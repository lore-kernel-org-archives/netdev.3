Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794428392;
	b=iRXxVb3xS3aLzYvGgDKXmudcR9rk6KFOFexIXFE4733sT3sIz3U+DLdNc6lt5aYiidGS
	 +FCxyYPsTqaE3eqvfidIef4PMqvRkM/Z8fjSDproY/6Sralfr+dbPSDrRvey0X9G5ZNNm
	 xvmsta3jQgvjzCjDBKfHKjYi59KKcs99sL4xnF6aYU/MW4DgM9GgUolngLvNsCUc1XM/w
	 eCEy0bO+0OY3S0K87VbBN8ahtuItCFAFE38BcFepdUxqfEo4vdKSGY8CESDYyG6BLvlGI
	 0PLM7EWXfVwwXs3tyStE6EyObl+9YnLqZIJiqB/XbNpxlU9hmz4ygFkj4inzYICLZdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794428392;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Fsi3SvXQUI8beUZD4/4ALv8TUVO2+64GykYur4chSg0=;
	b=KX8qMnDXRZQ8n/W/cp4YzhgopEXljho0udyxWyXTGq6SUgOHMISXdd3I4G/1fLdpNMhH
	 TXugKTNYp4J0cyoDOrLI32RJvQbB/JXL3kPRYwim+elSCg9uWLbfSf3G9QYWekYwVQw/s
	 6iLJzZAJnjP4yrMoYkWmLPu9AvhFiFqmldxl7+lI1qYufQM3bxHsm46CKyCIqcGb0Cqjw
	 VldOkmUkwnDd2HEOdx8OuE1aUGhmQq35Hyj82oXcYUWwxhaRinFR4laLtwtHWmZBRPFAs
	 YipmRkp5DuWPIENTsOCKpdWdhlL8AePbWeH1kfhbP85cTThU2vmir/6G6AMwXV752sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dv8/JS/W";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F4E606A337;
	Wed, 11 Nov 2026 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dv8/JS/W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D041F00A05;
	Wed, 11 Nov 2026 20:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428392;
	bh=Fsi3SvXQUI8beUZD4/4ALv8TUVO2+64GykYur4chSg0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dv8/JS/WtCxtJMYBkwaaR78mK1evKCVNuCkyp5iuPsesT/fjBuY0z11m67+DQQvgt
	 B8YFb3P2ZgUQQoct8rDltOREnv6mxzNES2rvnsZO+kz39nou8LOmcyjBLkGY2s6TUx
	 +yvLSWCo2FBo+x55XQB6Xo5F09ox6QIRNEr3ftbKLDT1MvknlbdEHypTg7fy131BlR
	 Su4L6kBcHhI7GSlPv+3TNX78Hjh5CGi7qluKu3dW7QYSy/ZM3nBBxt5CnnSFiKWbHe
	 FEpnvqhnoLkQThZgYbd9L0EGg1ud6gPUg7Zu6rDZ+jWExjgJwDjR1Qux47wED7dWmj
	 gw3JOAkmb2D1Q==
Subject: Re: [PATCH net-next v3 3/4] nexthop: flush cached routes when a
 nexthop leaves a group
From: netdev-bot+sashiko@kernel.org
To: qiliang.yuan@linux.dev
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 razor@blackwall.org, kuniyu@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 11 Nov 2026 20:19:51 +0000
Message-ID: <179442839125.2199510.2780924830588090717@kernel.org>
In-Reply-To: <20261109-bug-net-netns-move-rcu-barrier-v3-3-6084b02610b3@linux.dev>
References: <20261109-bug-net-netns-move-rcu-barrier-v3-3-6084b02610b3@linux.dev>
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

- [High] In remove_nexthop_from_groups() (net/ipv4/nexthop.c), the new
  loop calls nh_rt_cache_flush(net, nhge->nh_parent, nh) once for every…

--

nexthop: flush cached routes when a nexthop leaves a group

When a nexthop is removed and other members keep its group alive, dsts
cached through the removed nexthop could stay in use until the nexthop is
freed from an RCU callback. This patch calls nh_rt_cache_flush() for each
affected group in remove_nexthop_from_groups(), after synchronize_net().

> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 42e55b5a755ee..e0089a6450e75 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c

[ ... ]

> @@ -2130,6 +2133,13 @@ remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
>  	/* make sure all see the newly published array before releasing rtnl */
>  	synchronize_net();
>  
> +	/* Routes through the groups can still hold dsts cached through @nh,
> +	 * which are only released when @nh is freed. Invalidate them now that
> +	 * no reader can pick @nh from the old groups any more.
> +	 */
> +	list_for_each_entry(nhge, &deferred_free, nh_list)
> +		nh_rt_cache_flush(net, nhge->nh_parent, nh);

[Severity: High]
This loop runs a netns-wide flush once for every surviving group. Is
that needed, or would one flush after the loop be enough?

remove_nexthop_from_groups() is only reached from the !nh->is_group
branch of __remove_nexthop(), so @nh is never a group here. That means
each nh_rt_cache_flush() call only does the two global invalidations:

net/ipv4/nexthop.c:nh_rt_cache_flush() {
	if (!list_empty(&nh->fi_list))
		rt_cache_flush(net);

	spin_lock_bh(&nh->lock);
	have_f6i = !list_empty(&nh->f6i_list);
	spin_unlock_bh(&nh->lock);
	if (have_f6i)
		rt_genid_bump_ipv6(net);

	if (!replaced_nh->is_group)
		return;
	...
}

rt_cache_flush() is just a genid bump. rt_genid_bump_ipv6(), however,
calls fib6_flush_trees(), and __fib6_clean_all() then walks every IPv6
table in the netns while holding tb6_lock with BH disabled:

net/ipv6/ip6_fib.c:__fib6_clean_all() {
	...
			spin_lock_bh(&table->tb6_lock);
			fib6_clean_tree(net, &table->tb6_root,
					func, sernum, arg, skip_notify);
			spin_unlock_bh(&table->tb6_lock);
	...
}

The comment above __fib6_flush_trees in addrconf_core.c describes this
as "fairly expensive, be careful".

Every route through a group puts its fib6_info on the group's f6i_list
(fib6_add() does list_add(&rt->nh_list, &rt->nh->f6i_list)). So any
group that carries IPv6 routes triggers a full walk. After the first
walk, the walks for the remaining groups have no additional effect.

Before this patch, removing a nexthop from G groups did no fib6 walk.
Now it does G full walks back to back under RTNL, with no
cond_resched().

On link down or unregister, nexthop_flush_dev() calls remove_nexthop()
for every nexthop on the device, which multiplies the cost again. With
FRR using kernel nexthop groups, one peer nexthop is often a member of
many ECMP groups, and a full IPv6 table can hold around 200k routes.

CAP_NET_ADMIN in a user namespace is enough to set this up. Could that
lead to long RTNL hold times, or soft-lockup or RCU stall warnings on
!PREEMPT kernels?

The replace_nexthop() precedent cited in the commit message calls
nh_rt_cache_flush() once per operation. For groups, it uses the targeted
fib6_nh_release_dsts() instead of repeated global walks. The IPv4 side
of this file also batches through need_flush and a single fib_flush().

Would it work to collect the fi_list and f6i_list checks into two
booleans in this loop, and then call rt_cache_flush() and
rt_genid_bump_ipv6() at most once afterwards? Another option is to
release only the removed nexthop's own dsts with fib6_nh_release_dsts(),
which does not need a tree walk.

> +
>  	/* Now safe to free percpu stats — all RCU readers have finished */
>  	list_for_each_entry_safe(nhge, tmp, &deferred_free, nh_list) {
>  		list_del(&nhge->nh_list);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-bug-net-netns-move-rcu-barrier-v3-0-6084b02610b3%40linux.dev
