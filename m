Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852846982F;
	Sun, 20 Sep 2026 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789923769; cv=none; b=F6o9M0dDwyoJzT8La3l79+FvlIcIQhXxnN5A7Qhfl5GQrV5RbW8rp8fybGDkTKpdy+MSpYFzhCTdvFx0r+iHZe6CragGqESF/LiyGWdFZnetM+9v6J/L/pSQxeDx0DKbZjzPhuy92rBbSqaCTBlEIStZWFWJNCTx5f6KsbFUUKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789923769; c=relaxed/simple;
	bh=orSLI6sNWXdOVkkm1OKgZ3XrFgAlDpVSceMYh7cGdMk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cv11/csYZv1eDcclz1o4XhyjmE/Ej7pOO4dVl6hMvzQn+X+a6Zm/Qy+YvfFp5fyruGSrbhKkLeJP3ys3ruLXJCAzQgPARBM7uPEKAKVl2n2G+rMnkZW+WD+OlId4FJVMpzHs3IoRWpxfAr1tQcLIewcym6he8qyj7WlN8NOhSls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knuxvx+E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knuxvx+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933221F000FF;
	Sun, 20 Sep 2026 17:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789923768;
	bh=dUcRCf1eGnVfi1W8WAuJzDtzf2AUhHVib1k17d62MRY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=knuxvx+E1K3bukIu7ANc9yenaH5TTf71fbgye/bWuIkebLzpglwIKsW758k1qKMAF
	 1CHs3FkOat50571nqEZNDO7vgRPGkZJlRp0gAX49yLbdJFVpwkbf0eRlyJQoomGB5e
	 dp0AKwstM/DaGrg3VlfTk6lj4ivxrFmHQOgjQ8Vsm/ZZ1yb1hckPjnicC76mkcIvAi
	 8V/YD5kQp36Tc5VeYONlpjsZKM6cScWgS5sxa/DRujtT8vNpLJLan7FdYzXuPGIseB
	 xMrHrcGYVQPoIRQZiS9SaGmY4ZMF9oJ7PqoBWHDcOZ+XP7m2rCz25tDA+ixi8x2c/h
	 cEmGePV87inSw==
Subject: Re: [PATCH net-next v3 1/3] net: stmmac: sun8i: reset the MAC after
 PHY initialization
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: richard.genoud@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, wens@kernel.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, alexandre.torgue@foss.st.com,
 peppe.cavallaro@st.com, joabreu@synopsys.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, mripard@kernel.org, alastair@d-silva.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Date: Sun, 20 Sep 2026 17:02:46 +0000
Message-ID: <178992376611.2160803.4135764677337336595@kernel.org>
In-Reply-To: <20260917-submit-h616-emac1-v1-v3-1-62cb8316e19b@gmail.com>
References: <20260917-submit-h616-emac1-v1-v3-1-62cb8316e19b@gmail.com>
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

Critical: 0 · High: 1 (1) · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] A reset timeout during an MTU-change reopen leaves the still-
  running netdev owning freed DMA resources, causing a later double free.
- [Medium] Incomplete fix: the retained probe-time MAC soft reset in
  mdio_mux_syscon_switch_fn()…
- [Medium] Reset-timeout failure path leaves the EMAC un-quiesced.
- [Medium] The MAC reset timeout is shorter than the PHY receive-clock
  startup interval that IEEE 802.3 permits, so the newly relocated reset…
- [Low] The patch fixes a user-visible failure (MAC probe fails and the
  netdev plus its MDIO bus are torn down when the PHY driver has not…
- [Low] Stale comment and vacuous runtime-PM window in
  sun8i_dwmac_probe().

Pre-existing issues:
- [High] Use-after-free on the sun8i_dwmac_probe() `dwmac_mux:` error
  path.

--

net: stmmac: sun8i: reset the MAC after PHY initialization

This moves the sun8i EMAC software reset out of probe and into the stmmac
->reset (DMA reset) callback, so it runs during hardware setup once the PHY
has been attached and resumed. The H3 MDIO-mux reset after switching the
syscon mux is kept, and sun8i_dwmac_reset() now takes an ioaddr instead of
a stmmac_priv.

A few questions below.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 48c52eb962335..4523a14f5e0c3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -269,11 +269,32 @@ static const struct emac_variant emac_variant_h6 = {
>  #define SYSCON_ETCS_EXT_GMII	0x1
>  #define SYSCON_ETCS_INT_GMII	0x2
>  
> +static int sun8i_dwmac_reset(void __iomem *ioaddr)
> +{
> +	u32 v;
> +
> +	v = readl(ioaddr + EMAC_BASIC_CTL1);
> +	writel(v | 0x01, ioaddr + EMAC_BASIC_CTL1);
> +
> +	/* The timeout was previously set to 10ms, but some board (OrangePI0)
> +	 * need more if no cable plugged. 100ms seems OK
> +	 */
> +	return readl_poll_timeout(ioaddr + EMAC_BASIC_CTL1, v,
> +				  !(v & 0x01), 100, 100000);
> +}

[Severity: Medium]

Is 100 ms enough for this poll now that the reset runs right after the PHY
is brought back out of power-down?

sun8i_dwmac_dma_reset() is reached from stmmac_hw_setup(), which is called
after phylink_prepare_resume() on the reopen and resume paths.
phylink_prepare_resume() says it does not wait for the receive clock:

drivers/net/phy/phylink.c:phylink_prepare_resume() {
	/* IEEE 802.3 22.2.4.1.5 allows PHYs to stop their receive clock
	 * when PDOWN is set. ... Note that 802.3 allows PHYs 500ms before
	 * the clock meets requirements. We do not implement this delay.
	 */
	if (pl->config->mac_requires_rxc && phydev && phydev->suspended)
		phy_resume(phydev);
}

stmmac sets mac_requires_rxc, so for a PHY that takes longer than 100 ms
after leaving PDOWN to produce a valid RXC, would the reset time out and
make stmmac_hw_setup() fail on MTU change and on system resume?

>  /* sun8i_dwmac_dma_reset() - reset the EMAC
>   * Called from stmmac via stmmac_dma_ops->reset
>   */
>  static int sun8i_dwmac_dma_reset(void __iomem *ioaddr)
>  {
> +	int ret;
> +
> +	/* The PHY receive clock must be running for the reset to complete. */
> +	ret = sun8i_dwmac_reset(ioaddr);
> +	if (ret)
> +		return ret;
> +
>  	writel(0, ioaddr + EMAC_RX_CTL1);
>  	writel(0, ioaddr + EMAC_TX_CTL1);
>  	writel(0, ioaddr + EMAC_RX_FRM_FLT);

[Severity: Medium]

Does this early return leave the EMAC un-quiesced?

Two things change on the timeout path.  First, sun8i_dwmac_reset() has
already set the self-clearing SOFT_RST request (bit 0 of EMAC_BASIC_CTL1)
and nothing withdraws it.  Second, the register clearing that the ->reset
callback previously did unconditionally is now skipped:

	writel(0, ioaddr + EMAC_RX_CTL1);
	writel(0, ioaddr + EMAC_TX_CTL1);
	writel(0, ioaddr + EMAC_RX_FRM_FLT);
	writel(0, ioaddr + EMAC_RX_DESC_LIST);
	writel(0, ioaddr + EMAC_TX_DESC_LIST);
	writel(0, ioaddr + EMAC_INT_EN);
	writel(0x1FFFFFF, ioaddr + EMAC_INT_STA);

The callers do not compensate.  In stmmac_main.c, __stmmac_open() reaches
init_error: which only returns, unlike irq_error: which calls
stmmac_stop_all_dma().  stmmac_resume() likewise just powers down the
legacy serdes and returns.

On resume the host IRQ is still registered while EMAC_INT_EN keeps the
enables from before suspend (stmmac_suspend only calls
stmmac_stop_all_dma()) and EMAC_INT_STA is never acknowledged.  Should the
descriptor lists and interrupt registers still be cleared before returning
the error?

[Severity: High]

Can a reset timeout here turn an MTU change into a double free of the DMA
resources?

stmmac_change_mtu() releases the interface and reopens it with the new
configuration:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_change_mtu() {
		__stmmac_release(dev);

		ret = __stmmac_open(dev, dma_conf);
		if (ret) {
			free_dma_desc_resources(priv, dma_conf);
			kfree(dma_conf);
			netdev_err(priv->dev, "failed reopening the interface after MTU change\n");
			return ret;
		}
}

__stmmac_open() publishes the new pointers before the fallible setup:

	memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));
	...
	phylink_prepare_resume(priv->phylink);
	...
	ret = stmmac_hw_setup(dev);
	if (ret < 0)
		goto init_error;

struct stmmac_dma_conf embeds rx_queue[] and tx_queue[] by value, so
priv->dma_conf ends up with its own copies of the descriptor, buffer and
page pool pointers that stmmac_change_mtu() then frees.  The interface
stays administratively up, and the next close does:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:__stmmac_release() {
	/* Release and free the Rx/Tx resources */
	free_dma_desc_resources(priv, &priv->dma_conf);
}

The MTU reopen is also the case where phylink_stop() has just powered the
PHY down, so the new -ETIMEDOUT from sun8i_dwmac_dma_reset() is reachable
there.  The core recovery gap in stmmac_change_mtu() and __stmmac_open()
predates this patch, but the commit message says it wants to "return reset
errors through the normal hardware-setup error path" - is that path safe to
use on sun8i today?

[ ... ]

> @@ -895,7 +895,9 @@ static int mdio_mux_syscon_switch_fn(int current_child, int desired_child,
>  		/* After changing syscon value, the MAC need reset or it will
>  		 * use the last value (and so the last PHY set).
>  		 */
> -		ret = sun8i_dwmac_reset(priv);
> +		ret = sun8i_dwmac_reset(priv->ioaddr);
> +		if (ret)
> +			dev_err(priv->device, "EMAC reset timeout\n");
>  	}
>  	return ret;
>  }

[Severity: Medium]

Does this call site keep the receive-clock dependency the commit message
says it removes?

The new comment in sun8i_dwmac_dma_reset() states "The PHY receive clock
must be running for the reset to complete", and the core honours that:
stmmac_hw_setup() wraps stmmac_init_dma_engine() in
phylink_rx_clk_stop_block(), and __stmmac_open()/stmmac_resume() call
phylink_prepare_resume() first.

mdio_mux_syscon_switch_fn() has neither guarantee.  It runs during MAC
probe:

sun8i_dwmac_register_mdio_mux()
  mdio_mux_init()
    of_mdiobus_register(child)
      mdio_mux_read()
        mdio_mux_syscon_switch_fn()
          sun8i_dwmac_reset(priv->ioaddr)

so no PHY driver can have been bound yet, and for
DWMAC_SUN8I_MDIO_MUX_EXTERNAL_ID the internal EPHY has just been unpowered
by sun8i_dwmac_unpower_internal_phy().

On timeout the error propagates out of mdio_mux_read(), the child bus PHY
scan fails, and mdio-mux.c drops that child without failing mdio_mux_init()
as a whole:

drivers/net/mdio/mdio-mux.c:mdio_mux_init() {
		r = of_mdiobus_register(cb->mii_bus, child_bus_node);
		if (r) {
			mdiobus_free(cb->mii_bus);
			if (r == -EPROBE_DEFER) { ... }
			devm_kfree(dev, cb);
			dev_err(dev, "Error: Failed to register MDIO bus for child %pOF: %pe\n", ...);
}

Would probe then succeed with the external PHY permanently absent, which is
the same reprobe-to-recover state the commit describes fixing?

Separately, the timeout now only logs.  The syscon mux field has already
been rewritten and the EPHY power state already changed while the MAC has
not latched the new selection - should either be restored before returning?

[Severity: High]

This isn't a bug introduced by this patch, but the reset kept here makes an
existing unbalanced probe teardown easier to reach.  When
mdio_mux_syscon_switch_fn() has already taken the internal branch,
sun8i_dwmac_power_internal_phy() has set gmac->internal_phy_powered, and
sun8i_dwmac_register_mdio_mux() then fails (this reset timing out, or
of_mdiobus_register() returning -EPROBE_DEFER, or mdio_mux_init()
returning -ENODEV for "No acceptable child buses found"), probe takes
goto dwmac_mux:

drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c:sun8i_dwmac_probe() {
dwmac_mux:
	reset_control_put(gmac->rst_ephy);
	clk_put(gmac->ephy_clk);
dwmac_remove:
	pm_runtime_put_noidle(&pdev->dev);
	stmmac_pltfr_remove(pdev);
}

stmmac_pltfr_remove() -> stmmac_dvr_remove() ends with
priv->plat->exit(dev, priv->plat->bsp_priv), which is sun8i_dwmac_exit():

	if (gmac->variant->soc_has_internal_phy)
		sun8i_dwmac_unpower_internal_phy(gmac);

and because internal_phy_powered is still true:

drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c:sun8i_dwmac_unpower_internal_phy() {
	if (!gmac->internal_phy_powered)
		return;

	clk_disable_unprepare(gmac->ephy_clk);
	reset_control_assert(gmac->rst_ephy);
}

Does this use the clk and reset_control after they were put?
sun8i_dwmac_remove() uses the other order, unpowering before putting:

		mdio_mux_uninit(gmac->mux_handle);
		sun8i_dwmac_unpower_internal_phy(gmac);
		reset_control_put(gmac->rst_ephy);
		clk_put(gmac->ephy_clk);

> @@ -1217,10 +1219,6 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev, "Failed to register mux\n");
>  			goto dwmac_mux;
>  		}
> -	} else {
> -		ret = sun8i_dwmac_reset(priv);
> -		if (ret)
> -			goto dwmac_remove;
>  	}
>  
>  	pm_runtime_put(&pdev->dev);

[Severity: Low]

With this else arm gone, the comment above pm_runtime_get_sync() in
sun8i_dwmac_probe() no longer matches the code:

	/* the MAC is runtime suspended after stmmac_dvr_probe(), so we
	 * need to ensure the MAC resume back before other operations such
	 * as reset.
	 */
	pm_runtime_get_sync(&pdev->dev);

There is no reset left in probe.  The only remaining work between the
get_sync and pm_runtime_put() is the if (gmac->variant->soc_has_internal_phy)
block, so for v3s, a83t, r40, a64 and h6 the pair now brackets nothing.
Should the comment be updated, and should the get/put be moved inside the
soc_has_internal_phy branch?

[Severity: Low]

Should this carry a Fixes: tag and a target tree?  The commit fixes a
user-visible failure where probe tears down the netdev and its MDIO bus.
git blame on the removed if/else and probe-time reset points at
634db83b8265 ("net: stmmac: dwmac-sun8i: add support for mdio-mux"), on top
of the original driver 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i").

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b%40gmail.com
