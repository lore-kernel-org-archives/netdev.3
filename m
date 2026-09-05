Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0873A451B;
	Sat,  5 Sep 2026 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638558; cv=none; b=jTKpWlCPBjA+z3omTnnnLzjopdifal+dhi6P0fTswDvBQ9MKqKYJmHW2YM1FCij4XoVxaIGB/3W2BsrxKs5MQ21fSyR41uQxC7Z4C2lRJiCkUH8hZCNGmh52IB8YAEyqtta14R4Kn5Wdf7zL6gkJW3BCRQ+9MjLVsQOPLMKX3Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638558; c=relaxed/simple;
	bh=srOjzTF81bGvA3JmZCnhghe0OOBAJGDm1Ei8sCwaQyw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YSyd9ZP9MnncIotxbmprJvCaq0oq/Q0/v8at46R7hZ7AFadeYEUSwx0MkBToqwJNt6SCbuvfbXqzB/dqbIAIQD3FSe0GafMCvhUbgpiBN12QoUIIbUCQdhr74btwvFmUo2QCMKmMejnO1bkoIRNOnnhfNrArQ8WSGPL560BETJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqAR5dEO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqAR5dEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B0F1F00A3A;
	Sat,  5 Sep 2026 20:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788638553;
	bh=Anq5W3k6w5GBCn1kH3K4ZibK2Kah8XyXSoL6UmHBtMs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UqAR5dEOtt3WKiLPxovKc39nfeXBq9wkE4Z8/MpwfY6OVP4z+dZJrKF2w4sCQjEYQ
	 Uy+sCGw/azBDEz/5iy9WkTYZznqwp9L0Id9NCMb3yqy4/y7R0xH2hc3h8gXIwjQiGb
	 0mLO+eiaaGZP0HsycA24/x494VwP8QPRs8n0wrtQXQkms/I05QwJmqQawR88vFU4ec
	 Q6oqGz/Vg12B/q/eTQSHv66TlsZtz7FgTfaMKZyWu+VkuzsyxAHTWYcpcZYSBjgvJH
	 kj7gb4EetX81e/96OP1NqN7RxBs48nhIG4JyuE1sbi5mRwKYZorVyW6n8aexb7xihv
	 5X1n16ToibK4w==
Subject: Re: [PATCH v6 net] octeontx2-af: switch qmem from coherent DMA alloc
 to streaming DMA mapping
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: davem@davemloft.net, gakula@marvell.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
 Qqingfang.deng@linux.dev
Date: Sat, 05 Sep 2026 20:02:32 +0000
Message-ID: <178863855246.219967.10510865726694393307@kernel.org>
In-Reply-To: <20260902021023.2987908-1-rkannoth@marvell.com>
References: <20260902021023.2987908-1-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 3 (1) · Low: 1

- [High] New hard MAX_PAGE_ORDER ceiling in otx2_dma_alloc_coherent()
  (drivers/net/ethernet/marvell/octeontx2/af/common.h:76-77) rejects…
- [High] qmem regions are long-lived, bidirectionally shared hardware
  structures (NIX/NPA context tables, AF admin-queue instruction/result…
- [Medium] otx2_dma_phys_in_mask() (af/common.h:52-57) compares a raw CPU
  physical address against dma_get_mask(dev).
- [Medium] otx2_dma_alloc_coherent() maps up to 1<<MAX_PAGE_ORDER bytes'
  worth of pages (4 MiB with 4 KiB pages) in a single…
- [Medium] otx2_dma_alloc_coherent() unconditionally forces __GFP_RECLAIM
  on all allocations, violating caller-provided GFP semantics.
- [Low] The patch adds '#include <linux/dma-map-ops.h>' to
  drivers/net/ethernet/marvell/octeontx2/af/common.h (line 11) solely to…

Pre-existing issues:
- [Medium] qmem_alloc() computes 'qmem->alloc_sz = (qsize * entry_sz) +
  OTX2_ALIGN' in signed int arithmetic (af/common.h:121,135) from values…

--

octeontx2-af: switch qmem from coherent DMA alloc to streaming DMA mapping

This replaces the dma_alloc_attrs(DMA_ATTR_FORCE_CONTIGUOUS) backing of
qmem with buddy-allocated compound pages that are then mapped for the
device with dma_map_page_attrs(DMA_BIDIRECTIONAL).  New helpers
otx2_dma_alloc_coherent() and otx2_dma_free_coherent() gate on
dev_is_dma_coherent() and retry with GFP_DMA32 when the physical range
falls outside the device DMA mask.  A few questions below.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> index 779413a383b74..4ec20c3cfec03 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> @@ -7,6 +7,11 @@
>  #ifndef COMMON_H
>  #define COMMON_H
>  
> +#include <linux/dma-mapping.h>
> +#include <linux/dma-map-ops.h>

[Severity: Low]
This isn't a bug, but is including linux/dma-map-ops.h from a driver
header intended?  That header opens with:

  /*
   * This header is for implementations of dma_map_ops and related code.
   * It should not be included in drivers just using the DMA API.
   */

common.h is included across af/ and nic/, so this pulls DMA
implementation internals into the whole driver, apparently only to reach
dev_is_dma_coherent().

Related to that, on builds without ARCH_HAS_SYNC_DMA_FOR_DEVICE and
ARCH_HAS_SYNC_DMA_FOR_CPU, the same header defines:

  static inline bool dev_is_dma_coherent(struct device *dev)
  {
	return true;
  }

so the guard below is a compile-time constant rather than a runtime
check on those configurations.  Is that the intent?

> +#include <linux/gfp.h>
> +#include <linux/mm.h>
> +
>  #include "rvu_struct.h"
>  
>  #define OTX2_ALIGN			128  /* Align to cacheline */
> @@ -44,6 +49,74 @@ struct qmem {
>  	u32		qsize;
>  };
>  
> +static inline bool otx2_dma_phys_in_mask(struct device *dev, phys_addr_t paddr,
> +					 size_t size)
> +{
> +	u64 mask = dma_get_mask(dev);
> +
> +	return paddr + size - 1 <= mask;
> +}

[Severity: Medium]
Is comparing a CPU physical address against dma_get_mask() the test that
was wanted here?  The DMA mask constrains device (bus or IOVA)
addresses, so the equivalent core-API check goes through phys_to_dma()
and dma_capable(), which also account for dev->dma_range_map offsets and
dev->bus_dma_limit.

Two consequences follow:

- Behind an SMMU (the configuration the changelog relies on) the IOVA is
  allocated inside the mask no matter where the page sits physically, so
  freeing the pages and retrying with GFP_DMA32 is a constraint the
  hardware does not have, and it can end in NULL when no high-order
  ZONE_DMA32 block is available.

- With a non-zero dma-ranges offset or a bus_dma_limit below the mask, an
  address that passes this check is still not addressable, and the real
  verdict (bounce or DMA_MAPPING_ERROR) only comes later from
  dma_map_page_attrs().

Also, every octeontx2 device sets DMA_BIT_MASK(48) (rvu_probe(), cgx
probe, otx2_pf/otx2_vf/rep probe), so on shipping hardware the check
always passes and the GFP_DMA32 retry body is unreachable.  Could the
retry simply be dropped and the decision left to dma_map_page_attrs()?

> +
> +static inline void *otx2_dma_alloc_coherent(struct device *dev, size_t size,
> +					    dma_addr_t *dma_handle, gfp_t gfp)
> +{
> +	dma_addr_t dma_addr;
> +	unsigned int order;
> +	gfp_t alloc_gfp;
> +	void *vaddr;
> +
> +	if (!dev || !dma_handle || !size)
> +		return NULL;
> +
> +	if (!dev_is_dma_coherent(dev))
> +		return NULL;
> +
> +	size = PAGE_ALIGN(size);
> +	order = get_order(size);
> +	if (order > MAX_PAGE_ORDER)
> +		return NULL;

[Severity: High]
Does this cap reject qmem allocations that the previous
dma_alloc_attrs(DMA_ATTR_FORCE_CONTIGUOUS) path served from CMA?  With
4 KiB pages and the arm64 default ARCH_FORCE_MAX_ORDER, the ceiling is
4 MiB, while dma_alloc_contiguous() had no such limit:

  kernel/dma/contiguous.c:dma_alloc_contiguous() {
	if (dev->cma_area)
		return cma_alloc_aligned(dev->cma_area, size, gfp);
	...
	return cma_alloc_aligned(dma_contiguous_default_area, size, gfp);
  }

Call sites that appear to cross 4 MiB:

  af/cn20k/mbox_init.c:rvu_alloc_mbox_memory()
	err = qmem_alloc(rvu->dev, &mbox_addr, ndevs, mbox_size);

  reached from cn20k_rvu_mbox_init(TYPE_AFPF, rvu->hw->total_pfs) with
  mbox_size = MBOX_SIZE = SZ_64K, so total_pfs >= 64 gives order 11 and
  AF probe fails.  The CN20K mailbox IRQ code already handles PF indices
  up to 96.

  nic/otx2_pf.c:cn20k_pfvf_mbox_alloc()
	err = qmem_alloc(&pf->pdev->dev, &mbox_addr, numvfs, MBOX_SIZE);

  fails once numvfs >= 64, i.e. on enabling SR-IOV.

  nic/otx2_common.c:otx2_sq_init()
	err = qmem_alloc(pfvf->dev, &sq->tso_hdrs, qset->sqe_cnt,
			 TSO_HEADER_SIZE);

  nic/otx2_common.c:otx2_cq_init()
	err = qmem_alloc(pfvf->dev, &cq->cqe, cq->cqe_cnt, cq->cqe_size);

  and otx2_set_ringparam() still accepts up to a million entries:

	tx_count = clamp_t(u32, ring->tx_pending,
			   Q_COUNT(Q_SIZE_4K), Q_COUNT(Q_SIZE_MAX));

  so the TSO header area (sqe_cnt * 128), the SQE ring and the CQE ring
  (cqe_cnt * 128 or 512) pass 4 MiB somewhere around 16384 to 32768
  entries and now return -ENOMEM at interface bring-up.

Should these call sites be audited or capped before the allocator gains
a hard limit?

On the same subject, the changelog says:

  Allocations requiring more than MAX_PAGE_ORDER pages are still
  rejected, since the buddy allocator cannot serve them without CMA.

For CMA-enabled configurations that is a new restriction rather than
existing behaviour, and MAX_PAGE_ORDER is an order, not a page count.
Could that paragraph be reworded to describe the change?

> +
> +	alloc_gfp = (gfp & ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM)) |
> +		__GFP_ZERO | __GFP_COMP | __GFP_RECLAIM;
> +
> +	vaddr = (void *)__get_free_pages(alloc_gfp, order);
> +	while (vaddr &&
> +	       !otx2_dma_phys_in_mask(dev, virt_to_phys(vaddr), size)) {
> +		free_pages((unsigned long)vaddr, order);
> +		if (alloc_gfp & GFP_DMA32)
> +			return NULL;
> +		alloc_gfp |= GFP_DMA32;
> +		vaddr = (void *)__get_free_pages(alloc_gfp, order);
> +	}
> +	if (!vaddr)
> +		return NULL;
> +
> +	dma_addr = dma_map_page_attrs(dev, virt_to_page(vaddr), 0, size,
> +				      DMA_BIDIRECTIONAL, 0);

[Severity: Medium]
The helper accepts a gfp argument but then ORs in __GFP_RECLAIM
unconditionally, so whatever the caller asked for, the allocation ends
up able to block.  __GFP_RECLAIM is
__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM, so a caller passing
GFP_ATOMIC or GFP_NOWAIT to otx2_dma_alloc_coherent() has
__GFP_DIRECT_RECLAIM added behind its back and __get_free_pages() may
sleep.  From an atomic or spinlock-held context that is a
scheduling-while-atomic BUG rather than the allocation failure the
caller was prepared for.

Note this is different in kind from the __GFP_ZERO and __GFP_COMP bits
added in the same expression: those describe how the pages are
formatted, while __GFP_RECLAIM changes whether the call can sleep,
which is the caller's decision and not the allocator wrapper's.
Stripping __GFP_DMA, __GFP_DMA32 and __GFP_HIGHMEM is likewise fine,
since the helper manages the zone itself.

There is no bug in this tree today, because the only caller is
qmem_alloc() and it passes GFP_KERNEL, which already contains
__GFP_RECLAIM.  But the helper is written as a general
dma_alloc_coherent() replacement, is placed in a header shared by af/
and nic/, and its name invites reuse, so the override is a trap for the
next caller.

Could the OR of __GFP_RECLAIM simply be dropped and the caller's flags
honoured, or, if the helper is only ever meant to serve the sleeping
qmem_alloc() path, would it be clearer to drop the gfp parameter
altogether and hardcode GFP_KERNEL inside the helper?

[Severity: High]
Can this mapping end up on a SWIOTLB bounce buffer, so that the device
and the CPU stop looking at the same memory?

qmem regions are long-lived structures that hardware and the driver
touch concurrently for the lifetime of the mapping: NIX/NPA contexts, AF
admin queue instruction and result rings, CQE rings, the NPA fc_addr
writeback area, CN10K LMT lines, and the mailbox regions.  The mailbox
case is documented in the driver itself:

  af/cn20k/mbox_init.c:rvu_alloc_mbox_memory() {
	/* Allocate contiguous memory for mailbox communication.
	 * ...
	 * AF will access mbox memory using direct physical addresses
	 * and PFs will access the same shared memory from BAR2.
  }

With attrs = 0, dma_map_page_attrs() is allowed to substitute a bounce
buffer:

  kernel/dma/direct.c:dma_direct_map_phys() {
	if (is_swiotlb_force_bounce(dev)) {
		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
			return DMA_MAPPING_ERROR;

		return swiotlb_map(dev, phys, size, dir, attrs);
	}
  }

  drivers/iommu/dma-iommu.c:dev_use_swiotlb() {
	return IS_ENABLED(CONFIG_SWIOTLB) &&
		(dev_is_untrusted(dev) ||
		 dma_kmalloc_needs_bounce(dev, size, dir));
  }

so swiotlb=force, restricted-DMA pools, confidential-computing guests,
or a device marked untrusted behind the SMMU all bounce.  Regions at or
below swiotlb_max_mapping_size() (fc_addr, AQ rings, qints contexts,
small mailbox regions) would bounce successfully and silently.  In that
case the AF programs NIX_AF_LFX_*_BASE, NPA_AF_LFX_LOC_AURAS_BASE or
RVU_MBOX_AF_PFX_ADDR with the bounce address while the driver keeps
using qmem->base, and there are no dma_sync_*() calls anywhere to
reconcile the two.

The unmap in otx2_dma_free_coherent() then copies the device-side buffer
back over the page the CPU has been writing:

	dma_unmap_page_attrs(dev, dma_handle, size, DMA_BIDIRECTIONAL, 0);
	free_pages((unsigned long)vaddr, order);

dev_is_dma_coherent() only reports cache coherency; it does not promise
that the mapping aliases the same physical memory, and the physical-range
check above cannot rule bouncing out either since force-bounce ignores
the address.  Would DMA_ATTR_REQUIRE_COHERENT be the attribute wanted
here, given its documented contract:

  /*
   * DMA_ATTR_REQUIRE_COHERENT: Indicates that DMA coherency is required.
   * All mappings that carry this attribute can't work with SWIOTLB and cache
   * flushing.
   */
  #define DMA_ATTR_REQUIRE_COHERENT	(1UL << 12)

[Severity: Medium]
Separately, should the size passed here be clamped by
dma_max_mapping_size(dev)?  Documentation/core-api/dma-api.rst says of
that helper:

  Returns the maximum size of a mapping for the device. The size parameter
  of the mapping functions like dma_map_single(), dma_map_page() and
  others should not be larger than the returned value.

The only bound applied is the buddy order, so up to 4 MiB can be handed
to a single dma_map_page_attrs() call, while

  kernel/dma/direct.c:dma_direct_max_mapping_size() {
	if (is_swiotlb_active(dev) &&
	    (dma_addressing_limited(dev) || is_swiotlb_force_bounce(dev) ||
	     force_dma_unencrypted(dev)))
		return swiotlb_max_mapping_size(dev);
  }

can be roughly 256 KiB.  The failure then surfaces as a generic
-ENOMEM from qmem_alloc() with no hint about the size limit.  The old
dma_alloc_attrs() path had no per-mapping size limit.

> +	if (dma_mapping_error(dev, dma_addr)) {
> +		free_pages((unsigned long)vaddr, order);
> +		return NULL;
> +	}
> +
> +	*dma_handle = dma_addr;
> +	return vaddr;
> +}
> +

[ ... ]

>  static inline int qmem_alloc(struct device *dev, struct qmem **q,
>  			     int qsize, int entry_sz)
>  {
> @@ -60,8 +133,8 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
>  
>  	qmem->entry_sz = entry_sz;
>  	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
> -	qmem->base = dma_alloc_attrs(dev, qmem->alloc_sz, &qmem->iova,
> -				     GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
> +	qmem->base = otx2_dma_alloc_coherent(dev, qmem->alloc_sz, &qmem->iova,
> +					     GFP_KERNEL);
>  	if (!qmem->base)
>  		return -ENOMEM;

[Severity: Medium]
This isn't a bug introduced by this patch, but since the size
computation is now the only thing bounding the new allocator, can
alloc_sz wrap here?  The product is signed int arithmetic over values
that come straight from mailbox requests:

  af/rvu_npa.c:rvu_mbox_handler_npa_lf_alloc()
	err = qmem_alloc(rvu->dev, &pfvf->pool_ctx, req->nr_pools, hwctx_size);

req->nr_pools is u32 and only checked for being non-zero, so
nr_pools = 2^25 with a 128-byte pool context wraps the product to zero
and leaves alloc_sz = 128.  A single page is then allocated while
pool_ctx->qsize keeps the huge requested count used by later bounds
checks and hardware programming.

For the NIX RQ/SQ/CQ paths the same wrap is blocked before any register
write, because the count-proportional allocation fails first:

  af/rvu_nix.c:rvu_mbox_handler_nix_lf_alloc() {
	pfvf->rq_bmap = kcalloc(req->rq_cnt, sizeof(long), GFP_KERNEL);
	if (!pfvf->rq_bmap) {
		rc = -ENOMEM;
		goto free_mem;
	}

	rvu_write64(rvu, blkaddr, NIX_AF_LFX_RQS_BASE(nixlf),
		    (u64)pfvf->rq_ctx->iova);
  }

The NPA pool_ctx path has no such companion allocation, and device
accesses past the mapping land on untranslated IOVA that the SMMU
faults, so this is an inconsistent qmem object rather than memory
corruption.  Would it make sense to add a size sanity check on
qsize * entry_sz while this code is being touched?

> @@ -80,10 +153,9 @@ static inline void qmem_free(struct device *dev, struct qmem *qmem)
>  		return;
>  
>  	if (qmem->base)
> -		dma_free_attrs(dev, qmem->alloc_sz,
> -			       qmem->base - qmem->align,
> -			       qmem->iova - qmem->align,
> -			       DMA_ATTR_FORCE_CONTIGUOUS);
> +		otx2_dma_free_coherent(dev, qmem->alloc_sz,
> +				       qmem->base - qmem->align,
> +				       qmem->iova - qmem->align);
>  	devm_kfree(dev, qmem);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902021023.2987908-1-rkannoth%40marvell.com
