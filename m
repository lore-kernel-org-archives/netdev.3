Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA13DDB0E
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851068; cv=none; b=Y3tJhPk9bzKU2vXOe0hyg+7OLF/XIKXOvrLPtJbsbKF0/OmrkztblLW1Vu5sH9/T7tfG8LurlsvTgVWVjEDEDY2JhM4iuRlXCFitWKqjd+hSrBTKqDnMr8yGWVeYestQ6mcwZt8Lwo4WLhX2ssRy6TmeUkzkdNfnIaRCop88GR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851068; c=relaxed/simple;
	bh=bGDpIiXLA7xVBN438J19YhtYOJZSCafu7Il54gf0Zp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tnCVI53b7FgJKaHdaygRCRGc2BdjJdpo7q/faBi6SrQcCj3/WPtT+fMcl8BlsiE5VzUtJSWnzjlH/ZIG+K1JUW2Z1ilK4APtN/MhsoJJWwHE+Npc9qqEYEqgRLiDzGupVMsHfTt1RTDKR2rN2/LPjxpv5Qx4jEN3rDsc9r8mHWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c099WXg5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c099WXg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6966F1F000FF;
	Thu,  1 Oct 2026 10:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851061;
	bh=R9I7vM6gcFwOUQIozXAs7hTB9gJBPhSJrbUmDRpPSiI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c099WXg5bUu1G3cbZoEYm/mhWGOOHwC/YfcLfbGcQUCrJjsRY1ExaCbIZa2hbCJRp
	 LtHs39V0hHOI5eavcIHh1Xx+qzcCqRKnBL6sdqtJhrOD/JSOIr4rHmL+5/tu+evjgq
	 ug+PoWtb6QS7cvOGIh3tU13P4wJZAzC2Ur7wMET7g+Nymww1be38X/mKdGBXWXrEXS
	 GIDeL5OWSX0qCZ3BDLGlWOf8+DD8C/NUvrZMqs5ipBymrr0iTEYKj0vxkyIH7KH1uk
	 /phDIbqs71Rj9NReZ9LhwjifVp7UXUFubY9oeJQbYGbC3O+dsQ9eBzazsOLLH4vDF1
	 7EMHzlauESZfw==
Message-ID: <aff0a6c6-ab34-4578-850b-86e7d94deb7a@kernel.org>
Date: Thu, 1 Oct 2026 12:37:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: adopt SLUB sheaves for skbuff_small_head
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Hao Li <hao.li@linux.dev>
References: <20260228141252.435509-1-edumazet@google.com>
 <31a14f1c-7d20-4b0f-a039-9e034762ed98@suse.com>
 <CANn89iKH92jjRDD_jDNeioSy9U5mxKAYeyBJ3hHAFR_z4+wccA@mail.gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <CANn89iKH92jjRDD_jDNeioSy9U5mxKAYeyBJ3hHAFR_z4+wccA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/1/26 17:30, Eric Dumazet wrote:
> On Sun, Mar 1, 2026 at 12:24 PM Vlastimil Babka <vbabka@suse.com> wrote:
>>
>> On 2/28/26 15:12, Eric Dumazet wrote:
>> > skbuff_small_head is used both on receive and send paths,
>> > serving potentially 80 million allocations and frees per second.
>> >
>> > Tuning it on large servers has been problematic, especially
>> > on AMD Turins platforms, where "lock cmpxch16b" latency can
>> > be over 30,000 cycles.
>>
>> Huh, really? That sounds insane. Any pointers about that?
> 
> Yes, obviously on semi-contended cache lines.
> 
>>
>> > Switching to SLUB sheaves fixes the issue nicely.
>> >
>> > tcp_rr benchmark with 10,000 flows goes from 25 Mpps to 40 Mpps
>> > on AMD Turin.
>> >
>> > Other platforms show benefits with tcp_rr with more than 30,000
>> > flows.
>>
>> That's nice, thanks!
>>
>> However I must point out some caveates. I assume you did this on 6.19, where
>> sheaves are still opt-in. But also, when you opt-in, the pre-existing
>> per-cpu caching layer of percpu slab and percpu partial slabs is also still
>> there, so effectively the amount of percpu cached slab objects increase,
>> which can be the main performance difference for some workloads, and not the
>> difference between sheaves and percpu (partial) slabs implementation.
>>
> 
> Tests are on 6.18 LTS kernel, on which our latest production kernel is based.
> 
>> Note: but hopefully for your workload it's really the implementation.
>> "(lock) cmpxch16b" should be avoided, until you start freeing NUMA-remote
>> (to the freeing cpu) objects in significant volumes.
> 
> Right, __slab_free() is absolutely not 'slow path' when we have
> ~80,000 in-flight objects
> on a 512 cpu host.
> 
>>
>> In 7.0-rc1 sheaves are enabled for every cache automatically, and cpu
>> (partial) caches are gone completely. Their size is calculated to roughly
>> match the average amount of percpu caching the old scheme achieved (but that
>> effectively depended on the workload too, so can't be exactly translated)
>> and the result is visible in /sys/kernel/slab/$cache/sheaf_capacity
>> the args.sheaf_capacity can override that automatic sizing, if the specified
>> one is larger.
>>
> 
> Nice, I did not know that (I am not following lkml traffic)
> 
>> So what I would suggest is checking the performance betwen 6.19 and 7.0-rc1
>> without this patch (hope there won't be any other factors in the upgrade
>> influencing this much), noting the auto-calculated capacity. If it still
>> looks good, you don't need to do anything, otherwise you can try making the
>> capacity larger and see what happens.
> 
> I can not test this yet using 7.0-rc1.
> 
> I guess we will carry this patch privately, and will come back in a
> few months when
> I can get our infra ready.

Hi, just wondering if since then you were able to test a 7.0+ kernel and
thus see if the refactoring of all caches to use sheaves had the same
benefit as your patch on top of 6.18?

Thanks,
Vlastimil

> Thanks.

