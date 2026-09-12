Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C719D32B126;
	Sat, 12 Sep 2026 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244016; cv=none; b=i8UodBayaJv9kfVcU/cK3xrdXicETsi1lyO7yex7A0IAxfK7gg6d5+xHaGjQWD7tXhUIoP6K10EzvjdsBfaIszhkCTta6Dh7+Rj7XMx+SEBQdHUcWG2i51tDm2cUSN8ILYLoVRdiNJUBB8YVF5cBwcqXIo5TX7dpJW3RGcpxe0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244016; c=relaxed/simple;
	bh=TLku3qY510uU9e60A6MLbVuuhnKFMjE6VIDOYc1UUlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCEIa9BUSfNZxBhZBOOTX1QCN53EYkhl7x6JY3MCFiH3osY+5W7GUIzc5dudT9VYX3A29RYhPWld+2TIz1Mor65F1u1ojflhBoGAS/e5MU7BnAMHmbRsG9Yd3VQPcDrAt9yGh3JTok5d2Wes8hJyF3ZKXRT16MPN320CsT7MG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9ewyniS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9ewyniS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7D81F000FF;
	Sat, 12 Sep 2026 20:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244010;
	bh=YkDhQxVWy/3slqWBx/yw9dsD/9+W1OH/8+HzOVO0/8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P9ewyniSOH4D0Z5guBKU++kZUEv9d9JxruO/psAxW07kMwpG3ZFuPRUH1zJWy+rp6
	 sa2v990V84tuVjQluUo9Ib2lCgtPCcGrR4j5DOtWqCGLWGhWgESCGjgs9OnjsDuy85
	 oiA47+ESxUN6lnQg/MdfiUGuhZG57FfiVkXE6od0B0c+9QhHeVwb78mv0A5KF+b4KL
	 JsIGr0yacQ9Aa7/0R4I7cRdNmJO70B0Om+xiIVpq/C1SSHwsbHXD+/eQFLsfjQTJMx
	 35KPRTR6ADz9A8KhUPdaLe/DsLbzcDeUm1gxzXvxPQl8PNOxS935MqwvEr2zwdfkap
	 1cwwb7jDTbLMg==
From: Jakub Kicinski <kuba@kernel.org>
To: coiaprant@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	vkoul@kernel.org,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	romain.gantois@bootlin.com,
	hkallweit1@gmail.com,
	neil.armstrong@linaro.org,
	linux@armlinux.org.uk,
	shawn.lin@rock-chips.com,
	david@ixit.cz,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v4 07/10] net: pcs: xpcs: add Rockchip RK3568 platform glue driver
Date: Sat, 12 Sep 2026 13:13:29 -0700
Message-ID: <20260912201329.127095-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907153713.2572547-9-coiaprant@gmail.com>
References: <20260907153713.2572547-9-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: pcs: xpcs: add Rockchip RK3568 platform glue driver

This adds a glue driver for the Synopsys DesignWare XPCS found on RK3568,
which is reached through APB3 memory-mapped registers instead of a real
MDIO bus.  The driver registers a virtual MDIO bus that remaps the four
MII ports onto their respective MMDs, and exports xpcs_rk_create() so a
MAC driver can obtain a dw_xpcs instance.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part2%20V1.1-20210301.pdf (Page 2078)

A few questions below.

> diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
> index e417fd66f660a..88bc40791e69f 100644
> --- a/drivers/net/pcs/Kconfig
> +++ b/drivers/net/pcs/Kconfig
> @@ -12,6 +12,29 @@ config PCS_XPCS
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

[Severity: Medium]
Should this new user-visible symbol be part of a patch whose changelog only
describes adding Rockchip RK3568 support?

Two side effects of introducing PCS_XPCS_PLATFORM are not mentioned
anywhere in the commit message:

  - the "snps,dw-xpcs" platform glue moves out of pcs_xpcs.ko into a new
    pcs-xpcs-plat.ko, which changes module packaging for every existing
    memory-mapped DW XPCS user
  - the glue becomes optional, so a config with PCS_XPCS=y and
    PCS_XPCS_PLATFORM=n silently loses "snps,dw-xpcs" support

Since this restructuring of shared code is independent of the Rockchip
glue, could it be split into its own preparatory patch with the effects
described?

> +
> +config PCS_XPCS_ROCKCHIP
> +	tristate "Rockchip XPCS controller support"
> +	default ARCH_ROCKCHIP
> +	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)

[Severity: Medium]
Do the dependencies here need GENERIC_PHY and PM_GENERIC_DOMAINS as well?

xpcs_rk_probe() cannot make forward progress without either of them.  With
CONFIG_GENERIC_PHY=n, the first probe step hits the stub:

include/linux/phy/phy.h:
	static inline struct phy *devm_phy_get(struct device *dev,
					       const char *string)
	{
		return ERR_PTR(-ENOSYS);
	}

so xpcs_rk_serdes_phy_init() always fails through dev_err_probe().

With CONFIG_PM_GENERIC_DOMAINS=n (which covers every CONFIG_PM=n build),
xpcs_rk_serdes_phy_poweron() hits:

include/linux/pm_domain.h:
	static inline int dev_pm_genpd_rpm_always_on(struct device *dev, bool on)
	{
		return -EOPNOTSUPP;
	}

and the driver treats that as fatal.  Since the symbol is also
default ARCH_ROCKCHIP, it can be built and matched in configurations where
it can never bind.  Would adding depends on GENERIC_PHY and
PM_GENERIC_DOMAINS be appropriate?

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
>  obj-$(CONFIG_PCS_LYNX)		+= pcs-lynx.o
>  obj-$(CONFIG_PCS_MTK_LYNXI)	+= pcs-mtk-lynxi.o
>  obj-$(CONFIG_PCS_RZN1_MIIC)	+= pcs-rzn1-miic.o
> diff --git a/drivers/net/pcs/pcs-xpcs-rk.c b/drivers/net/pcs/pcs-xpcs-rk.c
> new file mode 100644
> index 0000000000000..68bcaa1a5cbbf
> --- /dev/null
> +++ b/drivers/net/pcs/pcs-xpcs-rk.c
> @@ -0,0 +1,543 @@

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
Is the mandatory "serdes" PHY consistent with the device tree added by the
rest of the series?

The binding added in this series lists phys and phy-names under required:

Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml:
	required:
	  - compatible
	  - reg
	  ...
	  - phys
	  - phy-names
	  - power-domains

but the SoC node has neither property:

arch/arm64/boot/dts/rockchip/rk3568.dtsi:
	xpcs: pcs@fda00000 {
		compatible = "rockchip,rk3568-xpcs";
		#address-cells = <1>;
		#size-cells = <0>;
		reg = <0x0 0xfda00000 0x0 0x200000>;
		clocks = <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
		clock-names = "csr", "eee";
		power-domains = <&power RK3568_PD_PIPE>;
		status = "disabled";

dtschema validates nodes regardless of status, so every RK3568 DTB other
than the one board patched later in the series should report that phys is
a required property.  Any board that enables the node without adding
phys/phy-names also gets an unconditional probe failure here, since there
is no devm_phy_get_optional() path.  Should the PHY properties move to the
SoC dtsi, or should they be dropped from required:?

[ ... ]

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

[Severity: Low]
The EEE clock is acquired and permanently enabled, but nothing ever
derives the XPCS 100 ns multiplier from its rate.  Should this driver call
xpcs_config_eee_mult_fact() the way dwmac-intel.c does?

Without it xpcs->eee_mult_fact stays 0, and the core programs that value
verbatim when EEE is turned on:

drivers/net/pcs/pcs-xpcs.c:
	/* Configure the eee_mult_fact so that
	 * clk_eee_time_period * (mult_fact + 1) is within the range
	 * 80 to 120ns.
	 */
	val = ... FIELD_PREP(DW_VR_MII_EEE_MULT_FACT_100NS,
			     xpcs->eee_mult_fact);

With the RK3568 EEE clock parents (125/200 MHz, so a 5-8 ns period), a
multiplier of 0 puts the LPI timing well below that range.  The register
reset value is also 0, so nothing valid is being overwritten, but is the
timing expected to be programmed here?

[ ... ]

> +struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *np)
> +{

[ ... ]

> +	pdev = of_find_device_by_node(pcs_np);
> +	of_node_put(pcs_np);
> +	if (!pdev)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	device_lock(&pdev->dev);
> +	pxpcs = platform_get_drvdata(pdev);
> +	if (!pxpcs || !pxpcs->bus) {
> +		device_unlock(&pdev->dev);
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	xpcs = xpcs_create_mdiodev(pxpcs->bus, (int)port);
> +	device_unlock(&pdev->dev);
> +	if (IS_ERR(xpcs)) {
> +		put_device(&pdev->dev);
> +		return xpcs;
> +	}
> +
> +	if (!device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER)) {

[Severity: Medium]
Can the mii_bus be freed under the new dw_xpcs in the window between
device_unlock() and device_link_add()?

The bus is devm managed, so it goes away when the XPCS platform driver
unbinds:

xpcs_rk_init_bus()
	bus = devm_mdiobus_alloc_size(dev, 0);
	...
	ret = devm_mdiobus_register(dev, bus);

and xpcs_create_mdiodev() takes no reference on it:

drivers/net/phy/mdio_device.c:mdio_device_create()
	mdiodev->bus = bus;
	mdiodev->addr = addr;

so the managed device link is the only thing keeping the supplier binding
alive.  With the lock already dropped, an unbind through sysfs or an
rmmod of pcs-xpcs-rk can run device_release_driver() before the link
exists.  put_device() keeps the struct device around but not the driver
binding or its devm resources, leaving mdiodev->bus and the ioremapped
window pointing at freed memory.  The xpcs_destroy() call on the
device_link_add() failure path would then touch it too.

Would creating the device link while still holding device_lock(), or
otherwise pinning the supplier before unlocking, close this?

[ ... ]

> +EXPORT_SYMBOL_GPL(xpcs_rk_create);

[Severity: Low]
As of this commit alone, xpcs_rk_create() has no in-tree caller, so the
driver only probes, pins the power domain and SerDes, and registers the
virtual MDIO bus without ever producing the phylink_pcs the changelog
describes.

This resolves later in the same series: rk_pcs_init() in
drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c calls
xpcs_rk_create(priv->device, pcs_node), rk_gmac_probe() installs
pcs_init/pcs_exit/select_pcs, and DWMAC_ROCKCHIP gains
select PCS_XPCS_ROCKCHIP.  Noting it only in case the ordering was
intentional.

[ ... ]
