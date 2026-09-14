Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD400414A3B;
	Mon, 14 Sep 2026 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418823; cv=none; b=EgMU14LxVg2K3pQnCpADxffT6H+rE7ZvSVcwwiLnSXYXnDp3GpoEqgpagPpNZH7ffsyx1Bj/yZmkT5LKpMj4A3/XJ64IKgc42uCUW3WmmG9YcQ3YNjLYdtbCNF3b7bdz1ruIi8yrEgry7bQ+GC+RlvgCuCViOYf17xDZu0D4IuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418823; c=relaxed/simple;
	bh=iuc0Ms3G1QCaMWS7uxt0b+11hbylwKF9JN6l7Ng6xnw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d1Da8ptTWkc/WKVZF18Sz1xj1QpAbmc8MASNyMHRtSSVXnE98AZye2xZ50bHeQpvHY6lhzsfs9QgF1PFZt26D6nIKF2F+oqbJYsgxfXUi5Tcoof6ioYSeUGJsPWOqoPPmqK1ZITO7eCKPQ+C7NzrnZIKf0fUCCgi9X8NO+24owg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFhVStkq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFhVStkq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C92C1F000FF;
	Mon, 14 Sep 2026 20:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789418821;
	bh=AjrYB93weBBzKDKZwSdDA669TbxyiIUSowl+L7cCzB8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WFhVStkqt0pF2sz9XYgnfb/CJ9xYY3pWPvAN7OWkgIsRyA6AVCniagiAp/OsHUU8M
	 HD/v+LDwWpRCRKZr9w0N2vLV5PFhsRwqhPuWr0JmXSfwboubKe1TzZ7lbUdqhVY5Tj
	 dqOCfRi0qNYMzIkB/NPIlI8TA9JuXuc4T3ON1E/AeQ7jrPL2l3Qdih64dMrpUPl+Fd
	 LlrtlnNr0fiCsxlUaBckuUUByGdVYYyKpdA/GZ7zTGC9DlJF8DP4xtfekv0jsTQTJF
	 /Q8koIsoki7d0tEp3H4AsGtsN3F6kHJQbyNrbmWA6ANF5AXfYAnx8+xV1GIrT2niCE
	 +i6PAmMiWR4xQ==
Subject: Re: [PATCH net-next v13 3/4] net: dsa: microchip: Support Microchip
 KSZ8995XA / KS8995XA
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Mon, 14 Sep 2026 20:46:59 +0000
Message-ID: <178941881987.22033.2678404976824973480@kernel.org>
In-Reply-To: <20260913-ks8995-to-ksz8-v13-3-327b16d309eb@kernel.org>
References: <20260913-ks8995-to-ksz8-v13-3-327b16d309eb@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 0 (1)

- [Medium] ksz_spi.c claims the three legacy compatibles "micrel,ks8995",
  "micrel,ksz8795" and "micrel,ksz8864", but the only in-tree schema…
- [Medium] In the new KSZ8995XA branch of ksz8_reset_switch()
  (drivers/net/dsa/microchip/ksz8.c:256), both the PHY-reset write loop…

Pre-existing issues:
- [Low] Reported concern (validated as NOT a functional regression): the
  new `{ "ks8995" }` and `{ "ksz8995xa" }` entries in ksz_spi_ids[]…

--

net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA

This adds KSZ8995XA (Micrel KS8995XA) support to the KSZ DSA driver,
including a reduced set of dev/switch ops, a per-port PHY reset in
ksz8_reset_switch(), DCB helpers for the eight global TOS priority
registers, and new SPI/OF match entries. It also makes the legacy
NET_DSA_KS8995 driver mutually exclusive with NET_DSA_MICROCHIP_KSZ_SPI
and takes over the legacy micrel compatibles.

> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index 941ae9f66f70b..d7498132064e8 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c

[ ... ]

> @@ -253,7 +255,35 @@ static int ksz8463_reset_switch(struct ksz_device *dev)
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
> +		for (port = 0; port < dev->info->port_cnt; port++) {
> +			ret = ksz_prmw8(dev, port, REG_PORT_STATUS_3,
> +					PORT_PHY_SOFT_RESET,
> +					PORT_PHY_SOFT_RESET);
> +			if (ret)
> +				return ret;
> +		}
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
Should both of these loops be bounded by dev->phy_port_cnt rather than
dev->info->port_cnt?

The chip data added here declares five ports with no PHY on the last one:

	[KSZ8995XA] = {
		...
		.port_cnt = 5,		/* total cpu and user ports */
		...
		.internal_phy = {true, true, true, true, false},
	},

and ksz8_switch_init() sets dev->phy_port_cnt = port_cnt - 1 = 4 with
dev->cpu_port = 4.  Other PHY-specific per-port loops in this file, for
example in ksz8_config_cpu_port(), use dev->phy_port_cnt.

With port_cnt the loops also touch index 4, and
PORT_CTRL_ADDR(4, REG_PORT_STATUS_3) resolves to absolute register 0x5F,
for which ksz8_reg.h has no definition; it only defines up to port 4:

	#define REG_PORT_1_STATUS_3		0x1F
	#define REG_PORT_2_STATUS_3		0x2F
	#define REG_PORT_3_STATUS_3		0x3F
	#define REG_PORT_4_STATUS_3		0x4F

If PORT_PHY_SOFT_RESET does not read back as zero at 0x5F, the poll
returns -ETIMEDOUT after 600 ms and setup is aborted:

	ret = ksz8_reset_switch(dev);
	if (ret) {
		dev_err(ds->dev, "failed to reset switch\n");
		return ret;
	}

so probe fails.  Alternatively, if 0x5F is the control register of the
standalone PHY5 on MII-P5 (the in-tree wrv54g and mi424wr-d device trees
describe PHY5 being used by a separate WAN netdev at external MDIO
address 5), does this soft-reset a PHY that belongs to an unrelated
network interface on every switch setup?

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

[Severity: Medium]
Do the bindings need updating to match the properties this driver reads
for these three compatibles?

The only schema matching micrel,ks8995, micrel,ksz8795 and micrel,ksz8864
is Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml, which
allows only compatible, reg, reset-gpios, ethernet-ports/ports and
spi-peripheral-props, with:

	unevaluatedProperties: false

The properties this driver parses are documented only in
Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml, and that
file does not list any micrel compatible (this series added only
microchip,ksz8995xa there).

Consumers in the driver for chips now reachable through these
compatibles:

  ksz8_parse_drive_strength() reads and applies
  microchip,hi-drive-strength-microamp,
  microchip,lo-drive-strength-microamp and
  microchip,io-drive-strength-microamp for KSZ8795_CHIP_ID, i.e. for
  micrel,ksz8795

  ksz_switch_register() reads microchip,synclko-125,
  microchip,synclko-disable, wakeup-source, microchip,pme-active-high
  and the per-port micrel,fiber-mode

  ksz_spi_probe() takes spi->irq, and ksz8_setup() calls
  ksz_girq_setup(), so interrupts is meaningful

None of those properties, nor interrupts, is permitted by
micrel,ks8995.yaml, so a device tree using this functionality on one of
these nodes is rejected by dt_binding_check while the driver honours it.
The Documentation tree is unchanged through the end of the series.

[ ... ]

> @@ -317,6 +344,7 @@ static const struct of_device_id ksz_dt_ids[] = {
>  MODULE_DEVICE_TABLE(of, ksz_dt_ids);
>  
>  static const struct spi_device_id ksz_spi_ids[] = {
> +	{ "ks8995" },
>  	{ "ksz8463" },
>  	{ "ksz8765" },
>  	{ "ksz8794" },

[Severity: Low]
This isn't a bug introduced by this patch, but the new "ks8995" and
"ksz8995xa" entries carry no driver_data, matching the existing
convention in ksz_spi_ids[] where none of "ksz8463" ... "lan9646" set it
either.  Since ksz_spi_probe() only uses firmware match data:

	chip = device_get_match_data(ddev);
	if (!chip)
		return -EINVAL;

a device instantiated from board info (modalias match only) cannot probe,
whereas the legacy ks8995.c used spi_get_device_id(spi)->driver_data.
Nothing in the tree instantiates these devices that way, and the final
patch of the series states the platform data path is unused, so this is
only a cleanup suggestion: either populate driver_data and use
spi_get_device_match_data(), or drop the IDs that cannot be matched.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913-ks8995-to-ksz8-v13-0-327b16d309eb%40kernel.org
