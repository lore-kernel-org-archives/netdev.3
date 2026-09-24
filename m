Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FBE336886
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257657; cv=none; b=VRw/LzusSRyCgFaai9Mcp6z3d23v7kWoqzF0APpbHOgHjAIlmLKiTDxnG2/OT+1Cgw8AMtvCUwp6b6N4fsamEnYMq0JQDJZlrVRaFO1MWCQ4mIz/bmRaXdEwxKPj11JztX1zi98yg0+Pp8wfbVUGFfra3q7q5yjlFtaflrzbtj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257657; c=relaxed/simple;
	bh=vf4vXMyutyVqzwxI3RbKjnycOiOG0C8YIum5q4GSzxg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jpeCweuF+lYN1eXHBbIPPzCxYPvDd3sqpmva0StkRYrm+G5XJ/KkBWXFwWVZys1L1iJh+dl6czzvD/rqFOaWmMqNd5FPQ9Q9Q8BSR1gyviGQox45FqRDfYEixUT3DwWIbdwV9IZAYMOx9yx19+zMXoBqKmI7Nzcp990uWBawhss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=umgQ0yo9; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umgQ0yo9"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a0312937eso251696685a.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790257654; x=1790862454; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZcGdbw8WHhv3w8flR5N5B14Qn7lScEPYePCeb49AvAY=;
        b=umgQ0yo9kOrYlYi1iDs8k7YmXOyQKOp+bOqoJmdUFXhlBkL+lYcip3OC8vYvtvvz2e
         V82R/rXK/WcXGf9pn+zB4cDtsoc69j/c4ir56bxnu1r30AOwCFC31BgcfijG2Uc3r/eH
         NgeteTq/O2cwIAPUhkCoCInV0XQPERUyEMKFZVJi+l1PFbQsbiNxUGlJKoJzgtD9irSr
         MCZP2myWOQXZgAqCa6xpgejtEXvFV5PhNbEdUGTQZwyYOuv+Pdol//J33RGJltCcKR2Z
         avIWnk5d1juuaLvuyMmWpDMjYqi7zFSvUozLV0VgBIWxZ8+3ff1IQlftC5KoHjNg2hxo
         yRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257654; x=1790862454;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZcGdbw8WHhv3w8flR5N5B14Qn7lScEPYePCeb49AvAY=;
        b=utrNSK14VNvLE0v7PYeJC8T5aYjAv+dGODQ0CpO+OnY8FaJdF9w2XeWo4JsV8TONMZ
         hg5ufhYkapw4s9IHMWNXLFpEEvg4Fqd/8NbiN+0UyAg3CYjDOwku+JQWqmRAJnJqjrxh
         Dje8NRbeWziJnjdDf+Tc3x8MpXVmslAa1rPIIy0n+N4YDYovfYpkjJqRFJrqnvAE3xKq
         s9XxVu/TsLdhEJ1fZlnBfP88gLXR7qZyajJOJFGteRoWKUXP35xQOMEKfiY3oMZB/9Sr
         kJtLPb2u7CKUA9KG4z7YeT6E120i3K0X9G3HuV/X+kZ4/dAf+r/t7G3b6GtXSQK/pv/5
         hIvg==
X-Forwarded-Encrypted: i=1; AKwUvBxYYUCq8dvZ/OD3KIyhufWleAbalSDNHTfhBMk5W/+7w+G2M84kKbT/hPSaikuz1JGHZQHzaDg=@vger.kernel.org
X-Gm-Message-State: AFuF++mSqPOTbFwFj+91fSNM22F1JpR+iTIL22f1rcy7besDNjC+hiJl
	lvUv7gDr4CbeLJKhPNafI/inHToP4+n1P59HxEG1WxBGl5yQT5bblElfeZIxREFbSb4WvqLA7ct
	zMJU19Yui2IHlEA==
X-Received: from qkr16.prod.google.com ([2002:a05:620a:490:b0:93a:20b6:ebe5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:19a6:b0:93b:eb9a:ca47 with SMTP id af79cd13be357-93c3639e404mr277523685a.31.1790257653909;
 Thu, 24 Sep 2026 06:47:33 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:47:22 +0000
In-Reply-To: <20260924134729.2047213-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924134729.2047213-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924134729.2047213-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/9] net: add sk_set_nospace() and sk_clear_nospace()
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

Add sk_set_nospace() and sk_clear_nospace() helpers and convert the
core networking setters and clearers to them; the following patches
convert the remaining subsystem callers so that
"git grep _bit(SOCK_NOSPACE" only reports the two helpers and the
remaining test_bit() sites.

Callers that had no NULL check are all called from user context with a
socket attached, so folding the check into the helpers only makes them
more robust.

No functional change intended.

This is a preparation patch: a following one gives TCP a cheaper
private copy of this bit, and needs a single choke point to keep it
in sync.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
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
2.56.0.rc1.310.g51773c2048-goog

