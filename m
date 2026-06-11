Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6AC32E6BD
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177654; cv=none; b=f51DrNf+cw9Oft0lfUGlx2s5GGXziASgTkvlOktR4A8m9jfSLD8sy4H1+zHd0cDcrOQxlgF/2rorX/4fKhQnVPjGxsEoVXmonoiBKdXDPf6HtTIo4qYeKNK5uXZgIWh9BG22Xb75Ih37TqGoxdzZpBelDGP6a+HWssv/Vy1Wf2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177654; c=relaxed/simple;
	bh=MFNkG++ILJO1VB2TAolFq97usUaFhNl3TxM1icN10qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=MLRM0tnEZpCNCCpM20JBvabz1xLL1mHYfFuL67synZbBlMzKetOPXUrHoDZDJ+5psZWZ1cbOdxwIIiP8kEo7oBwQU1Gm0dLvrmcXnhfU/ry9ICsgty6mPRmnFGxwb8OZgF0GhSnGRRa3K2L8xT6nx7ciGnpwrfLvSuCKjAaZ86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NIdX8YmI; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NIdX8YmI"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260611113406euoutp013024693eb7db45bff9e4bfe9023b5cc0~4A6HMGjl_1538015380euoutp01K
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:34:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260611113406euoutp013024693eb7db45bff9e4bfe9023b5cc0~4A6HMGjl_1538015380euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781177646;
	bh=8g2s0jRme3xUJx8EMCMyxhTKGTJa++SGeLY0Z7juRnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NIdX8YmIUTHL+ezpixoL1bl7YKRn/YaajDk0go6pC7VhOlqrpWcphQpKyP+FXUIAE
	 06MvCu/06W9KhzauLXex68Y3eEowgx8y6EQMjP8GDYX6mf/7mSRH5DFuadtMEpy4l5
	 kvE3ZLQwiuGtsU+SdtFlqaVXPrTe65U/SuKrclRQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260611113405eucas1p1d1c8a7d26109ebb9e8073dd24cf0187c~4A6GxH_kk2472224722eucas1p1U;
	Thu, 11 Jun 2026 11:34:05 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260611113404eusmtip2579709418077f6c33db53653589f05f0~4A6Fu84SU3268332683eusmtip2D;
	Thu, 11 Jun 2026 11:34:04 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, k.domagalski@samsung.com,
	k.tegowski@samsung.com, Jakub Raczynski <j.raczynski@samsung.com>, Sashiko
	<sashiko-bot@kernel.org>
Subject: [PATCH net 2/2] net/stmmac: Apply MTL_MAX queue limit if config
 missing
Date: Thu, 11 Jun 2026 13:33:58 +0200
Message-Id: <20260611113358.3379518-3-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611113358.3379518-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260611113405eucas1p1d1c8a7d26109ebb9e8073dd24cf0187c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260611113405eucas1p1d1c8a7d26109ebb9e8073dd24cf0187c
X-EPHeader: CA
X-CMS-RootMailID: 20260611113405eucas1p1d1c8a7d26109ebb9e8073dd24cf0187c
References: <20260611113358.3379518-1-j.raczynski@samsung.com>
	<CGME20260611113405eucas1p1d1c8a7d26109ebb9e8073dd24cf0187c@eucas1p1.samsung.com>

When "snps,rx-queues-to-use" or "tx-queues-to-use" config in DTS is provided
current code will apply U8_MAX value for queues_to_use if there is input of
higher value. But actual maximum number of supported queues is set via
macro MTL_MAX_RX_QUEUES and MTL_MAX_TX_QUEUES, which currently have value of 8.

This value of U8_MAX will be capped to value provided by core in DMA
capabilities (dma_conf), but it does so only if core provides it.
This is true for XGMAC (dwxgmac2) and some GMAC (dwmac4),
but not for (dwmac1000). This capping is at later stage in stmmac_hw_init(),
and during stmmac_mtl_setup() we might parse fields outside allocated memory
if queues_to_use is over defines MTL_MAX_ values,
for example following rx_queues_cfg is array of size of MTL_MAX_RX_QUEUES.

Fix this by capping value to MTL_MAX during config parsing.

Fixes: 94808793fed71 ("net: stmmac: use u8 for ?x_queues_to_use and number_?x_queues")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 5cae2aa72906..dc5f951a311d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -156,8 +156,8 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 
 	/* Processing RX queues common config */
 	if (!of_property_read_u32(rx_node, "snps,rx-queues-to-use", &value)) {
-		if (value > U8_MAX)
-			value = U8_MAX;
+		if (value > MTL_MAX_RX_QUEUES)
+			value = MTL_MAX_RX_QUEUES;
 		plat->rx_queues_to_use = value;
 	}
 
@@ -210,8 +210,8 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 
 	/* Processing TX queues common config */
 	if (!of_property_read_u32(tx_node, "snps,tx-queues-to-use", &value)) {
-		if (value > U8_MAX)
-			value = U8_MAX;
+		if (value > MTL_MAX_TX_QUEUES)
+			value = MTL_MAX_TX_QUEUES;
 		plat->tx_queues_to_use = value;
 	}
 
-- 
2.34.1

