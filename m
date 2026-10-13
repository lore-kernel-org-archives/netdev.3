Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FEE37A83D
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874247; cv=none; b=i7ONt051sy9EbVPs933QnLp+G8QwS5c2XjdKrx8FOUvhhVcO/P3+rvs7Th2G4916YeC2nTnkBWzxerKFfWEb++bFfWmBJE7xKX+Sxs3XA79b+2Y53kdwOQ5Bl5k3phkKGKz4ZWywVkwid9fnArwDDodhrcyG3irmh7UAy0DYyrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874247; c=relaxed/simple;
	bh=4zGQjOJKmJ+nQAg9xOPXrfkSWmPilUR3m4Q8RNIIgeg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OmUYssZLe8j13beXGbugtgVvzeU8QUCQrEcJfvg70bCYTKzRqvBjyGfaUE/p6NaRsxlH9z9HI5JNCQ2EvSDBmvE1DQJEZSuPAwr9UpBJ28V0mViFQ8WaEcQmaTHoobdVPs5fGEKlogh5xit8Hbm6IV1d6vSup5wWIZhHg+IwaEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu28btGv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu28btGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8101F000FF;
	Tue, 13 Oct 2026 06:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874245;
	bh=MTL4dtP4hOzIGkLPknabElb1Jb3/peLyPJWjh86/8X8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hu28btGvZvK1pdPHiddh3pWwQFdbAA8HkICS/11NHCZ/HWceXOf8Iqud1Qg1ebnAH
	 Z7ymCztWVmqUUD3LJWPPmzQ40vaxh+I10p+3bokcxkUZzs8497xjkHwRG0HPrh13E8
	 f2EkHSuvk6q7Gv9VGJyJOpjtS4qDzrc3wy4G/ZprQmVw9AGN4RlrAWtLkIe9Hg170a
	 W/THJmk+d+GOtgigSjQ6YRGHvmQF6PbArIwhNNtG4G3Mo74hA90dhP5oMmlgrlH6SC
	 SwR0xj80B1xcuoVRROOM4p20S6N5nktvmiTx3a4TnHny0mvW/RUQeyThwkq1HmACoe
	 CwQHG4GYze1yw==
Subject: Re: [PATCH v10] net/ncsi: Fix use-after-free in NCSI teardown
From: netdev-bot+sashiko@kernel.org
To: wongboonjhee52@gmail.com
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org
Date: Tue, 13 Oct 2026 06:50:44 +0000
Message-ID: <179187424485.434549.15081661538326489624@kernel.org>
In-Reply-To: <20261012060434.1974740-1-wongboonjhee52@gmail.com>
References: <20261012060434.1974740-1-wongboonjhee52@gmail.com>
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

Critical: 0 · High: 3 (1) · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ncsi_unregister_dev_prepare() holds the global ncsi_dev_mutex
  while it calls disable_work_sync(&ndp->work), so it waits for…
- [High] The prepare/unregister split leaves a use-after-free window on
  request timers.
- [High] The commit says it guards channel_queue additions against
  duplicates and keeps state and queue transitions under the ndp->lock-…
- [Medium] In the single-channel link-loss branch of
  ncsi_aen_handler_lsc(), the patch re-checks the channel and queues it…
- [Medium] ncsi_unregister_dev_prepare() calls
  disable_work_sync(&ndp->work), removes the ptype (so NC responses are…
- [Low] The patch is titled "Fix use-after-free in NCSI teardown" and has
  one Fixes: tag (2d283bdd079c), but it bundles several independent…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but an NCSI Get
  Capabilities response can corrupt kernel memory.

--

net/ncsi: Fix use-after-free in NCSI teardown

This patch splits NCSI unregistration into two steps. The prepare step
unlinks the device, removes the packet handler and drains the work and
timers, and a final step frees everything. It also adds a global
ncsi_dev_mutex that serializes netlink and VLAN operations with teardown,
reworks channel state and queue locking to take ndp->lock before
nc->lock, fixes several netlink handler issues, and converts ftgmac100 to
the two-step teardown.

> net/ncsi: Fix use-after-free in NCSI teardown

[ ... ]

> Fixes: 2d283bdd079c ("net/ncsi: Resource management")

[Severity: Low]
This isn't a bug, but could this be split into a series? Besides the
teardown use-after-free, the patch also carries:

  - the get_net() reference leak fix in five netlink handlers
  - the genlmsg_cancel(skb, NULL) fix in ncsi_pkg_info_all_nl()
  - the nr->cmd->data vs skb_network_header() offset fix in
    ncsi_send_netlink_timeout()
  - the PKG_INFO behaviour change for sparse package IDs
  - the uninitialized vid in set_one_vid()
  - a lock order and state machine rework across the AEN handlers,
    ncsi_report_link(), ncsi_channel_monitor(),
    ncsi_choose_active_channel() and ncsi_process_next_channel()
  - a batch/cursor rewrite of ncsi_kick_channels()
  - new netlink timeout notifications sent from ncsi_unregister_dev()

Several of these fix code from the later NCSI netlink commits rather than
2d283bdd079c. The single Fixes: tag doesn't match those, and backports to
trees without the netlink code would not apply cleanly.

It also means a regression in the state machine rework couldn't be
reverted without also reverting the use-after-free fix.

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 6d2fe5c2f3903..f45388810570d 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c

[ ... ]

> @@ -2108,8 +2110,12 @@ static void ftgmac100_remove(struct platform_device *pdev)
>  	priv = netdev_priv(netdev);
>  
>  	if (priv->ndev)
> -		ncsi_unregister_dev(priv->ndev);
> +		ncsi_unregister_dev_prepare(priv->ndev);
>  	unregister_netdev(netdev);
> +	if (priv->ndev) {
> +		ncsi_unregister_dev(priv->ndev);
> +		priv->ndev = NULL;
> +	}

[Severity: Medium]
ncsi_unregister_dev_prepare() disables ndp->work, removes the ptype (so NC
responses are dropped), stops the monitors and deletes the request timers,
all before unregister_netdev().

If a channel is mid-configuration or mid-suspend at that point, it stays
in NCSI_CHANNEL_INVISIBLE. Only the config_done and suspend_done steps in
the work move it out of that state.

The monitors are also stopped after the work is disabled. In between, a
monitor callback in its timeout branch can still call
ncsi_process_next_channel().

unregister_netdev() then reaches:

unregister_netdev()
  ... -> ftgmac100_stop()
    ncsi_stop_dev()

and ncsi_stop_dev() checks:

			WARN_ON_ONCE(chained ||
				     old_state == NCSI_CHANNEL_INVISIBLE);

Will removing the device during a configure or suspend transition always
hit this WARN, and panic on panic_on_warn systems? Nothing in the stop
path checks unregister_prepared, even though the header comment says the
prepare step quiesces NCSI before the netdev is stopped.

> diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
> index 040a31557201b..c3614f0648649 100644
> --- a/net/ncsi/ncsi-aen.c
> +++ b/net/ncsi/ncsi-aen.c

[ ... ]

> @@ -94,7 +96,11 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
>  			ndp->flags |= NCSI_DEV_RESHUFFLE;
>  			ncsi_stop_channel_monitor(nc);
>  			spin_lock_irqsave(&ndp->lock, flags);
> -			list_add_tail_rcu(&nc->link, &ndp->channel_queue);
> +			spin_lock(&nc->lock);
> +			if (nc->state == NCSI_CHANNEL_ACTIVE &&
> +			    list_empty(&nc->link))
> +				list_add_tail_rcu(&nc->link, &ndp->channel_queue);
> +			spin_unlock(&nc->lock);
>  			spin_unlock_irqrestore(&ndp->lock, flags);
>  			return ncsi_process_next_channel(ndp);

[Severity: Medium]
What happens here when the new re-check fails? For example, nc may be
INVISIBLE because it is being configured or suspended, or it may already
be INACTIVE.

Nothing is queued in that case, but ncsi_process_next_channel() is still
called with NCSI_DEV_RESHUFFLE just set. With an empty channel_queue it
goes to:

out:
	ndp->active_channel = NULL;
	ndp->active_package = NULL;
	if (ndp->flags & NCSI_DEV_RESHUFFLE) {
		ndp->flags &= ~NCSI_DEV_RESHUFFLE;
		return ncsi_choose_active_channel(ndp);
	}

Doesn't this abandon the transition that is in progress on nc?

ncsi_choose_active_channel() can start configuring another INACTIVE
channel while nc's requests are still outstanding. Or it can call
ncsi_report_link(ndp, true), which sets nd->state to functional. Either
way nc stays INVISIBLE until a reset.

ncsi_aen_handler_cr() handles the same failed re-check by returning 0:

	if (nc->state != NCSI_CHANNEL_ACTIVE || !list_empty(&nc->link)) {
		spin_unlock(&nc->lock);
		spin_unlock_irqrestore(&ndp->lock, flags);
		return 0;
	}

Should the lsc path do the same?

>  		}

[ ... ]

> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 54d0df0a9efe6..f84e7da098fea 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c

[ ... ]

> @@ -640,7 +649,7 @@ static int set_one_vid(struct ncsi_dev_priv *ndp, struct ncsi_channel *nc,
>  	unsigned long flags;
>  	int i, index;
>  	void *bitmap;
> -	u16 vid;
> +	u16 vid = 0;

[Severity: High]
This isn't a bug introduced by this patch, but while looking at the VLAN
filter code: can a Get Capabilities response with vlan_cnt > 64 corrupt
memory?

ncsi_rsp_handler_gc() takes the count straight from the response:

	nc->vlan_filter.vids = kcalloc(rsp->vlan_cnt,
				       sizeof(*nc->vlan_filter.vids),
				       GFP_ATOMIC);
	...
	nc->vlan_filter.bitmap = U64_MAX;
	nc->vlan_filter.n_vids = rsp->vlan_cnt;

but the bitmap is a single u64 placed directly before the vids pointer:

struct ncsi_channel_vlan_filter {
	u8	n_vids;
	u64	bitmap;
	u16	*vids;
};

In clear_one_vid(), once the 64 real bits are cleared,
find_first_bit(bitmap, ncf->n_vids) scans into the vids pointer. Then:

	clear_bit(index, bitmap);
	ncf->vids[index] = 0;

This flips a bit of the vids pointer and then writes through the
corrupted pointer.

set_one_vid() (find_first_zero_bit()/set_bit()) and
ncsi_rsp_handler_gp() also write past the bitmap. The later kfree() of
vids then gets the corrupted pointer.

Should n_vids be limited to the bitmap width?

>  
>  	if (list_empty(&ndp->vlan_vids))
>  		return -1;

[ ... ]

> @@ -1285,10 +1296,8 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
>  			 * so they will have AENs enabled.
>  			 */
>  			if (with_link || np->multi_channel) {
> -				spin_lock_irqsave(&ndp->lock, flags);
>  				list_add_tail_rcu(&nc->link,
>  						  &ndp->channel_queue);
> -				spin_unlock_irqrestore(&ndp->lock, flags);

[Severity: High]
The commit message says queue additions are guarded against duplicates
and kept under the ndp-before-channel lock order. The reconfigure branch
of the config_done state in ncsi_configure_channel() doesn't seem to have
been converted:

net/ncsi/ncsi-manage.c:ncsi_configure_channel() {
    ...
		if (nc->reconfigure_needed) {
			...
			nc->reconfigure_needed = false;
			nc->state = NCSI_CHANNEL_INACTIVE;
			spin_unlock_irqrestore(&nc->lock, flags);

			spin_lock_irqsave(&ndp->lock, flags);
			list_add_tail_rcu(&nc->link, &ndp->channel_queue);
			spin_unlock_irqrestore(&ndp->lock, flags);
    ...
}

Between dropping nc->lock and taking ndp->lock, nc is INACTIVE and not
on any list.

ncsi_choose_active_channel() can run on another CPU in that window. One
way in is ncsi_process_next_channel() with an empty queue and
NCSI_DEV_RESHUFFLE set, which the lsc handler now reaches after its guard
fails. It would pass the INACTIVE/list_empty() check and queue nc here.

Can the work then add the same nc->link a second time and corrupt
channel_queue? Should that path also change the state and add to the
queue under ndp->lock and nc->lock, with a list_empty() check?

>  
>  				netdev_dbg(ndp->ndev.dev,
>  					   "NCSI: Channel %u added to queue (link %s)\n",

[ ... ]

> @@ -1952,22 +2045,74 @@ int ncsi_reset_dev(struct ncsi_dev *nd)
>  	return 0;
>  }
>  
> +void ncsi_unregister_dev_prepare(struct ncsi_dev *nd)
> +{
> +	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
> +	struct ncsi_package *np;
> +	struct ncsi_channel *nc;
> +	int i;
> +	unsigned long flags;
> +
> +	mutex_lock(&ncsi_dev_mutex);
> +	if (!ndp->unregister_prepared) {
> +		ndp->unregister_prepared = true;
> +		spin_lock_irqsave(&ncsi_dev_lock, flags);
> +		list_del_rcu(&ndp->node);
> +		spin_unlock_irqrestore(&ncsi_dev_lock, flags);
> +
> +		dev_remove_pack(&ndp->ptype);
> +
> +		/* Wait for lookups that found this device before it was unlinked. */
> +		synchronize_rcu();
> +
> +		/* Quiesce NCSI activity before the netdev is stopped. */
> +		disable_work_sync(&ndp->work);

[Severity: High]
This waits for ndp->work while holding the global ncsi_dev_mutex. The
work can take RTNL in the apply_mac state:

ncsi_dev_work()
  ncsi_configure_channel()
    case ncsi_dev_state_config_apply_mac:
      rtnl_lock();

This patch also makes ncsi_vlan_rx_add_vid() and ncsi_vlan_rx_kill_vid()
take ncsi_dev_mutex. Those ndo callbacks are called from vlan_vid_add()
and vlan_vid_del() with RTNL held.

Can this deadlock?

CPU0:
ftgmac100_remove()
  ncsi_unregister_dev_prepare()
    mutex_lock(&ncsi_dev_mutex);
    disable_work_sync(&ndp->work);   <- waits for the work

kworker:
ncsi_dev_work()
  ncsi_configure_channel()
    rtnl_lock();                     <- waits for CPU1

CPU1 (RTNL held, e.g. adding a VLAN):
vlan_vid_add()
  ncsi_vlan_rx_add_vid()
    mutex_lock(&ncsi_dev_mutex);     <- waits for CPU0

The mutex is global, so CPU1 can be working on a different NCSI netdev
from the one being removed.

> +		list_for_each_entry(np, &ndp->packages, node)
> +			list_for_each_entry(nc, &np->channels, node)
> +				ncsi_stop_channel_monitor(nc);
> +		for (i = 0; i < ARRAY_SIZE(ndp->requests); i++)
> +			timer_delete_sync(&ndp->requests[i].timer);
> +	}
> +	mutex_unlock(&ncsi_dev_mutex);
> +}
> +EXPORT_SYMBOL_GPL(ncsi_unregister_dev_prepare);
> +
>  void ncsi_unregister_dev(struct ncsi_dev *nd)
>  {
>  	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
>  	struct ncsi_package *np, *tmp;
> -	unsigned long flags;
> +	struct ncsi_channel *nc;
> +	struct vlan_vid *vlan, *vlan_tmp;
> +	int i;
>  
> -	dev_remove_pack(&ndp->ptype);
> +	ncsi_unregister_dev_prepare(nd);
> +	for (i = 0; i < ARRAY_SIZE(ndp->requests); i++) {
> +		struct ncsi_request *nr = &ndp->requests[i];
>  
> -	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
> -		ncsi_remove_package(np);
> +		if (!nr->used)
> +			continue;
>  
> -	spin_lock_irqsave(&ncsi_dev_lock, flags);
> -	list_del_rcu(&ndp->node);
> -	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
> +		if (nr->flags == NCSI_REQ_FLAG_NETLINK_DRIVEN && nr->cmd) {
> +			struct ncsi_cmd_pkt *cmd = (struct ncsi_cmd_pkt *)
> +				skb_network_header(nr->cmd);
> +
> +			rcu_read_lock();
> +			ncsi_find_package_and_channel(ndp,
> +						      cmd->cmd.common.channel,
> +						      &np, &nc);
> +			rcu_read_unlock();
> +			ncsi_send_netlink_timeout(nr, np, nc);
> +		}
> +		ncsi_free_request(nr);
> +	}

[ ... ]

> +	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
> +		ncsi_remove_package(np);
>  
>  	kfree(ndp);
>  }

[Severity: High]
When ftgmac100_remove() has already called ncsi_unregister_dev_prepare(),
the second call here does nothing. So the request timers are drained only
once, before unregister_netdev().

Between the two calls the netdev is still registered and RTNL isn't held,
so the interface can be brought up:

ftgmac100_open()
  ncsi_start_dev()
    ncsi_reset_dev()
      ncsi_choose_active_channel()
        ncsi_process_next_channel()
          ncsi_configure_channel()
            ncsi_xmit_cmd()   <- sets nr->enabled, arms nr->timer

ncsi_start_dev() doesn't check unregister_prepared. This path can run
when the device is probed and no channel is ACTIVE.

When this loop runs later, ncsi_free_request() only syncs the timer if
nr->enabled is set:

	if (nr->enabled) {
		nr->enabled = false;
		timer_delete_sync(&nr->timer);
	}

ncsi_request_timeout() clears enabled as its first step and then keeps
using nr and ndp, including its own call to ncsi_free_request():

	spin_lock_irqsave(&ndp->lock, flags);
	nr->enabled = false;

If the timeout fires while this loop is running, can the loop skip
timer_delete_sync() and go on to ncsi_remove_package() and kfree(ndp)
while ncsi_request_timeout() is still using ndp->lock, ndp->requests[]
and ndp->work on another CPU?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012060434.1974740-1-wongboonjhee52%40gmail.com
