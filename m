Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7819125DB0D;
	Sat, 12 Sep 2026 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789172938; cv=none; b=LJqpa4ZY3otmqr5O/Ug9EitNtz7ys0mZh1TpyCt6Ok8cJ/XLf02eofOyIfrHh9rBLTQKgq/FiO/WncVpLqna/14d4Xby3J/NkcNi7KpP3YGALMil8KaYQXpUZgBEdiUkimo5iVGRMC2DXDs8RZB1zdEuLTRa+cWv0xHEEnZDQIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789172938; c=relaxed/simple;
	bh=66bztnUPANIKM3GoZrL92tIV4OfkOWM0ng2b67LvDqo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q5HF1ACs9EP+zbv7PfTXwmNmMlMSyPYOODRRHErcGhdXxWE77+qpCupCSo9vf3+Q/aD2oAsZd1PNaLeH6fijedSmSH+HSxdNEnZElPWOIXq/XjdZw0VfU7BAQjApmb945+c9RBLWVKPNwa4/fNiDHptN+2H39dCWFBVGx4RJu5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQZ+n7An; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQZ+n7An"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256121F00893;
	Sat, 12 Sep 2026 00:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789172936;
	bh=7CyK2LnRKJzzXqOaPiKnWWQUHGiqEFH5AJsjV3xCGUg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IQZ+n7AnQd/36iokUFFuXiF1lwIx0RVslvpRPuHACtllIStOXaUi4c+v4grD1ihGz
	 +vd0t6Wx5gj2yAj13dUbI56eGXBLV+IvAsXZszDOUSerGBXTLK5NpQKxPfTZktx4qm
	 ujXaMY7sIMR3cmsojMJM+1WDG9NZQntT9i1U7PM/XHy4MlXWGWh5TgGGU99BAcI42Q
	 UfXYMszrH2i1bXxtFfQQ2DAih2SmP+ZVksB3VxvCOx5lsG2g/LGDAY1hchAel3lBqj
	 Qauz6E4pxySZjpv5R2eX+vWjuPa1IDUKtus2G7pL339gmakqpds4q2/3jLlTHA9hsh
	 K/nruc872Ct+g==
Subject:
 Re: [PATCH net-next v14 3/6] driver core: add device_schedule_reprobe()
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Sat, 12 Sep 2026 00:28:54 +0000
Message-ID: <178917293473.219967.3333541093262308@kernel.org>
In-Reply-To: =?utf-8?q?=3C88efc948074a871d043f386c2623bd4af89ff671=2E1788976?=
 =?utf-8?q?064=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3C88efc948074a871d043f386c2623bd4af89ff671=2E17889760?=
 =?utf-8?q?64=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 3

- [Medium] The new shutdown guard is per-device and set lazily:
  device_shutdown() (drivers/base/core.c:4913-4914) sets…
- [Medium] device_schedule_reprobe() validates the device (dev->bus,
  dev->p, device_is_registered(), dev->driver) at dd.c:1531-1534 and…
- [Medium] The shutdown_done test that is supposed to suppress the detach
  half is evaluated once (dd.c:1472) before __device_release_driver()…
- [Low] Commit message framing vs. what the patch does: the message
  devotes most of its length to two concrete bug classes in three named…
- [Low] device_reprobe_work_fn() reports every negative device_attach()
  return with dev_err_probe(dev, ret, "re-probe failed, device left…
- [Low] device_reprobe_work_fn() decides whether to forcibly detach a
  device solely by comparing dev->driver against the raw pointer value…

--

driver core: add device_schedule_reprobe()

This adds a driver-core helper that schedules a delayed detach and
re-probe of a device on system_freezable_wq, pinning the device and its
parent and recording the bound driver pointer so a stale re-probe does
nothing.  It also adds a shutdown_done flag to struct device_private,
set by device_shutdown() under the device lock, and makes
__device_release_driver() return whether it was the caller that released
the driver.

A few questions below.

    Both classes disappear when the driver core owns the deferred work.
    Add device_schedule_reprobe(), which schedules a detach and re-probe
    of a device after a caller-specified delay:

[Severity: Low]
This isn't a bug, but could the message say more plainly that the three
drivers it describes are not converted here or later in this series?

At the end of the series, iwl_trans_reprobe_wk() in
drivers/net/wireless/intel/iwlwifi/iwl-trans.c and
h5_btrtl_reprobe_worker() in drivers/bluetooth/hci_h5.c still end with:

	if (device_reprobe(reprobe->dev))
		dev_err(reprobe->dev, "reprobe failed!\n");
	put_device(reprobe->dev);
	kfree(reprobe);
	module_put(THIS_MODULE);

with no bound-state check, and btintel_pcie is unchanged, so both bug
classes are still present in-tree.  The helper does gain in-tree callers
in this series (two call sites in drivers/net/dsa/mxl862xx/mxl862xx-fw.c),
just not in the three motivating drivers.

> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index a5b7abc10ff02..6234e37de7e99 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -106,6 +106,10 @@ struct driver_private {
>   * @dead: This device is currently either in the process of or has been
>   *	  removed from the system. Any asynchronous events scheduled for this
>   *	  device should exit without taking any action.
> + * @shutdown_done: Set once device_shutdown() has reached this device, under
> + *	  the device lock, before any shutdown callback runs. Read under the
> + *	  device lock. A deferred re-probe scheduled with
> + *	  device_schedule_reprobe() must not detach the device anymore.
>   *
>   * Nothing outside of the driver core should ever touch these fields.
>   */

[ ... ]

> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4c0c373998a19..3dcd8a3c3aa55 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4910,6 +4910,9 @@ void device_shutdown(void)
>  			device_lock(parent);
>  		device_lock(dev);
>  
> +		if (dev->p)
> +			dev->p->shutdown_done = true;
> +

[Severity: Medium]
This flag is set only when the reverse-order walk reaches each device, so
it means "this device has been reached", not "shutdown is in progress".
What happens when a scheduled re-probe fires after device_shutdown() has
started but before the walk reaches @dev?

The guard in device_reprobe_work_fn() sees dead == false and
shutdown_done == false, so the detach half runs:

	__device_release_driver() -> device_remove() -> drv->remove()

at a point where every device registered after @dev (children, later
probing suppliers) already had bus->shutdown()/driver->shutdown() run.

The re-attach that follows cannot succeed either, because
device_shutdown() calls device_block_probing() before the walk and
really_probe() then returns -EPROBE_DEFER:

	if (defer_all_probes) {
		...
		return -EPROBE_DEFER;
	}

device_unblock_probing() is only reached from dpm_complete(), never on the
shutdown path, so the device stays unbound.

And when the walk finally reaches @dev, this test in device_shutdown():

	} else if (dev->driver && dev->driver->shutdown) {

is false, so the driver's ->shutdown() is skipped for that device.  Would
a global condition (probing blocked, or system_state) be a better guard
here than a per-device flag?

>  		/* Don't allow any more runtime suspends */
>  		pm_runtime_get_noresume(dev);
>  		pm_runtime_barrier(dev);

> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index f6525a7ee8c54..81a3433f726e8 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c

[ ... ]

> @@ -1336,7 +1336,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>  			 */
>  			if (dev->driver != drv) {
>  				pm_runtime_put(dev);
> -				return;
> +				return false;
>  			}
>  		}

[Severity: Medium]
The commit message mentions this window ("One pre-existing window
remains: __device_release_driver() transiently drops the locks while
consumer device links are busy").  Since the new caller tests
shutdown_done only once, before the call, this loop revalidates only
dev->driver after retaking the locks:

	while (device_links_busy(dev)) {
		__device_driver_unlock(dev, parent);
		device_links_unbind_consumers(dev);
		__device_driver_lock(dev, parent);
		if (dev->driver != drv) {
			pm_runtime_put(dev);
			return false;
		}
	}

In that window device_shutdown() can take both locks, set shutdown_done
and run ->shutdown(), after which the work continues into device_remove()
and ->remove() runs after ->shutdown().  Would re-testing
dev->p->shutdown_done right after __device_driver_lock() close this for
the new helper?

[ ... ]

> @@ -1436,3 +1439,116 @@ void driver_detach(const struct device_driver *drv)
>  		put_device(dev);
>  	}
>  }
> +
> +struct device_reprobe {
> +	struct delayed_work work;
> +	struct device *dev;
> +	struct device *parent;
> +	const struct device_driver *drv;
> +	bool parent_lock;
> +};
> +
> +static void device_reprobe_work_fn(struct work_struct *work)
> +{
> +	struct device_reprobe *rp = container_of(work, struct device_reprobe,
> +						 work.work);
> +	struct device *parent = rp->parent;
> +	struct device *dev = rp->dev;
> +	bool detached = false;
> +	int ret;
> +
> +	/*
> +	 * A device unregistered before the work runs may have outlived the
> +	 * module providing its bus type, so dev->bus is not read until the
> +	 * device is known to be live.
> +	 */
> +	if (rp->parent_lock)
> +		device_lock(parent);
> +	device_lock(dev);
> +	/*
> +	 * rp->drv is only ever compared, never dereferenced: the driver it
> +	 * points to may have been unregistered and freed by now.
> +	 */
> +	if (!dev->p->dead && !dev->p->shutdown_done && dev->driver == rp->drv)
> +		detached = __device_release_driver(dev, parent);
> +	device_unlock(dev);
> +	if (rp->parent_lock)
> +		device_unlock(parent);
> +
> +	if (detached) {
> +		/*
> +		 * device_attach() must run with the parent locked on buses
> +		 * that require it, mirroring bus_rescan_devices_helper().
> +		 */
> +		if (rp->parent_lock)
> +			device_lock(parent);
> +		ret = device_attach(dev);
> +		if (ret < 0)
> +			dev_err_probe(dev, ret,
> +				      "re-probe failed, device left unbound\n");

[Severity: Low]
For ret == -EPROBE_DEFER, dev_err_probe() does more than pick a log
level.  __dev_probe_failed() in drivers/base/core.c does:

	case -EPROBE_DEFER:
		device_set_deferred_probe_reason(dev, &vaf);
		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);

so this string is stored in dev->p->deferred_probe_reason, which
drivers/base/base.h documents as the message retrieved via debugfs, and
any reason recorded earlier by the driver's own probe is overwritten.

-EPROBE_DEFER is reachable here: really_probe() returns it while
defer_all_probes is set, and __device_attach_driver()/__device_attach()
pass it back unchanged.  In that case /sys/kernel/debug/devices_deferred
reports "re-probe failed, device left unbound" for a device that is
queued for a retry.  Should the -EPROBE_DEFER case be handled separately
from a real failure?

> +		if (rp->parent_lock)
> +			device_unlock(parent);
> +	}
> +
> +	put_device(dev);
> +	put_device(parent);
> +	kfree(rp);
> +}
> +

[ ... ]

> + * scheduling time. In particular an administrative unbind is never
> + * undone by a stale re-probe.

[ ... ]

> +int device_schedule_reprobe(struct device *dev, unsigned int delay_ms)
> +{
> +	struct device_reprobe *rp;
> +
> +	if (!dev->bus || !dev->p || !device_is_registered(dev))
> +		return -EINVAL;
> +	if (!dev->driver)
> +		return -EINVAL;
> +
> +	rp = kzalloc_obj(*rp);
> +	if (!rp)
> +		return -ENOMEM;
> +
> +	rp->dev = get_device(dev);
> +	/*
> +	 * Pin the parent too: the work locks it, and an unregister of @dev
> +	 * would otherwise drop the last reference before the work runs.
> +	 */
> +	rp->parent = get_device(dev->parent);
> +	rp->parent_lock = dev->parent && dev->bus->need_parent_lock;

[Severity: Medium]
These reads happen without the device lock, and after a kzalloc_obj()
that can sleep, so the checks above them may already be stale.

device_del() takes its own copy of dev->parent at entry, unbinds the
driver, calls kobject_del() (which clears the only thing
device_is_registered() tests) and ends with:

	kobject_del(&dev->kobj);
	cleanup_glue_dir(dev, glue_dir);
	memalloc_noio_restore(noio_flag);
	put_device(parent);

dev->parent itself is never cleared.  Can a caller that passed the checks
and then slept in the allocation reach get_device(dev->parent) after that
final put_device(parent) dropped the last reference, i.e. kobject_get() on
a freed struct device, followed later by device_lock(parent) and
put_device(parent) in the work?

Separately, rp->parent and rp->parent_lock come from two independent
reads of dev->parent, and device_move() assigns it without the device
lock:

	old_parent = dev->parent;
	dev->parent = new_parent;

so can rp->parent end up NULL while rp->parent_lock is true, leaving
device_reprobe_work_fn() calling device_lock(NULL)?

Would re-validating and snapshotting parent/parent_lock/driver under
device_lock(dev), checking dev->p->dead (which kill_device() sets under
that lock at the start of device_del(), before its put_device(parent)),
avoid both cases?

> +	rp->drv = READ_ONCE(dev->driver);

[Severity: Low]
Is a raw pointer value enough to identify the binding that asked for the
re-probe?

Within delay_ms, an unbind followed by a bind of the same driver:

	echo dev > /sys/bus/.../unbind
	echo dev > /sys/bus/.../bind

restores dev->driver == rp->drv, so the check in
device_reprobe_work_fn() matches and the stale work runs a detach and
re-attach on a binding that never requested one.  That also narrows the
kernel-doc claim above, "an administrative unbind is never undone by a
stale re-probe": a plain unbind is honoured, an unbind plus rebind is
not.

And once the original module is unloaded, can another module's static
struct device_driver end up at the same address and make the comparison
succeed for an unrelated driver?  Would a generation counter, or a
recorded driver name, be a more stable token here?

> +	INIT_DELAYED_WORK(&rp->work, device_reprobe_work_fn);
> +	queue_delayed_work(system_freezable_wq, &rp->work,
> +			   msecs_to_jiffies(delay_ms));
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(device_schedule_reprobe);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788976064.git.daniel%40makrotopia.org
