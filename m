Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED3A23C8AE;
	Wed, 22 Jul 2026 04:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784693013; cv=none; b=mb3Q1MCKIv7VVofRuaUCO12Bwb6iq5hHPqPl9s8KZAVTXtWxhGbN1pS5g6lDNMg2qJ8WrgK6cfedWhcO+sv3Mrhj9qv14H8O62ANogSZ/u7iv5nIQmlHTE9ube8goz7V654Tp/mEPVEeX2T2t1S8MIYqR1XCdoqURDGa9Vv3Ado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784693013; c=relaxed/simple;
	bh=y/LSdUeDnWWFWVQ68Mi/8JsECuOOqZDPZDX+G1134uo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sppz8aRxGunGlR5/a8hXc+TLqMkP/27iVaUVWObCF7O8KK70Yl1jaN35qpsrfMGuJSfRADoxNdjjyzNKeJj8B9Rr1UKCbRWhT/uClMthlM3SYF1w1mjO1hsZoSlMg9aDIMalVYsg5gKHBQsOcD8Y3PU0CPAHLX5VRGJAX6L2x0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CguN28dn; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CguN28dn"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M1FjB61622687;
	Tue, 21 Jul 2026 21:03:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=q5Pkkigv/gR/ymyzxwgRJVJ
	+WgbUfuq+vOStFuXyFM0=; b=CguN28dncB+UPx0Pm0EVI5BHivxchGfM1JZGWRX
	MPyzQ1gE8ruMgkDuhroOYSclgwh0VYc6LK2e01/Nbg15ewMHEhYWQbQzrp7Xh/GZ
	T4xlaqDWkVRUJI/pQBKixsF5vmAUNNIBMMhCizSsDKbgUJiwtanp7Rc8BrlmKLUx
	vws9gWMmROx9pEr52SzPnQDQ3aVP724Xk3Ea6k666mS8Fw4fBfBAT3zn7Ye4I2FD
	kAXXbnQGUnNiOn7Io1A4b4WddkCmoNijALCA11zdZ1ztGWw1U3Iv/PSG4BUCqrPE
	U/DgbYu/PjH7bCygPYvsZodG8PqpV/H4npXn1a0gftk6FEg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fjjf88g5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 21:03:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 21 Jul 2026 21:03:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 21 Jul 2026 21:03:15 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id BC3F93F7044;
	Tue, 21 Jul 2026 21:03:11 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
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
Subject: [PATCH net-next v2] octeontx2-af: Use LMAC_AF_ERR codes in CGX handlers
Date: Wed, 22 Jul 2026 09:33:07 +0530
Message-ID: <20260722040307.3393236-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YxKk8JAHpl4Ziqmak3NpAtf42e-EF9lb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDAzNCBTYWx0ZWRfXxYS3Qnhc29Nw
 erGOVNHp8AZzpsjCOVz36cEGBdX+Y+SzapehTcMJghJ7HjBqs97zVsdWkVrXNEn03qLsNsHoCnO
 XImlfzaHiBNUwd/Prxz6nTYXMONGiMI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDAzNCBTYWx0ZWRfXw38QrnjC86HJ
 Xf3yUyyQPY66HCuXRTWHwhZ61BKUWk8lRkU0Fo+UnMCIoiWwPHQHBRAY7ow468GU0nQzuYbmcr5
 CtTXM61vnvtxx6Xms9oLs0SJN+rRE6CnpqmuNZohrDz6bUzlyqKkVFYviJT94q9rqCCkqn8NOfG
 TKzsfnVe9Uut2ucXfJVqwsU8/8bKUh1e29mBW3OxjqBKBmMASJvzsupd7Og/5isHnMMQu0Xigym
 Kvd0D6VgyciwSX5WO8zkRmNLThugn2FXUsg9NOXG4SsDj1716h0r5YsotS6vso0zl7p0gT4PX8e
 peLLopnWziPYp7NqDujvmoLTlLajxb4ByVT6Psjvn4ou9K9XoSDSxO+57CmIRE4BBXWaaW2lCfn
 3C4EmVd1oY4PO2XlCZCyCB2YlHCDN9Hm3wO7OHaU2rXth5APIDcOVorQaqqgux1EWx8dekwsW1c
 6/Ndpf2qKk3h6hO+83Q==
X-Authority-Analysis: v=2.4 cv=Rov16imK c=1 sm=1 tr=0 ts=6a604104 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=-5HDdqy3Crg6To4yp_AA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: YxKk8JAHpl4Ziqmak3NpAtf42e-EF9lb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_01,2026-07-21_01,2025-10-01_01

From: Hariprasad Kelam <hkelam@marvell.com>

When a netdev that is not mapped to a MAC block (cgx/rpm) requests a
MAC feature, the AF driver currently returns generic errors like -EPERM.

Replace these generic error codes with driver-specific LMAC_AF_ERR_*
error codes to provide better debugging information.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>

---
v2:
 - Fix rvu_mbox_handler_cgx_start_linkevents() and
   rvu_mbox_handler_cgx_stop_linkevents() to propagate the return value
   of rvu_cgx_config_linkevents() to the caller instead of
   unconditionally returning 0.
---
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 26 +++++++++----------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 4ff3935ed3fe..61126afefe2b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -709,7 +709,7 @@ int rvu_mbox_handler_cgx_mac_addr_add(struct rvu *rvu,
 	int rc = 0;
 
 	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	if (rvu_npc_exact_has_match_table(rvu))
 		return rvu_npc_exact_mac_addr_add(rvu, req, rsp);
@@ -732,7 +732,7 @@ int rvu_mbox_handler_cgx_mac_addr_del(struct rvu *rvu,
 	u8 cgx_id, lmac_id;
 
 	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	if (rvu_npc_exact_has_match_table(rvu))
 		return rvu_npc_exact_mac_addr_del(rvu, req, rsp);
@@ -789,7 +789,7 @@ int rvu_mbox_handler_cgx_promisc_enable(struct rvu *rvu, struct msg_req *req,
 	u8 cgx_id, lmac_id;
 
 	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	/* Disable drop on non hit rule */
 	if (rvu_npc_exact_has_match_table(rvu))
@@ -808,7 +808,7 @@ int rvu_mbox_handler_cgx_promisc_disable(struct rvu *rvu, struct msg_req *req,
 	u8 cgx_id, lmac_id;
 
 	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	/* Disable drop on non hit rule */
 	if (rvu_npc_exact_has_match_table(rvu))
@@ -877,7 +877,7 @@ static int rvu_cgx_config_linkevents(struct rvu *rvu, u16 pcifunc, bool en)
 	u8 cgx_id, lmac_id;
 
 	if (!is_cgx_config_permitted(rvu, pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 
@@ -895,15 +895,13 @@ static int rvu_cgx_config_linkevents(struct rvu *rvu, u16 pcifunc, bool en)
 int rvu_mbox_handler_cgx_start_linkevents(struct rvu *rvu, struct msg_req *req,
 					  struct msg_rsp *rsp)
 {
-	rvu_cgx_config_linkevents(rvu, req->hdr.pcifunc, true);
-	return 0;
+	return rvu_cgx_config_linkevents(rvu, req->hdr.pcifunc, true);
 }
 
 int rvu_mbox_handler_cgx_stop_linkevents(struct rvu *rvu, struct msg_req *req,
 					 struct msg_rsp *rsp)
 {
-	rvu_cgx_config_linkevents(rvu, req->hdr.pcifunc, false);
-	return 0;
+	return rvu_cgx_config_linkevents(rvu, req->hdr.pcifunc, false);
 }
 
 int rvu_mbox_handler_cgx_get_linkinfo(struct rvu *rvu, struct msg_req *req,
@@ -915,7 +913,7 @@ int rvu_mbox_handler_cgx_get_linkinfo(struct rvu *rvu, struct msg_req *req,
 	pf = rvu_get_pf(rvu->pdev, req->hdr.pcifunc);
 
 	if (!is_pf_cgxmapped(rvu, pf))
-		return -ENODEV;
+		return LMAC_AF_ERR_PF_NOT_MAPPED;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 
@@ -975,7 +973,7 @@ static int rvu_cgx_config_intlbk(struct rvu *rvu, u16 pcifunc, bool en)
 	u8 cgx_id, lmac_id;
 
 	if (!is_cgx_config_permitted(rvu, pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 	mac_ops = get_mac_ops(rvu_cgx_pdata(cgx_id, rvu));
@@ -1178,7 +1176,7 @@ int rvu_mbox_handler_cgx_set_fec_param(struct rvu *rvu,
 	u8 cgx_id, lmac_id;
 
 	if (!is_pf_cgxmapped(rvu, pf))
-		return -EPERM;
+		return LMAC_AF_ERR_PF_NOT_MAPPED;
 
 	if (req->fec == OTX2_FEC_OFF)
 		req->fec = OTX2_FEC_NONE;
@@ -1197,7 +1195,7 @@ int rvu_mbox_handler_cgx_get_aux_link_info(struct rvu *rvu, struct msg_req *req,
 		return LMAC_AF_ERR_FIRMWARE_DATA_NOT_MAPPED;
 
 	if (!is_pf_cgxmapped(rvu, pf))
-		return -EPERM;
+		return LMAC_AF_ERR_PF_NOT_MAPPED;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 
@@ -1226,7 +1224,7 @@ int rvu_mbox_handler_cgx_set_link_mode(struct rvu *rvu,
 		return LMAC_AF_ERR_FIRMWARE_DATA_NOT_MAPPED;
 
 	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_idx, &lmac);
 	cgxd = rvu_cgx_pdata(cgx_idx, rvu);
-- 
2.48.1

