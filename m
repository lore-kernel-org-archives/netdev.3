Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385376;
	b=MyXmNjIb+GlsM24BszsB0tGVTnJ38+njPSVgtd8csr4INQVVrWva2FKfVscmMcIFgAjl
	 WtCDkFXvmJcinPlAZBcnhTnA+v1e6R91VlCanUZ37BuBbAsi8IFJX7SgnTk75MwyYFyir
	 ey7Lpye60z0N02coUi0B2+xrviBZo76jthIhDrfc2DwWArqbF82H46iVPWkmoYdMOmFIs
	 f2nFbJsLq4asIV/1Tv5DKIbeWwkudjbK3gHTIyjMPM7VKaJKiIMYnC7x4n+b6RuvMJfAD
	 yGhfWWu0WqKDWfoMj/bPn8aXu5yfYdif5YpFeknOE/S35oakLvkp/5Hkghr4EvhXKiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385376;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=BwIQ9moUsoLTp/jYOv+s7DlJVU2q3ooRqyXGhjOvLyU=;
	b=K8XvxaKmZ8haokIocYhRrAbanznmr/uTSx2IGy6oB6lx7QzpvQC2ezPPmSj6iVZE5IA2
	 MnE0PA6EFZ1tHzfOwO2rYpirFrn9ZnW5H3G3luKY0CKTtKemhmMiE3Zew7KDcY5VjhXH8
	 YkHuq2Y5ay2QEu4LuZbMLzOLGVqsfzr0mOP3V5IqVUGkPbeisEFRw7MOp348wKtId9O8G
	 xAZOu4fPy1L0hO0ZJkUZzm9aUup0wYTInXPLASW7zJqFqFpvvaCLD0wlSunk07d3Jk/eQ
	 oB7ere5Tj14glmHcoSDwpchj8rF899x2Gt2pblTpeqxqYWJK2uT3Uk68fWsfU/AVVTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=BXIoJJ8l;
	arc=none smtp.remote-ip=195.10.208.50
Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74660A260A
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF74660A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=BXIoJJ8l
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4jPc2z5stFz9sK7;
	Wed, 11 Nov 2026 09:22:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794385371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BwIQ9moUsoLTp/jYOv+s7DlJVU2q3ooRqyXGhjOvLyU=;
	b=BXIoJJ8lUj8dz7GNJwxkz2bClqEFk9oQpMPo/QpF65CFWJIx88Ke3JI3kR4keqBJ+o31ap
	Iid9loUhcPW9qDugraNG+jmYcSGeiy2pHpadeuZgXhGydhZOeoNSYqi+4xRYCVzPqAsOZL
	+MAXIVdLudOM8HeS9Orc2ihSEUNSdTZLTseZm38tuwkjBfJvKT4tIU77DaxC/wvwZUcU4t
	PM/H1wsEW0tPLhV3iqh0T7BsBdzE8HpR/jGDGTDxTmCX5i7H37dI8oQg+z5/qMhBp4hYEO
	gOMefnJdQUY2YtA6x5qzKpVtJossHWyVvbaYkCdgYPTbuVVt1m+IMGVFfVlhCQ==
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
Subject: [PATCH net-next v2 2/3] ipv6: add ip6_dst_lookup_flow_cookie
Date: Wed, 11 Nov 2026 09:22:36 +0100
Message-ID: <e48cac0cdf9f3adcedecbbfff4a314a98bc22d01.1794384146.git.ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jPc2z5stFz9sK7

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
Changes since v1 https://lore.kernel.org/netdev/e40f48e925a0950eac99a3f084e485e82cabe88f.1793806941.git.ralf@mandelbit.com/
- Fix kdoc return statement in ip6_dst_lookup_flow and
  ip6_dst_lookup_flow_cookie. (NIPA)

 include/net/ipv6.h    | 13 +++++++++++
 net/ipv6/ip6_output.c | 51 +++++++++++++++++++++++++++++++++++++++++--
 net/ipv6/route.c      |  2 +-
 3 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 579df1516d25..5a6c66504056 100644
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
index 25fe0ba98b1a..1b273714f7cc 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1279,8 +1279,7 @@ EXPORT_SYMBOL_GPL(ip6_dst_lookup);
  *
  *	This function performs a route lookup on the given flow.
  *
- *	It returns a valid dst pointer on success, or a pointer encoded
- *	error code.
+ *	Return: a valid dst pointer on success or a pointer encoded error code.
  */
 struct dst_entry *ip6_dst_lookup_flow(struct net *net, const struct sock *sk, struct flowi6 *fl6,
 				      const struct in6_addr *final_dst)
@@ -1300,6 +1299,54 @@ struct dst_entry *ip6_dst_lookup_flow(struct net *net, const struct sock *sk, st
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
+ *	Same as ip6_dst_lookup_flow, but also returns the cookie describing
+ *	the routing state the dst was obtained from. A caller caching the dst
+ *	should use this cookie when validating it with dst_check. If the
+ *	IPv6 FIB changed during the lookup, a route dst no longer validates
+ *	with it. An xfrm bundle is validated by xfrm and ignores the cookie.
+ *
+ *	Return: a valid dst pointer on success or a pointer encoded error code.
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
index 89fddc9df55c..84af9626c738 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2811,7 +2811,7 @@ INDIRECT_CALLABLE_SCOPE struct dst_entry *ip6_dst_check(struct dst_entry *dst,
 	rt = dst_rt6_info(dst);
 
 	if (rt->sernum)
-		return rt6_is_valid(rt) ? dst : NULL;
+		return (rt6_is_valid(rt) && cookie == rt->sernum) ? dst : NULL;
 
 	rcu_read_lock();
 
-- 
2.56.0

