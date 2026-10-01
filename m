Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014E472531;
	Thu,  1 Oct 2026 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848662; cv=none; b=d4vpIyRbHwlGkrQMGdHA/uNQ7NpF0KaHvlLQA76AeYY9nAoIfFHAuROirTl06hiT3icougRNC9Nr5mrDFAyOVnooG8CZSbrLQ/DMUx57fB1W7yDs0acZTulSmXZn01xQ9V1IZcUlvapoY+8Q/FK/SACV0KG2FB15RKhkutVzdI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848662; c=relaxed/simple;
	bh=EOfi+HY/I3WQGblEEur6uvnizEyEsPz9kNUWUC/OcPI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H/RarfBO9N86JUkvk9He9VMbd9j1Q9jSRgLqIZh7io7efXMF3HUNhnuEMLDq4ccZppHq3+WZTlfS/hhkHChnrVAfer3wdvt+RSLCZKpe0Rx4nsWyh3CajniiD7ng7SaqcQr23Bjiw2NEkMcup1MuHwWMEGYnoqd1FQc3BsexHjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZOnftTJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZOnftTJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CC11F000FF;
	Thu,  1 Oct 2026 09:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790848660;
	bh=UhpsLeycjK0VgnF8MAHhIKQDQjwWcqvckbnNrIcB6Sg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GZOnftTJVNp6O0WxyvRdjRvXc20ru8txxJRstXJNwEy2JBPlORgN7MCwzpV4wwzMr
	 418vBlX1pbScqN6K6VHjXK6KyR36+Fgtr3ejfzjGEFrY3MoK0CamQs8dzqCIgL7ABo
	 V7+QN33ovFNxMHjyqAPEj0CHpj9rIpngti5ewFSq7Dio4Jjj2vkz7QqHKTRGS+WFwi
	 +nSNZD4I/rXHAw60pBKsIUp1j2xoeC3LPAUJ98beOmE8Z1O72sonZZ+xbnRujYFp8Q
	 blHEJvj4MHGymnri/HXgl8pTm+YCK5IPqZUisiiGGBpsuBs2a2onThH+jrJTIogy2L
	 /68KNYmhbWSUA==
Subject: Re: [PATCH net v3] octeontx2-af: Fix BPID leak in nix_bp_enable()
From: netdev-bot+sashiko@kernel.org
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 rkudurumalla@marvell.com, sgoutham@marvell.com, rkannoth@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org
Date: Thu, 01 Oct 2026 09:57:39 +0000
Message-ID: <179084865947.434549.9597991757798875277@kernel.org>
In-Reply-To: <20260928065718.3378580-1-nshettyj@marvell.com>
References: <20260928065718.3378580-1-nshettyj@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 3 (1) · Medium: 3 (3) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] BPIDs can still leak permanently after this patch, so the fix is
  incomplete.
- [High] After a BPID is freed, NIX_AF_RX_CHANX_CFG still holds it, so a
  later disable can free it a second time.
- [High] A malformed LBK request can now hang the AF mailbox worker
  forever in the new nix_bp_enable_unwind().
- [Medium] The commit message leaves out the most important fix in the
  patch, plus two behaviour changes.
- [Medium] nix_bp_enable_unwind() works out which BPIDs to release by
  reading NIX_AF_RX_CHANX_CFG outside rvu->rsrc_lock, instead of…
- [Medium] When an enable fails partway, the new nix_bp_enable_unwind()
  turns backpressure off on channels that already had it before the…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is serious.
- [Medium] For LBK, rvu_nix_get_bpid() allocates a new BPID from the free
  pool on every call and ignores req->bpid_per_chan.
- [Medium] The response encoding in nix_bp_enable() loses the top channel
  bit.
- [Medium] nix_bp_disable() frees the BPID found in the target channel's
  CFG register without checking bp->fn_map[bpid - free_pool_base] ==…

--

octeontx2-af: Fix BPID leak in nix_bp_enable()

This patch moves the LBK BPID allocation in nix_bp_enable() into the
per-channel loop, so no extra BPID is allocated after the last channel. It
also rejects requests with chan_cnt == 0. It adds a range check before
freeing in nix_bp_disable(), a new nix_bp_enable_unwind() helper for
mid-loop failures, and reports each channel's programmed BPID in the
mailbox response.

> Move the allocation into the loop body so it runs exactly once per
> channel actually programmed, and reject req->chan_cnt == 0 upfront.

[Severity: Medium]
The commit message only covers the extra rvu_nix_get_bpid() call and the
chan_cnt == 0 check. Should it also describe the other three changes?

The first is the new range check in nix_bp_disable(). Before this patch, a
bpid below free_pool_base passed a negative id to rvu_free_rsrc(), and
__clear_bit() wrote before the start of bp->bpids.bmap. On silicon with
cpt_links this looks reachable on every open of an LBK VF. The never-armed
CPT channel has a BPID field below free_pool_base, and the open path always
sends the CPT disable:

otx2_init_hw_resources()
    otx2_nix_cpt_config_bp(pf, false);

The second is the new nix_bp_enable_unwind() rollback helper.

The third is the change in what rsp->chan_bpid[] reports for LBK. Each
channel now gets its own BPID instead of bpid_base.

These changes appear only in the v3 changelog below the --- line, which is
dropped when the patch is applied. The subject and the Fixes: tag say
nothing about the out-of-bounds write. Could the commit message describe
that fix so stable backporters can see it?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 153eb57bad06..1ef505009c3a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -631,6 +631,15 @@ static int nix_bp_disable(struct rvu *rvu,
>  
>  		if (type == NIX_INTF_TYPE_LBK) {
>  			bpid = cfg & GENMASK(8, 0);

[Severity: High]
This isn't a bug introduced by this patch, but the channel loop around this
code never checks req->chan_base or req->chan_cnt against the caller's
pfvf->rx_chan_cnt:

nix_bp_disable() {
    ...
	chan_base = pfvf->rx_chan_base + req->chan_base;
	for (chan = chan_base; chan < (chan_base + req->chan_cnt); chan++) {
		chan_v = nix_get_channel(chan, cpt_link);
		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v));
		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
			    cfg & ~BIT_ULL(16));
    ...
}

req->chan_base comes from the VF, which leads to three problems.

NIX_AF_RX_CHANX_CFG(a) is (0x1A30 | (a) << 15), and rvu_write64() uses
(block << 28) | offset. For channels >= 8192 the offset reaches bit 28.
Can the read-modify-write then land in NIX1, NPC or block 7 register
space?

A caller can also disarm or reprogram channels that belong to other
functions.

chan is a u16, but chan_base + req->chan_cnt is an int. If the sum is above
0xFFFF, chan wraps, and nothing in this loop can fail. Could a single
NIX_BP_DISABLE or NIX_CPT_BP_DISABLE from a CGX-mapped PF/VF or an LBK VF
spin the AF mailbox worker forever?

The LBK path in nix_bp_enable() has the same gap. Unlike the CGX and SDP
cases, the LBK case in rvu_nix_get_bpid() checks no range. This patch
already changes both loops. Could it add channel range validation too?

> +			/* Ignore channels that were never armed with an LBK
> +			 * free-pool bpid (e.g. never enabled, or belonging
> +			 * to a CGX/SDP range) - bpid - free_pool_base would
> +			 * underflow and corrupt an unrelated bitmap word.
> +			 */
> +			if (bpid < bp->free_pool_base ||
> +			    bpid >= bp->free_pool_base + bp->bpids.max)
> +				continue;

[Severity: High]
The comment says this skips channels that were never armed. The check only
tests the BPID range, though, and ignores BIT(16) and fn_map. Can a stale
BPID that is still in range get freed a second time here?

nix_bp_disable() and the new nix_bp_enable_unwind() both clear only
BIT(16). CFG[8:0] still holds the BPID they just returned to the pool:

	rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
		    cfg & ~BIT_ULL(16));

rvu_nix_flr_free_bpids() frees BPIDs without touching NIX_AF_RX_CHANX_CFG
at all.

This sequence looks possible:

  VF A armed with BPID X
  VF A disabled, unwound or FLRed, X returned to the pool
  VF B allocates X
  VF A sends NIX_BP_DISABLE or NIX_CPT_BP_DISABLE
    (otx2_init_hw_resources() sends the CPT one on every open)
  nix_bp_disable() reads stale X from A's channel, passes the range
    check, and frees B's BPID
  VF C allocates X

B and C then share one hardware BPID, and B's fn_map/ref_cnt no longer
match the bitmap. Clearing CFG[8:0] on release, or checking BIT(16) and
fn_map ownership before freeing, would avoid this. Would either approach
work here?

> +
>  			mutex_lock(&rvu->rsrc_lock);
>  			rvu_free_rsrc(&bp->bpids, bpid - bp->free_pool_base);

[Severity: Medium]
This is a pre-existing issue, but nix_bp_disable() frees whatever BPID it
finds in the target channel's CFG register. It never checks that
bp->fn_map[bpid - bp->free_pool_base] == pcifunc.

req->chan_base isn't validated, so could a VF name another function's
channels, free that function's LBK BPID and clear its BP_ENA bit?

The fn_map loop that follows clears only entries the caller owns. The
victim's fn_map/ref_cnt stay set while its bitmap bit is cleared, and the
next rvu_alloc_rsrc() hands the BPID out again. The new range check keeps
the index in bounds, but it does not check ownership.

[ ... ]

> @@ -738,6 +747,35 @@ static int rvu_nix_get_bpid(struct rvu *rvu, struct nix_bp_cfg_req *req,
>  	return bpid;
>  }
>  
> +static void nix_bp_enable_unwind(struct rvu *rvu, struct nix_bp *bp,
> +				 int blkaddr, u16 chan_base, int chan_cnt,
> +				 int type, bool cpt_link)
> +{
> +	u16 chan, chan_v, bpid;
> +	u64 cfg;
> +
> +	for (chan = chan_base; chan < chan_base + chan_cnt; chan++) {

[Severity: High]
Can this loop run forever? chan is a u16, but chan_base + chan_cnt is an
int. When chan_base + chan_cnt >= 0x10000, chan wraps to 0 before it
reaches the limit.

For LBK, rvu_nix_get_bpid() never checks req->chan_base or req->chan_cnt.
A VF can therefore pick req->chan_base so that the u16 chan_base in
nix_bp_enable() is 0xFFFF, and send chan_cnt >= 2. Then:

nix_bp_enable()
    for (chan = chan_base; ...) wraps chan past 0xFFFF
        rvu_nix_get_bpid() allocates an LBK BPID on each pass
    rvu_nix_get_bpid() fails once the pool is empty
    nix_bp_enable_unwind(rvu, bp, blkaddr, chan_base, chan_id, ...)
        chan <= 0xFFFF < 0xFFFF + chan_id, so the loop never exits

Each pass does an MMIO read-modify-write on NIX_AF_RX_CHANX_CFG(chan_v),
including addresses outside the NIX block. It also takes rsrc_lock, and
there is no cond_resched(). Before this patch the same request returned
-EINVAL.

There is a related concern about the new response write in
nix_bp_enable():

	rsp->chan_bpid[chan_id] = ...

chan_id is now bounded only by the number of successful allocations. The
old response loop was bounded by req->chan_cnt. If bp->bpids.max is larger
than NIX_MAX_BPID_CHAN, could the wrapping loop write past the end of
rsp->chan_bpid[]?

> +		chan_v = nix_get_channel(chan, cpt_link);
> +		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v));
> +		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
> +			    cfg & ~BIT_ULL(16));

[Severity: Medium]
Does this turn off backpressure on channels that were already armed before
the request? nix_bp_enable() doesn't check whether a channel already has
BIT(16) set, and it doesn't save the original NIX_AF_RX_CHANX_CFG value. It
simply overwrites CFG[8:0] with a new BPID.

Suppose an LBK VF re-sends NIX_BP_ENABLE for channels that are already
armed, and a later iteration fails. One example is a 2-channel request when
only one BPID is free. The unwind then clears BIT(16) on every channel
programmed so far.

A channel that had working backpressure with BPID P ends up with
backpressure off and a freed BPID in CFG. P stays allocated, and nothing
refers to it.

Before this patch, the same failure left the channel armed.

> +
> +		if (type != NIX_INTF_TYPE_LBK)
> +			continue;
> +
> +		bpid = cfg & GENMASK_ULL(8, 0);
> +		if (bpid < bp->free_pool_base ||
> +		    bpid >= bp->free_pool_base + bp->bpids.max)
> +			continue;
> +
> +		mutex_lock(&rvu->rsrc_lock);
> +		rvu_free_rsrc(&bp->bpids, bpid - bp->free_pool_base);
> +		bp->fn_map[bpid - bp->free_pool_base] = 0;
> +		bp->ref_cnt[bpid - bp->free_pool_base] = 0;
> +		mutex_unlock(&rvu->rsrc_lock);

[Severity: Medium]
The unwind reads NIX_AF_RX_CHANX_CFG outside rsrc_lock to decide which
BPIDs to release. It then frees each one and zeroes fn_map/ref_cnt without
checking that fn_map[idx] == pcifunc. Can this race with an FLR of the
same VF?

__rvu_flr_handler() takes only rvu->flr_lock before it calls
rvu_nix_flr_free_bpids(). rvu_afvf_mbox_handler() takes no lock at all, so
the two can run at the same time:

  VF A: nix_bp_enable() iteration 0 allocates X and programs it
  FLR of A: rvu_nix_flr_free_bpids() frees X, register still holds X
  VF B: allocates X
  VF A: iteration 1 fails, nix_bp_enable_unwind() reads X from A's
        channel, frees it and zeroes fn_map[X]/ref_cnt[X]

B's live BPID is back in the pool, and the next allocation gives it to a
third function. Could the unwind free only the BPIDs this call allocated,
instead of reading them back from hardware?

nix_bp_disable() has the same pattern. It frees based only on the register
value and the range check.

> +	}
> +}

[ ... ]

> @@ -764,16 +805,27 @@ static int nix_bp_enable(struct rvu *rvu,

[ ... ]

>  	for (chan = chan_base; chan < (chan_base + req->chan_cnt); chan++) {
> +		bpid = rvu_nix_get_bpid(rvu, req, type, chan_id);

[Severity: Medium]
This isn't a bug introduced by this patch, but for LBK, rvu_nix_get_bpid()
allocates a new BPID from the free pool on every call and ignores
req->bpid_per_chan. mbox.h documents:

	/* bpid_per_chan = 0 assigns single bp id for range of channels */

With bpid_per_chan = 0 and chan_cnt > 1, shouldn't all the channels share
one BPID? In non-PFC mode the NIC side uses only pfvf->bpid[0] for CQ/aura
BPIDs. The BPIDs programmed on channels 1..n would then never be asserted,
and they still use up pool entries.

This patch keeps the allocation on every iteration and only changes the
response to report the per-channel BPIDs. In-tree LBK VFs skip
NIX_BP_ENABLE, so only other mailbox clients are affected.

[ ... ]

> @@ -783,16 +835,17 @@ static int nix_bp_enable(struct rvu *rvu,
>  		cfg &= ~GENMASK_ULL(8, 0);
>  		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
>  			    cfg | (bpid & GENMASK_ULL(8, 0)) | BIT_ULL(16));

[Severity: High]
Can BPIDs still leak permanently after this patch? For LBK, every enable
allocates a fresh BPID and overwrites CFG[8:0], without checking whether
the channel already holds one.

nix_bp_disable() then frees only the BPID it reads from each channel's
register. However, it clears ownership for every free-pool entry this
pcifunc owns:

nix_bp_disable() {
    ...
	rvu_free_rsrc(&bp->bpids, bpid - bp->free_pool_base);
	for (bpid = 0; bpid < bp->bpids.max; bpid++) {
		if (bp->fn_map[bpid] == pcifunc) {
			bp->fn_map[bpid] = 0;
			bp->ref_cnt[bpid] = 0;
    ...
}

rvu_nix_flr_free_bpids() only reclaims entries where fn_map[idx] ==
pcifunc. Any other BPID the function still holds keeps its bitmap bit set
with fn_map == 0, and nothing ever frees it.

Two sequences seem to hit this:

  An LBK VF sends NIX_BP_ENABLE, NIX_BP_ENABLE, then NIX_BP_DISABLE. The
  second enable overwrites the first BPID in CFG. The disable frees only
  the second BPID but wipes fn_map for both, so the first BPID is lost
  until the AF reloads.

  A VF enables RX BP (BPID A) and CPT BP (BPID B), disables RX BP, and
  then goes through FLR. The disable already wiped fn_map[B], so the FLR
  skips B.

Each round leaks one BPID from the shared LBK pool. Once the pool is
empty, NIX_BP_ENABLE fails with NIX_AF_ERR_INVALID_BPID for every LBK VF.

The new comment in nix_bp_enable() says "don't leak until an FLR". Doesn't
this path prevent the FLR from reclaiming them?

[ ... ]

> +		rsp->chan_bpid[chan_id] = ((req->chan_base + chan_id) & 0x7F) << 10 |
> +					  (bpid & 0x3FF);
> +		chan_id++;

[Severity: Medium]
This is a pre-existing issue, but the rewritten line keeps the old encoding,
which doesn't fit in a u16 chan_bpid[] element. 0x7F << 10 is 0x1FC00,
which needs 17 bits, so bit 6 of the channel index is lost.

mbox_handler_nix_bp_enable() on the NIC side decodes a 7-bit channel index:

	chan_id = ((rsp->chan_bpid[chan] >> 10) & 0x7F);

Won't channel indices >= 64 then alias onto lower pfvf->bpid[] entries?
struct nix_bp_cfg_rsp is sized for NIX_MAX_BPID_CHAN (256) channels, which
this encoding cannot represent. In-tree CGX requests stay well below 64
channels, so only SDP or LBK requests with more than 64 channels hit this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928065718.3378580-1-nshettyj%40marvell.com
