Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E0D3BBA08;
	Fri,  9 Oct 2026 04:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791521829; cv=none; b=fzqNxIkVYtsq6IIfmYCu47e8yKlvFB5sBFUk+cLVokZsv7oboKIRjSZtLBlC9jHTY6wGt3ibru94Jh4o787cflfzcAPMLb8Tm03JQUJH3WlmuI4ozsRKphoG5HnBCeFDr7gD8BL2q0e+SAbJWIVaAKYa/IF6+F9aOk8rWsAZvJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791521829; c=relaxed/simple;
	bh=okdmI8avXIfYGPzl8+5G448wnaivIt0/wvwBaT2nwVM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Km+9zHdJMWdMNLKmyQgsu7VmDNAvESSA6OKFuNHVAxwafDA0fciZpb8hfVBTHjTHhkYk+IlNnysWtXvvqI8EYL5Bi6NgLXluhXPTvmBC3q18LLNXvgh2lUX3Hl9Cdd3niJLkFC6db96+Vc0sPaa34MULRvkkjjYJlot+J0LeZj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSmNIB/u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSmNIB/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ED01F000FF;
	Fri,  9 Oct 2026 04:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791521827;
	bh=s0C8rMEEr2WMv2vEO2SPpseazIPbB1FsAbpuv1X1xKg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jSmNIB/uFUGW/hAo96K4omU/Zg54NHgj9LYGQfNVKwNJXqq3+LDEpt4kVWVcNx0Z4
	 KJlUKa4D8o+smA5FepPkYKu6AZ5vyHIw1gGbP6LNlsB0UxJS2FTXhoaSCJ+kZeOMrR
	 Nj5FLn/j0cTZ1UyW9j4isqr2TO4eLDF/g03QfK19UMubjX7YB0TwabCe37oGGkBa36
	 3MVrHt2zZKT3ZQvLNfzpAOOCp6I51W1avlVDh9R6SnOzV8/iqMrbwYRzoAbDd2RX/a
	 0WTabGpLGWGb6mpXiF0l6LBgQ3384pSpnDtD9FG95HW8vYMLOI1ZL01Hx6sbfUz9wY
	 GC5T+b7ex3Zpw==
Subject: Re: [PATCH net] ipv4: do not warn on route notification size race
From: netdev-bot+sashiko@kernel.org
To: 4ncienth@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 amcohen@nvidia.com, roopa@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 09 Oct 2026 04:57:06 +0000
Message-ID: <179152182668.434549.18232968419539498055@kernel.org>
In-Reply-To: <20261007045410.3806739-1-4ncienth@gmail.com>
References: <20261007045410.3806739-1-4ncienth@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] netlink: EMSGSIZE propagation to listeners breaks routing
  daemons

Pre-existing issues:
- [High] fib6_info_hw_flags_set() (net/ipv6/route.c:6471-6523) reads RCU-
  protected nexthop state without rcu_read_lock() and without RTNL.
- [Medium] fib6_info_hw_flags_set() in net/ipv6/route.c is the IPv6
  counterpart of fib_alias_hw_flags_set(), and it still has the false-…

--

ipv4: do not warn on route notification size race

This patch removes the WARN_ON(err == -EMSGSIZE) in
fib_alias_hw_flags_set(). With nexthop compat mode enabled, a concurrent
nexthop group replacement can grow the group between fib_nlmsg_size()
and fib_dump_info(), so -EMSGSIZE is a legitimate result there. The
existing error path still frees the skb and reports the error to
listeners.

Link: https://lore.kernel.org/netdev/20261004082043.GB92032@shredder/

> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> index acb1e43859143..248514dce0cdd 100644
> --- a/net/ipv4/fib_trie.c
> +++ b/net/ipv4/fib_trie.c
> @@ -1079,8 +1079,6 @@ void fib_alias_hw_flags_set(struct net *net, const struct fib_rt_info *fri)
>  
>  	err = fib_dump_info(skb, 0, 0, RTM_NEWROUTE, fri, 0);
>  	if (err < 0) {
> -		/* -EMSGSIZE implies BUG in fib_nlmsg_size() */
> -		WARN_ON(err == -EMSGSIZE);
>  		kfree_skb(skb);
>  		goto errout;
>  	}

[Severity: High]
With this patch -EMSGSIZE is treated as an expected result here
rather than a sizing bug. What should listeners see when it happens?

The error path still ends in:

errout:
	rtnl_set_sk_err(net, RTNLGRP_IPV4_ROUTE, err);

So the raw -EMSGSIZE from fib_dump_info() is passed through
netlink_set_err() to every RTNLGRP_IPV4_ROUTE listener. In
do_one_set_err() only ENOBUFS is filtered for sockets that set
NETLINK_NO_ENOBUFS:

	if (p->code == ENOBUFS && nlk_test_bit(RECV_NO_ENOBUFS, sk)) {

EMSGSIZE is therefore always written to sk->sk_err, and the next
recvmsg() on each listener socket fails with it.

Routing daemons that subscribe to this group generally read ENOBUFS
as "a notification was dropped, resync". EMSGSIZE on a multicast
listener socket is not something they are likely to expect from the
kernel. Depending on the daemon, it could be handled as a fatal
socket error or simply not trigger a resync, which would leave its
view of the route table stale.

The commit message now says this race is reachable when a nexthop
replacement runs while hardware flags change. That makes this path
more likely to be hit than the old WARN_ON() implied.

Would it make sense to report -ENOBUFS to listeners in this case, so
it looks like any other lost notification? Alternatively, the skb
could be resized and the fill retried, as __inet6_rt_notify() already
does for the same race:

	/* -EMSGSIZE implies needed space grew under us. */
	if (err == -EMSGSIZE) {
		sz = max(rt6_nlmsg_size(rt), sz << 1);
		goto retry;

[Severity: Medium]
This isn't a bug introduced by this patch, but the IPv6 counterpart in
net/ipv6/route.c still has the same warning:

net/ipv6/route.c:fib6_info_hw_flags_set() {
    ...
	skb = nlmsg_new(rt6_nlmsg_size(f6i), GFP_KERNEL);
    ...
	err = rt6_fill_node(net, skb, f6i, NULL, NULL, NULL, 0, RTM_NEWROUTE, 0,
			    0, 0, RT_DEL_REASON_UNSPEC);
	if (err < 0) {
		/* -EMSGSIZE implies BUG in rt6_nlmsg_size() */
		WARN_ON(err == -EMSGSIZE);
    ...
}

For an nh-backed route, rt6_nlmsg_size() reads nh->nh_grp once through
nexthop_for_each_fib6_nh(). With nexthop_compat_mode enabled,
rt6_fill_node() reads the group a second time through
rt6_fill_node_nexthop()->nexthop_mpath_fill_node().

Between those two reads, replace_nexthop_grp() can publish a larger group
in place with rcu_assign_pointer(old->nh_grp, newg). The callers,
mlxsw_sp_router_fib6_event_work() and nsim_fib_event_work(), hold only
their driver mutexes and not RTNL.

__inet6_rt_notify() in the same file already treats this as an expected
race:

	/* -EMSGSIZE implies needed space grew under us. */
	if (err == -EMSGSIZE) {
		sz = max(rt6_nlmsg_size(rt), sz << 1);
		goto retry;

Can the IPv6 WARN_ON() still fire if a much larger "ip nexthop replace"
runs while the driver work item is between rt6_nlmsg_size() and
rt6_fill_node()? This code has not changed since 907eea486888 ("net:
ipv6: Emit notification when fib hardware flags are changed").

This patch is going to stable. Would a companion patch for
fib6_info_hw_flags_set() make sense, so that IPv4 and IPv6 handle the
same race the same way?

[Severity: High]
This is also a pre-existing issue, not one introduced by this patch. It
came up while comparing the two paths.

fib_alias_hw_flags_set() wraps both the sizing and the fill in
rcu_read_lock(). fib6_info_hw_flags_set() holds neither rcu_read_lock()
nor RTNL around rt6_nlmsg_size() and rt6_fill_node().

For an nh-backed f6i, those paths reach rcu_dereference_rtnl() on
nh->nh_grp and nh_info. They do this through nexthop_for_each_fib6_nh(),
nexthop_is_blackhole() (documented as "called with rcu lock"),
nexthop_is_multipath(), nexthop_fib6_nh(), and:

include/net/nexthop.h:nexthop_mpath_fill_node() {
	struct nh_group *nhg = rcu_dereference_rtnl(nh->nh_grp);
	int i;

	for (i = 0; i < nhg->num_nh; i++) {
		struct nexthop *nhe = nhg->nh_entries[i].nh;
		struct nh_info *nhi = rcu_dereference_rtnl(nhe->nh_info);
    ...
}

rt6_fill_node() takes rcu_read_lock() only around the fib6_siblings
walk. rt6_nlmsg_size() takes it only on the non-nh path.

On the writer side, replace_nexthop_grp() relies on readers being inside
RCU read-side sections:

	rcu_assign_pointer(old->nh_grp, newg);

	/* Make sure concurrent readers are not using 'oldg' anymore. */
	synchronize_net();

The old group then moves to new->nh_grp, and it is freed through:

replace_nexthop()->nexthop_put(new)->call_rcu_hurry(nexthop_free_rcu)
    ->nexthop_free_group()->kfree(nhg)

Here is the scenario on a PREEMPT_RCU kernel:

- net.ipv6.fib_notify_on_flag_change is set to 1 or 2.
- An IPv6 route using a nexthop group is offloaded by mlxsw or netdevsim.
- The driver work item is preempted after loading oldg in
  nexthop_mpath_fill_node().
- Meanwhile "ip nexthop replace" runs on that group.

Can the grace period and nexthop_free_group() complete before the work
item resumes? If so, nhg->num_nh and nhg->nh_entries[i].nh->nh_info
would be read after the group is freed, and the freed data could end up
in the RTM_NEWROUTE notification.

Even without the race, would CONFIG_PROVE_RCU report "suspicious
rcu_dereference_check() usage" on every call that takes this path?

Should fib6_info_hw_flags_set() hold rcu_read_lock() across
rt6_nlmsg_size() and rt6_fill_node(), as the IPv4 version does?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007045410.3806739-1-4ncienth%40gmail.com
