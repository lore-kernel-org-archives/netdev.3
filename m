Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58A54825A8;
	Thu, 10 Sep 2026 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070526; cv=none; b=loie1xHRdnCxov6vd4Y7fAZ7xVrA9BHh+eJKtqhG1TBS9JdRyQs+b4+Topy/Veo0V8h+0iluyrw1KawqwDE+nPs3y0yjMyavn/Fyfnl4BrEFxk+bHZXuXZcZPs0x87g6p614UNYPJNpX1XL/62YgvoRZhZJUmXqtZfmpDkz5+k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070526; c=relaxed/simple;
	bh=lsnZ9FEErTzPI6kczqdyCGmd3+HhdRLdrbBHbeokNns=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CI+PbxN5TJkX0LlmpxrQGzME4LHeJG+fkNYXtl19vz7wi2NyaWftx2HwwQ+qgO5bxHQCQyDBesnRmdrLSB3YqQKa1ZmLxi8ViTn1cC7TSeVj7F2CKtLs9Gr62GmD+IPt70vQ7Esr1xnQF3WOK9jl1Wdn8hkA5qCXl++jW74Q8Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm+zOB8a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm+zOB8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796421F00893;
	Thu, 10 Sep 2026 20:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070524;
	bh=nfyOn+nEk/GMCi1Qa4cIAoJuiFBSov5lv9/s3UOize0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hm+zOB8a2bJT03EpmEnIASTXmvEjGimUWpZGJdbfplSbbulQkOgAblfHOaO0PFLpY
	 V+RFdi0Bg1oQSL/Dko0ZSfcQA3oJ8HGgUobCgRcFCZXoCdGvRBMZciRR2a3S1n28Bn
	 4aYvIvEZ3Z+0xXl4PrYDc29/ERHqyaMCX6QQCJexx/wzCAKFzPwFExa8XH5F26OeCb
	 HqzUzfbFRQXUKEbN6YWyswSyfVJSZuL/5cughzr6cO17XpVQZhL+O6WZBnrgLW88/Q
	 aiD0zvtKMOWcCTy57y+nX6xY+DQwBZlkF95OedUYwpBVULbXLJl77S67nyzHLdCo9S
	 23BCujS+BATGA==
Subject: Re: [PATCH net-next v11 4/4] net: dsa: ks8995: Delete surplus driver
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Thu, 10 Sep 2026 20:02:03 +0000
Message-ID: <178907052301.219967.24777314580254394@kernel.org>
In-Reply-To: <20260909-ks8995-to-ksz8-v11-4-0e04411a559d@kernel.org>
References: <20260909-ks8995-to-ksz8-v11-4-0e04411a559d@kernel.org>
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

- [Low] Incomplete DT-binding transition: after drivers/net/dsa/ks8995.c
  is deleted, the compatibles "micrel,ks8995", "micrel,ksz8795" and…

--

net: dsa: ks8995: Delete surplus driver

The old ks8995 DSA driver is removed because the Microchip KSZ driver now
handles the KS(Z)8995XA, and the NET_DSA_KS8995 Kconfig symbol is turned
into a transitional stub that selects the KSZ SPI driver instead.  The two
in-tree device trees using "micrel,ks8995" are said to keep working with
the replacement driver.

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
>  	help
> -	  This driver supports the Micrel KS8995 family of 10/100 Mbit ethernet
> -	  switches, managed over SPI.
> +	  This is a transitional option for users who had NET_DSA_KS8995
> +	  enabled. It automatically enables the new NET_DSA_MICROCHIP_KSZ_SPI
> +	  driver which supersedes it. This option will be removed in a future
> +	  kernel release.

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
> -MODULE_DEVICE_TABLE(of, ks8995_spi_of_match);

[Severity: Low]
Should the device tree bindings move over together with the driver here?

After this deletion, "micrel,ks8995", "micrel,ksz8795" and "micrel,ksz8864"
are documented only in
Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml, which was
written for the driver being removed:

  properties:
    compatible:
      enum:
        - micrel,ks8995
        - micrel,ksz8795
        - micrel,ksz8864
    reg: ...
    reset-gpios: ...
  ...
  unevaluatedProperties: false

The driver that now matches those compatibles is
drivers/net/dsa/microchip/ksz_spi.c, whose ksz_dt_ids still carries:

  {
          .compatible = "micrel,ks8995",
          .data = &ksz_switch_chips[KSZ8995XA]
  },

ksz_spi_probe() does dev->irq = spi->irq, and ksz_mdio_register() looks up
an "mdio" child node and an "mdio-parent-bus" phandle.  Those properties are
described in microchip,ksz.yaml but rejected by micrel,ks8995.yaml because of
unevaluatedProperties: false.  Does that mean a node using the legacy
compatible with interrupts or an mdio child node now fails dt_binding_check?

In the other direction, microchip,ksz.yaml gained microchip,ksz8995xa but
lists none of the three micrel,* strings, so the two in-tree nodes named in
the commit message, ethernet-switch@0 in
arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts and in
arch/arm/boot/dts/intel/ixp/intel-ixp42x-actiontec-mi424wr.dtsi, cannot be
validated against the binding of the driver that handles them.  Would it make
sense to fold the legacy compatibles into microchip,ksz.yaml, marking them
deprecated as appropriate?

One more detail in the surviving schema: the description states

  The chip itself is managed over SPI, but all the
  PHYs need to be accessed from an external MDIO channel.

while the chip data for KSZ8995XA in drivers/net/dsa/microchip/ksz_common.c
declares

  .internal_phy = {true, true, true, true, false},

Is that sentence still accurate for the replacement driver?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-ks8995-to-ksz8-v11-0-0e04411a559d%40kernel.org
