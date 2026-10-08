Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A2B2D7D47;
	Thu,  8 Oct 2026 00:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791421047; cv=none; b=MdIYrRSrgoktSE6ovFaXjxeqng+qUpxnffg/XewLaPEWVEVEa4xsGZPhcIyaDLVJ09sz+iCzvr3vIgBurdUK7/OMqlG0d8i3ir20mfMsURW3sH26/bz2+fOJVMUMOwdP3kDOiXVm4YTp+3dnsxbqZjV+9pFc7G1Ume1c5CPJb3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791421047; c=relaxed/simple;
	bh=v7B9i1VfDljCdEgQnoSfORwhkfk8rgMBRGXn3OOda4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NJ7gIAqnnfXs3oPxVJaP7XfMvs6qI5CugN29HVjPAh3TWrE1AReqgJJu2XGpRLD8Nd3c/alAJnuyyj8QPkyKv5th5Qm4rhn/1laIOhGqT+BP5A8FLlx5IxxttAshkHt5oqzDTBaVWZOJ52xvcyIQCW3gD14zXIwPWVQL9M+nmx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Es34JSdM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Es34JSdM"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697Ltn8B356479;
	Thu, 8 Oct 2026 00:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8g+cYB/gmrX
	Z+7YLMQrfybOgkX9xHuENYeWa80BuSA8=; b=Es34JSdM4I2RX9jG8CZQDpdUhtK
	ayvmpcJBw5wH1JRp8jTEWje85Q+gVsxdUf7JRnvkk/rXYIV2qJO9dIyQ/X7n2VNK
	/o1bWJF2GMyYuDSJt+k93Dnls37ZrM/ZmFLGo5YGn1XF4p8ZzxC1C/d8Vkx9VWs9
	WoN7HvPthv1fbro3G5YgRj25xpVvJ6w6Nt1Dt4++r9/dtgi5a8sBhCwsxwI+9T+T
	NXUIAspZKvcUmxAF2+KpHnMiKEKvC9N94e9+v/qzFsy9x4rlZrqqUEfb53ZlcKf1
	XTWmgll0L5lR59C7w22vgmJqGKN1GiZJniUQodki7DnuE2qehbxLvT/07Tg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe50fts-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 00:56:58 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6980uvi31429386;
	Thu, 8 Oct 2026 00:56:57 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6980uvm91429359
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 00:56:57 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id B29A2AD8; Wed,  7 Oct 2026 17:56:56 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next v2 5/8] net: qualcomm: rmnet: Add DL packet coalescing support
Date: Wed,  7 Oct 2026 17:55:42 -0700
Message-Id: <20261008005543.2630828-6-subash.a.kasiviswanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008005543.2630828-1-subash.a.kasiviswanathan@oss.qualcomm.com>
References: <20261008005543.2630828-1-subash.a.kasiviswanathan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: Nukdgdw82QvCSrZpsD_3rZP0OIDU0sAv
X-Authority-Analysis: v=2.4 cv=E4dYNqdl c=1 sm=1 tr=0 ts=6ac6ea5a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=wuWXtPjZ_Sd4MYLD3REA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwMyBTYWx0ZWRfX072CMmwo4div
 H5RBrz6R/WDoLF0Cd+ypjG2x9SF9gUTDs3xKMcPYTGw3aCXPjQCwZ13J5Op/FijGKEZib8TFnJG
 rpwhsoAF0CrlTxZjvM6sUHMdcbACtHQ=
X-Proofpoint-GUID: Nukdgdw82QvCSrZpsD_3rZP0OIDU0sAv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwMyBTYWx0ZWRfX7ZKEJL0gbBiH
 Dw4LxfFKxavAD89HA+Aw3WVM3TDiAM1oSCHtkBCpGBItppZDPLI+pPBD+aKz9JAECCNoJefFlNv
 JTrwuwFDd4RKLkyJjBtp65mCS/xiWrMk0dJUbubznYdBhxGw/8RA5flkwSyHQdN3qy/1zpg8g3b
 s6WhBn7O8OtQr1f9YaJhGuq3MERhpLUZia8Ngx/VdfjktfMUoapZZb18cdaI3OVfgEKQvDkTt33
 ZnQFz4v7tWvksMdI7XmQNCZmsqy+bsYxh4JoKO5fbBkAlctSj65lg3o7T5Zc6NgxcUxoK/FoG1z
 0EwUuHScpKNPTJG3dLvZXsNpqeHIys/7b9v8nKgL7IggK5j0H8K5heful6d/XUua2RppKr2SO9T
 J7IggoUPSc0cvinr3cyAkvDKSj+JwAerQGKSdBZmKzOQmRbduyGTkmcdcfIsG7r81fvETlGy+8p
 ShprSfTPZFtX2REr6Vw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080003

Hardware can coalesce multiple IP packets of a flow into a single MAP
frame carrying a MAPv5 coalescing header and a set of Number Length
Objects (NLOs) that describe the count and length of the individual
segments within. The MAP coalescing header encapsulates a single IP
packet of type IPv4 and IPv6 for protocols TCP and UDP. Up to 48 IP
packets can be coalesced into a single coalescing packet.

This means that hardware can coalesce up to 6 different sizes within a
single IP packet. Additionally, hardware can continue to coalesce
packets even though it may have detected an issue with the checksum. The
checksum bitmap will give information on the exact segments which
happened to encounter a bad checksum. In these cases, the packets need
to be segmented out from the whole IP packet and only the packets with
same size need to be queued to the stack for valid checksum packets
while invalid checksum packets are dropped in the driver.

Coalesced frames containing multiple packets are accepted only when
both RXCSUM and GRO_HW are enabled. Such packets are either queued
through the GRO fast path or segmented in the driver. The resulting SKBs
carry CHECKSUM_PARTIAL and SKBs representing multiple packets also carry
the appropriate GSO metadata.

GRO_HW is advertised as an optional hardware feature and can be enabled
through the normal netdev feature controls. A single-packet frame is
passed with CHECKSUM_UNNECESSARY when both features are enabled and with
CHECKSUM_NONE when either feature is disabled. Multi-packet coalesced
frames are dropped when either RXCSUM or GRO_HW is disabled.

If a packet is segmented, the IP length and checksum are also updated
accordingly.

DL packet coalescing relies on the MAPv5 checksum header being present
on ingress, so reject any configuration which requests coalescing without
also enabling MAPv5 ingress checksum offload.

Co-developed-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
---
v2: 
  - Add checks for packet content validation to avoid invalid access
  - Add better handling of the GRO_HW and RXCSUM flags
  - unclone prior to coalescing packet modifications
  - Tag drops with kfree_skb instead of consume_skb
  - Add more comments and update commit text about the coalescing
    operations
v1: https://lore.kernel.org/all/20260930051345.857443-5-subash.a.kasiviswanathan@oss.qualcomm.com/

 .../ethernet/qualcomm/rmnet/rmnet_config.c    |  12 +-
 .../ethernet/qualcomm/rmnet/rmnet_handlers.c  |   5 +-
 .../net/ethernet/qualcomm/rmnet/rmnet_map.h   |  18 +-
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 560 +++++++++++++++++-
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   |   1 +
 include/linux/if_rmnet.h                      |  31 +
 6 files changed, 611 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index b68f5561680f..ec882ad371ab 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -31,7 +31,8 @@ static int rmnet_is_real_dev_registered(const struct net_device *real_dev)
  * offload). MAP command support is orthogonal and permitted with any
  * of the three. Checksum offload versions are selected independently
  * for ingress and egress, but only one version may be enabled across
- * the device. Mixing v4 and v5 checksum flags is not supported.
+ * the device. Mixing v4 and v5 checksum flags is not supported. DL
+ * packet coalescing additionally requires a MAPv5 configuration.
  */
 static bool rmnet_config_data_format_valid(u32 data_format)
 {
@@ -40,7 +41,14 @@ static bool rmnet_config_data_format_valid(u32 data_format)
 	u32 v5_mask = RMNET_FLAGS_INGRESS_MAP_CKSUMV5 |
 		      RMNET_FLAGS_EGRESS_MAP_CKSUMV5;
 
-	return !(data_format & v4_mask) || !(data_format & v5_mask);
+	if ((data_format & v4_mask) && (data_format & v5_mask))
+		return false;
+
+	if ((data_format & RMNET_FLAGS_INGRESS_COALESCE) &&
+	    !(data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5))
+		return false;
+
+	return true;
 }
 
 /* Needs rtnl lock */
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
index ab1dfbd833e3..bb867ceb01c1 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
@@ -96,9 +96,10 @@ __rmnet_map_ingress_handler(struct sk_buff *skb,
 
 	__skb_queue_head_init(&list);
 
-	if ((data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5) &&
+	if ((data_format &
+	     (RMNET_FLAGS_INGRESS_MAP_CKSUMV5 | RMNET_FLAGS_INGRESS_COALESCE)) &&
 	    (map_header->flags & MAP_NEXT_HEADER_FLAG)) {
-		if (rmnet_map_process_next_hdr_packet(skb, &list, len))
+		if (rmnet_map_process_next_hdr_packet(skb, &list, len, data_format))
 			goto free_skb;
 	} else {
 		/* Subtract MAP header */
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
index ef738ce015d4..77ddac6023c0 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
@@ -6,6 +6,22 @@
 #define _RMNET_MAP_H_
 #include <linux/if_rmnet.h>
 
+enum rmnet_map_v5_close_type {
+	RMNET_MAP_COAL_CLOSE_NON_COAL,
+	RMNET_MAP_COAL_CLOSE_IP_MISS,
+	RMNET_MAP_COAL_CLOSE_TRANS_MISS,
+	RMNET_MAP_COAL_CLOSE_HW,
+	RMNET_MAP_COAL_CLOSE_COAL,
+};
+
+enum rmnet_map_v5_close_value {
+	RMNET_MAP_COAL_CLOSE_HW_NL,
+	RMNET_MAP_COAL_CLOSE_HW_PKT,
+	RMNET_MAP_COAL_CLOSE_HW_BYTE,
+	RMNET_MAP_COAL_CLOSE_HW_TIME,
+	RMNET_MAP_COAL_CLOSE_HW_EVICT,
+};
+
 struct rmnet_map_control_command {
 	u8  command_name;
 	u8  cmd_type:2;
@@ -55,7 +71,7 @@ void rmnet_map_checksum_uplink_packet(struct sk_buff *skb,
 				      int csum_type);
 int rmnet_map_process_next_hdr_packet(struct sk_buff *skb,
 				      struct sk_buff_head *list,
-				      u16 len);
+				      u16 len, u32 data_format);
 unsigned int rmnet_map_tx_aggregate(struct sk_buff *skb, struct rmnet_port *port,
 				    struct net_device *orig_dev);
 void rmnet_map_tx_aggregate_init(struct rmnet_port *port);
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 577f2758e385..5ffb811d7ef1 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -7,7 +7,11 @@
 #include <linux/netdevice.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <net/ip.h>
 #include <net/ip6_checksum.h>
+#include <net/ipv6.h>
 #include <linux/bitfield.h>
 #include "rmnet_config.h"
 #include "rmnet_map.h"
@@ -17,6 +21,19 @@
 #define RMNET_MAP_DEAGGR_SPACING  64
 #define RMNET_MAP_DEAGGR_HEADROOM (RMNET_MAP_DEAGGR_SPACING / 2)
 
+struct rmnet_map_coal_metadata {
+	void *ip_header;
+	void *trans_header;
+	u16 ip_len;
+	u16 trans_len;
+	u16 data_offset;
+	u16 data_len;
+	u8 ip_proto;
+	u8 trans_proto;
+	u8 pkt_count;
+	bool zero_csum;
+};
+
 static __sum16 *rmnet_map_get_csum_field(unsigned char protocol,
 					 const void *txporthdr)
 {
@@ -337,8 +354,8 @@ u32 rmnet_map_validate_packet_len(struct sk_buff *skb, u32 data_format)
 {
 	struct rmnet_map_v5_csum_header *next_hdr = NULL;
 	struct rmnet_map_header *maph;
-	void *data = skb->data;
 	u32 packet_len;
+	u8 hdr_type;
 
 	if (skb->len < sizeof(*maph))
 		return 0;
@@ -353,24 +370,28 @@ u32 rmnet_map_validate_packet_len(struct sk_buff *skb, u32 data_format)
 
 	if (data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV4) {
 		packet_len += sizeof(struct rmnet_map_dl_csum_trailer);
-	} else if ((data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5) &&
+	} else if ((data_format &
+		    (RMNET_FLAGS_INGRESS_MAP_CKSUMV5 | RMNET_FLAGS_INGRESS_COALESCE)) &&
 		   !(maph->flags & MAP_CMD_FLAG)) {
-		/* Mapv5 data pkt without csum hdr is invalid */
 		if (!(maph->flags & MAP_NEXT_HEADER_FLAG))
 			return 0;
 
-		packet_len += sizeof(*next_hdr);
-		next_hdr = data + sizeof(*maph);
+		if (skb->len < sizeof(*maph) + sizeof(*next_hdr))
+			return 0;
+
+		next_hdr = (struct rmnet_map_v5_csum_header *)(skb->data + sizeof(*maph));
+		hdr_type = u8_get_bits(next_hdr->header_info,
+				       MAPV5_HDRINFO_HDR_TYPE_FMASK);
+
+		if (hdr_type == RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD)
+			packet_len += sizeof(*next_hdr);
+		else if (hdr_type != RMNET_MAP_HEADER_TYPE_COALESCING)
+			return 0;
 	}
 
 	if (skb->len < packet_len)
 		return 0;
 
-	if (next_hdr &&
-	    u8_get_bits(next_hdr->header_info, MAPV5_HDRINFO_HDR_TYPE_FMASK) !=
-	    RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD)
-		return 0;
-
 	return packet_len;
 }
 
@@ -518,13 +539,530 @@ static bool rmnet_map_get_csum_valid(struct sk_buff *skb)
 	return !!(hdr->csum_info & MAPV5_CSUMINFO_VALID_FLAG);
 }
 
+/* Stamp GSO metadata so the network stack can segment a coalesced SKB. */
+static void rmnet_map_gso_stamp(struct sk_buff *skb,
+				struct rmnet_map_coal_metadata *coal_meta)
+{
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+
+	if (coal_meta->trans_proto == IPPROTO_TCP)
+		shinfo->gso_type = (coal_meta->ip_proto == 4) ?
+				   SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
+	else
+		shinfo->gso_type = SKB_GSO_UDP_L4;
+
+	shinfo->gso_size = coal_meta->data_len;
+	shinfo->gso_segs = coal_meta->pkt_count;
+}
+
+/* Set the transport checksum to the pseudo-header checksum and request
+ * partial checksum offload, letting the NIC or stack finish it.
+ */
+static void rmnet_map_partial_csum(struct sk_buff *skb,
+				   struct rmnet_map_coal_metadata *coal_meta)
+{
+	u16 pkt_len = skb->len - coal_meta->ip_len;
+	unsigned char *data = skb->data;
+	__sum16 pseudo;
+
+	if (coal_meta->ip_proto == 4) {
+		struct iphdr *iph = (struct iphdr *)data;
+
+		pseudo = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
+					    pkt_len, coal_meta->trans_proto, 0);
+	} else {
+		struct ipv6hdr *ip6h = (struct ipv6hdr *)data;
+
+		pseudo = ~csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr,
+					  pkt_len, coal_meta->trans_proto, 0);
+	}
+
+	if (coal_meta->trans_proto == IPPROTO_TCP) {
+		struct tcphdr *tp = (struct tcphdr *)(data + coal_meta->ip_len);
+
+		tp->check = pseudo;
+		skb->csum_offset = offsetof(struct tcphdr, check);
+	} else {
+		struct udphdr *up = (struct udphdr *)(data + coal_meta->ip_len);
+
+		up->check = pseudo;
+		skb->csum_offset = offsetof(struct udphdr, check);
+	}
+
+	skb->ip_summed = CHECKSUM_PARTIAL;
+	skb->csum_start = skb->data + coal_meta->ip_len - skb->head;
+}
+
+/* Carve one logical segment from a coalesced SKB and append it to the list.
+ * Adjusts TCP sequence numbers, IP IDs/lengths, and checksum state.
+ */
+static void
+__rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
+			     struct rmnet_map_coal_metadata *coal_meta,
+			     struct sk_buff_head *list, u8 pkt_id,
+			     bool csum_valid)
+{
+	u32 dlen = coal_meta->data_len * coal_meta->pkt_count;
+	u32 hlen = coal_meta->ip_len + coal_meta->trans_len;
+	struct sk_buff *skbn;
+
+	/* RFC 768: UDP checksum is optional for IPv4, and is 0 if unused.
+	 * Such packets are never actually bad, regardless of what the
+	 * checksum bitmap says.
+	 */
+	if (!csum_valid && coal_meta->zero_csum)
+		csum_valid = true;
+
+	if (!csum_valid)
+		goto next_pkt;
+
+	skbn = alloc_skb(hlen + dlen + RMNET_MAP_DEAGGR_HEADROOM, GFP_ATOMIC);
+	if (!skbn)
+		goto next_pkt;
+
+	skb_reserve(skbn, hlen + RMNET_MAP_DEAGGR_HEADROOM);
+	skb_put_data(skbn,
+		     coal_skb->data + coal_meta->ip_len + coal_meta->trans_len +
+		     coal_meta->data_offset,
+		     dlen);
+
+	/* Restore transport header */
+	skb_push(skbn, coal_meta->trans_len);
+	memcpy(skbn->data, coal_meta->trans_header, coal_meta->trans_len);
+	skb_reset_transport_header(skbn);
+
+	if (coal_meta->trans_proto == IPPROTO_TCP) {
+		struct tcphdr *th = tcp_hdr(skbn);
+
+		th->seq = htonl(ntohl(th->seq) + coal_meta->data_offset);
+		/* Strip dangerous flags from non-final segments */
+		if ((th->fin || th->psh) &&
+		    hlen + coal_meta->data_offset + dlen < coal_skb->len) {
+			th->fin = 0;
+			th->psh = 0;
+		}
+	} else if (coal_meta->trans_proto == IPPROTO_UDP) {
+		struct udphdr *uh = udp_hdr(skbn);
+
+		uh->len = htons(skbn->len);
+	}
+
+	/* Restore IP header */
+	skb_push(skbn, coal_meta->ip_len);
+	memcpy(skbn->data, coal_meta->ip_header, coal_meta->ip_len);
+	skb_reset_network_header(skbn);
+
+	if (coal_meta->ip_proto == 4) {
+		struct iphdr *iph = ip_hdr(skbn);
+
+		iph->id = htons(ntohs(iph->id) + pkt_id);
+		iph->tot_len = htons(skbn->len);
+		iph->check = 0;
+		iph->check = ip_fast_csum(iph, iph->ihl);
+	} else {
+		ipv6_hdr(skbn)->payload_len =
+			htons(skbn->len - sizeof(struct ipv6hdr));
+	}
+
+	rmnet_map_partial_csum(skbn, coal_meta);
+
+	skbn->dev = coal_skb->dev;
+
+	if (coal_meta->pkt_count > 1)
+		rmnet_map_gso_stamp(skbn, coal_meta);
+
+	__skb_queue_tail(list, skbn);
+
+next_pkt:
+	coal_meta->data_offset += dlen;
+	coal_meta->pkt_count = 0;
+}
+
+/* Parse the IP header of the coalesced frame and perform basic
+ * validation of header fields.
+ */
+static bool rmnet_map_coal_parse_ip_hdr(struct sk_buff *coal_skb,
+					struct rmnet_map_coal_metadata *meta,
+					bool *gro)
+{
+	struct ipv6hdr *ip6h;
+	struct iphdr *iph;
+	__be16 frag_off;
+	u8 protocol;
+	int ret;
+
+	if (coal_skb->len < sizeof(*iph))
+		return false;
+
+	iph = (struct iphdr *)coal_skb->data;
+
+	if (iph->version == 4) {
+		meta->ip_proto = 4;
+		meta->ip_len = iph->ihl * 4;
+		meta->trans_proto = iph->protocol;
+		meta->ip_header = iph;
+		if (meta->ip_len < sizeof(*iph) || coal_skb->len < meta->ip_len)
+			return false;
+
+		if (ip_is_fragment(iph))
+			return false;
+
+		if (iph->ihl != 5)
+			*gro = false;
+	} else if (iph->version == 6) {
+		if (coal_skb->len < sizeof(*ip6h))
+			return false;
+
+		ip6h = (struct ipv6hdr *)iph;
+		protocol = ip6h->nexthdr;
+		meta->ip_proto = 6;
+		ret = ipv6_skip_exthdr(coal_skb, sizeof(*ip6h), &protocol,
+				       &frag_off);
+		if (ret < 0 || frag_off || ret > U16_MAX)
+			return false;
+
+		meta->ip_len = (u16)ret;
+		meta->trans_proto = protocol;
+		meta->ip_header = ip6h;
+		if (coal_skb->len < meta->ip_len)
+			return false;
+
+		if (meta->ip_len > sizeof(*ip6h))
+			*gro = false;
+	} else {
+		return false;
+	}
+
+	return true;
+}
+
+/* Parse the transport header following the IP header into coal_meta. The
+ * available length is checked before any field is read.
+ */
+static bool rmnet_map_coal_parse_trans_hdr(struct sk_buff *coal_skb,
+					   struct rmnet_map_coal_metadata *meta)
+{
+	struct udphdr *uh;
+	struct tcphdr *th;
+	u32 avail;
+	u8 *base;
+
+	if (meta->ip_len > coal_skb->len)
+		return false;
+
+	base = (u8 *)meta->ip_header + meta->ip_len;
+	avail = coal_skb->len - meta->ip_len;
+
+	if (meta->trans_proto == IPPROTO_TCP) {
+		if (avail < sizeof(*th))
+			return false;
+
+		th = (struct tcphdr *)base;
+		meta->trans_len = th->doff * 4;
+		meta->trans_header = th;
+		if (meta->trans_len < sizeof(*th) || avail < meta->trans_len)
+			return false;
+	} else if (meta->trans_proto == IPPROTO_UDP) {
+		if (avail < sizeof(*uh))
+			return false;
+
+		uh = (struct udphdr *)base;
+		meta->trans_len = sizeof(*uh);
+		meta->trans_header = uh;
+		if (meta->ip_proto == 4 && !uh->check)
+			meta->zero_csum = true;
+	} else {
+		return false;
+	}
+
+	return true;
+}
+
+/* Reject the frame unless the total data bytes claimed by all NLOs
+ * exactly match the actual payload in the SKB. Each pkt_len covers
+ * IP+transport headers plus per-packet data. Headers appear once, so
+ * subtract hlen per packet and track the running sum against available
+ * data. An exact match is required, not just an upper bound, so that
+ * GSO metadata stamped from the NLOs stays consistent with the real
+ * SKB length.
+ */
+static bool rmnet_map_coal_validate_bounds(struct sk_buff *coal_skb,
+					   struct rmnet_map_v5_coal_header *coal_hdr,
+					   u8 num_nlos, u32 hlen, bool *gro)
+{
+	u32 total_data = 0;
+	u32 nlo_len;
+	u16 plen;
+	u8 i;
+
+	if (hlen > coal_skb->len)
+		return false;
+
+	for (i = 0; i < num_nlos; i++) {
+		plen = ntohs(coal_hdr->nl_pairs[i].pkt_len);
+
+		if (plen < hlen)
+			return false;
+
+		/* Zero-payload packets cannot use GSO with a zero gso_size. */
+		if (plen == hlen)
+			*gro = false;
+
+		nlo_len = (u32)(plen - hlen) * coal_hdr->nl_pairs[i].num_packets;
+		if (nlo_len > coal_skb->len - hlen - total_data)
+			return false;
+
+		total_data += nlo_len;
+	}
+
+	return total_data == coal_skb->len - hlen;
+}
+
+/* Attempt the GRO-friendly fast path for a single-NLO, checksum-valid frame
+ * by reusing the original SKB and stamping GSO metadata instead of copying
+ * out each segment.  Returns true if the frame was consumed via the fast
+ * path, or false if the caller should fall back to full segmentation.
+ */
+static bool rmnet_map_coal_gro_fast_path(struct sk_buff *coal_skb,
+					 struct rmnet_map_v5_coal_header *coal_hdr,
+					 struct rmnet_map_coal_metadata *coal_meta,
+					 struct sk_buff_head *list,
+					 u8 num_nlos, bool gro)
+{
+	u32 hlen = coal_meta->ip_len + coal_meta->trans_len;
+
+	if (!gro || num_nlos != 1 ||
+	    !(coal_hdr->coal_info & MAPV5_COALINFO_CSUM_VALID_FLAG))
+		return false;
+
+	coal_meta->data_len = ntohs(coal_hdr->nl_pairs[0].pkt_len) - hlen;
+	coal_meta->pkt_count = coal_hdr->nl_pairs[0].num_packets;
+
+	coal_skb->ip_summed = CHECKSUM_UNNECESSARY;
+	if (coal_meta->pkt_count > 1) {
+		rmnet_map_partial_csum(coal_skb, coal_meta);
+		rmnet_map_gso_stamp(coal_skb, coal_meta);
+	}
+
+	__skb_queue_tail(list, coal_skb);
+	return true;
+}
+
+/* NLO packet lengths are already bounds-checked by
+ * rmnet_map_coal_validate_bounds() so no further validation is needed here.
+ */
+static void rmnet_map_coal_segment_loop(struct sk_buff *coal_skb,
+					struct rmnet_map_v5_coal_header *coal_hdr,
+					struct rmnet_map_coal_metadata *coal_meta,
+					struct sk_buff_head *list,
+					u64 nlo_err_mask, bool gro, u8 num_nlos)
+{
+	u32 hlen = coal_meta->ip_len + coal_meta->trans_len;
+	u8 pkt, total_pkt = 0;
+	bool csum_err;
+	u16 pkt_len;
+	u8 nlo;
+
+	for (nlo = 0; nlo < num_nlos; nlo++) {
+		pkt_len = ntohs(coal_hdr->nl_pairs[nlo].pkt_len);
+		pkt_len -= hlen;
+		coal_meta->data_len = pkt_len;
+
+		/* nlo_err_mask is one flat bitstream across all NLOs. Shift
+		 * it once per packet in absolute frame order and do not
+		 * re-align at the NLO boundary above. See the comment on
+		 * rmnet_map_data_check_coal_header() for why.
+		 */
+		for (pkt = 0; pkt < coal_hdr->nl_pairs[nlo].num_packets;
+		     pkt++, total_pkt++, nlo_err_mask >>= 1) {
+			csum_err = nlo_err_mask & 1;
+
+			if (!gro) {
+				coal_meta->pkt_count = 1;
+				__rmnet_map_segment_coal_skb(coal_skb, coal_meta,
+							     list, total_pkt,
+							     !csum_err);
+				continue;
+			}
+
+			if (csum_err) {
+				if (coal_meta->pkt_count)
+					__rmnet_map_segment_coal_skb(coal_skb,
+								     coal_meta,
+								     list,
+								     total_pkt -
+								     coal_meta->pkt_count,
+								     true);
+				coal_meta->pkt_count = 1;
+				__rmnet_map_segment_coal_skb(coal_skb, coal_meta,
+							     list, total_pkt,
+							     false);
+			} else {
+				coal_meta->pkt_count++;
+			}
+		}
+
+		/* Flush remaining packets from this NLO */
+		if (coal_meta->pkt_count)
+			__rmnet_map_segment_coal_skb(coal_skb, coal_meta, list,
+						     total_pkt - coal_meta->pkt_count, true);
+	}
+}
+
+/* Expand a coalesced SKB into individual IP packets placed on the list.
+ * NLOs with checksum errors are dropped. __rmnet_map_ingress_handler will
+ * free the SKB in the error case.
+ */
+static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
+				      u64 nlo_err_mask,
+				      struct sk_buff_head *list,
+				      u16 len, u16 total_pkts)
+{
+	bool gro_hw = coal_skb->dev->features & NETIF_F_GRO_HW;
+	bool rxcsum = coal_skb->dev->features & NETIF_F_RXCSUM;
+	struct rmnet_map_v5_coal_header *coal_hdr;
+	struct rmnet_map_coal_metadata coal_meta;
+	bool gro = gro_hw;
+	u8 num_nlos;
+	u32 hlen;
+
+	memset(&coal_meta, 0, sizeof(coal_meta));
+
+	/* Drop any MAP frame padding. The coal header is counted in len */
+	skb_pull(coal_skb, sizeof(struct rmnet_map_header));
+	skb_trim(coal_skb, len);
+	coal_hdr = (struct rmnet_map_v5_coal_header *)coal_skb->data;
+	num_nlos = u8_get_bits(coal_hdr->coal_info, MAPV5_COALINFO_NUM_NLOS_FMASK);
+	skb_pull(coal_skb, sizeof(*coal_hdr));
+
+	if (!rmnet_map_coal_parse_ip_hdr(coal_skb, &coal_meta, &gro))
+		return -EINVAL;
+
+	if (!rmnet_map_coal_parse_trans_hdr(coal_skb, &coal_meta))
+		return -EINVAL;
+
+	hlen = coal_meta.ip_len + coal_meta.trans_len;
+
+	if (!rmnet_map_coal_validate_bounds(coal_skb, coal_hdr, num_nlos, hlen,
+					    &gro))
+		return -EINVAL;
+
+	/* Device capability gates coalesced delivery. Packet format can still
+	 * disable GSO and use the per-packet fallback below.
+	 */
+	if (total_pkts > 1 && (!rxcsum || !gro_hw))
+		return -EINVAL;
+
+	if (total_pkts == 1 && (!rxcsum || !gro_hw)) {
+		coal_skb->ip_summed = CHECKSUM_NONE;
+		__skb_queue_tail(list, coal_skb);
+		return 0;
+	}
+
+	if (rmnet_map_coal_gro_fast_path(coal_skb, coal_hdr, &coal_meta, list,
+					 num_nlos, gro))
+		return 0;
+
+	rmnet_map_coal_segment_loop(coal_skb, coal_hdr, &coal_meta, list,
+				    nlo_err_mask, gro, num_nlos);
+
+	return 0;
+}
+
+/* Validate the coalescing header and build the checksum error mask.
+ *
+ * Checks performed:
+ *  - MAP pkt_len accommodates the coal header (coal header is counted in
+ *    pkt_len. pkt_len < sizeof(*coal_hdr) means no payload is possible).
+ *  - num_nlos is in [1, RMNET_MAP_V5_MAX_NLOS].
+ *  - Total packet count does not exceed RMNET_MAP_V5_MAX_PACKETS.
+ *
+ * nlo_err_mask is NOT six independent per-NLO bitmaps. Each nl_pairs
+ * slot only has room for an 8 bit csum_error_bitmap, but a single NLO
+ * can carry more than 8 packets (up to RMNET_MAP_V5_MAX_PACKETS), so
+ * hardware spills a wide NLO's error bits into the csum_error_bitmap
+ * bytes of the following slots rather than truncating them. The
+ * six bitmap bytes are therefore always concatenated in slot order
+ * into one flat RMNET_MAP_V5_MAX_NLOS * 8 = RMNET_MAP_V5_MAX_PACKETS
+ * bit value, addressed by a packet's absolute position in the frame,
+ * regardless of how many NLOs are actually in use. Receivers must
+ * walk it as a single contiguous stream and must not expect it to
+ * align it at NLO boundaries.
+ */
+static int rmnet_map_data_check_coal_header(struct sk_buff *skb,
+					    u64 *nlo_err_mask,
+					    u16 *num_pkts)
+{
+	struct rmnet_map_header *maph = (struct rmnet_map_header *)skb->data;
+	struct rmnet_map_v5_coal_header *coal_hdr;
+	u8 num_nlos;
+	u16 pkts = 0;
+	u64 mask = 0;
+	int i;
+
+	/* coal header is counted in pkt_len */
+	if (ntohs(maph->pkt_len) < sizeof(*coal_hdr))
+		return -EINVAL;
+
+	coal_hdr = (struct rmnet_map_v5_coal_header *)(skb->data + sizeof(*maph));
+	num_nlos = u8_get_bits(coal_hdr->coal_info, MAPV5_COALINFO_NUM_NLOS_FMASK);
+
+	if (num_nlos == 0 || num_nlos > RMNET_MAP_V5_MAX_NLOS)
+		return -EINVAL;
+
+	for (i = 0; i < RMNET_MAP_V5_MAX_NLOS; i++) {
+		u8 err = coal_hdr->nl_pairs[i].csum_error_bitmap;
+		u8 pkt = coal_hdr->nl_pairs[i].num_packets;
+
+		mask |= ((u64)err) << (8 * i);
+		if (i < num_nlos) {
+			pkts += pkt;
+			if (pkts > RMNET_MAP_V5_MAX_PACKETS)
+				return -EINVAL;
+		}
+	}
+
+	*nlo_err_mask = mask;
+	*num_pkts = pkts;
+	return 0;
+}
+
 int rmnet_map_process_next_hdr_packet(struct sk_buff *skb,
 				      struct sk_buff_head *list,
-				      u16 len)
+				      u16 len, u32 data_format)
 {
 	struct rmnet_priv *priv = netdev_priv(skb->dev);
+	u64 nlo_err_mask;
+	u16 num_pkts;
+	int rc;
 
 	switch (rmnet_map_get_next_hdr_type(skb)) {
+	case RMNET_MAP_HEADER_TYPE_COALESCING:
+		if (!(data_format & RMNET_FLAGS_INGRESS_COALESCE))
+			return -EINVAL;
+
+		rc = rmnet_map_data_check_coal_header(skb, &nlo_err_mask,
+						      &num_pkts);
+		if (rc)
+			return rc;
+
+		/* Coalescing rewrites shared packet data and GSO metadata. */
+		if (skb_unclone(skb, GFP_ATOMIC))
+			return -ENOMEM;
+
+		rc = rmnet_map_segment_coal_skb(skb, nlo_err_mask, list, len,
+						num_pkts);
+		if (rc)
+			return rc;
+
+		if (skb_peek(list) != skb) {
+			if (skb_queue_empty(list))
+				kfree_skb(skb);
+			else
+				consume_skb(skb);
+		}
+		break;
+
 	case RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD:
 		if (unlikely(!(skb->dev->features & NETIF_F_RXCSUM))) {
 			priv->stats.csum_sw++;
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index d23f74b0aa47..b8542d2f03b2 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -331,6 +331,7 @@ int rmnet_vnd_newlink(u8 id, struct net_device *rmnet_dev,
 	rmnet_dev->hw_features = NETIF_F_RXCSUM;
 	rmnet_dev->hw_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 	rmnet_dev->hw_features |= NETIF_F_SG;
+	rmnet_dev->hw_features |= NETIF_F_GRO_HW;
 
 	priv->real_dev = real_dev;
 
diff --git a/include/linux/if_rmnet.h b/include/linux/if_rmnet.h
index c44bf6e80ecb..5df4d417f3d2 100644
--- a/include/linux/if_rmnet.h
+++ b/include/linux/if_rmnet.h
@@ -70,5 +70,36 @@ struct rmnet_map_v5_csum_header {
 #define MAPV5_HDRINFO_HDR_TYPE_FMASK	GENMASK(7, 1)
 #define MAPV5_CSUMINFO_VALID_FLAG	BIT(7)
 
+#define RMNET_MAP_HEADER_TYPE_COALESCING   1
 #define RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD 2
+
+/* MAPv5 coalescing header */
+#define RMNET_MAP_V5_MAX_NLOS		6
+#define RMNET_MAP_V5_MAX_PACKETS	48
+
+/* One Number-Length Object pair: per-NLO packet count and length. */
+struct rmnet_map_v5_nl_pair {
+	__be16 pkt_len;
+	u8  csum_error_bitmap;
+	u8  num_packets;
+} __aligned(1);
+
+/* MAPv5 coalescing header: describes up to RMNET_MAP_V5_MAX_NLOS NLOs.
+ * The header immediately follows the MAP header in the frame and is
+ * included in the MAP pkt_len field.
+ */
+struct rmnet_map_v5_coal_header {
+	u8  header_info;	/* MAPV5_HDRINFO_NXT_HDR_FLAG, MAPV5_HDRINFO_HDR_TYPE_FMASK */
+	u8  coal_info;		/* MAPV5_COALINFO_* */
+	u8  close_info;		/* MAPV5_CLOSEINFO_* */
+	u8  veid_info;		/* MAPV5_VEIDINFO_* */
+	struct rmnet_map_v5_nl_pair nl_pairs[RMNET_MAP_V5_MAX_NLOS];
+} __aligned(1);
+
+#define MAPV5_COALINFO_NUM_NLOS_FMASK		GENMASK(6, 4)
+#define MAPV5_COALINFO_CSUM_VALID_FLAG		BIT(7)
+#define MAPV5_CLOSEINFO_CLOSE_TYPE_FMASK	GENMASK(3, 0)
+#define MAPV5_CLOSEINFO_CLOSE_VALUE_FMASK	GENMASK(7, 4)
+#define MAPV5_VEIDINFO_VEID_FMASK		GENMASK(3, 0)
+
 #endif /* !(_LINUX_IF_RMNET_H_) */
-- 
2.34.1

