Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD074A2A70;
	Thu,  3 Sep 2026 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463499; cv=none; b=NvdOWshe9Pk4PFngY3OGYSfPXAHxujMf5QHLRFzwPzUk+i7zUqXRIFJh6SRSAjiFZeeo20TCNStpIL9+q5m1kndH1SHPcIsdvn7xJ4HKR/NZQ8r23c/6Y7XsguHlsmdsv6ZJWr/Wj30G8Ph5LVQmZYzDL4u3kSVVeC/GSPbyhEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463499; c=relaxed/simple;
	bh=Q+3dxNMXL5wxMHVj/rhKvI4aG1vWxrL8j8NpCfE16Fo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LrEeVJ6/q7GHPaBJrDgPmhAaXuy1lvB0V50vlYW1owUxSMdz9aiBk/g6u/ubdDF5ZahvlYjIJJHPgxyF26pjYRzKZA4psqFg2rFqV162aCG8jA3fCZi+oDwoTbfAov4aKToN01Imk9cKwsqdQOqOfeRQyvI7wFuxp1tpifynQwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzddHrT5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzddHrT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1895A1F00A3D;
	Thu,  3 Sep 2026 19:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788463485;
	bh=JgdRgNOV6kvsfN+ssFrwMkEO/o3VL74MHxQtnzd1zbU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EzddHrT5UvaPT5uZb66hxH+SlSQ1liPbnDVd4GFGec/nr9U9xFKV1V1tf3ifLL/41
	 uh2qhDbBGzdXGFW52l5A3c6Mjqpf4jO3B9oK6OFr4pTU4T9SYaCbXX4f2JL/xpotQi
	 GnVW9pA7zfI5se8ANFH6nxz77l6nVWIgwzu25GFhtJ1r6ZlF7ooWYJrwO8gTfP//pT
	 n8QGTS5/dWKmvOcy9fIJXC4fQrdupe7ZbItdNsJf+3x9nsQYfT0lzrKAuaY7t092Xq
	 Ewkt5OiUrbNAkXvI1DTZSAiriyu/RwOcjZHFlAVBzcVnfCwBZWBXFx6WLKj1PuZ98a
	 dLxD2PImX5bHw==
Subject:
 Re: [v9,net-next,2/8] octeontx2-af: switch: Add switch dev to AF mboxes
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com
Date: Thu, 03 Sep 2026 19:24:44 +0000
Message-ID: <178846348463.3394541.14836546464232213340@kernel.org>
In-Reply-To: <20260831131944.2649362-3-rkannoth@marvell.com>
References: <20260831131944.2649362-3-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 7 · Low: 3

- [High] The new IFACE_GET_INFO mailbox (MBOX_MSG_IFACE_GET_INFO, 0x014)
  performs no capability/ownership check on the requester.
- [Medium] The commit message describes the patch as only *defining*
  mailboxes so switch software can query information from AF ("These…
- [Medium] Memory leak of the devres-allocated `struct qmem` descriptor
  on qmem_alloc() partial failure.
- [Medium] Inconsistent locking for the same fields: the new helper
  nix_ctx_assign() publishes pfvf->rss_ctx, pfvf->cq_ints_ctx and…
- [Medium] rvu_mbox_handler_iface_get_info() walks every PF/VF and reads
  other pcifuncs' rvu_pfvf state (tx_chan_cnt, rx_chan_base/cnt,…
- [Medium] The two new bulk mailbox handlers emit non-ratelimited
  dev_err() messages driven entirely by attacker-supplied request…
- [Medium] rvu_mbox_handler_iface_get_info() publishes info->tx_link =
  nix_get_tx_link(rvu, pcifunc) (rvu.c:2071 for PFs, rvu.c:2104 for…
- [Medium] Silent Memory Leak in Context Assignment and Free Paths
- [Low] Stub mailbox handlers acknowledge success without implementing
  their advertised operation: rvu_mbox_handler_swdev2af_notify() in…
- [Low] The new UP message groups MBOX_UP_AF2SWDEV_MESSAGES (AF2SWDEV,
  0xEF1) and MBOX_UP_AF2PF_FDB_REFRESH_MESSAGES (AF2PF_FDB_REFRESH,…
- [Low] The new code takes the NIX admin-queue lock with
  spin_lock_irqsave() (rvu_iface_get_qcnts() in rvu.c, nix_qctx_assign()…

Pre-existing issues:
- [High] The patch introduces the convention "pfvf->{rq,sq,cq}_ctx and
  *_bmap are published/cleared under block->aq->lock" so the new…

--

octeontx2-af: switch: Add switch dev to AF mboxes

This adds new AF mailboxes (IFACE_GET_INFO, SWDEV2AF_NOTIFY,
NPC_MCAM_FLOW_DEL_N_FREE, NPC_MCAM_GET_MUL_STATS, NPC_MCAM_GET_FEATURES)
and two AF initiated UP message groups so switch software can query
information from AF.  It also reworks how the NIX LF context memory is
published and freed in rvu_nix.c.  A few questions below.

[Severity: Medium]

The changelog says:

  "Switch needs various information from AF driver. These mboxes are
   defined to query those from AF driver."

Two parts of the patch look wider than that description.

NPC_MCAM_FLOW_DEL_N_FREE (0x6020) is not a query.  Its handler deletes
flows and frees up to 256 MCAM entries per message.

rvu_nix.c also changes the generic NIX LF context lifecycle used by every
PF/VF: new helpers nix_qctx_assign() and nix_ctx_assign(), nix_ctx_free()
converted to snapshot-and-clear under aq->lock with a new early return
when aq is NULL, and per-allocation qmem_free() error handling in
rvu_mbox_handler_nix_lf_alloc().

Could the changelog mention the state changing mailbox and the NIX
context rework, or could the rvu_nix.c rework move into its own patch so
it can be reviewed and backported on its own?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index 854696d2a35f1..e45e6e93ed087 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -172,6 +172,10 @@ M(FL_NOTIFY,		0x012,  fl_notify,				\
>  				fl_notify_req, msg_rsp)		\
>  M(FL_GET_STATS,		0x013,  fl_get_stats,				\
>  				fl_get_stats_req, fl_get_stats_rsp)	\
> +M(IFACE_GET_INFO,	0x014, iface_get_info, msg_req,	\
> +				iface_get_info_rsp)			\
> +M(SWDEV2AF_NOTIFY,	0x015,  swdev2af_notify,		\
> +				swdev2af_notify_req, msg_rsp)		\
>  /* CGX mbox IDs (range 0x200 - 0x3FF) */				\
>  M(CGX_START_RXTX,	0x200, cgx_start_rxtx, msg_req, msg_rsp)	\
>  M(CGX_STOP_RXTX,	0x201, cgx_stop_rxtx, msg_req, msg_rsp)		\

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 74c041ab5280a..1402beccf6618 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -1990,6 +1990,140 @@ int rvu_mbox_handler_msix_offset(struct rvu *rvu, struct msg_req *req,
>  	return 0;
>  }
>  
> +static void rvu_iface_get_qcnts(struct rvu *rvu, struct rvu_pfvf *pfvf,
> +				struct iface_info *info)
> +{
> +	struct admin_queue *aq;
> +	unsigned long flags;
> +
> +	info->sq_cnt = 0;
> +	info->cq_cnt = 0;
> +	info->rq_cnt = 0;
> +
> +	aq = rvu->hw->block[pfvf->nix_blkaddr].aq;
> +	if (!aq)
> +		return;
> +
> +	spin_lock_irqsave(&aq->lock, flags);

[Severity: Low]

Is the irqsave variant needed for this lock?  Every pre-existing user of
block->aq->lock takes it with plain spin_lock(), for example
rvu_nix_blk_aq_enq_inst(), and that holder keeps the lock across
nix_aq_enqueue_wait(), which busy waits on AQ completion for up to its
1000 iteration timeout.

rvu_iface_get_qcnts() is called once per reported interface, so up to
IFACE_MAX (288) acquisitions per IFACE_GET_INFO message, each of which can
spin with interrupts disabled for that polling window.  Would plain
spin_lock() be enough here, matching the existing users?

> +
> +	/* Use each LF queue context size; bitmaps are sized to qsize longs. */
> +	if (pfvf->sq_ctx && pfvf->sq_bmap)
> +		info->sq_cnt = bitmap_weight(pfvf->sq_bmap, pfvf->sq_ctx->qsize);
> +	if (pfvf->cq_ctx && pfvf->cq_bmap)
> +		info->cq_cnt = bitmap_weight(pfvf->cq_bmap, pfvf->cq_ctx->qsize);
> +	if (pfvf->rq_ctx && pfvf->rq_bmap)
> +		info->rq_cnt = bitmap_weight(pfvf->rq_bmap, pfvf->rq_ctx->qsize);
> +
> +	spin_unlock_irqrestore(&aq->lock, flags);
> +}
> +
> +int rvu_mbox_handler_iface_get_info(struct rvu *rvu, struct msg_req *req,
> +				    struct iface_get_info_rsp *rsp)
> +{
> +	struct iface_info *info;
> +	bool truncated = false;
> +	struct rvu_pfvf *pfvf;
> +	int pf, vf, numvfs;
> +	int tot = 0;
> +	u16 pcifunc;
> +	u64 cfg;
> +
> +	/* Read-only topology snapshot for switch software; any PF/VF may
> +	 * request it. Only channel and queue counts already visible to the
> +	 * requester through AF are reported.
> +	 */

[Severity: High]

Should this mailbox be restricted to the switch pcifunc?  The handler never
looks at req->hdr.pcifunc, and the loop below walks every PF and every VF,
returning each function's pcifunc id, NPC rx/tx channel base and counts, tx
link, NIX block and live sq/cq/rq counts.

MBOX_MSG_IFACE_GET_INFO is registered in the generic MBOX_MESSAGES list, so
any RVU PF or VF can send it, including a VF assigned to an untrusted guest.

Is the second sentence of the comment accurate?  The rvu_pfvf state of
*other* functions is AF private, so the requester has no other way to read
another function's channel base or queue counts.  Other AF handlers that
touch a different function's state gate on npc_mcam_verify_entry() or
is_pffunc_map_valid(), and the SWDEV2AF_NOTIFY handler added later in the
series gates on rvu_is_switch_pcifunc().  Would the same kind of gate fit
here?

> +	rsp->cnt = 0;
> +	rsp->truncated = 0;
> +	memset(rsp->rsvd, 0, sizeof(rsp->rsvd));
> +	/* Preserve mbox_msghdr fields pre-filled by the mbox framework. */
> +	memset(rsp->info, 0, sizeof(rsp->info));
> +	info = rsp->info;
> +	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
> +		if (tot >= IFACE_MAX) {
> +			truncated = true;
> +			goto done;
> +		}
> +
> +		cfg = rvu_read64(rvu, BLKADDR_RVUM, RVU_PRIV_PFX_CFG(pf));
> +		numvfs = (cfg >> 12) & 0xFF;
> +
> +		/* Skip not enabled PFs */
> +		if (!(cfg & BIT_ULL(20)))
> +			goto chk_vfs;
> +
> +		/* If Admin function, check on VFs */
> +		if (cfg & BIT_ULL(21))
> +			goto chk_vfs;
> +
> +		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
> +		pfvf = rvu_get_pfvf(rvu, pcifunc);
> +
> +		/* Populate iff at least one Tx channel */
> +		if (!pfvf->tx_chan_cnt)
> +			goto chk_vfs;
> +
> +		info->is_vf = 0;
> +		info->pcifunc = pcifunc;
> +		info->rx_chan_base = pfvf->rx_chan_base;
> +		info->rx_chan_cnt = pfvf->rx_chan_cnt;
> +		info->tx_chan_base = pfvf->tx_chan_base;
> +		info->tx_chan_cnt = pfvf->tx_chan_cnt;

[Severity: Medium]

Can this snapshot of another function's rvu_pfvf be torn?  tx_chan_cnt,
rx_chan_base/cnt, tx_chan_base/cnt and nix_blkaddr of PF/VF X are written
by X's own NIX_LF_ALLOC / NIX_LF_FREE processing in nix_interface_init()
and the teardown path, which runs on a different mailbox worker, and
nothing here is serialized against it:

	if (!pfvf->tx_chan_cnt)
		goto chk_vfs;
	...
	info->rx_chan_base = pfvf->rx_chan_base;
	info->tx_chan_base = pfvf->tx_chan_base;

so the interface can be reported because tx_chan_cnt was still non-zero,
with channel bases that the other path has already reprogrammed.

Related, rvu_iface_get_qcnts() picks which lock to take from an unlocked
read of pfvf->nix_blkaddr:

	aq = rvu->hw->block[pfvf->nix_blkaddr].aq;
	if (!aq)
		return;
	spin_lock_irqsave(&aq->lock, flags);

On a part with NIX0 and NIX1, if that field does not agree with the block
whose aq->lock nix_ctx_free() takes, the pfvf->sq_ctx->qsize dereference is
not protected against the qmem_free() there.  Would taking rvu->rsrc_lock
around the whole walk, or deriving the lock from state that is stable under
the lock being taken, close both of these?

> +		info->tx_link = nix_get_tx_link(rvu, pcifunc);

[Severity: Medium]

Is nix_get_tx_link() the right source for the value exported here?  For LBK
VFs it ignores pfvf->lbkid and always returns the first LBK link:

	if (is_lbk_vf(rvu, pcifunc)) {/* LBK links */
		return hw->cgx_links;

while nix_interface_init() programs and reports the link as
hw->cgx_links + lbkid, with lbkid = vf & 0x1 ? 0 : 1 when
rvu->hw->lbk_links > 1.  On a part with more than one LBK link, does this
collapse LBK1 onto LBK0 and contradict the tx_link the same AF already
returned to that interface in its NIX_LF_ALLOC response?

nix_get_tx_link() also has no is_rep_dev() case, while nix_get_txschq_range()
treats representors as LBK, so a representor transmitting over
RVU_SWITCH_LBK_CHAN gets reported with a CGX or SDP link.  Should the new
consumer derive tx_link from pfvf->lbkid plus the representor mapping
instead?

> +		if (is_sdp_pfvf(rvu, pcifunc))
> +			info->is_sdp = 1;
> +
> +		rvu_iface_get_qcnts(rvu, pfvf, info);
> +
> +		if (pfvf->nix_blkaddr == BLKADDR_NIX0)
> +			info->nix = 0;
> +		else
> +			info->nix = 1;
> +
> +		info++;
> +		tot++;
> +
> chk_vfs:

[ ... VF loop repeats the same reads ... ]

> +done:
> +	rsp->cnt = tot;
> +	rsp->truncated = truncated;
> +
> +	return 0;
> +}
> +
>  int rvu_mbox_handler_free_rsrc_cnt(struct rvu *rvu, struct msg_req *req,
>  				   struct free_rsrcs_rsp *rsp)
>  {

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 153eb57bad067..b8f4ad160afcf 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -912,33 +911,78 @@ static void nix_setup_lso(struct rvu *rvu, struct nix_hw *nix_hw, int blkaddr)
>  	nix_hw->lso.in_use++;
>  }
>  
> +static void nix_qctx_assign(struct rvu *rvu, int blkaddr, struct qmem **ctx,
> +			    unsigned long **bmap, struct qmem *new_ctx,
> +			    unsigned long *new_bmap)
> +{
> +	struct admin_queue *aq = rvu->hw->block[blkaddr].aq;
> +	unsigned long flags;
> +
> +	if (!aq)
> +		return;
> +
> +	spin_lock_irqsave(&aq->lock, flags);
> +	*ctx = new_ctx;
> +	*bmap = new_bmap;
> +	spin_unlock_irqrestore(&aq->lock, flags);
> +}
> +
> +static void nix_ctx_assign(struct rvu *rvu, struct qmem **ctx,
> +			   struct qmem *new_ctx)
> +{
> +	mutex_lock(&rvu->rsrc_lock);
> +	*ctx = new_ctx;
> +	mutex_unlock(&rvu->rsrc_lock);
> +}

[Severity: Medium]
nix_qctx_assign() returns void and gives up silently when
rvu->hw->block[blkaddr].aq is NULL, but by the time it is called the
caller has already done all the allocating.  In
rvu_mbox_handler_nix_lf_alloc() the only references to the freshly
qmem_alloc()'d rq_ctx/sq_ctx/cq_ctx and the kcalloc()'d
rq_bmap/sq_bmap/cq_bmap are the locals, so if the assignment is
skipped pfvf->rq_ctx and friends stay NULL, the handler keeps going
and returns 0, and nothing ever frees the DMA memory or the bitmaps:
nix_ctx_free() at teardown only looks at the pfvf->* pointers, which
are still NULL.  Worse, NIX_AF_LFX_RQS_BASE / _SQS_BASE / _CQS_BASE
have already been programmed with those iovas at that point, so the
LF is left pointing at memory the driver no longer tracks, and it is
only reclaimed on AF unbind (devm) or never (kcalloc).

The same !aq test in nix_ctx_free() compounds it from the other side,
since that path then frees nothing at all.

Can block[blkaddr].aq actually be NULL here?  blkaddr came from
rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc) a few lines earlier and the
LF was reset via rvu_lf_reset(), so if the AQ is guaranteed to exist
for an implemented NIX block, the check reads as dead code and a
WARN_ON_ONCE() would document that better.  If it can be NULL, should
nix_qctx_assign() return int so the caller can qmem_free(new_ctx),
kfree(new_bmap) and goto free_mem with an error instead of leaking
and reporting success?

[Severity: Medium]

Do these two helpers protect the same fields with different locks?

nix_ctx_assign() publishes pfvf->rss_ctx, pfvf->cq_ints_ctx and
pfvf->nix_qints_ctx under rvu->rsrc_lock, while nix_ctx_free() below reads
and NULLs exactly those three fields under
rvu->hw->block[pfvf->nix_blkaddr].aq->lock and then calls qmem_free() on
them.  The two lock sets are disjoint, so the publish path and the teardown
path do not exclude each other, and no reader of those three fields takes
rvu->rsrc_lock.

rvu_mbox_handler_nix_lf_alloc() runs on the mailbox worker, and
nix_ctx_free() is reached from rvu_nix_lf_teardown() on rvu->flr_wq, so if
an FLR lands while NIX_LF_ALLOC is in flight:

  teardown (aq->lock)          alloc (rsrc_lock)
  rss_ctx = pfvf->rss_ctx;     /* still NULL */
  pfvf->rss_ctx = NULL;
                               pfvf->rss_ctx = rss_ctx;
  qmem_free(...)               /* nothing freed */

either the freshly published qmem is left attached to a destroyed LF and
never freed, or pfvf->rss_ctx ends up pointing at memory already passed to
qmem_free(), which the NIX_AQ_ENQ path only checks with
if (!pfvf->rss_ctx).  Since nix_qctx_assign() already uses aq->lock for
rq/sq/cq, should all six pointers use that one lock?

>  static void nix_ctx_free(struct rvu *rvu, struct rvu_pfvf *pfvf)
>  {
> -	kfree(pfvf->rq_bmap);
> -	kfree(pfvf->sq_bmap);
> -	kfree(pfvf->cq_bmap);
> -	if (pfvf->rq_ctx)
> -		qmem_free(rvu->dev, pfvf->rq_ctx);
> -	if (pfvf->sq_ctx)
> -		qmem_free(rvu->dev, pfvf->sq_ctx);
> -	if (pfvf->cq_ctx)
> -		qmem_free(rvu->dev, pfvf->cq_ctx);
> -	if (pfvf->rss_ctx)
> -		qmem_free(rvu->dev, pfvf->rss_ctx);
> -	if (pfvf->nix_qints_ctx)
> -		qmem_free(rvu->dev, pfvf->nix_qints_ctx);
> -	if (pfvf->cq_ints_ctx)
> -		qmem_free(rvu->dev, pfvf->cq_ints_ctx);
> +	struct admin_queue *aq = rvu->hw->block[pfvf->nix_blkaddr].aq;
> +	unsigned long *rq_bmap, *sq_bmap, *cq_bmap;
> +	struct qmem *rq_ctx, *sq_ctx, *cq_ctx;
> +	struct qmem *rss_ctx, *nix_qints_ctx, *cq_ints_ctx;
> +	unsigned long flags;
> +
> +	if (!aq)
> +		return;

[Severity: Medium]

Does this early return skip the frees?  Previously nix_ctx_free() released
the three bitmaps and all six qmem allocations unconditionally; now nothing
is freed when rvu->hw->block[pfvf->nix_blkaddr].aq is NULL.  Is aq
guaranteed non-NULL for every caller of nix_ctx_free(), including the
teardown path for a NIX block with no admin queue?

> +
> +	spin_lock_irqsave(&aq->lock, flags);
> +	rq_bmap = pfvf->rq_bmap;
> +	sq_bmap = pfvf->sq_bmap;
> +	cq_bmap = pfvf->cq_bmap;
> +	rq_ctx = pfvf->rq_ctx;
> +	sq_ctx = pfvf->sq_ctx;
> +	cq_ctx = pfvf->cq_ctx;
> +	rss_ctx = pfvf->rss_ctx;
> +	nix_qints_ctx = pfvf->nix_qints_ctx;
> +	cq_ints_ctx = pfvf->cq_ints_ctx;
>  
>  	pfvf->rq_bmap = NULL;
> -	pfvf->cq_bmap = NULL;
>  	pfvf->sq_bmap = NULL;
> +	pfvf->cq_bmap = NULL;
>  	pfvf->rq_ctx = NULL;
>  	pfvf->sq_ctx = NULL;
>  	pfvf->cq_ctx = NULL;
>  	pfvf->rss_ctx = NULL;
>  	pfvf->nix_qints_ctx = NULL;
>  	pfvf->cq_ints_ctx = NULL;
> +	spin_unlock_irqrestore(&aq->lock, flags);
> +
> +	kfree(rq_bmap);
> +	kfree(sq_bmap);
> +	kfree(cq_bmap);

[Severity: High]

This is a pre-existing race, not introduced by this patch, but the new
convention here makes the bitmap users look protected when they are not.

rvu_nix_blk_aq_enq_inst() validates the context pointer *before* it takes
aq->lock:

	case NIX_AQ_CTYPE_RQ:
		if (!pfvf->rq_ctx || req->qidx >= pfvf->rq_ctx->qsize)
			rc = NIX_AF_ERR_AQ_ENQUEUE;

and then, inside the lock, dereferences the bitmap:

		if (req->ctype == NIX_AQ_CTYPE_RQ && req->rq.ena)
			__set_bit(req->qidx, pfvf->rq_bmap);

If an FLR runs __rvu_flr_handler() -> rvu_nix_lf_teardown() ->
nix_ctx_free() on rvu->flr_wq while that mailbox message is in flight, the
pointer is NULLed under aq->lock and the bitmap is kfree()d right after the
unlock, so the __set_bit() is either a write through NULL or a write to
freed memory.

nix_lf_hwctx_disable() also reads pfvf->cq_ctx->qsize and caches the bmap
pointer with no lock, and cn20k/mbox_init.c:rvu_alloc_cint_qint_mem() still
assigns pfvf->cq_ints_ctx and pfvf->nix_qints_ctx directly rather than going
through nix_ctx_assign().  Should those accessors be converted in the same
patch that introduces the convention, so the pointer is fetched under the
lock that now guards it?

> +	if (rq_ctx)
> +		qmem_free(rvu->dev, rq_ctx);
> +	if (sq_ctx)
> +		qmem_free(rvu->dev, sq_ctx);
> +	if (cq_ctx)
> +		qmem_free(rvu->dev, cq_ctx);
> +	if (rss_ctx)
> +		qmem_free(rvu->dev, rss_ctx);
> +	if (nix_qints_ctx)
> +		qmem_free(rvu->dev, nix_qints_ctx);
> +	if (cq_ints_ctx)
> +		qmem_free(rvu->dev, cq_ints_ctx);
>  }
>  
>  static int nixlf_rss_ctx_init(struct rvu *rvu, int blkaddr,
> @@ -946,6 +990,7 @@ static int nixlf_rss_ctx_init(struct rvu *rvu, int blkaddr,
>  			      int rss_sz, int rss_grps, int hwctx_size,
>  			      u64 way_mask, bool tag_lsb_as_adder)
>  {
> +	struct qmem *rss_ctx;
>  	int err, grp, num_indices;
>  	u64 val;
>  
> @@ -955,12 +1000,12 @@ static int nixlf_rss_ctx_init(struct rvu *rvu, int blkaddr,
>  	num_indices = rss_sz * rss_grps;
>  
>  	/* Alloc NIX RSS HW context memory and config the base */
> -	err = qmem_alloc(rvu->dev, &pfvf->rss_ctx, num_indices, hwctx_size);
> +	err = qmem_alloc(rvu->dev, &rss_ctx, num_indices, hwctx_size);
>  	if (err)
>  		return err;

[Severity: Medium]

Does this leak the struct qmem descriptor when qmem_alloc() fails halfway?
qmem_alloc() publishes the devm_kzalloc()'d descriptor into *q before it
tries the DMA allocation:

af/common.h:qmem_alloc() {
	*q = devm_kzalloc(dev, sizeof(*qmem), GFP_KERNEL);
	if (!*q)
		return -ENOMEM;
	qmem = *q;
	...
	qmem->base = dma_alloc_attrs(dev, qmem->alloc_sz, &qmem->iova,
				     GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
	if (!qmem->base)
		return -ENOMEM;
}

so on dma_alloc_attrs() failure it returns -ENOMEM with a live descriptor
in the caller's pointer.  Before the patch that pointer was
&pfvf->rss_ctx, so nix_ctx_free() -> qmem_free() -> devm_kfree() released
it.  Now the descriptor is only in the local rss_ctx and the function
returns before nix_ctx_assign() publishes it, so nothing frees it until the
AF driver is unbound.

The same applies to the five sites in rvu_mbox_handler_nix_lf_alloc()
(rq_ctx, sq_ctx, cq_ctx, cq_ints_ctx, nix_qints_ctx): they goto free_mem,
and nix_ctx_free() only frees the pfvf->* pointers, which are still NULL.
Should these paths call qmem_free() on the local pointer, as the kcalloc()
failure paths already do?

>  
>  	rvu_write64(rvu, blkaddr, NIX_AF_LFX_RSS_BASE(nixlf),
> -		    (u64)pfvf->rss_ctx->iova);
> +		    (u64)rss_ctx->iova);
>  

[ ... ]

> @@ -974,6 +1019,8 @@ static int nixlf_rss_ctx_init(struct rvu *rvu, int blkaddr,
>  	for (grp = 0; grp < rss_grps; grp++)
>  		rvu_write64(rvu, blkaddr, NIX_AF_LFX_RSS_GRPX(nixlf, grp),
>  			    ((ilog2(rss_sz) - 1) << 16) | (rss_sz * grp));
> +
> +	nix_ctx_assign(rvu, &pfvf->rss_ctx, rss_ctx);
>  	return 0;
>  }
>  

[ ... ]

> @@ -1584,59 +1634,68 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>  
>  	/* Alloc NIX RQ HW context memory and config the base */
>  	hwctx_size = 1UL << ((ctx_cfg >> 4) & 0xF);
> -	rc = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
> +	rc = qmem_alloc(rvu->dev, &rq_ctx, req->rq_cnt, hwctx_size);
>  	if (rc)
>  		goto free_mem;
>  
> -	pfvf->rq_bmap = kcalloc(req->rq_cnt, sizeof(long), GFP_KERNEL);
> -	if (!pfvf->rq_bmap) {
> +	rq_bmap = kcalloc(req->rq_cnt, sizeof(long), GFP_KERNEL);
> +	if (!rq_bmap) {
> +		qmem_free(rvu->dev, rq_ctx);
>  		rc = -ENOMEM;
>  		goto free_mem;
>  	}

[ ... ]

> @@ -1649,29 +1708,33 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>  	cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST2);
>  	qints = (cfg >> 24) & 0xFFF;
>  	hwctx_size = 1UL << ((ctx_cfg >> 24) & 0xF);
> -	rc = qmem_alloc(rvu->dev, &pfvf->cq_ints_ctx, qints, hwctx_size);
> +	rc = qmem_alloc(rvu->dev, &cq_ints_ctx, qints, hwctx_size);
>  	if (rc)
>  		goto free_mem;
>  
>  	rvu_write64(rvu, blkaddr, NIX_AF_LFX_CINTS_BASE(nixlf),
> -		    (u64)pfvf->cq_ints_ctx->iova);
> +		    (u64)cq_ints_ctx->iova);
>  
>  	rvu_write64(rvu, blkaddr, NIX_AF_LFX_CINTS_CFG(nixlf),
>  		    BIT_ULL(36) | req->way_mask << 20);
>  
> +	nix_ctx_assign(rvu, &pfvf->cq_ints_ctx, cq_ints_ctx);
> +

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 60922944675b6..c115601b1212d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -3545,6 +3545,46 @@ int rvu_mbox_handler_npc_mcam_free_entry(struct rvu *rvu,
>  	return rc;
>  }
>  
> +int rvu_mbox_handler_npc_flow_del_n_free(struct rvu *rvu,
> +					 struct npc_flow_del_n_free_req *mreq,
> +					 struct msg_rsp *rsp)
> +{

[ ... ]

> +	for (i = 0; i < cnt; i++) {
> +		dreq.entry = entry[i];
> +		rvu_mbox_handler_npc_delete_flow(rvu, &dreq, &drsp);
> +
> +		sreq.entry = entry[i];
> +		ret = rvu_mbox_handler_npc_mcam_free_entry(rvu, &sreq, rsp);
> +		if (ret) {
> +			dev_err(rvu->dev, "free entry error for i=%d entry=%d\n",
> +				i, entry[i]);
> +			err = true;
> +		}
> +	}

[Severity: Medium]

Should this print be ratelimited?  cnt comes from the request and can be up
to 256, and rvu_mbox_handler_npc_mcam_free_entry() returns an error for
every entry the requester does not own (npc_mcam_verify_entry()), so one
NPC_MCAM_FLOW_DEL_N_FREE message from any PF/VF can emit 256 dev_err()
lines, repeatable in a loop.

The cnt validation a few lines above already uses dev_err_ratelimited().
Would dev_err_ratelimited() or dev_dbg() be better here too?

> +
> +	return err ? -EINVAL : 0;
> +}
> +

[ ... ]

> @@ -4444,6 +4484,81 @@ int rvu_mbox_handler_npc_mcam_entry_stats(struct rvu *rvu,
>  	return 0;
>  }
>  
> +int rvu_mbox_handler_npc_mcam_mul_stats(struct rvu *rvu,
> +					struct npc_mcam_get_mul_stats_req *req,
> +					struct npc_mcam_get_mul_stats_rsp *rsp)
> +{

[ ... ]

> +	for (i = 0; i < req_cnt; i++) {
> +		mcam_entry = npc_cn20k_vidx2idx(entry[i]);
> +
> +		if (npc_mcam_verify_entry(mcam, pcifunc, mcam_entry)) {
> +			mutex_unlock(&mcam->lock);
> +			dev_err(rvu->dev, "%s invalid mcam index=%d\n",
> +				__func__, entry[i]);
> +			return -EINVAL;
> +		}

[Severity: Medium]

Same question here: entry[i] is taken straight from the request, so any
PF/VF can drive this dev_err() at will by passing an index it does not own,
while the req_cnt check above uses dev_err_ratelimited().  Could this one be
ratelimited as well?

> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831131944.2649362-1-rkannoth%40marvell.com
