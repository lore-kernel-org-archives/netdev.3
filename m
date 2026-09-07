Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2B43BDD2
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769120; cv=none; b=rTIkLVbKVGj7jTeZA6DtDskIScL39q2HvSbqxt13tIOvI3XUEvL5ZTT4x3EF0bCwQjNARPoF4X4iMe/eBJM9lFGsRSuo9juIy+AHjy2zvxPaBO7bH/JM90rxp/f40y43SSvmjPJOExvCZTpUhifNXkh8L/thp88mMecGAzw4N1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769120; c=relaxed/simple;
	bh=vxZEYdHA49o+nSyPpt3mWagYZweYGFHbjkSyBXXssG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kmz8UBRLyEvLEYVgfHDHwOSmTWf6iaW+ewUl5rposEI9EGqxTLrakfDp88aNpJMMjtgNHR+HUnWjDRuok3TBVzTJU/6XaW8DB599cBfYjfKO2ItmpvNzA1+alibrwR1MMfCE8UG3fZUlSesOK86hTKQ/NxkICBW54k76kpxaWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=l2JkpWJw; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="l2JkpWJw"
Received: from kero.packetmixer.de (p200300c59748d0d8c3747188E6dfE6C0.dip0.t-ipconnect.de [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 9C8C6FA2BB;
	Mon, 07 Sep 2026 10:18:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKTh3S1osAd3oOzeSAiudKpVE9EbyXDX/gnbfTiEcb4=;
	b=l2JkpWJwQNRqT54ITMJWDjN76T+Q+nUXZajHv50P2N5O0gnx79kuT+mj8FmRm6iFHvFO1W
	v3NtdQ0RpyLFk0BfWTPyGY9H3msr3peB856KrzYcxr87SwcWFLek0HIh60m1FKxEpShPSB
	M9kGEtPtjQTcbu1dv+/JfFk/oQFwVwu72BMySA+Vcm/OQGFLkLSt8ongxaDBAJbgCMaJNH
	efSzn4SsTx78W/ouLNsYYKOoC7XHAKgysGviLYwh5XwwmCGi+16G8l0CFOvsEZifh0bk0F
	mfzGZjzVMJkpviGjBistbzKQT261vEEpMPLD4EijCm2JUxe8ZCQzBOpf53xwFw==
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
Subject: [PATCH net-next 06/15] batman-adv: tt: extract allocation of new global entries
Date: Mon,  7 Sep 2026 10:18:15 +0200
Message-ID: <20260907081824.2474040-7-sw@simonwunderlich.de>
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

The code which allocates and initializes a brand new global TT entry makes
up a third of batadv_tt_global_add() and only needs the tt_addr, vid and
flags arguments. It is also the only part of the "new entry" branch which
does not deal with the global hash.

Move it to batadv_tt_global_create() and let it return the initialized
entry.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 76 ++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 25 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e0bcef1eba935..d475f8efd44d7 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1832,6 +1832,56 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	spin_unlock_bh(&tt_global->list_lock);
 }
 
+/**
+ * batadv_tt_global_create() - allocate and initialize a global TT entry
+ * @tt_addr: the mac address of the non-mesh client
+ * @vid: VLAN identifier
+ * @flags: TT flags that have to be set for this non-mesh client
+ *
+ * The returned entry is not yet part of bat_priv->tt.global_hash and has an
+ * empty originator list.
+ *
+ * Return: the new entry with an initialized reference counter on success, NULL
+ * otherwise.
+ */
+static struct batadv_tt_global_entry *
+batadv_tt_global_create(const unsigned char *tt_addr, unsigned short vid,
+			u16 flags)
+{
+	struct batadv_tt_global_entry *tt_global_entry;
+	struct batadv_tt_common_entry *common;
+
+	tt_global_entry = kmem_cache_zalloc(batadv_tg_cache, GFP_ATOMIC);
+	if (!tt_global_entry)
+		return NULL;
+
+	common = &tt_global_entry->common;
+	ether_addr_copy(common->addr, tt_addr);
+	common->vid = vid;
+	spin_lock_init(&common->flags_lock);
+
+	if (!is_multicast_ether_addr(common->addr)) {
+		scoped_guard(spinlock_bh, &common->flags_lock)
+			common->flags = flags & (~BATADV_TT_SYNC_MASK);
+	}
+
+	tt_global_entry->roam_at = 0;
+	/* node must store current time in case of roaming. This is
+	 * needed to purge this entry out on timeout (if nobody claims
+	 * it)
+	 */
+	if (flags & BATADV_TT_CLIENT_ROAM)
+		tt_global_entry->roam_at = jiffies;
+	kref_init(&common->refcount);
+	common->added_at = jiffies;
+
+	INIT_HLIST_HEAD(&tt_global_entry->orig_list);
+	atomic_set(&tt_global_entry->orig_list_count, 0);
+	spin_lock_init(&tt_global_entry->list_lock);
+
+	return tt_global_entry;
+}
+
 /**
  * batadv_tt_global_add() - add a new TT global entry or update an existing one
  * @bat_priv: the bat priv with all the mesh interface information
@@ -1883,35 +1933,11 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	}
 
 	if (!tt_global_entry) {
-		tt_global_entry = kmem_cache_zalloc(batadv_tg_cache,
-						    GFP_ATOMIC);
+		tt_global_entry = batadv_tt_global_create(tt_addr, vid, flags);
 		if (!tt_global_entry)
 			goto out;
 
 		common = &tt_global_entry->common;
-		ether_addr_copy(common->addr, tt_addr);
-		common->vid = vid;
-		spin_lock_init(&common->flags_lock);
-
-		if (!is_multicast_ether_addr(common->addr)) {
-			spin_lock_bh(&common->flags_lock);
-			common->flags = flags & (~BATADV_TT_SYNC_MASK);
-			spin_unlock_bh(&common->flags_lock);
-		}
-
-		tt_global_entry->roam_at = 0;
-		/* node must store current time in case of roaming. This is
-		 * needed to purge this entry out on timeout (if nobody claims
-		 * it)
-		 */
-		if (flags & BATADV_TT_CLIENT_ROAM)
-			tt_global_entry->roam_at = jiffies;
-		kref_init(&common->refcount);
-		common->added_at = jiffies;
-
-		INIT_HLIST_HEAD(&tt_global_entry->orig_list);
-		atomic_set(&tt_global_entry->orig_list_count, 0);
-		spin_lock_init(&tt_global_entry->list_lock);
 
 		kref_get(&common->refcount);
 		hash_added = batadv_hash_add(bat_priv->tt.global_hash,
-- 
2.47.3

