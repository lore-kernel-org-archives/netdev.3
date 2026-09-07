Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40937262E;
	Mon,  7 Sep 2026 04:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788755199; cv=none; b=StfajgIkrSdfxu5dovDcK3Bfy/oi57lpyVNwoBsC7sbXfRVmyYcgFrNAn9rHTkimNZx8Xv8J2+c8yBiM7q8RmWz3Io5e6mq/nIdUQs09uY8WG+1LarH+fB6MlWp/HEyDp/7IPh2DqgUtn49DUApZXHSAGsqHmdpS5DuzcCS6f2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788755199; c=relaxed/simple;
	bh=HGONXtsYIyTXjgOinDCEJ/TO5O6nqTEHaVTdeUwAn4E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BtqwL5Kq+0KbGdhnmzN7ITk9/Otu+W21iiBAfONSEv4TeekBHWtZWv1ksNnH59/xDnXYltd4nReB6FbzujBtNYGNvJJfMxWlRb5z+vxp+1uBzNaQzFTeO7lOFcTvY12XmWk9TkvEvoxEifwnIM6dImLnEqWbEsPIcKS5C/nGuIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aDijYLtr; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aDijYLtr"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6873ksvh892506;
	Sun, 6 Sep 2026 21:26:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=PGK4TG5SCUPSyudunAdd7vT
	cWyaG6OG13ZmfJtdS0e0=; b=aDijYLtrTVcSwuJwpSrMJ06tQTq8BkCuO60WRCD
	3l5U4k+Y5t13YYitPEo+J+W/X1SLP1MoZbKWDdC/Snf2TfpEFBdGMCdVOgIRuvsW
	gRnr4qllR85hn1rwwh9AA3kMNgi7KAFm8jP9nqIhIUhtOnxRd50FI7WlWxpD47ne
	5IKOIGp/56QCoiEwFWMdlofZhOHrnFSkP6SFKE8K7xw4sM9wP3WcDL04TqE9WeeO
	l0uAnoacGwwbhmgFD2A1foQRjgPvYi0DneonAvNvwLF0lOCTelx9YmaIV7b/M9Nm
	8Fzzq+wpeFWfJ/C+P+VgpV/6WrZ1nEhQsmxYqwxIIsxhyPw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gh3u8sfna-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Sep 2026 21:26:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 6 Sep 2026 21:26:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 6 Sep 2026 21:26:27 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 7EF043F70A1;
	Sun,  6 Sep 2026 21:26:24 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v7 net] octeontx2-af: switch qmem from coherent DMA alloc to streaming DMA mapping
Date: Mon, 7 Sep 2026 09:56:16 +0530
Message-ID: <20260907042617.4076723-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: I64b3l3zOTxxHOgRTmx-Rhg9Pc79Myso
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA0NCBTYWx0ZWRfX348ad1Ze5uf+
 xCIf4KUyzZaXX7KtM59dVeKbC4vrK5KbFyyaATKZfjZQvd1jTZgumcAsOY4HTUcA9ViVVkyi6SI
 Xiax2z/7SFkJOlod+PvZtOo55cn5iq8=
X-Authority-Analysis: v=2.4 cv=b7+CJNGx c=1 sm=1 tr=0 ts=6a9e3cf5 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=c92rfblmAAAA:8
 a=RjVHOpb4maD8GXoWDgQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA0NCBTYWx0ZWRfX/2NIlrAcE6aW
 kFAZIvfDMllCf0nSGZvVS39ZB+UKtf1EMQqyocCKjf9x7WV2TwTXJfXkTKaxj4pNABXCYn1x5ci
 s2LV2KRtgjm/wnfjLH4IKceqcGqDDxxWQV6qDMjnypFNsrUH2UrToo35LdTPr6bhTgCn82SQTtD
 XvUNFn2Daue1LarpqfNZLMcr1t/XZF++sKI3GV0dY77JjU2c7Jemqtnk2yAMD13/K4GEpG6Q5hG
 58fhs5YvcnlVYPh7iYhxYJxteVNU8uZUnp8rplZeOjW6KHVSNPHSerGZ18BNO/n2W2IVRMMRd8U
 4XRA92bbq03sYaQxLHpRRWbT/OSDuBN8i9687fP5UgX7aa4g9UCMdITl255IHsq8yYKPpfHLF49
 fvgyzLlfVTq6RXGfTSpkjeIAb2zyG0jpM2e+ou9YFhVePjU8WXMdYVZ2efq+QY77PSh4NHRImUv
 9ud0piIuiE4/c2hMAdw==
X-Proofpoint-ORIG-GUID: I64b3l3zOTxxHOgRTmx-Rhg9Pc79Myso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01

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
v6 -> v7: Addressed Sashiko comments
	https://lore.kernel.org/netdev/178863855246.219967.10510865726694393307@kernel.org/

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
 .../ethernet/marvell/octeontx2/af/common.h    | 99 +++++++++++++++++--
 1 file changed, 93 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index 779413a383b7..cca2ae22c753 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
@@ -7,6 +7,11 @@
 #ifndef COMMON_H
 #define COMMON_H
 
+#include <linux/dma-direct.h>
+#include <linux/dma-mapping.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
+
 #include "rvu_struct.h"
 
 #define OTX2_ALIGN			128  /* Align to cacheline */
@@ -44,6 +49,90 @@ struct qmem {
 	u32		qsize;
 };
 
+static inline bool otx2_dma_phys_in_mask(struct device *dev, phys_addr_t paddr,
+					 size_t size)
+{
+	dma_addr_t dma_addr = phys_to_dma(dev, paddr);
+
+	return dma_capable(dev, dma_addr, size, true, 0);
+}
+
+static inline void *otx2_dma_alloc_coherent(struct device *dev, size_t size,
+					    dma_addr_t *dma_handle)
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
+
+	/* Octeontx2 qmem call sites size their allocations within
+	 * MAX_PAGE_ORDER; mailbox, queue context, and ring memory
+	 * requirements stay below the buddy allocator's limit.
+	 */
+	if (order > MAX_PAGE_ORDER) {
+		dev_err(dev,
+			"CONFIG_ARCH_FORCE_MAX_ORDER is set to %u, minimum needed is %u\n",
+			MAX_PAGE_ORDER, order);
+		return NULL;
+	}
+
+	if (size > dma_max_mapping_size(dev))
+		return NULL;
+
+	alloc_gfp = GFP_KERNEL | __GFP_ZERO | __GFP_COMP;
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
+	/* dev_is_dma_coherent() only guarantees cache coherency, not that the
+	 * mapped DMA address aliases qmem->base.  Require a coherent mapping
+	 * so the DMA API rejects SWIOTLB bounce buffers.
+	 */
+	dma_addr = dma_map_page_attrs(dev, virt_to_page(vaddr), 0, size,
+				      DMA_BIDIRECTIONAL, DMA_ATTR_REQUIRE_COHERENT);
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
+	dma_unmap_page_attrs(dev, dma_handle, size, DMA_BIDIRECTIONAL,
+			     DMA_ATTR_REQUIRE_COHERENT);
+	free_pages((unsigned long)vaddr, order);
+}
+
 static inline int qmem_alloc(struct device *dev, struct qmem **q,
 			     int qsize, int entry_sz)
 {
@@ -60,8 +149,7 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
 
 	qmem->entry_sz = entry_sz;
 	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
-	qmem->base = dma_alloc_attrs(dev, qmem->alloc_sz, &qmem->iova,
-				     GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
+	qmem->base = otx2_dma_alloc_coherent(dev, qmem->alloc_sz, &qmem->iova);
 	if (!qmem->base)
 		return -ENOMEM;
 
@@ -80,10 +168,9 @@ static inline void qmem_free(struct device *dev, struct qmem *qmem)
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

