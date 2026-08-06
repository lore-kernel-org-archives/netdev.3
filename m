Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B8E48424F
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031700; cv=none; b=kKPDxLT/rasKUut3GViOfwvRLXtaTkrjvYm35W8UZd5gJp0w6QOb8bStzAvCMYXXJ8mXE8klt0OdvDVSH+1EMif+2mSAjAmXjmzSg5T1xPPH+pJt995xNrUh7RQUz30xpIvXv8YHIPVb5IeGFAsinueCykN3gotOJ2kid06S/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031700; c=relaxed/simple;
	bh=YMrJHqplVwx2kC/JKXO/7KKnLxRXDy7VoJSh3QW+AfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=owj3RkBzgMSry3N8u3jMjqNsC5nrIFsy73Q3YZ+Gp+tPg0A7kLNOvlirzDsPrXlg4VcF0xzIEUTCoxLnDrBC3SYPXJZO0UZM69UZTZsjBb72XUgMMvHMaz8g0sNVsWtvG+jyaxTBu5G3UL32A7ITZyBN8H2oOUobXI3OTRtB6EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8TVrLPm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8TVrLPm"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d004f135b1so29343915ad.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 08:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786031690; x=1786636490; darn=vger.kernel.org;
        h=content-transfer-encoding:lines:status:content-disposition
         :content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87/H9EMlwH5MQtLg4YoCYwZZh62cqUzZ27PH8DCBgO4=;
        b=k8TVrLPmFzqy4CSP6J69MD9Jlb5vi0Un8F3KTYID8US4/GAxdvEdBAhnN4dE5fUNOC
         ijrWq8k8Ot6+TIheLBVax4hy/nyrD+ag0OG/PCxhW6XUeSqUNxFy9GNljK3VmZMn7Pya
         hs2OPzeeA5pjzGYq7i11UfOz1T2Y0hZ5bVNnuujF+5YnKEvIkAPWOXDpGIaar8+lJy57
         pLww31FacbC1dVy9UcnEy7AgR/X+m5s5zWhtjDbmALj1aZxnx/5wp+g+SHIYBV7Nk65z
         jTqsGO8s+mTYeu+y3De5yy6hqkK8utOAXkj5YEFv+9VgACaXs7jkZ8AXXi0qVgyJXrsi
         fnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786031690; x=1786636490;
        h=content-transfer-encoding:lines:status:content-disposition
         :content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=87/H9EMlwH5MQtLg4YoCYwZZh62cqUzZ27PH8DCBgO4=;
        b=E7pfcZuwgXwqBgF4qhZWdGSWiVPt3mw3SjGNoghZZpKCK78ynoGopmGU8kajMoa8sS
         ZYdpTIFmTP/ZjG8SZXXwtomBg7JGHHp7fOWQ580PQIo56SZ7SbCCFGdqHInuVZoNgW4d
         7X3vX/9k3uQ1It8n7/FGcyt5aUzFZOJb9kiOmuvJCFoMKsMY4hJUS9y+wQAofOmuNhMX
         PrUf8T2fZmZcVUWawALpv0zCvgsXU6hMT6MxxzGLLHRv7Lb6DPMVrJ3dD321JxAj7ILP
         hAbhrCi1BQec4fLZo+lMGmcULMAmMctyUNyBk0Z3ytxydlS3vQ3Gd4ePsm5UHRqiXc3i
         P5LA==
X-Forwarded-Encrypted: i=1; AHgh+RrSgDfRl6uDxBfUghgukxa3szYBNrT8BbmUehpZgYX672lPWIaRrO5DACF/7xmXZYJQ1aI8pBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YziR7glTCGrGgq9yT2DXa61RIv9DpxYmmHjva9OlUmQXyVQE1tD
	l+bhnr/6wI4yv2tNKyVRjTym3dXJFZAFOaJ9xktb8mEZsxYnqBq1sy+j
X-Gm-Gg: AR+sD12B1vGldMcTf6ZxDvacipV9rYu0GbPrCT7+xaKEW66S/myY5x514+0YELxO2ei
	Xru1dA/VxE+YNadKv65oF8HRxu9s1eTbhIq0N+htgrOIddNNjl2QVHdxcX6lAXMhD58ydATEl32
	nc4d8V0JiebiaeAbwDAsVjhKvDgMXi2kHObIGrzufSngbtqW1q124XoR4W+Jk2+ls8DNBJaCph7
	XJtVmCXqYFnOFaEWu6tQ5vzaARt2UFzpEH0/cgeiG1ZnaFXJe3ZnQxAzBW8B2bd86gG2S+y+kdV
	FlrT1yBrZKQ747grLtxzJLGQaD2kZN7lx39mm1UWpFefxsGczj97INHkzZaOyqPcTV9xjp2uwrw
	mQFhgLtD+bzkkS/Gz9NxNVpxU3GnQNTL6MtWMjR0nEAB2utJDP49PgL9mKj5Ie/Tb3zM006N/B1
	AZfgwvRUUmPbREl09i/+/P8UGqq/hsMtG/4XMlQEIAqdGLUsICdkcp7Z0KylROVVapjA4QJwDNh
	iAjtUd/TLh+H2jo2+r14WmODWP5wA==
X-Received: by 2002:a17:903:4688:b0:2cc:f5aa:9513 with SMTP id d9443c01a7336-2d0ca7fbc9amr204312735ad.10.1786031689896;
        Thu, 06 Aug 2026 08:54:49 -0700 (PDT)
Received: from DESKTOP-VNSSJ2S.lan (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4c94d4sm33717415ad.65.2026.08.06.08.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 08:54:49 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
To: pabeni@redhat.com
Cc: andrew+netdev@lunn.ch,
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
	sujuan.chen@mediatek.com
Subject: Re: [PATCH net v3 2/2] net:ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986
Date: Thu,  6 Aug 2026 23:54:30 +0800
Message-ID: <20260806155430.768-1-hujy652@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260730090030.201100-1-pabeni@redhat.com>
References: <20260724172040.1653-2-hujy652@gmail.com> <20260730090030.201100-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-References: <20260730090030.201100-1-pabeni@redhat.com>
X-Mutt-Fcc: ~/sent
Content-Transfer-Encoding: 8bit

On Thu, Jul 30, 2026 at 11:00:30AM +0200, Paolo Abeni wrote:
> From: AI Reviewer <ai@example.com>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/
> ---
> --- Patch [2]: [PATCH net v3 2/2] net:ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986 ---
> commit 30cd2d1bc8bf876e5d201d631684431920a3f165
> Author: Zhi-Jun You <hujy652@gmail.com>
> 
> net:ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986
> 
> This commit fixes an issue on non-DBDC MT7986 where WDMA_RING_TX(0) is
> never set up because idx is 1, even though it is required for WED RX to
> function. It addresses this by explicitly calling mtk_wed_wdma_tx_ring_setup
> if the WED version is v2 and rx_ring[0] is unallocated.
> 
> Link: https://lore.kernel.org/r/20260711112128.971-1-hujy652@gmail.com
> Link: https://lore.kernel.org/r/20260630144831.1109-1-hujy652@gmail.com
> 
> > diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
> > --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> [ ... ]
> > @@ -2334,6 +2334,13 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
> >  		if (!dev->rx_wdma[i].desc)
> >  			mtk_wed_wdma_rx_ring_setup(dev, i, 16, false);
> 
> [Severity: High]
> This is a pre-existing issue, but does this code ignore the return value
> from mtk_wed_wdma_rx_ring_setup()? 
> 
> If mtk_wed_ring_alloc() fails due to memory pressure, it returns an error
> without configuring the hardware base registers. Because the error is
> ignored, when DMA is later enabled in mtk_wed_start(), could the hardware
> attempt to fetch from unmapped physical addresses and cause an IOMMU fault?
> 
> >  
> > +	/*
> > +	 * non-DBDC MT7986 allocates only rx_ring[1] and tx_wdma[1] during setup
> > +	 * but tx_wdma[0] is also needed for WED to function.
> > +	 */
> > +	if (mtk_wed_is_v2(dev->hw) && !dev->rx_ring[0].desc)
> > +		mtk_wed_wdma_tx_ring_setup(dev, 0, MTK_WED_WDMA_RING_SIZE, !!dev->tx_wdma[0].desc);
> 
> [Severity: High]
> Does this new call to mtk_wed_wdma_tx_ring_setup() also need to check its
> return value? 
> 
> Similar to the RX ring above, if mtk_wed_ring_alloc() fails to allocate
> memory, the hardware base registers won't be configured. Since the caller
> proceeds to enable hardware DMA regardless, might this lead to the WED
> processing descriptors from unmapped memory and causing memory corruption
> or a system crash?
> 

I am not sure how to proceed with this.

Can Felix or Lorenzo comment this?

Best regards,
Zhi-Jun

> > +
> >  	if (dev->wlan.hw_rro) {
> >  		for (i = 0; i < MTK_WED_RX_PAGE_QUEUES; i++) {
> -- 
> This is an AI-generated review.
> 

