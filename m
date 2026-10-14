Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EB75632A0
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997415; cv=none; b=kgwU7jp5YmpyHnjclH5bstRqrTEO6tHz3D/ISHVZlBLICoIKbpwKtYJ5UBWvEgJYcVEzzL+gA8aiSm7baa4qERQvR2arZHyh+qHW/DwDKtlDhrJUFRl7Vj5h+0nWscsWXmaKBF17q3Oww7978ezdMh5p8vmTjvKllE6ude6QJdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997415; c=relaxed/simple;
	bh=ZCAj5qCE+Na42wzdj6f8WjbnDJItDP+nVzDuApjn03s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YePtfVShTy/2lFKxfJ0V5YV8SsUDIWeg7DWKUGLvZCSdps0vsueh0PL5HG8LMxhSBoPW6qeOu9Y0qKeJuxNxoXWbLbGeMV62VAlI8Zqtn8uMKwsJz+M7O49zHZXNCS5kczI2jVW0qnm7MOn1Jo3LsC1RChTNYuVOHms/Pcj+vPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=k8e5fC/F; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="k8e5fC/F"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so640577a12.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791997413; x=1792602213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ugF06mjxYvnU0C9PpIlhm3iMS0XIuy+NGR7vRCsQlXo=;
        b=k8e5fC/FPIAO6xXFPBuZPZWRAgJ+jxppyQOJhHKYdMnKPfyZnUVjsU1kt4ElBAsrS8
         G1eYghuy0atsC3ycXd45ZWDYJ544J5X14TK5cwr3ePguzD3yVPzP9lHOiB9eTbe4Emqu
         7C/tNRBBvX57av/C82QI4K8aco3gYml7PeRPiS8xPplu3Yo1UENRZw4OKqsH9+zBnlaJ
         c9IkCHkCsmZvszS+ynhaUiGOAn9eN6bTqPgL7j1gumzNcpn3VpolAp6twvPuviml8VcX
         duuJO2uVuUvoBKmuv4TtmQnh9risb6mr5Ou/vGcdR7TQGwkEEfLIwwrJ1jhVI/tJ20K1
         HQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997413; x=1792602213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ugF06mjxYvnU0C9PpIlhm3iMS0XIuy+NGR7vRCsQlXo=;
        b=QU3a1RQegarnlsOBXIOeKhOTBuHj4VHvwoj5wFy6WDl4frQCtzKXB2khh+qOae6IzV
         LWk2F6wDxSs+c3pjqTcAW6IEn2MhyQz5reMpGvoHapOh51KRthjj8ZocwDqT2Ulp/qJ7
         lmoiBkYli9AqGPg9WcKkzp4yN2o57LtH6s+gZw5l1/KLFchl8rg6Lo2Uoo1JKKnkfIRl
         Irq8nTWyY3qVP1xVyvbyjDeKM+YJWpDC2dbJj6DCXyTZPeOexvu7Pg687sMfz3rR7Ck8
         SN8w4Cc/RGr3CzXEwgU+bffon56lqhf8fQZEUpOMH3Z9JcqX4JOcWopv8kn292N8bvfR
         A3Rw==
X-Forwarded-Encrypted: i=1; AKwUvBy4XiwhKzhm0xmhq/2+eSaCZxqsJuWkW14WhnxkbnSxHbmvdh3/OAKJvELCzdGbHS0U79QcUKM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI56sqfKRXZKZj8jXzwUMhpcFQjX+3nOzFYiTckULprmBzlUT4o
	wCyyweBK9wNvKHAeBFUVfLrVXobEJaCtRbcBCKh4TXCoifn/nPspgG56s7oERGz2Nacl
X-Gm-Gg: AYBFou0EPgz5sMPYkeMZ8oLaySa88xL8m4Y3o072lDCsHKxZVscuu0KGrogb8O4kBPP
	K3XjYVdcYsa2msRk0YYM0zE7K7aaD9t3E3eUEy26rpi72/0L9CuEp0nuls5TA2vmfLDFz+8dWt6
	YiGPO+INLem/bpML0GxmFpgxXeY6PZtYKClt4DyUsrTfbtQSaZnO22morTzJuFfRK71jT/q1uo6
	oyj2EBrmwf3ljUFD/ewqY0L/KbVRQufjJjReU278UIsC19cE0wHIP5roPEiF9w/7pYB0LZCP+iz
	UriqBMP3rttfGxHeNZnr1qBfgmv8KKMo6/EEopfacWltz7UZyn1L5VbdOVHrryxOlxihlO1ZLMF
	EY03rWCJKx7i7cY/zqdeFEkSSNPmGFxJQNlYrd4/1EWqF7cnT9gL/9eLX30YK7swQZ04n1yHjzM
	+ECg2SVa5yZiqz0BD6QUIa7A5yt3IHvavhGCm7QjDdGGaAGARwc8KlSgxAsKx6jYnLL3HQw6EpF
	vfv1CzmJCx0B9QgVJCMl+S0S3EIP9wB5swV4Wb/
X-Received: by 2002:a17:90b:1a90:b0:39e:6a80:dd9d with SMTP id 98e67ed59e1d1-3ab3a9aa92bmr15129591a91.36.1791997412460;
        Wed, 14 Oct 2026 10:03:32 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94792925sm190406a91.13.2026.10.14.10.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:03:31 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@kernel.org,
	horms@kernel.org,
	vega@nebusec.ai,
	root@tr0jan.top,
	zihanx@nebusec.ai
Subject: [PATCH net v9 3/3] rxrpc: bound DATA receive queues
Date: Wed, 14 Oct 2026 16:58:36 +0000
Message-ID: <4528cb16accabf1dfddb1762c8f7f5977a9383f8.1791994058.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791994057.git.zihanx@nebusec.ai>
References: <cover.1791994057.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DATA packets retained in per-call buffers are not covered by common socket
receive-memory accounting. Separate calls can therefore accumulate more
DATA than the shared limit. The receive window also advances as packets
arrive, while rx_consumed advances only as the application reads them, so a
single call can retain more unconsumed DATA than the window should allow.

Charge accepted DATA to the per-local asynchronous receive budget and base
the per-call receive window on rx_consumed. Account split jumbo skbs and
release the charge when packets are consumed or purged.

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Fixes: 5d7edbc9231e ("rxrpc: Get rid of the Rx ring")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/cover.1791428529.git.zihanx@nebusec.ai/
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v9:
  - Split DATA receive-window and per-local aggregate queue accounting
    from connection/OOB queue budgeting.
  - Attribute the aggregate DATA accounting gap to 248f219cb8bc and retain
    5d7edbc9231e for the receive-window accounting issue.
  - v8 Link: https://lore.kernel.org/all/cover.1791428529.git.zihanx@nebusec.ai/
---
 net/rxrpc/ar-internal.h | 23 ++++++++++-
 net/rxrpc/call_event.c  |  1 +
 net/rxrpc/call_object.c |  4 +-
 net/rxrpc/input.c       | 83 +++++++++++++++++++++++++------------
 net/rxrpc/recvmsg.c     |  3 +-
 net/rxrpc/skbuff.c      | 92 +++++++++++++++++++++++++++++++++++++----
 6 files changed, 168 insertions(+), 38 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 36fc4609181e1..1f1f49eca8e11 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -50,6 +50,7 @@ struct key_preparsed_payload;
 struct rxrpc_connection;
 struct rxrpc_txbuf;
 struct rxrpc_txqueue;
+struct rxrpc_async_queue_charge;
 struct rxgk_context;
 
 /*
@@ -222,6 +223,15 @@ struct rxrpc_host_header {
 	u16		serviceId;	/* service ID */
 } __packed;
 
+/*
+ * Shared asynchronous receive-memory charge for split jumbo DATA packets.
+ */
+struct rxrpc_async_queue_charge {
+	refcount_t		ref;
+	long			size;
+	bool			charged;
+};
+
 /*
  * RxRPC socket buffer private variables
  * - max 48 bytes (struct sk_buff::cb)
@@ -233,6 +243,11 @@ struct rxrpc_skb_priv {
 			u16		offset;		/* Offset of data */
 			u16		len;		/* Length of data */
 		};
+		struct {
+			u16		offset;
+			u16		len;
+			struct rxrpc_async_queue_charge *charge;
+		} data;
 		struct {
 			rxrpc_seq_t	first_ack;	/* First packet in acks table */
 			rxrpc_seq_t	prev_ack;	/* Highest seq seen */
@@ -1517,8 +1532,12 @@ void rxrpc_new_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_see_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_get_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_free_skb(struct sk_buff *, enum rxrpc_skb_trace);
-bool rxrpc_charge_async_queue(struct rxrpc_local *, struct sk_buff *);
-void rxrpc_uncharge_async_queue(struct rxrpc_local *, struct sk_buff *);
+struct rxrpc_async_queue_charge *rxrpc_alloc_async_queue_charge(struct sk_buff *skb);
+void rxrpc_put_async_queue_charge(struct rxrpc_local *local,
+				  struct rxrpc_async_queue_charge *charge);
+bool rxrpc_charge_async_queue(struct rxrpc_local *local, struct sk_buff *skb);
+void rxrpc_uncharge_async_queue(struct rxrpc_local *local, struct sk_buff *skb);
+void rxrpc_purge_data_queue(struct rxrpc_call *call, struct sk_buff_head *list);
 void rxrpc_purge_queue(struct sk_buff_head *);
 
 /*
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 21be9c86d7a74..9360852604645 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -473,6 +473,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 out:
 	if (__rxrpc_call_is_complete(call)) {
 		timer_delete_sync(&call->timer);
+		rxrpc_purge_queue(&call->rx_queue);
 		if (!test_bit(RXRPC_CALL_DISCONNECTED, &call->flags))
 			rxrpc_disconnect_call(call);
 		if (call->security)
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 817ed9acb91e6..8f115be491249 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -553,9 +553,9 @@ static void rxrpc_cleanup_tx_buffers(struct rxrpc_call *call)
  */
 static void rxrpc_cleanup_rx_buffers(struct rxrpc_call *call)
 {
-	rxrpc_purge_queue(&call->recvmsg_queue);
+	rxrpc_purge_data_queue(call, &call->recvmsg_queue);
 	rxrpc_purge_queue(&call->rx_queue);
-	rxrpc_purge_queue(&call->rx_oos_queue);
+	rxrpc_purge_data_queue(call, &call->rx_oos_queue);
 	kfree(call->rx_dec_buffer);
 }
 
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 73cafe6bfa9f5..6f0ba50097390 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -479,7 +479,9 @@ static void rxrpc_input_queue_data(struct rxrpc_call *call, struct sk_buff *skb,
  * Process a DATA packet.
  */
 static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
-				 bool *_notify, rxrpc_serial_t *_ack_serial, int *_ack_reason)
+				 bool *_notify, rxrpc_serial_t *_ack_serial,
+				 int *_ack_reason,
+				 struct rxrpc_async_queue_charge **_charge)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct sk_buff *oos;
@@ -487,9 +489,13 @@ static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
 	unsigned int sack = call->ackr_sack_base;
 	rxrpc_seq_t window = call->ackr_window;
 	rxrpc_seq_t wtop = call->ackr_wtop;
-	rxrpc_seq_t wlimit = window + call->rx_winsize - 1;
+	/* Bound queued DATA by the application's receive window. */
+	rxrpc_seq_t wlimit = smp_load_acquire(&call->rx_consumed) +
+		call->rx_winsize;
 	rxrpc_seq_t seq = sp->hdr.seq;
 	bool last = sp->hdr.flags & RXRPC_LAST_PACKET;
+	bool set_last = false;
+	unsigned int slot = 0;
 	int ack_reason = -1;
 
 	rxrpc_inc_stat(call->rxnet, stat_rx_data);
@@ -498,10 +504,24 @@ static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
 	if (sp->hdr.flags & RXRPC_JUMBO_PACKET)
 		rxrpc_inc_stat(call->rxnet, stat_rx_data_jumbo);
 
+	if (after(seq, call->rx_highest_seq))
+		call->rx_highest_seq = seq;
+
+	trace_rxrpc_rx_data(call->debug_id, seq, serial, sp->hdr.flags);
+
+	if (after(seq, wlimit)) {
+		ack_reason = RXRPC_ACK_EXCEEDS_WINDOW;
+		goto send_ack;
+	}
+
 	if (last) {
-		if (test_and_set_bit(RXRPC_CALL_RX_LAST, &call->flags) &&
-		    seq + 1 != wtop)
-			return rxrpc_proto_abort(call, seq, rxrpc_eproto_different_last);
+		if (test_and_set_bit(RXRPC_CALL_RX_LAST, &call->flags)) {
+			if (seq + 1 != wtop)
+				return rxrpc_proto_abort(call, seq,
+							rxrpc_eproto_different_last);
+		} else {
+			set_last = true;
+		}
 	} else {
 		if (test_bit(RXRPC_CALL_RX_LAST, &call->flags) &&
 		    after_eq(seq, wtop)) {
@@ -511,17 +531,33 @@ static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
 		}
 	}
 
-	if (after(seq, call->rx_highest_seq))
-		call->rx_highest_seq = seq;
-
-	trace_rxrpc_rx_data(call->debug_id, seq, serial, sp->hdr.flags);
-
 	if (before(seq, window)) {
 		ack_reason = RXRPC_ACK_DUPLICATE;
 		goto send_ack;
 	}
-	if (after(seq, wlimit)) {
-		ack_reason = RXRPC_ACK_EXCEEDS_WINDOW;
+
+	if (seq != window) {
+		slot = seq - window;
+		sack = (sack + slot) % RXRPC_SACK_SIZE;
+
+		if (call->ackr_sack_table[sack]) {
+			ack_reason = RXRPC_ACK_DUPLICATE;
+			goto send_ack;
+		}
+	}
+
+	sp->data.charge = NULL;
+	if (sp->offset != sizeof(struct rxrpc_wire_header) ||
+	    (sp->hdr.flags & RXRPC_JUMBO_PACKET)) {
+		if (!*_charge)
+			*_charge = rxrpc_alloc_async_queue_charge(skb);
+		sp->data.charge = *_charge;
+	}
+	if (!rxrpc_charge_async_queue(call->local, skb)) {
+		sp->data.charge = NULL;
+		if (set_last)
+			clear_bit(RXRPC_CALL_RX_LAST, &call->flags);
+		ack_reason = RXRPC_ACK_NOSPACE;
 		goto send_ack;
 	}
 
@@ -568,19 +604,8 @@ static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
 
 		call->ackr_sack_base = sack;
 	} else {
-		unsigned int slot;
-
 		ack_reason = RXRPC_ACK_OUT_OF_SEQUENCE;
-
-		slot = seq - window;
-		sack = (sack + slot) % RXRPC_SACK_SIZE;
-
-		if (call->ackr_sack_table[sack % RXRPC_SACK_SIZE]) {
-			ack_reason = RXRPC_ACK_DUPLICATE;
-			goto send_ack;
-		}
-
-		call->ackr_sack_table[sack % RXRPC_SACK_SIZE] |= 1;
+		call->ackr_sack_table[sack] |= 1;
 		trace_rxrpc_sack(call, seq, sack, rxrpc_sack_oos);
 
 		if (after(seq + 1, wtop)) {
@@ -623,6 +648,7 @@ static void rxrpc_input_data_one(struct rxrpc_call *call, struct sk_buff *skb,
  */
 static bool rxrpc_input_split_jumbo(struct rxrpc_call *call, struct sk_buff *skb)
 {
+	struct rxrpc_async_queue_charge *charge = NULL;
 	struct rxrpc_jumbo_header jhdr;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb), *jsp;
 	struct sk_buff *jskb;
@@ -644,13 +670,15 @@ static bool rxrpc_input_split_jumbo(struct rxrpc_call *call, struct sk_buff *skb
 		jskb = skb_clone(skb, GFP_NOFS);
 		if (!jskb) {
 			kdebug("couldn't clone");
+			rxrpc_put_async_queue_charge(call->local, charge);
 			return false;
 		}
 		rxrpc_new_skb(jskb, rxrpc_skb_new_jumbo_subpacket);
 		jsp = rxrpc_skb(jskb);
 		jsp->offset = offset;
 		jsp->len = RXRPC_JUMBO_DATALEN;
-		rxrpc_input_data_one(call, jskb, &notify, &ack_serial, &ack_reason);
+		rxrpc_input_data_one(call, jskb, &notify, &ack_serial, &ack_reason,
+				    &charge);
 		rxrpc_free_skb(jskb, rxrpc_skb_put_jumbo_subpacket);
 
 		sp->hdr.flags = jhdr.flags;
@@ -664,7 +692,8 @@ static bool rxrpc_input_split_jumbo(struct rxrpc_call *call, struct sk_buff *skb
 
 	sp->offset = offset;
 	sp->len    = len;
-	rxrpc_input_data_one(call, skb, &notify, &ack_serial, &ack_reason);
+	rxrpc_input_data_one(call, skb, &notify, &ack_serial, &ack_reason,
+			    &charge);
 
 	stat_ix = umin(count, ARRAY_SIZE(call->rxnet->stat_rx_jumbo)) - 1;
 	atomic_inc(&call->rxnet->stat_rx_jumbo[stat_ix]);
@@ -681,9 +710,11 @@ static bool rxrpc_input_split_jumbo(struct rxrpc_call *call, struct sk_buff *skb
 		trace_rxrpc_notify_socket(call->debug_id, sp->hdr.serial);
 		rxrpc_notify_socket(call);
 	}
+	rxrpc_put_async_queue_charge(call->local, charge);
 	return true;
 
 protocol_error:
+	rxrpc_put_async_queue_charge(call->local, charge);
 	return false;
 }
 
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index efcba4b2e74f0..9f84fc5e74593 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -118,6 +118,7 @@ static void rxrpc_rotate_rx_window(struct rxrpc_call *call)
 
 	skb = skb_dequeue(&call->recvmsg_queue);
 	rxrpc_see_skb(skb, rxrpc_skb_see_rotate);
+	rxrpc_uncharge_async_queue(call->local, skb);
 
 	sp = rxrpc_skb(skb);
 	tseq   = sp->hdr.seq;
@@ -565,7 +566,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	goto not_yet_complete;
 
 call_failed:
-	rxrpc_purge_queue(&call->recvmsg_queue);
+	rxrpc_purge_data_queue(call, &call->recvmsg_queue);
 call_complete:
 	ret = rxrpc_recvmsg_term(call, msg);
 	if (ret < 0)
diff --git a/net/rxrpc/skbuff.c b/net/rxrpc/skbuff.c
index a5113a284456e..3b999200b6fc6 100644
--- a/net/rxrpc/skbuff.c
+++ b/net/rxrpc/skbuff.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/net.h>
 #include <linux/skbuff.h>
+#include <linux/slab.h>
 #include <net/sock.h>
 #include <net/af_rxrpc.h>
 #include "ar-internal.h"
@@ -58,10 +59,7 @@ void rxrpc_free_skb(struct sk_buff *skb, enum rxrpc_skb_trace why)
 	}
 }
 
-/*
- * Charge an skb retained outside UDP receive-memory accounting.
- */
-bool rxrpc_charge_async_queue(struct rxrpc_local *local, struct sk_buff *skb)
+static bool rxrpc_charge_async_queue_bytes(struct rxrpc_local *local, long size)
 {
 	struct sock *sk = local->socket->sk;
 	long rcvbuf;
@@ -72,25 +70,105 @@ bool rxrpc_charge_async_queue(struct rxrpc_local *local, struct sk_buff *skb)
 	for (;;) {
 		queued = atomic_long_read(&local->rx_async_queue_bytes);
 		if (queued &&
-		    (queued >= rcvbuf ||
-		     (long)skb->truesize >= rcvbuf - queued)) {
+		    (queued >= rcvbuf || size >= rcvbuf - queued)) {
 			sk_drops_inc(sk);
 			return false;
 		}
 		if (atomic_long_cmpxchg(&local->rx_async_queue_bytes, queued,
-					queued + (long)skb->truesize) == queued)
+					queued + size) == queued)
 			return true;
 	}
 }
 
+struct rxrpc_async_queue_charge *rxrpc_alloc_async_queue_charge(struct sk_buff *skb)
+{
+	struct rxrpc_async_queue_charge *charge;
+
+	charge = kzalloc(sizeof(*charge), GFP_NOFS);
+	if (!charge)
+		return NULL;
+
+	refcount_set(&charge->ref, 1);
+	charge->size = skb->truesize + sizeof(*charge);
+	return charge;
+}
+
+void rxrpc_put_async_queue_charge(struct rxrpc_local *local,
+				  struct rxrpc_async_queue_charge *charge)
+{
+	if (charge && refcount_dec_and_test(&charge->ref)) {
+		if (charge->charged)
+			atomic_long_sub(charge->size, &local->rx_async_queue_bytes);
+		kfree(charge);
+	}
+}
+
+/*
+ * Charge an skb retained outside UDP receive-memory accounting.
+ */
+bool rxrpc_charge_async_queue(struct rxrpc_local *local, struct sk_buff *skb)
+{
+	struct rxrpc_async_queue_charge *charge = NULL;
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	long size = 0;
+
+	if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA)
+		charge = sp->data.charge;
+
+	if (charge) {
+		bool clone = sp->hdr.flags & RXRPC_JUMBO_PACKET;
+
+		if (!charge->charged) {
+			size = charge->size;
+			if (clone)
+				size += SKB_DATA_ALIGN(sizeof(struct sk_buff));
+		} else if (clone) {
+			size = SKB_DATA_ALIGN(sizeof(struct sk_buff));
+		}
+		if (size && !rxrpc_charge_async_queue_bytes(local, size))
+			return false;
+		charge->charged = true;
+		refcount_inc(&charge->ref);
+		return true;
+	}
+	return rxrpc_charge_async_queue_bytes(local, (long)skb->truesize);
+}
+
 /*
  * Release the asynchronous receive charge on an skb.
  */
 void rxrpc_uncharge_async_queue(struct rxrpc_local *local, struct sk_buff *skb)
 {
+	struct rxrpc_async_queue_charge *charge;
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+
+	if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA) {
+		charge = sp->data.charge;
+		if (charge) {
+			sp->data.charge = NULL;
+			if (sp->hdr.flags & RXRPC_JUMBO_PACKET)
+				atomic_long_sub(SKB_DATA_ALIGN(sizeof(struct sk_buff)),
+						&local->rx_async_queue_bytes);
+			rxrpc_put_async_queue_charge(local, charge);
+			return;
+		}
+	}
 	atomic_long_sub(skb->truesize, &local->rx_async_queue_bytes);
 }
 
+/*
+ * Purge DATA from a call's receive queue and release its per-local charge.
+ */
+void rxrpc_purge_data_queue(struct rxrpc_call *call, struct sk_buff_head *list)
+{
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(list)) != NULL) {
+		rxrpc_uncharge_async_queue(call->local, skb);
+		rxrpc_free_skb(skb, rxrpc_skb_put_purge);
+	}
+}
+
 /*
  * Clear a queue of socket buffers.
  */
-- 
2.43.0

