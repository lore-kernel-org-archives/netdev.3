Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273379;
	b=F6Eyf6dQG8vzOq1EwCAagjp3wIrwnYfwPahozkCnvQKNJbxxTfYJiIJj6AUVEbrULk0b
	 XKYlfi8JlM+7wd6d3iaKXFCZSRQ6gllQZJM6zeyCdzd4IjRuJYXgjCcXjRxiRFVYJE3tP
	 Zs4lHOrMCdq+eKBpaSFGlbzRtAbv6S0KH9OPd36T9F/dkq2xT1exblchCXzw/t0xAVTRS
	 j8d8UIpCKu/IfF7SpAx8ODWILVVl/6i57jWWIXlJyqvjedrp7bL/t87hXFkZz7RpQPktI
	 xwKqx3bRTrhC/K3sVhPxRsCSXwHQWZMGtkizQbhlKTWR9en6+/IYYMNfXCIYpBpM8Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273379;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U6kBcEHjcJgHF91h/IFPJ2U9t2jiOYRPd8TbTb5gzdY=;
	b=CxyXVfQz4xs1g3zX0LImFXSXAJ7VW9zGVhDrxHWrd1Ue3RHKqYUcRaLfqEMcrs/2kHru
	 Uz2tAFMiAMx9G0pAfg3ud7BT6nbMJsLiSUGnLydERpAWncUim7oBq3e1boSfFkMys4nu8
	 VhfIcB1fC36UQmSeRRPzQqqOX30ra5Hj6vVI/RMlD1GptXHYtGwFY+AbgnmMh3RrSP6Ju
	 nVNHLEQ1G8AEWSwOT4QF6iveOYsIca4jZ/HNEJjLDtUW/KA0yRzC4Lk1T3tpefsoHDR1Z
	 OWf9Tk8Sr7VDW5f+1r8ULQvQ00UU1Q9of0ldBuCsHE48H7KcJJ5a2ntKrFov26HWN/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iyjDfQ77;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE96606A33D
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 01:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iyjDfQ77
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAAE1F008A3;
	Tue, 10 Nov 2026 01:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273379;
	bh=U6kBcEHjcJgHF91h/IFPJ2U9t2jiOYRPd8TbTb5gzdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iyjDfQ77qSqGFkA93Ae+8oZ6p/rYWrHFjA+gmskVArFinj3L5z2SgL22CItaaLGXb
	 sl9RoXhAy2BSoDZmeTKLFWOEv0WLU4b2SRQOhQFtuO3RPRSA585mQPbuNaVl0fxoLK
	 F5r6Hm0PeBMEDGlZGSvD5dtQHkYx5dh1NcIgXKzGaOfAKIRj/YUYYs91ACqKR+b1ai
	 2OOtPBvGwMhbKQl/p8VBFDoBirURr6kqjP4NcQfrTwJclZhagVB0QlDiIckI+dCkan
	 9R57jf8jhvOdrhFnkWqaDTmfF4VWs8UJdmG6sQBAc5sz1ViivkOqwsERiAFyi2ZHBL
	 RuV/+iFiZOFWA==
From: Jakub Kicinski <kuba@kernel.org>
To: linusw@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	ulli.kroll@googlemail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	pabeni@redhat.com,
	mirq-linux@rere.qmqm.pl,
	mhun512@gmail.com,
	edumazet@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 04/15] net: ethernet: cortina: Normalize free queue pointers on rebuild
Date: Mon,  9 Nov 2026 17:16:16 -0800
Message-ID: <20261110011617.1733422-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-gemini-ethernet-fixes-3-v6-4-c4b5ff8a65d8@kernel.org>
References: <20261103-gemini-ethernet-fixes-3-v6-4-c4b5ff8a65d8@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: ethernet: cortina: Normalize free queue pointers on rebuild

This commit masks the software free queue page indices to the active
queue order. When the free queue is rebuilt, it raises the order so the
new ring covers the read pointer the hardware kept. It also seeds the
software write pointer from that read pointer before filling the ring.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 003108270d060..7ebd62f8a3a46 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -887,6 +887,7 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
>  
>  	rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
>  	pn = (refill ? rw.bits.wptr : rw.bits.rptr) >> fpp_order;
> +	pn &= m_pn;
>  	epn = (rw.bits.rptr >> fpp_order) - 1;
>  	epn &= m_pn;

[Severity: Low]
This fixes an out-of-bounds access. Should it have a Fixes: tag?

Before this change, geth_fill_freeq() used the unmasked pn taken from the
retained hardware rptr to compute &geth->freeq_pages[pn]. After a rebuild
at a smaller order, the first loop iteration could index past the newly
allocated pages array. page_ref_count() and page_ref_add() would then run
on a garbage struct page pointer:

gmac_set_ringparam() / gmac_open()
  geth_resize_freeq()
    geth_setup_freeq()
      geth_fill_freeq(geth, false)

The unmasked code and geth_resize_freeq() both come from:

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

The other fixes in this series have that tag. Later patches such as
"Correct free queue DMA mappings" and "Preserve in-flight free queue
pages" rely on this patch keeping rptr inside the ring.

Without the tag, could stable pick up those patches without this one?

[ ... ]

> @@ -958,6 +960,10 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
>  		if (!geth_freeq_alloc_map_page(geth, pn))
>  			goto err_freeq_alloc;
>  
> +	/* Match the software pointer to the retained hardware pointer. */
> +	rptr = GET_RPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG);
> +	SET_WPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG, rptr & (len - 1));
> +

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Do the
TX queues have the same retained rptr problem this patch fixes for the
free queue?

gmac_set_ringparam() lets txq_order shrink while the interface is down.
On the next open, gmac_setup_txqs() allocates skb_tab and desc_ring with
1 << txq_order entries. It then seeds wptr and cptr from the hardware
rptr without masking it:

drivers/net/ethernet/cortina/gemini.c:gmac_setup_txqs() {
    ...
		r = readw(rwptr_reg);
		rwptr_reg += 2;
		writew(r, rwptr_reg);
		rwptr_reg += 2;
		txq->cptr = r;
    ...
}

The TX rptr uses the same union dma_rwptr layout, where rptr is
read-only, and gmac_cleanup_txqs() only sets wptr = rptr. Take the
default order 8 shrunk with "ethtool -G ethX tx 16": any retained
rptr >= 16 is then outside the new ring.

gmac_start_xmit() reads the unmasked wptr, and the space check masks only
the difference:

	w = rw.bits.wptr;

	d = txq->cptr - w - 1;
	d &= m;

gmac_map_tx_bufs() then uses w before masking it:

			txq->skb[w] = skb;
    ...
		txd = txq->ring + w;

Can this write past skb_tab and past the coherent TX descriptor ring, and
also give the hardware a pointer outside its ring?

gmac_clean_txq() also starts from the unmasked txq->cptr and dereferences
txq->ring + c and txq->skb[c].

This is still present at the end of the series.

[ ... ]

> @@ -1099,6 +1106,10 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
>  	}
>  
>  	new_order = min(15, ilog2(new_size - 1) + 1);
> +	rptr = GET_RPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG);
> +	if (rptr >= BIT(15))
> +		return -EIO;
> +	new_order = max_t(unsigned int, new_order, fls(rptr));
>  	dev_dbg(geth->dev, "set shared queue to size %d order %d\n",
>  		new_size, new_order);
>  	if (geth->freeq_ring && geth->freeq_order == new_order)

[Severity: Medium]
Does this let leftover hardware state, not the configured RX ring sizes,
decide the size of the shared free queue?

gemini.h marks rptr as read-only:

	unsigned int rptr	: 16;	/* Read Ptr, RO */

so the writel(0, GLOBAL_SWFQ_RWPTR_REG) in geth_global_init() only
clears wptr in practice. After a ring of order N has been used, rptr can
be anywhere in [0, 2^N). Whenever rptr >= 2^(N-1), fls(rptr) == N.

In that case, lowering rx_pending through gmac_set_ringparam() hits:

	if (geth->freeq_ring && geth->freeq_order == new_order)
		return 0;

ethtool -G then reports success, but the free queue keeps its old
descriptor ring. It also keeps its (1 << order) >> fpp_order pages,
which were allocated with GFP_ATOMIC.

Both callers resize only while RX DMA is idle. gmac_set_ringparam()
requires !netif_running(), and gmac_open() resizes before
gmac_start_dma(). So rptr cannot move between attempts.

Suppose a rebuild at the forced order fails in dma_alloc_coherent() or in
the GFP_ATOMIC page allocations in geth_setup_freeq(). Won't every later
gmac_open() compute the same order and fail the same way? gmac_open()
treats that as fatal:

	err = geth_resize_freeq(port);
	if (err && (err != -EBUSY)) {
		netdev_err(netdev, "could not resize freeq\n");
		goto err_stop_phy;

Asking for a smaller ring no longer helps in that state.

A stale rptr left by a bootloader, or by a kexec'd kernel with larger
rings, would set the same floor at first open. That seems to work against
the later "Scale Gemini RX queues to system memory" patch, which shrinks
the free queue on 32/64 MiB systems.

The commit message only says the replacement ring is kept "large enough
for the retained hardware pointer". Could it mention that requested
shrinks may be skipped? Is there a fallback when allocation at the
forced order fails?

This behaviour is unchanged at the end of the series.
