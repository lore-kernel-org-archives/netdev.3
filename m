Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3F638E113
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 05:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780031012; cv=none; b=quF3oOposGQ6lyscqyHUERMp9HKAXVcKkgyc+yLyUG5WvkgcGB64pJiVLepGWtONSQJP+TgcteF776ZUuR4Q8UX3Vosj0k8KfPxYJ2SOLmEePMg9NzWotOZiSyeqycjtSMK6if92tPAoUF4G5IcUbF+3eY5qjNTR+1/6+SHezMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780031012; c=relaxed/simple;
	bh=oP7cPGEcP1X0WeBLHgDcb+0X8KkMCocTsoyFfzfTx9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/CjplcjuEofmriDDCGLrGeZjsKtTS7HlRQKfTIuqM2rho4tSCVpEjPKWrVSSc0R80jmcr4Yvwe5GlUwfaM8Sx1Sol+oNu5Bz/cfs45VSRkUWGQByMww9YzqYBBTApLFB+VIE5S/jtyI9suayX5QCLw8/W2VUbFYSZaIkLL+rJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s3vPjiqy; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s3vPjiqy"
Message-ID: <2a64dc4a-ad65-4fbf-a505-f4813886629b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780030998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRdHeKDtR2mwyafnPfiY2fq+XDoh3loYzmQhXIoPiLQ=;
	b=s3vPjiqyeyzE3qYl+fZWxK/GHf0I1ZO0rt2+zQpG5bT+Etpn8Az6+KlP3+EQJgF4BMOZJU
	8boua2LXB6Y4nxUnWJsVhn7A+JzrZjDc1lv52Sm0l6aoQ6K21+yusP5XP5FKrcyI4RiGHK
	Ae0OLw9TQXHaZ5mA0VLIC1fSpEqut5g=
Date: Fri, 29 May 2026 13:02:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ipv6: anycast: insert aca into global hash under
 idev->lock
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20260529032026.363856-1-jiayuan.chen@linux.dev>
 <CAAVpQUCJxaPTsA8DJ-KzPpWM2_GQr1LBHfdyEo9ziCA4sEqv-w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAAVpQUCJxaPTsA8DJ-KzPpWM2_GQr1LBHfdyEo9ziCA4sEqv-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/29/26 11:41 AM, Kuniyuki Iwashima wrote:
> On Thu, May 28, 2026 at 8:20 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> syzbot reported a splat [1]: a slab-use-after-free in
>> ipv6_chk_acast_addr(), which walks the global inet6_acaddr_lst[] hash
>> under RCU and dereferences a struct ifacaddr6 that has already been
>> freed while still linked in the hash, so a later reader walks into a
>> dangling node.
>>
>> In __ipv6_dev_ac_inc() the aca is allocated with refcount 1, then
>> aca_get() bumps it to 2 to keep it alive across the unlocked region.
>> It is published to idev->ac_list under idev->lock, but
>> ipv6_add_acaddr_hash() runs after write_unlock_bh(). A concurrent
>> teardown (ipv6_ac_destroy_dev() from addrconf_ifdown(), under RTNL)
>> can slip into that window:
>>
>>    CPU0 __ipv6_dev_ac_inc           CPU1 ipv6_ac_destroy_dev (RTNL)
>>    ------------------------------   ------------------------------------
>>    aca_alloc()              refcnt 1
>>    aca_get()               refcnt 2
>>    write_lock_bh(idev->lock)
>>      add aca to ac_list
>>    write_unlock_bh(idev->lock)
>>                                     write_lock_bh(idev->lock)
>>                                       pull aca off ac_list
>>                                     write_unlock_bh(idev->lock)
>>                                     ipv6_del_acaddr_hash(aca)
>>                                       hlist_del_init_rcu() is a no-op,
>>                                       aca is not in the hash yet
>>                                     aca_put()           refcnt 2->1
>>    ipv6_add_acaddr_hash(aca)
>>      aca now inserted into the hash
>>    aca_put()                refcnt 1->0
>>      call_rcu(aca_free_rcu) -> kfree(aca)
>>
>> The hash removal becomes a no-op because the insertion has not
>> happened yet, so once CPU0 inserts and drops the last reference, the
>> aca is freed while still linked in inet6_acaddr_lst[], and readers
>> dereference freed memory after the slab slot is reused.
>>
>> This window opened once RTNL stopped serializing the join path against
>> device teardown. Move ipv6_add_acaddr_hash() inside the idev->lock
>> section so the ac_list and hash insertions are atomic with respect to
>> teardown: a racing remover now either misses the aca entirely or finds
>> it in both lists.
>>
>> [1] https://syzkaller.appspot.com/bug?extid=a01df04303c131efbf3a
> Closes: and Reported-by ?



It has already been closed automatically, so I didn't add a Closes tag.
As for the Reported-by tag, it should be carried along with the patch.


I'll pay attention next time. :)

>> Fixes: eb1ac9ff6c4a ("ipv6: anycast: Don't hold RTNL for IPV6_JOIN_ANYCAST.")
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Change itself looks good, thanks
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>
>
>> ---
>>   net/ipv6/anycast.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
>> index 67a42e01dfc3..cd8c02a1ad4c 100644
>> --- a/net/ipv6/anycast.c
>> +++ b/net/ipv6/anycast.c
>> @@ -371,10 +371,10 @@ int __ipv6_dev_ac_inc(struct inet6_dev *idev, const struct in6_addr *addr)
>>          aca->aca_next = idev->ac_list;
>>          rcu_assign_pointer(idev->ac_list, aca);
>>
>> -       write_unlock_bh(&idev->lock);
>> -
>>          ipv6_add_acaddr_hash(net, aca);
>>
>> +       write_unlock_bh(&idev->lock);
>> +
>>          ip6_ins_rt(net, f6i);
>>
>>          addrconf_join_solict(idev->dev, &aca->aca_addr);
>> --
>> 2.43.0
>>
