Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139B3815FB;
	Wed, 23 Sep 2026 02:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130843; cv=none; b=G12IaklgZtyubQHGC7inBlwcY9mW8kGXLQmReFn5FVS4DluqPAAD/PgdhgP/qGwE8Nmr7j9VmVrk0ASjQgbtJk1A6gBAAKLl8GrxBlZ++TGVuZu/U/oQUuOpTsmeeXGXW4FC9dzM4qmP7247MO975YBZMksG9k2MopbsvTEUD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130843; c=relaxed/simple;
	bh=uZGz3QOyEneEXepZww9qWHC9X3NxJzI0McMUAq8o8Qc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ew65CSBip7THP9yk371x8WoxZgauyt/gjUCK8fOSKJPEOKAElOzhn42+NujVr3SkJqdQjt6G23t/ZuqAPFJI9F75/d9O5/YYV3FAorE5aEmPrjUpet2MEiEYOcPeGnqcNPFzadnCaAdmybwdvewi5ylv7nW5mvmrHoCuqTJnlmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x9Co1-0000000030a-0SL3;
	Wed, 23 Sep 2026 02:33:57 +0000
Date: Wed, 23 Sep 2026 03:33:54 +0100
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
Subject: [PATCH net-next v17 3/6] driver core: add device_schedule_reprobe()
Message-ID: <acb746142c5e9d06fd592db29872b55869735faf.1790130482.git.daniel@makrotopia.org>
References: <cover.1790130482.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790130482.git.daniel@makrotopia.org>

Drivers that need a deferred re-probe of their own device open-code a
work item in module text. iwlwifi (iwl_trans_schedule_reprobe(), for a
firmware crash a lighter restart cannot fix) and hci_h5
(h5_btrtl_resume(), RTL devices lose their firmware state over suspend)
both end that work function with put_device(); kfree();
module_put(THIS_MODULE);, where a concurrent rmmod can free the module
text the epilogue is still executing. Neither gates the re-probe on the
device still being bound to the driver that scheduled it, which a driver
cannot do from outside because device_reprobe() takes the device lock
internally.

Add device_schedule_reprobe(), which detaches and re-probes a device
after a caller-specified delay. The work function is built-in text, so a
caller needs no module reference. The binding is recorded as the driver
pointer plus a copy of its name: the pointer is only ever compared,
never dereferenced, and the name copy rejects a freed struct
device_driver address the allocator later hands to a different driver.
The first user is the mxl862xx devlink flash path added later in this
series.

Nothing is locked or validated in the caller's context, so the helper
may be called with the device lock held, as the PM callbacks, ->remove()
and ->shutdown() hold it. Buses that take the parent lock to bind are
refused with -EINVAL: that lock has to be taken before @dev's own, so
the parent would have to be recorded before either is held, where
device_move() can replace it without taking any device lock.
usb_bus_type is the only such bus and no caller needs it today.

The detach is skipped once probing is blocked, which device_shutdown()
and dpm_prepare() both set before they touch any device, and the work is
freezable so one pending across suspend runs after resume. Beyond that
gate this is device_reprobe() deferred and __device_release_driver() is
unchanged, so it carries device_reprobe()'s pre-existing limitations:
the detach and the re-attach are not one locked operation, so an
administrative unbind between them may be undone, and detaching a device
that has managed consumers unbinds them as any release does, so a
re-probe a concurrent device_shutdown() overtakes may run ->remove() in
place of ->shutdown(). None of this is specific to the helper.

Assisted-by: LLM
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
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
 drivers/base/dd.c      | 115 +++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |   2 +
 2 files changed, 117 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f6525a7ee8c5..a26a6b0eaef5 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1436,3 +1436,118 @@ void driver_detach(const struct device_driver *drv)
 		put_device(dev);
 	}
 }
+
+struct device_reprobe {
+	struct delayed_work work;
+	const struct device_driver *drv;
+	const char *drv_name;
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
+	 * rp->drv is only compared, never dereferenced: the driver it points
+	 * to may have been unregistered and freed. The saved name rejects a
+	 * freed address the allocator has since handed to another driver.
+	 */
+	if (!defer_all_probes && !dev->p->dead && dev->driver == rp->drv &&
+	    !strcmp(dev->driver->name, rp->drv_name)) {
+		__device_release_driver(dev, NULL);
+		detached = true;
+	}
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
+	kfree(rp->drv_name);
+	kfree(rp);
+}
+
+/**
+ * device_schedule_reprobe - schedule a deferred detach and re-probe
+ * @dev: device to detach and re-probe
+ * @delay_ms: delay in milliseconds before the re-probe runs
+ *
+ * Schedule a detach and re-probe of @dev after @delay_ms milliseconds,
+ * from built-in driver-core work rather than a driver-owned work item,
+ * so the bound driver may call it without pinning its own module. The
+ * binding is recorded as the driver pointer plus a copy of its name; the
+ * pointer is only ever compared, never dereferenced, and the name copy
+ * guards against a freed &struct device_driver address the allocator
+ * later hands to a different driver.
+ *
+ * The re-probe is skipped when the work runs if @dev has since been
+ * removed, is no longer bound, is bound to a different driver, or probing
+ * has been blocked for a system shutdown. The work is freezable, so one
+ * pending across system suspend runs once the system has resumed. A
+ * failed re-probe leaves @dev unbound, as a failed initial probe would.
+ *
+ * This is device_reprobe() deferred, and shares its limitations;
+ * __device_release_driver() is unchanged. The detach and the re-attach
+ * are not one locked operation, so an administrative unbind arriving
+ * between them may be undone, and the attach half runs the normal probe
+ * path with no shutdown re-check of its own. If @dev has managed
+ * consumers, detaching it unbinds them as any driver release does, so a
+ * re-probe a concurrent device_shutdown() overtakes may run ->remove()
+ * in place of ->shutdown(). None of this is specific to this helper.
+ *
+ * Buses that take the parent lock to bind (only usb_bus_type) are refused
+ * with -EINVAL: the parent would have to be recorded before either lock
+ * is held, where device_move() can replace it.
+ *
+ * Context: May sleep (allocates with %GFP_KERNEL). May be called from any
+ * process context, @dev's own device lock held included, but not from
+ * @dev's ->probe(), which the scheduled work would detach.
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
+	rp->drv_name = kstrdup(drv->name, GFP_KERNEL);
+	if (!rp->drv_name) {
+		kfree(rp);
+		return -ENOMEM;
+	}
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
