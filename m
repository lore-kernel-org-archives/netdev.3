Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CFD48F82F;
	Mon, 21 Sep 2026 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996101; cv=none; b=ArecrTjVtXEC3wsdGCHzXqIbbodszEfPFWbU4DGcyy2CjL3T39ic/6cRbx8JaMJ5t8osRSUHDQ9OoS7DyZUmqGZOJQvGXCkSE7Q6daoaXrS6yEz5egwXonLR9Gh1gFTQMc1mKdIhHo8Xoy/US5BYdybTa3xEHbCg4ui7Keos76M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996101; c=relaxed/simple;
	bh=QSgBOvaFBCUjJ++WCPgDMRN07CnNxYlp9nFy0oqkWkA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fa98QEk68zbhhSMdD7A6/8tJBJMupWncWlQf4ZBvz8U/0es8aVyzVNO2gZMH8ktA9SdzzWxohu2PXMkzdfp00fFWZnKvm9vqa07Eec/94zIof5odeGIearfZKQLObbfX9rBJL7d1y83JJbf/HXyPHoD+Mz/wpAT7hGPmP7jK8w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jutjQXKQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jutjQXKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E831F000FF;
	Mon, 21 Sep 2026 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789996100;
	bh=Gzz6FOV+ihb6XY6fR1yWdHLsJygnj1TQ+0PTlX8dy6o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jutjQXKQt8K6B0xwKgv+5DKEb5jeEZ9f4C/ODLNIaJm89wXXv7vEK7sftym6VdTWZ
	 iWmXtpr5oBvd/fTs7Pnr+UITsvv31HyGnQ+iOx3dgtyyEq4uQpeN9MZAEWN/rJ+QRd
	 o5w8NXUfLIIFh+A6kq6qdPe/r+5hRcNYXF1atuMwz1gCfIMayhWGLIGhiWMHNAQhWS
	 3COIgiullYPWAz7+bvYXkrumeCx8KTXqLiPGlsZq7uoeCxzB3uz2Dz/PKfKftNH2h4
	 D7hNOPpq1slIm8JHsXKzU3vyIHlaU3U96hShCHNR8rtBPOwgutM3G6Ruk7ufnYL6j/
	 YKfjqqT4l267g==
Subject: Re: [PATCH v6 net-next] net: phy: mediatek: support MT7530 PHYs on
 EN71221 MCM
From: netdev-bot+sashiko@kernel.org
To: cjd@cjdns.fr
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, dqfext@gmail.com,
 SkyLake.Huang@mediatek.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 srherobrine20@gmail.com
Date: Mon, 21 Sep 2026 13:08:19 +0000
Message-ID: <178999609903.2160803.13587309272665638742@kernel.org>
In-Reply-To: <20260917130534.297930-1-cjd@cjdns.fr>
References: <20260917130534.297930-1-cjd@cjdns.fr>
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
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new "EcoNet EN751221 MCM PHY" driver entry can never bind,
  because its gate en751221_is_mcm_phy() (drivers/net/phy/mediatek/mtk-…
- [High] mt7530_is_gphy() (drivers/net/phy/mediatek/mtk-ge.c:150-154)
  masks the raw return value of phy_read(phydev, MII_ESTATUS) with…

--

net: phy: mediatek: support MT7530 PHYs on EN71221 MCM

This adds a second phy_driver entry for the MT7530 PHYs found on the
EcoNet EN751221 multi-chip module, which need extra register writes at
config_init time.  The MT7530 entry loses PHY_ID_MATCH_EXACT and both
entries now select hardware through custom match_phy_device callbacks.

> diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
> index 96d8ac5154e5e..62e3eff37b800 100644
> --- a/drivers/net/phy/mediatek/mtk-ge.c
> +++ b/drivers/net/phy/mediatek/mtk-ge.c

[ ... ]

> @@ -101,6 +102,69 @@ static int mt7530_phy_config_init(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +/*
> + * The EcoNet EN751221 "G" multi-chip module MT7530 requires additional PHY
> + * configuration.
> + */
> +static int en751221_mcm_phy_config_init(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_soft_reset(phydev);
> +	if (ret)
> +		return ret;
> +

[ ... ]

> +	return mt7530_phy_config_init(phydev);
> +}
> +
> +static bool en751221_is_mcm_phy(struct phy_device *phydev)
> +{
> +	struct device *parent = phydev->mdio.bus->parent;
> +
> +	return parent && parent->of_node &&
> +	       of_device_is_compatible(parent->of_node, "econet,en751221");
> +}

[Severity: High]
Can en751221_is_mcm_phy() ever return true?  The string
"econet,en751221" is documented as a root node compatible only:

Documentation/devicetree/bindings/mips/econet.yaml:
    properties:
      $nodename:
        const: '/'

      compatible:
        oneOf:
          - description: Boards with EcoNet EN751221 family SoC

and the only in-tree users are the root nodes of
arch/mips/boot/dts/econet/en751221.dtsi and
en751221_smartfiber_xp8421-b.dts.

The node inspected here is the MDIO bus parent, which is the switch or
MAC device, for example in mt7530_setup_mdio():

drivers/net/dsa/mt7530.c:
    bus->parent = dev;

so parent->of_node carries a switch compatible such as
"mediatek,mt7530" or "mediatek,mt7621", not the machine compatible.
Does that make en751221_phy_match() always return 0, leaving the new
"EcoNet EN751221 MCM PHY" entry unreachable and EN751221 MCM boards
silently bound to the plain "MediaTek MT7530 PHY" entry instead?

If the intent is machine level detection, would
of_machine_is_compatible() be the matching API here?  If node level
detection is intended, which compatible is expected on the switch or
MDIO node?  I could not find an EN751221 switch or MDIO node or driver
compatible upstream at all - grepping for "econet," under drivers/net/
only turns up "econet,en7528-switch" in mt7530-mmio.c plus this new
string - so is there any configuration in which this path runs today?

Also, the subject says "EN71221 MCM" while the changelog body and the
code use EN751221.

> +
> +/*
> + * MTK_GPHY_ID_MT7530 ID is also used for an EcoNet SoC FE phy, but that PHY
> + * does not advertise ESTATUS_1000_TFULL.
> + */
> +static bool mt7530_is_gphy(struct phy_device *phydev)
> +{
> +	return phydev->phy_id == MTK_GPHY_ID_MT7530 &&
> +	       (phy_read(phydev, MII_ESTATUS) & ESTATUS_1000_TFULL) != 0;
> +}

[Severity: High]
Should the phy_read() return value be checked for an error before it is
masked?  ESTATUS_1000_TFULL is BIT(13):

include/uapi/linux/mii.h:
    #define ESTATUS_1000_TFULL	0x2000	/* Can do 1000BT Full          */

phy_read() forwards mdiobus_read() errors as small negative values, and
every one of those has bit 13 set (-EIO is 0xfffffffb, likewise
-ETIMEDOUT, -EOPNOTSUPP).  Does an MDIO read failure therefore read as
"advertises 1000BASE-T full duplex" and turn the guard into an accept?

Second question on the same read: register 15 is only meaningful when
BMSR_ESTATEN is set in MII_BMSR, and a PHY that does not implement it
may return 0xffff, which again has bit 13 set.  genphy_read_abilities()
gates the access and checks the result:

drivers/net/phy/phy_device.c:genphy_read_abilities() {
	...
	if (val & BMSR_ESTATEN) {
		val = phy_read(phydev, MII_ESTATUS);
		if (val < 0)
			return val;
	...
}

Would the same gate plus error check be needed here, i.e. capture the
read in an int and return false when it is negative?

This matters because the FE PHY sharing MTK_GPHY_ID_MT7530 is exactly
the device this predicate is meant to reject.  On a false positive,
en751221_mcm_phy_config_init() runs genphy_soft_reset() followed by the
page 1 and vendor MMD writes against that PHY.

> +
> +static int mt7530_phy_match(struct phy_device *phydev,
> +			    const struct phy_driver *phydrv)
> +{
> +	return mt7530_is_gphy(phydev) && !en751221_is_mcm_phy(phydev);
> +}
> +
> +static int en751221_phy_match(struct phy_device *phydev,
> +			      const struct phy_driver *phydrv)
> +{
> +	return mt7530_is_gphy(phydev) && en751221_is_mcm_phy(phydev);
> +}
> +

[ ... ]

> @@ -126,7 +190,6 @@ static int mt7531_phy_config_init(struct phy_device *phydev)
>  
>  static struct phy_driver mtk_gephy_driver[] = {
>  	{
> -		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530),
>  		.name		= "MediaTek MT7530 PHY",

With PHY_ID_MATCH_EXACT gone, phy_bus_match() uses the callback result
verbatim:

drivers/net/phy/phy_device.c:phy_bus_match() {
	...
	if (phydrv->match_phy_device)
		return phydrv->match_phy_device(phydev, phydrv);
	...
}

so mt7530_is_gphy() is now the only binding gate for both entries.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917130534.297930-1-cjd%40cjdns.fr
