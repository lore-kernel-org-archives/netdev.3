Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87FB3DD85E;
	Mon, 28 Sep 2026 06:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577968; cv=none; b=VzUc3iU2SaxhzTI7BMaCUmoeAg9plNDL0UAVwA2RJU5HU8meP1qVTxvoVsvSrFBfCTvMvC6UEzHZo0mPpe1wB2/M2tAFYflyEGCxtrgsgDcZZvEVEn1OMW0Od2hyp3dz1YYYS3ppvvINhxSTI3by0YO3kArJHEzE+l/B3iMIz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577968; c=relaxed/simple;
	bh=pf1h8s51mQykoNLGiSOErB3X4yqDv5SE+AXtizTgDFU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyF6gtwZFhin06A/dFX6Y1+AplFeREekYAQuQ3bURfhpfvVv2nWCCrYgKu2I0owTM6qc4PeQGu+kGOqeDbd598nQcqxZo9pONny0s2FNf3H/mDIqYu3lHQXcLi9g5CI81wHq9mahot2TrEjS9qNwoWbcLgOiNiv/WES1Q4ToUsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=k70cG1fq; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="k70cG1fq"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S1vOlo1520056;
	Sun, 27 Sep 2026 23:45:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=yYshQPdA8r2ZC3kQohRYeFfzM
	/hRSL+/+GvCj72n+3o=; b=k70cG1fq5ymDNkzzaABHMemNxF7Po7q2YeLEj1NLK
	OIo9/QMGNjK+rzZVxn4pUzw4GFyOP2BMjw4gzRrVsd6S5M1VP752YICuRwskju4L
	o9SIYTgCE93nnrfYY39Lio3LqlTOzpbUUJOp+QMEDqju7ifJH/shaq0QxVcORXGn
	zYfR3vcsfARxP06oNs0GNU6tQU7c5yC8XBsr1F/2c8amKPbOO1x/89fsnf9yMkF+
	oJR8j8U3C5j/hwWVBud6q5XEzVwGVbofx5c20cE9RD8pGA3NdfngrfUw6tjwLRoB
	j7sLk/VQHbZVEdFq0ec2pvk84AGTt/7xNpWc0wR6H8tZA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gxxt7t8jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Sep 2026 23:45:55 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 27 Sep 2026 23:45:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 27 Sep 2026 23:45:54 -0700
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id C88F23F706C;
	Sun, 27 Sep 2026 23:45:50 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:15:49 +0530
From: Nitin Shetty J <nshettyj@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rkudurumalla@marvell.com>, <sgoutham@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <horms@kernel.org>, <nshettyj@marvell.com>
Subject: Re: [PATCH net v2] octeontx2-af: Fix BPID leak in nix_bp_enable()
Message-ID: <aroNHaLv6y14+5MY@kernel-ep2>
References: <20260910031604.1045397-1-nshettyj@marvell.com>
 <20260915131714.165308-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260915131714.165308-1-pabeni@redhat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyNiBTYWx0ZWRfX3SjiSoQy1yZ/
 Kd/GpAwARRsN8kus1In0i+Afr2E0kH7LBIclm3Rafm7qpv5ovpiIEwYxfA9lyqEhMVOIFipk+7M
 xeuJ1vyDXtDeRwkGQcpVKc79PgDnLO57qHWGmI7vR2bK70aUqYVnxPydm7AaeuUxuoGPQrBAaXG
 HxhWdbwTh1ZZ/rXEddd2PTkOhsuufpHOdtGampcYKTq8vxFSBzqTFoeFabOTiTvEw9zd15qdMmd
 L9WPv9D/MmNx18A9QXU3u270C4QGhI8ITU7IPGhro8qNO0478gkSlgNhoqYuyXlr9MFIi9LBXaD
 SwiyqhWtW0SgcCnmoNIXPD6j3S+SlgxkTZ+4Y+TiiZ1rLlMw9SmVrV/gybi1bw3ZxPlS1CImS5j
 EfEqxwcfc3tA9sBmgNAAE0p1EqlrGLjxir6BxG4eocmIqlZTqY0wpRX80eb0oBC7EsII3S6q2gj
 aPzsJ1z8rLPD7DPwekw==
X-Proofpoint-GUID: xAp85VNxfSZvwM_bBFozCPBuBXz8r5vh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyNiBTYWx0ZWRfX2PpGEb3QQrZL
 iuGiHR+FQeyOHJSqOUYZyAUpLc+jCVWiYLi1ZxWDW96aszZ9vN6fRkdGOONfzRdLZYfNg141ecX
 GnbuxQxHjsQOxYva/9SEcR5fNjMDBcI=
X-Authority-Analysis: v=2.4 cv=YaEodARf c=1 sm=1 tr=0 ts=6aba0d23 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=9R54UkLUAAAA:8
 a=20KFwNOVAAAA:8 a=84KQUMrIFqjjkz30nnYA:9 a=CjuIK1q_8ugA:10
 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: xAp85VNxfSZvwM_bBFozCPBuBXz8r5vh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01

On 2026-09-15 at 18:47:14, Paolo Abeni (pabeni@redhat.com) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> octeontx2-af: Fix BPID leak in nix_bp_enable()
> 
> For LBK interfaces rvu_nix_get_bpid() takes a BPID from the free pool on
> every call, and nix_bp_enable() used to call it once before the loop and
> once more after the last channel was programmed. The patch moves the
> allocation into the loop body and rejects req->chan_cnt == 0 upfront.
> 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > index 153eb57bad067..3a43432d29c15 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > @@ -764,19 +764,25 @@ static int nix_bp_enable(struct rvu *rvu,
> >  	if (cpt_link && !rvu->hw->cpt_links)
> >  		return 0;
> >  
> > +	if (!req->chan_cnt)
> > +		return NIX_AF_ERR_INVALID_BPID_REQ;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but since the change adds request
> validation here, is the companion bound on req->chan_base / req->chan_cnt
> also needed for LBK?
> 
> rvu_nix_get_bpid() range-checks the channel interval only for the CGX and
> SDP cases:
> 
> 	case NIX_INTF_TYPE_CGX:
> 		if ((req->chan_base + req->chan_cnt) > NIX_BPIDS_PER_LMAC)
> 			return NIX_AF_ERR_INVALID_BPID_REQ;
> 	...
> 	case NIX_INTF_TYPE_SDP:
> 		if ((req->chan_base + req->chan_cnt) > bp->sdp_bpid_cnt)
> 			return NIX_AF_ERR_INVALID_BPID_REQ;
> 
> The NIX_INTF_TYPE_LBK case has no such check, and nix_interface_init() gives
> an LBK VF exactly one RX channel (pfvf->rx_chan_cnt = 1), while req->chan_base
> is a u16 copied straight out of the mailbox region.
> 
> So chan_base = pfvf->rx_chan_base + req->chan_base can be any 16-bit value,
> and each iteration does a read-modify-write of the AF-global register
> NIX_AF_RX_CHANX_CFG(chan_v), which expands to 0x1A30 | (a) << 15. With
> req->chan_base near 0xFFF0 the offset reaches roughly 0x7FFF8000, well past
> the 1 << 28 per-block stride assumed by rvu_write64():
> 
> 	writeq(val, rvu->afreg_base + ((block << 28) | offset));
> 
> Can an LBK VF therefore reprogram the backpressure configuration of channels
> owned by other PF/VFs (arming them against a foreign BPID with BIT_ULL(16)
> set), or push the access outside the intended NIX register window?
> 
Since it is exisiting issue will submit separate patch.

> >  	pfvf = rvu_get_pfvf(rvu, pcifunc);
> >  	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
> >  
> > -	bpid_base = rvu_nix_get_bpid(rvu, req, type, chan_id);
> >  	chan_base = pfvf->rx_chan_base + req->chan_base;
> > -	bpid = bpid_base;
> > +	bpid_base = -1;
> >  
> >  	for (chan = chan_base; chan < (chan_base + req->chan_cnt); chan++) {
> > +		bpid = rvu_nix_get_bpid(rvu, req, type, chan_id);
> >  		if (bpid < 0) {
> >  			dev_warn(rvu->dev, "Fail to enable backpressure\n");
> >  			return -EINVAL;
> >  		}
> 
> [Severity: High]
> Now that the allocation happens per iteration, does this bare return leak the
> BPIDs already taken for the earlier channels?
> 
> For LBK, each call consumes one entry of the finite free pool and records
> ownership:
> 
> 	case NIX_INTF_TYPE_LBK:
> 		/* Alloc bpid from the free pool */
> 		mutex_lock(&rvu->rsrc_lock);
> 		bpid = rvu_alloc_rsrc(&bp->bpids);
> 		if (bpid < 0) {
> 			mutex_unlock(&rvu->rsrc_lock);
> 			return NIX_AF_ERR_INVALID_BPID;
> 		}
> 		bp->fn_map[bpid] = req->hdr.pcifunc;
> 		bp->ref_cnt[bpid]++;
> 
> A request with req->chan_cnt larger than the number of free pool entries
> fails deterministically once rvu_alloc_rsrc() returns -ENOSPC. At that point
> iterations 0..i-1 have already allocated BPIDs and written them into
> NIX_AF_RX_CHANX_CFG with the enable bit set, and this path returns without
> freeing them or clearing the enable bit.
> 
> The response is also left zeroed (otx2_mbox_alloc_msg_rsp() memsets the msg
> region and rsp->chan_cnt is only set at the end of the function), so the
> requester learns no channel/BPID mapping and will not send a matching
> NIX_BP_DISABLE. Does that leave the BPIDs marked used with fn_map/ref_cnt
> set until FLR, and the affected RX channels armed against BPIDs that no aura
> maps?
> 
> Would an unwind loop that frees the BPIDs and clears BIT_ULL(16) for the
> channels programmed so far be appropriate here?
> 
will fix it in next patch version

> >  
> > +		if (bpid_base < 0)
> > +			bpid_base = bpid;
> > +
> 
> [Severity: Medium]
> Only the first allocation is remembered here, but the response is built from
> it arithmetically:
> 
> 	for (chan = 0; chan < req->chan_cnt; chan++) {
> 		/* Map channel and bpid assign to it */
> 		rsp->chan_bpid[chan] = ((req->chan_base + chan) & 0x7F) << 10 |
> 					(bpid_base & 0x3FF);
> 		if (req->bpid_per_chan)
> 			bpid_base++;
> 	}
> 
> Does this diverge from what was actually programmed for LBK?
> 
> The mailbox contract in mbox.h says:
> 
> 	u8	bpid_per_chan;
> 	/* bpid_per_chan = 0 assigns single bp id for range of channels */
> 	/* bpid_per_chan = 1 assigns separate bp id for each channel */
> 
> The LBK branch of rvu_nix_get_bpid() ignores req->bpid_per_chan and always
> allocates a fresh pool entry. With bpid_per_chan == 0 and chan_cnt > 1, each
> NIX_AF_RX_CHANX_CFG gets a different BPID while rsp->chan_bpid[] reports
> bpid_base for every channel. The requester then wires up only bpid_base:
> 
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:mbox_handler_nix_bp_enable() {
> 	for (chan = 0; chan < rsp->chan_cnt; chan++) {
> 		chan_id = ((rsp->chan_bpid[chan] >> 10) & 0x7F);
> 		pfvf->bpid[chan_id] = rsp->chan_bpid[chan] & 0x3FF;
> 	}
> }
> 
> With bpid_per_chan == 1 the response assumes bpid_base, bpid_base + 1, ...,
> but rvu_alloc_rsrc() returns the first free bit of a shared bitmap:
> 
> 	id = find_first_zero_bit(rsrc->bmap, rsrc->max);
> 	if (id >= rsrc->max)
> 		return -ENOSPC;
> 	__set_bit(id, rsrc->bmap);
> 
> and rvu_nix_get_bpid() takes and drops rvu->rsrc_lock once per channel, so a
> fragmented pool or an interleaved allocation by another LBK function gives
> non-contiguous BPIDs. Can the reported map then name a BPID owned by a
> different pcifunc?
> 
> For bpid_per_chan == 0, would allocating once per request (and reporting the
> BPIDs actually written) match the documented behaviour better than "exactly
> once per channel actually programmed"?
> 
will fix it in next patch version

> >  		chan_v = nix_get_channel(chan, cpt_link);
> >  
> >  		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v));
> > @@ -784,7 +790,6 @@ static int nix_bp_enable(struct rvu *rvu,
> >  		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
> >  			    cfg | (bpid & GENMASK_ULL(8, 0)) | BIT_ULL(16));
> >  		chan_id++;
> > -		bpid = rvu_nix_get_bpid(rvu, req, type, chan_id);
> >  	}
> >  
> >  	for (chan = 0; chan < req->chan_cnt; chan++) {
> 
> [Severity: Critical]
> This is a pre-existing issue, but it interacts with the new mid-loop error
> return above, so it seems worth raising here.
> 
> nix_bp_disable() recovers the BPID to release from the channel register:
> 
> 	if (type == NIX_INTF_TYPE_LBK) {
> 		bpid = cfg & GENMASK(8, 0);
> 		mutex_lock(&rvu->rsrc_lock);
> 		rvu_free_rsrc(&bp->bpids, bpid - bp->free_pool_base);
> 
> nix_setup_bpids() makes free_pool_base strictly positive:
> 
> 	bp->free_pool_base = bp->cgx_bpid_cnt + bp->sdp_bpid_cnt +
> 			     NIX_BPIDS_PER_CPT;
> 
> So for any channel whose CFG BPID field is below free_pool_base - the reset
> value 0 on a channel that was never enabled, the tail channels left
> unprogrammed by the new error return in nix_bp_enable(), or a CGX-range BPID
> belonging to another function - the second argument is negative.
> 
> rvu_free_rsrc() does not check it:
> 
> 	void rvu_free_rsrc(struct rsrc_bmap *rsrc, int id)
> 	{
> 		if (!rsrc->bmap)
> 			return;
> 
> 		__clear_bit(id, rsrc->bmap);
> 	}
> 
> and generic___clear_bit() takes an unsigned long:
> 
> 	unsigned long mask = BIT_MASK(nr);
> 	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> 
> 	*p &= ~mask;
> 
> Can this write outside bp->bpids.bmap? Since nothing bounds chan_base /
> chan_cnt for LBK, a VF sending NIX_BP_DISABLE over channels it never enabled
> appears to reach this with bpid == 0. Should nix_bp_disable() validate that
> the register-derived BPID falls inside the free pool range before converting
> it to a pool index?
will fix it in next patch version

> -- 
> This is an AI-generated review.
> 
> 
