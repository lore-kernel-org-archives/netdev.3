Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035B53A7F4A
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784877530; cv=none; b=XjaiWVp6vk33KIEG2abI6zYUswuN8pfqae80HdJLrPiqT+Y3h9sRvKeGqEF9pueNc/i3DGGcLStvDpgze2PKCnicGzYoXbc+VoPJLlB/SAziUxvD/C7q5xDGOossGPD4jtvGjgx+skw4qCAdkfOWgu5CNlhmAv7/q8yXA/Hzeeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784877530; c=relaxed/simple;
	bh=OADtKjXuEnpdtdROI1zJm6WD/sxOV8pEklUgAu6sTVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGv39US57LtaniDHBneodhDwzz2WVI0ZjvAsBfszPjs7zsMIkU7H8RznFB/C60qc6qTc4m/68LSJQmz6F/anqT8m8OF552fq5xymp3G0VCxpWMI2NW28vYpypyG3kC3DwQhbQlPJia6fPdkJzSjLodALZ1yE//Y11xekFp+O1No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ln9NDP0F; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ln9NDP0F"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so109396f8f.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 00:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784877527; x=1785482327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iPrcNCAFpSMjvRTC4lqNm690NiiTuf14UlgUWIGL5FM=;
        b=Ln9NDP0FaONqFLTD6DllOHERZPAg5Po96u7+FatW66FAQmqVeavjGktq2vmKqqJbLO
         wv1W1gy2Ksjp+YqbDPbJiAK4pLSCp3/CKZ3mIzz0CSEJm0CuTv1Q5yX6SCCWnHveHBA/
         RI2TzBm1O5dCkiE5bXgT6xo5FVrVFGjsThpzdsE+DRB76VqlkbhGVtxARm7GaEMVHgQM
         i2LQzTgW3b2mOvJL9I+EWHn6O29kaF+Bcbp65O4sLf6XVoZhAKV1QuReojB8I0Mfoe+8
         UR/g/8kCImM0dA53EdARexpXnrjYJ5VdeDJ9qXc+SJniyq6s3YDEj+itTHlwRTID08Mg
         s+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784877527; x=1785482327;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPrcNCAFpSMjvRTC4lqNm690NiiTuf14UlgUWIGL5FM=;
        b=O3CKLmLpGJJpj3IODT2Ev7NVSYQh/NYF5Atj4yt4uUErTey/NrpxESwQ3rV2GjfX+/
         Nj9c3PZJ8OETGfYGIlGIcRgHlc8h5zri+3T78PmkZ1u00gpc4sLYEdXc9BfmdWRZXzsq
         ZGza3bzSuHGL9womkTzU1r2KlomEqaRRGwmu8GuzddSrrKgrCdCWgTYQPMNu5CcjRInU
         cqLhTqHOArTXi0Pwuj8tDeQ0BwqJ4RQG1yLHTOPxt6osRTpwsf32G9W4Zqq+DuN414ov
         rcTftAlbKNqu7GjixXlofMCpZ7cRtwqrHFtEv6Y+XsSNJxyO+7ST0pBLCPuMwuF0thCG
         YBdQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMbqHgMwMGDLmo7o4KTXsHDqeQdei7tBV+P6a6kFI2QmclqEBrlr+cbLziPWmSMFIb/BYVR3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvh1va2yHhYsXvNUNXdiIMYePL0lo0WhtxsyWo0hCRyYF7MMXS
	TQhPec1Ql4ltouaUqWf8v+KSjFk5DJdHGoCA8Kzq/a/zjNAyiKNbuhXd
X-Gm-Gg: AR+sD13SRhjKMSb4jdWIehZhf81bDzZzSR9rY1iAQi79WoYHtCTiChZOko/3IDaN8of
	3n47BoLLzeKx6oRQeEHsRx+4hE/PCU6FZAQwJBOotMNoxo08wv3HOtWS2QTHTeRTozSm5BcQYa1
	TbhquZpmhSHERbORKBxmgYiaiHExqfBAPAL5mD1/G4cffh+aKoE4G782lM5jreP3WSsrc7MfawB
	jFaY/jB40oj1H9tiiOyB16gviejTxHjdaK/Dj0iBxXFbIIKCDCqyIbSb5+9L8Z4cLEnqjbXv5Xt
	8RpI5PqsU06+fKp4ytHSEEe0gf6C5xFNEhXkbo8RSx1EHsf1B2IaqPn1fsnCX9q+25k4mrdCgQt
	8BtZnrs7uMSKQqVNW0FxUSTxGGBPw5d8tP2/ZmSNj1w5q9Vp4KSVqZJwwGVxLbsVlJmg24ok5HB
	87/BD3+VnL3zRLPoHrtikb3jcAbeXG3YaW0+bIvDV5gjqqUmF6boMOGWWUo/ujv/bTFxVv4ITjz
	0fpV2xo5Jgi
X-Received: by 2002:a05:6000:4a17:b0:47f:5c33:5eb9 with SMTP id ffacd0b85a97d-47f8d7702d1mr7536638f8f.52.1784877526867;
        Fri, 24 Jul 2026 00:18:46 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f123:1f01:c8e:3904:f911:945d? ([2001:9e8:f123:1f01:c8e:3904:f911:945d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a596sm22254724f8f.4.2026.07.24.00.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 00:18:46 -0700 (PDT)
Message-ID: <e7f50ff9-b5e3-4247-bef3-c0cc3581a50b@gmail.com>
Date: Fri, 24 Jul 2026 09:18:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 1/4] dt-bindings: net: pse-pd: add bindings
 for Realtek PSE MCU
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sander Vanheule <sander@svanheule.net>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Golle <daniel@makrotopia.org>, =?UTF-8?Q?Bj=C3=B8rn_Mork?=
 <bjorn@mork.no>, Conor Dooley <conor.dooley@microchip.com>
References: <20260715075530.2491534-1-jelonek.jonas@gmail.com>
 <20260715075530.2491534-2-jelonek.jonas@gmail.com>
 <b3456b41152613ed45bcfde92aff89d0c33fa243.camel@svanheule.net>
 <3f71640b-9f22-4d0b-9c4d-dc64c397d286@gmail.com>
 <amHEgOAWYXYuZwnl@pengutronix.de>
 <beff7c47-ef14-4108-a350-fb07bd56e166@gmail.com>
 <amHq0XuK2y-mcfmD@pengutronix.de>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <amHq0XuK2y-mcfmD@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Oleksij,

On 23.07.26 12:20, Oleksij Rempel wrote:
> On Thu, Jul 23, 2026 at 11:45:20AM +0200, Jonas Jelonek wrote:
>> [...]
>> What do you suggest? I would like to avoid doing any half-grounded claims
>> or assumptions here while not fully overviewing the whole picture. At the same
>> time, I have the feeling the datasheet and host command guide from Realtek
>> are genuinely trying to fool me.
>>
>> The setup seems to be very similar to PD692x0, we have multiple managers,
>> managed by a controller (the MCU). The MCU mostly does runtime discovery
>> of the downstream managers, so right now there is no apparent need to
>> have the same manager + port definitions in DT as PD692x0.
>>
>> In reality I haven't seen a board which has different power rails for different
>> managers. So there's usually a single wire from the PSU going to the PoE
>> daughterboard where everything lands on a single supply PCB trace. The MCU
>> has a multi-bank concept, however it's usage right now is rather confusing.
>> Managers seem to have strapping pins which tell which bank they use, and on
>> the MCU side one can set power limit for each bank.
> Current PSE framework already has a concept of power domain. Depending
> on implementation, the "manger" can be the weakest point in the chain.
> For example: one manager has 8 ports and can handle 200W, we have
> devices with 2 managers each 200W max and PSU providing 500W. If we
> attach 3 devices 100W each to ports 1, 2, 3 - will not work for the last
> one. If we attache them to ports 1, 2 + 9, will work just fine. Because
> it is attached to different power domain/manger.
>
> Even if this information is hidden in the MCU. It is usable for admins,
> to understand what combination of ports should be used for optimal power
> delivery.

It is not hidden, but I see two ways to surface this right now:
(1) Someone figures is out once per board and puts that topology in the DT.
(2) Runtime topology detection, the MCU tells us how many managers we
     have, which downstream addresses they have and which port lives on
     which manager.

I'm not sure what is preferred, having it in DT or using runtime detection
if possible.

>>> Since we already talk about power budgeting - all of this make sense if
>>> we have port priorities. For example PD692x0 firmware has default prios
>>> bound to port numbers. Is it the same with this firmware?
>> Looking at several switches, by default all ports have a priority of 0 assigned.
>> Thus, no pre-defined prioritisation, it's up to the user to set this.
> Do this switches have PSU covering all port at max load or it is over
> provisioning by design. 

In most cases it's overprovisioned by design, the PSU budget is usually lower
than what would be needed for all ports at max load. Even one of my switches,
having a PoE budget of 400W, has 8 ports with 32W and 16 ports with 60 W,
managed by 5 managers. Usually a manager is not overprovisioned but the
system PSU is.

> Haw it behave in reality If we attach more
> consumer then it is able to handle - all ports go off, or only some of
> them?

That's a good question ^^. Unfortunately, I do not have enough PoE-powered
devices here to test this scenario, or at least it takes a bit of time to get
enough devices.

>
> PD692x0 firmware has user configurable prios - but if many ports share
> same prios it has internal prios based on port number.
>

At least I'm not aware of that but since the firmware on the MCU is a
blackbox, in the end this could be the case too. But it's not an obvious
feature.


I'd like to slightly adjust the bindings, given the confusion about the naming
that came up with Sander. Is there anything else that should be changed? Or
is everything else in terms of supply, budgeting, etc. fine for follow-ups?


Best regards,
Jonas
