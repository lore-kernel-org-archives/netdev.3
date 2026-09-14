Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A21F383C8F;
	Mon, 14 Sep 2026 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789410899; cv=none; b=XN6pWYzpVP9sJSmvCEOLuKAu8PuwBZV9NTGQZ7lCTAFvntC3+zu3IxSyx2lMOfiUp5ey/wQPB3TXRTZxGGfS7z68obRrT+A8haAa8Rl/q626RKMRHtEdDr2U0X2h3+RPQR7MJ6qH0Fq2JuIOz2I5ekxEVnUQyeSc99vECgotjOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789410899; c=relaxed/simple;
	bh=3lIXPtDUgBXRidsf49KK0oHbEjfSUCrSXk7ZgvF4kIY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hbRF+M8dOndrxwZ0fahqmr79uBJKISOVk8yaDwdXxQ7AEz12WDVG7fZd2mCPTb8A+1Mu0ts69eCK+KlRaU0mrMF6QD5bJHDbmHkGGJqIPo0GGlG+mQSF5s3OHVKAa98Ey+tMsR39wvHjXeW62lCiAlIDbtuAuAsE8AWegA1KXIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAxcNaWe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAxcNaWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCDA1F000FF;
	Mon, 14 Sep 2026 18:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789410895;
	bh=fT9VbBQtyj7Ran4uSvsCEacPj44k52lVpIGpJDb2jeU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VAxcNaWeNvyPyNFhW32Y/QqV11W5Hozjb9AglAQpjUZlbpiNlk+12giJGgg5cAXbi
	 kXSJA4mFxCSuqJXRewPbJWdboSP7HErNKNH0vbzLXgzfQy7Njiy8cnkDxbPLOlslQ/
	 JSdJA/R6i3zG4V91Y6QrNMpiTnNmO2xMCk0Xp/2AS792ROnRDhy4rX/MAdNeWvCbRQ
	 idgSXeOed55SkafoM6pdMWwV6dJf8ib/QQ2zTnm899uL3Xvy7EQNNrArM1LNyT/YIX
	 EmLq5Q6i40RphacFGnIHUtubqv601PMfeSe1yg1jO0zhGGMwli7ZWxVuzWLmu4MggM
	 PCy6mpTtiuSQg==
Subject:
 Re: [PATCH net-next v15 3/6] driver core: add device_schedule_reprobe()
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Mon, 14 Sep 2026 18:34:53 +0000
Message-ID: <178941089370.22033.284426349094277915@kernel.org>
In-Reply-To: =?utf-8?q?=3C9dc69bcb070cd955a831d709fe280f8d98f98a86=2E1789175?=
 =?utf-8?q?618=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3C9dc69bcb070cd955a831d709fe280f8d98f98a86=2E17891756?=
 =?utf-8?q?18=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 4 · Low: 2

- [High] The '!defer_all_probes' test in device_reprobe_work_fn()
  (drivers/base/dd.c:1473) does not serialize the deferred detach…
- [Medium] The commit message justifies the new helper entirely with live
  bugs in three named in-tree drivers (iwlwifi iwl_trans_reprobe_wk(),…
- [Medium] device_schedule_reprobe() acquires device_lock(dev)
  synchronously in the caller's context (drivers/base/dd.c:1539) to…
- [Medium] device_schedule_reprobe() snapshots dev->parent and pins it
  under the device lock (drivers/base/dd.c:1540-1550), relying on the…
- [Medium] The deferred detach checks defer_all_probes only once
  (drivers/base/dd.c:1473), but __device_release_driver() transiently…
- [Low] device_schedule_reprobe() records the bound driver as a raw
  pointer (rp->drv = dev->driver, drivers/base/dd.c:1551) and…
- [Low] The kernel-doc states 'In particular a device left unbound by an
  administrative unbind stays unbound', but device_reprobe_work_fn()…

--

driver core: add device_schedule_reprobe()

This adds a driver core helper that schedules a delayed detach and
re-probe of a device on system_freezable_wq, recording the bound driver
and parent under the device lock at scheduling time.  It also changes
__device_release_driver() to report whether it was the caller that
released the driver.

A few questions below.

The first one is about the commit message rather than the diff.

[Severity: Medium]

The message opens with three named in-tree drivers:

  "Three in-tree drivers schedule a deferred re-probe of their own device
   from a work item whose work function lives in module text: iwlwifi
   [...] hci_h5 (h5_btrtl_resume(), ...) and btintel_pcie ..."

and then concludes:

  "Both classes disappear when the driver core owns the deferred work."

None of the three drivers is converted here, and there is no Fixes: tag,
so both bug classes remain live in the tree at this commit.  In
drivers/bluetooth/hci_h5.c the reprobe worker still ends with

    put_device(reprobe->dev);
    kfree(reprobe);
    module_put(THIS_MODULE);

and btintel_pcie still calls device_reprobe() synchronously from its own
reset work.

Can the last two actually use the new helper as written?  h5_btrtl_resume()
is reached from the serdev ->resume callback, which the PM core invokes
with device_lock(dev) held (device_resume() in
drivers/base/power/main.c), while device_schedule_reprobe() takes
device_lock(dev) itself.  btintel_pcie needs the detach to have completed
by the time its FLR path returns, which a fire-and-forget delayed work
with no completion or result cannot express.

Could the rationale be reworded to describe what this patch actually
changes, or the conversions be included?

Also, the actual user of the new export is not named anywhere above the
line; it arrives later in the series as "net: dsa: mxl862xx: add devlink
flash_update and info_get", so the no-in-tree-caller half of this is
resolved there.  Only the overstated motivation is at issue here.

> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index f6525a7ee8c54..aa1f278d0ee29 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1315,7 +1315,7 @@ EXPORT_SYMBOL_GPL(driver_attach);
>   * __device_release_driver() must be called with @dev lock held.
>   * When called for a USB interface, @dev->parent lock must be held as well.
>   */
> -static void __device_release_driver(struct device *dev, struct device *parent)
> +static bool __device_release_driver(struct device *dev, struct device *parent)
>  {
>  	struct device_driver *drv;
>  
> @@ -1336,7 +1336,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>  			 */
>  			if (dev->driver != drv) {
>  				pm_runtime_put(dev);
> -				return;
> +				return false;
>  			}
>  		}

[Severity: Medium]

The loop this return sits in drops both locks and, on re-acquisition,
only re-validates dev->driver:

drivers/base/dd.c:__device_release_driver() {
	while (device_links_busy(dev)) {
		__device_driver_unlock(dev, parent);
		device_links_unbind_consumers(dev);
		__device_driver_lock(dev, parent);
		if (dev->driver != drv) {
			pm_runtime_put(dev);
			return false;
		}
	}

The new caller checks defer_all_probes exactly once, before entering
here.  Can device_shutdown() take device_lock(parent)/device_lock(dev) in
that unlocked window and run ->shutdown()?  ->shutdown() does not change
dev->driver, so the release then resumes and calls device_remove(), i.e.
->remove() against already-quiesced state.

For the driver class the commit message names, "drivers which clear their
drvdata in ->shutdown() so that a subsequent ->remove() becomes a no-op",
that is the use-after-free of driver state the helper is introduced to
prevent.

The message describes this window as pre-existing and

  "not made worse by this helper."

Is that accurate?  Every pre-existing unbind path with this window needs
an administrator action, whereas this helper turns an asynchronous
in-kernel event (firmware crash recovery, a devlink flash) into an unbind
that can coincide with an unattended reboot.  Would re-checking
defer_all_probes after the device links loop re-acquires the locks close
it?

[ ... ]

> @@ -1436,3 +1439,122 @@ void driver_detach(const struct device_driver *drv)
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
> +	 * device_shutdown() blocks probing before its walk reaches @dev.
> +	 */
> +	if (!defer_all_probes && !dev->p->dead && dev->driver == rp->drv)
> +		detached = __device_release_driver(dev, parent);

[Severity: High]

Is this plain read of defer_all_probes enough to order the deferred
detach against device_shutdown()?  Nothing registers, cancels, flushes or
waits for this delayed work, and device_shutdown() only does:

drivers/base/core.c:device_shutdown() {
	wait_for_device_probe();
	device_block_probing();

wait_for_device_probe() waits on deferred_probe_work, probe_count and
async probes, none of which covers this work item.  So:

CPU0 device_reprobe_work_fn()
	device_lock(dev);
	/* reads defer_all_probes == false */

CPU1 device_shutdown()
	wait_for_device_probe();	/* does not see this work */
	device_block_probing();		/* defer_all_probes = true */
	/* walk reaches dev, blocks on device_lock(dev) */

CPU0 continues
	__device_release_driver(dev, parent);	/* ->remove(), driver = NULL */
	device_unlock(dev);

CPU1 then finds dev->driver == NULL, so neither dev->bus->shutdown nor
dev->driver->shutdown is invoked for this device, and CPU0's subsequent
device_attach() returns -EPROBE_DEFER from really_probe() because
defer_all_probes is now set, which the error filter below drops silently.

Does that leave the device neither shut down nor bound, which is the
class 2 behaviour the message says is closed:

  "The detach half is skipped while probing is blocked, which
   device_shutdown() does before its walk reaches any device. A re-probe
   firing during shutdown therefore leaves the device bound, and its
   ->shutdown() callback still runs."

The freezable workqueue does not help on this path: kernel_restart() and
kernel_power_off() reach device_shutdown() without freezing processes or
workqueues, unlike dpm_prepare().

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

[Severity: Low]

The kernel-doc below promises "In particular a device left unbound by an
administrative unbind stays unbound", but the device and parent locks are
dropped between the detach above and this device_attach().  Can an unbind
landing in that gap be silently undone?

drivers/base/bus.c:unbind_store() {
	if (dev && dev->driver == drv) {
		device_driver_detach(dev);
		err = count;
	}

The dev->driver == drv test runs without the device lock, so if it passes
just before the work detaches, device_driver_detach() ->
device_release_driver_internal() finds dev->driver == NULL,
__device_release_driver() returns false, unbind_store() still returns
count, and this device_attach() re-binds the device.  In-kernel callers of
device_release_driver() see the same no-op.

The new __device_release_driver() return value covers the narrower race
inside the device_links_busy() loop, where the competing unbinder did
perform the release; it cannot detect an unbind that released nothing
because the work got there first.

> +		if (ret < 0 && ret != -EPROBE_DEFER)
> +			dev_err_probe(dev, ret,
> +				      "re-probe failed, device left unbound\n");
> +		if (rp->parent_lock)
> +			device_unlock(parent);
> +	}
> +
> +	put_device(dev);
> +	put_device(parent);
> +	kfree(rp);
> +}
> +
> +/**
> + * device_schedule_reprobe - schedule a deferred detach and re-probe
> + * @dev: device to detach and re-probe
> + * @delay_ms: delay in milliseconds before the re-probe runs
> + *
> + * Schedule a detach and re-probe of @dev after @delay_ms milliseconds.
> + * The re-probe is skipped if, by the time the scheduled work runs, the
> + * device has been removed, probing has been blocked for a system
> + * shutdown, or @dev is no longer bound to the driver that was bound at
> + * scheduling time. In particular a device left unbound by an
> + * administrative unbind stays unbound.
> + *
> + * The work function is built-in text, so the bound driver may call this
> + * from its own code without holding a module reference. If the driver
> + * module is unloaded before the work runs, driver unregistration unbinds
> + * @dev first and the scheduled work does nothing.
> + *

[ ... ]

> + * The work is freezable: a re-probe pending across system suspend runs
> + * once the system has resumed.
> + *
> + * May only be called from process context, and not from @dev's own
> + * ->probe(), which is called with the device lock held.
> + *
> + * Returns: 0 on success, -EINVAL if @dev is not a registered device
> + * bound to a driver, -ENOMEM on allocation failure.
> + */
> +int device_schedule_reprobe(struct device *dev, unsigned int delay_ms)
> +{
> +	struct device_reprobe *rp;
> +	struct device *parent;
> +
> +	rp = kzalloc_obj(*rp);
> +	if (!rp)
> +		return -ENOMEM;
> +
> +	/* device_del() drops @dev's own reference to the parent. */
> +	device_lock(dev);

[Severity: Medium]

device_lock() is a plain mutex_lock(&dev->mutex) and is not recursive, so
does this hang any caller that already holds @dev's lock, rather than
just the ->probe() case the kernel-doc mentions?

The PM core holds the device lock across the driver sleep callbacks:

drivers/base/power/main.c:device_resume() {
	device_lock(dev);
	...
	error = dpm_run_callback(callback, dev, state, info);

	device_unlock(dev);
}

The same applies to ->suspend, ->prepare and ->complete, and to ->remove
via __device_release_driver() and ->shutdown via device_shutdown().

One of the three call sites this helper is written to replace is exactly
such a context: h5_btrtl_resume() is reached from h5_serdev_resume(), the
serdev ->resume, and it defers device_reprobe() into its own work item
because the device lock is held there.  Would moving the validation and
snapshot into the work function, as those drivers do, avoid this?  If not,
could the documented contract name the PM callbacks, ->remove() and
->shutdown() as well?

> +	parent = dev->parent;
> +	if (!dev->bus || !dev->p || dev->p->dead ||
> +	    !device_is_registered(dev) || !dev->driver) {
> +		device_unlock(dev);
> +		kfree(rp);
> +		return -EINVAL;
> +	}
> +
> +	rp->dev = get_device(dev);
> +	rp->parent = get_device(parent);

[Severity: Medium]

The comment above says device_del() takes the device lock before dropping
@dev's reference to the parent, but device_move() also reassigns
dev->parent while holding only device_pm_lock():

drivers/base/core.c:device_move() {
	old_parent = dev->parent;
	dev->parent = new_parent;
	...
	put_device(old_parent);
}

It never takes device_lock(dev), and the device stays registered and
non-dead throughout, so all the checks just above pass.

Can that put_device(old_parent) free the parent between the read of
dev->parent and this get_device(parent) when the child held the last
reference, making the get_device() a kobject_get() on freed memory and
the later device_lock()/device_unlock()/put_device() in
device_reprobe_work_fn() operate on it too?

And even when the old parent survives, rp->parent is stale for the
lifetime of the work, so the work pins and locks a device that is no
longer dev->parent on buses that set need_parent_lock.

No in-tree caller combines the two today: the user added later in this
series operates on an mdio_device, and the device_move() callers (ccw,
dasd, rfcomm, pvrusb2, u_ether, hci_sysfs) do not use this helper.

> +	rp->parent_lock = parent && dev->bus->need_parent_lock;
> +	rp->drv = dev->driver;

[Severity: Low]

Since rp->drv is a raw pointer used only for address equality in the
work, and the comment there accepts that it may point to freed module
data, can address reuse make the comparison match a different driver?

If the driver module is unloaded and another module is loaded during the
caller-chosen delay, a new struct device_driver can land at the same
address; if the pinned device is then bound to that driver (driver_override
or a matching bus id), dev->driver == rp->drv passes and the work unbinds
and re-probes a device the administrator deliberately bound elsewhere.

That contradicts the kernel-doc statements that the work is skipped when
@dev "is no longer bound to the driver that was bound at scheduling time"
and that "a device left unbound by an administrative unbind stays
unbound".  Would a generation counter, or additionally comparing the
driver name, close it?

> +	device_unlock(dev);
> +
> +	INIT_DELAYED_WORK(&rp->work, device_reprobe_work_fn);
> +	queue_delayed_work(system_freezable_wq, &rp->work,
> +			   msecs_to_jiffies(delay_ms));
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(device_schedule_reprobe);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1789175618.git.daniel%40makrotopia.org
