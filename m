Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792471461;
	b=OYqfwPxqo1EjQxO8LqrBUsbuswdS0FN9cA6C5Fc5bHLFfac7izmAbsm0JehxiFOhCLNw
	 fEkU/bS3raA550js3z6t75OzDznF2vBA+c6pZbk/MqxIBxpsnqdlk8uUF5y0MQCi8b10G
	 Tz/JpQk79QRiD/odb3IcTSXyJJUVGUewH38UPZDfsC0Vp1jXCQEsfjhDanmDORG2mQJQT
	 szb2FXtZjjaBf3ysM9PQYIps1zQo1/rBlfSjxjmWhrBPJh0qwUwiGItR/fNzQReX9Q0Bt
	 ofdFYhnvHYjgampYQjq0hS4IO5PRmKLmq1maQR26IaFZuw3AoezOIjPfuEuh7FgsU7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792471461;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oR7uzyBpMNwI6X7z2Y0P1yUUeL+pme9C2U3YKbHPOfg=;
	b=thfkaC5Gsmv9VGE7KLb/t3FYx3nscmbELFl6ErHqeidyquDKql9cjz3l93j6ExK81rtH
	 C9F+ojfP6bRk1JbDzZq3FhIZFAx4gNEk4e2B0HBOkcF8hSjlx08St2SEVw547nGpH9xrx
	 39LHpBpyhwXF1M1f1MEG9piBU9r9iHSrK3VJ6YJFtyipGOEjP+7/dP6EbJn2H8WU0Yezy
	 DVBELL2ccJd/a/groRg5e77gunA3CVXRI0ZF0SMyzcJonvcCd0mHAVnQEunfof553zX/v
	 54ZPKQaB2x8eab6XsyPk6BigpnnfpUTSgJZjwcb6XRYrIW5MJ6i4vMo/+pbfZ9Dr21w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mLm/ZILl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F301606A31A;
	Tue, 20 Oct 2026 04:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLm/ZILl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F4F1F000C4;
	Tue, 20 Oct 2026 04:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792471460;
	bh=oR7uzyBpMNwI6X7z2Y0P1yUUeL+pme9C2U3YKbHPOfg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mLm/ZILlidR5jCgVwenn9hsRNl5zYnHvXTIOUwYrpCaoQj96aDOQJIrOL7zXd2+ZR
	 oKV8rp59xznXmgz9Hya/29FyucoNcdpJMba1nBjutPApWyMcCFXpC8OotgHQi0DieQ
	 wirrHS/knnEM1XJe97zhzKYJhZvol1moYh8uNJz82/w5sPZNiSvoNq+NslblcTht5z
	 SQgugZcFyktT3ItQL75402aO/qcoE7KVOBqqK0mtM7yjAsk4A2gIazIhNX88EcVRLd
	 jMZ75NICsy7+rlr1KLrkd8C034mhsYveVEKIinT1jYA0fmsI0bOkiWjF3WwpWkLw0b
	 INA/y16BZi70g==
Subject: Re: [PATCH v3 net-next] octeontx2-af: Add couple of mailbox support.
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com
Date: Tue, 20 Oct 2026 04:44:18 +0000
Message-ID: <179247145899.3135.11261244321537828324@kernel.org>
In-Reply-To: <20261016041925.3287196-1-rkannoth@marvell.com>
References: <20261016041925.3287196-1-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 1 (2) · Medium: 6 (4) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] rvu_mbox_handler_nix_lf_alloc() still reads
  req->rq_cnt/sq_cnt/cq_cnt several times straight from peer-writable…
- [Medium] The commit message does not describe several behaviour changes
  to existing code.
- [Medium] nix_get_tx_link() now has is_rep_dev() in its LBK branch, so
  for the representor PF it returns hw->cgx_links (LBK link 0) where it…
- [Medium] rvu_mbox_handler_npc_delete_flow() (NPC_DELETE_FLOW, an
  existing mbox message used by the in-tree otx2 PF/VF driver) now…
- [Medium] The patch adds four AF mbox messages (IFACE_GET_INFO 0x014,
  NPC_MCAM_FLOW_DEL_N_FREE 0x6020, NPC_MCAM_GET_MUL_STATS 0x6022,…
- [Medium] rvu_mbox_handler_iface_get_info() fills info->tx_link from
  nix_get_tx_link(), which returns hw->cgx_links for every LBK VF and…
- [Medium] IFACE_GET_INFO uses `pfvf->tx_chan_cnt != 0` as its only
  liveness test, but some paths that remove a NIX LF never clear it.
- [Low] rvu_mbox_handler_iface_get_info() sets truncated = true as soon
  as tot reaches IFACE_MAX and the loop visits another PF or VF index.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is High
  severity.
- [High] This problem wasn't introduced by this patch, but it is High
  severity.
- [Medium] This problem wasn't introduced by this patch, but the patch
  makes it more visible.
- [Medium] This problem wasn't introduced by this patch, but the patch
  exposes it.
- [Medium] This problem wasn't introduced by this patch.
- [Medium] This problem wasn't introduced by this patch.

--

octeontx2-af: Add couple of mailbox support.

This patch adds four AF mailbox handlers. IFACE_GET_INFO lets a switch PF
query the PF/VF NIX topology, and three NPC handlers cover batch flow
delete/free, batch MCAM stats and an NPC feature query. It also publishes
NIX queue contexts under the AQ lock and channel bases/counts under
rsrc_lock, clears channel counts on NIX LF free/teardown, and makes
nix_get_tx_link() non-static.

> Add IFACE_GET_INFO and NPC batch flow/stats/features handlers for the
> RVU PFs, with synchronized NIX context and channel publishing.

[Severity: Medium]
The committed body is this one sentence, but the patch also changes how
several existing paths behave:

- rvu_mbox_handler_npc_delete_flow() now returns -EINVAL when a rule
  deletion fails. It used to always return 0.
- nix_get_tx_link() now returns hw->cgx_links for the representor PF
  instead of the SDP link.
- NIX_LF_FREE, rvu_nix_lf_teardown() and the NIX_LF_ALLOC free_dft path
  now zero rx_chan_cnt/tx_chan_cnt. A failed NIX_LF_ALLOC therefore reports
  zero channel counts in its response.
- NIX_LF_ALLOC for the representor now sets rx_chan_base and rx_chan_cnt
  to 0.
- nix_ctx_free() and the context allocation in
  rvu_mbox_handler_nix_lf_alloc() are restructured.

The only explanation is in the v1->v2 and v2->v3 notes below the "---"
line, and git am drops those.

Could the commit message describe these changes? Alternatively, could
some of them go into separate patches?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index cece197d1074b..28f2b549780f3 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -164,6 +164,8 @@ M(PTP_GET_CAP,		0x00c, ptp_get_cap, msg_req, ptp_get_cap_rsp)	\
>  M(GET_REP_CNT,		0x00d, get_rep_cnt, msg_req, get_rep_cnt_rsp)	\
>  M(ESW_CFG,		0x00e, esw_cfg, esw_cfg_req, msg_rsp)	\
>  M(REP_EVENT_NOTIFY,     0x00f, rep_event_notify, rep_event, msg_rsp) \
> +M(IFACE_GET_INFO,	0x014, iface_get_info, msg_req,	\
> +				iface_get_info_rsp)			\

[Severity: Medium]
Nothing in the tree seems to send these four new messages
(IFACE_GET_INFO, NPC_MCAM_FLOW_DEL_N_FREE, NPC_MCAM_GET_MUL_STATS and
NPC_MCAM_GET_FEATURES) or use PCI_DEVID_PAN_RVU. Grepping
drivers/net/ethernet/marvell/ finds only the definitions in mbox.h and
rvu.h and the AF handlers.

IFACE_GET_INFO is only allowed when the requesting PF's device ID is
0xA0E2, and no upstream driver binds to that ID.

Which in-tree driver is expected to send these messages?

The commit message also says the handlers are "for the RVU PFs". In fact
IFACE_GET_INFO is limited to that one switch PF type, while every PF and
VF can call the NPC handlers. Could that be clarified?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 30e148291581c..055e39746558a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -1990,6 +1990,165 @@ int rvu_mbox_handler_msix_offset(struct rvu *rvu, struct msg_req *req,

[ ... ]

> +int rvu_mbox_handler_iface_get_info(struct rvu *rvu, struct msg_req *req,
> +				    struct iface_get_info_rsp *rsp)
> +{

[ ... ]

> +	if (!rvu_is_switch_pcifunc(rvu, req->hdr.pcifunc))
> +		return -EPERM;

[Severity: Medium]
This is a pre-existing issue, but this new permission check depends on
req->hdr.pcifunc, which lives in the peer-writable mailbox.
__rvu_mbox_handler() fixes the sender identity in place:

    msg->pcifunc &= rvu_pcifunc_pf_mask(rvu->pdev);
    msg->pcifunc |= rvu_make_pcifunc(rvu->pdev, devid, 0);

otx2_mbox_init() sets mdev->mbase to the hardware mailbox itself, so the
handler runs on the shared buffer.

Suppose a peer keeps rewriting hdr.pcifunc after the AF has fixed it.
Can it then pass rvu_is_switch_pcifunc() and read the full PF/VF
topology?

Rewriting it to pcifunc 0 would also make npc_mcam_verify_entry() in
NPC_MCAM_GET_MUL_STATS skip its bounds and ownership checks. The existing
rvu_mbox_handler_npc_mcam_entry_stats() doesn't verify entries at all,
though.

[ ... ]

> +	mutex_lock(&rvu->rsrc_lock);
> +	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
> +		if (tot >= IFACE_MAX) {
> +			truncated = true;
> +			goto done;
> +		}

[Severity: Low]
Can truncated be set when nothing was dropped? The tot >= IFACE_MAX check
runs at the top of both the PF loop and the VF loop, before the enabled,
admin and tx_chan_cnt checks.

If exactly IFACE_MAX live interfaces fill rsp->info[] and the remaining
indexes are disabled or have no NIX LF, the reply is still marked
truncated.

[ ... ]

> +		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
> +		pfvf = rvu_get_pfvf(rvu, pcifunc);
> +
> +		/* Populate iff at least one Tx channel */
> +		if (!pfvf->tx_chan_cnt)
> +			goto chk_vfs;

[Severity: Medium]
Can tx_chan_cnt still be non-zero after the NIX LF is gone? The patch
clears it in NIX_LF_FREE, in rvu_nix_lf_teardown() and on the free_dft
path. It is not cleared on this path:

rvu_mbox_handler_detach_resources()
  rvu_detach_rsrcs()
    rvu_detach_block(BLKTYPE_NIX)

It is also not cleared on the implicit detach in ATTACH_RESOURCES without
modify. rvu_detach_block() disables and frees the LF but never touches
rx_chan_cnt/tx_chan_cnt.

The free_mem label in rvu_mbox_handler_nix_lf_alloc() skips the clear
too. A repeated NIX_LF_ALLOC that fails in qmem_alloc() or kcalloc()
therefore leaves the counts from the earlier allocation in place.

After either path, would IFACE_GET_INFO keep listing the function with
stale channels, tx_link, NIX block and queue counts?

[ ... ]

> +chk_vfs:
> +		for (vf = 0; vf < numvfs; vf++) {

[ ... ]

> +			info->is_vf = 1;
> +			info->pcifunc = pcifunc;
> +			info->rx_chan_base = pfvf->rx_chan_base;
> +			info->rx_chan_cnt = pfvf->rx_chan_cnt;
> +			info->tx_chan_base = pfvf->tx_chan_base;
> +			info->tx_chan_cnt = pfvf->tx_chan_cnt;
> +			info->tx_link = nix_get_tx_link(rvu, pcifunc);

[Severity: Medium]
Is this the link the LBK VF was actually given? In NIX_LF_ALLOC,
nix_interface_init() returns this to the VF:

    rsp->tx_link = hw->cgx_links + lbkid;

lbkid is "vf & 0x1 ? 0 : 1" when hw->lbk_links > 1, and
NIX_LF_LBK_BLK_SEL inverts it. nix_get_tx_link() returns hw->cgx_links
for every LBK VF and ignores pfvf->lbkid.

So on silicon with more than one LBK link, every AF VF with lbkid == 1
is reported on a different TX link from the one it programs into
NIX_AF_TL3_TL2X_LINKX_CFG.

The v2 changelog says pfvf->lbkid is now set before
nix_interface_set_chan() so this handler can read it, but the handler
never reads it. Should LBK VFs report hw->cgx_links + pfvf->lbkid here?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index d04540420bca9..32f824bf03b2a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c

[ ... ]

> @@ -920,33 +936,114 @@ static void nix_setup_lso(struct rvu *rvu, struct nix_hw *nix_hw, int blkaddr)
>  	nix_hw->lso.in_use++;
>  }
>  
> +static int nix_qctx_assign(struct rvu *rvu, int blkaddr, struct qmem **ctx,
> +			   unsigned long **bmap, struct qmem *new_ctx,
> +			   unsigned long *new_bmap)
> +{
> +	struct admin_queue *aq = rvu->hw->block[blkaddr].aq;
> +	unsigned long flags;
> +
> +	if (!aq) {
> +		WARN_ON_ONCE(1);
> +		return -ENODEV;
> +	}
> +
> +	spin_lock_irqsave(&aq->lock, flags);
> +	*ctx = new_ctx;
> +	*bmap = new_bmap;
> +	spin_unlock_irqrestore(&aq->lock, flags);

[Severity: High]
This isn't a bug introduced by this patch, but nix_qctx_assign() and
nix_ctx_assign() overwrite pfvf->rq_ctx, rq_bmap and the other context
pointers without freeing the old ones. qmem_alloc(&pfvf->rq_ctx) did the
same before the patch. rvu_mbox_handler_nix_lf_alloc() only checks:

    if (!pfvf->nixlf || blkaddr < 0)
        return NIX_AF_ERR_AF_LF_INVALID;

It never checks whether contexts are already allocated.

If a PF or VF sends NIX_LF_ALLOC repeatedly without NIX_LF_FREE, does
each call leak the previous DMA context buffers, qmem structs and
bitmaps?

NIX_LF_FREE and teardown only free the latest set. The requester also
chooses the size of each leak through rq_cnt, sq_cnt and cq_cnt.

[ ... ]

>  static void nix_ctx_free(struct rvu *rvu, struct rvu_pfvf *pfvf)
>  {

[ ... ]

> +	spin_lock_irqsave(&aq->lock, flags);
> +	rq_bmap = pfvf->rq_bmap;

[ ... ]

>  	pfvf->cq_ints_ctx = NULL;
> +	spin_unlock_irqrestore(&aq->lock, flags);
> +
> +free_ctx:
> +	kfree(rq_bmap);

[Severity: High]
This isn't a bug introduced by this patch, but the main reader of these
pointers doesn't follow the new locking. rvu_nix_blk_aq_enq_inst()
validates before it takes aq->lock:

    if (!pfvf->rq_ctx || req->qidx >= pfvf->rq_ctx->qsize)
        rc = NIX_AF_ERR_AQ_ENQUEUE;
    ...
    spin_lock(&aq->lock);
    ...
    __set_bit(req->qidx, pfvf->rq_bmap);

The SQ and CQ cases follow the same pattern, and none of them check the
bitmap again under the lock.

FLR teardown runs from rvu->flr_wq, which is separate from the mbox
workqueue, and it only takes flr_lock. Suppose nix_ctx_free() runs there
while an AF VF's NIX_AQ_ENQ is in flight. Can the reader then read qsize
from a freed qmem? Can it call __set_bit() on a NULL bitmap, or on a
smaller bitmap from a new allocation?

The debugfs print_nix_qsize() also reads these pointers without the lock.
So the "synchronized NIX context publishing" seems to protect only the
new IFACE_GET_INFO reader.

[ ... ]

> @@ -1583,59 +1693,92 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>  
>  	/* Alloc NIX RQ HW context memory and config the base */
>  	hwctx_size = 1UL << ((ctx_cfg >> 4) & 0xF);
> -	rc = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
> -	if (rc)
> +	rc = qmem_alloc(rvu->dev, &rq_ctx, req->rq_cnt, hwctx_size);
> +	if (rc) {
> +		qmem_free(rvu->dev, rq_ctx);
>  		goto free_mem;
> +	}
>  
> -	pfvf->rq_bmap = kcalloc(req->rq_cnt, sizeof(long), GFP_KERNEL);
> -	if (!pfvf->rq_bmap) {
> +	rq_bmap = kcalloc(req->rq_cnt, sizeof(long), GFP_KERNEL);
> +	if (!rq_bmap) {
> +		qmem_free(rvu->dev, rq_ctx);
>  		rc = -ENOMEM;
>  		goto free_mem;
>  	}
>  
>  	rvu_write64(rvu, blkaddr, NIX_AF_LFX_RQS_BASE(nixlf),
> -		    (u64)pfvf->rq_ctx->iova);
> +		    (u64)rq_ctx->iova);
>  
>  	/* Set caching and queue count in HW */
>  	cfg = BIT_ULL(36) | (req->rq_cnt - 1) | req->way_mask << 20;
>  	rvu_write64(rvu, blkaddr, NIX_AF_LFX_RQS_CFG(nixlf), cfg);
>  
> +	rc = nix_qctx_assign(rvu, blkaddr, &pfvf->rq_ctx, &pfvf->rq_bmap,
> +			     rq_ctx, rq_bmap);

[Severity: High]
This code reads req->rq_cnt several times, straight from the mailbox.
__rvu_mbox_handler() passes msg = mdev->mbase + offset, and
otx2_mbox_init() sets mbase to hwbase, so the request is never copied.

qmem_alloc() sets rq_ctx->qsize from one read and kcalloc() sizes
rq_bmap from another. NIX_AF_LFX_RQS_CFG is written from a third.
sq_cnt and cq_cnt are handled the same way.

If the peer changes rq_cnt between reads, can qsize end up larger than
the bitmap? Or can the bitmap become ZERO_SIZE_PTR when the second read
sees 0, which passes the !rq_bmap check? nix_qctx_assign() then publishes
both pointers together.

The new rvu_iface_get_qcnts() relies on the two sizes matching:

    /* Use each LF queue context size; bitmaps are sized to qsize longs. */
    if (pfvf->rq_ctx && pfvf->rq_bmap)
        info->rq_cnt = bitmap_weight(pfvf->rq_bmap, pfvf->rq_ctx->qsize);

Would this read past the slab object and return the popcount of
neighbouring heap memory to the switch PF, or oops on ZERO_SIZE_PTR?

The same mismatch also reaches the existing
__set_bit(req->qidx, pfvf->rq_bmap) in rvu_nix_blk_aq_enq_inst(), which
only checks qidx against qsize.

The v3 changelog says "the request counts are re-read from peer-writable
mailbox memory", and the new NPC handlers already copy their input
first. Could rq_cnt, sq_cnt and cq_cnt also be read once into locals
here?

[ ... ]

> @@ -1710,8 +1869,8 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>  	}
>  
>  	if (is_rep_dev(rvu, pcifunc)) {
> -		pfvf->tx_chan_base = RVU_SWITCH_LBK_CHAN;
> -		pfvf->tx_chan_cnt = 1;
> +		nix_interface_set_chan(rvu, pfvf, 0, 0,
> +				       RVU_SWITCH_LBK_CHAN, 1);
>  		goto exit;
>  	}

[Severity: Medium]
This is a pre-existing issue, but this patch makes it more visible. The
representor still jumps to exit before nix_interface_init(), so
rsp->tx_link is never set and stays 0. The rep driver copies it in
mbox_handler_nix_lf_alloc():

    pfvf->hw.tx_link = rsp->tx_link;

otx2_txschq_config() then programs NIX_AF_TL3_TL2X_LINKX_CFG(schq, 0),
which is CGX0/LMAC0.

After this patch, nix_get_tx_link() returns hw->cgx_links for the rep.
That is the value TL1 allocation uses and the value IFACE_GET_INFO
reports.

Should rsp->tx_link be set to the same value here? That way NIX_LF_ALLOC
and IFACE_GET_INFO would agree on the rep's TX link, and its TL2 link
config would match the AF's view.

[ ... ]

> @@ -2108,15 +2270,16 @@ static void nix_clear_tx_xoff(struct rvu *rvu, int blkaddr,
>  	rvu_write64(rvu, blkaddr, reg, 0x0);
>  }
>  
> -static int nix_get_tx_link(struct rvu *rvu, u16 pcifunc)
> +int nix_get_tx_link(struct rvu *rvu, u16 pcifunc)
>  {
> -	struct rvu_hwinfo *hw = rvu->hw;
>  	int pf = rvu_get_pf(rvu->pdev, pcifunc);
> +	struct rvu_hwinfo *hw = rvu->hw;
>  	u8 cgx_id = 0, lmac_id = 0;
>  
> -	if (is_lbk_vf(rvu, pcifunc)) {/* LBK links */
> +	if (is_lbk_vf(rvu, pcifunc) || is_rep_dev(rvu, pcifunc))
>  		return hw->cgx_links;
> -	} else if (is_pf_cgxmapped(rvu, pf)) {
> +
> +	if (is_pf_cgxmapped(rvu, pf)) {

[Severity: Medium]
Adding is_rep_dev() here moves the representor from the SDP link
(hw->cgx_links + hw->lbk_links) to LBK link 0. nix_get_tx_link() drives
the actual TX scheduler programming, not only the value IFACE_GET_INFO
reports:

- rvu_mbox_handler_nix_txsch_alloc() uses start = end = link at the
  aggregation level. The rep's TL1 therefore becomes the LBK0 TL1 that
  the AF LBK VFs share.
- nix_tl1_default_cfg() writes TL1 TOPOLOGY, SCHEDULE and CIR to
  schq = nix_get_tx_link(rvu, pcifunc).
- is_valid_txschq() treats matching links as permission at the
  aggregation level, so the rep can now reconfigure LBK0's TL1.
- When the rep is freed, nix_txschq_free() clears SW_XOFF and CFG_DONE
  on LBK0's TL1 while the LBK VFs are still using it.

nix_get_txschq_range() already treated the rep as LBK, so this may fix
an existing inconsistency.

Is it intended that the rep shares LBK0's TL1 with the LBK VFs? If so,
could this go into a separate patch with a Fixes: tag and an explanation
in the commit message?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 42a601976db36..e5f7cb7464983 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -3545,6 +3545,53 @@ int rvu_mbox_handler_npc_mcam_free_entry(struct rvu *rvu,

[ ... ]

> +	for (i = 0; i < cnt; i++) {
> +		dreq.entry = entry[i];
> +		ret = rvu_mbox_handler_npc_delete_flow(rvu, &dreq, &drsp);

[Severity: Medium]
This isn't a bug introduced by this patch, but this new batch path also
reaches an existing leak in rvu_mbox_handler_npc_delete_flow(). Default
rules owned by the requester are moved onto the del_list on the stack:

    list_move_tail(&iter->list, &del_list);

npc_delete_flow() then returns early for them, without list_del() or
kfree():

    if (rule->default_rule)
        return 0;

A PF can own a VF's default rule record after NPC_INSTALL_FLOW with
default_rule set. npc_install_flow() sets rule->owner = owner, for
example on the set-VF-MAC path.

After a PF delete-all, or a single matching entry sent through
NPC_MCAM_FLOW_DEL_N_FREE, is that rule leaked? It would still be linked
to a list head in a stack frame that no longer exists, list-based
teardown would not find it, and pfvf->def_ucast_rule would still point
to it.

[ ... ]

> @@ -4444,6 +4491,91 @@ int rvu_mbox_handler_npc_mcam_entry_stats(struct rvu *rvu,

[ ... ]

> +		if (rvu->hw->npc_stat_ena == BIT_ULL(63)) {
> +			/* cn10k: STAT_SEL is [11:0] */
> +			cntr = regval & 0xFFF;
> +		} else {
> +			cntr = regval & 0x1FF;
> +			/* 98xx: STAT_SEL_EXT is [14:12] */
> +			if (rvu->hw->npc_ext_set)
> +				cntr |= ((regval >> 12) & 0x7) << 9;
> +		}

[Severity: Medium]
This is a pre-existing issue, but the existing single-entry handler
still uses the decode that the v3 changelog calls wrong.
rvu_mbox_handler_npc_mcam_entry_stats() does:

    cntr = regval & 0x1FF;

npc_map_mcam_entry_and_cntr() encodes the counter like this:

    ((cntr >> 9) << 12) | hw->npc_stat_ena | cntr);

For counters of 512 and above on cn10k or 98xx, does NPC_MCAM_GET_STATS
(used by nic/otx2_tc.c) read NPC_AF_MATCH_STATX() of a different counter,
maybe one that belongs to another function?

Could rvu_mbox_handler_npc_mcam_entry_stats() use the same decode as the
new handler, so the two handlers agree?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index ec004ea5154cb..bc66d5c9a659f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c

[ ... ]

> @@ -1969,17 +1983,20 @@ int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
>  	}
>  	mutex_unlock(&mcam->lock);
>  
> +	err = 0;
>  	list_for_each_entry_safe(iter, tmp, &del_list, list) {
>  		u16 entry = iter->entry;
>  
>  		/* clear the mcam entry target pcifunc */
>  		mcam->entry2target_pffunc[entry] = 0x0;
> -		if (npc_delete_flow(rvu, iter, pcifunc))
> +		if (npc_delete_flow(rvu, iter, pcifunc)) {
>  			dev_err(rvu->dev, "rule deletion failed for entry:%u",
>  				entry);
> +			err = -EINVAL;
> +		}
>  	}
>  
> -	return 0;
> +	return err;
>  }

[Severity: Medium]
NPC_DELETE_FLOW is an existing message that the otx2 PF/VF driver uses.
It now returns -EINVAL, but by then npc_delete_flow() has already
unlinked and freed the rule.

In-tree callers act on the new error. otx2_remove_flow() returns before
it drops its own entry:

    if (err)
        return err;

    list_del(&flow->list);
    kfree(flow);

otx2_do_set_vf_vlan() does a goto out after the RX delete fails, so the
TX VLAN rule is never deleted.

Would the PF's flow list then keep an entry whose AF rule is already
gone?

The change is only needed so NPC_MCAM_FLOW_DEL_N_FREE can collect
errors. Could the error go only to the new handler? Otherwise, could the
commit message mention the change to the existing reply?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016041925.3287196-1-rkannoth%40marvell.com
