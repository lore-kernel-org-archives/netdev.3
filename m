Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5CA42C4F0
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792319333; cv=none; b=s1JxQ/UgI3hmXqi+MRRBqUPo0e1RyWRNJiPa2SUyZr5T2Y1VfeGcZ55OIZmUQof/XEwqsfZBD0vkWgdfNQiMglYZ0Lj+rhV2LDIHb6Uo2z28C3neQwXQT7NB1J0RMYRLBnvBvl1c4ipWtSJa6coP9DutE2w3qZ+YEgjxvaqeoKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792319333; c=relaxed/simple;
	bh=1lSDj+91DdSxQs2Y6WUUwuf8CIreeQgSrlDMbzyyn68=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QgRMriEdsCxt8r0T1ZyIramfb2g2HcfHDkpu8paAvuau5h+55jBhW+O5wSFw1wS1qkMXF5IbJdnyvfr1pJBDeOK8xb79NHpThc10k24vo/wjTmzPX35cMy7qZm2d3s0sazlOGIej/YyC9zWiV+Oo6ah6zX0IvfvIXz7z3piaDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYWVRptr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYWVRptr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2001F000C4;
	Sun, 18 Oct 2026 10:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792319331;
	bh=kckZEZpDQkMS3IcBuTgcy1aba2Yzz4sDujjLB6UR7ko=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lYWVRptrgWVBEs+2uoCJK02RUXw/eqo+aIInYi/nTNLS7JBYLWgmMTgX0sb3jMnkZ
	 i1Kyr6RjOBsfMHND7+VJ3pbhWyP9lvZLbUmhUj4iV2GVnCurQui5en78RYUmvkSbfp
	 ISK8uehdYsBaKPlBcWqyvAyT+Z63b+FVlsBWxFOYJCXlQNOxNBXQkimmjMW+ylPcs+
	 omHu2B3nSX03gSZP2F5e6EUUSY8JRKcHZd4aGmEAIvQcNPBQnDkg5ioyWqRDG9p9+H
	 nVC71bxsu9sCIkeVa1KCdjaIecRuTSQiozwueDMKZxzrEDDt44QZtsyJm+QiK7xpt7
	 y/LmUgdfcVWGg==
Subject: Re: [PATCH net-next v6 4/4] net/sched: cake: hash before segmenting
 and reject an overlong split
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, toke@toke.dk, sashiko-bot@kernel.org
Date: Sun, 18 Oct 2026 10:28:50 +0000
Message-ID: <179231933068.3135.80340792633077986@kernel.org>
In-Reply-To: <QDISC-BA27.v6.r0.20261014054826-4@mojatatu.com>
References: <QDISC-BA27.v6.r0.20261014054826-4@mojatatu.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In the new overlimit rejection branch of cake_enqueue()
  (net/sched/sch_cake.c), only one skb gets the QDISC_DROP_OVERLIMIT…
- [Low] Before this patch, cake_enqueue() read q->config->flow_mode once
  and passed that one value to cake_hash(), so key extraction and set-…
- [Low] The commit message calls itself a bug fix ('The Fix:') for two
  defects that go back to when split-GSO support was added to cake.

--

net/sched: cake: hash before segmenting and reject an overlong split

This commit splits cake_hash() into two parts. cake_hash_keys() has no
side effects and runs on the unsegmented skb. cake_hash_resolve() commits
the set-associative state, and only runs once the packet is admitted.

It also moves split-GSO segmentation ahead of the resolution. The summed
segment length is checked against QDISC_MAX_BACKLOG, and the whole list
is rejected before any state is committed.

> The Fix:
> with CAKE_FLAG_SPLIT_GSO, cake computes the flow/host hash keys, then
> splits a GSO skb into segments it accounts individually.

[ ... ]

> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
This isn't a bug, but should this have a Fixes: tag?

The commit message calls this a fix. Both problems it addresses go back
to when split-GSO support was added to cake:

With CAKE_FLAG_SPLIT_GSO, slen was added to the 32-bit
sch->qstats.backlog without any ceiling check. slen can be larger than
the headroom that qdisc_backlog_at_max() reserves.

A GSO skb whose skb_gso_segment() failed was dropped after cake_hash()
and the shaper state update had already committed state.

The new check also depends on QDISC_MAX_BACKLOG, which comes from the
preceding patch in the series ("net/sched: cap the accounted backlog
before it can wrap"). Any backport would need both patches.

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index adfe11737c66d..c67db1c61a90b 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c

[ ... ]

> @@ -1787,12 +1814,55 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  					 QDISC_DROP_OVERLIMIT);
>  	}
>  
> -	/* choose flow to insert into */
> +	/* Tin selection and key extraction run on the unsegmented skb:
> +	 * skb_gso_segment() rewrites an encapsulated GSO packet's headers to
> +	 * the inner ones, changing the keys. Neither commits state.
> +	 */
>  	b = cake_select_tin(sch, skb);
> -	idx = cake_hash(b, skb, q->config->flow_mode, flow_override,
> -			host_override) + 1;
> +	cake_hash_keys(skb, q->config->flow_mode, flow_override,
> +		       host_override, &keys);
> +
> +	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
> +		struct sk_buff *nskb, *seg;
> +		netdev_features_t features = netif_skb_features(skb);
> +
> +		segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
> +		if (IS_ERR_OR_NULL(segs))
> +			return qdisc_drop(skb, sch, to_free);
> +
> +		/* The split path accounts the segment sum, not the
> +		 * stab-adjusted qdisc_pkt_len(), so the top check does not
> +		 * bound it. Sum the list and reject it whole.
> +		 */
> +		skb_list_walk_safe(segs, seg, nskb)
> +			slen += seg->len;
> +
> +		if (unlikely((u64)sch->qstats.backlog + slen > QDISC_MAX_BACKLOG)) {
> +			qdisc_qstats_overlimit(sch);

[ ... ]

> +			if (unlikely(segs == skb)) {
> +				tcf_set_qdisc_drop_reason(skb,
> +							  QDISC_DROP_OVERLIMIT);
> +				consume_skb(skb);
> +				return qdisc_drop_all(segs, sch, to_free);
> +			}
> +			__qdisc_drop_all(segs, to_free);
> +			return qdisc_drop_reason(skb, sch, to_free,
> +						 QDISC_DROP_OVERLIMIT);
> +		}
> +	}

[Severity: Medium]
Do the segments placed on to_free here get a valid drop reason?

When segs != skb, qdisc_drop_reason() tags only the original skb. When
segs == skb, tcf_set_qdisc_drop_reason() tags only the head. Every other
segment keeps whatever value is in tc_skb_cb(seg)->drop_reason.

That field is at cb offset 32, right after the 32-byte struct
qdisc_skb_cb. SKB_GSO_CB_OFFSET is also 32, and __skb_gso_segment()
writes to that location:

net/core/gso.c:__skb_gso_segment() {
    ...
	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
    ...
}

This overwrites the QDISC_DROP_GENERIC value set by __dev_xmit_skb().
__copy_skb_header() then copies the cb into every segment.

__tcf_kfree_skb_list() reads the reason separately for each skb:

net/sched/sch_generic.c:__tcf_kfree_skb_list() {
    ...
		u32 reason = tc_skb_cb(skb)->drop_reason;
    ...
		if ((reason & SKB_DROP_REASON_SUBSYS_MASK) == __QDISC_DROP_REASON) {
			trace_qdisc_drop(q, txq, dev, skb, (enum qdisc_drop_reason)reason);
			skb_reason = SKB_DROP_REASON_QDISC_DROP;
		} else {
			skb_reason = (enum skb_drop_reason)reason;
		}
		kfree_skb_reason(skb, skb_reason);
    ...
}

A headroom-sized value has no qdisc subsystem bits. For those segments,
trace_qdisc_drop would be skipped, and kfree_skb_reason() would report an
unrelated core drop reason. A value of 1 would show up as SKB_CONSUMED,
and a value of 0 would hit the DEBUG_NET_WARN_ON_ONCE in
__sk_skb_reason_drop().

The qdisc_backlog_at_max() rejection at the top of cake_enqueue() tags
its drop correctly.

Could the existing slen-summing skb_list_walk_safe() loop call
tcf_set_qdisc_drop_reason(seg, QDISC_DROP_OVERLIMIT) on each segment?

> +
> +	/* Admitted: resolve the keys and commit flow/shaper state. */
> +	idx = cake_hash_resolve(b, &keys, q->config->flow_mode);

[Severity: Low]
Can the two reads of q->config->flow_mode see different values?

Before this patch, cake_hash() got a single flow_mode value, so key
extraction and resolution always used the same mode. Now
cake_hash_keys() and cake_hash_resolve() each do their own plain load.
On the split-GSO path, skb_gso_segment() and the slen walk run between
the two loads.

cake_change() calls cake_config_change(), which does
WRITE_ONCE(q->flow_mode, flow_mode) before sch_tree_lock() is taken. That
write is not serialised against cake_enqueue().

For example, keys built in a flows-only mode have srchost_hash and
dsthost_hash set to 0. If cake_hash_resolve() then runs in a dual-srchost
or dual-dsthost mode, allocate_src or allocate_dst is set and the flow is
tied to the host slot for hash 0. Later packets take the tags-match fast
path, so this assignment stays until the flow drains.

Would it be better to read the mode once with
READ_ONCE(q->config->flow_mode) and pass that value to both helpers?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-BA27.v6.r0.20261014054826%40mojatatu.com
