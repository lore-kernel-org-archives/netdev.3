Received: from out198-20.us.a.mail.aliyun.com (out198-20.us.a.mail.aliyun.com [47.90.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BC332860B;
	Mon, 28 Sep 2026 03:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790567087; cv=none; b=g0DWNiR+omoxgEVLzp/SCK3ExzM8yh9c+5clGAJzUafFTf/ZHdRGczvxgoaY+KdRcWUhPtus9rIx8FJ/nXOHTeTe+PmNJ4Y+ogEWlFXuSoe/wDEdfOGwcgm/D8j2EIeQ1gWJTttIuzC6CutXyGXz/H7keMPfvO7cRrS4NtQOtPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790567087; c=relaxed/simple;
	bh=k3NAUYz1a1Ry17JwU+0CsD0jTtgOP+BWicNDcz2wIVc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bOFEumGpVA/OVY5A5PyvhhqAMjakIXgBJGGLvbSMoV4oz0SzohQjxBRqsz8vOtKpZpltnnXMRwgFfR3cBqSgst+/EckpP7WYAp/kWgBtEHyn4Deku5URc+0ICNe7gBwkeNgIrWKcKnZlL4AmgeBPgdqiISz2c5NtmDLhrh9EizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07443272|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0253777-0.000750999-0.973871;FP=7701661819171818613|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033022149254;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=20;RT=20;SR=0;TI=SMTPD_---.jPlbUXj_1790566119;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jPlbUXj_1790566119 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 11:28:41 +0800
Message-ID: <34fc057d-17e2-4693-971a-63898708545a@motor-comm.com>
Date: Mon, 28 Sep 2026 11:28:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v21 1/3] dt-bindings: net: Document Motorcomm
 YT8824 PHY package
From: Kyle Switch <kyle.switch@motor-comm.com>
To: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260924075048.4060414-1-kyle.switch@motor-comm.com>
 <20260924075048.4060414-2-kyle.switch@motor-comm.com>
 <20260924-vowed-roulette-abda42cec444@spud>
 <c78999ec-82c5-4719-9358-5dbded43ccdf@lunn.ch>
 <415c6c1c-f59e-41c7-9045-22f20408a7f2@motor-comm.com>
Content-Language: en-US
In-Reply-To: <415c6c1c-f59e-41c7-9045-22f20408a7f2@motor-comm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/28/26 09:45, Kyle Switch wrote:
>
> On 9/25/26 03:16, Andrew Lunn wrote:
>>>> +$ref: ethernet-phy-package.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - motorcomm,yt8824-package
>>>> +  phy-mode:
>>>> +    $ref: /schemas/types.yaml#/definitions/string
>>>> +    enum: [ internal, 10g-qxgmii ]
>>> This should be after ref, but also have a vendor prefix.
>>> Additionally, the qcom ethernet-phy-package user also has a mode
>>> property. Net folks, should this be made common?
>> phy-mode is definitely wrong, it has a different meaning, and reusing
>> it is just going to cause confusion.
>>
>> qcom,package-mode does have the same meaning as what is trying to be
>> expressed here. So yes, a common, vendor independent property would
>> make sense. It maybe should be in ethernet-phy-package.
>
> Ans: okay, In the next version, I will revert the previous
>
>         implementation and follow the qcom,package-related approach.

Ans: Another question I'd like to get your opinions on. The usage modes of

the phy8824 are not as numerous as those covered by the qcom package.

What we're trying to express here is simply whether it's a phy8824 built 
into the switch or

a standalone phy8824. In both scenarios, there is one 10G serdes 
outputting four UTPs,

and the only difference is that some operations are slightly different, 
such as soft reset,

power down, and power up. How should these two types be defined and 
identified?

In a previous patch version, the "internal" and "10g-qxgmii" modes were 
used to

represent them. Andrew pointed out that "internal" is already a mode 
included in phy-mode,

which could cause confusion, so in subsequent versions phy-mode was used 
directly.

Now phy-mode needs to be replaced with a vendor-defined mode, but since 
the meaning

is different from what qcom expresses, it's not good to make it a common 
definition,

so we'd like to ask for your suggestions on how to identify internal vs. 
external phy8824 more appropriately.

>
>>
>>     Andrew
