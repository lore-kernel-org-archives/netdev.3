Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EBE428830
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788246535; cv=none; b=LkZWa5gX7m0gyx0uZYSgIGu+0ZjEyZbdOhXmqiD9iuhmfOyxu1Zs9xfPNtPS3Fcqo63r9qjSeseqTlhHUC4winJUiGmwzjQbfzDSwxRwH2Z+d0T0ZdIeplOcyRzX0K1beTyo6WBjsmzh8Kkf4hF2PeqOT1CmProzuCx32tScgoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788246535; c=relaxed/simple;
	bh=cXOOdu5gyc3GvyUZ6WV3Y4FynavNF/PeQCi+e0HTUhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CT4CWKCJWh1CIz7TRDdQUlKWUlBAh5QkPjQuVy0blwr5WXCgGJMUhHkWXUhBemIf6Ofwu/UE0yX21kKKlCZCiBkQrs2nVyE+9oQYeOcQWf/HzV+tRzzP3cf6vRDjUIzgddXCbeb0WGLJ+wPukq71PoghOUIfUVEhjeMbq24DDxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BIfSUuJz; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BIfSUuJz"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 342184E4148E;
	Tue,  1 Sep 2026 07:08:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 015EC6053C;
	Tue,  1 Sep 2026 07:08:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 407B511C78A73;
	Tue,  1 Sep 2026 09:08:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788246522; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=q9fGXpZ9LF56jBhwOwvOI4LVfnaQEfa6lGW0ji++kNY=;
	b=BIfSUuJztHjVFi3sSWYu8XLIB6EszsN8BHv4rXOpS5qv474oVCjpFiykzNkWnshFqGoChM
	/+fv7z6cqiEYfdFYHImf4lOrj8jO8cDL40b6bhedr31TqgkihR9bTNwLt4pyOarE5tsKWw
	6jGCti+rzHg6rdOgWOyts0sg9ZQGUFQ9pT1Tpy93lE9xUU/8ldtUnWy50cQ7IlUh0BoQXx
	qyAY6U2tcLucr/reFqvfmkDy75BGlaNSTVg+kHiGBz/KHW9TTfwQXuGXphafW8vuheXMgt
	XMNvtLMXIMpeQpASwkBQoJRdVZtIxUDKyAEC/SmbEMRmzYy0s33NySHo2Lg+tw==
Message-ID: <d4f9378d-36a1-4669-b0b3-9dcb9e3d980a@bootlin.com>
Date: Tue, 1 Sep 2026 09:08:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: stmmac: dwmac4: Read the UC filter size
 from hardware capabilities
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>, thomas.petazzoni@bootlin.com,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260831070121.349778-1-maxime.chevallier@bootlin.com>
 <20260831070121.349778-2-maxime.chevallier@bootlin.com>
 <2631c832d5aebc56e152628132494545@tipi-net.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <2631c832d5aebc56e152628132494545@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi again Nicolai,

On 8/31/26 14:04, Nicolai Buchwitz wrote:
> Hi Maxime
> 
> On 31.8.2026 09:01, Maxime Chevallier wrote:
>> dwmac4 has multiple banks of perfect filter entries, independently
>> configurable during IP integration.
>>
>> The multi_addr bank reports a number between 0 and 31 corresponding to
>> the actual number of entries in that bank, while the 32 and 64 banks
>> are all-or-nothing.
>>
>> Expose these caps over debugfs as well.
>>
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>> ---
> 
>> [...]
> 
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
>> index 6382836828ba..89368e34a388 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
>> @@ -176,7 +176,9 @@ enum power_event {
>>
>>  /* MAC HW features0 bitmap */
>>  #define GMAC_HW_FEAT_SAVLANINS        BIT(27)
>> -#define GMAC_HW_FEAT_ADDMAC        BIT(18)
>> +#define GMAC_HW_FEAT_MACADR64SEL    BIT(24)
>> +#define GMAC_HW_FEAT_MACADR32SEL    BIT(23)
>> +#define GMAC_HW_FEAT_ADDMAC        GENMASK(22, 18)
>>  #define GMAC_HW_FEAT_RXCOESEL        BIT(16)
>>  #define GMAC_HW_FEAT_TXCOSEL        BIT(14)
>>  #define GMAC_HW_FEAT_EEESEL        BIT(13)
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
>> index 23ffe1adcd0d..14ac3f0e51f7 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
>> @@ -388,6 +388,8 @@ static int dwmac4_get_hw_feature(void __iomem *ioaddr,
>>      dma_cap->half_duplex = (hw_cap & GMAC_HW_FEAT_HDSEL) >> 2;
>>      dma_cap->vlhash = (hw_cap & GMAC_HW_FEAT_VLHASH) >> 4;
>>      dma_cap->multi_addr = (hw_cap & GMAC_HW_FEAT_ADDMAC) >> 18;
> 
> Now that ADDMAC has grown from single bit to a mask, the hardcoded 18 has to match
> dwmac4.h. So IMHO it would make sense to use FIELD_GET() here (like actphyif)?
> 
>> +    dma_cap->additional_32_addr = (hw_cap & GMAC_HW_FEAT_MACADR32SEL) >> 23;
>> +    dma_cap->additional_64_addr = (hw_cap & GMAC_HW_FEAT_MACADR64SEL) >> 24;
>>      dma_cap->pcs = (hw_cap & GMAC_HW_FEAT_PCSSEL) >> 3;
>>      dma_cap->sma_mdio = (hw_cap & GMAC_HW_FEAT_SMASEL) >> 5;
>>      dma_cap->pmt_remote_wake_up = (hw_cap & GMAC_HW_FEAT_RWKSEL) >> 6;
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index f2fc89176654..a885f8cfef21 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -6580,6 +6580,18 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
>>          seq_printf(seq,
>>                 "\tNumber of Additional MAC address registers: %d\n",
>>                 priv->dma_cap.multi_addr);
>> +    } else if (priv->plat->core_type == DWMAC_CORE_GMAC4) {
>> +        seq_printf(seq,
>> +               "\tNumber of MAC address registers (1-31): %d\n",
>> +               priv->dma_cap.multi_addr);
>> +        seq_printf(seq,
>> +               "\tAdditional 32 MAC address registers (32-63): %s\n",
>> +               priv->dma_cap.additional_32_addr ? "Y" : "N");
>> +        seq_printf(seq,
>> +               "\tAdditional 64 MAC address registers (64-127): %s\n",
>> +               priv->dma_cap.additional_64_addr ? "Y" : "N");
>> +        seq_printf(seq, "\tHash Filter: %s\n",
>> +               (priv->dma_cap.hash_filter) ? "Y" : "N");
> 
> hash_filter seems to be only set in dwmac1000_dma.c? So on dwmac4 it would always print N?

I stand corrected actually, after looking deeper, you're right :)

On dwmac1000, the feature bit 4 is HASHSEL, whereas on dwmac4, bit4 of HW_Features0 is
VLHASH, 2 different Hash tables :)

dwmac4 doesn't seem to have a bit just to say "there's a hash table", but instead directly
reports the sizeof of the hash table.

So I'll ditch that as you recommend, maybe in its own patch.

Maxime

