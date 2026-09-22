Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEB6542ECA
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080049; cv=none; b=bAeQtHTq/OVz9+tVIcrS/2jcsC/8xNcabUTbVCNq9Li6Gp5g0w0CS0jDrZWRAMHSNoA2q3TGlomKd4U5mk1JePPzpFTBByBk/t7Quz/LP2wOT7WNulU8xl6+XObYS0QSGYxD1+r2kXkKcvwPK3XgC5yjguNYs9i6p/SP7dbOSq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080049; c=relaxed/simple;
	bh=ljJ/zpKWHiOhnAmLVnJecqFQFMfuIMwjtRBsR5hf6iU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E/+Rb3b2hxc5N90C42bOFbMUcdijQ4zpXW03mJK8l0gXzRNB1SCFGec5uMUqkrKU/WdP0x7vzG8+27PjfRcA6ga0Fbxq0H21ZE9J3BHGy9QaiEvsmc/HzFn1kE4OWp/b25f8B8bPQLOaZZ3gxBpVNq4UHb1vcKV4mLRcCW9O4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0IGYAle; arc=none smtp.client-ip=209.85.221.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0IGYAle"
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c851df59edso1223877e0c.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790080045; x=1790684845; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PjlRP0YLFxt1h/G0q+t6bWjigSH8NfqsPurAGsDBSBw=;
        b=k0IGYAle9QbmpYQ50W0yZfQsc7kq642ivWoC3G2AMf8/u/QfJvJduOWdN8xZocYmug
         7B6lyFGEL7ikhcZyUDhSJ/8LpwIkJ4yTCRhXT1UE95zrbMkxJpmkax0cdZqKxmMv8b9S
         ORAP3QDr3ucXpXpw2TbdQPHN22xD0+7rLH6yELdDcQm1Y3aUn19tyiXwFuX+GlL3RY2k
         nz4q7Y6T416F/1t6uU8rimFgBqsXYzqnYm6KVq+o5j1haqpXXwX5EPvdyIPmJMfeQSc4
         /NoumcOi1dpr0hn+YCvFrVbFcYN8RB/PMoD22BaLlA+dVg1tA6bkg37u5n+7RJbCgJoj
         0IJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080045; x=1790684845;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PjlRP0YLFxt1h/G0q+t6bWjigSH8NfqsPurAGsDBSBw=;
        b=jQtW61Oh9x+EYyYR3FebEuFQ+CXTWOY9N+ZDFMZfQpAEzJbLAEyOKvZMBZxQYB7PZG
         XZkftbdN6T1zLaFvwZUW/78l/JGRtF6aVmM8BE88UOTY9Bvic/+KguC3vULeX9yoAtLP
         oMDf5xdbZhp+g/lm4pVLZ4bW04R8mCZpsDsuCDEKfMm+GEXGdK0SZlvUZ5cHaEGGPUj3
         KM3WFvSc48RTN1zoNMR0tVRIMDw+wkiIAiUkJVGkjrdYT68//CrQSxGZL1B83NEwUXJ7
         ujJdSaxzpBFqU4Bc9vDtqvvgkExW8Vm1NHciLyh+letyCyu9cMcxdDE3VjVGeGdT2sx/
         idnQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/wOqurcII8Zyc8kDtW7ljekg3ZMPitjwpXJppbtP2ljdriIMst/uQGWRM4kMkKtUz3AM+FJ8=@vger.kernel.org
X-Gm-Message-State: AFuF++nljKI20s7xJpf6r0bqgQthr/Dff/lWT+dP2LmN4t8RyGS0UGed
	MnoNmBYHaFeZWnjZfLqcbEtgf5ss2dwz3h6zXuKAfjg+TI1fIT/FalQivGugB6iWgKwJBxA9gsR
	gUnIOzjUBkAF21g==
X-Received: from qvbqt14.prod.google.com ([2002:a05:6214:2e8e:b0:912:c17:4bcb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6122:2202:b0:5c9:a60d:3275 with SMTP id 71dfb90a1353d-5c9b599cf61mr8550403e0c.9.1790080045304;
 Tue, 22 Sep 2026 05:27:25 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:27:13 +0000
In-Reply-To: <20260922122721.3568295-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922122721.3568295-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922122721.3568295-3-edumazet@google.com>
Subject: [PATCH net-next 2/9] net: add sk_set_nospace() and sk_clear_nospace()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

SOCK_NOSPACE lives in sk->sk_socket->flags and is manipulated from
about thirty places in the tree, all of them open coding the
sk->sk_socket dereference, some with a NULL check, some without,
and some reaching the struct socket by yet another path.

Add sk_set_nospace() and sk_clear_nospace() helpers and convert all
the setters and clearers to them, so that "git grep _bit(SOCK_NOSPACE"
only reports the two helpers and the remaining test_bit() sites.

Callers that had no NULL check are all called from user context with a
socket attached, so folding the check into the helpers only makes them
more robust.

No functional change intended.

This is a preparation patch: a following one gives TCP a cheaper
private copy of this bit, and needs a single choke point to keep it
in sync.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h   |  2 ++
 net/core/sock.c      | 37 +++++++++++++++++++++++++++++++++++--
 net/core/stream.c    |  6 +++---
 net/ipv4/tcp.c       |  4 ++--
 net/ipv4/tcp_bpf.c   |  2 +-
 net/kcm/kcmsock.c    |  4 ++--
 net/mptcp/protocol.c |  4 ++--
 net/smc/af_smc.c     |  2 +-
 net/smc/smc_tx.c     |  6 +++---
 net/tls/tls_sw.c     |  2 +-
 10 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 60ea55dc18854a9759f5df618cc8c904d2323e95..f4dd2e105171386f1b68f808175457c51aff183a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1129,6 +1129,8 @@ static inline void sk_forward_alloc_add(struct sock *sk, int val)
 }
 
 void sk_stream_write_space(struct sock *sk);
+void sk_set_nospace(struct sock *sk);
+void sk_clear_nospace(struct sock *sk);
 
 /* OOB backlog add */
 static inline void __sk_add_backlog(struct sock *sk, struct sk_buff *skb)
diff --git a/net/core/sock.c b/net/core/sock.c
index 2948dffcc3e1b49a9a55e30f1380ec165a88859f..11a22aec7e414152aab115e8d11e30067ab3775f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2957,6 +2957,39 @@ void sock_kzfree_s(struct sock *sk, void *mem, int size)
 }
 EXPORT_SYMBOL(sock_kzfree_s);
 
+/**
+ *	sk_set_nospace - tell the transport a writer is waiting for space
+ *	@sk: socket
+ *
+ *	Must be called before the final check of the available send space,
+ *	so that the transport can not miss the request and forget to call
+ *	sk->sk_write_space() once space is available again.
+ */
+void sk_set_nospace(struct sock *sk)
+{
+	struct socket *sock = sk->sk_socket;
+
+	if (sock)
+		set_bit(SOCK_NOSPACE, &sock->flags);
+}
+EXPORT_SYMBOL(sk_set_nospace);
+
+/**
+ *	sk_clear_nospace - tell the transport no writer is waiting for space
+ *	@sk: socket
+ *
+ *	Called from ->sk_write_space() handlers, once send space has been
+ *	made available to writers.
+ */
+void sk_clear_nospace(struct sock *sk)
+{
+	struct socket *sock = sk->sk_socket;
+
+	if (sock)
+		clear_bit(SOCK_NOSPACE, &sock->flags);
+}
+EXPORT_SYMBOL(sk_clear_nospace);
+
 /* It is almost wait_for_tcp_memory minus release_sock/lock_sock.
    I think, these locks should be removed for datagram sockets.
  */
@@ -2970,7 +3003,7 @@ static long sock_wait_for_wmem(struct sock *sk, long timeo)
 			break;
 		if (signal_pending(current))
 			break;
-		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		sk_set_nospace(sk);
 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 		if (refcount_read(&sk->sk_wmem_alloc) < READ_ONCE(sk->sk_sndbuf))
 			break;
@@ -3011,7 +3044,7 @@ struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
 			break;
 
 		sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
-		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		sk_set_nospace(sk);
 		err = -EAGAIN;
 		if (!timeo)
 			goto failure;
diff --git a/net/core/stream.c b/net/core/stream.c
index 2d748581862d0eda8523f6f371cd2402e1dd6e01..a853b60afdc35a4735c017eb16c748cf2fab1b99 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -37,7 +37,7 @@ void sk_stream_write_space(struct sock *sk)
 	struct socket_wq *wq;
 
 	if (__sk_stream_is_writeable(sk, 1) && sock) {
-		clear_bit(SOCK_NOSPACE, &sock->flags);
+		sk_clear_nospace(sk);
 
 		rcu_read_lock();
 		wq = rcu_dereference(sk->sk_wq);
@@ -143,7 +143,7 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 		if (sk_stream_memory_free(sk) && !vm_wait)
 			break;
 
-		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		sk_set_nospace(sk);
 		sk->sk_write_pending++;
 		ret = sk_wait_event(sk, &current_timeo, READ_ONCE(sk->sk_err) ||
 				    (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) ||
@@ -177,7 +177,7 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 	 * When TCP receives ACK packets that make room, tcp_check_space()
 	 * only calls tcp_new_space() if SOCK_NOSPACE is set.
 	 */
-	set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+	sk_set_nospace(sk);
 	err = -EAGAIN;
 	goto out;
 do_interrupted:
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3ac4856852794736c5d49f042ecd08e4246bdd6d..1cde000cfab4704e6756872f6ddec16851ccc55d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -607,7 +607,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 				mask |= EPOLLOUT | EPOLLWRNORM;
 			} else {  /* send SIGIO later */
 				sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
-				set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+				sk_set_nospace(sk);
 
 				/* Race breaker. If space is freed after
 				 * wspace test but before the flags are set,
@@ -1398,7 +1398,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		continue;
 
 wait_for_space:
-		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		sk_set_nospace(sk);
 		tcp_remove_empty_skb(sk);
 		if (copied)
 			tcp_push(sk, flags & ~MSG_MORE, mss_now,
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 2e234d155b5e616d496611d1f367c34ed90f3000..64d74d92af52d1ca2fa3d24910a254a5092466f2 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -602,7 +602,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			goto out_err;
 		continue;
 wait_for_sndbuf:
-		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		sk_set_nospace(sk);
 wait_for_memory:
 		err = sk_stream_wait_memory(sk, &timeo);
 		if (err) {
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 71af69d442f211996e514d8d76a4c9d658f7b352..b29c0ed9caf5220ff741584e49632da45626beb7 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -735,7 +735,7 @@ static void kcm_tx_work(struct work_struct *w)
 	/* Primarily for SOCK_SEQPACKET sockets */
 	if (likely(sk->sk_socket) &&
 	    test_bit(SOCK_NOSPACE, &sk->sk_socket->flags)) {
-		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		sk_clear_nospace(sk);
 		sk->sk_write_space(sk);
 	}
 
@@ -779,7 +779,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	/* Call the sk_stream functions to manage the sndbuf mem. */
 	if (!sk_stream_memory_free(sk)) {
 		kcm_push(kcm);
-		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		sk_set_nospace(sk);
 		err = sk_stream_wait_memory(sk, &timeo);
 		if (err)
 			goto out_error;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e89a69ab927c9139c68c9039327cb0e55c33356b..74b1a512072878a54b229bc80aa76bb3e417c862 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2106,7 +2106,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		continue;
 
 wait_for_memory:
-		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		sk_set_nospace(sk);
 		__mptcp_push_pending(sk, msg->msg_flags);
 		ret = sk_stream_wait_memory(sk, &timeo);
 		if (ret)
@@ -4472,7 +4472,7 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 	if (__mptcp_stream_is_writeable(sk, 1))
 		return EPOLLOUT | EPOLLWRNORM;
 
-	set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+	sk_set_nospace(sk);
 	smp_mb__after_atomic(); /* NOSPACE is changed by mptcp_write_space() */
 	if (__mptcp_stream_is_writeable(sk, 1))
 		return EPOLLOUT | EPOLLWRNORM;
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e9f93b3ab435bbcce0a493f24205bd91bdf15b6a..4f2afbbdef2d7e62431e14562dc26bdfcdaa9f79 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2919,7 +2919,7 @@ __poll_t smc_poll(struct file *file, struct socket *sock,
 				mask |= EPOLLOUT | EPOLLWRNORM;
 			} else {
 				sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
-				set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+				sk_set_nospace(sk);
 
 				if (sk->sk_state != SMC_INIT) {
 					/* Race breaker the same way as tcp_poll(). */
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 3144b4b1fe29013cabc63d72671d256761a4c367..52e5395484fd3e0c4b1356226ecdcf4fb190d487 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -48,7 +48,7 @@ static void smc_tx_write_space(struct sock *sk)
 	if (atomic_read(&smc->conn.sndbuf_space) && sock) {
 		if (test_bit(SOCK_NOSPACE, &sock->flags))
 			SMC_STAT_RMB_TX_FULL(smc, !smc->conn.lnk);
-		clear_bit(SOCK_NOSPACE, &sock->flags);
+		sk_clear_nospace(sk);
 		rcu_read_lock();
 		wq = rcu_dereference(sk->sk_wq);
 		if (skwq_has_sleeper(wq))
@@ -100,7 +100,7 @@ static int smc_tx_wait(struct smc_sock *smc, int flags)
 		}
 		if (!timeo) {
 			/* ensure EPOLLOUT is subsequently generated */
-			set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+			sk_set_nospace(sk);
 			rc = -EAGAIN;
 			break;
 		}
@@ -111,7 +111,7 @@ static int smc_tx_wait(struct smc_sock *smc, int flags)
 		sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 		if (atomic_read(&conn->sndbuf_space) && !conn->urg_tx_pend)
 			break; /* at least 1 byte of free & no urgent data */
-		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		sk_set_nospace(sk);
 		sk_wait_event(sk, &timeo,
 			      READ_ONCE(sk->sk_err) ||
 			      (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) ||
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d1ad31986cf2cee88afbde43a2908791eeabb0fb..312e51270f293dc4df8efbec498473c4c3b48d15 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -966,7 +966,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		continue;
 
 wait_for_sndbuf:
-		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		sk_set_nospace(sk);
 wait_for_memory:
 		ret = sk_stream_wait_memory(sk, &timeo);
 		if (ret) {
-- 
2.55.0.1082.g2b9226bbc0-goog

