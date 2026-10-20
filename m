Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455968;
	b=kutkDpNa/75GrJFoNzue0PoasodqMYspzhcnV1HL7m0Zp/8QAif2gWJNk05wI+/qVT6A
	 w3hv/kjqbhJvIVOX4ZoV5jH7ZPaCWq4qzX7CnHomJ8ft+LSA+VzZ99TzkwRL1y/6gTM5Y
	 wjkOv0naIVMbFS1FBjfQnHZleXfvYYyZQRLmd4bGIJofz0nRfLQQwTdpwt0ONUP+LRgWk
	 6T2YSzsuOTW8b8N4fu7F2X0E5ChIsdtw6nEG5X68w4noEo8OR/GHSMHecDy4R+1eI9ENt
	 kI/QCrje8NSl7tqs2XOc5JL9tlCD339YJl2wK6kPIyXS0dUglbZ8FLH8QzrPmA3EkTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hrx76pmYceW8g0ndIN//rLD8UMKaYLXy40z7bwSNvMk=;
	b=V+v5M8M/bYVEd8yvomdUsmWPRV8xAu8lpUoX3b9zWrW2wK5dq477o2fWzgkqjpSRTzl6
	 SWIU893O3zO1+YV/0fXpvV8SJnjWjydBxZrw0VRqnDrANMvBRJCMHaeqVBexyyorC4yRa
	 xWH767u3xvvcs7oWiPD3VLQwCh+5VxETBaWT+RNxhRv3tYxFNXe2NsYJm3Nl047udJz4d
	 9bY3wviCpqwD39RvzYtD/t8QNaR603Szik88omePkIyLhmU9b9PxcrjK+0K5z2/r5BIgw
	 KWEjCLCQjrq8SDOoI6dtXX7XAo50SJJcopE/l0oPD/kEeoUIZUm36c1eKtyGCfmyeIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=B+ZVkpHx;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93955606A324
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93955606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=B+ZVkpHx
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso6510776eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1792455967; x=1793060767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hrx76pmYceW8g0ndIN//rLD8UMKaYLXy40z7bwSNvMk=;
        b=B+ZVkpHxQyS24RTRThwVSHE0b3lqmiGbH3K+aRPSO0z7vTBgoshbRsYHnPh4GBfM4v
         rLwnI2UtAseqmI0pI1v0u5CeKqDLVHIu7JptNB5Cg2OGJczc94sFb3EyvfgUNGf67oL3
         x9k2usIEeEl18CdBWS56qe21+VucxqckxrD3CFbWjifllDQZS6xFmodUP+GqtQwqFhKL
         r9mKe6Pvf1rIySF8lgEv2jN9KxeZh+qAFbHzQ2fgIFYkjVihrjPNbENDM939Fw3yYmcp
         7I1DdzplRAweR78toDczx/aKS6apQxce3lk6gwffmwtL/stqs9KwUa9lMiJczjR9BgPT
         Ldbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792455967; x=1793060767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hrx76pmYceW8g0ndIN//rLD8UMKaYLXy40z7bwSNvMk=;
        b=AfjUruaDAJqixl2NK3XCAiyehJBhvPIIcq8byww6E+5Oqyy8F1SevfsGoFJ68OdJxh
         HpCb5ZX4Pmo6NLsEKZmaalVtYxmyJjozPsZaUCDw3uRzjDmbnJKU1Lz9VvIUA2QODLFW
         IcmYV5gHr8XrZ/53A7HU6G0H66g4bkXahh/E/QVAOIVzNWBHhIMcIJzGdLOqneVAy5Fi
         y7adaa07yIy6rrejO7sBSztA/4/u2m97Jb3VZaxOZrNc89rfScd+DfbaKEXP0pVpLQLc
         EfP5Lx/HUOQi9kf9wUvG/vNYoPoLBwFjq9DmLQF5e1Vo6mxy8QWf91CLFsRs5txHwq3I
         g9Lw==
X-Gm-Message-State: AFq9FYLvv17MednD7zKrRyY6oO2j//7YJ2s98R6+kldlFIu1fmMGA0pC
	PQlWYSYz/eXiIU2RL3Su5l1GEn4N9hf0z7xX8qmVHt1AiwtczOm4ngAC0cZa3OmWdG0=
X-Gm-Gg: AYBFou2HL5tqPO002h6kB1IReUNwLzOwYQZhxkF2tENN9aecsvNAkLVT4GOhUzo5y6d
	EHcvifIRLgJqRLxgXXd0lahuHRSwh/69MBfBexEBqfcQ+gmLxOstYx5E4cGZWnyutqcKu1FFrzn
	B9cuB9iH1S6J1n4cG3i73/2wEX8p9Iy7iMc6hz4rl4F0oMrT0e6gcOWz+bFreToqYjwnlAtfyUQ
	ELAY7ms513aQj17Qzs2qH/IUSlzhdCEDiUO/qkOoI6n57yZdhIv/9U3Vnb49cjDAgU8h14s/tBg
	jPgQj+Z6dO05IDVP5jNg1K7fPhVtvyleHuxMtwB4mv4oXJI5DDXtsro6XFKGornGb5mx0quHTyU
	mXPhIJ/h1oGRrASBjQQ7Ktnoi9f4m/0JUy6Qkp6xZ2x/gVxx/yuls0NXQmxfXW1HpLfh6QtSyiL
	7Xd/ak0w8sAosW+SzW3eZIKxLqPKqAR22i1PYpg8ANo58OUXay7hRfV9V3dpcbIlGKZfjqh2AYM
	IivJX8CMJGcqRcF0i22mKBLPV4NZVgmeuDBsV5y8Q4gltYoPB9upV8toXtXvbGPgsrAlhmxaXA=
X-Received: by 2002:a05:7300:7a83:b0:360:1637:404 with SMTP id 5a478bee46e88-361a2d376e1mr14393549eec.33.1792455966439;
        Mon, 19 Oct 2026 17:26:06 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608258aa66sm44748072eec.20.2026.10.19.17.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 17:26:05 -0700 (PDT)
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
Subject: [PATCH net v4 5/5] amt: harden relay authentication and teardown
Date: Tue, 20 Oct 2026 00:25:57 +0000
Message-ID: <20261020002557.3984927-6-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020002557.3984927-1-omar@blockcast.net>
References: <20261020002557.3984927-1-omar@blockcast.net>
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

An AMT Request has an unauthenticated, spoofable source address. Allocating
tunnel state from that path allowed spoofed Requests to consume tunnel
slots
or overwrite the nonce and MAC of an established gateway.

Keep Requests stateless by deriving the Query MAC from the source address,
source port, nonce, and current secret. Authenticate the Membership Update
before decapsulation or allocation, key verified state by the address/port
endpoint, enforce global and per-source limits, and silently reject an
endpoint that cannot be admitted. Retain four secret generations so a
gateway can renew its MAC across rotations.

Before a verified Update reaches the IGMP or MLD report handlers, recheck
tunnel liveness under tunnel->lock so it cannot add multicast state after
teardown has started.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM
---
 drivers/net/amt.c | 300 +++++++++++++++++++++++++++++++++-------------
 include/net/amt.h |  21 ++--
 2 files changed, 228 insertions(+), 93 deletions(-)

Signed-off-by: Omar Ramadan <omar@blockcast.net>
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index f83afba..faf3297 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -860,11 +860,16 @@ out:
 
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
 
@@ -873,7 +878,8 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
 		return;
 
 	skb_pull(skb, sizeof(struct ethhdr));
-	if (amt_send_membership_query(amt, skb, tunnel, false)) {
+	if (amt_send_membership_query(amt, skb, daddr, dport, nonce, mac,
+				      false)) {
 		DEV_STATS_INC(amt->dev, tx_dropped);
 		kfree_skb(skb);
 	}
@@ -952,7 +958,8 @@ static struct sk_buff *amt_build_mld_gq(struct amt_dev *amt)
 	return skb;
 }
 
-static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
+static void amt_send_mld_gq(struct amt_dev *amt, __be32 daddr, __be16 dport,
+			    __be32 nonce, u64 mac)
 {
 	struct sk_buff *skb;
 
@@ -961,13 +968,15 @@ static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
 		return;
 
 	skb_pull(skb, sizeof(struct ethhdr));
-	if (amt_send_membership_query(amt, skb, tunnel, true)) {
+	if (amt_send_membership_query(amt, skb, daddr, dport, nonce, mac,
+				      true)) {
 		DEV_STATS_INC(amt->dev, tx_dropped);
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
@@ -1001,7 +1010,14 @@ static void amt_secret_work(struct work_struct *work)
 					   secret_wq);
 
 	spin_lock_bh(&amt->lock);
-	get_random_bytes(&amt->key, sizeof(siphash_key_t));
+	/* Keep three previous generations for a 180-240s MAC lifetime.
+	 * Its 180s floor exceeds the advertised QQIC (amt->qi, 125s),
+	 * allowing the gateway to renew its MAC with a periodic Request.
+	 */
+	amt->key[3] = amt->key[2];
+	amt->key[2] = amt->key[1];
+	amt->key[1] = amt->key[0];
+	get_random_bytes(&amt->key[0], sizeof(siphash_key_t));
 	spin_unlock_bh(&amt->lock);
 	mod_delayed_work(amt_wq, &amt->secret_wq,
 			 msecs_to_jiffies(AMT_SECRET_TIMEOUT));
@@ -1191,9 +1207,16 @@ static void amt_send_multicast_data(struct amt_dev *amt,
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
@@ -1214,13 +1237,13 @@ static bool amt_send_membership_query(struct amt_dev *amt,
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
 
@@ -1230,8 +1253,8 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 	amtmq->reserved = 0;
 	amtmq->l	= 0;
 	amtmq->g	= 0;
-	amtmq->nonce	= tunnel->nonce;
-	amtmq->response_mac = tunnel->mac;
+	amtmq->nonce	= nonce;
+	amtmq->response_mac = mac;
 
 	if (!v6)
 		skb_set_inner_protocol(skb, htons(ETH_P_IP));
@@ -1244,11 +1267,10 @@ static bool amt_send_membership_query(struct amt_dev *amt,
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
 
@@ -2576,16 +2598,106 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
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
+ * stops one verified source address from monopolising the table.
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
+	if (!netif_running(amt->dev)) {
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
+	siphash_key_t key[4];
+	int len, hdr_size, i;
 	u64 response_mac;
+	bool verified = false;
 	__be32 saddr;
 	__be32 nonce;
+	__be16 sport;
 
 	saddr = ip_hdr(skb)->saddr;
 
@@ -2599,34 +2711,51 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 
 	nonce = amtmu->nonce;
 	response_mac = amtmu->response_mac;
+	/* Snapshot the tunnel endpoint port before the encap is stripped. */
+	sport = udp_hdr(skb)->source;
 
-	if (iptunnel_pull_header(skb, hdr_size, skb->protocol, false))
-		return true;
+	/* Recompute the MAC handed out in the Membership Query.  Four live
+	 * secrets cover 180-240s, exceeding the advertised QQIC (amt->qi,
+	 * 125s), so a periodic Request can renew the MAC before it expires.
+	 * Authenticate before decapsulation or allocating tunnel state.
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
-		if (tunnel->ip4 == saddr) {
-			if ((nonce == tunnel->nonce &&
-			     response_mac == tunnel->mac)) {
-				/* Refresh liveness only.  gc_wq is
-				 * re-armed by amt_tunnel_expire() itself
-				 * from last_seen, never from here, so this
-				 * cannot re-queue the work of a tunnel
-				 * that is being freed.
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
+	if (!tunnel)
+		return true;
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
 
@@ -2811,15 +2940,29 @@ static bool amt_discovery_handler(struct amt_dev *amt, struct sk_buff *skb)
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
 	struct amt_tunnel_list *tunnel;
-	unsigned long long key;
 	struct udphdr *udph;
 	struct iphdr *iph;
+	siphash_key_t key;
+	bool full, have = false;
+	int per_src = 0;
 	u64 mac;
-	int i;
 
 	if (!pskb_may_pull(skb, sizeof(*udph) + sizeof(*amtrh)))
 		return true;
@@ -2831,59 +2974,41 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
 	if (amtrh->reserved1 || amtrh->reserved2 || amtrh->version)
 		return true;
 
-	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
-		if (tunnel->ip4 == iph->saddr)
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
-
-	tunnel->source_port = udph->source;
-	tunnel->ip4 = iph->saddr;
-
-	memcpy(&key, &tunnel->key, sizeof(unsigned long long));
-	tunnel->amt = amt;
-	spin_lock_init(&tunnel->lock);
-	for (i = 0; i < amt->hash_buckets; i++)
-		INIT_HLIST_HEAD(&tunnel->groups[i]);
-
-	INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
 
-	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
-	tunnel->key = amt->key;
-	__amt_update_relay_status(tunnel, AMT_STATUS_RECEIVED_REQUEST, true);
-	amt->nr_tunnels++;
-	mod_delayed_work(amt_wq, &tunnel->gc_wq,
-			 msecs_to_jiffies(amt_gmi(amt)));
+	/* Snapshot the secret and limits under the lock; keep the endpoint walk
+	 * out of the lock so spoofed Requests cannot serialize relay updates.
+	 */
+	spin_lock_bh(&amt->lock);
+	key = amt->key[0];
+	full = amt->nr_tunnels >= amt->max_tunnels;
 	spin_unlock_bh(&amt->lock);
 
-send:
-	tunnel->nonce = amtrh->nonce;
-	mac = siphash_3u32((__force u32)tunnel->ip4,
-			   (__force u32)tunnel->source_port,
-			   (__force u32)tunnel->nonce,
-			   &tunnel->key);
-	tunnel->mac = mac >> 16;
+	rcu_read_lock();
+	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
+		if (tunnel->ip4 != iph->saddr)
+			continue;
+		per_src++;
+		if (tunnel->source_port == udph->source)
+			have = true;
+	}
+	rcu_read_unlock();
 
-	if (!netif_running(amt->dev) || !netif_running(amt->stream_dev))
+	/* Withhold the Query when a new endpoint cannot get a tunnel. */
+	if (!have && (full || per_src >= AMT_MAX_TUNNELS_PER_SRC))
 		return true;
 
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
+				 mac);
 
 	return false;
 }
@@ -3151,6 +3276,14 @@ static int amt_dev_open(struct net_device *dev)
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
@@ -3161,7 +3294,6 @@ static int amt_dev_open(struct net_device *dev)
 	amt->req_cnt = 0;
 	WRITE_ONCE(amt->remote_ip, 0);
 	amt->nonce = 0;
-	get_random_bytes(&amt->key, sizeof(siphash_key_t));
 
 	amt->status = AMT_STATUS_INIT;
 	if (amt->mode == AMT_MODE_GATEWAY) {
diff --git a/include/net/amt.h b/include/net/amt.h
index 123725c..4acfc3d 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -242,20 +242,17 @@ struct amt_tunnel_list {
 	struct delayed_work	gc_wq;
 	/* Last time this tunnel was refreshed.  gc_wq
 	 * re-arms itself from this rather than being re-armed by the Update
-	 * path, so the Update path cannot re-queue the work of a tunnel that
-	 * amt_tunnel_expire() is freeing.
+	 * path, so the Update path cannot re-queue work for a tunnel that
+	 * amt_tunnel_expire() is freeing on the timeout path.
 	 */
 	unsigned long		last_seen;
 	/* Set under amt->lock and tunnel->lock by whichever freer reaches the
-	 * tunnel first; the other then leaves it alone, so it is freed once.
+	 * tunnel first;
+	 * the other then leaves it alone, so the tunnel is freed exactly once.
 	 */
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
@@ -341,8 +338,10 @@ struct amt_dev {
 	struct work_struct	event_wq;
 	/* AMT status */
 	enum amt_status		status;
-	/* Generated key */
-	siphash_key_t		key;
+	/* Current key and three previous generations keep MACs valid for
+	 * 180-240s, beyond the advertised QQIC (see amt_secret_work()).
+	 */
+	siphash_key_t		key[4];
 	struct sock	  __rcu *sk;
 	u32			max_groups;
 	u32			max_sources;
@@ -399,6 +398,10 @@ struct amt_dev {
 #define AMT_SECRET_TIMEOUT	60000
 #define IANA_AMT_UDP_PORT	2268
 #define AMT_MAX_TUNNELS         128
+/* Fixed per-source cap stops one verified source address from monopolising
+ * the AMT_MAX_TUNNELS-slot table.
+ */
+#define AMT_MAX_TUNNELS_PER_SRC 16
 #define AMT_MAX_REQS		128
 #define AMT_GW_HLEN (sizeof(struct iphdr) + \
 		     sizeof(struct udphdr) + \
