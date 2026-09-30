Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465AA3515C0;
	Wed, 30 Sep 2026 03:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790740132; cv=none; b=kT4pxz6AMHm595FD40BE6tQwc17hn/VX9JoU3auxvGrVzRttyHIJEHMAPHxl6GDK1VVifh9b10GZ/2dFMOC5WkWCud/yEv+DixbqWfBgVxQH+nan3BZGhgWRQryl3F+jCohaWM6o2OJ66dGLd/ugHZrig18+uxqOnoSi3XfMOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790740132; c=relaxed/simple;
	bh=lp5xPjq8zX7LuOkfHkwlpaeHU/dF2qbKn6hWPgeY8ME=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=blVkL6BvWTQnrbRr1mquZwQ9T04kWx58RKwPvbTkoXPsVXAZH9tF8R0qSXYJa4s12nD8GvYc79FHGQeFRelXHICaprxlcYo1c2Vl690cSKMnfGkuSFQqB4dNUl4Sn8Oqo24qnTyGRqvws1yJ80xOHxBVkucnnMRTjiDU11zXdcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Su0j72H4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Su0j72H4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABC01F000FF;
	Wed, 30 Sep 2026 03:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790740130;
	bh=KZHe/FVnfiE45qptdO4PNrZd1FsDbQ5ylcnvWq1RbyU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Su0j72H48UWQx0TELtMc1BpCk5Q2dO4T72aqrb1gWkrvf1xT+PPuvkSUpWWZGqALR
	 4z4NRo9dUDFcBGEWk+GnXYJCIkfp1PFomoTrt4gEXMA56rcHbaMdrvaWHeKc3rkHiK
	 s/lxcfp03ke+w4xeG5q5qZ/Fje75rCNjqkFBQVqr9fJq+TkaCNezzPECMgbDO5uCRj
	 C5fynlJfaRPMCo8ehkf8GMw07emQVFR7Dg0ZtzCrKA27qppiT+RRH6W/t/iejIC4gO
	 g4Z0DF1iF9e7k/l40cb/2BfD8BnHxjIDKCSiUJ3cmOaVenuCfz7DWuf5OXbcKJWgUa
	 wS3QRhW4nZF4g==
Subject:
 Re: [PATCH net-next v18 3/6] driver core: add device_schedule_reprobe()
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Wed, 30 Sep 2026 03:48:49 +0000
Message-ID: <179074012933.434549.4644127327520055010@kernel.org>
In-Reply-To: =?utf-8?q?=3Ce70f147857d21b792de81c7d39c2f74c6e0ec3f5=2E1790426?=
 =?utf-8?q?599=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3Ce70f147857d21b792de81c7d39c2f74c6e0ec3f5=2E17904265?=
 =?utf-8?q?99=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In device_reprobe_work_fn() (drivers/base/dd.c), the check `if
  (ret <= 0 && ret != -EPROBE_DEFER) dev_err(dev, "re-probe left the…
- [Medium] When probing is blocked, device_reprobe_work_fn() re-queues
  itself with `queue_delayed_work(system_freezable_wq, &rp->work,…
- [Medium] The shutdown/suspend gate in device_reprobe_work_fn() is a
  check-then-act.
- [Medium] device_schedule_reprobe() pins @dev with get_device() in a
  delayed work that nothing can cancel or flush: the rp handle is never…

--

driver core: add device_schedule_reprobe()

This adds device_schedule_reprobe(). It detaches and re-probes a device
from a driver-core delayed work after a delay the caller chooses. Under
the device lock, the work checks that the device is still bound to the
same driver, and it re-arms itself while suspend or shutdown blocks
probing.

> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index f6525a7ee8c54..823a25f9c0895 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1436,3 +1436,129 @@ void driver_detach(const struct device_driver *drv)

[ ... ]

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
> +	 * rp->drv is only compared, never dereferenced: the driver it points
> +	 * to may have been unregistered and freed. The saved name rejects a
> +	 * freed address the allocator has since handed to another driver.
> +	 */
> +	if (!dev->p->dead && dev->driver == rp->drv &&
> +	    !strcmp(dev->driver->name, rp->drv_name)) {
> +		if (defer_all_probes) {
> +			device_unlock(dev);
> +			queue_delayed_work(system_freezable_wq, &rp->work,
> +					   rp->delay);
> +			return;
> +		}

[Severity: Medium]
What stops this re-arm once shutdown has started? device_shutdown() does:

	wait_for_device_probe();
	device_block_probing();

device_unblock_probing() is only called from dpm_complete(). Once a reboot
starts, defer_all_probes stays true, so a pending request keeps
re-queueing itself until power-off.

device_schedule_reprobe() also accepts delay_ms == 0, which makes
rp->delay 0:

	rp->delay = msecs_to_jiffies(delay_ms);

With a zero delay, queue_delayed_work() queues the work at once. The work
then runs back to back and takes and drops dev->mutex on every pass,
while device_shutdown() walks the device list and takes the same
per-device locks.

The same applies to the dpm_prepare()..dpm_complete() window when
system_freezable_wq is not frozen, such as the kexec jump case mentioned
in the v18 changelog. The in-series mxl862xx caller uses 500 ms, so it
only gets a periodic re-arm. The exported API still allows the zero-delay
case.

Should there be a minimum re-arm interval? Or could the shutdown case drop
the request instead of re-arming? The kernel-doc only says the work
"re-arms itself after @delay_ms".

> +		__device_release_driver(dev, NULL);
> +		detached = true;
> +	}

[Severity: Medium]
Can defer_all_probes become true right after the check above?
device_block_probing() sets it with a plain store and takes no device
lock:

void device_block_probing(void)
{
	defer_all_probes = true;
	/* sync with probes to avoid races. */
	wait_for_device_probe();
}

wait_for_device_probe() flushes deferred_probe_work and waits for
probe_count and async probes. It does not wait for this work item on
system_freezable_wq.

Suppose the work reads false and calls __device_release_driver(), and dev
has managed consumers. The device lock is then dropped inside the
device_links_busy() loop:

	while (device_links_busy(dev)) {
		__device_driver_unlock(dev, parent);

		device_links_unbind_consumers(dev);

		__device_driver_lock(dev, parent);
		...
		if (dev->driver != drv) {

In that gap, device_shutdown() can take device_lock(dev) and call
dev->driver->shutdown(dev). When the work gets the lock back, dev->driver
is unchanged, so it continues to device_remove(). That runs ->remove()
after ->shutdown() on hardware that is already shut down. Consumers that
the backward walk has already shut down could see the same order.

The kernel-doc says a request "that fires during a shutdown detaches
nothing" and that the overlap "may run ->remove() in place of
->shutdown()". Isn't the actual result that both callbacks run, with
->remove() second?

The lock-dropping loop predates this patch. This helper adds a
timer-driven unbind that is likely to fire around a reboot that follows a
flash.

> +	device_unlock(dev);
> +
> +	if (detached) {
> +		ret = device_attach(dev);
> +		/* 0 is unbound too: a failed probe is folded into "no match" */
> +		if (ret <= 0 && ret != -EPROBE_DEFER)
> +			dev_err(dev, "re-probe left the device unbound\n");
> +	}

[Severity: Medium]
Will this ever see -EPROBE_DEFER coming from the driver's own ->probe()?
really_probe() makes ->probe() errors positive:

drivers/base/dd.c:really_probe() {
    ...
		ret = -ret;
		goto probe_failed;
    ...
}

driver_probe_device() adds the device to the deferred list when it sees
EPROBE_DEFER, and it returns the positive value. __device_attach_driver()
then folds any positive value into 0:

	ret = driver_probe_device(drv, dev);
	if (ret < 0)
		return ret;
	return ret == 0;

So device_attach() returns 0 for a probe-time deferral, and this
dev_err() fires even though the deferred-probe machinery will retry the
probe. The ret != -EPROBE_DEFER test seems to cover only the negative
deferrals, such as bus match deferral, device_links_check_suppliers() and
the defer_all_probes path in really_probe().

The commit message says:

  so the message is a plain dev_err() that skips only -EPROBE_DEFER, which
  the deferred-probe machinery retries on its own.

Does the code match this for the common case?

The same message is also printed if dev is unregistered between the
detach and device_attach(). In that case __device_attach() returns 0 early
because dev->p->dead is set.

> +
> +	put_device(dev);
> +	kfree(rp->drv_name);
> +	kfree(rp);
> +}

[Severity: Medium]
Could this put_device() drop the last reference and call into module
text that has already been unloaded?

rp is never returned to the caller, and there is no way to cancel or
flush it. The reference taken by get_device() in device_schedule_reprobe()
is therefore held for the whole delay.

For example, the mdio bus under the in-series mxl862xx user could be torn
down within that window through mdiobus_unregister() -> device_unregister().
If the module that provides dev->release, dev->type->release or
dev->class->dev_release is then unloaded, the work sees dev->p->dead and
skips the detach. This put_device() then drops the last reference:

device_reprobe_work_fn()
  put_device()
    kobject_put()
      device_release()
        dev->release(dev)    <- lives in the unloaded module

The commit message gives "a concurrent rmmod can free the module text the
epilogue is still executing" as the motivation, and says "The work
function is built-in text, so a caller needs no module reference". Does
that still hold for the module that owns the device's release callback?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790426599.git.daniel%40makrotopia.org
