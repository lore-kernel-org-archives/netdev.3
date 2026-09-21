Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE31E1A17;
	Mon, 21 Sep 2026 04:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789965206; cv=none; b=TBDkOHspqIGM8fHD/iIiBPxp0P+w3aBZd39q4WnuKQZECCFWtfMh4YeAQF8Jojy3+JXrMqt4X9tKfJcn37T6sJlsoBVqZVxqv59gM3ZUUPvUVCj307CBlD4f4SpM1wxxP7IeiOmzp1AANR02KkT3SphyDd2V+pvJuBwX6ArAgMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789965206; c=relaxed/simple;
	bh=mfhiPNmx7iVn5NOdbZCTtqIoo4KahBPt/hrRNRA1TlI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A0oytZcXB9X8b0LmwLWBD/ryV/U5hV/ZiNaWh/INl8JwzyyGJmh5/bgZ4WRXcmSYZLMqImZT1ytBeGEYW904Z0BrZHCiFKHC7tYjyi+dSK0xWZPVpYuBvPge9seMhvjgYJtsWYldfQcfv2J/eS2sNAPzIqSofCrwrzI47jhgmgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsOPvlu9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsOPvlu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D93C1F000FF;
	Mon, 21 Sep 2026 04:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789965204;
	bh=WadPeqkEztDeRp8nmdwkLjTvCyk+tTTZmv8u3+fmmGU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bsOPvlu9yFabPb3ahhjLqWktGMDLVhcoOi1cLPit5DTF7oI7qsbT2EqExQ50CbQiX
	 mAApR64SfjGL/3W+ZKrbvMlWJi71/mpEnMsBQZbJnBuIM2EiLujxwqcLq3JVNwtCLq
	 P6eJT9vb+yRXR9orWWOQfyMbs5UmMABIParOI0L9JSKS+cWsbZ+bmdgfCKCWCU4r2L
	 4+hQpOjwBTWevvWEJ6i/Mo/EUfodhU3zLdCp7+oPsMSK0y/dL4+pN21jwkPW9Oa7kD
	 41lJh+YfUG3crGffROPnPehBwBs6hPT6kdHYYYnslhsBHzy9I+yDBVdmiJ+QttBr0T
	 VelpepzGX+58g==
Subject:
 Re: [PATCH net v4] octeontx2-af: Fix rep link state sync and workqueue races
From: netdev-bot+sashiko@kernel.org
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gakula@marvell.com,
 sgoutham@marvell.com, rkannoth@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bbhushan2@marvell.com, horms@kernel.org,
 hkalra@marvell.com
Date: Mon, 21 Sep 2026 04:33:23 +0000
Message-ID: <178996520304.2160803.1095101901851529954@kernel.org>
In-Reply-To: <20260917042057.1627523-1-nshettyj@marvell.com>
References: <20260917042057.1627523-1-nshettyj@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 6 (1) · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Converting `rvu_rep_notify_pfvf_state()` into an asynchronous
  rep_evt_wq item lets a PFVF_STATE notification be delivered to the…
- [High] The `rvu->rswitch` bookkeeping (`used_entries`, `start_entry`,
  `entry2pcifunc`) is mutated by the devlink-driven…
- [Medium] The commit message describes only four changes (move wq init,
  fix UAF/races, add bounds checking, serialize LBK config) and carries…
- [Medium] The patch teaches `rvu_rep_install_mcam_rules()` to recognise
  PF/VFs whose NIXLF is already initialized…
- [Medium] `rvu_rep_notify_pfvf_state()` no longer sends the PF/VF-state
  up-message itself; it funnels the event through…
- [Medium] The representor workqueue allocation was moved out of
  `rvu_rep_install_mcam_rules()` into the `GET_REP_CNT` mailbox handler,…
- [Medium] The new teardown guard in `rvu_rep_wq_handler()` (`if
  (!READ_ONCE(rvu->rep_evt_teardown)) rvu_rep_up_notify(...)`) is a…
- [Medium] All the new access-control checks introduced by this patch
  (-EPERM in `rvu_mbox_handler_get_rep_cnt()`/`rvu_rep_get_rep_map()`…
- [Low] In `rvu_rep_open()`/`rvu_rep_stop()` the patch adds `if
  (rep->pcifunc & RVU_PFVF_FUNC_MASK) return 0;`, so administratively…

Pre-existing issues:
- [Medium] The new `err_disable_lbk` rollback in
  `rvu_rep_install_mcam_rules()` only clears the TL2 LBK link…
- [Low] Producer/consumer disagreement on the rep_event pcifunc selector:
  `rvu_rep_up_notify()` addresses the up-message with `pf =…

--

octeontx2-af: Fix rep link state sync and workqueue races

This moves the representor event workqueue allocation out of
rvu_rep_install_mcam_rules() and into the GET_REP_CNT mailbox handler,
adds ownership/bounds checks to the representor mailbox handlers, and
serializes LBK link configuration under rsrc_lock.  It also converts
rvu_rep_notify_pfvf_state() from an inline up-mailbox send into a
queued representor event.

Fixes: b8fea84a0468 ("octeontx2-pf: Add support to sync link state between representor and VFs")
Link: https://lore.kernel.org/lkml/aqrInFMnvs4K48+3@kernel-ep2/

A few questions below, mostly about the pieces of the diff that are not
described in the changelog and about the lifetime of the queued events.

> octeontx2-af: Fix rep link state sync and workqueue races
>
> Move rep event workqueue init to rvu_mbox_handler_get_rep_cnt(),
> fix use-after-free and race conditions in rep event handling,
> add bounds checking, and serialize LBK link configuration.

[Severity: Medium]
Could this be split, and could the message describe the behaviour changes
it does not currently mention?  The four items listed above do not seem to
cover everything in the diff:

- rvu_rep_notify_pfvf_state() changes from an inline synchronous up-mbox
  send into a queued rep_evt_wq item that can now return -EINVAL, -EPERM
  or -ENOMEM, or be dropped by the worker.  Incidentally, the old code
  did mutex_lock(&rvu->mbox_lock) while rvu_afpf_mbox_handler() already
  holds that same non-recursive mutex around
  __rvu_mbox_handler(mwork, TYPE_AFPF, true), so this conversion also
  quietly removes a self-deadlock on the AF-PF path.  Should that be
  called out as its own fix?

- rvu_rep_up_notify() now sets msg->pcifunc = event->pcifunc and
  re-targets PFVF_STATE at the representor PF.

- rvu_rep_install_mcam_rules() now enables LBK links for every PF/VF that
  already has NIXLF_INITIALIZED set, and rvu_switch_disable() in rep mode
  now walks all PFs/VFs disabling LBK links.

- rvu_switch_enable()'s error path now resets rswitch->entry2pcifunc,
  used_entries and start_entry, which fixes a dangling pointer that came
  from a different commit than b8fea84a0468.

With a single Fixes tag covering all of these, the get_rep_cnt response
overflow, the missing permission checks and the rswitch bookkeeping fix
cannot be backported separately.  Would separate patches with their own
Fixes tags work better here?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 937b085582b5f..4a4e7e434d4b9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -3715,12 +3715,29 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  static void rvu_remove(struct pci_dev *pdev)
>  {
> +	struct workqueue_struct *rep_wq;
>  	struct rvu *rvu = pci_get_drvdata(pdev);
>  
>  	rvu_dbg_exit(rvu);
>  	rvu_unregister_dl(rvu);
> +
> +	/* Block get_rep_cnt() from allocating a new rep_evt_wq. */
> +	mutex_lock(&rvu->rsrc_lock);
> +	WRITE_ONCE(rvu->rep_evt_teardown, true);
> +	rep_wq = rvu->rep_evt_wq;
> +	WRITE_ONCE(rvu->rep_evt_wq, NULL);
> +	mutex_unlock(&rvu->rsrc_lock);
> +
>  	rvu_unregister_interrupts(rvu);
>  	rvu_flr_wq_destroy(rvu);
> +
> +	/* Flush both mbox workqueues before destroying rep_wq. */
> +	flush_workqueue(rvu->afpf_wq_info.mbox_wq);
> +	if (rvu->afvf_wq_info.mbox_wq)
> +		flush_workqueue(rvu->afvf_wq_info.mbox_wq);
> +	if (rep_wq)
> +		destroy_workqueue(rep_wq);
> +
>  	rvu_cgx_exit(rvu);
>  	rvu_fwdata_exit(rvu);
>  	rvu_mcs_exit(rvu);

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> index a2781e0f504e3..705821fbf011b 100644
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

[Severity: Low]
This isn't a bug introduced by this patch, but the producer and consumer
still seem to disagree about the pcifunc selector for the non-PFVF_STATE
events.  For a VF representee, rvu_rep_up_notify() routes with
pf = rvu_get_pf(rvu->pdev, event->pcifunc) and stamps
msg->hdr.pcifunc = event->pcifunc, so the up-message carries VF function
bits.  On the receiving side the parent PF drops it:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:otx2_pfaf_mbox_up_handler() {
	...
	devid = msg->pcifunc & RVU_PFVF_FUNC_MASK;
	/* Skip processing VF's messages */
	if (!devid)
		otx2_process_mbox_msg_up(pf, msg);
	...
}

and the forwarded copy hits the default case of
otx2vf_process_mbox_msg_up(), which answers with otx2_reply_invalid_msg()
and -ENODEV.  Since this patch adds a VF bail-out in rvu_rep_open() and
rvu_rep_stop() but leaves rvu_rep_change_mtu() and
rvu_rep_dl_port_fn_hw_addr_set() emitting MTU/MAC events with a VF
pcifunc, the emit sites are now inconsistent.  Is changing the MTU on a
VF representor netdev expected to be propagated at all?

> +
> +	if (event->event & RVU_EVENT_PFVF_STATE)
> +		msg->hdr.pcifunc = event->hdr.pcifunc;
>  
>  	memcpy(&msg->evt_data, &event->evt_data, sizeof(struct rep_evt_data));
>  
> @@ -87,7 +93,12 @@ static void rvu_rep_wq_handler(struct work_struct *work)
>  
>  		event = &qentry->event;
>  
> -		rvu_rep_up_notify(rvu, event);
> +		/* Once teardown has started the AF-PF mbox interrupt may
> +		 * already be disabled, so sending would just block until
> +		 * otx2_mbox_wait_for_rsp() times out. Drop the event instead.
> +		 */
> +		if (!READ_ONCE(rvu->rep_evt_teardown))
> +			rvu_rep_up_notify(rvu, event);

[Severity: Medium]
Can the worker still hit the stall this comment describes?  The check and
the send are not atomic with respect to rvu_remove():

CPU0 rvu_rep_wq_handler()
	READ_ONCE(rvu->rep_evt_teardown)	/* false */

CPU1 rvu_remove()
	WRITE_ONCE(rvu->rep_evt_teardown, true);
	WRITE_ONCE(rvu->rep_evt_wq, NULL);
	rvu_unregister_interrupts(rvu);		/* AF-PF mbox irq gone */

CPU0 then proceeds into rvu_rep_up_notify(), which does

	otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pf);

with rvu->mbox_lock held, and no response interrupt can be serviced, so
it waits the full MBOX_RSP_TIMEOUT.  The following destroy_workqueue()
then waits on that worker, and rvu_afpf_mbox_handler() needs the same
rvu->mbox_lock.  Would draining rep_evt_wq before
rvu_unregister_interrupts() avoid this?

>  		kfree(qentry);
>  	} while (1);
>  }
> @@ -95,16 +106,28 @@ static void rvu_rep_wq_handler(struct work_struct *work)
>  int rvu_mbox_handler_rep_event_notify(struct rvu *rvu, struct rep_event *req,
>  				      struct msg_rsp *rsp)
>  {
> +	struct workqueue_struct *wq;
>  	struct rep_evtq_ent *qentry;
>  
> -	/* The mailbox dispatcher normalises only the header pcifunc; the
> -	 * nested struct rep_event::pcifunc body field is sender-controlled
> -	 * and is later used by rvu_rep_up_notify() to index rvu->pf[] /
> -	 * rvu->hwvf[].  Reject out-of-range body selectors before queueing.
> -	 */
> +	wq = smp_load_acquire(&rvu->rep_evt_wq);
> +	if (!wq)
> +		return -EINVAL;
> +
> +	/* Only the registered representor PF may send REP_EVENT_NOTIFY. */
> +	if (req->hdr.pcifunc != rvu->rep_pcifunc)
> +		return -EPERM;

[Severity: Medium]
What does this check authenticate?  rvu->rep_pcifunc is set by whichever
PF sends GET_REP_CNT first, and the only identity helper is circular:

drivers/net/ethernet/marvell/octeontx2/af/rvu.h:is_rep_dev() {
	if (rvu->rep_pcifunc && rvu->rep_pcifunc == pcifunc)
		return true;
	...
}

Nothing ties rep_pcifunc to the PCI_DEVID_RVU_REP function, so any PF
that wins the race becomes the representor.  It then learns the whole
PF/VF map, can rewrite pfvf->mac_addr of any CGX-mapped PF/VF through
RVU_EVENT_MAC_ADDR_CHANGE in rvu_rep_up_notify(), inject MTU/port-state
up-messages into other functions' mailboxes, and is treated as the
representor by the from_rep_dev target selection in
rvu_mbox_handler_npc_install_flow().  Meanwhile the real representor
driver's probe fails, because rvu_rep_get_rep_map() returns -EPERM for
it.  Should the AF validate the caller's device id before accepting the
registration?

> +
>  	if (!is_pf_func_valid(rvu, req->pcifunc))
>  		return -EINVAL;
>  
> +	/* Only CGX-mapped PFs are present in the representor map. */
> +	if (!is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, req->pcifunc)))
> +		return -EINVAL;
> +
> +	if ((req->event & RVU_EVENT_PFVF_STATE) &&
> +	    rvu_get_pf(rvu->pdev, req->hdr.pcifunc) >= rvu->hw->total_pfs)
> +		return -EINVAL;
> +
>  	qentry = kmalloc_obj(*qentry, GFP_ATOMIC);
>  	if (!qentry)
>  		return -ENOMEM;
> @@ -113,37 +136,23 @@ int rvu_mbox_handler_rep_event_notify(struct rvu *rvu, struct rep_event *req,
>  	spin_lock(&rvu->rep_evtq_lock);
>  	list_add_tail(&qentry->node, &rvu->rep_evtq_head);
>  	spin_unlock(&rvu->rep_evtq_lock);
> -	queue_work(rvu->rep_evt_wq, &rvu->rep_evt_work);
> +	queue_work(wq, &rvu->rep_evt_work);
>  	return 0;
>  }
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

[Severity: Medium]
Does routing this through the worker make PF/VF state changes wait for a
mailbox response that may never come?  The old code only did
otx2_mbox_wait_for_zero() plus otx2_mbox_msg_send_up() and never waited,
while rvu_rep_up_notify() ends with

	otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pf);

	mutex_unlock(&rvu->mbox_lock);

i.e. up to MBOX_RSP_TIMEOUT with rvu->mbox_lock held, and
rvu_afpf_mbox_handler() takes that same mutex for every AF-PF batch.

rvu->rep_mode and rvu->rep_pcifunc are only cleared by an explicit
ESW_CFG message, so if the representor PF disappears abnormally (FLR,
crash, forced unbind, guest reset of a passed-through PF), every
representee nix_lf_start_rx/stop_rx/teardown still enqueues an event, and
each one is retried for the full timeout.  rvu_rep_wq_handler() only
skips the send when rvu->rep_evt_teardown is set, and that happens
exclusively in rvu_remove().  Should the AF stop treating a gone
representor as registered?

[Severity: High]
Can this asynchronous handoff outlive the representor netdevs?  Delivery
now happens from the rep worker at an unbounded time after the producing
mailbox handler returned, and on the NIC side teardown is reachable at
runtime:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c:otx2_devlink_eswitch_mode_set() {
	case DEVLINK_ESWITCH_MODE_LEGACY:
		rvu_rep_destroy(pfvf);
	...
}

drivers/net/ethernet/marvell/octeontx2/nic/rep.c:rvu_rep_destroy() {
	...
		free_netdev(rep->netdev);
		kfree(rep->flow_cfg);
	}
	kfree(priv->reps);
}

priv->reps is not set to NULL and priv->rep_cnt / priv->rep_pf_map[] stay
intact, and nothing drains rvu->rep_evt_wq at this point:
rvu_mbox_handler_esw_cfg() only clears rvu->rep_mode, and the worker's
new guard tests rvu->rep_evt_teardown, which only rvu_remove() sets.  A
still-queued event therefore reaches rvu_rep_state_evt_handler(), where
rvu_rep_get_repid() still returns a valid index and the handler reads the
freed priv->reps array and writes rep->flags through freed memory.  Is
some flush of the AF representor event queue needed before
rvu_rep_destroy() frees the reps?

>  
>  #define RVU_LF_RX_STATS(reg) \
> @@ -325,6 +334,7 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
>  	u16 start = rswitch->start_entry;
>  	struct rvu_hwinfo *hw = rvu->hw;
>  	u16 pcifunc, entry = 0;
> +	struct rvu_pfvf *pfvf;
>  	int pf, vf, numvfs;
>  	int err, nixlf, i;
>  	u8 rep;
> @@ -334,19 +344,22 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
>  			continue;
>  
>  		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
> +		pfvf = rvu_get_pfvf(rvu, pcifunc);
>  		rvu_get_nix_blkaddr(rvu, pcifunc);
> +		if (test_bit(NIXLF_INITIALIZED, &pfvf->flags))
> +			rvu_switch_enable_lbk_link(rvu, pcifunc, true);

[Severity: Medium]
Should this path also publish RVU_EVENT_PFVF_STATE for the functions it
finds already initialized?  The LBK link is enabled here, but
rvu_rep_notify_pfvf_state() has only three callers
(rvu_mbox_handler_nix_lf_start_rx(), nix_lf_stop_rx() and
rvu_nix_lf_teardown()), all gated on rvu->rep_mode already being set.

So for a PF/VF that was brought up before switchdev mode was enabled, no
state event is ever generated.  rvu_rep_create() allocates rep_dev with
flags == 0, rvu_rep_state_evt_handler() is the only writer of
RVU_REP_VF_INITIALIZED, and rvu_rep_open() starts with

	if (!(rep->flags & RVU_REP_VF_INITIALIZED))
		return 0;

so the representor netdev never gets netif_carrier_on() or
netif_tx_start_all_queues() and its stats stay empty until the
representee interface is bounced.  Does the initial-state half of the
link state sync still work in that ordering?

>  		rep = true;
>  		for (i = 0; i < 2; i++) {
>  			err = rvu_rep_install_rx_rule(rvu, pcifunc,
>  						      start + entry, rep);
>  			if (err)
> -				return err;
> +				goto err_disable_lbk;

[ ... ]

> +err_disable_lbk:
> +	/* Undo any LBK links enabled above before the MCAM rule failure.
> +	 * Disabling a link that was never enabled is a safe no-op.
> +	 */
> +	for (pf = 1; pf < hw->total_pfs; pf++) {
> +		if (!is_pf_cgxmapped(rvu, pf))
> +			continue;
> +		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
> +		rvu_switch_enable_lbk_link(rvu, pcifunc, false);
> +		rvu_get_pf_numvfs(rvu, pf, &numvfs, NULL);
> +		for (vf = 0; vf < numvfs; vf++) {
> +			pcifunc = rvu_make_pcifunc(rvu->pdev, pf, vf + 1);
> +			rvu_switch_enable_lbk_link(rvu, pcifunc, false);
> +		}
>  	}
> -	return 0;
> +	return err;
>  }

[Severity: Medium]
This is a pre-existing issue, but does this rollback also need to release
the TX VTAG entries?  Every rvu_rep_install_tx_rule() that already
succeeded allocated and programmed a NIX TX VTAG definition through
rvu_rep_tx_vlan_cfg() -> nix_tx_vtag_cfg() -> nix_tx_vtag_alloc():

drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:rvu_rep_tx_vlan_cfg() {
	err = rvu_mbox_handler_nix_vtag_cfg(rvu, &req, &rsp);
	...
	*vidx = rsp.vtag0_idx;
}

Those entries are not freed by the new err_disable_lbk loop, not by
npc_delete_flow in rvu_switch_enable()'s uninstall path, and not by the
rep_mode branch of rvu_switch_disable(), which goes straight to
free_ents.  With NIX_TX_VTAG_DEF_MAX at 0x400 and two entries per
representee per enable, repeated eswitch mode toggles (or repeated failed
enables) would eventually return NIX_AF_ERR_TX_VTAG_NOSPC until the
representee NIX LFs are freed.  Would freeing them alongside the LBK
rollback be reasonable?

[ ... ]

> @@ -443,35 +466,111 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,

[ ... ]

> +	/* Only a PF can register as the representor, not a VF. */
> +	if (req->hdr.pcifunc & RVU_PFVF_FUNC_MASK) {
> +		ret = -EPERM;
> +		goto unlock;
> +	}

[ ... ]

> +	/* Initialize the wq for handling REP events */
> +	spin_lock_init(&rvu->rep_evtq_lock);
> +	INIT_LIST_HEAD(&rvu->rep_evtq_head);
> +	INIT_WORK(&rvu->rep_evt_work, rvu_rep_wq_handler);
> +	wq = alloc_workqueue("rep_evt_wq", WQ_UNBOUND, 0);
> +	if (!wq) {
> +		dev_err(rvu->dev, "REP workqueue allocation failed\n");
> +		devm_kfree(rvu->dev, map);
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}

[Severity: Medium]
What happens to this workqueue if rvu_probe() fails after
rvu_register_interrupts() has enabled the AF-PF mailbox interrupts?  A PF
sending GET_REP_CNT in that window allocates and publishes rep_evt_wq
here, but the probe unwind

	err_dl:
		rvu_unregister_dl(rvu);
	err_irq:
		rvu_unregister_interrupts(rvu);
	err_flr:
		rvu_flr_wq_destroy(rvu);
	err_mbox:
		rvu_mbox_destroy(&rvu->afpf_wq_info);
	...
		devm_kfree(dev, rvu);

never drains or destroys it, so the workqueue is leaked.  Worse,
rvu->rep_evt_work, rvu->rep_evtq_head and rvu->rep_evtq_lock all live
inside the rvu structure that devm_kfree() releases, so a REP_EVENT_NOTIFY
queued in the same window would run the worker against freed memory.  The
teardown added by this patch only exists in rvu_remove(), which is not
called for a failed probe.

> +
> +	rvu->rep_cnt = cnt;
> +	rsp->rep_cnt = cnt;
> +	rvu->rep2pfvf_map = map;
> +	rvu->rep_pcifunc = req->hdr.pcifunc;
> +
> +	/* Pairs with smp_load_acquire() in rvu_mbox_handler_rep_event_notify()
> +	 * to publish the above initialization before wq becomes visible.
> +	 */
> +	smp_store_release(&rvu->rep_evt_wq, wq);
> +unlock:
> +	mutex_unlock(&rvu->rsrc_lock);
> +	return ret;
>  }
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
> index 49ce38685a7e6..92719399a953f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
> @@ -203,10 +210,16 @@ void rvu_switch_enable(struct rvu *rvu)
>  	return;
>  
>  uninstall_rules:
> +	if (rvu->rep_mode && rvu->rep_pcifunc)
> +		rvu_switch_enable_lbk_link(rvu, rvu->rep_pcifunc, false);
> +
>  	uninstall_req.start = rswitch->start_entry;
>  	uninstall_req.end =  rswitch->start_entry + rswitch->used_entries - 1;
>  	rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req, &uninstall_rsp);
>  	kfree(rswitch->entry2pcifunc);
> +	rswitch->entry2pcifunc = NULL;
> +	rswitch->used_entries = 0;
> +	rswitch->start_entry = 0;

[Severity: High]
Can this order of stores turn the existing unlocked access into a NULL
dereference?  entry2pcifunc is cleared before used_entries, and the
readers run from the mailbox workqueues with no lock in common with the
devlink path:

drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:rvu_rep_update_rules() {
	u32 max = rswitch->used_entries;
	...
	if (!rswitch->used_entries)
		return;
	...
	for (entry = 0; entry < max; entry++) {
		if (rswitch->entry2pcifunc[entry] == pcifunc)
	...
}

CPU0 rvu_devlink_eswitch_mode_set() -> rvu_switch_enable()
	kfree(rswitch->entry2pcifunc);
	rswitch->entry2pcifunc = NULL;
	rswitch->used_entries = 0;

CPU1 rvu_mbox_handler_nix_lf_start_rx() -> rvu_switch_update_rules()
	-> rvu_rep_update_rules()	/* used_entries still non-zero */
	rswitch->entry2pcifunc[entry]	/* NULL deref */

rswitch->switch_lock is only taken inside
rvu_mbox_handler_npc_install_flow(), not by these readers or writers.
Ordering the stores the other way (as rvu_switch_disable() does) still
leaves a window, so would real serialization of the rswitch bookkeeping
be needed here?

>  free_entries:
>  	free_req.all = 1;
>  	rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> index 0f5d5642d3f7a..ef47e7e219016 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> @@ -459,6 +465,9 @@ static int rvu_rep_open(struct net_device *dev)
>  	netif_carrier_on(dev);
>  	netif_tx_start_all_queues(dev);
>  
> +	if (rep->pcifunc & RVU_PFVF_FUNC_MASK)
> +		return 0;
> +

[Severity: Low]
This bail-out (and the identical one in rvu_rep_stop()) stops VF
representors from emitting RVU_EVENT_PORT_STATE at all.  As far as I can
tell nothing consumed those events before either: the parent PF skips
up-messages whose pcifunc has function bits set in
otx2_pfaf_mbox_up_handler(), and otx2vf_process_mbox_msg_up() only
implements MBOX_MSG_CGX_LINK_EVENT and replies with -ENODEV for
REP_EVENT_UP_NOTIFY.  Is the intent to remove a send that never had a
receiver?  If so, could the changelog say so, since the subject mentions
fixing rep link state sync?

>  	evt.event = RVU_EVENT_PORT_STATE;
>  	evt.evt_data.port_state = 1;
>  	evt.pcifunc = rep->pcifunc;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917042057.1627523-1-nshettyj%40marvell.com
