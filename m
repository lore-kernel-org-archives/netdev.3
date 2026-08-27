Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF048440A19
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787831360; cv=none; b=K1olNcxkGaoDzcKcNAKWWpmz43isarqEabTejP6xewy4C6xdkziKFClPeQ4wYSzzYDmvYuFIqsLkKkyY6hCIfwHZzcwB+FvmCqcCwZRtcxmShvHsX17E+rNn6cENOPMEh/Y8siIZ5U8+1l2F+haF+TSQBfFMGBzp6xP2CsepODw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787831360; c=relaxed/simple;
	bh=FoO1QJ0GF50BvlM8x2sXaYqmyZtQ27nfVk7V1frg8n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C0eXDtSY/NhIwSuTA2VJFCwYPxHUYgLpu5VLaGzv1eDkXwEXs5KYqya7Qy1XMsqYSYph2KMNcXyR7wO+vwD7Maj9pYDBqAndAvJ+AU1yf8qmcp8FHbMPVIbGlMSYZb4WTRmxu3g4eS/Y7ci4CNtad+ls5R1pkd7xRc/jH3MK1Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Wkb+1rV0; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Wkb+1rV0"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+mzw++BiW9LAc9yAYC/WAMU5QJ4XXRR59EeZztCWpFg=;
	b=Wkb+1rV0iEudRgEXbvOKFH3uJLgDqvhseIHCwlA7xmPA1PzCgKL3yT+27hRgZrlC1ffrHAkGf
	a5ZwuxwpEm/c0xeZxN0Zg0y0C9FTDpsR6aa4zm24R+sm3p8bHqZhlEaQRCjVR1zZZy4EPY5mqSI
	iGUh07QRkt68B573g5PNyh4=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hW00B3YVKz12LFy;
	Thu, 27 Aug 2026 19:38:50 +0800 (CST)
Received: from whupemk200012.china.huawei.com (unknown [7.152.185.169])
	by mail.maildlp.com (Postfix) with ESMTPS id E9CC74056D;
	Thu, 27 Aug 2026 19:49:06 +0800 (CST)
Received: from [10.174.177.223] (10.174.177.223) by
 whupemk200012.china.huawei.com (7.152.185.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 27 Aug 2026 19:49:05 +0800
Message-ID: <ba64acb2-0078-4403-8780-d2f4719ca5c0@huawei.com>
Date: Thu, 27 Aug 2026 19:49:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] ipv4: icmp: reject RTN_UNREACHABLE input routes in
 icmp_route_lookup
To: Ido Schimmel <idosch@nvidia.com>
CC: <dsahern@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>,
	<zhangchangzhong@huawei.com>
References: <20260825094523.1461020-1-dongchenchen2@huawei.com>
 <20260826154017.GA1834664@shredder>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <20260826154017.GA1834664@shredder>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemk200012.china.huawei.com (7.152.185.169)


> On Tue, Aug 25, 2026 at 05:45:23PM +0800, Dong Chenchen wrote:
>> When the forward output route cannot be used in icmp_route_lookup(),
>> it enters the "reverse path" and calls ip_route_input() on fl4_dec.daddr,
>> the original packet's source address.
>>
>> ip_route_input() only returns an error for truly invalid packets. For
>> unreachable addresses it will succeed and return an input route whose
>> dst.output is set to ip_rt_bug(). The existing check only rejects
>> RTN_LOCAL routes, so the RTN_UNREACHABLE route types can still be returned
>> and later used for output, syzkaller triggering a WARN_ON_ONCE()
>> in ip_rt_bug() as bellow:
>>
>>   ------------[ cut here ]------------
>>   WARNING: net/ipv4/route.c:1273 at ip_rt_bug+0x14/0x20
>>   RIP: 0010:ip_rt_bug+0x14/0x20
>>   Call Trace:
>>    ip_push_pending_frames+0xfa/0x100
>>    __icmp_send+0x905/0xf10
>>    ip_options_compile+0xc0/0xd0
>>    ip_rcv_finish_core+0x321/0xae0
>>    ip_rcv+0x1de/0x260
>>    __netif_receive_skb_one_core+0x11a/0x130
>>    netif_receive_skb+0x7b/0x260
>>    tun_get_user+0x11bf/0x1c10
>>   ------------[ cut here ]------------
>>
>> Reject input route that is RTN_UNREACHABLE to fix it.
> 
> Nit: Also mention that the warning is only printed for RTN_LOCAL, as
> RTN_UNREACHABLE is not the result of a race condition.
> 
>>
>> Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
>> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
>> ---
>> v2:
>> - RTN_UNICAST judgement will reject bforward packet. Only reject RTN_UNREACHABLE
>> v3:
>> - Modify the comments to make them more accurate.
>> - RTN_UNREACHABLE dont need warn log.
>> ---
>>   net/ipv4/icmp.c | 17 ++++++++---------
>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
>> index 0caedfc7ca92..7350f0380be1 100644
>> --- a/net/ipv4/icmp.c
>> +++ b/net/ipv4/icmp.c
>> @@ -581,16 +581,15 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
>>   		skb_dstref_restore(skb_in, orefdst);
>>   
>>   		/*
>> -		 * At this point, fl4_dec.daddr should NOT be local (we
>> -		 * checked fl4_dec.saddr above). However, a race condition
>> -		 * may occur if the address is added to the interface
>> -		 * concurrently. In that case, ip_route_input() returns a
>> -		 * LOCAL route with dst.output=ip_rt_bug, which must not
>> -		 * be used for output.
>> +		 * At this point, fl4_dec.daddr should NOT be local (the
>> +		 * address can be added to the interface concurrently) or unroutable.
>> +		 * In that case, ip_route_input() returns a LOCAL or UNREACHABLE
>> +		 * route with dst.output=ip_rt_bug, which must not be used for output.
>>   		 */
> 
> The code is fine, but the comment is a bit misleading (the "should NOT"
> part is only correct for "local"). I find this clearer:
> 
> "
> fl4_dec.daddr is not expected to be local here, but it can be added to
> an interface concurrently, in which case ip_route_input() returns a
> LOCAL route. It can also fail to build a forwarding route towards
> fl4_dec.daddr, for example, when forwarding is disabled, and return an
> UNREACHABLE route. Both cases will result in a route with
> dst.output=ip_rt_bug, which must not be used for output.
> "
> 
> Thanks!

Thanks for review!
v4 will be sent

> 

