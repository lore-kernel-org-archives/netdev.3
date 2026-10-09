Received: from mail2.kuutio.org (mail2.kuutio.org [91.107.195.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DB6314B6E;
	Fri,  9 Oct 2026 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.107.195.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566649; cv=none; b=JhUW3PXy7/h5rS9k8RtTz9GILJPsUO97QUEntbfTmhbaOtEvrT9idwL/ObmBEhG1T8pCSmY5wzzTW6EB3OtnCjnqloFCfg0USWjYnUPfxzHuElSzOAZGA0siuEGAfiAC1Bt4c2IJyf6KIBJKRYj6CpQv8zaJbv/cpFQxXyKVmB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566649; c=relaxed/simple;
	bh=oF9hTyVe3cCLnrWfkkQN4TjCEJJxhdKESRmDjW1CGTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pdx6lBbWCyg+/63CDpxqfcsabfafyxn+rmgqrgDqW9JXMi3+vijNY8LCRTwJL9AOZClUySS4wVi3R19XemjbnAbATYdURzBsxpPHhzOzGgCpvEAovVHOP1EPUz6sftDiBypSD1qk1oXULwKnT8s90ReQoy5R880n3tDM3p7l9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net; spf=pass smtp.mailfrom=lemmela.net; arc=none smtp.client-ip=91.107.195.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lemmela.net
Received: from localhost (mail2.kuutio.org [127.0.0.1])
	by mail2.kuutio.org (Postfix) with ESMTP id BEBE62040A;
	Fri,  9 Oct 2026 17:24:05 +0000 (UTC)
X-Virus-Scanned: amavis at kuutio.org
Received: from mail2.kuutio.org ([127.0.0.1])
 by localhost (mail2.kuutio.org [127.0.0.1]) (amavis, port 10024) with LMTP
 id 6_KnS5cnMtum; Fri,  9 Oct 2026 17:24:04 +0000 (UTC)
Received: from [IPV6:2001:99a:adc:6a00::8be] (nbqchc6j3dhrbnnpubi-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:adc:6a00::8be])
	by mail2.kuutio.org (Postfix) with ESMTPSA id 8E8B41FD49;
	Fri,  9 Oct 2026 17:24:03 +0000 (UTC)
Message-ID: <94ed7592-cc4d-4a0d-8738-bfbe480e479e@lemmela.net>
Date: Fri, 9 Oct 2026 20:24:02 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: realtek,rtl82xx:
 document RTL8224 packages
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>, Javen Xu <javen_xu@realsil.com.cn>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Aleksander Jan Bajkowski <olek2@wp.pl>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Issam Hamdi
 <ih@simonwunderlich.de>, Chukun Pan <amadeus@jmu.edu.cn>,
 Jan Hoffmann <jan@3e8.eu>, Florian Fainelli <f.fainelli@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Manuel Stocker <mensi@mensi.ch>
References: <20261005201540.913977-1-oskari@lemmela.net>
 <20261005201540.913977-2-oskari@lemmela.net>
 <20261009-tentacled-magnificent-okapi-d5a173@quoll>
Content-Language: en-US
From: =?UTF-8?Q?Oskari_Lemmel=C3=A4?= <oskari@lemmela.net>
In-Reply-To: <20261009-tentacled-magnificent-okapi-d5a173@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/26 12:18, Krzysztof Kozlowski wrote:
> On Mon, Oct 05, 2026 at 11:15:39PM +0300, Oskari Lemmela wrote:
>> +    mdio {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        ethernet-phy-package@1 {
>> +            reg = <1>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            ethernet-phy@1 {
>> +                compatible = "ethernet-phy-ieee802.3-c45";
> 
> I don't fully get why you are adding to the example generic compatibles,
> not relevant to this binding.
> 

The generic C45 compatible explicitly requests Clause 45 discovery,
matching the management path used by the RTL8224 driver. Without it,
discovery starts with Clause 22 and may rely on the conditional C45
fallback, so I retained it to specify the intended discovery method.

However, I see that this string does not select realtek,rtl82xx.yaml,
so the example does not exercise this binding's constraints.

Andrew suggested that a dedicated RTL8224 package binding would make
sense. Would moving the package documentation and example into a
binding selected by "realtek,rtl8224-package" be appropriate? The child
PHYs would retain their C45 compatibles and be validated directly by
the package binding's child-node schema.

Thanks,
Oskari

>> +                reg = <1>;
>> +                enet-phy-pair-order = <0>;
>> +            };
> 
> Best regards,
> Krzysztof
> 

