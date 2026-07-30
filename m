Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E6E2236F2
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785370888; cv=none; b=FB/Q1QOc6CXfhYG61eQsX9saIrsXhT5X7WATyZTFZHpP1BWplJ48qYHp5atPzteIviqf0839ogbZj8s6MpzCmAuGUS0nHSk+RESibq1GC/L6MdAQHu2UDRowhO8SXj0bkOGDC8XUJozXXqYSz5IttyqUyRzOocNFdQKD1h8AHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785370888; c=relaxed/simple;
	bh=U/rwNanqn3XfYHC5o1rIYS4gIYBhz5xgEHxAbSACRrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bhkK1e1eNXS7j9jKRflQDJp8hMM8D7xgQk5jTM2llTYbnuETuDhsQTmbdLhZuVyX1TDYI9jBiuGV/WSlnVNUh7Vs86v+Xrg5xcXwLfXOUw5oLqZPOSZdszl/Gt3n0GxSJ7ZV8COToLOQfYguioUevSz9ol8hNpgUaN9q+DC2S7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=OuyFSff3; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="OuyFSff3"
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 2586E1802C7
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:21:14 +0200 (CEST)
Received: (qmail 14319 invoked by uid 988); 30 Jul 2026 00:21:14 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by perseus.uberspace.de (Haraka/3.1.1) with ESMTPSA; Thu, 30 Jul 2026 02:21:13 +0200
From: David Bauer <mail@david-bauer.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/2] l2tp: account for IP version in SKB headroom
Date: Thu, 30 Jul 2026 02:21:04 +0200
Message-ID: <20260730002107.447471-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-3) MIME_GOOD(-0.1) FUZZY_BULK(0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=U/rwNanqn3XfYHC5o1rIYS4gIYBhz5xgEHxAbSACRrU=;
	b=OuyFSff3Ex6YXwAqBVRoeYFWFzmLk6Vgo+D/5sVf2NN+AxQr7XujQ24IZvvFJk8TFhO1z+6Lh3
	sF2N3Z2Ugnrf+2M3U6Xh/b3x9SJEvXG7FSEDU1qSzQ3abBDO0QNRbRqrJKE9nOspqtmILukblE+0
	+hGUfpNaRwhTq+h7ONPEOFOSrlP5KLiSx6EFeGeQhZJ9NzJU+hUfOFXLIa7wI8DCp22Skp4pWj/5
	p0RAy04onJgjG4LbYElQ9QYTe1a91NqgzbpS3wEe4xPILg4/738jLt7psne3qChpXSM3ANdKGAuR
	aXNSC7PmFiF5FjEutoUMd5qHfkYGEvkXuUQXjw3iEdSQcZq91VdFF11+65k2pEFUo+uHpHaogG6s
	lV/EMoxzWDXIQab5+hQ/HmCEMj+wM499IhRR/3Ux3SJCvx8XiWanGT0N9EC3tc4YrGlhkHalZbCN
	FfX/OY4OpxAblvxIyS+LdGxRZmdbtiIKnvmX9yqN3+PDSZANmAE1xbbi1ZqYRxbTZ9p4et3i9guf
	SXMpNjmaePMhBZHLDu5hCbT4imt4XvwLROHIt4bD1Wzt6HfNvrAuKT4DCYe07AzOLHiXIcM+VVFd
	Yk/gJDYtPz3WrILNrinzSs1mdwi3eXqY28p961s5X/i9eNxMTYPtTdIfEFwFtUaPHqmTt/ENpPNO
	M=

Account for the IP version of the tunnel when accounting skb headroom on
xmit. This avoids having to potentially copy the skb a second time down
the stack due to allocating not enough space for IPv6 headers in case
the tunnel uses IPv6.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 net/l2tp/l2tp_core.c | 3 ++-
 net/l2tp/l2tp_core.h | 1 +
 net/l2tp/l2tp_eth.c  | 9 ++-------
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 4712cc41881a3..d6fa0f7436629 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1237,7 +1237,7 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
 	 * make room. Adjust truesize.
 	 */
 	uhlen = (tunnel->encap == L2TP_ENCAPTYPE_UDP) ? sizeof(*uh) : 0;
-	headroom = NET_SKB_PAD + sizeof(struct iphdr) + uhlen + session->hdr_len;
+	headroom = NET_SKB_PAD + tunnel->l3_overhead + uhlen + session->hdr_len;
 	if (skb_cow_head(skb, headroom)) {
 		kfree_skb(skb);
 		return NET_XMIT_DROP;
@@ -1688,6 +1688,7 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
 	}
 
 	sk->sk_allocation = GFP_ATOMIC;
+	tunnel->l3_overhead = kernel_sock_ip_overhead(sk);
 	release_sock(sk);
 
 	sock_hold(sk);
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index ffd8ced3a51ff..aab574376d95f 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -167,6 +167,7 @@ struct l2tp_tunnel {
 	u32			tunnel_id;
 	u32			peer_tunnel_id;
 	int			version;	/* 2=>L2TPv2, 3=>L2TPv3 */
+	int			l3_overhead;	/* IP header overhead */
 
 	char			name[L2TP_TUNNEL_NAME_MAX]; /* for logging */
 	enum l2tp_encap_type	encap;
diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index a4956ef9574cc..9e5f9deac08cf 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -188,7 +188,6 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
 				struct net_device *dev)
 {
 	unsigned int overhead = 0;
-	u32 l3_overhead = 0;
 	u32 mtu;
 
 	/* if the encap is UDP, account for UDP header size */
@@ -197,11 +196,7 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
 		dev->needed_headroom += sizeof(struct udphdr);
 	}
 
-	lock_sock(tunnel->sock);
-	l3_overhead = kernel_sock_ip_overhead(tunnel->sock);
-	release_sock(tunnel->sock);
-
-	if (l3_overhead == 0) {
+	if (tunnel->l3_overhead == 0) {
 		/* L3 Overhead couldn't be identified, this could be
 		 * because tunnel->sock was NULL or the socket's
 		 * address family was not IPv4 or IPv6,
@@ -212,7 +207,7 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
 	/* Adjust MTU, factor overhead - underlay L3, overlay L2 hdr
 	 * UDP overhead, if any, was already factored in above.
 	 */
-	overhead += session->hdr_len + ETH_HLEN + l3_overhead;
+	overhead += session->hdr_len + ETH_HLEN + tunnel->l3_overhead;
 
 	mtu = l2tp_tunnel_dst_mtu(tunnel) - overhead;
 	if (mtu < dev->min_mtu || mtu > dev->max_mtu)
-- 
2.53.0

