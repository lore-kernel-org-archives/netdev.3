Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415068;
	b=auho2q8YO389GAUL2uFHSo11XY169wi4IZlbqWeL+0pmO3rjbeXaXoB8BtbXu4+APxhV
	 lmjFZIt78qbAAQUEmpuyd+rr4gIQPW0CgXtnWDLMvFLMPACc61IMm509rRcGyvA3eW0r7
	 RAREkREpPe08UyfnTmrdvdZ72tmt+wvDcDerpPUWSyJ9DLVRdy4ajGF/0/d90o3qCd8yv
	 DciEysrMeJY8GRPSVLj0aGUJ5jnVDpPLfUdbPnQt5oVspRlDT33I9UiSIMSxCRPj/hzRO
	 Ixw2PJuwxyjUt4TnkeKX1zr1LghNNE9meRe9QHSJOj46S6rgQl5iZr3W1raBQTJB53Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415068;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=E1QHDpc/aG9SReTwqdCX+OYwneXtbq0qKQ+Vh74y2Fc=;
	b=WMgXsPjBqlrw//+M/wX9kH6W1+aj/b6PhUiyA6nqxv5DQFv9s2VUnkX1MP94sj39osMw
	 3gJASLcNe3GjIGC3wBTYo9Gldzr5HPIsmaP3EhbVBjtSDsMzYI4jStAZYDgNJ7RyTVq7j
	 +yhRoS2yON8qT2LgEUeWagQPCtPAvqDkaCVaR7R00SZsFRtyBN87uU5L/xI9Vm7NCxjfi
	 CBOyo2/83yY6tfHE0XnTcYBunJuw21B8XQmLOgX0vamE4qC335VwdQwZFVPt/wtCiN9of
	 48LbKKK+tM3k77R8uP0/+e2FoiSo9mFSWveuGvlYSyFXBrEY9e9Rpo98J0PT0Sla79A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZX1dvXd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA58606A889;
	Wed, 11 Nov 2026 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iZX1dvXd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E77C1F00A13;
	Wed, 11 Nov 2026 16:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415068;
	bh=E1QHDpc/aG9SReTwqdCX+OYwneXtbq0qKQ+Vh74y2Fc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iZX1dvXdE8G3oXJiuZCXpzW0nU5GMPALtQULiB8eGueTzpPrBYK9PKUV1Y7qp8I9n
	 bUzBvsWwohUb8HsyyfQauUUfC20j+bp2GRN8z+oibr0cdmeQMym9v6lsCdiQY8dasK
	 Vi2uQRfQkypUXQDBZc1ZrIhQGt7KOIWbEgy1Ei6fFf5pgIWyNZj6UUlthcgGA5WVwt
	 n04L0UhW0Oofo1WZWRVx4uXL44v5Aw3jJWJgy7kTEyIdG3I6Hq3qEOeh39K8Xgv/kd
	 VOKU/22hwVnb7eU5Zb2AGjOaP48BKaFGJyrrq3c43oS5SwZjEl1Jlr5Wmr+GdZJDVY
	 oJiD1wLtxi6tA==
Subject:
 Re: [PATCH net] net/sched: gred: reject table shrink with queued packets
From: netdev-bot+sashiko@kernel.org
To: shawnq1@163.com
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 11 Nov 2026 16:37:46 +0000
Message-ID: <179441506699.2199510.1043654703064770302@kernel.org>
In-Reply-To: <20261109163648.301164-1-shawnq1@163.com>
References: <20261109163648.301164-1-shawnq1@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Medium] The patch changes the result of an existing control operation.
- [Medium] The new shrink guard treats a non-zero table->tab[i]->backlog
  as meaning software skbs are still queued and gred_dequeue() will…
- [Low] The new walk over sch->gso_skb in gred_change_table_def()
  (net/sched/sch_gred.c:441-448) protects no VQ accounting, and the…
- [Low] In gred_change_table_def() (net/sched/sch_gred.c:411-413) the
  patch moves `struct gred_sched *table = qdisc_priv(sch);` below…
- [Low] On the table-definition path, gred_change()
  (net/sched/sch_gred.c:681-684) writes `sch->limit =…

--

net/sched: gred: reject table shrink with queued packets

With this commit, gred_change_table_def() returns -EBUSY when a table
shrink would remove a VQ that still has accounted backlog. It does the
same when an skb in sch->gso_skb carries a DP that is being removed. The
goal is to avoid a u32 backlog underflow in gred_dequeue() when a removed
VQ is recreated later.

Link: https://lists.openwall.net/linux-kernel/2026/10/22/1545

> diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
> index f3d9a7252949d..8ddbd7f058a6b 100644
> --- a/net/sched/sch_gred.c
> +++ b/net/sched/sch_gred.c
> @@ -408,8 +408,9 @@ static inline void gred_destroy_vq(struct gred_sched_data *q)
>  static int gred_change_table_def(struct Qdisc *sch, struct nlattr *dps,
>  				 struct netlink_ext_ack *extack)
>  {
> -	struct gred_sched *table = qdisc_priv(sch);
>  	struct tc_gred_sopt *sopt;
> +	struct gred_sched *table = qdisc_priv(sch);
> +	struct sk_buff *skb;

[Severity: Low]
This isn't a bug, but is there a reason to move the table declaration
below sopt? The old order followed the netdev reverse christmas tree
convention. Only the new struct sk_buff *skb line seems to be needed.

>  	bool red_flags_changed;
>  	int i;
>  
> @@ -437,6 +438,25 @@ static int gred_change_table_def(struct Qdisc *sch, struct nlattr *dps,
>  	}
>  
>  	sch_tree_lock(sch);
> +	skb_queue_walk(&sch->gso_skb, skb) {
> +		if (tc_index_to_dp(skb) >= sopt->DPs) {
> +			sch_tree_unlock(sch);
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "cannot remove a GRED VQ with queued packets");
> +			return -EBUSY;
> +		}
> +	}

[Severity: Low]
Does this gso_skb walk protect any VQ accounting?

GRED uses qdisc_peek_head as its .peek op, so qdisc_peek_dequeued() never
fills GRED's gso_skb. The only other writer seems to be dev_requeue_skb(),
and it runs after gred_dequeue() has already subtracted the skb from
q->backlog:

dequeue_skb()
  gred_dequeue()
    q->backlog -= qdisc_pkt_len(skb);
...
dev_requeue_skb()
  skb_queue_splice(&requeue, &q->gso_skb);

When the skb is sent again, dequeue_skb() takes it off gso_skb with
__skb_dequeue() and does not call gred_dequeue() again. The VQ backlog is
not touched a second time.

The commit message says:

    Reject a shrink while a removed VQ has accounted backlog or an skb
    in gso_skb still carries a removed DP. This keeps the per-VQ
    accounting state alive until all packets using it are drained.

Is that accurate for the gso_skb part? The only effect of this walk seems
to be a spurious -EBUSY while a requeued skb with a removed DP sits in
gso_skb.

> +
> +	for (i = sopt->DPs; i < MAX_DPs; i++) {
> +		struct gred_sched_data *q = table->tab[i];
> +
> +		if (q && q->backlog) {

[Severity: High]
Does this fully close the underflow the commit message describes? The
same "dequeue subtracts the old skb length from the new VQ's zeroed u32
backlog" case seems reachable without any table shrink.

In gred_enqueue(), the skb's DP may have no VQ while tab[t->def] is also
NULL. The skb is then passed through without charging any q->backlog,
and the tc_index rewrite is skipped:

net/sched/sch_gred.c:gred_enqueue() {
    ...
		q = t->tab[dp];
		if (!q) {
			...
			if (likely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) <=
					sch->limit))
				return qdisc_enqueue_tail(skb, sch);
    ...
}

A VQ for that DP may be created later while those skbs are still queued.
gred_change()->gred_change_vq() then installs a zeroed VQ:

		table->tab[dp] = q = *prealloc;

gred_dequeue() then finds tab[dp] != NULL and runs:

			q->backlog -= qdisc_pkt_len(skb);

This wraps the u32 backlog.

This looks like the normal configuration sequence. gred_init() only
takes the table definition, so "tc qdisc add ... gred setup vqs 4
default 0" creates no VQs. All DP 0 traffic is passed through until
"tc qdisc change ... DP 0 ..." creates VQ0 with backlog 0, while DP 0
packets are still queued.

This check only reads q->backlog of the VQs being removed. It can't see
pass-through packets, because they were never charged.

There is also a side effect. Once a VQ's backlog has wrapped, every later
shrink that would remove that VQ fails with -EBUSY until the qdisc is
reset. Before this patch, the shrink destroyed the corrupted VQ.

Could this be fixed in the datapath instead? For example, dequeue could
skip the subtraction for a VQ that never accounted the skb. That would
also cover the shrink case, without the new -EBUSY behaviour.

[Severity: Medium]
Can this make "tc qdisc change ... gred setup vqs N" fail indefinitely
under load?

Before this patch, a shrink always succeeded. Shadowed VQs were destroyed
with the "Destroying shadowed VQ" warning, so removing a VQ that still
had traffic looks like intended behaviour.

GRED uses a single FIFO. On a congested link with continuous traffic in a
removed DP, that VQ's backlog is rarely zero. There is also no way to
drain only those VQs.

The commit message only covers a drained queue ("After the queue drains,
shrinking and re-expanding succeeds"). Because of the Fixes: tag, stable
backports would also bring the new -EBUSY to existing scripts that
resize GRED tables at runtime.

The underflow only happens once the VQ is recreated. Could the
accounting be fixed at VQ creation or at dequeue instead?

[Severity: Medium]
On an offloaded GRED, does q->backlog only count software-queued skbs?

gred_offload_dump_stats() adds hardware backlog into the same field
under sch_tree_lock():

net/sched/sch_gred.c:gred_offload_dump_stats() {
    ...
		table->tab[i]->backlog += hw_stats->stats.qstats[i].backlog;
    ...
}

The nfp abm driver reports this value as the change in hardware backlog
since the previous dump:

drivers/net/ethernet/netronome/nfp/abm/qdisc.c:nfp_abm_stats_calculate() {
    ...
	qstats->backlog += new->backlog_bytes - old->backlog_bytes;
    ...
}

gred_dequeue() never subtracts the hardware part. Only a later dump with
a negative delta removes it. A shrink can therefore fail with "cannot
remove a GRED VQ with queued packets" while the software queue is empty.

The failure also continues after the hardware queue drains, until
"tc -s qdisc show" runs again. Before this patch, shrinking an offloaded
GRED always succeeded.

> +			sch_tree_unlock(sch);
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "cannot remove a GRED VQ with queued packets");
> +			return -EBUSY;

[Severity: Low]
Should this -EBUSY path leave sch->limit unchanged? gred_change() sets
the limit before it calls gred_change_table_def():

net/sched/sch_gred.c:gred_change() {
    ...
	if (tb[TCA_GRED_PARMS] == NULL && tb[TCA_GRED_STAB] == NULL) {
		if (tb[TCA_GRED_LIMIT] != NULL)
			sch->limit = nla_get_u32(tb[TCA_GRED_LIMIT]);
		return gred_change_table_def(sch, tb[TCA_GRED_DPS], extack);
	}
    ...
}

iproute2 sends both TCA_GRED_LIMIT and TCA_GRED_DPS for "tc qdisc change
... gred setup vqs N default D limit X". If that request shrinks the
table while a removed VQ has backlog, userspace gets -EBUSY, but the new
limit is already in effect.

The earlier failures in this function are input validation errors. This
one depends on how much traffic is queued at that moment, so userspace
can't predict it.

> +		}
> +	}
>  	table->DPs = sopt->DPs;
>  	table->def = sopt->def_DP;
>  	red_flags_changed = table->red_flags != sopt->flags;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109163648.301164-1-shawnq1%40163.com
