Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F4838A72C;
	Wed, 22 Jul 2026 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784707607; cv=none; b=p+c4NeEH+rgaU82Uch9cAWr59M8O/fZXcUMUmy1Sc/I/ei/F6nXXFiN+grdTKCZhwF2ncG4Rrkf8lxVZO19uxShXRYsTcV8oi7XT/8sAQV6GuDrL9srnsE+T5rHbRkcjkDtCAQBtsUbA1Ulqtnm7+s0wwOO7ZC85JlAFNXaSAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784707607; c=relaxed/simple;
	bh=bnqjgGr8WT8Q3FkEMjNbBKwHInk6WxtIIqcy+refYrk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QVgnE3BYtpwNuR0OLQNUNuL2n+lC5bI26qsGUKdKBTpdB1ttrKu7qmqk1LF4We+ooi+jWdJML4wp/2+6EExKjTqaa0XVkrO0hO+R7Rlw++suUCr7URpAQDuutaRypISl5xoKD+ynKb+ItABtaxtRtET2VeFetWswmOgv+jPZEFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.080864|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0643114-0.000559307-0.935129;FP=14472131977229634715|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021130;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iRuM9Tr_1784707593;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iRuM9Tr_1784707593 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 22 Jul 2026 16:06:34 +0800
Message-ID: <59cc79d4-cccb-4cc8-94d9-60c56e86b598@motor-comm.com>
Date: Wed, 22 Jul 2026 16:06:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kyle Switch <kyle.switch@motor-comm.com>
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
Content-Language: en-US
In-Reply-To: <d394347a-4162-49ea-b65a-c2e2bd3769aa@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/21/26 22:18, Andrew Lunn wrote:
> Just checking something here....
> 
>> +/**
>> + * ytphy_write_top_ext() - write a PHY's top extended register for YT8824
>> + * @phydev: a pointer to a &struct phy_device
>> + * @regnum: register number to write
>> + * @val: register val to write
>> + *
>> + * Returns: the value of regnum reg or negative error code
>> + */
>> +static int ytphy_write_top_ext(struct phy_device *phydev, u16 regnum,
>> +			       u16 val)
>> +{
>> +	int ret;
>> +
>> +	lockdep_assert_held(&phydev->mdio.bus->mdio_lock);
>> +	ret = __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, regnum);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return __phy_package_write(phydev, 0, YTPHY_PAGE_DATA, val);
> 
> The _top_ registers are in a different MDIO address, and are shared by
> all PHYs within one package. Correct?

Ans: yes, the understanding is correct. The top registers is shared by
     all PHYs.

> 
>> +static int yt8824_write_page(struct phy_device *phydev, int page)
>> +{
>> +	int old_page;
>> +	u16 data;
>> +
>> +	old_page = ytphy_read_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG);
>> +	data = old_page & (~YT8824_RSSR_SPACE_MASK);
>> +	data |= page;
>> +
>> +	return ytphy_write_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG, data);
> 
> The page register is in a top register. So when accessing a paged
> register, all other PHYs also get swapped to that page. And so it is
> necessary to block all other PHYs from accessing registers, until the
> paged access if completed?
> 
> If i have that right, that is an odd hardware design. Since this is an
> odd design, it deserves to be documented. Locking is hard, and it is
> made harder by not having good documentation about the design of the
> locking scheme. 

Ans: Yes, the current operation involves locking at the beginning of the phy8824 driver
     ops and unlocking at the end of the ops function, that is why so many __function 
     involved in this driver, but there are also some special cases that need to be reconsidered 
     such as using  phy_read_poll_timeout().Can you give me some suggestions on the lock scheme?

> 
>> +	old_page = phy_select_page(phydev, reg_space);
>> +	if (old_page < 0)
>> +		goto err_restore_page;
>> +
>> +	if (reg_space == YT8824_RSSR_UTP_SPACE) {
>> +		ret = __phy_read_mmd(phydev, 0x1,
>> +				     YT8824_UTP_TEMPLATE_MODE_CTRL);
> 
> What address spaces are paged? Every other design i've seen only has
> pages of C22 registers, since you only have 32 of them. But looking at
> this code, does this hardware also page C45?
> 

Ans: To access the mmd register of UTP, must first select the page as UTP. I'm not sure if this is 
     the answer you want.

>      Andrew
