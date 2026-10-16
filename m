Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C72D6E5A;
	Fri, 16 Oct 2026 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170884; cv=none; b=X89jD/mqvLqtiBEeDFIQPL5vgPZ9f8TWWuaFjjANNqo6F+GcgB6A8OxTGYnDmCW3nesBVlzLcsfAykjugLl66C2uCUN4jXhhxZcyenposPFArKPYn4IQ8BbbEa9IBTkVHehnE6WZi5grBqIwvfiJqfkbWFRY6KkCndBF9g10wFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170884; c=relaxed/simple;
	bh=oYjSgEgoTVkAqaic/eLXsthjcrJqD0NXBt9N8/nVNIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UW8HD4FskXIh+xs+JCrgehh2jqUYQH41J7BbDPdCf6CHSxU4cfO/v+OfpHsn217s9BCp7ZVZqLVjW+GqOC8dS90G5UF/DwbS3g13KBGImQA+IY2c+LwFI5CzLJQ2uF48t3f+3TjOw8CU1dTaZyYll0c/6OZ8ziUoiryWs/+DfuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=J0Be9/kM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="J0Be9/kM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yk5QjouUMVgrI9mYSPXA66yoO1F4fmgDZyJqEKOQrG0=; b=J0Be9/kMLz0FNq2E1ciKmOdKrb
	Mx0Vpin6IRwXunELqsTiZDE0aGwpioJ4kntiGTV6htzwJPyApzV8b483+vzB5HGn+KyjaQExyCu2h
	X44SkfTrZ/1t5m9pOHxgW4QrE6bYdKywFVXJIaYRgiPss37nKvW6ZLsYk2UzH94Ffl+M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHlVg-00BBg8-KI; Fri, 16 Oct 2026 19:14:24 +0200
Date: Fri, 16 Oct 2026 19:14:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pufan Jin <cyan2254650260@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Add JLSemi JL21xx Gigabit Ethernet
 PHY driver
Message-ID: <cdadd697-fc26-43eb-a427-07f557e3b6aa@lunn.ch>
References: <20261016161543.444356-1-cyan2254650260@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016161543.444356-1-cyan2254650260@gmail.com>

On Sat, Oct 17, 2026 at 12:15:43AM +0800, Pufan Jin wrote:
> Add a new PHY driver for JLSemi (Jinglue Semiconductor (Shanghai)
> Co., Ltd.) Gigabit Ethernet PHYs, specifically supporting the JL2101,
> JL2121, and generic JL21xx models.
> 
> The driver implements:
> - Paged register access via register 0x1f
> - RGMII TX and RX internal delay configuration with Device Tree
>   support via phy_get_internal_delay()
> - Link downshift and resolved speed, duplex, and master/slave mode
>   reporting from vendor-specific status registers
> - Interrupt handling for link state change and PME wakeup events
> - Hardware LED control via the Linux LED class / netdev triggers
> - Wake-on-LAN (WoL) with magic packet matching
> - Autonomous EEE disable to prevent interoperability packet drops
> - Power management (suspend / resume)
> 
> Link: https://www.jlsemi.com/
> Signed-off-by: Pufan Jin <cyan2254650260@gmail.com>
> ---
>  MAINTAINERS              |   6 +
>  drivers/net/phy/Kconfig  |   9 +
>  drivers/net/phy/Makefile |   1 +
>  drivers/net/phy/jlsemi.c | 551 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 567 insertions(+)
>  create mode 100644 drivers/net/phy/jlsemi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f53047aa8..4f738a573 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13976,6 +13976,12 @@ T:	git https://github.com/kleikamp/linux-shaggy.git
>  F:	Documentation/admin-guide/jfs.rst
>  F:	fs/jfs/
>  
> +JLSEMI PHY DRIVER
> +M:	Pufan Jin <cyan2254650260@gmail.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	drivers/net/phy/jlsemi.c
> +
>  JME NETWORK DRIVER
>  M:	Guo-Fu Tseng <cooldavid@cooldavid.org>
>  L:	netdev@vger.kernel.org
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index b4ef927fd..535a48084 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -270,6 +270,15 @@ config INTEL_XWAY_PHY
>  	  PEF 7061, PEF 7071 and PEF 7072 or integrated into the Intel
>  	  SoCs xRX200, xRX300, xRX330, xRX350 and xRX550.
>  
> +config JLSEMI_PHY
> +	tristate "JLSemi Ethernet PHYs"
> +	help
> +	  Supports the JLSemi Gigabit Ethernet PHYs, including the
> +	  JL2121 and JL2101 models found on embedded system carrier boards
> +	  and single-board computers.
> +
> +	  If unsure, say N.
> +
>  config LSI_ET1011C_PHY
>  	tristate "LSI ET1011C PHY"
>  	help
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index 25c4a3c24..2d7758e86 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_DP83TG720_PHY)	+= dp83tg720.o
>  obj-$(CONFIG_FIXED_PHY)		+= fixed_phy.o
>  obj-$(CONFIG_ICPLUS_PHY)	+= icplus.o
>  obj-$(CONFIG_INTEL_XWAY_PHY)	+= intel-xway.o
> +obj-$(CONFIG_JLSEMI_PHY)	+= jlsemi.o
>  obj-$(CONFIG_LSI_ET1011C_PHY)	+= et1011c.o
>  obj-$(CONFIG_LXT_PHY)		+= lxt.o
>  obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
> diff --git a/drivers/net/phy/jlsemi.c b/drivers/net/phy/jlsemi.c
> new file mode 100644
> index 000000000..c3acff48d
> --- /dev/null
> +++ b/drivers/net/phy/jlsemi.c
> @@ -0,0 +1,551 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Driver for JLSemi Gigabit Ethernet PHYs (JL2121 / JL2101)
> + *
> + * Copyright (C) 2026 Pufan Jin <cyan2254650260@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/ethtool.h>
> +#include <linux/ethtool_netlink.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/phy.h>
> +
> +#define PHY_ID_JL2101			0x937c4032
> +#define PHY_ID_JL2121			0x937c4030
> +#define PHY_ID_JL21XX			0x937c0000
> +#define JLSEMI_PHY_ID_MASK		0xffff0000
> +
> +#define JLSEMI_PAGE_SELECT		0x1f
> +
> +/* Status page and register */
> +#define JLSEMI_STATUS_PAGE		0xa43
> +#define JLSEMI_PHYSR			0x1a
> +#define JLSEMI_PHYSR_DUPLEX		BIT(3)
> +#define JLSEMI_PHYSR_SPEED_MASK		GENMASK(5, 4)
> +#define JLSEMI_PHYSR_SPEED_1000		0x20
> +#define JLSEMI_PHYSR_SPEED_100		0x10
> +#define JLSEMI_PHYSR_SPEED_10		0x00
> +#define JLSEMI_PHYSR_MASTER		BIT(11)
> +
> +/* RGMII delay page and registers */
> +#define JLSEMI_RGMII_PAGE		0xd08
> +#define JLSEMI_TXCR			0x11
> +#define JLSEMI_TX_DELAY			BIT(8)
> +#define JLSEMI_RXCR			0x15
> +#define JLSEMI_RX_DELAY			BIT(3)
> +
> +/* Power and EEE configuration */
> +#define JLSEMI_PHYCR2			0x19
> +#define JLSEMI_PHYCR2_PHY_EEE_ENABLE	BIT(5)
> +
> +/* Interrupt page and registers */
> +#define JLSEMI_INSR			0x1d
> +#define JLSEMI_INER_PAGE		0xa42
> +#define JLSEMI_INER			0x12
> +#define JLSEMI_INER_LINK_STATUS		BIT(4)
> +#define JLSEMI_INER_PME			BIT(7)
> +
> +/* Wake-on-LAN settings */
> +#define JLSEMI_WOL_PAGE			0xd8a
> +#define JLSEMI_WOL_SETTINGS_EVENTS	16
> +#define JLSEMI_WOL_EVENT_MAGIC		BIT(12)
> +#define JLSEMI_WOL_RST_RMSQ		17
> +#define JLSEMI_WOL_RG_RSTB		BIT(15)
> +#define JLSEMI_WOL_RMSQ			0x1fff
> +
> +/* Physical MAC address for WoL */
> +#define JLSEMI_PHYSICAL_ADDR_PAGE	0xd8c
> +#define JLSEMI_PHYSICAL_ADDR_WORD0	16
> +#define JLSEMI_PHYSICAL_ADDR_WORD1	17
> +#define JLSEMI_PHYSICAL_ADDR_WORD2	18
> +
> +/* LED control */
> +#define JLSEMI_LED_COUNT		3
> +#define JLSEMI_LEDCR_PAGE		0xd04
> +#define JLSEMI_LEDCR			0x10
> +#define JLSEMI_LEDCR_MODE		BIT(15)
> +#define JLSEMI_LEDCR_ACT_TXRX		BIT(4)
> +#define JLSEMI_LEDCR_LINK_1000		BIT(3)
> +#define JLSEMI_LEDCR_LINK_100		BIT(1)
> +#define JLSEMI_LEDCR_LINK_10		BIT(0)
> +#define JLSEMI_LEDCR_MASK		GENMASK(4, 0)
> +#define JLSEMI_LEDCR_SHIFT		5
> +
> +struct jlsemi_priv {
> +	u16 iner;
> +};
> +
> +static int jlsemi_read_page(struct phy_device *phydev)
> +{
> +	return __phy_read(phydev, JLSEMI_PAGE_SELECT);
> +}
> +
> +static int jlsemi_write_page(struct phy_device *phydev, int page)
> +{
> +	return __phy_write(phydev, JLSEMI_PAGE_SELECT, page);
> +}
> +
> +static int jlsemi_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct jlsemi_priv *priv;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	phydev->priv = priv;
> +
> +	return 0;
> +}
> +
> +static int jlsemi_config_rgmii_delay(struct phy_device *phydev)
> +{
> +	u16 val_txdly = 0, val_rxdly = 0;
> +	s32 rx_delay = -1, tx_delay = -1;
> +	int ret;
> +
> +	if (!phy_interface_is_rgmii(phydev))
> +		return 0;

...

> +static int jlsemi_config_init(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = jlsemi_disable_autonomous_eee(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (phy_interface_is_rgmii(phydev)) {
> +		ret = jlsemi_config_rgmii_delay(phydev);
> +		if (ret < 0)
> +			return ret;
> +	}

No need to test for RGMII twice.

> +static int jlsemi_read_status(struct phy_device *phydev)
> +{

> +	if (phydev->speed >= SPEED_1000) {

The > can be dropped. It should not happen.

Humm, actually. Should this be SPEED_100?

> +static void jlsemi_get_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
> +{
> +	int val;
> +
> +	wol->supported = WAKE_MAGIC;
> +	wol->wolopts = 0;
> +
> +	val = phy_read_paged(phydev, JLSEMI_WOL_PAGE, JLSEMI_WOL_SETTINGS_EVENTS);
> +	if (val < 0)
> +		return;
> +
> +	if (val & JLSEMI_WOL_EVENT_MAGIC)
> +		wol->wolopts |= WAKE_MAGIC;

I think you need something like:

        if (!device_can_wakeup(&dev->mdio.dev)) {
                wol->supported = 0;
                return;
        }

in order to determine if the PHY really can wake the system.

Look at realtek_main.c and

commit b826bf795564ddef6402cf2cb522ae035bd117ae
Author: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Date:   Wed Aug 13 11:04:45 2025 +0100

    net: phy: realtek: fix RTL8211F wake-on-lan support

> +static struct phy_driver jlsemi_drivers[] = {
> +	{
> +		PHY_ID_MATCH_EXACT(PHY_ID_JL2101),
> +		.name			= "JLSemi JL2101 Gigabit Ethernet",
> +		.features		= PHY_GBIT_FEATURES,

Should not be needed, if the device describes itself correctly.

> +	{
> +		.phy_id			= PHY_ID_JL21XX,
> +		.phy_id_mask		= JLSEMI_PHY_ID_MASK,

PHY_ID_MATCH_VENDOR()

> +
> +static const struct mdio_device_id __maybe_unused jlsemi_tbl[] = {
> +	{ PHY_ID_MATCH_EXACT(PHY_ID_JL2101) },
> +	{ PHY_ID_MATCH_MODEL(PHY_ID_JL2121) },
> +	{ PHY_ID_JL21XX, JLSEMI_PHY_ID_MASK },
> +	{ /* sentinel */ }

PHY_ID_MATCH_VENDOR() should work here as well.


    Andrew

---
pw-bot: cr
	
