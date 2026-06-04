Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE08223707
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 07:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557871; cv=none; b=hj3qIrBy1E/nIgVcUqRu0e1Xgcmcg9sWsefpjO1/sn1mq8uiUBDzb/EVJ6/LoB2dKxojgb8ZAXOH8YSXTfXEWa+44GCJXcFElI0fKy5CmBGf8nUbKPj5XnxQulXDX/tsjsK2o90KPEZA1seNpEjPDiZmWcrpaC0+aWKTgBbd7mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557871; c=relaxed/simple;
	bh=kF8Vlmf1/LFEckQpZufc3SC/K+2W4M/X0bIp7WOBVCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCgFCnVLC+aV6+bgyzqzKkUjinGkL6hcEMiDcCRDG6VM8t6ykzr7goHLp7nsnhna3xCbvCesg6JZ7gd5nt+rrNhbq7pJek+2+ucQc9OW4QHPk6m9ohOXB6RsKpJPSJtwcMoesCAsKAyUKmH+DtYY3io1E579B7McWj8Xytptj8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ncFrbHrc; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ncFrbHrc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5D473C6344A
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 07:24:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3252E5FEF7;
	Thu,  4 Jun 2026 07:24:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 096F7106A1739;
	Thu,  4 Jun 2026 09:24:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780557866; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=B0MSZZu4FCZaVylYhNYqwOIj8dwu7s4P1sh+7TqmddQ=;
	b=ncFrbHrcOfy69cmMaIY9qfsIVplRb5/ou9Jowm/GbTLnSdHg50SXOFp6Aq/zpEZbbOfNeZ
	mbpfAIVI3hp3MEu/Vf7dctSrOjmrrGz51YPSslUXq/fGLh5ErD6hJpa1XleookCo8VltGM
	DZclim8KevAzRUttwGqsNOAPbHRqInSAAtIUqHvA74Hn3Z9Liy2lLJw3p2Ygz8h92bHkSX
	aisZkcZxtzgI8ieyl/lo4nh3JVRZ6yaxkOnPwsexXw1/HwWmViXG94fzHEcx+33g2yuyp1
	YZ5TyUNAr4jcWv5IoxaNgQwu+jnp8kRMbyVdx9QgfJAz/gOIVpItmWWnQqt8WQ==
Message-ID: <c7e6f722-fc58-4b6d-bdc8-613a9c0ac929@bootlin.com>
Date: Thu, 4 Jun 2026 09:24:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: dwmac4: Report DCB feature
 capability
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, o.rempel@pengutronix.de
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260603173644.24371-1-ovidiu.panait.rb@renesas.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260603173644.24371-1-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 6/3/26 19:36, Ovidiu Panait wrote:
> Bit 16 of the MAC HW Feature1 register reports the DCB (Data Centre
> Bridging) feature. Read it so that dma_cap.dcben and the debugfs
> report it accurately. Right now it is always reported as being disabled.
> 
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

This matches with what I have in the iMX8MP ref manual :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thank you,

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac4.h     | 1 +
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
> index ffcd036d4c02..6382836828ba 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
> @@ -198,6 +198,7 @@ enum power_event {
>  #define GMAC_HW_FEAT_AVSEL		BIT(20)
>  #define GMAC_HW_TSOEN			BIT(18)
>  #define GMAC_HW_FEAT_SPHEN		BIT(17)
> +#define GMAC_HW_FEAT_DCBEN		BIT(16)
>  #define GMAC_HW_ADDR64			GENMASK(15, 14)
>  #define GMAC_HW_TXFIFOSIZE		GENMASK(10, 6)
>  #define GMAC_HW_RXFIFOSIZE		GENMASK(4, 0)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> index 28728271fbc9..829a23bdad01 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> @@ -391,6 +391,7 @@ static int dwmac4_get_hw_feature(void __iomem *ioaddr,
>  	dma_cap->av = (hw_cap & GMAC_HW_FEAT_AVSEL) >> 20;
>  	dma_cap->tsoen = (hw_cap & GMAC_HW_TSOEN) >> 18;
>  	dma_cap->sphen = (hw_cap & GMAC_HW_FEAT_SPHEN) >> 17;
> +	dma_cap->dcben = (hw_cap & GMAC_HW_FEAT_DCBEN) >> 16;
>  
>  	dma_cap->addr64 = (hw_cap & GMAC_HW_ADDR64) >> 14;
>  	switch (dma_cap->addr64) {

