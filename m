Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5EA541E5C
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080060; cv=none; b=GD90VdWokIXgIFXfvxrDh4avs3jQq9ZApbA3sL2rIwAnSL/4IwoVsweK+TJOTTuCUySaTQF6eCOM7/37p/T1NZ3EY3YdiEe11O3GazqptKUHxZl4CE8d84olHs6zTadpzgj7aE0mq+VsbTFVyrEgJZQtXektRBl9JSHOGXAXA8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080060; c=relaxed/simple;
	bh=/myHPWcGPouXBaAei1xHExmvxRRkkEpNCqKvBE81QWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t2HBGMr/YLOcSgqC8CeioXF1nWqDH98X7xdfVtDuFwrtgndSRoyNJM/KJhZmCPgn8ZNTr33j5Bw37fwBfbd7bba3u4Xz0A50/oYcfESiYW4iadlSwI4QfiMLpjg+BJWesJ5JuQZNosmqpMGPZ/73MpZ8emOE7oInNWMuiXll8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T19OCYe8; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T19OCYe8"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934956beec8so838809485a.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790080057; x=1790684857; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rgf5DKQ1yfadQNAc8xt8WyuDIOc2x7XkgzWj4naGbvQ=;
        b=T19OCYe8uF40F1mQj+kwIpdp2U/Dt6CHyXZMHwRucf0my21KJC2XWZFpOy+59LNQi+
         xO70Aj4I6VRblqVNE4knMdgPrqzjsJZWLSen4oz1jxHGoxmtNSXDu9CRfo1V4EyFjajp
         xfjTKjtDRrGALE4ytzTXezyAUPhaRiS6bYHh69VN+BJJvb2nsIG9W4gBiR6rAAOXR/Ha
         NQaexqYYYTNLEE+KU6u40Jb5qNJQhZcdiMmqXdHnp4JGZdLQ5hYipbAivON+b0uUFJRP
         Ka8yknRyM9uxR8e97evIj/Q468oJ9aWw2vl+qT5B5D6ksqWxmoUaBcV+NC0JLzHF3Hsy
         bB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080057; x=1790684857;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rgf5DKQ1yfadQNAc8xt8WyuDIOc2x7XkgzWj4naGbvQ=;
        b=Dmes619D/4vvpAJz4mM/ReB/274imUQAi+AmMFA4iqlAo8003NZgadieAyikyTJ8yk
         ulsZDRt+ryZq76qOz8R+rgLNrzyq1o2M+BXicFtAwBrBmqBpj9qcp2X9JJsWWSs6tNPN
         Q/PTCPjNwuRnJE/CJ1kj+JL8fB51X41izsH0N0V5bo0sviNzpkoVQvMCBYhEvz2O0C57
         fnVpdVDm3E23ykz4hhqsVwWkfSb5YYAA4qiYy55yhFSGCc6zo65kFYeTASFV9H4FL8qd
         JP3aOwROgKPS4Opem1ytjf0XoWuPdsysIq/z3On82wRuFNc3S+o7HEAefpNNCmmKTUbh
         9VIQ==
X-Forwarded-Encrypted: i=1; AKwUvByjqLyhmlw7I1qAMLkjtKvciQAWA0gZ4/dOjaE90HR7Ud1D0aJ+s5LB7IVyC8eFtcC1Ca1nwPg=@vger.kernel.org
X-Gm-Message-State: AFuF++m5Ursy5doq9HOY0yFRgXbssio6zs2IyRurYbB7V9LMBGtUDdD0
	Qw5a88fK7FrRLunVRlE1jYBWuD8hT1KfZxKDGeVOow21L0zWGKkCPcj5Sj1ly/5K9aCzv62Kfdx
	vkCYPffYnxeEeJQ==
X-Received: from qkbd24.prod.google.com ([2002:a05:620a:31f8:b0:93a:1fdc:716b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2b8a:b0:939:feee:630 with SMTP id af79cd13be357-93c15da20ebmr518608685a.30.1790080056936;
 Tue, 22 Sep 2026 05:27:36 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:27:20 +0000
In-Reply-To: <20260922122721.3568295-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922122721.3568295-10-edumazet@google.com>
Subject: [PATCH net-next 9/9] tcp: add tp->tcp_nospace
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

Add tp->tcp_nospace, a mirror of SOCK_NOSPACE placed in the
tcp_sock_write_txrx group, that is in a cache line both the transmit
and the receive paths already have to touch.  It fits in an existing
hole, sizeof(struct tcp_sock) is unchanged.

The two flags are now only changed from sk_set_nospace() and
sk_clear_nospace(), which maintain this invariant:

	SOCK_NOSPACE set  =>  tp->tcp_nospace set

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
 include/linux/tcp.h                           |  4 ++++
 include/net/tcp.h                             | 23 ++++++++++++++++++-
 net/core/sock.c                               | 18 +++++++++++----
 net/ipv4/tcp.c                                |  1 +
 net/ipv4/tcp_input.c                          |  8 ++++++-
 net/mptcp/subflow.c                           |  5 ++++
 7 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 0f6088c4ab8bb872e7fc86f02479592e84c0247a..3f225cdf12983d00c5347cd3ab16049b14b59047 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -12,6 +12,7 @@ struct inet_connection_sock   inet_conn
 u16                           tcp_header_len          read_mostly         read_mostly         tcp_bound_to_half_wnd,tcp_current_mss(tx);tcp_rcv_established(rx)
 u16                           gso_segs                read_mostly                             tcp_xmit_size_goal
 __be32                        pred_flags              read_write          read_mostly         tcp_select_window(tx);tcp_rcv_established(rx)
+u8                            tcp_nospace             read_mostly         read_mostly         tcp_check_space(tx);tcp_check_space(rx)
 u64                           bytes_received                              read_write          tcp_rcv_nxt_update(rx)
 u32                           segs_in                 read_write          read_write          tcp_segs_in(),tcp_v6_rcv(rx),tcp_v4_rcv()
 u32                           data_segs_in                                read_write          tcp_v6_rcv(rx)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a8c77719322f9caee305d954a107892c76d4ef7..d51aae60aa45bba31ae2f06b004383733caaf599 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -307,6 +307,10 @@ struct tcp_sock {
 		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
 		prev_ecnfield:2; /* ECN bits from the previous segment */
 	__be32	pred_flags;
+	u8	tcp_nospace;	/* mirrors SOCK_NOSPACE, but in a cache line
+				 * that tcp_check_space() already needs.
+				 * Can only be set if SOCK_NOSPACE is set.
+				 */
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
 	u32	rcv_nxt;	/* What we want to receive next		*/
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5e5f5f9b89a386568fc5efebfa3d3c7e1ff62683..1e1950dd184ec3daecd5f691a0c099382e873937 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -783,14 +783,35 @@ void tcp_done_with_error(struct sock *sk, int err);
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
+	if (sk_is_tcp(sk))
+		WRITE_ONCE(tcp_sk(sk)->tcp_nospace, 1);
+}
+
+static inline void tcp_clear_nospace(struct sock *sk)
+{
+	if (sk_is_tcp(sk) && !sk_is_mptcp(sk))
+		WRITE_ONCE(tcp_sk(sk)->tcp_nospace, 0);
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
index 11a22aec7e414152aab115e8d11e30067ab3775f..dce4e8e4e2bbef710eae641a270395a315bef56e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2969,8 +2969,13 @@ void sk_set_nospace(struct sock *sk)
 {
 	struct socket *sock = sk->sk_socket;
 
-	if (sock)
-		set_bit(SOCK_NOSPACE, &sock->flags);
+	if (!sock)
+		return;
+	/* Mirror first: callers relying on the barrier implied by
+	 * set_bit() + smp_mb__after_atomic() are then also covered.
+	 */
+	tcp_set_nospace(sk);
+	set_bit(SOCK_NOSPACE, &sock->flags);
 }
 EXPORT_SYMBOL(sk_set_nospace);
 
@@ -2985,8 +2990,13 @@ void sk_clear_nospace(struct sock *sk)
 {
 	struct socket *sock = sk->sk_socket;
 
-	if (sock)
-		clear_bit(SOCK_NOSPACE, &sock->flags);
+	if (!sock)
+		return;
+	clear_bit(SOCK_NOSPACE, &sock->flags);
+	/* Mirror last: a stale mirror only costs a slow path, while a
+	 * stale SOCK_NOSPACE would cost a missed EPOLLOUT.
+	 */
+	tcp_clear_nospace(sk);
 }
 EXPORT_SYMBOL(sk_clear_nospace);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1cde000cfab4704e6756872f6ddec16851ccc55d..92728e4c1e3df928cc7aa1bcbcf93fb15afaa28e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5261,6 +5261,7 @@ static void __init tcp_struct_check(void)
 
 	/* TXRX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, pred_flags);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, tcp_nospace);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, tcp_clock_cache);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, tcp_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_nxt);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 92bc60716f33d81e9ce90d9de2e5d989ba71c8a3..914d708326bf841641a4519341bfd77deba9e7e0 100644
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
2.55.0.1082.g2b9226bbc0-goog

