Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192742EEA3;
	Wed,  2 Sep 2026 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342645; cv=none; b=iB1qupaHjhlfZsFU4Yt0jXDIJ3MUA8Zka7PdgOU8JUvYiM5steTVKaCiIpbAUlNbp/yQbu/O0mGrr0Clgh0zxZyp0/yqDEj9kgbpXb4O2tQsFeMfvfITIuxxtURNxSU3BRBmGCTKvvEIGB8ZJ/2t5243X4ziYR9pOPp3pp97Iic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342645; c=relaxed/simple;
	bh=CWUt60UqcnfEvxhPNCZvxyQOINUAkeOvpmNIpzIwg64=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PSpf2wI15IZvQUJUXILPSsJJzsrob1U3MuivStrQGOPVx78R4LcIiS7TZRt94jzbeByAIq5fTCEjNodK6FZlhZM/owoHn57GRehEdEjIA5r3BYaODpDehVvzo+RZLloUmcuK+WVKyUEl4r423plARxeWl+NYUKRcTg6H9YKXcYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgK4P1Nu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgK4P1Nu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD9D1F00A3A;
	Wed,  2 Sep 2026 09:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788342643;
	bh=PAKXjOUuQBWD2QC0Iz5tEm1gL3UkPRkGVSnuq5xJXTM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SgK4P1NuvfIoxzQ3RqBtAbOWwqKpkH4cUYqeDSdr4AKbDR2/SGV87o2uICfNSQWjU
	 PxWxo/vzpEdwInkFv5h+X4/i0FYAJCEPxudjFjgsPRCEgpG3WTV4UvEIhQ0H7uuhdV
	 LdZ+m7sk+x/xcJKD+VIYNt/LbsSzEYMS8BD1eQKU5NwkgSN1seAhLmD3Mnd9AFEFCv
	 A2DL0D80tgu3q5gpSFqd2d52gBP7WMH3vMICg+LIq2+UBEeIEPjDGn32X2Ee9t69sd
	 5XYi15hT0rWLYgs+WSyfkE2onk777MQVO7sOd5Zc7NcFv2PRrV1Oq7oxGPlk1fxkoK
	 hZsmSWxOUzYVA==
Subject: Re: [net-next,v8,5/5] net: dsa: ks8995: Delete surplus driver
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Wed, 02 Sep 2026 09:50:42 +0000
Message-ID: <178834264228.3394541.12479851753660032697@kernel.org>
In-Reply-To: <20260831-ks8995-to-ksz8-v8-5-fd1dbb2b76e8@kernel.org>
References: <20260831-ks8995-to-ksz8-v8-5-fd1dbb2b76e8@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] After this patch drivers/net/dsa/microchip/ksz_spi.c (ksz_dt_ids,
  lines 236-249) is the only implementation of the compatibles…

--

net: dsa: ks8995: Delete surplus driver

This removes drivers/net/dsa/ks8995.c and its Makefile entry, since the
Microchip ksz driver now covers the same switches. NET_DSA_KS8995 is kept
in Kconfig as a transitional symbol that selects the ksz SPI driver.

> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index 68fb175cc36ab..55a9714033a6f 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -110,11 +110,13 @@ config NET_DSA_RZN1_A5PSW
>  config NET_DSA_KS8995
>  	tristate "Micrel KS8995 family 5-ports 10/100 Ethernet switches"
>  	depends on SPI
> -	depends on !NET_DSA_MICROCHIP_KSZ_SPI
> -	select NET_DSA_TAG_NONE
> +	select NET_DSA_MICROCHIP_KSZ_COMMON
> +	select NET_DSA_MICROCHIP_KSZ_SPI
>  	help
> -	  This driver supports the Micrel KS8995 family of 10/100 Mbit ethernet
> -	  switches, managed over SPI.
> +	  This is a transitional option for users who had NET_DSA_KS8995
> +	  enabled. It automatically enables the new NET_DSA_MICROCHIP_KSZ_SPI
> +	  driver which supersedes it. This option will be removed in a future
> +	  kernel release.
>  
>  config NET_DSA_SMSC_LAN9303
>  	tristate

[ ... ]

> diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
> deleted file mode 100644
> index 77d8b842693c1..0000000000000
> --- a/drivers/net/dsa/ks8995.c
> +++ /dev/null

[ ... ]

> -static const struct of_device_id ks8995_spi_of_match[] = {
> -	{ .compatible = "micrel,ks8995" },
> -	{ .compatible = "micrel,ksz8864" },
> -	{ .compatible = "micrel,ksz8795" },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, ks8995_spi_of_match);

[Severity: Low]
Should the devicetree binding be folded over as well when these three
compatibles move to the ksz driver?

After the deletion, ksz_dt_ids in drivers/net/dsa/microchip/ksz_spi.c is the
only implementation of micrel,ks8995, micrel,ksz8795 and micrel,ksz8864:

	{
		.compatible = "micrel,ksz8864",
		.data = &ksz_switch_chips[KSZ8864]
	},
	...
	{
		.compatible = "micrel,ks8995",
		.data = &ksz_switch_chips[KSZ8995XA]
	},

But the only schema selecting those strings is
Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml, which was
written for the deleted driver and ends with:

	unevaluatedProperties: false

allowing only compatible, reg, reset-gpios, the dsa.yaml ethernet-ports and
spi-peripheral-props.

The surviving driver parses more than that for these chips. For example
ksz_mdio_register() in drivers/net/dsa/microchip/ksz_common.c does:

	mdio_np = of_get_child_by_name(dev->dev->of_node, "mdio");

and ksz_switch_register() looks at wakeup-source,
microchip,synclko-125/synclko-disable, microchip,pme-active-high,
micrel,fiber-mode and interrupts. Those properties are described only in
Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml, whose
compatible enum contains no micrel-prefixed string.

So a board that uses compatible = "micrel,ks8995" and adds an mdio child
node binds fine at runtime, but would dt_binding_check/dtbs_check reject it,
with no schema left that can describe it? Would it make sense to add the
micrel aliases to microchip,ksz.yaml (deprecated) or cross-reference it from
micrel,ks8995.yaml?

Both in-tree users, arch/arm/boot/dts/intel/ixp/intel-ixp42x-actiontec-mi424wr.dtsi
and arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts, only use
compatible, reg, spi-max-frequency and ethernet-ports, so nothing fails
today.

Related, is this part of the micrel,ks8995.yaml description still accurate
now that the ksz driver handles the chip?

  The chip itself is managed over SPI, but all the PHYs need to be accessed
  from an external MDIO channel.

ksz_switch_chips[KSZ8995XA] in ksz_common.c declares

	.internal_phy = {true, true, true, true, false},

and the ksz driver can register an internal MDIO bus for those PHYs, so the
sentence reads like a property of the removed driver rather than of the
hardware.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-ks8995-to-ksz8-v8-0-fd1dbb2b76e8%40kernel.org
