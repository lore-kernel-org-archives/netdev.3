Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768CB19D065;
	Tue, 29 Sep 2026 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642989; cv=none; b=hEya3gEmGlGDg6i3Ay+z839ixTQ/oG5ZWM1OSfvTq2SvVge4h4GszULh1ZJHZ+/9CpPd50ogo0NXrEPwHcUCumFIE8tElKwQFKZDEE+GFpEIrDBTvJeE+p0iFzsXvCwpVstrWfuFCa9nx5hoxtJ1vEIkP8wOw66xgPk2ceQeFUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642989; c=relaxed/simple;
	bh=phHO8us2QASc5xZsc2sDVgZ211K6KVlDHNQDvnvnkMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxuhrvFQCHwJFRuJk9mv7EeHpEHordwwNV7qKGJXnrbqhnI4iNnhMnxkMLl1LrXYJegK7/CXEul+KqBDk/89Rpj4g8y/gimWGIGsRR6qrSIS3WBWLsMR9HK+vib14nQiJFIbeddHlB5ZK2DyIz4dKCHz+5C6WiAwQlihMhCoGaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08338112|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0415592-0.0117084-0.946732;FP=16925596808252007733|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=20;RT=20;SR=0;TI=SMTPD_---.jQhq37y_1790642973;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jQhq37y_1790642973 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 08:49:35 +0800
Message-ID: <46319153-5dd8-42f4-bd3d-c01e122cf218@motor-comm.com>
Date: Tue, 29 Sep 2026 08:49:32 +0800
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
 <24cdb178-7a94-487b-9f8a-42ba984e10bb@motor-comm.com>
 <20260928-valium-gents-cbf9a4fdbdcc@spud>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <20260928-valium-gents-cbf9a4fdbdcc@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/29/26 00:25, Conor Dooley wrote:
> On Mon, Sep 28, 2026 at 09:43:48AM +0800, Kyle Switch wrote:
>
>>>> +unevaluatedProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    mdio {
>>>> +        #address-cells = <1>;
>>>> +        #size-cells = <0>;
>>>> +
>>>> +        ethernet-phy-package@9 {
>>>> +            #address-cells = <1>;
>>>> +            #size-cells = <0>;
>>>> +            compatible = "motorcomm,yt8824-package";
>>>> +            reg = <9>;
>>>> +
>>>> +            phy-mode = "internal";
>>>> +
>>>> +            ethernet-phy@4 {
>>>> +                reg = <4>;
>>>> +            };
>>>> +
>>>> +            ethernet-phy@5 {
>>>> +                reg = <5>;
>>>> +            };
>>>> +
>>>> +            ethernet-phy@6 {
>>>> +                reg = <6>;
>>>> +            };
>>>> +
>>>> +            ethernet-phy@7 {
>>>> +                reg = <7>;
>>>> +            };
>>> Unless the addresses and numbers of phys are entirely unconstrained, I
>>> think you should add some pattern properties for them.
>> Ans: I'm somewhat confused on this point. What might the pattern properties
> There's no need for this "ans" business, the quoting makes it clear
> already.
okay, thank you.
>>          you mentioned include? Could you provide more detail? thank you.
> On second thoughts, there's some basic constraints already provided by
> ethernet-phy-package for this. Probably don't need to anyhting specific.
>
okay, based on your suggestions, the next version will be modified.
