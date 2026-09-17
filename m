Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A104F55D3;
	Thu, 17 Sep 2026 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661490; cv=none; b=V+tsCVDuHeaEpg9PH08NJiVFZz77OEk4LsyaqabIXXacrQuvaOW8tU2R9t2DDue4SemuQXa6SovbsL+dJ9vrYrt3nf56peqUIMDHkuusj9Ue9tGdUsgKApgQ511eNjKQkBySHusgdvt0kVUbS/mivFmSH1nzZPkuNpNJEw8+FV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661490; c=relaxed/simple;
	bh=sIJdhqOdw5BD6aOFYGFr3Bf79q+QOTkR9hjQrU/329A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WQSFIUI7PgVVQ/ag+RYG6YPKG4wIQZLj9K4GZ6dHV4fWrgs9fho+MX5+1cNkS21Zd3QJC5r3ExA6q7tP3ByNhGe6eIKu3TaVJEwMP0ZcpuKpdV93kLo+DqWwaD4pzGchmvCmiU6Emcy6SiEcaKx8Y1AQNy6g+eduVp9kIc2lars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKGkX5tj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKGkX5tj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3721F00898;
	Thu, 17 Sep 2026 16:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661488;
	bh=kE2VfpYRsvRE+gn1eeQvmgtMQXeLwmbr/bSO8ZdxK4E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eKGkX5tj86zbUKohufWOJoZhwiDhoJdnsffTpYyM5kMZrAejauLG6YxdRiM844yb3
	 8H9wq8+L4EOZBHbmDvUf5Anf6hBx6LOad2edwQBgzv9P/HFtXRl4+sQNxqHqzaA1/O
	 tHxQXoxtwUjovZoACYcDGgO2VZIQcChgC5jvi0ZYzPO/djw71/P9fXl+ocxjtZBZEY
	 yckHUv5cZJG8/FCYasT76VZSyLnflzEUOA7sg3ACUobrHDhzNzyIbk70ibyZ26glWG
	 CX1Qq0uohdhbHWQ3Lt/70ukF3Uy3pd3vijE981r0NZwGqQrC/GxknXO8Xpfj7rud1S
	 DWIPcLE7OdjUg==
Subject:
 Re: [PATCH net-next v16 3/6] driver core: add device_schedule_reprobe()
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Thu, 17 Sep 2026 16:11:26 +0000
Message-ID: <178966148657.22033.10297729973512480999@kernel.org>
In-Reply-To: =?utf-8?q?=3Cb8cfff498ef5662093062ea03015cb3ccb95957b=2E1789477?=
 =?utf-8?q?568=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3Cb8cfff498ef5662093062ea03015cb3ccb95957b=2E17894775?=
 =?utf-8?q?68=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 3 · Low: 4

- [High] The new `abort_if_blocked` protection stops at @dev.
- [Medium] `__device_release_driver()` (drivers/base/dd.c:1341-1345) can
  now abandon a release *inside* the `while (device_links_busy(dev))`…
- [Medium] Only the detach half of the re-probe is gated on
  `defer_all_probes`; the attach half is not.
- [Medium] The detach and the re-attach are not one serialized operation,
  so an administrative unbind can be acknowledged and then undone.
- [Low] `device_schedule_reprobe()` stores only a raw `const struct
  device_driver *` (`drv = READ_ONCE(dev->driver)`, no reference, no…
- [Low] The kernel-doc of `device_schedule_reprobe()` says "Nothing is
  locked in the caller's context, so this may be called from any process…
- [Low] Reported for completeness; my baseline decision is that this is
  NOT a defect to act on.
- [Low] Reported for completeness; my baseline decision is FALSE
  POSITIVE.

--

driver core: add device_schedule_reprobe()

This adds a driver-core helper that schedules a delayed detach and
re-probe of a device from built-in work, replacing the open-coded work
items drivers use today. __device_release_driver() gains a return value
and an abort_if_blocked flag so a re-probe can abandon the unbind when
probing has been blocked meanwhile.

A few questions about the new helper and the new flag.

> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index f6525a7ee8c54..f521ddefc4a88 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1314,8 +1314,12 @@ EXPORT_SYMBOL_GPL(driver_attach);
>  /*
>   * __device_release_driver() must be called with @dev lock held.
>   * When called for a USB interface, @dev->parent lock must be held as well.
> + * @abort_if_blocked gives up the release instead when probing has been
> + * blocked while the locks were dropped; only a caller that may abandon
> + * the unbind altogether can ask for it.
>   */
> -static void __device_release_driver(struct device *dev, struct device *parent)
> +static bool __device_release_driver(struct device *dev, struct device *parent,
> +				    bool abort_if_blocked)
>  {
>  	struct device_driver *drv;
>  
> @@ -1334,9 +1338,10 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>  			 * have released the driver successfully while this one
>  			 * was waiting, so check for that.
>  			 */
> -			if (dev->driver != drv) {
> +			if (dev->driver != drv ||
> +			    (abort_if_blocked && defer_all_probes)) {
>  				pm_runtime_put(dev);
> -				return;
> +				return false;
>  			}
>  		}
>  

[Severity: Medium]
When the new abort_if_blocked && defer_all_probes arm fires, is the
device-links state left half torn down?

By the time this check runs, device_links_busy() has already done:

drivers/base/core.c:device_links_busy() {
	...
		WRITE_ONCE(link->status, DL_STATE_SUPPLIER_UNBIND);
	}

	dev->links.status = DL_DEV_UNBINDING;
	...
}

and device_links_unbind_consumers() has already force-released the drivers
of the active consumers.

Returning false here leaves @dev bound, so device_links_driver_cleanup() -
the only code that moves those links back to DL_STATE_DORMANT and clears
DL_DEV_UNBINDING - never runs, and device_links_driver_bound() cannot run
either because the supplier never rebinds.

Can the already-detached consumers then re-probe?
device_links_check_suppliers() looks like it would defer them forever:

drivers/base/core.c:device_links_check_suppliers() {
	...
		if (link->status != DL_STATE_AVAILABLE &&
		    !device_link_test(link, DL_FLAG_SYNC_STATE_ONLY)) {
			...
			ret = dev_err_probe(dev, -EPROBE_DEFER, ...);
	...
}

and any new device_link_add() against this still-bound supplier starts at
DL_STATE_SUPPLIER_UNBIND because supplier->links.status is DL_DEV_UNBINDING.

The pre-existing dev->driver != drv arm is different in that a concurrent
releaser completes the state machine. Here the only caller passing true,
device_reprobe_work_fn(), treats false as "nothing happened" and does no
compensating cleanup. Should the kernel-doc and commit message mention this,
or should the abort undo the links state it inherits?

[ ... ]

> @@ -1369,7 +1377,7 @@ void device_release_driver_internal(struct device *dev,
>  	__device_driver_lock(dev, parent);
>  
>  	if (!drv || drv == dev->driver)
> -		__device_release_driver(dev, parent);
> +		__device_release_driver(dev, parent, false);
>  
>  	__device_driver_unlock(dev, parent);
>  }

[Severity: High]
Does the new flag actually close the ->shutdown()/->remove() interleaving
for the consumers, or only for @dev?

The commit message says:

  "__device_release_driver() drops the device lock while busy consumer
   links are unbound, which would let a ->shutdown() interleave in the
   middle of a release already under way, so it now re-checks on
   re-acquisition and abandons the release."

But the consumer unbinds happen inside that dropped-lock window, before the
new check is evaluated:

drivers/base/dd.c:__device_release_driver() {
	...
		while (device_links_busy(dev)) {
			__device_driver_unlock(dev, parent);

			device_links_unbind_consumers(dev);

			__device_driver_lock(dev, parent);
	...
}

and each consumer goes through this wrapper, which hardcodes the flag off:

drivers/base/core.c:device_links_unbind_consumers() {
	...
			device_release_driver_internal(consumer, NULL,
						       consumer->parent);
	...
}

So the sequence looks reachable:

device_reprobe_work_fn()
    device_lock(dev)                       /* defer_all_probes == false */
    __device_release_driver(dev, NULL, true)
        device_links_busy(dev) == true
        device_unlock(dev)
        device_links_unbind_consumers(dev)

meanwhile:

device_shutdown()
    device_block_probing()                 /* defer_all_probes = true */
    device_lock(consumer)
    consumer->driver->shutdown(consumer)
    device_unlock(consumer)

back in device_links_unbind_consumers():

    device_release_driver_internal(consumer, ...)
        __device_release_driver(consumer, ..., false)
            device_remove(consumer)        /* consumer ->remove() */

Is the consumer's ->remove() then run after its ->shutdown() has already
quiesced it? Nothing else serialises the two beyond the consumer's own
device lock, and wait_for_device_probe() cannot see the new delayed work:

drivers/base/dd.c:wait_for_device_probe() {
	flush_work(&deferred_probe_work);
	wait_event(probe_waitqueue, atomic_read(&probe_count) == 0);
	async_synchronize_full();
}

Should the abort decision be propagated into the consumer releases before
their removal callbacks run, or should shutdown be synchronised against the
whole in-flight re-probe?

> @@ -1436,3 +1444,98 @@ void driver_detach(const struct device_driver *drv)
>  		put_device(dev);
>  	}
>  }
> +
> +struct device_reprobe {
> +	struct delayed_work work;
> +	const struct device_driver *drv;
> +	struct device *dev;
> +};
> +
> +static void device_reprobe_work_fn(struct work_struct *work)
> +{
> +	struct device_reprobe *rp = container_of(work, struct device_reprobe,
> +						 work.work);
> +	struct device *dev = rp->dev;
> +	bool detached = false;
> +	int ret;
> +
> +	device_lock(dev);
> +	/*
> +	 * rp->drv is only ever compared, never dereferenced: the driver it
> +	 * points to may have been unregistered and freed by now.
> +	 * device_shutdown() blocks probing before its walk reaches @dev.
> +	 */
> +	if (!defer_all_probes && !dev->p->dead && dev->driver == rp->drv)
> +		detached = __device_release_driver(dev, NULL, true);
> +	device_unlock(dev);
> +
> +	if (detached) {
> +		ret = device_attach(dev);
> +		if (ret < 0 && ret != -EPROBE_DEFER)
> +			dev_err_probe(dev, ret,
> +				      "re-probe failed, device left unbound\n");
> +	}

[Severity: Medium]
Only the detach half is gated on defer_all_probes here; is the attach half
also meant to be?

device_attach() runs after device_unlock(dev) with no re-check, and
__device_attach() resumes the parent before anything tests defer_all_probes:

drivers/base/dd.c:__device_attach() {
	...
		if (dev->parent)
			pm_runtime_get_sync(dev->parent);

		ret = bus_for_each_drv(dev->bus, NULL, &data,
					__device_attach_driver);
	...
}

really_probe() only rejects the probe later. device_shutdown() itself only
does pm_runtime_get_noresume() plus a barrier, so a parent that is
RPM_SUSPENDED stays suspended - can this work then runtime-resume a parent
whose ->shutdown() has already run, and add @dev to the deferred-probe list
while probing is blocked?

Nothing cancels or flushes this work either, and wait_for_device_probe()
(which device_block_probing() relies on) only flushes deferred_probe_work,
waits for probe_count and calls async_synchronize_full(), none of which
observe a system_freezable_wq delayed work.

[Severity: Medium]
Can an administrative unbind be acknowledged and then undone here, since the
detach and the re-attach are not one serialised operation?

drivers/base/bus.c:unbind_store() {
	...
	if (dev && dev->driver == drv) {
		device_driver_detach(dev);
		err = count;
	...
}

That dev->driver == drv test is unlocked, and device_driver_detach() ends up
in device_release_driver_internal(), which blocks on the device lock this
work holds. When it gets the lock, dev->driver is NULL, so it does nothing,
and unbind_store() still returns count. Then this work calls
device_attach(dev) and the device is bound again. The same applies to an
unbind arriving in the window between device_unlock(dev) and
device_attach(dev).

The commit message lists "a stale re-probe undoes an administrative unbind"
among the things the new helper addresses, while the new return value only
covers an unbind that wins inside the busy-consumer-links loop. Could that
wording be narrowed, or the gap between detach and re-attach closed?

> +
> +	put_device(dev);
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
> + * scheduling time.
> + *
> + * The work function is built-in text, so the bound driver may call this
> + * from its own code without holding a module reference. If the driver
> + * module is unloaded before the work runs, driver unregistration unbinds
> + * @dev first and the scheduled work does nothing.

[ ... ]

> + *
> + * Nothing is locked in the caller's context, so this may be called from
> + * any process context, @dev's own device lock held included, but not
> + * from @dev's ->probe(), which the scheduled work would detach.

[ ... ]

> + */
> +int device_schedule_reprobe(struct device *dev, unsigned int delay_ms)
> +{
> +	const struct device_driver *drv;
> +	struct device_reprobe *rp;
> +
> +	drv = READ_ONCE(dev->driver);

[Severity: Low]
The recorded identity of the binding is a bare struct device_driver pointer,
with no reference, no module pin and no generation counter, and
device_reprobe_work_fn() gates the destructive detach only on

	dev->driver == rp->drv

Is pointer identity enough here? An unbind followed by a rebind of the same
driver within @delay_ms makes the test pass for a binding the caller never
scheduled against. After a module unload, can the same address be reused by
another module's struct device_driver, in which case the kernel-doc promise

  "If the driver module is unloaded before the work runs, driver
   unregistration unbinds @dev first and the scheduled work does nothing."

no longer holds, and the work would drive __device_release_driver() -
including device_links_unbind_consumers() and an unrelated driver's
->remove() - followed by device_attach()?

There is also no cancel or flush counterpart, so a caller cannot gate this
itself. Would a bind generation counter, a per-binding token, or at least
comparing the driver name as well, match the documented semantics?

> +	/*
> +	 * A bus taking the parent lock would need @dev's parent pinned until
> +	 * the work runs, which device_move() can invalidate.
> +	 */
> +	if (!drv || !dev->bus || dev->bus->need_parent_lock || !dev->p ||
> +	    dev->p->dead || !device_is_registered(dev))
> +		return -EINVAL;
> +
> +	rp = kzalloc_obj(*rp);
> +	if (!rp)
> +		return -ENOMEM;

[Severity: Low]
The kernel-doc says this "may be called from any process context", but
kzalloc_obj() with no gfp argument resolves to GFP_KERNEL and may sleep:

include/linux/gfp.h:
	#define __default_gfp(a,b,...) b
	#define default_gfp(...) __default_gfp(,##__VA_ARGS__,GFP_KERNEL)

The commit message invites callers from the PM callbacks, whose _late and
_noirq phases run with interrupts disabled. Could a Context: line stating
that this helper may sleep be added, or the gfp flags be passed explicitly?

> +
> +	rp->dev = get_device(dev);
> +	rp->drv = drv;
> +
> +	INIT_DELAYED_WORK(&rp->work, device_reprobe_work_fn);
> +	queue_delayed_work(system_freezable_wq, &rp->work,
> +			   msecs_to_jiffies(delay_ms));
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(device_schedule_reprobe);

[Severity: Low]
This isn't a bug, just a wording note. The commit message opens by
describing live defects in iwlwifi's iwl_trans_reprobe_wk() and hci_h5's
h5_btrtl_reprobe_worker():

  "both end that work function with put_device(); kfree();
   module_put(THIS_MODULE);, where a concurrent rmmod can free the module
   text the epilogue is still executing."

Neither driver is converted here and there is no Fixes: tag, while the newly
exported symbol has no in-tree caller until the mxl862xx patches later in
the series. Splitting the core helper from its first user is normal, so
nothing needs changing in the code; would leading with the motivation rather
than with those two drivers read more clearly?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1789477568.git.daniel%40makrotopia.org
