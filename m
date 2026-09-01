Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80A372B2B;
	Tue,  1 Sep 2026 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244837; cv=none; b=Yn8P3/zYchOclRxhY3mglUdM2QM0uxpsnngF8S7bAm3udotH+o4/Y3ydihwGWda5qFTSpsXA9QZTPPacvewVg8EHmuM/JUUovqvCdx/ExNRt4kpsebwkaO+lm56mKmiDo2e0Bdc5SRvgpYjE7ELkJ74UBlHbin5u8Kko4pi06sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244837; c=relaxed/simple;
	bh=G14URzXkglvORdKHqO/3JB8Zq+GbOYeHiSg9TdYe4lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VoEdtfROwd4uE7hui7j1JqMRgw6QttS8OoqWro5Se8C3FOKy5x52TROrn6cNN0BoVflHmEtqOX25tp3PINlnR5Bpe7xqA2/uQiSWFUagSDcQrbqfUP0KlMvyTl0JDR0jxuKZXLBdizoUt5xT67Ah5ab1tRNcx7DZO17zggbe5TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4OaW3ck; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4OaW3ck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88A11F000E9;
	Tue,  1 Sep 2026 06:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788244836;
	bh=lPBHNkQTa+bqA8OEnmWufP9T24dGVvNJX1CdFXbGfTw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=N4OaW3cky7XKHghtV2rlxTPp+co4baOYfdxtedE8bsbVfqLbfLoHBHAkMpolb3H4R
	 UNQZscamAbnG15s6d+Cu20Jxs1B9a/u4xIJgVg/V+uvAe66+LDWStQnzx0cbfQKr2t
	 94qbwVjX+leyTEFBzDRMIFmWxJi5G/k8YdWrXOOia7dwhZRqIdrsAeudgGxq+dJoWS
	 3UNomAuJv9QsInP9G/zyV1rLuAq/Ui683JDCiIuM8eQlVDhl2p3hoEJqL4C54Aa1CR
	 3GuQ2i2/q6zq4QuFkYLHuRzsQ/xd0SiLjJVhPXFsr9XYtg6XkolP+svr9BVB+Nk7Du
	 dhQ3CcziSiTGw==
Message-ID: <f5aa313d-0e23-41fa-b59b-9388839b2525@kernel.org>
Date: Tue, 1 Sep 2026 08:40:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: ptp: Document the TSCSS on Qualcomm
 Lemans and Monaco SoCs
To: Imran Shaik <imran.shaik@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Taniya Das <taniya.das@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260727-tscss-v1-0-beed14e72510@oss.qualcomm.com>
 <20260727-tscss-v1-1-beed14e72510@oss.qualcomm.com>
 <02792987-7ad8-4a6b-81ad-559c63174bb0@kernel.org>
 <640acacb-1704-4ee6-aa34-d6be3b30b44b@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <640acacb-1704-4ee6-aa34-d6be3b30b44b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/09/2026 08:31, Imran Shaik wrote:
>>
>>> +  clocks:
>>> +    minItems: 2
>>> +    items:
>>> +      - description: TSC AHB configuration clock.
>>> +      - description: TSC global counter clock.
>>> +      - description: TSC ETU clock.
>>> +
>>> +  clock-names:
>>> +    minItems: 2
>>
>> Why is this flexible?
>>
> 
> Actually, the TSC block can standalone work without the ETU support as
> well. This ETU clock is require only when we add the ETU slice sub
> nodes. Hence, keeping the minItems to 2, excluding the ETU clock.

Hardware either has them or not. Whether they are necessary to
prepared/enabled is independent thing and job for the driver.


> 
>>> +    items:
>>> +      - const: ahb
>>> +      - const: cntr
>>> +      - const: etu
>>> +
>>> +  interrupts:
>>> +    description: Summary interrupt raised based on external event for any of the ETU slices.
>>
>> Please follow Linux coding style.
>>
> 
> Sure, will update.
> 
>>> +    maxItems: 1
>>> +
>>> +  interrupt-names:
>>> +    items:
>>> +      - const: etu_summary
>>> +
>>> +  assigned-clocks: true
>>> +  assigned-clock-rates: true
>>
>> Drop. From where did you take it?
>>
> 
> Actually, we need these properties to be present in the DTS to take care
> of the clock rate requirements.
> 
> Please suggest on how to handle such requirements.

Why does this binding has to be different than ALL other bindings in the
kernel? I am not talking about DTS now.

> 
>>> +
>>> +  "#address-cells":
>>> +    const: 2
>>> +
>>> +  "#size-cells":
>>> +    const: 2
>>> +
>>> +  ranges: true
>>> +
>>> +patternProperties:
>>> +  "^etu-slice@[0-9a-f]+$":
>>> +    type: object
>>> +    description: ETU slice configuration
>>> +    properties:
>>> +      reg:
>>> +        maxItems: 1
>>> +
>>> +      pinctrl-0: true
>>> +
>>> +      pinctrl-names:
>>> +        items:
>>> +          - const: default
>>
>> Heh? Which code do you copy?
>>
> 
> Each ETU slice has its own external event pin config, so kept pinctrl-0
> and pinctrl-names on the slice subnode. Please suggest if you prefer
> otherwise.

No, from where did you get this code? Why are you sending bindings which
are different then all other bindings?


> 
>>> +
>>> +      qcom,etu-event-sel:
>>> +        description: Event selection value for this slice.
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>> +
>>> +      qcom,etu-slice:
>>> +        description: ETU slice identifier.
>>
>> You do not get identifiers. Please read writing bindings.
>>
> 
> In general, any ETU slice can function with any ETU event sel, and this
> might not be 1-1 always. Also, these ETU slices can be configured by the
> vendors based on the requirements of the GPIOs on the board. Hence, this
> etu-slice identifier will provide the flexibility to configure
> accordingly.

'reg' defines which ETU slice is this, no?


Best regards,
Krzysztof
