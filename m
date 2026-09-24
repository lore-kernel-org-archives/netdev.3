Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15E496D4E;
	Thu, 24 Sep 2026 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257485; cv=none; b=T2OfQNP/KjQDaqi+V+bXol98xP8mWoHlGbwdimbRdx8AQJwxuMdZqr+lY6/xbKkvQuw6mA54CufLTKQZSekkZmCBuw4blaSIXtWg1x5eaqk2g0ZguikwqAWt+2BHLKMP65nOkw3hkJS0bKFusaF0f/qF/+VBaql9/LCuPZ0ROEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257485; c=relaxed/simple;
	bh=EZKAYiJKZakwRjW5SPUTQz2FolYu1NY2ckIarQP1k/M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NyIaztk9WOtTe6j8ueEx40+p1q/JScniGyb7qxQSOUuDH30fO70uo41iFneP52Zc6mB2vPEgUNN/HdcEX604Z+jVkIRHNF4AbBfDJcJXWVyPZmpQUTetSFup9++1Mz0zL6HFu6R9vgC7zDUD9RsDdkKzSYVtA4VAGxc5HdVetZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpFCvJJL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpFCvJJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2D51F000FF;
	Thu, 24 Sep 2026 13:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790257475;
	bh=UAS3er2RQV6648r7mgyMvk+XVH+3swijnAUHceJqTb0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YpFCvJJL7s9wdGlwLA7nahacJGQVutOhwBkyxFlVWYVVhT4wJnNh8ed97sumKI5So
	 PrkDqH5rn/DQgQTP8UUFEW5t44f0IAVngj59iXDJCRVwntQA66nVpyHYGTNtw7ASQg
	 V5SVvtwPgDrMt1af16Agf33HC8RaB5aEdYp9g2DAAsq3AOz5J7JptKKrZ9taavGBRE
	 /jdXSY1DOfHK1oERMKUqR/xQV7Aj2kEAuXYGP53qtp7iHX8TSvoCm4ot11YrwdWNIn
	 iclD7aT/U+2f2ngtze6qILB6unOcTz9SHNom/rZCCHCivFBP0VcoN1Pgo4DqspprzK
	 I83pTkR7AAx4g==
Subject: Re: [PATCH net-next v4] net: dsa: mxl-gsw1xx: force internal PHYs
 into a known reset state
From: netdev-bot+sashiko@kernel.org
To: alexander.sverdlin@siemens.com
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, hauke@hauke-m.de,
 andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 13:44:34 +0000
Message-ID: <179025747410.2160803.16708374006312831463@kernel.org>
In-Reply-To: <20260922104124.311334-1-alexander.sverdlin@siemens.com>
References: <20260922104124.311334-1-alexander.sverdlin@siemens.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] gsw1xx_setup() (drivers/net/dsa/lantiq/mxl-gsw1xx.c:592-619)
  derives the set of "internal-PHY" RST_REQ bits from the mii_cfg[]…
- [Medium] net: dsa: mxl-gsw1xx: cascade ports over internal PHYs are
  incorrectly held in reset
- [Low] The commit fixes a user-visible functional defect in a driver
  that is already in released kernels but carries no `Fixes:` tag.

--

net: dsa: mxl-gsw1xx: force internal PHYs into a known reset state

This adds a per-variant ->setup() hook to struct gswip_hw_info, called from
gswip_setup() after MDIO auto-polling is disabled but before the MDIO bus is
registered.  For the GSW1xx variants the hook programs the shell RST_REQ PHY
reset bits, releasing the PHYs of DSA user ports and holding the remaining
internal PHYs in reset, with a single 300ms settle delay if any PHY was
released.

> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
> index 0b75be14dc109..4f95877c59d1d 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip.h
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
> @@ -261,6 +261,8 @@ struct gswip_hw_info {
>  	const struct gswip_pce_microcode (*pce_microcode)[];
>  	size_t pce_microcode_size;
>  	enum dsa_tag_protocol tag_protocol;
> +
> +	int (*setup)(struct dsa_switch *ds);
>  	void (*phylink_get_caps)(struct dsa_switch *ds, int port,
>  				 struct phylink_config *config);
>  	struct phylink_pcs *(*mac_select_pcs)(struct phylink_config *config,
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> index 6150dc3ffb641..7c53ded178367 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> @@ -689,6 +689,16 @@ static int gswip_setup(struct dsa_switch *ds)
>  	 */
>  	regmap_write(priv->mdio, GSWIP_MDIO_MDC_CFG0, 0x0);
>  
> +	/* GSW1xx will wake up the PHYs here, so it makes sense that it happens
> +	 * after the auto-polling deactivation above, but before the MDIO bus
> +	 * registration below
> +	 */
> +	if (priv->hw_info->setup) {
> +		err = priv->hw_info->setup(ds);
> +		if (err)
> +			return err;
> +	}
> +

[Severity: Low]
This hook repairs a boot-time failure that exists in the already released
driver, but the commit carries no Fixes: tag.

The commit message says:

    When bootstrapped with PS_NOWAIT = 0 the internal PHYs stay held in
    reset, so the driver only worked with PS_NOWAIT = 1 where they are
    released automatically.

At the baseline, the only writers of GSW1XX_SHELL_RST_REQ are
gsw1xx_pcs_enable() and gsw1xx_pcs_disable(), and they only touch
GSW1XX_RST_REQ_SGMII_SHELL, so nothing releases the internal-PHY reset
lines before this patch.  On PS_NOWAIT = 0 boards no PHY ID is readable
during the MDIO scan, which means no user port comes up.

Would a trailer such as:

    Fixes: 22335939ec907c ("net: dsa: lantiq: add DSA driver for MaxLinear GSW1xx switch devices")

be appropriate here, or is the omission deliberate because this is targeted
at net-next only?  If it is deliberate, could the commit message say so?

>  	/* Configure the MDIO Clock 2.5 MHz */
>  	regmap_write_bits(priv->mdio, GSWIP_MDIO_MDC_CFG1, 0xff, 0x09);
>  
> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> index 66bf7e3319057..5722a9fadc0a7 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> @@ -589,6 +589,37 @@ static void gsw150_phylink_get_caps(struct dsa_switch *ds, int port,
>  	gsw1xx_phylink_get_lpi_caps(config);
>  }
>  
> +static int gsw1xx_setup(struct dsa_switch *ds)
> +{
> +	struct gsw1xx_priv *priv = container_of(ds->priv, struct gsw1xx_priv, gswip);
> +	struct gswip_priv *gswip_priv = ds->priv;
> +	u32 phy_mask = 0, active_mask = 0;
> +	int port, ret;
> +
> +	/* Reset bits exist only for the internal-PHY ports preceding the first
> +	 * MII port.
> +	 */
> +	for (port = 0; port < gswip_priv->hw_info->max_ports; port++) {
> +		if (gswip_priv->hw_info->mii_cfg[port] != -1)
> +			break;
> +
> +		phy_mask |= GSW1XX_RST_REQ_PHY(port);
> +
> +		if (dsa_port_is_user(dsa_to_port(ds, port)))
> +			active_mask |= GSW1XX_RST_REQ_PHY(port);
> +	}
> +
> +	ret = regmap_update_bits(priv->shell, GSW1XX_SHELL_RST_REQ, phy_mask,
> +				 phy_mask & ~active_mask);
> +	if (ret)
> +		return ret;
> +
> +	if (active_mask)
> +		msleep(300);
> +
> +	return 0;
> +}

[Severity: Medium]
Does this hold the internal PHY of a DSA cascade port in reset?

dsa_port_is_user() is true only for DSA_PORT_TYPE_USER.  Suppose one
of the internal-PHY ports is described in the device tree with a link
property, so that it connects this switch to another switch in the
tree.  That port is DSA_PORT_TYPE_DSA and never gets into
active_mask.  The regmap_update_bits() call below then asserts its bit
in GSW1XX_SHELL_RST_REQ, and the PHY stays in reset.  The inter-switch
link cannot come up, so any traffic that has to cross it is lost.

allowed_cpu_ports keeps CPU ports off ports 0..4.  DSA link ports have
no such restriction, so this is the case that matters.

Before this patch that setup worked on PS_NOWAIT = 1 boards, because
the bootstrap releases the PHYs and nothing in the driver touched
these bits.  For that configuration this looks like a regression, not
just a missing feature.

The commit message says "release the PHYs of used (DSA user) ports",
but a link port is also a used port.  Other DSA drivers use
!dsa_is_unused_port(ds, port) when deciding which ports to power up.
That test covers user, CPU and DSA link ports alike.  Would it be the
right test here too?  Or is cascading over an internal-PHY port
something this driver intentionally does not support?  If so, it may
be better to reject that configuration with an error than to keep the
PHY in reset without saying anything.

[Severity: Medium]
Does this loop include the SGMII port in phy_mask on gsw12x/gsw140/gsw141?

For those three variants mii_cfg[] is declared as:

	.mii_cfg = {
		[0 ... GSW1XX_MII_PORT - 1] = -1,
		[GSW1XX_MII_PORT] = GSWIP_MII_CFGp(0),
		[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
	},

with GSW1XX_MII_PORT == 5, so mii_cfg[0..4] are all -1 and the loop breaks
only at port 5, covering ports 0 through 4.

But port 4 is not an internal PHY on those parts.  mxl-gsw1xx.h has:

	/* Port used for SGMII */
	#define GSW1XX_SGMII_PORT			4

and the driver's own port map in gsw1xx_phylink_get_caps() agrees:

	switch (port) {
	case 0 ... 3: /* built-in PHYs */
	...
	case 4: /* SGMII */

So phy_mask picks up GSW1XX_RST_REQ_PHY(4) == BIT(4).  The only bit
documented in this register for the SGMII block is BIT(5),
GSW1XX_RST_REQ_SGMII_SHELL, and it is managed separately by
gsw1xx_pcs_enable()/gsw1xx_pcs_disable().  Is BIT(4) defined as an
internal-PHY reset on the 4-PHY SKUs?

Two consequences follow from including port 4:

When port 4 is the SGMII CPU port or is unused, dsa_port_is_user() is false,
so reset request bit 4 gets asserted by the regmap_update_bits() above,
early in gswip_setup() and before the PCS is brought up.  Since
allowed_cpu_ports is BIT(GSW1XX_MII_PORT) | BIT(GSW1XX_SGMII_PORT), can this
leave the SGMII CPU port dead on those boards?

When port 4 is a DSA user port (SGMII to an SFP or external PHY),
active_mask becomes non-zero purely because of the SGMII port, so the 300ms
msleep() runs even though no internal PHY was released, and bit 4 is cleared
without the PCS code's knowledge.

Only gsw150 matches the derived range, since gsw150_phylink_get_caps()
classifies ports 0..4 as built-in PHYs.  Would a per-variant internal-PHY
count in struct gswip_hw_info, or an explicit skip of GSW1XX_SGMII_PORT, be
more accurate than deriving the range from mii_cfg[]?  The comment "Reset
bits exist only for the internal-PHY ports preceding the first MII port"
also reads as describing the 6-port variants, where port 4 precedes the MII
port but is not an internal PHY.

> +
>  static struct phylink_pcs *gsw1xx_phylink_mac_select_pcs(struct phylink_config *config,
>  							 phy_interface_t interface)
>  {
> @@ -830,6 +861,7 @@ static const struct gswip_hw_info gsw12x_data = {
>  		[GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
>  		[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
>  	},
> +	.setup			= gsw1xx_setup,
>  	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
>  	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
>  	.supports_2500m		= true,

[ ... ]

> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.h b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
> index caa8f1008587a..a7976a5988bd8 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.h
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
> @@ -110,6 +110,7 @@
>  #define GSW1XX_SHELL_BASE			0xfa00
>  #define  GSW1XX_SHELL_RST_REQ			0x01
>  #define   GSW1XX_RST_REQ_SGMII_SHELL		BIT(5)
> +#define   GSW1XX_RST_REQ_PHY(p)			BIT(p)

[Severity: Medium]
GSW1XX_RST_REQ_PHY(p) is an unconstrained BIT(p) placed next to
GSW1XX_RST_REQ_SGMII_SHELL, which is BIT(5).  Is the valid range of p worth
documenting here, given that it differs between the 4-PHY variants and
gsw150?

>  #define  GSW1XX_SHELL_MANU_ID			0x10
>  #define   GSW1XX_SHELL_MANU_ID_PNUML		GENMASK(15, 12)
>  #define   GSW1XX_SHELL_MANU_ID_MANID		GENMASK(11, 1)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922104124.311334-1-alexander.sverdlin%40siemens.com
