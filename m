Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4234678E;
	Wed,  8 Apr 2026 21:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775683282; cv=none; b=hobeABWCqwWjEIancos8Ssv3ORahLoEGEIQYWrFveAo5PQgh45GLEOQbt5Ra67DUyYNKyEA2a9o1FW1HPYn6OINpYJSe2/XZbAQiE5+1Yiwqa54sNU9rjjfO2WNC0LE+LxHiCfLP/KBr7AYXQNh7ZsFbojEXfBNkyWYZFphxg40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775683282; c=relaxed/simple;
	bh=AEwBmXrl+P16SqUF2Qjge5a9ctCanzTapuzBGGZSjt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOG6yhkFqcCd6ab9LRTTTxSbG0dDKmZ9hTfNGmj4GoRjdndZuAX59heN7D8G8uJt6tNgbekfuSmqG7G3rMaTBIBDY+doMhcvzrF4MGtQALH8hzDIFngIE8HcBceiwPtQY0YZKT7lsS9DNNaHfGcFmR8ukFuoZ2jAFvgGCfrYxso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Mb3dBzL7; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Mb3dBzL7"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5FB410CDF1;
	Wed,  8 Apr 2026 23:21:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775683278;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=uaQTp3lW1Nn3Bm18LOgfOavd2o3IuyanrZ2oFpQZfsw=;
	b=Mb3dBzL7w3uZkoLxmIWweEmb+utEqksb4jBOPS0MMieVqc40Gezv7M4MEisumb46aXvUM6
	L/R+nsCvBjImxWfxng5RC7db480d+L6o9wMwazpsAUohFSjnkW+XVxDus3Az4KaDE1itIy
	vbbM/cH/+vVq/ArVl2LNmsj/YbiK1y//5cVE2LNSJgRGvk1phfzHvllyozNIMSZdQ/EQhV
	pDfSh/TuaXTOTSO4Sbv0t7HNPGWeibP3rvzrC9V8mH7xnNeBvGAsDCxsymiYBhkwK2Va2I
	PAdpXrw6JD6hPe/GDPvR+DSdT300+RyHcNmLIUrTXOUb+43RSX0CJaUkCRy+Lg==
Message-ID: <a36f6c1a-85aa-4547-be29-daf56b438aaa@nabladev.com>
Date: Wed, 8 Apr 2026 23:21:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH] net: ks8851: Reinstate disabling of BHs around IRQ
 handler
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ronald Wahl <ronald.wahl@raritan.com>, Yicong Hui <yiconghui@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20260407212344.80265-1-marex@nabladev.com>
 <f4010cedaa49afc1648a73775a987ee5@tipi-net.de>
 <a9845b8e-5d3f-472b-8f03-bba699ba3882@nabladev.com>
 <215ad1cc5db3f352ac2a130c07dbd830@tipi-net.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <215ad1cc5db3f352ac2a130c07dbd830@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 4/8/26 9:15 PM, Nicolai Buchwitz wrote:
> On 8.4.2026 17:41, Marek Vasut wrote:
>> On 4/8/26 12:54 PM, Nicolai Buchwitz wrote:
>>
>> Hello Nicolai,
>>
>> thank you for testing on the SPI variant, that helped a lot.
>>
>>> In order to make this work I would propose something like this (which 
>>> works in my SPI setup):
>>>
>>> --- a/drivers/net/ethernet/micrel/ks8851_par.c
>>> +++ b/drivers/net/ethernet/micrel/ks8851_par.c
>>> @@ -60,12 +60,14 @@ static void ks8851_lock_par(struct ks8851_net 
>>> *ks, unsigned long *flags)
>>>   {
>>>       struct ks8851_net_par *ksp = to_ks8851_par(ks);
>>>
>>> +    local_bh_disable();
>>>       spin_lock_irqsave(&ksp->lock, *flags);
>>>   }
>>>
>>>   static void ks8851_unlock_par(struct ks8851_net *ks, unsigned long 
>>> *flags)
>>>   {
>>>       struct ks8851_net_par *ksp = to_ks8851_par(ks);
>>>
>>>       spin_unlock_irqrestore(&ksp->lock, *flags);
>>> +    local_bh_enable();
>>>   }
>>>
>>> Tested-by: Nicolai Buchwitz <nb@tipi-net.de>  # KS8851 SPI, non-RT 
>>> (regression + proposed fix)
>>
>> Are you also able to test the KS8851 driver with PREEMPT_RT enabled 
>> and heavy iperf3 traffic on the SPI variant ? Does that trigger any 
>> issues ? I ran 'iperf3 -s' on the KS8851 end and 'iperf3 -c 
>> 192.168.1.300 -t 0 --bidir' on the host PC side.
> 
> Successfully tested with both PREEMPT_RT and non-RT kernels using the 
> iperf3 command above - no issues observed. Both builds included the fix 
> from my previous message.
> If there is anything else worth testing on the KS8851 SPI variant, 
> please let me know.
Thank you for that. Could you please add the TB to v2 too ?
