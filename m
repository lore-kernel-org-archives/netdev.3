Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D146423E97;
	Wed,  2 Sep 2026 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342642; cv=none; b=GDiDteN/jslqSLeK3VRDwXg5z6ueDJ6hEmR9MqQEoMnGJDJ65qc/n2K7hvPqk7v0pX+BtxcjiRlXY2UBu3AHSlKiZqB/Lg91l4sWoWmn+pUOdBngrY4RFLWSsQyytvijXeNvyjJjV3e68CFike3PXMZnxVJC9KteQGSoKkYTwwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342642; c=relaxed/simple;
	bh=uL2swQmzYyTQNfow4ZiszeIOhbCBEr5l5qoMgWlY+n0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NG3ek1Gr3Uk6GVGEmSTnO+OnZK4KsSjhyaYmAJk7ENh5DeTrswFEoTU+yfPrfMIx+0FCeJLd3TtPhlRTg3B/OE+lnSdCrRg1xFziaaj087Aw7v1k96eX5hsBuJXCmeKdB6KhyCwnw9JQFKIG/dT0n4VNsAEhEl5HzRX2XwLdiec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqboXYEH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqboXYEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2331B1F00A3A;
	Wed,  2 Sep 2026 09:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788342637;
	bh=XZoBCkjmXXqwSmEgPl8Zrltg3R80/ETwA+UfClc5skw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BqboXYEHzrmMAjsDaYl4qzV4FgDUCjwTwXcX2mA/+ifesgnCcp3o89o3UlqallM2t
	 78QeqoycC6rIVQaYBoPH26H1nUAnXy8kU81IykZ+VDOVtuyd4B+HFoU1vAEkwQujZZ
	 H/BHScwphyUVVy2NA6+Ns12bTqIGF7Q+crQWB29X71W46XL4jqaj3k8n9ryVvF1U4b
	 LGVzMuSqy1hf/DMQosxEi+eR4W+8TubxSufo/eSwjNmyARkPDsFWakgCu1ZMThCuDR
	 UT93ncgkAZpOMmyFLw50CltOBMihdAh7YxbfePxle2y2sxrNsb4w6pCHyq+1YHyw45
	 tLuly0Nl+Oujg==
Subject:
 Re: [net-next,v8,1/5] net: dsa: microchip: Add fallback Micrel compatibles
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Wed, 02 Sep 2026 09:50:35 +0000
Message-ID: <178834263564.3394541.15921471896862717450@kernel.org>
In-Reply-To: <20260831-ks8995-to-ksz8-v8-1-fd1dbb2b76e8@kernel.org>
References: <20260831-ks8995-to-ksz8-v8-1-fd1dbb2b76e8@kernel.org>
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

Critical: 0 · High: 0 · Medium: 3 · Low: 1

- [Medium] The mutual exclusion the commit message claims to establish
  ("Make the KS8995 driver mutually exclusive with this driver to avoid…
- [Medium] At this commit the new `depends on !NET_DSA_MICROCHIP_KSZ_SPI`
  disables the whole KS8995 driver whenever NET_DSA_MICROCHIP_KSZ_SPI=y,…
- [Medium] Adding "micrel,ksz8864" to ksz_dt_ids redirects existing
  device trees for the KSZ8864RMN to a driver with a different DSA-…
- [Low] The KSZ SPI driver now binds "micrel,ksz8864" and
  "micrel,ksz8795" (and, at the series tip, "micrel,ks8995"), but…

--

net: dsa: microchip: Add fallback Micrel compatibles

This adds the legacy "micrel,ksz8864" and "micrel,ksz8795" compatibles to
ksz_dt_ids in the KSZ SPI driver, and makes NET_DSA_KS8995 depend on
!NET_DSA_MICROCHIP_KSZ_SPI so the two drivers are not built together.

> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index 676fb7dffe14f..68fb175cc36ab 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -110,6 +110,7 @@ config NET_DSA_RZN1_A5PSW
>  config NET_DSA_KS8995
>  	tristate "Micrel KS8995 family 5-ports 10/100 Ethernet switches"
>  	depends on SPI
> +	depends on !NET_DSA_MICROCHIP_KSZ_SPI

[Severity: Medium]
Does this actually make the two drivers mutually exclusive for modular
builds?  NET_DSA_MICROCHIP_KSZ_SPI is a tristate, and Kconfig implements
negation as arithmetic on the tristate value:

scripts/kconfig/expr.h:
    #define EXPR_NOT(dep)	(2-(dep))

so !m evaluates to m, not n.  That leaves
NET_DSA_MICROCHIP_KSZ_SPI=m together with NET_DSA_KS8995=m legal, both
modules get built, and both claim the same OF compatibles:

ksz_dt_ids in drivers/net/dsa/microchip/ksz_spi.c:
    { .compatible = "micrel,ksz8864", ... },
    { .compatible = "micrel,ksz8795", ... },

ks8995_spi_of_match in drivers/net/dsa/ks8995.c:
    { .compatible = "micrel,ks8995" },
    { .compatible = "micrel,ksz8864" },
    { .compatible = "micrel,ksz8795" },

The SPI modaliases "ksz8864"/"ksz8795" in ks8995_id overlap too, so which
driver binds a given node depends on module registration order, which is
the probe race the commit message says is being avoided.  Would
"depends on NET_DSA_MICROCHIP_KSZ_SPI=n" be the expression you want here,
or should the overlapping IDs simply be removed from ks8995.c?

For the record, this transient state does not survive the series: the later
patch "net: dsa: ks8995: Delete surplus driver" (59dbca612286) drops this
dependency line and deletes drivers/net/dsa/ks8995.c.

[Severity: Medium]
As of this commit, does this dependency leave "micrel,ks8995" without any
driver?  With NET_DSA_MICROCHIP_KSZ_SPI=y the whole KS8995 driver is
forced off, but ksz_dt_ids here only picks up ksz8864 and ksz8795 and goes
straight on to "microchip,ksz8463" - there is no "micrel,ks8995" entry and
no KSZ8995XA chip data yet.  ks8995_spi_of_match is the only match for
that string, and it is used by two in-tree device trees:

    arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts
    arch/arm/boot/dts/intel/ixp/intel-ixp42x-actiontec-mi424wr.dtsi

both with:
    compatible = "micrel,ks8995";

and documented in
Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml.  On those
boards the switch would no longer be probed in a KSZ_SPI=y build, and
make olddefconfig silently drops NET_DSA_KS8995.

This is repaired later in the same series: "net: dsa: microchip: Support
Microchip KSZ8995XA / KS8995XA" (65df0673d386) adds the "micrel,ks8995"
match with KSZ8995XA chip data, and 59dbca612286 turns NET_DSA_KS8995 into
a stub selecting the KSZ driver.  Would it be worth ordering the series so
this commit does not open a bisect window where KS8995 support disappears?

>  	select NET_DSA_TAG_NONE
>  	help
>  	  This driver supports the Micrel KS8995 family of 10/100 Mbit ethernet
> diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
> index 373e9054947cb..77aecac324667 100644
> --- a/drivers/net/dsa/microchip/ksz_spi.c
> +++ b/drivers/net/dsa/microchip/ksz_spi.c
> @@ -224,6 +224,21 @@ static void ksz_spi_shutdown(struct spi_device *spi)
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

[Severity: Medium]
Does this change the port numbering seen by existing "micrel,ksz8864"
device trees?  The two drivers model the same chip differently.

ksz_switch_chips[KSZ8864] in drivers/net/dsa/microchip/ksz_common.c:
    /* WARNING
     * KSZ8864 is similar to KSZ8895, except the first port
     * does not exist.
     *           external  cpu
     * KSZ8864   1,2,3      4
     */
    .internal_phy = {false, true, true, true, false},
    .supports_mii = {false, false, false, false, true},

drivers/net/dsa/ks8995.c, the previous owner of this compatible:
    /* In DSA the ports 1-4 are numbered 0-3 and the CPU port is port 4 */
    #define KS8995_REG_PC(p, r)	(0x10 + (0x10 * (p)) + (r))

and ks8995_phylink_get_caps() marks every port <= 3 as an internal-PHY
user port, including for [ksz8864] = { .name = "KSZ8864RMN" }.

So a device tree written for the old driver describes ethernet-port@0..@3
as user ports.  Bound to the KSZ driver, port 0 has internal_phy and all
supports_* false, so ksz_phylink_get_caps() leaves supported_interfaces
empty and phylink_create() rejects it:

drivers/net/phy/phylink.c:
    if (phy_interface_empty(config->supported_interfaces)) {
        dev_err(config->dev,
            "phylink: error: empty supported_interfaces\n");
        return ERR_PTR(-EINVAL);

which fails dsa_register_switch().  If port@0 is omitted instead, the
third real user port at register block 0x40 is never described and its PC2
bits stay at reset values.

No in-tree device tree uses micrel,ksz8864, so this only affects
out-of-tree trees written against the ks8995 numbering, and the KSZ model
is the one matching Microchip's documentation.  Could the commit message
or the binding mention that the port semantics of this already-documented
compatible change?

> +	{
> +		.compatible = "micrel,ksz8795",
> +		.data = &ksz_switch_chips[KSZ8795]
> +	},

[Severity: Low]
Should the DT bindings be updated along with these matches?
Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml, which
describes this driver's contract, has a closed compatible enum that starts
at "microchip,ksz8463" and lists no micrel,* string.  The only schema
matching these compatibles is micrel,ks8995.yaml, and it ends with:

    unevaluatedProperties: false

allowing nothing beyond reg, reset-gpios, dsa.yaml ethernet-ports and
spi-peripheral-props.  A tree that uses the features of the more capable
driver referred to in the commit message - an mdio child node with
ethernet-phy@N, interrupts, wakeup-source, microchip,synclko-125, the
microchip,*-drive-strength-microamp properties - is then rejected by
dt_binding_check/dtbs_check for these compatibles.

At the tip of the series (59dbca612286) neither schema covers this:
microchip,ksz.yaml only gained "microchip,ksz8995xa" and micrel,ks8995.yaml
is untouched.  Would listing the micrel,* strings in microchip,ksz.yaml,
including in the existing if/then blocks next to microchip,ksz8795 and
microchip,ksz8864, be the right fix?

>  	{
>  		.compatible = "microchip,ksz8463",
>  		.data = &ksz_switch_chips[KSZ8463]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-ks8995-to-ksz8-v8-0-fd1dbb2b76e8%40kernel.org
