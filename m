Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728713909A2;
	Wed, 30 Sep 2026 05:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790745294; cv=none; b=XGEITOUr1I3TpiF2swxWw9hgSX321mh8P4GMs3VlFpAuM21VIu6lBOSDe9DBYVVtbiyJxLG9Ey9vYfHe++uIhrlw3inb+QRbqWfZIFVAe6Dylv0AWu0zl6wBlVkQLi0n6CVOnQsicyeXTuq0qf/DyITjJerg5W8EefrN0Wq3/fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790745294; c=relaxed/simple;
	bh=A6QbYCRzGtVq/D+iZRCWOifQkAO5lvHNDZVfFHAs4xQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UwYPfW1lT8s0DNDatRpR+74/2ID0tHvrDvFsRzuoWiQrtbXbEV178dm4B4Q18FkB0bbcic4hKSlApomA21nRKwEIIy900uXCzb6dXpC+LO6l5Oti96ylLypjTiR9z6u47PmA3IHhtOXlDmCcgcGjgzYzLhekBRmqTNIUoSrRdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y6q7wiwV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y6q7wiwV"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TNPghY2250159;
	Wed, 30 Sep 2026 05:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DUpcp6hMQUM
	M+IMVu4MrYucP2bRvtt1vB0lRp6zep98=; b=Y6q7wiwV8MKB2encM9tdv9IxXIT
	s+wbGiTL7NxXwZHJXxJNt6lrn2Dv0Ac2jUoF3SvdFr9JRhD8OrVwtJVNvV2RNxlP
	Aygm6sQqbvBQ7aNGHDuYolasNbhVaqCRqbF2usvgKz/Si7yVqFqK/I9wZyp6Hs57
	nKgugtXlNqhCtC8tHAeMXLv9VFLfe8CEzoPL/pR8szeCwwgs/lIYAxcoO49h/PN0
	kgZRueukmlhidvmQbrzzMolOyhpjRITqeKQQkb0QZmBBHAJHZaVDZ5Memtkd1H8d
	SA9o8qYGd3FawnaI5aQ/u+g/FcfjyAvhnartCOY3Xp0X6e2coyPeATDEPJw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0nm3hhg0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 05:14:36 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U59XrO1569493;
	Wed, 30 Sep 2026 05:14:35 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 68U5EZvM1579173
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 05:14:35 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id C5A95AC1; Tue, 29 Sep 2026 22:14:34 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next 5/7] net: qualcomm: rmnet: Work around coalescing hardware quirks
Date: Tue, 29 Sep 2026 22:13:43 -0700
Message-Id: <20260930051345.857443-6-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: d0DnYHMg8N2V5vOTowtP8jW4ULWUH8RI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyMCBTYWx0ZWRfX/90+4206YOSg
 yOT+75nxGY251R3Y+togf3BqGGrcyUX7bQ/oVprKM7grE2UQOE2suBXpyTcQp+EihTPDjlCiIYq
 7G8tm+baOYcxx29hPF71W454YUHkoG3n8LZBF9t4YPMECta8KejvtgPw91o21EnY4FIF0N4pnUO
 rkcaVZ2eEs+5lHJTJA/hXGJ6D0RbgGYn8t2Si6YD2BA0uWhKLPmFzo48nMzyyBrL5mdX4jKBdFO
 obJ9kJpmerjcIl2tcOsio9ABnYXopzwaYfFY6dMeKoXUXDyiNz8FOOGyu/Me+pZpDrQHJbaIN1h
 vNTTmghQcFT4vG/2CbdaRb6GGYUXDjFBpn60meCsrZ4OjWouZUoES8GTSCJEV2LcITKE8QpdZc+
 IgMLonWFHbTLfNnn5/BG/01qoT22FGTTzCnaU3hZ72JckGcIzbHL5Tz5sZCBDNm6jly9tOilpUq
 WttIdgKTl+aIJmawYcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyMCBTYWx0ZWRfXwHNIykQUAxX1
 MYBqKMhhn3/Q5VkcdxJ4FHDLW2FIEWAfTcR+MO7NGOdZI2ik+43ubwsvuo2J+jkSOLUVqE9sA0z
 0ZhIfQyRU6vUcmBxYVF65slcrw2ZUbw=
X-Proofpoint-GUID: d0DnYHMg8N2V5vOTowtP8jW4ULWUH8RI
X-Authority-Analysis: v=2.4 cv=fqxJ914f c=1 sm=1 tr=0 ts=6abc9abc cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=0hx0W16NV3ASwRnRADkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300020

On certain hardware, the checksum valid indication from the bitmap
inside a MAPv5 coalescing frame cannot be trusted when the frame contains
exactly one packet and hardware completes the coalescing due to a
TCP FIN or PSH flag, a packet count limit, a byte count limit or a time
limit.  The hardware sets CSUM_VALID incorrectly in these cases, causing
the driver to mark packets CHECKSUM_UNNECESSARY when the checksum may in
fact be wrong.

Instead, set ip_summed to CHECKSUM_NONE so that the network stack verifies
the checksum rather than trusting the hardware indication.

The single NLO, single packet determination this fix depends on cannot
be based on the num_nlos field declared in the coalescing header, since
on certain simulation hardware configurations that field can be reported
incorrectly even though the per-NLO num_packets fields are accurate.
Recompute the true NLO count from the actual nl_pairs[] content before
applying the fixup so the determination is reliable regardless of
whether num_nlos itself can be trusted.

Co-developed-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
---
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index bb88e19e28d8..1f9e592e24b6 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -593,6 +593,61 @@ static void rmnet_map_partial_csum(struct sk_buff *skb,
 	skb->csum_start = skb->data + coal_meta->ip_len - skb->head;
 }
 
+/* On some hardware, num_nlos in the coalescing header can be reported
+ * incorrectly under certain conditions even though the per-NLO num_packets
+ * fields it is meant to summarize are correct. Recompute the true NLO count
+ * directly from the nl_pairs[] content rather than trusting the declared
+ * value, so that rmnet_map_v5_csum_fixup()'s single NLO, single packet check
+ * is reliable.
+ */
+static void rmnet_map_v5_fixup_num_nlos(struct rmnet_map_v5_coal_header *coal_hdr)
+{
+	u8 nlos = 0;
+	int i;
+
+	for (i = 0; i < RMNET_MAP_V5_MAX_NLOS; i++) {
+		if (coal_hdr->nl_pairs[i].num_packets)
+			nlos++;
+	}
+
+	coal_hdr->coal_info = u8_encode_bits(nlos, MAPV5_COALINFO_NUM_NLOS_FMASK) |
+			      (coal_hdr->coal_info & MAPV5_COALINFO_CSUM_VALID_FLAG);
+}
+
+/* The checksum valid indication for a single NLO, single packet coalescing
+ * frame cannot be trusted when the close reason is a TCP FIN/PSH, a packet
+ * count limit, a byte count limit or a time limit.
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
@@ -913,6 +968,7 @@ static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
 	skb_pull(coal_skb, sizeof(struct rmnet_map_header));
 	skb_trim(coal_skb, len);
 	coal_hdr = (struct rmnet_map_v5_coal_header *)coal_skb->data;
+	rmnet_map_v5_fixup_num_nlos(coal_hdr);
 	num_nlos = u8_get_bits(coal_hdr->coal_info, MAPV5_COALINFO_NUM_NLOS_FMASK);
 	skb_pull(coal_skb, sizeof(*coal_hdr));
 
@@ -927,6 +983,12 @@ static int rmnet_map_segment_coal_skb(struct sk_buff *coal_skb,
 	if (!rmnet_map_coal_validate_bounds(coal_skb, coal_hdr, num_nlos, hlen))
 		return -EINVAL;
 
+	if (rmnet_map_v5_csum_fixup(coal_hdr) && !coal_meta.zero_csum) {
+		coal_skb->ip_summed = CHECKSUM_NONE;
+		__skb_queue_tail(list, coal_skb);
+		return 0;
+	}
+
 	if (rmnet_map_coal_gro_fast_path(coal_skb, coal_hdr, &coal_meta, list,
 					 num_nlos, gro))
 		return 0;
-- 
2.34.1

