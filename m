Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F6444D68A
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644020; cv=none; b=hNcGQwIfJhpPvfys36ti5mh2Vd9RlAOZkpMed5tO/EaTlJqPbfK88Y5CEhHhgkCsK9PQOKFvbtk2vQvNEKGDqYa2qjL6KBTTMNhprQEtsY6Z5YNIol1EbUQ7tBH5BRowDeIV93o9OHJy58lpz9N6WVCI5Pjn9gNQ6rokEC/Kcj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644020; c=relaxed/simple;
	bh=wfI5gPH4XkvFrt3lvuE7ERq7EJqyU2XvSp91TeTePMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIFrfsw9lLFF1Mzwm22NBQ8QMI7HuDmiyCunnXemv/d+4OmyJfwSYRBU5k1Xm1wDA0tYkbZK0bUmOS0zsodX/CdxzKiRxb1ZdJZu9SptQqzk6e7Y9ertc5WcDiDRkV6NAyFmr8MpXjYuRjRIYsC98QkhzaBuOQizZBmOhTIWxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=RaHn+Uxw; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="RaHn+Uxw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwwDQk/o0iE4YuAUidfs7nDM7wYXtXm46RbYWVM/OnI=;
	b=RaHn+UxwTY05k7h3JSOpPEmjfA+ZKR3+yqksxOWtYbOPI7qDCsIfBJiJkGr3LqyhzTeDZo
	/nrd9Kj/HblE+KNko565FI5V9Ls+2YQZcJGtGV6XZg+BYSaYPl3KICfAC3mp371PXrcFrz
	jVMi7FYCc9f0K2KVYCp00wZRpkUAOjmsgPsSTEi9hIPW2M0FBz0nZprJ/M1N8kPZfqW3kg
	PZQqj7ea6Etc//FyR8xgTC+ODBrcvQjNflgsmTyqGeSb8tHmhmGH51JcqgBD/wVNXKmJfb
	pe+0rNs7GWtialp/I/GlgIoZim4UJ7gPadIN41qyHOa1sFksRuT9kGvLBc36Lw==
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
Subject: [PATCH net-next 08/11] batman-adv: bla: update stale kernel-doc
Date: Fri,  5 Jun 2026 09:20:02 +0200
Message-ID: <20260605072005.490368-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605072005.490368-1-sw@simonwunderlich.de>
References: <20260605072005.490368-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The bridge-loop-avoidance code was changed recently to avoid inconsistent
state and race condition problems. The kernel-doc addded in these commits
(and related code) has various minor deficits which are now resolved.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c |  2 +-
 net/batman-adv/bridge_loop_avoidance.h |  2 +-
 net/batman-adv/types.h                 | 10 +++++++---
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 0bd24a19ff202..5c73f6ba16cff 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -123,7 +123,7 @@ static bool batadv_compare_backbone_gw(const struct hlist_node *node,
  * @node: list node of the first entry to compare
  * @data2: pointer to the second claims
  *
- * Return: true if the claim have the same data, 0 otherwise
+ * Return: true if the claims have the same data, false otherwise
  */
 static bool batadv_compare_claim(const struct hlist_node *node,
 				 const void *data2)
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 8673a265995ff..06c7dfb8c677f 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -21,7 +21,7 @@
  *  detect frame sent by bridge loop avoidance
  * @mac: mac address to check
  *
- * Return: true if the it looks like a loop detect frame
+ * Return: true if it looks like a loop detect frame
  * (mac starts with BA:BE), false otherwise
  */
 static inline bool batadv_bla_is_loopdetect_mac(const uint8_t *mac)
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a7fa0d9e09288..5fd5bd358a249 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1723,22 +1723,26 @@ struct batadv_priv {
 
 #ifdef CONFIG_BATMAN_ADV_BLA
 
+/**
+ * enum batadv_bla_backbone_gw_state - state of a bridge loop avoidance
+ *  backbone gateway
+ */
 enum batadv_bla_backbone_gw_state {
 	/**
 	 * @BATADV_BLA_BACKBONE_GW_STOPPED: backbone gw is being removed
-	 * and it must not longer work on requests
+	 * and it must no longer work on requests
 	 */
 	BATADV_BLA_BACKBONE_GW_STOPPED,
 
 	/**
 	 * @BATADV_BLA_BACKBONE_GW_UNSYNCED: backbone was detected out
-	 * of sync and a request was send. No traffic is forwarded until the
+	 * of sync and a request was sent. No traffic is forwarded until the
 	 * situation is resolved
 	 */
 	BATADV_BLA_BACKBONE_GW_UNSYNCED,
 
 	/**
-	 * @BATADV_BLA_BACKBONE_GW_SYNCED: backbone is consider to be in
+	 * @BATADV_BLA_BACKBONE_GW_SYNCED: backbone is considered to be in
 	 * sync. traffic can be forwarded
 	 */
 	BATADV_BLA_BACKBONE_GW_SYNCED,
-- 
2.47.3

