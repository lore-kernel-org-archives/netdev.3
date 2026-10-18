Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30201343893;
	Sun, 18 Oct 2026 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320459; cv=none; b=sZz9/oW2azMHdF4t4J7iLykXRoAiScUZbHIzEkf+tPwP4drcaGLQoQRaaixBQgf2Q9GhB4rgQVnUJe3bcT3CvEAT7MG9RyVV1Ez8UB40GEZH5v78upq026iW/53SqQkqVfqr4SIZhN+L1MBV8Vlnqz/LYYSiKbNyTvkZ7qENjYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320459; c=relaxed/simple;
	bh=jVh3kMTXEuLejXZd68s7RGU8yjBRB0wCVzZRQ0q94ao=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nokUztuPV/SF+SyIO7Lr6pMmD+u2rzGTF1wFCgKAUwxay7Klrjm7EScaq3Eel+76Feyz8qpu5owvZn4cVwFTOKV5NP5YqP3ZfhUMroXtMh5wB3CGp/LL5k9PQV0d7KV3oMTNjPC5vKBgz0hIdc1G9wRzNiC/29lAgxJs7A9uoQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw1YrLIB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw1YrLIB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1A21F000C4;
	Sun, 18 Oct 2026 10:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792320456;
	bh=zQq5x4BuVgqNJxwt+zusD+7dTAQnaf9g8c8aBwQ/NUc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Zw1YrLIBD8PWqTCWUkyjzHz9t7igQwO0NVU4OCDEIoQx5Mxe1BiQkz5nT9J0C4fxl
	 kAOkMi8osveoEya9xtKzEgVdeCNP1zHPzXOCSSHcllnrbLz11/PtZsSvawFXiZqIp1
	 +4s+OSXwgVZMrLp1tHSfYkGhVdTT1U3Trlts8trjrfpNyUg9hknQWAy2KtOktQEI7y
	 7pvZqg+SY//7dzYg0iMqT+FVsNOtL+6KpYt0njHeNaNSQCv/evqDFGIA8Q43/DrydL
	 O+8M7+8kcQD/YQ1tAnuVS6bTa75xKlnn6U5yAaUEwuAsiiq92QM7uQWqjEtTDek9pq
	 fj2BXbmPiWa8A==
Subject: Re: [PATCH net-next v3 4/9] net: stmmac: qcom-ethqos: fix RGMII_ID
 mode to use DLL bypass
From: netdev-bot+sashiko@kernel.org
To: mohd.anwar@oss.qualcomm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, afd@ti.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, richardcochran@gmail.com, andersson@kernel.org,
 konradybcio@kernel.org, alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
 joabreu@synopsys.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, lorenzo.bianconi@oss.qualcomm.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Sun, 18 Oct 2026 10:47:34 +0000
Message-ID: <179232045490.3135.14337314664378256554@kernel.org>
In-Reply-To: <20261017-shikra_ethernet-v3-4-26a8beb44b8f@oss.qualcomm.com>
References: <20261017-shikra_ethernet-v3-4-26a8beb44b8f@oss.qualcomm.com>
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

- [Medium] In rgmii-id mode at 100M and 10M, ethqos_set_clk_tx_rate() now
  calls clk_set_rate(link_clk, 25000000) or clk_set_rate(link_clk,…
- [Medium] net: stmmac: qcom-ethqos: rgmii_setmask() on multi-bit
  RGMII_CONFIG2_RSVD_CONFIG15
- [Low] The commit is titled and described as a fix for a defect in the
  current tree, but it has no Fixes: tag.

--

net: stmmac: qcom-ethqos: fix RGMII_ID mode to use DLL bypass

In rgmii-id mode, this commit powers down the DLL, sets DDR bypass and
programs the IO_MACRO through a new ethqos_rgmii_id_macro_init() helper,
so the MAC adds no delay of its own. It also stops ethqos_set_clk_tx_rate()
from doubling the link clock at 100M/10M in rgmii-id mode.

> net: stmmac: qcom-ethqos: fix RGMII_ID mode to use DLL bypass
>
> When "rgmii-id" is selected the PHY supplies both TX and RX delays, so
> the MAC must not add its own. The driver currently falls through to the
> generic DLL initialisation path which programs it to add a delay.

[ ... ]

> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

[Severity: Low]
Should this have a Fixes: tag?

Before this patch, rgmii-id went through the generic DLL path in
ethqos_fix_mac_speed_rgmii() and then ethqos_rgmii_macro_init(). Only the
TX phase shift was suppressed there.

The MAC RX delay was still programmed:

  - at 1G: PRG_RCLK_DLY of 57 or 115, plus PRG_DLY_EN
  - at 10/100: EXT_PRG_RCLK_DLY_CODE of 5, plus EXT_PRG_RCLK_DLY and
    EXT_PRG_RCLK_DLY_EN

The PHY adds its own RX delay in this mode, so the RX delay was applied
twice.

A likely candidate is:

Fixes: 164a9ebe9742 ("net: stmmac: dwmac-qcom-ethqos: Respect phy-mode and TX delay")

That commit made rgmii-id handling cover the TX delay only and left the
MAC RX delay in place.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 44270c25d874f..53fb9de4d92c7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c

[ ... ]

> @@ -183,7 +186,15 @@ static int ethqos_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
>  	if (rate < 0)
>  		return rate;
>  
> -	return clk_set_rate(ethqos->link_clk, rate * 2);
> +	/* Clock Rate Requirements:
> +	 * MAC added delay: 250/50/5 Mhz for 1G/100M/10M
> +	 * No MAC delay (DLL bypass): 250/25/2.5 Mhz for 1G/100M/10M
> +	 */
> +	if (ethqos->phy_mode != PHY_INTERFACE_MODE_RGMII_ID ||
> +	    speed == SPEED_1000)
> +		rate *= 2;
> +
> +	return clk_set_rate(ethqos->link_clk, rate);

[Severity: Medium]
Can qcs404 and sc8280xp actually produce 25 MHz and 2.5 MHz on the link
clock?

On qcs404 the "rgmii" link clock is GCC_ETH_RGMII_CLK. Its parent's
frequency table only has these entries:

drivers/clk/qcom/gcc-qcs404.c:ftbl_emac_clk_src
    5 MHz, 50 MHz, 125 MHz, 250 MHz

On sc8280xp it is GCC_EMAC0_RGMII_CLK, and the lowest entry is 50 MHz:

drivers/clk/qcom/gcc-sc8280xp.c:ftbl_gcc_emac0_rgmii_clk_src
    50 MHz, 125 MHz, 250 MHz

Both branch clocks have CLK_SET_RATE_PARENT. The parent RCGs round up
rather than fail:

drivers/clk/qcom/clk-rcg2.c:clk_rcg2_determine_rate() {
	...
	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req, CEIL);
}

So in rgmii-id mode at 100M/10M, the request would silently become 50 MHz
or 5 MHz on qcs404, and 50 MHz on sc8280xp. clk_set_rate() would still
return 0.

Below 1G, ethqos_rgmii_id_macro_init() clears DDR_MODE and
TX_CLK_PHASE_SHIFT_EN and sets RSVD_CONFIG15, which assumes the 1x clock.
That gives a link clock at 2x the required rate at 100M on both SoCs and at
10M on qcs404. At 10M on sc8280xp it is 20x. No error is reported in any
of these cases.

A later patch in this series, "net: stmmac: qcom-ethqos: warn about legacy
RGMII PHY modes", tells users of these boards (qcs404-evb-4000 and
sa8540p-ride) to move to rgmii-id DTs, which puts them on this path.
Shikra, sm8150, sc8180x and qcs615 do have 25 MHz and 2.5 MHz entries.

Should the rate actually applied be checked here, for example with
clk_get_rate() after clk_set_rate()? Or does rgmii-id below 1G need
different handling on these SoCs?

[ ... ]

> @@ -475,6 +485,42 @@ static void ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
>  		      RGMII_IO_MACRO_CONFIG);
>  }
>  
> +static void ethqos_rgmii_id_macro_init(struct qcom_ethqos *ethqos, int speed)
> +{
> +	rgmii_clrmask(ethqos, RGMII_CONFIG2_TX_TO_RX_LOOPBACK_EN,
> +		      RGMII_IO_MACRO_CONFIG2);
> +
> +	if (speed == SPEED_1000)
> +		rgmii_setmask(ethqos, RGMII_CONFIG_DDR_MODE, RGMII_IO_MACRO_CONFIG);
> +	else
> +		rgmii_clrmask(ethqos, RGMII_CONFIG_DDR_MODE, RGMII_IO_MACRO_CONFIG);
> +	rgmii_setmask(ethqos, RGMII_CONFIG_BYPASS_TX_ID_EN, RGMII_IO_MACRO_CONFIG);
> +	rgmii_clrmask(ethqos, RGMII_CONFIG_POS_NEG_DATA_SEL, RGMII_IO_MACRO_CONFIG);
> +	rgmii_clrmask(ethqos, RGMII_CONFIG_PROG_SWAP, RGMII_IO_MACRO_CONFIG);
> +
> +	if (ethqos->has_emac_ge_3)
> +		rgmii_clrmask(ethqos, RGMII_CONFIG2_DATA_DIVIDE_CLK_SEL,
> +			      RGMII_IO_MACRO_CONFIG2);
> +	else
> +		rgmii_setmask(ethqos, RGMII_CONFIG2_DATA_DIVIDE_CLK_SEL,
> +			      RGMII_IO_MACRO_CONFIG2);
> +
> +	rgmii_clrmask(ethqos, RGMII_CONFIG2_TX_CLK_PHASE_SHIFT_EN,
> +		      RGMII_IO_MACRO_CONFIG2);
> +
> +	if (speed == SPEED_1000)
> +		rgmii_clrmask(ethqos, RGMII_CONFIG2_RSVD_CONFIG15, RGMII_IO_MACRO_CONFIG2);
> +	else
> +		rgmii_setmask(ethqos, RGMII_CONFIG2_RSVD_CONFIG15, RGMII_IO_MACRO_CONFIG2);
> +
> +	if (ethqos->rgmii_config_loopback_en)
> +		rgmii_setmask(ethqos, RGMII_CONFIG_LOOPBACK_EN, RGMII_IO_MACRO_CONFIG);
> +	else
> +		rgmii_clrmask(ethqos, RGMII_CONFIG_LOOPBACK_EN, RGMII_IO_MACRO_CONFIG);
> +
> +	rgmii_setmask(ethqos, RGMII_CONFIG2_RX_PROG_SWAP, RGMII_IO_MACRO_CONFIG2);
> +}
> +
>  static void ethqos_fix_mac_speed_rgmii(void *bsp_priv,
>  				       phy_interface_t interface, int speed,
>  				       unsigned int mode)

[Severity: Medium]
Does the programming guide really expect all of bits 31:17 in
RGMII_IO_MACRO_CONFIG2 to be set at 100M and 10M?

RGMII_CONFIG2_RSVD_CONFIG15 is GENMASK(31, 17), which is a 15-bit
field. The suffix looks like the field width, as it is for
RGMII_CONFIG_MAX_SPD_PRG_9 (GENMASK(16, 8)) and
RGMII_CONFIG_MAX_SPD_PRG_2 (GENMASK(7, 6)).

rgmii_setmask() is just rgmii_updatel(ethqos, mask, mask, offset). So
below 1G, ethqos_rgmii_id_macro_init() writes 0x7fff into this field,
which is 0xfffe0000 in RGMII_IO_MACRO_CONFIG2.

The existing ethqos_rgmii_macro_init() path only ever clears this
field, so this is the first place a non-zero value is written to it.

If the hardware expects a specific value there, for example 1, then
10M/100M links in rgmii-id mode would run with every reserved bit in
that range set. The effect of that is unknown, and it could break
those link speeds.

Should this be rgmii_updatel() with
FIELD_PREP(RGMII_CONFIG2_RSVD_CONFIG15, val) for the value the guide
gives? If all ones really is what the guide asks for, could you add a
comment saying so? Otherwise it reads like a single-bit setmask applied
to a multi-bit field by mistake.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017-shikra_ethernet-v3-0-26a8beb44b8f%40oss.qualcomm.com
