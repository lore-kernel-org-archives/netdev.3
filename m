Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA23390CAA;
	Thu, 17 Sep 2026 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633004; cv=none; b=SlIN2k1CaPbCrozlivgPxkjVE1wBYrTCdXf1a8OgL5/zP7tcQ2FnyOqWq9xhl4BkAqL4rKMgknERt7dt/ahhg0/lHux0oPVJVOfNQrtC+xYptJYmPt8B1qMH3gjeC/q5YV36Do8ANrRy+AGbfW5tbmye5YQtlCDifEGXWMPs+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633004; c=relaxed/simple;
	bh=b+JjD7EjqJWEW6UbTeDdSkVfA1qMIVzboLqxTAHiKi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzJQIs1gNVYHCogkZ9XXt1+fDRdsVA+Ao4FkTWptQBZsiZCeA2eys8ptTT5466iTHTfRATpjrbx1ZubFfO12dDyrVUQyiAoiFqzr6jgPET8wjR4AOoZmvFTI43VdqSUzcJaxbrBeI20DCPWWjjVJoolK7L2UlYysZeOGCT8ONHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lipxGimk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lipxGimk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AF41F000FF;
	Thu, 17 Sep 2026 08:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789632998;
	bh=XsxJHlaX6GD89exnhV0hjrgOEGC6zExrW4yhpXaG5Z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lipxGimkYhMgRR6E8rEv3gjIb5hgJe8Y7nXno47AijAue1TjIU19QSmw/xSubU6fw
	 c1eR99wu1Gh5ko6Qo/SlN3sau8Gy8FLCfPx1TEvXz0KCCR45FxJEAq6ztEStJLebL+
	 yNqTiT+tBmLou0g5Ui3hpsstk14l9LmlLf7LLNNDMg5M+h7tIfMIsJKulehvWAPevI
	 WMRRO0cSyY+DjmknK11Jo0aJsf4H1Yy/zPzG1OyygrcFd/UXfJ/kUcbqoQuWIttafv
	 8ZXmtaWMYoJBe0CVLzVAp9AvRETWcj1b2fZhETuFHsaWFi+EWEm7EmjwnY4AWLWWEs
	 pwaRRnvkCMVdw==
Date: Thu, 17 Sep 2026 09:16:32 +0100
From: Simon Horman <horms@kernel.org>
To: Quanye Yang <quanyeyang@proton.me>
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] tcp: annotate lockless access to sk->sk_err
Message-ID: <20260917081632.GW51261@horms.kernel.org>
References: <20260912-mptcp-sk-err-net-v3-1-c41383878bde@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912-mptcp-sk-err-net-v3-1-c41383878bde@proton.me>

On Sat, Sep 12, 2026 at 11:43:34PM +0800, Quanye Yang wrote:
> BUG: KCSAN: data-race in do_recvmmsg / mptcp_recvmsg
> 
> read-write (marked) to 0xffff8880134d391c of 4 bytes by task 2619 on cpu 1:
>  instrument_atomic_read_write include/linux/instrumented.h:113 [inline]
>  sock_error include/net/sock.h:2565 [inline]
>  do_recvmmsg+0x50c/0x580 net/socket.c:3049
>  __sys_recvmmsg net/socket.c:3144 [inline]
>  __do_sys_recvmmsg net/socket.c:3167 [inline]
>  __se_sys_recvmmsg net/socket.c:3160 [inline]
>  __x64_sys_recvmmsg+0x161/0x180 net/socket.c:3160
>  x64_sys_call+0x19c7/0x1ca0 arch/x86/include/generated/asm/syscalls_64.h:300
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0xde/0x3d0 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> read to 0xffff8880134d391c of 4 bytes by task 2620 on cpu 0:
>  tcp_recv_should_stop include/net/tcp.h:3086 [inline]
>  mptcp_recvmsg+0x54d/0xd50 net/mptcp/protocol.c:2466
>  inet_recvmsg+0x204/0x210 net/ipv4/af_inet.c:894
>  sock_recvmsg_nosec net/socket.c:1151 [inline]
>  sock_recvmsg+0x11a/0x140 net/socket.c:1173
>  ____sys_recvmsg+0x14b/0x3c0 net/socket.c:2933
>  ___sys_recvmsg+0x116/0x160 net/socket.c:2975
>  __sys_recvmsg net/socket.c:3008 [inline]
>  __do_sys_recvmsg net/socket.c:3014 [inline]
>  __se_sys_recvmsg net/socket.c:3011 [inline]
>  __x64_sys_recvmsg+0xeb/0x160 net/socket.c:3011
>  x64_sys_call+0x1319/0x1ca0 arch/x86/include/generated/asm/syscalls_64.h:48
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0xde/0x3d0 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> value changed: 0x0000006b -> 0x00000000
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 2620 Comm: syz.2.33 Not tainted 7.2.0-g39d4f32c5d53 #76 PREEMPT(full)
> Hardware name: QEMU Ubuntu 26.04 PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
> 
> do_recvmmsg() and getsockopt(SO_ERROR) call sock_error() without the
> socket lock. sock_error() clears sk_err with xchg(), which races with
> unmarked loads of the same field.
> 
> KCSAN reported the unmarked peek in tcp_recv_should_stop(). The same
> lockless writer races with the other plain sk_err reads on the
> TCP/MPTCP send, recv and splice paths.
> 
> Annotate those peeks with READ_ONCE(). No extra ordering is needed:
> the value is only used to decide whether I/O should stop. This does
> not consume sk_err; the check-then-sock_error() TOCTOU on the no-data
> paths is a separate issue.
> 
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Link: https://lore.kernel.org/netdev/8bbee583-6f21-4817-bfeb-2d60057380a3@linux.dev/
> Reported-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/632
> Signed-off-by: Quanye Yang <quanyeyang@proton.me>
> ---
> Changes in v3:
> - drop the Fixes tag and retarget to net-next
> - annotate the remaining unmarked sk_err peeks on the TCP/MPTCP
>   send, recv and splice paths
> - Link to v2: https://patch.msgid.link/20260909-mptcp-sk-err-net-v2-1-5044abecac90@proton.me
> 
> Changes in v2:
> - add Reported-by and Closes for the MPTCP syzkaller report
> - Link to v1: https://patch.msgid.link/20260908-mptcp-sk-err-net-v1-1-da71aaec9afd@proton.me

Reviewed-by: Simon Horman <horms@kernel.org>
