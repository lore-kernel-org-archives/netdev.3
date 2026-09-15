Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D23CB2E7
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478251; cv=none; b=KhYe9yMc65/N0EZZkAEK3LNbSpXgamBpOkirzsBjCFGvnYqfezl5SYFDx36svE7W3DJZjiiZEXnwrFcUdt+oWJz4/9VJBgkECrmtB/A9BcU7uaX9C4f1/FjvKNgbrNRoa2rdT8eSoZsP3P06PiZygE+Cnch82dN9G1Spv+CV0o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478251; c=relaxed/simple;
	bh=rym8qmba/3s+ZO+whDfWTVaJmUB31ha95ckxa8JtKz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzQuDOKWohFkoWvaCSqQSR+K0dZnsx+i4OE0jFaPv8LZjsDBebh54ZXeAGW8BA0AE4UmG18e8lm7E+ZYnUOUlARC4Fws/mmeZ2DxivnQMrGOjMnzZ3mp0xdyXYmnIvTFcIJEBvqJHn8h9whIuRNU2nlB3TUfvD290VKnZo6q1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGb1IHHl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGb1IHHl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789478248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udAajbuLtlPMxF8+J1Q9crxNPdR/M1cosm6ntUIT0f4=;
	b=JGb1IHHlWAQBSRr0BOlAD/lQz3SCliDDP3V1T4RI8sWDbQ9NytDYJmAqmhO38s0wEHpUPh
	Bmh5nL/rfu7pyTk6PEWZhE+Bego72NEeF3WHePS4g8I/MY5akWr8nT48Mp4T3aUgQjtrDx
	8rM7SWywgK04XY6qv7rXXARdsdKLdM4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-HARsTPi7OrucWwcCYecBJw-1; Tue,
 15 Sep 2026 09:17:25 -0400
X-MC-Unique: HARsTPi7OrucWwcCYecBJw-1
X-Mimecast-MFC-AGG-ID: HARsTPi7OrucWwcCYecBJw_1789478243
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0935918011F4;
	Tue, 15 Sep 2026 13:17:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.22.72.2])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D6F6E1956058;
	Tue, 15 Sep 2026 13:17:18 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rkudurumalla@marvell.com,
	sgoutham@marvell.com,
	rkannoth@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [PATCH net v2] octeontx2-af: Fix BPID leak in nix_bp_enable()
Date: Tue, 15 Sep 2026 15:17:14 +0200
Message-ID: <20260915131714.165308-1-pabeni@redhat.com>
In-Reply-To: <20260910031604.1045397-1-nshettyj@marvell.com>
References: <20260910031604.1045397-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
octeontx2-af: Fix BPID leak in nix_bp_enable()

For LBK interfaces rvu_nix_get_bpid() takes a BPID from the free pool on
every call, and nix_bp_enable() used to call it once before the loop and
once more after the last channel was programmed. The patch moves the
allocation into the loop body and rejects req->chan_cnt == 0 upfront.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 153eb57bad067..3a43432d29c15 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -764,19 +764,25 @@ static int nix_bp_enable(struct rvu *rvu,
>  	if (cpt_link && !rvu->hw->cpt_links)
>  		return 0;
>  
> +	if (!req->chan_cnt)
> +		return NIX_AF_ERR_INVALID_BPID_REQ;

[Severity: High]
This isn't a bug introduced by this patch, but since the change adds request
validation here, is the companion bound on req->chan_base / req->chan_cnt
also needed for LBK?

rvu_nix_get_bpid() range-checks the channel interval only for the CGX and
SDP cases:

	case NIX_INTF_TYPE_CGX:
		if ((req->chan_base + req->chan_cnt) > NIX_BPIDS_PER_LMAC)
			return NIX_AF_ERR_INVALID_BPID_REQ;
	...
	case NIX_INTF_TYPE_SDP:
		if ((req->chan_base + req->chan_cnt) > bp->sdp_bpid_cnt)
			return NIX_AF_ERR_INVALID_BPID_REQ;

The NIX_INTF_TYPE_LBK case has no such check, and nix_interface_init() gives
an LBK VF exactly one RX channel (pfvf->rx_chan_cnt = 1), while req->chan_base
is a u16 copied straight out of the mailbox region.

So chan_base = pfvf->rx_chan_base + req->chan_base can be any 16-bit value,
and each iteration does a read-modify-write of the AF-global register
NIX_AF_RX_CHANX_CFG(chan_v), which expands to 0x1A30 | (a) << 15. With
req->chan_base near 0xFFF0 the offset reaches roughly 0x7FFF8000, well past
the 1 << 28 per-block stride assumed by rvu_write64():

	writeq(val, rvu->afreg_base + ((block << 28) | offset));

Can an LBK VF therefore reprogram the backpressure configuration of channels
owned by other PF/VFs (arming them against a foreign BPID with BIT_ULL(16)
set), or push the access outside the intended NIX register window?

>  	pfvf = rvu_get_pfvf(rvu, pcifunc);
>  	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
>  
> -	bpid_base = rvu_nix_get_bpid(rvu, req, type, chan_id);
>  	chan_base = pfvf->rx_chan_base + req->chan_base;
> -	bpid = bpid_base;
> +	bpid_base = -1;
>  
>  	for (chan = chan_base; chan < (chan_base + req->chan_cnt); chan++) {
> +		bpid = rvu_nix_get_bpid(rvu, req, type, chan_id);
>  		if (bpid < 0) {
>  			dev_warn(rvu->dev, "Fail to enable backpressure\n");
>  			return -EINVAL;
>  		}

[Severity: High]
Now that the allocation happens per iteration, does this bare return leak the
BPIDs already taken for the earlier channels?

For LBK, each call consumes one entry of the finite free pool and records
ownership:

	case NIX_INTF_TYPE_LBK:
		/* Alloc bpid from the free pool */
		mutex_lock(&rvu->rsrc_lock);
		bpid = rvu_alloc_rsrc(&bp->bpids);
		if (bpid < 0) {
			mutex_unlock(&rvu->rsrc_lock);
			return NIX_AF_ERR_INVALID_BPID;
		}
		bp->fn_map[bpid] = req->hdr.pcifunc;
		bp->ref_cnt[bpid]++;

A request with req->chan_cnt larger than the number of free pool entries
fails deterministically once rvu_alloc_rsrc() returns -ENOSPC. At that point
iterations 0..i-1 have already allocated BPIDs and written them into
NIX_AF_RX_CHANX_CFG with the enable bit set, and this path returns without
freeing them or clearing the enable bit.

The response is also left zeroed (otx2_mbox_alloc_msg_rsp() memsets the msg
region and rsp->chan_cnt is only set at the end of the function), so the
requester learns no channel/BPID mapping and will not send a matching
NIX_BP_DISABLE. Does that leave the BPIDs marked used with fn_map/ref_cnt
set until FLR, and the affected RX channels armed against BPIDs that no aura
maps?

Would an unwind loop that frees the BPIDs and clears BIT_ULL(16) for the
channels programmed so far be appropriate here?

>  
> +		if (bpid_base < 0)
> +			bpid_base = bpid;
> +

[Severity: Medium]
Only the first allocation is remembered here, but the response is built from
it arithmetically:

	for (chan = 0; chan < req->chan_cnt; chan++) {
		/* Map channel and bpid assign to it */
		rsp->chan_bpid[chan] = ((req->chan_base + chan) & 0x7F) << 10 |
					(bpid_base & 0x3FF);
		if (req->bpid_per_chan)
			bpid_base++;
	}

Does this diverge from what was actually programmed for LBK?

The mailbox contract in mbox.h says:

	u8	bpid_per_chan;
	/* bpid_per_chan = 0 assigns single bp id for range of channels */
	/* bpid_per_chan = 1 assigns separate bp id for each channel */

The LBK branch of rvu_nix_get_bpid() ignores req->bpid_per_chan and always
allocates a fresh pool entry. With bpid_per_chan == 0 and chan_cnt > 1, each
NIX_AF_RX_CHANX_CFG gets a different BPID while rsp->chan_bpid[] reports
bpid_base for every channel. The requester then wires up only bpid_base:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:mbox_handler_nix_bp_enable() {
	for (chan = 0; chan < rsp->chan_cnt; chan++) {
		chan_id = ((rsp->chan_bpid[chan] >> 10) & 0x7F);
		pfvf->bpid[chan_id] = rsp->chan_bpid[chan] & 0x3FF;
	}
}

With bpid_per_chan == 1 the response assumes bpid_base, bpid_base + 1, ...,
but rvu_alloc_rsrc() returns the first free bit of a shared bitmap:

	id = find_first_zero_bit(rsrc->bmap, rsrc->max);
	if (id >= rsrc->max)
		return -ENOSPC;
	__set_bit(id, rsrc->bmap);

and rvu_nix_get_bpid() takes and drops rvu->rsrc_lock once per channel, so a
fragmented pool or an interleaved allocation by another LBK function gives
non-contiguous BPIDs. Can the reported map then name a BPID owned by a
different pcifunc?

For bpid_per_chan == 0, would allocating once per request (and reporting the
BPIDs actually written) match the documented behaviour better than "exactly
once per channel actually programmed"?

>  		chan_v = nix_get_channel(chan, cpt_link);
>  
>  		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v));
> @@ -784,7 +790,6 @@ static int nix_bp_enable(struct rvu *rvu,
>  		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
>  			    cfg | (bpid & GENMASK_ULL(8, 0)) | BIT_ULL(16));
>  		chan_id++;
> -		bpid = rvu_nix_get_bpid(rvu, req, type, chan_id);
>  	}
>  
>  	for (chan = 0; chan < req->chan_cnt; chan++) {

[Severity: Critical]
This is a pre-existing issue, but it interacts with the new mid-loop error
return above, so it seems worth raising here.

nix_bp_disable() recovers the BPID to release from the channel register:

	if (type == NIX_INTF_TYPE_LBK) {
		bpid = cfg & GENMASK(8, 0);
		mutex_lock(&rvu->rsrc_lock);
		rvu_free_rsrc(&bp->bpids, bpid - bp->free_pool_base);

nix_setup_bpids() makes free_pool_base strictly positive:

	bp->free_pool_base = bp->cgx_bpid_cnt + bp->sdp_bpid_cnt +
			     NIX_BPIDS_PER_CPT;

So for any channel whose CFG BPID field is below free_pool_base - the reset
value 0 on a channel that was never enabled, the tail channels left
unprogrammed by the new error return in nix_bp_enable(), or a CGX-range BPID
belonging to another function - the second argument is negative.

rvu_free_rsrc() does not check it:

	void rvu_free_rsrc(struct rsrc_bmap *rsrc, int id)
	{
		if (!rsrc->bmap)
			return;

		__clear_bit(id, rsrc->bmap);
	}

and generic___clear_bit() takes an unsigned long:

	unsigned long mask = BIT_MASK(nr);
	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);

	*p &= ~mask;

Can this write outside bp->bpids.bmap? Since nothing bounds chan_base /
chan_cnt for LBK, a VF sending NIX_BP_DISABLE over channels it never enabled
appears to reach this with bpid == 0. Should nix_bp_disable() validate that
the register-derived BPID falls inside the free pool range before converting
it to a pool index?
-- 
This is an AI-generated review.

