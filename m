Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474853F6614;
	Thu, 30 Jul 2026 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403289; cv=none; b=U07Hpsud9YyTDBb7724CXXKJNLOxvXzCKE1wmgsA0F8Cg4k+IQuWY+Nq5EbXEARWssuBnKoVsj3BG8kMJI9im9i45uz3STmRZKb98IYg2WK/NC43+MxN3YUxdGKRzyqkanmhgyh0oxSBIptei4bWw8xNpIyGKo4+mGlGzXU1EGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403289; c=relaxed/simple;
	bh=UInsaWDbdrSwoTEJsdBfpC1yKMLrZ9UoyNlFTTS47ds=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m8V+RIX7kf/o8BeWuyT1Ix3ZEvjsmg0GySnRjSbHyPOjgpauu+uVreIo9+6O5/+CU2pwhD4zodmpkf20oFSB//P5hAUi06KxhyUDJmrbPf4CNfyiP2k30RRzbC9mpMeNpHdgEqh10efXkwlmjHZciBlNq32wYmPPMRxfXVQt9oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WVl1tY8V; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WVl1tY8V"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nepUfLoqF6bqbQUSMjrQkvmDDqAdoktlr7zcVmRfsjs=;
	b=WVl1tY8V7WtkzTKWCcmIrvPZ+1ZnjH5TLH9CqnZ6sjm2Vo6nSlX12R5SMJUnsmJjqGsbqZs1N
	Ek8xMDYeBaPzhr9jhgyVUW6rU5/N2PbBVrG6VhDWpO5kJijdVedo5xtfxnNP85QeLGBTTRlqWX0
	kfjy9ogqSK89D2MufoA6/Vc=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h9k3Q4bzhzKmTp;
	Thu, 30 Jul 2026 17:11:46 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id BCCE8402AB;
	Thu, 30 Jul 2026 17:21:16 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 30 Jul 2026 17:21:15 +0800
Message-ID: <0d98a4d1-fad2-4539-b40d-58ea58cacff7@huawei.com>
Date: Thu, 30 Jul 2026 17:21:15 +0800
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
Subject: Re: [PATCH v3 net] net: page_pool: fix UAF in
 __page_pool_release_netmem_dma on xa_cmpxchg race
To: Mina Almasry <almasrymina@google.com>
References: <20260729110249.2824835-1-shaojijie@huawei.com>
 <CAHS8izO+kiugW_qN-US+S88ypDnaEePP+-78vnVOfBtb8P0AKg@mail.gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <CAHS8izO+kiugW_qN-US+S88ypDnaEePP+-78vnVOfBtb8P0AKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/7/30 6:35, Mina Almasry wrote:
> On Wed, Jul 29, 2026 at 4:03 AM Jijie Shao <shaojijie@huawei.com> wrote:
>> page_pool_scrub() iterates pool->dma_mapped via xa_for_each() with no
>> page ref held. __page_pool_release_netmem_dma() currently reads and
>> writes netmem fields (dma_addr, DMA index bits in pp_magic) after
>> xa_cmpxchg() returns. The unref path calls put_page() unconditionally
>> regardless of the cmpxchg outcome; when it loses the cmpxchg, it still
>> frees the page before the scrub winner finishes these netmem accesses,
>> so scrub touches a freed page -- a Use-After-Free.
>>
>> Fix this by:
>>
>> 1. Cache dma_addr to a local variable before xa_cmpxchg() in
>>     __page_pool_release_netmem_dma(), so the scrub winner uses the
>>     cached address for dma_unmap and never touches netmem fields after
>>     the cmpxchg.
>>
>> 2. Rename page_pool_release_dma_index() to page_pool_remove_dma_mapping()
>>     and strip it down to a pure cmpxchg wrapper; it no longer clears DMA
>>     index bits.
>>
>> 3. Move dma_addr and DMA index cleanup to page_pool_return_netmem(),
>>     which holds a page ref and can safely write netmem fields regardless
>>     of the cmpxchg outcome.
>>
>> The scrub path (no ref) only does cmpxchg + dma_unmap on the cached
>> address; the unref path (holds ref) clears dma_addr and DMA index bits
>> unconditionally before put_page().
>>
>> Suggested-by: Mina Almasry <almasrymina@google.com>
> Thanks for trying to give credit but I didn't do much but feed your
> earlier iteration to gemini. I don't mind either way but you can
> remove.
>
>> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them when destroying the pool")
>> Assisted-by: OhMyOpenCode:GLM-5.2
> I fed this to gemini and I got good feedback, but it needs improved
> human readability.
>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>> Changes in v3:
>> - Fix unlikely() to likely() for PP_DMA_INDEX_BITS to match
>>    file convention.
>> Link to v2: https://lore.kernel.org/r/20260727132612.3277927-1-shaojijie@huawei.com
>>
>> Changes in v2:
>> - Redesign the fix per Mina's review: v1's unconditional
>>    netmem_set_dma_index() introduced a UAF when the scrub path
>>    (no page ref) writes to a page freed by the unref path.
>> - Cache dma_addr before xa_cmpxchg; move dma_addr/DMA index
>>    cleanup to page_pool_return_netmem() which holds a page ref.
>> - Rename page_pool_release_dma_index() to
>>    page_pool_remove_dma_mapping() to reflect its new role as a
>>    pure cmpxchg wrapper.
>> - Link to v1: https://lore.kernel.org/r/20260724092135.414699-1-shaojijie@huawei.com
>> ---
>>   net/core/page_pool.c | 33 +++++++++++++++++++--------------
>>   1 file changed, 19 insertions(+), 14 deletions(-)
>>
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 21dc4a9c8714..b7f5cdb6c1c4 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -500,8 +500,8 @@ static int page_pool_register_dma_index(struct page_pool *pool,
>>          return err;
>>   }
>>
>> -static int page_pool_release_dma_index(struct page_pool *pool,
>> -                                      netmem_ref netmem)
>> +static int page_pool_remove_dma_mapping(struct page_pool *pool,
>> +                                       netmem_ref netmem)
> Not a readable name. IDK what 'removing dma mapping' means. It's not
> doing an unmap in the current iteration. Pick a new human-readable
> name based on the changes below:
>
>>   {
>>          struct page *old, *page = netmem_to_page(netmem);
>>          unsigned long id;
>> @@ -517,12 +517,7 @@ static int page_pool_release_dma_index(struct page_pool *pool,
>>                  old = xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
>>          else
>>                  old = xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0);
>> -       if (old != page)
>> -               return -1;
>> -
>> -       netmem_set_dma_index(netmem, 0);
>> -
>> -       return 0;
>> +       return (old == page) ? 0 : -1;
> This function, AFAICT, has only 1 call site where this return value
> decides whether to dma_unmap_page_attr. That's not easy for a human to
> follow. Just put the dma_unmap_page_attrs in this function.
>
> I asked gemini to apply my feedback and it gave me this (untested)
> patch. Consider reviewing this one and putting it through your
> testing/etc. Please review the comments around the code. Some look
> outdated? It's untested:
>
> ```
> net/core/page_pool.c
> index 21dc4a9c8714d..628854b56315b 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -500,29 +500,34 @@ static int page_pool_register_dma_index(struct
> page_pool *pool,
>          return err;
>   }
>
> -static int page_pool_release_dma_index(struct page_pool *pool,
> +static void page_pool_release_dma_index(struct page_pool *pool,
>                                         netmem_ref netmem)
>   {
>          struct page *old, *page = netmem_to_page(netmem);
>          unsigned long id;
> +       dma_addr_t dma;
> +
> +       dma = page_pool_get_dma_addr_netmem(netmem);
>
>          if (unlikely(!PP_DMA_INDEX_BITS))
> -               return 0;
> +               goto unmap;
>
>          id = netmem_get_dma_index(netmem);
>          if (!id)
> -               return -1;
> +               return;
>
>          if (in_softirq())
>                  old = xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
>          else
>                  old = xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0);
> -       if (old != page)
> -               return -1;
>
> -       netmem_set_dma_index(netmem, 0);
> +       if (old != page)
> +               return;
>
> -       return 0;
> +unmap:
> +       dma_unmap_page_attrs(pool->p.dev, dma,
> +                            PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> +                            DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
>   }
>
>   static bool page_pool_dma_map(struct page_pool *pool, netmem_ref
> netmem, gfp_t gfp)
> @@ -728,24 +733,13 @@ void page_pool_clear_pp_info(netmem_ref netmem)
>   static __always_inline void __page_pool_release_netmem_dma(struct
> page_pool *pool,
>                                                             netmem_ref netmem)
>   {
> -       dma_addr_t dma;
> -
>          if (!pool->dma_map)
>                  /* Always account for inflight pages, even if we didn't
>                   * map them
>                   */
>                  return;
>
> -       if (page_pool_release_dma_index(pool, netmem))
> -               return;
> -
> -       dma = page_pool_get_dma_addr_netmem(netmem);
> -
> -       /* When page is unmapped, it cannot be returned to our pool */
> -       dma_unmap_page_attrs(pool->p.dev, dma,
> -                            PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> -                            DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
> -       page_pool_set_dma_addr_netmem(netmem, 0);
> +       page_pool_release_dma_index(pool, netmem);
>   }
>
>   /* Disconnects a page (from a page_pool).  API users can have a need
> @@ -759,10 +753,17 @@ static void page_pool_return_netmem(struct
> page_pool *pool, netmem_ref netmem)
>          bool put;
>
>          put = true;
> -       if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops)
> +       if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_ops) {
>                  put = pool->mp_ops->release_netmem(pool, netmem);
> -       else
> +       } else {
>                  __page_pool_release_netmem_dma(pool, netmem);
> +               /* clear dma_addr/DMA index; safe because we hold a ref */
> +               if (pool->dma_map) {
> +                       page_pool_set_dma_addr_netmem(netmem, 0);
> +                       if (likely(PP_DMA_INDEX_BITS))
> +                               netmem_set_dma_index(netmem, 0);
> +               }
> +       }
>
>          /* This may be the last page returned, releasing the pool, so
>           * it is not safe to reference pool afterwards.
> ```
>

Hi Mina,

Thanks for the review! I restructured the fix as follows — is this
roughly what you had in mind?

Split into two functions. __page_pool_unmap_netmem_dma() does cmpxchg +
dma_unmap only, with dma_unmap inlined via a goto label. It caches
dma_addr before the cmpxchg and never touches netmem fields after, so
it is safe for the scrub path which holds no page ref:

static __always_inline void __page_pool_unmap_netmem_dma(struct page_pool *pool,
							 netmem_ref netmem)
{
	struct page *old, *page = netmem_to_page(netmem);
	unsigned long id;
	dma_addr_t dma;

	if (!pool->dma_map)
		return;

	dma = page_pool_get_dma_addr_netmem(netmem);

	if (unlikely(!PP_DMA_INDEX_BITS))
		goto unmap;

	id = netmem_get_dma_index(netmem);
	if (!id)
		return;

	if (in_softirq())
		old = xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
	else
		old = xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0);
	if (old != page)
		return;

unmap:
	dma_unmap_page_attrs(pool->p.dev, dma,
			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
}

__page_pool_release_netmem_dma() is now a thin wrapper that calls the
above and clears dma_addr/DMA index bits — safe because the caller
holds a page ref:

static __always_inline void __page_pool_release_netmem_dma(struct page_pool *pool,
							   netmem_ref netmem)
{
	if (!pool->dma_map)
		return;

	__page_pool_unmap_netmem_dma(pool, netmem);
	page_pool_set_dma_addr_netmem(netmem, 0);
	if (likely(PP_DMA_INDEX_BITS))
		netmem_set_dma_index(netmem, 0);
}

Scrub path calls __page_pool_unmap_netmem_dma() directly:

	xa_for_each(&pool->dma_mapped, id, ptr)
		__page_pool_unmap_netmem_dma(pool, page_to_netmem((struct page *)ptr));





