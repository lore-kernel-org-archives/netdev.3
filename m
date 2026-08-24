Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6977741D12B;
	Mon, 24 Aug 2026 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575446; cv=none; b=li1sbsAVJEN0VLmka7+QpY0gNHokcpZT5i0XBGsQ+e68+4PwXO2Dj4SYpC/0s2c2LD6CXYMkysfRsEDeLfwfLVK7L7BqTn2MKOWX7NAxKFhQUfSTwdtr0qoLYhupGtllg4ICSdld+UkD/AZ2aO6Bks0qkWanKkYkBMBlQCkSO5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575446; c=relaxed/simple;
	bh=lfl7rp+xhEOu29BWIIpft3LUJVcj9p9igChhyJD06hs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WOaAj5Oda9bcswHfm3Z2ytQ5W9Np0lAtGcHfCLcpKvumTobkwKIVixqm1UznKeCyIlRVB1fYdGiUOQoVbaf46h3U5goVoX1xlT/LH1R6ATEaz3oo/vA35u2I5ezz2bQrC95d0zwJfCy5WiRux8AmitGVIP3oLXsydV4ODJCL+oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DPszi5TG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DPszi5TG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 87B874E4139C;
	Mon, 24 Aug 2026 12:43:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 500905FFC1;
	Mon, 24 Aug 2026 12:43:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C4F711C7941D;
	Mon, 24 Aug 2026 14:43:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787575432; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fl8a2fw0ounjOTLkIR3VH+zumruQ5hoWeaHQ4crll+o=;
	b=DPszi5TGVdjjsBy4JSP2i5vMlxfEVSbTn00fFrQh1NzMZby3zb5VzjiVTSRtbcHVWitYLf
	Gl8bI89u+6hUcq+95mWBq7cLRckZMKwXOwxIY890xl0SS2b6ifYyPxrYusupqYaPWu1iZj
	0OVV8pen58nwNCxTpIDFbWYM3Rr/o7ljj7hQaW+RSQpoMGGOrv6IjZ91TEl4uFGmRx19rp
	6sjcFpQXLyVRUuVP5aFMnhg8A66Ydu79cb6kf1PbtcCGxtR8+A4hMQw+Y/XSydYaqX4X45
	Nx/2pLPxqIm7Pj8zEgy8SFhKEb63jkiBqe4xP8oaVzCRZfZZkAWE0nHFUxa43A==
Message-ID: <41dd51e5-ac20-48b5-9e7c-4d2d261f3402@bootlin.com>
Date: Mon, 24 Aug 2026 14:43:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [RFC PATCH net-next v2 0/2] net: pse-pd: Add LTC4266 PSE
 controller driver
To: Kyle Swenson <kyle.swenson@est.tech>,
 "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Roland_Kov=C3=A1cs?= <roland.kovacs@est.tech>,
 =?UTF-8?Q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
References: <20260820142429.2285172-1-kyle.swenson@est.tech>
Content-Language: en-US
In-Reply-To: <20260820142429.2285172-1-kyle.swenson@est.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Kyle,

Sadly, we won't present together at the next ELCE, but well, we still 
can drink a beer together. Are you going anyway?

On 8/20/26 16:25, Kyle Swenson wrote:
> This RFC series intends to continue discussion around the support for
> the LTC4266, an older PSE controller that supports powering Type 1 and
> Type 2 PDs.
> 
> This chip has four individually controllable ports, each with its own
> detection, classification and current-limiting abilities.  The driver
> declares the static power budgeting strategy.
> 
> The LTC4266 only enforces a current limit (I_CUT and I_LIM), not a power
> limit, so an admin power limit has to be turned into a current limit.
> There are two problems that fall out of this I don't feel like I've got
> a great solution to either and would welcome feedback, hence the 2nd RFC
> version.

Of course every controller is doing it on its own way ...
I have taken a look at your driver, it would be more precise to use the 
voltage used on each ports instead of the constant LTC4266_VPORT_MIN_MV.
I don't have the datasheet of the registers but does a read voltage 
return a value even with no PD plugged?
BTW I don't understand why in ltc4266_pi_set_pw_limit you are using the 
detected class for power comparison. If the user wants to set a power 
above the current detected class, well lets allow him to do so. Also 
this will prevent any power limit set if no PD is plugged which is not good.

> The first problem is programming the current limit from the
> admin-specified power limit for power limits other than a specific PD
> class.  For this, I replaced the linear regression in the first RFC with
> the minimum port voltage for a Type 2 PSE (50V, from Table 33-11 in the
> IEEE 802.3 spec) to convert power to current.

See above, please use a measured voltage for more precision.
  > The second problem is that when the admin does something like
> 
>      ethtool --set-pse eth1 c33-pse-avail-pw-limit 10000
> 
> the command fails with:
> 
>      netlink error: Can't calculate the current, PSE voltage read is 0
>      netlink error: Result not representable
> 
> unless the PSE port has been enabled first, and the PSE has detected and
> classified a PD on that port.  I'm hopeful I'm just missing something I
> can do differently in this driver, but if not I'm open to adjusting
> things at other layers to support this.

To have this working the pi_get_voltage should return some value even 
with no PD plugged.

I am replying only here for now. I will take a look more deeply on your 
code when this is solved. Is it ok for you?

Also I think your code is rather ready, so you could remove the RFC 
prefix. With it, the nedev check are not triggered.

Also in the 2nd patch you should add yourself in the MAINTAINERS file 
for this new driver.

Regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

