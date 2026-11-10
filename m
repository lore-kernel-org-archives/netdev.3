Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273383;
	b=cHW2KLjN0RkTdRirlKlAHjS9h47guOu503mcORT+Ry5SQmPNrsm0tP8d2u8Yq2nmTSwM
	 jKo4F/UZX4bNpV/UEd1xqMd+LLys204t4+vMDAya4YpoxHwOwmH4DOjFntDI3d0BjGxcW
	 jjHTAP4/LrKhBrmSBKi1gLL7LzMwzGDWEhXeFoKbmLBkjs/bQwDndfxUz/QBwTHOp7oyC
	 L9gP1XV2Ov+9DlQSFZKiMj69NQe61ldGMFlJ9nyv40V1LGDXna6ZvsaHKKSflS4nTCrZn
	 75NswcLacFfOOG7333WPaQmDTxrh9EDQ/Pt6AvLuzOCWpDb0eHQE3x3KDvM+knCh61g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273383;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Amg4mAQ96MD7+UAGZQM2FUDDWvMN84hl0rTGxW+cUZQ=;
	b=0blRW/oHL+X8/nES6ND57bopzYDcTnBL///L2/h6HwtOXFtO5ARKyTsQA0mxjjxLM2Ec
	 h6TZalH3vvYu6yTVD9+kTwmEXfgbcHOB2OQgK0ESMXkouiOesw+oGNpbMx772cMPlPr6J
	 A5ixu2zwKkTbFiWl6ZdiGAI8FWNFE9bzwGtdR2+aNhyzzpI5oyKvaUQdErSa6YHh3Gvba
	 tP3Oa7LibJ6rlGReu1cTZTVIJXpgyQuKyHx9F9sinXRX+mQEheeeHrtB+n8g5YClUzmbK
	 Fck/QLQZ7zXK+/FYCNShPh5QTKAp1L70pVMjersQmRqIP/OkrbY9vDEqOdofiFMN+Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jL8CIOxT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B3160A261A
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 01:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jL8CIOxT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61251F008A2;
	Tue, 10 Nov 2026 01:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273383;
	bh=Amg4mAQ96MD7+UAGZQM2FUDDWvMN84hl0rTGxW+cUZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jL8CIOxTRlwf1TqJvRCIQ6BxJC7/8VqhTh2k5OQWMcTLTfo4bqwfpNMkmPDEsfs/x
	 TnQbDjVJOdqtcQO/eETB7Qc4cmagNfkdK0XZh68Uwq63eslnpL8/LxHjIkGl2pXN1n
	 s7wErk51GnqrIhmrA8PsQRlGuxPFaoMe5vYi5XVAMF+1ooqre0//+zEVT5PaP46Fsc
	 ZRtkXwVUYyvbheYbWlK28X3UWPPlbboBdx4zksj/kRPZo28vb4U3L6nS/AManS1fUV
	 0zhw1hBJ5isRzuI2OMxlYmrTN1ODtAYEgu7IrAmSwuwoWvk2xhB0y9OxiAFffDRzT/
	 YnQhv9wxkBszw==
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
Subject: Re: [PATCH net-next v6 09/15] net: ethernet: cortina: Recycle claimed free queue pages
Date: Mon,  9 Nov 2026 17:16:22 -0800
Message-ID: <20261110011622.1733542-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-gemini-ethernet-fixes-3-v6-9-c4b5ff8a65d8@kernel.org>
References: <20261103-gemini-ethernet-fixes-3-v6-9-c4b5ff8a65d8@kernel.org>
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
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -964,9 +986,69 @@ static int geth_freeq_add_page(struct gemini_ethernet *geth, unsigned int wptr,
>  		xa_erase(&geth->freeq_mappings,
>  			 geth_freeq_mapping_index(geth, mapping));
>  	}
> -	gpage->page = NULL;
> -	gpage->mapping = 0;
> -	__clear_bit(slot, geth->freeq_page_bitmap);
> +	return ret;
> +}
> +
> +static int geth_freeq_add_page(struct gemini_ethernet *geth,
> +			       unsigned int wptr,
> +			       struct page *page, dma_addr_t page_mapping)
> +{
> +	struct gmac_queue_page *gpage;
> +	int ret;
> +	int slot;
> +
> +	lockdep_assert_held(&geth->freeq_lock);
> +
> +	slot = geth_freeq_alloc_slot(geth);
> +	if (slot < 0)
> +		return slot;
> +
> +	gpage = &geth->freeq_pages[slot];
> +	gpage->page = page;
> +	gpage->mapping = page_mapping;
> +	ret = geth_freeq_post_page(geth, wptr, gpage, false);
> +	if (ret) {
> +		gpage->page = NULL;
> +		gpage->mapping = 0;
> +		__clear_bit(slot, geth->freeq_page_bitmap);
> +	}
> +
> +	return ret;
> +}
> +
> +static int geth_freeq_recycle_page(struct gemini_ethernet *geth,
> +				   unsigned int wptr)
> +{
> +	struct gmac_queue_page *gpage;
> +	struct page *page;
> +	int ret;
> +	int slot;
> +
> +	lockdep_assert_held(&geth->freeq_lock);
> +
> +	slot = geth_freeq_recycle_slot(geth);
> +	if (slot < 0)
> +		return slot;
> +
> +	gpage = &geth->freeq_pages[slot];
> +	if (page_ref_count(gpage->page) > 1) {
> +		page = gpage->page;
> +		dma_unmap_single_attrs(geth->dev, gpage->mapping, PAGE_SIZE,
> +				       DMA_FROM_DEVICE,
> +				       DMA_ATTR_SKIP_CPU_SYNC);
> +		gpage->page = NULL;
> +		gpage->mapping = 0;
> +		__clear_bit(slot, geth->freeq_page_bitmap);
> +		put_page(page);
> +		return -EAGAIN;
> +	}
> +
> +	ret = geth_freeq_post_page(geth, wptr, gpage, true);
> +	if (ret) {
> +		__set_bit(slot, geth->freeq_recycle_bitmap);
> +		geth->freeq_recycle_pending++;
> +	}
> +
>  	return ret;
>  }
>  

[Severity: Medium]
geth_freeq_recycle_page() only checks page_ref_count() before handing
the page back to geth_freeq_post_page(). The pages come from
alloc_page(GFP_ATOMIC) in geth_freeq_map_page(). Under memory pressure
that allocation can return a page from the PFMEMALLOC reserves.

When gmac_rx() attaches a fragment with skb_fill_page_desc(), the skb
inherits skb->pfmemalloc. The core then drops it for any socket that
does not have SOCK_MEMALLOC set. That drop happens inside the NAPI
poll, so by the time geth_fill_freeq() runs the refcount is back to
one and the page is reposted to the free queue.

Nothing ever returns that page to the allocator. The reserve page stays
pinned, and every frame that lands in it is dropped, long after the
pressure has gone away.

Before this patch the base reference was dropped on the last claim in
geth_freeq_claim(), so a reserve page was freed once the stack let go
of it. The problem is new with recycling.

Other drivers that recycle RX pages gate reuse on
dev_page_is_reusable(), which also rejects pages from a remote NUMA
node. Could the discard branch here also be taken when
dev_page_is_reusable(gpage->page) is false? Pfmemalloc pages would then
go through the dma_unmap_single_attrs() and put_page() path instead of
being reposted.
