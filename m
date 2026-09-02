Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB284AA57B;
	Wed,  2 Sep 2026 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369887; cv=none; b=OvmbKpHSjUnhA2Sb6wnq1F1pjsD66XkCxip+dRuF1KTPT+0nYScJBFr9aMG6W57pDymo+MzP6G18YYqCbwgfdJgeq99nXl8OP3iNXzhI0RqGNPo6immzRKJn2cFKifYgBHn3/qO/vTOxwqHzlhca2UNn4v0jD9/1iHf9mc8zHxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369887; c=relaxed/simple;
	bh=M4X2t9nAZX4ILle1WH1kSNm7rcPKOkuKxQpYK7ZD3WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6vVMm/oaoVY2T3iXWugrRhm6rpoGydQ/PshsA74r2vrNFo9MMJp8DahtGKRKUQdAuF4PJ4xSTUBuR1LssPTl1cgQCG2KERQi6merFO8FWtrYpFeW+yMYzQw+YdKICWbzZSPE+uGzJhph7G87lY1w2upWXyn1B5pSPVTh0q8wSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaaXxoRM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaaXxoRM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1644B1F000E9;
	Wed,  2 Sep 2026 17:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788369885;
	bh=u0FcC/n2mEu42mIJXvQodCPpJc0ka2ZEHdUpAh1nQu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZaaXxoRMazHI/zl6usYVZ6wbuly4GGIF1Sj5TgBiuFF6tKYgsJg5cU74qEQ2afL0n
	 jR/exydyvOxHinoJa0uvt8Mr3I8ndI0HDg8Mqx6e8HtOXp9XgvL478HDNqWTtaAhBc
	 0hLjvAP7Pq4cpaNZFju2r7laJbyZpHLY+o261WGOfk7XE8SYHBj1i5Of+xptKbTayC
	 ysEgho6uGsl1x++lukfvDyAr3qx7urqyH0ga7sXuxGES48s4fgcq0G+extQimO9e+i
	 BOXk1jRiI8pKtOPJyvpm2+dqYVNzZErLY2w6uF53lQTY/Zd0GPELopCtaMyfw6/qlE
	 Wo8dyRw60O88A==
From: Simon Horman <horms@kernel.org>
To: rkannoth@marvell.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	hkelam@marvell.com,
	linux-kernel@vger.kernel.org,
	naveenm@marvell.com,
	netdev@vger.kernel.org,
	sgoutham@marvell.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v3 net] octeontx2-pf: reset HTB scheduler topology before freeing queues
Date: Wed,  2 Sep 2026 18:24:28 +0100
Message-ID: <20260902172428.534936-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828035231.46911-1-rkannoth@marvell.com>
References: <20260828035231.46911-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828035231.46911-1-rkannoth@marvell.com?part=1
---
octeontx2-pf: reset HTB scheduler topology before freeing queues

This adds otx2_qos_reset_schq_topology() and a wrapper
otx2_qos_free_hw_schq() so that NIX_AF_TLxX_TOPOLOGY is zeroed for TL4
through TL2 before a QoS scheduler queue is returned to the AF.  The new
wrapper replaces otx2_txschq_free_one() in the class node teardown path and
in the cfg rollback path.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> index 69c0911e28e91..ab9661334e6f9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> @@ -235,6 +235,58 @@ static int otx2_qos_txschq_set_parent_topology(struct otx2_nic *pfvf,
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
> +	else
> +		cfg->reg[0] = NIX_AF_TL1X_TOPOLOGY(schq);
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

[Severity: Low]
The trailing else here cannot be reached.  In the mbox level enum
NIX_TXSCH_LVL_TL4 is 1, TL3 is 2, TL2 is 3 and TL1 is 4, and the guard
at the top of otx2_qos_reset_schq_topology() already bails out with:

	if (lvl < NIX_TXSCH_LVL_TL4 || lvl >= NIX_TXSCH_LVL_TL1)
		return 0;

so only lvl 1, 2 and 3 ever get past it, and those three values are
exhaustively covered by the TL4/TL3/TL2 arms above.  The
NIX_AF_TL1X_TOPOLOGY(schq) assignment is dead code.

Beyond being unreachable, it actively contradicts the commit message,
which says the aggregation level is deliberately skipped because TL1 is
shared with the PF, the default Tx hierarchy and the VFs and is never
returned to the AF by nix_txschq_free_one().  A reader who only sees the
else arm will conclude the opposite, and if the guard is ever relaxed the
function will silently start zeroing a TL1 TOPOLOGY that other users
depend on.

Would you drop the else arm and make the last case an explicit
"else if (lvl == NIX_TXSCH_LVL_TL2)", or convert the chain to a switch
with the TL1 case omitted, so the code and the commit message agree on
which levels are handled?

[Severity: High]
Was otx2_qos_free_hw_node_schq() intentionally left on the bare
otx2_txschq_free_one() path?  It still reads:

drivers/net/ethernet/marvell/octeontx2/nic/qos.c:otx2_qos_free_hw_node_schq() {
	list_for_each_entry_reverse(node, &parent->child_schq_list, list)
		otx2_txschq_free_one(pfvf, node->level, node->schq);
}

These child_schq_list entries are the intermediate chain created by
otx2_qos_alloc_txschq_node() for every level from node->level - 1 down to
MDQ:

	for (lvl = node->level - 1; lvl >= NIX_TXSCH_LVL_MDQ; lvl--) {

so they sit at exactly the TL4/TL3/TL2 levels the commit message says are
sanitized.

They also carry TOPOLOGY, since otx2_qos_txschq_push_cfg_schq() programs it
for each chain entry's parent:

	list_for_each_entry(tmp, &node->child_schq_list, list) {
		ret = otx2_qos_txschq_config(pfvf, tmp);
		if (ret)
			return -EIO;
		ret = otx2_qos_txschq_set_parent_topology(pfvf, tmp->parent);

Two cases where those chain schqs would reach nix_txschq_free_one() with a
non-zero TOPOLOGY:

1) HTB set up while the interface is down.  otx2_qos_push_txschq_cfg() and
   otx2_qos_root_add() only fill the cfg and skip hardware programming:

	if (!(pfvf->netdev->flags & IFF_UP)) {
		otx2_qos_txschq_fill_cfg(pfvf, node, cfg);
		return 0;
	}

   A following "tc qdisc del" while still down goes
   otx2_qos_root_destroy() -> otx2_qos_destroy_node() ->
   otx2_qos_free_hw_cfg() -> otx2_qos_free_hw_node_schq(), returning the
   queue with whatever TOPOLOGY the previous owner left.

2) A partially failed push, for example otx2_qos_txschq_update_config()
   failing in the restore paths of otx2_qos_leaf_to_inner() /
   otx2_qos_leaf_alloc(), or otx2_qos_config_txschq() failing on ifup.  The
   chain is left unprogrammed and later freed through the same helper.

On the AF side nix_txschq_free_one() only touches XOFF, linkcfg, shaping and
schedule:

drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:nix_txschq_free_one() {
	nix_clear_tx_xoff(rvu, blkaddr, lvl, schq);
	nix_reset_tx_linkcfg(rvu, blkaddr, lvl, schq);
	nix_reset_tx_shaping(rvu, blkaddr, nixlf, lvl, schq);
	...
	nix_reset_tx_schedule(rvu, blkaddr, lvl, schq);
}

so a stale PRIO_ANCHOR/RR_PRIO in those chain queues would still survive
into the shared pool, which is the case the commit message describes.

> @@ -252,7 +304,7 @@ static void otx2_qos_free_hw_node(struct otx2_nic *pfvf,
>  	list_for_each_entry_safe(node, tmp, &parent->child_list, list) {
>  		otx2_qos_free_hw_node(pfvf, node);
>  		otx2_qos_free_hw_node_schq(pfvf, node);
> -		otx2_txschq_free_one(pfvf, node->level, node->schq);
> +		otx2_qos_free_hw_schq(pfvf, node->level, node->schq);
>  	}
>  }
>  
> @@ -913,7 +965,7 @@ static void otx2_qos_free_cfg(struct otx2_nic *pfvf, struct otx2_qos_cfg *cfg)
>  	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
>  		for (idx = 0; idx < cfg->schq[lvl]; idx++) {
>  			schq = cfg->schq_list[lvl][idx];
> -			otx2_txschq_free_one(pfvf, lvl, schq);
> +			otx2_qos_free_hw_schq(pfvf, lvl, schq);
>  		}
>  	}
>  

Is the difference between the two paths deliberate?  cfg->schq_list is
filled from child_schq_list by otx2_qos_read_txschq_cfg_schq(), so the
rollback path here does reset TOPOLOGY for the same queues that the
hierarchy teardown in otx2_qos_free_hw_node_schq() frees without a reset.
Would routing the child_schq_list loop through otx2_qos_free_hw_schq() as
well make the two paths symmetric?

[ ... ]
