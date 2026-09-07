Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFB530CD9E
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769121; cv=none; b=Y+wI7BUnyDJOZu8l77NQwCIZp5ig27RL3V45vszTZd/t2C97uE5QOgnf8YuDl7ssfl0KLDP1ufHed+Ta1sDjL5l936gh0Ru+TqgvXHenHbQ0OVbDActuhfaFnCXRDTlDi1DynlImpQXjrRiaA2fGRTI4JTVCXxBqIKKjDQ0wv2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769121; c=relaxed/simple;
	bh=HVCXpMC2TSw/xibI9H8FxsEIRzglwm+3HBcLF/jLfi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDThjLkAq+ITfEKHKxQsL4tP4TgFtfLdgdcReapVmGXZHFx0r2uFbwLr9ehFgr12q3DxpsggMDlr9wmPdsNHRxPVVIV+c/EMn0E5mjlHodTXmI7YIDpD+JMk7XfZGmjcXMHy1hT6Z6UeAdRIhG9+68MYOVlkcq6esBcQLK0aNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=r+uj+8Qu; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="r+uj+8Qu"
Received: from kero.packetmixer.de (p200300C59748D0d8C3747188E6DFE6c0.dip0.t-ipconnect.de [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 6E057FA2BE;
	Mon, 07 Sep 2026 10:18:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBLXy+zjOOc3JiDODVHxTk5L18GWZI/4gMrt0AqIkKY=;
	b=r+uj+8QuIZyqAIDt3YdpdFY1WuARyWrg888AYY2ZjXAcpwuf8zZ74WWx3wtWSCe8FduV9t
	UbcQXR94bK1CeyKsw6szubCcGVxhA2VQXQOKwEZeCaMbM4q0mqb5oIC1m+anWDAuutl9uX
	nCVJSjYpsEn4a87v6yzJiN2bw3pHZGSnsfsMWEiA0XKhowbPzlK9DLvOH1e5h4UOoSzTO8
	gBDFQ3J814SaMWyU1NZMmSPHw5UfkAtZ3p7x7pcLQ+poTNtembQsRVBSMkSDFlB4Udg/NU
	2TRUPQVqlTNf1YrWElcgvJan5a/ToTuyWj5QCQS1Xm+80vVO9EZFUx/KKsCbCQ==
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
Subject: [PATCH net-next 09/15] batman-adv: tt: extract removal of the superseded local entry
Date: Mon,  7 Sep 2026 10:18:18 +0200
Message-ID: <20260907081824.2474040-10-sw@simonwunderlich.de>
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

A client which was announced by another originator is no longer a local
client. The code which drops it from the local table and takes over its
WIFI flag is the second cleanup stage of batadv_tt_global_add() and needed
its own goto to skip over the multicast case.

Move it to batadv_tt_global_purge_local().

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 61 ++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 760acc7be973e..b3e45fb5e9dd4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1832,6 +1832,46 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	spin_unlock_bh(&tt_global->list_lock);
 }
 
+/**
+ * batadv_tt_global_purge_local() - drop the local entry of an announced client
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_global_entry: the global TT entry of the announced client
+ * @flags: TT flags announced for this non-mesh client
+ *
+ * A client which is announced by another originator is no longer a local
+ * client. Remove it from the local table and take over the WIFI flag it was
+ * tracked with.
+ */
+static void
+batadv_tt_global_purge_local(struct batadv_priv *bat_priv,
+			     struct batadv_tt_global_entry *tt_global_entry,
+			     u16 flags)
+{
+	struct batadv_tt_common_entry *common = &tt_global_entry->common;
+	u16 local_flags;
+
+	/* Do not remove multicast addresses from the local hash on
+	 * global additions
+	 */
+	if (is_multicast_ether_addr(common->addr))
+		return;
+
+	/* remove address from local hash if present */
+	local_flags = batadv_tt_local_remove(bat_priv, common->addr, common->vid,
+					     "global tt received",
+					     flags & BATADV_TT_CLIENT_ROAM);
+
+	scoped_guard(spinlock_bh, &common->flags_lock) {
+		common->flags |= local_flags & BATADV_TT_CLIENT_WIFI;
+
+		if (!(flags & BATADV_TT_CLIENT_ROAM))
+			/* this is a normal global add. Therefore the client is
+			 * not in a roaming state anymore.
+			 */
+			common->flags &= ~BATADV_TT_CLIENT_ROAM;
+	}
+}
+
 /**
  * batadv_tt_global_merge_flags() - merge announced flags into a global TT entry
  * @tt_global_entry: the global TT entry to update
@@ -2042,26 +2082,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	ret = true;
 
 out_remove:
-	/* Do not remove multicast addresses from the local hash on
-	 * global additions
-	 */
-	if (is_multicast_ether_addr(tt_addr))
-		goto out;
-
-	/* remove address from local hash if present */
-	local_flags = batadv_tt_local_remove(bat_priv, tt_addr, vid,
-					     "global tt received",
-					     flags & BATADV_TT_CLIENT_ROAM);
-
-	spin_lock_bh(&tt_global_entry->common.flags_lock);
-	tt_global_entry->common.flags |= local_flags & BATADV_TT_CLIENT_WIFI;
-
-	if (!(flags & BATADV_TT_CLIENT_ROAM))
-		/* this is a normal global add. Therefore the client is not in a
-		 * roaming state anymore.
-		 */
-		tt_global_entry->common.flags &= ~BATADV_TT_CLIENT_ROAM;
-	spin_unlock_bh(&tt_global_entry->common.flags_lock);
+	batadv_tt_global_purge_local(bat_priv, tt_global_entry, flags);
 
 out:
 	batadv_tt_global_entry_put(tt_global_entry);
-- 
2.47.3

