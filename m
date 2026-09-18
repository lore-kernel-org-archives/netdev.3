Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B494B7A53
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729170; cv=none; b=IE0/Sdgj/pfLA9UJUwkR7leL2VFvEWgHOmFSuVaX1vH6e+A4hARsPSBotST4oXRLIGKbl3tELc0Ac0F9a5uyqa9QPEEzapIWPEtC/ZMxrDhf3tZZNgIUZvY/EjkUtfQZN1smPyIEdLvkHAq+k3u4cWyVOtYM4G/nYExIB9VDxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729170; c=relaxed/simple;
	bh=AcDFCafRo2dWzqDrygtj4E/BQkmkjXu8068HVPZ47WY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UFo1z0z1rX/6okR77TIj3svZILI9X7tuQePVh+p/SPrBRZt4sLj/qXIVgjG8sC52RxY0bNJb4RLZNbvng4NkXqPJu0LJGWIuFGyO9QNHnUg2S0wFUWqTZDUojjtv8yHi5fmWWa7KeWQs9SkE83B0y170ws9S4ZnxVxIm2IEUddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbunNsJm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbunNsJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F741F00893;
	Fri, 18 Sep 2026 10:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789729168;
	bh=TGf9DS3bELe5EjqZiMRaxNC5L4u3dD6FgIx0hvAw/ZA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WbunNsJmt7MNrpb0IRYUOMJIBcKmvRsGNP2Mxw/gCeV7JMbXitQyu28/CYhFKbXf3
	 mKdLVLkuiYaM8/jdT7Zqdu7+UYmEzNKFSn2JEdZZ8s59YE5hT3DiELDRYYG42jtVbC
	 WZU+j/Jpc/rifcytr3O70oNy3xIo/XnTLtawhGHRhMYoS3OAlQm5bYX/DmCO9jRTUy
	 8J41ZIAF+7dscck0W/y1fCZIuThpvXXR3UV8BoXl6gHBJD73WE3Sb9hQ5aKI80bZM1
	 kbeMTdy7vAbM6bhvq+lqtys+LHupylEszUtI+tV0lKGO1f/LHeIVEkQanIJbmW7q9+
	 RHpkNu8n+vJFQ==
Subject: Re: [PATCH net v3 1/2] net/sched: sch_hfsc: bound the classify
 inner-filter walk with a drift budget
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, hybris@mojatatu.ai, sashiko-bot@kernel.org
Date: Fri, 18 Sep 2026 10:59:27 +0000
Message-ID: <178972916706.22033.3797727234207529111@kernel.org>
In-Reply-To: <QDISC-CTUU.v3.20260916184908@mojatatu.com>
References: <QDISC-CTUU.v3.20260916184908@mojatatu.com>
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

- [Medium] net/sched/sch_hfsc.c: the new drift budget in hfsc_classify()
  conflates "budget exhausted" with "the chain cycles", and the two new…

--

net/sched: sch_hfsc: bound the classify inner-filter walk with a drift budget

The patch adds a budget of non-descending hops to the hfsc_classify()
inner-filter walk so that a filter chain made cyclic by post-bind level
drift can no longer spin with the qdisc lock held.  Once the budget is
exhausted the packet is dropped with a rate-limited warning.

Link: https://sashiko.dev/#/patchset/QDISC-CTUU.v2.20260913192614@mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-CTUU.v2.20260913192614%40mojatatu.com

> diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> index e87f5021a1995..284490fd6ca91 100644
> --- a/net/sched/sch_hfsc.c
> +++ b/net/sched/sch_hfsc.c
> @@ -386,6 +386,15 @@ cftree_update(struct hfsc_class *cl)
>  #define	SM_MASK		((1ULL << SM_SHIFT) - 1)
>  #define	ISM_MASK	((1ULL << ISM_SHIFT) - 1)
>  
> +/*
> + * Cap on the non-descending hops a classify walk may take before its
> + * filter chain is treated as misconfigured. A flowid binding that was
> + * legal at bind time can become lateral once hfsc_adjust_levels()
> + * raises a class level; a few such hops are legitimate, an unbounded
> + * run means the chain cycles.
> + */
> +#define	HFSC_CLASSIFY_MAX_DRIFT	8
> +
>  static inline u64
>  seg_x2y(u64 x, u64 sm)
>  {
> @@ -1133,6 +1142,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
>  	struct hfsc_class *head, *cl;
>  	struct tcf_result res;
>  	struct tcf_proto *tcf;
> +	unsigned int drift;
>  	int result;
>  
>  	if (TC_H_MAJ(skb->priority ^ sch->handle) == 0 &&
> @@ -1142,6 +1152,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
>  
>  	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>  	head = &q->root;
> +	drift = HFSC_CLASSIFY_MAX_DRIFT;
>  	tcf = rcu_dereference_bh(q->root.filter_list);
>  	while (tcf && (result = tcf_classify_qdisc(skb, tcf, &res, false)) >= 0) {
>  #ifdef CONFIG_NET_CLS_ACT
> @@ -1167,6 +1178,17 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
>  		if (cl->level == 0)
>  			return cl; /* hit leaf class */
>  
> +		/*
> +		 * flowid binds skip the level check above (res.class is set
> +		 * at bind time and levels drift after), so a walk can follow
> +		 * lateral hops without descending; a bounded number of them
> +		 * is legal, more means the chain cycles.
> +		 */
> +		if (cl->level >= head->level && drift-- == 0) {
> +			pr_warn_ratelimited("hfsc: classify hop budget exhausted, dropping packet\n");
> +			return NULL;
> +		}
> +

[Severity: Medium]

The walk does terminate: any cycle over head classes has to contain at
least one non-descending hop per lap, descending hops strictly lower
head->level, and the budget never comes back.  A couple of questions
about the wording and about the drop, though.

Is drift really a "run" of non-descending hops?  It is initialised once
before the loop:

	drift = HFSC_CLASSIFY_MAX_DRIFT;

and is never reset, so it is a cumulative total for the whole walk.  The
macro comment says "an unbounded run means the chain cycles" and the
inline comment says "a bounded number of them is legal, more means the
chain cycles", neither of which mentions that the counter is cumulative
and must not be reset.

The v3 notes say the comments were reworded to "describe the cumulative
non-descending hop budget that is implemented, and explain why it is
deliberately not reset on a descending hop", but that description only
appears in the changelog.  Since resetting the budget on a descent would
re-open the loop (a cycle can hide one lateral hop per lap behind
arbitrarily many descents), should the in-tree comments spell the
never-reset property out?

Can this also drop packets for an acyclic chain that would have reached a
leaf?  hfsc_bind_tcf() validates a bind only against the levels present
at bind time:

net/sched/sch_hfsc.c:hfsc_bind_tcf() {
	if (cl != NULL) {
		if (p != NULL && p->level <= cl->level)
			return 0;
		qdisc_class_get(&cl->cl_common);
	}
}

So each bind can be created while its target is still a leaf, and adding
a child under that target afterwards raises its level in
hfsc_adjust_levels() without revalidating the bind.  Chaining ten sibling
classes that way (C0 bound to C1, C1 bound to C2, ... C8 bound to C9,
each bind made before the target gained a child) gives eight lateral hops
that consume the budget, and the ninth hop C8->C9 satisfies

	if (cl->level >= head->level && drift-- == 0)

so hfsc_classify() returns NULL even though C9's filter points at a leaf
and the walk contains no cycle.  hfsc_enqueue() then drops the packet:

net/sched/sch_hfsc.c:hfsc_enqueue() {
	cl = hfsc_classify(skb, sch, &err);
	if (cl == NULL) {
		if (err & __NET_XMIT_BYPASS)
			qdisc_qstats_drop(sch);
		__qdisc_drop(skb, to_free);
		return err;
	}
}

Is the asymmetry with the neighbouring path for the same class of
misconfiguration intended?  The classid case breaks out and falls through
to the default class:

			if (cl->level >= head->level)
				break; /* filter may only point downwards */

while budget exhaustion returns NULL and bypasses the default-class
fallback.  Would break be the better match here too?

Related to that, where does 8 come from?  HTB derives its bound from
TC_HTB_MAXDEPTH via ++hops > TC_HTB_MAXDEPTH, but HFSC has no comparable
structural limit (hfsc_change_class() bounds neither chain length nor
class count), so a chain of more than eight lateral hops is not
necessarily cyclic.  Could the warning say something like "non-descending
hop budget exhausted" instead of attributing the case to a cycle?

>  		/* apply inner filter chain */
>  		tcf = rcu_dereference_bh(cl->filter_list);
>  		head = cl;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-CTUU.v3.20260916184908%40mojatatu.com
