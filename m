Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D985F280325;
	Fri,  7 Aug 2026 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111547; cv=none; b=eXVxxVJ6kXRmD8kOFzi+E8/tlJeTgGXmv6t17VNSNQO1C/cyctyAnJ60CqpKYJUx04m1OFXOX0dNjg+hGLTU6sInYX8R3ovZ/0x3ENxplLAz4rG3myHoSWY1hJHl6JSAwDnH1u0ICe89R29Qx7nVnG2aQVG5IazKWT1KMcXMNkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111547; c=relaxed/simple;
	bh=z0MJWHKbJZ8NkAllEaqcVdeXwyRwXOq0e4EA/WAKpMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qveQz3hj9tfeVcGWVEkZiDP9cwGimfaiFGbFEwwwd+4zWK+tzf6Obo9TR4pU9A19vwEznqJaALf6wai6YUzyclcLvjPCzh7B2jeEAoHIkS3vmQ9bpIxk0WVDgcad2mwSVkedT9fqQutZoGpty2ue/wue94zf1ksp+jTe+ATZdCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4130120227B;
	Fri, 07 Aug 2026 16:05:37 +0200 (CEST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1wsLCb-000Gr6-0U;
	Fri, 07 Aug 2026 16:05:37 +0200
Message-ID: <270c4bc9-469d-4c30-b76c-0fba569abbd9@pengutronix.de>
Date: Fri, 7 Aug 2026 16:05:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/2] net: dsa: realtek: rtl83xx: add support
 for enabling supplies
To: Linus Walleij <linusw@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 Rob Herring <robh@kernel.org>, netdev@vger.kernel.org,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Eric Dumazet <edumazet@google.com>, kernel@pengutronix.de,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?=
 <alvin.sipraga@analog.com>, "David S. Miller" <davem@davemloft.net>,
 devicetree@vger.kernel.org
References: <anSj34TOZxYiG_ai@pengutronix.de>
 <f2260b02-621f-4b92-aade-85c403a8839d@lunn.ch>
 <02a51eff-3782-4012-8475-1047a9be4dd3@pengutronix.de>
 <CAD++jLk-5-_2x2scn2hNQ-aWBx=EKGYzvcaUwv5fS7k5Bq=KGA@mail.gmail.com>
 <anVedv6aV1hguF5x@pengutronix.de>
 <CAD++jLkkwuRYrW7aF4BrxoH=qVfNfbzsW8A+URig79dVMxgZ-g@mail.gmail.com>
 <anWE2HD_Mrv9XlYV@pengutronix.de>
 <c9e3a4fb-40a1-40f6-b0e4-bf957195f1b8@pengutronix.de>
 <CAD++jLmJCwALGLJt98BBhYAy_5UfUsJp6J7ah2+Pu51CMJeMPw@mail.gmail.com>
 <89763f3f-f21a-4240-aeee-b75b8f19aece@pengutronix.de>
 <113c8afb-0266-470e-a985-f60a7cdf6852@sirena.org.uk>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Language: en-US, de-DE, de-BE
In-Reply-To: <113c8afb-0266-470e-a985-f60a7cdf6852@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Mark,

On 8/7/26 2:19 PM, Mark Brown wrote:
> On Fri, Aug 07, 2026 at 10:27:31AM +0200, Ahmad Fatoum wrote:
> 
>> Anyways, circling back to the patch: Any objections to leave it as-is
>> and suppress the warnings in this particular driver?
> 
> Yes, that is a buggy use of regulator_get_optional() so you should not
> do that.

If the DT binding documents a regulator as optional, it makes no sense
to me that the driver implementing the binding triggers a warning when
the optional regulator is omitted.

>  Unless the supply may be physically absent it should not be
> used.  If you have ideas for how to safely improve the implementation of
> the normal regulator_get() then it'd be better to do that, bearing in
> mind that it's an API where getting things wrong can easily result in
> physical damange to the system.

How about demoting the dummy supply warning to notice? I think this
better reflects the severity of the message.

Cheers,
Ahmad




-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |

