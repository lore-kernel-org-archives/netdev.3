Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1634FC8DD;
	Thu,  3 Sep 2026 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463501; cv=none; b=Q9oGtYNkzCOHS3vfHDYo97QEG2Wru5VqsDmOtX0GIboKcxQGPezcDqW/CX1xYaFcibK4ihvOWZghcp1ir+pU5yv1hwb4CpMmSbsqIIMFHhPP2j3ECzw64Yx6Hj7EzKFRRUTjoaRCAIdbAfRVT83bTORnptaDuQC0lGGDk4Sn2PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463501; c=relaxed/simple;
	bh=tBANJ1wP9dKHC0IglIKzSks514Sp6JIC0GJuvB8s59U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HakLofIxbYCK7JbXMBx4D72c80Gs7e1KAUX4wLcLFMSp8lyLKtzHMex+xObR8/sCFW+Mfu7fuSf/oi8KpCOW3/UpF81siwfRH5h6lhiFdhgs4l3axLcXiJsrrEzKIrLmFBFzC4T36ezOQZrLeS5YmbTtAe1dXhE7ZFY2jcn8vVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFQskMpX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFQskMpX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B431F00AC4;
	Thu,  3 Sep 2026 19:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788463488;
	bh=A27X+nw20gRXFBzit7cf2xMFfcbsAQu0d2PBBeHVEZ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eFQskMpXdMQYnGOSnYu+oft41Z9F8Vtp6avJ6ClnAu+Ygjx3BOi5Ed3f1siGOXAFh
	 QT7bvUdMkGcyILMmXGa0L5ds8URbwzbcmbFWiDr5mzHY0zkejttBfLFbd8uI2qYFlQ
	 s/JwN0dGkJfa/eAPimJJQh6DT8yhCpTs4VVmCPPd8qC/vIQMPgEmxjPWkBQ6hQzMAV
	 Ek0MbWeL/hq5kEI4idzDT4FmZuPBhl8WpphXWPt6wzbgHRZwkfrPDBUt4LhQoWyHyQ
	 rBXrwhGnovnnet3x0NNoiLW+A3Tz6HiWmGRUZ9MKVy1KsgHvVmY5rs5s2i2cj1wzcd
	 HXBfhlZqau+VQ==
Subject: Re: [v9,net-next,5/8] octeontx2-af: switch: TL1 scheduling and NPC
 channel control
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com
Date: Thu, 03 Sep 2026 19:24:47 +0000
Message-ID: <178846348798.3394541.4444021202266324323@kernel.org>
In-Reply-To: <20260831131944.2649362-6-rkannoth@marvell.com>
References: <20260831131944.2649362-6-rkannoth@marvell.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 1 · High: 1 · Medium: 2 (1) · Low: 3

- [Critical] Missing scheduler-level validation on the new
  TXSCHQ_FREE_PAN_TL1 path in nix_txschq_free_one()…
- [High] Partial-allocation leak in rvu_mbox_handler_nix_txsch_alloc()
  (drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c):…
- [Medium] The commit message justifies the new fixed-size SQ bitmap with
  "the same span used by bitmap_weight(..., BITS_PER_LONG * 16) in…
- [Medium] PAN TL1 scheduler nodes are returned to the resource pool
  while still armed.
- [Low] Claim that rvu->rswitch.pcifunc has no writer, making
  rvu_is_switch_pcifunc() permanently false and all new PAN/set_chanmask…
- [Low] The new mailbox ABI comments in mbox.h describe the PAN scheduler
  queues as TL2 ("requests two aggregate-level TL2 queues on the PAN…
- [Low] The commit message states "without it, chan_mask was always
  forced to 0xFFF for non-AF functions" and describes set_chanmask as…

Pre-existing issues:
- [Medium] In rvu_nix_blk_aq_enq_inst() the SQ index bounds computation
  (the pfvf->sq_ctx NULL test, the sq_ctx->qsize read and the new…

--

octeontx2-af: switch: TL1 scheduling and NPC channel control

This adds a NIX_TXSCH_ALLOC_FLAG_PAN request flag so the switchdev PF can
get more than one aggregate-level scheduler queue on the PAN link, a
TXSCHQ_FREE_PAN_TL1 flag so those TL1 entries can be freed again, and a
set_chanmask field so the switchdev PF can keep its own NPC chan_mask.
It also changes the NIX LF SQ bitmap sizing and extends struct sg_list.

A few questions below.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index 8e3850f33751d..2aa1aa6599a5a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -1162,6 +1162,13 @@ struct nix_txsch_alloc_req {
>  	/* Scheduler queue count request at each level */
>  	u16 schq_contig[NIX_TXSCH_LVL_CNT]; /* No of contiguous queues */
>  	u16 schq[NIX_TXSCH_LVL_CNT]; /* No of non-contiguous queues */
> +	/* Set only by the single switchdev PF (rvu->rswitch.pcifunc). This is
> +	 * not the eswitch representor (rvu->rep_pcifunc). That PF requests two
> +	 * aggregate-level TL2 queues on the PAN link, one for CGX and one for
> +	 * SDP steering. No other PF or VF sets this flag.
> +	 */
> +#define NIX_TXSCH_ALLOC_FLAG_PAN BIT(0)
> +	u32 flags;
>  };

[Severity: Low]
The comment says the flag requests "aggregate-level TL2 queues", but the
aggregation level is always TL1 here.

af/rvu.c:rvu_setup_hw_capabilities() has the only assignment:

	hw->cap.nix_tx_aggr_lvl = NIX_TXSCH_LVL_TL1;

and every implementation site in this patch indexes
nix_hw->txsch[NIX_TXSCH_LVL_TL1].  The companion macro is even named
TXSCHQ_FREE_PAN_TL1.

Since mbox.h is the only contract a request producer has when choosing
nix_txsch_free_req.schq_lvl, and nix_txschq_free_one() never cross-checks
schq_lvl against the flag, would a producer following the TL2 prose end up
operating on a different scheduler level than one following the TL1 macro
name?

Could the comments say TL1, and could the "PAN link" also be defined
somewhere, along with why nix_get_pan_tx_link() is cgx_links + lbk_links + 1?

[Severity: Low]
This isn't a bug, but nothing in the tree sets NIX_TXSCH_ALLOC_FLAG_PAN,
TXSCHQ_FREE_PAN_TL1 or npc_install_flow_req.set_chanmask, even at the end of
this series, so the new mailbox fields have consumers in the AF but no
in-tree emitters.  Are the producers coming in a follow-up series?

(For the record, rvu->rswitch.pcifunc itself does get a writer later in the
series in rvu_sw_l2_ctrl_work_handler(), so rvu_is_switch_pcifunc() is not
permanently false.)

> @@ -1180,6 +1187,10 @@ struct nix_txsch_alloc_rsp {
>  struct nix_txsch_free_req {
>  	struct mbox_msghdr hdr;
>  #define TXSCHQ_FREE_ALL BIT_ULL(0)
> +	/* Frees PAN TL2 queues allocated with NIX_TXSCH_ALLOC_FLAG_PAN. Used
> +	 * only by the switchdev PF (rvu->rswitch.pcifunc), not by other PFs/VFs.
> +	 */
> +#define TXSCHQ_FREE_PAN_TL1 BIT_ULL(1)
>  	u16 flags;
>  	/* Scheduler queue level to be freed */
>  	u16 schq_lvl;

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 1402beccf6618..e4d13adc2896c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -2006,9 +2007,18 @@ static void rvu_iface_get_qcnts(struct rvu *rvu, struct rvu_pfvf *pfvf,
>  
>  	spin_lock_irqsave(&aq->lock, flags);
>  
> -	/* Use each LF queue context size; bitmaps are sized to qsize longs. */
> -	if (pfvf->sq_ctx && pfvf->sq_bmap)
> -		info->sq_cnt = bitmap_weight(pfvf->sq_bmap, pfvf->sq_ctx->qsize);
> +	if (pfvf->sq_bmap) {
> +		/* Match switchdev sq_bmap allocation size in nix_lf_alloc(). */
> +		if (rvu_is_switch_pcifunc(rvu, pcifunc))
> +			sq_bmap_bits = NIX_SQ_BMAP_BITS;
> +		else if (pfvf->sq_ctx)
> +			sq_bmap_bits = pfvf->sq_ctx->qsize;
> +		else
> +			sq_bmap_bits = 0;
> +
> +		if (sq_bmap_bits)
> +			info->sq_cnt = bitmap_weight(pfvf->sq_bmap, sq_bmap_bits);
> +	}

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index b8f4ad160afcf..9ee6531afbf94 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -1138,10 +1139,25 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
>  		if (!pfvf->rq_ctx || req->qidx >= pfvf->rq_ctx->qsize)
>  			rc = NIX_AF_ERR_AQ_ENQUEUE;
>  		break;
> -	case NIX_AQ_CTYPE_SQ:
> -		if (!pfvf->sq_ctx || req->qidx >= pfvf->sq_ctx->qsize)
> +	case NIX_AQ_CTYPE_SQ: {
> +		if (!pfvf->sq_ctx) {
> +			rc = NIX_AF_ERR_AQ_ENQUEUE;
> +			break;
> +		}
> +
> +		/* Switchdev PF uses a fixed sq_bmap (NIX_SQ_BMAP_BITS); cap qidx
> +		 * to that span so __set_bit() cannot run past the allocation.
> +		 * nix_lf_alloc() also rejects sq_cnt above NIX_SQ_BMAP_BITS.
> +		 */
> +		sq_bmap_bits = rvu_is_switch_pcifunc(rvu, pcifunc) ?
> +			       NIX_SQ_BMAP_BITS :
> +			       (u64)pfvf->sq_ctx->qsize * BITS_PER_LONG;
> +		max_q = min_t(u64, pfvf->sq_ctx->qsize, sq_bmap_bits);
> +
> +		if ((u64)req->qidx >= max_q)
>  			rc = NIX_AF_ERR_AQ_ENQUEUE;
>  		break;
> +	}

[Severity: Medium]
This isn't a bug introduced by this patch, but the comment claims a property
the locking does not provide.

The bounds computation above (the pfvf->sq_ctx test, the qsize read and
max_q) runs with no lock held, while the mutation it is supposed to bound
runs later in the same function under aq->lock, with no re-validation and no
NULL check:

	spin_lock(&aq->lock);
	...
		if (req->ctype == NIX_AQ_CTYPE_SQ && req->sq.ena)
			__set_bit(req->qidx, pfvf->sq_bmap);

Those are exactly the fields nix_ctx_free() clears under the same lock and
frees immediately after releasing it:

	spin_lock_irqsave(&aq->lock, flags);
	...
	pfvf->sq_bmap = NULL;
	pfvf->sq_ctx = NULL;
	...
	spin_unlock_irqrestore(&aq->lock, flags);

	kfree(sq_bmap);
	...
	if (sq_ctx)
		qmem_free(rvu->dev, sq_ctx);

The unlocked-validate/locked-mutate split predates this patch (the baseline
read was "if (!pfvf->sq_ctx || req->qidx >= pfvf->sq_ctx->qsize)"), so this
is only extending it.  I could not prove that AF mailbox AQ processing for a
pcifunc can actually run concurrently with that pcifunc's teardown, so this
may be unreachable.  If it is unreachable, could the comment avoid asserting
that __set_bit() "cannot run past the allocation", since the check and the
write are not in the same critical section?

> @@ -1566,18 +1582,28 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>  	if (!req->rq_cnt || !req->sq_cnt || !req->cq_cnt)
>  		return NIX_AF_ERR_PARAM;
>  
> +	/* Switchdev PF sq_bmap is fixed at NIX_SQ_BMAP_BITS; reject larger
> +	 * sq_cnt before allocating context memory or the bitmap.
> +	 */
> +	sq_bmap_bits = rvu_is_switch_pcifunc(rvu, pcifunc) ?
> +		NIX_SQ_BMAP_BITS :
> +		(u64)req->sq_cnt * BITS_PER_LONG;
> +
> +	if ((u64)req->sq_cnt > sq_bmap_bits)
> +		return NIX_AF_ERR_PARAM;
> +

[Severity: Medium]
The commit message says:

    Allocate the NIX LF SQ bitmap with the same span used by
    bitmap_weight(..., BITS_PER_LONG * 16) in rvu_get_hwinfo().

There is no function named rvu_get_hwinfo() in the driver (git grep at this
commit returns no matches), and there is no pre-existing bitmap_weight()
call with a BITS_PER_LONG * 16 span either - NIX_SQ_BMAP_BITS is added by
this patch.  The site actually changed is rvu_iface_get_qcnts(), the
IFACE_GET_INFO handler.  Could the message name the real function?

For the check above, the non-switch branch reduces to

	req->sq_cnt > (u64)req->sq_cnt * BITS_PER_LONG

which can never be true, so the "reject larger sq_cnt" validation is inert
for every non-switch caller.  Is that intentional, and could the new
NIX_AF_ERR_PARAM path and the new qidx cap in the SQ case of
rvu_nix_blk_aq_enq_inst() be mentioned in the changelog?

[ ... ]

> @@ -2209,6 +2240,25 @@ static void nix_get_txschq_range(struct rvu *rvu, u16 pcifunc,
>  	}
>  }
>  
> +static int nix_get_pan_tx_link(struct rvu *rvu)
> +{
> +	struct rvu_hwinfo *hw = rvu->hw;
> +
> +	return hw->cgx_links + hw->lbk_links + 1;
> +}
> +
> +static bool nix_txsch_is_pan_schq(struct rvu *rvu, int schq)
> +{
> +	int pan_link = nix_get_pan_tx_link(rvu);
> +
> +	return schq >= pan_link && schq <= pan_link + 1;
> +}
> +
> +static bool nix_txsch_pan_allowed(struct rvu *rvu, u16 pcifunc)
> +{
> +	return rvu_is_switch_pcifunc(rvu, pcifunc);
> +}
> +
>  static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
>  				      struct nix_hw *nix_hw,
>  				      struct nix_txsch_alloc_req *req)
> @@ -2224,12 +2274,27 @@ static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
>  	/* For traffic aggregating scheduler level, one queue is enough */
>  	if (lvl >= hw->cap.nix_tx_aggr_lvl) {
> -		if (req_schq != 1)
> +		if (req_schq != 1 && !(req->flags & NIX_TXSCH_ALLOC_FLAG_PAN))
>  			return NIX_AF_ERR_TLX_ALLOC_FAIL;
> +		if (req->schq[lvl] > MAX_TXSCHQ_PER_FUNC ||
> +		    req->schq_contig[lvl] > MAX_TXSCHQ_PER_FUNC)
> +			return NIX_AF_ERR_TLX_ALLOC_FAIL;
> +		if (req->flags & NIX_TXSCH_ALLOC_FLAG_PAN) {
> +			if (link >= txsch->schq.max || link + 1 >= txsch->schq.max)
> +				return NIX_AF_ERR_TLX_ALLOC_FAIL;
> +			if (req_schq > 2)
> +				return NIX_AF_ERR_TLX_ALLOC_FAIL;
> +		}
>  		return 0;
>  	}

[Severity: High]
This PAN block never test_bit()s whether the two PAN indices are actually
free, it only bounds them against txsch->schq.max and caps req_schq at 2.
So validation can pass while the two indices are already taken, and the
failure is then deferred into nix_txsch_alloc(), which is now fallible.

Can that leak the scheduler queues committed for the earlier levels?  See
the two hunks below.

> @@ -2270,6 +2335,46 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
>  	 * on transmit link to which PF_FUNC is mapped to.
>  	 */
>  	if (lvl >= hw->cap.nix_tx_aggr_lvl) {
> +		if (start != end) {
> +			int want_contig = rsp->schq_contig[lvl];
> +			int got_contig = 0, got = 0;
> +			int want = rsp->schq[lvl];
> +
> +			for (schq = start; schq <= end; schq++) {
> +				if (test_bit(schq, txsch->schq.bmap))
> +					continue;
> +
> +				if (got_contig < want_contig) {
> +					set_bit(schq, txsch->schq.bmap);
> +					rsp->schq_contig_list[lvl][got_contig++] = schq;
> +					continue;
> +				}
> +
> +				if (got < want) {
> +					set_bit(schq, txsch->schq.bmap);
> +					rsp->schq_list[lvl][got++] = schq;
> +				}
> +			}
> +
> +			rsp->schq_contig[lvl] = got_contig;
> +			rsp->schq[lvl] = got;
> +
> +			if (got_contig < want_contig || got < want) {
> +				for (idx = 0; idx < got_contig; idx++)
> +					clear_bit(rsp->schq_contig_list[lvl][idx],
> +						  txsch->schq.bmap);
> +				for (idx = 0; idx < got; idx++)
> +					clear_bit(rsp->schq_list[lvl][idx],
> +						  txsch->schq.bmap);
> +				rsp->schq_contig[lvl] = 0;
> +				rsp->schq[lvl] = 0;
> +				dev_err(rvu->dev,
> +					"Could not allocate schq at lvl=%u start=%u end=%u\n",
> +					lvl, start, end);
> +				return -ENOMEM;
> +			}
> +			return 0;
> +		}

[ ... ]

> @@ -2398,10 +2512,11 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
>  			end = txsch->schq.max;
>  		}
>  
> -		nix_txsch_alloc(rvu, txsch, rsp, lvl, start, end);
> +		if (nix_txsch_alloc(rvu, txsch, rsp, lvl, start, end))
> +			goto err;

[Severity: High]
Does this goto leak the scheduler queues allocated for the previous levels?

This goto is inside the per-level loop, but the error path only sets the
return code and unlocks:

	err:
		rc = NIX_AF_ERR_TLX_ALLOC_FAIL;
	exit:
		mutex_unlock(&rvu->rsrc_lock);
		return rc;

There is no clear_bit()/rvu_free_rsrc() for the bits already set in
txsch->schq.bmap, and no reset of the pfvf_map[schq] = TXSCH_MAP(pcifunc, 0)
stamps applied for SMQ/TL4/TL3/TL2 in earlier iterations.  The only failing
return is the new start != end branch at the aggregate level, which is the
last iteration, so the lower levels are already committed when it fires.

The requester gets an error and no schq lists back, so it cannot free those
indices individually - they stay used until TXSCHQ_FREE_ALL or LF teardown,
and each retry commits a fresh set.  Since the two PAN indices stay occupied
across retries, can a retry loop exhaust the shared SMQ/TL4/TL3/TL2 pool for
the other PFs/VFs on that NIX block?

Before this patch nix_txsch_alloc() was void and could not fail mid-loop, so
there was nothing to unwind.

> @@ -2679,6 +2794,20 @@ static int nix_txschq_free(struct rvu *rvu, u16 pcifunc)
>  	}
>  	nix_clear_tx_xoff(rvu, blkaddr, NIX_TXSCH_LVL_TL1,
>  			  nix_get_tx_link(rvu, pcifunc));
> +	/* TL1 is at nix_tx_aggr_lvl so the loop above skips it; also clear
> +	 * PAN TL1 XOFF on switch-owned links before flushing SMQs.
> +	 */
> +	if (nix_txsch_pan_allowed(rvu, pcifunc)) {
> +		txsch = &nix_hw->txsch[NIX_TXSCH_LVL_TL1];
> +
> +		for (schq = nix_get_pan_tx_link(rvu);
> +		     schq < txsch->schq.max &&
> +		     nix_txsch_is_pan_schq(rvu, schq); schq++) {
> +			if (TXSCH_MAP_FUNC(txsch->pfvf_map[schq]) != pcifunc)
> +				continue;
> +			nix_clear_tx_xoff(rvu, blkaddr, NIX_TXSCH_LVL_TL1, schq);
> +		}
> +	}
>  
>  	/* On PF cleanup, clear cfg done flag as
>  	 * PF would have changed default config.
> @@ -2706,11 +2835,11 @@ static int nix_txschq_free(struct rvu *rvu, u16 pcifunc)
>  		 /* TLs above aggregation level are shared across all PF
>  		  * and it's VFs, hence skip freeing them.
>  		  */
> -		if (lvl >= hw->cap.nix_tx_aggr_lvl)
> -			continue;
> -
>  		txsch = &nix_hw->txsch[lvl];
>  		for (schq = 0; schq < txsch->schq.max; schq++) {
> +			if (lvl >= hw->cap.nix_tx_aggr_lvl &&
> +			    !nix_txsch_is_pan_schq(rvu, schq))
> +				continue;
>  			if (TXSCH_MAP_FUNC(txsch->pfvf_map[schq]) != pcifunc)
>  				continue;
>  			nix_reset_tx_schedule(rvu, blkaddr, lvl, schq);
> 			rvu_free_rsrc(&txsch->schq, schq);
> 			txsch->pfvf_map[schq] = TXSCH_MAP(0, NIX_TXSCHQ_FREE);

[Severity: Medium]
Are the PAN TL1 nodes returned to the free pool while still armed?

The block above writes 0 to NIX_AF_TL1X_SW_XOFF (leaving the node
scheduling), and the loop here then calls nix_reset_tx_schedule() followed
by rvu_free_rsrc().  But nix_reset_tx_schedule() has no TL1 case:

	switch (lvl) {
	case NIX_TXSCH_LVL_TL2:
	...
	default:
		return;
	}

TL1X_CIR is not reset in this path either, because the first loop in
nix_txschq_free() still does

		if (lvl >= hw->cap.nix_tx_aggr_lvl)
			continue;

so nix_reset_tx_shaping() never runs for TL1.  The TL1 therefore goes back
to the pool enabled and still anchored through TL1X_TOPOLOGY.PRIO_ANCHOR to
TL2 children that the same loop frees and that can be handed to another PF.

The reverse direction looks asymmetric too: nothing in the allocation path
normalizes TL1X_SW_XOFF (nix_reset_tx_linkcfg() returns early for the
aggregation level, nix_reset_tx_schedule() is a no-op for TL1, and
nix_reset_tx_shaping() only touches TL1X_CIR).  If a PAN TL1 is freed while
XOFF is asserted - for instance rvu->rswitch.pcifunc has already been
cleared, so the new XOFF-clearing block is skipped while this loop still
releases the index - does the next owner get a TL1 that never transmits?

nix_txschq_free_one() on the TXSCHQ_FREE_PAN_TL1 path does call
nix_reset_tx_shaping() but likewise leaves TOPOLOGY/SCHEDULE programmed, so
the two free paths leave different hardware state behind.  Before this patch
TL1 was never freed, so leaving it armed did not matter.

> @@ -2754,7 +2883,16 @@ static int nix_txschq_free_one(struct rvu *rvu,
>  	schq = req->schq;
>  	txsch = &nix_hw->txsch[lvl];
>  
> -	if (lvl >= hw->cap.nix_tx_aggr_lvl || schq >= txsch->schq.max)
> +	if (req->flags & TXSCHQ_FREE_PAN_TL1) {
> +		if (!nix_txsch_pan_allowed(rvu, pcifunc))
> +			return NIX_AF_ERR_TLX_INVALID;
> +		if (!nix_txsch_is_pan_schq(rvu, schq))
> +			return NIX_AF_ERR_TLX_INVALID;
> +	} else if (lvl >= hw->cap.nix_tx_aggr_lvl) {
> +		return 0;
> +	}
> +
> +	if (schq >= txsch->schq.max)
>  		return 0;

[Severity: Critical]
Can this read past nix_hw->txsch[]?

lvl comes straight from the mailbox and is never bounded:

	lvl = req->schq_lvl;
	schq = req->schq;
	txsch = &nix_hw->txsch[lvl];

rvu_mbox_handler_nix_txsch_free() forwards req unvalidated:

	if (req->flags & TXSCHQ_FREE_ALL)
		return nix_txschq_free(rvu, req->hdr.pcifunc);
	else
		return nix_txschq_free_one(rvu, req);

and nix_hw->txsch[] has only NIX_TXSCH_LVL_CNT (5) entries.  Before this
patch the combined test short-circuited for every lvl >= 4 and returned 0
before txsch was dereferenced.  The new PAN branch skips that early return
and checks only the requester (nix_txsch_pan_allowed()) and the numeric
index (nix_txsch_is_pan_schq(), which is level-agnostic), so with
schq_lvl = 65535 execution reaches

	if (schq >= txsch->schq.max)

reading roughly 65535 * sizeof(struct nix_txsch) past nix_hw.  If that
garbage max happens to exceed schq, the code continues into
TXSCH_MAP_FUNC(pfvf_map[schq]) through a garbage pointer, then
rvu_free_rsrc(&txsch->schq, schq) and a pfvf_map[schq] write, all under
rvu->rsrc_lock.

Is the requester check enough to make this unreachable?  It looks like any
PF/VF can become rvu->rswitch.pcifunc, since rvu_sw_swdev2af_sender_check()
in af/switch/rvu_sw.c returns early without checking the sender:

	if (msg_type == SWDEV2AF_MSG_TYPE_FW_STATUS && req->fw_up)
		return 0;

after which rvu_sw_l2_ctrl_work_handler() stores that pcifunc into
rvu->rswitch.pcifunc.

Also, even for in-range levels there is no lvl == NIX_TXSCH_LVL_TL1 check,
so TXSCHQ_FREE_PAN_TL1 with schq_lvl = NIX_TXSCH_LVL_SMQ would tear down an
SMQ whose index happens to fall in the PAN range.  Could this path reject
lvl >= NIX_TXSCH_LVL_CNT before indexing, and require
lvl == NIX_TXSCH_LVL_TL1 when the PAN flag is set, the way
rvu_mbox_handler_nix_txschq_cfg() already validates
req->lvl >= NIX_TXSCH_LVL_CNT?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index e36c68ee5d847..40d49a3238146 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> @@ -1833,9 +1833,23 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
> -	/* ignore chan_mask in case pf func is not AF, revisit later */
> -	if (!is_pffunc_af(req->hdr.pcifunc))
> -		req->chan_mask = rvu_get_cpt_chan_mask(rvu);
> +	/* Non-AF callers get the CPT default chan_mask unless the authorized
> +	 * switchdev PF sets set_chanmask to preserve a caller-supplied mask.
> +	 * VFs and other PFs must not use set_chanmask; that would bypass
> +	 * channel isolation.
> +	 */
> +	if (!is_pffunc_af(req->hdr.pcifunc)) {
> +		if (req->set_chanmask &&
> +		    !rvu_is_switch_pcifunc(rvu, req->hdr.pcifunc)) {
> +			rvu_npc_free_entry_for_flow_install(rvu,
> +							    req->hdr.pcifunc,
> +							    allocated,
> +							    req->entry);
> +			return NPC_FLOW_VF_PERM_DENIED;
> +		}
> +		if (!req->set_chanmask)
> +			req->chan_mask = rvu_get_cpt_chan_mask(rvu);
> +	}

[Severity: Low]
The commit message says:

    For NPC install flow, add set_chanmask so callers can keep a non-default
    chan_mask when the requester is not the AF; without it, chan_mask was
    always forced to 0xFFF for non-AF functions.

Both halves look inaccurate for this code.  The replaced line called
rvu_get_cpt_chan_mask(), which is platform dependent:

	if (!is_rvu_otx2(rvu))
		return NIX_CHAN_CPT_X2P_MASK;
	else
		return 0xFFFu;

so the previous default was 0xFFF only on OTX2.  And the new behaviour is
not available to non-AF callers in general - the hunk above returns
NPC_FLOW_VF_PERM_DENIED unless the requester is exactly
rvu->rswitch.pcifunc.

Could the changelog say that set_chanmask is honored only for the switchdev
PF, and drop the claim about 0xFFF?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831131944.2649362-1-rkannoth%40marvell.com
