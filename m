Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F213274FDF;
	Sun, 20 Sep 2026 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789902820; cv=none; b=Jrq5z1ZIrGnuC8PBEPU+5BtZjiJxKgUJeAUd50VKA1Gg3OYGKlJMAfoYpsyCkqPjosdo4IM1W/CahS1NrXuU1AhQr3TUZJYBxr16XZjPiKYeA86++MTlbyptBzDxl97iNLQ9+nyaiz73/UoRNCU23Ik4nT1jgKRCGKJhHS4NlXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789902820; c=relaxed/simple;
	bh=gOYER6IUHXkL7jv8ZD1iRnGsJ3p9JkO/AqmkTPt1gxw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ClxYL6B2uX30t1u5NEFL0YglEp8Di88oT0YkL4tt+O1kdnl88ZWJ3NTbkE4WZii8yv0n95ffNWPKOPRtDI7Nxw+Z3ipxkzrOs2CqSFI5KaFzETTdF799aasZRf365CgDHOA8NpysUijd+4PCXUYS0ZoyLsnJGsqfwnx1u4dQEic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKLtuZB+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKLtuZB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C00D1F00893;
	Sun, 20 Sep 2026 11:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789902819;
	bh=hNJ2LbS/20qvrKMUhXuYqKizXYn9BXYfiVTMkSUbS3o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VKLtuZB+WOCGGrb/Yf/q/v9TCvGveDo6wZ7zA2ZmRk7FtYVhwtMnrTYM1Ol5vl6yV
	 42rePEX8+XezFoiJZBi48VZ++sCmLBlMN7W6VW3fO8REm8Jf2BdSE/5LhQtdaUg2CY
	 YbLcN3/VM0k8PQf/ZyWeMaCCoV/gWYoWTRm7NVBA8gTzkliVIfELnO+Axo9eY9WOXc
	 1XZHUwoeyelAQeG6DQjCnJhI8w4PnvwEbwsD0OC+rBBfX7IyZRyhG3M5zEvaCkYpnO
	 trPAlxEl4D1Ix7e9JImCMRRDNbkbST5l8KjTpeS3KPhT1Bo2dE9XWNypGPX1vIZR8H
	 fAyKfpX5+DHGg==
Subject: Re: [PATCH net 1/2] net: stmmac: propagate platform mac_finish errors
From: netdev-bot+sashiko@kernel.org
To: tom.karpiniec@outlook.com
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com,
 mohd.anwar@oss.qualcomm.com, linux@armlinux.org.uk, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 yong.liang.choong@linux.intel.com, brgl@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 11:13:37 +0000
Message-ID: <178990281791.2160803.4738243247711956388@kernel.org>
In-Reply-To: =?utf-8?q?=3CCH3PR11MB8413069BD77B03793D1A9B42E4B92=40CH3PR11MB?=
 =?utf-8?q?8413=2Enamprd11=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3CCH3PR11MB8413069BD77B03793D1A9B42E4B92=40CH3PR11MB8?=
 =?utf-8?q?413=2Enamprd11=2Eprod=2Eoutlook=2Ecom=3E?=
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit's stated goal — stop phylink from treating an
  interface as successfully configured when the SerDes is not ready — is…
- [Low] The continuation line of the newly returned call is misaligned by
  one column.

--

net: stmmac: propagate platform mac_finish errors

stmmac_mac_finish() previously dropped the return value of the platform
mac_finish callback and always told phylink the interface was configured
successfully.  The patch forwards the callback's result instead, keeping the
zero return when no callback is installed.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 1fb5f804ea234..1350e92943ac1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1048,8 +1048,8 @@ static int stmmac_mac_finish(struct phylink_config *config, unsigned int mode,
>  	struct stmmac_priv *priv = netdev_priv(ndev);
>  
>  	if (priv->plat->mac_finish)
> -		priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode,
> -				       interface);
> +		return priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode,
> +					     interface);

[Severity: High]
The changelog says phylink "can report carrier even though the SerDes is
not ready", and that after this change phylink can "keep the link down
until a subsequent configuration succeeds".  Does that hold for the other
in-tree user of plat->mac_finish?

intel_mac_finish() in dwmac-intel.c ends with:

	ret = intel_set_reg_access(regs, max_regs);
	if (ret < 0)
		return ret;

	priv->plat->phy_interface = interface;

	intel_serdes_powerdown(ndev, intel_priv);
	intel_serdes_powerup(ndev, intel_priv);

	return ret;

ret is the zero left by intel_set_reg_access(), and the result of
intel_serdes_powerup() is never assigned, so the callback returns 0 even
when the SerDes bring-up failed.

intel_serdes_powerup() returns the -ETIMEDOUT from serdes_status_poll()
(ten polls of SERDES_GSR0) at three points:

	if (data) {
		dev_err(priv->device, "Serdes PLL clk request timeout\n");
		return data;
	}
	...
	if (data) {
		dev_err(priv->device, "Serdes assert lane reset timeout\n");
		return data;
	}
	...
	if (data) {
		dev_err(priv->device, "Serdes power state P0 timeout.\n");
		return data;
	}

In each of those cases the preceding intel_serdes_powerdown() has already
put the lane in SERDES_PWR_ST_P3 (and gated SERDES_PHY_RX_CLK on PSE
parts), and plat->phy_interface has already been overwritten with no
rollback.

Since the Intel callback discards the status itself, can forwarding its
return value in stmmac_mac_finish() surface anything for the EHL/ADL-N
SGMII configurations that install intel_mac_finish (ehl_sgmii_data,
ehl_pse0/1_sgmii1g_data, adln_sgmii_phy0_data)?  The mac_finish contract
in include/linux/phylink.h states "Returns zero on success, or negative
errno on failure which will be reported to the kernel log", so should
intel_mac_finish() also return the intel_serdes_powerup() result for the
described behaviour to materialise on that platform?

[Severity: Low]
This isn't a bug, but the continuation line looks off by one column now.
The statement is two tabs deep, plus "return " and
"priv->plat->mac_finish(", which puts ndev at column 46, while the
continuation uses five tabs plus five spaces, i.e. column 45.  checkpatch
--strict should emit "CHECK: Alignment should match open parenthesis" for
this.

>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/CH3PR11MB8413FCBA598F7FABC04ADCFEE4B92%40CH3PR11MB8413.namprd11.prod.outlook.com
