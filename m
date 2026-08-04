Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B403A38F653;
	Tue,  4 Aug 2026 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785824729; cv=none; b=d2Wazp0I7TEOb+0gViHmrcxb7PTX9len6hbwQw1mHk9phqmkQQlApKUhGHGzTp5h5ZCwIDK4CuAUi00UXEnZqnYqzRYQSNFamE6F1wlmotPt9dCf5CP0uDa6/eRp2f3CPTK/oyasK8aOHeqgVLw5RfaIs13PaY/404D2Fjxz3RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785824729; c=relaxed/simple;
	bh=lPryO3MxFHHeRT6WH4H2dKr1Cv19kVbp7ZuTaqYqXzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/5L9LYqqwTq9W+NxZojBvEWnNklUuh9+IiShxcuA7DwYtdwPbNRIkP4NRTFzBrJI3wgKCjt0tOtS4Jj/jvcYdJi/B6Bj7zwDkyIjavTt7yxUcfKBuFR2fAXjkU7EYkWUxejgR9XSs1TibTkYZHvMXPrvhwlfkOT/yI30WmTHR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAk9QDhe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAk9QDhe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E41E1F000E9;
	Tue,  4 Aug 2026 06:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785824728;
	bh=fGorC68ff84+f7K5aUxjOqih6BHYiODyJZvYALgwCoU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HAk9QDher32vY/44zHYn5z39BisMfo/zfPby2x5M7TfX0xgdv5PHNmU7E7DM5VhkV
	 eTdtmA4n4HqfjseuTxYHlmgKB2dEdO+ArvTpxcxzbk4NZwO+WLfJK+Cq8mMH/3AlCM
	 /9AiPZP6S2dIjq3Q+47hpb0klv3ocSh7uN8M7coRDO1Qq3FqLL1QZoPqLWl+VlRbvx
	 xweiBkhr9pIE6sakJvQwzm+0Pqsp9Kb18WR6CjBaWyKIQr4Fc62EDiPaOJLpRciIuC
	 Btqv3fH2dcYsVGcJjJ1/SXBMGNAxDJ+lsCuB92Zaa9jujLQ8yUuJUIBJER8Jdq8TZQ
	 1OEqm22UA2EpA==
Message-ID: <60ef0086-6137-4e8c-b61b-64e3c833893d@kernel.org>
Date: Tue, 4 Aug 2026 08:25:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
 <20260730-loutish-labrador-of-joviality-6e6c79@quoll>
 <411ec84fd55e152e94ac1f4edba497eac3a5623d.camel@linutronix.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <411ec84fd55e152e94ac1f4edba497eac3a5623d.camel@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/08/2026 18:15, Vasilij Strassheim wrote:
> On Thu, 2026-07-30 at 10:56 +0200, Krzysztof Kozlowski wrote:
>> On Wed, Jul 29, 2026 at 06:36:55PM +0200, Vasilij Strassheim wrote:
>>> Add DT schema documentation for SoC-e FPGA switch devices.
>>> The binding is split into:
>>>  - a switch IP node describing the MMIO register block
>>>  - a DSA MDIO node describing the DSA-facing switch instance
>>> Both nodes are linked through the soce,switch-ip phandle.
>>>
>>> Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
>>> ---
>>>  .../bindings/net/dsa/soce,switch-dsa.yaml          | 195 +++++++++++++++++++++
>>>  .../bindings/net/dsa/soce,switch-ip.yaml           |  54 ++++++
>>>  2 files changed, 249 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/dsa/soce,switch-dsa.yaml b/Documentation/devicetree/bindings/net/dsa/soce,switch-dsa.yaml
>>> new file mode 100644
>>> index 000000000000..a04e2838d14e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/dsa/soce,switch-dsa.yaml
>>> @@ -0,0 +1,195 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/net/dsa/soce,switch-dsa.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: SoC-e DSA switch MDIO device
>>> +
>>> +maintainers:
>>> +  - SoC-e <info@soc-e.com>
>>
>> Nope, as explained more than once group boxes are not accepted.
> 
> That rule makes actually sense. I just saw UNGLinuxDriver@microchip.com in
> several places and thought it wasn't completely forbidden here.
> Will change it to my address in the next version.
> 
>>
>>> +
>>> +description: |
>>> +  This node is the MDIO-bus device entry for the SoC-e DSA switch driver.
>>
>> Node is not for a driver. Explain the hardware, not drivers, not DTS.
> 
> Got it, will change it for the next version.
> 
>>
>>
>>> +  It is a lightweight configuration node that lives on the MDIO bus of the
>>> +  SoC Ethernet controller acting as the DSA conduit (CPU port).
>>> +
>>> +  The switch hardware itself (MMIO register interface) is a separate IP core
>>> +  described by a companion node with one of the SoC-e compatible strings,
>>> +  for example:
>>> +    - soce,mrs-<version>
>>
>> How is this relevant here? do you describe this compatible?
> 
> I will completely rework the documentation to reflect other code changes and
> take the comment into account.
>>
>>> +  See the consolidated IP-core binding:
>>> +    - Documentation/devicetree/bindings/net/dsa/soce,switch-ip.yaml
>>> +  The two nodes are linked via the "soce,switch-ip" phandle property.
>>> +
>>> +  Port sub-nodes follow the DSA port binding documented in dsa-port.yaml.
>>> +  User ports should reference PHY nodes through "phy-handle". These PHY nodes
>>> +  live under the optional "mdio" child node of the switch and are exposed on
>>> +  the switch's synthetic DSA user MDIO bus.
>>> +
>>> +  The PHY-specific properties "soce,mdio-output" and "soce,phy-addr" describe
>>> +  the MDIO bus index and hardware PHY address used by the on-chip MDIO master
>>> +  of the switch IP core.
>>> +
>>> +properties:
>>> +  '#address-cells':
>>> +    const: 1
>>> +
>>> +  '#size-cells':
>>> +    const: 0
>>
>> You need to follow DTS coding style.
> 
> I will check and correct this.
> 
>>
>>> +
>>> +  compatible:
>>> +    const: soce,switch-dsa
>>
>> Way too generic. I understand that SoCe will NEVER - and you certify
>> that - develop a second, different "switch-dsa" model and they call this
>> one like this?
> 
> It is intentionally generic to cover the common basics of all variants and
> configurations of the synthesized switch in DSA.

Compatible must not be generic, as expressed hundreds times and
documented in writing bindings.

> I'm not sure what kind of guarantee I'm supposed to provide here regarding
> SoCe. If switch-dsa is already mainline in the future, then a different
> compatible will be needed for incompatible new models.

I also don't know what guarantee you must provide, it's you who wants to
add an exception.

...

>>> +
>>> +examples:
>>> +  - |
>>> +    switch_ip: switch@80020000 {
>>
>> ethernet-switch
>>
>> And drop unused label.
> 
> I will adjust it.
> 
>>
>> Considering this wasn't tested I should not even give here review...
>>
> Thank you very much for the review!
> I'm not sure what you mean by not tested. I ran make dt_binding_check` few
> times, but forgot to do it after making the latest adjustments.

Untested as it has an obvious failure as reported by bot.


Best regards,
Krzysztof
