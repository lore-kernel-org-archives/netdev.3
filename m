Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34341315D58;
	Fri, 24 Jul 2026 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893599; cv=none; b=Oa47lPKVM0uaC2VTLY8sRzAUvdufs0rJ2uRnAkZannLGGb3OZvo060YRIMqw7XKmQFy/Py88vU2EVjyPpT1gRjWVHyIUZgX986zekdkWwCA9MG67tTiURLsEnLv/7LUkhF6w2+0bd5rz03xRYAhZdScHhxX+syO+E8u53OIhWDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893599; c=relaxed/simple;
	bh=QEoBYZwbMR6PjHPHdT5DFom3L87/nFYJfav+a6ipctw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iv34z609JwqoVxdFQBhHZLAoSbyPlcWEsMaAPlUYrS/FkUu0MAK1qQFvOAPtJHeUTsEjGC7SGNTDeF+tVZZ7yJtRSb3FtycUynP2TplCq4bAAM1mj2Djc3Deci44uar/s4KoIi06JmfvitncubGOvAxPhc+FC/c3Xa6kJcY9EqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07437254|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0706852-0.000405561-0.928909;FP=16776813863550584971|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iU6FWiZ_1784893579;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iU6FWiZ_1784893579 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 24 Jul 2026 19:46:22 +0800
Message-ID: <4c4b9a41-cc54-4aa5-b302-631369e3c700@motor-comm.com>
Date: Fri, 24 Jul 2026 19:46:19 +0800
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
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <ec6fb144-9b38-418c-ab6f-a02d5fb47b2b@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/23/26 22:27, Andrew Lunn wrote:
> On Thu, Jul 23, 2026 at 05:28:39PM +0800, Kyle Switch wrote:
>>
>>
>> On 7/22/26 21:18, Andrew Lunn wrote:
>>> On Wed, Jul 22, 2026 at 04:06:31PM +0800, Kyle Switch wrote:
>>>>
>>>>
>>>> On 7/21/26 22:18, Andrew Lunn wrote:
>>>>> Just checking something here....
>>>>>
>>>>>> +/**
>>>>>> + * ytphy_write_top_ext() - write a PHY's top extended register for YT8824
>>>>>> + * @phydev: a pointer to a &struct phy_device
>>>>>> + * @regnum: register number to write
>>>>>> + * @val: register val to write
>>>>>> + *
>>>>>> + * Returns: the value of regnum reg or negative error code
>>>>>> + */
>>>>>> +static int ytphy_write_top_ext(struct phy_device *phydev, u16 regnum,
>>>>>> +			       u16 val)
>>>>>> +{
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	lockdep_assert_held(&phydev->mdio.bus->mdio_lock);
>>>>>> +	ret = __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, regnum);
>>>>>> +	if (ret < 0)
>>>>>> +		return ret;
>>>>>> +
>>>>>> +	return __phy_package_write(phydev, 0, YTPHY_PAGE_DATA, val);
>>>>>
>>>>> The _top_ registers are in a different MDIO address, and are shared by
>>>>> all PHYs within one package. Correct?
>>>>
>>>> Ans: yes, the understanding is correct. The top registers is shared by
>>>>      all PHYs.
>>>>
>>>>>
>>>>>> +static int yt8824_write_page(struct phy_device *phydev, int page)
>>>>>> +{
>>>>>> +	int old_page;
>>>>>> +	u16 data;
>>>>>> +
>>>>>> +	old_page = ytphy_read_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG);
>>>>>> +	data = old_page & (~YT8824_RSSR_SPACE_MASK);
>>>>>> +	data |= page;
>>>>>> +
>>>>>> +	return ytphy_write_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG, data);
>>>>>
>>>>> The page register is in a top register. So when accessing a paged
>>>>> register, all other PHYs also get swapped to that page. And so it is
>>>>> necessary to block all other PHYs from accessing registers, until the
>>>>> paged access if completed?
>>>>>
>>>>> If i have that right, that is an odd hardware design. Since this is an
>>>>> odd design, it deserves to be documented. Locking is hard, and it is
>>>>> made harder by not having good documentation about the design of the
>>>>> locking scheme. 
>>>>
>>>> Ans: Yes, the current operation involves locking at the beginning of the phy8824 driver
>>>>      ops and unlocking at the end of the ops function, that is why so many __function 
>>>>      involved in this driver, but there are also some special cases that need to be reconsidered 
>>>>      such as using  phy_read_poll_timeout().Can you give me some suggestions on the lock scheme?
>>>
>>> So, that is a really bad design. As a software engineer you should go
>>> talk to your hardware engineers and tell them what is wrong with this
>>> design. Hopefully they will then fix it for the next generation, move
>>> the page register into the PHYs own address space, a page register per
>>> PHY so removing this locking.
>>>
>>>>>> +	old_page = phy_select_page(phydev, reg_space);
>>>>>> +	if (old_page < 0)
>>>>>> +		goto err_restore_page;
>>>>>> +
>>>>>> +	if (reg_space == YT8824_RSSR_UTP_SPACE) {
>>>>>> +		ret = __phy_read_mmd(phydev, 0x1,
>>>>>> +				     YT8824_UTP_TEMPLATE_MODE_CTRL);
>>>>>
>>>>> What address spaces are paged? Every other design i've seen only has
>>>>> pages of C22 registers, since you only have 32 of them. But looking at
>>>>> this code, does this hardware also page C45?
>>>>>
>>>>
>>>> Ans: To access the mmd register of UTP, must first select the page as UTP. I'm not sure if this is 
>>>>      the answer you want.
>>>
>>> So it sounds like each MDIO address on the bus actually has two full
>>> PHYs on it, and this page register allows you to swap the accesses
>>> between the two. Are there two sets of MDI pins, one for each PHY?
>>> Can both FIBER and UTP be used at the same time? Could i configure
>>> both copper and fibre parts, see which gets link first, and then
>>> declare that the winner? Maybe you should actually be exposing both
>>> PHYs, with a mux between the MAC and the PHYs. This is something
>>> Maxime has been working on.
>>>
>>> This whole concept of one shared register controlling page access to
>>> all PHYs within the package sounds so wrong, i would go talk to the
>>> hardware engineers. Maybe you are missing something, the software is
>>> not doing what the hardware designer intended? Because this is so
>>> ugly.
>>>
>>
>> Ans: Perhaps there is indeed a misunderstanding here. The working mode 
>>      of phy8824 is"mac <---> usxgmii ----UTP". The panel ports of 
>>      PHY8824 is always UTP.
> 
> So what is all this code about YT8824_RSSR_FIBER_SPACE for?
> 
> I'm assuming this device can be used similar to the marvell
> m88e1111. It can either be used with Base-T UTP, or it can be
> connected to an SFP cage. It uses different pages to configure UTP vs
> fibre. Your driver seems to have a similar structure.
> 

Ans: It is different from the m88e1111 PHY, which may support UTP, fiber, 
     or combo mode. However, the PHY8824 is only used with UTPs, and 
     its structure is as follows, which includes UTP0, UTP1,UTP2,UTP3 and USXGMII.

     RJ45 <----> UTP0 <------>
     RJ45 <----> UTP1 <------>   USXGMII  <----->  USXGMII(the side of MAC)
     RJ45 <----> UTP2 <------>
     RJ45 <----> UTP3 <------>

     It is similar to phy8821 driver in motorcomm.c, with the difference 
     being that one has one UTP port and phy8824 has four UTP ports.
     YT8824_RSSR_FIBER_SPACE is used to access USXGMII reg space, Perhaps it 
     would be more accurate to call it YT8824_RSSR_USXGMII_SPACE or 
     YT8824_RSSR_SERDES_SPACE.

>        Andrew
