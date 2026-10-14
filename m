Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27E432B102;
	Wed, 14 Oct 2026 01:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791943174; cv=none; b=h1YnwV0rnzo2k9Xc9NuTTxBDEIbSHX1m+z6SC9bkz/VEWetqtwF5t+03mrXZ7/efl8hYQ4XOwAtDQKxS7f9xSBQVMs3l12SinNzhFzMpqesRMuDLHkbX3+q3swA6QfjCYoBbn+GQN+EkAzfqgFGOMSZRlqohCikChHcliXbR1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791943174; c=relaxed/simple;
	bh=vbrzVzE3aNnrJoOCYB3Pwqg7ZGE3ZQBTgY30PTcEU24=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LyUFdliTjJLI9yrSuPiP6ZDKSN6GJlVWJn7pk/B5HrzV1ADOTmuvKIJlVUda7mvT+E9jEQCvluvYXG3wJHZ/E/EowvUcJdvJW4j7BEP68jbI7lTJD/nNtbz8Qsyr3RPiMxPBOSpFUaHCfJJmR7HGRxD2YEDnvIKBA6VRnGkSuDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+PdYQj6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+PdYQj6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D431F00893;
	Wed, 14 Oct 2026 01:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791943169;
	bh=zFDf30rfu02U2sIfyJdv1QUqsJIm0erb/Pbz58veJ/Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B+PdYQj6z7j6zob8KOugkgoIur/JE13cBK0gsS8ZVXOmETC+AdSMYLLJwAv61Qx3g
	 46a+nY+4bScarWF1XHiGLPAhbIe55ud/ids+diElCtu1KsyTzC3JH2zStfDbCzeK8r
	 1kfzNjMexxX88h5xUV6jnQmTpHVpFH5R4lg50WxxjgyVGSUOBDexP7xpNbwIK/BUJi
	 QT9qEaqJjBzfPnmHC282G4OsB+6jIMcXZW/usGfyo4AiNfGHIS2sHMIrGVd3tyAJX0
	 ViF2xPWVXd9ofBGII59NKEof090wMaLVB7x6vvBHcDX1ACDHO4fbkngNClxwH7cL22
	 YQActuvTRa/cw==
Subject: Re: [PATCH net-next v14 5/5] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Wed, 14 Oct 2026 01:59:28 +0000
Message-ID: <179194316804.434549.2445810560010060057@kernel.org>
In-Reply-To: <20261013011122.1889766-6-kyle.switch@motor-comm.com>
References: <20261013011122.1889766-6-kyle.switch@motor-comm.com>
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

Critical: 0 · High: 1 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: dsa: motorcomm: port control register clobbered in
  yt922x_port_up due to missing read
- [Medium] The new "YT9228" entry in yt921x_infos can never be selected.
- [Medium] The patch adds { .compatible = "motorcomm,yt9224" } to
  yt921x_of_match, but the only binding for this driver,…
- [Medium] yt922x_pcs_config() accepts neg_mode, advertising and
  permit_pause_to_mac but uses none of them.
- [Low] yt922x_port_down() and yt922x_port_up() each run several separate
  register transactions: the PORTn_CTRL MAC/link bits, then FORCE_OP,…

--

net: dsa: motorcomm: Add support for Motorcomm YT922x

This commit adds YT922x series support to the existing YT921x DSA driver.
It adds a new series table entry, phylink MAC ops, a SerDes PCS
implementation in pcs-922x.c and a "motorcomm,yt9224" compatible. The
commit message says only the YT9224 variant is supported for now.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index ba988e121d68e..f0488fac90976 100644
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

[ ... ]

> @@ -3631,6 +3648,14 @@ static int yt921x_chip_detect(struct yt921x_priv *priv)
>  		return -ENODEV;
>  	}
>  
> +	if (!yt921x_needs_extmode_check(major)) {
> +		dev_info(dev,
> +			 "Motorcomm %s ethernet switch, chipid: 0x%x\n",
> +			 info->name, chipid);
> +		priv->info = info;
> +		return 0;
> +	}

[Severity: Medium]
Can the YT9228 entry in yt921x_infos[] ever be selected?

Both new entries use YT9224_MAJOR with mode 0 and extmode 0. The lookup
loop in yt921x_chip_detect() stops at the first entry whose major matches:

	for (info = yt921x_infos; info->name; info++)
		if (info->major == major)
			break;

For major 0x9004 that is always "YT9224". The new early return then uses
that entry without checking mode or extmode, and the two entries have the
same values for those anyway.

The commit message says:

    YT9228 is not supported yet.

If a YT9228 reports this major, as the table says it does, wouldn't it
bind instead of failing with -ENODEV? yt92xx_series_lookup() also sends
every 0x9004 chip to the YT922x series, and the chip would be logged as
"Motorcomm YT9224 ...".

It would also get the YT9224 serdes_mask. In that case,
yt922x_dsa_phylink_get_caps() and yt922x_pcs_setup() leave ports 1-3 with
no supported interfaces and no PCS. phylink_create() would then fail for
those ports, and DSA would quietly treat them as unused. Is that intended?

[ ... ]

> +static int
> +yt922x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
> +	       phy_interface_t interface, int speed, int duplex,
> +	       bool tx_pause, bool rx_pause)
> +{

[ ... ]

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

[Severity: High]
Is this meant to be a read-modify-write of YT922X_PORTn_CTRL?

ctrl starts at 0. Only the speed, duplex, pause and MAC/CFG enable
bits are ORed into it, so clearing YT922X_PORT_FC_AN and
YT922X_PORT_LINK_AN afterwards does nothing. That clear only makes
sense if ctrl was supposed to hold the current register contents
first.

As written, yt921x_reg_write() replaces the whole register on every
link up. Any field not set here is forced to zero each time phylink
calls yt922x_phylink_mac_link_up(). That includes
YT922X_PORT_HALF_PAUSE and any reserved or vendor-default bits above
YT922X_PORT_FORCE_OP. Is that safe on this hardware?

If a full write is really intended, the dead clear could be dropped
and the register layout documented. Otherwise, should this use
yt921x_reg_update_bits() with a mask covering only the fields being
programmed? That would mean speed, duplex, pause, the MAC/CFG enables
and the AN bits, in the same way that yt922x_port_down() only touches
the bits it cares about via yt921x_reg_clear_bits().

[Severity: Low]
This is minor, but what state is the port left in if the
YT922X_EN_PHY_VALUE update fails after FORCE_OP has already applied the
forced MAC link-up?

The MAC would stay forced up while the PHY-enable override from the
previous yt922x_port_down() stays forced low. yt922x_phylink_mac_link_up()
only logs the error. yt922x_port_down() has the same structure, with no
rollback of earlier steps.

This copies the existing yt921x_port_up() and yt921x_port_down() pattern.
It can only happen once SMI/MDIO access is already failing.

[ ... ]

> @@ -4220,6 +4655,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
>  
>  static const struct of_device_id yt921x_of_match[] = {
>  	{ .compatible = "motorcomm,yt9215" },
> +	{ .compatible = "motorcomm,yt9224" },
>  	{}
>  };

[Severity: Medium]
Should this come with a binding update? The binding in
Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml still
only has:

  compatible:
    const: motorcomm,yt9215

With that binding, any DTS using "motorcomm,yt9224" would fail dt-schema
validation, and checkpatch would report the compatible as undocumented.

The binding text also covers YT921x port layouts only. Its mdio
description says:

      Internal MDIO bus for the internal GbE PHYs. PHY 0-7 are used for Port
      0-7 respectively.

The new info table gives YT9224 internal PHYs only on ports 4-7, and
SerDes on ports 0 and 8.

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

[Severity: Medium]
yt922x_pcs_config() never uses neg_mode, advertising or
permit_pause_to_mac. Apart from the 0xd write to ext reg 0x4be, it only
rewrites the SerDes mode field. Is that enough to meet the pcs_config
contract?

The pcs_config kernel-doc in include/linux/phylink.h says in-band should
be enabled in MLO_AN_INBAND and disabled otherwise. It also says the
1000BASE-X advertisement should be programmed into the PCS. pcs-921x.c
does this with phylink_mii_c22_pcs_encode_advertisement() and
BMCR_ANENABLE handling.

Here, in-band-enabled and in-band-disabled requests produce the same
register writes. Depending on the reset default, won't one of them leave
the hardware AN state wrong? For example, a fixed-link 2500BASE-X CPU port
could be left with AN enabled, or an in-band SGMII PHY link with AN
disabled.

phylink_change_inband_advert() also relies on pcs_config() to apply
advertisement and pause changes:

	ret = phylink_pcs_config(pl->pcs, pl->pcs_neg_mode, &pl->link_config,
				 !!(pl->link_config.pause & MLO_PAUSE_AN));
	if (ret < 0)
		return ret;

	if (ret > 0)
		phylink_pcs_an_restart(pl);

Since this always returns 0 and never writes MII_ADVERTISE, wouldn't
ethtool advertisement or pause changes be silently dropped?

yt922x_pcs_get_state() also decodes BMSR/LPA as if in-band AN had been
configured. yt922x_pcs_an_restart() sets BMCR_ANRESTART even though AN was
never configured.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013011122.1889766-1-kyle.switch%40motor-comm.com
