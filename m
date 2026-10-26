Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.148.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005814;
	b=ovKzbPcnppwbB4IU7IwNAueZuaAL5cyjXAAB1g/0SItvXjXf/mxhUrwH+q5VtpbEs+PE
	 9Nphhfvjyp67rPyoEMWNaG3r7uMtyE1vtsLxHhj9AUz/7EVqkfq8HbxhkZ0vSDxKgkCcw
	 zmiHlwJ8uiH0aoVpWei8btvVnfwTLubMNzPazaFUkuzNreuQN7C67uf6AA6SQdMSSx2TZ
	 xY5ocAigrEuAXL2a/J1q2jFl2i2SxwOBbf1RfbqKHkFYhPJRX3rD9X0HKExKbepWrAAFY
	 gJq/Siyn30pWU3OYJuIZ7xz84WT/vQkWWIkSadQeYN8jhOG/mqnMN7QkAdpD2cOpIZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005814;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version;
	bh=PZIyRZwFkDCOQpL5jqjYEimFoRMS/EUzAEH+IiIXq5A=;
	b=xrATuH1ZIM2hncLw8C/LIH6DfYX9yRPSnWI528g0Pgjs404Pf3TfIxBu99AX90UGjjvJ
	 F6ANTfjElINOXTV2OBYUL0/po4vYW2fqMahAtU0djChBpCFtgrXek69tBI9kmcZrmZd2C
	 y9gXWPVKir7in03nu6H6kz2rFJ69YzF2UymXIJ5FyuHMYo/gyETbanz9f4zVXaaRDdXPP
	 QHSvBAqZf0MbEbH8wZQr4vgITaiGVIweF7toU1lobOwgYyFlZ1Y2ESH7vRxDBdpYCA23O
	 DDkE/PzVJOe6wkNznCYirmC/eIqvjpBkcGNDNkzG0BLgk/sqg/RgE5Bm181Fw31QYsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=C8uI6F56;
	arc=none smtp.remote-ip=67.231.148.174
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CF3606A31A;
	Mon, 26 Oct 2026 09:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3CF3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=C8uI6F56
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q2NJld1799042;
	Mon, 26 Oct 2026 02:10:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=PZIyRZwFkDCOQpL5jqjYEim
	FoRMS/EUzAEH+IiIXq5A=; b=C8uI6F56yQp2OIKiKZYle3rARGinmS1BiPCXLTh
	hEREc85H9m8g3fcEpJcGNns7DyLKA+kv0to5nECNwWorsB6qOYDUIXtSN4S2qUgh
	t3qxw03xwev8Lp7jVxbSnAMBMdjMbnZQvV2HghGoUYnJt63HL113LM37AYMRxHcW
	b3TCK0E+rEeULrTrebYtOQiBCGz4mXCHDRo+0gMnqD3uAYdE4pWfZiO2TvheioBv
	EOb2W4k8PwSdfE3KsSJrEubsP3EloWA/H7IsM7MHDeC8dKCWmrpzYwGOwq10uMjf
	4B9p6rE3ovrj6bQquxKDYkeNc7qK//RuOBKFJNXo88pGsZA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hhgx92kft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 02:10:06 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 Oct 2026 02:10:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 26 Oct 2026 02:10:04 -0700
Received: from sjc4ccscust-vm07.sclab.marvell.com (unknown [10.110.24.160])
	by maili.marvell.com (Postfix) with ESMTP id 8BDDA3F70A6;
	Mon, 26 Oct 2026 02:10:04 -0700 (PDT)
From: kmahammadraf <kmahammadraf@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Srujana Challa
	<schalla@marvell.com>,
        kmahammadraf <kmahammadraf@marvell.com>
Subject: [PATCH net] octeontx2-af: skip CPT ctx flush command when no CPT LFs are attached
Date: Mon, 26 Oct 2026 09:10:01 +0000
Message-ID: <20261026091001.3421476-1-kmahammadraf@marvell.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=N+O8hG9B c=1 sm=1 tr=0 ts=6adf18ee cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=9lLBhYfolSmS-7XGfIgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: iuGExx8CvH9hCKLU2tYc-5QxYq1Cevop
X-Proofpoint-ORIG-GUID: iuGExx8CvH9hCKLU2tYc-5QxYq1Cevop
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzNiBTYWx0ZWRfX3GmrpafehMDR
 SnIASB+x38AvKwjyZkxZezXFn0ZVI6W8fWo4fyk5J64hKSrzAMYAJAPQLyd8WuC49NWwilZyqCr
 acTipZAm7XrqrUsd1UPeg5pfxqDLiBo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzNiBTYWx0ZWRfX+88mAnNpRIjT
 PxQsANbFpUTyqqeWlX5/V71APkWqMF8xUsCY3CAkJdVA1rLRjoQK4vMmyrZqtIeiIWEpDjuj7Yv
 BFS84/8NNzu2nFOF/qItp5yfqeRRKGQAivu6Vdlx8cY93FFrd6Mwe7PZ4nQfz0PfCwfrjibZNHF
 fOauoPXxoSY+2Uu2zS8PUAPuMbjJqp4D+g8RtDAPYdH1L3AZmnv/YoRtN0X6L0ME2rDf6adtHqW
 VvSXoaDL1pEdvp4NYF6edJVjk3zLEt6WYQS/Ng8i8d/4op03ilCRv8OiHlTdEihfJ8iRF0NwsiL
 3qxgwsIfibQ2+18EvSwiWCUEQLXj3+OWlJjctHspozOuEJsKiT6qoeTRQXueAMdoMyH2T55YVL0
 NSEuNHeQfnuiNlkxV/WHhIPTuDSq7vaM2jrq/GP6WRfBKsxTAzdG7xtcPtmtjR32pQlnunVjEay
 bML+GRFcq5rMu2f029w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01

From: Srujana Challa <schalla@marvell.com>

CPT inline inbound LF command submission was attempted even when no CPT
LFs were mapped to the CPT PF. In that case, sending the uplink mailbox
message is unnecessary and can lead to avoidable failures/timeouts during
CPT context flush flow.

Add a guard in cpt_inline_inb_lf_cmd_send() to check mapped CPT LF count
for the CPT PF and return early when it is zero.

Signed-off-by: kmahammadraf <kmahammadraf@marvell.com>
Signed-off-by: Srujana Challa <schalla@marvell.com>
---
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index f404117bf6c8..751643176c6d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -1144,15 +1144,23 @@ int rvu_cpt_lf_teardown(struct rvu *rvu, u16 pcifunc, int blkaddr, int lf, int s
 static int cpt_inline_inb_lf_cmd_send(struct rvu *rvu, int blkaddr,
 				      int nix_blkaddr)
 {
-	int cpt_pf_num = rvu->cpt_pf_num;
+	int cpt_pf_num = rvu->cpt_pf_num, num_lfs;
 	struct cpt_inst_lmtst_req *req;
 	dma_addr_t res_daddr;
 	int timeout = 3000;
+	u16 pcifunc;
 	u8 cpt_idx;
 	u64 *inst;
 	u16 *res;
 	int rc;
 
+	pcifunc = (cpt_pf_num & RVU_OTX2_PFVF_PF_MASK) <<
+	      RVU_OTX2_PFVF_PF_SHIFT;
+	num_lfs = rvu_get_rsrc_mapcount(rvu_get_pfvf(rvu, pcifunc),
+					blkaddr);
+	if (num_lfs == 0)
+		return 0;
+
 	res = kzalloc(CPT_RES_LEN, GFP_KERNEL);
 	if (!res)
 		return -ENOMEM;
-- 
2.25.1

