Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F72D2486;
	Thu,  5 Mar 2026 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714382; cv=none; b=r81CavrB6VNm2JQx47o7jklLziXc4+kR+8kBkXcS7Zp1oq/xmHKIeWr6KCcKRIPkORTAQPRIPdjHzjSJQR/HWrji2TWCKklsD3nWOGbwtItiDah7recowtDHIuctpVdKTNqIeTe3XMOBiRm4YbNMPhUGeolU3/kLWo0bA8cut7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714382; c=relaxed/simple;
	bh=tMs6T9YZiJXMVoNczRW6TZfcqeNlIu0v5w1T5Hu+Qpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eM1oGq8z1f6GGhQJ1g4hht7iUFG0YQeX0LdqwhVs0BT2FFJj1btt3FqVXJdeA9hOGwoReiIu7fOkAEmtEkfQ4Cd+2Z1zwL9qvUYetYVV5HsHbEy3u7/oagkUfL2RKUZj7P9T2sywbl39GZKPoaKIdbevfPp3GxMKw9Z7rtC0Rp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JLkuseuL; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JLkuseuL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 99D3FC40413;
	Thu,  5 Mar 2026 12:39:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E7DB25FDEB;
	Thu,  5 Mar 2026 12:39:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EDE4103698B4;
	Thu,  5 Mar 2026 13:39:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772714375; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=euylI4z3buIJeD9o4LZqpQOfLSEVekKUGhNMjoeHw6Y=;
	b=JLkuseuL8JnTAYRdMvFCc1lBsMoelLt5Lc1U6U1GeKiFaBTaZC+dLLM70zrjWaKeAz43+g
	MiotncdX2E/8TTFfL80x+snCD1bI26mIOVcajXqqxYB7oorJQxM3XC0f9J/iS7jqigRDea
	v/OEkczjP+0TsqIfv5joqVElGNX8pR2uGZZJS2nET0YM3wuqwDdCmnpuI2ylpsvdMPmizN
	tDtgVjwhUH+T7zIiG1RpVRUS+i2mZhjg45fw0mrK4zS7TqCCan76HXmv3hd7a6LkHqsTTl
	Swvrq57wfZe4iTGOyDWI0gBnOCzlijxDD+6C6MZ5P+CdLC3tUG4wD7rqT8gDhg==
Message-ID: <98944cef-0877-4fb9-83a0-92bbd3852f66@bootlin.com>
Date: Thu, 5 Mar 2026 13:39:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-1-3f4c47954c71@bootlin.com>
 <20260305095656.vlyaztv6nbdqrmil@skbuf>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260305095656.vlyaztv6nbdqrmil@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Vladimir,

On 3/5/26 10:56 AM, Vladimir Oltean wrote:
> On Wed, Mar 04, 2026 at 11:18:52AM +0100, Bastien Curutchet (Schneider Electric) wrote:
>> @@ -2890,14 +2899,18 @@ static irqreturn_t ksz_irq_thread_fn(int irq, void *dev_id)
>>   	unsigned int nhandled = 0;
>>   	struct ksz_device *dev;
>>   	unsigned int sub_irq;
>> -	u8 data;
>> +	u16 data;
>>   	int ret;
>>   	u8 n;
>>   
>>   	dev = kirq->dev;
>>   
>> -	/* Read interrupt status register */
>> -	ret = ksz_read8(dev, kirq->reg_status, &data);
>> +	/*
>> +	 * Most of the KSZ switches have a 8-bits long interrupt status
>> +	 * register, but the KSZ8463 has a 16-bits long one. The overread here
>> +	 * is safe because we only iterate over kirq->nirqs in the below loop.
> 
> FWIW, this isn't the only thing making an overread "safe".
> If the adjacent register also has "clear on read" semantics, that's not
> good.
> 
> I can't tell whether that's the case here, though. There are just too
> many hardware variations to check for. I just wanted to point out that
> the reasoning is incomplete.
> 
You're right, I hadn't thought about the 'clear on read' case.

I'll use ksz_read16() only for the KSZ8463 to be 100% sure it won't 
break anything for other switches.


Best regards,
Bastien
