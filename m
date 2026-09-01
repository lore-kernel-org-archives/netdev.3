Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58D2F7F19;
	Tue,  1 Sep 2026 23:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788306809; cv=none; b=a0nanBUj8wvRDQOA/4lRsG3AhfRfZ77NzkzMLawgoRaSBZ4tplOOe3GY1Er4zqq3YRiLC5MjS6MEg4yrbpGslWAP537PATTfgpM4SVHZHb8XklCQg/HAJ1xdmAzQdnDBGns0aDAj0boSvFbbHM6TFgGbHf9Nh0ap8Tahs4ZRkoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788306809; c=relaxed/simple;
	bh=3/NMfsDfJ/6UUW5Dcrky0sN1KtqzX6D95QMZRHU7/8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8ySTH80f6WTXqawrhjhmQOla9pXIpVYjFdnMbyYPDA9pn1H8dhmA2itl0TEl83LqZq4WBgygxjequTVxgJe+FCIu5wysM1iFdM7r6MQx78u6yrASSGhXt9glmSOQroR3K0yV4T54bIohmLcDfHSrxEZsAhJBXrHCnsItdJgUHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlCZm/00; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlCZm/00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DE51F000E9;
	Tue,  1 Sep 2026 23:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788306807;
	bh=5VNPP7fWX29cxd19imiJ2HWowHN4W2Hpc1f9FDDo53Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PlCZm/004E+gIswTetX43BBwiswvMCjvXBGnzouy9PVsQarSdrMfHZOKfSO/kl6ea
	 EZNDHGV/sqGTmJ3Bqvvnr2xVmLVivlvi89gRjBQxCJd/t5Ut9/JMdw/x4kGH7O5dey
	 IZnmk3vptL7Id9qXr92jzHEdDKFiorVB5M+3toqOySosSzZ0s2KPSbfWk28MT46t64
	 M9L55WcV3YDTohBj+4gT3L44HRwgfZYKt2QDVK+12WA69Ek3WNLnR4rNI4HQt+R9J5
	 GTXe2qo+g7DP9QraJzAOGyon2UQpdd1KAVWbj2LtANodmbhvJFD4dCaFlFd5+Trfi7
	 vdm47eE6uu/ZQ==
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
Subject: Re: [PATCH net v2] octeontx2-af: Fix Rep link state sync up with PF/VFs
Date: Tue,  1 Sep 2026 16:53:26 -0700
Message-ID: <20260901235326.2232795-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827082430.383813-1-nshettyj@marvell.com>
References: <20260827082430.383813-1-nshettyj@marvell.com>
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

This moves the REP event workqueue creation from
rvu_rep_install_mcam_rules() into rvu_mbox_handler_get_rep_cnt(), routes
RVU_EVENT_PFVF_STATE up-notifies by the sender's pcifunc, and arms the
TL2/LBK link for already-initialized PF/VFs when representor rules are
installed.

A few questions on the changes below.

>     octeontx2-af: Fix Rep link state sync up with PF/VFs
>
>     Sync representor link state with PF/VFs and move rep event workqueue
>     init to rvu_mbox_handler_get_rep_cnt().

[Severity: Medium]
Could the changelog cover the rest of the diff? Besides the link-state
sync and the workqueue move, the patch also:

 - adds destroy_workqueue(rvu->rep_evt_wq) to rvu_remove()
 - adds two new rejection paths to rvu_mbox_handler_rep_event_notify()
   (the !rvu->rep_evt_wq test and the RVU_EVENT_PFVF_STATE header PF
   range check)
 - takes rvu->rsrc_lock inside rvu_switch_enable_lbk_link(), which is
   also used by the non-representor paths rvu_switch_install_tx_rule()
   and rvu_switch_disable()
 - arms the TL2/LBK link for already-initialized PF/VFs in
   rvu_rep_install_mcam_rules()
 - makes GET_REP_CNT cached/idempotent, which also removes a per-call
   devm_kzalloc() leak and changes the response semantics for repeated
   requests
 - stops emitting RVU_EVENT_PORT_STATE for VF representors in
   rvu_rep_open()/rvu_rep_stop()

Several of these are only listed in the v2 notes under the --- line, so
they will not appear in git history. The single Fixes: tag
(b8fea84a0468) seems to cover only the link-state part.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 74c041ab5280a..f484e362cf571 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -3716,6 +3716,10 @@ static void rvu_remove(struct pci_dev *pdev)
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

[Severity: High]
Is this destroy placed early enough in the teardown order to be safe?
rvu_mbox_destroy(&rvu->afpf_wq_info) runs later in rvu_remove(), so the
mailbox workqueues that produce REP events are still alive here.
rvu_unregister_interrupts() only masks and frees the mailbox IRQs, it
does not flush work already queued on mbox_wq.

That leaves a producer running concurrently with the destroy:

rvu_mbox_handler_rep_event_notify()
	if (!rvu->rep_evt_wq)
		return -EINVAL;
	...
	list_add_tail(&qentry->node, &rvu->rep_evtq_head);
	queue_work(rvu->rep_evt_wq, &rvu->rep_evt_work);

The guard is a plain unlocked load and rvu->rep_evt_wq is cleared only
after destroy_workqueue() returns, so can a producer that passed the
test queue_work() on a workqueue that is being or has already been
freed?

Also, nothing drains rep_evtq_head at teardown, so does a qentry linked
after the last worker run simply leak?

And since the workqueue is now created from a mailbox handler, can a
GET_REP_CNT arriving after this block re-allocate rep_evt_wq (plus a new
devm map) on an rvu that rvu_remove() then devm_kfree()s, with nobody
left to destroy that new workqueue?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> index a2781e0f504e3..ef8d30eeeafd9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> @@ -44,6 +44,8 @@ static int rvu_rep_up_notify(struct rvu *rvu, struct rep_event *event)
>  	if (event->event & RVU_EVENT_MAC_ADDR_CHANGE)
>  		ether_addr_copy(pfvf->mac_addr, event->evt_data.mac);
>  
> +	if (event->event & RVU_EVENT_PFVF_STATE)
> +		pf = rvu_get_pf(rvu->pdev, event->hdr.pcifunc);
>  	mutex_lock(&rvu->mbox_lock);
>  	msg = otx2_mbox_alloc_msg_rep_event_up_notify(rvu, pf);
>  	if (!msg) {
> @@ -53,6 +55,10 @@ static int rvu_rep_up_notify(struct rvu *rvu, struct rep_event *event)
>  
>  	msg->hdr.pcifunc = event->pcifunc;
>  	msg->event = event->event;
> +	msg->pcifunc = event->pcifunc;
> +
> +	if (event->event & RVU_EVENT_PFVF_STATE)
> +		msg->hdr.pcifunc = event->hdr.pcifunc;

[Severity: High]
The body pcifunc is now forwarded verbatim to the representor driver.
Does the consumer handle a pcifunc that is not in the representor map?

nic/rep.c:rvu_rep_state_evt_handler() {
	rep_id = rvu_rep_get_repid(priv, info->pcifunc);
	rep = priv->reps[rep_id];
	if (info->evt_data.vf_state)
		rep->flags |= RVU_REP_VF_INITIALIZED;
	...
}

nic/rep.c:rvu_rep_get_repid() {
	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++)
		if (priv->rep_pf_map[rep_id] == pcifunc)
			return rep_id;
	return -EINVAL;
}

There is no rep_id < 0 check, so priv->reps[-22] is read and then
written through. Do the checks added in
rvu_mbox_handler_rep_event_notify() prevent this? is_pf_func_valid()
accepts any real PF/VF (including PF0, LBK/SDP PFs and non-CGX-mapped
PFs) and the new check only bounds rvu_get_pf(req->hdr.pcifunc), so
nothing constrains the body pcifunc to an entry of rep_pf_map[].

The same negative index also seems reachable without a crafted sender
when rep_cnt exceeds 64 (see the rep_pf_map[] question further down):
rvu_rep_get_repid() then scans a truncated map, finds no match and
returns -EINVAL.

> @@ -97,6 +103,9 @@ int rvu_mbox_handler_rep_event_notify(struct rvu *rvu, struct rep_event *req,
>  {
>  	struct rep_evtq_ent *qentry;
>  
> +	if (!rvu->rep_evt_wq)
> +		return -EINVAL;
> +
>  	/* The mailbox dispatcher normalises only the header pcifunc; the
>  	 * nested struct rep_event::pcifunc body field is sender-controlled
>  	 * and is later used by rvu_rep_up_notify() to index rvu->pf[] /
> @@ -105,6 +114,10 @@ int rvu_mbox_handler_rep_event_notify(struct rvu *rvu, struct rep_event *req,
>  	if (!is_pf_func_valid(rvu, req->pcifunc))
>  		return -EINVAL;
>  
> +	if ((req->event & RVU_EVENT_PFVF_STATE) &&
> +	    rvu_get_pf(rvu->pdev, req->hdr.pcifunc) >= rvu->hw->total_pfs)
> +		return -EINVAL;
> +

[Severity: High]
This is a pre-existing gap and not introduced by this patch, but since
new validation is being added right here: should the target pcifunc also
be tied to the sender? is_pf_func_valid() only checks that req->pcifunc
is some valid function in the system, and the new check only bounds
rvu_get_pf(req->hdr.pcifunc) against total_pfs.

REP_EVENT_NOTIFY (0x00f) is in the generic MBOX_MESSAGES table, so any
PF or VF can reach this handler with an arbitrary valid target pcifunc
and attacker-chosen evt_data, and rvu_rep_up_notify() then acts on it:

	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, event->pcifunc);
	...
	if (event->event & RVU_EVENT_MAC_ADDR_CHANGE)
		ether_addr_copy(pfvf->mac_addr, event->evt_data.mac);

Can this overwrite the AF-side MAC of an unrelated function (the value
used for its default ucast MCAM rule), or relay a forged PFVF_STATE for
it? rvu_cn10k.c has the corresponding pattern when honouring a body
pcifunc from an untrusted sender:

	rvu_get_pf(req->hdr.pcifunc) == rvu_get_pf(base_pcifunc)

Would an equivalent ownership check fit here?

>  	qentry = kmalloc_obj(*qentry, GFP_ATOMIC);
>  	if (!qentry)
>  		return -ENOMEM;
> @@ -119,31 +132,17 @@ int rvu_mbox_handler_rep_event_notify(struct rvu *rvu, struct rep_event *req,
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
>  
>  #define RVU_LF_RX_STATS(reg) \
> @@ -325,6 +324,7 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
>  	u16 start = rswitch->start_entry;
>  	struct rvu_hwinfo *hw = rvu->hw;
>  	u16 pcifunc, entry = 0;
> +	struct rvu_pfvf *pfvf;
>  	int pf, vf, numvfs;
>  	int err, nixlf, i;
>  	u8 rep;
> @@ -334,7 +334,10 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
>  			continue;
>  
>  		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
> +		pfvf = rvu_get_pfvf(rvu, pcifunc);
>  		rvu_get_nix_blkaddr(rvu, pcifunc);
> +		if (test_bit(NIXLF_INITIALIZED, &pfvf->flags))
> +			rvu_switch_enable_lbk_link(rvu, pcifunc, true);

[Severity: Medium]
Is there a path that un-arms these links again? This enables
NIX_AF_TL3_TL2X_LINKX_CFG = BIT(12) | RVU_SWITCH_LBK_CHAN for every TL2
schq mapped to the PF and, further down, to each VF.

On the mid-loop error return, rvu_switch_enable()'s uninstall_rules
unwind only deletes MCAM flows and frees entry2pcifunc.

On normal teardown, rvu_switch_disable() takes the rep-mode shortcut:

	if (rvu->rep_mode)
		goto free_ents;

which skips the "Disable LBK link" loop that the legacy path runs, and
then sets rswitch->used_entries = 0, after which rvu_rep_update_rules()
returns immediately on:

	if (!rswitch->used_entries)
		return;

So after rvu_rep_destroy() -> rvu_eswitch_config(priv, false), do those
TL2 nodes stay programmed to transmit on all LBK links with forced
channel 63, and does repeated eswitch enable/disable accumulate that
state?

[Severity: Medium]
Is the (test_bit, configure) pair here safe against a concurrent NIXLF
stop? NIXLF_INITIALIZED is written by
rvu_mbox_handler_nix_lf_start_rx() (set_bit) and
rvu_mbox_handler_nix_lf_stop_rx() (clear_bit), and both then call
rvu_switch_update_rules() -> rvu_rep_update_rules() ->
rvu_switch_enable_lbk_link() with the opposite value.

rvu_rep_install_mcam_rules() runs from rvu_devlink_eswitch_mode_set() ->
rvu_switch_enable() and holds no lock covering this state
(rswitch->switch_lock is taken only inside
rvu_mbox_handler_npc_install_flow()), while the mailbox handlers run on
a workqueue with max_active = num:

install path			stop_rx path
test_bit(NIXLF_INITIALIZED) -> 1
				clear_bit(NIXLF_INITIALIZED)
				rvu_switch_enable_lbk_link(..., false)
rvu_switch_enable_lbk_link(..., true)

Does that leave the LBK link armed for a function whose RX was just
stopped? The rsrc_lock added in rvu_switch_enable_lbk_link() serializes
the register writes but does not make the test-then-configure pair
atomic against the flag update.

>  		rep = true;
>  		for (i = 0; i < 2; i++) {
>  			err = rvu_rep_install_rx_rule(rvu, pcifunc,
> @@ -354,6 +357,9 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
>  		rvu_get_pf_numvfs(rvu, pf, &numvfs, NULL);
>  		for (vf = 0; vf < numvfs; vf++) {
>  			pcifunc = rvu_make_pcifunc(rvu->pdev, pf, vf + 1);
> +			pfvf = rvu_get_pfvf(rvu, pcifunc);
> +			if (test_bit(NIXLF_INITIALIZED, &pfvf->flags))
> +				rvu_switch_enable_lbk_link(rvu, pcifunc, true);
>  			rvu_get_nix_blkaddr(rvu, pcifunc);
>  
>  			/* Skip installimg rules if nixlf is not attached */
> @@ -379,16 +385,6 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
>  			}
>  		}
>  	}
> -
> -	/* Initialize the wq for handling REP events */
> -	spin_lock_init(&rvu->rep_evtq_lock);
> -	INIT_LIST_HEAD(&rvu->rep_evtq_head);
> -	INIT_WORK(&rvu->rep_evt_work, rvu_rep_wq_handler);
> -	rvu->rep_evt_wq = alloc_workqueue("rep_evt_wq", WQ_PERCPU, 0);
> -	if (!rvu->rep_evt_wq) {
> -		dev_err(rvu->dev, "REP workqueue allocation failed\n");
> -		return -ENOMEM;
> -	}
>  	return 0;
>  }
>  
> @@ -443,35 +439,74 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
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
This isn't introduced by this patch, but the new fast path repeats it:
should rvu->rep_pcifunc be settable by any mailbox sender? GET_REP_CNT
is a generic message with no sender check here, while
rvu_mbox_handler_esw_cfg() does compare req->hdr.pcifunc against
rvu->rep_pcifunc before acting.

rvu->rep_pcifunc is the identity behind is_rep_dev():

	if (rvu->rep_pcifunc && rvu->rep_pcifunc == pcifunc)
		return true;

and rvu_mbox_handler_npc_install_flow() uses that to allow an arbitrary
flow target:

	} else if (from_rep_dev && req->vf) {
		/* Representor device installing for a representee */
		target = req->vf;

It is also the NPC action target for representee ingress
(req.vf = rvu->rep_pcifunc in rvu_rep_install_rx_rule()) and the
destination of PF/VF state notifications. Can a PF or VF that sends
GET_REP_CNT take over that identity?

> +	rsp->rep_cnt = rvu->rep_cnt;
> +	for (rep = 0; rep < rvu->rep_cnt; rep++)
> +		rsp->rep_pf_map[rep] = rvu->rep2pfvf_map[rep];

[Severity: High]
This is a pre-existing overflow that the original loop below also has,
but the new cached path copies without a bound too. Can this write past
rsp->rep_pf_map[]?

af/mbox.h:
	struct get_rep_cnt_rsp {
		struct mbox_msghdr hdr;
		u16 rep_cnt;
		u16 rep_pf_map[64];
		u64 rsvd;
	};

rep_cnt comes from rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs, and
rvu_cgx.c accumulates cgx_mapped_vfs as the sum of numvfs
(RVU_PRIV_PFX_CFG bits 12..19, up to 255) over every CGX-mapped PF, so
6 CGX PFs with 16 VFs each already gives 102 entries.

The consumer trusts it as well:

nic/rep.c:rvu_get_rep_cnt() {
	priv->rep_cnt = rsp->rep_cnt;
	for (rep = 0; rep < priv->rep_cnt; rep++)
		priv->rep_pf_map[rep] = rsp->rep_pf_map[rep];
}

with u16 rep_pf_map[RVU_MAX_REP] in struct otx2_nic and RVU_MAX_REP ==
64, so does this run into esw_mode/ipsec/af_xdp_zc_qidx? Should both
sides clamp against 64?

> +
> +	return 0;
> +}
> +
>  int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
>  				 struct get_rep_cnt_rsp *rsp)
>  {
>  	int pf, vf, numvfs, hwvf, rep = 0;
>  	u16 pcifunc;
> +	u16 *map;
> +
> +	if (rvu->rep2pfvf_map)
> +		return rvu_rep_get_rep_map(rvu, req, rsp);
>  
>  	rvu->rep_pcifunc = req->hdr.pcifunc;
>  	rsp->rep_cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
> -	rvu->rep_cnt = rsp->rep_cnt;
>  
> -	rvu->rep2pfvf_map = devm_kzalloc(rvu->dev, rvu->rep_cnt *
> -					 sizeof(u16), GFP_KERNEL);
> -	if (!rvu->rep2pfvf_map)
> +	/* Allocate at least one element so the map pointer is always non-NULL
> +	 * once published, making the above guard unconditionally reliable.
> +	 */
> +	map = devm_kzalloc(rvu->dev, (rsp->rep_cnt ?: 1) * sizeof(u16),
> +			   GFP_KERNEL);
> +	if (!map)
>  		return -ENOMEM;
>  

[ ... ]

> +	if (!rvu->rep_cnt) {
> +		rvu->rep2pfvf_map = map;
> +		return 0;
> +	}
> +
> +	/* Initialize the wq for handling REP events */
> +	spin_lock_init(&rvu->rep_evtq_lock);
> +	INIT_LIST_HEAD(&rvu->rep_evtq_head);
> +	INIT_WORK(&rvu->rep_evt_work, rvu_rep_wq_handler);
> +	rvu->rep_evt_wq = alloc_workqueue("rep_evt_wq", WQ_UNBOUND, 0);
> +	if (!rvu->rep_evt_wq) {
> +		dev_err(rvu->dev, "REP workqueue allocation failed\n");
> +		devm_kfree(rvu->dev, map);
> +		rvu->rep_cnt = 0;
> +		return -ENOMEM;
> +	}
> +
> +	rvu->rep2pfvf_map = map;
>  	return 0;
>  }

[Severity: High]
What serializes this lazy initialization? The check
"if (rvu->rep2pfvf_map)" and the later publication of rep_evt_wq and
rep2pfvf_map are plain loads/stores with no lock.

GET_REP_CNT has no sender-identity check, and while
rvu_afpf_mbox_handler() serializes PF batches under rvu->mbox_lock,
rvu_afvf_mbox_handler() calls __rvu_mbox_handler() with no mbox_lock at
all, and rvu_mbox_init() creates the mailbox workqueue with
max_active = num.

If two senders both see a NULL map:

CPU0				CPU1
if (rvu->rep2pfvf_map)  /* NULL */
				if (rvu->rep2pfvf_map)  /* NULL */
devm_kzalloc()			devm_kzalloc()
alloc_workqueue()		alloc_workqueue()
rvu->rep_evt_wq = ...		rvu->rep_evt_wq = ...

does the first workqueue and devm map get leaked, given that rvu_remove()
destroys only the last rep_evt_wq?

Separately, can the re-run of spin_lock_init(&rvu->rep_evtq_lock),
INIT_LIST_HEAD(&rvu->rep_evtq_head) and INIT_WORK(&rvu->rep_evt_work)
corrupt state that rvu_mbox_handler_rep_event_notify() is already using,
since that path only tests rep_evt_wq for non-NULL before doing
list_add_tail() and queue_work()?

There are also no release/acquire barriers around the publication, so is
a producer that observes a non-NULL rep_evt_wq guaranteed to see the
completed lock/list/work init and a fully populated map?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
> index 49ce38685a7e6..6f1330ae8d900 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
> @@ -15,8 +15,10 @@ void rvu_switch_enable_lbk_link(struct rvu *rvu, u16 pcifunc, bool enable)
>  
>  	nix_hw = get_nix_hw(rvu->hw, pfvf->nix_blkaddr);
>  	/* Enable LBK links with channel 63 for TX MCAM rule */
> +	mutex_lock(&rvu->rsrc_lock);
>  	rvu_nix_tx_tl2_cfg(rvu, pfvf->nix_blkaddr, pcifunc,
>  			   &nix_hw->txsch[NIX_TXSCH_LVL_TL2], enable);
> +	mutex_unlock(&rvu->rsrc_lock);
>  }
>  
>  static int rvu_switch_install_rx_rule(struct rvu *rvu, u16 pcifunc,
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
>  	evt.event = RVU_EVENT_PORT_STATE;
>  	evt.evt_data.port_state = 1;
>  	evt.pcifunc = rep->pcifunc;

[Severity: Medium]
Does the representor side actually follow the representee state after
this patch? rvu_rep_state_evt_handler() only touches the flag:

	rep_id = rvu_rep_get_repid(priv, info->pcifunc);
	rep = priv->reps[rep_id];
	if (info->evt_data.vf_state)
		rep->flags |= RVU_REP_VF_INITIALIZED;
	else
		rep->flags &= ~RVU_REP_VF_INITIALIZED;

Carrier and queue state are changed only in rvu_rep_open()/
rvu_rep_stop(), and rvu_rep_open() returns early before
netif_carrier_on() when the flag is clear:

	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
		return 0;

So does a representor brought up while its representee was down stay
carrier-down until it is closed and reopened, and does a representor
stay carrier-up after its representee stops?

Is the initial state seeded anywhere? rvu_rep_create() allocates
rep_dev objects with flags == 0, and the new branch in
rvu_rep_install_mcam_rules() that detects already-initialized PF/VFs

	if (test_bit(NIXLF_INITIALIZED, &pfvf->flags))
		rvu_switch_enable_lbk_link(rvu, pcifunc, true);

only arms the LBK link without emitting a matching
RVU_EVENT_PFVF_STATE, so do representors of functions that were already
up when rep mode was enabled ever learn about it?
-- 
pw-bot: cr
