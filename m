Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345272EEE73;
	Fri, 17 Jul 2026 03:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260086; cv=none; b=tXM2CHO5oR2RDSuQmuKnEco/A1SYaJpTG9ZfesHyJ/OJH30kgeJkLypWOrdNNf4ITilQFTJnC5PmpnefUAbyCuXHssN+4Cz64bFbZxb9bKrXXcj6C9pApSdfsrb4+NkeWRqByNk2lLQ0XUL18W7Ntr7pNQQVevPW4txwIRdY3+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260086; c=relaxed/simple;
	bh=nM++I0WQwv3G6NM7+03O4P19wU4HNG4GtOQjZdRwiFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smqPxtjTwoYZ3HZtklWhUxYXXSVaShvk8gQS01aoMFwiQTq6iKvaMBov5s5e4wFTzoQ7Jxm2ER+gmbf1il8W3ke9HQKvbhYLfvMsEpg9e1DEGAF/82ERAGvBWXWRZpMY4kPD3s6qvRGPdwIMVTqimQYKOPwNHfgmSeCyLf6GStc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1350863|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0982692-0.000545404-0.901185;FP=17291472072129174883|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iNmHfxv_1784260070;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iNmHfxv_1784260070 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 17 Jul 2026 11:47:53 +0800
Message-ID: <f138b88d-2218-48fb-bf16-656662d54507@motor-comm.com>
Date: Fri, 17 Jul 2026 11:47:49 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianmin.wang@motor-comm.com, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jie.han@motor-comm.com
References: <20260714111203.3852126-1-kyle.switch@motor-comm.com>
 <46c380a2-74ab-4690-a289-6050cb33c1a4@lunn.ch>
 <47b67113-2903-49b5-a25e-84e704ac017d@motor-comm.com>
 <7f1b935d-732d-4d2f-a2c3-a0517c9301d7@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <7f1b935d-732d-4d2f-a2c3-a0517c9301d7@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/26 21:09, Andrew Lunn wrote:
> On Wed, Jul 15, 2026 at 07:59:55PM +0800, Kyle Switch wrote:
>>
>>
>> On 7/15/26 05:46, Andrew Lunn wrote:
>>>> +static inline int ytphy_top_write(struct phy_device *phydev, u32 regnum,
>>>> +				  u16 val)
>>>> +{
>>>> +	struct yt8521_priv *priv = phydev->priv;
>>>> +	struct mii_bus *bus = phydev->mdio.bus;
>>>> +
>>>> +	return bus->write(bus, priv->top_phy_addr, regnum, val);
>>>> +}
>>>
>>> Please could you explain the architecture in detail. It seems like you
>>> are accessing registers of some other device on the bus.
>>>
>>> Maybe you need to use the code in phy_package.c?
>>
>> Ans: YT8824 contains top extend reg space, and the addr is fixed, for 
>> internal phy8824 the value is 9, and external phy8824 is (baseaddr + 4).
> 
> Does the "top extend reg space" have values in the ID registers, 2 and
> 3? Is Linux trying to probe this address space?
> 
> Anyway, it does sound like you need to use phy_package. That will give
> you a better API for accessing the registers in the other address
> space.
> 

Ans: The "top extend reg space" does not have ID register, which is common
      register space shared by UTP and serdes.

> 	Andrew
