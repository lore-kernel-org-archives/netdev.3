Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121957;
	b=gqckGcsq/KiKsmRQi1L8CgW6+ryrn0O05l57NxaGlQk17Axc8pKGhqs1IaSp5ovatUzM
	 QfXN3QJC9uiCqDP3zsQx1u9UeR2cC6k6qYzQrweWbeQoWeDqGFyLVPdVDhlDZ0L2BYZYi
	 oeYTbvoO75t+S7G+dBNIMKxG1Muewk+RIpZw2Ppih395nY33xB+uZfUYRI33RQP51McWq
	 pNGqpWfyyl8eHXgd+lFjT/TSPgGglBIBmaaWe4k/kzxuoSu+TRwcER95ix+/osQh/3C/q
	 6dO+tyvcs01Xg/t1Eiart8edFySCXHybqXW/ZFywTqBr++rLar/zA+BuDCRtgoHRLFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121957;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6jDbsLz7Z4thP3xHEXM66Grdqk9ofg2cghOAoc0Azow=;
	b=MjRQhQWbYfi5Z1xrabGhJxFDOkFxmCM7tUQIJRcqgUdq1JXm2dHKnAypG9E8CqseHGds
	 Is10Yblx6Y1ES1FtbbLqOdl9LvZ1yWOe+dHOfzSoRndkFbHz1Zob7kBpKWN3PR8yB3aOc
	 LX95HfoXX7WGI+wxqn7CmI9ub7IWl6YR9wC0iO59FR7PVxyzCAomLzG3k5yPIUbvhzuNv
	 czC3qnkUj0h2aWFgBtx3/UJS1Tj65AsKfO25pIAW15maEAKdpC4/YojORpYEkEmJvW3Dw
	 Y2hs16vFOMbvMGCLio3NdcN1xa1ZBJGnNPo3RGvXwPX+fBy0WoYLzNrRfkfT4bXI7MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXzkn6Qp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391A606A31A;
	Tue, 27 Oct 2026 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXzkn6Qp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D151E1F01825;
	Tue, 27 Oct 2026 17:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793121956;
	bh=6jDbsLz7Z4thP3xHEXM66Grdqk9ofg2cghOAoc0Azow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BXzkn6QpAQ3QV1R7Y1xvJ9l0TSAHmlthKWEU1S/vmxIUhNPPwOvcsZjwJ42vq7RP8
	 /FrUneKkRHRH80do1cDHtJVX6f8WY17EQ/n/D2AxsZg0z8lZtGWJT/J/BxS+ZAlTE2
	 /h9A8OoW0zbjI++uvJ9GTFbxQSJ4rIJZm3KuRhuFp0cUxTahQn8cVFqoZe7oj7NX2V
	 HrUC+oG30hXYIdoJwUMDBKjqeaLPtviFFb5m3NiqOqmlwdaXSkOOsRroI1SXY1CXbN
	 HK0AW5mKSSdDkNgFTg8+h2xf7l0GJWv5Dyg5qe/PjS+godeJ9e7c2FFUMWicl14zdo
	 9Rxwx4QDZcDzw==
Date: Tue, 27 Oct 2026 17:25:52 +0000
From: Simon Horman <horms@kernel.org>
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, rafal@milecki.pl,
	bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, nbd@openwrt.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: bgmac: fix TX DMA unmapping and slot cleanup
Message-ID: <20261027172552.GP257209@horms.kernel.org>
References: <20261022215235.3692083-1-rosenp@gmail.com>
 <20261027172240.416526-2-horms@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027172240.416526-2-horms@kernel.org>

On Tue, Oct 27, 2026 at 05:22:41PM +0000, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022215235.3692083-1-rosenp@gmail.com?part=1
> ---
> net: bgmac: fix TX DMA unmapping and slot cleanup
> 
> This patch fixes the bgmac_dma_tx_add() error path so that the head and
> each mapped fragment are unmapped from their own slots. It also clears
> dma_addr on every slot the failed packet touched. In
> bgmac_dma_tx_ring_free() it picks the unmap function from the SOF flag
> of the descriptor, unmaps before freeing, and clears slot->skb and
> slot->dma_addr.
> 
> > This was found through code inspection by an LLM while hitting other
> > bugs on an Asus RT-N16. It did not hit these ones specifically.
> >
> > Fixes: 9cde94506eac ("bgmac: implement scatter/gather support")
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> 
> [Severity: Low]
> This isn't a bug, but the commit message says an LLM found these
> problems. Should the trailers include an Assisted-by: tag?
> 
> Documentation/process/submitting-patches.rst says:
> 
>   If you used any sort of advanced coding tool in the creation of your
>   patch, you need to acknowledge that use by adding an Assisted-by tag.
> 
> Documentation/process/coding-assistants.rst gives the format as
> "Assisted-by: LLM [TOOL1] [TOOL2]". Step 6 of its procedure for finding
> and fixing bugs also asks for an Assisted-by tag.
> 
> > diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> > index 3e9c57196a397..d44ee8ed32459 100644
> > --- a/drivers/net/ethernet/broadcom/bgmac.c
> > +++ b/drivers/net/ethernet/broadcom/bgmac.c
> 
> [ ... ]
> 
> > @@ -535,17 +540,19 @@ static void bgmac_dma_tx_ring_free(struct bgmac *bgmac,
> >  		unsigned int len = ctl1 & BGMAC_DESC_CTL1_LEN;
> >  
> >  		slot = &ring->slots[i];
> > -		dev_kfree_skb(slot->skb);
> >  
> > -		if (!slot->dma_addr)
> > -			continue;
> > +		if (slot->dma_addr) {
> > +			if (le32_to_cpu(dma_desc[i].ctl0) & BGMAC_DESC_CTL0_SOF)
> > +				dma_unmap_single(dma_dev, slot->dma_addr,
> > +						 len, DMA_TO_DEVICE);
> > +			else
> > +				dma_unmap_page(dma_dev, slot->dma_addr,
> > +					       len, DMA_TO_DEVICE);
> > +			slot->dma_addr = 0;
> > +		}
> >  
> > -		if (slot->skb)
> > -			dma_unmap_single(dma_dev, slot->dma_addr,
> > -					 len, DMA_TO_DEVICE);
> > -		else
> > -			dma_unmap_page(dma_dev, slot->dma_addr,
> > -				       len, DMA_TO_DEVICE);
> > +		dev_kfree_skb(slot->skb);
> > +		slot->skb = NULL;
> 
> [Severity: Low]
> If a pending packet wraps around the end of the ring, is the skb still
> freed before all of its slots are unmapped?
> 
> The commit message says bgmac_dma_tx_ring_free() will "unmap before
> freeing". That ordering only holds within a single slot, because the
> loop walks slots in physical order from 0 to BGMAC_TX_RING_SLOTS - 1.
> 
> bgmac_dma_tx_add() puts fragments in consecutive slots modulo the ring
> size, and sets slot->skb only on the last one:
> 
> drivers/net/ethernet/broadcom/bgmac.c:bgmac_dma_tx_add() {
>     ...
> 		index = (index + 1) % BGMAC_TX_RING_SLOTS;
> 		slot = &ring->slots[index];
>     ...
> 	slot->skb = skb;
>     ...
> }
> 
> Take a scatter/gather packet whose head (SOF) is in the last slot of the
> ring and whose last fragment, which owns the skb, is in slot 0. The loop
> reaches i == 0 first and calls dev_kfree_skb(), which releases skb->head
> and the frag pages. Only later, at i == BGMAC_TX_RING_SLOTS - 1, does it
> call dma_unmap_single() on the head buffer, which is already freed.
> 
> bgmac_stop() and the suspend path call bgmac_chip_reset() before
> bgmac_dma_cleanup(), and the mappings are DMA_TO_DEVICE. So this may
> have no visible effect, but it still breaks the DMA API rule that a
> buffer is unmapped before it is freed.
> 
> bgmac_dma_tx_free() avoids this by walking from ring->start to
> ring->end. Could the same be done here? Another option is to unmap every
> slot in a first pass and free the skbs in a second pass.

Hi Rosen,

The issue flagged above does seem somewhat concerning.
What is your take on it?

...
