Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964646;
	b=Vj2WQEqJR2z5lUe3MT6CnEI3NCjM45OZvte5jpS7uxRjUR78RMPlP5fWDcYq0aA6BvZk
	 nIsfIl5Cg3qBRYiiHqhG0PP5a2028CM/o+t4VRSPWzBMz3ACa3pex/IGbU9kX6/TdrKd8
	 7Uy+VgdXBBQR+KG0v9VsiYZuJJVNMv6pq/B16w3nlIhzWDpW2pa0rXDqlatrU+AQeGSho
	 I8CG7kuTJIpdDjfWpWCqeCV+Qd2z6UVSHRE3V7ugsdsQYfqum3P45USCiIMuCk/eCu9MI
	 /IKkKqdH9b9YANNIPJTvI1d3v0269ju4TuOTzwBLBFns/Zi2GgTMk1a6kQAuDLW7cXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=giUdlGxportxV9oD0Y5dlTK4q5X4A50Fnd9TORaDW/g=;
	b=tp+zRUtlZHdocg6lihXLDOaabvUB3k9h7sQ7eEghKTanGr/b0ry7PG5SiWpWQc7//0Jq
	 c+EeMc/0wqcjNSsAm4P0ObXs24t2m2638qsJrOjJXcJSK66GssagE40aaXNDG297CQx+y
	 iMmxlyh/v/LUWkkrg+jBTkr4+vlsWfLnh0uQeQJ/IvrG9Mh6wC2nZqXb+bhu9p5pIhiRl
	 ocuRGRvP1skSOh6ZDx3tmhQmOvgwB6sXihBaeQmqshIeesYj0OiydoMog0dckenFFz0kF
	 4Ap7TMVgDlZ9HBoyIrC0Zr9r8JfBEqnH1PWkfcEA7NWogWBqwveV/tdD+bewlHn2xpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kP3kRWMw;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB6E60A261A
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 11:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBB6E60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kP3kRWMw
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b2d14968c9so4058037b3.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 03:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793964645; x=1794569445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=giUdlGxportxV9oD0Y5dlTK4q5X4A50Fnd9TORaDW/g=;
        b=kP3kRWMwkwMKregIs4hcvbfrWQictg/hBuCZqSgUbpIIq6Jr/pfivmybU53tqn9Pmt
         VhEN1wmqdyfCiJKRWG7V4GKmlJZBLojGMfRjp60fBk0kuQwx8DU+xt8yK8N7tUwVgrG7
         BR72Asai6KATZSsImGgMtwlETRvnn15duAI0Uu+k1Jl+KjrvMWOXKLZLlapX8OWfzv9G
         nTxuyPR3v4qtfNPYL5YOEf/5W/5dfFfulWqmiWHnAc/+MdIjKbl1wa3ujMNuqiE4DgBq
         ny/wn+4Pxvt2rN9yoL4c1ZnQh4z0UC+Yl/q9jWJL0fTK8jVBx1hAoR4IOGI8jzJUjd3y
         ND4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793964645; x=1794569445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=giUdlGxportxV9oD0Y5dlTK4q5X4A50Fnd9TORaDW/g=;
        b=l9GwFhE8Ft3q3fFgHMQrHMsXVjlY041UIv6iMNDE+7eaWd+6Ee2xnZu3Q7MSbfSOUp
         ZfyOERLW9cvR5yGF8LYdzH+khW3i1VKnTYShG8U2DSM8/3BjIRNTlUuXNPgwGombNgIM
         rzO4RfAqUFoBnvA99bJ26pGyRhddkecZR91EPQJe6V+QFUc2qv3Ej13k9zzcV9iCcpO9
         Yu3bkNLh1By7bq930Io/T43RpGiOVbf+RC96p7jye8jW4h3D0s8GPdPvzfr7h+5+otdU
         jDg8pCFypsOMgTc53HcAFxWfTLkhGrqM6S/cLxJdNO1pJfBTYQSAbvLruhxzzZq+oVE0
         6vPA==
X-Gm-Message-State: APuU4Z/X5X3X9+jOsxkGtmEjbuhTLf8oicC6JRGDCsI0LdZBUIocdtgc
	sF1jlfOt9kclBSECpw2MPJECK4OkV7VZgL5IaZPbSMHeTdIKOMSdxWk1JNAr3BhZ
X-Gm-Gg: AYBFou2Zc74nXuXdjZFxTJa567x/A01K6Xu8PfVP1S5rFx14w7i3hie2fcErWzi8kHU
	7+94ED5gbNiVdsl17OvOVDFsUs6eA9euDDQxjtq4uDBWJhQyauECr0ZWlV/28wqDLVc17AuJzEd
	RYzL2MaMaZqdRKBmbIFJQPkHmf3xL63Xq2TTyCLm33sx9olkxGaub3U+8PMlhanCIiKs0I3PaBX
	MtcEECsyo3MIcLyRWJ0OXeJHKXTeKp5QjDomYqMGiU94WUzxz2bszPgVWK0W9YJjkB2X1V81M1H
	R6iBrSNTEzSfN6Su1a5kmMo8Ay2NKdc+SaZXwBTMTpITf5FnBNwFd/Ot2d6p2U5o+mxrglX8zuq
	WpFpXdETDO5KtjzStj7uSWXj1cDCE+3bF5x14dQGll8ViVgsFfXRLzp3Enw0MXnBi5LsnUZswmX
	jXwftEtYVlJlRNyFGPOoV+t+kbHCcIoopwibWMwpCqkrOXglt7ljuxEXAqaWZq6+CrziRmN7PaD
	YRV2kx+rjsFWWc7JomDtIf67foaHBxxfgFs0GkK2zn0chq9lhzkJIgynhDtLNl8otXdc9vQlpIa
	m3wrdAGj3O1YVTkzSvb4YQ0piA==
X-Received: by 2002:a05:690c:3489:b0:8b0:a1d3:3823 with SMTP id 00721157ae682-8b3419692camr10812927b3.24.1793964644492;
        Fri, 06 Nov 2026 03:30:44 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f8221absm16589777b3.27.2026.11.06.03.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:30:44 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 06 Nov 2026 03:30:09 -0800
Subject: [PATCH net-next 5/6] eth: mpnic: IPv4 and IPv6 in IPv6 tunnel
 segmentation
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
Message-Id: <20261106-mpnic-lso-v1-5-e943ff1493e4@gmail.com>
References: <20261106-mpnic-lso-v1-0-e943ff1493e4@gmail.com>
In-Reply-To: <20261106-mpnic-lso-v1-0-e943ff1493e4@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, 
 Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0

The device can fully segment 4-in-6 and 6-in-6 packet types. Add
mpnic_features_check_encap_gso() to check the skb for some additional
constraints, such as ip6 non-atomic frag ext header.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h    |  3 ++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c |  2 ++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 50 +++++++++++++++++++++++---
 3 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
index 2cd627d62bf5..63282916eb13 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
@@ -14,6 +14,7 @@
 
 /* Transmit Work Descriptor Format */
 #define MPNIC_TWD_L2_HLEN		DESC_GENMASK(5, 0)
+#define MPNIC_TWD_L3_OHLEN		DESC_GENMASK(15, 8)
 #define MPNIC_TWD_L3_IHLEN		DESC_GENMASK(23, 16)
 #define MPNIC_TWD_CSUM_OFFSET		DESC_GENMASK(27, 24)
 #define MPNIC_TWD_L4_HLEN		DESC_GENMASK(31, 28)
@@ -30,6 +31,8 @@ enum {
 enum {
 	MPNIC_TWD_L3_TYPE_IPV4	= 1,
 	MPNIC_TWD_L3_TYPE_IPV6	= 2,
+	MPNIC_TWD_L3_TYPE_V6V6	= 3,
+	MPNIC_TWD_L3_TYPE_V6V4	= 4,
 };
 
 #define MPNIC_TWD_FLAG_DEST_MAC		DESC_BIT(43)
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
index 83be45031a30..e391ca6483e0 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
@@ -326,6 +326,7 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
 	mpn->num_napi = queues;
 
 	netdev->features |=
+		NETIF_F_GSO_IPXIP6 |
 		NETIF_F_SG |
 		NETIF_F_HW_CSUM |
 		NETIF_F_RXCSUM |
@@ -336,6 +337,7 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
 
 	netdev->hw_features |= netdev->features;
 	netdev->vlan_features |= netdev->features;
+	netdev->hw_enc_features |= netdev->features;
 
 	netdev->min_mtu = IPV6_MIN_MTU;
 	netdev->max_mtu = MPNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index 9dd61b6d374c..c349e54a3547 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -22,6 +22,7 @@ struct mpnic_xmit_cb {
 
 struct mpnic_tx_hdrs {
 	unsigned int i3len;
+	unsigned int o3len;
 	unsigned int l3_type;
 	unsigned int l4_type;
 };
@@ -218,6 +219,9 @@ mpnic_tx_map(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 
 static void mpnic_tx_fill_hdrs(struct sk_buff *skb, struct mpnic_tx_hdrs *hdrs)
 {
+	unsigned int net_off = skb_network_offset(skb);
+	unsigned int inner_off;
+
 	if (!skb_is_gso(skb)) {
 		hdrs->i3len = skb_checksum_start(skb) - skb_network_header(skb);
 		return;
@@ -228,9 +232,17 @@ static void mpnic_tx_fill_hdrs(struct sk_buff *skb, struct mpnic_tx_hdrs *hdrs)
 	else
 		hdrs->l4_type = MPNIC_TWD_L4_TYPE_UDP;
 
-	hdrs->i3len = skb_transport_offset(skb) - skb_network_offset(skb);
-	hdrs->l3_type = ip_hdr(skb)->version == 4 ?
-			MPNIC_TWD_L3_TYPE_IPV4 : MPNIC_TWD_L3_TYPE_IPV6;
+	if (!skb->encapsulation) {
+		hdrs->i3len = skb_transport_offset(skb) - net_off;
+		hdrs->l3_type = ip_hdr(skb)->version == 4 ?
+				MPNIC_TWD_L3_TYPE_IPV4 : MPNIC_TWD_L3_TYPE_IPV6;
+	} else {
+		inner_off = skb_inner_network_offset(skb);
+		hdrs->o3len = inner_off - net_off;
+		hdrs->i3len = skb_inner_transport_offset(skb) - inner_off;
+		hdrs->l3_type = inner_ip_hdr(skb)->version == 4 ?
+				MPNIC_TWD_L3_TYPE_V6V4 : MPNIC_TWD_L3_TYPE_V6V6;
+	}
 }
 
 static bool
@@ -305,6 +317,7 @@ mpnic_tx_offloads(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta)
 	*meta |= cpu_to_le64(FIELD_PREP(MPNIC_TWD_L2_HLEN,
 					skb_mac_header_len(skb) / 2) |
 			     FIELD_PREP(MPNIC_TWD_L3_IHLEN, hdrs.i3len / 2) |
+			     FIELD_PREP(MPNIC_TWD_L3_OHLEN, hdrs.o3len / 2) |
 			     FIELD_PREP(MPNIC_TWD_L3_TYPE, hdrs.l3_type) |
 			     FIELD_PREP(MPNIC_TWD_L4_TYPE, hdrs.l4_type));
 
@@ -363,6 +376,32 @@ netdev_tx_t mpnic_xmit_frame(struct sk_buff *skb, struct net_device *dev)
 	return mpnic_xmit_frame_ring(skb, mpn->tx[skb_get_queue_mapping(skb)]);
 }
 
+static bool mpnic_ipxip6_gso_ok(struct sk_buff *skb)
+{
+	struct ipv6hdr *ip6h;
+	__be16 frag_off;
+	u8 nexthdr;
+	int start;
+
+	ip6h = ipv6_hdr(skb);
+	nexthdr = ip6h->nexthdr;
+	start = skb_network_offset(skb) + sizeof(*ip6h);
+	start = ipv6_skip_exthdr(skb, start, &nexthdr, &frag_off);
+
+	return !frag_off && start == skb_inner_network_offset(skb) &&
+	       (nexthdr == IPPROTO_IPV6 || nexthdr == IPPROTO_IPIP);
+}
+
+static netdev_features_t
+mpnic_features_check_encap_gso(struct sk_buff *skb, netdev_features_t features)
+{
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_IPXIP6 &&
+	    mpnic_ipxip6_gso_ok(skb))
+		return features;
+
+	return features & ~NETIF_F_GSO_IPXIP6;
+}
+
 netdev_features_t mpnic_features_check(struct sk_buff *skb,
 				       struct net_device *dev,
 				       netdev_features_t features)
@@ -388,7 +427,10 @@ netdev_features_t mpnic_features_check(struct sk_buff *skb,
 	    !FIELD_FIT(MPNIC_TWD_MSS, skb_shinfo(skb)->gso_size))
 		return features & ~NETIF_F_GSO_MASK;
 
-	return features;
+	if (!skb->encapsulation || !skb_is_gso(skb))
+		return features;
+
+	return mpnic_features_check_encap_gso(skb, features);
 }
 
 static void mpnic_clean_twq0(struct mpnic_napi_vector *nv, int napi_budget,

-- 
2.52.0

