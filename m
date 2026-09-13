Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65980360ED1;
	Sun, 13 Sep 2026 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789322506; cv=none; b=oQCdNPU/qn/j3mWyvxcldVgp0gygfKpMPRAKxRdQiPxT5VfaoWwIwg2KiedbTlxEjjhrBd4hXNJYGekjBSkv0O0ZaUIrLbWkq4O1hxtPSUOZkdTx52dhYS5G7Eu7hbgm3t50BvxIXQMjRBU++/wfrmNtIb6jxTj3GQwymb5UIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789322506; c=relaxed/simple;
	bh=XvyQ3HP8On5tuqNSTyJQZnEMyEmUL/+AeSkCO31YUNs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGAPZpJVbsTYgcrq7Z/X67zLbiEG0lYGKP1GGI5ZXmcILt9zKtjoKQtKgeFjWa6yaTvcEyZDlH05/BL34Q5urnQKzQlDzTbaOelfTbNb4hFEQFTFtOlssxgWGrATiodzfZWZO2HerxvR02ojbsL6TtUvWWKue8K/HipikQ13pu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x5oWJ-000000003RU-3bwy;
	Sun, 13 Sep 2026 18:01:39 +0000
Date: Sun, 13 Sep 2026 19:01:36 +0100
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
Subject: [PATCH net-next v15 3/6] driver core: add device_schedule_reprobe()
Message-ID: <9dc69bcb070cd955a831d709fe280f8d98f98a86.1789175618.git.daniel@makrotopia.org>
References: <cover.1789175618.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789175618.git.daniel@makrotopia.org>

Three in-tree drivers schedule a deferred re-probe of their own device
from a work item whose work function lives in module text: iwlwifi
(iwl_trans_schedule_reprobe(), firmware crash recovery when a lighter
restart is not sufficient), hci_h5 (h5_btrtl_resume(), RTL devices
lose their firmware state over suspend) and btintel_pcie (synchronous
device_reprobe() from its own reset work, with a hand-rolled locking
contract spanning several comments).

Two bug classes affect the hand-rolled implementations:

1. The work function ends with put_device(); kfree();
   module_put(THIS_MODULE); in module text. After the atomic decrement
   a concurrent rmmod can free the module text before the function
   epilogue has finished executing. This is exactly the race
   module_put_and_kthread_exit() exists to close for kthreads; there
   is no work-item equivalent.

2. There is no synchronization between the deferred device_reprobe()
   and device_shutdown() or a driver unbind. The drivers do not check
   any bound state before calling device_reprobe(), so a stale
   re-probe can undo an administrative unbind, and the detach half can
   run against a device whose ->shutdown() callback has already run.
   The core already blocks the attach half during shutdown
   (device_shutdown() calls device_block_probing() before any
   callback, and really_probe() honors defer_all_probes), but nothing
   blocks the detach half. For drivers which clear their drvdata in
   ->shutdown() so that a subsequent ->remove() becomes a no-op this
   escalates to use-after-free of driver state which other subsystem
   structures still reference.

Both classes disappear when the driver core owns the deferred work.
Add device_schedule_reprobe(), which schedules a detach and re-probe
of a device after a caller-specified delay:

- The work function is builtin text, so callers do not need to hold a
  module reference. If the driver module is unloaded before the work
  runs, driver_unregister() has already unbound the device, the bound
  driver no longer matches the driver recorded at scheduling time and
  the work does nothing.

- The recorded driver pointer is only ever compared, never
  dereferenced, so it may legitimately point to freed memory.

- The bound-state check and __device_release_driver() run under a
  single hold of the device lock and, where the bus needs it, the
  parent lock, the same lock dance device_release_driver_internal()
  uses. This closes the check-vs-detach TOCTOU that drivers cannot
  close themselves, because device_reprobe() takes the device lock
  internally. __device_release_driver() reports whether this call was
  the one to release the driver, so an unbind that wins the race while
  busy consumer links are being unbound is not followed by a re-attach.

- Both @dev and its parent are pinned for the lifetime of the work. The
  parent, whether it needs locking and the bound driver are recorded
  under the device lock, which device_del() takes before it drops @dev's
  reference to the parent. A device that was unregistered before the
  work runs may have outlived the module providing its bus type, so
  dev->bus is not read once the work is scheduled.

- The detach half is skipped while probing is blocked, which
  device_shutdown() does before its walk reaches any device. A re-probe
  firing during shutdown therefore leaves the device bound, and its
  ->shutdown() callback still runs.

- The work is queued on system_freezable_wq. A re-probe pending across
  system suspend therefore runs once the devices have resumed and
  probing is unblocked again, instead of detaching a device the PM core
  has already suspended or running concurrently with its late suspend
  callbacks, which the PM core invokes without the device lock. The
  attach half is plain device_attach(), which checks the dead flag, and
  it takes the parent lock on buses that set need_parent_lock,
  mirroring bus_rescan_devices_helper().

One pre-existing window remains: __device_release_driver()
transiently drops the locks while consumer device links are busy, so
for devices with busy consumers a ->shutdown() can still interleave
in the middle of the release. That window exists identically for
every unbind path in the kernel, sysfs unbind included, and is not
made worse by this helper.

Assisted-by: LLM
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
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

 drivers/base/dd.c      | 126 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/device.h |   2 +
 2 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f6525a7ee8c5..aa1f278d0ee2 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1315,7 +1315,7 @@ EXPORT_SYMBOL_GPL(driver_attach);
  * __device_release_driver() must be called with @dev lock held.
  * When called for a USB interface, @dev->parent lock must be held as well.
  */
-static void __device_release_driver(struct device *dev, struct device *parent)
+static bool __device_release_driver(struct device *dev, struct device *parent)
 {
 	struct device_driver *drv;
 
@@ -1336,7 +1336,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 			 */
 			if (dev->driver != drv) {
 				pm_runtime_put(dev);
-				return;
+				return false;
 			}
 		}
 
@@ -1359,7 +1359,10 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 		bus_notify(dev, BUS_NOTIFY_UNBOUND_DRIVER);
 		kobject_uevent(&dev->kobj, KOBJ_UNBIND);
+		return true;
 	}
+
+	return false;
 }
 
 void device_release_driver_internal(struct device *dev,
@@ -1436,3 +1439,122 @@ void driver_detach(const struct device_driver *drv)
 		put_device(dev);
 	}
 }
+
+struct device_reprobe {
+	struct delayed_work work;
+	struct device *dev;
+	struct device *parent;
+	const struct device_driver *drv;
+	bool parent_lock;
+};
+
+static void device_reprobe_work_fn(struct work_struct *work)
+{
+	struct device_reprobe *rp = container_of(work, struct device_reprobe,
+						 work.work);
+	struct device *parent = rp->parent;
+	struct device *dev = rp->dev;
+	bool detached = false;
+	int ret;
+
+	/*
+	 * A device unregistered before the work runs may have outlived the
+	 * module providing its bus type, so dev->bus is not read until the
+	 * device is known to be live.
+	 */
+	if (rp->parent_lock)
+		device_lock(parent);
+	device_lock(dev);
+	/*
+	 * rp->drv is only ever compared, never dereferenced: the driver it
+	 * points to may have been unregistered and freed by now.
+	 * device_shutdown() blocks probing before its walk reaches @dev.
+	 */
+	if (!defer_all_probes && !dev->p->dead && dev->driver == rp->drv)
+		detached = __device_release_driver(dev, parent);
+	device_unlock(dev);
+	if (rp->parent_lock)
+		device_unlock(parent);
+
+	if (detached) {
+		/*
+		 * device_attach() must run with the parent locked on buses
+		 * that require it, mirroring bus_rescan_devices_helper().
+		 */
+		if (rp->parent_lock)
+			device_lock(parent);
+		ret = device_attach(dev);
+		if (ret < 0 && ret != -EPROBE_DEFER)
+			dev_err_probe(dev, ret,
+				      "re-probe failed, device left unbound\n");
+		if (rp->parent_lock)
+			device_unlock(parent);
+	}
+
+	put_device(dev);
+	put_device(parent);
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
+ * scheduling time. In particular a device left unbound by an
+ * administrative unbind stays unbound.
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
+ * May only be called from process context, and not from @dev's own
+ * ->probe(), which is called with the device lock held.
+ *
+ * Returns: 0 on success, -EINVAL if @dev is not a registered device
+ * bound to a driver, -ENOMEM on allocation failure.
+ */
+int device_schedule_reprobe(struct device *dev, unsigned int delay_ms)
+{
+	struct device_reprobe *rp;
+	struct device *parent;
+
+	rp = kzalloc_obj(*rp);
+	if (!rp)
+		return -ENOMEM;
+
+	/* device_del() drops @dev's own reference to the parent. */
+	device_lock(dev);
+	parent = dev->parent;
+	if (!dev->bus || !dev->p || dev->p->dead ||
+	    !device_is_registered(dev) || !dev->driver) {
+		device_unlock(dev);
+		kfree(rp);
+		return -EINVAL;
+	}
+
+	rp->dev = get_device(dev);
+	rp->parent = get_device(parent);
+	rp->parent_lock = parent && dev->bus->need_parent_lock;
+	rp->drv = dev->driver;
+	device_unlock(dev);
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
