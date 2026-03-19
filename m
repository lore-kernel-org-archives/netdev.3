Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D8F19CD1D
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889476; cv=none; b=b3cgW+32OIlXic5CrP2vkHPNl273VQM960bP9EHyjyQRwSZKRXvhK0fEKc/WIE5VMbe4gLmYq1K8pxjuEUTOTfGvTYiMh3ULnofUYOk+cSkGeTFFSvwUsvuhD5oueqDobiJMOn8opsEM1ACdvVcs315e6DVEbTWEUuMNrsvF0tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889476; c=relaxed/simple;
	bh=nEuNJew9DtfGgy45wVGgnodSVPjrqqmcDttRgAMy6Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9e32Em6Xt4Io1uzCBxQ40aD8EzyaMCYMYRVETpwXAjbIk84NqWJTOv/ngFEyv4S06q+neaZH+Q5brbz1XqYs7oAJYuvpAbhSjHCaP4oUvWQjI294xbq7CUH6Oekv3u6sYQrWPVsKYLwO51wru9XZEnfW9Xs1LiG9LbAvaV3bWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sx/5GzEZ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sx/5GzEZ"
Message-ID: <f877e139-2da9-49d9-93bf-9b4155d687a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773889473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OjOF20wdxrGrBFSt0GJGKkiNPQOJVnl0L9OdFsrtMY=;
	b=sx/5GzEZ34gPtRHb7EespSWifEhhgqYLbnSNhaWCz9kXr/nHW4mtL4eHNjslB4vG+q0o8n
	GWTmehddqFQs7gYGXAcf8+qehrJ5l5OM6op6p9yf7DI8mIf3iBRtxbEBg1US5WXhGpiEBv
	EyEmuI5XeK22HOc/Nt9Q/hdCZ07+NB4=
Date: Thu, 19 Mar 2026 11:04:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] net/ipv6: mcast: fix circular locking dependency
 in __ipv6_dev_mc_inc()
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+afbcf622635e98bf40d2@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Taehee Yoo <ap420073@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20260317111208.62667-1-jiayuan.chen@linux.dev>
 <20260318181536.47ed9fd1@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260318181536.47ed9fd1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/19/26 9:15 AM, Jakub Kicinski wrote:
> On Tue, 17 Mar 2026 19:12:07 +0800 Jiayuan Chen wrote:
>> syzbot reported a possible circular locking dependency:
>>
>>    fs_reclaim --> sk_lock-AF_INET6 --> &idev->mc_lock
>>
>>    CPU0                              CPU1
>>    ----                              ----
>>    lock(&idev->mc_lock)
>>                                      lock(sk_lock-AF_INET6)
>>                                      lock(&idev->mc_lock)  // blocked
>>    kzalloc(GFP_KERNEL)
>>      fs_reclaim
>>        ...nbd I/O...
>>          sk_lock-AF_INET6            // blocked -> DEADLOCK
>>
>> __ipv6_dev_mc_inc() does GFP_KERNEL allocation inside mc_lock via
>> mca_alloc(). This can enter memory reclaim, which through nbd block
>> I/O may need sk_lock-AF_INET6. But sk_lock -> mc_lock already exists
>> via setsockopt -> __ipv6_sock_mc_join, so we have a deadlock.
>>
>> Before commit 63ed8de4be81 ("mld: add mc_lock for protecting
>> per-interface mld data"), only RTNL was held during the allocation.
>> The lock ordering was always RTNL -> sk_lock (the nbd path doesn't
>> involve RTNL), so there was no circular dependency.
>>
>> Split mca_alloc() into mca_alloc() + mca_init(): mca_alloc() does the
>> GFP_KERNEL allocation before mc_lock, mca_init() initializes under
>> mc_lock. If the address already exists, the pre-allocated memory is
>> simply freed. Also move inet6_ifmcaddr_notify() outside mc_lock since
>> it also does GFP_KERNEL allocation.
> Moving the allocation seems fine, but also having to move the
> notification, potentially letting the notification go out of order
> makes me wonder if we aren't better off adding helpers for taking this
> lock which also call memalloc_noio_{save,restore} ?
Yeah, using memalloc_noio helpers is simpler. I checked and there
are about 18 places taking mc_lock, so having a common mc_lock()/mc_unlock()
wrapper that does the noio save/restore covers them all (if necessary).

The only thing that feels a bit odd is using memalloc_noio in the networking
subsystem. It makes sense in block/fs to protect itself from recursion.
