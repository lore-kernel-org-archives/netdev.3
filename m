Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A6625742F
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781852459; cv=none; b=D/iyHdCaQBMqNAZDqlO8ngf49FvsILBjN373d0u2k0a/RJlux4nxodcyMBDhJmQsiJQ8hkWwbXqKjI+sw003oT12zKihuDbR/RQ2wFidTZcLDsag+I1teKx0xi+uwWs6Fk5NFGKZGYDdaawXwIKWNcB4KwKjlqpO7d/MzQmTBJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781852459; c=relaxed/simple;
	bh=DwIRBUX0T8GP747+kN8bElaDCvE1bLQtOXWVOH17ksE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGR9PHkcqB3z3vMGXrFvFcTjBLxjfPATdUsHYAeI/bfsD+xc1gq0WWM11KYVJ/2eq81/Y14Q62pgVlVxYzd04ob7LjNWEBqrNr4HMyVPN+ZiHVLqTZHlkhonplaBG/z/ZE+Zj9aHxHRtpe2bBjaT/ug+7za4YmNFhTZ/uO4kpTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=A05KCRQy; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="A05KCRQy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1781852453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rCAtFVt4ZMP2kO4nXKaanvQl9nP0Gsfhi/ip7sFYGPU=;
	b=A05KCRQyRsYS6Idsa7MZHFlmbya3+zeRShHcAVvPsZsqIarAL01Deio+sNEwSD8rDid3bG
	WEITAEuS6sxkLMkp8WDaHR8WXRq0D8RNUOgOyzZiYKFeDmMGxqk8M0BZTBdBOfawuOCLbE
	JaLFbh51h0/79NX95M35EqXyXIHCjRS4sRoWvSR75APlEGar3pLyzfyMzOEZ4nmoz5MRK0
	N6Ix2Ihw0EXjfO9ANeTJqbaD+kQVN0yOlbjP02t8VR+TbPlfvvX/R2c82TgOY8csi1aRFc
	ZXyupNB/4UW5i6MBFUinAbnwt+DDIScFyLRVWfLROdbJEIFsNFwsQX4ZmeUwFA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 09/15] batman-adv: tp_meter: prevent parallel modifications of last_recv
Date: Fri, 19 Jun 2026 09:00:39 +0200
Message-ID: <20260619070045.438101-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619070045.438101-1-sw@simonwunderlich.de>
References: <20260619070045.438101-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

When last_recv is updated to store the last receive sequence number, it is
assuming that nothing is modifying in parallel while:

* check for outdated packets is done
* out of order check is performed (and packets are stored in out-of-order
  queue)
* the out-of-order queue was searched for closed gaps
* sequence number for next ack is calculated

Nothing of that was actually protected. It could therefore happen that the
last_recv was updated multiple times in parallel and the final sequence
number was calculated with deltas which had no connection to the sequence
number they were added to.

Lock this whole region with the same lock which was already used to protect
the unacked (out-of-order) list.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 22 +++++++++++++---------
 net/batman-adv/types.h    |  2 +-
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index fb87fa141e32a..055aa1ee6ac5c 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1402,6 +1402,7 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
  */
 static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 					  const struct sk_buff *skb)
+	__must_hold(&tp_vars->common.unacked_lock)
 {
 	const struct batadv_icmp_tp_packet *icmp;
 	struct batadv_tp_unacked *un, *new;
@@ -1418,12 +1419,11 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 	payload_len = skb->len - sizeof(struct batadv_unicast_packet);
 	new->len = payload_len;
 
-	spin_lock_bh(&tp_vars->common.unacked_lock);
 	/* if the list is empty immediately attach this new object */
 	if (list_empty(&tp_vars->common.unacked_list)) {
 		list_add(&new->list, &tp_vars->common.unacked_list);
 		tp_vars->common.unacked_count++;
-		goto out;
+		return true;
 	}
 
 	/* otherwise loop over the list and either drop the packet because this
@@ -1472,9 +1472,6 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 		tp_vars->common.unacked_count--;
 	}
 
-out:
-	spin_unlock_bh(&tp_vars->common.unacked_lock);
-
 	return true;
 }
 
@@ -1484,6 +1481,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
  * @tp_vars: the private data of the current TP meter session
  */
 static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
+	__must_hold(&tp_vars->common.unacked_lock)
 {
 	struct batadv_tp_unacked *un, *safe;
 	u32 to_ack;
@@ -1491,7 +1489,6 @@ static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 	/* go through the unacked packet list and possibly ACK them as
 	 * well
 	 */
-	spin_lock_bh(&tp_vars->common.unacked_lock);
 	list_for_each_entry_safe(un, safe, &tp_vars->common.unacked_list, list) {
 		/* the list is ordered, therefore it is possible to stop as soon
 		 * there is a gap between the last acked seqno and the seqno of
@@ -1509,7 +1506,6 @@ static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 		kfree(un);
 		tp_vars->common.unacked_count--;
 	}
-	spin_unlock_bh(&tp_vars->common.unacked_lock);
 }
 
 /**
@@ -1588,6 +1584,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 	const struct batadv_icmp_tp_packet *icmp;
 	struct batadv_tp_receiver *tp_vars;
 	size_t packet_size;
+	u32 to_ack;
 	u32 seqno;
 
 	icmp = (struct batadv_icmp_tp_packet *)skb->data;
@@ -1616,6 +1613,8 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 		WRITE_ONCE(tp_vars->last_recv_time, jiffies);
 	}
 
+	spin_lock_bh(&tp_vars->common.unacked_lock);
+
 	/* if the packet is a duplicate, it may be the case that an ACK has been
 	 * lost. Resend the ACK
 	 */
@@ -1627,8 +1626,10 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 		/* exit immediately (and do not send any ACK) if the packet has
 		 * not been enqueued correctly
 		 */
-		if (!batadv_tp_handle_out_of_order(tp_vars, skb))
+		if (!batadv_tp_handle_out_of_order(tp_vars, skb)) {
+			spin_unlock_bh(&tp_vars->common.unacked_lock);
 			goto out;
+		}
 
 		/* send a duplicate ACK */
 		goto send_ack;
@@ -1642,11 +1643,14 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 	batadv_tp_ack_unordered(tp_vars);
 
 send_ack:
+	to_ack = tp_vars->last_recv;
+	spin_unlock_bh(&tp_vars->common.unacked_lock);
+
 	/* send the ACK. If the received packet was out of order, the ACK that
 	 * is going to be sent is a duplicate (the sender will count them and
 	 * possibly enter Fast Retransmit as soon as it has reached 3)
 	 */
-	batadv_tp_send_ack(bat_priv, icmp->orig, tp_vars->last_recv,
+	batadv_tp_send_ack(bat_priv, icmp->orig, to_ack,
 			   icmp->timestamp, icmp->session, icmp->uid);
 out:
 	batadv_tp_receiver_put(tp_vars);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9fa8e73ff6e59..c1b3f989566f5 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1363,7 +1363,7 @@ struct batadv_tp_vars_common {
 	/** @unacked_list: list of unacked packets (meta-info only) */
 	struct list_head unacked_list;
 
-	/** @unacked_lock: protect unacked_list */
+	/** @unacked_lock: protect unacked_list + &batadv_tp_receiver.last_recv */
 	spinlock_t unacked_lock;
 
 	/** @unacked_count: number of unacked entries */
-- 
2.47.3

