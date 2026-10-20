Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528312;
	b=jSbvawyKFKPix+UzFNIaCMzXryqGKuEQIMVOESYHThwV5DBscWOYjdCcht83BDZNjt+e
	 +kfHnKPLkFzAU80MGYPHLAs8rUDuaVXReaSsIMVjVTmzKUooHCtJY76TJB9QueW812PX/
	 kFy6AVs3r416QJxOQP5ezfvcQu2A6rmDmHDcOu3QG52+sRGIoJbqslPmnLgyXD6RIDhdZ
	 g05J+KPBm7lx4HFLgtn0ATmmcrzUlOtavvttlD7aRndoMXUx/uD8w4r+oBGRrod1tNfuO
	 wmRXFVVDGD3TDL7Ax9lvheQA85oKscxQsPnpOHeEpyam1h9UPxE3vqzrTfnv5zi061A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528312;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=MHafQ+j9a+qjzrbYsK97o5qE4Gd/l3akDGUhkY8tLgg=;
	b=TtRA0pTA4Ti5lMgY1klgQdo5bRvoaUNw1PgTaCCFYjWv2Jn1aBp6afJ8nTYkS6I21naQ
	 8HaK59XrsuvJYz1V4oznOF96GeW+/5SeXSbYZw5KXJ8zj6danr9ErnDcEHReqYnuoTJM9
	 oleXwZOVzW5gjeb1AY4CjZ26SpyqgTFsQf3QqxkqSjYlSTZVTwnfOitizeEF4jLzx1HCi
	 IOpxtft0NCwk0bfMeiuqhSHvbOoiyRtyueJ1qrthfh8cjck8H4aBffoEe+j3r8ynUyf6Z
	 8cw/9zGdbFUsF35KIQHiG2+mSJWOkHs8pkgPtI4zmzM3b/aAuytPkOpArRrI8uaFGlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kMT4jAUX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE90606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kMT4jAUX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AD51F000C9;
	Tue, 20 Oct 2026 20:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792528312;
	bh=MHafQ+j9a+qjzrbYsK97o5qE4Gd/l3akDGUhkY8tLgg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kMT4jAUXCnPjhoUPPokodJSTv/gEnxMRbTcp/rIH8jQApJTWkYYoZHsOFjm65gwMd
	 Lm5+06GR70SZj0G2T4BHPATWJtnnJAMOEBSW5HSckLRRokIWbc6bVifOeFZjZGmf00
	 KWIfaH/dnMGA29nqF4DSwDgqVddFTp0pBj7MlkKHG1DwWvfm8Uy+atImuC6fw9zd77
	 9q0VOb53XSQy9l7sh+zV3L+XBG1j6bzpGNNA0AjOosWAYnBG2AsNQf6KPHVlvHn9tG
	 6QeH+jpzajmcKe9uPDjI6p2FEEJXbyK7IfvIqjLlgSm48ChAOROtfkli5u9G0F2bMt
	 Z74GazyMt6Rqw==
Message-ID: <88fc86f6-d096-4e81-b346-29cddf774945@kernel.org>
Date: Tue, 20 Oct 2026 14:31:51 -0600
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
Subject: Re: [PATCH net 1/2] ipv6: Hold RCU when emitting route hardware flags
 notification
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, horms@kernel.org, andrew+netdev@lunn.ch,
 petrm@nvidia.com
References: <20261019140337.2886875-1-idosch@nvidia.com>
 <20261019140337.2886875-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20261019140337.2886875-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/26 8:03 AM, Ido Schimmel wrote:
> fib6_info_hw_flags_set() is called by drivers from process context
> without RTNL or RCU. When the route uses a nexthop object,
> rt6_nlmsg_size() and rt6_fill_node() access the nexthop's RCU protected
> nexthop info and group pointers via rcu_dereference_rtnl(), resulting in
> suspicious RCU usage splats [1].
> 
> Fix by holding RCU while sizing and filling the notification, like
> fib_alias_hw_flags_set() already does. Switch to GFP_ATOMIC for the skb
> allocation accordingly.
> 
> Reproducer:
> 
>  # echo "10 0" > /sys/bus/netdevsim/new_device
>  # sysctl -wq net.ipv6.fib_notify_on_flag_change=1
>  # sysctl -wq net.ipv4.nexthop_compat_mode=1
>  # ip -6 nexthop add id 1 blackhole
>  # ip -6 route add 2001:db8:1::1/128 nhid 1
> 
> [1]
> WARNING: suspicious RCU usage
> 7.3.0-rc7-virtme-g191aa41548b2 #38 Not tainted
> net/ipv4/nexthop.c:1539 suspicious rcu_dereference_check() usage!
> [...]
> Workqueue: events nsim_fib_event_work
> Call Trace:
>  <TASK>
>  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
>  lockdep_rcu_suspicious.cold (kernel/locking/lockdep.c:6972)
>  nexthop_for_each_fib6_nh (net/ipv4/nexthop.c:1539 (discriminator 16))
>  rt6_nlmsg_size (net/ipv6/route.c:5728)
>  fib6_info_hw_flags_set (net/ipv6/route.c:6503)
>  nsim_fib6_rt_add (drivers/net/netdevsim/fib.c:671 drivers/net/netdevsim/fib.c:694)
>  nsim_fib6_rt_insert (drivers/net/netdevsim/fib.c:759)
>  nsim_fib_event_work (drivers/net/netdevsim/fib.c:856 drivers/net/netdevsim/fib.c:889 drivers/net/netdevsim/fib.c:1493)
>  process_one_work (kernel/workqueue.c:3396)
>  worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
>  kthread (kernel/kthread.c:436)
>  ret_from_fork (arch/x86/kernel/process.c:158)
>  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>  </TASK>
> 
> Fixes: 907eea486888 ("net: ipv6: Emit notification when fib hardware flags are changed")
> Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> Closes: https://lore.kernel.org/netdev/179152182668.434549.18232968419539498055@kernel.org/
> Assisted-by: LLM
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv6/route.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


