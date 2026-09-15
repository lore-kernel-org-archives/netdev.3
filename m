Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B021A3932C4;
	Tue, 15 Sep 2026 02:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439866; cv=none; b=NOH2WrDtWv8AnKunM6LffSmcLLo+FThLPLxxzwf4HYzBxe/hiVjxPvht0N3RZnK6UX5+X5GdbgrS+cKz6VASu79SyNXhufmavC7Wx5bzAOuOREOmQBABWSj7g1VkRWSNhntmwhNThnhxPE4k2bR4G+kMeTVlm8YepTZ7xtX1zt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439866; c=relaxed/simple;
	bh=jiSJQ7E4lJiit7qoFo7su9yMGXIuFlfm1acbBBrUB8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uG+Z1rv0uyL7pcWvNXHR9tvynd/wE9q/EzYXqI77pfMwp6LQkFfedAh6+Nexk7qlKMB8rQh0fb3o/CU/AhHxykcRLWKxuQ3GJB5ATyEHLH0zGq0pn4FAkSczw02LvXLSlF9UWrjG7dhYHtrzZVyGaGn7k3nQkI6Ib77/4yo278g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Tq8NPD4v; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Tq8NPD4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=28NwV2vVlHtAdkRsxG+/ANtYLWRXJRqvNQbGV/81xgg=;
	b=Tq8NPD4v8mzwCFBXh1fLTRYca04q15eX59GU2imrTeI7mrpMlb6jcG4JkZPn5m
	dPqJ5iUQNC7E5qs/MNDEPC0EA4eiHJ7NRsbLzkhGbp07yHMP0JGdpUEZ8rugNcGF
	4SE4JoD51z2s6LVj4CfePWf/vLv1SWeIhQe5ECVx8CIME=
Message-ID: <182acfbd-d03a-4847-8fb8-4d0d29f22107@126.com>
Date: Tue, 15 Sep 2026 10:36:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv4: fib: annotate data-race around nh->nh_saddr
To: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20260911073758.2714564-1-xiaolinkui@126.com>
 <CAAVpQUAUAgAVutpQgMu4LjG1KOpm9Du0Kw1kbp2vHtHqQ5USZw@mail.gmail.com>
 <CANn89iJTMxWERqz1tdxuQ2jW6Rr7xN_ceh_yejtrBTPwN_YEeg@mail.gmail.com>
 <CANn89iJfphTDBFKdNkgmBHDybc8wV2EGSJoiHvzR0ht4V2bMAA@mail.gmail.com>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <CANn89iJfphTDBFKdNkgmBHDybc8wV2EGSJoiHvzR0ht4V2bMAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3HxpLr6hq5rZWBQ--.4839S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw4kGr4DWrWfAFWDtry5Arb_yoW5Aw1UpF
	W8Jasrta47XFW7AFs2q3WUA3W09w1rtFy0g34Ika4avrn0qr13JFySgr95uas8ZF4kXw43
	AF4DWr17A345Ka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxDGOUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlAzDmmqor0y6ewAA3h



On 2026/9/15 04:21, Eric Dumazet wrote:
> On Mon, Sep 14, 2026 at 12:57 PM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Mon, Sep 14, 2026 at 12:51 PM Kuniyuki Iwashima <kuniyu@google.com> wrote:
>>>
>>> On Fri, Sep 11, 2026 at 12:38 AM Linkui Xiao <xiaolinkui@126.com> wrote:
>>>>
>>>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>>>
>>>> fib_select_multipath() compares nexthop_nh->nh_saddr against the flow
>>>> source address with no lock held, while fib_info_update_nhc_saddr()
>>>> stores a new value from another CPU as soon as the preferred source
>>>> address of the egress device changes.
>>>>
>>>> Commit 195374d89368 ("ipv4: fib: annotate races around nh->nh_saddr_genid
>>>> and nh->nh_saddr") added WRITE_ONCE() on the store side and READ_ONCE()
>>>> in fib_result_prefsrc() after syzbot reported
>>>>
>>>>          BUG: KCSAN: data-race in fib_select_path / fib_select_path
>>>>
>>>> but it only covered that reader. fib_select_multipath(), reached from
>>>> fib_select_path(), is a second lockless reader of nh->nh_saddr and was
>>>> left bare.
>>>
>>> 32607a332cfe added the reader after 195374d89368.
>>>
>>
>> Indeed, please put in V2:
>>
>> Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches
>> source address")
> 
> Adding Willem
> 
> It seems that this code also lacks a check against genid?
Thanks Eric and Kuniyuki for the correction. I'll send a V2 with Fixes: 
32607a332cfe.

Kuniyuki, good catch on the missing genid check. nh_saddr is only 
meaningful when nh_saddr_genid matches dev_addr_genid, and 
fib_select_multipath() currently skips that validation. I'll fold the 
genid check into V2 along with the READ_ONCE annotations, unless you'd 
prefer to send it as a separate patch. Let me know.

Best regards,
Linkui Xiao
> 
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index 50e96f86ca59ab164f764f5d2185d158c14a4a6a..5a8bbcb65daaada1c3ae96339cabc2e801653dac
> 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -2185,6 +2185,7 @@ void fib_select_multipath(struct fib_result
> *res, int hash,
>          bool use_neigh;
>          int score = -1;
>          __be32 saddr;
> +       int genid;
> 
>          if (unlikely(res->fi->nh)) {
>                  nexthop_path_fib_result(res, hash);
> @@ -2193,6 +2194,7 @@ void fib_select_multipath(struct fib_result
> *res, int hash,
> 
>          use_neigh = READ_ONCE(net->ipv4.sysctl_fib_multipath_use_neigh);
>          saddr = fl4 ? fl4->saddr : 0;
> +       genid = saddr ? atomic_read(&net->ipv4.dev_addr_genid) : 0;
> 
>          change_nexthops(fi) {
>                  int nh_upper_bound, nh_score = 0;
> @@ -2205,7 +2207,9 @@ void fib_select_multipath(struct fib_result
> *res, int hash,
>                      (use_neigh && !fib_good_nh(nexthop_nh)))
>                          continue;
> 
> -               if (saddr && nexthop_nh->nh_saddr == saddr)
> +               if (saddr &&
> +                   READ_ONCE(nexthop_nh->nh_saddr_genid) == genid &&
> +                   READ_ONCE(nexthop_nh->nh_saddr) == saddr)
>                          nh_score += 2;
>                  if (hash <= nh_upper_bound)
>                          nh_score++;

