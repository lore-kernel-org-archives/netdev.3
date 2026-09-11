Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96323D891F;
	Fri, 11 Sep 2026 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093637; cv=none; b=jgB8+AXmvOxN46jGwaUnkyFDT0klYun2vEmolRNdqTTggumpwXFj6tVtUoKewZBkktQcnYuE6VclrlSmASjEYiGMoYaAQnRGp+Z73R1DlXtm+gplEfJ3Z+tvlsnC9AYp2wq1WQlTeA57dFNPlnCBS+sNMHNMj+2B0hSAFO6JQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093637; c=relaxed/simple;
	bh=b5tqjVkCzKniwGDHsdA3MDH9gTn1SrNlnQnnCNlXyxU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VAjhevKKRSMUoSjCoJ4fqRWQnGIZMVMut64cLI8/1uQ8pGhgFdQtbWRk1Kmf8zPDbfagwCFtTaNagrlk5vVr/VFNz7ZAPHYfNSVb6N/bKCHpD+8n55L6PUiMiWM8X+uWy8rvHRZfu8L/TaOeOUeoVxFSynAw6YVnmTvVd4pFqOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KIAl/yXD; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KIAl/yXD"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B1245K2492347;
	Thu, 10 Sep 2026 19:27:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=diB5wH1BEuu/wrFDRhumqEY
	yEAnqWaC7u1J9kL0anho=; b=KIAl/yXDCQVv53Hk9EHQfKA1UlMNibeqsYrdWuQ
	4KdNo6vsWEwDyO07z+BEF7ki3vQGUbS3kLI2KXdWLneGFQOQxG1iyJlCkEtLRkOg
	187D3chX8G+gH4S/uYktL+BvLbniisZspMVumM9Ui/03OAdcmT5ehnP6/nWIoOvI
	CWjCUiE2S3lXX3K8XadTz4wpbLhwpwN/4FhgTjyxoAo6WpmjSXiFWpH6v2Ypxb5V
	t6P1mrxdDixSlAUZ2xHdahckNq9W2HUI9k9Li+l50IotMTP5ABw60um7zy/xNYoe
	s+VdlfkLk0PmY8J9pTUzSxv+hllhpb5WRwyqicXHrHK8Jiw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gkcxnwsn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 19:27:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Sep 2026 19:27:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 10 Sep 2026 19:27:05 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 2C02A3F705A;
	Thu, 10 Sep 2026 19:27:01 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <leon@kernel.org>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v9 net] octeontx2-af: switch qmem from coherent DMA alloc to streaming DMA mapping
Date: Fri, 11 Sep 2026 07:56:49 +0530
Message-ID: <20260911022649.573300-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDAzMCBTYWx0ZWRfX7g1+IQNRhJ6l
 JioAZ7b3o/TeTqginXYK0xDsjK5LkJm/J8AGxRRsKLlmuWFDoO5+bu4Y06jmyH1sPVZ4/VQiII5
 gFFZRoVCX1ZWDq9kwYOMRFjOjZNjgArHyAbd9zUDYjSGjwSTIrSmkXZA3q4mENNeB3RHVhToOCq
 3YBBHkz6OEK4kYZuss9HdLc3C8nFQtGiIKOGI4fhgy1b+AG3RvW8UOQytnAtdFCWRAkpRgLLkw3
 RC8JCdGuKrszdy5+25JhUqYecP/oDX+p4U6Ys0Ct8Ue+aMMch1OdL3Sx9jgtA/1AboiJibSjk34
 kmfnaJRHd6jO2KxlnZh00CmUqg5HHklrWjIG2aDjZ00OSu2V64uhAumS0EkKc8tJA35pnyFyxO1
 W4K8nSThUjeRfre5S8ZmpPl517vxiXsIfw9sVb8AXraY1qSSpYQ6bW+mrROrrVeJKe/y6kNvI2K
 Nlo47YBw6NJGn2x9v+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDAzMCBTYWx0ZWRfXyHdTwyJGq4WZ
 OfEzMilZ8v+NExIz6lDEwEaC4fRU6n5mXpWyVK4XTIM5jghz6OCL8oCCCfCw6lHXSJEtFbluDPX
 VyKsjFgb78GZA6QaQU1yyeEC+KzQknY=
X-Authority-Analysis: v=2.4 cv=UJxIjyfy c=1 sm=1 tr=0 ts=6aa366fa cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=c92rfblmAAAA:8
 a=ru-v7klqmRdtzB5SPb0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: AQ02s-JMqyUgEObEI6HN_V9U5YvigH6_
X-Proofpoint-GUID: AQ02s-JMqyUgEObEI6HN_V9U5YvigH6_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_01,2026-09-09_02,2025-10-01_01

qmem_alloc() uses dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS, which
allocates CPU-cache-coherent DMA memory and, with CMA enabled, draws from
the CMA pool. qmem backs NIX/NPA queue contexts, admin queues, and LMTST
regions (including CN10K LMTST areas that span page boundaries), so
consumption grows with enabled interfaces and is hard to provision in CMA.

Switch qmem to a streaming-DMA-style path: allocate memory with kmalloc(),
then map it for device access with dma_map_single(). Add
otx2_dma_alloc_coherent() and otx2_dma_free_coherent() helpers and wire
qmem_alloc()/qmem_free() through them instead of dma_alloc_attrs()/
dma_free_attrs().

This works on Octeon because the octeontx2 driver is written for
DMA-coherent devices: Octeon platforms provide IO coherency (via SMMU), so
the driver already uses streaming DMA APIs for packet data while
deliberately skipping explicit CPU cache sync (DMA_ATTR_SKIP_CPU_SYNC).
The same IO coherency lets qmem use a streaming map of kmalloc-backed
memory instead of a dedicated coherent allocator or CMA reservation. That
is valid because the platform is DMA-coherent, not because omitting
dma_sync_* magically makes memory coherent.

cc: Leon Romanovsky <leon@kernel.org>
Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
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

