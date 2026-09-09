Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F303A2DB780;
	Wed,  9 Sep 2026 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919520; cv=none; b=iT+esB0HwvmZNi2aGr1vlSBU4A5mez9ca+5+UWqM7mzE0jPmrDjGOPK3/V0c2vy0Cv93/qM+oykjd//5b0Ad/6Mg8Q4W+SC7ok2Vzpy6Hf4U4XWqiwdx9IS22Zgj3jdJ6cU+iRv/OUkVqrwC3GZQWJaIaseOTDTo2rGrSw0f9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919520; c=relaxed/simple;
	bh=4zqmSj58h7Tco5O5ICXl7nQpBduSBwP+wpfTaG0yjMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a51qPjtpJQZ3kI7U+1Jjbi/b5sdeOYE424Tfz98q4+c3FH3GbjHjvFOmQWdUfQrxugV0WHdjEgyTgF7SDrrjjiIYr4ldnaKoNcyNtf9D+yE42Vi4Rp/FxOjsDmnlNapgIy20kAtZuxz8mMQYlxXWA896d2tb+MHxqDtA7bc6kJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CC/UT0OM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CC/UT0OM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6922AC2BCB8;
	Wed,  9 Sep 2026 02:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788919519;
	bh=4zqmSj58h7Tco5O5ICXl7nQpBduSBwP+wpfTaG0yjMA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=CC/UT0OM2MtvR9AuHnhjjfvij6u5yq5HgrS+q1kgwg3toFmrx4iDakHSoVHCei1+w
	 UQN8nmcgj9HCFs/ASzZJxUaM+jvoDUobUpXVRyqwTbO2O1/0enn95oQzhcjUjhaAQx
	 PNmvZDDR2lVRhrZ3VWlSP33Y+Cq9iICDs9kTCX2Fa79ZcnKh5l3AfrvY8Si9K51gy+
	 mvhl+WocHwnPkZ3KDz8/5JcaeJjpAQpz3XCE8IOA7qH5urmUSAnF+b7D2/Q6wvP0tS
	 akc2MPs00baXkYeLrdXBuXnSHvSrGPIclDljNzW6JSq7KZyrZgvlVo7h62dvM6LpIV
	 vLjR+s2Ald7hQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44354C79FB5;
	Wed,  9 Sep 2026 02:05:19 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Wed, 09 Sep 2026 10:05:08 +0800
Subject: [PATCH net v2] tcp: fix data-race in tcp_recv_should_stop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mptcp-sk-err-net-v2-1-5044abecac90@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBBEf4Xs2TUtQQFP/IfhUMtWqqFttpVoC
 P9uwbPHN3kzs0AkthThUizANNtovctQHgrQo3J3QjtkhlKUZ9GKBqeQdMD4RGJGRwlrY5qGjDi
 JqoJcC0zGvvfJK2QB+l8YX7cH6bSNbdpoY/L82Y9nucv/P2aJEgdVS6VIt8oMXWCfvDtOBP26r
 l/zAnN8xwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788919517; l=3682;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=dJErtNJjTbHRqHJAsgAUQgVauvLdJ8L4HcDbe4mYVzA=;
 b=UpWHLgav9EkyotUa2n5ykWw6LJVh7yWZHp6hs7BCT4Ez31xmzU9zTR/67/MpD2YKXriHVKSfd
 PCLycswzloXAyvo1ZDnE+oX/27Z1be6rjYpruo0F16b1zrThIXhzD8I
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
Reported-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/632
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
Link: https://lore.kernel.org/all/14749060-d011-41e7-9a4b-754eb5bd9d5b@redhat.com/
---
Changes in v2:
- add Reported-by and Closes for the MPTCP syzkaller report
- Link to v1: https://patch.msgid.link/20260908-mptcp-sk-err-net-v1-1-da71aaec9afd@proton.me
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


