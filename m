Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976C33EC801
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402051; cv=none; b=n7jO6r+yRv4c2TxUB2bGY/1VHJzOG34sqQJIzYaZeAvwv/aGHz1HWngGynH/gN9MFOx7geGDP79+b4doUiIAar5qjHrgmu5Wp6wDYD0CSgxHdglDQTKk/DEqRllvN0MwStSr7x2OiaMSFXKotHj2DyHGil0qcSrwDFf3wqBXoG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402051; c=relaxed/simple;
	bh=ijwt6bKm0KcVQM8inqcTM4t+JpBlRF08Bvl7LQdga70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGaSLhWWx+xmfn4vol/a/vHiBLstmorp0VIUKiCveNXiN36aU9OuIgLejdhVOy3D6LjimOvBUlwpLcVXIXiR931xVgHNNBQ/o6GVvJabCgnPhe4MxAQkQuXNwifAyBtPJeMaXiDrpteyLfsEUj6CZZVrgAGYuZ57jMu2sSNyhmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7qNZ3XQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7qNZ3XQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785402048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7D+xutFpqSSg5uUi8QN36v5qhOBFCRAD67A2wtKPrg=;
	b=N7qNZ3XQrYfPCWK5hxrg38EhBGqnchhuNtcu7mpuspcwxg8kpdHbaYeuVG4YSbUM7u8tsd
	IXhissh9VHkFrWK/6hAxGlyrcme2cpHXkOiWsyWMwioPi0rC1oojzo698BDK2t8fSsDNoo
	Z+U3l36UXXbn1qqj21382AcmmDICdng=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-jFgMNW4qN6eqwqljLpwPDQ-1; Thu,
 30 Jul 2026 05:00:43 -0400
X-MC-Unique: jFgMNW4qN6eqwqljLpwPDQ-1
X-Mimecast-MFC-AGG-ID: jFgMNW4qN6eqwqljLpwPDQ_1785402041
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 963F51800350;
	Thu, 30 Jul 2026 09:00:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.174])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 347DC30002E9;
	Thu, 30 Jul 2026 09:00:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: hujy652@gmail.com
Cc: nbd@nbd.name,
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
Subject: Re: [PATCH net v3 2/2] net:ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986
Date: Thu, 30 Jul 2026 11:00:30 +0200
Message-ID: <20260730090030.201100-1-pabeni@redhat.com>
In-Reply-To: <20260724172040.1653-2-hujy652@gmail.com>
References: <20260724172040.1653-2-hujy652@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
--- Patch [2]: [PATCH net v3 2/2] net:ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986 ---
commit 30cd2d1bc8bf876e5d201d631684431920a3f165
Author: Zhi-Jun You <hujy652@gmail.com>

net:ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986

This commit fixes an issue on non-DBDC MT7986 where WDMA_RING_TX(0) is
never set up because idx is 1, even though it is required for WED RX to
function. It addresses this by explicitly calling mtk_wed_wdma_tx_ring_setup
if the WED version is v2 and rx_ring[0] is unallocated.

Link: https://lore.kernel.org/r/20260711112128.971-1-hujy652@gmail.com
Link: https://lore.kernel.org/r/20260630144831.1109-1-hujy652@gmail.com

> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
> --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
[ ... ]
> @@ -2334,6 +2334,13 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
>  		if (!dev->rx_wdma[i].desc)
>  			mtk_wed_wdma_rx_ring_setup(dev, i, 16, false);

[Severity: High]
This is a pre-existing issue, but does this code ignore the return value
from mtk_wed_wdma_rx_ring_setup()? 

If mtk_wed_ring_alloc() fails due to memory pressure, it returns an error
without configuring the hardware base registers. Because the error is
ignored, when DMA is later enabled in mtk_wed_start(), could the hardware
attempt to fetch from unmapped physical addresses and cause an IOMMU fault?

>  
> +	/*
> +	 * non-DBDC MT7986 allocates only rx_ring[1] and tx_wdma[1] during setup
> +	 * but tx_wdma[0] is also needed for WED to function.
> +	 */
> +	if (mtk_wed_is_v2(dev->hw) && !dev->rx_ring[0].desc)
> +		mtk_wed_wdma_tx_ring_setup(dev, 0, MTK_WED_WDMA_RING_SIZE, !!dev->tx_wdma[0].desc);

[Severity: High]
Does this new call to mtk_wed_wdma_tx_ring_setup() also need to check its
return value? 

Similar to the RX ring above, if mtk_wed_ring_alloc() fails to allocate
memory, the hardware base registers won't be configured. Since the caller
proceeds to enable hardware DMA regardless, might this lead to the WED
processing descriptors from unmapped memory and causing memory corruption
or a system crash?

> +
>  	if (dev->wlan.hw_rro) {
>  		for (i = 0; i < MTK_WED_RX_PAGE_QUEUES; i++) {
-- 
This is an AI-generated review.

