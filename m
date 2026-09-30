Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF833B0580;
	Wed, 30 Sep 2026 05:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790745300; cv=none; b=BJMWrUObLpVZbLXVR6XJeJ0y1tBh+gUGOBYYr41fVWO43V5biXNM0mv+91rmkFvEBY+tobBPUVIbmFs+6v1znPVMNCo/EA44FI3PnYnVYj3lYn7Y9CC1cZ6qb5qQ9hnc9KoNPu0V1UzwnL1jJeKwXfT3+V+t1Han6D4x17OC1F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790745300; c=relaxed/simple;
	bh=VMF8bbzX7F10FQtsgeT1wMb3AXGnt/30jnwIjRC5qNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QELxqtwniYHZ+9bDcq43PaX5BtYb8Zcob7iEEsogxRvQqp6pzi4nTtCZxR4BaUDWCvzrPtgAIWgko9nWSI6Rya/RkUeD+eu+/BVVlqprO+vVjqgVoxZAJkquAgNcdHbDf23J+pKxZ0dJgPyzsY1BX32GFrtniQdL19DozhWuzZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G4db7yR/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G4db7yR/"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TNQA8E2012373;
	Wed, 30 Sep 2026 05:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nGEgNqOc9Du
	ianw/WzovK/tf/zF9kc7LQqFG8XGx+B8=; b=G4db7yR/tMqAFvLPjbyrU7S25bZ
	+fV4vYgbsVMpSJvxoa2Sc5k/oDVNAM7eWO1nU6NpX5Z9adDmeTsrfMtPJ53AReNr
	+Zn2rrfbIOU/QZ9j1c6Ibkec84a0KDUq/U9M3nevVOQf6CrlaOVSR5QY0pEnN4GM
	DeixdponWake2ybhvTNx9NvhCP9Rcm78LBmNocaxQafrS++nrAauSQXqS3LQQuz7
	3C1xTn2TYSB84dohN8vKM7UjhNZqLNuwfFmWDyKe/VVOnLO5mEi6B7gQbr+OOKPU
	IzeGlrS0+qlWKLtUK3N4dVrT4NSx+wrxsQeUFTncjoKg8uuHvfKFuok6kcA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0j0ejgug-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 05:14:34 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U5E1F01549983;
	Wed, 30 Sep 2026 05:14:33 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 68U5EX401552842
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 05:14:33 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id 2E945AC1; Tue, 29 Sep 2026 22:14:33 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next 4/7] net: qualcomm: rmnet: Add DL packet coalescing support
Date: Tue, 29 Sep 2026 22:13:42 -0700
Message-Id: <20260930051345.857443-5-subash.a.kasiviswanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930051345.857443-1-subash.a.kasiviswanathan@oss.qualcomm.com>
References: <20260930051345.857443-1-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=cqgOAF4i c=1 sm=1 tr=0 ts=6abc9abb cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=KYMRCGCj0O7CP-3BYPAA:9
X-Proofpoint-GUID: Hm5Ysb9kAfx_xOY_--xXwHhHpATqebON
X-Proofpoint-ORIG-GUID: Hm5Ysb9kAfx_xOY_--xXwHhHpATqebON
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyMCBTYWx0ZWRfX9KQ3MU4cubVV
 l+Cn7PIJXhr0xtUStTFX+4b0JGr6NB0Oj9GFMYVZgo29kPUuPRfX7D5FENNfw4JyeTsjX5bld1q
 BAwXNnJxnwB96VrI6aLmBbY1tUuOMhA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyMCBTYWx0ZWRfX7as6QTNdQ8xd
 ln190pZEvcFK7ghwRup4u/SlhBGKJkJl/V8hrR7KyIaW93mlF0rgsPsHYTvs740MDfd58sumb8t
 um+Dj666kZ9aaXHYxfgQqlU7kA3/g5yjtlAJM69syCwKW57Y/i0Flb+jnRwaFY4p6BiMLxqkv6U
 BJD0yUjpd0tklCK9TzvXqurnqKz4RittQF4X3VkIUgtM8cilAgJmn56q3BBgV1ZTojEfDc7+BYI
 yKOJXgnSwbPZj4ZiSOC6ceYToFMzz1vBIULx4zblxFflFeozSJKoyNEEvfdBGVw+cKiggEED7nu
 qgrQzZans908YG/lr6RLVsp2ZIC7BukTBIzYCU1rkp35pRG6DFuiK8EGgvGOpmfYw5q4EbVW+xP
 7NfYX0+xTqwiyOwCRPKMVOZITLElo3FtajME+As+W10W8KFO/A0ntU8Y0yV6anKlfUtWTJ7Hco/
 1NupxYvgnl0cA92AUrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300020

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

Any packet queued to the network stack would have the gso information
populated in the skb and partial checksum set. If a packet is segmented,
the IP length and checksum are also updated accordingly.

DL packet coalescing relies on the MAPv5 checksum header being present
on ingress, so reject any configuration which requests coalescing
without also enabling MAPv5 ingress checksum offload.

Co-developed-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
---
 .../ethernet/qualcomm/rmnet/rmnet_config.c    |  12 +-
 .../ethernet/qualcomm/rmnet/rmnet_handlers.c  |   5 +-
 .../net/ethernet/qualcomm/rmnet/rmnet_map.h   |  18 +-
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 512 +++++++++++++++++-
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   |   1 +
 include/linux/if_rmnet.h                      |  31 ++
 6 files changed, 563 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 8051aef01ae3..555659c2edc2 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -30,7 +30,8 @@ static int rmnet_is_real_dev_registered(const struct net_device *real_dev)
  * offload), MAPv4 (v4 checksum offload) and MAPv5 (v5 checksum
  * offload). QMAP command support is orthogonal and permitted with
  * any of the three. Mixing v4 and v5 checksum offload flags together
- * is not a supported configuration.
+ * is not a supported configuration. DL packet coalescing additionally
+ * requires a MAPv5 configuration.
  */
 static bool rmnet_config_data_format_valid(u32 data_format)
 {
@@ -39,7 +40,14 @@ static bool rmnet_config_data_format_valid(u32 data_format)
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
index 577f2758e385..bb88e19e28d8 100644
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
 
@@ -518,13 +539,482 @@ static bool rmnet_map_get_csum_valid(struct sk_buff *skb)
 	return !!(hdr->csum_info & MAPV5_CSUMINFO_VALID_FLAG);
 }
 
-int rmnet_map_process_next_hdr_packet(struct sk_buff *skb,
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
+		if (ret < 0 || frag_off)
+			return false;
+
+		meta->ip_len = (u16)ret;
+		meta->trans_proto = protocol;
+		meta->ip_header = ip6h;
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
+/* Reject the frame if the total data bytes claimed by all NLOs exceed
+ * the actual payload in the SKB.  Each pkt_len covers IP+transport
+ * headers plus per-packet data. Headers appear once, so subtract hlen
+ * per packet and check the running sum against available data.
+ */
+static bool rmnet_map_coal_validate_bounds(struct sk_buff *coal_skb,
+					   struct rmnet_map_v5_coal_header *coal_hdr,
+					   u8 num_nlos, u32 hlen)
+{
+	u32 total_data = 0;
+	u32 nlo_len;
+	u16 plen;
+	u8 i;
+
+	for (i = 0; i < num_nlos; i++) {
+		plen = ntohs(coal_hdr->nl_pairs[i].pkt_len);
+
+		if (plen < hlen)
+			return false;
+
+		nlo_len = (u32)(plen - hlen) * coal_hdr->nl_pairs[i].num_packets;
+		if (total_data + nlo_len > coal_skb->len - hlen)
+			return false;
+
+		total_data += nlo_len;
+	}
+
+	return true;
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
+								     total_pkt,
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
+						     total_pkt, true);
+	}
+}
+
+/* Expand a coalesced SKB into individual IP packets placed on the list.
+ * NLOs with checksum errors are dropped. __rmnet_map_ingress_handler will
+ * free the SKB in the error case.
+ */
+static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
+				      u64 nlo_err_mask,
 				      struct sk_buff_head *list,
 				      u16 len)
+{
+	bool gro = coal_skb->dev->features & NETIF_F_GRO_HW;
+	struct rmnet_map_v5_coal_header *coal_hdr;
+	struct rmnet_map_coal_metadata coal_meta;
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
+	if (!rmnet_map_coal_validate_bounds(coal_skb, coal_hdr, num_nlos, hlen))
+		return -EINVAL;
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
+					    u64 *nlo_err_mask)
+{
+	struct rmnet_map_header *maph = (struct rmnet_map_header *)skb->data;
+	struct rmnet_map_v5_coal_header *coal_hdr;
+	u8 num_nlos, pkts = 0;
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
+		pkts += pkt;
+		if (pkts > RMNET_MAP_V5_MAX_PACKETS)
+			return -EINVAL;
+	}
+
+	*nlo_err_mask = mask;
+	return 0;
+}
+
+int rmnet_map_process_next_hdr_packet(struct sk_buff *skb,
+				      struct sk_buff_head *list,
+				      u16 len, u32 data_format)
 {
 	struct rmnet_priv *priv = netdev_priv(skb->dev);
+	u64 nlo_err_mask;
+	int rc;
 
 	switch (rmnet_map_get_next_hdr_type(skb)) {
+	case RMNET_MAP_HEADER_TYPE_COALESCING:
+		if (!(data_format & RMNET_FLAGS_INGRESS_COALESCE))
+			return -EINVAL;
+
+		rc = rmnet_map_data_check_coal_header(skb, &nlo_err_mask);
+		if (rc)
+			return rc;
+
+		rc = rmnet_map_segment_coal_skb(skb, nlo_err_mask, list, len);
+		if (rc)
+			return rc;
+
+		if (skb_peek(list) != skb)
+			consume_skb(skb);
+		break;
+
 	case RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD:
 		if (unlikely(!(skb->dev->features & NETIF_F_RXCSUM))) {
 			priv->stats.csum_sw++;
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index 5f921cddf82b..e1e319683a55 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -323,6 +323,7 @@ int rmnet_vnd_newlink(u8 id, struct net_device *rmnet_dev,
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

