Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2AE41D227
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065764; cv=none; b=GJPC+kzlmKKrTcyWw/V3Yg0pMVcGp/aKoa8LV/S97U9o45sDqRmLi/FdIdNiQpvJYStG8hWeUrLYBsWiTrdchxSnevrAw8ttIOLXAFIbM4F2FSakb65EjYy1MeUo4dwRJWcjANqTXOUBVX3j+8T9ZayB8ZeAWw3MzEPSb7O7JeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065764; c=relaxed/simple;
	bh=XjGaOIjQ/+IIGGxhFw+k+Tln3i2AhkheoPEyCqqCrug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7vxAmYX7jlPxrsqjqt+oc5n9yZ3oejOstIohvYznV+w83SbAeQaBk+J8QdbPsSUnfO6DE9LdMVSnoSIXXdyQ/881O1ytZt/IEsqxj74i42HY/Ti+YdP0Y1956Gym2zZDiLyl/syzOBcVeCNiARxKnh7oiEdjumUqWv5c6F6Jj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpcGQEWx; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpcGQEWx"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a17f91so7187161a12.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787065760; x=1787670560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Azjl3irT73V/koc25uPISYBKISfWZZT+yRNGdczt0Kk=;
        b=gpcGQEWx0DIri5vx9fOyVxr/ZHf//ax/xWkqmxy0M3GU6AW5LJqAru35z+xRV6VbBD
         V8MF0SIfRT1CvAJk7CzGGKg/wS2g2Wzhq2k30TVe2hAzKYXYRxjqd7XmVkQPuPOurC1r
         OquVPqXohx7S2q8OJWhBhj9Lpt4rETlz5cAjvlBdBmJR1Bw9jEzkETYKDd5DRG6oK1Pf
         7JEiRrpr4PsT10qu8wkNqUHILawhaTuO3Dn91j6TbpbRz11wqhwe8qfbf1comUOlAuB4
         OK5YJYg4Jp00Po17u4hL/CGVU9vWWahAWPXzUgttrc+K8L6ENLtAqqDckZGXeOB5sKz1
         MWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065760; x=1787670560;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Azjl3irT73V/koc25uPISYBKISfWZZT+yRNGdczt0Kk=;
        b=ONSiEiGixOwO9BSSHqbmXjUiBQFgrI+Iy/wfbfxR/8hESJj/pEuNgQXD8d5AiPt+vc
         nA01cLUGm8+H4t8QrrxEv+Prhq5LmKHhbZYHAaFDvYjuwP8alOZW4V3zwORxF27jKmWr
         4dYqh1/WS41a6geA1wDhqm9zBQprc9cOpvqTJXyQQaDQ1ZU7+/NhA9NHRjpLWGY6Wxvp
         V/tMF6w0mzi36ByekA1OPdCw8EXNndgxflmOlyYkSJfaFy/tUnaeAykrUnIjX4Cc/hkj
         sK9kXrCtEwcAqITgB1dvw0mtLJ4N9G1ENKjgV+xks85mfvdj4y91H/NQDs+4vEQeoUeg
         TBUw==
X-Forwarded-Encrypted: i=1; AHgh+RqiAzEtA8CtL9J7fuzY/GWrXvjvArnGj+Nfu8DxVGt7y0+d/hyx1oqOOjh0lHsklVdndulOsrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJlTKauadmLA1UZq2bxLubfghVIBXCpJV5DurUrjHgwYQHQYY+
	knpkugQ3Tb9CnKwQi4sRcj1E62lYXFKGgCH0sAPMbEqdJDHMQP2B71XB
X-Gm-Gg: AR+sD113E4XY0/9oADgmk8wptq2LpBUHsK/hyzRQLpgQvyXqGpuwMxzJNynNufDGPo1
	IgpW4i7Gror+8GQrACCCT8nhCFC1mej01vxqYf1lDwYmxeNEAjVbkxNeq27/WtJo+4ls+XCe2kR
	nmX9LFfzVCAmfJT+wa+kYisFpadCCb76FNomcu1ZmEgdeMaAOsb3jwZoyvDZouKDyjkPoKjZ8Pl
	+ZNQDNTzUJjoR+U6hm4ehZCfJCfv4WvlzfLc/DppUMUazwCjWdI510hRPLlo5IQ8iT/wquDcN/x
	A4rJOyzAqnfGx+osUQXMKo3/ebXXeKSgF0PcyV0NovWF1f0wP5WmKZsmmKKQwbDfBet0ML9fFXT
	74C80FSUGzNbBVoxiqKmEG2i1yFRNJ7z3gIuvTZjQ4TrG1vr0s8MnnnRMbFIOfFjAPmNNqkIhyl
	qcK/ILxyW1ii7qJY8NIPhBbcfG5jh8Ck6GfU2Ao8BxWrmNUrS+vr7KmzbGsDCugg1W10PChEo6k
	AdiG0zsDCHQ6FFCKMPL9WMlIHpKUplblo3W5erGuw==
X-Received: by 2002:a17:907:928c:b0:bf0:b39:dcc8 with SMTP id a640c23a62f3a-c212a1da2bamr1863469766b.26.1787065760375;
        Tue, 18 Aug 2026 08:09:20 -0700 (PDT)
Received: from [192.168.255.3] (249-9-142-46.pool.kielnet.net. [46.142.9.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c219e360887sm26417666b.61.2026.08.18.08.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 08:09:19 -0700 (PDT)
Message-ID: <9a880656-db90-41ea-bb40-658a878af12f@gmail.com>
Date: Tue, 18 Aug 2026 17:09:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 0/4] net: pse-pd: add Realtek PSE MCU support
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, bjorn@mork.no,
 sander@svanheule.net
References: <20260813222036.873930-1-jelonek.jonas@gmail.com>
 <178705861416.2079194.11658601794072677702.git-patchwork-notify@kernel.org>
 <20260818075920.4580f583@kernel.org>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260818075920.4580f583@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18.08.26 16:59, Jakub Kicinski wrote:
> On Tue, 18 Aug 2026 13:10:14 +0000 patchwork-bot+netdevbpf@kernel.org
> wrote:
>>   - [net-next,v14,1/4] dt-bindings: net: pse-pd: add bindings for Realtek PSE MCU
>>     https://git.kernel.org/netdev/net-next/c/368990e9f6c6
> Was this reviewed by device tree maintainers?

v8 was reviewed by Conor. Since I slightly changed the bindings after
that (dropped a '-supply' property, added a '-gpios' property), I dropped
his Reviewed-by again in v9. No major changes but still a change which
usually requires the trailers to be dropped.


Best,
Jonas
