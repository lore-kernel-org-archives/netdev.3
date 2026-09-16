Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2E353E0B;
	Wed, 16 Sep 2026 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789525300; cv=none; b=GapajTeieYY4MqhFQYBgkCvO7Er7R2L/+xmBOFy1kyccUpb2ihCrEJtrnGwHXL9VhhnG0h+joy/p16o49ubcUMUZSkCNrwZCfXlueNtA8ni7/lQET2cupovjHqZElstcwILgNWZordlXIstVld5QrNbkYGhTPL++5KTWJDlHl7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789525300; c=relaxed/simple;
	bh=iUvspt1cR7FJNAoPjQkq6ZimRx1IVGd1CvtYGyIOkVA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pb49/bd9q6KUsfgg6MLblOePh+BILVxz69XWiUchTXJft3EC0fIiY1UIuZI+zHlQuWBsuAkGkKxuHFWD1WbG6GWB+btRCK5KNdAJgeh4rySmCSd+T0ON/EMM3vfwu/TklmPXff2Id71caLWmb6xlSLpIkIq4d62EHm/QeK4z6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=flrFov5o; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="flrFov5o"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLZ4Z8472874;
	Tue, 15 Sep 2026 19:21:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ltw4RGtgj3eJZ4alyQ2JcmL
	xJKP7QsjNdQIHqtsFMiE=; b=flrFov5o3AobwqlzeyQwVJUeJiT1Sz52ER50CM/
	TpLA4IFQY70jQr0fQ5z1mN+fnyCtgofCbHfNTImt0cUVsd+gw4z6zDgBVXS61igT
	KtH7fYbCxNnKtH0kO808u7EXr39+dblqYVAlIfn5lWLBkpUbYdD8Jh2ysM5EzkYd
	ZkiCh1fOGScgZjC2R37xy+MHPMCoiogZzLUm9aRAZyxLo7KmTcXECxWxtNgm2EBb
	DFz28wr8LB9P74yjJeocQWaGYcUYFLYMxE2rv/zVq1EtSAgw6AUI0RvSNzm+X4BD
	bb1K66NyZ/YSB2tHbz8MPpNrosJGlZdKEtpAmacBGM/gD1g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gq5e4n4e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 19:21:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Sep 2026 19:21:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 15 Sep 2026 19:21:26 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id AEC323F7052;
	Tue, 15 Sep 2026 19:21:22 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <leon@kernel.org>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net] octeontx2-af: Fix memory scaling limitation in SR-IOV mode
Date: Wed, 16 Sep 2026 07:51:11 +0530
Message-ID: <20260916022111.1083017-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3T4jKNoaPDse7Q4qILxAR-G0VixW0hIz
X-Proofpoint-ORIG-GUID: 3T4jKNoaPDse7Q4qILxAR-G0VixW0hIz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDAzMCBTYWx0ZWRfX2XpFALOwielU
 hV2hBLN6KFI07mwDNc5DFTyKjcmnz+EkGUA2PEdJNGFUjmz94t98HMYIhuT4G79rBeIuIeDVyhg
 a3aNADvEObUOYcM589EWPcIgQqsfWPf29aaPKZEjawSHVlG14X6Z69IhI0l4EwWl4UhHuSefcm7
 vPrblPcTOq+yq2/s3cTI/o7W3VajLk2EedCUj3zVTwDYFObRb1fUZjXwfNm8rowN3MUcDCzUmN2
 ZW2Nbv0r0rP2eh/kpoW+MnD19t/kWvA8CmRbVhc1+zhoChJ61vHSh8UfiRTMDZoTR57MUl1ivhq
 7XF/eBlxff2ZmFZmy6BMnIA2ihD4UBtqn94m58b8kf+lAH3U/pZ7YSxMnNZrdUC7AOYPkDO2PYH
 TRQ0YyxTB71onOwoRp3iY5Z7N8yMk043D2p9ERqck4B7E0iOY4yYwD1nMTcYdg4fRB1iVrH0heE
 1RkocMTMTsr2caIFtqA==
X-Authority-Analysis: v=2.4 cv=N6W8hG9B c=1 sm=1 tr=0 ts=6aa9fd26 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=c92rfblmAAAA:8
 a=BO82YpIejP-UPoK7PFAA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDAzMCBTYWx0ZWRfX3m7jNV9nri2S
 vTMVoLDIieKWHcqPUO6TmXCPfgCc39bv6DcKjvpKTYguB+KK/Rnjn90F3R4Z4gqQ8AhNjMV3H76
 uy7VNNHpMgohqPTPJ6NF2xfim4RjYL4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01

The original code used DMA_ATTR_FORCE_CONTIGUOUS, which could exhaust
the CMA pool when a large number of VFs were requested.

Fix this by switching to the DMA streaming API. This is equivalent on
Octeon platforms, which provide full I/O coherency via the SMMU.

Cc: Leon Romanovsky <leon@kernel.org>
Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v9 -> v10: Updated commit message as suggested by Leon

v8 -> v9: Addressed Leon comment.
- Used kzalloc instead of kmalloc.

v7 -> v8: Addressed Leon comments.
- Replace __get_free_pages() and __GFP_COMP with kmalloc()
- Drop GFP_DMA32 retry loop and dma_capable()/phys_to_dma() mask probing
- Use dma_map_single()/dma_unmap_single() instead of dma_map_page_attrs()
  with DMA_ATTR_REQUIRE_COHERENT
- Remove defensive parameter checks and dma_max_mapping_size() from the
  allocator helper
- Move MAX_PAGE_ORDER validation to qmem_alloc()

v6 -> v7: Addressed Sashiko comments.
	https://lore.kernel.org/netdev/178863855246.219967.10510865726694393307@kernel.org/

v5 -> v6: Addressed review comments.
	https://lore.kernel.org/netdev/20260901015621.2708182-1-rkannoth@marvell.com/

v4 -> v5: Fixed compilation issues.
	https://lore.kernel.org/netdev/20260831024210.208447-1-rkannoth@marvell.com/

v3 -> v4: Fixed compilation issues.
	https://lore.kernel.org/netdev/apTpKcN_S1xIwRbZ@rkannoth-OptiPlex-7090/

v2 -> v3: Addressed sashiko comments.
	https://sashiko.dev/#/patchset/20260825045616.3723078-1-rkannoth%40marvell.com

v1 -> v2: Rewrote patch as per sashiko comment.
---
 .../ethernet/marvell/octeontx2/af/common.h    | 45 ++++++++++++++++---
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index 779413a383b7..78e42549d990 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
@@ -7,6 +7,10 @@
 #ifndef COMMON_H
 #define COMMON_H
 
+#include <linux/dma-mapping.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
+
 #include "rvu_struct.h"
 
 #define OTX2_ALIGN			128  /* Align to cacheline */
@@ -44,6 +48,33 @@ struct qmem {
 	u32		qsize;
 };
 
+static inline void *otx2_dma_alloc_coherent(struct device *dev, size_t size,
+					    dma_addr_t *dma_handle)
+{
+	dma_addr_t dma_addr;
+	void *vaddr;
+
+	vaddr = kzalloc(size, GFP_KERNEL);
+	if (!vaddr)
+		return NULL;
+
+	dma_addr = dma_map_single(dev, vaddr, size, DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(dev, dma_addr)) {
+		kfree(vaddr);
+		return NULL;
+	}
+
+	*dma_handle = dma_addr;
+	return vaddr;
+}
+
+static inline void otx2_dma_free_coherent(struct device *dev, size_t size,
+					  void *vaddr, dma_addr_t dma_handle)
+{
+	dma_unmap_single(dev, dma_handle, size, DMA_BIDIRECTIONAL);
+	kfree(vaddr);
+}
+
 static inline int qmem_alloc(struct device *dev, struct qmem **q,
 			     int qsize, int entry_sz)
 {
@@ -60,8 +91,11 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
 
 	qmem->entry_sz = entry_sz;
 	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
-	qmem->base = dma_alloc_attrs(dev, qmem->alloc_sz, &qmem->iova,
-				     GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
+
+	if (get_order(PAGE_ALIGN(qmem->alloc_sz)) > MAX_PAGE_ORDER)
+		return -ENOMEM;
+
+	qmem->base = otx2_dma_alloc_coherent(dev, qmem->alloc_sz, &qmem->iova);
 	if (!qmem->base)
 		return -ENOMEM;
 
@@ -80,10 +114,9 @@ static inline void qmem_free(struct device *dev, struct qmem *qmem)
 		return;
 
 	if (qmem->base)
-		dma_free_attrs(dev, qmem->alloc_sz,
-			       qmem->base - qmem->align,
-			       qmem->iova - qmem->align,
-			       DMA_ATTR_FORCE_CONTIGUOUS);
+		otx2_dma_free_coherent(dev, qmem->alloc_sz,
+				       qmem->base - qmem->align,
+				       qmem->iova - qmem->align);
 	devm_kfree(dev, qmem);
 }
 
-- 
2.43.0

