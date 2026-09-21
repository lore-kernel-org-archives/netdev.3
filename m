Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC4C517BC4;
	Mon, 21 Sep 2026 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034234; cv=none; b=NTAiBrJxI3Xb9VHKgeh96L8CnMebbyM9VbHptSMurz8mf4+u6fcoWnA3SvoBk+wyF5ABDlmKOgEbS7WaN9CtMdHpyGIZ71mINohlKWOXnHxOd1zRr4+B/t9mQWJaHgRxsRC9/kJQuwx2gVEZNyM9PAvBd5mzwGt5iCViFM6soJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034234; c=relaxed/simple;
	bh=8RLyNZvGTV91p4kpUcwMD41i4gjqCNoPuk6e5r/WBIc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VzeKljVP0OkIpmdiiXCHU9w9aChEOOKLLyEdj0YJI+Hs5NBsUqJWnZzpsKMJ//7GqL31QvTq+wejaDtlH0d3YATtKkNsmvuUmyqx2aujDuQRVwMH9l48S8yjB1Xlshg5AAllnz140ysY0dX80Q9G4chkrQcWR1cp4NMiXMqBq0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5bU0vlm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5bU0vlm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96821F00898;
	Mon, 21 Sep 2026 23:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790034230;
	bh=hu7bHNATY0PvnEcsV4mC2quF/7mPtsLL83QQCQBE1uA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N5bU0vlmAIu3nEYF7h0d31cd5vP9Gv4J/4NHrFP36xc4QSOmZcSi03CQkqflPXKKr
	 s5RV7ZzEUzwFLmXyw81LkJz+f7nJ5lJfsQ/kPqQ+FWUYYxXHFsaLzo0AT8kcY1/Z8s
	 +R6RZWFCRFyMbD/d/O1VlXCdQXdczuAvoM6KbgnP+VFIWZGjuB79kv2ZefI0vP6Qfi
	 GCAfAv355LFwI1twTsU7gFcctJ1ssHG3Z2/lZrgEc2IEKANwYvuXlAqoi9zd8JXadu
	 WSI4JBlY3bDdkMsSvcSiwBUnwWyedpudon3hDjZv8wZu/XMqi6jd6ncysSSQ6Y8+Ob
	 1RpM0lNcP2mHQ==
Subject: Re: [PATCH net-next v7 07/11] net: pcs: xpcs: add Rockchip RK3568
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
Date: Mon, 21 Sep 2026 23:43:48 +0000
Message-ID: <179003422823.2160803.10777218910514192511@kernel.org>
In-Reply-To: <20260917204624.2427486-8-coiaprant@gmail.com>
References: <20260917204624.2427486-8-coiaprant@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 4 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Use-after-free / TOCTOU in xpcs_rk_create()
  (drivers/net/pcs/pcs-xpcs-rk.c:517-545).
- [Medium] Kconfig dependency propagation bug: PCS_XPCS_ROCKCHIP has
  `depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)` but does `select…
- [Medium] Asymmetric MMD remapping makes read-modify-write and write-to-
  clear sequences incoherent and shares control state across ports.
- [Medium] The MDIO bus callbacks forge results for MMDs the glue cannot
  map.
- [Medium] No system-sleep handling for the SerDes PHY or the PCS.
- [Low] FALSE POSITIVE (series-resolved): 'xpcs_rk_create() has no in-
  tree caller / driver is inert'.
- [Low] An unrelated, user-visible restructuring of existing code is
  bundled into this 'add new driver' patch: pcs-xpcs-plat.o is removed…
- [Low] Comment vs. code mismatch about the power domain.
- [Low] DT schema vs. DTS mismatch in the series:
  Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml…

--

net: pcs: xpcs: add Rockchip RK3568 platform glue driver

This adds a platform glue driver that exposes the RK3568 XPCS APB3 register
space as a virtual MDIO bus so the generic pcs-xpcs core can drive it, with
per-port MMD remapping for the four MII ports. It also splits the generic
pcs-xpcs-plat.o glue out of the pcs_xpcs composite module behind a new
PCS_XPCS_PLATFORM symbol, and adds PCS_XPCS_ROCKCHIP.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 59, CRU_CLKSEL_CON29)
Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part2%20V1.1-20210301.pdf (Page 2078)

A couple of notes before the diff, on material that lives in other patches
of the series but is closely tied to this one.

[Severity: Low]
The binding added by the series,
Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml, lists
phys and phy-names in its unconditional required: list, but the xpcs node
added to arch/arm64/boot/dts/rockchip/rk3568.dtsi provides neither.

The justification given is that "dtbs_check only validates required
properties for enabled nodes".  Is that accurate?  dtschema selects schemas
by compatible and validates every node present in the DTB; there is no
status-based filtering, so every RK3568 board DTB that merely inherits the
disabled SoC node would report the two missing required properties unless
the board itself adds them (only rk3568-photonicat.dts does).

Would it make sense to make phys/phy-names conditional in the binding, or
to supply them in the dtsi?

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
Does this select hold up in the COMPILE_TEST configurations this hunk newly
makes expressible?  PM_GENERIC_DOMAINS in kernel/power/Kconfig is:

	config PM_GENERIC_DOMAINS
		bool
		depends on PM

The commit message covers only the other leg:

    PCS_XPCS_ROCKCHIP selects GENERIC_PHY and PM_GENERIC_DOMAINS.
    ARCH_ROCKCHIP already selects PM, so the dependency of PM_GENERIC_DOMAINS
    on PM is satisfied on the target platform.

With COMPILE_TEST on an arch where CONFIG_PM=n, the select is an unmet
direct dependency and Kconfig force-enables PM_GENERIC_DOMAINS anyway.
drivers/Makefile then builds pmdomain/ and drivers/pmdomain/core.c does:

	if (!dev || dev->power.ignore_children)

power.ignore_children only exists inside #ifdef CONFIG_PM in struct
dev_pm_info, so does this break the build for randconfig?

Since xpcs_rk_serdes_phy_poweron() treats any non-zero
dev_pm_genpd_rpm_always_on() return as fatal, and the
!CONFIG_PM_GENERIC_DOMAINS stub returns -EOPNOTSUPP, would "depends on PM"
(or depends on PM_GENERIC_DOMAINS) express the requirement better than an
unconditional select?

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
> diff --git a/drivers/net/pcs/Makefile b/drivers/net/pcs/Makefile
> index 4f7920618b900..f9f6cf2578d72 100644
> --- a/drivers/net/pcs/Makefile
> +++ b/drivers/net/pcs/Makefile
> @@ -1,10 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for Linux PCS drivers
>  
> -pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-plat.o \
> -				   pcs-xpcs-nxp.o pcs-xpcs-wx.o
> +pcs_xpcs-$(CONFIG_PCS_XPCS)	:= pcs-xpcs.o pcs-xpcs-nxp.o pcs-xpcs-wx.o
>  
>  obj-$(CONFIG_PCS_XPCS)		+= pcs_xpcs.o
> +obj-$(CONFIG_PCS_XPCS_PLATFORM) += pcs-xpcs-plat.o
> +obj-$(CONFIG_PCS_XPCS_ROCKCHIP) += pcs-xpcs-rk.o

[Severity: Low]
This isn't a bug, but could the pcs-xpcs-plat.o split be a separate
preparatory patch?  Nothing in pcs-xpcs-rk.o needs it, since the Rockchip
glue is added with its own obj- line.

The commit message says:

    The symbol defaults to PCS_XPCS, so existing configurations keep the
    snps,dw-xpcs platform glue enabled without any change.

The generic platform glue does change name though: it now ships as
pcs-xpcs-plat.ko instead of being linked into pcs_xpcs.ko, and it becomes
user-disablable via a new prompt.  Hand-maintained configs and initramfs
module lists that only pull in pcs_xpcs would silently lose the platform
driver.  Would it be worth stating that consequence explicitly?

>  obj-$(CONFIG_PCS_LYNX)		+= pcs-lynx.o
>  obj-$(CONFIG_PCS_MTK_LYNXI)	+= pcs-mtk-lynxi.o
>  obj-$(CONFIG_PCS_RZN1_MIIC)	+= pcs-rzn1-miic.o
> diff --git a/drivers/net/pcs/pcs-xpcs-rk.c b/drivers/net/pcs/pcs-xpcs-rk.c
> new file mode 100644
> index 0000000000000..1c725d6a008dc
> --- /dev/null
> +++ b/drivers/net/pcs/pcs-xpcs-rk.c
> @@ -0,0 +1,582 @@

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
Are these registers really write-only from the core's point of view?  The
read path maps them per port (addr 1 -> MMD 2, 2 -> MMD 3, 3 -> MMD 4)
while the write path forces MMD 7 for every address, and pcs-xpcs performs
read-modify-writes and write-to-clear on exactly these:

drivers/net/pcs/pcs-xpcs.c:xpcs_config_aneg_c37_sgmii()
	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL, mask, val);

drivers/net/pcs/pcs-xpcs.c:xpcs_config_eee()
	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_EEE_MCTRL0, mask, val);
	...
	return xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_EEE_MCTRL1, ...);

drivers/net/pcs/pcs-xpcs.c:xpcs_get_state_c37_sgmii()
	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);

For ports 1-3 the modify reads MMD 2/3/4 and writes the result into MMD 7,
so can a port 1-3 instance clobber the AN/EEE/DIG_CTRL2 configuration that
port 0 (possibly a different GMAC) programmed?

And since the write-to-clear of DW_VR_MII_AN_INTR_STS is redirected to
MMD 7, does the per-port CL37 AN-complete latch ever get cleared for ports
1-3?

mdio_lock serialises single accesses but not the core's AN_CTRL plus
DIG_CTRL1 or EEE_MCTRL0 plus EEE_MCTRL1 sequences.  Would mapping reads of
these registers to MMD 7 as well keep the read-modify-writes coherent?

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

[Severity: Medium]
Should an unmappable MMD be reported as a successful write and as a 0xffff
read?  The remapping helpers return -ENXIO for anything other than
MDIO_MMD_PMAPMD and MDIO_MMD_VEND2, which includes MDIO_MMD_PCS and
MDIO_MMD_AN, and these four bus callbacks turn that into "return 0" or
"return 0xffff".

Filtering the aliasing MMDs is clearly needed, but the mii_bus contract is
that 0 from a write callback means the write reached the device.  Here the
core is told a register write succeeded when nothing was issued:

drivers/net/pcs/pcs-xpcs.c:xpcs_soft_reset()
	case DW_AN_C73:
	case DW_10GBASER:
		dev = MDIO_MMD_PCS;

and the matching readback of 0xffff makes BMCR_RESET look permanently
asserted, which xpcs_poll_reset() only logs.

Note this instance does advertise those modes: xpcs_read_ids() falls back
to the VEND2 PHYSID because the MMD_PCS read returns the fabricated
0xffff, so desc stays synopsys_xpcs_compat and xpcs_get_interfaces()
publishes USXGMII/10GBASER/C73 in pcs.supported_interfaces.

Would returning -EOPNOTSUPP (or -ENODEV) for the unmappable MMDs be
better, so the core sees the failure instead of silently diverging from the
hardware state?

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

[ ... ]

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

[Severity: Medium]
Does anything re-initialise the SerDes after a system suspend/resume cycle?
phy_init() and phy_power_on() run only here, at probe, and
dev_pm_genpd_rpm_always_on() is only honoured by the runtime path:

drivers/pmdomain/core.c:genpd_power_off()
	checks to_gpd_data(pdd)->rpm_always_on

drivers/pmdomain/core.c:genpd_sync_power_off()
	if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
		return;

	if (genpd->suspended_count != genpd->device_count
	    || atomic_read(&genpd->sd_count) > 0)
		return;

genpd_sync_power_off() is the noirq/syscore path and does not look at
rpm_always_on, so once the other PD_PIPE consumers are suspended the domain
can be powered off during S3.  phy-rockchip-naneng-combphy.c has no
suspend/resume callbacks either, and phy-core still believes the PHY is
initialised and powered.

On resume the only thing restored is the CSR clock via
pm_runtime_force_resume(), so would the SGMII port come back up, given that
the probe comment below says register access and the soft reset need the
SerDes TX clock?

> +
> +	ret = devm_add_action_or_reset(dev, xpcs_rk_serdes_phy_poweroff, pxpcs);
> +	if (ret) {
> +		dev_err(dev, "Failed to register devm for SerDes PHY: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;

[ ... ]

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

[Severity: Low]
This isn't a bug, but "may be attached to a power domain" reads as if the
domain were optional, while the code below makes it mandatory:
xpcs_rk_serdes_phy_poweron() propagates the dev_pm_genpd_rpm_always_on()
error, and that returns -ENODEV when dev_to_genpd_safe() finds no genpd.

The comment in xpcs_rk_serdes_phy_poweron() ("The power domain is required
and must be enabled") and the binding, which lists power-domains under
required:, both say the opposite.  Could these be made consistent?

> +	 *
> +	 * Accessing the XPCS registers also requires a TX clock from the SerDes,
> +	 * which is needed for the soft reset.
> +	 */
> +	ret = xpcs_rk_serdes_phy_init(pxpcs);
> +	if (ret)
> +		return ret;

[ ... ]

> +struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *np)
> +{

[ ... ]

> +	pdev = of_find_device_by_node(pcs_np);
> +	of_node_put(pcs_np);
> +	if (!pdev)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	/*
> +	 * Pin the supplier before reading its drvdata: device_link_add()
> +	 * refuses to create a managed link while the supplier is being
> +	 * unbound, so if it succeeds the drvdata cannot be freed under us.
> +	 * The link is released automatically when the consumer device is
> +	 * destroyed (DL_FLAG_AUTOREMOVE_CONSUMER), which covers all probe
> +	 * failure paths, so no explicit device_link_remove() is needed.
> +	 */
> +	if (!device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER)) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	pxpcs = platform_get_drvdata(pdev);
> +	if (!pxpcs || !pxpcs->bus) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}

[Severity: High]
Does the device core actually guarantee what this comment describes?
device_link_init_status() handles the unbinding supplier explicitly rather
than refusing:

drivers/base/core.c:device_link_init_status()
	case DL_DEV_UNBINDING:
		link->status = DL_STATE_SUPPLIER_UNBIND;
		break;

device_link_add() returns NULL only for invalid flags,
!device_pm_initialized(supplier), dependency cycles, or the
SYNC_STATE_ONLY conditions.  By the time the supplier is unbinding it has
already passed device_links_busy() and device_links_unbind_consumers(), so
a link created afterwards neither blocks nor is waited for.

Meanwhile the supplier's devres is freed before drvdata is cleared:

drivers/base/dd.c:device_unbind_cleanup()
	devres_release_all(dev);
	...
	dev_set_drvdata(dev, NULL);

So can this happen?

CPU A: echo <pdev> > /sys/bus/platform/drivers/rk_xpcs-dwxpcs/unbind
	__device_release_driver()	/* DL_DEV_UNBINDING */
	  device_remove()
	    device_unbind_cleanup()
	      devres_release_all()	/* frees pxpcs, mii_bus, reg_base */

CPU B: MAC probe -> xpcs_rk_create()
	device_link_add()		/* succeeds, DL_STATE_SUPPLIER_UNBIND */
	pxpcs = platform_get_drvdata(pdev);  /* still the freed pointer */
	if (!pxpcs || !pxpcs->bus)	/* passes on freed memory */

xpcs_rk_create_data() publishes drvdata before any field is initialised, so
the same window exists on the supplier's probe-failure path, and
put_device(&pdev->dev) pins struct device only, not the driver-owned
devres.

Would device_lock() plus device_is_bound(), or a refcounted handle on the
MDIO bus, close this?

> +
> +	xpcs = xpcs_create_mdiodev(pxpcs->bus, (int)port);

Here the possibly freed mii_bus is handed to the generic core, which keeps
using it for every later register access, dereferencing bus->priv (the
freed struct dw_xpcs_rk) and pxpcs->reg_base.  Is there anything preventing
that?

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

[ ... ]

> +static DEFINE_RUNTIME_DEV_PM_OPS(xpcs_rk_pm_ops,
> +			   xpcs_rk_pm_runtime_suspend,
> +			   xpcs_rk_pm_runtime_resume,
> +			   NULL);

This only supplies the runtime callbacks plus the generic
pm_runtime_force_suspend/force_resume sleep pair, which gate the CSR clock;
see the question above about re-initialising the SerDes on resume.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917204624.2427486-1-coiaprant%40gmail.com
