Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E421933372A;
	Fri, 31 Jul 2026 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526647; cv=none; b=WKKAhAwvlibdHlM++62pcz3Ajhgj/vbeIcmvna3PVsh5FVNyFFMZM3UENBbAqO4nVGKB9Kv9kmAswX51A7maacLlgUJcRA6irD6k5m/z7DnHxxEbAq9s+AhamVY3IF34qqfpj09o39CEL7hLhoGEpMUplVVPbbWziKV4v4rmez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526647; c=relaxed/simple;
	bh=NB/PwCqVQAHiVelzBswTiN8ZoxQRfIuDcaO9gbe7GMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OI5W8AUNV478BYe0f2TWpLphuIXSnB52K18M9SHRxIzkPEpS7DVqBFCmDM0Dj6g28GdjwQEmd5yWJN4rNTs1uvJP3cMm+GnXECndXIy/nsdRNg4dNeCMpQM4Oh5RBZRrpy0Koi5DsyruVcoqS/oS4Evk4H/2eAYxXyCNv3uc0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MePVDpXD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MePVDpXD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8CzcEyA1wO04nQo+U8qgjK9ddh8HvnIYb//dcKYDGkU=; b=MePVDpXDpXTnK+oYBzwyCcIJoz
	FLdT1EFBftd1t8/U5VtVIIOZ2fvyWCR99NG8NjZYZ+sP49T2pmEwz2gtPHlppx46208YrpoGiD+Eb
	iiAr7XiFdcJ2WtAbj4nzC5WtIknLdHhqIioJ8nZM2oC5M7FiKoUki1zFRVeeh/RdAmlc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wpt2d-00FHhV-NY; Fri, 31 Jul 2026 21:37:11 +0200
Date: Fri, 31 Jul 2026 21:37:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v4 03/12] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <3eb5691a-4a84-487e-8d5e-f91a646c03c1@lunn.ch>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
 <20260731-ax88179a-v4-3-2cf1f71b1dd2@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-ax88179a-v4-3-2cf1f71b1dd2@birger-koblitz.de>

> +static int ax88179_mdiobus_write(struct mii_bus *bus, int phy_id, int regnum, u16 val)
> +{
> +	struct usbnet *dev = bus->priv;
> +	u16 res = (u16)val;

val already is a u16, so the cast is not needed.

> +
> +	return ax88179_write_cmd(dev, AX_ACCESS_PHY, phy_id, (__u16)regnum, 2, &res);

Does ax88179_write_cmd actually modify the res value? I'm just
wondering why you need the local copy.

> +static void ax88179a_get_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
> +{
> +	struct usbnet *dev = netdev_priv(net);
> +	struct ax88179_data *data;
> +
> +	data = dev->driver_priv;

This pattern happens enough that it is worth adding a helper,
netdev2data() or something like that.

> +static void ax88179a_mac_link_up(struct phylink_config *config,
> +				 struct phy_device *phy,
> +				 unsigned int phy_mode, phy_interface_t interface,
> +				 int speed, int duplex,
> +				 bool tx_pause, bool rx_pause)
> +{

> +
> +	netdev_info(dev->net, "ax88179a - Link status is: 1, Link speed: %d, Duplex: %d\n",
> +		    speed, duplex);
> +}

Maybe not needed? Does phylink print something?

> +static int ax88179a_init_mdio(struct usbnet *dev)
> +{
> +	struct ax88179_data *data = dev->driver_priv;
> +	int ret;
> +
> +	data->mdio = mdiobus_alloc();
> +	if (!data->mdio)
> +		return -ENOMEM;
> +
> +	data->mdio->priv = dev;
> +	data->mdio->read = ax88179_mdiobus_read;
> +	data->mdio->write = ax88179_mdiobus_write;
> +	data->mdio->read_c45 = ax88179_mdiobus_read_c45;
> +	data->mdio->write_c45 = ax88179_mdiobus_write_c45;
> +	data->mdio->name = "AX88179A MDIO Bus";
> +	data->mdio->phy_mask = ~(1 << AX88179_PHY_ID);
> +	/* mii bus name is usb-<usb bus number>-<usb device number> */
> +	snprintf(data->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
> +		 dev->udev->bus->busnum, dev->udev->devnum);
> +
> +	netdev_err(dev->net, "Registering MDIO bus\n");

Left over debug.

> +	/* Initialize MII structure */
> +	dev->mii.dev = dev->net;
> +	dev->mii.mdio_read = ax88179_mdio_read;
> +	dev->mii.mdio_write = ax88179_mdio_write;
> +	dev->mii.phy_id_mask = 0xff;
> +	dev->mii.reg_num_mask = 0xff;
> +	dev->mii.phy_id = AX88179_PHY_ID;

So the aim is this is removed. Do the follow up patches remove it?

> +static int ax88179a_reset(struct usbnet *dev)
> +{
> +	struct ax88179_data *ax179_data = dev->driver_priv;
> +	u16 *tmp16;
> +	u8 buf[5];
> +	u8 *tmp;
> +
> +	tmp16 = (u16 *)buf;
> +	tmp = (u8 *)buf;
> +
> +	/* Power up ethernet PHY */
> +	*tmp = AX_PHY_POWER;
> +	ax88179_write_cmd(dev, AX88179A_PHY_POWER, 0, 0, 1, tmp);
> +	msleep(250);
> +
> +	if (ax179_data->chip_version == AX_VERSION_AX88279) {
> +		*tmp16 = ax88179_mdio_read(dev->net, dev->mii.phy_id, MII_ADVERTISE);
> +		*tmp16 &= ~(ADVERTISE_10FULL | ADVERTISE_10HALF);
> +		*tmp16 |= AX_ADVERTISE_2500;
> +		ax88179_mdio_write(dev->net, dev->mii.phy_id, MII_ADVERTISE, *tmp16);
> +	}

If the PHY driver is doing the correct thing, this is not needed.  So
long as you tell phylink that 10Mbps is not supported by the MAC, it
should disable the advertisement of 10Mps link modes.

> +	ax179_data->eee_enabled = 0;
> +	ax179_data->eee_active = 0;

Are these used anywhere? Phylink should be tracking the EEE state, not
the MAC driver.

Overall, this is looking a lot better.

Thanks for continuing to work on this.

       Andrew
