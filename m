Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF0459B670
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184302; cv=none; b=fRDC64P0HJWc8ILazKywxPjQcyY0eDE6xXdTTtPQ3EDB6jE3VkQa7UCa0xWo2wu/WhKOgwtCc99cBECAZR5T6MVG1CNClqCiCOHIIWb1liMLedXZdy6VfsYaxJMHcW0o+/NDzM69Ijc0J8/5kxxkl5bapyQobznE0fn3FVFOBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184302; c=relaxed/simple;
	bh=R+yb59gPaHwEzCjRsD2Tkl6O/j0Pg2PqUvRzmIYok+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C94sahvZJaWHsSYCC7UfLi8LCdERTwS14wifRFrQXnD1DBFe7V2lWaUAaNxZkRrJixoPpBSCc80obbVfRYEOMPeoUD2tmQ48wd0TkckImXL/uLuEu1Tj0PULb2WxVoYrZgyB7Et4CokaqedBMDQ5yJosG2wyHP/LVZg9w+IrfJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=YJRArrZG; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="YJRArrZG"
Received: from kero.packetmixer.de (p200300c5970eeDD85F51F1FAA919d7A5.dip0.t-ipconnect.de [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id F2FD7FA66C;
	Mon, 31 Aug 2026 15:51:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHJY+bFbF1EZ50G17p2P6mlzloCVfztDiB/kxIfRPg8=;
	b=YJRArrZGzhBIB2JFIy9z522Wn8Skj9LqA/EK651yRInFhMpSWpAGY9GINKXOAT4OX7Dp6X
	2yCA/3QYcRiOWvQyK7n/rXwZfWTns45EuSVItewxrCom4vT9Q6emcAj9jmooiKVRxBcaV4
	D5EOqlCablATHs9iBdQH6ane3Atd/9Yc9pXex1L/EmsnwSojiC2JCjTQHl9O6xiO89XpGF
	80SueClxEF0UbzFJDfStykdkaaM1f/59q1aEzeTe5QieUVVjFd2EnYBS0a0Y6IR93A9qy8
	8zKSH7eVCVsInp6j99Fr2U9T+GicvtuwrN0wdKU19TKbWo/mrIoQg4+svYrPTA==
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
Subject: [PATCH net-next 10/15] batman-adv: tt: simplify NEW flag transition code
Date: Mon, 31 Aug 2026 15:51:12 +0200
Message-ID: <20260831135117.574836-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The function batadv_tt_local_set_flags() implements support for various
flags and to set/unset them. It is also possible to decide whether this
change should increase the TT size or not.

But in reality, this function is only used to transition tt local entries
from the NEW state and count these entries. Remove the rest of the code to
simplify the function.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 01c74d4a7e521..2f7951e4c3203 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3815,15 +3815,11 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_local_set_flags() - set or unset the specified flags on the local
- *  table and possibly count them in the TT size
+ * batadv_tt_local_transition_new() - unset the NEW flag on the local
+ *  table and count them in the TT size
  * @bat_priv: the bat priv with all the mesh interface information
- * @flags: the flag to switch
- * @enable: whether to set or unset the flag
- * @count: whether to increase the TT size by the number of changed entries
  */
-static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
-				      bool enable, bool count)
+static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
@@ -3839,19 +3835,11 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry,
 					 head, hash_entry) {
-			if (enable) {
-				if ((tt_common_entry->flags & flags) == flags)
-					continue;
-				tt_common_entry->flags |= flags;
-			} else {
-				if (!(tt_common_entry->flags & flags))
-					continue;
-				tt_common_entry->flags &= ~flags;
-			}
-
-			if (!count)
+			if (!(tt_common_entry->flags & BATADV_TT_CLIENT_NEW))
 				continue;
 
+			tt_common_entry->flags &= ~BATADV_TT_CLIENT_NEW;
+
 			batadv_tt_local_size_inc(bat_priv,
 						 tt_common_entry->vid);
 		}
@@ -3924,7 +3912,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 		return;
 	}
 
-	batadv_tt_local_set_flags(bat_priv, BATADV_TT_CLIENT_NEW, false, true);
+	batadv_tt_local_transition_new(bat_priv);
 
 	batadv_tt_local_purge_pending_clients(bat_priv);
 	batadv_tt_local_update_crc(bat_priv);
-- 
2.47.3

