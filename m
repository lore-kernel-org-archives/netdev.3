Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B135439DBE4;
	Wed,  9 Sep 2026 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979627; cv=none; b=XA1qEe+1B6t7tfMu6F6hq89k5rY+pcxlpcqn6/V67tkZV4VP23b/75rwb8cB0gDozz8miWXeCE78XydMPPXfTeNPR/D2pktBe5NyTRdIirckwEI7YzkftLFcQLwjUN64bdurzLpIev2KrjjbI/Rz7Y3nQ+iEBSIUo4EWoNVzZew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979627; c=relaxed/simple;
	bh=U9tE2oKJTFRuqi0eV5f0bby2LAnn3+jF/4cdcLYztQQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aouCakYU9F08Xa2TDwPNzrFxxkg7Mq2ee8mO5fFPRjstaWTmkjx6dBmst+INwSNjNyIhXWZN1XjFhdsPJnFYa2eOHf/1waftyC+4ijvjNENFP8+k+zMYuxhe0dur/sAEYoY1ROfdKD2eUOeZgh1y/WGbh8iTinhZ39uzSgdy1jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x4NK0-00000000421-174O;
	Wed, 09 Sep 2026 18:47:00 +0000
Date: Wed, 9 Sep 2026 19:46:57 +0100
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
Subject: [PATCH net-next v14 3/6] driver core: add device_schedule_reprobe()
Message-ID: <88efc948074a871d043f386c2623bd4af89ff671.1788976064.git.daniel@makrotopia.org>
References: <cover.1788976064.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1788976064.git.daniel@makrotopia.org>

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

- Both @dev and its parent are pinned for the lifetime of the work, and
  whether the parent needs locking is recorded at scheduling time. An
  unregister of @dev drops @dev's reference to the parent, and a device
  that was unregistered before the work runs may have outlived the
  module providing its bus type, so neither dev->parent nor dev->bus is
  read before the device is found live under the lock.

- A new shutdown_done flag in struct device_private, set under the
  device lock once device_shutdown() reaches a device, suppresses the
  detach half during shutdown. It occupies a spare bit in an existing
  byte, mirroring how kill_device() sets the dead flag.

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

 drivers/base/base.h    |   5 ++
 drivers/base/core.c    |   3 ++
 drivers/base/dd.c      | 120 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/device.h |   2 +
 4 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index a5b7abc10ff0..6234e37de7e9 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -106,6 +106,10 @@ struct driver_private {
  * @dead: This device is currently either in the process of or has been
  *	  removed from the system. Any asynchronous events scheduled for this
  *	  device should exit without taking any action.
+ * @shutdown_done: Set once device_shutdown() has reached this device, under
+ *	  the device lock, before any shutdown callback runs. Read under the
+ *	  device lock. A deferred re-probe scheduled with
+ *	  device_schedule_reprobe() must not detach the device anymore.
  *
  * Nothing outside of the driver core should ever touch these fields.
  */
@@ -120,6 +124,7 @@ struct device_private {
 	char *deferred_probe_reason;
 	struct device *device;
 	u8 dead:1;
+	u8 shutdown_done:1;
 };
 #define to_device_private_parent(obj)	\
 	container_of(obj, struct device_private, knode_parent)
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4c0c373998a1..3dcd8a3c3aa5 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4910,6 +4910,9 @@ void device_shutdown(void)
 			device_lock(parent);
 		device_lock(dev);
 
+		if (dev->p)
+			dev->p->shutdown_done = true;
+
 		/* Don't allow any more runtime suspends */
 		pm_runtime_get_noresume(dev);
 		pm_runtime_barrier(dev);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f6525a7ee8c5..81a3433f726e 100644
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
@@ -1436,3 +1439,116 @@ void driver_detach(const struct device_driver *drv)
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
+	 */
+	if (!dev->p->dead && !dev->p->shutdown_done && dev->driver == rp->drv)
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
+		if (ret < 0)
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
+ * device has been removed, the system shutdown sequence has reached the
+ * device, or @dev is no longer bound to the driver that was bound at
+ * scheduling time. In particular an administrative unbind is never
+ * undone by a stale re-probe.
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
+ * May only be called from process context.
+ *
+ * Returns: 0 on success, -EINVAL if @dev is not a registered device
+ * bound to a driver, -ENOMEM on allocation failure.
+ */
+int device_schedule_reprobe(struct device *dev, unsigned int delay_ms)
+{
+	struct device_reprobe *rp;
+
+	if (!dev->bus || !dev->p || !device_is_registered(dev))
+		return -EINVAL;
+	if (!dev->driver)
+		return -EINVAL;
+
+	rp = kzalloc_obj(*rp);
+	if (!rp)
+		return -ENOMEM;
+
+	rp->dev = get_device(dev);
+	/*
+	 * Pin the parent too: the work locks it, and an unregister of @dev
+	 * would otherwise drop the last reference before the work runs.
+	 */
+	rp->parent = get_device(dev->parent);
+	rp->parent_lock = dev->parent && dev->bus->need_parent_lock;
+	rp->drv = READ_ONCE(dev->driver);
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
