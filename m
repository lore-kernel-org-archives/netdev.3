Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E4621254B;
	Wed, 16 Sep 2026 00:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519540; cv=none; b=PZXf+4Lk/VA0JiTGQMKEhePATTCoJp4dzX5901xnD/H0qj4DZg5gxCn+hibUKWwkg2nJq+3323PReVsZe1g9qs/pWzKpLIj2iCI5kEDKRD09ktyfC+2Ql0kEYfEI0a29x04LaQKXKD6hfO0N6I1SmkWt+BI1DtV34kr9GB3L9A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519540; c=relaxed/simple;
	bh=SJy0CJxKyWYTfkHIDSlYC2tKvszR5q7zLVBZrn+ydVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyFDGDOoncl3xhKsxHUCtT+7YA+t0uX6acZAiGaF342A7RkHYeL5OrnufaCHnP+Tv7eFXtbGn5EOJoyGAeKGnDmiC+JXTkEOH/t7T40Ht71Qag6zWizCzHELvuR0UsvkqV/qXmEuF0auE9zm/+m3lMZPzokgD/zsp/IUTDbXw0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09098641|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0979617-0.000473135-0.901565;FP=16786935194897668094|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.jEUwywK_1789519527;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jEUwywK_1789519527 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 08:45:29 +0800
Message-ID: <e137f7aa-4755-466a-89d4-e2868e20210b@motor-comm.com>
Date: Wed, 16 Sep 2026 08:45:27 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 2/3] net: phy: Add support for Template
 Control register for PMA
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260915082152.3104633-1-kyle.switch@motor-comm.com>
 <20260915082152.3104633-3-kyle.switch@motor-comm.com>
 <14de4b19-254b-4d45-9239-5a3badbbb73d@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <14de4b19-254b-4d45-9239-5a3badbbb73d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/15/26 20:18, Andrew Lunn wrote:
>> +/**
>> + * genphy_c45_template_testmode - configure template testmode registers
>> + * @phydev: target phy_device struct
>> + * @test_mode: testmode includes Normal to Test mode 7
>> + *
>> + * Description: Set template testmode include Normal to Test mode 7
>> + *
>> + * Return: 0 on success, or a negative error code on failure (e.g. register
>> + * read/write error).
>> + */
>> +int genphy_c45_template_testmode(struct phy_device *phydev, int test_mode)
>> +{
>> +	int ctrl;
> I would suggest test_mode is a u16, or at least an unsigned type. ctrl
> should be a u16, since phy_modify_mmd() and phy_write() etc take a
> u16.
>
>> +
>> +	if (test_mode < MDIO_PMA_10GBT_TESTMODE_NORMAL ||
>> +	    test_mode > MDIO_PMA_10GBT_TESTMODE_7)
>> +		return -EOPNOTSUPP;
> And once test_mode is unsigned, you don't need to test if its is less
> than 0.
Ans: okay, will be fixed in next patch.
>      Andrew
>
> ---
> pw-bot: cr
> 	
