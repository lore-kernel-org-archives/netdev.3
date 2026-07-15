Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066A3CAA49;
	Wed, 15 Jul 2026 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784116815; cv=none; b=VLj35V/DsKTGVVZkWBZgkkd8CgblCRjWAYVXoGZgf5/ctMHoNbnHxxg5tNxzo7E9XM6bMxQLgwVxocf+gQkIpEAsFB3JmMRaZgz3nMvtckv0i0iJt7Z5l/HpeOcP2Arrtq2xO9y5S7HVSfdWMOA1R5s99CjIbZW8pFcVdROEu2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784116815; c=relaxed/simple;
	bh=mH3qArF2dKOYqYwlfBDDrx9WweSING/NqjZALu8/69k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgaB8KtUPo+tZRmdPSXxekkLW88Uh6DsdnybuCl1orOd9Ss3f+ydT0Wb8CLFzYn/8ujU22oHKW0C3uLmtamwSikZRw8M4XGGG06lJJ6gx70uMOqh91u4uhe8JMN3qOX4ZFghwLgztYrpoP3pM2t0BcnW0733D5yQs0lWZtviY/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2697289|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.022684-0.000293287-0.977023;FP=14913588932206190439|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iM32tT9_1784116796;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iM32tT9_1784116796 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 15 Jul 2026 20:00:00 +0800
Message-ID: <47b67113-2903-49b5-a25e-84e704ac017d@motor-comm.com>
Date: Wed, 15 Jul 2026 19:59:55 +0800
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
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <46c380a2-74ab-4690-a289-6050cb33c1a4@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/26 05:46, Andrew Lunn wrote:
>> +static inline int ytphy_top_write(struct phy_device *phydev, u32 regnum,
>> +				  u16 val)
>> +{
>> +	struct yt8521_priv *priv = phydev->priv;
>> +	struct mii_bus *bus = phydev->mdio.bus;
>> +
>> +	return bus->write(bus, priv->top_phy_addr, regnum, val);
>> +}
> 
> Please could you explain the architecture in detail. It seems like you
> are accessing registers of some other device on the bus.
> 
> Maybe you need to use the code in phy_package.c?

Ans: YT8824 contains top extend reg space, and the addr is fixed, for 
internal phy8824 the value is 9, and external phy8824 is (baseaddr + 4).
> 
>       Andrew
