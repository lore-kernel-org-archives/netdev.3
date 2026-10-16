Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0EB384CDF
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792180904; cv=none; b=FSE3JO3n9ruE9ZXUWLJEsKOZV/ASt6fhfWuQBIgUEIQPSGuzTlqSXThHp6kCTj6WsCNwEMxAaRqK8I+DoVRKh5blpE7y7V1mIO6FS7n4KyiqGBlPdICXmmoSf0M74JLBxFEvP5oXcCQwHG5JEpDodfQm9Ta633INwaAEU0/L36w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792180904; c=relaxed/simple;
	bh=RmhYclrTFbjoelMV8CqwRh/aOluel23zxWSqNEeQMQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAULL1Z0UILcBR5u3QKEiaLRT2R6Y22HXP4nMgj5E+zqt7m3C990oGn5+avPIwGCoay3Lpyd1Ygogk/gQ4xSLtX/RvJSOElF6wEp+GPT1/V2qO2aZd7H6Velt7FZNRCLMxYgYR62GqxSzUKLKGGDEnvdLajDyoFvbcitZvvm9I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=R2XqOheK; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="R2XqOheK"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8917c712f32so152297b3a.2
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792180903; x=1792785703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vwvAVW3n0rw1Bu0Ym+5LBgqXTnZJnIRQH9/RO6pTyNk=;
        b=R2XqOheKMDuZkKbvOfZ1re7HpnCPyq3rShvkLUlnU2fmamtKn7thc6E4jzDkSAwGzu
         0KDr2Gs9StvUAKg3OqWAijAfW2nbFK1C3+QMLZ/kH21pFOtGBlUo/RFVmehjZYfqFxO7
         /wdQ4JMB02yhRVjFha0i6ShLlImQm0W1h9uHWqqSu1YYg8hGzorMyFsvuV/14EWhQpGD
         QIA/yRiwS80w96WQXl8LAgEnnNNFNdNyDrlI2tDDV6q09fNwOv9a5ytoEkJphdSL3r1u
         60u/7ju4Yt6PVjs5zMGxbty3UaybhWjJBWOSMftGSKvC4gi7dxNwro4D+/pv/Q//+mfz
         q8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792180903; x=1792785703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vwvAVW3n0rw1Bu0Ym+5LBgqXTnZJnIRQH9/RO6pTyNk=;
        b=GnQrdrlESCYpF3bBweR2ikuthW5rWSvEzMJjwMbaE9fScP7Mr3Fxpt/fbjoDi4XqNO
         tw1UbBNmiEzUiQLP1qOxA2fsoHWAHNV0ccgP1KyTAkbn8xttYihJfvRF4ttd+w4urWit
         oDjvU+/5Aph2YiKH/f8cO42ZmoyKj90xm2J4nfrTE5cUbj6t3gMy8H3CZXXFyX4lIR96
         r3ry6dj6FArgfzAtr52Q+CMhWE5fB+oiatB5YcPeQT9IihKMr81k7qnxND3lrzdtjx+F
         /EVKit4lS9XDsa1Ste3wK0xtTV7UMTxMMKhQ1ktQKG0Qe6dhDxPpHiD2cgNlqgwq4/37
         FtTg==
X-Forwarded-Encrypted: i=1; AKwUvBxsAg3ShA4rsjSSqtDH2bmJCw69j4K0VO0am2JpJ/cqcZ3jh8jBxP+qD/1Op5I2rSS86ON2Puc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQHBh1hvgARMLHSt7uP6RqGeO5wkUSzzytCNCQLoVZcqEvygye
	mw+9HQxhJOSJMA+BANpGOlszXTnwWQRiGNrxSP33++oIrbj8HfkIA1Gd6wzWkz42hve032Ukvxt
	PD0YWaLqU
X-Gm-Gg: AYBFou1sfRDia0lLGTktmZAT2VBRecqWGQ5jLvK0Lmc0tx2KXLigt015TJDJ6v/F4H8
	4LzczfVWP4mQDzrLEZGJpOepnRx/wpOAkloVeJot7JXJnzscPr6tHXyEURgHAPeuTmwVtzgwY06
	bURkKJ07NQxC74LbDae7BXOlXLNQoqF3t5HOcregEwF60mNQW574It+tfH7dk3qPnoy7GZtdNaw
	oTj4B3vhjI2LYORxdvm0W5tO8woF3I4IBHZYtKOvRQh0dyZkom2fTlKztJYvnOGvnYb+S5XSW3s
	sdNZ1A2Mq7jhHaOJRQuLztq/ncNLaCg8iCQxSFOLzx0Q0VUKTSPSMhtN1aYNPPm9Xl0aNNd6Z2t
	0+aqXEClSW86L9woqfct+jKPIBa65NkcdQZw7qk3lqv3jGsSwd7TBsaNI8G59L9VBHpQdjI1L/p
	8hFWpgS2GA0/Up69CZNVHckUXgBYIpdjhDQXRB11NBBIgIItOquUT3Pp2BVFywVi8zg+WXNA1hl
	+YUP5G7GEf/ShJOuXvFvt/JYTlwSA==
X-Received: by 2002:a05:6a21:4c13:b0:3e1:7b85:5a95 with SMTP id adf61e73a8af0-3e2260392c3mr310426637.28.1792180902422;
        Fri, 16 Oct 2026 13:01:42 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654850c61sm1688558a12.1.2026.10.16.13.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 13:01:41 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	root@tr0jan.top,
	zihanx@nebusec.ai
Subject: [PATCH net v10 2/3] rxrpc: bound connection and OOB receive queues
Date: Fri, 16 Oct 2026 19:59:52 +0000
Message-ID: <b66a782a7c4180da2048b8d8f4ffcfe7e5877f0e.1792168462.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1792168462.git.zihanx@nebusec.ai>
References: <cover.1792168462.git.zihanx@nebusec.ai>
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
Link: https://lore.kernel.org/all/cover.1791994057.git.zihanx@nebusec.ai/
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v10:
  - Release the retained connection reference when an already-aborted
    connection causes queued CHALLENGE processing to return early.
  - Give queued OOB challenge skbs a dedicated internal skb mark, separate
    from the public OOB type enum.
  - v9 Link: https://lore.kernel.org/all/cover.1791994057.git.zihanx@nebusec.ai/
changes in v9:
  - Split connection/OOB queue budgeting from DATA receive-queue
    budgeting.
  - Add the Fixes attribution for the RXGK challenge OOB path.
  - Order receive-budget helper declarations per netdev reverse-xmas style.
  - v8 Link: https://lore.kernel.org/all/cover.1791428529.git.zihanx@nebusec.ai/
---
 net/rxrpc/ar-internal.h  |  3 +++
 net/rxrpc/conn_event.c   | 29 +++++++++++++++++++++++----
 net/rxrpc/conn_object.c  | 19 +++++++++++++++---
 net/rxrpc/io_thread.c    |  2 ++
 net/rxrpc/local_object.c |  1 +
 net/rxrpc/oob.c          | 20 +++++++++++--------
 net/rxrpc/recvmsg.c      |  4 ++--
 net/rxrpc/skbuff.c       | 43 +++++++++++++++++++++++++++++++++++++++-
 8 files changed, 103 insertions(+), 18 deletions(-)

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
index 611c790bc6d0c..d37cef2523997 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -391,8 +391,17 @@ static void rxrpc_do_process_connection(struct rxrpc_connection *conn)
 	/* go through the conn-level event packets, releasing the ref on this
 	 * connection that each one has when we've finished with it */
 	while ((skb = skb_dequeue(&conn->rx_queue))) {
+		struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 		rxrpc_see_skb(skb, rxrpc_skb_see_conn_work);
 		rxrpc_process_event(conn, skb);
+		if (skb->mark != RXRPC_SKB_MARK_SERVICE_CONN_SECURED)
+			rxrpc_uncharge_async_queue(conn->local, skb);
+		if (sp->hdr.type == RXRPC_PACKET_TYPE_CHALLENGE && sp->chall.conn) {
+			rxrpc_put_connection(
+				sp->chall.conn,
+				rxrpc_conn_put_challenge_input);
+			sp->chall.conn = NULL;
+		}
 		rxrpc_free_skb(skb, rxrpc_skb_put_conn_work);
 	}
 }
@@ -414,15 +423,22 @@ void rxrpc_process_connection(struct work_struct *work)
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
@@ -442,7 +458,10 @@ static bool rxrpc_post_challenge(struct rxrpc_connection *conn,
 		rxrpc_get_connection(conn, rxrpc_conn_get_challenge_input);
 
 	if (!conn->security->challenge_to_recvmsg) {
-		rxrpc_post_packet_to_conn(conn, skb);
+		if (!rxrpc_post_packet_to_conn(conn, skb)) {
+			rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
+			sp->chall.conn = NULL;
+		}
 		return true;
 	}
 
@@ -480,8 +499,10 @@ static bool rxrpc_post_challenge(struct rxrpc_connection *conn,
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
index c80ee2487d094..e3d135b12d22d 100644
--- a/net/rxrpc/oob.c
+++ b/net/rxrpc/oob.c
@@ -46,7 +46,9 @@ bool rxrpc_notify_socket_oob(struct rxrpc_call *call, struct sk_buff *skb)
 		sk = &rx->sk;
 		spin_lock_irq(&rx->recvmsg_lock);
 
-		if (sk->sk_state < RXRPC_CLOSE) {
+		if (sk->sk_state < RXRPC_CLOSE &&
+		    rxrpc_charge_async_queue(sp->chall.conn->local, skb)) {
+			skb->mark = RXRPC_SKB_MARK_CHALLENGE;
 			skb->skb_mstamp_ns = rx->oob_id_counter++;
 			rxrpc_get_skb(skb, rxrpc_skb_get_post_oob);
 			skb_queue_tail(&rx->recvmsg_oobq, skb);
@@ -194,7 +196,7 @@ static int rxrpc_respond_to_oob(struct rxrpc_sock *rx,
 	switch (p->command) {
 	case RXRPC_OOB_CMD_RESPOND:
 		ret = -EPROTO;
-		if (skb->mark != RXRPC_OOB_CHALLENGE)
+		if (skb->mark != RXRPC_SKB_MARK_CHALLENGE)
 			break;
 		conn = sp->chall.conn;
 		ret = -EOPNOTSUPP;
@@ -214,7 +216,8 @@ static int rxrpc_respond_to_oob(struct rxrpc_sock *rx,
 	}
 
 	switch (skb->mark) {
-	case RXRPC_OOB_CHALLENGE:
+	case RXRPC_SKB_MARK_CHALLENGE:
+		rxrpc_uncharge_async_queue(sp->chall.conn->local, skb);
 		rxrpc_put_connection(sp->chall.conn, rxrpc_conn_put_oob);
 		break;
 	}
@@ -275,10 +278,10 @@ enum rxrpc_oob_type rxrpc_kernel_query_oob(struct sk_buff *oob,
 					   unsigned long *_peer_appdata)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(oob);
-	enum rxrpc_oob_type type = oob->mark;
+	enum rxrpc_oob_type type = RXRPC_OOB_CHALLENGE;
 
-	switch (type) {
-	case RXRPC_OOB_CHALLENGE:
+	switch (oob->mark) {
+	case RXRPC_SKB_MARK_CHALLENGE:
 		*_peer		= sp->chall.conn->peer;
 		*_peer_appdata	= sp->chall.conn->peer->app_data;
 		break;
@@ -312,7 +315,7 @@ struct sk_buff *rxrpc_kernel_dequeue_oob(struct socket *sock,
 
 	oob = skb_dequeue(&rx->recvmsg_oobq);
 	if (oob)
-		*_type = oob->mark;
+		*_type = RXRPC_OOB_CHALLENGE;
 	return oob;
 }
 EXPORT_SYMBOL(rxrpc_kernel_dequeue_oob);
@@ -328,7 +331,8 @@ void rxrpc_kernel_free_oob(struct sk_buff *oob)
 	struct rxrpc_skb_priv *sp = rxrpc_skb(oob);
 
 	switch (oob->mark) {
-	case RXRPC_OOB_CHALLENGE:
+	case RXRPC_SKB_MARK_CHALLENGE:
+		rxrpc_uncharge_async_queue(sp->chall.conn->local, oob);
 		rxrpc_put_connection(sp->chall.conn, rxrpc_conn_put_oob);
 		break;
 	}
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index efcba4b2e74f0..172c72944cddd 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -248,8 +248,8 @@ static int rxrpc_recvmsg_oob(struct socket *sock, struct msghdr *msg,
 	if (ret < 0)
 		return ret;
 
-	switch ((enum rxrpc_oob_type)skb->mark) {
-	case RXRPC_OOB_CHALLENGE:
+	switch (skb->mark) {
+	case RXRPC_SKB_MARK_CHALLENGE:
 		need_response = true;
 		ret = rxrpc_recvmsg_challenge(sock, msg, skb, flags);
 		break;
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

