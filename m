Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864F254DACC
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084826; cv=none; b=WVs0OunC6KMs8x6yrOreD662STOsIoERRuSQEqO4HxH5zf41ppMdURUt/nfVBg5f6nHrq8XgOgreuLY67eN3mkqMEOyflxKXgOKX+NAlPU7IYVssMsCDG1jBD+O0xb6CPITv8p8NxkRvNG+Qj21s2Sr9otIUr34/ABewx0xdJJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084826; c=relaxed/simple;
	bh=/WV6UcnYJb59+aISOqYnJ6c8jl3+NFWBfdwZyU/KRWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=Yhfikeljv33RIZEH9ei820Y03maOUElLBCiH1n9W9H3VI0f75o/HUlp3d8k739HDeuB6YGN4gihPOQnl+6SzZRLET8P9oJXSk5FvPtAOLnLLFfsgB7NsuQ5URqrzze7HwfHYndNOjdaq16J1bEPS/R06f9yjnAXNHI5J3O5P3Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0t8ElE1; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0t8ElE1"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc433d52421so2482418a12.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790084824; x=1790689624; darn=vger.kernel.org;
        h=content-transfer-encoding:lines:status:content-disposition
         :content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rf3NcYvAmItVxbqtkxxzSpUPurh9H42FsWoY744N9zk=;
        b=D0t8ElE1PtDL708QOVh3ERdEGhjujno5L+rRCINOI/IgqxswUwQz5W36uPgHqQvDdm
         cIT0joE/ArPAXHZafNvl2L51AVZT5KZsHx+W3mBy3yM6baezxTCPbyFD6EINOILIQSFh
         9kVsdJs+RaQsLjyMQa0bJt0trsCpeKSD51qlJAi43wmuOEIJT2o+MHQyWerr42wPxJ0t
         VSGh/YHY0sSBGOJwnmVg9nsN/+UXNoAcLE76WcofZu8ef0ewWrdt/1cpDGIIRF0QiIke
         xKs/YGgYLabz9Jrsn31z5FIneQnzoobyHPYe6pLCOzlYgNPP5/Qalmsu3nnxtc6m/z1l
         Zz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790084824; x=1790689624;
        h=content-transfer-encoding:lines:status:content-disposition
         :content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rf3NcYvAmItVxbqtkxxzSpUPurh9H42FsWoY744N9zk=;
        b=LkyVKl/GZoW712A4UMBnR+oQxUu5xKdM2k0BMQ8TUeWvTO9LL42G280B0cHiAS0Boj
         8xW8T1gB1MXAIM+XPl2ZJ1lppxTNuF1plAM00+nV/P7qWIasxNwNadzBmQIrKIyAA+9Z
         iOjVyIjVx3IXx+V9Ih45X1PnA4AvJeZNIw5UCJlcF2SYlUk+d/GobnOOmdLz0IzN0k07
         VqPNIOlNmeZ0Bfh5miAHQsKqT3QBNMAr/BYsVKh5azZ9nhFUKeo1YsQK+Ddup4RZvXGI
         l8EOnTY+mB1r6Ba/eJhrYS+4+wHyYRpL0wNZP9HILQxSkZPcqH75RdDBdT+o1JtfTOc5
         HTYg==
X-Forwarded-Encrypted: i=1; AKwUvByxPS3ZTbt9WJ9tyIQdn3Wnua86e8A1TOPIvpveG3XqMpOtQXgtcja2D88FIGWVxLmVvh/o1VM=@vger.kernel.org
X-Gm-Message-State: AFuF++kDBM9B0yhhhrEGnmLmkcoiKr/lB1gQKly2vhFP1dEFyjFE/RFz
	Oly8XMwxPsU8eMXm/WGNo5UdFA2KjwQCV7izTF5vr5+sv4n9GgScHXeW
X-Gm-Gg: AYBFou0ior9iRGlA91XkNwFB+tR8dmMuCZHqEBQIL64E6Er7tcRRU7J10jKu9zuG9dT
	6gOBZ0j0Tib/PQ6bKG4v8pCfyfXyWk96NiPVAZWyEqFAgr43XK/gbMRkrorKErpq4fR7S7kK2oq
	vYLmPxfphsIWZYmeVm/hogCR3zSp3gHb8EuyFxlV09bZ79g8FEFam7zfRvD90KcTvcQWO2Bmu8L
	5L5ug1PJPJyFDF+gS1Ef2wNVSMU3iJIyD9VtNITfXyuRDiatsXKx24Wo47lGx/xFEDHd4JbH1jg
	vE9UGjsSPzfaunDcg95aYb3RY+Z8bNF4y4uukBHDBmFy8xvpWJ6mOdfByvM86q/ssnvgl5NJFp+
	I6LOwp1dElZFk+MWbMUh9vwTbI+QWYqwZX3XuECFgeDqPUqobESkyVkrLyaZyPO/RnoWz6wlrJM
	bJSt3dii3JQ/CS7jgwBsWpMrr+IS13pGc/IFYg6urxk5xtqjje1BNBLAbCR7RhBlTZXvDMBql/y
	AZMtaw07VqgqqjdQI7y3eZw3Ibk8MByS+z96ns=
X-Received: by 2002:a17:90b:35cb:b0:39e:6c69:f479 with SMTP id 98e67ed59e1d1-3a073262d85mr1337283a91.56.1790084823601;
        Tue, 22 Sep 2026 06:47:03 -0700 (PDT)
Received: from DESKTOP-VNSSJ2S.lan (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06caf4a73sm1381225a91.2.2026.09.22.06.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 06:47:03 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Rex.Lu@mediatek.com,
	andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com,
	davem@davemloft.net,
	edumazet@google.com,
	hujy652@gmail.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	lorenzo@kernel.org,
	matthias.bgg@gmail.com,
	nbd@nbd.name,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sujuan.chen@mediatek.com
Subject: Re: [PATCH net v4 3/3] net: ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986
Date: Tue, 22 Sep 2026 21:46:04 +0800
Message-ID: <20260922134604.617-1-hujy652@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179000700034.2160803.10594281691384015089@kernel.org>
References: <20260917144335.19466-3-hujy652@gmail.com> <179000700034.2160803.10594281691384015089@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=v4reply
X-Mutt-References: <179000700034.2160803.10594281691384015089@kernel.org>
X-Mutt-Fcc: ~/sent
Content-Transfer-Encoding: 8bit

On Mon, Sep 21, 2026 at 04:10:00PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In mtk_wed_start()
>   (drivers/net/ethernet/mediatek/mtk_wed.c:2346-2347) the newly added…
> 
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but the patch
>   widens it: dev->tx_wdma[] descriptor rings are allocated with…
> 
> --
> 
> net: ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986
> 
> On a non-DBDC MT7986 only rx_ring[1]/tx_wdma[1] get set up, so
> WDMA_RING_TX(0) is never programmed even though WED needs it for RX
> offload.  The patch adds a call to mtk_wed_wdma_tx_ring_setup() for ring 0
> from mtk_wed_start() when the device is WED v2 and rx_ring[0] was not
> allocated, passing reset=true when tx_wdma[0] already exists.
> 
> > diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
> > index 3f0be70c3f145..3800e602d3c48 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> > @@ -2339,6 +2339,13 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
> >  		if (!dev->rx_wdma[i].desc)
> >  			mtk_wed_wdma_rx_ring_setup(dev, i, 16, false);
> >  
> > +	/*
> > +	 * non-DBDC MT7986 allocates only rx_ring[1] and tx_wdma[1] during setup
> > +	 * but tx_wdma[0] is also needed for WED to function.
> > +	 */
> > +	if (mtk_wed_is_v2(dev->hw) && !dev->rx_ring[0].desc)
> > +		mtk_wed_wdma_tx_ring_setup(dev, 0, MTK_WED_WDMA_RING_SIZE, !!dev->tx_wdma[0].desc);
> 
> [Severity: Medium]
> Should the return value of mtk_wed_wdma_tx_ring_setup() be checked here?
> 
> On the first start of a non-DBDC v2 device dev->tx_wdma[0].desc is NULL, so
> reset is false and the helper takes the allocation path:
> 
> drivers/net/ethernet/mediatek/mtk_wed.c:mtk_wed_wdma_tx_ring_setup() {
> 	wdma = &dev->tx_wdma[idx];
> 	if (!reset && mtk_wed_ring_alloc(dev, wdma, MTK_WED_WDMA_RING_SIZE,
> 					 dev->hw->soc->wdma_desc_size, true))
> 		return -ENOMEM;
> 	...
> }
> 
> mtk_wed_ring_alloc() does a dma_alloc_coherent() of
> MTK_WED_WDMA_RING_SIZE * wdma_desc_size (32 KiB on MT7986), and on failure
> the helper returns before writing MTK_WDMA_RING_TX(0) BASE/COUNT/CPU_IDX/
> DMA_IDX and before the "if (!idx)" block that programs the WED side
> MTK_WED_WDMA_RING_TX window.
> 
> Since the status is dropped, mtk_wed_start() keeps going through
> mtk_wed_hw_init(), mtk_wed_configure_irq() and mtk_wed_dma_enable(), which
> arms MTK_WDMA_GLO_CFG_TX_DMA_EN and, for rx-capable v2,
> MTK_WED_WDMA_GLO_CFG_TX_DRV_EN | MTK_WED_WDMA_GLO_CFG_TX_DDONE_CHK, and
> then sets dev->running = true.  Can the hardware then fetch descriptors
> from a ring whose base register was left at 0 by the preceding
> mtk_wdma_tx_reset()/mtk_wed_reset(), leaving the WED offload silently
> non-functional with no message?
> 
> The other caller of the same helper propagates the failure:
> 
> drivers/net/ethernet/mediatek/mtk_wed.c:mtk_wed_rx_ring_setup() {
> 	if (mtk_wed_wdma_tx_ring_setup(dev, idx, MTK_WED_WDMA_RING_SIZE,
> 				       reset))
> 		return -ENOMEM;
> 	...
> }
> 
> and mtk_wed_start() itself already bails out on mtk_wed_rx_buffer_alloc()
> and mtk_wed_rro_cfg() failures.  Since mtk_wed_ops.start is void and
> mt7915_dma_start() cannot observe the error, would it make sense to abort
> the start sequence locally here (skipping mtk_wed_dma_enable() and
> dev->running = true) and log the failure?

ACK I will add error messages and return when there's an error.

> 
> [Severity: Medium]
> This isn't a problem introduced by this patch, but does this new call add
> another leak of dev->tx_wdma[0]?
> 
> dev->tx_wdma[] rings are allocated by mtk_wed_ring_alloc() via
> mtk_wed_wdma_tx_ring_setup(), but the ring-release helpers never free that
> array:
> 
> drivers/net/ethernet/mediatek/mtk_wed.c:mtk_wed_free_tx_rings() {
> 	for (i = 0; i < ARRAY_SIZE(dev->tx_ring); i++)
> 		mtk_wed_free_ring(dev, &dev->tx_ring[i]);
> 	for (i = 0; i < ARRAY_SIZE(dev->rx_wdma); i++)
> 		mtk_wed_free_ring(dev, &dev->rx_wdma[i]);
> }
> 
> drivers/net/ethernet/mediatek/mtk_wed.c:mtk_wed_free_rx_rings() {
> 	mtk_wed_free_rx_buffer(dev);
> 	mtk_wed_free_ring(dev, &dev->rro.ring);
> }
> 
> __mtk_wed_detach() calls those helpers and then does
> memset(dev, 0, sizeof(*dev)), so tx_wdma[].desc/desc_phys are discarded and
> the 32 KiB coherent allocation can no longer be released.
> 
> The existing allocation site is mtk_wed_rx_ring_setup(), so the omission
> predates this change, but non-DBDC MT7986/MT7981 previously never allocated
> tx_wdma[0] at all, and now every attach/start/detach cycle would leak one
> more ring.  Would adding dev->tx_wdma[] to mtk_wed_free_tx_rings() be the
> right way to restore alloc/free symmetry?
> 

There is a patch in MediaTek SDK fixing this exact issue.
I will pull the patch from there.

Link:https://github.com/mediatek/mtk-openwrt-feeds/blob/main/25.12/files/target/linux/mediatek/patches-6.12/999-wed-04-Fix-reinsert-wifi-module-cause-memory-leak-issue.patch

Best regards,
Zhi-Jun

pw-bot: cr
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917144335.19466-1-hujy652%40gmail.com
> 

