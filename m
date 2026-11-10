Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342037;
	b=ZJWsDWpQewMwP6JPVgejYwGCxaAT3K2zfUgnnCETZeno6tEitPewGWbJx6pYcf9SHEVt
	 SjzLeWEkQkBZsGQotDWv1w6H3YQG/BqvVw7gancTOxjA9mFaSPeMtsiC6HB8Z9bxbFFu6
	 3MiSGmW5jCW5A7BTZzeFYRS3dvEeEnkhPNG0jEZc3WynYjHanQao6W0chPL/mrau1cx1f
	 sna5+cQmwSV2SVjt0ylLRzR7PzhITnG8hqRsp7LmxKrnSx1EFdBGXnfexh9jrGl1PuB4q
	 CSyPBDnGX85f54SL0xnsUaLnnpn6mdw89s68ckwf/BSoqMrphbQR0ffs9YfIbArRWaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JNaHxAPlnIWxE7zaoc/iWSyWFuol7OYYj+MrFFaSfyY=;
	b=ioknDla2+ky9XUEz4nm0G0AyhhiHG0WHxy1QAI6t632RNYWCqmmDXhHW7K3YJE5Kfwoy
	 KKQok5Zmlv7GPr9uExwnzxwt9ILnLUXZXGB0ICUU7p2kR5yZegXDpVmJEPM/yBvFydIJE
	 MtEMNI15mfaUZOPYqEeX/8siz+XMd3coZoj0K/5rtrlmPVoRgngNfP+iN0dBoMJd6QW8b
	 QQazGOtxfaojaz7F+P0qlII1X6DVekXLHM0KGCF8zT//piF6YB2idzFuC/kP4AypTcrp7
	 FE5TWZmdUfjzZJkLBXuVIOwnk4QCTm4kurVHu4H4m+TM4+eypRQKEG9HCmvS0+ko+Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="S/DwPts0";
	arc=none smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821A60A5BC1
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0821A60A5BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S/DwPts0
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3acf82fdcdbso23934961fa.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794342035; x=1794946835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JNaHxAPlnIWxE7zaoc/iWSyWFuol7OYYj+MrFFaSfyY=;
        b=S/DwPts0ziWHvgQZdMPeL7g1NlkKp8Sil3EG8sgAfck3avy2O12lEmM8t5DhoIIU2I
         h9FoHkAMuqS7M+Un/YWtot1v3rO23WfO0DvRz+kgXhFltTiN71G+dQRh8qMxVsjZdjFl
         IkUwA2D322uR2noo57atPHbNAN+XZxV/G2LbR0uHdxngS6I1C9C3Xqy/67OvUFwkwmEL
         S7gJazsHFsZQeAUc56mJNPTaybRw5vk5sIV6ftlTXsEwqWqs3YJ8s+92M62YlYUNiaCc
         S1Jz2NxVv1b5rAKE9v8lIhF4KopGKnV1is/yigmR02Bf3onrk3X1dQ8HyNMM+CCDHNrw
         WUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342035; x=1794946835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JNaHxAPlnIWxE7zaoc/iWSyWFuol7OYYj+MrFFaSfyY=;
        b=YY9nsx4wJzz9JU7ZcEY6DeCW9+C8jjOfn8GWAprEVZW1WH4qo4gSzw4MG7+KUZXtSh
         0zwIPTSzDcyrhtuxz4lUHaE2LLLpNja7dTPLMywb9aGPDJEwqGSPsQwKnjOFnMXnaCZK
         T9O3m15GXVIqazHl2wMDnqFuaI5BrYpikVdfXAb+qnGFLTnAprLJsUXYhVygZEP1i3a2
         5tYCOSL0HBU5FSNgpP9FhJASiGunUcdZGdd5v59F+84EEIEJOjEK2CB96k4r1yCHGG2x
         Od4nZM3Ct/ttCxDUCCTqUGL1EcQ8Yu2T/ixIqKOqm5oOgOcN5Hizky0KytUAc/q9ythK
         BrAA==
X-Gm-Message-State: APuU4Z/o9ea8eE81/wNNjd71r4HKerrSYa0jdwpnYmvnea9UC+uHG5t4
	lT6E9ENuLE9yv4TPu7yQTCW1JDlHQpN1c1LkiiZYzRJnUe+Ao0Jk90uSEzYoxQt0w0KPMQ==
X-Gm-Gg: AYBFou1gC7wYJSVJi0HlAQMWtj1sKBGBKqTXJHXUyIYW3eLnXELhuNMRaekc9G1J2gd
	qqZp1R6Kv2gMp35TSK6GZTCD/4GTTLEpDQWlUJfESLsxG+Qkxcl49+YH5j7Tsth3EaVUwu2/t82
	Cr7+ZcoqRnb3LIn2O723NG3/AQGjipErD9pOv5rqYkJh7JtL/v8XzX74/bsD9fZpHGffy7yazEb
	MqqlclIdebB36vBQvH8KWTcdlT0+nVzokbfPO8ZR4Qzo2B18igW6Q468jsYOuZGGtJqo3bGKYeh
	tw1yIXFNDkkj8zgnYxtXkIfXCp1YJqgECQfRUH681qzlhaX2ADHN08htRtNcXDfNery6ojlOl6I
	auj4XFmDn/TGZiFvNe3J34Ko23oTFTHczrlrRJWx8vIMJaA6ULeXta2HaRRZldGIjLIQpQ2pATp
	4Cwlk+Tu4BBEl13wnTgUmW7zuiiFCd1LbOupZlvkvFO74vHs42+54g5+QaXjLBDdzXBxJtzRKFD
	IDATSHprC7+NjKdl21YZF9Pp6Xbkb6nXOLtNcQIxUjnP/jmUluMSPHRLog/Dka8CTfwjt69z9He
	8LKqy6ELgUYqAZFWJu6Eb+gB4qjRMf5pJgLmKE3Bj+4WA/T3XQtOKsaYhBMoJUikrjuk+BN26cD
	oi/WYSB2tNGt0GjK/
X-Received: by 2002:a2e:be9f:0:b0:3ab:2a19:8624 with SMTP id 38308e7fff4ca-3ae09632327mr7669191fa.5.1794342035172;
        Tue, 10 Nov 2026 12:20:35 -0800 (PST)
Received: from dau-home-pc.megasoftware.org ([95.139.137.59])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae090ea59esm5945401fa.0.2026.11.10.12.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 12:20:34 -0800 (PST)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 7/8] ip_tunnel: add drop reasons to the transmit path
Date: Tue, 10 Nov 2026 23:20:20 +0300
Message-ID: <20261110202021.821224-8-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110202021.821224-1-littlesmilingcloud@gmail.com>
References: <20261110202021.821224-1-littlesmilingcloud@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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

No new reason is needed:

 - SKB_DROP_REASON_PKT_TOO_BIG for the case above,
 - SKB_DROP_REASON_IP_OUTNOROUTES when the route lookup fails,
 - SKB_DROP_REASON_RECURSION_LIMIT when the route points back at the
   tunnel device itself, the case its description gives as an example,
 - SKB_DROP_REASON_NOMEM when the headroom cannot be expanded,
 - SKB_DROP_REASON_NEIGH_CREATEFAIL when the NBMA neighbour lookup
   fails, and SKB_DROP_REASON_NO_TX_TARGET when no destination can be
   derived at all, which includes a payload that is neither IPv4 nor
   IPv6,
 - SKB_DROP_REASON_TUNNEL_TXINFO, which already documents a packet
   reaching an external mode device without metadata, for the
   collect_md path,
 - the reason ip_tunnel_encap() returns since the previous patch, when
   the encapsulation header cannot be built.

Drop reasons on transmit are not new: vxlan already reports several of
them from its xmit path, and ip_tunnel_core.c reports
SKB_DROP_REASON_RECURSION_LIMIT. They are most useful for forwarded
packets, which is what a tunnel gateway mostly transmits: the sender is
another host, which gets an ICMP error for only some of these failures,
so the drop has to be explained on the gateway.

Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 net/ipv4/ip_tunnel.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index f3c5d8424925..924d02d0cc7b 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -586,6 +586,7 @@ static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
 void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		       u8 proto, int tunnel_hlen)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	u32 headroom = sizeof(struct iphdr);
 	struct ip_tunnel_info *tun_info;
@@ -599,8 +600,10 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
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
@@ -619,7 +622,8 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (!tunnel_hlen)
 		tunnel_hlen = ip_encap_hlen(&tun_info->encap);
 
-	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4))
+	reason = ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4);
+	if (reason)
 		goto tx_error;
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
@@ -629,6 +633,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		rt = ip_route_output_key(tunnel->net, &fl4);
 		if (IS_ERR(rt)) {
 			DEV_STATS_INC(dev, tx_carrier_errors);
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_error;
 		}
 		if (use_cache)
@@ -638,6 +643,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (rt->dst.dev == dev) {
 		ip_rt_put(rt);
 		DEV_STATS_INC(dev, collisions);
+		reason = SKB_DROP_REASON_RECURSION_LIMIT;
 		goto tx_error;
 	}
 
@@ -646,6 +652,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, tunnel_hlen,
 			    key->u.ipv4.dst, true)) {
 		ip_rt_put(rt);
+		reason = SKB_DROP_REASON_PKT_TOO_BIG;
 		goto tx_error;
 	}
 
@@ -663,6 +670,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
 	if (skb_cow_head(skb, headroom)) {
 		ip_rt_put(rt);
+		reason = SKB_DROP_REASON_NOMEM;
 		goto tx_dropped;
 	}
 
@@ -677,13 +685,14 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
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
@@ -711,6 +720,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 		if (!skb_dst(skb)) {
 			DEV_STATS_INC(dev, tx_fifo_errors);
+			reason = SKB_DROP_REASON_NO_TX_TARGET;
 			goto tx_error;
 		}
 
@@ -724,9 +734,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
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
@@ -734,8 +743,10 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 			neigh = dst_neigh_lookup(skb_dst(skb),
 						 &ipv6_hdr(skb)->daddr);
-			if (!neigh)
+			if (!neigh) {
+				reason = SKB_DROP_REASON_NEIGH_CREATEFAIL;
 				goto tx_error;
+			}
 
 			addr6 = (const struct in6_addr *)&neigh->primary_key;
 			addr_type = ipv6_addr_type(addr6);
@@ -752,12 +763,15 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
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
@@ -780,7 +794,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			    tunnel->net, READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
-	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4))
+	reason = ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4);
+	if (reason)
 		goto tx_error;
 
 	if (connected && md) {
@@ -798,6 +813,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 		if (IS_ERR(rt)) {
 			DEV_STATS_INC(dev, tx_carrier_errors);
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_error;
 		}
 		if (use_cache)
@@ -811,6 +827,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (rt->dst.dev == dev) {
 		ip_rt_put(rt);
 		DEV_STATS_INC(dev, collisions);
+		reason = SKB_DROP_REASON_RECURSION_LIMIT;
 		goto tx_error;
 	}
 
@@ -820,6 +837,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, 0, 0, false)) {
 		ip_rt_put(rt);
+		reason = SKB_DROP_REASON_PKT_TOO_BIG;
 		goto tx_error;
 	}
 
@@ -854,7 +872,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (skb_cow_head(skb, max_headroom)) {
 		ip_rt_put(rt);
 		DEV_STATS_INC(dev, tx_dropped);
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
 		return;
 	}
 
@@ -870,7 +888,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 #endif
 tx_error:
 	DEV_STATS_INC(dev, tx_errors);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_xmit);
 
-- 
2.47.3

