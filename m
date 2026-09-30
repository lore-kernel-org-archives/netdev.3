Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB9E52F27F
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793582; cv=none; b=qghVaeGrmkQ8NzHtA8jM98g820PftO9ybV5/O2eOqVdRlR2KOmsbcOwyRtiI5p8ueElfJsUpN7Wa1u/hlEq1Cvl1q9y1+z7O+ygp0HftsPW8Rdwn37JY/XS9NJG/W/cRFGUI62/FX92gxLJ4ZI8XWNnJ5UAPNqGsuUi25Y7AuUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793582; c=relaxed/simple;
	bh=ETE3KVm7YtrcbkFjBrkU3NxpedFemnu5Aq8/p8S3TcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfN8f5VzA4HoU6iHlA4uT/F2RIufntLA62/DrAezZn1HQDHeROaGlIYXwSFulaDOF3NR9X5XlgKctJAGDCLStgGg/K64kOMg4z2tVfdUzme3/CBJvRSKvrcfH9GspHz1hZ/W2XuiKGUSQTPHxfqw2c8Ffi3pGmvVRYo3x1qWZP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1aIeJtX; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1aIeJtX"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5ba3bdb56f0so41912e87.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793578; x=1791398378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QQ6qEwbZYfnXAk7GseVbLk3ClalmUBK5TJX2fiQrN4A=;
        b=g1aIeJtX3wgBxDNUb4sDrNb+eCR3pR71jaY/Kbq/se/uqRxerJUtQCAhyces0fVZb8
         eNyDP42DJ3iUQUxIRjVYRNhX2gvVljYMBC6GO7lcdnHaXUREfOrgm7rRc4s7tgR6cnxX
         UWDSONE7YK/y7pfvt32hkvW+QNO50s5mhmYlGRHsmxMu43VJzuQMfgz45GWoXs9W0Dwr
         spRQkOjvODzet3w3jNyE85ME2mKee6D6xgP34KF8nNO4H+q+lw7/f+OsUI/i75Ss7JPt
         EuGeQoHZKr81uRWIghDzk9U9YPTSVb1fQB0SwrqVpi/e3sfTn+v8E3P2DbVP5ozG1Eli
         U8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793578; x=1791398378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QQ6qEwbZYfnXAk7GseVbLk3ClalmUBK5TJX2fiQrN4A=;
        b=YeesYB4kTFvKXucmPXaE09CgdHkcQrFrSoq3yZI26TRavik4X4lrNLXTF5Uz7wKB/1
         qHVwpEHqglQQqKUoA2rMYdmcHLoPkGIW+TaQnN//t6ZA03HLZS6WqVuieY2CN61JdpPf
         Q5O82Jj7FdHszeJgRC1cB+uBqbg0B67JolOQv0090jytgafVb8V69bGWNY1NPX0/4xfO
         JqiYlnNnLZ93aR0FDtLRYa9l5PBsw00RQuR3gPtNlAhBk2iZJi8rDPASteVh5HX9i+dy
         3Nt0f9N9NuakADlx9B8oBgLp3VuYXOgbXWhBlz+aKq16Db/6U2PUXhCYwqiyT3GDw8wz
         R4qw==
X-Gm-Message-State: AFq9FYK0OHs7Sa5rCWP3DHkns2Bk4vjTBOumXeXK4JTPEWqg+/Xx2CR5
	XcJBsbyLp5zFhoP6sxtQ04KJpvHV7xh46gVyKFTB19durU8aFicQdsM53SV/Cw6b
X-Gm-Gg: AYBFou3PD21KWrdx7t2AjAaF4mqgkelGFp9RjGXQmwimCEEVqUYpSXR4hAED8LMUG49
	Wwg+917FU4KPxQz/S4gMYRI/tL+mEe6fuSfvskiIJAI20zRDKq18KWpE5DYmVcwJSaTBfS1HvPY
	AlcUzjdNvPVDqZTpU7jGdn5WqiPEanBvDJPDSRL34oKWwWdefiVrnSIwRWmw5Fym2G45Fgyyu7P
	vD8mYJcIzd3jwGTKffTarF37HaSsEG+FtKWkDrGZw0lgKAs2Nw26MgMgflRtanLG3K5K7p9m3Bk
	LgQSrJDzUu2MybUtqjTacmAjFmF1pB0ClQ4ehhUe+sv0k4Xo5XsCZImBbk60ca6Kw/kSM6uc7aQ
	rbKzST2YoYXQLle77JlL4D7L1FOJtx3cSHSr8jk7suTH1oHqfo/bYIN2qYAkX8j7ouiMdMYfX/0
	0VraTR3gK6hvaLsf7SK30W1RymMy4j8pD4FOONoyh5eFUuA9QQbw9XXN8oNNFNhZKdYTJRCPamj
	PfLiTTdX2oGy54gBhJbeOPPr8PU/O8DmuE8fa3OobX9TTKz11rnyYA=
X-Received: by 2002:a05:6512:1186:b0:5b6:10bc:dc4a with SMTP id 2adb3069b0e04-5ba433fc624mr94545e87.33.1790793578261;
        Wed, 30 Sep 2026 11:39:38 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.169.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fbb999sm156593e87.62.2026.09.30.11.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:39:37 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 09/14] ip_tunnel: add drop reasons to the transmit path
Date: Wed, 30 Sep 2026 21:39:05 +0300
Message-ID: <20260930183910.3151873-10-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
References: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_tunnel_xmit() and ip_md_tunnel_xmit() encapsulate the packets sent
through the tunnel, and every failure these two functions detect ends in
a plain kfree_skb(). The device counters separate them a little, but
they are too coarse to act on: tx_errors counts an encapsulation
failure, a routing failure, a routing loop and a packet that is simply
too big alike.

The packet that is too big deserves attention. tnl_update_pmtu()
returns -E2BIG for a non-GSO packet larger than the MTU if it is IPv4
with the DF bit set, or IPv6 and the MTU is at least IPV6_MIN_MTU, after
it has already sent the ICMP error back to the sender. That is path MTU
discovery working as intended, yet among the device counters the drop
only bumps tx_errors, like a failed encapsulation and a few other
failures do. If the ICMP error never reaches the sender, the resulting
MTU black hole cannot be told from those by the device counters. A
failed route lookup and a routing loop do have counters of their own,
tx_carrier_errors and collisions, but in both functions all of these
packets end up in the same kfree_skb() call.

No new reason is needed for most of it:

 - SKB_DROP_REASON_PKT_TOO_BIG for the case above,
 - SKB_DROP_REASON_IP_OUTNOROUTES when the route lookup fails,
 - SKB_DROP_REASON_RECURSION_LIMIT when the route points back at the
   tunnel device itself, which is the "dead loop on virtual device" that
   reason describes; its description now gives this case as an example,
 - SKB_DROP_REASON_NOMEM when the headroom cannot be expanded,
 - SKB_DROP_REASON_NEIGH_CREATEFAIL when the NBMA neighbour lookup
   fails, and SKB_DROP_REASON_NO_TX_TARGET when no destination can be
   derived at all, which includes a payload that is neither IPv4 nor
   IPv6,
 - SKB_DROP_REASON_TUNNEL_TXINFO, which already documents a packet
   reaching an external mode device without metadata, for the
   collect_md path.

Only the encapsulation failure has no fitting reason, so add
SKB_DROP_REASON_TUNNEL_ENCAP for it.

Drop reasons on transmit are not new: vxlan already reports several of
them from its xmit path, and ip_tunnel_core.c reports
SKB_DROP_REASON_RECURSION_LIMIT. They are most useful for forwarded
packets, which is what a tunnel gateway mostly transmits: the sender is
another host, which gets an ICMP error for only some of these failures,
so the drop has to be explained on the gateway.

Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/dropreason-core.h | 13 ++++++++++-
 net/ipv4/ip_tunnel.c          | 44 +++++++++++++++++++++++++----------
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 6f5273e16548..40f23548f668 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -132,6 +132,7 @@
 	FN(TUNNEL_OPT_MISMATCH)		\
 	FN(TUNNEL_OLD_SEQ)		\
 	FN(GRE_CSUM)			\
+	FN(TUNNEL_ENCAP)		\
 	FNe(MAX)
 
 /**
@@ -618,7 +619,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_PSP_INPUT,
 	/** @SKB_DROP_REASON_PSP_OUTPUT: PSP output checks failed */
 	SKB_DROP_REASON_PSP_OUTPUT,
-	/** @SKB_DROP_REASON_RECURSION_LIMIT: Dead loop on virtual device. */
+	/**
+	 * @SKB_DROP_REASON_RECURSION_LIMIT: Dead loop on virtual device, e.g. a
+	 * tunnel whose route to its remote end goes out of the tunnel device
+	 * itself.
+	 */
 	SKB_DROP_REASON_RECURSION_LIMIT,
 	/**
 	 * @SKB_DROP_REASON_TUNNEL_OPT_MISMATCH: the tunnel options carried by
@@ -636,6 +641,12 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_TUNNEL_OLD_SEQ,
 	/** @SKB_DROP_REASON_GRE_CSUM: GRE checksum error */
 	SKB_DROP_REASON_GRE_CSUM,
+	/**
+	 * @SKB_DROP_REASON_TUNNEL_ENCAP: failed to build the encapsulation
+	 * header of a tunnel, e.g. an unknown or unregistered encapsulation
+	 * type.
+	 */
+	SKB_DROP_REASON_TUNNEL_ENCAP,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 6d500751f837..98ebfadbf64b 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -587,6 +587,7 @@ static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
 void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		       u8 proto, int tunnel_hlen)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	u32 headroom = sizeof(struct iphdr);
 	struct ip_tunnel_info *tun_info;
@@ -600,8 +601,10 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
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
@@ -620,8 +623,10 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (!tunnel_hlen)
 		tunnel_hlen = ip_encap_hlen(&tun_info->encap);
 
-	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0)
+	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0) {
+		reason = SKB_DROP_REASON_TUNNEL_ENCAP;
 		goto tx_error;
+	}
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
 	if (use_cache)
@@ -630,6 +635,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		rt = ip_route_output_key(tunnel->net, &fl4);
 		if (IS_ERR(rt)) {
 			DEV_STATS_INC(dev, tx_carrier_errors);
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_error;
 		}
 		if (use_cache)
@@ -639,6 +645,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (rt->dst.dev == dev) {
 		ip_rt_put(rt);
 		DEV_STATS_INC(dev, collisions);
+		reason = SKB_DROP_REASON_RECURSION_LIMIT;
 		goto tx_error;
 	}
 
@@ -647,6 +654,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, tunnel_hlen,
 			    key->u.ipv4.dst, true)) {
 		ip_rt_put(rt);
+		reason = SKB_DROP_REASON_PKT_TOO_BIG;
 		goto tx_error;
 	}
 
@@ -664,6 +672,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
 	if (skb_cow_head(skb, headroom)) {
 		ip_rt_put(rt);
+		reason = SKB_DROP_REASON_NOMEM;
 		goto tx_dropped;
 	}
 
@@ -678,13 +687,14 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
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
@@ -712,6 +722,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 		if (!skb_dst(skb)) {
 			DEV_STATS_INC(dev, tx_fifo_errors);
+			reason = SKB_DROP_REASON_NO_TX_TARGET;
 			goto tx_error;
 		}
 
@@ -725,9 +736,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		} else if (payload_protocol == htons(ETH_P_IP)) {
 			rt = skb_rtable(skb);
 			dst = rt_nexthop(rt, inner_iph->daddr);
-		}
 #if IS_ENABLED(CONFIG_IPV6)
-		else if (payload_protocol == htons(ETH_P_IPV6)) {
+		} else if (payload_protocol == htons(ETH_P_IPV6)) {
 			const struct in6_addr *addr6;
 			struct neighbour *neigh;
 			bool do_tx_error_icmp;
@@ -735,8 +745,10 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 			neigh = dst_neigh_lookup(skb_dst(skb),
 						 &ipv6_hdr(skb)->daddr);
-			if (!neigh)
+			if (!neigh) {
+				reason = SKB_DROP_REASON_NEIGH_CREATEFAIL;
 				goto tx_error;
+			}
 
 			addr6 = (const struct in6_addr *)&neigh->primary_key;
 			addr_type = ipv6_addr_type(addr6);
@@ -753,12 +765,15 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 				dst = addr6->s6_addr32[3];
 			}
 			neigh_release(neigh);
-			if (do_tx_error_icmp)
+			if (do_tx_error_icmp) {
+				reason = SKB_DROP_REASON_NO_TX_TARGET;
 				goto tx_error_icmp;
-		}
+			}
 #endif
-		else
+		} else {
+			reason = SKB_DROP_REASON_NO_TX_TARGET;
 			goto tx_error;
+		}
 
 		if (!md)
 			connected = false;
@@ -781,8 +796,10 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			    tunnel->net, READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
-	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
+	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0) {
+		reason = SKB_DROP_REASON_TUNNEL_ENCAP;
 		goto tx_error;
+	}
 
 	if (connected && md) {
 		use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
@@ -799,6 +816,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 		if (IS_ERR(rt)) {
 			DEV_STATS_INC(dev, tx_carrier_errors);
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_error;
 		}
 		if (use_cache)
@@ -812,6 +830,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (rt->dst.dev == dev) {
 		ip_rt_put(rt);
 		DEV_STATS_INC(dev, collisions);
+		reason = SKB_DROP_REASON_RECURSION_LIMIT;
 		goto tx_error;
 	}
 
@@ -821,6 +840,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, 0, 0, false)) {
 		ip_rt_put(rt);
+		reason = SKB_DROP_REASON_PKT_TOO_BIG;
 		goto tx_error;
 	}
 
@@ -855,7 +875,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (skb_cow_head(skb, max_headroom)) {
 		ip_rt_put(rt);
 		DEV_STATS_INC(dev, tx_dropped);
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
 		return;
 	}
 
@@ -871,7 +891,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 #endif
 tx_error:
 	DEV_STATS_INC(dev, tx_errors);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_xmit);
 
-- 
2.47.3

