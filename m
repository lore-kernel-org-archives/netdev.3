Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392863;
	b=WCXiLXEk1Afw2j/95arYRPKQrmeuqKliYxddJjTVHgFj0zJV4c2BovHu/8bhzxu6fvyS
	 3vKyaXsz38se3JdEokg2EClDOW/IBi5F4Fimq/6MGq2kZlrEvXGfKNOZnd4vAr4W0yOQp
	 NDWE/quZPU5vVblN4bTAm+M7aEJwaqDGnj5YtPY5LjegwekAAWXzLBoRyW6uuZPbhKG4n
	 BL/KETZv/GpM/UL2/MAAFSHFMlKYwZ+cWnlaCbVC7L0s9ZU8FAI5Nk4e6sYvB3HVFMNVF
	 qbsAHbZr8VrVtPOBg1CT1VoOt1nPts5TXtqtT99ZHrfDUpRNSWJAAYE/vKNuj9FalHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392863;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kqq7QJp+oe/MI0HfV6CR+NZX7tzpT/m/ilc9QLSDs5s=;
	b=IiDXBgoV/CKcj2QMvr28yn53vQYezYjA/QxaC2uspw05K0WfB/lHC1EoLq/F8kZsgvLN
	 yBOVwjVSH1Nabw/fUU5jUq0Ep1skaGe9vCgtdFv6He9UKSes1T1Be8II7UcofVWDfE/uM
	 j/CmFl9KIfy6uX5hvJwvapYpgyUJkA7RcZeTVuWw9REqInGdykaZXJ6HzOtUgUWSUqtXp
	 FyhvkTfivrx8ojfh5Bycwh7FEukXjG9VrRK5Wy8lkSI/lj8RNtWAs24O4an8kZMtzHxS9
	 ZZBjb5KgtX0uN1CJuCh9r15UT0xt4SE+W0nIy4BF7C+qsuptq65vEgeKbJdzJHFbsbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=TeFlIHpr;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 49857606A8B7
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49857606A8B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=TeFlIHpr
Received: from kero.packetmixer.de (p200300c59740deD843Be7e4A980e9c65.dip0.t-ipconnect.de [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 9989BFA2EE;
	Wed, 11 Nov 2026 11:27:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqq7QJp+oe/MI0HfV6CR+NZX7tzpT/m/ilc9QLSDs5s=;
	b=TeFlIHprzFyctCW3axtbf2Gixwcf3JCP4TRZSvCpNvBghbp4Izq8M+c5I0lJs8kGkjGipH
	+5YV+tvs4vTslxT/jFLz45Jxuj8/3fUiqzvJi8ToUd0uFMcTmKkApCxamSMVRL2gS2ZjGp
	1aticfZRQRIiiADc7YimhHjYbBn4SYeXAqaBbFjk63pOkJS5TNXLi7AZM8mW3jXvUAlbfF
	/xN7itJroOL0+mZQ+O/t8wK1XZMkmFhuJLhPsqntqksjzeAf/RP9uw3NZHQxfHdZlF1mnJ
	k2rqBPXo0iY4kK+UqdBoIZpVtzzl8UeivxbQ64f5yGlnuS3OXXItghHpG2/nJQ==
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
Subject: [PATCH net-next 11/15] batman-adv: annotate hardif_neigh_node last_seen with READ/WRITE_ONCE
Date: Wed, 11 Nov 2026 11:27:25 +0100
Message-ID: <20261111102729.2096241-12-sw@simonwunderlich.de>
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

The last_seen field for batadv_hardif_neigh_node tracks the jiffies value
of the most recent activity and is used to detect timeouts. These accesses
are not consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be
used to prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jiffies vs
last_seen, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 6 ++++--
 net/batman-adv/bat_v.c      | 4 +++-
 net/batman-adv/bat_v_elp.c  | 2 +-
 net/batman-adv/originator.c | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index d4b6c09db8c7d..4e15af1e245a5 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1569,7 +1569,7 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 		hardif_neigh = batadv_hardif_neigh_get(if_incoming,
 						       ethhdr->h_source);
 		if (hardif_neigh)
-			hardif_neigh->last_seen = jiffies;
+			WRITE_ONCE(hardif_neigh->last_seen, jiffies);
 	}
 
 	router = batadv_orig_router_get(orig_node, if_outgoing);
@@ -2287,9 +2287,11 @@ batadv_iv_ogm_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 			       struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	unsigned int last_seen_msecs;
+	unsigned long last_seen;
 	void *hdr;
 
-	last_seen_msecs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen);
+	last_seen = READ_ONCE(hardif_neigh->last_seen);
+	last_seen_msecs = jiffies_delta_to_msecs(jiffies - last_seen);
 
 	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
 			  NLM_F_MULTI, BATADV_CMD_GET_NEIGHBORS);
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 2679090c3368b..bd2bf2b58635e 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -161,10 +161,12 @@ batadv_v_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 			  struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	unsigned int last_seen_msecs;
+	unsigned long last_seen;
 	u32 throughput;
 	void *hdr;
 
-	last_seen_msecs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen);
+	last_seen = READ_ONCE(hardif_neigh->last_seen);
+	last_seen_msecs = jiffies_delta_to_msecs(jiffies - last_seen);
 	throughput = ewma_throughput_read(&hardif_neigh->bat_v.throughput);
 	throughput = throughput * 100;
 
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index cf84aed0c947e..144bb30d608a8 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -534,7 +534,7 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 
 	last_seen = jiffies;
 	WRITE_ONCE(neigh->last_seen, last_seen);
-	hardif_neigh->last_seen = last_seen;
+	WRITE_ONCE(hardif_neigh->last_seen, last_seen);
 	hardif_neigh->bat_v.elp_latest_seqno = ntohl(elp_packet->seqno);
 	hardif_neigh->bat_v.elp_interval = ntohl(elp_packet->elp_interval);
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 352a88056e334..0f47ac3ecc967 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -587,7 +587,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 	ether_addr_copy(hardif_neigh->addr, neigh_addr);
 	ether_addr_copy(hardif_neigh->orig, orig_node->orig);
 	hardif_neigh->if_incoming = hard_iface;
-	hardif_neigh->last_seen = jiffies;
+	WRITE_ONCE(hardif_neigh->last_seen, jiffies);
 
 	kref_init(&hardif_neigh->refcount);
 
-- 
2.47.3

