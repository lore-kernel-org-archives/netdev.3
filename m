Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174372E22B5;
	Fri, 18 Sep 2026 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716578; cv=none; b=dEAlW5SDdNRD2kpPKtTZVofcQpq2V/rw3GuEYotKRQHsyrky3mA2E5X0xCb74pNfMbqkMR0iVx3n/FDhmPrZANDgObq+HUj9eeshCO9mo9a8hHcIm66JBJKUFPPk8zPKgbxj5GtuwLW56zdXO2B7iQHfX+NzGRolGJsVbPeC3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716578; c=relaxed/simple;
	bh=valHL9X0ETHGb1EYK1Z2cIIXIHVeLed9hWsXQh3INFI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y3Wt5dG9sZZs+WbrbEA7bAbvAWMuAnq16LGlszjMadTRKO8RNHOKkORp4X7VQdPpK+exrN7SIrg4aA6A2uuHGKlcxn5jx3lkfh5aW3fH1VWAMPoQYRSBxIpXy25nxT31qxl67Tvuh5E6ldVCp5IpMDnErjdIkbRJm2dYT5Od1J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNLgmBhJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNLgmBhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EA51F000FF;
	Fri, 18 Sep 2026 07:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789716573;
	bh=EB/EALPe9YnfHxvxf5+0Hr7CoVHdRA6vNL7f1QOjK2k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XNLgmBhJuHpee5/GkENr8NxVUL7zJsxLpqutuWBen1daiPYcKaTjoTr8UbiF64Nlg
	 8/BzEmu0hwibcAwujsGsp4MxuSdz/2rM8LX0sE56OZQWemXQWfRYmShMda8CbbDLjv
	 ZD1n2iK+MxRJcc+VhEImxZ4e78LbLbSJk2fcK3ijs3oh45GzyKaxUh5dA6JnjOmBxF
	 UTWLMIwRGOgK0tYsmRdEqBNKU2ZF5GCvDK2GIa/S7lE8UsxMHx+STOe7AKOvF6JX+C
	 gWYTzl5YkFjUpUnSjkYW7gwBWEtEb//9qEPDXAwG4HNDEzqu7GVLzUCTwfnkD77lVD
	 56W6uIiQtw0fw==
Subject: Re: [PATCH net] octeontx2-af: nix: Fix NIX LF allocation for
 representor devices
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: davem@davemloft.net, gakula@marvell.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
 sbhatta@marvell.com
Date: Fri, 18 Sep 2026 07:29:32 +0000
Message-ID: <178971657276.22033.17152200539540497538@kernel.org>
In-Reply-To: <20260915072711.985075-1-rkannoth@marvell.com>
References: <20260915072711.985075-1-rkannoth@marvell.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

- [Medium] Representor TX-link inconsistency inside the AF:
  rvu_mbox_handler_nix_lf_alloc() now reports `rsp->tx_link =…
- [Medium] Two uncoordinated writers now program the same
  NIX_AF_TL3_TL2X_LINKX_CFG(schq, LBK link) register for a representor's…

--

octeontx2-af: nix: Fix NIX LF allocation for representor devices

This patch reports the LBK TX link and configures the LBK PKIND for
representor NIX LFs during nix_lf_alloc, and skips the MAC address copy
into the allocation response for representors.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 153eb57bad067..ed62ef336a730 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -1713,6 +1713,9 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>  	if (is_rep_dev(rvu, pcifunc)) {
>  		pfvf->tx_chan_base = RVU_SWITCH_LBK_CHAN;
>  		pfvf->tx_chan_cnt = 1;
> +		/* Setting the TX link as that of LBK */
> +		rsp->tx_link = hw->cgx_links;

[Severity: Medium]
Should nix_get_tx_link() also learn about representors here?

The response now tells the PF driver that the representor's TX link is
LBK link 0 (hw->cgx_links), but nix_get_tx_link() in the same file has no
is_rep_dev() case:

	if (is_lbk_vf(rvu, pcifunc)) {/* LBK links */
		return hw->cgx_links;
	} else if (is_pf_cgxmapped(rvu, pf)) {
		...
	}

	/* SDP link */
	return hw->cgx_links + hw->lbk_links;

The representor is a dedicated PF, so is_lbk_vf() is false (non-zero PF
bits) and is_pf_cgxmapped() is false, which appears to leave the SDP link
as the return value.

The sibling helpers already special-case representors, for example
nix_get_txschq_range():

	if (is_lbk_vf(rvu, pcifunc) || is_rep_dev(rvu, pcifunc)) {

and rvu_mbox_handler_nix_set_hw_frs():

	} else if (is_rep_dev(rvu, pcifunc)) {
		link = hw->cgx_links + 0;
	}

That value from nix_get_tx_link() is what rvu_mbox_handler_nix_txsch_alloc()
uses as the representor's aggregation-level schq index:

		link = nix_get_tx_link(rvu, pcifunc);

		if (lvl >= hw->cap.nix_tx_aggr_lvl) {
			start = link;
			end = link;

so the representor would be handed TL1 of the SDP link, and is_valid_txschq()
would group it with SDP functions for TL1 sharing. nix_txschq_free() then
clears SW_XOFF and CFG_DONE on that same TL1:

	nix_clear_tx_xoff(rvu, blkaddr, NIX_TXSCH_LVL_TL1,
			  nix_get_tx_link(rvu, pcifunc));

On a board that also has an SDP PF, can the representor and the SDP function
end up overwriting each other's TL1 configuration this way, while the link
reported to the driver for the same LF is LBK link 0?

[Severity: Medium]
With tx_link now pointing at the LBK link, does the PF driver end up
programming the same NIX_AF_TL3_TL2X_LINKX_CFG register that the AF switch
path programs, but with a different value?

The driver side in otx2_txschq_config() writes:

		if (lvl == hw->txschq_link_cfg_lvl &&
		    !is_otx2_sdp_rep(pfvf->pdev)) {
			req->reg[2] = NIX_AF_TL3_TL2X_LINKX_CFG(schq, hw->tx_link);
			req->regval[2] = BIT_ULL(13) | BIT_ULL(12) | prio;

that is ENA | BP_ENA | relative channel 0, and is_otx2_sdp_rep() only matches
0xA0F7, so the 0xA0E0 representor is not excluded.

The AF side programs the same registers for the same representor schqs in
rvu_nix_tx_tl2_cfg():

	cfg = enable ? (BIT_ULL(12) | RVU_SWITCH_LBK_CHAN) : 0;
	lbk_link_start = hw->cgx_links;
	...
			rvu_write64(rvu, blkaddr,
				    NIX_AF_TL3_TL2X_LINKX_CFG(schq, lbk_link_start + lbk_links), cfg);

that is ENA | relative channel 63, without BP_ENA. Prior to this change the
driver's write targeted link 0 (a CGX link), so it did not overlap the AF's
LBK link programming.

Which write lands last looks ordering dependent. If the AF devlink is already
in switchdev mode when the representors are created,
rvu_devlink_eswitch_mode_set() returns early:

		if (rswitch->mode == mode)
			return 0;

so rvu_rep_pf_init() -> rvu_switch_enable_lbk_link() does not re-run and the
driver's relative channel 0 plus BP_ENA remains the final state, rather than
channel 63 that the switch path and the TX MCAM rule
(req.index = (lbkid << 8) | RVU_SWITCH_LBK_CHAN in rvu_rep.c) expect. In the
other order the AF write clears the driver's BP_ENA. Is one of the two writers
meant to be the owner of this register for representors?

>  		goto exit;
>  	}
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915072711.985075-1-rkannoth%40marvell.com
