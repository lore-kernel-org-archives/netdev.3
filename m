Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695774;
	b=d1C1TL3EW6Gkr+U3lZZ/QkS3Pvdy/29uDTFZXNoTGVYDpfQxZjjCfqoEH5JfEl5B3lQp
	 Pl5D91kAe32H1xuUC0bZysbuA7DZqBHtQ//pdvSr9UCWAg1o/73RIpFohqIL5AtX2AZyt
	 hSceMNMHnF97UIBksOOaCe+nUm6R9wqCoVu4K12rsn82TWE2zZ6AnpeyUMYEQOQyzmR6s
	 z8lus1qWXG1gWu9B0xDjUhzSJCZywKqxRMzFe47Uj2pLL8LJ6jJShX9SMZfcs6ZiStz4y
	 B0D3UoJl+DTgm59nna7ofOLYKNfJwNsNm92k3RKhnltkqKRspjoAhRRbvdiGkRAQPEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695774;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NDpuli4IqtoNpm+YHK8wWRZYUu/reWo+WKo0tRkJcOA=;
	b=fMiIqCpNqztR8Vc4GmL0qwPUX+mv8+TkGUw/bMQf9VOifVArjO/RlwJg1MRFCSMcXbvK
	 137jdow876oTOanHaUl1QBYWvuCHxAn1PzXOnB1Cni2WDfQHzE5/cVjOtGWiZqY1ZR8m9
	 b5sQF2LVx9F8fmeGclmuRy+4WDU7H9MUI0lfegVstt1lbR/iDQODvQFpblZgaqrUZnupG
	 CTIAV80vefzBYRaP+ZycLC3BlmvpYtWUJXneKLVWruEhvyoIpqm+eG/Nqx8VTceb5tUDF
	 8QkZ4SSChHimYVnARs1qYkTLfjlISq9F3Cq13nX7C7rIi9JR/9Of9DlsJG1rduuadng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O9VGrljH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65EE606A329
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O9VGrljH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263FB1F01828;
	Thu, 22 Oct 2026 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792695773;
	bh=NDpuli4IqtoNpm+YHK8wWRZYUu/reWo+WKo0tRkJcOA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O9VGrljHODp2tLS5reDAAqxzVZB3fQV6NDVvVdbalxAPIiHTyq4H3entF3XQqsJGm
	 nCtjprRnyoFEKQXq7SxFmQOejuBHBqRn9FQhq+n/nbVm/Z6w8ZwGnd3dCGHr5c1Ddp
	 TO1qVjeUMvsgu0VjZ9EpEvbsWpfxgExT4n3yY30SBdVgmMQBdbvQMyrLJdjhteBmxd
	 fYwDCaGGSFjk8O6skhMdCarj6oRKbgAiPB6uESC8A6oq5qoIp6FCeoWogXQGSxGyw3
	 GAyj0aLm01JT81UAvYrlN/rf0I8OFz0c50WIJeQTajRKukg7EBQ4njG9paNO07z+1L
	 /Rdbc68bfOAlg==
Subject: Re: [PATCH net-next v7 4/4] net/sched: cake: hash before segmenting
 and reject an overlong split
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, toke@toke.dk, bjorn@kernel.org, sashiko-bot@kernel.org
Date: Thu, 22 Oct 2026 19:02:52 +0000
Message-ID: <179269577270.3135.16072065138845192450@kernel.org>
In-Reply-To: <QDISC-BA27.v7.r0.20261019115505-4@mojatatu.com>
References: <QDISC-BA27.v7.r0.20261019115505-4@mojatatu.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] cake_enqueue() (net/sched/sch_cake.c:1825-1827): when
  skb_gso_segment() fails with IS_ERR_OR_NULL(segs), the original skb is…
- [Low] The commit presents itself as a bug fix ('The Fix:') with user-
  visible effects but has no Fixes: trailer.
- [Low] The commit message says cake_enqueue() reads q->config->flow_mode
  'once with READ_ONCE()'.

--

net/sched: cake: hash before segmenting and reject an overlong split

This commit splits cake_hash() into a side-effect-free cake_hash_keys(),
which runs on the unsegmented skb, and cake_hash_resolve(), which runs
only once the packet is admitted. The split-GSO path moves ahead of the
resolution: it sums the segment list, checks the total against
QDISC_MAX_BACKLOG and, on rejection, defers the whole list to to_free
with every segment tagged QDISC_DROP_OVERLIMIT. flow_mode is read once
with READ_ONCE() and passed to both hash helpers.

Link: https://lore.kernel.org/netdev/179231933068.3135.80340792633077986@kernel.org/

> net/sched: cake: hash before segmenting and reject an overlong split
>
> The Fix:
> with CAKE_FLAG_SPLIT_GSO, cake computes the flow/host hash keys, then
> splits a GSO skb into segments it accounts individually.

[ ... ]

> Link: https://lore.kernel.org/netdev/179231933068.3135.80340792633077986@kernel.org/
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
This isn't a bug, but the commit is presented as a fix and has no Fixes:
tag.

It adds the missing check of the segment sum against QDISC_MAX_BACKLOG on
the CAKE_FLAG_SPLIT_GSO path. It also stops cake_hash() state from being
committed for packets that are then dropped. The split-GSO accounting
dates back to when CAKE_FLAG_SPLIT_GSO was added to sch_cake.

Could a Fixes: tag be added so backporters know which kernels need this?

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index 91c33295b30b..730c90af14bd 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c

[ ... ]

> @@ -1761,13 +1784,17 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  {
>  	u32 idx, tin, prev_qlen, prev_backlog, drop_id;
>  	struct cake_sched_data *q = qdisc_priv(sch);
> +	int flow_mode = READ_ONCE(q->config->flow_mode);

[Severity: Low]
The commit message says:

  Read q->config->flow_mode once with READ_ONCE() in cake_enqueue() and
  pass that value to both cake_hash_keys() and cake_hash_resolve().

Is the snapshot complete? Further down in the same cake_enqueue() call,
the flowchain code still reloads the live config with plain loads:

net/sched/sch_cake.c:cake_enqueue() {
    ...
		WRITE_ONCE(flow->deficit, cake_get_flow_quantum(b, flow, q->config->flow_mode));
	} else if (flow->set == CAKE_SET_SPARSE_WAIT) {
    ...
		cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
		cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
	}
    ...
}

cake_config_change() publishes the new mode with WRITE_ONCE() before
cake_change() takes sch_tree_lock(). A concurrent tc change can therefore
let cake_hash_resolve() run with a mode that lacks the dual src/dst bits,
so flow->srchost and flow->dsthost are not updated. The later reload can
then see the dual mode and charge hosts[] bulk counts at stale indices.

These plain loads also race with the WRITE_ONCE() store, which KCSAN can
report.

Would passing the local flow_mode to these three calls as well keep one
mode for the whole enqueue?

>  	int len = qdisc_pkt_len(skb), ret;
>  	u16 flow_override, host_override;
> +	struct sk_buff *segs = NULL;

[ ... ]

> +	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
> +		struct sk_buff *nskb, *seg;
> +		netdev_features_t features = netif_skb_features(skb);
> +
> +		segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
> +		if (IS_ERR_OR_NULL(segs))
> +			return qdisc_drop(skb, sch, to_free);

[Severity: Medium]
The comment a few lines below says SKB_GSO_CB sits over
tc_skb_cb.drop_reason. Doesn't the same aliasing affect this failure
return?

__skb_gso_segment() writes the headroom into that slot before calling
skb_mac_gso_segment(), and that call can still fail. Examples are
-EINVAL on malformed SKB_GSO_DODGY headers from tun/virtio, or -ENOMEM in
skb_segment():

net/core/gso.c:__skb_gso_segment() {
    ...
	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
    ...
	segs = skb_mac_gso_segment(skb, features);
    ...
}

This overwrites the QDISC_DROP_GENERIC that __dev_xmit_skb() set before
enqueue. qdisc_drop() does not write a reason back. __tcf_kfree_skb_list()
then reads the headroom value, finds no qdisc subsystem bits, and passes it
to kfree_skb_reason() as a core skb_drop_reason:

net/sched/sch_generic.c:__tcf_kfree_skb_list() {
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

As a result, the drop gets an unrelated core reason and trace_qdisc_drop
is not emitted.

This return is unchanged from the old code. Since the patch moves this
block and re-tags the reject path for this exact aliasing, could this path
use qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_GENERIC) or a more
specific reason?

> +
> +		/* The split path accounts the segment sum, not the
> +		 * stab-adjusted qdisc_pkt_len(), so check it here.
> +		 */
> +		skb_list_walk_safe(segs, seg, nskb)
> +			slen += seg->len;
> +
> +		if (unlikely((u64)sch->qstats.backlog + slen > QDISC_MAX_BACKLOG)) {
> +			qdisc_qstats_overlimit(sch);
> +			/* __skb_gso_segment() puts SKB_GSO_CB at cb
> +			 * offset 32, over tc_skb_cb.drop_reason; every
> +			 * segment inherits it. Tag each one with the
> +			 * qdisc drop reason.
> +			 */
> +			skb_list_walk_safe(segs, seg, nskb)
> +				tcf_set_qdisc_drop_reason(seg,
> +							  QDISC_DROP_OVERLIMIT);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-BA27.v7.r0.20261019115505%40mojatatu.com
