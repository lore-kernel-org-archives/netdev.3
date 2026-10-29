Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793235597;
	b=TL8hdaOh2T6nkqp9vhUEVstknBSkKK4CccHrS/xZuNkO8f5uOrmphRLHhTXV0W6o01V3
	 M8MCGlQBj5K/sa303SxEWq/lvZkYR0zjuz8fGCxJ77ROid1iU1Hr4WMAo8ZfXAsFz/uaA
	 diXOMT/hcTW9hVKAO+XxcT83rqH3Dvx4BzgQ4mCmTfc90jJUM75YnD22hGaJYBkeCxUFt
	 piBaCOkgXAO9SlxC0b2363ku1JFZiVwhz4hK9xDngzUwoOieptbxCO3afgODKUlgxcHM/
	 LHn1HosRqgGhfEmTk+D4rznKyHzfFrP5gig30t8xecDI1oqO7FzTa1s07DBgUVlFuvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793235597;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oS0FmMc7AlJVVVUeRFYj25Bo+BdWrMabkFQ8UmhHdq4=;
	b=ozmuMYvQuW5g+ZFZXIA3AYIl0vf5IiYm59AgMvANh8++Vf538bFMR3zX1O/a4+U0d4GM
	 vuT4hrCMqH03bj5lsaayib7p9TVCTm5fnairDAKuH2YoBBAlC+b89BIf08V6wAbLz3QET
	 RV3je5DfeeQEKbvfKbbdbjtB0jpgXVTtZqaNStlW2uMNFA+ulLYWpY8dd7E5y5mWoD99h
	 Lly4jgHIg8ytOCN6lkyPXF0DHV7VB6F2G2sYLB8eQMQ2ipl0d5Ioa6u8C5Rr8MIMYEZDS
	 AS9OPBp7pCwTKKIusG4SWYk8JyVpK2pyYpQql9/ck3DrmLrwXQsMCsGFY3d/bs+S+vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WVuy9JUJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51713606A31A;
	Thu, 29 Oct 2026 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WVuy9JUJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8D31F01825;
	Thu, 29 Oct 2026 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793235597;
	bh=oS0FmMc7AlJVVVUeRFYj25Bo+BdWrMabkFQ8UmhHdq4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WVuy9JUJvVpnxgRolTlrO1MIZj20fkCl0H3mXHHgjQXpD2liErU9VCyFiPf8gewhV
	 llC0VAnh+/2o13ZitUeepntk7dWSQmy6SHXnGnZ+Mx2N3a+MAhP+TidwG9FZS2CVsi
	 8zNOIViOZL1WKKL7Mytanwerah70JXEq1PmuVYwgj5czZGj3EBYTFCGQOppEv1QN8p
	 hAnUtMkfbOvQ5auIukcnf7AfJpGa6dCcUN8jWWfGYIFPgwpo/hx0UPCScJxnsgM24P
	 E/8y72dp8s85s7iphCPWgVhP1Yw7HK/HiIpU96nhcQynvyTGBShEIzljYkA+HZKIMe
	 /yky4ATwXN6Ow==
Subject:
 Re: [PATCH net v6 3/4] net: ethernet: mtk_wed: free up rings during detach
From: netdev-bot+sashiko@kernel.org
To: hujy652@gmail.com
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 sujuan.chen@mediatek.com, rex.lu@mediatek.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, sashiko-bot@kernel.org
Date: Thu, 29 Oct 2026 00:59:55 +0000
Message-ID: <179323559576.3134.3581964797425462358@kernel.org>
In-Reply-To: <20261026-wedfix-v6-3-a52f6b15d2fc@gmail.com>
References: <20261026-wedfix-v6-3-a52f6b15d2fc@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] After this patch, mtk_wed_free_rx_rings()
  (drivers/net/ethernet/mediatek/mtk_wed.c:954-958) calls…

--

net: ethernet: mtk_wed: free up rings during detach

This commit makes mtk_wed_free_rx_rings() also free the rx_ring[] and
tx_wdma[] descriptor rings. Before this, __mtk_wed_detach() leaked them.
The change comes from mtk-openwrt-feeds and was modified to check
ring->desc instead of an extra flag.

Link: https://github.com/mediatek/mtk-openwrt-feeds/blob/main/25.12/files/target/linux/mediatek/patches-6.12/999-wed-04-Fix-reinsert-wifi-module-cause-memory-leak-issue.patch
Link: https://sashiko.dev/#/message/179000700034.2160803.10594281691384015089%40kernel.org

> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
> index 3f0be70c3f145..3044a7a8ea03e 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> @@ -949,6 +949,14 @@ mtk_wed_free_ring(struct mtk_wed_device *dev, struct mtk_wed_ring *ring)
>  static void
>  mtk_wed_free_rx_rings(struct mtk_wed_device *dev)
>  {
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dev->rx_ring); i++)
> +		mtk_wed_free_ring(dev, &dev->rx_ring[i]);
> +
> +	for (i = 0; i < ARRAY_SIZE(dev->tx_wdma); i++)
> +		mtk_wed_free_ring(dev, &dev->tx_wdma[i]);

[Severity: Low]
Could the WDMA engine still be writing to the tx_wdma[] descriptors when
they are freed here?

In __mtk_wed_detach(), these rings are freed right after
mtk_wed_wo_reset(), which returns void:

__mtk_wed_detach()
    mtk_wed_wo_reset(dev);
        mtk_wdma_tx_reset(dev);
    mtk_wed_free_rx_rings(dev);
        dma_free_coherent(..., tx_wdma[i].desc, ...)

If the TX_DMA_BUSY poll in mtk_wdma_tx_reset() times out, the timeout is
only logged:

mtk_wdma_tx_reset() {
    ...
	wdma_clr(dev, MTK_WDMA_GLO_CFG, MTK_WDMA_GLO_CFG_TX_DMA_EN);
	if (readx_poll_timeout(mtk_wdma_read_reset, dev, status,
			       !(status & mask), 0, 10000))
		dev_err(dev->hw->dev, "tx reset failed\n");
    ...
	for (i = 0; i < ARRAY_SIZE(dev->tx_wdma); i++)
		wdma_w32(dev,
			 MTK_WDMA_RING_TX(i) + MTK_WED_RING_OFS_CPU_IDX, 0);
}

mtk_wdma_v3_tx_reset() handles timeouts in its prefetch and writeback
BUSY polls the same way.

Only the CPU_IDX registers are cleared. The MTK_WDMA_RING_TX(i) BASE
registers and the WED WDMA_RING_TX BASE registers still point at
desc_phys.

If the engine has not gone idle, can a late descriptor fetch or
writeback land in coherent memory that has already gone back to the
allocator? Before this patch the rings were leaked, so such a write
could only reach memory that nothing else was using.

This depends on a hardware timeout, and I could not confirm from the
code that a late writeback really happens. TX_DMA_EN has already been
cleared in mtk_wed_dma_disable(), and MTK_WED_RESET_WED has been
asserted.

The same function already frees rx_wdma[] in mtk_wed_free_tx_rings()
right after mtk_wdma_rx_reset(), whose -ETIMEDOUT return is ignored, so
this follows an existing pattern in the driver. Would it be worth either
skipping the free on a reset timeout or clearing the ring BASE registers
before freeing?

> +
>  	mtk_wed_free_rx_buffer(dev);
>  	mtk_wed_free_ring(dev, &dev->rro.ring);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026-wedfix-v6-0-a52f6b15d2fc%40gmail.com
