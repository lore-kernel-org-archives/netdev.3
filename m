Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC8649EC5B;
	Mon, 28 Sep 2026 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591967; cv=none; b=KNRbv9WA4X2vVDBqpwA6E47R0ujLHupjpdD9udu2Q6JwX1JyHMPZYERBglu/bSajU9GgXDrXUiTk/bUYODFA0PAeYedJBdSIuQOCpESSm81w1PTg3IdH5HjlG7twnfFS3r88Z+KMjiPk4KltgfinlBO4QKJcAma4en+XBp91jCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591967; c=relaxed/simple;
	bh=ftP0mipDeFKaaBhoj6G4usb/YCg+Go6IAmyLKqgNtYg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gwwCDZsPVUojhNhJYPHw5FiKt6IPVLQj8FEKrvp/NU6a8nreYUE8JC1a1KdAZbJUTuTMX51IkfFXm9x0LeyAOJa2psabvbzV3ChQGjtKFEI/UQQeej/gdcjLnfUYbJezvbJlNb7fcni5pGZNasGCwFOERRoQ6P9qEBOY5hKUvPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zkd3bm70; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zkd3bm70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4605C1F000FF;
	Mon, 28 Sep 2026 10:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790591965;
	bh=76TGmK3fPiaUnJq3SNTCe0VphXiZXfXHC4KsJH2my/g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Zkd3bm703z8SpRCkhjUqXjUVVMa33fK25GqZL0qPZguQf5ZNeQ7LQOLcHVYyOGtpl
	 E0nyWTJqjDQmLEZeqiamvRd45HossopE7cXTfYLeO4v3Y1xmdGtq/lb13qgufXivb2
	 FK8/c7pK3KxD+kTBzkzX3g1CmhshVedxXucvjq8V3hYzn6kk8oQaWhzKvo/M1/wQBs
	 QKkDb40zh1FWG4TcLuocmC9eT08BglISxgg1tyQljfE//TgwVgJqJUvo+bivDJ5Ncd
	 cEZr0h1vkF2jbAtNf1+InPTFlX9Q5irwVBt24HJe7ChCEKGh9GnDskCMgVTzjoYpOT
	 Yp2TnQS7RM+xg==
Subject: Re: [PATCH net-next v9 7/7] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Mon, 28 Sep 2026 10:39:23 +0000
Message-ID: <179059196386.3145.17500825176523588544@kernel.org>
In-Reply-To: <20260924094146.4128703-8-kyle.switch@motor-comm.com>
References: <20260924094146.4128703-8-kyle.switch@motor-comm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The driver now matches the compatible "motorcomm,yt9224" in
  yt921x_of_match, but the patch does not document it.
- [Medium] yt922x_pcs_config() does not follow the phylink pcs_config()
  contract.
- [Medium] net: dsa: motorcomm: register overwrite in yt922x_port_up()
- [Low] The YT92XX_MODE_YT922X entry in yt92xx_series_table sets
  assisted_learning_on_cpu_port, dscp_prio_mapping_is_global,…
- [Low] Several strings touched or reused by this patch still describe
  YT921x only: - Kconfig: the NET_DSA_YT921X prompt now says 'YT9215 and…
- [Low] yt921x_dsa_teardown() fails to compile when
  CONFIG_NET_DSA_YT921X_LEDS=n.

--

net: dsa: motorcomm: Add support for Motorcomm YT922x

This adds basic DSA support for the Motorcomm YT9224 switch to the
existing yt921x driver. YT9224 gets its own dsa_switch_ops, its own
phylink MAC ops and a SerDes PCS on ports 0 and 8. YT9228 is not
supported yet.

> diff --git a/drivers/net/dsa/motorcomm/Kconfig b/drivers/net/dsa/motorcomm/Kconfig
> index 79cdd79a1fd25..ab2b548c216f3 100644
> --- a/drivers/net/dsa/motorcomm/Kconfig
> +++ b/drivers/net/dsa/motorcomm/Kconfig
> @@ -1,7 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config NET_DSA_YT921X
> -	tristate "Motorcomm YT9215 ethernet switch chip support"
> +	tristate "Motorcomm YT9215 and YT9224 ethernet switch chip support"
>  	select NET_DSA_TAG_YT921X
> +	select NET_DSA_TAG_YT922X
>  	select NET_IEEE8021Q_HELPERS if DCB
>  	help
>  	  This enables support for the Motorcomm YT9215 ethernet switch

[Severity: Low]
This isn't a bug, but the prompt now mentions YT9224 while the help text
still says "This enables support for the Motorcomm YT9215 ethernet switch
chip."

A few other strings still describe only YT921x:

- The chip.c file header now says "Driver for Motorcomm YT921x and YT922x
  Switch". It is still followed by "Should work on
  YT9213/YT9214/YT9215/YT9218, but only tested on YT9215+SGMII".

- The internal_mask comment in struct yt921x_info still reads "Ports with
  integral GbE PHYs". yt922x_dsa_phylink_get_caps() advertises MAC_2500FD
  on those ports.

- yt921x_mbus_int_init() still names the bus "YT921x internal MDIO bus"
  when it runs on YT922x.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 46f7b94469ead..b0fc2cdbc1580 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -4240,6 +4254,11 @@ static void yt921x_dsa_teardown(struct dsa_switch *ds)
>  	}
>  }
>  

[Severity: Low]
This patch doesn't touch yt921x_dsa_teardown(), but at this commit it
looks like it won't build with CONFIG_NET_DSA_YT921X_LEDS=n:

static void yt921x_dsa_teardown(struct dsa_switch *ds)
{
#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
	struct yt921x_priv *priv = to_yt921x_priv(ds);

	yt921x_leds_remove(priv);
#endif
	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
		struct yt921x_port *pp = &priv->ports[i];

		disable_delayed_work_sync(&pp->mib_read);
	}
}

Is priv undeclared here when the LED option is off? The option is a bool
with this dependency:

	depends on LEDS_CLASS=y || LEDS_CLASS=NET_DSA_YT921X

so it is n when LEDS_CLASS=n, when LEDS_CLASS=m with NET_DSA_YT921X=y, or
when the user disables it.

The baseline doesn't have this. It came in earlier in this series with
"net: dsa: motorcomm: move mib stop from remove() to teardown()" and is
still present here.

> +static bool yt921x_needs_extmode_check(u32 major)

[ ... ]

> @@ -4694,6 +4725,637 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {

[ ... ]

> +static int yt922x_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> +			     phy_interface_t interface,
> +			     const unsigned long *advertising,
> +			     bool permit_pause_to_mac)
> +{

[ ... ]

> +	res = yt921x_intif_ext_read(priv, addr, YT922X_PORT_SDSn, &data);
> +	if (res)
> +		goto err;
> +	data &= ~YT922X_SERDES_MODE_M;
> +	data |= ctrl;
> +	res = yt921x_intif_ext_write(priv, addr, YT922X_PORT_SDSn, data);
> +	if (res)
> +		goto err;
> +	mutex_unlock(&priv->reg_lock);
> +
> +	return res;
> +
> +err:
> +	mutex_unlock(&priv->reg_lock);
> +
> +	return res;
> +}
> +
> +static const struct phylink_pcs_ops yt922x_pcs_ops = {
> +	.pcs_get_state = yt922x_pcs_get_state,
> +	.pcs_config = yt922x_pcs_config,
> +	.pcs_an_restart = yt922x_pcs_an_restart,
> +};

[Severity: Medium]
yt922x_pcs_config() never reads neg_mode or advertising. It updates only
the SERDES_MODE field of YT922X_PORT_SDSn and returns 0. It never sets or
clears BMCR_ANENABLE and never writes MII_ADVERTISE.

The pcs_config kernel-doc in include/linux/phylink.h says:

 * When operating in %MLO_AN_INBAND, inband should always be enabled,
 * otherwise inband should be disabled.

It also says the 1000BASE-X advertisement should be programmed into the
PCS.

Does this leave the SerDes in whatever AN state it had after reset?
yt922x_pcs_an_restart() only ORs in BMCR_ANRESTART, so it keeps the
existing AN-enable setting.

yt922x_pcs_ops also has no .pcs_link_up, and yt922x_port_up() programs
only YT922X_PORTn_CTRL. By contrast, yt921x_port_up() programs the
SerDes speed and duplex (YT921X_SERDES_SPEED_*) for external ports.

Take a fixed-link or out-of-band SGMII, 1000BASE-X or 2500BASE-X port,
such as a CPU port with a fixed 2500base-x link like the binding example.
How does its SerDes get the speed and duplex? Could SGMII at 10/100
without in-band status run at the wrong rate?

There is no .pcs_inband_caps either, so unsupported in-band modes are
never rejected.

An ethtool autoneg or advertisement change goes through:

  phylink_change_inband_advert()->yt922x_pcs_config()

That path does the same writes and returns 0. phylink then never requests
an AN restart, and it records settings the PCS never applied.

The exact effect depends on the SerDes reset defaults.

[ ... ]

> @@ -4707,12 +5369,26 @@ static const struct yt92xx_series yt92xx_series_table[] = {
>  		.switch_ops = &yt921x_dsa_switch_ops,
>  		.mac_ops = &yt921x_phylink_mac_ops
>  	},
> +	[YT92XX_MODE_YT922X] = {
> +		.mode = YT92XX_MODE_YT922X,
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
This isn't a bug, but this entry sets num_lag_ids, the ageing time range,
dscp_prio_mapping_is_global and assisted_learning_on_cpu_port.
yt922x_dsa_switch_ops has none of the matching callbacks (port_fdb_add/del,
port_lag_join/leave, set_ageing_time, or the DSCP ops).

Nothing changes at runtime today:

- With no port_bridge_join, dp->bridge stays NULL, so dsa_user_fdb_event()
  returns early before it checks assisted_learning_on_cpu_port.

- A LAG join falls back to software through the -EOPNOTSUPP handling in
  dsa_user_changeupper().

- The ageing time is only sent to ports that offload the bridge.

Would it be cleaner to leave these unset until the matching ops are
added?

[ ... ]

> @@ -4830,8 +5506,9 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
>  }
>  
>  static const struct of_device_id yt921x_of_match[] = {
> -	{ .compatible = "motorcomm,yt9215" },
> -	{}
> +	{ .compatible = "motorcomm,yt9215", },
> +	{ .compatible = "motorcomm,yt9224", },
> +	{ /* sentinel */ }
>  };

[Severity: Medium]
Is "motorcomm,yt9224" documented anywhere? The only binding for this
driver, Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml,
still has:

  compatible:
    const: motorcomm,yt9215

Won't a DT node using the new compatible fail dt_binding_check and
dtbs_check? checkpatch will also flag it as undocumented.

The binding description also covers only the YT921x port layout ("up to 8
internal GbE PHYs", "GMACs (Port 8-9)"). The YT9224 setup here uses
internal PHYs on ports 4-7 and SerDes on ports 0 and 8.

Should a binding update go with this patch?

[ ... ]

> @@ -4694,6 +4725,637 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
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
> +		YT922X_PORT_TX_MAC_EN | YT922X_PORT_LINK_AN;
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
> +	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
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
> +	u32 mask;
> +	u32 ctrl;
> +	int res;
> +
> +	switch (speed) {
> +	case SPEED_10:
> +		ctrl = YT921X_PORT_SPEED_10;
> +		break;
> +	case SPEED_100:
> +		ctrl = YT921X_PORT_SPEED_100;
> +		break;
> +	case SPEED_1000:
> +		ctrl = YT921X_PORT_SPEED_1000;
> +		break;
> +	case SPEED_2500:
> +		ctrl = YT921X_PORT_SPEED_2500;
> +		break;
> +	case SPEED_5000:
> +		ctrl = YT921X_PORT_SPEED_5000;
> +		break;
> +	case SPEED_10000:
> +		ctrl = YT921X_PORT_SPEED_10000;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	if (duplex == DUPLEX_FULL)
> +		ctrl |= YT922X_PORT_DUPLEX_FULL;
> +	if (tx_pause)
> +		ctrl |= YT922X_PORT_TX_PAUSE;
> +	if (rx_pause)
> +		ctrl |= YT922X_PORT_RX_PAUSE;
> +	ctrl |= YT922X_PORT_RX_MAC_EN | YT922X_PORT_TX_MAC_EN |
> +		YT922X_PORT_CFG_TX_EN | YT922X_PORT_LINK |
> +		YT922X_PORT_CFG_RX_EN;
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
> +	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
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
> +static int
> +yt921x_intif_ext_write(struct yt921x_priv *priv, int port, int reg, u16 val)
> +{
> +	int res;
> +
> +	if (port > priv->series->max_ports)
> +		return -ENODEV;
> +
> +	res = yt921x_intif_write(priv, port, YT92XX_PAGE_SELECT, reg);
> +	if (res)
> +		return res;
> +
> +	res = yt921x_intif_write(priv, port, YT92XX_PAGE, val);
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}
> +
> +static int
> +yt921x_intif_ext_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
> +{
> +	int res;
> +
> +	if (port > priv->series->max_ports)
> +		return -ENODEV;
> +
> +	res = yt921x_intif_write(priv, port, YT92XX_PAGE_SELECT, reg);
> +	if (res)
> +		return res;
> +
> +	res = yt921x_intif_read(priv, port, YT92XX_PAGE, valp);
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}
> +
> +static int yt922x_sds_phyaddr_get(int port,
> +				  enum yt922x_phy_reg_type reg_type)
> +{
> +	/*
> +	 * sds phyaddr mapping depend on reg_type
> +	 */
> +	if (!yt922x_port_is_internal_sds(port))
> +		return -EOPNOTSUPP;
> +	if (reg_type == YT922X_PHY_REG_TYPE_COMMON_EXT)
> +		return YT922X_COMMON_EXT_PHYADDR;
> +
> +	return port;
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
> +	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
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
> +static void yt922x_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
> +				 struct phylink_link_state *state)
> +{
> +	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
> +	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
> +	int port = pp->index;
> +	int res = 0;
> +	u16 data;
> +	int addr;
> +	u16 lp;
> +
> +	addr = yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII);
> +	if (addr < 0) {
> +		state->link = false;
> +		return;
> +	}
> +
> +	mutex_lock(&priv->reg_lock);
> +	switch (state->interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		res = yt921x_intif_read(priv, addr, MII_BMSR, &data);
> +		if (res)
> +			goto err;
> +		res = yt921x_intif_read(priv, addr, MII_LPA, &lp);
> +		if (res)
> +			goto err;
> +		phylink_mii_c22_pcs_decode_state(state, neg_mode, data, lp);
> +		break;
> +	case PHY_INTERFACE_MODE_USXGMII:
> +		res = yt921x_intif_read(priv, addr, YT922X_PCS_LINK_CTRL,
> +					&data);
> +		if (res)
> +			goto err;
> +		state->link =  FIELD_GET(YT922X_PCS_LINK_STATUS, data);
> +		state->an_complete = FIELD_GET(YT922X_PCS_AN_COMPLETE, data);
> +		res = yt921x_intif_read(priv, addr, MII_LPA, &lp);
> +		if (res)
> +			goto err;
> +		if (state->link)
> +			phylink_decode_usxgmii_word(state, lp);
> +		break;
> +	default:
> +		state->link = false;
> +		break;
> +	}
> +	mutex_unlock(&priv->reg_lock);
> +	return;
> +err:
> +	mutex_unlock(&priv->reg_lock);
> +	state->link = false;
> +}
> +
> +static void yt922x_pcs_an_restart(struct phylink_pcs *pcs)
> +{
> +	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
> +	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
> +	struct device *dev = to_device(priv);
> +	int port = pp->index;
> +	u16 data;
> +	int addr;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	addr = yt922x_sds_phyaddr_get
> +		(port, YT922X_PHY_REG_TYPE_MII);
> +	if (addr < 0) {
> +		res = addr;
> +		goto err;
> +	}
> +	res = yt921x_intif_read(priv, addr, MII_BMCR, &data);
> +	if (res)
> +		goto err;
> +	data |= BMCR_ANRESTART;
> +	res = yt921x_intif_write(priv, addr, MII_BMCR, data);
> +	if (res)
> +		goto err;
> +	mutex_unlock(&priv->reg_lock);
> +	return;
> +
> +err:
> +	mutex_unlock(&priv->reg_lock);
> +	if (res)
> +		dev_err(dev, "Failed to %s PCS port %d: %i\n", "an restart",
> +			port, res);
> +}
> +
> +static int yt922x_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> +			     phy_interface_t interface,
> +			     const unsigned long *advertising,
> +			     bool permit_pause_to_mac)
> +{
> +	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
> +	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
> +	int res, port;
> +	u16 data;
> +	u16 ctrl;
> +	int addr;
> +
> +	port = pp->index;
> +	if (!yt922x_port_is_internal_sds(port))
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->reg_lock);
> +	addr = yt922x_sds_phyaddr_get
> +		(port, YT922X_PHY_REG_TYPE_SDS_COMMON_EXT);
> +	if (addr < 0) {
> +		res = addr;
> +		goto err;
> +	}
> +	/* write protect */
> +	res = yt921x_intif_ext_write(priv, addr, 0x4be, 0xd);
> +	if (res)
> +		goto err;
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +		ctrl = YT922X_SERDES_MODE_SGMII;
> +		break;
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +		ctrl = YT922X_SERDES_MODE_1000BASEX;
> +		break;
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		ctrl = YT922X_SERDES_MODE_2500BASEX;
> +		break;
> +	case PHY_INTERFACE_MODE_USXGMII:
> +		ctrl = YT922X_SERDES_MODE_USXGMII;
> +		break;
> +	default:
> +		res = -EINVAL;
> +		goto err;
> +	}
> +	res = yt921x_intif_ext_read(priv, addr, YT922X_PORT_SDSn, &data);
> +	if (res)
> +		goto err;
> +	data &= ~YT922X_SERDES_MODE_M;
> +	data |= ctrl;
> +	res = yt921x_intif_ext_write(priv, addr, YT922X_PORT_SDSn, data);
> +	if (res)
> +		goto err;
> +	mutex_unlock(&priv->reg_lock);
> +
> +	return res;
> +
> +err:
> +	mutex_unlock(&priv->reg_lock);
> +
> +	return res;
> +}
> +
> +static const struct phylink_pcs_ops yt922x_pcs_ops = {
> +	.pcs_get_state = yt922x_pcs_get_state,
> +	.pcs_config = yt922x_pcs_config,
> +	.pcs_an_restart = yt922x_pcs_an_restart,
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
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
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
> +	if (info->external_mask & BIT(port)) {
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
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
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
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	const struct yt921x_info *info = priv->info;
> +	unsigned long mask;
> +	int port;
> +
> +	mask = info->external_mask;
> +	for_each_set_bit(port, &mask, priv->series->max_ports) {
> +		struct yt921x_port *pp = &priv->ports[port];
> +
> +		pp->pcs.ops = &yt922x_pcs_ops;
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
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct device *dev = to_device(priv);
> +	struct device_node *np = dev->of_node;
> +	struct device_node *child;
> +	int res;
> +
> +	/*  ports index init */
> +	for (size_t i = 0; i < ARRAY_SIZE(priv->ports); i++) {
> +		struct yt921x_port *pp = &priv->ports[i];
> +
> +		pp->index = i;
> +	}
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
>  		.mode = YT92XX_MODE_YT921X,

[Severity: Medium]
yt922x_port_up() builds ctrl from scratch, starting with the speed
value. It then writes it to YT922X_PORTn_CTRL(port) with a plain
yt921x_reg_write(). Every bit not explicitly set here is cleared on
each link up. That includes YT922X_PORT_HALF_PAUSE and any reserved
or undocumented bits above YT922X_PORT_FORCE_OP.

The ctrl &= ~(YT922X_PORT_FC_AN | YT922X_PORT_LINK_AN) line suggests
a read-modify-write was intended. ctrl never held the register
contents, though, so that line does nothing.

The full write also clears YT922X_PORT_FORCE_OP, which
yt922x_port_down() had set. Only the following yt921x_reg_set_bits()
sets it again. yt922x_port_down() uses yt921x_reg_clear_bits() on the
same register, so the two paths treat it differently.

Is the full overwrite intended? If not, would yt921x_reg_update_bits()
do what you want here, with a mask covering speed, duplex, pause, the
MAC and CFG enables, FC_AN and LINK_AN? If it is intended, please drop
the dead mask and add a comment on why the other bits can be
discarded.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924094146.4128703-1-kyle.switch%40motor-comm.com
