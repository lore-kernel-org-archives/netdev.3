Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D519644B;
	Mon,  7 Sep 2026 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788798779; cv=none; b=QnrI98NKx2nxm8YX2CTbsdY8wUEFnpK0pBM+RXg2d/9Lkz3JWc+8hAWwbiqn8eG3ZbTOA1X3Dlivss2Pt4M04iqT9sFiqjQlglM4aYXv2Cq35mDNzOLA4EWtH/oEdHhgiA6xcsRk+eDucEN8foTP4P4P7pQO6+S3f9Ie8EAHuv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788798779; c=relaxed/simple;
	bh=BHT8Wc03cnUWoLCX1e0WfFYeTgcYzoQ4uNeyKpQkihw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dei1KDYW9E55MsR6Prh9bA3XmCTEREHpJDa/R5BaPbVoIKoDIyHvqBam0meg0yV1GB7CxIJfL2HVsKHIwBGcPujzk6ZIXAoro0DKhyJ/QOedKuFmlWhcxcig4LoOgTE9+WAhmdQfpsph/PtnAZG9AfBhnzht84t94lK2HBOuwcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rRLPgous; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rRLPgous"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A69A04E4156A;
	Mon,  7 Sep 2026 16:32:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 73EA760383;
	Mon,  7 Sep 2026 16:32:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A96111C79FF1;
	Mon,  7 Sep 2026 18:32:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788798775; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=LstbHmBty27bd+ICaS4If/ye13mygj2wBDsVWpIRiAE=;
	b=rRLPgousuuA9QNPrtiTfwUuvo+WoW4iabQtkuiSF5ufndSkDGXM/6RuBTRNZOqAWWvIwmL
	C2okzfUS6k27heDOwqmgt+v4p/kA4UHkO/mgPZiC0XpTsU7ZtnvfodeDWbNTZzyUjiNWfE
	OMadqYngpinDVKQGLiNTt6OCTN0ThKkKmVwsCn0vizlJROf3jK6mQmnawbEpw7Q6oFggkF
	OedIw3Z6LbygVK4wZ/cST7GKEm5hOzJ+hdC/dGgL+tQBapkcpd7vl15YPmU7R+xftFHDty
	zZJrB8aaKkbE3zqbq1r/vnVXb/b0A++N6+pe/DiOAY5E6pWcaDkJ6KTgYaXcaQ==
Message-ID: <0837f9fd-8cf7-475a-9011-b82d3e59acf0@bootlin.com>
Date: Mon, 7 Sep 2026 18:32:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net: dsa: mxl-gsw1xx: set SerDes NCO rate before
 SGMII reset
To: "Jan Havran (Advantech Czech)" <havran.jan@email.cz>,
 Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260907134818.16670-1-havran.jan@email.cz>
 <20260907134818.16670-2-havran.jan@email.cz>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260907134818.16670-2-havran.jan@email.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/7/26 15:48, Jan Havran (Advantech Czech) wrote:
> gsw1xx_pcs_config() releases the SGMII shell from reset via
> gsw1xx_pcs_reset() and only afterwards programs NCO_CTRL to select the
> SerDes clock rate (1G NCO1 vs 2.5G NCO2). The chip boot loader uses the
> other order: NCO_CTRL -> RST_REQ -> SGMII_PHY_HWBU_CTRL (GSW145 data
> sheet, section 3.2.8, table 13).
> 
> Program NCO_CTRL before gsw1xx_pcs_reset() to follow that order. On an
> Armada 7040 board driving a GSW145 whose switch comes up at 2.5G (pin strap
> PS_SUBTYPE_MD[2] = 1, pin LED42 / PS1 bit 14; GSW145 data sheet tables 23
> and 25), a 1 Gbps SGMII link only carried traffic with this change. It
> matters when the rate the switch is left at - by the straps or by the boot
> loader - differs from the rate the driver selects, which is likely why it
> has not been seen before.
> 
> Fixes: 22335939ec90 ("net: dsa: add driver for MaxLinear GSW1xx switch family")
> Signed-off-by: Jan Havran (Advantech Czech) <havran.jan@email.cz>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/dsa/lantiq/mxl-gsw1xx.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> index a1104b2f92a92..b8d8fefaa3a15 100644
> --- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> +++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
> @@ -352,8 +352,22 @@ static int gsw1xx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  	/* mark PCS configuration as incomplete */
>  	priv->tbi_interface = PHY_INTERFACE_MODE_NA;
>  
> -	if (!reconf)
> +	if (!reconf) {
> +		/* setup SerDes clock speed */
> +		if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +			nco_ctrl = GSW1XX_SGMII_2G5 | GSW1XX_SGMII_2G5_NCO2;
> +		else
> +			nco_ctrl = GSW1XX_SGMII_1G | GSW1XX_SGMII_1G_NCO1;
> +
> +		ret = regmap_update_bits(priv->clk, GSW1XX_CLK_NCO_CTRL,
> +					 GSW1XX_SGMII_HSP_MASK |
> +					 GSW1XX_SGMII_SEL,
> +					 nco_ctrl);
> +		if (ret)
> +			return ret;
> +
>  		ret = gsw1xx_pcs_reset(priv, interface);
> +	}
>  
>  	if (ret)
>  		return ret;
> @@ -423,19 +437,6 @@ static int gsw1xx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  		return ret;
>  
>  	if (!reconf) {
> -		/* setup SerDes clock speed */
> -		if (interface == PHY_INTERFACE_MODE_2500BASEX)
> -			nco_ctrl = GSW1XX_SGMII_2G5 | GSW1XX_SGMII_2G5_NCO2;
> -		else
> -			nco_ctrl = GSW1XX_SGMII_1G | GSW1XX_SGMII_1G_NCO1;
> -
> -		ret = regmap_update_bits(priv->clk, GSW1XX_CLK_NCO_CTRL,
> -					 GSW1XX_SGMII_HSP_MASK |
> -					 GSW1XX_SGMII_SEL,
> -					 nco_ctrl);
> -		if (ret)
> -			return ret;
> -
>  		ret = gsw1xx_pcs_phy_xaui_write(priv, 0x30, 0x80);
>  		if (ret)
>  			return ret;

