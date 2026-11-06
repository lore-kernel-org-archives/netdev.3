Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964649;
	b=d0OH4ZG8vAbLPeQfvDdpn0en3ILabUkPbKsSmv0kgdUcrPQh4RN/h9Z9kLud2kdniJbe
	 Lg9g4UOpUdpB3KNy+t41dWbdI+dnw8tikvGSO7w77L04Rb51Qabpwi6/7Y5rrUDNpvVoE
	 a/HUEKFgXLfvvx0JWg23cyTG6mjsOB+JzQcOaVnQiWHRrgxezovjFGpgXbh0226JalOI5
	 btF7W+jhtRrgjpyzPC/kdLKzlNdobqD3j8fsV3w0b7+RtRp3SJq14zG/wCRm0tCj5/GLP
	 ZxfL2KLB0KvaiW8WEpazeUEXr+Uxo0UiwbK8tkyIWa9YDMYNVoVXCl1r75ASU9PGzEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=YpArMDvxezA4L0Fqibs+TgJKi1PKuNMTHVIEso/M3YQ=;
	b=3oOeUkc5qL7DKev0KZnFezgDwMYMQ8D2DGUG6VucuhzbnYSaDfc0yCngUQ1BpuZX6N00
	 3PSmJOsRcE6t2wtawS6tViDREIpzto+D5+3yoTlFTywOpwSMBOAaJetqLz83CjCb81/+p
	 oSTW9Qrw2CxtZskeyrqa6pFHgv7sj5Psz9XFc/EHnVItvjp3UWxgk0ACVixUCQsQfIl8k
	 Kif4cPts+tYFHuzHpxehpyFvbiEksC1SjGnzVfIdrcKANWWiLjExPOsebHJnwc6DqzGKK
	 sUSiulBSzoByH5HJnAwZ1xA0nlNF2hBhD50Vo4EDhH3XZf+RT60lSw4avNqHQm6wsYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vErVLGop;
	arc=none smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E260A263F
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 11:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 350E260A263F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vErVLGop
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-679965fb848so506011d50.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 03:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793964647; x=1794569447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YpArMDvxezA4L0Fqibs+TgJKi1PKuNMTHVIEso/M3YQ=;
        b=vErVLGoprRsbcv7sQ3/jcfiTIh34AG+8FpB9nQRQzVJvU9KRJEee+MLIlOX0IdF1kx
         d7sm/9Ssp3ZtMJto4ZCd8ZPOyKQH7VVkpns/Gga4evawqtYPMXvX4ewXxl0hTCK3J5ph
         /Qt+qCZ8SmEqLcQ76MZ3xTRabi7T1fGH+mnW2PoseXL9VCNyk2BkOWMSjS5b2Yq1vNgV
         hIBUHzmhhN48QXgn3u0fqYm0NX5OGpS04940HbRmCgwQUdzvXASh78udIuL+VRjuO+M2
         JbkPMs3bq28C6Kwu54RYYxn5Sk/kjRJBfhc1Swn6/sjnXOKAWXr5LpAFMTymrht3lVYQ
         qgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793964647; x=1794569447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YpArMDvxezA4L0Fqibs+TgJKi1PKuNMTHVIEso/M3YQ=;
        b=IMT2LYj2GKzlnsOoX2UYIXDCCtR14VWOXQ3S6HVmwIH7oFhe5GqxMnOLSRfEO8fqfA
         dYn3MSfZOQnQJyLrZBvVzrOQvrlKhjSCq9nLTp+vlYgEPXKiFxHeuUU3bzxwWYFo2Wwa
         f8rFdeaCuKB3+cdfL30Nxqm1IPBnoqSgxCSOGP1cMZFHiaP+NZZasQ+LmE4qF+he6u4S
         8g1xluV/hAH/NhAA0wzd953gnAVxfPD3ADROnonRcMM8tJtdC5mzkvAU68BqJBBI71+Z
         AZbENFgtLkCMtlJnu8Vy8evPM9MZi4s9YOADlUCetJ7ehwDzVZTJRoZD5H6bPaSj0Ha9
         F20g==
X-Gm-Message-State: APuU4Z8x7t8w2yBtnD2iuh95Qjn4Ez91OkYUTllInEUVOreVyLnbZxhJ
	6ftEJ1LMAF3d4LULS5HXirGQrc/MXfVGvyizKfap2dvujLaz3l9SVSEW
X-Gm-Gg: AYBFou1ynpmCIuVmxcviAoLHKzjJmHMvBW/r7XetswYBrxjTO50x30SV32c9sRZ8ZRI
	WiMFexNRpvzu2PXOp9uPlVPr5lfphtOrjw1UPFAb8Z78G4+ZAX8m7LARgiR5XJVwvhkVxZK6jK0
	KnSgV8pJ5YdxF0avx7+IRaZNxyI4V4r/GyxW9zPhMRJdmJ6S+R2mKcaNfoH1wOKTGkASt6Nnkc4
	wP7aV5iu6qyjDYzNtO9s2u07v9NZswyEZFxDql+2XNVChzjElqwl0APnnMoFY0k7Tm3BSllDaiy
	zRvJpNrO24I+/Ake3ObdBLROUWmcMSPs5c3deM9U0VV4sf6p7zrmgHAlyWsn3G0iwu83/R8kzva
	zm6LhEd5I40Vb3EXtr+YSq71db463LfMBeqa4XpgBEn00/B47WhFvKEgv8h9iMQO3DpRQZRjjGf
	j57YfCRSjhsORU12rqDm9M3UqOwxMwsqjZOR1s8hOs3pNRJmzQZsJeJZ6N3gPDWFdR7la/XDeXy
	0jUtm8TzGFdbhuABaSrDzt4DnfuvI+ZXc/osVmG+j30gaFhxA5LaJmhS5bU4Mmzeg0jGxaFrpK6
	Ez3tlQI5GUu0e+7t8xrqOftNRQ==
X-Received: by 2002:a05:690e:12cf:b0:679:fa73:72f5 with SMTP id 956f58d0204a3-67c14405ed1mr1069137d50.43.1793964647063;
        Fri, 06 Nov 2026 03:30:47 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c13635f25sm1672486d50.23.2026.11.06.03.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:30:46 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 06 Nov 2026 03:30:10 -0800
Subject: [PATCH net-next 6/6] eth: mpnic: add GSO_PARTIAL for other tunnels
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
Message-Id: <20261106-mpnic-lso-v1-6-e943ff1493e4@gmail.com>
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

Tunnels that are not natively supported for segmentation can be
supported with GSO_PARTIAL. For GSO_PARTIAL, the driver uses L3 type
OTHER, which tells the device to suppress any updates to the l3 headers
of the packet. As a consequence of this, MANGLEID is required when the
inner l3 is ipv4, and for tunnels that have an outer l3 of ipv4, we need
to check if DF is set in mpnic_features_check_encap_gso(), because the
device will not edit the IDs of the wire packets.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h    |  1 +
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c |  9 +++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 21 ++++++++++++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
index 63282916eb13..03304e22d6ce 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
@@ -29,6 +29,7 @@ enum {
 #define MPNIC_TWD_FLAG_REQ_COMPLETION	DESC_BIT(37)
 #define MPNIC_TWD_L3_TYPE		DESC_GENMASK(42, 40)
 enum {
+	MPNIC_TWD_L3_TYPE_OTHER	= 0,
 	MPNIC_TWD_L3_TYPE_IPV4	= 1,
 	MPNIC_TWD_L3_TYPE_IPV6	= 2,
 	MPNIC_TWD_L3_TYPE_V6V6	= 3,
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
index e391ca6483e0..fc19793036df 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
@@ -325,7 +325,15 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
 	mpn->num_rx_queues = queues;
 	mpn->num_napi = queues;
 
+	netdev->gso_partial_features =
+		NETIF_F_GSO_GRE |
+		NETIF_F_GSO_GRE_CSUM |
+		NETIF_F_GSO_IPXIP4 |
+		NETIF_F_GSO_UDP_TUNNEL |
+		NETIF_F_GSO_UDP_TUNNEL_CSUM;
+
 	netdev->features |=
+		netdev->gso_partial_features |
 		NETIF_F_GSO_IPXIP6 |
 		NETIF_F_SG |
 		NETIF_F_HW_CSUM |
@@ -333,6 +341,7 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
 		NETIF_F_TSO |
 		NETIF_F_TSO_ECN |
 		NETIF_F_TSO6 |
+		NETIF_F_GSO_PARTIAL |
 		NETIF_F_GSO_UDP_L4;
 
 	netdev->hw_features |= netdev->features;
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index c349e54a3547..8b17acffe7e5 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -236,6 +236,9 @@ static void mpnic_tx_fill_hdrs(struct sk_buff *skb, struct mpnic_tx_hdrs *hdrs)
 		hdrs->i3len = skb_transport_offset(skb) - net_off;
 		hdrs->l3_type = ip_hdr(skb)->version == 4 ?
 				MPNIC_TWD_L3_TYPE_IPV4 : MPNIC_TWD_L3_TYPE_IPV6;
+	} else if (skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL) {
+		hdrs->i3len = skb_inner_transport_offset(skb) - net_off;
+		hdrs->l3_type = MPNIC_TWD_L3_TYPE_OTHER;
 	} else {
 		inner_off = skb_inner_network_offset(skb);
 		hdrs->o3len = inner_off - net_off;
@@ -395,11 +398,27 @@ static bool mpnic_ipxip6_gso_ok(struct sk_buff *skb)
 static netdev_features_t
 mpnic_features_check_encap_gso(struct sk_buff *skb, netdev_features_t features)
 {
+	struct iphdr *iph;
+
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_IPXIP6 &&
 	    mpnic_ipxip6_gso_ok(skb))
 		return features;
 
-	return features & ~NETIF_F_GSO_IPXIP6;
+	features &= ~NETIF_F_GSO_IPXIP6;
+
+	iph = ip_hdr(skb);
+	if (iph->version == 4 && !(iph->frag_off & htons(IP_DF)))
+		return features & ~NETIF_F_GSO_MASK;
+
+	/* HW can segment inner udp4 with fixed IDs, but there is no UDP
+	 * analog for MANGLEID, so defer to SW GSO.
+	 */
+	if (inner_ip_hdr(skb)->version == 4)
+		features &= ~NETIF_F_GSO_UDP_L4;
+	if (!(features & NETIF_F_TSO_MANGLEID))
+		features &= ~NETIF_F_TSO;
+
+	return features;
 }
 
 netdev_features_t mpnic_features_check(struct sk_buff *skb,

-- 
2.52.0

