Received: from mta0.migadu.com (out-203.mta0.migadu.com [91.218.175.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F3140F8F8
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376002; cv=none; b=UjqIt9drUpKaYIagWZ3mxPOb/Zvw+aPFhIFdXM6gcNx+Wl7Mknk7tkyNoU2MWw3hQgVYhICvzwV7Btjdygvvnt3a7xs1k8pUxGHTELOWFx44P7WQcT//84kg6IYw07PyDOvhlpFDJ2ld4xq1JzgC1JvlXcOUEt1a4JwwOq58nH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376002; c=relaxed/simple;
	bh=0eptoBPKzw2P39r0drFGgeobsP4rL9/tCMFwKo5AcVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfU/O/Tou+ZEsJMSxKwULByJjgNDZAlCwmL3L0pgUrdh6ndI4of+5mRQcfcd8gwUjCmzcvvaz5hRXPuCQbRpzF6YsnYO0iKnPMOYo4hzvsFoYLgWyxoTh9Yhepk1QA0E/t02/kfUE+bCwfb6WItUOtR3k6YF9tDHhaiWg0atiA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lnuPqPec; arc=none smtp.client-ip=91.218.175.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lnuPqPec"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0eptoBPKzw2P39r0drFGgeobsP4rL9/tCMFwKo5AcVM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789375990; v=1; x=1789980790;
 b=lnuPqPecl1vPHtS6CsEPgFSyTZVlxE0aWxxp8XX0Tm7kxy6pUEtUWk7QjrNlIwrd3LZqih0S
 rEk30Dn4mGxzAtVXWCxgUSA1sIaS/3mLjdGrvkDWBN5CcTiivtD2clSzBW8qDleIeLHoJT+SA5P
 IOWY2XcL+cQLncVge9j7JpKo=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c9665cda3aeefa43;
	Mon, 14 Sep 2026 08:53:10 +0000
X-Mizu-Trace-ID: c9665cda3aeefa43
X-Migadu-Flow: FLOW_OUT
Message-ID: <afba7d6a-a1b9-4c55-b3b0-3f034e92a4c3@linux.dev>
Date: Mon, 14 Sep 2026 16:53:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] tcp: Don't call skb_clone_and_charge_r() for
 close()d listener in tcp_v6_do_rcv().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Taras Madan <tarasmadan@google.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>
References: <20260914011420.115556-1-kuniyu@google.com>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <20260914011420.115556-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/9/14 09:14, Kuniyuki Iwashima 写道:
> tcp_v6_do_rcv() no longer calls skb_clone_and_charge_r() for
> TCP_LISTEN since commit 073d89808c06 ("net: fix data-races around
> sk->sk_forward_alloc").
> 
> However, there is still a small race window between tcp_v6_rcv()
> and tcp_v6_do_rcv(), where concurrent close() changes TCP_LISTEN
> to TCP_CLOSE, causing skb_clone_and_charge_r() to be called
> locklessly and resulting in the splat below. [0]
> 
> Let's avoid calling skb_clone_and_charge_r() for TCP_CLOSE as well.
> 
> This is fine for non-listeners because tcp_rcv_state_process()
> drops skb for TCP_CLOSE and opt_skb was freed immediately anyway.
> 
> [0]:
> sk->sk_forward_alloc
> WARNING: net/ipv4/af_inet.c:162 at inet_sock_destruct+0x64d/0x810 net/ipv4/af_inet.c:162, CPU#1: ksoftirqd/1/28
> Modules linked in:
> CPU: 1 UID: 0 PID: 28 Comm: ksoftirqd/1 Not tainted 7.2.0 #17 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> RIP: 0010:inet_sock_destruct+0x64d/0x810 net/ipv4/af_inet.c:162
> Code: 3d 49 ff e9 06 fd ff ff e8 d0 5b 83 f8 90 0f 0b 90 e9 35 fe ff ff e8 c2 5b 83 f8 90 0f 0b 90 e9 c5 fe ff ff e8 b4 5b 83 f8 90 <0f> 0b 90 e9 04 ff ff ff e8 a6 5b 83 f8 90 0f 0b 90 e9 65 fe ff ff
> RSP: 0018:ffffc90000677bb8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff8880117bde80 RCX: ffffffff8957eb41
> RDX: ffff88801dad5d00 RSI: ffffffff8957ec3c RDI: 0000000000000005
> RBP: 00000000fffff000 R08: ffffffff8957eb41 R09: 00000000fffff000
> R10: 0000000000000005 R11: 0000000000000000 R12: dffffc0000000000
> R13: ffff8880117bdf10 R14: ffffffff81c08eb7 R15: 0000000000000003
> FS:  0000000000000000(0000) GS:ffff8880d7ae5000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f93a1021138 CR3: 00000000207a9000 CR4: 0000000000350ef0
> Call Trace:
>   <TASK>
>   __sk_destruct+0x82/0xae0 net/core/sock.c:2356
>   rcu_do_batch kernel/rcu/tree.c:2645 [inline]
>   rcu_core+0x59c/0x1100 kernel/rcu/tree.c:2897
>   handle_softirqs+0x1e4/0x9b0 kernel/softirq.c:622
>   run_ksoftirqd kernel/softirq.c:1076 [inline]
>   run_ksoftirqd+0x38/0x60 kernel/softirq.c:1068
>   smpboot_thread_fn+0x458/0xc80 kernel/smpboot.c:160
>   kthread+0x396/0x4a0 kernel/kthread.c:436
>   ret_from_fork+0x8e0/0xe40 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
> 
> Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
> Reported-by: Taras Madan <tarasmadan@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks,

