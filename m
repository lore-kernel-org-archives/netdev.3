Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128BB3955D3
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792951; cv=none; b=DgIVKYio72ESOYsK2YRimMoKHCdCopT3v1ej5xxEFwC9D2ZVLxKAHitXMTH5jhSIrJEc7Eyt/AJ9tUawBw2VGFHi04ar/+IPqHjfAlSktHNiMkDo9CvWVgwq5Z5kBwdVIflBAaqQN4qYhm3myb9CSBBmciM1+OBbzCNfVVV1OxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792951; c=relaxed/simple;
	bh=k+TiqFi2kJ3fgeuDjisxOdt4icHeapDHE6JL7WVE1o0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DbSCnOuwEtsZnmqd/xRsvagWsf8v7ImVm5fF7Pde8syL/udwGt6tVISRY6ho9wNVeKLOVvJnpWqSAfNCCxVWY2fxqf57XJuUGUh0Rag0ShDqDkkPhQ+DORpqa+pky6/1vvCv6WQ+PRHD1VmUmS/FncIPK/V0GPaUs2amcYKIgp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIKYkqMI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIKYkqMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DA01F0089B;
	Mon, 12 Oct 2026 08:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791792949;
	bh=gTpTR8MgtArevivRS8DQFoKmOvkqNz2otEx/FY6wCn8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CIKYkqMIDwEkqwjTLl6ujRUhmwsqUpmRn/ZS0W88dJ5v5n1+lnRNVyHNXhqK4NpTI
	 cWyeeeiZbnx/pFQuPJox11MpHKSoLENzQeCVUJw2plbUf3QlS7WmHKU8PQVfQIX5w0
	 6PvlD2lYWu/85/Ssjxrq2kaTsGrBI8tr/CO8MQnlXSzRKQDLKKJurQd4w8FsTCJUbW
	 OGKNeL/AQwsx+sA18dr8+7dOz17H5J1JS+axKUFIcr1NX4pruhKqlPYohCiNs/WEp8
	 YcQA2cT13zUjzdFt2IhFbGeZXZyKiTAtg0EZB8XUDAB2ZS4k13sOBJjL+lOA0zKgb9
	 p7WJeTQBqIHyA==
Subject: Re: [PATCH net-next v5] net/sched: cap the accounted backlog before
 it can wrap
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, toke@toke.dk, moeller0@gmx.de,
 cake@lists.bufferbloat.net, sashiko-bot@kernel.org
Date: Mon, 12 Oct 2026 08:15:48 +0000
Message-ID: <179179294846.434549.11139405033362451338@kernel.org>
In-Reply-To: <QDISC-BA27.v5.20261007171509@mojatatu.com>
References: <QDISC-BA27.v5.20261007171509@mojatatu.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The ceiling does not hold for stabless non-GSO packets, so the
  wrap and the fq_codel_drop() NULL dereference are still reachable.
- [Medium] A duplicating netem child lets RED's new backlog guard be
  bypassed.
- [Medium] sch_plug is a sibling qdisc whose accounted backlog can still
  wrap, and the patch does not cover it.
- [Low] The patch has no Fixes: tag (and no stable Cc), although it fixes
  a user-visible defect reachable from a user namespace: wrapped AQM…
- [Low] The kernel-doc for QDISC_DROP_OVERLIMIT (include/net/dropreason-
  qdisc.h) defines it as 'the qdisc queue length exceeded its configured…
- [Low] The new header comment on fq_codel_classify() says it returns
  true only when 'a terminal TC action consumed the packet, or the…
- [Low] When the new cake_enqueue() SPLIT_GSO segment-sum check rejects a
  packet, the segment list goes onto *to_free via __qdisc_drop_all(segs,…

--

net/sched: cap the accounted backlog before it can wrap

This patch adds qdisc_backlog_at_max(), which drops packets at enqueue
once the stored 32-bit backlog is within QDISC_PKT_LEN_MAX of U32_MAX.
The guard is applied to fq_codel, cake, codel, pie, fq_pie, dualpi2,
pfifo and red. The GSO pkt_len producer in qdisc_pkt_len_segs_init() is
also clamped, and the fq_codel and cake classify/hash paths are
reordered so that rejected packets do not change flow state.

Closes: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
Link: https://lore.kernel.org/netdev/CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CANn89i+GOFH_8g+vSV0jUj0aBqLYVWuFOrHuDggZu9kPC_m6tQ@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CANn89i+99jPh7JjZf=G3Ouaom2tuOtAEiHUf2MEsRdVPd=nz4w@mail.gmail.com/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-BA27.v3.20260929142417%40mojatatu.com
Link: https://lore.kernel.org/netdev/20261006153043.GM83879@horms.kernel.org/

> The bound is exact for
> every producer: a stab-clamped length is capped by QDISC_PKT_LEN_MAX, and
> the stabless GSO producer is capped by qdisc_pkt_len_segs_init() (the
> SPLIT_GSO path additionally re-checks its segment sum). This follows the
> existing bfifo approach, which bounds bytes against the accounted
> length; gred is a precedent only in WRED mode, where it bounds the
> aggregate, while non-WRED gred bounds each virtual queue.

[Severity: Medium]
Should sch_plug get the same guard? It also makes admission decisions
on the accounted backlog, but it isn't covered by this patch.
plug_enqueue() checks skb->len, while qdisc_enqueue_tail() adds
qdisc_pkt_len():

net/sched/sch_plug.c:plug_enqueue() {
	if (likely((u64)sch->qstats.backlog + skb->len <= q->limit)) {
		if (!q->unplug_indefinite)
			q->pkts_current_epoch++;
		return qdisc_enqueue_tail(skb, sch);
	}
}

The user supplies q->limit as a u32, through plug_init() or
TCQ_PLUG_LIMIT. Take limit = U32_MAX and a 1 MiB stab. A 100 byte skb is
admitted at a backlog of 4095 MiB, because 4293918720 + 100 <= U32_MAX.
The backlog then reaches 2^32 and wraps to 0. While the qdisc is
plugged, the byte limit no longer applies.

Could plug_enqueue() use qdisc_backlog_at_max(), or compare against
qdisc_pkt_len()?

Non-WRED gred has a similar gap. Only each virtual queue is bounded, so
VQ limits that add up to more than 4 GiB can wrap the aggregate
sch->qstats.backlog. The pass-through branch in gred_enqueue() then
admits against the wrapped value:

	if (likely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) <=
				sch->limit))
		return qdisc_enqueue_tail(skb, sch);

> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/

[ ... ]

> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
Should this carry a Fixes: tag, and possibly a stable Cc? It fixes a
defect that users can reach from a user namespace: wrapped AQM backlogs
and the fq_codel_drop() NULL dereference described above.

The patch also depends on commit 8f735d64382d ("net/sched: bound
qdisc_pkt_len to prevent qdisc soft lockup"). That commit added this
clamp in __qdisc_calculate_pkt_len(), plus the QDISC_PKT_LEN_MAX define
that this patch moves:

	pkt_len = clamp_t(int, pkt_len, 1, QDISC_PKT_LEN_MAX);

8f735d64382d carries Fixes: 1da177e4c3f4 and will go to stable. The
QDISC_MAX_BACKLOG headroom argument only holds when it is applied.

Could the commit message name this dependency for backporters?

> diff --git a/net/core/dev.c b/net/core/dev.c
> index f587645e930a1..e6ac94c61ea07 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4268,6 +4268,14 @@ static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
>  		qdisc_skb_cb(skb)->pkt_segs = gso_segs;
>  	}
>  	qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
> +	/* (gso_segs - 1) * hdr_len can exceed QDISC_PKT_LEN_MAX for a dodgy
> +	 * GSO skb, so clamp the producer the same way a size table is
> +	 * clamped (__qdisc_calculate_pkt_len()). The accounted backlog stays
> +	 * within one stab-clamped packet of U32_MAX and cannot wrap.
> +	 */
> +	qdisc_skb_cb(skb)->pkt_len = min_t(unsigned int,
> +					   qdisc_skb_cb(skb)->pkt_len,
> +					   QDISC_PKT_LEN_MAX);
>  	return SKB_NOT_DROPPED_YET;
>  }

[Severity: High]
Does this clamp cover every exit of qdisc_pkt_len_segs_init()? The
function returns early for non-GSO skbs, and for GSO skbs that have no
transport header. In both cases pkt_len is left at skb->len:

	qdisc_skb_cb(skb)->pkt_len = skb->len;
	if (!shinfo->gso_size) {
		qdisc_skb_cb(skb)->pkt_segs = 1;
		return SKB_NOT_DROPPED_YET;
	}
	...
		if (unlikely(!skb_transport_header_was_set(skb)))
			return SKB_NOT_DROPPED_YET;

If the root has no size table, __qdisc_calculate_pkt_len() never runs.
A non-GSO skb larger than 1 MiB is then accounted at its full length.
qdisc_backlog_at_max() reserves only QDISC_PKT_LEN_MAX of headroom and
does not look at the incoming length.

Such skbs look reachable:

- tun_alloc_skb() enlarges the linear part for large writes instead of
  rejecting them.
- act_mirred egress hands them to dev_queue_xmit() without an MTU check.
- loopback sets no max_mtu.

Here is a possible sequence with fq_codel flows >= 2 and limit 4094:

  1. With a 1 MiB stab, queue 4094 small packets into flow 1 and leave
     flow 0 empty. The backlog is 4292870144, which is <=
     QDISC_MAX_BACKLOG (4293918719).

  2. Run tc qdisc change without TCA_STAB. qdisc_change() does:

	rcu_assign_pointer(sch->stab, stab);

     with stab == NULL. The queued packets keep their accounted lengths.

  3. Redirect a 2 MiB non-GSO frame into flow 1. It passes
     qdisc_backlog_at_max(). sch->qstats.backlog and q->backlogs[1] both
     become 4292870144 + 2097152 = 2^32, which is 0.

  4. qlen 4095 is above the limit, so fq_codel_drop() runs. Its strict
     '>' scan keeps idx 0, and dequeue_head(&q->flows[0]) dereferences a
     NULL flow->head.

If this sequence works, the commit message statement "The bound is
exact for every producer" would not hold for stabless non-GSO packets.

Could the clamp be applied on every return path of
qdisc_pkt_len_segs_init(), or after qdisc_calculate_pkt_len()?

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index dc93267029e70..6484c4fa0ccc6 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c

[ ... ]

> @@ -1758,22 +1797,87 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,

[ ... ]

> +	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
> +		struct sk_buff *nskb, *seg;
> +		netdev_features_t features = netif_skb_features(skb);
> +
> +		segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
> +		if (IS_ERR_OR_NULL(segs))
> +			return qdisc_drop(skb, sch, to_free);

[ ... ]

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

[Severity: Low]
What drop reason do the rejected segments carry when they are freed?
They go onto *to_free without one being set. Only skb, or the head in
the fraglist case, gets QDISC_DROP_OVERLIMIT.

tc_skb_cb()->drop_reason is at cb offset 32. That is the same word as
SKB_GSO_CB(skb)->mac_offset. __skb_gso_segment() writes it before the
segments copy the cb:

	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);

__tcf_kfree_skb_list() later reads it back:

	u32 reason = tc_skb_cb(skb)->drop_reason;

The qdisc subsystem bits are clear, so the headroom value goes to
kfree_skb_reason() as an unrelated core drop reason, and
trace_qdisc_drop is skipped. A headroom of 0 or 1 would be read as
SKB_NOT_DROPPED_YET or SKB_CONSUMED.

Should each segment get tcf_set_qdisc_drop_reason(seg,
QDISC_DROP_OVERLIMIT) before it is deferred?

> diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
> index a1ba2e355f2d1..ff7e72989dfc1 100644
> --- a/net/sched/sch_codel.c
> +++ b/net/sched/sch_codel.c
> @@ -116,15 +116,17 @@ static struct sk_buff *codel_peek(struct Qdisc *sch)
>  static int codel_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  			       struct sk_buff **to_free)
>  {
> -	struct codel_sched_data *q;
> +	struct codel_sched_data *q = qdisc_priv(sch);
>  
> -	if (likely(qdisc_qlen(sch) < sch->limit)) {
> -		codel_set_enqueue_time(skb);
> -		return qdisc_enqueue_tail(skb, sch);
> +	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
> +	    unlikely(qdisc_backlog_at_max(sch))) {
> +		WRITE_ONCE(q->drop_overlimit, q->drop_overlimit + 1);
> +		return qdisc_drop_reason(skb, sch, to_free,
> +					 QDISC_DROP_OVERLIMIT);
>  	}

[Severity: Low]
Does QDISC_DROP_OVERLIMIT still describe this drop? Its kernel-doc in
include/net/dropreason-qdisc.h says:

	 * @QDISC_DROP_OVERLIMIT: packet dropped because the qdisc queue
	 * length exceeded its configured limit (sch->limit). This typically
	 * indicates the queue is full and cannot accept more packets.

This patch also uses it for the byte backlog crossing QDISC_MAX_BACKLOG:

- codel_qdisc_enqueue(), where the qlen and ceiling cases can no longer
  be told apart.
- fq_codel_enqueue().
- cake_enqueue(), both the top-level check and the SPLIT_GSO segment-sum
  rejection. cake has no sch->limit packet check at all.
- red_enqueue().

These drops can happen with qlen far below sch->limit. For example,
fq_codel with limit 20000 drops at about 4096 packets. Drop monitor and
tracepoint users would be pointed at sch->limit, and raising it does not
help.

Existing usage is already a little loose here, since the dualpi2
memory_limit drops and the fq_codel memory-limited drops also report
this reason. Could the kernel-doc be updated, or a separate reason used?

[ ... ]

> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> index e6c87a32950f9..7c52acf201c63 100644
> --- a/net/sched/sch_fq_codel.c
> +++ b/net/sched/sch_fq_codel.c
> @@ -73,22 +73,34 @@ static unsigned int fq_codel_hash(const struct fq_codel_sched_data *q,
>  	return reciprocal_scale(skb_get_hash(skb), q->flows_cnt);
>  }
>  
> -static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
> -				      int *qerr)
> +/* Run the optional external classifier. Returns true when the caller must
> + * drop (a terminal TC action consumed the packet, or the result carried no
> + * class ID); the reason is then in *qerr. Else *idx is the 1-based flow
> + * index, or *do_hash asks the caller to use fq_codel_hash().
> + */

[Severity: Low]
Is this comment complete? The body also returns true in two other
cases:

- No filter matched (tcf_classify_qdisc() < 0).
- The minor is present but greater than q->flows_cnt.

		if (TC_H_MIN(res.classid) > 0 &&
		    TC_H_MIN(res.classid) <= q->flows_cnt) {
			*idx = TC_H_MIN(res.classid);
			return false;
		}
	}
	return true;

TC_ACT_SHOT is also a drop with __NET_XMIT_BYPASS, not a consumed
packet, and the cake_tcf_classify() comment uses the same wording.

The two new helpers handle no-match in opposite ways: cake hashes the
packet and fq_codel drops it. That matches the pre-patch behaviour, but
only the cake comment says so. Could the fq_codel comment list all the
drop cases?

[ ... ]

> diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
> index d7598214270b8..e3a254f9dbdf9 100644
> --- a/net/sched/sch_red.c
> +++ b/net/sched/sch_red.c
> @@ -76,6 +76,12 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  	unsigned int len;
>  	int ret;
>  
> +	if (unlikely(qdisc_backlog_at_max(sch))) {
> +		qdisc_qstats_overlimit(sch);
> +		return qdisc_drop_reason(skb, sch, to_free,
> +					 QDISC_DROP_OVERLIMIT);
> +	}
> +
>  	q->vars.qavg = red_calc_qavg(&q->parms,
>  				     &q->vars,
>  				     child->qstats.backlog);

[Severity: Medium]
Can a duplicating netem child get around this check? red_enqueue()
tests the backlog once and then calls qdisc_enqueue() on the child.
netem_enqueue() re-enters the root with the duplicate before it accounts
the original:

net/sched/sch_netem.c:netem_enqueue() {
	if (skb2) {
		struct Qdisc *rootq = qdisc_root_bh(sch);

		skb2->tc_depth++; /* prevent duplicating a dup... */
		rootq->enqueue(skb2, rootq, to_free);
		skb2 = NULL;
	}

	qdisc_qstats_backlog_inc(sch, skb);
}

The nested red_enqueue() sees the same RED backlog that the outer call
checked, so one check admits two packets. The outer call then does
qstats_backlog_add(sch, len) without checking again.

Take a 1 MiB stab, RED in ecn nodrop mode, and a netem child with
duplicate 100% and a large limit. After 2047 inputs the backlog is
4094 MiB, which is still <= QDISC_MAX_BACKLOG. The 2048th input adds two
1 MiB packets, and the RED and netem qstats.backlog both reach 2^32,
which is 0. red_calc_qavg() then reads a wrapped child backlog.

The commit message names child GSO segmentation through
qdisc_tree_reduce_backlog() as a known RED gap, but not this duplication
path. Is this case meant to be covered here, or in the separate change?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-BA27.v5.20261007171509%40mojatatu.com
