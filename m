Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17EA525A9B;
	Thu, 17 Sep 2026 13:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651353; cv=none; b=nzjSuorA4BCV4S2NvON7gEOjQ8V/S/dtmuo1aAvTiX2ve/QC/TIIw+HzZI4+0bWF6RrHT3WV2KOenunp2cxSGjHk0T6zxYcNKrQEW6ZsGzE9G6//f3CIaut00wailDEKjFMu+qtGlYLr5ct1Dz/Np/yf5CnuwCs/b9IhYRxo2ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651353; c=relaxed/simple;
	bh=bw4RiRytlAwgOjIBaeY17eG61L3UbiiEJNb7PryUON4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DCRtJMP3fCThtPo5pgf5nSxvyho8SjbwhD6+F4OOcpXTgz6Lu0im1LV4JQek5neGmglD24Hb3TGnYivPvH7Oin4jz6evjJtVVmQLXQQLscjNdEVG9Ip6eYGf3dB1/Ps7CNFZV+A8tfLZTGlUZgOy57uDpV2VGLcvPjg1WhWCDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tm/bLTAU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tm/bLTAU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D111F000FF;
	Thu, 17 Sep 2026 13:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789651350;
	bh=OvJeLdnFA9iA40KSTwKxccMcCwgK1FzuetzacI77lGE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Tm/bLTAUEUIEpmjHp7ziVORAz/hTWkLmVVpU+vM7RCwFs4HAgMysjeepglSHWTCZv
	 APcFhfCNpvIWRNBw2fcwu0dwmXZbhRStwbN/OqiruolYOZEHCZ1wyvn/S9pxfrKYdi
	 3ixFf5wESvnvZ3umdFwPrBLHh7cpehLrM3XdUbfOoelN6CHJPntXw7tuK+R+fwu5Q0
	 yb4bBCEDD5Qe0rujU18ONcRNcxM4nRa9MdP+YwEInq2ywYOVMNklDRmMML6lURTYNP
	 ot2lkqDPRoso17Sgit2lfkDYnRakWaQnn1fMIvuWEjmfdutFvXIluXXDIwlyCaD8rK
	 /9fQ9xCG/zXGA==
Subject: Re: [PATCH net-next v15 3/4] net: dsa: microchip: Support Microchip
 KSZ8995XA / KS8995XA
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Thu, 17 Sep 2026 13:22:28 +0000
Message-ID: <178965134899.22033.3037968040082683737@kernel.org>
In-Reply-To: <20260916-ks8995-to-ksz8-v15-3-8825ff5fd4be@kernel.org>
References: <20260916-ks8995-to-ksz8-v15-3-8825ff5fd4be@kernel.org>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 4 (2)

- [Medium] ksz8995xa_change_mtu() (drivers/net/dsa/microchip/ksz8.c:301)
  programs the hardware legal-packet-size limit from frame_size = mtu +…
- [Low] After this patch (and the final patch of the series, which
  deletes drivers/net/dsa/ks8995.c entirely),…
- [Low] Concern (validated as FALSE POSITIVE / disclosed later in
  series): the Kconfig exclusivity silently re-routes the existing…
- [Low] Concern (validated as FALSE POSITIVE): the new `{ "ks8995" }` and
  `{ "ksz8995xa" }` entries in ksz_spi_ids[] advertise SPI-ID (non-…
- [Low] Concern (validated as FALSE POSITIVE): the new KSZ8995XA branch
  of ksz8_reset_switch() writes PORT_PHY_SOFT_RESET to REG_PORT_STATUS_3…

Pre-existing issues:
- [Medium] Concern (validated as a real but pre-existing Medium defect,
  below the reporting threshold): ksz_init_global_dscp_map() in…
- [Low] Concern (validated as FALSE POSITIVE): the new KSZ8995XA special-
  tag programming (ksz_pwrite16(REG_PORT_CTRL_VID, 0) and…
- [Low] Concern (validated as FALSE POSITIVE): in
  ksz8_flush_dyn_mac_table() the new KSZ8995XA sequence sets…

--

net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA

This adds KSZ8995XA (Micrel KS8995XA) support to the KSZ DSA driver, with a
restricted set of dev/switch ops, per-port PHY reset polling, header special
tag setup and DCB helper changes for the chip's eight one-bit TOS priority
registers. It also moves the legacy "micrel,ks8995", "micrel,ksz8795" and
"micrel,ksz8864" compatibles over to the KSZ SPI driver and makes
NET_DSA_KS8995 and NET_DSA_MICROCHIP_KSZ_SPI mutually exclusive in Kconfig.

A few questions below.

> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index 941ae9f66f70b..d7498132064e8 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c

[ ... ]

> @@ -269,6 +299,31 @@ static int ksz8_reset_switch(struct ksz_device *dev)
>  	return 0;
>  }
>  
> +static int ksz8995xa_change_mtu(struct dsa_switch *ds, int port, int mtu)
> +{
> +	struct ksz_device *dev = ds->priv;
> +	int frame_size;
> +	u8 ctrl2 = 0;
> +
> +	if (!dsa_is_cpu_port(dev->ds, port))
> +		return 0;
> +
> +	frame_size = mtu + VLAN_ETH_HLEN + ETH_FCS_LEN;
> +
> +	/* The legal packet size bit polarity documented in the KSZ8995XA
> +	 * manual appears to be wrong. Practical tests show that the same
> +	 * semantics as the other switches are correct; using the documented
> +	 * polarity makes the switch hang on big packets.
> +	 */
> +	if (frame_size <= KSZ8995XA_LEGAL_PACKET_SIZE)
> +		ctrl2 |= KSZ8863_LEGAL_PACKET_ENABLE;
> +	else if (frame_size > KSZ8863_NORMAL_PACKET_SIZE)
> +		ctrl2 |= KSZ8863_HUGE_PACKET_ENABLE;
> +
> +	return ksz_rmw8(dev, REG_SW_CTRL_2, KSZ8863_LEGAL_PACKET_ENABLE |
> +			KSZ8863_HUGE_PACKET_ENABLE, ctrl2);
> +}
> +

[Severity: Medium]

Does frame_size here need to account for the 4-byte KS8995 special tag as
well?

ksz8995xa_change_mtu() computes:

	frame_size = mtu + VLAN_ETH_HLEN + ETH_FCS_LEN;

which allows room for exactly one VLAN header. But ks8995_xmit() in
net/dsa/tag_ks8995.c always inserts an additional outer tag:

	skb = vlan_insert_tag(skb, KS8995M_STPID(portmask), 0);

so a full-size 802.1Q frame injected by the CPU is 14 + 4 (special tag) +
4 (customer VLAN) + 1500 + 4 (FCS) = 1526 bytes on the wire at the CPU
port.

At the default MTU of 1500 the computation above yields exactly 1522,
which equals KSZ8995XA_LEGAL_PACKET_SIZE, so KSZ8863_LEGAL_PACKET_ENABLE
is set and the switch is told to enforce 1522.

DSA does not compensate either: in dsa_user_change_mtu() the CPU port gets
the bare user MTU, and only the conduit MTU gets the tag overhead added:

	cpu_mtu = largest_mtu;
	...
	err = dsa_port_mtu_change(cpu_dp, cpu_mtu);

Can this make the switch drop full-size VLAN-tagged frames coming from the
CPU?

The same allowance question applies to .port_max_mtu, since
ksz8995xa_switch_ops reuses ksz88xx_max_mtu(), which returns
KSZ8863_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN and therefore also
leaves no room for the special tag at the largest configurable MTU.

[ ... ]

> diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
> index 7131c5caac547..aa0260f07252e 100644
> --- a/drivers/net/dsa/microchip/ksz_dcb.c
> +++ b/drivers/net/dsa/microchip/ksz_dcb.c

[ ... ]

> @@ -283,15 +299,12 @@ int ksz_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
>   */
>  static int ksz_set_global_dscp_entry(struct ksz_device *dev, u8 dscp, u8 ipm)
>  {
> -	int reg, per_reg, shift;
> +	int reg, shift;
>  	u8 mask;
>  
> -	ksz_get_dscp_prio_reg(dev, &reg, &per_reg, &mask);
> +	ksz_get_dscp_prio_reg(dev, dscp, &reg, &mask, &shift);
>  
> -	shift = (dscp % per_reg) * (8 / per_reg);
> -
> -	return ksz_rmw8(dev, reg + (dscp / per_reg), mask << shift,
> -			ipm << shift);
> +	return ksz_rmw8(dev, reg, mask << shift, ipm << shift);
>  }

[Severity: Medium]

This is a pre-existing issue and not introduced by this patch, but since
this helper now also drives the new KSZ8995XA one-bit-per-DSCP register
layout, is the error return still being dropped by its only caller?

In ksz_init_global_dscp_map() the result is assigned and then discarded:

		ret = ksz_set_global_dscp_entry(dev, dscp, ipm);
	}

	return 0;
}

So a regmap failure while programming any of the 64 DSCP entries leaves the
table partially programmed while ksz8_setup() -> ksz_dcb_init() still
reports success. Would returning ret on failure be preferable?

[ ... ]

> diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
> index 373e9054947cb..e3bb9e604186d 100644
> --- a/drivers/net/dsa/microchip/ksz_spi.c
> +++ b/drivers/net/dsa/microchip/ksz_spi.c

[ ... ]

> @@ -224,6 +228,25 @@ static void ksz_spi_shutdown(struct spi_device *spi)
>  }
>  
>  static const struct of_device_id ksz_dt_ids[] = {
> +	/*
> +	 * Legacy Micrel bindings. In 2015 Microchip acquired
> +	 * Micrel which is the originator of the KSZ series, and
> +	 * devices branded for Micrel already existed, as well as
> +	 * some device tree bindings. These two products are identical
> +	 * to the same Microchip products.
> +	 */
> +	{
> +		.compatible = "micrel,ksz8864",
> +		.data = &ksz_switch_chips[KSZ8864]
> +	},
> +	{
> +		.compatible = "micrel,ksz8795",
> +		.data = &ksz_switch_chips[KSZ8795]
> +	},
> +	{
> +		.compatible = "micrel,ks8995",
> +		.data = &ksz_switch_chips[KSZ8995XA]
> +	},

[Severity: Low]

Should the bindings be updated for these three compatibles as well?

After this patch (and after the last patch of the series removes
drivers/net/dsa/ks8995.c), the KSZ driver is the only implementation of
"micrel,ks8995", "micrel,ksz8795" and "micrel,ksz8864", but the schema that
covers them is still
Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml, which defines
only compatible, reg and reset-gpios plus the dsa.yaml and
spi-peripheral-props references, and ends with:

  unevaluatedProperties: false

The KSZ implementation, on the other hand, reads several more properties for
whatever it matches, in ksz_switch_register():

	dev->synclko_125 = of_property_read_bool(dev->dev->of_node,
						 "microchip,synclko-125");
	dev->wakeup_source = of_property_read_bool(dev->dev->of_node,
						   "wakeup-source");

plus interrupts, an mdio child node, micrel,fiber-mode,
microchip,synclko-disable, microchip,pme-active-high and the three
microchip,*-drive-strength-microamp properties handled by
ksz8_parse_drive_strength(), which ksz8_setup() calls unconditionally.

Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml documents all of
those and already lists microchip,ksz8995xa, but it does not enumerate the
three micrel strings, and micrel,ks8995.yaml does not $ref it. So a device
tree using compatible = "micrel,ks8995" together with, say, interrupts or
microchip,synclko-125 is rejected by dt_binding_check even though the driver
honours it. The two in-tree device trees
(intel-ixp42x-actiontec-mi424wr.dtsi and intel-ixp42x-linksys-wrv54g.dts)
only use compatible/reg/spi-max-frequency/ethernet-ports, so nothing in tree
fails validation today.

Verified at the end of the series as well: micrel,ks8995.yaml is unchanged
and microchip,ksz.yaml's compatible enum still lacks the micrel strings.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ks8995-to-ksz8-v15-0-8825ff5fd4be%40kernel.org
