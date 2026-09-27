Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D31D195B1A;
	Sun, 27 Sep 2026 04:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790484380; cv=none; b=R642lqO95hg3zPH34Jc9WegfqKKMokcgny6/xF3JA9AgxwtF2FJPAjqNiBHHhSvfttUQh7mVzMmyroe8ty/D6ostg1nKyZh7012QdAY8AgiJYgXV9dE6xO2LNwIIHMhSGG2M3DNZLAyfovNdeO8uR1mKOfVukBLs/+orTdDMjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790484380; c=relaxed/simple;
	bh=HuMrWG010LH6weZEuJign7rHyJ6jfgcrIyx9DzKbLgc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nvXktStlQPm85P2hwoFoPOi/leOk1TlFLFwtm2xeB6t4WqSQDFnJfdFFnEGyPH2HPQKkpXmk//O9xL5SNHo6Kof/83vGLwrMhXGBWm+G9uLHgrwSox6uZ9/AoUE5L9sU9YSajDiSl3orMki7tETCCkWILcMgf5U1O2my+OQBQuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq8pzCJ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq8pzCJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013AB1F000FF;
	Sun, 27 Sep 2026 04:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790484378;
	bh=uH6TWvsGqmkBlRUesjBNUW1cWqlY4EwvCspgLp7JLvw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xq8pzCJ6fQhJBlQFwZtOPcAxd6FY4mDljatBCFNad//QGrJa1JTmMPj+pO3USZXHO
	 a0mVYDA6LAjZ/t2HDqrp3+fgAwoCcYmPSQVvNiyTOw/Fhsw2RTXBfOsP8K8ubEaMH4
	 1BwLezYRD8QHhekOVGo51KLGd/WNbzH3UZxeumLm7i4NnC3aEcvtoiQaRXhDpXng30
	 KUFjl8L2IZ6BilzJ0ntaL60JqbOxWQPIZVkIQrrFsqj/UIIVj02dmqt7UO7rV2gxP8
	 a7rsvuGggm3w4ttgU43UDuOa5y3D6UY24l9tHgf9uL1JKY3s3lnzqPBmFkXNXHBXZR
	 60uKZPaxjuBhQ==
Subject: Re: [PATCH v2 net-next] octeontx2-af: add tracepoints for NPC MCAM
 entry programming
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, sumang@marvell.com
Date: Sun, 27 Sep 2026 04:46:17 +0000
Message-ID: <179048437748.2160803.288999340916708222@kernel.org>
In-Reply-To: <20260923034858.1764461-1-rkannoth@marvell.com>
References: <20260923034858.1764461-1-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry()
  (drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c), the patch…
- [Medium] The commit message says the events are emitted from 'the
  legacy and CN20K NPC alloc, config, read, and shift paths'.
- [Low] The otx2_npc_cam event (rvu_trace.h) defines and prints its
  payload as w0_cam0/w0_cam1/w1_cam0/w1_cam1 and has no word-offset…
- [Low] In the submitted patch, the 'v1 -> v2' changelog begins with a
  '---' separator, and both Signed-off-by tags (Suman Ghosh, Ratheesh…
- [Low] On CN20K, npc_cn20k_ref_idx_alloc() replaces the physical indices
  in the returned mcam_idx list with virtual indices ('Return vidx to…

--

octeontx2-af: add tracepoints for NPC MCAM entry programming

This commit adds five ftrace events to the octeontx2 AF driver:
otx2_npc_mcam_alloc_entries, otx2_npc_mcam_copy,
otx2_npc_enable_mcam_entry, otx2_npc_cam and otx2_npc_action. They are
emitted from the legacy and CN20K NPC MCAM alloc, config, read, enable
and copy paths. The commit also zero-initializes the
npc_mcam_alloc_entry_req used by the two alloc-and-write mailbox handlers.

> Add ftrace events for MCAM allocation, CAM keyword writes, action/tag
> programming, enable/disable, and entry copies. Emit them from the legacy
> and CN20K NPC alloc, config, read, and shift paths so mailbox-driven
> rule changes can be correlated with the programmed MCAM state.

[Severity: Medium]
Is the CN20K coverage described here complete?

The copy and enable events are emitted only from the generic wrappers
npc_copy_mcam_entry() and npc_enable_mcam_entry() in rvu_npc.c. The
cam/action read events come only from the legacy npc_read_mcam_entry().
Several CN20K paths call the raw helpers directly.

npc_defrag_move_vdx_to_free() in cn20k/npc.c:

    if (npc_cn20k_enable_mcam_entry(rvu, blkaddr, old_midx, false)) {
    ...
    if (npc_cn20k_copy_mcam_entry(rvu, blkaddr, old_midx, new_midx)) {
    ...
    if (npc_cn20k_enable_mcam_entry(rvu, blkaddr, new_midx, true)) {

A defrag move therefore leaves no otx2_npc_mcam_copy or
otx2_npc_enable_mcam_entry record. The trace still shows the rule at
old_midx, but the hardware now holds it at new_midx.

npc_cn20k_config_mcam_entry() does its disable-before-update and its
final enable through npc_cn20k_enable_mcam_entry(). So it emits no
enable/disable events, unlike the legacy npc_config_mcam_entry().

npc_cn20k_dft_rules_free() disables default entries through
npc_cn20k_enable_mcam_entry() without a trace.

npc_cn20k_read_mcam_entry() is not instrumented at all. Its callers are
rvu_mbox_handler_npc_cn20k_mcam_read_entry(),
rvu_mbox_handler_npc_cn20k_read_base_steer_rule() and
npc_update_dmac_value().

The v2 changelog also says otx2_npc_mcam_copy was added "to cover MCAM
entry shifts". Should these CN20K paths be traced too, or should the
commit message be narrowed?

[Severity: Low]
This isn't a bug, but the applied commit has no Signed-off-by tags.

In the submitted patch, the "v1 -> v2" changelog begins with a "---"
separator. Both Signed-off-by lines (Suman Ghosh, Ratheesh Kannoth) come
after it, so git am drops them along with the changelog.

Could the Signed-off-by lines go above the first "---", with the version
changelog after it?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 7c829b1da3e52..0b485728f3990 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> @@ -1018,43 +1021,46 @@ static void npc_cn20k_config_kw_x2(struct rvu *rvu, struct npc_mcam *mcam,

[ ... ]

> -	npc_cn20k_get_keyword(entry, kw + 3, &cam0, &cam1);
> +	npc_cn20k_get_keyword(entry, kw + 3, &w3_cam0, &w3_cam1);
>  	rvu_write64(rvu, blkaddr,
>  		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W3_EXT(index, bank, 1),
> -		    cam1);
> +		    w3_cam1);
>  	rvu_write64(rvu, blkaddr,
>  		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W3_EXT(index, bank, 0),
> -		    cam0);
> +		    w3_cam0);
> +
> +	trace_otx2_npc_cam(actindex, bank, w0_cam0, w0_cam1, w1_cam0, w1_cam1);
> +	trace_otx2_npc_cam(actindex, bank, w2_cam0, w2_cam1, w3_cam0, w3_cam1);

[Severity: Low]
The otx2_npc_cam event labels its payload as w0_cam0/w0_cam1/w1_cam0/
w1_cam1 and has no word-offset field. Won't the second call here print
the W2/W3 CAM values under the "w0_cam0 ... w1_cam1" labels, with the
same mcam_index and bank as the first record?

For X4 entries, npc_cn20k_config_kw_x4() emits four of these records per
entry. The only way to tell the W0/W1 records from the W2/W3 records is
emission order.

Would a word index field, or a separate event for W2/W3, make these
records unambiguous?

[ ... ]

> @@ -1434,7 +1445,7 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
>  {
>  	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, req->hdr.pcifunc);
>  	struct npc_mcam_free_entry_req free_req = { 0 };
> -	struct npc_mcam_alloc_entry_req entry_req;
> +	struct npc_mcam_alloc_entry_req entry_req = { 0 };

[Severity: High]
With entry_req now zeroed, can NPC_CN20K_MCAM_ALLOC_AND_WRITE_ENTRY ever
succeed on CN20K?

The handler sets hdr.pcifunc, contig, ref_prio, ref_entry, count and
virt, but never entry_req.kw_type. So kw_type is always 0, which is
NPC_MCAM_KEY_X1 / NPC_MCAM_KEY_DYN.

rvu_mbox_handler_npc_mcam_alloc_entry() passes req through unchanged,
and npc_mcam_alloc_entries() rejects it on CN20K:

rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry()
  rvu_mbox_handler_npc_mcam_alloc_entry()
    npc_mcam_alloc_entries()
	/* Only x2 or x4 key types are accepted */
	if (req->kw_type != NPC_MCAM_KEY_X2 && req->kw_type != NPC_MCAM_KEY_X4)
		return NPC_MCAM_INVALID_REQ;

Before this patch, kw_type was uninitialized stack, so the outcome
depended on whatever happened to be there. Now every request fails with
NPC_MCAM_INVALID_REQ before any entry is allocated or programmed.

The missing kw_type assignment is older than this patch. However, the
v2 change to zero the struct is what makes the failure deterministic.

Should entry_req.kw_type be set here instead, for example from
req->req_kw_type or from the profile key type?

The legacy rvu_mbox_handler_npc_mcam_alloc_and_write_entry() in
rvu_npc.c got the same "= { 0 }" change and also never sets kw_type. It
would fail the same way if reached on CN20K silicon.

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
> index 4cd0fc4b0d203..ea1c5d7f10076 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
> @@ -159,6 +159,120 @@ TRACE_EVENT(otx2_parse_dump,
>  		      __entry->w3, __entry->w4, __entry->w5)
>  );
>  
> +TRACE_EVENT(otx2_npc_mcam_alloc_entries,

[ ... ]

> +	    TP_fast_assign(__entry->pcifunc = pcifunc;
> +			   __entry->contig = req->contig;
> +			   __entry->ref_prio = req->ref_prio;
> +			   __entry->ref_entry = req->ref_entry;
> +			   __entry->req_count = req->count;
> +			   __entry->kw_type = req->kw_type;
> +			   __entry->virt = req->virt;
> +			   __entry->start_mcam_idx = req->contig ? rsp->entry :
> +				(rsp->count ? rsp->entry_list[0] :
> +				 NPC_MCAM_ENTRY_INVALID);

[Severity: Low]
On CN20K, can rsp->entry_list[0] be a virtual index here rather than a
physical MCAM index?

npc_cn20k_ref_idx_alloc() returns vidx values when defrag_candidate
(!ref_valid && !contig && virt) is true:

	/* Return vidx to caller */
	mcam_idx[i] = vidx;

npc_mcam_alloc_entries() converts these with npc_cn20k_vidx2idx() for
its own bookkeeping, but it passes the unconverted rsp to
trace_otx2_npc_mcam_alloc_entries(). In that case rsp_start_mcam_idx
holds a vidx.

Meanwhile otx2_npc_cam, otx2_npc_action, otx2_npc_mcam_copy and
otx2_npc_enable_mcam_entry all record physical indices. No event records
the vidx to physical mapping.

Could the event record the physical index, or both, so the alloc record
can be matched to the later programming records?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923034858.1764461-1-rkannoth%40marvell.com
