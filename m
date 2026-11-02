Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631939;
	b=oBcq6HRT0jzOmnnRyfm61HTu3v5tdWOYk1X1WcqIWra4yXrsIqFp6fzo6wx+JybwmDuq
	 poxDVaPzz1cLKCxAzbwp1JxG9gvPLZY9Wcs9+B028CC7EeCqkrG/5qvJh+dR9CyotAMz/
	 L3sdYw074hTgmv9vzymYyXsbo+v0yo1cJaLGy70zyiseOSNfTijP2zda+Z/ox0hZxoi4H
	 p33YbmwDBpVF8WDo77z9ULRXiGudeigIUGouZylJm0XEzlrZRe+FEDUORxIoZmLKceVRa
	 YQF2ysWg3UFaTdJdcllboLLGcyP2KDkFH8CYjWKRbCdEXN4Nxpntv7wiQ+EgvZY/qvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631939;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=65B+XTjeC/stvy87CSmUplLFJkU9H65YFOEdiLp+FW4=;
	b=Y0j/BtWJncrbbp62ApR8EwETL6oMHH3fh3sL4QM45zPKRm387Kf5HLCoJsCQ6JUB9nrw
	 GlkOAIqqkgWEndTZrgFpHFCYtlFGikv6QPeUjlfTLbS/0V1VxnJmEIegvJh8+pl1V0cJv
	 CE5qfTX50d4tGI2nmYfORejIE39hpWMCsvjW43O0APqvXPFSrWfPFdnPBzOwQLJM/R32T
	 I+p+jS6FjYTJrKXtIUWI0jcTu5SXjWsKjAQ6K2zctW2MSBr9u/kMbRlxbZ8v2ZnCyYM5w
	 2NCgZRB4aDmyzxmCyjksUaKRJp7ma7oniBAPaCvdMQvEMqQ7Olhc9Us2jCOX9Q3pKvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ZOmYG3+f;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4D606A914
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE4D606A914
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ZOmYG3+f
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 309C14E413D3;
	Mon,  2 Nov 2026 15:05:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F0E8B60750;
	Mon,  2 Nov 2026 15:05:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A7717103290E8;
	Mon,  2 Nov 2026 16:05:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793631935; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=65B+XTjeC/stvy87CSmUplLFJkU9H65YFOEdiLp+FW4=;
	b=ZOmYG3+fd/zvXV69qvfdiIMJPfct1j57KXFg8/TuyO24nmgDGCs4U7dyZ9+kzpEC2zdb4n
	VFt5KXBqjwIjGUkyxWjh9RFrlHOKmG+wYw8wHuFiyBmU802FPJ3ZwmPyuhv5JzdQ2fDyKj
	6ZFvHH+6D8LTKTBMCeA7WqIHJcT/YY6wdn1+n1bxh1dr4dWm/1cA1rroqos6ZfxWJ8rkVF
	MiQ3qVOzKXFULFiBnrDb8D9OPFtLPBcY1UvXQ2GkWk4hGvnMqnMQJHn4CNdpDAI7j26iu1
	1ry4w4AFwxVoFtk+Jq8BEJawS85k8zpG9xKtZeMElACrSoHUOqdkWBRcTbKm/Q==
Message-ID: <1219dc2f-0f96-40db-8268-1a8eb009b152@bootlin.com>
Date: Mon, 2 Nov 2026 16:05:31 +0100
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
To: Guenter Roeck <linux@roeck-us.net>, Andrew Lunn <andrew@lunn.ch>
Cc: Roman Kuzmitskii <roman@damex.org>, linux-hwmon@vger.kernel.org,
 netdev@vger.kernel.org, robert.marko@sartura.hr, luka.perkov@sartura.hr,
 o.rempel@pengutronix.de
References: <03055ffd-d015-4810-8b8a-678821fa6dcc@damex.org>
 <92e3383e-26f8-4bed-b487-1c52f6c4f420@roeck-us.net>
 <8cd41211-b026-4158-8e18-454a9ac0bae4@damex.org>
 <4d12314e-56db-412c-a558-e4026cd03528@roeck-us.net>
 <d126b3d3-33b9-405c-9839-db492d874ece@lunn.ch>
 <9bac0a84-f03d-4fd1-8092-9922c65010bf@bootlin.com>
 <57516add-01bf-492b-9fd9-2bcb762e3041@roeck-us.net>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <57516add-01bf-492b-9fd9-2bcb762e3041@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 11/2/26 15:54, Guenter Roeck wrote:
> On 11/2/26 01:49, Kory Maincent wrote:
>>
>> On 11/1/26 20:57, Andrew Lunn wrote:
>>> On Sun, Nov 01, 2026 at 11:09:42AM -0800, Guenter Roeck wrote:
>>>> On 11/1/26 10:50, Roman Kuzmitskii wrote:
>>>>> On 11/2/26 1:38 AM, Guenter Roeck wrote:
>>>>>> On 11/1/26 10:02, Roman Kuzmitskii wrote:
>>>>>>> openwrt reviewers asked me to check with you first which way you 
>>>>>>> prefer:
>>>>>>> 1. extend hwmon driver with PSE-PD (like it is done right now)
>>>>>>> 2. move driver to drivers/net/pse-pd and extend it with PSE-PD
>>>>>>> 3. something else
>>
>> I am currently working on this topic by extending the tps23881 driver.
>> Please don't do it yourself to avoid working in parallel on the same 
>> topic. On the other hand, it would be nice if you can test it.
>> Roman I will add you in CC of my series.
>>
>>>>>>>
>>>>>> The hardware monitoring "enable" attribute is supposed to enable 
>>>>>> monitoring,
>>>>>> not to enable some power delivery or network (or any other) port. 
>>>>>> That "port
>>>>>> enable" feature using the hwmon ABI was sneaked in, and I am 
>>>>>> inclined to just
>>>>>> remove the upstream driver for severe ABI violation.
>>
>> Do you think it would be possible to remove the current tps23861 
>> driver and binding? This would break the backward compatibility.
>> I am currently using "tps23861-poe" compatible name binding.
>>
> ... and you probably also use the hwmon "enable" attribute
> to enable and disable ports on this chip. Again, that is an ABI abuse.
> I'll refrain from removing the driver for now, but I will likely
> remove the attribute if//when I find the time to do it.

I thinks you misread or I was no clear enough. I am working on expanding 
the tps23881 PSE driver to support the tps23861 version.
I am not using at all the hwmon framework in that development.
But as the binding tps23861 is already reserved for hwmon I use a new 
"tps23861-poe" compatible name binding.
To me, I agree to remove the hwmon driver but this will break backward 
compatibility. I am not a hwmon maintainer so it's not my decision to take.

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

