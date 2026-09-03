Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E349231E830;
	Thu,  3 Sep 2026 02:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402501; cv=none; b=ujfZOYo2zVb9RPwRWdoa3JzgU7fC3k8AEl8dVoxBtZp5Z/b6YfQdIuLOJBkaJo1moKgqbXN1EA8TDT4ST4Wgt1vkybNqEx+GnGDV+g1kUzB0O5UV9aOA+3sbNrejVx4x9vk16uXlD4HRcGFctjG+FgriwPCR5BqVDcOAEiPJ5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402501; c=relaxed/simple;
	bh=DRRLNo+ZiW0rLbuaRUyr+jl8wMCDAEozn83IccPkiE8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfLUuh5FUOrNragazN/qOntS97/ECxbMzSPZ4zpdxtTlRj9Nk81mBy+RdzVLIPXbBhNBMPKtnc7b0NLBqgkCbG/IdPXL7fCWnkqQ5GqdXqvjHP1vQ3MLjM2EWFMR/swWHpwA1riKkzFevPPre4ekdxey49w5zP06IrQG/2ZaXN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=U1NSRN5Y; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="U1NSRN5Y"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682NKiGh3671069;
	Wed, 2 Sep 2026 19:28:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=DaAFjO4WLWAvahNolIel+TJ3h
	f60XMXyJFaqoi688o4=; b=U1NSRN5YqQIFO78vTqePM1hPpPLPqfVmH1kJdE+0H
	3kxw3up97OJqKAHcjpCmuYb95BvYyZ8OTO6iq9AVF9FBGoXexHiWi0vGD5zu0Khl
	VBaa+tXaTH5i7jiuq8UIrhJLAVZ+oKvN4T3L19D3sgc7gwltyjUKsNVv61MpZ0jN
	jXM7NofIkGdHlQaAfS/V5UtDh8D+z164RewmDUc+lTb2cDLiEgRKICu7rpTapXH1
	QE3A3fF4foYLu5g5NkvGWuunXnUAkL4/qL7FJLm7fcCICbOVVPsMPVlAEjkCFkZT
	BTz8QbMAghiAm84qmgWablWQGB0KfkEbVfSMJe1M3yXZg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gew3k0gqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 19:28:11 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Sep 2026 19:28:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 2 Sep 2026 19:28:10 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 395743F7072;
	Wed,  2 Sep 2026 19:28:06 -0700 (PDT)
Date: Thu, 3 Sep 2026 07:58:01 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <davem@davemloft.net>, <hkelam@marvell.com>,
        <linux-kernel@vger.kernel.org>, <naveenm@marvell.com>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>,
        <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
Subject: Re: [PATCH v3 net] octeontx2-pf: reset HTB scheduler topology before
 freeing queues
Message-ID: <apjbMTi10xfCOS5s@rkannoth-OptiPlex-7090>
References: <20260828035231.46911-1-rkannoth@marvell.com>
 <20260902172428.534936-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902172428.534936-1-horms@kernel.org>
X-Proofpoint-ORIG-GUID: 6Cpz-VO-ate_HKTRXDs4RJb9tAD55hgM
X-Authority-Analysis: v=2.4 cv=OYSoyBTY c=1 sm=1 tr=0 ts=6a98db3b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=a9SWPeKXPFXt2NByfbMA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAyMCBTYWx0ZWRfXzjwOODeC9kGE
 Jb2Kq4dVUWTswP0FRrJjVZYZ0NtrDjbH4z2duLTT3ogbDhkO9QslEDHhxi01Kkt8rFvR1RUlZB7
 Y1f9YD4SJWKpZXPOsToH6c3SjdLAE5pB6BIKkwsfLm95PuS1r/tScfyNH445j/6eI6dUIihHzJD
 8g6/ZcnS1cS2eoKg2Nt9CntHsUYzZ65Xd/0f8Bq6kX+kDrEoTIFaoEnUhtVqkuxCTIupSTyR6Z2
 GUw2jjabfWAmCsttIGnuhcdtZ4AotSWb+4mZNKNdI/MtVDF4aENQoysWcAIi1m9ZS/mziUFPdZ0
 TV7RUVK/o5B6KKwIdTePxcGAxyHcmtMcIeMPBt4Pc1myvoZZJwzXx2wZJWK4IQPiH+Q1AlmrBro
 O5Dj5GRFGFfOw1D1+urPvq+gQ5Nse6c0fd4bAnWYYh9fD9bmxFl0Smi+Ng4MgyGDW+LbpAE6D2N
 VHApSYcy445V4o9fsDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDAyMCBTYWx0ZWRfX1vo8r51Nt8C5
 EmOhMrr8DkOcN8PUeqVn6lFwm8TNUD7LaDRiqjt+GWWKURsusPls8ncH4s6WdqZvaS8h+VQX3W9
 uy7LDt7q4ox39XA3MS3akFT1G+0aKFA=
X-Proofpoint-GUID: 6Cpz-VO-ate_HKTRXDs4RJb9tAD55hgM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_06,2026-09-02_04,2025-10-01_01

On 2026-09-02 at 22:54:28, Simon Horman (horms@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828035231.46911-1-rkannoth@marvell.com?part=1
> ---
> octeontx2-pf: reset HTB scheduler topology before freeing queues
>
> This adds otx2_qos_reset_schq_topology() and a wrapper
> otx2_qos_free_hw_schq() so that NIX_AF_TLxX_TOPOLOGY is zeroed for TL4
> through TL2 before a QoS scheduler queue is returned to the AF.  The new
> wrapper replaces otx2_txschq_free_one() in the class node teardown path and
> in the cfg rollback path.
>
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> > index 69c0911e28e91..ab9661334e6f9 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> > @@ -235,6 +235,58 @@ static int otx2_qos_txschq_set_parent_topology(struct otx2_nic *pfvf,
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
> > +	else
> > +		cfg->reg[0] = NIX_AF_TL1X_TOPOLOGY(schq);
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
>
> [Severity: Low]
> The trailing else here cannot be reached.  In the mbox level enum
> NIX_TXSCH_LVL_TL4 is 1, TL3 is 2, TL2 is 3 and TL1 is 4, and the guard
> at the top of otx2_qos_reset_schq_topology() already bails out with:
>
> 	if (lvl < NIX_TXSCH_LVL_TL4 || lvl >= NIX_TXSCH_LVL_TL1)
> 		return 0;
>
> so only lvl 1, 2 and 3 ever get past it, and those three values are
> exhaustively covered by the TL4/TL3/TL2 arms above.  The
> NIX_AF_TL1X_TOPOLOGY(schq) assignment is dead code.
>
> Beyond being unreachable, it actively contradicts the commit message,
> which says the aggregation level is deliberately skipped because TL1 is
> shared with the PF, the default Tx hierarchy and the VFs and is never
> returned to the AF by nix_txschq_free_one().  A reader who only sees the
> else arm will conclude the opposite, and if the guard is ever relaxed the
> function will silently start zeroing a TL1 TOPOLOGY that other users
> depend on.
>
> Would you drop the else arm and make the last case an explicit
> "else if (lvl == NIX_TXSCH_LVL_TL2)", or convert the chain to a switch
> with the TL1 case omitted, so the code and the commit message agree on
> which levels are handled?
>
> [Severity: High]
> Was otx2_qos_free_hw_node_schq() intentionally left on the bare
> otx2_txschq_free_one() path?  It still reads:
>
> drivers/net/ethernet/marvell/octeontx2/nic/qos.c:otx2_qos_free_hw_node_schq() {
> 	list_for_each_entry_reverse(node, &parent->child_schq_list, list)
> 		otx2_txschq_free_one(pfvf, node->level, node->schq);
> }
>
> These child_schq_list entries are the intermediate chain created by
> otx2_qos_alloc_txschq_node() for every level from node->level - 1 down to
> MDQ:
>
> 	for (lvl = node->level - 1; lvl >= NIX_TXSCH_LVL_MDQ; lvl--) {
>
> so they sit at exactly the TL4/TL3/TL2 levels the commit message says are
> sanitized.
>
> They also carry TOPOLOGY, since otx2_qos_txschq_push_cfg_schq() programs it
> for each chain entry's parent:
>
> 	list_for_each_entry(tmp, &node->child_schq_list, list) {
> 		ret = otx2_qos_txschq_config(pfvf, tmp);
> 		if (ret)
> 			return -EIO;
> 		ret = otx2_qos_txschq_set_parent_topology(pfvf, tmp->parent);
>
> Two cases where those chain schqs would reach nix_txschq_free_one() with a
> non-zero TOPOLOGY:
>
> 1) HTB set up while the interface is down.  otx2_qos_push_txschq_cfg() and
>    otx2_qos_root_add() only fill the cfg and skip hardware programming:
>
> 	if (!(pfvf->netdev->flags & IFF_UP)) {
> 		otx2_qos_txschq_fill_cfg(pfvf, node, cfg);
> 		return 0;
> 	}
>
>    A following "tc qdisc del" while still down goes
>    otx2_qos_root_destroy() -> otx2_qos_destroy_node() ->
>    otx2_qos_free_hw_cfg() -> otx2_qos_free_hw_node_schq(), returning the
>    queue with whatever TOPOLOGY the previous owner left.
>
> 2) A partially failed push, for example otx2_qos_txschq_update_config()
>    failing in the restore paths of otx2_qos_leaf_to_inner() /
>    otx2_qos_leaf_alloc(), or otx2_qos_config_txschq() failing on ifup.  The
>    chain is left unprogrammed and later freed through the same helper.
>
> On the AF side nix_txschq_free_one() only touches XOFF, linkcfg, shaping and
> schedule:
>
> drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:nix_txschq_free_one() {
> 	nix_clear_tx_xoff(rvu, blkaddr, lvl, schq);
> 	nix_reset_tx_linkcfg(rvu, blkaddr, lvl, schq);
> 	nix_reset_tx_shaping(rvu, blkaddr, nixlf, lvl, schq);
> 	...
> 	nix_reset_tx_schedule(rvu, blkaddr, lvl, schq);
> }
>
> so a stale PRIO_ANCHOR/RR_PRIO in those chain queues would still survive
> into the shared pool, which is the case the commit message describes.
>
> > @@ -252,7 +304,7 @@ static void otx2_qos_free_hw_node(struct otx2_nic *pfvf,
> >  	list_for_each_entry_safe(node, tmp, &parent->child_list, list) {
> >  		otx2_qos_free_hw_node(pfvf, node);
> >  		otx2_qos_free_hw_node_schq(pfvf, node);
> > -		otx2_txschq_free_one(pfvf, node->level, node->schq);
> > +		otx2_qos_free_hw_schq(pfvf, node->level, node->schq);
> >  	}
> >  }
> >
> > @@ -913,7 +965,7 @@ static void otx2_qos_free_cfg(struct otx2_nic *pfvf, struct otx2_qos_cfg *cfg)
> >  	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
> >  		for (idx = 0; idx < cfg->schq[lvl]; idx++) {
> >  			schq = cfg->schq_list[lvl][idx];
> > -			otx2_txschq_free_one(pfvf, lvl, schq);
> > +			otx2_qos_free_hw_schq(pfvf, lvl, schq);
> >  		}
> >  	}
> >
>
> Is the difference between the two paths deliberate?  cfg->schq_list is
> filled from child_schq_list by otx2_qos_read_txschq_cfg_schq(), so the
> rollback path here does reset TOPOLOGY for the same queues that the
> hierarchy teardown in otx2_qos_free_hw_node_schq() frees without a reset.
> Would routing the child_schq_list loop through otx2_qos_free_hw_schq() as
> well make the two paths symmetric?
>
> [ ... ]

ACK.

pw-bot: changes-requested
