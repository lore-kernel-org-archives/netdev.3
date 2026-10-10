Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338A836D9EB;
	Sat, 10 Oct 2026 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791641188; cv=none; b=ebz6hHaITgQRtsWRrfEr15ga/bcG0JnZIcn5xCGpY06E4GcS2VuTvNhQMGW9YG1rJsu97hKJFySsDq3MqI2L+u3S2Ihknaw/34uDxBB9yR3vQEyrCs2/zCI3J/oOIT6Ak0XkOEjCo5aAhpgpo+X39nItRJKp4i57T4QpWNkBm9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791641188; c=relaxed/simple;
	bh=ZYwiTmKE4MLfG8J+b/NJpyWxbzNsQfCLr6vyitiyL88=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CDf0ljIQZE/rh5Lky6TfkmUXwOWbft1cwlSVDhuoinkVPmfnwnSlpaqCF6qo3Qc2mErXlu4YqJdBctdlPSwPlwY2K77UoU+Wq6vnfz40IZjQb3/mxVVZ9PxNamc2B0fXsUQTxr5qqF1jqDci2vfRW4LY89318xO8b7pTGZ4SMU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By26bg6g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="By26bg6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E74E1F000FF;
	Sat, 10 Oct 2026 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791641186;
	bh=m/Wiyr2QQSo5MX8nUbvxxVLvSVSOOWu6WYbNTaig6YM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=By26bg6g5k2lL/nPDQTJ1BKR166L7ejk5ljC+av84QKY0S44e3auTr7xGMZF28Tmx
	 OapLSWr/TPG93JFKGVoDe+5Pt3LbMD7sCcHpjU6IBbhEqlNUvvaZfz9XGmzXJGqJaK
	 UPvtEhZ8w8hd+3mKoJP+bEEmxhJv1iPTQAhdxm2MzZl+DtwPoEenwuZ8Ourjfa1a2v
	 i+JhsSCGHswngJ3MX/m3tnHBxS5+geSTIeBG8KY3bPN9/oAxcPTQieNgf+BVRUlgyC
	 +Vxzwb/QwhmBRqTPilI+zmHusqKOinCv74RGv3cr8jMYJYkqIN22vzkKTBaPhWVXhc
	 eCVwPIua/b0HQ==
Subject:
 Re: [PATCH net v1] ncsi: Fix use-after-free in the device unregister path
From: netdev-bot+sashiko@kernel.org
To: 18983559317@163.com
Cc: sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 14:06:25 +0000
Message-ID: <179164118587.434549.3866860374276214421@kernel.org>
In-Reply-To: <20261009132021.39611-1-18983559317@163.com>
References: <20261009132021.39611-1-18983559317@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 4 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix leaves the netlink-query race it claims to close fully
  reachable.
- [High] ncsi_unregister_dev() frees ndp, which embeds requests[256] and
  their timer_list objects, without cancelling the outstanding request…
- [High] Moving disable_work_sync(&ndp->work) earlier does not stop the
  NCSI state machine, so the fix's premise ('stop the state machine work…
- [High] net/ncsi: active request timers cause UAF on device unregister
- [Medium] ncsi_remove_channel() only does list_del_rcu(&nc->node).
- [Medium] ncsi_remove_channel() now defers freeing nc with kfree_rcu(),
  but frees its sub-allocations immediately: kfree(nc->mac_filter.addrs)…

Pre-existing issues:
- [High] ftgmac100_remove() calls ncsi_unregister_dev(priv->ndev), which
  ends with kfree(ndp), and then calls unregister_netdev(netdev).

--

ncsi: Fix use-after-free in the device unregister path

This commit moves disable_work_sync() in ncsi_unregister_dev() so it runs
before the packages and channels are torn down. It also switches
ncsi_remove_package() and ncsi_remove_channel() from kfree() to
kfree_rcu(), with an rcu_head added to both structures.

> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 54d0df0a9efe6..05dcd732effa2 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -263,7 +263,7 @@ static void ncsi_remove_channel(struct ncsi_channel *nc)
>  	np->channel_num--;
>  	spin_unlock_irqrestore(&np->lock, flags);
>  
> -	kfree(nc);
> +	kfree_rcu(nc, rcu_head);

[Severity: Medium]
nc is now freed after a grace period, but earlier in ncsi_remove_channel()
its filter arrays are still freed right away, before the list_del_rcu():

	/* Release filters */
	kfree(nc->mac_filter.addrs);
	kfree(nc->vlan_filter.vids);

vlan_filter.n_vids and the bitmap are not changed. Can a reader that
already holds nc still index the freed vids[] array?

ncsi_write_channel_info() in ncsi-netlink.c reads it without nc->lock and
copies the values into the netlink reply:

	while ((i = find_next_bit((void *)&ncf->bitmap, ncf->n_vids,
				  i + 1)) < ncf->n_vids) {
		if (ncf->vids[i])
			nla_put_u16(skb, NCSI_CHANNEL_ATTR_VLAN_ID,
				    ncf->vids[i]);
	}

set_one_vid() can also do ncf->vids[index] = vid under nc->lock if it gets
the lock after ncsi_remove_channel() has dropped it.

Should the filter arrays be freed together with nc after the grace period?

[Severity: Medium]
ncsi_remove_channel() only unlinks nc->node. Is nc->link ever removed from
ndp->channel_queue? Also, are ndp->active_channel, ndp->hot_channel and
np->preferred_channel cleared before the channel is freed?

Suppose disable_work_sync() interrupts a multi-channel configuration. The
channels still queued stay on channel_queue after they are freed.

The monitor of a channel that has not been removed yet is still armed.
GLS responses are dropped after dev_remove_pack(), so that monitor can
reach its timeout branch in ncsi_channel_monitor():

	spin_lock_irqsave(&ndp->lock, flags);
	nc->state = NCSI_CHANNEL_ACTIVE;
	list_add_tail_rcu(&nc->link, &ndp->channel_queue);
	spin_unlock_irqrestore(&ndp->lock, flags);
	ncsi_process_next_channel(ndp);

The list_add_tail_rcu() writes into the link of the stale tail entry.
ncsi_process_next_channel() then pops the first entry with
list_first_or_null_rcu() and list_del_init(), makes it
ndp->active_channel, and calls ncsi_configure_channel() on it.

The kfree_rcu() grace period does not cover a timer callback that starts
after kfree_rcu() was called. Can this write to a freed ncsi_channel from
softirq context?

>  }

[ ... ]

> @@ -1958,6 +1958,8 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
>  	struct ncsi_package *np, *tmp;
>  	unsigned long flags;
>  
> +	disable_work_sync(&ndp->work);
> +

[Severity: High]
disable_work_sync() waits for the current run of ndp->work. It does
nothing about NCSI requests that are already outstanding.
ncsi_xmit_cmd() arms nr->timer, which is embedded in ndp->requests[],
and returns before the response arrives.

After dev_remove_pack() and synchronize_net(), no response can complete
those requests. Each pending one can then only finish through its
timeout. Nothing in ncsi_unregister_dev() walks ndp->requests[] and
cancels those timers before kfree(ndp).

So the timer wheel still holds nr->timer inside the freed ndp. About a
second later ncsi_request_timeout() runs on freed memory:

ncsi_request_timeout()
  ndp = nr->ndp
  spin_lock_irqsave(&ndp->lock, flags)     /* freed ndp */
  ncsi_find_package_and_channel()          /* netlink-driven */
  ncsi_free_request(nr)
    --ndp->pending_req_num
    consume_skb(cmd)

Even before the callback runs, a pending timer_list in freed memory
can corrupt the timer wheel once the allocation is reused.

The window is easy to hit. Probe commands to absent packages only ever
finish by timeout. Channel configuration, the channel monitor's GLS
commands and NCSI_CMD_SEND_CMD requests from netlink can all be
pending when the device is removed.

Should ncsi_unregister_dev() shut down every ndp->requests[i].timer
before freeing ndp, for example with timer_shutdown_sync()? Should it
also release any cmd/rsp skbs still attached to those requests, which
would otherwise leak?

[Severity: High]
Does disabling ndp->work actually stop the state machine?
ncsi_process_next_channel() calls ncsi_configure_channel(),
ncsi_suspend_channel() or ncsi_choose_active_channel() directly, and it is
called from places other than ndp->work.

One caller is the VLAN ndo path. ftgmac100 sets
NETIF_F_HW_VLAN_CTAG_FILTER in NCSI mode. ftgmac100_remove() calls
ncsi_unregister_dev() without rtnl, while the netdev is still registered.
So a concurrent VLAN add can do this:

ncsi_vlan_rx_add_vid()
  ncsi_find_dev()
  ncsi_kick_channels()          /* NCSI_FOR_EACH_PACKAGE/CHANNEL */
  ncsi_process_next_channel()
    ncsi_configure_channel()
      ncsi_xmit_cmd()

This runs in process context without rcu_read_lock(), so neither
kfree_rcu() nor the final kfree(ndp) is ordered against it.
ncsi_vlan_rx_kill_vid() follows the same pattern.

The other caller is the channel monitor timer. In its timeout branch,
ncsi_channel_monitor() clears nc->monitor.enabled itself and then keeps
using ndp.

If ncsi_remove_channel() reaches ncsi_stop_channel_monitor() on another
CPU after that point, it returns early:

	spin_lock_irqsave(&nc->lock, flags);
	if (!nc->monitor.enabled) {
		spin_unlock_irqrestore(&nc->lock, flags);
		return;
	}

timer_delete_sync() is never called. Nothing waits for the running
callback while ncsi_unregister_dev() goes on to kfree(ndp).

The commit message says this change will "stop the state machine work
before freeing the packages and channels". Do these entry points need to
be shut out before the lists are torn down for that to hold?

>  	dev_remove_pack(&ndp->ptype);

[Severity: High]
What happens to commands that are already in flight at this point?
ncsi_xmit_cmd() arms a timer embedded in ndp->requests[] and returns:

	nr->enabled = true;
	mod_timer(&nr->timer, jiffies + 1 * HZ);

disable_work_sync() only waits for the current run of the work.
dev_remove_pack() and synchronize_net() then make sure no response will
ever complete those requests.

Several kinds of request can still be pending: probe commands to absent
packages (these only finish by timeout), config commands, GLS commands
from channel monitors, and NCSI_CMD_SEND_CMD requests.

Nothing cancels ndp->requests[i].timer before kfree(ndp). About a second
later, ncsi_request_timeout() can run on the freed ndp:

ncsi_request_timeout()
  spin_lock_irqsave(&ndp->lock, flags)
  ncsi_find_package_and_channel()   /* netlink-driven requests */
  ncsi_free_request()
    timer_delete_sync(&nr->timer)
    --ndp->pending_req_num
    schedule_work(&ndp->work)

Does this leave pending timer_list objects in the timer wheel after their
memory has been freed?

Should each request timer be shut down (for example with
timer_shutdown_sync()) and the cmd/rsp skbs released before kfree(ndp)?

>  
>  	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
> @@ -1967,8 +1969,6 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
>  	list_del_rcu(&ndp->node);
>  	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
>  
> -	disable_work_sync(&ndp->work);
> -
>  	kfree(ndp);

[Severity: High]
The commit message lists "a netlink query" as a trigger. It says
kfree_rcu() protects "readers covered by an RCU read-side critical
section". Do any of the NCSI netlink readers run inside one?

ndp_from_ifindex() in ncsi-netlink.c takes no RCU lock and no reference on
ndp:

	nd = ncsi_find_dev(dev);
	ndp = nd ? TO_NCSI_DEV_PRIV(nd) : NULL;

	dev_put(dev);
	return ndp;

ncsi_pkg_info_nl() keeps that raw pointer across
genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL), which can sleep. Then
ncsi_write_package_info() walks ndp->packages and np->channels with
NCSI_FOR_EACH_PACKAGE/NCSI_FOR_EACH_CHANNEL. ncsi_pkg_info_all_nl() walks
the packages the same way. ncsi_unregister_dev() takes neither genl_mutex
nor rtnl.

ndp itself holds the packages list head. Here it is still freed with a
plain kfree() right after list_del_rcu(&ndp->node), with no grace period.

ftgmac100_remove() calls ncsi_unregister_dev() while the netdev is still
registered, so dev_get_by_index() still succeeds for a concurrent query.
NCSI_CMD_PKG_INFO has .flags = 0, so an unprivileged user can send it.

Can this sequence copy freed or reallocated package and channel memory
into the netlink reply?

ncsi_pkg_info_nl()
  ndp_from_ifindex()            /* no ref, no RCU */
  genlmsg_new(GFP_KERNEL)       /* may sleep */
                                   ncsi_unregister_dev()
                                     ncsi_remove_package()
                                     kfree(ndp)
  ncsi_write_package_info()     /* walks freed ndp->packages */

The admin-only ncsi_set_interface_nl() and ncsi_set_channel_mask_nl()
handlers, and the VLAN ndo paths, look like they have the same issue.

Does ndp need real lifetime protection here? For example, RCU around the
readers plus a grace period or a refcount before kfree(ndp), rather than
kfree_rcu() on the child objects only.

[Severity: High]
This isn't a bug introduced by this patch, but the commit message points
at the ordering in ftgmac100_remove(), and that ordering looks like it
also causes a deterministic use-after-free:

	if (priv->ndev)
		ncsi_unregister_dev(priv->ndev);
	unregister_netdev(netdev);

If the interface is up, unregister_netdev() closes it through
ftgmac100_stop(). priv->use_ncsi is still true and priv->ndev is never
cleared, so:

ftgmac100_remove()
  ncsi_unregister_dev()
    kfree(ndp)
  unregister_netdev()
    ftgmac100_stop()
      ncsi_stop_dev(priv->ndev)     /* freed ndp */
        NCSI_FOR_EACH_PACKAGE(ndp, np) ...
        ncsi_report_link(ndp, true)
          nd->handler(nd)

This walks the freed ndp->packages and takes nc->lock on channels that may
already be freed. It also writes nd->state and nd->link_up, and makes an
indirect call through nd->handler, which is loaded from freed memory.

Would calling unregister_netdev() before ncsi_unregister_dev() in
ftgmac100_remove() close this path? It would also close the netlink and
VLAN windows that depend on the netdev still being registered.

>  }
>  EXPORT_SYMBOL_GPL(ncsi_unregister_dev);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009132021.39611-1-18983559317%40163.com
