Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9982C1586;
	Sat, 10 Oct 2026 05:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791610997; cv=none; b=hfvI1QWNZgZ0PE1f3YtsrLSsLZz1pFBvM/xKRGLxEd9r5TrB8/iLIdWS1VDZkDg+RdVDQn6jwI03sE/Q55fr2/Qltj4feR5X1bYbiBVF1wr/sjQzlRHb6pyG8Wo1PjalNhVh5UIH8qLTdysQqg8mHeKrDWHHpA0ax4e1iITRUho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791610997; c=relaxed/simple;
	bh=fcvTyorDZVAQcSi//s3684ji1jb7tADtK6qk1Hr9bp8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cg+/Xv39kY3kOkv2enbG9Ml/iN5K+vWSozkOlmgioROCRgY5OQ8EOI2OW8fKImv4DA+cPn1p6RPg0TR74suXzSiSEqQUlQEjay2j9S4dRHl6PdS+3Mv6N6I4aGbyh3WRKx3uNMuBzxTvcU299Ua7yNbbyk/HtTGi1vBDj+ps/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfWyQQ0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfWyQQ0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948731F000FF;
	Sat, 10 Oct 2026 05:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791610995;
	bh=3YnmJCsa7kbM20lpmm8VtN+4scPpbpWarKqIKdt8SIw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UfWyQQ0UI+wm/eeC4OtEO6ITnduJ+nc2cALBrAPngf+IOHJ6OXlzagKJ8GzQwKb4t
	 uo9T5RoW5Wh3iq5FEsqCJqud+01xifM0ctAqA4Aa7DzsEk/t3jKv0iurWuNaJcaBVh
	 poTbpdVoPu6DS2hRB73HdcCxLa4m2aaypCLubLLcZiQdKD0X5cGSaiKR3rV5gUI8Uq
	 XbHMcjjcJpiBHdsBei5gtUuqd0QMznswzf5KHuygnQL9uQu3GOSczva3zqIoZt3vvf
	 mwRKV4ugZUtKWIwbS5adzjF5DmG6gEVRQDPbdcWK0mRjf4tZ7RgNk7zY3ircNfAjzD
	 9GgAUmDFn8u0w==
Subject: Re: [PATCH net v3 1/3] ipv6: serialize address publication with
 device teardown
From: netdev-bot+sashiko@kernel.org
To: 4ncienth@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 05:43:14 +0000
Message-ID: <179161099408.434549.14449036924552933828@kernel.org>
In-Reply-To: <20261009054042.272944-2-4ncienth@gmail.com>
References: <20261009054042.272944-2-4ncienth@gmail.com>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] At the reviewed commit, the new disable_ipv6 recheck in
  ipv6_add_addr() under idev->lock does not cover non-unregister…

Pre-existing issues:
- [High] addrconf_dad_failure() (net/ipv6/addrconf.c) runs from
  ndisc_recv_ns()/ndisc_recv_na() in softirq without RTNL.

--

ipv6: serialize address publication with device teardown

This patch makes ipv6_add_addr() hold idev->lock across both the hash and
device-list publication. While holding it, the function rechecks
idev->dead and disable_ipv6. addrconf_ifdown() now sets idev->dead under
idev->lock, so an address can no longer be published on an idev that is
being unregistered.

> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index c90ee6dd7446c..77b3b1154d591 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c

[ ... ]

> @@ -1168,14 +1168,20 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
>  
>  	rcu_read_lock();
>  
> -	err = ipv6_add_addr_hash(idev->dev, ifa);
> +	write_lock_bh(&idev->lock);
> +
> +	if (idev->dead)
> +		err = -ENODEV;
> +	else if (READ_ONCE(idev->cnf.disable_ipv6))
> +		err = -EACCES;
> +	else
> +		err = ipv6_add_addr_hash(idev->dev, ifa);

[Severity: Critical]
At this commit, does the disable_ipv6 recheck cover a teardown that is not
an unregister? The commit message says:

  "then recheck both dead and disable_ipv6 before publishing. If teardown
  wins, reject the unpublished object."

addrconf_ifdown(dev, false) clears the hash in Step 2 while holding only
addrconf_hash_lock. It takes idev->lock later, for the addr_list snapshot.
addrconf_disable_change() also writes disable_ipv6 without holding
idev->lock.

A softirq publisher can insert into a hash bucket that Step 2 has already
scanned. Examples are RA prefix handling, DAD failure and tempaddr
creation. The publisher can then link the address into addr_list before
the snapshot is taken.

At this commit, the !keep path of the cleanup loop never unhashes:

net/ipv6/addrconf.c:addrconf_ifdown() {
    ...
		if (!keep) {
			write_lock_bh(&idev->lock);
			list_del_rcu(&ifa->if_list);
			write_unlock_bh(&idev->lock);
			in6_ifa_put(ifa);
		}
    ...
}

The final put reaches inet6_ifa_finish_destroy(). That function only does
WARN_ON(!hlist_unhashed(&ifp->addr_lst)) and then frees the address via
kfree_rcu() anyway.

Could this leave a freed inet6_ifaddr on net->ipv6.inet6_addr_lst, where
ipv6_chk_addr() and ipv6_get_ifaddr() would later walk it?

The next commit in this series, "ipv6: remove ifaddr from hash during
ifdown list cleanup", adds hlist_del_init_rcu(&ifa->addr_lst) under
addrconf_hash_lock in this path, which fixes it. Since this patch is
tagged for stable, should the two be backported together?

>  	if (err < 0) {
> +		write_unlock_bh(&idev->lock);
>  		rcu_read_unlock();
>  		goto out;
>  	}
>  
> -	write_lock_bh(&idev->lock);
> -
>  	/* Add to inet6_dev unicast addr list. */
>  	ipv6_link_dev_addr(idev, ifa);
>  

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. The
recheck above does not cover the window after ipv6_add_addr() returns to
addrconf_dad_failure().

addrconf_dad_failure() runs from ndisc_recv_ns()/ndisc_recv_na() in
softirq without RTNL. For IFA_F_STABLE_PRIVACY addresses it does:

net/ipv6/addrconf.c:addrconf_dad_failure() {
    ...
		ifp2 = ipv6_add_addr(idev, &cfg, false, NULL);
		if (IS_ERR(ifp2))
			goto lock_errdad;

		spin_lock_bh(&ifp2->lock);
		ifp2->stable_privacy_retry = retries;
		ifp2->state = INET6_IFADDR_STATE_PREDAD;
		spin_unlock_bh(&ifp2->lock);

		addrconf_mod_dad_work(ifp2, net->ipv6.sysctl.idgen_delay);
    ...
}

addrconf_ifdown() can run on another CPU because of NETDEV_DOWN,
disable_ipv6, or NETDEV_CHANGEMTU below IPV6_MIN_MTU. If it snapshots
addr_list after ifp2 is linked, it can tear ifp2 down completely before
the spin_lock_bh(&ifp2->lock) above:

CPU1 (addrconf_ifdown)
    ifa->state = INET6_IFADDR_STATE_DEAD;
    __ipv6_ifa_notify(RTM_DELADDR, ifa)
        ip6_del_rt(net, ifp->rt, false);
        ifp->rt = NULL;
    list_del_rcu(&ifa->if_list);
    in6_ifa_put(ifa);

CPU2 (addrconf_dad_failure)
    ifp2->state = INET6_IFADDR_STATE_PREDAD;
    addrconf_mod_dad_work(ifp2, ...);

Can CPU2 overwrite the DEAD state here and queue DAD work on an address
that has already been torn down?

Suppose IF_READY is still set and ifp2 has inherited IFA_F_OPTIMISTIC.
Then addrconf_dad_work()->addrconf_dad_begin() reaches:

	if (ifp->flags & IFA_F_OPTIMISTIC) {
		ip6_ins_rt(net, ifp->rt);

At this point ifp->rt is NULL, and __ip6_ins_rt() dereferences
rt->fib6_table. IF_READY stays set in two cases:

- the NETDEV_CHANGEMTU path calls addrconf_ifdown(dev, true) without a
  prior NETDEV_DOWN
- the link comes back up within idgen_delay

Otherwise the address is left in state DAD or POSTDAD. On the final put,
inet6_ifa_finish_destroy() then hits:

	if (ifp->state != INET6_IFADDR_STATE_DEAD) {
		pr_warn("Freeing alive inet6 address %p\n", ifp);
		return;
	}

so the ifaddr is never freed.

addrconf_dad_start() avoids this by checking for DEAD first:

	if (ifp->state != INET6_IFADDR_STATE_DEAD) {
		ifp->state = INET6_IFADDR_STATE_PREDAD;
		begin_dad = true;
	}

Would a similar check under ifp2->lock in addrconf_dad_failure() work?
The PREDAD write itself looks redundant, because ipv6_add_addr() already
returns the object in state 0 (PREDAD). No later patch in this series
changes addrconf_dad_failure().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009054042.272944-1-4ncienth%40gmail.com
