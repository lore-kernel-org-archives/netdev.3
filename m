Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB239FCCA;
	Mon, 31 Aug 2026 02:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788144152; cv=none; b=uYQKuveyxAoOKnpbdvBM9QFHhZ0BqVeg/v9XgAFn62/bKqotsxiufhkkHZaHutBrMYqILall0595U0L09Do6febDrBVBfNCi9KgJuLGk/5SNOGu33VnLkFtm60NBgp5f6SEYr0lzkHWoNVOu60Bqf+exoUj5x9USIjEKsjIFILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788144152; c=relaxed/simple;
	bh=FW8/DsqKFFmOX7ebpO5LpSWmfki5hsDx5qU2SPAi4Fc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d5miHGYad7JIbiPKUE4GdJsVljbLbaG+FzIBch7QeLW/AGLXm5BTd9Iy+6uyUqg1IB7SmWvycmSM3t0vkxD7TL3nRmy7SjkSGyamk+bIGI06LqQzFLKVDuFFnvFH5zihlCgVgErZIHH/cK5F0W4mEwtxUvSxZ+FRAmLxOaG1MM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=frXyrBut; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="frXyrBut"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V1buLC3698144;
	Sun, 30 Aug 2026 19:42:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=IpEtLAuhQdynZllPbO6Fg+4
	6wAnOwB2T58eUa87MZ5k=; b=frXyrBut+E0BpFBfVFmDodY4YSuPoISy6P8olhe
	c5Kv2ITslRisV93aJSZlmKlvkrYqgUA+e9vrpu57Hgj0z8WFBAYrGo3+hRUW8qTi
	ah22XLFL6jWdPTfsVH6lXXg6ykJTK88eKYM1QhMU6q5zIO/RH1v3ZlDC4ERmkh5i
	u316AS9OAGBngzYVr33bUtg3GLJQUaTMoutoTu3m/Z48D9bjuKdtiGtyxBe7c78s
	3lVbS3rE6FVZhmcjx5INHDn+5O0ss9Pw6QA6YdX7Zy8x035iBzfHCb4sMdlXtJ7Y
	QFj37yqczHY/xEs7IadC9AogfT/T+3Pa4TFikpuaGpziJlQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gckp8h271-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Aug 2026 19:42:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 30 Aug 2026 19:42:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 30 Aug 2026 19:42:19 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 836B33F7089;
	Sun, 30 Aug 2026 19:42:16 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v4 net] octeontx2-af: switch qmem from coherent DMA alloc to streaming DMA mapping
Date: Mon, 31 Aug 2026 08:12:09 +0530
Message-ID: <20260831024210.208447-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDAyMSBTYWx0ZWRfX/Z3VxEpSogrw
 5IqkStHJdtHGfcFLaZhsmt4iCmoVAJA/rppDmZyheDDEzm6WayMThABA0zw5mXB0I4xdQhKDslN
 ASX64YSe5X6GFC83KLgGDRfMt7fqNh5inxrAkCaf7TYCWHpfZsKR7aKWHio5WzY7SlamkWfkPJm
 bseHjWa7NCYff97WORg9r0ISLH9FBbCvg8Wz4+nxsGbJJgYJIvxNzW4RlT8HwYXpi4jDO1UxKIh
 mccuSewWgEiGMhR826taGEs9YxO/T/VzTPLNGcHfDkftmG/PF2RlA3KtwoTwvGjYwhPdGp6FNm3
 73SciIuC2VKGFFFMXAgXPACQzo8keYjibKUIM0W9n+NYEHNaul8lva6VivNLLsZZLbTE4Z8D/pI
 +u5xsrTyeWfFVDrY372gYjjmiLXMC1zh9tg1XxQ/Aal6lQfscqnjsIOPxQvrjDuDUwXHf3GNEj9
 gqd9qpXIXh1aVSO+KGg==
X-Proofpoint-GUID: DwjLxArxpoSaWjVTqbCYf2bRU99oQwnP
X-Proofpoint-ORIG-GUID: DwjLxArxpoSaWjVTqbCYf2bRU99oQwnP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDAyMSBTYWx0ZWRfXwl1oGAWxUjGe
 ik8/8Tuf6zqcFX1/9hDmieElqo6OMYfoPXU6/pKej1QvVidv4ft7J3ln4H1v1BYTEv5GAmwr3ux
 NjUHYUvFkH6gN49zcHsXmQgSozz5/sM=
X-Authority-Analysis: v=2.4 cv=GLk41ONK c=1 sm=1 tr=0 ts=6a94ea0c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=c92rfblmAAAA:8 a=M5GUcnROAAAA:8
 a=_H5WFHcS1g1bKW8oBMQA:9 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_01,2026-08-27_02,2025-10-01_01

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
v3 -> v4: Fixed compilation issues.
	https://lore.kernel.org/netdev/apTpKcN_S1xIwRbZ@rkannoth-OptiPlex-7090/

v2 -> v3: Addressed sashiko comments
	https://sashiko.dev/#/patchset/20260825045616.3723078-1-rkannoth%40marvell.com
---
 .../ethernet/marvell/octeontx2/af/common.h    | 92 +++++++++++++++++--
 1 file changed, 86 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index 779413a383b7..4dd6d5fc877c 100644
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
@@ -44,6 +48,83 @@ struct qmem {
 	u32		qsize;
 };
 
+/* Buddy-backed coherent DMA alloc (Option 3): pages from __get_free_pages(),
+ * DMA-reachable RAM via dma_coherent_ok(), and bus/SMMU mappings via
+ * dma_map_phys() -> iommu_dma_map_phys() -> iommu_map() on SMMU systems.
+ */
+#define OTX2_DMA_COHERENT_ATTRS	DMA_ATTR_REQUIRE_COHERENT
+
+static inline bool otx2_dma_phys_in_mask(struct device *dev, phys_addr_t paddr,
+                                        size_t size)
+{
+       u64 mask = dma_get_mask(dev);
+
+       return paddr + size - 1 <= mask;
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
+		    __GFP_ZERO | __GFP_COMP | __GFP_RECLAIM;
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
@@ -60,8 +141,8 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
 
 	qmem->entry_sz = entry_sz;
 	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
-	qmem->base = dma_alloc_attrs(dev, qmem->alloc_sz, &qmem->iova,
-				     GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
+	qmem->base = otx2_dma_alloc_coherent(dev, qmem->alloc_sz, &qmem->iova,
+					     GFP_KERNEL);
 	if (!qmem->base)
 		return -ENOMEM;
 
@@ -80,10 +161,9 @@ static inline void qmem_free(struct device *dev, struct qmem *qmem)
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

