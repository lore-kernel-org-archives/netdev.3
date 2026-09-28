Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF182931E9
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585697; cv=none; b=Zr5VN5ZU7WPv18BJj3cxUv+5P06XySou+JrQk7yQzVzaGp4cNHQRyZKGhxXuwTd61bCmmHcCmYEHE9dvseIu5Dtwz8LEwba48GSRCmQ1hYfLa5BrhvjV5qxkSbqIMa/ocLLjW0/AAtPaaaKuOHFgUqAtgvimAIty+Yi0xXCVbwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585697; c=relaxed/simple;
	bh=gqHZm0Wwcr+tt3qVEjNhcLDenWrf2ThZODzb4LlKU8I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SqB4WNcNmaKfLoIluODNJvJLQ7/1b9/ItB707n5eOsjnspGGaSVAdPFpvd1gyMqG8ZRpGhXz9v8csAvGkC+rAkhL0phxuPsg5aOWEZhr5bpUexDS9j0/uwZOhHm3Mi1BSu56rd/IpjCkBX/rvNAGLCK1jCIqFDA4DevXUAJbyEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnY608eX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnY608eX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844D31F000FF;
	Mon, 28 Sep 2026 08:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585695;
	bh=gbu6VEauuGZeD//yTTDBvijqKt+mr4UHO1jmfiRhIHw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OnY608eXTtINyaBwY8xitY/9qomShAgj1WchrDm9akdfCTM4+uoOmvGoSrQdalqqB
	 B/zQEJcEioRXyXOnXpCI0GO6Nz4+wLkd0+mMW2K+kK0sCc2ItQyI9oCytPuDoNSuRA
	 4bzTCCQhBVzinOHxFYiY1CY/xpbeR3YhLFZIs2qQDvzgz1HTCBp1KtqW+5sxOmPFdK
	 xfBaZ5X4z6+9+mOaXua8KOduzIqMP5iHNRAYJc0OqaoKFA8h35uc9gcygkjYix3ERN
	 FcbL/DUFz5xbU7bNSZ5QXilBh6/gZD/rfBAhbCawMGq38mJkLfgdyEJXmFLeUd6M24
	 1rwYFpNbW9K+Q==
Subject: Re: [PATCH net-next] net/sched: fq_codel, cake: widen backlogs to u64
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, toke@toke.dk, cake@lists.bufferbloat.net,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, victor@mojatatu.com, hybris@mojatatu.ai,
 sashiko-bot@kernel.org
Date: Mon, 28 Sep 2026 08:54:54 +0000
Message-ID: <179058569406.3145.5884584307919911126@kernel.org>
In-Reply-To: <QDISC-BA27.v1.20260922092618@mojatatu.com>
References: <QDISC-BA27.v1.20260922092618@mojatatu.com>
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

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message understates the bug it fixes.
- [Medium] The patch widens the per-flow counter q->backlogs[] to u64,
  but fq_codel's CoDel drop decision still uses the qdisc-wide u32…
- [Low] The commit fixes a user-triggerable bug in fq_codel and CAKE:
  wrong fat-flow drop choices and, before the patch, a possible NULL…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  cake_heapify() does not refresh mb after a swap, so each call sifts…

--

net/sched: fq_codel, cake: widen backlogs to u64

This patch widens three counters from u32 to u64: the fq_codel per-flow
backlogs table, and the CAKE per-flow backlogs[] and per-tin tin_backlog
counters. This stops 1 MiB qdisc_pkt_len() values from wrapping them. The
fat-flow scan and heap comparison locals are widened to match, and the dump
paths export the low 32 bits through the existing uAPI fields.

Link: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/

> After a wrap, fq_codel_drop() sees a tiny maxbacklog
> and drops from an almost-empty flow, and the dequeue-side subtractions
> corrupt the counter further.

[Severity: Medium]
Is "almost-empty flow" the worst case here? qdisc_pkt_len() is capped at
QDISC_PKT_LEN_MAX. So with the old u32 counters, 4096 resident 1 MiB
packets in one flow X leave q->backlogs[X] at exactly 0.

Take the case where flows_cnt >= 2 (the default is 1024), X != 0, and all
other flows are empty. The strict comparison in the fq_codel_drop() scan
then never fires:

    for (i = 0; i < q->flows_cnt; i++) {
        if (q->backlogs[i] > maxbacklog) {

So idx stays 0, and flow = &q->flows[0] is an empty flow. dequeue_head()
then does this with no NULL check:

    struct sk_buff *skb = flow->head;

    WRITE_ONCE(flow->head, skb->next);

Wouldn't that be a NULL pointer dereference, reachable with CAP_NET_ADMIN
in a user namespace? The reproducer uses flows 1, which hides it, because
idx 0 is then the fat flow.

The u64 counters fix this, since they can't wrap. Could the commit message
describe the oops, so stable and CVE triage see the real impact?

Is the claim about the dequeue-side subtractions accurate?
fq_codel_enqueue(), dequeue_func() and fq_codel_drop() all add and
subtract the same qdisc_pkt_len() values in modular u32 arithmetic. The
counter therefore stays equal to the true backlog mod 2^32; it can't
represent values at or above 2^32, but it doesn't drift further.

> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
> Link: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/
> Tested-by: hybris <hybris@mojatatu.ai>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
Should this carry a Fixes: tag, and possibly Cc: stable?

The u32 per-flow backlogs go back to the original fq_codel and CAKE code.
The only reference to history is the prose "follow-up to commit
8f735d64382d", which backport tooling won't parse.

Other net fixes around this baseline carry Fixes: tags, such as "tcp:
prevent collapsing skbs across boundary in rtx queue" and "llc: reserve
device headroom for allocated frames".

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index dc93267029e70..8e99c85dab17b 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c

[ ... ]

> @@ -1466,17 +1466,17 @@ static void cake_heap_swap(struct cake_sched_data *q, u16 i, u16 j)

[ ... ]

>  static void cake_heapify(struct cake_sched_data *q, u16 i)
>  {
>  	static const u32 a = CAKE_MAX_TINS * CAKE_QUEUES;
> -	u32 mb = cake_heap_get_backlog(q, i);
> +	u64 mb = cake_heap_get_backlog(q, i);
>  	u32 m = i;
>  
>  	while (m < a) {

[ ... ]

> @@ -1493,7 +1493,7 @@ static void cake_heapify(struct cake_sched_data *q, u16 i)
>  		}
>  
>  		if (r < a) {
> -			u32 rb = cake_heap_get_backlog(q, r);
> +			u64 rb = cake_heap_get_backlog(q, r);
>  
>  			if (rb > mb) {
>  				m  = r;

[Severity: Medium]
This isn't a bug introduced by this patch, but does cake_heapify() ever
sift down more than one level? The rest of the loop is:

		if (m != i) {
			cake_heap_swap(q, i, m);
			i = m;
		} else {
			break;
		}

When a child wins, mb takes the child's backlog. cake_heap_swap() then
moves the smaller original entry down to m, and i = m. But mb is not
refreshed, so it still holds the promoted child's larger value.

In a heap that was valid below, the grandchildren are <= that value. So
lb > mb and rb > mb never fire again, and the loop breaks.

For example, take [1000, 900, 0, 700, 0], where the root flow holds a
900-byte packet followed by a 100-byte packet. cake_drop() drops the
900-byte head, and cake_heapify(q, 0) produces [900, 100, 0, 700, 0].
Node 1 (100) is now above its 700 child.

After the next drop from the 900 root, the next overflow prune in
cake_drop() can pick the 100-byte flow instead of the 700-byte flow. The
bottom-up rebuild in cake_drop() has the same one-level limit.

[ ... ]

> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> index 969b2510b0b86..3c20297cef07e 100644
> --- a/net/sched/sch_fq_codel.c
> +++ b/net/sched/sch_fq_codel.c
> @@ -51,7 +51,7 @@ struct fq_codel_sched_data {
>  	struct tcf_proto __rcu *filter_list; /* optional external classifier */
>  	struct tcf_block *block;
>  	struct fq_codel_flow *flows;	/* Flows table [flows_cnt] */
> -	u32		*backlogs;	/* backlog table [flows_cnt] */
> +	u64		*backlogs;	/* backlog table [flows_cnt] */

[Severity: Medium]
The per-flow counters are widened here, but does the CoDel drop decision
still see a backlog that wraps? fq_codel_enqueue() adds the same
qdisc_pkt_len() to both counters:

	WRITE_ONCE(q->backlogs[idx], q->backlogs[idx] + qdisc_pkt_len(skb));
	qdisc_qstats_backlog_inc(sch, skb);

sch->qstats.backlog is the __u32 backlog field in struct gnet_stats_queue.
__fq_codel_dequeue() passes it to CoDel:

	skb = codel_dequeue(sch, &sch->qstats.backlog, &q->cparams,

and codel_should_drop() then does:

	if (codel_time_before(vars->ldelay, params->target) ||
	    *backlog <= params->mtu) {
		/* went below - stay below for at least interval */
		vars->first_above_time = 0;
		return false;
	}

The aggregate is summed over all flows, so it wraps at or before the
point where the old per-flow counter did. With 4096 x 1 MiB queued across
any mix of flows, the aggregate is 0. CoDel then stops dropping and
ECN-marking whatever the sojourn time, and leaves the dropping state if
it was in it.

stab inflates pkt_len but not truesize, so this can happen below both
sch->limit and memory_limit.

The uAPI field can't be widened. Could CoDel be given a private u64 sum,
or a saturated value, instead?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-BA27.v1.20260922092618%40mojatatu.com
