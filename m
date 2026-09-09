Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840013C10B8;
	Wed,  9 Sep 2026 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990442; cv=none; b=FA0Q3CXLHG48LPE13S7xFd2GPoje34QOo6qAM/Tx/8RlG1W2MDEwbP+OLdK6FliDXeEQS2fuxH+QQnKhP7iJmMOMCPbzBk1mdd1VTVJkUjUkGwbpZ+3b+PgGdDa3D450mWpYsx1YQkOOMQNsjF7lcY3ySdeeeUHQ6A4P+9YVKt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990442; c=relaxed/simple;
	bh=g5uFWocXYhrPVwTZunXIpbbJmnal6J2se4cgUWNFvN0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WoHZMIFEqcZfpiqbR/1nGlzmn2HsZdonBT7oqC25ksycc26tk/hx2N/lwf7BBErI5+kXVGtTgV23vzC2TxP4hkR9indbQeBhkQKFYB06T1RgR4LW94m9emkf9rP/rgJ66xhixhyjaItHi3x/TnAJ5ygRfGEeigstKVYHHOxLjQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RffTdeTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RffTdeTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E371F00899;
	Wed,  9 Sep 2026 21:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788990429;
	bh=awiuTDRsYSjQfTpE2iAFXYzpEOg1sGc4+ZobikWlx8M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RffTdeTZlsEfoMdRbVlQ1+q1/KlEYZ8YbKJPcL/7FHxHBYDgSKFA0o3Mlq7BX/qgx
	 9knzP0MgK5+XsSmbWWSSpI6fy8OqnQXMpty2ZzFbwm0J4Z6cLD9jf+qYajc1W0CSf5
	 rMqvgbzji/KGcrS8CCIBGkPU++Et1DRjvDobsmu5V4mwPO8kZTRhbShansGZ6s/w5w
	 gJv6eM7WJV8AO08gL6P3SkcXRUBJxAjz0zxXCVIq7P2F5KzA4X8oaC6TKTwA1bxZEm
	 Fu9Pqp6R20VPuoYMtvomLb5GLXtXcf+kI60iK6GuioXPmjr9UW1DL5NlZ9qnRpblQw
	 4gZiyeR0oMogQ==
Subject: Re: [PATCH net-next 4/9] net: stmmac: qcom-ethqos: convert
 ethqos_rgmii_macro_init() to void
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
Date: Wed, 09 Sep 2026 21:47:07 +0000
Message-ID: <178899042791.219967.14323213694052499203@kernel.org>
In-Reply-To: <20260904-shikra_ethernet-v1-4-a50765996035@oss.qualcomm.com>
References: <20260904-shikra_ethernet-v1-4-a50765996035@oss.qualcomm.com>
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

- [Medium] net: stmmac: qcom-ethqos: removing the {SPEED_10, SPEED_100,
  SPEED_1000} guard from ethqos_rgmii_macro_init() is not the dead-code…

--

net: stmmac: qcom-ethqos: convert ethqos_rgmii_macro_init() to void

The patch changes ethqos_rgmii_macro_init() to return void because its
only caller ignores the return value, and drops the
{SPEED_10, SPEED_100, SPEED_1000} check together with the now unused
struct device pointer.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index ac7d6d3e205a1..44270c25d874f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -371,9 +371,8 @@ static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
>  	return 0;
>  }
>  
> -static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
> +static void ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
>  {
> -	struct device *dev = &ethqos->pdev->dev;
>  	unsigned int prg_rclk_dly, loopback;
>  	unsigned int phase_shift;
>  
> @@ -384,11 +383,6 @@ static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
>  	/* Select RGMII, write 0 to interface select */
>  	rgmii_clrmask(ethqos, RGMII_CONFIG_INTF_SEL, RGMII_IO_MACRO_CONFIG);
>  
> -	if (speed != SPEED_1000 && speed != SPEED_100 && speed != SPEED_10) {
> -		dev_err(dev, "Invalid speed %d\n", speed);
> -		return -EINVAL;
> -	}
> -

[Severity: Medium]
Which check higher up the call stack does this duplicate?  The commit
message says "the speed validation duplicates a check higher up the call
stack", but the only speed check above ethqos_fix_mac_speed_rgmii() appears
to be the switch in stmmac_mac_link_up(), which accepts speeds well above
1000:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_mac_link_up() {
	...
	case SPEED_2500:
		if (interface == PHY_INTERFACE_MODE_USXGMII)
			ctrl |= priv->hw->link.xgmii.speed2500;
		else
			ctrl |= priv->hw->link.speed2500;
		break;
	...
	default:
		netdev_err(priv->dev,
			   "unsupported speed %s on %s, leaving the MAC disabled\n",
			   phy_speed_to_str(speed), phy_modes(interface));
		return;
	}

	if (priv->plat->fix_mac_speed)
		priv->plat->fix_mac_speed(priv->plat->bsp_priv, interface,
					  speed, mode);
	...
}

So SPEED_2500 and above reach fix_mac_speed() unfiltered, and
ethqos_fix_mac_speed_rgmii() passes speed straight into
ethqos_rgmii_macro_init() without a check of its own.

The other speed validation in this driver, rgmii_clock() called from
ethqos_set_clk_tx_rate(), runs from priv->plat->set_clk_tx_rate() later in
stmmac_mac_link_up(), i.e. after fix_mac_speed(), so it also cannot keep an
out-of-range speed out of the macro programming.

Does the RGMII limit actually come from phylink's per-interface capability
filtering rather than from the call stack?  The fixed-link path looks like
it bypasses that filtering:

drivers/net/phy/phylink.c:phylink_parse_fixedlink() {
	...
	pl->link_config.speed = speed;
	...
	phylink_warn(pl, "fixed link %s duplex %dMbps not recognised\n", ...);
	...
}

The phylink_validate() result there is only used for the warning, and
phylink_get_fixed_state() then copies the stored config verbatim:

drivers/net/phy/phylink.c:phylink_get_fixed_state() {
	...
	*state = pl->link_config;
	...
}

which phylink_link_up() hands to mac_link_up() unchanged.

With phy-mode = "rgmii" (or rgmii-id/rxid/txid, all of which install
ethqos_fix_mac_speed_rgmii) and a fixed-link node specifying
speed = <2500>, ethqos_rgmii_macro_init() is now entered with speed ==
2500.  Before this patch it logged "Invalid speed 2500" and returned after
only the loopback-disable and INTF_SEL writes.  Now it runs to completion
and applies the full non-1000 configuration (DDR_MODE set, BYPASS_TX_ID_EN
set, PROG_SWAP and POS_NEG_DATA_SEL cleared, EXT_PRG_RCLK_DLY_CODE = 5,
RX_PROG_SWAP per has_emac_ge_3) while programming neither MAX_SPD_PRG_2 nor
MAX_SPD_PRG_9, so the speed divider keeps its power-on value and there is
no diagnostic left.

Would it make sense to either keep the check, or describe this behaviour
change and the loss of the diagnostic in the commit message?  Later commits
in this area do not reintroduce validation either: as of
70ec5f4a19736338086794f26222dcb9ec15b24c neither
ethqos_rgmii_macro_init() nor the newly added ethqos_rgmii_id_macro_init()
validates the speed.

>  	rgmii_setmask(ethqos, RGMII_CONFIG_DDR_MODE, RGMII_IO_MACRO_CONFIG);
>  
>  	if (speed == SPEED_1000) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904-shikra_ethernet-v1-0-a50765996035%40oss.qualcomm.com
