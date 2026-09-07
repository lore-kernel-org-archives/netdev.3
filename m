Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A2E37F305
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769119; cv=none; b=Fs6ZYxIFlJiCcMShT0nqFH86K4tsKPqHOMqjtpeW3Fu2A5+NwzHCNK3KhRxqivEF9OWiMZi/HbvRyEBKjT7EmhBXw1epzkuh8gubLJYU5ZnmU32jmuXf2fMty6wllT4dYmwztYwMLrXDweEMN1tRyc/L7vpJxsabrcjAZrkxA0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769119; c=relaxed/simple;
	bh=xFgZz0ny5vxrL5YF9IauzLyM3Xq4nfhOAxS4fzpd2Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfTHmHHTYbm53VVfUrGP6e/t0m/tXRgSrXj5K8x2oPTCs2PhTrfZPo2lISd+80NFA0mnG+vcvBHG5FAdFE5brmLUphE7gW9mYc+gn2T8q0yJ5wEGEKgJEZucNvcK8UIE+YtRX7uRakRHhSAQsm07LJ0vhcWBdlJWjaJjtxCGBlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=VSi5lkFc; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="VSi5lkFc"
Received: from kero.packetmixer.de (p200300C59748D0d8C3747188e6DFE6c0.dip0.t-ipconnect.de [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id BF8CAFA1AC;
	Mon, 07 Sep 2026 10:18:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaNZxQC8O9mmgTu5dTzySZJEw/1spS5Gz0etIBABIr8=;
	b=VSi5lkFc7V1vbOClS7FDKKyZqxsliiwB61The8Aof9Gxuyl2s4tAY7XeUDfYeb2iXS8HGA
	lZSb5YftjhQUQmdhF1hqy91bccmqR9NufSbd4tNe5WCpPrmtTxeP2wCng8MEa/2YQjyO3N
	82pQwqpyyCGmHZSPfM7QOQdBZeaOV4hNQohsU1OZ59hPZka6DUfCIkxL27i/HE7bkIaWqN
	8ekD+zFp3nF3jE2MjWc66TP2TcScHOHFtGKwT0Q9BCFc9w7xO51JFommSeor7US/ooLu2T
	vILO4lf4vV+joCQM5kQgXJb5tjfOwBeeAhzpWd9IyaUKpQ1e2DYZMN8a70dNtg==
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
Subject: [PATCH net-next 04/15] batman-adv: tt: extract refresh of existing local entries
Date: Mon,  7 Sep 2026 10:18:13 +0200
Message-ID: <20260907081824.2474040-5-sw@simonwunderlich.de>
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

The handling of a client which is already part of the local translation
table is independent from the rest of batadv_tt_local_add(): it only
refreshes last_seen and evaluates the PENDING and ROAM flags of the entry
which was just looked up.

Move it to batadv_tt_local_add_existing(). It reports via its return value
whether the client has to be announced to the mesh again and whether the
client roamed back to its original location.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 78 +++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 27 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5d5f270b7eb4c..91e11e5f10140 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -720,6 +720,55 @@ static bool batadv_tt_iif_is_wifi(struct net *net, int ifindex)
 	return batadv_is_wifi(wifi_flags);
 }
 
+/**
+ * batadv_tt_local_add_existing() - refresh an already known local TT entry
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_local: the local TT entry which was found in the local table
+ * @roamed_back: set to true when the client returned to its original location
+ *
+ * Return: true when the client has to be announced to the mesh again, false
+ * otherwise.
+ */
+static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
+					 struct batadv_tt_local_entry *tt_local,
+					 bool *roamed_back)
+{
+	struct batadv_tt_common_entry *common = &tt_local->common;
+
+	tt_local->last_seen = jiffies;
+
+	scoped_guard(spinlock_bh, &common->flags_lock) {
+		if (common->flags & BATADV_TT_CLIENT_PENDING) {
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
+				   "Re-adding pending client %pM (vid: %d)\n",
+				   common->addr, batadv_print_vid(common->vid));
+			/* whatever the reason why the PENDING flag was set,
+			 * this is a client which was enqueued to be removed in
+			 * this orig_interval. Since it popped up again, the
+			 * flag can be reset like it was never enqueued
+			 */
+			common->flags &= ~BATADV_TT_CLIENT_PENDING;
+
+			return true;
+		}
+
+		if (common->flags & BATADV_TT_CLIENT_ROAM) {
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
+				   "Roaming client %pM (vid: %d) came back to its original location\n",
+				   common->addr, batadv_print_vid(common->vid));
+			/* the ROAM flag is set because this client roamed away
+			 * and the node got a roaming_advertisement message. Now
+			 * that the client popped up again at its original
+			 * location such flag can be unset
+			 */
+			common->flags &= ~BATADV_TT_CLIENT_ROAM;
+			*roamed_back = true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * batadv_tt_local_create() - allocate and initialize a local TT entry
  * @mesh_iface: netdev struct of the mesh interface
@@ -834,33 +883,8 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 		tt_global = batadv_tt_global_hash_find(bat_priv, addr, vid);
 
 	if (tt_local) {
-		tt_local->last_seen = jiffies;
-
-		spin_lock_bh(&tt_local->common.flags_lock);
-		if (tt_local->common.flags & BATADV_TT_CLIENT_PENDING) {
-			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Re-adding pending client %pM (vid: %d)\n",
-				   addr, batadv_print_vid(vid));
-			/* whatever the reason why the PENDING flag was set,
-			 * this is a client which was enqueued to be removed in
-			 * this orig_interval. Since it popped up again, the
-			 * flag can be reset like it was never enqueued
-			 */
-			tt_local->common.flags &= ~BATADV_TT_CLIENT_PENDING;
-			added = true;
-		} else if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
-			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Roaming client %pM (vid: %d) came back to its original location\n",
-				   addr, batadv_print_vid(vid));
-			/* the ROAM flag is set because this client roamed away
-			 * and the node got a roaming_advertisement message. Now
-			 * that the client popped up again at its original
-			 * location such flag can be unset
-			 */
-			tt_local->common.flags &= ~BATADV_TT_CLIENT_ROAM;
-			roamed_back = true;
-		}
-		spin_unlock_bh(&tt_local->common.flags_lock);
+		added = batadv_tt_local_add_existing(bat_priv, tt_local,
+						     &roamed_back);
 	} else {
 		tt_local = batadv_tt_local_create(mesh_iface, addr, vid, iif_is_wifi);
 		if (!tt_local)
-- 
2.47.3

