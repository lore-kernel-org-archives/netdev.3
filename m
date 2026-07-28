Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F174432F8
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245976; cv=none; b=Aw5hNVFTgzfifWZQ+muw0nvf4lGGdIJ3azTmwvtV9t2KF6mgUGh6eiV56LF/Ikf627kwr8yAbmh0E5jVUAw3H5NxH6xwOpOL/+iKn231cHiGS1JixAVI4iLpcilGCq5DAfmxDkjcbZQPkYIbHVxckIT9D5hZfGtwgNblGJyMQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245976; c=relaxed/simple;
	bh=aniLKQduuR43Q2Sk4X8lBt5qmr5NpB17X7iddPDtA6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUg1ojZYlOyNuL4XbjiLLMaDA7pkfYATl8TxQ4Iz2pgLofHDM6nieb13DV+QHzX1lBHp0g5KVW5w28835ilcAmM48deHGweu8vGPShtHhLQFX8GWBMqyotrdZ546qTEVmQotmLtrfo9FsE1UVsMx43yMFhLLW6Jd8ikfWvIIYKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=MY58UjiF; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="MY58UjiF"
Received: from kero.packetmixer.de (p200300c59717eaD808F168C97E5563A8.dip0.t-ipconnect.de [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C7551FA1AE;
	Tue, 28 Jul 2026 15:39:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7FQaHnW8F+Df8CwvCMNaD1Q40CWCi8+sPu8uSFkUVc=;
	b=MY58UjiF1gchB4RUoxohYcRSaUPKoHOxzATlVNYO6jt6ykpNMd5rgE38/D8NxH7AOI8e7k
	bOnTHFjHinksciAEHNtj78med3YMnQN3zloQ+wBnHPZSjqxfpQ5M4Auh3ib4x18+IUv4he
	t7jPa+x5nRK0buldDUlgZhtv23nYuXzp2iOrdRpfHdgNmXLuUCexke9kpQkuiq/cz6kzSZ
	orq56eTJrcSEEW0KjETBkBXxuyKPhpu2uTF/lxt6l7iGeFT4pqPeEQJW4m+bjH4ow1rvt0
	nUjAH8TIUT5AQZFRLRy9ZXsb2uXQZMGjh6wZtyA4bGdu+fSoK8zHV+9HJkHn/Q==
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
Subject: [PATCH net-next 15/15] batman-adv: tt: simplify NEW flag transition code
Date: Tue, 28 Jul 2026 15:39:18 +0200
Message-ID: <20260728133918.643267-16-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
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
 net/batman-adv/translation-table.c | 37 ++++++++----------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5295e3a59906f..5e10e6bb7bd6a 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3853,15 +3853,11 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
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
@@ -3882,27 +3878,12 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
 			entry_flags = &tt_common_entry->flags;
 			old_flags = atomic_read(entry_flags);
 
-			/* the old_flags value of the atomic test-and-
-			 * set/clear decides whether this entry counts as
-			 * changed.
-			 */
-			if (enable) {
-				if ((old_flags & flags) == flags)
-					continue;
-
-				old_flags = atomic_fetch_or(flags, entry_flags);
-				if ((old_flags & flags) == flags)
-					continue;
-			} else {
-				if (!(old_flags & flags))
-					continue;
-
-				old_flags = atomic_fetch_andnot(flags, entry_flags);
-				if (!(old_flags & flags))
-					continue;
-			}
+			if (!(old_flags & BATADV_TT_CLIENT_NEW))
+				continue;
 
-			if (!count)
+			old_flags = atomic_fetch_andnot(BATADV_TT_CLIENT_NEW,
+							entry_flags);
+			if (!(old_flags & BATADV_TT_CLIENT_NEW))
 				continue;
 
 			batadv_tt_local_size_inc(bat_priv,
@@ -3977,7 +3958,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 		return;
 	}
 
-	batadv_tt_local_set_flags(bat_priv, BATADV_TT_CLIENT_NEW, false, true);
+	batadv_tt_local_transition_new(bat_priv);
 
 	batadv_tt_local_purge_pending_clients(bat_priv);
 	batadv_tt_local_update_crc(bat_priv);
-- 
2.47.3

