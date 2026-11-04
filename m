Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807647;
	b=xssnpgs/Xvc1BfA8+Ed9U6ynYodLQ7CfixJCNFGRaMzAXkHmNDP9rpJMS7iFMB6RKqd4
	 grwOVsBuLnX2k2iyqtoE+p7/ETxdPmRO/mCb7MxXVAJOybR3bpEjND6PY19n101weZIcI
	 GmHkFjcYG1ubznzarpPtmttXPVMntR5x2fB9wO4n62vpDLsD4KzKGlK5Yq0cgV8jDKumL
	 9uIVqCdUVE0kOHV02cdweqTPDVGggX8qMwVo98kXLwKVqGDa1D9I+24+bOA+8VvmhEAmw
	 DdI9Kr+6OpPPZ3qg/8xq8LBYvjdt3+p9QCwdskhzEPu5QNeLTGFdOBkNcaF6Z2lI1oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807647;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=PLGpNpz25Qz3CmIQ7D+7zv9NZHAsCr6e6nfBj5VFi8U=;
	b=j9le9rcD14KgLg7onc5etH4xDZvzuvO9H3nPjc7szHyaPZjtaoQQlJCa1tBOjEBn8cQo
	 F1GoxvPF8jf5TadFY/quej8H2b9SU2Y2mAQxwBuTz82D/pCneycPyJrHzyjm4H21JiWBc
	 L9D3PMCKGdo3QOvaBAyF+hiOP+HGFbZW7Hj83VCzs1vTPuqtbbTXZW79csMMRd4r25vZ1
	 3gIsj9S7IzfA0WNYHO99ViRtstjpAmyT1+J4vtsAk/rnjYjYYTSpbftySTqWhpsscv3W/
	 T/IS4Tzy2a4cx5CKiCKYGh+pWpnlCnns00U9exnEtWDmCq/RQIp3ElnsrYZutvSNeWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ZYG5IcsE;
	arc=none smtp.remote-ip=195.10.208.61
Received: from mout-b-201.mailbox.org (mout-b-201.mailbox.org [195.10.208.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793D606A329
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C793D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ZYG5IcsE
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4jKVNn35sRzLmVD;
	Wed, 04 Nov 2026 16:54:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1793807641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLGpNpz25Qz3CmIQ7D+7zv9NZHAsCr6e6nfBj5VFi8U=;
	b=ZYG5IcsEHM2HrFu2OEDk+zn/NQTJ5N+1njdPtpzggKQCc8F6KSVQfulCXyA32agvOvbntJ
	Q82nmikIF5h5TJvyIIeTHhi0cE4L2KWdWPQpbscQYhnbnR8YxM+oGhSemPonFbbyCoU8De
	NGVrvUfaDwXCWZJq50texEicSOmPoOkZjndcz3my4kQwroqeFITJwJr/PkfB/qFacPIQ+8
	4tLhXtvZEuxZfXhBhengK4fb7EKCMsEGMMxXu09jn2bJHiHAekwuz7iovqAVroUT33KYQ+
	M3QXxAzCm+DWXbzN7NHNw0RUZrej35gaZ8+kNPBp/M1IsZ8RGX/DJevn3YYpOQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 3/3] ipv6: use the lookup cookie when caching the dst in sockets
Date: Wed,  4 Nov 2026 16:53:31 +0100
Message-ID: <832892eaa7d2371f20459c3134c72914e42970b0.1793806941.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793806941.git.ralf@mandelbit.com>
References: <cover.1793806941.git.ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jKVNn35sRzLmVD

tcp_v6_connect, ip6_datagram_dst_update and ip6_sk_dst_lookup_flow store
the dst in the socket and read its cookie afterwards. If an xfrm policy
matching the flow is added after the route and policy lookup but before
the cookie is read, the plain route found without the policy is cached
with a post-insertion serial. Later packets pass the validation in
__sk_dst_check and skip xfrm, so a socket that should be using IPsec
keeps sending plaintext until the FIB changes again. It affects TCP and
connected UDP sockets alike.

Store the cookie returned by ip6_dst_lookup_flow_cookie instead. Add
ip6_dst_store_cookie for this and keep ip6_dst_store for callers that
have no lookup cookie.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 include/net/ip6_route.h | 18 +++++++++++++-----
 net/ipv6/datagram.c     |  6 ++++--
 net/ipv6/ip6_output.c   |  6 ++++--
 net/ipv6/route.c        | 12 ++++++------
 net/ipv6/tcp_ipv6.c     |  5 +++--
 5 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 95f936be32c6..2684f6069a5e 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -252,13 +252,13 @@ static inline const struct rt6_info *skb_rt6_info(const struct sk_buff *skb)
 /*
  *	Store a destination cache entry in a socket
  */
-static inline void ip6_dst_store(struct sock *sk, struct dst_entry *dst,
-				 bool daddr_set,
-				 bool saddr_set)
+static inline void ip6_dst_store_cookie(struct sock *sk, struct dst_entry *dst,
+					u32 cookie, bool daddr_set,
+					bool saddr_set)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 
-	np->dst_cookie = rt6_get_cookie(dst_rt6_info(dst));
+	np->dst_cookie = cookie;
 	sk_setup_caps(sk, dst);
 	np->daddr_cache = daddr_set;
 #ifdef CONFIG_IPV6_SUBTREES
@@ -266,8 +266,16 @@ static inline void ip6_dst_store(struct sock *sk, struct dst_entry *dst,
 #endif
 }
 
+static inline void ip6_dst_store(struct sock *sk, struct dst_entry *dst,
+				 bool daddr_set,
+				 bool saddr_set)
+{
+	ip6_dst_store_cookie(sk, dst, rt6_get_cookie(dst_rt6_info(dst)),
+			     daddr_set, saddr_set);
+}
+
 void ip6_sk_dst_store_flow(struct sock *sk, struct dst_entry *dst,
-			   const struct flowi6 *fl6);
+			   const struct flowi6 *fl6, u32 cookie);
 
 static inline bool ipv6_unicast_destination(const struct sk_buff *skb)
 {
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 191c9733ff9f..5797bf3e1333 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -78,6 +78,7 @@ int ip6_datagram_dst_update(struct sock *sk, bool fix_sk_saddr)
 	struct in6_addr *final_p;
 	struct dst_entry *dst;
 	struct flowi6 *fl6;
+	u32 cookie;
 	int err = 0;
 
 	if (inet6_test_bit(SNDFLOW, sk) &&
@@ -94,7 +95,8 @@ int ip6_datagram_dst_update(struct sock *sk, bool fix_sk_saddr)
 	final_p = fl6_update_dst(fl6, opt, &np->final);
 	rcu_read_unlock();
 
-	dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
+	dst = ip6_dst_lookup_flow_cookie(sock_net(sk), sk, fl6, final_p,
+					 &cookie);
 	if (IS_ERR(dst)) {
 		err = PTR_ERR(dst);
 		goto out;
@@ -112,7 +114,7 @@ int ip6_datagram_dst_update(struct sock *sk, bool fix_sk_saddr)
 		}
 	}
 
-	ip6_sk_dst_store_flow(sk, dst, fl6);
+	ip6_sk_dst_store_flow(sk, dst, fl6, cookie);
 
 out:
 	fl6_sock_release(flowlabel);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index a2bee762e825..0e5089f2a7a7 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1372,14 +1372,16 @@ struct dst_entry *ip6_sk_dst_lookup_flow(struct sock *sk, struct flowi6 *fl6,
 					 bool connected)
 {
 	struct dst_entry *dst = sk_dst_check(sk, inet6_sk(sk)->dst_cookie);
+	u32 cookie;
 
 	dst = ip6_sk_dst_check(sk, dst, fl6);
 	if (dst)
 		return dst;
 
-	dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_dst);
+	dst = ip6_dst_lookup_flow_cookie(sock_net(sk), sk, fl6, final_dst,
+					 &cookie);
 	if (connected && !IS_ERR(dst))
-		ip6_sk_dst_store_flow(sk, dst_clone(dst), fl6);
+		ip6_sk_dst_store_flow(sk, dst_clone(dst), fl6, cookie);
 
 	return dst;
 }
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b04ba79ce3ea..4107e54c7a1c 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3028,19 +3028,19 @@ void ip6_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, __be32 mtu)
 }
 
 void ip6_sk_dst_store_flow(struct sock *sk, struct dst_entry *dst,
-			   const struct flowi6 *fl6)
+			   const struct flowi6 *fl6, u32 cookie)
 {
 #ifdef CONFIG_IPV6_SUBTREES
 	struct ipv6_pinfo *np = inet6_sk(sk);
 #endif
 
-	ip6_dst_store(sk, dst,
-		      ipv6_addr_equal(&fl6->daddr, &sk->sk_v6_daddr),
+	ip6_dst_store_cookie(sk, dst, cookie,
+			     ipv6_addr_equal(&fl6->daddr, &sk->sk_v6_daddr),
 #ifdef CONFIG_IPV6_SUBTREES
-		      ipv6_addr_equal(&fl6->saddr, &np->saddr) ?
-		      true :
+			     ipv6_addr_equal(&fl6->saddr, &np->saddr) ?
+			     true :
 #endif
-		      false);
+			     false);
 }
 
 static bool ip6_redirect_nh_match(const struct fib6_result *res,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e006a30360ea..e45001602446 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -145,6 +145,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	struct dst_entry *dst;
 	struct flowi6 *fl6;
 	int addr_type;
+	u32 cookie;
 	int err;
 
 	if (addr_len < SIN6_LEN_RFC2133)
@@ -288,7 +289,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	 */
 	ip6_ecmp_set_mp_hash(net, fl6, sk->sk_txhash);
 
-	dst = ip6_dst_lookup_flow(net, sk, fl6, final_p);
+	dst = ip6_dst_lookup_flow_cookie(net, sk, fl6, final_p, &cookie);
 	if (IS_ERR(dst)) {
 		err = PTR_ERR(dst);
 		goto failure;
@@ -312,7 +313,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	inet->inet_rcv_saddr = LOOPBACK4_IPV6;
 
 	sk->sk_gso_type = SKB_GSO_TCPV6;
-	ip6_dst_store(sk, dst, false, false);
+	ip6_dst_store_cookie(sk, dst, cookie, false, false);
 
 	icsk->icsk_ext_hdr_len = 0;
 	if (opt)
-- 
2.56.0

