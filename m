Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D643BBFCE;
	Tue, 15 Sep 2026 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477796; cv=none; b=TJhT9YA4hw4f0eJRkqz1VMSEP3XNnN9rJNSf0IqIpQqD2GXy97j3mzov/9lgjs1gn7TqGfK3WLB44oVWPKkNl/jJVhzmdnedrIfrQDbOD8h/I3PRHG+SMxkB7DUZjBsUENDoW74dvm4kzaCXrcJmDdpCwy/UJy5hwLVQRwidpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477796; c=relaxed/simple;
	bh=ltKjkKmJu/im0SL+wLoMRQAfGHT4XuBvPXy5fFEYMV8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3ranTfoN85m1wFRgfs1JC1jMpcwV9jaJBLoAED7lny9zBzjMgH5EjmzRMc/acNfxj7TNfTnjAO34bwLn6I+g3QycvBlCcOabjBr6QYxQjCHtYssUR5ADrraNqJqkArTR2Am9vTJ9gkEP69QD6FIlP6l036Zd/N0BW9wE9G8ELU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x6Suz-000000000EA-3eyQ;
	Tue, 15 Sep 2026 13:09:49 +0000
Date: Tue, 15 Sep 2026 14:09:46 +0100
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
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH net-next v16 3/6] driver core: add device_schedule_reprobe()
Message-ID: <b8cfff498ef5662093062ea03015cb3ccb95957b.1789477568.git.daniel@makrotopia.org>
References: <cover.1789477568.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789477568.git.daniel@makrotopia.org>

Drivers that need a deferred re-probe of their own device open-code a
work item in module text. iwlwifi (iwl_trans_schedule_reprobe(), for a
firmware crash a lighter restart cannot fix) and hci_h5
(h5_btrtl_resume(), RTL devices lose their firmware state over suspend)
both end that work function with put_device(); kfree();
module_put(THIS_MODULE);, where a concurrent rmmod can free the module
text the epilogue is still executing. Neither checks any bound state
before calling device_reprobe(), and a driver cannot make that check
stick because device_reprobe() takes the device lock internally, so a
stale re-probe undoes an administrative unbind and the detach half runs
against a device whose ->shutdown() has already run.

Add device_schedule_reprobe(), which detaches and re-probes a device
after a caller-specified delay. The work function is built-in text and
the recorded driver pointer is only ever compared, never dereferenced,
so a caller needs no module reference. The bound-state check and
__device_release_driver() run under one hold of the device lock, and
__device_release_driver() now reports whether it was this call that
released the driver, so an unbind winning the race while busy consumer
links are unbound is not followed by a re-attach. The first user is the
mxl862xx devlink flash path added later in this series.

Nothing is locked or validated in the caller's context, so the helper
may be called with the device lock held, as the PM callbacks, ->remove()
and ->shutdown() hold it. Buses that take the parent lock to bind are
refused with -EINVAL: that lock has to be taken before @dev's own, so
the parent would have to be recorded before either is held, where
device_move() can replace it without taking any device lock.
usb_bus_type is the only such bus and no caller needs it today;
supporting one means deriving the parent inside the work and re-checking
it once both locks are held.

The detach is skipped once probing is blocked, which device_shutdown()
and dpm_prepare() both do before they touch any device. dpm_prepare()
leaves no window, its callers having frozen the freezable workqueues
first; device_shutdown() blocks probing only once
wait_for_device_probe() has returned, so a re-probe already past the
test completes its detach and the device runs ->remove() in place of
->shutdown(). __device_release_driver()
drops the device lock while busy consumer links are unbound, which would
let a ->shutdown() interleave in the middle of a release already under
way, so it now re-checks on re-acquisition and abandons the release. That
is offered as a flag, because only a caller free to leave the device
bound can take it: an administrative unbind has to complete, and
driver_detach() would spin on a device it never released. Past that loop
the lock is held until the driver is gone, so ->remove() cannot follow a
->shutdown() on the same device.

Assisted-by: LLM
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
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

 drivers/base/dd.c      | 111 +++++++++++++++++++++++++++++++++++++++--
 include/linux/device.h |   2 +
 2 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f6525a7ee8c5..f521ddefc4a8 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1314,8 +1314,12 @@ EXPORT_SYMBOL_GPL(driver_attach);
 /*
  * __device_release_driver() must be called with @dev lock held.
  * When called for a USB interface, @dev->parent lock must be held as well.
+ * @abort_if_blocked gives up the release instead when probing has been
+ * blocked while the locks were dropped; only a caller that may abandon
+ * the unbind altogether can ask for it.
  */
-static void __device_release_driver(struct device *dev, struct device *parent)
+static bool __device_release_driver(struct device *dev, struct device *parent,
+				    bool abort_if_blocked)
 {
 	struct device_driver *drv;
 
@@ -1334,9 +1338,10 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 			 * have released the driver successfully while this one
 			 * was waiting, so check for that.
 			 */
-			if (dev->driver != drv) {
+			if (dev->driver != drv ||
+			    (abort_if_blocked && defer_all_probes)) {
 				pm_runtime_put(dev);
-				return;
+				return false;
 			}
 		}
 
@@ -1359,7 +1364,10 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 		bus_notify(dev, BUS_NOTIFY_UNBOUND_DRIVER);
 		kobject_uevent(&dev->kobj, KOBJ_UNBIND);
+		return true;
 	}
+
+	return false;
 }
 
 void device_release_driver_internal(struct device *dev,
@@ -1369,7 +1377,7 @@ void device_release_driver_internal(struct device *dev,
 	__device_driver_lock(dev, parent);
 
 	if (!drv || drv == dev->driver)
-		__device_release_driver(dev, parent);
+		__device_release_driver(dev, parent, false);
 
 	__device_driver_unlock(dev, parent);
 }
@@ -1436,3 +1444,98 @@ void driver_detach(const struct device_driver *drv)
 		put_device(dev);
 	}
 }
+
+struct device_reprobe {
+	struct delayed_work work;
+	const struct device_driver *drv;
+	struct device *dev;
+};
+
+static void device_reprobe_work_fn(struct work_struct *work)
+{
+	struct device_reprobe *rp = container_of(work, struct device_reprobe,
+						 work.work);
+	struct device *dev = rp->dev;
+	bool detached = false;
+	int ret;
+
+	device_lock(dev);
+	/*
+	 * rp->drv is only ever compared, never dereferenced: the driver it
+	 * points to may have been unregistered and freed by now.
+	 * device_shutdown() blocks probing before its walk reaches @dev.
+	 */
+	if (!defer_all_probes && !dev->p->dead && dev->driver == rp->drv)
+		detached = __device_release_driver(dev, NULL, true);
+	device_unlock(dev);
+
+	if (detached) {
+		ret = device_attach(dev);
+		if (ret < 0 && ret != -EPROBE_DEFER)
+			dev_err_probe(dev, ret,
+				      "re-probe failed, device left unbound\n");
+	}
+
+	put_device(dev);
+	kfree(rp);
+}
+
+/**
+ * device_schedule_reprobe - schedule a deferred detach and re-probe
+ * @dev: device to detach and re-probe
+ * @delay_ms: delay in milliseconds before the re-probe runs
+ *
+ * Schedule a detach and re-probe of @dev after @delay_ms milliseconds.
+ * The re-probe is skipped if, by the time the scheduled work runs, the
+ * device has been removed, probing has been blocked for a system
+ * shutdown, or @dev is no longer bound to the driver that was bound at
+ * scheduling time.
+ *
+ * The work function is built-in text, so the bound driver may call this
+ * from its own code without holding a module reference. If the driver
+ * module is unloaded before the work runs, driver unregistration unbinds
+ * @dev first and the scheduled work does nothing.
+ *
+ * Multiple pending re-probes for the same device are individually safe;
+ * a caller that wants at most one pending re-probe must gate scheduling
+ * itself.
+ *
+ * The work is freezable: a re-probe pending across system suspend runs
+ * once the system has resumed.
+ *
+ * Nothing is locked in the caller's context, so this may be called from
+ * any process context, @dev's own device lock held included, but not
+ * from @dev's ->probe(), which the scheduled work would detach.
+ *
+ * Returns: 0 on success, -EINVAL if @dev is not a registered device
+ * bound to a driver or sits on a bus which takes the parent lock to
+ * bind, -ENOMEM on allocation failure.
+ */
+int device_schedule_reprobe(struct device *dev, unsigned int delay_ms)
+{
+	const struct device_driver *drv;
+	struct device_reprobe *rp;
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
+	rp->drv = drv;
+
+	INIT_DELAYED_WORK(&rp->work, device_reprobe_work_fn);
+	queue_delayed_work(system_freezable_wq, &rp->work,
+			   msecs_to_jiffies(delay_ms));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(device_schedule_reprobe);
diff --git a/include/linux/device.h b/include/linux/device.h
index aee79fd6b32b..7a9916950577 100644
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
2.55.0
