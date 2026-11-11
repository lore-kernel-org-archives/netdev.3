Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392863;
	b=c7sZqCE5u0J9in6zzyxDptAZ8G4/7Yn0xhHT11UrOq8kQeLvq+/4mDvEosEf2lcJ4qH2
	 qiqZokoKZrYvewCn6SJt3ETQsWmMbPUgDpsGuCmxuRoTf0Kk7t3eI7fnGIxDc8z1KoStw
	 HDkUP83GhDKdgtvKSiYbYCH2aOva6WUP3VWTqfJxV1oFN4qkVM1pToPU5AI0G87Xn1x0b
	 WZSkPqosdr4L4GHDFqGqOpBj8UiIe5GL8y+G/8kjKu+1J/lgewnPXaEu84Rjr5Bb+sxvZ
	 gySjx3Ikj7QLu7ffCk/cQBrOeV/EBFxSpnXy6X1hoC0a9u1rWjBA5ElghBF5DfTFaxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392863;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k0B3UfgQB/D8vYRdJmCukT9HrfQad+gn9eBgWfJ7V6I=;
	b=BavgekzK+73gpEvJLYjczljjVcteoQkkY2lbwSANDVhEIgaoV0BKDWK594IUYRvRZyBx
	 m+hpKx5nbmh24meDhxA8Q7txSQqJSigzuuk5Nf1/kmy9zDDpbPKl0XQ16WWEpna50faHc
	 nnqXd5X9By0gVUyid/pGCG6C98L+bJk9obp4HJQ/NiBXUYFl9AfO7QhIiziK8GKrrWNzQ
	 M93T/JofeXU27KR0WN50Ythz0GrZ3oqUeLmjS2ozyTQRaxpJw1u8qC56LR2BpKhMIk+i9
	 Q11699QfJzHUqYhdCu6I/591SMdzjmIld8ytUbiFra6RL+ERIIv8K06zb1ujjAsVyKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=rP54EsoB;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 5F55F606A8BA
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F55F606A8BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=rP54EsoB
Received: from kero.packetmixer.de (p200300c59740deD843bE7e4A980e9c65.dip0.t-ipconnect.de [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 9241BFA2F1;
	Wed, 11 Nov 2026 11:27:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0B3UfgQB/D8vYRdJmCukT9HrfQad+gn9eBgWfJ7V6I=;
	b=rP54EsoBoKySbRouSkdQwtz/NnxKTDKb/tdp3ZVF5VMUkxro3oiGoLu5ToDuLpzgOi1vwM
	CFP7KJSLqboDYHsmZl8IYXYRNi4uk5np5zQHLQZl09r4PGf/7id0DFIqoE9v3ztvtvy48C
	yMzRhWMXn+tu3X6w28boyPK50vU++4qLlaMjGhvJYOVdq2RJ4wCESjKv/S+QPFM7zL/9xQ
	1flOBQs/POKUEurdN4UjbvuZhwvQE6lYvBtWyeYYQ7+9ZCXpN4rk5bmnwhS1kjvxCmxvzy
	NbD9vcVfx6vZjA/NYgxneHDWKcyPJhMfLqn2QJp53MDyh016ouFaKYnKnfBsng==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 14/15] batman-adv: use bool for boolean flags
Date: Wed, 11 Nov 2026 11:27:28 +0100
Message-ID: <20261111102729.2096241-15-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
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

From: Sven Eckelmann <sven@narfation.org>

A few flags are stored in int or u8 although they only ever hold true or
false:

* the own_packet parameter of the B.A.T.M.A.N. IV OGM queueing functions
* batadv_forw_packet::own, whose kerneldoc already calls it a bool
* is_old_ttvn in batadv_check_unicast_ttvn(), which stores the result of
  batadv_seq_before()

Use bool for them, and pass true/false instead of 1/0.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 10 +++++-----
 net/batman-adv/routing.c    |  2 +-
 net/batman-adv/types.h      |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 9e529215a7908..0b2134a8f963a 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -623,7 +623,7 @@ static bool batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 					bool direct_link,
 					struct batadv_hard_iface *if_incoming,
 					struct batadv_hard_iface *if_outgoing,
-					int own_packet)
+					bool own_packet)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct batadv_forw_packet *forw_packet_aggr;
@@ -716,7 +716,7 @@ static bool batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 				    int packet_len,
 				    struct batadv_hard_iface *if_incoming,
 				    struct batadv_hard_iface *if_outgoing,
-				    int own_packet, unsigned long send_time)
+				    bool own_packet, unsigned long send_time)
 {
 	/* _aggr -> pointer to the packet we want to aggregate with
 	 * _pos -> pointer to the position in the queue
@@ -843,7 +843,7 @@ static void batadv_iv_ogm_forward(struct batadv_orig_node *orig_node,
 
 	batadv_iv_ogm_queue_add(bat_priv, (unsigned char *)batadv_ogm_packet,
 				BATADV_OGM_HLEN + tvlv_len,
-				if_incoming, if_outgoing, 0,
+				if_incoming, if_outgoing, false,
 				batadv_iv_ogm_fwd_send_time());
 }
 
@@ -955,7 +955,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		 * respective interfaces.
 		 */
 		scheduled = batadv_iv_ogm_queue_add(bat_priv, ogm_buff->buf, ogm_buff->len,
-						    hard_iface, hard_iface, 1, send_time);
+						    hard_iface, hard_iface, true, send_time);
 		if (!scheduled)
 			reschedule = true;
 
@@ -972,7 +972,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 
 		scheduled = batadv_iv_ogm_queue_add(bat_priv, ogm_buff->buf,
 						    ogm_buff->len, hard_iface,
-						    tmp_hard_iface, 1, send_time);
+						    tmp_hard_iface, true, send_time);
 		batadv_hardif_put(tmp_hard_iface);
 
 		if (!scheduled && tmp_hard_iface == hard_iface)
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 79fad88cd039c..e2951bf047024 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -891,7 +891,7 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	struct batadv_orig_node *orig_node;
 	struct ethhdr *ethhdr;
 	unsigned short vid;
-	int is_old_ttvn;
+	bool is_old_ttvn;
 	u8 curr_ttvn;
 	u8 old_ttvn;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 0fece14c7e7f8..b3edfc71af4a7 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2047,7 +2047,7 @@ struct batadv_forw_packet {
 	 * @own: bool for locally generated packets (local OGMs are re-scheduled
 	 * after sending)
 	 */
-	u8 own;
+	bool own:1;
 
 	/** @skb: bcast packet's skb buffer */
 	struct sk_buff *skb;
-- 
2.47.3

