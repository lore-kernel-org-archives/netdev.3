Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A1C395AF5;
	Tue, 12 May 2026 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591844; cv=none; b=Ch9XAWJHKcA1fVHEbqeGIfgaq4VDswSmLA0r/rodGm5yctTuqfyi9AZJG4JCyAVNthAREKNPr15s8XThxqESvUtn1sZasKDwkr0MTo2XPQsOs02QByzRVM52Rla2sAzDNsjleKFOkrAmsfsod/wgMk0ApxDJKs5Nye99vyvDIN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591844; c=relaxed/simple;
	bh=yKWShTkBi3bkltNiNY0m88AP3yUHt5rp8Xd8MvD9szQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpbNYr1mnLkc/nkvCl1VZMPr8cS+7GnkIaGnhxNuyIV1Y9Z1pUe1FOUirHqN4oUVNxqVO1j+IZqa5wGOgIGB2hL1y47kEWgv7F1i2EHW9+ILhTAVn9v/YHEUx8g3hcymx1KT1tdsXcIWisNjC7TOIyLKysUK3NDwTifB9iRo3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BbnnF9YN; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BbnnF9YN"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 429624E42BD3;
	Tue, 12 May 2026 13:17:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 152C160646;
	Tue, 12 May 2026 13:17:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2133511AF8CDC;
	Tue, 12 May 2026 15:17:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778591839; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=JoIymb14dgKFqmfOyS/oXw7DTEFjh2lp1/RCan2xs0E=;
	b=BbnnF9YNJc53JGbF7vIZ9ZRUz8EwmToMLKvNeqc/kE8hPvfz3iwdmEct3P3UK5otwLOyjT
	p6+yraBmiqEN4kCWikHKDvMaduAij07UmZ9nGtm1fTlF1DvTRskqVQ1kXWc7A/lzfjUuoG
	M+N20Iv/zlqzuavbe6fwa+9JJSKDvr+FilE4Yfi4/yJ68KRCXmyjuT4NePVfBh03xDalMJ
	v06rhqeF07qSwcSIXyx0K1+SGCThRlIeqPdC3IPYfZE7HpC2/E9ewueOZuXiQTlVGU2jwa
	T49cE++64G203cDoFG5iGkZTg+GbfOChLA2Ev51+LrPd69h+UgoYqPK/MBBkMQ==
Message-ID: <5680b248-81bd-4a8e-9682-9d6d133c6e1a@bootlin.com>
Date: Tue, 12 May 2026 15:17:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v3 1/3] net: phy: motorcomm: move mdio lock out from
 yt8531_set_ds()
To: Minda Chen <minda.chen@starfivetech.com>, Frank
 <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260508094522.3952-1-minda.chen@starfivetech.com>
 <20260508094522.3952-2-minda.chen@starfivetech.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260508094522.3952-2-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 5/8/26 11:45, Minda Chen wrote:
> yt8531_set_ds() default set register with mdio lock and only called
> with YT8531 PHY. But new type YT8531s support RGMII and has the same
> pin strength setting with YT8531, YT8531s need to call yt8531_set_ds()
> setting pin drive strength. But YT8531s config init function
> yt8521_config_init() already get the mdio lock with phy_select_page().
> If calling yt8521_config_init() with mdio lock will cause dead lock.
> 
> Need to get the lock before calling yt8531_get_ds() and move mdio
> lock out from it for YT8531s.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>   drivers/net/phy/motorcomm.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 4d62f7b36212..c66804537aa2 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -974,7 +974,8 @@ static u32 yt8531_get_ldo_vol(struct phy_device *phydev)
>   {
>   	u32 val;
>   
> -	val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
> +	val = ytphy_read_ext(phydev, YT8521_CHIP_CONFIG_REG);
> +
>   	val = FIELD_GET(YT8531_RGMII_LDO_VOL_MASK, val);
>   
>   	return val <= YT8531_LDO_VOL_1V8 ? val : YT8531_LDO_VOL_1V8;
> @@ -1010,10 +1011,11 @@ static int yt8531_set_ds(struct phy_device *phydev)
>   		ds = YT8531_RGMII_RX_DS_DEFAULT;
>   	}
>   
> -	ret = ytphy_modify_ext_with_lock(phydev,
> -					 YTPHY_PAD_DRIVE_STRENGTH_REG,
> -					 YT8531_RGMII_RXC_DS_MASK,
> -					 FIELD_PREP(YT8531_RGMII_RXC_DS_MASK, ds));
> +	ret = ytphy_modify_ext(phydev,
> +			       YTPHY_PAD_DRIVE_STRENGTH_REG,
> +			       YT8531_RGMII_RXC_DS_MASK,
> +			       FIELD_PREP(YT8531_RGMII_RXC_DS_MASK, ds));
> +
>   	if (ret < 0)
>   		return ret;
>   
> @@ -1033,10 +1035,11 @@ static int yt8531_set_ds(struct phy_device *phydev)
>   	ds_field_low = FIELD_GET(GENMASK(1, 0), ds);
>   	ds_field_low = FIELD_PREP(YT8531_RGMII_RXD_DS_LOW_MASK, ds_field_low);
>   
> -	ret = ytphy_modify_ext_with_lock(phydev,
> -					 YTPHY_PAD_DRIVE_STRENGTH_REG,
> -					 YT8531_RGMII_RXD_DS_LOW_MASK | YT8531_RGMII_RXD_DS_HI_MASK,
> -					 ds_field_low | ds_field_hi);
> +	ret = ytphy_modify_ext(phydev,
> +			       YTPHY_PAD_DRIVE_STRENGTH_REG,
> +			       YT8531_RGMII_RXD_DS_LOW_MASK | YT8531_RGMII_RXD_DS_HI_MASK,
> +			       ds_field_low | ds_field_hi);
> +
>   	if (ret < 0)
>   		return ret;
>   
> @@ -1826,7 +1829,9 @@ static int yt8531_config_init(struct phy_device *phydev)
>   			return ret;
>   	}
>   
> +	phy_lock_mdio_bus(phydev);
>   	ret = yt8531_set_ds(phydev);
> +	phy_unlock_mdio_bus(phydev);
>   	if (ret < 0)
>   		return ret;
>   

