Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6443DA5E
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518475; cv=none; b=bXxy2qXuyLmmM40x7r7HLVXT7n3Jms+woV+bx/NzsbFebEn3YSJaV2NxN26HsN14qgfK3enZjxZ1NNJruAsxob28/luIzgibiMm5ImVfwRvJlsNIH1+I+h7YjjCcO+ns7+LfuCJ2iwXpvvpsOaRik7KJs5HsuPJR9y8eGfQq/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518475; c=relaxed/simple;
	bh=n4179BlTXbZg1lTfgcWIqzvKZKuWDfe5OP9CmHCK1Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=YjMrJyUTsWcrGv5+OzxODgGyrrj6Nhd/htrMZPMVlouNfhe/PFC2LjOl0MHVmX+ZY+5XJl5CkzeembJeZKhEQH69BnIr/XhlQdFNz6DWKZxrRXJMmJdiNp73Dm1ulLcsp6+qFY/elT4VzUArPPDOHO7Qn9FZ9Zn7g08YN6T4Ass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JgbOrZm4; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JgbOrZm4"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260511165432euoutp028d73d88463012cb8f2920c4c9c1034df~ukSCsDQ_O2270322703euoutp02d
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:54:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260511165432euoutp028d73d88463012cb8f2920c4c9c1034df~ukSCsDQ_O2270322703euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1778518472;
	bh=da/DjnI9tZGTa9NOBdQBCg0Fra8F1d+y89DrAoA5ByY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JgbOrZm4oZlQcUl062o2hzUc/GLg+YYhFvdUWQ35EyPVLVs3yveO8IeW+LQD4s2QX
	 Lg8MLb6GBXHu7iCevey1DNyyxKmaL7Olg50uon9y3ytke9QiNY1JKy7Zfr6KGThgT/
	 pOgJmeF00kXgW6QnXetBe53BQ6e+FKOdVqQtzRQ8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260511165431eucas1p28254403c5d4117b900dca4ca613bb532~ukSCAIUY13107631076eucas1p2e;
	Mon, 11 May 2026 16:54:31 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260511165431eusmtip1bd396eeaf036a77b6203fba2e08697e0~ukSBbLWp_2784027840eusmtip1E;
	Mon, 11 May 2026 16:54:30 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	k.domagalski@samsung.com, k.tegowski@samsung.com, Jakub Raczynski
	<j.raczynski@samsung.com>
Subject: [PATCH net-next 2/3] net/stmmac/dwxgmac: Extend MTL/DMA support to
 16 queues
Date: Mon, 11 May 2026 18:54:15 +0200
Message-Id: <20260511165416.3093015-3-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511165416.3093015-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260511165431eucas1p28254403c5d4117b900dca4ca613bb532
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260511165431eucas1p28254403c5d4117b900dca4ca613bb532
X-EPHeader: CA
X-CMS-RootMailID: 20260511165431eucas1p28254403c5d4117b900dca4ca613bb532
References: <20260511165416.3093015-1-j.raczynski@samsung.com>
	<CGME20260511165431eucas1p28254403c5d4117b900dca4ca613bb532@eucas1p2.samsung.com>

New datasheets for XGMAC (3.20a and 3.40a, depending on product) support up to
16 MTL/DMA queues. Before we increase max amount through macro,
prepare dwxgmac functions to handle that.

Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 ++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 24 +++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 51943705a2b0..bd333afe7e1b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -257,6 +257,8 @@
 #define XGMAC_MTL_INT_STATUS		0x00001020
 #define XGMAC_MTL_RXQ_DMA_MAP0		0x00001030
 #define XGMAC_MTL_RXQ_DMA_MAP1		0x00001034
+#define XGMAC_MTL_RXQ_DMA_MAP2		0x00001038
+#define XGMAC_MTL_RXQ_DMA_MAP3		0x0000103c
 #define XGMAC_QxMDMACH(x)		GENMASK((x) * 8 + 7, (x) * 8)
 #define XGMAC_QxMDMACH_SHIFT(x)		((x) * 8)
 #define XGMAC_QDDMACH			BIT(7)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 98b3e0cc84fa..76f8214a6e5b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -266,9 +266,29 @@ static void dwxgmac2_map_mtl_to_dma(struct mac_device_info *hw, u32 queue,
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value, reg;
 
-	reg = (queue < 4) ? XGMAC_MTL_RXQ_DMA_MAP0 : XGMAC_MTL_RXQ_DMA_MAP1;
-	if (queue >= 4)
+	switch (queue / 4) {
+	// queue 0 ~ 3
+	case 0:
+		reg = XGMAC_MTL_RXQ_DMA_MAP0;
+		break;
+	// queue 4 ~ 7
+	case 1:
+		reg = XGMAC_MTL_RXQ_DMA_MAP1;
 		queue -= 4;
+		break;
+	// queue 8 ~ 11
+	case 2:
+		reg = XGMAC_MTL_RXQ_DMA_MAP2;
+		queue -= 8;
+		break;
+	// queue 12 ~ 15
+	case 3:
+		reg = XGMAC_MTL_RXQ_DMA_MAP3;
+		queue -= 12;
+		break;
+	default:
+		return;
+	}
 
 	value = readl(ioaddr + reg);
 	value &= ~XGMAC_QxMDMACH(queue);
-- 
2.34.1

