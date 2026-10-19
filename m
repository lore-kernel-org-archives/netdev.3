Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3BC486E5A;
	Mon, 19 Oct 2026 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394835; cv=none; b=Q7H5pOKkVWOdbt9V/NOlHfQysDroThM/co891ktWiCCWYFcRnlQg4ml5/KoOLV64VIJObj9NI+ifvyTPRBp4WH4vJlABPhnbd2DFkVQ69Xv1CAKOy0eM3nnqkvJ8rRmNnS5dUhAztRxeNtAT4pMCiCswzXLtar4iVuoKTgJe77c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394835; c=relaxed/simple;
	bh=9ULXod4bUR91ToHzbZzdWomf8gSblHEfMSPt1ofBFBQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k7GVVmS0wLIPb2SNXEZ8+i0Muvp7NykZfjpjcfIoMnDI7ZiR0joigxo7+3DZe8dX4Ga85bUlWwV/FWYaFX3BZCS+Zb1qTMOmxvQLqb2vagnZ6n/KqliUfTuGRTNinWxvt1STXrmWbfb+7uG6ybaipJ+6xMy/GfChyY1epjJuijU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O18R9u3P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O18R9u3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC7E1F000C5;
	Mon, 19 Oct 2026 07:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792394834;
	bh=vPKahiieUNWSBS0P4QMHjbfH/wRJi8FoZrJjUlGEzQo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O18R9u3PiJeSZrP3fUQSJ+dqTw073h2GBUAAxRdhJWpIam/c0132AMtogSup3BEo0
	 0P6hB1z9UvV4vvRk4UAj+tpxIh/2LgrcGACcohcoAgBf06k6saPzpbIKxDJY2bU7Cw
	 oLNgY0FPvnoa6AbHnMEuKfAj18mN96xKsken5N/ErSxQCNVzJKxyZOoxdd+69e77nZ
	 ph1XYgxFE62FOPQ6F+nvC1Gii1+lmXxlp19xQ9bx5Xwiz9i2uRaPEStFM7KoGlEHHs
	 sGz4B/GI8exSI1wRJ647Tpt9+wv8aR55Yvo8/yzge6Bgo6iGQoC2n4tA7Bej5Z/Ydo
	 E6p/eXTkc81YQ==
Subject:
 Re: [PATCH net-next v3 2/6] net: ftgmac100: Add AST2700 compatible support
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ratbert@faraday-tech.com, edumazet@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 07:27:12 +0000
Message-ID: <179239483279.3135.7936429088752447587@kernel.org>
In-Reply-To: <20261015-support_ast2700-v3-2-8d7999171ac4@aspeedtech.com>
References: <20261015-support_ast2700-v3-2-8d7999171ac4@aspeedtech.com>
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

- [Low] The comment on struct ftgmac100::rclk still says '/*
  AST2500/AST2600 RMII ref clock gate */' (line 117 at this commit, and…
- [Low] (Baseline: discarded as resolved later in the series.) At this
  commit, AST2700 binds to the driver with no DMA support above 4 GiB.

Pre-existing issues:
- [High] On Aspeed variants, including the newly added AST2700, a NULL
  pointer dereference oopses ftgmac100_reset_and_config_mac() when the…

--

net: ftgmac100: Add AST2700 compatible support

This adds an FTGMAC100_AST2700 mac_id, its match data, and an
"aspeed,ast2700-mac" entry in the OF match table. In ftgmac100_probe(),
AST2700 is handled the same way as the other Aspeed variants: it gets
the BIT(30) EDORR/EDOTR masks and is_aspeed is set.

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 6d2fe5c2f390..67b1fa464a42 100644
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
This is a pre-existing issue, not one introduced by this patch. Setting
is_aspeed for AST2700 does make it reachable with the new compatible,
though. Can ftgmac100_reset_and_config_mac() dereference a NULL phydev
here?

drivers/net/ethernet/faraday/ftgmac100.c:ftgmac100_reset_and_config_mac() {
    ...
	/* Aspeed RMII needs SCU reset to clear status */
	if (priv->is_aspeed && priv->netdev->phydev->interface == PHY_INTERFACE_MODE_RMII) {
    ...
}

Suppose the DT node has an "mdio" child node but no "phy-handle", no
"fixed-link" and no "use-ncsi". In that case ftgmac100_probe_dt() skips
ftgmac100_mii_probe() and returns 0 without attaching a PHY:

	if (!ftgmac100_has_child_node(np, "mdio")) {
		...
		err = ftgmac100_mii_probe(netdev);
		...
	}

	return 0;

ftgmac100_probe() also skips ftgmac100_setup_mdio() for AST2700. So
register_netdev() succeeds with netdev->phydev == NULL. The
faraday,ftgmac100.yaml binding allows this DT, because mdio and
phy-handle are both optional.

Bringing the interface up then runs:

ftgmac100_open()
  ftgmac100_reset_and_config_mac()
    priv->netdev->phydev->interface

The reset task reaches the same code through ftgmac100_reset().

Elsewhere, ftgmac100_open() treats phydev as optional:

	if (netdev->phydev) {
		/* If we have a PHY, start polling */
		phy_start(netdev->phydev);
	}

The unchecked dereference came in with commit af350ee72e9dd ("net:
ftgmac100: Add optional reset control for RMII mode on Aspeed SoCs").
It already affects AST2400/2500/2600.

A later patch in this series, "net: ftgmac100: Enable AST2700 RMII
support", adds another unconditional phydev->interface dereference in
ftgmac100_start_hw(). Its commit message and code comment say that
probe_dt always attaches a phy_device before register_netdev(). Doesn't
the path above show that this assumption doesn't always hold?

[Severity: Low]
This isn't a bug, but the comment on the rclk member of struct ftgmac100
still reads:

	/* AST2500/AST2600 RMII ref clock gate */
	struct clk *rclk;

Since is_aspeed is now set for AST2700, ftgmac100_setup_clk() acquires
RCLK for it too. The binding also describes the clock as "RMII RCLK
gate for AST2500/2600/2700". Could the comment be updated to include
AST2700?

[ ... ]

> @@ -2131,6 +2133,10 @@ static const struct ftgmac100_match_data ftgmac100_match_data_ast2600 = {
>  	.mac_id = FTGMAC100_AST2600
>  };
>  
> +static const struct ftgmac100_match_data ftgmac100_match_data_ast2700 = {
> +	.mac_id = FTGMAC100_AST2700
> +};
> +

[Severity: Low]
Can AST2700 do DMA with only this match data? At this commit no quirks
are set, so dma_set_mask_and_coherent() is never called. In addition:

ftgmac100_init_hw() only programs the 32-bit RXR_BADR/NPTXR_BADR
registers.

ftgmac100_alloc_rx_buf() and the tx path only store the low 32 bits of
the buffer address in rxdes3/txdes3.

The AST2700 EVB puts all of its DRAM above 4 GiB:

	reg = <0x4 0x00000000 0x0 0x40000000>;

This looks to be handled later in the series. "net: ftgmac100: Add
AST2700 upper DMA address support" adds FTGMAC100_QUIRK_DMA_35BIT to
this match data. The same patch adds the RXR/TXR high base register
writes and the upper address bits in rxdes2/txdes2.

The driver also cannot be built for arm64 until "net: ftgmac100: Allow
building on ARM64". The Kconfig has "depends on ARM || COMPILE_TEST"
and "depends on !64BIT || BROKEN", so this entry has no effect at this
point in the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-support_ast2700-v3-0-8d7999171ac4%40aspeedtech.com
