Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2791647D45C;
	Tue,  1 Sep 2026 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259895; cv=none; b=hkJJ/WzvnaV3QrnCO5fx0VePS47o3Dlhaq77RC+/F7kak46OHOolE/7/BtU9I0KtdXvjCoEAfpZ50KPWVsGAMh6lfDLHyzTX+toI3EwhA1pdYKnXWXdHiFufWHBcKe0h99RaVHdAMIYF/5AbiU07g9SluSRKGG5juAFdqUndSiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259895; c=relaxed/simple;
	bh=hi41lTusoffjhTZAD0tq3vk7nErR3nPjLxtFLNzwKm8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TSL5AyTB57q3IIpy494AzGDF+y7Q+QnurjaKoDmsUnmBfSY1tsxY3rqLsmncZt68NtmS8cGJlFf4HJfePuU2+riCf1G02EzvM/ct3ksxW/SMsp3rmdvqfzeW7G2C8kaLBreQnTYvAnQG5oZBv8HekJX3dmSf3bEeH/WMeZmiGV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TVOdq6ZY; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TVOdq6ZY"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AKqFh3759477;
	Tue, 1 Sep 2026 03:51:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ZeRP+oyC6wzCwcrc/jXVnPD
	zSEE2PZQ+WsB499yE34g=; b=TVOdq6ZYkk8yfiQQaH/Cww+vfDRqUSLhItjinKR
	CDjbCNK9lgI8AMGuiDWlNhhennFEPdH1PupEjnX31LnGenjEjuP9HJzeu49CffEH
	r1pwIeS8vXguOVUA82zhzAd6AUbSgGWgUpzLvtQLFz036WRtWy0bfTALhjeNprlR
	gDkpDpugsaPb5GZUhAnEyJ1pJE5eSy9/IvyNRypRyK0ib4X+qsPRZ5vOMZNU617p
	OpmE3sQSXJ/rjdXQK2QZ4rJrGihIucKm3wT2d0pyf6hUGpqvTPl5880GMQjtD+81
	Ir5dLAsTEynhAUUXozc5c5mD062oSkt75GFO6vUzkzjHlVg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gbxxj7k33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 03:51:21 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Sep 2026 03:50:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 1 Sep 2026 03:50:35 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id F044D5B692B;
	Tue,  1 Sep 2026 03:50:31 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Ashwin Sekhar T K <asekhar@marvell.com>,
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
Subject: [PATCH net] octeontx2-af: Handle pool context address update in aura WRITE operation
Date: Tue, 1 Sep 2026 16:20:28 +0530
Message-ID: <20260901105029.1667495-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA5NiBTYWx0ZWRfX/mY13Q913t7H
 FsLGcMG9p61/TsQqzQwiE3ESRnZ6/OFh88o2rqwqjVSVGzYsf4Wci9iiETT6z47CMDJeHR60oex
 TbTZW4C/a3I8F6/oUlczBGIpp7zoLpk=
X-Proofpoint-GUID: qS3CxKWfKQ_bPOI99SOh2dcufcsnV0dM
X-Proofpoint-ORIG-GUID: qS3CxKWfKQ_bPOI99SOh2dcufcsnV0dM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA5NiBTYWx0ZWRfX9woRZwVQupEq
 k4Yh1jmxkt0r0R/qmXKAvoximYliES174CLWFsdBFNE+vzz9ri0stbybDdwQ7YNaIho4R2bK9p3
 D2by5r2kAqfNNRs9RqvyyzgISDeunPDJCG24OTGAjOTR8UNENWQP8eIUsT3/NDu1SGw1j4O3uJ0
 8fNG4MLrJrxNMMrtrOfEv/wZtJATLgB39dGimFp4JHg6qpR09PJJknR/MBFPZwm9NSjqr3l6qex
 //TvSJmMEF9eRb5asNW62mtu02b/99UeLI2eNcnChnnvpcbv/CqKxDWjZU1PRMC63mXAf4GYgUC
 LdeZdnweHMJ3GzJIz5ixO6ooCRpfDeFfCliQOg62A5HAmFIfdwLJRypKr1L51mD5JOI6gCBW0hW
 aXhlJtj6tT+uXtyyjlu0RBGgEILqjP1PBkcxqhk+0+gHVxS2yTlG1PjqAVTPGT/tfmUkbdGRtb1
 E+J5qvXSuOI7wfrbSog==
X-Authority-Analysis: v=2.4 cv=QuJuG1yd c=1 sm=1 tr=0 ts=6a96ae2a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=3GIVawZG688hLDf85coA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01

From: Ashwin Sekhar T K <asekhar@marvell.com>

The NPA AQ WRITE operation for aura context was not translating the
pool_id in aura.pool_addr to the actual pool context IOVA, unlike the
INIT path which already did this correctly.

Add a helper npa_aura_translate_pool_addr() that validates pool_ctx,
checks bounds, and performs the pool_id to IOVA translation. Use it
in both the WRITE and INIT paths to fix the missing translation and
avoid code duplication.

Fixes: 4a3581cd5995 ("octeontx2-af: NPA AQ instruction enqueue support")
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Ashwin Sekhar T K <asekhar@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
index e2a33e46b48a..c8255271f84e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
@@ -58,6 +58,19 @@ static int npa_aq_enqueue_wait(struct rvu *rvu, struct rvu_block *block,
 	return 0;
 }
 
+static int npa_aura_translate_pool_addr(struct rvu_pfvf *pfvf, u64 *pool_addr)
+{
+	if (!pfvf->pool_ctx)
+		return NPA_AF_ERR_AQ_ENQUEUE;
+
+	if (*pool_addr >= pfvf->pool_ctx->qsize)
+		return NPA_AF_ERR_PARAM;
+
+	*pool_addr = pfvf->pool_ctx->iova +
+		     (*pool_addr * pfvf->pool_ctx->entry_sz);
+	return 0;
+}
+
 int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 			struct npa_aq_enq_rsp *rsp)
 {
@@ -116,6 +129,12 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 	case NPA_AQ_INSTOP_WRITE:
 		/* Copy context and write mask */
 		if (req->ctype == NPA_AQ_CTYPE_AURA) {
+			if (req->aura_mask.pool_addr) {
+				rc = npa_aura_translate_pool_addr(pfvf,
+								  &req->aura.pool_addr);
+				if (rc)
+					break;
+			}
 			memcpy(mask, &req->aura_mask,
 			       sizeof(struct npa_aura_s));
 			memcpy(ctx, &req->aura, sizeof(struct npa_aura_s));
@@ -127,13 +146,10 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 		break;
 	case NPA_AQ_INSTOP_INIT:
 		if (req->ctype == NPA_AQ_CTYPE_AURA) {
-			if (req->aura.pool_addr >= pfvf->pool_ctx->qsize) {
-				rc = NPA_AF_ERR_AQ_FULL;
+			rc = npa_aura_translate_pool_addr(pfvf,
+							  &req->aura.pool_addr);
+			if (rc)
 				break;
-			}
-			/* Set pool's context address */
-			req->aura.pool_addr = pfvf->pool_ctx->iova +
-			(req->aura.pool_addr * pfvf->pool_ctx->entry_sz);
 			memcpy(ctx, &req->aura, sizeof(struct npa_aura_s));
 		} else { /* POOL's context */
 			memcpy(ctx, &req->pool, sizeof(struct npa_pool_s));
-- 
2.48.1

