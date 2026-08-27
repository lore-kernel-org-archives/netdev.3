Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A785346A02;
	Thu, 27 Aug 2026 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814380; cv=none; b=cKUrEHvmuphDCTLpzEwXrt0OlHeF3fB/AjI77irVJEsXIWSfYQ50hMJBUCLceq1EQ6Z7eE7DV/ljZj640TSEfaJ6lyse6T7x+mO5AyWF/kPjcFBer4YRRhT/mIsz6Td1xvZbhAbcqO5jCgRAg5QKCBsUUqqYu2ez9MfDey+zdEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814380; c=relaxed/simple;
	bh=4BNXZbWRYPNaX43hc0k12OnYrSBjNZbE3iOBf1RWn0g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rp14tSdf5aocN+n3IE+DZIJRmhy9jwvn8m8JXRqeZIOFq2wXkXglwS26jRwpSMLHG+VWhGtoDRHB5BrHthl3B7xgTlxvubVt4pMICRbtuLDyYdJ5taSVZq6B3d8ohARV9vKx/1JFllaVdEqFo4N23oYvFnyIi8LPIKbFWKZFP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WQW1bkH9; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WQW1bkH9"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6QiuV2900718;
	Thu, 27 Aug 2026 00:06:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=PubU3jA6ABe9FIW24QaXu3z
	i/fiEy/Jv7mH/zMndm6U=; b=WQW1bkH9HwHMA/6psuqn5W6pO9+LYug4A8ljggH
	j6Ig4qEhnIIJtrEkP2sfgUe/mTY5eXEzaz52wSQNyghxA6gDq0IhEyKzcQbKKQBE
	B76mGE5A91n7Nnxlm318Lj//Ht6Mm19BSiiP5qwPyKSniHirb64Vy/Ha/qjjlNeS
	20KhvsQe83ah+Y7DMnPe8vfcb+DuAhl4No/TQFA+UWeEkp+Ip+8HKVBU9212pJww
	ZmfmaDOhWLhYngFcOAwMUWL7DQ8iFI6ul+canDVCigpH9L3coZYKXeDcR37RYOzv
	rDpFjpwqBIoEvst39BN95fb8vR5D4vzZF0MJMDsUZvgEY1Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g9xjqm154-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 00:06:08 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 27 Aug 2026 00:06:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 27 Aug 2026 00:06:07 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 070AB3F7058;
	Thu, 27 Aug 2026 00:06:03 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v3 net] octeontx2-af: allocate qmem from page allocator to avoid CMA
Date: Thu, 27 Aug 2026 12:35:53 +0530
Message-ID: <20260827070554.3919891-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA1NyBTYWx0ZWRfX6pYGBGlrCHcw
 uFeyEj+cXER2LA8E+ckOOluOkDEREQB7r0X5lERSaO0yBlkP3R9+W6NKCqUVt5DCg1E+5XQNry7
 oqCu8W6cuTX4L0zL2n4dv70nGZNoJdA=
X-Proofpoint-ORIG-GUID: 4xM3pL3fMwQYcpHdGkxRD0ixw7XB47bc
X-Authority-Analysis: v=2.4 cv=C/jZDwP+ c=1 sm=1 tr=0 ts=6a8fe1e0 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=c92rfblmAAAA:8 a=M5GUcnROAAAA:8
 a=5A6duo2oPW0hgrYG7nMA:9 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA1NyBTYWx0ZWRfX3rntqjA3EtsS
 Pqo2dXhcC+enTN1pqJMxXjCI81L5MZyCeYI7CsfVQL7R8G2VZWFYNU3hsXC2o2uP96HL3BeJkLj
 kE6TKS/svhvDYqUCDfzJGnhozY3sp5gGjLvKHCbGPZClVGs5MlbT6nx9x9cQrcAh1Dwy8ujttXe
 Rk9AyVrXFs13drpELMShNpcMKQnOieIHx5+hFFupKA/fANsIdpLh4lQrbaCW+Y/2Z8s8gGqV10u
 P414RF2RLALSjuKE2vtg3mT4UemYT4aBVbVZGMzwoFcje7FRhobxlgY3yH82zB6L+17dbYq2uOg
 NkQOQveJ0u2CzZyRhAw9dcrabnY3TI5QeH1pESs1cmUSXCdOhzSVVoXYEiggH4tBfh+bGQ3rNvy
 QHOiUJBiYkZi5RxkpjRiLEd63XemiHH1IHJtcVUCahbDiSvuWbrZf7vVXWG3UoveAEatp736D1a
 knQQgS6YgWpKfDlRh2A==
X-Proofpoint-GUID: 4xM3pL3fMwQYcpHdGkxRD0ixw7XB47bc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01

qmem_alloc() uses dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS for
physically contiguous DMA memory (e.g. CN10K LMTST regions spanning page
boundaries). With CMA enabled, those allocations are drawn from the CMA
pool. qmem backs NIX/NPA queue contexts, admin queues, and LMTST regions,
so total usage scales with enabled interfaces and is hard to provision in
CMA.

Add otx2_dma_alloc_coherent() and otx2_dma_free_coherent() helpers that
allocate compound pages from the buddy allocator via __get_free_pages()
with __GFP_COMP, __GFP_ZERO, and __GFP_RECLAIM (qmem_alloc() runs in
GFP_KERNEL context), select DMA-reachable memory with dma_coherent_ok()
(retrying with GFP_DMA32), and map the contiguous physical range for DMA
through dma_map_phys() and dma_unmap_phys() with DMA_ATTR_REQUIRE_COHERENT
so SMMU/IOMMU page table entries are installed on IOMMU-backed platforms.
Switch qmem_alloc() and qmem_free() to these helpers instead of
dma_alloc_attrs()/dma_free_attrs() with DMA_ATTR_FORCE_CONTIGUOUS.

Allocations requiring more than MAX_PAGE_ORDER pages are still rejected,
as the buddy allocator cannot serve them without CMA.

Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v2 -> v3: Addressed sashiko comments
	https://sashiko.dev/#/patchset/20260825045616.3723078-1-rkannoth%40marvell.com
---
 .../ethernet/marvell/octeontx2/af/common.h    | 81 +++++++++++++++++--
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index 779413a383b7..c6a6aae436a3 100644
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
@@ -44,6 +48,72 @@ struct qmem {
 	u32		qsize;
 };
 
+/* Buddy-backed coherent DMA alloc (Option 3): pages from __get_free_pages(),
+ * DMA-reachable RAM via dma_coherent_ok(), and bus/SMMU mappings via
+ * dma_map_phys() -> iommu_dma_map_phys() -> iommu_map() on SMMU systems.
+ */
+#define OTX2_DMA_COHERENT_ATTRS	DMA_ATTR_REQUIRE_COHERENT
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
+	size = PAGE_ALIGN(size);
+	order = get_order(size);
+	if (order > MAX_PAGE_ORDER)
+		return NULL;
+
+	alloc_gfp = (gfp & ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM)) |
+		    __GFP_ZERO | __GFP_COMP | __GFP_RECLAIM;
+
+	vaddr = (void *)__get_free_pages(alloc_gfp, order);
+	while (vaddr &&
+	       !dma_coherent_ok(dev, page_to_phys(virt_to_page(vaddr)), size)) {
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
@@ -60,8 +130,8 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
 
 	qmem->entry_sz = entry_sz;
 	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
-	qmem->base = dma_alloc_attrs(dev, qmem->alloc_sz, &qmem->iova,
-				     GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
+	qmem->base = otx2_dma_alloc_coherent(dev, qmem->alloc_sz, &qmem->iova,
+					     GFP_KERNEL);
 	if (!qmem->base)
 		return -ENOMEM;
 
@@ -80,10 +150,9 @@ static inline void qmem_free(struct device *dev, struct qmem *qmem)
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

