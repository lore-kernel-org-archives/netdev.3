Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471B03F65EA
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791154946; cv=none; b=c7eFVB91bHgErumxFK8rC99bnjXx2ml5RxZcrfuA1appEmXItdGfoQLSmYZQqExZvqjGAN22m1+4ctqu38aHWQRr0wWcjPZzuvKYStA2sLswZqLEG07a+7HTkNOd7agAQhhIrtxpiKRG7/VshNfC61Jj6ZlIkNsrA1EgHfd/7Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791154946; c=relaxed/simple;
	bh=8isZZ4b/JxGCQfLlpWm2pr0SOvk3J6mEGL4o7T+LtGA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8BXQ+lJBmMnnDk7y8tDpijAzBYnvyLnGvUgSrf2MPxLqp4ebBNzHIrIPTaYzJTIJxTZ16QlT1IJ5zkPMGE3SP9ebv+puwxtE2+lWyQyj4dVm40giyTa7pp2T4qXsnp38TJJtPYxiIupugwlnhF0KB9A/WsYhh00dUFLXhGRVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rhjf6l3B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rhjf6l3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD471F00893;
	Sun,  4 Oct 2026 23:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791154945;
	bh=0OLMiSbQ0crZieTOQ+/Ur254/yKOGqO+u2vRUzkXGrU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rhjf6l3Bd7/ys45uRHzH35mKcEsPrvSyJSwf8IuadjDD/AO0IwvQLuRcik90utAM0
	 1XYr6xlL3waquSoGIzIKFrQmuD25HpTYFBaYispYOw9QPhgLwo2YTWC/hrFTSer5pc
	 ransV4ViKbH0kZVEz7SyqGFl1WATpzGAWoLXPyP7LQmCeinJ1sAQw0135MYY3xYjVN
	 xS4U0FIy5SQBLNviSuJg5zYLc8D8paoYs1cKCztvDpUg1WdFTFu4fKG7tiybzrZ83b
	 ffhyniwjz2LIPjxWtGI7XUBTsNk3Sw7CAdK84Dtbp8g5m9LVvMBtebWegA0ypflKpS
	 w5GnCcadLEyWA==
Subject: Re: [PATCH v3 net-next 6/6] ipv6: Batch rt6_uncached_list_flush_dev()
 in netdev_run_todo().
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: dsahern@kernel.org, idosch@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, carges@cloudflare.com, kuni1840@gmail.com,
 netdev@vger.kernel.org
Date: Sun, 04 Oct 2026 23:02:23 +0000
Message-ID: <179115494386.434549.7335879058511719741@kernel.org>
In-Reply-To: <20261001204752.2572265-7-kuniyu@google.com>
References: <20261001204752.2572265-7-kuniyu@google.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Use-after-free of the net_device because no RCU grace period
  separates the uncached-route swap from the device free.
- [Medium] Uninitialised per-CPU list access in
  rt6_uncached_list_flush_dev() when IPv6 init failed at boot.

--

ipv6: Batch rt6_uncached_list_flush_dev() in netdev_run_todo().

This commit stops flushing IPv6 uncached routes from the per-device
NETDEV_UNREGISTER path. It now does the flush once per batched
unregistration from netdev_run_todo(), without RTNL. Routes are matched by
NETREG_UNREGISTERED and are unlinked only after both dst.dev and
rt6i_idev->dev point at blackhole_netdev. An ipv6_mod_enabled() check is
added because netdev_run_todo() also runs when IPv6 is disabled.

Closes: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v3-0-30493a37b6eb@cloudflare.com/

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 4658e4e16d9dd..4ce128864b8c8 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -11872,8 +11873,10 @@ void netdev_run_todo(void)
>  		linkwatch_sync_dev(dev);
>  	}
>  
> -	if (!list_empty(&list))
> +	if (!list_empty(&list)) {
>  		rt_flush_dev(NULL);
> +		rt6_uncached_list_flush_dev(NULL);
> +	}
>  
>  	cnt = 0;
>  	while (!list_empty(&list)) {

[Severity: Critical]
Does this flush need an RCU grace period before the device is freed?

Before this patch, rt6_disable_ip() called rt6_uncached_list_flush_dev(dev)
during NETDEV_UNREGISTER processing. The synchronize_net() in
unregister_netdevice_many_notify() ran after that call. So any RCU reader
that had loaded the old dst.dev was done before the device could be freed.

Now the swap happens after the only rcu_barrier() in netdev_run_todo(), and
the old device reference is dropped right away:

rt6_uncached_list_flush_dev(NULL)
    rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
    netdev_ref_replace(rt_dev, blackhole_netdev, ...)
        __dev_put(rt_dev)

The in6_dev_put(rt_idev) call can also reach in6_dev_finish_destroy(),
which drops a device reference synchronously.

netdev_wait_allrefs_any() then checks the refcount before any
rcu_barrier() or msleep():

	list_for_each_entry(dev, list, todo_list)
		if (netdev_refcnt_read(dev) == 1)
			return dev;

After that, netdev_run_todo() runs netdev_do_free_pcpu_stats(),
priv_destructor and free_netdev(). The final put reaches netdev_release(),
which calls kvfree(dev) under the comment "no need to wait for rcu grace
period".

Readers such as ip6_finish_output2() use the device under RCU without
taking a reference:

	struct net_device *dev = dst_dev_rcu(dst);
	struct inet6_dev *idev = ip6_dst_idev(dst);
	unsigned int hh_len = LL_RESERVED_SPACE(dev);

Take a sender holding an uncached rt6 on device X. It could come from an
IPV6_HDRINCL raw socket, an xfrm6 bundle, or icmp6_dst_alloc():

CPU1                           CPU0
ip6_finish_output2()
  dev = dst_dev_rcu(dst) /* X */
                               netdev_run_todo()
                                 rt6_uncached_list_flush_dev(NULL)
                                   swap to blackhole, put X
                                 netdev_wait_allrefs_any()
                                   refcnt == 1, return X
                                 ...
                                 kvfree(X)
  LL_RESERVED_SPACE(dev),
  dev_queue_xmit()

Can CPU1 then dereference the freed net_device and its tx queues? This
could happen while CPU1 is preempted inside its RCU section under
PREEMPT_RCU.

The previous patch in this series, "ipv4: Batch rt_flush_dev() in
netdev_run_todo().", seems to do the same for IPv4 uncached routes. Would
a synchronize_net() after the rt_flush_dev(NULL) and
rt6_uncached_list_flush_dev(NULL) calls, before netdev_wait_allrefs_any(),
close this window?

> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index a76869ff87cd6..b1dcb5e5da88c 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -158,10 +158,16 @@ void rt6_uncached_list_del(struct rt6_info *rt)
>  	}
>  }
>  
> -static void rt6_uncached_list_flush_dev(struct net_device *dev)
> +void rt6_uncached_list_flush_dev(struct net_device *dev)
>  {
>  	int cpu;
>  
> +	if (!ipv6_mod_enabled())
> +		return;
> +

[Severity: Medium]
Is ipv6_mod_enabled() enough to show that rt6_uncached_list was
initialised?

ipv6_mod_enabled() only reflects disable_ipv6_mod. The per-cpu list heads
and locks are set up at the very end of ip6_route_init(), after every step
that can fail:

net/ipv6/route.c:ip6_route_init() {
    ...
	ret = register_netdevice_notifier(&ip6_route_dev_notifier);
	if (ret)
		goto out_register_late_subsys;
    ...
	for_each_possible_cpu(cpu) {
		struct uncached_list *ul = per_cpu_ptr(&rt6_uncached_list, cpu);

		INIT_LIST_HEAD(&ul->head);
		spin_lock_init(&ul->lock);
	}
    ...
}

ip6_route_init() can fail, or inet6_init() can fail before it calls
ip6_route_init(). In either case the inet6_init() error paths leave
disable_ipv6_mod unset. Because CONFIG_IPV6 is bool, boot carries on.

The next device unregistration would then run:

rtnl_unlock()
  netdev_run_todo()
    rt6_uncached_list_flush_dev(NULL)
      list_empty(&ul->head)       /* head->next == NULL, seen as non-empty */
      spin_lock_bh(&ul->lock)     /* lock never initialised */
      list_for_each_entry_safe()  /* loads through NULL head->next */

Could this oops with BH disabled and the per-cpu lock held?

The commit message says:

    Note also that netdev_run_todo() cannot be called before
    rt6_uncached_list is initialised because:

That covers ordering, but not the case where initialisation never
finishes. Before this patch, the function was only reachable from
rt6_disable_ip() through the ip6_route/addrconf notifiers. Those are
registered only after ip6_route_init() has succeeded.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001204752.2572265-1-kuniyu%40google.com
