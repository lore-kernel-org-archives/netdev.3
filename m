Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D8347532;
	Thu,  1 Oct 2026 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862142; cv=none; b=iwsQ4lW8kIat1RT8eox9Gu9hfEMOa+cCZOsPRNlSrxj4JysTuqkXl4fb9TzFRyY0AOcbkndFMcg+3OvxXINQE5WcpXbTA5l3xWqqJmzUFbXfDhRaPaWUwBAAG4YelKJs9Y9QYV3e7jHTcgK+4Cx9cShGCm0AVCvizMupevXue3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862142; c=relaxed/simple;
	bh=xTvqhlC0vWHadfBolT6DIBZzHferUJQGFofzPWnwWFM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dMIiEQnp+xhN+zIupvlQS0Y8oOAaIJC/2L1f9p28OzZZyFf5/Zh1Ln48OsExYXR0TIx3Ks9M6fktqW40JE5wDt9TYbtTx0alS50koWGh28V32BmzlxApfnwY6gRzEr3YxSe3D/PxcEyC0O3brkuqzKUBKsNc5EjlVpaNiXHAjW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwnOcRNQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwnOcRNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389681F000FF;
	Thu,  1 Oct 2026 13:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862134;
	bh=IGGBHyyJMEIZSeMtev9OcIPuY+uZ9tEY5AayddBTGkk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bwnOcRNQhZccldHp7pyoWXKI5/airOW8n1rIzvWj1/ne/tPHZPmaEYz4xCPZF943K
	 u+5CpLbmabuwMJNvRwhXP8VRjFqLgTh8rKfQ8+PPPhcsvckK0NSqRSIIieSsEBGOLl
	 MX8P0VaxbuGf2yocOMHQ7EKIGWWiMz/SiHGS60KKaEvVoqQsHTdtw/GyEOEbawV5RG
	 s6DeucUDMJWTimxanss7hDafIibwyUQsGWaKNz6RLPxHscGdRZWbFtpYadz5xFYWNV
	 6hQ2Rx29mPZdbjmxmgTSAzHwQCUtS6TPLahmcSADo5fgmwW/5N8YmG313/i7vpv/Uv
	 xY5HsQT4R8ndA==
Subject:
 Re: [PATCH net] net: calxeda: cancel timeout work before freeing rings
From: netdev-bot+sashiko@kernel.org
To: getshell@seu.edu.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, o-takashi@sakamocchi.jp, kees@kernel.org,
 u.kleine-koenig@baylibre.com, bhelgaas@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Date: Thu, 01 Oct 2026 13:42:13 +0000
Message-ID: <179086213377.434549.10127161045062791327@kernel.org>
In-Reply-To: <20260928134115.1957-1-getshell@seu.edu.cn>
References: <20260928134115.1957-1-getshell@seu.edu.cn>
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

Critical: 0 · High: 3 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: tx_timeout_work can be queued again after
  the new cancel_work_sync() in xgmac_stop()…
- [High] Two more paths leave the worker lifetime bug reachable.
- [High] The patch moves netif_tx_disable() before napi_disable() in
  xgmac_stop() (line 1049 vs 1052).
- [Medium] The patch removes the `if (readl(priv->base +
  XGMAC_DMA_INTR_ENA)) napi_disable()` guard and calls…

--

net: calxeda: cancel timeout work before freeing rings

This commit reorders xgmac_stop(). Transmit is now stopped and the DMA
interrupts are masked first, then tx_timeout_work is cancelled, and only
then is NAPI disabled and the rings freed. It also removes the check on
XGMAC_DMA_INTR_ENA that decided whether napi_disable() was called.

> diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
> index a2410fba6be2..63296469bd85 100644
> --- a/drivers/net/ethernet/calxeda/xgmac.c
> +++ b/drivers/net/ethernet/calxeda/xgmac.c
> @@ -1046,12 +1046,10 @@ static int xgmac_stop(struct net_device *dev)
>  {
>  	struct xgmac_priv *priv = netdev_priv(dev);
>  
> -	if (readl(priv->base + XGMAC_DMA_INTR_ENA))
> -		napi_disable(&priv->napi);
> -

[Severity: Medium]
Is it safe to drop this guard? napi_disable() now runs every time, but
xgmac_open() can fail and leave NAPI disabled:

xgmac_open() {
    ...
	xgmac_hw_init(dev);     <- writes 0 to XGMAC_DMA_INTR_ENA
    ...
	ret = xgmac_dma_desc_rings_init(dev);
	if (ret < 0)
		return ret;
    ...
	napi_enable(&priv->napi);
    ...
}

On the xgmac_change_mtu() path, xgmac_stop() has already disabled NAPI.
If xgmac_dma_desc_rings_init() then returns -ENOMEM, netif_set_mtu_ext()
returns the error and the device stays up.

The next ifdown or MTU change calls xgmac_stop() again. Would that
napi_disable() on an already disabled NAPI spin forever in
napi_disable_locked() while holding RTNL and netdev_lock?

The old readl() check saw 0 in INTR_ENA in this state and skipped the
second disable.

> -	writel(0, priv->base + XGMAC_DMA_INTR_ENA);
> -
>  	netif_tx_disable(dev);
> +	writel(0, priv->base + XGMAC_DMA_INTR_ENA);

[Severity: High]
Can XGMAC_DMA_INTR_ENA be turned back on after this write? This is the
only place xgmac_stop() masks the interrupts. Both contexts it then waits
for write the mask back.

A poll that is still running when the mask is written finishes with:

xgmac_poll() {
    ...
	if (work_done < budget) {
		napi_complete_done(napi, work_done);
		__raw_writel(DMA_INTR_DEFAULT_MASK, priv->base + XGMAC_DMA_INTR_ENA);
	}
    ...
}

With the old order, napi_disable() ran before writel(0), so a poll could
not undo the mask.

A tx_timeout_work that is already running, which cancel_work_sync() waits
for, ends with:

xgmac_tx_timeout_work() {
    ...
	netif_wake_queue(priv->dev);

	napi_enable(&priv->napi);

	/* Enable interrupts */
	writel(DMA_INTR_DEFAULT_MASK, priv->base + XGMAC_DMA_STATUS);
	writel(DMA_INTR_DEFAULT_MASK, priv->base + XGMAC_DMA_INTR_ENA);
}

An xgmac_interrupt() still running on another CPU can also write
DMA_INTR_ABNORMAL to INTR_ENA, or call schedule_work() itself. There is no
synchronize_irq() in xgmac_stop().

Both masks include DMA_INTR_ENA_TSE. xgmac_mac_disable() then clears
DMA_CONTROL_ST, which stops the TX process and latches DMA_STATUS_TPS.
The IRQ is still registered, so:

xgmac_interrupt()
	if (intr_status & DMA_STATUS_TPS) {
		...
		schedule_work(&priv->tx_timeout_work);
	}

This queues the work again after the cancel, just before
xgmac_free_dma_desc_rings() frees the rings.

The late worker calls napi_disable() on the NAPI that xgmac_stop() has
just disabled. napi_disable_locked() then waits forever for
NAPIF_STATE_SCHED and NAPIF_STATE_NPSVC to clear, and it holds
netdev_lock the whole time. After that, xgmac_open()->napi_enable()
blocks under RTNL.

If the interface stays down and the device is removed, the pending work
can also outlive priv. See the comment on cancel_work_sync() below.

Would this need the interrupts masked, synchronize_irq(), NAPI disabled
and the mask written again before the work is cancelled or disabled with
disable_work_sync()?

> +	cancel_work_sync(&priv->tx_timeout_work);

[Severity: High]
Can the watchdog queue tx_timeout_work again after this cancel?
xgmac_change_mtu() calls stop and open directly on a running device:

xgmac_change_mtu() {
    ...
	/* Bring interface down, change mtu and bring interface back up */
	xgmac_stop(dev);
	WRITE_ONCE(dev->mtu, new_mtu);
	return xgmac_open(dev);
}

This path skips dev_deactivate_many(). The dev_watchdog() timer stays
armed, netif_running() stays true, and the carrier stays on.
netif_tx_disable() stops the queue but does not refresh trans_start.

If TX has been idle for longer than watchdog_timeo (5*HZ here, because the
driver doesn't set it), this can run between cancel_work_sync() and the
end of xgmac_open():

dev_watchdog()->xgmac_tx_timeout()->schedule_work(&priv->tx_timeout_work)

The late worker either hangs in napi_disable() on the NAPI that
xgmac_stop() disabled, or races with the napi_disable() in xgmac_stop().
Both cases end in the same netdev_lock/RTNL deadlock.

Separately, xgmac_remove() never cancels or disables tx_timeout_work:

xgmac_remove() {
    ...
	unregister_netdev(ndev);
	netif_napi_del(&priv->napi);
    ...
	free_netdev(ndev);
}

netif_close_many() skips ndo_stop for a device that is already down. Work
queued after the last xgmac_stop(), from the watchdog or from the TPS
path above, can therefore still be pending when free_netdev() frees priv.
priv embeds the work_struct.

Should xgmac_remove() also do a final cancel_work_sync() or
disable_work_sync()?

> +	napi_disable(&priv->napi);

[Severity: High]
netif_tx_disable() now runs before napi_disable(). Can a poll that runs
in between wake the queue again? That poll goes through:

xgmac_poll()->xgmac_tx_complete() {
    ...
	if (unlikely(netif_queue_stopped(priv->dev) &&
	    (tx_dma_ring_space(priv) > MAX_SKB_FRAGS)))
		netif_wake_queue(priv->dev);
}

xgmac_tx_timeout_work(), which cancel_work_sync() waits for, also calls
netif_wake_queue(). Nothing later in xgmac_stop() stops the queue again.

When xgmac_stop() is called from xgmac_change_mtu(), the device is still
running and the qdisc is still active. After the wake, xgmac_xmit() can
run on another CPU while xgmac_free_dma_desc_rings() frees priv->dma_tx
and priv->tx_skbuff, or after it has set them to NULL.

Would this lead to a use-after-free or a NULL dereference at
priv->tx_skbuff[entry] = skb in xgmac_xmit()? It would also write
XGMAC_DMA_TX_POLL to start DMA on freed descriptors.

With the old order, napi_disable() ran before netif_tx_disable(), so a
poll could not wake the queue here.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928134115.1957-1-getshell%40seu.edu.cn
