Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0502A5908CB;
	Tue,  8 Sep 2026 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887263; cv=none; b=uCaNRVUFxVH9jV8na94uw/KyjpoB84JnX7IkeZED+OqCMifQNqLAy2g+on3wCGX1HLI6663qfNky2LoYThKPr7dnnDnjxUt/VoPSeQTDPbrjw9Kovvt2SUspnbYFw6+gS7iSfqvYqHNrJDqzZsBKiRvJ02jSfEXF1wbbIsqyNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887263; c=relaxed/simple;
	bh=7jybtTARDbLiDN7g47KofFv0D/a1zezV6RwS8xfnTWk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UFLNWI/lDDWV5YLLPNmKbVAogD5ELvHwBA2fsU8Qbw1uR9qZyHnQiSb2Ux3LLtONrbZLYRwwFiXbXmR2xiLXgrPtQrMS+fy09YpkeiwHsV6J723yusAHdOpfnnKKz0dIe88NtoAXKaC5SuGNSV6/FFla/EMGF7JD/W0PUVamRvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgnlZN/o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgnlZN/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268BD1F00A3A;
	Tue,  8 Sep 2026 17:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788887261;
	bh=zdNtkBOLC/SAMyuh+w73NAqwDKO7Dz8z8s85TF2kyro=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TgnlZN/ok5ROunEpXsd9pVV6ur12Pl/ioBV5q9Y859TM6QGlXGVyitkXPsUmVKr81
	 zIh/oQlEn+iFBeNHgkMnPifdZHegN5Ey8aNw77V5E7/gxVPKd7pfEidK+cb0R/FJs/
	 dQzuWFTjoB3wWSTlW+yzTnN261+kzy8gn6xm//dEOuayV8CCPizY/TTMXqGtlcacOO
	 Yrp6OGxw2tJrDszKfpllBWKJdmBc8vmgEHfalIvLU0Ysuiqx9cxPguEpi/thqtPNvK
	 BdBwdsZ1bdYkXq+pxEpWMK3UKygz/lvk3tbV3zRxFAOOzsltDswPngEyTy+Xwn2T6m
	 ycAGQ1MLcUpXQ==
Subject: Re: [PATCH v4 net] octeontx2-pf: reset HTB scheduler topology before
 freeing queues
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: davem@davemloft.net, hkelam@marvell.com, linux-kernel@vger.kernel.org,
 naveenm@marvell.com, netdev@vger.kernel.org, sgoutham@marvell.com,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Tue, 08 Sep 2026 17:07:40 +0000
Message-ID: <178888726063.219967.8664029829834628993@kernel.org>
In-Reply-To: <20260903020533.3068041-1-rkannoth@marvell.com>
References: <20260903020533.3068041-1-rkannoth@marvell.com>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

- [High] Incomplete fix: the stale-TOPOLOGY bug class the commit claims
  to close stays reachable through the AF's bulk release path.
- [Medium] Set/reset asymmetry at the aggregation level: HTB offload
  programs NIX_AF_TL1X_TOPOLOGY (PRIO_ANCHOR/RR_PRIO) on the shared per-…

--

octeontx2-pf: reset HTB scheduler topology before freeing queues

This adds otx2_qos_reset_schq_topology() and otx2_qos_free_hw_schq() so
that NIX_AF_TL{4,3,2}X_TOPOLOGY is zeroed before each QoS scheduler queue
is handed back to the AF during HTB hierarchy teardown and cfg rollback.
The aggregation level (TL1) is intentionally skipped.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> index 69c0911e28e9..f160b1618efa 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> @@ -235,13 +235,63 @@ static int otx2_qos_txschq_set_parent_topology(struct otx2_nic *pfvf,
>  	return rc;
>  }
>  
> +static int otx2_qos_reset_schq_topology(struct otx2_nic *pfvf, u16 lvl,
> +					u16 schq)
> +{
> +	struct mbox *mbox = &pfvf->mbox;
> +	struct nix_txschq_config *cfg;
> +	int rc;
> +
> +	if (lvl < NIX_TXSCH_LVL_TL4 || lvl >= NIX_TXSCH_LVL_TL1)
> +		return 0;

[Severity: Medium]
Should the TL1 case be handled here too, or at least commented in the
code?  otx2_qos_txschq_set_parent_topology() does program TL1:

	else if (parent->level == NIX_TXSCH_LVL_TL1)
		cfg->reg[0] = NIX_AF_TL1X_TOPOLOGY(parent->schq);

	cfg->regval[0] = (u64)parent->prio_anchor << 32;
	cfg->regval[0] |= ((parent->child_dwrr_prio != OTX2_QOS_DEFAULT_PRIO) ?
			    parent->child_dwrr_prio : 0)  << 1;

and for a PF the HTB root sits at that level, in otx2_qos_alloc_root():

	if (!is_otx2_vf(pfvf->pcifunc)) {
		node->level = NIX_TXSCH_LVL_TL1;

so otx2_qos_txschq_push_cfg_tl() -> otx2_qos_txschq_set_parent_topology()
writes NIX_AF_TL1X_TOPOLOGY with the HTB prio_anchor, which is the base
index of the contiguous TL2 child block.

On tc qdisc del, otx2_qos_root_destroy() -> otx2_qos_destroy_node() ->
otx2_qos_free_hw_cfg() calls otx2_qos_free_hw_schq(pfvf, node->level,
node->schq) with node->level == NIX_TXSCH_LVL_TL1, which takes the early
return above.

Does anything else restore the default TL1 topology while the interface
stays up?  nix_txschq_free_one() early-returns for lvl >=
hw->cap.nix_tx_aggr_lvl, nix_reset_tx_schedule() has no TL1 case, and
nix_tl1_default_cfg() declines to reprogram once the PF has configured
TL1:

	/* Skip if PF has already done the config */
	if (TXSCH_MAP_FLAGS(pfvf_map[schq]) & NIX_TXSCHQ_CFG_DONE)
		return;
	rvu_write64(rvu, blkaddr, NIX_AF_TL1X_TOPOLOGY(schq),
		    (TXSCH_TL1_DFLT_RR_PRIO << 1));

The only writer of the default TL1 value appears to be
otx2_txschq_config():

	req->reg[1] = NIX_AF_TL1X_TOPOLOGY(schq);
	req->regval[1] = hw->txschq_aggr_lvl_rr_prio << 1;

which runs at interface open rather than on TC_HTB_DESTROY.  So after HTB
teardown with the link up, the shared TL1 keeps a PRIO_ANCHOR pointing at
TL2 indices that were just returned to the AF's block-wide TL2 pool and
may be re-allocated to another function.

The commit message says TL1 "is not freed back to the AF by
nix_txschq_free_one()", which rules out re-allocating TL1 itself, but does
it cover the residual anchor pointing into recycled TL2 indices?  Whether
the TL1 arbiter can act on such a stale anchor depends on hardware
semantics that are not visible from the tree, so this may be harmless in
practice, but the set/reset asymmetry looks worth spelling out in the code
rather than only in the changelog.

> +
> +	mutex_lock(&mbox->lock);
> +
> +	cfg = otx2_mbox_alloc_msg_nix_txschq_cfg(mbox);
> +	if (!cfg) {
> +		mutex_unlock(&mbox->lock);
> +		return -ENOMEM;
> +	}
> +
> +	cfg->lvl = lvl;
> +	cfg->num_regs = 1;
> +
> +	if (lvl == NIX_TXSCH_LVL_TL4)
> +		cfg->reg[0] = NIX_AF_TL4X_TOPOLOGY(schq);
> +	else if (lvl == NIX_TXSCH_LVL_TL3)
> +		cfg->reg[0] = NIX_AF_TL3X_TOPOLOGY(schq);
> +	else if (lvl == NIX_TXSCH_LVL_TL2)
> +		cfg->reg[0] = NIX_AF_TL2X_TOPOLOGY(schq);
> +
> +	cfg->regval[0] = 0;
> +
> +	rc = otx2_sync_mbox_msg(mbox);
> +
> +	mutex_unlock(&mbox->lock);
> +
> +	return rc;
> +}
> +
> +static void otx2_qos_free_hw_schq(struct otx2_nic *pfvf, u16 lvl, u16 schq)
> +{
> +	int err;
> +
> +	err = otx2_qos_reset_schq_topology(pfvf, lvl, schq);

[Severity: High]
Does this cover the case where the AF, not the driver, releases the QoS
queues?  The reset only runs on the driver's explicit per-schq frees, but
nix_txschq_free() in af/rvu_nix.c returns the same TL4/TL3/TL2 indices to
the shared pool with only PARENT and SCHEDULE cleared:

	nix_reset_tx_schedule(rvu, blkaddr, lvl, schq);
	rvu_free_rsrc(&txsch->schq, schq);
	txsch->pfvf_map[schq] = TXSCH_MAP(0, NIX_TXSCHQ_FREE);

and nix_reset_tx_schedule() writes TLxX_PARENT and TLxX_SCHEDULE only, so
TOPOLOGY (PRIO_ANCHOR/RR_PRIO) stays programmed.

That path is reachable while an HTB qdisc is still offloaded, for example
on a function reset (echo 1 > /sys/bus/pci/devices/<bdf>/reset) or a VF
FLR from a passthrough guest:

rvu_flr_handler() -> rvu_blklf_teardown() -> rvu_nix_lf_teardown() ->
nix_txschq_free()

In that case otx2_qos_free_hw_schq() never runs, so the state the commit
message describes ("PRIO_ANCHOR/RR_PRIO settings can survive in the
shared scheduler pool and affect later allocations") is unchanged.

The allocation side also looks unsanitized.  nix_txschq_alloc() resets
linkcfg, shaping and schedule for every newly allocated schq:

	nix_reset_tx_linkcfg(rvu, blkaddr, lvl, schq);
	nix_reset_tx_shaping(rvu, blkaddr, nixlf, lvl, schq);
	nix_reset_tx_schedule(rvu, blkaddr, lvl, schq);

but not TOPOLOGY, and otx2_txschq_config() never writes TOPOLOGY for
TL2/TL3/TL4, so a new owner inherits whatever anchor was left behind.

Would adding the TLxX_TOPOLOGY register to nix_reset_tx_schedule() be a
better place for this?  That would cover free_one, TXSCHQ_FREE_ALL, FLR
and allocation-time inheritance for all AF clients under rvu->rsrc_lock,
and the driver-side helper added here would not be needed.

> +	if (err)
> +		netdev_warn(pfvf->netdev,
> +			    "QoS: failed to reset topology for schq %u at level %u: %d\n",
> +			    schq, lvl, err);
> +
> +	otx2_txschq_free_one(pfvf, lvl, schq);
> +}
> +
>  static void otx2_qos_free_hw_node_schq(struct otx2_nic *pfvf,
>  				       struct otx2_qos_node *parent)
>  {
>  	struct otx2_qos_node *node;
>  
>  	list_for_each_entry_reverse(node, &parent->child_schq_list, list)
> -		otx2_txschq_free_one(pfvf, node->level, node->schq);
> +		otx2_qos_free_hw_schq(pfvf, node->level, node->schq);
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903020533.3068041-1-rkannoth%40marvell.com
