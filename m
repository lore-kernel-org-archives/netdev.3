Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED95651CF41;
	Wed, 30 Sep 2026 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803082; cv=none; b=ZyF6PPRvLgh9CYYJLEWyor51nUylJD1ee3O1Wm0Ni3SWW/c8bpUVOLnnomHMKPCUJoKJKLRJvdp6Jzf0NpUgIktoVHg5ckp695VGAheZ3WNYlKL+Vq3APMkhOjvQFLBnjDDkXzKEt9cpIDAtT668VA6TduPcW0RJR1VHJSc0XdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803082; c=relaxed/simple;
	bh=W3istN9aa+fsOaaX39K/N3ETCLRIffw8q7l17GylpLw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uXqvAEbSe7kEMyW3M1l/P7wsVU303VC5RxnboabBL4rpZhf08QzdY2nx+VdA35B+t8OzXpYouyQRrikx5ulrxkqnPI/Im9/W4od9pWiX9uYZfIqZaHfLgN83hjB6FH8p0+2D4occ7zI18OSfrsCgO3n4TimnzSuIW80MTvNrifA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpzN9wdI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpzN9wdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969641F00898;
	Wed, 30 Sep 2026 21:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790803080;
	bh=9EsS7cIO+gD5VxdexZb/ZbRLwojusBfnkkhRm9xH5Xo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QpzN9wdIJ30jOMJuLvfux65gJhGFf0btT56TisSRdGOh2T54OmxQc7Tn6g163Lvv5
	 b4jg5vnaLtmezYmW7q8D17MHW8hqaexJkTaKUs2xcimBFoW9VuTFG+VkCdTU8Vp4Ut
	 yf678WgJF7QxXs3qCzgvxL4tQhNxt1DV+iTvjbSVD2O/Yxp6pNx5mLObTCwzUIUBKd
	 N2ZvP431y2HLUrD4HwepyjPVFJOpu8F1eu4PQ2AK3yX2bt7DDcyXWbswS+53dRJ/tP
	 RrQ0tCHQaq2JnryrpWfZmFTWSxSdfFec8MLBgkIUx8hDnUr0KOhAXaoC24gpyVQHRO
	 NSN46WiY83Ylw==
Subject: Re: [PATCH 2/5] net: ftgmac100: Add AST2700 compatible support
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ratbert@faraday-tech.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 21:17:59 +0000
Message-ID: <179080307917.434549.2473496365006005968@kernel.org>
In-Reply-To: <20260927-support_ast2700-v1-2-9f03f29d2c82@aspeedtech.com>
References: <20260927-support_ast2700-v1-2-9f03f29d2c82@aspeedtech.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Baseline decision: false (resolved later in the series).
- [Low] Several driver comments listing which SoCs share a behaviour now
  leave out AST2700, although the code and binding include it.

Pre-existing issues:
- [High] This bug was not introduced by this patch, but the patch extends
  it to the new AST2700 compatible.

--

net: ftgmac100: Add AST2700 compatible support

This commit adds match data for the Aspeed AST2700 FTGMAC100 controller
and adds the aspeed,ast2700-mac compatible to the OF match table. In
ftgmac100_probe(), AST2700 is handled like the other Aspeed MACs. That
sets is_aspeed and skips the internal MDIO setup.

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 6d2fe5c2f3903..67b1fa464a421 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c

[ ... ]

> @@ -2017,7 +2018,8 @@ static int ftgmac100_probe(struct platform_device *pdev)
>  
>  	if (priv->mac_id == FTGMAC100_AST2400 ||
>  	    priv->mac_id == FTGMAC100_AST2500 ||
> -	    priv->mac_id == FTGMAC100_AST2600) {
> +	    priv->mac_id == FTGMAC100_AST2600 ||
> +	    priv->mac_id == FTGMAC100_AST2700) {
>  		priv->rxdes0_edorr_mask = BIT(30);
>  		priv->txdes0_edotr_mask = BIT(30);
>  		priv->is_aspeed = true;

[Severity: High]
This is a pre-existing issue, but this change extends it to the new
AST2700 compatible. When is_aspeed is set, ftgmac100_reset_and_config_mac()
dereferences phydev without a NULL check:

ftgmac100_reset_and_config_mac() {
    ...
	/* Aspeed RMII needs SCU reset to clear status */
	if (priv->is_aspeed && priv->netdev->phydev->interface == PHY_INTERFACE_MODE_RMII) {
    ...
}

This check came from commit af350ee72e9dda.

ftgmac100_probe_dt() can return 0 with no PHY attached. Take a node
with no use-ncsi, no fixed-link and no phy-handle, but with an mdio
child. For that node, ftgmac100_mii_probe() is skipped:

ftgmac100_probe_dt() {
    ...
	if (!ftgmac100_has_child_node(np, "mdio")) {
		/* Support legacy ASPEED devicetree descriptions that
    ...
}

The binding does not require phy-handle and allows an mdio child for
all compatibles. So an aspeed,ast2700-mac node like this would register
successfully with netdev->phydev == NULL.

Could bringing the interface up then oops here? ftgmac100_open() treats
phydev as optional for phy_start(), but only after this call:

ftgmac100_open()
  ftgmac100_reset_and_config_mac()
    priv->netdev->phydev->interface   <-- NULL phydev

The reset task reaches the same helper:

ftgmac100_reset_task()
  ftgmac100_reset()
    ftgmac100_reset_and_config_mac()

Later in the series, "net: ftgmac100: Enable AST2700 RMII support" adds
another unguarded phydev->interface dereference in ftgmac100_start_hw()
for the AST2700 RMII quirk. This problem is still there at the end of
the series.

[Severity: Low]
This isn't a bug, but AST2700 now sets is_aspeed and skips
ftgmac100_setup_mdio(). A few comments no longer list every SoC that
takes these paths:

struct ftgmac100:
	/* AST2500/AST2600 RMII ref clock gate */
	struct clk *rclk;

ftgmac100_setup_mdio():
		/* The AST2600 has a separate MDIO controller */

ftgmac100_probe_dt():
		 * them. 2600 has an independent MDIO controller, not
		 * part of the MAC.

The binding already describes the RCLK gate as being for
AST2500/2600/2700, and ftgmac100_setup_clk() now also runs for AST2700.

Should these comments mention AST2700 too? No later patch in the series
updates them.

[ ... ]

> @@ -2131,6 +2133,10 @@ static const struct ftgmac100_match_data ftgmac100_match_data_ast2600 = {
>  	.mac_id = FTGMAC100_AST2600
>  };
>  
> +static const struct ftgmac100_match_data ftgmac100_match_data_ast2700 = {
> +	.mac_id = FTGMAC100_AST2700
> +};
> +

[ ... ]

> @@ -2142,6 +2148,8 @@ static const struct of_device_id ftgmac100_of_match[] = {
>  	  .data = &ftgmac100_match_data_ast2500 },
>  	{ .compatible = "aspeed,ast2600-mac",
>  	  .data = &ftgmac100_match_data_ast2600 },
> +	{ .compatible = "aspeed,ast2700-mac",
> +	  .data = &ftgmac100_match_data_ast2700 },

[Severity: Low]
At this point in the series, can AST2700 DMA to its memory? All AST2700
DRAM is above 4 GiB:

arch/arm64/boot/dts/aspeed/ast2700-evb.dts:
	memory@400000000 {
		reg = <0x4 0x00000000 0x0 0x40000000>;

The driver only handles 32-bit DMA addresses here. No dma_set_mask*()
call is made for AST2700, and only the low 32 bits get programmed:

ftgmac100_init_hw():
	iowrite32(priv->rxdes_dma, priv->base + FTGMAC100_OFFSET_RXR_BADR);

ftgmac100_alloc_rx_buf():
	rxdes->rxdes3 = cpu_to_le32(map);

ftgmac100_hard_start_xmit():
	txdes->txdes3 = cpu_to_le32(map);

With the default 32-bit mask, ftgmac100_alloc_rings() would fail and
ftgmac100_open() would return -ENOMEM on AST2700.

A later patch in the series, "net: ftgmac100: Add AST2700 upper DMA
address support", fixes this. It adds FTGMAC100_QUIRK_DMA_35BIT to the
AST2700 match data, sets a 35-bit DMA mask in probe, and programs the
upper address bits for the rings, the descriptors and the unmap paths.
Also, at this commit the driver cannot be built for ARM64 without
BROKEN.

Would it make sense to reorder the series so the compatible is only
added once DMA support is in place?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927-support_ast2700-v1-0-9f03f29d2c82%40aspeedtech.com
