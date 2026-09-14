Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2133F3B0581
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 23:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427144; cv=none; b=ceWgvlsySdWOTlzuRNX3i1dQRTy7Tkwszndh9oxI834ytwGamxGmOMRZFy9f1E30zJxRXOpZ5FH/5xIBYlk08VA4QpO/kHdKUBQULiEyB7SU0qBgc87mSCn+2cpMQRLiHSZ5w3HCMVPMYwpalSY8ByInP2GbQT2RuvuSljd2ib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427144; c=relaxed/simple;
	bh=P2vh+m9vhD1yAdcrkyN5OCEwpU4OB1uR33RNwjIcCqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuaiU4O2uQhEbbwEzLr29RQ++gW6ICsENROKKtaL50IEYu7aDHnhlgNtuyjQnev+CQL1fJp64COffeUlvxYhYE1M5jpGH1+fIahdtXgTcCvtEDS+1iKJKAfF71xQP2I7Jhd6XoJLwuB88vShQ91Y24FLm28jDSp6HODreHyhhz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=PpaZZFb+; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="PpaZZFb+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3iVwswjto9RaOm5tJDfms1F+b1ffPI54hyW7yLXRnjg=; t=1789427143; x=1790291143; 
	b=PpaZZFb+6YDZRtdkKKkYpngEOaV5971aKgYbE4wKM/8qFmLt+re19hZlx98FKwysV+b2cnSKil5
	C3d870qVZLSE2p6I6T/2G88Peyl6eq798XkcUqY5HT9nizhJ42txAZ+KNrceqt2UbePSC3xPQss+Y
	SRms5JxxKqW+NPPaNaFJZBSRBgFqmRP+SyHKLLCk5rtpZ7IFDeT0Rmwm/ceb3zw4OeQ2PVscSvVlo
	aaiBUI/G4b87o7F6N9FhranZn5uKNCaGX8r+ssN17OtImWdFeUZ7Eu5+m/zCURCyOoux8UvJqA3NQ
	ip6azLQOgMPuAzY3Yu4TCBGLoWGadTSnFymA==;
Received: from ouster448.stanford.edu ([172.24.72.71]:60752 helo=cs.stanford.edu)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1x6Fk5-0007WN-AF; Mon, 14 Sep 2026 16:05:42 -0700
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
Subject: [PATCH net-next v11 08/15] net: homa: create homa_interest.h and homa_interest.c
Date: Mon, 14 Sep 2026 16:05:08 -0700
Message-ID: <20260914230517.1190-9-ouster@cs.stanford.edu>
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
X-Spam-Score: -101.0
X-Scan-Signature: d6ed69fe359c6065cef900a7b1f0f3b8

These files implement the homa_interest struct, which is used to
wait for incoming messages.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v20:
* Refactor outbound message management:
  * Outbound message data is now buffered in kernel pages that are
    independent of skbs; skbs are then created "just in time" that
    share access to those pages.
  * This eliminates the need for Homa to retain references to skb's
    after they have been passed to ip*xmit.
* Fix use-after-free race.
* Abort polling loop in homa_interest_wait if there is a signal.
* Clean up APIs: introduce new function homa_interest_notify_shared, move
  functionality from homa_wait_shared to homa_interest_wait

Changes for v18:
* Fix minor issues with indentation and lockdep annotations

Changes for v14:
* Fix race in homa_wait_shared (an RPC could get lost if it became
  ready at the same time that homa_interest_wait returned with an error)
* Remove nonblocking parameter from homa_interest_wait (handle this elsewhere)

Changes for v11:
* Clean up sparse annotations

Changes for v10: none

Changes for v9:
* Remove unused field homa_interest->core
---
 net/homa/homa_interest.c | 192 +++++++++++++++++++++++++++++++++++++++
 net/homa/homa_interest.h |  92 +++++++++++++++++++
 2 files changed, 284 insertions(+)
 create mode 100644 net/homa/homa_interest.c
 create mode 100644 net/homa/homa_interest.h

diff --git a/net/homa/homa_interest.c b/net/homa/homa_interest.c
new file mode 100644
index 000000000000..66ea429aac27
--- /dev/null
+++ b/net/homa/homa_interest.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0+
+
+/* This file contains functions for managing homa_interest structs. */
+
+#include "homa_impl.h"
+#include "homa_interest.h"
+#include "homa_rpc.h"
+#include "homa_sock.h"
+
+/* DESIGN NOTES:
+ * The key idea behind the design of the interest mechanism is to reduce usage
+ * of socket locks while handing off ready RPCs to application threads. Private
+ * handoffs do not require the socket lock to be acquired at all. Shared
+ * handoffs must acquire the socket lock to select one thread from a pool of
+ * waiting threads. But in the normal case the thread receiving the ready RPC
+ * does not need to acquire the socket lock again after the RPC has been
+ * handed off to it. The HOMA_INTEREST_HANDOFF_ACTIVE mechanism eliminates
+ * races that would otherwise be present in the absence of locking.
+ */
+
+/**
+ * homa_interest_init_shared() - Initialize an interest and queue it up on
+ * a socket.
+ * @interest:  Interest to initialize
+ * @hsk:       Socket on which the interests should be queued. Must be locked
+ *             by caller.
+ */
+void homa_interest_init_shared(struct homa_interest *interest,
+			       struct homa_sock *hsk)
+	__must_hold(hsk->lock)
+{
+	interest->rpc = NULL;
+	atomic_set(&interest->state, 0);
+	interest->blocked = 0;
+	init_waitqueue_head(&interest->wait_queue);
+	interest->hsk = hsk;
+	list_add(&interest->links, &hsk->interests);
+}
+
+/**
+ * homa_interest_init_private() - Initialize an interest that will wait
+ * on a particular (private) RPC, and link it to that RPC.
+ * @interest:   Interest to initialize.
+ * @rpc:        RPC to associate with the interest. Must be private, and
+ *              caller must have locked it.
+ *
+ * Return:      0 for success, otherwise a negative errno.
+ */
+int homa_interest_init_private(struct homa_interest *interest,
+			       struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	if (rpc->private_interest)
+		return -EINVAL;
+
+	interest->rpc = rpc;
+	atomic_set(&interest->state, 0);
+	interest->blocked = 0;
+	init_waitqueue_head(&interest->wait_queue);
+	interest->hsk = rpc->hsk;
+	INIT_LIST_HEAD(&interest->links);
+	rpc->private_interest = interest;
+	return 0;
+}
+
+/**
+ * homa_interest_wait() - Wait for an interest to have an actionable RPC,
+ * or for an error to occur.
+ * @interest:     Interest to wait for; must previously have been initialized
+ *                and linked to a socket or RPC. On return, the interest
+ *                will have been unlinked if it is shared and its ready flag
+ *                is set; otherwise it may still be linked.
+ *
+ * Return: 0 for success (the ready flag is set in the interest), or -EINTR
+ * if the thread received an interrupt. When this function returns, the
+ * interest will no longer be linked to a socket (if it ever was).
+ */
+int homa_interest_wait(struct homa_interest *interest)
+{
+	struct homa_sock *hsk = interest->hsk;
+	int result = 0;
+	int iteration;
+	int wait_err;
+
+	interest->blocked = 0;
+
+	/* This loop iterates in order to poll and/or reap dead RPCS. */
+	for (iteration = 0; ; iteration++) {
+		if (iteration != 0)
+			/* Give NAPI/SoftIRQ tasks a chance to run. */
+			schedule();
+
+		if (atomic_read_acquire(&interest->state) & HOMA_INTEREST_READY)
+			goto done;
+
+		if (signal_pending(current)) {
+			wait_err = -ERESTARTSYS;
+			goto check_err;
+		}
+
+		/* See if we can cleanup dead RPCs while waiting. */
+		if (homa_rpc_reap(hsk) != 0)
+			continue;
+
+		break;
+	}
+
+	interest->blocked = 1;
+	wait_err = wait_event_interruptible_exclusive(interest->wait_queue,
+						      atomic_read_acquire(&interest->state) &
+						      HOMA_INTEREST_READY);
+
+check_err:
+	if (wait_err == -ERESTARTSYS) {
+		int ready;
+
+		/* An interrupt occurred. We have to do two things.  First,
+		 * unlink the interest from the socket (if it was linked).
+		 * Second, check to see if in the meantime the interest
+		 * received a handoff. If so, ignore the interrupt. Must hold
+		 * the socket lock while checking, in order to eliminate races
+		 * with homa_rpc_handoff. Technically these are only needed
+		 * for shared interests, but it's harmless to do them for
+		 * private interests as well.
+		 */
+		homa_sock_lock(hsk);
+		list_del_init(&interest->links);
+		ready = atomic_read_acquire(&interest->state) &
+			HOMA_INTEREST_READY;
+		homa_sock_unlock(hsk);
+		if (ready == 0)
+			result = -EINTR;
+	}
+
+done:
+	/* Make sure that the handing off thread has completely finished
+	 * accessing the interest, so that it's safe for our caller to
+	 * reuse the interest's memory.
+	 */
+	while (atomic_read(&interest->state) & HOMA_INTEREST_HANDOFF_ACTIVE)
+		cpu_relax();
+	return result;
+}
+
+/**
+ * homa_interest_notify_private() - If a thread is waiting on the private
+ * interest for an RPC, wake it up.
+ * @rpc:      RPC that may (potentially) have a private interest. Must be
+ *            locked by the caller.
+ */
+void homa_interest_notify_private(struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	if (rpc->private_interest) {
+		/* See comment in homa_interest_notify_shared. */
+		atomic_set_release(&rpc->private_interest->state,
+				   HOMA_INTEREST_READY |
+				   HOMA_INTEREST_HANDOFF_ACTIVE);
+		wake_up(&rpc->private_interest->wait_queue);
+		atomic_set_release(&rpc->private_interest->state,
+				   HOMA_INTEREST_READY);
+	}
+}
+
+/**
+ * homa_interest_notify_shared() - Hand an RPC off to one of the interests
+ * available for a socket.
+ * @hsk:      Socket for the handoff; must have at least one interest.
+ *            Must be locked by caller.
+ * @rpc:      RPC to handoff; can be NULL to indicate that the socket
+ *            has been shutdown. Caller must have taken a reference.
+ */
+void homa_interest_notify_shared(struct homa_sock *hsk, struct homa_rpc *rpc)
+	__must_hold(hsk->lock)
+{
+	struct homa_interest *interest;
+
+	interest = list_first_entry(&hsk->interests,
+				    struct homa_interest, links);
+	list_del_init(&interest->links);
+	interest->rpc = rpc;
+
+	/* The dance below eliminates two race conditions: (a) a waking up
+	 * thread doesn't see the change to state and (b) a waking up thread
+	 * recycles the memory of the interest before we have finished
+	 * accessing it in wake_up.
+	 */
+	atomic_set_release(&interest->state,
+			   HOMA_INTEREST_READY | HOMA_INTEREST_HANDOFF_ACTIVE);
+	wake_up(&interest->wait_queue);
+	atomic_set_release(&interest->state, HOMA_INTEREST_READY);
+}
diff --git a/net/homa/homa_interest.h b/net/homa/homa_interest.h
new file mode 100644
index 000000000000..cb0b3f0d4f18
--- /dev/null
+++ b/net/homa/homa_interest.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0+ */
+
+/* This file defines struct homa_interest and related functions.  */
+
+#ifndef _HOMA_INTEREST_H
+#define _HOMA_INTEREST_H
+
+#include "homa_rpc.h"
+#include "homa_sock.h"
+
+/**
+ * struct homa_interest - Holds info that allows applications to wait for
+ * incoming RPC messages. An interest can be either private, in which case
+ * the application is waiting for a single specific RPC response and the
+ * interest is referenced by an rpc->private_interest, or shared, in which
+ * case the application is waiting for any incoming message that isn't
+ * private and the interest is present on hsk->interests.
+ */
+struct homa_interest {
+	/**
+	 * @rpc: If ready is set, then this holds an RPC that needs
+	 * attention, or NULL if this is a shared interest and hsk has
+	 * been shutdown. If ready is not set, this will be NULL if the
+	 * interest is shared; if it's private, it holds the RPC the
+	 * interest is associated with. If non-NULL, a reference has been
+	 * taken on the RPC.
+	 */
+	struct homa_rpc *rpc;
+
+	/**
+	 * @state: Used to manage the process of handing off an RPC.  Consists
+	 * of the following bits:
+	 * HOMA_INTEREST_READY:
+	 *     Nonzero means the interest is ready for attention: either there
+	 *     is an RPC that needs attention or @hsk has been shutdown.
+	 * HOMA_INTEREST_HANDOFF_ACTIVE:
+	 *     Nonzero means a handing-off thread is still accessing the
+	 *     interest. Used to ensure that the handing-off thread is
+	 *     completely finished before homa_interest_wait returns (so
+	 *     that the interest can safely be deleted).
+	 */
+#define HOMA_INTEREST_READY           1
+#define HOMA_INTEREST_HANDOFF_ACTIVE  2
+	atomic_t state;
+
+	/**
+	 * @blocked: Zero means a handoff was received without the thread
+	 * needing to block; nonzero means the thread blocked.
+	 */
+	int blocked;
+
+	/**
+	 * @wait_queue: Used to block the thread while waiting (will never
+	 * have more than one queued thread).
+	 */
+	struct wait_queue_head wait_queue;
+
+	/** @hsk: Socket that the interest is associated with. */
+	struct homa_sock *hsk;
+
+	/**
+	 * @links: If the interest is shared, used to link this object into
+	 * @hsk->interests.
+	 */
+	struct list_head links;
+};
+
+/**
+ * homa_interest_unlink_private() - Detach a private interest from its
+ * RPC. Note: this can race with homa_rpc_handoff, so on return it's
+ * possible that the interest is ready.
+ * @interest:    Interest to remove. Must have been initialized with
+ *               homa_interest_init_private. Its RPC must be locked by
+ *               the caller.
+ */
+static inline void homa_interest_unlink_private(struct homa_interest *interest)
+	__must_hold(interest->rpc->bucket->lock)
+{
+	if (interest == interest->rpc->private_interest)
+		interest->rpc->private_interest = NULL;
+}
+
+void     homa_interest_init_shared(struct homa_interest *interest,
+				   struct homa_sock *hsk);
+int      homa_interest_init_private(struct homa_interest *interest,
+				    struct homa_rpc *rpc);
+void     homa_interest_notify_private(struct homa_rpc *rpc);
+void     homa_interest_notify_shared(struct homa_sock *hsk,
+				     struct homa_rpc *rpc);
+int      homa_interest_wait(struct homa_interest *interest);
+
+#endif /* _HOMA_INTEREST_H */
-- 
2.43.0

