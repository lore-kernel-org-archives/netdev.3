Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6243C056
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769120; cv=none; b=IciqG2bXOhxowoGxZKzRs4k+ccOj9RTskMxuqNuYf4cLF/aMLlkOwiKdYHRhBzh1bTOSYeN89zpSSCarXu7qrwDpqA0kTmDt4dOeqnDy0DOG+KEjd5cTal534Cvsj95z8ZarfDYywMA3QXwCuRmfGqFUiGqlSGXAaBp8VhJA1nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769120; c=relaxed/simple;
	bh=tKZXQUJZB1yWWxc4BH4CG32Sos6ROswu9hP5+omheIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhL/8/xZSrOPUmTzLeEXPH3RZskNjUroJcGIfRoUOXeDQFY9PzUKsSQPv+7j9HAgA5Y/v47Ehcjw3Bm9O4UGX9CEZmEZeGY17/PEyzYs+Va8Qv8G4J6sruvsUXzsbo2rOmWF/bMyLZZ90hpIq2lVRWtpK+X/AAyiuFPxd/Q0vQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=gZ2bPA+/; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="gZ2bPA+/"
Received: from kero.packetmixer.de (p200300C59748d0d8C3747188E6DfE6c0.dip0.t-ipconnect.de [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 8E045FA2BC;
	Mon, 07 Sep 2026 10:18:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RN9LgWd+AGbvJuel+ddkIaD98qz45YUGUEEpTu8o6ss=;
	b=gZ2bPA+/plMxo+VgjXQwtmJwUyf7Z5xNWFKV09Jg+hSEJEspyysiwH1/ZIWEu7d011fcrE
	nRS1LxvhwUVNAdRXBp6GoZ7pWRFw5B9cJryKrrXHSVB9nDwIhSO4AZlEZpbZ/gktVZ9G+X
	22hO7u/12VH9NnTQKg2G44yijtbbafPFRbKx74Qxxlgv9bC1Mj0Eg3oYztBbXt7ID9J+bI
	kpINnGyB1I11Ao8rz8WGma9c0KFPmHJlPnlR012QNZpqYE/6VpX/PmB0GExy0Ty9w4vjL2
	ZDKhTPE6fOqEKG+hqXFIe5wCzbuZfsY1IaiSBaj+r1jMI+Bzz38x+1BOlhsZ/Q==
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
Subject: [PATCH net-next 07/15] batman-adv: tt: extract merging of flags into existing global entries
Date: Mon,  7 Sep 2026 10:18:16 +0200
Message-ID: <20260907081824.2474040-8-sw@simonwunderlich.de>
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

When an already known global TT entry is announced again, its flags have to
be merged with the announced ones. Two of the merge steps also decide
whether the originator list has to be purged before the announced
originator is added.

Move this to batadv_tt_global_merge_flags() and let it report via its
return value whether the originator list has to be purged.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 87 ++++++++++++++++++------------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index d475f8efd44d7..67e4ade5ae997 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1832,6 +1832,57 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	spin_unlock_bh(&tt_global->list_lock);
 }
 
+/**
+ * batadv_tt_global_merge_flags() - merge announced flags into a global TT entry
+ * @tt_global_entry: the global TT entry to update
+ * @flags: TT flags announced for this non-mesh client
+ *
+ * Return: true if the originator list of @tt_global_entry has to be purged
+ * before the announced originator is added, false otherwise.
+ */
+static bool
+batadv_tt_global_merge_flags(struct batadv_tt_global_entry *tt_global_entry,
+			     u16 flags)
+{
+	struct batadv_tt_common_entry *common = &tt_global_entry->common;
+	bool delete = false;
+
+	scoped_guard(spinlock_bh, &common->flags_lock) {
+		/* if the client was temporary added before receiving the first
+		 * OGM announcing it, we have to clear the TEMP flag. Also,
+		 * remove the previous temporary orig node and re-add it
+		 * if required. If the orig entry changed, the new one which
+		 * is a non-temporary entry is preferred.
+		 */
+		if (common->flags & BATADV_TT_CLIENT_TEMP) {
+			delete = true;
+			common->flags &= ~BATADV_TT_CLIENT_TEMP;
+		}
+
+		/* the change can carry possible "attribute" flags like the
+		 * TT_CLIENT_TEMP, therefore they have to be copied in the
+		 * client entry
+		 */
+		if (!is_multicast_ether_addr(common->addr))
+			common->flags |= flags & (~BATADV_TT_SYNC_MASK);
+
+		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
+		 * one originator left in the list and we previously received a
+		 * delete + roaming change for this originator.
+		 *
+		 * We should first delete the old originator before adding the
+		 * new one.
+		 */
+		if (common->flags & BATADV_TT_CLIENT_ROAM) {
+			delete = true;
+			tt_global_entry->roam_at = 0;
+			common->flags &= ~BATADV_TT_CLIENT_ROAM;
+		}
+	}
+
+	return delete;
+}
+
 /**
  * batadv_tt_global_create() - allocate and initialize a global TT entry
  * @tt_addr: the mac address of the non-mesh client
@@ -1974,41 +2025,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 			goto add_orig_entry;
 		}
 
-		delete = false;
-
-		spin_lock_bh(&common->flags_lock);
-		/* if the client was temporary added before receiving the first
-		 * OGM announcing it, we have to clear the TEMP flag. Also,
-		 * remove the previous temporary orig node and re-add it
-		 * if required. If the orig entry changed, the new one which
-		 * is a non-temporary entry is preferred.
-		 */
-		if (common->flags & BATADV_TT_CLIENT_TEMP) {
-			delete = true;
-			common->flags &= ~BATADV_TT_CLIENT_TEMP;
-		}
-
-		/* the change can carry possible "attribute" flags like the
-		 * TT_CLIENT_TEMP, therefore they have to be copied in the
-		 * client entry
-		 */
-		if (!is_multicast_ether_addr(common->addr))
-			common->flags |= flags & (~BATADV_TT_SYNC_MASK);
-
-		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
-		 * one originator left in the list and we previously received a
-		 * delete + roaming change for this originator.
-		 *
-		 * We should first delete the old originator before adding the
-		 * new one.
-		 */
-		if (common->flags & BATADV_TT_CLIENT_ROAM) {
-			delete = true;
-			tt_global_entry->roam_at = 0;
-			common->flags &= ~BATADV_TT_CLIENT_ROAM;
-		}
-		spin_unlock_bh(&common->flags_lock);
-
+		delete = batadv_tt_global_merge_flags(tt_global_entry, flags);
 		if (delete)
 			batadv_tt_global_del_orig_list(tt_global_entry);
 	}
-- 
2.47.3

