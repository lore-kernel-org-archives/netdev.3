Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B802AD00;
	Tue, 11 Aug 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456971; cv=none; b=oM/ir8DgZj3SNsZRrrNkpW0rTJOPUtwVJz0FB/SP3L5Ne6mVuI6DiHmKP6AZ6iIfDSN90ShSKMlYOcBTc/h1sHRBq9pSNHDOd23R1wjqcg88ASynexoBJpXiquEkGyIN/sHnvAzzsnVq6jlqNdEjbBfNLfbtEFGwRqt0c9dhcZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456971; c=relaxed/simple;
	bh=Js0t1IT3eMLOou5xUJZE9ujCwNlS4ni9JLnOal+Laps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGXNWrsqk3d22AUkGvGBkDVm0hUVmWX0oQmm99PrT1K83x0DNBZwDKrY4kEH6xD1CAWXBPolzZ1cHyILTGQ0hUTN7pdS419GR56BPJLy4+8TtPRFYhHh2Ar6y2IOxXqBAFdVnD/eCnn2h3SHw1b7OQxCmYMXW4XPBk+YDvk8soI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=UYXh6tiX; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="UYXh6tiX"
Received: by mail.gandi.net (Postfix) with ESMTPSA id EBD123ECF9;
	Tue, 11 Aug 2026 14:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786456960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmHc1SKArkBiLeCTl7vAS9lSJ0vHcdzEWugvVM8NW4w=;
	b=UYXh6tiXNhQ4qshHYLKbqInOEagvJROBEtkbXsHXezZTTYFW9he7eK/VrDdVQgA5EoZWYw
	l9I0g4SaE++MVb456nj/r4B9UiVKUDtmg69oZzEd2ioq+as9kdORs6jQNaThwenGRHPv/e
	vGde0HzY20XUuFoj5vesEEqtpl+Y2uPOTia+ORHHJD7d0In0Qv7jubRjgZ56HxP/6JyXb6
	w/SLlUJNLSMoRWQG4ThI5T/c2jES5nap+L7eKEy73fUtm/3XLBNWc9lujyEKOIzMhAsVH6
	tHm6WmfxDlBD7M72SdZ5usMa9itLKakh2cLM38bK4IX1CUNy76tedVj+KiV5cA==
Date: Tue, 11 Aug 2026 16:02:31 +0200
From: Arthur =?utf-8?Q?Cr=C3=A9pin?= Leblond <arthur@marmottus.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
Message-ID: <ansrd2nYaWBk-EiK@pc-du-fromage>
References: <20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net>
 <20260811-wiznet-link-gpio-v4-2-4d5f7da885a8@marmottus.net>
 <688f57cd-a098-4904-b8cd-965470a89386@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <688f57cd-a098-4904-b8cd-965470a89386@kernel.org>
X-GND-Sasl: arthur@marmottus.net
X-GND-Cause: dmFkZTF29h7gh2LGGnxjNrXQnL/oenCMurpA5kFcLLJasYLjRv0uv/9d7vwUirNzmcltikBHIfm1gQyEBGz7B4yNMRO41GPFFznJfeo8pDJiwWmepSxYXAPBe8iqUml2SdoEuroLQY/wfmTClMhyZQ3S09+ufIH/GW1PHmE61B6iNh7TWxlGIMmPWLwdFv9C39GdRVpS5lbSv2zmlKE9ymrHYXYubl8J07xYN6+JAGk0KbWJ/DAONKwOm1Bl0l0yO0As6Dcy+YG5n/uVd0d9bU5GuPwi4Fz5I1/UqXd3EwsQ8rBm23RoXcKwfTHfOejnnW6FahOPe7SlPHTQsrADzVjk1oFlI1ngdaKRZE+x6lH+lOYmbefW1Tt8Asqynh/SX11XNKKEHqw71LZOALvY1U8ly+ahtwT1U8wludWFLspIuQBVXxDxo1M8+uZrqXBp/oDZ2tiH3k5D17sEUFKJOivSnfqqaPU2QBU0Bm6AC/IET+gVwhGRSJtkr7R3JatT48pE9tXGPx4uyvGDr8zIiNYSEmY1m7EOZD0Q4rSyJuxHss8KCnL6sdLKreBEXsd/AlGABi6bg6bNtIzSsatzOUmNDjNSDotGe8Zl61quTJbZVAbdgzrBcPSe/EKc+LPJvqIUNMWq6swxweI1nOfHmVhdPblyX4EkSxtkur7gcP1S4PhG1Q
X-GND-State: clean
X-GND-Score: -100

On Tue, Aug 11, 2026 at 03:36:43PM +0200, Krzysztof Kozlowski wrote:
>On 11/08/2026 14:34, Arthur Crépin Leblond wrote:
>> Add an optional link status interrupt which can be connected to the
>> LINKLED pin on the device to detect link status changes.
>>
>> Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
>> ---
>>  Documentation/devicetree/bindings/net/wiznet,w5100.yaml | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
>> index 641c9ddbde9e..30f013f40a77 100644
>> --- a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
>> +++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
>> @@ -24,7 +24,11 @@ properties:
>>        - wiznet,w5500
>>
>>    interrupts:
>> -    maxItems: 1
>> +    maxItems: 2
>
>This is redundant, instead you need "minItems: 1"
>
>
>Best regards,
>Krzysztof

Thank you, I'll update it in the next patch.
I will also remove the unused gpio/gpio.h include.

Arthur
