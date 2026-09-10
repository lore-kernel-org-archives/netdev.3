Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B18472F67;
	Thu, 10 Sep 2026 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039264; cv=none; b=I1NFjQZFhH6l8Euq67jyYbhrX4sdS0CS9xsyJdH7XhTt8EVStZFmEtsRw18qrs3NIrJyL1xD8Mo8M0ZXttSuFgPb1EJjCs9Y5kv8WAPgsEnVoSxM41gKjU3Z/Dt9wF/Hl/wZgYBT9UPtRs4hFQDmE9pVIdhYLfonICXAT54lc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039264; c=relaxed/simple;
	bh=bd3sF6/CWearNn/69D5jN723YPDHKWriUGCgLzvKArg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jks18vRfWv8Emr2e3A0AiFYcFzWUPpLrS8HjjVqwWG1poHNx9CRdjENAgj/sqTD26sq+dXDr9lBb5gb9WZUiAp6LF8xsOoCqVAbmfgvK8UtZA/RUsyy02vN8Kchmq8LJtTawiQrHwnVDRY7Y5YrwcvWeRFbvHBvFRLQoqYXbEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEsA+GR1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEsA+GR1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6F21F00893;
	Thu, 10 Sep 2026 11:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039263;
	bh=O7e3qWzO2Vn98CTd0qWVMgZzcrHefsRMWkLLlqt65yA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GEsA+GR1gE7lwrx1p+l5r5RKliDTDDrs2fKC/F106NPKzpEt0T/J1eawVYM+Q8Jj0
	 4nEdXJcd9S31ZMhox5aUPyp8eEMHZv0IEFED4dwZnoDbk/RglQdG+UFRVNvM6wmDIn
	 djbeM0j13yrxs4/u2eqDl5Pb+/Yz3kVTBFiNT+zIwkL1sYaev/2QlVFdhSNBXe1Zt/
	 MUYdymiozWPKkzH5vDH0mfIkuEo8idNtw80UwIpO0/KB5vmgHo2lhdpzMoZSJR0t6l
	 KEMhHNToDq//Btmc+40gZv8bMqsJmo4dc4EpNQBjt33yJKCnzzTwvY8idSIpjCoWYe
	 wjl7Z6UmVymxA==
Subject: Re: [PATCH v4 net-next 11/15] net: enetc: restore VF MAC promiscuous
 mode after FLR for ENETC v4
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew@lunn.ch, olteanv@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 11:21:01 +0000
Message-ID: <178903926180.219967.4329633531157866810@kernel.org>
In-Reply-To: <20260909100733.1139689-12-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-12-wei.fang@oss.nxp.com>
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

- [Medium] The promiscuous-mode restoration is deferred to a workqueue:
  enetc_msg_psi_msix() only calls enetc_disable_psiier_interrupts() +…

--

net: enetc: restore VF MAC promiscuous mode after FLR for ENETC v4

A VF FLR on ENETC v4 resets PSIPMMR[SIn_MAC_UP] and PSIPMMR[SIn_MAC_MP]
to their promiscuous default, so the patch tracks the PF-managed UC/MC
promiscuous state per VF and re-applies it from a new vf_flr_handler
callback dispatched out of enetc_msg_task().

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index abe1e8dafe24..6a9b1e079ae2 100644
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
> +	spin_lock(&pf->si->gen_lock);
> +	enetc_set_si_uc_promisc(pf->si, vf_id + 1, uc_promisc);
> +	enetc_set_si_mc_promisc(pf->si, vf_id + 1, mc_promisc);
> +	spin_unlock(&pf->si->gen_lock);
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
> index aa37a0123274..ff99937815c0 100644
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

> @@ -542,6 +559,29 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
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
> @@ -550,6 +590,8 @@ static void enetc_msg_task(struct work_struct *work)
>  	u32 mr_status, mr_mask;
>  	int i;
>  
> +	enetc_vf_flr_handler(pf);
> +

[Severity: Medium]
How long can the SI stay in the hardware promiscuous default before this
restore runs?

The interrupt handler only masks PSIIER and queues the work:

drivers/net/ethernet/freescale/enetc/enetc_msg.c:enetc_msg_psi_msix() {
	enetc_disable_psiier_interrupts(pf);
	schedule_work(&si->msg_task);
}

so between the FLR taking effect (PSIPMMR[SIn_MAC_UP]/[SIn_MAC_MP] back at
their promiscuous reset values) and enetc_msg_task() ->
enetc_vf_flr_handler() -> enetc4_pf_vf_flr_handler() running, the SI keeps
receiving all port unicast and multicast traffic. Since the hardware default
ignores trust state, does this window also apply to an untrusted VF that has
never been granted promiscuous mode?

Is the window bounded here? PSIIER is only re-armed at the very end of
enetc_msg_task():

	for (i = 0; i < pf->num_vfs; i++) {
		...
		enetc_msg_handle_rxmsg(pf, i, &msg_code);
		...
	}

out:
	enetc_enable_psiier_interrupts(pf);

so an FLR latched while the message loop is in progress is not serviced until
that loop finishes. For a trusted VF the loop can reach
enetc_msg_get_link_speed(), which blocks on the global lock:

	rtnl_lock();
	phylink_ethtool_ksettings_get(priv->phylink, &link_info);
	rtnl_unlock();

Can a guest keep msg_task busy this way while another VF (or the same one)
sits in the FLR-induced promiscuous state?

Would it make sense to force UC/MC promiscuous off for the affected SI as
soon as the FLR event is observed, before the tracked policy is re-applied,
and to note the residual window in the commit message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909100733.1139689-1-wei.fang%40oss.nxp.com
