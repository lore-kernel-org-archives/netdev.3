Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B578E38A734;
	Sat,  5 Sep 2026 07:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788592592; cv=none; b=PjYr4Ck6/Iq5bmb7eQCpgApWSrvh3ELx/BrFeY0RIDND9xPXYkkF2qSVZPtZVKV2IXHY1hOkUdWM5ySlv9HQdPABpxw/MHEW0tL4hrBWXViQiNBzRJt/0rFwKAm9VtBzScI6WU0sNCEEz8no6NSnGcvpXr5qKwxvH2vjoFlYPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788592592; c=relaxed/simple;
	bh=E2Z5XEDCWcyBLtyczHnP6+X4+IDocqHd2V9+v7mlb0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4tC6EuscsHLfxt/wUaoZVs4YsPk04OJ1riwSwW/mnAtFJE7RcyQG1IoMCya8GP/UqwKxQGYeaDm0pBGN0uKGo6JK3RoDQp5WiF2Sm/QqG+M/aociTA9EUUoj3xB7xBbH4ACZc2O29vJO+HDktor2dBrxqOqpHYe3Du0Y2z2MIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mdxCrggv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mdxCrggv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B29FA4E41530;
	Sat,  5 Sep 2026 07:16:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E9E860580;
	Sat,  5 Sep 2026 07:16:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A54E511C787BD;
	Sat,  5 Sep 2026 09:16:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788592579; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=H8ZBz3umxxhqbNlNKwwRtIpUr3ROModBIAzMxPN9tJ4=;
	b=mdxCrggvFgOKR57ekJavFuca8kF/tZLdQVofV1pOlWkUdhy920vM1TTOJHl8jBzc/iOL5l
	mL+6R0aWf87hDbdMavHLnZVdWm+ILMgikU/zgNUQr8MHl1n00tcpVzXIpCXVJoHqnFgpx+
	xKozSahmSbVDuGeV5Y4s4muuDoc2jQfnPs2pV4yYiHLyr13jSLsGBrnS9k+kdrhkr/j4T+
	4vsBJe6hH2TJjJLzYqLcqkIxzwIotj1MlSEfJtVXsmWAiJyRV8iH/r6JS2FNehK+K8mCQO
	lX1ZLalhg56CS2J7Y0Z3L4mbk/j8B98YRbqspcDvMp3H87QT2g8mQZm4/5Gx3Q==
Message-ID: <84a2f232-06ed-4fa4-bcdd-4e72a792bf12@bootlin.com>
Date: Sat, 5 Sep 2026 09:16:09 +0200
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

Hi,

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

Managed to get some time to test that, the config does survive a suspend/resume
cycle, so sashiko's suspicion wasn't correct. The bit doesn't get cleared
after a resume.

I see the series was dropped from PW though, I'll add a few comments and details
in the commit log and resend.

Maxime

> 
> /P
> 

