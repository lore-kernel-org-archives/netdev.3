Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65498EADC;
	Sun, 20 Sep 2026 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789864407; cv=none; b=bFiUdk70bBtkiULC77EB56UuBQt2GlPweeYAg4VHF4wT2tuhBokfkcT6eOqbtia6Lv093OfZgkViyFwDH6RoWCp5KOD4oq4R7P/BJC1EamfPQBp0XmNPMKm1qQZTF5z4dvjdGJ2tRlWIgTqnDXYbmWdEo7uAcu+xolrKefD9GAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789864407; c=relaxed/simple;
	bh=w8GOMg6sq03tZE/gklbTIwAU81YfJQyzLOY/aaS9ZrY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dEjK7QfyQQExt1kd2AVLnG5niPE6O5dvawy78fachkqk5CvYYb0dITwSny8wmuxDWdzj3CUNu5rGtcrrphASNMPUjacfKjr3QytKZxw+QwpHhBKvsKZY682sS17XKfLmYkDf5gEBai+zxqFiQN5gcsHxBeaS8sRBOlFeHwdEL5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtufbqiL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtufbqiL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515CE1F000FF;
	Sun, 20 Sep 2026 00:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789864405;
	bh=GAj1GofghfBeAuRnU7cCQcJ12AFUHLqfyzqJAyGdsBI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VtufbqiLEpsquE+KKFdSK8MoXfLJvZmHdUK7QLZOjYnVjfQ3SWc43qXRrvF6do9q4
	 rbl5NwgpF7H4F3dVwC8uMPYRayPicwIHcDJieEcHJBECX+v4efSvjdryq+9gpeX9cX
	 6oxFvib0txlV8gvTWEd9vn0A2j3Ttym3GsdilsoyBfu8c7AYWg3B7WKcXYIgyWD9Ph
	 TsybKyjU4K9TGMVhH/IN410XgBk3Z8eWbegxxnBu+obZqKRIZ8UIV9CGpnC/HxLso0
	 UCfOxGRoh3OhvBhZghcKUYd9W1fKrgsfkd3lGkqGsvS3EdfBJNEABOP3vzfhlf8UpV
	 YAFilGKOjVkzQ==
Subject:
 Re: [PATCH net] octeontx2-af: Fix memory scaling limitation in SR-IOV mode
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: davem@davemloft.net, gakula@marvell.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org
Date: Sun, 20 Sep 2026 00:33:24 +0000
Message-ID: <178986440480.2160803.16078325840590029895@kernel.org>
In-Reply-To: <20260916022111.1083017-1-rkannoth@marvell.com>
References: <20260916022111.1083017-1-rkannoth@marvell.com>
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
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 1 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] New hard allocation ceiling in qmem_alloc() rejects the very SR-
  IOV/mailbox allocations the commit claims to fix.
- [High] Long-lived CPU/device-shared hardware rings and contexts are
  converted from coherent DMA memory to an unsynchronized streaming…
- [Medium] net: octeontx2: fragile high-order buddy allocations replace
  CMA

Pre-existing issues:
- [High] Untrusted mailbox queue counts overflow the signed size
  computation in qmem_alloc() and bypass the newly added order check,…
- [Medium] `struct qmem.base` is produced by qmem_alloc() as a CPU
  virtual address (previously dma_alloc_attrs(), now kzalloc()), but the…
- [Low] qmem_alloc() publishes the devm-allocated descriptor into *q
  (af/common.h:87-90) before both failure returns: the newly added `if…

--

octeontx2-af: Fix memory scaling limitation in SR-IOV mode

This replaces the dma_alloc_attrs(DMA_ATTR_FORCE_CONTIGUOUS) backing of
struct qmem with a kzalloc() plus dma_map_single() pair wrapped in two new
helpers in af/common.h. qmem_alloc() also gains a MAX_PAGE_ORDER size
check before the allocation.

A few questions on the new helpers and the size check below.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> index 779413a383b74..78e42549d9908 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h

[ ... ]

> @@ -44,6 +48,33 @@ struct qmem {
>  	u32		qsize;
>  };
>  
> +static inline void *otx2_dma_alloc_coherent(struct device *dev, size_t size,
> +					    dma_addr_t *dma_handle)
> +{
> +	dma_addr_t dma_addr;
> +	void *vaddr;
> +
> +	vaddr = kzalloc(size, GFP_KERNEL);
> +	if (!vaddr)
> +		return NULL;
> +
> +	dma_addr = dma_map_single(dev, vaddr, size, DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(dev, dma_addr)) {
> +		kfree(vaddr);
> +		return NULL;
> +	}
> +
> +	*dma_handle = dma_addr;
> +	return vaddr;
> +}

[Severity: Medium]
The stated goal is to stop exhausting the CMA pool when many VFs are
enabled, but kzalloc() still demands physically contiguous memory --
it just takes it from the buddy allocator instead of CMA. For anything
above PAGE_SIZE that is an order-N compound allocation, and the qmem
callers are not small: cn20k_pfvf_mbox_alloc() in nic/otx2_pf.c asks
for numvfs * MBOX_SIZE, rvu_alloc_mbox_memory() in af/cn20k/mbox_init.c
asks for ndevs * MBOX_SIZE, and the NPA/NIX context tables
(pfvf->pool_ctx, aura_ctx, rq_ctx, sq_ctx, cq_ctx) scale with the
mailbox-supplied counts. Those land at order 5 through order 10, which
is exactly the range that fails first on a fragmented long-running
system -- and CMA, being a reserved contiguous region, was better at
servicing them than the buddy allocator is. So does this trade a CMA
exhaustion failure for a fragmentation failure at a similar or lower
size, rather than removing the limit?

The failure is also noisier than the old path: there is no
__GFP_NOWARN here, so an order-10 kzalloc() failure during
otx2_sriov_enable() produces a page allocation failure warning with a
full dump_stack() and a meminfo dump, not just the -ENOMEM that
qmem_alloc() returns.

What is not clear from the commit message is why physical contiguity is
wanted at all. The justification given is that Octeon provides I/O
coherency via the SMMU -- but if an SMMU is translating, the device
only needs a contiguous IOVA range, and dma_alloc_attrs() with attrs 0
(or dma_alloc_noncontiguous()) would let iommu_dma_alloc() assemble the
buffer from order-0 pages and hand the hardware one contiguous IOVA.
That drops both the CMA dependency and the high-order dependency.

Was plain dma_alloc_attrs() without DMA_ATTR_FORCE_CONTIGUOUS tried,
and is there something in how qmem->iova is programmed into the
hardware (NPA_AF_AQ_BASE, the AURA/POOL context addresses in
rvu_npa_aq_enq_inst(), RVU_AF_PFX_BAR4_ADDR for the mailboxes) that
requires a physically contiguous buffer and not merely a contiguous
IOVA? If not, could the changelog explain why the streaming kzalloc()
form was preferred over letting the DMA layer do the stitching?

[Severity: High]

The helper is named otx2_dma_alloc_coherent(), but it hands out a
streaming DMA_BIDIRECTIONAL mapping that stays owned by the device for
the entire lifetime of the buffer, while the CPU keeps reading and
writing the same memory through vaddr. Is that safe without any
ownership transfer?

There is no dma_sync_single_for_cpu()/dma_sync_single_for_device()
anywhere in the driver:

  git grep dma_sync_single drivers/net/ethernet/marvell/octeontx2/
  (no matches)

Several qmem users touch the buffer concurrently with the hardware. In
npa_aq_enqueue_wait() (af/rvu_npa.c) the CPU writes the instruction ring
and then polls a field the NPA writes by DMA, with only a wmb():

	memcpy((void *)(aq->inst->base + (head * aq->inst->entry_sz)),
	       (void *)inst, aq->inst->entry_sz);
	memset(result, 0, sizeof(*result));
	/* sync into memory */
	wmb();

	/* Ring the doorbell and wait for result */
	rvu_write64(rvu, block->addr, NPA_AF_AQ_DOOR, 1);
	while (result->compcode == NPA_AQ_COMP_NOTDONE) {

nix_aq_enqueue_wait() (af/rvu_nix.c) does the same for NIX. On the data
path, otx2_sq_init() stores the NPA free-count word from qmem memory:

	sq->aura_fc_addr = pool->fc_addr->base;

and the transmit path dereferences *sq->aura_fc_addr on every packet, a
value the NPA updates by DMA. cn10k_lmtst_init() keeps
hw.lmt_base = dync_lmt->base as the CPU view while the AF programs
lmt_iova into the LMT map table, so the two views must alias the same
physical memory.

The commit message says the change "is equivalent on Octeon platforms,
which provide full I/O coherency via the SMMU". Does I/O coherency cover
the cases where dma_map_single() does not return an identity-shaped
mapping? dma_direct_map_phys() bounces when is_swiotlb_force_bounce()
is true (swiotlb=force, restricted-dma-pool), and dma-iommu bounces
kmalloc buffers whose size is not ARCH_DMA_MINALIGN aligned on a
non-coherent device, which includes the 1 * 64 + 128 = 192 byte
qmem_alloc(dev, &sq->sqe, 1, 64) allocation. In those cases the CPU and
the device would be looking at two different copies, and the same helper
is used by the PF/VF NIC drivers whose VFs can be assigned to guests.

Would dma_alloc_attrs() without DMA_ATTR_FORCE_CONTIGUOUS, or
dma_alloc_noncontiguous(), express the intended sharing model better?

> +
> +static inline void otx2_dma_free_coherent(struct device *dev, size_t size,
> +					  void *vaddr, dma_addr_t dma_handle)
> +{
> +	dma_unmap_single(dev, dma_handle, size, DMA_BIDIRECTIONAL);
> +	kfree(vaddr);
> +}
> +
>  static inline int qmem_alloc(struct device *dev, struct qmem **q,
>  			     int qsize, int entry_sz)
>  {
> @@ -60,8 +91,11 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
>  
>  	qmem->entry_sz = entry_sz;
>  	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;

[Severity: High]

This isn't a bug introduced by this patch, but the new order check below
validates a value that can already have wrapped here, so it may be worth
addressing in the same change.

qsize and entry_sz are int, so qsize * entry_sz is computed in int
arithmetic. rvu_mbox_handler_npa_lf_alloc() (af/rvu_npa.c) passes a u32
mailbox field with no upper bound:

	if (req->aura_sz > NPA_AURA_SZ_MAX ||
	    req->aura_sz == NPA_AURA_SZ_0 || !req->nr_pools)
		return NPA_AF_ERR_PARAM;
	...
	err = qmem_alloc(rvu->dev, &pfvf->pool_ctx, req->nr_pools, hwctx_size);

With hwctx_size 128 and nr_pools 0x2000001, qsize * entry_sz truncates
to 0x80, so alloc_sz becomes 256 and the new get_order() test passes,
while qmem->qsize keeps 33554433. rvu_npa_aq_enq_inst() then validates
an index against that inflated qsize and programs a device address
derived from it:

			if (req->aura.pool_addr >= pfvf->pool_ctx->qsize) {
				rc = NPA_AF_ERR_AQ_FULL;
				break;
			}
			/* Set pool's context address */
			req->aura.pool_addr = pfvf->pool_ctx->iova +
			(req->aura.pool_addr * pfvf->pool_ctx->entry_sz);

Can the NPA then access memory outside the 256-byte mapping?
rvu_mbox_handler_nix_lf_alloc() passes req->rq_cnt/sq_cnt/cq_cnt the
same way. Would computing alloc_sz in size_t with check_mul_overflow()
and check_add_overflow(), plus bounding the mailbox counts against
hardware limits, close this?

> -	qmem->base = dma_alloc_attrs(dev, qmem->alloc_sz, &qmem->iova,
> -				     GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
> +
> +	if (get_order(PAGE_ALIGN(qmem->alloc_sz)) > MAX_PAGE_ORDER)
> +		return -ENOMEM;

[Severity: High]

Does this new ceiling reject the allocations the commit message says it
is fixing? On arm64 with 4 KiB pages, ARCH_FORCE_MAX_ORDER defaults to
10, so MAX_PAGE_ORDER is 10 and this caps qmem at 4 MiB, which is also
KMALLOC_MAX_SIZE for the kzalloc() above.

Two callers request MBOX_SIZE (SZ_64K) per device. cn20k_pfvf_mbox_alloc()
in nic/otx2_pf.c:

	err = qmem_alloc(&pf->pdev->dev, &mbox_addr, numvfs, MBOX_SIZE);
	if (err) {
		dev_err(pf->dev, "qmem alloc fail\n");
		return ERR_PTR(-ENOMEM);
	}

and rvu_alloc_mbox_memory() in af/cn20k/mbox_init.c:

	err = qmem_alloc(rvu->dev, &mbox_addr, ndevs, mbox_size);
	if (err)
		return -ENOMEM;

At 64 devices, alloc_sz is 64 * 65536 + 128 = 4194432; PAGE_ALIGN() gives
4 MiB + 4 KiB and get_order() returns 11, so the call fails regardless of
how much memory is free. The old dma_alloc_attrs(DMA_ATTR_FORCE_CONTIGUOUS)
path went through CMA, which is not restricted to power-of-two buddy
orders and could satisfy both 4 MiB + 128 and the 6 MiB that
total_pfs = 96 needs on CN20K.

So does enabling 64 or more VFs now fail with -ENOMEM, and does CN20K AF
probe fail in rvu_mbox_init() -> cn20k_rvu_mbox_init() ->
rvu_alloc_mbox_memory() when total_pfs is 64 or more? Note that
cn20k_rvu_mbox_init() programs the per-device window size before the
allocation:

		for (dev = 0; dev < ndevs; dev++)
			rvu_write64(rvu, BLKADDR_RVUM,
				    RVU_MBOX_AF_PFX_CFG(dev), ilog2(MBOX_SIZE));

	return rvu_alloc_mbox_memory(rvu, type, ndevs, MBOX_SIZE);

so the new error path leaves RVU_MBOX_AF_PFX_CFG configured for a mailbox
that was never allocated.

Separately, the unconditional + OTX2_ALIGN padding is what pushes an
exactly power-of-two payload into the next order, and below the cap it
doubles the physical footprint (a 2 MiB payload plus 128 bytes rounds up
to order 10, 4 MiB). Could the commit message mention this new,
non-tunable failure surface?

[Severity: Low]

This is a pre-existing pattern, but the new return adds a second
instance of it. qmem_alloc() has already published the devm-allocated
descriptor into *q before this return:

	*q = devm_kzalloc(dev, sizeof(*qmem), GFP_KERNEL);

Neither this return nor the existing !qmem->base return devm_kfree()s
the descriptor or clears *q. rvu_alloc_mbox_memory() and
cn20k_pfvf_mbox_alloc() hold the qmem pointer only in a local and drop
it on error, so does each failed SR-IOV enable attempt retain a
descriptor plus its devres record until the device is detached?

> +
> +	qmem->base = otx2_dma_alloc_coherent(dev, qmem->alloc_sz, &qmem->iova);

[Severity: Medium]

This isn't a bug introduced by this patch, since kzalloc() also returns a
linear-map address, but the type confusion it exposes may be worth a look
while this code is being touched.

qmem->base is a CPU virtual address here, yet cn20k_rvu_get_mbox_regions()
in af/cn20k/mbox_init.c runs it through phys_to_virt() and uses the result
as the AF-side mailbox base that otx2_mbox_init() dereferences:

		bar = (u64)phys_to_virt((u64)rvu->ng_rvu->pf_mbox_addr->base);
		bar += region * MBOX_SIZE;

		mbox_addr[region] = (void *)bar;

with the same construct in the AFVF path. On arm64,
__phys_to_virt(x) is ((x) - PHYS_OFFSET) | PAGE_OFFSET, so this is an
identity transform only while memstart_addr is 0. Where DRAM does not
start at physical 0, or where a 52-bit-VA kernel runs on hardware without
52-bit VA support and arm64_memblock_init() adjusts memstart_addr:

	if (IS_ENABLED(CONFIG_ARM64_VA_BITS_52) && (vabits_actual != 52))
		memstart_addr -= _PAGE_OFFSET(vabits_actual) - _PAGE_OFFSET(52);

does the AF then read and write mailbox messages at an unrelated
linear-map address?

>  	if (!qmem->base)
>  		return -ENOMEM;
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916022111.1083017-1-rkannoth%40marvell.com
