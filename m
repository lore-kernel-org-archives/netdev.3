Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2801128C2BF;
	Thu,  8 Oct 2026 00:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791421045; cv=none; b=P1M95M8VpwXUP/3+bqbH+jPj+wPXYHiy9fHL0+hrVxz13CxcedmfSOWwrMpUJdImXR9+OsPjGXaN6Cws0O+0s1oaOVbTEU966VVN3w7p34gA9K3T5N1VoVTK9vg6VVmT69/tPSrjbJeqEkAi6uTf0gEL5Y7lW74hNBhEOiA4IeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791421045; c=relaxed/simple;
	bh=ZS+mhY/IX4ZP9JO30Do6Ai/yNc93jMJ1rEuTFypj8HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aOUFXnOui31QaTdKOhbGKj5jyhd+ZJNTexg2wwkLaHFcCwfQ3xHhA8XICKTXX5oFMOYw6/GpPnMEITI6nDUvsX65K9ibve/LCgykXANdV4rok9CyW63ADYuf+K4phjMb1jKDh21LMHsAArc1tLLXtOuGFw0veoB44+G/+UaSbcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CYvarI8I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CYvarI8I"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697LtnbX1345967;
	Thu, 8 Oct 2026 00:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=EER1/Yvf4ec
	CXWUJbrgRroOF1l+3JFNY7g4YRhJCZHo=; b=CYvarI8I2BZwG5LPjCuA0PqJ4Zf
	QoXIhHo8gvOp5EVv4tpQfxEwn7LEiXXFlhLYqhOauFmFQEl+le3SDcFpFaOE2k6i
	avHww5GzZd7XUMVIA6VQ7ldbySYqmfc5oEPsY3q4ZImokOkIPG5CsSSraTH5dBkL
	DLT/BSUvD5gftbL5/3X78XXua3OzGfgLQp/LevPcqAfDjalT3kGAki6KrZv7f9r+
	lLC9aN/P1qHW7+IaRieqNCmh4rOXH9XsgtKYeRRWvF1FRpTXeJeTMT0asj2pzJww
	JR9hnq3+NxjdPFb08V2pTRXN6yXLI+8I3r646zhpxYDTk6qzNFJ4CQ46bsQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe80euf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 00:56:58 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6980uvGn1429387;
	Thu, 8 Oct 2026 00:56:57 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6980uvSX1429358
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 00:56:57 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id B800FAD9; Wed,  7 Oct 2026 17:56:56 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next v2 6/8] net: qualcomm: rmnet: Work around coalescing hardware quirks
Date: Wed,  7 Oct 2026 17:55:43 -0700
Message-Id: <20261008005543.2630828-7-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwMyBTYWx0ZWRfX3TeG90brdpv8
 MKXZanF4b+jgNmJc/C4EhzoJZqVuLPpAk5ePpAT4FVmuNMuWlOTDv8itGHTvHfzIW3q/8bZ1JZU
 7pR9nfbNfxOCgRtqDeX91ZxxIxr/w2vuLjqUMUIQj+IMFGABaeJbsKD0vyVv1eKsM8fn3d5NX7u
 hkwItIpLK0YhRGFpGjPxnIHf1cj0rYBAbutNByYPh8D6o5nWutDu6x8uWcQTgd3wtzrCbHdBcTu
 pVDXlJF/QZOjTL37IbXW8WR318DaE7P7t4CzX+7ovMlnQEzoQjmWtPZPtZcvYDYpUUOMvuZPyv7
 AXLStuR8WHkINwvYCA/JM68rN/fwQsBZH6e1Y95ZFpB3PNdrtHnktBMpM6tyxKDliE7CrBRoqWl
 F5ykBSfIy5Rv4vr8aUHOCJ+w60EfKUDwMQV+qyvDvitqfRtMP/juC4AaZCksO4VJmgGXPXfr8tv
 DgaTr2KCv5scTc5b4OQ==
X-Proofpoint-GUID: VaIMEMG8lnajXz6GNVEQlAzD_R9Qvfpb
X-Proofpoint-ORIG-GUID: VaIMEMG8lnajXz6GNVEQlAzD_R9Qvfpb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwMyBTYWx0ZWRfX03ca8PmIPiJd
 hS0/35vXgWM7RjYYqdxniN9ZlS9e+ZSm9AXMhlcocAZjtuLrSrtqVFCfjVV71UjyWaDk5rwVGcz
 e/UAWTvxlOdU6majz69cWHGJAVJi69o=
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6ac6ea5a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=WUUzfVw4190rvMJAllgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080003

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
v2:
  - Update the nlo field parsing checks
  - Add more comments about the checksum related handling
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

