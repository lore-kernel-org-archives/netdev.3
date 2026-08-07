Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0076546D2BF;
	Fri,  7 Aug 2026 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091265; cv=none; b=Rm12VAt+h6F7OvSWhAPLyTxCSeyLcKfu2YougTqlYXgA46aZhcsC2W0yx+eqXfSrOnIBJ70MwXSJIDuKDjFjF0B+VpYKBDAgQzDGtxix2JNVeI6pNyHvUyzWlj3GOoyS2JeDN7t8LQ1qR2bcE+SqTsmtiCw4esPGNQ9G8ielbT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091265; c=relaxed/simple;
	bh=83yjCb6qqSshK9FNioHg3sYmvbjifB+5SSAmLEfy0wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WoyxwxPohKGP29sZPjD7GXPYKE5PNWQKbblKEGAP90wBGFD9o+Ry1kFMXfnQ59iTXgNtww5f7ll4JqnkyQR5IT+jl+ybS2GC7qeBPSVCsbbAYwCaUDD7OYISxcMvlk6GSJ2z7G8dYECOW932VJFrnQGsoWBrbeQQHqPDaKnC3sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E44A42005E3;
	Fri, 07 Aug 2026 10:27:32 +0200 (CEST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1wsFvQ-000E3K-2e;
	Fri, 07 Aug 2026 10:27:32 +0200
Message-ID: <89763f3f-f21a-4240-aeee-b75b8f19aece@pengutronix.de>
Date: Fri, 7 Aug 2026 10:27:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/2] net: dsa: realtek: rtl83xx: add support
 for enabling supplies
To: Linus Walleij <linusw@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown
 <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 Rob Herring <robh@kernel.org>, netdev@vger.kernel.org,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?=
 <alvin.sipraga@analog.com>, "David S. Miller" <davem@davemloft.net>,
 devicetree@vger.kernel.org
References: <20260806140239.3518906-1-o.rempel@pengutronix.de>
 <20260806140239.3518906-3-o.rempel@pengutronix.de>
 <9181f24b-cd5e-46c8-8e57-cbf309ac1a98@lunn.ch>
 <anSj34TOZxYiG_ai@pengutronix.de>
 <f2260b02-621f-4b92-aade-85c403a8839d@lunn.ch>
 <02a51eff-3782-4012-8475-1047a9be4dd3@pengutronix.de>
 <CAD++jLk-5-_2x2scn2hNQ-aWBx=EKGYzvcaUwv5fS7k5Bq=KGA@mail.gmail.com>
 <anVedv6aV1hguF5x@pengutronix.de>
 <CAD++jLkkwuRYrW7aF4BrxoH=qVfNfbzsW8A+URig79dVMxgZ-g@mail.gmail.com>
 <anWE2HD_Mrv9XlYV@pengutronix.de>
 <c9e3a4fb-40a1-40f6-b0e4-bf957195f1b8@pengutronix.de>
 <CAD++jLmJCwALGLJt98BBhYAy_5UfUsJp6J7ah2+Pu51CMJeMPw@mail.gmail.com>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Language: en-US, de-DE, de-BE
In-Reply-To: <CAD++jLmJCwALGLJt98BBhYAy_5UfUsJp6J7ah2+Pu51CMJeMPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/7/26 10:20 AM, Linus Walleij wrote:
> On Fri, Aug 7, 2026 at 9:49 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> 
>>>> (*) Reverse centaur = humans touted to please AI, as opposed
>>>> to AI helping humans, sarcastic term coined by author Cory Doctorow.
>>>
>>> Without context, I would fully agree with this statement. But as some
>>> one who need to adders new warnings on every kernel update for our
>>> customers, I see the point of sashiko - new unnecessary warning
>>> is extra unnecessary work for some one else == regression.
>>
>> I also think we shouldn't dump 6 new warnings on other users if their
>> setup is working ok.
> 
> If you think the regulator subsystem is too talkative that is one thing.
> 
> But there are millions of systems out there booting every day
> with dummy regulator prints that have been there since forever.
> New ones have been added over the years.
> 
> It doesn't mean dummy regulator prints are regressions.

I think it's a regression in user experience to have warnings pile up
over the years when nothing is broken.

Anyways, circling back to the patch: Any objections to leave it as-is
and suppress the warnings in this particular driver?

Thanks,
Ahmad

> 
> Yours,
> Linus Walleij
> 

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |

