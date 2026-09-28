Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C31D5174;
	Mon, 28 Sep 2026 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584355; cv=none; b=UXexJS7OTYOY4g2KpikMqMqwveK8/Aiai1ap5SFBrqyb1QHcsa7sZtPCqIotF4ArhAmHItPuo836IphA4z+x7HzIEj9/xlq1ZQcPxrnIcLtYCVva56gRCtew2gedAZeKzRz0KwULuLufyKeX7KZMnwZqlp6UlDN0uRap5jncMac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584355; c=relaxed/simple;
	bh=8Rzb4LGl41qz/oojsGab9S7CbEXwysTMVMHpJeJcgUs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EuTIOCaQvdxDyEoyzHJ1mBtkEZ7z6mQq+2wM3VSi4aI9TodKP6zW1O+Nssk4wVFNGC8Br4WR2kI8FvHvdvTniB58vw5b+xRzlRSf6bfhqMHoCSaTvt5ib4JnVokhttqYvYz3atYnYtizPsGBc/yk8YkV6y9f8bWpR262838Pmiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbUZRQj4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbUZRQj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485191F000FF;
	Mon, 28 Sep 2026 08:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790584353;
	bh=ucIq64lQ1n1AilFNl69re6AfXcJaIAEZ5EtAjXOOsyo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SbUZRQj4Osj/vsusqpdiXMgUc7bPdAYHFVORnml1cPSKpEcvlfb266VY3kcixbKJi
	 sdyxcwdFBUtKy/9JXdm1Gaelz6FT6cpXPW3OlmmUcd+/pqLtIXXacG1UsemHkAH8e8
	 ZZ9uN2O7dCS2HthWiLxlF8CUWgCNlsmMr+mgl3jD6vDDj851Z6x75mkJ66UDRA1NR/
	 cKWq3bqBPyABPQdol5q23kmgcpK83tf/OnXXoMTfSfvYOpsgtfLr/1iU9jlE38Pgtz
	 ExahByOJ3Oqor1PRA8vRQZJ6n1seDxMJZdK2et2j5ZRsyx/viJ1o/2gT+twlfozkC0
	 kwOcMioZ/rBEQ==
Subject:
 Re: [PATCH net] octeontx2-af: fix partial NIX Tx scheduler queue allocation
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 sgoutham@marvell.com, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Date: Mon, 28 Sep 2026 08:32:32 +0000
Message-ID: <179058435280.3145.10954316639683713234@kernel.org>
In-Reply-To: <20260924082128.1944674-1-rkannoth@marvell.com>
References: <20260924082128.1944674-1-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch says it fixes nix_txsch_alloc() 'return[ing] success
  after allocating fewer Tx scheduler queues than requested'.
- [High] The new rollback in nix_txsch_alloc() (rvu_nix.c:2289-2293)
  takes its loop bounds (rsp->schq_contig[lvl] and rsp->schq[lvl], both…
- [Medium] The new `if (nix_txsch_alloc(...)) goto err;` inside the per-
  level loop of rvu_mbox_handler_nix_txsch_alloc() (rvu_nix.c:2356-2357)…
- [Low] The commit message says nix_txsch_alloc() 'could return success
  after allocating fewer Tx scheduler queues than requested, or after…

--

octeontx2-af: fix partial NIX Tx scheduler queue allocation

This patch makes nix_txsch_alloc() return an error when it cannot satisfy
a Tx scheduler queue request, and clears the bitmap bits it set for the
failing level. rvu_mbox_handler_nix_txsch_alloc() then returns
NIX_AF_ERR_TLX_ALLOC_FAIL when that happens.

> nix_txsch_alloc() could return success after allocating fewer Tx
> scheduler queues than requested, or after failing to allocate a
> queue under the fixed topology mapping.

[Severity: Low]
Can either of these happen when the requester is well behaved?

nix_txsch_alloc() has one caller, rvu_mbox_handler_nix_txsch_alloc(). That
caller first runs nix_check_txschq_alloc_req() on every level, and it holds
rvu->rsrc_lock across both loops.

For the fixed mapping, the pre-check already does this:

drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:nix_check_txschq_alloc_req() {
    ...
		schq = start + (pcifunc & RVU_PFVF_FUNC_MASK);
		if (end <= txsch->schq.max && schq < end &&
		    !test_bit(schq, txsch->schq.bmap))
			free_cnt = 1;
		else
			free_cnt = 0;
    ...
}

That rejects the same idx >= (end - start) || test_bit() condition that
now returns -ENOMEM.

For the non-fixed mapping, the pre-check uses rvu_rsrc_free_count() and
rvu_rsrc_check_contig(). These do the same bitmap search that the
allocation does. Bits are only set inside nix_txsch_alloc(), so the full
request should always be satisfied.

As far as I can tell, the new failure paths only run if the peer changes
the shared mailbox request between the check and the allocation. Could the
commit message describe that case? And is the Fixes: tag still
appropriate, given that it suggests a user-visible bug for normal callers?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 153eb57bad06..28e70bae51ca 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -2195,12 +2195,14 @@ static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
>  	return 0;
>  }
>  
> -static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
> -			    struct nix_txsch_alloc_rsp *rsp,
> -			    int lvl, int start, int end)
> +static int nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
> +			   struct nix_txsch_alloc_rsp *rsp,
> +			   int lvl, int start, int end)
>  {
> +	int want_contig = rsp->schq_contig[lvl];
>  	struct rvu_hwinfo *hw = rvu->hw;
>  	u16 pcifunc = rsp->hdr.pcifunc;
> +	int want = rsp->schq[lvl];
>  	int idx, schq;

[ ... ]

> @@ -2277,6 +2279,22 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
>  		/* Update how many were allocated */
>  		rsp->schq[lvl] = idx;
>  	}
> +
> +	if ((want_contig && !rsp->schq_contig[lvl]) || (want && !rsp->schq[lvl]))
> +		goto err;

[Severity: High]
Does this catch a short non-contiguous allocation? The check only fires
when rsp->schq[lvl] is zero. If 0 < idx < want after the non-contiguous
loop, nix_txsch_alloc() still returns 0. That is the "fewer Tx scheduler
queues than requested" case the commit message says it fixes.

The caller does not check again. Its reset loops are bounded by the
requested count, not the allocated count:

drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:rvu_mbox_handler_nix_txsch_alloc() {
    ...
		for (idx = 0; idx < req->schq[lvl]; idx++) {
			schq = rsp->schq_list[lvl][idx];
			if (!(TXSCH_MAP_FLAGS(pfvf_map[schq]) &
			    NIX_TXSCHQ_CFG_DONE))
				pfvf_map[schq] = TXSCH_MAP(pcifunc, 0);
			nix_reset_tx_linkcfg(rvu, blkaddr, lvl, schq);
    ...
}

On a short allocation, this loop reads rsp->schq_list[lvl][] slots that
were never filled in. Those are usually zero, but the peer can write them.
The loop then resets linkcfg, shaping and schedule for those queue
indices. If CFG_DONE is not set, it also assigns pfvf_map ownership to
pcifunc. The queue may belong to another PF or VF.

On the PF side, otx2_qos_txschq_alloc() in nic/qos.c copies only
rsp->schq[lvl] queue IDs but keeps cfg->schq[] at the requested counts.
otx2_qos_txschq_fill_cfg_schq() then gives stale IDs to the extra child
nodes.

A short allocation can happen if the requester raises req->schq[lvl] in
the shared mailbox after nix_check_txschq_alloc_req() reads it and before
the handler reads it again here:

		rsp->schq[lvl] = req->schq[lvl];

Should the check require rsp->schq[lvl] == want and
rsp->schq_contig[lvl] == want_contig? Should the reset loops in the
handler use the allocated rsp counts instead of the req counts?

> +
> +	return 0;
> +
> +err:
> +	for (idx = 0; idx < rsp->schq_contig[lvl]; idx++)
> +		clear_bit(rsp->schq_contig_list[lvl][idx], txsch->schq.bmap);
> +
> +	for (idx = 0; idx < rsp->schq[lvl]; idx++)
> +		clear_bit(rsp->schq_list[lvl][idx], txsch->schq.bmap);

[Severity: High]
Is it safe to take both the loop bounds and the clear_bit() indices from
rsp here?

The response message is not a private copy. otx2_mbox_alloc_msg_rsp()
places it at mdev->mbase + tx_start + ... . For the AF's own VFs,
mdev->mbase is the ioremap_wc() BAR4 region shared with the VF, and the
AF processes the message directly in that memory.

Nothing limits rsp->schq[lvl] or rsp->schq_contig[lvl] to
MAX_TXSCHQ_PER_FUNC. Nothing checks the list entries against
txsch->schq.max either.

A peer that rewrites these fields before the rollback runs could cause
two problems:

  - A larger rsp->schq[lvl] makes the loop read past the schq_list row.

  - clear_bit() can run on any u16 index, up to 65535. That writes past
    the end of the kmalloc'd txsch->schq.bmap. It can also clear bits for
    queues owned by other functions, which then get allocated twice.

The peer can also force this err path. nix_check_txschq_alloc_req()
validates req->schq_contig[lvl]. The handler then reads it again into
rsp->schq_contig[lvl], and nix_txsch_alloc() reads it again from rsp. If
the value is raised in between, bitmap_find_next_zero_area() fails and
execution goes to err.

The existing reset loops in the handler already index pfvf_map[schq] with
values from rsp->schq_list. This rollback adds another write target to
that same pattern.

Could the allocated counts and indices be kept in kernel-private storage
for the rollback? Alternatively, they could be checked against
MAX_TXSCHQ_PER_FUNC and txsch->schq.max before use.

> +
> +	rsp->schq_contig[lvl] = 0;
> +	rsp->schq[lvl] = 0;
> +	return -ENOMEM;
>  }
>  
>  int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
> @@ -2335,7 +2353,8 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
>  			end = txsch->schq.max;
>  		}
>  
> -		nix_txsch_alloc(rvu, txsch, rsp, lvl, start, end);
> +		if (nix_txsch_alloc(rvu, txsch, rsp, lvl, start, end))
> +			goto err;

[Severity: Medium]
Does this goto leak the queues already allocated for levels 0..lvl-1?

For those earlier levels, nix_txsch_alloc() has already set their bits in
txsch->schq.bmap. The reset loops have also set pfvf_map[schq] to
TXSCH_MAP(pcifunc, 0) and reset their hardware config. The err label only
does this:

err:
	rc = NIX_AF_ERR_TLX_ALLOC_FAIL;
exit:
	mutex_unlock(&rvu->rsrc_lock);

The requesters treat a non-zero rc as "nothing allocated" and return.
These include otx2_qos_txschq_alloc(), otx2_txsch_alloc() and
otx2_pfc_txschq_alloc_one(). They never learn the queue IDs from the
earlier levels, so they cannot release them with NIX_TXSCH_FREE.

Those queues stay allocated to pcifunc until nix_txschq_free() runs at LF
teardown, and each retry can leak more. Before this patch nothing could
fail after the pre-check, so this error path is new.

The commit message also says the patch will "roll back any partially
allocated queue indices on error", but here only the failing level is
rolled back.

>  
>  		/* Reset queue config */
>  		for (idx = 0; idx < req->schq_contig[lvl]; idx++) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924082128.1944674-1-rkannoth%40marvell.com
