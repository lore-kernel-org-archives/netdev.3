Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4409463;
	Wed,  5 Aug 2026 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896281; cv=none; b=QeA2RP8ErpZrGT2biu9o0y25lo+KUMnNFfwxeDvfFQ3VozqvPJt/5Hc/8OupslGnxIyCxADxrRSuDXpuuZUWMOSrcADJfa3N2pNCPS1hIPEC6xxyXPgUH44LM/ZIMcWfVWL3z3TdvAny+EO1urK7p5ycxXhW8ZTwLHSqdqVmodg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896281; c=relaxed/simple;
	bh=WfvirnkFtMYeJz0d2XuItJZwCGwWNq8Cn7T/WpFy+kE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7H66ns55ZnA2X5iuKhs8tkWrUlSAKq+ARMWGZ6q6WBNtqxgQUjt4hjrSdzlX2okQSV2y8riMMM58fhKsBhfFllF8QVDZqfv345AE1jqbP0THHgv1FjKoQi4mbqzoJPdkHwpefDoD1QblIQqMDJLTijETghOMvqWYTHRyZGAU3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIB0qSz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIB0qSz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4108A1F000E9;
	Wed,  5 Aug 2026 02:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896280;
	bh=EoNhQWZZubP9kzIP7TZ8V1LYEcxSeF9ASil51tIfOYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZIB0qSz0flDKyNnJBohuQ9hVmy6J+7h0d7eeE+Ff1XJhVbkpkmt304pATxfEDf/EL
	 oDDonwK3YGS5NY7HuoEFl05MKY1BXn0XyYPaX/gWNCG1CnK8NSR8bM8B/fMz2wNugx
	 lnGW4T+wC+d7OvgfwSQ5XVLFLYxuXVw8rr019wZZ54AAqd6+RuDlBRJfrJNOcd93wB
	 lT681TjIZ51o8FWi/eedBtmiOinr8tyzy2bGuHYaptjwO2XmEn5TrH0Srmzaw4BiQf
	 IJTBx0X5X1er5ez+B9afBS8ofo+diuc35z78EQixH2XU86aQBkDAAmu3kPAJ1tM5rA
	 k0asS/5B62BVA==
Date: Tue, 4 Aug 2026 19:17:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <hawk@kernel.org>,
 <ilias.apalodimas@linaro.org>, <almasrymina@google.com>, <toke@redhat.com>,
 <shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 net] net: page_pool: fix UAF in
 __page_pool_release_netmem_dma on xa_cmpxchg race
Message-ID: <20260804191758.0f2009f7@kernel.org>
In-Reply-To: <20260731111507.2355601-1-shaojijie@huawei.com>
References: <20260731111507.2355601-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 19:15:07 +0800 Jijie Shao wrote:
> page_pool_scrub() iterates pool->dma_mapped via xa_for_each() with no
> page ref held. __page_pool_release_netmem_dma() currently reads and
> writes netmem fields (dma_addr, DMA index bits in pp_magic) after
> xa_cmpxchg() returns. The unref path calls put_page() unconditionally
> regardless of the cmpxchg outcome; when it loses the cmpxchg, it still
> frees the page before the scrub winner finishes these netmem accesses,
> so scrub touches a freed page -- a Use-After-Free.
> 
> Fix this by splitting the DMA release into two functions:
> 
> 1. __page_pool_unmap_netmem_dma() caches dma_addr before xa_cmpxchg(),
>    does the cmpxchg to remove the DMA mapping, and calls dma_unmap on
>    the cached address. It never touches netmem fields after the cmpxchg,
>    making it safe for the scrub path which holds no page ref.
> 
> 2. __page_pool_release_netmem_dma() wraps the above and additionally
>    clears dma_addr and DMA index bits in netmem fields. This is safe
>    only when the caller holds a page ref, so it is used by the return
>    path (page_pool_return_netmem).
> 
> The scrub path calls __page_pool_unmap_netmem_dma() directly; the return
> path calls __page_pool_release_netmem_dma().

Please clearly state what led you to discovering this bug?
Was it directly hit in production?
Was there a prod issue which made you investigate?
Were you able to trigger the race and if so -- how?

> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them when destroying the pool")
> Suggested-by: Mina Almasry <almasrymina@google.com>
> Assisted-by: OhMyOpenCode:GLM-5.2
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> Changes in v4:
> - Restructure per Mina's review: merge page_pool_remove_dma_mapping()
>   into __page_pool_unmap_netmem_dma() with dma_unmap inlined via goto
>   label; simplify __page_pool_release_netmem_dma() to a thin wrapper.
> - Link to v3: https://lore.kernel.org/r/20260729110249.2824835-1-shaojijie@huawei.com
> 
> Changes in v3:
> - Fix unlikely() to likely() for PP_DMA_INDEX_BITS to match
>   file convention.
> - Link to v2: https://lore.kernel.org/r/20260727132612.3277927-1-shaojijie@huawei.com
> 
> Changes in v2:
> - Redesign the fix per Mina's review: v1's unconditional
>   netmem_set_dma_index() introduced a UAF when the scrub path
>   (no page ref) writes to a page freed by the unref path.
> - Cache dma_addr before xa_cmpxchg; move dma_addr/DMA index
>   cleanup to page_pool_return_netmem() which holds a page ref.
> - Rename page_pool_release_dma_index() to
>   page_pool_remove_dma_mapping() to reflect its new role as a
>   pure cmpxchg wrapper.
> - Link to v1: https://lore.kernel.org/r/20260724092135.414699-1-shaojijie@huawei.com
> ---
>  net/core/page_pool.c | 46 ++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 21dc4a9c8714..497bb1906fc3 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -500,29 +500,40 @@ static int page_pool_register_dma_index(struct page_pool *pool,
>  	return err;
>  }
>  
> -static int page_pool_release_dma_index(struct page_pool *pool,
> -				       netmem_ref netmem)
> +static void __page_pool_unmap_netmem_dma(struct page_pool *pool,
> +					 netmem_ref netmem)
>  {
>  	struct page *old, *page = netmem_to_page(netmem);
>  	unsigned long id;
> +	dma_addr_t dma;
> +
> +	if (!pool->dma_map)
> +		return;
> +
> +	/* Cache dma_addr before xa_cmpxchg. The scrub path holds no page ref;
> +	 * the unref path calls put_page() regardless of cmpxchg outcome, so
> +	 * after the cmpxchg we cannot safely touch netmem fields.
> +	 */
> +	dma = page_pool_get_dma_addr_netmem(netmem);
>  
>  	if (unlikely(!PP_DMA_INDEX_BITS))
> -		return 0;
> +		goto unmap;

nit: just indent the intervening lines please.
Don't use goto where adding a code block would do.

>  	id = netmem_get_dma_index(netmem);
>  	if (!id)
> -		return -1;
> +		return;
>  
>  	if (in_softirq())
>  		old = xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
>  	else
>  		old = xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0);
>  	if (old != page)
> -		return -1;
> -
> -	netmem_set_dma_index(netmem, 0);
> +		return;
>  
> -	return 0;
> +unmap:
> +	dma_unmap_page_attrs(pool->p.dev, dma,
> +			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> +			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
>  }
-- 
pw-bot: cr
