Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA3B3B1016;
	Wed, 30 Sep 2026 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790745299; cv=none; b=C3ScRFPTxOmV7sy3oa6epIWrD7OtaB5jStf5vXf1kj2gQzy0K5L4ZsDkqmh43OKoeA4wMpe0IkgyU1QpJyLJX1JLQVCCIASTUgAAmUdrpe1p2UpATzrp+9kKtyjkfWDeYs4/jAq3gJzP0wz4U1ohe4CLFi+rNwtIIjWWtP0mKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790745299; c=relaxed/simple;
	bh=4DQMxhZSpaX88H78orOhkAmnQniVMXBQJxkzUgv+6NI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NWvIUJuLpWW5of4HrPIrdJTutOhp2UZfflNcTv/YbdT5w6Hw8K5A5piOfA7IUs7YmaErCd7qNmzv6+6tuoXhA53gJIKxiaMIHA8O4UuEi7QZ0QSJLRsh90Q1g1K+n1du2a5BHXndjjVp4F5AUACLO/4c1THO9LedqgzrM0VcLq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pMJ3i6Je; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pMJ3i6Je"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TNQIcQ484449;
	Wed, 30 Sep 2026 05:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=heAn0a44nug
	++l98LQBubZcd9Fa1OhiiMl8PSjOi36s=; b=pMJ3i6JeWjemLgrhF3DqJXhr8rO
	L+CkQZwkPFziusyRbssvTAi4hsaJjjdLrXSGpCZ7lL7bjQXQmmZZg5apKdDFK49c
	ir8UCZLDV2grwGvLtIItk1iuiP4eNS0GvLm4vD1SI6Z0HZxZw3yWZ9y0onlfr21L
	sjWNbmMur/NlezTE3OmKwrnSYkip+is6wVJMtB2kjdBVl4JesZdPy+AynkTtX9vk
	yYbq3OIynuukI1RN0pVRVPKOeE3na7G5mpl0rpLX6xO8XAMP/zbAO+zPrZM2E9vW
	AHY6XOf2YIJQT6TtynrOzY8raR/ZL1dqQUwOlibSUAqU3Gz6PyR0bHbFzvw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0dsx3vgw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 05:14:39 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U5EcsG1552728;
	Wed, 30 Sep 2026 05:14:38 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 68U5EckW1552718
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 05:14:38 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id DF6B4AC1; Tue, 29 Sep 2026 22:14:37 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next 6/7] net: qualcomm: rmnet: Add ethtool stats for DL coalescing
Date: Tue, 29 Sep 2026 22:13:44 -0700
Message-Id: <20260930051345.857443-7-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyMCBTYWx0ZWRfXwsfdznDZq8N2
 OnS7AfKw4AXoty9sl5pOar4KmnGLyk0rW4n0Rk0qCCVNCY+6vXi3Xe9GysyiUpRIst5p9EPIQyx
 NJurA5tMB/gJjwvnVd4WaB3nTCbTWIzqvO12TH23NJx1LuN2vDXCPuvA49HN9PLRNVp2855SUBM
 dNecLbPFcA+K97BaCcGi6VgKteT+PjODEphYpEIcuFid7gT/zkCwPJ4eC+PlmV0wAd4yqK8GVFk
 NNUzZ8uYlZVzaHF1b+0ZvJwW8LDKfEy2pPW/X+usI5oXIDScZPXwJmBgWZ4vFXLD2rGS5TI6d/Z
 Qd0KPNjPrc4anZFKNIbY0BK1D4V2SkznOIIu8+lWUFDZNyv118FrJf8dV+w/mjogPf1jHUc48nD
 5WwyBDA0eHieXllQFGhDtu7Bxhwuyl4oethe4Mhx3tSVONY5Vmfco40zVl3IPe2MGM80qKwJD7b
 YjDtwtkEsNN++M+NFEw==
X-Proofpoint-ORIG-GUID: zYbZx43Q3pMiVdFiIf9jpUBqcZb1TWOZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyMCBTYWx0ZWRfX7v5DYZEDH+iE
 8DeuTgxRcT1TBs/D8P0qvzCPlWNZ2qRhDju3hIKO1CSguieYgpWB+Brv0/V00fxp76w9MsHIfwo
 6k64U6zDpOLIhsCAlFmPEyntD6sr5tc=
X-Proofpoint-GUID: zYbZx43Q3pMiVdFiIf9jpUBqcZb1TWOZ
X-Authority-Analysis: v=2.4 cv=DqvDa2/+ c=1 sm=1 tr=0 ts=6abc9abf cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=QsziYRQwglh-mEha3X0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300020

Track coalescing decode activity with per-device counters and expose
them via ethtool. The counters include the coalescing related packet
counts, coalescing errors and reasons for coalescing completion.

Co-developed-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
---
 .../ethernet/qualcomm/rmnet/rmnet_config.h    |  20 ++++
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 110 ++++++++++++++++--
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   |  20 ++++
 3 files changed, 138 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
index 5adda0323dda..2a34f8a7b527 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
@@ -80,6 +80,26 @@ struct rmnet_priv_stats {
 	u64 csum_skipped;
 	u64 csum_sw;
 	u64 csum_hw;
+	/* DL coalescing */
+	u64 coal_rx;
+	u64 coal_pkts;
+	u64 coal_hdr_nlo_err;
+	u64 coal_hdr_pkt_err;
+	u64 coal_csum_err;
+	u64 coal_csum_drop;
+	u64 coal_reconstruct;
+	u64 coal_ip_invalid;
+	u64 coal_trans_invalid;
+	/* close-reason sub-counters */
+	u64 coal_close_non_coal;
+	u64 coal_close_ip_miss;
+	u64 coal_close_trans_miss;
+	u64 coal_close_hw_nl;
+	u64 coal_close_hw_pkt;
+	u64 coal_close_hw_byte;
+	u64 coal_close_hw_time;
+	u64 coal_close_hw_evict;
+	u64 coal_close_coal;
 };
 
 struct rmnet_priv {
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 1f9e592e24b6..2e76bf5a5a90 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -658,6 +658,7 @@ __rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
 			     bool csum_valid)
 {
 	u32 dlen = coal_meta->data_len * coal_meta->pkt_count;
+	struct rmnet_priv *priv = netdev_priv(coal_skb->dev);
 	u32 hlen = coal_meta->ip_len + coal_meta->trans_len;
 	struct sk_buff *skbn;
 
@@ -668,8 +669,10 @@ __rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
 	if (!csum_valid && coal_meta->zero_csum)
 		csum_valid = true;
 
-	if (!csum_valid)
+	if (!csum_valid) {
+		priv->stats.coal_csum_drop++;
 		goto next_pkt;
+	}
 
 	skbn = alloc_skb(hlen + dlen + RMNET_MAP_DEAGGR_HEADROOM, GFP_ATOMIC);
 	if (!skbn)
@@ -722,6 +725,7 @@ __rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
 	rmnet_map_partial_csum(skbn, coal_meta);
 
 	skbn->dev = coal_skb->dev;
+	priv->stats.coal_reconstruct++;
 
 	if (coal_meta->pkt_count > 1)
 		rmnet_map_gso_stamp(skbn, coal_meta);
@@ -740,14 +744,17 @@ static bool rmnet_map_coal_parse_ip_hdr(struct sk_buff *coal_skb,
 					struct rmnet_map_coal_metadata *meta,
 					bool *gro)
 {
+	struct rmnet_priv *priv = netdev_priv(coal_skb->dev);
 	struct ipv6hdr *ip6h;
 	struct iphdr *iph;
 	__be16 frag_off;
 	u8 protocol;
 	int ret;
 
-	if (coal_skb->len < sizeof(*iph))
+	if (coal_skb->len < sizeof(*iph)) {
+		priv->stats.coal_ip_invalid++;
 		return false;
+	}
 
 	iph = (struct iphdr *)coal_skb->data;
 
@@ -756,25 +763,33 @@ static bool rmnet_map_coal_parse_ip_hdr(struct sk_buff *coal_skb,
 		meta->ip_len = iph->ihl * 4;
 		meta->trans_proto = iph->protocol;
 		meta->ip_header = iph;
-		if (meta->ip_len < sizeof(*iph) || coal_skb->len < meta->ip_len)
+		if (meta->ip_len < sizeof(*iph) || coal_skb->len < meta->ip_len) {
+			priv->stats.coal_ip_invalid++;
 			return false;
+		}
 
-		if (ip_is_fragment(iph))
+		if (ip_is_fragment(iph)) {
+			priv->stats.coal_ip_invalid++;
 			return false;
+		}
 
 		if (iph->ihl != 5)
 			*gro = false;
 	} else if (iph->version == 6) {
-		if (coal_skb->len < sizeof(*ip6h))
+		if (coal_skb->len < sizeof(*ip6h)) {
+			priv->stats.coal_ip_invalid++;
 			return false;
+		}
 
 		ip6h = (struct ipv6hdr *)iph;
 		protocol = ip6h->nexthdr;
 		meta->ip_proto = 6;
 		ret = ipv6_skip_exthdr(coal_skb, sizeof(*ip6h), &protocol,
 				       &frag_off);
-		if (ret < 0 || frag_off)
+		if (ret < 0 || frag_off) {
+			priv->stats.coal_ip_invalid++;
 			return false;
+		}
 
 		meta->ip_len = (u16)ret;
 		meta->trans_proto = protocol;
@@ -782,6 +797,7 @@ static bool rmnet_map_coal_parse_ip_hdr(struct sk_buff *coal_skb,
 		if (meta->ip_len > sizeof(*ip6h))
 			*gro = false;
 	} else {
+		priv->stats.coal_ip_invalid++;
 		return false;
 	}
 
@@ -794,6 +810,7 @@ static bool rmnet_map_coal_parse_ip_hdr(struct sk_buff *coal_skb,
 static bool rmnet_map_coal_parse_trans_hdr(struct sk_buff *coal_skb,
 					   struct rmnet_map_coal_metadata *meta)
 {
+	struct rmnet_priv *priv = netdev_priv(coal_skb->dev);
 	struct udphdr *uh;
 	struct tcphdr *th;
 	u32 avail;
@@ -803,17 +820,23 @@ static bool rmnet_map_coal_parse_trans_hdr(struct sk_buff *coal_skb,
 	avail = coal_skb->len - meta->ip_len;
 
 	if (meta->trans_proto == IPPROTO_TCP) {
-		if (avail < sizeof(*th))
+		if (avail < sizeof(*th)) {
+			priv->stats.coal_trans_invalid++;
 			return false;
+		}
 
 		th = (struct tcphdr *)base;
 		meta->trans_len = th->doff * 4;
 		meta->trans_header = th;
-		if (meta->trans_len < sizeof(*th) || avail < meta->trans_len)
+		if (meta->trans_len < sizeof(*th) || avail < meta->trans_len) {
+			priv->stats.coal_trans_invalid++;
 			return false;
+		}
 	} else if (meta->trans_proto == IPPROTO_UDP) {
-		if (avail < sizeof(*uh))
+		if (avail < sizeof(*uh)) {
+			priv->stats.coal_trans_invalid++;
 			return false;
+		}
 
 		uh = (struct udphdr *)base;
 		meta->trans_len = sizeof(*uh);
@@ -821,6 +844,7 @@ static bool rmnet_map_coal_parse_trans_hdr(struct sk_buff *coal_skb,
 		if (meta->ip_proto == 4 && !uh->check)
 			meta->zero_csum = true;
 	} else {
+		priv->stats.coal_trans_invalid++;
 		return false;
 	}
 
@@ -896,6 +920,7 @@ static void rmnet_map_coal_segment_loop(struct sk_buff *coal_skb,
 					struct sk_buff_head *list,
 					u64 nlo_err_mask, bool gro, u8 num_nlos)
 {
+	struct rmnet_priv *priv = netdev_priv(coal_skb->dev);
 	u32 hlen = coal_meta->ip_len + coal_meta->trans_len;
 	u8 pkt, total_pkt = 0;
 	bool csum_err;
@@ -916,6 +941,9 @@ static void rmnet_map_coal_segment_loop(struct sk_buff *coal_skb,
 		     pkt++, total_pkt++, nlo_err_mask >>= 1) {
 			csum_err = nlo_err_mask & 1;
 
+			if (csum_err)
+				priv->stats.coal_csum_err++;
+
 			if (!gro) {
 				coal_meta->pkt_count = 1;
 				__rmnet_map_segment_coal_skb(coal_skb, coal_meta,
@@ -999,6 +1027,49 @@ static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
 	return 0;
 }
 
+/* Log the hardware close-reason counter for a coalescing header. */
+static void rmnet_map_data_log_close_stats(struct rmnet_priv *priv,
+					   u8 type, u8 code)
+{
+	switch (type) {
+	case RMNET_MAP_COAL_CLOSE_NON_COAL:
+		priv->stats.coal_close_non_coal++;
+		break;
+	case RMNET_MAP_COAL_CLOSE_IP_MISS:
+		priv->stats.coal_close_ip_miss++;
+		break;
+	case RMNET_MAP_COAL_CLOSE_TRANS_MISS:
+		priv->stats.coal_close_trans_miss++;
+		break;
+	case RMNET_MAP_COAL_CLOSE_HW:
+		switch (code) {
+		case RMNET_MAP_COAL_CLOSE_HW_NL:
+			priv->stats.coal_close_hw_nl++;
+			break;
+		case RMNET_MAP_COAL_CLOSE_HW_PKT:
+			priv->stats.coal_close_hw_pkt++;
+			break;
+		case RMNET_MAP_COAL_CLOSE_HW_BYTE:
+			priv->stats.coal_close_hw_byte++;
+			break;
+		case RMNET_MAP_COAL_CLOSE_HW_TIME:
+			priv->stats.coal_close_hw_time++;
+			break;
+		case RMNET_MAP_COAL_CLOSE_HW_EVICT:
+			priv->stats.coal_close_hw_evict++;
+			break;
+		default:
+			break;
+		}
+		break;
+	case RMNET_MAP_COAL_CLOSE_COAL:
+		priv->stats.coal_close_coal++;
+		break;
+	default:
+		break;
+	}
+}
+
 /* Validate the coalescing header and build the checksum error mask.
  *
  * Checks performed:
@@ -1023,20 +1094,25 @@ static int rmnet_map_data_check_coal_header(struct sk_buff *skb,
 					    u64 *nlo_err_mask)
 {
 	struct rmnet_map_header *maph = (struct rmnet_map_header *)skb->data;
+	struct rmnet_priv *priv = netdev_priv(skb->dev);
 	struct rmnet_map_v5_coal_header *coal_hdr;
 	u8 num_nlos, pkts = 0;
 	u64 mask = 0;
 	int i;
 
 	/* coal header is counted in pkt_len */
-	if (ntohs(maph->pkt_len) < sizeof(*coal_hdr))
+	if (ntohs(maph->pkt_len) < sizeof(*coal_hdr)) {
+		priv->stats.coal_hdr_nlo_err++;
 		return -EINVAL;
+	}
 
 	coal_hdr = (struct rmnet_map_v5_coal_header *)(skb->data + sizeof(*maph));
 	num_nlos = u8_get_bits(coal_hdr->coal_info, MAPV5_COALINFO_NUM_NLOS_FMASK);
 
-	if (num_nlos == 0 || num_nlos > RMNET_MAP_V5_MAX_NLOS)
+	if (num_nlos == 0 || num_nlos > RMNET_MAP_V5_MAX_NLOS) {
+		priv->stats.coal_hdr_nlo_err++;
 		return -EINVAL;
+	}
 
 	for (i = 0; i < RMNET_MAP_V5_MAX_NLOS; i++) {
 		u8 err = coal_hdr->nl_pairs[i].csum_error_bitmap;
@@ -1044,10 +1120,19 @@ static int rmnet_map_data_check_coal_header(struct sk_buff *skb,
 
 		mask |= ((u64)err) << (8 * i);
 		pkts += pkt;
-		if (pkts > RMNET_MAP_V5_MAX_PACKETS)
+		if (pkts > RMNET_MAP_V5_MAX_PACKETS) {
+			priv->stats.coal_hdr_pkt_err++;
 			return -EINVAL;
+		}
 	}
 
+	priv->stats.coal_pkts += pkts;
+	rmnet_map_data_log_close_stats(priv,
+				       u8_get_bits(coal_hdr->close_info,
+						   MAPV5_CLOSEINFO_CLOSE_TYPE_FMASK),
+				       u8_get_bits(coal_hdr->close_info,
+						   MAPV5_CLOSEINFO_CLOSE_VALUE_FMASK));
+
 	*nlo_err_mask = mask;
 	return 0;
 }
@@ -1065,6 +1150,7 @@ int rmnet_map_process_next_hdr_packet(struct sk_buff *skb,
 		if (!(data_format & RMNET_FLAGS_INGRESS_COALESCE))
 			return -EINVAL;
 
+		priv->stats.coal_rx++;
 		rc = rmnet_map_data_check_coal_header(skb, &nlo_err_mask);
 		if (rc)
 			return rc;
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index e1e319683a55..a21d6543c014 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -183,6 +183,26 @@ static const char rmnet_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"Checksum skipped",
 	"Checksum computed in software",
 	"Checksum computed in hardware",
+	/* DL coalescing */
+	"Coal frames received",
+	"Packets in coal frames",
+	"Coal hdr NLO errors",
+	"Coal hdr pkt count errors",
+	"Coal checksum errors",
+	"Coal packets dropped on csum err",
+	"Coal segments reconstructed",
+	"Coal invalid IP version",
+	"Coal invalid transport",
+	/* close reasons */
+	"Coal closed: non-coal",
+	"Coal closed: IP miss",
+	"Coal closed: transport miss",
+	"Coal closed: hw NL limit",
+	"Coal closed: hw pkt limit",
+	"Coal closed: hw byte limit",
+	"Coal closed: hw time limit",
+	"Coal closed: hw evict",
+	"Coal closed: FIN/PSH",
 };
 
 static void rmnet_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
-- 
2.34.1

