Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C9D4A8425;
	Tue,  6 Oct 2026 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312260; cv=none; b=ZygH80++QNM+9jm8iygmQjWpqN2MJqXNwYcC+JyRqUys2UIL7pqhtjKppN91/eDXF0nKwCCizPuizSJvPKCdhr8ryIzFhgGCe75xCfLv33ojQJD+eVnje5dGMVxiKaUqT1eAAj44pT2ENAkhL6dBWfp52cBxnP04QRhs76BbnV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312260; c=relaxed/simple;
	bh=FsQoQXZrv690gQsd/gBQOkfLe8j2rFpjMfRq3d3GDeQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UtwDbUq/kBe0QC2IpfRL0cK5AdCwfVLMy1whi99y8tYd0Z4jTUxhE++OQxVQ3s11MSJ2cg/bhNZKp6ceNzsZVLJPq57yMHZuD40l3H7tRq6QiDx4m3tI0dEcQw4F/MJX/I38Moj/aevIusIXQ6pl0yM+pn+s8KcXqaioC4kR7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHNYRdoH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHNYRdoH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0D51F0089B;
	Tue,  6 Oct 2026 18:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791312253;
	bh=nYj/ESZsZF0coe3gu0gqyHdAF8i+nS3OIBet9BgYlCE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gHNYRdoHBPr3PWdM+kOBrCDALMbcULUzNjHh99lySvz6Lw0QJbmObRU9MvljDWfHJ
	 Op4ZkhMkXfCa7weD2hFIVOXNY3suEBT1mom3+cVZsF9FnKUHnKDNWFCGaa/gQSYQug
	 f13jCZqRt+DdfVWo5PhNdWdXyeUfl43Ctk+LbKJLRuLnh/aBxuOpUdNvkA45qD28id
	 JEsETLH4vp7CDwt0oOa0TMA7Df0zum4KEL5h/G+pMvcpTdX0Msn6cVoWJ76CcbTYbD
	 fMmPpRZXBauFlViEwfqb7QLPhyA8V57gn/1CapPdGwevVysphDHlOqOj4mSt/1lcbE
	 uk/g+kNEWIHSw==
Subject: Re: [PATCH net-next v11 7/7] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Tue, 06 Oct 2026 18:44:12 +0000
Message-ID: <179131225201.434549.15841674446482506051@kernel.org>
In-Reply-To: <20261002173706.1225502-8-kyle.switch@motor-comm.com>
References: <20261002173706.1225502-8-kyle.switch@motor-comm.com>
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

Critical: 0 · High: 0 · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The driver's YT922x port map contradicts itself, so the
  YT9224's second SerDes port (port 9) cannot be used.
- [Medium] The patch adds compatible "motorcomm,yt9224" to
  yt921x_of_match[], but the DT binding is not updated.
- [Medium] The 5 Gb/s capability that YT922x SerDes ports advertise does
  not work: the MAC is never brought up at 5G.
- [Medium] yt922x_pcs_config() (pcs-922x.c:110-161) does not meet the
  phylink pcs_config contract.
- [Low] yt92xx_register_switch() declares `u32 chipid;` with no
  initializer.
- [Low] yt921x_dsa_teardown() does not compile with
  CONFIG_NET_DSA_YT921X_LEDS=n.

--

net: dsa: motorcomm: Add support for Motorcomm YT922x

This patch adds basic DSA support for the Motorcomm YT9224 switch to the
existing yt921x driver. It adds a YT922x series descriptor with its own
dsa_switch_ops and phylink_mac_ops, a new SerDes PCS implementation in
pcs-922x.c, and a "motorcomm,yt9224" compatible.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 9380d74d79ba2..175855cbc2375 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -141,6 +141,18 @@ static const struct yt921x_info yt921x_infos[] = {
>  		BIT(8) | BIT(9),
>  		BIT(8) | BIT(9),
>  	},
> +	{
> +		"YT9224", YT9224_MAJOR, 0, 0,
> +		GENMASK_U16(7, 4),
> +		0,
> +		BIT(8) | BIT(9),
> +	},

[Severity: Medium]
This entry marks port 9 as a SerDes port on YT9224. The YT922x series,
however, uses max_ports = YT922X_PORT_NUM, which is 9, and
yt92xx_register_switch() copies that into ds->num_ports. Can port 9
actually be used?

With ds->num_ports == 9, dsa_switch_parse_ports_of() rejects a DT node
for ethernet-port@9:

net/dsa/dsa.c:dsa_switch_parse_ports_of() {
    ...
	if (reg >= ds->num_ports) {
    ...
}

A board that wires the second SerDes (for example as the CPU port)
would then fail to probe with -EINVAL.

The rest of the new code also seems to assume 9 ports:

  yt922x_pcs_setup() loops with for_each_set_bit(port, &mask,
  priv->series->max_ports), so the PCS for port 9 is never set up.

  yt922x_chip_setup_dsa() writes GENMASK_U32(8, 0) to
  YT922X_FILTER_UNK_UCAST. It also builds the unknown ucast/mcast
  action word only for ports 0..8.

  YT922X_COMMON_EXT_PHYADDR is 9, and yt922x_sds_phyaddr_get() uses the
  port index as the SerDes MII address. A port 9 PCS would therefore
  use the same address as the common ext block.

The new tag_yt922x.c tagger, on the other hand, encodes destination
ports 1..9 in tag[1] bits 8:0 and port 0 in tag[2] BIT(15). That
describes a 10 port device.

Is either serdes_mask here or YT922X_PORT_NUM wrong?

[ ... ]

> @@ -3932,6 +3944,11 @@ static void yt921x_dsa_teardown(struct dsa_switch *ds)
>  	}
>  }
>  
> +static bool yt921x_needs_extmode_check(u32 major)
> +{
> +	return (major == YT9224_MAJOR) ? false : true;
> +}
> +

[Severity: Low]
This comes from an earlier patch in the series rather than this one.
Does yt921x_dsa_teardown(), just above, still build with
CONFIG_NET_DSA_YT921X_LEDS=n?

drivers/net/dsa/motorcomm/chip.c:yt921x_dsa_teardown() {
#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
	struct yt921x_priv *priv = to_yt921x_priv(ds);

	yt921x_leds_remove(priv);
#endif

	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
    ...
}

priv is declared only inside the #if block, but the loop after the
#endif uses it. NET_DSA_YT921X_LEDS is a user visible bool that depends
on LEDS_CLASS=y || LEDS_CLASS=NET_DSA_YT921X. With LEDS_CLASS=n, or
with LEDS_CLASS=m and NET_DSA_YT921X=y, the build would fail because
priv is undeclared.

The breakage was introduced by "net: dsa: motorcomm: move mib stop from
remove() to teardown()" earlier in the series. It is still there after
this patch, which also edits the driver's Kconfig entry.

[ ... ]

> @@ -4411,6 +4439,412 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {

[ ... ]

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

[Severity: Medium]
What happens here when phylink resolves SPEED_5000?

yt922x_dsa_phylink_get_caps() advertises USXGMII and MAC_5000FD for
every SerDes port. However, ethtool_speed_to_yt921x() has no
SPEED_5000 case:

drivers/net/dsa/motorcomm/chip.h:ethtool_speed_to_yt921x() {
	...
	case SPEED_2500:
		return YT921X_SPEED_2500;
	case SPEED_10000:
		return YT921X_SPEED_10000;
	default:
		return YT921X_SPEED_INVALID;
	}
}

YT921X_SPEED_INVALID is 5. That is the same value as the new
YT922X_PORT_SPEED_5000, which is defined but never used.

So with a 5G USXGMII link (for example yt922x_pcs_get_state() ->
phylink_decode_usxgmii_word() with MDIO_USXGMII_5000), yt922x_port_up()
returns -EINVAL before it writes YT922X_PORTn_CTRL, and en_phy is never
re-enabled.

yt922x_phylink_mac_link_up() only logs the error, and phylink_link_up()
still calls netif_carrier_on() afterwards. Would the port then report
carrier up while passing no traffic?

[ ... ]

> @@ -4423,12 +4857,25 @@ static const struct yt92xx_series yt92xx_series_table[] = {

[ ... ]

>  static const struct yt92xx_series *yt92xx_series_lookup(u32 major)
>  {
>  	if (major == YT9215_MAJOR || major == YT9218_MAJOR)
>  		return &yt92xx_series_table[YT92XX_MODE_YT921X];
> +	else if (major == YT9224_MAJOR)
> +		return &yt92xx_series_table[YT92XX_MODE_YT922X];
>  	else
>  		return NULL;
>  }

[Severity: Low]
This patch relies on yt92xx_register_switch(), the caller of this
lookup, to pick the YT922x series. Can its error path print an
uninitialized chipid?

drivers/net/dsa/motorcomm/chip.c:yt92xx_register_switch() {
    ...
	u32 chipid;
    ...
	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
	mutex_unlock(&priv->reg_lock);
	if (res) {
		dev_err(dev, "Unexpected chipid 0x%x\n", chipid);
		return res;
	}
    ...
}

The read can fail before *valp is written. For example,
yt921x_reg_mdio_read() bails out after an MDIO write error. In that case
chipid is still uninitialized stack memory when it is printed. The
message also says "Unexpected chipid" when the read itself failed.

This was introduced earlier in the series by "net: dsa: motorcomm:
initialize dsa_switch based on chipid".

[ ... ]

> @@ -4547,6 +4994,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
>  
>  static const struct of_device_id yt921x_of_match[] = {
>  	{ .compatible = "motorcomm,yt9215" },
> +	{ .compatible = "motorcomm,yt9224" },
>  	{}
>  };

[Severity: Medium]
Should the DT binding be updated along with this new compatible?

Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml still
has:

  compatible:
    const: motorcomm,yt9215

together with unevaluatedProperties: false. No binding under
Documentation/devicetree/bindings mentions yt9224.

The binding's description, port list and mdio text also cover only the
YT921x parts. The YT9224 layout is not documented: internal PHYs on
ports 4-7, SerDes on ports 8 and 9, and no xMII.

A DTS that uses "motorcomm,yt9224" would fail dt_binding_check, and
checkpatch would flag the compatible as undocumented.

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/pcs-922x.c b/drivers/net/dsa/motorcomm/pcs-922x.c
> new file mode 100644
> index 0000000000000..98d403d01ba3c
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/pcs-922x.c
> @@ -0,0 +1,173 @@

[ ... ]

> +static int yt922x_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> +			     phy_interface_t interface,
> +			     const unsigned long *advertising,
> +			     bool permit_pause_to_mac)
> +{

[ ... ]

> +	/* write protect */
> +	res = yt921x_intif_ext_write(priv, addr, 0x4be, 0xd);
> +	if (res)
> +		goto err;
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +		ctrl = YT922X_SERDES_MODE_SGMII;
> +		break;

[ ... ]

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

[ ... ]

> +const struct phylink_pcs_ops yt922x_phylink_pcs_ops = {
> +	.pcs_get_state = yt922x_pcs_get_state,
> +	.pcs_config = yt922x_pcs_config,
> +	.pcs_an_restart = yt922x_pcs_an_restart,
> +};

[Severity: Medium]
Does yt922x_pcs_config() need to handle neg_mode and advertising?

It only rewrites the YT922X_SERDES_MODE field. neg_mode, advertising
and permit_pause_to_mac are unused. BMCR_ANENABLE is never set or
cleared, and MII_ADVERTISE is never written for 1000BASE-X or
2500BASE-X.

The pcs_config kernel-doc in include/linux/phylink.h says:

 * When operating in %MLO_AN_INBAND, inband should always be enabled,
 * otherwise inband should be disabled.
 ...
 * For 1000BASE-X, the advertisement should be programmed into the PCS.

The sibling yt921x_serdes_config() in pcs-921x.c does this explicitly:

	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
		bmcr |= BMCR_ANENABLE;
	else
		bmcr &= ~BMCR_ANENABLE;

Without that, the PCS keeps whatever in-band AN state it had after
reset. In-band links may then fail to come up, and out-of-band or fixed
links may run with AN enabled.

yt922x_pcs_config() also returns 0 without programming the
advertisement. phylink_change_inband_advert() then never restarts AN,
so advertisement changes made through ethtool are silently dropped.

yt922x_phylink_pcs_ops has no pcs_inband_caps, pcs_link_up, pcs_enable
or pcs_disable. yt922x_port_up() only writes the MAC side
YT922X_PORTn_CTRL. Is anything forcing the SerDes speed for
out-of-band SGMII at 10/100M?

The 0x4be = 0xd write also happens before the interface is checked. For
an unsupported interface the function returns -EINVAL with that write
left in place, and the write is never undone. Should it be moved after
the switch on interface?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002173706.1225502-1-kyle.switch%40motor-comm.com
