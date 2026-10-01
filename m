Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6D308F39
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879611; cv=none; b=sWA+RodK8CQ5cs4+4NwwKO9srdF41VCu2Rycg6GHxB9ankjpvhH1kL2QiVC6tbgqylQfRyqMgiyHhIx/HO22VEADNVO6Yv2kZSktgqCEvwaswOBBw5Hj10kt0oBczBIDgXKQcs19SVj4pCd7qrpS2Vqk7UUvfgpGJgB60y1+qhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879611; c=relaxed/simple;
	bh=9gox+ywKwyEY6tfg+zuKC+UGJrrt57KGTf3kh0Fm0nI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZbPDjH19mlTvD9TXEU/ofQZ9NyQZ+RyeRft4inhIQpvUMQTYAWezNGCDxDHTabj6V1/lU01YJ5b25JzG100JfdPPD8NT11osq1yG+r+LneN7Tps4xADHzx5P28QXqP2z0/Ry8uG4X7gqem4j7eREu45QycsPZNen8m7b24ppThc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cN81mgQi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cN81mgQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A711F000FF;
	Thu,  1 Oct 2026 18:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790879609;
	bh=z6rE76TYdEYlOfBYUgMrOJjVvoDMRBPaxzhios+ZGsw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cN81mgQiJZfwSgwpi5jXkj9zgVjHlx6cVYb99BlGLif72UcyIInWlEPIWmaxkZdg1
	 nvbNFvYCaYZQI0KVIaTF+m6ftJSkoG1Z676bYlKLCdBq40SsVtovNMrPk+GSBX5whi
	 ffJTfUKiYMXdUZtlniAKgPjQOucR94LI6ZQUbwI7El6SZgE49trSJbvYsHnwmYWG1Y
	 X2L6IKgcALuPqAHYkfVJM6WIetimcYEORy9TsjIz1o0uS58IarCZqPAfmSmfNDDg5q
	 /BUZcJlfzhQtChZ3Gbmbgp9lZR6grkNN1uqdQ5PLiQIVogXgyu2SsXcjtPHKVVkO2B
	 bxgeDoMpSlF7g==
Subject: Re: [PATCH v7] net/ncsi: Fix Use-After-Free in NCSI teardown using
 synchronize_rcu
From: netdev-bot+sashiko@kernel.org
To: wongboonjhee52@gmail.com
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org
Date: Thu, 01 Oct 2026 18:33:28 +0000
Message-ID: <179087960866.434549.14313963252287475352@kernel.org>
In-Reply-To: <20260926133201.689877-1-wongboonjhee52@gmail.com>
References: <20260926133201.689877-1-wongboonjhee52@gmail.com>
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

Critical: 0 · High: 1 · Medium: 1 (4) · Low: 2 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] A deterministic use-after-free in NCSI teardown survives this
  patch.
- [Medium] In ncsi_unregister_dev(), the new comment says "Stop all
  request producers before draining request state." The code after it…
- [Low] The patch fixes a second, unrelated bug, a struct net refcount
  leak in the NCSI generic-netlink handlers, and the commit message body…
- [Low] The commit message mischaracterizes the defect and leaves out
  several behaviour changes.

Pre-existing issues:
- [Medium] ncsi_unregister_dev() does not free the struct vlan_vid
  entries on ndp->vlan_vids before kfree(ndp).
- [Medium] The concern says that making timer_delete_sync() unconditional
  in ncsi_stop_channel_monitor() introduces a double list_add of…
- [Medium] The package-info netlink operations assume package IDs are
  contiguous from 0.
- [Medium] set_one_vid() declares `u16 vid;` without initializing it and
  checks list_empty(&ndp->vlan_vids) without synchronization before…
- [Low] In ncsi_vlan_rx_add_vid()/ncsi_vlan_rx_kill_vid() the new
  rcu_read_lock() covers only the ncsi_find_dev() lookup and the…

--

net/ncsi: Fix Use-After-Free in NCSI teardown using synchronize_rcu

This patch reorders ncsi_unregister_dev() so the device is unlinked from
ncsi_dev_list and synchronize_rcu() runs before packages and channels are
freed. It also stops the channel monitor and request timers
synchronously. A global ncsi_dev_mutex now covers registration,
unregistration and the VLAN callbacks. The NCSI netlink handlers now take
rcu_read_lock() around their lookups, and VLAN entries are freed with
kfree_rcu().

> NCSI device teardown can free packages and channels while RCU readers,
> including Netlink handlers, are still using them. Unlink the device from
> the global list and wait for RCU readers before freeing its state.

[Severity: Low]
Is this an accurate description of the bug? Before this patch, none of
the NCSI netlink handlers took rcu_read_lock().

ndp_from_ifindex() called dev_get_by_index(), ncsi_find_dev() and
dev_put(), then returned a bare ndp pointer with no protection. The
handlers were never RCU readers outliving a grace period. They had no
reader-side protection at all, and this patch is what adds it.

The message also leaves out several behaviour changes:

- ncsi_register_dev() now takes a new global ncsi_dev_mutex. It still
  allocates with GFP_ATOMIC but can now sleep on the mutex. Its only
  in-tree caller, ftgmac100_probe(), can sleep, so this is not a
  functional problem.

- ncsi_stop_channel_monitor() no longer returns early when
  !monitor.enabled. That affects every caller, including
  ncsi_aen_handler_lsc() and ncsi_aen_handler_cr() in the RX softirq
  path, not only teardown.

- ncsi_unregister_dev() now deletes all 256 request timers
  synchronously.

- ncsi_vlan_rx_kill_vid() now stops after the first match.

- The netlink error paths are reworked. ncsi_pkg_info_nl() now
  allocates before the lookup, and ncsi_pkg_info_all_nl() now calls
  genlmsg_cancel() when the nest start fails.

Could the changelog describe these changes?

> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 54d0df0a9efe6..c3d3a448a07cb 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c

[ ... ]

> @@ -182,13 +184,10 @@ void ncsi_stop_channel_monitor(struct ncsi_channel *nc)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&nc->lock, flags);
> -	if (!nc->monitor.enabled) {
> -		spin_unlock_irqrestore(&nc->lock, flags);
> -		return;
> -	}
>  	nc->monitor.enabled = false;
>  	spin_unlock_irqrestore(&nc->lock, flags);
>  
> +	/* The callback may have cleared enabled and still be running. */
>  	timer_delete_sync(&nc->monitor.timer);
>  }

[Severity: Medium]
This is a pre-existing issue, but the AEN handlers still race with the
monitor timeout path: they check the channel state, then act on it
later. ncsi_aen_handler_lsc() follows the same pattern as this one:

net/ncsi/ncsi-aen.c:ncsi_aen_handler_cr() {
    ...
	if (!list_empty(&nc->link) ||
	    nc->state != NCSI_CHANNEL_ACTIVE) {
		spin_unlock_irqrestore(&nc->lock, flags);
		return 0;
	}
	spin_unlock_irqrestore(&nc->lock, flags);

	ncsi_stop_channel_monitor(nc);
    ...
	list_add_tail_rcu(&nc->link, &ndp->channel_queue);
    ...
}

If ncsi_channel_monitor() on another CPU takes its timeout branch at
the same time, it also queues nc->link on ndp->channel_queue. Neither
handler rechecks nc->link or nc->state after ncsi_stop_channel_monitor()
returns.

With timer_delete_sync() now unconditional, the handler waits for the
callback to finish. By then ncsi_process_next_channel() has usually
removed the entry with list_del_init(), so this patch narrows the
window rather than creating it.

Can nc->link still be added twice, and corrupt ndp->channel_queue,
when nc sits behind another entry in the queue?

[ ... ]

>  	/* Add the VLAN id to our internal list */
> +	rcu_read_lock();
>  	list_for_each_entry_rcu(vlan, &ndp->vlan_vids, list) {
>  		n_vids++;
>  		if (vlan->vid == vid) {
>  			netdev_dbg(dev, "NCSI: vid %u already registered\n",
>  				   vid);
> -			return 0;
> +			rcu_read_unlock();
> +			ret = 0;
> +			goto out_unlock;
>  		}
>  	}
> +	rcu_read_unlock();

[ ... ]

> @@ -1709,45 +1720,60 @@ int ncsi_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
>  
>  	found = ncsi_kick_channels(ndp) != 0;
>  
> -	return found ? ncsi_process_next_channel(ndp) : 0;
> +	ret = found ? ncsi_process_next_channel(ndp) : 0;

[Severity: Low]
This is a pre-existing issue, but ncsi_kick_channels() runs here after
rcu_read_unlock(). It walks ndp->packages and np->channels with
NCSI_FOR_EACH_PACKAGE() and NCSI_FOR_EACH_CHANNEL(). Both expand to
list_for_each_entry_rcu() with no lockdep condition.

Could this trigger the "RCU-list traversed in non-reader section"
warning with CONFIG_PROVE_RCU_LIST? The objects themselves look safe:
ncsi_dev_mutex is held for the whole callback, and ncsi_unregister_dev()
needs that mutex to unlink the device. So only the lockdep annotation
is wrong. ncsi_vlan_rx_kill_vid() has the same pattern.

> +out_unlock:
> +	mutex_unlock(&ncsi_dev_mutex);
> +	return ret;
>  }

[ ... ]

>  	/* Remove the VLAN id from our internal list */
> -	list_for_each_entry_safe(vlan, tmp, &ndp->vlan_vids, list)
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(vlan, &ndp->vlan_vids, list)
>  		if (vlan->vid == vid) {
>  			netdev_dbg(dev, "NCSI: vid %u found, removing\n", vid);
>  			list_del_rcu(&vlan->list);
>  			found = true;
> -			kfree(vlan);
> +			kfree_rcu(vlan, rcu);
> +			break;
>  		}
> +	rcu_read_unlock();

[Severity: Medium]
This isn't a bug introduced by this patch. kfree_rcu() fixes the entry
lifetime, but set_one_vid() still checks for an empty list with no
synchronization before walking it:

net/ncsi/ncsi-manage.c:set_one_vid() {
    ...
	u16 vid;

	if (list_empty(&ndp->vlan_vids))
		return -1;
    ...
	list_for_each_entry_rcu(vlan, &ndp->vlan_vids, list) {
		vid = vlan->vid;
    ...
	if (!vid) {
    ...
}

ncsi_vlan_rx_kill_vid() runs under RTNL and ncsi_dev_mutex, but nothing
serializes it against the NCSI work and configuration path.

If this removes the last entry between the list_empty() check and the
walk, the loop body never runs. Would vid then be read uninitialized,
so that a garbage VLAN ID is written into ncf->vids[] and sent in an
SVF command?

[ ... ]

> @@ -1956,19 +1990,35 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
>  {
>  	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
>  	struct ncsi_package *np, *tmp;
> +	struct ncsi_channel *nc;
>  	unsigned long flags;
> +	int i;
>  
> -	dev_remove_pack(&ndp->ptype);
> -
> -	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
> -		ncsi_remove_package(np);
> -
> +	mutex_lock(&ncsi_dev_mutex);
>  	spin_lock_irqsave(&ncsi_dev_lock, flags);
>  	list_del_rcu(&ndp->node);
>  	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
> +	mutex_unlock(&ncsi_dev_mutex);
>  
> +	dev_remove_pack(&ndp->ptype);
> +
> +	/* Wait for readers that found this device before it was unlinked. */
> +	synchronize_rcu();
>  	disable_work_sync(&ndp->work);
>  
> +	/* Stop all request producers before draining request state. */
> +	list_for_each_entry(np, &ndp->packages, node) {
> +		list_for_each_entry(nc, &np->channels, node)
> +			ncsi_stop_channel_monitor(nc);
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(ndp->requests); i++) {
> +		timer_delete_sync(&ndp->requests[i].timer);
> +	}

[Severity: Medium]
The comment above says request state is drained, but is anything
actually drained here? This loop only cancels the request timers.

A request can still be in flight: used, with nr->cmd set and no
response yet. The only path that releases it is ncsi_request_timeout()
calling ncsi_free_request():

net/ncsi/ncsi-manage.c:ncsi_free_request() {
    ...
	cmd = nr->cmd;
	rsp = nr->rsp;
    ...
	consume_skb(cmd);
	consume_skb(rsp);
}

ncsi_xmit_cmd() takes its own reference with skb_get(nr->cmd), and
only ncsi_free_request() drops it. After dev_remove_pack() no response
can arrive, and timer_delete_sync() stops the timeout from running.
kfree(ndp) then frees the requests[] table, which held the only pointer
to the skb.

Does this leak the command skb, and any stored response, for every
outstanding request? The channel monitor sends a GLS command every
second, so a request is often in flight at removal. A netlink-driven
request would also never send its timeout reply to user space.

Before this patch the pending timer fired after kfree(ndp), so the
change turns a use-after-free into a leak. Would it work to call
ncsi_free_request() for each requests[i] that is still used? The work
is already disabled here, and ncsi_free_request() already calls
timer_delete_sync() when nr->enabled is set.

The v6 -> v7 notes say request cleanup was dropped as unrelated, so
the comment may be left over from an earlier version.

> +
> +	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
> +		ncsi_remove_package(np);
> +
>  	kfree(ndp);

[Severity: High]
Is the teardown use-after-free still reachable through the only
in-tree user? ftgmac100_remove() frees ndp before it closes the netdev,
and it never clears priv->ndev:

drivers/net/ethernet/faraday/ftgmac100.c:ftgmac100_remove() {
    ...
	if (priv->ndev)
		ncsi_unregister_dev(priv->ndev);
	unregister_netdev(netdev);
    ...
}

If the interface is up, unregister_netdev() closes it and runs
ftgmac100_stop(), which does:

	if (priv->use_ncsi)
		ncsi_stop_dev(priv->ndev);

That gives this call chain on freed memory:

ftgmac100_remove()
  ncsi_unregister_dev()
    kfree(ndp)
  unregister_netdev()
    ftgmac100_stop()
      ncsi_stop_dev(priv->ndev)
        NCSI_FOR_EACH_PACKAGE(ndp, np) ...
        ncsi_report_link(ndp, true)
          nd->state = ncsi_dev_state_functional;
          nd->link_up = 0;
          nd->handler(nd);

ncsi_report_link() writes into the freed ncsi_dev_priv. It then makes
an indirect call through nd->handler, which is loaded from freed
memory.

The new sequence (ncsi_dev_mutex, list_del_rcu(), synchronize_rcu(),
disable_work_sync(), timer deletion) only fences users that find the
device through ncsi_find_dev() or ndp_from_ifindex().
ncsi_start_dev(), ncsi_stop_dev() and ncsi_reset_dev() use the nd
pointer directly.

The patch protects VLAN callbacks that arrive in this same window during
unregister_netdev(), but it does not protect ndo_stop. The call order in
ftgmac100_remove() is older than this patch. Should it still be fixed
here, given that this patch is meant to close NCSI teardown
use-after-frees?

[Severity: Medium]
This is a pre-existing issue, but does kfree(ndp) leak the struct
vlan_vid entries that are still on ndp->vlan_vids?

ftgmac100_remove() calls ncsi_unregister_dev() before
unregister_netdev(). As a result, the ndo_vlan_rx_kill_vid calls made
while unregister_netdev() tears down VLAN children cannot find the
device:

	nd = ncsi_find_dev(dev);
	rcu_read_unlock();
	if (!nd) {
		netdev_warn(dev, "NCSI: no net_device?\n");
		ret = 0;
		goto out_unlock;
	}

So none of the entries added through ncsi_vlan_rx_add_vid() are ever
freed. The v6 -> v7 notes say VLAN cleanup was left out of this patch
as unrelated.

>  }
>  EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
> diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
> index 8cc538358f6a3..202d4547d31d2 100644
> --- a/net/ncsi/ncsi-netlink.c
> +++ b/net/ncsi/ncsi-netlink.c

[ ... ]

> @@ -228,11 +236,14 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
>  	if (!attrs[NCSI_ATTR_IFINDEX])
>  		return -EINVAL;
>  
> -	ndp = ndp_from_ifindex(get_net(sock_net(skb->sk)),
> +	rcu_read_lock();
> +	ndp = ndp_from_ifindex(sock_net(skb->sk),
>  			       nla_get_u32(attrs[NCSI_ATTR_IFINDEX]));

[Severity: Low]
Dropping get_net() here also fixes a separate netns reference leak. The
same change is made in ncsi_set_interface_nl(),
ncsi_clear_interface_nl(), ncsi_send_cmd_nl(),
ncsi_set_package_mask_nl() and ncsi_set_channel_mask_nl().

ndp_from_ifindex() never calls put_net(), and there is no put_net()
anywhere in net/ncsi/. Each of these requests therefore leaked one
struct net reference.

The only hint of this fix is in the v6 -> v7 notes ("Use borrowed
socket network namespaces"), and git am drops those. Could it go in
its own patch, with a Fixes: tag for the commit that added the NCSI
netlink family? Otherwise, could the commit message at least describe
it? The current Fixes: tag (2d283bdd079c) points at a different root
cause.

>  
> -	if (!ndp)
> +	if (!ndp) {
> +		rcu_read_unlock();
>  		return -ENODEV;
> +	}
>  
>  	package_id = cb->args[0];
>  	package = NULL;
> @@ -240,20 +251,23 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
>  		if (np->id == package_id)
>  			package = np;
>  
> -	if (!package)
> +	if (!package) {
> +		rcu_read_unlock();
>  		return 0; /* done */
> +	}

[Severity: Medium]
This isn't a bug introduced by this patch, but this dump assumes package
IDs are contiguous from 0. cb->args[0] starts at 0, and the dump ends
as soon as no package has that exact ID.

ncsi_write_package_info() makes the same assumption:

	if (id > ndp->package_num - 1) {
		netdev_info(ndp->ndev.dev, "NCSI: No package with id %u\n", id);
		return -ENODEV;
	}

ncsi_add_package() keeps the package ID from the SP response and counts
package_num separately. Suppose the only package found has ID 1. Would
the dump then come back empty, and NCSI_CMD_PKG_INFO for package 1
return -ENODEV?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926133201.689877-1-wongboonjhee52%40gmail.com
