Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE264242D7B
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791419778; cv=none; b=tj4ZSmj0wT2qcEr6U+G+eztDk7IoFsx92eU5jBdPj5PHKwDa8JSWTRUgFMexR+Z7CyiXiNrobhYfxR04ZMp/sRR/IRUE5OJdH5ZaE+rlpNWcqaUyAfsdCucaKFKjliaZSoK/CjyK7RPr5FUnuaxq259aaDNyOP3o8LPqhMjWRiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791419778; c=relaxed/simple;
	bh=GIK/hcIfLB3RWGJogTAZ6egz56J35/W9Oo4n4PBm5x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOQEO72kkp6W6E7v/RsP5GeWRTWildTIc8fXAg6RBX1BQ21CNQXcJ80hWGLHHznc7mINKwvfrAO7ncWz1mJ6/adVNB6rU80bO/KHtDBsOvUT9oX/7Z10lyDcfnV4u+UlNRNHZTWeQRzOIveSklMZOP/GSwhOQKquf1HGkLfULs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=evfrEolt; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="evfrEolt"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3115c4451c8so3868158eec.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 17:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791419776; x=1792024576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wMN9oxRkAyUCmZ+51GodPhlfzpOweuXWlKV4WnjZu30=;
        b=evfrEolth7sSMzh+WK0Spu96Kya+ghNDZrhQRvlHnWvRqorKQq7dDlV1s/vAYyw3FY
         z0Wyrsw4/fQ43RqlXoOPnmNflpMwLI+mm/o/mkQnIchWCZdki7CIjBmyscX23reb5yCs
         P/LFSl8hRpXXpZew0IUkHIfFnBY02rgiDSx9bt4EqfVj+yVdFMqr8aCRZpNmscnCf+0h
         H1ve5naDBZ3BtWY1RXmAVwWa+u18OTtVrG1cFuzySwieMjRC0VqypxbQy1KaShQ2Xyzg
         0CcnyHSN8zhqzV6n2nQHLp1tYrA+Z9Cd1FOCYqUrYsNqozCFEybSlP3FbHhL0fDLSYDO
         cM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791419776; x=1792024576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wMN9oxRkAyUCmZ+51GodPhlfzpOweuXWlKV4WnjZu30=;
        b=k4nCgKFFmz6rf43n2hlb8HZ/vXOSjdwk3W7kkyMLnIQ7r5yYuYXFBIJZwx6d5hQ/o+
         yrtU/enbdx6tTuSzopX/OHGzAEaawmblfgC74KzCgHJYH5FEckAJIFnN4b5pc+WgTpcB
         /NLk2aOreDs+q/DyqannE0tdrqR2XHvkz2L6yjcvCpnF69W0JO1bMhbeBWpmOXpHnu8y
         h3zVhsrK+qxY8p2GKlFl/Okfkwr+buB1rnoemiPBaqUKLGZqB8yg57TqhYYlG2BN9W2o
         wZvqH2U91tB1daJ0qJXn9+35q/3ComKa7W908b3eDcCll3lA0m03fyOcUOp8xEuc+SBm
         R7Bg==
X-Gm-Message-State: AFuF++n2engIjYq62gLlzDw0UVS/SnFJJkOLEnqHRmYxcb8D5QVqh3k2
	qTg7SLJGRPDWTHyFzjpqTE7bcPx66EBGDRrYssaOvHwSLnc3aWh1x0OZolL567z2268=
X-Gm-Gg: AYBFou2AGNan3vqq6jwmMavwFE6wAbwFt4uc9HKeZy5n5LStyZ943ZGShfeiSrb8m1x
	zd5l35IK/JS+JhiLOI1LlVH0A8pAZMPTyqMXDKS4IUxciIlq+BmlgGTvolWbBmlovf6APDHU/++
	tXIxhdpzFgYY3bhbkEtK2QgBoavQX4YaoT8VJel/wMNrUN3uG1ABu8O+ES/zKwQPC3ZQdzzjESG
	GzpIQ6iCDW+6ZpxDii0ZttT0PAv39WdamqM8EV02yFR6OCnOeVwCERIhn18PmVV28CUx8RsnP2x
	ZpO0JlKNxlSsjS8FTni0z1pHuCfa4D4/hGv0N5tRtemRz3vuID/w9Wu/2GMIWthN4FGkWPZD2Xj
	y376JKZSHtilUFAFZ6nnNZUhhrGc4duhS50vV7QFcBe6hUryxhThrIFWKCTOfspoVX4bWOd29uB
	dYjT8Wy3Bd1qMl3QjAW64XC2yr6dj1aMZuPV8rAZL/SEVX9FsvZb8V5XK4WzNRKwAKmAbOsQHhJ
	fR5M147e1zo+z76/b6kaeq9utKZoJHywASs1a9/K/oKo5niYko=
X-Received: by 2002:a05:7300:f291:b0:351:2f0a:cb2a with SMTP id 5a478bee46e88-35177167717mr959816eec.2.1791419775725;
        Wed, 07 Oct 2026 17:36:15 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351735e316fsm3496694eec.11.2026.10.07.17.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 17:36:14 -0700 (PDT)
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
Subject: [PATCH net 4/4] amt: do not create tunnel state for unauthenticated Requests
Date: Thu,  8 Oct 2026 00:36:05 +0000
Message-ID: <20261008003606.3666617-5-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008003606.3666617-1-omar@blockcast.net>
References: <20261008003606.3666617-1-omar@blockcast.net>
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
   Request also emits an ICMP_DEST_UNREACH to the spoofed source, turning
   the relay into an ICMP reflector.

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
   mismatch. Tunnel state is created only after that check passes, so
   max_tunnels now bounds verified gateways.
 - amt->key becomes a two-element array. amt_secret_work() rotates every
   AMT_SECRET_TIMEOUT (60s) and an exchange may straddle a rotation, so
   Update accepts the current or previous secret. Previously each tunnel
   snapshotted the key at creation, which a stateless recompute cannot do.

The General Query is passed its destination by value rather than a tunnel
pointer, because at Request time no tunnel exists to point at.

Two smaller issues on the same path go away with it: the entry was
published by list_add_tail_rcu() before ->key, ->nonce and ->mac were
assigned, leaving a window in which a concurrent Update could match the
zeroed nonce/mac of a kzalloc()'d entry; and the send path read
tunnel->key into an unused local before that field was initialised.

Note for reviewers: the MAC covers the UDP source port, so a NAT
rebinding between Request and Update now changes the recomputed MAC where
the stored value would have survived it. Including the port is what
RFC 7450 5.1.4.6 describes, and the exposed window is a single round trip
rather than the tunnel lifetime, but it is a behaviour change.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 280 +++++++++++++++++++++++++++++-----------------
 include/net/amt.h |  11 +-
 2 files changed, 181 insertions(+), 110 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 79f2f59bf..65ee20c71 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -782,19 +782,24 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 
 static bool amt_send_membership_query(struct amt_dev *amt,
 				      struct sk_buff *skb,
-				      struct amt_tunnel_list *tunnel,
+				      __be32 daddr, __be16 dport,
+				      __be32 nonce, u64 mac,
 				      bool v6);
 
-/* Send the relay's General Query directly to the requesting gateway's tunnel.
+/* Send the relay's General Query directly to the requesting gateway.
  *
  * The query used to go through dev_queue_xmit() with the target tunnel stashed
  * in skb->cb for amt_dev_xmit() to recover, but the control block does not
- * survive every transmit path. We already hold the tunnel here, so strip the
- * L2 header amt_build_igmp_gq() adds and call the membership-query sender
- * directly. The sender returns true on error without consuming the skb.
+ * survive every transmit path. So strip the L2 header amt_build_igmp_gq() adds
+ * and call the membership-query sender directly. The sender returns true on
+ * error without consuming the skb.
+ *
+ * The destination is passed by value rather than as a tunnel, because at this
+ * point the requesting source is still unauthenticated and no tunnel state
+ * exists for it - see amt_request_handler().
  */
-static void amt_send_igmp_gq(struct amt_dev *amt,
-			     struct amt_tunnel_list *tunnel)
+static void amt_send_igmp_gq(struct amt_dev *amt, __be32 daddr, __be16 dport,
+			     __be32 nonce, u64 mac)
 {
 	struct sk_buff *skb;
 
@@ -803,7 +808,8 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
 		return;
 
 	skb_pull(skb, sizeof(struct ethhdr));
-	if (amt_send_membership_query(amt, skb, tunnel, false))
+	if (amt_send_membership_query(amt, skb, daddr, dport, nonce, mac,
+				      false))
 		kfree_skb(skb);
 }
 
@@ -880,7 +886,8 @@ static struct sk_buff *amt_build_mld_gq(struct amt_dev *amt)
 	return skb;
 }
 
-static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
+static void amt_send_mld_gq(struct amt_dev *amt, __be32 daddr, __be16 dport,
+			    __be32 nonce, u64 mac)
 {
 	struct sk_buff *skb;
 
@@ -890,11 +897,12 @@ static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
 
 	/* Direct send -- see amt_send_igmp_gq(). */
 	skb_pull(skb, sizeof(struct ethhdr));
-	if (amt_send_membership_query(amt, skb, tunnel, true))
+	if (amt_send_membership_query(amt, skb, daddr, dport, nonce, mac, true))
 		kfree_skb(skb);
 }
 #else
-static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
+static void amt_send_mld_gq(struct amt_dev *amt, __be32 daddr, __be16 dport,
+			    __be32 nonce, u64 mac)
 {
 }
 #endif
@@ -928,7 +936,8 @@ static void amt_secret_work(struct work_struct *work)
 					   secret_wq);
 
 	spin_lock_bh(&amt->lock);
-	get_random_bytes(&amt->key, sizeof(siphash_key_t));
+	amt->key[1] = amt->key[0];
+	get_random_bytes(&amt->key[0], sizeof(siphash_key_t));
 	spin_unlock_bh(&amt->lock);
 	mod_delayed_work(amt_wq, &amt->secret_wq,
 			 msecs_to_jiffies(AMT_SECRET_TIMEOUT));
@@ -1117,9 +1126,16 @@ static void amt_send_multicast_data(struct amt_dev *amt,
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
@@ -1140,13 +1156,13 @@ static bool amt_send_membership_query(struct amt_dev *amt,
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
 
@@ -1156,8 +1172,8 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 	amtmq->reserved = 0;
 	amtmq->l	= 0;
 	amtmq->g	= 0;
-	amtmq->nonce	= tunnel->nonce;
-	amtmq->response_mac = tunnel->mac;
+	amtmq->nonce	= nonce;
+	amtmq->response_mac = mac;
 
 	if (!v6)
 		skb_set_inner_protocol(skb, htons(ETH_P_IP));
@@ -1170,11 +1186,10 @@ static bool amt_send_membership_query(struct amt_dev *amt,
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
 
@@ -2443,16 +2458,81 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	return false;
 }
 
+/* Look up the tunnel for a source whose Membership Update has already been
+ * authenticated, creating it on first contact.
+ *
+ * This is now the only place tunnel state is allocated, so amt->max_tunnels
+ * bounds the number of *verified* gateways rather than the number of
+ * unverified Requests anyone can send.
+ */
+static struct amt_tunnel_list *amt_tunnel_get_or_create(struct amt_dev *amt,
+							__be32 saddr,
+							__be16 sport)
+{
+	struct amt_tunnel_list *tunnel;
+	int i;
+
+	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
+		if (tunnel->ip4 == saddr && tunnel->source_port == sport)
+			return tunnel;
+
+	spin_lock_bh(&amt->lock);
+
+	/* Re-check under the lock; a concurrent Update may have won the race. */
+	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
+		if (tunnel->ip4 == saddr && tunnel->source_port == sport) {
+			spin_unlock_bh(&amt->lock);
+			return tunnel;
+		}
+	}
+
+	if (amt->nr_tunnels >= amt->max_tunnels) {
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
+	INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
+	__amt_update_relay_status(tunnel, AMT_STATUS_RECEIVED_UPDATE, false);
+
+	/* Publish only once the entry is fully initialised. */
+	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
+	amt->nr_tunnels++;
+	spin_unlock_bh(&amt->lock);
+
+	return tunnel;
+}
+
 static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 {
 	struct amt_header_membership_update *amtmu;
 	struct amt_tunnel_list *tunnel;
+	bool verified = false;
+	siphash_key_t key[2];
+	int len, hdr_size, i;
+	u64 response_mac;
 	struct ethhdr *eth;
 	struct iphdr *iph;
-	int len, hdr_size;
+	__be32 saddr;
+	__be32 nonce;
 	__be16 sport;
 
 	iph = ip_hdr(skb);
+	saddr = iph->saddr;
 
 	hdr_size = sizeof(*amtmu) + sizeof(struct udphdr);
 	if (!pskb_may_pull(skb, hdr_size))
@@ -2464,37 +2544,61 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 
 	/* Snapshot the tunnel endpoint port before the encap is stripped. */
 	sport = udp_hdr(skb)->source;
+	nonce = amtmu->nonce;
+	response_mac = amtmu->response_mac;
+
+	/* Recompute the MAC handed out in the Membership Query rather than
+	 * comparing against a stored copy.  Both the current and the previous
+	 * secret are accepted so that an exchange straddling a rotation by
+	 * amt_secret_work() is not spuriously rejected.
+	 *
+	 * This runs before the packet is decapsulated so that an unverified
+	 * source is rejected without any further work being done on it.
+	 */
+	spin_lock_bh(&amt->lock);
+	key[0] = amt->key[0];
+	key[1] = amt->key[1];
+	spin_unlock_bh(&amt->lock);
 
-	if (iptunnel_pull_header(skb, hdr_size, skb->protocol, false))
-		return true;
-
-	skb_reset_network_header(skb);
+	for (i = 0; i < ARRAY_SIZE(key); i++) {
+		u64 mac = siphash_3u32((__force u32)saddr,
+				       (__force u32)sport,
+				       (__force u32)nonce,
+				       &key[i]) >> 16;
 
-	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
-		if (tunnel->ip4 == iph->saddr &&
-		    tunnel->source_port == sport) {
-			if ((amtmu->nonce == tunnel->nonce &&
-			     amtmu->response_mac == tunnel->mac)) {
-				mod_delayed_work(amt_wq, &tunnel->gc_wq,
-						 msecs_to_jiffies(amt_gmi(amt))
-								  * 3);
-				goto report;
-			} else {
-				/* The endpoint match is unique, so no other
-				 * tunnel can validate this Update. Count the
-				 * drop: an unauthenticated Update is not
-				 * observable from the gateway's own side.
-				 */
-				netdev_dbg(amt->dev, "Invalid MAC\n");
-				amt->dev->stats.rx_dropped++;
-				return true;
-			}
+		if (response_mac == mac) {
+			verified = true;
+			break;
 		}
 	}
 
-	return true;
+	if (!verified) {
+		/* Count the drop: an unauthenticated Update is not observable
+		 * from the gateway's own side.
+		 */
+		netdev_dbg(amt->dev, "Invalid MAC\n");
+		amt->dev->stats.rx_dropped++;
+		return true;
+	}
+
+	tunnel = amt_tunnel_get_or_create(amt, saddr, sport);
+	if (!tunnel) {
+		/* Out of tunnel slots.  Unlike the Request path this reply
+		 * only ever goes to a source that has proved it received our
+		 * Query, so it cannot be used to reflect at a third party.
+		 */
+		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0);
+		return true;
+	}
+
+	mod_delayed_work(amt_wq, &tunnel->gc_wq,
+			 msecs_to_jiffies(amt_gmi(amt)) * 3);
+
+	if (iptunnel_pull_header(skb, hdr_size, skb->protocol, false))
+		return true;
+
+	skb_reset_network_header(skb);
 
-report:
 	if (!pskb_may_pull(skb, sizeof(*iph)))
 		return true;
 
@@ -2666,15 +2770,27 @@ static bool amt_discovery_handler(struct amt_dev *amt, struct sk_buff *skb)
 	return false;
 }
 
+/* Handle an AMT Relay Membership Request.
+ *
+ * The source address of a Request is unauthenticated: it is a bare UDP
+ * datagram and can be trivially spoofed.  Allocating tunnel state here let an
+ * attacker fill the tunnel table (amt->max_tunnels entries, each held for
+ * amt_gmi()) from spoofed addresses, and let a single spoofed packet overwrite
+ * the nonce/MAC of an already-established tunnel and cut that gateway off.
+ *
+ * Nothing needs to be remembered at this point.  Every input to the keyed MAC
+ * is either carried in the packet or is device state, so the MAC is generated
+ * here, echoed back by the gateway in its Membership Update, and recomputed
+ * and verified there - see amt_update_handler().  Tunnel state is created only
+ * once that verification succeeds.
+ */
 static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
 {
 	struct amt_header_request *amtrh;
-	struct amt_tunnel_list *tunnel;
-	unsigned long long key;
 	struct udphdr *udph;
 	struct iphdr *iph;
+	siphash_key_t key;
 	u64 mac;
-	int i;
 
 	if (!pskb_may_pull(skb, sizeof(*udph) + sizeof(*amtrh)))
 		return true;
@@ -2686,68 +2802,24 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
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
-
-	tunnel->source_port = udph->source;
-	tunnel->ip4 = iph->saddr;
-
-	memcpy(&key, &tunnel->key, sizeof(unsigned long long));
-	tunnel->amt = amt;
-	spin_lock_init(&tunnel->lock);
-	for (i = 0; i < amt->hash_buckets; i++)
-		INIT_HLIST_HEAD(&tunnel->groups[i]);
 
-	INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
-
-	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
-	tunnel->key = amt->key;
-	__amt_update_relay_status(tunnel, AMT_STATUS_RECEIVED_REQUEST, true);
-	amt->nr_tunnels++;
-	mod_delayed_work(amt_wq, &tunnel->gc_wq,
-			 msecs_to_jiffies(amt_gmi(amt)));
+	spin_lock_bh(&amt->lock);
+	key = amt->key[0];
 	spin_unlock_bh(&amt->lock);
 
-send:
-	/* source_port is part of the tunnel's identity and is set once, in
-	 * the allocation path above; the lookup only reaches here on an
-	 * exact (address, port) match, so it is already udph->source. A
-	 * gateway that re-Requests from a new ephemeral port no longer
-	 * aliases onto this tunnel -- it gets its own, and this one ages
-	 * out on gc_wq. Do not "refresh" the port here: that is what made
-	 * a colliding Request steal an established tunnel outright.
-	 */
-	tunnel->nonce = amtrh->nonce;
-	mac = siphash_3u32((__force u32)tunnel->ip4,
-			   (__force u32)tunnel->source_port,
-			   (__force u32)tunnel->nonce,
-			   &tunnel->key);
-	tunnel->mac = mac >> 16;
-
-	if (!netif_running(amt->dev) || !netif_running(amt->stream_dev))
-		return true;
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
@@ -3017,7 +3089,7 @@ static int amt_dev_open(struct net_device *dev)
 	amt->req_cnt = 0;
 	amt->remote_ip = 0;
 	amt->nonce = 0;
-	get_random_bytes(&amt->key, sizeof(siphash_key_t));
+	get_random_bytes(&amt->key, sizeof(amt->key));
 
 	amt->status = AMT_STATUS_INIT;
 	if (amt->mode == AMT_MODE_GATEWAY) {
diff --git a/include/net/amt.h b/include/net/amt.h
index ad844d65a..13d7685b3 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -242,10 +242,6 @@ struct amt_tunnel_list {
 	struct delayed_work	gc_wq;
 	__be16			source_port;
 	__be32			ip4;
-	__be32			nonce;
-	siphash_key_t		key;
-	u64			mac:48,
-				reserved:16;
 	struct rcu_head		rcu;
 	struct hlist_head	groups[];
 };
@@ -325,8 +321,11 @@ struct amt_dev {
 	struct work_struct	event_wq;
 	/* AMT status */
 	enum amt_status		status;
-	/* Generated key */
-	siphash_key_t		key;
+	/* Generated keys. key[0] is current, key[1] is the previous
+	 * generation, kept so that a Request/Update exchange straddling a
+	 * secret rotation still verifies.
+	 */
+	siphash_key_t		key[2];
 	struct socket	  __rcu *sock;
 	u32			max_groups;
 	u32			max_sources;
-- 
2.43.0

