Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB99352FE41;
	Wed, 14 Oct 2026 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987779; cv=none; b=AP6JAN8bPrX0zUFM98Px2MZyr1iEdjR8H0+ieyTG8CgbAUxwfB+4vLcmDYIWmM+VR5rHU20XP4uIDgD050cBfzQan38TlZC4dfFEXiilnL06u5irIbo+kqEcU6rF03XCqJiPK9yjcGa9d7FuwlctlW5wWixNRm+KLYlWxU1PA78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987779; c=relaxed/simple;
	bh=G9DuwNGdgQmBS7rpZ5wCxz7aLuHLdoEg7BZzkdlkX3c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sjH8nF4USaKI5IRYe0Vgni14FuliKIkdhTVNLoUfqgvhPa9XJMKstSfjeZgwHHLMzljwWPpTvGLCuPzx0p4eNteGphijj+iTr5o7auvCSQOxxngRILTJHJSYrRsCOus7kdN93tbdjLZ2G2v839eXXwN4KoDMXZ5oKDVefDH00Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjaP9bAn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjaP9bAn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8661F000C5;
	Wed, 14 Oct 2026 14:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791987778;
	bh=nqDhNaCaYN5Lbqat6gXP1hdZzlS+QRvAgAFIo+ofINY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FjaP9bAnc0qtBn6N2czefnIpu4ezUFw6+Z6jei1oXbXSScbQYOXuGeyF4X+9rTla1
	 aF+ng+JU1D1U8YC9ay0OYVdwVmde/XCyCTvCvC+cTwoFVnTzKBUMdXs+BvX+q1NQ2+
	 IvoDSlU99quXfYeO7T1jOtTx8nSgvYELOvlHPRbM9p9TFvooKEbFH5NCNEjzZkAMfl
	 odrAdL+9rQ0UzdoScPGMEwkhVWfJihJRocRQZKamWPzb4svrkQ+c3bW+u+3vTcmsBG
	 OwqhmRKx+oyL2ssirkVzzwF2oOSBaQm6sqaxCfuGNgb0KDEHKX6wwfodEpCIwjQ11M
	 u4yn+AwWqRC4A==
Subject:
 Re: [PATCH net-next v5 7/8] net: bcmgenet: allow the MTU to be changed
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com, f.fainelli@gmail.com
Date: Wed, 14 Oct 2026 14:22:57 +0000
Message-ID: <179198777717.434549.10480959692013383148@kernel.org>
In-Reply-To: <20261013-nb-genet-mtu-nn-v2-v5-7-076b6fc240be@tipi-net.de>
References: <20261013-nb-genet-mtu-nn-v2-v5-7-076b6fc240be@tipi-net.de>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On a running interface, bcmgenet_change_mtu() silently resets
  the user's TX interrupt coalescing (ethtool -C tx-frames) to 1.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is High
  severity.
- [Medium] This problem wasn't introduced by this patch.

--

net: bcmgenet: allow the MTU to be changed

This commit sets dev->max_mtu for GENET v2+ from the packet ready threshold
and the page size. It also adds ndo_change_mtu, which resizes the buffers
and rewrites the MTU registers in place while the PHY stays up. A new
datapath_up flag tracks whether the rings exist, and a failed allocation
retries at the old MTU and closes the interface if that also fails.

Link: https://github.com/raspberrypi/linux/issues/5561

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index e00661b2414b9..9f28006957d4d 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -3870,6 +3885,91 @@ static int bcmgenet_change_carrier(struct net_device *dev, bool new_carrier)
>  	return 0;
>  }
>  
> +static int bcmgenet_change_mtu(struct net_device *dev, int new_mtu)
> +{

[ ... ]

> +	/* Only the buffers and the MTU registers change, leave the PHY up.
> +	 * Hold its lock meanwhile, a link event would otherwise take the MAC
> +	 * out of reset and enable it mid rewrite.
> +	 */
> +	mutex_lock(&dev->phydev->lock);
> +	bcmgenet_netif_stop(dev, false);

[Severity: Medium]
This is a pre-existing issue that this patch did not introduce, but this
patch adds a new caller that reaches it.

bcmgenet_netif_stop() drops the return value of bcmgenet_dma_teardown()
and then frees the RX pages anyway:

bcmgenet_netif_stop()
    bcmgenet_dma_teardown(priv);   /* -ETIMEDOUT ignored */
    ...
    bcmgenet_fini_dma(priv)
        bcmgenet_free_rx_buffers(priv);
        bcmgenet_destroy_rx_page_pools(priv);

Suppose bcmgenet_rdma_disable() times out because DMA_STATUS never
acknowledges the disable. Could the RDMA engine then keep writing into
pages that have already gone back to the page pool?

The later bcmgenet_init_dma() failure and netif_close() in
bcmgenet_change_mtu() would only notice the stuck DMA after the pages are
already freed.

bcmgenet_close() reaches the same path today. Nothing in the tree shows
RDMA actually failing to halt, so this may only be theoretical.

> +	priv->datapath_up = false;
> +
> +	WRITE_ONCE(dev->mtu, new_mtu);
> +	priv->rx_buf_len = bcmgenet_rx_buf_len(new_mtu);
> +	bcmgenet_set_mtu_regs(priv, new_mtu);
> +
> +	ret = bcmgenet_init_dma(priv, true);

[Severity: Medium]
Does this restart lose the user's TX interrupt coalescing setting?

bcmgenet_set_coalesce() writes ec->tx_max_coalesced_frames straight into
the DMA_MBUF_DONE_THRESH register of each TDMA ring and keeps no software
copy. bcmgenet_get_coalesce() reads the value back from ring 0.

This path rebuilds the TX rings with a hard-coded threshold:

bcmgenet_init_dma()
    bcmgenet_init_tx_queues()
        bcmgenet_init_tx_ring()
            bcmgenet_tdma_ring_writel(priv, index, 1, DMA_MBUF_DONE_THRESH);

bcmgenet_init_rx_coalesce() reapplies the RX coalescing, but nothing
restores the TX value.

Take "ethtool -C ethX tx-frames N" followed by an MTU change across
ETH_DATA_LEN, such as 1500 to 3000. Would ethtool -c then report
tx-frames 1?

> +	if (ret) {

[ ... ]

> @@ -4510,6 +4617,7 @@ static int bcmgenet_suspend(struct device *d)
>  	} else {
>  		/* Teardown the interface */
>  		bcmgenet_netif_stop(dev, true);
> +		priv->datapath_up = false;
>  	}
>  
>  	return 0;

[Severity: High]
This isn't a bug introduced by this patch, but datapath_up now tracks
exactly this state. Should bcmgenet_suspend() check it as well?

Suppose bcmgenet_init_dma() fails in bcmgenet_resume(). The interface
then stays netif_running() and detached:

- the earlier bcmgenet_fini_dma() has already deleted the NAPIs
- rx_cbs and tx_cbs are freed but not set to NULL
- the clock is gated

bcmgenet_resume()
	ret = bcmgenet_init_dma(priv, false);
	if (ret) {
		netdev_err(dev, "failed to initialize DMA\n");
		goto out_clk_disable;
	}
	...
out_clk_disable:
	if (priv->internal_phy)
		bcmgenet_power_down(priv, GENET_POWER_PASSIVE);
	clk_disable_unprepare(priv->clk);

On the next system suspend, bcmgenet_suspend() checks only
netif_running(dev). Both of its branches reach bcmgenet_disable_tx_napi():
the WoL branch directly, the other branch through bcmgenet_netif_stop().

The TX NAPIs were deleted with SCHED and NPSVC still set. Would
napi_disable_locked() then wait here forever?

	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		usleep_range(20, 200);
		val = READ_ONCE(n->state);
	}

If suspend ever got past that point, bcmgenet_tx_reclaim_all() would walk
the freed tx_cbs. bcmgenet_fini_dma() would also kfree() rx_cbs and tx_cbs
a second time, with the block unclocked.

bcmgenet_change_mtu() already handles this state ("A datapath left down by
a failed resume has nothing to reprogram either"). bcmgenet_suspend() only
gets the assignment, not an early return.

If the interface is closed after the failed resume, the new guard skips
bcmgenet_netif_stop(). bcmgenet_close() still calls bcmgenet_power_down()
and clk_disable_unprepare(priv->clk) unconditionally. The failed resume
already balanced the clock, so does this underflow the clock's enable and
prepare counts?

Could bcmgenet_suspend() skip the teardown when !priv->datapath_up? Could
the driver also track that the failed resume already gated the clock, so
close and suspend_noirq do not disable it again?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be%40tipi-net.de
