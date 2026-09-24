Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5B8361944
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257668; cv=none; b=bw2dI80t7S+N//O/pEViBo2r8yxlau+/GKLAHuunPaDCN4paDh7P7nnsFSKiBGp712JHxDG9nWUd7T7qekJ4SDE3qu7vw3Emh14YBu0JVAWD1ylldTYmW4UJVxLlU2nQSpSwSaQO4V9ZcukkHnJRUEqRgmViameL6wonV1+TNTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257668; c=relaxed/simple;
	bh=3VXORutPXVLOs5Z9/9nnDuwqkjc+IuVpw64VienBNvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j5VY3ujg61DlEf6fS8i+ZlepuUVgM5dC7iyfGJZSM0/IMHB/8JQ3SfLfsR2+VdWCUZLaMD0bN+g4wkTZKL/w8SqO0aUDoGGOpash8GJeWM2VWTILmnUpy4y7srpuWG/WLkPAiqQTFYgRC2a/Gn3ubXOprOw2fMwK4jlhLjmINh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d9dT2QZP; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d9dT2QZP"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-530d028f779so25251921cf.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790257665; x=1790862465; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2XKj3Wo4/WK218D2HBvZYifaivoje3k/Dp+GjSJxv6g=;
        b=d9dT2QZPMFK2rmZPJPrM8hI/mgXiZSU83oVtWKriSOQfjXHgEOO9ljTxMR0zlXmQqL
         Jrk57yC3xiKBfDN66/vTGvnjxPzVMJVmbBsa/TClHb0c0BrkwdCDyQxCzXK6xyvhKP1N
         oyqIk74gLQFyYuvXFGRc5DIvuFbDYcoMPZRQvN8+MFQU9OqMZZ75IkopncpWWBgGeSwM
         s6DGBVYHAnCl299WqOJF5AgvTAw01Z6d4Wd5aSE6/WKqjRrgjPpYKo222GB/2YzX2uYW
         1lI6bWHhVixN3kJffUBgfuFXIKVx8eeO/yRnmW3rzojxhtZtjTRl6BS/DAm4xjvqZZBD
         7Ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257665; x=1790862465;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2XKj3Wo4/WK218D2HBvZYifaivoje3k/Dp+GjSJxv6g=;
        b=zvYpIlrQ6Z/KKatyORC916hw+KqPAvo2bIWkh8PGEsMVUIiprcAueQuRxHM7m6n/gY
         IVVIFHhpzusuw9F7MJORvCwl/uIW1mYJ0Hl6ZlmZubmgZFKteaM/7e+Xm1VV0pDsNZem
         yTd11oPXPl6NKrncDcCvBSplnjZqtchVXR5quurPoButDxoujKh6UULj8vP4tidF4qDi
         bbi+r9Dj4+OX7GgAUf/yFOhZcSeLhtGOJuylB2RfboKRzstY6uP1XDfoBB+B9Ej3kVFv
         lghmAh2Pmp+4/giqcqZ2/enmh7iIjJh0wPVf3368i7LNjirAlKWgXqIeRlaN6sZ75ZQC
         Nd/Q==
X-Forwarded-Encrypted: i=1; AKwUvByAsHo4VziwTyAgcPKSaZIy+r+w8cns6ppWigptkavDWe5FO4XFEwg/+0+j1TIsafDMAZgCNTw=@vger.kernel.org
X-Gm-Message-State: AFuF++mlcN3xYFgmCmE4FKluySfvTmkHse+uLl5eZ1rHJeOE6fjpgTh1
	XJQbvJ7PJ1NqtOJbo4/u+aoMUGOAWGxnhpwnJmLyWh5//0QUjjTsTaYLnCnmBfP6UiY4WxUi2ZI
	7wOmVuhCbM3lRIA==
X-Received: from qtbiy6.prod.google.com ([2002:a05:622a:7006:b0:532:7eb1:8250])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1e0b:b0:51c:555:7dea with SMTP id d75a77b69052e-532feacc0a7mr16243331cf.30.1790257664900;
 Thu, 24 Sep 2026 06:47:44 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:47:29 +0000
In-Reply-To: <20260924134729.2047213-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924134729.2047213-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924134729.2047213-10-edumazet@google.com>
Subject: [PATCH v2 net-next 9/9] tcp: add tp->tcp_nospace
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_check_space() runs for every incoming ACK and for every packet we
send, and reads SOCK_NOSPACE from sk->sk_socket->flags.

struct socket lives in its own cache line, which the TCP fast paths do
not otherwise touch, so testing sk->sk_socket->flags pulls in an extra
cache line that is cold when the working set is large.

Add tp->tcp_nospace, a mirror of SOCK_NOSPACE placed right after
tp->chrono_type in the tcp_sock_write_tx group, in a cache line both
the transmit and the ACK paths already touch (bytes_sent, data_segs_out,
delivered, bytes_acked, chrono_type).  It fits in an existing 3-byte
hole before chrono_start, so no other field moves and sizeof(struct
tcp_sock) is unchanged.

The two flags are now only changed from sk_set_nospace() and
sk_clear_nospace(), which maintain this invariant:

	SOCK_NOSPACE set  =>  tp->tcp_nospace set

sk_set_nospace() sets SOCK_NOSPACE before tp->tcp_nospace (using
smp_mb__after_atomic() and smp_store_mb()), while sk_clear_nospace()
clears tp->tcp_nospace before SOCK_NOSPACE (using
smp_mb__before_atomic()).  If a lockless sk_set_nospace() from
tcp_poll() races with sk_clear_nospace() and SOCK_NOSPACE ends up set,
set_bit(SOCK_NOSPACE) happened after clear_bit(SOCK_NOSPACE), so
tp->tcp_nospace = 1 happens after tp->tcp_nospace = 0 as well.

tcp_check_space() can thus test tp->tcp_nospace alone and leave the
authoritative SOCK_NOSPACE test to __tcp_check_space().  The
invariant is one directional on purpose: a stale tp->tcp_nospace only
costs an extra call to __tcp_check_space(), which is what we do
unconditionally today, while a stale SOCK_NOSPACE would cost a
missed EPOLLOUT.

Note the smp_mb() is kept.  tcp_poll() sets the flag without the
socket lock, and the store-buffer pattern it forms with
tcp_check_space() needs a full barrier on both sides.

MPTCP subflows share the struct socket of their parent, hence its
SOCK_NOSPACE bit, which can not be mirrored in the subflow tcp_sock.
Pin their tp->tcp_nospace in subflow_ulp_init(), so that they always
reach __tcp_check_space() and keep the current behavior.

Microbenchmark on an AMD EPYC 7B13, 64 threads, each thread calling
tcp_check_space() in a loop over a private set of sockets.  Numbers
are cycles per call above a baseline loop that performs the work the
callers already did (the cache lines tcp_write_xmit() and
tcp_clean_rtx_queue() touched) but not tcp_check_space() itself, so
they are the marginal cost of the function.  Median of 11 runs.
The set size controls whether struct socket is still cached:

    sockets/thread	before	 after
    1			  +0.6	  +0.7
    256    (64 KB)	  +8.3	  +3.9
    4096   (1 MB)	 +22.4	  +1.1
    262144 (64 MB)	 +48.4	  -0.8

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  3 ++
 include/net/tcp.h                             | 30 ++++++++++++++++++-
 net/core/sock.c                               | 17 ++++++++---
 net/ipv4/tcp.c                                |  1 +
 net/ipv4/tcp_input.c                          |  8 ++++-
 net/mptcp/subflow.c                           |  5 ++++
 7 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 0f6088c4ab8bb872e7fc86f02479592e84c0247a..103328dc409e4485a3f989c95348c1bc74ab20c6 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -50,6 +50,7 @@ u8:1                          tcp_usec_ts             read_mostly         read_m
 u32                           chrono_start            read_write                              tcp_chrono_start/stop(tcp_write_xmit,tcp_cwnd_validate,tcp_send_syn_data)
 u32[3]                        chrono_stat             read_write                              tcp_chrono_start/stop(tcp_write_xmit,tcp_cwnd_validate,tcp_send_syn_data)
 u8:2                          chrono_type             read_write                              tcp_chrono_start/stop(tcp_write_xmit,tcp_cwnd_validate,tcp_send_syn_data)
+u8                            tcp_nospace             read_mostly         read_mostly         tcp_check_space(tx);tcp_check_space(rx)
 u8:1                          rate_app_limited                            read_write          tcp_rate_gen
 u8:1                          fastopen_connect
 u8:1                          fastopen_no_cookie
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a8c77719322f9caee305d954a107892c76d4ef7..e4d1720f49f08f3c12f5ba66fe8fe3379d71b1e0 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -269,6 +269,9 @@ struct tcp_sock {
 				 */
 	u32	snd_sml;	/* Last byte of the most recently transmitted small packet */
 	u8	chrono_type;	/* current chronograph type */
+	u8	tcp_nospace;	/* mirrors SOCK_NOSPACE, must be set whenever
+				 * SOCK_NOSPACE is set.
+				 */
 	u32	chrono_start;	/* Start time in jiffies of a TCP chrono */
 	u32	chrono_stat[3];	/* Time in jiffies for chrono_stat stats */
 	u32	write_seq;	/* Tail(+1) of data held in tcp send buffer */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5e5f5f9b89a386568fc5efebfa3d3c7e1ff62683..3389c51790e6b03714eda8fd89c05cf5c2999809 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -783,14 +783,42 @@ void tcp_done_with_error(struct sock *sk, int err);
 void tcp_reset(struct sock *sk, struct sk_buff *skb);
 void tcp_fin(struct sock *sk);
 void __tcp_check_space(struct sock *sk);
+
+/* Mirror of SOCK_NOSPACE in tcp_sock, maintained by sk_set_nospace()
+ * and sk_clear_nospace().
+ *
+ * MPTCP subflows share the parent socket, and thus its SOCK_NOSPACE bit.
+ * Keep their mirror always set (see subflow_ulp_init()) so that they
+ * always reach __tcp_check_space() and behave as before.
+ */
+static inline void tcp_set_nospace(struct sock *sk)
+{
+	if (sk_is_tcp(sk)) {
+		/* pairs with smp_mb__before_atomic() in tcp_clear_nospace() */
+		smp_mb__after_atomic();
+		/* pairs with smp_mb() in tcp_check_space() */
+		smp_store_mb(tcp_sk(sk)->tcp_nospace, 1);
+	}
+}
+
+static inline void tcp_clear_nospace(struct sock *sk)
+{
+	if (sk_is_tcp(sk) && !sk_is_mptcp(sk)) {
+		WRITE_ONCE(tcp_sk(sk)->tcp_nospace, 0);
+		/* pairs with smp_mb__after_atomic() in tcp_set_nospace() */
+		smp_mb__before_atomic();
+	}
+}
+
 static inline void tcp_check_space(struct sock *sk)
 {
 	/* pairs with tcp_poll() */
 	smp_mb();
 
-	if (sk->sk_socket && test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
+	if (unlikely(READ_ONCE(tcp_sk(sk)->tcp_nospace)))
 		__tcp_check_space(sk);
 }
+
 void tcp_sack_compress_send_ack(struct sock *sk);
 
 static inline void tcp_cleanup_skb(struct sk_buff *skb)
diff --git a/net/core/sock.c b/net/core/sock.c
index 11a22aec7e414152aab115e8d11e30067ab3775f..946f614f665b3608d1f310da908d82de622ec5c0 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2969,8 +2969,15 @@ void sk_set_nospace(struct sock *sk)
 {
 	struct socket *sock = sk->sk_socket;
 
-	if (sock)
-		set_bit(SOCK_NOSPACE, &sock->flags);
+	if (!sock)
+		return;
+	/* Set SOCK_NOSPACE before tp->tcp_nospace (paired with
+	 * sk_clear_nospace() clearing tp->tcp_nospace before SOCK_NOSPACE)
+	 * so a concurrent clear cannot leave SOCK_NOSPACE set with
+	 * tp->tcp_nospace cleared.
+	 */
+	set_bit(SOCK_NOSPACE, &sock->flags);
+	tcp_set_nospace(sk);
 }
 EXPORT_SYMBOL(sk_set_nospace);
 
@@ -2985,8 +2992,10 @@ void sk_clear_nospace(struct sock *sk)
 {
 	struct socket *sock = sk->sk_socket;
 
-	if (sock)
-		clear_bit(SOCK_NOSPACE, &sock->flags);
+	if (!sock)
+		return;
+	tcp_clear_nospace(sk);
+	clear_bit(SOCK_NOSPACE, &sock->flags);
 }
 EXPORT_SYMBOL(sk_clear_nospace);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1cde000cfab4704e6756872f6ddec16851ccc55d..f44cbd3e76178a5ec5b40e420b32836477c29266 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5242,6 +5242,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, snd_sml);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tcp_nospace);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, chrono_start);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, chrono_stat);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, write_seq);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 892ff256e235272a8483a11949cc98b319dd7cc9..cdea30d07fe2c2a38c3d38da27ad3274221d5958 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6098,8 +6098,14 @@ static void tcp_new_space(struct sock *sk)
  */
 void __tcp_check_space(struct sock *sk)
 {
+	struct socket *sock = sk->sk_socket;
+
+	/* tp->tcp_nospace is only a hint, SOCK_NOSPACE is authoritative. */
+	if (!sock || !test_bit(SOCK_NOSPACE, &sock->flags))
+		return;
+
 	tcp_new_space(sk);
-	if (!test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))
+	if (!test_bit(SOCK_NOSPACE, &sock->flags))
 		tcp_chrono_stop(sk, TCP_CHRONO_SNDBUF_LIMITED);
 }
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f0a6725d2c3762def75c879e769e9da37f92215a..e297c88be503b42979886baaf43acfb6b7e78055 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -2001,6 +2001,11 @@ static int subflow_ulp_init(struct sock *sk)
 	pr_debug("subflow=%p, family=%d\n", ctx, sk->sk_family);
 
 	tp->is_mptcp = 1;
+	/* Subflows share the MPTCP socket, and thus its SOCK_NOSPACE bit,
+	 * which tcp_check_space() can not mirror. Pin the mirror so that
+	 * __tcp_check_space() always tests the shared bit.
+	 */
+	tp->tcp_nospace = 1;
 	ctx->icsk_af_ops = icsk->icsk_af_ops;
 	icsk->icsk_af_ops = subflow_default_af_ops(sk);
 	ctx->tcp_state_change = sk->sk_state_change;
-- 
2.56.0.rc1.310.g51773c2048-goog

