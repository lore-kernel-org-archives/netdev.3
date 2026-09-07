Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E952DC765;
	Mon,  7 Sep 2026 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766150; cv=none; b=IrroisWkulC0adKL2+XYTI43JJuOT5wJfA9kg9gw97ZXmhwXyTZ+xvPWqHmh2TSn7DA1PsCHiDuXPMdDQY10IOW63rint+Vh3ppFxo3JmZ30bFd7sn9XGcuK1qBx+5PQHLEXPccz7KKHZVxs8excI8H9EXMqIzsbZ8VI78J1900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766150; c=relaxed/simple;
	bh=uDa6rYQmXTGgcYIJLVFNrSmufukAoyTcQnshhgvR3Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZn5DMvIKXk6vJXxi7tQWoixmM0vCxOECDRpEcnN51IjC6EdfUvK5AdOG99wT3VIKlv43EFIJaNAHFfaqf4Q2n65/Sc1jilLV3IT7EEVla/Ec5e+Rnuh1J/DdpafftHNK1mLTBW05vOJRQGd09JJegcx5EyiHrW02+WSdrD7r6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QZ9Cn0PW; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QZ9Cn0PW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 11BA41A1A1C;
	Mon,  7 Sep 2026 07:29:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D2B4660383;
	Mon,  7 Sep 2026 07:29:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8286A11C7A131;
	Mon,  7 Sep 2026 09:28:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788766140; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=aLz+YXhDXlEGNDvoI1Sa9xZvW1NLNKMWivo0ZPJIY08=;
	b=QZ9Cn0PWrljorCBOhiK1CJ1CZTrACqwecmjkSZL6aH++MTyIZx/YDEF5Vv9n6WLwIYfPQe
	7CBGnXgwfPsGyOCRBkxTvexerYSf7S41IzTaHKSeK5sdhB8p7J06iZXIelfhN6SvrJ6lV9
	sVEL7gy5QBOXFswDyJqBGrOsu8Ea9G6+nyIEaUtcgkOw8w2QEplRixDEYSuoCSHomNKP+h
	e8iIkLHNiwpi65LEYWLOvTowa3Fu7Taomx7mR0e9I/FtfT7w5FRoT+ZLHtg67qozO8l5cd
	H3LDIKWwkfOuhN9kQ/ULuqi6mX0pWa/nl+4NytM9Xsr95U0djysT9yOrU5spYQ==
Message-ID: <248c1a07-7a5c-44dc-a73e-f95a69bb4161@bootlin.com>
Date: Mon, 7 Sep 2026 09:28:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: stmmac: Add UltraRISC DP1000 GMAC
 support
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260901-dwmac-ultrarisc-v1-0-f19454814bcf@ultrarisc.com>
 <20260901-dwmac-ultrarisc-v1-3-f19454814bcf@ultrarisc.com>
 <910be156-b631-4b62-972a-79d9a9e38697@lunn.ch>
 <178842162417.2701756.3296149694160507506.b4-reply@b4>
 <1622b0a7-5516-4e72-b5e1-60c12b65b52e@lunn.ch>
 <8611dff3-56ea-4798-8303-b0a8af84580e@bootlin.com>
 <178850166577.1486454.10728134844652956076.b4-reply@b4>
 <178876008871.2542659.8460758662538260209.b4-reply@b4>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <178876008871.2542659.8460758662538260209.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/7/26 07:48, Jia Wang wrote:
> On 2026-09-04 14:01 +0800, Jia Wang wrote:
>> On 2026-09-03 14:30 +0200, Maxime Chevallier wrote:
>>>
>>>
>>> On 9/3/26 14:10, Andrew Lunn wrote:
>>>>>> This looks to be 90% identical to dwmac-sophgo.c.
>>>>>>
>>>>>> Do you expect any further changes to this driver? Is everything
>>>>>> supported? Are there more clocks? A GPIO for WoL?
>>>>>>
>>>>>> I'm just wondering if the common code should be pulled out, or even
>>>>>> dwmac-sophgo.c made generic so it can handle all plain boring devices
>>>>>> which have RGMII delays and not a lot else.
>>>>>>
>>>>>
>>>>> The probe boilerplate is indeed largely similar because both drivers
>>>>> use the common stmmac platform helpers. However, their platform-specific
>>>>> requirements differ: Sophgo requires additional TX clock handling and
>>>>> other configuration, while DP1000 requires fixed TX and RX delay
>>>>> handling. ACPI support under development is also intended to use the
>>>>> UltraRISC glue driver.
>>>>
>>>> ACPI is going to be fun, since nobody does ACPI networking.
>>>>
>>>> But how big is the change to the glue driver? I expect the change will
>>>> be minor, a call to devm_stmmac_probe_config_acpi(), in addition to
>>>> devm_stmmac_probe_config_dt(). Anything else?
>>>
>>> I agree that if ACPI support is added, let's try to make it part of the
>>> core.
>>>
>>
>> The ACPI support is still under development, but the current prototype
>> adds ACPI device matching and ACPI-specific platform-data setup. Some
>> common stmmac changes are also needed for ACPI-described platform
>> resources and MDIO.
>>
>>>>
>>>> One problem the stmmac driver has is cut/paste glue driver
>>>> development. The same code is repeated again and again. Russell King
>>>> spent a lot of time and effort trying to reduce the duplication. So we
>>>> should not be adding more duplicated code unless it is actually
>>>> required.
>>>
>>> It seems to me that all the RGMII handling could be made much more generic,
>>> as this is commong pattern in glue drivers :
>>>
>>> dwmac-sophgo has the "has_internal_rx_delay" field, and dwmac-eic7700 has
>>> both has_internal_[r|t]x_delay.
>>>
>>> With this third one, it makes sense to start sharing that logic across
>>> glues.
>>>
>>
>> I agree. DP1000 is another user of this pattern, with fixed internal
>> delays on both the TX and RX paths. I will look at moving this handling
>> into the common stmmac platform code, leaving each glue driver to
>> describe its internal delay capabilities.
>>
> 
> After looking further into the implementation, I see two possible
> approaches:
> 
> 1. Keep a minimal UltraRISC glue driver that only describes the fixed TX
> and RX delay capabilities, while the common stmmac code handles the PHY
> mode adjustment.
> 
> 2. Store these capabilities as compatible-specific match data in
> dwmac-generic and remove the UltraRISC glue driver entirely.
Let's go with 1 for now I'd say. UtraRISC will be the only one that's basically
an empty glue calling core code (maybe you have some plat->flags to passs ?).

If we manage to simplify even further (e.g. tx clock handling for exmaple), we could
also deal with dwmac-sophgo the same way. We could then consider something like
dwmac-simple.c , keeping dwmac-generic.c for the raw dwmac IPs.

Maxime
