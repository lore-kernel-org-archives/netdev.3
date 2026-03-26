Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFBC3B38B5;
	Thu, 26 Mar 2026 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774511959; cv=none; b=TMgWzorttxm7uThzslp/B2E9rrJkXB99N0kKItzeZYVRnAmBiE4QSEs2xl0dqHI5BoMFqb+ReZZHNRIFeIMvzlVgBKpMh2ASDZELBo7CF5hKZ1gM76VfuA34xMkTuTLIq8ZX15pA98k+vDAezGvz/s0K6QQ0Ni7LH6L6U36OjdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774511959; c=relaxed/simple;
	bh=vO8PIpxJovXOwq92AzoKj+UrdmM7MxtrDETvJjpsmvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQeAuHNif4PhR6jMjPs5mcdgbetPBsu1dJqYXjmEkmLlcCTNfkZ1gqu/PaVhRlPBJnksPtN4IUaedioz7nKbsfnawsAxbsb+FJPkSgDy662CeLcF+EUp9NHV3HOrm8bc1n+IMgvXEcPjB46OzyoSTJGW5prIGWpo114kcGZ1cu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E/5bo7P6; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E/5bo7P6"
Message-ID: <5ba172d5-5551-40fb-a3d8-521c471a334d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774511955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=34Zx/NqkbD/+leDsZuDXNlhFwVlMr8IpFSvBRz0tHhQ=;
	b=E/5bo7P6e5pgPv3sAS2MuZHLCiADlWMvV6uDpbA/Ad/S47UDicT7OOA1xEUQY7HKend4bM
	f+3DP6eO6gU7g02ZMMSti/U05BwFzjy2QJtV0+th7jitylV7uAjpsGwbkcwrS8RErMOTze
	Lv2mFdDRn5g3GxSq4xv1+C2qm4OxcTs=
Date: Thu, 26 Mar 2026 15:59:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ipv6: fix data race in fib6_metric_set() using
 cmpxchg
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fei Liu <feliu@redhat.com>
References: <20260326-b4-fib6_metric_set-kmemleak-v1-1-c89fc1b312c0@gmail.com>
 <e53a26e9-1120-4486-8b53-5caa8b959a28@linux.dev> <acTV0uiLrGTByBAC@fedora>
 <acTcoK1P7SFpDfwV@fedora>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <acTcoK1P7SFpDfwV@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/26/26 3:13 PM, Hangbin Liu wrote:
> On Thu, Mar 26, 2026 at 06:44:43AM +0000, Hangbin Liu wrote:
>> On Thu, Mar 26, 2026 at 02:23:15PM +0800, Jiayuan Chen wrote:
>>> On 3/26/26 12:22 PM, Hangbin Liu wrote:
>>>> fib6_metric_set() may be called concurrently from softirq context without
>>>> holding the FIB table lock. A typical path is:
>>>>
>>>>     ndisc_router_discovery()
>>>>       spin_unlock_bh(&table->tb6_lock)        <- lock released
>>>>       fib6_metric_set(rt, RTAX_HOPLIMIT, ...) <- lockless call
>>>>
>>>> When two CPUs process Router Advertisement packets for the same router
>>>> simultaneously, they can both arrive at fib6_metric_set() with the same
>>>> fib6_info pointer whose fib6_metrics still points to dst_default_metrics.
>>>>
>>>>     if (f6i->fib6_metrics == &dst_default_metrics) {   /* both CPUs: true */
>>>>         struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
>>>>         refcount_set(&p->refcnt, 1);
>>>>         f6i->fib6_metrics = p;   /* CPU1 overwrites CPU0's p -> p0 leaked */
>>>>     }
>>>>
>>>> The dst_metrics allocated by the losing CPU has refcnt=1 but no pointer
>>>> to it anywhere in memory, producing a kmemleak report:
>>>>
>>>>     unreferenced object 0xff1100025aca1400 (size 96):
>>>>       comm "softirq", pid 0, jiffies 4299271239
>>>>       backtrace:
>>>>         kmalloc_trace+0x28a/0x380
>>>>         fib6_metric_set+0xcd/0x180
>>>>         ndisc_router_discovery+0x12dc/0x24b0
>>>>         icmpv6_rcv+0xc16/0x1360
>>>>
>>>> Fix this by replacing the plain pointer store with cmpxchg() and free
>>>> the allocation safely when competition failed.
>>>>
>>>> Fixes: d4ead6b34b67 ("net/ipv6: move metrics from dst to rt6_info")
>>>> Reported-by: Fei Liu <feliu@redhat.com>
>>>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>>>> ---
>>>>    net/ipv6/ip6_fib.c | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
>>>> index dd26657b6a4a..64de761f40d5 100644
>>>> --- a/net/ipv6/ip6_fib.c
>>>> +++ b/net/ipv6/ip6_fib.c
>>>> @@ -730,14 +730,16 @@ void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val)
>>>>    	if (!f6i)
>>>>    		return;
>>>> -	if (f6i->fib6_metrics == &dst_default_metrics) {
>>>> +	if (READ_ONCE(f6i->fib6_metrics) == &dst_default_metrics) {
>>>> +		struct dst_metrics *dflt = (struct dst_metrics *)&dst_default_metrics;
>>>>    		struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
>>>>    		if (!p)
>>>>    			return;
>>>>    		refcount_set(&p->refcnt, 1);
>>>> -		f6i->fib6_metrics = p;
>>>> +		if (cmpxchg(&f6i->fib6_metrics, dflt, p) != dflt)
>>>> +			kfree(p);
>>>>    	}
>>>
>>> [...]
>>>
>>>>    	f6i->fib6_metrics->metrics[metric - 1] = val;
>>> Suggest using marked accessors to suppress KCSAN warnings:
>>>
>>> struct dst_metrics *m = READ_ONCE(f6i->fib6_metrics);
>>> WRITE_ONCE(m->metrics[metric - 1], val);
>> Thanks, I will update this in next version.
> BTW, do we really need to WRITE_ONCE here? What if the `val` are different
> on 2 CPUs? This would hide the problem, right?
>
> Thanks
> Hangbin
If concurrent writes to the same memory by two CPUs are considered a bug,
the solution is prevention, not detection by KCSAN. Furthermore, WRITE_ONCE
also helps suppress warnings from read-write races. For example, commit
6e84fc395e90 demonstrates this.


