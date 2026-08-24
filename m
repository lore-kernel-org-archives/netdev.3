Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A109225B083
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570399; cv=none; b=lH984/HTqNOcPxHNoYrtQe6rKZFSD/In/ADVkstYpbP1BnvgdPpVsCq2Hkh1Tsiv/RU+7O25byC9ydVlpVkw7eU9ratJXpjKcO/UgWGNOgVM882zuFpV3Z2/f3Da7T/QOhSZJECoDbrowGWEC20peuOCDhLUX2jqYBEAJbVLum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570399; c=relaxed/simple;
	bh=MwXjXKzmNiIkV3RifNZIu5TYX0eiFkzj/WozPklzINs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvBwAxuKq+RFw2sizVvRx391RqFoZHCUy/olprmVniQ/aF4zo2B6BFYpfBHp2Kh+p769CFzN2kPIZ+NAWUYvCyAYURWfiyDZ3HgBCceCCBXIx+YQQ9gyFq0ytUNdGLw7XH3LQsiVj2fQO8V8ykNXy2h0FmfQPLGNd7h11pGaSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pf5OmeA9; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf5OmeA9"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66c70effc23so375255d50.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 04:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787570396; x=1788175196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T13rKDf01IVg0gpjIDieJc2bCTTY4gP5nImnjH/r5+4=;
        b=Pf5OmeA9QSY2IKPw95jshRY43ba6Hdj5o69mMX+4rpFxnbR1bPyn1edWe3GZOh9sZO
         VAGJe5f/hYJjxxRu2zlYFz8BbSbfck7A+1XW/qtC2jswR/3T2i+4UGnJbkWk+djIceGD
         hcrzvPMgyJ7h+6DvX3eRbwifE0wytePCxH8KYbBIBGLnueg6X8L+YskY3j+vVhcvcM+l
         il5KWmBxBrdBnk5BrMV6G4Xzc/2fxeLAFh+VarriDKNIJZmKUaAZr/ZVGWXyx/B2gviN
         nFXrKGq0+AJZnmXtPlI4fHDiSdA0uTiqGRRjtg4MTIuHy5ESDg6Q6rqeeSLTiSvXuTLS
         txIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787570396; x=1788175196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T13rKDf01IVg0gpjIDieJc2bCTTY4gP5nImnjH/r5+4=;
        b=nNQ0jQWcEOchDTS3wJvFOECJTXIeucgoef3KIJ6wbQ4TO4txmQqnVtHiSJku//qY3K
         8/2d8Y0pBqcjsGoRim+10lPIkUtKZpXM/nIwIxb52XEE4dU2/ENuJHuZJnBGzMfmNg52
         M3TWT31DK397/QS6vGM7HCrD3KxfvOoyfqURfWM0Ji6XxyW1Oh5HEJOlJySMbvk3+YPI
         5KhWkv4TjH01RcICdsykUlBgSDgldwfdza+DfHtHFPhtK0gak2DSswYD7Q2WVHTu5PrZ
         DB0HcmWN8T1IRthiWrUVgz8FqcIuwIexwN1bh0p0sq42ORD3cB5h5jVt4qAE4XpoHqJ2
         g6yg==
X-Forwarded-Encrypted: i=1; AHgh+Rqv6wz1/HOCx3NdwD9Y3kUm3XaFuO6N6VOU2N3DhW2aZiLoqWu7rQe3TeZ7Ne+7OrjgoM+fXvQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lCRkgfrRBfmhHTFxxqb1tKiPxBQfqwSD19K4bkZgEHlLer5ka5
	uPoNn7vFVi9iVYjAesUqb0qiMy7p3llwU27A4navzoWQF1mOUIqeNs3X
X-Gm-Gg: AR+sD11IF3JuavFu23431rTFAgWEFA45YQtf/hW13lDyRZtsXxkeQYXenkft5GF7ER4
	XQt5odzT1UMX/t5ph9Dh1eJKWRURC+yyPZQRXLMBqyNck74rBpvMggwD+zttUODA6xnyVfHih3b
	fz2dgz+aLP08Vw+qY53v5wWXlQNdVUEylCit0fvfRn8Oiw9zH316aGpdaBd9v/TLu86J7ZY3lPk
	M3caA0m0z1M8lmSrofEVEcD/f79Xmg0SdVpVu++mAgafbKNbzNpqVR0Trzr+C6YWvgfvQlAMSVz
	vZBczbsmECkDGcAqkKI+T+UpI2XqUayVZb02bY64/KYrlE8oCwvWk5uxs8LGE5WG0H+UUGeQ8dt
	kcjKq4uIPEjln/fyC8hjEpeFsfgM4owNaTN4lbKp5wCH5PkJL1c6KFH94kedcjkHcx1RtGrd4Cm
	MtWFMHb4foB3id6im9ZzBFpyQRnNlrNqhcbjOfOc+dXDiECpmnE2FJ8nmEE306x3aMA7DkOo03j
	K/MrSvJqWcBIjnt5Mu0QtHgeoOun4pNlM3RvKpqZlcRMyF3YG91Pho=
X-Received: by 2002:a05:690c:6e0d:b0:80b:d006:6436 with SMTP id 00721157ae682-849f5df5f1dmr104720337b3.4.1787570396427;
        Mon, 24 Aug 2026 04:19:56 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca5d252f0sm30623677b3.13.2026.08.24.04.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:19:55 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Xin Long <lucien.xin@gmail.com>,
	William Tu <u9012063@gmail.com>,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] ip_tunnel: reserve FOU/GUE headroom before encapsulation
Date: Mon, 24 Aug 2026 19:19:44 +0800
Message-ID: <20260824111944.187200-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_tunnel_encap() expects its callers to reserve headroom based on
ip_encap_hlen(). Unlike the IPv6 tunnel transmit paths, the IPv4
ip_tunnel_xmit() and ip_md_tunnel_xmit() push FOU and GUE headers
before they grow the skb headroom.

That becomes visible when ipgre_changelink() publishes UDP
encapsulation before it updates the device headroom. The transmit path
does not serialize with RTNL, so it can interleave as follows:

  CPU 0 (ipgre_changelink)        CPU 1 (ipgre_xmit)
  install GUE encapsulation
                                  reserve the old needed_headroom
  publish larger GRE flags
  update tunnel->tun_hlen
                                  push the larger GRE header
                                  push the GUE and UDP headers
  update dev->needed_headroom

With REMCSUM, the new layout can push 16 bytes of GRE and 20 bytes of
GUE/UDP headers into an skb with only 32 bytes of actual headroom. The
final UDP push writes four bytes before skb->head.

With the update window widened, the kernel reported:

  skbuff: skb_under_panic: ... len:128 put:8 ... dev:gre0poc
  kernel BUG at net/core/skbuff.c:214!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  Call Trace:
   skb_push
   fou_build_udp
   gue_build_header
   ip_tunnel_xmit
   __gre_xmit
   ipgre_xmit

Use ip_encap_hlen() up front, route and perform PMTU handling first,
then reserve the final headroom before ip_tunnel_encap() builds the
UDP tunnel headers. This matches the existing IPv6 pattern and keeps
ip_tunnel_encap() as a pure header builder.

Fixes: dd9d598c6657 ("ip_gre: add the support for i/o_flags update via netlink")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v3:
- Move the headroom reservation into ip_tunnel_xmit() and
  ip_md_tunnel_xmit() instead of growing the skb inside the FOU/GUE
  builders.
- Use ip_encap_hlen() to reserve the final caller-side headroom before
  ip_tunnel_encap(), matching the existing IPv6 transmit pattern.
- Drop the IPv4 raw-pointer refreshes that were only needed when
  skb_cow_head() could run inside the encapsulation builders.

Link: https://lore.kernel.org/netdev/20260808005956.3761487-1-nicoyip.dev@gmail.com/ [v2]
Link: https://lore.kernel.org/netdev/20260801060115.3538849-1-nicoyip.dev@gmail.com/ [v1]
---
 net/ipv4/ip_tunnel.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 9d114bd575f9..5d5e7db11b3d 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -578,6 +578,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	const struct iphdr *inner_iph;
 	struct rtable *rt = NULL;
 	struct flowi4 fl4;
+	int encap_hlen;
 	__be16 df = 0;
 	u8 tos, ttl;
 	bool use_cache;
@@ -601,11 +602,11 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			    tos & INET_DSCP_MASK, tunnel->net, 0, skb->mark,
 			    skb_get_hash(skb), key->flow_flags);
 
-	if (!tunnel_hlen)
-		tunnel_hlen = ip_encap_hlen(&tun_info->encap);
-
-	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0)
+	encap_hlen = ip_encap_hlen(&tun_info->encap);
+	if (encap_hlen < 0)
 		goto tx_error;
+	if (!tunnel_hlen)
+		tunnel_hlen = encap_hlen;
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
 	if (use_cache)
@@ -645,7 +646,8 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			ttl = ip4_dst_hoplimit(&rt->dst);
 	}
 
-	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
+	headroom += encap_hlen + LL_RESERVED_SPACE(rt->dst.dev) +
+		    rt->dst.header_len;
 	if (skb_cow_head(skb, headroom)) {
 		ip_rt_put(rt);
 		goto tx_dropped;
@@ -653,6 +655,11 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_adj_headroom(dev, headroom);
 
+	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0) {
+		ip_rt_put(rt);
+		goto tx_error;
+	}
+
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
 	return;
@@ -677,6 +684,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	__be16 payload_protocol;
 	bool use_cache = false;
 	struct flowi4 fl4;
+	int encap_hlen;
 	bool md = false;
 	bool connected;
 	int err_count;
@@ -765,7 +773,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			    tunnel->net, READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
-	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
+	encap_hlen = ip_encap_hlen(&tunnel->encap);
+	if (encap_hlen < 0)
 		goto tx_error;
 
 	if (connected && md) {
@@ -834,7 +843,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	max_headroom = LL_RESERVED_SPACE(rt->dst.dev) + sizeof(struct iphdr)
-			+ rt->dst.header_len + ip_encap_hlen(&tunnel->encap);
+			+ rt->dst.header_len + encap_hlen;
 
 	if (skb_cow_head(skb, max_headroom)) {
 		ip_rt_put(rt);
@@ -845,6 +854,11 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_adj_headroom(dev, max_headroom);
 
+	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0) {
+		ip_rt_put(rt);
+		goto tx_error;
+	}
+
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
 	return;
-- 
2.43.0

