Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE5D5632A6;
	Wed,  9 Sep 2026 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957564; cv=none; b=Wid+8n4GkPGm30dy4n/2l7FnSTMVXaqZT55mA/pamdIUoKSYIkYHMqNDuCNrOrjYDWw0ABuby5dg5PaAm92lDgxrvwGI29Ky9pOYS5jgb8eUUYP3hwkcwH9Pi9umQUTSwKDkNxewRzv3/jnlXQDOUWj0CY6+MAoCvtu8iGThpDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957564; c=relaxed/simple;
	bh=CC0D30e9zI1ckeZwBA78mdeVVKja26rn7Z1/yA7LOzc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kfRvkZEOSAABcXKSJ5qt8jfyQmuUcaDRfGdMNAsS+iJoUptqjAvYu/avS52EmI1mXW1IltxQJsZVIeSod9jOFoXgZKdLLsovDgH1ijYuM93ELvh0YY661chWg4Eld/F+oqitSxRy+mhRjNd2/bbn8xrh8J27j+QUUUDIpA1uqMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+iiOx21; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+iiOx21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA711F00A3D;
	Wed,  9 Sep 2026 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788957561;
	bh=G2I09r6i6W52aQDRSUEwCUHQjacD2tL8JMF4jLJ+csc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y+iiOx21Qgc5KrT3MTmTqSQI/qVdzBBA6O1fN0fBh/5adEpWKXoFTICTXFS4w+kfI
	 uLU1TQOqtIxJJLSHauz1ZdiD33M365A/KkXPEKBveIbPkMlADpWppo3lO0S1nVnjXg
	 0s3/FHS+tC8Dd6qdybv+y3K+77NMSGsTQgoyvAEnnfKjMAZD9CwxdkFzRKvXSOHm3A
	 EKvik15lMcIYaPjXUD+zzm6BNMUabz3Gz85+mxTAtH+cMNU5z77o+6HSuP02C2IQV8
	 iyvfrXK9zGnT8r1PnELPvN5osrJsA7vPfcYxefwoj8ezaF+XG0V5izvRjKWsZEDjT1
	 je/jVGtFNGzgQ==
Subject: Re: [PATCH net-next v10 3/4] net: dsa: microchip: Support Microchip
 KSZ8995XA / KS8995XA
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Wed, 09 Sep 2026 12:39:20 +0000
Message-ID: <178895756004.219967.7460069441870628251@kernel.org>
In-Reply-To: <20260908-ks8995-to-ksz8-v10-3-7379239eb65f@kernel.org>
References: <20260908-ks8995-to-ksz8-v10-3-7379239eb65f@kernel.org>
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
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 3 · Low: 5

- [Medium] In ksz8_reset_switch()
  (drivers/net/dsa/microchip/ksz8.c:258-281) the new KSZ8995XA path…
- [Medium] Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
  lists `microchip,ksz8995xa` in the `not: { compatible: enum:…
- [Medium] ksz8995xa_switch_ops uses the shared ksz8_setup() as .setup,
  and that function unconditionally advertises VLAN behaviour to the DSA…
- [Low] The commit message states KSZ8995E and KSZ8995MA are BOTH
  different from the KSZ8995XA, yet ksz_switch_detect() maps family 0x95…
- [Low] drivers/net/dsa/microchip/ksz8_reg.h gains three defines that
  have no user anywhere in the tree, now or at the end of the series:…
- [Low] ksz_spi.c now owns the three legacy Micrel compatibles
  ("micrel,ks8995", "micrel,ksz8795", "micrel,ksz8864"), but those…
- [Low] In ksz8_reset_switch() the per-port PHY reset commands are issued
  through ksz_port_cfg(), which returns void and discards the…
- [Low] The new KSZ8995XA reset path performs up to 5 sequential
  regmap_read_poll_timeout() calls of 600 ms each (plus a 1-2 ms settle…

Pre-existing issues:
- [High] dev->mib_read (struct delayed_work) is only initialized by
  INIT_DELAYED_WORK() inside ksz_init_mib_timer(), which runs from the…

--

net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA

This adds KSZ8995XA (Micrel KS8995XA) support to the KSZ driver with a
restricted set of dev/switch ops, a per-port PHY reset-and-wait sequence, a
chip specific DSCP register layout, and the legacy Micrel compatibles moved
over from the ks8995 driver.  A few questions about the new code below.

> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index 941ae9f66f70..40d7d0eaf1ce 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c

[ ... ]

> @@ -253,7 +255,31 @@ static int ksz8463_reset_switch(struct ksz_device *dev)
>  
>  static int ksz8_reset_switch(struct ksz_device *dev)
>  {
> -	if (ksz_is_ksz88x3(dev)) {
> +	if (ksz_is_ksz8995xa(dev)) {
> +		unsigned int port, reg, val;
> +		int ret;
> +
> +		/* The KSZ8995XA switch itself cannot be reset by software, but
> +		 * often boot loaders have fun with ports, so reset them. This
> +		 * reset bit is self-clearing.
> +		 */
> +		for (port = 0; port < dev->info->port_cnt; port++)
> +			ksz_port_cfg(dev, port, REG_PORT_STATUS_3,
> +				     PORT_PHY_SOFT_RESET, true);

[Severity: Low]
The assert of PORT_PHY_SOFT_RESET goes through ksz_port_cfg(), which
returns void:

static void ksz_port_cfg(struct ksz_device *dev, int port, int offset, u8 bits,
			 bool set)
{
	ksz_rmw8(dev, dev->dev_ops->get_port_addr(port, offset), bits,
		 set ? bits : 0);
}

If the regmap_update_bits() behind this fails with -EIO while the following
reads succeed, the poll below sees the bit already clear and the driver
concludes the PHY was reset and settled.  Would using ksz_prmw8() directly
in this new loop and checking the return value be preferable, given the
commit message makes the reset-and-wait the point of this hunk?

> +
> +		/* IEEE 802.3 allows up to 500 ms for a PHY reset. */
> +		for (port = 0; port < dev->info->port_cnt; port++) {
> +			reg = dev->dev_ops->get_port_addr(port, REG_PORT_STATUS_3);
> +			ret = regmap_read_poll_timeout(ksz_regmap_8(dev), reg, val,
> +						       !(val & PORT_PHY_SOFT_RESET),
> +						       1000, 600000);
> +			if (ret)
> +				return ret;
> +		}

[Severity: Medium]
Both loops run over dev->info->port_cnt, which is 5 for the chip data added
in this same patch, so port index 4 is included.  That is the MII/CPU port,
and the same chip data declares it has no internal PHY:

	[KSZ8995XA] = {
		...
		.cpu_ports = 0x10,	/* can be configured as cpu port */
		.port_cnt = 5,		/* total cpu and user ports */
		...
		.internal_phy = {true, true, true, true, false},
	},

Is writing a PHY-only control bit into the port 5 register window (offset
0x0F of that port, i.e. 0x5F) and then waiting for it to self-clear
intended?  If bit 4 there does not self-clear, regmap_read_poll_timeout()
returns -ETIMEDOUT and the error propagates:

ksz8_setup()
  ret = ksz8_reset_switch(dev);
  if (ret) {
	dev_err(ds->dev, "failed to reset switch\n");
	return ret;
  }

which fails the probe with the four LAN PHYs freshly reset and SW_START
never written.  ksz8_switch_init() already computes the value that looks
correct here:

	dev->phy_port_cnt = dev->info->port_cnt - 1;

Would bounding both loops by dev->phy_port_cnt (or by
dev->info->internal_phy[port]) be more consistent with the chip data?  On
the known ixp42x boards the fifth PHY is reachable through MII-P5 and may
be managed externally, in which case resetting it here also discards its
configuration.

[Severity: Low]
A related question about the timeout: this runs from ksz8_setup(), which
DSA calls from dsa_register_switch() with dsa2_mutex held.  With five ports
at 600000 us each plus the settle sleep, a chip whose reset bit never
clears keeps that global mutex for roughly three seconds, blocking
registration and removal of every other DSA switch tree meanwhile.  Is a
shorter per-port timeout (the comment mentions the 500 ms IEEE 802.3 limit)
enough here?

> +
> +		/* Some PHYs need additional settling time after reset. */
> +		usleep_range(1000, 2000);
> +	} else if (ksz_is_ksz88x3(dev)) {
>  		/* reset switch */
>  		ksz_cfg(dev, KSZ8863_REG_SW_RESET,
>  			KSZ8863_GLOBAL_SOFTWARE_RESET | KSZ8863_PCS_RESET, true);

[ ... ]

> @@ -3111,6 +3235,38 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
>  	.pme_pwrite8 = ksz8_pme_pwrite8,
>  };
>  
> +/*
> + * Restricted operations for KSZ8995XA, so many things are not supported
> + * by this old switch that we need diet DSA operations.
> + */
> +const struct dsa_switch_ops ksz8995xa_switch_ops = {
> +	.get_tag_protocol	= ksz8995xa_get_tag_protocol,
> +	.setup			= ksz8_setup,

[Severity: Medium]
This ops table has no .port_vlan_filtering, .port_vlan_add or
.port_vlan_del, the chip data leaves num_vlans at 0, and the dev_ops
comment above states there is no VLAN handling.  The shared ksz8_setup()
used as .setup here still advertises VLAN behaviour to the DSA core for
this chip:

	ds->untag_bridge_pvid = true;
	...
	ds->vlan_filtering_is_global = true;

Since ds->untag_bridge_pvid is set, every frame received from this switch
goes through the software untag path in net/dsa/tag.c:dsa_switch_rcv():

	if (unlikely(cpu_dp->ds->untag_bridge_pvid ||
		     cpu_dp->ds->untag_vlan_aware_bridge_pvid)) {
		/* dsa_software_vlan_untag() drops skb on failure */
		nskb = dsa_software_vlan_untag(skb);

For a VLAN-unaware bridge that strips a tag whose VID equals the bridge
PVID.  As this switch never inserts a VLAN tag towards the CPU, such a tag
is genuine wire data.  Should these three flags (including
ds->configure_vlan_while_not_filtering) be guarded by ksz_is_ksz8995xa()
the way the vlan_cache allocation, ksz8_r_vlan_entries() and
UNICAST_VLAN_BOUNDARY are in the rest of the patch?

> +	.teardown		= ksz_teardown,
> +	.phy_read		= ksz8_phy_read16,
> +	.phy_write		= ksz8_phy_write16,

[ ... ]

> diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
> index 6bc511da1f7d..bd99699aae02 100644
> --- a/drivers/net/dsa/microchip/ksz8_reg.h
> +++ b/drivers/net/dsa/microchip/ksz8_reg.h
> @@ -30,6 +30,11 @@
>  #define KSZ88X3_REG_FVID_AND_HOST_MODE  0xC6
>  #define KSZ88X3_PORT3_RMII_CLK_INTERNAL BIT(3)
>  
> +#define REG_SW_ID_0			0x00
> +#define REG_SW_ID_1			0x01
> +
> +#define SW_START_SWITCH			BIT(0)

[Severity: Low]
These three defines have no user anywhere in drivers/net/dsa/microchip/,
neither in this patch nor at the end of the series.  SW_START_SWITCH also
duplicates the existing SW_START bit that ksz8_setup() writes through
regs[S_START_CTRL].  Can they be dropped, or is a follow-up user planned?

> +
>  #define REG_SW_CTRL_0			0x02
>  
>  #define SW_NEW_BACKOFF			BIT(7)

[ ... ]

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 1a9d6f83a023..6c15ac97a7e3 100644
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

[Severity: Low]
The commit message says:

  "Notice: there are also KSZ8995E and KSZ8995MA. These are BOTH
   different from the KSZ8995XA."

but family 0x95 with chip-ID nibble 0x0 is mapped here unconditionally to
KSZ8995XA, and "micrel,ks8995" (the identifier the legacy driver used for
KS8995MA) is bound to ksz_switch_chips[KSZ8995XA] in ksz_spi.c.  An MA or E
part would therefore be driven with the XA-only quirks added by this patch
(SW_SPECIAL_TAG, the inverted packet-size polarity, descending DSCP
registers, the PHY reset poll, and the no-indirect-access ops).

The last patch of the series explains that this ID cannot distinguish MA
from XA and that no MA users are known, so the hardware really offers
nothing better.  Could the wording in this commit message be adjusted to
say that up front, so the mapping does not read as a contradiction?

[ ... ]

> @@ -4029,11 +4066,13 @@ int ksz_switch_register(struct ksz_device *dev)
>  	if (ret)
>  		return ret;
>  
> -	/* Read MIB counters every 30 seconds to avoid overflow. */
> -	dev->mib_read_interval = msecs_to_jiffies(5000);
> +	if (!ksz_is_ksz8995xa(dev)) {
> +		/* Read MIB counters every 30 seconds to avoid overflow. */
> +		dev->mib_read_interval = msecs_to_jiffies(5000);
>  
> -	/* Start the MIB timer. */
> -	schedule_delayed_work(&dev->mib_read, 0);
> +		/* Start the MIB timer. */
> +		schedule_delayed_work(&dev->mib_read, 0);
> +	}
>  
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue and not introduced by this patch, which only
wraps these lines in a condition, but while the hunk is being touched:
dev->mib_read is only initialized inside ksz_init_mib_timer():

	INIT_DELAYED_WORK(&dev->mib_read, ksz_mib_read_work);

and that function is reached only from the chip .setup callbacks.  Can
dsa_register_switch() return 0 without ever calling ds->ops->setup?
net/dsa/dsa.c:dsa_tree_setup() does:

	complete = dsa_tree_setup_routing_table(dst);
	if (!complete)
		return 0;

so for an incomplete (cascaded, multi-switch) tree the setup callbacks are
skipped, and schedule_delayed_work() above is then called on a delayed_work
that is still all zeroes from devm_kzalloc().  __queue_delayed_work() warns
on timer->function, and with delay 0 the work item is queued with a NULL
func, which the worker then calls.

Would moving INIT_DELAYED_WORK() to allocation or registration time, rather
than into the setup path, be the right fix?

> diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
> index 373e9054947c..e3bb9e604186 100644
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
These three strings are documented only in
Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml, which was
written for the driver being removed: it sets unevaluatedProperties: false
and allows only compatible, reg, reset-gpios plus dsa.yaml ethernet-ports
and spi-peripheral-props.  The KSZ driver that now owns them parses
microchip,synclko-125, microchip,synclko-disable,
microchip,pme-active-high, wakeup-source, the drive-strength properties and
per-port micrel,fiber-mode and rx-internal-delay-ps, none of which appear
in that schema, and microchip,ksz.yaml lists no micrel,* compatible.  Does
a devicetree using a micrel,* compatible together with any of those
properties still pass dt_binding_check?

The description in micrel,ks8995.yaml also still says all the PHYs need to
be accessed from an external MDIO channel, while the chip data added here
declares internal_phy = {true, true, true, true, false} and the driver
serves those PHYs itself through ksz8_phy_read16() and
ksz_mdio_register().  Should the aliases move into microchip,ksz.yaml
(marked deprecated), or should micrel,ks8995.yaml reference the KSZ
property set?

>  	{
>  		.compatible = "microchip,ksz8463",
>  		.data = &ksz_switch_chips[KSZ8463]

[ ... ]

> @@ -256,6 +279,10 @@ static const struct of_device_id ksz_dt_ids[] = {
>  		.compatible = "microchip,ksz8895",
>  		.data = &ksz_switch_chips[KSZ8895]
>  	},
> +	{
> +		.compatible = "microchip,ksz8995xa",
> +		.data = &ksz_switch_chips[KSZ8995XA]
> +	},

[Severity: Medium]
In Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml this
compatible is placed in the negated enum of the ksz88x3 conditional:

  - if:
      not:
        properties:
          compatible:
            enum:
              - microchip,ksz8863
              - microchip,ksz8873
              - microchip,ksz8995xa
    then:
      $ref: dsa.yaml#/$defs/ethernet-ports
    else:
      patternProperties:
        "^(ethernet-)?ports$":
          patternProperties:
            "^(ethernet-)?port@[0-2]$":

So the KSZ8995XA takes the else branch, whose port pattern covers port@0 to
port@2 only, while the chip data added in this patch says port_cnt = 5 and
cpu_ports = 0x10, i.e. user ports 0-3 and CPU port 4.  Are port@3 and
port@4 of a valid KSZ8995XA node still validated?  They match neither the
[0-2] pattern nor dsa.yaml ethernet-ports on that branch.

That branch also offers microchip,rmii-clk-internal, which this chip never
uses:

ksz88x3_config_rmii_clk()
	if (!ksz_is_ksz88x3(dev))
		return;

Should microchip,ksz8995xa instead take the dsa.yaml ethernet-ports branch,
the way ksz8565 with port@6 already does?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-ks8995-to-ksz8-v10-0-7379239eb65f%40kernel.org
