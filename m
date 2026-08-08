Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42CC36EAAC
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786229407; cv=none; b=FKO8h8XMGocKLZI7nsb3SDv1bz+1Q5x4UtcD9plw6/6qqXWINsuaJ4kgX0qy8X4XMC8ubFSgr+zGfxGj5zXYoV0SBLuqUS9KtKZWasxMtMBoSVqXqR2DBJX+iGFQ7BkIMxEbgM+Dv3QqOCV7Fa7pAKM0Sm0DeTdOz7y14kWPPjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786229407; c=relaxed/simple;
	bh=7x84D7GlaxbGBWZuSkoAsGjqXhoQRBpfOh2j4lOnzio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ET2mFlrSd7rkoOMD9PoiJpxPLBLfOcDhFzNPSzO/Arc/ikITQKi2JGrSDTiobHJw5TNPJ8i068pnY2dpItRt+CZMpPjk7ERLXp+Z7C0z/718A8g2E2VE+Bww656nYZtThf7hB8kVBVJpWMf2Bdympem9TqgPVfumUEn704l6w6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=dedJAOQW; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="dedJAOQW"
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 0526817F87D
	for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 00:43:27 +0200 (CEST)
Received: (qmail 15097 invoked by uid 988); 8 Aug 2026 22:43:26 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by perseus.uberspace.de (Haraka/3.1.1) with ESMTPSA; Sun, 09 Aug 2026 00:43:26 +0200
From: David Bauer <mail@david-bauer.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/2] l2tp: account for IP version in SKB headroom
Date: Sun,  9 Aug 2026 00:43:12 +0200
Message-ID: <20260808224315.1092263-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-3) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=7x84D7GlaxbGBWZuSkoAsGjqXhoQRBpfOh2j4lOnzio=;
	b=dedJAOQW7oiAjjy8NaUzNWtDeUeJ0/Xe63SliISvu65JGNt4RXAnQesvwyvtTNFAZKjcfr4eNd
	OFVeU+5r+1x8Nj5/N+nSEqAmz/LSqEa0vMuyS+C3UFXi83d3VXIMuZr4xEiqTHJiIjt7B0iZ6q7N
	MAET5jKaBegNC/KcV3bDO3fR9RDp5SDlKsR4AIrl4UevbGun0EAI2MYUiDl9XgbMk05XlwMb40S7
	jn35VUnPFGMgtQ1xuEy27GSyooS7Vr5QWIgqQACtMgjd6A/BGp7saNc0hAoFFnXfgsXi8jNUa50a
	12EMK4YRPK8/3ljTAw4Oy2aSnGusWEdq8kGHjpxqwmSoHRh8h2qccSmgBByTkc65y5sQxqm4XpEO
	LR2iQFWWj810AbWlLPEjZLdUaD/2PgWJYQ8aWNgAnnEra/9V7PUWuMFbj8Rtfb6suIKHTTwtCFal
	ymSSEAkcc9gtVj2EMkGzuaVecYzlvp65mzXyO1kZrDscJN9DvvixEfzxaV9hflVeKiML8a3ovXjM
	j0gqn6ntMjYJpHtX4I7tuuAn06PKDoqhbGoVcnuplLu2gT2cADy468xUFAcrDf/fasB2TY1Xuoug
	SuT113S9ToCCrSVGIxyq+7YgRU1dwvch1lQHHHQBgiPoRyy5rJdvJ3aItKLtANv3+c6J3v+rR0od
	4=

Account for the IP version of the tunnel when accounting skb headroom on
xmit. This avoids having to potentially copy the skb a second time down
the stack due to allocating not enough space for IPv6 headers in case
the tunnel uses IPv6.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 v4:
  - Update comment to reflect new code behavior

 net/l2tp/l2tp_core.c |  3 ++-
 net/l2tp/l2tp_core.h |  1 +
 net/l2tp/l2tp_eth.c  | 14 ++++----------
 3 files changed, 7 insertions(+), 11 deletions(-)

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
index a4956ef9574cc..66d1fc3ad409a 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -188,7 +188,6 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
 				struct net_device *dev)
 {
 	unsigned int overhead = 0;
-	u32 l3_overhead = 0;
 	u32 mtu;
 
 	/* if the encap is UDP, account for UDP header size */
@@ -197,22 +196,17 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
 		dev->needed_headroom += sizeof(struct udphdr);
 	}
 
-	lock_sock(tunnel->sock);
-	l3_overhead = kernel_sock_ip_overhead(tunnel->sock);
-	release_sock(tunnel->sock);
-
-	if (l3_overhead == 0) {
+	if (tunnel->l3_overhead == 0) {
 		/* L3 Overhead couldn't be identified, this could be
-		 * because tunnel->sock was NULL or the socket's
-		 * address family was not IPv4 or IPv6,
-		 * dev mtu stays at 1500.
+		 * because the socket's address family was not IPv4
+		 * or IPv6 - dev mtu stays at 1500.
 		 */
 		return;
 	}
 	/* Adjust MTU, factor overhead - underlay L3, overlay L2 hdr
 	 * UDP overhead, if any, was already factored in above.
 	 */
-	overhead += session->hdr_len + ETH_HLEN + l3_overhead;
+	overhead += session->hdr_len + ETH_HLEN + tunnel->l3_overhead;
 
 	mtu = l2tp_tunnel_dst_mtu(tunnel) - overhead;
 	if (mtu < dev->min_mtu || mtu > dev->max_mtu)
-- 
2.53.0

