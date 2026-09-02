Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DE1337B81;
	Wed,  2 Sep 2026 02:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788315050; cv=none; b=FaHZQe4NDNnhJ0qOXQOFMqvEx9orO0tt01m+5G2ybkVAEGgcXhhbMNKVQ6DGKGzHZCVBFu9aIokoLu0UCS5x9IBYnoHXGCQ2JmuSdo61D7R9/nNqT6tXtWb+38IzaLFOjb+yzfcZEevA6x1VMRlzj/AwHRzUkml5jpo+RYCF2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788315050; c=relaxed/simple;
	bh=i1i9S3my4vaeFmsCeycJafrcVD7LiVUapFry091T9Z0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lCayJKjYPFR12G5fCdbjX0sOZM5Dgl+zz8OJgA26UyszGlDvyFeXrfjyDppj35l6vRjx33lm6mhdYjrxs936861saStedq5LF2xRSdUIkU3h1WopJCwWoA1gn6fNSI2O6VRy8AWRha0WxxWHQJhvGd9fEl7M81mDSlywV425xlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=F5W4id1v; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="F5W4id1v"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681Nh9iw1081117;
	Tue, 1 Sep 2026 19:10:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=T3lVIesR5KavWO77y/7CleO
	2a9ioqQS7P+0orlKRBs4=; b=F5W4id1vP4KAaIRgHMR+5dh8fYBGGLJfbYS9BGF
	0G04WR7SZFIbJpKIepsFx+k7IKk4haz/VlPlgSgYtOjFWk0nib6PFri+G6yFR8Cv
	YPedBm3bg/cGfW53B6DVsumK3CM5qe8rp1mOFt8sYn+jvZJ0YU0T8FKUwYPd2RPH
	e8/MQvFcTo+FdEkvzjw2XGreNaZolutQw8TZB+tgJLo+i5a0W8WU5+gfqSW0mKr0
	lXnplmXuF+IS5t9CG4AQ0OhmANoywC4iaSJAoATvrtW3FJBSAgoe/OOkW6aTq+2d
	vxuy9rDwV/5x9ohc0ekc6epwTRzpR4/f8K8pU70P/FTnwAQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ge8mj8a2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 19:10:35 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Sep 2026 19:10:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 1 Sep 2026 19:10:34 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 926013F704D;
	Tue,  1 Sep 2026 19:10:30 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <leon@kernel.org>, <Qqingfang.deng@linux.dev>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v6 net] octeontx2-af: switch qmem from coherent DMA alloc to streaming DMA mapping
Date: Wed, 2 Sep 2026 07:40:23 +0530
Message-ID: <20260902021023.2987908-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Gaj-XpRjMB7GnD-uyLUj0D6ZuCNc7eTH
X-Proofpoint-ORIG-GUID: Gaj-XpRjMB7GnD-uyLUj0D6ZuCNc7eTH
X-Authority-Analysis: v=2.4 cv=FKorAeos c=1 sm=1 tr=0 ts=6a97859b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=c92rfblmAAAA:8
 a=LKxa-v6c6y_hKPs_AdcA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDAxNiBTYWx0ZWRfXzeVVeDXXFt6b
 vRfPPg+IOHJpEQsYZ6o5Rwa1dwNxmE93d9Fhr8rqcTz/pItfyg3wwt73vS1XqasHPlZrkXOs559
 HE8RQvBXLKg4/T4Hz6cTEhjTPwsdcsA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDAxNiBTYWx0ZWRfX86kkfYtZK3cy
 q2wHSg7s9dMFczfA16P5RLdk6MIsmxZSuwFfbkv4YFbogCAuo6cj2rxww1dlTyI4XF6JfcIyBFd
 HMUVawswlVU+aIMUiG7S+OirmNs/bnWBkJxcNJZ9mkGSspAv/SQXYPPO1MEjk6oZsUodk7KtqpU
 23n6K44iKr1g27xCU/xVCMy2q951A6yDtoNZb4q3nLvIEvt9tGd2cLQ7pyw2HgwMzw3JPVhq5wG
 x98RESe7qZ8aoE8mYqQQjI7aKxV68weWJyDaBMMnmEF6odbnZ3ATWPOsXYDhzPoec4az25OERot
 7PWV3BBGInK7LeE0nKcK1PJsEErtAwbw0XZmnhN8KqYjQklYwGmhhupO6/U09IA7WaijXHHnH0U
 T7NOEPnqKeB3FQkFvAHl07Mn+c+A9delJObtBGGf1jfGQqNYP+bFxfuqK4Q39xaPIrohD9mC5Ef
 2h2f8+cGPRnSrvlvkOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01

qmem_alloc() uses dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS, which
allocates CPU-cache-coherent DMA memory and, with CMA enabled, draws from
the CMA pool. qmem backs NIX/NPA queue contexts, admin queues, and LMTST
regions (including CN10K LMTST areas that span page boundaries), so
consumption grows with enabled interfaces and is hard to provision in CMA.

Switch qmem to a streaming-DMA-style path: allocate physically contiguous
compound pages from the buddy allocator via __get_free_pages(), then map
them for device access with dma_map_page_attrs(). Add
otx2_dma_alloc_coherent() and otx2_dma_free_coherent() helpers that
enforce dev_is_dma_coherent(), retry with GFP_DMA32 when the physical
range is outside the device DMA mask, and wire qmem_alloc()/qmem_free()
through them instead of dma_alloc_attrs()/dma_free_attrs().

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
v5 -> v6: Addressed Review comments
	https://lore.kernel.org/netdev/20260901015621.2708182-1-rkannoth@marvell.com/

v4 -> v5: Fixed compilation issues.
	https://lore.kernel.org/netdev/20260831024210.208447-1-rkannoth@marvell.com/

v3 -> v4: Fixed compilation issues.
	https://lore.kernel.org/netdev/apTpKcN_S1xIwRbZ@rkannoth-OptiPlex-7090/

v2 -> v3: Addressed sashiko comments
	https://sashiko.dev/#/patchset/20260825045616.3723078-1-rkannoth%40marvell.com

v1 -> v2: Rewrote patch as per sashiko comment
---
 .../ethernet/marvell/octeontx2/af/common.h    | 84 +++++++++++++++++--
 1 file changed, 78 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index 779413a383b7..4ec20c3cfec0 100644
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
@@ -44,6 +49,74 @@ struct qmem {
 	u32		qsize;
 };
 
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
+	gfp_t alloc_gfp;
+	void *vaddr;
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
+	       !otx2_dma_phys_in_mask(dev, virt_to_phys(vaddr), size)) {
+		free_pages((unsigned long)vaddr, order);
+		if (alloc_gfp & GFP_DMA32)
+			return NULL;
+		alloc_gfp |= GFP_DMA32;
+		vaddr = (void *)__get_free_pages(alloc_gfp, order);
+	}
+	if (!vaddr)
+		return NULL;
+
+	dma_addr = dma_map_page_attrs(dev, virt_to_page(vaddr), 0, size,
+				      DMA_BIDIRECTIONAL, 0);
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
+	dma_unmap_page_attrs(dev, dma_handle, size, DMA_BIDIRECTIONAL, 0);
+	free_pages((unsigned long)vaddr, order);
+}
+
 static inline int qmem_alloc(struct device *dev, struct qmem **q,
 			     int qsize, int entry_sz)
 {
@@ -60,8 +133,8 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
 
 	qmem->entry_sz = entry_sz;
 	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
-	qmem->base = dma_alloc_attrs(dev, qmem->alloc_sz, &qmem->iova,
-				     GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
+	qmem->base = otx2_dma_alloc_coherent(dev, qmem->alloc_sz, &qmem->iova,
+					     GFP_KERNEL);
 	if (!qmem->base)
 		return -ENOMEM;
 
@@ -80,10 +153,9 @@ static inline void qmem_free(struct device *dev, struct qmem *qmem)
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

