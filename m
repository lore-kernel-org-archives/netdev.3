Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428393;
	b=17+8/R7hiN4zRe8NKgQL8k+xLwIjnZ8ZJXaV8PMP+k1Yusbsmzy8VLJtdIKxI0yyNQHu
	 grN7GflTN5P1C+8FZG0k1jqymYaXwYUUyL0a3COodJycqpTUVqzWnuBvBBWUKsnO+0O/J
	 Lu5hndljUX3UuZzFPg/JzbinbyI5VnsWkZv75F2O0gmKlI5a65qA2k0WA/mN0EtmDZpbd
	 +Ts1bmfL8HG6MX8wBy0Vvh2wEvcx5q0VLScy1fHOz1nYiUMGYN5FaNJ83li3NlyQRiSiI
	 +Zxc99SwhSDRQheQ7xGEiC/w9JOMEI+d6nqmmtUToD15Rf8f/fM8a9f0FqKnvS4/WZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428393;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=f8CuFtmyJf54ODlJeIy52UMNjkpCBp9aiQqZGqfLdfs=;
	b=n8Gu6y9IfkSk+iqb/Lb+FfphZIOjbvI6Mu4OcJ6uHFpjr1KIT4dgYsLcS0eIZtF779I8
	 GXZy9JNx0LFMrCj1Ca9wKufT6s4eZJYWvygQu36/kvr3CHKC1RUREPvGO8rpUW+j/7CFu
	 gu7R5yxLuEtJdWD1vmLVxedG/Y/4vMbglh4tzRaqR7C8tzmXDxk9lJfU/pms14gNkSRFc
	 fUgXs15WkIR26SuFdD66a9KzvBIYuh4W5b3OK1Pd7U/nDv3URd2iTtN13zOPweNGMfrkg
	 FlgLDDVyUpFi8Wc/0X3rgw4Ia7g6UMbKa4xfkY0N1fH6HUpxvMBdOfZXdW0t857npWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EF6/DFVJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308D606A891;
	Wed, 11 Nov 2026 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EF6/DFVJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50551F00A05;
	Wed, 11 Nov 2026 20:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428393;
	bh=f8CuFtmyJf54ODlJeIy52UMNjkpCBp9aiQqZGqfLdfs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EF6/DFVJvAHgtkuslUXsILHAGIMrwhUa+jHwuPgI2lFlmQ+w8J50wt0agxK18ixAy
	 7L2WJ/0q+oM3JjWAO/e6NqpZ9gtygDkzvbiLCx1/wETuUN5Ik6ChJTYMxQkQPIZovW
	 sfqpBfSa/To3OtMukbgd2Qs8erC/UygbXzRpqw8+ANWD5pZ8QnZKDsJxP2hzG5Ov1C
	 +okreTDi6WV2kzS4gdGsY6PZ5+bEbH8kozO0qrcqB34Jo/51Os2WDe+ZJEYd1o/PBE
	 lgkTMaBm8GSuGgbqwUz75XGnL66XGAipqHB0AFtZPlCluvLKKrwJcyaEpHGK6JCwpJ
	 w/boqCfsWAMEw==
Subject: Re: [PATCH net-next v3 4/4] net: remove rcu_barrier() from
 __dev_change_net_namespace()
From: netdev-bot+sashiko@kernel.org
To: qiliang.yuan@linux.dev
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 razor@blackwall.org, kuniyu@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 11 Nov 2026 20:19:52 +0000
Message-ID: <179442839245.2199510.16642149560557233526@kernel.org>
In-Reply-To: <20261109-bug-net-netns-move-rcu-barrier-v3-4-6084b02610b3@linux.dev>
References: <20261109-bug-net-netns-move-rcu-barrier-v3-4-6084b02610b3@linux.dev>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: UAF in rt6_remove_exception() after
  __dev_change_net_namespace()

--

> diff --git a/net/core/dev.c b/net/core/dev.c
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -13044,7 +13044,6 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
>  	 * the device is just moving and can keep their slaves up.
>  	 */
>  	call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
> -	rcu_barrier();
>  
>  	new_nsid = peernet2id_alloc(dev_net(dev), net, GFP_KERNEL);
>  
>

[Severity: High]
The commit message says the IPv6 exceptions of a nexthop that leaves a
group were already flushed when it left, but I don't think that holds.
When remove_nexthop_from_groups() drops a single IPv6 nexthop from a
multi-member group, nh_rt_cache_flush() is called with replaced_nh ==
nh. It bumps fib6_sernum through rt_genid_bump_ipv6() and then returns
early on !replaced_nh->is_group, so fib6_nh_release_dsts() is never
called. Any rt6_ex created through a route using the group stays in
nh->nh_info->fib6_nh.rt6i_exception_bucket until nexthop_free_rcu()
runs.

That nexthop_free_rcu() is not always queued directly from the
NETDEV_UNREGISTER handler. If nh is also used directly by another IPv6
route, __remove_nexthop_fib() deletes that fib6_info. Its
fib6_purge_rt() only flushes exceptions created from itself, and the
reference on nh is only dropped by nexthop_put() in
fib6_info_destroy_rcu(). nexthop_free_rcu() is therefore queued from
inside an RCU callback. Before this patch, the rcu_barrier() here plus
the one in netdev_run_todo() drained that two-stage chain before the
old netns could go on with its pernet exit handlers.

Now consider dev being moved out of a netns that is about to exit, or
default_device_exit_net() moving it back to init_net from
default_device_exit_batch(). The moved device is not on the old
netns's todo list, so netdev_run_todo() issues a single rcu_barrier(),
which only runs fib6_info_destroy_rcu() and queues nexthop_free_rcu().
netdev_wait_allrefs_any() then sees the loopback refcount already at 1
and returns without another barrier. ops_undo_list() then runs
fib6_net_exit(), freeing net->ipv6.rt6_stats, and ip6_route_net_exit(),
calling dst_entries_destroy() on net->ipv6.ip6_dst_ops, both before
the final rcu_barrier() in cleanup_net().

When nexthop_free_rcu() finally runs, fib6_nh_release() ->
fib6_nh_release_dsts() -> fib6_nh_flush_exceptions() ->
rt6_remove_exception() decrements net->ipv6.rt6_stats->fib_rt_cache in
freed memory, and dst_release() reaches dst_entries_add() on the
destroyed pcpuc_entries counter. Nothing beyond CAP_NET_ADMIN in a
user-owned netns is needed to set this up with RTM_NEWNEXTHOP,
RTM_NEWROUTE and RTM_NEWLINK.

Chains with more stages, such as a one-member group or two members of
the same group on the moved device, look like they can outlast even
the two barriers the old code had. Removing this barrier makes the
simple case reachable as well.

Should the leaving nexthop's exceptions be flushed explicitly in
remove_nexthop_from_groups() or nh_rt_cache_flush(), so that the claim
in the commit message actually holds? Or would you rather keep the
barrier until the netns exit ordering is sorted out?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-bug-net-netns-move-rcu-barrier-v3-0-6084b02610b3%40linux.dev
