Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com [115.124.28.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41378313E31;
	Fri, 17 Jul 2026 05:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784266307; cv=none; b=GjQyARq54gy38OKjLlXrM3/zsRx8CGF2WnAGnrdkkpgitztbe2vP2SS7Z5y7vig16NqnkZvBy5xd4RWsFHS2XFLmKqpbMeWMEJG7vqYjf2ylZgQl+JdsPfYoKdhgUeVj828eaiHRRKel7VewPWxrM0gz16R/iYvLADAxAnmRe0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784266307; c=relaxed/simple;
	bh=6MzmaWNX7zclwwt+ACB+wB7qL9qG/sOCsAy5i5UTImM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9WeaKOWqfs1PDeujTzHQiOAh0GufkBTqKjU59mffL7jTA70n0mA9SFOmlX3u516Nsklymkq4pVVMOPItJYhaP6wcZ/dnvyQS1RnMvxjUeS98AAwqaZLfyiO3q6JpSebZyiuO6QhUjxtAYCxO/nJF00It98I/bhPZgFR3guZzcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.049601-0.000702818-0.949696;FP=14579091355959073970|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iNoqHG4_1784266291;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iNoqHG4_1784266291 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 17 Jul 2026 13:31:33 +0800
Message-ID: <135b1c98-ab20-4201-b8fb-117423e134d4@motor-comm.com>
Date: Fri, 17 Jul 2026 13:31:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next v2 2/2] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianmin.wang@motor-comm.com, xiaolin.xu@motor-comm.com,
 ming.xu@motor-comm.com, jie.han@motor-comm.com
References: <20260715121012.1113552-1-kyle.switch@motor-comm.com>
 <6bb415f2-5e41-4002-90e5-3d37d881b391@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <6bb415f2-5e41-4002-90e5-3d37d881b391@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 01:16, Andrew Lunn wrote:
>> +#define YT8824_RSSR_SPACE_MASK			BIT(0)
>> +#define YT8824_RSSR_FIBER_SPACE			(0x1)
>> +#define YT8824_RSSR_UTP_SPACE			(0x0)
> 
> Since there are only two pages, one bit:
> 
>> +/**
>> + * yt8824_read_page() - read reg page
>> + * @phydev: a pointer to a &struct phy_device
>> + *
>> + * returns current reg space of yt8824 (YT8824_RSSR_FIBER_SPACE/
>> + * YT8824_RSSR_UTP_SPACE) or negative errno code
>> + */
>> +static int yt8824_read_page(struct phy_device *phydev)
>> +{
>> +	int old_page;
>> +
>> +	old_page = ytphy_read_top_ext_with_lock(phydev, YT8521_REG_SPACE_SELECT_REG);
>> +	if (old_page < 0)
>> +		return old_page;
>> +
>> +	if ((old_page & YT8824_RSSR_SPACE_MASK) == YT8824_RSSR_FIBER_SPACE)
>> +		return YT8824_RSSR_FIBER_SPACE;
>> +
>> +	return YT8824_RSSR_UTP_SPACE;
> 
> You can simplify this to just
> 
>     return old_page & YT8824_RSSR_SPACE_MASK;
> 

Ans: Fixed in v3 patch, Please help check in updated patch.

>> +static int yt8824_write_page(struct phy_device *phydev, int page)
>> +{
>> +	int old_page;
>> +	u16 data;
>> +
>> +	old_page = ytphy_read_top_ext_with_lock(phydev, YT8521_REG_SPACE_SELECT_REG);
>> +	data = old_page & (~(0x1));
> 
> Use YT8824_RSSR_SPACE_MASK here.
> 
>> +	data |= page;
>> +
>> +	return ytphy_write_top_ext_with_lock(phydev, YT8521_REG_SPACE_SELECT_REG, data);
>> +};
>> +
>> +/**
>> + * configuration YT8824 to one template test mode.
>> + */
>> +static int yt8824_soft_reset_step1_paged(struct phy_device *phydev,
>> +					 int reg_space)
>> +{
>> +	int old_page;
>> +	int ret = 0;
>> +
>> +	old_page = phy_select_page(phydev, reg_space);
>> +	if (old_page < 0)
>> +		goto err_restore_page;
>> +
>> +	if (old_page >= 0) {
> 
> What is the purpose of this if ()?

Ans: remove the unnecessary and redundant judgment in v3 patch.

> 
>> +		if (reg_space == YT8824_RSSR_UTP_SPACE) {
>> +			ret =  __phy_write_mmd(phydev, 0x1, 0x0084, 0x2000);
> 
> No magic numbers. 0x0084 is probably not a vendor register either, so
> please use its proper name. And is 0x2000 a value, or should it bit it
> use the BIT() macro?

Ans: Fixed in v3 patch.

> 
>> +			ret = __phy_read(phydev, MII_BMCR);
>> +			if (ret < 0)
>> +				goto err_restore_page;
>> +			ret |= BMCR_RESET;
>> +			ret = __phy_write(phydev, MII_BMCR, ret);
>> +			if (ret < 0)
>> +				goto err_restore_page;
>> +			do {
>> +				msleep(50);
>> +				ret = __phy_read(phydev, MII_BMCR);
>> +				if (ret < 0)
>> +					goto err_restore_page;
>> +			} while ((ret & BMCR_RESET) && --retry);
> 
> 
>> +			ret = __phy_read(phydev, MII_BMCR);
>> +			if (ret < 0)
>> +				goto err_restore_page;
>> +			/* disable isolation */
>> +			ret &= ~BIT(10);
> 
> That is probably a standard BMCR bit, so there should be a#define for
> it.

Ans: Fix all BMCR bit in V3.

> 
>> +			/* soft reset */
>> +			ret |= BMCR_RESET;
>> +			ret = __phy_write(phydev, MII_BMCR, ret);
>> +			if (ret < 0)
>> +				return ret;
>> +			do {
>> +				msleep(50);
>> +				ret = __phy_read(phydev, MII_BMCR);
>> +				if (ret < 0)
>> +					goto err_restore_page;
>> +			} while ((ret & BMCR_RESET) && --retry);
>> +			if (ret & BMCR_RESET)
>> +				goto err_restore_page;
> 
> Look at all the duplicated code here. Please add some helpers.
> Also take a look at phy_device.c, and follow what it does.

Ans: Fixed in v3 patch using phy_read_poll_timeout to wait softret done.

> 
>> +	if (phydev->interface == PHY_INTERFACE_MODE_INTERNAL) {
>> +		/* invalid test mode */
>> +		ret = yt8824_soft_reset_step1_paged(phydev,
>> +						    YT8824_RSSR_UTP_SPACE);
> 
> Why not call this function
> yt8824_soft_reset_invalid_test_mode_paged(). Having the comment is a
> big hint your function naming is bad.

Ans: Fixed in v3 patch, to rename the function based on 
its approximate functionality

> 
>> +static int yt8824_internal_config_init_paged(struct phy_device *phydev,
>> +					     int reg_space)
>> +{
>> +	struct yt8521_priv *priv = phydev->priv;
>> +	int old_page;
>> +	int port = 0;
>> +	int ret = 0;
>> +
>> +	old_page = phy_select_page(phydev, reg_space);
>> +	if (old_page < 0)
>> +		goto err_restore_page;
>> +
>> +	port = phydev->mdio.addr - priv->phy_base_addr;
>> +	ret = ytphy_write_ext(phydev, 0x1, 0x3);
>> +	if (ret < 0)
>> +		goto err_restore_page;
>> +	ret = __phy_write(phydev, MII_BMCR, 0x1900);
> 
> All the magic numbers need to be replaced. But this is especially bad,
> because BMCR is well documented and has all its bits covered with
> existing #define's.
> 

Ans: All standard BMCR registers operations have been replaced in the v3 patch.
However, for some extend registers, they are designed to optimize 
the performance of phy8824. If they are also replaced, the entire function may 
become bloated, so they have not been replaced for the time being.

>> +	netdev_info(phydev->attached_dev,
>> +		    "%s done, phy addr: %d, phy base addr = %d\n",
>> +		    __func__, phydev->mdio.addr, priv->phy_base_addr);
> 
> Very unusual. This is a PHY driver, so it should be using
> phy_info(). But i also think this should be _dgb().

Ans: yes, it will be fixed in V3 using phydev_dbg().

> 
> 	Andrew
