Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40149EC71;
	Mon, 14 Sep 2026 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417498; cv=none; b=jPWkHC+aYjnAfAddpIod7m2yMIfxCgTTCU91dTUjJp/hRn5zLaYPuh6SufCPe1L/eo8E86qQtQtCGEKNVWA/rhAxxautzNQhOfNsMnB0m8Dz8zVL1F2FJGXXg72icpgfpqvQEP7r/AuhZJzChafs0IkHGc5biLU61zNnD7Zl6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417498; c=relaxed/simple;
	bh=LbzhcDmPFD3lPNZ6b3m1tq7HziJgSsGa6ZxT9yz/xcI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aKapSG3o7Wl1wcEqiIO3AWvXEXHzmVxeZcZjjYsOVkh+S8qRifkU4OZQBKnEoCQsTkUIrM+e/7VKmpOCPl1OGlm1cjnySliD6xSB3ecAO+pg39gkExJTn3IyoPZVV9D6b6wtHTD10oWMWzPWHDT7DKSI+KQGJ1+LzaElMac30DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OP28RTtT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP28RTtT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CF11F0089B;
	Mon, 14 Sep 2026 20:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789417489;
	bh=OMMuydY+HeFbYXxtpaEu5EzSRSgh0D+mnFhpMS3MlYc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OP28RTtTZbrWRtWJ6KNB7eDOWxxWj0whdphMwls2X7V8eD+p6FUeznbEXk+AOb0nm
	 TJxbcfpqlk1J1uXjjRSx35aKDZebcXVu32skRn5RF4ESczR38UtaVT/UubGZC02akT
	 qF82YQ3hAhLC9zW788NWNe0KRygv0UEChdWXkTQpfrB7UkxhF76aXC10hMEbhdGdI2
	 FWIPBh2ZZFYLE/RVvqSrddisVzlJH7isjLIyxdgddvuiMPTgNeF5EGrMY0ZmODhcPZ
	 afnk3jm9gyNAS4hIQE5/EZmb4py2cguCsYjJ8/4oVbxYE/hW/XyrEC0Y60Gimf1z9X
	 pdisggaqfcIcg==
Subject: Re: [PATCH net-next v5 07/11] net: pcs: xpcs: add Rockchip RK3568
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
Date: Mon, 14 Sep 2026 20:24:47 +0000
Message-ID: <178941748759.22033.1861925605437398903@kernel.org>
In-Reply-To: <20260913185849.907479-8-coiaprant@gmail.com>
References: <20260913185849.907479-8-coiaprant@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 3 · Low: 2

- [High] Incorrect MMD write remapping for MII vendor registers breaks
  configuration for ports 1, 2, and 3.
- [Medium] The patch silently re-packages the pre-existing generic
  Synopsys XPCS platform driver.
- [Medium] xpcs_rk_init_clk() (drivers/net/pcs/pcs-xpcs-rk.c:361-362)
  computes `pxpcs->eee_mult_fact = DIV_ROUND_CLOSEST(100 *…
- [Medium] Acquiring `device_lock()` of another device from within a
  probe path causes a lockdep warning (recursive locking).
- [Low] Concern that the newly exported xpcs_rk_create()
  (include/linux/pcs/pcs-xpcs-rk.h) has no in-tree caller and no Kconfig…
- [Low] The rockchip,rk3568-xpcs binding lists `phys` and `phy-names` in
  its `required:` list…

--

net: pcs: xpcs: add Rockchip RK3568 platform glue driver

Adds a platform glue driver for the DesignWare XPCS block found on RK3568,
exposing the APB3-mapped XPCS registers as a virtual MDIO bus with per-port
MMD remapping so the generic pcs-xpcs core can create a phylink_pcs.  Also
adds new Kconfig symbols for the generic and Rockchip XPCS glue and an
exported xpcs_rk_create() helper for MAC drivers.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part2%20V1.1-20210301.pdf (Page 2078)

> diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
> index e417fd66f660a..080538f193d59 100644
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
> +	depends on GENERIC_PHY || COMPILE_TEST
> +	depends on PM_GENERIC_DOMAINS || COMPILE_TEST
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

[Severity: Medium]
Should this repackaging of the pre-existing generic platform glue be a
separate patch, or at least be described in the commit message?

pcs-xpcs-plat.o is moved out of the pcs_xpcs composite object and built as
its own module, and the new PCS_XPCS_PLATFORM tristate makes the snps,dw-xpcs
platform glue user-selectable where it was previously unconditional under
PCS_XPCS.  So the snps,dw-xpcs platform driver ships in pcs-xpcs-plat.ko
instead of pcs_xpcs.ko after this patch.

The commit message only describes adding the Rockchip glue driver and does
not mention this change to existing functionality.  Could the Makefile and
Kconfig refactor be split out with its own rationale?

> diff --git a/drivers/net/pcs/pcs-xpcs-rk.c b/drivers/net/pcs/pcs-xpcs-rk.c
> new file mode 100644
> index 0000000000000..7fd1408c044cc
> --- /dev/null
> +++ b/drivers/net/pcs/pcs-xpcs-rk.c
> @@ -0,0 +1,559 @@

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
xpcs_rk_serdes_phy_init() treats the "serdes" phy as mandatory and fails
probe when it cannot be resolved, and the binding added later in this series
(Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml) lists
phys and phy-names under required:

  required:
    - compatible
    - reg
    ...
    - phys
    - phy-names
    - power-domains

The SoC node added in arch/arm64/boot/dts/rockchip/rk3568.dtsi only has:

	xpcs: ethernet-pcs@fda00000 {
		compatible = "rockchip,rk3568-xpcs";
		#address-cells = <1>;
		#size-cells = <0>;
		reg = <0x0 0xfda00000 0x0 0x200000>;
		clocks = <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
		clock-names = "csr", "eee";
		power-domains = <&power RK3568_PD_PIPE>;
		status = "disabled";

CHECK_DTBS validates nodes regardless of status, so does every RK3568 DTB
now report missing phys/phy-names for this node?  Only
rk3568-photonicat.dts adds them, so a board that just flips this node to
status = "okay" would also fail probe with "Failed to get SerDes PHY".

Should the SoC node carry phys/phy-names, or should the binding not mark
them required at the SoC level?

[ ... ]

> +static int xpcs_rk_init_clk(struct dw_xpcs_rk *pxpcs)
> +{
[ ... ]
> +	/*
> +	 * Compute the multiplier for the EEE clock so that
> +	 * clk_eee_period * (mult_fact + 1) falls within 80..120 ns.
> +	 *
> +	 * On RK3568, clk_xpcs_eee is muxed between gpll200 (200 MHz, 5 ns)
> +	 * and cpll125 (125 MHz, 8 ns), selected by CRU_CLKSEL_CON29 bit 13.
> +	 * The reset value is 0 (200 MHz), but derive the value at runtime to
> +	 * stay correct if the mux is changed by a board.
> +	 */
> +	pxpcs->eee_mult_fact = DIV_ROUND_CLOSEST(100 * clk_get_rate(pxpcs->eee_clk),
> +						 1000000000UL) - 1;

[Severity: Medium]
Can this value overflow the 4-bit register field it ends up in?

For the reset configuration named in the comment (200 MHz, 5 ns) this
computes 100 * 200000000 / 1000000000 - 1 = 19.  That is passed on
unchecked:

	xpcs_config_eee_mult_fact(xpcs, pxpcs->eee_mult_fact);

and the core programs it in xpcs_config_eee():

	drivers/net/pcs/pcs-xpcs.c:
		      FIELD_PREP(DW_VR_MII_EEE_MULT_FACT_100NS,
				 xpcs->eee_mult_fact);

with

	drivers/net/pcs/pcs-xpcs.h:
	#define DW_VR_MII_EEE_MULT_FACT_100NS		GENMASK(11, 8)

FIELD_PREP on a runtime value does no range check, so 19 (0x13) becomes 3.
The hardware is then told the 100 ns reference is 4 EEE clock periods
(20 ns) rather than the 80..120 ns the comment and the kernel-doc of
xpcs_config_eee_mult_fact() require, which affects all derived LPI timers
once EEE is enabled.  Since the field caps the count at 16 periods, is 15
the only representable value for a 5 ns clock, and should this be clamped?

Two more things about the same expression:

- 100 * clk_get_rate() is evaluated in unsigned long, so on 32-bit builds
  100 * 200000000 wraps to 2820130816 and yields mult_fact 2.  Would
  mul_u64_u32_div() or a u64 intermediate be better here?

- If clk_get_rate() returns 0, 0 - 1 stored in a u8 becomes 255, giving
  field value 15.  Is a zero rate worth rejecting?

[ ... ]

> @@ -0,0 +1,559 @@
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
> +	/* read remapping to MII is performed by HW */
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
> +	/* Writable only on MII */
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
> +	/*
> +	 * Compute the multiplier for the EEE clock so that
> +	 * clk_eee_period * (mult_fact + 1) falls within 80..120 ns.
> +	 *
> +	 * On RK3568, clk_xpcs_eee is muxed between gpll200 (200 MHz, 5 ns)
> +	 * and cpll125 (125 MHz, 8 ns), selected by CRU_CLKSEL_CON29 bit 13.
> +	 * The reset value is 0 (200 MHz), but derive the value at runtime to
> +	 * stay correct if the mux is changed by a board.
> +	 */
> +	pxpcs->eee_mult_fact = DIV_ROUND_CLOSEST(100 * clk_get_rate(pxpcs->eee_clk),
> +						 1000000000UL) - 1;
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
> +	device_lock(&pdev->dev);

[Severity: Medium]
xpcs_rk_create() is called from a MAC driver's probe path, which is
already running under device_lock() of the MAC device taken by
really_probe().  Taking device_lock(&pdev->dev) here nests a second
struct device mutex, and since all device mutexes share one lockdep
class unless annotated, lockdep will report "possible recursive
locking detected" on the first probe.  That is a splat in the logs on
any CONFIG_PROVE_LOCKING build, and a panic with panic_on_warn set.

Holding the XPCS device's lock across xpcs_create_mdiodev() and
device_link_add() is also unusual - device_link_add() does its own
locking and the driver core normally expects supplier device locks not
to be held by consumers.

What race is the lock actually protecting against?  pxpcs and
pxpcs->bus are published by xpcs_rk_probe() via dev_set_drvdata() and
xpcs_rk_init_bus(), and the !pxpcs || !pxpcs->bus case already returns
-EPROBE_DEFER, so the consumer retries later; the device link then
keeps the supplier around.  Can the device_lock()/device_unlock() pairs
simply be dropped, or is something else needed here (e.g. checking that
the supplier is bound) to close the window you had in mind?

> +	pxpcs = platform_get_drvdata(pdev);
> +	if (!pxpcs || !pxpcs->bus) {
> +		device_unlock(&pdev->dev);
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	xpcs = xpcs_create_mdiodev(pxpcs->bus, (int)port);
> +	if (IS_ERR(xpcs)) {
> +		device_unlock(&pdev->dev);
> +		put_device(&pdev->dev);
> +		return xpcs;
> +	}
> +
> +	if (!device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER)) {
> +		xpcs_destroy(xpcs);
> +		device_unlock(&pdev->dev);
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	xpcs_config_eee_mult_fact(xpcs, pxpcs->eee_mult_fact);
> +	device_unlock(&pdev->dev);
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

[Severity: High]
This block in xpcs_rk_mdio_write_remapping() ignores addr entirely:
any write to DW_VR_MII_AN_CTRL, DW_VR_MII_AN_INTR_STS,
DW_VR_MII_EEE_MCTRL0, DW_VR_MII_EEE_MCTRL1 or DW_VR_MII_DIG_CTRL2 is
routed to ROCKCHIP_MMD_MII, which per the commit message is port 0's
MMD (7), regardless of which of the four ports the MDIO address
selects.

So when the core configures a PCS instance created with addr 1, 2 or 3
- xpcs_config_aneg_c37_sgmii() writing DW_VR_MII_AN_CTRL and
DW_VR_MII_DIG_CTRL2, xpcs_config_eee() writing DW_VR_MII_EEE_MCTRL0/1,
and the interrupt-status clear on DW_VR_MII_AN_INTR_STS - the write
lands on port 0 instead.  That has two effects: the intended port is
never configured (so its link stays broken), and port 0's
auto-negotiation/EEE state is silently clobbered by an unrelated
interface, including its pending AN interrupt status.

The read path is not symmetric either: xpcs_rk_mdio_read_remapping()
remaps per addr with the comment "read remapping to MII is performed by
HW", so a write to these registers on port 2 followed by a read back
would not return what was written.  Is that asymmetry deliberate?

Does the TRM say these vendor registers physically exist only in MMD 7
and are shared by all four MII ports?  If so, redirecting writes
silently still leaves per-port configuration impossible, and the driver
probably needs to say so explicitly (reject the access, or document how
the shared block is meant to be programmed) rather than aliasing ports
1..3 onto port 0.  If instead each port has its own copy of these
registers, this switch should be dropped so the addr-based mapping
below applies.  Which is it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913185849.907479-1-coiaprant%40gmail.com
