Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882455;
	b=zA5Li5N5qL8RNu1rkwl9qdmQS72JiwGEeVbTop6CyYimUMLgOmU/u8W4m+0thnsf1/xw
	 aC4MMzpy6qwu2ezlPEyVu/zEd4/lETa0SNjZ3cxh6vAqtkZGBXa4YYpC1iHtqsqr+9OlH
	 cM6BYvOVTMGh4HkCn0daogrB+8tO8tOZ3FiJU6k+jp13F63s+PrHADv1xlHTVtQcpgzRF
	 43KnREZvCCQDZVvj7Org/a1IrVtIvsgKMBS+etDk0JMvDVh8R3yGGsvvWf/IyidD+tQ5p
	 Xl8oVeRLlyfgHDDpGDbrclbBgrdXXOet18H9BmXR0cSdEQD6s7FicOux6VTp8B8JC2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882455;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ua2FUkwHp6H+H06QgHu5BHKGlmfLoB7dvzfq1T5O6IM=;
	b=2dVkovwN4JVbEZ7HExID5d5K8YlROWt0D8Hs6wTb2lTagnfp/1VunqjLNQ3qDd+SGtKH
	 C8s07EGBTRfly/uOXxTZCxGa8Bmf0Vv3k5qiqgIroecJGCZnsc6lnBOEeuvpvSuAcU+1J
	 WNaygXq5v9iIZovdVIWqnBLU4OzXh7p3r/hra+LVJ/hvK4tgUUKKaFFGv7/emSquokO9b
	 asIsrUE3Y7ooafzqu9lL38uC3vW5kq7MGjbJZ+JmsE+yCFblajY7mXuymFHRoykuEKweP
	 vd6D8NoEV31PIH3fNMvWoZtiKvqnlFP23ZuHgugNk0sKxA9I4sAZGwt4z2y3MN++ixA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nt+StYbJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DAD606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nt+StYbJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3046C1F000C1;
	Thu,  5 Nov 2026 12:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882454;
	bh=Ua2FUkwHp6H+H06QgHu5BHKGlmfLoB7dvzfq1T5O6IM=;
	h=From:To:Cc:Subject:Date;
	b=Nt+StYbJVUE3YzLLentQ6p9k7zxVjHtuOQ0PqDEDpbtuJ/NRNJOks+di5CMJXqKc8
	 uxGYjsfLf/CuFA4C25mdvYJ88/kh7HE3erTeDKN7c58N3nPXGFm1eSDNS3NS2FTeT/
	 3j4GEA5JpDVN4Z1IqDhLVnrw1CLZ5tYNuWsKW4pJGtTz/9ujdVrlZ14xDYC7nH4uph
	 +lGxK7Iuw3ZuIfSwTrTAbiCS8GQwJoLK6BYe7QGjMz4qUzhDDFyigr+rRopSm9Bpst
	 JyGSCVCYLaa35syEnwA43tzPMpAEkxMMPB6JQMPZtbSo1+DcEPGhfNM3v55Hx6bgEO
	 ME1KPBQQsNLhA==
From: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org,
	edumazet@kernel.org,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Chris Mason <mason@kernel.org>
Subject: [PATCH net] tcp: rate limit receive queue collapsing
Date: Thu,  5 Nov 2026 13:40:43 +0100
Message-ID: <20261105124043.1543405-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a socket is over its receive buffer limit and its sk_rcvbuf can
not grow, every incoming segment that needs memory goes through
tcp_prune_queue(), which runs tcp_collapse_ofo_queue() and tcp_collapse()
on the receive queue. Both walk their whole queue, even when there is
nothing left to collapse.

A peer can trigger this walk per packet, without refilling memory:

1) The segment lands last in the out-of-order queue. Since commit
   b0e01253a764 ("tcp: refine tcp_prune_ofo_queue() logic"),
   tcp_prune_ofo_queue() drops nothing, the segment is dropped and
   the queues are unchanged. The peer can send it again forever.

2) The segment lands second to last: one skb is pruned, and one small
   segment fills that space again.

3) The out-of-order queue is empty and the receive queue alone is over
   the limit (application not reading). Collapsing frees nothing,
   the out-of-order segment is dropped, and the window is not closed.

4) Collapsing frees just one skb, enough to queue the segment. The next
   segment is over the limit again.

Only allow a collapse if at least 1/8 of sk_rcvbuf of new memory was
queued in the receive queues since the previous collapse. This restores
the "12.5 % of the queue capacity" amortization of the 2018 SegmentSmack
fixes (CVE-2018-5390), using the same unit as the sk_rcvbuf limit, so
that peers sending small (bloated) segments are not penalized.

The credit is the net growth of sk_rmem_alloc in tcp_queue_rcv() and
tcp_data_queue_ofo(), so that:

- Coalescing a segment into the tailroom of the previous skb charges no
  memory, and earns no credit.
- An out-of-order segment replacing or covering queued skbs only earns
  the memory it adds.
- Duplicates earn nothing.
- Data moved from the out-of-order queue to the receive queue
  (tcp_ofo_queue()) is not credited twice.

In-order data is credited too, so that a receive queue filled by
bloated in-order segments can still be collapsed when a hole appears.

In-order segments are rate limited as well: a peer could otherwise send
small in-order segments that each trigger a collapse freeing a single
skb, enough to queue the segment, while the out-of-order queue holds
many skbs that can not be collapsed.

The credit is tracked in a new u32 tp->rcv_collapse_credit, placed in a
hole of the tcp_sock_write_rx group: no other field moves, and tcp_sock
size is unchanged. tcp_queue_rcv() now samples sk_rmem_alloc, and
writes the credit until it saturates at sk_rcvbuf, so that the fast path
stops writing it after a full buffer of new memory. Saturating at the
goal would not work: sk_rcvbuf, and the goal with it, can grow later
(for instance in tcp_clamp_window(), just before the goal is checked),
and a socket over its limit can not earn more credit until the
application reads.

When collapsing is not allowed, tcp_prune_queue() goes directly to
tcp_prune_ofo_queue(), which is cheap in the cases above.

A regular flow can see a difference when it goes over its limit before
1/8 of sk_rcvbuf of new memory was queued since the previous collapse:
out-of-order skbs can be pruned (even for an in-order segment filling a
hole), and an in-order segment that still does not fit is dropped,
with a zero window advertised, where a collapse might have made room.

Fixes: b0e01253a764 ("tcp: refine tcp_prune_ofo_queue() logic")
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Upcoming net-next work, once this patch reaches net-next:

- tcp: add TCPRcvCollapseSkipped counter
  Count the collapses skipped by tcp_prune_queue(). A high rate can
  indicate a peer repeatedly sending segments that can not be queued.

- selftests/net: packetdrill: add tcp_rcv_collapse_ratelimit.pkt
  Fill the out-of-order queue of a socket with a small locked receive
  buffer, then send 10 times a segment landing last in the out-of-order
  queue. Check that no collapse is attempted, and that filling the hole
  still lets the application read data. It uses the new counter.

- tcp: use SKB_DROP_REASON_SOCKET_RCVBUFF when over sk_rcvbuf
- net: add SKB_DROP_REASON_MEMCG
  Today, TCP reports all these drops as SKB_DROP_REASON_PROTO_MEM,
  whether the socket is over sk_rcvbuf, the memcg charge failed, or
  tcp_mem limits are reached.

 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 net/ipv4/tcp.c                                |  2 +
 net/ipv4/tcp_input.c                          | 55 +++++++++++++++----
 4 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 93c85b621ec2..554e8c14a401 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -107,6 +107,7 @@ u32[3]                        received_ecn_bytes      read_mostly         read_w
 u8:4                          received_ce_pending     read_mostly         read_write
 u32[3]                        delivered_ecn_bytes                         read_write
 u16                           pkts_acked_ewma                             read_write
+u32                           rcv_collapse_credit                         read_write          tcp_queue_rcv,tcp_data_queue_ofo,tcp_prune_queue
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:2                          accecn_minlen           write_mostly        read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 5a4c61fc240e..ef6c7e77f74c 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -366,6 +366,7 @@ struct tcp_sock {
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
 	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
+	u32	rcv_collapse_credit; /* memory queued since last collapse */
 	struct {
 		u32	rtt_us;
 		u32	seq;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b9de7c302ba8..da3bdf7269d7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3490,6 +3490,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->rx_opt.dsack = 0;
 	tp->rx_opt.num_sacks = 0;
 	tp->rcv_ooopack = 0;
+	tp->rcv_collapse_credit = 0;
 
 
 	/* Clean up fastopen related fields */
@@ -5308,6 +5309,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_collapse_credit);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_est);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcvq_space);
 }
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 3fd0e215324d..ddb9ebcfbf31 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5413,6 +5413,20 @@ static int tcp_try_rmem_schedule(struct sock *sk, const struct sk_buff *skb,
 	return 0;
 }
 
+/* Credit the memory added to the receive queues since @rmem was sampled
+ * toward the next allowed collapse. Saturate at sk_rcvbuf, not at the goal
+ * checked in tcp_prune_queue(): sk_rcvbuf (and the goal) can grow later,
+ * for instance in tcp_clamp_window().
+ */
+static void tcp_collapse_credit_add(struct sock *sk, int rmem)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	int delta = atomic_read(&sk->sk_rmem_alloc) - rmem;
+
+	if (delta > 0 && tp->rcv_collapse_credit < (u32)sk->sk_rcvbuf)
+		tp->rcv_collapse_credit += delta;
+}
+
 static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -5420,6 +5434,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 	struct sk_buff *skb1;
 	u32 seq, end_seq;
 	bool fragstolen;
+	int rmem;
 
 	tcp_save_lrcv_flowlabel(sk, skb);
 	tcp_data_ecn_check(sk, skb);
@@ -5430,6 +5445,8 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 		tcp_drop_reason(sk, skb, SKB_DROP_REASON_PROTO_MEM);
 		return;
 	}
+	/* Sampled after tcp_try_rmem_schedule(), which can prune. */
+	rmem = atomic_read(&sk->sk_rmem_alloc);
 
 	tcp_measure_rcv_mss(sk, skb);
 	/* Disable header prediction. */
@@ -5559,6 +5576,10 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 		skb_condense(skb);
 		skb_set_owner_r(skb, sk);
 	}
+	/* Net growth: coalescing can charge nothing, and covered skbs
+	 * were freed.
+	 */
+	tcp_collapse_credit_add(sk, rmem);
 	/* do not grow rcvbuf for not-yet-accepted or orphaned sockets. */
 	if (sk->sk_socket)
 		tcp_rcvbuf_grow(sk, tp->rcvq_space.space);
@@ -5567,8 +5588,9 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
 				      bool *fragstolen)
 {
-	int eaten;
+	int rmem = atomic_read(&sk->sk_rmem_alloc);
 	struct sk_buff *tail = skb_peek_tail(&sk->sk_receive_queue);
+	int eaten;
 
 	bpf_tcp_ops_call_flag(enqueue_rcvq, RCVQ, sk, skb);
 
@@ -5580,6 +5602,7 @@ static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
 		tcp_add_receive_queue(sk, skb);
 		skb_set_owner_r(skb, sk);
 	}
+	tcp_collapse_credit_add(sk, rmem);
 	return eaten;
 }
 
@@ -6056,18 +6079,28 @@ static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb)
 	if (tcp_can_ingest(sk, in_skb))
 		return 0;
 
-	tcp_collapse_ofo_queue(sk);
-	if (!skb_queue_empty(&sk->sk_receive_queue))
-		tcp_collapse(sk, &sk->sk_receive_queue, NULL,
-			     skb_peek(&sk->sk_receive_queue),
-			     NULL,
-			     tp->copied_seq, tp->rcv_nxt);
+	/* Collapsing walks both queues and is expensive, and can free
+	 * almost nothing. Require at least 1/8 of sk_rcvbuf of new memory
+	 * in the receive queues since the previous collapse, otherwise
+	 * a stream of segments could trigger one collapse per packet.
+	 */
+	if (tp->rcv_collapse_credit >= (u32)sk->sk_rcvbuf >> 3) {
+		tp->rcv_collapse_credit = 0;
 
-	if (tcp_can_ingest(sk, in_skb))
-		return 0;
+		tcp_collapse_ofo_queue(sk);
+		if (!skb_queue_empty(&sk->sk_receive_queue))
+			tcp_collapse(sk, &sk->sk_receive_queue, NULL,
+				     skb_peek(&sk->sk_receive_queue),
+				     NULL,
+				     tp->copied_seq, tp->rcv_nxt);
 
-	/* Collapsing did not help, destructive actions follow.
-	 * This must not ever occur. */
+		if (tcp_can_ingest(sk, in_skb))
+			return 0;
+	}
+
+	/* Collapsing did not help (or was not allowed),
+	 * destructive actions follow.
+	 */
 
 	tcp_prune_ofo_queue(sk, in_skb);
 

base-commit: 57889a8f6d49fc153aa0017d13086ab736567f8a
-- 
2.53.0

