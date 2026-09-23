Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03124734F5;
	Wed, 23 Sep 2026 21:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197881; cv=none; b=b07nIhCJHhuj0f2SjIDh/Uu52MegPbmWyxxl3zuHtZGCiwjy+HFKG/YwUb1WHwFJ+UjYaCy+cmjoYdj6d8/CQ/MC7ZOb5JjZJRiMXYmxxKT8+70DRWqMjQrTwjnEfMAGrn69lIgm4KK1mJyOLj7tAPyRL+Z4bMaZUtu9JqLf7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197881; c=relaxed/simple;
	bh=5FtQcR8+jEtCMvB4clOLvo11zd+Z2o2Tulh0hEyJw6Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i/iju5848pNUxU0NnlK2Q0vaw303K1LREtYbCEbFzLxvMW46fwRb/Aujcm1SB9eEqTl1JycyM5RJkKFWfzapVmMqooggQpCJtgKojgCTJNqDSE4VNEMQtDd7LwLipmSP3xulNscOxdhwrazJFwSOmNh9xQ2CEVaK7tGU1/C+8H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGczRBdH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGczRBdH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D421F000FF;
	Wed, 23 Sep 2026 21:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790197870;
	bh=Wmlne3xhea92CKgrsw+s9+ei2zGV1mNPRIkzXlgKMyI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XGczRBdH/MH2/6vPt4DQxGLfT7T/nE8UPfjRi3HkoNLSrM7af1YJR7gvNZoGkXx71
	 /FX6gIpr0AQ1IacPi2/Ax0an5GqwjcIeKUJuBMuw2F4FTTKXxRNwKHWA4tT1lIf3d4
	 n7NDgHEiPZ5M8H4Lin1PavW5giXQayZUMFIbsEcSE72j4O7kH1MluT51W7B5MarzXp
	 RrRbPb2N0UOXWVg5gslRCyYqebmyWANd0Hp8w/blKkeO73Rc1DE5Ap9g8tV4M5CX3G
	 psQINfzzvuatEsxHQmueGax9H3O03vIYphENVOa6okfqbR1mYwNvBQXXvAw3w7XPfa
	 KoO+cq0fSE03g==
Subject: Re: [PATCH] ethtool: tsinfo: release net_device reference in
 ethnl_tsinfo_start()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, kory.maincent@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 21:11:09 +0000
Message-ID: <179019786959.2160803.15568602727130969916@kernel.org>
In-Reply-To: <20260919204803.2811673-1-benquike@gmail.com>
References: <20260919204803.2811673-1-benquike@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Lookup-then-lock without post-lock revalidation in the new
  single-device path of ethnl_tsinfo_dumpit()…
- [Low] New code uses the untracked, explicitly deprecated refcount pair
  dev_get_by_index()/dev_put() (net/ethtool/tsinfo.c:481 and :488)…

--

ethtool: tsinfo: release net_device reference in ethnl_tsinfo_start()

The patch stops ethnl_tsinfo_start() from holding the net_device reference
for the lifetime of the dump. It saves dev->ifindex in ctx->pos_ifindex,
sets a new ctx->single_dev flag, releases the reference immediately, and
re-looks-up the device by ifindex on each ethnl_tsinfo_dumpit() invocation.

> diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
> index c9b680a9cc3f..06f22a826dfa 100644
> --- a/net/ethtool/tsinfo.c
> +++ b/net/ethtool/tsinfo.c

[ ... ]

> @@ -476,12 +477,15 @@ int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>  	struct net *net = sock_net(skb->sk);
>  	int ret = 0;
>  
> -	if (ctx->req_info->base.dev) {
> -		struct net_device *dev = ctx->req_info->base.dev;
> +	if (ctx->single_dev) {
> +		struct net_device *dev = dev_get_by_index(net, ctx->pos_ifindex);
>  
> +		if (!dev)
> +			return -ENODEV;
>  		netdev_lock_ops_compat(dev);
>  		ret = ethnl_tsinfo_dump_one_net_topo(skb, dev, cb);
>  		netdev_unlock_ops_compat(dev);
> +		dev_put(dev);
>  		return ret;
>  	}

[Severity: Medium]
Is the device state re-checked anywhere after the lock is taken here?
dev_get_by_index() does a lockless RCU lookup and only takes a refcount,
and netdev_lock_ops_compat(dev) is acquired afterwards without revisiting
dev->reg_state, dev->moving_ns or dev_net(dev).

The core helper for this pattern does that re-check:

net/core/dev.c:__netdev_put_lock_ops_compat() {
	netdev_lock_ops_compat(dev);
	if (dev->reg_state > NETREG_REGISTERED ||
	    dev->moving_ns || !net_eq(dev_net(dev), net)) {
		netdev_unlock_ops_compat(dev);
		dev_put(dev);
		return NULL;
	}
	...
}

and netdev_get_by_index_lock_ops_compat() wires the lookup and that check
together:

net/core/dev.c:netdev_get_by_index_lock_ops_compat() {
	dev = dev_get_by_index(net, ifindex);
	if (!dev)
		return NULL;

	return __netdev_put_lock_ops_compat(dev, net);
}

Can this sequence run against a device that finished unregistering?

CPU0 (dump)                        CPU1 (ip link del <dev>)
dev_get_by_index()                 unregister_netdevice_many() under rtnl
                                     dev_close(), NETDEV_UNREGISTER
                                     reg_state = NETREG_UNREGISTERED
                                   netdev_run_todo() drops rtnl, then
                                     waits for the refcnt
netdev_lock_ops_compat(dev)
ethnl_tsinfo_dump_one_net_topo()

netdev_run_todo() documents that it drops rtnl before waiting:

net/core/dev.c:netdev_run_todo() {
	 * 2) Since we run with the RTNL semaphore not held, we can sleep
	 *    safely in order to wait for the netdev refcnt to drop to zero.
}

So after the lock is finally acquired, would ethnl_tsinfo_dump_one_netdev()
call dev->ethtool_ops->get_ts_info() and walk dev->link_topo->phys on a
device whose driver has already been stopped?  The same window also covers
"ip link set <dev> netns ...", where dev_net(dev) != net by the time the
lock is held - would that emit the ifindex, name and PHC capabilities of a
device that now lives in another namespace to the requesting socket?

The all-devices branch below is not exposed to this because
for_each_netdev_lock_ops_compat_scoped() goes through
__netdev_put_lock_ops_compat().  net/ethtool/rss.c ethnl_rss_dumpit()
handles the single-device case with the same revalidating iterator plus a
match_ifindex filter:

net/ethtool/rss.c:ethnl_rss_dumpit() {
	for_each_netdev_lock_ops_compat_scoped(net, dev, ctx->ifindex) {
		if (ctx->match_ifindex && ctx->match_ifindex != ctx->ifindex)
			break;
	...
}

Would switching these three statements to
netdev_get_by_index_lock_ops_compat() (dropping the trailing dev_put(),
since that helper consumes the reference), or following the rss.c filtered
iterator, be preferable here?

[Severity: Low]
This isn't a bug, but the get/put pair added here is the untracked one.
net/core/dev.c carries this comment directly above dev_get_by_index():

	/* Deprecated for new users, call netdev_get_by_index() instead */
	struct net_device *dev_get_by_index(struct net *net, int ifindex)

The rest of net/ethtool uses the tracked API, including the peer
implementation of this exact "save ifindex in ->start(), re-acquire in
->dumpit()" pattern in ethnl_perphy_dumpit():

net/ethtool/netlink.c:ethnl_perphy_dumpit() {
		netdevice_tracker dev_tracker;
		struct net_device *dev;

		dev = netdev_get_by_index(genl_info_net(&info->info),
					  ctx->ifindex, &dev_tracker,
					  GFP_KERNEL);
	...
}

and ethnl_parse_header_dev_get()/ethnl_parse_header_dev_put(), which this
patch calls.  With CONFIG_NET_DEV_REFCNT_TRACKER=y an untracked reference is
the one that cannot be attributed when "unregister_netdevice: waiting for
<dev> to become free" is reported, which is the failure this patch is
addressing.  Could netdev_get_by_index(net, ifindex, &tracker, GFP_KERNEL)
and netdev_put(dev, &tracker) be used instead?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919204803.2811673-1-benquike%40gmail.com
