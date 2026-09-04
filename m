Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1037B402;
	Fri,  4 Sep 2026 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517525; cv=none; b=a2sXzoHKaLV5DlyS37oZWEDjrvEmE4r30d3n/zPX0sgDZmatKEyY/5Mq2PO0g2TbHz/n5Nq1L2HHDCRmGXRgS0YJb3W+fjZpQNikIVBy7P7UqKLBJuK1jLd19Siilfma3/X8ibnBwL6FyS+GhFKAPKpN9A1AOOJSPKMMwv02Fig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517525; c=relaxed/simple;
	bh=X23rqdy8BVgI+R/sHjmIfHENWVYBQVNKmyTOTyaWJsM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cc17Tl92NkZSTkGS1y2YqWoXw9rXVBJf9BOBMrGAv39WpqjHTR1GQlDAGoaka+7PYG2Ix/p+q97rxrNPPFWj95NDP6I5b8nPxnZTl3OEOGtnhodNsrdQIBLJV4jI4aqa7rqtHp9JkgnJ1Y88Hgw7elhUjBKcDYGEgCt2Kzfg7IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WazIK/Av; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WazIK/Av"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E88A1F00A3D;
	Fri,  4 Sep 2026 10:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517524;
	bh=Ju1FCXNbkEWVFiWw8h3tpKQe+2ulnvACfAvsVXfUKYA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WazIK/AvASqDZqtU85f43hUVhI5rukiMSsQHvfg6h00d2if22yXvSfNJ+KBf2TPx4
	 XxUc1Hp0tZ7yu8SQCiV6GW9FDJKz8hZMLvQAEgVcUouG+7/MRN0CCbWoVSHzMaRb0W
	 jbzHkSMdXZnD/yBHGW6wVVnUqEypsTwPpk2jYPKcgBhs1yJTkb1kkE6z1KVQwRdvuh
	 DiS1fokxuMOml/E2wf4EuQpraUTxsDbRmlJVvikXmv/DoQAWDBdxyQ4co4BBOuUyCe
	 ccM1yfV9++uA1KKFwogmLDuY8IhptN46RErxeT8eqNWTJWUBA5oxlxOR1dkIVvqYvo
	 89mgzpG7luq1Q==
Subject: Re: [PATCH net] octeontx2-af: Fix BPID leak in nix_bp_enable()
From: netdev-bot+sashiko@kernel.org
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 rkudurumalla@marvell.com, sgoutham@marvell.com, rkannoth@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Fri, 04 Sep 2026 10:25:23 +0000
Message-ID: <178851752316.4131868.12834435745206837525@kernel.org>
In-Reply-To: <20260901102500.1534911-1-nshettyj@marvell.com>
References: <20260901102500.1534911-1-nshettyj@marvell.com>
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

Critical: 0 · High: 1 (2) · Medium: 0 (3) · Low: 1

- [High] Incomplete fix: the BPID leak the commit claims to close is
  still reachable through the *pre-loop* rvu_nix_get_bpid() call.
- [Low] Inaccurate Fixes tag.

Pre-existing issues:
- [High] nix_bp_disable() frees a BPID derived from a hardware register
  with no validation.
- [High] Unvalidated mailbox channel range reaches the MMIO register
  index for LBK interfaces.
- [Medium] For LBK interfaces the mailbox contract and the response
  advertise BPIDs that do not match what is programmed into hardware.
- [Medium] Off-by-one BPID range check for SDP interfaces.
- [Medium] nix_bp_enable() has no unwind on a mid-loop failure.

--

octeontx2-af: Fix BPID leak in nix_bp_enable()

The patch stops nix_bp_enable() from calling rvu_nix_get_bpid() once the
last channel has been programmed, since for LBK interfaces every call
allocates a BPID from the shared free pool. A few questions about the fix
and about the surrounding BPID lifecycle follow.

> Fixes: 27150bc4286c ("octeontx2-af: Interface backpressure configuration")

[Severity: Low]
Is this the right commit to point at?  The behaviour the commit message
reasons about, "each call allocates a BPID", comes from the free-pool
allocation in the NIX_INTF_TYPE_LBK arm of rvu_nix_get_bpid():

	case NIX_INTF_TYPE_LBK:
		/* Alloc bpid from the free pool */
		mutex_lock(&rvu->rsrc_lock);
		bpid = rvu_alloc_rsrc(&bp->bpids);

git blame attributes that block to d6212d2e41a0 ("octeontx2-af: Create
BPIDs free pool"); before it the LBK arm computed a deterministic
bpid = cgx_bpid_cnt + req->chan_base with no allocation, so the surplus
trailing call could not leak anything.  Only the case label and the break
date back to 27150bc4286c.  Would Fixes: d6212d2e41a0 describe the
affected range (v6.9+) more accurately, so stable trees that lack the free
pool are not targeted?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 153eb57bad067..6df9f4e512b6c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -784,7 +784,8 @@ static int nix_bp_enable(struct rvu *rvu,
>  		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
>  			    cfg | (bpid & GENMASK_ULL(8, 0)) | BIT_ULL(16));
>  		chan_id++;
> -		bpid = rvu_nix_get_bpid(rvu, req, type, chan_id);
> +		if (chan_id < req->chan_cnt)
> +			bpid = rvu_nix_get_bpid(rvu, req, type, chan_id);
>  	}
>  
>  	for (chan = 0; chan < req->chan_cnt; chan++) {

[Severity: High]
Does this guard cover the other unconditional call?  nix_bp_enable() also
allocates before the loop:

	bpid_base = rvu_nix_get_bpid(rvu, req, type, chan_id);
	chan_base = pfvf->rx_chan_base + req->chan_base;
	bpid = bpid_base;

	for (chan = chan_base; chan < (chan_base + req->chan_cnt); chan++) {
		if (bpid < 0) {
			dev_warn(rvu->dev, "Fail to enable backpressure\n");
			return -EINVAL;
		}
		...
	}

req->chan_cnt is a u8 taken verbatim from struct nix_bp_cfg_req, and
neither nix_bp_enable() nor the LBK arm of rvu_nix_get_bpid() validates
it.  With chan_cnt == 0, does this leak one pool entry per request?

	NIX_BP_ENABLE (chan_cnt = 0)
	  rvu_mbox_handler_nix_bp_enable()
	    nix_bp_enable()
	      bpid_base = rvu_nix_get_bpid()   /* rvu_alloc_rsrc(&bp->bpids) */
	      for (...)                        /* zero iterations */
	      return 0

The allocated BPID is never written into NIX_AF_RX_CHANX_CFG, so
nix_bp_disable() cannot reclaim it either, since it recovers LBK BPIDs
only by reading the field back out of the channel register:

		if (type == NIX_INTF_TYPE_LBK) {
			bpid = cfg & GENMASK(8, 0);
			mutex_lock(&rvu->rsrc_lock);
			rvu_free_rsrc(&bp->bpids, bpid - bp->free_pool_base);
			for (bpid = 0; bpid < bp->bpids.max; bpid++) {
				if (bp->fn_map[bpid] == pcifunc) {
					bp->fn_map[bpid] = 0;
					bp->ref_cnt[bpid] = 0;
				}
			}

That same block wipes fn_map[]/ref_cnt[] for every BPID owned by the
pcifunc while freeing only the one read from the register, which also
removes the orphan from the fn_map sweep in rvu_nix_flr_free_bpids().
Can an LBK VF drain the shared pool this way, with the loss surviving
FLR?

On the same zero-count path, the only bpid < 0 test lives inside the
loop, so an error return from rvu_nix_get_bpid() (NIX_AF_ERR_AF_LF_INVALID
or NIX_AF_ERR_INVALID_BPID) is discarded and success is reported.  Would
moving the allocation into the loop body, or validating chan_cnt and
checking bpid_base before the loop, be a better shape for this fix than
extending the in-loop call with a guard?

[Severity: Medium]
This isn't a bug introduced by this patch, but for LBK the reported
mapping does not match what gets programmed.  mbox.h documents:

	u8	bpid_per_chan;
	/* bpid_per_chan = 0 assigns single bp id for range of channels */
	/* bpid_per_chan = 1 assigns separate bp id for each channel */

The LBK arm of rvu_nix_get_bpid() never consults req->bpid_per_chan
(unlike the CGX and SDP arms) and always takes a fresh pool entry, so an
LBK request with chan_cnt == N still programs N distinct BPIDs into
NIX_AF_RX_CHANX_CFG.  The response loop then synthesizes a contiguous
range instead:

	rsp->chan_bpid[chan] = ((req->chan_base + chan) & 0x7F) << 10 |
				(bpid_base & 0x3FF);
	if (req->bpid_per_chan)
		bpid_base++;

rvu->rsrc_lock is taken and dropped inside each rvu_nix_get_bpid() call,
so pool fragmentation or a concurrent enable/disable/FLR makes the
allocated ids non-consecutive as well.  Does mbox_handler_nix_bp_enable()
in otx2_common.c then arm the NPA aura / NIX CQ against BPIDs the channels
are not configured with?

	chan_id = ((rsp->chan_bpid[chan] >> 10) & 0x7F);
	pfvf->bpid[chan_id] = rsp->chan_bpid[chan] & 0x3FF;

nix_interface_init() sets rx_chan_cnt = 1 for LBK VFs and
otx2_nix_config_bp() sends bpid_per_chan = 0, so the in-tree non-PFC path
appears unaffected; the mismatch needs a multi-channel LBK request.

[Severity: High]
This is a pre-existing issue, but the release side of the same BPID
lifecycle frees an unvalidated register value.  In nix_bp_disable():

		if (type == NIX_INTF_TYPE_LBK) {
			bpid = cfg & GENMASK(8, 0);
			mutex_lock(&rvu->rsrc_lock);
			rvu_free_rsrc(&bp->bpids, bpid - bp->free_pool_base);

bpid is u16 and bp->free_pool_base is u16, so the subtraction is a plain
int and goes negative whenever the channel's BPID field is below
free_pool_base, in particular 0 on a channel where backpressure was never
enabled.  rvu_free_rsrc() does no bounds or state check:

	void rvu_free_rsrc(struct rsrc_bmap *rsrc, int id)
	{
		if (!rsrc->bmap)
			return;

		__clear_bit(id, rsrc->bmap);
	}

__clear_bit() takes an unsigned long, so does a negative index turn into
a wild word offset and write outside the bitmap allocation?  The path is

	NIX_BP_DISABLE (chan_cnt >= 1, no prior successful enable)
	  rvu_mbox_handler_nix_bp_disable()
	    nix_bp_disable()          /* cfg BPID field reads 0 */
	      rvu_free_rsrc(&bp->bpids, 0 - bp->free_pool_base)

Also, nix_bp_disable() clears only BIT_ULL(16) and leaves the BPID bits in
the register:

		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
			    cfg & ~BIT_ULL(16));

so does a second NIX_BP_DISABLE free the same pool index twice, with the
fn_map/ref_cnt wipe then allowing the same BPID to be handed to another
pcifunc?

[Severity: High]
This isn't introduced by this patch either, but the channel index that
nix_bp_enable() derives from the mailbox is unbounded for LBK:

	chan_base = pfvf->rx_chan_base + req->chan_base;
	...
		chan_v = nix_get_channel(chan, cpt_link);
		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v));

req->chan_base is a u16 fully controlled by the requesting PF/VF and
nix_get_channel() only ORs BIT(11) for cpt_link.  rvu_nix_get_bpid()
validates chan_base + chan_cnt for CGX and SDP, but the LBK arm validates
nothing and always returns a freshly allocated BPID, so the loop reaches
MMIO with an arbitrary index:

	#define NIX_AF_RX_CHANX_CFG(a)  (0x1A30 | (a) << 15)

	static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset, u64 val)
	{
		writeq(val, rvu->afreg_base + ((block << 28) | offset));
	}

Since the offset is ORed with block << 28 rather than added, can a large
chan_v alias another RVU block's register space or land past the
ioremapped BAR, with the read-modify-write leaving bpid | BIT(16) there?
Even small values let an LBK VF rewrite other functions'
NIX_AF_RX_CHANX_CFG, while nix_interface_init() gives an LBK VF
rx_chan_cnt = 1.  Note the LBK bound check used to exist:

	if ((req->chan_base + req->chan_cnt) > 63)
		return -EINVAL;

and was removed by d6212d2e41a0 ("octeontx2-af: Create BPIDs free pool").
Should it be restored?

[Severity: Medium]

Correction to the tag above, the finding id is gpt-5-6-sol-4-16.

[Severity: Medium]
This is a pre-existing issue, but nix_bp_enable() has no unwind when an
allocation fails part way through the loop.  Hardware is armed
channel-by-channel before the next BPID is obtained, and the failure is
only detected on the following iteration:

	for (chan = chan_base; chan < (chan_base + req->chan_cnt); chan++) {
		if (bpid < 0) {
			dev_warn(rvu->dev, "Fail to enable backpressure\n");
			return -EINVAL;
		}
		...
		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
			    cfg | (bpid & GENMASK_ULL(8, 0)) | BIT_ULL(16));
		chan_id++;
		if (chan_id < req->chan_cnt)
			bpid = rvu_nix_get_bpid(rvu, req, type, chan_id);
	}

On that -EINVAL return, the BPIDs already taken for the earlier channels
are not released and the BIT_ULL(16) bits already written are not
cleared.  The requester sees a failed mbox, so it never programs the
matching aura/CQ BPIDs and never sends NIX_BP_DISABLE.  Does this leave
channels armed against BPIDs whose aura side is unconfigured, recoverable
only via FLR through bp->fn_map?  And since nix_bp_disable() does not
check BIT_ULL(16) before trusting the read-back field, would a later
full-range disable then call rvu_free_rsrc() with 0 - bp->free_pool_base
for the never-programmed channels?

[Severity: Medium]
This is a pre-existing issue as well, but the SDP bound check in
rvu_nix_get_bpid() looks off by one:

		if (bpid > (bp->cgx_bpid_cnt + bp->sdp_bpid_cnt))
			return NIX_AF_ERR_INVALID_BPID;

nix_setup_bpids() reserves NIX_BPIDS_PER_CPT (=1) BPID at exactly
cgx_bpid_cnt + sdp_bpid_cnt:

	bp->cgx_bpid_cnt = rvu->hw->cgx_links * NIX_BPIDS_PER_LMAC;
	bp->sdp_bpid_cnt = rvu->hw->sdp_links * FIELD_GET(NIX_CONST_SDP_CHANS, cfg);
	bp->free_pool_base = bp->cgx_bpid_cnt + bp->sdp_bpid_cnt +
			     NIX_BPIDS_PER_CPT;

With sdp_chan_base >= 1 (the offset SDP case) and chan_base + chan_cnt at
the upper edge allowed by the request check, bpid reaches exactly
cgx_bpid_cnt + sdp_bpid_cnt and passes the > comparison.  Should this be
>= so an SDP channel cannot be programmed with the CPT-reserved BPID?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901102500.1534911-1-nshettyj%40marvell.com
