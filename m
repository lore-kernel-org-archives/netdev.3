Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157F0184;
	Tue, 15 Sep 2026 23:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516477; cv=none; b=TmJ0/KYZvJSPtoEk0Um0s1ZlXKiBqTwzBM+Ppcqr4SOX6r9LlPMgogHJA44N9vo+5w8A7/7W3OmvNS+n4vqqNHC30V+Nu9t47H336oukAPwnF351uJ8vcmfhac5Ied9jkGbJnB7I78PAZJav6Jw3Jytfni2Q1GR2QbmJUumuubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516477; c=relaxed/simple;
	bh=UmyZyDN1hmVNbueOVNGFZHqCXsRDIkRGlMQV+Pxjf6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMTQvtRSiOwO5p41xlN5oEUw4o+3Zg5h/nQRLIiOJUvDFciuHMCx1SwIacZ1/tTrFLUbaytQKyusqSp2HD8SwFOEx/8iSvfAbetUDibUnKVU+rDk4HwiWaC2qifR8omSaecp+VyKmKJJivjSJrUgLtipAgIDbdIWXvdNjn6YsAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8kYLAvv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8kYLAvv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F201F000FF;
	Tue, 15 Sep 2026 23:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789516475;
	bh=AQwUZclXn1mJxCCej5Cf4+aasu5nZ+Nj3Ko2BeP4XWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P8kYLAvvdzMblcmk67qpBXvByqRuAQi0xcn0OzbhDmmhoVS9XYXDZxE/40O0fQ1Uy
	 phG/2UVvUMpGNSDc+JlAwyJDSBZ+mS0s6MjN0Lxcd2PMb9GF9x4jA9QzLsmN3OOQKP
	 pZ977b3mhfmgVuSFLjsr3LmjS3WXNb3R7mWHoNwidwgMFhek4v9QBZtpYXyPnBPFNX
	 gmd4yvTnPa1q4hIathWF+QF3GE7wTuRa+foq+pHErF9CNTEdWRnhLyc693Kt2UB9zY
	 uNE+tosj+Ql+CVsPRXpfzl6Eqys6LpOLUzlv56nipDzkgX+SZOTt9c97U6+7ynv+++
	 NdmS8O5E1tlwQ==
From: Jakub Kicinski <kuba@kernel.org>
To: nshettyj@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asekhar@marvell.com,
	sgoutham@marvell.com,
	rkannoth@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net v2] octeontx2-af: Handle pool context address update in aura WRITE operation
Date: Tue, 15 Sep 2026 16:54:34 -0700
Message-ID: <20260915235434.1522983-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910060032.1209179-1-nshettyj@marvell.com>
References: <20260910060032.1209179-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
octeontx2-af: Handle pool context address update in aura WRITE operation

This adds a helper npa_aura_translate_pool_addr() which checks pfvf->pool_ctx,
bounds the caller supplied pool_id against pool_ctx->qsize and converts it to
the pool context IOVA. The helper is used from both the NPA_AQ_INSTOP_INIT and
the NPA_AQ_INSTOP_WRITE aura paths, with the WRITE path only translating when
aura_mask.pool_addr selects the whole word.

A few questions on the new code below.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
> index e2a33e46b48ad..775a3f0b88bd7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c

[ ... ]

> @@ -58,6 +59,19 @@ static int npa_aq_enqueue_wait(struct rvu *rvu, struct rvu_block *block,
>  	return 0;
>  }
>  
> +static int npa_aura_translate_pool_addr(struct rvu_pfvf *pfvf, u64 *pool_addr)
> +{
> +	if (!pfvf->pool_ctx)
> +		return NPA_AF_ERR_AQ_ENQUEUE;
> +
> +	if (*pool_addr >= pfvf->pool_ctx->qsize)
> +		return NPA_AF_ERR_PARAM;
> +
> +	*pool_addr = pfvf->pool_ctx->iova +
> +		     (*pool_addr * pfvf->pool_ctx->entry_sz);
> +	return 0;
> +}

[Severity: High]
This is a pre-existing lifetime problem rather than something this patch
introduces, but the new helper adds another instance of it, so it seems worth
raising.

Can pfvf->pool_ctx be freed between the NULL test and the reads of qsize,
iova and entry_sz here?  npa_ctx_free() frees the object before clearing the
pointer, and it takes neither block->aq->lock nor rvu->mbox_lock:

drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c:npa_ctx_free() {
	...
	qmem_free(rvu->dev, pfvf->pool_ctx);
	pfvf->pool_ctx = NULL;
	...
}

That path runs on the FLR workqueue:

rvu_flr_handler() -> __rvu_flr_handler() -> rvu_blklf_teardown(BLKADDR_NPA)
	-> rvu_npa_lf_teardown() -> npa_ctx_free()

__rvu_flr_handler() only holds rvu->flr_lock, and neither
rvu_process_mbox_msg() nor rvu_npa_aq_enq_inst() takes that mutex, so an AQ
enqueue arriving from the AFVF mailbox work item can run concurrently with
teardown.  When the aura/pool bitmaps hold no enabled contexts,
npa_lf_hwctx_disable() issues no AQ instruction and never acquires aq->lock,
so there is no incidental serialization either.

If that ordering is possible, the helper would read the devm-freed struct
qmem and program a stale iova/entry_sz result as the aura's pool context
pointer, which is then used by hardware as a DMA target.  Should the free
path take aq->lock (or otherwise flush the mailbox work) before releasing
pool_ctx?

[Severity: High]
This isn't introduced by this patch either - the same qsize-only check
existed on the INIT path since 4a3581cd5995 - but the patch now extends it to
the WRITE path, so a note on it:

Is pool_ctx->qsize trustworthy as an upper bound here?
rvu_mbox_handler_npa_lf_alloc() only rejects a zero nr_pools:

	if (req->aura_sz > NPA_AURA_SZ_MAX ||
	    req->aura_sz == NPA_AURA_SZ_0 || !req->nr_pools)
		return NPA_AF_ERR_PARAM;
	...
	err = qmem_alloc(rvu->dev, &pfvf->pool_ctx, req->nr_pools, hwctx_size);

and qmem_alloc() computes the allocation size in signed int arithmetic while
storing the requested count verbatim:

drivers/net/ethernet/marvell/octeontx2/af/common.h:qmem_alloc() {
	...
	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
	qmem->base = dma_alloc_attrs(dev, qmem->alloc_sz, &qmem->iova,
				     GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
	if (!qmem->base)
		return -ENOMEM;

	qmem->qsize = qsize;
	...
}

With the usual 128 byte pool hwctx size and nr_pools = 0x2000000, does
qsize * entry_sz wrap to 0 so that only OTX2_ALIGN bytes are allocated while
qsize stays 33554432?  The multiplication in the helper is done in 64-bit and
does not wrap, so an aura INIT or the newly added WRITE could then install a
pool context pointer several GiB past the real allocation.  Would bounding
nr_pools and using check_mul_overflow()/size_t arithmetic in qmem_alloc() be
the right place to fix this, so that qsize can be relied on here?

> @@ -116,6 +130,18 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
>  	case NPA_AQ_INSTOP_WRITE:
>  		/* Copy context and write mask */
>  		if (req->ctype == NPA_AQ_CTYPE_AURA) {
> +			/* Translate pool_addr only on a full-word write,
> +			 * partial masks aren't valid pool_id updates.
> +			 */
> +			if (req->aura_mask.pool_addr == U64_MAX) {
> +				rc = npa_aura_translate_pool_addr(pfvf,
> +								  &req->aura.pool_addr);
> +				if (rc)
> +					break;
> +			} else if (req->aura_mask.pool_addr) {
> +				rc = NPA_AF_ERR_PARAM;
> +				break;
> +			}

[Severity: Low]
This isn't a bug, but the new all-or-nothing rule for aura_mask.pool_addr
isn't described anywhere an LF driver author would look.  mbox.h still says:

	/* Mask data when op == WRITE (1=write, 0=don't write) */
	union {
		/* Valid when op == WRITE and ctype == AURA */
		struct npa_aura_s aura_mask;

so a partial pool_addr mask now returns NPA_AF_ERR_PARAM with no hint in the
header.  Could the aura_mask comment in mbox.h mention that pool_addr must be
masked either fully or not at all?

Also, the comment above reads as if partial masks are just passed through
without translation, while the code fails the whole request.  Would something
like "reject partial pool_addr masks; only a full-word write carries a
pool_id" match the code better?

>  			memcpy(mask, &req->aura_mask,
>  			       sizeof(struct npa_aura_s));
>  			memcpy(ctx, &req->aura, sizeof(struct npa_aura_s));

[Severity: High]
Are the values validated above the same values that end up in the AQ context?
As far as I can tell req points directly into the requester's mailbox region,
which stays writable by that PF/VF while the AF handler runs:

drivers/net/ethernet/marvell/octeontx2/af/rvu.c:__rvu_mbox_handler() {
	...
	msg = mdev->mbase + offset;
	...
	err = rvu_process_mbox_msg(mbox, devid, msg);
	...
}

drivers/net/ethernet/marvell/octeontx2/af/rvu.c:rvu_get_mbox_regions() {
	...
	mbox_addr[region] = ioremap_wc(bar4, MBOX_SIZE);
	...
}

So the mask test and the translation are one set of reads/writes, and the two
memcpys above are a second, independent read of the same shared buffer.  Can
a requester post aura_mask.pool_addr = 0 (which passes the else-if arm with no
translation) and then flip aura_mask.pool_addr to U64_MAX and aura.pool_addr
to an arbitrary 64-bit value from another CPU before the AF reaches the
memcpys?

That would put a caller-chosen pool context pointer into the aura context,
which is the case the patch is trying to prevent.  Would copying req->aura and
req->aura_mask into the aq->lock protected ctx/mask buffers (or an on-stack
struct npa_aura_s) first, and validating/translating that private copy, close
the window?  The same shape applies to the INIT path below.

>  		} else {
>  			memcpy(mask, &req->pool_mask,
>  			       sizeof(struct npa_pool_s));
>  			memcpy(ctx, &req->pool, sizeof(struct npa_pool_s));
>  		}
>  		break;
> @@ -127,13 +153,10 @@ int rvu_npa_aq_enq_inst(struct rvu *rvu, struct npa_aq_enq_req *req,
>  		break;
>  	case NPA_AQ_INSTOP_INIT:
>  		if (req->ctype == NPA_AQ_CTYPE_AURA) {
> -			if (req->aura.pool_addr >= pfvf->pool_ctx->qsize) {
> -				rc = NPA_AF_ERR_AQ_FULL;
> +			rc = npa_aura_translate_pool_addr(pfvf,
> +							  &req->aura.pool_addr);
> +			if (rc)
>  				break;
> -			}
> -			/* Set pool's context address */
> -			req->aura.pool_addr = pfvf->pool_ctx->iova +
> -			(req->aura.pool_addr * pfvf->pool_ctx->entry_sz);
>  			memcpy(ctx, &req->aura, sizeof(struct npa_aura_s));
>  		} else { /* POOL's context */
>  			memcpy(ctx, &req->pool, sizeof(struct npa_pool_s));
-- 
pw-bot: cr
