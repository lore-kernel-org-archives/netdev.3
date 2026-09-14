Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC233ACA4B
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 23:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427145; cv=none; b=AVTBVMhFpg+NeNi8VyaniQJ3PbuUdz82MHMVlwEX0SXde5DKZef7rr7CkD0mv/3SQdOuQHdFSG8Hc6TE5WjxfoMkpR3Q9SIvX/hJ97s/L2O0dWJZ83IdrNBDzepfphnhwBxU9zuYbN4OPI7iHhvcxCX1JcTKHKNJI/4B7//LpXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427145; c=relaxed/simple;
	bh=bco/ujejP90Xk7AYMYcbxbzhScabn7vEjACU1TI4gAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKkL5eF4JB7E8+CegkgHq1IgYFquBjYGkrBdEaKxS6gTZ5MZIMzcJe76+rIAPK8UV+uza4YsAgqi0Nm/r9Z0u/7eGLN7/0y2TJor83m0xc9+wQeQteeqw7ZyJ+V8UwiMtuPI3l3NIaxyEMghyox+xuQ4y6hKPGhvqxEZz1shimg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=MFa2ATWQ; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="MFa2ATWQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=elzapfc0dH7CGbenxDBSwTPfccfe4kNwOwt8+6BX+L0=; t=1789427141; x=1790291141; 
	b=MFa2ATWQmgTZ552CqyJMYI0jkbOzoiIPGinSoCOdq4Ha2vTtOun5U4vCLSN71XHxYHetPhF/wOi
	wyP4WLGDTpFWWmF4zCGCdN0wPb963hnrXizbiWpoa6BMjWZH8CNtE1p3IvBtiiXURJ8wWkAlfDTxN
	9iTzwrljPmUQHIoCYe+S7jO847uo3Ti1p+15vt0U+5MYFERtdp0Ssa67ZQuwc0++wmGDfhHNeXFmL
	Ar9Lm93X5O16thPFNXnlLeIJbX1YxvGNHOzIkXvqt+kFGDV1/hGruxHQG3iaY41gVDm8yrNXRznNh
	aVCGkrq2i9aAuL1D3wKUlIWs0hqwNQ+OFvGQ==;
Received: from ouster448.stanford.edu ([172.24.72.71]:60752 helo=cs.stanford.edu)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1x6Fk2-0007WN-6I; Mon, 14 Sep 2026 16:05:41 -0700
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
Subject: [PATCH net-next v11 07/15] net: homa: create homa_sock.h and homa_sock.c
Date: Mon, 14 Sep 2026 16:05:07 -0700
Message-ID: <20260914230517.1190-8-ouster@cs.stanford.edu>
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
X-Spam-Score: -96.8
X-Scan-Signature: 87486537fbe28b4e3cd855d70a6e48e3

These files provide functions for managing the state that Homa keeps
for each open Homa socket.

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
* Fix issues related to RCU:
  * Redesign socktab scanning mechanism.
  * Safe traversal of active_rpcs in homa_sock_shutdown.
* Fix race that could lose wmem wakeups. Also add code to homa_sock_shutdown
  to wakt up threads waiting for tx memory.
* Introduce homa_sock_link objects: fixes problems that could occur
  because of port number changes in homa_sock_bind.
* Fix races related to socket lifetimes (e.g., wasn't using reference counts
  properly).

Changes for v19:
* Use a flag bit in homa_sock instead of SOCK_NOSPACE in struct socket
  (this is needed because hsk->sock.sk_socket can become NULL at
  inconvenient times).
* Fix bug with initialization order in homa_sock_init.

Changes for v16:
* Add error_msg field to struct homa_sock (for HOMAIOCINFO)
* Acquire RCU read lock in homa_sock_wakeup_wmem for safety
* Refactor homa_sock_init to reduce time in atomic context

Changes for v11:
* Clean up sparse annotations

Changes for v10:
* Revise sparse annotations to eliminate __context__ definition
* Replace __u16 with u16, __u8 with u8, etc.
* Use the destroy function from struct proto properly (fixes races in
  socket cleanup)

Changes for v9:
* Add support for homa_net objects; there is now a single socket table shared
  across all network namespaces
* Set SOCK_RCU_FREE in homa_sock_init, not homa_sock_shutdown
* Various name improvements (e.g. use "alloc" instead of "new" for functions
  that allocate memory)

Changes for v8:
* Update for new homa_pool APIs

Changes for v7:
* Refactor homa_sock_start_scan etc. (take a reference on the socket, so
  homa_socktab::active_scans and struct homa_socktab_links are no longer
  needed; encapsulate RCU usage entirely in homa_sock.c).
* Add functions for tx memory accounting
* Refactor waiting mechanism for incoming messages
* Add hsk->is_server, setsockopt SO_HOMA_SERVER
* Remove "lock_slow" functions, which don't add functionality in this
  patch series
* Remove locker argument from locking functions
* Use u64 and __u64 properly
* Take a reference to the socket in homa_sock_find
---
 net/homa/homa_sock.c | 544 +++++++++++++++++++++++++++++++++++++++++++
 net/homa/homa_sock.h | 513 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1057 insertions(+)
 create mode 100644 net/homa/homa_sock.c
 create mode 100644 net/homa/homa_sock.h

diff --git a/net/homa/homa_sock.c b/net/homa/homa_sock.c
new file mode 100644
index 000000000000..a5fd321bacf2
--- /dev/null
+++ b/net/homa/homa_sock.c
@@ -0,0 +1,544 @@
+// SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0+
+
+/* This file manages homa_sock and homa_socktab objects. */
+
+#include "homa_impl.h"
+#include "homa_interest.h"
+#include "homa_peer.h"
+#include "homa_pool.h"
+
+/**
+ * homa_socktab_init() - Constructor for homa_socktabs.
+ * @socktab:  The object to initialize; previous contents are discarded.
+ */
+void homa_socktab_init(struct homa_socktab *socktab)
+{
+	int i;
+
+	spin_lock_init(&socktab->write_lock);
+	socktab->next_sequence = 1;
+	for (i = 0; i < HOMA_SOCKTAB_BUCKETS; i++)
+		INIT_HLIST_HEAD(&socktab->buckets[i]);
+}
+
+/**
+ * homa_socktab_destroy() - Destructor for homa_socktabs: deletes all
+ * existing sockets.
+ * @socktab:  The object to destroy.
+ * @hnet:     If non-NULL, only sockets for this namespace are deleted.
+ */
+void homa_socktab_destroy(struct homa_socktab *socktab, struct homa_net *hnet)
+{
+	struct homa_socktab_scan scan;
+	struct homa_sock *hsk;
+
+	for (hsk = homa_socktab_start_scan(socktab, &scan); hsk;
+			hsk = homa_socktab_next(&scan)) {
+		if (hnet && hnet != hsk->hnet)
+			continue;
+
+		/* In actual use there should be no sockets left when this
+		 * function is invoked, so the code below will never be
+		 * invoked. However, it is useful during unit tests.
+		 */
+		homa_sock_shutdown(hsk);
+		homa_sock_destroy(&hsk->sock);
+	}
+	homa_socktab_end_scan(&scan);
+}
+
+/**
+ * homa_socktab_start_scan() - Begin an iteration over all of the sockets
+ * in a socktab.
+ * @socktab:   Socktab to scan.
+ * @scan:      Will hold the current state of the scan; any existing
+ *             contents are discarded. The caller must eventually pass this
+ *             to homa_socktab_end_scan.
+ *
+ * Return:     The first socket in the table, or NULL if the table is
+ *             empty. If non-NULL, a reference is held on the socket to
+ *             prevent its deletion.
+ *
+ * Each call to homa_socktab_next will return the next socket in the table.
+ * All sockets that are present in the table at the time this function is
+ * invoked will eventually be returned, as long as they are not removed
+ * from the table. It is safe to remove sockets from the table while the
+ * scan is in progress. If a socket is removed from the table during the scan,
+ * it may or may not be returned by homa_socktab_next. New entries added
+ * during the scan may or may not be returned.
+ */
+struct homa_sock *homa_socktab_start_scan(struct homa_socktab *socktab,
+					  struct homa_socktab_scan *scan)
+{
+	scan->socktab = socktab;
+	scan->hsk = NULL;
+	scan->current_bucket = 0;
+	scan->avail = 0;
+	scan->sequence = U64_MAX;
+
+	return homa_socktab_next(scan);
+}
+
+/**
+ * homa_socktab_fill_scan() - Refill the @socks array for a homa_socktab_scan.
+ * On return, if its @avail member is zero it means all of the sockets in
+ * the socktab have been scanned.
+ * @scan:      State of the scan. Normally the @avail member will be zero,
+ *             but this is not necessary.
+ */
+void homa_socktab_fill_scan(struct homa_socktab_scan *scan)
+{
+	struct homa_sock_link *slink;
+	struct hlist_head *bucket;
+	struct hlist_node *next;
+
+	rcu_read_lock();
+	bucket = &scan->socktab->buckets[scan->current_bucket];
+	next = rcu_dereference(hlist_first_rcu(bucket));
+	while (scan->avail < HOMA_MAX_SCANNED_SOCKS) {
+		if (!next) {
+			if (scan->current_bucket >= HOMA_SOCKTAB_BUCKETS - 1)
+				break;
+			scan->current_bucket++;
+			scan->sequence = U64_MAX;
+			bucket = &scan->socktab->buckets[scan->current_bucket];
+			next = rcu_dereference(hlist_first_rcu(bucket));
+			continue;
+		}
+		slink = hlist_entry(next, struct homa_sock_link, links);
+		next = rcu_dereference(hlist_next_rcu(next));
+		if (slink->sequence < scan->sequence) {
+			scan->sequence = slink->sequence;
+			scan->socks[scan->avail] = slink->hsk;
+			if (refcount_inc_not_zero(&slink->hsk->sock.sk_refcnt))
+				scan->avail++;
+		}
+	}
+	rcu_read_unlock();
+}
+
+/**
+ * homa_socktab_next() - Return the next socket in an iteration over a socktab.
+ * @scan:      State of the scan.
+ *
+ * Return:     The next socket in the table, or NULL if the iteration has
+ *             returned all of the sockets in the table.  If non-NULL, a
+ *             reference is held on the socket to prevent its deletion (this
+ *             module will release the reference in the next call to
+ *             homa_socktab_next or homa_socktab_end). Sockets are not returned
+ *             in any particular order. It's possible that the returned socket
+ *             has been shutdown.
+ */
+struct homa_sock *homa_socktab_next(struct homa_socktab_scan *scan)
+{
+	if (scan->hsk) {
+		sock_put(&scan->hsk->sock);
+		scan->hsk = NULL;
+	}
+
+	if (scan->avail == 0) {
+		homa_socktab_fill_scan(scan);
+		if (scan->avail == 0)
+			return NULL;
+	}
+
+	scan->hsk = scan->socks[scan->avail - 1];
+	scan->avail--;
+	return scan->hsk;
+}
+
+/**
+ * homa_socktab_end_scan() - Must be invoked on completion of each scan
+ * to clean up state associated with the scan.
+ * @scan:      State of the scan.
+ */
+void homa_socktab_end_scan(struct homa_socktab_scan *scan)
+{
+	if (scan->hsk) {
+		sock_put(&scan->hsk->sock);
+		scan->hsk = NULL;
+	}
+	while (scan->avail > 0) {
+		sock_put(&scan->socks[scan->avail - 1]->sock);
+		scan->avail--;
+	}
+}
+
+/**
+ * homa_sock_init() - Constructor for homa_sock objects. This function
+ * handles Homa-specific initialization.
+ * @hsk:    Object to initialize. The Homa-specific parts must have been
+ *          initialized to zeroes by the caller.
+ *
+ * Return:  0 for success, otherwise a negative errno.
+ */
+int homa_sock_init(struct homa_sock *hsk)
+{
+	struct homa_pool *buffer_pool;
+	struct homa_socktab *socktab;
+	struct homa_sock *other;
+	struct homa_net *hnet;
+	struct homa *homa;
+	int starting_port;
+	int result = 0;
+	int i;
+
+	hnet = (struct homa_net *)net_generic(sock_net(&hsk->sock),
+					      homa_net_id);
+	homa = hnet->homa;
+	socktab = homa->socktab;
+
+	/* Do things requiring memory allocation before locking the socket,
+	 * so that GFP_ATOMIC is not needed.
+	 */
+	buffer_pool = homa_pool_alloc(hsk);
+	if (IS_ERR(buffer_pool))
+		return PTR_ERR(buffer_pool);
+
+	/* Initialize the fields private to Homa. We can initialize
+	 * everything except the port and hash table links without acquiring
+	 * the socket table lock.
+	 */
+	hsk->homa = homa;
+	hsk->hnet = hnet;
+	hsk->buffer_pool = buffer_pool;
+
+	hsk->is_server = false;
+	hsk->shutdown = false;
+	hsk->ip_header_length = (hsk->inet.sk.sk_family == AF_INET) ?
+				sizeof(struct iphdr) : sizeof(struct ipv6hdr);
+	hsk->error_msg = "no error";
+	spin_lock_init(&hsk->lock);
+	atomic_set(&hsk->protect_count, 0);
+	INIT_LIST_HEAD(&hsk->active_rpcs);
+	INIT_LIST_HEAD(&hsk->dead_rpcs);
+	INIT_LIST_HEAD(&hsk->waiting_for_bufs);
+	INIT_LIST_HEAD(&hsk->ready_rpcs);
+	INIT_LIST_HEAD(&hsk->interests);
+	for (i = 0; i < HOMA_CLIENT_RPC_BUCKETS; i++) {
+		struct homa_rpc_bucket *bucket = &hsk->client_rpc_buckets[i];
+
+		spin_lock_init(&bucket->lock);
+		bucket->id = i;
+		INIT_HLIST_HEAD(&bucket->rpcs);
+	}
+	for (i = 0; i < HOMA_SERVER_RPC_BUCKETS; i++) {
+		struct homa_rpc_bucket *bucket = &hsk->server_rpc_buckets[i];
+
+		spin_lock_init(&bucket->lock);
+		bucket->id = i + 1000000;
+		INIT_HLIST_HEAD(&bucket->rpcs);
+	}
+
+	/* Initialize fields outside the Homa part. */
+	hsk->sock.sk_sndbuf = homa->wmem_max;
+	sock_set_flag(&hsk->inet.sk, SOCK_RCU_FREE);
+
+	/* This is needed to prevent blocking when allocating memory in
+	 * functions like ip_route_output_flow, which could be invoked
+	 * while atomic.
+	 */
+	hsk->sock.sk_allocation = GFP_ATOMIC;
+
+	/* Pick a default port. Must keep the socktab locked from now
+	 * until the new socket is added to the socktab, to ensure that
+	 * no other socket chooses the same port.
+	 */
+	spin_lock_bh(&socktab->write_lock);
+	starting_port = hnet->prev_default_port;
+	while (1) {
+		hnet->prev_default_port++;
+		if (hnet->prev_default_port < HOMA_MIN_DEFAULT_PORT)
+			hnet->prev_default_port = HOMA_MIN_DEFAULT_PORT;
+		other = homa_sock_find(hnet, hnet->prev_default_port);
+		if (!other)
+			break;
+		sock_put(&other->sock);
+		if (hnet->prev_default_port == starting_port) {
+			spin_unlock_bh(&socktab->write_lock);
+			result = -EADDRNOTAVAIL;
+			goto error;
+		}
+		spin_unlock_bh(&socktab->write_lock);
+		cond_resched();
+		spin_lock_bh(&socktab->write_lock);
+	}
+	result = homa_sock_link(hsk, hnet->prev_default_port);
+	spin_unlock_bh(&socktab->write_lock);
+	if (result == 0)
+		return result;
+
+error:
+	hsk->shutdown = true;
+	hsk->homa = NULL;
+	homa_pool_free(buffer_pool);
+	return result;
+}
+
+/**
+ * homa_sock_link() - Add a socket to the hash table for its socktab,
+ * so that it will be discoverable through homa_sock_find. If the socket
+ * is already linked, the current link will be removed.
+ * @hsk:    Socket to link in; hsk->port will be used to determine
+ *          where the socket is linked in it socktab. Caller must hold
+ *          the lock for the socket's socktab.
+ * @port:   Port to use for the socket; if this function succeeds, this
+ *          number will be stored in hsk.
+ *
+ * Return:  0 for success, otherwise a negative errno.
+ */
+int homa_sock_link(struct homa_sock *hsk, int port)
+	__must_hold(hsk->homa->socktab->write_lock)
+{
+	struct homa_socktab *socktab = hsk->homa->socktab;
+	struct homa_sock_link *slink;
+
+	slink = kmalloc_obj(*slink, GFP_ATOMIC | __GFP_ACCOUNT);
+	if (!slink)
+		return -ENOMEM;
+	homa_sock_unlink(hsk);
+	slink->hsk = hsk;
+	slink->sequence = socktab->next_sequence;
+	socktab->next_sequence++;
+	hlist_add_head_rcu(&slink->links,
+			   &socktab->buckets[homa_socktab_bucket(hsk->hnet,
+								 port)]);
+	hsk->port = port;
+	hsk->inet.inet_num = port;
+	hsk->inet.inet_sport = htons(port);
+	hsk->slink = slink;
+	return 0;
+}
+
+/*
+ * homa_sock_unlink() - Unlinks a socket from its socktab. Once this method
+ * returns, the socket will not be discoverable through the socktab.
+ * @hsk:  Socket to unlink. Caller must hold the lock for the socket's
+ *        socktab.
+ */
+void homa_sock_unlink(struct homa_sock *hsk)
+	__must_hold(hsk->homa->socktab->write_lock)
+{
+	struct homa_sock_link *slink;
+
+	slink = hsk->slink;
+	if (!slink)
+		return;
+	hsk->slink = NULL;
+	hlist_del_rcu(&slink->links);
+	kfree_rcu(slink, rcu_head);
+}
+
+/**
+ * homa_sock_shutdown() - Disable a socket so that it can no longer
+ * be used for either sending or receiving messages. Any system calls
+ * currently waiting to send or receive messages will be aborted. This
+ * function will terminate any existing use of the socket, but it does
+ * not free up socket resources: that happens in homa_sock_destroy.
+ * @hsk:       Socket to shut down.
+ */
+void homa_sock_shutdown(struct homa_sock *hsk)
+{
+	struct homa_socktab *socktab;
+	struct homa_rpc *rpc;
+
+	homa_sock_lock(hsk);
+	if (hsk->shutdown || !hsk->homa) {
+		homa_sock_unlock(hsk);
+		return;
+	}
+
+	/* The order of cleanup is very important, because there could be
+	 * active operations that hold RPC locks but not the socket lock.
+	 * 1. Set @shutdown; this ensures that no new RPCs will be created for
+	 *    this socket (though some creations might already be in progress)
+	 *    and incoming packets will be dropped.
+	 * 2. Remove the socket from its socktab, so no-one will ever find
+	 *    it again.
+	 * 3. Go through all of the RPCs and delete them; this will
+	 *    synchronize with any operations in progress.
+	 * 4. Perform other socket cleanup: at this point we know that
+	 *    there will be no concurrent activities on individual RPCs.
+	 * 5. Don't delete the buffer pool until after all of the RPCs
+	 *    have been reaped.
+	 * See "Homa Locking Strategy" in homa_impl.h for additional information
+	 * about locking.
+	 */
+	hsk->shutdown = true;
+
+	/* This protects against RPC deletions during the RCU scan of
+	 * active_rpcs below.
+	 */
+	atomic_inc(&hsk->protect_count);
+	homa_sock_unlock(hsk);
+
+	socktab = hsk->homa->socktab;
+	spin_lock_bh(&socktab->write_lock);
+	homa_sock_unlink(hsk);
+	spin_unlock_bh(&socktab->write_lock);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(rpc, &hsk->active_rpcs, active_links) {
+		homa_rpc_lock(rpc);
+		homa_rpc_end(rpc);
+		homa_rpc_unlock(rpc);
+	}
+	wake_up_interruptible_poll(sk_sleep(&hsk->sock), EPOLLOUT);
+	rcu_read_unlock();
+	homa_unprotect_rpcs(hsk);
+
+	homa_sock_lock(hsk);
+	while (!list_empty(&hsk->interests))
+		homa_interest_notify_shared(hsk, NULL);
+	homa_sock_unlock(hsk);
+}
+
+/**
+ * homa_sock_destroy() - Release all of the internal resources associated
+ * with a socket; is invoked at time when that is safe (i.e., all references
+ * on the socket have been dropped).
+ * @sk:       Socket to destroy.
+ */
+void homa_sock_destroy(struct sock *sk)
+{
+	struct homa_sock *hsk = homa_sk(sk);
+
+	if (!hsk->homa)
+		return;
+
+	while (!list_empty(&hsk->dead_rpcs))
+		homa_rpc_reap(hsk);
+
+	WARN_ON_ONCE(refcount_read(&hsk->sock.sk_wmem_alloc) != 1);
+
+	if (hsk->buffer_pool) {
+		homa_pool_free(hsk->buffer_pool);
+		hsk->buffer_pool = NULL;
+	}
+}
+
+/**
+ * homa_sock_bind() - Associates a server port with a socket; if there
+ * was a previous server port assignment for @hsk, it is abandoned.
+ * @hnet:      Network namespace with which port is associated.
+ * @hsk:       Homa socket.
+ * @port:      Desired server port for @hsk. If 0, then this call
+ *             becomes a no-op: the socket will continue to use
+ *             its randomly assigned client port.
+ *
+ * Return:  0 for success, otherwise a negative errno. If an error is
+ *          returned, hsk->error_msg is set.
+ */
+int homa_sock_bind(struct homa_net *hnet, struct homa_sock *hsk,
+		   u16 port)
+{
+	struct homa_socktab *socktab = hnet->homa->socktab;
+	struct homa_sock *owner;
+	int result = 0;
+
+	if (port == 0)
+		return result;
+	if (port >= HOMA_MIN_DEFAULT_PORT) {
+		hsk->error_msg = "port number invalid: in the automatically assigned range";
+		return -EINVAL;
+	}
+	homa_sock_lock(hsk);
+	spin_lock_bh(&socktab->write_lock);
+	if (hsk->shutdown) {
+		hsk->error_msg = "socket has been shut down";
+		result = -ESHUTDOWN;
+		goto done;
+	}
+
+	owner = homa_sock_find(hnet, port);
+	if (owner) {
+		sock_put(&owner->sock);
+		if (owner != hsk) {
+			hsk->error_msg = "requested port number is already in use";
+			result = -EADDRINUSE;
+		}
+		goto done;
+	}
+	result = homa_sock_link(hsk, port);
+	if (result == 0)
+		hsk->is_server = true;
+done:
+	spin_unlock_bh(&socktab->write_lock);
+	homa_sock_unlock(hsk);
+	return result;
+}
+
+/**
+ * homa_sock_find() - Returns the socket associated with a given port.
+ * @hnet:       Network namespace where the socket will be used.
+ * @port:       The port of interest.
+ * Return:      The socket that owns @port, or NULL if none. If non-NULL
+ *              then this method has taken a reference on the socket and
+ *              the caller must call sock_put to release it.
+ */
+struct homa_sock *homa_sock_find(struct homa_net *hnet, u16 port)
+{
+	int bucket = homa_socktab_bucket(hnet, port);
+	struct homa_sock *result = NULL;
+	struct homa_sock_link *slink;
+	struct homa_sock *hsk;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(slink, &hnet->homa->socktab->buckets[bucket],
+				 links) {
+		hsk = slink->hsk;
+		if (hsk && hsk->port == port && hsk->hnet == hnet &&
+		    !hsk->shutdown &&
+		    refcount_inc_not_zero(&hsk->sock.sk_refcnt)) {
+			result = hsk;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return result;
+}
+
+/**
+ * homa_sock_wait_wmem() - Block the thread until @hsk's usage of tx
+ * packet memory drops below the socket's limit.
+ * @hsk:          Socket of interest.
+ * @nonblocking:  If there's not enough memory, return -EWOLDBLOCK instead
+ *                of blocking.
+ * Return: 0 for success, otherwise a negative errno.
+ */
+int homa_sock_wait_wmem(struct homa_sock *hsk, int nonblocking)
+{
+	long timeo = hsk->sock.sk_sndtimeo;
+	int result;
+
+	/* Note: we can't use sock_wait_for_wmem because that function
+	 * is not available to modules (as of August 2025 it's static).
+	 */
+	if (nonblocking)
+		timeo = 0;
+	set_bit(HOMA_SOCK_NOSPACE, &hsk->flags);
+
+	/* Must wakeup if either memory becomes available or HOMA_SOCK_NOSPACE
+	 * gets cleared. The wmem_avl check is needed to handle a race where
+	 * memory gets freed just before HOMA_SOCK_NOSPACE is set above. The
+	 * HOMA_SOCK_NOSPACE check is needed to handle a race where multiple
+	 * threads wakeup and one thread consumes enough memory that the
+	 * wmem_avl check fails for the other. This approach means that we may
+	 * exceed the memory limit if multiple threads wake up at once, but
+	 * it prevents thread starvation that could occur if the second
+	 * thread were to go back to sleep.
+	 */
+	result = wait_event_interruptible_timeout(*sk_sleep(&hsk->sock),
+						  homa_sock_wmem_avl(hsk) ||
+						  hsk->shutdown ||
+						  !test_bit(HOMA_SOCK_NOSPACE,
+							    &hsk->flags),
+						  timeo);
+	if (hsk->shutdown)
+		return -ESHUTDOWN;
+	if (signal_pending(current))
+		return -EINTR;
+	if (result == 0)
+		return -EWOULDBLOCK;
+	return 0;
+}
diff --git a/net/homa/homa_sock.h b/net/homa/homa_sock.h
new file mode 100644
index 000000000000..21a7802a999c
--- /dev/null
+++ b/net/homa/homa_sock.h
@@ -0,0 +1,513 @@
+/* SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0+ */
+
+/* This file defines structs and other things related to Homa sockets.  */
+
+#ifndef _HOMA_SOCK_H
+#define _HOMA_SOCK_H
+
+/* Forward declarations. */
+struct homa;
+struct homa_pool;
+struct homa_sock;
+
+/* Number of hash buckets in a homa_socktab. Must be a power of 2. */
+#define HOMA_SOCKTAB_BUCKET_BITS 10
+#define HOMA_SOCKTAB_BUCKETS BIT(HOMA_SOCKTAB_BUCKET_BITS)
+
+/**
+ * struct homa_socktab - A hash table that maps from port numbers (either
+ * client or server) to homa_sock objects.
+ *
+ * This table is managed exclusively by homa_socktab.c, using RCU to
+ * minimize synchronization during lookups.
+ */
+struct homa_socktab {
+	/**
+	 * @write_lock: Controls all modifications to this object; not needed
+	 * for socket lookups (RCU is used instead). Also used to
+	 * synchronize port allocation.
+	 */
+	spinlock_t write_lock;
+
+	/**
+	 * @next_sequence: Next sequence number to assign for a
+	 * homa_sock_link.
+	 */
+	u64 next_sequence;
+
+	/**
+	 * @buckets: Heads of chains for hash table buckets. Chains
+	 * consist of homa_sock_link objects, in decreasing order of
+	 * sequence number.
+	 */
+	struct hlist_head buckets[HOMA_SOCKTAB_BUCKETS];
+};
+
+/**
+ * struct homa_sock_link - Used to link a socket into a list associated
+ * with a bucket in a homa_socktab. This is a separate dynamically
+ * allocated object because a socket may need to change its position in
+ * the homa_socktab (because its port number changes); during the
+ * transition, multiple of these objects may exist for a socket so that
+ * socktab scans are not disrupted by the change in position. The lifetime
+ * of these objects is managed with RCU.
+ */
+struct homa_sock_link {
+	/** @hsk: The socket associated with this link. */
+	struct homa_sock *hsk;
+
+	/**
+	 * @sequence: Unique sequence number for this struct among all structs
+	 * in a socktab (smaller means older).
+	 */
+	u64 sequence;
+
+	/**
+	 * @links: Links this object into the chain for a bucket in a
+	 * homa_socktab.
+	 */
+	struct hlist_node links;
+
+	/** @rcu_head: Used for RCU-based freeing of this object. */
+	struct rcu_head rcu_head;
+};
+
+/**
+ * struct homa_socktab_scan - Records the state of an iteration over all
+ * the entries in a homa_socktab, in a way that is safe against concurrent
+ * reclamation of sockets.
+ */
+struct homa_socktab_scan {
+	/** @socktab: The table that is being scanned. */
+	struct homa_socktab *socktab;
+
+	/**
+	 * @hsk: Points to the current socket in the iteration, or NULL if
+	 * we're at the beginning of the iteration or have reached the end of
+	 * the current bucket. If non-NULL then we are holding a reference
+	 * to this socket.
+	 */
+	struct homa_sock *hsk;
+
+	/**
+	 * @current_bucket: The index of the bucket in socktab->buckets
+	 * currently being scanned.
+	 */
+	int current_bucket;
+
+	/**
+	 * @avail: The first @avail entries in @links are valid and
+	 * available for homa_sock_next to return.
+	 */
+	int avail;
+
+	/**
+	 * @socks: Used to collect a bunch of sockets by scanning hash table
+	 * bucket chains. Sockets are then returned from here by
+	 * homa_socktab_next. We own a reference for each of these sockets.
+	 */
+#define HOMA_MAX_SCANNED_SOCKS 5
+	struct homa_sock *socks[HOMA_MAX_SCANNED_SOCKS];
+
+	/**
+	 * @sequence: All homa_sock_links with @sequence numbers >= this
+	 * have already been scanned from @current_bucket.
+	 */
+	u64 sequence;
+};
+
+/**
+ * struct homa_rpc_bucket - One bucket in a hash table of RPCs.
+ */
+
+struct homa_rpc_bucket {
+	/**
+	 * @lock: serves as a lock both for this bucket (e.g., when
+	 * adding and removing RPCs) and also for all of the RPCs in
+	 * the bucket. Must be held whenever looking up an RPC in
+	 * this bucket or manipulating an RPC in the bucket. This approach
+	 * has the following properties:
+	 * 1. An RPC can be looked up and locked (a common operation) with
+	 *    a single lock acquisition.
+	 * 2. Looking up and locking are atomic: there is no window of
+	 *    vulnerability where someone else could delete an RPC after
+	 *    it has been looked up and before it has been locked.
+	 * 3. The lookup mechanism does not use RCU.  This is important because
+	 *    RPCs are created rapidly and typically live only a few tens of
+	 *    microseconds.  As of May 2025 RCU introduces a lag of about
+	 *    25 ms before objects can be deleted; for RPCs this would result
+	 *    in hundreds or thousands of RPCs accumulating before RCU allows
+	 *    them to be deleted.
+	 * This approach has the disadvantage that RPCs within a bucket share
+	 * locks and thus may not be able to work concurrently, but there are
+	 * enough buckets in the table to make such colllisions rare.
+	 *
+	 * See "Homa Locking Strategy" in homa_impl.h for more info about
+	 * locking.
+	 */
+	spinlock_t lock;
+
+	/**
+	 * @id: identifier for this bucket, used in error messages etc.
+	 * It's the index of the bucket within its hash table bucket
+	 * array, with an additional offset to separate server and
+	 * client RPCs.
+	 */
+	int id;
+
+	/** @rpcs: list of RPCs that hash to this bucket. */
+	struct hlist_head rpcs;
+};
+
+/**
+ * define HOMA_CLIENT_RPC_BUCKETS - Number of buckets in hash tables for
+ * client RPCs. Must be a power of 2.
+ */
+#define HOMA_CLIENT_RPC_BUCKETS 1024
+
+/**
+ * define HOMA_SERVER_RPC_BUCKETS - Number of buckets in hash tables for
+ * server RPCs. Must be a power of 2.
+ */
+#define HOMA_SERVER_RPC_BUCKETS 1024
+
+/**
+ * struct homa_sock - Information about an open socket.
+ */
+struct homa_sock {
+	/* Info for other network layers. Note: IPv6 info (struct ipv6_pinfo
+	 * comes at the very end of the struct, *after* Homa's data, if this
+	 * socket uses IPv6).
+	 */
+	union {
+		/** @sock: generic socket data; must be the first field. */
+		struct sock sock;
+
+		/**
+		 * @inet: generic Internet socket data; must also be the
+		 first field (contains sock as its first member).
+		 */
+		struct inet_sock inet;
+	};
+
+	/**
+	 * @homa: Overall state about the Homa implementation. NULL
+	 * means this socket was never initialized or has been deleted.
+	 */
+	struct homa *homa;
+
+	/**
+	 * @hnet: Overall state specific to the network namespace for
+	 * this socket.
+	 */
+	struct homa_net *hnet;
+
+	/**
+	 * @buffer_pool: used to allocate buffer space for incoming messages.
+	 * Storage is dynamically allocated.
+	 */
+	struct homa_pool *buffer_pool;
+
+	/**
+	 * @port: Port number: identifies this socket uniquely among all
+	 * those on this node.
+	 */
+	u16 port;
+
+	/**
+	 * @is_server: True means that this socket can act as both client
+	 * and server; false means the socket is client-only.
+	 */
+	bool is_server;
+
+	/**
+	 * @shutdown: True means the socket is no longer usable (either
+	 * shutdown has already been invoked, or the socket was never
+	 * properly initialized). Note: can't use the SOCK_DEAD flag for
+	 * this because that flag doesn't get set until much later in the
+	 * process of closing a socket.
+	 */
+	bool shutdown;
+
+	/**
+	 * @ip_header_length: Length of IP headers for this socket (depends
+	 * on IPv4 vs. IPv6).
+	 */
+	int ip_header_length;
+
+	/** @slink: Links this socket into a homa_socktab bucket. */
+	struct homa_sock_link *slink;
+
+	/**
+	 * @error_msg: Static string giving human-readable information about
+	 * the reason for the last error returned by a Homa kernel call.
+	 * Applications can fetch this with the HOMAIOCINFO ioctl to figure
+	 * out why a call failed.
+	 */
+	char *error_msg;
+
+	/* Information above is (almost) never modified; start a new
+	 * cache line below for info that is modified frequently.
+	 */
+
+	/**
+	 * @lock: Must be held when modifying fields such as interests
+	 * and lists of RPCs. This lock is used in place of sk->sk_lock
+	 * because it's used differently (it's always used as a simple
+	 * spin lock).  See "Homa Locking Strategy" in homa_impl.h
+	 * for more on Homa's synchronization strategy.
+	 */
+	spinlock_t lock ____cacheline_aligned_in_smp;
+
+	/**
+	 * @protect_count: counts the number of calls to homa_protect_rpcs
+	 * for which there have not yet been calls to homa_unprotect_rpcs.
+	 */
+	atomic_t protect_count;
+
+	/**
+	 * @flags: Additional state information: an OR'ed combination of
+	 * various single-bit flags. See below for definitions. Must be
+	 * manipulated with test_bit etc. because some of the manipulations
+	 * occur without holding @lock.
+	 */
+	unsigned long flags;
+
+	/* Valid bit numbers for @flags:
+	 * HOMA_SOCK_NOSPACE -     Nonzero means that the socket has hit its
+	 *                         limit on tx buffer space and threads are
+	 *                         blocked waiting for skbs to be released. Used
+	 *                         instead of the SOCK_NOSPACE flag in
+	 *                         @sock.sk_socket->flags. This is because
+	 *                         @sock.sk_socket can become NULL unexpectedly
+	 *                         (especially since Homa never acquires the
+	 *                         Linux socket lock). Thus code using sk_socket
+	 *                         requires tricky synchronization and is
+	 *                         error-prone.
+	 */
+#define HOMA_SOCK_NOSPACE        0
+
+	/**
+	 * @active_rpcs: List of all existing RPCs related to this socket,
+	 * including both client and server RPCs. This list isn't strictly
+	 * needed, since RPCs are already in one of the hash tables below,
+	 * but it's more efficient for homa_timer to have this list
+	 * (so it doesn't have to scan large numbers of hash buckets).
+	 * The list is sorted, with the oldest RPC first. Manipulate with
+	 * RCU so timer can access without locking.
+	 */
+	struct list_head active_rpcs;
+
+	/**
+	 * @dead_rpcs: Contains RPCs for which homa_rpc_end has been
+	 * called, but which have not yet been reaped by homa_rpc_reap.
+	 */
+	struct list_head dead_rpcs;
+
+	/**
+	 * @dead_frags: An estimate of the amount of memory tied up in
+	 * RPCs that are dead but have not yet been reaped. The sum of
+	 * rpc->msgout.num_frags + 1 for all of the dead RPCs (the 1 accounts
+	 * for the RPC itself). Used to detect when the reaper is lagging
+	 * behind. See "RPC Reaping Strategy" in homa_rpc_reap code for
+	 * deetails.
+	 */
+	u64 dead_frags;
+
+	/**
+	 * @waiting_for_bufs: Contains RPCs that are blocked because there
+	 * wasn't enough space in the buffer pool region for their incoming
+	 * messages. Sorted in increasing order of message length.
+	 */
+	struct list_head waiting_for_bufs;
+
+	/**
+	 * @ready_rpcs: List of all RPCs that are ready for attention from
+	 * an application thread.
+	 */
+	struct list_head ready_rpcs;
+
+	/**
+	 * @interests: List of threads that are currently waiting for
+	 * incoming messages via homa_wait_shared.
+	 */
+	struct list_head interests;
+
+	/**
+	 * @client_rpc_buckets: Hash table for fast lookup of client RPCs.
+	 * Modifications are synchronized with bucket locks, not
+	 * the socket lock.
+	 */
+	struct homa_rpc_bucket client_rpc_buckets[HOMA_CLIENT_RPC_BUCKETS];
+
+	/**
+	 * @server_rpc_buckets: Hash table for fast lookup of server RPCs.
+	 * Modifications are synchronized with bucket locks, not
+	 * the socket lock.
+	 */
+	struct homa_rpc_bucket server_rpc_buckets[HOMA_SERVER_RPC_BUCKETS];
+};
+
+/**
+ * struct homa_v6_sock - For IPv6, additional IPv6-specific information
+ * is present in the socket struct after Homa-specific information.
+ */
+struct homa_v6_sock {
+	/** @homa: All socket info except for IPv6-specific stuff. */
+	struct homa_sock homa;
+
+	/** @inet6: Socket info specific to IPv6. */
+	struct ipv6_pinfo inet6;
+};
+
+int                homa_sock_bind(struct homa_net *hnet, struct homa_sock *hsk,
+				  u16 port);
+void               homa_sock_destroy(struct sock *sk);
+void               homa_socktab_fill_scan(struct homa_socktab_scan *scan);
+struct homa_sock  *homa_sock_find(struct homa_net *hnet, u16 port);
+int                homa_sock_init(struct homa_sock *hsk);
+int                homa_sock_link(struct homa_sock *hsk, int port);
+void               homa_sock_shutdown(struct homa_sock *hsk);
+void               homa_sock_unlink(struct homa_sock *hsk);
+int                homa_sock_wait_wmem(struct homa_sock *hsk, int nonblocking);
+void               homa_socktab_destroy(struct homa_socktab *socktab,
+					struct homa_net *hnet);
+void               homa_socktab_end_scan(struct homa_socktab_scan *scan);
+void               homa_socktab_init(struct homa_socktab *socktab);
+struct homa_sock  *homa_socktab_next(struct homa_socktab_scan *scan);
+struct homa_sock  *homa_socktab_start_scan(struct homa_socktab *socktab,
+					   struct homa_socktab_scan *scan);
+
+/**
+ * homa_sock_lock() - Acquire the lock for a socket.
+ * @hsk:     Socket to lock.
+ */
+static inline void homa_sock_lock(struct homa_sock *hsk)
+	__acquires(hsk->lock)
+{
+	spin_lock_bh(&hsk->lock);
+}
+
+/**
+ * homa_sock_unlock() - Release the lock for a socket.
+ * @hsk:   Socket to lock.
+ */
+static inline void homa_sock_unlock(struct homa_sock *hsk)
+	__releases(hsk->lock)
+{
+	spin_unlock_bh(&hsk->lock);
+}
+
+/**
+ * homa_socktab_bucket() - Compute the bucket number in a homa_socktab
+ * that will contain a particular socket.
+ * @hnet:   Network namespace of the desired socket.
+ * @port:   Port number of the socket.
+ *
+ * Return:  The index of the bucket in which a socket matching @hnet and
+ *          @port will be found (if it exists).
+ */
+static inline int homa_socktab_bucket(struct homa_net *hnet, u16 port)
+{
+	return hash_32((uintptr_t)hnet ^ port, HOMA_SOCKTAB_BUCKET_BITS);
+}
+
+/**
+ * homa_client_rpc_bucket() - Find the bucket containing a given
+ * client RPC.
+ * @hsk:      Socket associated with the RPC.
+ * @id:       Id of the desired RPC.
+ *
+ * Return:    The bucket in which this RPC will appear, if the RPC exists.
+ */
+static inline struct homa_rpc_bucket
+		*homa_client_rpc_bucket(struct homa_sock *hsk, u64 id)
+{
+	/* We can use a really simple hash function here because RPC ids
+	 * are allocated sequentially.
+	 */
+	return &hsk->client_rpc_buckets[(id >> 1) &
+	       (HOMA_CLIENT_RPC_BUCKETS - 1)];
+}
+
+/**
+ * homa_server_rpc_bucket() - Find the bucket containing a given
+ * server RPC.
+ * @hsk:         Socket associated with the RPC.
+ * @id:          Id of the desired RPC.
+ *
+ * Return:    The bucket in which this RPC will appear, if the RPC exists.
+ */
+static inline struct homa_rpc_bucket
+		*homa_server_rpc_bucket(struct homa_sock *hsk, u64 id)
+{
+	/* Each client allocates RPC ids sequentially, so they will
+	 * naturally distribute themselves across the hash space.
+	 * Thus we can use the id directly as hash.
+	 */
+	return &hsk->server_rpc_buckets[(id >> 1)
+			& (HOMA_SERVER_RPC_BUCKETS - 1)];
+}
+
+/**
+ * homa_bucket_lock() - Acquire the lock for an RPC hash table bucket.
+ * @bucket:    Bucket to lock.
+ * @id:        Id of the RPC on whose behalf the bucket is being locked.
+ *             Used only for metrics.
+ */
+static inline void homa_bucket_lock(struct homa_rpc_bucket *bucket, u64 id)
+	__acquires(bucket->lock)
+{
+	spin_lock_bh(&bucket->lock);
+}
+
+/**
+ * homa_bucket_unlock() - Release the lock for an RPC hash table bucket.
+ * @bucket:   Bucket to unlock.
+ * @id:       ID of the RPC that was using the lock.
+ */
+static inline void homa_bucket_unlock(struct homa_rpc_bucket *bucket, u64 id)
+	__releases(bucket->lock)
+{
+	spin_unlock_bh(&bucket->lock);
+}
+
+static inline struct homa_sock *homa_sk(const struct sock *sk)
+{
+	return (struct homa_sock *)sk;
+}
+
+/**
+ * homa_sock_wmem_avl() - Returns true if the socket is within its limit
+ * for output memory usage. False means that no new messages should be sent
+ * until memory is freed.
+ * @hsk:   Socket of interest.
+ * Return: See above.
+ */
+static inline bool homa_sock_wmem_avl(struct homa_sock *hsk)
+{
+	return refcount_read(&hsk->sock.sk_wmem_alloc) < hsk->sock.sk_sndbuf;
+}
+
+/**
+ * homa_sock_wakeup_wmem() - Invoked when tx packet memory has been freed;
+ * if memory usage is below the limit and there are tasks waiting for memory,
+ * wake them up.
+ * @hsk:   Socket of interest.
+ */
+static inline void homa_sock_wakeup_wmem(struct homa_sock *hsk)
+{
+	/* Note: can't use sk_stream_write_space for this functionality
+	 * because it uses a different test to determine whether enough
+	 * memory is available.
+	 */
+	if (test_bit(HOMA_SOCK_NOSPACE, &hsk->flags) &&
+	    homa_sock_wmem_avl(hsk)) {
+		clear_bit(HOMA_SOCK_NOSPACE, &hsk->flags);
+		rcu_read_lock();
+		wake_up_interruptible_poll(sk_sleep(&hsk->sock), EPOLLOUT);
+		rcu_read_unlock();
+	}
+}
+
+#endif /* _HOMA_SOCK_H */
-- 
2.43.0

