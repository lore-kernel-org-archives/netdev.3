Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A563C3789;
	Thu, 24 Sep 2026 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260168; cv=none; b=pHgYMtk2rLMxRj5JgfOmXmWZ2QW/d6rF8YQ4oT5FwyAafHoDNkra8D4vxT+1+k2WxjwNUY8ybMboUmPEgN31F6KcU4V2zVbqc0izg8/eyXvEYh3qEgQmL4OHJPJrpjtVWuPuS5m2+WZbq7CHpgT2SybWgeSlCTMoW1Snc3CXMsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260168; c=relaxed/simple;
	bh=0NvXIV5gFngEObPgrQFtWuTgtfKLekPJNm+/deMv0Ao=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P4cC4fGkg6XJFEYEk8mtWLMoi8BgPSXWmkWc/RSFRXCOZO2PNv3/DqSMHKcCmcuvVNC2nC5ln/bxhFLH1q7CyVJ1zth835Uf5i4UZG+XRqz9y0vftSwCV96fHHCROs+RGtEhIdo5ZrzXu2hje1la0Z0c7D4TFce1dw/TzEjOBfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiYu3iP3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiYu3iP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2551F00893;
	Thu, 24 Sep 2026 14:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790260164;
	bh=KZovxsvRE68Ry60qHGKUoGu4YUryyE2jjoF+16sSt6A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hiYu3iP3gsuCSpBfD0UX1AqisO6uELDc76gG0HE13Ge9hE7HNGv4QJMA9iazGqwj1
	 nvJiIv844UpjkrIl5won6apVZkp1FC7guyAXSGUqoWOWvnJftpZosgRNZMCG+tF2il
	 1HoGAJ4GBdpG+yiD4HKIcR0J/nuqVs93cbhcx89qhpek1SDbB6oeC7FO4yXNuGZn7/
	 gQdOaMIR58LdbBaRnMv+zJNIgNqIqeC1OYEIXOEy7qHMFmXahmZ/5S4gy2PJW3nGzr
	 M5ellIqFR81OZxrmSrRFGS7K1wkQszoe3GGF+WYuaT8hVqg11opL/MDD/CumXbR347
	 uKGnMXwvozDUA==
Subject: Re: [PATCH net-next 1/9] ptp: ocp: move the CPLD identification read
 off the sync worker
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, corbet@lwn.net, rdunlap@infradead.org,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 14:29:22 +0000
Message-ID: <179026016273.2160803.4703423361109999929@kernel.org>
In-Reply-To: <20260922142829.57740-2-maimon.sagi@gmail.com>
References: <20260922142829.57740-2-maimon.sagi@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Moving the CPLD identification read into a self-terminating
  delayed work (ptp_ocp_cpld_work()) removes the only mechanism that re-…
- [Medium] The commit message names unbind/reboot blocking as part of the
  problem being fixed ("because ptp_ocp_remove() - which is also the…
- [Low] Comments describing the per-tick re-resolution of the CPLD i2c
  adapter are no longer accurate.
- [Low] Stale comment: `#define CPLD_ID_MAX_ATTEMPTS 10 /* one per
  sync_work tick */` (drivers/ptp/ptp_ocp.c:4386) still attributes the…

--

ptp: ocp: move the CPLD identification read off the sync worker

The one-shot TAP CPLD identification read is moved out of
ptp_ocp_sync_work() into a new delayed work, ptp_ocp_cpld_work(), which is
queued from probe only on boards that carry the part.  The new work
re-arms itself once a second only while bp->cpld_id_tried is clear, and
ptp_ocp_remove() gains a cancel_delayed_work_sync() for it.

A few questions below.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 2802989e84947..4a58bcc146487 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ ... ]

> @@ -5935,18 +5937,32 @@ ptp_ocp_sync_work(struct work_struct *work)
>  
>  	bp->sync = sync;
>  
> -	/* Resolve the adapter here rather than once in probe, where it can
> -	 * race the adapter's own registration, and read the ID as soon as it
> -	 * turns up.  A claim can fail transiently - the firmware may not
> -	 * grant the segment straight after power-up - so adva_x1_cpld_read_id()
> -	 * retries a bounded number of times before giving up.
> -	 */
> +	queue_delayed_work(system_power_efficient_wq, &bp->sync_work, HZ);
> +}
> +
> +/*
> + * Resolve the i2c adapter and read the CPLD identification.
> + *
> + * Kept off ptp_ocp_sync_work(): a claim can block for seconds - the
> + * MicroBlaze handshake polls for up to MBLAZE_RETRIES * MBLAZE_RETRY_US and
> + * the hand-back does the same - which would delay the in-sync sampling and
> + * the dpll change notification, and stall the cancel_delayed_work_sync() on
> + * the unbind and shutdown paths for as long.
> + *
> + * Reschedules only while there is something left to do, so a board without
> + * the part, or one whose identification is settled, costs nothing.
> + */
> +static void ptp_ocp_cpld_work(struct work_struct *work)
> +{
> +	struct ptp_ocp *bp = container_of(work, struct ptp_ocp, cpld_work.work);
> +
>  	adva_x1_cache_i2c_adap(bp);

[Severity: Low]

This isn't a bug, but with adva_x1_cache_i2c_adap() now called only from
ptp_ocp_cpld_work(), are its comments about per-tick retries still
accurate?  Its header says:

 * Called from the worker rather than once from probe: device_add() notifies
 * before it links the device to its parent, so with asynchronous probing
 * both the notifier and a single lookup here can miss the same adapter.
 * Retrying costs a short klist walk per tick until one of them succeeds.

and its body says an adapter cached in the removal window is rejected by
adva_x1_bus_claim() "and the next tick looks again", while
adva_x1_bus_claim() says forgetting a recycled number "lets the worker look
the adapter up again".

Once bp->cpld_id_tried is set the new worker stops re-arming, so there is
no next tick and only ptp_ocp_i2c_notifier_call() can repopulate the
number - which the same header comment says can miss the adapter.

> -	if (bp->has_cpld && !READ_ONCE(bp->cpld_id_tried) &&
> -	    READ_ONCE(bp->cpld_i2c_adap_nr) >= 0)
> +	if (READ_ONCE(bp->cpld_i2c_adap_nr) >= 0)
>  		adva_x1_cpld_read_id(bp);

[Severity: Low]

This isn't a bug, but the attempt budget consumed here is still documented
against the old worker:

#define CPLD_ID_MAX_ATTEMPTS  10     /* one per sync_work tick */

The attempts are now one per cpld_work tick.

>  
> -	queue_delayed_work(system_power_efficient_wq, &bp->sync_work, HZ);
> +	if (!READ_ONCE(bp->cpld_id_tried))
> +		queue_delayed_work(system_power_efficient_wq, &bp->cpld_work,
> +				   HZ);
>  }

[Severity: High]

Does this leave the post-flash re-read of the CPLD identity without a
worker to perform it?

adva_x1_cpld_read_id() sets the flag on the first success, or after the
attempt budget runs out:

	if (!ret || ++bp->cpld_id_attempts >= CPLD_ID_MAX_ATTEMPTS)
		bp->cpld_id_tried = true;

so after the probe-time read settles the tail above stops re-arming
cpld_work, and ptp_ocp_probe() is the only other queue site.

adva_x1_cpld_flash() still clears the bookkeeping and leaves the re-read to
a periodic worker:

	/* The old image is gone from here on, so stop reporting its
	 * identity even if the rest of the sequence fails.  Written under
	 * cpld_lock, which adva_x1_cpld_read_id() also holds across its own
	 * bookkeeping, so the worker cannot resurrect any of it.
	 */
	WRITE_ONCE(bp->cpld_id, 0);
	WRITE_ONCE(bp->cpld_usercode_ok, false);
	bp->cpld_id_tried = false;
	bp->cpld_id_attempts = 0;

but it queues nothing and does not re-read the ID or USERCODE itself.

Before this patch ptp_ocp_sync_work() requeued itself every HZ for the life
of the binding, so the next tick saw the cleared flag and read the new
image's IDCODE and USERCODE.  With the split, does bp->cpld_id stay 0 and
bp->cpld_usercode_ok stay false until unbind and rebind, so
ptp_ocp_devlink_info_get() permanently skips cpld.id and reports fw.cpld as
"unknown"?

	id = READ_ONCE(bp->cpld_id);
	if (id) {
		sprintf(buf, "0x%08x", id);
	...
	if (smp_load_acquire(&bp->cpld_usercode_ok))
		sprintf(buf, "0x%08x", READ_ONCE(bp->cpld_usercode));
	else
		strscpy(buf, "unknown", sizeof(buf));

Documentation/networking/devlink/ptp_ocp.rst states:

       worker and reports the cached value here; the version is omitted
       until that read has succeeded.  The read is made once per binding
       and again after a successful CPLD update.

Would queueing bp->cpld_work from adva_x1_cpld_flash() after that reset
(queueing an already pending delayed work is a no-op) match the documented
behaviour again, or should the worker keep re-arming while bp->has_cpld?

The same concern applies to the later reset of cpld_id_tried added in
adva_x1_cache_i2c_adap() by "ptp: ocp: forget a CPLD i2c adapter number
that no longer resolves" in this series; at the end of the series the queue
sites for cpld_work are still probe plus the worker's own conditional tail.

[ ... ]

> @@ -6046,6 +6063,9 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		}
>  	}
>  	queue_delayed_work(system_power_efficient_wq, &bp->sync_work, HZ);
> +	if (bp->has_cpld)
> +		queue_delayed_work(system_power_efficient_wq, &bp->cpld_work,
> +				   HZ);
>  
>  	return 0;
>  out_dpll:

[ ... ]

> @@ -6080,6 +6100,7 @@ ptp_ocp_remove(struct pci_dev *pdev)
>  	int i;
>  
>  	cancel_delayed_work_sync(&bp->sync_work);
> +	cancel_delayed_work_sync(&bp->cpld_work);

[Severity: Medium]

Is the unbind and shutdown part of the changelog still true with this
cancel in place?  The changelog says:

    While that runs the in-sync sampling and the dpll notification are delayed
    by the same amount, and because ptp_ocp_remove() - which is also the
    .shutdown handler - begins with cancel_delayed_work_sync(&bp->sync_work),
    unbind and reboot block for it too.

and the new function comment repeats it:

 * the dpll change notification, and stall the cancel_delayed_work_sync() on
 * the unbind and shutdown paths for as long.

cancel_delayed_work_sync() waits for an already running callback to return
rather than interrupting it, so if ptp_ocp_cpld_work() is mid-claim the
executing path is:

ptp_ocp_cpld_work()
  adva_x1_cpld_read_id()
    adva_x1_bus_claim()
      adva_x1_mblaze_acquire()

	iowrite32(MBLAZE_REQUEST, &bp->pps_select->i2c_bus_ctrl);
	for (i = 0; i < MBLAZE_RETRIES; i++) {
		usleep_range(MBLAZE_RETRY_US, MBLAZE_RETRY_US + 1000);
		val = ioread32(&bp->pps_select->i2c_bus_ctrl);
		if (val == MBLAZE_GRANTED)
			return 0;
	}

That is 200 iterations of a 10 ms sleep, and on timeout
adva_x1_mblaze_release() polls the same amount again, with no teardown
escape check in either loop.  The window in which the blocking read can be
in flight is the same before and after the split, since the read is
attempted once a second until cpld_id_tried is set.

Should the changelog and the comment be narrowed to the 1 Hz in-sync
sampling and dpll notification latency, or would a teardown flag checked
before taking cpld_lock and between MicroBlaze retries let the still
required synchronous cancel return promptly?

>  	for (i = 0; i < OCP_SMA_NUM; i++) {
>  		if (bp->sma[i].dpll_pin) {
>  			dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922142829.57740-1-maimon.sagi%40gmail.com
