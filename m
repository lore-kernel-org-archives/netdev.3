Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492C143CE7E
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769121; cv=none; b=Dcy/xZ8M089119ALjYsZrYm2ND0f5uWW1pOMr/ImDlh8OXDk3XCS0q6qRqM0AMEvH6e0TA4jUl7RmIU3d+qtkHeCx2wD1TdGiC4H79gV6+2TI6yCipw+My9np9g0pxrLeUdOdvH937VT7cBvJcQf4u6VB+6Tv5xrY+9RaRvywUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769121; c=relaxed/simple;
	bh=eSQKYN7jvrvaC+GrYx1ISgeI/NJf8mbQM6xFfw8yYWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECrO/trgm1TMFYUj/YcfBQU9bKbf/8rNuyKlp9YXO2qorclER2TjX0JWcRuDhtuwDn/4ESu6ZnbTOIXlCeiO1ep06EhzC2elqNsvGJUeIFGdGbQiU+crM5FTolWLxJE/zFXEsXI70iTQyTbeYyJyPzJN9zS7r8kW5i6oy+oUpOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=VpFMlUAK; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="VpFMlUAK"
Received: from kero.packetmixer.de (p200300c59748d0d8c3747188E6dfE6C0.dip0.t-ipconnect.de [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 9E1ECFA2C0;
	Mon, 07 Sep 2026 10:18:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZS6+oQjD9GI7kf3P/jASgDZaJ06znEuCzZF/IioT7eU=;
	b=VpFMlUAKVDyDf1WYyzatgIgfLNje7G9/5N3n9iB0FBt7g05X+umcQ3Wlgg5Vh6R2L8kx4Q
	80KV+eEKZGlJR6MWleUCoKqwmMqwBrYNhiivkg3r5PSewyDff6mTuy/SkdfwfZElyhXCsu
	bZYUp++TKUX+XgJfWw4S+EnpSv9ZHUQRy8WwJ8ExXsI729I1wXe0TSvuQFKSg7Hi+dlANw
	sTBffd3QBf2zlggTYtNhu9DinarFi4KCCpt6ETikvH4vBOYJ4qPp5sQzZBvIerLYc4y5aL
	IxVz/AMelO2Yn02afgbaJxQlZSABS5eMZ7tyIC6sYXKRbB8xYalJiKilpR1qbg==
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
Subject: [PATCH net-next 11/15] batman-adv: tt: extract immediate purge of a local entry
Date: Mon,  7 Sep 2026 10:18:20 +0200
Message-ID: <20260907081824.2474040-12-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

A client which was added after the last ttvn increment was never announced
and can be dropped from the local table right away. The code doing so is
the second half of batadv_tt_local_remove() and needed a goto to skip the
accounting when the entry was already gone from the hash.

Move it to batadv_tt_local_remove_now().

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 57 +++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index f5b753ed1ae1a..9f61797c64920 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1475,6 +1475,42 @@ batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
 	return pending;
 }
 
+/**
+ * batadv_tt_local_remove_now() - purge a local entry which was never announced
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_local_entry: local TT entry to purge
+ *
+ * A client which was added right after the last ttvn increment was never sent
+ * to the other nodes. It can therefore be dropped from the local table without
+ * waiting for the next ttvn increment.
+ */
+static void
+batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
+			   struct batadv_tt_local_entry *tt_local_entry)
+{
+	struct batadv_tt_common_entry *common = &tt_local_entry->common;
+	struct hlist_node *tt_removed_node;
+
+	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
+
+	/* remove exactly this object when still present in hash */
+	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
+					     batadv_compare_tt_entry,
+					     batadv_choose_tt, common);
+	if (!tt_removed_node)
+		return;
+
+	/* batadv_tt_local_transition_new() may have committed the entry and
+	 * thus counted it in the local table size since the
+	 * BATADV_TT_CLIENT_NEW check in batadv_tt_local_mark_removed().
+	 */
+	if (!(batadv_tt_flags_get(common) & BATADV_TT_CLIENT_NEW))
+		batadv_tt_local_size_dec(bat_priv, common->vid);
+
+	/* drop reference of remove hash entry */
+	batadv_tt_local_entry_put(tt_local_entry);
+}
+
 /**
  * batadv_tt_local_remove() - logically remove an entry from the local table
  * @bat_priv: the bat priv with all the mesh interface information
@@ -1490,7 +1526,6 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 			   bool roaming)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
-	struct hlist_node *tt_removed_node;
 	u16 curr_flags = BATADV_NO_FLAGS;
 	bool pending = false;
 	u16 flags;
@@ -1518,25 +1553,7 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	/* if this client has been added right now, it is possible to
 	 * immediately purge it
 	 */
-	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
-
-	/* remove exactly this object when still present in hash */
-	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
-					     batadv_compare_tt_entry,
-					     batadv_choose_tt,
-					     &tt_local_entry->common);
-	if (!tt_removed_node)
-		goto out;
-
-	/* batadv_tt_local_transition_new() may have committed the entry and
-	 * thus counted it in the local table size since the BATADV_TT_CLIENT_NEW
-	 * check above.
-	 */
-	if (!(batadv_tt_flags_get(&tt_local_entry->common) & BATADV_TT_CLIENT_NEW))
-		batadv_tt_local_size_dec(bat_priv, tt_local_entry->common.vid);
-
-	/* drop reference of remove hash entry */
-	batadv_tt_local_entry_put(tt_local_entry);
+	batadv_tt_local_remove_now(bat_priv, tt_local_entry);
 
 out:
 	batadv_tt_local_entry_put(tt_local_entry);
-- 
2.47.3

