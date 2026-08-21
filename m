Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532231D5AD4
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787317967; cv=none; b=qDcAn24149DUj8ukXhhyBP/xJJ02xLp69oCeRTGiVkBqVce13TwrXYwVEAcNsu9fuic730zIvulsT8r0Dgs8bxZEfxtdwUCAUEXexCBReYSLShV1iBB1NeOk0Q0RYUmp7kLG0a8RHkGCrqjJQlSXfKS7RMrT0KuPcgmz7XkTAwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787317967; c=relaxed/simple;
	bh=xIawzfQXdKP0Li2QjPtdvuJ9BFkJyYj3YzYRq2dpdx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGDqQjA5j0iSk/uMeeqLJjxIg+4GLMnlXdQZrao5K1J4MNS01p6fVglVB9Ux8QaEFzjT3VPh16q3h8X919NX1CE47xdS/NM/b5x2/uYLrrzm5S1buRhyS/+gF3VqZgfqUk0JLf31D0kpidnrC1z0Dvi7FN7agUQlmMIaJyG6P9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=LJzqUWSG; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="LJzqUWSG"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a422090b14so1556133a12.1
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 06:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787317954; x=1787922754; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JSVhaEczIAITOiUBAk3m0NB6xGaNx6EDtdLJJZuRCEo=;
        b=LJzqUWSGeql7ttoe3JTTDfWeKIrFSVtAa845PTvWE1xw2wTyMwfX4PRqCr+pW499FR
         VTK4KPE/1dbGVh0WWxHo4pxvxLRc14IEsaGrllLUnFpHrDyWPhZ2J/zKvdue4E3z8p90
         3ZZRumtwuor7TksPB+Gp5mAw85gOFYBxj7R/Pcmrqg9SXKM4eGoSaBTpYXU2FTTJa84z
         ZkLjCgorDPWIq1UXUlofK2HjybWulJPzxFZUSdC82yJdkjUQxQWeiuBn9b2vrxgB8jkN
         ggsf/EYtYeIKgeq8D0x5Hk/d4EYVTmPvwdPx1Nwvnn2nv0J8CAjFCPVs607J9DDW07SF
         V5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787317954; x=1787922754;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JSVhaEczIAITOiUBAk3m0NB6xGaNx6EDtdLJJZuRCEo=;
        b=C9diZ4DG8gfIKuapd9HWZadD3GMSIVNeUtXaI0aTypdfFbob8v7lvmlj0LOQQue5eH
         lOtKny8RkjmMM84SFnOY1w0h5xEkWw8gY326NIa1/v2H9irLJkHOb+4CgYc25l3FMXnV
         bJjJwRv3JLrHHHxh41vS0pbR52olO6hsYcXFfb6e0rtadBWpgqrtJf2ZeRULvg0yJVAY
         7RbQWAm4QhxEPPjGoZBD3bfA3yhcVkmVm2y4um3UIh0tC3gcM+g4xo/S1p/Q1Dm94ps2
         +oKCEJom3kreOTYZIZvZV7ZPIaOH9Md372GveippGqvW0z8uhxbCBb5CLONMByi6k7xi
         8SJg==
X-Forwarded-Encrypted: i=1; AHgh+RoYlIeWVNjGoeKw42fgu0mV7hegWphHSWLkScfl1jZGWitHBc4t+XZPcgYD+jO6OKEJXHq2bYU=@vger.kernel.org
X-Gm-Message-State: AFuF++mP1uRJDT4AnzjZxlXYr+LmtP9QZi+CVMIrgyiQQ+pWHyWsDdqF
	dv8iwtk6sjs2c+txUQ25gCxYivGEGgQl4/WcjaS+LzO7Y2fDxVBSGAL9yc7Jn0AHOhY=
X-Gm-Gg: AR+sD13i1eKkUaDdDJGw+hg/HOaNFtgJ9EofoCSRAXT84znswZtC9JipljP86qZjFsI
	gUDDOpLVpTZeH//IuTrlbUWkgF7ZWpddVxr4N4ZIthZpnhrId2eEShCP5JHTogbduO5BhUohPpt
	IN55f5K0nzuWKFecVDhwwXnnbGvtz+hRBPIlSvqCd7ApaibTw1GMUvV1RA5/brpW3UrNQ6shG2S
	f94HW52eOt1ylL/mHKXZ5213yx7MQM4k9HKJoFhMoO8eILNp0nmBkl9C64ZK18Lw4/Noor0/8ag
	A8lwJDJ3B1BPbx3wYoc1EgKDhJ7Uol0eUuOV6ExTOewd050HlR/wndI/+NcSd0wFVAGIutsvh9N
	8jbfRO8tlC+ho+xH6MS8Gu7mKdTKk5Jdk7b6M+B/ZJnvMTkPh3Lnt4RWkPbodpzoXi7MT763o0b
	iLHZLBHLpXh01fKkZccaH6QiAaw6bl+1RuoMXX8Q3JvGqfrfYT/GuLN6mGlfbdOJWQFDjG+KAcR
	wzT7HViGNKl4rVczaA=
X-Received: by 2002:a05:6402:428c:b0:6a0:8885:e6f0 with SMTP id 4fb4d7f45d1cf-6a42f162cdbmr7788392a12.3.1787317953467;
        Fri, 21 Aug 2026 06:12:33 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9e2esm6416459a12.5.2026.08.21.06.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 06:12:32 -0700 (PDT)
Message-ID: <d9b218ed-b7dc-40d3-90a2-24b5cdbe8f73@blackwall.org>
Date: Fri, 21 Aug 2026 16:12:31 +0300
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
 <d6c8ec4c-ab28-4d7c-ac26-414b94352c10@blackwall.org>
 <aohLhGviyByk6T1-@fedora>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <aohLhGviyByk6T1-@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/08/2026 15:58, Hangbin Liu wrote:
> On Fri, Aug 21, 2026 at 02:33:39PM +0300, Nikolay Aleksandrov wrote:
>>>> I think Sashiko's review has a point here:
>>>> "Does clamping the gap to 0 completely break load balancing when all interfaces
>>>> are overloaded?
>>>> When all slaves are overloaded, compute_gap() returns 0 for all of them. Since
>>>> max_gap is initialized to 0, max_gap <= gap will evaluate to 0 <= 0, which is
>>>> true.
>>>> This means tlb_get_least_loaded_slave() will continually update least_loaded to
>>>> the current slave, ultimately routing all traffic to the last slave in the list
>>>> instead of distributing it across the least overloaded interfaces."
>>>
>>> Yes, I have thought about this question. Previous code set max_gap LLONG_MIN,
>>> so there always has a slave assigned. Now we use u64. If we use (max_gap < gap),
>>> there may return NULL pointer.
>>>
>>>>
>>>> That is, compute_gap makes multiple different scenarios look the same:
>>>>    if speed is unknown           = 0
>>>>    if exactly equal capacity     = 0
>>>>    if overloaded by *any* amount = 0
>>>
>>> Yes, if there is are 2 NICs with 1 Gbps and 10 Gbps, but both shows as
>>> unknown. There is no meaning to compare the gaps. Because they use the same
>>> speed value (u32)-1 << 20.
>>>
>>> If two NICs both overloaded or equal capacity. There is also no mean to select
>>> any devices.
>>
>> Well that is debatable, to be correct you'd like to choose the NIC that is
>> least overloaded, one could be at capacity and the other could be 10Gbps above
>> capacity and you can still choose the second with this.
>>
>> If you make it a signed comparison then you can choose the least loaded, you'd
> 
> Oh, do you want to fallback to use s64 (long long) in compute_gap? Then
> all the counters need to using s64. The same with unbalanced_load, and we
> can't using the "delta" anymore. Do we need to change back to using spin_lock
> to protect the unbalanced_load writing.
> 

why? see more below

>> have to mark unknown speed with S64_MIN but it will compute the correct numbers
> 
> Here do you mean
> 	if (raw_speed == (u32)SPEED_UNKNOWN)
> 		s64 speed = S64_MIN
> 
> ? Then the 's64 gap = speed - load' will overflow, which means a 1Gbps NIC
> (shown as unknown) will have more gaps then 10Gbps NIC (correctly shown speed)
> 

oh that is easily fixed, it should not be a problem

>> and you can choose the least overloaded NIC, which the current code actually
>> does correctly.
>>
>> And most importantly - you definitely want to differentiate between unknown speed
>> and overload, these should not be the same.
> 
> If we use s64 and all slaves are overloaded, we can compute the difference.
> But once there is an unknown speed NIC, we lose visibility into the real difference.
> Such a NIC could be 1G, 10G, or 100G, yet we set its speed to `(u32)-1`.

no, we use signed and set it at S64_MIN, it is never chosen.

> 
> That is why I believe comparing gaps for NICs with unknown speed is meaningless.
> 

Right and they shouldn't be considered or rather should be last.

> Regarding overload scenarios: do you think this is a common‑case situation?
> Because in practice, we rarely hit the theoretical maximum link speed.
> For example, a 10Gbps NIC typically peaks at around ~950 Mbps.
> 
> Thanks
> Hangbin

Completely untested, but something like:

-static u64 compute_gap(struct slave *slave)
+static s64 compute_gap(struct slave *slave)
  {
         u64 slave_load = SLAVE_TLB_INFO(slave).load << 3;
         u32 raw_speed = READ_ONCE(slave->speed);
         u64 speed = (u64)raw_speed << 20;

         if (raw_speed == (u32)SPEED_UNKNOWN)
-               return 0;
-
-       if (speed <= slave_load)
-               return 0;
+               return S64_MIN;

-       return speed - slave_load;
+       return (s64)speed - (s64)slave_load;
  }

Then change the selection variables and comparison:

-       u64 max_gap = 0;
+       s64 max_gap = S64_MIN;

...

-                       u64 gap = compute_gap(slave);
+                       s64 gap = compute_gap(slave);

-                       if (max_gap <= gap) {
+                       if (!least_loaded || max_gap < gap) {

This should choose the slave with smallest gap and put the unknown speed behind all
slaves with known speeds.
