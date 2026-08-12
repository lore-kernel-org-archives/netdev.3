Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408A53290C7;
	Wed, 12 Aug 2026 05:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786511572; cv=none; b=mJrF8uGtLMDi+cBilh44APZQsavq3ulBqWX4Destia6LHjkpaO0LtRdFHbSZjIG4+trLChXycQj5c+U6Qd2m4r4ylcS/huLVyAI0wGjB0MFJMYps+6po8dQ7L86xVmPNoGMskQLIfqPEEL8sA+fcR6P68zehy723W+DR7gooMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786511572; c=relaxed/simple;
	bh=mTiGf0I08I0u/Fsy3ohnrOJWDLKW+uJUe7mJY3PO5os=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W+gO/uqsjGMgjEdLMCJjFX0chxiOuzTmb8U3N+/qs01SVTzMAOPsiOHDxDo/tn5Ilsf4cQPn8x6C+h33EoSkyRqoa78NDftIuU4WYt+rUj5Qtj6v0Grwg9fjtGj7stZusdVCVQpWkGNZ9+rmoeDmMB5VAF1MRuw5cR6fnVowvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=T9cPVTWz; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="T9cPVTWz"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C57VdY994965;
	Tue, 11 Aug 2026 22:12:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=v0nslzbQBoNMORt2QqKK4z8
	nmrnKKCPDdZF81LFPZIA=; b=T9cPVTWzDGCLvhQnXVeqe3a/tdIHWtrRiobbHTk
	4qrPZtoW+e8lzhiWK2vnfwnLON/YBG5Ui0UcviwGuoaKBIRylFg5lfVHZXmQQNr1
	oDpiMZ1EL71tS7apGzP1ksewYLFIzKdTBXw/RixKAa2I6ALeTH1FgbggHTcQbIsX
	/OjNFPd5JGB33y3XFwI3R4HPpKs1zura3rwGNDAWbe94Nv1X3zbAadUpib385cjO
	Glt2HE9rHN68/4YLBM9Kjag+uZDMLOpaqaGFEUolkiwCDSv3atoGBB4PvrNFhKEM
	NSXRUNATkrmb2sfw9au/V6hLWljpITnyB5gqmbpisvWvLMg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g0deb0unv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 22:12:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 11 Aug 2026 22:12:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 11 Aug 2026 22:12:38 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E2D9F3F7044;
	Tue, 11 Aug 2026 22:12:33 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Suman Ghosh
	<sumang@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v2 net-next] octeontx2-af: add NPC TEID matching for GTP-U and GTP-C flows
Date: Wed, 12 Aug 2026 10:42:15 +0530
Message-ID: <20260812051215.456258-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAzNyBTYWx0ZWRfX1gW9FG0UtNLs
 isGQORSbREwglCS8Tubey8oAGABujaUHoBfDEeBaG9wPvFWUdGxj8iOrP1bg+ySO45/6G6Xbdsg
 n39DrqZLw7M2mrKESCu6UrTTjusNtxo=
X-Proofpoint-ORIG-GUID: UBzy-ZJ4Hh-OQdNeTqN6KzYvspx-NvNp
X-Proofpoint-GUID: UBzy-ZJ4Hh-OQdNeTqN6KzYvspx-NvNp
X-Authority-Analysis: v=2.4 cv=MJxQXsZl c=1 sm=1 tr=0 ts=6a7c00c7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=c92rfblmAAAA:8 a=M5GUcnROAAAA:8
 a=Qfb8oaWSeBAurIiPRzwA:9 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAzNyBTYWx0ZWRfX6x7n3Duso0dV
 qHq+A7bswy8kYvKBQSCqNcUWcQ8qLOrR1KqR5YCXj0DaM//f1BKa+856KCRVjbAKfH1Te4GCGtI
 IFahb7kzB71wjf7OR1B1Ftoutb7b3YGciqVQ6C71jpRPNzYuHKzio3C8L0ElH7DpEJVwsUomOJu
 QJZoachokxjQXs/lhNMifJZgs1D7EiQ1fJIjfZMx1YhQgHJtmK1fn1eyMNsHjId0QqUCTXGbxme
 sKC42R6rvgCUZXSq4eflFSZbXmN+W+dnkxpv3lMQyEkb0cN3YhRepzgBPc/hNOYpqXXwa3HXAvi
 TAIMqVB+AZNK/K82ILbooW0NIBeGDdxW0ynYCNoEnmeKuQxNxd1QS4Xv1YCrfb6KQf7BTPl71cZ
 uAUUpVmPpE6QTw2U5nUis+NQ+/Ng0qihJ/ldTIryLfhXohS3+Knr4Q2ptR151DSU4YDISkQxRY5
 q2hrWjQWi4dTnYKNzBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01

From: Suman Ghosh <sumang@marvell.com>

Add NPC_GTPU_TEID and NPC_GTPC_TEID key fields and wire them through
the AF MCAM path so ethtool Rx flow rules can match on the TEID of
GTP-U and GTP-C packets.

In otx2_prepare_flow_request(), when a UDP or TCP v4/v6 ntuple rule
targets the well-known GTP-U (2152) or GTP-C (2123) destination port,
take the TEID value and mask from h_ext.data[1] and install the
corresponding LE layer match in NPC.  Expose the new fields in debugfs
MCAM dumps.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---

v1 -> v2: Addressed Sashiko comments
	https://sashiko.dev/#/patchset/20260810050436.1822566-1-rkannoth%40marvell.com
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  2 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  2 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |  8 ++++
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 38 ++++++++++++++++++-
 .../marvell/octeontx2/nic/otx2_flows.c        | 27 ++++++++++++-
 5 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 73f743e4a83d..7cf07f15bdae 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1849,6 +1849,8 @@ struct flow_msg {
 	u8 icmp_code;
 	__be16 tcp_flags;
 	u16 sq_id;
+	__be32 gtpu_teid;
+	__be32 gtpc_teid;
 };
 
 struct npc_install_flow_req {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index 719b3618eeb5..187a50047617 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -226,6 +226,8 @@ enum key_fields {
 	NPC_TYPE_ICMP,
 	NPC_CODE_ICMP,
 	NPC_TCP_FLAGS,
+	NPC_GTPU_TEID,
+	NPC_GTPC_TEID,
 	NPC_HEADER_FIELDS_MAX,
 	NPC_CHAN = NPC_HEADER_FIELDS_MAX, /* Valid when Rx */
 	NPC_PF_FUNC, /* Valid when Tx */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 3456313d3b3c..c0b0e4d14696 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -3437,6 +3437,14 @@ static void rvu_dbg_npc_mcam_show_flows(struct seq_file *s,
 			seq_printf(s, "%d ", rule->packet.icmp_code);
 			seq_printf(s, "mask 0x%x\n", rule->mask.icmp_code);
 			break;
+		case NPC_GTPU_TEID:
+			seq_printf(s, "%u ", ntohl(rule->packet.gtpu_teid));
+			seq_printf(s, "mask 0x%x\n", ntohl(rule->mask.gtpu_teid));
+			break;
+		case NPC_GTPC_TEID:
+			seq_printf(s, "%u ", ntohl(rule->packet.gtpc_teid));
+			seq_printf(s, "mask 0x%x\n", ntohl(rule->mask.gtpc_teid));
+			break;
 		default:
 			seq_puts(s, "\n");
 			break;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index d422bdd5e8f8..773097cd8534 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -56,6 +56,8 @@ static const char * const npc_flow_names[] = {
 	[NPC_TYPE_ICMP] = "icmp type",
 	[NPC_CODE_ICMP] = "icmp code",
 	[NPC_TCP_FLAGS] = "tcp flags",
+	[NPC_GTPU_TEID]	= "gtp-u teid ",
+	[NPC_GTPC_TEID]	= "gtp-c teid ",
 	[NPC_UNKNOWN]	= "unknown",
 };
 
@@ -661,6 +663,8 @@ do {									       \
 	NPC_SCAN_HDR(NPC_VLAN_TAG1, NPC_LID_LB, NPC_LT_LB_CTAG, 2, 2);
 	NPC_SCAN_HDR(NPC_VLAN_TAG2, NPC_LID_LB, NPC_LT_LB_STAG_QINQ, 2, 2);
 	NPC_SCAN_HDR(NPC_VLAN_TAG3, NPC_LID_LB, NPC_LT_LB_STAG_QINQ, 6, 2);
+	NPC_SCAN_HDR(NPC_GTPU_TEID, NPC_LID_LE, NPC_LT_LE_GTPU, 4, 4);
+	NPC_SCAN_HDR(NPC_GTPC_TEID, NPC_LID_LE, NPC_LT_LE_GTPC, 4, 4);
 	NPC_SCAN_HDR(NPC_DMAC, NPC_LID_LA, la_ltype, la_start, 6);
 
 	NPC_SCAN_HDR(NPC_IPSEC_SPI, NPC_LID_LD, NPC_LT_LD_AH, 4, 4);
@@ -720,7 +724,7 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
 		*features |= BIT_ULL(NPC_IPPROTO_ICMP6);
 	}
 
-	/* for ESP, check if corresponding layer type is present in the key */
+	/* for ESP check if corresponding layer type is present in the key */
 	if (npc_check_field(rvu, blkaddr, NPC_LE, intf))
 		*features |= BIT_ULL(NPC_IPPROTO_ESP);
 
@@ -1113,6 +1117,14 @@ void npc_update_flow(struct rvu *rvu, struct mcam_entry_mdata *mdata,
 		npc_update_entry(rvu, NPC_LE, mdata, NPC_LT_LE_ESP,
 				 0, ~0ULL, 0, intf);
 
+	if (features & BIT_ULL(NPC_GTPU_TEID))
+		npc_update_entry(rvu, NPC_LE, mdata, NPC_LT_LE_GTPU,
+				 0, ~0ULL, 0, intf);
+
+	if (features & BIT_ULL(NPC_GTPC_TEID))
+		npc_update_entry(rvu, NPC_LE, mdata, NPC_LT_LE_GTPC,
+				 0, ~0ULL, 0, intf);
+
 	if (features & BIT_ULL(NPC_LXMB)) {
 		output->lxmb = is_broadcast_ether_addr(pkt->dmac) ? 2 : 1;
 		npc_update_entry(rvu, NPC_LXMB, mdata, output->lxmb, 0,
@@ -1209,6 +1221,10 @@ do {									      \
 
 	NPC_WRITE_FLOW(NPC_IPFRAG_IPV6, next_header, pkt->next_header, 0,
 		       mask->next_header, 0);
+	NPC_WRITE_FLOW(NPC_GTPU_TEID, gtpu_teid, ntohl(pkt->gtpu_teid), 0,
+		       ntohl(mask->gtpu_teid), 0);
+	NPC_WRITE_FLOW(NPC_GTPC_TEID, gtpc_teid, ntohl(pkt->gtpc_teid), 0,
+		       ntohl(mask->gtpc_teid), 0);
 	npc_update_ipv6_flow(rvu, mdata, features, pkt, mask, output, intf);
 	npc_update_vlan_features(rvu, mdata, features, intf);
 
@@ -1805,6 +1821,26 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 		req->features |= BIT_ULL(NPC_LXMB);
 	}
 
+	if ((req->features & BIT_ULL(NPC_GTPU_TEID)) &&
+	    !npc_check_field(rvu, blkaddr, NPC_GTPU_TEID, req->intf)) {
+		dev_warn(rvu->dev,
+			 "%s: mkex profile does not extract GTP-U TEID\n",
+			 __func__);
+		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
+						    allocated, req->entry);
+		return NPC_FLOW_NOT_SUPPORTED;
+	}
+
+	if ((req->features & BIT_ULL(NPC_GTPC_TEID)) &&
+	    !npc_check_field(rvu, blkaddr, NPC_GTPC_TEID, req->intf)) {
+		dev_warn(rvu->dev,
+			 "%s: mkex profile does not extract GTP-C TEID\n",
+			 __func__);
+		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
+						    allocated, req->entry);
+		return NPC_FLOW_NOT_SUPPORTED;
+	}
+
 process_flow:
 	if (from_vf && req->default_rule) {
 		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 99d78fc5a2c4..7f69e386638c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -11,6 +11,8 @@
 #include "otx2_common.h"
 
 #define OTX2_DEFAULT_ACTION	0x1
+#define GTPU_PORT		2152
+#define GTPC_PORT		2123
 
 struct otx2_flow {
 	struct ethtool_rx_flow_spec flow_spec;
@@ -1036,8 +1038,31 @@ static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
 		return -EOPNOTSUPP;
 	}
 	if (fsp->flow_type & FLOW_EXT) {
+		int skip_user_def = false;
 		u16 vlan_etype;
 
+		switch (flow_type) {
+		case UDP_V4_FLOW:
+		case UDP_V6_FLOW:
+		case TCP_V4_FLOW:
+		case TCP_V6_FLOW:
+			if (ntohs(pmask->dport) == 0xFFFF &&
+			    ntohs(pkt->dport) == GTPU_PORT) {
+				/* Check for GTP-U packets */
+				skip_user_def = true;
+				pkt->gtpu_teid = fsp->h_ext.data[1];
+				pmask->gtpu_teid = fsp->m_ext.data[1];
+				req->features |= BIT_ULL(NPC_GTPU_TEID);
+			} else if (ntohs(pmask->dport) == 0xFFFF &&
+				   ntohs(pkt->dport) == GTPC_PORT) {
+				/* Check for GTP-C packets */
+				skip_user_def = true;
+				pkt->gtpc_teid = fsp->h_ext.data[1];
+				pmask->gtpc_teid = fsp->m_ext.data[1];
+				req->features |= BIT_ULL(NPC_GTPC_TEID);
+			}
+		}
+
 		if (fsp->m_ext.vlan_etype) {
 			/* Partial masks not supported */
 			if (be16_to_cpu(fsp->m_ext.vlan_etype) != 0xFFFF)
@@ -1076,7 +1101,7 @@ static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
 			req->features |= BIT_ULL(NPC_OUTER_VID);
 		}
 
-		if (fsp->m_ext.data[1]) {
+		if (fsp->m_ext.data[1] && !skip_user_def) {
 			if (flow_type == IP_USER_FLOW) {
 				if (be32_to_cpu(fsp->h_ext.data[1]) != IPV4_FLAG_MORE)
 					return -EINVAL;
-- 
2.43.0

