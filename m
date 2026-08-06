Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387013B5E19;
	Thu,  6 Aug 2026 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030032; cv=none; b=b6ev8/+km9npLQ2w8TPG61J502n6BXfDbXtnKwcp2RpGUXVNSyhjJ7X0gcTsiYOrYPxTOUveo0myqaXPQjhoP5QudDMkWwPRh+tixqHSZSS3rh0NNNULD9g8XDG4/fdLeLqyY8cnh2agGC+5lnV8JAwyKcBLlVHRkZ3H5q/xDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030032; c=relaxed/simple;
	bh=FdQauWWNSOG+WY1LrDPSbyl4wHVGHqZxjzNBTA8mqH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuAlEjKF/xTEB2qNkL8kUHLcrKTq+wZ+IoO9eRDOA9sSgtZGCkIyZkSzWUkOn/EcRRzPG44NlYxBrQHBvmRpunZWKdTq4UzNymbuEIJJMzh0ztSsBEzmY81nvOug4HaoSsHKcWMtambaC020hlvYQsPi0x6/d7LK+N6aYOKIj3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iydbNOwx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iydbNOwx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA561F000E9;
	Thu,  6 Aug 2026 15:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786030030;
	bh=qUsjF+YeeaxTVrvwtBqJiN5qQErPfQsUPkmhgat2qaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iydbNOwxBVuuoq9As/rkpNCPM5fKR5Grdp4PLgxBPOoHAAga9palcMQ5GyF0eNkry
	 flmvqn1ARmB7Y1UTik6ofr62X3hT8z7mu8GmLj8yDMZY9IDB3m4SUwxSFgkKS/hkHa
	 /LuGrNIpfp4psEvQg3pADJ7nwJSRBYKt+vq9uyYrC18eIpWtE3Eego0eu4K1DPNgf7
	 /OfDCge3gt9GyiFNIrApUeAsI4lfjN+TR6x7VQkWru1jWn08HA6zOSJfQxk382BDdz
	 e9lImNrKX4MpqkdYQr/vaX+njo/U5WWrGRhlDSYAJgXjV01Tb4LBCAhyaesrkc94Sy
	 mvKtLKp4YztYA==
From: Jakub Kicinski <kuba@kernel.org>
To: subratp@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	sbhatta@marvell.com,
	rkannoth@marvell.com,
	gakula@marvell.com,
	sgoutham@marvell.com
Subject: Re: [PATCH net v2 1/2] octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled
Date: Thu,  6 Aug 2026 08:26:50 -0700
Message-ID: <20260806152650.2562245-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731055310.1229213-2-subratp@marvell.com>
References: <20260731055310.1229213-2-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled

This adds a NULL check on pfvf->queue_to_pfc_map before it is dereferenced
in the aura and CQ context init paths, since SDP VFs never allocate the map.
The BPID is now set to bpid[0] first and only overridden when CONFIG_DCB is
enabled and the map exists.

No Link: tags in the commit header.

> Fixes: 184fb40f731b ("octeontx2-pf: Avoid adding dcbnl_ops for LBK and SDP vf").

[Severity: Low]
This isn't a bug, but there is a trailing period after the closing
parenthesis of the Fixes tag.  The expected form is:

Fixes: 184fb40f731b ("octeontx2-pf: Avoid adding dcbnl_ops for LBK and SDP vf")

The stray '.' can confuse the Fixes tag parsers used for stable backport
selection.  Since this is a regression fix, would a [PATCH net] annotation
on the subject also be appropriate?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> index dbf1731966082..f3903cce9bf78 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
> @@ -245,10 +245,12 @@ int cn20k_register_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs)
>  static u8 cn20k_aura_bpid_idx(struct otx2_nic *pfvf, int aura_id)
>  {
>  #ifdef CONFIG_DCB
> -	return pfvf->queue_to_pfc_map[aura_id];
> -#else
> -	return 0;
> +	if (pfvf->queue_to_pfc_map)
> +		return pfvf->queue_to_pfc_map[aura_id];
> +	else
> +		return 0;
>  #endif
> +	return 0;
>  }

[Severity: Low]
Is the else branch here needed?  With CONFIG_DCB=y both branches return, so
the trailing return 0 after #endif is unreachable, and cn20k_aura_bpid_idx()
does not follow the "default first, then conditionally override" shape the
commit message describes for the other two hunks.  Would this be equivalent
and match the rest of the patch?

	static u8 cn20k_aura_bpid_idx(struct otx2_nic *pfvf, int aura_id)
	{
	#ifdef CONFIG_DCB
		if (pfvf->queue_to_pfc_map)
			return pfvf->queue_to_pfc_map[aura_id];
	#endif
		return 0;
	}

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 3d253132a17f0..b4691472d2a3e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -1132,10 +1132,10 @@ int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
>  		if (!is_otx2_lbkvf(pfvf->pdev)) {
>  			/* Enable receive CQ backpressure */
>  			aq->cq.bp_ena = 1;
> -#ifdef CONFIG_DCB
> -			aq->cq.bpid = pfvf->bpid[pfvf->queue_to_pfc_map[qidx]];
> -#else
>  			aq->cq.bpid = pfvf->bpid[0];
> +#ifdef CONFIG_DCB
> +			if (pfvf->queue_to_pfc_map)
> +				aq->cq.bpid = pfvf->bpid[pfvf->queue_to_pfc_map[qidx]];
>  #endif

[Severity: Low]
This isn't a bug, but the same #ifdef CONFIG_DCB plus NULL test idiom now
appears in three places: cn20k_aura_bpid_idx(), otx2_cq_init() and
otx2_aura_aq_init().  cn20k_aura_bpid_idx() already encapsulates exactly this
logic.  Would it be cleaner to generalize it into a single accessor, say
otx2_get_bpid_idx(pfvf, qidx), and use it from all three sites?

Alternatively, could queue_to_pfc_map simply be allocated unconditionally
(it is only pfvf->hw.rx_queues bytes) instead of being tied to dcbnl_ops
registration in otx2_dcbnl_set_ops()?  That coupling is what broke in
184fb40f731b.

Note that otx2_update_bpid_in_rqctx() in otx2_dcbnl.c still dereferences the
map with no NULL check:

	if (pfvf->queue_to_pfc_map[qidx] && pfc_enable) {
	...
	pfvf->queue_to_pfc_map[qidx] = vlan_prio;

That stays safe only because SDP/LBK VFs never register dcbnl_ops, so
pfvf->pfc_en remains 0 and the PFC ntuple path is never taken for them.  Is
that invariant worth documenting, or would the shared accessor make it moot?

> @@ -1433,10 +1433,11 @@ int otx2_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
>  		 */
>  		if (pfvf->nix_blkaddr == BLKADDR_NIX1)
>  			aq->aura.bp_ena = 1;
> -#ifdef CONFIG_DCB
> -		aq->aura.nix0_bpid = pfvf->bpid[pfvf->queue_to_pfc_map[aura_id]];
> -#else
> +
>  		aq->aura.nix0_bpid = pfvf->bpid[0];
> +#ifdef CONFIG_DCB
> +		if (pfvf->queue_to_pfc_map)
> +			aq->aura.nix0_bpid = pfvf->bpid[pfvf->queue_to_pfc_map[aura_id]];
>  #endif

[Severity: High]
This isn't a bug introduced by this patch, but since the patch is hardening
accesses to queue_to_pfc_map, is it worth fixing the bounds problem on the
same array at the same time?

The map is allocated with only pfvf->hw.rx_queues bytes in
otx2_dcbnl_set_ops():

	pfvf->queue_to_pfc_map = devm_kzalloc(pfvf->dev, pfvf->hw.rx_queues,
					      GFP_KERNEL);

and otx2_update_bpid_in_rqctx() in otx2_dcbnl.c indexes it with a queue
index that comes from the ethtool ntuple ring_cookie:

	if (pfvf->queue_to_pfc_map[qidx] && pfc_enable) {
	...
	pfvf->queue_to_pfc_map[qidx] = vlan_prio;

Can qidx exceed hw.rx_queues here?  The range check in otx2_add_flow() is
gated on the interface not being a VF:

	if (!is_otx2_vf(pfvf->pcifunc) && !vf_num &&
	    ring >= pfvf->hw.rx_queues && fsp->ring_cookie != RX_CLS_FLOW_DISC)
		return -EINVAL;

so for a VF netdev the ring index is not validated, and otx2_add_flow_msg()
propagates it:

	req->index = ethtool_get_flow_spec_ring(ring_cookie);
	...
			if (pfvf->pfc_en & BIT(vlan_prio)) {
				pfc_rule = true;
				qidx = req->index;
			}
	...
	if (!err && pfc_rule)
		otx2_update_bpid_in_rqctx(pfvf, vlan_prio, qidx, true);

The AF handler in rvu_npc_fs.c assigns action.index = req->index without an
RQ count check, so the mbox call succeeds and the helper runs.  That looks
like an out-of-bounds read at a caller-chosen offset plus a one byte
out-of-bounds write of the VLAN priority.  The delete path in
otx2_remove_flow() passes the raw 64-bit ring_cookie into the same int qidx:

	otx2_update_bpid_in_rqctx(pfvf, 0,
				  flow->flow_spec.ring_cookie,
				  false);

Would adding the ring >= pfvf->hw.rx_queues check for VF netdevs, or bounds
checking qidx inside otx2_update_bpid_in_rqctx(), be the right fix?  This
requires CAP_NET_ADMIN on the VF netdev, which matters when the VF is handed
to a container or guest owner.
-- 
pw-bot: cr
