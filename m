Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98993AB26D
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427155; cv=none; b=BSanTdhqavwiZKRA3I8PKRx3257BGJzFEDRPe3giD+Khdkp3gHAJVgQ/2FCPccDsQuP2qfo/iLOBnrexKYal0Y+93K9NkwrbnrkCYQZ4Nv2MOVRuoOWvl9naW/0VuqdDSEgYuwuUwjRMZ1l6cWeDoa9Jrpzr4zLCxHX6tsBYuT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427155; c=relaxed/simple;
	bh=7bwGCcCm2p3Hbog7niq/kPCAqECm26Amgn9ZTRxAdvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9dNUfAzYpYdTIwVsqlJ5duiIjcQIQBfRyocKEOOIPm6QGYuqxLnDCdmLxN5M9zsUD0Ky1znPXURTbz6I9Go4jYgcQ8ZNq310HQgYvBhOpHVUmHJls0RM4fTDmtsb1iLa8pIoERJYWJWxQeikoIl7sT91bcAB18yaSSI296k7jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Mx/vrt02; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Mx/vrt02"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DHbPp9e93ZkM/qZlqQs3SB7XCqVenKYVe78kva9zLXQ=; t=1789427153; x=1790291153; 
	b=Mx/vrt02hPPs3QG+ndqJHxr8BjXSEvJLxuLZSDHg7SSBhtuUCOc7xsRXRQM3Y6Fhz5McnegVsU0
	RAtP+uahg3J3IWrUGouVGlao/Y0vZo1ZkQ7/qmmD9M3rdySuW8TUKFNdGMfP2NRbi0b/uQKhJST28
	3lUSJAZ2jAF/+eLqSaxsZk7n0nhi5VNNdMlsGIkQzr1Ge8bIdXDwjskYb+xPiv3hZY3QgM6UeE6VK
	NWo5lgNWlbNR9WqbupUaWbwm+Ke/KXyhE5BhF0NGQuC9QGg45Q7J9l7qkqKM6VhY+2WZ2xEuwJqFG
	Jv6niCaMFDevGrJEqvn6c4cMGkSsa+lOTq3A==;
Received: from ouster448.stanford.edu ([172.24.72.71]:60752 helo=cs.stanford.edu)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1x6FkG-0007WN-H7; Mon, 14 Sep 2026 16:05:53 -0700
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
Subject: [PATCH net-next v11 13/15] net: homa: create homa_timer.c
Date: Mon, 14 Sep 2026 16:05:13 -0700
Message-ID: <20260914230517.1190-14-ouster@cs.stanford.edu>
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
X-Scan-Signature: 3c26e552a1044023835a40b863ebedfd

This file contains code that wakes up periodically to check for
missing data, initiate retransmissions, and declare peer nodes
"dead".

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v20:
* Separate routing information (flows and dst_entry's) from the homa_peer
  struct: there can be multiple routes to a single peer.
* Don't hold locks while transmitting packets.
* Refactor outbound message management:
  * Outbound message data is now buffered in kernel pages that are
    independent of skbs; skbs are then created "just in time" that
    share access to those pages.
  * This eliminates the need for Homa to retain references to skb's
    after they have been passed to ip*xmit.

Changes for v14:
* Use new homa_rpc_tx_end function

Changes for v11:
* Cleanup sparse annotations.

Changes for v10:
* Refactor resend mechanism

Changes for v9:
* Reflect changes in socket and peer management
* Minor name changes for clarity

Changes for v7:
* Interface changes to homa_sock_start_scan etc.
* Remove locker argument from locking functions
* Use u64 and __u64 properly
---
 net/homa/homa_impl.h  |   3 +
 net/homa/homa_timer.c | 136 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100644 net/homa/homa_timer.c

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
index 831422ffbc11..fcb5d7cfc8a8 100644
--- a/net/homa/homa_impl.h
+++ b/net/homa/homa_impl.h
@@ -385,6 +385,9 @@ void     homa_rpc_handoff(struct homa_rpc *rpc);
 int      homa_rpc_tx_end(struct homa_rpc *rpc);
 struct sk_buff *__homa_skb_alloc(int length);
 void     homa_spin(int ns);
+void     homa_timer(struct homa *homa);
+void     homa_timer_check_rpc(struct homa_rpc *rpc);
+int      homa_timer_main(void *transport);
 int      homa_tx_copy_from_user(struct homa_rpc *rpc, struct iov_iter *iter,
 				bool xmit);
 struct sk_buff *homa_tx_skb_alloc(struct homa_rpc *rpc, u32 offset, u32 *end);
diff --git a/net/homa/homa_timer.c b/net/homa/homa_timer.c
new file mode 100644
index 000000000000..2fa86f523088
--- /dev/null
+++ b/net/homa/homa_timer.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0+
+
+/* This file handles timing-related functions for Homa, such as retries
+ * and timeouts.
+ */
+
+#include "homa_impl.h"
+#include "homa_peer.h"
+#include "homa_rpc.h"
+#include "homa_tx_pool.h"
+
+/**
+ * homa_timer_check_rpc() -  Invoked for each RPC during each timer pass; does
+ * most of the work of checking for time-related actions such as sending
+ * resends, aborting RPCs for which there is no response, and sending
+ * requests for acks. It is separate from homa_timer because homa_timer
+ * got too long and deeply indented.
+ * @rpc:     RPC to check; must be locked by the caller.
+ */
+void homa_timer_check_rpc(struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	struct homa *homa = rpc->hsk->homa;
+	int tx_end = homa_rpc_tx_end(rpc);
+
+	/* See if we need to request an ack for this RPC. */
+	if (!homa_is_client(rpc->id) && rpc->state == RPC_OUTGOING &&
+	    tx_end == rpc->msgout.length) {
+		if (rpc->done_timer_ticks == 0) {
+			rpc->done_timer_ticks = homa->timer_ticks;
+		} else {
+			/* >= comparison that handles tick wrap-around. */
+			if ((rpc->done_timer_ticks + homa->request_ack_ticks
+					- 1 - homa->timer_ticks) & 1 << 31) {
+				struct homa_need_ack_hdr h;
+
+				homa_xmit_control(NEED_ACK, &h, sizeof(h), rpc);
+			}
+		}
+	}
+
+	if (rpc->state == RPC_INCOMING) {
+		if (rpc->msgin.num_bpages == 0) {
+			/* Waiting for buffer space, so no problem. */
+			rpc->silent_ticks = 0;
+			return;
+		}
+	} else if (!homa_is_client(rpc->id)) {
+		/* We're the server and we've received the input message;
+		 * no need to worry about retries.
+		 */
+		rpc->silent_ticks = 0;
+		return;
+	}
+
+	if (rpc->state == RPC_OUTGOING) {
+		if (tx_end < rpc->msgout.length) {
+			/* There are granted bytes that we haven't transmitted,
+			 * so no need to be concerned; the ball is in our court.
+			 */
+			rpc->silent_ticks = 0;
+			return;
+		}
+	}
+
+	if (rpc->silent_ticks < homa->resend_ticks)
+		return;
+	if (rpc->silent_ticks >= homa->timeout_ticks) {
+		homa_rpc_abort(rpc, -ETIMEDOUT);
+		return;
+	}
+	if (((rpc->silent_ticks - homa->resend_ticks) % homa->resend_interval)
+			== 0)
+		homa_request_retrans(rpc);
+}
+
+/**
+ * homa_timer() - This function is invoked at regular intervals ("ticks")
+ * to implement retries and aborts for Homa.
+ * @homa:    Overall data about the Homa protocol implementation.
+ */
+void homa_timer(struct homa *homa)
+{
+	struct homa_socktab_scan scan;
+	struct homa_sock *hsk;
+	struct homa_rpc *rpc;
+	int rpc_count = 0;
+
+	homa->timer_ticks++;
+
+	/* Scan all existing RPCs in all sockets. */
+	for (hsk = homa_socktab_start_scan(homa->socktab, &scan);
+			hsk; hsk = homa_socktab_next(&scan)) {
+		while (hsk->dead_frags > homa->dead_frags_limit)
+			/* If we get here, it means that Homa isn't keeping
+			 * up with RPC reaping, so we'll help out.  See
+			 * "RPC Reaping Strategy" in homa_rpc_reap code for
+			 * details.
+			 */
+			if (homa_rpc_reap(hsk) == 0)
+				break;
+
+		if (list_empty(&hsk->active_rpcs) || hsk->shutdown)
+			continue;
+
+		if (!homa_protect_rpcs(hsk))
+			continue;
+		rcu_read_lock();
+		list_for_each_entry_rcu(rpc, &hsk->active_rpcs, active_links) {
+			homa_rpc_lock(rpc);
+			if (rpc->state == RPC_IN_SERVICE) {
+				rpc->silent_ticks = 0;
+				homa_rpc_unlock(rpc);
+				continue;
+			}
+			rpc->silent_ticks++;
+			homa_timer_check_rpc(rpc);
+			homa_rpc_unlock(rpc);
+			rpc_count++;
+			if (rpc_count >= 10) {
+				/* Give other kernel threads a chance to run
+				 * on this core.
+				 */
+				rcu_read_unlock();
+				schedule();
+				rcu_read_lock();
+				rpc_count = 0;
+			}
+		}
+		rcu_read_unlock();
+		homa_unprotect_rpcs(hsk);
+	}
+	homa_socktab_end_scan(&scan);
+	homa_tx_pool_gc(homa);
+	homa_route_gc(homa->peertab);
+}
-- 
2.43.0

