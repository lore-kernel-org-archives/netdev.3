Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B873BE146;
	Wed, 16 Sep 2026 06:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541257; cv=none; b=C2O2hvVTM9H3zY5lBsUBI1pRcAaFgiF0YTLfumCJ3EwX7ukqQ7PkPcBTAFXQnpaWRjsVWHgDm6JLhgjpydilFbz5AMYIeOjN/6tU3KxAqSLplreGZicjzWY2h24AoYyzeBan4IasirEq4EDvoek6Ik5fWxr+8DL4AaJji+JrZtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541257; c=relaxed/simple;
	bh=HQxmnThvgffYpLOl4WSo1X+/Cr3X/dNGx+sSBew8dYg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hEwrJv9xRW0IbZ7tYcO1qxZvq/55l6hkdggQFiRnhiK6f4dtq6fCquFQBQL7h01/l7DmQycYu9vPDCtcm2d+8wPaMRZU0jb63co4LiDS+4CZxZvFUKwYBH8IevqHU9y11lDXWws83UkewKfmaw+i5COXCYSqNsr0kXgMooxyZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NA6laQSG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NA6laQSG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB641F0089A;
	Wed, 16 Sep 2026 06:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541252;
	bh=Y/KTxHzxAa9v4rVu6Q4f/ssq2cP991EBjni4vP/Og24=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NA6laQSGP76MvfaJE0IhJ+I0gp+k6tJNbJyNP7vl0nEz1s7PO3IGm353TiOTXFCqD
	 nNq9+ikI16/70Oo5dQEFj2jnBqgJDqJpaNS30LgbEr7qGrXO9B7UjJujy3WvWD8NDy
	 jZWbri8P6VYg8pWS+R1iP57JWP/BWbl+HP9V4JIkBSyAH0GTHohrtoQsRKDrI/httN
	 jbcNwDsM9+byWdntpmQUVXbOX84DfxZKMaIrrKf2qgfSRu+yGhm49NbLblBEgxLvLm
	 8kI6YdXlMM0S6VXt8FEZXWDF1QjrPH/oTmKuOm2XKH0iBfD6PALODQyUl3Ha8s6S+/
	 VZOzKw5LgtBBQ==
Subject: Re: [PATCH net-next v11 08/15] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Wed, 16 Sep 2026 06:47:31 +0000
Message-ID: <178954125102.22033.1370276121014380023@kernel.org>
In-Reply-To: <20260914-ax88179a-v11-8-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-8-5ea7a925ba6d@birger-koblitz.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 1

- [High] NULL function-pointer dereference reachable from userspace: the
  AX88179A/279/772D path is entirely phylink/mdiobus based, yet…
- [Medium] This patch exposes .get_eee/.set_eee to userspace for the
  AX88179A/772D/279, but the driver has no LPI timer support and never…
- [Medium] ax88179a_ethtool_ops
  (drivers/net/usb/ax88179a_devices.c:224-241), the table this patch…
- [Low] Commit message inaccuracies.

--

ax88179_178a: Add EEE configuration support for AX88179A PHYs

This adds ethtool .get_eee/.set_eee handlers that forward to
phylink_ethtool_get_eee()/phylink_ethtool_set_eee(), and copies
phylink_config.supported_interfaces into phylink_config.lpi_interfaces so
that phylink considers the MAC capable of LPI.  A few questions below.

> ax88179_178a: Add EEE configuration support for AX88179A PHYs
>
> Configure phylink to work with the PHYs in the AX88197A controllers
> and provide ethtool get/set eee operations calling into phylink.

[Severity: Low]
Is "AX88197A" a real part number?  The chips handled by
drivers/net/usb/ax88179a_devices.c are AX88179A/AX88279/AX88772D, as the
probe message in ax88179a_bind() says:

    "AX88179A/279/772D Chip Version: ..."

Should the subject prefix be updated too?  After the file split earlier in
the series the module is ax88179:

    drivers/net/usb/Makefile:
    ax88179-y := ax88179_178a.o ax88179a_devices.o ax88179_lib.o

and the only file touched here is ax88179a_devices.c.

One more thing on the body: the description "Configure phylink to work with
the PHYs" does not mention the actual functional effect of the new memcpy.
phylink_create() computes

    pl->mac_supports_eee = pl->mac_supports_eee_ops &&
                           pl->config->lpi_capabilities &&
                           !phy_interface_empty(pl->config->lpi_interfaces);

so filling lpi_interfaces is what makes the LPI MAC ops added by the
previous patch reachable at all, and it also enables EEE handling for
AX88279 (both PHY_INTERFACE_MODE_SGMII and PHY_INTERFACE_MODE_2500BASEX get
copied).  Could the message state that?

> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index 80cabe3557cde..97aad545daee1 100644
> --- a/drivers/net/usb/ax88179a_devices.c
> +++ b/drivers/net/usb/ax88179a_devices.c
> @@ -206,6 +206,20 @@ static int ax88179a_get_eeprom_len(struct net_device *net)
>  		return AX88179A_EEPROM_LEN;
>  }
>  
> +static int ax88179a_get_eee(struct net_device *net, struct ethtool_keee *edata)
> +{
> +	struct ax88179_data *ax179_data = netdev2data(net);
> +
> +	return phylink_ethtool_get_eee(ax179_data->phylink, edata);
> +}
> +
> +static int ax88179a_set_eee(struct net_device *net, struct ethtool_keee *edata)
> +{
> +	struct ax88179_data *ax179_data = netdev2data(net);
> +
> +	return phylink_ethtool_set_eee(ax179_data->phylink, edata);
> +}
> +

[Severity: Medium]
What does userspace see for the LPI timer through these two new ops?
ax88179a_phylink_setup() sets mac_capabilities, lpi_capabilities,
eee_enabled_default and now lpi_interfaces, but never assigns
phylink_config.lpi_timer_default, and phylink_create() does:

    pl->eee_cfg.tx_lpi_timer = pl->config->lpi_timer_default;

phylink_bringup_phy() copies that into phydev->eee_cfg.tx_lpi_timer and
phy_ethtool_get_eee() reports it back via eeecfg_to_eee(), so
"ethtool --show-eee" prints a Tx LPI timer of 0 us.

Is the write side also a concern?  "ethtool --set-eee <dev> tx-lpi-timer N"
returns success: phylink_ethtool_set_eee() -> phy_ethtool_set_eee() stores N
in phydev->eee_cfg and phylink caches it with
eee_to_eeecfg(&pl->eee_cfg, eee), so N is echoed back on subsequent reads
while ax88179a_mac_enable_tx_lpi() throws the value away:

    static int ax88179a_mac_enable_tx_lpi(struct phylink_config *config,
                                          u32 timer, bool tx_clk_stop)
    {
            /* AX88179A does not provide LPI timer registers */
            return ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL,
                                     true, 0, NULL);
    }

The mac_enable_tx_lpi() kernel-doc in include/linux/phylink.h says
"@timer: LPI timeout in microseconds. ... Configure the LPI timeout
accordingly."  Would it be better to advertise the hardware's fixed idle
timeout in lpi_timer_default so ethtool reports the truth, and/or reject a
mismatching timer in the MAC callback rather than silently accepting it?

>  static const struct ethtool_ops ax88179a_ethtool_ops = {
>  	.get_link		= ethtool_op_get_link,
>  	.get_msglevel		= usbnet_get_msglevel,
> @@ -215,6 +229,8 @@ static const struct ethtool_ops ax88179a_ethtool_ops = {
>  	.get_eeprom_len		= ax88179a_get_eeprom_len,
>  	.get_eeprom		= ax88179_get_eeprom,
>  	.set_eeprom		= ax88179_set_eeprom,
> +	.get_eee		= ax88179a_get_eee,
> +	.set_eee		= ax88179a_set_eee,
>  	.nway_reset		= usbnet_nway_reset,

[Severity: High]
While looking at this table: can usbnet_nway_reset() ever work on this
hardware, and can the MII path here oops?

ax88179a_bind() sets only one mii field for the AX88179A family:

    if (!ax179_data->is_ax88772d)
            dev->mii.supports_gmii = 1;

mii.dev, mii.mdio_read, mii.mdio_write and mii.phy_id stay zero, unlike the
legacy sibling ax88179_bind() which fills them all in:

    dev->mii.dev = dev->net;
    dev->mii.mdio_read = ax88179_mdio_read;
    dev->mii.mdio_write = ax88179_mdio_write;
    dev->mii.phy_id_mask = 0xff;

usbnet_nway_reset() bails out with -EOPNOTSUPP when dev->mii.mdio_write is
NULL, so "ethtool -r" is a no-op here even though
phylink_ethtool_nway_reset() exists.

The same uninitialised dev->mii is reachable through
ax88179a_netdev_ops.ndo_eth_ioctl = usbnet_mii_ioctl, which calls
generic_mii_ioctl(&dev->mii, ...):

    case SIOCGMIIPHY:
            mii_data->phy_id = mii_if->phy_id;
            fallthrough;
    case SIOCGMIIREG:
            mii_data->val_out =
                    mii_if->mdio_read(mii_if->dev, mii_data->phy_id,
                                      mii_data->reg_num);

With mdio_read NULL, does "mii-tool eth0" (SIOCGMIIPHY) dereference a NULL
function pointer?  Would phylink_mii_ioctl()/phy_do_ioctl_running() and
phylink_ethtool_nway_reset() be the right entries for a phylink driver?

>  	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
>  	.set_link_ksettings	= phy_ethtool_set_link_ksettings,

[Severity: Medium]
Since this table now mixes phylink-based EEE ops with raw phylib link
settings helpers, should these two be phylink_ethtool_ksettings_get() and
phylink_ethtool_ksettings_set() instead?

The PHY is owned by phylink here:

    ax88179a_init_phy()
        ret = phylink_connect_phy(data->phylink, data->phydev);

but phy_ethtool_set_link_ksettings() operates directly on net->phydev and
calls phy_start_aneg(), so "ethtool -s eth0 advertise <mask>" bypasses
phylink entirely.

phylink_bringup_phy() only narrows phy->advertising once at connect time, so
the MAC limits declared in ax88179a_phylink_setup():

    data->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE | MAC_100;
    if (data->is_ax88772d)
            data->phylink_config.mac_capabilities |= MAC_10;

are not applied to later user changes, and phylink's cached
pl->link_config.advertising goes stale.  That is the same state phylink
consults when computing the EEE advertisement for the new .set_eee path, so
does mixing the two interfaces make the EEE result depend on whether
ethtool -s was used before?

> @@ -440,6 +456,10 @@ static int ax88179a_phylink_setup(struct usbnet *dev)
>  		phy_if_mode = PHY_INTERFACE_MODE_SGMII;
>  	}
>  
> +	memcpy(data->phylink_config.lpi_interfaces,
> +	       data->phylink_config.supported_interfaces,
> +	       sizeof(data->phylink_config.lpi_interfaces));
> +

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-ax88179a-v11-0-5ea7a925ba6d%40birger-koblitz.de
