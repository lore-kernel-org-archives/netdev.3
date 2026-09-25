Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D83343899;
	Fri, 25 Sep 2026 05:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314462; cv=none; b=aeTpwQsFAsMnfL0F5qHMKa/oH/mhBYn35bTUK0H9k3hLnvwTwY41kUBnpYlwDva/Oa84/Jn1viXn8FwmOoRLc/4STrvL75U2pcA5Nm5t5ihKvLmzEdMrZZo/b/pqpJq7yhqQipNRBmgc11x//49CtDPGHVKdxBEvdQulUOufOEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314462; c=relaxed/simple;
	bh=YlDLmTYGf+OMZSoeyItVG+ZNdULTD/7HAmwKxJQPA30=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RwGZz0SglZMnE5kDG4jRLh9qRhTHVOkIalHhLL0UjWkZ5/fG7bE8Oi+6jRwRw0w/8zqERyIx48yAcqRG3wrd2Ce2/xocZ27Wr+ru/RW4CN2sTDnYTzVcDDsi9ikiavWaxaidNmz9ZuLLTj1w1Cg31lwA2zVS0D+81RtPof/qPAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9SoKbxc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9SoKbxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C001F000FF;
	Fri, 25 Sep 2026 05:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790314460;
	bh=N7FhqT8hGabdEId+z3AaWAtoEMimGgShF1rW8+udDbI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T9SoKbxczKonmTCKj+pNMsK85DF1j+yR7tCjg4rhdcuLBKSkLfs+PUA9J3kQuuTZf
	 mRefrIJ95ox9jAXi8JNhblYjewH/gd+SRKQ2L2gpo1GnA5o8VQO0YTK8l6XRDEAEzQ
	 7ImWD6ThW3S+gvHFndy5TYuY6Ia1MbMcpJOAP4WFPq8zg7ZuBloPi3nsyk6ButnlJO
	 Rh9dwf+fEVgIQ32Tvod8wdIUItzEcTFDyGXhexPFfbrybUKhxX1500XGB1Z//obTIk
	 wQTSw3LTI2ZrbKn7G2x//dT400B+DURdVCPzHZ1Wc6kmIZh/Qlssffp8ucbUPH0kUR
	 hrO9q6dndn3HQ==
Subject:
 Re: [PATCH net-next v17 3/6] driver core: add device_schedule_reprobe()
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Fri, 25 Sep 2026 05:34:18 +0000
Message-ID: <179031445878.2160803.13040631254359751357@kernel.org>
In-Reply-To: =?utf-8?q?=3Cacb746142c5e9d06fd592db29872b55869735faf=2E1790130?=
 =?utf-8?q?482=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3Cacb746142c5e9d06fd592db29872b55869735faf=2E17901304?=
 =?utf-8?q?82=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 4 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] device_reprobe_work_fn() treats any `defer_all_probes == true`
  as a permanent shutdown.
- [Low] device_schedule_reprobe() (drivers/base/dd.c) reads the driver
  with `drv = READ_ONCE(dev->driver)` and holds no lock or reference on…
- [Low] device_reprobe_work_fn() identifies the binding only by
  `dev->driver == rp->drv && !strcmp(dev->driver->name, rp->drv_name)`.
- [Low] device_reprobe_work_fn() treats a re-probe as failed only when
  `ret < 0 && ret != -EPROBE_DEFER`, where ret comes from…
- [Low] The commit message says 'Nothing is locked or validated in the
  caller's context', but device_schedule_reprobe() does check the device…

Pre-existing issues:
- [Medium] device_reprobe_work_fn() checks defer_all_probes once, under
  device_lock(), and then calls __device_release_driver().
- [Low] The commit message's first paragraph gives, as motivation, the
  module-text epilogue race (put_device(); kfree();…

--

driver core: add device_schedule_reprobe()

This commit adds device_schedule_reprobe() to the driver core. It queues a
freezable delayed work item that detaches and re-probes a device, but only
if the device is still bound to the same driver, matched by pointer and
name. The work function is built-in text, so callers don't need a module
reference, and buses that take the parent lock to bind are refused.

> Drivers that need a deferred re-probe of their own device open-code a
> work item in module text. iwlwifi (iwl_trans_schedule_reprobe(), for a
> firmware crash a lighter restart cannot fix) and hci_h5
> (h5_btrtl_resume(), RTL devices lose their firmware state over suspend)
> both end that work function with put_device(); kfree();
> module_put(THIS_MODULE);, where a concurrent rmmod can free the module
> text the epilogue is still executing.

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch, but
neither of the two drivers given as motivation is converted anywhere in the
series. At the end of the series, iwl_trans_reprobe_wk() in iwl-trans.c and
h5_btrtl_reprobe_worker() in hci_h5.c still end with:

	put_device(reprobe->dev);
	kfree(reprobe);
	module_put(THIS_MODULE);

Could the commit message say these conversions are left for later? As
written, it reads as though the series deals with these drivers.

> Nothing is locked or validated in the caller's context, so the helper
> may be called with the device lock held, as the PM callbacks, ->remove()
> and ->shutdown() hold it.

[Severity: Low]
Is "validated" accurate here? device_schedule_reprobe() does check the
device in the caller's context:

	if (!drv || !dev->bus || dev->bus->need_parent_lock || !dev->p ||
	    dev->p->dead || !device_is_registered(dev))
		return -EINVAL;

The kernel-doc also lists these -EINVAL conditions.

What seems to be true is that nothing is locked. The checks are unlocked
snapshots, and the work repeats them under device_lock(). Could the
sentence say that instead?

> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index f6525a7ee8c54..a26a6b0eaef5b 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1436,3 +1436,118 @@ void driver_detach(const struct device_driver *drv)

[ ... ]

> +static void device_reprobe_work_fn(struct work_struct *work)
> +{

[ ... ]

> +	device_lock(dev);
> +	/*
> +	 * rp->drv is only compared, never dereferenced: the driver it points
> +	 * to may have been unregistered and freed. The saved name rejects a
> +	 * freed address the allocator has since handed to another driver.
> +	 */
> +	if (!defer_all_probes && !dev->p->dead && dev->driver == rp->drv &&
> +	    !strcmp(dev->driver->name, rp->drv_name)) {

[Severity: Medium]
Can a pending request be lost for good if its timer fires between
dpm_prepare() and dpm_complete()?

dpm_prepare() sets defer_all_probes through device_block_probing(), and
dpm_complete() clears it again, so in that window the block is only
temporary. When this check fails, the work goes straight to kfree(rp) and
nothing re-queues the request.

The kernel-doc relies on system_freezable_wq being frozen during that
window. Freezable workqueues are only frozen by freeze_kernel_threads(),
through try_to_freeze_tasks(false)->freeze_workqueues_begin().
kernel_kexec() with preserve_context (CONFIG_KEXEC_JUMP) does:

	error = freeze_processes();
	...
	error = dpm_suspend_start(PMSG_FREEZE);

and never calls freeze_kernel_threads(). With CONFIG_SUSPEND_FREEZER=n,
suspend_freeze_processes() doesn't freeze anything at all.

In those cases, wouldn't the work run while defer_all_probes is set, skip
the detach and free the request? That contradicts the kernel-doc's "one
pending across system suspend runs once the system has resumed".

For the mxl862xx flash user later in the series, priv->skip_teardown would
stay set. Further flashes would be refused with "A previous flash is still
waiting for its reprobe" until someone unbinds and binds the device by
hand.

[Severity: Low]
Can this check tell the binding that made the request from a later binding
of the same driver? Driver names are unique per bus, so the (pointer, name)
pair also matches any later bind of the same driver. That includes:

  - a sysfs unbind followed by a bind within the delay (500 ms for
    mxl862xx)
  - a module reload that places the static struct device_driver at the
    same address
  - a second request queued while the first one is still pending

In each case, the stale work would detach and re-probe a fresh instance
that never asked for it. device_schedule_reprobe() doesn't coalesce
requests and returns no handle, so ->remove() cannot cancel a pending one.

With the later mxl862xx user, one sequence is:

  - the rescue-path reprobe fires during a flash
  - ->remove() waits in mxl862xx_flash_shutdown()
  - the flash queues another request
  - that second request re-probes the new instance again

The kernel-doc lists "is no longer bound, is bound to a different driver"
as skip conditions. It doesn't mention that an unbind followed by a rebind
to the same driver still triggers the re-probe. The v15 revision documented
this. Should the kernel-doc say so again?

> +		__device_release_driver(dev, NULL);
> +		detached = true;
> +	}

[Severity: Medium]
This isn't a bug introduced by this patch, since the window is in
__device_release_driver(). However, the helper makes it reachable from a
timer.

defer_all_probes is checked only once, above. __device_release_driver()
can then drop dev->mutex:

	while (device_links_busy(dev)) {
		__device_driver_unlock(dev, parent);
		device_links_unbind_consumers(dev);
		__device_driver_lock(dev, parent);
		...
		if (dev->driver != drv) {

In that window device_shutdown() can call device_block_probing(), take
device_lock(dev), and call ->shutdown() on the device, which is still
bound. When the work takes the lock back, dev->driver is unchanged, so it
goes on to device_remove(). device_block_probing() waits only for
probe_count, not for a release that is already running.

The commit message and kernel-doc describe this as a pre-existing
limitation. system_freezable_wq is not frozen during reboot, though. Is
->remove() after ->shutdown() safe for drivers whose ->shutdown() powers
the hardware off?

> +	device_unlock(dev);
> +
> +	if (detached) {
> +		ret = device_attach(dev);
> +		if (ret < 0 && ret != -EPROBE_DEFER)
> +			dev_err_probe(dev, ret,
> +				      "re-probe failed, device left unbound\n");
> +	}

[Severity: Low]
Can this message ever print when the re-probe fails? really_probe() turns
->probe() errors into positive values:

	ret = -ret;

Then __device_attach_driver() does:

	ret = driver_probe_device(drv, dev);
	if (ret < 0)
		return ret;
	return ret == 0;

So device_attach() returns 0 in both main failure cases: when ->probe()
fails, and when no driver matches because it was unregistered in between.

call_driver_probe() already logs a failed ->probe(). The no-match case,
though, leaves the device unbound without any message. Is the ret < 0
check reachable for the "A failed re-probe leaves @dev unbound" case that
the kernel-doc describes?

[ ... ]

> +int device_schedule_reprobe(struct device *dev, unsigned int delay_ms)
> +{
> +	const struct device_driver *drv;
> +	struct device_reprobe *rp;
> +
> +	drv = READ_ONCE(dev->driver);

[ ... ]

> +	rp = kzalloc_obj(*rp);
> +	if (!rp)
> +		return -ENOMEM;
> +
> +	rp->drv_name = kstrdup(drv->name, GFP_KERNEL);

[Severity: Low]
What keeps drv valid here? dev->driver is read without the device lock and
without a reference on the driver or its module. drv->name is then
dereferenced after the sleeping kzalloc_obj().

If a caller isn't serialized against the driver being unbound or its
module being unloaded, can drv->name point into freed module memory?

The callers in this series look fine:

  - mxl862xx_devlink_flash_update() runs under the devlink instance lock,
    which ->remove() waits for
  - mxl862xx_rescue_heal_work_fn() is cancelled with cancel_work_sync() in
    ->remove()

The Context line says "May be called from any process context", though.
Should it say the caller must be the bound driver, in a context that its
->remove() waits for?

Also, the commit message says the pointer is "only ever compared, never
dereferenced". That holds for the stored rp->drv, but not for this path.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790130482.git.daniel%40makrotopia.org
