Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0460388E55;
	Mon, 10 Aug 2026 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348533; cv=none; b=GO1/4iehCnuXkqtxEEIB6itWx08zAO1TclaGHnjjdN+bnzxJEkKYU/4lT52e0587y1DTOWrDztzLeJmYRGZFLoVrKPmbxxUxy46kg55I/nfEe+DZQGAY8XcuJNzcDa0Y1B6qb0916V2fiKvnHVmxF6wMIEbjk+TRyApdP1As5YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348533; c=relaxed/simple;
	bh=S4dZUy84ansteXj3J/r2ZjzvSdLzFwEggQRJhGWqFH0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KZiJ3Q0YvXlO2hkJFSguA+G5FasCxLw5MqI271Mz0QQRqBddJ1qgTP9zikb+/8EYMPR9yQIt8CQLVJW1EQTk4CwA+4XP/WEnE8LBWzIpA2oSz4eK4ZKOd0dz4VgzlcCWIvIROhgWuveYgCRLQq9Yz/hqHSkprIvIGx6YzP1h1B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpGXD7q9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpGXD7q9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C29E1F000E9;
	Mon, 10 Aug 2026 07:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786348532;
	bh=kBLbIMgTXqINzSs76AQPCvPUga9OZFpNe9a8KjfvCuw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=LpGXD7q9dZZxtKlc5vTIWPheMBSrbxk8BWAVqruydo8JBkbpot8OkXjSNIT0EGIp7
	 DRc7lFbPbtvPoAQtQyCZVW/dyEkvEX1u1Kqb0/MArv1CXrBFmb6/Gltg0C/fupwf39
	 5mhfR1OXhAFH7Mh6Vo/SUWS1ap569zup/F/S/ZVKy7Ul4NpcwEJOIewaI6cNWo3yL7
	 t3C/zXIv/MBQzw26/qTohklhh0jBrK3xT2R8erD4Utkbtc3V/QYrQoDiFePbjbwo/c
	 TS6f8JXK1XrSKs8qLt7Hc6kVMmtGbzySuZPTJ4PFNFcf2W5KRt4u1tDpD8q2fDDZXF
	 VWdmWvZlXVaNA==
Message-ID: <f2183f1f-f690-4721-9e91-4fefd56d1b89@kernel.org>
Date: Mon, 10 Aug 2026 09:55:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] dt-bindings: net: wiznet,w5100: add
 link-gpios
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?UTF-8?Q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net>
 <20260806-wiznet-link-gpio-v3-2-532d4a143805@marmottus.net>
 <20260810-arrogant-anteater-of-economy-ef2078@quoll>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260810-arrogant-anteater-of-economy-ef2078@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/08/2026 09:43, Krzysztof Kozlowski wrote:
> On Thu, Aug 06, 2026 at 05:00:01PM +0200, Arthur Crépin Leblond wrote:
>> Add the link-gpios property which describes an optional GPIO line that
>> can be wired to the LINKLED pin of the w5500 as an interrupt to detect
>> link status changes.
>>
>> Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
>> ---
>>  Documentation/devicetree/bindings/net/wiznet,w5100.yaml | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
>> index 641c9ddbde9e..cebf437ad3c4 100644
>> --- a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
>> +++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
>> @@ -35,6 +35,12 @@ properties:
>>        however, board designs may need to limit this value.
>>      maximum: 80000000
>>  
>> +  link-gpios:
>> +    description:
>> +      An optional GPIO line that can be wired to the LINKLED pin of the w5500
>> +      as an interrupt to detect link status changes.
> 
> The message is confusing. If you describe it from the host (system point
> of view), then interrupts are not GPIOs but "interrupts".
> 
> But maybe this is OUT GPIO from the system to the device?
> 

So I read your driver and hardware datasheet. This is not an interrupt,
just output pin, so drop the "interrupt" wording here.

This output pin can be wired to LED or to GPIO on the host side, so
ideally this would be mutually exclusive, but representing this as GPIO
is fine for now. Description could be:
"Active low LINKLED output pin reporting status of the link"

Best regards,
Krzysztof
