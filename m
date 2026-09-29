Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90DA426436
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663217; cv=none; b=sB/ELvxAQiEYh90VJ90iFH6dgEldRYDm+RpQWUInqAgiYUD1x3wPfsmo5dA/BB6+WyduuigshQci4oaHcHzStCSR6Fjk74nMYi8mm7Zm5AuTdKfPTCLlveLmnKkMMWl4k3zGzFsdiqvRCiZFY2ysYGtM/fJa1X+ZWIm2AY9hdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663217; c=relaxed/simple;
	bh=gYYGpi7IteaQmi5+FRR89wngB4TMJCI03U+E3bimvZs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eM030uA+bCTFHk5519xpiMEb/sFNbZumGe7aexS1ZrBRF+MKLKhcLgpuw6KH4Z0x1/XGifVPUMO4WNAlHHrDz/AFvRtUele75OvJo6AX+lcy3divM9BFB2L9guRrHJk/XT6fBy5F0ZeGHoyqFkyobG1gLGIgKYUAt4koaTCzyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9RzJPSd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9RzJPSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084661F00893;
	Tue, 29 Sep 2026 06:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663215;
	bh=A38pLlTcbn8xd0njEYHBeEIlXgH3nZNJ5YhlXrRfpTI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j9RzJPSd6ETl8bt5K+BjUx1fnMaiO5TgWsxaEwtAVPP6Y1xZsNdedwPnwUI8QZFDW
	 oKELkTT1S7KTVz07g8XmFveuUFtGd3w7R33tLUJ995gsY18BES38gazVcgOAoYrE9L
	 VS8UDMfYVsMqoqdfEF3rh/sbzpY9B2cjjfvA3B9I4j7T/zV029FeGDjpLFErhyMvGP
	 s00cU6+Dde7xDi2p/4TM0YLJj9mEPu249Q7QvzcI21AbjspU3le0E/vcvi9b0VlgJg
	 H0CeNtUt04HsuqDiMg7RwOZ0ii+txGn0ED2c7W8jYO7ke7xriTHBb8GxJ861FC+/li
	 jKIIdtGsilAPw==
Subject: Re: [PATCH v1 net-next 5/5] ipv6: Batch rt6_uncached_list_flush_dev()
 for dying netns.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 carges@cloudflare.com, kuni1840@gmail.com, netdev@vger.kernel.org
Date: Tue, 29 Sep 2026 06:26:54 +0000
Message-ID: <179066321461.434549.4404823988585129411@kernel.org>
In-Reply-To: <20260927202429.2452589-6-kuniyu@google.com>
References: <20260927202429.2452589-6-kuniyu@google.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new ->pre_exit_batch() callback can crash the IPv6 init
  error path.
- [Medium] Race between the batch flush and rt6_uncached_list_add().

--

ipv6: Batch rt6_uncached_list_flush_dev() for dying netns.

This commit flushes IPv6 uncached routes for dying netns from a new
->pre_exit_batch() callback, which runs about once per cleanup_net().
Once NET_PRE_EXIT_DONE is set, the per-device rt6_uncached_list_flush_dev()
now returns early. rt6_uncached_list_add() now checks check_net() under
ul->lock, and a route for a dying netns is moved straight to
blackhole_netdev instead of being linked.

Closes: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v3-0-30493a37b6eb@cloudflare.com/
Link: https://lore.kernel.org/netdev/aq2B8PSfjn-xau4V@20HS2G4/

> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 475ced827ec57..7747e4f20fee6 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c

[ ... ]

> @@ -143,7 +159,12 @@ void rt6_uncached_list_add(struct rt6_info *rt)
>  	rt->dst.rt_uncached_list = ul;
>  
>  	spin_lock_bh(&ul->lock);
> -	list_add_tail(&rt->dst.rt_uncached, &ul->head);
> +
> +	if (check_net(dst_dev_net_rcu(&rt->dst)))
> +		list_add_tail(&rt->dst.rt_uncached, &ul->head);
> +	else
> +		rt6_uncached_list_replace(rt);
> +
>  	spin_unlock_bh(&ul->lock);
>  }
>  
> @@ -162,6 +183,9 @@ static void rt6_uncached_list_flush_dev(struct net_device *dev)
>  {
>  	int cpu;
>  
> +	if (dev && net_pre_exit_done(dev_net(dev)))
> +		return;
> +
>  	for_each_possible_cpu(cpu) {
>  		struct uncached_list *ul = per_cpu_ptr(&rt6_uncached_list, cpu);
>  		struct rt6_info *rt, *safe;

[Severity: Medium]
Because of this early return, the batch flush from ->pre_exit_batch() is
the only flush for devices in a dying netns. Can it miss a route that is
being added at the same time?

The dev == NULL path still skips a CPU's list with a lockless check,
before it takes ul->lock:

		if (list_empty(&ul->head))
			continue;

Here is the sequence I have in mind:

CPU A, rt6_uncached_list_add() (e.g. from ip6_pol_route() or
icmp6_dst_alloc()):
  spin_lock_bh(&ul->lock);        /* its own per-cpu list, empty */
  check_net() returns true
  <delayed by a hardirq, vCPU preemption or RT preemption>

CPU B, cleanup_net()->ops_undo_list():
  ops_pre_exit_list()
    ip6_route_net_pre_exit_batch()
      rt6_uncached_list_flush_dev(NULL)
        list_empty() on CPU A's list is true, so it is skipped

CPU A:
  list_add_tail(&rt->dst.rt_uncached, &ul->head);
  spin_unlock_bh(&ul->lock);

CPU B:
  synchronize_rcu();
  WRITE_ONCE(net->undo_state, NET_PRE_EXIT_DONE);
  ...
  NETDEV_UNREGISTER: addrconf_ifdown()->rt6_disable_ip()->
    rt6_uncached_list_flush_dev(dev) returns early

->pre_exit_batch() runs before the synchronize_rcu() in ops_undo_list(),
so CPU A's RCU/BH section is not waited for before the scan.

Would the late route then stay on the uncached list? It would still hold
its dst.dev reference (dev_tracker) and its rt6i_idev reference, and it
would never be moved to blackhole_netdev.

Before this patch, the per-device flush always ran at NETDEV_UNREGISTER,
after the synchronize_net() in unregister_netdevice_many().

If something holds that dst for a long time, could netdev_wait_allrefs()
hang and stall netns cleanup?

One option is to drop the list_empty() shortcut when dev is NULL. Another
is to run the batch flush after the grace period and before
NET_PRE_EXIT_DONE is published. Would either of those work?

[ ... ]

> @@ -6801,6 +6819,11 @@ static int __net_init ip6_route_net_init(struct net *net)
>  	goto out;
>  }
>  
> +static void __net_exit ip6_route_net_pre_exit_batch(struct list_head *net_exit_list)
> +{
> +	rt6_uncached_list_flush_dev(NULL);
> +}
> +

[Severity: Medium]
Could this callback crash on the ip6_route_init() error path?

ip6_route_init() registers ip6_route_net_ops before the per-cpu uncached
lists are initialized. They are only set up at the very end of the
function:

	ret = register_pernet_subsys(&ip6_route_net_ops);
	if (ret)
		goto out_register_inetpeer;
	...
	for_each_possible_cpu(cpu) {
		struct uncached_list *ul = per_cpu_ptr(&rt6_uncached_list, cpu);

		INIT_LIST_HEAD(&ul->head);
		spin_lock_init(&ul->lock);
	}

If a later step fails, the unwind calls
unregister_pernet_subsys(&ip6_route_net_ops). Those steps are fib6_init(),
xfrm6_init(), fib6_rules_init(), registering ip6_route_net_late_ops,
rtnl_register_many(), register_netdevice_notifier() and
bpf_iter_register().

With CONFIG_NET_NS=y, the same undo also runs inside
register_pernet_subsys() if ip6_route_net_init() fails for a netns. That
path goes through __register_pernet_operations()->ops_undo_single().

Both paths reach ops_pre_exit_list(). It calls ->pre_exit_batch() even
when net_exit_list is empty:

	if (ops->pre_exit_batch)
		ops->pre_exit_batch(net_exit_list);

which then calls:

ip6_route_net_pre_exit_batch()
  rt6_uncached_list_flush_dev(NULL)

At this point the static per-cpu heads are still zeroed. With head.next
== NULL, list_empty(&ul->head) returns false. spin_lock_bh() then takes a
lock that was never initialized. list_for_each_entry_safe() also derives
pos from the NULL next pointer and dereferences it.

Before this patch, ip6_route_net_ops had no ->pre_exit_batch(), so this
rollback did not touch the lists.

Would it make sense to initialize the per-cpu uncached lists before
registering ip6_route_net_ops?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927202429.2452589-1-kuniyu%40google.com
