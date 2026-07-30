Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A552B9B7;
	Thu, 30 Jul 2026 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395848; cv=none; b=IbkIuuoiKfuu1GxJmrJuId+iuSrOr+zZ+sCDZA0oTV00WSzDFeQuEOhO0fgZvKW+kmRSa+91ft9sCFQ9VhutpipF+Y9Y/2jg6q35l0US1/Rixw4CUQlPqBK3tHX2KlkO2pkuaEtEw71iK7cpbYnTeq7ZDukqYDSalunu+Pai8yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395848; c=relaxed/simple;
	bh=xYRuyCw+sZaHb6fF6gw0XCuwMjdAkENggsGxsYPic88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIxGrF9n3AFqylOIhihKkkKWceDMwOfNmkG4pKD4eYNk7ZAh/a5a6uOmz16iP1zSFxQLuWCKaJRTcY+QZKOIcRmqWTHpM9SkgHyBQSV6BWBejePVbmgiZuvT4qkIrKhWRgSO+t5Br2Qvim7d8uLGv80KRfGupe7gwf/24KReDyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qvBTU4Ug; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qvBTU4Ug"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6EB3B4E41000;
	Thu, 30 Jul 2026 07:17:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F5D9602B8;
	Thu, 30 Jul 2026 07:17:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4CCB511C15761;
	Thu, 30 Jul 2026 09:17:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785395835; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=3H6MWK6GwyDeXeOh9tGK2U19UW/15BQhpRWg3MHlJEI=;
	b=qvBTU4UgiJERlymmlQTYl2oKQFff1y6cSPjY4Im1uWQm4Sqm5IGQjyP2HYoq+190piGqib
	CUll1NMoV7VRPpQdXp9Et998bquRUIrxsZx51WMRPKQ00AjYZRy0PJJa3xhWA2J1gcJJrV
	UtH9+vCGVyD4IyPPveHs9JrMRqV1Nyp5t0Tu95xhJsYEdV2GXO3bUIYHNQCdUHm9Oo51Tr
	M3VokwPpJ4O5V4hwcKsyQVsCT9FqffbrI9IZ08Nzto1LJxRikgn8MWOXPTSM09EtT46x30
	2l8ioYFCQbcXGu7IgWSqqos2+JHDe3JByWUQEMCZTcZbtnIdqf6UJcNp7kmecg==
Message-ID: <d0f6d828-1c73-42af-aac6-e48330b77dea@bootlin.com>
Date: Thu, 30 Jul 2026 09:17:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: Select sleep pin state after suspending
 phylink
To: Fabio Estevam <festevam@gmail.com>, kuba@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 qiangqing.zhang@nxp.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, Clark Wang <xiaoning.wang@nxp.com>
References: <20260729224535.506598-1-festevam@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260729224535.506598-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/30/26 00:45, Fabio Estevam wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> When MAC Wake-on-LAN is disabled, stmmac_suspend() selects the sleep
> pinctrl state before calling phylink_suspend().
> 
> phylink_suspend() may access PHY registers over MDIO while stopping or
> reconfiguring the PHY. If selecting the sleep state muxes the MDC and
> MDIO pins away from the MDIO bus function, these accesses no longer work.
> 
> Select the sleep pin state only after phylink_suspend() has completed.
> 
> Keep the transition conditional on MAC Wake-on-LAN being disabled so
> that the pins remain active when the MAC must receive wake-up packets.
I think we need that fix, but it does raise even more questions:

How about when the PHY handles WoL ? We may have to access it early at wakeup,
possibly even before the MAC has woken up and restored the pinmux for mdio ?

The mdio bus may be shared with other PHYs as well, they may race on suspend
as well if the stmmac instance that drives MDIO quiesces before the other MAC
that needs the other PHY ?

All in all the question is, should we instead deal with MDIO muxing independently
of MII muxing, especially for suspend/resume ?

Maxime

> 
> Fixes: 90702dcd19c0 ("net: stmmac: fix MAC not working when system resume back with WoL active")
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> [fabio: Reworded subject/commit log for clarity and made it priv->wolopts conditional]
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Based on the NXP kernel fix:
> 
> https://github.com/nxp-imx/linux-imx/commit/7905fa71ed07d8c2f1da88ad9fffd5ac5e89461f
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 0de4bc949913..36ab66ad80fd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -8183,13 +8183,15 @@ int stmmac_suspend(struct device *dev)
>  		priv->irq_wake = 1;
>  	} else {
>  		stmmac_mac_set(priv, priv->ioaddr, false);
> -		pinctrl_pm_select_sleep_state(priv->device);
>  	}
>  
>  	mutex_unlock(&priv->lock);
>  
>  	rtnl_lock();
>  	phylink_suspend(priv->phylink, !!priv->wolopts);
> +
> +	if (!priv->wolopts)
> +		pinctrl_pm_select_sleep_state(priv->device);
>  	rtnl_unlock();
>  
>  	if (stmmac_fpe_supported(priv))

