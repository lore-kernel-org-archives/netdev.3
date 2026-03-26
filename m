Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2AE23D7E3
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532659; cv=none; b=eypNV4bJF/sYlUda7eZGz3XmtVQuREWMMFbxArRXjLBpk7+4hPeB+fd3FjrH3agadmOuvSa3MObFBxdjbq1qJFgEZ0Yvg6tqv4Y4og330gYA1wQmu0a1keJgMtFLA8JeYe98hzRZeYZjt7aN68wdT0mE2b74RE+jfyotDLzOJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532659; c=relaxed/simple;
	bh=ew/Q3m7U+lO4YgU4uvx7Upq5ty6V9+n/JqWNR6xxuQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTXNiXQZPJ1iC6FWrIGw7MsKMtKn3jBY5pRjnKaa/QRq5XMGZnrXd8TVxvxjOo1Kp1Z0ovKGF+4+WiBlvK4IzDtXK4Eg/VcJwCer2qJ8Ij4H1jG4uMbfefcso3GhfgTmCmOKrIi2eNTUr5XxPVVbuS5BlL7f5nvK7PSgL6o1u0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LsNyKgWe; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LsNyKgWe"
Message-ID: <39c100fe-1f6f-46d2-8dd5-cf82320508ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774532655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K03odWVdcWJvYNK2crB2kHPKb7HJfs7rp0mRh5FSdFM=;
	b=LsNyKgWeX3kOe1qqaQwzKw05d0myOG8pxI8Te81T0fqtaK2Z1jmM2YXV4NksELckKXzMWO
	Bl7LYSk1OaQ2XGN3v8ElkhQGgs2K/kVcRtPkFquRuQJODmOHraK2wFIdZo6dZtFMFhPRFD
	di9WdJh2gzBBiHYxaE4yfqnvrxTVXLg=
Date: Thu, 26 Mar 2026 21:43:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ipv6: fix data race in fib6_metric_set() using
 cmpxchg
To: Hangbin Liu <liuhangbin@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fei Liu <feliu@redhat.com>
References: <20260326-b4-fib6_metric_set-kmemleak-v1-1-c89fc1b312c0@gmail.com>
 <CANn89i+SX1Kp7D2JzzEtg-zRkJzi4bdjzc2snvM7npJQzNp0+Q@mail.gmail.com>
 <acUw8zYwbbpgo8KJ@fedora>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <acUw8zYwbbpgo8KJ@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/26/26 9:13 PM, Hangbin Liu wrote:
> On Thu, Mar 26, 2026 at 05:05:57AM -0700, Eric Dumazet wrote:
>>> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
>>> index dd26657b6a4a..64de761f40d5 100644
>>> --- a/net/ipv6/ip6_fib.c
>>> +++ b/net/ipv6/ip6_fib.c
>>> @@ -730,14 +730,16 @@ void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val)
>>>          if (!f6i)
>>>                  return;
>>>
>>> -       if (f6i->fib6_metrics == &dst_default_metrics) {
>>> +       if (READ_ONCE(f6i->fib6_metrics) == &dst_default_metrics) {
>>> +               struct dst_metrics *dflt = (struct dst_metrics *)&dst_default_metrics;
>>>                  struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
>>>
>>>                  if (!p)
>>>                          return;
>>>
>>>                  refcount_set(&p->refcnt, 1);
>>> -               f6i->fib6_metrics = p;
>>> +               if (cmpxchg(&f6i->fib6_metrics, dflt, p) != dflt)
>>> +                       kfree(p);
>>>          }
>>>
>> The following line should happen before the cmpxchg(),
>>   ->metrics[X] accesses also need READ_ONCE()/WRITE_ONCE() annotations.
> Hi Eric,
>
> Jiayuan also suggested to using READ_ONCE()/WRITE_ONCE() for metrics[X]
> accesses. But I don't get why this line should happen before the cmpxchg(),
> Would you please help explain?


I think what Eric means is something like this:


...
         struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);

         if (!p)
             return;

         p->metrics[metric - 1] = val;
         refcount_set(&p->refcnt, 1);
         if (cmpxchg(&f6i->fib6_metrics, dflt, p) != dflt)
             kfree(p);
         else
             return;
     }
}

m = READ_ONCE(f6i->fib6_metrics);
WRITE_ONCE(m->metrics[metric - 1], val);


Since p is private data before being published via cmpxchg(), we can
safely initialize its metrics beforehand. This way we don't need to
worry about concurrent access to f6i->fib6_metrics->metrics[] during
initialization. Right?


