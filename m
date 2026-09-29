Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB8420480
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 06:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663216; cv=none; b=K1DQsmU6kOrq0P7MoRbOtNdRxelr4Jo06/90VWEtOgADxHdJjV3hBQnBPO/SnxogxH6k6nFxzNHP/7zG8sKOk81r0cBAq1huo6heV0aEoBLoAgLM8ZWTYi1qFF5A1qjN9A2uHmrkDDyNwo0hAmd2XAeuNm1mPsqGG5vw3h0napQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663216; c=relaxed/simple;
	bh=zdvNIuPm7NWOPM1TsiCZxWZ4G7CtiXKu690bXTwm8qI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QnKpEjiz927j5tF0kbSUQTJSBXgnS8ExGgenrW5JcYrjKdJEeDzTsLdHoD4a/Lm4mIG2681Km1EClPrsgCyKAxvRIqyJOAQRP3zrV+/nwhP87PEdZ80XQ3Rl+XfuHswozmFyisx/zRg2wAsflBX15LarwCkLxl1X0TUT6nRwnCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nroJU7LO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nroJU7LO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3E11F000FF;
	Tue, 29 Sep 2026 06:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663214;
	bh=bcPuGJolLwyknyYMlDAQSy8JA4u2m9rgJ9aA4Z8Qcak=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nroJU7LOA62VyOA99UBZV/nw9pXNQVFXgHbOeYuY2XtpZpCZVmPsUVMp1MK3mdDv8
	 z0ewC7sNX5l7GSu0W6lMmFx/LCXTwaiugz9aq9kln9AMbDPwUGc8gCgBeu/KCCyLFd
	 hS/f0ZnGkUCdZf+V3LPC/0toq/PpT6iIlh/+GZzh+UoeJ3UsIHggZXByCL6AyLW0hs
	 VGFjI47rjXLm5JlblBMkQb/LwkxL1NF8C69gObvKWrOGfpPVXsYsYmi0M7kCIml5Ly
	 6jEa8c4FgXq1SeY7hqSVSAvQ9YynqIethrK5AbUhyIhNUvGjMBC6Cybxt/WK2onCJk
	 99Kj+8y05WdeQ==
Subject:
 Re: [PATCH v1 net-next 4/5] ipv4: Batch rt_flush_dev() for dying netns.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 carges@cloudflare.com, kuni1840@gmail.com, netdev@vger.kernel.org
Date: Tue, 29 Sep 2026 06:26:53 +0000
Message-ID: <179066321347.434549.4867798681835830977@kernel.org>
In-Reply-To: <20260927202429.2452589-5-kuniyu@google.com>
References: <20260927202429.2452589-5-kuniyu@google.com>
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

- [Medium] The early return in rt_flush_dev() and the batch purge use two
  different tests for "dying netns", and they disagree when setup_net()…
- [Medium] rt_flush_dev(NULL) now runs from ->pre_exit_batch(), before
  any RCU grace period (ops_undo_list() calls ops_pre_exit_list() before…

--

ipv4: Batch rt_flush_dev() for dying netns.

This patch calls rt_flush_dev(NULL) once from fib_net_ops->pre_exit_batch().
That call purges uncached routes whose device belongs to a netns with a zero
refcount, so the flush no longer runs once per device. rt_add_uncached_list()
now swaps in blackhole_netdev for routes of a dying netns, and
rt_flush_dev(dev) returns early once net_pre_exit_done() is true.

> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index d7da2f1acbb59..cbe328b3f2545 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1554,14 +1554,29 @@ struct uncached_list {

[ ... ]

>  void rt_add_uncached_list(struct rtable *rt)
>  {
>  	struct uncached_list *ul = raw_cpu_ptr(&rt_uncached_list);
>  
> +	/* Set once and never cleared: non-NULL marks an uncached route. */
>  	rt->dst.rt_uncached_list = ul;
>  
>  	spin_lock_bh(&ul->lock);
> -	list_add_tail(&rt->dst.rt_uncached, &ul->head);
> +
> +	if (check_net(dst_dev_net_rcu(&rt->dst)))
> +		list_add_tail(&rt->dst.rt_uncached, &ul->head);
> +	else
> +		rt_replace_uncached_list(rt);
> +
>  	spin_unlock_bh(&ul->lock);
>  }

[Severity: Medium]
Does this check_net() test keep new routes off the list after
rt_flush_dev(NULL) has already run?

The test runs under ul->lock. However, rt_flush_dev() still skips each
per-CPU list with a check that does not take the lock:

net/ipv4/route.c:rt_flush_dev() {
    ...
	for_each_possible_cpu(cpu) {
		struct uncached_list *ul = &per_cpu(rt_uncached_list, cpu);

		if (list_empty(&ul->head))
			continue;

		spin_lock_bh(&ul->lock);
    ...
}

rt_flush_dev(NULL) now runs from ->pre_exit_batch(). In ops_undo_list(),
that is before synchronize_rcu_expedited(). Could this interleaving happen?

CPU1 (softirq RX on a device in netns N)
rt_add_uncached_list()
    spin_lock_bh(&ul->lock);
    check_net(N) returns 1
    <stalls before list_add_tail(), e.g. preempted on PREEMPT_RT
     or a preempted vCPU>

CPU0 (cleanup_net, after the last ns reference is dropped)
ops_undo_list()
    fib_net_pre_exit_batch()
        rt_flush_dev(NULL)
            list_empty(&ul->head) is true for CPU1's list, so continue

CPU1
    list_add_tail(&rt->dst.rt_uncached, &ul->head);
    spin_unlock_bh(&ul->lock);

CPU0
    WRITE_ONCE(net->undo_state, NET_PRE_EXIT_DONE);

After this, every rt_flush_dev(dev) call for a device in N returns at the
new net_pre_exit_done() check. That includes the call from
fib_netdev_event() and the NETDEV_UNREGISTER rebroadcast in
netdev_wait_allrefs_any().

Would the route then keep its dev_tracker reference on a device in N
forever, so that unregister_netdevice waits for that device indefinitely?

The race also needs CPU1's list to be otherwise empty. The window is narrow
on non-RT kernels.

On weakly ordered architectures, the READ_ONCE() in list_empty() is not
ordered against a list_add_tail() that has already completed on another
CPU.

Before this patch, the flush that mattered ran from NETDEV_UNREGISTER after
synchronize_net(), and the rebroadcast ran it again, so a late addition was
still caught. The commit message says:

  Since ->pre_exit_batch() is called before synchronize_rcu(),
  we must prevent adding a new route for dying netns, so now
  rt_add_uncached_list() checks !check_net() and swaps the device
  with blackhole_netdev.

Would taking ul->lock every time in the dev == NULL case close this gap?
Then either the flush sees the route, or rt_add_uncached_list() sees
check_net() return false. This code is unchanged at the end of the series.

> @@ -1587,6 +1602,9 @@ void rt_flush_dev(struct net_device *dev)
>  	struct rtable *rt, *safe;
>  	int cpu;
>  
> +	if (dev && net_pre_exit_done(dev_net(dev)))
> +		return;
> +

[Severity: Medium]
Can this early return skip routes that the rt_flush_dev(NULL) purge never
removed?

The purge filter only picks routes whose netns has check_net() false:

			if (rt->dst.dev != dev &&
			    (dev || check_net(dev_net(rt->dst.dev))))
				continue;

The gate in rt_add_uncached_list() uses the same test. But
net_pre_exit_done() reads undo_state, and ops_undo_list() sets undo_state
for any undo on pernet_list:

net/core/net_namespace.c:ops_undo_list() {
	bool dying = ops_list == &pernet_list;
    ...
	if (dying) {
		list_for_each_entry(net, net_exit_list, exit_list)
			WRITE_ONCE(net->undo_state, NET_PRE_EXIT_DONE);
	}
    ...
}

That includes the setup_net() failure path:

net/core/net_namespace.c:setup_net() {
    ...
	list_add(&net->exit_list, &net_exit_list);
	ops_undo_list(&pernet_list, ops, &net_exit_list, false);
    ...
}

On that path the netns still holds the initial ns reference that
ns_common_init() takes in copy_net_ns(), so check_net() returns true. Is
this sequence possible?

copy_net_ns()
  setup_net()
    <a pernet init after fib_net_ops fails>
    ops_undo_list(&pernet_list, ...)
      fib_net_pre_exit_batch()
        rt_flush_dev(NULL)      <- skips the netns, check_net() is true
      undo_state = NET_PRE_EXIT_DONE
      ops_exit_rtnl_list()
        <unregister lo, fallback tunnels>
          fib_netdev_event(NETDEV_UNREGISTER)
            rt_flush_dev(dev)   <- returns early

Until then, rt_add_uncached_list() also keeps adding this netns's routes to
the list, since check_net() is still true.

If an IPv4 uncached route (an rt_uncached_list entry, an xfrm4 bundle, or a
route replaced in rt_cache_route()) pins one of these devices, does
anything move it to blackhole_netdev?

The NETDEV_UNREGISTER rebroadcast in netdev_wait_allrefs_any() used to
rescue such routes through rt_flush_dev(dev), but it now hits the same
early return. The rollback could then wait forever for the device inside
setup_net() with pernet_ops_rwsem held.

It is not clear that any in-tree path can create an uncached route on a
device of a netns that has not finished setup_net(), because those devices
are down and the netns is not visible yet. Nothing seems to prevent it
either.

The commit message says:

  When rt_flush_dev() is called with NULL from ->pre_exit_batch(),
  it purges every entry in dying netns

and:

  When rt_flush_dev() is later called again from fib_netdev_event()
  via NETDEV_UNREGISTER, it just returns.

Both hold for cleanup_net(), but not for every path that sets
NET_PRE_EXIT_DONE.

Would it make sense to set NET_PRE_EXIT_DONE only from cleanup_net()? The
other option would be for the NULL purge to pick nets by undo_state or by
membership in net_exit_list instead of check_net(). The matching IPv6
change later in the series appears to keep the same mismatch.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927202429.2452589-1-kuniyu%40google.com
