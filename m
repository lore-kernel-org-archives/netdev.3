Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEFA20B80B;
	Thu, 20 Aug 2026 01:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787188533; cv=none; b=DHVxkWzxu1IADUs7pfF9UBWaeWJHzmvLA+brTqT6vS640Wd9uzWsDb+jTKnwC67cPDOxO54sA7aQuPSMQZGm3F42w3bKVLMFgX5ifxUMa9YwgG+KWPfDxrz9XLxxHHBrBJ5JUgGqYRatpZJkJdoKCbfgNnnBnDE/5iEvGv3EAWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787188533; c=relaxed/simple;
	bh=HVl81FUkfzqxdgCe4i/LoT/opapDmNhADRh6bc2NgYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OncGSBP1P09Rwzzapdm387JNJdchQb7lVmsR5vw4btvtUB7VqmgH6YLtlAgfAE0/G7DXP+GBfkU1KLQIyoiGNwtWXWOFOe98Y4dVsCBltQlwgK7zKqkMZfl7BlSxxDPNDs+UqWMFf3KQCAcKTyoXItkmzhT9uOtogk1xIbyAK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2931211|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0127459-0.000384494-0.98687;FP=14627562493332982098|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033022149254;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iroXCgU_1787188525;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iroXCgU_1787188525 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 20 Aug 2026 09:15:27 +0800
Message-ID: <18ba6fe9-2d7c-4f46-b01f-3b73784e4237@motor-comm.com>
Date: Thu, 20 Aug 2026 09:15:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260817110626.510277-1-kyle.switch@motor-comm.com>
 <ddcf52a2-fba3-442e-bd82-106cf7f48ea2@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <ddcf52a2-fba3-442e-bd82-106cf7f48ea2@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/18/26 09:13, Andrew Lunn wrote:
>> +	if (link) {
>> +		phydev->link = 1;
>> +		phydev->pause = !!(lpa & BIT(10));
>> +		phydev->asym_pause = !!(lpa & BIT(11));
> This is wrong.
>
> Where do you see any other driver doing this?
>
> phy_resolve_aneg_pause() will set phydev->pause and
> phydev->asym_pause.
>
> You should be trying to use genphy_read_status() to do most of the
> work, and then mix in the 2.5G status information afterwards.

Ans: will be fixed in v12. The acquisition and synchronization

         of link status will adopt a more common approach.

>      Andrew
