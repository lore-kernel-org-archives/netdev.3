Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C9043CE7B
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769121; cv=none; b=blx5oGrtzwEOoW6ms7LQGafnsYMgJWvHLHHhq8gStj30b9I2PBVtZUf4hfr1ooymNAguJMtOXbMNi6r6fyh8OIyw2OYyFkQplnMopUKbye+GjRwCxeFQGfGTn2qEPQcFF4ZxUdSmkPEszwlNoXeqTZ8G3SJC9oMHVej4NyAKA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769121; c=relaxed/simple;
	bh=jZMzUx0Qzm11Taptq8ipNFUsUg7B7CyU7C9p2BM+knU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eh+63uvRktM0MDdV9qRdFMIIbZykW/840qHAns8lg8bhb2adXQhhzDXC4bzkP02tQ0pSn2ZeJuR5JUyEjPglsI7lHjNy63fgQZK+JBvMe0vCl7AjVsVI5Ga1WoiuDBT3/taHjZUfEn0XaZS5p8UFbOUnzdRp4CmOkhUrBUPrVWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=MlnD1D/i; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="MlnD1D/i"
Received: from kero.packetmixer.de (p200300c59748d0D8C3747188e6dFe6C0.dip0.t-ipconnect.de [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 8DA13FA2C1;
	Mon, 07 Sep 2026 10:18:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9UPNwNnh+47CLhgsd+wrZidNydWo2JD4C/E4XQ38ew=;
	b=MlnD1D/igJsTGf43rU9Tid9x+m4Auoct5nVrnnvNOxOxOhoacK73RH8MxYvWdybrcGYzI/
	WSIKbsiyyzBdQxkJyuAAErxM6U7unarg7oCRopQzdYE7wXgE8YIYf348vBbR54T30Uczmg
	8qX8//Ubvnt7O8x9iJGUis2BttaZCSDC7QyKAWP7zxT0/hQc/uKiyE1XQPIUUWUBT2CUrV
	/4FprlGgqbWP3xCG1wizz3+PpTsC/X3EYWhBj8+PQkHI5YgBnbQoVpkV6vz/pVdhLJRLp/
	wPKNRKImfHQqPa6xyd5HVVTr6l7teQR896brNAKjgxUeRc67TI2Bafr2vO8+mg==
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
Subject: [PATCH net-next 12/15] batman-adv: tt: drop the cleanup label from batadv_tt_local_remove()
Date: Mon,  7 Sep 2026 10:18:21 +0200
Message-ID: <20260907081824.2474040-13-sw@simonwunderlich.de>
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

With both locked sections moved to their own helpers, the only thing left
in the cleanup section is the reference of the looked up entry. The "out"
label is therefore only reached with a valid entry, except for the lookup
failure at the very beginning.

Return BATADV_NO_FLAGS directly when there is no entry and let the two
remaining cases be an if/else.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 9f61797c64920..6c65d195f3756 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1526,13 +1526,12 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 			   bool roaming)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
-	u16 curr_flags = BATADV_NO_FLAGS;
-	bool pending = false;
+	u16 curr_flags;
 	u16 flags;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
-		goto out;
+		return BATADV_NO_FLAGS;
 
 	flags = BATADV_TT_CLIENT_DEL;
 	/* if this global entry addition is due to a roaming, the node has to
@@ -1542,20 +1541,15 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (roaming)
 		flags |= BATADV_TT_CLIENT_ROAM;
 
-	pending = batadv_tt_local_mark_removed(tt_local_entry, roaming,
-					       &curr_flags);
-	if (pending) {
-		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry, flags,
-						  message);
-		goto out;
-	}
-
-	/* if this client has been added right now, it is possible to
-	 * immediately purge it
-	 */
-	batadv_tt_local_remove_now(bat_priv, tt_local_entry);
+	if (batadv_tt_local_mark_removed(tt_local_entry, roaming, &curr_flags))
+		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry,
+						  flags, message);
+	else
+		/* if this client has been added right now, it is possible to
+		 * immediately purge it
+		 */
+		batadv_tt_local_remove_now(bat_priv, tt_local_entry);
 
-out:
 	batadv_tt_local_entry_put(tt_local_entry);
 
 	return curr_flags;
-- 
2.47.3

