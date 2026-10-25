Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792947268;
	b=j90UUHqdHcfqWjAxhoxxpxZbS73woXKzJshMPbvWCuUaNE/ZvnI6o4mi4h1udeutY6wU
	 Nr22torgms1UMDTYrvObDU8gfFmIrcL0iY0Kf/9sClsMOXra8IK7maqtuH5rtcFehIfu5
	 Bbr2CNbJCwll8Z7p872N5aUUi9YdlkpJ8PsFtXwGzD7CwfUj84qe1LnDT6GobWQPFNaao
	 P441dKN8moYFM7cvTDYRBkR+z76tLX51dhRAButPV7bBXhKA45EEvV1dffR0aRGPCO08c
	 ZYlO3IWyHCJQ5kJ1HJChjghv36zeryQV36IPENBUWIgfNEEk7mPxnQqnl0rBGpgAiHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792947268;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GpToWoO8iZOVJNv7FQSjwzN3FKY8QIP81bPI85QyRNs=;
	b=Nnd6RDBXkr9WRTtRk5A8B2OUuK+Wy2HyEGltarO3z4cglvlDfhIjAVWg2y71z9Sdjq+j
	 C5cgmnT/yZ7ldGE99lg5NWz/MFAMnLImOvIevJ57n6IUBakLxeOG+lMPVsLrfPLBZ3JX2
	 unL/eUqnViOVBw7uENnm3E8pMVqNbmYqmCYTwspoimf0xFpqi9mbhQwMqxN8eTPUBQ/Nc
	 8TErmWm8olDptgDP5vXmU9ySEJnrmzc28T7jijJ2tvLs2fBbVMYTYfvgJ9bRfNMHEhtL3
	 qNwwSAQ7gbBRfwpvmhQkwGrzZVBb9OxlKfLgykjpv+6pnjpGx5Ph1yt+2HEQsp7SG9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wy5RrRo9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FC3606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wy5RrRo9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C08F1F01825;
	Sun, 25 Oct 2026 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792947267;
	bh=GpToWoO8iZOVJNv7FQSjwzN3FKY8QIP81bPI85QyRNs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wy5RrRo9rhtTjM6V9DRzdYCShHNVEL6sg4UkpVE2qL0IG61NcvRZAOSjbaA1rRC55
	 NSnFmPZJjK0uj5Du6O9X8XOzyYH67ij7Obbfy4P5/awgAMZa0Kro5OIflXHbWObhnS
	 kukJx3R8glICx1tBwlGPBtY9BQ5598rdwzyWnCzCTASYZKI5f9MQzhToREHqYOglJ5
	 4uNnhjY+T6HP5CpjaxQpAn9FY+6DdWb3K4ej6h3SdfXLsta93AyEScax73nHgG7XHK
	 OCxDyCj1uJO25FboPl1Asfe0iZjc2MAKRXGsCdSAJSMP/W3OSyPlzhhpm0bD8Yo5Mp
	 KKYKDbWoD5JvQ==
Subject: Re: [PATCH net] net/sched: re-cap skb->queue_mapping before indexing
 dev->_tx[]
From: netdev-bot+sashiko@kernel.org
To: phx0fer@gmail.com
Cc:
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org, kuba@kernel.org
Date: Sun, 25 Oct 2026 16:54:27 +0000
Message-ID: <179294726704.3134.231299812957492091@kernel.org>
In-Reply-To: <20261021155450.66934-1-phx0fer@gmail.com>
References: <20261021155450.66934-1-phx0fer@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [High] qdisc_restart() caps queue_mapping only on the head skb that
  dequeue_skb() returns, but dequeue_skb() can return a list linked…

--

net/sched: re-cap skb->queue_mapping before indexing dev->_tx[]

This commit adds a netdev_cap_txqueue() call in qdisc_restart(). It
clamps skb->queue_mapping before skb_get_tx_queue() indexes dev->_tx[],
because a tc BPF program on a transmit qdisc can store an out-of-range
queue_mapping.

> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 6f6a6f0d5eb0d..c326d12942e52 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -432,6 +432,13 @@ static inline bool qdisc_restart(struct Qdisc *q, int *packets, int budget)
>  		root_lock = qdisc_lock(q);
>  
>  	dev = qdisc_dev(q);
> +	/* A tc BPF program attached to a transmit qdisc can store an
> +	 * arbitrary skb->queue_mapping after the tx queue was picked, so
> +	 * the value reaching here is not necessarily one the device can
> +	 * serve.  Re-cap it before it indexes dev->_tx[].
> +	 */
> +	skb_set_queue_mapping(skb,
> +			      netdev_cap_txqueue(dev, skb_get_queue_mapping(skb)));

[Severity: High]
Is this cap early enough? dequeue_skb() runs before it, and it can index
dev->_tx[] with a BPF-written mapping in two places in this file.

First, take a qdisc without TCQ_F_ONETXQUEUE, such as prio as root of a
multiqueue device. There, try_bulk_dequeue_skb_slow() parks an skb whose
mapping differs from the head's on skb_bad_txq, and leaves the mapping
unchanged:

net/sched/sch_generic.c:try_bulk_dequeue_skb_slow() {
    ...
		if (unlikely(skb_get_queue_mapping(nskb) != mapping)) {
			qdisc_enqueue_skb_bad_txq(q, nskb);
			break;
		}
    ...
}

On the next qdisc_restart(), the path
dequeue_skb()->qdisc_dequeue_skb_bad_txq()->__skb_dequeue_bad_txq()
does:

	skb = skb_peek(&q->skb_bad_txq);
	if (skb) {
		/* check the reason of requeuing without tx lock first */
		txq = skb_get_tx_queue(txq->dev, skb);
		if (!netif_xmit_frozen_or_stopped(txq)) {

Say the classifier writes 0 on one packet and 1000 on the next. Wouldn't
this read &dev->_tx[1000].state before the new cap runs?

Second, dev_requeue_skb() puts every unsent skb of a returned list on
q->gso_skb without changing it. Only the head of a bulk list is capped
here. So on NETDEV_TX_BUSY, on a stopped queue partway through the list,
or on the XFRM "again" path, the tail skbs are requeued with their
original mapping. The gso_skb branch of dequeue_skb() then does:

		/* check the reason of requeuing without tx lock first */
		txq = skb_get_tx_queue(txq->dev, skb);
		if (!netif_xmit_frozen_or_stopped(txq)) {

using that uncapped value.

The queue_mapping store rewrite in bpf_convert_ctx_access() only drops
stores >= NO_QUEUE_MAPPING. Any value below 0xffff can therefore reach
both paths, so the new comment's "Re-cap it before it indexes dev->_tx[]"
doesn't hold for them.

The existing cap in netdev_tx_queue_mapping() in net/core/dev.c is
applied where the value is produced, not at one consumer. Would capping
after the egress qdisc's classifier runs during enqueue, or in the ctx
store rewrite, cover all of these consumers instead of adding a cap in
qdisc_restart()?

>  	txq = skb_get_tx_queue(dev, skb);
>  
>  	return sch_direct_xmit(skb, q, dev, txq, root_lock, validate);

[Severity: High]
This caps only the head skb, but dequeue_skb() can return a list linked
through skb->next. try_bulk_dequeue_skb_slow() chains up to 8 skbs that
share the head's original mapping:

	int mapping = skb_get_queue_mapping(skb);
	...
		skb->next = nskb;
		skb = nskb;
	} while (++cnt < 8);

try_bulk_dequeue_skb() is used for TCQ_F_ONETXQUEUE qdiscs such as
mq/mqprio children. It chains skbs without checking their mapping at all.

Suppose a cls_bpf program writes 100 on every packet. After this change
the head skb maps to 0, but every other skb in the list still carries
100. sch_direct_xmit()->dev_hard_start_xmit() then walks the whole list:

	while (skb) {
		struct sk_buff *next = skb->next;

		skb_mark_not_on_list(skb);
		rc = xmit_one(skb, dev, txq, next != NULL);

xmit_one() passes each skb to ndo_start_xmit. Drivers such as virtio_net
index their per-queue arrays with the raw mapping:

drivers/net/virtio_net.c:start_xmit() {
	int qnum = skb_get_queue_mapping(skb);
	struct send_queue *sq = &vi->sq[qnum];
	int err;
	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
    ...
}

Can this still overrun vi->sq[] and dev->_tx[] for every packet after the
first in a bulk batch?

The commit message says:

    The same stale value is then handed to dev_hard_start_xmit(), which
    reports the same fault.

That path still looks reachable for the tail skbs. These tail skbs can
also be requeued to gso_skb, where they hit the uncapped lookup in
dequeue_skb() described above.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021155450.66934-1-phx0fer%40gmail.com
