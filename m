Received: from out28-76.mail.aliyun.com (out28-76.mail.aliyun.com [115.124.28.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14152DECC2;
	Sun, 26 Jul 2026 03:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785037144; cv=none; b=FpVZqCkkLUBphCeJjoTHcBiiN/9HybK8WdygnkVcGJX0r+qsn1XqZHQAQXSahm2xYgX0wa/FeR2qDrJ+3Pl3EsIJHuLRgf1l3xpYkB0iZXzPtClWJ+eQ95l3voNQPtgNuv/E+KIIuqtN+yqWdXdqGbjiWyi4AbQ8HqHEnYLXa/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785037144; c=relaxed/simple;
	bh=AKpmIiQ4iccJxRD6HKk5WnyquH17NEcMmgFceiW2Lk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXyR5rDsmTVSvzS2rulEv5nG9nqKl4EoooqvefyZRcZN1Eaco++3DNZ8zNF4jYzZdSAA38AvngPFMmPABPUhjFjlQWxatocgYVmwXRuKMEypobiaJGPcFaUMbPt9ujamrF3TNxPrXYqJjBoWfsJX0m/3A8SX/Q3MoxgNmYenBMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07541294|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.263698-0.00342386-0.732878;FP=14437360192616700034|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iVOucSP_1785037128;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iVOucSP_1785037128 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 26 Jul 2026 11:38:50 +0800
Message-ID: <3398745a-d443-4882-9196-dd280b8ba982@motor-comm.com>
Date: Sun, 26 Jul 2026 11:38:48 +0800
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
 <0d789c95-5ca1-42d0-9ff5-27392cc65057@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <0d789c95-5ca1-42d0-9ff5-27392cc65057@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/25/26 06:18, Andrew Lunn wrote:
> On Fri, Jul 24, 2026 at 03:18:47PM +0200, Andrew Lunn wrote:
> 1;4000;47c> > Ans: It is different from the m88e1111 PHY, which may support UTP, fiber, 
>>>      or combo mode. However, the PHY8824 is only used with UTPs, and 
>>>      its structure is as follows, which includes UTP0, UTP1,UTP2,UTP3 and USXGMII.
>>>
>>>      RJ45 <----> UTP0 <------>
>>>      RJ45 <----> UTP1 <------>   USXGMII  <----->  USXGMII(the side of MAC)
>>>      RJ45 <----> UTP2 <------>
>>>      RJ45 <----> UTP3 <------>
>>>
>>>      It is similar to phy8821 driver in motorcomm.c, with the difference 
>>>      being that one has one UTP port and phy8824 has four UTP ports.
>>>      YT8824_RSSR_FIBER_SPACE is used to access USXGMII reg space, Perhaps it 
>>>      would be more accurate to call it YT8824_RSSR_USXGMII_SPACE or 
>>>      YT8824_RSSR_SERDES_SPACE.
>>
>> O.K, that completely changes my understanding of this device. Yes,
>> YT8824_RSSR_FIBER_SPACE should change name. And i would include this
>> diagram in the driver, and indicate how YT8824_RSSR_*_SPACE map to
>> this.
>>
>> For the locking, look thought all the code which is touching the
>> USXGMII side and see if it can be moved into probe().
> 
> So thinking about locking:
> 
> +static int yt8824_config_aneg(struct phy_device *phydev)
> +{
> +	int phy_ctrl = 0;
> +	int ret = 0;
> +
> +	ret = phy8824_page_write_lock(phydev, YT8824_RSSR_UTP_SPACE);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +			      phydev->advertising))
> +		phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN,
> +				     MDIO_AN_10GBT_CTRL,
> +				     MDIO_AN_10GBT_CTRL_ADV2_5G,
> +				     phy_ctrl);
> +	if (ret)
> +		return ret;
> +
> +	return genphy_config_aneg(phydev);
> +
> 
> This is only touching the UTP side of things. What a PHY advertises
> should not affect the USXGMII side. Why does it need
> YT8824_RSSR_UTP_SPACE? What would happen if YT8824_RSSR_USXGMII_SPACE
> has selected?
> 

Ans: yes, this place only involves the operation of UTP. The addition of 
     the operation to swap address spaces is solely to ensure that the 
     current operation is conducted on the UTP side, without affecting 
     the switching to the USXGMII side through other APIs.If the current 
     operation is performed on the USXGMII size, it cannot access the 
     standard MMD register of UTP, and all operations are configured and 
     the status obtained is the status of the UXGMII side, that is not what
     we want. That is why an operation to swap reg space has been added at 
     the beginning of each APIs.

>     Andrew
