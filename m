Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB4C2D8DA8;
	Mon, 21 Sep 2026 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984889; cv=none; b=MLGP+uTGLhHBXQpCfhfbpXmYFh+pWbys5LqV/Ef+24GSxB3kNmAwPOGO1Yy5bBc1DW5MRsiE2PDxgpo7IjChk/fXlSNI+TfMT+CsGKDYc6BlDm046ujW903jCCES6YWt37wcJymwc+ZG4YlsP1qsxX/xFjpaRyIEkKiK3pSpaG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984889; c=relaxed/simple;
	bh=wxaewxrEB+uoU5ttmH9zstsQaabickXV4tjVmy5lPQA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lgRLAZi+g2L0SMOImMLtcZfR6LOVNpFwkZ5m31ODNFA4mcA7xu0Yz8aXafZjyySWj1rQWeVHSQV5gVjR6rlxdwgReXVBranpL5/HDVDfXa5wvxHkCjLFchMfCSS5PboEy3KQDMAdNf6+OPg8hBHm82mjwjT6mO4y83EzU/YP/20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzR4lN1k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzR4lN1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBB41F000FF;
	Mon, 21 Sep 2026 10:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789984887;
	bh=Bsp5Dl9hE7Sk5T9zUzuExl2x6QwWgmYKxou+GHV1kSU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QzR4lN1kg0hi30PUyeisbzsjNgASRRd0KFFzSlCz3/ozGXL6ceMorp2PDzDhCEQni
	 wNQx2GO11dP98gSN8DljVDsZmgxsdIra5Je7k++XTAnRx1DphdE0s/8uNLwEmxX8oh
	 BfU2ws+YoTDp0mWtUErt9o3nDTb8+dD5iapmF6bw2QatLmHC4Xc9gO60vmbZnCG0AT
	 tqgDpgIQvTp7cOnloG6cTMNDM2jXJFHjTnqYmLYh96shMksTbAviGYjWNInCfX2UcM
	 wz30fyiGmY5cVNMT/Hnwha087hHZB13XiPr6/2/kMSg7WgGtde54Sz0kuzyh3Kc+H4
	 UmUE8jRJxCLqA==
Subject:
 Re: [PATCH] net: macb: rate limit netdev error info print in the data path
From: netdev-bot+sashiko@kernel.org
To: taozj888@163.com
Cc: maintainer@kernel.org, linux-kernel@vger.kernel.org,
 theo.lebrun@bootlin.com, conor.dooley@microchip.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, kuba@kernel.org
Date: Mon, 21 Sep 2026 10:01:26 +0000
Message-ID: <178998488647.2160803.1346494444640418442@kernel.org>
In-Reply-To: <20260920095839.62852-1-taozj888@163.com>
References: <20260920095839.62852-1-taozj888@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 (1) · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the patch rate-limits only 4 netdev_err() sites,
  leaving the equally floodable peer prints in the very same RX/TX data…
- [Low] The commit message describes a user-visible defect (unbounded
  console flooding from gem_rx() delaying boot) but carries only a…

Pre-existing issues:
- [Critical] Use-after-free of the skb the network stack still owns:
  macb_start_xmit() calls macb_pad_and_fcs(&skb, netdev) at…

--

net: macb: rate limit netdev error info print in the data path

The patch wraps five netdev_err() calls in the macb receive and transmit
paths with net_ratelimit(), so a flood of bad descriptors or LSO errors no
longer prints unbounded messages.  The motivating case is "not whole frame
pointed by descriptor" repeating from gem_rx() during boot.

No Link: tags were present in the commit header.

[Severity: Low]
This isn't a bug in the code, but the changelog describes a user-visible
defect (boot delayed by unbounded printing from gem_rx()) and the patch
carries only:

  Signed-off-by: Zijin Tao <taozj888@163.com>

Should this carry a Fixes tag and name the intended tree?  The unconditional
print in gem_rx() goes back to commit 4df95131ea80 ("net/macb: change RX
path for GEM"), which isn't referenced, and there is no note about whether
this is aimed at net or net-next.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index b8234ac4b602..c32d48d03008 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1617,16 +1617,16 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
>  		count++;
>  
>  		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
> -			netdev_err(bp->netdev,
> -				   "not whole frame pointed by descriptor\n");
> +			if (net_ratelimit())
> +				netdev_err(bp->netdev, "not whole frame pointed by descriptor\n");
>  			bp->netdev->stats.rx_dropped++;
>  			queue->stats.rx_dropped++;
>  			break;
>  		}
>  		skb = queue->rx_skbuff[entry];
>  		if (unlikely(!skb)) {
> -			netdev_err(bp->netdev,
> -				   "inconsistent Rx descriptor chain\n");
> +			if (net_ratelimit())
> +				netdev_err(bp->netdev, "inconsistent Rx descriptor chain\n");
>  			bp->netdev->stats.rx_dropped++;
>  			queue->stats.rx_dropped++;
>  			break;

[Severity: High]
The changelog says the change will "rate limit the netdev error information
print in the receive and transmit data path", but several equally floodable
netdev_err() calls in the same paths are left as they are.  Can the same
console flood still be produced through them?

In the receive path, gem_rx() ends with gem_rx_refill(queue), which prints
once per NAPI poll while allocations keep failing:

drivers/net/ethernet/cadence/macb_main.c:gem_rx_refill() {
	...
			skb = netdev_alloc_skb(bp->netdev, bp->rx_buffer_size);
			if (unlikely(!skb)) {
				netdev_err(bp->netdev,
					   "Unable to allocate sk_buff\n");
				break;
			}
	...
}

In the transmit path, macb_start_xmit() -> macb_tx_map() prints once per
skb, and a dma_map failure tends to persist:

drivers/net/ethernet/cadence/macb_main.c:macb_tx_map() {
	...
	/* Should never happen */
	if (unlikely(!tx_skb)) {
		netdev_err(bp->netdev, "BUG! empty skb!\n");
		return 0;
	}
	...
dma_error:
	netdev_err(bp->netdev, "TX DMA map failed\n");
	...
}

The at91ether entry points in the same file are in the same situation.
at91ether_start_xmit() returns NETDEV_TX_BUSY from the busy branch, so
sch_direct_xmit() -> dev_requeue_skb() -> __netif_schedule() retries the
same skb and the message can repeat at softirq rate:

drivers/net/ethernet/cadence/macb_main.c:at91ether_start_xmit() {
	...
		if (dma_mapping_error(dev, bp->rm9200_txq[desc].mapping)) {
			dev_kfree_skb_any(skb);
			netdev->stats.tx_dropped++;
			netdev_err(netdev, "%s: DMA mapping error\n", __func__);
			return NETDEV_TX_OK;
		}
	...
	} else {
		netdev_err(netdev, "%s called, but device is busy!\n",
			   __func__);
		return NETDEV_TX_BUSY;
	}
}

And at91ether_interrupt() prints from hard IRQ on every receive overrun,
which is the same remotely triggered error storm the changelog describes:

drivers/net/ethernet/cadence/macb_main.c:at91ether_interrupt() {
	...
	if (intstatus & MACB_BIT(ISR_ROVR))
		netdev_err(netdev, "ROVR error\n");
	...
}

Would it make sense to convert these as well, or to narrow the changelog to
the sites that are actually covered?

[ ... ]

> @@ -2511,7 +2513,8 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
>  		else
>  			hdrlen = skb_tcp_all_headers(skb);
>  		if (skb_headlen(skb) < hdrlen) {
> -			netdev_err(bp->netdev, "Error - LSO headers fragmented!!!\n");
> +			if (net_ratelimit())
> +				netdev_err(bp->netdev, "Error - LSO headers fragmented!!!\n");
>  			/* if this is required, would need to copy to single buffer */
>  			return NETDEV_TX_BUSY;
>  		}

[Severity: Critical]
This isn't a bug introduced by this patch, but while looking at the
NETDEV_TX_BUSY returns in macb_start_xmit(): can the non-LSO ring-full
return use an skb that was already freed?

macb_start_xmit() calls macb_pad_and_fcs(&skb, netdev) early on, and that
helper can free the pointer the transmit core still holds:

drivers/net/ethernet/cadence/macb_main.c:macb_pad_and_fcs() {
	...
	if (cloned || tailroom < padlen) {
		nskb = skb_copy_expand(*skb, 0, padlen, GFP_ATOMIC);
		if (!nskb)
			return -ENOMEM;

		dev_consume_skb_any(*skb);
		*skb = nskb;
	}
	...
}

Execution then continues, and the ring-full check can return
NETDEV_TX_BUSY:

drivers/net/ethernet/cadence/macb_main.c:macb_start_xmit() {
	...
	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
		       bp->tx_ring_size) < desc_cnt) {
		netif_stop_subqueue(netdev, q);
		...
		ret = NETDEV_TX_BUSY;
		goto unlock;
	}
	...
}

NETDEV_TX_BUSY is not a completion status, so the core writes into the skb
it passed in and then requeues it:

net/core/dev.c:dev_hard_start_xmit() {
	...
		rc = xmit_one(skb, dev, txq, next != NULL);
		if (unlikely(!dev_xmit_complete(rc))) {
			skb->next = next;
			goto out;
		}
	...
}

sch_direct_xmit() then hands that pointer to dev_requeue_skb(), which
stores it in q->gso_skb for a later dequeue and transmit.

Both conditions look independently satisfiable: a short or tailroom-poor,
non-CHECKSUM_PARTIAL, cloned or nonlinear frame on a NETIF_F_HW_CSUM
interface gets replaced by macb_pad_and_fcs(), and CIRC_SPACE() can be
below desc_cnt at that moment under sustained transmit load.

The LSO branch shown in this hunk avoids the sequence only because
macb_pad_and_fcs() returns 0 early when skb_shinfo(*skb)->gso_size is set.
Is the non-LSO ring-full path meant to return NETDEV_TX_BUSY after the skb
may have been replaced?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260920095839.62852-1-taozj888%40163.com
