Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DCD3E9C0D;
	Fri,  9 Oct 2026 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535466; cv=none; b=AeXsY4i42g4sTMgAHvvWbbP7qD4dhYt0/hY8d9tIosetpx+YW36YGbogWhuQ+9O/ogTVKTSS8Qk8lE+hm4sA5VI1NENRPPA56uMjvpodLeC8zBiy5JfQLVUHCz8msEueVhDEr14V8zM94CUqY4of1SM0PN+pGM8BHB9jmqTCEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535466; c=relaxed/simple;
	bh=wNBXMEjME8+piio+r2LiqOka4n+z/tN/J9K9sdu4cDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FW6l4trdtx5q/fdi8F6q+190N8jqJhAmnxxjp618HVVqLeHgMBM2FqQ1weXwlatNHkyxn9ge+rXfYavE+nNy00iNWTbZ0fDTHVhm/n+Yht+C+Bsh8IV/U74TlHHwCFOU/xoKEd64gNE+gN+fkS+9kAzhR0WLbab/bZRDG/a8d4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mSrh7OxY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mSrh7OxY"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KElx642334;
	Fri, 9 Oct 2026 08:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=OpdXO+6ePh8
	Y8GwFsQHQeIbjjrupoajEkzM9L+3LJWo=; b=mSrh7OxYwCXd70u4CQhH8dLxKsS
	p378UOsUkH/N4q1AdevBR6E6tWiv7wdd+ljGNUJJrwWyZxQjKnyWPb95YC++KP6c
	tlnKcid/xPri4ODkWWPeyM6jszKCZOVOBGv/gScUe++dg9Hf07meLi/tHBLQ7vx+
	1NN2fUsvbOJmNreb+9qIlMbaNtzm9ojpjiqTUDUW3D5eOmYqb+1bp/cYMPuYAmb4
	BieUCrQ/GlfyFO+laVWhmjGE3WrxNAlUJOzyEDnuBUzi/+6cxSJvxFPmhj/zd7Nx
	ZGvLRFmGNDE0JPRnVAxCM163IYfAuBzkH9WZFoCV3Y4VRmMC3bfWcDlTPwA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxrtrd9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:44:10 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998i9Gw349026;
	Fri, 9 Oct 2026 08:44:09 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 6998i9Jj349013
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:44:09 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id 4E37BACA; Fri,  9 Oct 2026 01:44:09 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net-next v3 3/8] net: qualcomm: rmnet: Process MAPv5 frames as a list
Date: Fri,  9 Oct 2026 01:43:46 -0700
Message-Id: <20261009084351.317632-4-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac8a95a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=WmGS0fCEuoS5Zl8EK2wA:9
X-Proofpoint-GUID: ZSxjg253s_RAZJeMZ9PRjNQqJgGA8YBn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNCBTYWx0ZWRfXzleywXvi2OR6
 GHoPP86d0s58mIG3Rn75b0zOBoAXXUxLRVvV5kNf67BtQCh/hZ4sMm1cQjKTWlkLVBZm75CRcOi
 gD9H3YHtO4gia8x0UJPFRsR70D7HlTq7y79KhmCiEImLyuGhTVqSTYUIzvEcC4aq0PSeOEBX/iW
 fpymFWq8ZSCkpxSBJLtoIwl1sn9qcvIjKd5G8rVDlHf5+UChCC17kCmNZ8m2N+Sup4WAatIQiIH
 UiKQvbehdWEZ9cdOQlfcBMs9QyL8BfzTkuwcLg++5gGbgd9L5Xcj5ABfuzZr+kBevCv+5iRoPcl
 2sb7ELx5vAjxG1wD3eU+Fpq5q64ktVqNBOlC7zYg9WhOuJxTiaH8i7rV5Tomz3St4PuLs7qIaTS
 zhM748owOjzO2Wy26qenoVfAI+O1D9z35qxiafHNYy7ZP/Zd40oN2a6L2O5iRVCMJFiAqZNWDZY
 fIHcZQ2wmgBf6DsyHFA==
X-Proofpoint-ORIG-GUID: ZSxjg253s_RAZJeMZ9PRjNQqJgGA8YBn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNCBTYWx0ZWRfX9WRdkHTvlB5P
 FUKwU/1ocFdis4iS6DiD5adwrpbrfVrzvP57e9sn5qBqZWaiFOY0qQOTltqumw7hEOvaVpiiPP6
 zktU3dliPvWwYJRUIdh6OY7PGIjkYBk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090034

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
v3: no change
v2: https://lore.kernel.org/all/20261008005543.2630828-4-subash.a.kasiviswanathan@oss.qualcomm.com/
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

