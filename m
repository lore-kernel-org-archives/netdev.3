Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EE84A6892;
	Sun,  4 Oct 2026 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791143543; cv=none; b=F9yKH2L2qudYH1llUOiSaluiBX5jF5bB9AfhutHmgOiqvKWPjeffMUK7d8kvgW+UdRiJ9eDsVvkxqhgOgrV7jENKTTCtDVLfSOj0rnA1r6ym+1ubuCNyjMLS0//9bngBJCjW1VCDRBLDxX3LTA0oRgrEPKhfpqgmIXt44LrbL2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791143543; c=relaxed/simple;
	bh=aJ4JANXBLIE523LUfMvUVrINzD2uPAIdYdywAl7kv5E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IMDLS3BEE7CMoEWvjXy6OctZ67zG6Pt0kmsfHECoDzytgXWmdfGte1jC+2eazXhJlpT4sG/cfSrnSPWKGua1/7HI0+mcwf2ii3mraHH5tmwn6MnH3OhNN+3WjnetsP0/sT4DO3Q4PyeL7r3F5zFEPYBJYdC5/toGCmxVdmtCP9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSMmr221; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSMmr221"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9631A1F000FF;
	Sun,  4 Oct 2026 19:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791143539;
	bh=ltr9IuWe66b3dEPQokcAToGLMYH/D9Aig3Tp+730PGE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OSMmr2217D9ydx6a2nj9BN6lcTPvtCj3ZMfZV/AIqXXuwrI/C80kQPBzDg0FlX249
	 T6vrvB/5cBOvFzVD3s51P/R2bCet+b/Wqp++5qz2CG9+/RC2r7Ndo9BXcHHKt1r8+P
	 bQ8oslBOJxlvJPqADyWK66c99sp4hRt/C7SpuJ3v2mE3al1s8frM7lz9GfK7LAstAA
	 i8sZ9Kf+dtP8jS7vkr82UQYP8UKd+XwPJlitFTDnxuSop8ACrq2HrjADhZEaYCt6e1
	 8uy2FQnOgEcloOtPYbJobZGaunH1L01FwMJ2qpywEMqAtzTdX+kB46FYyQSn0jkygv
	 alXjyxNZ3hnaA==
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: keep the GMAC powered when the
 PHY wakes the system
From: netdev-bot+sashiko@kernel.org
To: iav@iav.lv
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, heiko@sntech.de, edumazet@kernel.org,
 rmk+kernel@armlinux.org.uk, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Sun, 04 Oct 2026 19:52:18 +0000
Message-ID: <179114353815.434549.32562462811934801@kernel.org>
In-Reply-To: <20260930-dwmac-rk-phy-wol-v1-1-9fdc50bd9ae4@iav.lv>
References: <20260930-dwmac-rk-phy-wol-v1-1-9fdc50bd9ae4@iav.lv>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new predicate in rk_gmac_suspend() takes 'ndev->phydev ==
  NULL' to mean 'no PHY needs to stay powered for wake'.
- [Low] The commit body says Helios64 (RTL8211F, WoL in the PHY) hangs
  after 6911308d7d11.
- [Low] rk_gmac_suspend() reads ndev->phydev, an RTNL-protected field,
  without RTNL and without READ_ONCE(), in `ndev->phydev &&…

Pre-existing issues:
- [Medium] rk_gmac_resume() ignores the return value of rk_gmac_powerup()
  and always returns 0.

--

net: stmmac: dwmac-rk: keep the GMAC powered when the PHY wakes the system

With this patch, rk_gmac_suspend() also skips rk_gmac_powerdown() when the
attached PHY reports phy_may_wakeup(). Before, it only checked
device_may_wakeup() on the MAC. The decision is stored in a new
suspend_powerdown field, and rk_gmac_resume() uses it to decide whether
to call rk_gmac_powerup().

> When the PHY handles it, device_may_wakeup()
> is false for the MAC, and rk_gmac_suspend() powers the GMAC down: its
> clocks stop and phy-supply is released.
>
> On Helios64 (RTL8211F, Wake-on-LAN in the PHY) the board then hangs on
> the first or second suspend with a magic-packet wake.

[Severity: Low]
Does this describe the in-tree Helios64 configuration?

The gmac node in rk3399-kobol-helios64.dts has no ethernet-phy child. So
the RTL8211F probe never calls device_set_wakeup_capable() on the PHY, and
rtl8211f_get_wol() reports no WoL support:

drivers/net/phy/realtek/realtek_main.c:rtl8211f_get_wol() {
    ...
	if (!device_can_wakeup(&dev->mdio.dev)) {
		wol->supported = 0;
		return;
	}
    ...
}

phylink then passes the request to stmmac_mac_wol_set(), which does:

	device_set_wakeup_enable(priv->device, !!wolopts);

So on the in-tree board, the old !device_may_wakeup(dev) check in
rk_gmac_suspend() already kept the GMAC powered.

The case fixed here only happens with a DT that gives the PHY node an
interrupt and wakeup-source. That requirement is mentioned only below the
--- line. The same goes for the need for the separate interrupt storm fix
[1] to get the 20 of 20 result. Both notes are dropped when the patch is
applied.

Also, on Helios64 phy-supply is vcc_lan, which is vcc3v3_sys_s3. That
regulator has regulator-always-on and regulator-on-in-suspend, so
releasing it does not cut PHY power on this board. That leaves the stopped
clocks as the only trigger the message describes.

Could the commit message say which configurations are affected, why the
board hangs, and that [1] is also needed?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 72bdbcb5e863a..06faeb156b97d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

[ ... ]

> @@ -1530,10 +1531,13 @@ static int rk_set_clk_tx_rate(void *bsp_priv_, struct clk *clk_tx_i,
>  
>  static int rk_gmac_suspend(struct device *dev, void *bsp_priv_)
>  {
> +	struct net_device *ndev = dev_get_drvdata(dev);
>  	struct rk_priv_data *bsp_priv = bsp_priv_;
>  
> -	/* Keep the PHY up if we use Wake-on-Lan. */
> -	if (!device_may_wakeup(dev))
> +	/* Keep the MAC and PHY powered if either of them wakes the system. */
> +	bsp_priv->suspend_powerdown = !device_may_wakeup(dev) &&
> +		!(ndev->phydev && phy_may_wakeup(ndev->phydev));

[Severity: Medium]
What happens here if PHY WoL was enabled and the interface was brought
down before suspend?

With the link up, "ethtool -s ethX wol g" is taken by the wakeup-capable
PHY. phylink masks it out of the MAC request, so device_may_wakeup() stays
false for the MAC.

"ip link set ethX down" then runs:

stmmac_release()
  phylink_disconnect_phy()
    phy_disconnect()
      phy_detach()
        phy_suspend()     <- RTL8211F arms PME (PHY_ALWAYS_CALL_SUSPEND)
        phydev->attached_dev->phydev = NULL;

phylib keeps a detached PHY like this armed on purpose, as shown in
mdio_bus_phy_may_suspend():

	if (!netdev && phy_may_wakeup(phydev))
		return false;

On system suspend, stmmac_suspend() jumps to suspend_bsp because the
interface is not running:

	if (!ndev || !netif_running(ndev))
		goto suspend_bsp;

Here ndev->phydev is NULL, so suspend_powerdown becomes true.
rk_gmac_powerdown() then gates the GMAC clocks and drops phy-supply while
the PHY is still the wake source. How bad this is depends on the board:
on Helios64 only the clocks stop, but where phy-supply can be switched
off, the PHY loses power.

Before 6911308d7d11, the MAC wakeup flag stayed set across ifdown for PHY
WoL, so the glue kept the GMAC powered. Should the new check also cover
this case?

[Severity: Low]
Is it safe to read ndev->phydev here without rtnl_lock()?

stmmac_suspend() drops rtnl before it calls the glue hook:

	rtnl_lock();
	phylink_suspend(priv->phylink, !!priv->wolopts);
	rtnl_unlock();
	...
suspend_bsp:
	if (priv->plat->suspend)
		return priv->plat->suspend(dev, priv->plat->bsp_priv);

It also does not cancel the service task. stmmac_reset_subtask() runs on
priv->wq, which is not freezable. It takes rtnl_lock() and does:

	set_bit(STMMAC_DOWN, &priv->state);
	dev_close(priv->dev);
	dev_open(priv->dev, NULL);

This clears ndev->phydev in phy_detach() and sets it again from
__stmmac_open().

A reset queued by stmmac_global_err() can overlap with rk_gmac_suspend().
If it does, suspend_powerdown can be decided while the PHY is halfway
through detach or attach, and rk_gmac_resume() reuses that decision
without checking again. In theory, if the compiler reloads ndev->phydev
between the NULL test and the call, phy_may_wakeup() could also be passed
NULL.

Would it help to read the pointer once with READ_ONCE() into a local, or
to do the check under rtnl_lock()?

[ ... ]

> @@ -1543,8 +1547,7 @@ static int rk_gmac_resume(struct device *dev, void *bsp_priv_)
>  {
>  	struct rk_priv_data *bsp_priv = bsp_priv_;
>  
> -	/* The PHY was up for Wake-on-Lan. */
> -	if (!device_may_wakeup(dev))
> +	if (bsp_priv->suspend_powerdown)
>  		rk_gmac_powerup(bsp_priv);
>  
>  	return 0;

[Severity: Medium]
This is a pre-existing issue, but rk_gmac_resume() drops the return value
of rk_gmac_powerup() and always returns 0.

rk_gmac_powerup() can fail in rk_gmac_check_ops(), rk_get_phy_intf_sel(),
gmac_clk_enable(), a GRF write, or regulator_enable() in rk_phy_powerup().
In that case stmmac_resume() never takes its error path:

	if (priv->plat->resume) {
		ret = priv->plat->resume(dev, priv->plat->bsp_priv);
		if (ret)
			return ret;
	}

Instead it goes on to access MAC registers with the clocks off.

A later rk_gmac_powerdown() would then call pm_runtime_put_sync() without
a matching get, and regulator_disable() on a regulator that is already
disabled.

Should rk_gmac_resume() return the error from rk_gmac_powerup()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930-dwmac-rk-phy-wol-v1-1-9fdc50bd9ae4%40iav.lv
