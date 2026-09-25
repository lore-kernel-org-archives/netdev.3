Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9BC49B5CF;
	Fri, 25 Sep 2026 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340529; cv=none; b=gmenT7+1t66zXaEdODGV2uoIrRATBR4IhwwU5JyqHTCG+i/c2Xu+OZdFkZ29A8Zfq8iIeQwBIRaT+JWM4SqQNrGGfIPrjaU5H/y+S2kHoHNd/tWFz/umJUuwoplzLnKi0UQr1rarYSuMhxHHOh8//Rg4RUakAQvGhhr8B3ntSvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340529; c=relaxed/simple;
	bh=Lluhve9GLVZnyHypq6cbVhVLfV+2j0GiaQHO1Z0qb+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jBGrFHhXuMvXktn7M3i5S+b2p3u8+ADqlpMWC4iTLYG9M4XN4cv1x1kQ+N+/PTGSo1+/1fPbnmfys3PVb3EQSVuoOXb9wo2HukQodOP3CHpqT+KJfjkBYHPpn1Y/huGycBvb1+meTejJLeyFHdqqSEY9hDY4ezFxK/ztM6wcjak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNkBqB6d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNkBqB6d"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 661D0C2BCF7;
	Fri, 25 Sep 2026 12:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790340529;
	bh=Lluhve9GLVZnyHypq6cbVhVLfV+2j0GiaQHO1Z0qb+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qNkBqB6dE9PreFzMmseSz1TUGL6DNOLqlGpF46u2LtpcJp9gjtu1Tymd460z9Sxg0
	 0OAKZieA/suBGBL03zZAqN9ubNBgQ4vt6oQEnCrIHjd67S1A7PvgD1TllAxyhQ4jA6
	 qa4g3Ls99hQ6DJxTyj5NaYVpKjuzP1Ce5pOx+qY02QZsQU+r1EESmW8vbXPlKdPKGd
	 kJXPxGpru+sLdkGBZ7EPCiKm5RrF4imiEx6cq7FI/0HM7syGOCBlstjt4m1rEYAgzo
	 YE3OwJUayXSwUE+X4Q75ZH4ZJPPvUUF1+k+DVl71xPx1n5+xhPK5MvjE0OY/dRnWIb
	 m4LsJQeO/hd7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FFEC9830E;
	Fri, 25 Sep 2026 12:48:49 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Fri, 25 Sep 2026 05:47:56 -0700
Subject: [PATCH net-next v5 1/2] tcp: annotate lockless access to
 sk->sk_err
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-mptcp-sk-err-net-v5-1-0cac04d6ea48@proton.me>
References: <20260925-mptcp-sk-err-net-v5-0-0cac04d6ea48@proton.me>
In-Reply-To: <20260925-mptcp-sk-err-net-v5-0-0cac04d6ea48@proton.me>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790340527; l=5980;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=Kwtze8JDbZEv7VBa6/V5Zow9Hc5QtyIt72rJmzREsX0=;
 b=u5BZ+HmFR6KjPwk5HX45h1ifT1bFS6WBKp6hrm40HCGmX/U3rbaqatTxeLxJ3qF+Hl9pP+amn
 KzU7Stgr2GVC0Me9gYLyLIwP2TQCyjC9Vc2EMRPZ3jvQvtPJm0yEn0a
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

BUG: KCSAN: data-race in do_recvmmsg / mptcp_recvmsg

read-write (marked) to 0xffff8880134d391c of 4 bytes by task 2619 on cpu 1:
 instrument_atomic_read_write include/linux/instrumented.h:113 [inline]
 sock_error include/net/sock.h:2565 [inline]
 do_recvmmsg+0x50c/0x580 net/socket.c:3049
 __sys_recvmmsg net/socket.c:3144 [inline]
 __do_sys_recvmmsg net/socket.c:3167 [inline]
 __se_sys_recvmmsg net/socket.c:3160 [inline]
 __x64_sys_recvmmsg+0x161/0x180 net/socket.c:3160
 x64_sys_call+0x19c7/0x1ca0 arch/x86/include/generated/asm/syscalls_64.h:300
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0xde/0x3d0 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff8880134d391c of 4 bytes by task 2620 on cpu 0:
 tcp_recv_should_stop include/net/tcp.h:3086 [inline]
 mptcp_recvmsg+0x54d/0xd50 net/mptcp/protocol.c:2466
 inet_recvmsg+0x204/0x210 net/ipv4/af_inet.c:894
 sock_recvmsg_nosec net/socket.c:1151 [inline]
 sock_recvmsg+0x11a/0x140 net/socket.c:1173
 ____sys_recvmsg+0x14b/0x3c0 net/socket.c:2933
 ___sys_recvmsg+0x116/0x160 net/socket.c:2975
 __sys_recvmsg net/socket.c:3008 [inline]
 __do_sys_recvmsg net/socket.c:3014 [inline]
 __se_sys_recvmsg net/socket.c:3011 [inline]
 __x64_sys_recvmsg+0xeb/0x160 net/socket.c:3011
 x64_sys_call+0x1319/0x1ca0 arch/x86/include/generated/asm/syscalls_64.h:48
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0xde/0x3d0 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000006b -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 2620 Comm: syz.2.33 Not tainted 7.2.0-g39d4f32c5d53 #76 PREEMPT(full)
Hardware name: QEMU Ubuntu 26.04 PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014

do_recvmmsg() and getsockopt(SO_ERROR) call sock_error() without the
socket lock. sock_error() clears sk_err with xchg(), which races with
unmarked loads of the same field.

KCSAN reported the unmarked peek in tcp_recv_should_stop(). Annotate
that helper and the other send-side peeks with READ_ONCE().

On the no-data recv and splice paths, if (sk_err) followed by
sock_error() and an unconditional break can return 0 after another
thread consumes the error. Call sock_error() once and only stop when
it returns a non-zero error.

tcp_bpf_sendmsg() read sk_err twice; fold those unmarked loads into
one READ_ONCE() and use that value as the returned errno. The field
is still not consumed.

MPTCP is handled in the next patch.

Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://lore.kernel.org/netdev/8bbee583-6f21-4817-bfeb-2d60057380a3@linux.dev/
Reported-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/632
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
 include/net/tcp.h  |  2 +-
 net/core/stream.c  |  2 +-
 net/ipv4/tcp.c     | 12 +++++-------
 net/ipv4/tcp_bpf.c | 10 ++++------
 4 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5e5f5f9b89a3..8b1e1f0070a3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -3093,7 +3093,7 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
 
 static inline int tcp_recv_should_stop(struct sock *sk)
 {
-	return sk->sk_err ||
+	return READ_ONCE(sk->sk_err) ||
 	       sk->sk_state == TCP_CLOSE ||
 	       (sk->sk_shutdown & RCV_SHUTDOWN) ||
 	       signal_pending(current);
diff --git a/net/core/stream.c b/net/core/stream.c
index 2d748581862d..5c0adc3077f0 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -133,7 +133,7 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 	while (1) {
 		sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 
-		if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN))
+		if (READ_ONCE(sk->sk_err) || (sk->sk_shutdown & SEND_SHUTDOWN))
 			goto do_error;
 		if (!*timeo_p)
 			goto do_eagain;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1c867a302444..35036e532275 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -843,10 +843,9 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 				break;
 			if (sock_flag(sk, SOCK_DONE))
 				break;
-			if (sk->sk_err) {
-				ret = sock_error(sk);
+			ret = sock_error(sk);
+			if (ret)
 				break;
-			}
 			if (sk->sk_shutdown & RCV_SHUTDOWN)
 				break;
 			if (sk->sk_state == TCP_CLOSE) {
@@ -1228,7 +1227,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	mss_now = tcp_send_mss(sk, &size_goal, flags);
 
 	err = -EPIPE;
-	if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN))
+	if (READ_ONCE(sk->sk_err) || (sk->sk_shutdown & SEND_SHUTDOWN))
 		goto do_error;
 
 	while (msg_data_left(msg)) {
@@ -2760,10 +2759,9 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 			if (sock_flag(sk, SOCK_DONE))
 				break;
 
-			if (sk->sk_err) {
-				copied = sock_error(sk);
+			copied = sock_error(sk);
+			if (copied)
 				break;
-			}
 
 			if (sk->sk_shutdown & RCV_SHUTDOWN)
 				break;
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 2e234d155b5e..338c5d90e550 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -286,10 +286,9 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		if (sock_flag(sk, SOCK_DONE))
 			goto out;
 
-		if (sk->sk_err) {
-			copied = sock_error(sk);
+		copied = sock_error(sk);
+		if (copied)
 			goto out;
-		}
 
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
 			goto out;
@@ -553,10 +552,9 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		bool enospc = false;
 		u32 copy, osize;
 
-		if (sk->sk_err) {
-			err = -sk->sk_err;
+		err = -READ_ONCE(sk->sk_err);
+		if (err)
 			goto out_err;
-		}
 
 		copy = msg_data_left(msg);
 		if (!sk_stream_memory_free(sk))

-- 
2.55.0


