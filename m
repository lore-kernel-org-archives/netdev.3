Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA47C4252BB;
	Fri,  7 Aug 2026 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088961; cv=none; b=bH74lo0wSLadvdUrtC2khJxxNhbZu2h5JaiDXIxP+QgTO1QHJWUxNBVig96Qm3QbBizGzk39QTNsbpnQUzQ01NXNKisZBl0b+kyZBjeVceCZPBPgwlkXOpCOxW1tuquM/n+4FZzTJZeJsFMjg6d6/HgVgcJbfe+gW4FW7KnekxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088961; c=relaxed/simple;
	bh=fi2MuFluUi3ZEKC+8bpeI+eGKgy4RiFx8FGb6zegiiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4FyZ04jEmCYYwrW0nHbDhMgZt+tO+F2svhWUeiiLFSFLDq0vBLlTCgpcRMXnrgDEGlyIy8GiopwraCe+kOyi+GMZR1HbBaY4WXm6TAme+IP1hQe/uAORcwadMTObKNnoJK8k7KzmjQ+AYKaVsEj+WhbuP4rLTnPjqz44OGeO6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3E20E200C57;
	Fri, 07 Aug 2026 09:49:15 +0200 (CEST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1wsFKN-000Dj1-0T;
	Fri, 07 Aug 2026 09:49:15 +0200
Message-ID: <c9e3a4fb-40a1-40f6-b0e4-bf957195f1b8@pengutronix.de>
Date: Fri, 7 Aug 2026 09:49:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/2] net: dsa: realtek: rtl83xx: add support
 for enabling supplies
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Linus Walleij <linusw@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
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
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Language: en-US, de-DE, de-BE
In-Reply-To: <anWE2HD_Mrv9XlYV@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 8/7/26 9:10 AM, Oleksij Rempel wrote:
> On Fri, Aug 07, 2026 at 08:51:53AM +0200, Linus Walleij wrote:
>> On Fri, Aug 7, 2026 at 6:26 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>>> On Thu, Aug 06, 2026 at 07:40:29PM +0200, Linus Walleij wrote:
>>>> On Thu, Aug 6, 2026 at 5:56 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>>
>>>> [Andrew says]
>>>>> So devm_regulator_bulk_get() is already the "optional" variant, but it causes
>>>>> all existing users to get dummy supply warnings.
>>>>
>>>> So is this a big problem? Does it cause any other issues than
>>>> dmesg noise?
>>>
>>> As tested with local sashiko setup, new warnings for existing system
>>> without good reason will be reported as regression, so it will be
>>> blocker for net-next inclusion.
>>
>> Strong reverse centaur (*) warning on this one.
>>
>> I'm not sure this is how Mark want such "regressions" to be treated.
>>
>> I think a few dummy supplies is just fine and it's rather that Sashiko
>> need to be taught not to treat that as bugs/regressions.
>>
>> Yours,
>> Linus Walleij
>>
>> (*) Reverse centaur = humans touted to please AI, as opposed
>> to AI helping humans, sarcastic term coined by author Cory Doctorow.
> 
> Without context, I would fully agree with this statement. But as some
> one who need to adders new warnings on every kernel update for our
> customers, I see the point of sashiko - new unnecessary warning
> is extra unnecessary work for some one else == regression.

I also think we shouldn't dump 6 new warnings on other users if their
setup is working ok.

Cheers,
Ahmad

> 

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |

