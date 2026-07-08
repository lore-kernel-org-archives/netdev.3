Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB243800D;
	Wed,  8 Jul 2026 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535261; cv=none; b=PIBTtkR67XtWZAFFjO9oICSCrKc6N/CWO8AlUGc0wcLCI4fg5EH35zWE2mBcJ1pSmXdUH3EMIP0Hg/NOqq1cyQEJpuE4Qbt6VI8Z4UG/x/STSyQ8EGuReI5bgB3o6ACL+YwfXbGHi4tREo6KMPK/QTP0CX5ed1N7IqPc13jL+yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535261; c=relaxed/simple;
	bh=/Clcg5W49fBSfL0SR2mQDWbxpt8lcd/KGT45zBqE2OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBg3lXPTt6KR+kWxWCU0dW4R52wk6CgSNulS/Yivwmx6+n54h0aj4V+6I6BNSW7DFkhActdbOU/7a83oNTHiM4vCrCvFN7kJsIliNzQu6RfrwDHRXsWup8JG9TRH8FCpOAMLL4/HvDjIHWKKp8E02cT4cTrGro0pYvvh2BNIIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=NQ8w0Ns0; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=VrQiw1AX; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="NQ8w0Ns0";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="VrQiw1AX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783535258;
	bh=/Clcg5W49fBSfL0SR2mQDWbxpt8lcd/KGT45zBqE2OY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NQ8w0Ns0sMDpcxo56FYrlRW/4dVTE2c5t+BOp7S+vYSyEcrkJamMg6RKHdRs+Ufc9
	 stm0g4g2q21AL/gxFpafIMpNbdX1Wd6AtCFN/ifbhrn213vefmRP+Vf+v9cmdnyQCQ
	 qairUvNPdr4Skvvhm8AEAlU/hTxcNOz7D1VVw2YbChKUDsFFGJPYk7j4vMgS+P0oWH
	 RxfTZ3pNVOzTf7ZJgyxcODSn8yjeMvCcb/g9YSo4cAl7N45fe7FXJeOYV456f68HmZ
	 wseWEtVrlQB6RH6Mh2KLPa4E+9DyjbX4O1kWoUWnT+sW214P89iqG6RaWqX7yZwGkT
	 vgp28RlXM/VVQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 49E3A493F1; Wed,  8 Jul 2026 18:27:38 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783535256;
	bh=/Clcg5W49fBSfL0SR2mQDWbxpt8lcd/KGT45zBqE2OY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VrQiw1AXARNU6X4FGPQhC5hJnwn5L8jbeJ/P6hBM7Ao69CA9z240azFFJd6G3IPvO
	 jDi78qFXX/62lAU9C2ynYqW4/Kt7iTovv85mz3oKWstUY/YoKgIj4Dek0bxPLs/Evz
	 ivVDOwKflIMrXpFKbZ/KeqFckCbnyIW+zAaHQKzJW5NgUtE03OXGhFsdQclOMp3HQ5
	 GECHH6pcSOQrJGygGxbIrysDeEErJAr1H5QMQOm6WNCle6F0WI5mPuAAOOUQ38rRu9
	 dtKxHQhLwAAhOOG/0gQPCVp5nC/eo/nyFbtG16WEuNpEqmpeKdmbd/ZUEEVUCeEjB9
	 Z3ehZdubkpSAQ==
Received: from [IPV6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd] (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 01F1C493D0;
	Wed,  8 Jul 2026 18:27:35 +0000 (UTC)
Message-ID: <dadd3b8d-fab8-4ad0-9167-e46132a1db1f@birger-koblitz.de>
Date: Wed, 8 Jul 2026 20:27:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] ax88179_178a: Add HW support for AX179A-based chips
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-2-13685df67515@birger-koblitz.de>
 <6b368510-05d4-4d73-b588-8002d0d59915@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <6b368510-05d4-4d73-b588-8002d0d59915@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/1/26 17:05, Andrew Lunn wrote:
>>   #include <linux/usb/usbnet.h>
>>   #include <uapi/linux/mdio.h>
>>   #include <linux/mdio.h>
>> +#include <linux/if_vlan.h>
> 
> Does this patch require this header?
Yes, because of the use of __vlan_hwaccel_put_tag later in the patch.

> 
>> @@ -414,7 +570,6 @@ static int ax88179_suspend(struct usb_interface *intf, pm_message_t message)
>>   
>>   	usbnet_suspend(intf, message);
>>   
>> -	/* Enable WoL */
>>   	if (priv->wolopts) {
> 
> Please try to avoid changes like this.
Fixed in v2.

> 
>>   	/* Force bulk-in zero length */
>>   	ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL,
>> -			 2, 2, &tmp16);
>> +			2, 2, &tmp16);
>>   
>>   	tmp16 |= AX_PHYPWR_RSTCTL_BZ | AX_PHYPWR_RSTCTL_IPRL;
>>   	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL,
>> -			  2, 2, &tmp16);
>> +			2, 2, &tmp16);
> 
> Please put white space changes in another patch.
Will be removed from v2.

> 
>> +	/* Initialize MII structure */
>> +	dev->mii.dev = dev->net;
>> +	dev->mii.mdio_read = ax88179_mdio_read;
>> +	dev->mii.mdio_write = ax88179_mdio_write;
>> +	dev->mii.phy_id_mask = 0xff;
>> +	dev->mii.reg_num_mask = 0xff;
>> +	dev->mii.phy_id = 0x03;
> 
> If this device is going to have a long term future, it really should
> move to phylink.

As discussed previously, I started converting the code to phylink,
but for the PHYs implemented as IP-cores in the the AX88179A-based chips,
the behaviour of the PHYs is so different from their discrete counterparts
because of other firmware used, that even if they have the same PHY-ID as
their discrete counterparts, they behave entirely differently and in a
way that is adapted to being used via USB as part of a USB-Ethernet
adapter.

Only few of the USB-Ethernet drivers presently use phylink (asix,
lan78xx), btw.

Birger
