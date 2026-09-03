Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68246372ECD;
	Thu,  3 Sep 2026 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463513; cv=none; b=I1lNo//epKOAUAoSkIUj7xN/g9h8jbxGRsEVPo6MvNgA2Z+8A72jx6XXAkMbpBY5o3dDl+t4fGIl+CqAvc5dchxo3iWNYmZDsFNSN1JW2w8ZFZk6/sTDIoI8JF0BVt329VmA6V9z+yHyev4a87dvLluRBkFqhnXXWpnBG89pcH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463513; c=relaxed/simple;
	bh=o/FDy8iQcSQo7zEq/xJWJ67YmjfJHYE4910XzMYngPU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vEuAyKl+NiwD3D0RSECmWRS14jeBcA35tVAYSpEhffy1CX+DjVGrkU64lagcUbTAeCWhLfUQum3zm37scCRMkCUpWM4fDeK4r7GY4R2cOcEZ5mMI6rWvtZWYFXPG1hOApGW+ySvuewq2R8cdqDoOLkrEfRkaaNoZ/ewIYdRvXoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neg+rOwV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neg+rOwV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A14E1F00ACF;
	Thu,  3 Sep 2026 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788463491;
	bh=cyF/E/QSXTUrhfl5aco5srhl0/KIB+6BYrE8J2CyRlE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=neg+rOwVpXyntwi6iYaoVeqBVzpUFER33FhmG+uy75cAeNHN6AB3EDDnCFnhs34JD
	 80d1PIYSIkN4/8dtpKXc4EeHt4PE7eRh+Q4MGlZDZtYabeUsmnQ5IxQlY1mlo+lpd1
	 MaUQzWitlYhmdzGj6rZVWABWyTcTSM1lMXsRtlmrVT0Ry5OgpWPUxRgPAWDWUatjR5
	 jsTYgbS6FxXZ1X2lJXczQeoxFE+kwQeUeDiEsEGBGvkXRek4MU3CqeloamSiyHPoOO
	 co4M/rd4kNP0+TsKZTEmqLRTmRPdWChnIY0qdNPG25iSbxl1vF7EoO64c8EUmxKsqC
	 wl+xqWbGprgZQ==
Subject: Re: [v9,net-next,7/8] octeontx2: switch: plumb bridge FDB updates
 through AF and switchdev
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com
Date: Thu, 03 Sep 2026 19:24:50 +0000
Message-ID: <178846349021.3394541.5852418349978761361@kernel.org>
In-Reply-To: <20260831131944.2649362-8-rkannoth@marvell.com>
References: <20260831131944.2649362-8-rkannoth@marvell.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 19 potential
issue(s) to consider:

Critical: 3 · High: 6 · Medium: 9 · Low: 1

- [Critical] Type confusion: `sw_nb_fdb_event()` forwards every non-local
  SWITCHDEV_FDB_{ADD,DEL}_TO_DEVICE event to `sw_fdb_add_to_list(dev)`,…
- [Critical] `sw_fdb_wq_handler()` re-derives the device object from the
  deferred entry via `pf = pci_get_drvdata(entry->pdev)` and assigns it…
- [Critical] `rvu_sw_swdev2af_sender_check()` deliberately short-circuits
  authorization for SWDEV2AF_MSG_TYPE_FW_STATUS when `req->fw_up` is…
- [High] The `fdb_notify` mailbox message carries no port identity, so
  the AF derives the switch port solely from `req->hdr.pcifunc`.
- [High] `call_switchdev_notifiers(SWITCHDEV_FDB_ADD_TO_BRIDGE /
  SWITCHDEV_FDB_DEL_TO_BRIDGE, ...)` is invoked from the PF and VF…
- [High] Both new AF up-message senders reuse the AF->PF / AF->VF
  `mbox_up` shared region and re-ring the doorbell without waiting for…
- [High] Pending `sw_fdb` work entries reference per-PF/VF mailbox state,
  but the global `sw_fdb_wq` is only torn down from…
- [High] `sw_fdb_llock` is acquired with plain `spin_lock()` from softirq
  context and also with plain `spin_lock()` from process context.
- [High] `rvu_mbox_handler_fdb_notify()` programs hardware L2 forwarding
  rules based purely on the sender's own port and an attacker-supplied…
- [Medium] Commit message claims the AF was taught to "treat it like the
  CGX link event when acknowledging mailbox completion", but no such…
- [Medium] The FDB refresh path can never reach representor (RVU_REP)
  netdevs even though the offload direction explicitly supports them.
- [Medium] The FDB offload and refresh pipeline drops the VLAN ID that is
  part of the switchdev FDB key.
- [Medium] The design permanently loses FDB changes whenever firmware is
  unavailable or any asynchronous stage hits a transient failure, with…
- [Medium] In `rvu_sw_l2_ctrl_work_handler()` the global pointers
  `rvu_sw_l2_offl_wq` and `fdb_refresh_wq` and the global work…
- [Medium] A WQ_MEM_RECLAIM control worker destroys non-WQ_MEM_RECLAIM
  workqueues.
- [Medium] `rvu->rswitch.pcifunc` is now mutable at runtime and is
  written under the file-local `rvu_sw_l2_state_lock` (in…
- [Medium] `rvu_sw_l2_offl_coalesce_pending_locked()` cancels a new FDB
  operation against *any* pending opposite operation for the same…
- [Medium] The AF acknowledges the switch firmware-up notification before
  its FDB queues exist, and a later initialization failure can never be…
- [Low] Two comments added by this patch describe opposite behaviour for
  the same message.

--

octeontx2: switch: plumb bridge FDB updates through AF and switchdev

This plumbs switchdev FDB add/delete notifications from the PF through a
new fdb_notify mailbox into the AF, which queues them and pushes L2 rules
toward the switchdev image.  It also adds an AF to PF/VF upstream
MBOX_MSG_AF2PF_FDB_REFRESH message which raises
SWITCHDEV_FDB_ADD_TO_BRIDGE so the bridge FDB entry is kept alive.

Some questions below.

>     Teach the AF swdev2af path to initialize L2 offload workqueues on
>     firmware up/down and to accept refresh requests that enqueue FDB
>     entries for AF to PF mailbox delivery. Add an AF to PF (and VF) upstream
>     message for FDB refresh, handle it in the VF driver, and treat it like
>     the CGX link event when acknowledging mailbox completion in the AF.

[Severity: Medium]
The changelog says the new message is treated "like the CGX link event when
acknowledging mailbox completion in the AF", but I can't find that change in
the diff.  __rvu_mbox_up_handler() in af/rvu.c still only special-cases
MBOX_MSG_CGX_LINK_EVENT:

	switch (msg->id) {
	case MBOX_MSG_CGX_LINK_EVENT:
		break;
	default:
		if (msg->rc)
			dev_err(rvu->dev, "Mbox msg response has err %d, ID 0x%x\n",
				msg->rc, msg->id);

So a response to MBOX_MSG_AF2PF_FDB_REFRESH lands in the default branch.  A
peer without this patch (an older guest VF driver, which the host cannot
control) answers through otx2_reply_invalid_msg() with sig =
OTX2_MBOX_RSP_SIG and rc = -ENODEV, which passes the signature check and hits
that dev_err() for every refresh message.  Should a case for the new id be
added here, or should the changelog drop that sentence?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index 2aa1aa6599a5a..8f7b2962a2126 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -2015,6 +2015,7 @@ struct af2pf_fdb_refresh_req {
>  	struct mbox_msghdr hdr;
>  	u16 pcifunc;
>  	u8 mac[6];
> +	u64 flags;
>  };

[Severity: Medium]
None of the structures used by this end-to-end path carry a VLAN id:
fdb_notify_req, af2swdev_notify_req and af2pf_fdb_refresh_req all have only
a MAC plus flags.  The switchdev FDB key includes the VLAN, and
br_switchdev_fdb_populate() sets item->vid = fdb->key.vlan_id.

sw_nb_fdb_event() forwards only fdb_info->addr and never rejects a non-zero
fdb_info->vid, so the same MAC in two VLANs collapses to one hardware key.

On the way back, both refresh handlers build a zero-initialized
switchdev_notifier_fdb_info, so the bridge is asked to refresh the vid == 0
entry:

net/bridge/br.c:br_switchdev_event() {
	...
	err = br_fdb_external_learn_add(br, p, fdb_info->addr,
					fdb_info->vid, fdb_info->locked, false);

Is a VLAN field needed in these messages, or should non-zero vid be rejected
in sw_nb_fdb_event() until it is plumbed through?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
> index 2451eb57ec4c8..71f113bded5eb 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
> @@ -33,9 +35,64 @@ u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
> +static int rvu_sw_swdev2af_sender_check(struct rvu *rvu,
> +					struct swdev2af_notify_req *req,
> +					u64 msg_type)
> +{
> +	u16 sender = req->hdr.pcifunc;
> +
> +	if (!rvu_sw_swdev2af_msg_valid(msg_type))
> +		return -EINVAL;
> +
> +	if (msg_type == SWDEV2AF_MSG_TYPE_FW_STATUS && req->fw_up)
> +		return 0;
> +
> +	if (!rvu_is_switch_pcifunc(rvu, sender))
> +		return -EPERM;
> +
> +	return 0;
> +}

[Severity: Critical]
Can any mailbox client claim the switchdev role here?  The early return
skips the only authorization check for FW_STATUS with fw_up set, and
rvu_sw_l2_ctrl_work_handler() then stores the sender's identity:

	rswitch->pcifunc = pcifunc;
	rswitch->flags |= RVU_SWITCH_FLAG_FW_READY;

SWDEV2AF_NOTIFY is an ordinary downstream message, and
__rvu_mbox_handler()/rvu_process_mbox_msg() apply no per-message sender ACL
(they only normalize hdr.pcifunc from the mailbox devid), including for the
AF-VF mailbox:

	case TYPE_AFVF:
		msg->pcifunc &= ~(RVU_PFVF_FUNC_MASK << RVU_PFVF_FUNC_SHIFT);
		msg->pcifunc |= (devid << RVU_PFVF_FUNC_SHIFT) + 1;
		...
	err = rvu_process_mbox_msg(mbox, devid, msg);

rswitch.pcifunc is used as a privilege token elsewhere in the AF:

drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c:npc_install_flow() {
	if (req->set_chanmask && !rvu_is_switch_pcifunc(rvu, req->hdr.pcifunc)) {
		...
		return NPC_FLOW_VF_PERM_DENIED;
	}

nix_txsch_pan_allowed() and nix_lf_alloc() also key off it.  Before this
patch nothing ever assigned rswitch.pcifunc, so rvu_is_switch_pcifunc() was
always false.  With this change a guest VF sending FW_STATUS/fw_up=true
becomes the switch pcifunc, then passes the sender check for REFRESH_FDB with
an arbitrary pcifunc and MAC, and all af2swdev L2 rule pushes are redirected
to it.  Should the FW_STATUS path also verify the sender (device id /
rep_pcifunc), and reject a takeover while a switch pcifunc is already
registered?

[Severity: Medium]
rvu->rswitch.pcifunc becomes mutable at runtime with this patch, written
under the file-local rvu_sw_l2_state_lock, but read without it by
rvu_sw_l2_offl_rule_push():

	swdev_pf = rvu_get_pf(rvu->pdev, rvu->rswitch.pcifunc);

and by the inline rvu_is_switch_pcifunc() used from rvu_npc_fs.c,
nix_txsch_pan_allowed() and nix_lf_alloc().  A repeated FW_STATUS(fw_up=true)
with a different hdr.pcifunc can change the value while queued offload work
is running, so messages may go to the old or new switch PF.  Is a shared
accessor (or storing it under a lock visible to those readers) needed?

> +int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
>  				     struct swdev2af_notify_req *req,
>  				     struct msg_rsp *rsp)
>  {
> -	return 0;
> +	int rc;
> +
> +	rc = rvu_sw_swdev2af_sender_check(rvu, req, req->msg_type);
> +	if (rc)
> +		return rc;
> +
> +	switch (req->msg_type) {
> +	case SWDEV2AF_MSG_TYPE_FW_STATUS:
> +		rc = rvu_sw_l2_init_offl_wq(rvu, req->hdr.pcifunc, req->fw_up);
> +		break;

[Severity: Medium]
This returns the result of merely queueing work.  rvu_sw_l2_init_offl_wq()
does queue_work(wq, &ctrl->work) and returns, while the offload/refresh
queues and RVU_SWITCH_FLAG_FW_READY are set later in
rvu_sw_l2_ctrl_work_handler().

Firmware that sees rc == 0 can immediately send REFRESH_FDB, which
rvu_sw_l2_fdb_list_entry_add() rejects with -EINVAL while fdb_refresh_wq is
still NULL.  PF FDB updates arriving in the same window are acknowledged and
dropped by rvu_mbox_handler_fdb_notify():

	if (!(rvu->rswitch.flags & RVU_SWITCH_FLAG_FW_READY)) {
		spin_unlock_bh(&rvu_sw_l2_state_lock);
		return 0;
	}

And if either alloc_workqueue() fails, the handler only does dev_err() with
no way to correct the success already reported to firmware.  Would it be
better to allocate the queues synchronously in the handler so the return
code reflects readiness?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
> index 5f805bfa81edb..448a442a6ffb2 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
> @@ -4,11 +4,619 @@

[ ... ]

> +static void rvu_sw_l2_destroy_wqs(struct rvu *rvu)
> +{
> +	struct workqueue_struct *offl_wq, *refresh_wq;
> +	struct l2_entry *entry;
> +
> +	spin_lock_bh(&rvu_sw_l2_state_lock);
> +	rvu->rswitch.flags &= ~RVU_SWITCH_FLAG_FW_READY;
> +	fw_is_up = false;
> +	spin_unlock_bh(&rvu_sw_l2_state_lock);
> +
> +	mutex_lock(&fdb_refresh_list_lock);
> +	refresh_wq = fdb_refresh_wq;
> +	fdb_refresh_wq = NULL;
> +	mutex_unlock(&fdb_refresh_list_lock);
> +
> +	if (refresh_wq) {
> +		cancel_work_sync(&fdb_refresh_work.work);
> +		destroy_workqueue(refresh_wq);

[Severity: Medium]
This runs from the rvu_sw_l2_ctrl_wq worker, which is created with
WQ_MEM_RECLAIM:

	rvu_sw_l2_ctrl_wq = alloc_ordered_workqueue("rvu_sw_l2_ctrl",
						    WQ_MEM_RECLAIM);

while refresh_wq and rvu_sw_l2_offl_wq are allocated with flags 0.
destroy_workqueue() always drains, and drain_workqueue() ->
__flush_workqueue() -> check_flush_dependency() warns on exactly this
combination:

kernel/workqueue.c:check_flush_dependency() {
	WARN_ONCE(worker && ((worker->current_pwq->wq->flags &
			      (WQ_MEM_RECLAIM | __WQ_LEGACY)) == WQ_MEM_RECLAIM),
		  "workqueue: WQ_MEM_RECLAIM %s:%ps is flushing !WQ_MEM_RECLAIM %s:%ps", ...);

The preceding cancel_work_sync() doesn't avoid that drain.  Should the
offload/refresh queues also carry WQ_MEM_RECLAIM, or the control queue drop
it?

[ ... ]

> +/* High-frequency link state transitions or aggressive FDB
> + * aging intervals can induce rapid fdb churn. To prevent
> + * thrashing, inhibit hardware offloading of these transient
> + * forwarding states to the switching ASIC.  Events are queued
> + * at the tail and processed from the head; when enqueueing a
> + * new operation, drop older pending opposite operations for the
> + * same MAC and port that have not yet reached hardware. When an
> + * opposite entry is removed, the new operation is dropped as well.
> + */
> +static bool rvu_sw_l2_offl_coalesce_pending_locked(struct rvu *rvu,
> +						   struct l2_entry *new_entry)
> +{
> +	u64 opposite = (new_entry->flags & OTX2_FDB_ADD) ? OTX2_FDB_DEL : OTX2_FDB_ADD;
> +	struct l2_entry *entry, *tmp;
> +	bool coalesced = false;
> +
> +	lockdep_assert_held(&l2_offl_list_lock);
> +
> +	list_for_each_entry_safe(entry, tmp, &l2_offl_lh, list) {
> +		if (!ether_addr_equal(new_entry->mac, entry->mac))
> +			continue;
> +
> +		if (new_entry->port_id != entry->port_id)
> +			continue;
> +
> +		if (!(entry->flags & opposite))
> +			continue;
> +
> +		list_del_init(&entry->list);
> +		rvu_sw_l2_list_cnt_dec(rvu->dev, &l2_offl_list_cnt, "offload");
> +		kfree(entry);
> +		coalesced = true;
> +	}
> +
> +	return coalesced;
> +}

[Severity: Medium]
Can this leave a stale rule programmed in hardware?  The coalescing has no
knowledge of which operations already reached the switch image:

  ADD(mac,port) queued -> worker pushes it (hardware entry programmed)
  ADD(mac,port) again (bridge fdb update / replace / external-learn re-add)
      -> queued, no opposite entry pending
  DEL(mac,port) -> matches the pending duplicate ADD, deletes it and
      returns coalesced == true

The caller then does:

	if (rvu_sw_l2_offl_coalesce_pending_locked(rvu, l2_entry)) {
		mutex_unlock(&l2_offl_list_lock);
		kfree(l2_entry);
		return 0;
	}

so the DEL never reaches hardware while the earlier ADD did.  Should
coalescing only cancel a pair where neither side has been pushed, e.g. by
collapsing duplicates on enqueue?

> +static int rvu_sw_l2_offl_rule_push(struct rvu *rvu, struct l2_entry *l2_entry)
> +{
> +	struct af2swdev_notify_req *req;
> +	int swdev_pf;
> +
> +	swdev_pf = rvu_get_pf(rvu->pdev, rvu->rswitch.pcifunc);
> +
> +	mutex_lock(&rvu->mbox_lock);
> +	req = otx2_mbox_alloc_msg_af2swdev_notify(rvu, swdev_pf);
> +	if (!req) {
> +		mutex_unlock(&rvu->mbox_lock);
> +		return -ENOMEM;
> +	}
> +
> +	ether_addr_copy(req->mac, l2_entry->mac);
> +	req->flags = l2_entry->flags;
> +	req->port_id = l2_entry->port_id;
> +
> +	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, swdev_pf);
> +	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, swdev_pf);
> +
> +	mutex_unlock(&rvu->mbox_lock);
> +	return 0;
> +}

[Severity: High]
Both new up-message senders here (and in rvu_sw_l2_fdb_refresh_send() on the
afpf and afvf regions) discard the boolean result of
otx2_mbox_wait_for_zero() and never call otx2_mbox_wait_for_rsp().  Every
other AF up-message producer waits for the response before releasing
mbox_lock, e.g.

drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c:cgx_notify_pfs() {
	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, pfid);
	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pfid);
	otx2_mbox_wait_for_rsp(&rvu->afpf_wq_info.mbox_up, pfid);

otx2_mbox_msg_send_data() takes exclusive ownership of the shared region on
each send:

	mdev->msg_size = 0;
	mdev->rsp_size = 0;
	mdev->msgs_acked = 0;
	...
	rx_hdr->num_msgs = 0;

Since rvu_sw_l2_offl_rule_wq_handler() sends up to 16 messages per run and
the refresh worker drains its whole list one message at a time, can this
clobber a message the peer's mbox_up worker is still parsing, and desync
num_msgs/msgs_acked?

> +static int rvu_sw_l2_fdb_refresh_send(struct rvu *rvu, u16 pcifunc, u8 *mac)
> +{
> +	struct af2pf_fdb_refresh_req *req;
> +	int pf, vf;

[ ... ]

> +	if (pf != 0) {
> +		if (pf >= rvu->afpf_wq_info.mbox_up.ndevs) {
> +			mutex_unlock(&rvu->mbox_lock);
> +			return -EINVAL;
> +		}
> +
> +		req = otx2_mbox_alloc_msg_af2pf_fdb_refresh(rvu, pf);

[Severity: Medium]
For the host switchdev model the changelog targets ("so the host bridge can
learn the updated FDB entry"), how does a refresh reach a representor
netdev?  The offload direction accepts rep netdevs:

	if (otx2_rep_dev(pdev)) {
		struct rep_dev *rep = netdev_priv(dev);
		return rep->mdev;
	}

but the refresh is addressed by the represented pcifunc and delivered to
that function's parent PF mailbox (or the AF-VF mailbox for pf == 0), and
the only PF-side consumer raises the notifier on pf->netdev.  The rvu_rep
driver processes no up-messages at all, so an entry learned on a rep bridge
port is never refreshed, ages out of the host bridge, and the resulting
SWITCHDEV_FDB_DEL_TO_DEVICE tears the hardware rule down each ageing
interval.  Is that configuration meant to be supported yet?

> +static void rvu_sw_l2_fdb_refresh_wq_handler(struct work_struct *work)
> +{

[ ... ]

> +		rvu_sw_l2_fdb_refresh_send(fdb_work->rvu, l2_entry->port_id,
> +					   l2_entry->mac);
> +		kfree(l2_entry);
> +	}
> +}
> +
> +static void rvu_sw_l2_offl_rule_wq_handler(struct work_struct *work)
> +{

[ ... ]

> +		if (rvu_sw_l2_offl_rule_push(offl_work->rvu, l2_entry))
> +			dev_err(offl_work->rvu->dev,
> +				"%s: Error to push l2 rule\n",
> +				__func__);
> +		/*
> +		 * TODO: Requeue l2_entry on transient rvu_sw_l2_offl_rule_push()
> +		 * errors (e.g. ENOMEM, -EBUSY) to keep hardware FDB in sync with
> +		 * the bridge. Drop-on-failure is known deferred work.
> +		 */
> +		kfree(l2_entry);

[Severity: Medium]
There seems to be no path that ever reconciles hardware with the bridge
after an update is lost.  Updates are dropped in several places:

 - rvu_mbox_handler_fdb_notify() returns 0 without keeping the update when
   RVU_SWITCH_FLAG_FW_READY is clear, and again when rvu_sw_l2_offl_wq is
   NULL
 - rvu_sw_l2_destroy_wqs() frees all queued entries on firmware-down
 - this handler frees the entry after rvu_sw_l2_offl_rule_push() fails
 - rvu_sw_l2_fdb_refresh_wq_handler() ignores the return of
   rvu_sw_l2_fdb_refresh_send() entirely
 - sw_fdb_wq_handler() frees the entry after sw_fdb_add_or_del() fails

On the next firmware-up, rvu_sw_l2_ctrl_work_handler() only re-allocates the
queues and re-arms FW_READY; the bridge won't re-emit
SWITCHDEV_FDB_ADD_TO_DEVICE for entries it already considers offloaded.  Is
a replay of the bridge FDB on firmware-up, or a periodic resync, planned?
A dropped delete leaves a stale hardware entry forwarding a MAC to a port
the bridge no longer uses.

> +static void rvu_sw_l2_ctrl_work_handler(struct work_struct *work)
> +{

[ ... ]

> +	if (rvu_sw_l2_offl_wq || fdb_refresh_wq)
> +		rvu_sw_l2_destroy_wqs(rvu);
> +
> +	l2_offl_work.rvu = rvu;
> +	INIT_WORK(&l2_offl_work.work, rvu_sw_l2_offl_rule_wq_handler);
> +	rvu_sw_l2_offl_wq = alloc_workqueue("swdev_rvu_sw_l2_offl_wq", 0, 0);
> +	if (!rvu_sw_l2_offl_wq) {
> +		dev_err(rvu->dev, "L2 offl workqueue allocation failed\n");
> +		return;
> +	}
> +
> +	fdb_refresh_work.rvu = rvu;
> +	INIT_WORK(&fdb_refresh_work.work, rvu_sw_l2_fdb_refresh_wq_handler);
> +	fdb_refresh_wq = alloc_workqueue("swdev_fdb_refresh_wq", 0, 0);
> +	if (!fdb_refresh_wq) {
> +		dev_err(rvu->dev, "fdb refresh workqueue allocation failed\n");
> +		destroy_workqueue(rvu_sw_l2_offl_wq);
> +		rvu_sw_l2_offl_wq = NULL;
> +		return;
> +	}

[Severity: Medium]
These global pointers and work containers are published with no lock and no
release barrier, while every other accessor uses the list mutexes.
rvu_sw_l2_fdb_list_entry_add() reads them under fdb_refresh_list_lock, which
the publisher never takes:

	mutex_lock(&fdb_refresh_list_lock);
	wq = fdb_refresh_wq;
	...
	queue_work(wq, &fdb_refresh_work.work);

On a weakly ordered machine, can a concurrent mailbox handler observe the
plain store to fdb_refresh_wq before the INIT_WORK() and .rvu stores are
visible, and then queue work with a stale work->func or stale .rvu?

The failure path here also does destroy_workqueue(rvu_sw_l2_offl_wq) plus
the NULL store outside l2_offl_list_lock and without cancel_work_sync(), and
rvu_sw_l2_shutdown() tests both pointers and dereferences l2_offl_work.rvu
with none of those locks held.

[ ... ]

>  int rvu_mbox_handler_fdb_notify(struct rvu *rvu,
>  				struct fdb_notify_req *req,
>  				struct msg_rsp *rsp)
>  {
> +	struct workqueue_struct *wq;
> +	struct l2_entry *l2_entry;
> +	u32 port_id;
> +
> +	spin_lock_bh(&rvu_sw_l2_state_lock);
> +	if (!(rvu->rswitch.flags & RVU_SWITCH_FLAG_FW_READY)) {
> +		spin_unlock_bh(&rvu_sw_l2_state_lock);
> +		return 0;
> +	}
> +	spin_unlock_bh(&rvu_sw_l2_state_lock);
> +
> +	port_id = rvu_sw_port_id(rvu, req->hdr.pcifunc);
> +	if (port_id == RVU_SW_INVALID_PORT_ID)
> +		return -EINVAL;

[Severity: High]
Is any sender check missing here?  The only validation is that the sender's
pcifunc maps to a representor port id, and rep2pfvf_map[] is populated with
CGX PFs *and* their VFs:

drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:rvu_mbox_handler_get_rep_cnt() {
	rvu->rep2pfvf_map[rep] = pcifunc;
	...
	rvu->rep2pfvf_map[rep] = pcifunc | ((vf + 1) & RVU_PFVF_FUNC_MASK);

So a guest VF can send FDB_NOTIFY with an arbitrary req->mac and
req->flags, and the AF queues an L2 rule binding that MAC to the VF's own
switch port (or an OTX2_FDB_DEL for a victim MAC).  Legitimate senders come
from the host switchdev notifier via sw_fdb_add_or_del(), i.e. host
PF/representor-parent PFs only.  Should VF senders be rejected here?

[Severity: High]
(same site) Related to the above: with the FW_STATUS authorization gap, an
attacker that has made itself rswitch.pcifunc also receives every L2 rule
push (each bridge FDB MAC plus port id) via af2swdev_notify.

> +	if (atomic_read(&l2_offl_list_cnt) >= RVU_SW_L2_LIST_MAX) {
> +		rvu_sw_l2_list_cnt_warn(rvu->dev, &l2_offl_list_cnt, "offload");
> +		return -ENOMEM;
> +	}

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> index fcdf891f90b58..1d86cac5a7e83 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
> @@ -114,6 +115,38 @@ static void otx2vf_vfaf_mbox_handler(struct work_struct *work)
> +#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
> +static int otx2vf_mbox_af2pf_fdb_refresh(struct otx2_nic *vf,
> +					 struct af2pf_fdb_refresh_req *req,
> +					 struct msg_rsp *rsp)
> +{
> +	struct switchdev_notifier_fdb_info item = {0};
> +
> +	/* VM bridge + HW offload: vf->netdev is a br0 port in the guest.
> +	 * SWITCHDEV_FDB_ADD_TO_BRIDGE on this netdev refreshes the guest
> +	 * bridge FDB even when accelerated traffic bypasses eth0/eth1 RX
> +	 * (see rvu_sw_l2_fdb_refresh_send()).
> +	 */
> +	item.addr = req->mac;
> +	item.info.dev = vf->netdev;
> +	if (req->flags & OTX2_FDB_DEL)
> +		call_switchdev_notifiers(SWITCHDEV_FDB_DEL_TO_BRIDGE,
> +					 item.info.dev, &item.info, NULL);
> +	else
> +		call_switchdev_notifiers(SWITCHDEV_FDB_ADD_TO_BRIDGE,
> +					 item.info.dev, &item.info, NULL);
> +
> +	return 0;
> +}

[Severity: High]
This runs from the VF mailbox-up work handler (otx2vf_vfaf_mbox_handler(),
plain process context) with neither rtnl_lock() nor rcu_read_lock() held.
The same applies to otx2_mbox_up_handler_af2pf_fdb_refresh() in sw_fdb.c
called from otx2_pfaf_mbox_up_handler().  The notifier callee documents the
requirement:

net/bridge/br.c
/* called with RTNL or RCU */
static int br_switchdev_event(...)
{
	...
	p = br_port_get_rtnl_rcu(dev);
	if (!p)
		goto out;
	br = p->br;

Besides the CONFIG_PROVE_RCU splat from rcu_dereference_rtnl(), can
struct net_bridge_port be freed by a concurrent br_del_if() /
netdev_rx_handler_unregister() between that dereference and the use of
p->br?  DSA's dsa_slave_switchdev_event_work() and the mlx5 bridge offload
take rtnl_lock() around this call.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
> index 500451e85b503..e5e20b08ee8ee 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
> @@ -4,16 +4,276 @@

[ ... ]

> +static struct otx2_nic *sw_fdb_netdev_to_nic(struct net_device *dev)
> +{
> +	struct device *parent = dev->dev.parent;
> +
> +	if (parent && parent->bus == &pci_bus_type) {
> +		struct pci_dev *pdev = to_pci_dev(parent);
> +
> +		if (otx2_rep_dev(pdev)) {
> +			struct rep_dev *rep = netdev_priv(dev);
> +
> +			return rep->mdev;
> +		}
> +	}
> +
> +	return netdev_priv(dev);
> +}

[Severity: Critical]
Can this return a pointer that isn't a struct otx2_nic?  The fallthrough
returns netdev_priv(dev) for any netdev that isn't an RVU representor, and
sw_nb_is_valid_dev() explicitly admits VLAN uppers and bridge devices whose
lowers are merely Cavium-vendor PCI netdevs:

drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c:sw_nb_is_valid_dev() {
	if (netif_is_bridge_master(netdev) || is_vlan_dev(netdev)) {
		netdev_walk_all_lower_dev_rcu(netdev, sw_nb_check_slaves, &priv);
		valid = priv.flags && cnt;

drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c:sw_nb_is_cavium_dev() {
	if (pdev->vendor != PCI_VENDOR_ID_CAVIUM)
		return false;

A VLAN netdev has dev->dev.parent == NULL (net/8021q/vlan_dev.c only does
SET_NETDEV_DEVTYPE, never SET_NETDEV_DEV), so the PCI branch is skipped and
vlan_dev_priv memory is returned typed as struct otx2_nic *.
sw_fdb_add_to_list() then does:

	entry->pdev = pci_dev_get(pf->pdev);

reading pf->pdev from an offset past the end of the much smaller VLAN
private area, and the worker later calls pci_get_drvdata() and
mutex_lock(&pf->mbox.lock) through it.  The if (!pf) guard can't catch this
because the pointer is non-NULL.

Reproducer shape:

	ip link add link eth0 name eth0.100 type vlan id 100
	ip link set eth0.100 master br0
	# any learned (non-local) MAC on that port

Should sw_fdb_netdev_to_nic() return NULL unless the netdev is known to be
an rvu_nicpf/rvu_nicvf/rvu_rep netdev (e.g. by comparing
dev->netdev_ops or the PCI device id) instead of falling back to
netdev_priv()?

[ ... ]

> +static void sw_fdb_wq_handler(struct work_struct *work)
> +{
> +	struct sw_fdb_list_entry *entry;
> +	struct otx2_nic *pf;
> +	struct workqueue_struct *wq;
> +	LIST_HEAD(tlist);
> +
> +	spin_lock(&sw_fdb_llock);
> +	list_splice_init(&sw_fdb_lh, &tlist);
> +	spin_unlock(&sw_fdb_llock);

[Severity: High]
sw_fdb_llock is taken with plain spin_lock() here and in sw_fdb_deinit()
from process context, but also with plain spin_lock() from softirq context
in sw_fdb_add_to_list() (the GFP_ATOMIC allocation and
netdev_hold(..., GFP_ATOMIC) there confirm the atomic context).  The
bridge raises the switchdev notifier from the NET_RX softirq learning path:

net/bridge/br_fdb.c:br_fdb_update() {
	...
	br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);

So while this worker holds the lock for list_splice_init(), a softirq on the
same CPU delivering a learned MAC calls sw_fdb_add_to_list() ->
spin_lock(&sw_fdb_llock) on the already-held lock.  Should all these sites
use spin_lock_bh()?

> +	while ((entry =
> +		list_first_entry_or_null(&tlist,
> +					 struct sw_fdb_list_entry,
> +					 list)) != NULL) {
> +		list_del_init(&entry->list);
> +		sw_fdb_list_cnt_dec(entry->dev);
> +
> +		spin_lock(&sw_fdb_llock);
> +		wq = sw_fdb_wq;
> +		spin_unlock(&sw_fdb_llock);
> +
> +		pf = wq ? pci_get_drvdata(entry->pdev) : NULL;
> +		if (pf && sw_fdb_add_or_del(pf, entry->mac, entry->add_fdb))

[Severity: Critical]
For PF and VF PCI devices, isn't the driver data a struct net_device * and
not a struct otx2_nic *?

drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:otx2_probe() {
	pci_set_drvdata(pdev, netdev);

drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c:otx2vf_probe() {
	pci_set_drvdata(pdev, netdev);

Only rep.c stores the struct otx2_nic *.  The result is passed to
sw_fdb_add_or_del(), which does mutex_lock(&pf->mbox.lock) and
otx2_mbox_alloc_msg_fdb_notify(&pf->mbox) on memory that is actually inside
struct net_device.  The void * return of pci_get_drvdata() hides the
mistype at compile time.

sw_fdb_add_to_list() already resolved the correct struct otx2_nic * via
sw_fdb_netdev_to_nic() and then discarded it, keeping only entry->pdev.
Could the entry carry the otx2_nic pointer (with whatever reference makes it
safe) instead of re-deriving it here?

[Severity: High]
Related lifetime question at the same site: what keeps pf->mbox alive until
this work runs?  The global sw_fdb_wq is only torn down by
otx2_sw_nb_unregister() (driven by devlink eswitch mode on the RVU_REP
device), so removing the PF/VF instance that owns the referenced mailbox
doesn't cancel or purge the pending entries:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:otx2_remove() {
	otx2_pfaf_mbox_destroy(pf);
	pci_free_irq_vectors(pf->pdev);
	...
	pci_set_drvdata(pdev, NULL);
	free_netdev(netdev);

The if (pf) check can read a still-valid drvdata and then use pf->mbox after
otx2_pfaf_mbox_destroy() has destroyed the mailbox workqueue and
unmapped/freed the mailbox region.  netdev_hold()/pci_dev_get() keep the
net_device and pci_dev allocations alive, but not the mailbox state that is
dereferenced.  Should the remove path flush/purge the entries belonging to
that device?

[ ... ]

> +int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
> +					   struct af2pf_fdb_refresh_req *req,
> +					   struct msg_rsp *rsp)
> +{
> +	struct switchdev_notifier_fdb_info item = {0};
> +
> +	/* FDB refresh is raised from the switch offload path (AF) after
> +	 * switchdev FDB updates. PF-local ports are refreshed on pf->netdev.
> +	 * TODO: When req->hdr.pcifunc targets a guest VF (VM-bridged offload),
> +	 * forward the refresh via the PF-VF mailbox instead of applying it to
> +	 * pf->netdev; otherwise guest-owned MACs may age out prematurely (see
> +	 * rvu_sw_l2_fdb_refresh_send()).
> +	 */

[Severity: Low]
This comment and the one in rvu_sw_l2_fdb_refresh_send() describe opposite
behaviour for the same message.  Here the claim is that a VF-targeted
refresh is applied to pf->netdev and PF-VF forwarding is a TODO, but the PF
up-mbox dispatch never processes such a message locally:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:otx2_pfaf_mbox_up_handler() {
	devid = msg->pcifunc & RVU_PFVF_FUNC_MASK;
	/* Skip processing VF's messages */
	if (!devid)
		otx2_process_mbox_msg_up(pf, msg);

The rvu_sw_l2_fdb_refresh_send() comment states this correctly ("the parent
PF mailbox forwards the message to the guest VF driver").  Could the TODO
here be dropped or reworded?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
> index b51d8d2d01b8c..c947f30becc83 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
> @@ -191,13 +191,17 @@ static int sw_nb_fdb_event(struct notifier_block *unused,
>  	switch (event) {
>  	case SWITCHDEV_FDB_ADD_TO_DEVICE:
> -		if (fdb_info->is_local)
> -			break;
> -		break;
> -
>  	case SWITCHDEV_FDB_DEL_TO_DEVICE:
>  		if (fdb_info->is_local)
>  			break;
> +		/* dev is the bridge port that learned the FDB
> +		 * (SWITCHDEV_FDB_*_TO_DEVICE), not the bridge master.
> +		 * sw_nb_is_valid_dev() limits this to Cavium-offloaded
> +		 * setups; only Cavium PF/representor netdevs are supported
> +		 * as bridge ports today (VLAN/virt under bridge is TODO).
> +		 */
> +		sw_fdb_add_to_list(dev, (u8 *)fdb_info->addr,
> +				   event == SWITCHDEV_FDB_ADD_TO_DEVICE);
>  		break;

[Severity: High]
The comment says representor netdevs are supported bridge ports, but does
the AF accept an FDB update that originates from one?  fdb_notify_req has no
port field:

	struct fdb_notify_req {
		struct  mbox_msghdr hdr;
		u64 flags;
		u8  mac[ETH_ALEN];
		u8  rsvd[2];
	};

so the AF derives the port from req->hdr.pcifunc only.  For a rep bridge
port, sw_fdb_add_or_del() sends on the representor PF's own mailbox
(pf = rep->mdev), so hdr.pcifunc is the RVU_REP PF, not the represented
function.  rvu_sw_port_id() looks that up in rep2pfvf_map[] (populated only
with CGX PFs and their VFs), rvu_rep_get_vlan_id() returns 0, the
rep2pfvf_map[0] != pcifunc recheck fails, and
rvu_mbox_handler_fdb_notify() returns -EINVAL:

	port_id = rvu_sw_port_id(rvu, req->hdr.pcifunc);
	if (port_id == RVU_SW_INVALID_PORT_ID)
		return -EINVAL;

That would make every learn/flush on a rep bridge port fail with "Error to
add/del fdb %pM entry", and even if accepted, all rep ports share one
mailbox so they'd collapse to a single identity.  Does fdb_notify_req need a
port_id/pcifunc field for this to work?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831131944.2649362-1-rkannoth%40marvell.com
