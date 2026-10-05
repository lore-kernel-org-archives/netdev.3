Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157A8317144;
	Mon,  5 Oct 2026 05:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791179036; cv=none; b=EmwHtTPBZ21Srhs18MOJMIg5yv7KW4w2Ri+e9Ypd1+J4XshscYbNVOG73AXYXgzI+FbGVjvdvYeicGBWcbykF/ZBDx2e7E1WP36PROgRcuM2mlWj8vioRa86nQ4Q0VyJuXgOEuNY2bgMNX0mecJR6vvhWDBHC6XlrD+RA4sivkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791179036; c=relaxed/simple;
	bh=xP+WGFNm56hO+r5dARqGPf6tRhtvf256vf5kg1QeQ3g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fieg/j8BF8J7cFGfQViPqYcT6AAT+lZ5KKE8Olo8fz+e0kH2sxPbe/jnNhXbF5YNFCCGRNF1NGaOMIN4DXzcJodyTlVymfHWhhR3PWCGNcI8PAnFRjKYrKY/Ou6sFDy2pa8L3REltK7q1WchrODpmQiGz//cMqGXURzHqRtbRbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIziDx0Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIziDx0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299081F000FF;
	Mon,  5 Oct 2026 05:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791179034;
	bh=NSyfKk1MdZmdYf6bMLvQbQGvnoTw+HSCZk03c2AG8uw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JIziDx0QZ6xs3dFp5w7qdZpUxIXD1qAkDwCaBJzIgl2F6cCTUd9tOxZIcJG6/v535
	 pvGM+j9z2GBZCwSm/sXP22kOfrbhTeU1TDWHzbEyMnzlQH0fquyfengL4So/K73ZcF
	 5UVxv7hgwL1QQDd/0mj57oWYxYQZazXNCrllbre3Wc2ir2y0d3Md8iyS4x1VP4sCJb
	 /BRoHyLAO57VKfWo0Nhp4MFfDV+2kJ0SHtWVHJhAfrAlqg4b7BtyNLX/KuZUOeLcWO
	 uUQ9q53vO+zXCJBmu3TWyp7Db1c3YGVCvIQ8806V9zIPqikNnOMhKnOEV90mIANgCD
	 WJniyD5ustX8Q==
Subject:
 Re: [PATCH net] ipv6: serialize address publication with addrconf_ifdown
From: netdev-bot+sashiko@kernel.org
To: 4ncienth@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 05:43:53 +0000
Message-ID: <179117903368.434549.18116721683560446705@kernel.org>
In-Reply-To: <20261001052150.136559-1-4ncienth@gmail.com>
References: <20261001052150.136559-1-4ncienth@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Low] The new recheck in ipv6_add_addr_hash() reads idev->dead and
  idev->cnf.disable_ipv6 with plain loads…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it leaves open
  a race with the same symptom on the same nonblocking RA path.

--

ipv6: serialize address publication with addrconf_ifdown

This patch moves the idev->addr_list and tempaddr_list linking into
ipv6_add_addr_hash(). Both the hash and the device list publications now
happen under addrconf_hash_lock and then idev->lock. Before publishing,
the patch rechecks idev->dead and disable_ipv6, so an add that loses the
race with addrconf_ifdown() fails before the address is published.

> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index c90ee6dd7446c..899e9a47f7585 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c

[ ... ]

> @@ -1060,7 +1061,23 @@ static int ipv6_add_addr_hash(struct net_device *dev, struct inet6_ifaddr *ifa)
>  		netdev_dbg(dev, "ipv6_add_addr: already assigned\n");
>  		err = -EEXIST;
>  	} else {
> -		hlist_add_head_rcu(&ifa->addr_lst, &net->ipv6.inet6_addr_lst[hash]);
> +		write_lock(&idev->lock);
> +		if (idev->dead || idev->cnf.disable_ipv6) {
> +			err = idev->dead ? -ENODEV : -EACCES;

[Severity: High]
Does this recheck close the window for the addrconf_ifdown(dev, false)
callers?

idev->dead is set only when unregister is true. disable_ipv6 is set only
by the sysctl path and the DAD-abort path. Three callers set neither
flag: NETDEV_DOWN, CHANGEMTU on the loopback device, and
NETDEV_CHANGEUPPER to an L3 master:

addrconf_notify() {
    ...
	case NETDEV_DOWN:
	case NETDEV_UNREGISTER:
		...
		addrconf_ifdown(dev, event != NETDEV_DOWN);
    ...
	case NETDEV_CHANGEUPPER:
		...
		if (info->upper_dev && netif_is_l3_master(info->upper_dev))
			addrconf_ifdown(dev, false);
}

In the VRF case, do_vrf_add_slave() calls netdev_master_upper_dev_link()
while the port is still up and receiving RAs.

addrconf_ifdown() clears the hash one bucket at a time. Only after that
does it snapshot addr_list under idev->lock:

addrconf_ifdown() {
    ...
	/* Step 2: clear hash table */
	for (i = 0; i < IN6_ADDR_HSIZE; i++) {
		...
		spin_lock_bh(&net->ipv6.addrconf_hash_lock);
		...
		spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
	}

	write_lock_bh(&idev->lock);
    ...
	list_for_each_entry(ifa, &idev->addr_list, if_list)
		list_add_tail(&ifa->if_list_aux, &tmp_addr_list);
    ...
}

Suppose an RA is processed in softirq, without RTNL, on another CPU:

ndisc_router_discovery()
  addrconf_prefix_rcv()
    addrconf_prefix_rcv_add_addr()
      ipv6_add_addr(in6_dev, &cfg, false, NULL)

If it publishes into a bucket that Step 2 has already cleared, the ifa
goes into the snapshot but stays hashed. SLAAC addresses lack
IFA_F_PERMANENT, so keep is false and the Step 4 loop only does this:

		if (!keep) {
			write_lock_bh(&idev->lock);
			list_del_rcu(&ifa->if_list);
			write_unlock_bh(&idev->lock);
			in6_ifa_put(ifa);
		}

When the last reference is dropped, inet6_ifa_finish_destroy() fires
WARN_ON(!hlist_unhashed(&ifp->addr_lst)). Because the state is DEAD, it
still calls kfree_rcu(). ipv6_del_addr() cannot clean this up either,
because it returns early for DEAD addresses.

Can this leave inet6_addr_lst pointing at a freed inet6_ifaddr? If so,
later hash walks in ipv6_get_ifaddr(), ipv6_chk_addr(),
ipv6_chk_same_addr(), addrconf_verify_rtnl() and /proc/net/if_inet6
would read freed memory. The hlist_del_init_rcu() in a later unregister
would write to it.

This race existed before the patch, and the patch does not widen it.
Since the subject says publication is serialized with addrconf_ifdown,
could this mode be covered too? Two options would be unhashing in the
Step 4 !keep loop, or adding a going-down state that the add path checks.

[Severity: Low]
Should these reads use READ_ONCE()?

The writers hold RTNL only. They hold neither idev->lock nor
addrconf_hash_lock:

addrconf_ifdown():
	WRITE_ONCE(idev->dead, 1);

addrconf_disable_change():
	WRITE_ONCE(idev->cnf.disable_ipv6, newf);

addrconf_dad_work():
	WRITE_ONCE(idev->cnf.disable_ipv6, 1);

So the idev->lock held here does not protect these fields, although the
changelog suggests that the recheck relies on it. The check is correct
today only because addrconf_ifdown() stores dead and disable_ipv6 before
it takes addrconf_hash_lock in Step 2, and this check runs while holding
addrconf_hash_lock.

Could these become READ_ONCE() with a comment that names that ordering?
As written, KCSAN can report the race. A later reordering in
addrconf_ifdown(), such as setting dead after Step 2, would also silently
reopen the window. The earlier checks in ipv6_add_addr() use the same
plain reads.

> +		} else {
> +			hlist_add_head_rcu(&ifa->addr_lst,
> +					   &net->ipv6.inet6_addr_lst[hash]);
> +			ipv6_link_dev_addr(idev, ifa);
> +
> +			if (ifa->flags & IFA_F_TEMPORARY) {
> +				/* manage_tempaddrs() relies on addresses being added to the head */
> +				list_add(&ifa->tmp_list, &idev->tempaddr_list);
> +				in6_ifa_hold(ifa);
> +			}

[Severity: High]
This is a pre-existing issue, not one introduced by this patch, but there
seems to be a related window on the same nonblocking RA path.

ipv6_create_tempaddr() publishes the temporary address first. It sets
ifpub only after ipv6_add_addr() has returned and all locks are dropped:

ipv6_create_tempaddr() {
    ...
	ift = ipv6_add_addr(idev, &cfg, block, NULL);
    ...
	spin_lock_bh(&ift->lock);
	ift->ifpub = ifp;
    ...
	addrconf_dad_start(ift);
	in6_ifa_put(ift);
    ...
}

If Step 3 of addrconf_ifdown() runs between those two points, it removes
ift from tempaddr_list while ifpub is still NULL:

		list_del(&ifa->tmp_list);
		...
		if (ifa->ifpub) {
			in6_ifa_put(ifa->ifpub);
			ifa->ifpub = NULL;
		}
		...
		in6_ifa_put(ifa);

The creator then stores ifp in ift->ifpub, which hands over its reference
to ifp. Step 4 marks ift DEAD, because temporary addresses are never
IFA_F_PERMANENT. The final in6_ifa_put(ift) goes through
inet6_ifa_finish_destroy(), which never drops ifpub.

Nothing else releases that reference. ift is no longer on tempaddr_list,
and ipv6_del_addr() returns early for DEAD addresses.

Does this leak the reference on the public inet6_ifaddr? That would also
pin the inet6_dev and net_device, so unregister_netdevice() would wait
forever. This is the same netns cleanup stall that the commit message
describes.

The nonblocking caller is manage_tempaddrs()->ipv6_create_tempaddr(ifp,
false). It is reached from this softirq path without RTNL:

ndisc_router_discovery()
  addrconf_prefix_rcv()
    addrconf_prefix_rcv_add_addr()
      manage_tempaddrs()

So it can run at the same time as an RTNL-held addrconf_ifdown()
triggered by NETDEV_DOWN, an MTU drop, VRF enslave or unregister.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001052150.136559-1-4ncienth%40gmail.com
