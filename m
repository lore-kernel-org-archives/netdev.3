Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B05B3AB5DC;
	Wed, 30 Sep 2026 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790740147; cv=none; b=SYt9Br/yo5Yol/yxXpIVT1RVpalgktZXYjDycBqsH9SDWlorK6jynKJphT3yyUJpKgOJLrM9ygeQ3bZokAOFoK/GWgIilEKUGjcKYWbDIo1i3G7CV6Sp6kzKSGPuj1ejg99mFrwXeF3Rl3aNSf1LtBJpAynWRRoyxyYiYSvZ/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790740147; c=relaxed/simple;
	bh=j1iZTp+a/Z5k5TJm+boQtlcU0YG8jQ+F70tUecQ1lHQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SE5cPRybZvrjdjxMMqtbsoF1qwfYDwrGfEy/eiCH4b6SU0w5HFrSoD1DV8drP+8FE98nTJ4jh3w5mVCZTlxwwkYQMDf3SLQmX9x5FUYNjpIOEcKTL8LgBYyjsCFdQMfFmjw81FrOaz8x/KqO4GQ+iz0Eb85ZQ2eBwuvfD0H2Nlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciwyGXRf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciwyGXRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2793D1F00893;
	Wed, 30 Sep 2026 03:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790740145;
	bh=vmHZ769VMYvb2r3RD5dmx8AblNeG5aUw8nvgPh4u/Oc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ciwyGXRf90Zy5dh40YLg+vWMcdJIzJgOVRt7128HHReJXVxDVxVpJSWk5PFdyYNv4
	 KW2R/x3NOxna6uV48v8HzW+vXseYlqHE3oa2wjph6NOdHRYbYl0FilNn8OOERbqhRJ
	 wNgThxRM0DTiv6E7GRG8bQQefnvfM8bYez5kD3e/hkoPykaI9kOSU7HVurKZiO+0Go
	 wFqV+zvN8ehDuWNesrD6mneKj+tyHGi7HrzFn4ZOWNF94wxiZV0fP0avfe40TRcP6e
	 RqwWzGH3W0+BCAPREAgX7pfF0EvNNHiB5atdiCjtSGQP8/Eb7To/97f0ceRHAI+x/n
	 R5k6RFQG2czww==
Subject: Re: [PATCH v2 7/7] net: sxgbe: manage IRQ data lifetimes with devres
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
Date: Wed, 30 Sep 2026 03:49:02 +0000
Message-ID: <179074014271.434549.8202452038518263464@kernel.org>
In-Reply-To: <20260927144741.1320558-8-yaojiale02@163.com>
References: <20260927144741.1320558-8-yaojiale02@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch closes the remove-time IRQ use-after-free for only two
  objects: the netdev and priv->hw.
- [High] The device is never quiesced before the remove window the commit
  claims to close.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  sxgbe_release() calls timer_delete_sync(&priv->eee_ctrl_timer) (line…
- [Medium] This problem wasn't introduced by this patch, but
  init_tx_ring() allocates tx_skbuff_dma and tx_skbuff with…

--

net: sxgbe: manage IRQ data lifetimes with devres

This commit switches the netdev and priv->hw allocations in
sxgbe_drv_probe() to devres, so they are freed after the managed IRQs.
It removes the matching kfree()/free_netdev() calls from the probe error
path and from sxgbe_drv_remove().

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

[Severity: High]
This isn't a bug introduced by this patch, but eee_ctrl_timer lives in the
netdev private area and can still be pending when that memory is freed.
After this patch the free happens in devm_free_netdev() instead of
free_netdev().

sxgbe_release() deletes the timer before it disables NAPI:

    if (priv->eee_enabled)
        timer_delete_sync(&priv->eee_ctrl_timer);
    ...
    napi_disable(&priv->napi);

The RX/TX interrupts are still enabled between those two calls, so
sxgbe_poll()->sxgbe_tx_all_clean() can re-arm the timer:

    if ((priv->eee_enabled) && (!priv->tx_path_in_lpi_mode)) {
        sxgbe_enable_eee_mode(priv);
        mod_timer(&priv->eee_ctrl_timer, SXGBE_LPI_TIMER(eee_timer));
    }

The phy_stop()/phy_disconnect() calls in between make the window wider.

sxgbe_eee_ctrl_timer() re-arms itself every time it runs. Nothing in
sxgbe_drv_remove() or devres deletes the timer again.

Can the timer fire on freed memory after unbind? Until unbind, it also keeps
calling sxgbe_enable_eee_mode(), which touches MMIO after
clk_disable_unprepare() in sxgbe_release().

>  	if (!ndev)
>  		return NULL;
>  

[ ... ]

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
Does this close the window described in the commit message ("an interrupt
in that window can access freed memory")? The netdev and priv->hw are now
freed after the devres IRQ release. However, the IRQs are still only
released at unbind.

sxgbe_open() requests every line with devres:

    ret = devm_request_irq(priv->device, priv->irq, sxgbe_common_interrupt,
                           IRQF_SHARED, dev->name, dev);
    ...
    ret = devm_request_irq(priv->device,
                           (priv->txq[queue_num])->irq_no,
                           sxgbe_tx_interrupt, 0,
                           dev->name, priv->txq[queue_num]);

Nothing in sxgbe_release() calls free_irq(), devm_free_irq() or
synchronize_irq(). So the handlers are still live when sxgbe_drv_remove()
tears down the rings:

sxgbe_drv_remove()
  unregister_netdev()
    sxgbe_release()
      priv->hw->dma->stop_tx()
      free_dma_desc_resources()

stop_tx() raises TPS because TSE is part of SXGBE_DMA_ENA_INT.
sxgbe_tx_dma_int_status() reports TPS as tx_hard_error, so
sxgbe_tx_interrupt() calls sxgbe_restart_tx_queue():

    /* free the skbuffs of the ring */
    tx_free_ring_skbufs(tx_ring);
    ...
    priv->hw->dma->start_tx_queue(priv->ioaddr, queue_num);

No lock separates tx_free_ring_skbufs() from
free_dma_desc_resources()->dma_free_tx_skbufs(). Can both of them call
dev_kfree_skb_any() on the same tx_skbuff[i]?

Now suppose the interrupt lands right after stop_tx(). Can start_tx_queue()
re-enable a channel whose descriptor ring free_dma_desc_resources() frees
next? The device would then DMA to freed coherent memory.

The devm IRQs also survive ifdown. A second ifup runs init_tx_ring() again
and allocates new devm tx_skbuff and tx_skbuff_dma arrays. These are newer
than the TX IRQ devres entries from the first open, so devres frees them
before those IRQs at unbind.

On that second open, devm_request_irq() on the non-shared TX/RX lines would
fail with -EBUSY. Each attempt also adds another shared common/LPI handler.

Would request_irq() in sxgbe_open() and free_irq() in sxgbe_release(),
before the rings are freed, be a more direct fix? It would also cover the
netdev and priv->hw window this patch targets, because unregister_netdev()
would free the IRQs before sxgbe_drv_remove() frees anything.

[Severity: High]
Related to the above, the device interrupt sources are never masked during
teardown. sxgbe_dma_channel_init() arms every channel:

    writel(SXGBE_DMA_ENA_INT,
           ioaddr + SXGBE_DMA_CHA_INT_ENABLE_REG(cha_num));

Neither sxgbe_release() nor sxgbe_drv_remove() clears these enables or the
MAC core interrupt sources. Only the RX ISR and NAPI toggle them, through
disable_dma_irq/enable_dma_irq.

So the stop_tx() calls in sxgbe_drv_remove() and sxgbe_release() trigger
the TPS interrupt themselves. sxgbe_restart_tx_queue() then sets
SXGBE_TX_ENABLE again, while the channel's descriptor base and tail
registers still point at the ring that free_dma_desc_resources() frees.

Could the device then fetch descriptors from, and write status back to,
freed coherent memory?

After sxgbe_release() calls clk_disable_unprepare(priv->sxgbe_clk), the
handlers are still registered and read status registers on the gated
block. sxgbe_common_interrupt() is on IRQF_SHARED lines, so another device
on the same line can invoke it.

This patch keeps netdev, hw and ioaddr alive, so these accesses become real
MMIO instead of freed-pointer dereferences. Is anything stopping them?

Should ndo_stop mask the per-channel and MAC interrupt enables, and free or
synchronize the IRQs, before it stops DMA, gates the clock and frees the
rings?

[Severity: Medium]
This is a pre-existing issue, but init_tx_ring() allocates tx_skbuff_dma
and tx_skbuff with devm_kcalloc() on every ndo_open:

    tx_ring->tx_skbuff_dma = devm_kcalloc(dev, tx_rsize,
                                          sizeof(dma_addr_t), GFP_KERNEL);
    ...
    tx_ring->tx_skbuff = devm_kcalloc(dev, tx_rsize,
                                      sizeof(struct sk_buff *), GFP_KERNEL);

free_tx_ring() only frees the coherent descriptors. Do these arrays pile up
on each ifup until unbind?

The devm IRQs from the first open are never freed, so each later ifup fails
with -EBUSY at the TX IRQ request. Each attempt still leaks a new set of
arrays.

Separately, the irq_of_parse_and_map() mappings from sxgbe_platform_probe()
are only disposed on the probe error path. sxgbe_platform_remove() only
calls sxgbe_drv_remove(ndev). Should it also call irq_dispose_mapping() for
the common, TX, RX and LPI mappings?

>  
>  #ifdef CONFIG_PM

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927144741.1320558-1-yaojiale02%40163.com
