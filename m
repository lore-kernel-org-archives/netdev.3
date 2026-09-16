Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F3B4C4F62;
	Wed, 16 Sep 2026 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789553175; cv=none; b=akvT5xMvfEv7ox03ySBvqWe+jMVDiF5vJS9mo4NFQhJZEK3ZCnxSJnSbdUMT7cifMasGUSuxXyhxauQmls86XeMr7yyK4K6ZvQVRGWUmkKzhA7V2SnKr+XntdwhLO4GLXxJY6Nl/ca2+f1t+K7IpKQuOf6hUEcjl4+0PpY3quPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789553175; c=relaxed/simple;
	bh=dclSxSdDweKv6BAmc2l8xrCOEWeFmd/7HT54yO9Pi0Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hZUIWvXS5y1QiYRoDyt3yrfl1o0TiThw+FMHmcuCD/AkCvO7OBCwsOpQy/RKvAsGQawPcXEp9N7yvTKlu+JQzH6vnVjpEa+4EbXSgVHz0GRCX67MduDn3oC+WWCejO5AfHHlFmVg4adgWUBivNIRvHDur29bUlkYMMkpf8uE9Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol8VMfTS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol8VMfTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E83B1F00893;
	Wed, 16 Sep 2026 10:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789553157;
	bh=ax5M6Wer/qm81IgtsgsDxpffOklyuZc6CeQ6RrzuPQ4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ol8VMfTSWHsFNtVLQKXt0dZLV8XaJtGZi4u/DEjEs+Z1G/Tx8x15VztLBQMllyv8+
	 OmVr78UiXRV5HzO05yw7mUkBBRsZqx6NHVarXWHNC3f/91jHNUI2iImekW9t5UP0qw
	 0+6WtBWUWBuM2KjfXsPjQA2FfI76GB3ywMlp+TlPwVQZiZLD+59ags33VaIz70rJ0g
	 YZkIoN5CYyKe759UeYSTznPCU/nQplozLME4xs+WSCg2A7bc8oFZBsPaOeYBi/bRiB
	 /8TTFNz+E3r93eYpQGhSfzts87VNpo6ISSCHGxImEPydOsqCpAOl7YG7lI2jtWFlq5
	 wSjW4kbnYwwpQ==
Subject: Re: [PATCH net-next v3] net: dsa: mxl-gsw1xx: force internal PHYs
 into a known reset state
From: netdev-bot+sashiko@kernel.org
To: alexander.sverdlin@siemens.com
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, hauke@hauke-m.de,
 andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 10:05:56 +0000
Message-ID: <178955315667.22033.9168932540899690770@kernel.org>
In-Reply-To: <20260915091856.1375914-1-alexander.sverdlin@siemens.com>
References: <20260915091856.1375914-1-alexander.sverdlin@siemens.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 3

- [High] gsw1xx_setup() (drivers/net/dsa/lantiq/mxl-gsw1xx.c:593-637)
  builds the RST_REQ PHY mask exclusively inside…
- [Medium] gsw1xx_setup() decides that an internal PHY is "really used"
  solely by of_parse_phandle(dp->dn, "phy-handle", 0)…
- [Low] The commit message states "The delay is skipped when no PHY is
  released from reset", but the implemented condition is `if…
- [Low] The submission carries no `Fixes:` trailer.
- [Low] gsw1xx_setup() takes ownership of the internal PHY reset/power
  lines (drivers/net/dsa/lantiq/mxl-gsw1xx.c:628-634) but nothing ever…

--

net: dsa: mxl-gsw1xx: force internal PHYs into a known reset state

This adds a per-variant .setup hook to struct gswip_hw_info, called from
gswip_setup() after MDIO auto-polling is disabled and before the MDIO bus
is registered.  The GSW1xx implementation programs the internal PHY reset
lines in GSW1XX_SHELL_RST_REQ, releasing the PHYs of ports with a
phy-handle and holding the rest in reset, followed by a 300ms delay.

[Severity: Low]
There is no Fixes: tag on this submission.  The behaviour being enabled
(internal PHYs discoverable when the switch is strapped PS_NOWAIT = 0) has
never worked since the driver was added in commit 22335939ec90 ("net: dsa:
add driver for MaxLinear GSW1xx switch family"), which registered the MDIO
bus without ever programming the GSW1XX_SHELL_RST_REQ PHY bits; the
pre-patch driver only touched GSW1XX_RST_REQ_SGMII_SHELL.

Would a Fixes: tag pointing at 22335939ec90 be appropriate here, or is the
change intended as net-next material only?  The patch also changes
behaviour of already working configurations (unused PHYs are now asserted
into reset, and a 300ms delay is added), which argues against a stable
backport, so it would help to state the intent explicitly.

> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> index 6150dc3ffb641..7c53ded178367 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> @@ -689,6 +689,16 @@ static int gswip_setup(struct dsa_switch *ds)
>  	 */
>  	regmap_write(priv->mdio, GSWIP_MDIO_MDC_CFG0, 0x0);
>  
> +	/* GSW1xx will wake up the PHYs here, so it makes sense that it happens
> +	 * after the auto-polling deactivation above, but before the MDIO bus
> +	 * registration below
> +	 */
> +	if (priv->hw_info->setup) {
> +		err = priv->hw_info->setup(ds);
> +		if (err)
> +			return err;
> +	}
> +

[Severity: Low]
Is anything expected to put the released PHYs back into reset?

Once gsw1xx_setup() has deasserted the PHY reset bits, no other code path
writes GSW1XX_SHELL_RST_REQ again.  gswip_teardown() only clears the
global enable:

drivers/net/dsa/lantiq/lantiq_gswip_common.c:gswip_teardown() {
	struct gswip_priv *priv = ds->priv;

	regmap_clear_bits(priv->mdio, GSWIP_MDIO_GLOB, GSWIP_MDIO_GLOB_ENABLE);
}

There is no per-variant .teardown counterpart to the new .setup hook, and
gsw1xx_remove()/gsw1xx_shutdown() only unregister the switch and cancel the
delayed work, so after unbind or shutdown the internal PHYs stay powered
and out of reset.

The same applies to the failure paths that follow this hook inside
gswip_setup(), for example:

	err = gswip_mdio(priv);
	if (err) {
		dev_err(priv->dev, "mdio bus setup failed\n");
		return err;
	}

and the later gswip_switch_r_timeout() "MAC flushing didn't finish" return.
Both leave the PHYs released, which is the indeterminate powered state the
commit message says it wants to eliminate.  For comparison, the SGMII shell
reset is asserted and deasserted symmetrically in gsw1xx_pcs_disable() and
gsw1xx_serdes_pcs_init().

>  	/* Configure the MDIO Clock 2.5 MHz */
>  	regmap_write_bits(priv->mdio, GSWIP_MDIO_MDC_CFG1, 0xff, 0x09);
>  
> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> index 66bf7e3319057..08c633b2caebf 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> @@ -589,6 +590,52 @@ static void gsw150_phylink_get_caps(struct dsa_switch *ds, int port,
>  	gsw1xx_phylink_get_lpi_caps(config);
>  }
>  
> +static int gsw1xx_setup(struct dsa_switch *ds)
> +{
> +	struct gsw1xx_priv *priv = container_of(ds->priv, struct gsw1xx_priv, gswip);
> +	struct gswip_priv *gswip_priv = ds->priv;
> +	u32 phy_mask = 0, active_mask = 0;
> +	struct device_node *phy_np;
> +	struct dsa_port *dp;
> +	int ret;
> +
> +	dsa_switch_for_each_user_port(dp, ds) {
> +		struct phylink_config cfg = {};
> +
> +		/* Is there an internal PHY on this port? */
> +		gswip_priv->hw_info->phylink_get_caps(ds, dp->index, &cfg);
> +		if (!test_bit(PHY_INTERFACE_MODE_INTERNAL, cfg.supported_interfaces))
> +			continue;
> +
> +		phy_mask |= GSW1XX_RST_REQ_PHY(dp->index);

[Severity: High]
Can phy_mask miss internal PHYs on ports that are not DSA user ports?

dsa_switch_for_each_user_port() filters on dsa_port_is_user():

include/net/dsa.h:
#define dsa_switch_for_each_user_port(_dp, _ds) \
	dsa_switch_for_each_port((_dp), (_ds)) \
		if (dsa_port_is_user((_dp)))

But a dsa_port exists for every index up to ds->num_ports, whether or not
the device tree describes it:

net/dsa/dsa.c:dsa_switch_touch_ports() {
	for (port = 0; port < ds->num_ports; port++) {
		dp = dsa_port_touch(ds, port);
	...
}

Ports absent from (or disabled in) the DT stay DSA_PORT_TYPE_UNUSED and are
skipped by the loop above, so their reset bits never enter phy_mask.  Since
regmap_update_bits() only modifies bits inside the mask, those PHYs retain
their bootstrap value: released and powered with PS_NOWAIT = 1, held in
reset with PS_NOWAIT = 0.

gsw12x/gsw140/gsw141 declare built-in PHYs on ports 0..3 in
gsw1xx_phylink_get_caps(), and gsw150 on ports 0..4 in
gsw150_phylink_get_caps().  A board describing only ports 0 and 1, which is
the style of the in-tree GSW125 example in
Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml, would leave
PHYs 2 and 3 outside the mask.

Should the mask be derived from the variant's set of internal PHYs rather
than from DSA user-port classification?

> +
> +		/* Will the PHY be really used? */
> +		phy_np = of_parse_phandle(dp->dn, "phy-handle", 0);
> +		if (!phy_np)
> +			continue;

[Severity: Medium]
Is "phy-handle" the only property that should count as a PHY reference
here?

The PHY core accepts two legacy names as well:

drivers/net/phy/phy_device.c:fwnode_get_phy_node() {
	phy_node = fwnode_find_reference(fwnode, "phy-handle", 0);
	...
	phy_node = fwnode_find_reference(fwnode, "phy", 0);
	...
	return fwnode_find_reference(fwnode, "phy-device", 0);
}

and phylink_fwnode_phy_connect() uses that helper.  A port described with
phy = <&switchphyX> or phy-device = <&switchphyX> is therefore a valid PHY
reference that this loop classifies as unused, so its reset bit gets
asserted below.

Because the new hook runs before gswip_mdio(), the PHY is in reset when
of_mdiobus_register() reads its ID registers, no phy_device is created, and
phylink_fwnode_phy_connect() later returns -ENODEV:

net/dsa/user.c:dsa_user_phy_setup() {
	ret = phylink_of_phy_connect(dp->pl, port_dn, phy_flags);
	if (ret == -ENODEV && ds->user_mii_bus) {
	...
}

The ds->user_mii_bus fallback does not apply, since gswip_mdio() registers
a standalone mii_bus and never sets ds->user_mii_bus, so switch
registration would fail on hardware that worked before with PS_NOWAIT = 1.

A related case is fixed-link: phylink_fwnode_phy_connect() returns 0 early
when !phylink_expects_phy(pl), and such a port legitimately has no
phy-handle while its internal PHY still needs power.  Would that port end
up with its PHY held in reset while phylink reports the link up?

> +
> +		of_node_put(phy_np);
> +		active_mask |= GSW1XX_RST_REQ_PHY(dp->index);
> +	}
> +
> +	if (!phy_mask)
> +		return 0;
> +
> +	/* Deassert resets for PHYs referenced by active ports and hold the
> +	 * unused ones in reset, so the state is identical regardless of the
> +	 * PS_NOWAIT bootstrap.
> +	 */
> +	ret = regmap_update_bits(priv->shell, GSW1XX_SHELL_RST_REQ, phy_mask,
> +				 phy_mask & ~active_mask);
> +	if (ret)
> +		return ret;
> +
> +	if (active_mask)
> +		msleep(300);

[Severity: Low]
The commit message says:

  "The delay is skipped when no PHY is released from reset."

The implemented condition is "at least one internal-PHY port has a
phy-handle", not "a reset was actually deasserted".  On boards
bootstrapped with PS_NOWAIT = 1 the PHY bits are already zero, so
regmap_update_bits() changes nothing, yet the 300ms sleep is still taken on
every probe.

If the intent is to sleep only when a reset was really deasserted, would
regmap_update_bits_check() and a test on the change flag match the
description better?  Otherwise, could the commit message be reworded to say
the delay is taken whenever an internal PHY is in use?

> +
> +	return 0;
> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915091856.1375914-1-alexander.sverdlin%40siemens.com
