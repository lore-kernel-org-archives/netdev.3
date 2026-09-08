Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A4538425D;
	Tue,  8 Sep 2026 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849280; cv=none; b=Phs6ebOoszzWo8b8a/qjwocUKeMrIN073WNsiHTytdWKKlGFn/3D+alU4ZlWxVXUro3m2AptkPhdtNz3yfbl9rVB5v8yUXn4oMCrv2p4MMpNPWtQBhLBpc8udO7Akcagg1opxesDViFYU7tunVWW+dHMVV2NfnEzn54grt//bR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849280; c=relaxed/simple;
	bh=Ktk2KN0TJW7rOnwPUs+YPAY/UPuADu0BNS6NYfDiS4Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kAYKpsJcAzwX86F5ltOFvorwcX0bPm8RLo5YSbz2ehbms/I3ZyKw8fKm3YphID7+e9P8CJcmrubSiNndNfgUCuBEpcwGjicsqKPibdFW0u2Yno+rPSNsoM7YZV+ztqSR3xiIANw0WRC6VugPDo6xk7ruF84Y2eGZArnUwb954mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Wrntgdxx; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Wrntgdxx"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886QLCQ3574955;
	Mon, 7 Sep 2026 23:34:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=mQcOOkyLd/4dtQKCxyEN6ci
	PjrLeSB6d6Nfb+ZqvkVE=; b=WrntgdxxMnrj1OyQJidfWYzTZWajPOYxX9G8abm
	2XkUZvwebIV2oPEt8b+EHxYKEzIJ99Zo2wjAu+/tb63zrVuK3tZU0plYW3O/uOhC
	MLb3rNinMf2XAKrm+oyGkJn4Qt96R9AJUA43v7/o+6FujujWZn6rNApNMW22DiGW
	VcTKcbxfFRfjicuqUmasKal+6pJjdU0y5E+/6xCdlgniCbYVCtDO6uE0GTgWMFGH
	eeBrvcw/myTVq1XE/egh5m6aMYOKZdVhu+LHcHsiQvK6yh7ndfpnVtEYG9I+KZo4
	Y2c/tCZLLQDPsMpJEdsQqfA2ZCbJeVyQj1VHC8zR5nMe3/Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gh7b950am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 23:34:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Sep 2026 23:34:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 7 Sep 2026 23:34:21 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 63D363F7051;
	Mon,  7 Sep 2026 23:34:18 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <leon@kernel.org>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v8 net-next] octeontx2-af: switch qmem from coherent DMA alloc to streaming DMA mapping
Date: Tue, 8 Sep 2026 12:04:11 +0530
Message-ID: <20260908063411.257228-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=J/SaKgnS c=1 sm=1 tr=0 ts=6a9fac6e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=c92rfblmAAAA:8
 a=je43RRFQmPAUpNfO2WcA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 8GEAHo4YSitnKIa-SSXp61HUCqmML_tj
X-Proofpoint-ORIG-GUID: 8GEAHo4YSitnKIa-SSXp61HUCqmML_tj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA2OCBTYWx0ZWRfX1AEG7ZRRVQHW
 pG04Jxs8tBYH69XWwIpZWVj4ioCs9pJJ4DGW9iLbKn6A+1d2SYCIpf71vTsjQ2NHHAeb3xHUWTp
 DkNtRHaHd6vhE7TMEExZQYc3J3bGj+kLvTTRLLEoKhLarpCNip3Qt9ieZFMJXXXkLk1g2QjGAL9
 IjTz/1EfkxsOEvQ+WeICb4/nD5CCe+m+SO5sd7UrNCcm773vOPsIeM14YUsyKIuD+RgFaOhWc8j
 eS+bjm9sV7mgFvfBUPQXG4PU+esZFrWFLEWei0JlzePv+KPkc5uPXlv4qO2uhbU+QSP5kjV6IaQ
 hicJd2pyocwUJhom6Sg7DIEwFFxlw3UOs0VniwldzjFhzKUEDOhmdIQsRFE/cZS1hgz2CVf1QDq
 JLJBze6bTPLCoBKGyk6CNrX7howTZ5miP1Iit/G9LqTf+FTl2blFt7Wfw0rO+sPIvtFeMMcAeRX
 mfgDYLhXKsNO+D6ID+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA2OCBTYWx0ZWRfX0Lch3amBP9WR
 8UUJvLU9x9z6UYgU15YG0sgSmF7MyzQ8DcU4JUCe47S3jOH6tUGdGG9BWeoAC7jr2V1OSTtjUxm
 75dXZqM8KvapxNnEESVP5+ZuShOkdFk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01

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

cc: Geetha sowjanya <gakula@marvell.com>
Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v7 -> v8: Addressed Leon comments.
- Replace __get_free_pages() and __GFP_COMP with kmalloc()
- Drop GFP_DMA32 retry loop and dma_capable()/phys_to_dma() mask probing
- Use dma_map_single()/dma_unmap_single() instead of dma_map_page_attrs()
  with DMA_ATTR_REQUIRE_COHERENT
- Remove defensive parameter checks and dma_max_mapping_size() from the
  allocator helper
- Move MAX_PAGE_ORDER validation to qmem_alloc()
- Retain dev_is_dma_coherent() guard in otx2_dma_alloc_coherent()

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
index 779413a383b7..0569b6d9f03b 100644
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
+	vaddr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
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

