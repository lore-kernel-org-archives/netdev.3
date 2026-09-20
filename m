Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3547044C;
	Sun, 20 Sep 2026 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789923777; cv=none; b=mzz1JAhVgF/gPf0YBQ9vSCPa+PAdi1d0zB1W9lKX95QF9xUif4WKXVclGoVr0tP7gtkV+IuLAcRUUjlmUlkmMnEF431ELRNdGthgLUYWpleA3jWFUu2QNxLKNWaESe3wgyLnLNQGNa7Q7hAZdkavYmtjzLKPjrXYIQRxQRPYEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789923777; c=relaxed/simple;
	bh=zNm1UOEyT5VwvvQdjuL4absuX0lqMBhnL3Hqd25VBl0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=siXb4SzrtVVdUzXMZq4ISJ8w6UGBquSU4PD8fL5hGHQ5Z38sH9uF7UW+AX8ycLHoSrDdfZpnE/AtsaOcJMIFEDmNRkI4GKKvwqFFZnqILLu38bOP+R+K1WaF1pCGoc5+rdDBd3c97DaBbKbrnu9hTw9UxvKwfSYfhPVkCrzvtLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfuH4UFX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfuH4UFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891751F00893;
	Sun, 20 Sep 2026 17:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789923769;
	bh=Sxi4AzxEIOT2AErdFjZXxdrhgAaTfW/VmGrSAynXI5w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PfuH4UFXpsMG0D655ancdlsev0JCtjI7KQRw7GqgPSpO+dy30Fn2iWoGHFbCp+6aU
	 fXwbG0GbisoZSv9t/sWKu4NJ++6ffLmJIxSQ+9vFRlb0GCSSv4YttVg8eAiIPQ54GZ
	 uEX/wk3ldtUDZQg1VuvVnc3PTUGDeRZr87c1VDv2yzWIvbVbQBWXT8Vnf5YkwXhKx+
	 3HJN3baOxcuwIoZO/Z9PM6S8sVXJTSnG0/7MNgF2Ko0fPJFQjHva5berYREGiSp82e
	 Png5BqwN/ZLAXWJrakdJafsbqPlo/9jQkDaQvl7Tr8xw+MoFzrsshzIWuk6Kiuunqx
	 CXWwEQcPpZh5w==
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: sun8i: add support for
 Allwinner H616 EMAC1
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: richard.genoud@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, wens@kernel.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, alexandre.torgue@foss.st.com,
 peppe.cavallaro@st.com, joabreu@synopsys.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, mripard@kernel.org, alastair@d-silva.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Date: Sun, 20 Sep 2026 17:02:48 +0000
Message-ID: <178992376814.2160803.7753352020074814044@kernel.org>
In-Reply-To: <20260917-submit-h616-emac1-v1-v3-3-62cb8316e19b@gmail.com>
References: <20260917-submit-h616-emac1-v1-v3-3-62cb8316e19b@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new `emac_variant_h616_emac1` in
  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c (lines 153-158)…

--

net: stmmac: sun8i: add support for Allwinner H616 EMAC1

Adds a new emac_variant for the H616 secondary EMAC, pointing at a
dedicated syscon clock register at offset 0x34, and registers the
allwinner,sun50i-h616-emac1 compatible.  The variant is described as
RMII-only with the PHY handled by the co-packaged AC200/AC300 driver.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 4523a14f5e0c3..1020168f1c3a0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -81,6 +81,13 @@ static const struct reg_field sun8i_syscon_reg_field = {
>  	.msb = 31,
>  };
>  
> +/* EMAC1 clock register @ 0x34 in the "system control" address range */
> +static const struct reg_field sun8i_syscon_reg_field_emac1 = {
> +	.reg = 0x34,
> +	.lsb = 0,
> +	.msb = 31,
> +};
> +
>  /* EMAC clock register @ 0x164 in the CCU address range */
>  static const struct reg_field sun8i_ccu_reg_field = {
>  	.reg = 0x164,

[ ... ]

> @@ -143,6 +150,13 @@ static const struct emac_variant emac_variant_h6 = {
>  	.tx_delay_max = 7,
>  };
>  
> +static const struct emac_variant emac_variant_h616_emac1 = {
> +	.syscon_field = &sun8i_syscon_reg_field_emac1,
> +	/* The co-packaged AC200/AC300 PHY does not use the H3 PHY controls. */
> +	.soc_has_internal_phy = false,
> +	.support_rmii = true,
> +};

[Severity: Medium]
The commit message says "Add an EMAC1 variant using the dedicated register
and enable only RMII".  Where is support_rmii actually consumed?

Grepping drivers/net/ethernet/stmicro/stmmac/ at this commit, every
occurrence of support_mii/support_rmii/support_rgmii is either the
kernel-doc line for struct emac_variant, the bool member declaration, or a
per-variant initializer.  There is no variant->support_* read anywhere in
the tree, so setting only .support_rmii here has no runtime effect.

The one interface-mode gate left in the driver is variant agnostic, in
sun8i_dwmac_set_syscon():

	switch (plat->phy_interface) {
	case PHY_INTERFACE_MODE_MII:
		/* default */
		break;
	case PHY_INTERFACE_MODE_RGMII:
	case PHY_INTERFACE_MODE_RGMII_ID:
	case PHY_INTERFACE_MODE_RGMII_RXID:
	case PHY_INTERFACE_MODE_RGMII_TXID:
		reg |= SYSCON_EPIT | SYSCON_ETCS_INT_GMII;
		break;
	case PHY_INTERFACE_MODE_RMII:
		reg |= SYSCON_RMII_EN | SYSCON_ETCS_EXT_GMII;
		break;
	default:
		dev_err(dev, "Unsupported interface mode: %s",
			phy_modes(plat->phy_interface));
		return -EINVAL;
	}

	regmap_field_write(gmac->regmap_field, reg);

With compatible = "allwinner,sun50i-h616-emac1" and phy-mode = "rgmii",
does this probe successfully and program SYSCON_EPIT |
SYSCON_ETCS_INT_GMII into the new EMAC1 clock register at syscon 0x34?
And with phy-mode = "mii", is SYSCON_RMII_EN simply left clear?  Both
select a clock/pin routing this instance does not have, with no -EINVAL and
no message logged.

Nothing downstream re-adds the restriction either: dwmac-sun8i provides no
get_interfaces callback, so stmmac_phylink_setup() just accepts whatever
firmware picked:

	if (phy_interface_empty(config->supported_interfaces))
		__set_bit(priv->plat->phy_interface,
			  config->supported_interfaces);

That leaves the RMII-only constraint expressed only in the binding added by
the preceding patch in the series, "dt-bindings: net: allwinner: add H616
EMAC1" (phy-mode: const: rmii for this compatible), which is checked by
dtbs_check at build time rather than at probe time.

Would it make sense to reject non-RMII modes for this variant in
sun8i_dwmac_set_syscon(), or to start reading variant->support_* there?

On a related note, the commit message says the block "supports only RMII at
10/100 Mbps", but sun8i_dwmac_setup() still advertises gigabit for every
variant, including this one:

	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
			 MAC_10 | MAC_100 | MAC_1000;

Should the H616 EMAC1 variant also limit link.caps to MAC_10 | MAC_100?

> +
>  #define EMAC_BASIC_CTL0 0x00
>  #define EMAC_BASIC_CTL1 0x04
>  #define EMAC_INT_STA    0x08
> @@ -1276,6 +1290,8 @@ static const struct of_device_id sun8i_dwmac_match[] = {
>  		.data = &emac_variant_a64 },
>  	{ .compatible = "allwinner,sun50i-h6-emac",
>  		.data = &emac_variant_h6 },
> +	{ .compatible = "allwinner,sun50i-h616-emac1",
> +		.data = &emac_variant_h616_emac1 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, sun8i_dwmac_match);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b%40gmail.com
