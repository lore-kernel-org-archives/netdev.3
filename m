Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05BD36E466
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033711; cv=none; b=FHt8rpjiBo1CiWwmL7t3Jc2IijJ05Aj20VkJckgEmf9kL25lWO3V4QIEcebkJDrPzg/OOuwbE8K6lIaWDQo3RnNTVLkmKjzcBaIkWJKJm1G4rLA3DQBJvqWVb1I/w+cdbZkxWUDz4uQcNoyAbJsYHqnuHG+nA35mme7P7yCbia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033711; c=relaxed/simple;
	bh=7TJYEckY6ymsccnpN4RxWkTGJSmhYEyPqsTuk8P9moI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m+71b9zR2e8TLRADI+6CpOqFDrCJG5NHfF6s+k56aFNF4vOOinCgXCUQEFiI/9WNPFnnWCnoACpx6CZvfItGw1tFExt+YKOjSIoJCs4O4I12kS8HX8t9KEzLUTUhmpCWNSJ0KrgTsWEt2jCu2neVKVHRJKx1Yzryl5/OeWN1q0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii5l1rra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii5l1rra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0B11F000FF;
	Thu, 10 Sep 2026 09:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789033709;
	bh=RJekABWao83ru1JSBqfRyOG/eLqJN+V2YA2rUhRvpjE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ii5l1rraz5dobLBaVEZ50tCKg56Zz1t8ePyiJPtnG6dEqDOWDoR1tzi468zZ0aDH/
	 0wpRaJtWBr4Fe6rEEG8Vv3WlvReH5ABEzWqGHRKY/vi/8OMeSKneYZj9xtN2CnslOZ
	 kGJL2O+VuzPnzqtD41wZ1tPJITJ+Hg48q7aLPgSUncs3cWpyyKcLx9jRy1dN9Bbs4m
	 Nv7LZh4AFOnmx2vM1VqHE7cw5sf8NorRqe3iZwdUu51sfUZfI4Bbt9WTwYabbFiG60
	 Z0cKjQaINoKHWipBVbX5/kwlOJ01lcA+a/sxQjRbpISEaSKCQCyaZ/Xx/6LSPXOy9o
	 t/Yt8jTmxaMjw==
Subject: Re: [PATCH net] net: stmmac: fix TX descriptor availability check for
 TSO traffic
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 peppe.cavallaro@st.com, alexandre.torgue@st.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Thu, 10 Sep 2026 09:48:28 +0000
Message-ID: <178903370842.219967.14155724625684562557@kernel.org>
In-Reply-To:
 <20260907-stmmac-fix-tso-nfrags-check-v1-1-328459906cdb@oss.qualcomm.com>
References:
 <20260907-stmmac-fix-tso-nfrags-check-v1-1-328459906cdb@oss.qualcomm.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0 (1)

- [High] stmmac_tso_xmit() now demands the exact descriptor count
  returned by stmmac_tso_get_num_desc() (stmmac_main.c:4543-4544) but…

Pre-existing issues:
- [High] proto_hdr_len in stmmac_tso_xmit() is declared as u8
  (stmmac_main.c:4524) but is assigned the size_t result of…
- [Low] The stmmac_tso_xmit() kernel-doc states "mss is fixed when enable
  tso, so w/o programming the TDES3 ctx field." (stmmac_main.c:4512),…

--

net: stmmac: fix TX descriptor availability check for TSO traffic

This replaces the (skb->len - proto_hdr_len) / TSO_MAX_BUFF_SIZE + 1
estimate in stmmac_tso_xmit() with stmmac_tso_get_num_desc(), which counts
the header descriptor, the linear payload, every fragment and the MSS
context descriptor. The new count is then used for the free descriptor
check before the ring is programmed.

A few questions below.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 24656b35350b1..3566b33bc34e5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4454,6 +4454,26 @@ static bool stmmac_tso_valid_packet(struct sk_buff *skb)
>  	       header_len + gso_size < 16383;
>  }
>  
> +static int stmmac_tso_get_num_desc(struct stmmac_tx_queue *tx_q,
> +				   struct sk_buff *skb, u32 pay_len)
> +{
> +	int i, ndesc = 1;
> +
> +	/* head payload */
> +	ndesc += DIV_ROUND_UP(pay_len, TSO_MAX_BUFF_SIZE);
> +	/* frag payload */
> +	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
> +		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
> +
> +		ndesc += DIV_ROUND_UP(skb_frag_size(frag),
> +				      TSO_MAX_BUFF_SIZE);
> +	}
> +	/* MSS update requires a new descriptor */
> +	ndesc += !!(skb_shinfo(skb)->gso_size != tx_q->mss);

[Severity: Low]
This is a pre-existing issue and not introduced by this patch, but the new
comment here now contradicts the stmmac_tso_xmit() kernel-doc that follows
a few lines below, which still says:

	 * mss is fixed when enable tso, so w/o programming the TDES3 ctx field.

stmmac_tso_xmit() does program a context descriptor whenever the skb MSS
differs from the cached queue MSS:

	if (mss != tx_q->mss) {
		...
		stmmac_set_mss(priv, mss_desc, mss);
		tx_q->mss = mss;
		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);

Would it make sense to drop or update that kernel-doc sentence while
touching this area?

> +
> +	return ndesc;
> +}
> +
>  /**
>   *  stmmac_tso_xmit - Tx entry point of the driver for oversized frames (TSO)
>   *  @skb : the socket buffer
> @@ -4497,10 +4517,10 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	unsigned int first_entry, entry, tx_packets;
>  	struct stmmac_txq_stats *txq_stats;
> +	int i, first_tx, nfrags, ndesc;
>  	struct stmmac_tx_queue *tx_q;
>  	bool set_ic, is_last_segment;
>  	u32 pay_len, mss, queue;
> -	int i, first_tx, nfrags;
>  	u8 proto_hdr_len, hdr;
>  	dma_addr_t des;
>  
> @@ -4513,14 +4533,15 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	/* Compute header lengths */
>  	proto_hdr_len = stmmac_tso_header_size(skb);
> +	pay_len = skb_headlen(skb) - proto_hdr_len; /* no frags */

[Severity: High]
This isn't a bug introduced by this patch, but the new pay_len computation
inherits an existing truncation. proto_hdr_len is declared u8 while
stmmac_tso_header_size() returns a size_t (skb_transport_offset() +
sizeof(struct udphdr), or skb_tcp_all_headers()), and
stmmac_tso_valid_packet() explicitly admits headers up to 1023 bytes into
the hardware TSO path:

	return header_len <= 1023 && gso_size >= 64 &&
	       header_len + gso_size < 16383;

For a header of 256..1023 bytes the store wraps modulo 256 (486 becomes
230, 256 becomes 0). The truncated value then defines the hardware
contract, both for the payload start address:

	stmmac_tso_allocator(priv, &entry, des + proto_hdr_len, pay_len,
			     (nfrags == 0), queue);

and for the descriptor lengths:

	stmmac_prepare_tso_tx_desc(priv, first, 1, proto_hdr_len, 0, 1,
				   is_last_segment, hdr / 4,
				   skb->len - proto_hdr_len);

so the tail of the real header is handed to the engine as TCP/UDP payload
while TDES3 declares more payload than the following descriptors describe
(a header of exactly 256 also yields a zero length buffer1 with TSE set).
A TCP over IPv6 socket carrying a few hundred bytes of sticky
destination/hop-by-hop options makes skb_tcp_all_headers() exceed 255 while
staying under 1023, so such an skb reaches stmmac_tso_xmit().

For the new pay_len the error biases upward, so the ring accounting stays
safe, but should proto_hdr_len be widened to unsigned int (or size_t) since
this patch now builds the descriptor count on it too?

>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
>  		hdr = sizeof(struct udphdr);
>  	else
>  		hdr = tcp_hdrlen(skb);
>  
> -	/* Desc availability based on threshold should be enough safe */
> -	if (unlikely(stmmac_tx_avail(priv, queue) <
> -		(((skb->len - proto_hdr_len) / TSO_MAX_BUFF_SIZE + 1)))) {
> +	ndesc = stmmac_tso_get_num_desc(tx_q, skb, pay_len);
> +	if (unlikely(stmmac_tx_avail(priv, queue) < ndesc)) {
>  		if (!netif_tx_queue_stopped(netdev_get_tx_queue(dev, queue))) {
>  			netif_tx_stop_queue(netdev_get_tx_queue(priv->dev,
>  								queue));

[Severity: High]
The new requirement is exact, but the TX flow control watermarks were left
unchanged. Can this make the "Tx Ring full when queue awake" branch
reachable for ordinary TSO traffic?

stmmac_tso_get_num_desc() returns at least nfrags + 2 for any TSO skb that
has a linear payload, so with MAX_SKB_FRAGS = 17 plus an MSS change it asks
for 20 descriptors, and up to roughly 23 when individual frags exceed
TSO_MAX_BUFF_SIZE.

The tail of stmmac_tso_xmit() still stops the queue based on the old
assumption:

	if (unlikely(stmmac_tx_avail(priv, queue) <= (MAX_SKB_FRAGS + 1))) {
		netif_dbg(priv, hw, priv->dev, "%s: stop transmitted packets\n",
			  __func__);
		netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, queue));
	}

so the queue is deliberately left awake with as few as 19 free slots, while
the next TSO skb may need more. Does that leave a window where the stack
submits an skb that does not fit, hitting the un-ratelimited netdev_err()
in the ndo_start_xmit hot path together with netif_tx_stop_queue() and a
NETDEV_TX_BUSY requeue?

The non-TSO path keeps the invariant the watermark was designed for,
stmmac_xmit() needs nfrags + 1, which is always satisfied when the queue is
awake:

	if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 1)) {

The only place the queue is re-armed is stmmac_tx_clean():

	if (unlikely(netif_tx_queue_stopped(netdev_get_tx_queue(priv->dev, queue))) &&
	    stmmac_tx_avail(priv, queue) > STMMAC_TX_THRESH(priv)) {
		...
		netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, queue));

STMMAC_TX_THRESH() is dma_tx_size / 4, which is 16 on the 64 entry ring
stmmac_set_ringparam() accepts (DMA_MIN_TX_SIZE in common.h). On such a
ring the wake threshold is itself below the new requirement, so can the
queue be woken while the skb still does not fit, producing a repeating
stop/wake/TX_BUSY cycle with repeated error logging?

Should the stop and wake watermarks be raised to the worst case TSO
descriptor count, or the skb linearized/pushed to software GSO, as part of
this change?

>  @@ -4532,8 +4553,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>  		return NETDEV_TX_BUSY;
>  	}

One more on this branch: it sets XOFF without re-checking availability and
without arming a wake source. If the ring drains concurrently
(dirty_tx == cur_tx, no further TX completion and no NAPI run), does the
XOFF state persist until dev_watchdog fires ndo_tx_timeout?

Since the patch is tagged for stable, would it be worth describing the new
NETDEV_TX_BUSY and error logging behaviour in the commit message?

>  
> -	pay_len = skb_headlen(skb) - proto_hdr_len; /* no frags */
> -
>  	mss = skb_shinfo(skb)->gso_size;
>  
>  	/* set new MSS value if needed */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907-stmmac-fix-tso-nfrags-check-v1-1-328459906cdb%40oss.qualcomm.com
