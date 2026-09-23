Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67343BB40;
	Wed, 23 Sep 2026 01:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790125684; cv=none; b=q2qGGmlcerk6g3GGdB7YRrnVWikSd/k6naVbonP1czG26cP3RZxk5KR0K8jMahg1XXMoUzGz9GA4+6nBBHWQp9qqDkZqNW6qKZlBGAfEh81LWYpugmvh3L9KR3OG0u1fPHXMlV3kgQhlP2WB4VDWYqrFWtuN058fkrEwTOOKDYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790125684; c=relaxed/simple;
	bh=Cl6M25MbGKAUkLudFpLqIbyV0WfSAp98zFid4MxGhLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgmsiY68AMQHVlul6huvv/FWS0ZWtabpCs1dMicewtufNGCqJx0xVml8XydH8cR0fP1fkyvZ6eN/toiVCkATrGnx9nMHuRj2nhQ3YHdKAQH12iFlR7GIedtW+2yurfHJ709Kofug1YHijkXOBaBfWhadxfu0fxmz99zb+lM7sBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1299984|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00690652-6.2799e-05-0.993031;FP=17003242350029999494|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jKUqOj9_1790125676;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jKUqOj9_1790125676 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 23 Sep 2026 09:07:58 +0800
Message-ID: <68f0b522-1795-41bb-bb13-33a29bf3d1b9@motor-comm.com>
Date: Wed, 23 Sep 2026 09:07:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 2/6] net: dsa: motorcomm: use max_ports in
 series for port bounds checking
To: Andrew Lunn <andrew@lunn.ch>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
References: <20260917082236.3427168-1-kyle.switch@motor-comm.com>
 <20260917082236.3427168-3-kyle.switch@motor-comm.com>
 <e54c308b-3297-4abc-af95-5ef9c925931f@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <e54c308b-3297-4abc-af95-5ef9c925931f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/22/26 20:47, Andrew Lunn wrote:
>> @@ -402,7 +403,8 @@ yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
>>   	mbus->read = yt921x_mbus_int_read;
>>   	mbus->write = yt921x_mbus_int_write;
>>   	mbus->parent = dev;
>> -	mbus->phy_mask = (u32)~GENMASK(YT921X_PORT_NUM - 1, 0);
>> +	max_ports = priv->series->max_ports;
>> +	mbus->phy_mask = (u32)~GENMASK(max_ports - 1, 0);
> A separate patch, but can this be changed to GENMASK_U32() so the cast
> is not needed? There maybe be other instances in this driver which can
> be changed as well.
Ans: okay, will be updated in next patch.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>      Andrew
