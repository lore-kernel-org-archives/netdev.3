Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D296230264
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769118; cv=none; b=e/CTPUsN/fRxmwXVJqan0VXuKRNS6YMeaJxZXDpE+w6PqlGvO4IwG/V20CbHK+oT49wexLIVxj3yV5rNhx/B5dLXiS9nP7XuBISy8f9IkOSFFBdNgE+vDgzMkNL4TOPy8HVfTJM43BGKG6cXxtyNwBPIYo3WzYn+VElbCsXQNdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769118; c=relaxed/simple;
	bh=y/R31qSZUhjWgxsOYh3YsIEum2qUwr2/c2156BwD5II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxT0ChhihcYpe/Ugvq23u7p5oOB7Lpnx8Emu83JVquLt36LVsMMEctQwu5tMG4JDz9IaAVe5D2Q6OE/QFlI7yQOPqX5E7OAv7+9ukti4bx7h7QOq1ehu5T09SIdm/h0r7XanmghZOvdRj/z97rqnxiNtpnizKr2Ef375ZGTNivQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=T1iTFBDb; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="T1iTFBDb"
Received: from kero.packetmixer.de (p200300C59748d0d8c3747188e6dfE6C0.dip0.t-ipconnect.de [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id C7E98FA133;
	Mon, 07 Sep 2026 10:18:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRcYI0Qa4jD6HPqhMI0gjRr/Hmwnmtlo6Q7G3gFIZUs=;
	b=T1iTFBDbqH6t47yS1gzOLar1dQrH69w6leb3W+Nozb9LdqhAJ+SNPQEUBqtjVjrIoEa6CG
	H+ewUq5HkXH1e54yzQoAmv6UyzT2TXlFIpceUd6B15zAwmnBaShP0h3rt0nDDcTHB4TmoT
	Mm5nj4ZfjzTr3E3VpubA4VbFKgprcTVyeHlLf2aCueSUHj12L+AmWX6jLaNFAsCfmHtL4g
	ehfcHqf6cJb9YskF3RzixOYmCDCHvI7L7OgjGL9RI+xZDUi7XsR/y79bxMgeESrVRWC5xs
	9MFPZ/AFtWFR68LS969NQ7foyu9Db7mnqvKdsz9WR4ux92qym4OEZZRQrBjMeA==
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
Subject: [PATCH net-next 03/15] batman-adv: tt: replace forward gotos in batadv_tt_local_add()
Date: Mon,  7 Sep 2026 10:18:12 +0200
Message-ID: <20260907081824.2474040-4-sw@simonwunderlich.de>
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

batadv_tt_local_add() used two labels in the middle of the function to
express which parts of the common tail have to be executed: "add_event" to
announce a (re-)added client and "check_roaming" to skip that announcement.
Jumping forward into the middle of a function makes it hard to see which
path ends up sending an ADD event. Especially since the PENDING branch
reached "add_event" while the branch right below it reached "check_roaming"
instead.

Express the same in an "added" variable and turn the two client cases into
a plain if/else. The PENDING check returned early before the ROAM check
could run, so it becomes an "else if".

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 43 ++++++++++++++----------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2bc243f0fa699..5d5f270b7eb4c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -818,6 +818,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_tt_global_entry *tt_global = NULL;
 	struct batadv_tt_local_entry *tt_local;
 	bool roamed_back = false;
+	bool added = false;
 	bool iif_is_wifi;
 	bool ret = false;
 	u8 remote_flags;
@@ -846,12 +847,8 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			 * flag can be reset like it was never enqueued
 			 */
 			tt_local->common.flags &= ~BATADV_TT_CLIENT_PENDING;
-			spin_unlock_bh(&tt_local->common.flags_lock);
-
-			goto add_event;
-		}
-
-		if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
+			added = true;
+		} else if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
 			batadv_dbg(BATADV_DBG_TT, bat_priv,
 				   "Roaming client %pM (vid: %d) came back to its original location\n",
 				   addr, batadv_print_vid(vid));
@@ -864,29 +861,29 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			roamed_back = true;
 		}
 		spin_unlock_bh(&tt_local->common.flags_lock);
+	} else {
+		tt_local = batadv_tt_local_create(mesh_iface, addr, vid, iif_is_wifi);
+		if (!tt_local)
+			goto out;
 
-		goto check_roaming;
-	}
-
-	tt_local = batadv_tt_local_create(mesh_iface, addr, vid, iif_is_wifi);
-	if (!tt_local)
-		goto out;
+		kref_get(&tt_local->common.refcount);
+		hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
+					     batadv_choose_tt, &tt_local->common,
+					     &tt_local->common.hash_entry);
 
-	kref_get(&tt_local->common.refcount);
-	hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
-				     batadv_choose_tt, &tt_local->common,
-				     &tt_local->common.hash_entry);
+		if (unlikely(hash_added != 0)) {
+			/* remove the reference for the hash */
+			batadv_tt_local_entry_put(tt_local);
+			goto out;
+		}
 
-	if (unlikely(hash_added != 0)) {
-		/* remove the reference for the hash */
-		batadv_tt_local_entry_put(tt_local);
-		goto out;
+		added = true;
 	}
 
-add_event:
-	batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
+	/* announce the (re-)added client to the mesh */
+	if (added)
+		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
 
-check_roaming:
 	batadv_tt_local_add_roam(bat_priv, tt_global, roamed_back);
 
 	spin_lock_bh(&tt_local->common.flags_lock);
-- 
2.47.3

