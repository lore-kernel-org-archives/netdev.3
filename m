Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491041;
	b=IdyFE5+BnHONLckst9qco99lqlnm6Vk8sQIrO/DDmkA6X4ulM415VS9HiTVoBjfxywYk
	 hqzG7lE4tcmpXtu3JFzq0inUVLy6QdX75XtCVTEF4+pFImBTxZvKYd+V2KQuCUFtCfJ3h
	 wUWSI8F6bxvlSS+nNmwxl14oroihkgP40+kcQRumGl2aSa41rMe3nWahM8LaIb7uWx9+V
	 Nq54IhWbR/giAj0EsKR1+OHUVxJ2KD9j8IB053J1jpWM6cyZd6boWQDul5Wwm4YUYoykp
	 3rWMIBLD67EES2plSggLYDblzOdJNWnniXbx+8I720qrx8OdoV+Tn1jB95S+vk1Y1Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491041;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5EL4xcpEAaTLBP9HyYnzoNI2lvu1UvL/iwtcQQL4HvU=;
	b=va8AEBZ7a9ZrdiIp2V9jnm2n5XTc5SrLn/0Y/ud0edqmW4b5nIZqq2MwElh6nf752WXZ
	 EUs0B2h4lGbnWeZZ69CJEQiN4YBL0+WGK83ky12Ww4HNFgu/ysZJKsh1/s+ONtR9qIppk
	 rN2SZVSG0n0yiBV+rt3dyInkJ4gjCzUDcD32wChKvO22zwdMar3G/gMDyMzc67lsAuNiA
	 kVzIWJSWY+z6pC66yjng5Br6At2TN8vAgufT6tkNJHORxoGNFFVOZy3pmoVsAHWV9iBPf
	 SWH9u4uA7dcCvZV9MkFwynmozDsIbKfk1uvBklpYxQthMjYM5n2S3C85X8BFPO0QQxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S9V7JYW3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A270606A31E;
	Tue, 20 Oct 2026 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S9V7JYW3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564461F000C4;
	Tue, 20 Oct 2026 10:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792491041;
	bh=5EL4xcpEAaTLBP9HyYnzoNI2lvu1UvL/iwtcQQL4HvU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S9V7JYW3J5QXsgoaZUgvWdJVADjrvM9bjyxqXiHF+e/lbyGC4czDQuIr82jsBH3D7
	 4sdNyrht6TnJCO9hIxYM1u90t6bMX+gBGrouuvW8p+JqLeaSqr9TMImfss9w+2BOq4
	 btXMWQsGxlamT1Y8XCc5Eff5RjGgiKvOvgiELLsdr142LU+0EI6hRivdBzzhaS8jzw
	 pjSwQOroBeuiYbm3bNI/UwHXJyxXTc8fJDHiEl0w32dElxckkfrbANK0hpZZCNn3LZ
	 EnJFRGUQjmLjcRepZUTrid3mWgsVcGNnovKLEwtqFjlLQ2J7HnwfRGrtHQYQuo5iDe
	 fu6ArfV1nLdsg==
Subject: Re: [PATCH net v5 1/5] net: ethernet: mtk_wed: skip ring reset in
 wdma_tx_ring_setup for WED v3
From: netdev-bot+sashiko@kernel.org
To: hujy652@gmail.com
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 sujuan.chen@mediatek.com, rex.lu@mediatek.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Date: Tue, 20 Oct 2026 10:10:39 +0000
Message-ID: <179249103985.3135.17834274932669029718@kernel.org>
In-Reply-To: <20261016-wedfix-v5-1-8b02e78fd34f@gmail.com>
References: <20261016-wedfix-v5-1-8b02e78fd34f@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: mtk_wed: memory leak of rx_ring and tx_ring on setup
  failure

--

> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
> --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> @@ -1938,7 +1938,7 @@ mtk_wed_wdma_tx_ring_setup(struct mtk_wed_device *dev, int idx, int size,
>  	wdma_w32(dev, MTK_WDMA_RING_TX(idx) + MTK_WED_RING_OFS_CPU_IDX, 0);
>  	wdma_w32(dev, MTK_WDMA_RING_TX(idx) + MTK_WED_RING_OFS_DMA_IDX, 0);
>  
> -	if (reset)
> +	if (!mtk_wed_is_v3_or_greater(dev->hw) && reset)
>  		mtk_wed_ring_reset(wdma, MTK_WED_WDMA_RING_SIZE, true);
>  
>  	if (!idx)  {
>

[Severity: High]
The change here looks fine to me. Since mtk_wed_wdma_tx_ring_setup()
is one of the failure points involved, I'm raising the ring teardown
changes later in this series here. That is the patch that gates
mtk_wed_free_ring() on MTK_WED_RING_CONFIGURED.

First, mtk_wed_free_rx_rings() walks dev->rx_ring[] but tests
dev->tx_ring[i].flags before calling mtk_wed_free_ring() on
dev->rx_ring[i]. That looks like a copy/paste slip. If tx_ring[i] was
never configured, an allocated rx_ring[i] is never freed. Should that
be dev->rx_ring[i].flags?

Second, mtk_wed_tx_ring_setup() and mtk_wed_rx_ring_setup() call
mtk_wed_ring_alloc() first. They then call
mtk_wed_wdma_rx_ring_setup() or mtk_wed_wdma_tx_ring_setup(). If the
wdma step fails, they return -ENOMEM before MTK_WED_RING_CONFIGURED
is set on the ring that was already allocated.

Once the free paths only call mtk_wed_free_ring() for rings with
MTK_WED_RING_CONFIGURED set, __mtk_wed_detach() skips those partially
set up rings. Their coherent DMA descriptor memory is then leaked.
Before this series, mtk_wed_free_ring() keyed off ring->desc, which
handled this case.

I see two options:

 - Keep relying on the ring->desc check in mtk_wed_free_ring() for
   freeing, so the flag gating is not needed in the free paths.
 - Free the just-allocated ring on the error path in the setup
   functions.

The right choice depends on what the flag gating is meant to protect
against, so could you explain the intent there?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-wedfix-v5-0-8b02e78fd34f%40gmail.com
