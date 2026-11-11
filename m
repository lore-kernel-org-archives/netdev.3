Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392862;
	b=5Nqr1VL/41+Y+2NtwB8SBvXpQW6/tV8ZNLtMGWU8G++cC2jW07HGS0QXHh6iZx07qILH
	 1aefnLHOe45btLxR4eGxaPEaVDfLz3kq0o7Zqh8eyY68ikbhT+N9PD42P2kJSsC+K/mg3
	 JOyPC+nIxrc0xnrQQyCk8zpItdtz996QNAof9YAj39+bvBb6m9mqqBElz/m7mj5/Njsk4
	 fk1lXJBzgdfAw9XObWkoMGmVX4T/32lHlBfdCYQnxiP7u2CdMBUZ4CGLLiwREzpb3UxIm
	 lgtOYwvhqJXEPrnUM6jfzDPEW8yBf2Z1KEuX/GCcjukjPa0PV68qQvTvUKAM5nyffYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392862;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9QKOMeV0vIGITZxOlcL8FwOZGUAIGR/9wBMhtY2e9ao=;
	b=Au6NbBIoXB58OhqGHo+EWZq6OrJ81bcdRPpebeU2PpTjZJG9irIZMIZuDq8xY9kX8b7s
	 Ts/+k5SmRpZviEmpLrk/4tVC+Gc/81agc+LLfDP2DfB7e4+QjtEokDp6ml+LrR4WMAAnw
	 2787BBof+RVdcad9De0w9AuoOsqHeNQcp07hNEYXz6WDxmV4hsjD67E3rl/Rpq3zqSMPC
	 fw40uRYrs26RmMY6d1tQSSgS3P4gqUlFP48pbuUyKJCcugRPmfORrhnDggtHgNvidvi2O
	 uBcCxcvJ++RLpphPBcRtSOCI3tp6hPoUiBSe4Ld7dp3XLx4EHNZWFu8ZxkaQwm40UNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=jGpwnbn1;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 16AE9606A88B
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16AE9606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=jGpwnbn1
Received: from kero.packetmixer.de (p200300c59740deD843BE7e4a980E9c65.dip0.t-ipconnect.de [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id D0BF4FA2ED;
	Wed, 11 Nov 2026 11:27:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9QKOMeV0vIGITZxOlcL8FwOZGUAIGR/9wBMhtY2e9ao=;
	b=jGpwnbn1W+NnSk9/c/bB3FaXWXWdTR7fh2m8d9vQxaZmLXqmyWAPslA+PhtlCc5ihQx00i
	m/2BUldDx6YoPWAeuha1uCy1rXQ4ob8Cwr7rJlp03Qg/64niyROjpFDJNApSQyCKmaIiFV
	uvrVw/pxP1XGjsqTvz1D/WXV7OVgdRx19cKAx8eFoVTRL/S7+l0X4sA3ZD1aPT+oH/gTW0
	WU/kk5kY+NtTwky/6aoKxAqr7OVC9o2Unkd7kpGmsX1eiF4Z98pTPqOZDMiht7KMcAd9EZ
	o7vo282k+PVNpmv+4o9WvLtJwOtUCQMShCpTo8yJ/azAjNILfqplD04vTR8lHA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 10/15] batman-adv: annotate neigh_node last_seen with READ/WRITE_ONCE
Date: Wed, 11 Nov 2026 11:27:24 +0100
Message-ID: <20261111102729.2096241-11-sw@simonwunderlich.de>
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

The last_seen field for batadv_neigh_node tracks the jiffies value of the
most recent activity and is used to detect timeouts. These accesses are not
consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used to
prevent data races caused by compiler optimizations.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-6ad653e2-1ce9-4124-bdf2-2187de5a2c16
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 4 ++--
 net/batman-adv/bat_v_elp.c  | 6 ++++--
 net/batman-adv/bat_v_ogm.c  | 2 +-
 net/batman-adv/originator.c | 4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index ee3a5ac465012..d4b6c09db8c7d 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1169,7 +1169,7 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	if (!neigh_ifinfo)
 		goto out;
 
-	neigh_node->last_seen = jiffies;
+	WRITE_ONCE(neigh_node->last_seen, jiffies);
 
 	spin_lock_bh(&neigh_node->ifinfo_lock);
 	batadv_ring_buffer_set(neigh_ifinfo->bat_iv.tq_recv,
@@ -1289,7 +1289,7 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 
 	/* if orig_node is direct neighbor update neigh_node last_seen */
 	if (orig_node == orig_neigh_node)
-		neigh_node->last_seen = jiffies;
+		WRITE_ONCE(neigh_node->last_seen, jiffies);
 
 	WRITE_ONCE(orig_node->last_seen, jiffies);
 
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 6ad6042a5d9b6..cf84aed0c947e 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -506,6 +506,7 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 	struct batadv_hardif_neigh_node *hardif_neigh;
 	struct batadv_orig_node *orig_neigh;
 	struct batadv_neigh_node *neigh;
+	unsigned long last_seen;
 	s32 elp_latest_seqno;
 	s32 seqno_diff;
 
@@ -531,8 +532,9 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 	if (seqno_diff < 1 && seqno_diff > -BATADV_ELP_MAX_AGE)
 		goto hardif_free;
 
-	neigh->last_seen = jiffies;
-	hardif_neigh->last_seen = jiffies;
+	last_seen = jiffies;
+	WRITE_ONCE(neigh->last_seen, last_seen);
+	hardif_neigh->last_seen = last_seen;
 	hardif_neigh->bat_v.elp_latest_seqno = ntohl(elp_packet->seqno);
 	hardif_neigh->bat_v.elp_interval = ntohl(elp_packet->elp_interval);
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 03c70d91e64d1..cf3c1d22761b9 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -658,7 +658,7 @@ static int batadv_v_ogm_metric_update(struct batadv_priv *bat_priv,
 		goto out;
 
 	last_seen = jiffies;
-	neigh_node->last_seen = last_seen;
+	WRITE_ONCE(neigh_node->last_seen, last_seen);
 	WRITE_ONCE(orig_node->last_seen, last_seen);
 
 	orig_ifinfo->last_real_seqno = ntohl(ogm2->seqno);
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 3b925ba9c9723..352a88056e334 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -698,7 +698,7 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 	kref_get(&hard_iface->refcount);
 	ether_addr_copy(neigh_node->addr, neigh_addr);
 	neigh_node->if_incoming = hard_iface;
-	neigh_node->last_seen = jiffies;
+	WRITE_ONCE(neigh_node->last_seen, jiffies);
 
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 	ACCESS_PRIVATE(neigh_node, orig_node_id) = orig_node;
@@ -1126,7 +1126,7 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
 	/* for all neighbors towards this originator ... */
 	hlist_for_each_entry_safe(neigh_node, node_tmp,
 				  &orig_node->neigh_list, list) {
-		last_seen = neigh_node->last_seen;
+		last_seen = READ_ONCE(neigh_node->last_seen);
 		if_incoming = neigh_node->if_incoming;
 
 		if (batadv_has_timed_out(last_seen, BATADV_PURGE_TIMEOUT) ||
-- 
2.47.3

