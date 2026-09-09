Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3560B563286;
	Wed,  9 Sep 2026 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957565; cv=none; b=qI2wW768bUmeOdWmEtsqfVo/2pNIMjPqMd8VHInANsTCO6vTJL98VZn2Sw2nLgUSh7z7/0NWb/kU9ZkYwfyOSl74lnJZMW6N9GuTlOY1PSNyiJNCcfvJgreoycG335FjMgXuedYFr4qvepqUFIcbizd+maXBRfny3jGNgTX3CWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957565; c=relaxed/simple;
	bh=VcgIdmNMYXI7yNdnB7holatvKQwONyu5My/mVct0ZEg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wc470xBi40qwdt60xVN6dSgWh77dgmVLwVs8TdU/wmZtm+eXhlYxxNdxeU99yg1k8R58U5pe+52TkhpBeJXF4gVxCOmt9U7JRenRDFdOKQG4kwMPcYl4lb3bQQS5EsnmXyFMvV7oANcqsAfAd+ndleNsYweWMC18NpDBE2/h9+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNXLF10t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNXLF10t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6091F00A3A;
	Wed,  9 Sep 2026 12:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788957563;
	bh=aBRTZZZvyK+ppw+WpnaWViM8laukFKs+n1HWm1orEGw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FNXLF10tkwhDlWAQQFzFEkyGjOPrqV1K6avOehEvyJxHwNZQs8xBGoxVYOF0zV2Ct
	 a3W3ORuFSihg4NmyrEC4arEoHuaxE3ivy4CIKXklPKkqOxeCen+scAbBgFtA6WnsxI
	 hN/B5Qn1E17AXIBP+JjRCL+LnieFMk2/aUzNqbhqEnaboDFDA1yxyNlSo6IY9wGwDQ
	 +Tc+9xXpTc2ID1tNNXVqnlSaXIbk25n+uMYeoudFy+NuvcUJflTSM2s7hebsZks+Cl
	 UnZJe2y2DEU55pPKceIFQEws7iDg0H5M9DdvtbouuDVvKvy65XVji6R0Xcyb5SXuJj
	 nEex2Gzb+MDLw==
Subject: Re: [PATCH net-next v10 4/4] net: dsa: ks8995: Delete surplus driver
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Wed, 09 Sep 2026 12:39:21 +0000
Message-ID: <178895756167.219967.14097789539530670509@kernel.org>
In-Reply-To: <20260908-ks8995-to-ksz8-v10-4-7379239eb65f@kernel.org>
References: <20260908-ks8995-to-ksz8-v10-4-7379239eb65f@kernel.org>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 3

- [Low] The Kconfig stub silently changes the DSA tag protocol for every
  existing CONFIG_NET_DSA_KS8995 user, and the commit message does not…
- [Low] After this deletion,
  Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml is the DT…
- [Low] The retired NET_DSA_KS8995 symbol is kept as a visible `tristate`
  with its original hardware-sounding prompt ("Micrel KS8995 family…

--

net: dsa: ks8995: Delete surplus driver

This removes drivers/net/dsa/ks8995.c and its Makefile rule, and turns
CONFIG_NET_DSA_KS8995 into a transitional Kconfig stub that selects the
Microchip KSZ SPI driver instead.  Three observations below, all minor.

> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index e309e4c1ee3a..55a9714033a6 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -110,11 +110,13 @@ config NET_DSA_RZN1_A5PSW
>  config NET_DSA_KS8995
>  	tristate "Micrel KS8995 family 5-ports 10/100 Ethernet switches"
>  	depends on SPI
> -	depends on NET_DSA_MICROCHIP_KSZ_SPI = n
> -	select NET_DSA_TAG_NONE
> +	select NET_DSA_MICROCHIP_KSZ_COMMON
> +	select NET_DSA_MICROCHIP_KSZ_SPI

[Severity: Low]
Should the commit message mention that this changes the CPU port framing
for existing users?

The deleted driver returned DSA_TAG_PROTO_NONE from
ks8995_get_tag_protocol(), while "micrel,ks8995" in ksz_dt_ids of
drivers/net/dsa/microchip/ksz_spi.c binds to
ksz_switch_chips[KSZ8995XA], whose ksz8995xa_get_tag_protocol() in
drivers/net/dsa/microchip/ksz8.c returns DSA_TAG_PROTO_KS8995
(needed_headroom = VLAN_HLEN in net/dsa/tag_ks8995.c).  ksz8_setup()
also programs the switch into special tagging mode:

	if (ksz_is_ksz8995xa(dev))
		ksz_cfg(dev, REG_SW_CTRL_9, SW_SPECIAL_TAG, true);

Until this patch the two drivers were mutually exclusive via
"depends on NET_DSA_MICROCHIP_KSZ_SPI = n", so this select is what flips
existing configs from untagged to 4-byte special-tag framing.

The commit message says the two in-tree device trees "continue to be
supported by the replacement driver without regressions" without noting
the tag protocol change.  Could that sentence be expanded?

[Severity: Low]
This isn't a bug, but both selected symbols are user-visible:
NET_DSA_MICROCHIP_KSZ_COMMON is a menuconfig with the prompt "Microchip
KSZ8XXX/KSZ9XXX/LAN937X series switch support" and
NET_DSA_MICROCHIP_KSZ_SPI is a tristate with the prompt "KSZ series SPI
connected switch driver".

Documentation/kbuild/kconfig-language.rst says "In general use select
only for non-visible symbols (no prompts anywhere) and for symbols with
no dependencies".  While CONFIG_NET_DSA_KS8995 is set, neither the KSZ
menuconfig nor the KSZ SPI driver can be set to n, and menuconfig gives
no hint about what is forcing them on.

The same file already uses the prompt-less pattern for symbols that are
meant to be selected:

config NET_DSA_SMSC_LAN9303
	tristate
	select NET_DSA_TAG_LAN9303
	...

Would dropping the prompt on NET_DSA_KS8995 work better here?

>  	help
> -	  This driver supports the Micrel KS8995 family of 10/100 Mbit ethernet
> -	  switches, managed over SPI.
> +	  This is a transitional option for users who had NET_DSA_KS8995
> +	  enabled. It automatically enables the new NET_DSA_MICROCHIP_KSZ_SPI
> +	  driver which supersedes it. This option will be removed in a future
> +	  kernel release.

[Severity: Low]
Related to the above: the symbol keeps the hardware-style tristate prompt
"Micrel KS8995 family 5-ports 10/100 Ethernet switches" even though the
Makefile rule is gone, so the menu now offers a driver that builds no
code and whose y/m distinction has no meaning.  Should the prompt be
retitled as deprecated, and should the help text name the kernel release
in which it will be removed?

> diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
> index 6ceb78a755d7..9923137429f8 100644
> --- a/drivers/net/dsa/Makefile
> +++ b/drivers/net/dsa/Makefile
> @@ -2,7 +2,6 @@
>  obj-$(CONFIG_NET_DSA_BCM_SF2)	+= bcm-sf2.o
>  bcm-sf2-objs			:= bcm_sf2.o bcm_sf2_cfp.o
>  obj-$(CONFIG_NET_DSA_LOOP)	+= dsa_loop.o
> -obj-$(CONFIG_NET_DSA_KS8995) 	+= ks8995.o

[ ... ]

> diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
> deleted file mode 100644
> index 77d8b842693c..000000000000
> --- a/drivers/net/dsa/ks8995.c
> +++ /dev/null
> @@ -1,857 +0,0 @@

[ ... ]

> -static const struct of_device_id ks8995_spi_of_match[] = {
> -	{ .compatible = "micrel,ks8995" },
> -	{ .compatible = "micrel,ksz8864" },
> -	{ .compatible = "micrel,ksz8795" },
> -	{ },
> -};

[Severity: Low]
Does Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml need an
update in the same patch?  After this deletion it is the DT contract for
hardware whose only implementation is
drivers/net/dsa/microchip/ksz_spi.c, and its description says:

  The chip itself is managed over SPI, but all the
  PHYs need to be accessed from an external MDIO channel.

That matched the deleted driver, which had no .phy_read/.phy_write, but
ksz_switch_chips[KSZ8995XA] in drivers/net/dsa/microchip/ksz_common.c
declares:

		.internal_phy = {true, true, true, true, false},

and the KSZ driver provides ksz8_phy_read16()/ksz8_phy_write16().

The schema also keeps a narrow "unevaluatedProperties: false" whitelist,
while these same three micrel,* compatibles are now served by the driver
documented in microchip,ksz.yaml, so future KSZ binding additions will
not apply to them.  Note the file cannot simply be dropped, since
arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts and
intel-ixp42x-actiontec-mi424wr.dtsi still use "micrel,ks8995".

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-ks8995-to-ksz8-v10-0-7379239eb65f%40kernel.org
