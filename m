Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2C537BE64;
	Mon, 10 Aug 2026 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350089; cv=none; b=m+tJW530Ooe8ZpGChMGVxcTP0L0+wkqcqcqJKN1NF2nfpRYwEH5ypClicmyQANSq8Mv3Ys3daolpbNXOFiwkAB6NxMEKV0TFVL/slklddNTjlIjHzBpo0YGx8dViePstl2ApqkHsKBNQLbuXorqElwcou1L4vofbR5oW3gl/lC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350089; c=relaxed/simple;
	bh=OdkvWDLa6mr/cK91fIDwDcf8YmdoTFwD//G+QnrLYVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqmD+WSIPMPzcr//yAT653B4Tbl5Kr6OK1u6FB83s5lEQ2kWodN2vtxkL+9OIdoxBqzR/VqU5+i0gDN5qEiubd+ZsZ7ukZXRXzK64ujm5yUaN5m/Q+DuvfSlvMe6fOAC+qgblBCV7GyHom01Qi2X/KL3SK1oqEyke5SANrDF9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxuJTifg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxuJTifg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B161F00A3E;
	Mon, 10 Aug 2026 08:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786350087;
	bh=Lnn1PF2iPOyVcDhhxi5TecnoD9/9cIb38+Gj+4lKZLo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TxuJTifgdoGKYpyWx+4Ne4m6xv0Ttl5XlfiWCRrqLm7Xir7ToZquLG9JAtxR/72Xv
	 eLcoLDg32+VnOqqiPoUJEQhGnT4O+KlGlyI/YC5peXqUP45aKq7m45+Aitrs7TW4DE
	 vMYymtzQTcp2lTS+NA3ilbufYshre38JrIJ6jnp75Zl2B9pDapTXo6Q335w+7pxYFa
	 fOCkQd92uPWlWHCM7VfxgDFbe4Bfv1zlsfR9Tfd9ROLsGV/xyrZp16tdG6bi65CD0e
	 Em52rZuLdtQ1tf/LgcTZq7dGotRoF2Xh3qmYUq0cAhSV+Lv+HcxUA+2k2f0AwxexgL
	 f50tjqYKEUSYQ==
Message-ID: <44b4c6f3-3414-47ac-baaf-bca2f68df4c4@kernel.org>
Date: Mon, 10 Aug 2026 10:21:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] dt-bindings: net: wiznet,w5100: add
 link-gpios
To: =?UTF-8?Q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Netdev <netdev@vger.kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net>
 <20260806-wiznet-link-gpio-v3-2-532d4a143805@marmottus.net>
 <20260810-arrogant-anteater-of-economy-ef2078@quoll>
 <9e8fb566-e372-4519-ac0b-b8ca6de275e3@app.fastmail.com>
 <105fcc5b-e1d9-4bd8-a697-2d68e185aa38@kernel.org>
 <anmH0NR42wC4EwG-@pc-du-fromage>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <anmH0NR42wC4EwG-@pc-du-fromage>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/08/2026 10:12, Arthur Crépin Leblond wrote:
> On Mon, Aug 10, 2026 at 09:59:18AM +0200, Krzysztof Kozlowski wrote:
>> On 10/08/2026 09:53, Arnd Bergmann wrote:
>>> On Mon, Aug 10, 2026, at 09:43, Krzysztof Kozlowski wrote:
>>>> On Thu, Aug 06, 2026 at 05:00:01PM +0200, Arthur Crépin Leblond wrote:
>>>>>
>>>>> +  link-gpios:
>>>>> +    description:
>>>>> +      An optional GPIO line that can be wired to the LINKLED pin of the w5500
>>>>> +      as an interrupt to detect link status changes.
>>>>
>>>> The message is confusing. If you describe it from the host (system point
>>>> of view), then interrupts are not GPIOs but "interrupts".
>>>>
>>>> But maybe this is OUT GPIO from the system to the device?
>>>
>>> From the device point of view, it's an LED output, but from the
>>> system side we should describe it as an IRQ_TYPE_EDGE_BOTH
>>> "interrupts" property rather than a gpio line.
>>
>> Then probably we should list all four other pins as well (speed, duplex
>> and active).
>>
>> Best regards,
>> Krzysztof
> 
> We use this line to detect a link change but don't read its value in
> the interrupt handler, we read the i2c PHYCFGR register to get the
> link status.

I know, but won't you have soon the same problem with active? Otherwise
are you going to keep polling for the active link, since it is not
reported through the main interrupt?

Best regards,
Krzysztof
