Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8589F3F9F4D;
	Tue, 28 Jul 2026 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237923; cv=none; b=LEBjGuCnBnnz6A92itt17M7W4tgVDxvEk8rUzpkAhWWD4b0XJWtplXWuiKaCJhUVNJsQk3UdSojMyohQlPde/AFVVwSLE3d87rwurVm5K9dxhc2KhYLYohTl4v+L2shM3mqtr0DY7MWtGXDlSegZB87itFLhJkXQGxOqZnYB2PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237923; c=relaxed/simple;
	bh=cPkMl4/vcSNUsUTw0aP/bqPdtv+72puiasHr3ktme30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfisaC3pDNFgCBCAyykUzAqbpVCXcfwW14a1KI5wiEEWkzQvLY3Pp2DUWQ2IpUzoYodNCmg/WPJybgBixQ39cr2iGi0Ame4um0DCK6kfcwH+bfCPrKJ/pYH1AtP3gt5xj3XV6BBHJUvVKZPltJJ/Lp/mQz/NO6hmRt3KWLtH6zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07720412|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.735679-0.00304353-0.261277;FP=14746844111612971234|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021130;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iXTH-05_1785237909;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iXTH-05_1785237909 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 28 Jul 2026 19:25:10 +0800
Message-ID: <7a0f1dba-047d-4155-a057-3ab25eb87918@motor-comm.com>
Date: Tue, 28 Jul 2026 19:25:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <d394347a-4162-49ea-b65a-c2e2bd3769aa@lunn.ch>
 <59cc79d4-cccb-4cc8-94d9-60c56e86b598@motor-comm.com>
 <c591a9b0-7fea-4953-93db-23f0f591e6ae@lunn.ch>
 <47d31704-e57b-4828-8c8d-0438ef43e49a@motor-comm.com>
 <ec6fb144-9b38-418c-ab6f-a02d5fb47b2b@lunn.ch>
 <4c4b9a41-cc54-4aa5-b302-631369e3c700@motor-comm.com>
 <87a4548f-ef0d-4ddc-9e87-155786cd5e31@lunn.ch>
 <638fda5b-ee2c-4f3c-94b6-37d689d48721@motor-comm.com>
 <b1f54c52-5719-414b-9bdd-3a0b0bc06252@lunn.ch>
 <42910a0b-52ee-401f-b8f1-69eb0e0858ce@motor-comm.com>
 <cf87c11c-308c-4a3b-a374-6e705a3a1d57@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <cf87c11c-308c-4a3b-a374-6e705a3a1d57@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/28/26 05:36, Andrew Lunn wrote:
>>> So, please look at adding phy_package_lock() and
>>> phy_package_unlock(). Maybe it is possible to make use of struct
>>> mii_bus shared_lock? Please look at how that is currently used and
>>> check to see if there might be deadlocks.
>>>
>>
>> Ans: From my perspective, although a phy8824 has four UTPs, it uses the same mdio bus. 
>>      Wouldn't it be possible to achieve the desired effect without using an extra lock.
>>
>>      There are only two scenarios for phy8824 to swap to USXGMII reg space.
>>      1. init configuration 
>>      2. soft reset and isolate done in USXGMII side during UTP soft reset.
> 
> Soft reset is performed in phy_init_hw() which is called in a few
> different places, such as phy_attach_direct(), phy_mii_ioctl() etc. So
> you have to assume it can be called anytime. As such you need locking.
> 
> A big point of phylib is the collection of helpers to deal with
> anything defined in 802.3. The PHY driver should be using these
> helpers to do things defined in the standard. But if you are holding
> the mdio lock, you cannot use the helpers. What i don't want to see is
> your driver reimplementing code which we have in helpers because of
> your bad hardware design.
> 
> Locking is hard, and given how infrequently phylib does operations, it
> is going to be difficult to find and fix race conditions which result
> in the PHYs becoming miss configured. So you need a simple, robust
> solution.
> 
> If you think you have a solution to allow the helpers to be used,
> which is simple and robust, please post it. Otherwise, i think you
> need phy_package_lock()/phy_package_unlock()

Ans: i will post patch v7, please help comments on it.

> 
> 	Andrew
