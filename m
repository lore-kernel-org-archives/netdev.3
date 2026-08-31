Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBEE59B661
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184302; cv=none; b=m/m5VxcWE96VwhaKRvbzevTW1uuIzzqpkGmfDxO4x/pY2qz0X+WU1AUnRcs4JFuFVl+rFeMCMdNUwjj0psykDRLuyNsAzFuG0eVkUiGB7EoWXy/yqCwACZmexqWkOUKd2Q+PsgNNbeWD6EN5MxsHITNqjzahmAjLDsIghvC54BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184302; c=relaxed/simple;
	bh=wfSqMLOgnn/9yg/IinzQwH8Gp8r5notdnQ12ruvzCPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7ZgGhzOpqpJOjHKLZp2T8lO5HWXu9zgaX3IIDlPUd4FU8w64jSgs3gl33+f52x6N3BWoRLlejk/cjVC2296b6D/C1r05T5fysrrLOvj0aJM/fOWNU7z3i9fz301QH+o/XSs3koq2uHgh/TJggKLzNJTpjbR4VWZlnDD6dvcRyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=k17Xgaqp; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="k17Xgaqp"
Received: from kero.packetmixer.de (p200300c5970EEDD85f51F1FAA919d7a5.dip0.t-ipconnect.de [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 7C680FA363;
	Mon, 31 Aug 2026 15:51:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cE0GpFmEXti3+JZJB3VbZa56hZHQGMfsVE7+uKQtrBI=;
	b=k17Xgaqp5ZgNko0hrYE/a6iAa0wtlKd7sRW1hRQTaQHO6wFH8IfS5d8el5IpIdYqvudw9I
	0jnyDkwoC8rqn2Xn/GV+jM0xutk1C+un5pTkilGC2vWRTPr1j2Eeap/TCE1gBkaheq9zL8
	L63o/hP1b5LfO78LT+YVyEGBQ9HGcj6ktOIHVt5swTAVp83evcrxJO6h7Q3fc71QJK/sHK
	qCUr6BjuDvReLCim8XH6gXMh0kGKcN8nPNFUr8VKA+4oAO94tcM2qkjwnyELtqUPoAZ18g
	lhptsqkSntL15sxltxSRHH03qKhaA7c4TbIX79P31RFTIXeHVuBFuT5TaztCIw==
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
Subject: [PATCH net-next 08/15] batman-adv: tt: remove only the entry which was looked up from the hash
Date: Mon, 31 Aug 2026 15:51:10 +0200
Message-ID: <20260831135117.574836-9-sw@simonwunderlich.de>
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

batadv_hash_remove() searches a bucket with a compare callback and unlinks
the first matching entry. batadv_compare_tt() matches any entry for the
same MAC address and VLAN, not the object which was passed in, and the
callers in batadv_tt_local_remove() and batadv_tt_global_free() are not
serialized against the rest of the translation table in any way.

So when the looked up entry was already unlinked by another context and a
new entry for the same client was added in the meantime, these two
functions unlink that new entry instead.

Add batadv_compare_tt_entry(), which matches the very object which is
searched for, and use it for both removals. Nothing is unlinked when the
entry is gone already, batadv_hash_remove() then simply returns NULL and
only the reference of the calling context is dropped.

As a side effect the returned hlist_node can no longer belong to a
different object, so both functions can operate on the entry they were
given.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 38 ++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 88aeefa97db6e..66456a2d45e26 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -95,6 +95,26 @@ static bool batadv_compare_tt(const struct hlist_node *node, const void *data2)
 	return (tt1->vid == tt2->vid) && batadv_compare_eth(data1, data2);
 }
 
+/**
+ * batadv_compare_tt_entry() - check if a hash node is a specific TT entry
+ * @node: the list element pointer of the TT entry stored in the bucket
+ * @data2: pointer to the tt_common_entry which is looked for
+ *
+ * Unlike batadv_compare_tt(), this only matches the very object which is
+ * passed as @data2 and not just any entry for the same TT client. It is meant
+ * for batadv_hash_remove() callers which must not unlink an entry they did not
+ * look up themselves.
+ *
+ * Return: true if @node belongs to @data2, false otherwise
+ */
+static bool batadv_compare_tt_entry(const struct hlist_node *node,
+				    const void *data2)
+{
+	const struct batadv_tt_common_entry *tt = data2;
+
+	return node == &tt->hash_entry;
+}
+
 /**
  * batadv_choose_tt() - return the index of the tt entry in the hash table
  * @data: pointer to the tt_common_entry object to map
@@ -575,7 +595,6 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 				  struct batadv_tt_global_entry *tt_global,
 				  const char *message)
 {
-	struct batadv_tt_global_entry *tt_removed_entry;
 	struct hlist_node *tt_removed_node;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -583,18 +602,16 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 		   tt_global->common.addr,
 		   batadv_print_vid(tt_global->common.vid), message);
 
+	/* remove exactly this object when still present in hash */
 	tt_removed_node = batadv_hash_remove(bat_priv->tt.global_hash,
-					     batadv_compare_tt,
+					     batadv_compare_tt_entry,
 					     batadv_choose_tt,
 					     &tt_global->common);
 	if (!tt_removed_node)
 		return;
 
 	/* drop reference of remove hash entry */
-	tt_removed_entry = hlist_entry(tt_removed_node,
-				       struct batadv_tt_global_entry,
-				       common.hash_entry);
-	batadv_tt_global_entry_put(tt_removed_entry);
+	batadv_tt_global_entry_put(tt_global);
 }
 
 /**
@@ -1292,7 +1309,6 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 			   unsigned short vid, const char *message,
 			   bool roaming)
 {
-	struct batadv_tt_local_entry *tt_removed_entry;
 	struct batadv_tt_local_entry *tt_local_entry;
 	struct hlist_node *tt_removed_node;
 	u16 curr_flags = BATADV_NO_FLAGS;
@@ -1325,18 +1341,16 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	 */
 	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
 
+	/* remove exactly this object when still present in hash */
 	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
-					     batadv_compare_tt,
+					     batadv_compare_tt_entry,
 					     batadv_choose_tt,
 					     &tt_local_entry->common);
 	if (!tt_removed_node)
 		goto out;
 
 	/* drop reference of remove hash entry */
-	tt_removed_entry = hlist_entry(tt_removed_node,
-				       struct batadv_tt_local_entry,
-				       common.hash_entry);
-	batadv_tt_local_entry_put(tt_removed_entry);
+	batadv_tt_local_entry_put(tt_local_entry);
 
 out:
 	batadv_tt_local_entry_put(tt_local_entry);
-- 
2.47.3

