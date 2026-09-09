Received: from mta1.migadu.com (out-22.mta1.migadu.com [95.215.58.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063941397
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 02:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922687; cv=none; b=o0LcMT5MpEd3UFJOcNQ6eKeMOXt80hcIOyYLEuJjQmpn/aeueDllJ/ORvFaHsiYWbhAS25tjfHpikADS7a+4+d2pDPruLuLrYKi/JqFndaVOSVQXDIAiU/PZ7XQq0rnpZH7aiDoiZudAzMHoyA8aynbzPq54O1MRIMvfuUBH07E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922687; c=relaxed/simple;
	bh=lkc5mj4lW16ivPJ8rrhfx1h8FyU/NRPzkzLjWPo4X0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/HvTO+5pyO5446fKeR6Nv7WZ3qiE46hMa7fL7G8ZC1DfKWAHgoToi7OEMt3fD9WRMOl0HmeY7sPdDeG+bOOS/WryR2g4l6BPLzvzlFpWAblrtTuir2XLO9cYHRX7y5nTuizHzHHdr378gEtYor6PeNI1jt/88AkYOAMf3xo/a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OWYdSwjV; arc=none smtp.client-ip=95.215.58.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OWYdSwjV"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lkc5mj4lW16ivPJ8rrhfx1h8FyU/NRPzkzLjWPo4X0M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788922682; v=1; x=1789527482;
 b=OWYdSwjVUpqSs+Vn9TqxkwcuUFMkZZ1dLMwV2lC7v0Wm684n7rs+xina7S/m4Lxf125Q00gf
 SSdpynspMaDujlnhBGp2zpa8Cx2z1IF7xKCT/BYXsBtBAc1yjeZYuCGXQh8/ntHwaukQ66H88Et
 aXjL34Q8Z6T/ku2aDa4gc13s=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b0e8a5b124b5113c;
	Wed, 09 Sep 2026 02:58:02 +0000
X-Mizu-Trace-ID: b0e8a5b124b5113c
X-Migadu-Flow: FLOW_OUT
Message-ID: <8bbee583-6f21-4817-bfeb-2d60057380a3@linux.dev>
Date: Wed, 9 Sep 2026 10:57:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] tcp: fix data-race in tcp_recv_should_stop
To: quanyeyang@proton.me, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260909-mptcp-sk-err-net-v2-1-5044abecac90@proton.me>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260909-mptcp-sk-err-net-v2-1-5044abecac90@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/9/26 10:05 AM, Quanye Yang via B4 Relay wrote:
> From: Quanye Yang <quanyeyang@proton.me>
>
> BUG: KCSAN: data-race in do_recvmmsg / mptcp_recvmsg
>
> read-write (marked) to 0xffff8880134d391c of 4 bytes by task 2619 on cpu 1:
>   instrument_atomic_read_write include/linux/instrumented.h:113 [inline]
>   sock_error include/net/sock.h:2565 [inline]
>   do_recvmmsg+0x50c/0x580 net/socket.c:3049
>   __sys_recvmmsg net/socket.c:3144 [inline]
>   __do_sys_recvmmsg net/socket.c:3167 [inline]
>   __se_sys_recvmmsg net/socket.c:3160 [inline]
>   __x64_sys_recvmmsg+0x161/0x180 net/socket.c:3160
>   x64_sys_call+0x19c7/0x1ca0 arch/x86/include/generated/asm/syscalls_64.h:300
>   do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>   do_syscall_64+0xde/0x3d0 arch/x86/entry/syscall_64.c:84
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff8880134d391c of 4 bytes by task 2620 on cpu 0:
>   tcp_recv_should_stop include/net/tcp.h:3086 [inline]
>   mptcp_recvmsg+0x54d/0xd50 net/mptcp/protocol.c:2466
>   inet_recvmsg+0x204/0x210 net/ipv4/af_inet.c:894
>   sock_recvmsg_nosec net/socket.c:1151 [inline]
>   sock_recvmsg+0x11a/0x140 net/socket.c:1173
>   ____sys_recvmsg+0x14b/0x3c0 net/socket.c:2933
>   ___sys_recvmsg+0x116/0x160 net/socket.c:2975
>   __sys_recvmsg net/socket.c:3008 [inline]
>   __do_sys_recvmsg net/socket.c:3014 [inline]
>   __se_sys_recvmsg net/socket.c:3011 [inline]
>   __x64_sys_recvmsg+0xeb/0x160 net/socket.c:3011
>   x64_sys_call+0x1319/0x1ca0 arch/x86/include/generated/asm/syscalls_64.h:48
>   do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>   do_syscall_64+0xde/0x3d0 arch/x86/entry/syscall_64.c:84
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x0000006b -> 0x00000000
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 2620 Comm: syz.2.33 Not tainted 7.2.0-g39d4f32c5d53 #76 PREEMPT(full)
> Hardware name: QEMU Ubuntu 26.04 PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
>
> do_recvmmsg() calls sock_error() without the socket lock. sock_error()
> clears sk_err with xchg(), which races with the unmarked load in
> tcp_recv_should_stop(). The same race exists for plain TCP with
> concurrent recvmmsg() readers; KCSAN reported it on an MPTCP socket
> because mptcp_recvmsg() uses this helper.
>
> Use READ_ONCE() for the lockless peek. No extra ordering is needed:
> the value is only used to decide whether receiving should stop.
> This does not consume sk_err; the check-then-sock_error() TOCTOU
> on the no-data paths is a separate issue.
>
> Fixes: eb477fdd6803 ("tcp: add recv_should_stop helper")


Is the Fixes tag right? eb477fdd6803 only moved the existing check
into a helper, the plain read was already there before.


> Reported-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/632
> Signed-off-by: Quanye Yang <quanyeyang@proton.me>
> ---
> Link: https://lore.kernel.org/all/14749060-d011-41e7-9a4b-754eb5bd9d5b@redhat.com/
> ---
> Changes in v2:
> - add Reported-by and Closes for the MPTCP syzkaller report
> - Link to v1: https://patch.msgid.link/20260908-mptcp-sk-err-net-v1-1-da71aaec9afd@proton.me
> ---
>   include/net/tcp.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 436495ff2271..c61d8678eafd 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -3082,7 +3082,8 @@ enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
>   
>   static inline int tcp_recv_should_stop(struct sock *sk)
>   {
> -	return sk->sk_err ||
> +	/* sk_err can be cleared locklessly by sock_error(). */
> +	return READ_ONCE(sk->sk_err) ||
>   	       sk->sk_state == TCP_CLOSE ||
>   	       (sk->sk_shutdown & RCV_SHUTDOWN) ||
>   	       signal_pending(current);


The lockless writers are sock_error() from SO_ERROR and recvmmsg(),
so every plain read of sk_err on a TCP socket has the same race, not 
only this helper:
     tcp_recvmsg_locked
     tcp_sendmsg_locked
     tcp_splice_read
     sk_stream_wait_memory
     tcp_bpf_sendmsg
     tcp_bpf_recvmsg_parser
     mptcp_splice_read
     mptcp_recvmsg

I'd drop the Fixes tag, target net-next and annotate all of them like 
e13ec3da05d1, instead of pointing at a MPTCP commit.

Eric, Matthieu, does that sound OK?


