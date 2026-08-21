Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C637C3B6360
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312024; cv=none; b=uHwm0vtHfftaPmhIbold069vBCEcO/KPNmDejDISBosF7PvOwrlAko8CbnTNRIe2DJ7h8MVx8NKrVWpA2z0Y4pmtq+OXSNqhr7IfFh2cHxlK2PVtnzITd1uVHOteVEHPw+m9a8ZcQTXiQpirzI7BklsdUv2g9brW6LJgjfYcbEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312024; c=relaxed/simple;
	bh=jN781Own8GalleQrt1GGkCOtNEBYh+MhQTKdDwGO36U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8xP5e7Y0VEEAnt4wM+zaKb/aXzfWYO3adfHKc0ZvrHRnrw6tsqaPZJulLPFm7T1TwcCfQg6ULSkocDdY1V4MSZi2n2Rmyuq+daKNh+EoJu2oA1SUK0EJKBkxA+PD+VphYELOE8EdsxwPbaopNcjpvPUS1CAPY8IGexwH/hhzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Kc834sft; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Kc834sft"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso1599168a12.3
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 04:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787312021; x=1787916821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kBA0NxP0g66qtgBb3N+LnO10mEb/jnflAdJrZZcYUhU=;
        b=Kc834sftkLXymv/8Q8vF9b03P0VlvY5JMwCqYIE5Ez03KklJultqR+szSacl+tHx0S
         OOM0sjyY1KX2m0zX710PGbOHDxHa3p7Ou1lK7Xa8+5FcnONJoRTIoo/O6uEF25HKKTwa
         2RdqGsBcqbZ3yj6J1lP70XswaCxi3oAN3EP6j+K5jz0m+0e8/HIhTFjihzRiMq0dp644
         ALE+tho290MCu55r8D7hQh8s9Sa2LI2fUtWK58Cx8ZI++rxdarkoXQr+9nSiqI0l+vs6
         GUgaccf7F5Ob1aflqrR40Dg1nafKcCT60fe3m325FZGMEwVvK6+1gJQKltXHecB9AtuX
         CYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787312021; x=1787916821;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kBA0NxP0g66qtgBb3N+LnO10mEb/jnflAdJrZZcYUhU=;
        b=nNOlxoyjivBoia6OqD3LJGG4bo+rwhDDjFztmz7BtJ19WKGD7jSF4Ld4zdlMDN8ErR
         GiN3BZxyzJ7977qGqqtXwk9RdcqK0cYmia420wBvyz66qDAPDB3ayIClP05KVE3seFem
         Dr5yFfyEM612QBhIT3GsPbppNv4T8i7EvFNA0+pcbxQenvm4F2jJdD2QBF4HyINh5IkI
         +mFKreVxdQUQbaNqJfMqCPjv52O59SZt4uZhiays18vtP4AEGYZasCizjBSNl7WIiEmu
         WuhnGHNjyKNiXtgigzbQ6YFe6IhsxRRljsDbMov7lGn4i/zCGqTTxyem5oQm4DZc8hz0
         sJzA==
X-Forwarded-Encrypted: i=1; AHgh+RoS+xMslKyzYdiL/9U0w4DTVExTGOukYUMTOtVevKGCqnUIHYabbI3VZ9HH0bJp0Y/EKDlMBGY=@vger.kernel.org
X-Gm-Message-State: AFuF++n3watP9uOIzw/PZUmx61/xJw6lpPXIySW9NPwgMAOYUT8BZ4l0
	Um+96JJIXGTw8jQY7zE+FVsjr9bw8RWYtxkt3TEuDmQWbtzsffaeL92iog1dexzRfHo=
X-Gm-Gg: AR+sD11ifds/NivE6OYkTbl0bCZGuwLFYwUnTvokJGHKVh+c1HDUHVINBwu0IMfmc74
	2xydq172sFi3vo8nVZMXKkEaF4D4ngANrt2Ox9FB5gYYte8Ckan5o30jbZUX+b15f+un4i26HP6
	KXJXEiTe80S2jQhoKTspoRxNlrU2eSFdWxY9soRzqaGNkLL2IJ0IqP86hsVH9iXudrvvAhSBlh0
	7WfoASLgGfkRwnH21pYajrfKZIWPU7j7dVL2ftxAu6JQNCUHSqLdXWJBy3NDhSkLHt1hBmOKN4j
	S9PvwM7VMjyf3f8KN0GhcX8uDEJkA4twwZjMfyEWXPWkxTd22WS0xd86q7LUAq3lM1xrsSwwh+u
	oL4r3OndwizI3JDABEGgEg41SeoJO2W+uoGsFWm30xHiRsHxfRnBQYLUwScAriNYGXGj/Imm6xh
	iLsiKuuvESQGS/sp0LKGMl+4pHbg7I4nMAGw+aIF93ywIctfPqLkfbru9DpnR9k3b4IoU2m7vh7
	aae2P0uIJc9ydO0ZGMjIpo+DyWVYQ==
X-Received: by 2002:a05:6402:505b:b0:698:af31:5a9b with SMTP id 4fb4d7f45d1cf-6a42f1e08c0mr5689597a12.9.1787312020748;
        Fri, 21 Aug 2026 04:33:40 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff156693sm6032491a12.15.2026.08.21.04.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 04:33:40 -0700 (PDT)
Message-ID: <d6c8ec4c-ab28-4d7c-ac26-414b94352c10@blackwall.org>
Date: Fri, 21 Aug 2026 14:33:39 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] bonding: fix u32 overflow in compute_gap()
Content-Language: en-US, bg
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260820-bond_overflow-v4-0-805ba0d3efb6@kylinos.cn>
 <20260820-bond_overflow-v4-2-805ba0d3efb6@kylinos.cn>
 <b63cb237-8bc0-4c95-820f-d004433f5577@blackwall.org>
 <aogrnqQ0c077G4-B@fedora>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <aogrnqQ0c077G4-B@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/08/2026 13:42, Hangbin Liu wrote:
> Hi Nikolay,
> On Fri, Aug 21, 2026 at 01:16:20PM +0300, Nikolay Aleksandrov wrote:
>>> -static long long compute_gap(struct slave *slave)
>>> +static u64 compute_gap(struct slave *slave)
>>>    {
>>> -	return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
>>> -	       (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
>>> +	u64 slave_load = SLAVE_TLB_INFO(slave).load << 3; /* Bytes to bits */
>>> +	u32 raw_speed = READ_ONCE(slave->speed);
>>> +	u64 speed = (u64)raw_speed << 20; /* Convert to bits per sec */
>>> +
>>> +	/* It's meaningless to compare gap on unknown speed NIC */
>>> +	if (raw_speed == (u32)SPEED_UNKNOWN)
>>> +		return 0;
>>> +
>>> +	/* Skip slave which is over loaded */
>>> +	if (speed <= slave_load)
>>> +		return 0;
>>> +
>>> +	return speed - slave_load;
>>>    }
>>>    static struct slave *tlb_get_least_loaded_slave(struct bonding *bond)
>>>    {
>>>    	struct slave *slave, *least_loaded;
>>>    	struct list_head *iter;
>>> -	long long max_gap;
>>> +	u64 max_gap = 0;
>>>    	least_loaded = NULL;
>>> -	max_gap = LLONG_MIN;
>>>    	/* Find the slave with the largest gap */
>>>    	bond_for_each_slave_rcu(bond, slave, iter) {
>>>    		if (bond_slave_can_tx(slave)) {
>>> -			long long gap = compute_gap(slave);
>>> +			u64 gap = compute_gap(slave);
>>> -			if (max_gap < gap) {
>>> +			/* Make sure we have one available slave */
>>> +			if (max_gap <= gap) {
>>>    				least_loaded = slave;
>>>    				max_gap = gap;
>>
>> I think Sashiko's review has a point here:
>> "Does clamping the gap to 0 completely break load balancing when all interfaces
>> are overloaded?
>> When all slaves are overloaded, compute_gap() returns 0 for all of them. Since
>> max_gap is initialized to 0, max_gap <= gap will evaluate to 0 <= 0, which is
>> true.
>> This means tlb_get_least_loaded_slave() will continually update least_loaded to
>> the current slave, ultimately routing all traffic to the last slave in the list
>> instead of distributing it across the least overloaded interfaces."
> 
> Yes, I have thought about this question. Previous code set max_gap LLONG_MIN,
> so there always has a slave assigned. Now we use u64. If we use (max_gap < gap),
> there may return NULL pointer.
> 
>>
>> That is, compute_gap makes multiple different scenarios look the same:
>>   if speed is unknown           = 0
>>   if exactly equal capacity     = 0
>>   if overloaded by *any* amount = 0
> 
> Yes, if there is are 2 NICs with 1 Gbps and 10 Gbps, but both shows as
> unknown. There is no meaning to compare the gaps. Because they use the same
> speed value (u32)-1 << 20.
> 
> If two NICs both overloaded or equal capacity. There is also no mean to select
> any devices.

Well that is debatable, to be correct you'd like to choose the NIC that is
least overloaded, one could be at capacity and the other could be 10Gbps above
capacity and you can still choose the second with this.

If you make it a signed comparison then you can choose the least loaded, you'd
have to mark unknown speed with S64_MIN but it will compute the correct numbers
and you can choose the least overloaded NIC, which the current code actually
does correctly.

And most importantly - you definitely want to differentiate between unknown speed
and overload, these should not be the same.

> 
>>
>> So Sashiko's comment seems correct, it doesn't matter if a slave is overloaded
>> with 1 gbps or 100, they will look the same.
> 
> I've thought like:
> 
>    if (speed over load)
>    	return 1;
>    if (speed unknown)
>    	return 2;
> 
> That sounds reasonable: we could select an unknown‑speed NIC that is not
> overloaded. However, this does not work.
> 

It doesn't to me, it still doesn't differentiate between NICs that are
overloaded differently.

> When performing the `speed <= slave_load` check, the speed value has already
> been shifted. Unknown speed is converted to a very large value, so the
> calculation will never report an overload condition — even though the actual
> hardware may already be overloaded.
> 
> This is why I end up returning 0 for all such cases. Hope my explanation
> is clear.
> 
> Thanks
> Hangbin

