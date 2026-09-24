Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3343A7F7;
	Thu, 24 Sep 2026 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236478; cv=none; b=g6sYckQ2Iu3Y5vo8F14/PuXFjVLhE4WxoUq5SKks8TzlXskVqgxit2+4JREBOJMFGBNTFhrp00Hmmjz2QSbIziKIZXfzXnPgV+Jy0FfJ6DsxmgynCEi2gowbVItUou9pvFAbktmEWqrvzAp4fOCvaYuvae1DHwMnnqAgKb1hGbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236478; c=relaxed/simple;
	bh=KwSEeIHWCwe6qIBz/Wc6pSn+7t9vpTxTqEiSRlK8ROk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=avvCDbxduh2hMxcKuDon4nzk+dv05goo7C1izXfbZ38YcystXO8WU4DDxD+QGufmidZ5EASkfr3ObynUW7aTbWf5HqqxnoUhz8IpIBh/+TBHEXPA/2k3ZyclmnVzQwnDTZmOJKucelv8b4TKWzUGOMQIqk13BNAIHRWgcFYimQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+JiYILu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+JiYILu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84E41F00893;
	Thu, 24 Sep 2026 07:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790236476;
	bh=DxqQtbdMKwuJT3eU1eoI8vIyietxydQvJa0ahL0de9c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G+JiYILup4u3XlXmz5zYcCTrNN06DxyXMs0j68Yu26EqEX8BvLKTI7GX1AQd5sLWf
	 E1Rs4h4KVYRiQTYfpQdRXba3eP5MPRiSNbmhv1V7oegUg3aM6VTYynjeQZC8iUQ6QJ
	 ZI7oXCBlXELnVq9IVZRYlHs9auXNObuYZsADwdNdv2UvTTN6BOZwfTKjcuUJvZfOQK
	 dPkHT1i+Wo09prRwKwie4AN1GRCQTdB92YAbhNcIwursRjYk9s62tuxrWZm0RBIblI
	 QCdk6IVq729tQ8U0SACi38y77pGViuygXOJ73M2a/qnjtqjUNc8qHNlSdD7rti7bh9
	 61ejniS/sv08w==
Subject: Re: [PATCH net 2/3] net: stmmac: close the interface after a failed
 MTU reopen
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 qiangqing.zhang@nxp.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ansuelsmth@gmail.com,
 yangtiezhu@loongson.cn, chenhuacai@kernel.org, richard.genoud@bootlin.com,
 alastair@d-silva.org, mripard@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Thu, 24 Sep 2026 07:54:34 +0000
Message-ID: <179023647445.2160803.16164944289328147798@kernel.org>
In-Reply-To:
 <20260921-submit-stmmac-reset-fixes-v1-v1-2-87a4e431ee00@gmail.com>
References:
 <20260921-submit-stmmac-reset-fixes-v1-v1-2-87a4e431ee00@gmail.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 1 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The failed-MTU-reopen path leaves the MAC Rx/Tx enabled and
  all RX/TX DMA channels in RUN state while the descriptor rings and RX…
- [High] The new priv->opened state is only maintained by
  __stmmac_open()/__stmmac_release(), but the driver contains a second,…
- [High] The fix is incomplete for the sibling live-reconfiguration paths
  and makes a new inconsistent state reachable there.

--

net: stmmac: close the interface after a failed MTU reopen

The patch adds a new priv->opened flag that tracks whether the data path
was successfully opened, makes __stmmac_release() bail out when it is
clear, and calls netif_close() on the MTU reopen error path so the PHY
and runtime-PM reference are dropped. A few questions below about paths
that are not covered by the new flag.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 7582fca637419..873331dbaf772 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -281,6 +281,8 @@ struct stmmac_priv {
>  	struct mutex lock;
>  
>  	struct stmmac_dma_conf dma_conf;
> +	/* Paired __stmmac_open()/__stmmac_release(), serialized by RTNL. */
> +	bool opened;

[Severity: High]
Does the comment's pairing invariant hold for the XDP release/open pair?

stmmac_xdp_release() performs the same teardown as __stmmac_release()
(stmmac_disable_all_queues(), hrtimer_cancel() per TX queue,
stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0), stmmac_stop_all_dma(),
free_dma_desc_resources(priv, &priv->dma_conf), stmmac_mac_set(false))
but never clears priv->opened, and stmmac_xdp_open() never sets it.

stmmac_xdp_set_prog() also ignores the reopen result:

	if (if_running && need_update)
		stmmac_xdp_open(dev);

so if stmmac_xdp_open() fails in alloc_dma_desc_resources(),
init_dma_desc_rings() or stmmac_request_irq(), the netdev stays up with
NAPI disabled, IRQs freed and priv->dma_conf holding freed pointers,
while priv->opened is still true.

A later "ip link set down" then passes the new guard and runs the whole
__stmmac_release() a second time. Isn't that the same repeated teardown
the commit message describes, i.e. napi_disable() on already disabled
NAPI while holding RTNL, stmmac_free_irq() on freed IRQs and a second
dma_free_coherent()/page_pool_destroy() over the same rings?

Should stmmac_xdp_release() clear priv->opened and stmmac_xdp_open() set
it on success as well?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 1fb5f804ea234..44b59d0f56b5b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4179,6 +4179,7 @@ static int __stmmac_open(struct net_device *dev,
>  	stmmac_enable_all_queues(priv);
>  	netif_tx_start_all_queues(priv->dev);
>  	stmmac_enable_all_dma_irq(priv);
> +	priv->opened = true;
>  
>  	return 0;
>  
> @@ -4249,6 +4250,11 @@ static void __stmmac_release(struct net_device *dev)
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	u8 chan;
>  
> +	/* A failed MTU reopen has already released the data path. */
> +	if (!priv->opened)
> +		return;
> +	priv->opened = false;
> +

[Severity: High]
Can this early return also be reached from the ethtool reconfiguration
paths, where the outer resources have already been dropped?

stmmac_reinit_ringparam() and stmmac_reinit_queues() call the ndo
handlers directly while the netdev stays administratively up:

	if (netif_running(dev))
		stmmac_release(dev);

	priv->dma_conf.dma_rx_size = rx_size;
	priv->dma_conf.dma_tx_size = tx_size;

	if (netif_running(dev))
		ret = stmmac_open(dev);

stmmac_release() now clears priv->opened and its tail also runs
stmmac_legacy_serdes_power_down(), phylink_disconnect_phy() and
pm_runtime_put(). If the following stmmac_open() fails (for example in
stmmac_setup_dma_desc(), pm_runtime_resume_and_get() or
stmmac_init_phy()), the interface is left IFF_UP with priv->opened
false, no PHY attached and no runtime-PM reference, and unlike the MTU
path no netif_close() is done here.

>From that state, a later "ip link set down" reaches stmmac_release(),
__stmmac_release() returns at the new guard, and the unconditional tail
still runs:

	__stmmac_release(dev);

	stmmac_legacy_serdes_power_down(priv);
	phylink_disconnect_phy(priv->phylink);
	pm_runtime_put(priv->device);

Does the second pm_runtime_put() here produce a "Runtime PM usage count
underflow!" report?

And in the same state, an MTU change still passes netif_running(),
__stmmac_release() becomes a no-op and __stmmac_open() proceeds into
phylink_prepare_resume() and stmmac_hw_setup() register programming with
no runtime-PM reference held and no PHY connected. Since stmmac's
runtime suspend gates the bus clocks via stmmac_bus_clks_config(priv,
false), can those register accesses hit a suspended device?

>  	/* Stop and disconnect the PHY */
>  	phylink_stop(priv->phylink);
>  

[ ... ]

> @@ -6174,6 +6180,10 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
>  		if (ret) {
>  			free_dma_desc_resources(priv, dma_conf);
>  			kfree(dma_conf);
> +			/* Finish closing the PHY and PM state, but do not repeat
> +			 * the data-path teardown after the failed reopen.
> +			 */
> +			netif_close(dev);
>  			netdev_err(priv->dev, "failed reopening the interface after MTU change\n");
>  			return ret;
>  		}

[Severity: Critical]
Is the premise of the comment, that the data path has already been
released, true for the hardware state when __stmmac_open() fails in
stmmac_request_irq()?

__stmmac_open() first copies the new configuration into priv->dma_conf
and then calls stmmac_hw_setup(), whose last steps are:

	/* Enable the MAC Rx/Tx */
	stmmac_mac_set(priv, priv->ioaddr, true);
	...
	/* Start the ball rolling... */
	stmmac_start_all_dma(priv);

If stmmac_request_irq() then fails, the unwind is only:

	irq_error:
		phylink_stop(priv->phylink);

		for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
			hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);

		stmmac_release_ptp(priv);
	init_error:
		return ret;

so the MAC stays enabled, all RX/TX DMA channels stay in RUN state, and
priv->opened stays false because it is only set after IRQ setup
succeeds.

stmmac_change_mtu() then calls free_dma_desc_resources(priv, dma_conf).
Since priv->dma_conf aliases dma_conf at this point, doesn't that free
the descriptor rings and RX page-pool pages whose addresses are still
live in the DMA channel base and tail registers?

The following netif_close() reaches __stmmac_release(), which now
returns at the new !priv->opened guard before stmmac_stop_all_dma(),
which was the only remaining caller that clears the RUN bits (and calls
stmmac_deinit_chan()). Can the device keep fetching descriptors and
writing received frames into the freed coherent memory and the returned
page-pool pages?

The commit message says:

	"A subsequent open can then allocate fresh resources and retry
	normally."

With the channels still armed, does the next stmmac_open() reliably
recover, given that the SWR poll in stmmac_init_dma_engine() is bounded
and can time out while the channels still have outstanding bus
transactions?

Would it be better to unwind the hardware where it was started, that is
stmmac_stop_all_dma() plus stmmac_mac_set(priv, priv->ioaddr, false) in
the irq_error path of __stmmac_open(), or before the rings are freed in
stmmac_change_mtu()? The follow-up patch in this series for the resume
path does exactly that (stmmac_stop_all_dma() and stmmac_mac_set(priv,
priv->ioaddr, false) before __stmmac_release()), but the MTU path is
left unchanged at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-submit-stmmac-reset-fixes-v1-v1-0-87a4e431ee00%40gmail.com
