Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2646E2E7162;
	Tue,  6 Oct 2026 04:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791262090; cv=none; b=b1yw+mT7ry8vFMPCDLXEmiFs30iLFT0WLK5fyw8lpbFTOV7LaoZys2Kgz5skKAnO+st7Gh392gL8z3rFcUxcddFT4Osp0bU8juBlAeil2fldynN7qq56UXRQrL95LkTiF5UIziFHsuFSj+TeZXcmlb9tTbqtJ1adMt17cSYLha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791262090; c=relaxed/simple;
	bh=ES1mMtTZdGK8xFhtNdrhuMbWFvc9o0sjfQ9tF5U073U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sAR4GZzaNN1mWqdBnH8LlIiaOwq3887inFQR362A7T6XY0g+srX9hegGDqJJJSepTCrqBJZ9e0fq+f1QzlCyibSK94K5S50owEJWvIIhy1C8norD+wKW3odGhTVNA0YiBEB4+dO0clBFynyOZ52SKXktwYHXfaxiLv8JrwW5sZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwPTStiD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwPTStiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEC91F000FF;
	Tue,  6 Oct 2026 04:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791262088;
	bh=jpMdpPz3UFTGrvQw6HHtAR4usszUupWqUCkddaJWEWs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QwPTStiDmmZwaJl30JvBXLYoSXbVxrTancywoeFnjEpYHl7fsZXDxYXDD2DxFfaO8
	 3q9E0SgYn8ggerN8388n9EqEeGS4X7SjL1MvaCzM5Kstvr7JyiI4wI0c0GxQ8CHvcs
	 EUng3fVr5tkRK2MZuFRUSs/l/FM4IuLl3f5vBXSLqAWj5jmADrGYZUkXGYJ7MUKMT2
	 fhD+1fGgxWaVNoOPIXC5o0CE9b8/d81o3PC64zt9iwESitmX6ZcgNLRY3dtHHnNzdQ
	 8JNV41/t6d2jQiXGaRF2k+pdEgixOZDWPvNJhkI7sF5Uusj+pvfEle125iQ74tIycr
	 vjfRFFARaeYDw==
Subject: Re: [PATCH net v2] net: stmmac: mask the MAC interrupt while resume
 resets the MAC
From: netdev-bot+sashiko@kernel.org
To: iav@iav.lv
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 06 Oct 2026 04:48:07 +0000
Message-ID: <179126208779.434549.13501536895517522673@kernel.org>
In-Reply-To: <20261002043558.1302590-1-iav@iav.lv>
References: <20261002043558.1302590-1-iav@iav.lv>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] If stmmac_hw_setup() fails because stmmac_reset() times out in
  stmmac_init_dma_engine() ("Failed to reset the dma"),…
- [Medium] stmmac_resume() disables ndev->irq at the very top and re-
  enables it only after netif_device_attach().
- [Medium] The disable_irq()/enable_irq() pair in stmmac_resume() is not
  serialized against stmmac_reset_subtask().

--

net: stmmac: mask the MAC interrupt while resume resets the MAC

This patch disables ndev->irq for all of stmmac_resume() when the
interface is running, and re-enables it on every exit path. The goal is
to stop an RGSMIIIS status that is already pending from storming the line
between the MAC reset in stmmac_hw_setup() and the GMAC_INT_MASK write in
dwmac1000_core_init().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index ec62fa7418f41..b275b6234b557 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -8313,15 +8313,25 @@ int stmmac_resume(struct device *dev)
>  	struct net_device *ndev = dev_get_drvdata(dev);
>  	struct stmmac_priv *priv = netdev_priv(ndev);
>  	int ret;
> +	bool irq_off;
> +
> +	/* Resume resets the MAC, leaving every core interrupt unmasked until
> +	 * the mask is written again: a status bit already pending would storm.
> +	 */
> +	irq_off = netif_running(ndev);
> +	if (irq_off)
> +		disable_irq(ndev->irq);

[Severity: Medium]
In single-IRQ mode the line is requested as shared:

stmmac_request_irq_single() {
	ret = request_irq(dev->irq, stmmac_interrupt,
			  IRQF_SHARED, dev->name, dev);
}

disable_irq() masks the descriptor for every action on that line. The
commit message uses the same sharing argument to leave the line enabled
during suspend.

Is it intended that resume keeps the line masked for every sharer through
priv->plat->resume(), stmmac_mdio_reset(), stmmac_legacy_serdes_power_up(),
rtnl_lock(), mutex_lock(&priv->lock), phylink_prepare_resume(), the DMA
SWR poll (up to 200 ms) and phylink_resume()?

The window that needs protection seems to run only from the SWR in
stmmac_init_dma_engine() to stmmac_core_init(), and both are inside
stmmac_hw_setup().

Could another device on the line that resumes at the same time (for
example an async-resumed PCI function on the same INTx line with
stmmac_pci, or the Loongson glue without MSI) have its completion
interrupts held off long enough to time out?

The masked window also covers blocking on rtnl_lock(). Could a sharer
that holds rtnl and waits for its own interrupt on this line with no
timeout deadlock here? Lockdep cannot see that dependency.

>  
>  	if (priv->plat->resume) {
>  		ret = priv->plat->resume(dev, priv->plat->bsp_priv);

[ ... ]

> @@ -8367,7 +8377,7 @@ int stmmac_resume(struct device *dev)
>  		stmmac_legacy_serdes_power_down(priv);
>  		mutex_unlock(&priv->lock);
>  		rtnl_unlock();
> -		return ret;
> +		goto out;
>  	}

[Severity: Medium]
If stmmac_hw_setup() fails because stmmac_reset() times out, can this
path turn the line back on while the core interrupts are still unmasked?

stmmac_hw_setup()
  stmmac_init_dma_engine()
    stmmac_reset()        <- SWR asserted, poll times out
    netdev_err(priv->dev, "Failed to reset the dma\n");
    return ret;
  return ret;             <- before stmmac_core_init()

On this path, stmmac_core_init()->dwmac1000_core_init() is the only code
that writes GMAC_INT_DEFAULT_MASK back to GMAC_INT_MASK, so the mask is
never restored. The goto out then calls enable_irq(ndev->irq)
unconditionally.

Suppose the mask has already returned to its reset value of 0, or the
reset finishes late after the 200 ms poll in dwmac_dma_reset() has given
up. Then the latched RGSMIIIS bit reaches a live line.
stmmac_interrupt() never clears that source and still returns
IRQ_HANDLED. Wouldn't that be the same storm this patch is meant to
prevent?

The comment in stmmac_hw_setup() says clk_rx_i must be running for the
reset to complete, and a stopped clk_rx_i is the known cause of SWR
timeouts.

This path behaved the same way before the patch, because the line was
always live. It is still a resume exit that the fix does not cover.
Would re-masking the core interrupts, or acknowledging the source, on
this failure path close it?

>  
>  	stmmac_init_timestamping(priv);

[ ... ]

> @@ -8393,7 +8403,12 @@ int stmmac_resume(struct device *dev)
>  
>  	netif_device_attach(ndev);
>  
> -	return 0;
> +	ret = 0;
> +out:
> +	if (irq_off)
> +		enable_irq(ndev->irq);

[Severity: Medium]
Can this enable_irq() become unbalanced if stmmac_reset_subtask() runs
between rtnl_unlock() and here?

priv->wq comes from create_singlethread_workqueue() and is not
freezable. stmmac_suspend() does not cancel or flush the reset work
either.

A reset can be requested around resume, for example from
stmmac_safety_interrupt() on a separate sfty_irq line, which resume does
not disable. That goes through stmmac_global_err() ->
stmmac_service_event_schedule(), and STMMAC_DOWN is not set across
suspend/resume.

The worker blocks on rtnl while resume holds it, then:

stmmac_resume()                    stmmac_reset_subtask()
  disable_irq(ndev->irq)
  ...
  rtnl_unlock()
  netif_device_attach()
  <preempted>
                                     dev_close()
                                       stmmac_release()
                                         free_irq()
                                     dev_open()
                                       request_irq()
                                         irq_startup()
                                           desc->depth = 0
  enable_irq(ndev->irq)
    __enable_irq() with depth 0

Wouldn't this trigger the "Unbalanced enable for IRQ %d" WARN, which
becomes a panic with panic_on_warn? The line itself ends up enabled,
because request_irq() already started it. Nothing serializes the window
between rtnl_unlock() and this enable_irq() against the worker.

> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(stmmac_resume);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002043558.1302590-1-iav%40iav.lv
