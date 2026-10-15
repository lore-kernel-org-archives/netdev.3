Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EEC248893;
	Thu, 15 Oct 2026 23:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108087; cv=none; b=jGat3ryfvq8UJxml1lPe97P+TRGaKrKXXlbHWt7leFTcT697TxvmGQSmlJdoCJlMUgzJlos3vFIF2VZK0f7DjfZumn11v96DruVjGamhIAOMEMjrHgqH1yrCZgDOa/4tmpOOeB5vItaoMnsNydJgo4VL5vhq2qzC7pwA1rGe+7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108087; c=relaxed/simple;
	bh=m27SmZZTS7JpMwtLitQ0k7tJ3ZHPI8bxno74mTETTsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WcN0vDTPdudZtGvxJ1CWJiByj6cJ6x25RRKAzw8LiyT3CoP+WIQBPv3RiLtUbS424K/0NQebL8L1bj1LIxwrlxpOmKZ0Y2DMYUh9IZFuX210M8eAiiXYRQd6fjNgkelzlh9WcdB5L1mPgfxmp/cIIisaL61KrxaCBfRcHff1X+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=dyIUXUSn; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="dyIUXUSn"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 391B51082A1;
	Fri, 16 Oct 2026 01:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792108073;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=odgiDLhjLN5ABbzDY81bVr2SK/hEUupDPKG/mRLLcQo=;
	b=dyIUXUSnfbx5JPj9xwmce7sdh3eqYg1BddGhsGlr2ILCCag/yMBhihpJwgJbLUJYGrP3Tb
	GioP4cm+ZkZsDPh34k+mipoB1ArBzN+q4hLdPXoBPpHA8IkxrHQdGusBiBpCayvxy715kt
	eEBrgsNYKf0HZyEW7VjYY4Cn2ORXwN/aKtNGLk5Y0Rv2LXoeR5bjm4AV3IVh/O5xhwFxMw
	MsASeLBtQAFY7yc2plsz2IN5+urBPIsRtiSq3s4yd4whZsNyLUwtyWyQg+8kISuOqLZ0J7
	MljKKfZInTiPmSsIQXrscENW4qoLuqyJQLA5IrlY/eKUOYiRUQNLDcVVMSY0mw==
Message-ID: <83380f02-6dc7-4aaa-8987-be17fbd26d4c@nabladev.com>
Date: Thu, 15 Oct 2026 23:20:52 +0200
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
 <b4addd8f-43ba-417e-85ad-a78391c8f2fb@nabladev.com>
 <d8e72848-1611-4d6e-b3e8-17013bce7948@nabladev.com>
 <AS4PR04MB9338F6AFA7DF06339C54DD1288932@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <c4c6953e-c831-4b1f-8600-67c226384876@nabladev.com>
 <AS4PR04MB9338A3A7CF410D39C6B49969889E2@AS4PR04MB9338.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <AS4PR04MB9338A3A7CF410D39C6B49969889E2@AS4PR04MB9338.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/13/26 4:17 AM, Wei Fang wrote:
>>>>>> Clark helped measure the MDC rate on the 95 EVK board this morning,
>>>>>> and the result was 644KHz, which is consistent with the theoretical
>>>>>> value. The scope's accuracy or other factors may be causing you to
>>>>>> observe a rate of 558kHz.
>>>>>
>>>>> That 644 kHz and 558 kHz differs too much to be an equipment
>>>>> miscalibration / misuse.
>>>>
>>>> For the sake of completeness, the MX95 B0 I have on my desk now
>>>> prints this in
>>>> SM:
>>>>
>>>>    >$ clock.r
>>>> ...
>>>> 097: busnetcmix           =  on,  133333333Hz
>>>> 098: enet                 =  on,  666666666Hz
>>>> 099: enetphytest200m      =  on,   24000000Hz
>>>> 100: enetphytest500m      =  on,   24000000Hz
>>>> 101: enetphytest667m      =  on,   24000000Hz
>>>> 102: enetref              =  on,  250000000Hz
>>>> 103: enettimer1           =  on,   24000000Hz
>>>>
>>>> And the cycle time of MDC is 1.8ms , which is some 550 kHz .
>>>
>>> The enet clock is the source of NETC system clock, and there is a 1/2
>>> divisor inside the NETCMIX, so the NETC system clock is 333 MHz.
>>> So the MDC clock should be 644 KHz, the frequency measured by Clark in
>>> the attachment is indeed 644kHz.
>> Is there maybe any other clock source that might feed the MDC clock on
>> MX95 B0, that could explain the 558 kHz I observe ?
> 
> I do not think so. If that's the case, then setting the divisor to 66 would not
> result in a MDC clock of 2.5 MHz.
Hmmm, I see.

(also, I apologize for the slow response, I am completely flooded by 
emails, I still need a few days to get back to this topic)
