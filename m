Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8C2472AE;
	Sun, 18 Oct 2026 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291022; cv=none; b=cLTcssqfdBA6+FhfmhzlT9Qun5cvK/xMlAxzrstgrXjPoe2y1u6OaRK7ZH6RY2NZZ8cA2dgQQmq65w6nv9YcWA4x/o0Ea8yXfObkwyJCzefh69xh8SPFMi1UODC9r+ebM9zCvoB8xAK735ipagkDwKNZdCa6kJtaVJER8PlsE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291022; c=relaxed/simple;
	bh=ZyXwKspPfB0s1xV0JoPQqDeAx7UFE/EWOeNYdQnwyF0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r5rA5ohFLvnWHIQDq0HywV3kbyVJdquFKY+euihLHoRhAFDHp6mDvaTUqz0c8l4ZCe5/5PyEWp5VMPshUyZrldnQViV8YxPbgl7v61Z3PE/IyYVxSE2h6FwhlQRJc0EOndFH4dT4aOEfBsUdTMrC6kI0EqyzU1plQWCzfon9QKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRk51wlm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRk51wlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8941F000C4;
	Sun, 18 Oct 2026 02:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792291021;
	bh=o3ZNKS+hfhnvlxakxtQbid3J/khsjxIGqm03KzIRndo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gRk51wlmgmeYILyYz3dNDjzI5LtbBTXrNWt3sQVviFOK7Oos1eW7rbHG5Obh+Re2v
	 iGH1Ljn0QrElrjQEHu2mHj85p7ZRODYHp0DaaBWDPlxflWeQ9g64+fE+FtyIzs58nr
	 hNM4VPmJsRJuNbm573hSctU+RDYsFcCGWPRDMd0s0tR9LWObIiNeuoXRhiedbxrHUr
	 F+VDMH4xCA3iEv5i47xWCWxM1oo5QZOrcAEDZP3JXtGBlNGbLPZqHrXy0zVW/5rT5J
	 CtSz+D8qnDF3Eam5Rb/NY1K8Wi6daLh9P8JertBaXmKuN/RiQgH7ECUvGGMXpkHEo5
	 96PhpiQDTcVvQ==
Subject: Re: [PATCH net v1] net/ncsi: fix use-after-free of ncsi_dev_priv in
 ncsi_unregister_dev()
From: netdev-bot+sashiko@kernel.org
To: 18983559317@163.com
Cc: sam@mendozajonas.com, fercerpav@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 gwshan@linux.vnet.ibm.com, joel@jms.id.au, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 18 Oct 2026 02:36:59 +0000
Message-ID: <179229101976.3135.13016645504142552637@kernel.org>
In-Reply-To: <20261017015315.415794-1-18983559317@163.com>
References: <20261017015315.415794-1-18983559317@163.com>
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

Critical: 0 · High: 4 (2) · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Switching to kfree_rcu(ndp, rcu) in ncsi_unregister_dev() does
  not fix the netlink reader use-after-free that the commit message…
- [High] Only the outermost ncsi_dev_priv gets an RCU-deferred free.
- [High] The ftgmac100 teardown use-after-free from the third KASAN trace
  (ncsi_stop_dev called from ftgmac100_stop during unregister_netdev) is…
- [High] net/ncsi: active request and monitor timers not quiesced in
  ncsi_unregister_dev()

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  ncsi_unregister_dev() never cancels the 256 request timers embedded in…
- [High] This problem wasn't introduced by this patch, but
  ncsi_vlan_rx_kill_vid() (net/ncsi/ncsi-manage.c) unlinks a vlan_vid…
- [Medium] This problem wasn't introduced by this patch, but
  ncsi_unregister_dev() never frees the struct vlan_vid entries on…

--

net/ncsi: fix use-after-free of ncsi_dev_priv in ncsi_unregister_dev()

This patch moves disable_work_sync(&ndp->work) in ncsi_unregister_dev()
so it runs before the packages and channels are torn down. It also
replaces the final kfree(ndp) with kfree_rcu(ndp, rcu). The goal is to
fix the use-after-free reports from the NCSI netlink readers and from
ftgmac100_stop() -> ncsi_stop_dev() during driver removal.

> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 54d0df0a9efe6..35e9dd85e0443 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -1960,6 +1960,11 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
>  
>  	dev_remove_pack(&ndp->ptype);
>  
> +	/* Quiesce the configuration worker before releasing the packages
> +	 * and channels it walks.
> +	 */
> +	disable_work_sync(&ndp->work);
> +
>  	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
>  		ncsi_remove_package(np);

[Severity: High]
Does disable_work_sync() quiesce everything that walks the packages
and channels here? The per-channel monitor timers still seem to be
running when the removal loop starts.

ftgmac100_remove() calls ncsi_unregister_dev() before
unregister_netdev(). So ncsi_stop_dev() has not run yet, and every
active channel still has nc->monitor.timer armed.
ncsi_remove_channel() only calls ncsi_stop_channel_monitor() on the
channel it is about to free. While the loop frees the first package,
the ncsi_channel_monitor() callback of a channel on a later package
can still fire.

That callback does one of two things:

- It sends a GLS with ncsi_xmit_cmd().
- In its timeout path, it calls ncsi_report_link(ndp, true), sets
  NCSI_DEV_RESHUFFLE, queues nc on ndp->channel_queue and calls
  ncsi_process_next_channel(ndp).

Either way it runs concurrently with ncsi_remove_package() and
touches package and channel state that is being torn down.

The GLS case also arms a timer. ncsi_xmit_cmd() sets nr->enabled and
calls mod_timer() with a one second timeout. That timer lives in one
of the ndp->requests[] entries, which are embedded in ndp.

dev_remove_pack() has already run, so ncsi_rcv_rsp() can never
complete that request and the timer is certain to fire. Commands
left in flight by ncsi_dev_work or by NCSI_CMD_SEND_CMD have the same
problem.

Nothing in ncsi_unregister_dev() deletes these timers.
kfree_rcu(ndp, rcu) frees ndp after one grace period, normally well
before the one second timeout. ncsi_request_timeout() then runs in
softirq context on freed memory. It reads nr->ndp, takes ndp->lock
and calls ncsi_free_request(). The timer_list is also still linked on
the timer wheel when its memory is freed, so the timer base can be
corrupted as well. Any outstanding nr->cmd and nr->rsp skbs leak.

Should every channel monitor be stopped before any package is freed?
The teardown would then call timer_delete_sync() on each
ndp->requests[i].timer and release outstanding requests before the
final kfree_rcu(). Or would you rather require callers to run
ncsi_stop_dev() first, and reorder ftgmac100_remove() to match?

[Severity: High]
Only ndp gets a deferred free here. Can the netlink readers still reach
packages and channels that have already been freed?

ncsi_remove_package() frees each package right after unlinking it:

net/ncsi/ncsi-manage.c:ncsi_remove_package() {
    ...
	spin_lock_irqsave(&ndp->lock, flags);
	list_del_rcu(&np->node);
	ndp->package_num--;
	spin_unlock_irqrestore(&ndp->lock, flags);

	kfree(np);
}

ncsi_remove_channel() does the same. It frees nc->mac_filter.addrs and
nc->vlan_filter.vids while nc is still on np->channels. It then calls
kfree(nc) right after list_del_rcu(&nc->node).

While this runs, ndp is still on ncsi_dev_list, so ndp_from_ifindex()
can still find it. ncsi_write_package_info() walks NCSI_FOR_EACH_PACKAGE
and NCSI_FOR_EACH_CHANNEL (both list_for_each_entry_rcu()), and
ncsi_write_channel_info() reads np->id, nc->package->preferred_channel,
nc->version.fw_name and ncf->vids[i] into the reply skb.

A reader that loaded np or nc just before the kfree() would then
dereference freed memory. NCSI_CMD_PKG_INFO has no GENL_ADMIN_PERM, so an
unprivileged user can race this against driver removal.

Even with the ndp lifetime fixed, don't the packages and channels also
need an RCU-deferred or refcounted free?

[ ... ]

> @@ -1967,8 +1972,6 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
>  	list_del_rcu(&ndp->node);
>  	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
>  
> -	disable_work_sync(&ndp->work);
> -
> -	kfree(ndp);
> +	kfree_rcu(ndp, rcu);

[Severity: High]
Does kfree_rcu() actually protect the netlink reader named in the commit
message? None of the NCSI genetlink handlers seem to be RCU readers.

ndp_from_ifindex() finds ndp through ncsi_find_dev(), which walks
ncsi_dev_list with list_for_each_entry_rcu() but without rcu_read_lock().
It then drops the netdev reference and returns a bare pointer:

net/ncsi/ncsi-netlink.c:ndp_from_ifindex() {
    ...
	nd = ncsi_find_dev(dev);
	ndp = nd ? TO_NCSI_DEV_PRIV(nd) : NULL;

	dev_put(dev);
	return ndp;
}

ncsi_pkg_info_nl() can sleep before it uses that pointer:

net/ncsi/ncsi-netlink.c:ncsi_pkg_info_nl() {
    ...
	ndp = ndp_from_ifindex(genl_info_net(info),
			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
	...
	skb = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
	...
	rc = ncsi_write_package_info(skb, ndp, package_id);
    ...
}

ncsi_write_package_info() then reads ndp->package_num. That is the
access in the first KASAN trace.

The genl doit and dumpit callbacks run in process context under
genl_mutex, not inside an RCU read-side critical section.
ncsi_unregister_dev() never takes genl_mutex. So the grace period can
end, and the kfree_rcu() callback can free ndp, while ncsi_pkg_info_nl()
still holds the pointer.

In ncsi_ops, NCSI_CMD_PKG_INFO (ncsi_pkg_info_nl() and
ncsi_pkg_info_all_nl()) has .flags = 0, so any local user can loop on it
during removal. If the memory has been reused, the reply would copy it to
user space. The admin-only SET_* and SEND_CMD handlers look up ndp the
same way and then write to it.

Does this need real lifetime handling instead? Some options are a
refcount taken under ncsi_dev_lock, readers that hold rcu_read_lock() and
don't sleep, or serializing unregister against genl.

[Severity: High]
Is the ftgmac100 teardown use-after-free from the third KASAN trace fixed
here, or only made less likely?

ftgmac100_remove() still unregisters the NCSI device before the netdev:

drivers/net/ethernet/faraday/ftgmac100.c:ftgmac100_remove() {
    ...
	if (priv->ndev)
		ncsi_unregister_dev(priv->ndev);
	unregister_netdev(netdev);
    ...
}

priv->ndev and priv->use_ncsi are never cleared. unregister_netdev()
takes rtnl_lock(), which can sleep, and under PREEMPT it can also be
preempted. It then reaches:

unregister_netdev()
  __dev_close_many()
    ftgmac100_stop()
      ncsi_stop_dev(priv->ndev)

ncsi_stop_dev() walks ndp->packages, reads ndp->ndev.dev, and calls
ncsi_report_link(ndp, true). That call writes nd->state and nd->link_up
and calls nd->handler. Nothing holds RCU or a reference across this
sequence, so the kfree_rcu() callback could free ndp first.

Would it be better to reorder ftgmac100_remove() so ncsi_unregister_dev()
runs after unregister_netdev()? Clearing priv->ndev and priv->use_ncsi
would also work. Either way, the fix would not depend on how long a grace
period takes.

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
ncsi_unregister_dev() never cancels the request timers in
ndp->requests[].

ncsi_register_dev() sets up all of them:

	timer_setup(&ndp->requests[i].timer, ncsi_request_timeout, 0);

and ncsi_xmit_cmd() arms one for each command:

	nr->enabled = true;
	mod_timer(&nr->timer, jiffies + 1 * HZ);

After dev_remove_pack() no response can arrive, so ncsi_rcv_rsp() ->
ncsi_free_request() can no longer delete an outstanding timer.

Requests can still be outstanding at this point:

- ncsi_channel_monitor() can send a GLS between dev_remove_pack() and
  ncsi_stop_channel_monitor() in ncsi_remove_channel(). With the new
  ordering the monitors keep running through disable_work_sync().
- ncsi_dev_work may have commands in flight.
- A netlink NCSI_CMD_SEND_CMD request may be in flight.

ndp is freed after one grace period, usually well before the 1 second
timeout, while the timer_list is still on the timer wheel. When the timer
fires, ncsi_request_timeout() dereferences nr and nr->ndp, takes
ndp->lock and calls ncsi_free_request(), all on freed memory. The pending
nr->cmd and nr->rsp skbs also leak.

Should ncsi_unregister_dev() call timer_delete_sync() on each
ndp->requests[i].timer and release outstanding requests before freeing
ndp?

[Severity: Medium]
This is also a pre-existing issue, but are the struct vlan_vid entries
on ndp->vlan_vids leaked here?

ncsi_vlan_rx_add_vid() allocates each entry with kzalloc_obj() and links
it onto ndp->vlan_vids with list_add_rcu(). The only free path is
ncsi_vlan_rx_kill_vid(), which first looks up ndp:

net/ncsi/ncsi-manage.c:ncsi_vlan_rx_kill_vid() {
    ...
	nd = ncsi_find_dev(dev);
	if (!nd) {
		netdev_warn(dev, "NCSI: no net_device?\n");
		return 0;
	}
    ...
}

ftgmac100_remove() calls ncsi_unregister_dev(), which removes ndp from
ncsi_dev_list, before it calls unregister_netdev(). When the 8021q
NETDEV_UNREGISTER handling later calls ncsi_vlan_rx_kill_vid(),
ncsi_find_dev() returns NULL, so every registered vlan_vid leaks when
ndp is freed.

[Severity: High]
This is another pre-existing issue, unrelated to the ordering changed
here. ncsi_vlan_rx_kill_vid() frees a vlan_vid as soon as it is
unlinked, with no grace period:

net/ncsi/ncsi-manage.c:ncsi_vlan_rx_kill_vid() {
    ...
			list_del_rcu(&vlan->list);
			found = true;
			kfree(vlan);
    ...
}

set_one_vid() reads the same list as an RCU reader from ncsi_dev_work:

	rcu_read_lock();
	list_for_each_entry_rcu(vlan, &ndp->vlan_vids, list) {
		vid = vlan->vid;

ncsi_vlan_rx_kill_vid() runs under rtnl from vlan_vid_del().
set_one_vid() runs from the workqueue under nc->lock and does not hold
rtnl.

With no shared lock, can set_one_vid() read vlan->vid or vlan->list.next
after the entry has been freed? Should this use kfree_rcu() instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017015315.415794-1-18983559317%40163.com
