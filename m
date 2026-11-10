Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348420;
	b=J+t3fDA2IpXq9qeKkFjtFjfyyny8guGiuNETXKkQaDX8Y/43xC9CmLvQbjC1kTLMoyNa
	 8q1pZWXC7N6pA7CbMCwaQKS+GAo4ie1e5kZSK5ygz3ob6Xsb2ODyunZO9w2Cx1W+pzncF
	 zGzxVuy7IBUxPumAa/urMycQOVSnuGCU4cusIEKCtYwYNAHrxX8ngUBzbJm9XBnScf5yz
	 drtSMFFfdz8aMZxCe5aIr73Ro8HF3yWkKH9VJ7CW0o2B1E8HKXYYUA+R8lwq8ZBS21jSj
	 sqQlccazkG/caE+TvBEI01inz7prIeCwWb8sqmVCtpCDWqyfxvPgKu+ATXQDTnV4t/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=L1CME/PdqAtK6fTk+OjSyhi24vRJH8mOY9MTHCX4fQs=;
	b=5Rqb5vSIUxh644VEztU9NJkDTD+G0XwWMfsiWpOBPmFfFg6TLMpMF0PoIsCNWhtbbYFM
	 e2H7rc/gqjtHEzou1njaEfyjCxH2bi/NhACm63CurXWWyc2hxlHIclg/i0pJA6+KYwPwb
	 gOfi//tmxKGRLt+l4dLzgftYbEFu8sbwY3XzwghPgbrjmFC6g7nq0P37pLLN2eZhRycCW
	 v8Y6e9wjVpC8IGkZhFIbNNmmF2Z15JT5vfRjxSymwg3v3OtK9nNf0CIpf6s1OXuoSN016
	 yuPZJwBpKN5di7jIsrIydg5qejHxriSooVi26GAp7TxlDjP+L+mLrymhN4lNRFeKBWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tu7chxr9;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A247760A383B
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A247760A383B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tu7chxr9
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b0d126f631so26981187b3.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794348419; x=1794953219; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L1CME/PdqAtK6fTk+OjSyhi24vRJH8mOY9MTHCX4fQs=;
        b=tu7chxr9lTHSpeArUj0qxc48Q3LyVi/yMAQXybtp0NFwktdNshnDRyg7n7wTG0zJoQ
         bhIiH6ehNWKKhfnTuEOH1l5EfvkgY6akXzg9xIuTMzgPuYHBVQJU5YWWeWdUZ9uKP+qu
         gn5Nxl45ecVb1jNGLU9mO35veAd6qCRZILpjMwZJbZVoOprZ8RxpaiFGkRbHAJP+RVZj
         /fF8sMdbE6KXHjptFfjw7CYUDRroQGJ+jiVWzU5fmeFt17I7DYh53UqF9+ZID5YKUBKi
         lUUMXkzvdOy2mKHBO+xhQS43XoaY+5GmVm0sqIiR0yd08x6bh3KJNGuvCoz301ETNdu4
         2zWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794348419; x=1794953219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L1CME/PdqAtK6fTk+OjSyhi24vRJH8mOY9MTHCX4fQs=;
        b=XANBbXtqSIqtHuctvVV3UDS3dIqL6JTrNNo3K0cL6+RVtr+v4cRealJFfOh2e+EQN8
         SQXEPTcnoPKBPj26hczJC3AxlUjxx4H9MbMmOnb4nuy7+MK97H/1cc5+ca4WABxoUTNI
         jq9SdhUXptBEMKoJt1o2FHgNEBCB1NoXLTWIQxJ0Esui4V+L0E1WtO68ciYat9Pag+8j
         NRAdtSykLyW+hpz/rU2xwBTpHXH4/8EurNOUCgY2QbgqKRwaG1epKfuXJ1bZApW3kX7P
         UqE3GxQooGMrQKiLClg2Mj2XCOIScWbfha8Qyko0lhHAmSuHsPutsM9sRib/aAQLz1wm
         cjhA==
X-Gm-Message-State: APuU4Z/PuwvtohAi9okEWkri/iVMtWFnC0yiBQrPt0ZgR/WkdiKiRkS1
	L7BI6u+jaRXP0XtVNFT2vRiWuxNGa4uRF3rVnVghZWvcHdC56Y3Hxoju
X-Gm-Gg: AYBFou2nCco1xXa1ZtyFH4rOcjV5Chiih/KZ4mJ6QctHM6lL0uqgoIHxFOG2Zs1SFb5
	nqp9+mK+TMeUWpMYxdPeAwzrlu8n+OyAOWl9ONiLREh+TaN6DaI44oFEoesH3Ro8fJAru3yg/Mq
	6A9T++YD8dv4Y15WYaOxla4+1y55TOtBI3vUFh0L07eqO9H/Nv4YNO+K/kQCumT/X1Y1iOJgKo2
	mRq0bm77FXcAEWI8wg82Pp3hYbL/iEcG7w+EfLZw0ySC6amZyl/58rs2OYVqlRUhAzH4+JbIZUL
	i8QbcPOAb1CKbemkipkYLivaHgFS/Oi5kEHiw3XzeqdRZ5HEZpTi3jzbzWBk+GdAIJo31/6S9Uv
	/SLRQNJTDj7JqC/wdOi7JPoLGJ4uK+bwZ1+VcA+TsRfO7LajMlAHh/6AdQjBej3CcZALTDrcU4q
	mQHHj/pz3hNdxTe1AwU6JyaO0WbUCpumKJ2emOnW1VLU6iDs2t1XmTmydvudWo+vNMmKKGFO1D+
	U9unYCzNsRn/LEIX4qK1NRwalj/X6IJ+Ql1DfndXS6ScLanIIbSJuKbjpsGk2+x0vLGEb6VUIWn
	ZodIkciXiqJcEbiw0R5e7lufNao=
X-Received: by 2002:a05:690c:113:b0:8b1:e7c:cdcb with SMTP id 00721157ae682-8b3a7fe6a1amr5656197b3.23.1794348418497;
        Tue, 10 Nov 2026 14:06:58 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b39324c076sm30025117b3.5.2026.11.10.14.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:06:57 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 10 Nov 2026 14:06:39 -0800
Subject: [PATCH net-next v2 6/6] eth: mpnic: add GSO_PARTIAL for other
 tunnels
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
Message-Id: <20261110-mpnic-lso-v2-6-ccd37b051d08@gmail.com>
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

Tunnels that are not natively supported for segmentation can be
supported with GSO_PARTIAL. For GSO_PARTIAL, the driver uses L3 type
OTHER, which tells the device to suppress any updates to the l3 headers
of the packet. As a consequence of this, MANGLEID is required when the
inner l3 is ipv4, and for tunnels that have an outer l3 of ipv4, we need
to check if DF is set in mpnic_features_check_encap_gso(), because the
device will not edit the IDs of the wire packets.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
v2:
- derive the L3 header length from csum_start rather than
  inner_transport_header, matching mpnic_features_check() and
  mpnic_tx_lso()
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
index 032a5ee92a08..198aad631c65 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
@@ -322,7 +322,15 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
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
@@ -330,6 +338,7 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
 		NETIF_F_TSO |
 		NETIF_F_TSO_ECN |
 		NETIF_F_TSO6 |
+		NETIF_F_GSO_PARTIAL |
 		NETIF_F_GSO_UDP_L4;
 
 	netdev->hw_features |= netdev->features;
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index 839feb4716b6..af5e490c112d 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -236,6 +236,9 @@ static void mpnic_tx_fill_hdrs(struct sk_buff *skb, struct mpnic_tx_hdrs *hdrs)
 		hdrs->i3len = skb_transport_offset(skb) - net_off;
 		hdrs->l3_type = ip_hdr(skb)->version == 4 ?
 				MPNIC_TWD_L3_TYPE_IPV4 : MPNIC_TWD_L3_TYPE_IPV6;
+	} else if (skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL) {
+		hdrs->i3len = skb_checksum_start_offset(skb) - net_off;
+		hdrs->l3_type = MPNIC_TWD_L3_TYPE_OTHER;
 	} else {
 		inner_off = skb_inner_network_offset(skb);
 		hdrs->o3len = inner_off - net_off;
@@ -397,11 +400,27 @@ static bool mpnic_ipxip6_gso_ok(struct sk_buff *skb)
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

