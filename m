Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433516;
	b=oku+uZeT+fNkalDFRVMxC4dNPxzgKpT//Zr8WlM4np9dhUbU4jPRQwNhfkoeXYUe4D6C
	 8KgmmSwsgruLZBp/r47WVicwZ20S1tkqhjD77t5VIZaKvug8+3v2U1Yi5tZ+c87nemH3X
	 vLiG2rC3pQjDNrhowrj9DD0r27tEf/mVQE77Wze4B6vTHeLLw4oEgdHl4K2JWOIpvCLKW
	 r9/1OMTCqMMdGFpgxLbvYLU7d/Orxobx6qcRicwlwpNHsmAsDXznIE0vk4DINo5cJBRzt
	 uu2Fh72vfM0fQ5BNe4IUmu4wxOFTCUZEufsZNucEHzoKpxfUdhmvyOgARoPk1gH2SlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433516;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type;
	bh=QnEhKYRpP9FnaXBvVg+soWZF6AbQEQAbyDeVAEjKokE=;
	b=wYuQL9mqhNbBGXOg+V6vbMOqNDrXB5nTTaH0WQRRa4G9p7ksi0CrVFWXY5nTQLZUS8W1
	 K4pc/49Z6YGCpp2s7IgvKaXAtxFGIm0khcUAuHPzv4XY2lUFqkTjfFSI5XEHqaHV1NAZM
	 q9Xb16OxKihUG7rQbWxBQgV5O65pWTepo/Gg4hVY2YJncVKq58c1QRAS1cFo7lngk4E/A
	 vZ82ndX5ObhPbzPiqlBqRHPYbci7ICK2sgOEAJyPuEjGYvPBvqciyFHw7ndkGNiE7z8f+
	 DdXPbg6WwfjDW+43vx7lgOQP4ZHv+D0vDcDSW+qIYcMBLMTmrRwoDmzPrOtP77X94xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DFE606A319
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 18:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63DFE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Victor Nogueira
 <victor@mojatatu.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 cake@lists.bufferbloat.net, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v7 1/4] net/sched: cake, fq_codel: return the
 classifier result to the caller
In-Reply-To: <QDISC-BA27.v7.r0.20261019115505-1@mojatatu.com>
References: <QDISC-BA27.v7.r0.20261019115505@mojatatu.com>
 <QDISC-BA27.v7.r0.20261019115505-1@mojatatu.com>
Date: Mon, 19 Oct 2026 20:11:40 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87wlrdwof7.fsf@toke.dk>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> The Fix:
> cake and fq_codel run an optional external classifier from their enqueue
> path and then compute the flow hash inside the helper. Have the helper
> return the filter's overrides (cake) or a 1-based flow index or a request
> to hash (fq_codel) instead, so the caller owns the flow selection.
>
> This is preparation for the accounting changes that follow. Packet
> classification and flow selection are unchanged.

It's not clear to me why this change is needed at all for fq_codel?
fq_codel_hash just does a reciprocal_scale() of the skb hash, it doesn't
mutate any qdisc state. So why can't fq_codel_classify not just stay as
it is?

> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/sch_cake.c     | 35 +++++++++++++++++++-----------
>  net/sched/sch_fq_codel.c | 47 +++++++++++++++++++++++++++++-----------
>  2 files changed, 56 insertions(+), 26 deletions(-)
>
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index dc93267029e7..6432d10c992e 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1712,18 +1712,24 @@ static struct cake_tin_data *cake_select_tin(struct Qdisc *sch,
>  	return &qd->tins[tin];
>  }
>  
> -static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
> -			 struct sk_buff *skb, int flow_mode, int *qerr)
> +/* Run the qdisc's optional external classifier. Returns true when a
> + * terminal TC action consumed the packet, with the reason in *qerr;
> + * otherwise *flow and *host hold the filter's overrides (0 if none).
> + */

This comment is unnecessary, and just repeating what the code does.
Please drop.

> +static bool cake_tcf_classify(struct Qdisc *sch, struct sk_buff *skb,
> +			      u16 *flow, u16 *host, int *qerr)
>  {
>  	struct cake_sched_data *q = qdisc_priv(sch);
>  	struct tcf_proto *filter;
>  	struct tcf_result res;
> -	u16 flow = 0, host = 0;
>  	int result;
>  
> +	*flow = 0;
> +	*host = 0;
> +
>  	filter = rcu_dereference_bh(q->filter_list);
>  	if (!filter)
> -		goto hash;
> +		return false;
>  
>  	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>  	result = tcf_classify_qdisc(skb, filter, &res, false);
> @@ -1737,17 +1743,15 @@ static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
>  			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
>  			fallthrough;
>  		case TC_ACT_SHOT:
> -			return 0;
> +			return true;
>  		}
>  #endif
>  		if (TC_H_MIN(res.classid) <= CAKE_QUEUES)
> -			flow = TC_H_MIN(res.classid);
> +			*flow = TC_H_MIN(res.classid);
>  		if (TC_H_MAJ(res.classid) <= (CAKE_QUEUES << 16))
> -			host = TC_H_MAJ(res.classid) >> 16;
> +			*host = TC_H_MAJ(res.classid) >> 16;
>  	}
> -hash:
> -	*t = cake_select_tin(sch, skb);
> -	return cake_hash(*t, skb, flow_mode, flow, host) + 1;
> +	return false;
>  }
>  
>  static void cake_reconfigure(struct Qdisc *sch);
> @@ -1758,20 +1762,25 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  	u32 idx, tin, prev_qlen, prev_backlog, drop_id;
>  	struct cake_sched_data *q = qdisc_priv(sch);
>  	int len = qdisc_pkt_len(skb), ret;
> +	u16 flow_override, host_override;
>  	struct sk_buff *ack = NULL;
>  	ktime_t now = ktime_get();
>  	struct cake_tin_data *b;
>  	struct cake_flow *flow;
>  	bool same_flow = false;
>  
> -	/* choose flow to insert into */
> -	idx = cake_classify(sch, &b, skb, q->config->flow_mode, &ret);
> -	if (idx == 0) {
> +	/* Classify first: a terminal TC action consumes the packet. */
> +	if (cake_tcf_classify(sch, skb, &flow_override, &host_override, &ret)) {
>  		if (ret & __NET_XMIT_BYPASS)
>  			qdisc_qstats_drop(sch);
>  		__qdisc_drop(skb, to_free);
>  		return ret;
>  	}
> +
> +	/* choose flow to insert into */
> +	b = cake_select_tin(sch, skb);
> +	idx = cake_hash(b, skb, q->config->flow_mode, flow_override,
> +			host_override) + 1;
>  	tin = (u32)(b - q->tins);
>  	idx--;
>  	flow = &b->flows[idx];
> diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> index e6c87a32950f..011b8fc54d84 100644
> --- a/net/sched/sch_fq_codel.c
> +++ b/net/sched/sch_fq_codel.c
> @@ -73,22 +73,38 @@ static unsigned int fq_codel_hash(const struct fq_codel_sched_data *q,
>  	return reciprocal_scale(skb_get_hash(skb), q->flows_cnt);
>  }
>  
> -static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
> -				      int *qerr)
> +/* Run the qdisc's optional external classifier. Returns true when the
> + * caller must drop the packet, with the reason in *qerr: a terminal TC
> + * action consumed it, or no valid class in 1..q->flows_cnt was
> + * selected (no filter matched, the result carried no class ID, or its
> + * minor was above q->flows_cnt). Unlike cake, a packet with no valid
> + * class is dropped here (a BYPASS drop) rather than falling back to
> + * hashing. Otherwise *idx is the 1-based flow index, or *do_hash asks
> + * the caller to use fq_codel_hash().
> + */
> +static bool fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
> +			      unsigned int *idx, bool *do_hash, int *qerr)
>  {
>  	struct fq_codel_sched_data *q = qdisc_priv(sch);
>  	struct tcf_proto *filter;
>  	struct tcf_result res;
>  	int result;
>  
> +	*idx = 0;
> +	*do_hash = false;
> +
>  	if (TC_H_MAJ(skb->priority) == sch->handle &&
>  	    TC_H_MIN(skb->priority) > 0 &&
> -	    TC_H_MIN(skb->priority) <= q->flows_cnt)
> -		return TC_H_MIN(skb->priority);
> +	    TC_H_MIN(skb->priority) <= q->flows_cnt) {
> +		*idx = TC_H_MIN(skb->priority);
> +		return false;
> +	}
>  
>  	filter = rcu_dereference_bh(q->filter_list);
> -	if (!filter)
> -		return fq_codel_hash(q, skb) + 1;
> +	if (!filter) {
> +		*do_hash = true;
> +		return false;
> +	}
>  
>  	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>  	result = tcf_classify_qdisc(skb, filter, &res, false);
> @@ -101,13 +117,16 @@ static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
>  			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
>  			fallthrough;
>  		case TC_ACT_SHOT:
> -			return 0;
> +			return true;
>  		}
>  #endif
> -		if (TC_H_MIN(res.classid) <= q->flows_cnt)
> -			return TC_H_MIN(res.classid);
> +		if (TC_H_MIN(res.classid) > 0 &&
> +		    TC_H_MIN(res.classid) <= q->flows_cnt) {
> +			*idx = TC_H_MIN(res.classid);
> +			return false;
> +		}
>  	}
> -	return 0;
> +	return true;
>  }
>  
>  /* helper functions : might be changed when/if skb use a standard list_head */
> @@ -188,17 +207,19 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  	struct fq_codel_sched_data *q = qdisc_priv(sch);
>  	unsigned int idx, prev_backlog, prev_qlen;
>  	struct fq_codel_flow *flow;
> -	int ret;
> +	bool do_hash = false;
>  	unsigned int pkt_len;
>  	bool memory_limited;
> +	int ret;
>  
> -	idx = fq_codel_classify(skb, sch, &ret);
> -	if (idx == 0) {
> +	if (fq_codel_classify(skb, sch, &idx, &do_hash, &ret)) {
>  		if (ret & __NET_XMIT_BYPASS)
>  			qdisc_qstats_drop(sch);
>  		__qdisc_drop(skb, to_free);
>  		return ret;
>  	}
> +	if (do_hash)
> +		idx = fq_codel_hash(q, skb) + 1;
>  	idx--;
>  
>  	codel_set_enqueue_time(skb);
> -- 
> 2.43.0
