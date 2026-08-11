Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5675545517D;
	Tue, 11 Aug 2026 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455473; cv=none; b=GERu7lIPXUMDnVKtTeJPlWTvJoN/LwiDTkQhisxFUX4WQuqXv3X5871R5ZfaA76kFNZo9bGA5EaVV4nmpfEB7JC4cRqq+lE7X0xlqFlZORyoGh/tCccAd4A+GLdYR9WxuV4OHoh69hpgngOgX9DwuodA61vsB5SIhQZytkECIco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455473; c=relaxed/simple;
	bh=uh0+o/p5jGQLpC3F2ehJKZZaXXaghzJ7kLDjKmzdJEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tod8eskeK6iWTaYmFi1xdNpPd2dqkAGEjhl459EAuWuWquBnbty1ITGp2raIbzzZ0BRESC6mNAiFgOfZbF5UwL51yvv4hSoWNl7dxnoGeeZ1vABJ/wJn0vtx+QKfaTJ922ZiYxk2h4nhANnWlnquPLqTxkPClZHsz5kr6Z09Nxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le1ymI6X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le1ymI6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60D41F000E9;
	Tue, 11 Aug 2026 13:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786455462;
	bh=UArm/786/2NmZWRaPIkMj1RTcfpoUlxMmf7R9TVTcIk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Le1ymI6XNhVW0KkYbHRc1HLc7pLeE3KghnVTh6uItsxjUsMsBOeOulv1V+0xjb69O
	 62r+vVrS4bKFMY1MAikWu8XrAmM15LzJWfgrhMpcxC9FvlvkufhuOqMXLsknNS9wZp
	 pqPEscZLiIi5scanl2+QNUeHsNIZTWTwR5VX1xdMptDri+NDIbIw+eXM1aU2BQbphZ
	 T+9s6ypOaIBuHeE5Q6mTVgBV8cWNjWusyxUefppziJI9X6uB2Bk+/TpKzxju60R8QZ
	 VV2C9u8yx6/N+M3Civ8UAA6czTpOmG7kK6wB0XSYrlNnQYC4Q0oPa8wO6EdKs7vb4G
	 O6Dzi/xc1QBcw==
Message-ID: <ab56ed98-5166-4046-a665-1395c92949ef@kernel.org>
Date: Tue, 11 Aug 2026 15:37:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/3] w5100: restore GPIO-based link detection
To: Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?Q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net>
 <9bf826bf-cef8-434c-8fe4-e8724c90a37b@app.fastmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <9bf826bf-cef8-434c-8fe4-e8724c90a37b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/08/2026 15:01, Arnd Bergmann wrote:
> On Tue, Aug 11, 2026, at 14:34, Arthur Crépin Leblond wrote:
>>
>> In the previous version of the w5100 driver, the LINKLED pin could be
>> wired to a GPIO to detect the link status changes via an interrupt.
>> This only works on w5500 as it is the only one documenting its LINKLED
>> pin to hold the link status (on w5100 the LINKLED pin is changing with
>> RX/TX activity).
>>
>> This series of patches is bringing back the link status detection on
>> w5500 using the Link Status bit of the PHY Configuration Register.
>> Additionally, the LINKLED pin can also be wired to detect link status
>> changes and read the register in the interrupt handler.
>>
>> Arthur Crépin Leblond
>>
>> Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
>> ---
>> Changes in v4:
>> - Use directly an interrupt line instead of gpio -> irq
>> - Update interrupts in DT bindings
>> - Address sashiko reviews
>>  - drop devm_ on request_threaded_irq to avoid use after free
>>  - disable/enable the link_irq in the suspend/resume
>>  - only call netif_carrier_on|off if the link interrupt is present
>> - Link to v3: 
>> https://patch.msgid.link/20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net
> 
> Hi Arthur,
> 
> This version looks good to me,
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Krzystof said that he preferred these to be described as GPIOs
> instead, but I think there were some other open questions with
> your previous version. If you can come up with a version that
> Krzystof likes better, I'm fine with that as well.

No, interrupts are fine.

Best regards,
Krzysztof
