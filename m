Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832149553B;
	Sun, 18 Oct 2026 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792324940; cv=none; b=ZejgY+bqPqzVXel9xUlq2LfJjMMCIZqayEN2VaH06SlgvvSaEZBrP4IyLL9dGFSo7TI660kG71kqYYRWlNaUbeHCbrgpJ7XqmYQ591mqkCOYSJn6nei7oT4juCkiGziC/ilg6mrPU2rM7y0ciGHHlJoHGZ3CKw/Y0VawnkmqzuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792324940; c=relaxed/simple;
	bh=zoo3eiL2glYtdPJ2Y3aeYG37KgEUvBsw/IaOCFE9QHs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iYR9B7KKFxHCydMKwn/6dpeREAAqQe9lqePJCOOQj5LsnzlHGfGAeyMQdtNa6ycfWl6JKSsTjyK9h6H6meZDgxmNu/1pBwwkqdGMHP72aPxa1/CPHij+bCYsFDVZO1YhqoxU/dv7R5qjTYK3QgvyY7Ucz8J6TkTp5F7DO7uF6IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuuQeKb6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuuQeKb6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC491F000C5;
	Sun, 18 Oct 2026 12:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792324932;
	bh=uNrI+WN4CqntUAuiZlLiynnJmLlgbrAhDMwt8sD+5ac=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YuuQeKb6/JmHsIl8LCjO6QDe6ZVS4S8E+lUoXMFxhTNVn/ZxSwZoEMn0XDCjavjA4
	 FFWhK56fI1MtnR3hQARkonQG/8kCh3PvoUGHCf0sx5UdybcLAc4oXIwEoR3wMCqyP6
	 gxNCu522oiaaFUdasjl6PW9a0BjrZq6yJWVHX0UE1kRspoZ77n6OHntFaYfFvprzUP
	 rYp+WgOgp/lPwn5QWEO75rWgQgoCWwfQEmfOaL1rmECyPuZPxoUF7Nr+t0fIPUtuVD
	 mGtaqT+yqT0bLUi2SOgfxueQtfNz88VYzXys6UE1HsgcUwCQb3RVdIzZ22R7XlhmRA
	 wAdikLFZ555Yw==
Subject: Re: [PATCH net 2/4] net: bcmgenet: do not tear the datapath down
 twice after a failed resume
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 f.fainelli@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 18 Oct 2026 12:02:11 +0000
Message-ID: <179232493108.3135.9703046589792155223@kernel.org>
In-Reply-To: <20261017-nb-genet-fini-dma-net-v1-2-47e7c57f6834@tipi-net.de>
References: <20261017-nb-genet-fini-dma-net-v1-2-47e7c57f6834@tipi-net.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] With this patch alone, bcmgenet_resume() still drops the
  priv->clk reference in out_clk_disable when bcmgenet_init_dma() fails,…
- [Medium] With this patch alone, after a failed resume the netdev stays
  detached.
- [Medium] Before calling bcmgenet_init_dma(), bcmgenet_resume() always
  calls bcmgenet_hfb_restore(), which goes through bcmgenet_hfb_clear().
- [Low] The patch fixes two bugs from different origins but carries only
  one Fixes tag.
- [Low] The commit message and the new comment in bcmgenet_resume() (`/*
  A link event can enable the receiver after a failed resume, so check…

--

net: bcmgenet: do not tear the datapath down twice after a failed resume

This patch sets priv->rx_cbs and priv->tx_cbs to NULL when they are freed.
bcmgenet_close() and bcmgenet_suspend() then check priv->tx_cbs and skip the
datapath teardown after a failed bcmgenet_resume(). The WoL resume path also
stops reusing rings that are gone when it sees CMD_RX_EN set.

> Fixes: b6e978e50444 ("net: bcmgenet: add suspend/resume callbacks")

[Severity: Low]

This isn't a bug, but should the WoL hunk have a second Fixes tag?

The priv->tx_cbs check added to the CMD_RX_EN test in bcmgenet_resume()
guards the "Successfully exited WoL, just resume data flows" branch, which
reuses the rings. That branch came from 254f3239dd07 ("net: bcmgenet: revise
suspend/resume"), not b6e978e50444. The previous patch in this series, "net:
bcmgenet: stop the PHY when a WoL resume rebuilds the datapath", already uses
Fixes: 254f3239dd07 for the same block.

A Fixes: 254f3239dd07 tag would record where the WoL hunk comes from. It
would also show that the hunk only applies to trees that contain that commit.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 308716cddc077..fe3338ba81980 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -3493,7 +3498,9 @@ static int bcmgenet_close(struct net_device *dev)
>  
>  	netif_dbg(priv, ifdown, dev, "bcmgenet_close\n");
>  
> -	bcmgenet_netif_stop(dev, false);
> +	/* A failed resume has torn the datapath down already */
> +	if (priv->tx_cbs)
> +		bcmgenet_netif_stop(dev, false);
>  
>  	/* Really kill the PHY state machine and disconnect from it */
>  	phy_disconnect(dev->phydev);

[Severity: Medium]

Now that this check lets close go further, can priv->clk be released twice
after a failed resume?

When bcmgenet_init_dma() fails, bcmgenet_resume() still goes through
out_clk_disable, and the interface stays netif_running():

out_clk_disable:
	if (priv->internal_phy)
		bcmgenet_power_down(priv, GENET_POWER_PASSIVE);
	clk_disable_unprepare(priv->clk);
	return ret;

Before this patch, the next ifdown hung in napi_disable(). Now
bcmgenet_close() gets past the check and reaches this code again:

	if (priv->internal_phy)
		ret = bcmgenet_power_down(priv, GENET_POWER_PASSIVE);

	clk_disable_unprepare(priv->clk);

A second suspend has the same problem. The new early return in
bcmgenet_suspend() returns 0, so bcmgenet_suspend_noirq() calls
bcmgenet_power_down() and clk_disable_unprepare(priv->clk) once more.

Would this underflow the clk enable/prepare counts? And would the power-down
register writes (EXT_EXT_PWR_MGMT, or the WoL MPD/HFB/UMAC_CMD sequence) hit
a block that has no clock?

The next patch in the series, "net: bcmgenet: let the interface be reopened
after a failed resume", removes out_clk_disable and keeps the clock enabled
on this failure path. So this only affects this intermediate commit. Could
that change be folded in here or moved before this patch?

[Severity: Medium]

Is the netdev still detached once bcmgenet_close() completes after a failed
resume?

bcmgenet_suspend() called netif_device_detach(dev). The init_dma failure path
in bcmgenet_resume() returns without calling netif_device_attach(), and
bcmgenet_close() does not re-attach either. On the next ifup, __dev_open()
sees that the device is not present and returns -ENODEV.

The next patch in the series, "net: bcmgenet: let the interface be reopened
after a failed resume", adds netif_device_attach(dev) to bcmgenet_close()
after free_irq(). So this also only affects this intermediate commit.

[ ... ]

> @@ -4258,7 +4265,11 @@ static int bcmgenet_resume(struct device *d)
>  
>  	if (device_may_wakeup(d) && priv->wolopts) {
>  		reg = bcmgenet_umac_readl(priv, UMAC_CMD);
> -		if (reg & CMD_RX_EN) {
> +
> +		/* A link event can enable the receiver after a failed
> +		 * resume, so check the rings too
> +		 */

[Severity: Low]

Is a link event really what sets CMD_RX_EN here? The commit message gives
the same cause:

  But after a failed resume the MAC sits in software reset, and the
  next link event takes it out and enables it.

After a failed resume, the PHY state machine is not handling link changes:

- On the non-WoL path, bcmgenet_netif_stop(dev, true) in suspend already
  called phy_stop().
- On the WoL path, the fallback calls phy_stop() if the PHY was started.
  Otherwise bcmgenet_wol_power_down_cfg() leaves phydev->state = PHY_READY.

Either way, bcmgenet_mii_setup()->bcmgenet_mac_config() is not reached. That
is the code that clears CMD_SW_RESET and sets CMD_TX_EN | CMD_RX_EN on link
up.

The bit seems to come from the next WoL suspend instead. It takes the new
early return in bcmgenet_suspend(), and then runs
bcmgenet_suspend_noirq()->bcmgenet_power_down()->bcmgenet_wol_power_down_cfg():

	/* Can't suspend with WoL if MAC is still in reset */
	if (reg & CMD_SW_RESET)
		reg &= ~CMD_SW_RESET;

	/* Receiver must be enabled for WOL MP detection */
	reg |= CMD_RX_EN;

bcmgenet_wol_power_up_cfg() leaves RX_EN set when it puts the MAC back into
SW_RESET. bcmgenet_resume() then sees CMD_RX_EN with no rings.

The added priv->tx_cbs check covers this case anyway. Could the comment and
the commit message describe this path instead?

> +		if (priv->tx_cbs && (reg & CMD_RX_EN)) {
>  			/* Successfully exited WoL, just resume data flows */
>  			list_for_each_entry(rule, &priv->rxnfc_list, list)
>  				if (rule->state == BCMGENET_RXNFC_STATE_ENABLED)

[ ... ]

> @@ -4343,6 +4354,15 @@ static int bcmgenet_suspend(struct device *d)
>  	if (!netif_running(dev))
>  		return 0;
>  
> +	/* A failed resume has torn the datapath down already. Resume still
> +	 * enables irq1 on the WoL path, so it has to be disabled here.
> +	 */
> +	if (!priv->tx_cbs) {
> +		if (device_may_wakeup(d) && priv->wolopts)
> +			disable_irq(priv->irq1);
> +		return 0;
> +	}

[Severity: Medium]

With WoL enabled, can this early return arm the default filter and the
non-wake HFB filters as wake sources?

bcmgenet_resume() calls bcmgenet_hfb_restore() before the
bcmgenet_init_dma() call that can fail. That goes through
bcmgenet_hfb_clear(), which enables the catch-all filter 0 and sets
RBUF_HFB_EN. It then restores every runtime rxnfc filter. Nothing undoes
this when init_dma fails.

On the next suspend, this return skips the "Suspend non-wake Rx data flows"
block further down. That block normally keeps only the RX_CLS_FLOW_WAKE
rules enabled and clears RBUF_HFB_EN when there are none:

		} else {
			bcmgenet_hfb_reg_writel(priv, hfb_enable << 1,
						HFB_FLT_ENABLE_V3PLUS + 4);
		}
		if (!hfb_enable)
			reg &= ~RBUF_HFB_EN;

bcmgenet_suspend_noirq() still calls
bcmgenet_power_down(GENET_POWER_WOL_MAGIC), and
bcmgenet_wol_power_down_cfg() then does:

	reg = UMAC_IRQ_MPD_R;
	if (hfb_ctrl_reg & RBUF_HFB_EN)
		reg |=  UMAC_IRQ_HFB_SM | UMAC_IRQ_HFB_MM;

Could ordinary received traffic that matches filter 0 then wake the system,
even when only magic-packet wake was requested?

This looks like it is still there at the end of the series. The later
patches keep the clock on after a failed resume, so these register writes
take effect.

>  	netif_device_detach(dev);
>  
>  	if (device_may_wakeup(d) && priv->wolopts) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017-nb-genet-fini-dma-net-v1-0-47e7c57f6834%40tipi-net.de
