Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60616217648
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804056; cv=none; b=meuX6f2ppWFbpNpTcmrqui3AeI8fzVkdBiwV5x8AWru08gV11Ku97P4WcrnHD3cFRwwaEWOn7yXbcwn22UuNuVoCOh7iMbCpNSbYaJ8aMhYUaRAdLyNVC5rmx9z5g+JGZqER7ctkkqi+D8Mu2MHzb8hIb2/TRMUz9vgJA2H+Ics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804056; c=relaxed/simple;
	bh=hQSkr81osMmnKVS+PLx87rToCxjZ9lmr9hzW8fjTE2A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mG2O2n5+VOKTfJgDIaSHqyCeimhrRWh/bkPyM/jDpj3OvjucuXrpXW0LuTGdT8aJCHA+Jf5grsFnsbvtLGsp9RinFdKWBpuxfDYsLW0GEjxCLAu+CtTBjqYsVFwwLD7Ed9elu2paUaJVfMt+wtf4ny/RN5dKaC+i+alE0LGbMIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HehpvHIn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HehpvHIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB141F000FF;
	Wed, 30 Sep 2026 21:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790804053;
	bh=S2vG1Mhuv+pR9JA6kaW6baOesZxlKroQYZoJTVbzuvU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HehpvHInnv5s/EMOv2rcUkk4+ggrVlXM/XLVBGRvBgKeJPNPhUQEL4TwcTI6cd386
	 zJbFLSrLLhv+cLuAaNI7fLaCoFyRsLR5eBMeULUr0+gJq6Ok11LMDa6k9T2kwr8to0
	 F0sKPqKNky+uYjkDeeVQax3FgXBACKrQFqAF/74vYcRx0ptOjh9djZj2lTr/C08+3X
	 HrFsaSA/Fzh+haD5zCEwj3+GIif3VxEZjrpTtcEGwwcy49YPIyYXEoj9yi3GcS6mbj
	 f1pBjrOENh35yuA88AIcdyQkmN32fSNju2xF438DeGlPz2uWNzyY5j1vmo85n2Or6F
	 vfc9h/m6McDPg==
Subject: Re: [PATCH net-next v3] net/sched: cap the accounted backlog before
 it can wrap
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, hybris@mojatatu.ai, toke@toke.dk, moeller0@gmx.de,
 cake@lists.bufferbloat.net, sashiko-bot@kernel.org
Date: Wed, 30 Sep 2026 21:34:12 +0000
Message-ID: <179080405275.434549.4774091019761986371@kernel.org>
In-Reply-To: <QDISC-BA27.v3.20260929142417@mojatatu.com>
References: <QDISC-BA27.v3.20260929142417@mojatatu.com>
X-sashiko-severity: Critical
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

Critical: 1 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The new overlimit path for CAKE's SPLIT_GSO in
  cake_enqueue() (net/sched/sch_cake.c:1824-1825) puts the same skb on…
- [High] The new ceiling qdisc_backlog_at_max() (sch->qstats.backlog >
  U32_MAX - QDISC_PKT_LEN_MAX) only prevents a wrap if no single packet…
- [Medium] cake_enqueue() now calls cake_hash(b, skb, ...) at
  net/sched/sch_cake.c:1831, after skb_gso_segment(skb, ...) at line…
- [Low] The commit fixes a user-reachable crash (the NULL flow->head
  dereference in fq_codel_drop()/dequeue_head()) and wrong AQM drop…
- [Low] The new comment on cake_tcf_classify()
  (net/sched/sch_cake.c:1715-1718) says it returns true when 'the…

--

net/sched: cap the accounted backlog before it can wrap

This patch makes fq_codel, cake, codel, pie, fq_pie, dualpi2, RED and
pfifo drop at enqueue once sch->qstats.backlog is within QDISC_PKT_LEN_MAX
of U32_MAX. fq_codel and cake are restructured so the external classifier
runs before the new ceiling check and flow hashing runs after it. The CAKE
SPLIT_GSO path now segments first and checks the summed segment length
before cake_hash() is called.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
Link: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/
Link: https://lore.kernel.org/netdev/CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CANn89i+GOFH_8g+vSV0jUj0aBqLYVWuFOrHuDggZu9kPC_m6tQ@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CANn89i+99jPh7JjZf=G3Ouaom2tuOtAEiHUf2MEsRdVPd=nz4w@mail.gmail.com/

> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
[ ... ]
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
This isn't a bug, but should this have a Fixes: tag and Cc: stable?

The commit message describes a NULL flow->head dereference in
fq_codel_drop()->dequeue_head(). It says this needs only CAP_NET_ADMIN in
a user namespace.

The backlog wrap also existed before the QDISC_PKT_LEN_MAX clamp was
added, when stab pkt_len had no upper bound. So older stable trees are
affected, and nothing in the trailers marks them.

> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index f35bd06a6bad6..87fa65c88f03b 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -906,6 +906,23 @@ static inline unsigned int qdisc_pkt_len(const struct sk_buff *skb)
>  	return qdisc_skb_cb(skb)->pkt_len;
>  }
>  
> +#define QDISC_PKT_LEN_MAX	(1 << 20)	/* 1 MiB */
> +
> +/* Largest accounted backlog for which enqueuing one more maximum-size
> + * packet cannot wrap the 32-bit sch->qstats.backlog.
> + */
> +#define QDISC_MAX_BACKLOG	(U32_MAX - QDISC_PKT_LEN_MAX)
> +
> +/* True when the accounted backlog is close enough to U32_MAX that one
> + * more maximum-size packet could wrap it. A qdisc whose limit is a
> + * packet count (or is otherwise not a byte bound) must drop at enqueue
> + * when this holds, so the 32-bit backlog an AQM reads cannot wrap.
> + */
> +static inline bool qdisc_backlog_at_max(const struct Qdisc *sch)
> +{
> +	return sch->qstats.backlog > QDISC_MAX_BACKLOG;
> +}

[Severity: High]
Does the fixed 1 MiB headroom still hold when no size table is attached?

The only clamp to QDISC_PKT_LEN_MAX is in __qdisc_calculate_pkt_len().
qdisc_calculate_pkt_len() calls it only when a stab exists:

net/sched/sch_api.c:__qdisc_calculate_pkt_len() {
    ...
	pkt_len = clamp_t(int, pkt_len, 1, QDISC_PKT_LEN_MAX);
	qdisc_skb_cb(skb)->pkt_len = pkt_len;
}

Without a stab, pkt_len comes from qdisc_pkt_len_segs_init(), which has no
upper bound:

net/core/dev.c:qdisc_pkt_len_segs_init() {
    ...
		gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
    ...
	qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
}

For SKB_GSO_DODGY skbs from AF_PACKET with PACKET_VNET_HDR (CAP_NET_RAW in
a user namespace), __virtio_net_hdr_to_skb() lets the sender choose two
values. csum_start becomes the transport offset, and gso_size can be as
small as TCP_MIN_GSO_SIZE.

A 16 KiB skb with an 8 KiB header gives about 1024 segments and a pkt_len
of about 8 MiB. A 64 KiB skb with a 32 KiB header gives about 128 MiB.

qdisc_backlog_at_max() admits such a packet whenever the backlog is at most
U32_MAX - 1 MiB. Can about 32 of these packets still wrap
sch->qstats.backlog and fq_codel's q->backlogs[idx]? Their truesize is
small, so they stay well under fq_codel's memory_limit and packet limit.

If so, the NULL flow->head dereference in fq_codel_drop()->dequeue_head()
comes back. So do the wrong AQM decisions in codel, pie, fq_pie, dualpi2,
cake, RED and pfifo.

The new comments in fq_codel_enqueue() and cake_enqueue() say "the 1 MiB
QDISC_PKT_LEN_MAX headroom keeps a single packet from crossing the ceiling".
That would not be true on this path.

Would this need a length-aware check such as (u64)backlog +
qdisc_pkt_len(skb) > U32_MAX, or a pkt_len clamp in
qdisc_pkt_len_segs_init() as well?

[ ... ]

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index dc93267029e70..bd1a7aed2ebb2 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1712,18 +1712,25 @@ static struct cake_tin_data *cake_select_tin(struct Qdisc *sch,
>  	return &qd->tins[tin];
>  }
>  
> -static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
> -			 struct sk_buff *skb, int flow_mode, int *qerr)
> +/* Run the optional external classifier. Returns true when the caller must
> + * drop (the filter's terminal TC action consumed the packet, or it matched no
> + * usable flow); the reason is then in *qerr. Otherwise *flow and *host hold
> + * the filter's flow/host overrides (0 when the filter supplied none).
> + */

[Severity: Low]
This isn't a bug, but is the "or it matched no usable flow" part of this
comment accurate?

cake_tcf_classify() returns true only for TC_ACT_STOLEN, TC_ACT_QUEUED,
TC_ACT_TRAP and TC_ACT_SHOT. In two other cases it leaves *flow and *host
at 0, returns false, and cake hashes the packet as before:

  - there is no filter match (result < 0)
  - the classid minor or major is out of range

		if (TC_H_MIN(res.classid) <= CAKE_QUEUES)
			*flow = TC_H_MIN(res.classid);
		if (TC_H_MAJ(res.classid) <= (CAKE_QUEUES << 16))
			*host = TC_H_MAJ(res.classid) >> 16;
	}
	return false;

fq_codel_classify() has the same wording, and there it does return true
for a no-flow result. So the two comments match, but the functions
behave differently.

> +static bool cake_tcf_classify(struct Qdisc *sch, struct sk_buff *skb,
> +			      u16 *flow, u16 *host, int *qerr)

[ ... ]

> @@ -1758,22 +1763,74 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,

[ ... ]

> +	/* Tin selection (DSCP/wash) must happen before segmentation, but no
> +	 * flow/host state is committed until admission is known below.
> +	 */
> +	b = cake_select_tin(sch, skb);
> +
> +	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
> +		struct sk_buff *nskb, *seg;
> +		netdev_features_t features = netif_skb_features(skb);
> +
> +		segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
> +		if (IS_ERR_OR_NULL(segs))
> +			return qdisc_drop(skb, sch, to_free);
> +
> +		/* The split path accounts the sum of the segment lengths
> +		 * rather than the stab-adjusted qdisc_pkt_len(), so the top
> +		 * check does not bound this addition. Sum the list and reject
> +		 * the whole list before any flow/host state is committed.
> +		 */
> +		skb_list_walk_safe(segs, seg, nskb)
> +			slen += seg->len;
> +
> +		if (unlikely((u64)sch->qstats.backlog + slen > QDISC_MAX_BACKLOG)) {
> +			qdisc_qstats_overlimit(sch);
> +			/* skb_gso_segment() moved the sock_wfree destructor to
> +			 * the tail segment; free both the original packet and
> +			 * the whole list after the qdisc lock is released,
> +			 * never here.
> +			 */
> +			__qdisc_drop_all(segs, to_free);
> +			return qdisc_drop_reason(skb, sch, to_free,
> +						 QDISC_DROP_OVERLIMIT);

[Severity: Critical]
Can this put the same skb on *to_free twice?

For SKB_GSO_FRAGLIST packets (for example forwarded fraglist GRO
traffic), skb_segment_list() returns the original skb, with an extra
reference, as the head of the list:

net/core/skbuff.c:skb_segment_list() {
    ...
	skb->prev = tail;
    ...
	skb_get(skb);

	return skb;
}

So segs == skb here. The two drop calls then run in this order:

  - __qdisc_drop_all(segs, to_free) sets tail->next = *to_free and
    *to_free = skb.
  - qdisc_drop_reason(skb, ...) calls __qdisc_drop(), which sets
    skb->next = *to_free. At that point *to_free is skb itself.

That leaves skb->next == skb, and segments 2..N can no longer be reached
from *to_free. Are they leaked?

Later, __tcf_kfree_skb_list() walks the list:

	while (skb) {
		u32 reason = tc_skb_cb(skb)->drop_reason;
		struct sk_buff *next = skb->next;
		...
		kfree_skb_reason(skb, skb_reason);
		skb = next;
	}

Each pass lands on the same skb:

  - The first pass drops the skb_get() reference.
  - The second pass frees the skb.
  - The third pass reads tc_skb_cb(skb)->drop_reason from freed memory
    and calls kfree_skb_reason() again.

Does this lead to a use-after-free or double free, and possibly an
endless loop in the transmit path?

This happens with split_gso (the default) when the backlog is at or below
QDISC_MAX_BACKLOG but backlog + slen is above it. Before this patch there
was no drop path here: every segment was enqueued and consume_skb(skb)
only dropped the extra reference.

> +		}
> +	}
> +
> +	/* Admission is known; persistent flow/hash/shaper mutation may begin. */
> +	idx = cake_hash(b, skb, q->config->flow_mode, flow_override, host_override);

[Severity: Medium]
Is cake_hash() now dissecting an skb whose headers skb_gso_segment() has
already changed?

Before this patch, cake_classify() hashed the untouched skb before
segmenting. For encapsulated GSO skbs, a successful segmentation leaves
the original skb pointing at its inner headers:

net/ipv4/udp_offload.c:__skb_udp_tunnel_segment() {
    ...
	skb->encapsulation = 0;
	...
	skb_reset_mac_header(skb);
	skb_set_network_header(skb, skb_inner_network_offset(skb));
	skb_set_transport_header(skb, skb_inner_transport_offset(skb));
	skb->mac_len = skb_inner_network_offset(skb);
	skb->protocol = new_protocol;
    ...
}

skb_gso_error_unwind() undoes this only on failure. After it,
skb_mac_gso_segment() pushes skb->data back to the new inner mac header.

For VXLAN, skb->protocol becomes ETH_P_TEB, and __skb_flow_dissect()
handles that only inside GRE dissection. Would skb_flow_dissect_flow_keys()
in cake_hash() then fail and leave srchost_hash and dsthost_hash at 0?
For other tunnels, would the inner addresses be hashed instead of the outer
ones?

With split_gso and the default triple-isolate mode, tunnel GSO packets
could then land in a different flow or host bucket than non-GSO packets
of the same outer flow. That would change per-host fairness, could
reorder packets across queues, and would pass different keys to the
NAT-mode conntrack lookup.

>  	tin = (u32)(b - q->tins);
> -	idx--;
>  	flow = &b->flows[idx];

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-BA27.v3.20260929142417%40mojatatu.com
