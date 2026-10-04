Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B668638F92F;
	Sun,  4 Oct 2026 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791144841; cv=none; b=h1/JyFLDwARXG7P18FU2DfZKXkHuID3DTV90ox5buru2gvAnRC3j0/Nfuj7ndEG3we3fk+nVxxhCAMsdoo0RtdXUsL7PgEk9UQgyvOxyokGiJ5GJ4qbBo5NUAGk37HOvZM66K0h7RP9w0I/xrdzxlR9VFrk1HBeTvSLA1lXl+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791144841; c=relaxed/simple;
	bh=JuI4FfFu7Fyt64CymKie/49zNIQ0f4ie5JD09Mb2hTc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TxjY12HHp5pmKYMN4e2lM2vVxidhxaCRunItS4ii6Qwjefsa02mW7fCNONTp7PaIQcpdwS8z+NQ3CYIEYqarMh9aF+PSG3phequ3m4ucEYboT+exYf1ZNaVIVUzVTMyIugIrp00B45lNcsZY982ZOcuyycYNu2eyt1Jf/RHkyvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg0JWCa/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg0JWCa/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BFF1F000FF;
	Sun,  4 Oct 2026 20:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791144839;
	bh=kUIWaC88q0Bw4l+W8HSB54nC9nI/6KV4K3UIv1ypbKY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jg0JWCa/by34WL3CmzK/O05a1p/buJChGldkdMlaLCsm8gM+mvk8EduO9B2LJ2wtq
	 Nhhww3mCRVYJlNH44bI7XMPWzxrKl7gwtnj2kodSY1EvWPwbq8GUPedBdKlgfi6V/y
	 cEjC44FwvlIUwKZGiFdjTyetP6qpaGjMG0Hqt4UvFp/xnI4jhEDneI7YyL2qH1wQHx
	 pyiI9v9gedayEb9VZCNz6gGSMcFs4hBKR1wCIPqYy2EkRR4FDYFw9cDWFBW1N4JV1y
	 XlWhPyeWPsGugh+/sS8rNK8HZY7Bw6riahDO6a5z9T8T5jsUMkUUQDM/d6ZlIQamoZ
	 QnsfKV0GmlfmA==
Subject: Re: [PATCH net-next] net: stmmac: mask the MAC interrupt while resume
 resets the MAC
From: netdev-bot+sashiko@kernel.org
To: iav@iav.lv
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Sun, 04 Oct 2026 20:13:58 +0000
Message-ID: <179114483834.434549.10718571008152168526@kernel.org>
In-Reply-To: <20260930-stmmac-irq-shut-v1-1-104d1a1dcb28@iav.lv>
References: <20260930-stmmac-irq-shut-v1-1-104d1a1dcb28@iav.lv>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The defect is specific to dwmac1000, but stmmac_resume() now
  calls disable_irq(ndev->irq) on every core for the whole resume.
- [Medium] stmmac_resume() now re-enables ndev->irq on every exit path,
  including error exits where GMAC_INT_MASK was never restored.
- [Low] The commit message names commit 2e2c878a3141 ("net: stmmac:
  remove SGMII/RGMII/SMII interrupt handling") as the point after which…
- [Low] The new comment in the generic stmmac_resume() says 'Resume
  resets the MAC, leaving every core interrupt unmasked until the mask…

--

net: stmmac: mask the MAC interrupt while resume resets the MAC

This patch disables ndev->irq for the whole of stmmac_resume() when the
interface is running, and enables it again on every exit path. The aim is
to stop an RGMII interrupt storm on dwmac1000. There, the MAC reset in
stmmac_hw_setup() clears GMAC_INT_MASK, and it stays clear until
dwmac1000_core_init() writes it again.

> stmmac_resume() resets the MAC in stmmac_hw_setup(). On dwmac1000 the
> reset clears the interrupt mask, and all core interrupts stay unmasked
> until dwmac1000_core_init() writes it again. A link change in that
> window raises an RGMII interrupt, and no handler clears it since
> commit 2e2c878a3141 ("net: stmmac: remove SGMII/RGMII/SMII interrupt handling").
> The line storms:

[ ... ]

> The message repeats every few milliseconds and the network stays down
> until a power cycle or a watchdog reset.

[Severity: Low]
Should this carry a Fixes: tag for the commit it names?

Fixes: 2e2c878a3141 ("net: stmmac: remove SGMII/RGMII/SMII interrupt handling")

That commit removed dwmac1000_rgsmii() and its call from
dwmac1000_irq_status(). That call read GMAC_RGSMIIIS to ack the interrupt:

-	if (intr_status & PCS_RGSMIIIS_IRQ)
-		dwmac1000_rgsmii(ioaddr, x);

It also moved GMAC_INT_DISABLE_RGMII into GMAC_INT_DEFAULT_MASK. Since
then, the mask written by dwmac1000_core_init() is the only protection.

The only trailers are Assisted-by and Signed-off-by, and the note after
them says the patch was ported to net-next. Both 7.2 and 7.3-rc5 were
tested as affected. Would net, with a Fixes: tag and possibly Cc: stable,
be the better target?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3ad9252bf6aea..6e0415538327b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -8356,16 +8356,26 @@ int stmmac_resume(struct device *dev)
>  {
>  	struct net_device *ndev = dev_get_drvdata(dev);
>  	struct stmmac_priv *priv = netdev_priv(ndev);
> +	bool irq_off;
>  	int ret;
>  
> +	/* Resume resets the MAC, leaving every core interrupt unmasked until
> +	 * the mask is written again: a link change in that window would storm.
> +	 */

[Severity: Low]
Does this comment hold for every core that uses stmmac_resume()?

Only dwmac1000 writes a mask register, where 0 means everything is
unmasked:

drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c:dwmac1000_core_init() {
    ...
	writel(GMAC_INT_DEFAULT_MASK, ioaddr + GMAC_INT_MASK);
    ...
}

dwmac4 and xgmac write enable registers instead. On those cores a reset
leaves the core interrupts disabled, not unmasked:

drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c:dwmac4_core_init() {
    ...
	writel(GMAC_INT_DEFAULT_ENABLE, ioaddr + GMAC_INT_EN);
    ...
}

drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:dwxgmac2_core_init() {
    ...
	writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
    ...
}

Could the comment say that this is a workaround specific to dwmac1000?

> +	irq_off = netif_running(ndev);
> +	if (irq_off)
> +		disable_irq(ndev->irq);

[Severity: Medium]
What happens to other devices on this line while resume runs? In single
IRQ mode the line is requested as shared:

stmmac_request_irq_single() {
    ...
	ret = request_irq(dev->irq, stmmac_interrupt,
			  IRQF_SHARED, dev->name, dev);
    ...
}

disable_irq() masks the line for every handler on it. The line then stays
masked through all of these:

  plat->resume()
  stmmac_mdio_reset()
  SerDes power-up
  rtnl_lock()
  mutex_lock(&priv->lock)
  stmmac_hw_setup(), including the DMA soft reset poll of up to 200ms
  in dwmac_dma_reset()
  PTP init
  phylink_resume()

No other device on the line gets interrupts during that time. Suppose one
of them waits for its own interrupt while holding RTNL, or another lock
that stmmac_resume() needs. Can that stall until a timeout, or forever if
the wait has no timeout? Lockdep would not see this dependency.

The commit message mentions IRQF_SHARED only as the reason to leave the
line enabled during suspend.

The problem is specific to dwmac1000. Could the fix avoid the shared line
altogether? Some options:

  rewrite GMAC_INT_MASK right after the reset
  restore the read-to-clear of GMAC_RGSMIIIS in dwmac1000
  disable the line only between the reset and core_init

[ ... ]

> @@ -8451,6 +8462,9 @@ int stmmac_resume(struct device *dev)
>  	stmmac_legacy_serdes_power_down(priv);
>  	mutex_unlock(&priv->lock);
>  	rtnl_unlock();
> +out:
> +	if (irq_off)
> +		enable_irq(ndev->irq);

[Severity: Medium]
Can this enable the line again while GMAC_INT_MASK is still clear?

If stmmac_init_dma_engine() fails, stmmac_hw_setup() returns before
stmmac_core_init(). That is the only place where dwmac1000_core_init()
restores the mask:

stmmac_hw_setup() {
    ...
	ret = stmmac_init_dma_engine(priv);
	if (ret < 0) {
		phylink_rx_clk_stop_unblock(priv->phylink);
		...
		return ret;
	}
    ...
	stmmac_core_init(priv, priv->hw, dev);
    ...
}

The failure can come from stmmac_prereset_configure(), or from
stmmac_reset() timing out ("Failed to reset the dma"). The timeout is a
known case when clk_rx_i from the PHY is not running yet.

dwmac_dma_reset() returns -ETIMEDOUT and leaves SFT_RESET set:

dwmac_dma_reset() {
    ...
	return readl_poll_timeout(ioaddr + DMA_BUS_MODE, value,
				 !(value & DMA_BUS_MODE_SFT_RESET),
				 10000, 200000);
}

So the hardware finishes the reset once the RX clock starts. That usually
happens when the PHY link comes up, which phylink_prepare_resume() has
already started. The reset clears the mask just as the RGMII link change
event arrives.

The error then takes this path:

stmmac_resume()
  stmmac_hw_setup() fails
  goto error_unlock
  out:
    enable_irq(ndev->irq)

stmmac_interrupt() never acks the RGMII source and always returns
IRQ_HANDLED:

stmmac_interrupt() {
    ...
	stmmac_common_interrupt(priv);
	stmmac_dma_interrupt(priv);
	return IRQ_HANDLED;
}

Because of that, the spurious IRQ detector will not disable the line
either. Does the storm this patch fixes come back on these exits, with no
later core_init to close the window?

The commit message says the line is enabled again "on every exit path".
On these exits, though, it is enabled inside the window the patch is
meant to close.

>  
>  	return ret;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930-stmmac-irq-shut-v1-1-104d1a1dcb28%40iav.lv
