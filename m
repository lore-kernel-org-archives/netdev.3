Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273381;
	b=dxA+GrYeie9MWVsQx8PxpyHMCgehyB6kSEe7a4l6SIF45gTJkPnbEPziAgRgGQrDtSO4
	 KpjzLIMRtMupB5cg9PPhzRQ/dKr/kWObwqowdc8BVuy/EGGbcl+wPi71du80mXgnLdwv9
	 xyQp4VxSysPBMTT4vwaNnCZi8agUSkO4bKw+p8TnaNpyC0c81t1Lpw0dfml86VWTTbwHR
	 dOFgl3mw0Gvu/RgXGkduwhvbuxUSUXvLXiv5SprLpYFdal7mpVekRXcpxeBBfK9bsAyZL
	 4RT4Nj8gvPWDOG0FlyU+bV89OnKnpSL/btClvOtLgS3NqrHO6+hNuJIyghRf6cnTigA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273381;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=52CherUoK9hjxkc0kCYXL2letzJbH7xVvwCFDHX+rW0=;
	b=X2GtAurXJ6ejuwEvtUFe7jwwwmy+8hvuktj8wCckpPSHWrJuF1GobOxHXYHC1CIPQC12
	 mBvXJ4uI1WR2PWU9DkIoOlqmpKc6oy7zMLdB+ImNaII9kl5VeHboVmMKpqVSdAjlSBM1v
	 jvioOEHEaOnhPrfsF6w3W3ijfbSoPPczX3s+ks3tdNH9CEyOfSyTbanbnjhD13iAOpsgA
	 3fGGiydwVwEdGs4Oa84J8D5u/7IlJqaCqrrbPyVfmgzu9IDi8J1otFwGid0SoFxGBSEiq
	 Eky8urPJqdiNaP1ZJMTef87OR/nzt8Z8FeH3jEvWSmiDUnDX3bzzBVM4HRNAQUxORQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTwpXm9L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63AF60A260B
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 01:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTwpXm9L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF5F1F008A3;
	Tue, 10 Nov 2026 01:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273380;
	bh=52CherUoK9hjxkc0kCYXL2letzJbH7xVvwCFDHX+rW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JTwpXm9LvzsNr6AzQnhzA7toq4aKUSUpp1vm7IErYgbzqD7sXPuCQ3iuUyPJQN9m7
	 03kUuZoeULRF0U48aXps0wwQfTSPbgecAMHvMMrN/pGWceeqzgUHsGQKQtMLji7IXl
	 Ljf5Giyj+jN0rRzJ52RCujc1fuijzsL+HN0bY8BD+JtBHJ5iM8i0bMcn9BqdRWQixJ
	 m0ueMStYH/2oQksD7uwPja132FRZUXfmYvFx4xhhW6Y4Y0gvbrbcQAO27jd1X6SDJK
	 WEGSljtTpnezsa5XBVNPg7yXMas/IyOxt2dgpDTDzATINq6xUC/3X54m2QPvBohb8e
	 +oeJvtZonCjJw==
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
Subject: Re: [PATCH net-next v6 06/15] net: ethernet: cortina: Index free queue fragments with XArray
Date: Mon,  9 Nov 2026 17:16:19 -0800
Message-ID: <20261110011619.1733459-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-gemini-ethernet-fixes-3-v6-6-c4b5ff8a65d8@kernel.org>
References: <20261103-gemini-ethernet-fixes-3-v6-6-c4b5ff8a65d8@kernel.org>
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
net: ethernet: cortina: Index free queue fragments with XArray

This commit replaces the linear scan over freeq_pages in
geth_freeq_lookup() with an XArray lookup. The XArray is indexed by
fragment DMA address in fragment units. geth_freeq_alloc_map_page()
inserts the entries under freeq_lock and erases them when a page is
replaced.

> RX descriptors return the DMA address of the free queue fragment used by
> the hardware. The driver currently recovers its page by scanning every
> free queue page and comparing address ranges.
>
> This isn't very efficient...

[Severity: Low]
This isn't a bug, but should the commit message say that later fixes in
this series depend on this patch?

The patch is described only as a lookup speed-up and has no Fixes: tag.
Later patches in the series do carry Fixes: tags, and they build on the
per-fragment index added here.

"Correct free queue DMA mappings" (Fixes: 4d5ae32f5e1e) drops the
replacement unmap. It says the lifetime of the replaced mapping "is
handled ... later in the series".

"Preserve in-flight free queue pages" (Fixes: 4d5ae32f5e1e) says "Keep
each exact fragment DMA address in the XArray until software claims its
descriptor". Its geth_freeq_claim() calls xa_erase() on one fragment at a
time.

If those fixes go to net or stable, they won't apply or build without
freeq_mappings, geth_freeq_mapping_index() and the per-fragment
xa_insert()/xa_erase() calls from this patch. Could the dependency be
noted here, so this patch isn't mistaken for net-next material?

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 006362a033952..c1c42e1f93f42 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -726,43 +728,47 @@ static int gmac_setup_rxq(struct net_device *netdev)

[ ... ]

> -unlock:
> +	spin_lock_irqsave(&geth->freeq_lock, flags);
> +	gpage = xa_load(&geth->freeq_mappings, index);
> +	if (!gpage || !gpage->page)
> +		goto err_unlock;
> +
> +	page = gpage->page;
> +	page_mapping = gpage->mapping;
> +	valid = mapping >= page_mapping &&
> +		mapping - page_mapping <= PAGE_SIZE - frag_len &&
> +		!((mapping - page_mapping) & (frag_len - 1));
> +	if (!valid)
> +		goto err_unlock;
> +
> +	*page_offs = mapping - page_mapping;
>  	spin_unlock_irqrestore(&geth->freeq_lock, flags);
>  	return page;

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but
is a CPU sync missing before the fragment is handed back to gmac_rx()?

geth_freeq_lookup() returns a fragment that the device has written,
without calling dma_sync_single_range_for_cpu().

In the other direction, geth_fill_freeq() gives a page with refcount 1
back to the hardware without calling dma_sync_single_for_device():

geth_fill_freeq() {
    ...
		/* Add one reference per fragment in the page */
		page_ref_add(page, 1 << fpp_order);
    ...
}

There are no dma_sync_* calls anywhere in gemini.c at this commit. With
non-coherent DMA, could the CPU read stale cache lines for RX data?

Later patches in this series appear to fix this.
geth_freeq_claim() calls dma_sync_single_range_for_cpu() for each
claimed fragment. geth_freeq_post_page() calls
dma_sync_single_for_device() when recycling a page.
geth_freeq_release_pages() syncs the fragments that hardware still owns.

The commit message of "Preserve in-flight free queue pages" also notes
that the CPU sync is currently a no-op on FA526.

[ ... ]
