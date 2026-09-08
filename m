Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE985309F08;
	Tue,  8 Sep 2026 03:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788836411; cv=none; b=XFNJBK4Fn+eSdjshTnQCufrzutqeeoO5CbUzVAKtejtaTvSpVFplA5uYKSVlgZ+Of1Whs3k3H1d5Bu4WNQFz4C47Q/udaN3gOTUkL5/oOxPB/Qy+QQ7E3IvgU5sJGz/tE+YH68VxeVpCHvFfYwlj9rCbm/fDHGvdYHNEy/+EbQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788836411; c=relaxed/simple;
	bh=H+3cMeoBF7+P0cb8pgXCTG/4UZ7JdxRxsC+q5xqOw2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ta1oUaocZBU/Q1kNfGDZ6Ik8UN39gpc3j5r83K6ClWevXq/D9FP+v5auLq5Bz9lTvu4ZkMGbF+6vX7zVkN+P9lQRfWBj5lDr1Gns+EJUdtBz24eMqd5XgK9wt/+r94N7bYkoPmw9+JgrGo6Ahwwzqzjbyh8mVUJmXcZhLIqCbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yz5h6b4E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yz5h6b4E"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 633D0C2BCC7;
	Tue,  8 Sep 2026 03:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788836411;
	bh=H+3cMeoBF7+P0cb8pgXCTG/4UZ7JdxRxsC+q5xqOw2E=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Yz5h6b4ElZR+O2sr5VRFguJeYr5hn0SIyaflYW3jUe9k2NWjNVBsavs6/ilWg6Yv+
	 2viLIBL8f9oUQV510fvn1azDcWEx0OAVRLvaeof45SWTwtsGjboNSjiam/0F7v5rLL
	 n5JLoKkjkaOsjUJ2BuzrYmOOc6OEoFHqSZTq49+cm4fxXL3YCx6kdIJ4DkYYgDeXT5
	 uBeca4W0VJhX7WYdlpzk+550VV/uOGAgQknN6fT7Bqg8oPTypWxe5US+fRttepiQtj
	 /OfhvD1f9jSiqr+e+XLpWo+OJ+d/uFSGNb2aP9og+IxpMOwAmTX5/r9QS7J3QW1GJW
	 8YCT6I0AaQAwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA08C79F9F;
	Tue,  8 Sep 2026 03:00:11 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Tue, 08 Sep 2026 10:59:58 +0800
Subject: [PATCH net] tcp: fix data-race in tcp_recv_should_stop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-mptcp-sk-err-net-v1-1-da71aaec9afd@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ7CMAwEv1L5jCVTFQh8BfUAYQMGESI7IKSqf
 yfAcVY7M5HDFE67biLDS10fucFy0VG8HPIZrKfG1Eu/lq0EvpcaC/uNYcYZlTcphYAkKxkGalo
 xJH3/kntqBxr/oz+PV8T6jdE8fwBOehg3eQAAAA==
X-Change-ID: 20260908-mptcp-sk-err-net-7ff88ef05044
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Quanye Yang <quanyeyang@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788836410; l=3380;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=aVD2Wy+C2Sd5Y8HCYwrqgTQ88TLljMqiVxf6EXpAQ2M=;
 b=DZaxjjeF5h5EPEKOuqP9tYOn8GIuV4AEQ6hyK5BKm7tPeAcH0LLEUFKTA0wJIMc/HgWmWOsXW
 1wUGmPsA+GVB5j0owZlUsT0LJiow8C3G8zvTrN6f6a2GV8siHYkxgjf
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

do_recvmmsg() calls sock_error() without the socket lock. sock_error()
clears sk_err with xchg(), which races with the unmarked load in
tcp_recv_should_stop(). The same race exists for plain TCP with
concurrent recvmmsg() readers; KCSAN reported it on an MPTCP socket
because mptcp_recvmsg() uses this helper.

Use READ_ONCE() for the lockless peek. No extra ordering is needed:
the value is only used to decide whether receiving should stop.
This does not consume sk_err; the check-then-sock_error() TOCTOU
on the no-data paths is a separate issue.

Fixes: eb477fdd6803 ("tcp: add recv_should_stop helper")
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
Link: https://lore.kernel.org/all/14749060-d011-41e7-9a4b-754eb5bd9d5b@redhat.com/
---
 include/net/tcp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 436495ff2271..c61d8678eafd 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -3082,7 +3082,8 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
 
 static inline int tcp_recv_should_stop(struct sock *sk)
 {
-	return sk->sk_err ||
+	/* sk_err can be cleared locklessly by sock_error(). */
+	return READ_ONCE(sk->sk_err) ||
 	       sk->sk_state == TCP_CLOSE ||
 	       (sk->sk_shutdown & RCV_SHUTDOWN) ||
 	       signal_pending(current);

---
base-commit: 38b6be101006d3e7af972999f45d4f1e8250587a
change-id: 20260908-mptcp-sk-err-net-7ff88ef05044

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


