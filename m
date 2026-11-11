Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392863;
	b=4ZzHuU1bLnAuH0+0+yfdHJSa2rNYYcTPQYb/hY6r09IJZr42OML+N5FwEq6cxQXULp02
	 MZmbej5IQVPIac/OOUcIIf0u2MxmskYzdpeO9IYEP/kKVkNieeKC0yiHSdAHgqoI8rFpf
	 jinfImPPau3NgMCO39y9vf5nvI9ZE4NqlKuSc/hx5xWAst6zVihluAdL/UHKwQ12ZKobi
	 cC5pemv4d0R5y4tMcyGOAjz/vsGABR8WrCKHcSw3CgZ0w7rX/tQm2vibiEWY8Y+DsnVok
	 K4OAHz+HTReecZer2SgwETcYB1GHKV+Py3wzA0LBaw5f1pZwoigUUZSLuceQ+3X9JKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392863;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8izr6JBjAAVusJ1VnVGQY41b0QUV+OE5YoCdMUYPcvI=;
	b=IyU4l8iIjCXa1rs2XzDj3kvDCIgxi7JJWNY/ODhF9W0Ce1UsH0r9VzS497XjjOCeDbh9
	 Ut9GnOvn1h2vCcYsFI1ynVtZ3sX7W/7guR+JYPJMF493wvAtE+mSdp2ddDf7XZiauTo/5
	 C7ZSgaYso98PdHI8cz+6CQnsTztjaR4f23vXwG4314ipUzF/27OzmeHuU5b7pzuRDPRf0
	 r8bN4oFjeDU0XcaN+wtG73hOC+43reEim8XIixtXcHd9Az7OkK2XqOnpxOPGaYnZlNWjp
	 SQ8/RzNLUx5ei9MezH7s9AMucGYZSDcrkgaGjXEIST+VYoPvOkzxbaR8OCXLV0g6vyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b="FeD/m8YU";
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0C551606A88A
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C551606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=FeD/m8YU
Received: from kero.packetmixer.de (p200300c59740DED843bE7e4a980e9C65.dip0.t-ipconnect.de [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 3E17CFA273;
	Wed, 11 Nov 2026 11:27:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8izr6JBjAAVusJ1VnVGQY41b0QUV+OE5YoCdMUYPcvI=;
	b=FeD/m8YUH6MxOjiTcF3amNRUMNhe/l78SKBDDEknsh4Lgg0qElsq4vuLIyIR7et2FOteHb
	qnX+5oF8HCv2N2zGBBddAjP67C188nRQYUp2xK+P6k2+qLdyqyP+NL+FKF2wibIZXYyah+
	5Sez9ijKcO7dmWZlvp0SqFu2YTErcmi/QiPQ/i57QH8Rt3s47MtAfGGVJq++4TBom2f8oU
	FdWO0xErsUqO81fdXQ8DhLMYi63rPdesCC8uk0Zp3vzh5l1ubHXTqDzhmP6IhrM+5NFqyY
	AYt253eIVYBqiSwVmYl4ARjcFvWQFTsOLKHslrqpxjz/V2X9T6uE9j/kjW3FYg==
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
Subject: [PATCH net-next 09/15] batman-adv: annotate originator last_seen with READ/WRITE_ONCE
Date: Wed, 11 Nov 2026 11:27:23 +0100
Message-ID: <20261111102729.2096241-10-sw@simonwunderlich.de>
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

The last_seen field for batadv_orig_node tracks the jiffies value of the
most recent activity and is used to detect timeouts. These accesses are not
consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used to
prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jiffies vs
last_seen, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 6 ++++--
 net/batman-adv/bat_v.c      | 4 +++-
 net/batman-adv/bat_v_ogm.c  | 7 ++++---
 net/batman-adv/originator.c | 8 +++++---
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 85e99506a53f5..ee3a5ac465012 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1291,7 +1291,7 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	if (orig_node == orig_neigh_node)
 		neigh_node->last_seen = jiffies;
 
-	orig_node->last_seen = jiffies;
+	WRITE_ONCE(orig_node->last_seen, jiffies);
 
 	/* find packet count of corresponding one hop neighbor */
 	orig_eq_count = batadv_iv_orig_ifinfo_sum(orig_neigh_node, if_incoming);
@@ -2045,10 +2045,12 @@ batadv_iv_ogm_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 				 bool best)
 {
 	unsigned int last_seen_msecs;
+	unsigned long last_seen;
 	void *hdr;
 	u8 tq_avg;
 
-	last_seen_msecs = jiffies_to_msecs(jiffies - orig_node->last_seen);
+	last_seen = READ_ONCE(orig_node->last_seen);
+	last_seen_msecs = jiffies_delta_to_msecs(jiffies - last_seen);
 
 	if (!batadv_iv_ogm_neigh_get_tq_avg(neigh_node, if_outgoing, &tq_avg))
 		return 0;
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 4a25e513864ca..2679090c3368b 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -302,6 +302,7 @@ batadv_v_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 {
 	struct batadv_neigh_ifinfo *n_ifinfo;
 	unsigned int last_seen_msecs;
+	unsigned long last_seen;
 	u32 throughput;
 	void *hdr;
 
@@ -313,7 +314,8 @@ batadv_v_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 
 	batadv_neigh_ifinfo_put(n_ifinfo);
 
-	last_seen_msecs = jiffies_to_msecs(jiffies - orig_node->last_seen);
+	last_seen = READ_ONCE(orig_node->last_seen);
+	last_seen_msecs = jiffies_delta_to_msecs(jiffies - last_seen);
 
 	if (if_outgoing != BATADV_IF_DEFAULT &&
 	    if_outgoing != neigh_node->if_incoming)
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 70846c997410d..03c70d91e64d1 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -626,6 +626,7 @@ static int batadv_v_ogm_metric_update(struct batadv_priv *bat_priv,
 	struct batadv_neigh_ifinfo *neigh_ifinfo = NULL;
 	struct batadv_orig_ifinfo *orig_ifinfo;
 	bool protection_started = false;
+	unsigned long last_seen;
 	u32 path_throughput;
 	int ret = -EINVAL;
 	s32 seq_diff;
@@ -656,9 +657,9 @@ static int batadv_v_ogm_metric_update(struct batadv_priv *bat_priv,
 	if (seq_diff < 0 && !protection_started)
 		goto out;
 
-	neigh_node->last_seen = jiffies;
-
-	orig_node->last_seen = jiffies;
+	last_seen = jiffies;
+	neigh_node->last_seen = last_seen;
+	WRITE_ONCE(orig_node->last_seen, last_seen);
 
 	orig_ifinfo->last_real_seqno = ntohl(ogm2->seqno);
 	orig_ifinfo->last_ttl = ogm2->ttl;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index f06583ef9b3f5..3b925ba9c9723 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -977,7 +977,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	WRITE_ONCE(orig_node->last_ttvn, 0);
 	orig_node->tt_buff = NULL;
 	orig_node->tt_buff_len = 0;
-	orig_node->last_seen = jiffies;
+	WRITE_ONCE(orig_node->last_seen, jiffies);
 	reset_time = jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
 	orig_node->bcast_seqno_reset = reset_time;
 
@@ -1210,16 +1210,18 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 {
 	struct batadv_neigh_node *best_neigh_node;
 	struct batadv_hard_iface *hard_iface;
+	unsigned long last_seen;
 	struct list_head *iter;
 	bool changed_ifinfo;
 	bool changed_neigh;
 
-	if (batadv_has_timed_out(orig_node->last_seen,
+	last_seen = READ_ONCE(orig_node->last_seen);
+	if (batadv_has_timed_out(last_seen,
 				 2 * BATADV_PURGE_TIMEOUT)) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Originator timeout: originator %pM, last_seen %u\n",
 			   orig_node->orig,
-			   jiffies_to_msecs(orig_node->last_seen));
+			   jiffies_to_msecs(last_seen));
 		return true;
 	}
 	changed_ifinfo = batadv_purge_orig_ifinfo(bat_priv, orig_node);
-- 
2.47.3

