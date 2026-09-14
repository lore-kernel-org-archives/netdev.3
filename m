Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D762147DD44
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398580; cv=none; b=iBnwz6/M6XqAxHB/HO/9wb+ctvtrTI+c9D0q3HxzULBlMiyTsdszRJ2y72L4aZ1TVxT5CxTFufadQxfBCXdkRkttmg3m+KSFVTEA5CENOsBO0wnmcMdJgrwfY5WGfCUtCqGf/0dNhGOuTrJkKbAfbTwAH1yFsn//MV5KQ3FbwDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398580; c=relaxed/simple;
	bh=IiMcqHzawsoygOUmpDt2R7XR7oG4cX4pvQdzWru4lCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxD/odr+4dzKP2c+fFGQrxthlKb7vuUudikvPfC8eMtTwl1OK7TuRg7ea+9rlgaHLPmCNfCXOTy85Nk/6gW0W51gPkFL5aQskkGd0RRuXANHFU1gfv4m1K5y8H5E1PCuo2yA7xwLs4dXdkh2vPfuwjrlfaFUjtb8m86kzZYv4+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68EF9IP9078146;
	Tue, 15 Sep 2026 00:09:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68EF9IE3078142
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 15 Sep 2026 00:09:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4216f102-301c-4a11-8fe3-d937c9109cbd@I-love.SAKURA.ne.jp>
Date: Tue, 15 Sep 2026 00:09:16 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: track raw dev_put()/dev_hold() usage under
 CONFIG_NET_DEV_REFCNT_TRACKER=y
To: Eric Dumazet <edumazet@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Aleksandr Nogikh <nogikh@google.com>
Cc: Network Development <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <bd87fb25-b125-42b6-b70f-5bc5a9b6bcbd@I-love.SAKURA.ne.jp>
 <39ed6ba0-bef0-4710-9790-ab13092521b1@I-love.SAKURA.ne.jp>
 <591e7555-a399-4753-becb-b00df2df660d@I-love.SAKURA.ne.jp>
 <56c707e7-1fb0-43ec-b8fb-cf6f451e513e@I-love.SAKURA.ne.jp>
 <271af679-34c1-4f7e-875c-4761c22595eb@I-love.SAKURA.ne.jp>
 <d0d5bb33-c9fb-4442-9015-7999f91b4e29@I-love.SAKURA.ne.jp>
 <CANn89i+-pNgDa1TEs3TYCoeHhf6_eeLuQ7jhpzDZvEXc+3WkcA@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CANn89i+-pNgDa1TEs3TYCoeHhf6_eeLuQ7jhpzDZvEXc+3WkcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav313.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/09/14 20:44, Eric Dumazet wrote:
> I am adding Dmitry and Aleksandr to Cc, because I think the best answer
> to your problem is not a netdev one. More on this below.
> 
> First, sorry for letting this series sit for three rounds. You are one
> of the very few people actually chasing the "unregister_netdevice:
> waiting for %s to become free" reports, that work is not fun, and
> silence is not the answer you deserved.
> 
> Let me also say clearly that I do not think the approach is bogus. Once
> a reference is taken without a tracker, there is no slot to store a
> cookie in, so counting +1/-1 per unique stack and looking at the balance
> is essentially the only thing one can do. And 10 bugs fixed is more
> evidence than most debug facilities come with.
> 
> My problem is the cost/benefit for mainline. This adds a field to
> struct net_device and code to __dev_hold()/__dev_put(), which are inline
> and expanded in thousands of places, in order to produce information
> that is strictly weaker than what ref_tracker already gives us (a stack
> balance cannot tell which hold was not released when the same call site
> does both). It is a workaround for an incomplete migration, and we would
> be carrying it forever. Even with a perfect implementation I would be
> lukewarm, and I would rather tell you that now than stay silent again.

Excuse me, but Gemini already has the ability to identify in which subsystem
__dev_put() is missing
( https://lkml.kernel.org/r/73ed3aa5-f6e1-47b6-9e5d-428ac1f4cbf3@I-love.SAKURA.ne.jp ).

And, that ability allows us to determine which subsystem should be examined
using ref_tracker
( https://lkml.kernel.org/r/2bc332e0-b250-4679-a075-1c413ad843ce@I-love.SAKURA.ne.jp ).

And, converting culprit subsystem to use of ref_tracker allows us to find the cause
( https://lkml.kernel.org/r/deb3ac27-5eaf-406a-9bf4-733cc43ecaba@I-love.SAKURA.ne.jp ).

This is much efficient debugging approach than trying to convert all subsystems
to use ref_tracker (need to continue converting all culprits until we find v.s.
need to convert single culprit).

> If you would rather still pursue mainline inclusion, here is what I
> would need, roughly in order of importance:
> 
> 1) The per-call list walk has to go. Today every __dev_hold() /
>    __dev_put() walks a per-device list doing memcmp() of up to 160 bytes
>    per node. With a few thousand distinct traces on a device, that is
>    hundreds of KB of memory traffic per refcount operation, and it gets
>    worse precisely on the devices you are investigating. I suspect it
>    costs much more than the stack_trace_save() itself. stack_depot_save()
>    gives you a handle, and a small hash of { handle -> atomic count }
>    makes this O(1), removes the 6 MiB static array, the global raw
>    spinlock, the sticky "exhausted" flag and the dedup pass at dump time.
>    Ideally this lives in lib/ref_tracker.c as a "count only" mode, so
>    other ref_tracker users benefit and net/core/dev.c gains a few lines.

We can reduce memcmp() by combining with hash. Current implementation is
focused on avoiding memory allocation, for we don't know what locks the callers
of __dev_hold() / __dev_put() might be holding.

> 
> 2) Do not overload CONFIG_NET_DEV_REFCNT_TRACKER. People enable it today
>    expecting the cost of one stackdepot entry per tracked reference. A
>    separate option (default n, depends on DEBUG_KERNEL), ideally behind a
>    static key, lets them opt in knowingly. Some numbers on the slowdown
>    would help too.

That is no problem. I am considering to propose a kernel config option like
CONFIG_DEBUG_AID_FOR_SYZBOT.

> 
> 3) The kernel/softirq.c, kernel/rcu/tree.c, kernel/workqueue.c and
>    net/socket.c hunks are not needed, and this one is free for you:
>    filter_irq_stacks() (include/linux/stackdepot.h), already used by
>    KASAN, KFENCE and kmemleak, trims the stack at the
>    .irqentry/.softirqentry boundary, which is what your open-coded
>    trimming does. That removes the noinline declarations, the boot time
>    timer + kallsyms dance, and the need for acks outside netdev. The
>    remaining name matching ("process_one_work", "__sys_bind", ...) will
>    rot silently; capping the depth should be enough.

Thank you for pointing filter_irq_stacks() out.

> 
> 4) The dump is called from the 10 seconds warning loop, so a device that
>    never goes away prints 100+ traces every 10 seconds forever. That
>    message is not rare in the field, and the flood can cause hung task
>    splats and RCU stalls of its own. Please print once, or behind a
>    ratelimit / an explicit sysctl.

Current implementation is tuned for syzbot which gives up upon first message.
We can improve it.

> 
> Two minor ones: in alloc_netdev_mqs() the erase_netdev_trace_buffer()
> call sits inside the #ifdef CONFIG_PCPU_DEV_REFCNT block, so entries leak
> on that path when it is unset; and netdev_trace_buffer_exhausted is never
> cleared, so one unlucky device permanently disables the balance line for
> all others.

It doesn't leak. CONFIG_PCPU_DEV_REFCNT=n case does not call __dev_hold().

If we want to avoid netdev_trace_buffer_exhausted, we can dynamically attach
PAGE_SIZE'd blocks to net_device. But we need to be careful when trying to
allocate memory from __dev_hold() / __dev_put() path.

> 
> Last thing, on netdevice_tracker. I know your view is that nobody will
> convert the remaining callers, and you are not wrong that it has been
> slow. But a converted call site gives paired data, which is strictly
> better than a balance, and it is a permanent improvement rather than a
> debug facility. If you send me the list of remaining raw
> dev_hold()/dev_put() users, I will take a share of the conversions and
> review the rest, subsystem by subsystem. That is a burden you should not
> be carrying alone, and it is a fair thing for you to ask of us.

Narrowing down (with this evidence) which subsystem to convert to ref_tracker
using my approach is a powerful reasoning for involving relevant people.
