Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B92B3446CE;
	Sun,  6 Sep 2026 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788660018; cv=none; b=kz1k4HMkwWTzteEDonm6Sy70C9DiTRtlXSbfGPzu3jRuMIkty6QcPMM8zk4yZZjHK+s6wvu7gSLKYdEElR5vCFD51led/R+KCDJbhALO41dvyEvorbZBf2zU+YsUhHLxBhcQOyLCBj/h/pR96fTrPw68ajA1YM6lMnuC/PWi9oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788660018; c=relaxed/simple;
	bh=zdnVE6OM4MlSPQ+Mqw/tgCCA+ygXGZeHe/xc5gIY2w4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/wRFrTE3o4ZVVZVp2ggEXuZQ6ovBDS8wQQGA32y+MQotH1P9vaUXpHC681P5HJGKavaUF4PW789kngNdQMEfw/Qe9AI8Zjp9IdQxW7HEB/br0pbQFaKUAWuMvykPmFaB1JLe6zkSfAwMqn4jOwB7fK3peRyUwGgMrMR86qa6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09186308|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.116061-0.000648473-0.883291;FP=3166778003519755808|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.j6gvpv9_1788660005;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j6gvpv9_1788660005 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 06 Sep 2026 10:00:06 +0800
Message-ID: <21081f00-e258-4fdc-98e8-32c53b5db812@motor-comm.com>
Date: Sun, 6 Sep 2026 10:00:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/6] net: dsa: motorcomm: introduce mib_init
 to control MIB polling initialization
To: Andrew Lunn <andrew@lunn.ch>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
 <20260904095416.1692962-4-kyle.switch@motor-comm.com>
 <47d2ccc3-c138-4691-8019-2bddbe9a548f@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <47d2ccc3-c138-4691-8019-2bddbe9a548f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/4/26 21:45, Andrew Lunn wrote:
> On Fri, Sep 04, 2026 at 05:54:14PM +0800, Kyle Switch wrote:
>> Add a mib_init flag to indicate whether MIB polling has been
>> successfully initialized. This prevents the driver from attempting
>> to clean up MIB-related resources on removal for switch families
>> that do not support MIB polling, which would otherwise trigger
>> errors or crashes.
> This one i'm not convinced about. At some point, you are going to make
> initialisation of MIBs conditional. Why not use that condition to
> control removal as well a setup? Why do you need both a conditional
> and this pp->mib_init state flag?
>
>> @@ -4771,6 +4772,7 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
>>   	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
>>   		struct yt921x_port *pp = &priv->ports[i];
>>   
>> +		if (pp->mib_init)
>>   			disable_delayed_work_sync(&pp->mib_read);
> This looks odd. When adding an if (), you would expect the next line
> to require an additional indent. Was the indentation already wrong?
Ans: In the next version, we will modify patches 3/6 and 4/6 of this series.
>      Andrew
>
> ---
> pw-bot: cr
