Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1003BED32
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 05:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791610612; cv=none; b=i4gH8W413yR37fvTq09S9LcgW2Mtn88JTSiVWilS312fc+7Z4s/b/arVgg2Y9jk8MJK8q6GKzwq1J+fLcuiYARPmymrY/ARAJsNf7zOQ6Nm16KyFaxmL3SLB9YlOWTPkwvtGKWN2LWp3816EoEMI9vEgjsCrVAa6oQ8iCgEE8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791610612; c=relaxed/simple;
	bh=2UBKq6fMtDM9EZeGB5XQfEcMgVjRuLqjsT4LqFSLT4g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LeBWYKdV902WUhssNU8RUJlvdlaffD0wTX8EmI1aPSl1KisZer32WTBmR4bWWawlExbRZbu1qHuDMMiGLSd18j8ouaW4DGr/nxp2t1Q3i/QEeBT1W9enJplGCl4PFVfczjQopjTknSN1699HSo6vLxjYXI0bLqZmLuKKWpxj7l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eynJVJzO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eynJVJzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA101F00893;
	Sat, 10 Oct 2026 05:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791610611;
	bh=cvr/wqHXLbNWZObltdSzu48ZtSvGttnKgp1JHabMuvI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eynJVJzOKCaJAPDg0Ul/l7v7LraIz4uLMSKyMu79XnemSSBk27IdiWYDpm56M9XOV
	 r/IkIQlMVD7p6a7E6ISt4La38uF+THPLOfN5rVd5apmnzy76Fdg4D+xGbhNlIeMfMU
	 VNsSqp+UgdUkyJyXV+rRsglpUSWn+rsE4QearmiAEGQsZLrYWVIRUjcp/ms7NZMvSU
	 UoxdCWmvwvHxVu/qsyR4VAZbqCLWN1AUZ3KE07B1SThCmy884wgbZ5w7ZBmrh9AEgc
	 oHOvvJMu/sEXagegpFUj3HFI0n1NBdXgUxzwxce41REaXp94nVaVP3QCDkq/BZt0jU
	 0tGYcjlKflV+g==
Subject: Re: [PATCH net-next 1/2] net/sched: honor
 TCA_ACT_FLAGS_NO_PERCPU_STATS in more actions
From: netdev-bot+sashiko@kernel.org
To: acassen@corp.free.fr
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
Date: Sat, 10 Oct 2026 05:36:50 +0000
Message-ID: <179161061024.434549.7317813587026825277@kernel.org>
In-Reply-To: <20261009051930.3619697-2-acassen@corp.free.fr>
References: <20261009051930.3619697-2-acassen@corp.free.fr>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] With TCA_ACT_FLAGS_NO_PERCPU_STATS set, police, skbedit and
  sample now create actions with a->cpu_bstats == NULL, using…
- [Low] The commit message gets the scope of the race wrong in several
  places: (1) It says only 'gact and mirred carry this same race today'.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but replacing a
  police action's existing rate estimator can deadlock.

--

net/sched: honor TCA_ACT_FLAGS_NO_PERCPU_STATS in more actions

This commit switches skbedit, police, mpls and sample to
tcf_idr_create_from_flags(). With TCA_ACT_FLAGS_NO_PERCPU_STATS set, these
actions no longer allocate per-CPU stats. Their datapath counter updates
are converted to tcf_action_update_bstats() and the qstats helpers, which
fall back to tcfa_lock and atomics when the per-CPU counters are absent.

> skbedit, police, mpls and sample store and dump
> TCA_ACT_FLAGS_NO_PERCPU_STATS since commit 40bd094d65fc ("flow_offload:
> fill flags to action structure"), but still allocate per CPU stats.

[ ... ]

> problem is the hardware stats path used when an action is offloaded but
> skip_sw is not set: tcf_action_update_stats() writes the same counters
> without holding tcfa_lock, so the two paths can race on tcfa_bstats.
> gact and mirred carry this same race today, these actions only come in
> line with them. I will send a separate patch to fix it.

[Severity: Low]
I have a few questions about the scope described here.

ct, gate, pedit and vlan also create actions with
tcf_idr_create_from_flags(), and their .stats_update callbacks call
tcf_action_update_stats(). Don't they have the same race as gact and
mirred?

act_mpls_ops has no .stats_update callback, so mpls never reaches
tcf_action_update_stats(). Should mpls be left out of the list of actions
that come "in line with" the racy ones?

The race also seems reachable for software-only filters, and for skip_sw
filters through concurrent filter gets, not only for offloaded actions
without skip_sw. The comment on tcf_police_init() below has the details.

"I will send a separate patch to fix it." reads like a cover-letter
remark. Should it go below the --- line so it doesn't end up in the git
history?

[ ... ]

> diff --git a/net/sched/act_police.c b/net/sched/act_police.c
> index 3f8147f375493..0b0c09e3dfd93 100644
> --- a/net/sched/act_police.c
> +++ b/net/sched/act_police.c
> @@ -80,8 +80,8 @@ static int tcf_police_init(struct net *net, struct nlattr *nla,
>  		return ACT_P_BOUND;
>  
>  	if (!exists) {
> -		ret = tcf_idr_create(tn, index, NULL, a,
> -				     &act_police_ops, bind, true, flags);
> +		ret = tcf_idr_create_from_flags(tn, index, NULL, a,
> +						&act_police_ops, bind, flags);

[Severity: Medium]
With no_percpu set, police, skbedit and sample now have
a->cpu_bstats == NULL. Each of them has a .stats_update callback
(tcf_police_stats_update(), tcf_skbedit_stats_update(),
tcf_sample_stats_update()) that ends up in tcf_action_update_stats().
The non-percpu branch of that function writes the shared counters without
taking tcfa_lock:

net/sched/act_api.c:tcf_action_update_stats() {
    ...
	_bstats_update(&a->tcfa_bstats, bytes, packets);
	atomic_add(drops, &a->tcfa_drops);
	if (hw)
		_bstats_update(&a->tcfa_bstats_hw, bytes, packets);
}

The datapath writer, tcf_action_update_bstats(), holds
spin_lock(&a->tcfa_lock). The hardware stats callers,
tcf_exts_hw_stats_update() and tcf_action_update_hw_stats(), only
disable preemption.

Since u64_stats_sync needs writers to be mutually exclusive, can this
lose byte/packet updates to tcfa_bstats, or tear them on 32-bit?

The race doesn't seem to need hardware offload. fl_dump() calls
fl_hw_update_stats() whenever skip_hw is clear, and mall_dump() does the
same. For a filter that isn't offloaded, tcf_exts_hw_stats_update() still
calls this for every action, with zero stats:

	preempt_disable();
	tcf_action_stats_update(a, stats->bytes, stats->pkts, stats->drops,
				stats->lastused, true);
	preempt_enable();

So a default software-only flower filter with a no_percpu police action
would do an unlocked read-modify-write of tcfa_bstats on every dump,
while packets on other CPUs update the same counter under tcfa_lock.

The skip_sw case from the commit message example is also exposed.
RTM_GETTFILTER is RTNL_FLAG_DOIT_UNLOCKED, and fl_hw_update_stats() runs
after tp->lock is dropped, so two concurrent filter gets can both write
tcfa_bstats.

Before this patch, each writer updated its own this_cpu_ptr() slot.
Should the non-percpu branch of tcf_action_update_stats() take tcfa_lock
before no_percpu is honored for these actions?

>  		if (ret) {
>  			tcf_idr_cleanup(tn, index);
>  			return ret;

[Severity: High]
This isn't a bug introduced by this patch, but can replacing the
estimator on an existing police action deadlock?

Further down, tcf_police_init() passes the action lock as the estimator
stats lock. It is the only gen_replace_estimator() caller that passes a
non-NULL lock:

	err = gen_replace_estimator(&police->tcf_bstats,
				    police->common.cpu_bstats,
				    &police->tcf_rate_est,
				    &police->tcf_lock,
				    false, est);

gen_new_estimator() then waits for the old timer while it holds that
lock:

net/core/gen_estimator.c:gen_new_estimator() {
    ...
	if (lock)
		spin_lock_bh(lock);
	old = rcu_dereference_protected(*rate_est, 1);
	if (old) {
		timer_delete_sync(&old->timer);
    ...
}

The old estimator's stats_lock is also &police->tcf_lock, and its timer
callback takes it:

est_timer()
  est_fetch_counters()
    spin_lock(e->stats_lock);

This sequence looks possible:

CPU A                                  CPU B
                                       est_timer() starts (old estimator)
tcf_police_init()
  gen_new_estimator()
    spin_lock_bh(&police->tcf_lock)
                                       est_fetch_counters()
                                         spin_lock(&police->tcf_lock)
                                         spins
    timer_delete_sync(&old->timer)
      __timer_delete_sync() loops
      waiting for est_timer()

Neither CPU can make progress. To trigger it, run "tc actions replace
action police ... estimator ... index N" on a police action that already
has an estimator.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009051930.3619697-1-acassen%40corp.free.fr
