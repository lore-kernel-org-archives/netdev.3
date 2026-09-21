Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CA546AF10
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986145; cv=none; b=MrZ7AWc/56vj7+vGJV9oslhlKEFG50lwjhmQND7V/xzxRbMO3yCdcqFU0yVCsqN67Ga+XKML0lzKcbhhhJAjCS00lv3CxSEccvRkUc0NbRuEkxik9gDf0HL4HY5uAxUgkXySB+hmNQmXAaf0jNlWUKT9rY5OhEhQAvnBnRUKPU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986145; c=relaxed/simple;
	bh=/ANmigreeHTrXcEfbtT4k7fUKnHz/4fCQs2A+jgp5Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGouuz65lAibRVFWUlN7VhuBBNJ/9yXd+Jl9LzFDdV3vz7f5tcWnWBk4KmB6CAzYA5ok4plip2O4q8k+gaTj3ptzyZK6Zae7sxQ7Ko+OeiJfGIz3bcaqEAmI/e2sJszveCxU+JdL8d3SZ1nLM81mKoKr4Xyt60axmEM4vf7F4Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BpXKjQvQ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BpXKjQvQ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d097b4939so13928985e9.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1789986141; x=1790590941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n7tjkxEa26MkRXLZGP2UNgugcoeirPpcduDaiEtHwvs=;
        b=BpXKjQvQQ/0/jTD6HFHhZHSONtS8J7b1QZfb0BWu0Xn+7QFoxS0EGew8H6rnw2NduJ
         Q6/WrvsO2hD44b+Nj/QltN9ThgpI/8kNSNivy9+5FoL0ekwthAsa32xrPaa/lU3SHpYN
         fDIecjLkpOv3cTzm2Tg+k6EweDKe9YL94eWhzF6nj6xmN7t9uGc7ttb0ijJvPpqhaxrO
         1WsSBcHFQNM/yW4PjEnofCG0HrtGdBr74cMbOuopOt7/2oLAmXbe2U49J6+e/2lthM4a
         36lCH/9GtuntamZXi38OHCea57mcvq3bFFqxWXgeWNVrDkSW5HOhSTa4mFRac92GxXuX
         3Unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789986141; x=1790590941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n7tjkxEa26MkRXLZGP2UNgugcoeirPpcduDaiEtHwvs=;
        b=tswzflbSw3mVZgOT8b0qNkAy4FwgtY9GPJ1bB+jJkuezk8OUdVlqL1rXuDLZFVYq6c
         ymurOzcaDQjO7drNcOGDXBalWfnVP1uUDgADDriflxlxNrPYNC9iA4EbgUon54yjx7tl
         oUmoWL0USTkVDE7Jubutc7R9ES5+hzV/33wpZAY0jH0rIdZ1I92dibgVuN9CO0YGVXlj
         jTddGGgDCRhnAZi5LbbRDsoZ7Mxx4OEJW8BuzxVUFgvR2Mm6CSD7rTPgnrQZBhq3ZhUg
         b9AZ7fDiTtwQUYH0fhQZDIZqw2Zs79XjzA4Im+vIwBG4imvcsbU0fB0m7j+pWRE2I4R/
         mXLg==
X-Gm-Message-State: AFuF++ktkiMc+3y1rbcZ6UTgbDkeoN2crlOsJIVuV1YTm3KQVD66L6yV
	rQ5FXJE3AmiRTptUBXmZyD01jglVAM5fEapr9Sn0ks4GLIGl4I2FSKOFj1UBFzUFMbTkrjMUWY/
	6UNT1rX0Oz6nryccaQnlJA/7gJmPMHsiXzlxY5i7yb5KnE1IsTt72ygu0+1+R+ljGMUg=
X-Gm-Gg: AYBFou0wHnt+VHFLNyKuUqQMwvamuXTVpgu7L0TANcE8RD4SVnGPA/TIV6145jTUUre
	aqsCVUZtC/yOFnDQpd5sm6uIPdoUISMSkEk9XBVi/V7IuVXK10icMG8NdjGc8x5IO9PGSPZBc5P
	U5IAWMXIkDmwrf5CgbyAokNGgXX3OjBNumneAuPjeriIU8bAGBO9bqGU3bawpFkKgglEf5Ec6nP
	Sd0LC6DXlkvFwCppoTlhIRpgRDq9INS2uaiqtvyoZpCaxFIbQUAgzTma+F9YrlgJoj1coeiLKx6
	7TUjrGWF2/Q+EceFqdvEuijlfVw10KChPUQ88Rzp4PN6S8z98mNeiODLy/gZ2xZmH65qzMMvuw1
	o0ozXgu/4yaeQUIuRTwgBL8bI88SI5pgYfu/r/dJkVzbRY46zapW2F1hoZ2qIXI6hppGrTPi/+j
	rt74P8ySpWCCY5Hbo+iW8A2ChJEtxxPmNExJ6JHrDUOOayqVLZJ/gi79dgss0qX4/SVJgJQRV4R
	BHYae06QUnv
X-Received: by 2002:a05:600c:4e46:b0:49e:642a:4f6f with SMTP id 5b1f17b1804b1-49fc585e9edmr139154845e9.33.1789986141352;
        Mon, 21 Sep 2026 03:22:21 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583fffsm20925476f8f.23.2026.09.21.03.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:22:20 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 03/11] ovpn: track UDP socket route key for peer dst cache
Date: Mon, 21 Sep 2026 12:22:04 +0200
Message-ID: <20260921102215.3599702-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921102215.3599702-1-antonio@openvpn.net>
References: <20260921102215.3599702-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

ovpn stores the route used to transmit UDP packets in a per-peer dst
cache. A cached dst is only valid for the route lookup inputs used when
it was resolved.

Some of those inputs are mutable while userspace still owns the UDP
socket. In particular, changes to the socket mark or UDP source port do
not invalidate ovpn's peer dst cache, so ovpn can keep using a route
selected with an old socket route key.

Replace the cached mark with a route key containing the socket-owned
lookup inputs currently used by ovpn, and reset the peer dst cache when
the key changes. Before storing a newly looked-up dst, recheck the route
key under the peer lock so a dst resolved for stale socket state is not
published.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c |  1 +
 drivers/net/ovpn/peer.h | 19 ++++++++-
 drivers/net/ovpn/udp.c  | 90 +++++++++++++++++++++++++++++++++++------
 3 files changed, 95 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c95656ca7c35..b400783c2efa 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -113,6 +113,7 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	RCU_INIT_POINTER(peer->bind, NULL);
 	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
+	seqcount_spinlock_init(&peer->route_key_seq, &peer->lock);
 	kref_init(&peer->refcount);
 	ovpn_peer_stats_init(&peer->vpn_stats);
 	ovpn_peer_stats_init(&peer->link_stats);
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index dfa5c0037e02..063535699ecd 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -10,6 +10,7 @@
 #ifndef _NET_OVPN_OVPNPEER_H_
 #define _NET_OVPN_OVPNPEER_H_
 
+#include <linux/seqlock.h>
 #include <net/dst_cache.h>
 #include <net/strparser.h>
 
@@ -17,6 +18,16 @@
 #include "socket.h"
 #include "stats.h"
 
+/**
+ * struct ovpn_route_key - route key used for the peer dst cache
+ * @mark: fwmark used for route lookup
+ * @sport: UDP source port used for route lookup
+ */
+struct ovpn_route_key {
+	u32 mark;
+	__be16 sport;
+};
+
 /**
  * struct ovpn_peer - the main remote peer object
  * @ovpn: main openvpn instance this peer belongs to
@@ -45,6 +56,8 @@
  * @tcp.sk_cb.ops: pointer to the original prot_ops object (TCP only)
  * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
+ * @route_key: route key matching the current dst cache contents
+ * @route_key_seq: seqcount protecting lockless route_key reads
  * @bind: remote peer binding
  * @keepalive_interval: seconds after which a new keepalive should be sent
  * @keepalive_xmit_exp: future timestamp when next keepalive should be sent
@@ -55,7 +68,7 @@
  * @vpn_stats: per-peer in-VPN TX/RX stats
  * @link_stats: per-peer link/transport TX/RX stats
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
- * @lock: protects binding to peer (bind) and keepalive* fields
+ * @lock: protects binding to peer (bind), route_key and keepalive* fields
  * @refcount: reference counter
  * @rcu: used to free peer in an RCU safe way
  * @release_entry: entry for the socket release list
@@ -99,6 +112,8 @@ struct ovpn_peer {
 	} tcp;
 	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
+	struct ovpn_route_key route_key;
+	seqcount_spinlock_t route_key_seq;
 	struct ovpn_bind __rcu *bind;
 	unsigned long keepalive_interval;
 	unsigned long keepalive_xmit_exp;
@@ -109,7 +124,7 @@ struct ovpn_peer {
 	struct ovpn_peer_stats vpn_stats;
 	struct ovpn_peer_stats link_stats;
 	enum ovpn_del_peer_reason delete_reason;
-	spinlock_t lock; /* protects bind  and keepalive* */
+	spinlock_t lock; /* protects bind, route_key and keepalive* */
 	struct kref refcount;
 	struct rcu_head rcu;
 	struct llist_node release_entry;
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index df4750dabd1e..c6d591cb7ff4 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -131,6 +131,48 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
+static bool ovpn_route_key_equal(const struct ovpn_route_key *a,
+				 const struct ovpn_route_key *b)
+{
+	return a->mark == b->mark && a->sport == b->sport;
+}
+
+/**
+ * ovpn_dst_cache_check_key - reset peer dst cache after key changes
+ * @peer: the peer owning the dst cache
+ * @cache: the cache that might need to be reset
+ * @key: the route key for the packet being transmitted
+ *
+ * Reset the peer dst cache if it was populated for a different route key.
+ */
+static void ovpn_dst_cache_check_key(struct ovpn_peer *peer,
+				     struct dst_cache *cache,
+				     const struct ovpn_route_key *key)
+{
+	struct ovpn_route_key old_key;
+	unsigned int seq;
+
+	/* snapshot the saved key before deciding whether the cache matches */
+	do {
+		seq = read_seqcount_begin(&peer->route_key_seq);
+		old_key = peer->route_key;
+	} while (read_seqcount_retry(&peer->route_key_seq, seq));
+
+	/* nothing changed: the current cache can be reused */
+	if (likely(ovpn_route_key_equal(&old_key, key)))
+		return;
+
+	/* recheck under lock because another path may have updated the key */
+	spin_lock_bh(&peer->lock);
+	if (!ovpn_route_key_equal(&peer->route_key, key)) {
+		write_seqcount_begin(&peer->route_key_seq);
+		peer->route_key = *key;
+		dst_cache_reset(cache);
+		write_seqcount_end(&peer->route_key_seq);
+	}
+	spin_unlock_bh(&peer->lock);
+}
+
 /**
  * ovpn_udp4_output - send IPv4 packet over udp socket
  * @peer: the destination peer
@@ -138,21 +180,23 @@ static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
  * @cache: dst cache
  * @sk: the socket to send the packet over
  * @skb: the packet to send
+ * @key: the route key snapshot used for cache validation and flow lookup
  *
  * Return: 0 on success or a negative error code otherwise
  */
 static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 			    struct dst_cache *cache, struct sock *sk,
-			    struct sk_buff *skb)
+			    struct sk_buff *skb,
+			    const struct ovpn_route_key *key)
 {
 	struct rtable *rt;
 	struct flowi4 fl = {
 		.saddr = bind->local.ipv4.s_addr,
 		.daddr = bind->remote.in4.sin_addr.s_addr,
-		.fl4_sport = inet_sk(sk)->inet_sport,
+		.fl4_sport = key->sport,
 		.fl4_dport = bind->remote.in4.sin_port,
 		.flowi4_proto = sk->sk_protocol,
-		.flowi4_mark = sk->sk_mark,
+		.flowi4_mark = key->mark,
 	};
 	int ret;
 
@@ -193,7 +237,12 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    ret);
 		goto err;
 	}
-	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+
+	/* avoid storing a stale cache */
+	spin_lock_bh(&peer->lock);
+	if (likely(ovpn_route_key_equal(key, &peer->route_key)))
+		dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+	spin_unlock_bh(&peer->lock);
 
 transmit:
 	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
@@ -213,12 +262,14 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
  * @cache: dst cache
  * @sk: the socket to send the packet over
  * @skb: the packet to send
+ * @key: the route key snapshot used for cache validation and flow lookup
  *
  * Return: 0 on success or a negative error code otherwise
  */
 static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 			    struct dst_cache *cache, struct sock *sk,
-			    struct sk_buff *skb)
+			    struct sk_buff *skb,
+			    const struct ovpn_route_key *key)
 {
 	struct dst_entry *dst;
 	int ret;
@@ -226,10 +277,10 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	struct flowi6 fl = {
 		.saddr = bind->local.ipv6,
 		.daddr = bind->remote.in6.sin6_addr,
-		.fl6_sport = inet_sk(sk)->inet_sport,
+		.fl6_sport = key->sport,
 		.fl6_dport = bind->remote.in6.sin6_port,
 		.flowi6_proto = sk->sk_protocol,
-		.flowi6_mark = sk->sk_mark,
+		.flowi6_mark = key->mark,
 		.flowi6_oif = bind->remote.in6.sin6_scope_id,
 	};
 
@@ -259,7 +310,12 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    &bind->remote.in6, ret);
 		goto err;
 	}
-	dst_cache_set_ip6(cache, dst, &fl.saddr);
+
+	/* avoid storing a stale cache */
+	spin_lock_bh(&peer->lock);
+	if (likely(ovpn_route_key_equal(key, &peer->route_key)))
+		dst_cache_set_ip6(cache, dst, &fl.saddr);
+	spin_unlock_bh(&peer->lock);
 
 transmit:
 	/* user IPv6 packets may be larger than the transport interface
@@ -288,6 +344,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
  * @cache: dst cache
  * @sk: the socket to send the packet over
  * @skb: the packet to send
+ * @key: route key snapshot used for cache validation and flow lookup
  *
  * rcu_read_lock should be held on entry.
  * On return, the skb is consumed.
@@ -295,7 +352,8 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
  * Return: 0 on success or a negative error code otherwise
  */
 static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
-			   struct sock *sk, struct sk_buff *skb)
+			   struct sock *sk, struct sk_buff *skb,
+			   struct ovpn_route_key *key)
 {
 	struct ovpn_bind *bind;
 	int ret;
@@ -315,11 +373,11 @@ static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
 
 	switch (bind->remote.in4.sin_family) {
 	case AF_INET:
-		ret = ovpn_udp4_output(peer, bind, cache, sk, skb);
+		ret = ovpn_udp4_output(peer, bind, cache, sk, skb, key);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
-		ret = ovpn_udp6_output(peer, bind, cache, sk, skb);
+		ret = ovpn_udp6_output(peer, bind, cache, sk, skb, key);
 		break;
 #endif
 	default:
@@ -341,15 +399,21 @@ static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
 void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 		       struct sk_buff *skb)
 {
+	struct ovpn_route_key key = {
+		.mark = READ_ONCE(sk->sk_mark),
+		.sport = READ_ONCE(inet_sk(sk)->inet_sport),
+	};
 	int ret;
 
 	skb->dev = peer->ovpn->dev;
-	skb->mark = READ_ONCE(sk->sk_mark);
+	skb->mark = key.mark;
 	/* no checksum performed at this layer */
 	skb->ip_summed = CHECKSUM_NONE;
 
+	ovpn_dst_cache_check_key(peer, &peer->dst_cache, &key);
+
 	/* crypto layer -> transport (UDP) */
-	ret = ovpn_udp_output(peer, &peer->dst_cache, sk, skb);
+	ret = ovpn_udp_output(peer, &peer->dst_cache, sk, skb, &key);
 	if (unlikely(ret < 0))
 		kfree_skb(skb);
 }
-- 
2.55.0

