Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com [115.124.28.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E628841A91E;
	Thu, 23 Jul 2026 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798932; cv=none; b=JOd5ri2zB+TcU70SnMKgWLqJSZ90wMb0HKkWKppO1YMJOJiSN9TYPjh2CwtBRCTQ/pIJ04eUoOf9JLu4ci432+ZW9c6g5KJV9dPssWN3uEADqw2YiLmcWhlaDT6mQ+bBaLIaC5ImvCyNVU2D0Ssi5NzalXfqJZKAcx4dCNWKRHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798932; c=relaxed/simple;
	bh=pFf4Pu4MIk7I1AVUaIl6vzYQGwM/H7G+SH59PxZwQpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbSFA/GoiH9muyioKLJ8e5KRv7qe1T49URiYWZAVSIPW4m54LN0AAHw1pIw5dNmfx+3ZXA5ItZp5cZHh5B0gvPVoczORPQxWqcdchBJrYAglciYo5Fc6CTWiKZkCxZz0EVHwoLXJS5VylK85ZaBv1xZA/Wvbe+oU1kg2fs+gdG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07454953|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.115064-0.00112449-0.883811;FP=14471040948161218715|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iSzbhJO_1784798919;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iSzbhJO_1784798919 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 23 Jul 2026 17:28:42 +0800
Message-ID: <47d31704-e57b-4828-8c8d-0438ef43e49a@motor-comm.com>
Date: Thu, 23 Jul 2026 17:28:39 +0800
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
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <c591a9b0-7fea-4953-93db-23f0f591e6ae@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/22/26 21:18, Andrew Lunn wrote:
> On Wed, Jul 22, 2026 at 04:06:31PM +0800, Kyle Switch wrote:
>>
>>
>> On 7/21/26 22:18, Andrew Lunn wrote:
>>> Just checking something here....
>>>
>>>> +/**
>>>> + * ytphy_write_top_ext() - write a PHY's top extended register for YT8824
>>>> + * @phydev: a pointer to a &struct phy_device
>>>> + * @regnum: register number to write
>>>> + * @val: register val to write
>>>> + *
>>>> + * Returns: the value of regnum reg or negative error code
>>>> + */
>>>> +static int ytphy_write_top_ext(struct phy_device *phydev, u16 regnum,
>>>> +			       u16 val)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	lockdep_assert_held(&phydev->mdio.bus->mdio_lock);
>>>> +	ret = __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, regnum);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	return __phy_package_write(phydev, 0, YTPHY_PAGE_DATA, val);
>>>
>>> The _top_ registers are in a different MDIO address, and are shared by
>>> all PHYs within one package. Correct?
>>
>> Ans: yes, the understanding is correct. The top registers is shared by
>>      all PHYs.
>>
>>>
>>>> +static int yt8824_write_page(struct phy_device *phydev, int page)
>>>> +{
>>>> +	int old_page;
>>>> +	u16 data;
>>>> +
>>>> +	old_page = ytphy_read_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG);
>>>> +	data = old_page & (~YT8824_RSSR_SPACE_MASK);
>>>> +	data |= page;
>>>> +
>>>> +	return ytphy_write_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG, data);
>>>
>>> The page register is in a top register. So when accessing a paged
>>> register, all other PHYs also get swapped to that page. And so it is
>>> necessary to block all other PHYs from accessing registers, until the
>>> paged access if completed?
>>>
>>> If i have that right, that is an odd hardware design. Since this is an
>>> odd design, it deserves to be documented. Locking is hard, and it is
>>> made harder by not having good documentation about the design of the
>>> locking scheme. 
>>
>> Ans: Yes, the current operation involves locking at the beginning of the phy8824 driver
>>      ops and unlocking at the end of the ops function, that is why so many __function 
>>      involved in this driver, but there are also some special cases that need to be reconsidered 
>>      such as using  phy_read_poll_timeout().Can you give me some suggestions on the lock scheme?
> 
> So, that is a really bad design. As a software engineer you should go
> talk to your hardware engineers and tell them what is wrong with this
> design. Hopefully they will then fix it for the next generation, move
> the page register into the PHYs own address space, a page register per
> PHY so removing this locking.
> 
>>>> +	old_page = phy_select_page(phydev, reg_space);
>>>> +	if (old_page < 0)
>>>> +		goto err_restore_page;
>>>> +
>>>> +	if (reg_space == YT8824_RSSR_UTP_SPACE) {
>>>> +		ret = __phy_read_mmd(phydev, 0x1,
>>>> +				     YT8824_UTP_TEMPLATE_MODE_CTRL);
>>>
>>> What address spaces are paged? Every other design i've seen only has
>>> pages of C22 registers, since you only have 32 of them. But looking at
>>> this code, does this hardware also page C45?
>>>
>>
>> Ans: To access the mmd register of UTP, must first select the page as UTP. I'm not sure if this is 
>>      the answer you want.
> 
> So it sounds like each MDIO address on the bus actually has two full
> PHYs on it, and this page register allows you to swap the accesses
> between the two. Are there two sets of MDI pins, one for each PHY?
> Can both FIBER and UTP be used at the same time? Could i configure
> both copper and fibre parts, see which gets link first, and then
> declare that the winner? Maybe you should actually be exposing both
> PHYs, with a mux between the MAC and the PHYs. This is something
> Maxime has been working on.
> 
> This whole concept of one shared register controlling page access to
> all PHYs within the package sounds so wrong, i would go talk to the
> hardware engineers. Maybe you are missing something, the software is
> not doing what the hardware designer intended? Because this is so
> ugly.
> 

Ans: Perhaps there is indeed a misunderstanding here. The working mode 
     of phy8824 is"mac <---> usxgmii ----UTP". The panel ports of 
     PHY8824 is always UTP.Therefore, the link will only be established to UTP, 
     and our monitoring of the link status will also only involve UTP. The 
     operations on the serdes reg space(usxgmii reg space) are limited to initial
     configuration and serdes soft reset procedures.

     I will fix the current code by referencing the existing phy driver in patch v6.

>     Andrew
