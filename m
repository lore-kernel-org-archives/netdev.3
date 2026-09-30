Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1939734E;
	Wed, 30 Sep 2026 03:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790740142; cv=none; b=sG8ICf/hDjWJp9WMGWEW15ceoMx/Kt653GQpZR4a9sRYpbQVWNRWbua8t9B1FPIiC2vEogBWft+CrHgC003hknauQ5KSOHkZGDqwRrqE/a1t/Z/LqYIqT9jSj2wBv+Ea0AFoBxsf2Gf1oVQH2YN6ft9JGrSs3hxENSlPPzkSwtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790740142; c=relaxed/simple;
	bh=IfNK/x300/g/dbN/6uhIWYcvxYKUBYnf0Lr1wvUYTeg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q0w3Kn152vRySKcmsMSi2rHz0miH96EM7BnJWAfStvP1YBhDhsRAwmviO3fZ52RWBYwJZptq1XnfNWSr7htp5a76s/VunbrSOjE9hD2UYFGYrykivpmu0YjldUCSwmdKBZ8YsTOY2OB6RD79t0CIJXzzG3q8u88IJaI4anhaBVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzOXliEa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzOXliEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A41D1F00893;
	Wed, 30 Sep 2026 03:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790740140;
	bh=eajeywToKttcXIlo1Rjmibrw2w3e+m2Cm8BdSEkTeKE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AzOXliEaIQ8TDdxc0wEqsFTJEemK2a2HQ3Q+k+zDA8c988qbM8+AFmarqKWodFieu
	 JFpgLdGr5T76xPQ72O7xY0iPQPPW9EOvrqTwryUpyCYoIyRIlct5RLI+BHaZltDbqh
	 Qa8C/2cx8Fa9R/CvNua4E3E3bsR5vvh2ZdHL9gHHVqKpXyNsWU0pDTFLB7D2xw64+A
	 LN7riYU1X6YbDEGR5W8EIGOmFv7oJq9yu1ii0LdQr8VvcosUcK8ZVtpqaUjLOu9sIQ
	 yDoiTfgDhpH5E00cA+43j+qU9OUh8b1LEuXZ4BCheckEW0f3XvZ0crtpPopRQD/UWf
	 zqWULOBbq5YBg==
Subject: Re: [PATCH v2 3/7] net: hip04: manage the netdev lifetime with devres
From: netdev-bot+sashiko@kernel.org
To: yaojiale02@163.com
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
 shenjian15@huawei.com, shaojijie@huawei.com, niklas.soderlund@ragnatech.se,
 paul@pbarker.dev, bh74.an@samsung.com, linux@armlinux.org.uk,
 nicolas.ferre@microchip.com, soren.brinkmann@xilinx.com,
 fabio.estevam@freescale.com, arnd@arndb.de, zhangfei.gao@linaro.org,
 dingtianhong@huawei.com, xuejiancheng@hisilicon.com, lidongpo@hisilicon.com,
 mitsuhiro.kimura.kc@renesas.com, sergei.shtylyov@cogentembedded.com,
 s.shtylyov@omp.ru, claudiu.beznea.uj@bp.renesas.com, vipul.pandya@samsung.com,
 ks.giri@samsung.com, siva.kallam@samsung.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org
Date: Wed, 30 Sep 2026 03:48:57 +0000
Message-ID: <179074013765.434549.10669415017995583528@kernel.org>
In-Reply-To: <20260927144741.1320558-4-yaojiale02@163.com>
References: <20260927144741.1320558-4-yaojiale02@163.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 1 · High: 0 (2) · Medium: 0 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] hip04_remove()
  (drivers/net/ethernet/hisilicon/hip04_eth.c:1027-1040) still runs…

Pre-existing issues:
- [High] In hip04_mac_probe(), of_phy_connect() at line 981 succeeds and
  runs phy_attach_direct(), which sets phydev->attached_dev = ndev…
- [High] hip04_timeout() queues priv->tx_timeout_task on system_wq.
- [Medium] priv->tx_coalesce_timer is embedded in the netdev private
  area.
- [Medium] hip04_mac_probe() calls devm_request_irq() (line 972) before
  it masks PPE_INTEN or acks PPE_RINT, and before netif_napi_add() (line…

--

net: hip04: manage the netdev lifetime with devres

This patch switches hip04_mac_probe() to devm_alloc_etherdev(). It also
drops the explicit free_netdev() calls from the probe error path and from
hip04_remove(). The goal is for devres to release the IRQ taken with
devm_request_irq() before it releases the netdev.

> diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
> index fc2c47dcfaabe..4a643dff22ab0 100644
> --- a/drivers/net/ethernet/hisilicon/hip04_eth.c
> +++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
> @@ -905,7 +905,7 @@ static int hip04_mac_probe(struct platform_device *pdev)
>  	int irq;
>  	int ret;
>  
> -	ndev = alloc_etherdev(sizeof(struct hip04_priv));
> +	ndev = devm_alloc_etherdev(d, sizeof(struct hip04_priv));
>  	if (!ndev)
>  		return -ENOMEM;
>  

[Severity: Medium]
This is a pre-existing issue, but can hip04_mac_interrupt() run before
priv->napi is initialized?

hip04_mac_probe() calls devm_request_irq() before netif_napi_add(), with
of_phy_connect() (which can sleep) in between. Nothing in probe masks
PPE_INTEN or acks PPE_RINT beforehand.

The previous owner may have left the PPE interrupt enabled with RCV_INT
pending. One example is kexec from a kernel with the port up, since the
driver has no .shutdown. In that case:

hip04_mac_interrupt()
  napi_schedule_prep(&priv->napi)   <- zeroed state, returns true
  __napi_schedule(&priv->napi)
    net_rx_action()
      __napi_poll()                 <- napi->poll is NULL

Whether the PPE state survives that handoff depends on the hardware.

[ ... ]

> @@ -1021,7 +1021,6 @@ static int hip04_mac_probe(struct platform_device *pdev)
>  	hip04_free_ring(ndev, d);
>  init_fail:
>  	of_node_put(priv->phy_node);
> -	free_netdev(ndev);
>  	return ret;
>  }
>  

[Severity: High]
This is a pre-existing issue, but does this error path leave the PHY
attached to a netdev that is about to be freed?

Suppose of_phy_connect() succeeds earlier in hip04_mac_probe(), and then
hip04_alloc_ring() or register_netdev() fails. The alloc_fail and
init_fail labels never call phy_disconnect(priv->phy).

phy_attach_direct() set phydev->attached_dev = ndev, took device and
module references, and resumed the PHY. Once devres frees ndev (or
free_netdev() did, before this patch), attached_dev is left dangling.

On a later system suspend:

mdio_bus_phy_suspend()
  mdio_bus_phy_may_suspend()
    netdev->ethtool->wol_enabled   <- netdev has been freed

The MDIO bus and PHY driver module references also leak. A later bind
of this MAC would then fail in phy_attach_direct() with -EBUSY, because
the PHY is still attached.

> @@ -1038,7 +1037,6 @@ static void hip04_remove(struct platform_device *pdev)
>  	unregister_netdev(ndev);

[Severity: Critical]
This fixes the order of the managed IRQ release and the netdev free. Can
a late interrupt still reach freed memory in hip04_remove() through the
rings, though? The start of the function is unchanged:

hip04_remove() {
	if (priv->phy)
		phy_disconnect(priv->phy);

	hip04_free_ring(ndev, d);
	unregister_netdev(ndev);
	...
}

When the interface is up, hip04_free_ring() frees every rx_buf[] frag,
every pending tx_skb[] and the coherent tx_desc ring. It does not clear
those pointers or unmap rx_phys[].

At that point the MAC, PPE_INTEN, NAPI and the IRQ are all still live.
They are only quiesced by ndo_stop inside unregister_netdev().

In that window, an RX interrupt or the tx_coalesce_timer can still do:

hip04_mac_interrupt()
  napi_schedule_prep(&priv->napi)
  __napi_schedule()
    hip04_rx_poll()
      hip04_tx_reclaim()     <- reads the freed tx_desc
      build_skb(buf, ...)    <- buf is a freed rx_buf[] frag

The hardware can also keep DMAing into the freed RX pages.

After that, unregister_netdev()->dev_close()->hip04_mac_stop() calls
hip04_tx_reclaim(ndev, true). Does this double free the skb for every
TX slot that was not yet reclaimed?

hip04_tx_reclaim() {
	...
		desc = &priv->tx_desc[tx_tail];
		if (desc->send_addr != 0) {
			if (force)
				desc->send_addr = 0;
	...
		bytes_compl += priv->tx_skb[tx_tail]->len;
		dev_kfree_skb(priv->tx_skb[tx_tail]);
	...
}

By then tx_desc has already been released by dma_free_coherent(). The
tx_skb[] entries have already been freed by dev_kfree_skb_any() in
hip04_free_ring(), but they were left non-NULL.

hip04_mac_stop() also calls dma_unmap_single(..., DMA_FROM_DEVICE) on
all the freed RX buffers. On non-coherent ARM, that invalidates cache
lines of pages that may already have been reused.

hip04_mac_stop() also calls phy_stop() on a PHY that phy_disconnect()
already halted, because priv->phy is not cleared. That triggers the
"called from state HALTED" warning.

This is tagged for stable as a fix for late interrupts reaching freed
memory in hip04_remove(). Would it make sense to call unregister_netdev()
first, so ndo_stop quiesces the hardware and NAPI, and only then do
phy_disconnect(), hip04_free_ring() and the rest?

>  	of_node_put(priv->phy_node);
>  	cancel_work_sync(&priv->tx_timeout_task);
> -	free_netdev(ndev);
>  }
>  

[Severity: High]
This is a pre-existing issue, but does the cancel_work_sync() here come
too late to protect against hip04_tx_timeout_task()?

hip04_tx_timeout_task() {
	...
	hip04_mac_stop(priv->ndev);
	hip04_mac_open(priv->ndev);
}

The work runs the ndo_stop and ndo_open logic without rtnl_lock() and
without a netif_running() check. Nothing in ndo_stop cancels it.

Suppose a TX watchdog timeout queued the work, and the work reaches
napi_disable() after ndo_stop has already disabled NAPI. That ndo_stop
can come from unregister_netdev() or from a plain ifdown.
napi_disable() takes netdev_lock(), and napi_disable_locked() then
waits forever:

napi_disable_locked() {
	...
		while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
			usleep_range(20, 200);
			val = READ_ONCE(n->state);
		}
	...
}

Those bits stay set on a disabled NAPI until napi_enable() is called.
The kworker then holds netdev->lock indefinitely. Either
unregister_netdevice_many_notify() blocks on netdev_lock(dev) with RTNL
held, or hip04_remove() blocks in cancel_work_sync().

The same work can also run between hip04_free_ring() and
unregister_netdev(). In that case hip04_mac_open() calls
dma_map_single() on the freed rx_buf[] entries.

Could the work be cancelled from ndo_stop, or serialized with
rtnl_lock() and a netif_running() check?

[Severity: Medium]
This is a pre-existing issue, but should priv->tx_coalesce_timer be
cancelled on this path as well?

The timer is embedded in the netdev private area. It is armed from
hip04_mac_start_xmit() and from the done: tail of hip04_rx_poll(), which
can run after napi_complete_done():

hip04_rx_poll() {
	...
	napi_complete_done(napi, rx);
done:
	/* start a new timer if necessary */
	if (rx < budget && tx_remaining)
		hip04_start_tx_timer(priv);
	...
}

Neither hip04_mac_stop() nor hip04_remove() calls hrtimer_cancel() on
it.

If the timer expires after devres frees the netdev, tx_done() does
container_of() on priv and napi_schedule_prep(&priv->napi). Both of
those touch freed memory.

The timer expires after 100-200us, and the netdev is freed well after
that. So this only happens if the timer is delayed past the whole
teardown.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927144741.1320558-1-yaojiale02%40163.com
