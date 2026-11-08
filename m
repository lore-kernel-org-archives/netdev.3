Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141805;
	b=wUTlQfI15/0d6jhNd6XLNahFl4a+4Ysw8/OjxrwvhsUpP3KcKE/5z3y3m76vH5w3aFsB
	 iPWj39aXtxbrxffgJeRMrAx/i0rl/Jhi+n6NU6oJyzWCpb8V7XYKdf9ZWPhHezpvoReQh
	 5emjAhjP1enfIVOFL65yVwkaqC/aDIU77Er053bNInDvCLCkGjgeb3OmGnR082BqT+f4q
	 NW/tHsPOm+CKJvjwmwjX8KrZbRHxkdUoGGKIrFh1d8utYe/qbiqMk+tb/1146xW2RseLZ
	 H+61qTCMEqYsmmOG61ZwK+0bfDTArCLQuiE0gciZbPKSK5iXhv46OTXxShqWHcl6NBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141805;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=9t7OcQthK6OJKkUQxmAF7FdnpPZpAnVTEplL1mljYyU=;
	b=S6VgbNMItqmzOQTrJIN9oVP4DZirgxV5OTv4+WTd3+x3u2JZdBMXnScYW/E8ZpcKe1XF
	 lYTYjZP86aDS1dYGHssf4JQNVyq2qdNEJxGS/801ZYRC04nwa/N/DsMfezfZAH4DfYUAO
	 fgg4pwxocpk6wJ8tA+0me4GISDF3vld3MzBc+yCu3pBgsLBVZs1zSgdhixkgsIRHHhqdL
	 bC0CSAhYVnUFdh2k8jZ0lsTzqp2EVBTk4441xBQOhmBPYouz7+O5KC3B8GEhmXMieUJBG
	 5sLGMc26lXMvNkhZ7WiJMLzkfQMkv9t97c+XP8uzGb3xn1hAzvqgNJ07imcTQcZbVIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=Vso+Dq0L;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=03pS813d;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586A606A33B
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 12:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E586A606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=Vso+Dq0L;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=03pS813d
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id DE3F4EC00DB
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 07:43:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 08 Nov 2026 07:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1794141803;
	 x=1794228203; bh=9t7OcQthK6OJKkUQxmAF7FdnpPZpAnVTEplL1mljYyU=; b=
	Vso+Dq0LBNHKLrajBi000oxJxMF1/9Yaq2uJ3sQy1A+cC7MDX63oDXV4pVoFRz6P
	4LW1nBAVvyH/KOUYU4dR2Lzka9w5OvQT9un0voJ2Ml2mVbsAXIxFT7B5Bu3zYg7x
	y7SETYeD0Z5Fg960PLKoZYc/WCNL7S3Xy7H2gBd9zZO16nLAuoqWwBcKwb04RAnk
	K0PHsDchve4zbEKuZzesUmNuGykpJBK0msExc0sGYbg6acIJCvICIgwtA9b/9WwA
	+dyHgsLWREHg6XX10riSsRy2CtgdANNGw+I+pRK+au8KVVEV2G9XCEo5KoLII56Y
	Jbe8lqjU+qwj2yp82iopBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794141803; x=
	1794228203; bh=9t7OcQthK6OJKkUQxmAF7FdnpPZpAnVTEplL1mljYyU=; b=0
	3pS813dCM4QU3IYnIw1WtmMal1mhi6G2Vak7EbmIOJbTelTf3PqLwpaVm5binyQT
	oEoV6RxJAHKExOipTgx7w5oh/VFu/T1dfQvJhfvDZ5DKP4uFRLlxaCLGpTeEMm2R
	2I6X5DXi0Vi7FIV2D4UDD0c782qq6LiEmDUBtUH/5qHzfp1Ipz8T7qWtbz4QT4o4
	HIqEP0vQHBmqaqyXouPLk6AlNf5CQrdoK7F2zPvt7aKaOC3QgpXNEscx3aqu0XSf
	QX/oyiyT6V1agHtxABh3TXKFZG5h/MD5HPLC5fV/ZANsEk0yg4/DI/qw3EsqheT2
	2/vmD8cmSjZvWumLQioMA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794141803; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=; rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:v/Rq+DYMEtAmqt2E/8xNQr11VbXJVDYNO4VAthxrKlt6ckT
	+cMIZB7PumP/eWp8aqbIZ0YB6NJUjNyy9wwhge/sjDI7fdPhZJmgFP2y00b3uIL8
	F2j92wSYsXgiygXJhoc+nNiuQX7kcPcZjUn4UCazj+4Fjvn+GvJbYKH/c882DwmC
	z/IeN6u43kq6Ot1OTi5u/6swbq9ZnVPlANIgM5FioGzfDOaowh1FcVfWGF2vsZwe
	sDcuira7/QUWO587msci0KMJJigINmvSmY5x+Hqi3GSo0U0cW47JeTPJrGpfD2Gl
	tXpLwH/M1nLAG7saGlS4Q2Rins056mA4A75w6jA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:AZea8D71Udc2e4wFncQRxvRrx+SqjaAkqxRhusZLRVs=:AvovO4GVKB8/t2m/jiK9YeuIrX48txv0/Nme4NV9Uqs=;
X-ME-Sender: <xms:a27wajhQifqnexaeZBHUibOI2lCEKgL_PqCii-mqEPgHf5VxphOPBQ>
    <xme:a27wamDvK2ew68FXUc7MhYbamM1MFRy-3trw92DQDRiVHIWEZgJ_lcq2Hmv84hwqa
    9Pgq9hC7s0ey1Rt0VXzQXNAbcow8-Dij9o_IKqj4cv8QZuKTxR1kaaf>
X-ME-Received: <xmr:a27wat6UBeckFgNZUIEU23G3XsZy6LfQLtB3nRBPDP4V3E8l3tO5fwsPY7bcJRVhpN4242Se6kj1XRLDbvVbKJ5VoshX_EN7wVffwQ>
X-ME-Proxy-Cause: dmFkZTFvpcRF2U5Eqq2oGivzePSyI52xcgAkdznKLWpxb3H76ey6ZgBIPA4VdqYaDnscX5
    rw/WiyxacwJRwb4wAJziiEoDZPJqF7VpDXRzryvYOE97JvMlI6gHJJwukuX5E3aGQfUrhP
    zcspf6iBJbC2JfcDbk0W2z6dMhWrS9LB/KyyX0W304P6wlYIn2Gs96QFYrkqheZA3EJsQH
    HruypYwUGAt7hJLh+hZo8jHU9U40FuNrAvm1F/O5S6gO11QtROXNs/qiYLSb0VNyhdWq3Y
    ldj+KznwwpIPuZF4KvrXrj5qmTsj0TUMEsb+cZ+X7RL6ZwAeAY1//VENmnWPj8YQY02Icd
    mc/bOb4oO3+eHQ64LQjP3Kx5hBYqczBaQ812iQjQB/hlkwQ9ChOkvEXLe7mOZpV1+K/hiN
    cE6oX5dOXDDFZYvhy20tlEAhrK1Eaz5Og8dkeFuSF5mbC+wesTZb49DRxZdAHg+DJBwaOF
    4hLMsgUE+bNFUVOE2VkLPYYKVXMBx+s+fd7JsfEW05q9SiqpyPlJ5y0Pjoa850IlDfeJQy
    j4EWtYEYh8R1syPS13ZTo1l3WfJFah1Xoqyhqv2wzVFrpae/1d5FZhJaMQ8mplcoqtc4cI
    PMkQHYeUcDh4K2JuTOqhLKldrwKq6JV8GCFXZNpm+1aBlo3RFqZ95mJJqU0Q
X-ME-Proxy: <xmx:a27wajHnOeSNwujTZq0CB118UtQYke5AKUh5BvpmwwW3uIV8p2Ndug>
    <xmx:a27wagA4BFshzjbUHvrFHCIrKuz0jFJzy6OX52dCSJDIHG9zUI1jQg>
    <xmx:a27wagxelI18bojR414T44ld6LWmTHOn0QLSmqr07jnvifXz0xtlbQ>
    <xmx:a27was4WCaeeYVHlSLRWqhgJ7VTrbdVcd8cI-KqxbfTD2xPBpUS5FQ>
    <xmx:a27wateyUz2ZiufDLxE_C4houeQ21Av4MK4kgtPe0Bzr0GOupX9f_yZS>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 07:43:23 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Sun, 08 Nov 2026 13:42:54 +0100
Subject: [PATCH v2 1/2] net: atlantic: AQC113: Fix
 hw_atl2_hw_acket_filter_set for L2 filter base index > 0
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
Message-Id: <20261108-net-atlantic-aq113-apple-l2-filter-slots-v2-1-0b988d031c78@jannau.net>
References: <20261108-net-atlantic-aq113-apple-l2-filter-slots-v2-0-0b988d031c78@jannau.net>
In-Reply-To: <20261108-net-atlantic-aq113-apple-l2-filter-slots-v2-0-0b988d031c78@jannau.net>
To: Sukhdeep Singh <sukhdeeps@marvell.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2845; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=AvovO4GVKB8/t2m/jiK9YeuIrX48txv0/Nme4NV9Uqs=;
 b=kA0DAAoWoRs8240vZWYByyZiAGrwbmai/h23AOXcMsXc31/FlMQfChfgUyMWJ2Q2+pbkbvq4+
 Ih1BAAWCgAdFiEEYivpiACrfCFcfeBWoRs8240vZWYFAmrwbmYACgkQoRs8240vZWZAdAD9F5NJ
 daLj2qyV2kAqncgb+mfHi75FqJ72RiIheL7XSiYA/3PLqR2sI/EjfbK5BkuWGp9Dx/YjWfNWDfH
 YwZbRuuMC
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

hw_atl2_hw_packet_filter_set() wraps hw_atl_b0_hw_packet_filter_set()
which has no concept of `l2_filters_base_index` and enables/disables
filters from `HW_ATL_B0_MAC_MIN` (1) to `HW_ATL_B0_MAC_MAX` (33). After
commit 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART, L2 filter
slot, MAC address") this may result in disabling filters set in
hw_atl2.c including the l2 filter for the MAC address. This results in
broken networking on Apple silicon systems with AQC113. The firmware in
this systems report `l2_filters_base_index = 9`.
Copy the formerly wrapped `hw_atl_b0_hw_packet_filter_set()` to handle
this additional complexity.

Fixes: 6c1ca112a6e4 ("net: atlantic: fix AQC113 HW init: ART, L2 filter slot, MAC address")
Cc: stable@vger.kernel.org
Signed-off-by: Janne Grunau <j@jannau.net>
---
 .../ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c   | 35 +++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index 25dd7150aaaf..8d7a489aa5de 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -759,9 +759,42 @@ static int hw_atl2_hw_ring_tx_init(struct aq_hw_s *self,
 static int hw_atl2_hw_packet_filter_set(struct aq_hw_s *self,
 					unsigned int packet_filter)
 {
+	struct aq_nic_cfg_s *cfg = self->aq_nic_cfg;
+	struct hw_atl2_priv *priv = self->priv;
+	u32 base_location = priv->l2_filters_base_index + 1;
+	unsigned int num_l2_filters = min_t(unsigned int, HW_ATL2_MAC_MAX,
+					    priv->l2_filter_count);
+	unsigned int i = 0U;
+	u32 vlan_promisc;
+	u32 l2_promisc;
+
 	hw_atl2_hw_new_rx_filter_promisc(self, IS_FILTER_ENABLED(IFF_PROMISC));
 
-	return hw_atl_b0_hw_packet_filter_set(self, packet_filter);
+	l2_promisc = IS_FILTER_ENABLED(IFF_PROMISC) ||
+		     !!(cfg->priv_flags & BIT(AQ_HW_LOOPBACK_DMA_NET));
+	vlan_promisc = l2_promisc || cfg->is_vlan_force_promisc;
+
+	hw_atl_rpfl2promiscuous_mode_en_set(self, l2_promisc);
+
+	hw_atl_rpf_vlan_prom_mode_en_set(self, vlan_promisc);
+
+	hw_atl_rpfl2multicast_flr_en_set(self,
+					 IS_FILTER_ENABLED(IFF_ALLMULTI) &&
+					 IS_FILTER_ENABLED(IFF_MULTICAST), 0);
+
+	hw_atl_rpfl2_accept_all_mc_packets_set(self,
+					       IS_FILTER_ENABLED(IFF_ALLMULTI) &&
+					       IS_FILTER_ENABLED(IFF_MULTICAST));
+
+	hw_atl_rpfl2broadcast_en_set(self, IS_FILTER_ENABLED(IFF_BROADCAST));
+
+	for (i = HW_ATL2_MAC_MIN; i < num_l2_filters; ++i)
+		hw_atl_rpfl2_uc_flr_en_set(self,
+					   (cfg->is_mc_list_enabled &&
+					    (i <= cfg->mc_list_count)) ?
+					   1U : 0U, base_location + i);
+
+	return aq_hw_err_from_flags(self);
 }
 
 #undef IS_FILTER_ENABLED

-- 
2.56.0

