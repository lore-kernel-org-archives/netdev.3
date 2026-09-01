Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1DE4CCDC5;
	Tue,  1 Sep 2026 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265677; cv=none; b=stM5fpfkjf35/NbxO7cMVYgA8FRYCVz+iImUVS9lVIJpjYVkl6TOclZJ2P/nmHXbJPDhAyWMYlKcHCR2GUA3qPOHUftfE1+WNh+6CZetSdAf1XU+1IW24svf4Al3PFL5eKLyLkliBkmWgcw8xKR1BVCb6E7U/X/377gjyVRJs6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265677; c=relaxed/simple;
	bh=Bd4pFuQnFbnUKxip0ykfNL8TfT8t5yll/JcxRMTIcMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjz5OQ3Tbq/nZcCFTV7+og2tCcYID90w7otD6TuzMIa2AVTKiG87cin9OIZLQjANsnWqeCUX1SmRCJuo3hMmYpzVnPreMWCmSTzoK0j5Pe6392JZpCaU27UqArOIa29+sKUC12QDvKNvl81wF1pBJtJ2Gjz5ASLhcLn4l4xBWvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=v8//1kYr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="v8//1kYr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8DCE54E4146F;
	Tue,  1 Sep 2026 12:27:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 50B286053C;
	Tue,  1 Sep 2026 12:27:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A52211C7926B;
	Tue,  1 Sep 2026 14:27:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788265667; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Xr51EjeNPpVhvkrX+j2KA7sh6coRP73TE02mljTkxnU=;
	b=v8//1kYrmgBcaY6YVc8sDaF69kyfH4N9WEwUhY/Wo+1HXLtYKSqrB/9+Ul2nYL6KKpt6US
	fqBzJ7WqTU6KPYB0g1slSVgS40NG95FD3gwRQ3bwEAkBTEEZNfbcRrebLA06ZQ0F4HKtYN
	wyyfMqyHwBUkRkHy3hGPoAZ/nxie3rleG+4aWVVKu2QValCJHKxS6fH5GaSTqjY8KLYM/x
	Y43ew5raxQ16WVeXs4YqhJCeqhC/csYuDmno1pUkctQX6eyuLUn37plP1UL45LiUuqcSu3
	ATy7I2LgRdyL+SAL/FJi8RPAcw6nljrXCAS4tW5u3cttrHARFq/KUnsEkKr32A==
Message-ID: <6f395b75-d5ed-4536-9f9b-9de2f56dd9fb@bootlin.com>
Date: Tue, 1 Sep 2026 14:27:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac4: Use the full perfect
 filter ability for UC filter
To: Andrew Lunn <andrew@lunn.ch>
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
 <20260831070121.349778-3-maxime.chevallier@bootlin.com>
 <285c8969-2f0d-46de-b098-60ff10f30cf6@lunn.ch>
 <493afde2-8603-41e8-b6ce-f8e399c53275@bootlin.com>
 <c7819431-d33d-4e9c-ab36-be55b94d29f4@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <c7819431-d33d-4e9c-ab36-be55b94d29f4@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/1/26 14:21, Andrew Lunn wrote:
> On Tue, Sep 01, 2026 at 08:37:20AM +0200, Maxime Chevallier wrote:
>> Hi,
>>
>> On 9/1/26 02:12, Andrew Lunn wrote:
>>> On Mon, Aug 31, 2026 at 09:01:20AM +0200, Maxime Chevallier wrote:
>>>> Contrary to dwmac1000 that gets its number of perfect filter entries
>>>> through the 'snps,perfect-filter-entries' property, dwmac4 allows
>>>> reading the filter size from the HW features registers.
>>>
>>> Does dwmac4 take any notice of "snps,perfect-filter-entries"? Should
>>> it be marked deprecated?
>>
>> It's only used on :
>>
>>   "st,spear600-gmac"
>>   "snps,dwmac-3.50a"
>>   "snps,dwmac-3.70a"
>>   "snps,dwmac-3.72a"
>>   "snps,dwmac"
>>
>> So, dwmac1000.
>>
>> I'd say, we can definitely deprecate on IPs that don't match these.
>>
>> Interestingly, there are _some_ dwmac4 devicetrees out there that use
>> this property. It achieves nothing, and even worse, doesn't match what
>> the HW reports :
>>
>> In arch/riscv/boot/dts/starfive/jh7110.dtsi for example :
>>
>> gmac1: ethernet@16040000 {                                            
>> 	compatible = "starfive,jh7110-dwmac", "snps,dwmac-5.20";
>> 	[...]
>> 	snps,perfect-filter-entries = <256>;
>> }
> 
> So another thing for the TODO list, extend the YAML description to
> make properties conditional on the IP core version, so the validator
> tools will pick this up.

Looks like it yes. I'm starting to wonder if we should  maintain this kind
 of TODO list in the kdoc. I know these types of lists have a nasty
tendancy of falling into disrepair, but this could help.

Maxime

> 
> 	Andrew

