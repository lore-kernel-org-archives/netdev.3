Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B053C1A;
	Tue,  8 Sep 2026 03:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788839393; cv=none; b=UKIWUOHbLMW9HWaCnIBMvY2SErhjoKiAubq2UVrWtDrUQvqSy57eYfIMVWe+j3Dr+dNfju6XBkrFVLt5BRlxsSKadh+0ONK4duB+D/T90e9OQ0T9bzwCg6X5yBuC/7LmTWo8DKCF/KrMf/rNcjY/MFBI+Oo1O9jW7rRsYzSCs94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788839393; c=relaxed/simple;
	bh=J7gSVQ50zSTgz0M9d6E9TBC5PgylRRg1sqSjkBgar0w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UVjUCDUhTwBK199Egv4hJ6l2h0p3nrAyxdcDq38ulmGe1lFh4IvufsUoZ7VS/Uz2Vn8RCOSuRGqXK66+AFvZb134XJ/Z5CQz3C5HJNJyahLPgSP2DmDFr12gVV9CawOZgEL3BA3wCXuyZ+5rUG0HkRy15jPKXkITk1YFfwHoxfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A919xKv2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A919xKv2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFB41F00A3A;
	Tue,  8 Sep 2026 03:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788839388;
	bh=PvwgdqOq/o16bPAZXWMfhyGsJc4zPGN4eic3geCCrk8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=A919xKv2kiSqbuD4sqVmVz3NXrQVVWid/ZgM1SP2SyvQ/N/n8Iueqc5bmraMGQHRL
	 NzMSCGz2hyirQooBQcpCGvcqDKtZp2YV4qLF26qkxa7zUjXIuektYUFH4Z8jcDNMBM
	 oTvdsgPPIU1oKUyz5zGEt4USVES8NKp3pnKGAIFV4kOKBDA3HlVxJgELJLplZPMUbA
	 jUR8WUsOGDvOLOJXMytzPUCvzzgOtprwb0dLtjD2mkw+C/9d0nsgEsARKzaAe52xt6
	 Nl6WPPD2NjSai6SBWPn/5ch4khVW4XCQVFVe1BW+i5jRdajSUXbyGTLEreVJRXcQ9O
	 vs30iLeZdHW5w==
Subject: Re: [PATCH net-next v9 4/4] net: dsa: ks8995: Delete surplus driver
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 08 Sep 2026 03:49:47 +0000
Message-ID: <178883938748.219967.12302213755391446012@kernel.org>
In-Reply-To: <20260906-ks8995-to-ksz8-v9-4-8d8815a91bd8@kernel.org>
References: <20260906-ks8995-to-ksz8-v9-4-8d8815a91bd8@kernel.org>
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

- [Medium] Deleting drivers/net/dsa/ks8995.c leaves the ambiguous legacy
  compatible "micrel,ks8995" handled unconditionally as a KSZ8995XA by…
- [Medium] The SPI ID table entries added for the KS8995 migration do not
  line up with the DT compatibles they are supposed to cover.
- [Low] The transitional stub added by this patch
  (drivers/net/dsa/Kconfig:110-119) tells KS8995 users that…

--

net: dsa: ks8995: Delete surplus driver

This removes drivers/net/dsa/ks8995.c and its Makefile entry, and turns
NET_DSA_KS8995 into a transitional Kconfig stub that selects the Microchip
KSZ SPI driver instead. Users of the old driver are expected to be phased
over to NET_DSA_MICROCHIP_KSZ_SPI when they migrate their configs.

> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index e309e4c1ee3a9..55a9714033a6f 100644
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

[Severity: Medium]
After this deletion, is the ambiguous "micrel,ks8995" compatible handled
only as a KSZ8995XA?  In ksz_spi.c the ksz_dt_ids table has:

	{
		.compatible = "micrel,ks8995",
		.data = &ksz_switch_chips[KSZ8995XA]
	},

and ksz_switch_detect() keeps that classification for the shared ID:

	case KSZ8895_FAMILY_ID:
		if (id2 == KSZ8895_CHIP_ID_95XA) {
			dev->chip_id = KSZ8995XA_CHIP_ID;

KSZ8895_CHIP_ID_95XA is 0x0, which is the 0x95/0x0 pair the commit message
describes as unable to distinguish MA from XA.

Does that mean MA silicon now gets programmed on the XA path?
ksz8_setup() does:

	if (ksz_is_ksz8995xa(dev))
		ksz_cfg(dev, REG_SW_CTRL_9, SW_SPECIAL_TAG, true);

and ksz8_port_setup() writes the per-port tag bits:

		if (cpu_port)
			ksz_port_cfg(dev, port, REG_PORT_CTRL_0, PORT_INSERT_TAG, true);
		else
			ksz_port_cfg(dev, port, REG_PORT_CTRL_0, PORT_REMOVE_TAG, true);

The tagging model also changes for these DT nodes: the deleted driver's
ks8995_get_tag_protocol() returned DSA_TAG_PROTO_NONE, while
ksz8995xa_get_tag_protocol() returns DSA_TAG_PROTO_KS8995.

Two in-tree device trees instantiate exactly this compatible:

	arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts
	arch/arm/boot/dts/intel/ixp/intel-ixp42x-actiontec-mi424wr.dtsi

			compatible = "micrel,ks8995";

so both boards move to the XA path and to a different tagger.  Since the
commit message only says "No KS8995MA users are known" and "Neither variant
has been verified with the replacement driver", could it also mention these
two boards and the DSA_TAG_PROTO_NONE to DSA_TAG_PROTO_KS8995 change?

[Severity: Medium]
With all old KS8995 configurations now routed to ksz_spi.c, do the SPI ID
table and the compatible list there line up?  ksz_spi_ids contains:

	{ "ksz8995" },

but the compatible added for this part in ksz_dt_ids is:

	{
		.compatible = "microchip,ksz8995xa",
		.data = &ksz_switch_chips[KSZ8995XA]
	},

__spi_register_driver() strips the vendor prefix and looks up the remainder
with spi_match_id():

	drivers/spi/spi.c:__spi_register_driver() {
		...
			pr_warn("SPI driver %s has no spi_device_id for %s\n",
				sdrv->driver.name, of_id->compatible);
		...
	}

Does this print a warning on every registration of the ksz-switch driver,
and does module autoloading fail for a DT using "microchip,ksz8995xa"
because the uevent carries MODALIAS=spi:ksz8995xa while the module only
exports spi:ksz8995?  Renaming the entry to "ksz8995xa" would seem to cover
both.

Separately, the new "ks8995" ID carries no driver_data, and ksz_spi_probe()
takes the chip description only from the firmware node:

	chip = device_get_match_data(ddev);
	if (!chip)
		return -EINVAL;

so a board-file SPI device named "ks8995" cannot probe.  This part matches
the pre-existing convention of the whole ksz_spi ID table (none of the
entries carry driver_data) and the commit message's statement that nothing
in tree uses that mechanism, which does hold for the current tree.

[Severity: Low]
This isn't a bug, but the help text below points migrating users at
NET_DSA_MICROCHIP_KSZ_SPI, whose chip enumeration lives in the parent
menuconfig NET_DSA_MICROCHIP_KSZ_COMMON in drivers/net/dsa/microchip/Kconfig:

	  This driver adds support for Microchip KSZ8, KSZ9 and
	  LAN937X series switch chips, being KSZ8863/8873,
	  KSZ8895/8864, KSZ8794/8795/8765,
	  KSZ9477/9897/9896/9567/8567, KSZ9893/9563/8563 and
	  LAN9370/9371/9372/9373/9374.

That list does not mention KS8995 or KSZ8995XA, even though ksz_dt_ids has
both "micrel,ks8995" and "microchip,ksz8995xa" entries.  Could the chip list
be updated so users landing there find their device?

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

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906-ks8995-to-ksz8-v9-0-8d8815a91bd8%40kernel.org
