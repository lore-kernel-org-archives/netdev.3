Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586083264E9;
	Mon, 28 Sep 2026 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559851; cv=none; b=FEQ1ozzpvR+pkCb3x3mO82F4SdPp23It/dDzI5l32ICSlDUUNccTBTIUmKKQWnTzcQa8LjYhx3crG/w1HlOJHnNp1qvz2sbSihlQBrdgBk7cIMshWSiLOPp+7ZA07ZOdPdxQPi8+1s7uf3bvn+Kgt6SWdNpItOClIQBHfdcfn90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559851; c=relaxed/simple;
	bh=efSUk6AE2PleoNROsz51zl7Oh9s8rF2qCon4OZEEy2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BeW0dRTjNEgCbaJaRPrmShffhiJGL51Ot+1sc1ZRfbKvPdkiX8qaKfrjqxCDOxoe+qI3ZRkJnmCibuvYhy7tV7yW1byxzLnRWVy/J9nQNQ9ivhlCJgR76KFlvYwgCD1KnWGro7EfYaCsHpvR8xVtSbqHPnYGu+uhKP3h4387Ft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0748968|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0236239-0.00567962-0.970697;FP=7125214396166179889|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=20;RT=20;SR=0;TI=SMTPD_---.jPe.ris_1790559829;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jPe.ris_1790559829 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 09:43:58 +0800
Message-ID: <24cdb178-7a94-487b-9f8a-42ba984e10bb@motor-comm.com>
Date: Mon, 28 Sep 2026 09:43:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v21 1/3] dt-bindings: net: Document Motorcomm
 YT8824 PHY package
To: Conor Dooley <conor@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260924075048.4060414-1-kyle.switch@motor-comm.com>
 <20260924075048.4060414-2-kyle.switch@motor-comm.com>
 <20260924-vowed-roulette-abda42cec444@spud>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <20260924-vowed-roulette-abda42cec444@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/25/26 01:07, Conor Dooley wrote:
> On Thu, Sep 24, 2026 at 03:50:46PM +0800, Kyle Switch wrote:
>> Motorcomm YT8824 Ethernet PHY is PHY package of 4 PHY-s.
>>
>> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
>> ---
>>   .../bindings/net/motorcomm,yt8824.yaml        | 69 +++++++++++++++++++
>>   MAINTAINERS                                   |  2 +
>>   2 files changed, 71 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
>> new file mode 100644
>> index 000000000000..fd62b309e7ff
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
>> @@ -0,0 +1,69 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/motorcomm,yt8824.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MotorComm YT8824 Ethernet PHY
>> +
>> +maintainers:
>> +  - Kyle Switch <kyle.switch@motor-comm.com>
>> +
>> +description:
>> +  Motorcomm YT8824 Ethernet PHY is a PHY package of 4 PHYs.
>> +
>> +$ref: ethernet-phy-package.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - motorcomm,yt8824-package
>> +  phy-mode:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    enum: [ internal, 10g-qxgmii ]
> This should be after ref, but also have a vendor prefix.
> Additionally, the qcom ethernet-phy-package user also has a mode
> property. Net folks, should this be made common?
>
Ans: okay, The next version will follow the approach used by the qcom, 
package.
>> +  reg:
>> +    description:
>> +      The absolute MDIO address of the YT8824 shared top extend
>> +      register block.
>> +      For internal mode, this is fixed at 9;
>> +      For external mode it is (base MDIO address of the four
>> +      member PHYs) + 4.
>> +      Note that this is NOT the base ID of the first member PHY.
>> +required:
> Please use blank lines between properties and other elements of the
> binding.
>
Ans: okay.
>> +  - compatible
>> +  - phy-mode
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    mdio {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        ethernet-phy-package@9 {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            compatible = "motorcomm,yt8824-package";
>> +            reg = <9>;
>> +
>> +            phy-mode = "internal";
>> +
>> +            ethernet-phy@4 {
>> +                reg = <4>;
>> +            };
>> +
>> +            ethernet-phy@5 {
>> +                reg = <5>;
>> +            };
>> +
>> +            ethernet-phy@6 {
>> +                reg = <6>;
>> +            };
>> +
>> +            ethernet-phy@7 {
>> +                reg = <7>;
>> +            };
> Unless the addresses and numbers of phys are entirely unconstrained, I
> think you should add some pattern properties for them.

Ans: I'm somewhat confused on this point. What might the pattern properties

         you mentioned include? Could you provide more detail? thank you.

>
> Thanks,
> Conor.
>
>> +        };
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e3ce77c839b0..ed7af1bd9521 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -18409,8 +18409,10 @@ F:	drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
>>   
>>   MOTORCOMM PHY DRIVER
>>   M:	Frank <Frank.Sae@motor-comm.com>
>> +M:	Kyle Switch <kyle.switch@motor-comm.com>
>>   L:	netdev@vger.kernel.org
>>   S:	Maintained
>> +F:	Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
>>   F:	Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>>   F:	drivers/net/phy/motorcomm.c
>>   
>> -- 
>> 2.25.1
>>
