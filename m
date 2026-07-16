Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141F242255C;
	Thu, 16 Jul 2026 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206939; cv=none; b=mnnqDJABlqvw7vycDM++7qleksOSKvj0jEJQo2H7VISTmmjDC0mRak2jZvfuRECBq8wBikMn7Kdyva7+33kGICfbcwW0v5XCNPg5n1GHse3VqTDs6dh/+BaiOhNQqk+uNsoKAs+TofrdtmHENpwgCH4VDbCROJzmX+7BMIGFW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206939; c=relaxed/simple;
	bh=1HNP4Nw6q0zER9T0cMvm6r69fPS6nGavn7ZTsTwXnY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGIZgjnlQ8UQV9Ky8VpXmlBTGvbNzy71yNFLi0qQ5UwPqXC2oqb+YV4NnWCzvvcHK4R/w+JjLeGMLnJJmzvVnsMAlKAaHcnLoPBqA8ODx6Uc2TvQPqefnE0kyZABLr5ipWSpg08uO9/4AhXYs+CHqFI0kiFKyrrB+J2q1lb5cl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eUOKg4Az; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eUOKg4Az"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 87EF4C2B9E8;
	Thu, 16 Jul 2026 13:02:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1E309602B8;
	Thu, 16 Jul 2026 13:02:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BEFE211BD3C6E;
	Thu, 16 Jul 2026 15:01:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784206927; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=zTUPSuHQAbihWXKOUNBC/PoJhnAlh+bcUK9ov3l4dIk=;
	b=eUOKg4AzJ8Nj9dsSPxLDiiFkQt8iV8mJFUvm36BSRlszf/OY/clhHXabhnOfjqLmdx528s
	zXNe//VBkUeEyPdfvt+uyUW7MZgN9O32bXq3VsvMH9mN4oWv9wxqKYyoq3zXBhz5mbtvt+
	WTMnrTzWPTDjo78wpSQhYhBu3cOxbK22BILluJNsuOxKGr8Nki77FJpeq01uAAHEw1K2Xk
	ms3aMDQ7KawllFARvO0dJDPSzz7kd0smDce/rj7PBzeLjlvkzOoagRReyQmQDyOlWK3js7
	ZoK+jcZbcbMAmn8/xwwoA6Ks1hSs4bRsVJovl7SFLtxPFkn69q1rfeoYpnIJ+Q==
Message-ID: <c7193123-72e1-4bf5-85f7-eb68a4000c44@bootlin.com>
Date: Thu, 16 Jul 2026 15:01:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: phy: add DAPU Telecom DAP8210R(I)
 Gigabit Ethernet PHY driver
To: Artem Shimko <a.shimko.dev@gmail.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260716113805.593215-1-a.shimko.dev@gmail.com>
 <20260716113805.593215-3-a.shimko.dev@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260716113805.593215-3-a.shimko.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/16/26 13:38, Artem Shimko wrote:
> Add a new PHY driver for the DAPU Telecom DAP8211R(I) Gigabit
> Ethernet PHY, which is commonly used in enterprise and industrial
> networking applications.
> 
> The driver implements extended register access via indirect addressing
> through corresponding registers, and provides comprehensive device tree
> support for RGMII delay configuration. The rx-internal-delay-ps and
> tx-internal-delay-ps properties allow precise tuning of clock delays in
> 150 ps steps from 0 to 2250 ps. Additionally, the optional
> dapu,tx-inverted-clk flag enables 180-degree TX clock phase shift for
> boards where signal integrity or MAC requirements necessitate clock
> inversion.
> 
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
> ---
>  drivers/net/phy/Kconfig    |  10 ++
>  drivers/net/phy/Makefile   |   1 +
>  drivers/net/phy/dap8211r.c | 281 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 292 insertions(+)
>  create mode 100644 drivers/net/phy/dap8211r.c
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 099f25dceabb..4576f707ac94 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -237,6 +237,16 @@ config DAVICOM_PHY
>  	help
>  	  Currently supports dm9161e and dm9131
>  
> +config DAP8211R_PHY
> +	tristate "DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY"
> +	depends on OF
> +	help
> +	  Support for the DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY.
> +	  This PHY is designed for enterprise and industrial networking
> +	  applications, supporting 10/100/1000 Mbps operation.
> +	  RGMII with: configurable TX/RX clock delays, optional flag to enable
> +	  180-degree TX clock phase shift and internal packet generator.
> +
>  config ICPLUS_PHY
>  	tristate "ICPlus PHYs"
>  	help
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index de660ae94945..ad35733eb4bb 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_BROADCOM_PHY)	+= broadcom.o
>  obj-$(CONFIG_CICADA_PHY)	+= cicada.o
>  obj-$(CONFIG_CORTINA_PHY)	+= cortina.o
>  obj-$(CONFIG_DAVICOM_PHY)	+= davicom.o
> +obj-$(CONFIG_DAP8211R_PHY)	+= dap8211r.o
>  obj-$(CONFIG_DP83640_PHY)	+= dp83640.o
>  obj-$(CONFIG_DP83822_PHY)	+= dp83822.o
>  obj-$(CONFIG_DP83848_PHY)	+= dp83848.o
> diff --git a/drivers/net/phy/dap8211r.c b/drivers/net/phy/dap8211r.c
> new file mode 100644
> index 000000000000..e1e6a322ef0c
> --- /dev/null
> +++ b/drivers/net/phy/dap8211r.c
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: GPL
> +/*
> + * Driver for the DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY.
> + *
> + * Specifications:
> + *   - IEEE 802.3 10BASE-Te, 100BASE-TX, 1000BASE-T
> + *   - IEEE 802.3az-2010 Energy Efficient Ethernet
> + *   - IEEE 1588 SyncE support
> + *   - RGMII
> + *
> + * Author: Artem Shimko <a.shimko.dev@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/errno.h>
> +#include <linux/ethtool.h>
> +#include <linux/kernel.h>
> +#include <linux/mii.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/of.h>
> +#include <linux/phy.h>
> +
> +#define DAP8211R_PHY_ID			0x0008011B
> +#define DAP8211R_PHY_ID_MASK		0xFFFFFFFF
> +
> +#define DAP8211R_EXT_ADD		0x1E
> +#define DAP8211R_EXT_DATA		0x1F
> +
> +#define DAP8211R_PHY_CON		0xA001
> +#define DAP8211R_PHY_SW_RST		BIT(15)
> +
> +#define DAP8211R_RGMII_CON		0xA003
> +#define DAP8211R_RGMII_TX_DEL_MASK	GENMASK(3, 0)
> +#define DAP8211R_RGMII_RX_DEL_MASK	GENMASK(13, 10)
> +#define DAP8211R_RGMII_CLK_INVERT	BIT(14)
> +
> +/* Default RGMII delay: 13 * 150 == 1.95ns */
> +#define DAP8211R_DEFAULT_DELAY_SEL	0xD
> +
> +struct dap8211r_delay_config {
> +	u32 ps;
> +	u8 sel;
> +};
> +
> +static const struct dap8211r_delay_config delay_config[] = {
> +	{   0, 0},
> +	{ 150, 1},
> +	{ 300, 2},
> +	{ 450, 3},
> +	{ 600, 4},
> +	{ 750, 5},
> +	{ 900, 6},
> +	{1050, 7},
> +	{1200, 8},
> +	{1350, 9},
> +	{1500, 10},
> +	{1650, 11},
> +	{1800, 12},
> +	{1950, 13},
> +	{2100, 14},
> +	{2250, 15},
> +};
> +
> +#define DAP8211R_DELAY_COUNT	ARRAY_SIZE(delay_config)
> +
> +/**
> + * dap8211r_delay_ps_to_sel() - Convert ps to register value (exact match only)
> + * @ps: Delay in picoseconds
> + *
> + * Converts a delay value in picoseconds to the corresponding register value
> + * for RGMII delay configuration. The PHY supports specific values from
> + * 0 to 2250 ps in 150 ps steps.
> + *
> + * Return: Register value (0-15) on success, -EINVAL if @ps is not supported.
> + */
> +
> +static int dap8211r_delay_ps_to_sel(u32 ps)
> +{
> +	for (int i = 0; i < DAP8211R_DELAY_COUNT; i++)
> +		if (ps == delay_config[i].ps)
> +			return delay_config[i].sel;
> +
> +	return -EINVAL;
> +}
> +
> +/**
> + * dap8211r_read_ext() - Read extended register
> + * @phydev: PHY device structure
> + * @reg: Extended register address
> + *
> + * Reads a PHY extended register using the indirect access method.
> + * The caller must hold the MDIO bus lock.
> + *
> + * Return: Register value on success, or negative error code
> + */
> +static int dap8211r_read_ext(struct phy_device *phydev, u16 reg)
> +{
> +	int ret;
> +
> +	phy_lock_mdio_bus(phydev);
> +	ret = __phy_write(phydev, DAP8211R_EXT_ADD, reg);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = __phy_read(phydev, DAP8211R_EXT_DATA);
> +out:
> +	phy_unlock_mdio_bus(phydev);
> +	return ret;
> +}
> +
> +/**
> + * dap8211r_modify_ext() - Modify extended register bits
> + * @phydev: PHY device structure
> + * @reg: Extended register address
> + * @mask: Bit mask of bits to clear
> + * @set: Bit mask of bits to set
> + *
> + * Modifies a PHY extended register using the indirect access method.
> + * New value = (old value & ~mask) | set.
> + * The caller must hold the MDIO bus lock.
> + *
> + * Return: 0 on success, or negative error code
> + */
> +static int dap8211r_modify_ext(struct phy_device *phydev, u16 reg, u16 mask, u16 set)
> +{
> +	int ret;
> +
> +	phy_lock_mdio_bus(phydev);
> +	ret = __phy_write(phydev, DAP8211R_EXT_ADD, reg);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = __phy_modify(phydev, DAP8211R_EXT_DATA, mask, set);
> +out:
> +	phy_unlock_mdio_bus(phydev);
> +	return ret;
> +}
> +
> +/**
> + * dap8211r_get_rgmii_delay() - Get RGMII delay from DT
> + * @phydev: PHY device
> + * @prop_name: DT property name
> + * @is_id: If phy mode is PHY_INTERFACE_MODE_RGMII_[TXID,RXID,ID]
> + *
> + * Reads the RGMII delay from the device tree. If the property is not
> + * specified, the default delay (1950ps) is used.
> + *
> + * Return: Register value (0-15) on success, negative error code on failure.
> + *	   -EINVAL: Property not specified and is_id is false.
> + */
> +static int dap8211r_get_rgmii_delay(struct phy_device *phydev, const char *prop_name, bool is_id)
> +{
> +	struct device_node *np = phydev->mdio.dev.of_node;
> +	u32 ps = 0;
> +	int ret;
> +
> +	ret = of_property_read_u32(np, prop_name, &ps);
> +	if (ret == -EINVAL)
> +		return (is_id) ? DAP8211R_DEFAULT_DELAY_SEL : ret;
> +	if (ret < 0)
> +		return ret;
> +
> +	return dap8211r_delay_ps_to_sel(ps);
> +}
> +
> +/**
> + * dap8211r_config_init() - Initialize PHY
> + * @phydev: PHY device structure
> + *
> + * Configures the PHY during initialization:
> + * - RGMII delays based on interface mode
> + * - TX clock invertion
> + * - Software reset to apply settings (low active, self clear)
> + *
> + * Return: 0 on success, or negative error code
> + */
> +static int dap8211r_config_init(struct phy_device *phydev)
> +{
> +	struct device_node *phydev_node = phydev->mdio.dev.of_node;
> +	u16 mask = 0, set = 0;
> +	int ret, retries = 10;
> +
> +	switch (phydev->interface) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +		ret = dap8211r_get_rgmii_delay(phydev, "rx-internal-delay-ps", false);
> +		if (ret >= 0) {
> +			set = FIELD_PREP(DAP8211R_RGMII_RX_DEL_MASK, ret);
> +			mask = DAP8211R_RGMII_RX_DEL_MASK;
> +		} else if ((ret < 0) && (ret != -EINVAL)) {
> +			return ret;
> +		}
> +
> +		ret = dap8211r_get_rgmii_delay(phydev, "tx-internal-delay-ps", false);
> +		if (ret >= 0) {
> +			set |= FIELD_PREP(DAP8211R_RGMII_TX_DEL_MASK, ret);
> +			mask |= DAP8211R_RGMII_TX_DEL_MASK;
> +		} else if ((ret < 0) && (ret != -EINVAL)) {
> +			return ret;
> +		}
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		ret = dap8211r_get_rgmii_delay(phydev, "rx-internal-delay-ps", true);
> +		if (ret < 0)
> +			return ret;
> +
> +		set = FIELD_PREP(DAP8211R_RGMII_RX_DEL_MASK, ret);
> +		mask = DAP8211R_RGMII_RX_DEL_MASK;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +		ret = dap8211r_get_rgmii_delay(phydev, "rx-internal-delay-ps", true);
> +		if (ret < 0)
> +			return ret;
> +
> +		set = FIELD_PREP(DAP8211R_RGMII_RX_DEL_MASK, ret);
> +		mask = DAP8211R_RGMII_RX_DEL_MASK;
> +		fallthrough;
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		ret = dap8211r_get_rgmii_delay(phydev, "tx-internal-delay-ps", true);
> +		if (ret < 0)
> +			return ret;
> +
> +		set |= FIELD_PREP(DAP8211R_RGMII_TX_DEL_MASK, ret);
> +		mask |= DAP8211R_RGMII_TX_DEL_MASK;
> +		break;
> +	default:
> +		phydev_err(phydev, "Unsupported interface: %d\n",
> +			   phydev->interface);
> +		return -EINVAL;
> +	}

You can simplify the whole delay parsing a log by using phy_get_internal_delay().
It will give you the index of the delay from the delay table you have :)

https://elixir.bootlin.com/linux/v7.1.3/source/drivers/net/phy/phy_device.c#L3085

You can take a look at the few drivers that use it (mscc, dp83869) for reference

Maxime
