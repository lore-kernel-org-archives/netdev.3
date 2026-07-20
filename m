Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D8C3D3002;
	Mon, 20 Jul 2026 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538330; cv=none; b=i/4B0MFS4OyHiI7d3fzec4FzQ7F4VklxmUSY5ebNogd7gl00ONuBzGgnfNk1xVIR1FyVusi97DWpxt/fD5lO2keZvJOJo14rXQx4YIneg7sEigdt6rkoBrp6xEX2ByHPQGlBFn16xn25vzbD8X64iabijwBk7ecmEWqVINMtZ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538330; c=relaxed/simple;
	bh=enVSGgLWfyWsB6cuCxYYnUyxJmn5j+tbsUUgmkY9C68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkvV5H0OZzt6zAzvRqrdAELDlK8kZceYezCZbzhwMZi8bg6s4XM5zrWQanBu+hlbv9KLl8JGAhY/k+rXMcwfrhAGcyIqMR9wOWk+dkMLaJ9joA6eFhk2unEe2SDcDBK81eTUzK+FJ+s2YQwSF4NSZclZ3YQ7Dt2lG3gPI8vHF2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07438403|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.036001-0.00152048-0.962479;FP=14472166057743748263|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iQ3UBI1_1784538318;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iQ3UBI1_1784538318 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 20 Jul 2026 17:05:21 +0800
Message-ID: <3d87f3d1-83c6-49b5-ac6f-59880c6a6c6c@motor-comm.com>
Date: Mon, 20 Jul 2026 17:05:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next v3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260717054807.1321374-1-kyle.switch@motor-comm.com>
 <06a5b8d1-f3a5-40e9-af12-52c5c9fd99e6@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <06a5b8d1-f3a5-40e9-af12-52c5c9fd99e6@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 23:11, Andrew Lunn wrote:
>> +/**
>> + * ytphy_read_top_ext() - read a PHY's top extended register for YT8824
>> + * @phydev: a pointer to a &struct phy_device
>> + * @regnum: register number to read
>> + *
>> + * NOTE:The caller must have taken the MDIO bus lock.
> 
> Didn't i request this is done in code, not comments?

Ans: fix done in patch v4 by called lockdep_assert_held to make
sure to hold the lock.

> 
>> +static int ytphy_read_top_ext(struct phy_device *phydev, u16 regnum)
>> +{
>> +	struct yt8824_shared_priv *shared_priv;
>> +	unsigned int offset;
>> +	int ret;
>> +
>> +	shared_priv = phy_package_get_priv(phydev);
>> +	offset = shared_priv->offset;
>> +	ret = __phy_package_write(phydev, offset, YTPHY_PAGE_SELECT, regnum);
> 
> You look to be using the package wrongly.
> 
> https://elixir.bootlin.com/linux/v7.1.3/source/drivers/net/phy/phy_package.c#L192
> 
>  * The base_addr parameter serves as cookie which has to have the same values
>  * for all members of one group and as the base PHY address of the PHY package
>  * for offset calculation to access generic registers of a PHY package.
>  * Usually, one of the PHY addresses of the different PHYs in the package
>  * provides access to these global registers.
>  * The address which is given here, will be used in the __phy_package_read()
>  * and __phy_package_write() convenience functions as base and added to the
>  * passed offset in those functions.
> 
> Although it is called base, it can be above all the others. So when
> you create the package, set the cookie value to your top address. You
> can then use __phy_package_write() directly, offset of 0.

Ans: fix done in patch v4, the base_addr is used to access to the top extend register
for phy8824.

> 
>> -static struct phy_driver motorcomm_phy_drvs[] = {
>> -	{
>> -		PHY_ID_MATCH_EXACT(PHY_ID_YT8511),
>> -		.name		= "YT8511 Gigabit Ethernet",
>> -		.config_init	= yt8511_config_init,
>> -		.suspend	= genphy_suspend,
>> -		.resume		= genphy_resume,
>> -		.read_page	= yt8511_read_page,
>> -		.write_page	= yt8511_write_page,
>> -	},
> 
> I still don't like this. Please stop diff deleting all these and
> putting them back later. It makes me thing something changed, maybe
> white space?

Ans: I tried to refactor this issue by hanging the position of the newly
added code. However, the same issue may still arise in other code segments, 
without modifying the existing code.
> 
>> +static int yt8824_utp_softreset_paged(struct phy_device *phydev,
>> +				      int reg_space)
>> +{
>> +	int old_page;
>> +	int ret = 0;
>> +	int val;
>> +
>> +	old_page = phy_select_page(phydev, reg_space);
>> +	if (old_page < 0)
>> +		goto err_restore_page;
>> +	if (reg_space == YT8824_RSSR_UTP_SPACE) {
>> +		ret = __phy_read(phydev, MII_BMCR);
>> +		if (ret < 0)
>> +			goto err_restore_page;
>> +		ret |= BMCR_RESET;
>> +		ret = __phy_write(phydev, MII_BMCR, ret);
> 
> So here you are using __phy_write() so it does not take the mdio lock.
> 
>> +		if (ret < 0)
>> +			goto err_restore_page;
>> +		/* wait until softreset done. */
>> +		ret = phy_read_poll_timeout(phydev, MII_BMCR, val, !(val & BMCR_RESET),
>> +					    50000, 600000, true);
> 
> This uses phy_read(), so does take the lock.
> 
> How can this be correct?
> 
> Please take some time to think about locking. Please enable all the
> locking debug options in the kernel and see if you get splats. And
> also really do turn your locking comments into code.
> 

Ans: this issue fixed done in patch v4. The correct procedure might be to acquire the mdio lock 
within this phy_select_page() and release it within phy_restore_page(). During this period, 
all interfaces that involve acquiring the mdio lock are unacceptable and incorrect.

>     Andrew
