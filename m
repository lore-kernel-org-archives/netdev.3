Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69B1D5CFE;
	Mon,  3 Aug 2026 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788866; cv=none; b=XSHldBSkEMj+f0nVgNwsWlTWE61uyxaWuvcXdOryZlKHpmXIoB8utb5KnWf4F7SEFdb7aXmQeu/pj9jwc7PyZiW2h4dsh0rUomVDQGPv04Y3f+c7ho1PnypRgN8JQMzZ9kPRc/POFwtAJMZe/gaqnIxDKTiJj5l6dEYikbl6gRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788866; c=relaxed/simple;
	bh=zC6MKzB4E20ZLrhXIF3++GhMSEHc6QspUW/bHQ3992s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tg2gnuzer6LNlCkhh87NtsAYtivTzmfYGMFrqy4xQ3abDVkqUIyUlb0AHdsCYXDO6B+lxg4xgatMJ00ZS2PKfWv8NO82pWYpaYqUkWIFAUfKwGeZZVZ2o2ktcUi9DHZ3ZRztQVkh27HnQUA+ZwmGkjX1SraRFYTCy1PPgolH5tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nOquFb8l; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nOquFb8l"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 814911A13E0;
	Mon,  3 Aug 2026 20:27:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4E6066029B;
	Mon,  3 Aug 2026 20:27:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC6FB11C31895;
	Mon,  3 Aug 2026 22:27:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785788857; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=BzrJkwrJfsf2rrodj1Wh/NjOkI2xIwXy72z2ZA+RwDE=;
	b=nOquFb8lsI+2DkBXVoUXBrPHiv8VeEDfnU9qRa9kdgYnLrJll52PYpxHkwCslubu3N+hCJ
	tWOGsLtMoq2V7p6nutpNrRqsHJCWU/UJ0eghwfOT8Wd+3Vgz6dbvMivgaYNHAhT6nU6YEA
	IsEdu64pL5LnCctzaq/WMLDzxCv+7bFSI8D8QOym5DAke7rjuMSQUR+XO96KpvpLtKois7
	OId2/u38wA72ZS9WBvaDaKV5Pr1yRl+r2s5yTgoMAG5pS5ATA9hLHk7teTaZHEPlloL9p9
	1f+7CaAjx9rUoUnSFex/snQlTcAzN+6B4ak2RpdqfXSYIBQJqW+xlJuF+lo2Nw==
Message-ID: <a12aaa08-d6d8-4710-a053-6eb06c7c62cb@bootlin.com>
Date: Mon, 3 Aug 2026 22:27:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: remove ptpaddr/mmcaddr/estaddr "safe"
 initialization
To: Jisheng Zhang <jszhang@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260803135745.12600-1-jszhang@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260803135745.12600-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Don't forget to put the tree name in the subject please :

https://docs.kernel.org/process/maintainer-netdev.html

That one's for net-next, thanks for the cleanup

On 8/3/26 15:57, Jisheng Zhang wrote:
> These so called "safe" initializations aren't needed any more from
> sometime, but the unnecessaries are obvious after recent clean up
> by Russell. The code will correctly initialize them after getting
> the correct stmmac_hwif_entry by calling stmmac_hwif_find().
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/hwif.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> index 511b0fd5e834..265671170bf6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -328,18 +328,6 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
>  	/* Save ID for later use */
>  	priv->synopsys_id = version.snpsver;
>  
> -	/* Lets assume some safe values first */
> -	if (core_type == DWMAC_CORE_GMAC4) {
> -		priv->ptpaddr = priv->ioaddr + PTP_GMAC4_OFFSET;
> -		priv->mmcaddr = priv->ioaddr + MMC_GMAC4_OFFSET;
> -		priv->estaddr = priv->ioaddr + EST_GMAC4_OFFSET;
> -	} else {
> -		priv->ptpaddr = priv->ioaddr + PTP_GMAC3_X_OFFSET;
> -		priv->mmcaddr = priv->ioaddr + MMC_GMAC3_X_OFFSET;
> -		if (core_type == DWMAC_CORE_XGMAC)
> -			priv->estaddr = priv->ioaddr + EST_XGMAC_OFFSET;
> -	}
> -
>  	mac = devm_kzalloc(priv->device, sizeof(*mac), GFP_KERNEL);
>  	if (!mac)
>  		return -ENOMEM;

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime
