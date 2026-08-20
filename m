Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41F2D9ECA
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 06:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787208106; cv=none; b=QDDJ7c2fQuwoE9AtBZrOsuEXqdBeVnZlBZuVZzu6Iq44W+uXqlkuHcAx35LdvAhklYxbBZ7xqQtzmIkalBfK8KBDzzHFunSjkZcAqZC/xfZrJySOauk/i3gOYD56jlEhVbW+K2SwmolKDnnrtSl/D8A/8pSgSDIkNa9gmOqPx+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787208106; c=relaxed/simple;
	bh=Xx6pKjcM6nbWsFH425jnLeA2uNLJUKg+SCB6YsSRsl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XKlS+Lcd5krTZudaZYYX6JCzJCUQN2FLhGTXJ5n8O+ngFic2I41eg1A5kQRnqXIUEbEM6h8ukt6v/QYEndTtgYGUNEtY8AsJmlZQ09rDUI09tgQcaetHsp19KWf0JcPIly3lEHhMHTtrqLw5jkPmJqqNI3IptgDases9UPU6tLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QcdyZTgW; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QcdyZTgW"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8vV5CxZkak+aXEgjCqH19WUR9gqL+2Gfmk+yJnGv2sU=;
	b=QcdyZTgWavcYUpYMI7UCfv4NKLfLlsAlUqWQubUl25hWtjrOa3K19I7rT0V8oEmR3Cby+mASp
	+K8IKTIhEZEGjMjhm7aGP5hkjaLslAkvPzcmLCOV2OsTg5SQ5aCEf1pDVNuLjWNWgNle8z7i3jI
	uVZryjOmyEwmcVTN6CjALi4=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hQYV03bPRzRhVQ;
	Thu, 20 Aug 2026 14:30:48 +0800 (CST)
Received: from whupemk200012.china.huawei.com (unknown [7.152.185.169])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B49F40538;
	Thu, 20 Aug 2026 14:41:28 +0800 (CST)
Received: from [10.174.177.223] (10.174.177.223) by
 whupemk200012.china.huawei.com (7.152.185.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 14:41:27 +0800
Message-ID: <08ef98c2-bd3c-4c6f-8b08-8183547626ff@huawei.com>
Date: Thu, 20 Aug 2026 14:41:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv4: icmp: reject RTN_UNREACHABLE input routes in
 icmp_route_lookup
To: Ido Schimmel <idosch@nvidia.com>
CC: <dsahern@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>,
	<zhangchangzhong@huawei.com>
References: <20260815075102.3426068-1-dongchenchen2@huawei.com>
 <20260817141535.GA432475@shredder>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <20260817141535.GA432475@shredder>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemk200012.china.huawei.com (7.152.185.169)



在 2026/8/17 22:15, Ido Schimmel 写道:
> On Sat, Aug 15, 2026 at 03:51:02PM +0800, Dong Chenchen wrote:
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
>> Reject any input route that is RTN_UNREACHABLE to fix it.
>>
>> Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
>> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> 
> FYI, there's a new policy regarding AI review:
> 
> "
> Patch authors are expected to proactively look into the AI-generated
> reviews and handle such feedback as any other kind of review: either
> debate it or address it. In both cases a reply on the mailing list is
> expected.
> "
> 
> https://docs.kernel.org/next/process/maintainer-netdev.html#review-timelines
> 
>> ---
>>   net/ipv4/icmp.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
>> index 0caedfc7ca92..4703d8dd6b47 100644
>> --- a/net/ipv4/icmp.c
>> +++ b/net/ipv4/icmp.c
>> @@ -585,11 +585,11 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
>>   		 * checked fl4_dec.saddr above). However, a race condition
>>   		 * may occur if the address is added to the interface
>>   		 * concurrently. In that case, ip_route_input() returns a
>> -		 * LOCAL route with dst.output=ip_rt_bug, which must not
>> -		 * be used for output.
>> +		 * LOCAL or UNREACHABLE route with dst.output=ip_rt_bug,
>> +		 * which must not be used for output.
>>   		 */
> 
> Why would the addition of an address lead to RTN_UNREACHABLE? This seems
> to be true for RTN_LOCAL, but not for RTN_UNREACHABLE. Similarly, it
> doesn't seem like RTN_UNREACHABLE is the result of a race condition.
> 
> The comment needs to be reworded to reflect that.
> 
Thanks for review!
RTN_UNREACHABLE scenario indeed does not require contention conditions.
v3 will be sent.

Best regards
Dong Chenchen>> -		if (!err && rt2 && rt2->rt_type == RTN_LOCAL) {
>> -			net_warn_ratelimited("detected local route for %pI4 during ICMP sending, src %pI4\n",
>> +		if (!err && rt2 && (rt2->rt_type == RTN_LOCAL || rt2->rt_type == RTN_UNREACHABLE)) {
>> +			net_warn_ratelimited("detected unusable input route for %pI4 during ICMP sending, src %pI4\n",
>>   					     &fl4_dec.daddr, &fl4_dec.saddr);
> 
> The check is fine, but if RTN_UNREACHABLE is not the result of a race
> condition, then net_warn_ratelimited() should only be emitted for
> RTN_LOCAL.
> 
>>   			dst_release(&rt2->dst);
>>   			err = -EINVAL;
>> -- 
>> 2.25.1
>>
> 

