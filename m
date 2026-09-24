Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2705D3515C7
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275035; cv=none; b=H1JV/N0RerOF74WLZaERHLncrdab5t59K48PR/BF/Q/bRfS0VsNaLKY0+xAxUcJvIEW3XzkGQ1NwOOjxM0CpSCbsggTw/mCfPlquh9NJ62F+2PehpOvrY64Cd3aUzU+CxwrZsMwAwAMnxpMpLpZxdYbJmNUKHNP5bJWnfZuwQ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275035; c=relaxed/simple;
	bh=69CWd/7AW5rrYbsTFz1bpUAFrV0pYhDc05yv1pMJC+Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=METOL1y5bmpJ4LC2oYOMGEB/p+HKEFlpFJu3GGtiJOxDZeXeKr0Hu5P1Q8Rqo1GHlqObczltJF29dB1H5sLkzRWBkv9rf1akGD7YEy6tfd3r/lXQnwLZuqnH6xnyG97zl9V54M28YlE9m3kMWV/KxXTWiYNNhMWl6PrYfZ8oyS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkGr5KCh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkGr5KCh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03DD1F000FF;
	Thu, 24 Sep 2026 18:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790275034;
	bh=M0IcHnP4FaWiw3jhb2dK9AD3iem/r7Oo+dlCSa0taro=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZkGr5KChembJr9Kyt7b0M8SIYbDm5WqhkjeE9SAYsNxqDIvW8sm72Zu0F4yh3KlRx
	 iRPLNghHnKcY5bixMFftXTZMLnLKM8JHScX9X+CsuPOR10nLfEFE+dYw4Gp7RXdmlY
	 YK64f5oxaKoUyRNbI9YtMPMbOR4xKr9BhNpio7unCFP70iS/fRIxe6tQTvIdDaoiuj
	 M/DwFw9eWKb/uSWmsCfuiFeOObSDXMJnotL0YsCjWxD34SAv+ptb8jcHlxdDlcDoEC
	 v8Kdp04Oxu88qX/NcYVgvr9gR/0qf5btwZ44MBLC0DU1cDYsAuvKjq8lHVOX+nd1se
	 4iBue5z3jQFhw==
Subject: Re: [PATCH v6] net/ncsi: Fix Use-After-Free in NCSI teardown using
 synchronize_rcu
From: netdev-bot+sashiko@kernel.org
To: wongboonjhee52@gmail.com
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org
Date: Thu, 24 Sep 2026 18:37:13 +0000
Message-ID: <179027503337.2160803.14322570323974429407@kernel.org>
In-Reply-To: <20260921153633.565779-1-wongboonjhee52@gmail.com>
References: <20260921153633.565779-1-wongboonjhee52@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix's reclamation model (list_del_rcu(&ndp->node) ->
  synchronize_rcu() -> kfree everything) is only correct if every reader…
- [High] The new 'Stop all request producers' loop in
  ncsi_unregister_dev() does not guarantee that an executing channel-…
- [Medium] The newly added vlan_vids drain in ncsi_unregister_dev() uses
  plain list_del() followed by immediate kfree() on ndp->vlan_vids, a…
- [Low] Unrelated fixes bundled under one Fixes: tag.

Pre-existing issues:
- [High] Peer call-site inconsistency / net namespace reference leak
  around ndp_from_ifindex().

--

net/ncsi: Fix Use-After-Free in NCSI teardown using synchronize_rcu

This patch reorders ncsi_unregister_dev() so the device is unlinked from
ncsi_dev_list first, followed by synchronize_rcu(), stopping channel
monitors, draining ndp->requests[] and ndp->vlan_vids, and only then
freeing packages, channels and ndp.  It also wraps the NCSI netlink
handlers in rcu_read_lock()/rcu_read_unlock() around the ndp lookup and
use.

A few questions below about the new teardown ordering and about the
netlink handlers.

> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 54d0df0a9efe6..00941c6302700 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -1956,19 +1956,43 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
>  {
>  	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
>  	struct ncsi_package *np, *tmp;
> +	struct ncsi_channel *nc;
> +	struct vlan_vid *vlan, *vlan_tmp;
>  	unsigned long flags;
> -
> -	dev_remove_pack(&ndp->ptype);
> -
> -	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
> -		ncsi_remove_package(np);
> +	int i;
>  
>  	spin_lock_irqsave(&ncsi_dev_lock, flags);
>  	list_del_rcu(&ndp->node);
>  	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
>  
> +	dev_remove_pack(&ndp->ptype);
>  	disable_work_sync(&ndp->work);
>  
> +	/* Wait for readers that found this device before it was unlinked. */
> +	synchronize_rcu();

[Severity: High]
Does this synchronize_rcu() actually cover every reader that can obtain
ndp?  The reclamation model here (list_del_rcu(&ndp->node) then
synchronize_rcu() then kfree of everything) only holds if all readers walk
ncsi_dev_list inside an RCU read-side section.

ncsi_vlan_rx_add_vid() and ncsi_vlan_rx_kill_vid() look like they do the
lookup with no rcu_read_lock() at all:

net/ncsi/ncsi-manage.c:ncsi_vlan_rx_add_vid() {
	nd = ncsi_find_dev(dev);
	...
	ndp = TO_NCSI_DEV_PRIV(nd);

	/* Add the VLAN id to our internal list */
	list_for_each_entry_rcu(vlan, &ndp->vlan_vids, list) {
	...
	ncsi_kick_channels(ndp);
	...
}

and ncsi_find_dev() traverses the list with the RCU helper:

net/ncsi/ncsi-manage.c:ncsi_find_dev() {
	NCSI_FOR_EACH_DEV(ndp) {      /* list_for_each_entry_rcu() */
		if (ndp->ndev.dev == dev)
			return &ndp->ndev;
	}
}

So can this sequence still hit freed memory?

CPU0: ncsi_vlan_rx_add_vid()
	nd = ncsi_find_dev(dev);        /* returns ndp, no RCU section */
	<preempted>

CPU1: ncsi_unregister_dev()
	list_del_rcu(&ndp->node);
	synchronize_rcu();              /* CPU0 is not an RCU reader */
	... frees requests, vlan entries, channels, packages ...
	kfree(ndp);

CPU0: resumes and dereferences ndp (ndp->vlan_vids, list_add_rcu(),
      ncsi_kick_channels(ndp), ncsi_process_next_channel(ndp))

ftgmac100_remove() calls ncsi_unregister_dev() before unregister_netdev(),
and the ftgmac100_open() error path unregisters NCSI while the netdev stays
registered, so the ndo_vlan_rx_add_vid/kill_vid callbacks are still
reachable from user space during teardown.  Would those two callbacks also
need rcu_read_lock() (they additionally trip the CONFIG_PROVE_RCU
"RCU-list traversed in non-reader section" assertion today)?

> +
> +	/* Stop all request producers before draining request state. */
> +	list_for_each_entry(np, &ndp->packages, node) {
> +		list_for_each_entry(nc, &np->channels, node)
> +			ncsi_stop_channel_monitor(nc);
> +	}

[Severity: High]
Is this loop enough to guarantee the monitor timer callback has finished?
ncsi_stop_channel_monitor() returns early without any synchronization when
the flag is already clear:

net/ncsi/ncsi-manage.c:ncsi_stop_channel_monitor() {
	spin_lock_irqsave(&nc->lock, flags);
	if (!nc->monitor.enabled) {
		spin_unlock_irqrestore(&nc->lock, flags);
		return;
	}
	nc->monitor.enabled = false;
	spin_unlock_irqrestore(&nc->lock, flags);

	timer_delete_sync(&nc->monitor.timer);
}

but ncsi_channel_monitor() clears that same flag itself and then keeps
touching nc and ndp, both on the bad_state path and on the
"NCSI Channel %d timed out!" default path:

net/ncsi/ncsi-manage.c:ncsi_channel_monitor() {
	...
		spin_lock_irqsave(&nc->lock, flags);
		nc->monitor.enabled = false;
		nc->state = NCSI_CHANNEL_INVISIBLE;
		ncm->data[2] &= ~0x1;
		spin_unlock_irqrestore(&nc->lock, flags);

		spin_lock_irqsave(&ndp->lock, flags);
		nc->state = NCSI_CHANNEL_ACTIVE;
		list_add_tail_rcu(&nc->link, &ndp->channel_queue);
		spin_unlock_irqrestore(&ndp->lock, flags);
		ncsi_process_next_channel(ndp);
		return;
}

So if the callback is running on another CPU and has just dropped nc->lock
after clearing monitor.enabled, the new loop becomes a no-op and teardown
continues to ncsi_remove_package() -> ncsi_remove_channel() -> kfree(nc),
kfree(np), then kfree(ndp).  Can the callback then write into freed memory
via the list_add_tail_rcu() into ndp->channel_queue and the nc->state
store?  The earlier synchronize_rcu() does not help here, since the timer
callback is not an RCU reader of ncsi_dev_list.

Also, ncsi_remove_channel() already calls ncsi_stop_channel_monitor(nc),
so is the extra loop doing anything beyond duplicating that call?

> +
> +	for (i = 0; i < ARRAY_SIZE(ndp->requests); i++) {
> +		struct ncsi_request *nr = &ndp->requests[i];
> +
> +		timer_delete_sync(&nr->timer);
> +		if (nr->used)
> +			ncsi_free_request(nr);
> +	}
> +
> +	list_for_each_entry_safe(vlan, vlan_tmp, &ndp->vlan_vids, list) {
> +		list_del(&vlan->list);
> +		kfree(vlan);
> +	}

[Severity: Medium]
Is plain list_del() the right unlink here?  ndp->vlan_vids is published and
traversed with the RCU helpers elsewhere in the same file:

net/ncsi/ncsi-manage.c:ncsi_vlan_rx_add_vid() {
	list_for_each_entry_rcu(vlan, &ndp->vlan_vids, list) {
	...
	list_add_rcu(&vlan->list, &ndp->vlan_vids);
}

list_del() stores LIST_POISON1 into entry->next, so a concurrent
list_for_each_entry_rcu() walk would follow a poisoned pointer, and the
kfree() is immediate rather than deferred past a grace period.  Note the
synchronize_rcu() earlier in this function happens before these unlinks, so
it does not cover them.  Would list_del_rcu() plus a deferred free (or
performing this drain only after the readers are provably quiesced) be more
appropriate?

[Severity: Low]
This isn't a bug, but the vlan_vids drain and the ndp->requests[] drain
look like separate fixes from the RCU reclamation change, and neither is
mentioned in the commit message.

At baseline nothing freed ndp->vlan_vids, and ftgmac100_remove() calls
ncsi_unregister_dev() before unregister_netdev(), so those entries were
leaked; the requests[] walk additionally releases still-held cmd/rsp SKBs
through ncsi_free_request() -> consume_skb(cmd)/consume_skb(rsp).  Only the
nr->timer cancellation seems required by the new ordering, since nr->timer
is embedded in ndp.

Would it make sense to split these into separate patches, given they all
land under the single "Fixes: 2d283bdd079c" tag?

> +
> +	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
> +		ncsi_remove_package(np);
> +
>  	kfree(ndp);
>  }
>  EXPORT_SYMBOL_GPL(ncsi_unregister_dev);

> diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
> index 8cc538358f6a3..f8ea2ea73fb0d 100644
> --- a/net/ncsi/ncsi-netlink.c
> +++ b/net/ncsi/ncsi-netlink.c

[ ... ]

> @@ -228,11 +236,14 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
>  	if (!attrs[NCSI_ATTR_IFINDEX])
>  		return -EINVAL;
>  
> +	rcu_read_lock();
>  	ndp = ndp_from_ifindex(get_net(sock_net(skb->sk)),
>  			       nla_get_u32(attrs[NCSI_ATTR_IFINDEX]));
>  
> -	if (!ndp)
> +	if (!ndp) {
> +		rcu_read_unlock();
>  		return -ENODEV;
> +	}

[Severity: High]
This is a pre-existing issue and not introduced by this patch, but since
new return paths are being added right next to it: does this get_net() leak
a struct net reference?

ndp_from_ifindex() treats its struct net * as borrowed and never drops it:

net/ncsi/ncsi-netlink.c:ndp_from_ifindex() {
	dev = dev_get_by_index(net, ifindex);
	...
	dev_put(dev);
	return ndp;
}

git grep put_net over net/ncsi/ finds nothing.  ncsi_pkg_info_nl() passes
genl_info_net(info) with no reference taken, while ncsi_pkg_info_all_nl(),
ncsi_set_interface_nl(), ncsi_clear_interface_nl(), ncsi_send_cmd_nl(),
ncsi_set_package_mask_nl() and ncsi_set_channel_mask_nl() all pass
get_net(sock_net(...)).  Since get_net() runs before the !ndp test, the
reference is pinned even on the new early -ENODEV return above, and
NCSI_CMD_PKG_INFO carries no GENL_ADMIN_PERM so the dump path is reachable
unprivileged.

Would dropping the get_net() at these sites (matching ncsi_pkg_info_nl) or
adding put_net() in the helper be the right fix, so the peer call sites
agree on who owns the reference?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921153633.565779-1-wongboonjhee52%40gmail.com
