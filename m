Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145D37E5D4;
	Thu, 17 Sep 2026 02:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610623; cv=none; b=iJTBHle8BFnK5F7GzRRONYZLUvVHcy/DpY8b7v+vN3s/Oiq24F7ZLWrua2py43mn+g+myf92G16HF3ys7lgg0KkAYzN7KuwPri4k6RTYINkyrmUsmSZjdNWSsz2yIFtDgQgVDiV07C+p1UP3UyUQisWUX4lT0uRKqYA/xmUdcaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610623; c=relaxed/simple;
	bh=Oo0eucG9brvB6l4HggCL7KhF82e/7QUIP4t8AqsBMV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRsAHw3L+UlET4lg0YDgaq2bkT1UJdvWesHmSsMlrDTjuGQZKMqUVVPpgWAtL3VYEw3UvpxZ6XV+MEMD6AXiwYMuCQubSRcXyYMwkGcZvio1kjmX0ZwQRXfAXp6jQMTvlTambiyeas7s1qDyoC9k19IfmdYmicJR7Oo+0iwY0Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4HT8gXz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4HT8gXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5671F000FF;
	Thu, 17 Sep 2026 02:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789610622;
	bh=duNLCu0t1RikXS4ic+PsmwPopHLDDP0sqc23AUxRyKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y4HT8gXzxhcSUNKmjREJvOAMXZ5kTN9M82t5Bq/9ILRFGt5b6kN7jMYXxxBU1l0NQ
	 RzEFia3cejsbOLO0JpBSzSghF3W3e7ff9JQytacfnBZHE712E11lm6pl3XWJ6f8Gvf
	 c4ITsLt6CkrB5hUhLHQwohioRtlERoraRXr5cOfUX8FlKhEnTDU3zc7u6jVSTt5wjI
	 J5wpvOzxI7cWa+wkB0KQCINh/owW0pTv2pEoxyJaJ6lEcjq/xPFNiKybDsAR+ip88u
	 IhBu9XovMWy/53HCD2c2xKaTkgeGi5anZuypklNsbX7aeOKb8YkRSVzmZUsz7UnMO4
	 4Hl1J/WHfVBfg==
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
Subject: Re: [PATCH net v6 1/2] octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled
Date: Wed, 16 Sep 2026 19:03:40 -0700
Message-ID: <20260917020340.2544315-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910062657.3712256-2-subratp@marvell.com>
References: <20260910062657.3712256-2-subratp@marvell.com>
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

This consolidates the per-file CONFIG_DCB ifdef blocks that pick the BPID
index for CQ and aura contexts into a new otx2_get_bpid_idx() helper in
otx2_common.h, and drops the equivalent cn20k_aura_bpid_idx().

>     Previously, BPID assignment under CONFIG_DCB assumed
>     `queue_to_pfc_map` was always initialized. For SDP VFs this leads to
>     invalid memory access as it was not initialized.
>
>     This patch adds a NULL check for `queue_to_pfc_map` before
>     dereferencing it. Also, simplifies the logic by always assigning a
>     default BPID first, then conditionally overriding it if CONFIG_DCB is
>     enabled and the map exists.

[Severity: High]
Does the patch match this description?  I do not see a NULL check for
queue_to_pfc_map anywhere in the diff, and no place where a default BPID is
assigned first and then conditionally overridden.  The new helper appears to
dereference the map unconditionally when CONFIG_DCB=y, which looks
byte-for-byte equivalent to the ifdef blocks it replaces.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index eecee612b7b2c..2a63d22cbd8d0 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -1029,6 +1029,14 @@ static inline int otx2_tc_flower_rule_cnt(struct otx2_nic *pfvf)
>  	return pfvf->flow_cfg->nr_flows;
>  }
>  
> +static inline u8 otx2_get_bpid_idx(struct otx2_nic *pfvf, int qidx)
> +{
> +#ifdef CONFIG_DCB
> +	return pfvf->queue_to_pfc_map[qidx];
> +#endif
> +	return 0;
> +}
> +

[Severity: High]
With CONFIG_DCB=y, isn't the trailing return 0 dead code here, leaving
pfvf->queue_to_pfc_map[qidx] as an unguarded dereference?

queue_to_pfc_map is allocated only in otx2_dcbnl_set_ops():

drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c:otx2_dcbnl_set_ops() {
	pfvf->queue_to_pfc_map = devm_kzalloc(pfvf->dev, pfvf->hw.rx_queues,
					      GFP_KERNEL);
}

and since the Fixes: commit, otx2vf_probe() skips that call for SDP and LBK
VFs:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c:otx2vf_probe() {
#ifdef CONFIG_DCB
	/* Priority flow control is not supported for LBK and SDP vf(s) */
	if (!(is_otx2_lbkvf(vf->pdev) || is_otx2_sdp_rep(vf->pdev))) {
		err = otx2_dcbnl_set_ops(netdev);
#endif
}

so for an SDP VF the pointer stays NULL for the lifetime of the device.

Would something like this be what was intended?

	static inline u8 otx2_get_bpid_idx(struct otx2_nic *pfvf, int qidx)
	{
	#ifdef CONFIG_DCB
		if (pfvf->queue_to_pfc_map)
			return pfvf->queue_to_pfc_map[qidx];
	#endif
		return 0;
	}

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 175992188c18a..0f3f405d9f1b7 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c

[ ... ]

> @@ -1132,11 +1133,8 @@ int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
>  		if (!is_otx2_lbkvf(pfvf->pdev)) {
>  			/* Enable receive CQ backpressure */
>  			aq->cq.bp_ena = 1;
> -#ifdef CONFIG_DCB
> -			aq->cq.bpid = pfvf->bpid[pfvf->queue_to_pfc_map[qidx]];
> -#else
> -			aq->cq.bpid = pfvf->bpid[0];
> -#endif
> +			bpid_idx = otx2_get_bpid_idx(pfvf, qidx);
> +			aq->cq.bpid = pfvf->bpid[bpid_idx];

[Severity: High]
Does this call site still oops on an SDP VF with CONFIG_DCB=y?  The only
guard here is !is_otx2_lbkvf(), which matches PCI_DEVID_OCTEONTX2_RVU_AFVF
and PCI_DEVID_RVU_REP but not PCI_DEVID_OCTEONTX2_SDP_REP:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h {
	static inline bool is_otx2_lbkvf(struct pci_dev *pdev)
	{
		return (pdev->device == PCI_DEVID_OCTEONTX2_RVU_AFVF) ||
			(pdev->device == PCI_DEVID_RVU_REP);
	}
}

so interface bring up on an SDP VF reaches otx2_get_bpid_idx() with a NULL
map:

ndo_open -> otx2_init_hw_resources() -> otx2_cq_init() ->
otx2_get_bpid_idx()

The same holds for the other two converted sites, which carry identical
guards:

otx2_init_hw_resources() -> otx2_rq_aura_pool_init() ->
otx2_aura_aq_init() -> otx2_get_bpid_idx()

and cn20k_aura_aq_init() -> otx2_get_bpid_idx(), where the removed
cn20k_aura_bpid_idx() had the same shape.

Given the Fixes: tag will pull this into stable, could the helper be
respun with the guard the changelog describes, so that SDP VFs fall back to
pfvf->bpid[0]?

[ ... ]
-- 
pw-bot: cr
