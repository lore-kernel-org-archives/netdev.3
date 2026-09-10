Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B8248896;
	Thu, 10 Sep 2026 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020052; cv=none; b=VZpcDDajNkcw7C3BHt6hIiz835ivs9zxXzcbT6Dtj9QP8ETLfkR6r/mDN4LXyiRjUQClgonU5P+WrhhvfeowXZ+idkm/mM/IeWFAWggjJk+GqMAucJZ1cG44N7SlgxpipMUGebyRZjDYhycrDzY7UoweSDMfeOmM/51chNLg1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020052; c=relaxed/simple;
	bh=jj/OL21QB741FYTSFpFmjg6Y9OkjcQaBN4YByoE+hHU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hZZjtRk5ylU44tdMZ3GRboxPTbzRDE5njB0uIdA0arfo0Fzcaa6nxxUNEJLLHUOSN1RNUcrvWQTmwtrEdjd2vwQHw9+40bDgjETBMCswbHh3nG0++ghHEtF+OggKiEbFPYxOm5vgAcSVS61Fc/cl+689YDRvE6j3Jcuj2FTV+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=R/6Jlb0j; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="R/6Jlb0j"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5GF3P1791011;
	Wed, 9 Sep 2026 23:00:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=oijHTblVPyuLC3WGKWMJr+u
	g0iRJ++hVeGgYjrhxby8=; b=R/6Jlb0jucMM2Nl/CC/OYCi0AmQj4u2BQs3i026
	hZxhkxzlNgX/mrhFN44NzZ4+PoRYnuzb85uOAaWHF4OZZ/VrFIvMeYYufIMhHzlx
	skZk2t2/c8YQ52fPvLFjY4IlZ565EVgpvD35r+LPeDF5EnqnIOoRtKbvy+kmrrWK
	4vncnIJJ9/uPs4GLZf+kTr11vsKt8pam5iY1YRTmTv6EXgmZ+B+O9QpUrtRt4uxV
	Sr68Y+BQUDPgQ7IdNxURgSvp9PECI6YzTOSKPJrS9GJZhKez6alsbdebj8y45jNE
	v89dFBSSb7rxo71i3II08sGT5+wOngLIhYRdRb35vmxOXIQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gkcxsjatt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 23:00:40 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Sep 2026 23:00:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 9 Sep 2026 23:00:39 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 9F7D23F7085;
	Wed,  9 Sep 2026 23:00:35 -0700 (PDT)
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
Subject: [PATCH net v2] octeontx2-af: Handle pool context address update in aura WRITE operation
Date: Thu, 10 Sep 2026 11:30:32 +0530
Message-ID: <20260910060032.1209179-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=NrlE4MdJ c=1 sm=1 tr=0 ts=6aa24788 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=oYjgqJuL35MgYmRiCA0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA2MSBTYWx0ZWRfX9c36gNB8l/Zb
 L5qXnUW4gjEjA1COBdaPunOuyxrIf75RiO+3bNIZj8VZJGA3JLQpn4TvJaREaQ5YCQ5pC+V/5V7
 +oVRBaVwiAaY13nmL1qoXFoIGoLMrac=
X-Proofpoint-ORIG-GUID: EDiIGl0AIYMnZUk8NvLH7zGkm-KV4Jfs
X-Proofpoint-GUID: EDiIGl0AIYMnZUk8NvLH7zGkm-KV4Jfs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA2MSBTYWx0ZWRfX0GBqrE/mMMnf
 rVQX8bzpisHWWD0BNEUGVzollHak11sjKdCfb6rltVVdT0ooR0+2U67XWY1Hl0Q91ell+t6hsng
 yG7gbtOWQEkiwDGj8zVMRTP15BBXeLIqnvI+fQ3Ye79do9SFs58fe/ceSQzZ5uKalak/IYXZXF2
 JHgdgRcmOxb7EnAk79bQROKUP608cR7v3vfaF060ijR9yL6r3EA5+zf0vgpc8NBXgdOmidaBmJk
 Mm/RxAOdwTLbUHrD2T16yus4erqgPneqroaDIvhwajscbT+xe7gu2HfISRMdptuFu0PUG7NQAJe
 zhe2ueqM1QTfIzG6NxxuBdPfV0+U89Zff+tQBDyTyE3fS8AyEcN8zC6eAjDeXs/hrwXIi0kGrRj
 qV1RtdoDykEgO8Qa2DChrS2gBpMQM/lsgHhBLptqoN12y+FClgbbh7/DnDuN4sQibSoGVEjLFyJ
 2DCnWT6/Fa4nKPsgcrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01

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
changes in v2:
 - Reject partial aura_mask.pool_addr writes; only translate
   pool_addr to a real pool context address when the mask
   selects the full word
---
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   | 35 +++++++++++++++----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
index e2a33e46b48a..775a3f0b88bd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
@@ -5,6 +5,7 @@
  *
  */
 #include <linux/bitfield.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 
@@ -58,6 +59,19 @@ static int npa_aq_enqueue_wait(struct rvu *rvu, struct rvu_block *block,
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
@@ -116,6 +130,18 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
 	case NPA_AQ_INSTOP_WRITE:
 		/* Copy context and write mask */
 		if (req->ctype == NPA_AQ_CTYPE_AURA) {
+			/* Translate pool_addr only on a full-word write,
+			 * partial masks aren't valid pool_id updates.
+			 */
+			if (req->aura_mask.pool_addr == U64_MAX) {
+				rc = npa_aura_translate_pool_addr(pfvf,
+								  &req->aura.pool_addr);
+				if (rc)
+					break;
+			} else if (req->aura_mask.pool_addr) {
+				rc = NPA_AF_ERR_PARAM;
+				break;
+			}
 			memcpy(mask, &req->aura_mask,
 			       sizeof(struct npa_aura_s));
 			memcpy(ctx, &req->aura, sizeof(struct npa_aura_s));
@@ -127,13 +153,10 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
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

