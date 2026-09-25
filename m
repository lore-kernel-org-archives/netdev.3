Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077593ABD99;
	Fri, 25 Sep 2026 05:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314662; cv=none; b=X9RVPSbvOOGAN0pWv+uzGquMqpqkr0sqCpgjfmLZazi2rujJ+PUxq2HFnaToiLRxamfeKWSkn6InpSkAjR0RxVvcLa0eEcpfkyXf7+VyB4tU2VQfL9MNvF2FvQjIU3oEYOGc9zjb8aV91W2Db3j/wmVyKyshJBlARmQKMXN8RPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314662; c=relaxed/simple;
	bh=TiptZsxf29OlOe5WXy9sZcFl7rzB5X4lMEs5dta2ZEw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SzFxvX+077gW8fP8kujV3vpBW+pL8NJXAFefRGTSjgFrC2dE7i/HwcPODmvFWc/j0SvsUGrKg84e0cDowWufTg0voo0JC3JXPlkj2M6qX8tTOJry0/1K534kpVvMg+UDAD6V7rfVdLkNLQo/4vV1NoTDwzppVT5d2V1QTJle7+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrG/hNu4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrG/hNu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25E11F000FF;
	Fri, 25 Sep 2026 05:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790314659;
	bh=EL5nCry69SwHPUTQMjJHl7impNhyS6Pktx8aZN5u7lY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GrG/hNu4nPXNyo0wDtdIm5hVDIvNEP7LPxEQMlEdPWVrPERU4+SqOEeYvgwuCOaYX
	 j0ARcQhufb3k6d8d3PWGOKmBeuINU/ARJ/zwKc4mMo6drVS4wz3mgUkzVXXCcwI3+J
	 rbtyBucJyp/JGf6Lzw/SlXEsi3SLmvLt8j0Z6ZmagMuWOJYY+KTBW6zW0TJs2QyD8l
	 TjfNwcfoh9rS1/3yOKrAgiqEkyU90ozMvygS8gFJYn9Cp63HsUhdhjrRbNTPDATnR/
	 pVVIU1ybuEy1nOtlg+BFI33+08YIZa8u0d/hjzFwkjxjLIMdsj91fgQrOg0nb2g+J7
	 Nae0d/eETWZJg==
Subject: Re: [PATCH v1] ptp: idt82p33: Stop PTP work producers before teardown
From: netdev-bot+sashiko@kernel.org
To: lhfff@tju.edu.cn
Cc: richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Fri, 25 Sep 2026 05:37:38 +0000
Message-ID: <179031465830.2160803.9108448970348190131@kernel.org>
In-Reply-To: <20260922113601.855416-1-lhfff@tju.edu.cn>
References: <20260922113601.855416-1-lhfff@tju.edu.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new `stopping` gate in `idt82p33_enable()`
  (drivers/ptp/ptp_idt82p33.c:947-949) is placed before `switch…
- [Low] Missing `Fixes:` tag and `Cc: stable@vger.kernel.org` on a
  genuine use-after-free fix.

Pre-existing issues:
- [High] User-triggerable AB-BA deadlock in the very work-cancellation
  path this patch reworks, left unfixed.
- [Medium] `idt82p33_ptp_clock_unregister_all()` unconditionally calls
  `cancel_delayed_work_sync(&channel->adjtime_work)` for all MAX_PHC_PLL…
- [Medium] The teardown path drains `extts_work` and each channel's
  `adjtime_work` but does nothing about an in-flight double-DCO (ddco)…

--

ptp: idt82p33: Stop PTP work producers before teardown

This adds a stopping flag to struct idt82p33, set under the device mutex at
the head of idt82p33_ptp_clock_unregister_all(), and uses it to reject new
adjtime and enable requests while the EXTTS and per-channel adjtime work is
drained.  The extts_work cancellation is moved out of idt82p33_remove() into
the unregister helper.

A few questions below.

[Severity: Low]
The changelog describes a real use-after-free:

    "Device removal then frees the channel while its delayed work remains
    queued, causing a use-after-free."

The producer being closed is in _idt82p33_adjtime_internal_triggered():

	/* Schedule to implement the workaround in one second */
	(void)div_s64_rem(delta_ns, NSEC_PER_SEC, &remainder);
	if (remainder != 0)
		schedule_delayed_work(&channel->adjtime_work, HZ);

and struct idt82p33 is devm_kzalloc()ed in idt82p33_probe(), so the embedded
delayed_work is freed once idt82p33_remove() returns.  git blame attributes
the schedule_delayed_work() above to ad3cc7760dc45f.  Should this carry

	Fixes: ad3cc7760dc45f ("ptp: idt82p33: Add adjphase support")
	Cc: stable@vger.kernel.org

so the fix is picked up for the affected stable trees?

> diff --git a/drivers/ptp/ptp_idt82p33.c b/drivers/ptp/ptp_idt82p33.c
> index f01c50dfa44e8..ffc2ec1fc4bed 100644
> --- a/drivers/ptp/ptp_idt82p33.c
> +++ b/drivers/ptp/ptp_idt82p33.c
> @@ -918,6 +918,13 @@ static void idt82p33_ptp_clock_unregister_all(struct idt82p33 *idt82p33)
>  	struct idt82p33_channel *channel;
>  	u8 i;
>  
> +	mutex_lock(idt82p33->lock);
> +	idt82p33->stopping = true;
> +	idt82p33->extts_mask = 0;
> +	mutex_unlock(idt82p33->lock);
> +
> +	cancel_delayed_work_sync(&idt82p33->extts_work);
> +
>  	for (i = 0; i < MAX_PHC_PLL; i++) {
>  		channel = &idt82p33->channel[i];
>  		cancel_delayed_work_sync(&channel->adjtime_work);

[Severity: Medium]
This isn't a bug introduced by this patch, but since this is the teardown
function being hardened: can this cancel_delayed_work_sync() run on a
channel whose adjtime_work was never initialized?

INIT_DELAYED_WORK(&channel->adjtime_work, ...) is the last statement of
idt82p33_channel_init(), and the per-PLL loop in idt82p33_probe() breaks on
the first failure before calling this helper:

			if (idt82p33->pll_mask & (1 << i))
				err = idt82p33_enable_channel(idt82p33, i);
			else
				err = idt82p33_channel_init(idt82p33, i);
			if (err) {
				...
				break;
			}

With DEFAULT_PLL_MASK == 0x01 and MAX_PHC_PLL == 2, a failure inside
idt82p33_enable_channel(idt82p33, 0) (an i2c/regmap error, or
ptp_clock_register() failing) leaves channel[1].adjtime_work as the zeroed
devm_kzalloc() memory.  cancel_delayed_work_sync() then reaches

kernel/workqueue.c:__flush_work() {
	if (WARN_ON(!work->func))
		return false;
}

and work_grab_pending() -> try_to_grab_pending() calls timer_delete() on a
timer that never went through debug object init, which reports assert_init
with CONFIG_DEBUG_OBJECTS_TIMERS.  Would guarding the cancel, or moving the
INIT_DELAYED_WORK() so it runs for every channel before any failure is
possible, be preferable here?

[Severity: Medium]
This is a pre-existing issue, but the drain added here does not cover an
in-flight double-DCO adjustment.  idt82p33_start_ddco() programs a
transient frequency offset and relies only on the PTP aux worker to undo it:

	err = _idt82p33_adjfine(channel,
				idt82p33_ddco_scaled_ppm(current_ppm, ppb));
	if (err)
		return err;

	/* schedule the worker to cancel ddco */
	ptp_schedule_worker(channel->ptp_clock,
			    msecs_to_jiffies(duration_ms) - 1);
	channel->ddco = true;

ptp_clock_unregister() cancels rather than runs that work:

drivers/ptp/ptp_clock.c:ptp_clock_unregister() {
	if (ptp->kworker) {
		kthread_cancel_delayed_work_sync(&ptp->aux_work);
		kthread_destroy_worker(ptp->kworker);
	}
}

So if a small-delta clock_adjtime() (|delta| below phase_snap_threshold and
at least DDCO_THRESHOLD_NS) happens within the ddco duration before unbind,
idt82p33_stop_ddco() never restores channel->current_freq and the DPLL keeps
the slew offset after the driver is gone.  Should the teardown path stop an
active ddco before unregistering the clock?

> @@ -937,6 +944,10 @@ static int idt82p33_enable(struct ptp_clock_info *ptp,
>  	int err = -EOPNOTSUPP;
>  
>  	mutex_lock(idt82p33->lock);
> +	if (idt82p33->stopping) {
> +		err = -ENODEV;
> +		goto out;
> +	}
>  
>  	switch (rq->type) {
>  	case PTP_CLK_REQ_PEROUT:

[Severity: Medium]
This gate sits before the switch, so it also refuses requests with on == 0.
Since stopping is set before the ptp_clock_unregister() loop, doesn't that
mean the PTP core's own teardown disable call is now rejected?

idt82p33_ptp_clock_unregister_all()
  ptp_clock_unregister()
    ptp_disable_all_events()
      ptp_disable_pinfunc()
        ops->enable(ops, &rq{PTP_CLK_REQ_EXTTS}, 0)   -> -ENODEV

drivers/ptp/ptp_chardev.c:ptp_disable_all_events() {
	for (i = 0; i < info->n_pins; i++)
		if (info->pin_config[i].func == PTP_PF_EXTTS)
			ptp_disable_pinfunc(info, info->pin_config[i].func,
					    info->pin_config[i].chan);
}

The return value is discarded there, but idt82p33_enable() still ends with
the unconditional

	if (err)
		dev_err(idt82p33->dev,
			"Failed in %s with err %d!\n", __func__, err);

so every unbind of a device whose userspace assigned a pin to PTP_PF_EXTTS
prints "Failed in idt82p33_enable with err -19!" for a routine core call.

The second effect is on PEROUT.  A userspace perout-off landing between
stopping = true and that channel's unregistration is also refused, so
idt82p33_perout_enable() -> idt82p33_output_enable() never runs:

	if (enable)
		val &= ~SQUELCH_ENABLE;
	else
		val |= SQUELCH_ENABLE;

	return idt82p33_write(idt82p33, OUT_MUX_CNFG(outn), &val, sizeof(val));

and the chip keeps driving the output.  Would testing the arming direction
only (on && idt82p33->stopping), or setting stopping after the
ptp_clock_unregister() loop, avoid both?

[ ... ]

> @@ -1342,6 +1358,8 @@ static void idt82p33_extts_check(struct work_struct *work)
>  		return;
>  
>  	mutex_lock(idt82p33->lock);
> +	if (idt82p33->stopping)
> +		goto out;
>  
>  	for (i = 0; i < MAX_PHC_PLL; i++) {
>  		mask = 1 << i;

[Severity: High]
This is a pre-existing issue, but the new stopping check is placed after
mutex_lock(), so it cannot break an existing AB-BA cycle around
extts_work that this patch's drain now also depends on.

idt82p33_gettime() takes the mutex and calls _idt82p33_gettime(), which does:

	u8 old_mask = idt82p33->extts_mask;
	...
	/* Disable extts */
	if (old_mask)
		new_mask = idt82p33_extts_enable_mask(channel, old_mask, false);

and with enable == false that helper drains the poller while the caller
still holds the lock:

drivers/ptp/ptp_idt82p33.c:idt82p33_extts_enable_mask() {
	if (extts_mask == 0)
		return 0;

	if (enable == false)
		cancel_delayed_work_sync(&idt82p33->extts_work);
}

The work being drained is idt82p33_extts_check(), whose only pre-lock guard
is the lockless extts_mask test, and extts_mask is non-zero on this path:

	if (idt82p33->extts_mask == 0)
		return;

	mutex_lock(idt82p33->lock);
	if (idt82p33->stopping)
		goto out;

If the 95 ms poller is already blocked on that mutex_lock(), does
cancel_delayed_work_sync() wait for a callback that is waiting for the lock
the canceller holds?  The same window exists through idt82p33_adjtime() ->
_idt82p33_adjtime_internal_triggered() -> _idt82p33_gettime().

Also, because idt82p33_ptp_clock_unregister_all() now takes
mutex_lock(idt82p33->lock) first, an unbind racing a wedged gettime blocks
there as well, so the drain this patch adds would not complete.  The mutex is
the shared rsmu MFD lock (idt82p33->lock = &ddata->lock), so the other MFD
users are held off too.  Should idt82p33_extts_check() check stopping before
taking the lock, or should the cancel in idt82p33_extts_enable_mask() be
moved outside the lock?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922113601.855416-1-lhfff%40tju.edu.cn
