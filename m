Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F84BFE72;
	Mon, 21 Sep 2026 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007004; cv=none; b=VPwcdfRR4qe5cRHHcXOwPTpW5ryPUXl2DUdw1u6BJCwLkQ4XfRRyqmDdCYxw8Sh0qLWWCTJZBwNRQR5LfieCFwabMla1uv9bCbzS9Ckj3hEVO5Hn1Qnjmm4Cw2Z5OhhklHyhp8gus7EmsA/Tz02+zhZuIw9OvlBd6C+fniT2Ud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007004; c=relaxed/simple;
	bh=NbPulBCELv0H2q/E+uGtw6KeAuqtwDAXmQ6zOv0kNBw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=abnIERDqYVVu025EcazEa8wMznFwlQrJ2rG6l9NbTLZP3PmNezxzXyVTnvNtlSVSdMrVF+NzBqlHnJJtyd/h3MsBtJ65ECnPCvssUMJyKBQpXeZHEeIBGcy/Iwr742K9sZOZMCVOUUDju1gETWoOTtUeadypgetp1Tx6Z9OTCfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8H4FXk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8H4FXk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D7C1F000FF;
	Mon, 21 Sep 2026 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790007001;
	bh=8Dcl/YCF2+B098BGRJ8CrT3yll1ewyEntjQdy30W5P4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U8H4FXk2ri/2sD/yFYT+r33CsULfV6zir8BMvHAGdh04PvCgac9ult+PiQEzJAOLf
	 PUfnkPM9fmPeH+dWRkW7MEd0cufrUy6QRfif8QWFDfL5fFUzzns2r2hm2w/l+GVk5S
	 1LdZZpX7aCf3czlUPykZsV24sAQ/J9cALH3z0woJWa23rB4PbBvEC108NWtk9LEH6O
	 XggwGv4iWzAUUu2rlziQg4CQ5Y6x0cWxn23RExJ9xVKnoEnuiSu2+2d4a6oXi42gZk
	 vHi7uugSHWh68R4bhCjVLc9cxu78WO+yXrFaFELY7Bx437OV/dWgCHtQtZUYgu1chx
	 fT6of19l3ygCQ==
Subject: Re: [PATCH net v4 3/3] net: ethernet: mtk_wed: setup WDMA_RING_TX(0)
 for non-DBDC MT7986
From: netdev-bot+sashiko@kernel.org
To: hujy652@gmail.com
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 sujuan.chen@mediatek.com, Rex.Lu@mediatek.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Date: Mon, 21 Sep 2026 16:10:00 +0000
Message-ID: <179000700034.2160803.10594281691384015089@kernel.org>
In-Reply-To: <20260917144335.19466-3-hujy652@gmail.com>
References: <20260917144335.19466-3-hujy652@gmail.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In mtk_wed_start()
  (drivers/net/ethernet/mediatek/mtk_wed.c:2346-2347) the newly added…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  widens it: dev->tx_wdma[] descriptor rings are allocated with…

--

net: ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986

On a non-DBDC MT7986 only rx_ring[1]/tx_wdma[1] get set up, so
WDMA_RING_TX(0) is never programmed even though WED needs it for RX
offload.  The patch adds a call to mtk_wed_wdma_tx_ring_setup() for ring 0
from mtk_wed_start() when the device is WED v2 and rx_ring[0] was not
allocated, passing reset=true when tx_wdma[0] already exists.

> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
> index 3f0be70c3f145..3800e602d3c48 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> @@ -2339,6 +2339,13 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
>  		if (!dev->rx_wdma[i].desc)
>  			mtk_wed_wdma_rx_ring_setup(dev, i, 16, false);
>  
> +	/*
> +	 * non-DBDC MT7986 allocates only rx_ring[1] and tx_wdma[1] during setup
> +	 * but tx_wdma[0] is also needed for WED to function.
> +	 */
> +	if (mtk_wed_is_v2(dev->hw) && !dev->rx_ring[0].desc)
> +		mtk_wed_wdma_tx_ring_setup(dev, 0, MTK_WED_WDMA_RING_SIZE, !!dev->tx_wdma[0].desc);

[Severity: Medium]
Should the return value of mtk_wed_wdma_tx_ring_setup() be checked here?

On the first start of a non-DBDC v2 device dev->tx_wdma[0].desc is NULL, so
reset is false and the helper takes the allocation path:

drivers/net/ethernet/mediatek/mtk_wed.c:mtk_wed_wdma_tx_ring_setup() {
	wdma = &dev->tx_wdma[idx];
	if (!reset && mtk_wed_ring_alloc(dev, wdma, MTK_WED_WDMA_RING_SIZE,
					 dev->hw->soc->wdma_desc_size, true))
		return -ENOMEM;
	...
}

mtk_wed_ring_alloc() does a dma_alloc_coherent() of
MTK_WED_WDMA_RING_SIZE * wdma_desc_size (32 KiB on MT7986), and on failure
the helper returns before writing MTK_WDMA_RING_TX(0) BASE/COUNT/CPU_IDX/
DMA_IDX and before the "if (!idx)" block that programs the WED side
MTK_WED_WDMA_RING_TX window.

Since the status is dropped, mtk_wed_start() keeps going through
mtk_wed_hw_init(), mtk_wed_configure_irq() and mtk_wed_dma_enable(), which
arms MTK_WDMA_GLO_CFG_TX_DMA_EN and, for rx-capable v2,
MTK_WED_WDMA_GLO_CFG_TX_DRV_EN | MTK_WED_WDMA_GLO_CFG_TX_DDONE_CHK, and
then sets dev->running = true.  Can the hardware then fetch descriptors
from a ring whose base register was left at 0 by the preceding
mtk_wdma_tx_reset()/mtk_wed_reset(), leaving the WED offload silently
non-functional with no message?

The other caller of the same helper propagates the failure:

drivers/net/ethernet/mediatek/mtk_wed.c:mtk_wed_rx_ring_setup() {
	if (mtk_wed_wdma_tx_ring_setup(dev, idx, MTK_WED_WDMA_RING_SIZE,
				       reset))
		return -ENOMEM;
	...
}

and mtk_wed_start() itself already bails out on mtk_wed_rx_buffer_alloc()
and mtk_wed_rro_cfg() failures.  Since mtk_wed_ops.start is void and
mt7915_dma_start() cannot observe the error, would it make sense to abort
the start sequence locally here (skipping mtk_wed_dma_enable() and
dev->running = true) and log the failure?

[Severity: Medium]
This isn't a problem introduced by this patch, but does this new call add
another leak of dev->tx_wdma[0]?

dev->tx_wdma[] rings are allocated by mtk_wed_ring_alloc() via
mtk_wed_wdma_tx_ring_setup(), but the ring-release helpers never free that
array:

drivers/net/ethernet/mediatek/mtk_wed.c:mtk_wed_free_tx_rings() {
	for (i = 0; i < ARRAY_SIZE(dev->tx_ring); i++)
		mtk_wed_free_ring(dev, &dev->tx_ring[i]);
	for (i = 0; i < ARRAY_SIZE(dev->rx_wdma); i++)
		mtk_wed_free_ring(dev, &dev->rx_wdma[i]);
}

drivers/net/ethernet/mediatek/mtk_wed.c:mtk_wed_free_rx_rings() {
	mtk_wed_free_rx_buffer(dev);
	mtk_wed_free_ring(dev, &dev->rro.ring);
}

__mtk_wed_detach() calls those helpers and then does
memset(dev, 0, sizeof(*dev)), so tx_wdma[].desc/desc_phys are discarded and
the 32 KiB coherent allocation can no longer be released.

The existing allocation site is mtk_wed_rx_ring_setup(), so the omission
predates this change, but non-DBDC MT7986/MT7981 previously never allocated
tx_wdma[0] at all, and now every attach/start/detach cycle would leak one
more ring.  Would adding dev->tx_wdma[] to mtk_wed_free_tx_rings() be the
right way to restore alloc/free symmetry?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917144335.19466-1-hujy652%40gmail.com
