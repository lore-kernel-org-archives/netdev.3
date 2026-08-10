Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE6C23E330;
	Mon, 10 Aug 2026 05:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338307; cv=none; b=PBQ5kRak6wcG2LButXsa6K0L7ue52g2gy03MxlTnBNOgjLXscSTuWk1W0ltMWc5+HTKpLhdWurFwXiHAbrXdVv1TjGdkWXHkhkEDyMdDeEcYBM1PL9mK6Z2iK205354ClAHGaoL2guJjhknmul54cYfdckroKPU0H5BhAZKQkgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338307; c=relaxed/simple;
	bh=KL2jEj5SWweh/lk8r5S+GozpMKDs1YDFshjjTCVBxOA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dq9x+RHrvDPOEAm6Ze6xLxZyJPcYuIF+qWWBbV2ePPClWbgTu0zKpiglsQUV+s3/m+ZkvqSqOke6E4sUk850dFPME07w1Jj9NoE1eilyfi/7SC/2m1+qJZShjCjikYc++cbGdPxszZs0XiHVYQH1tpK1zjXiwLWu8a4YSZyjfTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kOwSBDqA; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kOwSBDqA"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A0PfQs3515554;
	Sun, 9 Aug 2026 22:04:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=S0BguUbjoMPGafniO7XOb8L
	QQDkn1HCWbh6FjVmbgzA=; b=kOwSBDqAa54X5bgfcLDlFEChy1XRA2Ns5KoPMLZ
	XISJEzTxKaKquYmfX4uHSF4cENbwKyGhNOM+bKCP1UJ5DDrEJdHE4IKn2HiPf0rn
	+GD2Kd3DqsWAwHi08IZqYFNyvFcrW14xt9XM9euR83+heB5Z3XVVp0NtnBO3C6pM
	V9w9mfmgjrR2KO9WHh8KU3Sd4Xn7x9pt/j9LqvQuPnrHqDgKyAzHj5LRqF26JZiU
	nDqIv/rdMHQWL/SH8b+3S2GRbx/gQsdmfBxJG4xiF2OjmT9I32bxR/D5Ln1f7AVk
	0FKEHr1qsp+PE18FgLs88aPJfdfX+AipgN/9Q8AbjwTnZ6w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fx3yjb3qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 22:04:56 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 9 Aug 2026 22:04:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 9 Aug 2026 22:04:55 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id B5BA45B693B;
	Sun,  9 Aug 2026 22:04:51 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Suman Ghosh
	<sumang@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net-next] octeontx2-af: add NPC TEID matching for GTP-U and GTP-C flows
Date: Mon, 10 Aug 2026 10:34:36 +0530
Message-ID: <20260810050436.1822566-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA0MCBTYWx0ZWRfX1tPMlQlfMG0A
 EaLIX8QMe7QitshCvs7rcJ5dFRBR9nndlJmMGjNzJrcBL7fNTsa60+DrEjQLCrLmlH+RKUGrPmr
 MqK/M5NO23ZSTkMeE3CaoyYBOX0R3Vi1tthRS4Fz64V3AKZ/VQvk0bUznTbLQiIUyPAJ0I+xeKV
 kgpEw0AbVpisyHV+zsg04rIB9ZO3DviUsikDOKNcLfnnwzWKw8YIQEMkTiurFBnjH1/ZdHHZhrn
 IARKfW7TCA24WlYgkyMSQY7qM+BRJz2X+MKUmy/slBNkqp/3mYEjR44c7TxQ1+tzR+ODLMs4RsN
 4zMvGYWAGdCrAV/VxRcMLzEgxynHpi473tf2pjtROnL7WY9sSCoGoZHUNH/Bdga3zq17gM5YoVd
 sXeQltfB24HgTfBC/BXltqvIS2k/hEs8fU/NgjAUS/jd/XOj0ISo3+uUui+hnDfm/gv67V1hrYI
 vZLggoe+R7t4LI+NGzA==
X-Authority-Analysis: v=2.4 cv=cOfQdFeN c=1 sm=1 tr=0 ts=6a795bf8 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=ANcf8giYjA2aJ84Cnk8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: rw5LLmhf3RxtWW8G3Ss9lltnoR2zSuTh
X-Proofpoint-ORIG-GUID: rw5LLmhf3RxtWW8G3Ss9lltnoR2zSuTh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA0MCBTYWx0ZWRfX/O11mLGWYVTf
 1zM8j2i12QMFztfZDoh1Nmm01JOs7z2a7JV43vw+ZF290NHiHyItp/PGLNMA6YF5QsxivAlI+Yt
 gLhW75TAPnpXssynOExbNge7SIw3/8I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01

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
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  2 ++
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  2 ++
 .../marvell/octeontx2/af/rvu_debugfs.c        |  8 +++++++
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 21 +++++++++++++++--
 .../marvell/octeontx2/nic/otx2_flows.c        | 23 +++++++++++++++++++
 5 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 73f743e4a83d..1101e29328ac 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1839,6 +1839,8 @@ struct flow_msg {
 		u8 next_header;
 	};
 	__be16 vlan_itci;
+	__be32 gtpu_teid;
+	__be32 gtpc_teid;
 #define OTX2_FLOWER_MASK_MPLS_LB		GENMASK(31, 12)
 #define OTX2_FLOWER_MASK_MPLS_TC		GENMASK(11, 9)
 #define OTX2_FLOWER_MASK_MPLS_BOS		BIT(8)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index 719b3618eeb5..33277fc3d27e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -214,6 +214,8 @@ enum key_fields {
 	NPC_DPORT_UDP,
 	NPC_SPORT_SCTP,
 	NPC_DPORT_SCTP,
+	NPC_GTPU_TEID,
+	NPC_GTPC_TEID,
 	NPC_IPSEC_SPI,
 	NPC_MPLS1_LBTCBOS,
 	NPC_MPLS1_TTL,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 3456313d3b3c..bb690890606c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -3437,6 +3437,14 @@ static void rvu_dbg_npc_mcam_show_flows(struct seq_file *s,
 			seq_printf(s, "%d ", rule->packet.icmp_code);
 			seq_printf(s, "mask 0x%x\n", rule->mask.icmp_code);
 			break;
+		case NPC_GTPU_TEID:
+			seq_printf(s, "%d ", ntohl(rule->packet.gtpu_teid));
+			seq_printf(s, "mask 0x%x\n", ntohl(rule->mask.gtpu_teid));
+			break;
+		case NPC_GTPC_TEID:
+			seq_printf(s, "%d ", ntohl(rule->packet.gtpc_teid));
+			seq_printf(s, "mask 0x%x\n", ntohl(rule->mask.gtpc_teid));
+			break;
 		default:
 			seq_puts(s, "\n");
 			break;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index d422bdd5e8f8..1f9af70cf2f9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -44,6 +44,8 @@ static const char * const npc_flow_names[] = {
 	[NPC_SPORT_SCTP] = "sctp source port",
 	[NPC_DPORT_SCTP] = "sctp destination port",
 	[NPC_LXMB]	= "Mcast/Bcast header ",
+	[NPC_GTPU_TEID]	= "gtp-u teid ",
+	[NPC_GTPC_TEID]	= "gtp-c teid ",
 	[NPC_IPSEC_SPI] = "SPI ",
 	[NPC_MPLS1_LBTCBOS] = "lse depth 1 label tc bos",
 	[NPC_MPLS1_TTL]     = "lse depth 1 ttl",
@@ -661,6 +663,8 @@ do {									       \
 	NPC_SCAN_HDR(NPC_VLAN_TAG1, NPC_LID_LB, NPC_LT_LB_CTAG, 2, 2);
 	NPC_SCAN_HDR(NPC_VLAN_TAG2, NPC_LID_LB, NPC_LT_LB_STAG_QINQ, 2, 2);
 	NPC_SCAN_HDR(NPC_VLAN_TAG3, NPC_LID_LB, NPC_LT_LB_STAG_QINQ, 6, 2);
+	NPC_SCAN_HDR(NPC_GTPU_TEID, NPC_LID_LE, NPC_LT_LE_GTPU, 4, 4);
+	NPC_SCAN_HDR(NPC_GTPC_TEID, NPC_LID_LE, NPC_LT_LE_GTPC, 4, 4);
 	NPC_SCAN_HDR(NPC_DMAC, NPC_LID_LA, la_ltype, la_start, 6);
 
 	NPC_SCAN_HDR(NPC_IPSEC_SPI, NPC_LID_LD, NPC_LT_LD_AH, 4, 4);
@@ -720,9 +724,10 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
 		*features |= BIT_ULL(NPC_IPPROTO_ICMP6);
 	}
 
-	/* for ESP, check if corresponding layer type is present in the key */
+	/* for ESP/GTP-U/GTP-C check if corresponding layer type is present in the key */
 	if (npc_check_field(rvu, blkaddr, NPC_LE, intf))
-		*features |= BIT_ULL(NPC_IPPROTO_ESP);
+		*features |= BIT_ULL(NPC_IPPROTO_ESP) | BIT_ULL(NPC_GTPU_TEID) |
+			     BIT_ULL(NPC_GTPC_TEID);
 
 	/* for vlan corresponding layer type should be in the key */
 	if (*features & BIT_ULL(NPC_OUTER_VID))
@@ -1113,6 +1118,14 @@ void npc_update_flow(struct rvu *rvu, struct mcam_entry_mdata *mdata,
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
@@ -1209,6 +1222,10 @@ do {									      \
 
 	NPC_WRITE_FLOW(NPC_IPFRAG_IPV6, next_header, pkt->next_header, 0,
 		       mask->next_header, 0);
+	NPC_WRITE_FLOW(NPC_GTPU_TEID, gtpu_teid, ntohl(pkt->gtpu_teid), 0,
+		       ntohl(mask->gtpu_teid), 0);
+	NPC_WRITE_FLOW(NPC_GTPC_TEID, gtpc_teid, ntohl(pkt->gtpc_teid), 0,
+		       ntohl(mask->gtpc_teid), 0);
 	npc_update_ipv6_flow(rvu, mdata, features, pkt, mask, output, intf);
 	npc_update_vlan_features(rvu, mdata, features, intf);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 99d78fc5a2c4..59ea2da33ae2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -11,6 +11,8 @@
 #include "otx2_common.h"
 
 #define OTX2_DEFAULT_ACTION	0x1
+#define GTPU_PORT		2152
+#define GTPC_PORT		2123
 
 struct otx2_flow {
 	struct ethtool_rx_flow_spec flow_spec;
@@ -1036,8 +1038,29 @@ static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
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
+			if (ntohs(pkt->dport) == GTPU_PORT) {
+				/* Check for GTP-U packets */
+				skip_user_def = true;
+				pkt->gtpu_teid = fsp->h_ext.data[1];
+				pmask->gtpu_teid = fsp->m_ext.data[1];
+				req->features |= BIT_ULL(NPC_GTPU_TEID);
+			} else if (ntohs(pkt->dport) == GTPC_PORT) {
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
-- 
2.43.0

