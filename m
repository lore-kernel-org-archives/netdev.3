Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C661559C8E
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997405; cv=none; b=TnQ56qC/sWI9bKs0yVZJzbAarfxf9F8VFfsDVubxwR9hmEdad0sBvLGiPiqfmeflHwtqJ03+zQxkMjBa3UyD79HL3oX7G2jdd8NZlvXEqpUOuuei4dMWH5MnUABgu6Vx9G1f9uHDVP95w6uADqWs9ZnDCgdGX+Y7y6OqYLtDlzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997405; c=relaxed/simple;
	bh=8XhZgrtP5VhSyyYt1prRvZzU4PR7+JnMNzXORg095Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMSTn3g7LISrnb9HjCGqjcOY7k0khgvTyKRSvdmA6/rXgWvcZ56sV8x4jBu+ypwony9/V96MaHPaDxerHM2UVP3PueDbO6htVuIsA+IPh0CPGzp3cMapJ1FEsGLi2Jb+yUKQWHbLeJjpkaUs7gYmTFBm9aeFIamR+3+VbQIlCZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=TtI6pYwe; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="TtI6pYwe"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so841133a12.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791997402; x=1792602202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JQr/puKGjwAhZc21SLejI85mMl8Dhq6nGdAJWNNxORs=;
        b=TtI6pYwe6LmZMnIjiXM8Aw2QxWhxIeEBWyP+5P8vm7ipHp1OKOe65Bob8uB7IJ0K5L
         Ly1sobQKMHTFk8ql74MhVE09aSUMQu263YYj/2d1/KbRGQADL2m41iavI1NXAohqSxDq
         haMa7HzXwvSwMO/dOJlPTWlvbHA6QMGfQn6Dns/k/BKQPg3knTTdPfABOkMGV9w8Sssu
         2nje1jv7Glc08CoEqdKQZ3sfQ/zlsI3OLulSqw8vIYaRtjFOHYX3RKwDzqBxqmxxuS5C
         CEmHWY6xkE1FuhCAQPNtHRNPJIqCX1Fh5Di17qrDQHQm9jLTuYZ3iosZQ0N7duDcmuFL
         Br/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997402; x=1792602202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JQr/puKGjwAhZc21SLejI85mMl8Dhq6nGdAJWNNxORs=;
        b=lPHhagwKW4Or9rL4L76EIKSOIW1qHnbyn+4JrrsL6VVeYJGk2wuKO/2xgJ86SVCraS
         YqPvNi9S0ysX5qS8wqzMe63fICAsp0VBdG6eZ8+KAeMgOdeLsT3jMmapBnpXFDt+Hm4F
         zehBY4fa9LCAcVZ6tssHHc6ZJsyzLQCHW3WXIOpHHANPLP5WMlcnOjxA4r1ZAjLVDaZT
         GzMjQ3FbpseeIZuRDyNPLbiTESdkbZaRgh8ZrRODjaq4DYUQapRbfJq1SBhC6kfzu9pb
         lmAjhJc05wYYgAS8WgguM+cvna8P0AgEVSl5in0y/WQmnLSEPJCgmumsqVSu1p75icrZ
         Dkqw==
X-Forwarded-Encrypted: i=1; AKwUvByGpRJ5YewNENg9E9SAgIvFuPP//fWo8/AOe5MkXIkb+uPdZZfX3f6/+1pYf4hh+pegnt3yKz8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9RJCC2PJXmXinbBREFXzN+0zk1DzrcQv7SH6D1zBn8TvuG5Um
	6PLKReyoCS8TmBZmgfgylCHahPTrkmNFInrkdlejHtsdTGRWxv4be2Jfh7mN2IFG/2LV
X-Gm-Gg: AYBFou1xWAa3T4TZPs8sjM66eYRW+Rx7baB98LE42VMVrlPBaIKtxj2FKTddSU4MqnD
	LY+Feq0+1y2lw9V5VSRoDDBeh0qYRvsxQtvrO1mfBKpIA/pK4NdbMoMHSrLxEyojj3EbTwP+van
	idEhbmEgN00ScrpeBnCtzwEs04MJfG/KZFTBP5gEh91g+4s6l6pI8RcIsUyRH0j9EC+ijPtkp+u
	d2tYBDmfrWSrimk60b8IRg2X5oB1TtFvP4zyPdGr1AMJZrOhS4mAZkDhHi+s+9jH8lkXzi/gx/k
	HcEyeoVET0VD8a3huVzKCOUQomnJFkeXhkQ9YT+B8laXbhYrFW0cZ+EwdSv/xieb37z059YlheU
	K2R+5PN2aW2XcgYJ8+3FQrGB+X4EkS8g/bGX6v8QGXf5b1U/rzedwsUgo7lbwx5xAHjolCnqucp
	6bUyHwmETQkfHhW9v5INcoytvavENrNZvjLmh65sJxaA4R8Cwv6rNj8caVhKEXpKRFiAoUXWHjz
	XHOlvELQNVYOqwiQAp48+Ma+4KMD0M=
X-Received: by 2002:a17:90b:1d03:b0:3a8:181a:2bfb with SMTP id 98e67ed59e1d1-3ab3a949a69mr11331698a91.23.1791997402001;
        Wed, 14 Oct 2026 10:03:22 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94792925sm190406a91.13.2026.10.14.10.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:03:19 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@kernel.org,
	horms@kernel.org,
	vega@nebusec.ai,
	root@tr0jan.top,
	zihanx@nebusec.ai
Subject: [PATCH net v9 1/3] rxrpc: account encapsulated packets to UDP socket
Date: Wed, 14 Oct 2026 16:58:34 +0000
Message-ID: <ca93aae0e2da0fb4720ab9ed6840847bae08fca0.1791994058.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791994057.git.zihanx@nebusec.ai>
References: <cover.1791994057.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxrpc_encap_rcv() queues encapsulated UDP packets on the RxRPC local
queue without charging them to the UDP socket. If the I/O thread cannot
keep up, the queue can grow without bound.

Charge each packet against the tunnel socket under
sk_receive_queue.lock. Derive the receive-buffer limit from the
advertised window, retaining headroom for control and error traffic.
Drop packets when the buffer or protocol memory budget is exhausted,
while preserving UDP's empty-queue exception.

Orphan charged skbs when the I/O thread dequeues them. Since
skb_set_owner_r() does not hold a socket reference, clear sk_user_data
under RCU and release the socket only after purging the local queues.

The remaining patches bound RxRPC queues that can retain skbs after the
UDP receive-memory charge is released.

Fixes: 446b3e14525b ("rxrpc: Move packet reception processing into I/O thread")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/cover.1791428529.git.zihanx@nebusec.ai/
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v9:
  - Split the fix into UDP accounting, connection/OOB queue budgeting,
    and DATA receive-queue budgeting patches.
  - Correct the Fixes attribution for the asynchronous receive queues.
  - v8 Link: https://lore.kernel.org/all/cover.1791428529.git.zihanx@nebusec.ai/
changes in v8:
  - Rebase onto net/main at 6d25ffca055a and resend after the previous
    posting became stale.
  - v7 Link: https://lore.kernel.org/all/cover.1790427022.git.zihanx@nebusec.ai/
changes in v7:
  - Rebase the fix onto net/main at a7bfaba4823e.
  - v6 Link: https://lore.kernel.org/all/cover.1789608557.git.zihanx@nebusec.ai/
changes in v6:
  - Refresh the tunnel socket receive-buffer cap when rxrpc_rx_window_size
    increases, without shrinking an existing socket.
  - Distinguish socket receive-buffer exhaustion from protocol memory
    accounting failures in the drop reason.
  - Cap the window-derived value at sysctl_rmem_max and only grow an
    existing sk_rcvbuf.
  - v5 Link: https://lore.kernel.org/all/cover.1789273347.git.zihanx@nebusec.ai/
changes in v5:
  - Size the tunnel sk_rcvbuf from one advertised DATA window, with
    additional headroom for ACKs and ICMP, capped by sysctl_rmem_max.
  - Drop the dst instead of skb_dst_force(); keep skb->dev = NULL.
  - Document the runtime receive-window sizing limitation.
  - v4 Link: https://lore.kernel.org/all/cover.1788878590.git.zihanx@nebusec.ai/
changes in v4:
  - Serialize UDP rmem charge and uncharge with sk_receive_queue.lock.
  - Orphan only PACKET skbs charged by encap_rcv(); preserve error skb
    ownership.
  - Clarify the callback-listener setup and distinguish the unprivileged
    flood from extra conditions used for the recorded OOM.
  - v3 Link: https://lore.kernel.org/all/cover.1788539302.git.zihanx@nebusec.ai/
changes in v3:
  - Orphan skbs when the I/O thread dequeues them so UDP rmem ownership
    does not follow packets onto call or connection queues.
  - Clarify the affected source files and the recorded OOM context.
  - v2 Link: https://lore.kernel.org/all/cover.1785339953.git.zihanx@nebusec.ai/
changes in v2:
  - Use sk_drops_inc(), correct the Fixes attribution, and refresh the
    baseline reproducer and decoded crash log.
  - Explain why packetdrill does not express the sustained unique-call
    flood used by this reproducer.
  - v1 Link: https://lore.kernel.org/all/cover.1784742007.git.zihanx@nebusec.ai/
---
 net/rxrpc/ar-internal.h  |  1 +
 net/rxrpc/io_thread.c    | 61 ++++++++++++++++++++++++++++++++++++++--
 net/rxrpc/local_object.c | 24 ++++++++++++++--
 3 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 865f05fe37ab9..b079ec98aaa74 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1323,6 +1323,7 @@ void rxrpc_send_version_request(struct rxrpc_local *local,
  * local_object.c
  */
 void rxrpc_local_dont_fragment(const struct rxrpc_local *local, bool set);
+void rxrpc_adjust_rcvbuf(struct sock *sk);
 struct rxrpc_local *rxrpc_lookup_local(struct net *, const struct sockaddr_rxrpc *);
 struct rxrpc_local *rxrpc_get_local(struct rxrpc_local *, enum rxrpc_local_trace);
 struct rxrpc_local *rxrpc_get_local_maybe(struct rxrpc_local *, enum rxrpc_local_trace);
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index dc5184a2fa9d1..634a6e1cab87a 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -7,12 +7,37 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <net/udp.h>
+
 #include "ar-internal.h"
 
 static int rxrpc_input_packet_on_conn(struct rxrpc_connection *conn,
 				      struct sockaddr_rxrpc *peer_srx,
 				      struct sk_buff *skb);
 
+/*
+ * Drop UDP rmem ownership for packets charged in encap_rcv().
+ * sk_forward_alloc is serialised by sk_receive_queue.lock.
+ */
+static void rxrpc_skb_orphan_udp(struct sk_buff *skb)
+{
+	struct sock *sk = skb->sk;
+
+	if (!sk)
+		return;
+
+	spin_lock_bh(&sk->sk_receive_queue.lock);
+	skb_orphan(skb);
+	spin_unlock_bh(&sk->sk_receive_queue.lock);
+}
+
+static void rxrpc_encap_rcv_drop(struct sock *udp_sk, struct sk_buff *skb,
+				 enum skb_drop_reason reason)
+{
+	sk_drops_inc(udp_sk);
+	sk_skb_reason_drop(udp_sk, skb, reason);
+}
+
 /*
  * handle data received on the local endpoint
  * - may be called in interrupt context
@@ -28,6 +53,10 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
 	struct sk_buff_head *rx_queue;
 	struct rxrpc_local *local = rcu_dereference_sk_user_data(udp_sk);
 	struct task_struct *io_thread;
+	enum skb_drop_reason reason;
+	unsigned int headroom;
+	unsigned int rcvbuf;
+	unsigned int rmem;
 
 	if (unlikely(!local)) {
 		kfree_skb(skb);
@@ -41,8 +70,6 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
 	if (skb->tstamp == 0)
 		skb->tstamp = ktime_get_real();
 
-	skb->mark = RXRPC_SKB_MARK_PACKET;
-	rxrpc_new_skb(skb, rxrpc_skb_new_encap_rcv);
 	rx_queue = &local->rx_queue;
 #ifdef CONFIG_AF_RXRPC_INJECT_RX_DELAY
 	if (rxrpc_inject_rx_delay ||
@@ -52,9 +79,36 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
 	}
 #endif
 
+	headroom = SKB_TRUESIZE(RXRPC_JUMBO(1)) * 2;
+	spin_lock(&udp_sk->sk_receive_queue.lock);
+	rxrpc_adjust_rcvbuf(udp_sk);
+	rcvbuf = READ_ONCE(udp_sk->sk_rcvbuf);
+	rmem = atomic_read(&udp_sk->sk_rmem_alloc);
+	/* Permit one skb when there is no receive memory charged, as UDP does. */
+	if (rmem && rmem + skb->truesize + headroom >= rcvbuf) {
+		reason = SKB_DROP_REASON_SOCKET_RCVBUFF;
+		goto drop;
+	}
+	if (!sk_rmem_schedule(udp_sk, skb, skb->truesize)) {
+		reason = SKB_DROP_REASON_PROTO_MEM;
+		goto drop;
+	}
+
+	skb->dev = NULL;
+	skb_set_owner_r(skb, udp_sk);
+	spin_unlock(&udp_sk->sk_receive_queue.lock);
+	skb_dst_drop(skb);
+
+	skb->mark = RXRPC_SKB_MARK_PACKET;
+	rxrpc_new_skb(skb, rxrpc_skb_new_encap_rcv);
 	skb_queue_tail(rx_queue, skb);
 	wake_up_process(io_thread);
 	return 0;
+
+drop:
+	spin_unlock(&udp_sk->sk_receive_queue.lock);
+	rxrpc_encap_rcv_drop(udp_sk, skb, reason);
+	return 0;
 }
 
 /*
@@ -471,6 +525,9 @@ int rxrpc_io_thread(void *data)
 		/* Distribute packets and errors. */
 		while ((skb = __skb_dequeue(&rx_queue))) {
 			struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+
+			if (skb->mark == RXRPC_SKB_MARK_PACKET)
+				rxrpc_skb_orphan_udp(skb);
 			switch (skb->mark) {
 			case RXRPC_SKB_MARK_PACKET:
 				skb->priority = 0;
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 169f9dfdaa77f..f519a93059244 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -22,6 +22,19 @@
 
 static void rxrpc_local_rcu(struct rcu_head *);
 
+void rxrpc_adjust_rcvbuf(struct sock *sk)
+{
+	u32 rcvbuf, old_rcvbuf;
+
+	rcvbuf = READ_ONCE(rxrpc_rx_window_size) *
+		SKB_TRUESIZE(RXRPC_JUMBO(1)) * 2;
+	rcvbuf += rcvbuf / 4;
+	rcvbuf = min_t(u32, rcvbuf, READ_ONCE(sysctl_rmem_max));
+	old_rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+	if (rcvbuf > old_rcvbuf)
+		WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
+}
+
 /*
  * Handle an ICMP/ICMP6 error turning up at the tunnel.  Push it through the
  * usual mechanism so that it gets parsed and presented through the UDP
@@ -198,6 +211,9 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 
 	/* set the socket up */
 	usk = local->socket->sk;
+	spin_lock_bh(&usk->sk_receive_queue.lock);
+	rxrpc_adjust_rcvbuf(usk);
+	spin_unlock_bh(&usk->sk_receive_queue.lock);
 	usk->sk_error_report = rxrpc_error_report;
 
 	switch (srx->transport.family) {
@@ -437,8 +453,8 @@ void rxrpc_destroy_local(struct rxrpc_local *local)
 	if (socket) {
 		local->socket = NULL;
 		kernel_sock_shutdown(socket, SHUT_RDWR);
-		socket->sk->sk_user_data = NULL;
-		sock_release(socket);
+		rcu_assign_sk_user_data(socket->sk, NULL);
+		synchronize_rcu();
 	}
 
 	/* At this point, there should be no more packets coming in to the
@@ -448,6 +464,10 @@ void rxrpc_destroy_local(struct rxrpc_local *local)
 	rxrpc_purge_queue(&local->rx_delay_queue);
 #endif
 	rxrpc_purge_queue(&local->rx_queue);
+
+	if (socket)
+		sock_release(socket);
+
 	rxrpc_purge_client_connections(local);
 	page_frag_cache_drain(&local->tx_alloc);
 }
-- 
2.43.0

