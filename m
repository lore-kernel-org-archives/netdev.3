Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D9244DB73
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864425; cv=none; b=fI3IDe19qpHlmTTavadYbIY9S7nzFfeNr/JdEV2k3XtUCcyAkWb0l5Akddrndr5G+nc/L7CqAHzJbEr8BCXALLDap3C/1RiHzfvfmbvOjXUj+XycsMG5JYZGLr20sHNAyuoOwIYJm5DJDL6228lAM/zN4z8OJBOlRZpem7erJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864425; c=relaxed/simple;
	bh=cqy2g94XZBX9G7YrkwcJjxw9K2n4YchLbqNslZ1SIeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFvmBHJ2d4ND88/HVyXE+Zifg/2dx6JHQutFQlraKt4HdbvQe6cwrl5KF5hVva4IJ+s7pMh5ezZEgnsa3njSzdaIANZV72lh7hSrLDTIF7ZdZrN4/UKz2XuOJHzCflLd2IFQ51JzvicFOHNE+GwFPW2oD3o6JhyeQOBasALrLx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ngf67DKI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ngf67DKI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785864422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=retShh/rB2y4b8pbkyMobCsIfF4njhz1xD4LfU/+mpM=;
	b=Ngf67DKIVPQ7YwKnwBonJ7ofrjVZwx0Yv0XxQXWXsu2Yw3pw0zWLqjC+7lfFeFXEk2eF6m
	94X18XpFokgGUL9nYJj970tEvuB+fN2PNAWncf8EYli+vm5YZYXoLAYmI4PdU4yZ5cP7Vt
	77tRWqV/RHCbqI3iS/5M48DNqMkUO2E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-HUkj6BBXOXiujZhflO2mGw-1; Tue,
 04 Aug 2026 13:26:57 -0400
X-MC-Unique: HUkj6BBXOXiujZhflO2mGw-1
X-Mimecast-MFC-AGG-ID: HUkj6BBXOXiujZhflO2mGw_1785864416
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7DE21800620;
	Tue,  4 Aug 2026 17:26:55 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.44])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A3B9B414;
	Tue,  4 Aug 2026 17:26:52 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH net v6 02/10] rxrpc: Fix packet encryption error handling
Date: Tue,  4 Aug 2026 18:26:29 +0100
Message-ID: <20260804172639.2844491-3-dhowells@redhat.com>
In-Reply-To: <20260804172639.2844491-1-dhowells@redhat.com>
References: <20260804172639.2844491-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

In rxrpc_send_data(), if ->secure_packet() returns an error, the code
currently just jumps to out: and returns the error to the app on the
assumption that any error returned by this is automatically fatal for the
call, and may even have corrupted the transmission queue - but leaving it
to userspace to deal with.  Nothing stops the application from retrying the
sendmsg(), which will try to encrypt the buffer again, and might succeed
with a corrupt buffer.

Fix rxrpc_send_data() in the following ways:

 (1) If -ENOMEM is returned, assume we never got as far as the encryption
     and that the operation is retryable.  In which case, jump to
     maybe_error_rewind and, if we've copied data into the last packet,
     remove a byte from it so that we don't tell the caller that we've
     completed the transmission phase.

 (2) If any other error occurs, set the TX_ERROR flag on the call and
     return that error directly; on all subsequent attempts to add data to
     the call, return -EIO.  The app must then abort the call to get rid of
     it (this allows the app to choose the abort code to use).

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Closes: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 fs/afs/rxrpc.c               | 22 +++++++++------
 include/trace/events/rxrpc.h |  1 +
 net/rxrpc/ar-internal.h      |  1 +
 net/rxrpc/sendmsg.c          | 53 ++++++++++++++++++++++++++++--------
 4 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index d82916657a3d..b435f4b2da7f 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -412,21 +412,25 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	msg.msg_controllen	= 0;
 	msg.msg_flags		= MSG_WAITALL | (call->write_iter ? MSG_MORE : 0);
 
-	ret = rxrpc_kernel_send_data(call->net->socket, rxcall,
-				     &msg, call->request_size,
-				     afs_notify_end_request_tx);
-	if (ret < 0)
-		goto error_do_abort;
+	do {
+		ret = rxrpc_kernel_send_data(call->net->socket, rxcall,
+					     &msg, call->request_size,
+					     afs_notify_end_request_tx);
+		if (ret < 0)
+			goto error_do_abort;
+	} while (iov_iter_count(&msg.msg_iter) > 0);
 
 	if (call->write_iter) {
 		msg.msg_iter = *call->write_iter;
 		msg.msg_flags &= ~MSG_MORE;
 		trace_afs_send_data(call, &msg);
 
-		ret = rxrpc_kernel_send_data(call->net->socket,
-					     call->rxcall, &msg,
-					     iov_iter_count(&msg.msg_iter),
-					     afs_notify_end_request_tx);
+		do {
+			ret = rxrpc_kernel_send_data(call->net->socket,
+						     call->rxcall, &msg,
+						     iov_iter_count(&msg.msg_iter),
+						     afs_notify_end_request_tx);
+		} while (iov_iter_count(&msg.msg_iter) > 0);
 		*call->write_iter = msg.msg_iter;
 
 		trace_afs_sent_data(call, &msg, ret);
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 704a10de6670..8f3e3967885a 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -148,6 +148,7 @@
 	EM(rxrpc_eproto_wrong_security,		"wrong-sec")		\
 	EM(rxrpc_recvmsg_excess_data,		"recvmsg-excess")	\
 	EM(rxrpc_recvmsg_short_data,		"recvmsg-short")	\
+	EM(rxrpc_sendmsg_tx_error,		"tx-error")		\
 	E_(rxrpc_sendmsg_late_send,		"sendmsg-late")
 
 #define rxrpc_call_poke_traces \
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 865f05fe37ab..a6f830c1621f 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -642,6 +642,7 @@ enum rxrpc_call_flag {
 	RXRPC_CALL_TX_LAST,		/* Last packet in Tx buffer (at rxtx_top) */
 	RXRPC_CALL_TX_ALL_ACKED,	/* Last packet has been hard-acked */
 	RXRPC_CALL_TX_NO_MORE,		/* No more data to transmit (MSG_MORE deasserted) */
+	RXRPC_CALL_TX_ERROR,		/* Terminal error; call needs abort */
 	RXRPC_CALL_SEND_PING,		/* A ping will need to be sent */
 	RXRPC_CALL_RETRANS_TIMEOUT,	/* Retransmission due to timeout occurred */
 	RXRPC_CALL_BEGAN_RX_TIMER,	/* We began the expect_rx_by timer */
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 4c754f78ece9..5ea10dc497a7 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -330,13 +330,6 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	bool more = msg->msg_flags & MSG_MORE;
 	int ret, copied = 0;
 
-	if (test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags)) {
-		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
-				  call->cid, call->call_id, call->rx_consumed,
-				  0, -EPROTO);
-		return -EPROTO;
-	}
-
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
 	ret = rxrpc_wait_to_be_connected(call, &timeo);
@@ -353,6 +346,19 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 
 reload:
+	if (unlikely(test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags))) {
+		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
+				  call->cid, call->call_id, call->rx_consumed,
+				  0, -EPROTO);
+		return -EPROTO;
+	}
+	if (unlikely(test_bit(RXRPC_CALL_TX_ERROR, &call->flags))) {
+		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_tx_error,
+				  call->cid, call->call_id, call->rx_consumed,
+				  0, -EIO);
+		return -EIO;
+	}
+
 	txb = call->tx_pending;
 	call->tx_pending = NULL;
 	if (txb)
@@ -440,12 +446,21 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 		/* add the packet to the send queue if it's now full */
 		if (!txb->space ||
 		    (msg_data_left(msg) == 0 && !more)) {
-			if (msg_data_left(msg) == 0 && !more)
-				txb->flags |= RXRPC_LAST_PACKET;
-
+			/* Do any required crypto.  If this fails, it could
+			 * have corrupted the txbuf content with a partial
+			 * encrypt.  Assume that ENOMEM is retryable, but
+			 * everything else is terminal.
+			 */
 			ret = call->security->secure_packet(call, txb);
-			if (ret < 0)
+			if (ret < 0) {
+				if (ret == -ENOMEM)
+					goto maybe_error_rewind;
+				set_bit(RXRPC_CALL_TX_ERROR, &call->flags);
 				goto out;
+			}
+
+			if (msg_data_left(msg) == 0 && !more)
+				txb->flags |= RXRPC_LAST_PACKET;
 			rxrpc_queue_packet(rx, call, txb, notify_end_tx);
 			txb = NULL;
 		}
@@ -463,6 +478,22 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	_leave(" = %d", call->error);
 	return call->error;
 
+maybe_error_rewind:
+	/* If we got a retryable error after copying all the supplied data into
+	 * the last packet, we need to rewind as much as we can so the caller
+	 * knows they need to retry the sendmsg.
+	 */
+	if (copied && !more && !msg_data_left(msg)) {
+		unsigned int rewind_by = umin(copied, txb->len);
+
+		txb->space  += rewind_by;
+		txb->len    -= rewind_by;
+		txb->offset -= rewind_by;
+		copied      -= rewind_by;
+		if (call->tx_total_len != -1)
+			call->tx_total_len += rewind_by;
+		iov_iter_revert(&msg->msg_iter, rewind_by);
+	}
 maybe_error:
 	if (copied) {
 		if (rxrpc_call_is_complete(call) &&

