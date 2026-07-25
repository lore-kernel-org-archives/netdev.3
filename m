Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986092F532C;
	Sat, 25 Jul 2026 02:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784947700; cv=none; b=Hib+AiAZIjvJRagWrGhP2uvRNVXlKDGNXeEoM8uqRKTXl82h9QJSfrgwKBAAs/9O3K4Xj0elDlhzDGOSrD0VMCRKNVzzwqO4nAibYjOB87hnCJshKeMfn8oufjkozwPT60tm3Ox9IWZC+XZ4gdVgnvQORGQZRqOOIhophDOiDnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784947700; c=relaxed/simple;
	bh=guOsYibO7QMNNX7lkIMvcUY1u8vTrX4+NoNiYHL0rRY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nj2WqAMVeo+EqwHkUnginwtlKxfY4JY0FByVbXSnM+zwqTEmYFvYJY7dR18hMfpRtzNX29zx8TDJcs5OEgitsB1JeS6fYSh0Z64EAX2YjgVvkkc6seJnGNZUGJfW4aG530YULvIWgrbQ9iejblnRaz3xuGQTdjDpFOtL0s35eLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=qzOIjR46; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="qzOIjR46"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sC8U7OUmzzrKPJM/6GjCTj61i7RT1qLaPD1QDJZ5GVo=;
	b=qzOIjR46i33fZMihMGGdg9npfX01OhTOBYCUZx9HrLvEhoNcE2zf1U1xavctHQbMRrJDhbebV
	mGrRIdf8yZPulUZXTQzARX7S4diJKSdPb8WI3sxJCkwNbkdjBJhS2Tx7YkumHU8yBeCxTI6G1am
	t4TCJVCpiAC3g6pwB144Ytw=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4h6TZ86Zc5zLlTV;
	Sat, 25 Jul 2026 10:38:40 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 436C34057C;
	Sat, 25 Jul 2026 10:48:05 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 25 Jul 2026 10:48:04 +0800
Message-ID: <f708da1d-3ce1-469d-b63a-ae2d6f331a24@huawei.com>
Date: Sat, 25 Jul 2026 10:48:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <hawk@kernel.org>, <ilias.apalodimas@linaro.org>,
	<toke@redhat.com>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: page_pool: fix DMA index not cleared on
 xa_cmpxchg race
To: Mina Almasry <almasrymina@google.com>
References: <20260724092135.414699-1-shaojijie@huawei.com>
 <CAHS8izPTQ5rOXs5rfVc3tnWcaeQ8wJ1qJqSXEfboe0OTGNkLkA@mail.gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <CAHS8izPTQ5rOXs5rfVc3tnWcaeQ8wJ1qJqSXEfboe0OTGNkLkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/7/25 2:33, Mina Almasry wrote:
> On Fri, Jul 24, 2026 at 2:22 AM Jijie Shao <shaojijie@huawei.com> wrote:
>> page_pool_release_dma_index() uses xa_cmpxchg() to atomically remove a
>> page from pool->dma_mapped.  When the cmpxchg loses the race (the entry
>> was already removed by a concurrent release path, e.g. page_pool_scrub()
>> during page_pool_destroy()), the function returns -1 *without* clearing
>> the DMA index bits stored in pp_magic.  Its caller then skips dma_unmap
>> based on that -1, which is correct, but the stale DMA index bits left
>> in pp_magic are wrong: the xarray entry they index no longer exists.
>> A page recycled back into the pool then carries a dangling DMA index,
>> and kernels that validate pp_magic in the return path surface this as
>> a WARN.
>>
>> Move netmem_set_dma_index(netmem, 0) to execute unconditionally before
>> return, so both the winner and the loser of the xa_cmpxchg race clear
>> the DMA index bits.  The return value still distinguishes the two
>> cases (-1 loser / 0 winner), preserving the contract that exactly one
>> side performs dma_unmap.
>>
>> The race window opens when page_pool_destroy() runs concurrently with
>> late page returns from SKBs held in per-CPU defer lists, TCP receive
>> queues or GRO hashes -- e.g. a driver reconfiguring channels/ring
>> depth while traffic is flowing.
>>
>> Observed on arm64 (7.2.0-rc1) with the hns3 driver:
>>
>>    WARNING: net/core/netmem_priv.h:18 at page_pool_clear_pp_info+0x20/0x38,
>>             CPU#83: iperf/3874878
>>
>> Return path (CPU_B, process context, triggering the WARN).  The page
>> was held in a per-CPU SKB defer list and is being released through
>> tcp_recvmsg():
>>
>>    page_pool_clear_pp_info+0x20/0x38
>>    page_pool_put_unrefed_netmem+0x11c/0x2e8
>>    napi_pp_put_page+0xf0/0x120
>>    skb_release_data+0x170/0x228
>>    skb_attempt_defer_free+0x7c/0x1f0
>>    tcp_recvmsg_locked+0x710/0x9a0
>>    tcp_recvmsg+0x74/0x1c8
>>    inet_recvmsg+0x2c/0xf0
>>    __sys_recvfrom+0xdc/0x198
>>    __arm64_sys_recvfrom+0x2c/0x48
>>    invoke_syscall+0x5c/0x120
>>    el0_svc_common.constprop.0+0xc8/0xf0
>>    do_el0_svc+0x24/0x38
>>    el0_svc+0x34/0x1e0
>>    el0t_64_sync_handler+0xa0/0xe8
>>    el0t_64_sync+0x1ac/0x1b0
>>
>> Scrub path (CPU_A, racing with the return path, derived from code):
>>
>>    page_pool_destroy
>>    -> page_pool_scrub
>>       -> xa_for_each(dma_mapped)
>>          -> __page_pool_release_netmem_dma
>>             -> page_pool_release_dma_index   <- race window
>>
>> Debug approach and evidence:
>> Reproduced with a stability test that repeatedly reconfigures the hns3
>> channel count and ring depth (ethtool -L/-G) while running iperf3 with
>> multiple parallel streams, then closes the iperf3 sockets to release
>> the SKBs held in TCP receive queues and per-CPU defer lists.
>>
>> On the unmodified kernel the WARN reproduces after hours to tens of
>> hours. To make the race window observable, a debugfs knob injects a
>> controlled udelay() right after the winning xa_cmpxchg() in
>> page_pool_release_dma_index(), widening the gap between the xarray
>> entry removal and the pp_magic cleanup.  With the delay injected the
>> WARN reproduces 4-5 times within about half an hour.
>>
>> Instrumentation added to page_pool_release_dma_index() logs the per-
>> page pp_magic, DMA index, refcount and dma_addr at release time.  A
>> representative log line from a WARN-triggering page:
>>
>>    PP_DMA_IDX: magic=0xdead0000000cbec0 idx=6525 refcnt=1 dma_addr=0x0
>>
>>    magic=0xdead0000000cbec0  -> PP_SIGNATURE | (6525 << shift)
>>    idx=6525                  -> DMA index bits still set in pp_magic
>>    dma_addr=0x0              -> scrub already did dma_unmap + cleared addr
>>    refcnt=1                  -> inflight page, unrefed release path
>>
>> The combination "dma_addr == 0 but DMA index != 0" is the signature of
>> the race: CPU_A (scrub) won the xa_cmpxchg, performed dma_unmap and
>> cleared dma_addr; CPU_B (return) lost the cmpxchg, returned -1 and
>> skipped netmem_set_dma_index(0), leaving the DMA index bits stale --
>> exactly the gap this fix closes.
>>
>> With this fix applied the WARN no longer triggers under the same
>> workload (verified overnight), both with and without the debugfs
>> delay knob enabled.
>>
>> Fixes: 95920c2ed02b ("page_pool: Fix PP_MAGIC_MASK to avoid crashing on some 32-bit arches")
>> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them when destroying the pool")
>> Assisted-by: OhMyOpenCode:GLM-5.2
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> If at all possible, when generating fixes via LLMs, spend time
> reviewing the patch yourself before sending to make sure the patch
> makes sense. In this case, I was taken back that this 10+, 3- fix came
> with such a huge huge commit message.


Thanks for the review, Mina. Fair point on the commit message length — this
was my first time digging into page_pool internals and the message ended up
documenting the whole investigation path. I first saw the call trace on
6.17-rc4 and spent a long time chasing the hns3 driver before realizing the
issue was in page_pool itself. The fix was LLM-suggested and I did run it,
but only under iperf — which, as you note, is not enough to surface the
UAF (the freed page isn't reused fast enough for the stale write to land on
a different subsystem's memory, so "no crash / no WARN" lulled me into
thinking the fix was safe). I should have reasoned about the refcount
contract from the code rather than relying on workload symptoms. I'll trim
the commit message heavily in v2.


>
> I did not review my self but my LLM - which does not tire in reading
> the long commit message - came up with this review. It looks like it
> may be correct. I think the fact that we do not touch the netmem at
> all if we lose the race is intentional, because the netmem may not be
> allocated:
>
> ```
>    While this fixes the WARN_ON_ONCE, it introduces a critical
> Use-After-Free (UAF) and memory corruption bug in the scrub path.
>
>    page_pool_scrub() iterates over pool->dma_mapped without holding a
> reference to the page. If the scrub path races with the normal unref
> path and wins xa_cmpxchg(), the unref path will proceed to free the
> page.
>
>    If the scrub path is preempted immediately after xa_cmpxchg(), the
> page will be freed before the scrub path can continue. When the scrub
> path resumes, it will execute your new netmem_set_dma_index(netmem,
> 0), read the dma_addr,
>    and clear it—all on a freed page that may now belong to another
> subsystem. This will corrupt memory and unmap garbage DMA addresses.


You're right. I verified in the source:

     - page_pool_scrub() walks pool->dma_mapped via xa_for_each() with no
       get_page on the entries (net/core/page_pool.c:1178).
     - page_pool_return_netmem() calls put_page() after
       __page_pool_release_netmem_dma() returns (net/core/page_pool.c:778),
       so the unref path can free the page once refcount hits 0.

So "loser doesn't touch netmem" is indeed the intended contract, and v1
breaking it on the scrub-loser path is a real UAF.

One clarification on the scope of the LLM review's UAF claim: the scrub
**winner** UAF it describes is pre-existing, not introduced by v1. In
__page_pool_release_netmem_dma() (unchanged by v1), the winner path does:

       if (page_pool_release_dma_index(pool, netmem))   // cmpxchg
           return;
       dma = page_pool_get_dma_addr_netmem(netmem);      // READ netmem->dma_addr
       dma_unmap_page_attrs(..., dma, ...);
       page_pool_set_dma_addr_netmem(netmem, 0);          // WRITE netmem->dma_addr
       
These three netmem dereferences happen after the cmpxchg wins, with no page
ref held. If the unref loser races to put_page() in between, the scrub winner
reads/writes a freed page. v1 doesn't change the winner path; it only adds a
new netmem_set_dma_index() write on the **loser** path, which is the new UAF
v1 introduces.


>
>    To safely fix this:
>
>    1. __page_pool_release_netmem_dma() must cache dma_addr to a local
> variable before calling xa_cmpxchg().
>    2. The scrub path (winner) must not touch netmem after a successful
> xa_cmpxchg().
>    3. The unref path (loser), which safely holds the page reference,
> should handle clearing the DMA index and dma_addr to satisfy the WARN,
> regardless of the race outcome.

For v2 I'll follow your direction:

     1. Cache dma_addr to a local variable before xa_cmpxchg() in
        __page_pool_release_netmem_dma().
     2. Scrub path (winner or loser) does not touch netmem fields after
        cmpxchg; it only does dma_unmap on the cached address.
     3. Unref path, which holds the page ref, clears dma_addr and DMA index
        bits regardless of the cmpxchg outcome.

This fixes both the v1-introduced loser UAF and the pre-existing winner UAF.

Will send v2 soon.

Thanks,
Jijie Shao


