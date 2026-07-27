Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C863E5EC3;
	Mon, 27 Jul 2026 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142093; cv=none; b=T+tEydsGqWwbLHN3vwXyCukZ4qsn/jS9mMXhL0OPu6PC20SriIeEmVz6RwtvmjfawEQj1UkHDRC106kvZQSNXyFn9Uo0BhNMRDEQ6+2KFAD61Ne4r4HAyR42S+Lpw6kqkB5byxn6EOHolQE28FeeiMsFx52fs+AjRBvE93D/8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142093; c=relaxed/simple;
	bh=VKIEp+KB9SltXns1dRwYtir0OY9UTCqRxLNLy2BqsKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJIvCa5ijjJglUuRlhTKAJ45kIBVqTMBywgb6FQurhx4jgsfAjBfu9GPuvlK8igTSJQqlNDF6ie1rBh6vruEFEAeyXFfbO86Ny6YOVN/eyEKHxDonE/pz/88vR3fTHC4vaZPDjNpWA/y5T24KX937KsFsUHJHqNeBODJpKjOVL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07450157|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0419407-0.000422469-0.957637;FP=17008814682599360514|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iWJ1fKu_1785142077;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iWJ1fKu_1785142077 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 27 Jul 2026 16:47:59 +0800
Message-ID: <42910a0b-52ee-401f-b8f1-69eb0e0858ce@motor-comm.com>
Date: Mon, 27 Jul 2026 16:47:56 +0800
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
References: <20260721114810.660718-1-kyle.switch@motor-comm.com>
 <d394347a-4162-49ea-b65a-c2e2bd3769aa@lunn.ch>
 <59cc79d4-cccb-4cc8-94d9-60c56e86b598@motor-comm.com>
 <c591a9b0-7fea-4953-93db-23f0f591e6ae@lunn.ch>
 <47d31704-e57b-4828-8c8d-0438ef43e49a@motor-comm.com>
 <ec6fb144-9b38-418c-ab6f-a02d5fb47b2b@lunn.ch>
 <4c4b9a41-cc54-4aa5-b302-631369e3c700@motor-comm.com>
 <87a4548f-ef0d-4ddc-9e87-155786cd5e31@lunn.ch>
 <638fda5b-ee2c-4f3c-94b6-37d689d48721@motor-comm.com>
 <b1f54c52-5719-414b-9bdd-3a0b0bc06252@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <b1f54c52-5719-414b-9bdd-3a0b0bc06252@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/26/26 22:51, Andrew Lunn wrote:
> On Sun, Jul 26, 2026 at 11:24:16AM +0800, Kyle Switch wrote:
>>
>>
>> On 7/24/26 21:18, Andrew Lunn wrote:
>>>> Ans: It is different from the m88e1111 PHY, which may support UTP, fiber, 
>>>>      or combo mode. However, the PHY8824 is only used with UTPs, and 
>>>>      its structure is as follows, which includes UTP0, UTP1,UTP2,UTP3 and USXGMII.
>>>>
>>>>      RJ45 <----> UTP0 <------>
>>>>      RJ45 <----> UTP1 <------>   USXGMII  <----->  USXGMII(the side of MAC)
>>>>      RJ45 <----> UTP2 <------>
>>>>      RJ45 <----> UTP3 <------>
>>>>
>>>>      It is similar to phy8821 driver in motorcomm.c, with the difference 
>>>>      being that one has one UTP port and phy8824 has four UTP ports.
>>>>      YT8824_RSSR_FIBER_SPACE is used to access USXGMII reg space, Perhaps it 
>>>>      would be more accurate to call it YT8824_RSSR_USXGMII_SPACE or 
>>>>      YT8824_RSSR_SERDES_SPACE.
>>>
>>> O.K, that completely changes my understanding of this device. Yes,
>>> YT8824_RSSR_FIBER_SPACE should change name. And i would include this
>>> diagram in the driver, and indicate how YT8824_RSSR_*_SPACE map to
>>> this.
>>>
>>> For the locking, look thought all the code which is touching the
>>> USXGMII side and see if it can be moved into probe().
>>>
>>
>> Ans: It may not be possible to completely move the code which touch the USXGMII side
>>      into the probe() function. The initialization configuration aimed at optimizing 
>>      the performance of the USXGMII side may be moved into the probe(). However, for the 
>>      soft reset of UTP, it is necessary to configure MII_BMCR registers in USXGMII side.
> 
> I'm beginning to think you need to add an extra lock.
> 
> The idea with the mdio lock for accessing pages was that is existed,
> and it would protect against accesses which don't come through phylib,
> like hwmon. Because it is a low level lock, it really only works
> within one PHY, when there are operations going on above it. The
> assumption is that PHYs operate independently.
> 
> You are attempting to use it differently. Because of the poor hardware
> design, you need to protect one PHY from another PHY. Your PHYs don't
> operate independently. So i think you need to add a high level lock,
> shared across the package. All the entry points via struct phy_driver
> need to lock the package as a whole. The PHY can then do what it needs
> to do without having to worry about another PHY being operated on in
> parallel. You can make use of the phylib helpers, since the MDIO level
> lock is not taken. phylibs concept of pages registers will work. Once
> everything is done, release the package lock.
> 
> So, please look at adding phy_package_lock() and
> phy_package_unlock(). Maybe it is possible to make use of struct
> mii_bus shared_lock? Please look at how that is currently used and
> check to see if there might be deadlocks.
> 

Ans: From my perspective, although a phy8824 has four UTPs, it uses the same mdio bus. 
     Wouldn't it be possible to achieve the desired effect without using an extra lock.

     There are only two scenarios for phy8824 to swap to USXGMII reg space.
     1. init configuration 
     2. soft reset and isolate done in USXGMII side during UTP soft reset.

     for scenario 1:
     It will lock the MDIO bus throughout the entire process, and upon completion, 
     it will swap to the UTP register space and unlock the MDIO bus.

     For scenario 2:
     If PHY1 works on its own UTP reg space, at this point, PHY2 swap the reg space to USXGMII side.
     In this case, PHY2 will hold this lock until the operation of PHY2 is completed, 
     and swap back to UTP reg space, unlock the bus. It will not affect the operation of PHY1
     works on its own UTP reg space.
>       Andrew
