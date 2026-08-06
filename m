Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7991380FEA;
	Thu,  6 Aug 2026 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998950; cv=none; b=hfstfdPot7Ufncg37m2iNVF5P6kWRHJIKx9naC3q4/8gYGZfyFlDL9jQHFenaV9Hfu+8/WOrhHIbslJYwYWizSLdCGrqgCDe+JzApYDeDZk4qEG5EHqQgv7oXEzFviEH9HGpSAg1SIxamq6NZpoAsvFWDDAK2aIQq4z5Mc6sYZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998950; c=relaxed/simple;
	bh=liepSuCWhET3A51hBZr4UfpyD/X0Yqjo0PxB4LUBEwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHKmPfLE0R/jd72e+B1E8DEZQPzBhqyLaulyrLkiVNcqNIGml3f+jFxZC4eYQQg22cVKMIirA5W7lOVHkv9oyZGFW6onuT4GZu4x9mh+Ed06VGgkgyY/lofnVHgkNp6g9tF4i4WVviY0ADmnGRV5ivCOxxHnP3yySboHxgdIux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUjhy0vL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUjhy0vL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7202B1F000E9;
	Thu,  6 Aug 2026 06:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785998948;
	bh=3aNbsAERipFsx+yzQGv3WCU2Y9Zc5fWn7EPOiXhK8f8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fUjhy0vLKfClXxk6YvO7DPT0idsViF/fGh4Q8xpBEsMQnDrYmDR+FPbrSlP8klYpi
	 CspRJKPJ0NcfRS4q20LNYzEjh2chLl6jfqUnU4f8aN0/lQV1EJG8YpqvQzqTfSmD71
	 2SRYTMjbFvmfdoRa7VjCqWLPGkWbPW8RwEC8zjxHzu5adB0cCv29A14MBKLcVGA+in
	 eqWSuRlIhCWXWL6US0yrikt+i0Dbh3Ji7PIjPqAhmcYHLIklA9l+a7U9YC0OOeOMIr
	 JqJcJ2Z2RCx7QNRjJqrZ8b+y+7tzu+wuSyPgHnYgyqXhgkvq0+lCY13c1DVrNzEQTJ
	 TZTbeNDC6Ma1g==
Message-ID: <b90b8790-b0dc-4383-a9b7-fe9ba3f6edfd@kernel.org>
Date: Thu, 6 Aug 2026 08:48:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] dt-bindings: net: pcs: add rockchip,rk3568-xpcs
 binding
To: Coia Prant <coiaprant@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Vinod Koul <vkoul@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>,
 David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-renesas-soc@vger.kernel.org
References: <20260801142244.679437-2-coiaprant@gmail.com>
 <20260801142244.679437-6-coiaprant@gmail.com>
 <20260805-stirring-wondrous-mule-faf37d@quoll>
 <CALj3r0hbp-zS7Sv-6T3uBOCq2ZO4XZHKvkD4dTZ3gXRS=90JUQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <CALj3r0hbp-zS7Sv-6T3uBOCq2ZO4XZHKvkD4dTZ3gXRS=90JUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/08/2026 19:20, Coia Prant wrote:
> Hi Krzysztof,
> 
> Thanks for the detailed review. Here's my response to each point:
> 
>>> +title: Rockchip RK3568 Synopsys DesignWare Ethernet PCS
>>> +
>>> +maintainers:
>>> +  - Coia Prant <coiaprant@gmail.com>
>>> +
>>> +description: |
>>> +  Rockchip RK3568 SoC integrates a Synopsys DesignWare Ethernet Physical
>>> +  Coding Sublayer (XPCS).
>>> +  The PCS provides an interface between the Media Access Control (MAC)
>>> +  and the Physical Medium Attachment (PMA) sublayer through a Media
>>> +  Independent Interface (GMII).
>>> +
>>> +  The XPCS is accessed over the APB3 bus and internally connected to a
>>> +  Naneng Combo SerDes PHY.
>>> +  It supports 1000BASE-X, SGMII and QSGMII modes.
>>> +
>>> +  The block contains four MII ports (pcs-mii@0..3) that can be
>>> +  individually enabled and routed to one of the Ethernet GMAC controllers
>>> +  via the pcs-handle property in the MAC device tree node.
> 
> 1. Commit message: I'll drop the redundant description paragraph and keep
>    only the essential information.
> 
> 2. Subject: I'll drop the redundant "binding" word.
> 
>> +properties:
>> +  compatible:
>> +    const: rockchip,rk3568-xpcs
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
> 
> 3. reg order: I'll move reg to the second property (after compatible).
> 
> 4. Quotes: I'll use consistent quoting style throughout.
> 
>> +  reg:
>> +    description: |
>> +      Base address and size of the XPCS register space mapped over the
>> +      APB3 bus.
> 
> 5. reg description: I'll drop it as redundant.
> 
>> +  clocks:
>> +    description: |
>> +      Clock sources for the XPCS:
>> +      - csr: APB3 bus interface clock (clk_csr_i), required for register
>> +        access.
>> +      - eee: EEE clock (clk_eee_i), required for Energy Efficient
>> +        Ethernet (EEE) operation.
>> +    minItems: 2
>> +    maxItems: 2
> 
> 6. clocks: I'll change to items with descriptions instead of min/maxItems.
> 
>> +  clock-names:
>> +    items:
>> +      - const: csr
>> +      - const: eee
>> +
>> +  phys:
>> +    description: |
> 
> 7. description formatting: I'll remove unnecessary '|' where not needed.
> 
>> +  power-domains:
>> +    description: |
>> +      Power domain for the XPCS.
> 
> 8. power-domains description: I'll drop the redundant part.

I don't understand any of these. There are none of my quotes. I don't
get what you are referring to.


Best regards,
Krzysztof
