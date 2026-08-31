Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4751B4B2CA1
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184306; cv=none; b=e3cwJ0UBWy726DaUK5Cua3FARMmeo3Eeww6Vx8xRKCcY2LkwJ4rNlKcl5kHxqLbWuxsaY7Nbi24M1lAABeur9V5jFEP7StCQqo+wMd3Q84t98QDvojQDfb0z/Xe31Se6tGaftf0SFCDOgF9wl6eJmGgVIpJ5bQGPeIODKTkFO4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184306; c=relaxed/simple;
	bh=sL14nmFg3QF1Ir9N20n4SNhZy6Xu1PglGQxWEievsYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTsi/NKfVQ/iKUP7d99dEOeEVosf1jaFz6Dyc7+xUfUVihJ9Evk5pfdMrZVfO8fEw+//G7gcJh5eq7iyBqkZ3J/MixuYIVccwUOyWJwtIlRhxaIs08L1ShO5g3Nxewr3jEbvts28xOVK/NRBUeRGlk72cZ6q9hUjCBXuMxONDgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=RAephEWo; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="RAephEWo"
Received: from kero.packetmixer.de (p200300C5970EeDd85F51f1FAa919d7a5.dip0.t-ipconnect.de [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 85807FA6BB;
	Mon, 31 Aug 2026 15:51:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/prk9mD3H+9HIMfDOj8RFswIOJ7B6P88+rB5ZHCRJN4=;
	b=RAephEWomQjz5Iqe6ynUSNV6lf/jH4KTen8T0nFrYuKfWHqARTKFLdgorJWqiIIAOwhvbM
	RyyGNVvC6Y6uoA8SK/42/S9VVca2MCT5f6nAY00eTCFMgvRUfd31Py4irkOkNRZfx4v3rH
	rbYTR/p+eZ1cBb8ORpxIe9fVTPYuzwmRdf/RnElTEhlAXq2wBSJCaxA4H999ROtbbQUvOT
	dRl2W7Iof73V6QKoi3UWMr9RgBt4zll+HhUfFzF/779W3QK40y9ta+k+D8xQorbzz6NZ79
	gN+V/LcYvCdvVGtQZFcQQdhhE672xHC6jLR8dR8q45kaDsHBSddVW1l8JKPkJQ==
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
Subject: [PATCH net-next 15/15] batman-adv: tt: decrement count for committed client on local_remove
Date: Mon, 31 Aug 2026 15:51:17 +0200
Message-ID: <20260831135117.574836-16-sw@simonwunderlich.de>
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

Local TT entries which have the BATADV_TT_CLIENT_NEW no longer set are
committed. The batadv_tt_local_size_inc() was called for them and thus the
batadv_tt_local_size_dec() has to be called also when
batadv_tt_local_remove() is called for them when the BATADV_TT_CLIENT_NEW
wasn't consumed in the remove path.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 794692170b611..44a8cf89382c6 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -352,7 +352,8 @@ static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
  *
  * It must only be called after a batadv_tt_local_entry without NEW flag
  * was removed from bat_priv->tt.local_hash (under the specific
- * list_locks[i]).
+ * list_locks[i]) or when it is ensured that it is not accessible
+ * in this list.
  */
 static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
 				     unsigned short vid)
@@ -1423,6 +1424,13 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (!tt_removed_node)
 		goto out;
 
+	/* batadv_tt_local_transition_new() may have committed the entry and
+	 * thus counted it in the local table size since the BATADV_TT_CLIENT_NEW
+	 * check above.
+	 */
+	if (!(batadv_tt_flags_get(&tt_local_entry->common) & BATADV_TT_CLIENT_NEW))
+		batadv_tt_local_size_dec(bat_priv, tt_local_entry->common.vid);
+
 	/* drop reference of remove hash entry */
 	batadv_tt_local_entry_put(tt_local_entry);
 
-- 
2.47.3

