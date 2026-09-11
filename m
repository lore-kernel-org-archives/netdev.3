Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125B44160D;
	Fri, 11 Sep 2026 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125927; cv=none; b=WhYAwu+VuMW4koF3tWGuIxI7ZyH95pvFuOQDwByu7S6gP0qZCdL3n5/KbyK6ORmnWatbAqmJkweUxJnkejODe5KAEuI0kGUq2q7Q09uk7erLI+D6ubkGPELDkfErIFEiRY9TgxU4iyLygrt+rDEtGKtvY0IMn2DS+7mmqVYRPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125927; c=relaxed/simple;
	bh=rqKiCJf3gWsUbRPQca/CAN0RIfrbcNqytLiv5lKTl48=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LSHiSc17quTksGu+iGj0PLRmq30ME7XqzrJZK9+tWmMBd4uRZSNYcB5maNd5qmGHu/PObcxusEA5z9drh16io3uDycONBJsussb8wxGjTNzf1ztgPLhBkIzNIt5iZT6j5yvLUvon8NoVkGcY2TYhUbPXr3BPTobZureDJnYYXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7bL2UuA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7bL2UuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5684F1F0089A;
	Fri, 11 Sep 2026 11:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125916;
	bh=1//qZSRS+hJDa1tgu3tfHEnaKnJO5kTUToo92WITcnw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l7bL2UuAQ1c3GP2ytUeLyrlGQHpnk5WC+NnS9brjNa0bRHl7O4QKofRDC2BaWPghk
	 x3QC5gqWbA4v48oPtcpSJwKUNDi6Rx1AqeoC+O2wggnnd7K7nM2MT+3JAOXT5aUg6P
	 +d98xToerqvUMxy4OgLgrd93RoscyQvn19UigUVBL8wRgyz5z4l096nIEy1Zz5Szw4
	 7d7cMmUMfKiJ9E0tRbqB5rmLSimtNFD/wkcqk/+vuUJzzLGkYOttesMqBicC9CIDwz
	 DE0u02m3kOXAsb45YmdAuCha6/rXTbPpsywdvkNjRVOZ6GqHpVWplIr3+FS8ADyNBX
	 BUk3h90Z5kmfw==
Subject: Re: [PATCH net-next v2 5/9] net: stmmac: qcom-ethqos: fix RGMII_ID
 mode to use DLL bypass
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
Date: Fri, 11 Sep 2026 11:25:14 +0000
Message-ID: <178912591493.219967.8863321460780410702@kernel.org>
In-Reply-To: <20260908-shikra_ethernet-v2-5-bbe3389d0652@oss.qualcomm.com>
References: <20260908-shikra_ethernet-v2-5-bbe3389d0652@oss.qualcomm.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The patch is worded as a bug fix ("fix RGMII_ID mode to use
  DLL bypass", "Also fix ethqos_set_clk_tx_rate()") for two user-visible…

--

net: stmmac: qcom-ethqos: fix RGMII_ID mode to use DLL bypass

For phy-mode = "rgmii-id" the driver now powers down the DLL, sets DDR
bypass and programs the IO_MACRO through a new
ethqos_rgmii_id_macro_init() helper instead of running the generic DLL
init.  It also stops doubling the link clock rate at 100M/10M in that
mode, and drops RGMII_ID from the TX phase-shift suppression in
ethqos_rgmii_macro_init().

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
>  }

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

[Severity: Medium]
The changelog describes this as two functional corrections, "fix RGMII_ID
mode to use DLL bypass" and "Also fix ethqos_set_clk_tx_rate() to not
double the clock rate in bypass mode at 100M/10M", but there is no Fixes:
tag.  Should one be added?

Both defects look reachable before this patch.  qcom_ethqos_probe() accepts
PHY_INTERFACE_MODE_RGMII_ID and installs the affected callback:

	case PHY_INTERFACE_MODE_RGMII_ID:
	case PHY_INTERFACE_MODE_RGMII_RXID:
	case PHY_INTERFACE_MODE_RGMII_TXID:
		plat_dat->fix_mac_speed = ethqos_fix_mac_speed_rgmii;

so an rgmii-id link previously ran the full DLL init and had the RX delay
programmed by ethqos_rgmii_macro_init() through
SDCC_DDR_CONFIG_PRG_RCLK_DLY / SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY, and also
got rate * 2 from ethqos_set_clk_tx_rate().

The partial mitigation for the TX side came in with 164a9ebe9742 ("net:
stmmac: dwmac-qcom-ethqos: Respect phy-mode and TX delay"), which only
suppressed RGMII_CONFIG2_TX_CLK_PHASE_SHIFT_EN and left the RX delay and
the doubled rate in place.  Would that commit, or the original driver
commit, be the right Fixes: target here?

Related question: which platform reproduces the misprogramming, and on
which hardware was the new bypass register sequence in
ethqos_rgmii_id_macro_init() validated?  Grepping arch/arm64/boot/dts/qcom
turns up no ethqos node using phy-mode = "rgmii-id" (only sa8540p-ride.dts,
which uses "rgmii-txid"), so it is hard to tell from the changelog who is
affected and what the backport risk is.  Could that be stated in the commit
message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-shikra_ethernet-v2-0-bbe3389d0652%40oss.qualcomm.com
