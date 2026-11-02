Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642171;
	b=xnAYwUxcqzxgi/lC4h3HTq5vMkFW8q35WVvinmYQxuwRBLh2mxnlqlV0ZwxquTqBPwY7
	 CI9cLYEj079UswHEDQLSgLSTTGple9wRCAh+RrL8qIuovSP2O0YTb8MmMwXJpJZmDxbVa
	 Q48SXFprAZMOkFIPUK3PeN00Eca0DDNoTXRIqQDc0qdHbAOayf+DP7BLIuqiITtiydzwP
	 AVv23qj9mZINh5xMwpsT5sPVW/xylhAMo/+zAwQMv7ry8PRcBbrh8j7nUGkjlbGXSccMW
	 8r58NRNRmS7pIQ+R0KtXv1Z7BToG4/g7cp2ktLewyfgKuT3WP9fG4s+pbnMz8cg2KJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642171;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=NBkQHJrIAak8Le5dPArCMzdgm6IQY5JFknK7cSDqjyM=;
	b=3KjfRZNznzxsbsEhp6JUny4kwqpGZFpDV+aOEZp1NSeo9spgDOg95N6PHWs0EcRycg+G
	 pEIHQrEKtYh+oJmlFHt+0ZNe+kqJCVG3MciVM5FttxKn9T1GPIDj0jPP2VEiMBKH3wpyV
	 vZwWgL8sA9ogx8mMrc9elOJOumuLi0c6d2VEF+Wde2LpS5Z3HIs0ETdXVhFlU+tVdeUJU
	 YsIlnV8IYXM4Lq2CdrULzDtYJNXkd9hpvEJbRLMaAwLi9rJjo1awxYyWKVnC+Coxm9j2b
	 bz4Lbrgc6kHNojFwFTtTv77/faVgYjmoP6TqeRgaP7mv8N5aliDp+8MOtYlgFSzdEng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=CKTxuzPl;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664AD606D80D
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 17:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 664AD606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=CKTxuzPl
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9BD62C8F448;
	Mon,  2 Nov 2026 17:57:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4FE70603D7;
	Mon,  2 Nov 2026 17:56:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D4626103291C3;
	Mon,  2 Nov 2026 18:56:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793642166; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=NBkQHJrIAak8Le5dPArCMzdgm6IQY5JFknK7cSDqjyM=;
	b=CKTxuzPlQaXjY/y8jNESEW9VTqgWELe/6h4In4VRek/PvHUDeVhxPBSSQdG+6IJKw0y+S0
	gxUZJOzoWv22keLo2fM1YyD3avtk87usEOKQsqfVFPmuopSDlkGq5rrsy19Fb3rC1j2nqG
	Bm5WfOzPgYibbuR08N9cMWkDWQQkjitR3JiOFI2McGKrZTQYjgWNy3PNu7U9bO9Aenvl8L
	kxJvEAqY+Dze7olGlSsjxe5nMg37up+GsvEVQqnnbo0iRPfOgaizvqC0Ui46o0mUFR6rAA
	+UqYP8MsII0yEYd1mEyu9zabAGMKBcMqw5GT9qnQx12AeLdHpPnG46v5DBdkPQ==
Message-ID: <5db15d98-ee57-4c78-8514-dfc5da52d6b4@bootlin.com>
Date: Mon, 2 Nov 2026 18:56:02 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [RFC] hwmon: (tps23861) PSE-PD support, extend hwmon driver or
 move to pse-pd?
To: Andrew Lunn <andrew@lunn.ch>
Cc: Guenter Roeck <linux@roeck-us.net>, Roman Kuzmitskii <roman@damex.org>,
 linux-hwmon@vger.kernel.org, netdev@vger.kernel.org,
 robert.marko@sartura.hr, luka.perkov@sartura.hr, o.rempel@pengutronix.de
References: <03055ffd-d015-4810-8b8a-678821fa6dcc@damex.org>
 <92e3383e-26f8-4bed-b487-1c52f6c4f420@roeck-us.net>
 <8cd41211-b026-4158-8e18-454a9ac0bae4@damex.org>
 <4d12314e-56db-412c-a558-e4026cd03528@roeck-us.net>
 <d126b3d3-33b9-405c-9839-db492d874ece@lunn.ch>
 <9bac0a84-f03d-4fd1-8092-9922c65010bf@bootlin.com>
 <57516add-01bf-492b-9fd9-2bcb762e3041@roeck-us.net>
 <1219dc2f-0f96-40db-8268-1a8eb009b152@bootlin.com>
 <e422d6e8-3385-43f2-bcd3-1c5060a5b45e@lunn.ch>
 <d7f5a3b3-a3e9-47bf-8f08-5c8feb0c88e7@bootlin.com>
 <300336f7-94d2-4075-abf3-2c1ddc48fa69@lunn.ch>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <300336f7-94d2-4075-abf3-2c1ddc48fa69@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 11/2/26 18:33, Andrew Lunn wrote:
> On Mon, Nov 02, 2026 at 05:57:06PM +0100, Kory Maincent wrote:
>>
>>
>> On 11/2/26 17:36, Andrew Lunn wrote:
>>>> I am not using at all the hwmon framework in that development.
>>>> But as the binding tps23861 is already reserved for hwmon I use a new
>>>> "tps23861-poe" compatible name binding.
>>>> To me, I agree to remove the hwmon driver but this will break backward
>>>> compatibility. I am not a hwmon maintainer so it's not my decision to take.
>>>
>>> Is the hwmon code applicable to the tps238XX range of devices?
>>>
>>> Can that hwmon code by merged into the PoE driver? Without API
>>> changes, apart from dropping the API abuse case? The compatible can
>>> then be transplanted into the PoE driver?
>>
>> Should we really want to add the hwmon framework in the driver only to keep
>> the binding name?
> 
> That is why i asked if the code is applicable. If it is using hwmon to
> show the temperature of the PoE controller, it probably is
> applicable.
> 
> If it is just repeating the same information which is available in
> ethtool, then it is not so useful. If it is not useful, the hwmon
> driver should be marked as deprecated, and a pointer added to the real
> PoE driver.

Oh ok. The information reported by the hwmon driver that are not in the 
PSE driver are:
- current and voltage while PSE is reporting the power
- the temperature
- the port resistance

Not sure if they are useful. For the temperature the PSE raise a 
notification in case of over temperature.
Anyway if we want to report these information I think we will report 
them through ethtool not in sysfs. We can later add a new ops to report 
the temperature if people want it.

Regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

