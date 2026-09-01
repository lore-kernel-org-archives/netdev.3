Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91F4CCDC2;
	Tue,  1 Sep 2026 04:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237067; cv=none; b=sA09ibubu4kMaHavp1oIpcLwcl18Rg0DCdcfwT0VDXPx2gBHIcCZYiqhb50+3LLWs8xDoMwIsoJNa6YJVq9NVIom1MjFpVLRkJniTcrwVMLNw9Ak3famkaK1V9PPNkAcwe/nN7wcifJw5I3KlB7X0MmqF4a83miLplJxJO9avNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237067; c=relaxed/simple;
	bh=7OxC0Jzr7y3mGjPRhKuzqMAdosQnylYItU3J57m5E/0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jq8d2LWWk3T/RB8grEzwjLjFUPsgaQF4oixdrgS62ienHP5NKgKGlFRK1aOyxIv9RmM2VFqDUKEJYN5DNURpMp3XIIgqB78ttfSNr4Cj51psu7M5cNEnDN9EhwGwR+lNKIDslvDB0CmtzY7Y6yGIYNGF4f0v6pnt+SZNDbvGcIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=T9npXl9d; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="T9npXl9d"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6810pTw52006847;
	Mon, 31 Aug 2026 21:30:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=XnU8AFBrPLKcQs+bzkFjbE3
	5nJ0qMHT58FU4zbm/i7g=; b=T9npXl9dXHfyy7PgIMZtLJT6qu2HFX1kyF3lW8P
	VE8xpVbOVqI9YQsqetVcbRTzM9uHcIZD/MzV8U9Dhngs8aXYvO4Vk4E1/QfFLNJA
	FkhfYNtLUNrGd9M+w8cQ3AeFNIAtEX6xwgOsXnDHL2BEZytdCCZxNcfqLuygiNpx
	b5ViNsmlTzZoohIZC63PelosLAG67Gfo1lA78haO/Ch+BXumH6E5ggXFsIqgIrHC
	3g/3LFaiHJLqj5ee6owz5pf0UTh6sosNlqemu05fHu00sEsTCValWQV9K1CmSdJM
	eTvwxBaIegjsNvrAUIN4KnOAZX1aIj3RcAx04AZinbGVkuQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gckp8naxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 21:30:45 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 21:30:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 21:30:38 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 6045B5B6926;
	Mon, 31 Aug 2026 21:30:34 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Suman Ghosh
	<sumang@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v4 net-next] octeontx2-af: add NPC TEID matching for GTP-U and GTP-C flows
Date: Tue, 1 Sep 2026 10:00:27 +0530
Message-ID: <20260901043027.2765502-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDAzNyBTYWx0ZWRfXzBi6IU0p+6jj
 n4YQOqJWTrh4xkK9jG2J6LT74aM1Yaw1eGlQvjZGTDahI14AExF3BAJCAsud/5fyE3St4LqTZKP
 SFliYC2jlVhOiAHPfvuZvViZvc07l7SRp0CCsQcK+DwCCI3/mevOn5lkLBatZ2ysHLsFtnGBhSx
 5OGpw0s+d08ASoX0ivs9wjAtJxBTI9YGi4O4zvBBXJO4s+gbupeS9bkdRQVazkL8f9ScE8tJad1
 +nce1NuKMSdJEzgcj+NoonvLS9/ZUfFJplL2P/Z/NFEQ3gySkqoV3GHgT7zOuAR7vDKxxGoOubZ
 SGBWk9dB71SgfwyUKysl8HqKbk1QDoQBXqEdBzMviHED6jyUjg7UaZrHsnoK2cYmUCHkXczUjZ0
 uuvVn1cdIxH+Q4Ss2H0JxyCsuDQpskxPTV5irt2HncJ1YixMNF1pThXN55K3oymVH1+e69mqgRf
 CCKveV2EJn7ir2AItWA==
X-Proofpoint-GUID: dwPxrEzjtlM0TSjPFHWiKAk2F9Gzr6ge
X-Proofpoint-ORIG-GUID: dwPxrEzjtlM0TSjPFHWiKAk2F9Gzr6ge
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDAzNyBTYWx0ZWRfX1cjAx1i4sZ+B
 GCtNIG1b0mL0RD5kkwlXf7AZlSA/OMoZiZBLTTZkbh/6I3hWKgW4giIDN7wqunWGCkSLCaZT1+h
 DkJHT+2tjs+fHZ7lNytwbyRPHcWcIG8=
X-Authority-Analysis: v=2.4 cv=GLk41ONK c=1 sm=1 tr=0 ts=6a9654f5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=c92rfblmAAAA:8 a=M5GUcnROAAAA:8
 a=Qfb8oaWSeBAurIiPRzwA:9 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01

From: Suman Ghosh <sumang@marvell.com>

Add NPC_GTPU_TEID and NPC_GTPC_TEID key fields and wire them through
the AF MCAM path so ethtool Rx flow rules can match on the TEID of
GTP-U and GTP-C packets.

In otx2_prepare_flow_request(), when a UDP  v4/v6 ntuple rule
targets the well-known GTP-U (2152) or GTP-C (2123) destination port,
take the TEID value and mask from h_ext.data[1] and install the
corresponding LE layer match in NPC.  Expose the new fields in debugfs
MCAM dumps.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---

v3 -> v4: Addressed Sashiko comments
	https://sashiko.dev/#/patchset/20260817035127.1782901-1-rkannoth%40marvell.com
v2 -> v3: Addressed Sashiko comments
	https://sashiko.dev/#/patchset/20260812051215.456258-1-rkannoth%40marvell.com
v1 -> v2: Addressed Sashiko comments
	https://sashiko.dev/#/patchset/20260810050436.1822566-1-rkannoth%40marvell.com
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  2 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  2 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |  8 ++++
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 40 ++++++++++++++++++-
 .../marvell/octeontx2/nic/otx2_flows.c        | 26 ++++++++++++
 5 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index cece197d1074..2082b042048f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1851,6 +1851,8 @@ struct flow_msg {
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
index 22ee99676879..50e891992c83 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -3443,6 +3443,14 @@ static void rvu_dbg_npc_mcam_show_flows(struct seq_file *s,
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
index d422bdd5e8f8..84be78ab7351 100644
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
 
@@ -1769,6 +1785,28 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 
 	req->entry = npc_cn20k_vidx2idx(req->entry);
 
+	if ((req->features & BIT_ULL(NPC_GTPU_TEID)) &&
+	    !npc_check_field(rvu, blkaddr, NPC_GTPU_TEID, req->intf)) {
+		if (is_pffunc_af(req->hdr.pcifunc))
+			dev_warn(rvu->dev,
+				 "%s: mkex profile does not extract GTP-U TEID\n",
+				 __func__);
+		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
+						    allocated, req->entry);
+		return NPC_FLOW_NOT_SUPPORTED;
+	}
+
+	if ((req->features & BIT_ULL(NPC_GTPC_TEID)) &&
+	    !npc_check_field(rvu, blkaddr, NPC_GTPC_TEID, req->intf)) {
+		if (is_pffunc_af(req->hdr.pcifunc))
+			dev_warn(rvu->dev,
+				 "%s: mkex profile does not extract GTP-C TEID\n",
+				 __func__);
+		rvu_npc_free_entry_for_flow_install(rvu, req->hdr.pcifunc,
+						    allocated, req->entry);
+		return NPC_FLOW_NOT_SUPPORTED;
+	}
+
 	/* If DMAC is not extracted in MKEX, rules installed by AF
 	 * can rely on L2MB bit set by hardware protocol checker for
 	 * broadcast and multicast addresses.
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 99d78fc5a2c4..73401e7ec68d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -11,6 +11,8 @@
 #include "otx2_common.h"
 
 #define OTX2_DEFAULT_ACTION	0x1
+#define GTPU_PORT		2152
+#define GTPC_PORT		2123
 
 struct otx2_flow {
 	struct ethtool_rx_flow_spec flow_spec;
@@ -1036,6 +1038,7 @@ static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
 		return -EOPNOTSUPP;
 	}
 	if (fsp->flow_type & FLOW_EXT) {
+		int skip_user_def = false;
 		u16 vlan_etype;
 
 		if (fsp->m_ext.vlan_etype) {
@@ -1076,7 +1079,30 @@ static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
 			req->features |= BIT_ULL(NPC_OUTER_VID);
 		}
 
+		/* GTP TEID uses FLOW_EXT data[1]; VLAN/MAC use other fields. */
 		if (fsp->m_ext.data[1]) {
+			switch (flow_type) {
+			case UDP_V4_FLOW:
+			case UDP_V6_FLOW:
+				if (ntohs(pmask->dport) == 0xFFFF &&
+				    ntohs(pkt->dport) == GTPU_PORT) {
+					/* Check for GTP-U packets */
+					skip_user_def = true;
+					pkt->gtpu_teid = fsp->h_ext.data[1];
+					pmask->gtpu_teid = fsp->m_ext.data[1];
+					req->features |= BIT_ULL(NPC_GTPU_TEID);
+				} else if (ntohs(pmask->dport) == 0xFFFF &&
+					   ntohs(pkt->dport) == GTPC_PORT) {
+					/* Check for GTP-C packets */
+					skip_user_def = true;
+					pkt->gtpc_teid = fsp->h_ext.data[1];
+					pmask->gtpc_teid = fsp->m_ext.data[1];
+					req->features |= BIT_ULL(NPC_GTPC_TEID);
+				}
+			}
+		}
+
+		if (fsp->m_ext.data[1] && !skip_user_def) {
 			if (flow_type == IP_USER_FLOW) {
 				if (be32_to_cpu(fsp->h_ext.data[1]) != IPV4_FLAG_MORE)
 					return -EINVAL;
-- 
2.43.0

