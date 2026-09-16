Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C6733DEE5;
	Wed, 16 Sep 2026 02:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789525006; cv=none; b=O0Pvu+5FihR/LXea27MyzniEHS/EuBh3/VusdXenblJxldfvGeT5F3sr281nVO/5R65bylJ5hg++PLJUXfikzLu39oVsVSHreUSoMrc6138+6aGdqUkMpA708MW++Jcmu5P8YEowwbthzRH0u5nmuO5YAh/HsVGpajrjG6w3K4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789525006; c=relaxed/simple;
	bh=+7ERvJIEmInl+TT2Pq2Zf+uPj16hTW5VqLOuCnrAswo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VvcAJc5AiDPLJymX8+qyweGeGbMmeTgzCp0T477BwQR4GRCdM8whJ1uQO439oq2BqUlmCYa/1W0cwjDk4sV9x57BEbJr6299ZyaBiFu2f7mq5P14+jILcgTD4mM7vJfI+kTwayjVM3rfYVGy96RSxqWW8V2Kex/cjsndrj8m38w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=hLEctKEh; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hLEctKEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=GtNeDLEL3cZw63X0BeAVNi6atiMHIlq/9+o/lSVzZXA=;
	b=hLEctKEhyv1IWULCYVqHEer/WN6aDoaG/gt/cbcQSsleivfDWM+lAhr8MhyZSc
	VU8VEigWPJ0bfsy9chcrEQtM1U7S8yCB1k2xEu1grx8sDvWQyjevdFzO+W8fF3rX
	TF5rxJjtwImFyUAcH6u4G0g3FKSerA4iwVhvRbfaqkljc=
Message-ID: <4e98fbb0-c416-4059-b605-56a1e0e48cbb@126.com>
Date: Wed, 16 Sep 2026 10:15:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv4: fib: fix data-race and stale genid check
 around nh->nh_saddr
To: Ido Schimmel <idosch@nvidia.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20260915071503.465875-1-xiaolinkui@126.com>
 <20260915175354.GA805835@shredder>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <20260915175354.GA805835@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHnzTc+6lqSjS3BQ--.18307S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw4kXF4UXry3KFy8WFW7urg_yoW7uFWxpF
	W8tasrt347JFy29FsrtF47Z3W09w4rtFyF9r9293yY93Z8Xr13JFWSgr9I9F98Xr4kXw42
	yF45Wr1UAryY9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZNVkUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlR07Emqp+938OwAA3D

Hi Ido,

Thanks a lot for the review. Both points are valid, and I'll address
them in v3.

1. Commit reference

You're right — the rule that nh_saddr is only meaningful when
nh_saddr_genid matches dev_addr_genid was established by commit
436c3b66ec98 ("ipv4: Invalidate nexthop cache nh_saddr more
correctly."), not by 195374d89368. The latter only added the
READ_ONCE()/WRITE_ONCE() annotations. I'll correct the commit message
accordingly.

2. Refresh on genid mismatch instead of skipping

I agree that skipping the comparison on a genid mismatch would
silently downgrade ECMP selection to hash-based for as long as the
cached genid remains stale, which defeats the purpose of the
source-address matching introduced by 32607a332cfe.

I'll adopt your fib_nh_saddr() helper in v3:

     static __be32 fib_nh_saddr(struct net *net, const struct fib_info *fi,
                                struct fib_nh *nh, int genid)
     {
         if (READ_ONCE(nh->nh_saddr_genid) == genid)
             return READ_ONCE(nh->nh_saddr);

         return fib_info_update_nhc_saddr(net, &nh->nh_common,
                                          fi->fib_scope);
     }

and simplify the check to:

     if (saddr && fib_nh_saddr(net, fi, nexthop_nh, genid) == saddr)
         nh_score += 2;

This keeps the fast path free of extra work when the genid matches,
while refreshing the cached source address on a mismatch, mirroring
fib_result_prefsrc().

I'll send v3 shortly. Thanks again for the guidance.

Best regards,
Linkui Xiao

On 2026/9/16 01:53, Ido Schimmel wrote:
> On Tue, Sep 15, 2026 at 03:15:03PM +0800, Linkui Xiao wrote:
>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>
>> fib_select_multipath() compares nexthop_nh->nh_saddr against the flow
>> source address with no lock held, while fib_info_update_nhc_saddr()
>> stores a new value from another CPU as soon as the preferred source
>> address of the egress device changes.
>>
>> Commit 195374d89368 ("ipv4: fib: annotate races around nh->nh_saddr_genid
>> and nh->nh_saddr") added WRITE_ONCE() on the store side and READ_ONCE()
>> in fib_result_prefsrc() after syzbot reported
>>
>> 	BUG: KCSAN: data-race in fib_select_path / fib_select_path
>>
>> but it only covered that reader. fib_select_multipath(), reached from
>> fib_select_path(), is a second lockless reader of nh->nh_saddr and was
>> left bare.
>>
>> Moreover, nh_saddr is only meaningful when nh_saddr_genid matches
>> dev_addr_genid, as established by 195374d89368. fib_select_multipath()
> 
> It's established by commit 436c3b66ec98 ("ipv4: Invalidate nexthop cache
> nh_saddr more correctly.")
> 
>> skips that validation, so it can score a nexthop using a stale source
>> address and skew the ECMP selection.
>>
>> Annotate both reads with READ_ONCE() and add the missing genid check,
>> mirroring fib_result_prefsrc().
>>
>> Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches source address")
>> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
>> ---
>> V1: https://lore.kernel.org/all/CANn89iJhFL2LNQCXTANQAx8B1GVdGTJgrDwPTZOjbH8k1ygtsg@mail.gmail.com/
>>
>> V2:
>> - point Fixes: at 32607a332cfe, which introduced the bare reader
>> - add the missing genid check as suggested by Eric Dumazet
>>
>>   net/ipv4/fib_semantics.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
>> index 7a362f2e2c2b..e2bfc11aea09 100644
>> --- a/net/ipv4/fib_semantics.c
>> +++ b/net/ipv4/fib_semantics.c
>> @@ -2184,6 +2184,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
>>   	bool use_neigh;
>>   	int score = -1;
>>   	__be32 saddr;
>> +	int genid;
>>   
>>   	if (unlikely(res->fi->nh)) {
>>   		nexthop_path_fib_result(res, hash);
>> @@ -2192,6 +2193,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
>>   
>>   	use_neigh = READ_ONCE(net->ipv4.sysctl_fib_multipath_use_neigh);
>>   	saddr = fl4 ? fl4->saddr : 0;
>> +	genid = saddr ? atomic_read(&net->ipv4.dev_addr_genid) : 0;
>>   
>>   	change_nexthops(fi) {
>>   		int nh_upper_bound, nh_score = 0;
>> @@ -2204,7 +2206,9 @@ void fib_select_multipath(struct fib_result *res, int hash,
>>   		    (use_neigh && !fib_good_nh(nexthop_nh)))
>>   			continue;
>>   
>> -		if (saddr && nexthop_nh->nh_saddr == saddr)
>> +		if (saddr &&
>> +		    READ_ONCE(nexthop_nh->nh_saddr_genid) == genid &&
>> +		    READ_ONCE(nexthop_nh->nh_saddr) == saddr)
>>   			nh_score += 2;
>>   		if (hash <= nh_upper_bound)
>>   			nh_score++;
> 
> The cached generation ID can remain stale for a long time and during
> this time we will silently downgrade the nexthop selection to be hash
> based. We need to refresh it in case there is a mismatch. Something
> like:
> 
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index e2bfc11aea09..5c9021ea3a79 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -2176,6 +2176,15 @@ static bool fib_good_nh(const struct fib_nh *nh)
>   	return !!(state & NUD_VALID);
>   }
>   
> +static __be32 fib_nh_saddr(struct net *net, const struct fib_info *fi,
> +			   struct fib_nh *nh, int genid)
> +{
> +	if (READ_ONCE(nh->nh_saddr_genid) == genid)
> +		return READ_ONCE(nh->nh_saddr);
> +
> +	return fib_info_update_nhc_saddr(net, &nh->nh_common, fi->fib_scope);
> +}
> +
>   void fib_select_multipath(struct fib_result *res, int hash,
>   			  const struct flowi4 *fl4)
>   {
> @@ -2206,9 +2215,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
>   		    (use_neigh && !fib_good_nh(nexthop_nh)))
>   			continue;
>   
> -		if (saddr &&
> -		    READ_ONCE(nexthop_nh->nh_saddr_genid) == genid &&
> -		    READ_ONCE(nexthop_nh->nh_saddr) == saddr)
> +		if (saddr && fib_nh_saddr(net, fi, nexthop_nh, genid) == saddr)
>   			nh_score += 2;
>   		if (hash <= nh_upper_bound)
>   			nh_score++;

