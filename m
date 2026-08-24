Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AB5377EA7;
	Mon, 24 Aug 2026 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787597746; cv=none; b=aKEd0+MichoZ/HHvpyZZm7QrZX374oGrWGhrlztPg47pV56NLAIvHzrJ+4FMBZLUFrdL3JAOoBn0Tgl+rY6QIV2V1JUgIdbuOqRM7qU+ZEHEKwEZk3qzQ82wsYfloSGireuv8NIgcIXp974d2k/W2358Zpm31qiUcoZRtf9VF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787597746; c=relaxed/simple;
	bh=/N7VuBs/Acdw3nMOvkAxT4HnnRTviqAoTt+kur8b71A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRGjch4iKbEb/lp8ry7MklOpS3yUEiMwhcsgDUNE1ICXa8UGE/0mcq6f8GBizUNumUkRFTWVVUsZsuwgES3Znm9djTJZTTSkDEPCWi4iuR8uPKNL0xGX4qN8z3nkKY3c1cPoQ1ozrqkGADKGGdn5reMwj6m6ijXkho4vMvaq5Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+wFY+7x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+wFY+7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46071F000E9;
	Mon, 24 Aug 2026 18:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787597744;
	bh=RFRjF770zUg7ocx68hTI+0p0FkkHDkPQv1TIsN31kEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E+wFY+7xzzikE3jHEEs3hhvSSWHzZwqewZ0kxdGzCSb8pgJO+n+AMVC8QEQZs4C/2
	 gZZVm817LWooUWcYrbJrrvmMStoalSThnRaJV9fBlAGrckced0Rspw/44UhYogdyJ4
	 rgyvl5IU3fZCf+kuhyJjr2nYbkOVbiQ7BG/piKNL991DoS6UxmgIfOYYgtUM9neHNt
	 8FfQv9b1b6WSwXYHDHRJcvJv45mr0zzXFVEcjY97Exb0o4AeHsO9g8OQmyIFzL5Fma
	 RolgmKYnwv0RluSNZrEhVUbPzorlNjux4fOR//sIWWMJixHM6YUkBpeUjESdIQH+t7
	 94E95ztKt1d4Q==
From: Jakub Kicinski <kuba@kernel.org>
To: nshettyj@marvell.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gakula@marvell.com,
	sgoutham@marvell.com,
	rkannoth@marvell.com,
	sbhatta@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	bbhushan2@marvell.com,
	hkalra@marvell.com,
	horms@kernel.org
Subject: Re: [PATCH net] octeontx2-af: Fix Rep link state sync up with PF/VFs
Date: Mon, 24 Aug 2026 11:55:42 -0700
Message-ID: <20260824185542.2708163-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821052030.2361371-1-nshettyj@marvell.com>
References: <20260821052030.2361371-1-nshettyj@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
octeontx2-af: Fix Rep link state sync up with PF/VFs

This changes the representor link-state notification path so PFVF_STATE
events are addressed to the representee's own PF mailbox, moves the rep
event workqueue initialization from rvu_rep_install_mcam_rules() into
rvu_mbox_handler_get_rep_cnt(), and enables the LBK link for already
initialized NIX LFs while installing rep MCAM rules.

A few questions below.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index ffba56ee8a60c..69983091a5e37 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -3709,6 +3709,10 @@ static void rvu_remove(struct pci_dev *pdev)
>  	rvu_unregister_dl(rvu);
>  	rvu_unregister_interrupts(rvu);
>  	rvu_flr_wq_destroy(rvu);
> +	if (rvu->rep_evt_wq) {
> +		destroy_workqueue(rvu->rep_evt_wq);
> +		rvu->rep_evt_wq = NULL;
> +	}
>  	rvu_cgx_exit(rvu);
>  	rvu_fwdata_exit(rvu);
>  	rvu_mcs_exit(rvu);

[Severity: Medium]
Is a second, independent fix being folded in here without being described?

In the baseline, rep_evt_wq was allocated inside
rvu_rep_install_mcam_rules(), which rvu_switch_enable() calls every time
rep mode is (re)enabled, so each re-enable overwrote and leaked the
previous workqueue, and rvu_remove() never destroyed it at all (only
flr_wq, mcs_intr_wq and cgx_evh_wq were torn down).

This patch adds the destroy_workqueue() above and makes the allocation
one-shot, but the changelog only says "move rep event workqueue init to
rvu_mbox_handler_get_rep_cnt()" and the single Fixes: tag points at the
link-state commit.

Could the leak and the missing module-unload teardown be spelled out, and
should they be a separate patch with their own Fixes: tag so a stable
backport does not have to guess?

[Severity: Medium]
Is this the right position for the destroy?  rep_evt_wq is destroyed and
NULLed here, but the producers of rep events are only stopped later by
rvu_mbox_destroy(&rvu->afpf_wq_info) -> destroy_workqueue(mw->mbox_wq).
rvu_unregister_interrupts() only masks the mbox interrupt and frees IRQs;
it does not flush or cancel mbox work items that are already queued.

In that window an AF mbox worker handling NIX_LF_FREE or NIX_LF_STOP_RX
from a still-loaded PF driver with rvu->rep_mode set reaches:

  rvu_rep_notify_pfvf_state()
    rvu_mbox_handler_rep_event_notify()
      spin_lock(&rvu->rep_evtq_lock);
      list_add_tail(&qentry->node, &rvu->rep_evtq_head);
      spin_unlock(&rvu->rep_evtq_lock);
      queue_work(rvu->rep_evt_wq, &rvu->rep_evt_work);

Can that queue_work() run with rvu->rep_evt_wq already NULL, giving a NULL
dereference in __queue_work(), or hit a workqueue that is concurrently
being destroyed if the load happened just before the NULL store?  Any
rep_evtq_ent linked after drain_workqueue() also never runs and is leaked.
Would moving the destroy after rvu_mbox_destroy() close this?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> index a2781e0f504e3..9daee5de01851 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> @@ -44,6 +44,8 @@ static int rvu_rep_up_notify(struct rvu *rvu, struct rep_event *event)
>  	if (event->event & RVU_EVENT_MAC_ADDR_CHANGE)
>  		ether_addr_copy(pfvf->mac_addr, event->evt_data.mac);
>  
> +	if (event->event & RVU_EVENT_PFVF_STATE)
> +		pf = rvu_get_pf(rvu->pdev, event->hdr.pcifunc);

[Severity: Critical]
Can pf end up out of range here?

Previously pf came from event->pcifunc, and rvu_mbox_handler_rep_event_notify()
bounds-checks that body field with is_pf_func_valid().  event->hdr.pcifunc
is not checked by anything on this path.

MBOX_MSG_REP_EVENT_NOTIFY (0x00f) is in the generic MBOX_MESSAGES table, so
it is dispatched for the AF-VF mailbox as well, and __rvu_mbox_handler()
normalizes only the FUNC bits on that path:

	case TYPE_AFVF:
		msg->pcifunc &= ~(RVU_PFVF_FUNC_MASK << RVU_PFVF_FUNC_SHIFT);
		msg->pcifunc |= (devid << RVU_PFVF_FUNC_SHIFT) + 1;
		break;

so the PF bits of hdr.pcifunc stay exactly as the VF wrote them.
rvu_get_pf() just shifts and masks, so pf can be 0..63 while
rvu->afpf_wq_info.mbox_up.dev[] has only rvu->hw->total_pfs entries.  That
index then flows into otx2_mbox_alloc_msg_rep_event_up_notify(),
otx2_mbox_wait_for_zero(), otx2_mbox_msg_send_up() and
otx2_mbox_wait_for_rsp(), and otx2_mbox_alloc_msg_rsp() does:

	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
	...
	spin_lock(&mdev->mbox_lock);
	...
	msghdr = mdev->mbase + mbox->tx_start + msgs_offset + mdev->msg_size;
	memset(msghdr, 0, size);

with no bounds check on devid.  Does this let a VF drive a spin_lock and a
memset through an out-of-bounds struct otx2_mbox_dev and a wild mbase
pointer in the host AF?  Should hdr.pcifunc be validated with
is_pf_func_valid() (or pf checked against hw->total_pfs) before it is used
as a mailbox index?

>  	mutex_lock(&rvu->mbox_lock);
>  	msg = otx2_mbox_alloc_msg_rep_event_up_notify(rvu, pf);
>  	if (!msg) {
> @@ -53,6 +55,10 @@ static int rvu_rep_up_notify(struct rvu *rvu, struct rep_event *event)
>  
>  	msg->hdr.pcifunc = event->pcifunc;
>  	msg->event = event->event;
> +	msg->pcifunc = event->pcifunc;

[Severity: High]
This isn't a bug introduced by this patch, but the consumer of the
pcifunc carried here does not check the lookup result.

nic/rep.c:rvu_rep_get_repid() returns -EINVAL when the pcifunc is not in
priv->rep_pf_map:

	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++)
		if (priv->rep_pf_map[rep_id] == pcifunc)
			return rep_id;
	return -EINVAL;

and rvu_rep_state_evt_handler() uses it directly as an index:

	rep_id = rvu_rep_get_repid(priv, info->pcifunc);
	rep = priv->reps[rep_id];
	if (info->evt_data.vf_state)
		rep->flags |= RVU_REP_VF_INITIALIZED;

An unmapped pcifunc looks reachable: rvu->rep2pfvf_map (and thus
priv->rep_pf_map) is built once in rvu_mbox_handler_get_rep_cnt() from
rvu_get_pf_numvfs(), so VFs created later on a CGX-mapped PF have no entry,
yet rvu_rep_notify_pfvf_state() still fires for them since its only filter
is is_pf_cgxmapped().  Can that produce a read of priv->reps[-22] followed
by a read-modify-write of whatever pointer is there?  Would a
"if (rep_id < 0) return;" in rvu_rep_state_evt_handler() be appropriate?

> +
> +	if (event->event & RVU_EVENT_PFVF_STATE)
> +		msg->hdr.pcifunc = event->hdr.pcifunc;
>  
>  	memcpy(&msg->evt_data, &event->evt_data, sizeof(struct rep_evt_data));
>  
> @@ -119,31 +125,17 @@ int rvu_mbox_handler_rep_event_notify(struct rvu *rvu, struct rep_event *req,
>  
>  int rvu_rep_notify_pfvf_state(struct rvu *rvu, u16 pcifunc, bool enable)
>  {
> -	struct rep_event *req;
> -	int pf;
> +	struct rep_event req = { 0 };
> +	struct msg_rsp rsp;
>  
>  	if (!is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, pcifunc)))
>  		return 0;
>  
> -	pf = rvu_get_pf(rvu->pdev, rvu->rep_pcifunc);
> -
> -	mutex_lock(&rvu->mbox_lock);
> -	req = otx2_mbox_alloc_msg_rep_event_up_notify(rvu, pf);
> -	if (!req) {
> -		mutex_unlock(&rvu->mbox_lock);
> -		return -ENOMEM;
> -	}
> -
> -	req->hdr.pcifunc = rvu->rep_pcifunc;
> -	req->event |= RVU_EVENT_PFVF_STATE;
> -	req->pcifunc = pcifunc;
> -	req->evt_data.vf_state = enable;
> -
> -	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, pf);
> -	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pf);
> -
> -	mutex_unlock(&rvu->mbox_lock);
> -	return 0;
> +	req.hdr.pcifunc = rvu->rep_pcifunc;
> +	req.event = RVU_EVENT_PFVF_STATE;
> +	req.pcifunc = pcifunc;
> +	req.evt_data.vf_state = enable;
> +	return rvu_mbox_handler_rep_event_notify(rvu, &req, &rsp);
>  }

[Severity: Low]
Could the changelog mention that this converts a synchronous mailbox-up
send into an asynchronous enqueue on rep_evt_wq?

The callers are rvu_mbox_handler_nix_lf_start_rx(),
rvu_mbox_handler_nix_lf_stop_rx() and rvu_nix_lf_teardown().  The consumer
rvu_rep_state_evt_handler() sets and clears RVU_REP_VF_INITIALIZED, which
rvu_rep_open()/rvu_rep_stop() test, so the representor can keep treating the
representee as initialized for an unbounded window after its LF was stopped
or freed.  The return value also changes meaning from "sent" to "queued".

The old code appears to have been worse: it took mutex_lock(&rvu->mbox_lock)
while rvu_afpf_mbox_handler() already holds rvu->mbox_lock around
__rvu_mbox_handler(), i.e. it self-deadlocked on the AFPF
nix_lf_start_rx/stop_rx path.  Since this hunk is really a deadlock fix,
would it help to say so, and to give it its own Fixes: tag?

[Severity: High]
This is a pre-existing issue, but it stays open in the code being
touched here: rvu_mbox_handler_rep_event_notify() ends with

	queue_work(rvu->rep_evt_wq, &rvu->rep_evt_work);

with no check that rep_evt_wq exists.  rep_evt_wq is only allocated from a
representor-specific mailbox handler (rvu_rep_install_mcam_rules() before,
rvu_mbox_handler_get_rep_cnt() now), so on systems where eswitch mode is
never enabled it stays NULL for the AF driver's lifetime, while
MBOX_MSG_REP_EVENT_NOTIFY (0x00f) is in the generic MBOX_MESSAGES table and
can be sent by any PF or AF-VF at any time.

Can any PF or VF trigger an oops in __queue_work() this way?  In the same
scenario rvu->rep_evtq_lock and rvu->rep_evtq_head are also used before
their spin_lock_init()/INIT_LIST_HEAD().

>  
>  #define RVU_LF_RX_STATS(reg) \
> @@ -325,6 +317,7 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
>  	u16 start = rswitch->start_entry;
>  	struct rvu_hwinfo *hw = rvu->hw;
>  	u16 pcifunc, entry = 0;
> +	struct rvu_pfvf *pfvf;
>  	int pf, vf, numvfs;
>  	int err, nixlf, i;
>  	u8 rep;
> @@ -334,7 +327,10 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
>  			continue;
>  
>  		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
> +		pfvf = rvu_get_pfvf(rvu, pcifunc);
>  		rvu_get_nix_blkaddr(rvu, pcifunc);
> +		if (test_bit(NIXLF_INITIALIZED, &pfvf->flags))
> +			rvu_switch_enable_lbk_link(rvu, pcifunc, true);

[Severity: Medium]
What serializes this test_bit() and the register programming that follows?

rvu_switch_enable_lbk_link() -> rvu_nix_tx_tl2_cfg() walks txsch->pfvf_map[]
and writes per-schq config:

	for (schq = 0; schq < txsch->schq.max; schq++) {
		if (TXSCH_MAP_FUNC(txsch->pfvf_map[schq]) != pcifunc)
			continue;
		...
		rvu_write64(rvu, blkaddr,
			    NIX_AF_TL3_TL2X_LINKX_CFG(schq, lbk_link_start + lbk_links),
			    cfg);
	}

NIXLF_INITIALIZED is set in the nix_lf_alloc()/nix_lf_start_rx paths and
cleared in rvu_nix_lf_teardown(), and txsch->pfvf_map[] is mutated by
nix_txsch_alloc()/nix_txschq_free() under rvu->rsrc_lock.  Those run from
per-PF mbox works and from the FLR worker, while this loop runs from the
devlink eswitch-mode path without rvu->rsrc_lock.

Can test_bit() see NIXLF_INITIALIZED set, the PF then free its NIX LF and
have its TL2 schqs reassigned, and rvu_nix_tx_tl2_cfg() program channel-63
LBK config on schqs that no longer belong to that pcifunc?  Should these
calls be made under rvu->rsrc_lock?

[Severity: Medium]
Is there a matching disable for the link bits armed here?

rvu_nix_tx_tl2_cfg() writes cfg = BIT_ULL(12) | RVU_SWITCH_LBK_CHAN into
NIX_AF_TL3_TL2X_LINKX_CFG.  If a later rvu_rep_install_rx_rule() or
rvu_rep_install_tx_rule() in this loop fails, the function returns with all
previously iterated PFs and VFs already armed, and the caller only removes
NPC state:

  rvu_switch_enable()
  uninstall_rules:
	rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req, &uninstall_rsp);
	kfree(rswitch->entry2pcifunc);

On teardown, rvu_switch_disable() does "if (rvu->rep_mode) goto free_ents;",
skipping the per-PF/VF disable loop entirely, and once
rswitch->used_entries is 0, rvu_rep_update_rules() returns immediately, so
it cannot clear them either.  Does that leave the NIX TL2 LBK link enabled
for as long as the representee LF stays up, diverging from the AF's software
view that rep mode is off?

>  		rep = true;
>  		for (i = 0; i < 2; i++) {
>  			err = rvu_rep_install_rx_rule(rvu, pcifunc,
> @@ -354,6 +350,9 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
>  		rvu_get_pf_numvfs(rvu, pf, &numvfs, NULL);
>  		for (vf = 0; vf < numvfs; vf++) {
>  			pcifunc = rvu_make_pcifunc(rvu->pdev, pf, vf + 1);
> +			pfvf = rvu_get_pfvf(rvu, pcifunc);
> +			if (test_bit(NIXLF_INITIALIZED, &pfvf->flags))
> +				rvu_switch_enable_lbk_link(rvu, pcifunc, true);
>  			rvu_get_nix_blkaddr(rvu, pcifunc);
>  
>  			/* Skip installimg rules if nixlf is not attached */

[ ... ]

> @@ -443,12 +432,28 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
>  	return 0;
>  }
>  
> +static int rvu_rep_get_rep_map(struct rvu *rvu, struct msg_req *req,
> +			       struct get_rep_cnt_rsp *rsp)
> +{
> +	int rep;
> +
> +	rvu->rep_pcifunc = req->hdr.pcifunc;

[Severity: High]
This isn't a bug introduced by this patch, but the new function adds a
second place where any mailbox sender can claim the global representor
identity.

GET_REP_CNT (0x00d), ESW_CFG (0x00e) and REP_EVENT_NOTIFY (0x00f) are all in
the generic MBOX_MESSAGES table, so they are processed for the AF-VF mailbox
too.  rvu->rep_pcifunc is assigned straight from req->hdr.pcifunc with no
check that the sender is the legitimate representor PF, and the only
authorization in rvu_mbox_handler_esw_cfg() is:

	if (req->hdr.pcifunc != rvu->rep_pcifunc)
		return 0;

	rvu->rep_mode = req->ena;

so a sender that just claimed rep_pcifunc passes it and can flip global rep
mode.  REP_EVENT_NOTIFY does not require the sender to match rep_pcifunc at
all; it only checks that the separately supplied body pcifunc exists via
is_pf_func_valid(), after which rvu_rep_up_notify() will do
ether_addr_copy(pfvf->mac_addr, event->evt_data.mac) for that other
function and inject a message into its up mailbox.

Should these handlers verify that the sender is a PF and is the registered
representor before touching rvu->rep_pcifunc and per-function state?

> +	rsp->rep_cnt = rvu->rep_cnt;
> +	for (rep = 0; rep < rvu->rep_cnt; rep++)
> +		rsp->rep_pf_map[rep] = rvu->rep2pfvf_map[rep];

[Severity: High]
This is a pre-existing issue, but the new function repeats it: does this
loop overflow rsp->rep_pf_map[]?

struct get_rep_cnt_rsp declares "u16 rep_pf_map[64]", while rep_cnt comes
from "rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs" and cgx_mapped_vfs is
accumulated in rvu_map_cgx_lmac_pf() as "rvu->cgx_mapped_vfs += numvfs;"
with numvfs read from RVU_PRIV_PFX_CFG (8 bits per PF), with no clamp.  With
4 CGX-mapped PFs of 32 VFs each, rep_cnt is 132 and the writes run past the
response object in the mailbox region.

The reader side does the same thing: rvu_get_rep_cnt() copies rsp->rep_cnt
entries into "u16 rep_pf_map[RVU_MAX_REP]" inside struct otx2_nic.  Would a
min(rvu->rep_cnt, ARRAY_SIZE(rsp->rep_pf_map)) on both sides be worth
adding while this code is being reworked?

> +
> +	return 0;
> +}
> +
>  int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
>  				 struct get_rep_cnt_rsp *rsp)
>  {
>  	int pf, vf, numvfs, hwvf, rep = 0;
>  	u16 pcifunc;
>  
> +	if (rvu->rep_cnt)
> +		return rvu_rep_get_rep_map(rvu, req, rsp);
> +
>  	rvu->rep_pcifunc = req->hdr.pcifunc;
>  	rsp->rep_cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
>  	rvu->rep_cnt = rsp->rep_cnt;

[Severity: High]
Is rvu->rep_cnt safe to use as the "already initialized" key when it is
assigned before the two allocations that can fail?

The order in this handler is:

	rvu->rep_cnt = rsp->rep_cnt;
	rvu->rep2pfvf_map = devm_kzalloc(...);
	if (!rvu->rep2pfvf_map)
		return -ENOMEM;
	...
	rvu->rep_evt_wq = alloc_workqueue("rep_evt_wq", 0, 0);
	if (!rvu->rep_evt_wq)
		return -ENOMEM;

and neither error path clears rep_cnt.  Retry is reachable: rvu_rep_probe()
propagates the failure through rvu_get_rep_cnt() to err_detach_rsrc, and a
rebind (or any other sender of the generic GET_REP_CNT message) re-enters
this handler and now takes the new fast path.

If devm_kzalloc() failed, does rvu_rep_get_rep_map() then run
"rsp->rep_pf_map[rep] = rvu->rep2pfvf_map[rep]" on a NULL pointer?

If alloc_workqueue() failed, the retry returns 0, the representor driver
proceeds to ESW_CFG and sets rvu->rep_mode, and every later
rvu_rep_notify_pfvf_state() -> rvu_mbox_handler_rep_event_notify() reaches
queue_work(NULL, &rvu->rep_evt_work) with the qentry already linked onto
rep_evtq_head and leaked.  Before this patch the workqueue was created in
rvu_rep_install_mcam_rules(), whose failure aborted the whole
rvu_switch_enable() setup, so this "rep_cnt set but no workqueue" state did
not exist.  Should rep_cnt (and rep_pcifunc) be reset to 0 on both error
paths?

> @@ -473,5 +478,15 @@ int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
>  			rep++;
>  		}
>  	}
> +
> +	/* Initialize the wq for handling REP events */
> +	spin_lock_init(&rvu->rep_evtq_lock);
> +	INIT_LIST_HEAD(&rvu->rep_evtq_head);
> +	INIT_WORK(&rvu->rep_evt_work, rvu_rep_wq_handler);
> +	rvu->rep_evt_wq = alloc_workqueue("rep_evt_wq", 0, 0);

[Severity: Medium]
Was dropping WQ_PERCPU intentional?  The baseline line was
alloc_workqueue("rep_evt_wq", WQ_PERCPU, 0).  alloc_workqueue_noprof()
requires one of WQ_PERCPU or WQ_UNBOUND:

	if (unlikely(!(flags & (WQ_UNBOUND | WQ_PERCPU)))) {
		WARN_ONCE(1, "workqueue: %s is using neither WQ_PERCPU or WQ_UNBOUND. "
			  "Setting WQ_PERCPU.\n", wq->name);

so every representor bring-up that reaches this handler would now emit a
WARN backtrace (and panic with panic_on_warn).  The other alloc_workqueue()
sites in this driver still pass it, for example rvu_mbox_init() uses
WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_PERCPU.

[Severity: Medium]
Is the "if (rvu->rep_cnt)" test enough to make this block run only once?

GET_REP_CNT is a generic message dispatched for both mailboxes.
rvu_afpf_mbox_handler() serializes AFPF handlers under rvu->mbox_lock, but
rvu_afvf_mbox_handler() calls __rvu_mbox_handler(mwork, TYPE_AFVF, false)
with no lock, and the AF mbox workqueue has max_active == num_pfs.  If a PF
and an AF-VF both observe rep_cnt == 0, can both run this block, so that
spin_lock_init() reinitializes a lock the other CPU may hold,
INIT_LIST_HEAD() discards already-queued rep_evtq_ent entries, INIT_WORK()
reinitializes a possibly queued work item and rep_evt_wq is overwritten,
leaking the first one?

There is also no acquire/release ordering, so a second caller that sees the
non-zero rep_cnt published before rep2pfvf_map is stored can enter
rvu_rep_get_rep_map() and read a NULL or partial map.

Separately, when cgx_mapped_pfs + cgx_mapped_vfs is 0, a successful pass
still leaves rep_cnt == 0 (devm_kzalloc(0) returns ZERO_SIZE_PTR, not NULL),
so does every subsequent GET_REP_CNT re-run this block and allocate another
workqueue over the previous one?

[Severity: Medium]
Which rvu_probe() error path destroys this workqueue?

rvu_register_interrupts() runs before rvu_register_dl() and
rvu_enable_sriov(), so AF mailbox processing, and therefore this handler, is
live before probe completes.  The unwind labels err_dl/err_irq/err_flr/
err_mbox/err_hwsetup call rvu_unregister_dl(), rvu_unregister_interrupts(),
rvu_flr_wq_destroy(), rvu_mbox_destroy() and then devm_kfree(dev, rvu), and
none of them touches rvu->rep_evt_wq.

Does a GET_REP_CNT arriving in that interval followed by a
rvu_register_dl()/rvu_enable_sriov() failure leak the workqueue?  Since
rvu->rep_evt_work is embedded in the rvu object being devm_kfree()d, could a
queued rep event then touch freed memory?

> +	if (!rvu->rep_evt_wq) {
> +		dev_err(rvu->dev, "REP workqueue allocation failed\n");
> +		return -ENOMEM;
> +	}
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> index 0f5d5642d3f7a..3f89a2c04b2b5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> @@ -459,6 +459,9 @@ static int rvu_rep_open(struct net_device *dev)
>  	netif_carrier_on(dev);
>  	netif_tx_start_all_queues(dev);
>  
> +	if (rep->pcifunc & RVU_PFVF_FUNC_MASK)
> +		return 0;
> +

[Severity: Medium]
Could the changelog describe the bug these two guards fix?

"Sync representor link state with PF/VFs" reads as a cosmetic improvement,
but rvu_rep_open()/rvu_rep_stop() set evt.pcifunc = rep->pcifunc and call
rvu_rep_notify_pfvf(), and the AF side picks the target mailbox with
pf = rvu_get_pf(rvu->pdev, event->pcifunc) in rvu_rep_up_notify(), which for
a VF representor is the VF's parent PF.

otx2_mbox_up_handler_rep_event_up_notify() then handles
RVU_EVENT_PORT_STATE by clearing OTX2_FLAG_PORT_UP and calling
netif_tx_stop_all_queues()/netif_carrier_off() on the PF's own netdev.

So did "ip link set <vf-rep> down" previously take down the parent PF's data
path?  Stating that in the changelog would help backporters judge the fix.

>  	evt.event = RVU_EVENT_PORT_STATE;
>  	evt.evt_data.port_state = 1;
>  	evt.pcifunc = rep->pcifunc;

[ ... ]
-- 
pw-bot: cr
