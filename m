Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112874;
	b=BpTHXn/OHtLsVpTjmdRJXqs+iNJwY3/3EVBk2F4PSbvOCCl2iFCcpQYAYqpCyY7LVJoX
	 dXFbNt2K9NVtX3lDw1MOIwio5Fkmjr5qAz1BMfczLeviSlL/1QskGj2c3X2jmSErpRSG0
	 xQLrn43+I9Q3igm81jcxmz+cAEYnY/gmBFz/buocHEJDOrI/DEy7cCJ0d3DuibSDbyEmD
	 +dDaKxp4KS5RBjGtxnzmN+d5Ftk59Rj1Giub/B9AUmozsN/SkfrOBc5BXRYDXRLUkW27Y
	 fatgSrfWRzF50iEa7JuzrKQDEzZWG0KJIW/cSBRxFCq/teCyHZPUf2fMTx5G2UxH8KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112874;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=VVKMTXSgZ4XOrfVnDGwcJ20pqkUPPmxf9qOMEgAGK6k=;
	b=M3fteO29MlawA25qrMst2W+F8NFj6QbQZQFmrQqWCS6j6dpVDLFK9d+X6LaBMdyKCHr8
	 VLnor4FyBbXAc08seE0Tn65/z9NPBz1jRn6Z6j1nSKAMevXUOVTFXPRp/LQS4+SXu0lJg
	 4K8HHrBKxGeycgNqRP4IS62SxJy8wkfpj5KwHpBR8NNrZBBOTHAQE1GIAhRk2FBWciyTv
	 Ok6aCR9iz6WN6qmOiI3DlTGrQBhYjzsVcNz9frF51l7IX0ucaQzYiM0+lbZvsmWXhc4t6
	 zd8jU+QQ37phT4JH3FFpaLIajURAlEsByd1xb/XcTQLOPLKONqJH6QSNzSat0NXrcmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9yR8Dbm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDB3606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9yR8Dbm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA1B1F01825;
	Tue, 27 Oct 2026 14:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793112873;
	bh=VVKMTXSgZ4XOrfVnDGwcJ20pqkUPPmxf9qOMEgAGK6k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=H9yR8DbmfYEsSb85b8vOkwQ+0Z9tTX9PVs4RDmexLRNSOVLCRYAKsJKYQz2b8nKo1
	 If8mj+185YOTPWEBoSm1VKSHnVgehO8VFCON1d0TuUVAyeMMQvxSOiB5PeFDWLOVCe
	 XWsxvNyorQjR+gEB+kTk6PoZxgd2dMq7Ek+LjbzTaWWg1uKolhS2/UrPlfyGatL0Zj
	 x//ugnX+P0Bad/H5uqGt7QPwDg8JV3MU9Ftq8b5yf8ONw3GzJpB9yUufwHMJvaxBtv
	 VmCs9apG7epphLAcpO3z8HWv2D0VI0+uAp8Z7u0ujp1Ba7r/ZnlZCT5EU78Cvdy736
	 MNnSM920dqbeA==
Message-ID: <2dafbf91-43eb-4290-a84d-210e80a67b54@kernel.org>
Date: Tue, 27 Oct 2026 08:54:32 -0600
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] ipv6: Protect multiple routes insertion by table
 lock.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@google.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, syzbot+751b587577d0ebca10f2@syzkaller.appspotmail.com
References: <20261027065247.2871134-1-kuniyu@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20261027065247.2871134-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/26 12:52 AM, Kuniyuki Iwashima wrote:
> syzbot reported the warning below. [0]
> 
> While call_fib6_multipath_entry_notifiers() is called locklessly,
> fib6_siblings could be changed concurrently, leading to the
> warning (and later null-ptr-deref).
> 
> Let's protect multiple routes insertion with tb6_lock.
> 
> Along with that, __ip6_ins_rt() and ip6_route_del() are changed
> to fib6_add() and fib6_del().
> 
> Note that fib6_del() finally calls rt6_multipath_rebalance(),
> which requires rcu_read_lock().
> 
> [0]:
> i != fen6_info->nsiblings
> WARNING: drivers/net/netdevsim/fib.c:831 at nsim_fib6_event_init drivers/net/netdevsim/fib.c:831 [inline], CPU#0: syz.0.157/6279
> WARNING: drivers/net/netdevsim/fib.c:831 at nsim_fib6_prepare_event drivers/net/netdevsim/fib.c:947 [inline], CPU#0: syz.0.157/6279
> WARNING: drivers/net/netdevsim/fib.c:831 at nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:1003 [inline], CPU#0: syz.0.157/6279
> WARNING: drivers/net/netdevsim/fib.c:831 at nsim_fib_event_nb+0x1029/0x11d0 drivers/net/netdevsim/fib.c:1043, CPU#0: syz.0.157/6279
> Modules linked in:
> CPU: 0 UID: 0 PID: 6279 Comm: syz.0.157 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> RIP: 0010:nsim_fib6_event_init drivers/net/netdevsim/fib.c:831 [inline]
> RIP: 0010:nsim_fib6_prepare_event drivers/net/netdevsim/fib.c:947 [inline]
> RIP: 0010:nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:1003 [inline]
> RIP: 0010:nsim_fib_event_nb+0x1029/0x11d0 drivers/net/netdevsim/fib.c:1043
> Code: eb 0d 4d 89 fd e8 b7 c5 6c fa be 01 00 00 00 48 89 df e8 5a 38 85 fd 4d 89 ef 4c 8b 6c 24 20 e9 4a f3 ff ff e8 98 c5 6c fa 90 <0f> 0b 90 e9 db fa ff ff 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c df f0
> RSP: 0018:ffffc900047bef10 EFLAGS: 00010293
> RAX: ffffffff875b59a8 RBX: 0000000000000002 RCX: ffff888079770000
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
> RBP: ffffc900047bf0a0 R08: ffff88805c0bb02f R09: 1ffff1100b817605
> R10: dffffc0000000000 R11: ffffed100b817606 R12: dffffc0000000000
> R13: 0000000000000000 R14: 0000000000000001 R15: ffff88802c792000
> FS:  00007f334ba076c0(0000) GS:ffff888123ad0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f334ba06ff8 CR3: 000000007a5b2000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
>  atomic_notifier_call_chain+0xda/0x180 kernel/notifier.c:223
>  call_fib_notifiers+0x31/0x60 net/core/fib_notifier.c:36
>  call_fib6_multipath_entry_notifiers+0xf5/0x160 net/ipv6/ip6_fib.c:428
>  ip6_route_multipath_add net/ipv6/route.c:5542 [inline]
>  inet6_rtm_newroute+0x14f5/0x1a30 net/ipv6/route.c:5664
>  rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7163
>  netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2572
>  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>  netlink_unicast+0x7bd/0x940 net/netlink/af_netlink.c:1361
>  netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1916
>  sock_sendmsg_nosec+0x14e/0x190 net/socket.c:800
>  __sock_sendmsg net/socket.c:818 [inline]
>  ____sys_sendmsg+0x54e/0x850 net/socket.c:2715
>  ___sys_sendmsg+0x2a5/0x360 net/socket.c:2769
>  __sys_sendmmsg+0x273/0x4d0 net/socket.c:2858
>  __do_sys_sendmmsg net/socket.c:2885 [inline]
>  __se_sys_sendmmsg net/socket.c:2882 [inline]
>  __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2882
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f334ab9e1d9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f334ba07028 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
> RAX: ffffffffffffffda RBX: 00007f334ae26090 RCX: 00007f334ab9e1d9
> RDX: 04000000000001f2 RSI: 0000200000000000 RDI: 0000000000000004
> RBP: 00007f334ac35888 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000000000fc R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f334ae26128 R14: 00007f334ae26090 R15: 00007ffd96688aa8
>  </TASK>
> 
> Fixes: 169fd62799e8 ("ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.")
> Reported-by: syzbot+751b587577d0ebca10f2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6adbaed6.67317f00.38c4bc.001b.GAE@google.com/T/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v2: Wrap rt6_multipath_total_weight() and
>     rt6_multipath_upper_bound_set() w/ rcu_read_lock()
> 
> syzbot found a way to abuse 1ms sleep in netdevsim and pile up
> 10000+ routes w/ the delay, so it might report this with this
> fix applied:
> 
>   unregister_netdevice: waiting for syz_tun to become free. Usage count = 10
> 
> I have two patches to fix it, but I think this is net-next
> material.
> 
>   https://syzkaller.appspot.com/text?tag=Patch&x=15923c21580000
> ---
>  net/ipv6/ip6_fib.c |  4 ----
>  net/ipv6/route.c   | 17 +++++++++++++----
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


