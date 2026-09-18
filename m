Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F1A2F7F02;
	Fri, 18 Sep 2026 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727482; cv=none; b=AAnWBJLlmGvbE8YcJNBE4F1PsI0ufICZMjNNg6EAI5vyab/cuGvho0NRjsqhsST48fZWb3dvxWVcdwhRvkpUvTseIYW7OErUQHoSDEwnZB3q41AJaeZqI4nfzMh2uhNxe67Qx9naRqnhiyLtBxwnIY5ChMeAutpJyBHmpFvHwxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727482; c=relaxed/simple;
	bh=ZqqA2okcK9T9B21cSdzuy9gaf0TwWn4UjOnK9Ss/Hyc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dc1/3v/7+tfhoSl7XzGUgPTES0vQPeaGzg2IAeMoOOGkNDcmXw2u/pv/3au1EuFvsmb+P+8Mn1PVWJQfM3cZTEmw/mou8NDO3fzminrx6vwC/ie4XG5bSwF18BKfzKbxJhWE1bYVFTHVDb/U3xxTKJUun3cEpWpuDRW6quhl1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfEUuJyi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfEUuJyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE641F00893;
	Fri, 18 Sep 2026 10:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727480;
	bh=F8/sHQW/v/sgH0s98jk5354G9LroilOQ1TMryG6E6Vc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YfEUuJyi3QzYdXpyRS1qS3GydgPvYn3JKC7qQExY3U4TiGgXYof05zLbRm1hxTtjm
	 PYrmp4/ZpjnNOL2kzUrNb8rcn4MaMpuw7Vfs63toREJU9KWxZr3S49rP5cAOLz3Mf8
	 IpA74hNXyqrDo3zu9AoW+hpUTWZed2XjOm6/n1Rw/rGXZNO478E9mry7xI+2jnrcZx
	 FqhFA0rRnlWcnpdea2yxNJbVu/MmZxCi/W4J7iN8HhUt90Y4QD5atV+8Tx1XsqkJHI
	 DGmKN2BOKmY1skj+YRPa0jhnkhrRa3aIJHbaUZVm0UMuBrglQRzGtGSnLcN9UHdL/A
	 wOB5cyY1pwr4w==
Subject: Re: [PATCH net] octeontx2-af: nix: Fix TX vtag upper bits programming
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, naveenm@marvell.com,
 netdev@vger.kernel.org, sgoutham@marvell.com, vattunuru@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, sbhatta@marvell.com
Date: Fri, 18 Sep 2026 10:31:19 +0000
Message-ID: <178972747903.22033.9265631093980831113@kernel.org>
In-Reply-To: <20260915073058.992915-1-rkannoth@marvell.com>
References: <20260915073058.992915-1-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0

- [High] The statement added by this patch in nix_tx_vtag_alloc()
  (drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:3110), `regval |=…

Pre-existing issues:
- [High] In the same TX-VTAG mailbox path this patch modifies, the error
  path of nix_tx_vtag_cfg() (rvu_nix.c:3191-3193) calls…
- [High] In the same TX-VTAG mailbox path this patch touches, the free
  path uses a fully caller-controlled signed index from the mailbox…

--

octeontx2-af: nix: Fix TX vtag upper bits programming

This adds one statement to nix_tx_vtag_alloc() so that the vtag bits above
bit 47 also end up in NIX_AF_TX_VTAG_DEFX_DATA, with the aim of fixing TX
VLAN tag insertion when the extended vtag fields are used.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 153eb57bad067..091ef8dac7c94 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -3107,6 +3107,7 @@ static int nix_tx_vtag_alloc(struct rvu *rvu, int blkaddr,
>  	mutex_unlock(&vlan->rsrc_lock);
>  
>  	regval = size ? vtag : vtag << 32;
> +	regval |= (vtag & ~GENMASK_ULL(47, 0)) << 48;

[Severity: High]
Is this new term always zero?

~GENMASK_ULL(47, 0) is 0xffff000000000000, so the mask keeps bits 63:48
where they already are, and the following << 48 shifts them out of the
64-bit word:

	regval |= (vtag & 0xffff000000000000ULL) << 48;   /* == 0 */

If that is right, the value handed to rvu_write64() below is bit for bit
the same as before the patch, and the condition described in the changelog
("The upper bits of the vtag value above bit 47 were not written to
NIX_AF_TX_VTAG_DEFX_DATA") is still present.

The in-tree producer of those upper bits is rvu_rep_tx_vlan_cfg() in
rvu_rep.c, which packs the EtherType at vtag0[63:48] and asks for
VTAGSIZE_T4:

	req.vtag_size = VTAGSIZE_T4;
	req.cfg_type = 0; /* tx vlan cfg */
	req.tx.cfg_vtag0 = true;
	req.tx.vtag0 = FIELD_PREP(NIX_VLAN_ETYPE_MASK, etype) | vlan_tci;

with NIX_VLAN_ETYPE_MASK defined in rvu_reg.h as GENMASK_ULL(63, 48).
Since the field is already at its final register position, and since
size == 0 makes nix_tx_vtag_alloc() compute regval = vtag << 32 and drop
everything above bit 31, doesn't the representor path still program
EtherType 0 while the NIX_VTAG_CFG mailbox returns success?

Would something like this be the intended expression instead?

	regval |= vtag & NIX_VLAN_ETYPE_MASK;

>  
>  	rvu_write64(rvu, blkaddr,
>  		    NIX_AF_TX_VTAG_DEFX_DATA(index), regval);

[Severity: High]
This isn't a bug introduced by this patch, but while looking at the same
TX VTAG mailbox path: is the error path of nix_tx_vtag_cfg() missing
vlan->rsrc_lock?

	err_free:
		if (req->tx.cfg_vtag0)
			nix_tx_vtag_free(rvu, blkaddr, pcifunc, rsp->vtag0_idx);

Every other caller holds the mutex around it, for example
nix_tx_vtag_decfg():

	mutex_lock(&vlan->rsrc_lock);

	if (req->tx.free_vtag0) {
		err = nix_tx_vtag_free(rvu, blkaddr, pcifunc, idx0);

and nix_free_tx_vtag_entries() does the same.

nix_tx_vtag_free() ends in rvu_free_rsrc(), which is a non-atomic
read-modify-write:

	void rvu_free_rsrc(struct rsrc_bmap *rsrc, int id)
	{
		if (!rsrc->bmap)
			return;

		__clear_bit(id, rsrc->bmap);
	}

and rvu_alloc_rsrc() pairs find_first_zero_bit() with __set_bit() on the
same word. AF mailbox work items for different PF/VFs can run at the same
time (rvu_mbox_init() allocates the workqueue with max_active == num), so
can this interleaving lose an allocation?

CPU0 (nix_tx_vtag_cfg err_free, no lock)
	reads bitmap word

CPU1 (nix_tx_vtag_alloc, holds rsrc_lock)
	__set_bit(index, bmap)

CPU0
	writes back the stale word, clearing CPU1's bit

The same index could then be handed out twice, letting two PF/VFs share one
NIX_AF_TX_VTAG_DEFX_DATA/CTL entry, or the entry could be leaked in the
opposite interleaving. The ownership store
vlan->entry2pfvf_map[rsp->vtag0_idx] = pcifunc also happens outside the
lock, i.e. not atomically with the bitmap allocation done under it.

[Severity: High]
This is a pre-existing issue too, but in the deconfiguration side of the
same path: are the mailbox-supplied indices ever range checked?

nix_tx_vtag_decfg() takes them straight from the request, as signed int
fields of struct nix_vtag_config, and dereferences the map with them:

	int idx0 = req->tx.vtag0_idx;
	int idx1 = req->tx.vtag1_idx;
	...
	if (req->tx.free_vtag0 && req->tx.free_vtag1)
		if (vlan->entry2pfvf_map[idx0] != pcifunc ||
		    vlan->entry2pfvf_map[idx1] != pcifunc)
			return NIX_AF_ERR_PARAM;

Note that comparison only runs when both free flags are set. With just
free_vtag0 set, the index reaches nix_tx_vtag_free() unchecked:

	vlan = &nix_hw->txvlan;
	if (vlan->entry2pfvf_map[index] != pcifunc)
		return NIX_AF_ERR_PARAM;

entry2pfvf_map is a devm_kcalloc'd array of vlan->rsrc.max entries
(NIX_TX_VTAG_DEF_MAX is 0x400), so does this read out of bounds for a
negative or too-large index? And if the sampled u16 happens to equal the
sender's pcifunc, execution continues to:

	rvu_write64(rvu, blkaddr,
		    NIX_AF_TX_VTAG_DEFX_DATA(index), 0x0ull);
	rvu_write64(rvu, blkaddr,
		    NIX_AF_TX_VTAG_DEFX_CTL(index), 0x0ull);

	vlan->entry2pfvf_map[index] = 0;
	rvu_free_rsrc(&vlan->rsrc, index);

where the register offset is 0x1A10 | (index) << 16, the map store is an
out-of-bounds write, and rvu_free_rsrc() does __clear_bit() outside the
bitmap.

rvu_mbox_handler_nix_vtag_cfg() only validates the flag combination before
dispatching:

		if (req->tx.free_vtag0 || req->tx.free_vtag1)
			return nix_tx_vtag_decfg(rvu, blkaddr, req);

Should nix_tx_vtag_decfg() reject indices outside [0, vlan->rsrc.max)
before using them?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915073058.992915-1-rkannoth%40marvell.com
