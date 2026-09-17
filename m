Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB4C4DDB22;
	Thu, 17 Sep 2026 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670303; cv=none; b=D5g9EdBthH9RQRniiOv1U9TLMGlA+cCd9o1G9Wy2A++Dz6NpHnHKf0/ePKKJjtrXyXofzPKzBSAYJrgeATXx1orggJSJ84SkLGPuPyc9lGT0xpWBC45Sfy9hOgcG0AVnEmx4v1cpUTYo40A6s1eViMOuBWyMJYVNqqUYBAtXcs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670303; c=relaxed/simple;
	bh=TeBt3V75PWrgMgZAfS44/kWsqJiDkKvpRXfk3qwt+G8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ocouap1fPfzb7v23/V/9Jc/152kRA3tlLhkj9GT9G52RvW0JmeBo49xcfU4koA0hzccUWuYSWGCeBInAgFwYv/1x9dgFfvdeV9i0YUsk/F4PaIMnnY3Zl8a5qPaMOsniu9a41CgsavofzV0Zh7OPUvqlZkrZ0ieM1qgl95EFl4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtT0qAnc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtT0qAnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C0D1F00893;
	Thu, 17 Sep 2026 18:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789670299;
	bh=vFJ83dMavxspRJfLpFnxL1Ynn4WHazaHxF4+mLoUoh0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TtT0qAncIsE0NdFY499mMj//R50cs4AdsXWOfmeM8g2EHmgl+yPNKVetgo5+4znqp
	 Pked6mWyZWn9a6UCikf4Nlz2Z3y3OV2E2YwcT/jGCyJtV33fCjDZA45dxLWDN92I+Q
	 hw0ReQFMJbDTzzO+CX/whVzGNiMKR3yVuRwfngI4eji7WkthrkBUyzvPOAWgNMl2ou
	 oeaArbMA+ThOZN1dBM6z1RUUmOr11rLEUQSUQ3PKAR1+xHgT+5Q3lRBC8ZYgtk9Kup
	 y6IO1+EkVloopQfNBvRuU5//iGNEZgNrV7m30+PqaBjoit0gJ2KdglSkLG07BpbLrA
	 sJDl7z+xPG0iQ==
Subject: Re: [PATCH net-next v6 07/11] net: pcs: xpcs: add Rockchip RK3568
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
 linux-stm32@st-md-mailman.stormreply.com, linux-renesas-soc@vger.kernel.org
Date: Thu, 17 Sep 2026 18:38:18 +0000
Message-ID: <178967029805.22033.5645939036963586824@kernel.org>
In-Reply-To: <20260915123802.1561724-8-coiaprant@gmail.com>
References: <20260915123802.1561724-8-coiaprant@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 3 · Low: 5

- [High] xpcs_rk_create() creates an implicitly managed device link
  (device_link_add() with only DL_FLAG_AUTOREMOVE_CONSUMER, so…
- [High] xpcs_rk_create() reads another device's driver-private data with
  platform_get_drvdata() without holding device_lock(&pdev->dev) and…
- [Medium] PCS_XPCS_ROCKCHIP does 'select PM_GENERIC_DOMAINS' without
  'depends on PM'.
- [Medium] Read/write MMD asymmetry for the vendor registers:
  xpcs_rk_mdio_read_remapping() maps every MDIO_MMD_VEND2 read by port…
- [Medium] xpcs_get_state_c37_sgmii() now unconditionally clears
  DW_VR_MII_AN_INTR_STS and writes BMCR_ANRESTART for every latched AN-…
- [Low] xpcs_rk_create() is exported with no in-tree caller at this
  commit (drivers/net/pcs/pcs-xpcs-rk.c), and include/linux/pcs/pcs-…
- [Low] The binding marks phys/phy-names as required and the driver
  treats a missing "serdes" PHY as a fatal probe error…
- [Low] The RK3568 binding description advertises QSGMII while the
  generic Synopsys XPCS compatibility table has no…
- [Low] When MMD remapping fails (any MMD other than MDIO_MMD_PMAPMD or
  MDIO_MMD_VEND2, for which the remappers return -ENXIO), the MDIO bus…
- [Low] net: pcs: integer underflow in EEE multiplier calculation

--

net: pcs: xpcs: add Rockchip RK3568 platform glue driver

This adds a Rockchip RK3568 glue driver that exposes the SoC's APB3-mapped
DesignWare XPCS as a virtual MDIO bus for the generic pcs-xpcs core, with
per-port MMD remapping for the four MII ports.  It also splits the generic
platform glue out of the pcs_xpcs composite object behind a new
PCS_XPCS_PLATFORM symbol.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 59, CRU_CLKSEL_CON29)
Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part2%20V1.1-20210301.pdf (Page 2078)

A few questions below.

> diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
> index e417fd66f660a..3db9b343ac0c7 100644
> --- a/drivers/net/pcs/Kconfig
> +++ b/drivers/net/pcs/Kconfig
> @@ -12,6 +12,31 @@ config PCS_XPCS
>  	  This module provides a driver and helper functions for Synopsys
>  	  DesignWare XPCS controllers.
>  
> +if PCS_XPCS
> +
> +config PCS_XPCS_PLATFORM
> +	tristate "Generic XPCS controller support"
> +	default PCS_XPCS
> +	help
> +	  Generic DWXPCS driver for platforms that don't require any
> +	  platform specific code to function or is using platform
> +	  data for setup.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +config PCS_XPCS_ROCKCHIP
> +	tristate "Rockchip XPCS controller support"
> +	default ARCH_ROCKCHIP
> +	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
> +	select GENERIC_PHY
> +	select PM_GENERIC_DOMAINS

[Severity: Medium]
Should PCS_XPCS_ROCKCHIP also carry "depends on PM"?

PM_GENERIC_DOMAINS in kernel/power/Kconfig is:

  config PM_GENERIC_DOMAINS
	bool
	depends on PM

Since select does not propagate dependencies, does a COMPILE_TEST or
randconfig build with CONFIG_PM=n force PM_GENERIC_DOMAINS on with unmet
direct dependencies, i.e. the sym_warn_unmet_dep() warning?

The same missing dependency looks functional as well.  The APB3/CSR clock
is only ever prepared in the runtime resume callback:

  static int xpcs_rk_pm_runtime_resume(struct device *dev)
  {
	struct dw_xpcs_rk *pxpcs = dev_get_drvdata(dev);

	return clk_prepare_enable(pxpcs->csr_clk);
  }

which is reachable only through .pm = pm_ptr(&xpcs_rk_pm_ops), and pm_ptr()
is NULL when CONFIG_PM=n.  In that configuration
pm_runtime_resume_and_get() in xpcs_rk_read_reg()/xpcs_rk_write_reg()
returns 0 without invoking any callback, so does every readl()/writel() on
reg_base then run with the CSR clock gated?  That is the abort case the
probe comment warns about.

Would "depends on PM" (or "depends on PM_GENERIC_DOMAINS") instead of
"select PM_GENERIC_DOMAINS" be the right expression here?

> +	help
> +	  Support for XPCS controller on Rockchip RK356x SoC.
> +
> +	  If you have a Rockchip SoC with this interface, say Y or M here.
> +
> +endif # PCS_XPCS
> +
>  config PCS_LYNX
>  	tristate
>  	help

[ ... ]

> diff --git a/drivers/net/pcs/pcs-xpcs-rk.c b/drivers/net/pcs/pcs-xpcs-rk.c
> new file mode 100644
> index 0000000000000..d5e0f22c973c2
> --- /dev/null
> +++ b/drivers/net/pcs/pcs-xpcs-rk.c

[ ... ]

> +#define ROCKCHIP_MMD_MII1	2
> +#define ROCKCHIP_MMD_MII2	3
> +#define ROCKCHIP_MMD_MII3	4
> +#define ROCKCHIP_MMD_PMAPMD	6
> +#define ROCKCHIP_MMD_MII	7

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

[Severity: Medium]
Reads of MDIO_MMD_VEND2 are remapped per port address (MMD 7/2/3/4), while
writes of these five registers always go to MMD 7.  How does that interact
with the read-modify-write sequences the core performs on exactly these
registers?

For a PCS on port 1, xpcs_do_config() does:

  xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL, mask, val);

which reads MMD 2 and writes the computed value into MMD 7.  Is the value
written derived from the register that is actually being modified, and can
the mdio_lock make that pair atomic when the two halves land in different
physical blocks?

Two further cases look related:

  - DW_VR_MII_AN_INTR_STS is write-to-clear and is cleared by
    xpcs_get_state_c37_sgmii() and by the AN handling paths.  With every
    port clearing MMD 7, can one port consume another port's latched
    AN-complete indication?

  - xpcs_config_eee() clears DW_VR_MII_EEE_MCTRL0/1 on disable.  With two
    ports routed to different GMACs, does disabling EEE on one port clear
    the LPI controls of the other?

If these registers really are global to the block, should the provider
arbitrate them (or refuse more than one active port) rather than letting
each phylink_pcs instance program them independently?

> +	default:
> +		break;
> +	}
> +
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

[ ... ]

> +static int xpcs_rk_read_c45(struct mii_bus *bus, int addr, int dev, int reg)
> +{
> +	struct dw_xpcs_rk *pxpcs = bus->priv;
> +
> +	if (!xpcs_rk_mdio_addr_validate(addr))
> +		return -ENODEV;
> +
> +	dev = xpcs_rk_mdio_read_remapping(addr, dev, reg);
> +	if (dev < 0)
> +		return 0xffff;
> +
> +	return xpcs_rk_read_reg(pxpcs, dev, reg);
> +}
> +
> +static int xpcs_rk_write_c45(struct mii_bus *bus, int addr, int dev, int reg, u16 val)
> +{
> +	struct dw_xpcs_rk *pxpcs = bus->priv;
> +
> +	if (!xpcs_rk_mdio_addr_validate(addr))
> +		return -ENODEV;
> +
> +	dev = xpcs_rk_mdio_write_remapping(addr, dev, reg);
> +	if (dev < 0)
> +		return 0;
> +
> +	return xpcs_rk_write_reg(pxpcs, dev, reg, val);
> +}

[Severity: Low]
When the remapping returns -ENXIO (any MMD other than MDIO_MMD_PMAPMD or
MDIO_MMD_VEND2), the bus callbacks fabricate a result instead of reporting
the error: the read paths return 0xffff and the write paths return 0 as if
the APB3 transaction had happened.  The c22 wrappers do the same.

For the modes this glue supports the only reachable user appears to be
xpcs_read_ids(), which tolerates id == 0xffffffff and falls back to
MDIO_MMD_VEND2, so the fabricated value is load-bearing for probe and
returning the errno instead would make xpcs_read_ids() fail with -ENODEV.

Given that, could this behaviour at least get a comment saying that
unsupported MMDs are deliberately faked so probe keeps working?  And would
it be better for the instance to advertise only the interfaces this MMD map
can actually serve, so a future C73 path does not silently write into
nothing?

> +
> +static struct dw_xpcs_rk *xpcs_rk_create_data(struct platform_device *pdev)
> +{

[ ... ]

> +static int xpcs_rk_serdes_phy_init(struct dw_xpcs_rk *pxpcs)
> +{
> +	struct device *dev = &pxpcs->pdev->dev;
> +
> +	pxpcs->serdes_phy = devm_phy_get(dev, "serdes");
> +	if (IS_ERR(pxpcs->serdes_phy))
> +		return dev_err_probe(dev, PTR_ERR(pxpcs->serdes_phy),
> +					"Failed to get SerDes PHY\n");
> +
> +	return 0;
> +}

[Severity: Low]
This makes a missing "serdes" phy fatal for probe, and the binding added
earlier in the series lists phys and phy-names under required:, but the
SoC-level node in arch/arm64/boot/dts/rockchip/rk3568.dtsi
(ethernet-pcs@fda00000) has neither property - only
rk3568-photonicat.dts adds:

  phys = <&combphy2 PHY_TYPE_SGMII>;
  phy-names = "serdes";

Does "make dtbs_check" then report "'phys' is a required property" for
every rk3568 dtb that includes rk3568.dtsi, given that dt-validate also
checks disabled nodes?  And does a board that only flips &xpcs to
status = "okay" get an unexplained probe failure here?

Would dropping phys/phy-names from required: (leaving them to board level)
or adding the phys reference to the SoC dtsi be the intended arrangement?

[ ... ]

> +struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *np)
> +{

[ ... ]

> +	pdev = of_find_device_by_node(pcs_np);
> +	of_node_put(pcs_np);
> +	if (!pdev)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	if (!device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER)) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	pxpcs = platform_get_drvdata(pdev);
> +	if (!pxpcs || !pxpcs->bus) {
> +		device_link_remove(dev, &pdev->dev);

[Severity: High]
Can device_link_remove() actually drop this link?

device_link_add() is called with only DL_FLAG_AUTOREMOVE_CONSUMER, so
DL_FLAG_STATELESS is absent and the core adds DL_FLAG_MANAGED.  In
drivers/base/core.c, device_link_remove() -> device_link_put_kref() then
takes:

  if (device_link_test(link, DL_FLAG_STATELESS))
	kref_put(&link->kref, __device_link_del);
  else if (!device_is_registered(link->consumer))
	__device_link_del(&link->kref);
  else
	WARN(1, "Unable to drop a managed device link reference\n");

The consumer here is the stmmac device, which is registered, so does this
hit the WARN(1) splat (and panic with panic_on_warn) while leaving the link
in place?

The -EPROBE_DEFER path looks easy to reach: "pcs-handle" is not among the
fw_devlink-parsed properties in drivers/of/property.c, so nothing orders
the GMAC probe after the XPCS probe.  Whenever the GMAC probes first,
device_link_add() succeeds and platform_get_drvdata() returns NULL.

Would it be simpler to create the link only after the fallible XPCS
creation has succeeded (calling xpcs_destroy() if the link then fails), or
to use device_link_del() / a stateless link consistently?

> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	xpcs = xpcs_create_mdiodev(pxpcs->bus, (int)port);

[Severity: High]
Is reading the supplier's drvdata here safe against the supplier
unbinding?

This runs from another device's probe (rk_pcs_init() during stmmac probe),
without device_lock(&pdev->dev) and without a device_is_bound() check.  In
drivers/base/dd.c, device_unbind_cleanup() does:

  devres_release_all(dev);
  ...
  device_set_driver(dev, NULL);
  dev_set_drvdata(dev, NULL);

So if the XPCS probe fails (for example -EPROBE_DEFER from
devm_phy_get(dev, "serdes")) or the device is unbound while this function
sits between device_link_add() and platform_get_drvdata(), the devm
allocation holding pxpcs is already freed while drvdata still points at
it.  Does the "!pxpcs || !pxpcs->bus" test then read freed memory, and can
the freed devm mii_bus be handed to xpcs_create_mdiodev()?

Note also that device_link_add() does not block an unbinding supplier
(device_link_init_status() just assigns DL_STATE_SUPPLIER_UNBIND), and
__device_release_driver() does not re-check for consumers appearing after
its device_links_busy() loop.

Related to this, xpcs_rk_create_data() publishes the structure at the very
start of probe:

  pxpcs->pdev = pdev;

  dev_set_drvdata(&pdev->dev, pxpcs);

while reg_base, the clocks, eee_mult_fact and bus are filled in later, and
xpcs_rk_init_bus() ends with a plain "pxpcs->bus = bus;".  Is the non-NULL
bus field being used as a cross-device readiness flag without any
release/acquire pairing?

Would validating the supplier under device_lock(&pdev->dev) with
device_is_bound(), and holding a reference for the lifetime of the returned
dw_xpcs (the pdev reference is dropped with put_device() before returning,
and mdio_device_create() never registers on the bus), close this?

> +	if (IS_ERR(xpcs)) {
> +		device_link_remove(dev, &pdev->dev);
> +		put_device(&pdev->dev);
> +		return xpcs;
> +	}
> +
> +	xpcs_config_eee_mult_fact(xpcs, pxpcs->eee_mult_fact);
> +	put_device(&pdev->dev);
> +	return xpcs;
> +}
> +EXPORT_SYMBOL_GPL(xpcs_rk_create);

[ ... ]

One more question about a different patch in the same series, "net: pcs:
xpcs: add ANRESTART support for SGMII link recovery", since it interacts
with this driver:

[Severity: Medium]
In xpcs_get_state_c37_sgmii() (drivers/net/pcs/pcs-xpcs.c) the status
clear was turned into a clear plus an AN restart:

  if (state->an_complete) {
	/* Clear AN complete status or interrupt */
	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
	...
	/* Initiate the next round of AN */
	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, BMCR_ANRESTART,
			  BMCR_ANRESTART);

The changelog describes this as an RK3568 timing quirk, but the code has no
device-ID or quirk gate and no link-transition tracking, so it applies to
every DesignWare XPCS in DW_AN_C37_SGMII mode.

The block is entered whenever DW_VR_MII_AN_STS_C37_ANCMPLT_INTR is set and
DW_VR_MII_C37_ANSGM_SP_LNKSTS is clear, which is a legitimate state (PCS
configuration exchange complete, PHY link still down).

Does that mean an AN restart is issued once per poll interval, for as long
as the attached PHY reports AN complete with link down, on parts that do
not need the workaround?  Should the restart be gated on a per-device
quirk?

[ ... ]

> @@ -0,0 +1,573 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Rockchip XPCS platform device driver
> + *
> + * Based on the Synopsys DesignWare XPCS platform driver.
> + * Copyright (C) 2024 Serge Semin
> + *
> + * Adapted for Rockchip SoCs, with reference to the Rockchip OEM driver.
> + * Copyright (C) 2026 Coia Prant
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/math.h>
> +#include <linux/mdio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/pcs/pcs-xpcs-rk.h>
> +#include <linux/phy.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +#include <linux/sizes.h>
> +#include <linux/time.h>
> +
> +#include "pcs-xpcs.h"
> +
> +struct dw_xpcs_rk {
> +	struct platform_device *pdev;
> +	struct mii_bus *bus;
> +	void __iomem *reg_base;
> +	struct phy *serdes_phy;
> +	struct clk *csr_clk;
> +	struct clk *eee_clk;
> +	u8 eee_mult_fact;
> +};
> +
> +static ptrdiff_t xpcs_rk_addr_format(int dev, int reg)
> +{
> +	return FIELD_PREP(0x70000, dev) | FIELD_PREP(0xffff, reg);
> +}
> +
> +static int xpcs_rk_read_reg(struct dw_xpcs_rk *pxpcs, int dev, int reg)
> +{
> +	ptrdiff_t csr;
> +	int ret;
> +
> +	csr = xpcs_rk_addr_format(dev, reg);
> +
> +	ret = pm_runtime_resume_and_get(&pxpcs->pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = readl(pxpcs->reg_base + (csr << 2)) & 0xffff;
> +
> +	pm_runtime_put(&pxpcs->pdev->dev);
> +	return ret;
> +}
> +
> +static int xpcs_rk_write_reg(struct dw_xpcs_rk *pxpcs, int dev, int reg, u16 val)
> +{
> +	ptrdiff_t csr;
> +	int ret;
> +
> +	csr = xpcs_rk_addr_format(dev, reg);
> +
> +	ret = pm_runtime_resume_and_get(&pxpcs->pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	writel(val, pxpcs->reg_base + (csr << 2));
> +
> +	pm_runtime_put(&pxpcs->pdev->dev);
> +	return 0;
> +}
> +
> +#define ROCKCHIP_MMD_MII1	2
> +#define ROCKCHIP_MMD_MII2	3
> +#define ROCKCHIP_MMD_MII3	4
> +#define ROCKCHIP_MMD_PMAPMD	6
> +#define ROCKCHIP_MMD_MII	7
> +
> +static bool xpcs_rk_mdio_addr_validate(int addr)
> +{
> +	return !(addr < 0 || addr > 3);
> +}
> +
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
> +
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
> +static int xpcs_rk_read_c22(struct mii_bus *bus, int addr, int reg)
> +{
> +	struct dw_xpcs_rk *pxpcs = bus->priv;
> +	int dev;
> +
> +	if (!xpcs_rk_mdio_addr_validate(addr))
> +		return -ENODEV;
> +
> +	dev = xpcs_rk_mdio_read_remapping(addr, MDIO_MMD_VEND2, reg);
> +	if (dev < 0)
> +		return 0xffff;
> +
> +	return xpcs_rk_read_reg(pxpcs, dev, reg);
> +}
> +
> +static int xpcs_rk_write_c22(struct mii_bus *bus, int addr, int reg, u16 val)
> +{
> +	struct dw_xpcs_rk *pxpcs = bus->priv;
> +	int dev;
> +
> +	if (!xpcs_rk_mdio_addr_validate(addr))
> +		return -ENODEV;
> +
> +	dev = xpcs_rk_mdio_write_remapping(addr, MDIO_MMD_VEND2, reg);
> +	if (dev < 0)
> +		return 0;
> +
> +	return xpcs_rk_write_reg(pxpcs, dev, reg, val);
> +}
> +
> +static int xpcs_rk_read_c45(struct mii_bus *bus, int addr, int dev, int reg)
> +{
> +	struct dw_xpcs_rk *pxpcs = bus->priv;
> +
> +	if (!xpcs_rk_mdio_addr_validate(addr))
> +		return -ENODEV;
> +
> +	dev = xpcs_rk_mdio_read_remapping(addr, dev, reg);
> +	if (dev < 0)
> +		return 0xffff;
> +
> +	return xpcs_rk_read_reg(pxpcs, dev, reg);
> +}
> +
> +static int xpcs_rk_write_c45(struct mii_bus *bus, int addr, int dev, int reg, u16 val)
> +{
> +	struct dw_xpcs_rk *pxpcs = bus->priv;
> +
> +	if (!xpcs_rk_mdio_addr_validate(addr))
> +		return -ENODEV;
> +
> +	dev = xpcs_rk_mdio_write_remapping(addr, dev, reg);
> +	if (dev < 0)
> +		return 0;
> +
> +	return xpcs_rk_write_reg(pxpcs, dev, reg, val);
> +}
> +
> +static struct dw_xpcs_rk *xpcs_rk_create_data(struct platform_device *pdev)
> +{
> +	struct dw_xpcs_rk *pxpcs;
> +
> +	pxpcs = devm_kzalloc(&pdev->dev, sizeof(*pxpcs), GFP_KERNEL);
> +	if (!pxpcs)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pxpcs->pdev = pdev;
> +
> +	dev_set_drvdata(&pdev->dev, pxpcs);
> +
> +	return pxpcs;
> +}
> +
> +static int xpcs_rk_serdes_phy_init(struct dw_xpcs_rk *pxpcs)
> +{
> +	struct device *dev = &pxpcs->pdev->dev;
> +
> +	pxpcs->serdes_phy = devm_phy_get(dev, "serdes");
> +	if (IS_ERR(pxpcs->serdes_phy))
> +		return dev_err_probe(dev, PTR_ERR(pxpcs->serdes_phy),
> +					"Failed to get SerDes PHY\n");
> +
> +	return 0;
> +}
> +
> +static void xpcs_rk_serdes_phy_poweroff(void *data)
> +{
> +	struct dw_xpcs_rk *pxpcs = data;
> +	struct device *dev = &pxpcs->pdev->dev;
> +
> +	phy_power_off(pxpcs->serdes_phy);
> +	phy_exit(pxpcs->serdes_phy);
> +
> +	dev_pm_genpd_rpm_always_on(dev, false);
> +}
> +
> +static int xpcs_rk_serdes_phy_poweron(struct dw_xpcs_rk *pxpcs)
> +{
> +	struct device *dev = &pxpcs->pdev->dev;
> +	int ret;
> +
> +	/*
> +	 * The power domain is required and must be enabled, which allows us to
> +	 * dynamically turn the CSR clock on/off using PM while keeping the PCS
> +	 * powered on.
> +	 */
> +	ret = dev_pm_genpd_rpm_always_on(dev, true);
> +	if (ret) {
> +		dev_err(dev, "Failed to power on power-domains\n");
> +		return ret;
> +	}
> +
> +	ret = phy_init(pxpcs->serdes_phy);
> +	if (ret) {
> +		dev_err(dev, "Failed to init SerDes PHY\n");
> +		goto pm_domain;
> +	}
> +
> +	ret = phy_power_on(pxpcs->serdes_phy);
> +	if (ret) {
> +		dev_err(dev, "Failed to power on SerDes PHY\n");
> +		goto serdes_phy;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, xpcs_rk_serdes_phy_poweroff, pxpcs);
> +	if (ret) {
> +		dev_err(dev, "Failed to register devm for SerDes PHY: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +
> +serdes_phy:
> +	phy_exit(pxpcs->serdes_phy);
> +pm_domain:
> +	dev_pm_genpd_rpm_always_on(dev, false);
> +	return ret;
> +}
> +
> +static int xpcs_rk_init_res(struct dw_xpcs_rk *pxpcs)
> +{
> +	struct platform_device *pdev = pxpcs->pdev;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "No reg-space found\n");
> +		return -EINVAL;
> +	}
> +
> +	if (resource_size(res) < SZ_2M) {
> +		dev_err(dev, "Invalid reg-space size\n");
> +		return -EINVAL;
> +	}
> +
> +	pxpcs->reg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pxpcs->reg_base)) {
> +		dev_err(dev, "Failed to map reg-space\n");
> +		return PTR_ERR(pxpcs->reg_base);
> +	}
> +
> +	return 0;
> +}
> +
> +static void xpcs_rk_exit_clk(void *data)
> +{
> +	struct dw_xpcs_rk *pxpcs = data;
> +	struct device *dev = &pxpcs->pdev->dev;
> +
> +	pm_runtime_force_suspend(dev);
> +	clk_disable_unprepare(pxpcs->eee_clk);
> +}
> +
> +static int xpcs_rk_init_clk(struct dw_xpcs_rk *pxpcs)
> +{
> +	struct device *dev = &pxpcs->pdev->dev;
> +	unsigned long rate;
> +	u64 mult;
> +	int ret;
> +
> +	pxpcs->csr_clk = devm_clk_get(dev, "csr");
> +	if (IS_ERR(pxpcs->csr_clk))
> +		return dev_err_probe(dev, PTR_ERR(pxpcs->csr_clk),
> +					 "Failed to get CSR clock\n");
> +
> +	pxpcs->eee_clk = devm_clk_get(dev, "eee");
> +	if (IS_ERR(pxpcs->eee_clk))
> +		return dev_err_probe(dev, PTR_ERR(pxpcs->eee_clk),
> +					 "Failed to get EEE clock\n");
> +
> +	ret = clk_prepare_enable(pxpcs->eee_clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable EEE clock\n");
> +		return ret;
> +	}
> +
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_enable(dev);
> +
> +	ret = devm_add_action_or_reset(dev, xpcs_rk_exit_clk, pxpcs);
> +	if (ret) {
> +		dev_err(dev, "Failed to register devm for EEE clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Compute the multiplier for the EEE clock so that
> +	 * clk_eee_period * (mult_fact + 1) falls within 80..120 ns.
> +	 *
> +	 * On RK3568, clk_xpcs_eee is muxed between gpll200 (200 MHz, 5 ns)
> +	 * and cpll125 (125 MHz, 8 ns), selected by CRU_CLKSEL_CON29 bit 13.
> +	 * The reset value is 0 (200 MHz), but derive the value at runtime to
> +	 * stay correct if the mux is changed by a board.
> +	 *
> +	 * Use a 64-bit intermediate: on 32-bit builds, 100 * 200000000
> +	 * does not fit in unsigned long. Clamp to the 4-bit
> +	 * DW_VR_MII_EEE_MULT_FACT_100NS field.
> +	 */
> +	rate = clk_get_rate(pxpcs->eee_clk);
> +	if (!rate)
> +		return dev_err_probe(dev, -EINVAL, "Invalid EEE clock rate\n");
> +
> +	mult = DIV_ROUND_CLOSEST_ULL(100ULL * rate, NSEC_PER_SEC) - 1;
> +	pxpcs->eee_mult_fact = min_t(u64, mult, 15);
> +	return 0;
> +}
> +
> +static int xpcs_rk_init_bus(struct dw_xpcs_rk *pxpcs)
> +{
> +	struct device *dev = &pxpcs->pdev->dev;
> +	static atomic_t id = ATOMIC_INIT(-1);
> +	struct mii_bus *bus;
> +	int ret;
> +
> +	bus = devm_mdiobus_alloc_size(dev, 0);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->name = "Rockchip DW XPCS MCI/APB3";
> +	bus->read = xpcs_rk_read_c22;
> +	bus->write = xpcs_rk_write_c22;
> +	bus->read_c45 = xpcs_rk_read_c45;
> +	bus->write_c45 = xpcs_rk_write_c45;
> +	bus->phy_mask = ~0;
> +	bus->parent = dev;
> +	bus->priv = pxpcs;
> +
> +	snprintf(bus->id, MII_BUS_ID_SIZE,
> +		 "rockchip_dwxpcs-%x", atomic_inc_return(&id));
> +
> +	/*
> +	 * MDIO-bus here serves as just a back-end engine abstracting out
> +	 * the MDIO and MCI/APB3 IO interfaces utilized for the Rockchip DWXPCS CSRs
> +	 * access.
> +	 */
> +	ret = devm_mdiobus_register(dev, bus);
> +	if (ret) {
> +		dev_err(dev, "Failed to create MDIO bus\n");
> +		return ret;
> +	}
> +
> +	pxpcs->bus = bus;
> +	return 0;
> +}
> +
> +static int xpcs_rk_probe(struct platform_device *pdev)
> +{
> +	struct dw_xpcs_rk *pxpcs;
> +	int ret;
> +
> +	pxpcs = xpcs_rk_create_data(pdev);
> +	if (IS_ERR(pxpcs))
> +		return PTR_ERR(pxpcs);
> +
> +	/*
> +	 * The XPCS may be attached to a power domain (e.g. PD_PIPE). The domain
> +	 * must be powered on before any register access, otherwise the SoC will
> +	 * trigger a synchronous external abort (SError).
> +	 *
> +	 * Accessing the XPCS registers also requires a TX clock from the SerDes,
> +	 * which is needed for the soft reset.
> +	 */
> +	ret = xpcs_rk_serdes_phy_init(pxpcs);
> +	if (ret)
> +		return ret;
> +
> +	ret = xpcs_rk_serdes_phy_poweron(pxpcs);
> +	if (ret)
> +		return ret;
> +
> +	ret = xpcs_rk_init_res(pxpcs);
> +	if (ret)
> +		return ret;
> +
> +	ret = xpcs_rk_init_clk(pxpcs);
> +	if (ret)
> +		return ret;
> +
> +	ret = xpcs_rk_init_bus(pxpcs);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id xpcs_rk_of_ids[] = {
> +	{ .compatible = "rockchip,rk3568-xpcs" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, xpcs_rk_of_ids);
> +
> +struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *np)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *pcs_np;
> +	struct dw_xpcs_rk *pxpcs;
> +	struct dw_xpcs *xpcs;
> +	u32 port;
> +
> +	if (!of_device_is_available(np))
> +		return ERR_PTR(-ENODEV);
> +
> +	if (of_property_read_u32(np, "reg", &port))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!xpcs_rk_mdio_addr_validate((int)port))
> +		return ERR_PTR(-EINVAL);
> +
> +	/* The XPCS pdev is attached to the parent node */
> +	pcs_np = of_get_parent(np);
> +	if (!pcs_np)
> +		return ERR_PTR(-ENODEV);
> +
> +	if (!of_device_is_available(pcs_np)) {
> +		of_node_put(pcs_np);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	if (!of_match_node(xpcs_rk_of_ids, pcs_np)) {
> +		of_node_put(pcs_np);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	pdev = of_find_device_by_node(pcs_np);
> +	of_node_put(pcs_np);
> +	if (!pdev)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	if (!device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER)) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	pxpcs = platform_get_drvdata(pdev);
> +	if (!pxpcs || !pxpcs->bus) {
> +		device_link_remove(dev, &pdev->dev);
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	xpcs = xpcs_create_mdiodev(pxpcs->bus, (int)port);
> +	if (IS_ERR(xpcs)) {
> +		device_link_remove(dev, &pdev->dev);
> +		put_device(&pdev->dev);
> +		return xpcs;
> +	}
> +
> +	xpcs_config_eee_mult_fact(xpcs, pxpcs->eee_mult_fact);
> +	put_device(&pdev->dev);
> +	return xpcs;
> +}
> +EXPORT_SYMBOL_GPL(xpcs_rk_create);
> +
> +static int xpcs_rk_pm_runtime_suspend(struct device *dev)
> +{
> +	struct dw_xpcs_rk *pxpcs = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(pxpcs->csr_clk);
> +
> +	return 0;
> +}
> +
> +static int xpcs_rk_pm_runtime_resume(struct device *dev)
> +{
> +	struct dw_xpcs_rk *pxpcs = dev_get_drvdata(dev);
> +
> +	return clk_prepare_enable(pxpcs->csr_clk);
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(xpcs_rk_pm_ops,
> +			   xpcs_rk_pm_runtime_suspend,
> +			   xpcs_rk_pm_runtime_resume,
> +			   NULL);
> +
> +static struct platform_driver xpcs_rk_driver = {
> +	.probe = xpcs_rk_probe,
> +	.driver = {
> +		.name = "rk_xpcs-dwxpcs",
> +		.pm = pm_ptr(&xpcs_rk_pm_ops),
> +		.of_match_table = xpcs_rk_of_ids,
> +	},
> +};
> +module_platform_driver(xpcs_rk_driver);
> +
> +MODULE_DESCRIPTION("Rockchip XPCS platform device driver");
> +MODULE_AUTHOR("Coia Prant <coiaprant@gmail.com>");
> +MODULE_LICENSE("GPL");

[Severity: Low]
Is the "- 1" here safe for every rate clk_get_rate() can return?

mult is u64, so if the EEE clock ends up slower than ~5 MHz (a
mis-described clock in DT, a mux left in an unexpected position, a
board that reparents clk_xpcs_eee) then
DIV_ROUND_CLOSEST_ULL(100ULL * rate, NSEC_PER_SEC) evaluates to 0 and
the subtraction wraps to U64_MAX.  The clamp on the next line does not
catch that: min_t(u64, mult, 15) compares U64_MAX against 15 and keeps
15, so the slowest possible clock programs the largest
DW_VR_MII_EEE_MULT_FACT_100NS value instead of the smallest.  The only
rate that is rejected today is exactly 0, via the !rate check just
above.

So the failure mode is the opposite of what the comment intends:
clk_eee_period * (mult_fact + 1) would be far outside the 80..120 ns
window rather than clamped to the nearest end of it.

Would it be clearer to compute the product first and clamp before
decrementing, e.g. keep the DIV_ROUND_CLOSEST_ULL() result in mult,
clamp it into 1..16, and only then subtract 1?  Or, if a rate that low
is simply not a valid configuration for this block, should
xpcs_rk_init_clk() reject it with dev_err_probe() the way it already
rejects rate == 0, rather than silently picking a multiplier?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915123802.1561724-1-coiaprant%40gmail.com
