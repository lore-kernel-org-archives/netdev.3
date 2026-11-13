Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549091;
	b=eud7X3qTwcCAIQpU3VUQ/r5qrBwFpTWcstfYmWg/0ZXJy7SOBeRl9V4WeIeUuWsIbfmC
	 jKUf4/u1Ck0hq+q++6TlCkEoqBpmo1VWWjurE1vi4RR3YeWrScSEpV9+b1jyFXK/7XBSH
	 sY6WZYnLHmsTG2OcPu5EcVK05gdQFteruDP5h2qpOxCOcF2EsX9Z6Rx7vYRmxhQPlK85F
	 3OyAgvbOjxn6MhydWvqw54TH1Rg2sj2sr3ACHPjDSo+iEQQZQnBi1mY/kFnIFcvWTdooN
	 vBljDTk4nR/3ZZGhJSWxWvrFrS4BpvszG0kGAEwbRJktoT6qBk81ArTHbzDf7eXxjTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549091;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LANplOGl/IujYksPR/YOrSZcasHgqJlzVsMCgKPcbSc=;
	b=yM4ahsez4LAWauE6wfTeN70t1dveJgA1FsS8XtiCcCVHcDBd8/3FcERqkuYTVIA1Qw7/
	 jhKxDKiQClp/LoXP2v5hCV6QeegBh8WdWLh+ZrfRdfTGbV9BL606oawbGgGwv6GDRwIpf
	 xH0OIKo2DOO5Yn5P0/nLqXtLD6ATFccwDCtX09K7dJGvB4NhbsvnGm66NN5PbSVV5Rte8
	 uZnZAx7HmJxgIYRaLa4FSzZiRR9fzQAbcFSIWwVGqcc6z2/IXcEYh6I6+bQ3tZLMO1Sch
	 ge38d7SNPTNAiIBGdeJW7YZV7O1qUnKUvSkYz/5auJdwUUTCAvYHoqLKtoC6S2LUjrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aA1FJUQW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2D0606A883;
	Fri, 13 Nov 2026 05:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aA1FJUQW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BD41F00925;
	Fri, 13 Nov 2026 05:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549091;
	bh=LANplOGl/IujYksPR/YOrSZcasHgqJlzVsMCgKPcbSc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aA1FJUQWvmVyKCMaGNbnhQ/CSPlv+LzHzApYMzxMhm3zkyQb3k4PVjqJjprnP5yhL
	 MPaOl4dvJh04hFrFS7m+9tMYXnn3RktAnoy1dg87CCjB5E6Lt6Myc/slDGxih3KiV8
	 OVBLZQlz5P/YXiKTJFbNbxri4tJN/IWUjIxlHnHDzrAg3TPnCR34iAWBsaWtiY3I5W
	 TuIK6AYitM9SSD1djcQj65gyICIua5A89ZdTxgYW75TwDd9xxvsiytCvLrRkkJBZm8
	 3ufPL4LPvMoFKOeW+ow4l/0+6TSt/Yf/5TqXnaAtbUaWWQXXSM6DzFccAcbe2Vi/7w
	 PDF9CDEughw5A==
Subject: Re: [PATCH net v5 4/4] net: phy: postpone PHY interrupts during sleep
 with MAC-managed PM
From: netdev-bot+sashiko@kernel.org
To: iav@iav.lv
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, lukas@wunner.de, rafael.j.wysocki@intel.com,
 wei.fang@nxp.com, niklas.soderlund@ragnatech.se, paul@pbarker.dev,
 florian.fainelli@broadcom.com, opendmb@gmail.com, Thangaraj.S@microchip.com,
 shenwei.wang@nxp.com, Haoning.CHENG@cn.bosch.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 05:51:29 +0000
Message-ID: <179454908985.2199510.13649467977536691436@kernel.org>
In-Reply-To: <20261111-b4-phylib-mac-pm-irq-v3-v5-4-bbfdb5afb7d3@iav.lv>
References: <20261111-b4-phylib-mac-pm-irq-v3-v5-4-bbfdb5afb7d3@iav.lv>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new wakeup policy treats every postponed PHY interrupt as
  a system wakeup whenever phy_may_wakeup() is true, including link-…

--

net: phy: postpone PHY interrupts during sleep with MAC-managed PM

This commit sets irq_suspended for PHYs whose MAC manages PHY PM. With it
set, phy_interrupt() postpones the PHY driver's handler for the whole
sleep transition instead of accessing an MDIO bus that may be powered
down. The wakeup event a postponed interrupt reports is now decided in
mdio_bus_phy_suspend() and stored in the new irq_wake field.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 110c9dfcbd916..2dc13dd1afb66 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -332,6 +332,44 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
>  	return !phydev->suspended;
>  }
>  
> +static __maybe_unused enum phy_irq_wake
> +phy_irq_wake_source(struct phy_device *phydev)
> +{
> +	struct net_device *netdev = phydev->attached_dev;
> +	bool phy_wol;
> +
> +	if (!netdev)
> +		return PHY_IRQ_WAKE_NONE;
> +
> +	/* phy_suspend() cached the answer of a suspended PHY, which may
> +	 * not be reachable over MDIO.
> +	 */
> +	if (phydev->suspended && !phy_can_wakeup(phydev))
> +		phy_wol = phydev->wol_phy;
> +	else
> +		phy_wol = phy_may_wakeup(phydev);
> +
> +	if (phy_wol)
> +		return PHY_IRQ_WAKE_SYSTEM;
> +
> +	/* With MAC-managed PM, only Wake-on-LAN in the PHY makes its
> +	 * interrupt a wakeup: the MAC stops the PHY itself.
> +	 */
> +	if (phydev->mac_managed_pm)
> +		return PHY_IRQ_WAKE_NONE;

[Severity: Medium]
Can a link-change interrupt caused by the MAC's own suspend path abort
system suspend here?

Take a MAC-managed PHY where phy_may_wakeup() is true. The phy_may_wakeup()
check comes before the mac_managed_pm check, so irq_wake is set to
PHY_IRQ_WAKE_SYSTEM. This happens in mdio_bus_phy_suspend(), which runs
before the MAC's suspend callback.

With stmmac, which sets config->wol_phy_speed_ctrl = true, the MAC
suspend then does:

stmmac_suspend()
  phylink_suspend()
    phylink_stop()
    phylink_speed_down(pl, false)    /* gated on phy_may_wakeup() */
      phy_speed_down(phydev, false)
        phy_config_aneg()            /* restarts autoneg, link drops */

phy_stop() does not mask the PHY interrupt. On PHYs whose INT pin carries
both link and WoL events, the link-fail interrupt then fires while
irq_suspended is set, and phy_interrupt() does:

		case PHY_IRQ_WAKE_SYSTEM:
			pm_system_wakeup();
			break;

This runs without reading the interrupt status, so a link change cannot be
told apart from a PME/WoL event. The phy_speed_down() kernel-doc already
warns about this:

  WARNING: Setting sync to false may cause the system being unable to suspend
  in case the PHY generates an interrupt when finishing the autonegotiation.

Resume speeds the link back up and the next suspend speeds it down again.
Wouldn't every retry abort in the same way?

Two configurations where this looks reachable:

AR8031/AR8035 (at803x) with WoL enabled. AT803X_INTR_ENABLE_WOL shares
AT803X_INTR_ENABLE and the INT pin with the link fail/success bits. These
PHYs lack PHY_ALWAYS_CALL_SUSPEND, so phy_suspend() returns -EBUSY and the
link interrupts are never masked.

BCM54xx with a DT interrupt and no WoL configured. bcm54xx_phy_probe()
calls device_init_wakeup(&phydev->mdio.dev, true) whenever
bcm54xx_phy_can_wakeup() is true, which is whenever
phy_interrupt_is_valid(). So phy_may_wakeup() is true by default, and the
speed-down and PHY_IRQ_WAKE_SYSTEM apply on every suspend.

Before this patch, MAC-managed PHYs never reported a wakeup from
phy_interrupt(). The driver handler read the status, and handlers such as
rtl8211f_handle_interrupt() report a wakeup only on the PME bit.

This also seems to contradict the commit message:

  ... and the MAC device may
  wake the system on its own, so a link interrupt the MAC causes must not
  abort suspend.

The Helios64 result ("no suspend aborted") seems to depend on
rtl8211f_suspend() writing RTL8211F_INER_PME to RTL821x_INER before the
speed-down. That masks the link interrupt, and other PHY drivers do not do
the same.

The postponed path also never reads or clears the status. Doesn't that
leave a level-triggered INT asserted, with the line disabled by
disable_irq_nosync() until resume?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-b4-phylib-mac-pm-irq-v3-v5-0-bbfdb5afb7d3%40iav.lv
