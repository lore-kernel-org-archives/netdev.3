Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D4D3AAF7D
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340904; cv=none; b=sQEtjDsiLYyKeK9yiGYZqnePQ2vS+VIN2g1jn88Wyfw4gMg0kDDq4R6m07rbNQbx3Bpji7ZcFtPY7Wdzt++wdMOxCICIr/WqeLTmJUmrP30AhLuXUVVjE36oeiqWhq2FQeeJ6yGF3YID8cENG/FrRAPVJPSRbhxo8jWdKJmmHQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340904; c=relaxed/simple;
	bh=LLqegErpiwnNJz+6QEiPVr0B0jHHttmhiT2gIzb7tbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAHxpSIGja6+Jr7mOwaOXfK4CNvnCYG0klGfNWY4QsBGV5NQzLLQtzQcbXfU77TE6772apDG3476Y1zm7MVP9IVimEc9zd2YfbhAoEAq1vQCmxII3g6QW2TgbGUz3xzWQ0DYCAzN3365sgSMinHKyxruJg4TzCFmKXlS8SWNuxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7+ZrFYB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7+ZrFYB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785340902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0U90slAaEmIBgfeuUR2Wm/d5X06U5sN8cTBSeFBj2M=;
	b=N7+ZrFYBrxQUjh1AEetXMO7Pl6BriK5ibQGKT06a2Dzn1hybzyR58JJpzrCp1/qcIce2Wd
	E/uXrNYUSd+uhgkaUdrpsXmvRq2DJqGJvfntx2+Iz697Al8Z35vIctvgrkRNmhiHcmtH+F
	ufqwqFnFPKxlxyyE7QRqoMCAyzCJ3tA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-wXrLD-_0OI2UG-nf-lyFbQ-1; Wed,
 29 Jul 2026 12:01:38 -0400
X-MC-Unique: wXrLD-_0OI2UG-nf-lyFbQ-1
X-Mimecast-MFC-AGG-ID: wXrLD-_0OI2UG-nf-lyFbQ_1785340896
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37C0E18002A8;
	Wed, 29 Jul 2026 16:01:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E42D9180034E;
	Wed, 29 Jul 2026 16:01:32 +0000 (UTC)
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
Subject: [PATCH net v5 04/10] rxrpc: Fix generation of notifications after call completion
Date: Wed, 29 Jul 2026 17:01:01 +0100
Message-ID: <20260729160108.2031453-5-dhowells@redhat.com>
In-Reply-To: <20260729160108.2031453-1-dhowells@redhat.com>
References: <20260729160108.2031453-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
 net/rxrpc/call_state.c       | 57 +++++++++++++++++++++++++++++++++++-
 net/rxrpc/recvmsg.c          | 42 +++++++++-----------------
 3 files changed, 71 insertions(+), 29 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 8f3e3967885a..d7c7b04d69fc 100644
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
diff --git a/net/rxrpc/call_state.c b/net/rxrpc/call_state.c
index 6afb54373ebb..6e402312e145 100644
--- a/net/rxrpc/call_state.c
+++ b/net/rxrpc/call_state.c
@@ -7,6 +7,61 @@
 
 #include "ar-internal.h"
 
+/*
+ * Post a call for attention by the socket or kernel service.  Further
+ * notifications are suppressed by putting recvmsg_link on a dummy queue.
+ */
+static void __rxrpc_notify_socket(struct rxrpc_call *call)
+{
+	struct rxrpc_sock *rx;
+	struct sock *sk;
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
+			spin_lock_irq(&call->notify_lock);
+			call->notify_rx(sk, call, call->user_call_ID);
+			spin_unlock_irq(&call->notify_lock);
+		} else {
+			spin_lock_irq(&rx->recvmsg_lock);
+			if (list_empty(&call->recvmsg_link)) {
+				rxrpc_get_call(call, rxrpc_call_get_notify_socket);
+				list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
+			}
+			spin_unlock_irq(&rx->recvmsg_lock);
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
+ * Post a call for attention by the socket or kernel service.  Further
+ * notifications are suppressed by putting recvmsg_link on a dummy queue.
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
@@ -25,7 +80,7 @@ bool rxrpc_set_call_completion(struct rxrpc_call *call,
 	rxrpc_set_call_state(call, RXRPC_CALL_COMPLETE);
 	trace_rxrpc_call_complete(call);
 	wake_up(&call->waitq);
-	rxrpc_notify_socket(call);
+	__rxrpc_notify_socket(call);
 	return true;
 }
 
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index efcba4b2e74f..28b2148b5693 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -17,13 +17,12 @@
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
+	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
+	struct sock *sk = &rx->sk;
 
 	_enter("%d", call->debug_id);
 
@@ -32,31 +31,18 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
 		return;
 	}
 
-	rcu_read_lock();
-
-	rx = rcu_dereference(call->socket);
-	sk = &rx->sk;
-	if (rx && sk->sk_state < RXRPC_CLOSE) {
-		if (call->notify_rx) {
-			spin_lock_irq(&call->notify_lock);
-			call->notify_rx(sk, call, call->user_call_ID);
-			spin_unlock_irq(&call->notify_lock);
-		} else {
-			spin_lock_irq(&rx->recvmsg_lock);
-			if (list_empty(&call->recvmsg_link)) {
-				rxrpc_get_call(call, rxrpc_call_get_notify_socket);
-				list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
-			}
-			spin_unlock_irq(&rx->recvmsg_lock);
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
 
@@ -561,7 +547,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	if (!(flags & MSG_PEEK) &&
 	    !skb_queue_empty(&call->recvmsg_queue))
-		rxrpc_notify_socket(call);
+		rxrpc_requeue_call(sock, call);
 	goto not_yet_complete;
 
 call_failed:

