Received: from out198-27.us.a.mail.aliyun.com (out198-27.us.a.mail.aliyun.com [47.90.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E8E36167F;
	Tue,  4 Aug 2026 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843845; cv=none; b=XA7kEn3HE5K4Vb/V0A+IdQX74x0J5p5tRnahZG9pdmUnNN13agDwpnyef5UYW9M13ZNhsp5i0QHkn6TekxlcuLHH0oNa7PzYKsW0rWIxXu3PJwzotQZjODppekXFAYwrTO+Y8S04UKNRc8dSQOTJOKHWxxHy/AOkUc9u9cEZllE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843845; c=relaxed/simple;
	bh=ti3Duy4rA6W1jj2Xmti4fPitrh18w/Jbz4O3kVl/RHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVg+tFYj7dqfCkDiGSLTslPnkJGDhOT2pcQSUykATJlw8ipmUMZvCrSEzwtx5b4FIx/d2x1UtLy4YUwNctpgj6othPCT2yGSFfy3UZlhqioZyKLDMrOje9cIWK4qFzomCBU7GuqNV9zw52MQ/aOo5C/5WHASDfUzDwmtSQy2SJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07975866|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.116667-0.000224523-0.883108;FP=11247112880801763570|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.idWJpQ-_1785843816;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.idWJpQ-_1785843816 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 04 Aug 2026 19:43:41 +0800
Message-ID: <c8544727-853d-4513-9025-b3260044c930@motor-comm.com>
Date: Tue, 4 Aug 2026 19:43:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260801035236.3560015-1-kyle.switch@motor-comm.com>
 <50f7c213-0791-41e3-9eac-049ce87ee260@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <50f7c213-0791-41e3-9eac-049ce87ee260@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/4/26 04:49, Andrew Lunn wrote:
>> +static int yt8824_config_aneg(struct phy_device *phydev)
>> +{
>> +	int phy_ctrl = 0;
>> +	int ret = 0;
>> +
>> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>> +			      phydev->advertising))
>> +		phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
>> +
>> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN,
>> +				     MDIO_AN_10GBT_CTRL,
>> +				     MDIO_AN_10GBT_CTRL_ADV2_5G,
>> +				     phy_ctrl);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return genphy_config_aneg(phydev);
>> +}
> 
> What i'm missing now is some explanation why this is safe. What is
> stopping something from changing the page after the call to
> phy8824_page_write_with_lock() before genphy_config_aneg() completes?

Ans: The assumption that there is no problem here is based on the handling of 
     the USXGMII reg space being error-free, especially that the swap back to 
     the old reg space has no errors. However, this may not be correct. 
     For example, if yt8824_sds_isolate_paged() completes its processing, but 
     an error occurs when swapping back to old_page—meaning the switch to the 
     UTP reg space does not happen—then this assumption would be incorrect. I
     miss this scenario.
     You may be right that a high-level lock is needed to ensure that UTPs do 
     not interfere with each other. I will update it in v9.

> 
> 	Andrew
