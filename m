Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77971494838;
	Mon, 21 Sep 2026 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790019858; cv=none; b=q6n8MGLXscO+7ZYDRnMfMYxia05E2Ze1QvSVs/2ymYYVOTbB86RC0XhIfdjvmZcVx4sGcFzhkXCQLFTvgnOH5yn5pLh52ruQuk3QsuigvqFoPfUBxztg/sR0R6HW4Kgxk+V4npXttblPMi7h8NnyokzzIjV7PE/hhjkZnMsEDVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790019858; c=relaxed/simple;
	bh=CqrAnHtcwX9WQpWWUO3LaXFmHGfOvpp3wC/giK8+WVk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MKtixr4wjAhbBLsAFkbT8uPFrx7RRG8jHkvmfKBcEioi+YVTewhL/5JtKBxr/r6WOJkFIEn4r0+qa5aN6bJvqFjb3Ryrv2NAFkrYLPcSsFszoQdyKF2lrnFGXrwhCOahcGnDnZKt+1nkGeTZx0qg4HLziNk+vLDwz2q4R4mt/Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ni06qA4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ni06qA4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863181F00893;
	Mon, 21 Sep 2026 19:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790019856;
	bh=8K12elA3reNVde5Ectr0vBv0VBkq3lZswh5dkH1Ivlo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ni06qA4aFpjZAK0TeR/oyUyseY/rVgQJEM83YWIaNnlNjSzUBs1Ibb48VS+0lyNX3
	 LDGJGXJ96b2TCUO0iTkASXc9ov8u6BgQVSqaLzmne+Ou2BuyPYxkuejYgAaGZ1/WIf
	 D0U85/JIvo5B7JHpuedVEHFNYf4kgs3SxPUmZ7k87inxj/hKtShfzB8619mObBVDcR
	 wJTzDlbeNT5RkhLh39x7H42Y7fNRg738dyX4kfukw6IaaL44sKu/dpdsOk9Qg+69m3
	 57LKaApFouDmpoxGC1MXHC1cJcJBeePxBFnacoNVe9e5AxElhoIe0nprBGPdqV5Zq6
	 vYg7KqEbUTlcQ==
Subject: Re: [PATCH net-next v3 8/8] net: dsa: motorcomm: Add SerDes PCS
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2026 19:44:15 +0000
Message-ID: <179001985513.2160803.17379563809191262211@kernel.org>
In-Reply-To: <20260917185010.3189199-9-mmyangfl@gmail.com>
References: <20260917185010.3189199-9-mmyangfl@gmail.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] PHY_INTERFACE_MODE_100BASEX is advertised as a supported PCS
  interface and the SerDes is actually programmed to…
- [Medium] For SGMII with in-band signalling enabled,
  yt921x_serdes_config() sets YT921X_PORT_CTRL_PAUSE_AN whenever…
- [Low] yt921x_phylink_pcs_get_state() logs an unconditional dev_err() on
  every register-read failure (pcs-921x.c:132-137).

--

net: dsa: motorcomm: Add SerDes PCS

This adds a phylink PCS implementation for the yt921x SerDes ports, moving
the SerDes mode selection out of yt921x_port_config() into pcs_config(),
and wires up in-band negotiation through the internal MDIO interface.

A few questions about the new PCS code below.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 491ba1edfa3cd..530bea77ac70a 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -3511,6 +3512,10 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
>  	if (ps == YT921X_SPEED_NUM)
>  		return -EINVAL;
>  
> +	mask = YT921X_PORT_SPEED_M | YT921X_PORT_TX_MAC_EN |
> +	       YT921X_PORT_RX_MAC_EN | YT921X_PORT_TX_PAUSE |
> +	       YT921X_PORT_RX_PAUSE | YT921X_PORT_DUPLEX_FULL |
> +	       YT921X_PORT_CTRL_LINK_AN;
>  	ctrl = YT921X_PORT_SPEED(ps);
>  	if (duplex == DUPLEX_FULL)
>  		ctrl |= YT921X_PORT_DUPLEX_FULL;
> @@ -3519,7 +3524,9 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
>  	if (rx_pause)
>  		ctrl |= YT921X_PORT_RX_PAUSE;
>  	ctrl |= YT921X_PORT_RX_MAC_EN | YT921X_PORT_TX_MAC_EN;
> +	if (pp->serdes && pp->inband)
> +		ctrl |= YT921X_PORT_CTRL_LINK_AN;
> +	res = yt921x_reg_update_bits(priv, YT921X_PORTn_CTRL(port), mask, ctrl);
>  	if (res)
>  		return res;

[ ... ]

> @@ -3637,6 +3622,29 @@ yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
>  	return -EINVAL;
>  }
>  
> +static struct phylink_pcs *
> +yt921x_phylink_mac_select_pcs(struct phylink_config *config,
> +			      phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
> +	const struct yt921x_info *info = priv->info;
> +	int port = dp->index;
> +
> +	if (!(BIT(port) & info->serdes_mask))
> +		return NULL;
> +
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_100BASEX:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		return &priv->ports[port].pcs;
> +	default:
> +		return NULL;
> +	}
> +}
> +

[ ... ]

> @@ -4266,6 +4281,23 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
>  		return -ENODEV;
>  	}
>  
> +	mask = priv->info->serdes_mask;
> +	for_each_set_bit(port, &mask, YT921X_PORT_NUM) {
> +		struct yt921x_port *pp = &priv->ports[port];
> +
> +		pp->pcs.ops = &yt921x_phylink_pcs_ops;
> +		pp->pcs.poll = true;
> +
> +		__set_bit(PHY_INTERFACE_MODE_SGMII,
> +			  pp->pcs.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_100BASEX,
> +			  pp->pcs.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +			  pp->pcs.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			  pp->pcs.supported_interfaces);
> +	}
> +

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/pcs-921x.c b/drivers/net/dsa/motorcomm/pcs-921x.c
> new file mode 100644
> index 0000000000000..dcf7397cd2413
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/pcs-921x.c
> @@ -0,0 +1,235 @@

[ ... ]

> +static int
> +yt921x_serdes_config(struct yt921x_priv *priv, int port, unsigned int neg_mode,
> +		     phy_interface_t interface,
> +		     const unsigned long *advertising, bool permit_pause_to_mac)
> +{
> +	bool inband = neg_mode & PHYLINK_PCS_NEG_INBAND;
> +	struct yt921x_port *pp = &priv->ports[port];

[ ... ]

> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +		ctrl = YT921X_SERDES_MODE_SGMII;
> +		break;
> +	case PHY_INTERFACE_MODE_100BASEX:
> +		ctrl = YT921X_SERDES_MODE_100BASEX;
> +		break;
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +		ctrl = YT921X_SERDES_MODE_1000BASEX;
> +		break;
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		ctrl = YT921X_SERDES_MODE_2500BASEX;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	res = yt921x_reg_update_bits(priv, YT921X_SERDESn(port),
> +				     YT921X_SERDES_MODE_M, ctrl);
> +	if (res)
> +		return res;
> +
> +	mask = YT921X_PORT_CTRL_LINK_AN | YT921X_PORT_CTRL_PAUSE_AN;
> +	ctrl = 0;
> +	if (inband)
> +		ctrl |= YT921X_PORT_CTRL_LINK_AN;
> +	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED && permit_pause_to_mac)
> +		ctrl |= YT921X_PORT_CTRL_PAUSE_AN;

[Severity: Medium]
Should YT921X_PORT_CTRL_PAUSE_AN also be gated on the interface here?

For PHY_INTERFACE_MODE_SGMII the Cisco in-band configuration word carries
only link, speed and duplex - there are no pause capability bits - so the
resolved pause can only come from the attached PHY via the tx_pause/rx_pause
arguments of mac_link_up().

permit_pause_to_mac is true by default, since phylink_create() initialises
link_config.pause to MLO_PAUSE_AN and phylink_major_config() passes:

    err = phylink_pcs_config(pl->pcs, pl->pcs_neg_mode, state,
                             !!(pl->link_config.pause & MLO_PAUSE_AN));

so an SGMII port with in-band enabled ends up with PAUSE_AN set. At the same
time yt921x_port_up() now programs the software-resolved bits with a masked
update whose mask does not contain YT921X_PORT_CTRL_PAUSE_AN:

    mask = YT921X_PORT_SPEED_M | YT921X_PORT_TX_MAC_EN |
           YT921X_PORT_RX_MAC_EN | YT921X_PORT_TX_PAUSE |
           YT921X_PORT_RX_PAUSE | YT921X_PORT_DUPLEX_FULL |
           YT921X_PORT_CTRL_LINK_AN;

so PAUSE_AN stays set while TX_PAUSE/RX_PAUSE are written from software.
Does that leave flow control taking its value from in-band fields that SGMII
never transmits?

mvpp2_gmac_pcs_config() only applies permit_pause_to_mac in the 802.3z branch
and explicitly not for SGMII, for the same reason.

> +	res = yt921x_reg_update_bits(priv, YT921X_PORTn_CTRL(port), mask, ctrl);
> +	if (res)
> +		return res;

[ ... ]

> +static unsigned int
> +yt921x_phylink_pcs_inband_caps(struct phylink_pcs *pcs,
> +			       phy_interface_t interface)
> +{
> +	return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
> +}
> +
> +static void
> +yt921x_phylink_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
> +			     struct phylink_link_state *state)
> +{

[ ... ]

> +	res = yt921x_intif_read(priv, port, MII_BMSR, &bmsr);
> +	if (res)
> +		goto out;
> +
> +	res = yt921x_intif_read(priv, port, MII_LPA, &lpa);
> +
> +out:
> +	mutex_unlock(&priv->reg_lock);
> +
> +	if (res) {
> +		dev_err(dev, "Failed to %s PCS port %d: %i\n", "get state of",
> +			port, res);
> +		state->link = false;
> +		return;
> +	}

[Severity: Low]
Would dev_err_ratelimited(), or logging only on a state change, be better
here?

yt921x_dsa_setup() registers the PCS with pp->pcs.poll = true, and phylink
arms a one second timer for MLO_AN_INBAND ports:

drivers/net/phy/phylink.c:phylink_pcs_poll_start() {
	if (pl->pcs && pl->pcs->poll && pl->cfg_link_an_mode == MLO_AN_INBAND)
		mod_timer(&pl->link_poll, jiffies + HZ);
}

phylink_resolve() also calls phylink_mac_pcs_get_state() a second time when
the link reads down. If the internal MDIO/SMI access keeps failing (bus
wedged, chip held in reset), does this print the same message roughly twice
per second per SerDes port indefinitely?

The error paths in yt921x_phylink_pcs_an_restart() and
yt921x_phylink_pcs_disable() are bounded by administrative events, but this
one is on a periodic path.

> +
> +	phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr, lpa);
> +}

[Severity: Medium]
Can a 100BASE-X port ever come up with this decode path?

PHY_INTERFACE_MODE_100BASEX is set in pp.pcs.supported_interfaces by
yt921x_dsa_setup(), yt921x_phylink_mac_select_pcs() returns this PCS for it,
and yt921x_serdes_config() programs YT921X_SERDES_MODE_100BASEX, but
phylink_mii_c22_pcs_decode_state() has no case for it:

drivers/net/phy/phylink.c:phylink_mii_c22_pcs_decode_state() {
	state->link = !!(bmsr & BMSR_LSTATUS);
	...
	switch (state->interface) {
	case PHY_INTERFACE_MODE_1000BASEX:
	...
	case PHY_INTERFACE_MODE_2500BASEX:
	...
	case PHY_INTERFACE_MODE_SGMII:
	...
	default:
		state->link = false;
		break;
	}
}

so the BMSR_LSTATUS bit just read from MII_BMSR is discarded and the link is
forced down on every poll.

One way to reach this without any in-band DT setting is an SFP cage on a
SerDes port: phylink_sfp_config_optical() picks
PHY_INTERFACE_MODE_100BASEX for a 100BASE-FX module and
phylink_sfp_set_config() selects MLO_AN_INBAND, after which
phylink_resolve() uses pcs_get_state() as the only link source.

On a related note, yt921x_phylink_pcs_inband_caps() ignores its interface
argument and reports LINK_INBAND_ENABLE for 100BASE-X as well.
phylink_get_inband_type() returns INBAND_NONE for that mode, so
BMCR_ANENABLE is not actually armed, but
phylink_validate_pcs_inband_autoneg() consults these caps, so
"ethtool -s ... autoneg on" is accepted for a mode with no in-band
negotiation. Should the 100BASE-X case return LINK_INBAND_DISABLE only, or
be dropped from supported_interfaces until the state decoding handles it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917185010.3189199-1-mmyangfl%40gmail.com
