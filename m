Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D62C4052D9;
	Fri, 25 Sep 2026 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790378427; cv=none; b=cSoTP0M3I1OaOwgkiOXCc1KDCOP2/EAAKLs/HqLg7lmOs2TVnhoo0lGsoF70A4agzGNSKnLAvXSusqzJ6VdncMlVjfWHvKZV1/IZZqg/GRAcdPmFpHuU9NdQRmMcjOXc5gunhaifRH5AzDf7I9R7Gy4bMvJlARqua5k+VvgD6QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790378427; c=relaxed/simple;
	bh=qDDn7S7fkI624qO1l2d++Ebdya+dURosmfA3mOPJH9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKbqo/TolJFN8vbiDAhYU/8OY4wC0ruWHLPjBmNpFMe0LOidn3G/KdLdtJZ9m+s/iA6VRNfiBaI4oiwOJgPaWyU/nMVeyvXiQ1H5KH+dd06GUiY0PBVisVQBLhCGovQD4KMXW/6SFlgyy6bwUjIL6cFWCHjdJ5jlCHKmaBU3Jts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YAbONOm4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YAbONOm4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bdRAuVYJ24AiBGURuaHS+Y/B4MaoMRz5vRylc4AgETo=; b=YAbONOm4LrdjOW7M47eb7B4UHs
	WENs8RV9Hv1N4Jb3TZV9lTSNxkwNTmzIYYrDq/09ByvZAZxckT1P3Zx3Kf65C8jTYPU8ZSzsS2AcO
	8ir4VVEa4EI9CMBhidn4uD7gy/xGUfm7iEyqXgtE2DJlGnG0339LPRQLt8KmkbLKpoEE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAFDF-007KEj-MU; Sat, 26 Sep 2026 01:20:17 +0200
Date: Sat, 26 Sep 2026 01:20:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v3 6/8] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
Message-ID: <716486ec-6253-41dd-83ac-b816c845fafe@lunn.ch>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-6-ddebafcb9ba7@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-devel-vstrassheim-soce-dsa-ml-v3-6-ddebafcb9ba7@linutronix.de>

On Wed, Sep 23, 2026 at 12:39:33PM +0200, Vasilij Strassheim wrote:
> Add a DSA driver for SoC-e FPGA-based Ethernet switch IP cores.
> 
> Read the core version and synthesis-time feature registers during probe.
> Require DSA support and between 3 and 31 implemented ports, without
> exceeding the licensed port count. Derive each port's phylink
> capabilities from its phy-mode.
> 
> Enable "DSA custom rules" tagging for all frames during setup. This
> directs ingress traffic from user ports to the CPU port while standalone
> ports remain isolated. Enable and disable port ingress and egress
> through the DSA port callbacks, and disable tagging again during
> teardown so that unbinding the driver does not leave its managed
> configuration active.
> 
> Populate the integrated MDIO controller and mux child devices used for
> external PHY access.
> 
> Tested with a SoC-e MRS 25.01 IP core on a Xilinx ZynqMP platform.
> 
> Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> ---
>  drivers/net/dsa/Kconfig              |   2 +
>  drivers/net/dsa/Makefile             |   1 +
>  drivers/net/dsa/soce/Kconfig         |  14 ++
>  drivers/net/dsa/soce/Makefile        |   4 +
>  drivers/net/dsa/soce/soce_dsa.h      |  26 +++
>  drivers/net/dsa/soce/soce_dsa_core.c | 343 +++++++++++++++++++++++++++++++++++
>  6 files changed, 390 insertions(+)
> 
> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index fe8cd5338fda..879fbede83f0 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -94,6 +94,8 @@ source "drivers/net/dsa/ocelot/Kconfig"
>  
>  source "drivers/net/dsa/qca/Kconfig"
>  
> +source "drivers/net/dsa/soce/Kconfig"
> +
>  source "drivers/net/dsa/sja1105/Kconfig"
>  
>  source "drivers/net/dsa/xrs700x/Kconfig"
> diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
> index 7e637d56b35c..97de3d181440 100644
> --- a/drivers/net/dsa/Makefile
> +++ b/drivers/net/dsa/Makefile
> @@ -26,4 +26,5 @@ obj-y				+= ocelot/
>  obj-y				+= qca/
>  obj-y				+= realtek/
>  obj-y				+= sja1105/
> +obj-y				+= soce/
>  obj-y				+= xrs700x/
> diff --git a/drivers/net/dsa/soce/Kconfig b/drivers/net/dsa/soce/Kconfig
> new file mode 100644
> index 000000000000..c31b7c5af695
> --- /dev/null
> +++ b/drivers/net/dsa/soce/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config NET_DSA_SOCE
> +	tristate "SoC-e switches"
> +	depends on NET_DSA
> +	depends on OF
> +	depends on HAS_IOMEM
> +	select MDIO_BUS_MUX_MMIOREG
> +	select MDIO_SOCE
> +	select NET_DSA_TAG_SDSA
> +	help
> +	  This enables support for switches based on SoC-e IP cores.
> +	  Frames are exchanged with the CPU port using the SDSA DSA tag protocol.
> +	  The driver supports switch variants whose features and number of ports
> +	  are selected at synthesis time and detected at runtime.
> diff --git a/drivers/net/dsa/soce/Makefile b/drivers/net/dsa/soce/Makefile
> new file mode 100644
> index 000000000000..2a6d95ef663f
> --- /dev/null
> +++ b/drivers/net/dsa/soce/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_NET_DSA_SOCE) += soce_dsa.o
> +soce_dsa-objs := soce_dsa_core.o
> diff --git a/drivers/net/dsa/soce/soce_dsa.h b/drivers/net/dsa/soce/soce_dsa.h
> new file mode 100644
> index 000000000000..2acd4dbaf958
> --- /dev/null
> +++ b/drivers/net/dsa/soce/soce_dsa.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020-2026 System on Chip engineering, S.L.
> + * Copyright (c) 2026 Linutronix GmbH
> + * Author: Vasilij Strassheim <v.strassheim@linutronix.de>
> + */
> +
> +#ifndef __SOCE_DSA_H
> +#define __SOCE_DSA_H
> +
> +#include <linux/types.h>
> +
> +#include <net/dsa.h>
> +
> +#define SOCE_MAX_NUM_PORTS 31
> +
> +struct soce_dsa_local {
> +	void __iomem *base_addr;
> +};
> +
> +struct soce_priv {
> +	struct soce_dsa_local local;
> +	struct dsa_switch ds;
> +};
> +
> +#endif /* __SOCE_DSA_H */
> diff --git a/drivers/net/dsa/soce/soce_dsa_core.c b/drivers/net/dsa/soce/soce_dsa_core.c
> new file mode 100644
> index 000000000000..d391b11b94ad
> --- /dev/null
> +++ b/drivers/net/dsa/soce/soce_dsa_core.c
> @@ -0,0 +1,343 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020-2026 System on Chip engineering, S.L.
> + * Copyright (c) 2026 Linutronix GmbH
> + * Author: Vasilij Strassheim <v.strassheim@linutronix.de>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/of.h>
> +#include <linux/of_net.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy.h>
> +#include <linux/phylink.h>
> +#include <linux/platform_device.h>
> +
> +#include <net/dsa.h>
> +
> +#include "soce_dsa.h"
> +
> +#define SOCE_MIN_NUM_PORTS			3
> +
> +#define SOCE_CORE_VERSION_OFFSET		0x0000
> +#define SOCE_CORE_VERSION_VERSION_SHIFT		24
> +#define SOCE_CORE_VERSION_SUBVERSION_SHIFT	16
> +#define SOCE_MIN_CORE_VERSION			0x24
> +#define SOCE_MIN_CORE_SUBVERSION		0x01
> +
> +#define SOCE_LIC_FEATURES_OFFSET		0x0004
> +#define SOCE_LIC_FEATURES_NUM_PORTS_MASK	GENMASK(31, 27)
> +
> +#define SOCE_IMPL_FEATURES0_OFFSET		0x000c
> +#define SOCE_IMPL_FEATURES0_NUM_PORTS_MASK	GENMASK(31, 27)
> +#define SOCE_IMPL_FEATURES0_PORT_VLAN		BIT(9)
> +#define SOCE_IMPL_FEATURES0_DSA			BIT(23)
> +
> +#define SOCE_DSA_REGS_BASE			0x1200
> +#define SOCE_TAG_ALL_FRAMES_CTRL_OFFSET		(SOCE_DSA_REGS_BASE + 0x001c)
> +#define SOCE_TAG_ALL_FRAMES_CTRL_ENABLE		BIT(0)
> +#define SOCE_CUSTOM_RULES_TAGGING_OFFSET	(SOCE_DSA_REGS_BASE + 0x0020)
> +#define SOCE_CUSTOM_RULES_TAGGING_ENABLE	BIT(0)
> +
> +#define SOCE_PORTS_REGS_BASE			0x3000
> +#define SOCE_PORTS_SELECTOR_OFFSET		SOCE_PORTS_REGS_BASE
> +#define SOCE_PORTS_SELECTOR_PORT_MASK		GENMASK(7, 0)
> +#define SOCE_PORTS_CTRL_OFFSET			(SOCE_PORTS_REGS_BASE + 0x0004)
> +#define SOCE_PORTS_CTRL_INGR_EN			BIT(0)
> +#define SOCE_PORTS_CTRL_EGR_EN			BIT(1)
> +
> +static void soce_phylink_get_caps(struct dsa_switch *ds, int port,
> +				  struct phylink_config *config)
> +{
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	phy_interface_t mode;
> +	int ret;
> +
> +	ret = of_get_phy_mode(dp->dn, &mode);
> +	if (ret)
> +		return;
> +
> +	if (phy_interface_mode_is_rgmii(mode))
> +		phy_interface_set_rgmii(config->supported_interfaces);
> +	else
> +		__set_bit(mode, config->supported_interfaces);
> +
> +	config->mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
> +
> +	switch (mode) {
> +	case PHY_INTERFACE_MODE_MII:
> +		config->mac_capabilities |= MAC_10 | MAC_100;
> +		break;
> +	case PHY_INTERFACE_MODE_GMII:
> +		config->mac_capabilities |= MAC_10 | MAC_100 | MAC_1000;
> +		break;
> +	case PHY_INTERFACE_MODE_RMII:
> +		config->mac_capabilities |= MAC_10FD | MAC_100FD;
> +		break;
> +	default:
> +		if (phy_interface_mode_is_rgmii(mode))
> +			config->mac_capabilities |= MAC_10FD | MAC_100FD |
> +						    MAC_1000FD;
> +		break;
> +	}
> +}
> +
> +static int soce_sw_validate_core_version(u8 version, u8 subversion)
> +{
> +	if (version < SOCE_MIN_CORE_VERSION ||
> +	    (version == SOCE_MIN_CORE_VERSION &&
> +	     subversion < SOCE_MIN_CORE_SUBVERSION))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static void soce_sw_read_core_version(struct soce_dsa_local *local,
> +				      u8 *version, u8 *subversion,
> +				      u16 *revision)
> +{
> +	u32 regval;
> +
> +	regval = readl(local->base_addr + SOCE_CORE_VERSION_OFFSET);
> +	*version = (u8)(regval >> SOCE_CORE_VERSION_VERSION_SHIFT);
> +	*subversion = (u8)(regval >> SOCE_CORE_VERSION_SUBVERSION_SHIFT);
> +	*revision = (u16)regval;
> +}
> +
> +static int soce_sw_detect_features(struct soce_dsa_local *local,
> +				   u32 *numports)
> +{
> +	void __iomem *base = local->base_addr;
> +	u32 implemented_numports;
> +	u32 licensed_numports;
> +	u32 regval;
> +
> +	regval = readl(base + SOCE_LIC_FEATURES_OFFSET);
> +	licensed_numports = FIELD_GET(SOCE_LIC_FEATURES_NUM_PORTS_MASK, regval);
> +	if (!licensed_numports || licensed_numports > SOCE_MAX_NUM_PORTS)
> +		return -EINVAL;
> +
> +	regval = readl(base + SOCE_IMPL_FEATURES0_OFFSET);
> +	if (!(regval & SOCE_IMPL_FEATURES0_DSA))
> +		return -ENODEV;
> +
> +	implemented_numports =
> +		FIELD_GET(SOCE_IMPL_FEATURES0_NUM_PORTS_MASK, regval);
> +	if (implemented_numports < SOCE_MIN_NUM_PORTS ||
> +	    implemented_numports > licensed_numports)
> +		return -EINVAL;
> +
> +	*numports = implemented_numports;
> +
> +	return 0;
> +}
> +
> +static void soce_sw_enable_tagging(struct soce_dsa_local *local)
> +{
> +	void __iomem *base = local->base_addr;
> +	u32 regval;
> +
> +	regval = readl(base + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
> +	regval |= SOCE_TAG_ALL_FRAMES_CTRL_ENABLE;
> +	writel(regval, base + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
> +
> +	regval = readl(base + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
> +	regval |= SOCE_CUSTOM_RULES_TAGGING_ENABLE;
> +	writel(regval, base + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
> +}
> +
> +static void soce_sw_disable_tagging(struct soce_dsa_local *local)
> +{
> +	void __iomem *base = local->base_addr;
> +	u32 regval;
> +
> +	regval = readl(base + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
> +	regval &= ~SOCE_TAG_ALL_FRAMES_CTRL_ENABLE;
> +	writel(regval, base + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
> +
> +	regval = readl(base + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
> +	regval &= ~SOCE_CUSTOM_RULES_TAGGING_ENABLE;
> +	writel(regval, base + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
> +}
> +
> +static void soce_port_select(struct soce_dsa_local *local, int port)
> +{
> +	writel(FIELD_PREP(SOCE_PORTS_SELECTOR_PORT_MASK, port),
> +	       local->base_addr + SOCE_PORTS_SELECTOR_OFFSET);
> +}
> +
> +static void soce_port_set_enabled(struct soce_dsa_local *local, int port,
> +				  bool enabled)
> +{
> +	void __iomem *base = local->base_addr;
> +	u32 regval;
> +
> +	soce_port_select(local, port);
> +
> +	regval = readl(base + SOCE_PORTS_CTRL_OFFSET);
> +	if (enabled)
> +		regval |= SOCE_PORTS_CTRL_INGR_EN | SOCE_PORTS_CTRL_EGR_EN;
> +	else
> +		regval &= ~(SOCE_PORTS_CTRL_INGR_EN | SOCE_PORTS_CTRL_EGR_EN);
> +	writel(regval, base + SOCE_PORTS_CTRL_OFFSET);
> +}
> +
> +static int soce_port_enable(struct dsa_switch *ds, int port,
> +			    struct phy_device *phy)
> +{
> +	struct soce_priv *priv = ds->priv;
> +
> +	soce_port_set_enabled(&priv->local, port, true);
> +
> +	return 0;
> +}
> +
> +static void soce_port_disable(struct dsa_switch *ds, int port)
> +{
> +	struct soce_priv *priv = ds->priv;
> +
> +	soce_port_set_enabled(&priv->local, port, false);
> +}
> +
> +static int soce_setup(struct dsa_switch *ds)
> +{
> +	struct soce_priv *priv = ds->priv;
> +
> +	soce_sw_enable_tagging(&priv->local);

Once all the setup is finished, what is the state of the switch?

What we want is that the user ports are isolated from each other, and
can only exchange frames with the CPU. That makes the hardware
basically a port expander, and you do bridging in software. Later
patches can then add offload of bridging, and whatever else the
hardware can do, which Linux can also do in software.

	Andrew
