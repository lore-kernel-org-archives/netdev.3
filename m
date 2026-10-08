Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0993BB9E3
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439281; cv=none; b=A8A/QvoIJCar6tAdJQ8Mm72cx+ejsKEhZw2qipPZKJcJ9MEDHqykfSakl5X1tJO31QJi1It2Y7VyfdiFUYzc5xPeaCOvCmwE6Sj/8mjCPZXyEwuUV0M1skfI0UzyxbDAD8INjJuYStjeMiJ09FYBgLgKrEeOzLAAt+yPtUNRxB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439281; c=relaxed/simple;
	bh=cGqsW0suTHECZfgxqiPI9yHP1zI5xXzt8Mzbt+ZXwhY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H7qPZTEIpw07iSyJGxhQVeIl2B1B8jCOlp5ziMJ+g1diwj3zk4J+1e2EYLaq5ZXHdImlwPKDsJJmyPywriew+XEDI4K1hYTOsvZD5T9qo0eYazyoiPaKTBe0lz4BBb6sOAXjDOl0Ed58DXcix16mv5+3FBXIF3ibrgtYdZfaonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADnt9+Xn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADnt9+Xn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009A81F00893;
	Thu,  8 Oct 2026 06:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439278;
	bh=NUpENx7r1ida6Sk6Qo2M2dJHJMpiDsNqMg28Lr5iinQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ADnt9+Xnd2rfdiTur/CnedTk1QxYdopORFGlmf06Fu6uMVUQCQSUnJrnNMveWIPnd
	 k0P5bbbfEc5IrBBX2vGKCfUU3IRNEBpZQHBYPblKIpJSCMzSHp+u+w5wDVwjtlWcaY
	 s05exqVxY57YSwW7SXT1OLriLp+DElKWjBqo0NdBTczbyZzcafNADgnn1mjcHG4toZ
	 89A4U55Q/NUqZgqAEFrGqxSSb50xacbCeu3QLJ+oKGHDNRDZxwYx1ygRErgFGJMoBz
	 NDQZaRtae5Lr5bvqVlgFxJc6z2dBrqFHL9XXnaKa+a2J4018ZVGwy2nEJNjmR3uCmD
	 eEYuTnXcNFICg==
Subject: Re: [PATCH v8] net/ncsi: Fix Use-After-Free in NCSI teardown using
 synchronize_rcu
From: netdev-bot+sashiko@kernel.org
To: wongboonjhee52@gmail.com
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org
Date: Thu, 08 Oct 2026 06:01:17 +0000
Message-ID: <179143927752.434549.6629076454294032976@kernel.org>
In-Reply-To: <20261005115944.1397670-1-wongboonjhee52@gmail.com>
References: <20261005115944.1397670-1-wongboonjhee52@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 3 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In ftgmac100_remove(), the patch moves unregister_netdev() ahead
  of ncsi_unregister_dev().
- [High] In ncsi_aen_handler_lsc() (net/ncsi/ncsi-aen.c), the single-
  channel/single-package link-down path now sets `nc->state =…
- [High] The patch introduces an ABBA lock order inversion between
  ndp->lock and nc->lock.
- [Medium] After ncsi_stop_channel_monitor(), ncsi_aen_handler_lsc() and
  ncsi_aen_handler_cr() recheck only `nc->state == NCSI_CHANNEL_ACTIVE`…
- [Medium] Because of the reorder in ftgmac100_remove(), the NCSI device
  is still on ncsi_dev_list while unregister_netdev() runs.
- [Medium] The commit message describes only RCU-safe teardown,
  protection of Netlink/VLAN lookups, and synchronous monitor-timer stop.
- [Low] The new request-cleanup loop in ncsi_unregister_dev() calls
  ncsi_find_package_and_channel() for each outstanding NETLINK_DRIVEN…

Pre-existing issues:
- [Low] ncsi_send_netlink_timeout() falls back to reading the package ID
  from `((struct ncsi_pkt_hdr *)nr->cmd->data)->channel` when np is NULL.

--

net/ncsi: Fix Use-After-Free in NCSI teardown using synchronize_rcu

The patch unlinks the NCSI device from the global list and waits with
synchronize_rcu() before freeing packages and channels. It wraps the
Netlink lookups and VLAN callbacks in RCU/mutex protection and stops
channel monitors and request timers synchronously. It also reorders
ftgmac100_remove() so that unregister_netdev() runs before
ncsi_unregister_dev().

> NCSI device teardown can free packages and channels while RCU readers,
> including Netlink handlers, are still using them. Unlink the device from
> the global list and wait for RCU readers before freeing its state.
>
> Protect Netlink lookups and VLAN callbacks against concurrent teardown.
> Synchronously stop channel-monitor timers before freeing their channels,
> including when a timer callback has already cleared the enabled flag.
> Remove VLAN entries with RCU-safe list deletion and deferred freeing.

[Severity: Medium]
The commit message only covers the RCU teardown. The patch also seems to
include several independent changes, and these are described only in the
v7 -> v8 notes below the cut line, which are dropped when the patch is
applied:

- Six Netlink handlers no longer call get_net(sock_net(...)). There was
  no matching put_net() in net/ncsi/, so this fixes a struct net
  reference leak on every command.
- list_empty() guards against duplicate list_add_tail_rcu() on
  ndp->channel_queue in ncsi_channel_monitor(), the AEN handlers and
  ncsi_kick_channels().
- AEN state handling changes in ncsi_aen_handler_lsc() and
  ncsi_aen_handler_cr().
- vid is now initialised in set_one_vid().
- User-visible Netlink changes: the id > package_num - 1 check is removed
  from ncsi_write_package_info(), the PKG_INFO dump cursor now continues
  past package ID gaps, and genlmsg_cancel() is no longer called with a
  NULL hdr.
- Outstanding ncsi_request skbs and the vlan_vids entries are now freed
  at unregister.
- A new global ncsi_dev_mutex.

The message also says "RCU readers, including Netlink handlers". Before
this patch the Netlink handlers did not take rcu_read_lock().

Could these be split out, or at least described in the commit message,
with their own Fixes: tags where appropriate?

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 6d2fe5c2f3903..193f5147ef7a6 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c

[ ... ]

> @@ -2107,9 +2109,11 @@ static void ftgmac100_remove(struct platform_device *pdev)
>  	netdev = platform_get_drvdata(pdev);
>  	priv = netdev_priv(netdev);
>
> -	if (priv->ndev)
> -		ncsi_unregister_dev(priv->ndev);
>  	unregister_netdev(netdev);
> +	if (priv->ndev) {
> +		ncsi_unregister_dev(priv->ndev);
> +		priv->ndev = NULL;
> +	}

[Severity: High]
Can this reorder trigger the BUG_ON in netdev_run_todo()?

ncsi_register_dev() binds the NCSI packet handler to this netdev:

    ndp->ptype.dev = dev;
    dev_add_pack(&ndp->ptype);

Because pt->dev is set, ptype_head() puts the handler on
dev->ptype_specific. The only removal is the dev_remove_pack() in
ncsi_unregister_dev(), and that now runs after unregister_netdev() has
returned.

unregister_netdev() -> rtnl_net_dev_unlock() -> rtnl_unlock() ->
netdev_run_todo() then checks:

    BUG_ON(!list_empty(&dev->ptype_specific));

dev_add_pack() takes no netdev reference, so netdev_wait_allrefs_any()
completes. The BUG_ON would then fire every time an NCSI-enabled
ftgmac100 is removed, whether by unbind or rmmod.

[Severity: Medium]
The NCSI device is now still on ncsi_dev_list while unregister_netdev()
runs. Does ncsi_vlan_rx_kill_vid() then restart the channel state machine
during teardown?

unregister_netdevice() first calls dev_close() -> ftgmac100_stop() ->
ncsi_stop_dev(). That function deliberately leaves the channel states
ACTIVE:

    /* Stop the channel monitor on any active channels. Don't reset the
     * channel state so we know which were active when ncsi_start_dev()
     * is next called.
     */

NETDEV_UNREGISTER handling in 8021q then removes the VLAN uppers and calls
vlan_kill_rx_filter_info() -> ncsi_vlan_rx_kill_vid(). That path checks
netif_device_present() but not whether the interface is up.
ncsi_find_dev() still succeeds, so ncsi_kick_channels() queues every
ACTIVE channel. ncsi_process_next_channel() -> ncsi_configure_channel()
then sends NC-SI commands, arms request timers and schedules ndp->work on
a closed netdev that is being unregistered.

Before this patch, ncsi_unregister_dev() ran first, so this callback
found no NCSI device and returned early.

[ ... ]

> diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
> index 040a31557201b..c4025e7f2cf26 100644
> --- a/net/ncsi/ncsi-aen.c
> +++ b/net/ncsi/ncsi-aen.c
> @@ -93,8 +93,16 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
>  		if (had_link) {
>  			ndp->flags |= NCSI_DEV_RESHUFFLE;
>  			ncsi_stop_channel_monitor(nc);
> +			spin_lock_irqsave(&nc->lock, flags);
> +			if (nc->state != NCSI_CHANNEL_ACTIVE) {
> +				spin_unlock_irqrestore(&nc->lock, flags);
> +				return 0;
> +			}
> +			nc->state = NCSI_CHANNEL_INACTIVE;
> +			spin_unlock_irqrestore(&nc->lock, flags);
>  			spin_lock_irqsave(&ndp->lock, flags);
> -			list_add_tail_rcu(&nc->link, &ndp->channel_queue);
> +			if (list_empty(&nc->link))
> +				list_add_tail_rcu(&nc->link, &ndp->channel_queue);
>  			spin_unlock_irqrestore(&ndp->lock, flags);
>  			return ncsi_process_next_channel(ndp);
>  		}

[Severity: High]
Is setting NCSI_CHANNEL_INACTIVE here intended? Before this patch the
channel was queued with its state still ACTIVE, so
ncsi_process_next_channel() took the suspend path:

    case NCSI_CHANNEL_INACTIVE:
        ...
        ncsi_configure_channel(ndp);
        break;
    case NCSI_CHANNEL_ACTIVE:
        ...
        ncsi_suspend_channel(ndp);

With INACTIVE, the channel that has just lost link is reconfigured
instead of suspended. The skipped steps are SP, the GLS refresh on all
channels triggered by NCSI_DEV_RESHUFFLE, and DCNT/DC/DP. The failed
channel therefore stays enabled on the NIC, and its
modes[NCSI_MODE_TX_ENABLE].enable flag stays set.

When ncsi_choose_active_channel() then picks a replacement,
ncsi_channel_is_tx() sees the stale TX enable flag and returns false, so
the replacement never gets ECNT. If the replacement is in another
package and there is no HWA, the old package is never deselected either.

Does this break failover after a link loss in the default
!multi_package && !multi_channel configuration? It looks like the CR/kick
pattern may have been copied into the LSC path, and this change seems
unrelated to the teardown use-after-free.

> @@ -158,12 +166,15 @@ static int ncsi_aen_handler_cr(struct ncsi_dev_priv *ndp,
>
>  	ncsi_stop_channel_monitor(nc);
>  	spin_lock_irqsave(&nc->lock, flags);
> -	nc->state = NCSI_CHANNEL_INVISIBLE;
> +	if (nc->state != NCSI_CHANNEL_ACTIVE) {
> +		spin_unlock_irqrestore(&nc->lock, flags);
> +		return 0;
> +	}
> +	nc->state = NCSI_CHANNEL_INACTIVE;
>  	spin_unlock_irqrestore(&nc->lock, flags);
> -
>  	spin_lock_irqsave(&ndp->lock, flags);
> -	nc->state = NCSI_CHANNEL_INACTIVE;
> -	list_add_tail_rcu(&nc->link, &ndp->channel_queue);
> +	if (list_empty(&nc->link))
> +		list_add_tail_rcu(&nc->link, &ndp->channel_queue);
>  	spin_unlock_irqrestore(&ndp->lock, flags);

[Severity: Medium]
After ncsi_stop_channel_monitor(), both ncsi_aen_handler_cr() and
ncsi_aen_handler_lsc() recheck only nc->state, set INACTIVE and drop
nc->lock. Only after that do they take ndp->lock and test list_empty().

ncsi_kick_channels() does the check and the transition in a single
critical section:

    if (nc->state == NCSI_CHANNEL_ACTIVE &&
        list_empty(&nc->link)) {
        nc->state = NCSI_CHANNEL_INACTIVE;
        list_add_tail_rcu(&nc->link, &ndp->channel_queue);

The split sequence in the AEN handlers appears to allow two races.

First, timer_delete_sync() can wait for a monitor callback whose timeout
branch has already queued nc as ACTIVE. ncsi_channel_monitor() writes
nc->state under ndp->lock only. If another channel is ahead in the
queue, nc stays queued, and the AEN handler then overwrites its state
with INACTIVE. nc is later configured instead of suspended.

Second, a concurrent ncsi_reset_dev() -> ncsi_choose_active_channel()
(for example from a Netlink set_interface command) can run between the
nc->lock release and the ndp->lock acquisition. It can queue nc, and
ncsi_process_next_channel() can dequeue it and mark it INVISIBLE. The
AEN handler's list_empty() check then passes and it re-queues a channel
that is already being configured. The next dequeue hits the "Invalid
state" path, which calls ncsi_report_link(ndp, false).

Should these handlers check queue membership and change the state in the
same critical section as the enqueue?

> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 54d0df0a9efe6..266b1c4209ba4 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c

[ ... ]

> @@ -1567,13 +1567,12 @@ int ncsi_process_next_channel(struct ncsi_dev_priv *ndp)
>  		goto out;
>  	}
>
> +	spin_lock(&nc->lock);
>  	list_del_init(&nc->link);
> -	spin_unlock_irqrestore(&ndp->lock, flags);
> -
> -	spin_lock_irqsave(&nc->lock, flags);
>  	old_state = nc->state;
>  	nc->state = NCSI_CHANNEL_INVISIBLE;
> -	spin_unlock_irqrestore(&nc->lock, flags);
> +	spin_unlock(&nc->lock);
> +	spin_unlock_irqrestore(&ndp->lock, flags);

[Severity: High]
Does this create an ABBA ordering between ndp->lock and nc->lock?

Here and in ncsi_kick_channels(), nc->lock is now taken inside ndp->lock.
ncsi_choose_active_channel() is unchanged and still nests the locks the
other way round:

    spin_lock_irqsave(&nc->lock, cflags);
    ...
        spin_lock_irqsave(&ndp->lock, flags);
        list_add_tail_rcu(&nc->link,
                          &ndp->channel_queue);
        spin_unlock_irqrestore(&ndp->lock, flags);
    ...
    spin_unlock_irqrestore(&nc->lock, cflags);

For example:

CPU0
ncsi_vlan_rx_add_vid()
  ncsi_kick_channels()
    spin_lock_irqsave(&ndp->lock, flags);
    spin_lock(&nc->lock);          <- spins

CPU1
ncsi_choose_active_channel()
    spin_lock_irqsave(&nc->lock, cflags);
    spin_lock_irqsave(&ndp->lock, flags);   <- spins

CPU1 can be reached from ncsi_dev_work, from ncsi_reset_dev() via
Netlink, from an AEN in NET_RX softirq, or from the monitor timer.
ncsi_dev_mutex serializes only the VLAN, register and unregister paths.

Both CPUs have IRQs disabled, so this would be a hard lockup. Lockdep
should also see both orders during normal bring-up, even when no
deadlock occurs.

[ ... ]

> @@ -1956,19 +2003,56 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)

[ ... ]

> +	for (i = 0; i < ARRAY_SIZE(ndp->requests); i++) {
> +		struct ncsi_request *nr = &ndp->requests[i];
> +
> +		timer_delete_sync(&nr->timer);
> +		if (!nr->used)
> +			continue;
> +
> +		if (nr->flags == NCSI_REQ_FLAG_NETLINK_DRIVEN && nr->cmd) {
> +			struct ncsi_cmd_pkt *cmd = (struct ncsi_cmd_pkt *)
> +				skb_network_header(nr->cmd);
> +
> +			ncsi_find_package_and_channel(ndp,
> +						      cmd->cmd.common.channel,
> +						      &np, &nc);

[Severity: Low]
Will this produce an "RCU-list traversed in non-reader section!" warning
under CONFIG_PROVE_RCU_LIST?

ncsi_find_package_and_channel() goes through ncsi_find_package() and
ncsi_find_channel(). Those walk ndp->packages and np->channels with
NCSI_FOR_EACH_PACKAGE/NCSI_FOR_EACH_CHANNEL, which are
list_for_each_entry_rcu() without a lockdep condition. Here they are
called from process context with no rcu_read_lock().

There are no concurrent writers at this point, so this would only be a
debug splat. Elsewhere the patch does wrap similar helpers in
rcu_read_lock().

> +			ncsi_send_netlink_timeout(nr, np, nc);

[Severity: Low]
This isn't a bug introduced by this patch, but this new caller inherits
it. When np is NULL, ncsi_send_netlink_timeout() falls back to:

    nla_put_u32(skb, NCSI_ATTR_PACKAGE_ID,
                NCSI_PACKAGE_INDEX((((struct ncsi_pkt_hdr *)
                                     nr->cmd->data)->channel)));

ncsi_xmit_cmd() has already done skb_push(nr->cmd, sizeof(*eh)), so
nr->cmd->data points at the Ethernet header. Offset 5 is therefore
h_dest[5], which is 0xff for broadcast, and the reported package ID
becomes 7.

The teardown path reaches this fallback when an outstanding Netlink
command targets a package that was never discovered, because
ncsi_send_cmd_nl() only range-checks the package ID. The existing
ncsi_request_timeout() caller has the same problem.

> +		}
> +		ncsi_free_request(nr);
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005115944.1397670-1-wongboonjhee52%40gmail.com
