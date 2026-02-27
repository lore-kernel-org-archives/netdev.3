Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48F935A3A0
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 22:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772230074; cv=none; b=SBI5vh955KqHR2lefXH5MsIyqqdBVRPcJG/JVkBY4lxZd9JeS7bskh6rXffW5pyXVrhgddxldrt2HfpdcojNrGtpHkst/WpQXYAgHSCCfDlim13/VvmXk8qtG7Ktatqi8KWdEOlwIJuFHSfLLjaO39SWToU+XlrtbgC4FXVBHKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772230074; c=relaxed/simple;
	bh=TTfI44tvuFwsGVLvU35bqIiczRST6P5VXzFUFdVzMys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g5HmWzHD1UBCNJyTHrLZLC0Eu4gr7CJsKB7PxDUIOly3SZqR84uOZch7SjK2/v9LDUBqJSvVw6TL8cE3LpBH4Z7/ajAq/U0ynhy6R4dpTPN7qXRmrtRyjWl1I7P8TfVUepTfK9SB/lSvy0nX7k5bNjM+tVZ3t+X3DSiWgriZAAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=LRBsSFV/; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="LRBsSFV/"
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 6D1E217FF75
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:07:43 +0100 (CET)
Received: (qmail 4545 invoked by uid 988); 27 Feb 2026 22:07:43 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.1.1) with ESMTPSA; Fri, 27 Feb 2026 23:07:43 +0100
From: David Bauer <mail@david-bauer.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] l2tp: account for IP version in SKB headroom
Date: Fri, 27 Feb 2026 23:07:37 +0100
Message-ID: <20260227220740.11928-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-2.999999) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.599999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=TTfI44tvuFwsGVLvU35bqIiczRST6P5VXzFUFdVzMys=;
	b=LRBsSFV/tQIaEZ5IpwS8nn6+fHpAG05Pty3FtVIJsAeuhhb7yep1eHIKy7PlmB7lAjReIRDEnf
	e4/RMWvZ+b+OPKhAN9ex+CSA/8MkcYB/JRW4IJsmlpaENdmmNNiAQROB7NbM+WECa2xhw6P7Xauf
	p6zX1Vf4PGeJlR+Hf5/xp2q/8QfUjSo8TwfONHzfJS95Li7F8UO3Bq4mHnq/PZNn/8pv4eqSGJkn
	0pZ+mBOdErLocu7VJzNwas/u6aeGCq1bqPePdATapyIKbVErj++SrT1MHm6uCbrU3PSUXxnaN03Q
	e1QyOsKPAHJXTjArjY3JEs+cJ7hHHDQt3zT1XBljoY0t7799lhy1d6+CClaZSxCiKvSGJM9dk5no
	+WEF1iBEIjFm4NSe48ZK2gCQm/NiOv1chQuYPxtzGlEUbOn2kURYnWKE0opuJouEC6yjXAsQ+XWC
	fZkTxifkbdbqeYa8bmpprWk/s6gqCHOJVegQaYCXlxevHc+YCN3A8HhGVHLYetsNDDJNYktccFAd
	F/zcbny/KE//6mZy9sxzEDUnfzH1kTy5puDes2mxv/6z38GPOj9xPNJgCyfWJ5tkG64FdZt+l9Cr
	HEOPMijBgta522JAvac6HAswEQzlnlS1fZ34EfZgIhFLJ5aW0Vl9ootGYpnUva89hJi8+wPZFLAB
	w=

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
index c89ae52764b89..bb19c11b0af8e 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1236,7 +1236,7 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
 	 * make room. Adjust truesize.
 	 */
 	uhlen = (tunnel->encap == L2TP_ENCAPTYPE_UDP) ? sizeof(*uh) : 0;
-	headroom = NET_SKB_PAD + sizeof(struct iphdr) + uhlen + session->hdr_len;
+	headroom = NET_SKB_PAD + tunnel->l3_overhead + uhlen + session->hdr_len;
 	if (skb_cow_head(skb, headroom)) {
 		kfree_skb(skb);
 		return NET_XMIT_DROP;
@@ -1682,6 +1682,7 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
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
2.51.0

