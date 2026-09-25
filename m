Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA85F37EFF1;
	Fri, 25 Sep 2026 02:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790301827; cv=none; b=ZXiZON1yeuO7pkwx2mWEWDv7atdqOB1iGSE/211DYfTYCZbhiqbL1WOaBnO4Uj+zjMaopL31CBlzjqvwbDehZrDX38cAcmaULYzUopQFsFJAnHaqq1HPKPr9pfh63rrm3qUX2m0ShRYlfJDvMrSH8QaBt+LtJi9JzwR49BA1BME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790301827; c=relaxed/simple;
	bh=5TdzdPd1ZudjF1IfQwVmzOo1WnxbsV31gIYvfeYWOoE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FomFnojks01CFrxTYSxmDpwxCXJ33bfixJENu7EkTII8U+WtJ49Sma8mNYxr5RmoPaUpic/8xZNeHYKW5YwyluOZgyNpzIHOMo0bc0vyItKNBIN4uwNX4to97jquJAa2AtSuofpyrvv6fEAsPF5PH01cwwp6kbgVbxZZnO91kP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNwRdyxi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNwRdyxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525B41F000FF;
	Fri, 25 Sep 2026 02:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790301825;
	bh=1tnkY2s2DVVGP0iyZfDIANfzMWWEVKjrYMrG/4nzmSI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iNwRdyxillxQFirsyCtD7IeNn3aKwEyrLa/8xQkOE1FR53L3zpRhrjb3YU84g71Kk
	 O+BlUBStNYsiPw4YVVAqX5K8+TPQ5Vd7c7rag+GKjlCY8nXrhIBlkq0MiyeQROUshv
	 YwNcIsGBMKsfMEOqgvN/h/C5d/9BJ9Ximm2efgOU2J3nd7SCumKjV0WthKszIRJljv
	 vSvFBOZ/gLgeLYFYpvoaRILt6Z3iqoi9iNG8U8rZbOXCVpg3WqmNxM1tUCz8Hw9WbW
	 cEW/oJNZ07w9ZZwo2WYUZC27bqJdpeiO33IlUNF/olv9DN0jjEKxi57UVOXTYx1bF/
	 ZjFWpE6EI1dEg==
Subject: Re: [PATCH net-next v10 07/11] net: pcs: xpcs: add Rockchip RK3568
 platform glue driver
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, vkoul@kernel.org,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 romain.gantois@bootlin.com, hkallweit1@gmail.com, neil.armstrong@linaro.org,
 linux@armlinux.org.uk, shawn.lin@rock-chips.com, david@ixit.cz,
 netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org
Date: Fri, 25 Sep 2026 02:03:43 +0000
Message-ID: <179030182389.2160803.3666914180615619528@kernel.org>
In-Reply-To: <20260922200336.2201212-8-coiaprant@gmail.com>
References: <20260922200336.2201212-8-coiaprant@gmail.com>
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

Critical: 0 · High: 1 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In drivers/net/pcs/pcs-xpcs-rk.c, xpcs_rk_system_suspend()
  relies solely on device_set_wakeup_path() to keep the PD_PIPE power…
- [Medium] xpcs_rk_mdio_write_remapping() (drivers/net/pcs/pcs-xpcs-
  rk.c:137-150) forces writes of DW_VR_MII_AN_CTRL,…
- [Medium] xpcs_rk_create() (drivers/net/pcs/pcs-xpcs-rk.c:537-546)
  dereferences the struct device_link * returned by device_link_add()…
- [Medium] Concern: xpcs_rk_create() validates the supplier with an
  unlocked read of the driver-core-internal field…
- [Low] Concern: xpcs_rk_create() is EXPORT_SYMBOL_GPL'ed and published
  in a new header include/linux/pcs/pcs-xpcs-rk.h with no in-tree caller…
- [Low] In xpcs_rk_create() (drivers/net/pcs/pcs-xpcs-rk.c:518-558) the
  comment justifying the device_link handling misstates the API…

--

net: pcs: xpcs: add Rockchip RK3568 platform glue driver

This adds a Rockchip RK3568 glue driver for the DesignWare XPCS that
exposes the APB3-mapped CSRs through a virtual MDIO bus, splits the
generic platform glue into its own PCS_XPCS_PLATFORM module, and adds
power-management handling for the shared PD_PIPE power domain.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 59, CRU_CLKSEL_CON29)
Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part2%20V1.1-20210301.pdf (Page 2078)

> diff --git a/drivers/net/pcs/pcs-xpcs-rk.c b/drivers/net/pcs/pcs-xpcs-rk.c
> new file mode 100644
> index 0000000000000..35ee980a759e5
> --- /dev/null
> +++ b/drivers/net/pcs/pcs-xpcs-rk.c
> @@ -0,0 +1,619 @@

[ ... ]

> +static int xpcs_rk_mdio_read_remapping(int addr, int dev, int reg)
> +{
> +	switch (dev) {
> +	case MDIO_MMD_PMAPMD:
> +		return ROCKCHIP_MMD_PMAPMD;
> +	case MDIO_MMD_VEND2:
> +		break;
> +	default:
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Reads are redirected by hardware to the port's read-only mirror;
> +	 * only writes have to be targeted at MII (see the write path).
> +	 */
> +	switch (addr) {
> +	case 0:
> +		return ROCKCHIP_MMD_MII;
> +	case 1:
> +		return ROCKCHIP_MMD_MII1;
> +	case 2:
> +		return ROCKCHIP_MMD_MII2;
> +	case 3:
> +		return ROCKCHIP_MMD_MII3;
> +	default:
> +		return -ENODEV;
> +	}
> +}
> +
> +static int xpcs_rk_mdio_write_remapping(int addr, int dev, int reg)
> +{
> +	switch (dev) {
> +	case MDIO_MMD_PMAPMD:
> +		return ROCKCHIP_MMD_PMAPMD;
> +	case MDIO_MMD_VEND2:
> +		break;
> +	default:
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * These registers physically live only in MII (the management port).
> +	 * Ports 1-3 expose read-only mirrors of these bits, so writes must
> +	 * always target MII; the read path remaps per address and the
> +	 * hardware redirects to the port's mirror.
> +	 */
> +	switch (reg) {
> +	case DW_VR_MII_AN_CTRL:
> +	case DW_VR_MII_AN_INTR_STS:
> +	case DW_VR_MII_EEE_MCTRL0:
> +	case DW_VR_MII_EEE_MCTRL1:
> +	case DW_VR_MII_DIG_CTRL2:
> +		return ROCKCHIP_MMD_MII;
> +	default:
> +		break;
> +	}

[Severity: Medium]
Reads and writes of the same (addr, reg) pair resolve to different MMDs for
addresses 1..3.  xpcs_rk_mdio_write_remapping() sends AN_CTRL, AN_INTR_STS,
EEE_MCTRL0/1 and DIG_CTRL2 to ROCKCHIP_MMD_MII before the per-address switch
is reached, while xpcs_rk_mdio_read_remapping() returns ROCKCHIP_MMD_MII1/2/3
for those same registers.  Since xpcs_rk_addr_format() folds the MMD into the
APB CSR index, the two accesses land on different physical offsets.

The unmodified core does read-modify-write on exactly these registers, e.g.
in xpcs_config_aneg_c37_sgmii():

	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL, mask, val);
	...
	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);

and in xpcs_get_state_c37_sgmii():

	an_intr = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS);
	if (an_intr & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR) {
		an_intr &= ~DW_VR_MII_AN_STS_C37_ANCMPLT_INTR;
		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, an_intr);

For port 1..3, is the value read from the port mirror then written back into
port 0's register, and is the autoneg-complete latch that was observed a
different one from the latch that gets acknowledged?

Two related questions on the same mapping:

AN_CTRL (PCS mode / TX_CONFIG) and the EEE registers become one shared
instance for all four ports with no serialization, yet the commit message
says ports 0..3 can be routed to GMAC0 or GMAC1 independently.  How is
cross-port clobbering avoided when two MACs configure their PCS?

DW_VR_MII_DIG_CTRL1, which holds VR_RST plus 2G5_EN/MAC_AUTO_SW and is
modified by the core in xpcs_config_aneg_c37_sgmii() and
xpcs_config_2500basex(), is not in the list and therefore goes to the
per-port MMD.  Does that contradict the comment's claim that such vendor
registers "physically live only in MII"?

[ ... ]

> +	/*
> +	 * Establish the device link before reading the supplier's drvdata.
> +	 * device_link_add() does not fail on a supplier that is unbinding:
> +	 * it creates the link in DL_STATE_SUPPLIER_UNBIND. Whether the link
> +	 * actually protects the drvdata depends on the supplier's state at
> +	 * creation time.
> +	 *
> +	 * Check link->supplier->links.status right after creation. If the
> +	 * supplier was DL_DEV_DRIVER_BOUND, the link is in
> +	 * DL_STATE_CONSUMER_PROBE and device_links_unbind_consumers() will
> +	 * wait for this probe to finish before unbinding the supplier, so
> +	 * the drvdata stays valid for the rest of the function. Any other
> +	 * state means the supplier is not usable yet; defer and retry.
> +	 *
> +	 * The link is released automatically when the consumer device is
> +	 * destroyed (DL_FLAG_AUTOREMOVE_CONSUMER), so no explicit
> +	 * device_link_remove() is needed on the failure paths.
> +	 */

[Severity: Low]
Two details in this comment in xpcs_rk_create() look inaccurate.

include/linux/device.h describes the flag as:

	/* Remove the link automatically on consumer driver unbind. */

so is "released automatically when the consumer device is destroyed" the
right wording?  The core drops such links from __device_links_no_driver() on
consumer probe failure or driver unbind, not at device destruction.

The claim that a DL_DEV_DRIVER_BOUND supplier implies DL_STATE_CONSUMER_PROBE
only holds while the consumer is DL_DEV_PROBING:

drivers/base/core.c:device_link_init_status() {
	case DL_DEV_DRIVER_BOUND:
		switch (consumer->links.status) {
		case DL_DEV_PROBING:
			link->status = DL_STATE_CONSUMER_PROBE;
	...
}

An already-bound consumer gets DL_STATE_ACTIVE and anything else gets
DL_STATE_AVAILABLE.  Could the comment (or the kernel-doc of the exported
helper) state that xpcs_rk_create() must be called from the consumer's probe?

> +	link = device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> +	if (!link) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	if (READ_ONCE(link->supplier->links.status) != DL_DEV_DRIVER_BOUND) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}

[Severity: Medium]
Is it valid to dereference the pointer returned by device_link_add() here?
DL_FLAG_STATELESS is not passed, so this is a managed link, and the
kernel-doc above device_link_add() says:

 * If that flag is not set, however, the caller of this function is handing the
 * management of the link over to the driver core entirely and its return value
 * can only be used to check whether or not the link is present.

No kref is taken for managed links (kref_get() only happens on the stateless
path), so the caller owns no reference on the link object, which the core can
free from device_link_drop_managed() -> kref_put(&link->kref,
__device_link_del) or from device_del() -> device_links_purge().

Since link->supplier is just &pdev->dev, and this function already holds a
reference on pdev from of_find_device_by_node(), would reading
pdev->dev.links.status instead give the same result without touching the
link object?

> +	pxpcs = platform_get_drvdata(pdev);
> +	if (!pxpcs || !pxpcs->bus) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	xpcs = xpcs_create_mdiodev(pxpcs->bus, (int)port);

[Severity: Medium]
This is a check on a driver-core-internal field (links.status) followed by
use of the supplier's devm-owned data (pxpcs->bus, pxpcs->eee_mult_fact) and
registration of an MDIO device on that bus.

For the in-tree caller the window does look closed: rk_pcs_init() runs from
stmmac_pcs_setup() in __stmmac_dvr_probe(), so the consumer is DL_DEV_PROBING
and the new link is DL_STATE_CONSUMER_PROBE, which makes the supplier wait:

drivers/base/core.c:device_links_unbind_consumers() {
	if (status == DL_STATE_CONSUMER_PROBE) {
		device_links_write_unlock();

		wait_for_device_probe();
		goto start;
	}
}

But xpcs_rk_create() is exported and does not document that precondition.
For a caller outside the consumer's probe the link would be
DL_STATE_AVAILABLE or DL_STATE_ACTIVE, nothing would wait for it, and the
supplier's devres could be released while pxpcs->bus is in use.  Also note
that xpcs_rk_create_data() publishes drvdata before bus and eee_mult_fact
exist:

	pxpcs->pdev = pdev;

	dev_set_drvdata(&pdev->dev, pxpcs);

so the read here relies entirely on the supplier being fully bound.  Would
it be preferable to document the probe-context requirement, or to avoid
inspecting links.status from a driver altogether?

> +EXPORT_SYMBOL_GPL(xpcs_rk_create);

[Severity: Low]
At this commit xpcs_rk_create() has no in-tree caller, and the new header
include/linux/pcs/pcs-xpcs-rk.h declares it without a
!CONFIG_PCS_XPCS_ROCKCHIP stub.  The caller does arrive later in the same
series (rk_pcs_init() in drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
calls it and is installed as plat_dat->pcs_init for
PHY_INTERFACE_MODE_SGMII), and DWMAC_ROCKCHIP does "select
PCS_XPCS_ROCKCHIP", which forces the tristate to at least the selector's
value, so there is no y/m link mismatch either.  Noting it only because the
symbol is unused at this point in the series.

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
Does device_set_wakeup_path() actually keep PD_PIPE powered on RK3568?  The
commit message states:

	genpd then leaves the domain powered, because the Rockchip power
	domain driver sets GENPD_FLAG_ACTIVE_WAKEUP on PD_PIPE, which makes
	genpd check the wakeup path of its consumers during system suspend.

PD_PIPE is registered without active wakeup in
drivers/pmdomain/rockchip/pm-domains.c:

	[RK3568_PD_PIPE]	= DOMAIN_RK3568("pipe", BIT(8), BIT(11), false, false),

The last argument is the wakeup flag, so pd_info->active_wakeup stays false
and GENPD_FLAG_ACTIVE_WAKEUP is never set for this domain.  genpd only
honours the consumer wakeup path when that flag is present:

drivers/pmdomain/core.c:genpd_finish_suspend() {
	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd) &&
	    !device_out_band_wakeup(dev))
		return 0;
}

Without the flag, does genpd fall through to genpd_sync_power_off() and power
PD_PIPE down, which is exactly the situation the probe comment warns about
("The domain must be powered on before any register access, otherwise the SoC
will trigger a synchronous external abort")?

dev_pm_genpd_rpm_always_on() does not appear to cover the system-suspend path
either; genpd_sync_power_off() only consults GENPD_FLAG_ALWAYS_ON:

drivers/pmdomain/core.c:genpd_sync_power_off() {
	if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
		return;
}

If the domain is power-cycled, what restores the hardware on the way back up?
phy_init() and phy_power_on() are called once from xpcs_rk_probe() via
xpcs_rk_serdes_phy_poweron(), xpcs_rk_system_resume() returns 0 without
re-initialising the SerDes or the PCS, and
drivers/phy/rockchip/phy-rockchip-naneng-combphy.c has no dev_pm_ops at all.
Does that leave the combphy and XPCS at power-on-reset defaults (no SerDes
configuration, no SerDes TX clock) after resume while the driver, the xpcs
core and phylink still assume the programmed configuration is live, and MAC
WoL, the stated reason for the mechanism, non-functional?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922200336.2201212-1-coiaprant%40gmail.com
