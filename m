Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C2159B674
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184304; cv=none; b=JSaMVmF6I7Fu+vPUztNdN5r/OlKbIvG/z1J5oUDVv8Lm5krRHNXuGZBk+uA7tiTDJ3sOwjehnMBLH6F4xEPNKgPz9SASEJHBG1RH161r7PMIb0E87hEu58xyI6c+jebwEvi8dk++i6M2IiUH0jRMXPcXk5o3Ymxfcj1Ry7bQFho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184304; c=relaxed/simple;
	bh=RkAy9uHmk0ZiPAPrW84Avo2ibQnLdGBCBAsLq3NaRHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsYbwnZ6QAbDKMTdHUhBAew9T0QF77enGvtTKY4oorArTt42jbCsxNzk/avZb9SugPBSggMWJeoeUBWk8WnbGIPaEkGPCygXf2HIdrkO4SMMqtgGpilzrprP0/1aTZ2UeqwGGfnD684kWAtWXoKP9hA9H2wmlu2flzpmcfT936k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=Cgl84q14; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="Cgl84q14"
Received: from kero.packetmixer.de (p200300C5970EeDd85F51f1FAa919d7a5.dip0.t-ipconnect.de [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 79A8DFA66D;
	Mon, 31 Aug 2026 15:51:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0arQLmCPaXP9OBvZH+SrzazgTcqbldryCUCPg9JgYhc=;
	b=Cgl84q14joCgYS6KdNqVcIVrPBwxhfi2dT30vEX8+Jc2Eimgxq127PBCkgN/Uv0B4C8m7v
	nf1wDL3sjEU8XFWAMwMrj3JMYAVv6CzIcmFmZy48V9w6Vw5qgQ1g2I0p3064CC35NWfySO
	11KbcOw8FitDXEIvFhfb02LEQ4aDNRLeUdBXvnnwuLPhRc3QxCCCgrrklsWzj9lycR2+5r
	Oe2kqDUzUsFiiEGoOsHfOFkfRWHqgQR6q0AnUXFjGfcyzpsd87jiaOI8GrQCdYPkD7VLur
	yrqUtcuuaBggfkk8reayjZgdHjiVlxJGbE4Olz8UJkXO3MaZp2ww6jq0N5liRQ==
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
Subject: [PATCH net-next 11/15] batman-adv: tt: drop unnecessary cleanup goto in helpers
Date: Mon, 31 Aug 2026 15:51:13 +0200
Message-ID: <20260831135117.574836-12-sw@simonwunderlich.de>
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

To use scoped_guard(), it is not allowed to use goto in the same routine.
These goto's should only be used for cleanups but are not necessary of
minimal helpers like batadv_is_my_client(),
batadv_tt_global_client_is_roaming() and
batadv_tt_local_client_is_roaming(). Removing the goto's is actually making
these functions more readable.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2f7951e4c3203..fbe75e184153f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3544,19 +3544,18 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
 			 unsigned short vid)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
-	bool ret = false;
+	bool ret;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
-		goto out;
+		return false;
+
 	/* Check if the client has been logically deleted (but is kept for
 	 * consistency purpose)
 	 */
-	if ((tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) ||
-	    (tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM))
-		goto out;
-	ret = true;
-out:
+	ret = !((tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) ||
+		(tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM));
+
 	batadv_tt_local_entry_put(tt_local_entry);
 	return ret;
 }
@@ -4082,15 +4081,15 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 					u8 *addr, unsigned short vid)
 {
 	struct batadv_tt_global_entry *tt_global_entry;
-	bool ret = false;
+	bool ret;
 
 	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr, vid);
 	if (!tt_global_entry)
-		goto out;
+		return false;
 
 	ret = tt_global_entry->common.flags & BATADV_TT_CLIENT_ROAM;
 	batadv_tt_global_entry_put(tt_global_entry);
-out:
+
 	return ret;
 }
 
@@ -4108,15 +4107,15 @@ bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
 				       u8 *addr, unsigned short vid)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
-	bool ret = false;
+	bool ret;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
-		goto out;
+		return false;
 
 	ret = tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM;
 	batadv_tt_local_entry_put(tt_local_entry);
-out:
+
 	return ret;
 }
 
-- 
2.47.3

