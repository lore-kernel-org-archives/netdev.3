Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E403353EF7
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772256; cv=none; b=fcijDxzxb4LLlOidukZu5bADqYQA1C3/KW4YByPJ80cqvivj8AW19ehU7vE1hd0gtG1QulNRMjJ/3YH/0P0tTZln6511JE67asg5NT2wxe41Y7NAB0EMolz6nG46j1kirafUC82SHzvrVUerDOvGZWLggCLIGJbS69IaaoLpRAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772256; c=relaxed/simple;
	bh=e9b8RBrfW+lTefYIZ1ahNWqlMpdaZ7PH/7L4D03Bsss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=SChcnf6286kbc2Ne69zM6f0XlXdYPzkt+4OwxF7VFsPda+oZWMVxYpjwqx7wU0P33DmpaXchy5FB0XEiIp6byX+zTpJoDMSRcj7KyXKmBR+x96a/WR2eiU6sG2lvqL6GDAgMoVdUalBc2Pd+qIEDRsBmgz8b5xw4h9uencoGmpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OXRIxigN; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OXRIxigN"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260421115052euoutp021dcec36fe1e04ae86b7739aa1a79377b~oXPMsNcc33202332023euoutp02L
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:50:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260421115052euoutp021dcec36fe1e04ae86b7739aa1a79377b~oXPMsNcc33202332023euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776772252;
	bh=Wdm3kV4WDvCDxi2Q1eh8TQdGmwSJyWv03shz+xr93NA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=OXRIxigNRGwkHnJiEZ1USlGtyC22qjDAtNpf+a0Ge/z/2SbHAFLKXO3BdBaS2e703
	 YTpSTUwAlx93ngfJ+caYX8rDuOVftYXVl3wRjJMThlON7ULwiDGahtVcDJHx77wCeW
	 vICmQnjG9MlVkJym6OCqB9HE3SEvJ8eDZ2HngkZM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260421115052eucas1p103281c5b25719a44c0875d6b0860bfa6~oXPMWi_xc0669206692eucas1p1S;
	Tue, 21 Apr 2026 11:50:52 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260421115051eusmtip10861a4b8207300cfdc8286dec4615f9e~oXPL4eC_W1849318493eusmtip1l;
	Tue, 21 Apr 2026 11:50:51 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	andrew+netdev@lunn.ch, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, Jakub Raczynski
	<j.raczynski@samsung.com>
Subject: [PATCH] net/stmmac: Fix typos: 'tx_undeflow_irq' ->
 'tx_underflow_irq'
Date: Tue, 21 Apr 2026 13:50:09 +0200
Message-Id: <20260421115008.2690541-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260421115052eucas1p103281c5b25719a44c0875d6b0860bfa6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260421115052eucas1p103281c5b25719a44c0875d6b0860bfa6
X-EPHeader: CA
X-CMS-RootMailID: 20260421115052eucas1p103281c5b25719a44c0875d6b0860bfa6
References: <CGME20260421115052eucas1p103281c5b25719a44c0875d6b0860bfa6@eucas1p1.samsung.com>

All references to tx_underflow_irq are misspelled as 'undeflow'. Fix them.

Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h         | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c    | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c      | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index d26e8a063022..e7da9964854d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -147,7 +147,7 @@ struct stmmac_extra_stats {
 	unsigned long rx_vlan;
 	unsigned long rx_split_hdr_pkt_n;
 	/* Tx/Rx IRQ error info */
-	unsigned long tx_undeflow_irq;
+	unsigned long tx_underflow_irq;
 	unsigned long tx_process_stopped_irq;
 	unsigned long tx_jabber_irq;
 	unsigned long rx_overflow_irq;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 815213223583..068c21f37c29 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -247,7 +247,7 @@ static int loongson_dwmac_dma_interrupt(struct stmmac_priv *priv,
 	if (unlikely(abnor_intr_status)) {
 		if (unlikely(intr_status & DMA_STATUS_UNF)) {
 			ret = tx_hard_error_bump_tc;
-			x->tx_undeflow_irq++;
+			x->tx_underflow_irq++;
 		}
 		if (unlikely(intr_status & DMA_STATUS_TJT))
 			x->tx_jabber_irq++;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index c01b86fd64da..a73720811791 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -459,7 +459,7 @@ static int sun8i_dwmac_dma_interrupt(struct stmmac_priv *priv,
 
 	if (v & EMAC_TX_UNDERFLOW_INT) {
 		ret |= tx_hard_error;
-		x->tx_undeflow_irq++;
+		x->tx_underflow_irq++;
 	}
 
 	if (v & EMAC_TX_EARLY_INT)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index a0383f9486c2..79fe50ad33d1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -182,7 +182,7 @@ int dwmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 	if (unlikely(intr_status & DMA_STATUS_AIS)) {
 		if (unlikely(intr_status & DMA_STATUS_UNF)) {
 			ret = tx_hard_error_bump_tc;
-			x->tx_undeflow_irq++;
+			x->tx_underflow_irq++;
 		}
 		if (unlikely(intr_status & DMA_STATUS_TJT))
 			x->tx_jabber_irq++;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index c1e26965d9b5..df092fb354ed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -78,7 +78,7 @@ static const struct stmmac_stats stmmac_gstrings_stats[] = {
 	STMMAC_STAT(rx_vlan),
 	STMMAC_STAT(rx_split_hdr_pkt_n),
 	/* Tx/Rx IRQ error info */
-	STMMAC_STAT(tx_undeflow_irq),
+	STMMAC_STAT(tx_underflow_irq),
 	STMMAC_STAT(tx_process_stopped_irq),
 	STMMAC_STAT(tx_jabber_irq),
 	STMMAC_STAT(rx_overflow_irq),
-- 
2.34.1

