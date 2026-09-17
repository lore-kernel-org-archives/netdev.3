Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257E7388E44
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639824; cv=none; b=PExxLJ8DetrnC+jX9B86D4H6/6NxeS2U4rNyHzI55nRZbAOBeyh82m6fAS+JXromf0NK2nTMTFwXqVKSZBO8sryMFrKqy/JKf/SJv5zL7MQeLbvhzGWNEIT6h/INeha8zqcp9C1GsYgJNJ9Of6t3cU+7BgZ892xjWGF5AUj96jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639824; c=relaxed/simple;
	bh=oNzE2NffAFkLZYsxNZ5fQjm1Sqcdr0SOLol4fBRIriQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TX9Cf75tsW1Bliq3r66Ybs7lzg+AH26I6U7sTSvj8+K0nhaCcYA8c8l6boJqKQadu6Cihrgjts2eKoYkWaI+ywHSecInfePoTcYkBSZlx/p1Foj/kfFDIk4I/fu83mPZ2EZweKd5AQNOF518Qv/yBVykKMV+BWCjDsjlGR5ubYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=Z4ZHaapB; arc=none smtp.client-ip=195.10.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="Z4ZHaapB"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4hls2C4SL0zNlsT;
	Thu, 17 Sep 2026 12:10:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1789639811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IURLXFO3MKgUgMKLwNK2sKMAPrC4AqwHGkFor+aBr0I=;
	b=Z4ZHaapBDOZWv9/DYOTK+kdy5S5AxmdLL5QKm1LfIH0HXksdXEbNGtqrLG5oS9MszbMdgi
	2snH9ipsCqHXBk7k+lD9W0ojRspxmAKnjpbxqIEH+eAqO8gfgC/BZeSP/+U2krMFc8bxpX
	4lJ0HSF8SCZID/Tq2wre5joGaUDPbxo+nTVoseY0iEx2Z0CQppRbCb9uzX+xMRh2oxLyNX
	Wp9iHu9Suh/vABySHlNIw6HCMLgOLcYVgG1dxUTQ33sNqzWdq/8xrnDZuMH1WTeK0+J36X
	HM8LndT9sRvSKlGDw6ir5c8tDGHHJeL5iOeI0yW1VUTLDKwZJabpysmA/ebElA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 1/1] ovpn: avoid caching stale IPv6 dst after FIB changes
Date: Thu, 17 Sep 2026 12:09:54 +0200
Message-ID: <65f8ed83f2aa154b985731c10c6c6b20060dd198.1789639346.git.ralf@mandelbit.com>
In-Reply-To: <cover.1789639346.git.ralf@mandelbit.com>
References: <cover.1789639346.git.ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4hls2C4SL0zNlsT

ovpn stores the IPv6 route used for UDP transmission in a per-peer dst
cache. IPv6 dst validation uses a cookie derived from the route itself,
or, for routes without their own sernum, from the associated fib6 node.

If the IPv6 FIB changes after ip6_dst_lookup_flow returns but before
dst_cache_set_ip6 reads the cookie, ovpn can store an old dst with a new
cookie. Later dst_cache_get_ip6 can then consider that stale dst valid
because the stored cookie matches the updated fib6 node sernum.

Sample the IPv6 FIB generation before and after route lookup, and only
populate ovpn's peer dst cache if the generation did not change while
the lookup was in flight. Also add a dst_cache helper that stores a
caller-provided IPv6 cookie, so the cached dst carries the cookie
sampled from the lookup result instead of one read after a concurrent
FIB update.

The current packet may still be transmitted with the route returned by
the lookup if the FIB changes before TX completion. This patch only
prevents that potentially stale route from being preserved in ovpn's
peer dst cache and reused for later packets.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Link: https://lore.kernel.org/netdev/20260901122501.482920-1-ralf@mandelbit.com/
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/udp.c  | 20 +++++++++++++++++---
 include/net/dst_cache.h | 13 +++++++++++++
 net/core/dst_cache.c    | 19 +++++++++++++++----
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 7f69e8890b5b..a28974cc36e8 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -220,8 +220,10 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 			    struct dst_cache *cache, struct sock *sk,
 			    struct sk_buff *skb)
 {
+	struct net *net = sock_net(sk);
 	struct dst_entry *dst;
-	int ret;
+	int gen0, gen1, ret;
+	u32 cookie;
 
 	struct flowi6 fl = {
 		.saddr = bind->local.ipv6,
@@ -250,7 +252,11 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 		dst_cache_reset(cache);
 	}
 
-	dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl, NULL);
+	gen0 = rt_genid_ipv6(net);
+	/* keep the unordered initial generation read before the FIB lookup */
+	smp_rmb();
+
+	dst = ip6_dst_lookup_flow(net, sk, &fl, NULL);
 	if (IS_ERR(dst)) {
 		ret = PTR_ERR(dst);
 		net_dbg_ratelimited("%s: no route to host %pISpc: %d\n",
@@ -258,7 +264,15 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    &bind->remote.in6, ret);
 		goto err;
 	}
-	dst_cache_set_ip6(cache, dst, &fl.saddr);
+
+	cookie = rt6_get_cookie(dst_rt6_info(dst));
+
+	/* keep the FIB and cookie reads before the final generation read */
+	smp_rmb();
+	gen1 = rt_genid_ipv6(net);
+
+	if (likely(gen0 == gen1))
+		dst_cache_set_ip6_cookie(cache, dst, &fl.saddr, cookie);
 
 transmit:
 	/* user IPv6 packets may be larger than the transport interface
diff --git a/include/net/dst_cache.h b/include/net/dst_cache.h
index 1961699598e2..5f9cc4fe926c 100644
--- a/include/net/dst_cache.h
+++ b/include/net/dst_cache.h
@@ -45,6 +45,19 @@ void dst_cache_set_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
 
 #if IS_ENABLED(CONFIG_IPV6)
 
+/**
+ *	dst_cache_set_ip6_cookie - store ipv6 dst with caller-provided cookie
+ *	@dst_cache: the cache
+ *	@dst: the entry to be cached
+ *	@saddr: the source address to be stored inside the cache
+ *	@cookie: the route validation cookie to store with @dst
+ *
+ *	local BH must be disabled.
+ */
+void dst_cache_set_ip6_cookie(struct dst_cache *dst_cache,
+			      struct dst_entry *dst,
+			      const struct in6_addr *saddr, u32 cookie);
+
 /**
  *	dst_cache_set_ip6 - store the ipv6 dst into the cache
  *	@dst_cache: the cache
diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 9ab4902324e1..76c9fc1b0acf 100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -117,8 +117,9 @@ void dst_cache_set_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
 EXPORT_SYMBOL_GPL(dst_cache_set_ip4);
 
 #if IS_ENABLED(CONFIG_IPV6)
-void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
-		       const struct in6_addr *saddr)
+void dst_cache_set_ip6_cookie(struct dst_cache *dst_cache,
+			      struct dst_entry *dst,
+			      const struct in6_addr *saddr, u32 cookie)
 {
 	struct dst_cache_pcpu *idst;
 
@@ -128,11 +129,21 @@ void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
 	local_lock_nested_bh(&dst_cache->cache->bh_lock);
 
 	idst = this_cpu_ptr(dst_cache->cache);
-	dst_cache_per_cpu_dst_set(idst, dst,
-				  rt6_get_cookie(dst_rt6_info(dst)));
+	dst_cache_per_cpu_dst_set(idst, dst, cookie);
 	idst->in6_saddr = *saddr;
 	local_unlock_nested_bh(&dst_cache->cache->bh_lock);
 }
+EXPORT_SYMBOL_GPL(dst_cache_set_ip6_cookie);
+
+void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
+		       const struct in6_addr *saddr)
+{
+	if (!dst_cache->cache)
+		return;
+
+	dst_cache_set_ip6_cookie(dst_cache, dst, saddr,
+				 rt6_get_cookie(dst_rt6_info(dst)));
+}
 EXPORT_SYMBOL_GPL(dst_cache_set_ip6);
 
 struct dst_entry *dst_cache_get_ip6(struct dst_cache *dst_cache,
-- 
2.55.0

