Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D20359A70
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460252; cv=none; b=pCzmt2xmkeRpSEYy1QRS++CHcD6vvOCdN3XEtic5HvdwqB6WgR1tVZAQ5K8kYOn9DHIvqhjdm8oZefwkMo9EFFCq/YzW+gM1m2AU8Cm15fQudyC6PKtIDJYZSiG2E469DPFi65cPK11PL1zHaiVSqi6gg8KMaPJut0LJ/Ex+WhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460252; c=relaxed/simple;
	bh=UaFjdMT3Hwdro+euYK9P31xkWRmOMucUzViMDFJbNqE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=peDErdXHvaQvUlCVvNBx4YfIxQ1Y7cF4PUFWZFLk0C+0lA7YsU2HG3eaBQKBahKtzEjVg2xAKDbhmqsC3zoWgpMqsfPdAoCgMNOmCxF24+Ls7qPSqqogtCJBHzOpLVwZl8Q/HPAUIbFXxtlmVrZofKHxAMz1Zq3aZZKX6uLjulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnzHbKpK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnzHbKpK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0DC1F000FF;
	Tue, 15 Sep 2026 08:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789460249;
	bh=+FTS5q0WGW0L0f2iDM6eX4+p3Jn0+1p2xJAs5jFxk1o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PnzHbKpKaM2Tb61y4jAgnPxXnpNOmjap9dL1NZHUk+vpNjIiZxHYFcf3Ysbklnf45
	 b8BRFJRjXAL2/ZWAmdrwWukjLeAHxuCUizcKdM8Px75r0UQQighpYO5QN93/1QG5r3
	 0ctMXnyldoq6OtfoUIxiMbB7jLbbJTKvuBppL0JLr2RmK0gm9Hhu7Qrwu4zsCtG/R6
	 cmS/Y41cVX8oPzYkW91ZCGL9JCNueqN9lOfqc/gGPtA26KblehKbkm/8YsaOHQIJXW
	 aSH3KOVcQOdCyGrQi534EFOYkygnI78isLDeQs3FG4kcMmY77FIg9dEZV5zzpur2Kv
	 hA5FY6a1E1yAw==
Subject: Re: [PATCH net v2 1/2] net/sched: sch_hfsc: bound the classify
 inner-filter walk with a drift budget
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, sashiko-bot@kernel.org, hybris@mojatatu.ai
Date: Tue, 15 Sep 2026 08:17:28 +0000
Message-ID: <178946024860.22033.17011861551160960190@kernel.org>
In-Reply-To: <QDISC-CTUU.v2.20260913192614@mojatatu.com>
References: <QDISC-CTUU.v2.20260913192614@mojatatu.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] net/sched/sch_hfsc.c:hfsc_classify(): the new `drift` budget
  is a *cumulative* per-packet allowance of 8 non-descending hops, not…

--

net/sched: sch_hfsc: bound the classify inner-filter walk with a drift budget

hfsc_classify() can loop forever between two interior classes when two
flowid binds that were each legal at bind time become mutually pointing
after hfsc_adjust_levels() raises a level. The patch adds a budget of
non-descending hops to the classify walk and drops the packet with a
rate-limited warning when the budget runs out.

Link: https://sashiko.dev/#/patchset/QDISC-CTUU.v1.20260908094501@mojatatu.com

> diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> index e87f5021a1995..b073efaf2bf5f 100644
> --- a/net/sched/sch_hfsc.c
> +++ b/net/sched/sch_hfsc.c
> @@ -386,6 +386,12 @@ cftree_update(struct hfsc_class *cl)
>  #define	SM_MASK		((1ULL << SM_SHIFT) - 1)
>  #define	ISM_MASK	((1ULL << ISM_SHIFT) - 1)
>  
> +/*
> + * bound on consecutive non-descending (lateral / upward) hops in a
> + * classify walk, mirroring htb's TC_HTB_MAXDEPTH headroom
> + */
> +#define	HFSC_CLASSIFY_MAX_DRIFT	8
> +
>  static inline u64
>  seg_x2y(u64 x, u64 sm)
>  {

[ ... ]

> @@ -1142,6 +1149,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
>  
>  	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>  	head = &q->root;
> +	drift = HFSC_CLASSIFY_MAX_DRIFT;
>  	tcf = rcu_dereference_bh(q->root.filter_list);
>  	while (tcf && (result = tcf_classify_qdisc(skb, tcf, &res, false)) >= 0) {
>  #ifdef CONFIG_NET_CLS_ACT
> @@ -1167,6 +1175,16 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
>  		if (cl->level == 0)
>  			return cl; /* hit leaf class */
>  
> +		/*
> +		 * flowid binds skip the level check above (res.class is set
> +		 * at bind time and levels drift after), so a walk can follow
> +		 * lateral hops without descending; bound them here.
> +		 */
> +		if (cl->level >= head->level && drift-- == 0) {
> +			pr_warn_ratelimited("hfsc: classify loop detected, dropping packet\n");
> +			return NULL;
> +		}

[Severity: Medium]
Can this drop packets for an acyclic configuration?  drift is seeded once
before the while loop in hfsc_classify() and the only mutation is the
post-decrement above, so a descending hop never returns any budget.  That
makes the budget cumulative over the whole walk rather than the bound on
"consecutive non-descending (lateral / upward) hops" the macro comment
describes, and rather than what the changelog says:

  "Bound the traversal, mirroring HTB: count only the non-descending hops"
  "a terminating lateral chain (the level-drift false-positive family)
   still classifies normally"

A terminating lateral chain longer than eight hops, or several shorter
lateral segments separated by legal descents, would exhaust the budget.
Such a chain is constructible with plain tc commands because bindings are
only checked at bind time:

net/sched/sch_hfsc.c:hfsc_bind_tcf() {
	if (cl != NULL) {
		if (p != NULL && p->level <= cl->level)
			return 0;

and levels are raised afterwards with no revalidation:

net/sched/sch_hfsc.c:hfsc_adjust_levels() {
	do {
		level = 0;
		list_for_each_entry(p, &cl->children, siblings) {
			if (p->level >= level)
				level = p->level + 1;
		}
		WRITE_ONCE(cl->level, level);
	} while ((cl = cl->cl_parent) != NULL);

So for sibling classes A1..A10, each with one leaf child, binding a filter
on A_i with flowid A_{i+1} while A_{i+1} is still a leaf passes
hfsc_bind_tcf(), and adding a child to A_{i+1} afterwards turns that hop
lateral.  Would resetting drift back to HFSC_CLASSIFY_MAX_DRIFT on every
descending hop match the documented intent?

Should this path use break instead of return NULL?  The two existing
failure exits in the same loop break out to the default class:

		if (!cl) {
			cl = hfsc_find_class(res.classid, sch);
			if (!cl)
				break; /* filter selected invalid classid */
			if (cl->level >= head->level)
				break; /* filter may only point downwards */
		}

	/* classification failed, try default class */
	cl = hfsc_find_class(TC_H_MAKE(TC_H_MAJ(sch->handle),
				       READ_ONCE(q->defcls)), sch);

With return NULL, a configured defcls leaf is skipped and hfsc_enqueue()
does qdisc_qstats_drop(sch) plus __qdisc_drop(skb, to_free).

On the macro comment itself, is "mirroring htb's TC_HTB_MAXDEPTH headroom"
accurate?  htb_classify() increments hops on every inner hop and HTB
enforces a maximum depth of TC_HTB_MAXDEPTH structurally, so its bound
cannot reject a legal walk.  HFSC caps neither class level nor hierarchy
depth, so the value 8 has no equivalent backing here.  Could the comment
and the changelog sentence "anything beyond a small budget is a cycle" be
reworded to describe the heuristic that is actually implemented?

Also, the warning text asserts "classify loop detected" on a walk where no
class has been revisited.  Would a message that reports the budget being
exhausted be more accurate?

>  		/* apply inner filter chain */
>  		tcf = rcu_dereference_bh(cl->filter_list);
>  		head = cl;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-CTUU.v2.20260913192614%40mojatatu.com
