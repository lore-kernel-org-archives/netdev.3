Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CCD3876A4;
	Tue, 15 Sep 2026 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460304; cv=none; b=LjcHTwkoazhaKZCZwFaKUzQz4QnuDBW/LrQkE/dJ6JRXXHOEkGfFrDgN1EsgvB1PywdYIDArE8Dp4lHQReUZGriLJetW3CAtRoirFB8hAoNJ/9hhHZgsBwSKs5KZa0WEF8/4pqLhsq+GtJ+LwmFePcyC9K/xSYNdSlzCr6zgrhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460304; c=relaxed/simple;
	bh=ieoU48RBV77xjZtkHFGV0rx9vh33zE1V23UHbbNjHL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtwB6wvWAZNs5BRVGa9wGQ0ZA+MpYnC4/TNyhuO2bvsHBhbTDbEyJzBEdC3jTl4WiT6lX9LAaLAw5Jidjsb/lyK4br3wS0tAyyRdCzKAzqYjly8GAOSj4L6ieHUWHXZpA482Kk2IVnwp2SiW4eREJsMR4FaUdml8+v5QS6UDqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2097744|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.787375-0.000208565-0.212417;FP=3234824456992474950|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.jE598-K_1789460288;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jE598-K_1789460288 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 15 Sep 2026 16:18:10 +0800
Message-ID: <1e795205-212a-4ad4-9ba5-b3d0c7fb2d62@motor-comm.com>
Date: Tue, 15 Sep 2026 16:18:08 +0800
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
 <77c43c66-98f8-479e-a3ab-8717b8132be9@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <77c43c66-98f8-479e-a3ab-8717b8132be9@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/15/26 09:57, Andrew Lunn wrote:
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
> You should be able to simplify this using FIELD_PREP().
Ans: will be fixed in next patch.
>
>      Andrew
