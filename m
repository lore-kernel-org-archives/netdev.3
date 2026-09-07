Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F6B47DD58
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781125; cv=none; b=SSWSx+0McXiQyJ1ldC8uGZssJX1F9Dq7tuYFczxJKXpU5MNGMvuZFd3uzRv4Z97iWZgSggCpH2/eWe0gQxt4iFMnMjmBkIcLFHoJ/QE9iUvP4y6pjFEMwfDzuLZfNoSnbJtpanRm5gdTtnBVfx1Hj13jtJpy6Sn8W6Wffwd9J5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781125; c=relaxed/simple;
	bh=TsDMA/MeL7R3gT7mdT45KJCnSy+kE9/LlWl5Rkg5/7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pq3u2OSeAdMLibuBjnXn7+a/cGO6gj4GoZoRC/1KOk6RHTEZGUftUvopRYoTxIZvefk5bGjrgwEGR8zhZR2St4wvCVghAWNh4IFMnxLVrjllLn64pOcW1QBuXXwGFqo7rSHTIvMLncyfZ0+LrzfjpFibPDXn283xjv8xS6Rb3Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6R0CaYL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6R0CaYL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788781122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUKRZg5p5RLsQwLnENs9+U5uoPXN8+g4eiTJcd+gods=;
	b=T6R0CaYLzVlNJALt3MTBHaKbtv31NihJC7R3oUbmBQAQtyX7ra8cIlDJHy67wPE+F0axlf
	2W030INHUq/3/CTituG9ZJpgvI44zry8HjngvMLG//znVE6BJ+QnAcI2om7YPuzOokxwzw
	b+lbD7sOaJgcwGts0r0LjsuM+T5xWUw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-9jh6N_ZpPKyasRKm6KeU3g-1; Mon,
 07 Sep 2026 07:38:39 -0400
X-MC-Unique: 9jh6N_ZpPKyasRKm6KeU3g-1
X-Mimecast-MFC-AGG-ID: 9jh6N_ZpPKyasRKm6KeU3g_1788781117
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 468DB1954B3F;
	Mon,  7 Sep 2026 11:38:37 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.158])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AADC1800348;
	Mon,  7 Sep 2026 11:38:33 +0000 (UTC)
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
Subject: [PATCH net v9 09/14] rxrpc: Fix generation of notifications after call completion
Date: Mon,  7 Sep 2026 12:37:36 +0100
Message-ID: <20260907113743.1453210-10-dhowells@redhat.com>
In-Reply-To: <20260907113743.1453210-1-dhowells@redhat.com>
References: <20260907113743.1453210-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

AF_RXRPC may generate a notification to the application after a call has
completed because it generates one notification when
rxrpc_input_split_jumbo() queues the final packet and completes the call
and then generates another when rxrpc_input_split_jumbo() does the
aggregated data receive notification at the end of the function.

This might cause the AFS filesystem to malfunction because it tries to
queue the afs_call for processing an extra time.  Most of the time this
happens quickly enough that the second queue_work skips, but sometimes this
means that the call work may happen a second time with implications for
afs_call lifetime management.

Fix this by:

 (1) Create a lighter version of rxrpc_notify_socket() that's just used to
     requeue a call for rxrpc_recvmsg() without creating another
     notification.

 (2) Move rxrpc_notify_socket() to call_state.c and rename it to
     __rxrpc_notify_socket().

 (3) Create a wrapper called rxrpc_notify_socket() that skips the
     notification if a call is completed.

 (4) Make rxrpc_set_call_completion() call __rxrpc_notify_socket() to avoid
     the skip-if-completed check.

Also remove the comment on rxrpc_notify_socket() that said it added the
call to a dummy queue to prevent further notification.

Fixes: 2d1faf7a0ca3 ("rxrpc: Simplify skbuff accounting in receive path")
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
 include/trace/events/rxrpc.h |  1 +
 net/rxrpc/ar-internal.h      |  2 +-
 net/rxrpc/call_state.c       | 56 +++++++++++++++++++++++++++++++++++-
 net/rxrpc/recvmsg.c          | 43 +++++++++------------------
 4 files changed, 71 insertions(+), 31 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index a5c92592d8f9..52f8718cf725 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -343,6 +343,7 @@
 	EM(rxrpc_call_see_distribute_error,	"SEE dist-err") \
 	EM(rxrpc_call_see_input,		"SEE input   ") \
 	EM(rxrpc_call_see_notify_released,	"SEE nfy-rlsd") \
+	EM(rxrpc_call_see_notify_skipped,	"SEE nfy-skip") \
 	EM(rxrpc_call_see_recvmsg,		"SEE recvmsg ") \
 	EM(rxrpc_call_see_recvmsg_requeue,	"SEE recv-rqu") \
 	EM(rxrpc_call_see_recvmsg_requeue_first, "SEE recv-rqF") \
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index a6f830c1621f..cb36a709f540 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1110,6 +1110,7 @@ static inline bool rxrpc_is_client_call(const struct rxrpc_call *call)
 /*
  * call_state.c
  */
+void rxrpc_notify_socket(struct rxrpc_call *call);
 bool rxrpc_set_call_completion(struct rxrpc_call *call,
 			       enum rxrpc_call_completion compl,
 			       u32 abort_code,
@@ -1442,7 +1443,6 @@ extern const struct seq_operations rxrpc_local_seq_ops;
 /*
  * recvmsg.c
  */
-void rxrpc_notify_socket(struct rxrpc_call *);
 int rxrpc_recvmsg(struct socket *, struct msghdr *, size_t, int);
 
 /*
diff --git a/net/rxrpc/call_state.c b/net/rxrpc/call_state.c
index 6afb54373ebb..364810c65276 100644
--- a/net/rxrpc/call_state.c
+++ b/net/rxrpc/call_state.c
@@ -7,6 +7,60 @@
 
 #include "ar-internal.h"
 
+/*
+ * Post a call for attention by the socket or kernel service.
+ */
+static void __rxrpc_notify_socket(struct rxrpc_call *call)
+{
+	struct rxrpc_sock *rx;
+	struct sock *sk;
+	unsigned long flags;
+
+	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
+		rxrpc_see_call(call, rxrpc_call_see_notify_released);
+		return;
+	}
+
+	rcu_read_lock();
+
+	rx = rcu_dereference(call->socket);
+	sk = &rx->sk;
+	if (rx && sk->sk_state < RXRPC_CLOSE) {
+		if (call->notify_rx) {
+			spin_lock_irqsave(&call->notify_lock, flags);
+			call->notify_rx(sk, call, call->user_call_ID);
+			spin_unlock_irqrestore(&call->notify_lock, flags);
+		} else {
+			spin_lock_irqsave(&rx->recvmsg_lock, flags);
+			if (list_empty(&call->recvmsg_link)) {
+				rxrpc_get_call(call, rxrpc_call_get_notify_socket);
+				list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
+			}
+			spin_unlock_irqrestore(&rx->recvmsg_lock, flags);
+
+			if (!sock_flag(sk, SOCK_DEAD)) {
+				_debug("call %ps", sk->sk_data_ready);
+				sk->sk_data_ready(sk);
+			}
+		}
+	}
+
+	rcu_read_unlock();
+}
+
+/*
+ * Post a call for attention by the socket or kernel service.
+ */
+void rxrpc_notify_socket(struct rxrpc_call *call)
+{
+	if (rxrpc_call_is_complete(call)) {
+		rxrpc_see_call(call, rxrpc_call_see_notify_skipped);
+		return;
+	}
+
+	__rxrpc_notify_socket(call);
+}
+
 /*
  * Transition a call to the complete state.
  */
@@ -25,7 +79,7 @@ bool rxrpc_set_call_completion(struct rxrpc_call *call,
 	rxrpc_set_call_state(call, RXRPC_CALL_COMPLETE);
 	trace_rxrpc_call_complete(call);
 	wake_up(&call->waitq);
-	rxrpc_notify_socket(call);
+	__rxrpc_notify_socket(call);
 	return true;
 }
 
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 56fa324d0962..28b2148b5693 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -17,14 +17,12 @@
 #include "ar-internal.h"
 
 /*
- * Post a call for attention by the socket or kernel service.  Further
- * notifications are suppressed by putting recvmsg_link on a dummy queue.
+ * Requeue a call for recvmsg() to pick up.
  */
-void rxrpc_notify_socket(struct rxrpc_call *call)
+static void rxrpc_requeue_call(struct socket *sock, struct rxrpc_call *call)
 {
-	struct rxrpc_sock *rx;
-	struct sock *sk;
-	unsigned long flags;
+	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
+	struct sock *sk = &rx->sk;
 
 	_enter("%d", call->debug_id);
 
@@ -33,31 +31,18 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
 		return;
 	}
 
-	rcu_read_lock();
-
-	rx = rcu_dereference(call->socket);
-	sk = &rx->sk;
-	if (rx && sk->sk_state < RXRPC_CLOSE) {
-		if (call->notify_rx) {
-			spin_lock_irqsave(&call->notify_lock, flags);
-			call->notify_rx(sk, call, call->user_call_ID);
-			spin_unlock_irqrestore(&call->notify_lock, flags);
-		} else {
-			spin_lock_irqsave(&rx->recvmsg_lock, flags);
-			if (list_empty(&call->recvmsg_link)) {
-				rxrpc_get_call(call, rxrpc_call_get_notify_socket);
-				list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
-			}
-			spin_unlock_irqrestore(&rx->recvmsg_lock, flags);
+	spin_lock_irq(&rx->recvmsg_lock);
+	if (list_empty(&call->recvmsg_link)) {
+		rxrpc_get_call(call, rxrpc_call_get_notify_socket);
+		list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
+	}
+	spin_unlock_irq(&rx->recvmsg_lock);
 
-			if (!sock_flag(sk, SOCK_DEAD)) {
-				_debug("call %ps", sk->sk_data_ready);
-				sk->sk_data_ready(sk);
-			}
-		}
+	if (!sock_flag(sk, SOCK_DEAD)) {
+		_debug("call %ps", sk->sk_data_ready);
+		sk->sk_data_ready(sk);
 	}
 
-	rcu_read_unlock();
 	_leave("");
 }
 
@@ -562,7 +547,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	if (!(flags & MSG_PEEK) &&
 	    !skb_queue_empty(&call->recvmsg_queue))
-		rxrpc_notify_socket(call);
+		rxrpc_requeue_call(sock, call);
 	goto not_yet_complete;
 
 call_failed:

