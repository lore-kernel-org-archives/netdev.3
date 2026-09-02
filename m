Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4107035AC20;
	Wed,  2 Sep 2026 05:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327403; cv=none; b=Bv8b5kDkZamhOHci7J+qa1BUBxUN+pP5PwRyx+YIgqx6w0ODaWqMl62Fc+1FWME5VDItB3aIVIq0vtMzovo1LBVfjA34bkFbM4JqF0AUHfdqcJqfvE3+FEYQk6Ab8yItOq2xQXqcJoLHxLyL44STjRPbzAJ+hWRL2hu1sdTKMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327403; c=relaxed/simple;
	bh=EW95iMc+HD2EV1QbMuQQWWMqn8jnXihC+IITPzQ98Nk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D+m5Gq4MlcEjc6HikzOsokUhGG38Q+IBfhf8S1hU2ixqs4mCwk7t32vU9Oe6DZkinhePVXZW9Vp1ghAgI8t8E+W1ja5eVs6+ajgZrKAgy94NH2AHuUG+76Mp6PySj/WFu5NJkPuKEW8+p+dfDsg1gVfHu0NwBEJZhWeytaSxcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tqj6MJ0H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tqj6MJ0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C5F1F00A3A;
	Wed,  2 Sep 2026 05:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788327401;
	bh=nP+IKRrI12tQiqaPXgsj+gPxrpnK92e3DFKJgQuf2NQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Tqj6MJ0HZr2exBv1xpIUGy1ELztryIh8pN/UCvFya4pDDUP/9I5rxde8R0qzKK+P+
	 kKD/BVwH5E6IAEjLqOxqKJKZMarV1MlhNxSmha/VNKF5oAk0nmXk06LqbdSZ+c4Wpk
	 4UaE5eL3AFl4204q2vBw3bVUoPLItK8XXkK0ZEG6LJrvUaxQ/EkYyA2oyMA2GK9OIq
	 xZ8B3NJYTKtQB8lWb7TM2kdV3/A3//cs0BNh/pbGirHQAn8z5Tyenw06y6d/zuvnWm
	 3DoGX+PBuD5V5kIsrpH8hdctQehlZOodS9pLb+gsxuVgPOhuzEV8K5qs2O879vROde
	 qNWVG6QlOLvlQ==
Subject: Re: [net-next,v15,07/13] net: mdio: realtek-rtl9300: Configure
 hardware polling during probing
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Wed, 02 Sep 2026 05:36:40 +0000
Message-ID: <178832740065.3394541.13669961918312863118@kernel.org>
In-Reply-To: <20260831143439.2404484-8-markus.stockhausen@gmx.de>
References: <20260831143439.2404484-8-markus.stockhausen@gmx.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 2

- [Medium] Asymmetric polling control: otto_emdio_init_polling()
  (drivers/net/mdio/mdio-realtek-rtl9300.c:786) clears the chip-wide…
- [Low] No rollback of the chip-wide polling state on probe failure and
  no teardown counterpart.
- [Low] Concern that otto_emdio_set_port_polling() writes the SMI
  polling-control register without holding priv->lock, allowing polling…

--

net: mdio: realtek-rtl9300: Configure hardware polling during probing

This adds a poll_ctrl register offset per chip variant and a helper to
toggle the per-port hardware polling bit. Polling is disabled for all
ports at probe time, re-enabled from a new notify_phy_attach callback and
disabled again from notify_phy_detach.

References given in the commit message:
[1] https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/files-6.18/drivers/net/mdio/mdio-realtek-otto.c#L818
[2] https://lore.kernel.org/netdev/680696024a8648535ce6dee771fe4de67802e0e8.1769053496.git.daniel@makrotopia.org/

> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index 7de8adec243ba..a925640290cb0 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c

[ ... ]

> @@ -253,6 +256,12 @@ static struct otto_emdio_priv *otto_emdio_bus_to_priv(struct mii_bus *bus)
>  	return chan->priv;
>  }
>  
> +static int otto_emdio_set_port_polling(struct otto_emdio_priv *priv, int port, bool active)
> +{
> +	return regmap_assign_bits(priv->regmap, priv->info->poll_ctrl + (port / 32) * 4,
> +				  BIT(port % 32), active);
> +}

[Severity: Low]
A question about the claim in the commit message that "Enabling/disabling
hardware polling is a simple regmap bit access. For this it is enough to
rely on the regmap internal lock." otto_emdio_set_port_polling() runs
without priv->lock, so a polling toggle for one port can land while an
indirect command sequence for another port is in flight.

Reading the file again this looks fine, since priv->lock only covers the
indirect command register sequence:

    otto_emdio_read_cmd()/otto_emdio_write_cmd() {
        lockdep_assert_held(&priv->lock);

and poll_ctrl (0xca90 / 0x0ccc) is not one of the command registers
(c22_data/c45_data/io_data/port_mask_low/port_mask_high/broadcast/ext_page),
while regmap_assign_bits() does the read-modify-write under the regmap
lock. Also, in steady state the polling bits of all attached ports are
already set while commands run, so taking priv->lock around the toggle
would not change the interference behaviour.

Is that reasoning correct, i.e. is the intended invariant "priv->lock
covers the command sequence registers only" rather than "all hardware
access"?

[ ... ]

> @@ -596,6 +605,36 @@ static int otto_emdio_9310_setup_controller(struct otto_emdio_priv *priv)
>  	return 0;
>  }
>  
> +static int otto_emdio_notify_phy_attach(struct phy_device *phydev)
> +{
> +	struct otto_emdio_priv *priv = otto_emdio_bus_to_priv(phydev->mdio.bus);
> +	int port = otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr);
> +
> +	if (port < 0) {
> +		/* All subsequent bus operations will fail */
> +		phydev_err(phydev, "PHY is not mapped to a valid switch port\n");
> +		return port;
> +	}
> +
> +	return otto_emdio_set_port_polling(priv, port, true);
> +}

[ ... ]

> @@ -741,6 +783,19 @@ static int otto_emdio_map_ports(struct device *dev)
>  	return err;
>  }
>  
> +static int otto_emdio_init_polling(struct otto_emdio_priv *priv)
> +{
> +	int err;
> +
> +	for (int port = 0; port < priv->info->num_ports; port++) {
> +		err = otto_emdio_set_port_polling(priv, port, false);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Is the enable/disable pair symmetric here?

otto_emdio_init_polling() clears the polling bit for every port from 0 to
info->num_ports - 1, but the only place a bit is ever set again is
otto_emdio_notify_phy_attach(), which is reached only from
phy_attach_direct() and returns early when otto_emdio_phy_to_port() cannot
map the address:

    if (port < 0) {
        /* All subsequent bus operations will fail */
        phydev_err(phydev, "PHY is not mapped to a valid switch port\n");
        return port;
    }

priv->valid_ports is filled only from ethernet-ports children that carry a
phy-handle:

    otto_emdio_map_ports() {
        ...
        phy_dn = of_parse_phandle(port_dn, "phy-handle", 0);
        /* skip ports without phys */
        if (!phy_dn)
            continue;

So can a port that never gets a phydev attached ever have its polling bit
restored? cameo-rtl9302c-2x-rtl8224-2xge.dts has port@24 and port@25 with
phy-mode = "10gbase-r" and no phy-handle, which look like concrete
instances of that.

The file header states the constraint this affects:

 * - Without the polling and a proper MAC status, some of the link handling features do not work.
 *   Especially an unpopulated MAC_LINK_STS register cancels operations to other MAC registers.

The commit message says "Disable polling for all ports when the MDIO driver
starts" and "it brings the hardware polling into a consistent operation mode
for devices where U-Boot does not take care", but does not mention that
ports without a kernel-managed PHY are never re-enabled and that the
bootloader mask is overwritten without any save/restore. Could that be
spelled out, or the loop restricted to priv->valid_ports?

Note there is no in-tree MAC or DSA driver for these SoCs today, so on a
pure mainline kernel notify_phy_attach() never runs and the net effect of
loading this driver is that polling stays off for all ports. That makes the
functional impact only demonstrable with an out-of-tree or future MAC
driver, but the asymmetry in the code is visible as is.

>  static int otto_emdio_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -760,6 +815,10 @@ static int otto_emdio_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->regmap))
>  		return PTR_ERR(priv->regmap);
>  
> +	err = otto_emdio_init_polling(priv);
> +	if (err)
> +		return err;
> +
>  	platform_set_drvdata(pdev, priv);
>  
>  	err = otto_emdio_map_ports(dev);

[Severity: Low]
Should the polling mask be restored when probe fails?

otto_emdio_init_polling() runs right after the syscon regmap is obtained,
before platform_set_drvdata() and before otto_emdio_map_ports(),
otto_emdio_setup_topology(), info->setup_controller() and
otto_emdio_probe_one()/devm_of_mdiobus_register(), each of which does a
plain "return err".

The bits live in the shared switch syscon regmap rather than in
driver-private memory, so devres unwinding does not undo them, and the
driver has neither a .remove callback nor a devm_add_action() for this.
Does a non-deferred probe failure (missing ethernet-ports node, illegal or
duplicate port number, devm_mdiobus_alloc_size() returning -ENOMEM,
devm_of_mdiobus_register() failing) leave the switch with polling disabled
for all ports with nothing to restore it?

The same applies mid-loop in otto_emdio_init_polling():

    err = otto_emdio_set_port_polling(priv, port, false);
    if (err)
        return err;

which returns with a partially modified mask and no saved copy of the
previous register value.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831143439.2404484-1-markus.stockhausen%40gmx.de
