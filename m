Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C21659B682
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184304; cv=none; b=s6xgbOllNyZ6wgU2BdAQiZgmX8yBNW4+WqPrBdDvGNHNSUDqlXviwIbKU6OP0w9RimppcSpGvxRuQ8OGPI0ZayJoCITUfuwDR7zL7nfd81ffQC917hylY+ZW3ClL8aSpAacGsZDE6xYEbiFJVHtMGcmsfWK3nIbx/6RBdPLJ7us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184304; c=relaxed/simple;
	bh=W9Qid2bERlvGyGuNqGlKGNDfX1I8A5G5RjhkwFgKhbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+j/d0SgVuM2XXcdEmXWDf+9py4yJHY0UcsHMhDWV+3NNG6YZXdeyFZGJ0h2462OILUbfDZ00mSWJDWpduJ85vV749mwL0x3lxemx19bRJpxdRa3f+wE8wH6nil1Gw/a2FGCAmvJaH8Qi1Hlfq0EwcM8Lp5AKTZNtBkChUaTqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=WJyevspY; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="WJyevspY"
Received: from kero.packetmixer.de (p200300c5970eEDD85F51f1fAa919d7a5.dip0.t-ipconnect.de [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id A0690FA6B8;
	Mon, 31 Aug 2026 15:51:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+fih36mn0rWJXnLxh9qzk4Rdn9Swqf0asTE0uYK2L0=;
	b=WJyevspYEfY8Vot1fQU80G/zjwUd5yeT7S5RK7TUVIdntXdpdFFZIFJLb3/klWV90skPhF
	7SymHOqTyrZc8+EUWejd04iGcxiPiBDOquzS8ihn2oZMpGnq0FUiidu3NYb4+fBEs1LpcJ
	Ddfqww4O3ELo5Aef3im1QbghmmZ3sCa3eFjUy2YS70cOpBaAyrs3edUQCAMOxHep6ge5Wa
	R4XFgfhKavsoh4E9ktZgizfzOnzUEbVVQB6NxziFmKPbAGbUvtI+azACtVzlgWclihfh1B
	3yYl6qx9B/RacrkcdP+BUKmuBEHwgb1bU0JL4xzccYi1FZkUTyZ5Lkd4s488OQ==
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
Subject: [PATCH net-next 13/15] batman-adv: tt: transition NEW local entries only under lock
Date: Mon, 31 Aug 2026 15:51:15 +0200
Message-ID: <20260831135117.574836-14-sw@simonwunderlich.de>
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

The batadv_tt_local_size_inc() must never be called for an entry which was
already removed from the list. Otherwise the removal from the hash cannot
correctly determine if the batadv_tt_local_size_dec() needs to be called or
not.

This assumption is broken by the use of rcu_read_lock() in
batadv_tt_local_transition_new() because it might still see entries in the
list which were already removed by a different context from the list. If it
then increments the size counter, nothing will reduce the counter again.
Simply because the removal (responsible for the decrement) already
happened.

Over the whole time, the actual hash list spinlock must be held when
transitioning NEW local entries to avoid list manipulations.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 163f909623069..a870d9a97e329 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -333,6 +333,10 @@ static void batadv_tt_local_size_mod(struct batadv_priv *bat_priv,
  *  given vid
  * @bat_priv: the bat priv with all the mesh interface information
  * @vid: the VLAN identifier
+ *
+ * It must only be called when removing the NEW flag of a
+ * batadv_tt_local_entry while it is still part of the bat_priv->tt.local_hash.
+ * It must therefore be checked under the specific list_locks[i].
  */
 static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
 				     unsigned short vid)
@@ -3938,6 +3942,7 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
  */
 static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 {
+	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct hlist_head *head;
@@ -3948,10 +3953,10 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
+		list_lock = &hash->list_locks[i];
 
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(tt_common_entry,
-					 head, hash_entry) {
+		spin_lock_bh(list_lock);
+		hlist_for_each_entry(tt_common_entry, head, hash_entry) {
 			bool cont = false;
 
 			scoped_guard(spinlock_bh, &tt_common_entry->flags_lock) {
@@ -3969,7 +3974,7 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 			batadv_tt_local_size_inc(bat_priv,
 						 tt_common_entry->vid);
 		}
-		rcu_read_unlock();
+		spin_unlock_bh(list_lock);
 	}
 }
 
-- 
2.47.3

