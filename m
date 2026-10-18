Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6573A344DB7;
	Sun, 18 Oct 2026 03:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792294583; cv=none; b=QePXaGgJ7KI+sqmGQUIdzKBR0u/0sXhrJigSHludPDe3aYrhi7iaFpv/WwO/1vFNTrBgtd0BevFnrvUneVsPiT9ubovAF/877aV8YP4hXwFmcT3wfoHX/gP9ZpXITgEXkHtmh5g/7PVvuVbxZLPoL3K30xl4jiKVl4VclytkQUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792294583; c=relaxed/simple;
	bh=ACHZxWmCN37RgbSYYmrHE4/NBiIMOBnNNpsYI2qE6mw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lTh4xo/azONysh+HHhKD7CqqHinHfObaBU43iwgpdusfan8GUu9DyVxkUYjDbH+CiGxt/0gMXvpjOtHdgHodfBbUOXQyoV+Rz/KoduKyZmaM+T7KefvnsVpDHDqHFcXIN4ztFBsBU1RHe1KG7d/4Mh8OqhvnAYKNa7yNBGo/zjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHM2n2P7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHM2n2P7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6038D1F000C4;
	Sun, 18 Oct 2026 03:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792294582;
	bh=QnWEPJayxPpyyDWH+a39Kmem0X6xb1GKVFGOHNM64yM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hHM2n2P7wf4oiU9im9pCQdT2I8Vl1yvT9SCA0DxHeYCmC5RoEaam6MGPfhiOOVtDc
	 rWsGad9IATUPWVuj2PmzGJ96QKclLFJxgmTxo9eqGwfnSOxyfPuN7yy0u4FR0NM/2t
	 PnISVvOgyPjE/16BBwEfdFa3Lq+q4YhMLqtVO1AvFA8LfMQaHxHqi0jHcH9likUw8M
	 Cro2pnu1e3c6uY75R5hlU0m0MfI2qlvbb+qtQ5sntf59E+gRYGbV7oNYUsgT3AqYnY
	 FN88v/UuxWLWv5qCb750be1008lmr54AqRV0kCYE3wA3vF9VXoQ5SpnsHFp7FlwyU6
	 H4UI0jV0j7mBQ==
Subject: Re: [PATCH net v2] net/ncsi: fix use-after-free of ncsi_channel in
 ncsi_remove_channel()
From: netdev-bot+sashiko@kernel.org
To: 18983559317@163.com
Cc: sam@mendozajonas.com, fercerpav@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 gwshan@linux.vnet.ibm.com, joel@jms.id.au, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 18 Oct 2026 03:36:20 +0000
Message-ID: <179229458091.3135.8180877668637139297@kernel.org>
In-Reply-To: <20261017024947.420683-1-18983559317@163.com>
References: <20261017024947.420683-1-18983559317@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete, and the race the commit message targets
  (rmmod ftgmac100 vs. NCSI_CMD_PKG_INFO) can still cause a use-after-…
- [Medium] The patch adds the RCU reader protocol only to the
  NCSI_CMD_PKG_INFO handlers.
- [Medium] The comment the patch adds in ncsi_remove_channel() (ncsi-
  manage.c:270-273) says the call_rcu() deferral protects the 'channel…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  ncsi_pkg_info_all_nl() passes get_net(sock_net(skb->sk)) to…

--

net/ncsi: fix use-after-free of ncsi_channel in ncsi_remove_channel()

This patch wraps the NCSI_CMD_PKG_INFO doit and dump handlers in
rcu_read_lock(). It also moves the freeing of ncsi_channel and its filter
arrays into an RCU callback. The goal is to close a use-after-free between
netlink package info readers and ftgmac100 teardown through
ncsi_unregister_dev().

> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 54d0df0a9efe6..c16047dee3f8a 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c

[ ... ]

> @@ -263,7 +267,11 @@ static void ncsi_remove_channel(struct ncsi_channel *nc)
>  	np->channel_num--;
>  	spin_unlock_irqrestore(&np->lock, flags);
>  
> -	kfree(nc);
> +	/* Readers (netlink package info walkers, channel configuration
> +	 * worker) may still hold the channel or its filter arrays;
> +	 * release everything after a grace period.
> +	 */
> +	call_rcu(&nc->rcu, ncsi_channel_release);

[Severity: Medium]

Does this grace period really cover the channel configuration worker?
ncsi_dev_work() -> ncsi_process_next_channel() / ncsi_configure_channel() /
ncsi_suspend_channel() does not run under rcu_read_lock(), so call_rcu()
does not wait for it.

ncsi_unregister_dev() stops the worker only after every channel has already
been passed to call_rcu():

ncsi_unregister_dev() {
	...
	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
		ncsi_remove_package(np);
	...
	disable_work_sync(&ndp->work);
	...
}

ncsi_remove_channel() does not unlink nc->link from ndp->channel_queue. It
also does not clear ndp->active_channel, ndp->hot_channel or
np->preferred_channel.

A worker that is running or preempted could still dereference nc after
ncsi_channel_release() has freed it. It could also list_del_init() a stale
nc->link in ncsi_process_next_channel().

It could also re-arm nc->monitor.timer through ncsi_start_channel_monitor()
in ncsi_configure_channel() after ncsi_stop_channel_monitor() has already
run timer_delete_sync(). The timer would then fire on freed memory.

The worker race itself predates this patch, because the old code called
kfree() right away.

Should the comment leave out the worker? Or should teardown call
disable_work_sync() before releasing the channels, use timer_shutdown_sync()
on the monitor timer, and unlink nc->link from channel_queue?

>  }
>  
>  struct ncsi_package *ncsi_find_package(struct ncsi_dev_priv *ndp,
> diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
> index 8cc538358f6a3..8d1fe60beb22f 100644
> --- a/net/ncsi/ncsi-netlink.c
> +++ b/net/ncsi/ncsi-netlink.c

[ ... ]

> @@ -192,7 +187,21 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
>  		kfree_skb(skb);
>  		return -EMSGSIZE;
>  	}
> +	/* The device is resolved and the lists are walked inside an RCU
> +	 * read-side critical section: the teardown path only unlinks these
> +	 * objects and frees them after a grace period.
> +	 */

[Severity: High]

Is this comment accurate for ndp and np? Only the channel free moved to
call_rcu(). The package and the device are still freed right after
list_del_rcu():

ncsi_remove_package() {
	...
	spin_lock_irqsave(&ndp->lock, flags);
	list_del_rcu(&np->node);
	ndp->package_num--;
	spin_unlock_irqrestore(&ndp->lock, flags);

	kfree(np);
}

ncsi_unregister_dev() {
	...
	spin_lock_irqsave(&ncsi_dev_lock, flags);
	list_del_rcu(&ndp->node);
	spin_unlock_irqrestore(&ncsi_dev_lock, flags);

	disable_work_sync(&ndp->work);

	kfree(ndp);
}

Inside the new rcu_read_lock() section, ncsi_write_package_info() still
reads ndp->package_num, ndp->package_whitelist and np->id, and it follows
the np->node and np->channels links.

ncsi_write_channel_info() reaches the parent package through a channel
that call_rcu() keeps alive:

	if (nc == nc->package->preferred_channel)

ncsi_pkg_info_all_nl() also holds on to package and reads package->id
after the walk.

ftgmac100_remove() calls ncsi_unregister_dev() before unregister_netdev().
So it looks like the same rmmod vs NCSI_CMD_PKG_INFO race from the commit
message can still cause a use-after-free, now on np or ndp instead of nc.

Do np and ndp also need kfree_rcu() or call_rcu(), or a synchronize_rcu()
before the kfree()?

> +	rcu_read_lock();
> +	ndp = ndp_from_ifindex(genl_info_net(info),
> +			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
> +	if (!ndp) {
> +		rcu_read_unlock();
> +		kfree_skb(skb);
> +		return -ENODEV;
> +	}
> +
>  	rc = ncsi_write_package_info(skb, ndp, package_id);
> +	rcu_read_unlock();

[Severity: Medium]

Do the other genl handlers in ncsi-netlink.c need the same change? These
handlers still call ndp_from_ifindex() and walk NCSI_FOR_EACH_PACKAGE() /
NCSI_FOR_EACH_CHANNEL() without rcu_read_lock():

ncsi_set_interface_nl()
ncsi_clear_interface_nl()
ncsi_send_cmd_nl()
ncsi_set_package_mask_nl()
ncsi_set_channel_mask_nl()

The commit message says "Either half alone leaves the race". On a
preemptible kernel, one of these walkers can be preempted mid-walk during
ncsi_unregister_dev(). The grace period can then end and
ncsi_channel_release() can free nc while the walker still uses it.

Several of these handlers also write through the pointers they find.
ncsi_set_interface_nl() stores the channel into package->preferred_channel
and updates package->channel_whitelist. ncsi_clear_interface_nl() takes
np->lock and writes np fields for each package.

Can these turn into use-after-free writes during teardown?

These ops are GENL_ADMIN_PERM and the family only works in init_net, so a
trigger needs CAP_NET_ADMIN. With CONFIG_PROVE_RCU_LIST these walks would
also cause suspicious RCU usage warnings.

>  
>  	if (rc) {
>  		nla_nest_cancel(skb, attr);
> @@ -228,20 +237,26 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
>  	if (!attrs[NCSI_ATTR_IFINDEX])
>  		return -EINVAL;
>  
> +	package_id = cb->args[0];
> +
> +	rcu_read_lock();
>  	ndp = ndp_from_ifindex(get_net(sock_net(skb->sk)),
>  			       nla_get_u32(attrs[NCSI_ATTR_IFINDEX]));

[Severity: Medium]

This is a pre-existing issue and was not introduced by this patch, but does
ncsi_pkg_info_all_nl() leak a netns reference here?

get_net(sock_net(skb->sk)) takes a reference that ndp_from_ifindex() never
drops, and there is no put_net() anywhere in net/ncsi/. get_net() runs
before the lookup, so the reference leaks even when no NCSI device is
found.

The same pattern is in ncsi_set_interface_nl(), ncsi_clear_interface_nl(),
ncsi_send_cmd_nl(), ncsi_set_package_mask_nl() and
ncsi_set_channel_mask_nl().

The family does not set netnsok, so only init_net is affected, and its
refcount grows with every dump call.

Would plain sock_net() be enough here?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017024947.420683-1-18983559317%40163.com
