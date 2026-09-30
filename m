Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564C83DDB0E
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762109; cv=none; b=S4hDf7MmuIh88yP+yaoVpBzmZMRSXNGyx7h6EBZA6R0tGbwBIsHccTpW3syP62dmPRg7kb8Rdp7mC74/YBZ7mT5Eu9ZhkvGfhd3zoOwomueX3YiQ8owz9BbaKnXy1BkYJX32qyDGTCLCbL+2+9zCClvZmog6fBwqQwOSG7xox3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762109; c=relaxed/simple;
	bh=zM/qWLSmR2E8tB/sMPH0wyIwlfTMiX7Xe4ECAVf5gHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbZnGaIU+hIYC9yPug1o1SklnKP/fiR8QKTv0Nd2KGxaDhBNJFxGWQouoRucMZ++Fz7bO1QkHTwhwIgidzNr6wFW5B3+yYSd65rrV2wrIftVqxeSeloNGEng20Q8Z7ynZrRtmNPRBKovTtmqmF9sL9sXWDf5Z+H1bkoUUt9Nujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=mUO13suY; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="mUO13suY"
Received: from kero.packetmixer.de (p200300C5970e81d8Cf20E45A7328d917.dip0.t-ipconnect.de [IPv6:2003:c5:970e:81d8:cf20:e45a:7328:d917])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 127CFFA1B0;
	Wed, 30 Sep 2026 11:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1790761562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXNKA4chhRAf3l6+DCaQ64fVBwcgFd1YVsVFhuwWxXU=;
	b=mUO13suY66lRcQGOhkzd2hN4o0eS/vy7z7w9nrxR23UPnoaqm5f9A+UoTjnXEBHVYfu67I
	+ASbwyok4QK7mJ1ucVhi+SoIu3NBqIu9OuTXZpOGluFq2jCQJjlnEr8ttrXilOIMcgw3xb
	gNBORMcPBMf72CBMfe2KCGji4guaviXzCNtxJOruk2aRk5XHFbRhd6sWhNi+BgLZgUXE6U
	28w3+n6g3Hja7JIfCq0Gc76Nt4I/3jbfoyRr4rivH4TQLeshOKG/cP85+WVMR3gOK/qCtL
	e3edR323tYwcwaztjgF0icsYXgiBcsEYlitwjEjBQ0gCrnFKxAs9NkOoLSaJwg==
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
Subject: [PATCH net-next 3/9] batman-adv: tt: clarify responsibility for roam flag during removal
Date: Wed, 30 Sep 2026 11:45:52 +0200
Message-ID: <20260930094558.3723766-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930094558.3723766-1-sw@simonwunderlich.de>
References: <20260930094558.3723766-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

If an local client gets removed due to an roam, then the local entry must
be marked as "roamed" to handle the rerouting correctly. But this is not
done by batadv_tt_local_remove() directly but by the new helper
batadv_tt_local_mark_removed(). The former will only create similar flags
for the roaming event.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907081824.2474040-1-sw%40simonwunderlich.de?part=10
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6d8fa6d28fee8..78f032c9ad65c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1461,7 +1461,10 @@ batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
 	scoped_guard(spinlock_bh, &common->flags_lock) {
 		*curr_flags = common->flags;
 
-		/* mark the local client as ROAMed */
+		/* if this global entry addition is due to a roaming, the node
+		 * has to mark the local entry as "roamed" in order to
+		 * correctly reroute packets later
+		 */
 		if (roaming)
 			common->flags |= BATADV_TT_CLIENT_ROAM;
 
@@ -1532,22 +1535,22 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (!tt_local_entry)
 		return BATADV_NO_FLAGS;
 
-	flags = BATADV_TT_CLIENT_DEL;
-	/* if this global entry addition is due to a roaming, the node has to
-	 * mark the local entry as "roamed" in order to correctly reroute
-	 * packets later
-	 */
-	if (roaming)
-		flags |= BATADV_TT_CLIENT_ROAM;
+	if (batadv_tt_local_mark_removed(tt_local_entry, roaming, &curr_flags)) {
+		/* queue (roamed) del event which was prepared by
+		 * batadv_tt_local_mark_removed()
+		 */
+		flags = BATADV_TT_CLIENT_DEL;
+		if (roaming)
+			flags |= BATADV_TT_CLIENT_ROAM;
 
-	if (batadv_tt_local_mark_removed(tt_local_entry, roaming, &curr_flags))
 		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry,
 						  flags, message);
-	else
+	} else {
 		/* if this client has been added right now, it is possible to
 		 * immediately purge it
 		 */
 		batadv_tt_local_remove_now(bat_priv, tt_local_entry);
+	}
 
 	batadv_tt_local_entry_put(tt_local_entry);
 
-- 
2.47.3

