Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E1850C2BF
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540958; cv=none; b=UuClUTMxS5I2X9ZGqsplsR0nEBZUgR9BRXaI/ixyUKgo32LcoImLNbKEJDNbK3hKABTgW+xVtJL8ENgveU2s1Tt2fwdDjL/Dd9VdPOpeCX/6GKxsGl7QhDIR40SeXsxLpJf9NE1wRNklGN+8QZJuAgeBU8SDkcD4LVjh5XkWwnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540958; c=relaxed/simple;
	bh=7Ib8IcvKeHtblIcGzQNVS6oUxOoSw6QIGv40Sk/T8uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ojPtm6MFUD9KJqNB5Xd7laH0bN0f5MX/lDUUA2pgbidJmYmiZRWMN5Q0+TSvNIfbtYKzwBAQmYiug0qmEsfgQ0C5JoF47379VqGyAJ8AbgWiEIBRVNuz/hlrVnRfbF2dMdHjGtYzFG8B+mas8TcG4cS+wsBUIQQvlhARG2+n3kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVGNI0cV; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVGNI0cV"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff2f2c4dso67725ad.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788540956; x=1789145756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Pugumtiy8a7ud4fT7dQUu5IP2KC8hqTj50eSk7DgzY=;
        b=KVGNI0cVQiXO3Ys1406hyAujbA0cwj4dT2YHfOubzYCLBOt2tZUFkt6nHSI+zZoKXA
         4mGlpSfVGXpQfrAhqidx/2V5RNft2gT+JehUrMv2DOaErHk434nlY3hQnvhVStpO6ipN
         X9HUDx19sWKQds4dLRmRWg7w0RY9M68yl66k4+495iYO7BQtyUNiZ6JM9i1Q2D3YDOiQ
         ujLaMFBIbqagqC/6TJDawckDSvJnRdG4H8/Ekr3brP6f7rQPlSirfaXEibwAyQ5b+b8b
         PmICa7gpzeZ5btpb4I3Buf816Pq6B97JFwBMRQC3+xMr56hRYUXm2cYJ0KeE5cLC5/+d
         C2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788540956; x=1789145756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Pugumtiy8a7ud4fT7dQUu5IP2KC8hqTj50eSk7DgzY=;
        b=NI8tkrrhX6PusPXyxBAT/ig4Rmv8RFxGIL+5MjOhCi5/l+VSv7dZSjeMpiKX4r2d/p
         xa1PD2u9+aN9FajwepM8U0kRb0Adir6609xNNgihGe+JVuEMy39mlZGg6cJOLAX8QZ4m
         vUIQI0t9qky58YPbkOarNDWhaztma30bBYU/z7yx8s8dpw+xn08H1wOFLe5SHp0+NEy4
         SIrlEZKF/00sivUnszbkHSaRPgdv+QC4KEI50/rcV7T1PCdw8v0OY6N2H6Ul9xAibukt
         /pYU9onbb8GCLULY0HKo0YoTaMhwOIUnvUA7YlBDHktFpYzjRyfLpP18CjrD25sylkaA
         UMWg==
X-Forwarded-Encrypted: i=1; AKwUvBwgX7s203p9o5t7boYwa9KngqwfOOHiDjuaA1oJXtstgYnDuBBIKEd/f7If51a8OUhZOaW350Q=@vger.kernel.org
X-Gm-Message-State: AFuF++n9okLJqO7RQAtiKkxz6Fgz+rE/bf6ZaRSz+qJ4SvMRUVnFR7qu
	zqdK9ba5dfasIOAMmM9sxITDEmA9pq1aiohrYNgshYaz5EUzCmgmGD4i
X-Gm-Gg: AYBFou1M7nthQfxkcF+LCWsys1asn5oU2OMKOqZSDMz2oeciM4hnfOFB1TlO89ezSwG
	oEUIxmBWM+aYVHGIACgtWfnjhfuAvzyZXlizMNneR/rj1KxgAX102nDF4ivHev5taQb5vXD4KBB
	bi0rna/zcSwz6NABmP+Uy7uzoXU9ccLx7Jk9WFaxXYY8Wi/4Hemi8CDSgQrNN0YLaFLpd30SaWh
	DIMp7NG36NYxi5RHl6veBOB2xDE63UVDz4NQHXTxeKMMy7Hh1Y8kZxjfxeY6yIh32D9ZSvvKuSo
	iiWjyTsREDVjm2a6hlRN6cpTxkF/e3vEu+UN8UlaqDd7QF1j+kZtk/oSqXygFQXJXYlSSsrqT3l
	3/S3R0VZ13pAjUt3dWLvvYT3nZo5SlI+JjHnzADaKcI9vASTv2StoDJJEAAjK1tnqfNX0FwnVtP
	KNmtfe7GLkxMwtWYYfZb5NBlTodNhWm8hXX1R2H0nK7YSGIwuOkyK2Ivkiz1aBQ2pC3GdcoP16O
	21JDtrt1qcpBzmvtleoiDwcUTdHL8UUs7To50b81SVwFkNazHYd2EFMfA==
X-Received: by 2002:a17:90b:562b:b0:396:d27b:86a4 with SMTP id 98e67ed59e1d1-39b3d5f2c09mr392878a91.2.1788540956155;
        Fri, 04 Sep 2026 09:55:56 -0700 (PDT)
Received: from localhost.localdomain (45.78.64.189.16clouds.com. [45.78.64.189])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339befe870sm8685464eec.30.2026.09.04.09.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:55:55 -0700 (PDT)
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
Subject: [PATCH net v4] ip_tunnel: reserve FOU/GUE headroom before encapsulation
Date: Sat,  5 Sep 2026 00:55:44 +0800
Message-ID: <20260904165544.1362052-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_tunnel_encap() expects its callers to reserve headroom based on
ip_encap_hlen(). ip_tunnel_xmit() currently pushes FOU and GUE headers
before it grows the skb headroom.

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

Snapshot tunnel->encap, route and perform PMTU handling first, then
reserve the final headroom before ip_tunnel_encap() builds the UDP
tunnel headers. Because encapsulation is now delayed, pass the
snapshotted encap length into tnl_update_pmtu() so the inner packet
size stays skb->len + encap_hlen - tunnel_hlen.

ip_md_tunnel_xmit() is left unchanged. It takes FOU/GUE parameters
from the skb metadata dst, not from the device configuration, so it
is not exposed to this race. tnl_update_pmtu() still runs after
encapsulation there, so that path passes 0 for the extra length.

The IPv6 analogue of this headroom reservation is still work in
progress.

Link: https://lore.kernel.org/netdev/b58876297f7d45de008f2e94b6ecab8b2ed84d21.1786088695.git.petalzu987@gmail.com/
Fixes: dd9d598c6657 ("ip_gre: add the support for i/o_flags update via netlink")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v4:
- Not restructure ip_md_tunnel_xmit(); only pass 0 into the new
  tnl_update_pmtu() argument.
- Snapshot tunnel->encap with data_race() and reuse the copy for both
  ip_encap_hlen() and ip_tunnel_encap().
- Fix tnl_update_pmtu() inner packet size after delaying the encap
  push: pkt_size = skb->len + encap_hlen - tunnel_hlen.
- Keep reverse xmas tree for the new locals.
- Note that the IPv6 FOU/GUE headroom fix is still WIP.

Changes in v3:
- Move the headroom reservation into ip_tunnel_xmit() instead of
  growing the skb inside the FOU/GUE builders.
- Use ip_encap_hlen() to reserve the final caller-side headroom before
  ip_tunnel_encap().
- Drop the IPv4 raw-pointer refreshes that were only needed when
  skb_cow_head() could run inside the encapsulation builders.

Link: https://lore.kernel.org/netdev/20260824111944.187200-1-nicoyip.dev@gmail.com/ [v3]
Link: https://lore.kernel.org/netdev/20260808005956.3761487-1-nicoyip.dev@gmail.com/ [v2]
Link: https://lore.kernel.org/netdev/20260801060115.3538849-1-nicoyip.dev@gmail.com/ [v1]
---
 net/ipv4/ip_tunnel.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 9d114bd575f9..447b435b10cc 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -512,14 +512,15 @@ EXPORT_SYMBOL_GPL(ip_tunnel_encap_setup);
 static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
 			    struct rtable *rt, __be16 df,
 			    const struct iphdr *inner_iph,
-			    int tunnel_hlen, __be32 dst, bool md)
+			    int tunnel_hlen, __be32 dst, bool md,
+			    int encap_hlen)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	int pkt_size;
 	int mtu;
 
 	tunnel_hlen = md ? tunnel_hlen : tunnel->hlen;
-	pkt_size = skb->len - tunnel_hlen;
+	pkt_size = skb->len + encap_hlen - tunnel_hlen;
 	pkt_size -= dev->type == ARPHRD_ETHER ? dev->hard_header_len : 0;
 
 	if (df) {
@@ -629,7 +630,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (test_bit(IP_TUNNEL_DONT_FRAGMENT_BIT, key->tun_flags))
 		df = htons(IP_DF);
 	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, tunnel_hlen,
-			    key->u.ipv4.dst, true)) {
+			    key->u.ipv4.dst, true, 0)) {
 		ip_rt_put(rt);
 		goto tx_error;
 	}
@@ -671,6 +672,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	struct ip_tunnel_info *tun_info = NULL;
+	struct ip_tunnel_encap ipencap;
 	const struct iphdr *inner_iph;
 	unsigned int max_headroom;	/* The extra header space needed */
 	struct rtable *rt = NULL;		/* Route to the other host */
@@ -680,6 +682,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	bool md = false;
 	bool connected;
 	int err_count;
+	int encap_hlen;
 	u8 tos, ttl;
 	__be32 dst;
 	__be16 df;
@@ -765,7 +768,10 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			    tunnel->net, READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
-	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
+	/* Snapshot encap; ipgre_changelink() can update it concurrently. */
+	ipencap = data_race(tunnel->encap);
+	encap_hlen = ip_encap_hlen(&ipencap);
+	if (encap_hlen < 0)
 		goto tx_error;
 
 	if (connected && md) {
@@ -803,7 +809,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (payload_protocol == htons(ETH_P_IP) && !tunnel->ignore_df)
 		df |= (inner_iph->frag_off & htons(IP_DF));
 
-	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, 0, 0, false)) {
+	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, 0, 0, false,
+			    encap_hlen)) {
 		ip_rt_put(rt);
 		goto tx_error;
 	}
@@ -834,7 +841,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	max_headroom = LL_RESERVED_SPACE(rt->dst.dev) + sizeof(struct iphdr)
-			+ rt->dst.header_len + ip_encap_hlen(&tunnel->encap);
+			+ rt->dst.header_len + encap_hlen;
 
 	if (skb_cow_head(skb, max_headroom)) {
 		ip_rt_put(rt);
@@ -845,6 +852,11 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_adj_headroom(dev, max_headroom);
 
+	if (ip_tunnel_encap(skb, &ipencap, &protocol, &fl4) < 0) {
+		ip_rt_put(rt);
+		goto tx_error;
+	}
+
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
 	return;
-- 
2.43.0
