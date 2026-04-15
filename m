Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC953385AC;
	Wed, 15 Apr 2026 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776294880; cv=none; b=N9Tw7WxbQ6xzaMxCn3Pyj4+yepoavrGt60Bx7jbIVEcjAKlgK/xprTAjsV38KI0TbVHweYtpTC+yyF9ACRwrP6tU75aFHTsYMic0GCGgI7YnPC7wQg3hu/NE9KoVUpH421tRhjKRdyc5/aMp1eivGXYKU09xdmkU3bjoGgI3hUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776294880; c=relaxed/simple;
	bh=IcmijxZdC+BhUBqiRwmbE8FYI8MorWaag56fwHIYnaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfiGGQHydXTR8LfGTy+i9HxlCKG3A94zEjvcVgxaZ5pbJZHS1JVfEKNVyiP42sRo63MlxqTkI4fVHMyOt75bR9gGxVtDFH2nanR4Kdnmt75lWtMDb0mE8t72ovMLRb8gIxKjULcGKAmZR1MJMzcJ0TT6cup4BfjgKRiu4iuALW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=U+F5ZJpX; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="U+F5ZJpX"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A9D43113E7D;
	Thu, 16 Apr 2026 01:14:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776294876;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=OeFPr+ALTgMq0IMKEDlEFOHJAoIK1gIcttz9sveYRvI=;
	b=U+F5ZJpX3/4zSS+By5YIWlbop6c4YtPZ6kTIpUZ2HH8bxMnuXVWbfvWfoFjiNHYIzAOn4/
	AayiRoDkbcBSoPHWIEADWLmvZs6VbZq02mXIwA22OS00AJVfd6solAOuA+j6h1lzG5irKG
	14QoQuP7K+aByr8rHfN7xrJ0S8Bi6v0iWqc/nvRhRY094d+5jZh2gl/4vuZ3XONkNTO6FZ
	9tT99r7l5i+19KgixmmJtgk8fYHhZG+CM2lxwoSj3CDBcKPr5x5zHy8ZdAeBFb7ovTyQRK
	FxUlUouWIwAc48oFHOkUq1Z65zTTAfLxR53zv6YDGfWLLAI72m1jQP3Sjq8k4g==
Message-ID: <7734527a-d08b-49fa-b258-c37c5ae2da55@nabladev.com>
Date: Thu, 16 Apr 2026 01:14:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH v3 1/2] net: ks8851: Reinstate disabling of BHs around
 IRQ handler
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>,
 Paolo Abeni <pabeni@redhat.com>, Ronald Wahl <ronald.wahl@raritan.com>,
 Yicong Hui <yiconghui@gmail.com>, linux-kernel@vger.kernel.org
References: <20260414103327.113500-1-marex@nabladev.com>
 <20260414125753.Im6GAIHn@linutronix.de>
 <2fcfb84f-69f6-493e-94d6-95d85d8000f6@nabladev.com>
 <20260414145218.lsNpdAJI@linutronix.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260414145218.lsNpdAJI@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 4/14/26 4:52 PM, Sebastian Andrzej Siewior wrote:
> On 2026-04-14 16:20:46 [+0200], Marek Vasut wrote:
>>> This is what happens since commit 0913ec336a6c0 ("net: ks8851: Fix
>>> deadlock with the SPI chip variant"). Before that commit the softirq
>>> execution will be picked up by netdev_alloc_skb_ip_align() and requires
>>> PREEMPT_RT and a RX packet in #1 to trigger the deadlock.
>>
>> Do you want me to add this into the V4 commit message ?
> 
> The description does not match the code since the commit mentioned
> above.

I hope the V4 commit message is a bit better.

>>> The backtrace here and the description is based on an older kernel.
>>> However
>> I actually did update the backtrace in V3 with the one from current next
>> 20260413 .
> 
> That would be from yesterday and the change is merged since v6.10. But
> why is the softirq starting from __netdev_alloc_skb() instead of
> spin_unlock_bh(&ks->statelock)? After that unlock, the softirq must be
> processed and __netdev_alloc_skb() _could_ observe pending softirqs but
> not from ks8851.
Because __netdev_alloc_skb() also enables/disables BH , see the "else" 
branch:

  759 struct sk_buff *__netdev_alloc_skb(struct net_device *dev, 
unsigned int len,
  760                                    gfp_t gfp_mask)
  761 {
...
  786         if (in_hardirq() || irqs_disabled()) {
  787                 nc = this_cpu_ptr(&netdev_alloc_cache);
  788                 data = page_frag_alloc(nc, len, gfp_mask);
  789                 pfmemalloc = page_frag_cache_is_pfmemalloc(nc);
  790         } else {
  791                 local_bh_disable();
  792                 local_lock_nested_bh(&napi_alloc_cache.bh_lock);
...
  798                 local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
  799                 local_bh_enable();
...
