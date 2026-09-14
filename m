Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533013AD515
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427152; cv=none; b=auGqesy3leStoe55ABzIrx9ft5oJjIEZFCpsWvh+BhUdaAzWrOiOV+rBn3nDeVLEEBRTB9n1XyaW0Pxj/4GFjZLVuDc60/+qTfNQDg8FG10kdMVNpM7nkM0Xv/mqYS/PCTqyJnDX5QcnfRseuktzGg8bPYBl1y7b/nQar/PXoBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427152; c=relaxed/simple;
	bh=ChqhKr9N0bz/jqfYec3CF5Mpt1Zm6pTIJBbdQZSi8ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/u7ASmYDn5i/LK7f6q94GEcturSZJCr01rxK+83H7YC682rQ6rQ3q47fEIID3uPizkz6zeuWYcxetEkJcX715fjq2IkgkzGUaoz9wPxxJsWVoA0EQGl/f6FC45kHEz8oCNI+5AVBB5+dOQdagWu+86p2qeDSMI+qZOXESSh6j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=oyzjLeXo; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="oyzjLeXo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Dw2FI5KmbEpIwarvAJ6wdvPW3UmuiyAbAvmk4i2Zh8k=; t=1789427149; x=1790291149; 
	b=oyzjLeXouDj1Cnzi/uXvOxp9HOBMmVsyIEyA0kBfZ1bEVDkTjB4aJ+TlTXJFsM21EUDErpeOFsv
	wXrrc7Zdpx3U/6xRnANx8Dg0/EfrJSNNehM+Q832R4a8GTmo8t+9cM5MD0gDK6cFMOSD0JABa7b0d
	XOLWRP7e5KgCCXEyuX3CwBrEC9HPZbCmMA8sPyyE1LbOrmVGjcwlEz61iT4qy32ivMlMOUkkHJwIb
	/farO9kmfxs0kFrxpMDfPgoKBbecahWI6FGK2HWBT/HEFBo08AHCL6kLDSMUR8Ku7F43xZnJgG0PE
	enA9qFKLFYD00L4m+jvJIs6DYlvpY4Y11/1w==;
Received: from ouster448.stanford.edu ([172.24.72.71]:60752 helo=cs.stanford.edu)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1x6FkA-0007WN-Go; Mon, 14 Sep 2026 16:05:48 -0700
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
Subject: [PATCH net-next v11 10/15] net: homa: create homa_outgoing.c
Date: Mon, 14 Sep 2026 16:05:10 -0700
Message-ID: <20260914230517.1190-11-ouster@cs.stanford.edu>
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
X-Scan-Signature: b2a73d6ad1d5d1abdb6c0a717d3468da

This file does most of the work of transmitting outgoing messages.
It is also responsible for copying data from user space into kernel
memory.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v20:
* Refactor outbound message management:
  * Outbound message data is now buffered in kernel pages that are
    independent of skbs; skbs are then created "just in time" that
    share access to those pages.
  * This eliminates the need for Homa to retain references to skb's
    after they have been passed to ip*xmit.
* Separate routing information (flows and dst_entry's) from the homa_peer
  struct: there can be multiple routes to a single peer.
* Don't hold locks while transmitting packets.
* When detecting IPv4 vs. IPv6, prefer info in addresses rather than info
  from the socket; this moves Homa closer to allowing dual-stack IPv6
  sockets.
* Zero out packet headers to avoid leaking kernel data to the network.

Changes for v18:
* Make sure unused fields in outgoing skbs are always zeroed.
* Use new API for homa_set_doff.

Changes for v16:
* Set hsk->error_msg (for HOMAIOCINFO)
* Refactor pipelining mechanism in homa_message_out_fill
* Retain retransmitted packets until homa_rpc_reap (to ensure that RPCs
  don't get reaped with retransmitted packets still in the tx pipeline)

Changes for v14:
* Implement homa_rpc_tx_end function

Changes for v13:
* Fix bug in homa_resend_data: wasn't fully initializing new skb.
* Fix bug in homa_tx_data_pkt_alloc: wasn't allocating enough space
  in the new skb.

Changes for v12:
* Move RPC_DEAD check in homa_xmit_data to eliminate window for
  more complete coverage.

Changes for v11:
* Cleanup and simplify use of RPC reference counts.

Changes for v10:
* Revise sparse annotations to eliminate __context__ definition
* Remove log messages after alloc errors

Changes for v9:
* Use new homa_clock abstraction layer
* Various name improvements (e.g. use "alloc" instead of "new" for functions
  that allocate memory)
* Eliminate sizeof32 define: use sizeof instead

Changes for v7:
* Implement accounting for bytes in tx skbs
* Rename UNKNOWN packet type to RPC_UNKNOWN
* Use new RPC reference counts; eliminates need for RCU
* Remove locker argument from locking functions
* Use u64 and __u64 properly
* Fix incorrect skb check in homa_message_out_fill
---
 net/homa/homa_impl.h     |  11 +
 net/homa/homa_outgoing.c | 537 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 548 insertions(+)
 create mode 100644 net/homa/homa_outgoing.c

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
index 7c87d517aae7..d52b6a631b0c 100644
--- a/net/homa/homa_impl.h
+++ b/net/homa/homa_impl.h
@@ -363,10 +363,21 @@ static inline bool homa_make_header_avl(struct sk_buff *skb)
 
 extern unsigned int homa_net_id;
 
+void     homa_message_out_init(struct homa_rpc *rpc, int length);
+int      homa_resend_data(struct homa_rpc *rpc, int start, int end);
 void     homa_rpc_handoff(struct homa_rpc *rpc);
+int      homa_rpc_tx_end(struct homa_rpc *rpc);
+struct sk_buff *__homa_skb_alloc(int length);
+int      homa_tx_copy_from_user(struct homa_rpc *rpc, struct iov_iter *iter,
+				bool xmit);
+struct sk_buff *homa_tx_skb_alloc(struct homa_rpc *rpc, u32 offset, u32 *end);
+int      homa_tx_skb_send(struct homa_rpc *rpc, u32 offset, u32 *end);
 int      homa_xmit_control(enum homa_packet_type type, void *contents,
 			   size_t length, struct homa_rpc *rpc);
+int      __homa_xmit_control(void *contents, size_t length,
+			     struct homa_route *route, struct homa_sock *hsk);
 void     homa_xmit_data(struct homa_rpc *rpc);
+void     homa_xmit_unknown(struct sk_buff *skb, struct homa_sock *hsk);
 
 int      homa_message_in_init(struct homa_rpc *rpc, int length);
 
diff --git a/net/homa/homa_outgoing.c b/net/homa/homa_outgoing.c
new file mode 100644
index 000000000000..afc7c034d145
--- /dev/null
+++ b/net/homa/homa_outgoing.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0+
+
+/* This file contains functions related to the sender side of message
+ * transmission. It also contains utility functions for sending packets.
+ */
+
+#include "homa_impl.h"
+#include "homa_peer.h"
+#include "homa_rpc.h"
+#include "homa_tx_pool.h"
+#include "homa_wire.h"
+
+/**
+ * homa_message_out_init() - Initialize rpc->msgout. This function doesn't
+ * read data from user space or create sk_buffs, but it sets up information
+ * such as the message geometry.
+ * @rpc:       RPC whose output message should be initialized. Must be
+ *             locked by caller. Fields in rpc->msgout should have been
+ *             zeroed by the caller.
+ * @length:    Number of bytes that will eventually be in rpc->msgout.
+ */
+void homa_message_out_init(struct homa_rpc *rpc, int length)
+	__must_hold(rpc->bucket->lock)
+{
+	struct dst_entry *dst;
+	u64 max_segs;
+	int mtu;
+
+	memset(&rpc->msgout, 0, sizeof(rpc->msgout));
+	rpc->msgout.length = length;
+	rpc->msgout.init_time = homa_clock();
+
+	/* Compute the geometry of packets. */
+	rcu_read_lock();
+	dst = rcu_dereference(rpc->route->dst);
+	mtu = dst_mtu(dst);
+	rpc->msgout.max_seg_data = mtu - rpc->hsk->ip_header_length -
+				   sizeof(struct homa_data_hdr);
+	max_segs = min_t(u32, rpc->hsk->homa->max_gso_size,
+			 dst->dev->gso_max_size) -
+		   (sizeof(struct homa_data_hdr) + HOMA_SKB_EXTRA);
+	do_div(max_segs, rpc->msgout.max_seg_data +
+			 sizeof(struct homa_seg_hdr));
+	if (max_segs > dst->dev->gso_max_segs)
+		max_segs = dst->dev->gso_max_segs;
+	if (max_segs < 1)
+		max_segs = 1;
+	rpc->msgout.max_gso_segs = max_segs;
+	rpc->msgout.max_gso_data = max_segs * rpc->msgout.max_seg_data;
+	rcu_read_unlock();
+}
+
+/**
+ * homa_tx_copy_from_user() - Copy outbound message data for an RPC from
+ * user space into kernel memory and (possibly) start transmitting packets.
+ * @rpc:      RPC whose tx message is to be copied.
+ * @iter:     Describes the location in user space of the message
+ *            data.
+ * @xmit:     True means this function should also start transmitting packets.
+ *            False means only copy data; don't transmit packets.
+ * Return:    Zero for success, otherwise a negative errno.
+ */
+int homa_tx_copy_from_user(struct homa_rpc *rpc, struct iov_iter *iter,
+			   bool xmit)
+	__must_hold(rpc->bucket->lock)
+{
+	struct homa_frag_filler filler;
+	int err, hdr_space;
+	u64 num_segs;
+	int offset;
+
+	homa_message_out_init(rpc, iter->count);
+
+	/* Allocate kernel memory to hold the message data (note that we
+	 * need to allocate extra space for homa_seg_hdrs).
+	 */
+	num_segs = rpc->msgout.length + rpc->msgout.max_seg_data - 1;
+	do_div(num_segs, rpc->msgout.max_seg_data);
+	hdr_space = num_segs * sizeof(struct homa_seg_hdr);
+	rpc->msgout.frags = &rpc->msgout.frag;
+	rpc->msgout.num_frags = 1;
+	err = homa_tx_pool_alloc(rpc->hsk->homa, rpc->msgout.length + hdr_space,
+				 &rpc->msgout.num_frags, &rpc->msgout.frags);
+	if (err != 0)
+		return err;
+	rpc->msgout.frag_bytes = rpc->msgout.length + hdr_space;
+	refcount_add(rpc->msgout.frag_bytes, &rpc->hsk->sock.sk_wmem_alloc);
+
+	/* Copy the data in from user space, preceding each segment of data
+	 * with its homa_seg_hdr.
+	 */
+	homa_rpc_unlock(rpc);
+	homa_frag_filler_init(&filler, rpc->msgout.num_frags,
+			      rpc->msgout.frags);
+	offset = 0;
+	while (offset < rpc->msgout.length) {
+		int seg_size = min(rpc->msgout.length - offset,
+				   rpc->msgout.max_seg_data);
+		struct homa_seg_hdr seg_hdr;
+
+		seg_hdr.offset = htonl(offset);
+		err = homa_copy_to_frags(&filler, &seg_hdr, sizeof(seg_hdr));
+		if (unlikely(err != 0))
+			goto done;
+		err = homa_copy_iter_to_frags(&filler, iter, seg_size);
+		if (unlikely(err != 0))
+			goto done;
+		offset += seg_size;
+
+		/* Make sure that anyone seeing a change in copied_from_user
+		 * also sees related changes to rpc->msgout.
+		 */
+		smp_store_release(&rpc->msgout.copied_from_user, offset);
+	}
+
+done:
+	homa_rpc_lock(rpc);
+	if (xmit && err == 0)
+		homa_xmit_data(rpc);
+	return err;
+}
+
+/**
+ * __homa_skb_alloc() - Allocate a new (empty) sk_buff for use in transmitting
+ * data or control info.
+ * @length:       Number of bytes of data that the caller would like to
+ *                have available in the linear part of the sk_buff for
+ *                the Homa header and additional data beyond that. This
+ *                function will allocate additional space for IP and
+ *                Ethernet headers, as well as for the homa_skb_info.
+ * Return:        New sk_buff, or NULL if there was insufficient memory.
+ *                The sk_buff will be configured so that the next
+ *                skb_put will be for the transport (Homa) header. The
+ *                homa_skb_info is not initialized.
+ */
+struct sk_buff *__homa_skb_alloc(int length)
+{
+	struct sk_buff *skb;
+
+	skb = alloc_skb(HOMA_SKB_EXTRA + sizeof(struct homa_skb_info) + length,
+			GFP_ATOMIC);
+	if (likely(skb)) {
+		skb_reserve(skb, HOMA_SKB_EXTRA);
+		skb_reset_transport_header(skb);
+	}
+	return skb;
+}
+
+/**
+ * homa_tx_skb_alloc() - Create an outgoing data packet for a Homa message.
+ * @rpc:      RPC for the message. Its @msgout must have been initialized
+ *            (e.g. the packet geometry will be determined by information
+ *            in @rpc->msgout).
+ * @offset:   Offset within the message of the first byte of data for
+ *            this packet.
+ * @end:      Offset within the message of the byte just after the last
+ *            one to include in this packet. The skb may actually end either
+ *            before or after this offset; this value is modified to hold
+ *            the actual end.
+ * Return:    A pointer to the sk_buff, or a negative errno for error.
+ */
+struct sk_buff *homa_tx_skb_alloc(struct homa_rpc *rpc, u32 offset, u32 *end)
+	__must_hold(rpc->bucket->lock)
+{
+	int msg_frags_left, bytes_left, bytes_to_skip, rem;
+	struct homa_sock *hsk = rpc->hsk;
+	struct homa_skb_info *homa_info;
+	skb_frag_t *msg_frag, *skb_frag;
+	struct skb_shared_info *shinfo;
+	u64 seg_index, num_segs;
+	struct homa_data_hdr *h;
+	struct sk_buff *skb;
+	int err;
+
+	if (offset >= rpc->msgout.length)
+		return ERR_PTR(-EINVAL);
+	if (*end > rpc->msgout.length)
+		*end = rpc->msgout.length;
+
+	/* Find the location within rpc->msgin.frags of the data for the
+	 * first segment to output (skipping its homa_seg_hdr, since that
+	 * will be in the linear part of the skb). Also, round offset down
+	 * to the start of its segment.
+	 */
+	seg_index = offset;
+	rem = do_div(seg_index, rpc->msgout.max_seg_data);
+	offset -= rem;
+	bytes_to_skip = seg_index * (rpc->msgout.max_seg_data +
+				     sizeof(struct homa_seg_hdr)) +
+			sizeof(struct homa_seg_hdr);
+	for (msg_frags_left = rpc->msgout.num_frags,
+	     msg_frag = rpc->msgout.frags; ; msg_frags_left--, msg_frag++) {
+		if (bytes_to_skip < skb_frag_size(msg_frag))
+			break;
+		bytes_to_skip -= skb_frag_size(msg_frag);
+	}
+
+	/* Compute how much data from rpc->msgout.frags to include in the
+	 * packet.
+	 */
+	num_segs = *end - offset + rpc->msgout.max_seg_data - 1;
+	do_div(num_segs, rpc->msgout.max_seg_data);
+	if (num_segs > rpc->msgout.max_gso_segs)
+		num_segs = rpc->msgout.max_gso_segs;
+	bytes_left = num_segs * (rpc->msgout.max_seg_data +
+				 sizeof(struct homa_seg_hdr)) -
+		     sizeof(struct homa_seg_hdr);
+
+	skb = __homa_skb_alloc(sizeof(struct homa_data_hdr));
+	if (unlikely(!skb))
+		return ERR_PTR(-ENOMEM);
+	skb->ooo_okay = 1;
+	shinfo = skb_shinfo(skb);
+
+	/* Fill in the Homa header (which will be replicated in every
+	 * segment by GSO). The header in the linear portion contains the
+	 * homa_seg_hdr for the first fragment.
+	 */
+	h = (struct homa_data_hdr *)skb_put(skb, sizeof(struct homa_data_hdr));
+	memset(h, 0, sizeof(*h));
+	h->common.sport = htons(hsk->port);
+	h->common.dport = htons(rpc->dport);
+	h->common.type = DATA;
+	homa_set_doff(skb, sizeof(struct homa_data_hdr) -
+			   sizeof(struct homa_seg_hdr));
+	h->common.sender_id = cpu_to_be64(rpc->id);
+	h->message_length = htonl(rpc->msgout.length);
+	homa_peer_get_acks(rpc->route->peer, 1, &h->ack);
+	if (offset < rpc->msgout.next_xmit_offset)
+		h->retransmit = 1;
+	h->seg.offset = htonl(offset);
+
+	/* Virtually copy data from rpc->msgout.frags to the skb; each
+	 * iteration of the following loop copies one frag.
+	 */
+	while (bytes_left > 0 && shinfo->nr_frags < MAX_SKB_FRAGS &&
+	       msg_frags_left > 0) {
+		skb_frag_t *skb_frag = &shinfo->frags[shinfo->nr_frags];
+		struct page *page;
+		int frag_bytes;
+
+		frag_bytes = min(skb_frag_size(msg_frag) - bytes_to_skip,
+				 bytes_left);
+		page = skb_frag_page(msg_frag);
+		get_page(page);
+		skb_frag->netmem = page_to_netmem(page);
+		skb_frag->offset = msg_frag->offset + bytes_to_skip;
+		skb_frag_size_set(skb_frag, frag_bytes);
+		skb_len_add(skb, frag_bytes);
+
+		bytes_left -= frag_bytes;
+		bytes_to_skip = 0;
+		msg_frag++;
+		msg_frags_left--;
+		shinfo->nr_frags++;
+	}
+
+	if (bytes_left > 0 && msg_frags_left > 0 &&
+	    shinfo->nr_frags >= MAX_SKB_FRAGS) {
+		/* There wasn't enough fragment space in skb to store all the
+		 * desired segments. Round the skb back to the nearest segment
+		 * boundary.
+		 */
+		while (bytes_left > 0) {
+			bytes_left -= rpc->msgout.max_seg_data +
+				      sizeof(struct homa_seg_hdr);
+			num_segs--;
+		}
+		if (num_segs == 0) {
+			err = -EINVAL;
+			goto error;
+		}
+		while (bytes_left < 0) {
+			skb_frag = &shinfo->frags[shinfo->nr_frags - 1];
+			if (-bytes_left < skb_frag_size(skb_frag)) {
+				skb_frag_size_sub(skb_frag, -bytes_left);
+				skb_len_add(skb, bytes_left);
+				break;
+			}
+			bytes_left += skb_frag_size(skb_frag);
+			skb_len_add(skb, -skb_frag_size(skb_frag));
+			put_page(skb_frag_page(skb_frag));
+			shinfo->nr_frags--;
+		}
+	}
+	*end = min_t(u32, offset + num_segs * rpc->msgout.max_seg_data,
+		     rpc->msgout.length);
+
+	/* Fill in fields in shinfo. */
+	if (num_segs > 1) {
+		shinfo->gso_segs = num_segs;
+		shinfo->gso_size = rpc->msgout.max_seg_data +
+				   sizeof(struct homa_seg_hdr);
+		shinfo->gso_type = (hsk->inet.sk.sk_family ==
+				    AF_INET6) ? SKB_GSO_TCPV6 :
+				    SKB_GSO_TCPV4;
+	}
+
+	/* Initialize homa_skb_info for the packet. */
+	homa_info = homa_get_skb_info(skb);
+	memset(homa_info, 0, sizeof(*homa_info));
+	homa_info->data_bytes = *end - offset;
+	homa_info->dont_defer = false;
+	return skb;
+
+error:
+	kfree_skb_reason(skb, SKB_DROP_REASON_NOT_SPECIFIED);
+	return ERR_PTR(err);
+}
+
+/**
+ * homa_tx_skb_send() - Create and send one (GSO) data packet for an RPC. The
+ * dimensions of the packet transmitted may change from those specified
+ * in the argument depending on factors such as availability of GSO,
+ * MTU, etc.
+ * @rpc:         RPC for which to send the packet. This function releases
+ *               and then re-requires rpc's lock, so the RPC could be
+ *               dead when this function returns.
+ * @offset:      The packet must contain this offset.
+ * @end:         Offset of the message byte just after the last one
+ *               the caller would like included in the packet. Modified
+ *               to hold the offset just after the last byte actually
+ *               included in the packet.
+ * Return:       0 for success, otherwise a negative errno.
+ */
+int homa_tx_skb_send(struct homa_rpc *rpc, u32 offset, u32 *end)
+	__must_hold(rpc->bucket->lock)
+{
+	struct homa_route *route;
+	struct sk_buff *skb;
+	int err;
+
+	skb = homa_tx_skb_alloc(rpc, offset, end);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	/* Note: must update next_xmit_offset here, before releasing the
+	 * RPC lock below; otherwise some other thread might decide to
+	 * transmit the same bytes.
+	 */
+	if (*end > rpc->msgout.next_xmit_offset)
+		rpc->msgout.next_xmit_offset = *end;
+
+	err = homa_route_validate(rpc);
+	if (err != 0) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_IP_OUTNOROUTES);
+		return err;
+	}
+	route = rpc->route;
+
+	/* Take a reference on the route so we can safely use it even after
+	 * the RPC lock has been released (rpc->route may change, but not
+	 * route).
+	 */
+	homa_route_hold(route);
+	homa_rpc_unlock(rpc);
+	err = homa_route_xmit(skb, rpc->hsk, route, 0);
+	homa_route_release(route);
+	homa_rpc_lock(rpc);
+	return err;
+}
+
+/**
+ * homa_xmit_control() - Send a control packet to the other end of an RPC.
+ * @type:      Packet type, such as DATA.
+ * @contents:  Address of buffer containing the contents of the packet.
+ *             Only information after the common header must be valid;
+ *             the common header will be filled in by this function.
+ * @length:    Length of @contents (including the common header).
+ * @rpc:       The packet will go to the socket that handles the other end
+ *             of this RPC. Addressing info for the packet, including all of
+ *             the fields of homa_common_hdr except type, will be set from this.
+ *
+ * Return:     Either zero (for success), or a negative errno value if there
+ *             was a problem.
+ */
+int homa_xmit_control(enum homa_packet_type type, void *contents,
+		      size_t length, struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	struct homa_common_hdr *h = contents;
+	struct homa_route *route;
+	int err;
+
+	memset(h, 0, sizeof(*h));
+	h->type = type;
+	h->sport = htons(rpc->hsk->port);
+	h->dport = htons(rpc->dport);
+	h->sender_id = cpu_to_be64(rpc->id);
+	err = homa_route_validate(rpc);
+	if (err != 0)
+		return err;
+	route = rpc->route;
+
+	/* Must take a reference on route to ensure it persists through
+	 * packet transmission (rpc->route could get replaced once we
+	 * release the RPC lock).
+	 */
+	homa_route_hold(route);
+	homa_rpc_unlock(rpc);
+	err = __homa_xmit_control(contents, length, route, rpc->hsk);
+	homa_route_release(route);
+	homa_rpc_lock(rpc);
+	return err;
+}
+
+/**
+ * __homa_xmit_control() - Lower-level version of homa_xmit_control: sends
+ * a control packet.
+ * @contents:  Address of buffer containing the contents of the packet.
+ *             The caller must have filled in all of the information,
+ *             including the common header.
+ * @length:    Length of @contents.
+ * @route:     Route via which to send packet (includes destination).
+ * @hsk:       Socket via which the packet will be sent.
+ *
+ * Return:     Either zero (for success), or a negative errno value if there
+ *             was a problem.
+ */
+int __homa_xmit_control(void *contents, size_t length, struct homa_route *route,
+			struct homa_sock *hsk)
+{
+	struct homa_common_hdr *h;
+	struct sk_buff *skb;
+	int extra_bytes;
+	int err;
+
+	skb = __homa_skb_alloc(HOMA_MAX_HEADER);
+	if (unlikely(!skb))
+		return -ENOBUFS;
+
+	h = skb_put(skb, length);
+	memcpy(h, contents, length);
+	extra_bytes = HOMA_MIN_PKT_LENGTH - length;
+	if (extra_bytes > 0)
+		memset(skb_put(skb, extra_bytes), 0, extra_bytes);
+	skb->ooo_okay = 1;
+	homa_set_doff(skb, 20);
+	err = homa_route_xmit(skb, hsk, route, 0);
+	return err;
+}
+
+/**
+ * homa_xmit_unknown() - Send an RPC_UNKNOWN packet to a peer.
+ * @skb:         Buffer containing an incoming packet; identifies the peer to
+ *               which the RPC_UNKNOWN packet should be sent.
+ * @hsk:         Socket that should be used to send the RPC_UNKNOWN packet.
+ */
+void homa_xmit_unknown(struct sk_buff *skb, struct homa_sock *hsk)
+{
+	struct homa_common_hdr *h = (struct homa_common_hdr *)skb->data;
+	struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
+	struct homa_rpc_unknown_hdr unknown;
+	struct homa_route *route;
+
+	memset(&unknown, 0, sizeof(unknown));
+	unknown.common.sport = h->dport;
+	unknown.common.dport = h->sport;
+	unknown.common.type = RPC_UNKNOWN;
+	unknown.common.sender_id = cpu_to_be64(homa_local_id(h->sender_id));
+	route = homa_route_get(hsk, &saddr);
+	if (!IS_ERR(route)) {
+		__homa_xmit_control(&unknown, sizeof(unknown), route, hsk);
+		homa_route_release(route);
+	}
+}
+
+/**
+ * homa_xmit_data() - If an RPC has outbound data packets that are permitted
+ * to be transmitted according to the scheduling mechanism, arrange for
+ * them to be sent.
+ * @rpc:       RPC to check for transmittable packets. Must be locked by
+ *             caller.
+ */
+void homa_xmit_data(struct homa_rpc *rpc)
+	__must_hold(rpc->bucket->lock)
+{
+	u32 xmit_offset, end;
+
+	while (rpc->state != RPC_DEAD) {
+		xmit_offset = rpc->msgout.next_xmit_offset;
+
+		/* Don't transmit unless enough data has been copied from user
+		 * space for a maximum-size packet.
+		 */
+		if (xmit_offset + rpc->msgout.max_gso_data >
+		    rpc->msgout.copied_from_user &&
+		    rpc->msgout.copied_from_user < rpc->msgout.length)
+			break;
+
+		if (xmit_offset >= rpc->msgout.length)
+			break;
+		end = rpc->msgout.length;
+		homa_tx_skb_send(rpc, xmit_offset, &end);
+	}
+}
+
+/**
+ * homa_resend_data() - This function is invoked as part of handling RESEND
+ * requests. It retransmits the packet(s) containing a given range of bytes
+ * from a message.
+ * @rpc:      RPC for which data should be resent. Must be locked by caller.
+ * @start:    Offset within @rpc->msgout of the first byte to retransmit.
+ * @end:      Offset within @rpc->msgout of the byte just after the last one
+ *            to retransmit.
+ * Return:    0 for success, otherwise a negative errno.
+ */
+int homa_resend_data(struct homa_rpc *rpc, int start, int end)
+	__must_hold(rpc->bucket->lock)
+{
+	u32 offset, pkt_end;
+	int err = 0;
+
+	for (offset = start; offset < end; offset = pkt_end) {
+		pkt_end = end;
+		err = homa_tx_skb_send(rpc, offset, &pkt_end);
+		if (err != 0)
+			break;
+		if (rpc->state == RPC_DEAD)
+			break;
+	}
+	return err;
+}
+
+/**
+ * homa_rpc_tx_end() - Return the offset of the first byte in an
+ * RPC's outgoing message that has not (with high probability) been
+ * passed to the NIC (i.e. offsets beyond this point have not been
+ * passed to ip*xmit or are deferred in homa_qdisc).
+ * @rpc:    RPC to check
+ * Return:  See above. If the message has been fully transmitted then
+ *          rpc->msgout.length is returned.
+ */
+int homa_rpc_tx_end(struct homa_rpc *rpc)
+{
+	return rpc->msgout.next_xmit_offset;
+}
-- 
2.43.0

