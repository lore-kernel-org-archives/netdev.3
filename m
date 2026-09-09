Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75573BED61;
	Wed,  9 Sep 2026 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990456; cv=none; b=YfHICjBeFXes1IT4HGKADfLaltY8HOb8igYuzwtQMgBdQHDEOYfDVoyl5FndyN4Jon5rXLibo9DFBMVvClKGleABvdDRG2FAkxcVVwcgkNRO9XirJCWrJjxxGKIPyKBN6G9X81lSSwgKkJ71O2MlDmysyk4oJb0f3MrGPCqOfdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990456; c=relaxed/simple;
	bh=mxmCFcHexHv9KSFGTwkZ6nRLna1emqzvTuP5Ux1zJj8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KSxn01EnOilGwrQcyEAIThRBEsKz6eZ+va+BlVkSjHjgDSgOdi8UP8bdTb5QnEbSPHdTwr188traZBPe2gqry55Rz4KiE/d4raYAODRVjXTjxrz2tpV8CuaYJDtywDqREHi2LTiSBoMBQ3r6m025qBqytrt+dlgYkPqEpmXbvXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaPADtvv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaPADtvv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D65D1F0089A;
	Wed,  9 Sep 2026 21:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788990431;
	bh=Fxm0rfg/W700YPmfHnrKBmFSWVktG0RSyDx6J4rYQAc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NaPADtvvzmV+s2NvbIW2UOB799kJDqph9FG7qpdZNYPB8JB9DakHXvheENaAkFlt0
	 rqvIYntlUwYij2NOfumWJNsadhT7pV2KuKjUiCnd8mSEqm9vdd0sJy5pViEAqh/Ddw
	 heYd1xaZ44pqa8U8Ccel7jEVMthWLeREfUeng+Xde8kqYcndHOHHw9LBkyyw9mbFoi
	 SAH5mcPUKI5r+nhD2kFQr7gwBvxj7b7Z22FbiBXtrB1bpMpYyYak3Iw9i9KgIDfZvp
	 cIoJ00eHSs/EGuQ3E8fWBz4ullGk8kCGaq4O+t3ApjOQzPm1JHcGKmvyjzh5AK5Wr3
	 Q2GRfXVGWQhGw==
Subject: Re: [PATCH net-next 5/9] net: stmmac: qcom-ethqos: fix RGMII_ID mode
 to use DLL bypass
From: netdev-bot+sashiko@kernel.org
To: mohd.anwar@oss.qualcomm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, afd@ti.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, richardcochran@gmail.com, andersson@kernel.org,
 konradybcio@kernel.org, alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
 joabreu@synopsys.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Wed, 09 Sep 2026 21:47:09 +0000
Message-ID: <178899042982.219967.10620350671306953901@kernel.org>
In-Reply-To: <20260904-shikra_ethernet-v1-5-a50765996035@oss.qualcomm.com>
References: <20260904-shikra_ethernet-v1-5-a50765996035@oss.qualcomm.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 1

- [High] ethqos_set_clk_tx_rate() applies the new DLL-bypass (no-MAC-
  delay) link clock rate to every RGMII variant except plain "rgmii",…
- [Low] The patch is titled "fix RGMII_ID mode to use DLL bypass" and the
  changelog states the driver "currently falls through to the generic…

Pre-existing issues:
- [Medium] For PHY_INTERFACE_MODE_RGMII_RXID the PHY supplies the RX
  delay, yet that mode still takes the legacy path in…

--

net: stmmac: qcom-ethqos: fix RGMII_ID mode to use DLL bypass

For rgmii-id the PHY supplies both delays, so this powers down the DLL,
sets DDR bypass and programs the IO_MACRO through a new
ethqos_rgmii_id_macro_init() helper.  It also changes the link clock rate
calculation in ethqos_set_clk_tx_rate() and drops RGMII_ID from the
phase-shift suppression in ethqos_rgmii_macro_init().

A few questions below.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 44270c25d874f..67738c1598c50 100644
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
> +	if (ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII ||
> +	    speed == SPEED_1000)
> +		rate *= 2;
> +
> +	return clk_set_rate(ethqos->link_clk, rate);
>  }

[Severity: High]
Should this predicate match the one that actually selects the bypass
hardware configuration?

Here the un-doubled (bypass) rate is applied to every RGMII variant
except plain "rgmii", so rgmii-txid and rgmii-rxid also get the
un-doubled rate at 100M and 10M:

  ethqos_set_clk_tx_rate()
     if (ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII ||
         speed == SPEED_1000)
             rate *= 2;

But in ethqos_fix_mac_speed_rgmii() only PHY_INTERFACE_MODE_RGMII_ID
takes the new early return into the bypass configuration:

  if (ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_ID) {
          rgmii_setmask(ethqos, SDCC_DLL_CONFIG_PDN, SDCC_HC_REG_DLL_CONFIG);
          rgmii_setmask(ethqos, SDCC_USR_CTL_DDR_BYPASS, SDCC_USR_CTL);
          ethqos_rgmii_id_macro_init(ethqos, speed);
          return;
  }

rgmii-txid and rgmii-rxid still run the full DLL init and
ethqos_rgmii_macro_init(), which sets RGMII_CONFIG_DDR_MODE and programs
PRG_RCLK_DLY, i.e. the "MAC added delay" configuration that the new
comment says needs 50 MHz at 100M and 5 MHz at 10M.  Those modes now get
25 MHz and 2.5 MHz instead, where before the patch the rate was always
doubled.

arch/arm64/boot/dts/qcom/sa8540p-ride.dts uses phy-mode = "rgmii-txid"
on both EMAC nodes, so is this a regression for that board whenever the
link comes up at 100 Mbps or 10 Mbps?

Would something like the following keep the two halves consistent?

  if (ethqos->phy_mode != PHY_INTERFACE_MODE_RGMII_ID ||
      speed == SPEED_1000)
          rate *= 2;

The condition is still unchanged at the tip of the series
(70ec5f4a19736338086794f26222dcb9ec15b24c); the later commit
"net: stmmac: qcom-ethqos: warn about legacy RGMII PHY modes" only adds a
dev_warn() on that path and does not restore the doubled rate.

>  
>  static void
> @@ -405,8 +416,7 @@ static void ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
>  		      RGMII_IO_MACRO_CONFIG2);
>  
>  	/* Determine if the PHY adds a 2 ns TX delay or the MAC handles it */
> -	if (ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_ID ||
> -	    ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_TXID)
> +	if (ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_TXID)
>  		phase_shift = 0;
>  	else
>  		phase_shift = RGMII_CONFIG2_TX_CLK_PHASE_SHIFT_EN;

[Severity: Medium]
This isn't a problem introduced by this patch, but was rgmii-rxid
considered while reworking this?

qcom_ethqos_probe() accepts it and routes it to the same handler:

  case PHY_INTERFACE_MODE_RGMII_RXID:
  case PHY_INTERFACE_MODE_RGMII_TXID:
          plat_dat->fix_mac_speed = ethqos_fix_mac_speed_rgmii;

and ethqos_rgmii_macro_init() programs the MAC RX delay regardless of
phy-mode:

  rgmii_updatel(ethqos, SDCC_DDR_CONFIG_PRG_RCLK_DLY,
                FIELD_PREP(SDCC_DDR_CONFIG_PRG_RCLK_DLY,
                           prg_rclk_dly), SDCC_HC_REG_DDR_CONFIG);

  rgmii_setmask(ethqos, SDCC_DDR_CONFIG_PRG_DLY_EN,
                SDCC_HC_REG_DDR_CONFIG);

(and SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_CODE = 5 plus the EXT_PRG_RCLK_DLY
bits at 100M/10M).  For rgmii-rxid the PHY already supplies the RX delay,
which is the same class of issue the patch fixes on the rgmii-id side.
No in-tree qcom DTS uses "rgmii-rxid", so only out-of-tree boards would
see it.  Could the changelog say whether rgmii-rxid was evaluated and
left alone deliberately?

[ ... ]

> @@ -493,6 +539,21 @@ static void ethqos_fix_mac_speed_rgmii(void *bsp_priv,
>  
>  	ethqos_set_func_clk_en(ethqos);
>  
> +	/* For rgmii-id mode, the PHY should add the required delays.
> +	 * Therefore, power down the DLL and program it in bypass mode.
> +	 * Program the IO_MACRO as per the settings recommended by the
> +	 * programming guide for bypass mode. This will ensure that the
> +	 * MAC core doesn't add any additional delays.
> +	 */
> +	if (ethqos->phy_mode == PHY_INTERFACE_MODE_RGMII_ID) {
> +		rgmii_setmask(ethqos, SDCC_DLL_CONFIG_PDN, SDCC_HC_REG_DLL_CONFIG);
> +		rgmii_setmask(ethqos, SDCC_USR_CTL_DDR_BYPASS, SDCC_USR_CTL);
> +
> +		ethqos_rgmii_id_macro_init(ethqos, speed);
> +
> +		return;
> +	}
> +

[Severity: Low]
The subject says "fix RGMII_ID mode to use DLL bypass" and the changelog
describes a user-visible timing misconfiguration, but the commit carries
only a Signed-off-by, with no Fixes: tag and no stable Cc.

Would this one be appropriate?

  Fixes: 164a9ebe9742 ("net: stmmac: dwmac-qcom-ethqos: Respect phy-mode and TX delay")

That commit introduced the per-phy-mode delay handling for rgmii-id and
rgmii-txid while leaving the DLL/RX delay path enabled for rgmii-id.

>  	/* Initialize the DLL first */
>  
>  	/* Set DLL_RST */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904-shikra_ethernet-v1-0-a50765996035%40oss.qualcomm.com
