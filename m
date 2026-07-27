Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36BC3F39C8;
	Mon, 27 Jul 2026 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147392; cv=none; b=sRfkv7c2GO7nGbHgrtYAJmFHfjsSp77eLkeE/YI5nAmbznSlA3c6SoDCdgl91UtuRRjP6Meu/bMfVFCTDC8XINbp4NP7zedtHYKzHh+tF1OP3Bd98/ifF6M4z6q600cpzANeI4XRHeS4/tiY3FqCqhCdXl80taq3dTcEZiw61eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147392; c=relaxed/simple;
	bh=o7FyTBbL3mhtNnJmIsKYs4Lu4DCXqHhAH5v7njg2+jE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dyl2e76EADDAvd6tG3tL51YhbNvQsRnzsSXNtbvgdVA020ot2sZqXdpxo60/xNOEr+UTxgNEsGFpj6S40l2RNLq/bQMwOFBEF506byCQR0co5a1sM8nrE5NKAnOGVBojW6pK5UklFcXnAgx3g/jf4N7pc9X6Zpv+wxJY2IZszoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JUVpXSsz; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JUVpXSsz"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R7UVCN596548;
	Mon, 27 Jul 2026 03:16:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=FY/F3H1n8oGrT7UH/gUu4hm
	cIZwHreoC3DkT7Bu2Or4=; b=JUVpXSszJIc2DGcEsVuJ7yFRPxw6TGr/o5M1+Is
	95RDsXuD4N47RCszr4OMvpsWZ2wgMiazrAufSaC4T69Wnzr0JTI4S+3wgq8n9LQy
	nCNq/wpVUAVc6sQenoaDfvii6HnT112+FBe4EZmNBY0Mnko5qcfMKF19ElWdtltx
	+zLg3DlRQ3Etm+SeMZ5Oux/eoA9Thz5Jix9dqfdwWfi1l+zTLHYwnXiiGQ+jyDqX
	eV49zegWCyNXJ4iJHctWCOrJvLQx+Pdkb9DJC7kS6iEZ45Jmth1KCtqANMgMkp1m
	LcLMhOZzIbQGD/nIxDInoXkNkOtVtPW8/wuwqqwAMEdgIpw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fmvnekj2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 03:16:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 27 Jul 2026 03:16:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 27 Jul 2026 03:16:21 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 5CEC93F703F;
	Mon, 27 Jul 2026 03:16:18 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Satha Rao
	<skoteshwar@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v3 net-next] octeontx2-af: add new mbox to support sync cycle on rx path
Date: Mon, 27 Jul 2026 15:46:08 +0530
Message-ID: <20260727101608.300290-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEwMCBTYWx0ZWRfX4kDE2Ur1ZMmS
 aWKwg1d52LSdVGjBZ+muzxBmg3DPPsqSy7By9V2E9yBTYhfmLYhxShCv7XSFO/q4Ls/8XYO2YnH
 0BSo/DAHmBWu7RyQnnL2RVVj9dfcDvc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEwMCBTYWx0ZWRfX52BkXlsiqMQr
 9lmdVEVEsRRU4zvtB1LcOMyfxUGTs8BY1NjOR/4F4BYZH2gQvpV9cTlnXHO+ccFIrAE6WGhgw+0
 ZFn1mC/K4o7JAfdz5z8PcGc9pvoEKnkBsEZwynRnO7hJJuxmUa68FxQKiJGmscBO4KxzeEPIzIK
 tHihwyqgOlSnOFiqFkemdYmC5810bL6x3fWPgDgQAT2bDOdOxfXtKPiS37DStv4V7jxlxE44KXC
 QkyBXtpD/y36tECcYcsHBST5zNuMqyTlFGbVVMtVdOxuUzL8DVp01pQ1PnRc3K9dZyGxG7zbBss
 UkEr+nf0wU0fK0GtgB6EAonq11C6yliC/HLdd9SkQp4ibFOCRmhceFjvy7nRc6JbtEF5BUPMJIl
 P8/biuPmY7PLC+7AFGsu9nu3+nCXqpnooeUZWzbiGDhlNKgzT9f5gdUym9O3rCkV+YvqvRCGC8+
 PvIzEYWSv6XOM5uRUGg==
X-Authority-Analysis: v=2.4 cv=e5A2j6p/ c=1 sm=1 tr=0 ts=6a672ff5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=0iagpPcjLyzhSgOJ4cUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: RYrW5TlxpTp7YHUYC7qGhfNCRujHC84V
X-Proofpoint-ORIG-GUID: RYrW5TlxpTp7YHUYC7qGhfNCRujHC84V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01

From: Satha Rao <skoteshwar@marvell.com>

sync ensures that all packets that were in flight are flushed out to
memory. This can be used to assist in the tearing down of an active RQ.

To complete disabling RQs or disabling SMQ and its SQs, LF software
send mbox to AF to complete RX_SW_SYNC.

Both VF and PF and invoke this mbox.

Signed-off-by: Satha Rao <skoteshwar@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v2 -> v3: Addressed Simon comments
	https://lore.kernel.org/netdev/20260715041239.2052888-1-rkannoth@marvell.com/
v1 -> v2: https://lore.kernel.org/netdev/20260715041239.2052888-1-rkannoth@marvell.com/
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  2 ++
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 31 +++++++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 10552e9cf519..73f743e4a83d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -362,6 +362,7 @@ M(NIX_CPT_BP_ENABLE,    0x8020, nix_cpt_bp_enable, nix_bp_cfg_req,	    \
 				nix_bp_cfg_rsp)				    \
 M(NIX_CPT_BP_DISABLE,   0x8021, nix_cpt_bp_disable, nix_bp_cfg_req,	    \
 				msg_rsp)				\
+M(NIX_RX_SW_SYNC,	0x8022, nix_rx_sw_sync, msg_req, msg_rsp)		\
 M(NIX_READ_INLINE_IPSEC_CFG, 0x8023, nix_read_inline_ipsec_cfg,		\
 				msg_req, nix_inline_ipsec_cfg)		\
 M(NIX_MCAST_GRP_CREATE,	0x802b, nix_mcast_grp_create, nix_mcast_grp_create_req,	\
@@ -952,6 +953,7 @@ enum nix_af_status {
 	NIX_AF_ERR_INVALID_MCAST_GRP	= -436,
 	NIX_AF_ERR_INVALID_MCAST_DEL_REQ = -437,
 	NIX_AF_ERR_NON_CONTIG_MCE_LIST = -438,
+	NIX_AF_ERR_RX_SW_SYNC_FAIL	= -439,
 };
 
 /* For NIX RX vtag action  */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index dade7bb6deb7..e397c8cedbc7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -269,15 +269,19 @@ u32 convert_bytes_to_dwrr_mtu(u32 bytes)
 	return 0;
 }
 
-static void nix_rx_sync(struct rvu *rvu, int blkaddr)
+static int nix_rx_sync(struct rvu *rvu, int blkaddr)
 {
 	int err;
 
+	mutex_lock(&rvu->rsrc_lock);
+
 	/* Sync all in flight RX packets to LLC/DRAM */
 	rvu_write64(rvu, blkaddr, NIX_AF_RX_SW_SYNC, BIT_ULL(0));
 	err = rvu_poll_reg(rvu, blkaddr, NIX_AF_RX_SW_SYNC, BIT_ULL(0), true);
-	if (err)
+	if (err) {
 		dev_err(rvu->dev, "SYNC1: NIX RX software sync failed\n");
+		goto unlock;
+	}
 
 	/* SW_SYNC ensures all existing transactions are finished and pkts
 	 * are written to LLC/DRAM, queues should be teared down after
@@ -289,6 +293,10 @@ static void nix_rx_sync(struct rvu *rvu, int blkaddr)
 	err = rvu_poll_reg(rvu, blkaddr, NIX_AF_RX_SW_SYNC, BIT_ULL(0), true);
 	if (err)
 		dev_err(rvu->dev, "SYNC2: NIX RX software sync failed\n");
+
+unlock:
+	mutex_unlock(&rvu->rsrc_lock);
+	return err;
 }
 
 static bool is_valid_txschq(struct rvu *rvu, int blkaddr,
@@ -6336,6 +6344,25 @@ int rvu_mbox_handler_nix_bandprof_get_hwinfo(struct rvu *rvu, struct msg_req *re
 	return 0;
 }
 
+int rvu_mbox_handler_nix_rx_sw_sync(struct rvu *rvu, struct msg_req *req,
+				    struct msg_rsp *rsp)
+{
+	int blkaddr, nixlf, err;
+
+	/* NIX_AF_RX_SW_SYNC is global per NIX block; nix_rx_sync() serializes
+	 * access under rvu->rsrc_lock across mbox and teardown paths.
+	 */
+	err = nix_get_nixlf(rvu, req->hdr.pcifunc, &nixlf, &blkaddr);
+	if (err)
+		return err;
+
+	err = nix_rx_sync(rvu, blkaddr);
+	if (err)
+		return NIX_AF_ERR_RX_SW_SYNC_FAIL;
+
+	return 0;
+}
+
 static struct nix_mcast_grp_elem *rvu_nix_mcast_find_grp_elem(struct nix_mcast_grp *mcast_grp,
 							      u32 mcast_grp_idx)
 {
-- 
2.43.0

