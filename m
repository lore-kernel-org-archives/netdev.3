Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C56496D4C
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789245390; cv=none; b=ARuol8gXDjp4ZEmQtZMAQ5oWcgxw3NcTBvkktitG0JCxTDeKgLqCai5Dj+s8J5ewqU7Pg0dgX06qdJK20dH63tC30TGAkhcIEV9ymfFECg1e1dQv46/t33D/iK7cgNHinIZm5dyUBArWHK73to0NT/g/aD1wV7BoG4HljZqm6oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789245390; c=relaxed/simple;
	bh=w644z/uGUOLViaTnJAFURdO3RXlXAtD3dZW20pc0L/k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=forpwGbn+3cvDgSDmCtg1/oCB9tL+M8v2FtMz/91KVXBz5XESKPkwi+jVrwpARDstbjgqnuSLwgULsCnGYe+DrCCFJzbOWedWUk+2CEZqXML7oJtfWBrbBMbxN9KKQaQIsF+lBskfykoHCwtFvsGwxBgseuPtnX7b105yNxufAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzjvQGKC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzjvQGKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70271F0089A;
	Sat, 12 Sep 2026 20:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789245387;
	bh=XnXuF7ayH3K6i0gi+gwQwSkztFiLufZed8doCHe7QEw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OzjvQGKCvktvti4QnX+SQNHuToXNe5FP47WouXyfttSb5wGCpNiu2xMkQks/2kB6z
	 +Ovku0L+uRrr29TgKHdi3Qnbeu6pEvY5XMeDdPkzpTb8/HoxcG+Jb4ExaqEpdqVzYE
	 BMx78y8UtiQOEXqaHB/ddeM3PWWKNVPew/9NYUnjrp0aqzfvPAH+rbAWXG9E2iqHZ2
	 9CufRg4FImDGJDOuwW7idl5r233tLvzCLrB7FwOTUtHIJrDrVjdfjrOMvcQlR9uW1k
	 L9WxYOCH8RY/7ldiT06oq5JkRZzl8s+lt7VxWKlEUHBXuYX2qTdh7Jc2lnFaGk07Bp
	 OGdHsZoN4xboQ==
Subject:
 Re: [PATCH net] net/sched: sch_hfsc: bound the classify inner-filter walk
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kaber@trash.net, sashiko-bot@kernel.org, victor@mojatatu.com,
 hybris@mojatatu.ai
Date: Sat, 12 Sep 2026 20:36:26 +0000
Message-ID: <178924538639.3125.3879861212376394770@kernel.org>
In-Reply-To: <QDISC-CTUU.v1.20260908094501@mojatatu.com>
References: <QDISC-CTUU.v1.20260908094501@mojatatu.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] hfsc_classify() (net/sched/sch_hfsc.c:1146) seeds the new cycle
  guard with `hops = head->level` where `head = &q->root`.

--

net/sched: sch_hfsc: bound the classify inner-filter walk

This adds a hop budget to the inner-filter walk in hfsc_classify(), seeded
from the root class level, and drops the packet with a rate-limited warning
when the budget is exhausted. The intent is to stop the classify walk from
spinning forever when two flowid binds end up pointing at each other after
hfsc_adjust_levels() raises a class level.

Link: https://sashiko.dev/#/patchset/20260824161809.4147223-1-victor@mojatatu.com

> diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> index e87f5021a1995..71744a6c2f38e 100644
> --- a/net/sched/sch_hfsc.c
> +++ b/net/sched/sch_hfsc.c
> @@ -1133,6 +1133,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
>  	struct hfsc_class *head, *cl;
>  	struct tcf_result res;
>  	struct tcf_proto *tcf;
> +	unsigned int hops;
>  	int result;
>  
>  	if (TC_H_MAJ(skb->priority ^ sch->handle) == 0 &&
> @@ -1142,6 +1143,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
>  
>  	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>  	head = &q->root;
> +	hops = head->level;
        ^^^^^^^^^^^^^^^^^^

[Severity: High]

Can a legal, acyclic chain of flowid binds consume more hops than
q->root.level and get dropped here?

The budget root->level is an upper bound on the number of internal classes
visited only if every filter step strictly descends the tree. But as the
commit message itself points out, the descent check is only reached on the
classid-lookup path:

	cl = (struct hfsc_class *)res.class;
	if (!cl) {
		cl = hfsc_find_class(res.classid, sch);
		if (!cl)
			break; /* filter selected invalid classid */
		if (cl->level >= head->level)
			break; /* filter may only point downwards */
	}

For a flowid bind, res.class is already set and no level relation is
enforced at classify time.  hfsc_bind_tcf() checks the relation once, at
bind time:

	if (cl != NULL) {
		if (p != NULL && p->level <= cl->level)
			return 0;

and hfsc_adjust_levels() later raises levels without revalidating the
stored res.class:

		WRITE_ONCE(cl->level, level);

So the walk can step between classes of equal level without cycling.
A configuration that the current code accepts at every step, with no cycle
at all:

- A1 child of root with one leaf child -> A1->level == 1, root->level == 2,
  so hops == 2.
- A2 as a leaf child of root (level 0); filter on A1 with flowid A2 is
  accepted because p(A1)->level 1 > cl(A2)->level 0.
- Add a leaf child to A2 -> A2->level becomes 1 (root->level stays 2).
- A3 as a leaf child of root; filter on A2 with flowid A3 accepted
  (1 > 0); then add a leaf child to A3 -> A3->level == 1.
- Filter on A3 with flowid A3's leaf child (strictly descending), root
  filter selects A1.

Walking a matching packet: A1 (hops 2 -> 1), A2 (hops 1 -> 0), A3 hits
hops-- == 0 and returns NULL, so hfsc_enqueue() drops the packet even
though the next step was a leaf.  Before this patch the same packet was
enqueued into A3's leaf.

Would a configuration-independent constant avoid this, the way the HTB
side does it in htb_classify()?

	if (++hops > TC_HTB_MAXDEPTH) {
		pr_warn_ratelimited("htb: classify loop detected, dropping packet\n");
		return NULL;
	}

The commit message says "Bound the traversal the same way the HTB side was
fixed: a sane walk strictly descends the class tree, so it consumes fewer
hops than the level the walk starts at".  Is that premise consistent with
the rest of the message, which states the strict-descent check "never runs"
for flowid binds and that levels drift after bind time?

>  	tcf = rcu_dereference_bh(q->root.filter_list);
>  	while (tcf && (result = tcf_classify_qdisc(skb, tcf, &res, false)) >= 0) {
>  #ifdef CONFIG_NET_CLS_ACT
> @@ -1167,6 +1169,15 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
>  		if (cl->level == 0)
>  			return cl; /* hit leaf class */
>  
> +		/*
> +		 * flowid binds skip the level check above, and levels
> +		 * drift after bind time, so this walk can cycle.
> +		 */
> +		if (hops-- == 0) {
> +			pr_warn_ratelimited("hfsc: classify loop detected, dropping packet\n");
> +			return NULL;
> +		}
> +
>  		/* apply inner filter chain */
>  		tcf = rcu_dereference_bh(cl->filter_list);
>  		head = cl;

Also, since budget exhaustion is reported unconditionally as "classify loop
detected" without any evidence that a class was revisited, would the
warning be misleading for the acyclic case above?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-CTUU.v1.20260908094501%40mojatatu.com
