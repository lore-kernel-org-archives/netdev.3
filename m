Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BD748F02F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810006; cv=none; b=pMYf+ioSoxJEuG+98t7U8l7bQVSukO6HsYA0gWGsNSScb3bixh4xDU7nTwXEGlmSbZv41RvoBG28GcnS4+O1dAzxj8Ho8wgTbN0dafdn6eONOJh7U1UGeil58+gKTNBwslWuDhGMPd/x99LGoNVmWl2COdwtceVYndmD4hJ8Z+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810006; c=relaxed/simple;
	bh=oIcEZ1SkiebrhuuZOuIWrbMB/sI2KSX9RW0eEwofPzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wbla3MJ+oS/YpjJvrvQ5uLbfgE+OBaMM7gJWq+erqCNLC9/p/VhLaxMisNirGKmVdIfIQh5udrTyfLv2x4X0nL+TajuBaRyj1KqeJdRARzx/fiuWEdR/JMVMec+CUMxdxym98uKIlZ1QtmfQkqcCRc83k6J+UcxvWc5x9OGOSyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=f/MNvuMa; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="f/MNvuMa"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35b2c599f43so1307156eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791809999; x=1792414799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2EwgVNrzisfcCRTS0RsMD1mVu3fWoNM4dHps1dquGOY=;
        b=f/MNvuMaehW0RFPjK669wmkwLal1cJeS+fY14pj3i751QG7ThH6dbqtF3VQ6DpPezt
         +Ga8VkNzRRsUn7AfSvYvTu4bRwu49mFQQGyFTCY6gxUrs+TtdaJ1TzHSF6fSKVrhLZ75
         x1JzoHZJoGW8KZ37h/1vr4rWUoUg7bnl7fgSL+2ouZwWwuDkYDnJhyuZtalylHzBDdva
         /dVNKOWMOcKlV/tHbi00Ec8AT/O3pvqeTLDql0m9bzOxBjCvGMHb4xV+MR/PdHqoWFIH
         2gwaRH+GENWAuljBw5oD0xXl981yA9V+3Qdvv1ZY7VTlT6AOFOQPdp4gwFxxNpOjBz89
         rW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791809999; x=1792414799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2EwgVNrzisfcCRTS0RsMD1mVu3fWoNM4dHps1dquGOY=;
        b=ZOsqPi95S5mPd459rnDoiIB9F8GbuERHoQmBPbV2/mZY2yyxBO2R+ZBKgscNCTNjg0
         T9xx4LMKzeZJ8mAxidqN5N3YqOwHdeaCzHlBLcEsK1H20npDxWxC9p3luteqaBEKftRh
         EtUeJOoim6PUwFDTyliV9JR0aRSV/vz0sMnkZCym5sBezcC8p1zhNwhTiS1wY2FBSjsR
         HG0C6FkDqEQixCnm+eLDRYois+3HGbx7OFmZ6xgKhH2BI2xngGy4gMYKVAaaQVt8405g
         qpu3uIl3bAogKpbaIVNwJMyj1Dw4qf8LcWsoJBdbvl2pPk1PdN1qHFrf5zmNtEwdSExY
         Fjlg==
X-Gm-Message-State: AFq9FYLKlHkmF6ciRm8FEPPEbOhR93+Jkau69r8TCgDKL/HOa8Yh5Mx0
	g9myHiNkyBG1MWL35Hm4Th73lWThju9hC9hS+kfQADvcccWIUBJ1J+Nrf/xFBofIxVE=
X-Gm-Gg: AYBFou0JFeATSqx1GghMTtlFK2UhPYKc/CgeoFSOH79ey04QkD3NhBZEw1JPvhVJT2q
	XuFyjxyZPB85HxJ016fnQJDplf/5eNMIEhu6QqFyDWbc0Vx0eAnGsQ8TaAhRWVHEHcQhUyoam65
	UBLAKRRVo8oiPx/f7aF2tmN82h53X9B6BJVxPW+d/1gg/5RjJDQNKquMxkmvPQonfuBNi6sRoLx
	3fpFlnL7q3L0Guy02AOzBOvIO30lHndGNDSbgWhdWcxtu4VYx87Wp1grS70lJX7KSeQkV7yE1cD
	ZIpFule9dqZMCLFoi9KzCXnB5vVo3UNJA/HgKq00Ko1smY5mnMgWTH4LhPX47oerIpZ6ZEVBGlr
	diyf30U4I2Zn8OeEupdXM7jvY1TkcOeDpc80+0VdQjuZEcO+Cjxg6fbz2SxisOXCG5otsqYu9MY
	jEiOpq4piAISV28yE7GTXZ4KBPplDiIN3wQVhVpnD/OZUlnIiv1veBDWEiRRcBqncZe1kRTd0Xc
	XSn2J3FDNzjmLlpyVUD8jXw0SKyRqgjy2QwQmrl+BcP09dMjwGHZFOZ8b+L3NU=
X-Received: by 2002:a05:7300:f405:b0:35b:954b:b9d6 with SMTP id 5a478bee46e88-35b954bbebfmr1137856eec.12.1791809998585;
        Mon, 12 Oct 2026 05:59:58 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb61asm35348067eec.21.2026.10.12.05.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:59:57 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v3 6/6] amt: do not create tunnel state for unauthenticated Requests
Date: Mon, 12 Oct 2026 12:59:43 +0000
Message-ID: <20261012125943.558629-7-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012125943.558629-1-omar@blockcast.net>
References: <20261012125943.558629-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amt_request_handler() allocated a struct amt_tunnel_list for any incoming
Relay Membership Request, keyed on the claimed source endpoint, before
anything about that source had been verified. A Request is a bare UDP
datagram with a trivially spoofable source address, so this gave a remote
attacker two primitives:

 - Resource exhaustion. Each entry is held for amt_gmi() (260s with the
   default qrv=2/qi=125/qri=10) and the table is bounded by
   amt->max_tunnels (default AMT_MAX_TUNNELS, 128). Requests from 128
   spoofed addresses fill the table, and re-sending once per interval
   keeps it full, so real gateways are refused. Once full, every further
   Request also emitted an ICMP_DEST_UNREACH to the spoofed source,
   turning the relay into an ICMP reflector.

 - Session desynchronisation. The lookup hit at the top of the function
   jumped to the send path, which took no lock and overwrote ->nonce and
   ->mac of an already-established tunnel. One spoofed packet carrying a
   known gateway's source endpoint invalidates that gateway's outstanding
   (nonce, response_mac), so its next Membership Update is dropped as
   "Invalid MAC". This costs one packet, consumes no table slot, and is
   therefore unaffected by max_tunnels tuning.

No state actually has to be created at Request time. Every input to the
keyed MAC is carried in the packet or is device state, so the MAC can be
generated on Request and recomputed on Update rather than stored:

 - amt_request_handler() now allocates nothing. It computes the MAC and
   replies, matching amt_send_advertisement(), which already answers
   Discovery statelessly from the same context.
 - amt_update_handler() recomputes the expected MAC from the packet's
   source address, source port and nonce and drops the packet on
   mismatch. Tunnel state is created only after that check passes, in
   amt_tunnel_get_or_create(), so max_tunnels now bounds verified
   gateways rather than unverified Requests.
 - amt->key becomes a three-element array. amt_secret_work() rotates
   every AMT_SECRET_TIMEOUT (60s) and an exchange may straddle a
   rotation, so Update accepts the current or either of the two previous
   secrets. Three generations keep a MAC valid for 120-180s, at least the
   amt_gmi() the Query advertised; two generations (120s floor) could
   expire a MAC before the interval it promised. A stateless recompute
   cannot snapshot the key per tunnel the way the old code did.

Fold in four further issues on the same path:

 - Per-source exhaustion. With the table now bounded by verified
   gateways, one verified source could still take every slot. The locked
   re-check in amt_tunnel_get_or_create() counts the tunnels a source
   already holds and refuses past a fixed internal cap
   (AMT_MAX_TUNNELS_PER_SRC). This needs no UAPI, so it is a backportable
   fix; a configurable per-source bound is left to net-next.
 - Table-full killed rediscovery. A Request that arrives when the table
   is full, from a source that holds no tunnel, is now refused with ICMP
   and no Query, rather than answered with a Query whose later Update
   cannot be admitted. Withholding the Query lets the gateway's req_cnt
   climb and drive rediscovery. The ICMP is rate-limited and allocates
   nothing, unlike the old reflector. A source that holds a tunnel is
   still answered, as before: its periodic Request renews the response
   MAC its Updates echo.
 - Zero-key window at open. amt_dev_open() seeded amt->key only after
   amt_socket_create() had already enabled the encap receive path, so a
   Request arriving in that window was answered with a MAC keyed on the
   all-zero (predictable) secret. Seed the keys under amt->lock before
   the socket is created.
 - The entry was published by list_add_tail_rcu() before ->nonce and
   ->mac were assigned, leaving a window in which a concurrent Update
   could match the zeroed fields of a kzalloc()'d entry; and the send
   path read tunnel->key into an unused local before it was initialised.
   Both go away now that nothing is published until it is fully built.

The General Query is passed its destination by value rather than a tunnel
pointer, because at Request time no tunnel exists to point at.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 310 ++++++++++++++++++++++++++++++++--------------
 include/net/amt.h |  17 ++-
 2 files changed, 228 insertions(+), 99 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index fec3265..2d9f2d9 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -784,11 +784,16 @@ out:
 
 static bool amt_send_membership_query(struct amt_dev *amt,
 				      struct sk_buff *skb,
-				      struct amt_tunnel_list *tunnel,
+				      __be32 daddr, __be16 dport,
+				      __be32 nonce, u64 mac,
 				      bool v6);
 
-static void amt_send_igmp_gq(struct amt_dev *amt,
-			     struct amt_tunnel_list *tunnel)
+/* The destination is passed by value rather than as a tunnel: the requesting
+ * source is not authenticated yet and no tunnel state exists for it - see
+ * amt_request_handler().
+ */
+static void amt_send_igmp_gq(struct amt_dev *amt, __be32 daddr, __be16 dport,
+			     __be32 nonce, u64 mac)
 {
 	struct sk_buff *skb;
 
@@ -797,7 +802,8 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
 		return;
 
 	skb_pull(skb, sizeof(struct ethhdr));
-	if (amt_send_membership_query(amt, skb, tunnel, false)) {
+	if (amt_send_membership_query(amt, skb, daddr, dport, nonce, mac,
+				      false)) {
 		amt->dev->stats.tx_dropped++;
 		kfree_skb(skb);
 	}
@@ -876,7 +882,8 @@ static struct sk_buff *amt_build_mld_gq(struct amt_dev *amt)
 	return skb;
 }
 
-static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
+static void amt_send_mld_gq(struct amt_dev *amt, __be32 daddr, __be16 dport,
+			    __be32 nonce, u64 mac)
 {
 	struct sk_buff *skb;
 
@@ -885,13 +892,15 @@ static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
 		return;
 
 	skb_pull(skb, sizeof(struct ethhdr));
-	if (amt_send_membership_query(amt, skb, tunnel, true)) {
+	if (amt_send_membership_query(amt, skb, daddr, dport, nonce, mac,
+				      true)) {
 		amt->dev->stats.tx_dropped++;
 		kfree_skb(skb);
 	}
 }
 #else
-static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
+static void amt_send_mld_gq(struct amt_dev *amt, __be32 daddr, __be16 dport,
+			    __be32 nonce, u64 mac)
 {
 }
 #endif
@@ -925,7 +934,13 @@ static void amt_secret_work(struct work_struct *work)
 					   secret_wq);
 
 	spin_lock_bh(&amt->lock);
-	get_random_bytes(&amt->key, sizeof(siphash_key_t));
+	/* Rotate: keep the two previous generations so a MAC handed out just
+	 * before a rotation still verifies for up to three AMT_SECRET_TIMEOUT
+	 * windows (120-180s), covering the amt_gmi() the Query advertised.
+	 */
+	amt->key[2] = amt->key[1];
+	amt->key[1] = amt->key[0];
+	get_random_bytes(&amt->key[0], sizeof(siphash_key_t));
 	spin_unlock_bh(&amt->lock);
 	mod_delayed_work(amt_wq, &amt->secret_wq,
 			 msecs_to_jiffies(AMT_SECRET_TIMEOUT));
@@ -1115,9 +1130,16 @@ static void amt_send_multicast_data(struct amt_dev *amt,
 			    0);
 }
 
+/* Send a Membership Query to a source that has not been authenticated yet.
+ *
+ * No per-source state exists at this point and none is created: the nonce and
+ * the keyed MAC are carried in the Query and recomputed from the Membership
+ * Update when it comes back, so everything this needs is passed by value.
+ */
 static bool amt_send_membership_query(struct amt_dev *amt,
 				      struct sk_buff *skb,
-				      struct amt_tunnel_list *tunnel,
+				      __be32 daddr, __be16 dport,
+				      __be32 nonce, u64 mac,
 				      bool v6)
 {
 	struct amt_header_membership_query *amtmq;
@@ -1138,13 +1160,13 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 	skb_reset_inner_headers(skb);
 	memset(&fl4, 0, sizeof(struct flowi4));
 	fl4.flowi4_oif         = amt->stream_dev->ifindex;
-	fl4.daddr              = tunnel->ip4;
+	fl4.daddr              = daddr;
 	fl4.saddr              = amt->local_ip;
 	fl4.flowi4_dscp        = inet_dsfield_to_dscp(AMT_TOS);
 	fl4.flowi4_proto       = IPPROTO_UDP;
 	rt = ip_route_output_key(amt->net, &fl4);
 	if (IS_ERR(rt)) {
-		netdev_dbg(amt->dev, "no route to %pI4\n", &tunnel->ip4);
+		netdev_dbg(amt->dev, "no route to %pI4\n", &daddr);
 		return true;
 	}
 
@@ -1154,8 +1176,8 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 	amtmq->reserved = 0;
 	amtmq->l	= 0;
 	amtmq->g	= 0;
-	amtmq->nonce	= tunnel->nonce;
-	amtmq->response_mac = tunnel->mac;
+	amtmq->nonce	= nonce;
+	amtmq->response_mac = mac;
 
 	if (!v6)
 		skb_set_inner_protocol(skb, htons(ETH_P_IP));
@@ -1168,11 +1190,10 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 			    ip4_dst_hoplimit(&rt->dst),
 			    0,
 			    amt->relay_port,
-			    tunnel->source_port,
+			    dport,
 			    false,
 			    false,
 			    0);
-	amt_update_relay_status(tunnel, AMT_STATUS_SENT_QUERY, true);
 	return false;
 }
 
@@ -2490,14 +2511,99 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	return false;
 }
 
+/* The tunnel of the gateway endpoint @saddr:@sport, or NULL. */
+static struct amt_tunnel_list *amt_tunnel_lookup(struct amt_dev *amt,
+						 __be32 saddr, __be16 sport)
+{
+	struct amt_tunnel_list *tunnel;
+
+	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
+		if (tunnel->ip4 == saddr && tunnel->source_port == sport)
+			return tunnel;
+	return NULL;
+}
+
+/* Look up the tunnel for a source whose Membership Update has already been
+ * authenticated, creating it on first contact.
+ *
+ * This is now the only place tunnel state is allocated, so amt->max_tunnels
+ * bounds the number of *verified* gateways rather than the number of
+ * unverified Requests anyone can send.  A fixed per-source cap additionally
+ * stops one verified endpoint from monopolising the table; a single gateway
+ * needs at most one tunnel per family (RFC 7450 s4.2.2).
+ */
+static struct amt_tunnel_list *amt_tunnel_get_or_create(struct amt_dev *amt,
+							__be32 saddr,
+							__be16 sport)
+{
+	struct amt_tunnel_list *tunnel;
+	int per_src = 0;
+	int i;
+
+	tunnel = amt_tunnel_lookup(amt, saddr, sport);
+	if (tunnel)
+		return tunnel;
+
+	spin_lock_bh(&amt->lock);
+
+	/* Re-check under the lock in case a concurrent Update won the race, and
+	 * count how many tunnels this source already holds on the same walk.
+	 */
+	list_for_each_entry(tunnel, &amt->tunnel_list, list) {
+		if (tunnel->ip4 != saddr)
+			continue;
+		if (tunnel->source_port == sport) {
+			spin_unlock_bh(&amt->lock);
+			return tunnel;
+		}
+		per_src++;
+	}
+
+	if (amt->nr_tunnels >= amt->max_tunnels ||
+	    per_src >= AMT_MAX_TUNNELS_PER_SRC) {
+		spin_unlock_bh(&amt->lock);
+		return NULL;
+	}
+
+	tunnel = kzalloc(sizeof(*tunnel) +
+			 (sizeof(struct hlist_head) * amt->hash_buckets),
+			 GFP_ATOMIC);
+	if (!tunnel) {
+		spin_unlock_bh(&amt->lock);
+		return NULL;
+	}
+
+	tunnel->source_port = sport;
+	tunnel->ip4 = saddr;
+	tunnel->amt = amt;
+	spin_lock_init(&tunnel->lock);
+	for (i = 0; i < amt->hash_buckets; i++)
+		INIT_HLIST_HEAD(&tunnel->groups[i]);
+
+	tunnel->last_seen = jiffies;
+	INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
+	__amt_update_relay_status(tunnel, AMT_STATUS_RECEIVED_UPDATE, false);
+
+	/* Publish only once the entry is fully initialised. */
+	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
+	amt->nr_tunnels++;
+	mod_delayed_work(amt_wq, &tunnel->gc_wq,
+			 msecs_to_jiffies(amt_gmi(amt)) * 3);
+	spin_unlock_bh(&amt->lock);
+
+	return tunnel;
+}
+
 static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 {
 	struct amt_header_membership_update *amtmu;
 	struct amt_tunnel_list *tunnel;
 	struct ethhdr *eth;
 	struct iphdr *iph;
-	int len, hdr_size;
+	siphash_key_t key[3];
+	int len, hdr_size, i;
 	u64 response_mac;
+	bool verified = false;
 	__be32 saddr;
 	__be32 nonce;
 	__be16 sport;
@@ -2517,33 +2623,57 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	/* Snapshot the tunnel endpoint port before the encap is stripped. */
 	sport = udp_hdr(skb)->source;
 
-	if (iptunnel_pull_header(skb, hdr_size, skb->protocol, false))
-		return true;
+	/* Recompute the MAC handed out in the Membership Query rather than
+	 * comparing against a stored copy.  All three live secrets are accepted
+	 * so an exchange straddling one or two rotations by amt_secret_work() is
+	 * not spuriously rejected (three generations cover 120-180s, at least
+	 * the amt_gmi() the Query advertised).  This runs before the packet is
+	 * decapsulated and before any tunnel state is looked up or created, so
+	 * an unverified source is rejected with no further work.
+	 */
+	spin_lock_bh(&amt->lock);
+	for (i = 0; i < ARRAY_SIZE(key); i++)
+		key[i] = amt->key[i];
+	spin_unlock_bh(&amt->lock);
 
-	skb_reset_network_header(skb);
+	for (i = 0; i < ARRAY_SIZE(key); i++) {
+		u64 mac = siphash_3u32((__force u32)saddr,
+				       (__force u32)sport,
+				       (__force u32)nonce,
+				       &key[i]) >> 16;
 
-	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
-		if (tunnel->ip4 == saddr &&
-		    tunnel->source_port == sport) {
-			if ((nonce == tunnel->nonce &&
-			     response_mac == tunnel->mac)) {
-				/* Refresh liveness only.  gc_wq is re-armed by
-				 * amt_tunnel_expire() itself from last_seen, never
-				 * from here, so this cannot re-queue the work of a
-				 * tunnel that is being freed.
-				 */
-				WRITE_ONCE(tunnel->last_seen, jiffies);
-				goto report;
-			} else {
-				netdev_dbg(amt->dev, "Invalid MAC\n");
-				return true;
-			}
+		if (response_mac == mac) {
+			verified = true;
+			break;
 		}
 	}
 
-	return true;
+	if (!verified) {
+		netdev_dbg(amt->dev, "Invalid MAC\n");
+		return true;
+	}
+
+	tunnel = amt_tunnel_get_or_create(amt, saddr, sport);
+	if (!tunnel) {
+		/* Out of tunnel slots.  Unlike the Request path this reply only
+		 * ever goes to a source that proved it received our Query, so it
+		 * cannot be used to reflect at a spoofed third party.
+		 */
+		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0);
+		return true;
+	}
+
+	/* Refresh liveness only.  gc_wq is re-armed by amt_tunnel_expire()
+	 * itself from last_seen, never from here, so this cannot re-queue the
+	 * work of a tunnel that is being freed.
+	 */
+	WRITE_ONCE(tunnel->last_seen, jiffies);
+
+	if (iptunnel_pull_header(skb, hdr_size, skb->protocol, false))
+		return true;
+
+	skb_reset_network_header(skb);
 
-report:
 	if (!pskb_may_pull(skb, sizeof(*iph)))
 		return true;
 
@@ -2720,15 +2850,27 @@ static bool amt_discovery_handler(struct amt_dev *amt, struct sk_buff *skb)
 	return false;
 }
 
+/* Handle an AMT Relay Membership Request.
+ *
+ * The source of a Request is unauthenticated: it is a bare UDP datagram with a
+ * trivially spoofable source address.  Allocating tunnel state here let an
+ * attacker fill the table from spoofed addresses, and let one spoofed packet
+ * overwrite the nonce/MAC of an established tunnel and cut that gateway off.
+ *
+ * Nothing needs to be remembered at this point.  Every input to the keyed MAC
+ * is carried in the packet or is device state, so the MAC is generated here,
+ * echoed back by the gateway in its Membership Update, and recomputed and
+ * verified there - see amt_update_handler().  Tunnel state is created only once
+ * that verification succeeds.
+ */
 static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
 {
 	struct amt_header_request *amtrh;
-	struct amt_tunnel_list *tunnel;
-	unsigned long long key;
 	struct udphdr *udph;
 	struct iphdr *iph;
+	siphash_key_t key;
+	bool full;
 	u64 mac;
-	int i;
 
 	if (!pskb_may_pull(skb, sizeof(*udph) + sizeof(*amtrh)))
 		return true;
@@ -2740,67 +2882,42 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
 	if (amtrh->reserved1 || amtrh->reserved2 || amtrh->version)
 		return true;
 
-	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
-		if (tunnel->ip4 == iph->saddr &&
-		    tunnel->source_port == udph->source)
-			goto send;
-
-	spin_lock_bh(&amt->lock);
-	if (amt->nr_tunnels >= amt->max_tunnels) {
-		spin_unlock_bh(&amt->lock);
-		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0);
-		return true;
-	}
-
-	tunnel = kzalloc(sizeof(*tunnel) +
-			 (sizeof(struct hlist_head) * amt->hash_buckets),
-			 GFP_ATOMIC);
-	if (!tunnel) {
-		spin_unlock_bh(&amt->lock);
+	if (!netif_running(amt->dev) || !netif_running(amt->stream_dev))
 		return true;
-	}
 
-	tunnel->source_port = udph->source;
-	tunnel->ip4 = iph->saddr;
-
-	memcpy(&key, &tunnel->key, sizeof(unsigned long long));
-	tunnel->amt = amt;
-	spin_lock_init(&tunnel->lock);
-	for (i = 0; i < amt->hash_buckets; i++)
-		INIT_HLIST_HEAD(&tunnel->groups[i]);
-
-	tunnel->last_seen = jiffies;
-	INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
-
-	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
-	tunnel->key = amt->key;
-	__amt_update_relay_status(tunnel, AMT_STATUS_RECEIVED_REQUEST, true);
-	amt->nr_tunnels++;
-	mod_delayed_work(amt_wq, &tunnel->gc_wq,
-			 msecs_to_jiffies(amt_gmi(amt)));
+	/* No state is created for a Request (see amt_update_handler()); read the
+	 * current secret and the table occupancy together under the lock.
+	 */
+	spin_lock_bh(&amt->lock);
+	key = amt->key[0];
+	full = amt->nr_tunnels >= amt->max_tunnels;
 	spin_unlock_bh(&amt->lock);
 
-send:
-	/* source_port is part of the tunnel's identity and is set once, in
-	 * the allocation path above; the lookup only reaches here on an exact
-	 * (address, port) match, so it already equals udph->source.  Do not
-	 * "refresh" it here: doing so let a colliding Request from a new port
-	 * steal an established tunnel outright.
+	/* When the table is full, refuse a source that holds no tunnel without
+	 * sending a Query.  A silent Query would keep the gateway believing the
+	 * exchange is progressing while its later, verified Update is refused;
+	 * withholding it lets the gateway's req_cnt climb and drive rediscovery
+	 * instead.  The ICMP is rate-limited and no state is allocated, so this
+	 * is not the reflector the pre-verification allocation path used to be.
+	 * A source that holds a tunnel is answered: its periodic Request is how
+	 * it renews the response MAC its Updates echo.
 	 */
-	tunnel->nonce = amtrh->nonce;
-	mac = siphash_3u32((__force u32)tunnel->ip4,
-			   (__force u32)tunnel->source_port,
-			   (__force u32)tunnel->nonce,
-			   &tunnel->key);
-	tunnel->mac = mac >> 16;
-
-	if (!netif_running(amt->dev) || !netif_running(amt->stream_dev))
+	if (full && !amt_tunnel_lookup(amt, iph->saddr, udph->source)) {
+		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0);
 		return true;
+	}
+
+	mac = siphash_3u32((__force u32)iph->saddr,
+			   (__force u32)udph->source,
+			   (__force u32)amtrh->nonce,
+			   &key) >> 16;
 
 	if (!amtrh->p)
-		amt_send_igmp_gq(amt, tunnel);
+		amt_send_igmp_gq(amt, iph->saddr, udph->source, amtrh->nonce,
+				 mac);
 	else
-		amt_send_mld_gq(amt, tunnel);
+		amt_send_mld_gq(amt, iph->saddr, udph->source, amtrh->nonce,
+				mac);
 
 	return false;
 }
@@ -3068,6 +3185,14 @@ static int amt_dev_open(struct net_device *dev)
 	enable_delayed_work(&amt->discovery_wq);
 	enable_delayed_work(&amt->req_wq);
 
+	/* Seed the keys before amt_socket_create() enables the encap receive
+	 * path, so a Request or Update that arrives immediately is never
+	 * verified against an all-zero (predictable) secret.
+	 */
+	spin_lock_bh(&amt->lock);
+	get_random_bytes(&amt->key, sizeof(amt->key));
+	spin_unlock_bh(&amt->lock);
+
 	err = amt_socket_create(amt);
 	if (err) {
 		disable_delayed_work(&amt->req_wq);
@@ -3078,7 +3203,6 @@ static int amt_dev_open(struct net_device *dev)
 	amt->req_cnt = 0;
 	WRITE_ONCE(amt->remote_ip, 0);
 	amt->nonce = 0;
-	get_random_bytes(&amt->key, sizeof(siphash_key_t));
 
 	amt->status = AMT_STATUS_INIT;
 	if (amt->mode == AMT_MODE_GATEWAY) {
diff --git a/include/net/amt.h b/include/net/amt.h
index 0520121..1c7c144 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -253,10 +253,6 @@ struct amt_tunnel_list {
 	bool			dead;
 	__be16			source_port;
 	__be32			ip4;
-	__be32			nonce;
-	siphash_key_t		key;
-	u64			mac:48,
-				reserved:16;
 	struct rcu_head		rcu;
 	struct hlist_head	groups[];
 };
@@ -336,8 +332,11 @@ struct amt_dev {
 	struct work_struct	event_wq;
 	/* AMT status */
 	enum amt_status		status;
-	/* Generated key */
-	siphash_key_t		key;
+	/* Generated keys.  key[0] is current; key[1] and key[2] are the two
+	 * previous generations, kept so a Request/Update exchange straddling
+	 * one or two secret rotations still verifies (see amt_secret_work()).
+	 */
+	siphash_key_t		key[3];
 	struct sock	  __rcu *sk;
 	u32			max_groups;
 	u32			max_sources;
@@ -394,6 +393,12 @@ struct amt_dev {
 #define AMT_SECRET_TIMEOUT	60000
 #define IANA_AMT_UDP_PORT	2268
 #define AMT_MAX_TUNNELS         128
+/* Per-source tunnel cap.  A single gateway needs at most one tunnel per
+ * family; this stops one verified source endpoint from monopolising the
+ * AMT_MAX_TUNNELS-slot table.  Deployments that legitimately need more behind
+ * one address (e.g. CGNAT) use the configurable net-next per-source bound.
+ */
+#define AMT_MAX_TUNNELS_PER_SRC 16
 #define AMT_MAX_REQS		128
 #define AMT_GW_HLEN (sizeof(struct iphdr) + \
 		     sizeof(struct udphdr) + \
-- 
2.43.0

