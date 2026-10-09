Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E16B4825B4;
	Fri,  9 Oct 2026 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535473; cv=none; b=KT9AtIkaifmV5IcksF4zPI7qfzejiHnpWNDlEL3TTDxJub4kfG0BFiedJFoP1ubwQD4QMshPKTc8RFV5SIZSa1pMmLAG19J7KU8GrRLOityh0T/uHLZoQVWwhSUVHEH+O4vZbaDSDYlGKceEY8APCTvTc0mEA6tzFUnu0OCRCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535473; c=relaxed/simple;
	bh=7Nbtjt9kx2lNKWO3xaUdViG642wFyVaH1R8roFn4i+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ENww3AZMTb3F3cLbEepshifyfKLNqCWMfaQ9Ka0jkak9ryK4nvXAea/HOU/YLiG3EI/meQUy7wxAqTsXgmTOOY0vSjN5C65vToQfYZLvvAXIGMzSGCAsmkLWC0OOJdOrhj6IqwjVmHHurB+9XHGPK/cdoUZAzyTg9ip8j4b4zSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QEU0EeL/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QEU0EeL/"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KNWj1252485;
	Fri, 9 Oct 2026 08:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=L21tCU21DC8
	WRc2bbBC8VDeX/VeRrM2DstF8vG/zOEU=; b=QEU0EeL/WsidpDPqsDIAbfbvXti
	u7UFrZe0MxrRamBN7Ph1doWihIg8r+iBvbkghdxXKsyKYMa13hDVFPnmETINBKHw
	i8dFQOXdbYBJ2DZEc0cH5lDCPhQfh90AYB1tuq17i3DNM1WwaruLf7EFNXmulC+t
	7AjIcp4tz0GePZl1Ff3HOq9j3HjgPe7uted02jcnbwTTDNeuAPYu/eSflyL55XE0
	YNkd/EztmTbf4RpFE4FLIhEncwBafUJAjYU8+uV5yCTE71ob16y22za9fGLKo8Ay
	0/bEUSGlgdwwykfZio8W3MWjGp//+EI8ZqSCssVJ+8uiKxMSfs1scmKt4hA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6baj3wy2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:44:15 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998iEI5317235;
	Fri, 9 Oct 2026 08:44:14 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 6998iDZK317217
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:44:14 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id AFE3EACA; Fri,  9 Oct 2026 01:44:13 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next v3 6/8] net: qualcomm: rmnet: Work around coalescing hardware quirks
Date: Fri,  9 Oct 2026 01:43:49 -0700
Message-Id: <20261009084351.317632-7-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNCBTYWx0ZWRfX74PhnVJg1ObF
 ObZ3gLrE3jlNDJVZKrJTDw/i1JidKdCzSc299MDd3BzFHfMPytgUyf1EwX3cl87MzYaY+cByGlh
 UTrFZ7FNWQzkfAc+LKm0VP5FRBFMkCN60dw5pKLAA5NxRUku6fIpIjxIgvnIgo7cbbgRj9oAql+
 08V17orJuW0smhgfTWPsEiihJszYpaaH2nK/E2ylBB6UErKUi5Rw06lwoZNmxFsAv3g+jEEsFNW
 vRrhWnCK+XpFWCd/PGMWsTcyirR2tZ6uqIEcctPPuYbIDL7qG6cLE0LEOflr6j5OK+/YUQ6LgQ0
 ULxb/Sp0Hp4PaH3cODnclOvCxGMLE/Dk2qvG1v8BBIlE+pmbPH0GXCElULTKxUTUf367mlBnGmj
 sO9dfYTR1c/w0LLTeXFgfr0EJMAVUjPMxYYfcdCR3+og23JVMIvXN+6BWd2s5jkXQG97wLeNRbF
 q4xd0KA28z9wSKCXZWw==
X-Proofpoint-GUID: BljGV5U_rPuMr1AM7MKUzaE53eN_x-qh
X-Authority-Analysis: v=2.4 cv=H/dOUOYi c=1 sm=1 tr=0 ts=6ac8a95f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=WUUzfVw4190rvMJAllgA:9
X-Proofpoint-ORIG-GUID: BljGV5U_rPuMr1AM7MKUzaE53eN_x-qh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNCBTYWx0ZWRfX2VqpMEzS2sUQ
 t52bQIgeUy6WCLOUqFG1q1oPR2DuRKeUZIlzSO9leYhKi0kavygb+v2FfX2K5VdIaOGNFdmXCYu
 kleXQiPr+XqaaXFL4oCHHydwT4ZxyQQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090034

On certain hardware, the frame-level CSUM_VALID indication in a MAPv5
coalescing frame cannot be trusted when the frame contains exactly one
packet and hardware completes coalescing due to a TCP FIN or PSH flag, a
packet count limit, a byte count limit or a time limit. The GRO path could
otherwise mark the packet CHECKSUM_UNNECESSARY even when its checksum is
wrong.

Force these frames to CHECKSUM_NONE before either GRO processing or
bitmap-based segmentation. This lets the network stack verify the checksum.
Packets marked by the checksum error bitmap are therefore not dropped
directly by rmnet for these frames.

The single NLO, single packet determination this fix depends on cannot be
based on the num_nlos field declared in the coalescing header, since on
certain simulation hardware configurations that field can be reported
incorrectly even though the per-NLO num_packets fields are accurate.
Derive the effective NLO count from the contiguous num_packets prefix and
stop processing at the first empty entry. This prevents stale values in
unused slots from changing checksum fixup or segmentation behavior.

Co-developed-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
---
v3: no change
v2: https://lore.kernel.org/all/20261008005543.2630828-7-subash.a.kasiviswanathan@oss.qualcomm.com/
v1: https://lore.kernel.org/all/20260930051345.857443-6-subash.a.kasiviswanathan@oss.qualcomm.com/ 

 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 90 ++++++++++++++++---
 1 file changed, 80 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 5ffb811d7ef1..e8adb4006717 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -593,6 +593,68 @@ static void rmnet_map_partial_csum(struct sk_buff *skb,
 	skb->csum_start = skb->data + coal_meta->ip_len - skb->head;
 }
 
+/* On some hardware, num_nlos in the coalescing header can be reported
+ * incorrectly under certain conditions even though the per-NLO num_packets
+ * fields it is meant to summarize are correct. Recompute the NLO count from
+ * the contiguous nl_pairs[] prefix rather than trusting the declared value.
+ * The first empty NLO marks the end of the prefix. Entries after it are not
+ * processed.
+ */
+static int rmnet_map_v5_get_num_nlos(const struct rmnet_map_v5_coal_header *coal_hdr)
+{
+	int nlos;
+
+	for (nlos = 0; nlos < RMNET_MAP_V5_MAX_NLOS; nlos++)
+		if (!coal_hdr->nl_pairs[nlos].num_packets)
+			break;
+
+	if (!nlos)
+		return -EINVAL;
+
+	return nlos;
+}
+
+static void rmnet_map_v5_set_nlos(struct rmnet_map_v5_coal_header *coal_hdr,
+				  u8 nlos)
+{
+	coal_hdr->coal_info = u8_encode_bits(nlos, MAPV5_COALINFO_NUM_NLOS_FMASK) |
+				      (coal_hdr->coal_info & MAPV5_COALINFO_CSUM_VALID_FLAG);
+}
+
+/* The frame-level CSUM_VALID indication for a single NLO, single packet
+ * coalescing frame cannot be trusted when the close reason is a TCP FIN/PSH,
+ * a packet count limit, a byte count limit or a time limit.
+ */
+static bool rmnet_map_v5_csum_fixup(struct rmnet_map_v5_coal_header *coal_hdr)
+{
+	u8 close_value = u8_get_bits(coal_hdr->close_info,
+				     MAPV5_CLOSEINFO_CLOSE_VALUE_FMASK);
+	u8 close_type = u8_get_bits(coal_hdr->close_info,
+				    MAPV5_CLOSEINFO_CLOSE_TYPE_FMASK);
+	u8 num_nlos = u8_get_bits(coal_hdr->coal_info,
+				  MAPV5_COALINFO_NUM_NLOS_FMASK);
+
+	/* Only applies to single NLO, single packet frames */
+	if (num_nlos != 1 || coal_hdr->nl_pairs[0].num_packets != 1)
+		return false;
+
+	/* TCP FIN or PSH triggered the close */
+	if (close_type == RMNET_MAP_COAL_CLOSE_COAL)
+		return true;
+
+	/* Hit a hardware limit */
+	if (close_type == RMNET_MAP_COAL_CLOSE_HW) {
+		switch (close_value) {
+		case RMNET_MAP_COAL_CLOSE_HW_PKT:
+		case RMNET_MAP_COAL_CLOSE_HW_BYTE:
+		case RMNET_MAP_COAL_CLOSE_HW_TIME:
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /* Carve one logical segment from a coalesced SKB and append it to the list.
  * Adjusts TCP sequence numbers, IP IDs/lengths, and checksum state.
  */
@@ -916,14 +978,13 @@ static void rmnet_map_coal_segment_loop(struct sk_buff *coal_skb,
 static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
 				      u64 nlo_err_mask,
 				      struct sk_buff_head *list,
-				      u16 len, u16 total_pkts)
+				      u16 len, u16 total_pkts, u8 num_nlos)
 {
 	bool gro_hw = coal_skb->dev->features & NETIF_F_GRO_HW;
 	bool rxcsum = coal_skb->dev->features & NETIF_F_RXCSUM;
 	struct rmnet_map_v5_coal_header *coal_hdr;
 	struct rmnet_map_coal_metadata coal_meta;
 	bool gro = gro_hw;
-	u8 num_nlos;
 	u32 hlen;
 
 	memset(&coal_meta, 0, sizeof(coal_meta));
@@ -932,7 +993,7 @@ static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
 	skb_pull(coal_skb, sizeof(struct rmnet_map_header));
 	skb_trim(coal_skb, len);
 	coal_hdr = (struct rmnet_map_v5_coal_header *)coal_skb->data;
-	num_nlos = u8_get_bits(coal_hdr->coal_info, MAPV5_COALINFO_NUM_NLOS_FMASK);
+	rmnet_map_v5_set_nlos(coal_hdr, num_nlos);
 	skb_pull(coal_skb, sizeof(*coal_hdr));
 
 	if (!rmnet_map_coal_parse_ip_hdr(coal_skb, &coal_meta, &gro))
@@ -959,6 +1020,12 @@ static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
 		return 0;
 	}
 
+	if (rmnet_map_v5_csum_fixup(coal_hdr) && !coal_meta.zero_csum) {
+		coal_skb->ip_summed = CHECKSUM_NONE;
+		__skb_queue_tail(list, coal_skb);
+		return 0;
+	}
+
 	if (rmnet_map_coal_gro_fast_path(coal_skb, coal_hdr, &coal_meta, list,
 					 num_nlos, gro))
 		return 0;
@@ -991,13 +1058,14 @@ static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
  */
 static int rmnet_map_data_check_coal_header(struct sk_buff *skb,
 					    u64 *nlo_err_mask,
+					    u8 *num_nlos,
 					    u16 *num_pkts)
 {
 	struct rmnet_map_header *maph = (struct rmnet_map_header *)skb->data;
 	struct rmnet_map_v5_coal_header *coal_hdr;
-	u8 num_nlos;
 	u16 pkts = 0;
 	u64 mask = 0;
+	int nlos;
 	int i;
 
 	/* coal header is counted in pkt_len */
@@ -1005,17 +1073,18 @@ static int rmnet_map_data_check_coal_header(struct sk_buff *skb,
 		return -EINVAL;
 
 	coal_hdr = (struct rmnet_map_v5_coal_header *)(skb->data + sizeof(*maph));
-	num_nlos = u8_get_bits(coal_hdr->coal_info, MAPV5_COALINFO_NUM_NLOS_FMASK);
-
-	if (num_nlos == 0 || num_nlos > RMNET_MAP_V5_MAX_NLOS)
+	nlos = rmnet_map_v5_get_num_nlos(coal_hdr);
+	if (nlos < 0)
 		return -EINVAL;
 
+	*num_nlos = nlos;
+
 	for (i = 0; i < RMNET_MAP_V5_MAX_NLOS; i++) {
 		u8 err = coal_hdr->nl_pairs[i].csum_error_bitmap;
 		u8 pkt = coal_hdr->nl_pairs[i].num_packets;
 
 		mask |= ((u64)err) << (8 * i);
-		if (i < num_nlos) {
+		if (i < *num_nlos) {
 			pkts += pkt;
 			if (pkts > RMNET_MAP_V5_MAX_PACKETS)
 				return -EINVAL;
@@ -1034,6 +1103,7 @@ int rmnet_map_process_next_hdr_packet(struct sk_buff *skb,
 	struct rmnet_priv *priv = netdev_priv(skb->dev);
 	u64 nlo_err_mask;
 	u16 num_pkts;
+	u8 num_nlos;
 	int rc;
 
 	switch (rmnet_map_get_next_hdr_type(skb)) {
@@ -1042,7 +1112,7 @@ int rmnet_map_process_next_hdr_packet(struct sk_buff *skb,
 			return -EINVAL;
 
 		rc = rmnet_map_data_check_coal_header(skb, &nlo_err_mask,
-						      &num_pkts);
+						      &num_nlos, &num_pkts);
 		if (rc)
 			return rc;
 
@@ -1051,7 +1121,7 @@ int rmnet_map_process_next_hdr_packet(struct sk_buff *skb,
 			return -ENOMEM;
 
 		rc = rmnet_map_segment_coal_skb(skb, nlo_err_mask, list, len,
-						num_pkts);
+						num_pkts, num_nlos);
 		if (rc)
 			return rc;
 
-- 
2.34.1

