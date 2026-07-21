Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3E47CC71;
	Tue, 21 Jul 2026 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634328; cv=none; b=oNCdPmuRKvgosCZ6SyZ52ncxLJeVxPyFwgT53I6hazqYMYQkZRPbq0DJqtI0rpHya6jR1tGglYZ84oe+S2+2hGk8uE1Kl1W/TbsbD1EOxpqUcbWAYHw1ZR2nT5BA9gSbtrIbDRRb3MP69fTN5RMfOBr5S4YxdL67S9Q23k9xd6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634328; c=relaxed/simple;
	bh=0FJQKnTVMAYMufoxm0YthDSjCeAuvoA31LNmTDP+tzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZnSnLAodFP74osCNG6QUAG3aWBYGsB+yl+TjzJXlRJQfFZobt+vTDB6WwtQWVyGnTtw86UkXiGDxTLq0kNPkJcvLKxH5/j20FPna0L5PQOtryfXz5FuGaXdlqTfIiUM8OcQ5SRDRDAEuyDpuvm6XTyB7OLr08ciFkojaYX+vW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08930098|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.044324-0.00972623-0.94595;FP=16931123191131704947|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iR4KY0G_1784634311;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iR4KY0G_1784634311 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 21 Jul 2026 19:45:14 +0800
Message-ID: <2672de66-2be0-4946-9cc9-a21e2a7ae71a@motor-comm.com>
Date: Tue, 21 Jul 2026 19:45:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next v3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260717054807.1321374-1-kyle.switch@motor-comm.com>
 <06a5b8d1-f3a5-40e9-af12-52c5c9fd99e6@lunn.ch>
 <3d87f3d1-83c6-49b5-ac6f-59880c6a6c6c@motor-comm.com>
 <f3b70dc6-95ff-4add-8b1d-6534fe4dc3f6@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <f3b70dc6-95ff-4add-8b1d-6534fe4dc3f6@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/20/26 21:37, Andrew Lunn wrote:
>>>> -static struct phy_driver motorcomm_phy_drvs[] = {
>>>> -	{
>>>> -		PHY_ID_MATCH_EXACT(PHY_ID_YT8511),
>>>> -		.name		= "YT8511 Gigabit Ethernet",
>>>> -		.config_init	= yt8511_config_init,
>>>> -		.suspend	= genphy_suspend,
>>>> -		.resume		= genphy_resume,
>>>> -		.read_page	= yt8511_read_page,
>>>> -		.write_page	= yt8511_write_page,
>>>> -	},
>>>
>>> I still don't like this. Please stop diff deleting all these and
>>> putting them back later. It makes me thing something changed, maybe
>>> white space?
>>
>> Ans: I tried to refactor this issue by hanging the position of the newly
>> added code. However, the same issue may still arise in other code segments, 
>> without modifying the existing code.
> 
> Look at other patches on this list. Look at the diff generated. Do you
> see the same sort of issue? I'm pretty sure something is wrong here.
> 
> Try
> 
> git reset HEAD~1
> git diff -w
> 
> and see if you get a different diff. That would indicate there is a
> whitespace change you need to revert.
> 

Ans: Fix done in patch v5.

> 	   Andrew
