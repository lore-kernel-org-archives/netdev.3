Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253D546EF6A;
	Mon, 28 Sep 2026 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582628; cv=none; b=Z5Ilf+fkAxgYg0myUfOKsGIUNa1G/ufsNcKhOt9Fy5pMGjwuE1rfkWk/dza/KRtcoYz2A9F6wsYqVbDkcm8htWE/BSBzFptvdt6v/dMeR7A2knFTA/y5MpYC8Hxx/KdhY5XgfaG/6lOPRblQdKGk6Dn1fQOdVeKYQ81Vmm0gFAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582628; c=relaxed/simple;
	bh=ZPV5p+j4KPjhk3iffSJAn2mihUCwMaMbCnf1VocEA1Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kj3+PwNB9hKARJl83bJOIoMSPKjr+klT83eZuRk0vTbHk6g3RcGaFSkyOchV0+IbgKTMPvHeldSo1Y97Y5jJiReAJ3edlWnawxbiEJP07uUgxT1b/kMvPAX/yjixpxmC78XUKUSGkhnwKsbWYxMr2f0YMxwLz347KTVEfBVotmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQwmu5tZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQwmu5tZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94FD1F000FF;
	Mon, 28 Sep 2026 08:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582624;
	bh=wpKB8NWNIG9HI9GTo75J4nfgoxYdt8QoZF0s8fE5gFw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fQwmu5tZ++pPdx978y8XvVOELXuIhncUvhyxzvE3O28BzUdCEfshtgvu6Ynzj9ine
	 bnC73Rzfo9sFCCL8gc8PvojoDaVGNcVeAjQXndfnduOZcKzV6AXEW/mppLXuwcgbli
	 jDY2o76gvQzgaJ4E3zxjgnrWuYvCgick5VE2SEqzgpazPxoFnRBCLcicVatAGSQ8+a
	 WbmRCmUD+U+2PA+bVTY2WzNpmeJh2Tfo8ZKfSVMMf2LtlFj0S6cAI8kNTtktL010mt
	 t0+XXepyA6wezn0wGw/geaZ6Ijhfi0Sv/L0vKPTg1w7yPWhw8yQ1QtDF9a5bMhC5hU
	 2feqsY/CYFnsg==
Subject:
 Re: [PATCH net-next v2 7/7] net: stmmac: mediatek: add support for MT8189 SoC
From: netdev-bot+sashiko@kernel.org
To: louisalexis.eyraud@collabora.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, biao.huang@mediatek.com,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, kernel@collabora.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Date: Mon, 28 Sep 2026 08:03:42 +0000
Message-ID: <179058262236.3145.17042342965998808468@kernel.org>
In-Reply-To: <20260924-dwmac-mediatek-mt8189-v2-7-430bd74d5ef9@collabora.com>
References: <20260924-dwmac-mediatek-mt8189-v2-7-430bd74d5ef9@collabora.com>
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

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On MT8189, the driver and the DT binding disagree about MAC-
  sourced RMII.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  mediatek_dwmac_probe() ignores the return value of…
- [Medium] This problem wasn't introduced by this patch, but
  mediatek_dwmac_clks_config(enabled=true) leaks clock enables.

--

net: stmmac: mediatek: add support for MT8189 SoC

This adds MT8189 support to the MediaTek dwmac glue driver. MT8189 reuses
the MT8195 pericfg programming callbacks, with a different register
offset, 180ps delay stage dividers, a shorter clock list and the TX clock
output enable feature.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> index 36599dc33b14..f07c331b029f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c

[ ... ]

> @@ -124,6 +131,10 @@ static const char * const mt8195_dwmac_clk_l[] = {
>  	"axi", "apb", "mac_cg", "mac_main", "ptp_ref"
>  };
>  
> +static const char * const mt8189_dwmac_clk_l[] = {
> +	"mac_main", "ptp_ref"
> +};

[Severity: Medium]
How is RMII with the MAC providing the reference clock meant to work on
MT8189?

The MT8189 binding added earlier in this series ("dt-bindings: net:
mediatek-dwmac: add support for MT8189 SoC") limits clock-names to exactly
these two entries:

    clock-names:
      items:
        - const: mac_main
        - const: ptp_ref

However, it still allows mediatek,rmii-clk-from-mac for this compatible.
The tx/rx-delay-ps descriptions also mention the MT8189 RMII interface.

If a board sets mediatek,rmii-clk-from-mac, mediatek_dwmac_clk_init()
always requests a clock that the binding does not permit:

drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c:mediatek_dwmac_clk_init() {
    ...
	if (plat->rmii_clk_from_mac) {
		plat->rmii_internal_clk = devm_clk_get(plat->dev, "rmii_internal");
		if (IS_ERR(plat->rmii_internal_clk))
			ret = PTR_ERR(plat->rmii_internal_clk);
    ...
}

So a DT that passes schema validation fails to probe. A DT that supplies
rmii_internal, and so would probe, fails schema validation.

The new variant also reuses mt8195_set_interface() and mt8195_set_delay().
These program MT8195_RMII_CLK_SRC_INTERNAL and the RMII_TXC/RMII_RXC delay
path, so the driver seems to treat this mode as supported.

Should the MT8189 binding gain an optional rmii_internal clock? Or should
the binding and the driver reject mediatek,rmii-clk-from-mac for MT8189
with a clear error?

[ ... ]

> @@ -495,6 +506,21 @@ static void mt8195_fix_mac_speed(void *priv, phy_interface_t interface,
>  			   reg_val);
>  }
>  
> +static const struct mediatek_dwmac_variant mt8189_gmac_variant = {
> +	.dwmac_set_phy_interface = mt8195_set_interface,
> +	.dwmac_set_delay = mt8195_set_delay,

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. Now that
MT8189 uses mt8195_set_delay(), can it cause trouble that
mediatek_dwmac_probe() ignores the return value of mediatek_dwmac_init()?

drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c:mediatek_dwmac_probe() {
    ...
	mediatek_dwmac_common_data(pdev, plat_dat, priv_plat);
	mediatek_dwmac_init(&pdev->dev, priv_plat);

	ret = mediatek_dwmac_clks_config(priv_plat, true);
    ...
}

With phy-mode = "gmii", stmmac_get_phy_intf_sel() returns
PHY_INTF_SEL_GMII_MII. That passes the check in mediatek_dwmac_init(), and
mt8195_set_interface() writes CTRL0. mt8195_set_delay() then reaches:

	default:
		dev_err(plat->dev, "phy interface not supported\n");
		return -EINVAL;

CTRL1 and CTRL2 are never written, but probe still goes on into
stmmac_dvr_probe() and succeeds.

The error is also ignored for phy modes that mediatek_dwmac_init() rejects
up front. In that case the device probes with the pericfg interface
registers never programmed.

Should probe fail when mediatek_dwmac_init() returns an error?

> +	.dwmac_fix_mac_speed = mt8195_fix_mac_speed,
> +	.clk_list = mt8189_dwmac_clk_l,
> +	.num_clks = ARRAY_SIZE(mt8189_dwmac_clk_l),

[Severity: Medium]
This isn't a bug introduced by this patch, but does
mediatek_dwmac_clks_config() leak the bulk clock enables when the
rmii_internal clock fails to enable?

drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c:mediatek_dwmac_clks_config() {
    ...
		ret = clk_bulk_prepare_enable(variant->num_clks, plat->clks);
		...
		ret = clk_prepare_enable(plat->rmii_internal_clk);
		if (ret) {
			dev_err(plat->dev, "failed to enable rmii internal clk, err = %d\n", ret);
			return ret;
		}
    ...
}

That path has no clk_bulk_disable_unprepare(). mediatek_dwmac_probe() also
returns the error directly, without reaching err_drv_probe:

	ret = mediatek_dwmac_clks_config(priv_plat, true);
	if (ret)
		return ret;

On MT8189 this leaves mac_main and ptp_ref prepared and enabled. The devm
bulk get cleanup only drops the clock references. The same leak can
happen through the clks_config callback on resume.

On MT8189 this needs a DT that sets mediatek,rmii-clk-from-mac and also
supplies an rmii_internal clock, which the MT8189 binding does not allow.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-dwmac-mediatek-mt8189-v2-0-430bd74d5ef9%40collabora.com
