Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C5846A;
	Wed,  9 Sep 2026 03:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788923852; cv=none; b=kHfZORI4ynuv95474wQv+NUzrPF2Va+plqyqEYspeiIua52foHL4JtP+eL7BnpJ6Cu4XIp9lQIg3HXKn4mzjUMQSqb4t8gMAPmo2Qru/WQfjBL3Jz1p1I4ryvW2HDeaRCG8859FGPx1E2DghzNCBvbWTMOet/RFiKFUyiaFzR3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788923852; c=relaxed/simple;
	bh=gO8/wzbula69UjPLsaAFAfb4VYs9owik9alWAHWgknM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avAn0T7pOOXCxuYUZLtjw1G2EKHW8+e9L/2hJ/nFHF7p8og6fOf03hUR3zaU9tLTlcOZyeT9KJHNbrBTbNOSfKqnE1rKczEdymHH1siEZAQwR3aLZxzUwsdK3tvWz1vpnIord739QCOkqvE1qi6RWKqaPT266ub+DtzdsHnvK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LZQXTILM; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LZQXTILM"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6891UnOH1568962;
	Tue, 8 Sep 2026 20:17:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
	comrW9jVXFX62Upjo1YTfLTecKCj6r82E5QbVSQuk8=; b=LZQXTILMjQMuAxdcr
	YwO6wsxgbHpLrnNd/Oj8ro7D7C9ZNgxTqFocjWPzsg0lp5yrye6M1c3SQOLjaz1b
	5IY6sG3H6euYGf1UzWQjS4QxkoqJlrwLAH9R3JZNo04E+U73ZfINqucOHm91n7Xr
	xJuEwoxRtK0oD1gQkBvdH2r4eFlv6/ocGY0ejj/FTphYUC8bjdao9ZjD+0yvhqFG
	b75UgiiSa6EMpev4Bo1qi589JB3aoIBc8waBuMBPS21U8Dd0EElUqaYCpQjlDsX2
	Gy8FSSepwGPBxvHDRDbh8BdzI6bWlSSwHcgPeAeSnFqAP80xRHuO9qalxULTCwzY
	ev0pA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gjwuu06ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 20:17:21 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Sep 2026 20:17:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 8 Sep 2026 20:17:20 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id EB8813F7071;
	Tue,  8 Sep 2026 20:17:16 -0700 (PDT)
Date: Wed, 9 Sep 2026 08:47:10 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <davem@davemloft.net>, <hkelam@marvell.com>,
        <linux-kernel@vger.kernel.org>, <naveenm@marvell.com>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>,
        <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
Subject: Re: [PATCH v4 net] octeontx2-pf: reset HTB scheduler topology before
 freeing queues
Message-ID: <aqDPtg2y3Pl5_r-j@rkannoth-OptiPlex-7090>
References: <20260903020533.3068041-1-rkannoth@marvell.com>
 <178888726063.219967.8664029829834628993@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178888726063.219967.8664029829834628993@kernel.org>
X-Proofpoint-ORIG-GUID: FrHDYgM9XZgUsfzd4gOwOHJtLt6LE7Af
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDAzMyBTYWx0ZWRfX0vwpK0n+qW8y
 P0MUzYWm4Mk81Ew0HUDYz1yiIBUBVXusF3UVHNftHFTZQtFFPUdebb3hho6F1qTn8yyDhhaEU/p
 L+FGspatLKDFYc4gKtKJSHFKK8Opwtw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDAzMyBTYWx0ZWRfX+lvYU+Dm/3WT
 SouS6BGe1TsVuQn2IHH9GRKa49iLpB4ojk/L0M0rmq6dCUKnW8B+u72BqxvrZtg7kA33xyv60RX
 ZwI3AlkXQDATkTHeIwSRhLEwiSCA4XHRBkzahbAMAd5knd5w+HI1YQBak4b8qvQR11Sw4adzSUb
 1DDLYndy6rP2wlAX1ZmjkGnOh8onCz86miss1BD0c/olqOjR8bgZOutuWvCgGSQNFT7pmWpQ/fI
 vcWdQdBukCt2U4pGp0L0DEn03rWtp1oWMMf58eTkJwT2lSXpu1ZU6tZORQxoRuxVm8vEurYTwU3
 gQ1yjiaa9YY4Hrf1AkcmDa9T6cW4Fb7ZJbcWupkJykT5w7o9Qw1idnSIpoLHUThtatx9YlLSCLp
 1LcECrS1PNsm8tHE4JFr4V5USYiZC1RIHO90IrsWNITfioFPqJf57gzplUJQRtioT4PvR/VARB2
 p5wj98/Ml5Txi0I6MUw==
X-Authority-Analysis: v=2.4 cv=SfzHsPRu c=1 sm=1 tr=0 ts=6aa0cfc1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=s4vksbRjvoXbhyHLyvkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: FrHDYgM9XZgUsfzd4gOwOHJtLt6LE7Af
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01

On 2026-09-08 at 22:37:40, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>
> Critical: 0 · High: 1 · Medium: 1 · Low: 0
>
> - [High] Incomplete fix: the stale-TOPOLOGY bug class the commit claims
>   to close stays reachable through the AF's bulk release path.
AF's built release path is FLR/PCI reset path. We will fix it as seperate fix.

> - [Medium] Set/reset asymmetry at the aggregation level: HTB offload
>   programs NIX_AF_TL1X_TOPOLOGY (PRIO_ANCHOR/RR_PRIO) on the shared per-…
We can't clear TL1 blindly as it is a shared resource between PF and VF.

>
> --
>
> octeontx2-pf: reset HTB scheduler topology before freeing queues
>
> This adds otx2_qos_reset_schq_topology() and otx2_qos_free_hw_schq() so
> that NIX_AF_TL{4,3,2}X_TOPOLOGY is zeroed before each QoS scheduler queue
> is handed back to the AF during HTB hierarchy teardown and cfg rollback.
> The aggregation level (TL1) is intentionally skipped.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> > index 69c0911e28e9..f160b1618efa 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> > @@ -235,13 +235,63 @@ static int otx2_qos_txschq_set_parent_topology(struct otx2_nic *pfvf,
> >  	return rc;
> >  }
> >
> > +static int otx2_qos_reset_schq_topology(struct otx2_nic *pfvf, u16 lvl,
> > +					u16 schq)
> > +{
> > +	struct mbox *mbox = &pfvf->mbox;
> > +	struct nix_txschq_config *cfg;
> > +	int rc;
> > +
> > +	if (lvl < NIX_TXSCH_LVL_TL4 || lvl >= NIX_TXSCH_LVL_TL1)
> > +		return 0;
>
> [Severity: Medium]
> Should the TL1 case be handled here too, or at least commented in the
> code?  otx2_qos_txschq_set_parent_topology() does program TL1:
>
> 	else if (parent->level == NIX_TXSCH_LVL_TL1)
> 		cfg->reg[0] = NIX_AF_TL1X_TOPOLOGY(parent->schq);
>
> 	cfg->regval[0] = (u64)parent->prio_anchor << 32;
> 	cfg->regval[0] |= ((parent->child_dwrr_prio != OTX2_QOS_DEFAULT_PRIO) ?
> 			    parent->child_dwrr_prio : 0)  << 1;
>
> and for a PF the HTB root sits at that level, in otx2_qos_alloc_root():
>
> 	if (!is_otx2_vf(pfvf->pcifunc)) {
> 		node->level = NIX_TXSCH_LVL_TL1;
>
> so otx2_qos_txschq_push_cfg_tl() -> otx2_qos_txschq_set_parent_topology()
> writes NIX_AF_TL1X_TOPOLOGY with the HTB prio_anchor, which is the base
> index of the contiguous TL2 child block.
>
> On tc qdisc del, otx2_qos_root_destroy() -> otx2_qos_destroy_node() ->
> otx2_qos_free_hw_cfg() calls otx2_qos_free_hw_schq(pfvf, node->level,
> node->schq) with node->level == NIX_TXSCH_LVL_TL1, which takes the early
> return above.
>
> Does anything else restore the default TL1 topology while the interface
> stays up?  nix_txschq_free_one() early-returns for lvl >=
> hw->cap.nix_tx_aggr_lvl, nix_reset_tx_schedule() has no TL1 case, and
> nix_tl1_default_cfg() declines to reprogram once the PF has configured
> TL1:
>
> 	/* Skip if PF has already done the config */
> 	if (TXSCH_MAP_FLAGS(pfvf_map[schq]) & NIX_TXSCHQ_CFG_DONE)
> 		return;
> 	rvu_write64(rvu, blkaddr, NIX_AF_TL1X_TOPOLOGY(schq),
> 		    (TXSCH_TL1_DFLT_RR_PRIO << 1));
>
> The only writer of the default TL1 value appears to be
> otx2_txschq_config():
>
> 	req->reg[1] = NIX_AF_TL1X_TOPOLOGY(schq);
> 	req->regval[1] = hw->txschq_aggr_lvl_rr_prio << 1;
>
> which runs at interface open rather than on TC_HTB_DESTROY.  So after HTB
> teardown with the link up, the shared TL1 keeps a PRIO_ANCHOR pointing at
> TL2 indices that were just returned to the AF's block-wide TL2 pool and
> may be re-allocated to another function.
>
> The commit message says TL1 "is not freed back to the AF by
> nix_txschq_free_one()", which rules out re-allocating TL1 itself, but does
> it cover the residual anchor pointing into recycled TL2 indices?  Whether
> the TL1 arbiter can act on such a stale anchor depends on hardware
> semantics that are not visible from the tree, so this may be harmless in
> practice, but the set/reset asymmetry looks worth spelling out in the code
> rather than only in the changelog.
>
> > +
> > +	mutex_lock(&mbox->lock);
> > +
> > +	cfg = otx2_mbox_alloc_msg_nix_txschq_cfg(mbox);
> > +	if (!cfg) {
> > +		mutex_unlock(&mbox->lock);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	cfg->lvl = lvl;
> > +	cfg->num_regs = 1;
> > +
> > +	if (lvl == NIX_TXSCH_LVL_TL4)
> > +		cfg->reg[0] = NIX_AF_TL4X_TOPOLOGY(schq);
> > +	else if (lvl == NIX_TXSCH_LVL_TL3)
> > +		cfg->reg[0] = NIX_AF_TL3X_TOPOLOGY(schq);
> > +	else if (lvl == NIX_TXSCH_LVL_TL2)
> > +		cfg->reg[0] = NIX_AF_TL2X_TOPOLOGY(schq);
> > +
> > +	cfg->regval[0] = 0;
> > +
> > +	rc = otx2_sync_mbox_msg(mbox);
> > +
> > +	mutex_unlock(&mbox->lock);
> > +
> > +	return rc;
> > +}
> > +
> > +static void otx2_qos_free_hw_schq(struct otx2_nic *pfvf, u16 lvl, u16 schq)
> > +{
> > +	int err;
> > +
> > +	err = otx2_qos_reset_schq_topology(pfvf, lvl, schq);
>
> [Severity: High]
> Does this cover the case where the AF, not the driver, releases the QoS
> queues?  The reset only runs on the driver's explicit per-schq frees, but
> nix_txschq_free() in af/rvu_nix.c returns the same TL4/TL3/TL2 indices to
> the shared pool with only PARENT and SCHEDULE cleared:
>
> 	nix_reset_tx_schedule(rvu, blkaddr, lvl, schq);
> 	rvu_free_rsrc(&txsch->schq, schq);
> 	txsch->pfvf_map[schq] = TXSCH_MAP(0, NIX_TXSCHQ_FREE);
>
> and nix_reset_tx_schedule() writes TLxX_PARENT and TLxX_SCHEDULE only, so
> TOPOLOGY (PRIO_ANCHOR/RR_PRIO) stays programmed.
>
> That path is reachable while an HTB qdisc is still offloaded, for example
> on a function reset (echo 1 > /sys/bus/pci/devices/<bdf>/reset) or a VF
> FLR from a passthrough guest:
>
> rvu_flr_handler() -> rvu_blklf_teardown() -> rvu_nix_lf_teardown() ->
> nix_txschq_free()
>
> In that case otx2_qos_free_hw_schq() never runs, so the state the commit
> message describes ("PRIO_ANCHOR/RR_PRIO settings can survive in the
> shared scheduler pool and affect later allocations") is unchanged.
>
> The allocation side also looks unsanitized.  nix_txschq_alloc() resets
> linkcfg, shaping and schedule for every newly allocated schq:
>
> 	nix_reset_tx_linkcfg(rvu, blkaddr, lvl, schq);
> 	nix_reset_tx_shaping(rvu, blkaddr, nixlf, lvl, schq);
> 	nix_reset_tx_schedule(rvu, blkaddr, lvl, schq);
>
> but not TOPOLOGY, and otx2_txschq_config() never writes TOPOLOGY for
> TL2/TL3/TL4, so a new owner inherits whatever anchor was left behind.
>
> Would adding the TLxX_TOPOLOGY register to nix_reset_tx_schedule() be a
> better place for this?  That would cover free_one, TXSCHQ_FREE_ALL, FLR
> and allocation-time inheritance for all AF clients under rvu->rsrc_lock,
> and the driver-side helper added here would not be needed.
>
> > +	if (err)
> > +		netdev_warn(pfvf->netdev,
> > +			    "QoS: failed to reset topology for schq %u at level %u: %d\n",
> > +			    schq, lvl, err);
> > +
> > +	otx2_txschq_free_one(pfvf, lvl, schq);
> > +}
> > +
> >  static void otx2_qos_free_hw_node_schq(struct otx2_nic *pfvf,
> >  				       struct otx2_qos_node *parent)
> >  {
> >  	struct otx2_qos_node *node;
> >
> >  	list_for_each_entry_reverse(node, &parent->child_schq_list, list)
> > -		otx2_txschq_free_one(pfvf, node->level, node->schq);
> > +		otx2_qos_free_hw_schq(pfvf, node->level, node->schq);
> >  }
>
> [ ... ]
>
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903020533.3068041-1-rkannoth%40marvell.com
