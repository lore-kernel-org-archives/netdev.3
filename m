Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564823B47D0
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420956; cv=none; b=qW0epvc1kZFC7Lqnwda3EuCgNmITHP2Rfx89lSivHhTF5LP2cfJn/ps9OkQFelk1kORp/zG0kd5Tg0rUmbnVaISD8LCLKkBWFXoPJCmtxLCOR06OmjoitsGjEzPTQ6ZtiUgsejhbQ/irmzrkGa2cUQXTuKNKoSG1ZGQKSlaFgfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420956; c=relaxed/simple;
	bh=bBPfqWjEhnOTllfco9OGArQ1YDXq0Ak7Wfo5cvZcbYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bM312v4bEZXYlw+dyh3Pcva9OpUFXFYgx3WCs4oHy6xZ1nwAAD2aTm5wNXIkfbly3QD2QS2qDk/5R1RZJ08AsEIQ8hXP68NBR+UddIpE2arPJD2D5Pqq0CSmjJoR/xnUVhzXrK00rMmDd9ompQkWWplJNkDUvhI5Rtc9D8NtwQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W2XxSvm/; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W2XxSvm/"
Message-ID: <ca14985b-1ed9-4242-a098-df52c2651135@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783420943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4TFvE1Rw3DQbDOqM6Yo8y6QbCnFXQQjvW8W6wp7SBg=;
	b=W2XxSvm/N1BVj1UbrSl/6tRKKVs4/z6FAiQMTL+rjMCb7fO4B7VbqtM/Kyiw/FLFVxTand
	fImO3twvXQMwWIFAIhAPP7ne1OSIL4dUmcQVoYVVozSUcK5k9C0SKHo2nfGClzu4jIgASS
	r2kGYMwOSMP5jSm/SjfEYueP38ZxRlM=
Date: Tue, 7 Jul 2026 18:41:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] ipv4: hold a consistent view of rt->dst.dev
 under RCU
To: Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260701032434.17500-1-xuanqiang.luo@linux.dev>
 <20260705164649.GA295849@shredder>
 <5e2119f1-3c1c-43eb-984e-a8eeab2896e0@linux.dev>
 <ef3a91ba-f4c5-4d89-a88b-465b5b7fab12@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <ef3a91ba-f4c5-4d89-a88b-465b5b7fab12@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/7/7 17:02, Paolo Abeni 写道:
> On 7/7/26 3:26 AM, luoxuanqiang wrote:
>> 在 2026/7/6 00:46, Ido Schimmel 写道:
>>> On Wed, Jul 01, 2026 at 11:24:34AM +0800,xuanqiang.luo@linux.dev wrote:
>>>> From: Xuanqiang Luo<luoxuanqiang@kylinos.cn>
>>>>
>>>> rt_flush_dev() walks the per-CPU uncached route list and rewrites
>>>> rt->dst.dev in-place to blackhole_netdev under spin_lock_bh().
>>>> This lock does not exclude RCU readers, which may load rt->dst.dev
>>>> multiple times within a single rcu_read_lock() region.
>>>>
>>>> ip_rt_send_redirect() is a typical example: it reads rt->dst.dev
>>>> three times to obtain in_dev, the L3 master ifindex, and net.
>>>> A concurrent device unregistration can repoint rt->dst.dev to
>>>> blackhole_netdev between those reads, making the reader combine
>>>> state from two different net_devices — for instance, an in_dev
>>>> from the real device but a netns and peer lookup from the blackhole
>>>> device.  ip_rt_get_source() has the same problem: it reads
>>>> rt->dst.dev four times to obtain the output ifindex, the netns,
>>>> and the source address, so a concurrent flush can cause the source
>>>> selection to mix state from different devices.
>>> Why only change ip_rt_send_redirect() and ip_rt_get_source() when the
>>> patch is titled "ipv4: hold a consistent view of rt->dst.dev under RCU"?
>>> What is the criterion?
>> Thanks! You are right, the subject is too broad. I will make them
>> more accurate in the next version.
>>
>>>> Take a single dst_dev_rcu() snapshot of rt->dst.dev at the start
>>>> of each affected RCU reader and use that snapshot throughout, so
>>>> concurrent flushes cannot cause mid-function inconsistency.
>>>> Publish the in-place write in rt_flush_dev() with rcu_assign_pointer()
>>>> to match the readers.
>>> The rt_flush_dev() change should be a separate change. Note that
>>> dst_dev_put() was already converted to use rcu_assign_pointer().
>>>
>> I will split the rt_flush_dev() change into a separate patch.
>>
>>>> Fixes: caacf05e5ad1a ("ipv4: Properly purge netdev references on uncached routes.")
>>> Please remove the Fixes tag given you are targeting net-next.
>> Just to clarify: is the suggestion to drop the Fixes tag here solely
>> because this patch is targeted at net-next? Or are there any other
>> reasons?
> Generally speaking, yes: net-next patches should not include a fixes tag
> unless the blamed commit is on net-next only.
>
> More specifically, this patch is really a behavior improvement and not a
> vertical fix, as such we want to avoid it propagating on stable trees,
> as the fixes tag sometimes does.
>
> /P
>
Many thanks for the detailed explanation!

