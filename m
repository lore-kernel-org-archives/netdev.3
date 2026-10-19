Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295BB3DA5AA;
	Mon, 19 Oct 2026 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792396406; cv=none; b=b3XzUPP2UVHsP0t/PIosm/e2jWbipehqPCiLykWr5uW3UszKTjKLTN9Xb0bMmczQhrq8tXw8pzeuGZsL2//PcvJpUyGWL79be5abzqryaEkxTCRjMgynX2dNeMWcI7aWNh1YzhePGqK/v7K9HGEq+OpoLGO3qqY8OpdXTTjBkd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792396406; c=relaxed/simple;
	bh=WtYSDHeQWJNHhUiaNltIgksUR8hn0YxMiGpLg+V2auY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ig88ZHgWwyQPJ5SPFjNbWff9T8WMM0COeyXh/VcU8A1p7AdkQu6FPmKFiZqyLfHnDnIyotHAgDI0yHW0MbCIFAW+4TdbobR3EkjPA1HLFkGyQXTdgktGuakUge7EukV/x1djHwhWUOuzolOAClR5HNiraXvEBVrP31E1Yda+jRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZhOYCqLf; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZhOYCqLf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CA69FC5CD45;
	Mon, 19 Oct 2026 07:54:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C22E960582;
	Mon, 19 Oct 2026 07:53:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 273A410328429;
	Mon, 19 Oct 2026 09:52:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792396390; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=XdtJHOQga8yZintzw2L/x8WOKIlE3a7c6yHsYsvBWSo=;
	b=ZhOYCqLfY0uqKfnFsc7IaeJv/xjMPmvrjEhsq6qUY/OnQxd90wxSGRTZlE5YbnJivQjrLs
	H0+eN6D72FZKrmGiYewBm9LgeouitI9fTmxrvwxXlgFjDeIge0JdTmsT8bsZ2QNLZOwfqN
	O+p34paK3Akp4O9RTpAD2jaRMut6JzAGO9AL7uaO2o9O1IR4Zsk0MbMdvvbNLBscn/5omL
	ZSz4ixluYb3uCw6mrSMv2NNXYp1pmH8AtQbZAJYS2fFGGSmKNcgRfHJo2UTfCRh5nI+ema
	PJMzOQDR08v5AAwPHr8770QYwnNktt7ajaw+WB6MHrhGHkn+eEI45868UdufxQ==
Message-ID: <3d0b17c6-3b94-4e36-b7bc-700211c83273@bootlin.com>
Date: Mon, 19 Oct 2026 09:52:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] net: stmmac: support the TC9564 SoC
To: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: Daniel Thompson <daniel@riscstar.com>, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 richardcochran@gmail.com, p.zabel@pengutronix.de, peppe.cavallaro@st.com,
 joabreu@synopsys.com, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261019030129.1470307-1-elder@riscstar.com>
 <20261019030129.1470307-6-elder@riscstar.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261019030129.1470307-6-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Alex,

On 10/19/26 05:01, Alex Elder wrote:
> From: Daniel Thompson <daniel@riscstar.com>
> 
> Add support for the Ethernet XGMAC functionality present in the
> Toshiba TC9564 SoC.
> 
> The TC9564 is a fairly complex chip that attaches to a host via
> the upstream port of a PCIe switch it implements.  That switch
> has three downstream ports, and one of those has an embedded PCI
> endpoint.  The PCI endpoint implements two PCI functions, and a
> 10 Gbps-capable XGMAC interface is attached to each.
> 
> The TC9564 implements additional peripherals, and access to them
> is provided by a PCI endpoint bus associated with BAR 4 of the
> first PCI function.  A PCI driver sets up the PCI function for
> use, and peripherals using the bus use platform drivers, matched
> by compatible string.
> 
> We use the pci-ep-bus approach for the stmmac driver as well, with
> each PCI function exposing access to its BAR 4 via an endpoint bus.
> The XGMAC device is defined within a pci-ep-bus node, and is bound
> to the platform driver based on its compatible string.
> 
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Co-developed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  MAINTAINERS                                   |   1 +
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>  .../ethernet/stmicro/stmmac/dwmac-tc9564.c    | 590 ++++++++++++++++++
>  4 files changed, 603 insertions(+)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-tc9564.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 972c9faead5b3..69f301aa26eb9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28313,6 +28313,7 @@ M:	Alex Elder <elder@kernel.org>
>  M:	Daniel Thompson <danielt@kernel.org>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml
> +F:	drivers/net/ethernet/stmicro/stmmac/dwmac-tc9564.c
>  
>  TOSHIBA WMI HOTKEYS DRIVER
>  M:	Azael Avalos <coproscefalo@gmail.com>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index ab3c4cf964239..5613921188df4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -363,6 +363,17 @@ config DWMAC_LOONGSON1
>  	  device driver. This driver is used for Loongson1-based boards
>  	  like Loongson LS1B/LS1C.
>  
> +config DWMAC_TC9564
> +	tristate "Toshiba TC9564 DWMAC support"
> +	depends on OF && COMMON_CLK && TC9564_PCI
> +	default TC9564_PCI
> +	help
> +	  Support for the Ethernet controllers on the Toshiba TC9564.
> +
> +	  This enables glue layer support in the stmmac driver support
> +	  for the Toshiba TC9564.  This chip implements two embedded
> +	  PCIe functions, each of which has an XGMAC interface.
> +
>  config DWMAC_TEGRA
>  	tristate "NVIDIA Tegra MGBE support"
>  	depends on ARCH_TEGRA || COMPILE_TEST
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> index b16a456b730ec..c4de25db93715 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> @@ -52,4 +52,5 @@ obj-$(CONFIG_STMMAC_PCI)	+= stmmac-pci.o
>  obj-$(CONFIG_DWMAC_INTEL)	+= dwmac-intel.o
>  obj-$(CONFIG_DWMAC_LOONGSON)	+= dwmac-loongson.o
>  obj-$(CONFIG_DWMAC_MOTORCOMM)	+= dwmac-motorcomm.o
> +obj-$(CONFIG_DWMAC_TC9564)	+= dwmac-tc9564.o
>  stmmac-pci-objs:= stmmac_pci.o
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tc9564.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tc9564.c
> new file mode 100644
> index 0000000000000..21098f91e3bbf
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tc9564.c
> @@ -0,0 +1,590 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
> + *
> + * Derived from code having the following copyrights:
> + * Copyright (C) 2011-2012  Vayavya Labs Pvt Ltd
> + * Copyright (C) 2025 Toshiba Electronic Devices & Storage Corporation
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/iopoll.h>
> +#include <linux/irqdomain.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/pcs/pcs-xpcs-regmap.h>
> +#include <linux/pcs/pcs-xpcs.h>
> +#include <linux/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/stmmac.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include "common.h"
> +#include "dwxgmac2.h"
> +#include "stmmac.h"
> +#include "stmmac_platform.h"
> +
> +#define DRIVER_NAME			"dwmac-tc9564"
> +
> +/* Start of range representing PCI space on the TC9564 internal bus */
> +#define TC9564_SLV00_SRC_ADDR		0x0000001000000000ULL
> +
> +#define TC9564_PTP_CLOCK_RATE		(250 * HZ_PER_MHZ)
> +
> +#define TC9564_RX_FIFO_SIZE		(46 * SZ_1K)
> +#define TC9564_TX_FIFO_SIZE		(46 * SZ_1K)
> +
> +/* Fields and values for the EMACTL registers */
> +#define EMAC_SP_SEL_MASK		GENMASK(3, 0)
> +#define SP_SEL_2500BASEX		4
> +#define SP_SEL_SGMII_1000M		5
> +#define SP_SEL_SGMII_100M		6
> +#define SP_SEL_SGMII_10M		7
> +#define EMAC_PHY_INF_SEL_MASK		GENMASK(5, 4)
> +#define PCS_CLK_PHY			1	/* Clock from PHY */
> +#define EMAC_INV_SGM_SIG_DET		BIT(6)	/* 1 = polarity inverted */
> +#define EMAC_LPIHWCLKEN			BIT(8)	/* 1 = low power mode */
> +#define EMAC_INIT_DONE			BIT(21)
> +
> +/* Offset to the XPCS memory block, relative to the EMAC address range */
> +#define DWMAC_XPCS_OFFSET		0x3a00
> +
> +/* Offset to the PMATOP memory block, relative to the EMAC address range */
> +#define DWMAC_PMATOP_OFFSET			0x4000
> +
> +#define PMA_CML_GL_PM_CFG0			0x01b8
> +
> +/*
> + * Five sets three registers must be configured for PMA.  The HWT_REFCLK
> + * registers are each separated by 0x14 bytes.  The Common0 configuration
> + * registers are separated by 0x8 bytes.
> + */
> +#define PMA_REG_COUNT				5
> +
> +#define PMA_HWT_REFCK_R_EN			0x1080
> +#define PMA_HWT_REFCK_TERM_EN			0x1090
> +#define PMA_HWT_REFCK_STRIDE			0x0014
> +
> +#define PMA_COMM_CFG_0_1			0x1888
> +#define PMA_COMM_CFG_0_1_STRIDE			0x0008
> +
> +/* PMA_COMM_CFG_0_1 fields (WRITE_MASK is a field name) */
> +#define COMM_CFG_WRITE_MASK_MASK		GENMASK(16, 9)
> +#define WRITE_MASK_VALUE			0xf7	/* Power-on value */
> +#define COMM_CFG_ENABLE				BIT(8)
> +#define COMM_CFG_WRITE_DATA_MASK		GENMASK(7, 0)
> +#define WRITE_DATA_VALUE			0x04	/* Power-on value */
> +
> +enum {
> +	RESET_ID_MAC,
> +	RESET_ID_XPCS,
> +	RESET_ID_PMA,
> +};
> +
> +static const char * const tc9564_reset_names[] = {
> +	[RESET_ID_MAC] = "mac",
> +	[RESET_ID_XPCS] = "xpcs",
> +	[RESET_ID_PMA] = "pma",
> +};
> +
> +/**
> + * struct tc9564_data - Toshiba-specific platform data
> + * @dev:		Device pointer
> + * @ioaddr:		Pointer to mapped eMAC memory
> + * @plat:		Pointer to our stmmac platform data
> + * @resets:		Reset controller bulk array
> + * @clocks:		Clock controller bulk array
> + * @clock_count:	Number of valid elements in the clock array
> + * @config_regmap:	Regmap used to access eMAC configuration registers
> + * @emac_ctl_offset:	Offset of the eMAC control register within the regmap
> + * @res:		Structure passed to stmmac_dvr_probe()
> + * @desc:		DMA descriptor data used by mac_device_info
> + * @dma:		DMA operations data used by mac_device_info
> + */
> +struct tc9564_data {
> +	struct device *dev;
> +	void __iomem *ioaddr;
> +	struct plat_stmmacenet_data *plat;
> +	struct reset_control_bulk_data resets[ARRAY_SIZE(tc9564_reset_names)];
> +	struct clk_bulk_data *clocks;
> +	u32 clock_count;
> +
> +	struct regmap *config_regmap;
> +	u32 emac_ctl_offset;
> +
> +	/* This field is data passed to stmmac_dvr_probe() */
> +	struct stmmac_resources res;
> +
> +	/* These two fields are used by the mac_device_info structure */
> +	struct stmmac_desc_ops desc;
> +	struct stmmac_dma_ops dma;
> +};
> +
> +struct tc9564_mac_speed {
> +	phy_interface_t phy_interface;
> +	int speed;
> +	u32 sp_sel;
> +};
> +
> +static struct tc9564_mac_speed mac_speed[] = {
> +	{ PHY_INTERFACE_MODE_2500BASEX,	SPEED_2500,  SP_SEL_2500BASEX },
> +	{ PHY_INTERFACE_MODE_SGMII,	SPEED_1000,  SP_SEL_SGMII_1000M },
> +	{ PHY_INTERFACE_MODE_SGMII,	SPEED_100,   SP_SEL_SGMII_100M },
> +	{ PHY_INTERFACE_MODE_SGMII,	SPEED_10,    SP_SEL_SGMII_10M },
> +};
> +
> +/* TC9564 uses indirect addressing so this need only describe a 1KiB range */
> +static const struct regmap_config xpcs_regmap_config = {
> +	.reg_bits	= 32,
> +	.val_bits	= 32,
> +	.reg_base	= 0x00,		/* Minimum XPCS reg offset */
> +	.max_register	= 0xff,		/* Register DW_VR_CSR_VIEWPORT */
> +	.reg_shift	= REGMAP_UPSHIFT(2),
> +};
> +
> +/**
> + * tc9564_pma_init() - Initialize PMA
> + * @td:	bsp_priv pointer
> + *
> + * Initialize (or re-initialize) the PMA, configure the clocks and wait for the
> + * eMAC to be ready.
> + */
> +static void tc9564_pma_init(struct tc9564_data *td)
> +{
> +	struct reset_control *rstc = td->resets[RESET_ID_PMA].rstc;
> +	struct regmap *regmap = td->config_regmap;
> +	void __iomem *pmatop;
> +	u32 val;
> +	int ret;
> +	u32 i;
> +
> +	/*
> +	 * When we re-initialize the PMA then the reset will already have
> +	 * been deasserted. We must make sure the PMA reset is asserted
> +	 * before we change the clock settings.
> +	 */
> +	WARN_ON(reset_control_assert(rstc));
> +
> +	pmatop = td->res.addr + DWMAC_PMATOP_OFFSET;
> +
> +	/* Power on CML buffer (0 = normal mode, 1 = power down) */
> +	writel(0, pmatop + PMA_CML_GL_PM_CFG0);
> +
> +	/* This value switches clock from C0_REFCK to CLK_REF_I */
> +	val = u32_encode_bits(WRITE_MASK_VALUE, COMM_CFG_WRITE_MASK_MASK);
> +	val |= COMM_CFG_ENABLE;
> +	val |= u32_encode_bits(WRITE_DATA_VALUE, COMM_CFG_WRITE_DATA_MASK);
> +
> +	for (i = 0; i < PMA_REG_COUNT; i++) {
> +		u32 offset =  i * PMA_HWT_REFCK_STRIDE;
> +
> +		/* Disable C0_REFCK and 100 ohm termination */
> +		writel(0, pmatop + PMA_HWT_REFCK_R_EN + offset);
> +		writel(0, pmatop + PMA_HWT_REFCK_TERM_EN + offset);
> +
> +		/* Switch clock from C0_REFCK to CLK_REF_I */
> +		offset =  i * PMA_COMM_CFG_0_1_STRIDE;
> +		writel(val, pmatop + PMA_COMM_CFG_0_1 + offset);
> +	}
> +
> +	WARN_ON(reset_control_deassert(rstc));
> +
> +	ret = regmap_read_poll_timeout(regmap, td->emac_ctl_offset,
> +				       val, val & EMAC_INIT_DONE, 50, 1000000);
> +	WARN(ret, "timeout waiting for MAC init done\n");

This is too many WARN_ON / WARN, there's 3 just in this function. At least use
WARN_ON_ONCE, or maybe better 	print a log with pr_warn / dev_warn ?

> +}
> +
> +static int tc9564_mac_speed_select(struct tc9564_data *td,
> +				   phy_interface_t interface, int speed)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mac_speed); i++) {
> +		if (mac_speed[i].phy_interface != interface)
> +			continue;
> +
> +		if (speed == mac_speed[i].speed || speed == SPEED_UNKNOWN)
> +			return mac_speed[i].sp_sel;
> +	}
> +	dev_err(td->dev, "%s/%d unsupported\n", phy_modes(interface), speed);

Is that "mac_speed" lookup table actually needed ? maybe a simpler switch/case
based on the speed alone would be enough, or do we really need to validate
the phy_interface_t each time ?

> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static void tc9564_mac_configure(struct tc9564_data *td,
> +				 phy_interface_t interface, int speed)
> +{
> +	struct regmap *regmap = td->config_regmap;
> +	u32 offset = td->emac_ctl_offset;
> +	int sp_sel;
> +	u32 val;
> +
> +	sp_sel = tc9564_mac_speed_select(td, interface, speed);
> +	if (sp_sel < 0)
> +		return;
> +
> +	/* No error checking needed for MMIO regmap */
> +	regmap_read(regmap, offset, &val);
> +	val |= EMAC_LPIHWCLKEN;
> +	val &= ~EMAC_INV_SGM_SIG_DET;
> +	val = u32_replace_bits(val, PCS_CLK_PHY, EMAC_PHY_INF_SEL_MASK);
> +	val = u32_replace_bits(val, sp_sel, EMAC_SP_SEL_MASK);
> +	regmap_write(regmap, offset, val);
> +}
> +
> +static void tc9564_mac_enable(struct tc9564_data *td)
> +{
> +	WARN_ON(clk_bulk_prepare_enable(td->clock_count, td->clocks));
> +
> +	WARN_ON(reset_control_deassert(td->resets[RESET_ID_MAC].rstc));
> +
> +	tc9564_mac_configure(td, td->plat->phy_interface, SPEED_UNKNOWN);
> +	tc9564_pma_init(td);
> +
> +	WARN_ON(reset_control_deassert(td->resets[RESET_ID_XPCS].rstc));

Too many warns :)

> +}
> +
> +static void tc9564_mac_disable(struct tc9564_data *td)
> +{
> +	WARN_ON(reset_control_bulk_assert(ARRAY_SIZE(td->resets), td->resets));

same

Maxime
