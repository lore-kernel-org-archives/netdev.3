Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533A59B66B
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184302; cv=none; b=mJly48s612zV1kyN503QPlegiuNRWMR6147ltbYGzdrHatp1H1iElzJjryDwXyJDHmaH8ySIHRfr7AkMmaSSzBAC4LAUkeyisa+SzE06sncXDRTQiqtjqfxU+vKFmpEZYqTHgSL3Ct7/OtQio40W5YSs6ca6l6yXXj+7yXyazWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184302; c=relaxed/simple;
	bh=QHB2zSCC5P+uNM8x3vYgnkz9a33844PmQgZM+dUSn3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jf4XMnfSGxPvPJLREHSKJUFb8Lgw2ZUu6btJd7/7D/GEkAnm41Rx4PuoX3+5s5Dw5q3Bx1fd8iIBPFgF7LqX7qyhbFNSOdCP5lSy9kB+T++XctOYXRfVSk7fwkqc9BlHhrBH2vX+BQ/My3KwZfDwLmdwGOD0qoJVQ7YuoheAR0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=jkHLLo6G; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="jkHLLo6G"
Received: from kero.packetmixer.de (p200300C5970eeDd85f51f1faa919D7a5.dip0.t-ipconnect.de [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 6F3C5FA364;
	Mon, 31 Aug 2026 15:51:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M17yNbbXZaFjkt4hjjms2dM3rlKCV48jAS/RCVbz2cY=;
	b=jkHLLo6G/9x/pyW5wNX0rDMxv8h0QzgS0MusCmImBqNtkujuFFKW3TqgIekMgNV+JLuavM
	RqQznr3hplj3oeWqCI+Q9biP8Q+iFsxgJQDXOmrwn20MWgVw089qzdrc0DwJBPr4UFnpWH
	Ih1bLOj0O0YFkFvwbLX3UeH1TmSl4xakd9BCSch4+JUe3mx8Hl/S6c7v2TyDyt28meFYWI
	T6Ju6yhULMyqgJLgEgv8MJAWUaKt46CEIDnmuyFoJyGBeHq4c84paxDI35BJsESHOIDYLD
	5uY0zPJjy8RHRPo3aRpLq3OkUpgf7FDoxWDoKCtdDbd8KUjOhNIAeew+wo15yg==
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
Subject: [PATCH net-next 09/15] batman-adv: tt: extract code handling a roam on add
Date: Mon, 31 Aug 2026 15:51:11 +0200
Message-ID: <20260831135117.574836-10-sw@simonwunderlich.de>
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

The code for handling the roaming of clients is mostly self contained but
embedded in the already too large batadv_tt_local_add function. The
maintainability can be improved by keeping it in an separate function.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 71 +++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 66456a2d45e26..01c74d4a7e521 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -614,6 +614,50 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 	batadv_tt_global_entry_put(tt_global);
 }
 
+/**
+ * batadv_tt_local_add_roam() - handle roamed clients during batadv_tt_local_add()
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_global: the global TT entry
+ * @roamed_back: whether @tt_global roamed back
+ */
+static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
+				     struct batadv_tt_global_entry *tt_global,
+				     bool roamed_back)
+{
+	struct batadv_tt_orig_list_entry *orig_entry;
+	struct hlist_head *head;
+
+	if (!tt_global)
+		return;
+
+	/* Check whether it is a roaming, but don't do anything if the roaming
+	 * process has already been handled
+	 */
+	if (tt_global->common.flags & BATADV_TT_CLIENT_ROAM)
+		return;
+
+	/* These node are probably going to update their tt table */
+	head = &tt_global->orig_list;
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_entry, head, list) {
+		batadv_send_roam_adv(bat_priv, tt_global->common.addr,
+				     tt_global->common.vid,
+				     orig_entry->orig_node);
+	}
+	rcu_read_unlock();
+
+	if (roamed_back) {
+		batadv_tt_global_free(bat_priv, tt_global,
+				      "Roaming canceled");
+	} else {
+		/* The global entry has to be marked as ROAMING and
+		 * has to be kept for consistency purpose
+		 */
+		tt_global->common.flags |= BATADV_TT_CLIENT_ROAM;
+		tt_global->roam_at = jiffies;
+	}
+}
+
 /**
  * batadv_tt_local_add() - add a new client to the local table or update an
  *  existing client
@@ -632,14 +676,12 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 {
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_tt_global_entry *tt_global = NULL;
-	struct batadv_tt_orig_list_entry *orig_entry;
 	struct batadv_tt_local_entry *tt_local;
 	struct net *net = dev_net(mesh_iface);
 	struct net_device *in_dev = NULL;
 	struct batadv_meshif_vlan *vlan;
 	bool roamed_back = false;
 	bool iif_is_wifi = false;
-	struct hlist_head *head;
 	int packet_size_max;
 	bool ret = false;
 	u8 remote_flags;
@@ -758,30 +800,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
 
 check_roaming:
-	/* Check whether it is a roaming, but don't do anything if the roaming
-	 * process has already been handled
-	 */
-	if (tt_global && !(tt_global->common.flags & BATADV_TT_CLIENT_ROAM)) {
-		/* These node are probably going to update their tt table */
-		head = &tt_global->orig_list;
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(orig_entry, head, list) {
-			batadv_send_roam_adv(bat_priv, tt_global->common.addr,
-					     tt_global->common.vid,
-					     orig_entry->orig_node);
-		}
-		rcu_read_unlock();
-		if (roamed_back) {
-			batadv_tt_global_free(bat_priv, tt_global,
-					      "Roaming canceled");
-		} else {
-			/* The global entry has to be marked as ROAMING and
-			 * has to be kept for consistency purpose
-			 */
-			tt_global->common.flags |= BATADV_TT_CLIENT_ROAM;
-			tt_global->roam_at = jiffies;
-		}
-	}
+	batadv_tt_local_add_roam(bat_priv, tt_global, roamed_back);
 
 	/* store the current remote flags before altering them. This helps
 	 * understanding is flags are changing or not
-- 
2.47.3

