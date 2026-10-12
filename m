Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497E0424D6B;
	Mon, 12 Oct 2026 19:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831692; cv=none; b=bEJldK4mKkvA1YC89JA3r1oFveSiwXomn1Mbn7q3yVeYx4hkPkt0cHLTkO6iq02fll6UaeFhsPPxNRHvisXRhLdcH1jv9A4CeD6mKiyqLfEkLRn5bolVvkl4oVNvXrdlfkdayWy3rJuyhMMjK9VoTQDE5S3A0ievNKy8wSWq8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831692; c=relaxed/simple;
	bh=SVulfABCSF2DjMkV/iDE+/N9i7JqLudl7A/jX1X0Y3k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VKKO6aV2XEARTtWTVc6NWy8+YqTkEVU6vpwI47rVBgcEDKUPv35+ERmL1Pj3pYxIMHOqDuj0z9Q5Mv72KJ9CiAGxBYskcsAM5chIvheJeJlbUUXW0n3vmZHyFROyuH9oAq2WUC18H3n+rRUDla8HS5X7aTXi/E4gVNdfXHDu8b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw2W5zPk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw2W5zPk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260641F0089B;
	Mon, 12 Oct 2026 19:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831690;
	bh=N14pcaI8uCBCbhFTbz7e4hnbVvBNCCVccm2OMr/cMs0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Gw2W5zPk0uXvrXNEEDmv7p/zEM3ieV/5bfoaMHWmPpMOHZXo2iPaMZ3JtAAbxSmPx
	 +EMo7aBx41bWuJ8+gDPWfsOeP8DAKH0/46b6N8eQnGi95s5tDpcPPE54cVx+qTo+Rw
	 /7tnaP54M3Ra2lguoahOXFFA4Weli5UAYg5rOEyLhG9L1Y95EIxKDam50Dm+qd9WEw
	 Ydz0mIiw4qXrGEsjM7uGr6VDT381rq3SeEVlbcZCNjnT7GeAcIAD8Kt0zzXPWSkZ0o
	 D97UpaAmSzMPGiSSZAKPwjPsXGsi4oXOWLUPletUR4iprgyUHHARUiB5eTyOzjGXbm
	 XmRMulQlGD1Hg==
Subject: Re: [PATCH net-next v11 3/6] net: pcs: xpcs: add Rockchip RK3568
 platform glue driver
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 david.wu@rock-chips.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 19:01:28 +0000
Message-ID: <179183168873.434549.8116321142686860038@kernel.org>
In-Reply-To: <20261008175225.3375274-4-coiaprant@gmail.com>
References: <20261008175225.3375274-4-coiaprant@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The system-suspend path does not keep PD_PIPE powered, so the
  commit message's claim is false.
- [Medium] xpcs_rk_create() lets the supplier unbind while it is still
  using the supplier's data (time-of-check/time-of-use).
- [Low] Concern: xpcs_rk_create() is exported but nothing in the tree
  calls it.
- [Low] Concern: PCS_XPCS_ROCKCHIP uses `select PM_GENERIC_DOMAINS if PM`
  and has no `depends on PM`, so with CONFIG_PM=n the driver can build…
- [Low] Concern: "rockchip,rk3568-xpcs" and its required properties have
  no DT binding.

--

net: pcs: xpcs: add Rockchip RK3568 platform glue driver

This adds a platform glue driver for the Synopsys XPCS on RK3568. The
driver exposes the APB3-mapped XPCS registers as a virtual MDIO bus for
the generic pcs-xpcs core. It also moves pcs-xpcs-plat.o into its own
module behind PCS_XPCS_PLATFORM, and marks the XPCS as part of the wakeup
path during system suspend so that PD_PIPE stays powered for MAC WoL.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 59, CRU_CLKSEL_CON29)
Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part2%20V1.1-20210301.pdf (Page 2078)

> diff --git a/drivers/net/pcs/pcs-xpcs-rk.c b/drivers/net/pcs/pcs-xpcs-rk.c
> new file mode 100644
> index 0000000000000..698a43b753341
> --- /dev/null
> +++ b/drivers/net/pcs/pcs-xpcs-rk.c

[ ... ]

> +struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *pcs, int port)
> +{

[ ... ]

> +	if (!device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER)) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	if (READ_ONCE(pdev->dev.links.status) != DL_DEV_DRIVER_BOUND) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	pxpcs = platform_get_drvdata(pdev);
> +	if (!pxpcs || !pxpcs->bus) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	xpcs = xpcs_create_mdiodev(pxpcs->bus, port);

[Severity: Medium]
Can the XPCS be unbound while xpcs_rk_create() is still using pxpcs and
pxpcs->bus?

The check above reads the supplier's own links.status. It does not look
at the state of the link that device_link_add() returned. Supplier unbind
is blocked only for links in DL_STATE_CONSUMER_PROBE or DL_STATE_ACTIVE:

drivers/base/core.c:device_links_busy() {
    ...
		if (link->status == DL_STATE_CONSUMER_PROBE
		    || link->status == DL_STATE_ACTIVE) {
			ret = true;
    ...
}

Suppose the XPCS has no driver when device_link_add() runs from the GMAC
probe. device_link_init_status() then starts the link in
DL_STATE_DORMANT. If the XPCS finishes probing before the READ_ONCE()
check, device_links_driver_bound() moves the link to DL_STATE_AVAILABLE.

In that case the DL_DEV_DRIVER_BOUND check passes, but an AVAILABLE link
does not make device_links_busy() return true. A sysfs unbind of the XPCS
can then run devres_release_all() and free pxpcs and the devm mii_bus
while xpcs_rk_create() is still using them in platform_get_drvdata(),
pxpcs->bus, xpcs_create_mdiodev() and pxpcs->eee_mult_fact. This window
stays open until the GMAC probe completes.

The comment above says a small window remains. Is this AVAILABLE case the
window it means? Would checking that the returned link is in
DL_STATE_CONSUMER_PROBE, instead of checking pdev->dev.links.status,
close it?

> +	if (IS_ERR(xpcs)) {
> +		put_device(&pdev->dev);
> +		return xpcs;
> +	}
> +
> +	xpcs_config_eee_mult_fact(xpcs, pxpcs->eee_mult_fact);
> +	put_device(&pdev->dev);
> +	return xpcs;
> +}
> +EXPORT_SYMBOL_GPL(xpcs_rk_create);

[Severity: Low]
This isn't a bug, but nothing in the tree calls xpcs_rk_create() at this
point in the series.

The user arrives later in "net: stmmac: dwmac-rk: add SGMII support for
RK3568". There, rk_pcs_init() calls xpcs_rk_create(priv->device,
pcs_node, bsp_priv->id) and DWMAC_ROCKCHIP selects PCS_XPCS_ROCKCHIP, so
this is resolved by the end of the series.

[ ... ]

> +static int xpcs_rk_system_suspend(struct device *dev)
> +{
> +	/*
> +	 * Keep the PD_PIPE power domain on during system suspend.
> +	 *
> +	 * PD_PIPE is shared with SATA/PCIe and would be powered down by
> +	 * genpd once all its consumers are suspended, killing the SerDes
> +	 * and breaking MAC WoL.  Mark the XPCS as part of the wakeup path
> +	 * so genpd keeps the domain on.  Unconditional because the XPCS
> +	 * core has no callback to convey the MAC WoL state.
> +	 */
> +	device_set_wakeup_path(dev);
> +	return 0;
> +}
> +
> +static int xpcs_rk_system_resume(struct device *dev)
> +{
> +	return 0;
> +}

[Severity: High]
Does device_set_wakeup_path() actually keep PD_PIPE powered here?

The commit message says genpd leaves the domain on "because the Rockchip
power domain driver sets GENPD_FLAG_ACTIVE_WAKEUP on PD_PIPE". However,
PD_PIPE is declared with wakeup set to false:

drivers/pmdomain/rockchip/pm-domains.c:
	[RK3568_PD_PIPE]	= DOMAIN_RK3568("pipe", BIT(8), BIT(11), false, false),

The flag is only added when active_wakeup is set:

drivers/pmdomain/rockchip/pm-domains.c:rockchip_pm_add_one_domain() {
    ...
	if (pd_info->active_wakeup)
		pd->genpd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
    ...
}

genpd_finish_suspend() skips the power-off only when both conditions are
true:

drivers/pmdomain/core.c:genpd_finish_suspend() {
    ...
	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd) &&
	    !device_out_band_wakeup(dev))
		return 0;
    ...
}

For PD_PIPE the XPCS is therefore counted in suspended_count. Once the
SerDes, SATA, PCIe and XPCS consumers have all suspended,
genpd_sync_power_off() turns the domain off. dev_pm_genpd_rpm_always_on()
only covers runtime PM, not this system sleep path. Nothing else in the
series changes drivers/pmdomain/.

If the domain does turn off, won't MAC WoL stop working? Won't the SerDes
and XPCS also come back at their reset defaults? xpcs_rk_system_resume()
is empty, so after resume nothing repeats phy_init()/phy_power_on() or
restores any XPCS state.

Would this need GENPD_FLAG_ACTIVE_WAKEUP set on PD_PIPE in the pmdomain
driver (or some other way to keep the domain on), plus a real resume
path?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008175225.3375274-1-coiaprant%40gmail.com
