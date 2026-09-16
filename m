Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B351992D
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569457; cv=none; b=hcfQu6oRFZt5igNzmsoAx35wJp1182h1BYVF5P6axHMlkgrNsDH8yZW4w5GxyiO4JSgGIp35wsRpWTsTchKhDMS/SNl4SpysoWpjpSo2YdrgZ0vWshPJCtlGxWY2MhP07UeUZSa2yibiHz9YtoLMSviBFIy6V4jou2rmiZF1Qrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569457; c=relaxed/simple;
	bh=lxp4NJkYO7E48ja5AHkMY7+Cyu/qdRcqrWCWF1iYoYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CT2WPY9teYVxQxdgPSFMqrfaOrBThM9YAMTuRfl4SHbUgIaqt/r2jOyFbjhc3L7FXEuoJIHY7zSoPinOYu6NplRj1loDHPrY7YR/Og1l6CydrHF9po48HFPwU4kdj4xN8ULE8UyNmi6J5ef7/7ZCdyiK98Ts45Ci3CzvKCyYso0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6N83kz+; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6N83kz+"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5919af2eeso7866811fa.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 07:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789569452; x=1790174252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7+2xUfpNk80vOApeT5HP7l0i/3VJUg0mGr1lclpVbwY=;
        b=M6N83kz+t1eJoUlU6Ks33mso4Gz2zS3UHXekz2EjI7hsHL5Gc1PnutXWXo6WSEsJtM
         7fIP5lNqZ8L3QIoD2Ivt94hudAc0HlUTNrSp7ZWe1V05Tsm0UoY6c6sAQXiG4bvyygcG
         1cumdXY1s2KdrSe3c5Qvea+gI7dq7s7LA0OZRl1FczXlQxCelwJQsvFVevv29DYRGdZ8
         hqCNDOumKjPP8BGcvzdKGDeNXOhoqnaBfDiPyjuDbMV6lDTnsUGtrzaCkov1C0211Ycr
         sbfzgfx/F4uD/bGOjQM+Eaq/prQX0Ize2IP5te2T5mXzy0U0cEaqmqN1z/7B5CUJOIDF
         eBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789569452; x=1790174252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7+2xUfpNk80vOApeT5HP7l0i/3VJUg0mGr1lclpVbwY=;
        b=dky7p4NKCw2Je7KtYi93nyzvH206bo7fhZe41q1Vgv8BU/YCTAEcTWacE0c+Z9NQKG
         fuXZYZ1l+pKZtKxYYkkMdlLbO6ZInisvcjdb3r2P6YXLTtHRpArU+p5HdxjFk46sbQL0
         xM1koRhAEU83IFZ/WKQww0TxhnkyMOwUbSWx8fJPvo0E7ixjHiXdujHUdDpWJqq7DkY7
         VA+ItN4CVFYElY7UjNyxNJtpLNQt3uRXGXsMdjk660ppol8bq2ucZpC57J0lHZyTm3sG
         xR2nmtRUJsHrYQhw3Hoge8wdsQnt0yELmraa/XbS90osmPbq5/PqPFf6H1L9b4zOWWfx
         S9VA==
X-Gm-Message-State: AFuF++kfeaMAofo6lZbgQtcyIZ04eiJwgWNPQbY6LaO/I4e4Tu+0WMqu
	4u5Na6Zur11RQyjK3x16NcFjta9OGpLj7OXnDJlffllbgSKW3HKdvhZa8/d+z0TOhdc=
X-Gm-Gg: AYBFou0fFe08qAdkjGNn7lPPKNlC56yhDKyU1LVLqqXinvtFBRp4dIyls93C/gaPvgT
	jf7rY/WBOaEPwydMnSRRgC65YUHIFPAa1AacpX0waMWyKrfEqQMkuFdmfbuk55f8QR0I4rNRfus
	oamNtT8IAbKio2yPt6NUTaNfSQCXYeA9NZZYNI38TGcqKeZvLZorX+fMcYH9n4fGOJgkSZaal/C
	U0nR2NgrJgiT6mD8XyGmKuKXdfLUjgRhtO7LKR4OQDE7GOm+hw2eNvAAwi8OYXvcEZ/9kMG3IIa
	b10kLe8SSbPhoIxHm8E0a8Rr1XKjPCnPIawD7KZQjA/OFvexyeqn2F07+o9dK9Y1Tf1oGuNZrzn
	PNpg7dIg58cbjwNO4ACS4dc/29kVx3/NMxcBUJuDgf+2E1m9OetvISropvH7ap9th6y2IH1BNW2
	pKvZX6vusSqoHbovKNxmcCMDegoweo1zbK/mxYv4dWvYykNGR/GFIS8GWYodrLg154Mx3JFWBsg
	UPkLTwMjgViAU+iKCz1Frhhq8yT9/4kYqAouwkYh8IdJoLFrFUo1tiXUWC5n9A+7g==
X-Received: by 2002:a05:6512:3a93:b0:5b6:1a7c:aa1f with SMTP id 2adb3069b0e04-5b8b6655de0mr834514e87.55.1789569451985;
        Wed, 16 Sep 2026 07:37:31 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([95.139.134.117])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57eb908sm955658e87.79.2026.09.16.07.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 07:37:31 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 6/9] ip_tunnel: add drop reasons to the transmit path
Date: Wed, 16 Sep 2026 17:37:14 +0300
Message-ID: <20260916143717.1875082-7-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916143717.1875082-1-littlesmilingcloud@gmail.com>
References: <20260916143717.1875082-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_tunnel_xmit() and ip_md_tunnel_xmit() encapsulate packets that the
tunnel forwards, and every failure on that path ends in the same plain
kfree_skb().  The device counters separate them a little, but they are
too coarse to act on: tx_errors alone covers an encapsulation failure, a
routing failure, a lookup loop and a packet that is simply too big.

The last one deserves attention.  tnl_update_pmtu() returns -E2BIG for a
packet larger than the path MTU, an IPv4 one with the DF bit set or any
IPv6 one, after it has already sent the ICMP error back to the sender.
That is path MTU discovery working as intended, yet it lands in
tx_errors next to genuine failures, so a MTU black hole cannot be told
from a broken route by looking at the counters.

No new reason is needed for most of it:

 - SKB_DROP_REASON_PKT_TOO_BIG for the case above,
 - SKB_DROP_REASON_IP_OUTNOROUTES when no route is found,
 - SKB_DROP_REASON_RECURSION_LIMIT when the route points back at the
   tunnel device itself, which is the "dead loop on virtual device" that
   reason describes,
 - SKB_DROP_REASON_NOMEM when the headroom cannot be expanded,
 - SKB_DROP_REASON_NEIGH_CREATEFAIL when the NBMA neighbour lookup
   fails, SKB_DROP_REASON_NO_TX_TARGET when no destination can be
   derived at all, and SKB_DROP_REASON_UNHANDLED_PROTO for a payload
   that is neither IPv4 nor IPv6,
 - SKB_DROP_REASON_TUNNEL_TXINFO, which already documents a packet
   reaching an external mode device without metadata, for the
   collect_md path.

Only the encapsulation failure has no fitting reason, so add
SKB_DROP_REASON_TNL_ENCAP for it.

Drop reasons on transmit are not new: vxlan already reports several of
them from its xmit path, and ip_tunnel_core.c reports
SKB_DROP_REASON_RECURSION_LIMIT.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/dropreason-core.h |  7 ++++++
 net/ipv4/ip_tunnel.c          | 41 ++++++++++++++++++++++++++++-------
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index fa8bd552122f..30378a0d2272 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -134,6 +134,7 @@
 	FN(GRE_INVALID_HDR)		\
 	FN(GRE_CSUM)			\
 	FN(GRE_TUNNEL_NOT_FOUND)	\
+	FN(TNL_ENCAP)			\
 	FNe(MAX)
 
 /**
@@ -643,6 +644,12 @@ enum skb_drop_reason {
 	 * endpoints and the key the packet carries.
 	 */
 	SKB_DROP_REASON_GRE_TUNNEL_NOT_FOUND,
+	/**
+	 * @SKB_DROP_REASON_TNL_ENCAP: failed to build the
+	 * encapsulation header of a tunnel, e.g. an unknown or
+	 * unregistered encapsulation type.
+	 */
+	SKB_DROP_REASON_TNL_ENCAP,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 0260a97e990e..e7757c0a09be 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -580,6 +580,7 @@ static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
 void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		       u8 proto, int tunnel_hlen)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	u32 headroom = sizeof(struct iphdr);
 	struct ip_tunnel_info *tun_info;
@@ -593,8 +594,10 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	tun_info = skb_tunnel_info(skb);
 	if (unlikely(!tun_info || !(tun_info->mode & IP_TUNNEL_INFO_TX) ||
-		     ip_tunnel_info_af(tun_info) != AF_INET))
+		     ip_tunnel_info_af(tun_info) != AF_INET)) {
+		reason = SKB_DROP_REASON_TUNNEL_TXINFO;
 		goto tx_error;
+	}
 	key = &tun_info->key;
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 	inner_iph = (const struct iphdr *)skb_inner_network_header(skb);
@@ -613,8 +616,10 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (!tunnel_hlen)
 		tunnel_hlen = ip_encap_hlen(&tun_info->encap);
 
-	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0)
+	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0) {
+		reason = SKB_DROP_REASON_TNL_ENCAP;
 		goto tx_error;
+	}
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
 	if (use_cache)
@@ -623,6 +628,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		rt = ip_route_output_key(tunnel->net, &fl4);
 		if (IS_ERR(rt)) {
 			DEV_STATS_INC(dev, tx_carrier_errors);
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_error;
 		}
 		if (use_cache)
@@ -632,6 +638,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (rt->dst.dev == dev) {
 		ip_rt_put(rt);
 		DEV_STATS_INC(dev, collisions);
+		reason = SKB_DROP_REASON_RECURSION_LIMIT;
 		goto tx_error;
 	}
 
@@ -640,6 +647,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, tunnel_hlen,
 			    key->u.ipv4.dst, true)) {
 		ip_rt_put(rt);
+		reason = SKB_DROP_REASON_PKT_TOO_BIG;
 		goto tx_error;
 	}
 
@@ -657,6 +665,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
 	if (skb_cow_head(skb, headroom)) {
 		ip_rt_put(rt);
+		reason = SKB_DROP_REASON_NOMEM;
 		goto tx_dropped;
 	}
 
@@ -671,13 +680,14 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 tx_dropped:
 	DEV_STATS_INC(dev, tx_dropped);
 kfree:
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 }
 EXPORT_SYMBOL_GPL(ip_md_tunnel_xmit);
 
 void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		    const struct iphdr *tnl_params, u8 protocol)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	struct ip_tunnel_info *tun_info = NULL;
 	const struct iphdr *inner_iph;
@@ -705,9 +715,15 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 		if (!skb_dst(skb)) {
 			DEV_STATS_INC(dev, tx_fifo_errors);
+			reason = SKB_DROP_REASON_NO_TX_TARGET;
 			goto tx_error;
 		}
 
+		/* Only the branches below can derive a destination.  If
+		 * none of them matches, the payload protocol is not one
+		 * this tunnel can carry.
+		 */
+		reason = SKB_DROP_REASON_UNHANDLED_PROTO;
 		tun_info = skb_tunnel_info(skb);
 		if (tun_info && (tun_info->mode & IP_TUNNEL_INFO_TX) &&
 		    ip_tunnel_info_af(tun_info) == AF_INET &&
@@ -728,8 +744,10 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 			neigh = dst_neigh_lookup(skb_dst(skb),
 						 &ipv6_hdr(skb)->daddr);
-			if (!neigh)
+			if (!neigh) {
+				reason = SKB_DROP_REASON_NEIGH_CREATEFAIL;
 				goto tx_error;
+			}
 
 			addr6 = (const struct in6_addr *)&neigh->primary_key;
 			addr_type = ipv6_addr_type(addr6);
@@ -746,8 +764,10 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 				dst = addr6->s6_addr32[3];
 			}
 			neigh_release(neigh);
-			if (do_tx_error_icmp)
+			if (do_tx_error_icmp) {
+				reason = SKB_DROP_REASON_NO_TX_TARGET;
 				goto tx_error_icmp;
+			}
 		}
 #endif
 		else
@@ -774,8 +794,10 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			    tunnel->net, READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
-	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
+	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0) {
+		reason = SKB_DROP_REASON_TNL_ENCAP;
 		goto tx_error;
+	}
 
 	if (connected && md) {
 		use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
@@ -792,6 +814,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 		if (IS_ERR(rt)) {
 			DEV_STATS_INC(dev, tx_carrier_errors);
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_error;
 		}
 		if (use_cache)
@@ -805,6 +828,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (rt->dst.dev == dev) {
 		ip_rt_put(rt);
 		DEV_STATS_INC(dev, collisions);
+		reason = SKB_DROP_REASON_RECURSION_LIMIT;
 		goto tx_error;
 	}
 
@@ -814,6 +838,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, 0, 0, false)) {
 		ip_rt_put(rt);
+		reason = SKB_DROP_REASON_PKT_TOO_BIG;
 		goto tx_error;
 	}
 
@@ -848,7 +873,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (skb_cow_head(skb, max_headroom)) {
 		ip_rt_put(rt);
 		DEV_STATS_INC(dev, tx_dropped);
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
 		return;
 	}
 
@@ -864,7 +889,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 #endif
 tx_error:
 	DEV_STATS_INC(dev, tx_errors);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_xmit);
 
-- 
2.47.3

