Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C47235295C
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824798; cv=none; b=l4+E/cyOHsKRj7d73oLt5BwJCfVrn7ebAivl6I3b5MqNgW+TKr3R5+DrSzih16dAO040ZArZU6rV5dINijSeL0YB7hOxwy8hDVnM24mT90Kk66NTtw/7ahdbRad4tVzGEUl053M7X1MQ3FlZhgsvZ/dCdDtKGy/4xnomlSil0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824798; c=relaxed/simple;
	bh=h7G3/kC+p8D1kUbhgBcyAsgXcspLGJsAuz7vfvbqZ0w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rWYcmuW0uJLQ4AjOK8to2AjEtJjCQWno/lZYK2cS8OzwYz86preTGHi6u3s9tzvDoGOv5weHMtoiVUYXehKgDHxmt5dzqOkxAxanti2pmJYGPmIesS2xDu4e91wbuScEPdU1rHxyD6s2PuJZH2jmMbz63pxWV74PiF9a756aEw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CG2BSFet; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CG2BSFet"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ec3146553so312993585a.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 02:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787824778; x=1788429578; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FBIzrg8ZFKoNTtfDO8edGrIoQ09TXt9xuNZA8cBP54Q=;
        b=CG2BSFetK9MyOU601BDRfJdGMrJ4J6i9Dw6hErb6cG2Cvp/vYUAWAZg1tTzOSipBij
         XA7BBdwCkyoIXO164XGyxCuauEnJKX3aNLUivor0vA+k6HVrgsfonMGz3cD7rUY082l+
         4Wyih7zNmIvQhYq1ZNL+wUdTvUnizpQy8W1GimpmWaCB/tYQnScSiJQdlHH2DDJWuBON
         4gT+o2vwhpUG4sa7gZpHp+UYy+S+8OZPCOiXXzimrSlkyIolV2tur3RsSBJKcPCXF1KM
         0QCAbhmUsP+/4Jl0wmz5F55PUyNAjWzNseAEHuvgLlKS2ZYYYuRlMvyyx/GAFwcDktWk
         2KnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787824778; x=1788429578;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FBIzrg8ZFKoNTtfDO8edGrIoQ09TXt9xuNZA8cBP54Q=;
        b=nN0n5n1XOhvalgF8nGbKCN/Ol44OXvtteDxfH+tocdE3oXLg8CWqfhDbHZY8ZoReC7
         wYvuKT/RZgCaOis7HIsQBW31fTM1DDO2WsKjVmhIPrv/RTd5QcQjOcH9UY7ROzf2BdS7
         kW9yri6pe7WgOySCzd1Oy2wf9+Yg64FthoYiQRbuSBDWx9WnoW8GGMNftazHhlBfLKry
         p1mhq5eGREoBUukdsMlz03eumrXozSfFxPSJxDkG5B7Pts+xnm90cyqZN5yn1zl1b8he
         dYQe0hmmrwUhR116Q1gqHfzlNpRx56PEsXunU/mlq1c7YYL+jFhXsU+KBkMXAD8zMekV
         oi2w==
X-Forwarded-Encrypted: i=1; AHgh+Ro28NzK/GrgHbgI3ZKGTr2aKjbSksrjY7yseZwDlzJ0z/v8DT+cvJSHT6ZAQ4UlzV+qYoxdHP8=@vger.kernel.org
X-Gm-Message-State: AFuF++nBQKuBufd/vvgUO8CJ+ZJcTGxFkYRpQ0JI5NmsoOXBhDceBdE/
	CLqBXpPCX31WjvaX6KYwPfZnpgOrOl8FAu5t2Ux4zTDEL3c4QVo5NsjisXh0vt8i5VZqCiY1H+J
	fcTxo4SEI8E7xeA==
X-Received: from qkac8.prod.google.com ([2002:a05:620a:2008:b0:934:95c3:41d6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:708c:b0:92e:f380:dabf with SMTP id af79cd13be357-937803ebd11mr1266668485a.30.1787824777658;
 Thu, 27 Aug 2026 02:59:37 -0700 (PDT)
Date: Thu, 27 Aug 2026 09:59:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260827095936.551524-1-edumazet@google.com>
Subject: [PATCH v2 net] tcp: use GFP_ATOMIC in tcp_send_active_reset()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_send_active_reset() can be called from contexts where gfp_any()
(in tcp_disconnect()) or sk->sk_allocation (in __tcp_close() and
mptcp_do_fastclose()) evaluates to GFP_KERNEL, which includes
__GFP_FS and __GFP_DIRECT_RECLAIM.

Allocating with GFP_KERNEL while holding the socket lock (sk_lock) creates
a lockdep dependency:
  sk_lock -> fs_reclaim

This causes false-positive lockdep circular locking warnings with storage
subsystems (such as nvme-tcp) that acquire socket locks in block I/O paths
and invoke tcp_disconnect() or close sockets upon teardown:
  set->srcu -> sk_lock -> fs_reclaim -> elevator_lock -> set->srcu

Active resets are small RST packet headers that should never
enter direct reclaim or block while holding socket locks.

Use sk_gfp_mask(sk, GFP_ATOMIC | __GFP_NOWARN) inside tcp_send_active_reset()
and remove its priority argument. This preserves __GFP_MEMALLOC access
for SOCK_MEMALLOC sockets, suppresses allocation failure warnings,
and aligns with other control packet allocations (e.g. tcp_send_fin(),
__tcp_send_ack(), tcp_xmit_probe_skb()).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: addressed actionnable Sashiko's feedback (https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825023614.1228551-1-edumazet%40google.com)
v1: https://lore.kernel.org/netdev/20260825023614.1228551-1-edumazet@google.com/

 include/net/tcp.h     |  3 +--
 net/ipv4/tcp.c        | 14 ++++++--------
 net/ipv4/tcp_output.c |  4 ++--
 net/ipv4/tcp_timer.c  |  6 +++---
 net/mptcp/protocol.c  |  3 +--
 net/mptcp/protocol.h  |  2 +-
 6 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 670c20876f265c14504c26f45b87763ae47d3127..436495ff2271de047423dbe33036b7c6d1556584 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -765,8 +765,7 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
 void tcp_send_probe0(struct sock *);
 int tcp_write_wakeup(struct sock *, int mib);
 void tcp_send_fin(struct sock *sk);
-void tcp_send_active_reset(struct sock *sk, gfp_t priority,
-			   enum sk_rst_reason reason);
+void tcp_send_active_reset(struct sock *sk, enum sk_rst_reason reason);
 int tcp_send_synack(struct sock *);
 void tcp_push_one(struct sock *, unsigned int mss_now);
 void __tcp_send_ack(struct sock *sk, u32 rcv_nxt, u16 flags);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b4237d0e994d6f9d754d2167023e3981a40b58f4..93d723d8c1098e421cb7e3596318acd20fd80233 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3182,8 +3182,7 @@ void __tcp_close(struct sock *sk, long timeout)
 		/* Unread data was tossed, zap the connection. */
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONCLOSE);
 		tcp_set_state(sk, TCP_CLOSE);
-		tcp_send_active_reset(sk, sk->sk_allocation,
-				      SK_RST_REASON_TCP_ABORT_ON_CLOSE);
+		tcp_send_active_reset(sk, SK_RST_REASON_TCP_ABORT_ON_CLOSE);
 	} else if (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime) {
 		/* Check zero linger _after_ checking for unread data. */
 		sk->sk_prot->disconnect(sk, 0);
@@ -3257,7 +3256,7 @@ void __tcp_close(struct sock *sk, long timeout)
 		struct tcp_sock *tp = tcp_sk(sk);
 		if (READ_ONCE(tp->linger2) < 0) {
 			tcp_set_state(sk, TCP_CLOSE);
-			tcp_send_active_reset(sk, GFP_ATOMIC,
+			tcp_send_active_reset(sk,
 					      SK_RST_REASON_TCP_ABORT_ON_LINGER);
 			__NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_TCPABORTONLINGER);
@@ -3276,7 +3275,7 @@ void __tcp_close(struct sock *sk, long timeout)
 	if (sk->sk_state != TCP_CLOSE) {
 		if (tcp_check_oom(sk, 0)) {
 			tcp_set_state(sk, TCP_CLOSE);
-			tcp_send_active_reset(sk, GFP_ATOMIC,
+			tcp_send_active_reset(sk,
 					      SK_RST_REASON_TCP_ABORT_ON_MEMORY);
 			__NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_TCPABORTONMEMORY);
@@ -3377,14 +3376,14 @@ int tcp_disconnect(struct sock *sk, int flags)
 	} else if (unlikely(tp->repair)) {
 		WRITE_ONCE(sk->sk_err, ECONNABORTED);
 	} else if (tcp_need_reset(old_state)) {
-		tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_TCP_STATE);
+		tcp_send_active_reset(sk, SK_RST_REASON_TCP_STATE);
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	} else if (tp->snd_nxt != tp->write_seq &&
 		   (1 << old_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
 		/* The last check adjusts for discrepancy of Linux wrt. RFC
 		 * states
 		 */
-		tcp_send_active_reset(sk, gfp_any(),
+		tcp_send_active_reset(sk,
 				      SK_RST_REASON_TCP_DISCONNECT_WITH_DATA);
 		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	} else if (old_state == TCP_SYN_SENT)
@@ -5147,8 +5146,7 @@ int tcp_abort(struct sock *sk, int err)
 	bh_lock_sock(sk);
 
 	if (tcp_need_reset(sk->sk_state))
-		tcp_send_active_reset(sk, GFP_ATOMIC,
-				      SK_RST_REASON_TCP_STATE);
+		tcp_send_active_reset(sk, SK_RST_REASON_TCP_STATE);
 	tcp_done_with_error(sk, err);
 
 	bh_unlock_sock(sk);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f2709d585edbd9d9fef97953920edfcb7c45e61c..3581384d097feea4cddc3c1f30404367aa93aaa8 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3849,9 +3849,9 @@ void tcp_send_fin(struct sock *sk)
  * was unread data in the receive queue.  This behavior is recommended
  * by RFC 2525, section 2.17.  -DaveM
  */
-void tcp_send_active_reset(struct sock *sk, gfp_t priority,
-			   enum sk_rst_reason reason)
+void tcp_send_active_reset(struct sock *sk, enum sk_rst_reason reason)
 {
+	gfp_t priority = sk_gfp_mask(sk, GFP_ATOMIC | __GFP_NOWARN);
 	struct sk_buff *skb;
 
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTRSTS);
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 1038e7ba9c2eb19279b431249b56f8a8e4ffaf74..e56eae4bc341e94880bf0d6d1435094dfaaf879f 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -126,7 +126,7 @@ static int tcp_out_of_resources(struct sock *sk, bool do_reset)
 		    (!tp->snd_wnd && !tp->packets_out))
 			do_reset = true;
 		if (do_reset)
-			tcp_send_active_reset(sk, GFP_ATOMIC,
+			tcp_send_active_reset(sk,
 					      SK_RST_REASON_TCP_ABORT_ON_MEMORY);
 		tcp_done(sk);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONMEMORY);
@@ -809,7 +809,7 @@ static void tcp_keepalive_timer(struct timer_list *t)
 				goto out;
 			}
 		}
-		tcp_send_active_reset(sk, GFP_ATOMIC, SK_RST_REASON_TCP_STATE);
+		tcp_send_active_reset(sk, SK_RST_REASON_TCP_STATE);
 		goto death;
 	}
 
@@ -836,7 +836,7 @@ static void tcp_keepalive_timer(struct timer_list *t)
 		    icsk->icsk_probes_out > 0) ||
 		    (user_timeout == 0 &&
 		    icsk->icsk_probes_out >= keepalive_probes(tp))) {
-			tcp_send_active_reset(sk, GFP_ATOMIC,
+			tcp_send_active_reset(sk,
 					      SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT);
 			tcp_write_err(sk);
 			goto out;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b474d03620a75d3df26fcae1a84901b965c6954e..e1f08f71cdb16b2bbecd5630bca895d651c17b4c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3109,8 +3109,7 @@ static void mptcp_do_fastclose(struct sock *sk)
 		 */
 		inet_csk(ssk)->icsk_ack.rcv_mss = TCP_MIN_MSS;
 
-		tcp_send_active_reset(ssk, ssk->sk_allocation,
-				      SK_RST_REASON_TCP_ABORT_ON_CLOSE);
+		tcp_send_active_reset(ssk, SK_RST_REASON_TCP_ABORT_ON_CLOSE);
 unlock:
 		release_sock(ssk);
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 06a107d4e8392269b42f3af7ac531764619107c1..87ccb84e9927ccb23b242c11d34eb69427362702 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -690,7 +690,7 @@ mptcp_send_active_reset_reason(struct sock *sk)
 	enum sk_rst_reason reason;
 
 	reason = sk_rst_convert_mptcp_reason(subflow->reset_reason);
-	tcp_send_active_reset(sk, GFP_ATOMIC, reason);
+	tcp_send_active_reset(sk, reason);
 }
 
 /* Made the fwd mem carried by the given skb available to the msk,
-- 
2.55.0.887.g758fc8c411-goog

