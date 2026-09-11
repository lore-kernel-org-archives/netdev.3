Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A17282F1B;
	Fri, 11 Sep 2026 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119370; cv=none; b=bUhqTlAeTNBdGbi24wb/x0nUd15ubrlz2GbRF5J5we+r/29mtomG2T4LqVGCllpsPQL0VGxlviJrMZW5uftrRgh7BP+SVNTYOH0TrQrNU4Bw5cffdJdWNORlMrR11nod8EeFfwUxwKvYlLjGa0kf4XxGBblnMdLukyS+6I+TrIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119370; c=relaxed/simple;
	bh=B9v8d7iETnFFe/NuHO6wTQUtOOro82ObwYm/yJ6LQ3g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GozfB8Zq1YZvJIjgcunMW78UKaH+uON3JTHQ743OSjt/8NdAKjryi1zbb9QkKHP2cEvWUypKpxanL8TDe/yf/Z7n6N7P5gi4WNRW8w0+1VrA2qHf6u9gZfaBdH2LCTNBNUAcOkPGQpDT5yQeHat17OepsDPbZTo/DoPCaebOGvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhsUJJ4N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhsUJJ4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365BC1F000FF;
	Fri, 11 Sep 2026 09:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789119368;
	bh=O4x6t1/WtG8DeGWc5q0VOQD/GtT4W1lzrL2RmKnX8BE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GhsUJJ4NTgvL9XZC3Jo54kpt93UZoKiyLIv5ZHWm/KNWNRRNUIePM7TM5woI84+3/
	 F7ppLvlf59iP9KYerpd9ZIIDMiS8aCLzjzNrU15xRDueaGBkIckKOdbySo/PQJU5br
	 UK2u5p7wSiuYZzH1W47PGJNYFpNSkJPlIyPfO9lgbkojsK+XhzNQy/EAOj8x/PjFjc
	 4orTUMWdxAwP6f0gN5U0P0KQogDuXuc7FEs6su4XnM3j24PGlsJiXiDW34wGzqkXmY
	 t3jcxmZ0sViD6CEN8CblEi+vau0OtD/0O+qMzayzVp5uS+1YaTB7ijs3ad2Tc+PTJ0
	 mghuENKwU2VQg==
Subject: Re: [PATCH v8 net-next] octeontx2-af: switch qmem from coherent DMA
 alloc to streaming DMA mapping
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: davem@davemloft.net, gakula@marvell.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org
Date: Fri, 11 Sep 2026 09:36:07 +0000
Message-ID: <178911936770.219967.4327734860588306431@kernel.org>
In-Reply-To: <20260908063411.257228-1-rkannoth@marvell.com>
References: <20260908063411.257228-1-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 3 (1) · Medium: 0 · Low: 0

- [High] otx2_dma_alloc_coherent()
  (drivers/net/ethernet/marvell/octeontx2/af/common.h:51-69) creates a…
- [High] dma_map_single() is not guaranteed to return an address that
  aliases the caller's buffer, and the new helper accepts any successful…
- [High] The newly added check in qmem_alloc() (af/common.h:95) 'if
  (get_order(PAGE_ALIGN(qmem->alloc_sz)) > MAX_PAGE_ORDER) return…

Pre-existing issues:
- [High] qmem_alloc() computes 'qmem->alloc_sz = (qsize * entry_sz) +
  OTX2_ALIGN' (af/common.h:93) in int from mailbox-supplied, unbounded…

--

octeontx2-af: switch qmem from coherent DMA alloc to streaming DMA mapping

This replaces the dma_alloc_attrs(DMA_ATTR_FORCE_CONTIGUOUS) backing of
qmem with kmalloc() plus dma_map_single(), wrapped in new
otx2_dma_alloc_coherent()/otx2_dma_free_coherent() helpers. qmem_alloc()
and qmem_free() are wired through the new helpers, and a
get_order()/MAX_PAGE_ORDER size check is added to qmem_alloc().

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> index 779413a383b74..0569b6d9f03b5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h

[ ... ]

> +static inline void *otx2_dma_alloc_coherent(struct device *dev, size_t size,
> +					    dma_addr_t *dma_handle)
> +{
> +	dma_addr_t dma_addr;
> +	void *vaddr;
> +
> +	vaddr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
> +	if (!vaddr)
> +		return NULL;
> +
> +	dma_addr = dma_map_single(dev, vaddr, size, DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(dev, dma_addr)) {
> +		kfree(vaddr);
> +		return NULL;
> +	}

[Severity: High]
The v8 changelog says "Retain dev_is_dma_coherent() guard in
otx2_dma_alloc_coherent()", but is that guard actually present here?  A
grep of drivers/net/ethernet/marvell/octeontx2/ for
dev_is_dma_coherent|dma_sync_single|dma_max_mapping_size returns nothing at
this commit, so the coherency premise of the changelog does not appear to
be expressed anywhere in the code.

Does this matter for the qmem consumers?  They use the buffer in the
dma_alloc_coherent() model, not the streaming model.  For example
nix_aq_enqueue_wait() in af/rvu_nix.c:

	memcpy((void *)(aq->inst->base + (head * aq->inst->entry_sz)),
	       (void *)inst, aq->inst->entry_sz);
	memset(result, 0, sizeof(*result));
	/* sync into memory */
	wmb();
	/* Ring the doorbell and wait for result */
	rvu_write64(rvu, block->addr, NIX_AF_AQ_DOOR, 1);
	while (result->compcode == NIX_AQ_COMP_NOTDONE) {

The CPU writes the instruction, the device DMA-writes result->compcode, and
the only barrier is wmb() with no dma_sync_single_for_device()/for_cpu()
ownership transfer.  npa_aq_enqueue_wait() and the NIX CQ rings do the
same.

On a device that is not IO-coherent, can the CPU-written contexts stay in
dirty cache lines while the device fetches stale data, and can the
device-written result words never be invalidated so the poll loop spins on
a stale compcode until it times out?

The kernel already has DMA_ATTR_REQUIRE_COHERENT for exactly this, in
include/linux/dma-mapping.h:

	/*
	 * DMA_ATTR_REQUIRE_COHERENT: Indicates that DMA coherency is required.
	 * All mappings that carry this attribute can't work with SWIOTLB and cache
	 * flushing.
	 */

The v8 changelog states this attribute was dropped.  Would using it (or an
explicit dev_is_dma_coherent() bail-out) make the requirement enforced
rather than assumed?

[Severity: High]
Separately, this helper accepts any non-error dma_addr and returns the
kmalloc pointer to the caller.  Is dma_map_single() guaranteed to return an
address that aliases that buffer?

In dma_direct_map_phys() (kernel/dma/direct.c):

	if (is_swiotlb_force_bounce(dev)) {
		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
			return DMA_MAPPING_ERROR;
		return swiotlb_map(dev, phys, size, dir, attrs);
	}

and later the dma_capable()/dma_kmalloc_needs_bounce() path also falls back
to swiotlb_map() when DMA_ATTR_REQUIRE_COHERENT is absent.
dma_kmalloc_needs_bounce() in include/linux/dma-map-ops.h is:

	return !dma_kmalloc_safe(dev, dir) && !dma_kmalloc_size_aligned(size);

which is true for a non-coherent device with DMA_BIDIRECTIONAL when the
kmalloc size is neither >= 2*ARCH_DMA_MINALIGN nor cache-line rounded --
for instance qmem_alloc(dev, &sq->sqe, 1, 64) in nic/otx2_common.c gives
alloc_sz = 192.

If the mapping is bounced, the IOVA programmed into NIX_AF_LFX_*_BASE,
NPA_AF_LFX_*_BASE, RVU_PF_VF_MBOX_ADDR and the LMT map table refers to a
bounce slot that receives one all-zero copy, while the driver keeps reading
and writing the original kmalloc buffer with no dma_sync_* to reconcile
them.  Can this leave the device armed with memory the driver never
updates?  dma_alloc_attrs()/dma_alloc_coherent() did not have this
property.

Also, under SWIOTLB the largest streaming mapping is
IO_TLB_SEGSIZE * IO_TLB_SIZE (256 KiB).  Do the multi-hundred-KiB qmem
regions (the CN10K LMT region sized num_online_cpus() * 32 * 128, CQ rings,
aura/pool context tables) simply fail to map and abort queue init in that
configuration?

> +
> +	*dma_handle = dma_addr;
> +	return vaddr;
> +}

[ ... ]

> @@ -60,8 +91,11 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
>  
>  	qmem->entry_sz = entry_sz;
>  	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
> -	qmem->base = dma_alloc_attrs(dev, qmem->alloc_sz, &qmem->iova,
> -				     GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
> +
> +	if (get_order(PAGE_ALIGN(qmem->alloc_sz)) > MAX_PAGE_ORDER)
> +		return -ENOMEM;

[Severity: High]
Does this new check, combined with the switch to kmalloc(), introduce a
hard size ceiling that the old CMA-backed path did not have?

KMALLOC_MAX_SIZE in include/linux/slab.h is:

	#define KMALLOC_SHIFT_MAX	(MAX_PAGE_ORDER + PAGE_SHIFT)
	/* Maximum allocatable size */
	#define KMALLOC_MAX_SIZE	(1UL << KMALLOC_SHIFT_MAX)

i.e. 4 MiB on a 4 KiB-page kernel.  Some existing callers ask for more.
cn20k_pfvf_mbox_alloc() in nic/otx2_pf.c does:

	err = qmem_alloc(&pf->pdev->dev, &mbox_addr, numvfs, MBOX_SIZE);

with MBOX_SIZE == SZ_64K, so at numvfs == 64 alloc_sz is 4 MiB + 128,
PAGE_ALIGN gives 0x401000 and get_order() returns 11 > MAX_PAGE_ORDER (10).
qmem_alloc() then returns -ENOMEM before attempting any allocation and
otx2_pfvf_mbox_init()/otx2_sriov_enable() fail, even though the same driver
handles numvfs > 64 elsewhere.  Does 'echo 64 > .../sriov_numvfs' still
work on CN20K after this change?

rvu_alloc_mbox_memory() in af/cn20k/mbox_init.c requests ndevs * MBOX_SIZE
scaling with the hardware PF/VF count, and rvu_mbox_handler_npa_lf_alloc()
in af/rvu_npa.c requests NPA_AURA_COUNT(aura_sz) * hwctx_size, which for
the mailbox-legal aura_sz == NPA_AURA_SZ_1M is 1M * 128 = 128 MiB.  Do
those now fail too?

Two smaller points on the same branch: get_order(PAGE_ALIGN(x)) equals
get_order(x), so the PAGE_ALIGN() adds nothing, and the branch returns
-ENOMEM with no dev_err() where the previous path produced a visible
allocation warning.  Could the new size ceiling and the changed failure
characteristics (plain GFP_KERNEL order-9/10 buddy allocations, no
__GFP_NOWARN or __GFP_RETRY_MAYFAIL) be mentioned in the changelog, given
the Fixes: tag makes this a stable-backport candidate?

[Severity: High]
This isn't a bug introduced by this patch, but the value being validated
here has already wrapped.  qmem->alloc_sz is an int and the multiplication
'qsize * entry_sz' is done in int on mailbox-supplied counts, so the new
get_order() check bounds the wrapped size rather than the requested one.

rvu_mbox_handler_npa_lf_alloc() in af/rvu_npa.c rejects only !req->nr_pools
(a u32 mailbox field) before calling:

	err = qmem_alloc(rvu->dev, &pfvf->pool_ctx, req->nr_pools, hwctx_size);

With nr_pools = 0x2000000 and hwctx_size = 128 the product is 2^32, which
wraps to 0, so alloc_sz = 128, get_order(PAGE_ALIGN(128)) = 0 passes the
new check and kmalloc(128) succeeds -- while pool_ctx->qsize keeps the full
33554432.  rvu_npa_aq_enq_inst() then only checks against that qsize:

	if (req->aura.pool_addr >= pfvf->pool_ctx->qsize) {
		rc = NPA_AF_ERR_AQ_FULL;
		break;
	}
	/* Set pool's context address */
	req->aura.pool_addr = pfvf->pool_ctx->iova +
	(req->aura.pool_addr * pfvf->pool_ctx->entry_sz);

so the device is handed an IOVA up to 4 GiB past a 128-byte mapping.  The
NIX path has the same shape with the u32 req->rq_cnt/sq_cnt/cq_cnt fields
in rvu_mbox_handler_nix_lf_alloc(), whose values are also programmed into
NIX_AF_LFX_*_BASE.

Since this patch adds a size-validation step at exactly this point, would
it make sense to do the arithmetic in size_t with size_mul()-style
overflow-checked helpers before validating, so the check bounds the real
request?

> +
> +	qmem->base = otx2_dma_alloc_coherent(dev, qmem->alloc_sz, &qmem->iova);
>  	if (!qmem->base)
>  		return -ENOMEM;
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908063411.257228-1-rkannoth%40marvell.com
