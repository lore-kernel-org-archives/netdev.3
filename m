Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E83546E4
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 06:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970772; cv=none; b=NEKR2v0lYyOtHbUL7rr0QwM2OwBf82Dty5tAMvFC4DKGK+VuV90V0VFiuGKIBV9jH+tRJMrqLucXVkukogudq0Dg6KPmSx6Mi1VsAiqjEPZWBxFu3i0HkbiWVieRppLyfNP2CxRSjhB8iFer6BGAtugwcPBsLRVIzQzDOTepHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970772; c=relaxed/simple;
	bh=K2BRi/jr5OsYGwRmRtFF3h6s31LvosjAYnv2pH1QQgk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t4PrUaN5ZX7lgBZ9o7z6OX0ZWZhzd6SS6xdyONz/5SQ3fEJoTXFy3QOPajRMyUCXwyAx4JnetfDCAWKXcQxban1xxqmOq6qyYF3KN60zcxcUjBS588FGBoH90tpGJOUshguC2vo2DbBsVgGT+peXGaQ6ee6U7itE+6gsovhN4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kse0SuVn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kse0SuVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6321F00893;
	Mon, 21 Sep 2026 06:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789970770;
	bh=0C2rtBQpmB3SNwVa0QgHznGf8faBcMF0zk9fd101V3E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kse0SuVnzNGT3BV7vjJ7WffJG64ZjURvO55z6iAoTr3r8dPMbigvFSijrjCPoRXs/
	 azLaTZQX2yEILEZokc8R2umvk9Cnl0Iu1oDcWL4h8NXSUf4TOQyfKj09v+pXJkgazI
	 Xc5B3xdxqhptAv2fuUf7g5Zu8odP4CIBHbYu1m02UVczey5T7ZXHxLNlW/GW23ceAs
	 sQBIzJj4Ch/jiahvxQW/tHUsVuqQUx3aMhGdBuUeRzki09mvovv333Z6DMpdyuz4v9
	 X/musM/x1AyS0fVet6Zqsx9SZRjxCsmuyiBO4Pe+qG4YEIJ12+94vNf9zmRQfYDx4/
	 oSx4k2O0diOKg==
Subject: Re: [PATCH v5] net/ncsi: Fix Use-After-Free in NCSI teardown using
 synchronize_rcu
From: netdev-bot+sashiko@kernel.org
To: wongboonjhee52@gmail.com
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org
Date: Mon, 21 Sep 2026 06:06:09 +0000
Message-ID: <178997076985.2160803.10781988481082001796@kernel.org>
In-Reply-To: <20260920052402.435974-1-wongboonjhee52@gmail.com>
References: <20260920052402.435974-1-wongboonjhee52@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 3 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix does not close the UAF it claims to close: the NCSI
  netlink readers are not RCU readers, so synchronize_rcu() in…
- [High] ncsi_unregister_dev() flushes the per-request timers
  (ndp->requests[i].timer, net/ncsi/ncsi-manage.c:1970-1973) BEFORE…
- [Medium] rcu_barrier() in ncsi_unregister_dev() (net/ncsi/ncsi-
  manage.c:1981) is a no-op for this bug and is misdescribed by the…
- [Medium] The patch makes several substantive teardown-ordering changes
  that the commit message does not describe and that the v5 changelog…
- [Medium] The new request-timer cancellation loop in
  ncsi_unregister_dev() (net/ncsi/ncsi-manage.c:1970-1973) performs only…

Pre-existing issues:
- [Medium] ncsi_unregister_dev() frees ndp without draining
  ndp->vlan_vids, leaking every struct vlan_vid still on the list.

--

net/ncsi: Fix Use-After-Free in NCSI teardown using synchronize_rcu

This reworks ncsi_unregister_dev() so the NCSI device is unlinked from
ncsi_dev_list first, then the packet handler and work item are stopped, the
request and channel-monitor timers are cancelled, and the package tree is
destroyed after synchronize_rcu()/rcu_barrier(). The intent is to let the
existing kfree() based teardown remain safe against concurrent RCU readers.

> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 54d0df0a9efe..3cda4b28480f 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -1956,19 +1956,33 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
>  {
>  	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
>  	struct ncsi_package *np, *tmp;
> +	struct ncsi_channel *nc;
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

[Severity: Medium]
The v5 notes say "Simplified the patch to focus strictly on flushing readers
during device unregistration", but this hunk also changes teardown ordering in
ways the commit message does not mention:

  - the ncsi_dev_lock/list_del_rcu(&ndp->node) block moves ahead of
    dev_remove_pack()
  - the package destruction loop moves from before dev_remove_pack() to after
    disable_work_sync()
  - two new timer cancellation loops are added

The package-loop move looks like the most useful part of the change, since it
closes the window where ndp->work or the Rx handler can run against already
freed packages, yet it is not described at all. Could the changelog spell out
these ordering changes, given the Fixes: tag makes this a stable backport
candidate?

>  
> +	for (i = 0; i < ARRAY_SIZE(ndp->requests); i++) {
> +		if (ndp->requests[i].enabled)
> +			timer_delete_sync(&ndp->requests[i].timer);
> +	}

[Severity: Medium]
This loop cancels the request timer but performs only half of what
ncsi_free_request() does. That function is the only place the command and
response buffers are released:

net/ncsi/ncsi-manage.c:ncsi_free_request() {
	if (nr->enabled) {
		nr->enabled = false;
		timer_delete_sync(&nr->timer);
	}
	...
	cmd = nr->cmd;
	rsp = nr->rsp;
	nr->cmd = NULL;
	nr->rsp = NULL;
	nr->used = false;
	...
	consume_skb(cmd);
	consume_skb(rsp);
}

and the request keeps its own reference on nr->cmd, since the transmit path
takes an extra one:

net/ncsi/ncsi-cmd.c:ncsi_xmit_cmd() {
	nr->enabled = true;
	mod_timer(&nr->timer, jiffies + 1 * HZ);

	/* Send NCSI packet */
	skb_get(nr->cmd);
	ret = dev_queue_xmit(nr->cmd);
}

Deleting the timer means the timeout callback never runs, and dev_remove_pack()
above has already removed the Rx handler that would otherwise complete the
request, so does kfree(ndp) below leak nr->cmd and nr->rsp for every slot that
still has used set? Would calling ncsi_free_request() for each used slot here
be preferable to only deleting the timer?

> +
> +	list_for_each_entry(np, &ndp->packages, node) {
> +		list_for_each_entry(nc, &np->channels, node)
> +			ncsi_stop_channel_monitor(nc);
> +	}

[Severity: High]
The channel monitors are stopped here, after the request timers were already
flushed above, but the monitor is itself a producer of requests. It transmits
directly from softirq context and re-arms itself:

net/ncsi/ncsi-manage.c:ncsi_channel_monitor() {
	case NCSI_CHANNEL_MONITOR_START:
	case NCSI_CHANNEL_MONITOR_RETRY:
		nca.ndp = ndp;
		...
		ret = ncsi_xmit_cmd(&nca);
	...
	mod_timer(&nc->monitor.timer, jiffies + HZ);
}

and ncsi_xmit_cmd() arms a timer that lives inside ndp:

net/ncsi/ncsi-cmd.c:ncsi_xmit_cmd() {
	nr->enabled = true;
	mod_timer(&nr->timer, jiffies + 1 * HZ);
}

Neither dev_remove_pack() nor disable_work_sync() stops the monitor timer, so a
monitor tick firing after the request loop has passed a slot (including one
already executing while timer_delete_sync() inside ncsi_stop_channel_monitor()
waits for it) can arm ndp->requests[i].timer roughly a second into the future.
Nothing rescans the request table after this loop, and synchronize_rcu() and
rcu_barrier() do not wait for timer_list callbacks.

Can kfree(ndp) then free memory that still holds a queued timer, leaving the
timer base with a pointer into freed slab and letting the callback write to it
from softirq?

net/ncsi/ncsi-manage.c:ncsi_request_timeout() {
	struct ncsi_request *nr = timer_container_of(nr, t, timer);
	struct ncsi_dev_priv *ndp = nr->ndp;
	...
	spin_lock_irqsave(&ndp->lock, flags);
	nr->enabled = false;
	...
	ncsi_free_request(nr);
}

The callback can also walk the already freed package tree through
ncsi_find_package_and_channel() in the NCSI_REQ_FLAG_NETLINK_DRIVEN case, and
touch ndp->pending_req_num plus schedule_work(&ndp->work) via
ncsi_free_request(). The netlink send-cmd path can arm a request timer the same
way, since teardown holds no lock shared with it.

Would stopping every request producer first (channel monitors and the netlink
send path), then unconditionally flushing the request timers and releasing the
requests, and only then freeing, be the safer order here?

> +
> +	synchronize_rcu();
> +	rcu_barrier();

[Severity: High]
Do these calls actually serialize against the readers the commit message names?
net/ncsi/internal.h declares the iterators as RCU list walks:

#define NCSI_FOR_EACH_PACKAGE(ndp, np) \
	list_for_each_entry_rcu(np, &ndp->packages, node)

but net/ncsi/ncsi-netlink.c contains no rcu_read_lock() at all; the only
rcu_read_lock() anywhere under net/ncsi is in ncsi_manage.c. The netlink lookup
returns an unreferenced ndp and drops the netdev reference before returning:

net/ncsi/ncsi-netlink.c:ndp_from_ifindex() {
	dev = dev_get_by_index(net, ifindex);
	...
	nd = ncsi_find_dev(dev);
	ndp = nd ? TO_NCSI_DEV_PRIV(nd) : NULL;

	dev_put(dev);
	return ndp;
}

ncsi_find_dev() itself walks ncsi_dev_list via NCSI_FOR_EACH_DEV() with no
read-side section. ncsi_pkg_info_nl() and ncsi_pkg_info_all_nl() then traverse
ndp->packages and np->channels and copy their contents into the reply, in
sleepable process context (genlmsg_new(..., GFP_KERNEL)), and for the dump
across separate invocations with state in cb->args[0].

A preemptible task that holds no rcu_read_lock() is permanently in a quiescent
state, so doesn't synchronize_rcu() here return without waiting for those
handlers, leaving ncsi_remove_package() -> ncsi_remove_channel() -> kfree(nc),
kfree(np) and kfree(ndp) free to run while the handler is still dereferencing
those pointers? NCSI_CMD_PKG_INFO has .flags = 0, so that reader needs no
privileges.

There is a second ordering question: the grace period runs before the removals,
while the removal helpers still free immediately after unlinking:

net/ncsi/ncsi-manage.c:ncsi_remove_package() {
	spin_lock_irqsave(&ndp->lock, flags);
	list_del_rcu(&np->node);
	ndp->package_num--;
	spin_unlock_irqrestore(&ndp->lock, flags);

	kfree(np);
}

Shouldn't the wait come after the list_del_rcu(), and don't the netlink readers
need rcu_read_lock() spanning lookup through last use (or a reference) before a
writer-side grace period can help at all?

[Severity: Medium]
The commit message presents "synchronize_rcu() and rcu_barrier()" together as
"waiting for all RCU readers to finish", but rcu_barrier() waits for previously
queued call_rcu() callbacks, not for read-side critical sections. Grepping
net/ncsi for call_rcu, kfree_rcu or kvfree_rcu returns no matches: ndp, np, nc,
the filters and the vlan_vid entries are all freed synchronously with kfree().

Is there any NCSI callback for rcu_barrier() to flush here? As written it blocks
the unregister path until every RCU callback queued system-wide has completed,
in addition to the synchronize_net() already performed by dev_remove_pack() and
the new synchronize_rcu(). Could it be dropped, or the dependency named?

> +
> +	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
> +		ncsi_remove_package(np);
> +
>  	kfree(ndp);
>  }
>  EXPORT_SYMBOL_GPL(ncsi_unregister_dev);

[Severity: Medium]
This isn't a bug introduced by this patch, but since the teardown path is being
reworked here: kfree(ndp) frees the ndp->vlan_vids list head without draining
the list. The entries are allocated in ncsi_vlan_rx_add_vid():

	vlan = kzalloc_obj(*vlan);
	if (!vlan)
		return -ENOMEM;
	...
	list_add_rcu(&vlan->list, &ndp->vlan_vids);

and the only kfree() for them is in ncsi_vlan_rx_kill_vid(). Does unregistering
with VIDs still registered leak up to NCSI_MAX_VLAN_VIDS of these objects, and
would draining ndp->vlan_vids here be worth folding in?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260920052402.435974-1-wongboonjhee52%40gmail.com
