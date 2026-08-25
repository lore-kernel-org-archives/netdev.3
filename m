Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3153148C9
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 02:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625379; cv=none; b=NjP0nqlitH486Y2VQecRq5gpSEsXr1LrbHGJkZjHMhxTeC45NXH7YNNdYPueTt+Qn1ZHiEoiKOaFfkW+TEEmm5ArM8/TKP+YAImxJ2QHJ2T3PzlgyldKu+kuJJk/8P7nZ/HbFbe4yiv0mUuPAohQA0+4XuIm308/J947lWdPuvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625379; c=relaxed/simple;
	bh=MaekYfP6yHNfYBcCPb3y4Mw3+SboXBs/BQ5ex5RmME0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Gyc/CYpEywZUKgGYAj06WWJAXYHhVJ+frqYEqgU4WAZ6h/6P776Efs3L9JMzZfF8KbNLvMIUzOE8nDrqk/bKT2EtClTL/+A/mUEmoGc4fPp7w2x3HalWOirWDKdl7IudkAFEQ8u8BMCXROf+uO1EJTI3hRlsWjTAsWyBFT9QsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S6d0PBL/; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S6d0PBL/"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9368b4c5964so327290485a.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 19:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787625376; x=1788230176; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mey2z7MBDyx5oTc7EMMk3YFV5rom+XznTjBRDbZHmzA=;
        b=S6d0PBL/Nacwuknx8WNy5R+HilNVG1/SzHai5y5XF9Lx75sgwiD6beXrI2z0LRLDPs
         WWZEJtifmq+MSYlVnrvef9U5m88/CISPCejoB2QWjpaIeR88pzzyBF2eFvu7P59Am9er
         fCQ8H55Swa7jo6FpzHp9wngB9lQOJuQTjb20UlEmr9UqA/kkXjuhVxFKUABQGZgcwRLl
         FnNGnAnYBUzoOB/H5VO0fOz8FOB1MUjDtSmHTgSFr7aLKU13U3XUlahW7wnB6BztRxwj
         C4veO8US76oCMR6CfmkbIyK0mgwJfQT/2daqTzynKhd8Loi7gSaArG4b8ByrOK2LwlkE
         51oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787625376; x=1788230176;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mey2z7MBDyx5oTc7EMMk3YFV5rom+XznTjBRDbZHmzA=;
        b=dMc93kt23UrMAz0CPiFkv5IWw1nYM/ICJmXbxj3XmIpItdhBsrpAUFO597COBbyWdN
         OwR7TV/SSGGhF2Qzutx5+/OxYyCiNG3gD+ptzi6XXWIirlLx8bVlW7vrkWhTkGt+3zlM
         o4peaHH7YBr6nTE/NSxv/VIyWrZbwjosNUymeFfwvLjQ1bAaC1oX/ILk0YzTGdfL2Z9B
         9doHhCwUZeYRevavdcKsNiwZqdCYtzTwpUd+Mbi1xzDbi0gA5ydV0AgS0h7xZ8dmCc8o
         Km3RWtLu0vxyJ8kwHJqat6Q88AOcn9A9G+2k7g02Cs0hDKnHYmvBFA61bFkdq5z8aRwe
         FsEg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3cnPVJua3fYfJCFTLDdqFxc3oNogzQ6Z+V5PVJfO7J23fesVDDhR0NOmBC5upEEb3rQGoJAc=@vger.kernel.org
X-Gm-Message-State: AFuF++ldR/BPpQG1iO4++kJrR6ySsnxAhSWiAsh7mvI4Kpdut9X6rHxw
	USPDQzN9dKFmGEcpWjZ+XOcuo6s45QervSaA5OQ0ErOIx87TSMfqbaKJ/54x/k4t2psb7QmE3UW
	XwnZaw/fXtUr5dg==
X-Received: from qkpc42.prod.google.com ([2002:a05:620a:26aa:b0:92e:6796:933])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:8084:b0:914:b9a2:f29d with SMTP id af79cd13be357-9376b8f9f6emr757775085a.37.1787625375787;
 Mon, 24 Aug 2026 19:36:15 -0700 (PDT)
Date: Tue, 25 Aug 2026 02:36:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260825023614.1228551-1-edumazet@google.com>
Subject: [PATCH net] tcp: use GFP_ATOMIC in tcp_send_active_reset()
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

Hardcode GFP_ATOMIC inside tcp_send_active_reset() and remove its
priority argument since all callers now use GFP_ATOMIC.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     |  3 +--
 net/ipv4/tcp.c        | 14 ++++++--------
 net/ipv4/tcp_output.c |  7 +++----
 net/ipv4/tcp_timer.c  |  6 +++---
 net/mptcp/protocol.c  |  3 +--
 net/mptcp/protocol.h  |  2 +-
 6 files changed, 15 insertions(+), 20 deletions(-)

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
index f2709d585edbd9d9fef97953920edfcb7c45e61c..19a799e5d5ce3b55c57e2557d21a8d44982db714 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3849,15 +3849,14 @@ void tcp_send_fin(struct sock *sk)
  * was unread data in the receive queue.  This behavior is recommended
  * by RFC 2525, section 2.17.  -DaveM
  */
-void tcp_send_active_reset(struct sock *sk, gfp_t priority,
-			   enum sk_rst_reason reason)
+void tcp_send_active_reset(struct sock *sk, enum sk_rst_reason reason)
 {
 	struct sk_buff *skb;
 
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTRSTS);
 
 	/* NOTE: No TCP options attached and we never retransmit this. */
-	skb = alloc_skb(MAX_TCP_HEADER, priority);
+	skb = alloc_skb(MAX_TCP_HEADER, GFP_ATOMIC);
 	if (!skb) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTFAILED);
 		return;
@@ -3869,7 +3868,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority,
 			     TCPHDR_ACK | TCPHDR_RST);
 	tcp_mstamp_refresh(tcp_sk(sk));
 	/* Send it off. */
-	if (tcp_transmit_skb(sk, skb, 0, priority))
+	if (tcp_transmit_skb(sk, skb, 0, GFP_ATOMIC))
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTFAILED);
 
 	/* skb of trace_tcp_send_reset() keeps the skb that caused RST,
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
2.55.0.860.g4b6b3295ed-goog

