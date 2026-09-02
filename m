Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC0E38758C;
	Wed,  2 Sep 2026 05:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327407; cv=none; b=UjIdPZvk0Hzv6KtrOjLdQZDtvaDGGQd94XIjQz8/DrrLtI2MBKtJeUBfXm832AjDSyX6Jrow6ti9pKeZTpngntm7nWkq6jEG8GOLWQ+x2s4mydXYh0Q6Y1JzRhHLWHi50ChhU6s3ISsXLtSzuF//RslglkNz1aJmm39DdIJmIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327407; c=relaxed/simple;
	bh=PK/FWWehGLFaLTiqWVOyihZM52jAgczzjuxMrm129iA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gi5czt1x52/I+Ysss0h3b5Es20Bmlh9ofDpBHyQbqbmp+/t6oWp1LL0QGVi9i7p5pR/3x4iVHrCJ3NvVTQ4MLYgbjj6q41ubQsn5EHf47fB/FDI5tEPG+uHjHOqJzKNJkOXTWn9SXW4knIrBlGIh4mbXib6nNq71/d94IncNiAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb7aAwla; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb7aAwla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAC61F00A3A;
	Wed,  2 Sep 2026 05:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788327406;
	bh=Y6IQbBn3Cx/BWmZYf6oCeu7h2HCAWR3VNIWpyWvQBg0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Cb7aAwla7aGBSmEWVwqvgNnIyL00BTUrjXiUF77sa/GEKFTm9AAsg+knw6pd4wDd1
	 E+gFcmA7sLnOH1pl/dErz3shB1OVJkh/ICUyFUxUeSw/l+84W3Zlr7HDDm63Ra5p4Z
	 GzcAhbIKife6j9BYCFry3Ea+8ZS04lZrtRhi20+55RLRdHe38n0uUQNsD8S3JIwQaw
	 n7dZNMndkLhNKdx19PCajIsiH57dJaNJyw029x8mRJyfYiEZKW/ZFIhHTIJUIzGIl/
	 U1Y/ryArqRKg4/y9fqAhSqbDnFq5O0hwGHqnvdmcXogmO8+YmE6gwbA9zSgoCIlmbO
	 ZW4/z4/3KunNw==
Subject:
 Re: [net-next,v15,11/13] net: mdio: realtek-rtl9300: Add support for RTL838x
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Wed, 02 Sep 2026 05:36:44 +0000
Message-ID: <178832740475.3394541.12105423283158871835@kernel.org>
In-Reply-To: <20260831143439.2404484-12-markus.stockhausen@gmx.de>
References: <20260831143439.2404484-12-markus.stockhausen@gmx.de>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 3

- [Medium] On the newly added RTL838x variant, a device tree that
  declares a Clause 45 PHY (compatible = "ethernet-phy-ieee802.3-c45")…
- [Low] DISCARDED (fixed later in the same series): Kconfig prompt/help
  text and MODULE_DESCRIPTION still advertise only the RTL9300 family…
- [Low] The driver now matches "realtek,rtl8380-mdio", but no in-tree
  binding documents a parent node that satisfies what the driver…
- [Low] The RTL838x variant introduced here declares RTL8380_NUM_BUSES =
  1, but Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml…

--

net: mdio: realtek-rtl9300: Add support for RTL838x

This patch adds the RTL838x (maple) variant to the Realtek MDIO driver by
duplicating the RTL9300-style register defines with an RTL8380 prefix,
adding C22/C45 accessors, a setup_controller() callback that sets the PHY
patch-done bit, and the new "realtek,rtl8380-mdio" match entry.

A few questions below on the new variant description and the device tree
side.

> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index b90972c1dc6a2..57ab89afb9e5e 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
> @@ -126,6 +126,28 @@
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  
> +#define RTL8380_NUM_BUSES			1
      ^^^^

[Severity: Low]
Should the binding also express the one-bus limit for this compatible?
Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml applies the
same subnode pattern to every compatible and has no per-compatible if/then
block:

  patternProperties:
    '^mdio-bus@[0-3]$':
      $ref: mdio.yaml#

So a device tree for realtek,rtl8380-mdio with mdio-bus@1 through
mdio-bus@3 validates cleanly, but the driver then refuses it in
otto_emdio_probe_one():

  if (mdio_bus >= priv->info->num_buses)
          return dev_err_probe(dev, -EINVAL,
                               "illegal (dangling) smi bus number %d\n", mdio_bus);

and otto_emdio_map_ports() likewise returns -EINVAL for
"illegal smi bus number". Since otto_emdio_probe() propagates that error,
the whole controller fails to probe and even the valid bus 0 is never
registered. The later 2-bus RTL839x compatible in this series has the same
gap.

> +#define RTL8380_NUM_PAGES			4096
> +#define RTL8380_NUM_PORTS			28
> +#define RTL8380_SMI_GLB_CTRL			0xa100
> +#define   RTL8380_SMI_PHY_PATCH_DONE		BIT(15)
> +#define RTL8380_SMI_ACCESS_PHY_CTRL_0		0xa1b8
> +#define RTL8380_SMI_ACCESS_PHY_CTRL_1		0xa1bc
> +#define   RTL8380_PHY_CTRL_REG_ADDR		GENMASK(24, 20)
> +#define   RTL8380_PHY_CTRL_PARK_PAGE		GENMASK(19, 15)
> +#define   RTL8380_PHY_CTRL_MAIN_PAGE		GENMASK(14, 3)
> +#define   RTL8380_PHY_CTRL_WRITE		BIT(2)
> +#define   RTL8380_PHY_CTRL_READ			0
> +#define   RTL8380_PHY_CTRL_TYPE_C45		BIT(1)
> +#define   RTL8380_PHY_CTRL_TYPE_C22		0
> +#define   RTL8380_PHY_CTRL_FAIL			0 /* no fail indicator */
> +#define RTL8380_SMI_ACCESS_PHY_CTRL_2		0xa1c0
> +#define   RTL8380_PHY_CTRL_INDATA		GENMASK(31, 16)
> +#define   RTL8380_PHY_CTRL_DATA			GENMASK(15, 0)
> +#define RTL8380_SMI_ACCESS_PHY_CTRL_3		0xa1c4
> +#define RTL8380_SMI_POLL_CTRL			0xa17c
> +#define RTL8380_SMI_PORT0_5_ADDR_CTRL		0xa1c8
> +
>  #define RTL9300_NUM_BUSES			4
>  #define RTL9300_NUM_PAGES			4096
>  #define RTL9300_NUM_PORTS			28

[ ... ]

> @@ -586,6 +662,15 @@ static int otto_emdio_setup_topology(struct otto_emdio_priv *priv)
>  	return 0;
>  }
>  
> +static int otto_emdio_8380_setup_controller(struct otto_emdio_priv *priv)
> +{
> +	/*
> +	 * PHY_PATCH_DONE enables PHY control via SoC. This is required for PHY access, including
> +	 * patching and must be set before the PHYs are probed.
> +	 */
> +	return regmap_set_bits(priv->regmap, RTL8380_SMI_GLB_CTRL, RTL8380_SMI_PHY_PATCH_DONE);
> +}

[Severity: Medium]
Can priv->smi_bus_is_c45[] end up set on RTL838x with nothing in the
hardware matching it?

otto_emdio_map_ports() sets the flag for any variant:

  if (of_device_is_compatible(phy_dn, "ethernet-phy-ieee802.3-c45"))
          priv->smi_bus_is_c45[bus] = true;

For RTL9300/RTL9310 that flag is consumed by their setup_controller()
callbacks, which program RTL9300_GLB_CTRL_INTF_SEL and
RTL9310_SMI_GLB_FMT_SEL_C45. The new RTL838x callback above never reads it,
which matches the commit message: "The setup_controller() function needs no
C45 configuration as polling only works in C22 mode".

The flag still has a software consumer in otto_emdio_notify_phy_attach():

  if (!priv->smi_bus_is_c45[chan->mdio_bus] &&
      !phy_id_compare_vendor(phydev->phy_id, RTL_VENDOR_ID)) {
          phydev_err(phydev, "Only Realtek PHYs allowed on C22 bus\n");
          return -EOPNOTSUPP;
  }

  return otto_emdio_set_port_polling(priv, port, true);

With RTL8380_NUM_BUSES == 1, a single PHY node declaring
compatible = "ethernet-phy-ieee802.3-c45" disables that check for every PHY
on the device, and polling is then armed anyway for the port. The PHY keeps
being accessed with the Realtek paged C22 encoding (priv->page[port] into
RTL8380_PHY_CTRL_MAIN_PAGE) by a polling engine that only does C22.

Because RTL8380_PHY_CTRL_FAIL is 0, otto_emdio_run_cmd() can never report a
hardware failure here:

  return cmdstate & info->cmd_fail ? -ENXIO : 0;

Would it make sense for the RTL838x path to reject (or at least warn about)
a bus flagged as C45, rather than letting the driver bookkeeping and the
hardware mode diverge silently?

[ ... ]

> @@ -923,6 +1030,7 @@ static const struct otto_emdio_info otto_emdio_9310_info = {
>  };
>  
>  static const struct of_device_id otto_emdio_ids[] = {
> +	{ .compatible = "realtek,rtl8380-mdio", .data = &otto_emdio_8380_info },

[Severity: Low]
Is there a binding for the parent node this compatible needs?

otto_emdio_probe() takes its regmap from the parent:

  priv->regmap = syscon_node_to_regmap(dev->parent->of_node);

and otto_emdio_map_ports() requires an "ethernet-ports" child of that same
parent, otherwise probe fails with -EINVAL "missing ethernet-ports":

  ports_dn = of_get_child_by_name(parent->of_node, "ethernet-ports");

The only schema describing such a container (syscon + simple-mfd with
ethernet-ports and an mdio-controller child) is
Documentation/devicetree/bindings/net/realtek,rtl9301-switch.yaml, and its
compatible enum lists only realtek,rtl9301/9302b/9302c/9303-switch, also at
the end of this series. A grep of Documentation/devicetree/bindings finds no
rtl838x/rtl8380 switch compatible.

That leaves a DT author either inventing an undocumented parent compatible
(caught by dtbs_check) or claiming realtek,rtl9301-switch on RTL838x
hardware, whose register window this patch treats as different (0xa1xx
versus 0xcaxx). Should a parent binding for the RTL838x switch/syscon node
be added alongside this?

[Severity: Low]
This isn't a bug, but with RTL838x now matched, the Kconfig prompt and help
text in drivers/net/mdio/Kconfig still say:

  tristate "Realtek RTL9300 MDIO interface support"
  ...
    This driver supports the MDIO interface found in the Realtek
    RTL9300 family of Ethernet switches with integrated SoC.

and MODULE_DESCRIPTION() in this file still says "RTL9300 MDIO driver". The
later patch in this series, "net: mdio: realtek-rtl9300: reword Kconfig and
module description", changes both to RTL83xx/RTL93xx, so this is only a
transient state within the series. Would folding the wording change in
earlier keep each commit self-consistent?

>  	{ .compatible = "realtek,rtl9301-mdio", .data = &otto_emdio_9300_info },
>  	{ .compatible = "realtek,rtl9311-mdio", .data = &otto_emdio_9310_info },
>  	{}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831143439.2404484-1-markus.stockhausen%40gmx.de
