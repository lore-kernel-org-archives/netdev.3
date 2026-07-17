Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A134301719;
	Fri, 17 Jul 2026 05:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784265158; cv=none; b=DBseknpcraqGMNDPf2eG/iTKz26rQVV/Pua1U6nrhM4GR6mEVfy3XZnovGcsBfUz1sapEAsJ4wxcyPvSdjaniMSEWXX/tBZOgGdroPFDFV9MPZ02L0+ivQsbsbLOi3JeotovXk+fO9YZU6gT3rSrzSqWdUC4pkMPMUZczkDL9TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784265158; c=relaxed/simple;
	bh=d/LWPaCJUqdjv7f+9cFrD1OQhfs7NhtxdqU3y36cj7Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JnHsW/ZNtgl7ZUmD1bImM4bvH8xg/cOIfRg5MGw1LhSjAzKyPq3cj2f8+PVVOpCDOc1uu36s453Ior8sE9j1WitlrXQIKuJLNyQA2M3+xKhCfVltQToPd1CeBJko6vZRmbhMKq/2RUWmobPvQPduSC2j7BExfBvnBsIhl7UmuCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EtKnQI+S; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EtKnQI+S"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H37iZc3062953;
	Thu, 16 Jul 2026 22:12:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=um8QIwYqVbkW2svWJg2tDQh
	QZiIgPbsXdgReCDAWcPY=; b=EtKnQI+S+4setkbA5L8RxhuHswCzKxqZ/7CAP8C
	3A61G5GuaKUXaXpfdlS9DNCO1kKVLCNLB/T6Uehibqf9tmAF6YCkbtHzI9r49tjt
	IY0ouDYhboznRy7PgoVpgU/vl1yHwXL3ZHP6e8ru6jhO8fYTfGmkSULdxETPydhY
	iiRIfru3BVFAxyrLc7DR41/LyypCej+jFu8aRKfbDVsjZd6JToy6VRr4yg61GYsY
	ntm0Lq3NNbenrLRiztYnoNYDQtX8qtgQZEOpOCyx5HfolpHxZ1pz9t3PrbrXOWkk
	PQCiKUHKVmLZhlywGN6IYYkGwAQWVFlHmptldD5pkdGxX4Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4feddnp156-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 22:12:15 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 16 Jul 2026 22:12:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 16 Jul 2026 22:12:14 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 867CE5B693C;
	Thu, 16 Jul 2026 22:12:10 -0700 (PDT)
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
Subject: [PATCH net-next] octeontx2-af: Use LMAC_AF_ERR codes in CGX handlers
Date: Fri, 17 Jul 2026 10:41:57 +0530
Message-ID: <20260717051157.1418508-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: xvCcRKLTGeUpEiH9PQYpW8UoOqxNMh1Y
X-Proofpoint-GUID: 7Pzt3Erlmn_2wQDnwpeosYnTu7CVbQIR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA0NyBTYWx0ZWRfX2V3A6EVoP0wc
 guMrRMKHoT+WbZKNC2KxoQ8/f6VT/mVh0hHRlk8HRHOPZ2GZJbG9Nh5vOjn6m2J/pc9HB37ppqN
 HmukSR0bGsj2QyfNpZcWVnnS0+8KUBc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA0NyBTYWx0ZWRfX/new4a9Tr3DF
 x9ne2godZtSJF5ElVDVhENBC53rrzLiba9CgPy7/fKHrZzq7Aopz9CGrjz+J4CsOeY0wQ44/PNR
 rZSmrZPWoqKV7kUmHNo22S8ld3f3iK7e8Q54SmlL4fdz7OevOHwxCpd39+YXBzMVpuSxeEMfpWQ
 hC9wf6Yh5iOyBr+h0wZq2YfBDC8/rQdYidsM2n7qrTumRmg3UNb7Sk2D9Lh/WCkwuMspvalfpBm
 grKe/f+1PBwFvk+5sqXTx41Gio6CcUopJcBtMBveyiXgX+Vw+GJO9fPq8kjE4oT/fg2W4/A0EDG
 JwAJFBAz1x4p7VpZNDjRt+eic1kpmka6BVpnqAXAT7SoVIWZknUi/7c6VgB+/SwgrF4UUW0bU7E
 d4p7SrLlwdIzS/5JIq23k1L+cPpD81qY6JQ/YtRtmMnKJLcxkayN+t8miFRALkQf9KVNz+Hy6Jq
 kMOaPFgoyI756NjtF1A==
X-Authority-Analysis: v=2.4 cv=a5AAM0SF c=1 sm=1 tr=0 ts=6a59b9af cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=eiSpelsGC-AfaHloDKMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_01,2026-07-15_02,2025-10-01_01

From: Hariprasad Kelam <hkelam@marvell.com>

When a netdev that is not mapped to a MAC block (cgx/rpm) requests a
MAC feature, the AF driver currently returns generic errors like -EPERM.

Replace these generic error codes with driver-specific LMAC_AF_ERR_*
error codes to provide better debugging information.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 4ff3935ed3fe..5558bb66bf9f 100644
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
 
@@ -915,7 +915,7 @@ int rvu_mbox_handler_cgx_get_linkinfo(struct rvu *rvu, struct msg_req *req,
 	pf = rvu_get_pf(rvu->pdev, req->hdr.pcifunc);
 
 	if (!is_pf_cgxmapped(rvu, pf))
-		return -ENODEV;
+		return LMAC_AF_ERR_PF_NOT_MAPPED;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 
@@ -975,7 +975,7 @@ static int rvu_cgx_config_intlbk(struct rvu *rvu, u16 pcifunc, bool en)
 	u8 cgx_id, lmac_id;
 
 	if (!is_cgx_config_permitted(rvu, pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 	mac_ops = get_mac_ops(rvu_cgx_pdata(cgx_id, rvu));
@@ -1178,7 +1178,7 @@ int rvu_mbox_handler_cgx_set_fec_param(struct rvu *rvu,
 	u8 cgx_id, lmac_id;
 
 	if (!is_pf_cgxmapped(rvu, pf))
-		return -EPERM;
+		return LMAC_AF_ERR_PF_NOT_MAPPED;
 
 	if (req->fec == OTX2_FEC_OFF)
 		req->fec = OTX2_FEC_NONE;
@@ -1197,7 +1197,7 @@ int rvu_mbox_handler_cgx_get_aux_link_info(struct rvu *rvu, struct msg_req *req,
 		return LMAC_AF_ERR_FIRMWARE_DATA_NOT_MAPPED;
 
 	if (!is_pf_cgxmapped(rvu, pf))
-		return -EPERM;
+		return LMAC_AF_ERR_PF_NOT_MAPPED;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 
@@ -1226,7 +1226,7 @@ int rvu_mbox_handler_cgx_set_link_mode(struct rvu *rvu,
 		return LMAC_AF_ERR_FIRMWARE_DATA_NOT_MAPPED;
 
 	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
-		return -EPERM;
+		return LMAC_AF_ERR_PERM_DENIED;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_idx, &lmac);
 	cgxd = rvu_cgx_pdata(cgx_idx, rvu);
-- 
2.48.1

