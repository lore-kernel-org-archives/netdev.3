Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B49523EAA6;
	Tue, 25 Aug 2026 04:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787633804; cv=none; b=dEcVc/fv0eNC5AM2AhDc0kp8cjfHKUr3a9rFvpyk8Mvk+cS0eRPGBUoLCylJ2cazp5+amLJg9IOIbbJxbuWKcnp6tRWt0oQTmCOrzngRiC5gPNN4pIiIPBnf85I/VDbtVduSCcEbOqq+wiU8mqEBVdtkjEARhIC9jxLCcgua+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787633804; c=relaxed/simple;
	bh=nBYszwVzs5FCAy7zLpLSrnsSfh0hF95VYsu67TuoT8w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IEFdKwPleDeQXhhCicrujrurv320D84ALGpxivmSDxl4akNtM6TXFOvwpclj8B1oZrKmrFwDA3xtbJCs0ZciVcXnyJKB4axS7w6180aKn8QZFY+nWXDqBzl3v7uUEp8sdZGoqHTzHqI1rzgeGbMg8RNWClFMbOVM37dPbVqa8dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Y0roNcnN; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Y0roNcnN"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P2QVYE1199979;
	Mon, 24 Aug 2026 21:56:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=H1WiJCyj+xeDk1QLV9CMwIU
	CuSxu0OcVTPkcsvryMQk=; b=Y0roNcnN6ZXh4VVguWHK7GM7AHCOz9CO2yn6dKe
	Tfk2UoUOIBJ/NxwOCtn8dOzwfHQzO0QZs8idGo90ZBYvAa2khIzX2WfC8wQ92by5
	ytNuQlmZUnliS15g8tZaS2x+YavXM1VCXnIMNg/uEoOrBMWNui+bzRQEN5GBdI5s
	atYIzt7H38fdNEOQWKZPFO3pTMnkuB42ffMxKFBCX8itt2pN2+lLIysarVXCs+9g
	Fz3Nfgvl2kopHGaqSADH/6b7dbjFm84Y9xOblTBvKzIDuR1xqPlgcYtE29SXwOIc
	hEIKSCtkMnnzZ+XFUeKSGzrxthTQzl6c9E9WvaeqTXnvqSA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g8xp98xa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 21:56:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 24 Aug 2026 21:56:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 24 Aug 2026 21:56:33 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id C4BCD3F7048;
	Mon, 24 Aug 2026 21:56:29 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v2 net] octeontx2-af: allocate qmem from page allocator to avoid CMA
Date: Tue, 25 Aug 2026 10:26:16 +0530
Message-ID: <20260825045616.3723078-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDAzOSBTYWx0ZWRfX1p8abKbtOAkO
 Tk2C+VTJ0HybzHPzD1P4d7X5kYQ864OH2zJksdzjEGzZvV5PGxdQn/U+XveXlukN3M04CIUVILF
 fQpi0Oum8tLW/SXx5yGgXMtjS0Cem3XZJLSFzUlwZeZLw8hr1sTPUMyuSDKLzWT7uruSIpCya7z
 8XT5Tmwc5XwAcjBeVdvRNKVJiSdn40VRIK0W2d6W41N1UmZPoFVo6aXOK/noIkFtMkei2MJgs8p
 NF1ESYMR4UP8u3SDitxVCOj2aUNBhvHZnryYCh1L/13cNVLVg6LZR43IFtDiRy7H2yfTEZ6a3vN
 NJU3SWEgtD/O2dp+g9u/e/2hV5fzp6PZM1QiwlUG1WubzMqcpUm3WUz/jZxmgoqls8fULA5GAhi
 Oy1YsUQ6CaOA84EcgtFAGMFvusZJDwOlzrNoY7LLMhrau99k9ElmcqdtYCkCcEddFd9IW75atxl
 3vRuFcHPu4YbBu5oSQg==
X-Proofpoint-ORIG-GUID: 1EkdAQL_88yaepTvOVw3YoX_643a3fG_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDAzOSBTYWx0ZWRfX4aElZ/nB/az9
 3NDrvypT+/4DEfWkxU5EN6zvUZPypsJdPgvgh9ui+Cle3AxyA84CmkLm/5M5dvPqQsc7Vi31QAG
 OsKuoVgwxLORI3jtHdXGEspMycKibFw=
X-Proofpoint-GUID: 1EkdAQL_88yaepTvOVw3YoX_643a3fG_
X-Authority-Analysis: v=2.4 cv=A95c+aWG c=1 sm=1 tr=0 ts=6a8d2081 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=JB0Lc2itZwj43V2tWJ8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01

qmem_alloc() uses dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS so
CN10K LMTST regions get physically contiguous DMA memory across page
boundaries.  On platforms with CMA enabled, that attribute causes
allocations to be drawn from the CMA pool.  qmem is used for NIX and
NPA queue contexts, admin queues, and LMTST regions, so the footprint
grows with the number of enabled interfaces and is difficult to
provision in CMA.

Add otx2_dma_alloc_coherent() and otx2_dma_free_coherent() helpers
that allocate compound pages with __get_free_pages(__GFP_COMP),
DMA-map them with dma_map_page(), and retry with GFP_DMA32 when the
physical address exceeds the device DMA mask.  Switch qmem_alloc()
and qmem_free() to use them instead of
dma_alloc_attrs()/dma_free_attrs().

Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/common.h    | 79 +++++++++++++++++--
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index 779413a383b7..30dd882a0149 100644
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
@@ -44,6 +48,70 @@ struct qmem {
 	u32		qsize;
 };
 
+/* dma_alloc_coherent()/dma_free_coherent() equivalents backed by
+ * __get_free_pages().  The region is mapped for DMA with
+ * dma_map_page()/dma_unmap_page().
+ */
+static inline void *otx2_dma_alloc_coherent(struct device *dev, size_t size,
+					    dma_addr_t *dma_handle, gfp_t gfp)
+{
+	dma_addr_t dma_addr;
+	unsigned int order;
+	phys_addr_t paddr;
+	struct page *page;
+	void *vaddr;
+	u64 mask;
+
+	if (!dev || !dma_handle || !size)
+		return NULL;
+
+	size = PAGE_ALIGN(size);
+	order = get_order(size);
+	if (order > MAX_PAGE_ORDER)
+		return NULL;
+
+	gfp |= __GFP_COMP | __GFP_ZERO | __GFP_RECLAIM;
+	vaddr = (void *)__get_free_pages(gfp, order);
+	if (!vaddr)
+		return NULL;
+
+	paddr = virt_to_phys((void *)vaddr);
+	mask = dma_get_required_mask(dev);
+	if (paddr + size > mask) {
+		free_pages((unsigned long)vaddr, order);
+		gfp |= GFP_DMA32;
+
+		vaddr = (void *)__get_free_pages(gfp, order);
+		if (!vaddr)
+			return NULL;
+	}
+
+	page = virt_to_page(vaddr);
+	dma_addr = dma_map_page(dev, page, 0, size, DMA_BIDIRECTIONAL);
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
+	dma_unmap_page(dev, dma_handle, size, DMA_BIDIRECTIONAL);
+	free_pages((unsigned long)vaddr, order);
+}
+
 static inline int qmem_alloc(struct device *dev, struct qmem **q,
 			     int qsize, int entry_sz)
 {
@@ -60,8 +128,8 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
 
 	qmem->entry_sz = entry_sz;
 	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
-	qmem->base = dma_alloc_attrs(dev, qmem->alloc_sz, &qmem->iova,
-				     GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
+	qmem->base = otx2_dma_alloc_coherent(dev, qmem->alloc_sz, &qmem->iova,
+					     GFP_KERNEL);
 	if (!qmem->base)
 		return -ENOMEM;
 
@@ -80,10 +148,9 @@ static inline void qmem_free(struct device *dev, struct qmem *qmem)
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

