Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF0342D746;
	Wed,  2 Sep 2026 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342645; cv=none; b=gLCHVeekQDyskZIuTP0j0dClAwy3hkIpBtn2J2UR6M7zuhMK+8r/O4M2ySGEwfB55KrBi/oBMUZ+JdKrV3L2wIp9XhF1ZYJroHrpbr5pmaRLkT9uYm2nwEElX26siox4VjuS7Cp3B5bU4eFSOcrchTN0MM7B3YIYHxOd7IJ0Q4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342645; c=relaxed/simple;
	bh=dnNFSqNjrgayNSlDgCVQ9iRt5RHUP2rrEumDZJm3kvU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mJ3DQ0h98CYw0lxhMF+wXokwUIISBrzMez/1rs37x2NIEHuXiP6NF0OK9qLHDzV+yIb19aT+L2jmFwTzunoZzlGzZzdT75gZDjFS8fVK2ms5CEiHqNKGRvfiZN1+9L5K/l4oDTfVn1dpR1pedfF3RNZibyhaiHmEJWk2ad5jJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUO20p2l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUO20p2l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121F41F000E9;
	Wed,  2 Sep 2026 09:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788342642;
	bh=aip67qC66hkPdn20J/njhU2Z8RYV+Mn2JU1xMI5LZb0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CUO20p2lNbAe1mccxJfr9qzuchz4TwHqwyuACOo0DOaxHx2jX+CMYPvl0cMZmUnpD
	 yK8g3X2ImwTD3EZ/+kKezHiT+aaKb+unrMEpUGkjkYTimxQzYHw/ObKb/Wn5eJEKH/
	 QQjcqtNY2KuoUQ6lxaW0MVCaIiyPuMU74CFQxuyluQa9UPLz1EiTjpBQBUAx3xzDe5
	 hlLEiL5ehQ2iFVqectZPd3v6V2IRUZrxwRSupo30+uARNKKT4Phq0puhUKa4OcNrUK
	 nCce1vmUjJz/KtA+Wc2mW4cA3wg/d1aPOWnDVcn+kAO+123tkXPLK+8Hm2t3nJdHN6
	 MiV/4OcBmRAgg==
Subject: Re: [net-next,v8,4/5] net: dsa: microchip: Support Microchip
 KSZ8995XA / KS8995XA
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Wed, 02 Sep 2026 09:50:40 +0000
Message-ID: <178834264058.3394541.10134411408334800406@kernel.org>
In-Reply-To: <20260831-ks8995-to-ksz8-v8-4-fd1dbb2b76e8@kernel.org>
References: <20260831-ks8995-to-ksz8-v8-4-fd1dbb2b76e8@kernel.org>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] KSZ8995XA detection cannot distinguish the XA from the
  KS8995MA/KSZ8995E parts the commit message says are incompatible, and…
- [Medium] The new KSZ8995XA branch of ksz8_reset_switch() loops over all
  ports (`for (port = 0; port < dev->info->port_cnt; port++)`, i.e.…
- [Low] For KSZ8995XA the special-tag configuration in ksz8_port_setup()
  only ever *sets* bits in Port Control 0: PORT_INSERT_TAG (BIT(2)) on…

--

net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA

This adds KSZ8995XA (aka Micrel KS8995XA) support to the KSZ DSA driver,
with a reduced set of dev/switch operations, a header special tag instead
of a tail tag, and adjusted DCB helpers for the chip's eight one-bit-per-
DSCP TOS priority registers. It also switches the SPI mode for this chip
and adds new OF and SPI identifiers.

> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index 941ae9f66f70b..f9272d1b7bf47 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c

[ ... ]

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

[Severity: Medium]
Should this loop be bounded by dev->phy_port_cnt rather than
dev->info->port_cnt?

The new chip data declares five ports with no internal PHY on the last
one:

drivers/net/dsa/microchip/ksz_common.c, ksz_switch_chips[KSZ8995XA]:
		.port_cnt = 5,		/* total cpu and user ports */
		...
		.internal_phy = {true, true, true, true, false},

With PORT_CTRL_ADDR(port, addr) = addr + 0x10 + port * 0x10, the fifth
iteration writes address 0x5F, the MII/CPU port block, while ksz8_reg.h
only defines the STATUS_3 register for ports 1 through 4:

drivers/net/dsa/microchip/ksz8_reg.h:
#define REG_PORT_1_STATUS_3		0x1F
#define REG_PORT_2_STATUS_3		0x2F
#define REG_PORT_3_STATUS_3		0x3F
#define REG_PORT_4_STATUS_3		0x4F

Every other PHY-side loop in ksz8.c uses dev->phy_port_cnt, which is
port_cnt - 1 for this chip.

Does that last write land on a reserved bit, or does it soft-reset the
fifth PHY on MII-P5 which does not belong to the switch fabric?  On the
two in-tree boards using this family that PHY is the WAN PHY driven by a
different MAC, so a reset there would be visible as a link drop on an
unrelated netdev.  Since the comment says the switch itself has no
software reset, the bit is also never cleared again by the driver.

[ ... ]

> @@ -2057,6 +2118,21 @@ static void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
>  
>  	ksz8_cfg_port_member(dev, port, member);
>  
> +	if (ksz_is_ksz8995xa(dev)) {
> +		/* Use VID 0 to identify untagged frames in the special tag */
> +		ksz_pwrite16(dev, port, REG_PORT_CTRL_VID, 0);
> +
> +		/* The KSZ8995XA has a special tag format in the front of the frame
> +		 * that need to be inserted by the CPU and then removed by each
> +		 * port. PORT_REMOVE_TAG simply means "remove tags coming from the
> +		 * CPU port" it does not affect ingress packets.
> +		 */
> +		if (cpu_port)
> +			ksz_port_cfg(dev, port, REG_PORT_CTRL_0, PORT_INSERT_TAG, true);
> +		else
> +			ksz_port_cfg(dev, port, REG_PORT_CTRL_0, PORT_REMOVE_TAG, true);
> +	}

[Severity: Low]
Both branches here only ever set a bit, since ksz_port_cfg(..., true)
expands to ksz_rmw8() with mask equal to value.  The opposite bit is
never driven to a defined value: PORT_INSERT_TAG is left untouched on
user ports and PORT_REMOVE_TAG is left untouched on the CPU port.

Given that ksz8_reset_switch() states this part cannot be reset by
software, and only pokes PORT_PHY_SOFT_RESET, is Port Control 0 ever
brought to a known state?  If a boot loader (the same agent the comment
above blames for having fun with ports) left PORT_INSERT_TAG set on a
user port, the switch would emit the special tag onto the wire there; if
it left PORT_REMOVE_TAG set on the CPU port, frames towards the CPU would
be stripped, and the KS8995 tagger would then disagree with the hardware
frame format.

Would a single read-modify-write covering both bits be clearer, so both
end up defined?

	ksz_prmw8(dev, port, REG_PORT_CTRL_0,
		  PORT_INSERT_TAG | PORT_REMOVE_TAG,
		  cpu_port ? PORT_INSERT_TAG : PORT_REMOVE_TAG);

[ ... ]

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 1a9d6f83a0232..6c15ac97a7e3f 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c

[ ... ]

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
>  		ret = ksz_read8(dev, REG_KSZ8864_CHIP_ID, &id4);
>  		if (ret)
>  			return ret;

[Severity: Medium]
How does this branch distinguish the XA from the parts the commit message
calls out as different?  The commit message says:

    Notice: there are also KSZ8995E and KSZ8995MA. These are BOTH
    different from the KSZ8995XA.

Here family ID 0x95 with chip-ID nibble 0 is claimed as
KSZ8995XA_CHIP_ID unconditionally, and the early break skips any further
read.  The neighbouring KSZ8895/KSZ8864 path does read
REG_KSZ8864_CHIP_ID to narrow things down, and the revision field in
register 0x01 (which the old driver read in get_chip_rev()) is never
consulted, so dev->chip_rev stays 0 and probe prints "found switch:
KSZ8995XA, rev 0" for any family-0x95, chip-0 silicon.

The new define asserts the ID is XA specific:

drivers/net/dsa/microchip/ksz_common.h:
#define KSZ8895_CHIP_ID_95XA		0x0

but drivers/net/dsa/ks8995.c names exactly the same family/chip-ID pair
KS8995MA:

	[ks8995] = {
		.name = "KS8995MA",
		.family_id = FAMILY_KS8995,
		.chip_id = KS8995_CHIP_ID,

The same patch also points the family-wide legacy identifiers at the XA
chip data:

drivers/net/dsa/microchip/ksz_spi.c, ksz_dt_ids:
	{
		.compatible = "micrel,ks8995",
		.data = &ksz_switch_chips[KSZ8995XA]
	},

plus { "ks8995" } in ksz_spi_ids.  micrel,ks8995 is the family-wide
compatible per Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml,
and both in-tree users of it, intel-ixp42x-linksys-wrv54g.dts and
intel-ixp42x-actiontec-mi424wr.dtsi, were previously handled by
drivers/net/dsa/ks8995.c.  The later commit "net: dsa: ks8995: Delete
surplus driver" removes that driver, so there is no fallback.

If an MA or E part answers with this ID, it gets programmed with the
XA-specific configuration with no warning and no way to opt out:
SW_SPECIAL_TAG in REG_SW_CTRL_9, per-port PORT_INSERT_TAG and
PORT_REMOVE_TAG, DSA_TAG_PROTO_KS8995 instead of the previous
DSA_TAG_PROTO_NONE, descending TOS/DSCP register order, single-bit port
priority, the deliberately inverted legal/huge packet-size polarity, and
VLAN, MIB and FDB support switched off.

Could this branch consult the revision field (or another discriminator),
or at least emit a dev_warn that MA and E share this ID and are treated
as XA?  Alternatively, could the legacy family-wide compatible keep
distinct chip data?

The series also reads as internally inconsistent on this point: this
commit message says E and MA support could be added "in the future",
while "net: dsa: ks8995: Delete surplus driver" states the ksz driver
"now handles all switches that the old driver was handling".

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-ks8995-to-ksz8-v8-0-fd1dbb2b76e8%40kernel.org
