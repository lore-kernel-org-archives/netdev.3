Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15219346774
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551786; cv=none; b=ixoUEaml2LNMw8V5LBK75W1mRQpTFzFq0AerRszNfJeIGrFkxiZ3GjGUOuwqmoMj1XkScTlQE1sWHz0douYoFbQOpmPhtHxt8+hNV93TB1a2iUweC9QMbRJ7cnx6JXQgCEleM1tb4msXeemz1cBJ+gWXAlCeJvDF/WW0kjW/kjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551786; c=relaxed/simple;
	bh=RQKkplf9sjmWDaJ5x5mGtb7d1P+SBbfhFRqyn88aqAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWgMIUPVYhggiLiYe94mg+Nkr2BSM88pXSDTVzQ5bJbWMgKB86APiWDkyTH5YfnBp1vapd37WqVIuDBi4VRdCjF25l5VA86SxznCRqRfmerTCpcEuzg9s4lqHOQ3g8Bhg6V7jdMmAvUg+zMU6honsaKxybvAlH7leuT5U4eB0Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=dZP+/o4q; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="dZP+/o4q"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381b831d535so2016983a91.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786551784; x=1787156584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lT2zzt0axhGJhfN8P9buCx7a1xNY6xzG+/ZekEGaBwg=;
        b=dZP+/o4qorVVdgxG9V7ZBQ/nS0qPKYqtimE3IIADnfyQF6kGqe8aETtbCRF3atnfGv
         aJSkdaRn5hi6xNOLD0nrQfhnIgMZPdIQCoiSOzusmWYMF7Rk3oxpWwUpetulbCc89hRe
         9QiY8VTcv9SOA9zLKV1+M4VvqA44EgxU57Zv96rNoDa6OosD5UM8kVPHRlEtF/bUHG3A
         +oiw5KoBq+AIH7t8Yk88jpojnWX+RG/HwOjhj4i1f3DsV7yorp1rtXnJPv/86qXOm2kP
         szRmZ851/K7jol4FrEejZPk2iLegur9rXSd66RZsqYIWWJnSy7VhS1jllcerTrnaSD1a
         jfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551784; x=1787156584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lT2zzt0axhGJhfN8P9buCx7a1xNY6xzG+/ZekEGaBwg=;
        b=S040yvixUMbmFoTn1G631c9tsnOz5r+2yM3WrAO7Nr0NT/ECBYDA35gba6C5wbt+EW
         5P+zP1IcbwAWRH1WR0G+kxQ3qNXLQOxsVsY8MOjoAthoKB7mkI1vAiMSVdPUgBW0HGzM
         p3NhgBP8NeZOLY5Cgv2EVhcf+Wm9ZEhtWGRVPKxMaiDW8ASqj1Rp/qz1Wji9gQZS3Xo5
         /5ZxTC7EesY4DGkkXT+GI2r9l2Me1/61E5LJ5fnafHi2FVX3ktx1ln7HsDQY6SCSFi/1
         sWJxMtBtsM5EhZkrsm2zq5FMsIwK+0ZY0yEHiyUtYkvtQHq3RYrfGpkp99rkEFyIpXHe
         ze1Q==
X-Forwarded-Encrypted: i=1; AHgh+RoaWibZ1PKXYiK0oSCQmM/7nOBCxTbpF632aRUprLpEXm96ovSP8/K2fZaHDLbbJzKzx9j0a5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxonIrcuh3G9jqxnZ6JgBUhaHnRyffJ/7gIwJfP7qtIOXql1DuI
	vIZgmKC+taKFz7hcuNEl50RXJARUyI2vbq4SDz//N3lssaMLtYKD81YRIVRzhAKmsN2e
X-Gm-Gg: AR+sD119aIYfmGGMa1+olAvDrkdAJO1hmaelXvK4Z1LkUMDGc8bRGJb/DQRJJiL17l0
	K2d4iuVlU7uZRf/lGjbCDEXHVrqcJBdbKZNcPb2e78FBVW9C35OaoxxIK329rAuCEpEk5WSefYr
	ZQLV0AqXbBY1I09BOgg5Kueo5TqpIRTL+6cnEE+5JYX1NdyBi1Z/gqbWfUbOnD+kDCzdBdWpme3
	vZ6suhsaFc4wrJvXFNwlRyGqKTbrGN4iClVxBeHutG9kAF2yvVs0SIQGi2sONTQ3pU5H+ObSHDA
	PU2oyDfoDLnKkiG6OT4OJ0hUU42gWaWw9uZnPoTRHLLSmMxZs7vIEaC7OOXEIMwbFgtB0kHJ5LY
	+9gpMrXqECh71n4jRwbErVmLy8mZcEPNMjz9AAlcGS3OGPaIn75kegdIVf2eBDHBOXENJAmvreT
	zH36rxKmHNDZQ2Eyj9j2QizDTYXAcI69OiaHAmnMl87ZHuIY9hDXgOlSvaA0fAzbLxcsysZD9LM
	+OU
X-Received: by 2002:a17:90b:1d02:b0:381:e74f:8a6a with SMTP id 98e67ed59e1d1-39301437940mr7571258a91.16.1786551784224;
        Wed, 12 Aug 2026 09:23:04 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392fe44ebecsm1466974a91.2.2026.08.12.09.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:23:03 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: idosch@nvidia.com,
	netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	atenart@kernel.org,
	yuehaibing@huawei.com,
	kuniyu@google.com,
	kees@kernel.org,
	kylebot@openai.com,
	thorsten.blum@linux.dev,
	maoyixie.tju@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v4 2/2] net: cap advertised IP tunnel headroom
Date: Thu, 13 Aug 2026 00:22:35 +0800
Message-ID: <ba04a1fd6bfae2377607fad5d8f80f7eb80fd4c4.1786542637.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1786542637.git.zhilinz@nebusec.ai>
References: <cover.1786542637.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IP tunnel devices derive their advertised needed_headroom from lower
output devices. A stack of user-created devices can make the derived
value larger than the 16-bit skb header offsets can represent. Once IP
output reserves it, skb head expansion can wrap those offsets.

The runtime transmit path already caps a growing needed_headroom at 512.
Apply the same cap when tunnel configuration publishes needed_headroom
derived from a lower output device.

Capping the advertised value is safe: IP tunnel transmit still expands
the skb when a packet needs more headroom. A nonsensical stacked
configuration can therefore incur an extra reallocation, but it cannot
publish an unbounded reservation to upper layers.

Fixes: 1a37e412a022 ("net: Use 16bits for *_headers fields of struct skbuff")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 include/net/ip_tunnels.h | 11 +++++++++--
 net/ipv4/ip_tunnel.c     |  2 +-
 net/ipv6/ip6_gre.c       |  7 +++++--
 net/ipv6/ip6_tunnel.c    |  7 +++++--
 net/ipv6/sit.c           |  2 +-
 5 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index d708b66e55cda..85e3455cea259 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -629,8 +629,7 @@ struct metadata_dst *iptunnel_metadata_reply(struct metadata_dst *md,
 int skb_tunnel_check_pmtu(struct sk_buff *skb, struct dst_entry *encap_dst,
 			  int headroom, bool reply);
 
-static inline void ip_tunnel_adj_headroom(struct net_device *dev,
-					  unsigned int headroom)
+static inline unsigned int ip_tunnel_limit_headroom(unsigned int headroom)
 {
 	/* we must cap headroom to some upperlimit, else pskb_expand_head
 	 * will overflow header offsets in skb_headers_offset_update().
@@ -640,6 +639,14 @@ static inline void ip_tunnel_adj_headroom(struct net_device *dev,
 	if (headroom > max_allowed)
 		headroom = max_allowed;
 
+	return headroom;
+}
+
+static inline void ip_tunnel_adj_headroom(struct net_device *dev,
+					  unsigned int headroom)
+{
+	headroom = ip_tunnel_limit_headroom(headroom);
+
 	if (headroom > READ_ONCE(dev->needed_headroom))
 		WRITE_ONCE(dev->needed_headroom, headroom);
 }
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 9d114bd575f92..5b1f180485d42 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -317,7 +317,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
 		mtu = min(tdev->mtu, IP_MAX_MTU);
 	}
 
-	dev->needed_headroom = t_hlen + hlen;
+	dev->needed_headroom = ip_tunnel_limit_headroom(t_hlen + hlen);
 	mtu -= t_hlen + (dev->type == ARPHRD_ETHER ? dev->hard_header_len : 0);
 
 	if (mtu < IPV4_MIN_MTU)
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 70c1710910203..200d0ba1a40e7 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1137,8 +1137,11 @@ static void ip6gre_tnl_link_config_route(struct ip6_tnl *t, int set_mtu,
 			return;
 
 		if (rt->dst.dev) {
-			dev->needed_headroom = rt->dst.dev->hard_header_len +
-					       t_hlen;
+			unsigned int headroom;
+
+			headroom = rt->dst.dev->hard_header_len + t_hlen;
+			headroom = ip_tunnel_limit_headroom(headroom);
+			dev->needed_headroom = headroom;
 
 			if (set_mtu) {
 				int mtu = rt->dst.dev->mtu - t_hlen;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index bf8e40af60b08..2c941acb081fa 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1522,8 +1522,11 @@ static void ip6_tnl_link_config(struct ip6_tnl *t)
 			tdev = __dev_get_by_index(t->net, p->link);
 
 		if (tdev) {
-			dev->needed_headroom = tdev->hard_header_len +
-				tdev->needed_headroom + t_hlen;
+			unsigned int headroom;
+
+			headroom = tdev->hard_header_len + tdev->needed_headroom;
+			headroom += t_hlen;
+			dev->needed_headroom = ip_tunnel_limit_headroom(headroom);
 			mtu = min_t(unsigned int, tdev->mtu, IP6_MAX_MTU);
 
 			mtu = mtu - t_hlen;
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index a38b24fb83842..19b7fa8d1a2a0 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1131,7 +1131,7 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
 		WRITE_ONCE(dev->mtu, mtu);
 		hlen = tdev->hard_header_len + tdev->needed_headroom;
 	}
-	dev->needed_headroom = t_hlen + hlen;
+	dev->needed_headroom = ip_tunnel_limit_headroom(t_hlen + hlen);
 }
 
 static void ipip6_tunnel_update(struct ip_tunnel *t,
-- 
2.43.0

