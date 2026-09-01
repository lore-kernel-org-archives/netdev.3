Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED6F3AFD19
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272517; cv=none; b=fQzNpAySGKZawuGNihQ5Z8TH9CVwDxhm1kMZ+U37/u6d7uDye81P46hrxXhqlWDCvLLli8l+fbQhywaJCaYdjIpXL1HwcwaJSEs7fNZsI5MiISoIAsKk7hQy1m2pGzQkqSUUNhUy2lUgJwD+FzB2UhYMzmk4c+CH0m/3GBeHE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272517; c=relaxed/simple;
	bh=Cgmb/qFmvYmnyEKPGYAwZgQWqXO4pDib+3V1jvSRM4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5+p+MbxSm6IjsbYkAuQyODDRm85iN46PoOPgIQFFon9v00DNCYCrj0gPEY3cH0mI8BgWdZHKt80ipGrEHHZoQrx/d2D459hlbhe4YVjGqLk6Stikms3KaTuSQ089P87GRw4FEmflA1YmaeMEBceQHrN/NE2pF74c82VxNqAGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H2/4vuqC; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H2/4vuqC"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1151B4E41496;
	Tue,  1 Sep 2026 14:21:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D682E6053C;
	Tue,  1 Sep 2026 14:21:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B20F611C79234;
	Tue,  1 Sep 2026 16:21:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788272506; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=BlynNgY5zP68PI3zywr2W59oa9iEvK/XT6rpy4x8qgE=;
	b=H2/4vuqC5BV/8rBy8qIYdeXYUf+vcm1VOR/iXjm8IH96O/YVghje2GnNdxIk/Ni5lDF3ph
	J6L7CUQ65zzz+/Td49gkM+GNN9TyOuuRxRtNgXSynBLpfUSF2N4qBrmqRwCiBOcVdzLOpq
	ve9Nukk4bt1+4KZa/3uOLXZcL5D+YPsF/ud5XFlbgoRJ0e5qNe4n2pD8xWxG/TRqGukO6e
	xZjfqb2fyEswz6XZRIsTO+rvK8zYLNiXmUXSUDWdMX/n/Grju+kPAfQyrrzZLuUGl0ov3S
	1jcAWxE/x8nbnTZRNWVGhZT3QTvxQRdxkYx2AY2dgrfEH7NH6FBS9SNScWdsVg==
Message-ID: <3053bd10-50c0-4a4e-bfe3-7c2479bad560@bootlin.com>
Date: Tue, 1 Sep 2026 16:21:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: phy: motorcomm: Enable analog frontend
 on YT8531S
To: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, Yao Zi <me@ziyao.cc>,
 Frank <Frank.Sae@motor-comm.com>
Cc: thomas.petazzoni@bootlin.com, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260831073747.361482-1-maxime.chevallier@bootlin.com>
 <20260831073747.361482-4-maxime.chevallier@bootlin.com>
 <17e50070-46c9-46dd-8109-95007a4f681f@redhat.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <17e50070-46c9-46dd-8109-95007a4f681f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/1/26 15:59, Paolo Abeni wrote:
> On 8/31/26 9:37 AM, Maxime Chevallier wrote:
>> The YT6801 PCIe NIC includes the dwmac-motorcomm IP for the MAC part, as
>> well as a YT8531S PHY, configured in GMII mode.
>>
>> It seems this PHY requires the Analog Front-end (AFE) DAC clock to be
>> enabled for link to reliably establish, otherwise the link just doesn't
>> come up.
>>
>> Let's enable it at config_init().
>>
>> This logic has been extracted from the vendor driver provided by
>> Motorcomm.
>>
>> It's really unclear if this is specific to the integrated version of
>> that PHY, and how this potentially interacts with the fiber mode this
>> PHY supports, so this configuration is only enabled when the interface
>> is GMII, i.e. the PHY is integrated.
>>
>> With this, the PHY reliably establishes link and the YT6801 PCIe card
>> becomes fully functional.
>>
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>> ---
>>  drivers/net/phy/motorcomm.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
>> index 36c229460a77..90a4f86f2758 100644
>> --- a/drivers/net/phy/motorcomm.c
>> +++ b/drivers/net/phy/motorcomm.c
>> @@ -144,6 +144,11 @@
>>  #define YT8521_CLOCK_GATING_REG			0xC
>>  #define YT8521_CGR_RX_CLK_EN			BIT(12)
>>  
>> +/* Analog front-end control register 3 */
>> +#define YT8531S_EXT_AFE_CTRL3			0x12
>> +/* Analog front-end DAC clock enable */
>> +#define YT8531S_AFE_CTRL3_CLKDAC_AON		BIT(13)
>> +
>>  #define YT8521_EXTREG_SLEEP_CONTROL1_REG	0x27
>>  #define YT8521_ESC1R_SLEEP_SW			BIT(15)
>>  #define YT8521_ESC1R_PLLON_SLP			BIT(14)
>> @@ -1740,8 +1745,15 @@ static int yt8531s_config_init(struct phy_device *phydev)
>>  	if (ret)
>>  		goto err_restore_page;
>>  
>> -	if (phy_interface_is_rgmii(phydev))
>> +	if (phy_interface_is_rgmii(phydev)) {
>>  		ret = yt8531_set_ds(phydev);
>> +		if (ret)
>> +			goto err_restore_page;
>> +	}
>> +
>> +	if (phydev->interface == PHY_INTERFACE_MODE_GMII)
>> +		ret = ytphy_modify_ext(phydev, YT8531S_EXT_AFE_CTRL3,
>> +				       0, YT8531S_AFE_CTRL3_CLKDAC_AON);
> 
> Sashiko suspects this will not survive a suspend/resume:
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831073747.361482-1-maxime.chevallier%40bootlin.com

hmm sashiko may be right, worth adding right now as it seems there are
some discussions already on motorcomm suspend/resume issues, let me spin
a V2

Thanks !

Maxime

