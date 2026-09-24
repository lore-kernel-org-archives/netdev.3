Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6C6366546;
	Thu, 24 Sep 2026 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260176; cv=none; b=CLNlMNpu4CIJyrORqSYOA1rN0aAUUK4bCFj3r7h3tScGEvh639BmwjfLB5Fl2djFSTZG7za1x6k0jgmmjynj6M6MR+94XX6MMwyt7TRKI+7Gj+3UrrAwTHQ9UpQqxncf/6TR/Tra8WSgH2eky6UcGBp3UCyxg2SIuEKu1i6IDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260176; c=relaxed/simple;
	bh=y+HOsHmcvk2FB9sXpLl3UGfNtNCH0XrHJajJt7vo3gQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CLUI4c90itdfHS4pDekV2lZEHidu/U2LlGlgr/PxeYYOmSYI0EWlvpL3xxLjNixU5UsPxIsrigFhcKu74cYJo4ic4ckujTBCIj04uDta8N8rygZCRkX9a8OeAeeiwN08i209vGrilzBlkdEq3nCcEcJ1KfKCt9M3ISAmpsy0K5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/W5Wut5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/W5Wut5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404201F00893;
	Thu, 24 Sep 2026 14:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790260170;
	bh=5xPGLMh4eCNlzVtbo0R1Sk4v+fg1q+RbjrViBKO8yfA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B/W5Wut5WmgTS8+x6eR7Ifdd0zRQGKBlX3O8MuDrcdeWOUkWNAzZPa986XNQ4aFj7
	 3gWzmCA75uEaMmCwa2zQUApu90CT6DTxdOjB0Z8K9N428yg6Lajnb+KAV4XcOrA9fy
	 1ks1YyUw2F+t60v6RQZL7xPMpnTxJ2JgpSyV+dWXSqwpnvhC1RsNoFZG0yFhTc/piB
	 jeNa/w+bSS8gL/Fpe3hz7lVKmFuWBVS1x/hlQ6xeQRs40eAGdoQBX30a+BZXm/HOcR
	 AIRdR/eLVwbjaRgoabqZTOtVQCaB0bh1V/66LrWb5h9YmnvKjn7B2qwwxAoYzn4gSF
	 /xRa0uj6Rz2ow==
Subject: Re: [PATCH net-next 5/9] ptp: ocp: correct the CPLD bookkeeping
 comments and the flash progress
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, corbet@lwn.net, rdunlap@infradead.org,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 14:29:28 +0000
Message-ID: <179026016884.2160803.3459773408972054792@kernel.org>
In-Reply-To: <20260922142829.57740-6-maimon.sagi@gmail.com>
References: <20260922142829.57740-6-maimon.sagi@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Inconsistent memory-access annotation for cpld_i2c_adap_nr:
  the patch rewrites the struct comment to state that readers of…
- [Medium] The new cpld_id_tried comment claims "the worker reads it
  unlocked, where a stale value only costs one extra attempt", but the…
- [Low] Stale comment naming the wrong work item: CPLD_ID_MAX_ATTEMPTS is
  documented as "/* one per sync_work tick */" (line 4406), but…

--

ptp: ocp: correct the CPLD bookkeeping comments and the flash progress

This rewrites the struct ptp_ocp member comments for cpld_i2c_adap_nr and
cpld_id_tried to describe serialised writers with lock-free readers, and
converts the cpld_id_tried stores to WRITE_ONCE().  It also changes the
CPLD flash progress notification to report bytes written rather than the
offset of the page just written.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 45313143b6f76..e10f6b5149c93 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -428,9 +428,12 @@ struct ptp_ocp {
>  	/* adva_x1 CPLD I2C (internal use only) */
>  	/* serialises CPLD operations */
>  	struct mutex		cpld_lock;
> -	/* guards cpld_i2c_adap_nr against the bus notifier */
> +	/* serialises the cpld_i2c_adap_nr writers against each other */
>  	spinlock_t		cpld_adap_lock;
> -	/* I2C adapter nr; -1 if absent.  Under cpld_adap_lock */
> +	/* I2C adapter nr, -1 if absent.  Writers hold cpld_adap_lock;
> +	 * readers take no lock and re-validate what they got, since the
> +	 * number can be recycled - see adva_x1_bus_claim().
> +	 */
>  	int			cpld_i2c_adap_nr;

[Severity: Medium]
The new comment states that readers of cpld_i2c_adap_nr take no lock, and
the same reasoning is used in this patch to convert the cpld_id_tried stores
to WRITE_ONCE().  Should the cpld_i2c_adap_nr stores get the same treatment?

The three readers are all unlocked and marked:

adva_x1_cache_i2c_adap()
	if (!bp->has_cpld || !bp->i2c_ctrl ||
	    READ_ONCE(bp->cpld_i2c_adap_nr) >= 0)
		return;

adva_x1_bus_claim()
	adap = i2c_get_adapter(READ_ONCE(bp->cpld_i2c_adap_nr));

ptp_ocp_cpld_work()
	if (READ_ONCE(bp->cpld_i2c_adap_nr) >= 0)
		adva_x1_cpld_read_id(bp);

while every store stays a plain store:

adva_x1_forget_i2c_adap()
	scoped_guard(spinlock, &bp->cpld_adap_lock) {
		if (nr < 0 || bp->cpld_i2c_adap_nr == nr)
			bp->cpld_i2c_adap_nr = -1;
	}

adva_x1_cache_i2c_adap()
	scoped_guard(spinlock, &bp->cpld_adap_lock) {
		if (bp->cpld_i2c_adap_nr < 0)
			bp->cpld_i2c_adap_nr = i2c_verify_adapter(child)->nr;
	}

ptp_ocp_i2c_notifier_call()
	scoped_guard(spinlock, &bp->cpld_adap_lock)
		bp->cpld_i2c_adap_nr = adap->nr;
	...
	scoped_guard(spinlock, &bp->cpld_adap_lock) {
		if (bp->cpld_i2c_adap_nr == adap->nr)
			bp->cpld_i2c_adap_nr = -1;
	}

cpld_adap_lock excludes the other writers only, so an i2c adapter add or
remove running the notifier while ptp_ocp_cpld_work() or
adva_x1_cache_i2c_adap() performs its READ_ONCE() is a plain-store against
marked-load pair that KCSAN reports on the write side.

An aligned int is not expected to tear on supported architectures, and
adva_x1_bus_claim() re-validates via adap->dev.parent, so is the remaining
issue just that the annotation is now inconsistent with the contract the
comment describes?

> @@ -442,9 +445,12 @@ struct ptp_ocp {
>  	u32			cpld_usercode;
>  	/* cpld_usercode has been read since the last flash */
>  	bool			cpld_usercode_ok;
> -	/* one-shot ID read finished, successfully or not; under cpld_lock */
> +	/* one-shot ID read finished, successfully or not.  Written under
> +	 * cpld_lock; the worker reads it unlocked, where a stale value only
> +	 * costs one extra attempt.
> +	 */
>  	bool			cpld_id_tried;
> -	/* failed ID read attempts so far; under cpld_lock */
> +	/* failed ID read attempts so far; cpld_lock */
>  	unsigned int		cpld_id_attempts;

[Severity: Low]
While the annotation of cpld_id_attempts is being updated here, should the
comment on the macro that bounds it be updated too?  It still says:

#define CPLD_ID_MAX_ATTEMPTS  10     /* one per sync_work tick */

cpld_id_attempts is incremented only in adva_x1_cpld_read_id(), whose only
caller is ptp_ocp_cpld_work(), and the comment above that worker says the
opposite in the same file ("Kept off ptp_ocp_sync_work()").
ptp_ocp_sync_work() no longer touches any CPLD state, so the budget is
consumed one per cpld_work tick.

The comment was accurate before the CPLD identification was moved off the
sync worker earlier in this series; the tree now has two comments about the
same counter naming different workers.

[ ... ]

> @@ -5047,7 +5053,7 @@ static int adva_x1_cpld_flash(struct ptp_ocp *bp, struct devlink *devlink,
>  	 */
>  	WRITE_ONCE(bp->cpld_id, 0);
>  	WRITE_ONCE(bp->cpld_usercode_ok, false);
> -	bp->cpld_id_tried = false;
> +	WRITE_ONCE(bp->cpld_id_tried, false);
>  	bp->cpld_id_attempts = 0;

[Severity: Medium]
Two questions about cpld_id_tried here.

First, the new struct comment says a stale unlocked read "only costs one
extra attempt".  In the stale-true direction, does it not cost all of the
remaining attempts?  ptp_ocp_cpld_work() re-arms itself only while the flag
reads false:

	if (!READ_ONCE(bp->cpld_id_tried))
		queue_delayed_work(system_power_efficient_wq, &bp->cpld_work,
				   HZ);

Second, does anything consume this reset after a flash?

adva_x1_cpld_read_id() has a single caller, ptp_ocp_cpld_work(), and
cpld_work is queued from only two places: ptp_ocp_register_resources() and
that self-requeue above.  The worker stops as soon as the ID read succeeds,
roughly a second after probe, and adva_x1_cpld_flash() clears the flags but
never queues cpld_work:

	WRITE_ONCE(bp->cpld_usercode_ok, false);
	WRITE_ONCE(bp->cpld_id_tried, false);
	bp->cpld_id_attempts = 0;

With no live worker left to read the flag, does cpld_usercode_ok stay false
for the rest of the binding, so ptp_ocp_devlink_info_get():

	if (smp_load_acquire(&bp->cpld_usercode_ok))
		sprintf(buf, "0x%08x", READ_ONCE(bp->cpld_usercode));
	else
		buf[0] = '\0';

reports fw.cpld with an empty value after a successful flash until the
driver is rebound?

At the baseline the identification ran from ptp_ocp_sync_work(), which
requeued unconditionally every HZ, so the same reset did trigger a re-read.
The peer reset in adva_x1_cache_i2c_adap() still works because it runs
inside the live worker.  Would queueing cpld_work after clearing
cpld_id_tried in adva_x1_cpld_flash() restore the re-identification?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922142829.57740-1-maimon.sagi%40gmail.com
