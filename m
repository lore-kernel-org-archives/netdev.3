Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38F39446D;
	Mon, 12 Oct 2026 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791774124; cv=none; b=Q0eZS70/QV6UWEk1ES6AVOXFNjWqC9ZH7c7qThuwfqENpvdqZa28Tu5ud/9UXidFw8mQg22cnhtaFDxeLWeHJDkkYj9DOHihit6JrbfLDe59LQ8P2L5j/cHHcekCVuiQCHtOLtroO19IXj+TbLmN15BwrNyOLKzXWKrbKQh1sn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791774124; c=relaxed/simple;
	bh=HRuy9DVi2EhF+rOi0MZsVVoXJ2hkX0cyeeM45fXq2zY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HFu5XcHU9kzQzcXmrbymLYmcnm2TDcZHd79cJf/HvFm1HNBn/7rD3pnX2GXCpKWXyXapKtQW+s1sC3HCxi6zzJWNK0dWKIjBU2zLXMdbMf9HtEe25ZP19uXOwKg2F0QhQ1FjNQvr/iUU6AMrLxErtcoFVPGhaFHUM4p/Ws8sPag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZRdXsoC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZRdXsoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CE31F0089C;
	Mon, 12 Oct 2026 03:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791774117;
	bh=BFuRq+E5yoydXqM7norUga+9+JKACLKQCXsQK3TKbh4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WZRdXsoCRozN0vavy5DY2aJg7rQZKQfAhkVBq+6M75x93Km/2F4dmJGWmYEDVNgCO
	 HvBz2Bi8RIIdQ3pWIlEW2wmsyucP5dQLRxKNA8wEJs6SF8UyZ0k2DqDdQDMjzinRBp
	 NbwmNqxAFqNzERn2Tvq7/PIgmn26vvAojdvS0KiUyvjA0JcKcJmbDGb2LXt8NJAyqq
	 x7iESnV0fvZbhozLlTDxqBkTzD1lhFFm/21E47B/adfZFeGTP+wTPpklgxlJTOVLAy
	 kdxgX/mbAT4VL2MKKIhQ7ioh0kAn8n8h53ug6dRP++R/PI7t1OKqjDFX3wvNHCk1r4
	 z4nvUSeCt3Xow==
Subject: Re: [PATCH net-next v13 5/5] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Mon, 12 Oct 2026 03:01:56 +0000
Message-ID: <179177411619.434549.14167854594243598989@kernel.org>
In-Reply-To: <20261011025043.1859940-6-kyle.switch@motor-comm.com>
References: <20261011025043.1859940-6-kyle.switch@motor-comm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds a "YT9228" entry to yt921x_infos.
- [Medium] yt921x_of_match gains the compatible "motorcomm,yt9224", but
  no DT binding documents it.
- [Medium] yt922x_pcs_config() ignores neg_mode, advertising and
  permit_pause_to_mac.
- [Medium] net: dsa: motorcomm: undefined behavior in __ffs() for
  cascaded topologies without local CPU port
- [Low] The YT922x row in yt92xx_series_table sets
  .assisted_learning_on_cpu_port = true, .num_lag_ids = YT922X_LAG_NUM,…
- [Low] yt921x_intif_ext_write()/yt921x_intif_ext_read() check `if (port
  > priv->series->max_ports)`, while the existing internal-bus accessors…
- [Low] yt922x_port_up() builds ctrl from 0 and writes all of
  YT922X_PORTn_CTRL with yt921x_reg_write(), with YT922X_PORT_FORCE_OP…
- [Low] yt922x_pcs_config() writes the magic extended register 0x4be =
  0xd under the bare comment '/* write protect */', with no symbolic…

--

net: dsa: motorcomm: Add support for Motorcomm YT922x

This commit adds basic DSA support for the Motorcomm YT9224 switch to the
existing yt921x driver. It adds a YT922x series table entry, phylink MAC
ops, a new PCS implementation in pcs-922x.c and a "motorcomm,yt9224"
compatible. It also adds a YT9228 info entry, even though the commit
message says YT9228 is not supported yet.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index ba988e121d68e..2c5a525fc5c31 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -76,6 +76,18 @@ static const struct yt921x_info yt921x_infos[] = {
>  		BIT(8) | BIT(9),
>  		BIT(8) | BIT(9),
>  	},
> +	{
> +		"YT9224", YT9224_MAJOR, 0, 0,
> +		GENMASK_U16(7, 4),
> +		0,
> +		BIT(8) | BIT(0),
> +	},
> +	{
> +		"YT9228", YT9224_MAJOR, 0, 0,
> +		GENMASK_U16(7, 4),
> +		0,
> +		BIT(8) | GENMASK_U16(3, 0),
> +	},
>  	{}
>  };
>  
> @@ -3606,6 +3618,11 @@ static void yt921x_dsa_teardown(struct dsa_switch *ds)
>  #endif
>  }
>  
> +static bool yt921x_needs_extmode_check(u32 major)
> +{
> +	return (major == YT9224_MAJOR) ? false : true;
> +}
> +
>  static int yt921x_chip_detect(struct yt921x_priv *priv)
>  {
>  	struct device *dev = yt921x_priv_to_device(priv);
> @@ -3631,6 +3648,9 @@ static int yt921x_chip_detect(struct yt921x_priv *priv)
>  		return -ENODEV;
>  	}
>  
> +	if (!yt921x_needs_extmode_check(major))
> +		goto skip_extmode_check;
> +

[Severity: Medium]
The YT9224 and YT9228 entries use the same (YT9224_MAJOR, 0, 0) key. Can
the YT9228 entry ever be selected?

yt921x_chip_detect() stops at the first entry with a matching major:

	for (info = yt921x_infos; info->name; info++)
		if (info->major == major)
			break;

For YT9224_MAJOR, the new goto then skips the only loop that narrows the
match by mode and extmode. Even without the goto, the two rows have the
same mode and extmode, so that loop could not tell them apart.

The commit message says "YT9228 is not supported yet". Any part reporting
major 0x9004 is still accepted, logged as "YT9224", and given serdes_mask
BIT(8) | BIT(0).

On a YT9228, would ports 1-3 then get no PCS ops and no SerDes interface
modes from yt922x_pcs_setup() and yt922x_dsa_phylink_get_caps()? Should
probe fail with -ENODEV instead?

[ ... ]

> @@ -4078,6 +4106,405 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
>  	.setup			= yt921x_dsa_setup,
>  };
>  
> +static int yt922x_port_down(struct yt921x_priv *priv, int port)
> +{
> +	u32 mask;
> +	int res;
> +
> +	/* mac force down */
> +	mask = YT922X_PORT_LINK | YT922X_PORT_RX_MAC_EN |
> +	YT922X_PORT_TX_MAC_EN | YT922X_PORT_LINK_AN;
> +	res = yt921x_reg_clear_bits(priv, YT922X_PORTn_CTRL(port), mask);

[ ... ]

> +static int
> +yt922x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
> +	       phy_interface_t interface, int speed, int duplex,
> +	       bool tx_pause, bool rx_pause)
> +{
> +	int ps = ethtool_speed_to_yt921x(speed);
> +	u32 ctrl = 0;

[ ... ]

> +	ctrl |= YT922X_PORT_RX_MAC_EN | YT922X_PORT_TX_MAC_EN |
> +			YT922X_PORT_CFG_TX_EN | YT922X_PORT_LINK |
> +			YT922X_PORT_CFG_RX_EN;
> +	ctrl &= ~(YT922X_PORT_FC_AN | YT922X_PORT_LINK_AN);
> +	res = yt921x_reg_write(priv, YT922X_PORTn_CTRL(port), ctrl);
> +	if (res)
> +		return res;
> +
> +	/* force op */
> +	mask = YT922X_PORT_FORCE_OP;
> +	res = yt921x_reg_set_bits(priv, YT922X_PORTn_CTRL(port), mask);

[Severity: Low]
yt922x_port_up() writes the whole YT922X_PORTn_CTRL register with
YT922X_PORT_FORCE_OP clear, then sets FORCE_OP in a second read-modify-write.
Does this take the port out of forced mode for a moment on every link up?

The full write also zeroes bits the driver does not model, such as
YT922X_PORT_HALF_PAUSE and everything above bit 14. yt921x_port_up() uses
an update with an explicit mask instead.

yt922x_port_down() clears LINK, RX/TX_MAC_EN and LINK_AN, but leaves
YT922X_PORT_CFG_TX_EN and YT922X_PORT_CFG_RX_EN set. Is it intended that
the up and down paths are not symmetric?

[ ... ]

> +static const struct dsa_switch_ops yt922x_dsa_switch_ops = {
> +	/* port */
> +	.get_tag_protocol = yt922x_dsa_get_tag_protocol,
> +	.phylink_get_caps = yt922x_dsa_phylink_get_caps,
> +	.port_setup  = yt922x_dsa_port_setup,
> +	/* chip */
> +	.setup   = yt922x_dsa_setup,
> +};
> +
>  static const struct yt92xx_series yt92xx_series_table[] = {
>  	[YT92XX_MODE_YT921X] = {
>  		.name = "YT921x",
> @@ -4090,12 +4517,25 @@ static const struct yt92xx_series yt92xx_series_table[] = {
>  		.switch_ops = &yt921x_dsa_switch_ops,
>  		.mac_ops = &yt921x_phylink_mac_ops
>  	},
> +	[YT92XX_MODE_YT922X] = {
> +		.name = "YT922x",
> +		.max_ports = YT922X_PORT_NUM,
> +		.num_lag_ids = YT922X_LAG_NUM,
> +		.ageing_time_min = 1 * 6000,
> +		.ageing_time_max = U16_MAX * 6000,
> +		.dscp_prio_mapping_is_global = true,
> +		.assisted_learning_on_cpu_port = true,
> +		.switch_ops = &yt922x_dsa_switch_ops,
> +		.mac_ops = &yt922x_phylink_mac_ops,
> +	},
>  };

[Severity: Low]
This row sets num_lag_ids, ageing_time_min/max,
dscp_prio_mapping_is_global and assisted_learning_on_cpu_port.
yt92xx_register_switch() copies all of them into struct dsa_switch.

yt922x_dsa_switch_ops has none of the callbacks these fields depend on:
port_fdb_add/del, port_lag_join/leave, set_ageing_time, port_*_dscp_prio
or port_bridge_join. The DSA core checks for each callback before using
these fields, so there is no runtime effect today.

Should these fields stay unset until the matching callbacks are added?

[ ... ]

> @@ -4220,6 +4658,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
>  
>  static const struct of_device_id yt921x_of_match[] = {
>  	{ .compatible = "motorcomm,yt9215" },
> +	{ .compatible = "motorcomm,yt9224" },
>  	{}
>  };

[Severity: Medium]
Is there a binding update for this new compatible?
Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml still
only allows:

  compatible:
    const: motorcomm,yt9215

Wouldn't a DTS using "motorcomm,yt9224" fail dtbs_check?

The binding description also does not match the YT9224 layout programmed
here. It says "up to 8 internal GbE PHYs and up to 2 GMACs" and "PHY 0-7
are used for Port 0-7". This patch programs internal PHYs on ports 4-7,
SerDes on ports 0 and 8, and 9 ports in total.

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/mdio_bus.c b/drivers/net/dsa/motorcomm/mdio_bus.c
> index 3aa1111efaa46..a4cb74d0fd90b 100644
> --- a/drivers/net/dsa/motorcomm/mdio_bus.c
> +++ b/drivers/net/dsa/motorcomm/mdio_bus.c
> @@ -299,3 +299,42 @@ int yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
>  
>  	return 0;
>  }
> +
> +/* intif extend register read/write api */
> +int
> +yt921x_intif_ext_write(struct yt921x_priv *priv, int port, int reg, u16 val)
> +{
> +	int res;
> +
> +	if (port > priv->series->max_ports)
> +		return -ENODEV;

[Severity: Low]
yt921x_mbus_int_read() and yt921x_mbus_int_write() use:

	if (port >= priv->series->max_ports)

yt921x_intif_ext_write() and yt921x_intif_ext_read() use > instead, so
address == max_ports (9 on YT922x) gets through.

YT922X_COMMON_EXT_PHYADDR is defined as 9, so the looser bound may be
deliberate. If it is, could the parameter be renamed from port to addr,
and the bound get a comment?

The only current caller, yt922x_pcs_config(), passes 0 or 8.

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/pcs-922x.c b/drivers/net/dsa/motorcomm/pcs-922x.c
> new file mode 100644
> index 0000000000000..98d403d01ba3c
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/pcs-922x.c

[ ... ]

> +static int yt922x_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> +			     phy_interface_t interface,
> +			     const unsigned long *advertising,
> +			     bool permit_pause_to_mac)
> +{

[Severity: Medium]
yt922x_pcs_config() never uses neg_mode, advertising or
permit_pause_to_mac. It only writes ext reg 0x4be and the SERDES_MODE
field of YT922X_PORT_SDSn, and returns 0 on success.

BMCR_ANENABLE and MII_ADVERTISE are never programmed. Does in-band AN then
follow the hardware reset default instead of what phylink asked for?

For example, take a 2500BASE-X or SGMII link in outband or fixed-link mode
toward a CPU MAC that does not do AN. Could that link fail to come up if
the PCS has AN enabled by default?

Advertisement changes from ethtool would also report success without
changing anything. Meanwhile yt922x_pcs_get_state() decodes BMSR/LPA as if
in-band AN were set up.

yt921x_serdes_config() in pcs-921x.c programs the advertisement through
phylink_mii_c22_pcs_encode_advertisement() and sets BMCR_ANENABLE from
neg_mode. yt921x_phylink_pcs_ops also provides pcs_inband_caps, pcs_enable
and pcs_disable. Should yt922x_phylink_pcs_ops do the same?

> +	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
> +	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
> +	int res, port;
> +	u16 data;
> +	u16 ctrl;
> +	int addr;
> +
> +	port = pp->index;
> +	mutex_lock(&priv->reg_lock);
> +	addr = yt922x_sds_phyaddr_get
> +		(port, YT922X_PHY_REG_TYPE_SDS_COMMON_EXT);
> +	if (addr < 0) {
> +		res = addr;
> +		goto err;
> +	}
> +	/* write protect */
> +	res = yt921x_intif_ext_write(priv, addr, 0x4be, 0xd);

[Severity: Low]
What does writing 0xd to extended register 0x4be do? The comment says
"write protect".

If this write turns protection on rather than off, could the following
YT922X_PORT_SDSn mode write be silently ignored by the hardware?
yt921x_intif_ext_write() only reports transport errors, so the driver
would not notice.

The previous state is also never restored before returning. Could this
value get a named define and a comment saying what it means? Does it need
to be undone after the mode update?

> +	if (res)
> +		goto err;

[ ... ]

> @@ -4078,6 +4106,405 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
>  	.setup			= yt921x_dsa_setup,
>  };
>  
> +static int yt922x_port_down(struct yt921x_priv *priv, int port)
> +{
> +	u32 mask;
> +	int res;
> +
> +	/* mac force down */
> +	mask = YT922X_PORT_LINK | YT922X_PORT_RX_MAC_EN |
> +	YT922X_PORT_TX_MAC_EN | YT922X_PORT_LINK_AN;
> +	res = yt921x_reg_clear_bits(priv, YT922X_PORTn_CTRL(port), mask);
> +	if (res)
> +		return res;
> +	/* Need force op to make soft configuration effective */
> +	mask = YT922X_PORT_FORCE_OP;
> +	res = yt921x_reg_set_bits(priv, YT922X_PORTn_CTRL(port), mask);
> +	if (res)
> +		return res;
> +
> +	/* disable en_phy */
> +	res = yt921x_reg_clear_bits(priv, YT922X_EN_PHY_VALUE, BIT(port));
> +	if (res)
> +		return res;
> +	res = yt921x_reg_set_bits(priv, YT922X_EN_PHY_OVERWRITE, BIT(port));
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}
> +
> +static void
> +yt922x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
> +			     phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct yt921x_priv *priv = dsa_to_yt921x_priv(dp->ds);
> +	int port = dp->index;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt922x_port_down(priv, port);
> +	mutex_unlock(&priv->reg_lock);
> +
> +	if (res)
> +		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring down",
> +			port, res);
> +}
> +
> +static int
> +yt922x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
> +	       phy_interface_t interface, int speed, int duplex,
> +	       bool tx_pause, bool rx_pause)
> +{
> +	int ps = ethtool_speed_to_yt921x(speed);
> +	u32 ctrl = 0;
> +	u32 mask;
> +	int res;
> +
> +	if (ps == YT921X_SPEED_INVALID)
> +		return -EINVAL;
> +	ctrl |= ps;
> +
> +	if (duplex == DUPLEX_FULL)
> +		ctrl |= YT922X_PORT_DUPLEX_FULL;
> +	if (tx_pause)
> +		ctrl |= YT922X_PORT_TX_PAUSE;
> +	if (rx_pause)
> +		ctrl |= YT922X_PORT_RX_PAUSE;
> +	ctrl |= YT922X_PORT_RX_MAC_EN | YT922X_PORT_TX_MAC_EN |
> +			YT922X_PORT_CFG_TX_EN | YT922X_PORT_LINK |
> +			YT922X_PORT_CFG_RX_EN;
> +	ctrl &= ~(YT922X_PORT_FC_AN | YT922X_PORT_LINK_AN);
> +	res = yt921x_reg_write(priv, YT922X_PORTn_CTRL(port), ctrl);
> +	if (res)
> +		return res;
> +
> +	/* force op */
> +	mask = YT922X_PORT_FORCE_OP;
> +	res = yt921x_reg_set_bits(priv, YT922X_PORTn_CTRL(port), mask);
> +	if (res)
> +		return res;
> +
> +	/* enable en_phy */
> +	res = yt921x_reg_set_bits(priv, YT922X_EN_PHY_VALUE, BIT(port));
> +	if (res)
> +		return res;
> +	res = yt921x_reg_set_bits(priv, YT922X_EN_PHY_OVERWRITE, BIT(port));
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}
> +
> +static void
> +yt922x_phylink_mac_link_up(struct phylink_config *config,
> +			   struct phy_device *phydev, unsigned int mode,
> +			   phy_interface_t interface, int speed, int duplex,
> +			   bool tx_pause, bool rx_pause)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct yt921x_priv *priv = dsa_to_yt921x_priv(dp->ds);
> +	int port = dp->index;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt922x_port_up(priv, port, mode, interface, speed, duplex,
> +			     tx_pause, rx_pause);
> +	mutex_unlock(&priv->reg_lock);
> +
> +	if (res)
> +		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring up",
> +			port, res);
> +}
> +
> +static void
> +yt922x_phylink_mac_config(struct phylink_config *config, unsigned int mode,
> +			  const struct phylink_link_state *state)
> +{
> +}
> +
> +static struct phylink_pcs *
> +yt922x_phylink_mac_select_pcs(struct phylink_config *config,
> +			      phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct yt921x_priv *priv = dsa_to_yt921x_priv(dp->ds);
> +
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +	case PHY_INTERFACE_MODE_USXGMII:
> +		return &priv->ports[dp->index].pcs;
> +
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +static const struct phylink_mac_ops yt922x_phylink_mac_ops = {
> +	.mac_select_pcs = yt922x_phylink_mac_select_pcs,
> +	.mac_link_down = yt922x_phylink_mac_link_down,
> +	.mac_link_up = yt922x_phylink_mac_link_up,
> +	.mac_config = yt922x_phylink_mac_config,
> +};
> +
> +static enum dsa_tag_protocol
> +yt922x_dsa_get_tag_protocol(struct dsa_switch *ds, int port,
> +			    enum dsa_tag_protocol m)
> +{
> +	return DSA_TAG_PROTO_YT922X;
> +}
> +
> +static void
> +yt922x_dsa_phylink_get_caps(struct dsa_switch *ds, int port,
> +			    struct phylink_config *config)
> +{
> +	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
> +	const struct yt921x_info *info = priv->info;
> +
> +	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +				   MAC_10 | MAC_100 | MAC_1000;
> +
> +	if (info->internal_mask & BIT(port)) {
> +		/* port 4 to port 7, internal utp */
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  config->supported_interfaces);
> +		config->mac_capabilities |= MAC_2500FD;
> +	}
> +	if (info->serdes_mask & BIT(port)) {
> +		/* serdes */
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +			  config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  config->supported_interfaces);
> +		config->mac_capabilities |= MAC_2500FD;
> +		__set_bit(PHY_INTERFACE_MODE_USXGMII,
> +			  config->supported_interfaces);
> +		config->mac_capabilities |= MAC_5000FD;
> +		config->mac_capabilities |= MAC_10000FD;
> +	}
> +}
> +
> +static int yt922x_port_setup(struct yt921x_priv *priv, int port)
> +{
> +	struct dsa_switch *ds = &priv->ds;
> +	u32 mask;
> +	u32 ctrl;
> +	int res;
> +
> +	/* enable user port isolation and disable fdb learning */
> +	ctrl = ~priv->cpu_ports_mask;
> +	res = yt921x_reg_write(priv, YT922X_PORTn_ISOLATION(port), ctrl);
> +	if (res)
> +		return res;
> +
> +	mask = YT922X_PORT_LEARN_DIS;
> +	res = yt921x_reg_set_bits(priv, YT922X_PORTn_LEARN(port), mask);
> +	if (res)
> +		return res;
> +
> +	if (dsa_is_cpu_port(ds, port)) {
> +		ctrl = ~(u32)0;
> +		res = yt921x_reg_write(priv, YT922X_PORTn_ISOLATION(port),
> +				       ctrl);
> +		if (res)
> +			return res;
> +	}
> +
> +	return 0;
> +}
> +
> +static int yt922x_dsa_port_setup(struct dsa_switch *ds, int port)
> +{
> +	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt922x_port_setup(priv, port);
> +	mutex_unlock(&priv->reg_lock);
> +
> +	return res;
> +}
> +
> +static int yt922x_cpu_tag_mode_set_8b(struct yt921x_priv *priv)
> +{
> +	u32 val;
> +	u32 val1;
> +	int res;
> +
> +	/* cpu tag mode set to 8b */
> +	res = yt921x_reg_read(priv, YT922X_CPU_TAG_RX_CTRL, &val);
> +	if (res)
> +		return res;
> +	res = yt921x_reg_read(priv, YT922X_CPU_TAG_TX_CTRL, &val1);
> +	if (res)
> +		return res;
> +	val &= ~YT922X_CPU_TAG_RX_MODE;
> +	val1 &= ~YT922X_CPU_TAG_TX_MODE;
> +	val1 &= ~YT922X_CPU_TAG_TX_TYPE;
> +	res = yt921x_reg_write(priv, YT922X_CPU_TAG_RX_CTRL, val);
> +	if (res)
> +		return res;
> +	res = yt921x_reg_write(priv, YT922X_CPU_TAG_TX_CTRL, val1);
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}
> +
> +static int yt922x_cpu_port_set(struct yt921x_priv *priv)
> +{
> +	struct dsa_switch *ds = &priv->ds;
> +	u32 ctrl;
> +	int res;
> +
> +	/* cpu tag mode */
> +	res = yt922x_cpu_tag_mode_set_8b(priv);
> +	if (res)
> +		return res;
> +
> +	/* Enable DSA */
> +	priv->cpu_ports_mask = dsa_cpu_ports(ds);
> +	ctrl = YT921X_EXT_CPU_PORT_TAG_EN | YT921X_EXT_CPU_PORT_PORT_EN |
> +	       YT921X_EXT_CPU_PORT_PORT(__ffs(priv->cpu_ports_mask));
> +	res = yt921x_reg_write(priv, YT921X_EXT_CPU_PORT, ctrl);
> +	if (res)
> +		return res;
> +
> +	/* Setup software switch */
> +	ctrl = YT922X_CPU_COPY_TO_EXT_CPU;
> +	res = yt921x_reg_write(priv, YT922X_CPU_COPY, ctrl);
> +	if (res)
> +		return res;
> +
> +	return res;
> +}
> +
> +static int yt922x_chip_setup_dsa(struct yt921x_priv *priv)
> +{
> +	unsigned long cpu_ports_mask;
> +	u32 ctrl;
> +	int port;
> +	int res;
> +
> +	/* cpu port set */
> +	res = yt922x_cpu_port_set(priv);
> +	if (res)
> +		return res;
> +
> +	ctrl = GENMASK_U32(8, 0);
> +	res = yt921x_reg_write(priv, YT922X_FILTER_UNK_UCAST, ctrl);
> +	if (res)
> +		return res;
> +
> +	ctrl = 0;
> +	for (int i = 0; i < priv->series->max_ports; i++)
> +		ctrl |= YT922X_ACT_UNK_ACTn_TRAP(i);
> +	cpu_ports_mask = priv->cpu_ports_mask;
> +	for_each_set_bit(port, &cpu_ports_mask, priv->series->max_ports) {
> +		ctrl &= ~YT922X_ACT_UNK_ACTn_M(port);
> +		ctrl |= YT922X_ACT_UNK_ACTn_DROP(port);
> +	}
> +	res = yt921x_reg_write(priv, YT922X_ACT_UNK_UCAST, ctrl);
> +	if (res)
> +		return res;
> +	res = yt921x_reg_write(priv, YT922X_ACT_UNK_MCAST, ctrl);
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}
> +
> +static int yt922x_chip_setup(struct yt921x_priv *priv)
> +{
> +	u32 ctrl;
> +	int res;
> +
> +	ctrl = YT922X_FUNC_MIB | YT922X_FUNC_ACL;
> +	res = yt921x_reg_set_bits(priv, YT921X_FUNC, ctrl);
> +	if (res)
> +		return res;
> +
> +	res = yt922x_chip_setup_dsa(priv);
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}
> +
> +static void yt922x_pcs_setup(struct dsa_switch *ds)
> +{
> +	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
> +	const struct yt921x_info *info = priv->info;
> +	unsigned long mask;
> +	int port;
> +
> +	mask = info->serdes_mask;
> +	for_each_set_bit(port, &mask, priv->series->max_ports) {
> +		struct yt921x_port *pp = &priv->ports[port];
> +
> +		pp->pcs.ops = &yt922x_phylink_pcs_ops;
> +		pp->pcs.poll = true;
> +
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  pp->pcs.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +			  pp->pcs.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  pp->pcs.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_USXGMII,
> +			  pp->pcs.supported_interfaces);
> +	}
> +}
> +
> +static int yt922x_dsa_setup(struct dsa_switch *ds)
> +{
> +	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
> +	struct device *dev = yt921x_priv_to_device(priv);
> +	struct device_node *np = dev->of_node;
> +	struct device_node *child;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_chip_reset(priv);
> +	mutex_unlock(&priv->reg_lock);
> +	if (res)
> +		return res;
> +
> +	/* Register the internal mdio bus. */
> +	child = of_get_child_by_name(np, "mdio");
> +	if (child) {
> +		res = yt921x_mbus_int_init(priv, child);
> +		of_node_put(child);
> +		if (res)
> +			return res;
> +	}
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt922x_chip_setup(priv);
> +	mutex_unlock(&priv->reg_lock);
> +	if (res)
> +		return res;
> +
> +	/* switch sds pcs setup */
> +	yt922x_pcs_setup(ds);
> +
> +	return 0;
> +}
> +
> +static const struct dsa_switch_ops yt922x_dsa_switch_ops = {
> +	/* port */
> +	.get_tag_protocol = yt922x_dsa_get_tag_protocol,
> +	.phylink_get_caps = yt922x_dsa_phylink_get_caps,
> +	.port_setup  = yt922x_dsa_port_setup,
> +	/* chip */
> +	.setup   = yt922x_dsa_setup,
> +};
> +
>  static const struct yt92xx_series yt92xx_series_table[] = {
>  	[YT92XX_MODE_YT921X] = {
>  		.name = "YT921x",

[Severity: Medium]
yt922x_cpu_port_set() passes dsa_cpu_ports(ds) straight into __ffs().
What happens if this switch has no local CPU port?

In a cascaded tree, a downstream switch reaches the conduit only
through a DSA link, so dsa_cpu_ports(ds) returns 0 for it.
__ffs(0) becomes __builtin_ctzl(0), which is undefined.

The result is masked into YT921X_EXT_CPU_PORT_PORT() and written to
YT921X_EXT_CPU_PORT with TAG_EN and PORT_EN set. The hardware would
then be told that some arbitrary port is the external CPU port.
Nothing in the probe path notices, and priv->cpu_ports_mask stays 0
for yt922x_port_setup() and yt922x_chip_setup_dsa() afterwards.

yt922x_dsa_switch_ops has no handling for DSA link ports at all. If
cascading is not meant to be supported on YT922x, should
yt922x_cpu_port_set() return an error when cpu_ports_mask is 0,
instead of programming the register? If cascading is meant to work,
what should YT921X_EXT_CPU_PORT be set to on the downstream switch?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011025043.1859940-1-kyle.switch%40motor-comm.com
