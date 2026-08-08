Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445137A83A
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786229407; cv=none; b=OxXoHmLFHfknZhtR6815G5R2sRVj21T7RJJ3a3uPpisSMyOzd7Q2aPf5cFHbUG2ZgLvI5gLLWiBAwCMIMw60DWvFX89XBsztWUQ/mNEjJb2JdHHEKHPg+nSB4xY3lpwOG80K/NTTREnyTme1f0p7Bf0V5eXlOrOQFGQM/isWyS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786229407; c=relaxed/simple;
	bh=Yv8lBqO/udfdxkO5A/EhO+3uB5djyNkIhr5HW3WNXIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIZmPD/u98+s9pteWq0yZ/tMk0MwvrVvlBiqajVvkZOCOnHvW56LoO770Yb6NDmJvJCElYSj8ZwUS6axZZZM7fj1AK4Y+j5dFUmmtdxLk72Rx+cJXywzO4e6JoYoVIE9ucDyHSPCzWfn0Q4v/FKUvt3cZYUBBCtIUglgaqy1tgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=uhUvqoys; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="uhUvqoys"
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 4B7351803F8
	for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 00:43:28 +0200 (CEST)
Received: (qmail 15141 invoked by uid 988); 8 Aug 2026 22:43:28 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by perseus.uberspace.de (Haraka/3.1.1) with ESMTPSA; Sun, 09 Aug 2026 00:43:28 +0200
From: David Bauer <mail@david-bauer.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 2/2] l2tp: unify headroom calculation
Date: Sun,  9 Aug 2026 00:43:13 +0200
Message-ID: <20260808224315.1092263-2-mail@david-bauer.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808224315.1092263-1-mail@david-bauer.net>
References: <20260808224315.1092263-1-mail@david-bauer.net>
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
	bh=Yv8lBqO/udfdxkO5A/EhO+3uB5djyNkIhr5HW3WNXIc=;
	b=uhUvqoysBajVWgo2QiWXJzV+oVkspFkuu73S29AFJ0wEB0SsgEosbPvQ1H9ixNAycKev5dTz+R
	3XBlRIvbUV/ym+/hwYjsb1Y4xcL02aGIY8jtP9Q/KhFd68f5JOatSRdko1yN4EcxWutMt/qUqCxd
	2+7X5y7/yLOb1xSM+0jXGW2JbmoiJgdCELthGdnqt+y7oYeeDUlPlWNGL50K3ll9et5d26KDESeX
	3f3irA7Wc8qsp2X3gpgAYO5869/nuSMiMx1GAa/ji/6K0ryx3Xh3zCZMBjfUjKRYAMgOXVPGd7G8
	1H9x5Udv9oIkVnDFj+zUG1QIrxervMd5yZvhVWFj0MonRKg33643M6eZCz+7vTZhJ6xKHdzxNYoY
	AJTq2PEzhGTzyRB384tsluGPDGxnYULSMn0kcPPKrEeHmD59kOXhXGOGxpQ7eb/PSNKYsAAH+18v
	974qVtHCPeJqg3UEQqud0G4tsxdM23TYJgX3XpvBfO8qY/W9My0TEYXgVtPtPe8EIoGcriBrJzbs
	Y1NQptmavcj7MxS13lupVdJe81a8q0mGBsfJzs9DnfBVaDS8BKyQivviX2ulTaw+BpBgez1dh7md
	O5lFQdD2htF1WiomU+IgXvzymWdxLZu8iPLaWjTFOwbA9P6N8ThaBKc3ymXQv6nkyY1CcDUJPt5o
	8=

Unify the calculation to determine the required headroom for each skb.
This was previously done inconsistently, resulting requesting more space
in the skb headroom when crafting the L2TP header than indicated with
needed_headroom.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 net/l2tp/l2tp_core.c | 10 +++++-----
 net/l2tp/l2tp_core.h | 19 +++++++++++++++++++
 net/l2tp/l2tp_eth.c  | 14 +++-----------
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index d6fa0f7436629..f52bf3b532907 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1227,18 +1227,16 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
 	struct l2tp_tunnel *tunnel = session->tunnel;
 	unsigned int data_len = skb->len;
 	struct sock *sk = tunnel->sock;
-	int headroom, uhlen, udp_len;
 	int ret = NET_XMIT_SUCCESS;
 	struct inet_sock *inet;
 	struct udphdr *uh;
+	int udp_len;
 
 	/* Check that there's enough headroom in the skb to insert IP,
 	 * UDP and L2TP headers. If not enough, expand it to
 	 * make room. Adjust truesize.
 	 */
-	uhlen = (tunnel->encap == L2TP_ENCAPTYPE_UDP) ? sizeof(*uh) : 0;
-	headroom = NET_SKB_PAD + tunnel->l3_overhead + uhlen + session->hdr_len;
-	if (skb_cow_head(skb, headroom)) {
+	if (skb_cow_head(skb, l2tp_session_skb_headroom(session, tunnel))) {
 		kfree_skb(skb);
 		return NET_XMIT_DROP;
 	}
@@ -1290,7 +1288,9 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
 		uh = udp_hdr(skb);
 		uh->source = inet->inet_sport;
 		uh->dest = inet->inet_dport;
-		udp_len = uhlen + session->hdr_len + data_len;
+
+		udp_len = l2tp_tunnel_udp_hdrlen(tunnel);
+		udp_len += session->hdr_len + data_len;
 		if (udp_len > U16_MAX) {
 			kfree_skb(skb);
 			ret = NET_XMIT_DROP;
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index aab574376d95f..2c41877b6ce57 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -335,6 +335,25 @@ static inline int l2tp_v3_ensure_opt_in_linear(struct l2tp_session *session, str
 	return 0;
 }
 
+static inline int l2tp_tunnel_udp_hdrlen(struct l2tp_tunnel *tunnel)
+{
+	return tunnel->encap == L2TP_ENCAPTYPE_UDP ?
+		sizeof(struct udphdr) : 0;
+}
+
+static inline int l2tp_session_overhead(struct l2tp_session *session,
+					struct l2tp_tunnel *tunnel)
+{
+	return l2tp_tunnel_udp_hdrlen(tunnel) + session->hdr_len +
+		tunnel->l3_overhead;
+}
+
+static inline int l2tp_session_skb_headroom(struct l2tp_session *session,
+					    struct l2tp_tunnel *tunnel)
+{
+	return NET_SKB_PAD + l2tp_session_overhead(session, tunnel);
+}
+
 #define MODULE_ALIAS_L2TP_PWTYPE(type) \
 	MODULE_ALIAS("net-l2tp-type-" __stringify(type))
 
diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index 66d1fc3ad409a..687ce1c6db946 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -190,12 +190,6 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
 	unsigned int overhead = 0;
 	u32 mtu;
 
-	/* if the encap is UDP, account for UDP header size */
-	if (tunnel->encap == L2TP_ENCAPTYPE_UDP) {
-		overhead += sizeof(struct udphdr);
-		dev->needed_headroom += sizeof(struct udphdr);
-	}
-
 	if (tunnel->l3_overhead == 0) {
 		/* L3 Overhead couldn't be identified, this could be
 		 * because the socket's address family was not IPv4
@@ -203,10 +197,8 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
 		 */
 		return;
 	}
-	/* Adjust MTU, factor overhead - underlay L3, overlay L2 hdr
-	 * UDP overhead, if any, was already factored in above.
-	 */
-	overhead += session->hdr_len + ETH_HLEN + tunnel->l3_overhead;
+	/* Calculate required overhead */
+	overhead = ETH_HLEN + l2tp_session_overhead(session, tunnel);
 
 	mtu = l2tp_tunnel_dst_mtu(tunnel) - overhead;
 	if (mtu < dev->min_mtu || mtu > dev->max_mtu)
@@ -214,7 +206,7 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
 	else
 		dev->mtu = mtu;
 
-	dev->needed_headroom += session->hdr_len;
+	dev->needed_headroom = l2tp_session_skb_headroom(session, tunnel);
 }
 
 static int l2tp_eth_create(struct net *net, struct l2tp_tunnel *tunnel,
-- 
2.53.0

