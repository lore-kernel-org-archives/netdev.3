Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50A4F93B0;
	Thu, 17 Sep 2026 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680302; cv=none; b=UmZ0s16qY/wRKuBz8ApdgC4Fny5bwLjdAAoACAB25VxWwv7Yxc/xtjz4GipkBZ4eFeMU+Pd1ybYF+yl7tBBD5Ea1fPFpMmwVMZzqMtnpxsrbFD/G0StOjlwB9JFFPHzrwdJaPkfKNFDzHB7yPEUTPWjaE0ln7D03qhIHqQof4Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680302; c=relaxed/simple;
	bh=1LjZxFB9JzgscBi3gs/+Dy8rvM8PKEmr+afsgKgH0nM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WtyghXJ89VilLouc5Tm8yPJColZYx51N1y1B/egY8rq+IbTMkMVYowupEY82OHIag+nbQoTOafKKYjT/jOdqAD7c5u4ufUYTJfvl+PfnlQZvumLjL1CfEn1SlNjNd5jt0xoagrhRIIl0ySJvEo+7PRCv2569I3qfwjyYCzWUNQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hafZJYyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hafZJYyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96F51F00899;
	Thu, 17 Sep 2026 21:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680300;
	bh=PCweAarrOEjsJAewhlf/5bnAlcZgvtm9MRqEZtk2a2U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hafZJYyK284Q/O+IEqitZlHGJChqEEAwC9lsJReDIkT1g0TioYLYACUfCKUiVm9mw
	 GNvwLP/QI7WiIk6A78q096ivC9avwX0kD8F1h7EbKwnOMOkd4tuCEHch7Yks4ABCBp
	 TYoRUQQjbrATyuwP5SpBf/X9t7Z+If2UFv6yU7oCCUX9ML5PVLHGrtMu02re3JUoIZ
	 luoR3ODy+W7pNc5mrwtCmWBzZJKogr0VwZo880paAUIoJxYG2bUeDHkGO4yAj6K5dV
	 LOIrkW318uFj5kId3pQnH2sSlm6ZCovmeK3jRBJtsI9V3NO0WliPi3MPBDzVbY6/H0
	 hO+GYD1Y+pnkA==
Subject: Re: [PATCH net-next v12 08/15] ax88179_178a: Add EEE configuration
 support for AX88179A PHYs
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Thu, 17 Sep 2026 21:24:59 +0000
Message-ID: <178968029951.22033.7295791968219633553@kernel.org>
In-Reply-To: <20260916-ax88179a-v12-8-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-8-60c04c9924a2@birger-koblitz.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] The patch exposes .get_eee/.set_eee (ax88179a_devices.c:209-221,
  table entries at :232-233) and activates the LPI path by populating…
- [Low] The commit message contains a non-existent part number:
  "Configure phylink to work with the PHYs in the AX88197A controllers"…

--

ax88179_178a: Add EEE configuration support for AX88179A PHYs

This adds .get_eee/.set_eee to ax88179a_ethtool_ops, both forwarding to
phylink, and copies supported_interfaces into
phylink_config.lpi_interfaces in ax88179a_phylink_setup() so phylink
considers the MAC LPI capable.

>     ax88179_178a: Add EEE configuration support for AX88179A PHYs
>
>     Configure phylink to work with the PHYs in the AX88197A controllers
>     and provide ethtool get/set eee operations calling into phylink.

[Severity: Low]
Should "AX88197A" read "AX88179A" here?  The driver only knows
AX_VERSION_AX88179A, AX88772D and AX88279, so the part number in the
changelog does not match anything in the tree.

Also, would it help to spell out which variants are affected?
ax88179a_phylink_setup() and ax88179a_ethtool_ops are shared by all three
chips, and dev->net->ethtool_ops = &ax88179a_ethtool_ops is assigned in
ax88179a_bind() without a chip check, so AX88279 gains user-configurable
EEE too, while AX88772D stays unsupported because lpi_capabilities is left
at 0 for it:

	if (!data->is_ax88772d) {
		data->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;
		data->phylink_config.eee_enabled_default = false;
	}

and phylink_ethtool_get_eee()/phylink_ethtool_set_eee() then return
-EOPNOTSUPP for that variant.

Finally, the message says only "configure phylink to work with the PHYs",
which does not mention the actual mechanism being added, namely declaring
the MAC's LPI-capable interfaces so phylink_create() sets
mac_supports_eee.

> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index 785919e14e861..6bf1ac17aa1d5 100644
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

[ ... ]

> @@ -440,6 +456,10 @@ static int ax88179a_phylink_setup(struct usbnet *dev)
>  		phy_if_mode = PHY_INTERFACE_MODE_SGMII;
>  	}
>  
> +	memcpy(data->phylink_config.lpi_interfaces,
> +	       data->phylink_config.supported_interfaces,
> +	       sizeof(data->phylink_config.lpi_interfaces));
> +

[Severity: Low]
This isn't a bug, but what does userspace see for the Tx LPI timer now?

ax88179a_phylink_setup() never assigns phylink_config.lpi_timer_default,
so phylink_create() leaves pl->eee_cfg.tx_lpi_timer at 0, and
ax88179a_get_eee() -> phylink_ethtool_get_eee() reports 0 us via
ethtool --show-eee.

In the other direction, ethtool --set-eee <dev> tx-lpi-timer N goes
through ax88179a_set_eee() -> phylink_ethtool_set_eee() -> eee_to_eeecfg()
which stores the value, but the MAC callback drops it:

	static int ax88179a_mac_enable_tx_lpi(struct phylink_config *config, u32 timer, bool tx_clk_stop)
	{
		struct usbnet *dev = netdev_priv(to_net_dev(config->dev));

		/* AX88179A does not provide LPI timer registers */
		return ax88179_write_cmd(dev, AX_GPHY_CTL, AX_GPHY_EEE_CTRL, true, 0, NULL);
	}

so the value is accepted and echoed back by get_eee without ever reaching
hardware.

For the record, this same combination already exists upstream:
ksz_phylink_get_caps() copies supported_interfaces into lpi_interfaces
without setting lpi_timer_default, and
ksz_phylink_mac_enable_tx_lpi() documents "@timer: timer value before
entering LPI (unused)" and just returns 0.  Would setting
lpi_timer_default to whatever fixed timeout the PHY uses still be worth
doing here, so --show-eee reports something meaningful?

>  	phylink = phylink_create(&data->phylink_config, dev->net->dev.fwnode,
>  				 phy_if_mode, &ax88179a_phylink_mac_ops);
>  	if (IS_ERR(phylink))

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ax88179a-v12-0-60c04c9924a2%40birger-koblitz.de
