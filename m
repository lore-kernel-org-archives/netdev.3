Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA26230648C;
	Wed,  9 Sep 2026 02:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788921418; cv=none; b=VRzFUBepYiZLhuo7BmulrWumoNH4UVAmHnYfA8QVD2LTCboQqec8cwxSsrHFRYLEPQ/9C/eflORRywS55ZKSdt/qo2rJkT4Dpa8EfMaaxND5kATphv+3vQyBzPg+K953Vn+6BRwvtk+8ABhRmfaq0bJi+tPoRHUGdDoI5ZnruyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788921418; c=relaxed/simple;
	bh=MdMRKcr4RCcIckMKiox054ELsgROHZ/zrOl7J0fhazo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GN8bMcwv2RSnrlne+wu8ExjDIGvMqQTYYV7Eaw27LbLs+hE25q2NPEwAmsCgY9Foy2FFcfxI9+NIImHVUlSQfoiXTwVcvWqrYa3FhLSX2k5E+4liEhHiJlD8hj57K6W5J01WQWEyugKeqrsDNYHh6nDn6M62kO97ndoFkt+qQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAxvAivo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAxvAivo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011C11F00A3A;
	Wed,  9 Sep 2026 02:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788921413;
	bh=7SnHjoka3biYXsU/usMnvGvxju6EcnroAMwKl7/BMn0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PAxvAivoBVWJl8aNUDPk7Q3Eb+LmKGduCMb4I2WXGuv+8kk0AqabYIBOZE0Lxxunc
	 rCUDELZFcpOZTc4L/Qnud3yYfOeCSoAclz/oHL01ra9d8nXK/6LUtreIXMvld8sIr9
	 3/Nr1aHBSqEoSIhRYHWAiT+vUfxoE5iK1EjvNMdzQ66nvpWMhDVUofI2EwUg+B14rq
	 3kPIs2fSAJy2wX2H62KjG5lu61Sm0W7TlJvq818p47VcrhAIF6TBd5Nj3rhGe//LDt
	 Os0FXAzvztZ1Ps5JTq7AytxXqIOq88tIklY2wOp7j0PDFTHAA56iHGI9sMdozI9Mts
	 oxij27YLB1i2Q==
Subject: Re: [PATCH net] octeontx2-pf: fix null RX segment address free
From: netdev-bot+sashiko@kernel.org
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gakula@marvell.com,
 sgoutham@marvell.com, rkannoth@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 09 Sep 2026 02:36:52 +0000
Message-ID: <178892141248.219967.7550488863478080555@kernel.org>
In-Reply-To: <20260903143516.2697708-1-nshettyj@marvell.com>
References: <20260903143516.2697708-1-nshettyj@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 0 · Low: 0

- [High] Incomplete fix: the zero-`seg_addr` guard is added only to
  `otx2_free_rcv_seg()`, leaving the bug class the commit message claims…
- [High] The new guard in `otx2_free_rcv_seg()` (otx2_txrx.c:260-261)
  uses `return`, which aborts the inner per-segment loop *and* the outer…

--

octeontx2-pf: fix null RX segment address free

The patch adds a check in otx2_free_rcv_seg() so that a segment address
which reads back as zero is not handed to aura_freeptr().  It targets the
multi-segment reclaim path introduced by b1bc8457e9d0.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 8d2d607bc92f..a9aefd14ae52 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -256,9 +256,12 @@ static void otx2_free_rcv_seg(struct otx2_nic *pfvf, struct nix_cqe_rx_s *cqe,
>  	while (start < end) {
>  		sg = (struct nix_rx_sg_s *)start;
>  		seg_addr = &sg->seg_addr;
> -		for (seg = 0; seg < sg->segs; seg++, seg_addr++)
> +		for (seg = 0; seg < sg->segs; seg++, seg_addr++) {
> +			if (unlikely(!*seg_addr))
> +				return;

[Severity: High]
Should this be continue instead of return?

The return leaves both the inner per-segment loop and the outer
while (start < end) walk over the remaining SG sub-descriptors, so if
slot N reads zero, slots N+1..segs-1 and every later SG word inside
(desc_sizem1 + 1) * 16 are never returned to the aura.

struct nix_rx_sg_s in otx2_struct.h describes segs as a count, not a
null-terminated list:

	u64 segs       : 2;
	...
	u64 seg_addr;
	u64 seg2_addr;
	u64 seg3_addr;

and the peer walk in otx2_rcv_pkt_handler() processes every advertised
slot of every SG word, so the two readers of the same descriptor now
disagree about its meaning.

Neither caller re-scans the CQE afterwards.  otx2_check_rcv_errors()
does:

	/* Free buffer back to pool */
	if (cqe->sg.segs)
		otx2_free_rcv_seg(pfvf, cqe, qidx);
	return true;

and otx2_cleanup_rx_cqes() bumps processed_cqe, continues, and later
rings the CQ doorbell.  Can the skipped pointers leak the RX buffers
here, i.e. lose them from the NPA aura and, on the teardown path, leave
pages charged to the page_pool with their DMA mappings still installed
so page_pool_destroy() sees inflight pages?

The commit message describes a per-segment condition ("when the segment
address is null"), which reads more like a skip of the single bad slot
than an abort of the whole reclaim loop.

>  			pfvf->hw_ops->aura_freeptr(pfvf, qidx,
>  						   *seg_addr & ~0x07ULL);
> +		}
>  		start += sizeof(*sg);
>  	}
>  }

[Severity: High]
If a segment address in an RX CQE can be observed as zero, does the fix
cover the other readers of the same descriptor words?

otx2_rcv_pkt_handler() performs the identical walk with no zero test at
all:

	start = (void *)sg;
	end = start + ((cqe->parse.desc_sizem1 + 1) * 16);
	while (start < end) {
		sg = (struct nix_rx_sg_s *)start;
		seg_addr = &sg->seg_addr;
		seg_size = (void *)sg;
		for (seg = 0; seg < sg->segs; seg++, seg_addr++) {
			if (otx2_skb_add_frag(pfvf, skb, *seg_addr,
					      seg_size[seg], parse, cq->cq_idx))
				cq->pool_ptrs++;
		}
		start += sizeof(*sg);
	}

The pre-check in otx2_rx_napi_handler() only looks at the first word:

		if (cqe->hdr.cqe_type == NIX_XQE_TYPE_INVALID ||
		    !cqe->sg.seg_addr) {

so seg2_addr, seg3_addr and any later SG sub-descriptor reach
otx2_skb_add_frag() unchecked.  With a zero iova that function does:

	va = phys_to_virt(otx2_iova_to_phys(pfvf->iommu_domain, iova));
	...
	page = virt_to_page(va);

and publishes a page the driver never allocated into the GRO skb, with
skb_mark_for_recycle() run on it later.  When nr_frags has reached
MAX_SKB_FRAGS it also does:

	pfvf->hw_ops->aura_freeptr(pfvf, qidx, iova & ~0x07ULL);

which is the same invalid free the commit message says it is preventing,
only on the fast path.  Can this happen?

The same question applies to the caller that motivates this change.  In
otx2_cleanup_rx_cqes() only the multi-segment case goes through the
patched helper:

		if (cqe->sg.segs > 1) {
			otx2_free_rcv_seg(pfvf, cqe, cq->cq_idx);
			continue;
		}
		iova = cqe->sg.seg_addr - OTX2_HEAD_ROOM;

		otx2_free_bufs(pfvf, pool, iova, pfvf->rbsize);

With seg_addr == 0 the subtraction underflows, and otx2_free_bufs() in
otx2_common.c then does virt_to_head_page(phys_to_virt(pa)) followed by
page_pool_put_full_page() / dma_unmap / put_page() on a page derived from
that address.  Does this branch need the same guard?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903143516.2697708-1-nshettyj%40marvell.com
