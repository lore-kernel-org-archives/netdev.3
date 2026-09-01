Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB77B409280;
	Tue,  1 Sep 2026 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788227821; cv=none; b=JXtDL2UFpGqd6xXUoaj+ovh6ZuLckffh/VYHCxOTQaM3S5GKEW4WzCM//WovhI9CNtsHLSNR7RA7tLrvbXNhTkEBoKh5R/4L++uKhSBcPEF5hSqGwEuGb2gV5h0rjJfLJ+vkwpTMO8UH0LZW5pPZ5vwloTO5b+wZzzL03gegLuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788227821; c=relaxed/simple;
	bh=FUEbGwpuucJRnZxU3ecalNrP+U6WA4CO28VuRIkPtZE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rd40j88X5At7db6gs3+3XMxnp8cbtu7CJeXgyHdbx97HRn7iQ2zNvBvS0iBpGRmN7YaSMcy5V99BjQktdV29rb++Re+BLbGqeevlhE6dppjzzUy2WiP3B8KW3Xgb4Ha0VJmcD6ktieICSbUPdBwvasWFuB0PaMztzZUS1wl6t3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TU0X54yd; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TU0X54yd"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6810oq5Q2737091;
	Mon, 31 Aug 2026 18:56:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=+hIm0H8t3SNNWxHgGkAiCWA
	uwbbirI2o93RczyjUZx8=; b=TU0X54ydLCjRlnYw5MRLtvnsn1aiLgabFMHb1Bf
	No6/2+Gsy7t7xP+HDdV8HDKMo9nE/BgjWlxUfnf+v0ypoQXrX8h+Q4G2SVUbTnho
	0Gh83wcEE1O24LjMLsbyGW6GDF+6e3KeHpX0PFbgnODYrnm3kCSh3fE1XNBFCl/l
	DBpcWagzwUSd7HvCH9O9qktDQDTqUSwET6+XqWEaGA3riLr5hA0Y/Oq9hqpsCnVp
	8VNn/yjjYEQZyJGl6h0OEWz8Y9zyMjonzI1kUrZ0oAw9qF0t9DVuJWuLDW29524/
	+0RzsOPfxrrd0biH/UEx/bWByGsWbsjN4vUOnoPyEtBEE0w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gdcy19txu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 18:56:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 18:56:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 18:56:37 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 093705B6926;
	Mon, 31 Aug 2026 18:56:33 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v5 net] octeontx2-af: switch qmem from coherent DMA alloc to streaming DMA mapping
Date: Tue, 1 Sep 2026 07:26:21 +0530
Message-ID: <20260901015621.2708182-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=W9MIkxWk c=1 sm=1 tr=0 ts=6a9630d6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=c92rfblmAAAA:8
 a=kt9dCiDiZ5nfXSYzE0wA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: vY8mGfoXzSyXfyXCBK2kRjC1WJy6-5Kh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDAxNCBTYWx0ZWRfX2vB9YWaEW7Tc
 tWSmDMj9E2ARKFZ0snLPuaG5Iu5fP5IU+WonU0xam3W1jaqzAOQknBTFGWDhhw6rT40Q89SvGFA
 SgW0cptAy9s7KaKj5ZxdX88bSa0zfj+mMxLM46prQR4oy1q1hbPQrv6K4VBDAnMhveaRrAu/rUF
 +hXLAIm1zUJvY/dmFt3SYpzucu3as7TPYHAogf00JmXawirdGK6TexXQYSFAheQt2g4hGJ8g2l+
 dymF5msDKBezoxEOjlyYPvOyqw9veUxDxx6DGURYJlACvpxcFnn0+BIPquKJ2mehbsN4Dsz/sBK
 ZT7UJn9P6gXkWAkUKrPBxFYbaE7P+rv9Ss8TokEJgI3wcK7CpVJ3ZySeAdD3Fs5WIFGSTc+TZPV
 rqdLVPX/8MofREPRagW8PX6M65iNPia8d89VYH2cMpqfsxNz59WWPdlE+QJ6L7NoT+CO2+RcZby
 M2MyAWUGcoF1sgyMCRQ==
X-Proofpoint-ORIG-GUID: vY8mGfoXzSyXfyXCBK2kRjC1WJy6-5Kh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDAxNCBTYWx0ZWRfX4NOGd1Nnez9z
 z+FvJvhqdAt9V3SO02REDBG8cwRiSquR0p1uPU/bFJ9ghpXqHAtNA0GozfDBrEq4MyxS5RulGfx
 iMdM7DmCEyWJr/V3PD9xEylgHrOfc+8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01

qmem_alloc() uses dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS, which
allocates CPU-cache-coherent DMA memory and, with CMA enabled, draws from
the CMA pool. qmem backs NIX/NPA queue contexts, admin queues, and LMTST
regions (including CN10K LMTST areas that span page boundaries), so
consumption grows with enabled interfaces and is hard to provision in CMA.

Switch qmem to a streaming-DMA-style path: allocate physically contiguous
compound pages from the buddy allocator via __get_free_pages(), then map
them for device access with dma_map_phys() and dma_unmap_phys() using
DMA_ATTR_REQUIRE_COHERENT. Add otx2_dma_alloc_coherent() and
otx2_dma_free_coherent() helpers that enforce dev_is_dma_coherent(),
retry with GFP_DMA32 when the physical range is outside the device DMA
mask, and wire qmem_alloc()/qmem_free() through them instead of
dma_alloc_attrs()/dma_free_attrs().

This works on Octeon because the octeontx2 driver is written for
DMA-coherent devices: Octeon platforms provide IO coherency (via SMMU), so
the driver already uses streaming DMA APIs for packet data while
deliberately skipping explicit CPU cache sync (DMA_ATTR_SKIP_CPU_SYNC).
The same IO coherency lets qmem use a streaming map of buddy-allocated
pages instead of a dedicated coherent allocator or CMA reservation. That
is valid because the platform is DMA-coherent, not because omitting
dma_sync_* magically makes memory coherent.

Allocations requiring more than MAX_PAGE_ORDER pages are still rejected,
since the buddy allocator cannot serve them without CMA.

cc: Geetha sowjanya <gakula@marvell.com>
Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---

v4 -> v5: Fixed compilation issues.
	https://lore.kernel.org/netdev/20260831024210.208447-1-rkannoth@marvell.com/

v3 -> v4: Fixed compilation issues.
	https://lore.kernel.org/netdev/apTpKcN_S1xIwRbZ@rkannoth-OptiPlex-7090/

v2 -> v3: Addressed sashiko comments
	https://sashiko.dev/#/patchset/20260825045616.3723078-1-rkannoth%40marvell.com

v1 -> v2: Rewrote patch as per sashiko comment
---
 .../ethernet/marvell/octeontx2/af/common.h    | 93 +++++++++++++++++--
 1 file changed, 87 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index 779413a383b7..061dd907f7fa 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
@@ -7,6 +7,11 @@
 #ifndef COMMON_H
 #define COMMON_H
 
+#include <linux/dma-mapping.h>
+#include <linux/dma-map-ops.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
+
 #include "rvu_struct.h"
 
 #define OTX2_ALIGN			128  /* Align to cacheline */
@@ -44,6 +49,83 @@ struct qmem {
 	u32		qsize;
 };
 
+/* Buddy-backed coherent DMA alloc (Option 3): pages from __get_free_pages(),
+ * DMA-reachable RAM via dma_coherent_ok(), and bus/SMMU mappings via
+ * dma_map_phys() -> iommu_dma_map_phys() -> iommu_map() on SMMU systems.
+ */
+#define OTX2_DMA_COHERENT_ATTRS	DMA_ATTR_REQUIRE_COHERENT
+
+static inline bool otx2_dma_phys_in_mask(struct device *dev, phys_addr_t paddr,
+					 size_t size)
+{
+	u64 mask = dma_get_mask(dev);
+
+	return paddr + size - 1 <= mask;
+}
+
+static inline void *otx2_dma_alloc_coherent(struct device *dev, size_t size,
+					    dma_addr_t *dma_handle, gfp_t gfp)
+{
+	dma_addr_t dma_addr;
+	unsigned int order;
+	phys_addr_t paddr;
+	void *vaddr;
+	gfp_t alloc_gfp;
+
+	if (!dev || !dma_handle || !size)
+		return NULL;
+
+	if (!dev_is_dma_coherent(dev))
+		return NULL;
+
+	size = PAGE_ALIGN(size);
+	order = get_order(size);
+	if (order > MAX_PAGE_ORDER)
+		return NULL;
+
+	alloc_gfp = (gfp & ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM)) |
+		__GFP_ZERO | __GFP_COMP | __GFP_RECLAIM;
+
+	vaddr = (void *)__get_free_pages(alloc_gfp, order);
+	while (vaddr &&
+	       !otx2_dma_phys_in_mask(dev, page_to_phys(virt_to_page(vaddr)), size)) {
+		free_pages((unsigned long)vaddr, order);
+		if (alloc_gfp & GFP_DMA32)
+			return NULL;
+		alloc_gfp |= GFP_DMA32;
+		vaddr = (void *)__get_free_pages(alloc_gfp, order);
+	}
+	if (!vaddr)
+		return NULL;
+
+	paddr = page_to_phys(virt_to_page(vaddr));
+	dma_addr = dma_map_phys(dev, paddr, size, DMA_BIDIRECTIONAL,
+				OTX2_DMA_COHERENT_ATTRS);
+	if (dma_mapping_error(dev, dma_addr)) {
+		free_pages((unsigned long)vaddr, order);
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
+	unsigned int order;
+
+	if (!dev || !vaddr)
+		return;
+
+	size = PAGE_ALIGN(size);
+	order = get_order(size);
+
+	dma_unmap_phys(dev, dma_handle, size, DMA_BIDIRECTIONAL,
+		       OTX2_DMA_COHERENT_ATTRS);
+	free_pages((unsigned long)vaddr, order);
+}
+
 static inline int qmem_alloc(struct device *dev, struct qmem **q,
 			     int qsize, int entry_sz)
 {
@@ -60,8 +142,8 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
 
 	qmem->entry_sz = entry_sz;
 	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
-	qmem->base = dma_alloc_attrs(dev, qmem->alloc_sz, &qmem->iova,
-				     GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
+	qmem->base = otx2_dma_alloc_coherent(dev, qmem->alloc_sz, &qmem->iova,
+					     GFP_KERNEL);
 	if (!qmem->base)
 		return -ENOMEM;
 
@@ -80,10 +162,9 @@ static inline void qmem_free(struct device *dev, struct qmem *qmem)
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

