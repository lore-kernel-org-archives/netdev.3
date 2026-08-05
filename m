Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E423E4C61;
	Wed,  5 Aug 2026 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918089; cv=none; b=E2ZlT2pPUu4P4P44WzV7HoMhpgGm6PeXJvtGIRK7Wo31vGsh7iDtKHb6Bno1k1437bwqHfSi+xRxvEILDVy1YmbmtUJzlwSltR+StmENLf3hsIlewRT5ptw9A4MR4DxrbicfMX7HlnJpp1ufHrtp72fz86yl89fG3m1BKp2qcgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918089; c=relaxed/simple;
	bh=FEad3da9/YtJbJn7Ae5EExNe04C1ck2KOOPbr5uPN7U=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IkjdlSAOT3OofCLVG9RuW17yBKovIQJTP6N6lNtU4Q30i2Hb/8eqC5aty2w7qUIHAkPmkg3ZjpgEcPxAlU1TLtAh+19x1VF005w/d2UKdP1tDyZ2C/ocS5OEJknp/J+73asCsMdt/evIe6zgLkwHbrFVqkX3XAEqVggVdCrafPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1EMkthti; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1EMkthti"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=L7sD+hrsCCO6GXRInJ0UA6QU5IQ8iSVf7UotkNMYvRU=;
	b=1EMkthtiyytQm0JT6Fb8MD65SJpyvB/WwoL8CE8RKylpXPo1eT6u9iRBC1AO+jETBr74ZLPeU
	YrTKq2krYc+Uy4M3qMKeRGLhnhXV0oYF/IS1UOnGFa24svCG7IcPBCm8Ihg3mCeQHkwuK0igDDv
	a/i2j1e/a0yrjngzGGfK4Fg=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hFNRW4W5FzRhR0;
	Wed,  5 Aug 2026 16:11:51 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 91DBE4056D;
	Wed,  5 Aug 2026 16:21:21 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 16:21:20 +0800
Message-ID: <590910a6-1095-4bbc-bed3-e6cf70fa8d26@huawei.com>
Date: Wed, 5 Aug 2026 16:21:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <almasrymina@google.com>,
	<toke@redhat.com>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 net] net: page_pool: fix UAF in
 __page_pool_release_netmem_dma on xa_cmpxchg race
To: Jakub Kicinski <kuba@kernel.org>
References: <20260731111507.2355601-1-shaojijie@huawei.com>
 <20260804191758.0f2009f7@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260804191758.0f2009f7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/8/5 10:17, Jakub Kicinski wrote:
> On Fri, 31 Jul 2026 19:15:07 +0800 Jijie Shao wrote:
>> page_pool_scrub() iterates pool->dma_mapped via xa_for_each() with no
>> page ref held. __page_pool_release_netmem_dma() currently reads and
>> writes netmem fields (dma_addr, DMA index bits in pp_magic) after
>> xa_cmpxchg() returns. The unref path calls put_page() unconditionally
>> regardless of the cmpxchg outcome; when it loses the cmpxchg, it still
>> frees the page before the scrub winner finishes these netmem accesses,
>> so scrub touches a freed page -- a Use-After-Free.
>>
>> Fix this by splitting the DMA release into two functions:
>>
>> 1. __page_pool_unmap_netmem_dma() caches dma_addr before xa_cmpxchg(),
>>     does the cmpxchg to remove the DMA mapping, and calls dma_unmap on
>>     the cached address. It never touches netmem fields after the cmpxchg,
>>     making it safe for the scrub path which holds no page ref.
>>
>> 2. __page_pool_release_netmem_dma() wraps the above and additionally
>>     clears dma_addr and DMA index bits in netmem fields. This is safe
>>     only when the caller holds a page ref, so it is used by the return
>>     path (page_pool_return_netmem).
>>
>> The scrub path calls __page_pool_unmap_netmem_dma() directly; the return
>> path calls __page_pool_release_netmem_dma().
> Please clearly state what led you to discovering this bug?
> Was it directly hit in production?
> Was there a prod issue which made you investigate?
> Were you able to trigger the race and if so -- how?
>
>> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them when destroying the pool")
>> Suggested-by: Mina Almasry <almasrymina@google.com>
>> Assisted-by: OhMyOpenCode:GLM-5.2
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>> Changes in v4:
>> - Restructure per Mina's review: merge page_pool_remove_dma_mapping()
>>    into __page_pool_unmap_netmem_dma() with dma_unmap inlined via goto
>>    label; simplify __page_pool_release_netmem_dma() to a thin wrapper.
>> - Link to v3: https://lore.kernel.org/r/20260729110249.2824835-1-shaojijie@huawei.com
>>
>> Changes in v3:
>> - Fix unlikely() to likely() for PP_DMA_INDEX_BITS to match
>>    file convention.
>> - Link to v2: https://lore.kernel.org/r/20260727132612.3277927-1-shaojijie@huawei.com
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
>>   net/core/page_pool.c | 46 ++++++++++++++++++++++----------------------
>>   1 file changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 21dc4a9c8714..497bb1906fc3 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -500,29 +500,40 @@ static int page_pool_register_dma_index(struct page_pool *pool,
>>   	return err;
>>   }
>>   
>> -static int page_pool_release_dma_index(struct page_pool *pool,
>> -				       netmem_ref netmem)
>> +static void __page_pool_unmap_netmem_dma(struct page_pool *pool,
>> +					 netmem_ref netmem)
>>   {
>>   	struct page *old, *page = netmem_to_page(netmem);
>>   	unsigned long id;
>> +	dma_addr_t dma;
>> +
>> +	if (!pool->dma_map)
>> +		return;
>> +
>> +	/* Cache dma_addr before xa_cmpxchg. The scrub path holds no page ref;
>> +	 * the unref path calls put_page() regardless of cmpxchg outcome, so
>> +	 * after the cmpxchg we cannot safely touch netmem fields.
>> +	 */
>> +	dma = page_pool_get_dma_addr_netmem(netmem);
>>   
>>   	if (unlikely(!PP_DMA_INDEX_BITS))
>> -		return 0;
>> +		goto unmap;
> nit: just indent the intervening lines please.
> Don't use goto where adding a code block would do.
>

Hi Jakub,

Thanks for the review. v5 incoming addressing both points:

- Added bug discovery context to the commit  message.
- Replaced goto with if (likely(PP_DMA_INDEX_BITS)) block.

Jijie



