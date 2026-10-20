Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491045;
	b=gBGFavcAJSUkC0shxvJvSvgZAMpmrTXb3l3LJMHlULyaYBJ/bK4RlNXBXpIB8IEB8Bw2
	 6sdikJcQ6SRRxeiOlqpBzlCo6z4XZwnCapXI9fTqG1V25Yo12y/n0QAhHqdPX8DaJv7hh
	 ZVBnaiFcMaXv2oO7Eg2kG6oM8T6PwtczKaKkg/fN1gjjVNDHVSTu85Hr6/unIqiA1YeNU
	 IWxH7iAK9T3UUOiTOXsS0lywE42ZV5daYiFO+SOV+WvntW4U/SaCXLSUqsH4twhB/9KrV
	 0m9C8ewFwwpL6DPZ6Jy49ZMW+LiiUY3HtY3s7qWoVJ9RdY7N0UtzsRxPwoa3XrWpceA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491045;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MMHFHJsHvrQ6vsAyrpqxqCfyIZhO9hxrgzTqYUNgKyM=;
	b=MTSnTQdOgOsl3VYtkzMHcjcQlgWnuFG2N1C3AckoYXHwYdIM+W/DBsJxeq9Ps9FHTMOu
	 7DZW97Rx6BvLfssBdRibCtoWWiCanBspDThfw5sB9j5fFL6Dx6FCOnrWsslJqfaQ8WxHe
	 t9kKNX7p2pPbhTXdj1io1kGEO0MMZUtUupaRhVqYiNaf6JE3sj3i2AJW51eiB0JAjRfuK
	 yEQpi87d8t5Z0eZ0ikhhH9j4VGgTDnaWdOoxrsyRAhR01OvlD2ILaUzFfg8vX8GCAQ86K
	 M/roRcQ87/JHygrhJ1d2wT/8mauc51Syuo+ngAo6eWYq2tFwGp83v8WS6wukvW95Fjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJ0vlel+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3BA606A33C;
	Tue, 20 Oct 2026 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJ0vlel+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39D71F000C6;
	Tue, 20 Oct 2026 10:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792491045;
	bh=MMHFHJsHvrQ6vsAyrpqxqCfyIZhO9hxrgzTqYUNgKyM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YJ0vlel+0ZFenaF2Hs5rWNEGQjMJkDJ44Nx1JIrKo56KCi3vKcYnbcDKuPBKAIzmM
	 8NBUWIHgtC9DUO4r4g9QegKQXQL1hh0UuFG2hcFlE60B9QU2Si1mJvy7Det0bqdnyx
	 LMAnW/UshLwIVESQwSuNUVWj4G34muIkjl+T0HQisunWR1sCJQOC7fMy9UVgz6Dtng
	 i289+FAQMOiYodKRf4YlIlA1+TA2RX0gm5HFrz7Puzad2xxI986j/MvV5rSCQO1IGS
	 /nIZHjyCwCKNgjTSdqnmIQGFIvPKnKjFQfURJdOj4qgnMrQPZH9h2Kd9NXLHFwdx+Z
	 p7n3bkdXSGZLg==
Subject: Re: [PATCH net v5 4/5] net: ethernet: mtk_wed: setup WDMA_RING_TX(0)
 for non-DBDC MT7986
From: netdev-bot+sashiko@kernel.org
To: hujy652@gmail.com
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 sujuan.chen@mediatek.com, rex.lu@mediatek.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Date: Tue, 20 Oct 2026 10:10:44 +0000
Message-ID: <179249104422.3135.15395792602371896876@kernel.org>
In-Reply-To: <20261016-wedfix-v5-4-8b02e78fd34f@gmail.com>
References: <20261016-wedfix-v5-4-8b02e78fd34f@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In mtk_wed_start()
  (drivers/net/ethernet/mediatek/mtk_wed.c:2362-2363), this commit adds…
- [Medium] mtk_wed_free_rx_rings()
  (drivers/net/ethernet/mediatek/mtk_wed.c:954-956) decides whether to…
- [Low] The new comment in mtk_wed_start() describes the motivating case,
  a non-DBDC MT7986 that allocates only rx_ring[1]/tx_wdma[1].

--

net: ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986

This patch makes mtk_wed_start() set up WDMA_RING_TX(0) on WED v2 devices
when rx_ring[0] was not allocated. This is the case on a non-DBDC MT7986,
which only sets up ring index 1. If tx_wdma[0] is already allocated, it is
reset instead of being allocated again.

> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
> index b8264435acbe5..3a7c2bb33691f 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> @@ -2355,6 +2355,13 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
>  		if (!dev->rx_wdma[i].desc)
>  			mtk_wed_wdma_rx_ring_setup(dev, i, 16, false);
>  
> +	/*
> +	 * non-DBDC MT7986 allocates only rx_ring[1] and tx_wdma[1] during setup
> +	 * but tx_wdma[0] is also needed for WED to function.
> +	 */
> +	if (mtk_wed_is_v2(dev->hw) && !dev->rx_ring[0].desc)

[Severity: Low]
This isn't a bug, but the comment covers less than the condition does. The
guard matches any WED v2 device where rx_ring[0] was not set up, and MT7981
also has .version = 2. It is not limited to a non-DBDC MT7986.

Could the comment describe the condition as it is implemented, the way the
commit message does?

> +		mtk_wed_wdma_tx_ring_setup(dev, 0, MTK_WED_WDMA_RING_SIZE, !!dev->tx_wdma[0].desc);

[Severity: Medium]
Should the return value of mtk_wed_wdma_tx_ring_setup() be checked here?

On the first start, tx_wdma[0].desc is NULL, so reset is false and the
helper allocates the ring. If the allocation fails, the helper returns
before it programs any WDMA or WED ring register:

mtk_wed_wdma_tx_ring_setup() {
	...
	if (!reset && mtk_wed_ring_alloc(dev, wdma, MTK_WED_WDMA_RING_SIZE,
					 dev->hw->soc->wdma_desc_size, true))
		return -ENOMEM;
	...
}

mtk_wed_start() keeps going anyway. It calls mtk_wed_hw_init() and then
mtk_wed_dma_enable(), which does:

	wed_set(dev, MTK_WED_WDMA_GLO_CFG,
		MTK_WED_WDMA_GLO_CFG_TX_DRV_EN |
		MTK_WED_WDMA_GLO_CFG_TX_DDONE_CHK);

It then sets dev->running = true. At that point WDMA TX is enabled but the
ring 0 base was never programmed.

The other caller of this helper, mtk_wed_rx_ring_setup(), does pass the
failure back:

	if (mtk_wed_wdma_tx_ring_setup(dev, idx, MTK_WED_WDMA_RING_SIZE,
				       reset))
		return -ENOMEM;

A later patch in this series, "net: ethernet: mtk_wed: bail out when
failed to set up rings in wed_start", wraps this call with a dev_err()
and a return. With that patch applied, the end of the series is fine. Can
the check be added in this patch so it works on its own?

[ ... ]

[Severity: Medium]
This code is not part of this hunk. It comes from the earlier patch in
this series, "net: ethernet: mtk_wed: free up rings during detach". It is
mentioned here because mtk_wed_free_rx_rings() is also what frees the
tx_wdma[0] ring added above. Does the flag check test the right array?

mtk_wed_free_rx_rings() {
	...
	for (i = 0; i < ARRAY_SIZE(dev->rx_ring); i++)
		if ((dev->tx_ring[i].flags & MTK_WED_RING_CONFIGURED))
			mtk_wed_free_ring(dev, &dev->rx_ring[i]);
	...
}

mtk_wed_rx_ring_setup() sets MTK_WED_RING_CONFIGURED on
dev->rx_ring[idx].flags, not on tx_ring[idx]. So if rx_ring[i] is
configured and tx_ring[i] is not, the coherent descriptor buffer for
rx_ring[i] is not freed. After that, __mtk_wed_detach() calls
memset(dev, 0, sizeof(*dev)) and the pointer is lost.

One setup where this appears to happen is MT7988 with an MT7992 using
hif2. mt7996_dma_init() registers the band1 rx queue on the primary WED
as MT_WED_Q_RX(1). mt7996_register_phy() sends band1 tx to wed_hif2. The
primary WED therefore has rx_ring[1] configured but not tx_ring[1].

Does primary rx_ring[1] then leak on every detach, for example on a
module reload? Should this check dev->rx_ring[i].flags instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-wedfix-v5-0-8b02e78fd34f%40gmail.com
