Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFF388E63;
	Fri, 17 Jul 2026 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285855; cv=none; b=T7JuIp12NGCnbrC4MXRKXnZZXwpwtw9sZ7CI7+MwUtqcndMgLvqkJamBKDlY7kbcZl+Se9mRIaWPa3QfmCgX13kREofZ1krF0AVvTNIQc1zJ1rcPhOJBkiQT8txAApjM1YjgHk2AU11L0USjeMskyxHldbHg1T4WcnnkFgEhFl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285855; c=relaxed/simple;
	bh=pa6dvyFbfR9PE8HqN6zB2Jvsd1AFKISqyZFw9Np1+H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EF4taRBSaHydFSMLdKsg9HTW7PVfO9E3yCYKz13mJVbzyiuvUGhqMoMLNXkDlEKjQsXr0Xe52ggJHFEFqxLNR0+X4vMK0bk0FZNYlOoQB275U6c88FYAqdYdhKd557vG8V6DLCEEpM0rNRss7wv5RtVGq8JKhPMsi/4uUQlLKhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZUViPnd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZUViPnd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23D91F00A3A;
	Fri, 17 Jul 2026 10:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784285837;
	bh=hoRvErgqkfs5jpMpYRE1GV/40OpQ4sJSKnHa56qmmB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SZUViPnd9pHd4zqdlwnHFih9y3wXrPDnTCkc4rSWaNNFw6f8YubW8bTmLYf2jTG/s
	 mle7+6wvxwy5mCJ10kg72UZEJFTmCOhyrH+Zbq6XBThPmCaUpjpFTVfYGrofR2BXXV
	 8nw0HOeSVadkmOkKm58jbk89PDDpUcxnQ2QqWoOaiP+/0n4+GB3aprsm1MttKAAsg+
	 QolvZ3JCqDIB5mbkPmvjVpkdENcCFFvlqC2WCPZC7Xu4jMODB9LQH/CVlM3wCGcAuB
	 CO+dqyQF78ayl8yTiCBTQ4bCH5nDmwinN7sXX/eosRaxcVhyHw0ePBpeOTSNxWzXnf
	 JynaALHjZu3pA==
From: Simon Horman <horms@kernel.org>
To: hujy652@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	nbd@nbd.name,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	sujuan.chen@mediatek.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2] net:ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986
Date: Fri, 17 Jul 2026 11:55:28 +0100
Message-ID: <20260717105527.435610-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260711112128.971-1-hujy652@gmail.com>
References: <20260711112128.971-1-hujy652@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260711112128.971-1-hujy652@gmail.com?part=1
---
--- Patch [1]: [PATCH net v2] net:ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986 ---
commit d478e0562d6cafb9be212cb1356ac8344230386e
Author: Zhi-Jun You <hujy652@gmail.com>

net:ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986
    
WDMA_RING_TX(0) is required to set MTK_WED_WDMA_RING_TX for WED RX but on a
non-DBDC MT7986 it is never setup because idx is 1. Fix this by calling
mtk_wed_wdma_tx_ring_setup if wed is v2 and rx_ring[0] is not allocated.

Link: https://lore.kernel.org/netdev/20260630144831.1109-1-hujy652@gmail.com/

> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
> --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> @@ -2334,6 +2334,13 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
>  		if (!dev->rx_wdma[i].desc)
>  			mtk_wed_wdma_rx_ring_setup(dev, i, 16, false);
>  
> +	/*
> +	 * non-DBDC MT7986 allocates only rx_ring[1] and tx_wdma[1] during setup
> +	 * but tx_wdma[0] is also needed for WED to function.
> +	 */
> +	if (mtk_wed_is_v2(dev->hw) && !dev->rx_ring[0].desc)
> +		mtk_wed_wdma_tx_ring_setup(dev, 0, MTK_WED_WDMA_RING_SIZE, !!dev->tx_wdma[0].desc);

[Severity: High]
Is it safe to ignore the return value of mtk_wed_wdma_tx_ring_setup() here?

If mtk_wed_ring_alloc() fails under memory pressure, it returns -ENOMEM:

mtk_wed_wdma_tx_ring_setup() {
    ...
    if (!reset && mtk_wed_ring_alloc(dev, wdma, MTK_WED_WDMA_RING_SIZE,
                                     dev->hw->soc->wdma_desc_size, true))
        return -ENOMEM;
    ...
}

Could this result in the hardware being enabled with uninitialized or
zeroed base addresses, potentially leading to DMA faults or system crashes?

Since mtk_wed_start() has the ability to return early on allocation
failure (as seen with mtk_wed_rx_buffer_alloc()), should it abort the
start sequence when this ring setup fails?


[Severity: High]
This isn't a bug introduced by this patch, but when this setup function
is called with reset evaluating to true on v3 hardware, does
mtk_wed_ring_reset() corrupt the v3-specific descriptor initialization?

In mtk_wed_wdma_tx_ring_setup(), v3 hardware initializes desc->info:

mtk_wed_wdma_tx_ring_setup() {
    ...
    if (mtk_wed_is_v3_or_greater(dev->hw)) {
        for (i = 0; i < MTK_WED_WDMA_RING_SIZE; i++) {
            ...
            desc->info = cpu_to_le32(MTK_WDMA_TXD0_DESC_INFO_DMA_DONE);
            ...
        }
    }
    ...
    if (reset)
        mtk_wed_ring_reset(wdma, MTK_WED_WDMA_RING_SIZE, true);
    ...
}

However, mtk_wed_ring_reset() loops over the ring and unconditionally
clears desc->info:

mtk_wed_ring_reset() {
    ...
    desc->info = 0;
    ...
}

Could this wipe out the configured v3-specific state and lead to a DMA
stall or faults on v3 hardware?

> +
>  	if (dev->wlan.hw_rro) {
>  		for (i = 0; i < MTK_WED_RX_PAGE_QUEUES; i++) {
>  			u32 addr = MTK_WED_RRO_MSDU_PG_CTRL0(i) +
