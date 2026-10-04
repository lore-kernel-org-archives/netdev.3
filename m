Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8393B418342;
	Sun,  4 Oct 2026 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791104594; cv=none; b=coscG5CYof/17DLbKhA1qvumHZ48+AH6Udj0x8C/hCYDc1FRB2DHphDwQbzLaFwQ9f79Mi5X3Pu5ZSPwf937m7UyhOx8ZtSictbDqCP8IyzkKeynAGK15TsKSDTZVKrwjb2TJEz+XW8EUetJ4vyjngQNEliaBRTu2/PH7BqT6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791104594; c=relaxed/simple;
	bh=UiqMAjyp10FHl+89HZ71lBqlz5fX8fQd7q8QEgeWWP8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lcyG5CKCA8Iv0RJMi9GnWdQgtJMzgQ2QQG8SYSMz0Z5GjlG0ksb59uss522GSl0AzhaJ8ilHXAssOg/2RWLCsnxyzNf65g9ajO+ZfcTQS0ClLqr1UppjI2zQHqMfRjODIA5fpFZUJOfqSJ2MDBJ348giysqo52rmnrSiUeys8uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieQXcmZC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieQXcmZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D0B1F000FF;
	Sun,  4 Oct 2026 09:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791104592;
	bh=1csFcv/zpdL1/3QwbyMxAX3rqrDvcTCz439BrEOVy5U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ieQXcmZCAl0ggJfCcKBLG+qyUQro0U7XDR/gmIOrPR4IZgaXLCic5SAJzZzlb55gY
	 TC30DiSej/PpYUKCnDJ6nalpuXy+QrABiW+4VfkNTpqeqCj6C8McGnmLoQHDIVtY1m
	 MVZ/mek5SxgYyXpFwdh0mW9jnrz+fU8uB8oY5sUAp/8/3jurInGnbMVPj90vS9Z6YS
	 1yAwbxwUB9aH2NVHXF/gXjrcNZmGxHScG2xs+5bQkmaUtyd1asLkAzOtsIqwUCyd9M
	 NiByJLnT5c9Z1lbH/Is/uv+b00OCVMAcXJNvjDPtI6J9bDxC/9zDbwbKV5rPa+ljmj
	 f0hHnGiTGgeAQ==
Subject:
 Re: [PATCH net v3 7/7] net: sxgbe: manage IRQ data lifetimes with devres
From: netdev-bot+sashiko@kernel.org
To: yaojiale02@163.com
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
 shenjian15@huawei.com, shaojijie@huawei.com, niklas.soderlund@ragnatech.se,
 paul@pbarker.dev, bh74.an@samsung.com, linux@armlinux.org.uk,
 soren.brinkmann@xilinx.com, nicolas.ferre@microchip.com,
 fabio.estevam@freescale.com, arnd@arndb.de, dingtianhong@huawei.com,
 zhangfei.gao@linaro.org, xuejiancheng@hisilicon.com, lidongpo@hisilicon.com,
 s.shtylyov@omp.ru, claudiu.beznea.uj@bp.renesas.com, vipul.pandya@samsung.com,
 siva.kallam@samsung.com, ks.giri@samsung.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org
Date: Sun, 04 Oct 2026 09:03:10 +0000
Message-ID: <179110459004.434549.4831686330572550768@kernel.org>
In-Reply-To: <20261003085940.493951-8-yaojiale02@163.com>
References: <20261003085940.493951-8-yaojiale02@163.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (2) · Medium: 0 (2) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix does not close the bug class its commit message
  describes: IRQ handlers can still run against freed memory in the…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but any re-open of
  the interface fails, and the MTU-change path can then wedge rtnl.
- [High] This problem wasn't introduced by this patch, but the EEE
  control timer can be re-armed after sxgbe_release() cancels it, and…
- [Medium] This problem wasn't introduced by this patch, but
  sxgbe_platform_probe() only allocates plat_dat when pdev->dev.of_node…
- [Medium] This problem wasn't introduced by this patch, but
  sxgbe_drv_probe() calls register_netdev(), which makes the interface…
- [Low] This problem wasn't introduced by this patch, but init_tx_ring()
  allocates tx_ring->tx_skbuff_dma and tx_ring->tx_skbuff with…

--

net: sxgbe: manage IRQ data lifetimes with devres

This commit switches the netdev and priv->hw allocations in the sxgbe
driver to devres. They are then released after the devm-managed IRQs
requested in sxgbe_open(). The goal is to close a window where an
interrupt arriving after sxgbe_drv_remove() could dereference freed
memory.

> diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> index 70cf3619555f9..ada851477302e 100644
> --- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> +++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c

[ ... ]

> @@ -2069,8 +2069,8 @@ struct sxgbe_priv_data *sxgbe_drv_probe(struct device *device,
>  	int ret;
>  	u8 queue_num;
>  
> -	ndev = alloc_etherdev_mqs(sizeof(struct sxgbe_priv_data),
> -				  SXGBE_TX_QUEUES, SXGBE_RX_QUEUES);
> +	ndev = devm_alloc_etherdev_mqs(device, sizeof(struct sxgbe_priv_data),
> +				       SXGBE_TX_QUEUES, SXGBE_RX_QUEUES);
>  	if (!ndev)
>  		return NULL;
>  

[Severity: Medium]
This isn't a bug introduced by this patch, but can priv->plat be NULL
in sxgbe_drv_probe()?

sxgbe_platform_probe() only allocates plat_dat when pdev->dev.of_node is
set, but it always passes plat_dat to sxgbe_drv_probe():

	priv = sxgbe_drv_probe(&(pdev->dev), plat_dat, addr);

If a platform device without an OF node gets bound, either by name
("sam_sxgbeeth") or through driver_override, sxgbe_drv_probe()
dereferences the NULL pointer here:

	if (!priv->plat->riwt_off) {

[ ... ]

> @@ -2191,11 +2191,7 @@ struct sxgbe_priv_data *sxgbe_drv_probe(struct device *device,
>  	clk_put(priv->sxgbe_clk);
>  error_napi_del:
>  	netif_napi_del(&priv->napi);
> -error_free_hw:
> -	kfree(priv->hw);
> -error_free_netdev:
> -	free_netdev(ndev);
> -
> +error_return:
>  	return NULL;
>  }

[Severity: Medium]
This is a pre-existing issue, but is the netdev published before its
IRQ numbers are set?

sxgbe_drv_probe() calls register_netdev() and returns. Only after that
does sxgbe_platform_probe() fill in the IRQ numbers:

	priv = sxgbe_drv_probe(&(pdev->dev), plat_dat, addr);
	...
	priv->irq  = irq_of_parse_and_map(node, 0);

The txq/rxq structures come from devm_kmalloc() and are not zeroed. If
udev or NetworkManager calls dev_open() in that window, sxgbe_open()
runs with priv->irq == 0, or with uninitialized txq[i]->irq_no and
rxq[i]->irq_no values.

> @@ -2229,10 +2225,6 @@ void sxgbe_drv_remove(struct net_device *ndev)
>  	clk_put(priv->sxgbe_clk);
>  
>  	netif_napi_del(&priv->napi);
> -
> -	kfree(priv->hw);
> -
> -	free_netdev(ndev);
>  }

[Severity: High]
Does this fully close the window described in the commit message? The
netdev and priv->hw now outlive the IRQs. However, the IRQs themselves
stay live after the interface is closed.

sxgbe_open() requests the common, LPI, per-TX and per-RX IRQs with
devm_request_irq(priv->device, ...). Neither sxgbe_release() nor the
sxgbe_open() error path frees, masks or synchronizes them.

unregister_netdev() in sxgbe_drv_remove() runs sxgbe_release(), which
does:

	priv->hw->dma->stop_tx(priv->ioaddr, SXGBE_TX_QUEUES);
	...
	free_dma_desc_resources(priv);
	...
	clk_disable_unprepare(priv->sxgbe_clk);

It never writes SXGBE_DMA_CHA_INT_ENABLE_REG and never frees the IRQs.
The handlers stay registered until devres teardown after remove
returns. The same state exists after every ifdown and every
sxgbe_change_mtu().

In that window, sxgbe_tx_interrupt() has no interface-up check:

	if (unlikely((status & tx_hard_error)))
		sxgbe_restart_tx_queue(priv, txq->queue_no);

and sxgbe_restart_tx_queue() does:

	tx_free_ring_skbufs(tx_ring);
	...
	priv->hw->dma->start_tx_queue(priv->ioaddr, queue_num);
	...
	netif_tx_wake_queue(dev_txq);

Can tx_free_ring_skbufs() race with dma_free_tx_skbufs() and
free_tx_ring() in close? That could unmap and free the same skbs twice,
or read freed dma_tx descriptors through get_tx_len().

Can start_tx_queue() set SXGBE_TX_ENABLE again on a channel whose
descriptor base still points at the ring freed with
dma_free_coherent()? The device could then DMA into reallocated memory.

The trigger might not need a stray error. SXGBE_DMA_ENA_INT includes
SXGBE_DMA_INT_ENA_TSE, and sxgbe_tx_dma_int_status() maps
SXGBE_DMA_INT_STATUS_TPS to tx_hard_error. If the hardware sets TPS on
a software stop, the stop_tx() calls in sxgbe_drv_remove() and
sxgbe_release() could raise the very interrupt that restarts TX DMA.
That hardware behaviour can't be confirmed from the code alone.

All three handlers also access CSRs through priv->ioaddr after
clk_disable_unprepare(). The common and LPI lines are IRQF_SHARED. So
another device on the line, or the extra CONFIG_DEBUG_SHIRQ call in
free_irq() during devres teardown, can run them while the clock is
gated.

Would it be better to mask the channel interrupts and free the IRQs in
ndo_stop, before freeing the rings and gating the clock? This could use
request_irq()/free_irq() or devm_free_irq(). That alone would also fix
the netdev/priv->hw use-after-free, so it would replace the devres
ordering here rather than build on it.

[Severity: High]
This isn't a bug introduced by this patch, but can the EEE control
timer still be armed when devres frees the netdev that contains it?

sxgbe_release() cancels the timer first. It then calls phy_stop() and
phy_disconnect(), which can sleep, and only later calls napi_disable():

	if (priv->eee_enabled)
		timer_delete_sync(&priv->eee_ctrl_timer);
	...
	napi_disable(&priv->napi);

A NAPI poll in that gap, sxgbe_poll()->sxgbe_tx_all_clean(), can re-arm
the timer:

	if ((priv->eee_enabled) && (!priv->tx_path_in_lpi_mode)) {
		sxgbe_enable_eee_mode(priv);
		mod_timer(&priv->eee_ctrl_timer, SXGBE_LPI_TIMER(eee_timer));
	}

sxgbe_eee_ctrl_timer() re-arms itself on every expiry, and nothing on
the close or remove path deletes it again.

After close, the timer writes MAC registers with the clock gated. After
remove, the timer_list sits in netdev private memory that devres has
freed, so the next expiry is a use-after-free. After module unload, it
runs freed module text.

[Severity: High]
This is a pre-existing issue, but does every re-open of the interface
fail because the IRQs from the previous sxgbe_open() are never freed?

Consider a second sxgbe_open(), from ifdown/ifup or from
sxgbe_change_mtu() on a running interface (which calls sxgbe_release()
and then sxgbe_open()):

- The IRQF_SHARED common and LPI requests succeed and add duplicate
  actions with the same dev_id.

- The first per-TX-queue request is exclusive (flags 0). It fails with
  -EBUSY in __setup_irq() because the earlier action is still
  installed:

	ret = devm_request_irq(priv->device,
			       (priv->txq[queue_num])->irq_no,
			       sxgbe_tx_interrupt, 0,
			       dev->name, priv->txq[queue_num]);

- init_error frees the rings, disconnects the PHY and disables the
  clock. The duplicate shared actions are left in place.

After an MTU change on a running interface, the device stays IFF_UP
with NAPI disabled and the rings freed. A later ifdown, or
unregister_netdev() in sxgbe_drv_remove(), runs sxgbe_release() again.

Would that second napi_disable() spin forever in napi_disable_locked()
while rtnl is held, since NAPIF_STATE_SCHED is already set? Even if it
returned, free_dma_desc_resources() would free the coherent rings and
the rx_skbuff arrays a second time.

[Severity: Low]
This isn't a bug introduced by this patch, but init_tx_ring() allocates
tx_ring->tx_skbuff_dma and tx_ring->tx_skbuff with devm_kcalloc() on
every ndo_open:

	tx_ring->tx_skbuff_dma = devm_kcalloc(dev, tx_rsize,
					      sizeof(dma_addr_t), GFP_KERNEL);
	...
	tx_ring->tx_skbuff = devm_kcalloc(dev, tx_rsize,
					  sizeof(struct sk_buff *), GFP_KERNEL);

free_tx_ring() only releases the coherent ring:

	dma_free_coherent(dev, tx_rsize * sizeof(struct sxgbe_tx_norm_desc),
			  tx_ring->dma_tx, tx_ring->dma_tx_phy);

Does each open attempt, including the failing re-opens above, leave
another pair of arrays attached to the device until unbind?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261003085940.493951-2-yaojiale02%40163.com
