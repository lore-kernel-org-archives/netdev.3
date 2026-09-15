Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B2C4CE67B;
	Tue, 15 Sep 2026 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515411; cv=none; b=f8iANhcp8jhyzficTz4/Q8cKu6N9k9Hg2U/fk9FUrMyzum1T4PEFE+ytqJpkgXd8bmtgYewyOeEg7QCuY19WuGrNqzDXcxfrToMYe1jk8jKMaOwoxHab3PHjzrypBaq82uAZemCiv9tsvq0Jz35QaB8yKmitJWeIbY5YPW9alyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515411; c=relaxed/simple;
	bh=5scx2ryFbHdurjNoZBdW3Ik4qDTBkzo5sYS9hShd3AA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KZexT9O+Q8Huzoqt0bu6YaZ5AkgQsTgr7skpMBmfRcvzBgo5lKXQRtRJETH8YDInQlQ+Xw3Obb+x21dlmhTsZmgB/Pyto2ZzAgZm4VnUzL2/+MmHpjczF4CjsFT0bJuVfnzbe24X4liV9lzoagzqN339W+LEGrkH6TigiOrBPg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5p4LHCF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5p4LHCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF1A1F00893;
	Tue, 15 Sep 2026 23:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515409;
	bh=pe798LSuROpgFIV7L7M+ZrNYQ1ZGVCFirFMLfxgF5Vs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P5p4LHCF79hpRDKUhy0feeRSBUwrOdi4c1IS3ZmsCZsVeRJS/HKsyDJZnDn/vpdJp
	 XuoqRkuxlBG7Z/2Ztw7YkPNgbRM0nwNcckV2R9qwl+YCctA2228qLN8a/WjUwPbLxA
	 6Xoqeqkx+6AeVUHkH7juaTsmGCzuhohrbl+X8Np+KBUj6z2lQEnoilyrSMGBWmFdR/
	 0AWFa6Wz42kc78lVUeoj1INLIUd7wazJ8p64bmblJQ/28D+y/8C3/VMPOdFoJH7+Yk
	 w/eOn15z/jxSWOjdxWWUX0gVFfg/hecstGcZgCQ6niCm2GuFxOhiYMTvH43xyNx4s8
	 lyPhszvdKQV7Q==
Subject: Re: [PATCH net-next v14 3/4] net: dsa: microchip: Support Microchip
 KSZ8995XA / KS8995XA
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 15 Sep 2026 23:36:48 +0000
Message-ID: <178951540838.22033.9648130176733242397@kernel.org>
In-Reply-To: <20260914-ks8995-to-ksz8-v14-3-3d72692b3c97@kernel.org>
References: <20260914-ks8995-to-ksz8-v14-3-3d72692b3c97@kernel.org>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

- [High] PHY soft reset loop unconditionally includes the MAC-only CPU
  port, risking a 600ms polling timeout and probe failure.
- [Low] ksz_spi.c now claims 'micrel,ks8995', 'micrel,ksz8795' and
  'micrel,ksz8864', but the series never reconciles the bindings: the…

--

net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA

This adds KSZ8995XA (Micrel KS8995XA) support to the KSZ DSA driver,
including a chip data entry, restricted dev/switch ops, DCB helper changes
for the reversed one-bit-per-DSCP TOS registers, and SPI mode 0 setup. It
also moves the legacy Micrel compatibles for KS8995, KSZ8795 and KSZ8864
over from the old KS8995 driver, made mutually exclusive through Kconfig.

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
Should the bindings be reconciled along with this ownership transfer?

These three compatibles are now handled by the KSZ driver, but
Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml (the binding
for this driver) only gained microchip,ksz8995xa in the series, and its
compatible enum does not list micrel,ks8995, micrel,ksz8795 or
micrel,ksz8864:

    compatible:
      enum:
        - microchip,ksz8463
        ...
        - microchip,ksz8895  # 5-port version of KSZ8895 family switch
        - microchip,ksz8995xa

The only schema describing the three legacy strings is
Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml, which stays a
closed schema allowing just compatible, reg, reset-gpios plus the dsa
ethernet-ports and spi-peripheral-props references:

    properties:
      compatible:
        enum:
          - micrel,ks8995
          - micrel,ksz8795
          - micrel,ksz8864
    ...
    unevaluatedProperties: false

For those same compatibles the KSZ driver now reads microchip,synclko-125,
microchip,synclko-disable, microchip,pme-active-high, wakeup-source, the
per-port micrel,fiber-mode and RGMII delay properties in
ksz_switch_register(), and microchip,io-drive-strength-microamp in
ksz8_parse_drive_strength(). Would a device tree using any of those on a
node with a micrel,* compatible now fail dt_binding_check/dtbs_check
because micrel,ks8995.yaml rejects them?

Also, that schema's description still says:

    The chip itself is managed over SPI, but all the
    PHYs need to be accessed from an external MDIO channel.

Does this still hold for the KSZ driver, which sets
internal_phy = {true, true, true, true, false} for KSZ8995XA and registers
its own MDIO bus through ksz_mdio_register()? Would folding the legacy
compatibles into microchip,ksz.yaml (or referencing it) and updating that
description avoid having two schemas describe the same driver-supported
silicon with divergent property sets?

[ ... ]

> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c
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
> +
> +		/* Some PHYs need additional settling time after reset. */
> +		usleep_range(1000, 2000);
> +	} else if (ksz_is_ksz88x3(dev)) {
>  		/* reset switch */
>  		ksz_cfg(dev, KSZ8863_REG_SW_RESET,
>  			KSZ8863_GLOBAL_SOFTWARE_RESET | KSZ8863_PCS_RESET, true);

[Severity: High]
Should these two loops be bounded to the ports that actually have
an internal PHY?

The KSZ8995XA chip data declares port_cnt = 5 and
internal_phy = {true, true, true, true, false}, i.e. port 4 is the
MAC-only CPU port. Both loops here run from 0 to
dev->info->port_cnt - 1, so port 4 also gets PORT_PHY_SOFT_RESET
written into REG_PORT_STATUS_3 by ksz_prmw8() and is then polled by
regmap_read_poll_timeout() waiting for that bit to self-clear. On a
port with no PHY behind it, is that bit guaranteed to be implemented
and self-clearing? If it is reserved, reads back as written, or reads
as one, the poll spins for the full 600 ms timeout and returns
-ETIMEDOUT, ksz8_reset_switch() propagates that to ksz8_setup(),
which prints "failed to reset switch" and aborts the probe - so the
switch would never come up at all.

Even in the benign case where the CPU port register happens to read
back zero, the write and the poll on port 4 look like they have no
meaning. Would it be better to iterate over dev->phy_port_cnt (set
by ksz8_switch_init() before setup runs), or to skip ports where
!dev->info->internal_phy[port], so that only real PHYs are reset and
polled? If including the CPU port is deliberate and the datasheet
documents the bit as self-clearing there too, a comment saying so
would help.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-ks8995-to-ksz8-v14-0-3d72692b3c97%40kernel.org
