Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9844908C9;
	Fri,  9 Oct 2026 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535477; cv=none; b=ki4mM0RnrzI9ncoC+pEZSx1FhfCrhSdZzvTWg71gwr51ik4qywnAEhrMfBOj65RzvD8LkAE/ljUbJAC/KuCWPnXY3AqlaU4ZJyBmzQUg0xhMOIB+ffd6k+sUUcMnZYikt+JhIn7+h0wPJ3BbhK6LKioXLDmZS6ZZIMo3B/PZbTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535477; c=relaxed/simple;
	bh=bd+H2N9fN+X2D05a0ItL1heGGZyVzKhEOpOC4BtZMjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ELNMjFwm8i8DM6bKHKiDlkxZhH4M6UcVG/E02QTtWZKets+6nA5nZhVKjWAvWtPd+DBRK6C2US/PRiDJdZtcqLe2ohbfxWSK4dMYfA0vy8e5zKjtZDGExMgXXshUyAqSh8NeXWSk2jflVxtqZr9AbhNhLm0k20LglTtBxoubJKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OzL1IJIL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OzL1IJIL"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KF1v642361;
	Fri, 9 Oct 2026 08:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=EZJFVhXm8pA
	rexs7YQSa1rf4Tv11s85OSeU7TDYrnU8=; b=OzL1IJILBWKMROQ4Gd4Q6ESvgzl
	6DlWG34H5GWPWKUacLGAXWoJP7VgFMCrw+NIFXlSWWbAO/ZW5Vj+lo9PDyvnN58E
	7pCmyjQ1uxqQTjdaTs354Aq0eftRDgSbkwkYUC94UrJ5fqxRBkLIJ5hJt46ubkRk
	DRvz5iUWYibcsbDAUhGNbPM9PU1syBAiNiS7JSZAmncBXETQioaX4Z9s19pKhXRV
	0GyGH0Mz+Bwuou6iFuUDSaZ+ryAhS1NZEBjj2xK9A74qn9TZ82K1jY+KzvPoSeWI
	BEyzxBklwq5djAi/x170zLCGFncMCIfmnlwWQnKgDowSNG/fCyRnGg4tFrw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxrtrdq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:44:16 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998iF3n236380;
	Fri, 9 Oct 2026 08:44:15 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6998iF8W236369
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:44:15 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id 3B24AACA; Fri,  9 Oct 2026 01:44:15 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next v3 7/8] net: qualcomm: rmnet: Add DL coalescing statistics
Date: Fri,  9 Oct 2026 01:43:50 -0700
Message-Id: <20261009084351.317632-8-subash.a.kasiviswanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009084351.317632-1-subash.a.kasiviswanathan@oss.qualcomm.com>
References: <20261009084351.317632-1-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac8a960 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=7FMIsJl21R0jxg--SRsA:9
X-Proofpoint-GUID: G2gULiftikxPyxeY0Sl6pTA2bvor3NhH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNCBTYWx0ZWRfX/sDHA/4veYlQ
 5ZT2OhWjTzOdCEUTY9zC4N0cNC5sIHEQWW0EvPVlkoWRQKYvO0KutUkT1xafivA0+/L2IEqBZTP
 VvbRLgvo6dXOC06U0Q2Jm9uDFzdsAOBnQql84SvSuVkoNon81yr2X3bqtAkhpnVZHYcU0DccDla
 l1TbShd+kHDmL1XLVfX13eGSsHaeCeR54GdpYVynKzYLAZZuGs74AQ3Jj8c3ON/xQ/pO9gjjl74
 LMFk2uDTRvkJtl9NXQ6i3DNh61KCbC3EzvY6jBqfSp0+ALrVWJFgmOw89UHTdHdCyeDlrCplNXc
 YXcoruEyrmnQWPnUn5xgV6Y/dmTT31QqZ/FURBP9AydvO1BEEUTllt36OVqGkhSv3+eeUKQBDQt
 r1oth9DFNBsvGKWXL56owIAF54IxLZyV9sja8dGSukQjt/HismAyl/HnqdulZ3k5zWyR0tj3SYn
 +X61MAWMSpuwMZwzZ5g==
X-Proofpoint-ORIG-GUID: G2gULiftikxPyxeY0Sl6pTA2bvor3NhH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNCBTYWx0ZWRfX3hPh6DTaHl6Q
 j0SCQxJQjcNHXq3LFGowfYwn5sMmdFMngHaZWOByioQHdA8DzZruwekxJegi7guCM3AvgGx9t6p
 KB7nxAf/esf4VEfYQO9FM/9PuZPk3o4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090034

Track downlink coalescing activity with standard network stack RX
statistics and rmnet specific ethtool diagnostics.

Expose these standard RX statistics through netdev_stat_ops:

- HW-GRO packets and the number of wire packets represented by them
- RX allocation failures
- RX drops for reconstructed packets discarded by rmnet

Keep these rmnet specific ethtool statistics for diagnostics that have no
standard representation:

- Coalescing header, packet count and bounds errors
- Invalid IP and transport headers
- Segment reconstruction
- Hardware close reasons

Store the per-CPU counters as u64_stats_t values and update them with
u64_stats_inc() and u64_stats_add() under u64_stats_sync protection. Copy
them into plain snapshot structures with u64_stats_copy() before
aggregation. This avoids torn counter reads during reporting.

Checksum error diagnostics distinguish hardware reported errors from
packets actually dropped. IPv4 UDP packets with a zero checksum are
accepted and are not counted as drops.

Co-developed-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
---
v3: 
  - Fix build warning due to fortify detecting memcpy() read beyond the
    declared ethtool_stats field boundary in struct rmnet_priv_stats as
    reported by netdev build bot.
  - Fix build warning due to rmnet_get_ethtool_stats() exceeding the
    configured 1280 byte stack frame limit due to the statistics
    snapshot as reported by kernel test robot.
v2: https://lore.kernel.org/all/20261008005543.2630828-8-subash.a.kasiviswanathan@oss.qualcomm.com/
v1: https://lore.kernel.org/all/20260930051345.857443-7-subash.a.kasiviswanathan@oss.qualcomm.com/

 .../ethernet/qualcomm/rmnet/rmnet_config.h    | 104 +++++-
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 338 ++++++++++++++++--
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   | 130 ++++++-
 3 files changed, 516 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
index 5adda0323dda..917d31f6eded 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
@@ -63,31 +63,105 @@ struct rmnet_vnd_stats {
 	u32 tx_drops;
 };
 
+struct rmnet_priv_stats {
+	/* Network stack RX statistics for all rmnet receive paths */
+	u64 rx_hw_gro_packets;
+	u64 rx_hw_gro_wire_packets;
+	u64 rx_alloc_fail;
+	u64 rx_dropped;
+
+	/* Custom diagnostics for the coalescing receive path */
+	struct_group(ethtool_stats, /* ethtool statistics */
+		u64 csum_ok;
+		u64 csum_ip4_header_bad;
+		u64 csum_valid_unset;
+		u64 csum_validation_failed;
+		u64 csum_err_bad_buffer;
+		u64 csum_err_invalid_ip_version;
+		u64 csum_err_invalid_transport;
+		u64 csum_fragmented_pkt;
+		u64 csum_skipped;
+		u64 csum_sw;
+		u64 csum_hw;
+		/* Coalescing-only counters. Some are subsets of the standard counters. */
+		u64 coal_alloc_fail;
+		u64 coal_rx;
+		u64 coal_pkts;
+		u64 coal_hdr_err;
+		u64 coal_hdr_pkt_err;
+		u64 coal_bounds_err;
+		u64 coal_csum_err;
+		u64 coal_csum_drop;
+		u64 coal_reconstruct;
+		u64 coal_ip_invalid;
+		u64 coal_trans_invalid;
+		/* close-reason sub-counters */
+		u64 coal_close_non_coal;
+		u64 coal_close_ip_miss;
+		u64 coal_close_trans_miss;
+		u64 coal_close_hw_nl;
+		u64 coal_close_hw_pkt;
+		u64 coal_close_hw_byte;
+		u64 coal_close_hw_time;
+		u64 coal_close_hw_evict;
+		u64 coal_close_coal;
+	);
+};
+
+struct rmnet_pcpu_priv_stats {
+	/* Network stack RX statistics for all rmnet receive paths */
+	u64_stats_t rx_hw_gro_packets;
+	u64_stats_t rx_hw_gro_wire_packets;
+	u64_stats_t rx_alloc_fail;
+	u64_stats_t rx_dropped;
+
+	/* Custom diagnostics for the coalescing receive path */
+	u64_stats_t csum_ok;
+	u64_stats_t csum_ip4_header_bad;
+	u64_stats_t csum_valid_unset;
+	u64_stats_t csum_validation_failed;
+	u64_stats_t csum_err_bad_buffer;
+	u64_stats_t csum_err_invalid_ip_version;
+	u64_stats_t csum_err_invalid_transport;
+	u64_stats_t csum_fragmented_pkt;
+	u64_stats_t csum_skipped;
+	u64_stats_t csum_sw;
+	u64_stats_t csum_hw;
+	/* Coalescing-only counters. Some are subsets of the standard counters. */
+	u64_stats_t coal_alloc_fail;
+	u64_stats_t coal_rx;
+	u64_stats_t coal_pkts;
+	u64_stats_t coal_hdr_err;
+	u64_stats_t coal_hdr_pkt_err;
+	u64_stats_t coal_bounds_err;
+	u64_stats_t coal_csum_err;
+	u64_stats_t coal_csum_drop;
+	u64_stats_t coal_reconstruct;
+	u64_stats_t coal_ip_invalid;
+	u64_stats_t coal_trans_invalid;
+	/* close-reason sub-counters */
+	u64_stats_t coal_close_non_coal;
+	u64_stats_t coal_close_ip_miss;
+	u64_stats_t coal_close_trans_miss;
+	u64_stats_t coal_close_hw_nl;
+	u64_stats_t coal_close_hw_pkt;
+	u64_stats_t coal_close_hw_byte;
+	u64_stats_t coal_close_hw_time;
+	u64_stats_t coal_close_hw_evict;
+	u64_stats_t coal_close_coal;
+};
+
 struct rmnet_pcpu_stats {
 	struct rmnet_vnd_stats stats;
+	struct rmnet_pcpu_priv_stats priv_stats;
 	struct u64_stats_sync syncp;
 };
 
-struct rmnet_priv_stats {
-	u64 csum_ok;
-	u64 csum_ip4_header_bad;
-	u64 csum_valid_unset;
-	u64 csum_validation_failed;
-	u64 csum_err_bad_buffer;
-	u64 csum_err_invalid_ip_version;
-	u64 csum_err_invalid_transport;
-	u64 csum_fragmented_pkt;
-	u64 csum_skipped;
-	u64 csum_sw;
-	u64 csum_hw;
-};
-
 struct rmnet_priv {
 	u8 mux_id;
 	struct net_device *real_dev;
 	struct rmnet_pcpu_stats __percpu *pcpu_stats;
 	struct gro_cells gro_cells;
-	struct rmnet_priv_stats stats;
 };
 
 struct rmnet_port *rmnet_get_port_rcu(const struct net_device *real_dev);
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index e8adb4006717..74d64b7066e2 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -53,34 +53,45 @@ rmnet_map_ipv4_dl_csum_trailer(struct sk_buff *skb,
 {
 	struct iphdr *ip4h = (struct iphdr *)skb->data;
 	void *txporthdr = skb->data + ip4h->ihl * 4;
+	struct rmnet_pcpu_stats *pcpu_ptr;
 	__sum16 *csum_field, pseudo_csum;
 	__sum16 ip_payload_csum;
 
+	pcpu_ptr = this_cpu_ptr(priv->pcpu_stats);
+
 	/* Computing the checksum over just the IPv4 header--including its
 	 * checksum field--should yield 0.  If it doesn't, the IP header
 	 * is bad, so return an error and let the IP layer drop it.
 	 */
 	if (ip_fast_csum(ip4h, ip4h->ihl)) {
-		priv->stats.csum_ip4_header_bad++;
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.csum_ip4_header_bad);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return -EINVAL;
 	}
 
 	/* We don't support checksum offload on IPv4 fragments */
 	if (ip_is_fragment(ip4h)) {
-		priv->stats.csum_fragmented_pkt++;
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.csum_fragmented_pkt);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return -EOPNOTSUPP;
 	}
 
 	/* Checksum offload is only supported for UDP and TCP protocols */
 	csum_field = rmnet_map_get_csum_field(ip4h->protocol, txporthdr);
 	if (!csum_field) {
-		priv->stats.csum_err_invalid_transport++;
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.csum_err_invalid_transport);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return -EPROTONOSUPPORT;
 	}
 
 	/* RFC 768: UDP checksum is optional for IPv4, and is 0 if unused */
 	if (!*csum_field && ip4h->protocol == IPPROTO_UDP) {
-		priv->stats.csum_skipped++;
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.csum_skipped);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return 0;
 	}
 
@@ -113,11 +124,15 @@ rmnet_map_ipv4_dl_csum_trailer(struct sk_buff *skb,
 
 	/* The cast is required to ensure only the low 16 bits are examined */
 	if (ip_payload_csum != (__sum16)~pseudo_csum) {
-		priv->stats.csum_validation_failed++;
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.csum_validation_failed);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return -EINVAL;
 	}
 
-	priv->stats.csum_ok++;
+	u64_stats_update_begin(&pcpu_ptr->syncp);
+	u64_stats_inc(&pcpu_ptr->priv_stats.csum_ok);
+	u64_stats_update_end(&pcpu_ptr->syncp);
 	return 0;
 }
 
@@ -129,16 +144,21 @@ rmnet_map_ipv6_dl_csum_trailer(struct sk_buff *skb,
 {
 	struct ipv6hdr *ip6h = (struct ipv6hdr *)skb->data;
 	void *txporthdr = skb->data + sizeof(*ip6h);
+	struct rmnet_pcpu_stats *pcpu_ptr;
 	__sum16 *csum_field, pseudo_csum;
 	__sum16 ip6_payload_csum;
 	__be16 ip_header_csum;
 
+	pcpu_ptr = this_cpu_ptr(priv->pcpu_stats);
+
 	/* Checksum offload is only supported for UDP and TCP protocols;
 	 * the packet cannot include any IPv6 extension headers
 	 */
 	csum_field = rmnet_map_get_csum_field(ip6h->nexthdr, txporthdr);
 	if (!csum_field) {
-		priv->stats.csum_err_invalid_transport++;
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.csum_err_invalid_transport);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return -EPROTONOSUPPORT;
 	}
 
@@ -164,11 +184,15 @@ rmnet_map_ipv6_dl_csum_trailer(struct sk_buff *skb,
 	 * examined.
 	 */
 	if (ip6_payload_csum != (__sum16)~pseudo_csum) {
-		priv->stats.csum_validation_failed++;
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.csum_validation_failed);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return -EINVAL;
 	}
 
-	priv->stats.csum_ok++;
+	u64_stats_update_begin(&pcpu_ptr->syncp);
+	u64_stats_inc(&pcpu_ptr->priv_stats.csum_ok);
+	u64_stats_update_end(&pcpu_ptr->syncp);
 	return 0;
 }
 #else
@@ -263,6 +287,9 @@ static void rmnet_map_v5_checksum_uplink_packet(struct sk_buff *skb,
 {
 	struct rmnet_priv *priv = netdev_priv(orig_dev);
 	struct rmnet_map_v5_csum_header *ul_header;
+	struct rmnet_pcpu_stats *pcpu_ptr;
+
+	pcpu_ptr = this_cpu_ptr(priv->pcpu_stats);
 
 	ul_header = skb_push(skb, sizeof(*ul_header));
 	memset(ul_header, 0, sizeof(*ul_header));
@@ -287,7 +314,9 @@ static void rmnet_map_v5_checksum_uplink_packet(struct sk_buff *skb,
 			proto = ((struct ipv6hdr *)iph)->nexthdr;
 			trans = iph + ip_len;
 		} else {
-			priv->stats.csum_err_invalid_ip_version++;
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.csum_err_invalid_ip_version);
+			u64_stats_update_end(&pcpu_ptr->syncp);
 			goto sw_csum;
 		}
 
@@ -296,13 +325,17 @@ static void rmnet_map_v5_checksum_uplink_packet(struct sk_buff *skb,
 			skb->ip_summed = CHECKSUM_NONE;
 			/* Ask for checksum offloading */
 			ul_header->csum_info |= MAPV5_CSUMINFO_VALID_FLAG;
-			priv->stats.csum_hw++;
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.csum_hw);
+			u64_stats_update_end(&pcpu_ptr->syncp);
 			return;
 		}
 	}
 
 sw_csum:
-	priv->stats.csum_sw++;
+	u64_stats_update_begin(&pcpu_ptr->syncp);
+	u64_stats_inc(&pcpu_ptr->priv_stats.csum_sw);
+	u64_stats_update_end(&pcpu_ptr->syncp);
 }
 
 /* Adds MAP header to front of skb->data
@@ -434,16 +467,23 @@ int rmnet_map_checksum_downlink_packet(struct sk_buff *skb, u16 len)
 {
 	struct rmnet_priv *priv = netdev_priv(skb->dev);
 	struct rmnet_map_dl_csum_trailer *csum_trailer;
+	struct rmnet_pcpu_stats *pcpu_ptr;
+
+	pcpu_ptr = this_cpu_ptr(priv->pcpu_stats);
 
 	if (unlikely(!(skb->dev->features & NETIF_F_RXCSUM))) {
-		priv->stats.csum_sw++;
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.csum_sw);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return -EOPNOTSUPP;
 	}
 
 	csum_trailer = (struct rmnet_map_dl_csum_trailer *)(skb->data + len);
 
 	if (!(csum_trailer->flags & MAP_CSUM_DL_VALID_FLAG)) {
-		priv->stats.csum_valid_unset++;
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.csum_valid_unset);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return -EINVAL;
 	}
 
@@ -453,7 +493,9 @@ int rmnet_map_checksum_downlink_packet(struct sk_buff *skb, u16 len)
 	if (IS_ENABLED(CONFIG_IPV6) && skb->protocol == htons(ETH_P_IPV6))
 		return rmnet_map_ipv6_dl_csum_trailer(skb, csum_trailer, priv);
 
-	priv->stats.csum_err_invalid_ip_version++;
+	u64_stats_update_begin(&pcpu_ptr->syncp);
+	u64_stats_inc(&pcpu_ptr->priv_stats.csum_err_invalid_ip_version);
+	u64_stats_update_end(&pcpu_ptr->syncp);
 
 	return -EPROTONOSUPPORT;
 }
@@ -463,8 +505,11 @@ static void rmnet_map_v4_checksum_uplink_packet(struct sk_buff *skb,
 {
 	struct rmnet_priv *priv = netdev_priv(orig_dev);
 	struct rmnet_map_ul_csum_header *ul_header;
+	struct rmnet_pcpu_stats *pcpu_ptr;
 	void *iphdr;
 
+	pcpu_ptr = this_cpu_ptr(priv->pcpu_stats);
+
 	ul_header = (struct rmnet_map_ul_csum_header *)
 		    skb_push(skb, sizeof(struct rmnet_map_ul_csum_header));
 
@@ -480,22 +525,30 @@ static void rmnet_map_v4_checksum_uplink_packet(struct sk_buff *skb,
 
 	if (skb->protocol == htons(ETH_P_IP)) {
 		rmnet_map_ipv4_ul_csum_header(iphdr, ul_header, skb);
-		priv->stats.csum_hw++;
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.csum_hw);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return;
 	}
 
 	if (IS_ENABLED(CONFIG_IPV6) && skb->protocol == htons(ETH_P_IPV6)) {
 		rmnet_map_ipv6_ul_csum_header(iphdr, ul_header, skb);
-		priv->stats.csum_hw++;
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.csum_hw);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return;
 	}
 
-	priv->stats.csum_err_invalid_ip_version++;
+	u64_stats_update_begin(&pcpu_ptr->syncp);
+	u64_stats_inc(&pcpu_ptr->priv_stats.csum_err_invalid_ip_version);
+	u64_stats_update_end(&pcpu_ptr->syncp);
 
 sw_csum:
 	memset(ul_header, 0, sizeof(*ul_header));
 
-	priv->stats.csum_sw++;
+	u64_stats_update_begin(&pcpu_ptr->syncp);
+	u64_stats_inc(&pcpu_ptr->priv_stats.csum_sw);
+	u64_stats_update_end(&pcpu_ptr->syncp);
 }
 
 /* Generates UL checksum meta info header for IPv4 and IPv6 over TCP and UDP
@@ -665,9 +718,13 @@ __rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
 			     bool csum_valid)
 {
 	u32 dlen = coal_meta->data_len * coal_meta->pkt_count;
+	struct rmnet_priv *priv = netdev_priv(coal_skb->dev);
 	u32 hlen = coal_meta->ip_len + coal_meta->trans_len;
+	struct rmnet_pcpu_stats *pcpu_ptr;
 	struct sk_buff *skbn;
 
+	pcpu_ptr = this_cpu_ptr(priv->pcpu_stats);
+
 	/* RFC 768: UDP checksum is optional for IPv4, and is 0 if unused.
 	 * Such packets are never actually bad, regardless of what the
 	 * checksum bitmap says.
@@ -675,12 +732,29 @@ __rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
 	if (!csum_valid && coal_meta->zero_csum)
 		csum_valid = true;
 
-	if (!csum_valid)
+	if (!csum_valid) {
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		/* rx_dropped is standard accounting. coal_csum_drop is its
+		 * coalescing-specific checksum error subset.
+		 */
+		u64_stats_add(&pcpu_ptr->priv_stats.rx_dropped, coal_meta->pkt_count);
+		u64_stats_inc(&pcpu_ptr->priv_stats.coal_csum_drop);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		goto next_pkt;
+	}
 
 	skbn = alloc_skb(hlen + dlen + RMNET_MAP_DEAGGR_HEADROOM, GFP_ATOMIC);
-	if (!skbn)
+	if (!skbn) {
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		/* The coal counter is the coalescing subset of the standard
+		 * allocation failure and RX drop counters.
+		 */
+		u64_stats_add(&pcpu_ptr->priv_stats.rx_alloc_fail, coal_meta->pkt_count);
+		u64_stats_add(&pcpu_ptr->priv_stats.rx_dropped, coal_meta->pkt_count);
+		u64_stats_add(&pcpu_ptr->priv_stats.coal_alloc_fail, coal_meta->pkt_count);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		goto next_pkt;
+	}
 
 	skb_reserve(skbn, hlen + RMNET_MAP_DEAGGR_HEADROOM);
 	skb_put_data(skbn,
@@ -729,6 +803,9 @@ __rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
 	rmnet_map_partial_csum(skbn, coal_meta);
 
 	skbn->dev = coal_skb->dev;
+	u64_stats_update_begin(&pcpu_ptr->syncp);
+	u64_stats_inc(&pcpu_ptr->priv_stats.coal_reconstruct);
+	u64_stats_update_end(&pcpu_ptr->syncp);
 
 	if (coal_meta->pkt_count > 1)
 		rmnet_map_gso_stamp(skbn, coal_meta);
@@ -747,14 +824,22 @@ static bool rmnet_map_coal_parse_ip_hdr(struct sk_buff *coal_skb,
 					struct rmnet_map_coal_metadata *meta,
 					bool *gro)
 {
+	struct rmnet_priv *priv = netdev_priv(coal_skb->dev);
+	struct rmnet_pcpu_stats *pcpu_ptr;
 	struct ipv6hdr *ip6h;
 	struct iphdr *iph;
 	__be16 frag_off;
 	u8 protocol;
 	int ret;
 
-	if (coal_skb->len < sizeof(*iph))
+	pcpu_ptr = this_cpu_ptr(priv->pcpu_stats);
+
+	if (coal_skb->len < sizeof(*iph)) {
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.coal_ip_invalid);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return false;
+	}
 
 	iph = (struct iphdr *)coal_skb->data;
 
@@ -763,35 +848,58 @@ static bool rmnet_map_coal_parse_ip_hdr(struct sk_buff *coal_skb,
 		meta->ip_len = iph->ihl * 4;
 		meta->trans_proto = iph->protocol;
 		meta->ip_header = iph;
-		if (meta->ip_len < sizeof(*iph) || coal_skb->len < meta->ip_len)
+		if (meta->ip_len < sizeof(*iph) || coal_skb->len < meta->ip_len) {
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.coal_ip_invalid);
+			u64_stats_update_end(&pcpu_ptr->syncp);
 			return false;
+		}
 
-		if (ip_is_fragment(iph))
+		if (ip_is_fragment(iph)) {
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.coal_ip_invalid);
+			u64_stats_update_end(&pcpu_ptr->syncp);
 			return false;
+		}
 
 		if (iph->ihl != 5)
 			*gro = false;
 	} else if (iph->version == 6) {
-		if (coal_skb->len < sizeof(*ip6h))
+		if (coal_skb->len < sizeof(*ip6h)) {
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.coal_ip_invalid);
+			u64_stats_update_end(&pcpu_ptr->syncp);
 			return false;
+		}
 
 		ip6h = (struct ipv6hdr *)iph;
 		protocol = ip6h->nexthdr;
 		meta->ip_proto = 6;
 		ret = ipv6_skip_exthdr(coal_skb, sizeof(*ip6h), &protocol,
 				       &frag_off);
-		if (ret < 0 || frag_off || ret > U16_MAX)
+		if (ret < 0 || frag_off || ret > U16_MAX) {
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.coal_ip_invalid);
+			u64_stats_update_end(&pcpu_ptr->syncp);
 			return false;
+		}
 
 		meta->ip_len = (u16)ret;
 		meta->trans_proto = protocol;
 		meta->ip_header = ip6h;
-		if (coal_skb->len < meta->ip_len)
+		if (coal_skb->len < meta->ip_len) {
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.coal_ip_invalid);
+			u64_stats_update_end(&pcpu_ptr->syncp);
 			return false;
+		}
 
 		if (meta->ip_len > sizeof(*ip6h))
 			*gro = false;
 	} else {
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.coal_ip_invalid);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return false;
 	}
 
@@ -804,29 +912,49 @@ static bool rmnet_map_coal_parse_ip_hdr(struct sk_buff *coal_skb,
 static bool rmnet_map_coal_parse_trans_hdr(struct sk_buff *coal_skb,
 					   struct rmnet_map_coal_metadata *meta)
 {
+	struct rmnet_priv *priv = netdev_priv(coal_skb->dev);
+	struct rmnet_pcpu_stats *pcpu_ptr;
 	struct udphdr *uh;
 	struct tcphdr *th;
 	u32 avail;
 	u8 *base;
 
-	if (meta->ip_len > coal_skb->len)
+	pcpu_ptr = this_cpu_ptr(priv->pcpu_stats);
+
+	if (meta->ip_len > coal_skb->len) {
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.coal_trans_invalid);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return false;
+	}
 
 	base = (u8 *)meta->ip_header + meta->ip_len;
 	avail = coal_skb->len - meta->ip_len;
 
 	if (meta->trans_proto == IPPROTO_TCP) {
-		if (avail < sizeof(*th))
+		if (avail < sizeof(*th)) {
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.coal_trans_invalid);
+			u64_stats_update_end(&pcpu_ptr->syncp);
 			return false;
+		}
 
 		th = (struct tcphdr *)base;
 		meta->trans_len = th->doff * 4;
 		meta->trans_header = th;
-		if (meta->trans_len < sizeof(*th) || avail < meta->trans_len)
+		if (meta->trans_len < sizeof(*th) || avail < meta->trans_len) {
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.coal_trans_invalid);
+			u64_stats_update_end(&pcpu_ptr->syncp);
 			return false;
+		}
 	} else if (meta->trans_proto == IPPROTO_UDP) {
-		if (avail < sizeof(*uh))
+		if (avail < sizeof(*uh)) {
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.coal_trans_invalid);
+			u64_stats_update_end(&pcpu_ptr->syncp);
 			return false;
+		}
 
 		uh = (struct udphdr *)base;
 		meta->trans_len = sizeof(*uh);
@@ -834,6 +962,9 @@ static bool rmnet_map_coal_parse_trans_hdr(struct sk_buff *coal_skb,
 		if (meta->ip_proto == 4 && !uh->check)
 			meta->zero_csum = true;
 	} else {
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.coal_trans_invalid);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return false;
 	}
 
@@ -919,12 +1050,16 @@ static void rmnet_map_coal_segment_loop(struct sk_buff *coal_skb,
 					struct sk_buff_head *list,
 					u64 nlo_err_mask, bool gro, u8 num_nlos)
 {
+	struct rmnet_priv *priv = netdev_priv(coal_skb->dev);
 	u32 hlen = coal_meta->ip_len + coal_meta->trans_len;
+	struct rmnet_pcpu_stats *pcpu_ptr;
 	u8 pkt, total_pkt = 0;
 	bool csum_err;
 	u16 pkt_len;
 	u8 nlo;
 
+	pcpu_ptr = this_cpu_ptr(priv->pcpu_stats);
+
 	for (nlo = 0; nlo < num_nlos; nlo++) {
 		pkt_len = ntohs(coal_hdr->nl_pairs[nlo].pkt_len);
 		pkt_len -= hlen;
@@ -939,6 +1074,12 @@ static void rmnet_map_coal_segment_loop(struct sk_buff *coal_skb,
 		     pkt++, total_pkt++, nlo_err_mask >>= 1) {
 			csum_err = nlo_err_mask & 1;
 
+			if (csum_err) {
+				u64_stats_update_begin(&pcpu_ptr->syncp);
+				u64_stats_inc(&pcpu_ptr->priv_stats.coal_csum_err);
+				u64_stats_update_end(&pcpu_ptr->syncp);
+			}
+
 			if (!gro) {
 				coal_meta->pkt_count = 1;
 				__rmnet_map_segment_coal_skb(coal_skb, coal_meta,
@@ -982,11 +1123,15 @@ static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
 {
 	bool gro_hw = coal_skb->dev->features & NETIF_F_GRO_HW;
 	bool rxcsum = coal_skb->dev->features & NETIF_F_RXCSUM;
+	struct rmnet_priv *priv = netdev_priv(coal_skb->dev);
 	struct rmnet_map_v5_coal_header *coal_hdr;
 	struct rmnet_map_coal_metadata coal_meta;
+	struct rmnet_pcpu_stats *pcpu_ptr;
 	bool gro = gro_hw;
 	u32 hlen;
 
+	pcpu_ptr = this_cpu_ptr(priv->pcpu_stats);
+
 	memset(&coal_meta, 0, sizeof(coal_meta));
 
 	/* Drop any MAP frame padding. The coal header is counted in len */
@@ -1005,8 +1150,12 @@ static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
 	hlen = coal_meta.ip_len + coal_meta.trans_len;
 
 	if (!rmnet_map_coal_validate_bounds(coal_skb, coal_hdr, num_nlos, hlen,
-					    &gro))
+					    &gro)) {
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.coal_bounds_err);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return -EINVAL;
+	}
 
 	/* Device capability gates coalesced delivery. Packet format can still
 	 * disable GSO and use the per-packet fallback below.
@@ -1014,6 +1163,16 @@ static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
 	if (total_pkts > 1 && (!rxcsum || !gro_hw))
 		return -EINVAL;
 
+	if (gro && total_pkts > 1) {
+		/* Standard counters cover delivered HW-GRO skbs. coal_rx and
+		 * coal_pkts cover coalescing input regardless of HW-GRO.
+		 */
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.rx_hw_gro_packets);
+		u64_stats_add(&pcpu_ptr->priv_stats.rx_hw_gro_wire_packets, total_pkts);
+		u64_stats_update_end(&pcpu_ptr->syncp);
+	}
+
 	if (total_pkts == 1 && (!rxcsum || !gro_hw)) {
 		coal_skb->ip_summed = CHECKSUM_NONE;
 		__skb_queue_tail(list, coal_skb);
@@ -1036,6 +1195,67 @@ static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
 	return 0;
 }
 
+/* Log the hardware close-reason counter for a coalescing header. */
+static void rmnet_map_data_log_close_stats(struct rmnet_pcpu_stats *pcpu_ptr,
+					   u8 type, u8 code)
+{
+	switch (type) {
+	case RMNET_MAP_COAL_CLOSE_NON_COAL:
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.coal_close_non_coal);
+		u64_stats_update_end(&pcpu_ptr->syncp);
+		break;
+	case RMNET_MAP_COAL_CLOSE_IP_MISS:
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.coal_close_ip_miss);
+		u64_stats_update_end(&pcpu_ptr->syncp);
+		break;
+	case RMNET_MAP_COAL_CLOSE_TRANS_MISS:
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.coal_close_trans_miss);
+		u64_stats_update_end(&pcpu_ptr->syncp);
+		break;
+	case RMNET_MAP_COAL_CLOSE_HW:
+		switch (code) {
+		case RMNET_MAP_COAL_CLOSE_HW_NL:
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.coal_close_hw_nl);
+			u64_stats_update_end(&pcpu_ptr->syncp);
+			break;
+		case RMNET_MAP_COAL_CLOSE_HW_PKT:
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.coal_close_hw_pkt);
+			u64_stats_update_end(&pcpu_ptr->syncp);
+			break;
+		case RMNET_MAP_COAL_CLOSE_HW_BYTE:
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.coal_close_hw_byte);
+			u64_stats_update_end(&pcpu_ptr->syncp);
+			break;
+		case RMNET_MAP_COAL_CLOSE_HW_TIME:
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.coal_close_hw_time);
+			u64_stats_update_end(&pcpu_ptr->syncp);
+			break;
+		case RMNET_MAP_COAL_CLOSE_HW_EVICT:
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.coal_close_hw_evict);
+			u64_stats_update_end(&pcpu_ptr->syncp);
+			break;
+		default:
+			break;
+		}
+		break;
+	case RMNET_MAP_COAL_CLOSE_COAL:
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.coal_close_coal);
+		u64_stats_update_end(&pcpu_ptr->syncp);
+		break;
+	default:
+		break;
+	}
+}
+
 /* Validate the coalescing header and build the checksum error mask.
  *
  * Checks performed:
@@ -1062,23 +1282,34 @@ static int rmnet_map_data_check_coal_header(struct sk_buff *skb,
 					    u16 *num_pkts)
 {
 	struct rmnet_map_header *maph = (struct rmnet_map_header *)skb->data;
+	struct rmnet_priv *priv = netdev_priv(skb->dev);
 	struct rmnet_map_v5_coal_header *coal_hdr;
+	struct rmnet_pcpu_stats *pcpu_ptr;
 	u16 pkts = 0;
 	u64 mask = 0;
 	int nlos;
 	int i;
 
+	pcpu_ptr = this_cpu_ptr(priv->pcpu_stats);
+
 	/* coal header is counted in pkt_len */
-	if (ntohs(maph->pkt_len) < sizeof(*coal_hdr))
+	if (ntohs(maph->pkt_len) < sizeof(*coal_hdr)) {
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.coal_hdr_err);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return -EINVAL;
+	}
 
 	coal_hdr = (struct rmnet_map_v5_coal_header *)(skb->data + sizeof(*maph));
 	nlos = rmnet_map_v5_get_num_nlos(coal_hdr);
-	if (nlos < 0)
+	if (nlos < 0) {
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.coal_hdr_err);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		return -EINVAL;
+	}
 
 	*num_nlos = nlos;
-
 	for (i = 0; i < RMNET_MAP_V5_MAX_NLOS; i++) {
 		u8 err = coal_hdr->nl_pairs[i].csum_error_bitmap;
 		u8 pkt = coal_hdr->nl_pairs[i].num_packets;
@@ -1086,11 +1317,27 @@ static int rmnet_map_data_check_coal_header(struct sk_buff *skb,
 		mask |= ((u64)err) << (8 * i);
 		if (i < *num_nlos) {
 			pkts += pkt;
-			if (pkts > RMNET_MAP_V5_MAX_PACKETS)
+			if (pkts > RMNET_MAP_V5_MAX_PACKETS) {
+				u64_stats_update_begin(&pcpu_ptr->syncp);
+				u64_stats_inc(&pcpu_ptr->priv_stats.coal_hdr_pkt_err);
+				u64_stats_update_end(&pcpu_ptr->syncp);
 				return -EINVAL;
+			}
 		}
 	}
 
+	/* coal_pkts counts packets reported by the hardware, independent of
+	 * whether the frame is later delivered through HW-GRO.
+	 */
+	u64_stats_update_begin(&pcpu_ptr->syncp);
+	u64_stats_add(&pcpu_ptr->priv_stats.coal_pkts, pkts);
+	u64_stats_update_end(&pcpu_ptr->syncp);
+	rmnet_map_data_log_close_stats(pcpu_ptr,
+				       u8_get_bits(coal_hdr->close_info,
+						   MAPV5_CLOSEINFO_CLOSE_TYPE_FMASK),
+				       u8_get_bits(coal_hdr->close_info,
+						   MAPV5_CLOSEINFO_CLOSE_VALUE_FMASK));
+
 	*nlo_err_mask = mask;
 	*num_pkts = pkts;
 	return 0;
@@ -1101,16 +1348,23 @@ int rmnet_map_process_next_hdr_packet(struct sk_buff *skb,
 				      u16 len, u32 data_format)
 {
 	struct rmnet_priv *priv = netdev_priv(skb->dev);
+	struct rmnet_pcpu_stats *pcpu_ptr;
 	u64 nlo_err_mask;
 	u16 num_pkts;
 	u8 num_nlos;
 	int rc;
 
+	pcpu_ptr = this_cpu_ptr(priv->pcpu_stats);
+
 	switch (rmnet_map_get_next_hdr_type(skb)) {
 	case RMNET_MAP_HEADER_TYPE_COALESCING:
 		if (!(data_format & RMNET_FLAGS_INGRESS_COALESCE))
 			return -EINVAL;
 
+		/* coal_rx counts coalescing input, not delivered HW-GRO skbs. */
+		u64_stats_update_begin(&pcpu_ptr->syncp);
+		u64_stats_inc(&pcpu_ptr->priv_stats.coal_rx);
+		u64_stats_update_end(&pcpu_ptr->syncp);
 		rc = rmnet_map_data_check_coal_header(skb, &nlo_err_mask,
 						      &num_nlos, &num_pkts);
 		if (rc)
@@ -1135,12 +1389,18 @@ int rmnet_map_process_next_hdr_packet(struct sk_buff *skb,
 
 	case RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD:
 		if (unlikely(!(skb->dev->features & NETIF_F_RXCSUM))) {
-			priv->stats.csum_sw++;
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.csum_sw);
+			u64_stats_update_end(&pcpu_ptr->syncp);
 		} else if (rmnet_map_get_csum_valid(skb)) {
-			priv->stats.csum_ok++;
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.csum_ok);
+			u64_stats_update_end(&pcpu_ptr->syncp);
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 		} else {
-			priv->stats.csum_valid_unset++;
+			u64_stats_update_begin(&pcpu_ptr->syncp);
+			u64_stats_inc(&pcpu_ptr->priv_stats.csum_valid_unset);
+			u64_stats_update_end(&pcpu_ptr->syncp);
 		}
 
 		skb_pull(skb, sizeof(struct rmnet_map_header) +
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index b8542d2f03b2..d76af4788243 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -7,6 +7,7 @@
 #include <linux/capability.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
+#include <net/netdev_queues.h>
 #include <linux/if_arp.h>
 #include <linux/netlink.h>
 #include <net/pkt_sched.h>
@@ -141,8 +142,10 @@ static void rmnet_vnd_uninit(struct net_device *dev)
 static void rmnet_get_stats64(struct net_device *dev,
 			      struct rtnl_link_stats64 *s)
 {
+	struct rmnet_priv_stats total_priv_stats = { };
 	struct rmnet_priv *priv = netdev_priv(dev);
 	struct rmnet_vnd_stats total_stats = { };
+	struct rmnet_priv_stats priv_snapshot;
 	struct rmnet_pcpu_stats *pcpu_ptr;
 	struct rmnet_vnd_stats snapshot;
 	unsigned int cpu, start;
@@ -153,6 +156,8 @@ static void rmnet_get_stats64(struct net_device *dev,
 		do {
 			start = u64_stats_fetch_begin(&pcpu_ptr->syncp);
 			snapshot = pcpu_ptr->stats;	/* struct assignment */
+			u64_stats_copy(&priv_snapshot, &pcpu_ptr->priv_stats,
+				       sizeof(priv_snapshot));
 		} while (u64_stats_fetch_retry(&pcpu_ptr->syncp, start));
 
 		total_stats.rx_pkts += snapshot.rx_pkts;
@@ -160,6 +165,7 @@ static void rmnet_get_stats64(struct net_device *dev,
 		total_stats.tx_pkts += snapshot.tx_pkts;
 		total_stats.tx_bytes += snapshot.tx_bytes;
 		total_stats.tx_drops += snapshot.tx_drops;
+		total_priv_stats.rx_dropped += priv_snapshot.rx_dropped;
 	}
 
 	s->rx_packets = total_stats.rx_pkts;
@@ -167,8 +173,45 @@ static void rmnet_get_stats64(struct net_device *dev,
 	s->tx_packets = total_stats.tx_pkts;
 	s->tx_bytes = total_stats.tx_bytes;
 	s->tx_dropped = total_stats.tx_drops;
+	s->rx_dropped = total_priv_stats.rx_dropped;
 }
 
+/* Report standard network stack RX statistics. These are distinct from the
+ * rmnet-specific coalescing diagnostics exposed through ethtool.
+ */
+static void rmnet_get_queue_stats_rx(struct net_device *dev, int idx,
+				     struct netdev_queue_stats_rx *stats)
+{
+	struct rmnet_priv *priv = netdev_priv(dev);
+	struct rmnet_priv_stats total_stats = { };
+	struct rmnet_pcpu_stats *pcpu_ptr;
+	struct rmnet_priv_stats snapshot;
+	unsigned int cpu, start;
+
+	for_each_possible_cpu(cpu) {
+		pcpu_ptr = per_cpu_ptr(priv->pcpu_stats, cpu);
+
+		do {
+			start = u64_stats_fetch_begin(&pcpu_ptr->syncp);
+			u64_stats_copy(&snapshot, &pcpu_ptr->priv_stats,
+				       sizeof(snapshot));
+		} while (u64_stats_fetch_retry(&pcpu_ptr->syncp, start));
+
+		total_stats.rx_hw_gro_packets += snapshot.rx_hw_gro_packets;
+		total_stats.rx_hw_gro_wire_packets +=
+			snapshot.rx_hw_gro_wire_packets;
+		total_stats.rx_alloc_fail += snapshot.rx_alloc_fail;
+	}
+
+	stats->hw_gro_packets = total_stats.rx_hw_gro_packets;
+	stats->hw_gro_wire_packets = total_stats.rx_hw_gro_wire_packets;
+	stats->alloc_fail = total_stats.rx_alloc_fail;
+}
+
+static const struct netdev_stat_ops rmnet_stat_ops = {
+	.get_queue_stats_rx = rmnet_get_queue_stats_rx,
+};
+
 static const struct net_device_ops rmnet_vnd_ops = {
 	.ndo_start_xmit = rmnet_vnd_start_xmit,
 	.ndo_change_mtu = rmnet_vnd_change_mtu,
@@ -192,8 +235,34 @@ static const char rmnet_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"Checksum skipped",
 	"Checksum computed in software",
 	"Checksum computed in hardware",
+	/* DL coalescing */
+	"Coal alloc packet drops",
+	"Coal frames received",
+	"Packets in coal frames",
+	"Coal header errors",
+	"Coal hdr pkt count errors",
+	"Coal bounds errors",
+	"Coal checksum errors",
+	"Coal packets csum err drops",
+	"Coal segments reconstructed",
+	"Coal invalid IP packet",
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
 
+static_assert(ARRAY_SIZE(rmnet_gstrings_stats) ==
+	      (sizeof(struct rmnet_priv_stats) -
+	       offsetof(struct rmnet_priv_stats, csum_ok)) / sizeof(u64));
+
 static void rmnet_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 {
 	switch (stringset) {
@@ -218,12 +287,68 @@ static void rmnet_get_ethtool_stats(struct net_device *dev,
 				    struct ethtool_stats *stats, u64 *data)
 {
 	struct rmnet_priv *priv = netdev_priv(dev);
-	struct rmnet_priv_stats *st = &priv->stats;
+	struct rmnet_priv_stats total_stats = { };
+	struct rmnet_pcpu_stats *pcpu_ptr;
+	struct rmnet_priv_stats *snapshot;
+	unsigned int cpu, start;
 
 	if (!data)
 		return;
 
-	memcpy(data, st, ARRAY_SIZE(rmnet_gstrings_stats) * sizeof(u64));
+	snapshot = kzalloc_obj(*snapshot);
+	if (!snapshot)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		pcpu_ptr = per_cpu_ptr(priv->pcpu_stats, cpu);
+
+		do {
+			start = u64_stats_fetch_begin(&pcpu_ptr->syncp);
+			u64_stats_copy(snapshot, &pcpu_ptr->priv_stats,
+				       sizeof(*snapshot));
+		} while (u64_stats_fetch_retry(&pcpu_ptr->syncp, start));
+
+		total_stats.csum_ok += snapshot->csum_ok;
+		total_stats.csum_ip4_header_bad += snapshot->csum_ip4_header_bad;
+		total_stats.csum_valid_unset += snapshot->csum_valid_unset;
+		total_stats.csum_validation_failed += snapshot->csum_validation_failed;
+		total_stats.csum_err_bad_buffer += snapshot->csum_err_bad_buffer;
+		total_stats.csum_err_invalid_ip_version +=
+			snapshot->csum_err_invalid_ip_version;
+		total_stats.csum_err_invalid_transport +=
+			snapshot->csum_err_invalid_transport;
+		total_stats.csum_fragmented_pkt += snapshot->csum_fragmented_pkt;
+		total_stats.csum_skipped += snapshot->csum_skipped;
+		total_stats.csum_sw += snapshot->csum_sw;
+		total_stats.csum_hw += snapshot->csum_hw;
+		/* Custom rmnet coalescing diagnostics follow. */
+		total_stats.coal_alloc_fail += snapshot->coal_alloc_fail;
+		total_stats.coal_rx += snapshot->coal_rx;
+		total_stats.coal_pkts += snapshot->coal_pkts;
+		total_stats.coal_hdr_err += snapshot->coal_hdr_err;
+		total_stats.coal_hdr_pkt_err += snapshot->coal_hdr_pkt_err;
+		total_stats.coal_bounds_err += snapshot->coal_bounds_err;
+		total_stats.coal_csum_err += snapshot->coal_csum_err;
+		total_stats.coal_csum_drop += snapshot->coal_csum_drop;
+		total_stats.coal_reconstruct += snapshot->coal_reconstruct;
+		total_stats.coal_ip_invalid += snapshot->coal_ip_invalid;
+		total_stats.coal_trans_invalid += snapshot->coal_trans_invalid;
+		total_stats.coal_close_non_coal += snapshot->coal_close_non_coal;
+		total_stats.coal_close_ip_miss += snapshot->coal_close_ip_miss;
+		total_stats.coal_close_trans_miss += snapshot->coal_close_trans_miss;
+		total_stats.coal_close_hw_nl += snapshot->coal_close_hw_nl;
+		total_stats.coal_close_hw_pkt += snapshot->coal_close_hw_pkt;
+		total_stats.coal_close_hw_byte += snapshot->coal_close_hw_byte;
+		total_stats.coal_close_hw_time += snapshot->coal_close_hw_time;
+		total_stats.coal_close_hw_evict += snapshot->coal_close_hw_evict;
+		total_stats.coal_close_coal += snapshot->coal_close_coal;
+	}
+
+	kfree(snapshot);
+
+	/* The first four fields are reported through netdev queue statistics. */
+	memcpy(data, &total_stats.ethtool_stats,
+	       sizeof(total_stats.ethtool_stats));
 }
 
 static int rmnet_get_coalesce(struct net_device *dev,
@@ -332,6 +457,7 @@ int rmnet_vnd_newlink(u8 id, struct net_device *rmnet_dev,
 	rmnet_dev->hw_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 	rmnet_dev->hw_features |= NETIF_F_SG;
 	rmnet_dev->hw_features |= NETIF_F_GRO_HW;
+	rmnet_dev->stat_ops = &rmnet_stat_ops;
 
 	priv->real_dev = real_dev;
 
-- 
2.34.1

