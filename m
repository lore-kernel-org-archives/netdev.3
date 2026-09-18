Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2576336683B;
	Fri, 18 Sep 2026 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721473; cv=none; b=UhI1ggZYuiFvqtfiXvz70E1719qv5ilvw62nnYBFqhnAHfRHk6zC+JvPAvuqSxO3Y342Re+RyRAHTeMpgZRclQLBhRab/+eCTwhh1/zQY66fbUHlr/JaET2/7TASBHJiQcyVt7YSiuWGEHCqa1UANDZkfycbDVXfJC1X59cpRVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721473; c=relaxed/simple;
	bh=xWOycQC9ar5cWzy6zXMif3238d9w3iMQfJ1bsYTAqSY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nMKthnFt9A8bufMdkqTbhx05mtSY/yboBh9T0RVCN74ns2T0zHjlt6LejDOI0UtVvgYr5UGs7e9AiZTsxxPsd+0jfPzJSRW8PkZWBZGZMgdRYyj/xIRN9gy6TSh+etV0ckTTUULb7lK2FoKrBVgbrfqFd6uLpAJYk9t6x/40z9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuNixOlW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuNixOlW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9961F000FF;
	Fri, 18 Sep 2026 08:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721470;
	bh=wG7expkxBKBJwa5iNtUDo5tj/AloBH9wKyWG5wea2/w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UuNixOlWt5YDxzsOVt6JouEAgBngWfoXKPfYEAOCS2QM79MgPkI4sCD4grndcNGE3
	 LI1iUduxO17kABZzlFvwNMYi4RZGiT4NZNOiSkLLDI981vySo/UgW3byRe/ZFc0/Et
	 CG+TLpZElQHwPpKNeA8x2NDPCTmrBkOpB/XL69zCxwIDFgF2OcOpKBOvKSynPS2+Rb
	 X1tQqDcDz7UEQlm6vvvKJ/4zLLjzjaD3nFrk89krLxpD2oDlgaBdXjLFUxo0sJhDmg
	 u1NOQ7PZvxyr3nF1TmAjkzcx1rg+HBPv3/Ikk2NEEBdk66gcZhg5o4G/Ce2cDdnSZv
	 xKbbUES6h8Ctw==
Subject: Re: [PATCH net-next] octeontx2-af: Add tracepoints for NPC MCAM entry
 programming
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com, sumang@marvell.com
Date: Fri, 18 Sep 2026 08:51:09 +0000
Message-ID: <178972146950.22033.9500232204047707079@kernel.org>
In-Reply-To: <20260915025014.928685-1-rkannoth@marvell.com>
References: <20260915025014.928685-1-rkannoth@marvell.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 5 · Low: 2

- [Medium] New trace event `otx2_npc_mcam_alloc_entries` declares
  `__field(u16, pcifunc)` (rvu_trace.h:167) and prints it in…
- [Medium] The new `trace_otx2_npc_mcam_alloc_entries()` call in
  `npc_mcam_alloc_entries()` unconditionally reads `req->kw_type` and…
- [Medium] The `mcam_index` field of the new events carries two different
  quantities depending on the emitter.
- [Medium] trace: missing traces for rule changes during MCAM entry
  shifts
- [Medium] trace: missing CN20K tracepoints and incompatible trace
  definitions
- [Low] `TP_fast_assign()` of `otx2_npc_mcam_alloc_entries` copies
  `rsp->entry` unconditionally (rvu_trace.h:184) and `TP_printk()`…
- [Low] trace: trailing newlines in TP_printk format strings

--

octeontx2-af: Add tracepoints for NPC MCAM entry programming

This adds four ftrace events to the AF driver (MCAM allocation, CAM
keyword programming, action/VLAN tag writes and entry enable/disable) and
emits them from npc_mcam_alloc_entries(), npc_config_mcam_entry(),
npc_read_mcam_entry() and npc_enable_mcam_entry(). It also renames the
local cam0/cam1 variables to w0_cam0/w0_cam1/w1_cam0/w1_cam1 so both
keywords stay live for the trace call.

A few questions about the values being recorded.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index c34f8d86cc8a5..ae373558975e5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c

[ ... ]

> @@ -259,6 +260,7 @@ void npc_enable_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
>  	int bank = npc_get_bank(mcam, index);
>  	int actbank = bank;
>  
> +	trace_otx2_npc_enable_mcam_entry(index, (u8)enable);
>  	if (is_cn20k(rvu->pdev)) {
>  		if (npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, enable))
>  			dev_err(rvu->dev, "Error to %s mcam %u entry\n",

> @@ -521,10 +523,10 @@ static void npc_config_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
>  				  struct mcam_entry *entry, bool enable)
>  {
>  	int bank = npc_get_bank(mcam, index);
> +	u64 w0_cam0, w0_cam1, w1_cam0, w1_cam1;
>  	int kw = 0, actbank, actindex;
>  	u8 tx_intf_mask = ~intf & 0x3;
>  	u8 tx_intf = intf;
> -	u64 cam0, cam1;
>  
>  	actbank = bank; /* Save bank id, to set action later on */
>  	actindex = index;

> @@ -561,17 +563,18 @@ static void npc_config_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
>  		/* Set the match key */
> -		npc_get_keyword(entry, kw, &cam0, &cam1);
> +		npc_get_keyword(entry, kw, &w0_cam0, &w0_cam1);
>  		rvu_write64(rvu, blkaddr,
> -			    NPC_AF_MCAMEX_BANKX_CAMX_W0(index, bank, 1), cam1);
> +			    NPC_AF_MCAMEX_BANKX_CAMX_W0(index, bank, 1), w0_cam1);
>  		rvu_write64(rvu, blkaddr,
> -			    NPC_AF_MCAMEX_BANKX_CAMX_W0(index, bank, 0), cam0);
> +			    NPC_AF_MCAMEX_BANKX_CAMX_W0(index, bank, 0), w0_cam0);
>  
> -		npc_get_keyword(entry, kw + 1, &cam0, &cam1);
> +		npc_get_keyword(entry, kw + 1, &w1_cam0, &w1_cam1);
>  		rvu_write64(rvu, blkaddr,
> -			    NPC_AF_MCAMEX_BANKX_CAMX_W1(index, bank, 1), cam1);
> +			    NPC_AF_MCAMEX_BANKX_CAMX_W1(index, bank, 1), w1_cam1);
>  		rvu_write64(rvu, blkaddr,
> -			    NPC_AF_MCAMEX_BANKX_CAMX_W1(index, bank, 0), cam0);
> +			    NPC_AF_MCAMEX_BANKX_CAMX_W1(index, bank, 0), w1_cam0);
> +		trace_otx2_npc_cam(index, bank, w0_cam0, w0_cam1, w1_cam0, w1_cam1);
>  	}

[Severity: Medium]
Is the value passed here really an MCAM entry index?  In
npc_config_mcam_entry() index has already been reduced to a bank-relative
register offset before the loop runs:

	actbank = bank; /* Save bank id, to set action later on */
	actindex = index;
	index &= (mcam->banksize - 1);

so trace_otx2_npc_cam() records a bank-local offset under the field name
mcam_index, while trace_otx2_npc_enable_mcam_entry() in
npc_enable_mcam_entry() fires before its own masking and records the
absolute index (and the call at the end of this function passes actindex,
not index).

npc_read_mcam_entry() has the same shape, since src &= (mcam->banksize - 1)
runs before both new traces there.

Can a consumer reconstruct the absolute index from what is logged?  bank
comes from npc_get_bank(), which collapses banks for the X2 keysize:

	/* 0,1 & 2,3 banks are combined for this keysize */
	if (mcam->keysize == NPC_MCAM_KEY_X2)
		return bank ? 2 : 0;

and mcam->banksize is not part of any of the new events.  An entry at
absolute index banksize + N would appear as mcam_index:N in the cam and
action events but as mcam_index:banksize+N in the enable event, and two
different entries sharing a bank-local offset would collide on the same
mcam_index.

Would passing actindex here (and the unmasked src in npc_read_mcam_entry())
make the events line up with each other and with entry2pfvf_map[]?

> @@ -586,6 +589,8 @@ static void npc_config_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
>  	rvu_write64(rvu, blkaddr, NPC_AF_MCAMEX_BANKX_TAG_ACT(index, actbank),
>  		    entry->vtag_action);
>  
> +	trace_otx2_npc_action(index, actbank, tx_intf, (u8)enable,
> +			      entry->action, entry->vtag_action);
>  	/* Enable the entry */
>  	if (enable)
>  		npc_enable_mcam_entry(rvu, mcam, blkaddr, actindex, true);

[ ... ]

> @@ -625,6 +631,8 @@ void npc_read_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
>  			   NPC_AF_MCAMEX_BANKX_CAMX_INTF(src, sbank, 1)) & 3;
>  	*ena = rvu_read64(rvu, blkaddr,
>  			  NPC_AF_MCAMEX_BANKX_CFG(src, sbank)) & 1;
> +	trace_otx2_npc_action(src, sbank, *intf, *ena,
> +			      entry->action, entry->vtag_action);
>  }

[Severity: Medium]
The tx_intf field of otx2_npc_action is fed from two different sources.
The config site passes the TX-masked tx_intf computed inside the bank loop:

			tx_intf_mask = 0x1;
			tx_intf = intf & tx_intf_mask;

while this site passes the raw hardware INTF read back with & 3.  Should the
two emitters agree on what tx_intf means, or should the read side get its
own event?

> @@ -3197,6 +3205,7 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
>  	rsp->free_count = -1;
>  	mutex_unlock(&mcam->lock);
>  
> +	trace_otx2_npc_mcam_alloc_entries(pcifunc, req, rsp);
>  	return 0;
>  
>  not_cn20k:

> @@ -3383,6 +3392,7 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
>  	rsp->free_count = mcam->bmap_fcnt;
>  
>  	mutex_unlock(&mcam->lock);
> +	trace_otx2_npc_mcam_alloc_entries(pcifunc, req, rsp);
>  	return 0;
>  }

[Severity: Medium]
Are req->kw_type and req->virt always initialized when this fires?

Two in-kernel callers build the request on the stack without zeroing it.
rvu_mbox_handler_npc_mcam_alloc_and_write_entry() in rvu_npc.c has:

	struct npc_mcam_alloc_entry_req entry_req;
	...
	entry_req.hdr.pcifunc = req->hdr.pcifunc;
	entry_req.contig = true;
	entry_req.ref_prio = req->ref_prio;
	entry_req.ref_entry = req->ref_entry;
	entry_req.count = 1;

and rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry() in cn20k/npc.c
sets virt but not kw_type.  Both reach npc_mcam_alloc_entries() through
rvu_mbox_handler_npc_mcam_alloc_entry(), so the new
TP_fast_assign() reads of req->kw_type and req->virt would pick up
uninitialized stack bytes and copy them into the ring buffer.  On the legacy
(non-cn20k) path those two fields were not read at all before this patch.

For contrast, rvu_npc_alloc_entry_for_flow_install() in rvu_npc_fs.c does
memset(&entry_req, 0, sizeof(entry_req)) and sets kw_type.  Would zeroing
the two stack requests above be enough here?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
> index 4cd0fc4b0d203..77dc1b4a4c64e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
> @@ -159,6 +159,105 @@ TRACE_EVENT(otx2_parse_dump,
>  		      __entry->w3, __entry->w4, __entry->w5)
>  );
>  
> +TRACE_EVENT(otx2_npc_mcam_alloc_entries,
> +	    TP_PROTO(u16 pcifunc,
> +		     struct npc_mcam_alloc_entry_req *req,
> +		     struct npc_mcam_alloc_entry_rsp *rsp),
> +	    TP_ARGS(pcifunc, req, rsp),
> +	    TP_STRUCT__entry(__field(u16, pcifunc)
> +			     __field(u8, contig)
> +			     __field(u8, ref_prio)
> +			     __field(u16, ref_entry)
> +			     __field(u16, req_count)
> +			     __field(u8, kw_type)
> +			     __field(u8, virt)
> +			     __field(u16, start_mcam_idx)
> +			     __field(u16, rsp_count)
> +			     __field(u16, free_count)
> +	    ),
> +	    TP_fast_assign(__entry->contig = req->contig;
> +			   __entry->ref_prio = req->ref_prio;
> +			   __entry->ref_entry = req->ref_entry;
> +			   __entry->req_count = req->count;
> +			   __entry->kw_type = req->kw_type;
> +			   __entry->virt = req->virt;
> +			   __entry->start_mcam_idx = rsp->entry;
> +			   __entry->rsp_count = rsp->count;
> +			   __entry->free_count = rsp->free_count;
> +	    ),

[Severity: Medium]
Is the assignment of __entry->pcifunc missing here?  The field is declared
in TP_STRUCT__entry() and printed by TP_printk(), but the assign block only
sets the nine fields taken from req and rsp:

	TP_fast_assign(__entry->contig = req->contig;
		       ...
		       __entry->free_count = rsp->free_count;
	),

Trace records are reserved without the payload being zeroed, so the
pcifunc: column would show whatever bytes previously occupied that
ring-buffer offset.  Both emit points in npc_mcam_alloc_entries() pass a
valid pcifunc, so adding __entry->pcifunc = pcifunc; would cover it.

Also, the neighbouring events in this header (otx2_msg_alloc, otx2_msg_send,
otx2_msg_process) print pcifunc with 0x%x while this one uses %d.  Was %d
intended?

[Severity: Low]
Is rsp->entry meaningful for every allocation recorded here?  The mailbox
definition in mbox.h says:

	u16 entry; /* Entry allocated or start index if contiguous.
		    * Invalid incase of non-contiguous.
		    */

In both branches of npc_mcam_alloc_entries() rsp->entry is only assigned
under if (req->contig), so for a non-contiguous request it still holds the
NPC_MCAM_ENTRY_INVALID value set by
rvu_mbox_handler_npc_mcam_alloc_entry(), and the indices actually handed out
live in rsp->entry_list[], which the event never records.  Would logging
entry_list[0], or only recording start_mcam_idx when contig is set, match
the mailbox contract better?

> +	    TP_printk("pcifunc:%d req_contig:%d req_ref_prio:%d req->ref_entry:%d req->req_count:%d req->kw_type:%d req->virt:%d rsp_start_mcam_idx:%d rsp_count:%d rsp_free_count:%d\n",
> +		      __entry->pcifunc, __entry->contig, __entry->ref_prio,
> +		      __entry->ref_entry, __entry->req_count, __entry->kw_type,
> +		      __entry->virt, __entry->start_mcam_idx, __entry->rsp_count,
> +		      __entry->free_count)
> +);

[ ... ]

> @@ -625,6 +631,8 @@ void npc_read_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
>  			   NPC_AF_MCAMEX_BANKX_CAMX_INTF(src, sbank, 1)) & 3;
>  	*ena = rvu_read64(rvu, blkaddr,
>  			  NPC_AF_MCAMEX_BANKX_CFG(src, sbank)) & 1;
> +	trace_otx2_npc_action(src, sbank, *intf, *ena,
> +			      entry->action, entry->vtag_action);
>  }
>  
>  static int npc_copy_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,

[Severity: Medium]
Should the rule-shift path be instrumented too?

npc_copy_mcam_entry() rewrites the INTF/W0/W1 CAM0+CAM1 registers,
ACTION, TAG_ACT and CFG of the destination entry with its own
rvu_read64()/rvu_write64() loop; it does not go through
npc_config_mcam_entry() or npc_enable_mcam_entry(), so none of the four
new events fire for it.  npc_mcam_shift_entry() drives this whenever an
allocation has to move existing rules around, and on cn20k the work is
handed to npc_cn20k_copy_mcam_entry(), which is equally silent.

That leaves a trace consumer with a hole in exactly the case the
changelog is aiming at: it sees otx2_npc_cam/otx2_npc_action for the
entry when it was first programmed, then the hardware contents move to a
different index with no record, and the next event for the old index may
be an unrelated rule.  Correlating mailbox-driven rule changes with MCAM
state then requires guessing where the shift went.

Would you add an event for the copy (src, dest, and the CFG/ACTION
values carried over), or is emitting otx2_npc_cam/otx2_npc_action for
the destination entry from npc_copy_mcam_entry() closer to what you
want?

[ ... ]

> @@ -159,6 +159,105 @@ TRACE_EVENT(otx2_parse_dump,
>  		      __entry->w3, __entry->w4, __entry->w5)
>  );
>  
> +TRACE_EVENT(otx2_npc_mcam_alloc_entries,
> +	    TP_PROTO(u16 pcifunc,
> +		     struct npc_mcam_alloc_entry_req *req,
> +		     struct npc_mcam_alloc_entry_rsp *rsp),
> +	    TP_ARGS(pcifunc, req, rsp),
> +	    TP_STRUCT__entry(__field(u16, pcifunc)
> +			     __field(u8, contig)
> +			     __field(u8, ref_prio)
> +			     __field(u16, ref_entry)
> +			     __field(u16, req_count)
> +			     __field(u8, kw_type)
> +			     __field(u8, virt)
> +			     __field(u16, start_mcam_idx)
> +			     __field(u16, rsp_count)
> +			     __field(u16, free_count)
> +	    ),
> +	    TP_fast_assign(__entry->contig = req->contig;
> +			   __entry->ref_prio = req->ref_prio;
> +			   __entry->ref_entry = req->ref_entry;
> +			   __entry->req_count = req->count;
> +			   __entry->kw_type = req->kw_type;
> +			   __entry->virt = req->virt;
> +			   __entry->start_mcam_idx = rsp->entry;
> +			   __entry->rsp_count = rsp->count;
> +			   __entry->free_count = rsp->free_count;
> +	    ),
> +	    TP_printk("pcifunc:%d req_contig:%d req_ref_prio:%d req->ref_entry:%d req->req_count:%d req->kw_type:%d req->virt:%d rsp_start_mcam_idx:%d rsp_count:%d rsp_free_count:%d\n",
> +		      __entry->pcifunc, __entry->contig, __entry->ref_prio,
> +		      __entry->ref_entry, __entry->req_count, __entry->kw_type,
> +		      __entry->virt, __entry->start_mcam_idx, __entry->rsp_count,
> +		      __entry->free_count)
> +);
> +
> +TRACE_EVENT(otx2_npc_enable_mcam_entry,
> +	    TP_PROTO(u16 index, u8 enable),
> +	    TP_ARGS(index, enable),
> +	    TP_STRUCT__entry(__field(u16, mcam_index)
> +			     __field(u8, ena)
> +	    ),
> +	    TP_fast_assign(__entry->mcam_index = index;
> +			   __entry->ena = enable;
> +	    ),
> +	    TP_printk("mcam_index:%d enable:%d\n", __entry->mcam_index, __entry->ena)

[Severity: Low]
The trailing \n in the format strings is not needed.  The tracing
infrastructure appends one already:

	#define TP_printk(fmt, args...) fmt "\n", args

in include/trace/stages/stage3_trace_output.h, so every record from
otx2_npc_mcam_alloc_entries, otx2_npc_enable_mcam_entry, otx2_npc_cam
and otx2_npc_action gets an extra blank line in the trace output, which
is noise for anyone parsing the log.  Could you drop the \n from all
four TP_printk() strings?

While there: otx2_npc_cam's format has stray commas between the fields
(w0_cam1:0x%llx, w1_cam0:0x%llx,) that the other events do not use.

> +);
> +
> +TRACE_EVENT(otx2_npc_cam,
> +	    TP_PROTO(u16 index, u8 bank,
> +		     u64 w0_cam0,
> +		     u64 w0_cam1,
> +		     u64 w1_cam0,
> +		     u64 w1_cam1),
> +	    TP_ARGS(index, bank,
> +		    w0_cam0, w0_cam1,
> +		    w1_cam0, w1_cam1),
> +	    TP_STRUCT__entry(__field(u16, mcam_index)
> +			     __field(u8, bank)
> +			     __field(u64, w0_cam0)
> +			     __field(u64, w0_cam1)
> +			     __field(u64, w1_cam0)
> +			     __field(u64, w1_cam1)
> +	    ),
> +	    TP_fast_assign(__entry->mcam_index = index;
> +			   __entry->bank = bank;
> +			   __entry->w0_cam0 = w0_cam0;
> +			   __entry->w0_cam1 = w0_cam1;
> +			   __entry->w1_cam0 = w1_cam0;
> +			   __entry->w1_cam1 = w1_cam1;
> +	    ),
> +	    TP_printk("mcam_index:%d bank:%d w0_cam0:0x%llx w0_cam1:0x%llx, w1_cam0:0x%llx, w1_cam1:0x%llx\n",
> +		      __entry->mcam_index, __entry->bank, __entry->w0_cam0, __entry->w0_cam1,
> +		      __entry->w1_cam0, __entry->w1_cam1)
> +);
> +
> +TRACE_EVENT(otx2_npc_action,
> +	    TP_PROTO(u16 index, u8 bank,
> +		     u8 tx_intf, u8 enable,
> +		     u64 act, u64 vtag_act),
> +	    TP_ARGS(index, bank,
> +		    tx_intf, enable,
> +		    act, vtag_act),
> +	    TP_STRUCT__entry(__field(u16, mcam_index)
> +			     __field(u8, bank)
> +			     __field(u8, tx_intf)
> +			     __field(u8, enable)
> +			     __field(u64, act)
> +			     __field(u64, vtag_act)
> +	    ),
> +	    TP_fast_assign(__entry->mcam_index = index;
> +			   __entry->bank = bank;
> +			   __entry->tx_intf = tx_intf;
> +			   __entry->enable = enable;
> +			   __entry->act = act;
> +			   __entry->vtag_act = vtag_act;
> +	    ),
> +	    TP_printk("mcam_index:%d bank:%d tx_intf:%d enable:%d action:0x%llx vtag_action:0x%llx\n",
> +		      __entry->mcam_index, __entry->bank, __entry->tx_intf,
> +		      __entry->enable, __entry->act, __entry->vtag_act)
> +);
> +
>  #endif /* __RVU_TRACE_H */
>  
>  #undef TRACE_INCLUDE_PATH

[Severity: Medium]
What happens to these events on cn20k?

npc_enable_mcam_entry() emits otx2_npc_enable_mcam_entry() before the
is_cn20k(rvu->pdev) branch, so enable/disable is covered on both
generations.  The CAM keyword and action writes are not:
npc_config_mcam_entry() is the legacy path, and cn20k programs its
entries from the separate config path in cn20k/npc.c (the same way
npc_cn20k_enable_mcam_entry() and npc_cn20k_copy_mcam_entry() shadow
their legacy counterparts).  On cn20k parts the only new events a user
sees would be the alloc and the enable/disable ones, i.e. the keyword
and action state the changelog promises is missing for that hardware.

The event shape makes this awkward to fix later, too.  otx2_npc_cam
takes exactly one bank's worth of two keywords (w0_cam0/w0_cam1 and
w1_cam0/w1_cam1) as fixed TP_PROTO arguments, so a path that programs
wider keys in one go cannot reuse it without either splitting the call
artificially per keyword pair or inventing a second event name for the
same concept.

Is cn20k instrumentation planned as a follow-up?  If so, would it be
worth defining otx2_npc_cam now with the CAM words in an __array() (or
__dynamic_array()) plus a word count, so both key layouts land in one
event rather than two divergent ones?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915025014.928685-1-rkannoth%40marvell.com
