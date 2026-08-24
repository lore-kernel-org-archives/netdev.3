Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB643F6619
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563048; cv=none; b=L6KBocrti5NVR0Ay/kZEzyGLmM1iwRTucAduci+epwNP86AxppuHpWaiCPujbodmtqN8rc1n/pigxl9O3hfmpk/+KNiMy8B/e0YvPOT1k6WXaa5dlkG67BOIX0bH4IJ4gpiOqbic3UcmzIblEq77y0pc/ze+sOwwOMyJQMNcVkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563048; c=relaxed/simple;
	bh=38yMvmaCgmec0kXdTtoUopBBw4FcTlDZZl7EI31fwrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPS1i/RnNs32ITvqy4iTXnsrOCuyJKNfXOZkRBdSy2pwKp/aITJg/Uou7M52INDCIYc9PQB2e/l6nOGsY/YxSVflq4bA+A1Upq1kF1TdtgZF458peeqRjTteRsDAOP4EDQH7I7pq7gU+qrWwgDY++q74FfHkrEzrMHWBIYG5kbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cP9dzwCe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cP9dzwCe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787563042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krVBIugAdVZzo9mKGnPgfVDrDNgE8/gtH6fZE3kNjno=;
	b=cP9dzwCeX+pDbW3E308sMatTEHH1wSjtmt+ZhRxvvKE9gkl6Z3zlqCN5MU4M9HhcDSjt42
	JFo18sc8rDwkBw+eyj7arDWNfm7YFZF8Sbop1fTzfKksrBme6leafRDVVCqPG3KFQ54qtj
	mzaG+Fw2huK2AlHRP4ZrT+zKLmHJbiM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-nLNUV_K6NKunyWQPWlt49A-1; Mon,
 24 Aug 2026 05:17:16 -0400
X-MC-Unique: nLNUV_K6NKunyWQPWlt49A-1
X-Mimecast-MFC-AGG-ID: nLNUV_K6NKunyWQPWlt49A_1787563034
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AB7418417D8;
	Mon, 24 Aug 2026 09:17:14 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.15])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BAC5B180034C;
	Mon, 24 Aug 2026 09:17:10 +0000 (UTC)
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
Subject: [PATCH net v8 04/12] rxrpc: Fix update of call->tx_pending without holding lock
Date: Mon, 24 Aug 2026 10:16:36 +0100
Message-ID: <20260824091645.415423-5-dhowells@redhat.com>
In-Reply-To: <20260824091645.415423-1-dhowells@redhat.com>
References: <20260824091645.415423-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently, rxrpc_send_data() updates call->tx_pending just before it
returns - but it won't be holding the call->lock when it does this if a
wait was interrupted by a signal.  This would allow a parallel sendmsg() to
race.

Further, both the callers of rxrpc_send_data() call it with the lock held,
and then it returns an indication through the parameter list to say whether
it has dropped the lock or not - after which the callers both just drop the
lock if it's still held.

Fix this by:

 (1) Moving the release of call->lock down into rxrpc_send_data() and get
     rid of the indicator parameter.  This makes it easier to see where the
     lock is held.

 (2) After waiting, if the attempt to reacquire the mutex is interrupted,
     just return directly there rather than going to out_unlock

Note that there's a slight change in behaviour in that wait_for_space
failure now doesn't check for completion because it doesn't hold the call
user_mutex.  The caller, however, should re-issue the send and pick up any
error at a second attempt.

Fixes: b0f571ecd794 ("rxrpc: Fix locking in rxrpc's sendmsg")
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
 net/rxrpc/sendmsg.c | 54 +++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 3a36f82b84d9..271562450469 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -320,8 +320,8 @@ static int rxrpc_alloc_txqueue(struct sock *sk, struct rxrpc_call *call)
 static int rxrpc_send_data(struct rxrpc_sock *rx,
 			   struct rxrpc_call *call,
 			   struct msghdr *msg, size_t len,
-			   rxrpc_notify_end_tx_t notify_end_tx,
-			   bool *_dropped_lock)
+			   rxrpc_notify_end_tx_t notify_end_tx)
+	__releases(&call->user_mutex)
 {
 	struct rxrpc_txbuf *txb;
 	struct sock *sk = &rx->sk;
@@ -334,12 +334,12 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 	ret = rxrpc_wait_to_be_connected(call, &timeo);
 	if (ret < 0)
-		return ret;
+		goto out_unlock;
 
 	if (call->conn->state == RXRPC_CONN_CLIENT_UNSECURED) {
 		ret = rxrpc_init_client_conn_security(call->conn);
 		if (ret < 0)
-			return ret;
+			goto out_unlock;
 	}
 
 	/* this should be in poll */
@@ -350,13 +350,15 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
 				  call->cid, call->call_id, call->rx_consumed,
 				  0, -EPROTO);
-		return -EPROTO;
+		ret = -EPROTO;
+		goto out_unlock;
 	}
 	if (unlikely(test_bit(RXRPC_CALL_TX_ERROR, &call->flags))) {
 		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_tx_error,
 				  call->cid, call->call_id, call->rx_consumed,
 				  0, -EIO);
-		return -EIO;
+		ret = -EIO;
+		goto out_unlock;
 	}
 
 	txb = call->tx_pending;
@@ -462,7 +464,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 				if (ret == -ENOMEM)
 					goto maybe_error_rewind;
 				set_bit(RXRPC_CALL_TX_ERROR, &call->flags);
-				goto out;
+				goto out_txb;
 			}
 
 			if (len == 0 && !more)
@@ -474,15 +476,18 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 success:
 	ret = copied;
-out:
+out_txb:
 	call->tx_pending = txb;
+out_unlock:
+	mutex_unlock(&call->user_mutex);
 	_leave(" = %d", ret);
 	return ret;
 
 call_terminated:
 	rxrpc_put_txbuf(txb, rxrpc_txbuf_put_send_aborted);
-	_leave(" = %d", call->error);
-	return call->error;
+	call->tx_pending = NULL;
+	ret = call->error;
+	goto out_unlock;
 
 maybe_error_rewind:
 	/* If we got a retryable error after copying all the supplied data into
@@ -505,36 +510,38 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 		if (rxrpc_call_is_complete(call) &&
 		    call->error < 0) {
 			ret = call->error;
-			goto out;
+			goto out_txb;
 		}
 		goto success;
 	}
-	goto out;
+	goto out_txb;
 
 efault:
 	ret = -EFAULT;
-	goto out;
+	goto out_txb;
 
 wait_for_space:
 	ret = -EAGAIN;
 	if (msg->msg_flags & MSG_DONTWAIT)
 		goto maybe_error;
 	mutex_unlock(&call->user_mutex);
-	*_dropped_lock = true;
+
 	ret = rxrpc_wait_for_tx_window(rx, call, &timeo,
 				       msg->msg_flags & MSG_WAITALL);
 	if (ret < 0)
-		goto maybe_error;
+		goto out_nolock;
 	if (call->interruptibility == RXRPC_INTERRUPTIBLE) {
 		if (mutex_lock_interruptible(&call->user_mutex) < 0) {
 			ret = sock_intr_errno(timeo);
-			goto maybe_error;
+			goto out_nolock;
 		}
 	} else {
 		mutex_lock(&call->user_mutex);
 	}
-	*_dropped_lock = false;
 	goto reload;
+out_nolock:
+	_leave(" = %d [intr]", ret);
+	return copied ?: ret;
 }
 
 /*
@@ -700,7 +707,6 @@ rxrpc_new_client_call_for_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg,
 int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 {
 	struct rxrpc_call *call;
-	bool dropped_lock = false;
 	int ret;
 
 	struct rxrpc_send_params p = {
@@ -809,16 +815,15 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 		ret = 0;
 		break;
 	case RXRPC_CMD_SEND_DATA:
-		ret = rxrpc_send_data(rx, call, msg, len, NULL, &dropped_lock);
-		break;
+		ret = rxrpc_send_data(rx, call, msg, len, NULL);
+		goto error_put;
 	default:
 		ret = -EINVAL;
 		break;
 	}
 
 out_put_unlock:
-	if (!dropped_lock)
-		mutex_unlock(&call->user_mutex);
+	mutex_unlock(&call->user_mutex);
 error_put:
 	rxrpc_put_call(call, rxrpc_call_put_sendmsg);
 	_leave(" = %d", ret);
@@ -855,7 +860,6 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 			   struct msghdr *msg, size_t len,
 			   rxrpc_notify_end_tx_t notify_end_tx)
 {
-	bool dropped_lock = false;
 	int ret;
 
 	_enter("{%d},", call->debug_id);
@@ -866,12 +870,10 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 	mutex_lock(&call->user_mutex);
 
 	ret = rxrpc_send_data(rxrpc_sk(sock->sk), call, msg, len,
-			      notify_end_tx, &dropped_lock);
+			      notify_end_tx);
 	if (ret == -ESHUTDOWN)
 		ret = call->error;
 
-	if (!dropped_lock)
-		mutex_unlock(&call->user_mutex);
 	_leave(" = %d", ret);
 	return ret;
 }

