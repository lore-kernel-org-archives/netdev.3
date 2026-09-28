Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7F4375ADF;
	Mon, 28 Sep 2026 03:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790564470; cv=none; b=Yd8tMR1b1ul/CHH+xRGF4psGW6k73/RxRbh2WH0S1VGf3uaP6sdY/qxy8NIZD+ZqHEv/mkgUPAmEtZGkV8X2KT8KL6yPqhD9cqniIghVKUflVjn2Pt2OnXcxYv0R1dSrrjbLhGmAixsFWxgSuAmZrdkvGoguTN/+kv0yeypc3Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790564470; c=relaxed/simple;
	bh=W3hqJ4qSYnTKObfPRxhvQRlPTxE2bznCpWcRMdtnkDk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RPeC2PzhiCLB65t/RMmwkEjgtwtYbOxQoho4Oyxq553uClQ6Ik2XNBqVHeG2tdD7MmmQqqTik8AxDwlEO7juhoLvLJvn/FQJnNJVLXqydz6Y/KDdgcReKuvliLAMGMsp8N0Iyb+pOPT786ZBN2aLRld0BurG9CuXJND7Q5UBBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGAiax1t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGAiax1t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF2F1F000FF;
	Mon, 28 Sep 2026 03:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790564468;
	bh=PN0P/Vv0c2MpO0YTq/zOreHTdzUIQ0+rv735FxZ8mYI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PGAiax1t3B+/3hColOpAyInC58o05LDlfx1s4i6OGgvS47J6dAOiRuMxQ+MRgKe9A
	 2OU17MO9jRUhOCg4Jz81FK5b0OgtX3gMS2DUy2SdOkwF8v1fFfkDfwntvaSDCB5v32
	 lwVeoe/8tkQXWTFhO2aaZhRGUlMoDrrZA3Y/1nSaf1h5Ns83lPNooWgR/At1HW9A81
	 hXJl+O96N0cqh+RXePebLZ03uTa26hJOJMlF6aMxTArs5/KoXgbqTJu8KPeIEu6cGq
	 m3AliNtTbzrldlSAvUrMskLyIqxHKgMTWT2C+Fd5GUvhUjVf/I1KOfA6hhgywY06Lf
	 tRRwqwc/PtOww==
Subject: Re: [PATCH v2 net-next] octeontx2-af: Add couple of mailbox support.
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com
Date: Mon, 28 Sep 2026 03:01:06 +0000
Message-ID: <179056446689.3145.6845627797649400561@kernel.org>
In-Reply-To: <20260924024446.1851115-1-rkannoth@marvell.com>
References: <20260924024446.1851115-1-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 (1) · High: 1 (4) · Medium: 5 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] rvu_mbox_handler_nix_lf_alloc() now declares the locals `struct
  qmem *rq_ctx, *sq_ctx, *cq_ctx;` without initializing them, and…
- [Medium] The patch rewrites nix_get_tx_link() (rvu_nix.c) and changes
  what it returns for existing users, not only for the new…
- [Medium] IFACE_GET_INFO treats `pfvf->tx_chan_cnt != 0` as meaning the
  interface has a live NIX LF, but the patch clears the channel fields…
- [Medium] In nix_interface_init(), `lbkid = 0; if (rvu->hw->lbk_links >
  1) lbkid = ...; if (loop) lbkid = !lbkid;` sets lbkid=1 even when…
- [Medium] The new rvu_mbox_handler_npc_mcam_mul_stats() decodes the
  counter selector as `cntr = regval & 0x1FF` before reading…
- [Medium] rvu_mbox_handler_nix_lf_free() now calls
  nix_interface_clear_chan(), which sets rx_chan_base to 0.
- [Low] For the representor, nix_get_tx_link() now returns hw->cgx_links,
  and IFACE_GET_INFO reports that value.
- [Low] nix_interface_init() writes pfvf->lbkid without holding
  rsrc_lock, before nix_interface_set_chan().

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but
  __rvu_mbox_handler() sets msg->pcifunc in the peer-writable shared…
- [High] This problem wasn't introduced by this patch, but
  rvu_mbox_handler_nix_lf_alloc() never checks whether…
- [High] This problem wasn't introduced by this patch, but
  rvu_nix_blk_aq_enq_inst() checks `pfvf->rq_ctx && req->qidx <…
- [High] This problem wasn't introduced by this patch, but
  rvu_nix_blk_aq_enq_inst() holds spin_lock(&aq->lock) across…
- [High] This problem wasn't introduced by this patch, but
  __rvu_mbox_handler() computes the next message address as `offset =…
- [Medium] This problem wasn't introduced by this patch, but the existing
  rvu_mbox_handler_npc_mcam_entry_stats() never calls…

--

octeontx2-af: Add couple of mailbox support.

This patch adds an IFACE_GET_INFO mailbox handler for the switch PF. It
also adds NPC handlers for batched flow delete/free, multi-entry stats and
feature queries. NIX channel fields are now published under rsrc_lock and
NIX context pointers under the AQ lock, and nix_get_tx_link() is exported
with new LBK and representor handling.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 30e148291581c..055e39746558a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c

[ ... ]

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
> +	if (!rvu_is_switch_pcifunc(rvu, req->hdr.pcifunc))
> +		return -EPERM;

[Severity: Critical]
This is a pre-existing issue, but this authorization check trusts
req->hdr.pcifunc, and that field is in the shared mailbox, which the peer
can write.

__rvu_mbox_handler() rewrites the header in place and then hands the same
message to the handler:

    msg->pcifunc &= rvu_pcifunc_pf_mask(rvu->pdev);
    msg->pcifunc |= rvu_make_pcifunc(rvu->pdev, devid, 0);

Suppose a PF/VF keeps rewriting pcifunc in its mailbox region after that
read-modify-write. Could the handler then see a forged identity here and
pass the switch-only check?

The new rvu_mbox_handler_npc_flow_del_n_free() has the same problem. It
copies mreq->hdr.pcifunc into its sub-requests. With a forged pcifunc of
0, npc_mcam_verify_entry() returns early:

    if (is_pffunc_af(pcifunc))
        return 0;

That skips both the bounds check and the ownership check. Could an
untrusted function use this to delete or free MCAM entries that belong to
other functions?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 93c5c4b298bf2..26836c243c500 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c

[ ... ]

> @@ -337,6 +336,28 @@ static bool is_valid_txschq(struct rvu *rvu, int blkaddr,
>  	return true;
>  }
>  

[ ... ]

> +static void nix_interface_clear_chan(struct rvu *rvu, struct rvu_pfvf *pfvf)
> +{
> +	mutex_lock(&rvu->rsrc_lock);
> +	pfvf->rx_chan_base = 0;
> +	pfvf->rx_chan_cnt = 0;
> +	pfvf->tx_chan_base = 0;
> +	pfvf->tx_chan_cnt = 0;
> +	mutex_unlock(&rvu->rsrc_lock);
> +}

[Severity: Medium]
Is 0 a safe cleared value for rx_chan_base? Channel 0 is a real hardware
channel. Also, pfvf->nixlf stays attached after NIX_LF_FREE, and the otx2
driver sends NIX_LF_FREE when the interface goes down.

Existing handlers still use rx_chan_base after that. The representor path
in rvu_mbox_handler_npc_install_flow() does:

    if (from_rep_dev)
        req->channel = pfvf->rx_chan_base;

So a flow installed for a representee that is down would match channel 0.
That rule is not rewritten when the LF is allocated again.

nix_bp_enable() and nix_bp_disable() both compute:

    chan_base = pfvf->rx_chan_base + req->chan_base;

and then read-modify-write NIX_AF_RX_CHANX_CFG. With rx_chan_base cleared,
could they program the BPID and the BP enable bit on another interface's
channels? For LBK VFs, nix_bp_disable() would also free the BPID it read
from that other channel.

Before this patch, rx_chan_base kept the function's own channel after
LF_FREE.

[ ... ]

> @@ -410,14 +430,13 @@ static int nix_interface_init(struct rvu *rvu, u16 pcifunc, int type, int nixlf,
>  		 * loopback channels.Therefore if odd number of AF VFs are
>  		 * enabled then the last VF remains with no pair.
>  		 */
> -		pfvf->rx_chan_base = rvu_nix_chan_lbk(rvu, lbkid, vf);
> -		pfvf->tx_chan_base = vf & 0x1 ?
> -					rvu_nix_chan_lbk(rvu, lbkid, vf - 1) :
> -					rvu_nix_chan_lbk(rvu, lbkid, vf + 1);
> -		pfvf->rx_chan_cnt = 1;
> -		pfvf->tx_chan_cnt = 1;
> -		rsp->tx_link = hw->cgx_links + lbkid;
>  		pfvf->lbkid = lbkid;
> +		nix_interface_set_chan(rvu, pfvf,
> +				       rvu_nix_chan_lbk(rvu, lbkid, vf), 1,
> +				       vf & 0x1 ?
> +				       rvu_nix_chan_lbk(rvu, lbkid, vf - 1) :
> +				       rvu_nix_chan_lbk(rvu, lbkid, vf + 1), 1);

[Severity: Low]
pfvf->lbkid is still written outside rsrc_lock here.
rvu_mbox_handler_iface_get_info() reads it under rsrc_lock through
nix_get_tx_link().

AFVF mailbox work and the switch PF's AFPF work don't share a lock.
Suppose an LBK VF sends a second NIX_LF_ALLOC while its channels are
still published (nothing rejects this), and NIX_LF_LBK_BLK_SEL flips
lbkid. Can a concurrent IFACE_GET_INFO then pair the new tx_link with the
old channel values?

[ ... ]

> @@ -912,33 +929,114 @@ static void nix_setup_lso(struct rvu *rvu, struct nix_hw *nix_hw, int blkaddr)
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
This isn't a bug introduced by this patch, but what happens to the old
pfvf->rq_ctx and rq_bmap if a function sends NIX_LF_ALLOC twice without a
NIX_LF_FREE in between? The same question applies to the SQ, CQ, RSS,
CINT and QINT contexts.

rvu_mbox_handler_nix_lf_alloc() only checks:

    if (!pfvf->nixlf || blkaddr < 0)
        return NIX_AF_ERR_AF_LF_INVALID;

These helpers then overwrite the pointers, as the old
qmem_alloc(&pfvf->rq_ctx, ...) calls did. Does each repeated
NIX_LF_ALLOC leak the DMA coherent context buffers and the kcalloc'd
bitmaps? The devm qmem structs are only reclaimed at unbind.

[ ... ]

>  static void nix_ctx_free(struct rvu *rvu, struct rvu_pfvf *pfvf)
>  {

[ ... ]

> +	spin_lock_irqsave(&aq->lock, flags);
> +	rq_bmap = pfvf->rq_bmap;
> +	sq_bmap = pfvf->sq_bmap;
> +	cq_bmap = pfvf->cq_bmap;

[ ... ]

>  	pfvf->rss_ctx = NULL;
>  	pfvf->nix_qints_ctx = NULL;
>  	pfvf->cq_ints_ctx = NULL;
> +	spin_unlock_irqrestore(&aq->lock, flags);
> +
> +free_ctx:
> +	kfree(rq_bmap);
> +	kfree(sq_bmap);
> +	kfree(cq_bmap);

[Severity: High]
This is a pre-existing issue, but the new aq->lock handling only protects
the IFACE_GET_INFO reader. rvu_nix_blk_aq_enq_inst() validates the context
before it takes aq->lock:

    if (!pfvf->rq_ctx || req->qidx >= pfvf->rq_ctx->qsize)
        rc = NIX_AF_ERR_AQ_ENQUEUE;

After nix_aq_enqueue_wait(), it touches the bitmap under aq->lock without
checking again:

    if (req->ctype == NIX_AQ_CTYPE_RQ && req->rq.ena)
        __set_bit(req->qidx, pfvf->rq_bmap);

__rvu_flr_handler() takes only flr_lock, and the AFVF mailbox work takes
no lock. So an FLR teardown can run nix_ctx_free() at the same time. Can
the AQ path then call __set_bit() on a NULL bitmap, or read
rq_ctx->qsize after qmem_free()?

[Severity: High]
This isn't a bug introduced by this patch either, but can
rvu_nix_blk_aq_enq_inst() sleep while holding aq->lock? It holds
spin_lock(&aq->lock) across nix_aq_enqueue_wait(). When the completion
code is CTX_FAULT, LOCKERR or CTX_POISON, that leads to:

nix_aq_enqueue_wait()
  rvu_ndc_fix_locked_cacheline()
    rvu_poll_reg()
      usleep_range(1, 5)

On non-CN20K parts, rvu_poll_reg() sleeps whenever the NDC busy bits are
not already clear.

[ ... ]

> @@ -1504,7 +1612,10 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>  				  struct nix_lf_alloc_req *req,
>  				  struct nix_lf_alloc_rsp *rsp)
>  {
> +	struct qmem *cq_ints_ctx = NULL, *nix_qints_ctx = NULL;
>  	int nixlf, qints, hwctx_size, intf, rc = 0, pf;
> +	unsigned long *rq_bmap, *sq_bmap, *cq_bmap;
> +	struct qmem *rq_ctx, *sq_ctx, *cq_ctx;

[ ... ]

> @@ -1575,59 +1686,92 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
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

[Severity: High]
Can rq_ctx be uninitialized here? qmem_alloc() returns without writing *q
when qsize is 0:

    if (!qsize)
        return -EINVAL;

The handler checks rq_cnt, sq_cnt and cq_cnt for zero at the top.
However, req points into the mailbox, which the peer can write, and the
fields are read again here. That re-read happens after rvu_lf_reset(),
which can poll for around 20ms.

If a PF or AF VF sets the count to 0 in that window, qmem_free() gets an
uninitialized stack pointer. It then passes it to dma_free_attrs() and
devm_kfree().

The same applies to sq_ctx and cq_ctx below. It also applies to rss_ctx
in nixlf_rss_ctx_init() if rss_grps is changed to 0 after validation.

The v2 notes say cq_ints_ctx and nix_qints_ctx were NULL-initialized "so
the error path does not pass an uninitialized pointer to qmem_free()".
Should rq_ctx, sq_ctx, cq_ctx and rss_ctx be initialized the same way?

[ ... ]

> @@ -1702,8 +1862,8 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>  	}
>  
>  	if (is_rep_dev(rvu, pcifunc)) {
> -		pfvf->tx_chan_base = RVU_SWITCH_LBK_CHAN;
> -		pfvf->tx_chan_cnt = 1;
> +		nix_interface_set_chan(rvu, pfvf, 0, 0,
> +				       RVU_SWITCH_LBK_CHAN, 1);
>  		goto exit;
>  	}

[Severity: Low]
This path jumps to exit before nix_interface_init(), so rsp->tx_link is
never set for the representor. With this patch, nix_get_tx_link() returns
hw->cgx_links for the representor, and IFACE_GET_INFO reports that value.
So NIX_LF_ALLOC and IFACE_GET_INFO report different links for the
representor.

This doesn't seem to misprogram hardware. otx2_txschq_config() skips the
NIX_AF_TL3_TL2X_LINKX_CFG write when is_otx2_sdp_rep() is true, and the
missing rsp->tx_link predates this patch. Should the two responses still
agree?

[ ... ]

> @@ -1807,6 +1967,8 @@ int rvu_mbox_handler_nix_lf_free(struct rvu *rvu, struct nix_lf_free_req *req,
>  	nix_interface_deinit(rvu, pcifunc, nixlf);
>  
>  free_lf:
> +	nix_interface_clear_chan(rvu, pfvf);
> +

[Severity: Medium]
IFACE_GET_INFO treats a non-zero tx_chan_cnt as meaning the function has a
live NIX LF:

    if (!pfvf->tx_chan_cnt)
        goto chk_vfs;

This is the only place the channels are cleared, though. Two other paths
free the NIX contexts and leave the channels set.

The first is rvu_nix_lf_teardown(), which runs on FLR and detach. It calls
nix_interface_deinit(), nix_txschq_free() and nix_ctx_free(), but not
nix_interface_clear_chan().

The second is rvu_mbox_handler_nix_lf_alloc(). It can fail after
nix_interface_init() has already called nix_interface_set_chan(), for
example when nix_update_mce_rule() fails. It then goes through
free_dft/free_mem to nix_ctx_free() without clearing the channels.

In both cases, would IFACE_GET_INFO keep listing the function with its
old channel base/count and tx_link, but zero queue counts?

[ ... ]

> @@ -2100,15 +2262,22 @@ static void nix_clear_tx_xoff(struct rvu *rvu, int blkaddr,
>  	rvu_write64(rvu, blkaddr, reg, 0x0);
>  }
>  
> -static int nix_get_tx_link(struct rvu *rvu, u16 pcifunc)
> +int nix_get_tx_link(struct rvu *rvu, u16 pcifunc)
>  {
> -	struct rvu_hwinfo *hw = rvu->hw;
>  	int pf = rvu_get_pf(rvu->pdev, pcifunc);
> +	struct rvu_hwinfo *hw = rvu->hw;
> +	struct rvu_pfvf *pfvf;
>  	u8 cgx_id = 0, lmac_id = 0;
>  
> -	if (is_lbk_vf(rvu, pcifunc)) {/* LBK links */
> +	if (is_rep_dev(rvu, pcifunc))
>  		return hw->cgx_links;
> -	} else if (is_pf_cgxmapped(rvu, pf)) {
> +
> +	if (is_lbk_vf(rvu, pcifunc)) {
> +		pfvf = rvu_get_pfvf(rvu, pcifunc);
> +		return hw->cgx_links + pfvf->lbkid;
> +	}

[Severity: Medium]
This changes what the existing TX scheduler callers get back, not only
what IFACE_GET_INFO sees.

Before this patch, every LBK VF got hw->cgx_links. The representor is not
CGX mapped, so it got the SDP link, cgx_links + lbk_links. Now LBK VFs get
cgx_links + lbkid and the representor gets cgx_links.

The existing callers use this value as a TL1 index:

  rvu_mbox_handler_nix_txsch_alloc() uses start = end = link at the
  aggregation level.

  nix_tl1_default_cfg() writes NIX_AF_TL1X_TOPOLOGY/SCHEDULE/CIR(link).

  nix_txschq_free() clears TL1 SW_XOFF and, for PFs, CFG_DONE on
  TL1[link].

  is_valid_txschq() uses it to decide whether aggregation-level TLs are
  shared.

With lbk_links > 1, LBK VFs with lbkid 1 move to TL1[cgx_links + 1]. The
representor PF moves onto LBK0's TL1, which the AF VFs share. Since the
representor is a PF, won't its nix_txschq_free() now clear CFG_DONE on
that shared TL1?

On fixed-mapping silicon, nix_get_txschq_range() computes the LBK start
as:

    *start = hw->cap.nix_txsch_per_cgx_lmac * link;

That was only correct while link was always cgx_links. Can a non-zero
lbkid now produce overlapping ranges?

The commit message doesn't mention this change to existing TX behaviour.
If it is meant as a fix, could it go in a separate patch with a Fixes:
tag?

[Severity: Medium]
Is lbkid always below hw->lbk_links here? nix_interface_init() does:

    lbkid = 0;
    if (rvu->hw->lbk_links > 1)
        lbkid = vf & 0x1 ? 0 : 1;
    ...
    if (loop)
        lbkid = !lbkid;

So on single-LBK silicon, an LBK VF that passes NIX_LF_LBK_BLK_SEL ends up
with lbkid 1. nix_get_tx_link() then returns cgx_links + 1, which is the
SDP link index (cgx_links + lbk_links).

Would that VF's TL1 allocation, its nix_tl1_default_cfg() writes, the
SW_XOFF clearing in nix_txschq_free() and the is_valid_txschq() sharing
checks all hit the SDP TL1? On fixed-mapping silicon, its schq range
would also collide with the SDP range.

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 42a601976db36..c1d0c36b47b55 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -3545,6 +3545,53 @@ int rvu_mbox_handler_npc_mcam_free_entry(struct rvu *rvu,
>  	return rc;
>  }
>  
> +int rvu_mbox_handler_npc_flow_del_n_free(struct rvu *rvu,
> +					 struct npc_flow_del_n_free_req *mreq,
> +					 struct msg_rsp *rsp)
> +{

[ ... ]

> +	cnt = mreq->cnt;
> +	if (!cnt || cnt > 256) {
> +		dev_err_ratelimited(rvu->dev, "Invalid cnt=%u\n", cnt);
> +		return -EINVAL;
> +	}
> +
> +	/* Snapshot shared mailbox memory before processing the request. */
> +	memcpy(entry, mreq->entry, cnt * sizeof(entry[0]));

[Severity: High]
This is a pre-existing issue, but the dispatcher never bounds-checks where
a request sits. __rvu_mbox_handler() computes the next message as:

    offset = mbox->rx_start + msg->next_msgoff;

It doesn't check this offset, or the request size, against the MBOX_SIZE
mapping (ioremap_wc(bar4, MBOX_SIZE) for AF VFs). A peer could place this
request near the end of the mapping. Could this memcpy() of up to 512
bytes then read past the mapped mailbox and fault?

The same applies to the memcpy() in rvu_mbox_handler_npc_mcam_mul_stats().

[ ... ]

> @@ -4444,6 +4491,83 @@ int rvu_mbox_handler_npc_mcam_entry_stats(struct rvu *rvu,
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

[Severity: Medium]
This isn't a bug introduced by this patch. The new batch handler checks
ownership here, but the existing single-entry
rvu_mbox_handler_npc_mcam_entry_stats() does not:

    index = req->entry & (mcam->banksize - 1);
    bank = npc_get_bank(mcam, req->entry);

npc_get_bank() has no upper bound on CN20K or for non-X2 key sizes. Can a
PF/VF use NPC_MCAM_ENTRY_STATS to read the hit counters of MCAM rules
owned by other functions, or to build out-of-range register offsets?

[ ... ]

> +		/* read MCAM entry STAT_ACT register */
> +		regval = rvu_read64(rvu, blkaddr, NPC_AF_MCAMEX_BANKX_STAT_ACT(index, bank));
> +
> +		if (!(regval & rvu->hw->npc_stat_ena)) {
> +			rsp->stat[cnt] = 0;
> +			cnt++;
> +			continue;
> +		}
> +
> +		cntr = regval & 0x1FF;
> +
> +		rsp->stat[cnt] = rvu_read64(rvu, blkaddr, NPC_AF_MATCH_STATX(cntr));

[Severity: Medium]
Does the 0x1FF mask drop the extended counter selector bits?
npc_map_mcam_entry_and_cntr() programs STAT_ACT as:

    ((cntr >> 9) << 12) | hw->npc_stat_ena | cntr

The comment in rvu_npc.c describes STAT_SEL_EXT at [14:12] on 98xx and a
12-bit STAT_SEL on CN10K. For an entry mapped to counter N where N is 512
or higher, wouldn't this return counter (N mod 512) instead?

The existing single-entry handler truncates the same way, but this patch
adds a second copy of that code.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924024446.1851115-1-rkannoth%40marvell.com
