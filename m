Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39746483BD9
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031812; cv=none; b=cOXVyyYxf/er60qC+8RHF14yzJP5HDF8LCILFPJ3ouWepgA8Yp5al+V+hqv0w2d7+JhpBsVPW/6h9IdFDFZLX7SILPZRK3DnIC1vHpJ3vzCfsybaBZmeoUmHPsKrOJo63Y2b3UIXOgoRKCxXsgv/fZuVs/+UJbFETRM+gTE/Nf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031812; c=relaxed/simple;
	bh=xpXYLu1m3cEgdgrwU2FGnbw3ZDXBwpd6sjT5QZMN/eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSYz0q2NLjevRM/23v/aqIc8bE1NxuMlx9AJfbSD/yb4JrS8q+isS2hwZGzfRwCwBWfFAKcjMazfCu1p0Z3qzd2h28NBI2W0mNtr6Eyxfd9nvD17aRy3HpnJ9CJOosPDJraQAnMe1fgbYXWGtp6zqm13dA81gAOAIhegRl6BKpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1ws0SB-0000FO-4P; Thu, 06 Aug 2026 17:56:19 +0200
Message-ID: <02a51eff-3782-4012-8475-1047a9be4dd3@pengutronix.de>
Date: Thu, 6 Aug 2026 17:56:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/2] net: dsa: realtek: rtl83xx: add support
 for enabling supplies
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?=
 <alsi@bang-olufsen.dk>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
References: <20260806140239.3518906-1-o.rempel@pengutronix.de>
 <20260806140239.3518906-3-o.rempel@pengutronix.de>
 <9181f24b-cd5e-46c8-8e57-cbf309ac1a98@lunn.ch>
 <anSj34TOZxYiG_ai@pengutronix.de>
 <f2260b02-621f-4b92-aade-85c403a8839d@lunn.ch>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <f2260b02-621f-4b92-aade-85c403a8839d@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hello Andrew,

[Cc += regulator maintainers]

On 8/6/26 17:35, Andrew Lunn wrote:
> On Thu, Aug 06, 2026 at 05:10:23PM +0200, Oleksij Rempel wrote:
>> On Thu, Aug 06, 2026 at 04:12:44PM +0200, Andrew Lunn wrote:
>>>> +static const char *const rtl8365mb_supplies[] = {
>>>> +	"avddh", "avddl", "dvddio", "dvddio1", "dvddl", "pllvddl", NULL,
>>>> +};
>>>> +
>>>
>>>> +static int rtl83xx_enable_supplies(struct device *dev,
>>>> +				   const char *const *supplies)
>>>> +{
>>>> +	int i, ret, count = 0;
>>>> +
>>>> +	for (i = 0; supplies && supplies[i]; i++) {
>>>> +		ret = devm_regulator_get_enable_optional(dev, supplies[i]);
>>>> +		if (ret == -ENODEV)
>>>> +			continue;
>>>> +		if (ret)
>>>> +			return dev_err_probe(dev, ret, "failed to enable %s supply\n",
>>>> +					     supplies[i]);
>>>> +		count++;
>>>> +	}
>>>> +
>>>
>>> I've never used it, i've no idea if it is applicable, but there does
>>> appear to be _bulk_ calls in the regulator API, maybe which is similar
>>> to the clk _bulk_ API?
>>
>> Ack, in the first iteration of this patch we was using
>> devm_regulator_bulk_get_enable(). But it would print warnings on
>> existing boards without regulators in devicetree. Currently there are no
>> bulk helpers with _optional regulators, so I reworked it to hand made
>> optional bulk support.
> 
> static inline int __must_check clk_bulk_get_optional(struct device *dev,
> static inline int __must_check devm_clk_bulk_get_optional(struct device *dev,
> static inline int __must_check devm_clk_bulk_get_optional_enable(struct device *dev,
> 
> If clk has them, maybe regulators should as well?

clk and regulator have different interpretations of _optional
when encountering a non-existent resource:

clk_get                 return error
clk_get_optional        return NULL
regulator_get           return handle dummy regulator
regulator_get_optional  return error code

So devm_regulator_bulk_get() is already the "optional" variant, but it causes
all existing users to get dummy supply warnings.

I don't know if there's a strong case for a devm_regulator_bulk_get_nowarn(),
maybe Mark or Liam have an opinion on that.

Cheers,
Ahmad

> 
>    Andrew
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
