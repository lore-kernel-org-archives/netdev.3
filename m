Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982E54854FC;
	Wed,  2 Sep 2026 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352245; cv=none; b=dQB4iI8G9hBjQu1lMOK3eavrkhivj5kUS9KVq+AVNP4Ise9NC4TCMVqf011Le+zUcDYYO9uXmW38tC8wHQr948Z8NfWRNA6adfaJLN259jXklGLLETq8R7d+wnCvy+Mrujm0VO5sankUM3055oaUnntpUgN8A1Z3etPTb/XTc9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352245; c=relaxed/simple;
	bh=YKEXwukBletJTUbce8h0JaCI3ZP0fdkibSeN1SJT240=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o+iQzHpvCBg0IXuD4N4AreiIyAW0/5PRqd+DrtyogMakgDvDh+P/INBbjAjEL/8A2Xn3Z8dUvqyigAGJM23h/fKEdqVJ6MTcoDiskScP7HC1rXUAOW5NJ7KMdlFOrHuI2F12hbAXHmoSvCJqT7f4zWczQF/2nDHXmnvkCBpmi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9zysS9w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9zysS9w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C4F1F00A3E;
	Wed,  2 Sep 2026 12:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788352243;
	bh=BoK2T4TxrIBDAwjCqKk2pDJTF++4hSg0bd4NL//DBGc=;
	h=From:To:Subject:Date;
	b=Q9zysS9wwo8hJQAyeBICjWE1VZkwT0Ehapdw77gixRoo9Ih7YyWSwnq2HdOBMjK79
	 TRVkh7pjf0IAG+a9LNtmp8tphjJR3MqAPQ223zAK9yzLcycgJRkkoMHiicJAjdbFJE
	 NlEtWM4MbsTPVkjbl4HyfT5Az3EHGEZAb+nPuuLezGnPbcMwjrhq+Kv7z5a5Wpbema
	 xytZpNkz426lo3zT9lMFfnVREGIKcFTpclYpYNEFCmatnIbP8l1F9EzX/n6qMlNnkC
	 o2WPr1iPIEdCfOfTiP78L5yjyk8JLdhj5N73VuOJ9X8LZ+j/gEOCApTIcLJJdU/zEZ
	 xFCcM1aiEbCjw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	David Heidelberg <david@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Szymon Janc <szymon.janc@tieto.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] nfc: llcp: Fix race condition in accept_queue lifecycle
Date: Wed,  2 Sep 2026 12:30:31 +0000
Message-ID: <20260902123033.1169067-1-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nfc_llcp_socket_release(), sockets and listener accept queues are
walked under the local sockets rwlock and bh_lock_sock().  However,
bh_lock_sock() does not synchronise against process-context lock_sock()
held by nfc_llcp_accept_dequeue() during accept().  Because
socket_release() does not check sock_owned_by_user(), both paths can
concurrently unlink and release the same child socket, resulting in
use-after-free or a NULL pointer dereference of child->parent in
nfc_llcp_accept_unlink().

Fix this synchronisation race by having nfc_llcp_socket_release() use
process-context lock_sock() instead of bh_lock_sock():

1. Pop sockets from the local sockets list under the write lock using
   nfc_llcp_sock_list_pop() so lock_sock() can be acquired without
   holding the rwlock.

2. Because lock_sock() can sleep, defer the final release of the
   nfc_llcp_local structure to a workqueue (release_work).  This avoids
   a sleeping-in-atomic bug when the last local reference is dropped
   from softirq context.  Additionally, hold a single device reference
   on local from registration until final destruction.

3. In nfc_llcp_local_get(), use kref_get_unless_zero() to prevent
   resurrecting a local object whose teardown has been scheduled.

4. In llcp_sock_accept(), verify that the listener socket state is still
   LLCP_LISTEN after waking from schedule_timeout() to prevent hangs if
   the listener is closed concurrently.

5. When unlinking unaccepted child sockets during listener release,
   unlink them from local->sockets, call sock_orphan(), and drop their
   initial sk_alloc creation reference via sock_put().

6. Make nfc_llcp_accept_unlink() idempotent by guarding parent access with
   a NULL check.

Fixes: 50b78b2a6500 ("NFC: Fix sleeping in atomic when releasing socket")
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 -> v2:
- Defer local release to dedicated workqueue (llcp_wq) to avoid sleeping in atomic
- Drain and destroy llcp_wq on module unload to prevent module exit race
- Drop initial sk_alloc creation ref on unaccepted child sockets across all teardown paths
- Use kref_get_unless_zero() in local_get to prevent resurrecting dying local objects
- Check listener socket state after waking in llcp_sock_accept() to avoid hangs
- Standardise Parent (0) -> Child (1) lockdep subclass nesting

v2 -> v3:
- Allocate dedicated workqueue (llcp_wq) with WQ_UNBOUND to fix syzbot warning

 net/nfc/llcp.h      |   1 +
 net/nfc/llcp_core.c | 123 +++++++++++++++++++++++++++-----------------
 net/nfc/llcp_sock.c |  49 +++++++++++++-----
 3 files changed, 115 insertions(+), 58 deletions(-)

diff --git a/net/nfc/llcp.h b/net/nfc/llcp.h
index d8345ed57c95..23ae7a0112d3 100644
--- a/net/nfc/llcp.h
+++ b/net/nfc/llcp.h
@@ -91,6 +91,7 @@ struct nfc_llcp_local {
 	struct hlist_head pending_sdreqs;
 	struct timer_list sdreq_timer;
 	struct work_struct sdreq_timeout_work;
+	struct work_struct release_work;
 	u8 sdreq_next_tid;
 
 	/* sockets array */
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index bd6361e2efa4..23553e7426ec 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -20,6 +20,8 @@ static LIST_HEAD(llcp_devices);
 /* Protects llcp_devices list */
 static DEFINE_SPINLOCK(llcp_devices_lock);
 
+static struct workqueue_struct *llcp_wq;
+
 static void nfc_llcp_rx_skb(struct nfc_llcp_local *local, struct sk_buff *skb);
 
 void nfc_llcp_sock_link(struct llcp_sock_list *l, struct sock *sk)
@@ -63,21 +65,33 @@ static void nfc_llcp_socket_purge(struct nfc_llcp_sock *sock)
 	}
 }
 
+static struct sock *nfc_llcp_sock_list_pop(struct llcp_sock_list *l)
+{
+	struct sock *sk;
+
+	write_lock(&l->lock);
+	sk = sk_head(&l->head);
+	if (sk) {
+		sock_hold(sk);
+		sk_del_node_init(sk);
+	}
+	write_unlock(&l->lock);
+
+	return sk;
+}
+
 static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 				    int err)
 {
 	struct sock *sk;
-	struct hlist_node *tmp;
 	struct nfc_llcp_sock *llcp_sock;
 
 	skb_queue_purge(&local->tx_queue);
 
-	write_lock(&local->sockets.lock);
-
-	sk_for_each_safe(sk, tmp, &local->sockets.head) {
+	while ((sk = nfc_llcp_sock_list_pop(&local->sockets))) {
 		llcp_sock = nfc_llcp_sock(sk);
 
-		bh_lock_sock(sk);
+		lock_sock(sk);
 
 		nfc_llcp_socket_purge(llcp_sock);
 
@@ -91,17 +105,27 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 			list_for_each_entry_safe(lsk, n,
 						 &llcp_sock->accept_queue,
 						 accept_queue) {
+				bool put_creation = false;
+
 				accept_sk = &lsk->sk;
-				bh_lock_sock(accept_sk);
+				lock_sock_nested(accept_sk,
+						 SINGLE_DEPTH_NESTING);
 
-				nfc_llcp_accept_unlink(accept_sk);
+				if (nfc_llcp_sock(accept_sk)->parent == sk) {
+					nfc_llcp_accept_unlink(accept_sk);
+					nfc_llcp_sock_unlink(&local->sockets, accept_sk);
 
-				if (err)
-					accept_sk->sk_err = err;
-				accept_sk->sk_state = LLCP_CLOSED;
-				accept_sk->sk_state_change(sk);
+					if (err)
+						accept_sk->sk_err = err;
+					accept_sk->sk_state = LLCP_CLOSED;
+					accept_sk->sk_state_change(accept_sk);
+					sock_orphan(accept_sk);
+					put_creation = true;
+				}
 
-				bh_unlock_sock(accept_sk);
+				release_sock(accept_sk);
+				if (put_creation)
+					sock_put(accept_sk); /* creation ref */
 			}
 		}
 
@@ -110,23 +134,18 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 		sk->sk_state = LLCP_CLOSED;
 		sk->sk_state_change(sk);
 
-		bh_unlock_sock(sk);
-
-		sk_del_node_init(sk);
+		release_sock(sk);
+		sock_put(sk);
 	}
 
-	write_unlock(&local->sockets.lock);
-
 	/* If we still have a device, we keep the RAW sockets alive */
 	if (device == true)
 		return;
 
-	write_lock(&local->raw_sockets.lock);
-
-	sk_for_each_safe(sk, tmp, &local->raw_sockets.head) {
+	while ((sk = nfc_llcp_sock_list_pop(&local->raw_sockets))) {
 		llcp_sock = nfc_llcp_sock(sk);
 
-		bh_lock_sock(sk);
+		lock_sock(sk);
 
 		nfc_llcp_socket_purge(llcp_sock);
 
@@ -135,26 +154,20 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 		sk->sk_state = LLCP_CLOSED;
 		sk->sk_state_change(sk);
 
-		bh_unlock_sock(sk);
-
-		sk_del_node_init(sk);
+		release_sock(sk);
+		sock_put(sk);
 	}
-
-	write_unlock(&local->raw_sockets.lock);
 }
 
 static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
 {
-	/* Since using nfc_llcp_local may result in usage of nfc_dev, whenever
-	 * we hold a reference to local, we also need to hold a reference to
-	 * the device to avoid UAF.
-	 */
-	if (!nfc_get_device(local->dev->idx))
+	if (!local)
 		return NULL;
 
-	kref_get(&local->ref);
+	if (kref_get_unless_zero(&local->ref))
+		return local;
 
-	return local;
+	return NULL;
 }
 
 static void local_cleanup(struct nfc_llcp_local *local)
@@ -172,30 +185,34 @@ static void local_cleanup(struct nfc_llcp_local *local)
 	nfc_llcp_free_sdp_tlv_list(&local->pending_sdreqs);
 }
 
+static void local_release_work(struct work_struct *work)
+{
+	struct nfc_llcp_local *local;
+	struct nfc_dev *dev;
+
+	local = container_of(work, struct nfc_llcp_local, release_work);
+	dev = local->dev;
+
+	local_cleanup(local);
+	kfree(local);
+	nfc_put_device(dev);
+}
+
 static void local_release(struct kref *ref)
 {
 	struct nfc_llcp_local *local;
 
 	local = container_of(ref, struct nfc_llcp_local, ref);
 
-	local_cleanup(local);
-	kfree(local);
+	queue_work(llcp_wq, &local->release_work);
 }
 
 int nfc_llcp_local_put(struct nfc_llcp_local *local)
 {
-	struct nfc_dev *dev;
-	int ret;
-
-	if (local == NULL)
+	if (!local)
 		return 0;
 
-	dev = local->dev;
-
-	ret = kref_put(&local->ref, local_release);
-	nfc_put_device(dev);
-
-	return ret;
+	return kref_put(&local->ref, local_release);
 }
 
 static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *local,
@@ -1705,6 +1722,7 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
 	INIT_WORK(&local->rx_work, nfc_llcp_rx_work);
 
 	INIT_WORK(&local->timeout_work, nfc_llcp_timeout_work);
+	INIT_WORK(&local->release_work, local_release_work);
 
 	rwlock_init(&local->sockets.lock);
 	rwlock_init(&local->connecting_sockets.lock);
@@ -1748,10 +1766,23 @@ void nfc_llcp_unregister_device(struct nfc_dev *dev)
 
 int __init nfc_llcp_init(void)
 {
-	return nfc_llcp_sock_init();
+	int ret;
+
+	llcp_wq = alloc_workqueue("nfc_llcp_wq", WQ_UNBOUND, 0);
+	if (!llcp_wq)
+		return -ENOMEM;
+
+	ret = nfc_llcp_sock_init();
+	if (ret) {
+		destroy_workqueue(llcp_wq);
+		return ret;
+	}
+
+	return 0;
 }
 
 void nfc_llcp_exit(void)
 {
 	nfc_llcp_sock_exit();
+	destroy_workqueue(llcp_wq);
 }
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 5558d8a4d48b..ce6875eb58fb 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -392,11 +392,12 @@ void nfc_llcp_accept_unlink(struct sock *sk)
 
 	pr_debug("state %d\n", sk->sk_state);
 
-	list_del_init(&llcp_sock->accept_queue);
-	sk_acceptq_removed(llcp_sock->parent);
-	llcp_sock->parent = NULL;
-
-	sock_put(sk);
+	if (llcp_sock->parent) {
+		list_del_init(&llcp_sock->accept_queue);
+		sk_acceptq_removed(llcp_sock->parent);
+		llcp_sock->parent = NULL;
+		sock_put(sk);
+	}
 }
 
 void nfc_llcp_accept_enqueue(struct sock *parent, struct sock *sk)
@@ -423,12 +424,20 @@ struct sock *nfc_llcp_accept_dequeue(struct sock *parent,
 
 	list_for_each_entry_safe(lsk, n, &llcp_parent->accept_queue,
 				 accept_queue) {
+		struct nfc_llcp_local *local;
+
 		sk = &lsk->sk;
-		lock_sock(sk);
+		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 
 		if (sk->sk_state == LLCP_CLOSED) {
-			release_sock(sk);
+			local = nfc_llcp_sock(sk)->local;
+
 			nfc_llcp_accept_unlink(sk);
+			if (local)
+				nfc_llcp_sock_unlink(&local->sockets, sk);
+			sock_orphan(sk);
+			release_sock(sk);
+			sock_put(sk);
 			continue;
 		}
 
@@ -464,7 +473,7 @@ static int llcp_sock_accept(struct socket *sock, struct socket *newsock,
 
 	pr_debug("parent %p\n", sk);
 
-	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+	lock_sock(sk);
 
 	if (sk->sk_state != LLCP_LISTEN) {
 		ret = -EBADFD;
@@ -490,7 +499,12 @@ static int llcp_sock_accept(struct socket *sock, struct socket *newsock,
 
 		release_sock(sk);
 		timeo = schedule_timeout(timeo);
-		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+		lock_sock(sk);
+
+		if (sk->sk_state != LLCP_LISTEN) {
+			ret = -EBADFD;
+			break;
+		}
 	}
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(sk_sleep(sk), &wait);
@@ -629,13 +643,24 @@ static int llcp_sock_release(struct socket *sock)
 
 		list_for_each_entry_safe(lsk, n, &llcp_sock->accept_queue,
 					 accept_queue) {
+			bool put_creation = false;
+
 			accept_sk = &lsk->sk;
-			lock_sock(accept_sk);
+			lock_sock_nested(accept_sk, SINGLE_DEPTH_NESTING);
 
-			nfc_llcp_send_disconnect(lsk);
-			nfc_llcp_accept_unlink(accept_sk);
+			if (nfc_llcp_sock(accept_sk)->parent == sk) {
+				nfc_llcp_send_disconnect(lsk);
+				nfc_llcp_accept_unlink(accept_sk);
+				nfc_llcp_sock_unlink(&local->sockets, accept_sk);
+
+				accept_sk->sk_state = LLCP_CLOSED;
+				sock_orphan(accept_sk);
+				put_creation = true;
+			}
 
 			release_sock(accept_sk);
+			if (put_creation)
+				sock_put(accept_sk); /* creation ref */
 		}
 	}
 
-- 
2.55.0.966.g6673acef38-goog

