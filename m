Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635088;
	b=s452upHA+Flxeq9lt+ikkWd1CHhftZWwYQoY37lJXuCdrMJA2K7uJua4jbjCV+f52PVm
	 G8Fi6fUaeoWq4nTqzjxyNcu07CzStishQwZ4iBp2MD0DwLjgRny6ml/z5dHd1WST6tyb4
	 Yu35a9hn90I9oU20d9qIn/V1vGvZzAaDPrG6gXXufHpihIxdk/9pLteAtHwc0bYvV7FfH
	 XS/T98Jx6Sw76VB1GeehyjvqZPTPm+zgx33pD2PSUatwmmU5dmqXOHcdaVR83g4TLI4Oe
	 qNZChDjCUZj+10uRT00CNtozum6OmYfPxZKdqsxHmlIt/NVKYW4k7K8GvdmQ6BfE4Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635088;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ufUFmryCQ5/cziiF8CC+dv7WB0Oz7MQ1k7QzIbPVAGw=;
	b=gi5qn6aL4j2Hg5x+9XcFoHcYnOPb9PYZNKUjIhFkyHxelb8ilOB4DdCF3m0+uKEHr/p7
	 PI3Qlo1PadDLf74lSIVtZQe4aONnPiydpAaaEjRT7gbMb0Sg75jUnZXK1TDZoEgIjtRLx
	 AZ0U8uo5ZKYFSYckcVwvLgRnXmFPyTVuJVM8EvrWV9pd4uGfArbzycwQDysQjbVRcuTRi
	 o2LJSlMiB/QzdieBq/3nwUwkLLavQSU9dNkjpe8ctI7MES6lQd/+cJrs0Th64zoyVFb0m
	 huNI84WBY8VGXXd9k8Nf6HvyOhyd9My1wouhzO0cOfF7nXCeTZc/yiO4LNR4toD7DqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WVv8CltN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70530606A331;
	Thu, 22 Oct 2026 02:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WVv8CltN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E5E1F000C1;
	Thu, 22 Oct 2026 02:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792635088;
	bh=ufUFmryCQ5/cziiF8CC+dv7WB0Oz7MQ1k7QzIbPVAGw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WVv8CltN4eQlTrbylpl5R7zGBsej5r4oe2lSd+bwMIe5NhLnkFmKiryOujvXqiUhk
	 JLWP+73fdnES3KJCx3kR0NSJMCqd2dGdkvemRw9G3DiAnbVS4zuzMo4UX6Vz+4jWOr
	 Aq6fXDP9eUR3MLnbHxLVjhZdtQZ38YqQa6PkiuKiHPLEmPFEKG9jlavZ869MDMY3IW
	 zXala83rWIS6THGhJ9XmJu3RfgPONDl8ngEJguoLPw+pLJYZyHvdGyf0sON/1bhv7Z
	 a2FZ/6AMxrMAxaMH1Jt3F7RAviihhcn2oewa4Qmu9P6LZKqOl9wL+Zi3KNeX1HChZj
	 KN2OHBk0HDCLQ==
Subject: Re: [PATCH net-next v16 5/5] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Thu, 22 Oct 2026 02:11:27 +0000
Message-ID: <179263508707.3135.8457050259877070501@kernel.org>
In-Reply-To: <20261020111115.3072180-6-kyle.switch@motor-comm.com>
References: <20261020111115.3072180-6-kyle.switch@motor-comm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] yt921x_of_match in drivers/net/dsa/motorcomm/chip.c now
  accepts the new compatible "motorcomm,yt9224", but the DT binding was…
- [Medium] yt922x_port_up() (drivers/net/dsa/motorcomm/chip.c) sets
  YT922X_PORT_FC_AN | YT922X_PORT_LINK_AN whenever pp->inband is true.
- [Medium] On YT922x SerDes ports (0 and 8), nothing tells the SerDes
  side the resolved speed, duplex or link when in-band AN is not enabled.
- [Medium] yt922x_pcs_an_restart() (drivers/net/dsa/motorcomm/pcs-922x.c)
  sets BMCR_RESET in addition to BMCR_ANRESTART.
- [Low] The YT922x code disagrees with itself on
  PHY_INTERFACE_MODE_100BASEX.
- [Low] The YT92XX_MODE_YT922X entry in yt92xx_series_table
  (drivers/net/dsa/motorcomm/chip.c) declares capabilities that…

--

net: dsa: motorcomm: Add support for Motorcomm YT922x

This adds initial support for the Motorcomm YT9224 switch to the yt921x
DSA driver. It adds a separate dsa_switch_ops and phylink_mac_ops table
for the YT922x series and a new PCS implementation in pcs-922x.c. Only
port_setup, setup, phylink_get_caps and get_tag_protocol are provided.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index be82fbb99a936..b5c76a5ce55a2 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -2574,6 +2593,470 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {

[ ... ]

> +static int
> +yt922x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
> +	       phy_interface_t interface, int speed, int duplex,
> +	       bool tx_pause, bool rx_pause)
> +{

[ ... ]

> +	/*
> +	 * Self-negotiation: the LINK/AN bits in ctrl are set based to inband.
> +	 * Forced mode: set LINK, keep the AN bit at 0 and clear it via the mask
> +	 */
> +	if (pp->inband)
> +		ctrl |= (YT922X_PORT_FC_AN | YT922X_PORT_LINK_AN);
> +	else
> +		ctrl |= YT922X_PORT_LINK;

[Severity: Medium]
Should YT922X_PORT_FC_AN really be set every time pp->inband is true?

pp->inband is set in yt922x_pcs_config():

	bool inband = neg_mode & PHYLINK_PCS_NEG_INBAND;

In include/linux/phylink.h, PHYLINK_PCS_NEG_INBAND_DISABLED has the same
value as PHYLINK_PCS_NEG_INBAND. So this test is also true when in-band AN
is disabled and BMCR_ANENABLE is being cleared. yt922x_pcs_config() also
never reads permit_pause_to_mac.

As a result, FC_AN gets set in these cases:

- the INBAND_DISABLED case
- SGMII, whose in-band word carries no pause bits
- when phylink passes permit_pause_to_mac = false, for example after
  ethtool -A ... autoneg off

In those cases, would the MAC ignore the tx_pause/rx_pause values that
phylink passed to mac_link_up()?

The YT921x path in pcs-921x.c gates the equivalent bit like this:

yt921x_serdes_config() {
    ...
	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED && permit_pause_to_mac &&
	    interface != PHY_INTERFACE_MODE_SGMII)
		ctrl |= YT921X_PORT_CTRL_PAUSE_AN;
    ...
}

Could YT922x use the same condition?

> +
> +	res = yt921x_reg_update_bits(priv, YT922X_PORTn_CTRL(port), mask, ctrl);
> +	if (res)
> +		return res;

[Severity: Medium]
On the SerDes ports (0 and 8), does anything program the SerDes side with
the resolved speed, duplex and link when in-band AN is not used? Examples
are SGMII with an out-of-band PHY, or a fixed-link.

As far as I can see, nothing does:

- yt922x_port_up() writes only YT922X_PORTn_CTRL.
- yt922x_pcs_config() writes only the SerDes mode field and
  BMCR_ANENABLE.
- yt922x_phylink_pcs_ops has no .pcs_link_up.
- yt922x_port_config() sets pp->serdes = true, but no YT922x code reads
  it.

The YT921x path does this step in yt921x_port_up():

	if (pp->serdes) {
		mask = YT921X_SERDES_SPEED_M;
		ctrl = YT921X_SERDES_SPEED(ps);
		...

If the YT922x PCS works the same way, could a 10/100 link through an SGMII
PHY with AN disabled leave the PCS at its default rate while the MAC is
forced to 10/100? The link would come up but pass no traffic.

The YT922x register map isn't public, so the MAC-side write may be enough
on its own. Could this be confirmed?

[ ... ]

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

[Severity: Low]
Is PHY_INTERFACE_MODE_100BASEX meant to be supported on YT922x?

Some of the code handles it:

- yt922x_port_config() accepts it.
- yt922x_pcs_config() programs YT922X_SERDES_MODE_100BASEX.
- yt922x_pcs_get_state() has a dedicated 100BASEX branch.

Other places leave it out:

- yt922x_dsa_phylink_get_caps() does not set it in
  config->supported_interfaces.
- yt922x_pcs_setup() does not set it in pcs.supported_interfaces.
- yt922x_phylink_mac_select_pcs() returns NULL for it.

phylink will reject 100base-x, so the 100BASEX handling looks like dead
code. Should 100BASEX be added to the caps and the PCS selection, or
dropped?

Also, yt922x_phylink_pcs_ops has no .pcs_inband_caps. yt921x_phylink_pcs_ops
has yt921x_phylink_pcs_inband_caps(), which limits 100BASEX to
LINK_INBAND_DISABLE. Should YT922x provide one as well, so phylink knows
the in-band limits of the PCS?

[ ... ]

> @@ -2586,12 +3069,25 @@ static const struct yt92xx_series yt92xx_series_table[] = {
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
Do these capabilities match what yt922x_dsa_switch_ops implements?

yt92xx_register_switch() copies these fields into struct dsa_switch:

- num_lag_ids
- ageing_time_min/max
- dscp_prio_mapping_is_global
- assisted_learning_on_cpu_port

yt922x_dsa_switch_ops only has get_tag_protocol, phylink_get_caps,
port_setup and setup. There is no port_lag_join, set_ageing_time,
port_fdb_add/del or DSCP op.

With assisted_learning_on_cpu_port set, the DSA core will try to program
host FDB entries. dsa_user_fdb_event() then returns -EOPNOTSUPP because
port_fdb_add/del are missing.

Nothing breaks at runtime today. Should these fields stay unset until the
matching ops are added? They look copied from the YT921x entry.

[ ... ]

> @@ -2716,6 +3210,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
>  
>  static const struct of_device_id yt921x_of_match[] = {
>  	{ .compatible = "motorcomm,yt9215" },
> +	{ .compatible = "motorcomm,yt9224" },
>  	{}
>  };

[Severity: Medium]
Is a binding update for this compatible missing from the series?

Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml still has:

    const: motorcomm,yt9215

Its description only covers the YT9213/4/5/8 port layouts. YT9224 has a
different layout: internal PHYs on ports 4-7, SerDes on ports 0 and 8, and
no xMII.

Any DTS using motorcomm,yt9224 would fail dtbs_check. checkpatch will also
warn about an undocumented compatible.

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/pcs-922x.c b/drivers/net/dsa/motorcomm/pcs-922x.c
> new file mode 100644
> index 0000000000000..5ad7873e0df7e
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/pcs-922x.c

[ ... ]

> +static void yt922x_pcs_an_restart(struct phylink_pcs *pcs)
> +{

[ ... ]

> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_intif_read(priv, addr, MII_BMCR, &bmcr);
> +	if (res)
> +		goto err;
> +	bmcr |= BMCR_ANRESTART;
> +	bmcr |= BMCR_RESET;
> +	res = yt921x_intif_write(priv, addr, MII_BMCR, bmcr);

[Severity: Medium]
Is BMCR_RESET intended here?

This PCS is driven as a Clause 22 device. get_state uses MII_BMSR/MII_LPA
and phylink_mii_c22_pcs_decode_state().

On such a PCS, BMCR bit 15 resets the control registers to their defaults.
Could that wipe out the MII_ADVERTISE value and the BMCR_ANENABLE state
that yt922x_pcs_config() just wrote? The code also does not wait for the
self-clearing reset to complete.

This path runs right after configuration. yt922x_pcs_config() reports a
change even when only ANENABLE toggles:

	changed |= (bmcr_new != bmcr_old);

So for 1000BASE-X/2500BASE-X with in-band AN, the first major config
returns > 0 and phylink then calls pcs_an_restart. Running ethtool -r on
the port takes the same path through phylink_ethtool_nway_reset().

The YT921x version, yt921x_phylink_pcs_an_restart(), only sets
BMCR_ANRESTART. yt921x_serdes_config() also clears changed when ANENABLE
toggles:

	/* If the ANENABLE bit was changed, the PHY will restart negotiation,
	 * so we don't need to flag a change to trigger its own restart.
	 */
	if (bmcr != val)
		changed = false;

Should YT922x follow the same approach?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020111115.3072180-1-kyle.switch%40motor-comm.com
