Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6767E3655D1
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792102031; cv=none; b=tphl9aXDJm7MKUosibt11zLyVsjWcSHOaHQaH/sJxuTEcJ6peli3gP/bzOiQkXTIpAOkpmrpQOtwJVqSP3ao+etlF02b5WWwSBFfy7OXpQBH/7ACoWnAw8SqcJ7eT7mOCqE75v2HRfy+es5m7viT42K8sZfUWHqaY752ntJkoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792102031; c=relaxed/simple;
	bh=pEl2fhKiq4nr3u0ztpEZbvsp/DqSZorIAo/Kc9WSEjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwxVVwa7J2fm+is5cFsOJLhAERCk7jSpxwqFYtxQMBOwtjBuwBpxbhS7mdKp3rnzoWpBumfrTLYQpFAvJxASva86XH4ErQJLNt4AZvIOF8uzYrEXnzioiNogz8rkmw5QUDF+LbfQaYOcAsXzFJ8koxEh4Y1cxnEq7nvwU1uJyAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=pHAN5VmR; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="pHAN5VmR"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35d7fa491deso452776eec.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1792102026; x=1792706826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmDzSuToSJYXaFQ/SP1WJX0Yu1h0YAXEwCCcouF86DY=;
        b=pHAN5VmR3mrtv1vkY9NNVEaWY8g60q97+26HfuNCbLsseBG4w9d7HsOPX9HmOlpWh+
         RsjvZEUzUVmC0dcSxBDtR8hK6esNGPiPe34M8FRljEvmvUDMjHl3DbT4GQZpoD9zbybJ
         OiVm28UO6H8J8vmThN/ofLHoSe3qcRtKH3bilyMHHJCJ07d7iNYY2UuNPM+ikntTw2ES
         Ay+5Ai2UWzgZUA2ygtmE7WQNKrRf5HfXqtiyGSq/x7kpYe/PPMbthrWIPJu/AmawM9bx
         QIBnqbt4Nz5Wle6a3UF4L5s5j0na8+c3DsgQr5aH2DCw7uktfXXN6IRnD2zWQRVVKKpg
         Jn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792102026; x=1792706826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zmDzSuToSJYXaFQ/SP1WJX0Yu1h0YAXEwCCcouF86DY=;
        b=nzGNj4inRE8JAQ3jwDRg3Py5PLKDb4bKjI/up2/TzPd/cc/mSpwdFxu5g0fSrySMaE
         krRwjfVP5TxzUQQmeI2ir4L5Uo3YFovWp8HMkAzCo+5c+RNx4PxoFEIWW4pJO509xPPJ
         VamXNiLEkgGPNv+HJHs8w5VlHQVJkTkigpK3QzY3yzy5mkzWgaal9o7cbtIYrJTCe9i/
         q3JoXlaodrw9RYRjV/40Cb0DLi0Q6ezIzEG5//LC51wBLq0ME1LUJcUmZItgrEt4ExH6
         fr0/XN4cqwVIxUcxhj6QkEsYyjxwqagHLPNcrtuuVeGzguL9NwVUVVVbj2ID09jA3xpT
         y2nQ==
X-Gm-Message-State: AFq9FYLIZZD/BhP2r1YeQ2Lzt1AAZwp3WGVb+bhJuXVdhpst+sVeBPbq
	JNZ6mZhQazHCIbjDuqNwZ2Hmuc+afJ/ISJf3lzXbMpRgV3qJpyjBrOtM/Cqb0FX/Pgg=
X-Gm-Gg: AYBFou0iIuHJ5Yhe+OuZUHPARLgO2PpWWC6xfItPRLv/6k5BPx/bLRKFA0dQyeAsi1Y
	yb3JKE2OklzWX3DvwmIYnOJgRPMCTiW60wwerdXrGscFL5hbH/kQpZ9U3IZrb+9D8mJak0Y2o/s
	g0hMOS4I7EskfKcbFBUd3OrvKMznWyGmleKpDfB1b+2pP/s8DWf83Q3b1p5DWrkSu3kM7qz1b2Y
	THXclKMjwzBnyRE1vwDqetzsDFwN5Ne+hCOUTZcjcLNpIObNT+et/kS0lLQkkLbeeKXM7WslZim
	cdCdEZW64XVyvmHK3lQtDcZo4S0jehe2VgYmgR5x4Ese2qyag4k87K8b2Bwt/CNDViSqLSSKhhZ
	OfbrrVbPykwgQv6nYAJJTHuAsl6NsOcNaLr2Lpzp5KNHo/k/T83zFqEMxWZiwKiqVspAi/Zf+JN
	sygnagGR8dcvkOyxzKIw7dWxCFHv2KZJm8j7b/jTICGHbuCJkUq3lW8iuTItUQ+wwpR/k3MN86O
	YCK1jBDlVHU+Mp3n4xUQiIjLP3oaywTOF+IhqHQ
X-Received: by 2002:a05:693c:41c3:10b0:35c:3057:5ff2 with SMTP id 5a478bee46e88-3602d6e5cf7mr1408418eec.9.1792102025941;
        Thu, 15 Oct 2026 15:07:05 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cab0sm1016445eec.3.2026.10.15.15.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 15:07:04 -0700 (PDT)
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
Date: Thu, 15 Oct 2026 22:06:48 +0000
Message-ID: <20261015220648.1545576-6-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015220648.1545576-1-omar@blockcast.net>
References: <20261015220648.1545576-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep relay Requests stateless: derive the Membership Query MAC from the
source address, source port, nonce, and current key, then authenticate the
Membership Update before decapsulating it or creating tunnel state. Key tunnel
state by the (address, port) endpoint and reject new endpoints at the global
or per-source cap without reflecting ICMP. Keep four key generations so a
gateway can renew its MAC across rotations.

Make tunnel and multicast state teardown safe against concurrent RCU readers
and delayed workers. Mark tunnels, groups, and sources dead under their locks;
have group and source workers hold RCU while finding their owners and checking
that state; and release the group timer's device reference on every exit path.
Recheck tunnel liveness before a Membership Update can arm group work.

A deferred gateway Query is accepted only if its relay address still matches
the current relay, and transmit error/drop counters use the concurrent-safe
netdev statistics helpers.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM

Signed-off-by: Omar Ramadan <omar@blockcast.net>
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index c6924ab..ba2734c 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -309,8 +309,8 @@ static void amt_source_work(struct work_struct *work)
 		if (!gnode->nr_sources)
 			amt_del_group(amt, gnode);
 	} else {
-		/* When a router filter-mode for a group is EXCLUDE,
-		 * source records are only deleted when the group timer expires
+		/* When a router filter-mode for the group is EXCLUDE, source
+		 * records are only deleted when the group timer expires.
 		 */
 		snode->status = AMT_SOURCE_STATUS_D_FWD;
 	}
@@ -806,11 +806,16 @@ out:
 
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
 
@@ -819,7 +824,8 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
 		return;
 
 	skb_pull(skb, sizeof(struct ethhdr));
-	if (amt_send_membership_query(amt, skb, tunnel, false)) {
+	if (amt_send_membership_query(amt, skb, daddr, dport, nonce, mac,
+				      false)) {
 		DEV_STATS_INC(amt->dev, tx_dropped);
 		kfree_skb(skb);
 	}
@@ -898,7 +904,8 @@ static struct sk_buff *amt_build_mld_gq(struct amt_dev *amt)
 	return skb;
 }
 
-static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
+static void amt_send_mld_gq(struct amt_dev *amt, __be32 daddr, __be16 dport,
+			    __be32 nonce, u64 mac)
 {
 	struct sk_buff *skb;
 
@@ -907,13 +914,15 @@ static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
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
@@ -947,7 +956,14 @@ static void amt_secret_work(struct work_struct *work)
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
@@ -1137,9 +1153,16 @@ static void amt_send_multicast_data(struct amt_dev *amt,
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
@@ -1160,13 +1183,13 @@ static bool amt_send_membership_query(struct amt_dev *amt,
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
 
@@ -1176,8 +1199,8 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 	amtmq->reserved = 0;
 	amtmq->l	= 0;
 	amtmq->g	= 0;
-	amtmq->nonce	= tunnel->nonce;
-	amtmq->response_mac = tunnel->mac;
+	amtmq->nonce	= nonce;
+	amtmq->response_mac = mac;
 
 	if (!v6)
 		skb_set_inner_protocol(skb, htons(ETH_P_IP));
@@ -1190,11 +1213,10 @@ static bool amt_send_membership_query(struct amt_dev *amt,
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
 
@@ -2517,16 +2539,106 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
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
 
@@ -2540,34 +2652,58 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 
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
+	if (!tunnel) {
+		/* Out of tunnel slots.  Unlike the Request path this reply only
+		 * ever goes to a source that proved it received our Query,
+		 * so it
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
 
@@ -2582,6 +2718,10 @@ report:
 		}
 
 		spin_lock_bh(&tunnel->lock);
+		if (READ_ONCE(tunnel->dead)) {
+			spin_unlock_bh(&tunnel->lock);
+			return true;
+		}
 		amt_igmp_report_handler(amt, skb, tunnel);
 		spin_unlock_bh(&tunnel->lock);
 
@@ -2602,6 +2742,10 @@ report:
 		}
 
 		spin_lock_bh(&tunnel->lock);
+		if (READ_ONCE(tunnel->dead)) {
+			spin_unlock_bh(&tunnel->lock);
+			return true;
+		}
 		amt_mld_report_handler(amt, skb, tunnel);
 		spin_unlock_bh(&tunnel->lock);
 
@@ -2744,15 +2888,29 @@ static bool amt_discovery_handler(struct amt_dev *amt, struct sk_buff *skb)
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
@@ -2764,60 +2922,40 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
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
+	if (!netif_running(amt->dev) || !netif_running(amt->stream_dev))
 		return true;
-	}
 
-	tunnel = kzalloc(sizeof(*tunnel) +
-			 (sizeof(struct hlist_head) * amt->hash_buckets),
-			 GFP_ATOMIC);
-	if (!tunnel) {
-		spin_unlock_bh(&amt->lock);
-		return true;
+	/* Snapshot the secret and tunnel limits on the same locked walk. */
+	spin_lock_bh(&amt->lock);
+	key = amt->key[0];
+	full = amt->nr_tunnels >= amt->max_tunnels;
+	list_for_each_entry(tunnel, &amt->tunnel_list, list) {
+		if (tunnel->ip4 != iph->saddr)
+			continue;
+		per_src++;
+		if (tunnel->source_port == udph->source)
+			have = true;
 	}
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
-	tunnel->last_seen = jiffies;
-	INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
-
-	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
-	tunnel->key = amt->key;
-	__amt_update_relay_status(tunnel, AMT_STATUS_RECEIVED_REQUEST, true);
-	amt->nr_tunnels++;
-	mod_delayed_work(amt_wq, &tunnel->gc_wq,
-			 msecs_to_jiffies(amt_gmi(amt)) * 3);
 	spin_unlock_bh(&amt->lock);
 
-send:
-	tunnel->nonce = amtrh->nonce;
-	mac = siphash_3u32((__force u32)tunnel->ip4,
-			   (__force u32)tunnel->source_port,
-			   (__force u32)tunnel->nonce,
-			   &tunnel->key);
-	tunnel->mac = mac >> 16;
-
-	if (!netif_running(amt->dev) || !netif_running(amt->stream_dev))
+	/* Withhold the Query when a new endpoint cannot get a tunnel, so the
+	 * gateway rediscovers.  Existing endpoints must still renew their MAC.
+	 * Drop silently: an unauthenticated Request must not reflect ICMP.
+	 */
+	if (!have && (full || per_src >= AMT_MAX_TUNNELS_PER_SRC))
 		return true;
 
+	mac = siphash_3u32((__force u32)iph->saddr,
+			   (__force u32)udph->source,
+			   (__force u32)amtrh->nonce,
+			   &key) >> 16;
+
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
@@ -3085,6 +3223,14 @@ static int amt_dev_open(struct net_device *dev)
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
@@ -3095,7 +3241,6 @@ static int amt_dev_open(struct net_device *dev)
 	amt->req_cnt = 0;
 	WRITE_ONCE(amt->remote_ip, 0);
 	amt->nonce = 0;
-	get_random_bytes(&amt->key, sizeof(siphash_key_t));
 
 	amt->status = AMT_STATUS_INIT;
 	if (amt->mode == AMT_MODE_GATEWAY) {
diff --git a/include/net/amt.h b/include/net/amt.h
index ffe231b..1b4283e 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -242,20 +242,16 @@ struct amt_tunnel_list {
 	struct delayed_work	gc_wq;
 	/* Last time this tunnel was refreshed.  gc_wq
 	 * re-arms itself from this rather than being re-armed by the Update
-	 * path, so the Update path cannot re-queue the work of a tunnel that
-	 * amt_tunnel_expire() is freeing.
+	 * path, so the Update path cannot re-queue work for a tunnel that
+	 * amt_tunnel_expire() is freeing on the timeout path.
 	 */
 	unsigned long		last_seen;
-	/* Set under amt->lock and tunnel->lock by whichever freer reaches the
-	 * tunnel first; the other then leaves it alone, so it is freed once.
+	/* Set under amt->lock by whichever freer reaches the tunnel first;
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
@@ -339,8 +335,10 @@ struct amt_dev {
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
@@ -397,6 +395,10 @@ struct amt_dev {
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
-- 
2.43.0

