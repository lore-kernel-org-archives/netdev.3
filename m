Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AFB499F27;
	Mon, 21 Sep 2026 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983335; cv=none; b=goCUVBkWLhByIgTMChIzMxOvM+V9+nOqU7pbmcLNxwchDNbWPVYxgETZSEluibthigmLVfmY+1o0VqKSwlmaK2dS1IrlQQif3hWLOt7XXLOZXMHG9hWIUihrLTDC5JaGOHweYM7p5PxwX8/+fM7gzO3gcPWXoV9pvOVygPAZYXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983335; c=relaxed/simple;
	bh=2fx0gGNpJJopbueNjiaGNeqxnVxGgXTC314wtJ4/y0w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o0vD6Lg861Qpa3uToos5zQooqEdVIyxFdvMucjqwYF1l392GdzXSsiayyGo8wOD+wFHwmtagVyQtL1Gi2oUNw+AKzohTy5caHIqc+Laid4K+dmjLymFNfwur81JwZqjECPpFuWnixKRom4326Oea77poRipm53f3hNHyERuz4Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0YHY5DN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0YHY5DN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30551F000FF;
	Mon, 21 Sep 2026 09:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789983333;
	bh=YMwOLTG56jwERBfAtojuwEAnWnxIxlP6/aR60IPV2YA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g0YHY5DNQmRnzw5ZnVAGKe4+tlVVwu9JhGYX0aHoaTop83aX8l147sED440xeyoS6
	 NRDK7ruQlUQzF455YG76kXawczR5ewflUXa7oBx71oFCwG+O3WZ4v1nxLbAxh89jk/
	 pyLjTfFFFD+xBaOskDj0uk6IWJdiqWpEEV/BuV6ulQLGvA32g+/NZaUOJVCCLWHu3x
	 jHI4iy3tDjvQbZe+ku00EHrPmUS2MGzDE9nDk74T+fTOKmrb3FBcyzuTFZS6QtygjF
	 bxhFFUKiA8aTMIiEAOd/JcCyV41tPj4WGOZlSldmAMxO57UtFs4LYtbQN71PXW1HAt
	 OBzfDOANWrlng==
Subject: Re: [PATCH net-next v8 6/6] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Mon, 21 Sep 2026 09:35:32 +0000
Message-ID: <178998333228.2160803.11818290223147794708@kernel.org>
In-Reply-To: <20260917082236.3427168-7-kyle.switch@motor-comm.com>
References: <20260917082236.3427168-7-kyle.switch@motor-comm.com>
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
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] yt922x_pcs_config() violates the documented phylink PCS
  contract: it ignores neg_mode, advertising and permit_pause_to_mac and…
- [High] net: devm_ leak and sysfs crash in DSA .setup callback
- [Medium] The driver advertises a new device-tree compatible
  "motorcomm,yt9224" in yt921x_of_match[], but no DT binding documents…
- [Low] drivers/net/dsa/motorcomm/Kconfig: the NET_DSA_YT921X prompt is
  updated to "Motorcomm YT9215 and YT9224 ethernet switch chip support"…
- [Low] net/dsa/tag_yt922x.c defines YT922X_TAG_RX_PRIO_M (bits 15:13 of
  the received control word) but yt922x_tag_rcv() reads that same word…

--

net: dsa: motorcomm: Add support for Motorcomm YT922x

This adds YT922x (YT9224 only for now) support to the existing Motorcomm
YT921x DSA driver: a new chip info entry, a new yt92xx series entry with
its own dsa_switch_ops and phylink_mac_ops, a PCS implementation for the
internal SerDes ports, and a new "motorcomm,yt9224" OF compatible.

A few questions below.

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
right below it still says:

	  This enables support for the Motorcomm YT9215 ethernet switch
	  chip.

Should the help text mention YT9224 too?

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 2412fe2f696f8..1cf5e859d8af0 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -4694,6 +4725,637 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {

[ ... ]

> +static void
> +yt922x_phylink_mac_config(struct phylink_config *config, unsigned int mode,
> +			  const struct phylink_link_state *state)
> +{
> +}

[ ... ]

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

[Severity: High]
Is this safe on a second .setup() call?

DSA .setup() is not a once-per-device callback: the tree is torn
down and set up again whenever the conduit goes away and comes back
(dsa_tree_teardown() / dsa_tree_setup()), while the mdio_device that
owns the devm allocations stays bound the whole time. So the devm
resources taken in yt921x_mbus_int_init() (devm_mdiobus_alloc() plus
devm_of_mdiobus_register()) are only released when the mdiodev
itself unbinds, not when the switch is torn down.

That means on the second yt922x_dsa_setup() the first internal MDIO
bus is still registered, priv->mbus_int gets overwritten (leaking
the first allocation), and the of_mdiobus_register() for the new bus
hits a duplicate sysfs name for the same bus id, which fails the
re-setup and leaves the switch half-configured.

Making it worse, yt922x_dsa_switch_ops has no .teardown at all,
unlike yt921x_dsa_switch_ops which supplies yt921x_dsa_teardown(),
so there is nothing on the yt922x path that can unwind anything
allocated or registered from .setup().

How do you want to fix this? Either register the internal bus with
the plain mdiobus_alloc()/of_mdiobus_register() and drop it from a
new yt922x .teardown callback, or move the bus registration out of
.setup() into yt921x_mdio_probe(), where the devm lifetime actually
matches the device. If the yt921x path has the same issue today,
please say so and fix both consistently rather than copying the
pattern into the new ops.

[Severity: High]
Can the SerDes ports negotiate a link with this pcs_config()?

The callback only rewrites the 3-bit SERDES_MODE field of the ext register
YT922X_PORT_SDSn. neg_mode, advertising and permit_pause_to_mac are unused,
so MII_BMCR.BMCR_ANENABLE is never set or cleared and MII_ADVERTISE is
never programmed.

The kerneldoc for pcs_config in include/linux/phylink.h states:

 * When operating in %MLO_AN_INBAND, inband should always be enabled,
 * otherwise inband should be disabled.
 ...
 * For 1000BASE-X, the advertisement should be programmed into the PCS.
 ...
 * When an autonegotiation restart is required for 802.3z modes, .pcs_config()
 * should return a positive non-zero integer (e.g. 1)

Here res is 0 on the success path, so phylink never triggers the restart:

drivers/net/phy/phylink.c:phylink_change_inband_advert() {
	ret = phylink_pcs_config(pl->pcs, pl->pcs_neg_mode, &pl->link_config,
				 !!(pl->link_config.pause & MLO_PAUSE_AN));
	if (ret < 0)
		return ret;

	if (ret > 0)
		phylink_pcs_an_restart(pl);
}

which means an ethtool advertisement change never reaches
yt922x_pcs_an_restart(), and yt922x_pcs_an_restart() itself only sets
BMCR_ANRESTART, so it cannot enable in-band AN either.

Meanwhile yt922x_pcs_get_state() hands MII_LPA to
phylink_mii_c22_pcs_decode_state() (and phylink_decode_usxgmii_word() for
USXGMII) as if it were a completed negotiation word, and
yt922x_phylink_mac_link_up() -> yt922x_port_up() then force-writes that
speed/duplex/pause into YT922X_PORTn_CTRL. Since
yt922x_phylink_mac_config() is empty, nothing else applies the interface
change either.

Is there also anything that resets or re-times the SerDes when the mode
changes between rates (SGMII 1.25G, 2500BASEX 3.125G, USXGMII 10.3125G)?

For YT9224 external_mask is BIT(0) | BIT(8), so this affects the ports that
normally carry the CPU link.

[ ... ]

> +static enum dsa_tag_protocol
> +yt922x_dsa_get_tag_protocol(struct dsa_switch *ds, int port,
> +			    enum dsa_tag_protocol m)
> +{
> +	return DSA_TAG_PROTO_YT922X;
> +}

[Severity: Low]
On the tagger added earlier in this series (net/dsa/tag_yt922x.c), is
YT922X_TAG_RX_PRIO_M used anywhere? yt922x_tag_rcv() reads the same control
word only for the source port:

	rx = ntohs(tag[2]);
	port = FIELD_GET(YT922X_TAG_RX_PORT_M, rx);
	skb->dev = dsa_conduit_find_user(netdev, 0, port);

while the sibling yt921x_tag_rcv() does:

	skb->priority = FIELD_GET(YT921X_TAG_RX_PRIO_M, rx);

Was the skb->priority assignment meant to be there as well, or should the
unused macro be dropped?

[ ... ]

> @@ -4825,8 +5501,9 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
>  }
>  
>  static const struct of_device_id yt921x_of_match[] = {
> -	{ .compatible = "motorcomm,yt9215" },
> -	{}
> +	{ .compatible = "motorcomm,yt9215", },
> +	{ .compatible = "motorcomm,yt9224", },
> +	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, yt921x_of_match);

[Severity: Medium]
Should this series also update the binding? The only Motorcomm DSA schema in
the tree, Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml,
still has:

properties:
  compatible:
    const: motorcomm,yt9215

so a node with compatible = "motorcomm,yt9224" is matched by the driver but
rejected by dt_binding_check/dtbs_check.

The binding prose also disagrees with the topology added here. The schema
describes "up to 8 internal GbE PHYs and up to 2 GMACs" with "PHY 0-7 are
used for Port 0-7 respectively", while the new chip info entry is:

	{
		"YT9224", YT9224_MAJOR, 0, 0,
		YT922X_PORT_MASK_INTm_n(4, 7),
		YT922X_PORT_MASK_EXT0 | YT922X_PORT_MASK_EXT1,
	},

i.e. internal PHYs on ports 4-7 and SerDes on ports 0 and 8, with
YT922X_PORT_NUM = 9 (no port 9). Following the current binding text, would a
device tree author end up describing ports the driver cannot drive?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917082236.3427168-1-kyle.switch%40motor-comm.com
