Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1AE3750D6;
	Thu, 24 Sep 2026 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290911; cv=none; b=vF5sZBzH3VPQf4pSyLNNfo4p39uz0TOnUmWNyTFt4gedAeZviAt4dcvHLFGZ/OGgFmENutzm8p+76fFaLwQbTjC5yIVlQVSIScnKJS02pHHYz/ZJP+QJA8EUtvXP4JySwc1DEvv6C8m8IK5G8RcDuJRz9oiQI8EFAtSkBgCzKhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290911; c=relaxed/simple;
	bh=zY9gjeMJMW/86OZGp/Xg9IuDdDuU+5y+lW+CcT0YJB0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U18eSN1KBSVqTqs8FZ270gHMoX/qlV9QaAow6QQdLm4P0Qk4NQ8ExJ9epcZxLXgnN9k91L6a7BeLndXAcjYQe2WZ9asD1Iq2nCFAmjtYoK69HRsgVW6a4O0e62upGBwEepkoj357IlirTU3uOq679le5Im+/b6aISJ8F9tTVfZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G85tYgxv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G85tYgxv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BC41F000FF;
	Thu, 24 Sep 2026 23:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790290909;
	bh=/SoON5rlMc9+Ef0No/JCwsV8yngWnfn2kD2REmrsOk0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G85tYgxvDK5SYK/iEE7hLXtxSRu37U6odwgkhO4Hu/5PKchcGgvYBD55k+N7npUve
	 KGcdt5Htncg0mUiUhT5s/pcquW4WdOXpVC64rzR5NaP/Ual/FcaW5dVOv8Jd4U3ClL
	 rZMp+G2iaXqDCUXabkt6/Y50IuaRZkqqYvU8wBlwxp1S2gQuienQ1CXtX55YhBaP/C
	 dj6E2MtuGVh/v0G/3/DE2Vlygph9B8c55WDwYK15sIiniLdmmMgjQlk2VakvLuGcSI
	 jLuVTWAHA5drq6W/ecj7eb8nCa6kGYj1ndtvwLtgiDrSUQWhtCgi/Iwgbt/wwfFVkV
	 zWnkzctVbJPPQ==
Subject: Re: [PATCH net-next 1/6] net: add netif_rx_mode_schedule_fresh()
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sebaddel@cisco.com
Date: Thu, 24 Sep 2026 23:01:48 +0000
Message-ID: <179029090875.2160803.9750318118693297771@kernel.org>
In-Reply-To:
 <20260921-b4-enic-sriov-v2-vf-receive-control-v1-1-67a0a6e08d43@cisco.com>
References:
 <20260921-b4-enic-sriov-v2-vf-receive-control-v1-1-67a0a6e08d43@cisco.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Claimed dead code: netif_rx_mode_schedule_fresh() is added and
  EXPORT_SYMBOL_GPL()'d with no in-tree caller in this patch.
- [Low] Claim that netif_rx_mode_schedule_fresh() cannot deliver the
  documented 'complete configuration replay' for ndo_set_rx_mode_async…

Pre-existing issues:
- [High] dev->rx_mode_retry_timer is initialized for the whole net_device
  lifetime in netif_rx_mode_init() (net/core/dev_addr_lists.c:1369) but…

--

net: add netif_rx_mode_schedule_fresh()

This adds a new exported helper that cancels any pending receive-mode retry
timer, resets the retry backoff counter, and then queues an immediate
receive-mode update via the netdev work core.  It is meant for callers that
need to replay the full receive configuration after a state transition,
as opposed to netif_rx_mode_schedule_retry() which is used after a failed
update.

No Link: tags present in the commit header.

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 5d16737167eed..2246be72d8114 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5197,6 +5197,7 @@ static inline void __dev_mc_unsync(struct net_device *dev,
>  
>  /* Functions used for secondary unicast and multicast support */
>  void dev_set_rx_mode(struct net_device *dev);
> +void netif_rx_mode_schedule_fresh(struct net_device *dev);
>  void netif_rx_mode_schedule_retry(struct net_device *dev);
>  int netif_set_promiscuity(struct net_device *dev, int inc);
>  int dev_set_promiscuity(struct net_device *dev, int inc);
> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> index 08528ca0a8b31..4ae0510ce91fa 100644
> --- a/net/core/dev_addr_lists.c
> +++ b/net/core/dev_addr_lists.c
> @@ -1337,6 +1337,27 @@ static void netif_rx_mode_queue(struct net_device *dev)
>  	__netdev_work_core_sched(dev, NETDEV_WORK_RX_MODE);
>  }
>  
> +/**
> + * netif_rx_mode_schedule_fresh() - schedule a fresh receive-mode update
> + * @dev: network device
> + *
> + * Cancel any pending retry and reset its backoff budget before scheduling an
> + * immediate receive-mode update. Callers use this after a state transition
> + * which requires the complete receive configuration to be replayed, rather
> + * than after a failed update (which uses netif_rx_mode_schedule_retry()).
> + *
> + * Context: sleepable. The caller must hold the device operations lock, or
> + * RTNL for a device which still uses RTNL-compatible operations.
> + */

[Severity: Low]
The kernel-doc says the helper is for callers which need "the complete
receive configuration to be replayed".  Does the helper on its own produce
that replay for an ndo_set_rx_mode_async driver?

The queued run ends up in netif_rx_mode_run(), which snapshots the address
lists and then reconciles them.  __hw_addr_list_snapshot() copies sync_cnt
and refcount, __hw_addr_sync_dev() skips entries whose sync_cnt is already
nonzero, and the reconcile step then computes a zero delta, so addresses
that were already marked synced are not pushed to the driver again.

Checking the caller added later in the series, enic does invalidate that
state first:

drivers/net/ethernet/cisco/enic/enic_main.c:enic_reset_addr_lists() {
	netif_addr_lock_bh(netdev);
	__dev_uc_unsync(netdev, NULL);
	__dev_mc_unsync(netdev, NULL);
	netif_addr_unlock_bh(netdev);
	...
}

and __hw_addr_unsync_dev() with a NULL unsync callback is documented and
implemented to just reset sync_cnt for each entry, so the following
netif_rx_mode_schedule_fresh() does re-push everything.  That makes the
behaviour correct as used, but the requirement is only visible in the
driver.

Would it be worth stating in the kernel-doc that the caller is responsible
for clearing the per-address sync state (for example via
__dev_uc_unsync(dev, NULL) / __dev_mc_unsync(dev, NULL)) before calling
this helper?

> +void netif_rx_mode_schedule_fresh(struct net_device *dev)
> +{
> +	might_sleep();
> +	netdev_assert_locked_ops_compat(dev);
> +	netif_rx_mode_cancel_retry(dev);
> +	netif_rx_mode_queue(dev);
> +}
> +EXPORT_SYMBOL_GPL(netif_rx_mode_schedule_fresh);
> +

[Severity: Low]
This isn't a bug, but at this commit netif_rx_mode_schedule_fresh() is
exported with no in-tree caller.

Grepping the tree at the end of the series shows eight references in
drivers/net/ethernet/cisco/enic/enic_main.c (enic_open(), enic_reset() and
enic_tx_hang_reset() among them), so the symbol does get its first user
inside the same series, which is the usual "add the API in one patch, add
the users in the following patches" layout.  Mentioning the intended first
consumer in the changelog would make that obvious to anyone bisecting or
reviewing this patch alone.

>  static void netif_rx_mode_retry(struct timer_list *t)
>  {
>  	struct net_device *dev =

[Severity: High]
This isn't a bug introduced by this patch, but since this patch adds a
second entry point that cancels dev->rx_mode_retry_timer, is the lifetime of
that timer fully covered anywhere?

netif_rx_mode_init() arms the timer for the whole net_device lifetime:

net/core/dev_addr_lists.c:netif_rx_mode_init() {
	__hw_addr_init(&dev->rx_mode_addr_cache);
	timer_setup(&dev->rx_mode_retry_timer, netif_rx_mode_retry, 0);
}

The only cancellation site in the tree is in __dev_close_many():

net/core/dev.c:__dev_close_many() {
	...
		netif_rx_mode_cancel_retry(dev);
		netif_set_up(dev, false);
	...
}

but netif_close_many() drops devices that are not IFF_UP before that:

net/core/dev.c:netif_close_many() {
	/* Remove the devices that don't need to be closed */
	list_for_each_entry_safe(dev, tmp, head, close_list)
		if (!(dev->flags & IFF_UP))
			list_del_init(&dev->close_list);
	...
}

netif_rx_mode_schedule_retry() has no IFF_UP, netif_device_present() or
dev_isalive() guard, and bnxt arms the timer from inside ndo_open, which
runs before __dev_open() sets IFF_UP:

drivers/net/ethernet/broadcom/bnxt/bnxt.c:bnxt_init_chip() {
	rc = bnxt_cfg_rx_mode(bp, &bp->dev->uc, true);
	if (rc == -EAGAIN) {
		netif_rx_mode_schedule_retry(bp->dev);
		rc = 0;
	}
	...
}

(bnge_netdev.c does the same.)  If that open subsequently fails, IFF_UP is
never set, so the close path skips the device and nothing cancels the timer.

On the teardown side, unregister_netdevice_many_notify() only calls
netdev_work_cancel_all(dev), and the free path only does
__hw_addr_flush(&dev->rx_mode_addr_cache); there is no
timer_shutdown_sync() or timer_delete_sync() for rx_mode_retry_timer.

Can free_netdev() then release the device while the timer is still queued,
so that netif_rx_mode_retry() dereferences freed memory through
timer_container_of() and netif_rx_mode_queue() -> netdev_work_enqueue() ->
dev_isalive(dev), and the timer wheel keeps a pointer into freed memory?
Would a timer_shutdown_sync(&dev->rx_mode_retry_timer) on the
unregister/free path, or an IFF_UP/present check in
netif_rx_mode_schedule_retry(), be the right fix here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43%40cisco.com
