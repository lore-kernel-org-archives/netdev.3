Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD64E0B8E
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407756; cv=none; b=GwPzXOqUhIHhtDWzJyYlLOKMa/TI2an2dSwUW5z7oJ5H94/+A4bW0NFt11fnxFkjr0MXVDWYatQ6szg1AOkBeiPtpk54xBfjKa8PXP+rZpjGrwyu0zFxibVVxhm6QI2gTPsILgPBFf1bIQdgLTXMkoRHgixm3IPHVMFr6Yq04Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407756; c=relaxed/simple;
	bh=ovDFpjSK5zrXS3tm2vqxRSTL0tLs87a5huRh3mIZqcA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLs2MvW5gdn6ShbVscJFmiUrrvWGlcwoustVqlkylE3VT6jFoglccezzIXVbUl1pGi2WO2231Q5CXSaQOQmDMugBFRl6y2F6WW94qI9F1LaGDk31jRr1/RV1ExMb3yOPHGI2v44Hf0qfnO8tbMSsasmFdmzBWnjysYfetkn3Chw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsCj65Ya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsCj65Ya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62901F000C4;
	Mon, 19 Oct 2026 11:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792407754;
	bh=uSmuzNhNojXxJzMP+669CELsIyLXirbJ7oAZfTcFMyQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MsCj65Ya1UD6sqbFd92XM2Fe8w5Fg209I/23FVwR4bT4770NXSrlHYsv6+GAnospx
	 RvQWGafpaLcAXL1JYAg0UQ0kqYlsu9CsE7FWSuAhg0mp7PyILI2LMA1nJZSXBtl0gd
	 hwZm5AK73wAz2ddQV9KRecBrdHDuP+ueMdu1M+2NbGyK7hgmV9KW46CDjLFgh2uzrf
	 SODrxgvBoGf6hK4Zr/p1xyOPzcD/t7nY3n/uVelIeerNgqOOKF3JXDXY4G0ZGc+Sw3
	 bbr3LFHb3SyV+9KiCxDIVWj8Kq346DLWcUcPkVTfVtF8kFwm0m5SGEt/Izd1Eex6eI
	 j4e/N7A1+6WgA==
Subject: Re: [PATCH net-next v2 1/4] net/sched/sch_cake: serialize
 reconfiguration with the datapath
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, toke@toke.dk, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, victor@mojatatu.com
Date: Mon, 19 Oct 2026 11:02:33 +0000
Message-ID: <179240775332.3135.11032430535974449223@kernel.org>
In-Reply-To: <QDISC-5RTM.v2.r0.20261015051735-1@mojatatu.com>
References: <QDISC-5RTM.v2.r0.20261015051735-1@mojatatu.com>
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

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message lists a torn 64-bit store of rate_bps on
  32-bit machines as effect (b) of the bug.
- [Medium] sch_cake: buffer_limit truncation wraps queue capacity at high
  bandwidths
- [Low] The commit fixes a real, user-visible lost update but has no
  Fixes: tag, and it describes itself as a 'follow-up'.
- [Low] Reproducer (a) in the commit message cannot show the bug.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  cake_mq_change() still commits the shared config without serializing…

--

net/sched/sch_cake: serialize reconfiguration with the datapath

This commit takes sch_tree_lock() in cake_change() before calling
cake_config_change(). The netlink configuration commit and
cake_reconfigure() are then serialized with the autorate-ingress rate
update in cake_enqueue(). The commit also annotates rate_bps accesses with
READ_ONCE()/WRITE_ONCE() for readers that run outside the qdisc lock.

Link: https://sashiko.dev/#/patchset/20260816012109.2865223-1-ooonea@gmail.com
Link: https://lore.kernel.org/netdev/20260816012109.2865223-1-ooonea@gmail.com/

> This is a follow-up to commit 7cbfb180945c ("net/sched: sch_cake: fix
> autorate reconfiguration throttling").  That change only stored
> last_reconfig_time; it did not address the concurrency between the
> autorate rate update in cake_enqueue() and the netlink reconfiguration
> path, which the original review flagged.

[Severity: Low]
Should this have a Fixes: tag?

Before this patch, cake_change() ran cake_config_change() with only RTNL
held. It took sch_tree_lock() only around cake_reconfigure(). The autorate
store in cake_enqueue() runs under the qdisc lock.

That second writer was added by commit 7298de9cd725 ("sch_cake: Add
ingress mode"). Commit bc0ce2bad36c ("net/sched: sch_cake: Factor out
config variables into separate struct") only moved the field into
q->config.

The referenced commit 7cbfb180945c carries "Fixes: 7298de9cd725", but
this patch has no Fixes: trailer. Without one, stable selection cannot
tell which trees need this fix.

Would Fixes: 7298de9cd725 ("sch_cake: Add ingress mode") be appropriate?

> Conditions to recreate the bug: build with CONFIG_KCSAN=y.  Two distinct
> effects are reachable.  (a) The lost update of the installed rate is
> reproducible without a sanitizer: put cake in autorate-ingress on a
> device, drive bursty traffic with gaps so the 250ms autorate
> reconfiguration fires, and concurrently loop 'tc qdisc change dev ...
> cake bandwidth <N>kbit autorate-ingress', then read the installed rate
> back and observe the estimate instead of the configured rate.

[Severity: Low]
Can recipe (a) tell a fixed kernel from an unfixed one?

The looped command ends with autorate-ingress. That sends
TCA_CAKE_AUTORATE=1, so cake_config_change() keeps the flag set:

	if (tb[TCA_CAKE_AUTORATE]) {
		if (!!nla_get_u32(tb[TCA_CAKE_AUTORATE])) {
			...
			rate_flags |= CAKE_FLAG_AUTORATE_INGRESS;

While the flag is set, cake_enqueue() is designed to overwrite rate_bps
with (avg_peak_bandwidth * 15) >> 4 once 250ms have passed since
last_reconfig_time. cake_change() never resets last_reconfig_time.

So reading the rate back through cake_config_dump() would show the
estimate both with and without this patch.

The race diagram above needs a change that clears autorate ("clears
autorate in its local rate_flags"). Should the recipe use a change that
turns autorate-ingress off instead?

The same paragraph starts with "build with CONFIG_KCSAN=y" but then says
(a) can be reproduced without a sanitizer. Could that be reworded?

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index dc93267029e70..a05da73b5f848 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1906,7 +1906,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  			if (ktime_after(now,
>  					ktime_add_ms(q->last_reconfig_time,
>  						     250))) {
> -				q->config->rate_bps = (q->avg_peak_bandwidth * 15) >> 4;
> +				WRITE_ONCE(q->config->rate_bps,
> +					   (q->avg_peak_bandwidth * 15) >> 4);

[Severity: Medium]
On 32-bit kernels, isn't this WRITE_ONCE() of a u64 still two 32-bit
stores?

The commit message lists the torn 64-bit store of rate_bps on 32-bit as
effect (b), and then says:

  plain READ_ONCE()/WRITE_ONCE() annotations cover the readers that run
  outside the lock (cake_config_dump(), which is not serialized, and the
  cake_mq shared config, observed under different child locks)

compiletime_assert_rwonce_type() accepts 64-bit types on 32-bit, but the
volatile access is still split into two halves. KCSAN treats accesses up
to sizeof(long long) as atomic. The annotation therefore silences the
report without making the access single-copy atomic.

cake_config_dump() reads rate_bps without the qdisc lock, while this
store runs under that lock:

	if (nla_put_u64_64bit(skb, TCA_CAKE_BASE_RATE64,
			      READ_ONCE(q->rate_bps), TCA_CAKE_PAD))

For cake_mq, cake_mq_change() writes the shared rate_bps through
cake_config_change() with no child lock held:

	ret = cake_config_change(&priv->cake_config, opt, extack, &overhead_changed);

Meanwhile each child reads READ_ONCE(q->config->rate_bps) in
cake_dequeue() under its own root lock. It passes the value straight to
cake_configure_rates(sch, new_rate, true). A torn value there becomes the
shaper rate until the next sync or the later cake_reconfigure().

Can both of these readers still see a torn rate_bps on 32-bit? If so,
should the commit message limit the claim to readers under the same qdisc
lock?

>  				q->last_reconfig_time = now;
>  				cake_reconfigure(sch);
>  			}

[ ... ]

> @@ -2784,9 +2786,16 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	/* Once the qdisc is live, commit and reconfigure under the lock that
> +	 * serializes the datapath, so a concurrent 'tc qdisc change' and the
> +	 * autorate update cannot lose the configured rate.
> +	 */
> +	if (qd->tins)
> +		sch_tree_lock(sch);
> +
>  	ret = cake_config_change(q, opt, extack, &overhead_changed);
>  	if (ret)
> -		return ret;
> +		goto unlock;

[Severity: Medium]
This isn't a bug introduced by this patch, but cake_mq_change() still
commits the shared config the same way cake_change() did before this
patch:

	ret = cake_config_change(&priv->cake_config, opt, extack, &overhead_changed);
	...
		if (qd->tins) {
			sch_tree_lock(chld);
			cake_reconfigure(chld);
			sch_tree_unlock(chld);
		}

cake_config_change() publishes tin_mode, rate_bps, rate_flags, flow_mode
and the other fields with only RTNL held.

Until cake_mq_change() reaches a given child, that child's cake_dequeue()
can still run the is_shared sync block under its own root lock once
sync_time has elapsed:

cake_dequeue()
  cake_configure_rates(sch, new_rate, true)
    cake_config_besteffort()    /* new tin_mode, qd->tin_cnt = 1 */

Because rate_adjust is true, cake_configure_rates() skips the tin purge:

	if (!rate_adjust) {
		...
		for (c = qd->tin_cnt; c < CAKE_MAX_TINS; c++) {
			cake_clear_tin(sch, c);

Take a diffserv8 -> besteffort change. Could packets still queued in tins
1..7 then fall outside the shaped-mode scan? cake_dequeue() would return
NULL at the "No point in going further" check with sch->q.qlen > 0 and no
watchdog scheduled. That would last until cake_reconfigure() runs for
that child and purges those tins.

The child datapaths also read q->config->rate_flags, flow_mode and
tin_mode with plain loads. The matching WRITE_ONCE() stores run under a
different lock, so the children can see a mix of old and new config.

Should cake_mq_change() get similar treatment in a follow-up?

[ ... ]

> @@ -2626,12 +2628,12 @@ static void cake_reconfigure(struct Qdisc *sch)
>  	struct cake_sched_config *q = qd->config;
>  	u32 buffer_limit;
>  
> -	cake_configure_rates(sch, qd->config->rate_bps, false);
> +	cake_configure_rates(sch, READ_ONCE(qd->config->rate_bps), false);
>  
>  	if (q->buffer_config_limit) {
>  		buffer_limit = q->buffer_config_limit;
> -	} else if (q->rate_bps) {
> -		u64 t = q->rate_bps * q->interval;
> +	} else if (READ_ONCE(q->rate_bps)) {
> +		u64 t = READ_ONCE(q->rate_bps) * q->interval;
>  
>  		do_div(t, USEC_PER_SEC / 4);
>  		buffer_limit = max_t(u32, t, 4U << 20);

[Severity: Medium]
This isn't a bug introduced by this patch, but this line is being
touched, so: t is computed as a u64 here and then handed to
max_t(u32, t, 4U << 20) two lines below. max_t() casts both operands
to u32 before it compares them. The upper 32 bits of t are therefore
thrown away rather than clamped.

After do_div(t, USEC_PER_SEC / 4), t is rate_bps * interval / 250000.
With the default 100ms rtt that is 0.4 * rate_bps. It passes U32_MAX
once rate_bps exceeds about 10.7e9 bytes/s, roughly 85.9 Gbit/s. A
larger rtt lowers the threshold in proportion; with rtt 1s it is
already reached at about 8.6 Gbit/s.

Above that point buffer_limit becomes t modulo 4GB. Right at the
threshold it drops to the 4MB floor, and it keeps cycling as the rate
grows. The final WRITE_ONCE(qd->buffer_limit, ...) takes the min()
against max(sch->limit * psched_mtu(), buffer_config_limit), which is
around 15MB with the default limit. So a higher configured rate can
end up with a smaller memory limit than a lower one. cake_enqueue()
then starts calling cake_drop() much earlier than the configuration
implies.

buffer_used is already a u64 in cake_sched_data, while buffer_limit
is still a u32. Should t be clamped in u64 before it is narrowed, for
example with min_t(u64, t, U32_MAX) ahead of the max_t()? Or should
buffer_limit be widened to match buffer_used?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-5RTM.v2.r0.20261015051735%40mojatatu.com
