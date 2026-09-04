Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724094570FD;
	Fri,  4 Sep 2026 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514505; cv=none; b=d3J+rwIO0J8tPvMMwoHM4smm11jsU7BQNG1sqkv1WAoRfTnKpWuWhSIRvhJ6Nn5VSy6pjcttR3x+yenyJYtpa93XMeOlkZcZeGrPlfskVy24WkephuiiVEK7Y7YRMPiTKfuCe2i6YjVEnZKrcltOpVtQhNVJFciB9y1OUsbHdS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514505; c=relaxed/simple;
	bh=i4txPTwdLHWMzUZX/Pc40wYcfscunYHA0BHDf3sg8oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3TKgF38q9kNLaSKLctUKcqtl9Yng0DxCdnR0T8aRCMXRo85JNaHAz5UbEZoe/LiowaK5amiC92rITzY0bCi2KE9PnHoZMENCq/dnAqbQygm8877hr+UA67EsVTqD911yQqhPmssFjzoNVAEQSzdv5r6msFQTD96AVfyRR9/KLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07812227|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0339435-0.000440438-0.965616;FP=7634499340052119369|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.j5O83XJ_1788514495;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j5O83XJ_1788514495 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 04 Sep 2026 17:34:57 +0800
Message-ID: <6db0ab1b-3b37-4c4f-802a-bac196062caa@motor-comm.com>
Date: Fri, 4 Sep 2026 17:34:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: dsa: yt921x: Optimize driver for better
 generality.
To: Andrew Lunn <andrew@lunn.ch>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com
References: <20260902024737.587386-1-kyle.switch@motor-comm.com>
 <b91e38ca-7ef6-44c6-89c0-79419cba57f3@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <b91e38ca-7ef6-44c6-89c0-79419cba57f3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/2/26 20:29, Andrew Lunn wrote:
> On Wed, Sep 02, 2026 at 10:47:37AM +0800, Kyle Switch wrote:
>> Replace fixed macros with values defined in series_info
>> for port validity checks, in order to facilitate future
>> adaptation to more switch series.
>>
>> Replace all fixed values for DSA switch attributes with
>> values defined in series_info, to enable better scalability
>> across different switch families.
>>
>> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
>> ---
>>
>> v4:
>> 1. Split patch into multiple patches
> I still only see one patch. I was expecting to see a patch series of 5
> to 10 patches.
>
> This one patch still does multiple things. It needs splitting up.
>
> Please subscribe to the netdev list. Spend 15 minutes every day
> looking at other developers patches. Look at how they split up
> changes. Read the review comments. Follow a patch series from v1
> through to vX until it is merged. If you see review comments which
> apply to your code, please fix up your own code.
>
> You can learn a lot this way, it is worth the time and effort.
Ans: Thank you for your advice. I may have misunderstood

your earlier comment regarding patch splitting. In the v3 version,

we actually divided the patch into three parts: the tag, the DSA driver,

and another component. However, it appears that due to email

configuration problems, only the driver patch was delivered.

In any case, we will ensure that the patches are split by functionality

and post them accordingly.

>      Andrew
>
> ---
> pw-bot: cr
