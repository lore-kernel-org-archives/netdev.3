Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490440;
	b=r9d/RqggG0Te5UnVFmAEVO1DTENcYuOoNz8OFe/2UVUc2EH//BvloRxJl19GpT9zNOHM
	 cDvv22WMLaHPdc34ksqH76byjHDCFKQ7qu26ksEqJ5G2r6sAMU53KV3lbgd6ll9DmaVQu
	 ZmRkIJ3rzms0DS0f6ZXyAjLVvv9gV1W3IlF8iE4AOTuhOx8P1sjZtRTQSp7y8mBina7UB
	 UoyF9I96XbaGhYZFypU41o4OuHzKQVNDDG02uW1X5Wm0I7JJasMdvVX2ZPh3+v4ewenKY
	 yG/UclFKnXOTOCiNP0yQWRobjF25bxWpuCN0C1X3HUcYkA0rkclyOr3ZVZm+ipryP/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=FwL/KWXkezDHAFArKAWV6uoJFctTAPwUR8TBzgDQZkM=;
	b=cgnul73lf0n0MBibk275d/b1jp3/gujdkQ6qZvWo9wCksaUmiFqEF9spt1RMj2R/oocS
	 puL23XBsMe8ediiBzUW6xdDhatiVxV7vdL8EMammJLgkSaCFXoTF/YBy2DUu85wgCvGwN
	 wOme96Ck1yS22KPisRcI9kub1PtYmR8hQQxPEK5+/ifmXhfxlmfkPgQovvNwGnTcGIY9d
	 l1YkknMasjXiOmAXY9vvHayMTGzvvH34E/ybUc9rbrjqYSYp+Wlb9SAkIOshqJINVg1EH
	 djiwSvNmS9gkMQmB0rkbb80hs2jR68tJqJLft94Dvq2fjNT4B1noQEmvDXm2KlEqBpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mXJNNx/2";
	arc=none smtp.remote-ip=74.125.228.139
Received: from mail-ej2-f11.google.com (mail-ej2-f11.google.com [74.125.228.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CFD606A32A
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28CFD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mXJNNx/2
Received: by mail-ej2-f11.google.com with SMTP id a640c23a62f3a-c504c069dcaso214425866b.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 05:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794490437; x=1795095237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FwL/KWXkezDHAFArKAWV6uoJFctTAPwUR8TBzgDQZkM=;
        b=mXJNNx/2D9bvkGxbL6UWwG/avIeDGrhci2v0aMLsxA7DT/5Yz4ftOHqj59EKRfh4Zz
         d07QlHaS+8sKpB3jabucAJ5AqTKh/l0io+O8RDSnOThAXqYvo6lhIjVf6MuYqgq0LcUf
         Gfuhs3ZIyBVcb3hrtL9AK4ezUgGPq7m3550CFYJg5te+Am2IfAMWUThiRfIXcnq/bC2n
         V1xOD6v21IgJzmUi85ke8xToh16MDap6S+Uvy9RRpT6Q+utqLJC7h5Cel+B1dU+dqUAv
         cWC0li+6766Zs6EcZ0ua6EFtmxEYjkt56zyRXuRos7dCTE6oRa/ZQ29MERH9mwQd1qeN
         4tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490437; x=1795095237;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FwL/KWXkezDHAFArKAWV6uoJFctTAPwUR8TBzgDQZkM=;
        b=W7b3F6W5MkSpeizX3IBbEZJcyML5ZjMkUsKGbjkq97lf4P8yfqmVsEE11HGDbc3M2P
         9C+mVoqu/ft62AX5MFNEZPm2DvATTf7hp0XbDOcN6yug+3iSTtDHtmDOS/fqxUzsDiaw
         SCuncS8hgbLXuubTX+p4xUbTgsPHoI6GEd9ne4e72Y/hyFzJWLMvunkKlTwuWrakGStc
         byAFkcUbQM7rZs4RVmSzO5fUVEJMCGbd+jQo0GrU1V/Z4Dj7C8oPrp0nlynJZHCB2pP/
         3aLfLIyYYM+Kgru6qdVpB7mNTYj1NqBvv5Y4ixXUSaOIQX5ea0J+25zJ6nl4tpt6fROf
         CRQw==
X-Forwarded-Encrypted: i=1; AL+hErE4xFDwBPOsDlAa18r1MWRp0dal5xipK0URYJ83Z5h1Fl+VKrik5j0G+jVoME/ZzLPLKZWD9Bg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gXq1ck5SGSdK+393DakUOAFbLRLHY0+K0qZTl/tDm4NYjAxw8
	scrnpn37nsiZpMTITkzJGj3LBuXhD55bUxIbSVaU7UNA0II2fPmpDmHh
X-Gm-Gg: AYBFou0jx/Xt3nJdwnEnlxHu1vCBCqLiUhcQxjK2eruazhfqCypiUHGbrc+RPnfOPBX
	e3ccuyOlRwTxc06txHntYMrhfCu/BnJFX2nYuYHDIwKAbMO6Ot933RHUqb0H0ePlWUMOD2AK8m5
	OF137q2Cu9NwvCKbPj5f4Hr8/40ND732kZmGD12HZAsK/cpHolPzA5t7k7sjyd3DMID5qB3TDs7
	FPljQH72jv93zZlM4sk8cg2EjUWFB3IkkDw72mZqW+W1H2XfJxTVuRlmUQv/5oZS2ZmlRiHFasg
	z4cPsnESv0+YATvRYUfqiyi9SWtr47nNSnX5Ngg4QYGZVHYRwveHpdG01EtIk3QlS0gzLY4qWJT
	+FmdGb2UQUG4rE4R2HIO73P4YgIYnu8P259xUpdBSSjq+NSZ++zKWWN2L33H3aetFKcAsQV1xF+
	NXR8C9KgCj1J0MraxbdYGQbUri3yg43FB91tSpRYV+rUv4ocYXZeC9cXwunHsmMFIHVc/0/hSmv
	xkPqLOweB9tbvcnjiZNAhOx8zWc/G+MWj9wVjc0h93mCZjHGRFRNx1OT0In8uDGMa8mbjONu0xR
	d7tWoOP74LWbNoMkYHzmC8/kLo1SxQIa6qlRbA==
X-Received: by 2002:a17:907:868a:b0:c3e:34fa:611d with SMTP id a640c23a62f3a-c5066b51879mr464464066b.35.1794490437222;
        Thu, 12 Nov 2026 05:33:57 -0800 (PST)
Received: from [192.168.100.182] ([45.249.9.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a3a6947sm353760066b.10.2026.11.12.05.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 05:33:56 -0800 (PST)
Message-ID: <e11f1ba6-6e56-4bac-a0cb-f9258a53f34e@gmail.com>
Date: Thu, 12 Nov 2026 18:33:51 +0500
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: spacemit: Hold RTNL lock in emac_resume() and
 emac_suspend()
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Vivian Wang <wangruikang@iscas.ac.cn>, Andrew Lunn <andrew@lunn.ch>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yixun Lan <dlan@kernel.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tomas Hlavacek
 <tmshlvck@gmail.com>, Muhammad Bilal <meatuni001@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261105123441.2524171-1-alitariq45892@gmail.com>
 <DMO13SWAGZAN.NYISGLGI7Y5A@linux.spacemit.com>
 <c55c5878-d9c1-4863-bc55-99d334ba2ede@gmail.com>
 <12a95b3a-9c8b-4a2d-9b81-12b3839e64a9@lunn.ch>
 <DMPNAPNEGQ5I.XYUIB7Y8HDCA@linux.spacemit.com>
 <ee3f414c-fffa-41e6-8bec-6af7ce676c4b@iscas.ac.cn>
 <DMQJ0R4QTE6R.2I492KA9N85CB@linux.spacemit.com>
Content-Language: en-US
From: Ali Tariq <alitariq45892@gmail.com>
In-Reply-To: <DMQJ0R4QTE6R.2I492KA9N85CB@linux.spacemit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/9/26 1:10 PM, Troy Mitchell wrote:
> On Mon Nov 9, 2026 at 7:59 AM GMT, Vivian Wang wrote:
>> On 11/8/26 15:19, Troy Mitchell wrote:
>>
>>> On Sat Nov 7, 2026 at 5:32 PM GMT, Andrew Lunn wrote:
>>>> On Fri, Nov 06, 2026 at 03:44:50PM +0500, Ali Tariq wrote:
>>>>>
>>>>> On 11/6/26 2:43 PM, Troy Mitchell wrote:
>>>>>> On Thu,  5 Nov 2026 17:34:37 +0500, Ali Tariq wrote:
>>>>>>> @@ -2056,7 +2059,9 @@ static int emac_suspend(struct device *dev)
>>>>>>>    		return 0;
>>>>>>>    	}
>>>>>>> +	rtnl_lock();
>>>>>>>    	emac_stop(ndev);
>>>>>>> +	rtnl_unlock();
>>>>>>>    	clk_disable_unprepare(priv->bus_clk);
>>>>>>>    	netif_device_detach(ndev);
>>>>>> This can deadlock. emac_stop() -> emac_down() calls
>>>>>> cancel_work_sync(&priv->tx_timeout_task) with RTNL now held, while
>>>>>> emac_tx_timeout_task() starts with rtnl_lock().
>>>>>>
>>>>> Thanks Troy, that makes sense.
>>>>>
>>>>> For the deadlock, I think the correct function to call is rtnl_trylock()
>>>>> inside the emac_tx_timeout_task(), which would return if the lock is already
>>>>> held and will hold the lock if it is not.
>>>> rtnl_trylock() is generally a workaround needed for badly written
>>>> code. Please try to avoid it.
>>> Agreed. If the reset is done in place, the work does not need RTNL at all,
>>> so .ndo_stop can keep cancel_work_sync() as is.
>>>
>> Thanks for the diagnosis and suggestions.
>>
>> Although, maybe we could simply avoid cancel_work_sync() in emac_down()?
>> emac_tx_timeout_task() checks for !netif_running and does nothing if
>> already down so it should be safe. The task cancel_work_sync() in
>> emac_remove() does cleanup on unbind so the task is not leaked.
>>
>> This seems to be the pattern in other drivers as well. What do you think?
> That was my first thought too, but I'm not sure netif_running() is
> enough here. emac_suspend() calls emac_stop() directly, so
> netif_running() is still true and a pending work would stop the device
> a second time. And since the netdev is devm-registered, emac_remove()
> runs before unregister_netdev(), so the work could be requeued after
> the cancel there.
> 
> So we'd still need to cancel it in suspend and remove, and at that
> point resetting in place looks simpler to me. What do you think?
> 
> 

Thanks Troy, Vivian and Andrew. I'll drop rtnl_trylock().

I think a simpler approach here will be to go with Vivian's suggestion
of dropping cancel_work_sync() from emac_down(), and handle Troy's two
cases by disabling the work where the device is stopped without the core:

1. Suspend: emac_suspend() calls disable_work_sync() before stopping
    the device, and emac_resume() calls enable_work(). So the work
    can't run while the device is suspended.

2. Remove: emac_remove() uses disable_work_sync() instead of
    cancel_work_sync(), so the work can't be queued again before the
    devm unregister_netdev().

For a normal close, the work's existing netif_running() check is
enough, because the core clears it before calling .ndo_stop.

With this, nothing waits for the work while holding RTNL, and the
work doesn't wait for itself.

v2 will have two patches. First the TX timeout fix (reported by Troy) 
then the suspend/resume patch, which will take
RTNL after disable_work_sync() and before the netif_running() checks.

If you still prefer resetting in place, please let me know.

Regards,
Ali

pw-bot: cr
