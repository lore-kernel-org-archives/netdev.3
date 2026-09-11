Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213F6457E5C;
	Fri, 11 Sep 2026 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125927; cv=none; b=iUKFLRwgX6nEbtPjqPhAN4NLCToDE/N7C7gmQ4Y5nPFAJcgC0VAb4kMbrFZutMyRwjWWXU0Jv81fFQQUXh4yEqoOSh8GN2r0J7uRGh1avz1+0ahNYL+twY8/zd3Jh/daXsVJOrHhU18LkZBtTsB9SKM1H+Qf0Bqg1BNwuaB2KsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125927; c=relaxed/simple;
	bh=kO4jNVxro618510vEcBdqU9dJR50/9uAtMyazRvYXQQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KNhyorvKEmVdACovYitZd4tRHjjfirrg62PyyoybCh3xJKcMR9+n533u/VdRLa/v6pO0PJPzg08aPHLw6bRjNbhIa4D4Qnln9Jjz47LsQsVuaPhoxj27v8GGQEUgva3wTu2Px6M4IECQjmbbG4LW3viflLgIDWBqbU2bI1dC2os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9HORjxT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9HORjxT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1651F0089C;
	Fri, 11 Sep 2026 11:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125921;
	bh=VqunXJGGS/PDbbgMJ0G/ODtjBROTqOXa86+5nrXhdNg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U9HORjxTZXihuesFPdMs4/VvG9NkowYEhQ+I/bxor1qZ/lCkR7hj5DW6NSp3IagBZ
	 WMiEhfhfqoHnF5dktct9h6nDJKl0FPUuEfjrwEsJ3L3nE1hJKtFdJvQlWe7DI2cUq8
	 0XiuzMOu/3pUbPaHASTrhUoLcrRZZnJdC6e+yHmumjclhz560bGet4LOuMQN1ZDf3E
	 qSr/S361CYYFLLl3MZEmEtvgRM/gVbJ3maHvIk6cVNiojLhP9nwnqWD9uVryDb7tN0
	 09W6LyXvxU5DkaxZmQ7oEsXlPjiukp+ZjLRpQ8evjC3GRqo6WanhTJsLcovtGyYNIZ
	 JUyJWamM0zK7A==
Subject: Re: [PATCH net-next v2 7/9] net: stmmac: qcom-ethqos: set initial
 RGMII link clock to lowest speed
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
Date: Fri, 11 Sep 2026 11:25:19 +0000
Message-ID: <178912591910.219967.8208494265030276950@kernel.org>
In-Reply-To: <20260908-shikra_ethernet-v2-7-bbe3389d0652@oss.qualcomm.com>
References: <20260908-shikra_ethernet-v2-7-bbe3389d0652@oss.qualcomm.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] For legacy RGMII phy-modes (rgmii, rgmii-rxid, rgmii-txid) the
  RGMII IO-macro DLL is programmed and its lock polled inside…
- [Low] Commit message names the wrong callback: it states "fix_mac_speed
  updates the rate once a link is established", but neither…

--

net: stmmac: qcom-ethqos: set initial RGMII link clock to lowest speed

The probe-time call to ethqos_set_clk_tx_rate() is changed from SPEED_1000
to SPEED_10 so the RGMII link clock is not left at 250 MHz while no link is
up.  Two questions below, one about the changelog wording and one about the
first link-up path.

> net: stmmac: qcom-ethqos: set initial RGMII link clock to lowest speed
>
> On probe the RGMII link clock is initialised at SPEED_1000, which
> translates to a 250 MHz source clock even when no PHY link is present,
> drawing unnecessary power.
>
> Initialise at SPEED_10 instead; fix_mac_speed updates the rate once
> a link is established.

[Severity: Low]
Is "fix_mac_speed updates the rate once a link is established" the right
callback name here?  Neither ethqos_fix_mac_speed_rgmii() nor
ethqos_fix_mac_speed_sgmii() calls clk_set_rate() on ethqos->link_clk; the
only clk_set_rate(ethqos->link_clk, ...) in the file is in
ethqos_set_clk_tx_rate(), which probe installs as
plat_dat->set_clk_tx_rate.

stmmac_mac_link_up() invokes the two as separate callbacks, fix_mac_speed()
first and set_clk_tx_rate() later:

	if (priv->plat->fix_mac_speed)
		priv->plat->fix_mac_speed(priv->plat->bsp_priv, interface,
					  speed, mode);
	...
	if (priv->plat->set_clk_tx_rate) {
		ret = priv->plat->set_clk_tx_rate(priv->plat->bsp_priv,
						priv->plat->clk_tx_i,
						interface, speed);

Could the changelog name set_clk_tx_rate instead, so the ordering is not
hidden?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index a92bf4a6a2dbd..2471871562ed9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -814,7 +814,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  				     "Failed to get serdes phy\n");
>  
>  	ethqos_set_clk_tx_rate(ethqos, NULL, plat_dat->phy_interface,
> -			       SPEED_1000);
> +			       SPEED_10);

[Severity: Medium]
Does the first 1000 Mbps link-up now run the SDCC DLL bring-up with the
probe-time 10 Mbps clock rate?

For the legacy rgmii / rgmii-rxid / rgmii-txid modes,
ethqos_fix_mac_speed_rgmii() enables the DLL and polls for lock:

	if (speed != SPEED_100 && speed != SPEED_10) {
		/* Set DLL_EN */
		rgmii_setmask(ethqos, SDCC_DLL_CONFIG_DLL_EN,
			      SDCC_HC_REG_DLL_CONFIG);
		...
		/* wait for DLL LOCK */
		if (read_poll_timeout_atomic(rgmii_readl, val,
					     val & SDC4_STATUS_DLL_LOCK,
					     1000, 1000000, true,
					     ethqos, SDC4_STATUS))
			dev_err(dev, "Timeout while waiting for DLL lock\n");
	}

and stmmac_mac_link_up() calls fix_mac_speed() before set_clk_tx_rate(), so
at that point ethqos->link_clk is still at the rate programmed at probe.
With SPEED_10 that is rgmii_clock(SPEED_10) = 2500000, doubled to 5 MHz for
the non-rgmii-id modes by ethqos_set_clk_tx_rate(), where it used to be
250 MHz:

	/* Clock Rate Requirements:
	 * MAC added delay: 250/50/5 Mhz for 1G/100M/10M
	 * No MAC delay (DLL bypass): 250/25/2.5 Mhz for 1G/100M/10M
	 */

If the DLL cannot lock at that input rate, the poll busy-waits its full 1 s
budget in the link-up path and then continues with an unlocked DLL, since
fix_mac_speed() is not re-run after set_clk_tx_rate() raises the rate to
250 MHz.

Note the driver itself skips the DLL enable/lock for SPEED_10 and
SPEED_100, which suggests the block is expected to see the rate matching
the negotiated speed.  Is a minimum DLL input frequency involved here, and
if so should the probe-time rate stay high, or should the clock be raised
before fix_mac_speed() runs?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-shikra_ethernet-v2-0-bbe3389d0652%40oss.qualcomm.com
