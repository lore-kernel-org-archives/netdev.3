Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807651;
	b=rqug3I/gf1giZAmzgd+sgtMoHGGGKNQlQxMeV8fuwiKXtUbUXjPNzSUIWCnIx5YG5rmR
	 CIl6INbpo4d8SN6y4xQ1LVtKkzoj0C2kgfzeYYgb3iREo5dwn9XM8hWa5vYg12R4ruoLH
	 2JCa8SSNWITBqiKxQv1Ukt9OfBcBPuH1RHLX5JRAhI5/ROlj34FB8/NrnKwokJwQ0A82i
	 2CA90noL8xKMFEhZfYTcKlIP5s0q/o1fNp+gJ+gZ1Mns40lHGbEJtA0XeTd1v6iCYfQxP
	 dOw6Eq2gwlmm+ENUbv0h+fSA5Dn/CcLpHQNummTqC3ABTqZ2Lf10+HgQAQVyaZYfoqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807651;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=g+LUb4nFQLa7r5XmdHEiMh9DfnzpPQR7XqZ6FyFKwM0=;
	b=aCfa6omOkVP0/IetK6tSyJ0/YqmKlhu/aCbKHG8GCjw55LquHhpq08+YYQoYR51XauyG
	 nl+Zh2Fg1Kb1mOey8vPjMT58zrDCRbLJ8sPFr3slVnKzvabYjMUtwyzkVJpsW1lPdxqvL
	 b93bIwjOgG6+/8JtrMbZ0csAhcbHSHQVHU+bE84uo6ujTZt1hDOHv9Yoou+nRgQbX/cmJ
	 GkFjnTNFbnnNG5NgqYchBklbMCAONgTtDp/Kr0ZtwqbXUZkwgG/0b+o6fklaJvAPgH3AK
	 dRPLMAX9gNcZ4HmQf1T2kFg7FRqXlgnHvmsutG4RvwmKHmeQ9rwOrh5wBX3IUWz/rNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=knaz6xw+;
	arc=none smtp.remote-ip=195.10.208.55
Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF017606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF017606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=knaz6xw+
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4jKVNm20cXzNlrF;
	Wed, 04 Nov 2026 16:54:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1793807640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+LUb4nFQLa7r5XmdHEiMh9DfnzpPQR7XqZ6FyFKwM0=;
	b=knaz6xw+Gv37j6HCWVp8VzQR1b40GQX6BP/hV+vO8HgM2sxJ3enmMN/QLdM+xtlKfpNOdE
	qrX+3k8EnLPAAJ8cfUriZlJRENNzSAkD/BPs2eaYk2nFIERnpGvWAy9VLvfx8auCzy63sU
	w9q+JYIEEHeWrVl1XnOP4vv2UzRTE4czPWhv9KWNiQaxsAdXnCVTBcJEZPgbZ4+PcXpOkI
	SZNV/UBm+jlVwC/ZA/K8xxArtBPNXe0IAeJkAoZgeBwWG1R0iyvO1Pxd9U/pFa82PyBZDh
	7ouPiGeFnzn/P9OS1qrN+b1mIwQQq/U5V2mdIc3nYyUjxwhIDcRq4e4LZJYWgA==
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
Subject: [PATCH net-next 2/3] ipv6: add ip6_dst_lookup_flow_cookie
Date: Wed,  4 Nov 2026 16:53:30 +0100
Message-ID: <e40f48e925a0950eac99a3f084e485e82cabe88f.1793806941.git.ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jKVNm20cXzNlrF

Callers that keep a dst in a persistent cache read its validation cookie
with rt6_get_cookie once the lookup has returned. For a route without
its own sernum that is the current fn_sernum of the node, so a FIB
change landing in between, or an xfrm policy insertion, which restamps
every node, pairs the old dst with the new serial. dst_check then keeps
accepting it until the next change.

Add ip6_dst_lookup_flow_cookie, which returns the cookie together with
the dst. The cookie is taken between two reads of the IPv6 generation:
if it moved during the lookup the cookie is 0, which is never a node
serial, so a route dst can still be used for the packet at hand but is
not accepted again. An xfrm bundle ignores the cookie and is validated
against its own route and path cookies, which this patch does not
change.

dsts of nexthop objects are validated against the global generation and
ignore the cookie. For them the helper returns the generation read
before the lookup, and ip6_dst_check now requires it to match
rt->sernum, so a dst allocated after a FIB change is rejected for a
lookup that began before it. Callers that read the cookie from the dst
keep passing rt->sernum and are not affected.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 include/net/ipv6.h    | 13 ++++++++++++
 net/ipv6/ip6_output.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 net/ipv6/route.c      |  2 +-
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 3de07e738538..aca14bd5f78b 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1062,6 +1062,11 @@ int ip6_dst_lookup(struct net *net, struct sock *sk, struct dst_entry **dst,
 #if IS_ENABLED(CONFIG_IPV6)
 struct dst_entry *ip6_dst_lookup_flow(struct net *net, const struct sock *sk, struct flowi6 *fl6,
 				      const struct in6_addr *final_dst);
+struct dst_entry *ip6_dst_lookup_flow_cookie(struct net *net,
+					     const struct sock *sk,
+					     struct flowi6 *fl6,
+					     const struct in6_addr *final_dst,
+					     u32 *cookie);
 #else
 static inline struct dst_entry *ip6_dst_lookup_flow(struct net *net, const struct sock *sk,
 						    struct flowi6 *fl6,
@@ -1069,6 +1074,14 @@ static inline struct dst_entry *ip6_dst_lookup_flow(struct net *net, const struc
 {
 	return ERR_PTR(-EAFNOSUPPORT);
 }
+
+static inline struct dst_entry *
+ip6_dst_lookup_flow_cookie(struct net *net, const struct sock *sk,
+			   struct flowi6 *fl6, const struct in6_addr *final_dst,
+			   u32 *cookie)
+{
+	return ERR_PTR(-EAFNOSUPPORT);
+}
 #endif
 
 struct dst_entry *ip6_sk_dst_lookup_flow(struct sock *sk, struct flowi6 *fl6,
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 25fe0ba98b1a..a2bee762e825 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1300,6 +1300,55 @@ struct dst_entry *ip6_dst_lookup_flow(struct net *net, const struct sock *sk, st
 }
 EXPORT_SYMBOL_GPL(ip6_dst_lookup_flow);
 
+/**
+ *	ip6_dst_lookup_flow_cookie - perform route lookup on flow with ipsec
+ *				     and return the matching dst cookie
+ *	@net: Network namespace to perform lookup in
+ *	@sk: socket which provides route info
+ *	@fl6: flow to lookup
+ *	@final_dst: final destination address for ipsec lookup
+ *	@cookie: where to store the cookie for the returned dst
+ *
+ *	Same as ip6_dst_lookup_flow(), but also returns the cookie describing
+ *	the routing state the dst was obtained from. A caller caching the dst
+ *	should use this cookie when validating it with dst_check(). If the
+ *	IPv6 FIB changed during the lookup, a route dst no longer validates
+ *	with it. An xfrm bundle is validated by xfrm and ignores the cookie.
+ *
+ *	It returns a valid dst pointer on success, or a pointer encoded
+ *	error code.
+ */
+struct dst_entry *ip6_dst_lookup_flow_cookie(struct net *net,
+					     const struct sock *sk,
+					     struct flowi6 *fl6,
+					     const struct in6_addr *final_dst,
+					     u32 *cookie)
+{
+	const struct rt6_info *rt;
+	struct dst_entry *dst;
+	int gen0, gen1;
+
+	gen0 = rt_genid_ipv6(net);
+	/* read the generation before looking at the FIB or xfrm policies */
+	smp_rmb();
+
+	dst = ip6_dst_lookup_flow(net, sk, fl6, final_dst);
+	if (IS_ERR(dst))
+		return dst;
+
+	rt = dst_rt6_info(dst);
+	*cookie = rt->sernum ? gen0 : rt6_get_cookie(rt);
+
+	/* keep the FIB and cookie reads before the final generation read */
+	smp_rmb();
+	gen1 = rt_genid_ipv6(net);
+	if (unlikely(gen0 != gen1))
+		*cookie = 0;
+
+	return dst;
+}
+EXPORT_SYMBOL_GPL(ip6_dst_lookup_flow_cookie);
+
 /**
  *	ip6_sk_dst_lookup_flow - perform socket cached route lookup on flow
  *	@sk: socket which provides the dst cache and route info
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index fa2b9033be6a..b04ba79ce3ea 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2797,7 +2797,7 @@ INDIRECT_CALLABLE_SCOPE struct dst_entry *ip6_dst_check(struct dst_entry *dst,
 	rt = dst_rt6_info(dst);
 
 	if (rt->sernum)
-		return rt6_is_valid(rt) ? dst : NULL;
+		return (rt6_is_valid(rt) && cookie == rt->sernum) ? dst : NULL;
 
 	rcu_read_lock();
 
-- 
2.56.0

