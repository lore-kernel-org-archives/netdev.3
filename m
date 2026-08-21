Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4BF38399E;
	Fri, 21 Aug 2026 05:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291707; cv=none; b=jcYgfpLroAf3vNoc97+Xgru0ghiKt9JHuQ+3SUFqAYsjBooXa+0caFltbjnQ54WWjZ1aYYSvWUrqSsqSUQ6hbtFbD+ExcY7p9/WerV5XX4VTs+HOCHO9s+Fe9rXvaHMcPkalGqjdTB03NqKBehN18IBsNUaB3Uw4GRBCAvQYB5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291707; c=relaxed/simple;
	bh=+80evn1FmyOQJoH2c/YgqrkQaOcsU397yIL1IyjGbxw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CDnLUC0gJEFdqU2fQMzM39c1NajuUX1pgixFpSna96rcJiMh0DPy0slTkopaIEIQhwu7FpwIeqzRCA3ZaJDlAXOtGtXSkjH6mBNEc7q+L44YyQaYpZc38XruQRSchRQBgfRRw9HIWrfY3s8QjVRy5F4PRyw2DTTMXqVm5fMtS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Fp5Jpbji; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Fp5Jpbji"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L5WEJo3794732;
	Thu, 20 Aug 2026 22:54:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=4tCcaWn1kVbKCxqClph9/fp
	eB0HQCekLshW8SgwMgl8=; b=Fp5JpbjiecLyhBpoGHtD+7LAVjPlM7ydPaqlmUK
	6Ro1S/v+HybRFuFjzyU1zP4e5n4KaKGatRRFtcLsODu87zUQVAXFqZytRqGAojgM
	MCgKQSX9ghm7NmMuxcrwkoSpsDX4qgdFc6vdnBQL5BWdT2wlcgwT99GyBUPcQwuf
	MQR1MtRG+4Xw90mNarWpPcW2dEhzKEqusIKG0oty+G5bJOuTgrHZXcqfLIvy9a+B
	U/Jx3D37W+7V4YQkoiQ6DeTRVaX+XBnKA7N6ni8LorwaSxCqx0xYM7MXk+5l1NHK
	pIPZRiT2k/S7F7Vb8fcN/r3m6q7Y7wFIzov7rIQ4PJGQ2JQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g6ccdrmx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 22:54:53 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 20 Aug 2026 22:54:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 20 Aug 2026 22:54:52 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 33B5D3F7090;
	Thu, 20 Aug 2026 22:54:47 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Naveen Mamindlapalli <naveenm@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] octeontx2-af: Fix TL3/TL2 link config ENA clearing
Date: Fri, 21 Aug 2026 11:24:45 +0530
Message-ID: <20260821055445.2517568-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: yyfKs5s-BamJqj4MZRbMFeghyDizH-CP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDAzOSBTYWx0ZWRfX4LzxLyOnem3e
 TLWG4Lo9UmLznTvlGvTmOi7pTaNYoignc4Rj96Pr0M7CQwWjuyAcLUsgDiqA09d9Srf9J943ATQ
 5r/O/DzuNB3TwTs+hgYNZsv3ZQ7l2K9TDqt+ACppsiAtApuLYfhUrVfAtd9t9uEg9Teaf4AK5sY
 V6eWH7DIUuAcrNji81YLnWeKJKhtUbPObwJ6Dv8jmctHe9BNwtb7F+RqBOLqHuMhH0LYoNGaHXR
 E3oFzvNhTlWDOMtPnosphl1stWwTLe9rlTQHo/UNQ9aAt1YPSI5rBTMlOuM7gV2meifxGWzqPdK
 v9nzaso8OurewcdFOAwxjtcgp6eW1RMBua4twhmkuundA6LRZOQnIfv5w1u/7K+JNuKlp+Uwv3A
 88Qt6apLxHlWLrs1X0mSJysW2fjVsY0yiXLKQc2ri0w+rbISuYHlvKTGhUDNwmRVjvpvB1c5FZb
 ig1hXY7Lkx11H8eqsew==
X-Proofpoint-ORIG-GUID: yyfKs5s-BamJqj4MZRbMFeghyDizH-CP
X-Authority-Analysis: v=2.4 cv=Nu7htcdJ c=1 sm=1 tr=0 ts=6a87e82d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=XNy1rerU-O3ekx9n268A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDAzOSBTYWx0ZWRfX/QbIJeZoCDHg
 W2jSf193EFfQJ6MCW2kUcOMOFZEDNrqx2Hs4jM01/nRoe68yvbXEbaWlVpXc1phGBCJGEUdL4Jc
 vIboJvWJHgJAufY6/Nm1Hn/3SIqQCJo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-20_02,2025-10-01_01

From: Naveen Mamindlapalli <naveenm@marvell.com>

Clear and restore the ENA bit for each TL3/TL2 link entry during
SMQ flush instead of repeatedly using the same link index.

Fixes: 019aba04f08c ("octeontx2-af: Modify SMQ flush sequence to drop packets")
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 964bcaae098e..7f100bdf23a4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -2483,7 +2483,7 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 	int pf = rvu_get_pf(rvu->pdev, pcifunc);
 	u8 cgx_id = 0, lmac_id = 0;
 	u16 tl2_tl3_link_schq;
-	u8 link, link_level;
+	u8 link_level;
 	u64 cfg, bmap = 0;
 
 	if (!is_rvu_otx2(rvu)) {
@@ -2516,7 +2516,6 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 	link_level = rvu_read64(rvu, blkaddr, NIX_AF_PSE_CHANNEL_LEVEL) & 0x01 ?
 			NIX_TXSCH_LVL_TL3 : NIX_TXSCH_LVL_TL2;
 	tl2_tl3_link_schq = smq_flush_ctx->smq_tree_ctx[link_level].schq;
-	link = smq_flush_ctx->smq_tree_ctx[NIX_TXSCH_LVL_TL1].schq;
 
 	/* SMQ set enqueue xoff */
 	cfg = rvu_read64(rvu, blkaddr, NIX_AF_SMQX_CFG(smq));
@@ -2526,13 +2525,13 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 	/* Clear all NIX_AF_TL3_TL2_LINK_CFG[ENA] for the TL3/TL2 queue */
 	for (i = 0; i < (rvu->hw->cgx_links + rvu->hw->lbk_links); i++) {
 		cfg = rvu_read64(rvu, blkaddr,
-				 NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link));
+				 NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, i));
 		if (!(cfg & BIT_ULL(12)))
 			continue;
 		bmap |= BIT_ULL(i);
 		cfg &= ~BIT_ULL(12);
 		rvu_write64(rvu, blkaddr,
-			    NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link), cfg);
+			    NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, i), cfg);
 	}
 
 	/* Do SMQ flush and set enqueue xoff */
@@ -2553,10 +2552,10 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 		if (!(bmap & BIT_ULL(i)))
 			continue;
 		cfg = rvu_read64(rvu, blkaddr,
-				 NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link));
+				 NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, i));
 		cfg |= BIT_ULL(12);
 		rvu_write64(rvu, blkaddr,
-			    NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link), cfg);
+			    NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, i), cfg);
 	}
 
 	/* clear XOFF on TL2s */
-- 
2.48.1

