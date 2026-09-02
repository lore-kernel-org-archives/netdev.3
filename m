Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194B4AA595;
	Wed,  2 Sep 2026 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380297; cv=none; b=g9yXOh3gqSO18MEGdXAo9mtIPcEm+N0dfXSvI41f1hhPMxbj3pOJM3zt4XsooaE+z3HR3hW0sLH+5hz6QLjwK0biodICp+9xq1M/nz3zB1h7K9laVIWj12jisKPNytyI3jveazTWZ0XSBxQCMBqMJ9mrchqKWDW+1wnvrfRG6/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380297; c=relaxed/simple;
	bh=AiMpsQKRSyW9p3QmVE+GV+W6pXWXt1nNQlMgTFD3klw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=siqzUpom+Cbl1P1i15n7ROuyQoiPOXcG4jBCHpEoXIX/qUr56Q2sUCDj83PZlqm8FufD0ocBOEZiMusiJCIcrqxJrzOfbSqFryScyRBqsA2zV4JUZT/O67sihecOxqpS7yw2FRblv9xPJVokpOwj0pIueEALUNc3Yj64mchTcrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uf4oyFBZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uf4oyFBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF411F000E9;
	Wed,  2 Sep 2026 20:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788380295;
	bh=A8rlIDdIOWg5m9AdylGBKk63i17vSwszE6f5FVlv1g8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uf4oyFBZtRfV0T7EeDICXwiKQYqJnJn0l61KgcbWS/4Z0JeY3S8SJtyIgTFb8TNuV
	 fG+TONzGdJJbWvw8dtrHJ91NNP0krWe+oOSVSRKz29cOGDAACaQLL7ZP4Ez8mBZ6BN
	 pnwhiFSnGBEFg+8ueG45EIUymTtlu5rc9v2c7EO7j6Op7NWi8PH8R6IEuJkGLVA7qV
	 gmRZwAjtMigknkL8H2eUkmrQ5WYJmWiY2hClNvERS+EkChDj/7IbgAdUWU27m3MEDj
	 3j8MhhV1rM9mvS6lTHXgPNJTDdzEaiVvxsh8hkHhgv8tO/deVkgg79RLmGK7VOjL0J
	 9Foygr88sDIOw==
From: Simon Horman <horms@kernel.org>
To: rosenp@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	claudiu.manoil@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: gianfar: handle startup_gfar failure and fix double free
Date: Wed,  2 Sep 2026 21:18:01 +0100
Message-ID: <20260902201803.546034-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828222051.77604-1-rosenp@gmail.com>
References: <20260828222051.77604-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828222051.77604-1-rosenp@gmail.com?part=1
---
net: gianfar: handle startup_gfar failure and fix double free

This makes reset_gfar() return an int and propagates the startup_gfar()
error out of reset_gfar() and gfar_change_mtu(), and adds a
tx_bd_base test plus NULLing of the descriptor-ring base and dma-base
pointers in free_skb_resources(). A few questions on the resulting
behaviour below.

> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> index cf636fc5aafa..d0ac8a958696 100644
> --- a/drivers/net/ethernet/freescale/gianfar.c
> +++ b/drivers/net/ethernet/freescale/gianfar.c
> @@ -1140,11 +1140,24 @@ static void free_skb_resources(struct gfar_private *priv)
>  			free_skb_rx_queue(rx_queue);
>  	}
>  
> -	dma_free_coherent(priv->dev,
> -			  sizeof(struct txbd8) * priv->total_tx_ring_size +
> -			  sizeof(struct rxbd8) * priv->total_rx_ring_size,
> -			  priv->tx_queue[0]->tx_bd_base,
> -			  priv->tx_queue[0]->tx_bd_dma_base);
> +	if (priv->tx_queue[0]->tx_bd_base) {
> +		dma_free_coherent(priv->dev,
> +				  sizeof(struct txbd8) *
> +				  priv->total_tx_ring_size +
> +				  sizeof(struct rxbd8) *
> +				  priv->total_rx_ring_size,
> +				  priv->tx_queue[0]->tx_bd_base,
> +				  priv->tx_queue[0]->tx_bd_dma_base);

[Severity: High]
The changelog says that after this change "a second free cannot operate on
a stale pointer regardless of which error path is taken". Is that true for
the receive skb as well?

free_skb_resources() -> free_skb_rx_queue() frees it but leaves the field
set:

drivers/net/ethernet/freescale/gianfar.c:free_skb_rx_queue() {
	dev_kfree_skb(rx_queue->skb);
	...
	kfree(rx_queue->rx_buff);
	rx_queue->rx_buff = NULL;
}

rx_buff is cleared, rx_queue->skb is not, and gfar_init_bds() only resets
next_to_clean/next_to_use/next_to_alloc for the rx rings on the following
startup_gfar().

rx_queue->skb is non-NULL whenever a frame spanning several descriptors was
only partially received:

drivers/net/ethernet/freescale/gianfar.c:gfar_clean_rx_ring() {
	/* Store incomplete frames for completion */
	rx_queue->skb = skb;
}

So after any stop/start cycle (gfar_change_mtu(), reset_gfar() from
gfar_hwtstamp_set() or gfar_reset_task(), or the ethtool ring/coalesce/
features paths) the field is a dangling pointer, and the next poll picks it
up:

drivers/net/ethernet/freescale/gianfar.c:gfar_clean_rx_ring() {
	struct sk_buff *skb = rx_queue->skb;
	...
}

Can that append fragments to the freed skb via gfar_add_rx_frag()? And if
no packet arrives before the next teardown, does the next stop_gfar() ->
free_skb_resources() -> free_skb_rx_queue() call dev_kfree_skb() on the
same skb a second time?

Would adding rx_queue->skb = NULL in free_skb_rx_queue() fit here?

> +
> +		for (i = 0; i < priv->num_tx_queues; i++) {
> +			priv->tx_queue[i]->tx_bd_base = NULL;
> +			priv->tx_queue[i]->tx_bd_dma_base = 0;
> +		}
> +		for (i = 0; i < priv->num_rx_queues; i++) {
> +			priv->rx_queue[i]->rx_bd_base = NULL;
> +			priv->rx_queue[i]->rx_bd_dma_base = 0;
> +		}
> +	}
>  }
>  
>  void stop_gfar(struct net_device *dev)

[Severity: Medium]
What serializes these stores against the transmit path?

gfar_start_xmit() reads the base with only the txq _xmit_lock held, and
without testing GFAR_DOWN:

	base = tx_queue->tx_bd_base;

stop_gfar() only marks the queues stopped:

drivers/net/ethernet/freescale/gianfar.c:stop_gfar() {
	netif_tx_stop_all_queues(dev);
	...
	disable_napi(priv);
	gfar_halt(priv);
	phy_stop(dev->phydev);
	free_skb_resources(priv);
}

It takes no netif_tx_lock() (gfar_suspend() does) and no synchronize_net(),
and it sleeps in napi_disable() and phy_stop(), so a transmit that already
passed netif_xmit_frozen_or_stopped() inside HARD_TX_LOCK can still be
running here.

With base == NULL, does the wrap arithmetic move the descriptor pointer
below the former ring?

drivers/net/ethernet/freescale/gianfar.c:skip_txbd() {
	return (new_bd >= (base + ring_size)) ? (new_bd - ring_size) : new_bd;
}

For a stale cur_tx the comparison against (NULL + ring_size) is always
true, so the result is new_bd - ring_size. Before the patch the same race
scribbled inside the freed ring; can it now write up to
(ring_size - 1) * sizeof(struct txbd8) bytes below it?

The zeroed rx_bd_dma_base feeds gfar_rxbd_dma_lastfree(), used by
gfar_clean_rx_ring() and gfar_update_link_state() to program rfbptr — would
that publish a bogus DMA address? If the NULLing is kept, should it happen
under the same exclusion the readers use, i.e. netif_tx_disable() plus a
GFAR_DOWN check in gfar_start_xmit()?

> @@ -2003,6 +2016,7 @@ static int gfar_set_mac_address(struct net_device *dev)
>  static int gfar_change_mtu(struct net_device *dev, int new_mtu)
>  {
>  	struct gfar_private *priv = netdev_priv(dev);
> +	int err = 0;
>  
>  	while (test_and_set_bit_lock(GFAR_RESETTING, &priv->state))
>  		cpu_relax();
> @@ -2013,24 +2027,27 @@ static int gfar_change_mtu(struct net_device *dev, int new_mtu)
>  	WRITE_ONCE(dev->mtu, new_mtu);
>  
>  	if (dev->flags & IFF_UP)
> -		startup_gfar(dev);
> +		err = startup_gfar(dev);
>  
>  	clear_bit_unlock(GFAR_RESETTING, &priv->state);
>  
> -	return 0;
> +	return err;
>  }

[Severity: Medium]
Who restores the configuration that was already committed before the new
error return?

dev->mtu is written with WRITE_ONCE() before startup_gfar() runs, and the
core does not undo it when the driver callback fails:

net/core/dev.c:__netif_set_mtu() {
	if (ops->ndo_change_mtu)
		return ops->ndo_change_mtu(dev, new_mtu);
	...
}

net/core/dev.c:netif_set_mtu_ext() {
	if (new_mtu == dev->mtu)
		return 0;
	...
	orig_mtu = dev->mtu;
	err = __netif_set_mtu(dev, new_mtu);

	if (!err) {
		err = call_netdevice_notifiers_mtu(NETDEV_CHANGEMTU, dev, orig_mtu);
	...
}

So on -ENOMEM userspace is told the request failed, but ip link reports the
new MTU, no NETDEV_CHANGEMTU is sent, and a retry with the same value hits
the new_mtu == dev->mtu early return and reports success without ever
restarting the stopped device. Should dev->mtu be put back on the failure
path?

gfar_hwtstamp_set() has the same shape: priv->hwts_rx_en is assigned before
reset_gfar() and is not restored when the new error is returned.
dev_set_hwtstamp_phylib() returns the ndo error directly with no rollback,
so gfar_hwtstamp_get() then reports the filter the setter said it could not
apply, and repeating the identical request returns 0 because the flag
already matches while the controller stays halted.

>  
> -static void reset_gfar(struct net_device *ndev)
> +static int reset_gfar(struct net_device *ndev)
>  {
>  	struct gfar_private *priv = netdev_priv(ndev);
> +	int ret;
>  
>  	while (test_and_set_bit_lock(GFAR_RESETTING, &priv->state))
>  		cpu_relax();

[Severity: Medium]
This isn't a bug introduced by this patch, but since both users of the
GFAR_RESETTING guard are being touched here: the set-on-entry /
clear-on-exit bit pair in reset_gfar() and gfar_change_mtu() is an
open-coded, lockdep-invisible spinlock whose holder sleeps, in
dma_alloc_coherent(GFP_KERNEL) inside gfar_alloc_skb_resources(), in
napi_disable()'s usleep_range() and in phy_stop(), while another CPU
busy-waits in cpu_relax(). Two concurrent reconfiguration requests, for
example ip link set mtu racing hwstamp_ctl or a TX-timeout reset racing
ethtool -G, will burn a CPU for the duration.

It also cannot express the state left behind by the new error path: once
the bit is cleared after a failed startup_gfar(), code whose only guard is
the bit runs against the freed and now NULLed rings:

drivers/net/ethernet/freescale/gianfar.c:gfar_update_link_state() {
	if (unlikely(test_bit(GFAR_RESETTING, &priv->state)))
		return;
	...
}

Would a mutex plus an explicit "rings gone" state be a better fit?

>  
>  	stop_gfar(ndev);
> -	startup_gfar(ndev);
> +	ret = startup_gfar(ndev);
>  
>  	clear_bit_unlock(GFAR_RESETTING, &priv->state);
> +
> +	return ret;
>  }
>  
>  /* gfar_reset_task gets scheduled when a packet has not been

[Severity: High]
Is the failure sequence in the changelog reachable? It says
"gfar_close() -> stop_gfar() -> free_skb_resources() frees the same
coherent DMA ring a second time".

When startup_gfar() fails it returns before enable_napi():

drivers/net/ethernet/freescale/gianfar.c:startup_gfar() {
	gfar_mac_reset(priv);

	err = gfar_alloc_skb_resources(ndev);
	if (err)
		return err;
	...
	phy_start(ndev->phydev);
	enable_napi(priv);
	netif_tx_wake_all_queues(ndev);
	...
}

reset_gfar() and gfar_change_mtu() then just forward the error, so NAPI
stays in the state left by the preceding stop_gfar() -> disable_napi() and
the netdev stays IFF_UP. The next teardown disables NAPI again before it
ever reaches free_skb_resources():

drivers/net/ethernet/freescale/gianfar.c:stop_gfar() {
	netif_tx_stop_all_queues(dev);
	...
	disable_napi(priv);
	gfar_halt(priv);
	phy_stop(dev->phydev);
	free_skb_resources(priv);
}

and the second disable has nothing to wait for:

net/core/dev.c:napi_disable_locked() {
		while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
			usleep_range(20, 200);
			val = READ_ONCE(n->state);
		}

		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
	...
}

Those bits are left set on exit and only napi_enable() clears them, so does
gfar_close() -> cancel_work_sync() -> stop_gfar() spin here forever,
unkillable, holding rtnl_lock and the netdev instance lock? If so the
double free described in the changelog never happens, because the close
never gets past disable_napi(), and the hunk in free_skb_resources() is not
what breaks.

Would it make more sense to restore the NAPI and PHY balance, or to force
the interface fully down, when startup_gfar() fails, rather than only
returning the error?

[Severity: Medium]
The changelog says reset_gfar() now propagates the error "instead of
silently continuing", but the reset path that runs on TX watchdog expiry
and on IEVENT_XFUN still drops it:

drivers/net/ethernet/freescale/gianfar.c:gfar_reset_task() {
	struct gfar_private *priv = container_of(work, struct gfar_private,
						 reset_task);
	reset_gfar(priv->ndev);
}

gfar_timeout() -> schedule_work(&priv->reset_task) -> gfar_reset_task()
ignores the return value, with no netdev_err() and no recovery, so after a
failed reset the netdev remains IFF_UP with the MAC halted, PHY stopped,
NAPI disabled, all TX queues stopped and GFAR_DOWN set, and nothing is
logged. Should this caller at least report the failure?

Note the ethtool re-init sites in gianfar_ethtool.c (gfar_scoalesce,
gfar_sringparam, gfar_set_features) already propagated the error before
this patch and end up in the same half-down state, which suggests
propagation alone does not address the "leaves the interface logically UP"
half of the problem the changelog describes.

>  @@ -2058,6 +2075,7 @@ static int gfar_hwtstamp_set(struct net_device *netdev,
>  			     struct netlink_ext_ack *extack)
>  {
>  	struct gfar_private *priv = netdev_priv(netdev);
> +	int ret = 0;
>  
>  	switch (config->tx_type) {
>  	case HWTSTAMP_TX_OFF:

[ ... ]

> @@ -2084,13 +2102,13 @@ static int gfar_hwtstamp_set(struct net_device *netdev,
>  			return -ERANGE;
>  		if (!priv->hwts_rx_en) {
>  			priv->hwts_rx_en = 1;
> -			reset_gfar(netdev);
> +			ret = reset_gfar(netdev);
>  		}
>  		config->rx_filter = HWTSTAMP_FILTER_ALL;
>  		break;
>  	}
>  
> -	return 0;
> +	return ret;
>  }

[Severity: High]
This is a pre-existing issue rather than something the patch introduces,
but it is in the function being modified: gfar_hwtstamp_set() calls
reset_gfar() with no netif_running() or IFF_UP test, and reset_gfar()
unconditionally runs stop_gfar() followed by startup_gfar().

The generic caller only requires the device to be present:

net/core/dev_ioctl.c:dev_set_hwtstamp() {
	if (!netif_device_present(dev))
		return -ENODEV;
	...
}

So SIOCSHWTSTAMP on an administratively down gianfar interface with
FSL_GIANFAR_DEV_HAS_TIMER set reaches stop_gfar() -> disable_napi() ->
napi_disable() on contexts that were only added by netif_napi_add() in
gfar_probe() and never enabled, since napi_enable() runs only in
startup_gfar(). Does that loop forever in napi_disable_locked()'s
usleep_range() with rtnl_lock held? And if it did return, would
phy_stop(dev->phydev) run with dev->phydev already cleared by
phy_disconnect() in gfar_close()?

Should reset_gfar() (or its callers) skip the stop/start when the interface
is not running, the way gfar_change_mtu() checks dev->flags & IFF_UP?
