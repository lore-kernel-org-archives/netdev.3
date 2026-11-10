Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348415;
	b=oCkKBsGlCLf9Mx7pnYd+H4+E/ulb4h7ZMPhJC30lgWZtdl6lqmGSIMsUBoWn319qyPU1
	 0NBzUVIbZ8vw12gn4UH3DLGpTuQcEzbyeyPQa3XTJRGwMXUGId8XjaZXyHSk65hRJabpJ
	 x7HiktgSE5rbCQMjWePt4XDIq9xg8dTOqEqev9sFM7Lr0pM6bli7nOLNkrSV2O+pWc/7E
	 JHsI+Wssch+JWXhXZabHvA67hycnqs9W/yEsdC2pCsOA7GdKTlYsMrauKfy2BtLCv6+9J
	 zFRWsNFzUdvUFnrpYcwZdzFLcYejopj/h9bIPT9iS5cLiosxjpjWAOCUmTBRlrzw6HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=e9Yk425c0lmvI3Fov6PMm0wFZURaAWgsc3MI4RNZV48=;
	b=RG+cKk1fz3qtQdvwH6NKnf5XeF5BmkihUewj56u2yooJP6NGYXh5wflhts+Ay/Y701jM
	 cQwMWWi2553LqfTJJf3DQofRosB8CmX+vr/gAqv7nX2xUvoHLTVNuXTjMkUCqgna2MFr0
	 +cYtKtQJZ2s9LxKdrVNTTCyeoodrNpK4fyo5aId1fOU+SsvZ7nm5RRxMWWJ4bgAkncsq/
	 d/POVJeC7Btk+tgT1L5/t1k51+fZBAR7PucpFBNM6i3CBpeB1medl8lQpNfYdIKPkPUsH
	 ZmI3zxpyQjYhWKaQZf27LyNoGYeGV90JtApkoP0iHcD0r/H8mXZFulRtHMhfDm91z1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kU4A+hFw;
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC560A3801
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98CC560A3801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kU4A+hFw
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b305e10ac7so27500077b3.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794348413; x=1794953213; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9Yk425c0lmvI3Fov6PMm0wFZURaAWgsc3MI4RNZV48=;
        b=kU4A+hFwt6DVDPy0h4leSYLAH5R2uPO+z7FPy+2ygFqORSmw6zkXXWfCHX7KeZUCIU
         XsN5aIwI77xJKJpMG8i8BVyuQK56Bb+rJfbSw6KC9LaHpTKzy+E9ezAuuR7KkyJ6SRWQ
         ySfwv4Qj+/XCdo2Rh3DkUUSPPF+tgQpyukzABc5brC6yMaKh4XbswnUMRW9d4LmkZn4L
         X4HkiMs8Q1RSDU44cdKVOYtbj5sn95ovYPiCkJs2GjFH4wk2HYVYQmH9bLcUHirXgMrC
         GBps8y0HZCAFrWkqy+ppd/tQuTQRISOcPzOJ/hJbebmAQSaDmBlRUV3gY8b9lKVo7lHg
         1qdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348414; x=1794953214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e9Yk425c0lmvI3Fov6PMm0wFZURaAWgsc3MI4RNZV48=;
        b=UeP8KAhkHf2ixIAthRrPf6FrTZA/vlhKHuEmD27/7hKdRMr5jAXSg7pxYKtUSpXaL9
         V4K8pkvcFV9bk8d8yi6gaDvj2oaXfG0Ynu2FQ6+nvnPxwgZkHMRSTtwYp4SJBX9owvZE
         TjQV++tw/tCPs8EqDjvt6/hsvt+4j5PnRH7x9bZucQpJqSicyU4FKJMlKTmTx9P7w6fl
         CGSTDSyD18VRtSLQuQNZ5y0XDjCgi+3O7dQyNdCUk4ttSpl2JkklaO4E+1fgw1ypzO/Q
         Phbokvppovy//hl6AcvnlWPi1apMAkJVcpBvsTkV92GB8jTGJxFn6y+xk3OaaVTWrUb6
         pKgw==
X-Gm-Message-State: APuU4Z8UPqDS2L5xrzzrZrztuJ/hdufMYVjCmY9O1fkxgEqOIS6tbe6K
	9Ftx8sXrCcLIWtovA821HAM/Kx3jw4ln7awbqd1rY0RWiIG42u+zbm6w
X-Gm-Gg: AYBFou1dG/OdujR7eoVLB124RInELUfYaf41Ab7AIyzqxTePZHY0qMY0+4mWf2PVbfk
	u2h0M2QpYdmXkhuyzechJTUxCPyoIEo9GairFnROfvKrkbGbILzWLD4kiPm6G9nREjfbXXy651f
	+UMQ0q//HMlw62NQxbMLrcyexIGgFSr7ktonujUvQkQ4F1wqfdQi2iSjiTN/c+H0zXMQ4jpLfau
	RpvZc385CHpQnJzQgCFBqtp3srqICQRfWe3/dyi5LiRTILQYaiVWPfvQa0JPKEANDOoXEf+32XW
	MTV9/iTUX090Kjw3p5blEju/xfdy2+2oGP5iDCtAraxqzJ1yAWsf/+rCgpQpuqdYkeDi2eilovz
	wL4RKSsnU6VFk/Qu3FHis2lBOqhdB7xpS3tUfE7FIvQghswOIhVD5BVbcKtFtku7ez+JtM7rzms
	eqO37JARsp+lKfeCWa/5CjFd+fHzJLhKfxK/6OBVKde0SQ+tf98g3R2MFLplI4Q9CknB7ATo11c
	UC5/B6dIMO5UAOzlTnE2Rb4e44w2s7CeoUYEcpAOKtPzoN3JYkgBgmxjMbKbgRtk++uaomRkJBL
	p2nPNYhy+jKKcebFdwAgwgVFn71TlXroF8liJYCZ/r+v7PEr
X-Received: by 2002:a05:690c:9204:b0:8b1:4394:bebf with SMTP id 00721157ae682-8b3a80d49f4mr3999677b3.33.1794348413594;
        Tue, 10 Nov 2026 14:06:53 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393408893sm30218057b3.26.2026.11.10.14.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:06:53 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 10 Nov 2026 14:06:37 -0800
Subject: [PATCH net-next v2 4/6] eth: mpnic: UDP segmentation offload
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-mpnic-lso-v2-4-ccd37b051d08@gmail.com>
References: <20261110-mpnic-lso-v2-0-ccd37b051d08@gmail.com>
In-Reply-To: <20261110-mpnic-lso-v2-0-ccd37b051d08@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, 
 Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0

Support segmentation of non-encapsulated udp4/udp6 packets. Like for
tcp, the segmentation engine expects the udp csum to be seeded with 0
length.

The HW inverts UDP checksums computed as 0 during segmentation.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
v2:
- fall back to SW GSO for skbs shorter than MPNIC_MIN_FRAME_LEN, since
  HW LSO would segment the zero padding as payload
---
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h    |  2 ++
 drivers/net/ethernet/meta/mpnic/mpnic_init.c   |  1 +
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c |  3 ++-
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 36 +++++++++++++++++++-------
 4 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
index 672ce0a98c22..2cd627d62bf5 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
@@ -20,6 +20,7 @@
 #define MPNIC_TWD_L4_TYPE		DESC_GENMASK(33, 32)
 enum {
 	MPNIC_TWD_L4_TYPE_TCP	= 1,
+	MPNIC_TWD_L4_TYPE_UDP	= 2,
 };
 
 #define MPNIC_TWD_FLAG_REQ_LSO		DESC_BIT(35)
@@ -335,6 +336,7 @@ enum {
 
 #define MPNIC_TOF_MODE_IPV4_ZERO_CSUM		CSR_BIT(1)
 #define MPNIC_TOF_MODE_TCP_ZERO_CSUM		CSR_BIT(2)
+#define MPNIC_TOF_MODE_UDP_ZERO_CSUM		CSR_BIT(3)
 #define MPNIC_TOF_MODE_L4_ZERO_CSUM		CSR_BIT(4)
 #define MPNIC_TOF_TCP_FLAG_CLR		0x7e3030		/* 0x1f8c0c0 */
 #define MPNIC_TOF_TCP_FLAG_CLR_FIRST_SEGMENT	CSR_GENMASK(8, 0)
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_init.c b/drivers/net/ethernet/meta/mpnic/mpnic_init.c
index b9a41656f8f7..ab832ec5de0e 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_init.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_init.c
@@ -304,6 +304,7 @@ static void mpnic_txglb_init(struct mpnic_dev *mpd)
 			      MPNIC_IPV4_ID_MODE_INCREMENT) |
 		   FIELD_PREP(MPNIC_TOF_MODE_IPV4_ZERO_CSUM, 1) |
 		   FIELD_PREP(MPNIC_TOF_MODE_TCP_ZERO_CSUM, 1) |
+		   FIELD_PREP(MPNIC_TOF_MODE_UDP_ZERO_CSUM, 0) |
 		   FIELD_PREP(MPNIC_TOF_MODE_L4_ZERO_CSUM, 0));
 	mpnic_wr64(mpd, MPNIC_TOF_TCP_FLAG_CLR,
 		   FIELD_PREP(MPNIC_TOF_TCP_FLAG_CLR_FIRST_SEGMENT,
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
index bde327ad3154..bf3b459ba5be 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
@@ -328,7 +328,8 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
 		NETIF_F_RXCSUM |
 		NETIF_F_TSO |
 		NETIF_F_TSO_ECN |
-		NETIF_F_TSO6;
+		NETIF_F_TSO6 |
+		NETIF_F_GSO_UDP_L4;
 
 	netdev->hw_features |= netdev->features;
 	netdev->vlan_features |= netdev->features;
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index b78f8599bbe8..2a0560b7dd19 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -223,29 +223,44 @@ static void mpnic_tx_fill_hdrs(struct sk_buff *skb, struct mpnic_tx_hdrs *hdrs)
 		return;
 	}
 
-	hdrs->l4_type = MPNIC_TWD_L4_TYPE_TCP;
+	if (skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))
+		hdrs->l4_type = MPNIC_TWD_L4_TYPE_TCP;
+	else
+		hdrs->l4_type = MPNIC_TWD_L4_TYPE_UDP;
+
 	hdrs->i3len = skb_transport_offset(skb) - skb_network_offset(skb);
 	hdrs->l3_type = ip_hdr(skb)->version == 4 ?
 			MPNIC_TWD_L3_TYPE_IPV4 : MPNIC_TWD_L3_TYPE_IPV6;
 }
 
 static bool
-mpnic_tx_lso(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta)
+mpnic_tx_lso(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta,
+	     const struct mpnic_tx_hdrs *hdrs)
 {
 	struct skb_shared_info *shinfo;
 	unsigned int l4len, hdrlen;
-	struct tcphdr *tcph;
-	__be16 payload_len;
+	unsigned char *l4hdr;
 
 	if (skb_cow_head(skb, 0))
 		return true;
 
 	shinfo = skb_shinfo(skb);
+	l4hdr = skb_checksum_start(skb);
+
+	if (hdrs->l4_type == MPNIC_TWD_L4_TYPE_TCP) {
+		struct tcphdr *tcph = (struct tcphdr *)l4hdr;
+		__be16 payload_len;
 
-	tcph = (struct tcphdr *)skb_checksum_start(skb);
-	l4len = __tcp_hdrlen(tcph);
-	payload_len = cpu_to_be16(skb->len - skb_checksum_start_offset(skb));
-	csum_replace_by_diff(&tcph->check, (__force __wsum)payload_len);
+		l4len = __tcp_hdrlen(tcph);
+		payload_len = cpu_to_be16(skb->len -
+					  skb_checksum_start_offset(skb));
+		csum_replace_by_diff(&tcph->check, (__force __wsum)payload_len);
+	} else {
+		struct udphdr *udph = (struct udphdr *)l4hdr;
+
+		l4len = sizeof(*udph);
+		csum_replace_by_diff(&udph->check, (__force __wsum)udph->len);
+	}
 
 	*meta |= cpu_to_le64(FIELD_PREP(MPNIC_TWD_L4_HLEN, l4len / 4) |
 			     FIELD_PREP(MPNIC_TWD_MSS, shinfo->gso_size) |
@@ -276,7 +291,7 @@ mpnic_tx_offloads(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 					skb->csum_offset / 2));
 
 	if (skb_is_gso(skb)) {
-		if (mpnic_tx_lso(ring, skb, meta))
+		if (mpnic_tx_lso(ring, skb, meta, &hdrs))
 			return true;
 	} else {
 		*meta |= cpu_to_le64(MPNIC_TWD_FLAG_REQ_CSO);
@@ -369,7 +384,8 @@ netdev_features_t mpnic_features_check(struct sk_buff *skb,
 		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
 
 	if (skb_is_gso(skb) &&
-	    !FIELD_FIT(MPNIC_TWD_MSS, skb_shinfo(skb)->gso_size))
+	    (skb->len < MPNIC_MIN_FRAME_LEN ||
+	     !FIELD_FIT(MPNIC_TWD_MSS, skb_shinfo(skb)->gso_size)))
 		return features & ~NETIF_F_GSO_MASK;
 
 	return features;

-- 
2.52.0

