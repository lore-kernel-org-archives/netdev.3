Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9191F8755;
	Tue,  8 Sep 2026 03:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788839391; cv=none; b=U4cyvSmsk/sZrF8LcxO3ECMy+JhmaRVSMWapbuN4c3sbmg0xbwpxq/GdO/UqlginqtiKUCb4WojC5X1NXzNQka7pMWFYqrc3uNlDLoRhoLwkB/ZmA7D4+vjWV/3Fv1KM0egpv3eLWtJI4bfIgfFyD3PX4/NK16KRf8QK4yKKtbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788839391; c=relaxed/simple;
	bh=sGR1Gu5iwje3TBWUznuu5syp3/Y9LMYYiqGtEwAry/Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U++PthNXgOMAHL9QnWkvL1aBkC/StJQHKrhBt1IKN2YHrKYQitbWAL4S23vH06cpwwwHQghO5KcN1JQKSoL+3nHNQYPkc8el5m1TK4sdY4RXj3x4gmOcEpQJL057ZJv1zxsGJibPpRTu+QQITzAAK3Xd8lehoZHCT/VPsoVgF9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Twaek6w7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Twaek6w7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394921F00A3E;
	Tue,  8 Sep 2026 03:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788839387;
	bh=GQhY6Jtw+ORcrf/pi5HKqntdkIpzlaubgkFQ4MC5nYM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Twaek6w7QypzgGLMV5ApGnfy9fuq7Y8zgHqVkah2KTbHBFLd760X51hNJdvmJT0gw
	 oRZrIOdKTcBpuWy/3KeDvNEqhmKHI+pkwY4ktyKB4DIN+Ye2c7E7/j2V4U1C1mjTBm
	 ose+q6y3zJ2IjJlzNCkJtnHO9Or5IKZs7dHIwWmZ2V05gwah/HtarteiGo8OZiwjv2
	 aJX1srKtVlimuOs4NrwOt64l9uQp4s1w+Ysbg4YMHzjm1EMmbC4lyA8W2sdgpa5bMy
	 pKLySB9UVgfOZ6iDTbxxTXTC82YaRt0e7VC62jad8L8kRJTgdoNSNT6u2dMT/7z2HN
	 Ts7GZwvhUYc0A==
Subject: Re: [PATCH net-next v9 3/4] net: dsa: microchip: Support Microchip
 KSZ8995XA / KS8995XA
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 08 Sep 2026 03:49:45 +0000
Message-ID: <178883938573.219967.4602720623318150522@kernel.org>
In-Reply-To: <20260906-ks8995-to-ksz8-v9-3-8d8815a91bd8@kernel.org>
References: <20260906-ks8995-to-ksz8-v9-3-8d8815a91bd8@kernel.org>
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

- [Medium] The generic legacy compatible "micrel,ks8995" is newly bound
  to ksz_switch_chips[KSZ8995XA] in drivers/net/dsa/microchip/ksz_spi.c,…
- [Low] ksz_spi.c now matches three compatible strings —
  "micrel,ksz8864", "micrel,ksz8795" and "micrel,ks8995" — that do not…
- [Low] The new KSZ8995XA branch of ksz8_reset_switch() iterates ports
  0..dev->info->port_cnt-1 (5 ports) writing PORT_PHY_SOFT_RESET…
- [Low] ksz8_port_vlan_filtering() gained a special case `if
  (ksz_is_ksz88x3(dev) || ksz_is_ksz8995xa(dev)) return -ENOTSUPP;`,…

--

net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA

This adds KSZ8995XA (Micrel KS8995XA) support to the KSZ driver, with a
restricted set of dev/switch ops, a header-tag protocol, one-bit-per-DSCP
priority registers and reworked DCB register helpers.  It also moves the
legacy Micrel compatibles over to the KSZ SPI driver and makes the old
ks8995 driver mutually exclusive with it in Kconfig.

> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index 676fb7dffe14f..e309e4c1ee3a9 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -110,6 +110,7 @@ config NET_DSA_RZN1_A5PSW
>  config NET_DSA_KS8995
>  	tristate "Micrel KS8995 family 5-ports 10/100 Ethernet switches"
>  	depends on SPI
> +	depends on NET_DSA_MICROCHIP_KSZ_SPI = n
>  	select NET_DSA_TAG_NONE
>  	help
>  	  This driver supports the Micrel KS8995 family of 10/100 Mbit ethernet

[ ... ]

> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index 941ae9f66f70b..f9272d1b7bf47 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c
> @@ -253,7 +254,17 @@ static int ksz8463_reset_switch(struct ksz_device *dev)
>  
>  static int ksz8_reset_switch(struct ksz_device *dev)
>  {
> -	if (ksz_is_ksz88x3(dev)) {
> +	if (ksz_is_ksz8995xa(dev)) {
> +		unsigned int port;
> +
> +		/* The KSZ8995XA switch itself cannot be reset by software, but
> +		 * often boot loaders have fun with ports, so reset them. This
> +		 * reset bit is self-clearing.
> +		 */
> +		for (port = 0; port < dev->info->port_cnt; port++)
> +			ksz_port_cfg(dev, port, REG_PORT_STATUS_3,
> +				     PORT_PHY_SOFT_RESET, true);

[Severity: Low]
This isn't a bug, but should this loop use dev->phy_port_cnt rather than
dev->info->port_cnt?

The chip data for KSZ8995XA has .port_cnt = 5 and
.internal_phy = {true, true, true, true, false}, so the last iteration
writes PORT_PHY_SOFT_RESET to the port 5 register block, and ksz8_reg.h
only names REG_PORT_1..4_STATUS_3.  Other PHY-oriented loops in ksz8.c
bound on dev->phy_port_cnt.

The legacy driver does define KS8995_GC0_P5_PHY BIT(3) /* Port 5 PHY
enabled */ and its KS8995_REG_PS(p, r) macro is valid for p = 0..4, so
this register does appear to exist on the hardware; it is just
inconsistent with how internal_phy[] is declared here.

> +	} else if (ksz_is_ksz88x3(dev)) {
>  		/* reset switch */
>  		ksz_cfg(dev, KSZ8863_REG_SW_RESET,
>  			KSZ8863_GLOBAL_SOFTWARE_RESET | KSZ8863_PCS_RESET, true);

[ ... ]

> @@ -1672,7 +1731,7 @@ static int ksz8_port_vlan_filtering(struct dsa_switch *ds, int port, bool flag,
>  {
>  	struct ksz_device *dev = ds->priv;
>  
> -	if (ksz_is_ksz88x3(dev))
> +	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8995xa(dev))
>  		return -ENOTSUPP;

[Severity: Low]
Can this new ksz_is_ksz8995xa() branch ever be reached?

ksz8995xa_switch_ops (added further down in this patch) does not set
.port_vlan_filtering, and the core checks that first:

net/dsa/port.c:dsa_port_vlan_filtering() {
	...
	if (!ds->ops->port_vlan_filtering)
		return -EOPNOTSUPP;
	...
}

So for a KSZ8995XA device ksz8_port_vlan_filtering() is never entered and
the added condition looks like dead code that suggests the op is wired up.
As a side note, the existing return here is -ENOTSUPP while the core path
already returns the canonical -EOPNOTSUPP.

[ ... ]

> @@ -3111,6 +3220,38 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
> +/*
> + * Restricted operations for KSZ8995XA, so many things are not supported
> + * by this old switch that we need diet DSA operations.
> + */
> +const struct dsa_switch_ops ksz8995xa_switch_ops = {
> +	.get_tag_protocol	= ksz8995xa_get_tag_protocol,
> +	.setup			= ksz8_setup,
> +	.teardown		= ksz_teardown,
[ ... ]
> +	.port_get_apptrust	= ksz_port_get_apptrust,
> +	.port_set_apptrust	= ksz_port_set_apptrust,
> +};

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 1a9d6f83a0232..6c15ac97a7e3f 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2944,11 +2977,15 @@ static int ksz_switch_detect(struct ksz_device *dev)
>  			return -ENODEV;
>  		break;
>  	case KSZ8895_FAMILY_ID:
> -		if (id2 == KSZ8895_CHIP_ID_95 ||
> -		    id2 == KSZ8895_CHIP_ID_95R)
> +		if (id2 == KSZ8895_CHIP_ID_95XA) {
> +			dev->chip_id = KSZ8995XA_CHIP_ID;
> +			break;
> +		} else if (id2 == KSZ8895_CHIP_ID_95 ||
> +			   id2 == KSZ8895_CHIP_ID_95R) {
>  			dev->chip_id = KSZ8895_CHIP_ID;
> -		else
> +		} else {
>  			return -ENODEV;
> +		}

[Severity: Medium]
The commit message says:

  "Notice: there are also KSZ8995E and KSZ8995MA. These are BOTH
   different from the KSZ8995XA."

Given that, is it safe for family 0x95 with chip ID nibble 0x0 to be
mapped unconditionally to KSZ8995XA_CHIP_ID here?

The legacy driver attributes that same ID to KS8995MA:

drivers/net/dsa/ks8995.c:
	[ks8995] = {
		.name		= "KS8995MA",
		.family_id	= FAMILY_KS8995,
		.chip_id	= KS8995_CHIP_ID,

and the new define in this patch is:

	#define KSZ8895_CHIP_ID_95XA		0x0

Combined with the new "micrel,ks8995" entry in ksz_dt_ids pointing at
ksz_switch_chips[KSZ8995XA], and with NET_DSA_KS8995 now disabled
whenever NET_DSA_MICROCHIP_KSZ_SPI is enabled, an MA part behind the
generic compatible would be probed and programmed as XA hardware:
SW_SPECIAL_TAG in REG_SW_CTRL_9, per-port PORT_INSERT_TAG /
PORT_REMOVE_TAG, PVID 0, the descending one-bit-per-DSCP registers, the
single-bit port-based priority and the inverted packet-size polarity,
plus DSA_TAG_PROTO_KS8995 from ksz8995xa_get_tag_protocol().

Two in-tree device trees use the generic string today,
arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts and
intel-ixp42x-actiontec-mi424wr.dtsi, so if MA behaves differently in
special-tag mode those boards would lose CPU-port traffic.

For context, the later "net: dsa: ks8995: Delete surplus driver" patch in
the series records that this ID cannot distinguish MA from XA, that no
KS8995MA users are known and that neither variant has been verified, but
it does not change this mapping.  Could this detection either reject the
ambiguous case or at least warn?

> +		ret = ksz_read8(dev, REG_KSZ8864_CHIP_ID, &id4);
> +		if (ret)
> +			return ret;

[ ... ]

> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> index cbe98494578c3..93be74f7a2658 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -860,6 +867,7 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
>  #define KSZ87_CHIP_ID_94		0x6
>  #define KSZ87_CHIP_ID_95		0x9
>  #define KSZ88_CHIP_ID_63		0x3
> +#define KSZ8895_CHIP_ID_95XA		0x0
>  #define KSZ8895_CHIP_ID_95		0x4
>  #define KSZ8895_CHIP_ID_95R		0x6

[ ... ]

> diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
> index 373e9054947cb..2c55014246e5f 100644
> --- a/drivers/net/dsa/microchip/ksz_spi.c
> +++ b/drivers/net/dsa/microchip/ksz_spi.c
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
Should the three Micrel strings also be added to the compatible enum in
Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml?

The series adds "microchip,ksz8995xa" to that enum, but "micrel,ksz8864",
"micrel,ksz8795" and "micrel,ks8995" are not listed anywhere under
Documentation/, and the legacy ks8995 driver is removed later in the
series, so the KSZ schema becomes the only place that could describe
them.  As a result the two ixp42x device trees using "micrel,ks8995"
stay unvalidated by dt_binding_check / dtbs_check.  Listing them (for
instance as deprecated) would close that gap.

> +	{
> +		.compatible = "microchip,ksz8463",
> +		.data = &ksz_switch_chips[KSZ8463]

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906-ks8995-to-ksz8-v9-0-8d8815a91bd8%40kernel.org
