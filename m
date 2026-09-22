Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184FB3BFE2B;
	Tue, 22 Sep 2026 05:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790054179; cv=none; b=LVgEQr6akweWyRJyhmyJTZcDA9z5woAQSgxLCOV+QyEZwNHbVZborKbaSqHPaGpo4Z0bfPc3WHziC7BRu7YLX5uNJfiXywf2pD+aplrC7Ox0RJh7LALHWPFaAtcJ3O7SNRCMWDW0QvUcrvwiel7vw8lSoKensstk6i+zPK1KOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790054179; c=relaxed/simple;
	bh=kErxJUraXcbDJd4nIqqD55mLyijReAwA+wGHVUieWeo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ItpzU2EaJiRv2T3c+DTNMRPBFX2STIFj8B2HFtj0goN2p3IgEGa19/t8AGOrD2c/P1QJyehNLA98b10CD6pRrGhSGxJeqQNChsf0nChPkQcmYmy2uM0Aft9nHG8MYtpHS2j211cy3h5Pwz4oBBM5RPC7dcZYS6GFazW5FwLjZ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adm48BqG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adm48BqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211591F000FF;
	Tue, 22 Sep 2026 05:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790054176;
	bh=d7N0UpwOPrKgx1OHFeJVSbmvR0eenlbvVUVovscGrbo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=adm48BqGhTLLQ/tqz+b8X3sPefSpQ3cyLQ7gMipAeZ9v4ASlk7m43EAVEyZX68V48
	 h9kzHHSqAWPtp7i5om/eoYWyjQYwXdPrTPyZsfRKgvNOnzDe4eYWofs8qvJOucc1Ua
	 ZPWEBy0FS6T8MdOUyqSGDBdeqsrITSiXVeUZ/eVkEvgV32g6KmYt5/PEjFmYbQKt5n
	 /rvsUnhCY8aOvuxsRxzQUvOwgndMPWvD8bCnHBSYZWNWi99G23TvSKCJsWEcvK4nlq
	 /ISrteatJ1aZpKnM7CFQNHLQyewkv10JHGcUgNHHr7XnN9aVoKbAP32+qvM0/iN4pE
	 +Rqcsk5Y1XQhg==
Subject:
 Re: [PATCH net-next] octeontx2-af: Representor devlink id and port mapping
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com
Date: Tue, 22 Sep 2026 05:16:15 +0000
Message-ID: <179005417560.2160803.15313824484958555300@kernel.org>
In-Reply-To: <20260918050021.1359606-1-rkannoth@marvell.com>
References: <20260918050021.1359606-1-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 5 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new cached fast path in rvu_mbox_handler_get_rep_cnt()
  (af/rvu_rep.c:489-495) returns success before the relocated…
- [High] The patch turns MBOX_MSG_GET_REP_CNT from 'last caller wins'
  into 'first caller wins, permanently'.
- [Medium] Commit message omits a functional rewrite of
  rvu_mbox_handler_get_rep_cnt().
- [Medium] Everything the patch adds is dead code with no in-tree
  consumer, yet it permanently changes a shared AF<->PF mailbox wire…
- [Medium] struct esw_cfg_req (MBOX_MSG_ESW_CFG, id 0x00e) is extended by
  switch_id[MAX_PHYS_ITEM_ID_LEN] + switch_id_len (sizeof grows from 32…
- [Medium] The new comment block above struct esw_cfg_req
  (af/mbox.h:1787-1804), duplicated at af/rvu_rep.c:458 and…
- [Medium] The patch introduces a lockless publish/subscribe protocol for
  rvu->rep2pfvf_map / rvu->rep_cnt but omits the release/acquire pairing…
- [Low] rvu_sw_port_id() (af/rvu_rep.c:208-226) duplicates, verbatim, the
  linear rep2pfvf_map[] search implemented immediately above it in…

Pre-existing issues:
- [High] Both response-building loops in rvu_mbox_handler_get_rep_cnt()
  write rsp->rep_pf_map[rep] with no bound against the ABI array size:…
- [Medium] rvu_eswitch_config() (nic/rep.c:400-423) discards the return
  value of otx2_sync_mbox_msg() and unconditionally returns 0, so a…

--

octeontx2-af: Representor devlink id and port mapping

The patch appends a devlink-derived switch id to the MBOX_MSG_ESW_CFG
request and stores it in the AF's rvu_switch state, adds a
rvu_sw_port_id() helper, and reworks rvu_mbox_handler_get_rep_cnt() to
build the representor map once under rvu->rsrc_lock.

A few questions below.

>     octeontx2-af: Representor devlink id and port mapping
>     
>     Extend ESW_CFG with a devlink-derived physical ID and copy it into
>     the AF representor configuration. Add a representor port id helper
>     and export rvu_rep_get_vlan_id().

[Severity: Medium]
Could the changelog also describe what happens to
rvu_mbox_handler_get_rep_cnt()?  Besides the ESW_CFG extension, the patch
changes that handler in ways the message does not mention:

 - it goes from recomputing the map and refreshing rvu->rep_pcifunc on
   every MBOX_MSG_GET_REP_CNT to computing once and serving a cached
   snapshot, with rvu->rep_pcifunc now assigned only on the first call
 - it wraps the handler in rvu->rsrc_lock
 - it introduces a READ_ONCE()/WRITE_ONCE() protocol for
   rep2pfvf_map/rep_cnt
 - it fixes a repeated devm_kzalloc() of rvu->rep2pfvf_map: the old code
   overwrote the pointer with a fresh devm allocation on every
   GET_REP_CNT, and devm memory is only released at AF detach

Should the leak fix be a separate patch with a Fixes: tag, so it can be
backported independently?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index cece197d1074..cafb92b5d57c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -1784,10 +1784,30 @@ struct get_rep_cnt_rsp {
>  	u64 rsvd;
>  };
>  
> +/*
> + * MBOX_MSG_ESW_CFG wire format.
> + *
> + * Transaction shape: the representor driver issues exactly one mailbox
> + * message per sync on this path.  rvu_eswitch_config() in nic/rep.c
> + * allocates only struct esw_cfg_req, then calls otx2_sync_mbox_msg()
> + * without enqueueing any other message IDs.  The AF handles one request
> + * per dispatch for this doorbell.
> + *
> + * Layout extensions are therefore confined to this message: fields cannot
> + * be confused with a batched successor because the representor driver
> + * never batches ESW_CFG with other messages.  otx2_mbox_alloc_msg_rsp()
> + * does advance hdr.next_msgoff cumulatively when multiple messages share
> + * a sync, but that API usage does not occur on the ESW_CFG caller path.
> + *
> + * PF and AF implementations are updated together in-tree; both sides
> + * must agree on the struct size carried by MBOX_MSG_ESW_CFG.
> + */

[Severity: Medium]
Are the three claims in this comment accurate?

"The AF handles one request per dispatch for this doorbell" — the AF side
loops over everything the sender enqueued:

af/rvu.c:__rvu_mbox_handler() {
	for (id = 0; id < mw->mbox_wrk[devid].num_msgs; id++) {
		msg = mdev->mbase + offset;
		...
		offset = mbox->rx_start + msg->next_msgoff;
	}
}

"otx2_mbox_alloc_msg_rsp() ... that API usage does not occur on the
ESW_CFG caller path" — otx2_mbox_alloc_msg_esw_cfg() is generated by the
M() macro in nic/otx2_common.h, whose body is:

	req = (struct _req_type *)otx2_mbox_alloc_msg_rsp(		\
		&mbox->mbox, 0, sizeof(struct _req_type),		\

"the representor driver never batches ESW_CFG with other messages" — the
new -EINVAL path added to rvu_eswitch_config() in this patch returns
after the ESW_CFG message has already been allocated into the mbox but
without sending it, so the next unrelated otx2_sync_mbox_msg() would
flush it together with other messages.

Message boundaries come from next_msgoff, which is derived from
sizeof(struct esw_cfg_req), so batching does not seem to be what makes
the layout change safe or unsafe — sender/receiver agreement on the
struct size is.  Would it be clearer to document that requirement
instead?  The same claim is repeated in af/rvu_rep.c and nic/rep.c.

>  struct esw_cfg_req {
>  	struct mbox_msghdr hdr;
>  	u8 ena;
>  	u64 rsvd;
> +	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
> +	u8 switch_id_len;
>  };

[Severity: Medium]
This changes the layout of a shared-memory AF/PF mailbox message
(sizeof(struct esw_cfg_req) grows from 32 to 72 bytes), but
OTX2_MBOX_VERSION stays at 0x000a.  How is a peer built against the old
32-byte layout detected?

rvu_process_mbox_msg() validates only the signature before casting the
mailbox slot to the now-larger request type:

	if (req->sig != OTX2_MBOX_REQ_SIG)
		goto bad_message;
	...
		err = rvu_mbox_handler_ ## _fn_name(rvu,		\
						    (struct _req_type *)req, \

and otx2_mbox_alloc_msg_rsp() memsets only the sender's own message
size, so with an old sender the bytes the new fields occupy are whatever
was left in the mailbox.  rvu_mbox_handler_esw_cfg() then reads
switch_id_len from those bytes and memcpy()s up to 32 bytes of stale
mailbox content in as the switch identity.  The
"len && len <= MAX_PHYS_ITEM_ID_LEN" guard bounds the destination but
cannot tell garbage-in-range from a real identity.

Two related questions: should the new fields use the existing u64 rsvd
extension placeholder rather than being appended after it, and is it
intended that the wire field width is tied to the kernel-internal
MAX_PHYS_ITEM_ID_LEN, so that changing that define changes the AF/PF
wire layout?

The note in the comment says both sides "must agree on the struct size"
— could that be enforced (hdr.ver check, or a version bump) instead of
asserted?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> index fb4870cd18e9..d1a9be6e4ac1 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -577,6 +578,11 @@ struct rvu_switch {
>  	u16 *entry2pcifunc;
>  	u16 mode;
>  	u16 start_entry;
> +	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
> +	u8 switch_id_len;
> +#define RVU_SWITCH_FLAG_FW_READY BIT_ULL(0)
> +	u64 flags;
> +	u16 pcifunc;
>  };

[Severity: Medium]
Is there a consumer for any of this in the tree?  Grepping
drivers/net/ethernet/marvell/octeontx2/ at this commit:

 - rswitch.switch_id / switch_id_len are written only in
   rvu_mbox_handler_esw_cfg() and read nowhere
 - rswitch.flags, RVU_SWITCH_FLAG_FW_READY and rswitch.pcifunc have no
   reader and no writer at all, and are not mentioned in the changelog
 - rvu_sw_port_id() has no callers, only its definition and the new
   declaration below
 - rvu_rep_get_vlan_id() is un-staticed and prototyped in rvu.h, but all
   its callers remain in af/rvu_rep.c, so the "export" has no effect

The net functional effect of the patch appears to be zero while
struct esw_cfg_req grows by 40 bytes on the wire.  Without a first user
it is hard to judge whether encoding rep_id << 16 | pcifunc into a u32
is the right port-id shape, or whether the AF needs the devlink
switch_id at all — the representor side already publishes the same
DSN-derived id via devlink_port_attrs_set() in
rvu_rep_devlink_port_register().  Could the infrastructure be merged
together with the code that uses it?

> @@ -1199,4 +1205,6 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu);
>  void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena);
>  int rvu_rep_notify_pfvf_state(struct rvu *rvu, u16 pcifunc, bool enable);
>  int npc_mcam_verify_entry(struct npc_mcam *mcam, u16 pcifunc, int entry);
> +u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc);
> +u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc);
>  #endif /* RVU_H */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> index a2781e0f504e..0e2d02b38b60 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c

[ ... ]

> @@ -189,16 +190,41 @@ int rvu_mbox_handler_nix_lf_stats(struct rvu *rvu,
>  	return 0;
>  }
>  
> -static u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
> +u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
>  {
> +	u16 *map = READ_ONCE(rvu->rep2pfvf_map);
> +	u16 cnt = READ_ONCE(rvu->rep_cnt);
>  	int id;
>  
> -	for (id = 0; id < rvu->rep_cnt; id++)
> -		if (rvu->rep2pfvf_map[id] == pcifunc)
> +	if (!map || !cnt)
> +		return 0;
> +
> +	for (id = 0; id < cnt; id++)
> +		if (map[id] == pcifunc)
>  			return id;
>  	return 0;
>  }
>  
> +u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
> +{
> +	u16 rep_id, *map, cnt;
> +
> +	map = READ_ONCE(rvu->rep2pfvf_map);
> +	cnt = READ_ONCE(rvu->rep_cnt);
> +	if (!map || !cnt)
> +		return RVU_SW_INVALID_PORT_ID;
> +
> +	for (rep_id = 0; rep_id < cnt; rep_id++) {
> +		if (map[rep_id] != pcifunc)
> +			continue;
> +
> +		return FIELD_PREP(GENMASK_ULL(31, 16), rep_id) |
> +		       FIELD_PREP(GENMASK_ULL(15, 0), pcifunc);
> +	}
> +
> +	return RVU_SW_INVALID_PORT_ID;
> +}

[Severity: Low]
This isn't a bug, but rvu_sw_port_id() repeats the rep2pfvf_map[] walk
that rvu_rep_get_vlan_id() does immediately above it, with the opposite
failure convention: the new helper returns RVU_SW_INVALID_PORT_ID while
rvu_rep_get_vlan_id() returns 0, which is also a valid rep_id (the first
CGX-mapped PF).  The patch even adds a second path returning that
ambiguous 0 for "map not published yet".

The value is consumed directly as steering state:

af/rvu_rep.c:rvu_rep_install_rx_rule() {
	rep_id = rvu_rep_get_vlan_id(rvu, pcifunc);
	if (rte) {
		vlan_tci = rep_id | BIT_ULL(8);
	...
		req.index = rep_id;
}

Could the two be collapsed into one lookup with a single unambiguous
"not found" indication?

>  static int rvu_rep_tx_vlan_cfg(struct rvu *rvu,  u16 pcifunc,
>  			       u16 vlan_tci, int *vidx)
>  {
> @@ -429,6 +455,7 @@ int rvu_rep_pf_init(struct rvu *rvu)
>  	return 0;
>  }
>  
> +/* MBOX_MSG_ESW_CFG arrives as the sole message in its sync; see esw_cfg_req. */
>  int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
>  			     struct msg_rsp *rsp)
>  {
> @@ -436,6 +463,13 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
>  		return 0;
>  
>  	rvu->rep_mode = req->ena;
> +	memset(rvu->rswitch.switch_id, 0, sizeof(rvu->rswitch.switch_id));
> +	rvu->rswitch.switch_id_len = 0;
> +	if (req->switch_id_len && req->switch_id_len <= MAX_PHYS_ITEM_ID_LEN) {
> +		memcpy(rvu->rswitch.switch_id, req->switch_id,
> +		       req->switch_id_len);
> +		rvu->rswitch.switch_id_len = req->switch_id_len;
> +	}
>  
>  	if (!rvu->rep_mode)
>  		rvu_npc_free_mcam_entries(rvu, req->hdr.pcifunc, -1);
> @@ -447,31 +481,47 @@ int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
>  				 struct get_rep_cnt_rsp *rsp)
>  {
>  	int pf, vf, numvfs, hwvf, rep = 0;
> -	u16 pcifunc;
> +	u16 pcifunc, rep_cnt;
> +	u16 *map;
>  
> -	rvu->rep_pcifunc = req->hdr.pcifunc;
> -	rsp->rep_cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
> -	rvu->rep_cnt = rsp->rep_cnt;
> +	mutex_lock(&rvu->rsrc_lock);
> +
> +	if (rvu->rep2pfvf_map) {
> +		rsp->rep_cnt = rvu->rep_cnt;
> +		for (rep = 0; rep < rvu->rep_cnt; rep++)
> +			rsp->rep_pf_map[rep] = rvu->rep2pfvf_map[rep];
> +		mutex_unlock(&rvu->rsrc_lock);
> +		return 0;
> +	}

[Severity: High]
Can this cached return path leave rvu->rep_pcifunc pointing at the wrong
function permanently?

Before this patch, "rvu->rep_pcifunc = req->hdr.pcifunc;" was the first
statement of the handler and ran on every MBOX_MSG_GET_REP_CNT.  Now it
is at the bottom of the allocating path only, and the cache key is the
global rvu->rep2pfvf_map pointer rather than the requesting pcifunc.
Nothing in the tree frees or resets rep2pfvf_map (devm allocation) or
rep_pcifunc, so once the map exists every later request, including the
real representor driver's probe, returns here.

The downstream users then go quiet rather than failing:

af/rvu_rep.c:rvu_mbox_handler_esw_cfg() {
	if (req->hdr.pcifunc != rvu->rep_pcifunc)
		return 0;

so rep_mode is not set, the new switch_id is not recorded, and
rvu_npc_free_mcam_entries() is not called on disable — all reported as
success.  rvu_rep_pf_init() still sets NIXLF_INITIALIZED and calls
rvu_switch_enable_lbk_link() for the stale pcifunc, and is_rep_dev()
classifies it as the representor device.

On the requester side, rvu_eswitch_config() drops the mailbox result and
returns 0, so the representor driver cannot see that its ESW_CFG was
ignored.

[Severity: High]
This isn't a bug introduced by this patch, but the new copy loop here
repeats an unbounded write into a fixed-size ABI array.  Can this
overflow rsp->rep_pf_map[]?

struct get_rep_cnt_rsp declares:

	u16 rep_cnt;
	u16 rep_pf_map[64];

while rep_cnt comes from rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs,
accumulated per CGX-mapped PF from the provisioned VF count:

af/rvu_cgx.c:rvu_map_cgx_lmac_pf() {
			rvu->cgx_mapped_pfs++;
			rvu_get_pf_numvfs(rvu, pf, &numvfs, &hwvfs);
			rvu->cgx_mapped_vfs += numvfs;
}

numvfs is an 8-bit field of RVU_PRIV_PFX_CFG, so 8 CGX-mapped PFs with
8 VFs each already gives 72 entries.  The response buffer is carved from
the mailbox region at exactly sizeof(struct get_rep_cnt_rsp), so indices
at or above 64 write past it.  The requester mirrors this:

nic/rep.c:rvu_get_rep_cnt() {
	for (rep = 0; rep < priv->rep_cnt; rep++)
		priv->rep_pf_map[rep] = rsp->rep_pf_map[rep];
}

with priv->rep_pf_map[RVU_MAX_REP] (64) inside struct otx2_nic.  Since
this patch is already reworking the handler, would it make sense to
reject rep_cnt > ARRAY_SIZE(rsp->rep_pf_map) here (and validate
rsp->rep_cnt in rvu_get_rep_cnt())?

>  
> -	rvu->rep2pfvf_map = devm_kzalloc(rvu->dev, rvu->rep_cnt *
> -					 sizeof(u16), GFP_KERNEL);
> -	if (!rvu->rep2pfvf_map)
> +	rep_cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
> +	map = devm_kzalloc(rvu->dev, rep_cnt * sizeof(u16), GFP_KERNEL);
> +	if (!map) {
> +		mutex_unlock(&rvu->rsrc_lock);
>  		return -ENOMEM;
> +	}
>  
>  	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
>  		if (!is_pf_cgxmapped(rvu, pf))
>  			continue;
>  		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
> -		rvu->rep2pfvf_map[rep] = pcifunc;
> +		map[rep] = pcifunc;
>  		rsp->rep_pf_map[rep] = pcifunc;
>  		rep++;
>  		rvu_get_pf_numvfs(rvu, pf, &numvfs, &hwvf);
>  		for (vf = 0; vf < numvfs; vf++) {
> -			rvu->rep2pfvf_map[rep] = pcifunc |
> -				((vf + 1) & RVU_PFVF_FUNC_MASK);
> -			rsp->rep_pf_map[rep] = rvu->rep2pfvf_map[rep];
> +			map[rep] = pcifunc | ((vf + 1) & RVU_PFVF_FUNC_MASK);
> +			rsp->rep_pf_map[rep] = map[rep];
>  			rep++;
>  		}
>  	}
> +
> +	rvu->rep_pcifunc = req->hdr.pcifunc;
> +	WRITE_ONCE(rvu->rep2pfvf_map, map);
> +	WRITE_ONCE(rvu->rep_cnt, rep_cnt);
> +	rsp->rep_cnt = rep_cnt;

[Severity: Medium]
Should the publication here use release semantics, and should the two
variables be published in the order the readers consume them?

map[] is filled with plain stores and then the pointer is published with
a plain WRITE_ONCE(), which carries no release ordering, so on a weakly
ordered CPU the pointer store can become visible before the element
stores.  smp_store_release() / rcu_assign_pointer() paired with
smp_load_acquire() / rcu_dereference() would be the usual pairing.

Also, the pointer is stored before rep_cnt, while both new readers load
the pointer first and the count second:

	u16 *map = READ_ONCE(rvu->rep2pfvf_map);
	u16 cnt = READ_ONCE(rvu->rep_cnt);
	...
	if (!map || !cnt)
		return 0;

Can a reader see a non-NULL map together with rep_cnt still 0?
rvu_rep_get_vlan_id() then returns 0, which is a valid rep_id, and that
value is used as the VLAN TCI and MCAM index in
rvu_rep_install_rx_rule() / rvu_rep_install_tx_rule().

The readers take no lock, and the reader path runs in user process
context without rvu->rsrc_lock:

af/rvu_devlink.c:rvu_devlink_eswitch_mode_set() {
		if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV)
			rvu_switch_enable(rvu);
}

so it can overlap the mailbox writer.

[Severity: High]
With rvu->rep_pcifunc now assigned only on this first, map-allocating
invocation, MBOX_MSG_GET_REP_CNT changes from "last caller wins" to
"first caller wins, for the lifetime of the AF driver".  Is that
intended?

The AF dispatcher applies no per-message-ID privilege check, and the PF
forwards guest-VF messages of any ID after checking only the signature:

nic/otx2_pf.c:otx2_pfvf_mbox_handler() {
		if (msg->sig != OTX2_MBOX_REQ_SIG)
			goto inval_msg;

		/* Set VF's number in each of the msg */
		msg->pcifunc &= ~RVU_PFVF_FUNC_MASK;
}

So any PF or guest-owned VF that sends GET_REP_CNT before the rvu_rep
driver probes becomes rvu->rep_pcifunc permanently.  is_rep_dev() then
returns true for it across the AF (NIX LF channel assignment, the MCAM
teardown skip, TXSCH/LBK link selection, and the from_rep_dev
target-pcifunc privilege in rvu_mbox_handler_npc_install_flow()), and it
becomes the only accepted sender of MBOX_MSG_ESW_CFG.

Before this patch the real driver's next GET_REP_CNT reclaimed the role;
now there is no reset path (no free of rep2pfvf_map on rvu_rep unbind or
FLR), so the legitimate representor driver's ESW_CFG returns 0 without
doing anything, forever.  Would keying the cache on the requester, or
re-recording rep_pcifunc on the cached path, be preferable?

>  
> +	mutex_unlock(&rvu->rsrc_lock);
> +
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> index 0f5d5642d3f7..97581d786abd 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> @@ -408,6 +412,12 @@ static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
>  		return -ENOMEM;
>  	}
>  	req->ena = ena;
> +	req->switch_id_len = attrs.switch_id.id_len;
> +	if (req->switch_id_len > MAX_PHYS_ITEM_ID_LEN) {
> +		mutex_unlock(&priv->mbox.lock);
> +		return -EINVAL;
> +	}
> +	memcpy(req->switch_id, attrs.switch_id.id, req->switch_id_len);
>  	otx2_sync_mbox_msg(&priv->mbox);
>  	mutex_unlock(&priv->mbox.lock);
>  	return 0;

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but the
new switch_id transfer inherits it: otx2_sync_mbox_msg()'s return value
is discarded and rvu_eswitch_config() always returns 0, so a mailbox
timeout (-EIO from otx2_mbox_wait_for_rsp()) or an AF error response
reported by otx2_mbox_check_rsp_msgs() looks like success.

rvu_rep_create() and rvu_rep_destroy() also ignore the helper's result,
so representor netdevs can be brought up while the AF never enabled
representor mode (and now never recorded the switch id), and teardown
frees the host-side representors even when the AF-side disable — the
path that calls rvu_npc_free_mcam_entries() in
rvu_mbox_handler_esw_cfg() — never ran, leaving NPC MCAM entries
programmed for destroyed representors.

Should the return value be propagated now that a configuration payload
rides on this message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918050021.1359606-1-rkannoth%40marvell.com
