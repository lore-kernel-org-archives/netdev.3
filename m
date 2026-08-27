Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1181F47426F;
	Thu, 27 Aug 2026 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837849; cv=none; b=QL9ThiWYBm1ufkB9ouPfK47BA/soD0L7B2IB8hu2v5K6KpkHoCsfftwrGHBaxj9fsnwdhcAR5BB5ndWzXYj0Ug99RLnVkPWGXSm93YYdCkkpmsoaPJf9tRSqa8xoidFBKFaFlhsttB5yCAOPxKZFRmuf2NgcObosfdMc0IwyqVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837849; c=relaxed/simple;
	bh=oY0c1AW+usFPalvGusOLX5O6JdebncBbHrokDzDAods=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yflf0cuJUURXxccqqfd7BZsRPZq6Ul3cLpcf9ImccLhQR+dRx/IaM4Cz2P2delr+1io4Dlt0Mj3sI7EDxnDVg+KI9L7uLjAn8mDW2ngWMCO26vTVzIMkZp4v6QWZBf8pv5hSTBKi4r5zvADiXzs3UVatcuthQilYpj+QpY2OLXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjJPsLHD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjJPsLHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B3D1F00A3A;
	Thu, 27 Aug 2026 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787837842;
	bh=Nv36OJs/i5N81A8w6VnsxH1bGMLmb+1yrGEItGrsKAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EjJPsLHDWlcdH9oc1cBBRFh+A5r1VkH6ZSeSmbXBpUIQM70sjTBYjZh5kAyvo9m+O
	 irLt8peeL/4RC/y31+osaY9sQ/kuJenQJ/kEzZYEAjZP6OWSCFdy9l+WeNjTjLqY39
	 2SZOjspV8OUsaJUehzctVCbAlb2/EVVVLnAwjhOVOMSiKjEubdH++OcMTznZBhS8zb
	 34DIfptVKRPo/zVeNdKqmEecg0SPzbvd9Y5ZyRIntBuOJDegmDq2fSxEVBSfZgrzry
	 qREY4rTOCLuRYf8K07kGzyofeWkIO7x267382H99g6+g3dxcLCTcZy18V9tPQgf0IO
	 xha+cG0Nt1xfA==
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
Subject: Re: [PATCH v2 net] octeontx2-pf: reset HTB scheduler topology before freeing queues
Date: Thu, 27 Aug 2026 14:37:06 +0100
Message-ID: <20260827133706.470757-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824072147.3524339-1-rkannoth@marvell.com>
References: <20260824072147.3524339-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824072147.3524339-1-rkannoth@marvell.com?part=1
---
octeontx2-pf: reset HTB scheduler topology before freeing queues

This patch adds otx2_qos_reset_schq_topology() and wraps
otx2_txschq_free_one() in a new otx2_qos_free_hw_schq() helper so that
NIX_AF_TLxX_TOPOLOGY is zeroed for TL1 through TL4 before an HTB scheduler
queue is handed back to the AF. The new helper is used in the hierarchy
teardown paths and in the cfg rollback path.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> index 69c0911e28e91..100342b68ffa2 100644
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
> +	if (lvl < NIX_TXSCH_LVL_TL4 || lvl > NIX_TXSCH_LVL_TL1)
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

[Severity: High]

The level guard admits NIX_TXSCH_LVL_TL1, so the trailing else writes
NIX_AF_TL1X_TOPOLOGY(schq) = 0.  Is zero the right value for TL1?

otx2_txschq_config() in otx2_common.c programs it with the aggregation
level RR priority:

	req->reg[1] = NIX_AF_TL1X_TOPOLOGY(schq);
	req->regval[1] = hw->txschq_aggr_lvl_rr_prio << 1;

and otx2_qos_root_add() depends on the same value for the HTB root:

	/* Update TL1 RR PRIO */
	if (root->level == NIX_TXSCH_LVL_TL1) {
		root->child_dwrr_prio = pfvf->hw.txschq_aggr_lvl_rr_prio;

On a PF the HTB root sits at TL1, since otx2_qos_alloc_root() does:

	if (!is_otx2_vf(pfvf->pcifunc)) {
		node->level = NIX_TXSCH_LVL_TL1;

so every qdisc delete now reaches the new code with lvl == TL1:

otx2_qos_root_destroy() -> otx2_qos_destroy_node() ->
    otx2_qos_free_hw_cfg() -> otx2_qos_free_hw_schq(pfvf, TL1, root->schq)

TL1 is the per-tx-link queue shared by the PF, its default (non-HTB) Tx
hierarchy and all of its VFs.  nix_txsch_alloc() hands out the same queue
for everyone on that link:

	if (lvl >= hw->cap.nix_tx_aggr_lvl) {
		start = link;
		end = link;

Can zeroing RR_PRIO and PRIO_ANCHOR there disturb DWRR arbitration for the
PF's ordinary traffic and for its VFs, whose TL2 SCHEDULE[PRIO] is
programmed with txschq_aggr_lvl_rr_prio?

The AF does apply the write when it comes from a PF.
rvu_mbox_handler_nix_txschq_cfg() only short-circuits aggregation level
writes issued by VFs:

	if (req->lvl >= hw->cap.nix_tx_aggr_lvl &&
	    pcifunc & RVU_PFVF_FUNC_MASK) {

and nix_tl1_default_cfg() will not put the default back, because
NIX_TXSCHQ_CFG_DONE is already set:

	/* Skip if PF has already done the config */
	if (TXSCH_MAP_FLAGS(pfvf_map[schq]) & NIX_TXSCHQ_CFG_DONE)
		return;

Since otx2_txschq_config() only runs at interface open, does the zeroed TL1
TOPOLOGY then persist until the interface is brought down and up again?

Separately, is the TL1 write useful at all?  nix_txschq_free_one() never
frees an aggregation level queue:

	if (lvl >= hw->cap.nix_tx_aggr_lvl || schq >= txsch->schq.max)
		return 0;

That makes the commit message wording "before returning it to the AF" and
"can survive in the shared scheduler pool and affect later allocations" not
apply at TL1, while the register write still lands.  Would skipping
lvl >= hw->cap.nix_tx_aggr_lvl, or writing
hw->txschq_aggr_lvl_rr_prio << 1 instead of 0, be more appropriate?

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

[Severity: Low]

This isn't a bug, but doing the sanitization in the PF/VF driver only covers
cooperative in-kernel HTB teardown.

nix_txschq_free() in rvu_nix.c (FLR, NIXLF free, VF removal) frees all of a
pcifunc's schqs through nix_reset_tx_linkcfg(), nix_clear_tx_xoff(),
nix_reset_tx_shaping() and nix_reset_tx_schedule(), and
nix_reset_tx_schedule() touches only PARENT and SCHEDULE:

	if (tlx_parent)
		rvu_write64(rvu, blkaddr, tlx_parent, 0x0);

	if (tlx_schedule)
		rvu_write64(rvu, blkaddr, tlx_schedule, 0x0);

So a PF or VF that is FLR'd while an HTB hierarchy is configured still
returns queues with PRIO_ANCHOR/RR_PRIO programmed, which is the state the
commit message describes.

Would clearing TOPOLOGY inside nix_reset_tx_schedule() cover all callers
instead, and also avoid the extra synchronous mbox message per freed schq
that this patch adds to teardown?

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

[ ... ]

> @@ -266,7 +318,7 @@ static void otx2_qos_free_hw_cfg(struct otx2_nic *pfvf,
>  	otx2_qos_free_hw_node_schq(pfvf, node);
>  
>  	/* free node hw mappings */
> -	otx2_txschq_free_one(pfvf, node->level, node->schq);
> +	otx2_qos_free_hw_schq(pfvf, node->level, node->schq);
>  
>  	mutex_unlock(&pfvf->qos.qos_lock);
>  }

[ ... ]
