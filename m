Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C35D31E84F;
	Sat,  3 Oct 2026 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791042741; cv=none; b=eQVqzzUtm0p3UCZOvf6JjJp3aazA7fl2sF+ezdg4AHCxhw0xlfwE2U/CVZcwxgPkRw/EppW+4KN1v7oBmq4ytDVVqa1BwALNCYWnkEJ0UGsmt2TNS669H7uGyGmcnsbnku7UpZSlRc+9iEJhThY/OzLIjt2syMG5A2TIqW4n97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791042741; c=relaxed/simple;
	bh=J7F/S0S3/XEpDd8Dh0JylWzFaMMd24rg6kIjPCYo72k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAD7e6AOi6FsKkPgLJ/eRDFbPhq1eGpQnZ1UINORPbk4slnffdcutKCB4vHF6x540Er4pkqzorGb0Nskpyr7u/kWuRv2aBHRhK/6gKlX7PezFSQ0aIg+/BW+wi0DKzaZkI5i8cIfgPw8erKZZYMdf2ewjRfuf9O/4S2CbXncTdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xD221-000000001HK-3YoN;
	Sat, 03 Oct 2026 15:52:13 +0000
Date: Sat, 3 Oct 2026 16:52:10 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH net-next v19 3/6] driver core: add device_schedule_reprobe()
Message-ID: <ff5b5f2963a45a8e1877ad1006b026ce730b7d9d.1791035885.git.daniel@makrotopia.org>
References: <cover.1791035885.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791035885.git.daniel@makrotopia.org>

Drivers that need a deferred re-probe of their own device open-code a
work item in module text. iwlwifi (iwl_trans_schedule_reprobe(), for a
firmware crash a lighter restart cannot fix) and hci_h5
(h5_btrtl_resume(), RTL devices lose their firmware state over suspend)
both end that work function with put_device(); kfree();
module_put(THIS_MODULE);, where a concurrent rmmod can free the module
text the epilogue is still executing. Neither gates the re-probe on the
device still being bound to the driver that scheduled it, which a driver
cannot do from outside because device_reprobe() takes the device lock
internally. Their conversion is left to follow-up patches.

Add device_schedule_reprobe(), which detaches and re-probes a device
after a caller-specified delay. The work function is built-in text, so a
caller needs no module reference. The first user is the mxl862xx
devlink flash path added later in this series.

At most one request exists per device, recorded in struct
device_private from its scheduling until its work has released the
driver. The slot identifies the binding: device_del() and
device_unbind_cleanup() clear it, the latter after ->remove() has
returned and the driver pointer is cleared, so a request the driver
schedules from a context its ->remove() waits for is cancelled too, a
failed probe leaves none behind, and neither an unbind followed by a
rebind nor a module reload within the delay gets a re-probe it did not
ask for. A spinlock ties the slot to the queueing and cancelling of its
work, so a cancel either removes a pending work and frees the request
or leaves it to the running work, which frees itself once the slot is
no longer its own; the reference the request holds on the device goes
with it.

A failed re-probe leaves the device unbound, as a failed initial probe
would, and really_probe() logs it like one. The work does not judge the
outcome itself: a deferred retry is off the deferred-probe list while
it runs, so no read of the device state tells one from a failure.

No sleeping lock is taken in the caller's context, only the leaf
spinlock of the slot, and the checks are snapshots the work repeats
under the device lock, so the helper may be called with the device
lock held, as the prepare, suspend, resume and complete callbacks,
->remove() and ->shutdown() hold it. The caller is the bound driver, in
a context its ->remove() waits for. Buses that take the parent lock to
bind are refused with -EINVAL: that lock has to be taken before @dev's
own, so the parent would have to be recorded before either is held,
where device_move() can replace it without taking any device lock.
usb_bus_type is the only such bus and no caller needs it today.

While probing is blocked, which device_shutdown() and dpm_prepare() both
set before they touch any device, a request that fires is dropped once
a halt, power-off or restart has begun and otherwise re-arms itself
once a second, so one pending across a system suspend or a hibernation
restore runs once the system has resumed. Beyond
that gate this is device_reprobe() deferred, with the release path of
__device_release_driver() untouched, so it carries device_reprobe()'s
pre-existing limitations: the detach and the re-attach are not one
locked operation, so an administrative unbind between them may be
undone, and detaching a device that has managed consumers unbinds them
as any release does, so a re-probe a concurrent device_shutdown()
overtakes may run ->remove() after ->shutdown(). None of this is
specific to the helper.

Assisted-by: LLM
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v19:
 - keep one request per device in struct device_private, held until
   its work has released the driver, and cancel it from device_del()
   and device_unbind_cleanup(), so the reference it holds is dropped
   with the binding or by a work already running, a rebind or a module
   reload within the delay no longer gets a stale re-probe, and a
   request scheduled from a context ->remove() waits for, or from a
   probe that then fails, is cancelled with the binding; a spinlock
   pairs the slot with the queueing and cancelling of its work, and the
   slot identifies the binding, which makes the driver pointer and name
   copy redundant (found by Sashiko AI review and a local review)
 - re-arm while probing is blocked unless a halt, power-off or restart
   has begun, so a request pending across a hibernation restore
   survives it (found by a local review)
 - drop the error for a re-probe that left the device unbound: the probe
   path logs a failed probe itself, device_attach() reports a probe the
   driver deferred as 0, and a deferred retry is off the deferred-probe
   list while it runs, so no state read tells it from a failure (found
   by Sashiko AI review and a local review)
 - drop a request that fires once a shutdown has begun and re-arm one
   that fires during a suspend once a second, since a zero delay spun a
   kworker while probing was blocked (found by Sashiko AI review)
 - kernel-doc and commit message: a re-probe overtaken by a shutdown can
   run ->remove() after ->shutdown(), only the prepare, suspend, resume
   and complete PM callbacks hold the device lock, a request from
   ->probe() runs once the probe has returned, and the error is also
   withheld for a device bound or gone after all (found by Sashiko AI
   review and a local review)
v18:
 - re-arm the work while probing is blocked instead of dropping the
   request: dpm_prepare() blocks probing as well, and a kexec jump or a
   kernel without the suspend freezer reaches that window with the
   workqueue running, which lost the request for good (found by Sashiko
   AI review)
 - log an error for every unbound outcome of device_attach() except a
   deferred probe: a failed probe comes back as 0, which the check for a
   negative value missed (found by Sashiko AI review)
 - kernel-doc: the caller is the bound driver in a context its ->remove()
   waits for, and a rebind of the same driver within the delay still
   gets the re-probe (found by Sashiko AI review)
 - commit message: the caller's checks are unlocked snapshots, only the
   stored driver pointer is never dereferenced, and the drivers named as
   motivation are converted later (found by Sashiko AI review)
v17:
 - drop the abort_if_blocked flag and the bool return of
   __device_release_driver(), leaving that function unchanged: the flag
   left the device-links state half torn down when it fired and did not
   cover the consumers unbound in the same window, so the shutdown-vs-
   release window it targeted is documented as pre-existing to every
   unbind path instead (found by Sashiko AI review)
 - record the bound driver's name beside the pointer and compare both,
   so a freed struct device_driver address reused by another driver is
   not mistaken for the original binding (found by Sashiko AI review)
 - kernel-doc: add a Context line and state the pre-existing limitations
   shared with device_reprobe() (found by Sashiko AI review)
v16:
 - commit message: device_shutdown() blocks probing only once
   wait_for_device_probe() has returned, so a re-probe already past the
   test detaches the device instead of leaving it bound for its
   ->shutdown()
 - take no lock in the caller's context and drop the parent snapshot,
   refusing buses that need the parent lock instead: the caller-context
   device lock inverted against the devlink instance lock on the flash
   path and against a synchronous work cancel on the rescue path, and a
   pinned parent can be freed by device_move() (found by Sashiko AI
   review)
 - abandon the release when probing is blocked while the device links
   loop has the locks dropped, rather than calling that window
   pre-existing: a deferred re-probe is the one unbind that may be
   abandoned, so it is the one that can close it (found by Sashiko AI
   review)
 - commit message: describe what this patch changes rather than bugs in
   drivers it does not convert, and name the first user (found by
   Sashiko AI review)
 - kernel-doc: drop the promise that an administrative unbind always
   wins, which unbind_store() does not guarantee (found by Sashiko AI
   review)
v15:
 - skip the detach while probing is blocked instead of adding a
   per-device shutdown_done flag: device_shutdown() blocks probing
   before its walk starts, so the flag left a window where the work
   detached a device that then neither re-attached nor got its
   ->shutdown() call (found by Sashiko AI review)
 - validate the device and snapshot the parent, its locking requirement
   and the bound driver under the device lock, so an unregister racing
   the allocation can neither leave a freed parent pinned nor pair a
   NULL parent with a request to lock it (found by Sashiko AI review)
 - keep -EPROBE_DEFER out of the re-probe error path, where
   dev_err_probe() would record the message as the device's deferred
   probe reason (found by Sashiko AI review)
 - kernel-doc: a stale re-probe leaves an unbound device unbound, which
   an unbind followed by a rebind within the delay does not (found by
   Sashiko AI review)
v14: no changes
v13:
 - queue the work on system_freezable_wq, so a re-probe pending across
   system suspend can neither detach a device the PM core has suspended
   nor race its late suspend callbacks; it runs after resume instead
   (found by Sashiko AI review)
 - record at scheduling time whether the parent needs locking, instead
   of reading dev->bus in the work, which may be gone with its module
   once the device has been unregistered (found by Sashiko AI review)
 - let __device_release_driver() report whether it released the driver,
   so an administrative unbind that wins the race inside the device
   links loop is not undone by the re-attach (found by Sashiko AI
   review)
 - use dev_err_probe() for the re-probe error path, so a re-probe
   deferred at resume no longer logs a spurious error (Hans de Goede,
   on the standalone posting of this helper)
 - describe the parent pinning and locking in the commit message, as in
   the standalone posting

v12:
 - pin the parent device across the deferred work; a reference on the
   child alone left device_reprobe_work_fn() dereferencing a freed
   dev->parent under __device_driver_lock() when the device was
   unregistered before the work ran (found by Sashiko AI review)
 - take the parent lock across device_attach() on buses that require
   it, matching bus_rescan_devices_helper() (found by Sashiko AI review)

v11: new patch: add device_schedule_reprobe() to the driver core (posted
     earlier as an RFC) so mxl862xx can schedule its post-flash and
     post-drain re-probe through the core instead of open-coding a work
     item
---
 drivers/base/base.h    |   5 ++
 drivers/base/core.c    |   1 +
 drivers/base/dd.c      | 172 +++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |   2 +
 4 files changed, 180 insertions(+)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index a5b7abc10ff02..e85a84129eb48 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -106,6 +106,9 @@ struct driver_private {
  * @dead: This device is currently either in the process of or has been
  *	  removed from the system. Any asynchronous events scheduled for this
  *	  device should exit without taking any action.
+ * @reprobe: request scheduled with device_schedule_reprobe(), held until
+ *	     its work has released the driver; cancelled when the device is
+ *	     deleted or the binding that scheduled it ends
  *
  * Nothing outside of the driver core should ever touch these fields.
  */
@@ -119,6 +122,7 @@ struct device_private {
 	const struct device_driver *async_driver;
 	char *deferred_probe_reason;
 	struct device *device;
+	struct device_reprobe *reprobe;
 	u8 dead:1;
 };
 #define to_device_private_parent(obj)	\
@@ -241,6 +245,7 @@ void devres_for_each_res(struct device *dev, dr_release_t release,
 int devres_release_all(struct device *dev);
 void device_block_probing(void);
 void device_unblock_probing(void);
+void device_reprobe_cancel(struct device *dev);
 void deferred_probe_extend_timeout(void);
 void driver_deferred_probe_trigger(void);
 const char *device_get_devnode(const struct device *dev, umode_t *mode,
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4c0c373998a19..bcd0f821f8802 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3927,6 +3927,7 @@ void device_del(struct device *dev)
 	device_lock(dev);
 	kill_device(dev);
 	device_unlock(dev);
+	device_reprobe_cancel(dev);
 
 	if (dev->fwnode && dev->fwnode->dev == dev)
 		dev->fwnode->dev = NULL;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f6525a7ee8c54..21973cf0f1a41 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -599,6 +599,7 @@ static void device_unbind_cleanup(struct device *dev)
 	kfree(dev->dma_range_map);
 	dev->dma_range_map = NULL;
 	device_set_driver(dev, NULL);
+	device_reprobe_cancel(dev);
 	dev_set_drvdata(dev, NULL);
 	dev_pm_domain_detach(dev, dev->power.detach_power_off);
 	if (dev->pm_domain && dev->pm_domain->dismiss)
@@ -1436,3 +1437,174 @@ void driver_detach(const struct device_driver *drv)
 		put_device(dev);
 	}
 }
+
+struct device_reprobe {
+	struct delayed_work work;
+	struct device *dev;
+};
+
+/* Retry interval while probing is blocked; the caller's delay may be 0. */
+#define DEVICE_REPROBE_BLOCKED_RETRY	HZ
+
+/* Ties the slot in struct device_private to the queueing of its work. */
+static DEFINE_SPINLOCK(device_reprobe_lock);
+
+static void device_reprobe_free(struct device_reprobe *rp)
+{
+	put_device(rp->dev);
+	kfree(rp);
+}
+
+/*
+ * The slot holds a request from its scheduling until its work has released
+ * the driver. A pending work is freed here; a running one finds the slot no
+ * longer its own and frees itself.
+ */
+void device_reprobe_cancel(struct device *dev)
+{
+	struct device_reprobe *rp;
+	bool pending = false;
+
+	if (!dev->p)
+		return;
+	spin_lock(&device_reprobe_lock);
+	rp = dev->p->reprobe;
+	WRITE_ONCE(dev->p->reprobe, NULL);
+	if (rp)
+		pending = cancel_delayed_work(&rp->work);
+	spin_unlock(&device_reprobe_lock);
+	if (pending)
+		device_reprobe_free(rp);
+}
+
+static void device_reprobe_work_fn(struct work_struct *work)
+{
+	struct device_reprobe *rp = container_of(work, struct device_reprobe,
+						 work.work);
+	struct device *dev = rp->dev;
+	bool rearm;
+	int ret;
+
+	device_lock(dev);
+	/* The slot still holding rp means the binding that scheduled it does. */
+	if (dev->p->dead || READ_ONCE(dev->p->reprobe) != rp) {
+		device_unlock(dev);
+		goto out;
+	}
+	if (defer_all_probes) {
+		device_unlock(dev);
+		spin_lock(&device_reprobe_lock);
+		rearm = dev->p->reprobe == rp &&
+			(system_state < SYSTEM_HALT ||
+			 system_state == SYSTEM_SUSPEND) &&
+			queue_delayed_work(system_freezable_wq, &rp->work,
+					   DEVICE_REPROBE_BLOCKED_RETRY);
+		spin_unlock(&device_reprobe_lock);
+		if (rearm)
+			return;
+		goto out;
+	}
+	/* Releasing the driver clears the slot, which was this request. */
+	__device_release_driver(dev, NULL);
+	device_unlock(dev);
+
+	/* A failed probe is logged by the probe path, as for a first probe. */
+	ret = device_attach(dev);
+	dev_dbg(dev, "re-probe: device_attach() returned %d\n", ret);
+out:
+	spin_lock(&device_reprobe_lock);
+	if (dev->p->reprobe == rp)
+		WRITE_ONCE(dev->p->reprobe, NULL);
+	spin_unlock(&device_reprobe_lock);
+	device_reprobe_free(rp);
+}
+
+/**
+ * device_schedule_reprobe - schedule a deferred detach and re-probe
+ * @dev: device to detach and re-probe
+ * @delay_ms: delay in milliseconds before the re-probe runs
+ *
+ * Schedule a detach and re-probe of @dev after @delay_ms milliseconds,
+ * from built-in driver-core work rather than a driver-owned work item,
+ * so the bound driver may call it without pinning its own module.
+ *
+ * At most one request exists per device, from its scheduling until its
+ * work has released the driver, and the request identifies the binding
+ * that scheduled it. It is cancelled when @dev is deleted or when that
+ * binding ends, whether by a release or by a failed probe, so neither an
+ * unbind followed by a rebind nor a module reload within the delay gets a
+ * re-probe it did not ask for; its reference on @dev is dropped with it,
+ * or once a work already running has finished. A request that fires
+ * while probing is blocked for a system suspend or a hibernation restore
+ * re-arms itself every second and runs once the system has resumed; one
+ * that fires while probing is blocked for a halt, power-off or restart is
+ * dropped. A failed re-probe leaves @dev unbound, as a failed initial
+ * probe would, and is logged by the probe path like one.
+ *
+ * This is device_reprobe() deferred, and shares its limitations; the
+ * release path of __device_release_driver() is untouched. The detach and
+ * the re-attach are not one locked operation, so an administrative unbind
+ * arriving between them may be undone. If @dev has managed consumers,
+ * detaching it unbinds them as any driver release does, so a re-probe a
+ * concurrent device_shutdown() overtakes may run ->remove() after
+ * ->shutdown(). None of this is specific to this helper.
+ *
+ * Buses that take the parent lock to bind (only usb_bus_type) are refused
+ * with -EINVAL: the parent would have to be recorded before either lock
+ * is held, where device_move() can replace it.
+ *
+ * Context: May sleep (allocates with %GFP_KERNEL). Must be called by the
+ * driver bound to @dev, from a process context its ->remove() waits for,
+ * so that the binding outlives the call; @dev's own device lock may be
+ * held. A request from ->probe() runs once the probe has returned and is
+ * cancelled if the probe fails.
+ *
+ * Returns: 0 on success, -EINVAL if @dev is not a registered device
+ * bound to a driver or sits on a bus which takes the parent lock to
+ * bind, -EBUSY if a re-probe of @dev is pending or has not yet released
+ * the driver, -ENOMEM on allocation failure.
+ */
+int device_schedule_reprobe(struct device *dev, unsigned int delay_ms)
+{
+	const struct device_driver *drv;
+	struct device_reprobe *rp;
+	int ret = 0;
+
+	drv = READ_ONCE(dev->driver);
+	/*
+	 * A bus taking the parent lock would need @dev's parent pinned until
+	 * the work runs, which device_move() can invalidate.
+	 */
+	if (!drv || !dev->bus || dev->bus->need_parent_lock || !dev->p ||
+	    dev->p->dead || !device_is_registered(dev))
+		return -EINVAL;
+
+	rp = kzalloc_obj(*rp);
+	if (!rp)
+		return -ENOMEM;
+
+	rp->dev = get_device(dev);
+	INIT_DELAYED_WORK(&rp->work, device_reprobe_work_fn);
+
+	/*
+	 * A release or deletion that got here first has cleared the driver or
+	 * set dead before cancelling, so a request published after its cancel
+	 * is refused here; one published before is cancelled by it.
+	 */
+	spin_lock(&device_reprobe_lock);
+	if (dev->p->reprobe)
+		ret = -EBUSY;
+	else if (dev->p->dead || READ_ONCE(dev->driver) != drv)
+		ret = -EINVAL;
+	else
+		WRITE_ONCE(dev->p->reprobe, rp);
+	if (!ret)
+		queue_delayed_work(system_freezable_wq, &rp->work,
+				   msecs_to_jiffies(delay_ms));
+	spin_unlock(&device_reprobe_lock);
+	if (ret)
+		device_reprobe_free(rp);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(device_schedule_reprobe);
diff --git a/include/linux/device.h b/include/linux/device.h
index aee79fd6b32b4..7a99169505772 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1314,6 +1314,8 @@ int  __must_check device_attach(struct device *dev);
 int __must_check driver_attach(const struct device_driver *drv);
 void device_initial_probe(struct device *dev);
 int __must_check device_reprobe(struct device *dev);
+int __must_check device_schedule_reprobe(struct device *dev,
+					 unsigned int delay_ms);
 
 bool device_is_bound(struct device *dev);
 
-- 
2.56.0
