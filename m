Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265C6EECB;
	Tue,  1 Sep 2026 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262755; cv=none; b=F8aGKOYRq/6HGV5RAgKLtVA93aJlFT8EDlcXLgGEm6dqf0c3YxWzSkcEH5qhDvgsj8ADaw4cgECMJsevINGoWLw/XM9lTHWVZaVN6DtuEydC9+mv9otJBmZCYD+/RChBLfyYr7UT2NoytCDKTKYKavPO9Cgz0HdGWFCuLktJhYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262755; c=relaxed/simple;
	bh=snWgoOTiHg05wk/9uc4m9iV2V1XK3aAcA58da+a8E4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6Tsg8+IDQls83iHXBrvDdqyz8ArFdVtEODeWkBj2QTws7o45S30+qO8E5bGie12sjngnwm8vKCLQXSKbI8UWDnlqvQLAM+KGGTj4+zgw1mykpOX2hqnvyhdP6BAxtH+d3re0zxwRunQFWtIktNmRzgLYlMZE39acYqGxJzIXtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ic5F4IlO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ic5F4IlO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDD61F000E9;
	Tue,  1 Sep 2026 11:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788262753;
	bh=DgUoPRtJ/GnOdQTDh4HR7dWVyv6xZBoAKQyqX3/YoXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ic5F4IlOodp9XGGhQMY63n539ibLVwUp+J71eqsn8VwLLgx5xjAUonxC35L1omDY3
	 bEwPKN0WkWUrOVM6mkBXqyk5LWeu4rnREdCR1HK5xvBXZh+xPQ1yle2RjpS0z0QWFL
	 QcBumLcPRZa/FD9f/ZNh4w4hZu9Lm9Qhav1ykBU59RpB5qw+9L9XQ2lo19nUWAgNHZ
	 j6ZPkJY1K38H4zXW5LCN0BOju7qy/m4mcgtjtJOAlnS0TWgRQcmzvuH+WNKaDaeg51
	 GV1rqE+ghGt7QYFrKD0JVjPSI88KigEx+8jH3jfFZXfD+XWule6VJsOJe3r9xokVqm
	 Aci4DdmgVi2PQ==
Date: Tue, 1 Sep 2026 14:39:08 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, gakula@marvell.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v5 net] octeontx2-af: switch qmem from coherent DMA alloc
 to streaming DMA mapping
Message-ID: <20260901113908.GK24140@unreal>
References: <20260901015621.2708182-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901015621.2708182-1-rkannoth@marvell.com>

On Tue, Sep 01, 2026 at 07:26:21AM +0530, Ratheesh Kannoth wrote:
> qmem_alloc() uses dma_alloc_attrs() with DMA_ATTR_FORCE_CONTIGUOUS, which
> allocates CPU-cache-coherent DMA memory and, with CMA enabled, draws from
> the CMA pool. qmem backs NIX/NPA queue contexts, admin queues, and LMTST
> regions (including CN10K LMTST areas that span page boundaries), so
> consumption grows with enabled interfaces and is hard to provision in CMA.
> 
> Switch qmem to a streaming-DMA-style path: allocate physically contiguous
> compound pages from the buddy allocator via __get_free_pages(), then map
> them for device access with dma_map_phys() and dma_unmap_phys() using
> DMA_ATTR_REQUIRE_COHERENT. Add otx2_dma_alloc_coherent() and
> otx2_dma_free_coherent() helpers that enforce dev_is_dma_coherent(),
> retry with GFP_DMA32 when the physical range is outside the device DMA
> mask, and wire qmem_alloc()/qmem_free() through them instead of
> dma_alloc_attrs()/dma_free_attrs().
> 
> This works on Octeon because the octeontx2 driver is written for
> DMA-coherent devices: Octeon platforms provide IO coherency (via SMMU), so
> the driver already uses streaming DMA APIs for packet data while
> deliberately skipping explicit CPU cache sync (DMA_ATTR_SKIP_CPU_SYNC).
> The same IO coherency lets qmem use a streaming map of buddy-allocated
> pages instead of a dedicated coherent allocator or CMA reservation. That
> is valid because the platform is DMA-coherent, not because omitting
> dma_sync_* magically makes memory coherent.
> 
> Allocations requiring more than MAX_PAGE_ORDER pages are still rejected,
> since the buddy allocator cannot serve them without CMA.
> 
> cc: Geetha sowjanya <gakula@marvell.com>
> Fixes: 73d33dbc0723 ("octeontx2-af: Use DMA_ATTR_FORCE_CONTIGUOUS attribute in DMA alloc")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---

<...>

> +	paddr = page_to_phys(virt_to_page(vaddr));
> +	dma_addr = dma_map_phys(dev, paddr, size, DMA_BIDIRECTIONAL,
> +				OTX2_DMA_COHERENT_ATTRS);

1. Don't redefine existing DMA attribute, e.g, use DMA_COHERENT_ATTRS
directly.
2. According to the Documentation/core-api/dma-attributes.rst, most likely
you don't need DMA_COHERENT_ATTRS too.
3. There is no need to use dma_map_phys() in your case as you are
supplying struct page backed memory and don't provide DMA_ATTR_MMIO,
use dma_map_page_attrs() instead.
4. Commit message is AI slop.

Thanks
