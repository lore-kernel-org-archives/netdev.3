Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0031340401
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769121; cv=none; b=kPl1j9oDwDNQS24e/4oy/S5Pn9siLXk2RVctfIugTDOwujXS6bSvGVocArAdjd4l30amgz5uSI+pOs8PJcADc8gOHz+1tjOo950Y0w8TvfLqOTZHj8SshHdpW0UDs2BTJHZc026HrarrQQ5Dkk57TEu+3Z7FAuWLwtCG4M4mUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769121; c=relaxed/simple;
	bh=ZULiR9cVNnOl5dQiAij+TLFVx9jy77NyzGCrHJOLC1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nslVYtSTALK6wIKXnfVZQlS8rpn1jPes5at62qpZfXobse9mRKnTwkFwTRqBV24HUWM8CU7HeI1XGGjPWy/pQSB6YzWwnJHWhpXeTLuWhoCc72gf2XgUZt+lj2ZJw5J4+mFHaxFzwlYOlwtcO3hSiuWQof1/4rYVapZl86J+i4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=VypMkJim; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="VypMkJim"
Received: from kero.packetmixer.de (p200300C59748D0d8C3747188e6DFE6c0.dip0.t-ipconnect.de [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 088D6FA2BF;
	Mon, 07 Sep 2026 10:18:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYYAL99fI+3xs+LRvqt1S/0lzPOfMPpCYz8ivw1Xc+c=;
	b=VypMkJimVaiqgFJMVlNNzCF3ON4gWs4eDXO9e75F+RuXVUaR19cfEs39ASRxWU9X9o190j
	g+2MA9AqIicgf5kBKb3xOYUtK2PtfHOkZddTowpyjynisnBFbZAZq5Lt8UKmrjjarPwDop
	f65IyrcoweHxKh0s3rbQCyfW+DhPUwR5NeYlHLJj6aZyC4oFjt1d3jdjSIvNYyfZLwITgY
	1CLgKqDeNJT0UPDYZAkLmKsIEjy53zJqMpoMp2AqUdWoWkwM+sEuxlOgA7vptY++aKflNU
	sa3sdCqzZnkV0w/sP4gnhIEwQmuTinX5aaSM+VXZGlsWcSO14at4L8t47nzF3w==
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
Subject: [PATCH net-next 10/15] batman-adv: tt: extract marking of a removed local entry
Date: Mon,  7 Sep 2026 10:18:19 +0200
Message-ID: <20260907081824.2474040-11-sw@simonwunderlich.de>
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

The first locked section of batadv_tt_local_remove() does three things at
once

* it snapshots the flags for the return value
* it marks the client as ROAMed
* it decides whether the entry has to survive until the next ttvn increment

But this complex locked section is in the middle of the function and cannot
be written as scoped_guard() due to goto's in this routine.

Move it to batadv_tt_local_mark_removed() and report the decision via its
return value. But leave the batadv_tt_local_set_pending_event() flag
assembly outside the function because it has no locking requirements.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 48 ++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b3e45fb5e9dd4..f5b753ed1ae1a 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1443,6 +1443,38 @@ batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
 		   batadv_print_vid(tt_local_entry->common.vid), message);
 }
 
+/**
+ * batadv_tt_local_mark_removed() - mark a local entry as removed
+ * @tt_local_entry: local TT entry to mark
+ * @roaming: true if the deletion is due to a roaming event
+ * @curr_flags: pointer to store the flags of the entry before it was marked
+ *
+ * Return: true if the entry has to be kept in the local table until the next
+ * ttvn increment, false if it can be purged immediately.
+ */
+static bool
+batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
+			     bool roaming, u16 *curr_flags)
+{
+	struct batadv_tt_common_entry *common = &tt_local_entry->common;
+	bool pending = false;
+
+	scoped_guard(spinlock_bh, &common->flags_lock) {
+		*curr_flags = common->flags;
+
+		/* mark the local client as ROAMed */
+		if (roaming)
+			common->flags |= BATADV_TT_CLIENT_ROAM;
+
+		if (!(common->flags & BATADV_TT_CLIENT_NEW)) {
+			common->flags |= BATADV_TT_CLIENT_PENDING;
+			pending = true;
+		}
+	}
+
+	return pending;
+}
+
 /**
  * batadv_tt_local_remove() - logically remove an entry from the local table
  * @bat_priv: the bat priv with all the mesh interface information
@@ -1467,26 +1499,16 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (!tt_local_entry)
 		goto out;
 
-	spin_lock_bh(&tt_local_entry->common.flags_lock);
-	curr_flags = tt_local_entry->common.flags;
-
 	flags = BATADV_TT_CLIENT_DEL;
 	/* if this global entry addition is due to a roaming, the node has to
 	 * mark the local entry as "roamed" in order to correctly reroute
 	 * packets later
 	 */
-	if (roaming) {
+	if (roaming)
 		flags |= BATADV_TT_CLIENT_ROAM;
-		/* mark the local client as ROAMed */
-		tt_local_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
-	}
-
-	if (!(tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW)) {
-		tt_local_entry->common.flags |= BATADV_TT_CLIENT_PENDING;
-		pending = true;
-	}
-	spin_unlock_bh(&tt_local_entry->common.flags_lock);
 
+	pending = batadv_tt_local_mark_removed(tt_local_entry, roaming,
+					       &curr_flags);
 	if (pending) {
 		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry, flags,
 						  message);
-- 
2.47.3

