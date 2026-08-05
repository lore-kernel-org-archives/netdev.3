Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A089C407CCA;
	Wed,  5 Aug 2026 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923086; cv=none; b=Lcdhhqdomvwq97LvN4/aI9D114ZSaTcPMC+Yok5BuxXwCOJyHYxmqEB0RpKenvXvprVJTol9Cn1j6oNOXolyjaM1drP4m02kOsAhUhxFnfnueORzk+Jjg6m+Kph8QPqEQ+5QpKTJ2EcJAUdLwhS1ppEXiQPlueDWNXVly3vssl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923086; c=relaxed/simple;
	bh=26yFBuhMx/v2K//LPh7gW+XK3IDpf4atvibnqGNILmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePKi8V33CoXi3sf8Fn9pj9RQ8LSyb09t2rHEp/P9u3ue8V95ktcYMprxTtDz8nZ8xn+CKFo2SzsWk/Eh1LT5O85hBCfHYPaAyvC0Ud54bkvzVDbYAPkr400IW2xxU0K3sEawTOPGencrwTaK6ZloeJAnvZ9G85oggSFhQqbzh+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=GFfBROQs; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="GFfBROQs"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05F2F3E99A;
	Wed,  5 Aug 2026 09:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1785923073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtXFHHJglfqPL058cGxqSiFLFxG+GA5lJ7tDnZa+M44=;
	b=GFfBROQsGGyFNcsofm/eieeO+C0kitXrWZPPc38BoOWmfc1yFxNK+Y7ZZ5Pf4VOI+AlinN
	0Y+ew4lrSq6qAmoj9VCNvdXYtv8MMfZRpok1rhYAVgJfhlptwD9hPBLLGYxawmZYjPkQrN
	8ux4tzTzE50hfaDLECxF0mw00xdWXETP804PqdTIjQ9Fp5ho+Nja3Vr3Z9vGta1J6IusWj
	RzUWyN2mx1kA6xjZnYaZ8NwVI4Oe4jJ5TpyW/k0K8G+p5I8fc9lEEfUArcrfy7yszXF3wj
	zQwQI2kMz1mIt8WQaPXu/vMGOy/bx/+1i2qs6jLm1HsP8q4BtTizcPHJqL+CGA==
Date: Wed, 5 Aug 2026 11:44:23 +0200
From: Arthur =?utf-8?Q?Cr=C3=A9pin?= Leblond <arthur@marmottus.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Netdev <netdev@vger.kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w5100: restore GPIO-based link detection
Message-ID: <anMF9_h0OilX-Tz3@pc-du-fromage>
References: <20260804-wiznet-link-gpio-v1-1-b626fd4f7ccb@marmottus.net>
 <d762ff5f-30ba-42fc-bf58-500f807483ad@lunn.ch>
 <anLzkNOBMvn7_0d3@pc-du-fromage>
 <5d9c865e-a9a2-4756-a27b-a5af60ef3bad@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d9c865e-a9a2-4756-a27b-a5af60ef3bad@app.fastmail.com>
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGiNRN3RMvshvS8Em8+0JZ9VAxUYPVVpgFCjw1591NemXY7gpudXGb+lrDTL7j4AOeRes2W0AGLKUabndoMhNNZUxRk2X5huN03hjAOzysXl2usXJ2K7szdcEycMOkLY6MsOkM4OKgLFGQOunPoO55xaPaBL6qcGNJH1gTZAFY9FuypwgVqcAvUwNEyUBVtJUqC9auzifXZNZe9gFTHQZh2Q7akUacefk93SxfVrvJ7ozu6TOEnUVuKBWAe9Tke5V3GghNMWbnRSrari0OfvGpHSufegTr3UT6VqJkcO2wscFGK2k02Gt7Wh1ifeIzkfQIQ2PcywfsltbroobvhiYjnJMchpM9Y7wfttty3GA0N61DPIMDAZXG17+90zzsAdjzPTtM5HCT88wpg8STVWm5XKhVVK+s+owqQSxpbJnX5ywFJEjDItIa4TfsiQzRh/J2I43CzFW8G/XI4I8GT885+Qy/8CoNjkUMv2luIV+IxSzTjGQHdWP6pUoeK+1FBSgA5HeFolZD0kQGeV7V3FuW0q1zPA0dWs9MrM3/JYPXIKUZLYW2R4bpU4MYc56XVgkEY8mMtbJbcOgN9sX9L3TTGYoMnSvmbaHuZvWt5V5v0X2wHUQN0bMWmxZyqAjz3uDrUXTemdoVXfxhtEskdzZzHNCD+oUvu98lr9bcqLjwwkA

On Wed, Aug 05, 2026 at 11:11:53AM +0200, Arnd Bergmann wrote:
>On Wed, Aug 5, 2026, at 10:25, Arthur Crépin Leblond wrote:
>> On Tue, Aug 04, 2026 at 07:54:29PM +0200, Andrew Lunn wrote:
>>>
>>>https://wiznet.io/products/ethernet-chips/w5100
>>>
>>>suggests it has an integrated PHY. So why is a GPIO needed to report
>>>link?
>>
>> the W5100/W5500 exposes directly a LINKLED pin for the carrier status.
>> On my board (RPi), that pin is wired to a GPIO to detect changes on the host
>> directly via an interrupt.
>
>The datasheet says
>
>   LINKLED O 66 Link LED
>      Active low in link state indicates a good status for
>      10/100M.
>      It is always ON when the link is OK and it flashes
>      while in a TX or RX state.
>
>which sounds like this is not a great way to do it, since any
>data transfer would drop the link status. Are you sure the
>gpio line as you connect it actually only reports link status
>and not RX/TX? Which chip/revision specifically are you using?
>
>With the W5300 driver (now removed) that was trying to use the
>link gpio, the LINKLED description in the datasheet is different
>and does not mention flashing, so on that one, the gpio link
>interrupt was more likely to actually work.
>
>      Arnd

You're right for the W5100 that would not make any sense during data
transfers it would trigger the interrupt. That's unreliable.

I am using the W5500, and in the datasheet it says

   Link LED
   This shows the Link status.
   Low: Link is established
   High: Link is not established

I can confirm it is what is happening, I don't see any changes
of state during TX/RX.

Arthur
