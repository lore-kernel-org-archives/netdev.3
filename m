Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07707349CC9
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694363; cv=none; b=BgsD0pe0nbUw/dFM4cCPQFNxJtqYvYNJymhC55uMaccOwyRYeGOg7royMPtbGFHhAtF1PIE7jA6O130dGjHKVxsyun27Xd7+sNLql2zz7KSxKzSUHjVI4L8jTLO1tKxqaxahXZY3iATGOeE1txgB7Qi/BuXV6h26xYoiNGIU16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694363; c=relaxed/simple;
	bh=4Gii1ym6K9QpzVfq94PZJSdWoP7NnEix+aBSrFpPCIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0kcCZv91luFP+WwResSa45f8D+BT7hFHBX0XS1mG+HzBPkIvMrfjkztZulEimKRzs2vLxBgSoAO0dnfsIJwCSKXn/tSyOoIPdIsE/Ipz7/zakSCd4hZqu8LDqdvE4WlLpzW4kupBKCwNg97Dlcrqho6/1vMmAa4nWTRA2Is+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XEmPz3pU; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XEmPz3pU"
Message-ID: <a5c5b8a6-85a8-7830-e19b-ffd5de750e3c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783694349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QFfQEvWIc8hC7yQXMHVs3FeaASqXtgVk5YNjOkXDQE=;
	b=XEmPz3pUI7UmGCNy0ohkq9/USDv+N0QFWPCEGJ1cxiuPA77A3xsmAqqU/7SLLi1HhOSJrf
	hhSlBrNgATMMFi4vVfAwiLbKvUsTZ8NQ/B/6/jA6wWWa2zMaK3bbQqb9E3NrW+ZNFlJDyf
	BWyeEUMKQsNnduL221Z7cKL44RujoJo=
Date: Fri, 10 Jul 2026 10:39:03 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net: dpaa: fix mode setting
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710143430.2276141-1-mwalle@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260710143430.2276141-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/10/26 10:22, Michael Walle wrote:
> Before converting to the phylink interface, the init function would have
> set the correct I/F mode depending on the maximum link speed of an
> interface. After converting to phylink, the established link speed
> is used to determine this setting and is set in the .link_up()
> callback. The callback isn't called because the link is never
> established between the PCS and a connected SGMII PHY.
> To fix it, don't use the current speed, but set the mode depending on
> the interface (which implies the maximum speed) in .mac_config().
> 
> Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
> Suggested-by: Sean Anderson <sean.anderson@linux.dev>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> FWIW, I dropped setting a non-reserved mode in init(). The hardware
> default is 0 and the mac_config() will set a valid mode anyway.
> 
> Changes in v2:
>   - the setting is/was based on the maximum speed, not the current
>     speed. thus, move the setting into mac_config().
>   - Link to v1: https://lore.kernel.org/r/20260706121011.1948906-1-mwalle@kernel.org/
> 
>   .../net/ethernet/freescale/fman/fman_dtsec.c  | 26 ++++++++++---------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
> index fe35703c509e..7075f93bab49 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
> @@ -900,22 +900,28 @@ static void dtsec_mac_config(struct phylink_config *config, unsigned int mode,
>   {
>   	struct mac_device *mac_dev = fman_config_to_mac(config);
>   	struct dtsec_regs __iomem *regs = mac_dev->fman_mac->regs;
> -	u32 tmp;
> +	u32 ecntrl, maccfg2;
> +
> +	maccfg2 = ioread32be(&regs->maccfg2);
> +	maccfg2 &= ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE);
>   
>   	switch (state->interface) {
>   	case PHY_INTERFACE_MODE_RMII:
> -		tmp = DTSEC_ECNTRL_RMM;
> +		ecntrl = DTSEC_ECNTRL_RMM;
> +		maccfg2 |= MACCFG2_NIBBLE_MODE;
>   		break;
>   	case PHY_INTERFACE_MODE_RGMII:
>   	case PHY_INTERFACE_MODE_RGMII_ID:
>   	case PHY_INTERFACE_MODE_RGMII_RXID:
>   	case PHY_INTERFACE_MODE_RGMII_TXID:
> -		tmp = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
> +		ecntrl = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
> +		maccfg2 |= MACCFG2_BYTE_MODE;
>   		break;
>   	case PHY_INTERFACE_MODE_SGMII:
>   	case PHY_INTERFACE_MODE_1000BASEX:
>   	case PHY_INTERFACE_MODE_2500BASEX:
> -		tmp = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
> +		ecntrl = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
> +		maccfg2 |= MACCFG2_BYTE_MODE;
>   		break;
>   	default:
>   		dev_warn(mac_dev->dev, "cannot configure dTSEC for %s\n",
> @@ -923,7 +929,8 @@ static void dtsec_mac_config(struct phylink_config *config, unsigned int mode,
>   		return;
>   	}
>   
> -	iowrite32be(tmp, &regs->ecntrl);
> +	iowrite32be(ecntrl, &regs->ecntrl);
> +	iowrite32be(maccfg2, &regs->maccfg2);
>   }
>   
>   static void dtsec_link_up(struct phylink_config *config, struct phy_device *phy,
> @@ -948,15 +955,10 @@ static void dtsec_link_up(struct phylink_config *config, struct phy_device *phy,
>   	iowrite32be(tmp, &regs->ecntrl);
>   
>   	tmp = ioread32be(&regs->maccfg2);
> -	tmp &= ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE | MACCFG2_FULL_DUPLEX);
> -	if (speed >= SPEED_1000)
> -		tmp |= MACCFG2_BYTE_MODE;
> -	else
> -		tmp |= MACCFG2_NIBBLE_MODE;
> -
>   	if (duplex == DUPLEX_FULL)
>   		tmp |= MACCFG2_FULL_DUPLEX;
> -
> +	else
> +		tmp &= ~MACCFG2_FULL_DUPLEX;

Did you test this when forcing 10/100 speed?

>   	iowrite32be(tmp, &regs->maccfg2);
>   
>   	mac_dev->update_speed(mac_dev, speed);

If so,

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
