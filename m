Received: from out28-218.mail.aliyun.com (out28-218.mail.aliyun.com [115.124.28.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0243C10A2;
	Tue, 15 Sep 2026 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460464; cv=none; b=cZra/2JDsgX4aGk9PDJKzx2gGyEHoMX+PM6VPYwHvnnVFk31KxdTy84N9LYRJzXxW4TXXVIKLuIuwwGw1221F7CRTItyirf/cYCYM1O0A83UhT/pCq+Sxy2r/K1VirvczOUfGexPWIkQvhUee3cwMnlNCD1Aj+kR5xDcm0EzDKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460464; c=relaxed/simple;
	bh=Upw1QE4B7KJ9ldifL0YRpaGKViY72ufU30zj+m73Kjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDS/QjoM2PZ29zz1o20AjLq2LKqWzCz8YLVT1YTmGvHTkcU6XE0kpHMqW3hE7DnkOropBOfYwLiU/X3o99qRgfxFHzxe5wAi6bIlLSYRHvVsX0B2PU+uHesKtYI2WQOaz8bAKdCOHi15kd7T/7baDqhjmG5JjITsoNHF54Wk428=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0779098|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.584533-0.000241741-0.415225;FP=16768640395262875382|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.jDwVrZQ_1789460400;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jDwVrZQ_1789460400 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 15 Sep 2026 16:20:01 +0800
Message-ID: <88bfefec-8617-487d-a2d3-39348cf3ed3e@motor-comm.com>
Date: Tue, 15 Sep 2026 16:19:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 2/2] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260912065224.2723883-1-kyle.switch@motor-comm.com>
 <20260912065224.2723883-3-kyle.switch@motor-comm.com>
 <03664dd8-8f95-4ee3-8237-3c64febd90c3@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <03664dd8-8f95-4ee3-8237-3c64febd90c3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/15/26 09:48, Andrew Lunn wrote:
>> +struct yt8824_shared_priv {
>> +	unsigned int interface_mode;
> phy_interface_t
>
>> +	if (!of_property_read_string(np, "phy-mode",
>> +				     &interface_mode_name)) {
>> +		if (!strcasecmp(interface_mode_name,
>> +				phy_modes(PHY_INTERFACE_MODE_USXGMII))) {
>> +			priv->interface_mode = PHY_INTERFACE_MODE_USXGMII;
>> +		} else if (!strcasecmp
>> +				(interface_mode_name,
>> +				 phy_modes(PHY_INTERFACE_MODE_INTERNAL))) {
>> +			priv->interface_mode = PHY_INTERFACE_MODE_INTERNAL;
>> +		} else {
>> +			return -EINVAL;
>> +		}
>> +	} else {
>> +		phydev_warn(phydev, "%s, phy-mode missing in DTS.\n",
>> +			    __func__);
>> +	}
> Please don't reinvent the wheel. Look around to find an existing
> wheel.

Ans: okay, The next version will adopt the existing approach to define

and retrieve interface_mode.

>> +/**
>> + * genphy_c45_template_testmode - configure template testmode registers
>> + * @phydev: target phy_device struct
>> + * @test_mode: testmode includes Normal to Test mode 7
>> + *
>> + * Description: Set template testmode include Normal to Test mode 7
>> + *
>> + * Return: 0 on success, or a negative error code on failure (e.g. register
>> + *	read/write error).
>> + */
>> +int genphy_c45_template_testmode(struct phy_device *phydev, int test_mode)
>> +{
>> +	int ctrl = 0;
>> +
>> +	switch (test_mode) {
>> +	case 0:
>> +		ctrl = MDIO_PMA_10GBT_TESTMODE_NORMAL;
>> +		break;
>> +
>> +	case 1:
>> +		ctrl = MDIO_PMA_10GBT_TESTMODE_1;
>> +		break;
>> +
>> +	case 2:
>> +		ctrl = MDIO_PMA_10GBT_TESTMODE_2;
>> +		break;
>> +
>> +	case 3:
>> +		ctrl = MDIO_PMA_10GBT_TESTMODE_3;
>> +		break;
>> +
>> +	case 4:
>> +		ctrl = MDIO_PMA_10GBT_TESTMODE_4;
>> +		break;
>> +
>> +	case 5:
>> +		ctrl = MDIO_PMA_10GBT_TESTMODE_5;
>> +		break;
>> +
>> +	case 6:
>> +		ctrl = MDIO_PMA_10GBT_TESTMODE_6;
>> +		break;
>> +
>> +	case 7:
>> +		ctrl = MDIO_PMA_10GBT_TESTMODE_7;
>> +		break;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	return phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_10GBT_TESTMODE,
>> +			      MDIO_PMA_10GBT_TESTMODE_MASK, ctrl);
>> +}
>> +EXPORT_SYMBOL_GPL(genphy_c45_template_testmode);
> It would be normal to put this in a patch of its own. We just need to
> see a user of it within the same patchset.
Ans: okay, will be updated.
>
>      Andrew
>
> ---
> pw-bot: cr
