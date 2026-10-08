Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226312D3EEB;
	Thu,  8 Oct 2026 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791421046; cv=none; b=cRUHGHmSzW9g9mJyxFPBf6NMa4MUuVs0dOH8rMlZg2Ah8I6As1YiohU3cEwLDCDNNu10whzRZFweMOErfrhw/mrgb+DprF4URuMeLeRgKHyb3+3IYdpmoUYU8ifaX8tSxYvRW5zq5l5U9dEBXELjzMp9HBei4exDOLYaJIvUPi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791421046; c=relaxed/simple;
	bh=v+uSw36GybNN2AGUfreiFXduP10nY5Y7dqtBjLQeQuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R1W2+dzfhZ97q7Mb30B4ZGWhS9ufr5cp2JPw4Szh5v13sKOqt9UI+VnKA95IbfnNoIy6EaLk34VjQVaILQUI7CunxYdMIo/2jZeaXjwI6pxKBvs8f2Q4jQ5tCMPKD83vWKeBYIPPCO4r0FFwrU3E5DJRS7lIwZT/1+C69PhGBeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XZ/1pE5U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XZ/1pE5U"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697LuQQP1972902;
	Thu, 8 Oct 2026 00:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=66wVtErp65k
	toVjojyWaNKc9JasNCG4qA0Rm2AEFoBs=; b=XZ/1pE5UulMDUOU/0l2toPYkZ0w
	OLKZQCPUkH5BT6Cm+i0Uajxm3ZU2ZRTzN4y80aUsmCkLwJvJFtHTcjgz6EGvppzt
	dKLAKmrNyqgY5q1YV6rBXpht4PYulBpSGUF+wAfkOEDPS9ts6IZJitYDEj4dvHDJ
	YSM6VFSucWOn6zaUckdizOWmDABSW0bi0rJ/FA0aal9ZEo+O0y3aLUhsj+n+NlJn
	0tfTpXuzdUpIJ7k/7/SYO3stlnL1rbtlrSBmJDT95HkPIykfS/ejlw4RMymM176c
	TRZoTtepBGnKevJKFUiDwfkjftBtdYfdvNC0Lfu5xqi0cQ1yAVGIeZlIv6w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe68fnu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 00:56:57 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6980uvnf1544288;
	Thu, 8 Oct 2026 00:56:57 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 6980uuBj1544281
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 00:56:57 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id A7DFBAD6; Wed,  7 Oct 2026 17:56:56 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next v2 3/8] net: qualcomm: rmnet: Process MAPv5 frames as a list
Date: Wed,  7 Oct 2026 17:55:40 -0700
Message-Id: <20261008005543.2630828-4-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: qhUwgdXYVimPPQb1BRLTKsrK9WehENDR
X-Authority-Analysis: v=2.4 cv=HcWB3SE8 c=1 sm=1 tr=0 ts=6ac6ea5a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=WmGS0fCEuoS5Zl8EK2wA:9
X-Proofpoint-GUID: qhUwgdXYVimPPQb1BRLTKsrK9WehENDR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwMyBTYWx0ZWRfXx+RXb8aFkC7/
 /bQt1Ub0B0NLYPBZyRb1PbHn1qf9QXykAyOZxdsMWwl3S2ZWFiU5CZBN1hvIAKzWXJ6+73xla4H
 ON3evwAbs0LSXIK4Qud4UZwsImESvjh5VELyeS17rnlq9Kv+WjlkT8Gz8nwc5B9ZwP0Cl8Ikiit
 sZucUk5KEZEr9xEfb3OcfKntbWiDJuvgVFM/U1JTqFvXiVZAdvh2Nbbeiw9ST4OpGnLJYe+iyvz
 z3OCG2rk23Ld3tuuXM5iatsDjLhdfMBwNZT8aXOKFbFPun7ffdvoG8uDt2oSkec7lEnoTUa1LDI
 NxAFqGmpSgFDhOl07w6Qp1QXuw89CZDj+8XAid1OmqoY7K/PP+kmTyt53VzEurhHUpTcJqjDb4/
 gO/VNzHnTDBA3LJUGE+m9Mf4IQ8GZYJ0PK+bBjogGwvTcuuNL8EoiMcD9Rl93mKU50qhPCBlg8R
 Z5Oly9d0tvVhNAoRQkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwMyBTYWx0ZWRfX6OQ9r1/ZC1D2
 UxrRfW5NZA1OnFTCkKW/uwCnXohb3XjMPBA7R5XHxWBwo34kjJzEKM7Ob8Fuhw8XgEbS8QzJXRM
 3BY/FXwGRqdT5klulURYFsGzCeN3vcI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080003

Add support for handling the MAP packets as a list in preparation for
the subsequent patch in the series  which adds support for handling the
coalescing packets. This is needed as a single coalescing MAP packet could
yield multiple IP packets.

There is no functional change in the handling of the previously
supported MAP packet formats.

Co-developed-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
---
v2: no change
v1: https://lore.kernel.org/all/20260930051345.857443-3-subash.a.kasiviswanathan@oss.qualcomm.com/

 .../ethernet/qualcomm/rmnet/rmnet_handlers.c  | 22 +++++--
 .../net/ethernet/qualcomm/rmnet/rmnet_map.h   |  4 +-
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 57 ++++++++++++-------
 3 files changed, 58 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
index aa5523f4618e..ab1dfbd833e3 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
@@ -50,6 +50,16 @@ rmnet_deliver_skb(struct sk_buff *skb)
 	gro_cells_receive(&priv->gro_cells, skb);
 }
 
+static void rmnet_deliver_skb_list(struct sk_buff_head *head)
+{
+	struct sk_buff *skb;
+
+	while ((skb = __skb_dequeue(head))) {
+		rmnet_set_skb_proto(skb);
+		rmnet_deliver_skb(skb);
+	}
+}
+
 /* MAP handler */
 
 static void
@@ -59,6 +69,7 @@ __rmnet_map_ingress_handler(struct sk_buff *skb,
 {
 	struct rmnet_map_header *map_header = (void *)skb->data;
 	struct rmnet_endpoint *ep;
+	struct sk_buff_head list;
 	u16 len, pad;
 	u8 mux_id;
 
@@ -83,12 +94,12 @@ __rmnet_map_ingress_handler(struct sk_buff *skb,
 
 	skb->dev = ep->egress_dev;
 
+	__skb_queue_head_init(&list);
+
 	if ((data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5) &&
 	    (map_header->flags & MAP_NEXT_HEADER_FLAG)) {
-		if (rmnet_map_process_next_hdr_packet(skb, len))
+		if (rmnet_map_process_next_hdr_packet(skb, &list, len))
 			goto free_skb;
-		skb_pull(skb, sizeof(*map_header));
-		rmnet_set_skb_proto(skb);
 	} else {
 		/* Subtract MAP header */
 		skb_pull(skb, sizeof(*map_header));
@@ -96,10 +107,11 @@ __rmnet_map_ingress_handler(struct sk_buff *skb,
 		if (data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV4 &&
 		    !rmnet_map_checksum_downlink_packet(skb, len + pad))
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		skb_trim(skb, len);
+		__skb_queue_tail(&list, skb);
 	}
 
-	skb_trim(skb, len);
-	rmnet_deliver_skb(skb);
+	rmnet_deliver_skb_list(&list);
 	return;
 
 free_skb:
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
index 0977e495f591..ef738ce015d4 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
@@ -53,7 +53,9 @@ void rmnet_map_checksum_uplink_packet(struct sk_buff *skb,
 				      struct rmnet_port *port,
 				      struct net_device *orig_dev,
 				      int csum_type);
-int rmnet_map_process_next_hdr_packet(struct sk_buff *skb, u16 len);
+int rmnet_map_process_next_hdr_packet(struct sk_buff *skb,
+				      struct sk_buff_head *list,
+				      u16 len);
 unsigned int rmnet_map_tx_aggregate(struct sk_buff *skb, struct rmnet_port *port,
 				    struct net_device *orig_dev);
 void rmnet_map_tx_aggregate_init(struct rmnet_port *port);
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 39d6d084e73f..577f2758e385 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -497,35 +497,54 @@ void rmnet_map_checksum_uplink_packet(struct sk_buff *skb,
 	}
 }
 
-/* Process a MAPv5 packet header */
+static struct rmnet_map_v5_csum_header *
+rmnet_map_get_next_hdr(struct sk_buff *skb)
+{
+	return (struct rmnet_map_v5_csum_header *)(skb->data +
+						   sizeof(struct rmnet_map_header));
+}
+
+static u8 rmnet_map_get_next_hdr_type(struct sk_buff *skb)
+{
+	struct rmnet_map_v5_csum_header *hdr = rmnet_map_get_next_hdr(skb);
+
+	return u8_get_bits(hdr->header_info, MAPV5_HDRINFO_HDR_TYPE_FMASK);
+}
+
+static bool rmnet_map_get_csum_valid(struct sk_buff *skb)
+{
+	struct rmnet_map_v5_csum_header *hdr = rmnet_map_get_next_hdr(skb);
+
+	return !!(hdr->csum_info & MAPV5_CSUMINFO_VALID_FLAG);
+}
+
 int rmnet_map_process_next_hdr_packet(struct sk_buff *skb,
+				      struct sk_buff_head *list,
 				      u16 len)
 {
 	struct rmnet_priv *priv = netdev_priv(skb->dev);
-	struct rmnet_map_v5_csum_header *next_hdr;
-	u8 nexthdr_type;
 
-	next_hdr = (struct rmnet_map_v5_csum_header *)(skb->data +
-			sizeof(struct rmnet_map_header));
+	switch (rmnet_map_get_next_hdr_type(skb)) {
+	case RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD:
+		if (unlikely(!(skb->dev->features & NETIF_F_RXCSUM))) {
+			priv->stats.csum_sw++;
+		} else if (rmnet_map_get_csum_valid(skb)) {
+			priv->stats.csum_ok++;
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		} else {
+			priv->stats.csum_valid_unset++;
+		}
 
-	nexthdr_type = u8_get_bits(next_hdr->header_info,
-				   MAPV5_HDRINFO_HDR_TYPE_FMASK);
+		skb_pull(skb, sizeof(struct rmnet_map_header) +
+			      sizeof(struct rmnet_map_v5_csum_header));
+		skb_trim(skb, len);
+		__skb_queue_tail(list, skb);
+		break;
 
-	if (nexthdr_type != RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD)
+	default:
 		return -EINVAL;
-
-	if (unlikely(!(skb->dev->features & NETIF_F_RXCSUM))) {
-		priv->stats.csum_sw++;
-	} else if (next_hdr->csum_info & MAPV5_CSUMINFO_VALID_FLAG) {
-		priv->stats.csum_ok++;
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-	} else {
-		priv->stats.csum_valid_unset++;
 	}
 
-	/* Pull csum v5 header */
-	skb_pull(skb, sizeof(*next_hdr));
-
 	return 0;
 }
 
-- 
2.34.1

