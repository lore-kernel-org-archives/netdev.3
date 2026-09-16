Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA9738E8A6;
	Wed, 16 Sep 2026 01:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521496; cv=none; b=UUfypwU+P5rAH89MxALN8LRycRnwVXLJD6cggxZIaRS4ZcaKNNyojQeF4LY2zR1mm4TV/i0/VRLHPEl4OSuLuEHNtzLpgDCpd/kttjOZQYmtzzRTkGH7sT7c6zbNtk4k6yzOpWu7L0YXRPMGtm+d4b6FDDPVQIddgLnqDT7b+jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521496; c=relaxed/simple;
	bh=2Mfzy/Hw/zIGmWuz6makzY737zlzZTf9GqyrD1aCXTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcEI1AcXjRJ/XQhx5xa2nRonJvljhvwojKIaQQUBrOHs1zkTX+SyqeKJEzpgZqdwQCCGfr01Dtdvwuhh4zH7C5sQje9/GaipdeT2dimjIHpXtgKs2rvlByRpKGzKFZSgNYrEV4AKznOLJlN/iww3U8rPfnzyPiW1OAdnC6sOOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNtgh9fD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNtgh9fD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BCD1F000FF;
	Wed, 16 Sep 2026 01:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521495;
	bh=Fc/KEcEpePX8jQDme+fWQ04KtaWAl60QQBLlVHiy7uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FNtgh9fDxH8JeM8YBWXHATb5KHD5TagJYZLPIxf0lhUydsQ3+FHSIPB61e1Ye2uzJ
	 qjTSn36WE/iNZ0+l12XZguvkY+BHcIDKhSokDiUyZBF8aPAUnwA0hjSTMp5grSS+uf
	 m4cV6t3ZGjrDveXPdhRkeveX9/Hrs2eMVF/pt1DY9P8WfSeyZjHCJ7fshRt2XaHaz/
	 w/ViKNEQigfGPi2AB0UPbJK7VrTxSg9aQu7KQWyE2/aqvir/szxt1dlDjZxzF/45f9
	 yL+MqWZ+DQSFEgcdbXrQFwxlGpBcXxX94VjpKqB0uORPXNiCZouNuKeBXfxaM15AY9
	 VMwRfTNwAjJww==
From: Jakub Kicinski <kuba@kernel.org>
To: suraj.gupta2@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	radhey.shyam.pandey@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	michal.simek@amd.com,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: xilinx: axienet: Free outstanding DMA buffers on dmaengine stop
Date: Tue, 15 Sep 2026 18:17:38 -0700
Message-ID: <20260916011737.1638482-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910141946.3017164-1-suraj.gupta2@amd.com>
References: <20260910141946.3017164-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's fix what AI is pointing out in another patch in the same series?
Or please explain in the commit msg why the issue is not real,
I'm not very familiar with the DMA engine API, TBH.

AI review:
---
net: xilinx: axienet: Free outstanding DMA buffers on dmaengine stop

This adds clearing of the ring slot skb pointer in the TX and RX dmaengine
completion callbacks, and makes axienet_stop() walk the TX and RX rings
after terminating the channels to unmap and free any slot that still has a
non-NULL skb, instead of only kfree()ing the ring shells.

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 1722b7038f340..7828fbb09dc87 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c

[ ... ]

> @@ -1171,6 +1172,7 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
>  						       &meta_max_len);
>  	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
>  			 DMA_FROM_DEVICE);
> +	skbuf_dma->skb = NULL;
>  
>  	if (IS_ERR(app_metadata)) {
>  		if (net_ratelimit())

> @@ -1752,16 +1754,40 @@ static int axienet_stop(struct net_device *ndev)
>  		free_irq(lp->rx_irq, ndev);
>  		axienet_dma_bd_release(ndev);
>  	} else {
> +		struct skbuf_dma_descriptor *skbuf_dma;
> +
>  		dmaengine_terminate_sync(lp->tx_chan);
>  		dmaengine_synchronize(lp->tx_chan);
>  		dmaengine_terminate_sync(lp->rx_chan);
>  		dmaengine_synchronize(lp->rx_chan);
>  
> -		for (i = 0; i < TX_BD_NUM_MAX; i++)
> -			kfree(lp->tx_skb_ring[i]);
> +		/* dmaengine_terminate_sync() aborts the descriptors still owned
> +		 * by the DMA engine without running their completion callbacks.
> +		 * A ring slot owns a live, DMA-mapped SKB iff its skb pointer is
> +		 * non-NULL (the callbacks clear it on completion), so unmap and
> +		 * free those here. Otherwise every outstanding TX/RX SKB and its
> +		 * DMA mapping is leaked on ifdown.
> +		 */

[ ... TX ring loop snipped ... ]

> +
> +		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++) {
> +			skbuf_dma = lp->rx_skb_ring[i];
> +			if (skbuf_dma && skbuf_dma->skb) {
> +				dma_unmap_single(lp->dev, skbuf_dma->dma_address,
> +						 lp->max_frm_size, DMA_FROM_DEVICE);
> +				dev_kfree_skb_any(skbuf_dma->skb);
> +			}
> +			kfree(skbuf_dma);
> +		}
>  		kfree(lp->rx_skb_ring);
>  
>  		dma_release_channel(lp->rx_chan);

[Severity: High]

Is the invariant described in the comment, "A ring slot owns a live,
DMA-mapped SKB iff its skb pointer is non-NULL", guaranteed to hold once
the terminate calls have returned?

axienet_dma_rx_cb() re-arms the RX channel unconditionally at the end of
every completion, with no check against a stopping flag or
netif_running():

drivers/net/ethernet/xilinx/xilinx_axienet_main.c:axienet_dma_rx_cb() {
	...
rx_submit:
	for (i = 0; i < CIRC_SPACE(lp->rx_ring_head, lp->rx_ring_tail,
				   RX_BUF_NUM_DEFAULT); i++)
		axienet_rx_submit_desc(lp->ndev);
	dma_async_issue_pending(lp->rx_chan);
}

Note lp->stopping is only set in the !lp->use_dmaengine branch of
axienet_stop(), so it does not fence this path.

The callback runs from the provider tasklet with chan->lock dropped, so it
can run on another CPU while axienet_stop() is between the terminate and
the free loop:

drivers/dma/xilinx/xilinx_dma.c:xilinx_dma_chan_desc_cleanup() {
	...
	spin_unlock_irqrestore(&chan->lock, flags);
	dmaengine_desc_get_callback_invoke(&desc->async_tx, &result);
	spin_lock_irqsave(&chan->lock, flags);
}

If the callback wins that race, axienet_rx_submit_desc() maps a fresh
buffer, installs it in the slot and submits it:

	skbuf_dma->skb = skb;
	skbuf_dma->dma_address = sg_dma_address(skbuf_dma->sgl);
	skbuf_dma->desc = dma_rx_desc;
	...
	lp->rx_ring_head++;
	dmaengine_submit(dma_rx_desc);

and xilinx_dma_tx_submit() queues it and clears the provider's guard:

	append_desc_queue(chan, desc);
	...
	chan->terminating = false;

The following dma_async_issue_pending() then restarts the channel.
dmaengine_synchronize() is only tasklet_kill() here:

drivers/dma/xilinx/xilinx_dma.c:
static void xilinx_dma_synchronize(struct dma_chan *dchan)
{
	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);

	tasklet_kill(&chan->tasklet);
}

so it waits for the callback to return but does not abort the descriptor the
callback just submitted.

In that case the new RX loop sees skbuf_dma->skb != NULL for that slot and
performs dma_unmap_single() plus dev_kfree_skb_any() on a buffer the engine
still owns.  Can this let the hardware write into a freed, unmapped skb, or
trigger an IOMMU fault?

There is also the ordering of kfree(lp->rx_skb_ring) before
dma_release_channel(lp->rx_chan).  If the late descriptor completes in that
window, axienet_dma_rx_cb() does:

	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_tail++);
	skb = skbuf_dma->skb;

Is that a use-after-free of lp->rx_skb_ring?

Before this change the same window only leaked the buffer.  Would it make
sense to fence resubmission first, for example by setting the stopping flag
for the dmaengine path before the terminate calls and checking it in
axienet_dma_rx_cb() before the rx_submit loop, and to release the channels
before freeing the rings?

Note also that dmaengine_terminate_sync() already ends with
dmaengine_synchronize(), so the explicit dmaengine_synchronize() calls that
follow it here are redundant, though harmless.
-- 
pw-bot: cr
