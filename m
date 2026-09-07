Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CC643C054
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769120; cv=none; b=OdAfqK7VElUxmLX5KzLiDcQxRMiYMRLdE/FZeBU2pjgXAqyTnvIYlC6p5931HE5dfdIuubzR1RKUZ6sV75Yl14qEgreV+sdEaZWYqw9si3RU0NP7DqD8mCG0Dgu4/xwo28niXQESCrrhd+2Ae4qYMB+XWGcSDXhrGgS6Q7R7TQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769120; c=relaxed/simple;
	bh=akta6jdZZHEsSh4vHgOyJXzKr26rcGiRd0yWcdbMlPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=js5aOLMzUFoeNjmiuDZopOI7lj1YBADYnyFmiXLjdlOfTRrp+zx0rGVPL6/LuhPGWChPKpcbQNWtq08zDzJmoN1vAY2+89berliaJYBoXnnywGOJmjey2Y2+q3UyZ37/LeDBxM5xWkU1bEkkP7pU8VIpQWTGoZ754KQ0OngaZR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=qK6w/p9/; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="qK6w/p9/"
Received: from kero.packetmixer.de (p200300C59748D0d8C3747188e6DFE6c0.dip0.t-ipconnect.de [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 77F76FA1AD;
	Mon, 07 Sep 2026 10:18:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wYDAT1YzP/l1jEHF3Ntt6E7R95zh/mzRvcUkHQKOlLM=;
	b=qK6w/p9/X+FbdzE+DEs92EOHXSAgEHtz/94E4Fknro/tm2sEWz7fabp51RE+s1GGYZTdnb
	NYZRYOeMGE9oaTfSw0y/Y9aCwNqE02lQ6gJFP9q5wkOcOrTaFaZCHFkhAzRVT/4oUJq3Ko
	F/WxW889UXoOJpc15vC7dkH0OgrUUaljXKBTR/Fqpnwrtt4fxcbFutCBCZ0tjqiPPQfhRL
	j2QHgKLR/NUfqC1kXihjlUFZYQAo1FRnP9knvn8RtTjkiQig5JpMXvNOFBciPMXeqAtPW1
	G/ehm+3zgnJmoZ/1k0nS7FNJbXDgjgY0qOcCr4KeibqiZlgw9L/NFpTkI+cyKw==
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
Subject: [PATCH net-next 05/15] batman-adv: tt: extract update of dynamic client flags
Date: Mon,  7 Sep 2026 10:18:14 +0200
Message-ID: <20260907081824.2474040-6-sw@simonwunderlich.de>
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

The WIFI and ISOLA flags are re-evaluated on every batadv_tt_local_add()
call, no matter whether a new entry was created or an existing one was
refreshed. It is mostly isolated from the rest of the
batadv_tt_local_add().

Move it to batadv_tt_local_update_flags(). To allow the caller to trigger
the queuing of ADD events, it returns whether one of the flags announced to
the other nodes actually changed.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 79 +++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 91e11e5f10140..e0bcef1eba935 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -847,6 +847,55 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 	return tt_local;
 }
 
+/**
+ * batadv_tt_local_update_flags() - update the dynamic flags of a local entry
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_local: the local TT entry to update
+ * @iif_is_wifi: whether the client is connected via a wifi interface
+ * @mark: the value contained in the skb->mark field of the received packet (if
+ *  any)
+ *
+ * Return: true if a flag announced to the other nodes was modified, false
+ * otherwise.
+ */
+static bool
+batadv_tt_local_update_flags(struct batadv_priv *bat_priv,
+			     struct batadv_tt_local_entry *tt_local,
+			     bool iif_is_wifi, u32 mark)
+{
+	struct batadv_tt_common_entry *common = &tt_local->common;
+	u8 remote_flags;
+	u32 match_mark;
+	bool modified;
+
+	scoped_guard(spinlock_bh, &common->flags_lock) {
+		/* store the current remote flags before altering them. This
+		 * helps understanding is flags are changing or not
+		 */
+		remote_flags = common->flags & BATADV_TT_REMOTE_MASK;
+
+		if (iif_is_wifi)
+			common->flags |= BATADV_TT_CLIENT_WIFI;
+		else
+			common->flags &= ~BATADV_TT_CLIENT_WIFI;
+
+		/* check the mark in the skb: if it's equal to the configured
+		 * isolation_mark, it means the packet is coming from an
+		 * isolated non-mesh client
+		 */
+		match_mark = (mark & bat_priv->isolation_mark_mask);
+		if (bat_priv->isolation_mark_mask &&
+		    match_mark == bat_priv->isolation_mark)
+			common->flags |= BATADV_TT_CLIENT_ISOLA;
+		else
+			common->flags &= ~BATADV_TT_CLIENT_ISOLA;
+
+		modified = remote_flags ^ (common->flags & BATADV_TT_REMOTE_MASK);
+	}
+
+	return modified;
+}
+
 /**
  * batadv_tt_local_add() - add a new client to the local table or update an
  *  existing client
@@ -870,10 +919,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	bool added = false;
 	bool iif_is_wifi;
 	bool ret = false;
-	u8 remote_flags;
 	int hash_added;
-	u32 match_mark;
-	bool modified;
 
 	iif_is_wifi = batadv_tt_iif_is_wifi(dev_net(mesh_iface), ifindex);
 
@@ -910,35 +956,10 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 
 	batadv_tt_local_add_roam(bat_priv, tt_global, roamed_back);
 
-	spin_lock_bh(&tt_local->common.flags_lock);
-	/* store the current remote flags before altering them. This helps
-	 * understanding is flags are changing or not
-	 */
-	remote_flags = tt_local->common.flags & BATADV_TT_REMOTE_MASK;
-
-	if (iif_is_wifi)
-		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
-	else
-		tt_local->common.flags &= ~BATADV_TT_CLIENT_WIFI;
-
-	/* check the mark in the skb: if it's equal to the configured
-	 * isolation_mark, it means the packet is coming from an isolated
-	 * non-mesh client
-	 */
-	match_mark = (mark & bat_priv->isolation_mark_mask);
-	if (bat_priv->isolation_mark_mask &&
-	    match_mark == bat_priv->isolation_mark)
-		tt_local->common.flags |= BATADV_TT_CLIENT_ISOLA;
-	else
-		tt_local->common.flags &= ~BATADV_TT_CLIENT_ISOLA;
-
-	modified = remote_flags ^ (tt_local->common.flags & BATADV_TT_REMOTE_MASK);
-	spin_unlock_bh(&tt_local->common.flags_lock);
-
 	/* if any "dynamic" flag has been modified, resend an ADD event for this
 	 * entry so that all the nodes can get the new flags
 	 */
-	if (modified)
+	if (batadv_tt_local_update_flags(bat_priv, tt_local, iif_is_wifi, mark))
 		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
 
 	ret = true;
-- 
2.47.3

