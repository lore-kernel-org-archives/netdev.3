Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60092CCC5;
	Wed, 30 Sep 2026 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774878; cv=none; b=POncWzya+ew7tvD993h7MoGtdqqK/Q3lRAowjSuFIAhbY3xTMCj4DkwHOj3i9FS0XQJowEr/ekTFQsYBZBVHZbcRyuMprxWyhkN5AoGexDOpalE0025lcRwU4nVPntB211M5fKpg9z6QXXE/a1IMf3JlV9Cr6HLn1Tl9OYTxdj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774878; c=relaxed/simple;
	bh=vboSnGveW2ZsiMFFUD6YKj38UXVfjqeCSzoq0pw3aJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLTHzYd2PIJS6dqeteDm9XPT6Rv+CM4wn0ujLNtIEyYhjBEKfqqGAsgrswbAqr9hwcNf8eBnSuy59pc622C+FPTqya+5wUQbP0Jnq/SOs1F4RzfUJLQt5/g1WaZ4DRqx+ZBsztJ5MXYNpL9H9lsM2jst+WFWOtRIaFIhyG+wqlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=aFuSLMyS; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="aFuSLMyS"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA5D9105E1A;
	Wed, 30 Sep 2026 15:27:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790774861;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=OBei++PFaKsMbbmTFH6SGCUXPPlqHSi9qP+JnXxY1cU=;
	b=aFuSLMySPm7G3osxABYWT0UV/BSHnPFnh0nh5k6JBPKZrU74rFStGOgqwoAb5rHFDUCbiz
	fc9gRs9EVlrPROFwUBifU+FpYFWVU6ZUMSASYQGDkdCRadIblaiO21bAmXICLFShjB49Rs
	ga5g1EpWoai41UEv2SWV37NBJGxbtV5Rh9P+q5DnT1hnCIitpoSdW+Rn/+2CYwCMHOg13i
	hFNrJJu+kbWllfxPGz8q3K/c14kr6wsEIf3Mss0aMTcxJaJMZlTpfFUyk8XyG+6NZexsMK
	ou+50BYNDVPV/jNWzXyTayHlF3TWwUh0Rp9howkKLXbN56OXwvWK1z/capMVng==
Message-ID: <b4addd8f-43ba-417e-85ad-a78391c8f2fb@nabladev.com>
Date: Wed, 30 Sep 2026 15:27:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
To: Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260924180607.60932-1-marex@nabladev.com>
 <AS4PR04MB93382AF6B2AC7B5F421019BB888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <af3d4fd1-9659-4d91-997f-6bb09ae06ba5@nabladev.com>
 <AS4PR04MB933887CA9C646F0359D8E61A888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <AS4PR04MB933887CA9C646F0359D8E61A888B2@AS4PR04MB9338.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/30/26 8:12 AM, Wei Fang wrote:
>>>> The current eMDIO MDC rate is 558 kHz on i.MX95 B0. This is very low,
>>>
>>> The system clock of i.MX95 NETC is 333MHz, AFAIU, the MDC rate should
>>> be
>>> 333/(2*258+1) = 644KHz. I'm confused that why you said the rate is 558KHz.
>>
>> That is what I observe on a scope on local MX95 board (not the EVK).
> 
> Clark helped measure the MDC rate on the 95 EVK board this morning, and the
> result was 644KHz, which is consistent with the theoretical value. The scope's
> accuracy or other factors may be causing you to observe a rate of 558kHz.

That 644 kHz and 558 kHz differs too much to be an equipment 
miscalibration / misuse.

> But
> anyway, the description of 558kHz is indeed confusing because it does not match
> the theoretical value.

Do you know from which clock are the MDC clock derived from on MX95 ?

>>>> but also very compatible. However, for example NXP TJA1120 PHY needs
>>>> at minimum 1 MHz MDC clock and 558 kHz does not work with that PHY.
>>>
>>> We previously used the TJA1120-SDBR daughter card to connect to the
>>> ENETC interface (RGMII) of the i.MX95 19x19 EVK board. However, we did
>>> not encounter any issues with MDIO access.
>>
>> Most PHYs are fine with the low frequency.
> 
> Yes, but the example you gave is TJA1120, and we also connected to TJA1120
> without this problem, so this is what puzzles me.

[...]

>> Page 46 bottom
>> Table 37. Dynamic characteristics...continued
>> Tclk(MDC) MDC ... clock period ... Min 400 ns
>>
>> 400ns ~= 2.5 MHz .
> 
> Thanks, I find the similar context in TJA1120's datasheet. The max period is
> 1000ns, so the min rate is 1MHz. It's weird that we did not see any MDIO
> access issues with TJA1120. I saw a note about MDC timing: "Not measured
> in production, guaranteed by design." It's possible that the minimum of 1MHz
> is a theoretical value, and it may actually work even below 1MHz.

I got a report it is problematic, hence this patch. But maybe this is 
also related to the 558 kHz MDC clock I measure locally vs. 644 kHz MDC 
clock on your end.

>>>> As a minimum change, increase the MDC clock to 2.5 MHz which matches
>>>
>>> The prerequisite is that NETC system clock is 333MHz, so that you can
>>> get a MDC clock rate of 2.5MHz (333/(2*66 + 1)). But unfortunately,
>>> not all NETC versions have a 333MHz system clock. For example, LS1028A
>>> is 400MHz, so the MDC rate will be 3MHz, which will be a problem.
>> Yes, this is my concern.
>>
>> Are those clock which feed MDC clock available via clock framework on LS ? If
>> so, we could calculate the divider based on those clock.
> 
> No, we typically hardcode the clock frequency in the driver based on the NETC
> version. Another simple method is to set the divisor to 166 instead of 66, which
> will not cause any problems for using a 400MHz NETC.

Hmmmm, are those clock available on MX95 ? Maybe we can do some sort of 
fallback -- assume 166 MHz clock on LS, and obtain the clock and clock 
rate via clock framework on MX95 ?
