Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62411407CDE;
	Wed, 10 Jun 2026 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095033; cv=none; b=doXr7aUUkSFB4o+5iH0YfpaU48kc9YD4/EWh9fELQM4JMGpwPfShFEGx/M9IQKZyfe+T65G6PMTkjQB+zuvX/tNNXTP0ND4kdPzMei3l9pDrcN3CGGmYJO25f2qtFjOX1Lp3jtFrNHI7MJM1kXBF32lo7VGxCVLdJi0w43J/+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095033; c=relaxed/simple;
	bh=KM5hnWieQE+6grrCVkCmYWDnAvRe+9Yjquc+9atC8Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dV0+YREQs3/Gpoi28tpODSRu/Sn7wTfhH0atDjTWd3qVr7lv5edHi5uK3KdLA91vkg47pTEa0wrJVSCcxs1gaXSLYH0COWMPfOiFDCgGlmV0pnShBtZn0q2vFWLfbEKCbNwX7WWb5XKjtwm2YbLxdOeefGp1UsK4xTX7ROZpmNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCFTUdmI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCFTUdmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391731F00893;
	Wed, 10 Jun 2026 12:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781095031;
	bh=jpM9dV28IgCGkNk5c7gDITLS1K5veCZwAlZ+WvOTSVI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bCFTUdmIgwwUyfrPkan4OH9FVlzemH5SpsHDsJJIp+XjQTv7D/M9bfj8cJcePk0AD
	 X7UiRY2046HvpjVqQ5YRx0evnuASNya9yejeLkQuG0+yjD+e+o/49s7rwzhs/SsqpU
	 9vJ0NiW4TQkUB8L+KW15PZevOshHtC7CUWvT3IxuHpiif9q5QB/W6QS67ulz/loQ+c
	 SSZTKeOdeWSoNPi6fbS9ZW7rXcUVSKCaamHh6RR1qD9rvBkJbaAhgAuGeM9fkJ6IUS
	 f6t3BFG7jUCCvj5gutUYmra69fTDERJ0CWj6Bu0lhOsrv8J2ktIpeKIT2JEjGvQOMe
	 ioSobPgOwsrhQ==
Message-ID: <79995d31-ae82-4f2b-a2d3-036037ae1ba2@kernel.org>
Date: Wed, 10 Jun 2026 14:37:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/5] veth: add tx_timeout watchdog as BQL
 safety net
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-4-hawk@kernel.org>
 <60c82009-790e-4be9-8651-309b14a6f55d@redhat.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <60c82009-790e-4be9-8651-309b14a6f55d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 04/06/2026 10.24, Paolo Abeni wrote:
> On 5/27/26 3:54 PM, hawk@kernel.org wrote:
>> @@ -1819,6 +1836,7 @@ static void veth_setup(struct net_device *dev)
>>   	dev->priv_destructor = veth_dev_free;
>>   	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
>>   	dev->max_mtu = ETH_MAX_MTU;
>> +	dev->watchdog_timeo = msecs_to_jiffies(16000);
> 
> Since a repost is neede it could be possibly usedfull using a macro for
> the above constant and expanding the math leading to the actual value.

Makes sense to move to a DEFINE.
It might be practical to use in veth_set_coalesce() as I guess we should
enforce tx_coal to be less-than the timeout.

> Also possibly an additional + 1 to avoid a very unlikely false positive
> on exactly the maximum possible interval timer?

I don't think the +1 brings much value, because this timer is jiffies 
based so do don't expect to hit exact value anyhow.

--Jesper
