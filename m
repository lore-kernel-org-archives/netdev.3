Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C10353EEB
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749769; cv=none; b=Myb0f6DqhPl07yS3yyzPHqYCtbNNzJdIVNgUliTSRyBe3S17YSWdlNv4kfCrs3i93kRiDcGuawru8XDas7503OhT2t0sGscs5WhFBBcCNsTmwRUtKwN5lG/7vj87/ivYwmeygXRjoyEU6rfHwIljwe+lhnszr+BlCA5l4Ji0F1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749769; c=relaxed/simple;
	bh=DIypUq1aJTPaT29le8aCgDPQ3iCMvwD2dB3kusCe9rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAHbrwD1VF6Ri+aAIa5IeTxMv5bOek+HKRR00tz7UciAFpPXvRHjOzfY5kMnBYV7uvZvGwTQ7JRkos6Jbw1Tb9n3l7G5VNJkO4XI+N4uFctZhABcnfopMDc+uf58fbQcfZ4ibcDf8CkvhEZwLBj7OFPMvO2xTJnm3t84Tt4c6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elwoGOhJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elwoGOhJ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so94742565e9.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784749766; x=1785354566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jxGkMmrfkSCmCjSyz4Fz4f0WolkDFwEimPgOqfycITM=;
        b=elwoGOhJmTy7zCjxXnKHVj+k3Ey0M+VMBNSZRSsRqlh5s0Sspj4e9KDlXzbobtWwfr
         A/Tq6JpFU4LQnqdnfoptoFO7LP0syEslbLJAFx2/rxpo4N9TAbEMp0CTLevIx6k9hiwQ
         /e3OukE/OO3Q8+JJpB9xZu0ASnJzmQYYCckcdYdq7IP+ZX2y54+h16vZ7Q3kQMMhww1t
         GQmcE9USUxS/zyAUO4f2V5/A8FEKwcJT6LcyNNssIYI3XeO8bq1rkpIe/6OOQT4W76ZB
         ZLFNpPrxjZCusVj2E8mOR5sHfiBW28RFeJghuffObCnWlGLL23dzOwIcNw46iVrZUf0S
         dSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784749766; x=1785354566;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jxGkMmrfkSCmCjSyz4Fz4f0WolkDFwEimPgOqfycITM=;
        b=aMHePtllSo+hLisSJa7+Dt3RE3ObhauzlVRWGpC9DfegdzUJDcCMN4JwLqDwP9ArmR
         JUkFzlPCdOFLVVlR5YRgvZ2u6802FDln7N6QqyLxEoU1MYdK7Nsy5x9nZ9XT0Icqx49G
         8YigoZdZwdgRm7C15vMDfwqjLue6a9Vx8/nudavS4hJF7oAwgzjK9WOnC1/5ArHDUVmM
         SQCA/e1Hy7ZmrYK0nHkLngWiws0vf1rTOlRqVF2eKFnmFDjBvwysvYhYIwCK1PKOlbIS
         DoRexhh4UWAst4mC0GaCDIv5XUDVSaGfbGxq7SgVOs+LqQeocawhvb4aTG0kgmBFeLoa
         HaXQ==
X-Gm-Message-State: AOJu0Yw8jg029F+c0BW8BZdJBNufCkAsDh5WEAn3I9jBbuLQqJgNL2ex
	a3jW0dR6uy0H3wyG1BHeqe0GRZCK898vk1hGTrq5jIOq6043B8Xnodo0
X-Gm-Gg: AR+sD12QVNpo1FJTrmwEMzr05yhmVo7jViGqPfRGdUV3md1LdOm5uYNJjIQJpf7GcjK
	JnEz4h07zV9EM52Ke/XL29Y2aNyfypwC53L3Imcqdrc0RaPlRIwr3TJljDCIDVIqRLvBsENraWt
	SImOUs8BttBmK+RWv5YzyjeinXBWXWFAlp9EWnlUiRcoWoCDt/9icvk6EcEauMHxf+smKO5Dt00
	HPXqqI+PVXcccs1X4yxavio8HiVGCqkO5Q1e7hkq6+fSogafdms5UPgUPqIUL1+Ef15dfTGh2m1
	ZQuJIuQguFxqCRc0RnbNbIyhmSMCiGjzUsMKCtWdre0/E4J44/eWr8Q5FL72GQ+8GbL3GXI4zJG
	7C1Bo0z5irPgWf2enjC4OVQeX6/pIV/wq21CBJ5g3Mc4EVXXPo0nTVoLlzSCZN7cv57j4hPv7Qf
	epeDeIXdWWnIzus0TP21uk74X0yDXE1S4mlilyjC5eSe1JcSRqftlhgbvhgOk7ap5dRb+60I/zU
	byS
X-Received: by 2002:a05:600c:2211:b0:495:6b78:6f4 with SMTP id 5b1f17b1804b1-49573cc2102mr920475e9.8.1784749765825;
        Wed, 22 Jul 2026 12:49:25 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f117:4301:646f:5fa9:4c84:901e? ([2001:9e8:f117:4301:646f:5fa9:4c84:901e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a64dsm9204964f8f.1.2026.07.22.12.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 12:49:25 -0700 (PDT)
Message-ID: <3f71640b-9f22-4d0b-9c4d-dc64c397d286@gmail.com>
Date: Wed, 22 Jul 2026 21:49:24 +0200
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
To: Sander Vanheule <sander@svanheule.net>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20260715075530.2491534-1-jelonek.jonas@gmail.com>
 <20260715075530.2491534-2-jelonek.jonas@gmail.com>
 <b3456b41152613ed45bcfde92aff89d0c33fa243.camel@svanheule.net>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <b3456b41152613ed45bcfde92aff89d0c33fa243.camel@svanheule.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 22.07.26 19:49, Sander Vanheule wrote:
> [...]
>
>> +  power-supply:
>> +    description: Regulator supplying the PoE power rail.
> As I reported to Jonas earlier [1], I used this property to define a power
> supply for the 54V rail. While everything was working nicely, I still got this
> warning for the missing vpwr-supply property on the PSE-PI nodes:
>
> regulator regulator.2: supply vpwr not found, using dummy regulator
> Of course I don't like seeing warnings when everything is seemingly working
> fine, but I was also wondering if this duplicated way of providing the PoE power
> rail is a good way to go forward and if the generic pse-pi@n/vpwr-supply
> shouldn't just be used instead. The latter is admittedly more verbose, with a
> property on every node, but going forward offers a few advantages IMHO:
>  * Being able to reserve "power-supply" on the main node for the MCU's actual
>    3.3V regulator (not needed anywhere at the moment AFAIK)

I would probably rename this, mirroring the PD692x0 naming. "power" is actually
too blurry, leaving too much room for interpretation. Still keeping its purpose
to reference the supply that serves the PoE rail for this MCU with its downstream
PSE. Reasoning below.

>  * Being able to take advantage of the generic pse-pi framework evolving to take
>    into account more properties of the parent regulator, such as requesting more
>    power, or ensuring the parent supply is not overdrawn by the combined PSE-PI
>    outputs.

Correct me if I'm wrong but from what I see, most of that budgeting machinery
isn't used in dynamic budget evaluation strategy, which is used here because the
MCU does budgeting on it's own. Using vpwr-supply on each PI still buys that the
supply is enabled and ref-counted by PSE-PD core, and keeps potential for what
might come. But no requesting, allocation or deallocation of power.

Given that, I had a closer look at PD692x0 and it seems, this has a similar setup.
The difference here being just that there's no multi-manager concept. There is
also a manager-level supply reference "vmain-supply" which the driver reads
and applies to the hardware, which does budgeting also in hardware.

Based on that, I would just adjust the binding to more suitable name for the
supply. Implementing the power budget application to the MCU is fine for a
follow-up. All boards I've worked with so far already have a pre-set safe budget
in their default configuration, avoiding any potential issues or physical damage
due to overload.

> [1] https://github.com/openwrt/openwrt/pull/23222#issuecomment-5032841546
>
> Best,
> Sander

Best,
Jonas
