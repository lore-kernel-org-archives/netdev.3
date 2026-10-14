Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD79A3F2116
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997409; cv=none; b=EdUHX0r1iLnX1iyX1MiGCj7kvqDVgfoj4bpqoK9gXdweMFyp6N24Mk0I+NUf9VTL9mZwNmnCMgBncgJ6EJlAH1+SMF+rE0ArtDf9LSoa9Bl3B2g2oIN7BuKloSR9kTlYc7ff4ICAYYyZ6HmqdV/2S511Qab14xkKq51wBTMGBbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997409; c=relaxed/simple;
	bh=uaIkzR8evxVH7/rSXAwCo2cOBUVlFMFGBzEAl38Qi0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCEcidHZWReW1pFl2g/4ayE/AEGue/q0OgvHNLQ29u1/Xq8suUWYuRyQlBX+3WFr9vvwBhsG60vwhnBjQ7JX1gcazaXfZA5cb+so+RhMLj4j3ZJZCYvKFw9YfuxUXlaQxef9jGxFket4lXuql81CZRAOpILJbucW+c/lZuWLIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=cxF9L/r2; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="cxF9L/r2"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso1740713a12.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791997407; x=1792602207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E8V6uqhAqWa6MF3zqg1iOpPXTxg7nTUma99cKdwC/10=;
        b=cxF9L/r2nkUFhu58GJV2hzloOEl/0iBCpN76YIXOsemKMutTdhK4NHRVq0SrpkPQ0S
         HIXHXqSzzdGXl3Maosbex0DF9jGl2AUJGBjJZiqz0WKHkCA5OuxbCJF7ILkAk749h38+
         He5EBpiZdR70Y4Yed5ylXJM7aeXHTacOYdAWK6j5wHZ2EPSQkJl+Pc3gne7aGG8D64N2
         YulytIrH22mHyql0I+WFX71s1bkvUL8RoDdOTRENfHzUQD2kLoNEWtnSc1SZFhtYqEk3
         rWY9oQ6f1Y9iJEUE7+tjvW0Fisxk4MglStFv1Qx3OsBtjYtZJHiIZCCqRQj3AxBD1xPz
         HbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997407; x=1792602207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E8V6uqhAqWa6MF3zqg1iOpPXTxg7nTUma99cKdwC/10=;
        b=s7N4k0OaAdjkPonH3+K6qol6hHtf6i98xkJxD7uwyHt4vyWKeG+CX6ZWPryQmE5m3x
         WVveqDysn+7m5q4zRObfo+hehFMKBQNK0BMKuLQtyFtJ4ezZK+LkV6cpMnNhnIvVLwPu
         Ebmx3/m4RZuMdg4hZQ1pqyajlQsCJsszBtqkZX4anN4+VJ/ls9tIvub0HuGH3tN+rymG
         asL8NAzG5C2i22q0hSWvxl+rqc+OnPCNpW0IWcxaZ3sc3kNQiAVc5wTtpEC2hhaVIc/Q
         jHKOZ7hPQKKvd+vUVnHISDUZ+n4b9C6bPZ01lHV3TXACopFL4qGXQv73yZAn1EYUKlB4
         vNog==
X-Forwarded-Encrypted: i=1; AKwUvBwAY6jRO9xeI/LjCTint21VrcDfictiG062+YFwoF8qe+L+YYvdFpuFl9cKvIdbbnN6qcM2W5w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOLV85TCprrSIAreSJlF/L6vFk5aghSz1p5YSOCP9fnVdURnyj
	8SrdX8fvtqYemNPHGkeY+X13jhwWVwLDbKq88voM6oJcU/NTp29MuYUZietjAJaydZ8f
X-Gm-Gg: AYBFou2wKo8cET+MHHawKHoi6z+JRcYnwPA6FJqSRa+xr8kH/yGkqm11L5/UDk8lqYC
	CbSteAESr+QIGtrUxHg8YN4H6uQh/0CqhF9WtZQy71wk30/VuJ+Ni1oR4xV56TDxzxUrYckam8y
	BlWK4wKQDqgK8V0Dj6Q6BpudQzkdbgmHe3AMTZId5dz8nd+wzYd58f1czEBIITi10KoIgEJpldC
	UwPnr5ii1PINunx/5ydUxvC4EeAL2kcTR4U5U3liTznh0vJ3nrzLqvHIMoO1nNGE/M3c35YXWux
	73c4ewGbtu9lfOI3I6tQVfFh5vcHjOzuVUN7n++GfvaQEuISPRx64VwrhcvlN7X2FFggKF7Dqsw
	qfcTgKfTb0CuUQ877l0+HsR1odJluuuOiBtuufGGNpuig+DAULU+Z+MQ9quItssQc8dIbzefM/u
	Mf7qPwyrmDtxKkv55s1R9vv1p8VK/GPYTvrf+jaKIEXk1lKXa+njkdfGO/yqZH1fC3mrStMerCV
	Xh9fzOxIOKRJYoAGQycFflSLs/XC+eTGtr7G510
X-Received: by 2002:a17:90b:2b48:b0:3a8:1320:38b5 with SMTP id 98e67ed59e1d1-3ab3a747d7amr13283375a91.30.1791997406588;
        Wed, 14 Oct 2026 10:03:26 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94792925sm190406a91.13.2026.10.14.10.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:03:25 -0700 (PDT)
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
Subject: [PATCH net v9 2/3] rxrpc: bound connection and OOB receive queues
Date: Wed, 14 Oct 2026 16:58:35 +0000
Message-ID: <7fcebf53a6ccaec41de4acc52465b2937297071a.1791994058.git.zihanx@nebusec.ai>
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

After rxrpc_io_thread() dequeues a packet, the UDP receive-memory charge
is released. Connection-level packets can remain queued on conn->rx_queue,
while managed RXGK challenges can remain on the socket's OOB queue and
pending-response set.

Account both paths against a per-local receive budget. Release the charge
when a packet is processed, answered, freed or purged, and retain it when a
secured service packet is returned to the local I/O queue.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/cover.1791428529.git.zihanx@nebusec.ai/
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v9:
  - Split connection/OOB queue budgeting from DATA receive-queue
    budgeting.
  - Add the Fixes attribution for the RXGK challenge OOB path.
  - Order receive-budget helper declarations per netdev reverse-xmas style.
  - v8 Link: https://lore.kernel.org/all/cover.1791428529.git.zihanx@nebusec.ai/
---
 net/rxrpc/ar-internal.h  |  3 +++
 net/rxrpc/conn_event.c   | 22 ++++++++++++++++----
 net/rxrpc/conn_object.c  | 19 +++++++++++++++---
 net/rxrpc/io_thread.c    |  2 ++
 net/rxrpc/local_object.c |  1 +
 net/rxrpc/oob.c          |  5 ++++-
 net/rxrpc/skbuff.c       | 43 +++++++++++++++++++++++++++++++++++++++-
 7 files changed, 86 insertions(+), 9 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index b079ec98aaa74..36fc4609181e1 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -360,6 +360,7 @@ struct rxrpc_local {
 	struct sk_buff_head	rx_delay_queue;	/* Delay injection queue */
 #endif
 	struct sk_buff_head	rx_queue;	/* Received packets */
+	atomic_long_t		rx_async_queue_bytes;	/* Outstanding async Rx bytes */
 	struct list_head	conn_attend_q;	/* Conns requiring immediate attention */
 	struct list_head	call_attend_q;	/* Calls requiring immediate attention */
 
@@ -1516,6 +1517,8 @@ void rxrpc_new_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_see_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_get_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_free_skb(struct sk_buff *, enum rxrpc_skb_trace);
+bool rxrpc_charge_async_queue(struct rxrpc_local *, struct sk_buff *);
+void rxrpc_uncharge_async_queue(struct rxrpc_local *, struct sk_buff *);
 void rxrpc_purge_queue(struct sk_buff_head *);
 
 /*
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 611c790bc6d0c..4baddd178cfa5 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -393,6 +393,8 @@ static void rxrpc_do_process_connection(struct rxrpc_connection *conn)
 	while ((skb = skb_dequeue(&conn->rx_queue))) {
 		rxrpc_see_skb(skb, rxrpc_skb_see_conn_work);
 		rxrpc_process_event(conn, skb);
+		if (skb->mark != RXRPC_SKB_MARK_SERVICE_CONN_SECURED)
+			rxrpc_uncharge_async_queue(conn->local, skb);
 		rxrpc_free_skb(skb, rxrpc_skb_put_conn_work);
 	}
 }
@@ -414,15 +416,22 @@ void rxrpc_process_connection(struct work_struct *work)
  * post connection-level events to the connection
  * - this includes challenges, responses, some aborts and call terminal packet
  *   retransmission.
+ * - bound the queued memory independently of the UDP rmem charge.
  */
-static void rxrpc_post_packet_to_conn(struct rxrpc_connection *conn,
+static bool rxrpc_post_packet_to_conn(struct rxrpc_connection *conn,
 				      struct sk_buff *skb)
 {
+	struct rxrpc_local *local = conn->local;
+
+	if (!rxrpc_charge_async_queue(local, skb))
+		return false;
+
 	_enter("%p,%p", conn, skb);
 
 	rxrpc_get_skb(skb, rxrpc_skb_get_conn_work);
 	skb_queue_tail(&conn->rx_queue, skb);
 	rxrpc_queue_conn(conn, rxrpc_conn_queue_rx_work);
+	return true;
 }
 
 /*
@@ -442,7 +451,10 @@ static bool rxrpc_post_challenge(struct rxrpc_connection *conn,
 		rxrpc_get_connection(conn, rxrpc_conn_get_challenge_input);
 
 	if (!conn->security->challenge_to_recvmsg) {
-		rxrpc_post_packet_to_conn(conn, skb);
+		if (!rxrpc_post_packet_to_conn(conn, skb)) {
+			rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
+			sp->chall.conn = NULL;
+		}
 		return true;
 	}
 
@@ -480,8 +492,10 @@ static bool rxrpc_post_challenge(struct rxrpc_connection *conn,
 		return false;
 	}
 
-	if (!call)
-		rxrpc_post_packet_to_conn(conn, skb);
+	if (!call && !rxrpc_post_packet_to_conn(conn, skb)) {
+		rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
+		sp->chall.conn = NULL;
+	}
 	return true;
 }
 
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 0ece717db0f85..d85345e014a9f 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -300,6 +300,19 @@ static void rxrpc_rcu_free_connection(struct rcu_head *rcu)
 		wake_up_var(&rxnet->nr_conns);
 }
 
+/*
+ * Purge a connection's receive queue, updating the local queue accounting.
+ */
+static void rxrpc_purge_conn_queue(struct rxrpc_connection *conn)
+{
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&conn->rx_queue))) {
+		rxrpc_uncharge_async_queue(conn->local, skb);
+		rxrpc_free_skb(skb, rxrpc_skb_put_purge);
+	}
+}
+
 /*
  * Clean up a dead connection.
  */
@@ -329,7 +342,7 @@ static void rxrpc_clean_up_connection(struct work_struct *work)
 		conn->peer->pmtud_pending = true;
 	}
 
-	rxrpc_purge_queue(&conn->rx_queue);
+	rxrpc_purge_conn_queue(conn);
 	rxrpc_free_skb(conn->tx_response, rxrpc_skb_put_response);
 
 	rxrpc_kill_client_conn(conn);
@@ -338,15 +351,15 @@ static void rxrpc_clean_up_connection(struct work_struct *work)
 	key_put(conn->key);
 	rxrpc_put_bundle(conn->bundle, rxrpc_bundle_put_conn);
 	rxrpc_put_peer(conn->peer, rxrpc_peer_put_conn);
-	rxrpc_put_local(conn->local, rxrpc_local_put_kill_conn);
 
 	/* Drain the Rx queue.  Note that even though we've unpublished, an
 	 * incoming packet could still be being added to our Rx queue, so we
 	 * will need to drain it again in the RCU cleanup handler.
 	 */
-	rxrpc_purge_queue(&conn->rx_queue);
+	rxrpc_purge_conn_queue(conn);
 
 	page_frag_cache_drain(&conn->tx_data_alloc);
+	rxrpc_put_local(conn->local, rxrpc_local_put_kill_conn);
 	call_rcu(&conn->rcu, rxrpc_rcu_free_connection);
 }
 
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 634a6e1cab87a..8679402c03e1b 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -528,6 +528,8 @@ int rxrpc_io_thread(void *data)
 
 			if (skb->mark == RXRPC_SKB_MARK_PACKET)
 				rxrpc_skb_orphan_udp(skb);
+			else if (skb->mark == RXRPC_SKB_MARK_SERVICE_CONN_SECURED)
+				rxrpc_uncharge_async_queue(sp->poke_conn->local, skb);
 			switch (skb->mark) {
 			case RXRPC_SKB_MARK_PACKET:
 				skb->priority = 0;
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index f519a93059244..8e43f77d43683 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -137,6 +137,7 @@ static struct rxrpc_local *rxrpc_alloc_local(struct net *net,
 		skb_queue_head_init(&local->rx_delay_queue);
 #endif
 		skb_queue_head_init(&local->rx_queue);
+		atomic_long_set(&local->rx_async_queue_bytes, 0);
 		INIT_LIST_HEAD(&local->conn_attend_q);
 		INIT_LIST_HEAD(&local->call_attend_q);
 
diff --git a/net/rxrpc/oob.c b/net/rxrpc/oob.c
index c80ee2487d094..5ab4ec5ad8c31 100644
--- a/net/rxrpc/oob.c
+++ b/net/rxrpc/oob.c
@@ -46,7 +46,8 @@ bool rxrpc_notify_socket_oob(struct rxrpc_call *call, struct sk_buff *skb)
 		sk = &rx->sk;
 		spin_lock_irq(&rx->recvmsg_lock);
 
-		if (sk->sk_state < RXRPC_CLOSE) {
+		if (sk->sk_state < RXRPC_CLOSE &&
+		    rxrpc_charge_async_queue(sp->chall.conn->local, skb)) {
 			skb->skb_mstamp_ns = rx->oob_id_counter++;
 			rxrpc_get_skb(skb, rxrpc_skb_get_post_oob);
 			skb_queue_tail(&rx->recvmsg_oobq, skb);
@@ -215,6 +216,7 @@ static int rxrpc_respond_to_oob(struct rxrpc_sock *rx,
 
 	switch (skb->mark) {
 	case RXRPC_OOB_CHALLENGE:
+		rxrpc_uncharge_async_queue(sp->chall.conn->local, skb);
 		rxrpc_put_connection(sp->chall.conn, rxrpc_conn_put_oob);
 		break;
 	}
@@ -329,6 +331,7 @@ void rxrpc_kernel_free_oob(struct sk_buff *oob)
 
 	switch (oob->mark) {
 	case RXRPC_OOB_CHALLENGE:
+		rxrpc_uncharge_async_queue(sp->chall.conn->local, oob);
 		rxrpc_put_connection(sp->chall.conn, rxrpc_conn_put_oob);
 		break;
 	}
diff --git a/net/rxrpc/skbuff.c b/net/rxrpc/skbuff.c
index e2169d1a14b5f..a5113a284456e 100644
--- a/net/rxrpc/skbuff.c
+++ b/net/rxrpc/skbuff.c
@@ -58,6 +58,39 @@ void rxrpc_free_skb(struct sk_buff *skb, enum rxrpc_skb_trace why)
 	}
 }
 
+/*
+ * Charge an skb retained outside UDP receive-memory accounting.
+ */
+bool rxrpc_charge_async_queue(struct rxrpc_local *local, struct sk_buff *skb)
+{
+	struct sock *sk = local->socket->sk;
+	long rcvbuf;
+	long queued;
+
+	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+
+	for (;;) {
+		queued = atomic_long_read(&local->rx_async_queue_bytes);
+		if (queued &&
+		    (queued >= rcvbuf ||
+		     (long)skb->truesize >= rcvbuf - queued)) {
+			sk_drops_inc(sk);
+			return false;
+		}
+		if (atomic_long_cmpxchg(&local->rx_async_queue_bytes, queued,
+					queued + (long)skb->truesize) == queued)
+			return true;
+	}
+}
+
+/*
+ * Release the asynchronous receive charge on an skb.
+ */
+void rxrpc_uncharge_async_queue(struct rxrpc_local *local, struct sk_buff *skb)
+{
+	atomic_long_sub(skb->truesize, &local->rx_async_queue_bytes);
+}
+
 /*
  * Clear a queue of socket buffers.
  */
@@ -66,7 +99,15 @@ void rxrpc_purge_queue(struct sk_buff_head *list)
 	struct sk_buff *skb;
 
 	while ((skb = skb_dequeue((list))) != NULL) {
-		int n = atomic_dec_return(select_skb_count(skb));
+		int n;
+
+		if (skb->mark == RXRPC_SKB_MARK_SERVICE_CONN_SECURED) {
+			struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+
+			rxrpc_uncharge_async_queue(sp->poke_conn->local, skb);
+			rxrpc_put_connection(sp->poke_conn, rxrpc_conn_put_poke);
+		}
+		n = atomic_dec_return(select_skb_count(skb));
 		trace_rxrpc_skb(skb, refcount_read(&skb->users), n,
 				rxrpc_skb_put_purge);
 		consume_skb(skb);
-- 
2.43.0

