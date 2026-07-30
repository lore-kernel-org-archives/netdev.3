Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E1F2459E1
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 00:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785370887; cv=none; b=hxHrkcN9cTCwxw5i9EUAyLTaivNxJ9IDQZg7L6vCGk6dspQMFPUkHQZZb0eyirV16YJ72oxaH2PyV6ivu2Lo/orwFC+kubWNqsl1jH7DO7SroxusHkv3PdA7c2Hu5EeAam5PTkb9DunOldDU7e5he0DRnNMmeYT2XJoyfmjI6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785370887; c=relaxed/simple;
	bh=FlKxkLF2WpAMdM69oYvUSbD+QKEo3E4RCDJPOJmZ2WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCTDJ632OCoRwwu9PzCoa0yxbRro7WbL/CK8IYKjRvJ5yJ76OAuPFBmqPL25Bli3qzOuLxtQNYLu7aMhh9wKVEjGDkJugFtOeHFRn2Wdgt9n4pwuKFXJkLfS6CothOhDL3ZA7mh2MWe7A2kXZ6KNke4L95mln85J9gHaiWeiY70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=xGKtA4mu; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="xGKtA4mu"
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 490E1180353
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 02:21:15 +0200 (CEST)
Received: (qmail 14329 invoked by uid 988); 30 Jul 2026 00:21:15 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by perseus.uberspace.de (Haraka/3.1.1) with ESMTPSA; Thu, 30 Jul 2026 02:21:15 +0200
From: David Bauer <mail@david-bauer.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/2] l2tp: unify headroom calculation
Date: Thu, 30 Jul 2026 02:21:05 +0200
Message-ID: <20260730002107.447471-2-mail@david-bauer.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730002107.447471-1-mail@david-bauer.net>
References: <20260730002107.447471-1-mail@david-bauer.net>
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
	bh=FlKxkLF2WpAMdM69oYvUSbD+QKEo3E4RCDJPOJmZ2WM=;
	b=xGKtA4mu7FEVfk0rqUYRK9Vgymv1JLno4A5LuGyM5bwXlhEZvmg3A577Mrcp7u8UnCyJ3OwzJM
	fcP7mrZjrBKbVBK92T46XBob7TxOvWz5meu0cojwLG8HuS29Olnk8hFjFqOoGzIYKLRTu18mcyz1
	PviiS725Jy4Ja285CKupn2WLX6qdJTepKU9ccn2LVuriusB2ez+FZVo2E3DL/hoHIHGqXpR5XsYn
	U1yToTIsw5X5BkXUMxI4lYzdU1xaCFe2/8Q/7o7uMt8Njx/q8slz2RNh6Ppc6GcL4a+OAFOMlbNs
	qnpIM1/hwXqydXW2BsaVPuvbPqAbLCSyAikU/AMolq3wJyAcVbE2o4zqnCzV2Nm+9UKJCLfVF/u6
	PTTc0EgfPwDtSrFIhmBesvrhBasOrz69khw+5j3m2W19YEEMotTrVOpIxI8XuPVuYGl5uixD31qi
	/QXL9q9P9eYsN7XOaAXKHZfcNrcR/VCWEJoygzFG3H+JeK+V/wGNVt0ro1wuexlMD6Fy2z4iEV40
	CaMU0Mfey9zTL3xdlkXs6zSSz9Y+2WpcpfmhMKHGCI+Hld2w3NwwOlKxPAomijUlDIjm5nlXfQNo
	H4GVEaZohCziO/AfCH3yH22JzuxKcYb0J/KYZX9UbHKN9od7/+Y8OmV85od0s4OWTaoAOD1Jkb5V
	k=

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

