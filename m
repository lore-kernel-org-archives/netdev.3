Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F73EC80B
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427150; cv=none; b=QUg6esJNnaIQRLBSZeCepy0TmDY4VNiQV8jGj5tIUvbwmenp8KBkPyIsnyM3TQtUXgYbjDxIUHNl1fFSBeauaYbOLdpcoPp0sRwcugJeL1jGuXkKadyFDd1C0oHmMflhxvYhfP6bbp5flf5DAAk8P+BRgyI9+TvLYTst8d7Ltgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427150; c=relaxed/simple;
	bh=BMJPW7nI/5l7B4HR0eMv7Uz8NqOcmFL250zG4Z/sh3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3GT/jFtZeJKKclCVB8ScB54Qy0t/PXdfLiQt/WKBfcblkLSnfqZRBPcVoVeBOJsap1hf0An6PccqkCv1ohWhQQST3ycArN9RlEIsOgbu7ssUgWMSV3i67kRGrgpq0ZRKY653sRHque44rnkrkXHAo9H/J3tPOI7bA0N0WdP/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=glyvhW9F; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="glyvhW9F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OgurYWBzltDlj2nJWICwbJhmHiQ0lgiwCmPlSRaRz/k=; t=1789427146; x=1790291146; 
	b=glyvhW9Fe4VmQ6Ai1pPrJqOEKPaVaKxKEUngeZg2zZN4YfXqwA7LNaPTRAxbzhAq0Jc9WsKlf+b
	QOy4/ekl4zT7srBvhlWzakD/PfnJMIcKJ4dBqQtL/P31NSZ6bN4YRqTxrVhEYv0KKKYXUp11TD0xJ
	/XtcwcGOzP0dRxOUCJ3+fs5HwrYULjvCu9fEZ4ZwbUNmirmv8QzIvcUS1wVLomyPd9/c64XI6TeV7
	wHXXR7YHHpdulfMZhJxZQ2rQwquxwRC+tdz/4RopBa3qYOo5gPP6lMflVnC3UO4Dgelt+Zu4FnyIt
	+42sY/onWpxCo7wY03yE7BnwDaYW6e5WU4VA==;
Received: from ouster448.stanford.edu ([172.24.72.71]:60752 helo=cs.stanford.edu)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1x6Fk6-0007WN-Pf; Mon, 14 Sep 2026 16:05:46 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	skhan@linuxfoundation.org,
	bagasdotme@gmail.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v11 09/15] net: homa: create homa_rpc.h and homa_rpc.c
Date: Mon, 14 Sep 2026 16:05:09 -0700
Message-ID: <20260914230517.1190-10-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260914230517.1190-1-ouster@cs.stanford.edu>
References: <20260914230517.1190-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -97.4
X-Scan-Signature: 12f32041872b7c69aae81e3002125079

These files provide basic functions for managing remote procedure calls,
which are the fundamental entities managed by Homa. Each RPC consists
of a request message from a client to a server, followed by a response
message returned from the server to the client.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v20:
* Separate routing information (flows and dst_entry's) from the homa_peer
  struct: there can be multiple routes to a single peer.
* Refactor outbound message management:
  * Outbound message data is now buffered in kernel pages that are
    independent of skbs; skbs are then created "just in time" that
    share access to those pages.
  * This eliminates the need for Homa to retain references to skb's
    after they have been passed to ip*xmit.
* Add cgroup memory accounting (__GFP_ACCOUNT).
* Don't hold locks while transmitting packets.
* Check for NULL buffer_pool in homa_rpc_reap; also, don't hold socket
  lock while freeing rx skbs.
* Extract homa_rpc_collect_skbs from homa_rpc_reap (cleaner, reduces
  indentation in homa_rpc_reap).
* Refactor homa_rpc_acked into homa_rpc_ack (encapsulates lock management
  and iterating over multiple acks).

Changes for v19:
* Use new cleanup homa_pool cleanup functions.
* Fix bugs that could occur if homa_rpc_alloc_server encountered errors

Changes for v16:
* Retain retransmitted packets until homa_rpc_reap (to ensure that RPCs
  don't get reaped with retransmitted packets still in the tx pipeline)
* Fix deadlock over hsk->protect_count in homa_rpc_reap
* Fix bugs in wmem management
* Use set_bit and clear_bit for flag bits
* Use refcount_t instead of atomic_t for reference counts
* Replace inline code with homa_rpc_lock_preempt function
* Reduce stack usage in homa_rpc_reap
* Use consume_skb and kfree_skb_reason instead of kfree_skb
* Add homa_rpc_get_info() for use in HOMAIOCINFO
* Set hsk->error_msg

Changes for v14:
* Add msgout.first_not_tx field needed by homa_rpc_tx_end function
  (better abstraction)

Changes for v11:
* Cleanup and simplify use of RPC reference counts.
* Rework the mechanism for waking up RPCs that stalled waiting for
  buffer pool space.

Changes for v10:
* Replace __u16 with u16, __u8 with u8, etc.
* Improve documentation
* Revise sparse annotations to eliminate __context__ definition
* Use kzalloc instead of __GFP_ZERO
* Fix issues from xmastree, sparse, etc.

Changes for v9:
* Eliminate reap.txt; move its contents into code as a comment
  in homa_rpc_reap
* Various name improvements (e.g. use "alloc" instead of "new" for functions
  that allocate memory)
* Add support for homa_net objects
* Use new homa_clock abstraction layer

Changes for v8:
* Updates to reflect pacer refactoring

Changes for v7:
* Implement accounting for bytes in tx skbs
* Fix potential races related to homa->active_rpcs
* Refactor waiting mechanism for incoming packets: simplify wait
  criteria and use standard Linux mechanisms for waiting
* Add reference counting for RPCs (homa_rpc_hold, homa_rpc_put)
* Remove locker argument from locking functions
* Rename homa_rpc_free to homa_rpc_end
* Use u64 and __u64 properly
* Use __skb_queue_purge instead of skb_queue_purge
* Use __GFP_ZERO in kmalloc calls
* Eliminate spurious RCU usage
---
 net/homa/homa_impl.h |   7 +
 net/homa/homa_rpc.c  | 735 +++++++++++++++++++++++++++++++++++++++++++
 net/homa/homa_rpc.h  | 545 ++++++++++++++++++++++++++++++++
 3 files changed, 1287 insertions(+)
 create mode 100644 net/homa/homa_rpc.c
 create mode 100644 net/homa/homa_rpc.h

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
index d365748dc5ba..7c87d517aae7 100644
--- a/net/homa/homa_impl.h
+++ b/net/homa/homa_impl.h
@@ -363,6 +363,13 @@ static inline bool homa_make_header_avl(struct sk_buff *skb)
 
 extern unsigned int homa_net_id;
 
+void     homa_rpc_handoff(struct homa_rpc *rpc);
+int      homa_xmit_control(enum homa_packet_type type, void *contents,
+			   size_t length, struct homa_rpc *rpc);
+void     homa_xmit_data(struct homa_rpc *rpc);
+
+int      homa_message_in_init(struct homa_rpc *rpc, int length);
+
 /**
  * homa_net() - Return the struct homa_net associated with a particular
  * struct net.
diff --git a/net/homa/homa_rpc.c b/net/homa/homa_rpc.c
new file mode 100644
index 000000000000..3c94489641c2
--- /dev/null
+++ b/net/homa/homa_rpc.c
@@ -0,0 +1,735 @@
+// SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0+
+
+/* This file contains functions for managing homa_rpc structs. */
+
+#include "homa_impl.h"
+#include "homa_interest.h"
+#include "homa_peer.h"
+#include "homa_pool.h"
+#include "homa_tx_pool.h"
+
+/**
+ * homa_rpc_alloc_client() - Allocate and initialize a client RPC (one that
+ * is used to issue an outgoing request). Doesn't send any packets. Invoked
+ * with no locks held.
+ * @hsk:      Socket to which the RPC belongs.
+ * @dest:     Address of host (ip and port) to which the RPC will be sent.
+ *
+ * Return:    A pointer to the newly allocated object, or a negative
+ *            errno if an error occurred. The RPC will be locked; the
+ *            caller must eventually unlock it. Sets hsk->error_msg on errors.
+ */
+struct homa_rpc *homa_rpc_alloc_client(struct homa_sock *hsk,
+				       const union sockaddr_in_union *dest)
+	__cond_acquires(nonnull, crpc->bucket->lock)
+{
+	struct in6_addr dest_addr_as_ipv6 = canonical_ipv6_addr(dest);
+	struct homa_rpc_bucket *bucket;
+	struct homa_rpc *crpc;
+	int err;
+
+	crpc = kzalloc_obj(*crpc, GFP_KERNEL_ACCOUNT);
+	if (unlikely(!crpc)) {
+		hsk->error_msg = "couldn't allocate memory for client RPC";
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Initialize fields that don't require the socket lock. */
+	crpc->hsk = hsk;
+	crpc->id = atomic64_fetch_add(2, &hsk->homa->next_outgoing_id);
+	bucket = homa_client_rpc_bucket(hsk, crpc->id);
+	crpc->bucket = bucket;
+	crpc->state = RPC_OUTGOING;
+	refcount_set(&crpc->refs, 1);
+	crpc->route = homa_route_get(hsk, &dest_addr_as_ipv6);
+	if (IS_ERR(crpc->route)) {
+		err = PTR_ERR(crpc->route);
+		crpc->route = NULL;
+		goto error;
+	}
+	crpc->dport = ntohs(dest->in6.sin6_port);
+	crpc->msgin.length = -1;
+	crpc->msgout.length = -1;
+	INIT_LIST_HEAD(&crpc->ready_links);
+	INIT_LIST_HEAD(&crpc->buf_links);
+	INIT_LIST_HEAD(&crpc->dead_links);
+	crpc->resend_timer_ticks = hsk->homa->timer_ticks;
+	crpc->magic = HOMA_RPC_MAGIC;
+	crpc->start_time = homa_clock();
+
+	/* Initialize fields that require locking. This allows the most
+	 * expensive work, such as copying in the message from user space,
+	 * to be performed without holding locks. Also, can't hold spin
+	 * locks while doing things that could block, such as memory allocation.
+	 */
+	homa_bucket_lock(bucket, crpc->id);
+	homa_sock_lock(hsk);
+	if (hsk->shutdown) {
+		homa_sock_unlock(hsk);
+		homa_rpc_unlock(crpc);
+		hsk->error_msg = "socket has been shut down";
+		err = -ESHUTDOWN;
+		goto error;
+	}
+	hlist_add_head(&crpc->hash_links, &bucket->rpcs);
+	rcu_read_lock();
+	list_add_tail_rcu(&crpc->active_links, &hsk->active_rpcs);
+	rcu_read_unlock();
+	homa_sock_unlock(hsk);
+
+	return crpc;
+
+error:
+	if (crpc->route)
+		homa_route_release(crpc->route);
+	kfree(crpc);
+	return ERR_PTR(err);
+}
+
+/**
+ * homa_rpc_alloc_server() - Allocate and initialize a server RPC (one that is
+ * used to manage an incoming request). If appropriate, the RPC will also
+ * be handed off (we do it here, while we have the socket locked, to avoid
+ * acquiring the socket lock a second time later for the handoff).
+ * @hsk:      Socket that owns this RPC.
+ * @source:   IP address (network byte order) of the RPC's client.
+ * @h:        Header for the first data packet received for this RPC; used
+ *            to initialize the RPC.
+ *
+ * Return:  A pointer to a new RPC, which is locked, or a negative errno
+ *          if an error occurred. If there is already an RPC corresponding
+ *          to h, then it is returned instead of creating a new RPC.
+ */
+struct homa_rpc *homa_rpc_alloc_server(struct homa_sock *hsk,
+				       const struct in6_addr *source,
+				       struct homa_data_hdr *h)
+	__cond_acquires(nonnull, srpc->bucket->lock)
+{
+	u64 id = homa_local_id(h->common.sender_id);
+	struct homa_rpc_bucket *bucket;
+	struct homa_rpc *srpc = NULL;
+	int err;
+
+	if (!hsk->buffer_pool)
+		return ERR_PTR(-ENOMEM);
+
+	/* Lock the bucket, and make sure no-one else has already created
+	 * the desired RPC.
+	 */
+	bucket = homa_server_rpc_bucket(hsk, id);
+	homa_bucket_lock(bucket, id);
+	hlist_for_each_entry(srpc, &bucket->rpcs, hash_links) {
+		if (srpc->id == id &&
+		    srpc->dport == ntohs(h->common.sport) &&
+		    ipv6_addr_equal(&srpc->route->peer->addr, source)) {
+			/* RPC already exists; just return it instead
+			 * of creating a new RPC.
+			 */
+			return srpc;
+		}
+	}
+
+	/* Initialize fields that don't require the socket lock. */
+	if (hsk->sock.sk_memcg) {
+		struct mem_cgroup *old = set_active_memcg(hsk->sock.sk_memcg);
+
+		srpc = kzalloc_obj(*srpc, GFP_ATOMIC | __GFP_ACCOUNT);
+		set_active_memcg(old);
+	} else {
+		srpc = kzalloc_obj(*srpc, GFP_ATOMIC);
+	}
+	if (!srpc) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	/* Must be initialized before any errors can occur in this function. */
+	INIT_LIST_HEAD(&srpc->buf_links);
+
+	srpc->hsk = hsk;
+	srpc->bucket = bucket;
+	srpc->state = RPC_INCOMING;
+	refcount_set(&srpc->refs, 1);
+	srpc->route = homa_route_get(hsk, source);
+	if (IS_ERR(srpc->route)) {
+		err = PTR_ERR(srpc->route);
+		srpc->route = NULL;
+		goto error;
+	}
+	srpc->dport = ntohs(h->common.sport);
+	srpc->id = id;
+	srpc->msgin.length = -1;
+	srpc->msgout.length = -1;
+	INIT_LIST_HEAD(&srpc->ready_links);
+	INIT_LIST_HEAD(&srpc->dead_links);
+	srpc->resend_timer_ticks = hsk->homa->timer_ticks;
+	srpc->magic = HOMA_RPC_MAGIC;
+	srpc->start_time = homa_clock();
+	err = homa_message_in_init(srpc, ntohl(h->message_length));
+	if (err != 0)
+		goto error;
+
+	/* Initialize fields that require socket to be locked. */
+	homa_sock_lock(hsk);
+	if (hsk->shutdown) {
+		homa_sock_unlock(hsk);
+		err = -ESHUTDOWN;
+		goto error;
+	}
+	hlist_add_head(&srpc->hash_links, &bucket->rpcs);
+	list_add_tail_rcu(&srpc->active_links, &hsk->active_rpcs);
+	homa_sock_unlock(hsk);
+	if (ntohl(h->seg.offset) == 0 && srpc->msgin.num_bpages > 0) {
+		set_bit(RPC_PKTS_READY, &srpc->flags);
+		homa_rpc_handoff(srpc);
+	}
+	return srpc;
+
+error:
+	if (srpc) {
+		homa_pool_release(srpc);
+		if (srpc->route)
+			homa_route_release(srpc->route);
+	}
+	homa_bucket_unlock(bucket, id);
+	kfree(srpc);
+	return ERR_PTR(err);
+}
+
+/**
+ * homa_rpc_ack() - Handle one or more acknowledgments for RPCs.
+ * @hsk:      Socket on which the ack(s) were received. Can sometimes be used
+ *            to avoid a socket lookup.
+ * @rpc:      RPC for which caller holds lock (NULL if none).
+ * @saddr:    Source address from which the ack was received (the client
+ *            node for the RPC)
+ * @num_acks: Number of acknowledgments in @acks
+ * @acks:     Information about one or more RPCs from @saddr that may now be
+ *            deleted safely.
+ */
+void homa_rpc_ack(struct homa_sock *hsk, struct homa_rpc *rpc,
+		  const struct in6_addr *saddr, int num_acks,
+		  struct homa_ack *acks)
+{
+	struct homa_sock *hsk2;
+	struct homa_rpc *rpc2;
+	u16 server_port;
+	u64 id;
+	int i;
+
+	if (rpc)
+		homa_rpc_unlock(rpc);
+	for (i = 0; i < num_acks; i++) {
+		struct homa_ack *ack = &acks[i];
+
+		server_port = ntohs(ack->server_port);
+		id = homa_local_id(ack->client_id);
+		if (hsk->port != server_port) {
+			/* Without RCU, sockets other than hsk can be deleted
+			 * out from under us.
+			 */
+			hsk2 = homa_sock_find(hsk->hnet, server_port);
+			if (!hsk2)
+				continue;
+		} else {
+			hsk2 = hsk;
+		}
+		rpc2 = homa_rpc_find_server(hsk2, saddr, id);
+		if (rpc2) {
+			homa_rpc_end(rpc2);
+			homa_rpc_unlock(rpc2); /* Locked by homa_rpc_find_server. */
+		}
+		if (hsk2 != hsk)
+			sock_put(&hsk2->sock);
+	}
+	if (rpc)
+		homa_rpc_lock(rpc);
+}
+
+/**
+ * homa_rpc_end() - Stop all activity on an RPC and begin the process of
+ * releasing its resources; this process will continue in the background
+ * until homa_rpc_reap eventually completes it.
+ * @rpc:  Structure to clean up, or NULL. Must be locked. Its socket must
+ *        not be locked. The RPC may still be used after this function returns
+ *        (there are many places where the RPC lock is temporarily released,
+ *        and it would add too much complexity to put checks for death
+ *        every time the lock is reacquired). However, any code that could
+ *        make the RPC visible again must check rpc->state; if the RPC is
+ *        dead then that code must no-op itself.
+ */
+void homa_rpc_end(struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	/* The goal for this function is to make the RPC inaccessible,
+	 * so that no other code will ever access it again. However, don't
+	 * actually release resources or tear down the internal structure
+	 * of the RPC; leave that to homa_rpc_reap, which runs later. There
+	 * are two reasons for this. First, releasing resources may be
+	 * expensive, so we don't want to keep the caller waiting; homa_rpc_reap
+	 * will run in situations where there is time to spare. Second, there
+	 * may be other code that currently has pointers to this RPC but
+	 * temporarily released the lock (e.g. to copy data to/from user space).
+	 * It isn't safe to clean up until that code has finished its work and
+	 * released any pointers to the RPC (homa_rpc_reap will ensure that
+	 * this has happened). So, this function should only make changes
+	 * needed to make the RPC inaccessible.
+	 */
+	if (!rpc || rpc->state == RPC_DEAD)
+		return;
+	rpc->state = RPC_DEAD;
+	rpc->error = -EINVAL;
+
+	/* Unlink from all lists, so no-one will ever find this RPC again. */
+	homa_sock_lock(rpc->hsk);
+	__hlist_del(&rpc->hash_links);
+	list_del_rcu(&rpc->active_links);
+	list_add_tail(&rpc->dead_links, &rpc->hsk->dead_rpcs);
+	__list_del_entry(&rpc->ready_links);
+	homa_pool_unlink(rpc);
+	homa_interest_notify_private(rpc);
+
+	rpc->hsk->dead_frags += rpc->msgout.num_frags + 1;
+	if (rpc->hsk->dead_frags > rpc->hsk->homa->max_dead_frags)
+		/* This update isn't thread-safe; it's just a
+		 * statistic so it's OK if updates occasionally get
+		 * missed.
+		 */
+		rpc->hsk->homa->max_dead_frags = rpc->hsk->dead_frags;
+
+	homa_sock_unlock(rpc->hsk);
+}
+
+/**
+ * homa_rpc_abort() - Terminate an RPC.
+ * @rpc:     RPC to be terminated.  Must be locked by caller.
+ * @error:   A negative errno value indicating the error that caused the abort.
+ *           If this is a client RPC, the error will be returned to the
+ *           application; if it's a server RPC, the error is ignored and
+ *           we just free the RPC.
+ */
+void homa_rpc_abort(struct homa_rpc *rpc, int error)
+	__must_hold(rpc->bucket->lock)
+{
+	if (!homa_is_client(rpc->id)) {
+		homa_rpc_end(rpc);
+		return;
+	}
+	rpc->error = error;
+	homa_rpc_handoff(rpc);
+}
+
+/**
+ * homa_abort_rpcs() - Abort all RPCs to/from a particular peer.
+ * @homa:    Overall data about the Homa protocol implementation.
+ * @addr:    Address (network order) of the destination whose RPCs are
+ *           to be aborted.
+ * @port:    If nonzero, then RPCs will only be aborted if they were
+ *	     targeted at this server port.
+ * @error:   Negative errno value indicating the reason for the abort.
+ */
+void homa_abort_rpcs(struct homa *homa, const struct in6_addr *addr,
+		     int port, int error)
+{
+	struct homa_socktab_scan scan;
+	struct homa_sock *hsk;
+	struct homa_rpc *rpc;
+
+	for (hsk = homa_socktab_start_scan(homa->socktab, &scan); hsk;
+	     hsk = homa_socktab_next(&scan)) {
+		/* Skip the (expensive) lock acquisition if there's no
+		 * work to do.
+		 */
+		if (list_empty(&hsk->active_rpcs))
+			continue;
+		if (!homa_protect_rpcs(hsk))
+			continue;
+		rcu_read_lock();
+		list_for_each_entry_rcu(rpc, &hsk->active_rpcs, active_links) {
+			if (!ipv6_addr_equal(&rpc->route->peer->addr, addr))
+				continue;
+			if (port && rpc->dport != port)
+				continue;
+			homa_rpc_lock(rpc);
+			if (rpc->state != RPC_DEAD)
+				homa_rpc_abort(rpc, error);
+			homa_rpc_unlock(rpc);
+		}
+		rcu_read_unlock();
+		homa_unprotect_rpcs(hsk);
+	}
+	homa_socktab_end_scan(&scan);
+}
+
+/**
+ * homa_rpc_reap() - Invoked to release resources associated with dead
+ * RPCs for a given socket. Each call will do a small amount of work; there
+ * may still be unreaped RPCs on return.
+ * @hsk:      Homa socket that may contain dead RPCs. Must not be locked by the
+ *            caller; this function will lock and release.
+ *
+ * Return: A return value of 0 means that we ran out of work to do; calling
+ *         again may not do any work (there could be unreaped RPCs, but if so,
+ *         they cannot currently be reaped).  A value greater than zero means
+ *         there is still more reaping work to be done.
+ */
+int homa_rpc_reap(struct homa_sock *hsk)
+{
+	/* RPC Reaping Strategy:
+	 *
+	 * (Note: there are references to this comment elsewhere in the
+	 * Homa code)
+	 *
+	 * This function is separate from homa_rpc_end for two reasons.
+	 * First, there may be outstanding references to an RPC when
+	 * homa_rpc_end is invoked; the storage for the RPC cannot be
+	 * freed until all of those references have been released.
+	 * Second, reaping an RPC is potentially expensive (if it owns a
+	 * lot of buffer memory) and homa_rpc_end could be invoked in
+	 * homa_softirq when there are short messages waiting to be processed.
+	 * Taking time to reap a long RPC could result in delays for
+	 * subsequent short RPCs. This second reason is less important
+	 * now than it used to be (in earlier versions of Homa skbs for both
+	 * inbound and outbound messages were retained until the RPC was
+	 * reaped, and freeing the skbs was relatively expensive; now no
+	 * skbs are retained; there are only pages of tx message memory to
+	 * return to homa_tx_pool).
+	 *
+	 * Thus Homa doesn't reap immediately in homa_rpc_end. Instead, dead
+	 * RPCs are queued up and reaping occurs in this function, which is
+	 * invoked later. The challenge is to do this so that (a) we don't allow
+	 * large numbers of dead RPCs to accumulate and (b) we minimize the
+	 * impact of reaping on latency of unrelated messages.
+	 *
+	 * The primary place where homa_rpc_reap is invoked is when threads
+	 * are waiting for incoming messages. The thread has nothing else to
+	 * do (it may even be polling for input), so reaping can be performed
+	 * with no latency impact on the application.  However, if a machine
+	 * is overloaded then it may never wait, so this mechanism isn't always
+	 * sufficient.
+	 *
+	 * Homa now reaps in two other places, if reaping while waiting for
+	 * messages isn't adequate:
+	 * 1. If too many dead RPCs accumulate, then homa_timer will call
+	 *    homa_rpc_reap.
+	 * 2. If the timer thread cannot keep up with all the reaping to be
+	 *    done then as a last resort homa_dispatch_pkts will reap in small
+	 *    increments (a few sk_buffs or RPCs) for every incoming batch
+	 *    of packets. This is undesirable because it will impact Homa's
+	 *    latency.
+	 *
+	 * During the introduction of homa_pools for managing input
+	 * buffers, freeing of packets for incoming messages was moved to
+	 * homa_copy_to_user under the assumption that this code wouldn't be
+	 * on the critical path. However, there is evidence that with
+	 * fast networks (e.g. 100 Gbps) copying to user space is the
+	 * bottleneck for incoming messages, and packet freeing takes about
+	 * 20-25% of the total time in homa_copy_to_user. So, it may eventually
+	 * be desirable to move packet freeing out of homa_copy_to_user.
+	 */
+#define BATCH_MAX_RPCS 5
+#define BATCH_MAX_FRAGS 30
+	struct homa_rpc *rpcs[BATCH_MAX_RPCS];
+	int checked_all_rpcs;
+	int total_dead_frags;
+	struct homa_rpc *rpc;
+	struct homa_rpc *tmp;
+	int i, num_rpcs;
+
+	/* Each iteration through the following loop will reap
+	 * up to BATCH_MAX_RPCS RPCs.
+	 */
+	checked_all_rpcs = list_empty(&hsk->dead_rpcs);
+	if (checked_all_rpcs)
+		return 0;
+	num_rpcs = 0;
+	total_dead_frags = 0;
+
+	homa_sock_lock(hsk);
+	if (atomic_read(&hsk->protect_count)) {
+		homa_sock_unlock(hsk);
+		return 0;
+	}
+
+	/* Collect freeable RPCs. */
+	list_for_each_entry_safe(rpc, tmp, &hsk->dead_rpcs, dead_links) {
+		int refs;
+
+		if (num_rpcs >= BATCH_MAX_RPCS ||
+		    total_dead_frags >= BATCH_MAX_FRAGS)
+			goto release;
+
+		/* Make sure that all outstanding uses of the RPC have
+		 * completed. We can read the reference count safely
+		 * only when we're holding the lock. Note: it isn't
+		 * safe to block while locking the RPC here, since we
+		 * hold the socket lock.
+		 */
+		if (homa_rpc_try_lock(rpc)) {
+			refs = refcount_read(&rpc->refs);
+			homa_rpc_unlock(rpc);
+		} else {
+			refs = 2;
+		}
+		if (refs > 1)
+			continue;
+
+		rpcs[num_rpcs] = rpc;
+		num_rpcs++;
+		list_del(&rpc->dead_links);
+		hsk->dead_frags -= (rpc->msgout.num_frags + 1);
+		total_dead_frags += rpc->msgout.num_frags;
+	}
+	checked_all_rpcs = true;
+
+	/* Free all of the collected resources; release the socket lock
+	 * while doing this.
+	 */
+release:
+	homa_sock_unlock(hsk);
+	for (i = 0; i < num_rpcs; i++) {
+		rpc = rpcs[i];
+
+		/* Free any unconsumed input packets and gaps (there
+		 * shouldn't usually be any of either).
+		 */
+		if (rpc->msgin.length >= 0) {
+			struct sk_buff *skb;
+
+			for (skb = __skb_dequeue(&rpc->msgin.packets); skb;
+			     skb = __skb_dequeue(&rpc->msgin.packets))
+				consume_skb(skb);
+			while (1) {
+				struct homa_gap *gap;
+
+				gap = list_first_entry_or_null(&rpc->msgin.gaps,
+							       struct homa_gap,
+							       links);
+				if (!gap)
+					break;
+				list_del(&gap->links);
+				kfree(gap);
+			}
+		}
+
+		if (rpc->route) {
+			homa_route_release(rpc->route);
+			rpc->route = NULL;
+		}
+		homa_pool_release(rpc);
+		homa_tx_pool_free(hsk->homa, rpc->msgout.num_frags,
+				  rpc->msgout.frags);
+		WARN_ON(refcount_sub_and_test(rpc->msgout.frag_bytes,
+					      &hsk->sock.sk_wmem_alloc));
+		if (rpc->msgout.frags != &rpc->msgout.frag)
+			kfree(rpc->msgout.frags);
+		rpc->state = 0;
+		rpc->magic = 0;
+		kfree(rpc);
+	}
+	homa_sock_wakeup_wmem(hsk);
+	if (hsk->buffer_pool)
+		homa_pool_check_waiting(hsk->buffer_pool);
+	return !checked_all_rpcs;
+}
+
+/**
+ * homa_abort_sock_rpcs() - Abort all outgoing (client-side) RPCs on a given
+ * socket.
+ * @hsk:         Socket whose RPCs should be aborted.
+ * @error:       Zero means that the aborted RPCs should be freed immediately.
+ *               A nonzero value means that the RPCs should be marked
+ *               complete, so that they can be returned to the application;
+ *               this value (a negative errno) will be returned from
+ *               recvmsg.
+ */
+void homa_abort_sock_rpcs(struct homa_sock *hsk, int error)
+{
+	struct homa_rpc *rpc;
+
+	if (list_empty(&hsk->active_rpcs))
+		return;
+	if (!homa_protect_rpcs(hsk))
+		return;
+	rcu_read_lock();
+	list_for_each_entry_rcu(rpc, &hsk->active_rpcs, active_links) {
+		if (!homa_is_client(rpc->id))
+			continue;
+		homa_rpc_lock(rpc);
+		if (rpc->state == RPC_DEAD) {
+			homa_rpc_unlock(rpc);
+			continue;
+		}
+		if (error)
+			homa_rpc_abort(rpc, error);
+		else
+			homa_rpc_end(rpc);
+		homa_rpc_unlock(rpc);
+	}
+	rcu_read_unlock();
+	homa_unprotect_rpcs(hsk);
+}
+
+/**
+ * homa_rpc_find_client() - Locate client-side information about the RPC that
+ * a packet belongs to, if there is any. Thread-safe without socket lock.
+ * @hsk:      Socket via which packet was received.
+ * @id:       Unique identifier for the RPC.
+ *
+ * Return:    A pointer to the homa_rpc for this id, or NULL if none.
+ *            The RPC will be locked; the caller must eventually unlock it
+ *            by invoking homa_rpc_unlock.
+ */
+struct homa_rpc *homa_rpc_find_client(struct homa_sock *hsk, u64 id)
+	__cond_acquires(nonnull, crpc->bucket->lock)
+{
+	struct homa_rpc_bucket *bucket = homa_client_rpc_bucket(hsk, id);
+	struct homa_rpc *crpc;
+
+	homa_bucket_lock(bucket, id);
+	hlist_for_each_entry(crpc, &bucket->rpcs, hash_links) {
+		if (crpc->id == id)
+			return crpc;
+	}
+	homa_bucket_unlock(bucket, id);
+	return NULL;
+}
+
+/**
+ * homa_rpc_find_server() - Locate server-side information about the RPC that
+ * a packet belongs to, if there is any. Thread-safe without socket lock.
+ * @hsk:      Socket via which packet was received.
+ * @saddr:    Address from which the packet was sent.
+ * @id:       Unique identifier for the RPC (must have server bit set).
+ *
+ * Return:    A pointer to the homa_rpc matching the arguments, or NULL
+ *            if none. The RPC will be locked; the caller must eventually
+ *            unlock it by invoking homa_rpc_unlock.
+ */
+struct homa_rpc *homa_rpc_find_server(struct homa_sock *hsk,
+				      const struct in6_addr *saddr, u64 id)
+	__cond_acquires(nonnull, srpc->bucket->lock)
+{
+	struct homa_rpc_bucket *bucket = homa_server_rpc_bucket(hsk, id);
+	struct homa_rpc *srpc;
+
+	homa_bucket_lock(bucket, id);
+	hlist_for_each_entry(srpc, &bucket->rpcs, hash_links) {
+		if (srpc->id == id && ipv6_addr_equal(&srpc->route->peer->addr,
+						      saddr))
+			return srpc;
+	}
+	homa_bucket_unlock(bucket, id);
+	return NULL;
+}
+
+/**
+ * homa_rpc_find_from_skb() - Given an skb for a Homa packet, find the homa_rpc
+ * associated with the packet and lock it.
+ * @skb:        Packet buffer; must contain a Homa packet that is "fully
+ *              populated" (e.g. the dev field and IP header are initialized).
+ * @incoming:   True means this is an incoming packet, false means outgoing.
+ * Return:      Pointer an RPC that has been locked; the caller is responsible
+ *              for unlocking it. If no RPC could be found, NULL is returned.
+ */
+struct homa_rpc *homa_rpc_find_from_skb(struct sk_buff *skb, bool incoming)
+{
+	struct homa_common_hdr *h;
+	struct homa_sock *hsk;
+	struct homa_net *hnet;
+	struct homa_rpc *rpc;
+	int port;
+	u64 id;
+
+	/* Find the appropriate socket.*/
+	h = (struct homa_common_hdr *)skb_transport_header(skb);
+	id = be64_to_cpu(h->sender_id);
+	if (incoming) {
+		port = ntohs(h->dport);
+		id ^= 1;
+	} else {
+		port = ntohs(h->sport);
+	}
+	hnet = homa_net(dev_net(skb->dev));
+	hsk = homa_sock_find(hnet, port);
+	if (!hsk)
+		return NULL;
+
+	/* Look up the RPC (client and server RPCs are handled differently) */
+	if (homa_is_client(id)) {
+		rpc = homa_rpc_find_client(hsk, id);
+	} else {
+		if (skb_is_ipv6(skb)) {
+			struct in6_addr *addr;
+
+			addr = (incoming) ? &ipv6_hdr(skb)->saddr :
+					&ipv6_hdr(skb)->daddr;
+			rpc = homa_rpc_find_server(hsk, addr, id);
+		} else {
+			struct in6_addr addr;
+
+			if (incoming)
+				ipv6_addr_set_v4mapped(ip_hdr(skb)->saddr,
+						       &addr);
+			else
+				ipv6_addr_set_v4mapped(ip_hdr(skb)->daddr,
+						       &addr);
+			rpc = homa_rpc_find_server(hsk, &addr, id);
+		}
+	}
+	sock_put(&hsk->sock);
+	return rpc;
+}
+
+/**
+ * homa_rpc_get_info() - Extract information from an RPC for returning to
+ * an application via the HOMAIOCINFO ioctl.
+ * @rpc:   RPC for which information is desired.
+ * @info:  Structure in which to store the information.
+ */
+void homa_rpc_get_info(struct homa_rpc *rpc, struct homa_rpc_info *info)
+	__must_hold(rpc->bucket->lock)
+{
+	struct homa_gap *gap;
+
+	memset(info, 0, sizeof(*info));
+	info->id = rpc->id;
+	if (rpc->hsk->inet.sk.sk_family == AF_INET6) {
+		info->peer.in6.sin6_family = AF_INET6;
+		info->peer.in6.sin6_addr = rpc->route->peer->addr;
+		info->peer.in6.sin6_port = htons(rpc->dport);
+	} else {
+		info->peer.in6.sin6_family = AF_INET;
+		info->peer.in4.sin_addr.s_addr = ipv6_to_ipv4(rpc->route->peer->addr);
+		info->peer.in4.sin_port = htons(rpc->dport);
+	}
+	info->completion_cookie = rpc->completion_cookie;
+	if (rpc->msgout.length >= 0) {
+		info->tx_length = rpc->msgout.length;
+		info->tx_sent = rpc->msgout.next_xmit_offset;
+		info->tx_granted = rpc->msgout.length;
+	} else {
+		info->tx_length = -1;
+	}
+	if (rpc->msgin.length >= 0) {
+		info->rx_length = rpc->msgin.length;
+		info->rx_remaining = rpc->msgin.bytes_remaining;
+		list_for_each_entry(gap, &rpc->msgin.gaps, links) {
+			info->rx_gaps++;
+			info->rx_gap_bytes += gap->end - gap->start;
+		}
+		info->rx_granted = rpc->msgin.length;
+		if (skb_queue_len(&rpc->msgin.packets) > 0)
+			info->flags |= HOMA_RPC_RX_COPY;
+	} else {
+		info->rx_length = -1;
+	}
+	if (!list_empty(&rpc->buf_links))
+		info->flags |= HOMA_RPC_BUF_STALL;
+	if (!list_empty(&rpc->ready_links) &&
+	    rpc->msgin.bytes_remaining == 0 &&
+	    skb_queue_len(&rpc->msgin.packets) == 0)
+		info->flags |= HOMA_RPC_RX_READY;
+	if (rpc->flags & RPC_PRIVATE)
+		info->flags |= HOMA_RPC_PRIVATE;
+}
diff --git a/net/homa/homa_rpc.h b/net/homa/homa_rpc.h
new file mode 100644
index 000000000000..fa082d229740
--- /dev/null
+++ b/net/homa/homa_rpc.h
@@ -0,0 +1,545 @@
+/* SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0+ */
+
+/* This file defines homa_rpc and related structs.  */
+
+#ifndef _HOMA_RPC_H
+#define _HOMA_RPC_H
+
+#include <linux/percpu-defs.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+
+#include "homa_sock.h"
+#include "homa_wire.h"
+
+/* Forward references. */
+struct homa_ack;
+
+/**
+ * struct homa_message_out - Describes a message (either request or response)
+ * for which this machine is the sender.
+ */
+struct homa_message_out {
+	/**
+	 * @length: Total bytes in message (excluding headers).  A value
+	 * less than 0 means this structure is uninitialized and therefore
+	 * not in use (all other fields will be zero in this case).
+	 */
+	int length;
+
+	/**
+	 * @frags: Array of fragments that hold the tx message in a ready-
+	 * to-transmit form, consisting of segments, each with a
+	 * homa_seg_hdr followed by the data for that segment. These
+	 * fragments will be incorporated into skb's to transmit the message.
+	 * If this doesn't point to @frag below then it is dynamically
+	 * allocated and must be freed.
+	 */
+	skb_frag_t *frags;
+
+	/** @num_frags: Number of fragments at @frags. */
+	int num_frags;
+
+	/**
+	 * @frag_bytes: Total amount of memory in all of @frags; this is
+	 * included in sk_wmem_alloc.
+	 */
+	int frag_bytes;
+
+	/**
+	 * @frag: @frags will point here if the message data all fits in a
+	 * single fragment (avoid alloc/free overhead).
+	 */
+	skb_frag_t frag;
+
+	/**
+	 * @max_seg_data: Maximum amount of message data to include in each
+	 * segment of tx packets.
+	 */
+	int max_seg_data;
+
+	/**
+	 * @max_gso_segs: Maximum number of segments that can be present in a
+	 * single GSO packet.
+	 */
+	int max_gso_segs;
+
+	/**
+	 * @max_gso_data: Maximum amount of message data in a GSO frame
+	 * (@max_seg_data * @max_gso_segs).
+	 */
+	int max_gso_data;
+
+	/**
+	 * @copied_from_user: Number of bytes of the message that have
+	 * been copied from user space into @frags. Used for lockless
+	 * communication between one core copying in data and another
+	 * core transmitting the data in skbs.
+	 */
+	int copied_from_user;
+
+	/**
+	 * @next_xmit_offset: All bytes in the message, up to but not
+	 * including this one, have been passed to ip_queue_xmit or
+	 * ip6_xmit at least once.
+	 */
+	int next_xmit_offset;
+
+	/**
+	 * @init_time: homa_clock() time when this structure was initialized.
+	 * Used to find the oldest outgoing message.
+	 */
+	u64 init_time;
+};
+
+/**
+ * struct homa_gap - Represents a range of bytes within a message that have
+ * not yet been received.
+ */
+struct homa_gap {
+	/** @start: offset of first byte in this gap. */
+	int start;
+
+	/** @end: offset of byte just after last one in this gap. */
+	int end;
+
+	/**
+	 * @time: homa_clock() time when the gap was first detected.
+	 * As of 7/2024 this isn't used for anything.
+	 */
+	u64 time;
+
+	/** @links: for linking into list in homa_message_in. */
+	struct list_head links;
+};
+
+/**
+ * struct homa_message_in - Holds the state of a message received by
+ * this machine; used for both requests and responses.
+ */
+struct homa_message_in {
+	/**
+	 * @length: Payload size in bytes. -1 means this structure is
+	 * uninitialized and therefore not in use.
+	 */
+	int length;
+
+	/**
+	 * @packets: DATA packets for this message that have been received but
+	 * not yet copied to user space (ordered by increasing offset). The
+	 * lock in this structure is not used (the RPC lock is used instead).
+	 */
+	struct sk_buff_head packets;
+
+	/**
+	 * @recv_end: Offset of the byte just after the highest one that
+	 * has been received so far.
+	 */
+	int recv_end;
+
+	/**
+	 * @gaps: List of homa_gaps describing all of the bytes with
+	 * offsets less than @recv_end that have not yet been received.
+	 */
+	struct list_head gaps;
+
+	/**
+	 * @bytes_remaining: Amount of data for this message that has
+	 * not yet been received; will determine the message's priority.
+	 */
+	int bytes_remaining;
+
+	/**
+	 * @num_bpages: The number of entries in @bpage_offsets used for this
+	 * message (0 means buffers not allocated yet or the buffers have
+	 * been handed off to the application).
+	 */
+	u32 num_bpages;
+
+	/**
+	 * @bpage_offsets: Describes buffer space allocated for this message.
+	 * Each entry is an offset from the start of the buffer region.
+	 * All but the last pointer refer to areas of size HOMA_BPAGE_SIZE.
+	 */
+	u32 bpage_offsets[HOMA_MAX_BPAGES];
+
+};
+
+/**
+ * struct homa_rpc - One of these structures exists for each active
+ * RPC. The same structure is used to manage both outgoing RPCs on
+ * clients and incoming RPCs on servers.
+ */
+struct homa_rpc {
+	/** @hsk:  Socket that owns the RPC. */
+	struct homa_sock *hsk;
+
+	/**
+	 * @bucket: Pointer to the bucket in hsk->client_rpc_buckets or
+	 * hsk->server_rpc_buckets where this RPC is linked. Used primarily
+	 * for locking the RPC (which is done by locking its bucket).
+	 */
+	struct homa_rpc_bucket *bucket;
+
+	/**
+	 * @state: The current state of this RPC:
+	 *
+	 * @RPC_OUTGOING:     The RPC is waiting for @msgout to be transmitted
+	 *                    to the peer.
+	 * @RPC_INCOMING:     The RPC is waiting for data @msgin to be received
+	 *                    from the peer; at least one packet has already
+	 *                    been received.
+	 * @RPC_IN_SERVICE:   Used only for server RPCs: the request message
+	 *                    has been read from the socket, but the response
+	 *                    message has not yet been presented to the kernel.
+	 * @RPC_DEAD:         The RPC has been killed and is waiting to be
+	 *                    reaped. The RPC may continue to be used in this
+	 *                    state using references that existed when
+	 *                    homa_rpc_end was invoked, but it can no longer
+	 *                    be discovered and no code may make it
+	 *                    discoverable.
+	 *
+	 * Client RPCs pass through states in the following order:
+	 * RPC_OUTGOING, RPC_INCOMING, RPC_DEAD.
+	 *
+	 * Server RPCs pass through states in the following order:
+	 * RPC_INCOMING, RPC_IN_SERVICE, RPC_OUTGOING, RPC_DEAD.
+	 */
+	enum {
+		RPC_OUTGOING            = 5,
+		RPC_INCOMING            = 6,
+		RPC_IN_SERVICE          = 8,
+		RPC_DEAD                = 9
+	} state;
+
+	/**
+	 * @flags: Additional state information: an OR'ed combination of
+	 * various single-bit flags. See below for definitions. Must be
+	 * manipulated with atomic operations because some of the manipulations
+	 * occur without holding the RPC lock.
+	 */
+	unsigned long flags;
+
+	/* Valid bit numbers for @flags:
+	 * RPC_PKTS_READY -        The RPC has input packets ready to be
+	 *                         copied to user space.
+	 * APP_NEEDS_LOCK -        Means that code in the application thread
+	 *                         needs the RPC lock (e.g. so it can start
+	 *                         copying data to user space) so others
+	 *                         (e.g. SoftIRQ processing) should relinquish
+	 *                         the lock ASAP. Without this, SoftIRQ can
+	 *                         lock out the application for a long time,
+	 *                         preventing data copies to user space from
+	 *                         starting (and they limit throughput at
+	 *                         high network speeds).
+	 * RPC_PRIVATE -           This RPC will be waited on in "private" mode,
+	 *                         where the app explicitly requests the
+	 *                         response from this particular RPC.
+	 * RPC_GRANTABLE -         1 means this RPC needs help from the grant
+	 *                         mechanism to receive its incoming message. 0
+	 *                         means either it is entirely unscheduled or
+	 *                         the message has been completely received.
+	 *                         This bit gets set at most once in the life
+	 *                         of an RPC; once cleared, it never gets set
+	 *                         again.
+	 * RPC_GRANT_MANAGED -     1 means this RPC has been inserted in the
+	 *                         grant management data structures. This
+	 *                         doesn't happen until the first time
+	 *                         homa_grant_check_rpc is called, so it is
+	 *                         possible for RPC_GRANTABLE to be set but
+	 *                         not RPC_GRANT_MANAGED.
+	 */
+#define RPC_PKTS_READY        0
+#define APP_NEEDS_LOCK        1
+#define RPC_PRIVATE           2
+#define RPC_GRANTABLE         3
+#define RPC_GRANT_MANAGED     4
+
+	/**
+	 * @refs: Number of references to this RPC, including one for each
+	 * unmatched call to homa_rpc_hold plus one for the socket's reference
+	 * in either active_rpcs or dead_rpcs. References are acquired at
+	 * "top level", such as homa_dispatch_pkts or homa_recvmsg. If a
+	 * function receives a locked RPC as parameter, it can assume
+	 * that the caller is also holding a reference to it.
+	 */
+	refcount_t refs;
+
+	/**
+	 * @route: Holds a dst_entry that can be used to route to the peer;
+	 * also provides indirect access to a homa_peer for the peer. This
+	 * value can change due to route invalidations, if RPC lock not held.
+	 */
+	struct homa_route *route;
+
+	/** @dport: Port number on @peer that will handle packets. */
+	u16 dport;
+
+	/**
+	 * @id: Unique identifier for the RPC among all those issued
+	 * from its port. The low-order bit indicates whether we are
+	 * server (1) or client (0) for this RPC.
+	 */
+	u64 id;
+
+	/**
+	 * @completion_cookie: Only used on clients. Contains identifying
+	 * information about the RPC provided by the application; returned to
+	 * the application with the RPC's result.
+	 */
+	u64 completion_cookie;
+
+	/**
+	 * @error: Only used on clients. If nonzero, then the RPC has
+	 * failed and the value is a negative errno that describes the
+	 * problem.
+	 */
+	int error;
+
+	/**
+	 * @msgin: Information about the message we receive for this RPC
+	 * (for server RPCs this is the request, for client RPCs this is the
+	 * response).
+	 */
+	struct homa_message_in msgin;
+
+	/**
+	 * @msgout: Information about the message we send for this RPC
+	 * (for client RPCs this is the request, for server RPCs this is the
+	 * response).
+	 */
+	struct homa_message_out msgout;
+
+	/**
+	 * @hash_links: Used to link this object into a hash bucket for
+	 * either @hsk->client_rpc_buckets (for a client RPC), or
+	 * @hsk->server_rpc_buckets (for a server RPC).
+	 */
+	struct hlist_node hash_links;
+
+	/**
+	 * @ready_links: Used to link this object into @hsk->ready_rpcs.
+	 */
+	struct list_head ready_links;
+
+	/**
+	 * @buf_links: Used to link this RPC into @hsk->waiting_for_bufs.
+	 * If the RPC isn't on @hsk->waiting_for_bufs, this is an empty
+	 * list pointing to itself.
+	 */
+	struct list_head buf_links;
+
+	/**
+	 * @active_links: For linking this object into @hsk->active_rpcs.
+	 * The next field will be LIST_POISON1 if this RPC hasn't yet been
+	 * linked into @hsk->active_rpcs. Access with RCU.
+	 */
+	struct list_head active_links;
+
+	/** @dead_links: For linking this object into @hsk->dead_rpcs. */
+	struct list_head dead_links;
+
+	/**
+	 * @private_interest: If there is a thread waiting for this RPC in
+	 * homa_wait_private, then this points to that thread's interest.
+	 */
+	struct homa_interest *private_interest;
+
+	/**
+	 * @silent_ticks: Number of times homa_timer has been invoked
+	 * since the last time a packet indicating progress was received
+	 * for this RPC, so we don't need to send a resend for a while.
+	 */
+	int silent_ticks;
+
+	/**
+	 * @resend_timer_ticks: Value of homa->timer_ticks the last time
+	 * we sent a RESEND for this RPC.
+	 */
+	u32 resend_timer_ticks;
+
+	/**
+	 * @done_timer_ticks: The value of homa->timer_ticks the first
+	 * time we noticed that this (server) RPC is done (all response
+	 * packets have been transmitted), so we're ready for an ack.
+	 * Zero means we haven't reached that point yet.
+	 */
+	u32 done_timer_ticks;
+
+	/**
+	 * @magic: when the RPC is alive, this holds a distinct value that
+	 * is unlikely to occur naturally. The value is cleared when the
+	 * RPC is reaped, so we can detect accidental use of an RPC after
+	 * it has been reaped.
+	 */
+#define HOMA_RPC_MAGIC 0xdeadbeef
+	int magic;
+
+	/**
+	 * @start_time: homa_clock() time when this RPC was created. Used
+	 * occasionally for testing.
+	 */
+	u64 start_time;
+};
+
+void     homa_abort_rpcs(struct homa *homa, const struct in6_addr *addr,
+			 int port, int error);
+void     homa_abort_sock_rpcs(struct homa_sock *hsk, int error);
+void     homa_rpc_abort(struct homa_rpc *crpc, int error);
+void     homa_rpc_ack(struct homa_sock *hsk, struct homa_rpc *rpc,
+		      const struct in6_addr *saddr, int num_acks,
+		      struct homa_ack *acks);
+struct homa_rpc
+	*homa_rpc_alloc_client(struct homa_sock *hsk,
+			       const union sockaddr_in_union *dest);
+struct homa_rpc
+	*homa_rpc_alloc_server(struct homa_sock *hsk,
+			       const struct in6_addr *source,
+			       struct homa_data_hdr *h);
+void     homa_rpc_end(struct homa_rpc *rpc);
+struct homa_rpc
+	*homa_rpc_find_client(struct homa_sock *hsk, u64 id);
+struct homa_rpc
+	*homa_rpc_find_from_skb(struct sk_buff *skb, bool incoming);
+struct homa_rpc
+	*homa_rpc_find_server(struct homa_sock *hsk,
+			      const struct in6_addr *saddr, u64 id);
+void     homa_rpc_get_info(struct homa_rpc *rpc, struct homa_rpc_info *info);
+int      homa_rpc_reap(struct homa_sock *hsk);
+
+/**
+ * homa_rpc_lock() - Acquire the lock for an RPC.
+ * @rpc:    RPC to lock.
+ */
+static inline void homa_rpc_lock(struct homa_rpc *rpc)
+	__acquires(rpc->bucket->lock)
+{
+	homa_bucket_lock(rpc->bucket, rpc->id);
+}
+
+/**
+ * homa_rpc_try_lock() - Acquire the lock for an RPC if it is available.
+ * @rpc:       RPC to lock.
+ * Return:     Nonzero if lock was successfully acquired, zero if it is
+ *             currently owned by someone else.
+ */
+static inline int homa_rpc_try_lock(struct homa_rpc *rpc)
+	__cond_acquires(nonzero, rpc->bucket->lock)
+{
+	if (!spin_trylock_bh(&rpc->bucket->lock))
+		return 0;
+	return 1;
+}
+
+/**
+ * homa_rpc_lock_preempt() - Same as homa_rpc_lock, except sets the
+ * APP_NEEDS_LOCK flags while waiting to encourage the existing lock
+ * owner to relinquish the lock.
+ * @rpc:   RPC to lock.
+ */
+static inline void homa_rpc_lock_preempt(struct homa_rpc *rpc)
+	__acquires(rpc->bucket->lock)
+{
+	set_bit(APP_NEEDS_LOCK, &rpc->flags);
+	homa_bucket_lock(rpc->bucket, rpc->id);
+	clear_bit(APP_NEEDS_LOCK, &rpc->flags);
+}
+
+/**
+ * homa_rpc_unlock() - Release the lock for an RPC.
+ * @rpc:   RPC to unlock.
+ */
+static inline void homa_rpc_unlock(struct homa_rpc *rpc)
+	__releases(rpc->bucket->lock)
+{
+	homa_bucket_unlock(rpc->bucket, rpc->id);
+}
+
+/**
+ * homa_protect_rpcs() - Ensures that no RPCs will be reaped for a given
+ * socket until homa_unprotect_rpcs is called. Typically used by functions
+ * that want to scan the active RPCs for a socket without holding the socket
+ * lock.  Multiple calls to this function may be in effect at once. See
+ * "Homa Locking Strategy" in homa_impl.h for more info on why this function
+ * is needed.
+ * @hsk:    Socket whose RPCs should be protected. Must not be locked
+ *          by the caller; will be locked here.
+ *
+ * Return:  1 for success, 0 if the socket has been shutdown, in which
+ *          case its RPCs cannot be protected.
+ */
+static inline int homa_protect_rpcs(struct homa_sock *hsk)
+{
+	int result;
+
+	homa_sock_lock(hsk);
+	result = !hsk->shutdown;
+	if (result)
+		atomic_inc(&hsk->protect_count);
+	homa_sock_unlock(hsk);
+	return result;
+}
+
+/**
+ * homa_unprotect_rpcs() - Cancel the effect of a previous call to
+ * homa_protect_rpcs(), so that RPCs can once again be reaped.
+ * @hsk:    Socket whose RPCs should be unprotected.
+ */
+static inline void homa_unprotect_rpcs(struct homa_sock *hsk)
+{
+	atomic_dec(&hsk->protect_count);
+}
+
+/**
+ * homa_rpc_hold() - Increment the reference count on an RPC, which will
+ * prevent it from being freed until homa_rpc_put() is called. References
+ * are taken in two situations:
+ * 1. An RPC is going to be manipulated by a collection of functions. In
+ *    this case the top-most function that identifies the RPC takes the
+ *    reference; any function that receives an RPC as an argument can
+ *    assume that a reference has been taken on the RPC by some higher
+ *    function on the call stack.
+ * 2. A pointer to an RPC is stored in an object for use later, such as
+ *    an interest. A reference must be held as long as the pointer remains
+ *    accessible in the object.
+ * @rpc:      RPC on which to take a reference.
+ */
+static inline void homa_rpc_hold(struct homa_rpc *rpc)
+{
+	refcount_inc(&rpc->refs);
+}
+
+/**
+ * homa_rpc_put() - Release a reference on an RPC (cancels the effect of
+ * a previous call to homa_rpc_hold).
+ * @rpc:      RPC to release.
+ */
+static inline void homa_rpc_put(struct homa_rpc *rpc)
+{
+	refcount_dec(&rpc->refs);
+}
+
+/**
+ * homa_is_client(): returns true if we are the client for a particular RPC,
+ * false if we are the server.
+ * @id:  Id of the RPC in question.
+ * Return: true if we are the client for RPC id, false otherwise
+ */
+static inline bool homa_is_client(u64 id)
+{
+	return (id & 1) == 0;
+}
+
+/**
+ * homa_rpc_needs_attention() - Returns true if @rpc has failed or if
+ * its incoming message is ready for attention by an application thread
+ * (e.g., packets are ready to copy to user space).
+ * @rpc: RPC to check.
+ * Return: See above
+ */
+static inline bool homa_rpc_needs_attention(struct homa_rpc *rpc)
+{
+	return (rpc->error != 0 || test_bit(RPC_PKTS_READY, &rpc->flags));
+}
+
+#endif /* _HOMA_RPC_H */
-- 
2.43.0

