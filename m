Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A855326A0
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914069; cv=none; b=pt0UYT97PPUZnd1G0Ki4QLEzp27d7pcPDy38BRQet+87ccfP/7Mu9q71PayIUtWlYjB7ZfTo4Ck+d6euPPj0Tlxq+vzjUGCgxLJ4sNnXQryh2IVfSDhQqh/YJ4H3H5MtCeFL+K4yowAqDdBNPU1RT85Y1ZA/diz4wByQfyHJvgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914069; c=relaxed/simple;
	bh=RdWwQnlUWEUqnI4l+4rKhFpbSf6bq7OlVlIUzpPlsL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TERgk5ooYGvf5AAto7Oq1n5lvM+ZoKVjmNFG8HySnbJ+SmUz/zsN/+MGXUmj0vfjZsYZQ2yG1kkcQ2Cv1ON6icT248zF6labIOp/pKbyR7duSet6VmT+W8louuZN+TNt+BGCo6ATRHjfI6CyQcBQIb+y7zLnukmUBuR+oR9kD+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=yrJxBE7M; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="yrJxBE7M"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30b6dad2382so7531354eec.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791914065; x=1792518865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jDWiDcZvqIc6oN8dqeE/x4ONYZ9SE9YCPWWgwLd8q0E=;
        b=yrJxBE7MvB2LaOMbkFL/EeKvEJiXTT/48qd57WzS0fe1CcH5ACSq6g9oTO0e2Q/aXz
         bbdX4VZstwdTbSUZek6YY2XUtX/8DlU33NqrNgajZ+hw4alE7i2yOEv/0SBeeCu2eVfi
         Rlxlprrhy1lJ+wx7N9Hm3gKVHcbk6qi+T/21/73EbmO4MhNGOLw0oSse8/BF31d/z8Gl
         eVxWBo2iOxWA/ZtTr6O5L6H8VlCVAhwYCwJRNhNkWZQU+lh3I7kssUA7oGEpFjQ46eVe
         1uhLPjg4/oz0xzPprLQ6sWU3x6Hch2lcHvL+0Fn5E1omlfhGo/sFdjWxRK2K0BPaqNmT
         c83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791914065; x=1792518865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jDWiDcZvqIc6oN8dqeE/x4ONYZ9SE9YCPWWgwLd8q0E=;
        b=FJocDrXjuX9bgwtS6IVxY1l2BaJ6h9RiG58wmCnaadnWHwjUkjhxrlzIy1MrAJ8CWu
         Ymq8ATe7+u5Ywu4Q1h6Vw46APl9UvVId11JtKLxpJJDPASqR8myOltlnvEhtmnzP/vXK
         GcbzPPjZsawJAytuRyThemU/zr7AOWcc0QCEyI2piZg5GsH/QGH6rXW0PVWzrBVk7lmn
         jtoTT4CD3HrKCw1FkmEU6Pd2I394KBSmc93JtP1SWsz5Au9ztBp4haVx5DJIolAQd/Iq
         +DYZ1LqrKadN7kQVWdBCq4sJhzTxrXmWGNS//+Lv/vHD1/1PfgBSw12JKEMlHg58U/al
         MPfQ==
X-Gm-Message-State: AFq9FYIHL9MZpDWj6qjg65mIukvM5ibryrZsjVf5YHqBkeb/LHy0YAmT
	CPOCNNstG43eI/mlYJjkptQFMf2Wdtcc1dVxjriDa2VGsi5Mv6aTztdNyji/TH1nmys=
X-Gm-Gg: AYBFou1VATmzQB1ybff0Ll2SlH+qxpSbE6ATYkVFQT4Rn7cV7ueeb0vJjFySo0u1JFF
	PKtFynN+REJP3DR+0ix5bCjct0dnz+Xlgj1DdmFtVt/aWK++xtk2ss04vWJd8uVU++zuQxRkMk+
	hZ4A+0hCXsZJb5xnGAoCOVLwI2ArZTWJUwOP31dCSwsaWFQEuijePjPoqVSWInS3CnWUfxjtqAM
	tw/WMAVuZ/oDNk7wqZjA33cN8mTfkFvpdJrLUvECNdWJm4o3Tm/hnp8ew6skmqGXrXdOi5tyZQf
	FvPSdLgKEJZEJis+tYDiQTU+wFah9D2rlW3IZ3cWU74G0T6qeQKSDr/Gp97JIOQAVPRmIzjLm2Q
	EOB3qs3jNPlnioXwlA5g5tomGefOHSAlEnM61EE3KGB0JnBMSYJZFDWdyQ/02og/ZCHyqfPgDyp
	2th46sHfvn8iovMfHH7ew4GRRePpSmEJddr2ecIAdJOU38DORKRcxzEhLyJPnWdo5hychi4LrT5
	zbQGYc+BHku18hR7MPEIgKRj+iDrZC72oaBgFfoSCFkAxDXHZo02l2QAVz8A2f4
X-Received: by 2002:a05:7301:e10c:b0:35c:3941:c7bd with SMTP id 5a478bee46e88-35c3941d34bmr4438434eec.19.1791914064861;
        Tue, 13 Oct 2026 10:54:24 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cab27d5sm50183362eec.17.2026.10.13.10.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:54:23 -0700 (PDT)
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
Subject: [PATCH net v4 5/5] amt: harden relay tunnel lifetime and request admission
Date: Tue, 13 Oct 2026 17:54:07 +0000
Message-ID: <20261013175407.947606-6-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013175407.947606-1-omar@blockcast.net>
References: <20261013175407.947606-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Relay Membership Requests are unauthenticated UDP packets. Creating tunnel
state from a Request lets spoofed sources consume relay slots and lets a
spoofed Request overwrite the nonce and MAC of an established endpoint.

Keep Requests stateless: derive the Query MAC from the source address,
source port, nonce, and current key, then authenticate the Membership Update
before decapsulating it or creating tunnel state. Key tunnel state by the
(address, port) endpoint. Initialise every key before enabling receive.

Keep four generations of the relay key. The current key and three previous
keys provide a 180-240 second validation window, whose lower bound exceeds
the advertised QQIC request interval, so a gateway can renew its MAC across
key rotations.

When a new endpoint would exceed either the global tunnel limit or the
per-source limit, withhold the Membership Query and silently drop the
Request. This avoids reflecting ICMP to an unauthenticated source and lets
the gateway rediscover. Requests from an existing endpoint still receive a
Query and can renew their MAC.

A Membership Update may find a tunnel under RCU after expiry has marked it
dead. Recheck tunnel->dead while holding tunnel->lock before adding report
groups, so no group timer is armed after teardown has cleared the groups.
Check netif_running(amt->dev) under amt->lock before allocating a tunnel,
so an Update racing device stop cannot publish state that stop will miss.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 316 +++++++++++++++++++++++++++++++++-------------
 include/net/amt.h |  16 ++-
 2 files changed, 241 insertions(+), 91 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 884f27f..0124f1b 100644
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
@@ -925,7 +934,14 @@ static void amt_secret_work(struct work_struct *work)
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
@@ -1115,9 +1131,16 @@ static void amt_send_multicast_data(struct amt_dev *amt,
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
@@ -1138,13 +1161,13 @@ static bool amt_send_membership_query(struct amt_dev *amt,
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
 
@@ -1154,8 +1177,8 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 	amtmq->reserved = 0;
 	amtmq->l	= 0;
 	amtmq->g	= 0;
-	amtmq->nonce	= tunnel->nonce;
-	amtmq->response_mac = tunnel->mac;
+	amtmq->nonce	= nonce;
+	amtmq->response_mac = mac;
 
 	if (!v6)
 		skb_set_inner_protocol(skb, htons(ETH_P_IP));
@@ -1168,11 +1191,10 @@ static bool amt_send_membership_query(struct amt_dev *amt,
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
 
@@ -2491,16 +2513,107 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
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
 
@@ -2514,34 +2627,58 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 
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
 
@@ -2556,6 +2693,10 @@ report:
 		}
 
 		spin_lock_bh(&tunnel->lock);
+		if (READ_ONCE(tunnel->dead)) {
+			spin_unlock_bh(&tunnel->lock);
+			return true;
+		}
 		amt_igmp_report_handler(amt, skb, tunnel);
 		spin_unlock_bh(&tunnel->lock);
 
@@ -2576,6 +2717,10 @@ report:
 		}
 
 		spin_lock_bh(&tunnel->lock);
+		if (READ_ONCE(tunnel->dead)) {
+			spin_unlock_bh(&tunnel->lock);
+			return true;
+		}
 		amt_mld_report_handler(amt, skb, tunnel);
 		spin_unlock_bh(&tunnel->lock);
 
@@ -2718,15 +2863,29 @@ static bool amt_discovery_handler(struct amt_dev *amt, struct sk_buff *skb)
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
@@ -2738,60 +2897,40 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
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
-			 msecs_to_jiffies(amt_gmi(amt)));
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
@@ -3059,6 +3198,14 @@ static int amt_dev_open(struct net_device *dev)
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
@@ -3069,7 +3216,6 @@ static int amt_dev_open(struct net_device *dev)
 	amt->req_cnt = 0;
 	WRITE_ONCE(amt->remote_ip, 0);
 	amt->nonce = 0;
-	get_random_bytes(&amt->key, sizeof(siphash_key_t));
 
 	amt->status = AMT_STATUS_INIT;
 	if (amt->mode == AMT_MODE_GATEWAY) {
diff --git a/include/net/amt.h b/include/net/amt.h
index 0520121..63bb647 100644
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
@@ -336,8 +332,10 @@ struct amt_dev {
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
@@ -394,6 +392,12 @@ struct amt_dev {
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
