Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9638D3ED;
	Sat, 19 Sep 2026 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850714; cv=none; b=srAuUDvM3PNOPRkBDT1rGU7ytS1JV61dFk8i+alqnpTk0C6xEVEW9bVt88hlTVyaUiDfsnbRpV7LFhnGJo9qZKAoHymasGH51ICoR59G2F6+E7tNu1qnpEVZr5ZHWQ1wZRwNQ0SCwvMHv/V/NgzEo23O4iv5wVsisUVGXuDwoIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850714; c=relaxed/simple;
	bh=bkVSBssyKDQPsLkjNwmK2HUH36/oKB9tOVZk+FTbg10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAF3AiU3M6jG4SV3j/ibZCsqadmcwzJ4Klva2ut7ysH6HWYKcXmi0exvSfO5XWJ1Qlk7eT0Db2JAmSONDGueEd/RJTBvVVuEVdOlYZyvNR067zggtoT0r73jTPdzj6McBEfQwuzZJt1eFtQVw9mlKnDVFU8+2+vcBiWMB2+xbKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ijUdkmj7; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ijUdkmj7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 13298C51463;
	Sat, 19 Sep 2026 20:45:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 81DFD606CA;
	Sat, 19 Sep 2026 20:45:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5CF410328D5B;
	Sat, 19 Sep 2026 22:45:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789850706; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+8cETlr2q3PyJ3g9Jr0Py+3JGqk7+/bLEsejFMbYS4E=;
	b=ijUdkmj7VNvlxYbA3WVTHJY/7SdGCalNBcu7HIyXxCiRBe7vE2Z67CPyT/4UYskHTrcRaf
	OTgkg/aDFO0FsMm8ndO1Kb6TnMHAo8dDYPe0gQOIatFJ8epID1ATAkYTWI5YEXLue2stex
	2YcTJfg1qFNCiZT2q9zDQAoDaDYovtp4SInkogEKNonlIHoV59cow/FmscsUWfDgeRWe0K
	zAKZVRTweuAW5ljAmAFC4nZIKh7GhQ8FSE1lC53EwEqoCiyQ2eZEAVJ1koRFLtzpLwTeSE
	mmCV3jEAvaU//AqMoJimj4v8ZlXyGmcMJrPqth1vJ7kqImrgUCH2hH8yVGjQLA==
Message-ID: <00953149-df16-4d60-b180-2a80ba49e518@bootlin.com>
Date: Sat, 19 Sep 2026 22:44:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: stmmac: dwmac-rk: fix bulk clock leak
 when the PHY clock fails
To: Coia Prant <coiaprant@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260919174223.2356964-1-coiaprant@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260919174223.2356964-1-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi;

On 9/19/26 19:42, Coia Prant wrote:
> gmac_clk_enable() enables the bulk clocks first and then the optional
> PHY clock. If clk_prepare_enable() on the PHY clock fails, the function
> returns without rolling back the bulk clocks, and bsp_priv->clk_enabled
> stays false, so the later gmac_clk_enable(bsp_priv, false) becomes a
> no-op and the bulk clock references are leaked.
> 
> Add the missing clk_bulk_disable_unprepare() on that failure path.
> 
> Fixes: ea449f7fa0bf ("net: ethernet: stmmac: dwmac-rk: rework optional clock handling")
> Signed-off-by: Coia Prant <coiaprant@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thank you,

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 8d7042e689261..f3a98bd9d6ead 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1163,7 +1163,10 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
>  
>  			ret = clk_prepare_enable(bsp_priv->clk_phy);
>  			if (ret)
> +				clk_bulk_disable_unprepare(bsp_priv->num_clks,
> +							   bsp_priv->clks);
>  				return ret;
> +			}
>  
>  			rk_configure_io_clksel(bsp_priv);
>  			rk_ungate_rmii_clock(bsp_priv);

