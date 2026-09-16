Received: from out198-11.us.a.mail.aliyun.com (out198-11.us.a.mail.aliyun.com [47.90.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5BD30D3FE;
	Wed, 16 Sep 2026 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519506; cv=none; b=VpB27GZSX0j8fSU/k9Iu5qwZVJ/SSTMW1LwpQDQjnxY+04BxiD0iHweVdcA3u+ZzGcXhu+sHyzIFtAYFIRK/A4pLaaD3vFFknX5rC/2zoTdnkcOS7iOX+9fRJfrdInc/KXEyk81udY2thLFro0r8mwluuPYeRkIoXJOCCCFU7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519506; c=relaxed/simple;
	bh=rCEC5XFahmz+zw5p3XDO/HvC2RTY4PZomMuy4HTsGAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFyCntOQ9N3eTZMkueArbZr7LxtGPuVUd53qjZc95cUzl36T2Tb/tqGcfqFBvar8hwd/f7ZVxz4v1BM4q8gFCWuqEgEBdWy8l4OsgfSINf7PVd2MoYoHfBOcXAP9i6XMtrkNIZkmvkLZp3NrWZxbpaCQMUOCziYKaapRUX8C/VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08043806|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0385799-0.000201561-0.961219;FP=5194741222436556406|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.jEXYnJE_1789519482;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jEXYnJE_1789519482 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 08:44:44 +0800
Message-ID: <9d05be62-4911-430b-8c8f-c64930aadb76@motor-comm.com>
Date: Wed, 16 Sep 2026 08:44:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 3/3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260915082152.3104633-1-kyle.switch@motor-comm.com>
 <20260915082152.3104633-4-kyle.switch@motor-comm.com>
 <46ad6aa9-c71c-4bea-b997-f2ceb57adfa6@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <46ad6aa9-c71c-4bea-b997-f2ceb57adfa6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/15/26 20:31, Andrew Lunn wrote:
>> + * yt8824_utp_invalid_test_mode_paged() - config YT8824 to invalid test mode.
>> + * @phydev: a pointer to a &struct phy_device
>> + *
>> + * Returns: 0 or negative errno code
>> + */
>> +static int yt8824_utp_invalid_test_mode_paged(struct phy_device *phydev)
>> +{
>> +	int ret;
>> +
>> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return genphy_c45_template_testmode
>> +		(phydev, MDIO_PMA_10GBT_TESTMODE_1);
> MDIO_PMA_10GBT_TESTMODE_1 is defined by 802.3. How can it be invalid?
>
> Is the description wrong, and this hardware does not support test mode
> 1?

Ans: What's expressed here is switching to a test mode — other modes

         would work too. Here it defaults to switching to testmode1. 
Later on,

          I'm considering either renaming the function or just renaming 
directly

        to testmode1.

>
> 	Andrew
