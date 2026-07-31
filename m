Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BC7239E80;
	Fri, 31 Jul 2026 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477210; cv=none; b=HdA1nqOqVTKLLKp0QwgCPORBgW59gNtC4UfisfEtrOal+UGKUxyAgJIv7oaD2aqFFWpaK7dyoEXAueJNIYyJ62NOgvoarzLXQhD+xYV6lGWH5S9ym7obMCXnv+/mO9Yn+omg26A1qhsxHw+AI38Avbsevs13Ul7/Gy2MxJ0dJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477210; c=relaxed/simple;
	bh=7w2IzaaUA1BeXue6JhSxWCMuTwrJePOUUbHLbdMGPcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjO6/9WjRGicXjgSw5H0pWOekM0q9x9/giplGjEP0kWouGmTO+iBdNa/VGZPrlb8dcEoZA2lYdvBi+YvaJ9enh3msbBS+JQ0YklH0l4InPDwhoZpVvX6PyLutqr3JQjHM2r6awhqmd1fp/DZ69W4+rch767fZTIvlrd5mJwEtX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=X3nw9QDm; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="X3nw9QDm"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V50CPo2827495;
	Thu, 30 Jul 2026 22:53:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
	02rlHNJdLSG56b+d/VG4iN7mdggz52P+TzSOS5Q0hA=; b=X3nw9QDmT2v0rUQ4t
	ocUqt/vops/5KLqsVYooKc7LmJP+jsdOlEe36P8jBibZWQJmb4kblTUGFrhtJ0Um
	EbBqg9s6WE8eVvojcLEx01B4m4QGzLFcIGFqWyO4zmIOZdx9eDdTjFlBEa+rIfHM
	ym4lfUiIGfenl9DDV3LBkf8ow91csiaD5qvHucvas44bOjH9iuuq4+riOEuiKQvp
	We8PbX1ZgbuVFVRv+QZA+g4HeWn1zx5DZSK3QKIWIKGE8Q+K58IXITQh2QWyuzub
	VUEaMANP9XGjDrRBDL+mSiPoZJ2XLj9YfGi0e6C2OsQi8W4EcGTTmt2rpc+is3n6
	xbUXg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4frcw59gxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 22:53:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 30 Jul 2026 22:53:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 30 Jul 2026 22:53:20 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id 843673F7074;
	Thu, 30 Jul 2026 22:53:16 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v2 1/2] octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled
Date: Fri, 31 Jul 2026 11:23:09 +0530
Message-ID: <20260731055310.1229213-2-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731055310.1229213-1-subratp@marvell.com>
References: <20260731055310.1229213-1-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAzOCBTYWx0ZWRfX9DvsVYqf36Y8
 Ymb6aGSL1QrRYXJK5V1ieY5zuU8Qk1rsuvrspmsJ06RnQo0q7eb6DaTNZmj2m3mHCGrU8wiv/bq
 3hThgze+dxJcTNtd/Ydb/0HOE6FzCfY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAzOCBTYWx0ZWRfX6UbSvjXW0sOI
 WKvXOch23qgpLRRDvRnKIPNL4nGtO0vziY4HS9GPFCai5w3ibNF4k+Ho/vwTGEaxA1DQ6hrKaIS
 aUyMfw+qHTCCHqXrAKfPi+zPoBJ6slh2fVbzEpJIt8t6nATHfncw6j1EaIej1UWXk6kgw0WS6cK
 5cPCZeYTJrV6AYZ8fOI5SB3myHzU/v2M33EE1gYB169twYN/ooVaXLtTJRy5seqtlumZBzqNGKV
 c89JK0rqutjCIlHHZDF6HtoRQB3FYwRtdtvnS57qztAHgpXqWXYrgxhKt7HrUsTNhVbf16Nakm8
 wRSbTJ3zVg5O7nRPHVUs4YIAt7oBlCXoiwY6lCqxzrKRLS/ICX+uzWHS0TiETHE057bNN7KIZrJ
 DZIlfXVex+Hc8P0h4bHTOEABqaId7IDo4cYpJot0BL0Wy/0yHFGbQprZFhMaBELtSmG9ezFhi4N
 b8nuvDRmhU6i0hP1dsw==
X-Proofpoint-ORIG-GUID: U58eIQqSfbUS_XNDwgHJBYvtcBwQcBJN
X-Authority-Analysis: v=2.4 cv=C5bZDwP+ c=1 sm=1 tr=0 ts=6a6c3851 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=MZaZBdy3eYgu71wtW0YA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: U58eIQqSfbUS_XNDwgHJBYvtcBwQcBJN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01

From: Geetha sowjanya <gakula@marvell.com>

Previously, BPID assignment under CONFIG_DCB assumed
`queue_to_pfc_map` was always initialized. For SDP VFs this leads to
invalid memory access as it was not initialized.

This patch adds a NULL check for `queue_to_pfc_map` before
dereferencing it. Also, simplifies the logic by always assigning a
default BPID first, then conditionally overriding it if CONFIG_DCB is
enabled and the map exists.

Fixes: 184fb40f731b ("octeontx2-pf: Avoid adding dcbnl_ops for LBK and SDP vf").
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Subrat Pandey <subratp@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c  |  8 +++++---
 .../ethernet/marvell/octeontx2/nic/otx2_common.c    | 13 +++++++------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
index dbf173196608..f3903cce9bf7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
@@ -245,10 +245,12 @@ int cn20k_register_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs)
 static u8 cn20k_aura_bpid_idx(struct otx2_nic *pfvf, int aura_id)
 {
 #ifdef CONFIG_DCB
-	return pfvf->queue_to_pfc_map[aura_id];
-#else
-	return 0;
+	if (pfvf->queue_to_pfc_map)
+		return pfvf->queue_to_pfc_map[aura_id];
+	else
+		return 0;
 #endif
+	return 0;
 }
 
 static int cn20k_tc_get_entry_index(struct otx2_flow_config *flow_cfg,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 3d253132a17f..b4691472d2a3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1132,10 +1132,10 @@ int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
 		if (!is_otx2_lbkvf(pfvf->pdev)) {
 			/* Enable receive CQ backpressure */
 			aq->cq.bp_ena = 1;
-#ifdef CONFIG_DCB
-			aq->cq.bpid = pfvf->bpid[pfvf->queue_to_pfc_map[qidx]];
-#else
 			aq->cq.bpid = pfvf->bpid[0];
+#ifdef CONFIG_DCB
+			if (pfvf->queue_to_pfc_map)
+				aq->cq.bpid = pfvf->bpid[pfvf->queue_to_pfc_map[qidx]];
 #endif
 
 			/* Set backpressure level is same as cq pass level */
@@ -1433,10 +1433,11 @@ int otx2_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
 		 */
 		if (pfvf->nix_blkaddr == BLKADDR_NIX1)
 			aq->aura.bp_ena = 1;
-#ifdef CONFIG_DCB
-		aq->aura.nix0_bpid = pfvf->bpid[pfvf->queue_to_pfc_map[aura_id]];
-#else
+
 		aq->aura.nix0_bpid = pfvf->bpid[0];
+#ifdef CONFIG_DCB
+		if (pfvf->queue_to_pfc_map)
+			aq->aura.nix0_bpid = pfvf->bpid[pfvf->queue_to_pfc_map[aura_id]];
 #endif
 
 		/* Set backpressure level for RQ's Aura */
-- 
2.43.0

