Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4851A2545
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785026405; cv=none; b=N1hbQdNoKBAx7QRoWatWpMGW7OLd06UbQ9cUonmzuEnA7ft9lovaDXdyQb108MjpmoGjTAWXlkkC/Hi4LNYD1nnT7I4gKfEns2XTCMqCLIFRDkEOCRmUgZ4igRsr58OBRyrXTjYi5roBDaFa+X7rq9Wkh2Mgd9oAe4D6LrdDT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785026405; c=relaxed/simple;
	bh=IdnRII5AFLLGiNRJBMR4htYuayp/tmQT8nkB1Fu829o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1W7bfJt1SgEetkITQmQeZ40NZBoa3MapWNtRYpxYKukYWUBaLaCkjWMlwKKyK/HWSbvfkOodiwmiTCU7UpYJQccOe9CWtODDJj0raj9cPvyxKN1D13N3ZoCDq2G4d4XRgVBhAc9u4ZsrVGw49NmUEgWuLaMhbaMztsMDkdr730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=HTVkQbQu; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="HTVkQbQu"
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 3356E180186
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 02:32:45 +0200 (CEST)
Received: (qmail 4680 invoked by uid 988); 26 Jul 2026 00:32:45 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by perseus.uberspace.de (Haraka/3.1.1) with ESMTPSA; Sun, 26 Jul 2026 02:32:45 +0200
From: David Bauer <mail@david-bauer.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] l2tp: unify headroom calculation
Date: Sun, 26 Jul 2026 02:32:28 +0200
Message-ID: <20260726003231.403489-2-mail@david-bauer.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726003231.403489-1-mail@david-bauer.net>
References: <20260726003231.403489-1-mail@david-bauer.net>
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
	bh=IdnRII5AFLLGiNRJBMR4htYuayp/tmQT8nkB1Fu829o=;
	b=HTVkQbQuT/8m+bjTyDUaqkxr/KS41GwXcGxjo8ISyElf46AKgH5s8c6n9umaEGeqJRZM0i7O/E
	pM6Is8aC6lpGrNY7vxCdhDl0FA5LGBUIqLzY9HNNn6+g3fn2/QjS+FXLc7hGSZuO/oMoBt9xFd6U
	wahC4z88WNRAltbxXsmJPN9T9iiR4e0FsE3d0rEZq7KtstRSMBXBG5eH7W9sYRPfBZSUcnL1m/A5
	qfGSUlXuVDCSip7ISQhMwRx4adJA02baoBVjSZdHTfezaRt1K6eSFhhnWDXrebiWZ1bLg8QxC4Rf
	DR/T76P8F4/nIPNVbs5j+udkpt+eggbekBfyPh6pvWCDpN2rlwrvc90Da0zwyvVJJG3lSocnuu4/
	nJuFCCPx/1lN8jNBXs3/Uxl6XYXap1sopSNGMzLI4oSQQwMWcTodA7ShZPfNplTZ9LNQY5IJ3h3P
	J5E4uvI7B9AxmHswfB+oV9IHmt87tnaW+X1WOhVqmBaEsyvpWyic1nlbxnMM3xlWR3xhsNj0U4yP
	vr0OWhMxji4uAwedZ4Tl6XcjJ24N9rX0HVMwW4HlQZ9Cmr4RtuTDogbSnCgMgFaD5MKtxPlxQIi7
	sYJQI2YCnz0edt54YDYAPb9kpJDdsn+r+CFeV3xpFrBn6Z0CZ9MJ08qk5caYHQIgnJyqckAXDTja
	c=

Unify the calculation to determine the required headroom for each skb.
This was previously done inconsistently, resulting requesting more space
in the skb headroom when crafting the L2TP header than indicated with
needed_headroom.

Signed-off-by: David Bauer <mail@david-bauer.net>
---
 net/l2tp/l2tp_core.c |  8 +++-----
 net/l2tp/l2tp_core.h | 18 ++++++++++++++++++
 net/l2tp/l2tp_eth.c  | 14 +++-----------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index d6fa0f7436629..73361c46e6782 100644
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
@@ -1290,7 +1288,7 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
 		uh = udp_hdr(skb);
 		uh->source = inet->inet_sport;
 		uh->dest = inet->inet_dport;
-		udp_len = uhlen + session->hdr_len + data_len;
+		udp_len = l2tp_tunnel_udp_hdrlen(tunnel) + session->hdr_len + data_len;
 		if (udp_len > U16_MAX) {
 			kfree_skb(skb);
 			ret = NET_XMIT_DROP;
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index aab574376d95f..9f24045695b61 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -335,6 +335,24 @@ static inline int l2tp_v3_ensure_opt_in_linear(struct l2tp_session *session, str
 	return 0;
 }
 
+static inline int l2tp_tunnel_udp_hdrlen(struct l2tp_tunnel *tunnel)
+{
+	return tunnel->encap == L2TP_ENCAPTYPE_UDP ?
+		sizeof(struct udphdr) : 0;
+}
+
+static inline int l2tp_session_overhead(struct l2tp_session *session, struct l2tp_tunnel *tunnel)
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
index 9e5f9deac08cf..6f4516180c922 100644
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
 		 * because tunnel->sock was NULL or the socket's
@@ -204,10 +198,8 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
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
@@ -215,7 +207,7 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
 	else
 		dev->mtu = mtu;
 
-	dev->needed_headroom += session->hdr_len;
+	dev->needed_headroom = l2tp_session_skb_headroom(session, tunnel);
 }
 
 static int l2tp_eth_create(struct net *net, struct l2tp_tunnel *tunnel,
-- 
2.53.0

