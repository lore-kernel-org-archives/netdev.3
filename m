Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5E9366057
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785026406; cv=none; b=GX/x01AI9E7SZPJyI/sE0/UdOcCd1J2dPeBxdDXanAssBHDpE9jVyRCjaRf4X/z8kX29hw2jqxdyXosbgijpbhcd/juau/vM00PTJ3wmdO8AdCOlftGr8RzdsCenHeeNPKCOcGN2PDjxdiFOWZZvcgL7DfQoX4WXp4uDXf4heNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785026406; c=relaxed/simple;
	bh=U/rwNanqn3XfYHC5o1rIYS4gIYBhz5xgEHxAbSACRrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gB6GKa+OhGDpej+mEFyZx1tdObj3IU/4gitIdH827vKFbGzarphAl2PDJyd0+WQmBU7RqR145RT2KztS3Q0um1I1uoZSGyoH3czpzsvYRAbN/DhA2fHLl2f662yJ2Iyh3qaeaBrTWAWxKASvn5imtGyrLc/yadP/PL29b45/DHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=gdiPcduH; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="gdiPcduH"
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 25860180149
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 02:32:44 +0200 (CEST)
Received: (qmail 4668 invoked by uid 988); 26 Jul 2026 00:32:43 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by perseus.uberspace.de (Haraka/3.1.1) with ESMTPSA; Sun, 26 Jul 2026 02:32:43 +0200
From: David Bauer <mail@david-bauer.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] l2tp: account for IP version in SKB headroom
Date: Sun, 26 Jul 2026 02:32:27 +0200
Message-ID: <20260726003231.403489-1-mail@david-bauer.net>
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
	bh=U/rwNanqn3XfYHC5o1rIYS4gIYBhz5xgEHxAbSACRrU=;
	b=gdiPcduHbwvmWVEET4M88pRg4NH5TJW5GmDuMGVFGpokCc9x9T6vq2LzyaDNPwuxDNsCCkBppt
	KLSCESPTbpgWkU+kjQHIqUDYKiHfadj9+yooQH8CdmOXsbdZcsd1YpwAEQYt1HAufG8ZX9Ihmtg1
	Rt56koKos1oBM0WC03cBklwrqXBvT4+VcdKwJ4b5yMBj2N5mc+oOOU5ZLXjgh3JynJg1UGRvfzFb
	BcE0Dv5qZjJzI4eJYrRtIkVw+E0YBfy5Wgp8npFk+VQ5pYaL5MnzBpio+PD0UEbvMzoNCFBPLb36
	bhlkYjTl5jQzGQjECoOZ4J6SBMxDFMlcsb5lEPh7VtyTCE5K3aKWPzSzIW0Ut1f7qz912Ehf5mQw
	4bySh72slJ+/oZt6huEvKYWEwzvGu/NeCcfnnmVIvjzYwrL6CkqQbOoUvQAyoQ8wapAeBsnabOIz
	Wtf5xFwHsnKuIVNb0khE/MwjsM+F7PZBL1UcusXn9f0U2uDaqnNESrGlUaJ/+eKZ/q2cYEkc9Ptg
	dQSEAqauEB6boguhXnxcfnAbHsmhEK/ShOAL5XDjz93Rappk7ieSo+Ka9l07essQqf+cB+aDmfx8
	KgTmQ5xpH9oalOmnesFXaG9OzYV2OzzmmSAsSJkST9pcb5D5RBlZJqAaO1HFuq32I79j+mM171Ew
	I=

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

