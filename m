Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AF83FFD;
	Sat,  5 Sep 2026 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788637970; cv=none; b=OiwfxhPBSY8VCJdApWD+Vj/PXk/3ydIdCGMhDsONfuR5G61CzJZut3zK8UTvzkK+hHqQR9TPkS8XVbIRHrQMCAZQLuq6dzn5i4mCL2AfDC3D1LkbsB6J0VaNTrz3vBKKBzwF5hXBaVKBCe+2gX5g01vniKi6QuY7+mHbc/zhUu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788637970; c=relaxed/simple;
	bh=73g66NrXJZn+H9Gp9gby6kzuMvgNILJeBvPV7DVUt8E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bsPQqvy6/+3dtKzOfhb1knC/DjgnVpfve+dr8QGo/eaP5Xez18IO0UV26hJ8tfCYz3Ry7d6ZBKhxj7OdJ3wnUYFqa/D+ECj/4727o7xwzKDC+ffnwKkdsDvmm1JzE/BkwJ0s/vnLh1W4FosSvSs1ivu0vqNFJm/dtvOa8/OgAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MH71rYN6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MH71rYN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18751F00A3A;
	Sat,  5 Sep 2026 19:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788637969;
	bh=m4FJ7KTWJRKMMnfj6UAMEGWcrxUpDtQeWt6pguBYUuI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MH71rYN6IoNc7H57jNMsqROR4hNqT9jc1ODxIhVY9tYyZlJvAWiiw2WSGm2iVPV50
	 wJLcwM4SVyHhjrknVRxOcFwPeOdgi+GUvUJUGoPumj0QQC0L3nlwYRcON54lnXCbGE
	 4J7G65MzwnmFDPCPixzZAfamYaQPLu+w8CRmPV7ZwaTcE6hKndNO9WwQcdfAN8b8t6
	 Vwif8Ll750p8kgElN+pX9ZaWb21RUsJkJDEW8ofSBbuL/5MwBHuSDPjrOrDWCv5TpX
	 owHEWkfJbeqrfFdpN6vNaNS1g/yhKWFHkJiMErpiffII3FTtNmKpelFBlkqA9PQv5u
	 nu8dTaSOdpKDA==
Subject: Re: [PATCH net] octeontx2-af: Handle pool context address update in
 aura WRITE operation
From: netdev-bot+sashiko@kernel.org
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, asekhar@marvell.com,
 sgoutham@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Sat, 05 Sep 2026 19:52:48 +0000
Message-ID: <178863796829.219967.14604401966508125474@kernel.org>
In-Reply-To: <20260901105029.1667495-1-nshettyj@marvell.com>
References: <20260901105029.1667495-1-nshettyj@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 1 (1) · Low: 0

- [High] In rvu_npa_aq_enq_inst()'s NPA_AQ_INSTOP_WRITE path, the new
  gate `if (req->aura_mask.pool_addr)` treats a documented bit-granular…
- [Medium] npa_aura_translate_pool_addr() validates and rewrites
  req->aura.pool_addr in place, where `req` points directly into the…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it defeats the
  bounds check the patch adds: rvu_mbox_handler_npa_lf_alloc() validates…
- [Medium] npa_aura_translate_pool_addr() dereferences
  pfvf->pool_ctx->qsize/iova/entry_sz after only a NULL test, with no…

--

octeontx2-af: Handle pool context address update in aura WRITE operation

This adds a helper npa_aura_translate_pool_addr() which checks that
pfvf->pool_ctx exists, bounds checks the pool_id in aura.pool_addr and
converts it into the pool context IOVA.  The helper is then used from both
the NPA_AQ_INSTOP_WRITE and NPA_AQ_INSTOP_INIT legs of
rvu_npa_aq_enq_inst().

A few questions below about the translation in the WRITE path and about the
inputs the new bounds check relies on.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
> index e2a33e46b48ad..c8255271f84eb 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
> @@ -58,6 +58,19 @@ static int npa_aq_enqueue_wait(struct rvu *rvu, struct rvu_block *block,
>  	return 0;
>  }
>  
> +static int npa_aura_translate_pool_addr(struct rvu_pfvf *pfvf, u64 *pool_addr)
> +{
> +	if (!pfvf->pool_ctx)
> +		return NPA_AF_ERR_AQ_ENQUEUE;

[Severity: Medium]
This is a pre-existing issue and not something this patch introduces, but
now that the dereference is factored into a helper it is worth asking: what
keeps pfvf->pool_ctx alive between this NULL test and the field reads just
below it?

npa_ctx_free() does:

	qmem_free(rvu->dev, pfvf->pool_ctx);
	pfvf->pool_ctx = NULL;

and it is reached both from rvu_mbox_handler_npa_lf_free() and from the FLR
work item:

	__rvu_flr_handler() -> rvu_blklf_teardown(BLKADDR_NPA)
		-> rvu_npa_lf_teardown() -> npa_ctx_free()

The FLR side runs under rvu->flr_lock, while rvu_npa_aq_enq_inst() runs from
the mailbox worker holding only aq->lock, which is the per-block admin queue
lock and is unrelated to the pfvf context memory.  With disjoint lock sets,
can an npa_aq_enq for the same pcifunc read pool_ctx->qsize, iova and
entry_sz after qmem_free() has released them, and program the resulting
garbage IOVA into the aura?

The same unsynchronised pattern already exists for pfvf->aura_ctx at the top
of rvu_npa_aq_enq_inst(), so this looks like it wants serialisation of NPA
context alloc/free against AQ enqueue rather than more pointer checks.

> +
> +	if (*pool_addr >= pfvf->pool_ctx->qsize)
> +		return NPA_AF_ERR_PARAM;

[Severity: High]
This isn't a bug introduced by this patch, but it does limit what this new
bounds check can guarantee.  How much can pool_ctx->qsize be trusted here?

rvu_mbox_handler_npa_lf_alloc() only rejects a zero nr_pools:

	if (req->aura_sz > NPA_AURA_SZ_MAX ||
	    req->aura_sz == NPA_AURA_SZ_0 || !req->nr_pools)
		return NPA_AF_ERR_PARAM;
	...
	err = qmem_alloc(rvu->dev, &pfvf->pool_ctx, req->nr_pools, hwctx_size);

and qmem_alloc() computes the allocation size in int:

	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
	qmem->base = dma_alloc_attrs(dev, qmem->alloc_sz, &qmem->iova, ...);
	...
	qmem->qsize = qsize;

Since the pool context size is a power of two, a mailbox request with
nr_pools = 0x2000000 and entry_sz = 128 makes the product wrap to 0, so only
the alignment padding is actually allocated while qmem->qsize keeps the full
0x2000000.  Does this then let npa_aura_translate_pool_addr() accept any
pool_id below that inflated qsize and return iova + pool_id * entry_sz well
past the real DMA allocation, which NPA will fetch and update as an
NPA_POOL_S?

If so, the bound probably needs to be enforced in
rvu_mbox_handler_npa_lf_alloc() / qmem_alloc() with checked size arithmetic
before qsize is recorded.

> +
> +	*pool_addr = pfvf->pool_ctx->iova +
> +		     (*pool_addr * pfvf->pool_ctx->entry_sz);
> +	return 0;
> +}
> +
>  int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
>  			struct npa_aq_enq_rsp *rsp)
>  {
> @@ -116,6 +129,12 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
>  	case NPA_AQ_INSTOP_WRITE:
>  		/* Copy context and write mask */
>  		if (req->ctype == NPA_AQ_CTYPE_AURA) {
> +			if (req->aura_mask.pool_addr) {
> +				rc = npa_aura_translate_pool_addr(pfvf,
> +								  &req->aura.pool_addr);
> +				if (rc)
> +					break;
> +			}

[Severity: High]
Is a nonzero aura_mask.pool_addr the right condition here?  mbox.h documents
aura_mask as bit granular write enable data:

	/* Mask data when op == WRITE (1=write, 0=don't write) */

and npa_aura_s declares pool_addr as a full 64-bit word:

	u64 pool_addr;			/* W0 */

so a requester can pass a partial mask, for example BIT_ULL(16).  In-tree
users do set partial masks on other fields, e.g. aura_mask.ena = 1 in
otx2_xsk.c and aura_mask.nix0_bpid = GENMASK(8, 0) in otx2_dcbnl.c.

With a partial mask, this code translates the whole 64-bit word to
pool_ctx->iova + pool_id * entry_sz, and then the mask is handed to the
admin queue unchanged:

> 			memcpy(mask, &req->aura_mask,
> 			       sizeof(struct npa_aura_s));
> 			memcpy(ctx, &req->aura, sizeof(struct npa_aura_s));

Hardware commits (old_pool_addr & ~mask) | (translated & mask), so doesn't
the aura end up with a spliced pointer that is neither the previous value nor
the requested pool context?  The bounds check in
npa_aura_translate_pool_addr() only constrains the fully written value, so
the merged address can fall outside [iova, iova + qsize * entry_sz) and NPA
will still dereference it as an NPA_POOL_S, whose stack_base and fc_addr
drive further DMA.  Meanwhile the AF records the aura as programmed in
pfvf->aura_bmap further down the function.

Repeated single bit masked writes would also let the requester steer
individual bits of the pool pointer, since each masked bit takes its value
from a translated address of a pool_id the requester chose.

Would it be better to force the mask for the translated word, for example
setting req->aura_mask.pool_addr = ~0ULL after translating, or to reject any
aura_mask.pool_addr other than 0 or ~0ULL, rather than passing the requester
mask through?

[Severity: Medium]
Related question about where req lives.  __rvu_mbox_handler() takes the
message straight out of the shared mailbox region:

	msg = mdev->mbase + offset;
	...
	err = rvu_process_mbox_msg(mbox, devid, msg);

so req points into memory the requesting PF/VF can keep writing.  The gate
if (req->aura_mask.pool_addr), the *pool_addr >= qsize test inside the
helper, and the later memcpy() of req->aura and req->aura_mask into the AQ
context and mask areas are all separate fetches of that memory.

Can a requester that flips aura_mask.pool_addr from zero to nonzero, or
rewrites aura.pool_addr, after the check has run get the raw untranslated
value into the hardware aura?  aq->lock only serialises AF side use of the
admin queue result buffer, it does not stop the peer from writing the
message.

The INIT leg has the same validate in place and recopy window, which the two
paths now share through the helper.  Would snapshotting aura.pool_addr and
aura_mask.pool_addr into local variables once, validating the snapshot, and
building the AQ context and mask from it close this?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901105029.1667495-1-nshettyj%40marvell.com
