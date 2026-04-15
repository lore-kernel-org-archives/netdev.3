Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621D93E51E4
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776271607; cv=none; b=HH+IfbD3C1U1v/roVzEB7JMKPVQgZ2+YbG9UVEol7oo96q8mowiwG2NUK9InKqzO8d94j0coJbYsqHzk8xCrC92CQKg05RMS+I4NenTaUuDflLFixWcCOYQjRwqHUwQ2aP/1Px+hz1vuktgVQsnxCRtG79Z8YiIbnySXtQFpI/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776271607; c=relaxed/simple;
	bh=9V5UV0H7MNGsiv3j20XRW3gOxXBgz2rZPl/n+ef13Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0zvBM570IpWswaJElNL6PZRnIV/T8KlYgtFo9o0U8Gdxy81EzIXw6zjtkqu8ms5ORivBCPE1XXgTQMOAnvJz4m+DFTJ0b+2MGG1IIgGdmyIjx0N/jUyKpaMadBk0lrGX0sfVNgiOJFYA2ywqVpWcjj9hv4IRK5NGIJXZMw/yOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW/f26Es; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW/f26Es"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7531AC19424;
	Wed, 15 Apr 2026 16:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776271607;
	bh=9V5UV0H7MNGsiv3j20XRW3gOxXBgz2rZPl/n+ef13Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fW/f26Es+VpZNbsFgLDGuFZPeNpaxhhh4Snuyt9w2JIMPiB1dhxrqeL6YBx8Jpt4E
	 ZQ7/nvDHkkPpEo8MOH4NbMh/Ok3l9PHn1ELWTJjvicCfCC994+ciDxlnXoQ2QlLykV
	 dPDakfB6qFZ5v3sKcVhSSyBmuHBHHUeoQYG5BP9LXCdfjzgHeenrjWUkjF40swEwNx
	 a0mVjfMq2eaSGSMKoOXfbZF0xPIUvGN3ErKGA2Z0kW4V3TAe3zyqy9v9zPM/HRF1Gc
	 oLN05DTT8JdNdkSG9UbHnbRc3budngWXSxJwrPBGbCc4sBjUbqX5wYgYT1EH4khf6m
	 F7Aed9NzH5q4A==
Date: Wed, 15 Apr 2026 17:46:43 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: airoha: Add missing bits in
 airoha_qdma_cleanup_tx_queue()
Message-ID: <20260415164643.GQ772670@horms.kernel.org>
References: <20260414-airoha_qdma_cleanup_tx_queue-fix-net-v2-1-875de57cc022@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-airoha_qdma_cleanup_tx_queue-fix-net-v2-1-875de57cc022@kernel.org>

On Tue, Apr 14, 2026 at 08:50:52AM +0200, Lorenzo Bianconi wrote:
> Similar to airoha_qdma_cleanup_rx_queue(), reset DMA TX descriptors in
> airoha_qdma_cleanup_tx_queue routine. Moreover, reset TX_DMA_IDX to
> TX_CPU_IDX to notify the NIC the QDMA TX ring is empty.
> 
> Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - Move q->ndesc initialization at end of airoha_qdma_init_tx routine in
>   order to avoid any possible NULL pointer dereference in
>   airoha_qdma_cleanup_tx_queue()

This seems to be a separate issue.
If so, I think it should be split out into a separate patch.

> - Check if q->tx_list is empty in airoha_qdma_cleanup_tx_queue()
> - Link to v1: https://lore.kernel.org/r/20260410-airoha_qdma_cleanup_tx_queue-fix-net-v1-1-b7171c8f1e78@kernel.org

I think it was covered in the review Jakub forwarded for v1.  But FTR,
Sashiko has some feedback on this patch in the form of an existing bug
(that should almost certainly be handled separately from this patch).

> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 41 ++++++++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 9e995094c32a..3c1a2bc68c42 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -966,27 +966,27 @@ static int airoha_qdma_init_tx_queue(struct airoha_queue *q,
>  	dma_addr_t dma_addr;
>  
>  	spin_lock_init(&q->lock);
> -	q->ndesc = size;
>  	q->qdma = qdma;
>  	q->free_thr = 1 + MAX_SKB_FRAGS;
>  	INIT_LIST_HEAD(&q->tx_list);
>  
> -	q->entry = devm_kzalloc(eth->dev, q->ndesc * sizeof(*q->entry),
> +	q->entry = devm_kzalloc(eth->dev, size * sizeof(*q->entry),
>  				GFP_KERNEL);
>  	if (!q->entry)
>  		return -ENOMEM;
>  
> -	q->desc = dmam_alloc_coherent(eth->dev, q->ndesc * sizeof(*q->desc),
> +	q->desc = dmam_alloc_coherent(eth->dev, size * sizeof(*q->desc),
>  				      &dma_addr, GFP_KERNEL);
>  	if (!q->desc)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < q->ndesc; i++) {
> +	for (i = 0; i < size; i++) {
>  		u32 val = FIELD_PREP(QDMA_DESC_DONE_MASK, 1);
>  
>  		list_add_tail(&q->entry[i].list, &q->tx_list);
>  		WRITE_ONCE(q->desc[i].ctrl, cpu_to_le32(val));
>  	}
> +	q->ndesc = size;
>  
>  	/* xmit ring drop default setting */
>  	airoha_qdma_set(qdma, REG_TX_RING_BLOCKING(qid),
> @@ -1051,13 +1051,17 @@ static int airoha_qdma_init_tx(struct airoha_qdma *qdma)
>  
>  static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
>  {
> -	struct airoha_eth *eth = q->qdma->eth;
> -	int i;
> +	struct airoha_qdma *qdma = q->qdma;
> +	struct airoha_eth *eth = qdma->eth;
> +	int i, qid = q - &qdma->q_tx[0];
> +	struct airoha_queue_entry *e;
> +	u16 index = 0;
>  
>  	spin_lock_bh(&q->lock);
>  	for (i = 0; i < q->ndesc; i++) {
> -		struct airoha_queue_entry *e = &q->entry[i];

super nit: In v2 e is always used within a block (here and in the hunk below).
           So I would lean towards declaring e in the blocks where it is
	   used.

	   No need to repost just for this!

> +		struct airoha_qdma_desc *desc = &q->desc[i];
>  
> +		e = &q->entry[i];
>  		if (!e->dma_addr)
>  			continue;
>  
> @@ -1067,8 +1071,31 @@ static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
>  		e->dma_addr = 0;
>  		e->skb = NULL;
>  		list_add_tail(&e->list, &q->tx_list);
> +
> +		/* Reset DMA descriptor */
> +		WRITE_ONCE(desc->ctrl, 0);
> +		WRITE_ONCE(desc->addr, 0);
> +		WRITE_ONCE(desc->data, 0);
> +		WRITE_ONCE(desc->msg0, 0);
> +		WRITE_ONCE(desc->msg1, 0);
> +		WRITE_ONCE(desc->msg2, 0);
> +
>  		q->queued--;
>  	}
> +
> +	if (!list_empty(&q->tx_list)) {
> +		e = list_first_entry(&q->tx_list, struct airoha_queue_entry,
> +				     list);
> +		index = e - q->entry;
> +	}
> +	/* Set TX_DMA_IDX to TX_CPU_IDX to notify the hw the QDMA TX ring is
> +	 * empty.
> +	 */
> +	airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
> +			FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
> +	airoha_qdma_rmw(qdma, REG_TX_DMA_IDX(qid), TX_RING_DMA_IDX_MASK,
> +			FIELD_PREP(TX_RING_DMA_IDX_MASK, index));
> +
>  	spin_unlock_bh(&q->lock);
>  }
>  
> 
> ---
> base-commit: 2cd7e6971fc2787408ceef17906ea152791448cf
> change-id: 20260410-airoha_qdma_cleanup_tx_queue-fix-net-93375f5ee80f
> 
> Best regards,
> -- 
> Lorenzo Bianconi <lorenzo@kernel.org>
> 
