Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491044;
	b=PXhbREeNRtBZw0oXLEW0MInJukfKZR1iLqB6aJuQ6iwJ+0xnksnno6FhS7tIeQGaquhg
	 JENuJDl2u5hVvaYDMJwqC0udO0mnNX3YqwHY9TTV1/WfT85hYjlPrruNpuuZTUP4KvRDc
	 cTgO3k7rzVO6ySrtcWI65KaHbUGU6oiB9k1ravFQzbSGTxP/KZxwIH/zz4iDN2WYjS8a2
	 7H4GLprB4r0VysQxvAUO8MBoUHksavuQ3l3D3nUlTZ98I/LB/dNahzLvSFFd7UOYIMvNP
	 GgX2uBfS063gom/lF43T5VCec6gWgC662hepehcmqO84OOz35bMKpuLWH0Q+2eOZrWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491044;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fQPIuEpvWD+B7zD+vc2FJ+857BaEpzNPJt644Gt/XNE=;
	b=sc6iUawt/yDAx8dBm8N7Pk54ACy+GlfRxYvFA/XN1YCu/1h6HgRTQNTlxqWG9aR9NqpC
	 aupeaRBqo/RqqyZ1sU4UWCqrzlSzk50fHS/M8uSz+llKyVIMBdno/aQWrUjR0+X9zWMvT
	 m6x+P7A0vbN5B6IfBF8g4alsTaZtDdzzOgHYClUk2lKCjr6xFTBhT4QEmA3qj5kuWY02J
	 FDXuE1jHh/d8cSmtj2+LHgcgWBMT9yAESTl7BEZjOXGacLICCi2zS3KaHiIOIPi3S9WBn
	 W9I5eYNUfq1kItbhMPXjjh4DWuMb3jZdGbHXqLqKoSfaUDfRoRBOfzAqjsfWV6yebdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KiKYLVMC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750EA606A32A;
	Tue, 20 Oct 2026 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KiKYLVMC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3597D1F000C7;
	Tue, 20 Oct 2026 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792491044;
	bh=fQPIuEpvWD+B7zD+vc2FJ+857BaEpzNPJt644Gt/XNE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KiKYLVMCggbH067ZJKEdACaWtrYZoeoYJIiN8o2ZTZiVzEvR1SG87a6QsRgDmlicX
	 ZrOPC6gY5TuT4NaWhoJmspYcKGvMSgLEOmBpZqyCm0aE5+M6oGwch+bDrY5p/4uGLL
	 3QLoqlcm8b7uV0qOycg+6oZYgL9FGjGbmFEhLsZbxZhrfYOM8bXhTHxsLt3rplfYLl
	 FD99Iayp8OzeZVj3Ox5G4ZboMDWB+HzdU7yQO40G/rdaR894bXxbF4bdRgIKpxWYXQ
	 r8NbuPQMuWE7nkKlPoJwYkDoeL4rrIgqUYe438K7lnNjZcGb+aZ4ybstVrmEN26uXP
	 5QP4mxOqoSJxQ==
Subject:
 Re: [PATCH net v5 3/5] net: ethernet: mtk_wed: free up rings during detach
From: netdev-bot+sashiko@kernel.org
To: hujy652@gmail.com
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 sujuan.chen@mediatek.com, rex.lu@mediatek.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Date: Tue, 20 Oct 2026 10:10:42 +0000
Message-ID: <179249104276.3135.12420565113536395663@kernel.org>
In-Reply-To: <20261016-wedfix-v5-3-8b02e78fd34f@gmail.com>
References: <20261016-wedfix-v5-3-8b02e78fd34f@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Copy-paste bug in the new rx_ring cleanup loop in
  mtk_wed_free_rx_rings()…
- [Medium] The new flag gating in mtk_wed_free_tx_rings() causes a leak
  on partial setup failure.
- [Medium] The patch now frees the rx_ring descriptor memory in
  __mtk_wed_detach() → mtk_wed_free_rx_rings(), but WED never disables…

--

net: ethernet: mtk_wed: free up rings during detach

This commit adds frees for rx_ring and tx_wdma in mtk_wed_free_rx_rings()
during __mtk_wed_detach(). It also sets MTK_WED_RING_CONFIGURED in the
tx/rx ring and wdma tx/rx ring setup paths, and only frees rings that have
that flag set.

Link: https://github.com/mediatek/mtk-openwrt-feeds/blob/main/25.12/files/target/linux/mediatek/patches-6.12/999-wed-04-Fix-reinsert-wifi-module-cause-memory-leak-issue.patch

> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
> index 3f0be70c3f145..b8264435acbe5 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> @@ -949,6 +949,16 @@ mtk_wed_free_ring(struct mtk_wed_device *dev, struct mtk_wed_ring *ring)
>  static void
>  mtk_wed_free_rx_rings(struct mtk_wed_device *dev)
>  {
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(dev->rx_ring); i++)
> +		if ((dev->tx_ring[i].flags & MTK_WED_RING_CONFIGURED))
> +			mtk_wed_free_ring(dev, &dev->rx_ring[i]);

[Severity: High]
Should this check dev->rx_ring[i].flags instead of dev->tx_ring[i].flags?

The flag on rx_ring[idx] is set in mtk_wed_rx_ring_setup(), and that
function never touches tx_ring[idx]. The existing reader in
mtk_wed_dma_enable() also tests the flag on the rx ring itself:

	for (i = 0; i < MTK_WED_RX_QUEUES; i++) {
		struct mtk_wed_ring *ring = &dev->rx_ring[i];
		...
		if (!(ring->flags & MTK_WED_RING_CONFIGURED))
			continue; /* queue is not configured by mt76 */

TX and RX rings are set up separately, so their flags can differ. Take
MT7992 with a second HIF:

- mt7996_dma_init() puts band1 RX on the primary WED's rx_ring[1].
- mt7996_register_phy() sends band1 TX to wed_hif2.
- mt7996_init_tx_queues() then uses MT_WED_Q_TX(0) on wed_hif2.

So the primary WED's tx_ring[1] is never configured.

In that case, is the rx_ring[1] descriptor memory still leaked on every
detach? This loop skips it, and the pointer is then lost to the
memset(dev, 0, sizeof(*dev)) at the end of __mtk_wed_detach(). That looks
like the same leak the commit message says it fixes.

mtk_wed_free_ring() already returns early when ring->desc is NULL. Would
dropping the flag check here be enough?

> +
> +	for (i = 0; i < ARRAY_SIZE(dev->tx_wdma); i++)
> +		if ((dev->tx_wdma[i].flags & MTK_WED_RING_CONFIGURED))
> +			mtk_wed_free_ring(dev, &dev->tx_wdma[i]);
> +
>  	mtk_wed_free_rx_buffer(dev);
>  	mtk_wed_free_ring(dev, &dev->rro.ring);
>  }

[Severity: Medium]
Can rx_ring[i] be freed here while the WLAN chip's WFDMA RX engine still
points at it?

mtk_wed_rx_ring_setup() writes ring->desc_phys into the WLAN chip's PDMA
RX ring registers through wpdma_rx_w32(). mtk_wed_dma_enable() then turns
on the chip's RX DMA:

		val = wifi_r32(dev,
			       dev->wlan.wpdma_rx_glo -
			       dev->wlan.phy_base) | MTK_WFMDA_RX_DMA_EN;
		wifi_w32(dev,
			 dev->wlan.wpdma_rx_glo - dev->wlan.phy_base,
			 val);

mtk_wed_dma_disable() never clears MTK_WFMDA_RX_DMA_EN. On normal teardown
mt7915/mt7996 disable DMA before mt76_dma_cleanup() detaches WED. The
mt7915 probe error path does not seem to do that:

mt7915_init_hardware()
  mt7915_dma_init()
    mt7915_dma_enable()
      mt7915_dma_start()
        mtk_wed_device_start()     <- WFDMA RX enabled
  mt7915_mcu_init()                <- fails, returns without DMA disable

The probe error label in mt7915/pci.c or mt7915/soc.c then runs:

mtk_wed_device_detach()
  __mtk_wed_detach()
    mtk_wed_free_rx_rings()
      mtk_wed_free_ring(dev, &dev->rx_ring[i])
        dma_free_coherent()

If the chip writes back an RX descriptor after this point, would that
corrupt memory that has since been reused? Before this patch the ring
leaked, so such writes landed in memory that was still allocated.

The error path leaving DMA armed predates this patch, and the RX packet
buffers were already freed in this window. Whether the chip really writes
descriptors after MCU init fails depends on hardware behaviour. Freeing
the descriptor ring here is the new part.

> @@ -959,9 +969,11 @@ mtk_wed_free_tx_rings(struct mtk_wed_device *dev)
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(dev->tx_ring); i++)
> -		mtk_wed_free_ring(dev, &dev->tx_ring[i]);
> +		if ((dev->tx_ring[i].flags & MTK_WED_RING_CONFIGURED))
> +			mtk_wed_free_ring(dev, &dev->tx_ring[i]);

[Severity: Medium]
Does this leak the tx_ring[idx] descriptor buffer when
mtk_wed_tx_ring_setup() fails partway?

mtk_wed_tx_ring_setup() allocates the descriptor before it sets the flag:

	if (!reset && mtk_wed_ring_alloc(dev, ring, MTK_WED_TX_RING_SIZE,
					 sizeof(*ring->desc), true))
		return -ENOMEM;

	if (mtk_wed_wdma_rx_ring_setup(dev, idx, MTK_WED_WDMA_RING_SIZE,
				       reset))
		return -ENOMEM;

	ring->reg_base = MTK_WED_RING_TX(idx);
	ring->wpdma = regs;
	ring->flags |= MTK_WED_RING_CONFIGURED;

If the rx_wdma dma_alloc_coherent() fails, tx_ring[idx].desc stays
allocated but the flag is never set. The -ENOMEM travels up:

mt76_wed_dma_setup()
  mt76_dma_alloc_queue()
    mt7915/mt7996 dma init
      probe error path
        mtk_wed_device_detach()

Before this patch, mtk_wed_free_tx_rings() freed the ring because
mtk_wed_free_ring() only checks ring->desc. With the new check the ring
is skipped, and the memset in __mtk_wed_detach() then drops the pointer.

mtk_wed_rx_ring_setup() uses the same order. A failure in
mtk_wed_wdma_tx_ring_setup() returns before rx_ring[idx].flags is set, so
the flag-gated rx_ring free in mtk_wed_free_rx_rings() cannot reclaim
that ring either.

Since mtk_wed_free_ring() already guards on ring->desc, what does the
MTK_WED_RING_CONFIGURED check add in these free loops? The commit message
does not explain why the frees are gated.

>  	for (i = 0; i < ARRAY_SIZE(dev->rx_wdma); i++)
> -		mtk_wed_free_ring(dev, &dev->rx_wdma[i]);
> +		if ((dev->rx_wdma[i].flags & MTK_WED_RING_CONFIGURED))
> +			mtk_wed_free_ring(dev, &dev->rx_wdma[i]);
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-wedfix-v5-0-8b02e78fd34f%40gmail.com
