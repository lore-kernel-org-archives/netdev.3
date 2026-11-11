Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385377;
	b=3fk4L9PuZpLwTfQrLWC4rwFurY/ZatYZz4cwq2JLFJVNXkppSo9/2WDR7lkDRGvGag0k
	 9I+BkRogTVLG5gY5hshFUcgCt3R0CeP9464JdSzV0XvljsOaxfqBKg3ibQ+3zDKEiW3P0
	 k2yjZcE6F4lSTWj/j1YjXjU4BhUCTKaNxdqd1ykOA4oUjIYJvwTLPrqEdJ6hE1YfPSw28
	 MnjBR3AAc2sJipujKsjjwZ71CeHSbLPJ3OUX6YIPI+GgOibKsMsjunaz48x9STMaj4yxf
	 FdZ8NKjm3bLbhdbqb+PYClMk0gdB+ODc1ej7DP+Inqd82NGoKomJ8oM1xfqeyWoKbsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385377;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=NZDDpKrU/yIeXbDY6WHKdTEd7lEWaMyB1sedMS9z2UM=;
	b=EEObMZB3B/lt+ZMwzcWjG/+xZUuzQGFuMWVueUtX1nygILXWE+eIuAhTOOJp0LIE+HtC
	 dsgwpwoY2aw/JOBxutC/xLvqpxL1sVIQbwTU3rn42hXG9WbR7AY8sBtyf1rUB5DAmMU43
	 lTGYnUgmY4HtRQdYzjuZmf3kW5SyhbXth6O/CCUFUdPf/6QyQ/lRMurqpM8X2FZgzhiSA
	 67Vx9Ucnkx/jYI71/U5HI9pBAeq09mrI5AQk1ycDBimVwXgg4xGRga1UWMK3TwmaDsKFf
	 F65jJqK8py3JUaZzwdQBXauAfGrbDjSfurf0up4gRvOXOhHQgETqMv6idPW8YPcFGYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=N9b7t9pc;
	arc=none smtp.remote-ip=195.10.208.42
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53E160A2625
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B53E160A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=N9b7t9pc
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jPc310Stcz5vM6;
	Wed, 11 Nov 2026 09:22:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794385373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZDDpKrU/yIeXbDY6WHKdTEd7lEWaMyB1sedMS9z2UM=;
	b=N9b7t9pcKmWbJnOB8tEnQyO48Tj4cRUL3ta7xcaQE+2KYc05lfuksZdGdOVDOssDz53Rio
	pXDXhVRQcxZ6Vnf/GRbVzCzDhzasBBIBQJbXvB7e4tS+9XtOVz3x/I5V9WM7a//Q3D9NxE
	UgrIsWSpncAUD9xMyD0PwZHL4C7t+x830YTTtu6FpBhtfq26Wq84uhyD0M42xb6kL3k2lC
	OMfkSTO0o1SqDP4CFIgZi/mbVzH72HEVFBPRs0SAIUoQOD/+Xi+mQe/w/jHnrADtbYZWsD
	yDuzZt2hXjMUGONag1DTQ3ysWY7w7hoYV/vc3pwuQPjYBvpjHIKv6zcbfAutCQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
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
Subject: [PATCH net-next v2 3/3] ipv6: use the lookup cookie when caching the dst in sockets
Date: Wed, 11 Nov 2026 09:22:37 +0100
Message-ID: <43917b9119e13e54dcde0e2941d3f4a1fe255df7.1794384146.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794384146.git.ralf@mandelbit.com>
References: <cover.1794384146.git.ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jPc310Stcz5vM6

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
No changes since v1 https://lore.kernel.org/netdev/832892eaa7d2371f20459c3134c72914e42970b0.1793806941.git.ralf@mandelbit.com/

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
index ff7a7ffbf983..c18609bab366 100644
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
index 1b273714f7cc..2288102710b3 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1370,14 +1370,16 @@ struct dst_entry *ip6_sk_dst_lookup_flow(struct sock *sk, struct flowi6 *fl6,
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
index 84af9626c738..ec7433b4fac8 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3042,19 +3042,19 @@ void ip6_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, __be32 mtu)
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
index b1dec5d86d63..25404656069c 100644
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

