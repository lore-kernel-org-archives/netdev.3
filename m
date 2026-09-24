Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C443B14D7;
	Thu, 24 Sep 2026 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260175; cv=none; b=joiE6h4ND8WWJfOQMvZMdKLCPwwc2c9WB8NYhj056tWGLxmdcnkq6xbsInhmsavzgooeoVY9Puv7NT+fqGAjzMNAChlMhHwZv+kJWnG9FB6s8ztZmZQXnweVCSeOtB6Hf8Z3LP4hcAKf6cB1/WygqAYBoOLl6kuJ2/4z2pU4mMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260175; c=relaxed/simple;
	bh=54vjJUtCjzRcpTcb0l110tu1mHO202bvaS3l6nvPEPc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xe8JdV9Y3s23oGVRHtA5I6VzzCYJeyflpH12NI/1eagoDwmW2kUiVB5JYtxdecel+rwKh4Rd7buDay+h2WRJuarEUDJbA4aTgxX+Xr0RuGEhk2EvcjF0Eas6Htk7XtV+sn6DaIH3HccK7P/tCetrQhykMu7lv9izfUErypfyJJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPgs5FSY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPgs5FSY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F881F0089B;
	Thu, 24 Sep 2026 14:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790260168;
	bh=eBIwOeloVjzIJs/J4otWj36CmSvvToGwciluH7wAY4Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iPgs5FSYP1dQOlNyYRGrKHye4s1cJzHgbQtgO8rT7pwktOqtnZOhcSKKgGB5YnQpQ
	 +FnX9tmM/UYJ3/tCdtq3ay+0B6KID9iRcAK2QG/et0HrApGPduWxl1sAXpxSqDhjgD
	 96gDEqDYY6ce6Cd9wkeeOioL8RkrOmXum2LyryJIa3XMu++ebi1DD4IQe/XSzni1rT
	 cww6yUfemyqZpz1k8+YCFmBRtAfPCl8e/AW5/7PYXi6tebH8wIfq0ucbxM/T9F5/Fy
	 Uh7EHv6Lr/BU7d9VEUPq0+VrDeL7cKQN1NRDCbRiuXuOzpIOzfy2ZqifVQYvtzGYCW
	 1DdAKQr07fPEQ==
Subject: Re: [PATCH net-next 4/9] ptp: ocp: forget a CPLD i2c adapter number
 that no longer resolves
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, corbet@lwn.net, rdunlap@infradead.org,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 14:29:27 +0000
Message-ID: <179026016715.2160803.18414234331512445641@kernel.org>
In-Reply-To: <20260922142829.57740-5-maimon.sagi@gmail.com>
References: <20260922142829.57740-5-maimon.sagi@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 2 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The re-arm of the one-shot CPLD identification added to
  adva_x1_cache_i2c_adap() (drivers/ptp/ptp_ocp.c:4618-4621) is dead…
- [High] adva_x1_bus_claim() calls the wildcard form
  adva_x1_forget_i2c_adap(bp, -1) on the i2c_get_adapter() failure path…
- [Medium] adva_x1_cache_i2c_adap() now zeroes bp->cpld_id_attempts
  unconditionally (drivers/ptp/ptp_ocp.c:4620), which silently defeats…
- [Medium] adva_x1_cache_i2c_adap() now performs an unconditional,
  uninterruptible blocking acquisition of bp->cpld_lock -…
- [Low] The patch inserts adva_x1_forget_i2c_adap() (and its own
  kerneldoc-style comment) between the pre-existing block comment that…

--

ptp: ocp: forget a CPLD i2c adapter number that no longer resolves

This adds adva_x1_forget_i2c_adap() and calls it both when i2c_get_adapter()
fails for the cached number and when the parent check rejects the adapter.
It also resets bp->cpld_id_tried and bp->cpld_id_attempts in
adva_x1_cache_i2c_adap() after a number is cached.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index feb61355078a2..45313143b6f76 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -4574,6 +4574,19 @@ static int adva_x1_i2c_adap_match(struct device *dev, const void *data)
>   * both the notifier and a single lookup here can miss the same adapter.
>   * Retrying costs a short klist walk per tick until one of them succeeds.
>   */
> +/*
> + * Forget the cached adapter number so the next sweep resolves it again.
> + * @nr < 0 forgets whatever is cached; otherwise only that number, so a
> + * caller that raced the notifier cannot clear a newer one.
> + */
> +static void adva_x1_forget_i2c_adap(struct ptp_ocp *bp, int nr)
> +{
> +	scoped_guard(spinlock, &bp->cpld_adap_lock) {
> +		if (nr < 0 || bp->cpld_i2c_adap_nr == nr)
> +			bp->cpld_i2c_adap_nr = -1;
> +	}
> +}
> +

[Severity: Low]

Was the placement of the new helper intended here?  The pre-existing block
comment that ends with "Retrying costs a short klist walk per tick until one
of them succeeds." describes adva_x1_cache_i2c_adap(), but it now sits
directly above adva_x1_forget_i2c_adap(), which does not walk any klist and
is called from adva_x1_bus_claim() rather than from the worker tick.

adva_x1_cache_i2c_adap() is left with no header comment at all.  Would moving
the helper (with its own comment) above that block, or below
adva_x1_cache_i2c_adap(), keep each comment attached to the function it
describes?

>  static void adva_x1_cache_i2c_adap(struct ptp_ocp *bp)
>  {
>  	struct device *child;
> @@ -4598,6 +4611,15 @@ static void adva_x1_cache_i2c_adap(struct ptp_ocp *bp)
>  			bp->cpld_i2c_adap_nr = i2c_verify_adapter(child)->nr;
>  	}
>  
> +	/* A different adapter may answer differently, so let the one-shot
> +	 * identification run again rather than leaving cpld.id absent for
> +	 * the rest of the binding.
> +	 */
> +	scoped_guard(mutex, &bp->cpld_lock) {
> +		bp->cpld_id_tried = false;
> +		bp->cpld_id_attempts = 0;
> +	}
> +

[Severity: High]

Can this re-arm ever clear a flag that was actually set?

adva_x1_cache_i2c_adap() has a single caller, ptp_ocp_cpld_work(), and that
worker only re-queues itself while the flag is clear:

ptp_ocp_cpld_work() {
	adva_x1_cache_i2c_adap(bp);
	if (READ_ONCE(bp->cpld_i2c_adap_nr) >= 0)
		adva_x1_cpld_read_id(bp);

	if (!READ_ONCE(bp->cpld_id_tried))
		queue_delayed_work(system_power_efficient_wq, &bp->cpld_work,
				   HZ);
}

The only writer that sets it is adva_x1_cpld_read_id(), which is itself only
called from that worker:

	if (!ret || ++bp->cpld_id_attempts >= CPLD_ID_MAX_ATTEMPTS)
		bp->cpld_id_tried = true;

So once cpld_id_tried is true the worker is never queued again, and every
time the new scoped_guard runs, cpld_id_tried is already false.

The commit message says "leaving cpld_id_tried set kept cpld.id absent for
the rest of the binding".  In that state - identification gave up and a
different adapter shows up afterwards - ptp_ocp_i2c_notifier_call() publishes
the new number:

		if (bp->i2c_ctrl && adap->dev.parent == &bp->i2c_ctrl->dev) {
			scoped_guard(spinlock, &bp->cpld_adap_lock)
				bp->cpld_i2c_adap_nr = adap->nr;
		}

but it neither clears cpld_id_tried/cpld_id_attempts nor queues cpld_work,
and the only other queue_delayed_work(&bp->cpld_work) is the one-time call in
probe.  Does cpld.id therefore still stay 0 for the rest of the binding,
leaving the reset here unreachable for the case it is meant to fix?

[Severity: Medium]

Does zeroing bp->cpld_id_attempts here remove the CPLD_ID_MAX_ATTEMPTS bound
enforced in adva_x1_cpld_read_id()?

The reset is unconditional and sits outside the spinlock section that caches
a number, so it also fires when the locked re-test cached nothing (because
the notifier published a number meanwhile), and it never compares the newly
cached number with the one identification already failed on.  The comment
says "A different adapter may answer differently", but an identical re-cache
wipes the budget too.

Combined with the new forget on !adap in adva_x1_bus_claim(), can this repeat
per tick?  i2c_del_adapter() clears the idr entry before it unregisters the
device:

drivers/i2c/i2c-core-base.c:i2c_del_adapter() {
	mutex_lock(&core_lock);
	found = idr_find(&i2c_adapter_idr, adap->nr);
	if (found == adap)
		idr_replace(&i2c_adapter_idr, NULL, adap->nr);
	mutex_unlock(&core_lock);
	...
	device_unregister(&adap->dev);
}

In that window i2c_get_adapter() returns NULL, so the claim forgets the
number, while device_find_child(&bp->i2c_ctrl->dev, ...) still finds the
adapter child, so the next tick re-caches it and resets the counter to 0.
Each of those ticks performs another bus claim with adva_x1_mblaze_acquire()
polling the grant with the i2c root adapter lock held, and cpld_id_tried can
never latch.

If the retry budget is meant to be dropped here, could the changelog say so,
and could the struct field comment describing cpld_id_tried as a "one-shot ID
read finished, successfully or not" be updated to match?

[Severity: Medium]

Should the worker block uninterruptibly on cpld_lock here?  The rest of the
driver avoids exactly that on this path:

adva_x1_cpld_read_id() {
	if (!mutex_trylock(&bp->cpld_lock))
		return -EBUSY;

cpld_status_show() {
	/* A CPLD operation can hold cpld_lock a long time; stay killable. */
	ret = mutex_lock_interruptible(&bp->cpld_lock);

adva_x1_cpld_flash() holds cpld_lock across the whole programming sequence -
a config-sector erase alone waits up to CPLD_ERASE_MS and the page loop can
write CPLD_MAX_IMAGE_SZ / CPLD_PAGE_SIZE pages, each with its own wait - so
can the worker sleep here for tens of seconds or more?

Two knock-on effects: ptp_ocp_remove() does
cancel_delayed_work_sync(&bp->cpld_work) and inherits that wait, and the
child reference from device_find_child() is still held across the new guard
because put_device(child) only runs after it, so
i2c_del_adapter()'s wait_for_completion(&adap->dev_released) waits for the
same period.

Since only i2c_verify_adapter(child)->nr is used, and that happens inside the
earlier spinlock block, could put_device(child) move ahead of this section,
and could the acquisition follow the trylock pattern the worker already uses?

>  	put_device(child);
>  }
>  
> @@ -4614,8 +4636,14 @@ static int adva_x1_bus_claim(struct ptp_ocp *bp)
>  	lockdep_assert_held(&bp->cpld_lock);
>  
>  	adap = i2c_get_adapter(READ_ONCE(bp->cpld_i2c_adap_nr));
> -	if (!adap)
> +	if (!adap) {
> +		/* The adapter behind the cached number is gone.  Forget it,
> +		 * or adva_x1_cache_i2c_adap() keeps bailing out on its first
> +		 * test and never resolves the adapter again.
> +		 */
> +		adva_x1_forget_i2c_adap(bp, -1);
>  		return -ENODEV;
> +	}

[Severity: High]

Can the wildcard form here discard a number the notifier just published?

The helper's own comment says the nr >= 0 form exists so that "a caller that
raced the notifier cannot clear a newer one", but this call site passes -1,
which forgets whatever is cached.  The number is sampled with READ_ONCE() and
i2c_get_adapter() then sleeps on the i2c core_lock, so the decision to clear
is based on a value read outside the critical section:

CPU0 adva_x1_bus_claim()
	adap = i2c_get_adapter(READ_ONCE(bp->cpld_i2c_adap_nr));  /* sleeps */

CPU1 ptp_ocp_i2c_notifier_call(), BUS_NOTIFY_ADD_DEVICE
		if (bp->i2c_ctrl && adap->dev.parent == &bp->i2c_ctrl->dev) {
			scoped_guard(spinlock, &bp->cpld_adap_lock)
				bp->cpld_i2c_adap_nr = adap->nr;
		}

CPU0 resumes with !adap
		adva_x1_forget_i2c_adap(bp, -1);   /* nr = -1 again */

The notifier only takes cpld_adap_lock, so cpld_lock does not serialise it
against the claim path.  The common case looks like the sampled value already
being -1: cpld_status_show() or adva_x1_cpld_flash() then calls
i2c_get_adapter(-1), gets NULL, and clears whatever was published meanwhile.

Recovery only exists while ptp_ocp_cpld_work() is still re-queued.  Once
cpld_id_tried is set the worker stops, the notifier will not re-announce an
already registered adapter, and cpld_i2c_adap_nr stays -1, so later CPLD
accesses return -ENODEV - the failure mode this commit is closing.

Would passing the number that was actually sampled, and skipping the call
when that sample was already negative, avoid this?

>  
>  	/* The number is freed before the notifier clears it, so it can
>  	 * already be another adapter's.  Check this is still ours, and drop
> @@ -4623,10 +4651,7 @@ static int adva_x1_bus_claim(struct ptp_ocp *bp)
>  	 * way, where forgetting it lets the worker look the adapter up again.
>  	 */
>  	if (!bp->i2c_ctrl || adap->dev.parent != &bp->i2c_ctrl->dev) {
> -		scoped_guard(spinlock, &bp->cpld_adap_lock) {
> -			if (bp->cpld_i2c_adap_nr == adap->nr)
> -				bp->cpld_i2c_adap_nr = -1;
> -		}
> +		adva_x1_forget_i2c_adap(bp, adap->nr);
>  		i2c_put_adapter(adap);
>  		return -ENODEV;
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922142829.57740-1-maimon.sagi%40gmail.com
