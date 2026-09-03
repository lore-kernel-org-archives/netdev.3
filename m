Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B673A6412;
	Thu,  3 Sep 2026 23:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479070; cv=none; b=H9mjbVec7GVuVBc23E+/D9S7bJc2JO4Dl67R6lZkLegtziZXuBnacgXemZer/HexduVe45GjO2CEeoecRowy8DegaVwn6sGQ1DZkNHOeEBwFNlzkV38XZkv1j6DbO7lO7vG+ndbrRlKDhPyLuO7CMjX3jZCryBA6MqsIVUdQHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479070; c=relaxed/simple;
	bh=7CdGKf66S+9POaLGQ2FG7vdBj6HCbm8OuU3AJyb3Mhs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LbDe2dReGYjxQucclaHpe15SSxtNKY/hY/SPsmD0LrJY+zExmbwXLr0IJ/TQSQuPLswES1EkIVUDqyMZ3vkd1Avz2/s09nNByRrCDum5jUOBSNjXeH566e/uTNKJnQldKsu0uswWnvYpEegbJ9llKaTt3IIYeWHgw2SfvPBV70w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8n7Fvtg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8n7Fvtg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126261F00A3E;
	Thu,  3 Sep 2026 23:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788479068;
	bh=vvIkYBXZMmxBT+6D10uOx8Ye7aPkSdClNRitjOi6G18=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m8n7FvtgkUH3W7b6bcxwSnc/5RrwF9DOLwDm1pYfytbqWNuUj6CwIlYHaH6VJBja7
	 vlQjBhVec1DC/Fx7cJMM9KLh7hyignqklSjLkzzDLshgKJ8Tq0yZa4F8JYOtyR8RGI
	 Z4LjyOaKVt3jr6ecav6vDLtBe2M/QBc7F2ph7hnHZ7WomQgGnBs1uix4MmtFN3PD/v
	 87U5iJA0RM/QhiiWvCugdLcsKLwKq0tWG9CkuvFY5MpQtxZ5rvYjR+6Ilns8YEv+x0
	 epa1lBzGgfjy5KCEVfP3keWmc+MH0dbtk8T0ZC4CFeGtRSja70raTdFzaoASi4td2G
	 /YK09/dUo3r9w==
Subject: Re: [PATCH v3 net-next 11/15] net: enetc: restore VF MAC promiscuous
 mode after FLR for ENETC v4
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew@lunn.ch, olteanv@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 23:44:27 +0000
Message-ID: <178847906763.4131868.15039580023572972267@kernel.org>
In-Reply-To: <20260831025441.635045-12-wei.fang@oss.nxp.com>
References: <20260831025441.635045-12-wei.fang@oss.nxp.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The promiscuous-mode revocation after a VF FLR is fully
  asynchronous: enetc_msg_psi_msix() (enetc_msg.c:36-45) masks PSIIER…

--

net: enetc: restore VF MAC promiscuous mode after FLR for ENETC v4

On ENETC v4 a VF FLR resets PSIPMMR[SIn_MAC_UP] and PSIPMMR[SIn_MAC_MP]
to their default, which enables unicast and multicast promiscuous mode
for that SI.  The patch tracks the PF-managed promiscuous state in
enetc_vf_flags and adds a vf_flr_handler callback that re-applies it from
enetc_msg_task() after each FLR.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index a4ffe1100bd7..c421c0e7355b 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -212,9 +212,29 @@ static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type,
>  		enetc4_pf_set_mc_hash_filter(pf, mc);
>  }
>  
> +static void enetc4_pf_vf_flr_handler(struct enetc_pf *pf, int vf_id)
> +{
> +	struct enetc_vf_state *vf_state;
> +	bool uc_promisc, mc_promisc;
> +
> +	vf_state = &pf->vf_state[vf_id];
> +	mutex_lock(&vf_state->lock);
> +
> +	uc_promisc = !!(vf_state->flags & ENETC_VF_FLAG_UC_PROMISC);
> +	mc_promisc = !!(vf_state->flags & ENETC_VF_FLAG_MC_PROMISC);
> +
> +	mutex_lock(&pf->msg_lock);
> +	enetc_set_si_uc_promisc(pf->si, vf_id + 1, uc_promisc);
> +	enetc_set_si_mc_promisc(pf->si, vf_id + 1, mc_promisc);
> +	mutex_unlock(&pf->msg_lock);
> +
> +	mutex_unlock(&vf_state->lock);
> +}
> +
>  static const struct enetc_pf_ops enetc4_pf_ops = {
>  	.set_si_primary_mac = enetc4_pf_set_si_primary_mac,
>  	.get_si_primary_mac = enetc4_pf_get_si_primary_mac,
> +	.vf_flr_handler = enetc4_pf_vf_flr_handler,
>  };

[ ... ]

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> index 4aabeb23a386..55c23d4a73a8 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> @@ -27,6 +27,9 @@ static void enetc_enable_psiier_interrupts(struct enetc_pf *pf)
>  	u32 psiier = ENETC_PSIMR_MASK(pf->num_vfs);
>  	struct enetc_hw *hw = &pf->si->hw;
>  
> +	if (pf->ops->vf_flr_handler)
> +		psiier |= ENETC_VFFLR_MASK(pf->num_vfs);
> +
>  	enetc_wr(hw, ENETC_PSIIER, psiier);
>  }

[ ... ]

> @@ -594,6 +611,29 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
>  	kfree(msg);
>  }
>  
> +static void enetc_vf_flr_handler(struct enetc_pf *pf)
> +{
> +	u32 flr_mask = ENETC_VFFLR_MASK(pf->num_vfs);
> +	struct enetc_hw *hw = &pf->si->hw;
> +	u32 flr_status;
> +
> +	if (!pf->ops->vf_flr_handler)
> +		return;
> +
> +	flr_status = enetc_rd(hw, ENETC_PSIIDR) & flr_mask;
> +	if (!flr_status)
> +		return;
> +
> +	for (int i = 0; i < pf->num_vfs; i++) {
> +		if (!(ENETC_VFFLR_BIT(i) & flr_status))
> +			continue;
> +
> +		/* Clear FLR interrupt status, W1C */
> +		enetc_wr(hw, ENETC_PSIIDR, ENETC_VFFLR_BIT(i));
> +		pf->ops->vf_flr_handler(pf, i);
> +	}
> +}
> +
>  static void enetc_msg_task(struct work_struct *work)
>  {
>  	struct enetc_si *si = container_of(work, struct enetc_si, msg_task);
> @@ -602,6 +642,8 @@ static void enetc_msg_task(struct work_struct *work)
>  	u32 mr_status, mr_mask;
>  	int i;
>  
> +	enetc_vf_flr_handler(pf);
> +

[Severity: Medium]
How long can the SI stay in the hardware promiscuous state before this
restore runs?

The hardware puts the SI into UC/MC promiscuous mode at the instant of the
FLR, but the policy is only re-applied from the work item:

enetc_msg_psi_msix() {
	enetc_disable_psiier_interrupts(pf);
	schedule_work(&si->msg_task);

	return IRQ_HANDLED;
}

enetc_msg_task() -> enetc_vf_flr_handler() -> pf->ops->vf_flr_handler()
	-> enetc4_pf_vf_flr_handler()

Since the guest owning the VF triggers the FLR itself (vfio-pci reset, or a
driver bind path reaching pcie_flr()), it knows exactly when that window
opens and only needs to re-arm an Rx BD ring to receive frames destined for
other SIs until enetc4_pf_vf_flr_handler() clears the bits in PSIPMMR.

The scan also happens once, at the top of enetc_msg_task():

	enetc_vf_flr_handler(pf);

	mr_mask = ENETC_PSIMR_MASK(pf->num_vfs);

and enetc_vf_flr_handler() takes a single PSIIDR snapshot with an early
return:

	flr_status = enetc_rd(hw, ENETC_PSIIDR) & flr_mask;
	if (!flr_status)
		return;

If an FLR lands while msg_task is already part-way through the VF message
loop, is the restore then delayed until the whole in-flight batch finishes
and the re-queued work runs?  The FLR bits are not re-checked before
enetc_enable_psiier_interrupts(pf) at the end of the work item.

Would it be feasible to clear PSIPMMR[SIn_MAC_UP]/[SIn_MAC_MP] directly in
enetc_msg_psi_msix() for the VFs whose FLR bits are set, and leave the full
policy re-apply in the work item?  As written the handler sleeps on
vf_state->lock and pf->msg_lock, so it cannot run from the hardirq.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831025441.635045-1-wei.fang%40oss.nxp.com
