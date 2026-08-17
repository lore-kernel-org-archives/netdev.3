Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A0626AC3;
	Mon, 17 Aug 2026 03:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786938712; cv=none; b=VPbcSA5BQN6guVBpoOMkgcKZqnvcooW14eZiNvJeYbXPbTwW/oHL06oAsAbF8q3jhLLir9Zdrwd7clTf27L34MTVsMYPC5/dHPIpCc3E8IP+FMvv1Vj3jeBqKLMWZRjwDIUUyfKlmaVJmo0KLpVZTsslxBHo1p9xzUmvpde4KzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786938712; c=relaxed/simple;
	bh=CGfGlmyeRmNgaRqSYOSwp0zFcKu9oUfZuAwnKLihcx0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OU4t4KEk70cFlMTZZlZd7eyboCR6s0iN+e2uzTqj7UbVqpXOlRPNqKWzZAVng9RsNXImOt92kO80TNhj6XQx/PVYjyqpr4tYvIVx2erK0d+KE4V1+3JTlYZ5gPDQtDIeUkTXLyDux6gkVkluxFsq/GabF473FDUbYkMNowcmg9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Nv4bC61Y; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Nv4bC61Y"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GNMITt840734;
	Sun, 16 Aug 2026 20:51:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=pxRMZjmDqxQfaK7yCy8AyFn
	+kAuNJ6gb945kBzO3cDA=; b=Nv4bC61Y6DDYaNkFGaJGe+YGjbnHYPJbRAiXmOA
	/2tukLVVRuxsk1r414PN8zauOWLMn+YD3YV7dOi2BKV0W+k9BMMzF+cpxbKwQLQZ
	ctJqn5/c01GGzCgU8U/jZ/CbcjShciTi0Zpjt8fwdyRI/x5XhLyCAcjgaD2v9XJf
	Qq7UE5le2fjc52nPVfuA63yXYMAUUiTKyJEkaHf1i2cgnPZCY3ekOE1XxSgqKeDH
	cD8kr7yTLnss11sg2IIc9rUcDA/FvTUDYDdFhgNKrLFOl+6ptcXe2Gh7ZyK/TQ9p
	52nKpZLxl3VVuulzL0YLPZrSReI0QZ3VwPjd1Wqq35Kezeg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g36v39cs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Aug 2026 20:51:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 16 Aug 2026 20:51:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 16 Aug 2026 20:51:38 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id BA72E3F7080;
	Sun, 16 Aug 2026 20:51:34 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Suman Ghosh
	<sumang@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v3 net-next] octeontx2-af: add NPC TEID matching for GTP-U and GTP-C flows
Date: Mon, 17 Aug 2026 09:21:27 +0530
Message-ID: <20260817035127.1782901-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAyNyBTYWx0ZWRfXzXi57J0tRUOk
 45ExlI2pI5QDHpIMRSk1TZ7xEguOzmtmwizUDp6YwPJuDNhoiyytd0R8TOJPRD57yyBuMaQx/Dx
 qVGyKkYtvt0ZPyvGpJXHtIslmRtfNvk=
X-Proofpoint-ORIG-GUID: vElBa_1f6Q3fYvJy3FNR5Enatpn7fFmX
X-Authority-Analysis: v=2.4 cv=MatcfZ/f c=1 sm=1 tr=0 ts=6a82854b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=c92rfblmAAAA:8 a=M5GUcnROAAAA:8
 a=Qfb8oaWSeBAurIiPRzwA:9 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: vElBa_1f6Q3fYvJy3FNR5Enatpn7fFmX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAyNyBTYWx0ZWRfX/yiXhXKPYkw0
 +jLYl3qcLLejMmNayj7vJvVMioa0mNAWjSuoMA+blykVd7hyTdsCRrXjQWxE7H9n7ehnhw1gU+w
 CudLofaSgdg63IZ1BI9HSQ+OYoKZndmU3RzUwOYE3JKE2zpODsC9tVnAKfHO68ze272j1DVwkth
 5Xgchrdtb8iKfdCJWVVLqTTYwpvrVBCSoCM6kQmCVV+0r2uZuF7uhSRVfKBigk8eSvZIfLapkW+
 SPSv8E8YBG6zhxZ8zou4JcJ4Kbvo9KOu+tYIJFXnxdR7vWL9xSYXhFxoNMTAWomY1XW6dQNr82Q
 v+d5ADB0SFJV5RrNszvKP0GcxFWHkXDyCZaMRJjipVfLDd5ZJpT7kexsPbZA91bYxFjp5kl2p3w
 TDFiudyRsOm5Fa/iMI/V1k+I8UwiLdlVQbV7tRChnZqNPURJ8VrlcOkAWEIyyc8R/FpAKair/6+
 qy3y+/V7WzQ/iSwl1IA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01

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
v2 -> v3: Addressed Sashiko comments
	https://sashiko.dev/#/patchset/20260812051215.456258-1-rkannoth%40marvell.com
v1 -> v2: Addressed Sashiko comments
	https://sashiko.dev/#/patchset/20260810050436.1822566-1-rkannoth%40marvell.com
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  2 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  2 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |  8 ++++
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 40 ++++++++++++++++++-
 .../marvell/octeontx2/nic/otx2_flows.c        | 29 +++++++++++++-
 5 files changed, 79 insertions(+), 2 deletions(-)

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
index 99d78fc5a2c4..b374d8811bc8 100644
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
@@ -1076,7 +1079,31 @@ static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
 			req->features |= BIT_ULL(NPC_OUTER_VID);
 		}
 
-		if (fsp->m_ext.data[1]) {
+		/* GTP TEID uses FLOW_EXT data[1]; VLAN/MAC use other fields. */
+		if (fsp->m_ext.data[1] &&
+		    fsp->h_ext.data[1] != cpu_to_be32(OTX2_DEFAULT_ACTION)) {
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

