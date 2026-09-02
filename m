Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6927473;
	Wed,  2 Sep 2026 02:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788316447; cv=none; b=S8IDrulxhuTZ1SowmCmUDuUB6FPbyAg9QNQW5AFs4GMgmHndanED7VFYEVuRYu6m3GZVfOn+1sBeZNipoPdb168Go6bB5HKIx5sUR3GplFAgDQLaxbQ0Tb19S/w86rKNf1p6qowXhJ5eJIr1CRMH1OewOa5+i7GAQvWDth9d8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788316447; c=relaxed/simple;
	bh=JUYmhXFP2a2YF0aKT7MyPblCcJHehWaM3wUVtQBEyTk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jWliiodn+G/KuUawOWfFhd+0Vo/KRqQyzuwWNde3GByiWtrTHouz8Hc7rRXBVwwbhUTQLjZmfr43unY7qm/da5s+45mOQ7Cq8RtEacsnHQIlUyeqPYHdRxaV0pfcbxVWxSqBVbH5x+YO5DSXXiGnvIr75L5xROveN/Lqu4nQsNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3OPvIS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3OPvIS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D03A1F000E9;
	Wed,  2 Sep 2026 02:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788316445;
	bh=Dc77wljZJgDwExXbT/HbdCINRwERCtbm+9vwDrcagrw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O3OPvIS5OUYk7DSuD2XymwXDwG8ScWkcePfMWhG1VsM/gCmD/cRkkdSah77tFfGRL
	 +SIdmhUrNlwj5CBoNzdwconswFwjnweJtiRZKThtAvVziamtUdm/qwWx4g0jI5wUtl
	 DQzdn7uQaHdGw+9RgDw5C7OhAZldR5hBTyxJ2zbpcekUN3EdzAKWCcjWVz+j7Q4yZN
	 ta5OjIlrboTemdUPVMENnEKH9smm+4TuTih5kk6Irzn5EV8GGPMM07bo8p5Obq/PGb
	 5KHnV9bRkGiMMAqi42S9lZWak2UjUOuZdKMJWMB5F46xHf6dczHTR+lL+UmVX300KX
	 4kzHSuJM6ZCLA==
Subject: Re: [net] net: macb: exclude software FCS from TX byte statistics
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com,
 conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 david.laight.linux@gmail.com, linux-kernel@vger.kernel.org
Date: Wed, 02 Sep 2026 02:34:04 +0000
Message-ID: <178831644461.3394541.6866889296253430552@kernel.org>
In-Reply-To: <20260831113128.1678674-1-nb@tipi-net.de>
References: <20260831113128.1678674-1-nb@tipi-net.de>
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

Critical: 0 (1) · High: 0 · Medium: 1 (1) · Low: 0

- [Medium] Incomplete fix: the software FCS can be appended twice to the
  same skb, so tx_bytes is still over-reported by four bytes and the new…

Pre-existing issues:
- [Critical] Use-after-free / double-free of an skb plus leak of the
  replacement skb: macb_pad_and_fcs()…
- [Medium] macb_pad_and_fcs() writes the four software FCS bytes into a
  cloned skb's shared data allocation without unsharing it.

--

net: macb: exclude software FCS from TX byte statistics

The patch records how many FCS bytes macb_pad_and_fcs() appended in
software into a new macb_tx_skb.fcs_len field, and subtracts that value
from skb->len when TX completion updates tx_bytes.  BQL accounting keeps
using the padded skb->len.

Referenced series: https://lore.kernel.org/all/20260824134703.766708-1-nb@tipi-net.de/

> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 1e1f52285a39..d6931c41f39d 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -968,6 +968,8 @@ struct macb_dma_desc_ptp {
>   *       of the frame
>   * @mapping: DMA address of the skb's fragment buffer
>   * @size: size of the DMA mapped buffer
> + * @fcs_len: FCS bytes appended in software, 0 or ETH_FCS_LEN, only
> + *           set for the last buffer of the frame
>   * @mapped_as_page: true when buffer was mapped with skb_frag_dma_map(),
>   *                  false when buffer was mapped with dma_map_single()
>   */
> @@ -975,6 +977,7 @@ struct macb_tx_skb {
>  	struct sk_buff		*skb;
>  	dma_addr_t		mapping;
>  	size_t			size;
> +	u8			fcs_len;
>  	bool			mapped_as_page;
>  };
>  

[ ... ]

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 76ee4f506033..b1939da4c95a 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -1450,8 +1450,8 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
>  					    skb->data);
>  				bp->netdev->stats.tx_packets++;
>  				queue->stats.tx_packets++;
> -				bp->netdev->stats.tx_bytes += skb->len;
> -				queue->stats.tx_bytes += skb->len;
> +				bp->netdev->stats.tx_bytes += skb->len - tx_skb->fcs_len;
> +				queue->stats.tx_bytes += skb->len - tx_skb->fcs_len;
>  				packets++;
>  				bytes += skb->len;
>  			}

[ ... ]

> @@ -2417,6 +2419,7 @@ static inline int macb_clear_csum(struct sk_buff *skb)
>  	return 0;
>  }
>  
> +/* Returns a negative errno, or the FCS bytes appended (0 or ETH_FCS_LEN). */
>  static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *netdev)
>  {
>  	bool cloned = skb_cloned(*skb) || skb_header_cloned(*skb) ||
> @@ -2465,7 +2468,7 @@ static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *netdev)
>  	skb_put_u8(*skb, (fcs >> 16)	& 0xff);
>  	skb_put_u8(*skb, (fcs >> 24)	& 0xff);
>  
> -	return 0;
> +	return ETH_FCS_LEN;
>  }

[Severity: Medium]
This is a pre-existing issue, not something introduced here, but can these
four skb_put_u8() writes land in data shared with another sk_buff?

macb_pad_and_fcs() computes:

	bool cloned = skb_cloned(*skb) || skb_header_cloned(*skb) ||
		      skb_is_nonlinear(*skb);

and only copies via skb_copy_expand() under "if (cloned || tailroom <
padlen)".  For a linear skb with skb->len >= ETH_ZLEN and skb_tailroom()
>= ETH_FCS_LEN the earlier

	if (padlen <= 0) {
		/* FCS could be appeded to tailroom. */
		if (tailroom >= ETH_FCS_LEN)
			goto add_fcs;

jumps past that copy, so the FCS is written into the possibly shared data
area.

One case where the written bytes are still inside a clone's valid range:
packet_rcv() clones the skb for a tap, then ip_rcv_core() calls
pskb_trim_rcsum(), which only moves the original's tail.  Forwarding that
skb out a macb port then overwrites four bytes that the clone (and
userspace) still considers payload.

Would using skb_unshare()/skb_cow() before the "goto add_fcs" fast path be
appropriate here?

>  
>  static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
> @@ -2478,6 +2481,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
>  	netdev_tx_t ret = NETDEV_TX_OK;
>  	unsigned int hdrlen;
>  	unsigned long flags;
> +	int fcs_len;
>  	bool is_lso;
>  
>  	if (macb_clear_csum(skb)) {
> @@ -2485,7 +2489,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
>  		return ret;
>  	}
>  
> -	if (macb_pad_and_fcs(&skb, netdev)) {
> +	fcs_len = macb_pad_and_fcs(&skb, netdev);
> +	if (fcs_len < 0) {
>  		dev_kfree_skb_any(skb);
>  		return ret;
>  	}

[Severity: Medium]
Does the requeue path still report tx_bytes four bytes too large?

macb_pad_and_fcs() runs here, before the descriptor space check later in
macb_start_xmit():

	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
		       bp->tx_ring_size) < desc_cnt) {
		netif_stop_subqueue(netdev, q);
		...
		ret = NETDEV_TX_BUSY;
		goto unlock;
	}

On NETDEV_TX_BUSY the core hands the same skb back:

sch_direct_xmit()
    if (!dev_xmit_complete(ret)) {
        /* Driver returned NETDEV_TX_BUSY - requeue skb */
        dev_requeue_skb(skb, q);

so macb_start_xmit() -> macb_pad_and_fcs() runs on that skb a second time.
The early-exit predicate (features, ip_summed, gso_size, ptp state) is
unchanged, padlen = ETH_ZLEN - skb->len is now <= 0, so the code reaches
add_fcs again and appends a second four-byte CRC computed over
payload+FCS1.

macb_tx_map() then stores fcs_len = ETH_FCS_LEN while skb->len contains
2 * ETH_FCS_LEN software bytes, so macb_tx_complete() and
macb_tx_error_task() still add four bytes too many:

	bp->netdev->stats.tx_bytes += skb->len - tx_skb->fcs_len;

and the frame on the wire carries the stale first FCS as trailing payload.

Reaching the NETDEV_TX_BUSY branch needs desc_cnt >= 2, i.e. a
software-FCS frame longer than bp->max_tx_length.  In-tree configurations
allow that: mpfs_config has .max_tx_length = 4040 with .jumbo_max_len =
4040, and pic64hpsc_config has .jumbo_max_len = 16383 against
GEM_MAX_TX_LEN of 16320, so with jumbo MTU a frame grown by the software
FCS spans two descriptors and CIRC_SPACE == 1 yields NETDEV_TX_BUSY.

Would moving the macb_pad_and_fcs() call after the CIRC_SPACE check (or
otherwise making the append idempotent) address this?  Since the chosen
representation records only the length of the last append, should the
changelog also mention the requeue interaction?

[Severity: Critical]
This isn't a bug introduced by this patch, but the same ordering looks like
it can free the caller's skb and then tell the core to reuse it.

macb_pad_and_fcs() substitutes the skb only through the caller's local
pointer:

	if (cloned || tailroom < padlen) {
		nskb = skb_copy_expand(*skb, 0, padlen, GFP_ATOMIC);
		if (!nskb)
			return -ENOMEM;

		dev_consume_skb_any(*skb);
		*skb = nskb;
	}

If macb_start_xmit() afterwards takes the

		ret = NETDEV_TX_BUSY;
		goto unlock;

path, nskb is dropped on the floor and the core continues with the
original pointer:

dev_hard_start_xmit()
    rc = xmit_one(skb, dev, txq, next != NULL);
    if (unlikely(!dev_xmit_complete(rc))) {
            skb->next = next;
            goto out;

That is a write into the already freed sk_buff, and sch_direct_xmit() then
calls dev_requeue_skb() on it, so it is dequeued, transmitted and freed a
second time, while nskb leaks.

The preconditions coexist: a forwarded or bridged nonlinear frame has
skb_tailroom() == 0 and cloned == true, so the skb_copy_expand() /
dev_consume_skb_any() path is always taken, and on mpfs_config
(.max_tx_length = 4040, .jumbo_max_len = 4040) or pic64hpsc_config
(GEM_MAX_TX_LEN 16320 against .jumbo_max_len 16383) the frame plus the
four FCS bytes needs two descriptors, so CIRC_SPACE == 1 returns
NETDEV_TX_BUSY.

Should the space check happen before any skb is consumed or replaced?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831113128.1678674-1-nb%40tipi-net.de
