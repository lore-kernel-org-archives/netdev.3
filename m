Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476210;
	b=DxcPt0U+pm38jAb/3PadvSvo3p6YB9pz2cs41Q4kvXKESgSeFAFR/y6PDUQKEpJGxmwi
	 I/JCE3qQbdBD5rxIlf/5mkVJ1LJlsnXIxCP4SVOoBMUUIZqMfkDhfjSM8Dfp/b+kvLr39
	 PE2vhwmbNn4cEhMZfe2TEfbLcest2v9IY9/sFthaxvVfFzduVr/PUcYe9DF8HSD0/p/Q6
	 9HJ0Ce1LuVNR6KFSm5XFJ9uSCBqUY1Zvvzsnq8+EY5RwqQ7vOOSg5CEg+0nUZtFnhlgss
	 A1lj7c25FcBs33ZF6kE1vgWYPuX25KxpELkjtXceW73/ZhCAS3MTS/5VfW0XX/M1O/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476210;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pALi1i1EkIm5pnPkLRbsgcgxk7uPJ30fEOp++hHfNsA=;
	b=oSkHvTSVZFBpuT2TGJGevvBzOkJtxeGNvDfSfdgLl3sdq3umZTPQgFtdAumHInY7D7wF
	 vtZTym7C2ZbdhvFIT0gEruqAyc1N9qXu5AOzcEJG/Y1zRmsAb/VLSFGEw+SXlcEWbtVSP
	 UrdQfGM5BMvFOZHj/ViBvhImzt+AdgMi9wxVsASoS9aoi0ESt3jSx2RvbDEdxnNkXHt6u
	 pkwvQyLI9oO0g7sin8+Imnk1pgXqkDXioFbxOP47siRJYPwSI0KR1GnmSDw0V9M7KhUCY
	 CV/coY7dEUb5c+QySMJAac7CmMxFdGkFips5qKYRC3d3wRsdE93T/3M7ZP0tk48zAvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Pq/5Jc3K";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76230606A323;
	Thu, 12 Nov 2026 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pq/5Jc3K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6D61F00A05;
	Thu, 12 Nov 2026 09:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794476210;
	bh=pALi1i1EkIm5pnPkLRbsgcgxk7uPJ30fEOp++hHfNsA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Pq/5Jc3KuREdnl86zOuZWTs9FWCGSjFGk59m1ilZSWjwlUG/Hb9gG9fgKqLndlMDS
	 zcr89mbJgPVvuJVlxRJxPlF2c/4BM/X66jZOoB0z1YZeDdTumoLLH3UlclG9FZbK2K
	 R5yzVTMYH6KXgWjcAe2A5hVevYYQgOhFmZJa5tkOARYgdtM+ZS6NLD3uWi1kZQANaY
	 O56I/rOn0fVbL/2qTUHIXSLQQArLhMvfkvxN6OH1NlRGvAU4PraL0HpeI2cmHR9DEC
	 jLpfkPAl4GLGwNaqB//h8BeIDqJhpTKdoaigb1+rR7F63QGWCHDVcSNnBZLe4D3W/e
	 4muwKU5cuYEuA==
Subject: Re: [PATCH v4 net-next] octeontx2-af: Add couple of mailbox support.
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
 cursoragent@cursor.com
Date: Thu, 12 Nov 2026 09:36:48 +0000
Message-ID: <179447620892.2199510.3746680937453360550@kernel.org>
In-Reply-To: <20261109033617.2161960-1-rkannoth@marvell.com>
References: <20261109033617.2161960-1-rkannoth@marvell.com>
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

Critical: 0 · High: 2 (1) · Medium: 2 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch changes nix_get_tx_link() in
  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c.
- [High] In rvu_mbox_handler_nix_lf_alloc(), the patch snapshots
  rq_cnt/sq_cnt/cq_cnt/way_mask with READ_ONCE and adds the comment 'req…
- [Medium] The commit message presents the nix_get_tx_link() change as an
  export plus a new reported value ('Export nix_get_tx_link(); it now…
- [Medium] For the representor, rvu_mbox_handler_nix_lf_alloc() jumps
  from the is_rep_dev() branch to exit before nix_interface_init(), so…
- [Low] The new NPC_MCAM_FLOW_DEL_N_FREE handler
  (rvu_mbox_handler_npc_flow_del_n_free) and NPC_MCAM_GET_MUL_STATS…
- [Low] struct iface_info declares sq_cnt/cq_cnt/rq_cnt as u16.
- [Low] The patch adds four AF mailbox messages with fixed wire layouts:
  IFACE_GET_INFO (0x014), NPC_MCAM_FLOW_DEL_N_FREE (0x6020),…
- [Low] The subject 'octeontx2-af: Add couple of mailbox support.' and
  the body do not mention several changes made in the patch.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch's
  partial lock conversion leaves it in place.

--

octeontx2-af: Add couple of mailbox support.

This adds AF handlers for the IFACE_GET_INFO, NPC_MCAM_FLOW_DEL_N_FREE,
NPC_MCAM_GET_MUL_STATS and NPC_MCAM_GET_FEATURES mailbox messages. It also
publishes NIX queue contexts under aq->lock and channel bases/counts under
rsrc_lock, and clears the counts on LF free, detach and allocation failure.
Finally, nix_get_tx_link() is exported and now returns cgx_links + lbkid
for LBK VFs and cgx_links + 0 for the representor.

> octeontx2-af: Add couple of mailbox support.

[Severity: Low]
This isn't a bug, but the subject and body leave out several changes in
this patch:

  - The NIX_LF_ALLOC READ_ONCE() snapshot of the rq/sq/cq counts and
    way_mask.
  - The split of NPC_DELETE_FLOW into npc_delete_flow_rules().

Both are described only in the v3 -> v4 changelog below the "---" line,
and git am drops that.

The patch also combines lifecycle fixes (clearing the channel counts on
detach, free, teardown and alloc failure) and a TX link semantic change
with four new mailbox ABIs. None of the fixes has a Fixes: tag.

Could the fixes be split out, so they can be reviewed and backported on
their own?

> Publish NIX queue contexts under aq->lock and channel bases/counts
> under rsrc_lock, and clear the counts when a NIX LF is freed, detached
> or fails to allocate. Export nix_get_tx_link(); it now reports the
> LBK link of an LBK VF and LBK link 0 for the representor.

[Severity: Medium]
Is this description complete? nix_get_tx_link() is not only a reporting
helper. The NIX TX scheduler takes its link from it:

  rvu_mbox_handler_nix_txsch_alloc()   TL1 start = end = link
  nix_get_txschq_range()               fixed-mapping range from link
  nix_tl1_default_cfg()                schq = link
  nix_txschq_free()                    TL1 SW_XOFF / CFG_DONE at link
  is_valid_txschq()                    access allowed when links match

With this change, AF VFs with lbkid = 1 and the representor get different
TL1 queues and fixed-mapping ranges than before.

The v2 -> v3 note says hw->cgx_links was kept for LBK VFs so that "the TX
scheduler callers (txschq alloc/free, TL1 default config, schq range)
keep the same link". v4 reverses that.

The new values match the RX link selection, which uses
hw->cgx_links + pfvf->lbkid and hw->cgx_links + 0. If the goal is to fix
a TX/RX link mismatch, should this be a separate patch with a Fixes: tag?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index cece197d1074b..28f2b549780f3 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h

[ ... ]

> @@ -1812,6 +1847,33 @@ struct rep_event {
>  	struct rep_evt_data evt_data;
>  };
>  
> +struct iface_info {
> +	u8 is_vf : 1;
> +	u8 is_sdp : 1;
> +	u8 rsvd : 6;
> +	u16 pcifunc;
> +	u16 rx_chan_base;
> +	u16 tx_chan_base;
> +	u16 sq_cnt;
> +	u16 cq_cnt;
> +	u16 rq_cnt;

[Severity: Low]
Can these counts be truncated? rvu_iface_get_qcnts() fills them like
this:

	info->sq_cnt = bitmap_weight(pfvf->sq_bmap, pfvf->sq_ctx->qsize);

bitmap_weight() returns unsigned int. qsize comes from the u32
rq_cnt/sq_cnt/cq_cnt in nix_lf_alloc_req, and
rvu_mbox_handler_nix_lf_alloc() only rejects zero.

So a function with more than 65535 enabled queues would get a wrapped
count in the IFACE_GET_INFO reply.

> +	u8 rx_chan_cnt;
> +	u8 tx_chan_cnt;
> +	u8 tx_link;
> +	u8 nix;
> +};
> +
> +/* Max supported */
> +#define IFACE_MAX (256 + 32) /* 32 PFs + 256 VFs */
> +
> +struct iface_get_info_rsp {
> +	struct  mbox_msghdr hdr;
> +	u16 cnt;
> +	u8 truncated;
> +	u8 rsvd[5];
> +	struct iface_info info[IFACE_MAX];
> +};

[Severity: Low]
This isn't a bug, but the commit message says:

  Only the AF handlers are added; the senders are not part of this patch.

This patch fixes the wire layouts of IFACE_GET_INFO,
NPC_MCAM_FLOW_DEL_N_FREE, NPC_MCAM_GET_MUL_STATS and
NPC_MCAM_GET_FEATURES, including the iface_info bitfields, IFACE_MAX and
the 256-entry arrays. No in-tree PF/VF code uses them.

Could the senders be posted with these handlers, as netdev usually
expects for new interfaces?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 29559db689290..59cc87becb54d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c

[ ... ]

> @@ -920,33 +936,114 @@ static void nix_setup_lso(struct rvu *rvu, struct nix_hw *nix_hw, int blkaddr)

[ ... ]

>  static void nix_ctx_free(struct rvu *rvu, struct rvu_pfvf *pfvf)
>  {

[ ... ]

> +	spin_lock_irqsave(&aq->lock, flags);
> +	rq_bmap = pfvf->rq_bmap;
> +	sq_bmap = pfvf->sq_bmap;
> +	cq_bmap = pfvf->cq_bmap;

[ ... ]

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
> +free_ctx:
> +	kfree(rq_bmap);
> +	kfree(sq_bmap);
> +	kfree(cq_bmap);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
does the new aq->lock publication cover the AQ enqueue path?

rvu_nix_blk_aq_enq_inst() checks the context without aq->lock:

	case NIX_AQ_CTYPE_RQ:
		/* Check if index exceeds max no of queues */
		if (!pfvf->rq_ctx || req->qidx >= pfvf->rq_ctx->qsize)

It calls is_valid_txschq() and builds the instruction. Only then does it
take spin_lock(&aq->lock), and it uses the bitmap without checking it
again:

		if (req->ctype == NIX_AQ_CTYPE_RQ && req->rq.ena)
			__set_bit(req->qidx, pfvf->rq_bmap);

nix_ctx_free() is reached from FLR teardown, which holds only flr_lock:

  __rvu_flr_handler()
    rvu_blklf_teardown()
      rvu_nix_lf_teardown()
        nix_ctx_free()

The mbox AQ path does not take flr_lock.

If FLR teardown runs between the unlocked check and spin_lock(&aq->lock),
can the AQ path now call __set_bit(qidx, NULL)?

Before this patch, the same window was a use-after-free of the kcalloc'd
bitmap. The new locking seems to protect only the IFACE_GET_INFO reader.

[ ... ]

> @@ -1520,15 +1630,21 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>  	bool rules_created = false;
>  	struct rvu_block *block;
>  	struct rvu_pfvf *pfvf;
> +	u32 rq_cnt, sq_cnt, cq_cnt;
> +	u64 way_mask;
>  	struct cgx *cgxd;
>  	u64 cfg, ctx_cfg;
>  	int blkaddr;
>  
> -	if (!req->rq_cnt || !req->sq_cnt || !req->cq_cnt)
> +	/* req is in shared mailbox memory; read the counts only once */
> +	rq_cnt = READ_ONCE(req->rq_cnt);
> +	sq_cnt = READ_ONCE(req->sq_cnt);
> +	cq_cnt = READ_ONCE(req->cq_cnt);
> +
> +	if (!rq_cnt || !sq_cnt || !cq_cnt)
>  		return NIX_AF_ERR_PARAM;
>  
> -	if (req->way_mask)
> -		req->way_mask &= 0xFFFF;
> +	way_mask = READ_ONCE(req->way_mask) & 0xFFFF;
>  
>  	pfvf = rvu_get_pfvf(rvu, pcifunc);
>  	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
> @@ -1583,63 +1699,96 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,

[ ... ]

>  	/* Initialize receive side scaling (RSS) */
>  	hwctx_size = 1UL << ((ctx_cfg >> 12) & 0xF);
>  	rc = nixlf_rss_ctx_init(rvu, blkaddr, pfvf, nixlf, req->rss_sz,
> -				req->rss_grps, hwctx_size, req->way_mask,
> +				req->rss_grps, hwctx_size, way_mask,
>  				!!(req->flags & NIX_LF_RSS_TAG_LSB_AS_ADDER));
>  	if (rc)
>  		goto free_mem;

[Severity: High]
The new comment says the counts are read only once because req is in
shared mailbox memory. Are other validated fields in this handler still
fetched twice?

req->rss_sz and req->rss_grps are checked earlier:

	if (req->rss_sz && (req->rss_sz > MAX_RSS_INDIR_TBL_SIZE ||
			    !is_power_of_2(req->rss_sz)))
	...
	    (!req->rss_grps || req->rss_grps > MAX_RSS_GROUPS))

They are read again from req for this nixlf_rss_ctx_init() call, which
loops like this:

	for (grp = 0; grp < rss_grps; grp++)
		rvu_write64(rvu, blkaddr, NIX_AF_LFX_RSS_GRPX(nixlf, grp),

If the peer rewrites rss_grps after the check, can this write registers
outside this LF's RSS group slots? For example, grp = 32 with nixlf = 0
gives 0x4700, which is NIX_AF_RX_NPC_MC_RCV. A rewritten rss_sz would
also break the ilog2() encoding.

req->npa_func and req->sso_func have the same problem. They are validated
with is_pffunc_map_valid(), then read again before being written to
NIX_AF_LFX_CFG:

	if (req->npa_func)
		cfg = req->npa_func;
	if (req->sso_func)
		cfg |= (u64)req->sso_func << 16;

Could a peer swap in another function's pcifunc here, and bind this NIX
LF to that function's NPA or SSO LF? The window between check and use
covers the rvu_lf_reset() polling and the GFP_KERNEL allocations.

[ ... ]

> @@ -1710,8 +1875,8 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
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
For the representor, this jumps to exit before nix_interface_init(). So
rsp->tx_link is never written and stays 0.

The PF driver saves it in mbox_handler_nix_lf_alloc():

	pfvf->hw.tx_link = rsp->tx_link;

and later uses it to program the TL3/TL2 LINKX_CFG.

After this patch, nix_get_tx_link() returns hw->cgx_links + 0 for the
representor. That value picks the TL1 handed out by TXSCH_ALLOC and is
reported as tx_link in IFACE_GET_INFO.

Should NIX_LF_ALLOC report the same tx_link for the representor, so the
AF doesn't give out two different TX links for one function?

The two values already differed before this patch (SDP link vs 0). The
new value and its exposure through IFACE_GET_INFO come from this change.

[ ... ]

> @@ -2108,15 +2276,22 @@ static void nix_clear_tx_xoff(struct rvu *rvu, int blkaddr,
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
> +	struct rvu_pfvf *pfvf;
>  
> -	if (is_lbk_vf(rvu, pcifunc)) {/* LBK links */
> -		return hw->cgx_links;
> -	} else if (is_pf_cgxmapped(rvu, pf)) {
> +	if (is_rep_dev(rvu, pcifunc))
> +		return hw->cgx_links + 0;
> +
> +	if (is_lbk_vf(rvu, pcifunc)) {
> +		pfvf = rvu_get_pfvf(rvu, pcifunc);
> +		return hw->cgx_links + pfvf->lbkid;
> +	}

[Severity: High]
Can lbkid be equal to or larger than hw->lbk_links here?

In nix_interface_init(), lbkid is set from the VF index only when
lbk_links > 1. It is then inverted based on the requester's
NIX_LF_LBK_BLK_SEL flag:

		lbkid = 0;
		if (rvu->hw->lbk_links > 1)
			lbkid = vf & 0x1 ? 0 : 1;
		...
		if (loop)
			lbkid = !lbkid;

On single-LBK silicon, an AF VF that sends NIX_LF_ALLOC with
NIX_LF_LBK_BLK_SEL gets lbkid = 1. This function then returns
hw->cgx_links + 1, which is the SDP link (hw->cgx_links + hw->lbk_links).

This value drives the TX scheduler. Does that hand the VF the SDP TL1?

  rvu_mbox_handler_nix_txsch_alloc()
    start = link; end = link;              (TL1 index = SDP link)
  nix_tl1_default_cfg()
    schq = nix_get_tx_link(rvu, pcifunc);  (writes SDP TL1 regs)
  nix_txschq_free()
    nix_clear_tx_xoff(..., NIX_TXSCH_LVL_TL1, nix_get_tx_link(...))

is_valid_txschq() would also let the VF configure SDP-owned
aggregation-level schqs, because the links now compare equal:

		if ((nix_get_tx_link(rvu, map_func) !=
		     nix_get_tx_link(rvu, pcifunc)) &&
		    (rvu_get_pf(rvu->pdev, map_func) !=
		     rvu_get_pf(rvu->pdev, pcifunc))) {

On fixed-mapping silicon, nix_get_txschq_range() still computes the LBK
range like this:

		*start = hw->cap.nix_txsch_per_cgx_lmac * link;
		*end = *start + hw->cap.nix_txsch_per_lbk_lmac;

That is only correct for link == hw->cgx_links. With per_cgx = 4,
per_lbk = 132 and link = hw->cgx_links + 1, the range moves up by 4. It
then overlaps other LBK VFs' slots, and on single-LBK parts the first
SDP schqs.

On parts with lbk_links > 1, there are two more changes:

  - AF VFs with lbkid = 1 move from TL1 cgx_links to cgx_links + 1.
  - The representor moves from the SDP TL1 to LBK0's TL1, which it now
    shares with lbkid 0 AF VFs.

pfvf->lbkid is written only in NIX_LF_ALLOC and is never reset. Can the
TL1 allocated in TXSCH_ALLOC then differ from the TL1 that is later
configured or freed?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 42a601976db36..9b31c6643d104 100644
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

[Severity: Low]
Should this be READ_ONCE(mreq->cnt)? cnt is a plain load from shared
mailbox memory, and it bounds the memcpy() into the on-stack
u16 entry[256]. Without READ_ONCE(), the compiler is allowed to reload
the field after the bounds check.

rvu_mbox_handler_npc_mcam_mul_stats() has the same pattern, and there
req_cnt also bounds the writes to rsp->stat[]:

	req_cnt = req->cnt;
	...
	memcpy(entry, req->entry, req_cnt * sizeof(entry[0]));

The NIX_LF_ALLOC change in this patch already uses READ_ONCE() for the
same reason.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109033617.2161960-1-rkannoth%40marvell.com
