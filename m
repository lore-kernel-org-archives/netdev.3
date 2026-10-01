Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0264C2E7378;
	Thu,  1 Oct 2026 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837051; cv=none; b=d3FYrTrhH/ufyYUW4tUvGdd/ieLDB2Vxxjawnq+9hPGiMp+lj5fUZ8PfdFfvzG7JKsmWbLS293n4QFiW+3ObhaoHB/UQWYXgW3nxiZIEe7gJ7ECb3g6uR1MIICzmXWEmrk9dri2qpF9Y8kqksOt96j4qk6e4hqRWpufpj9w8Gu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837051; c=relaxed/simple;
	bh=LsnAAHvFDuQwyPRClA/c5MrD2tO6dRUppdgUbT7c60Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xeix8jDSpgF78M1WKaklUF305fke52X3AuU8SXr7BCYdo+vN+lkWAaQ9M5oL4X3uxxr/N05xvhdxNJG/Ehwipvmr6UV876E49g+MzqzdJy8JOFONL1Baoou1cS57rWAUka23C37uIDg1G1ja/N1ARam3n0ruIx+qTs9eoddV20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNTQImGB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNTQImGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3871F000FF;
	Thu,  1 Oct 2026 06:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790837049;
	bh=uz52g7ev+vWjhN7bH8UE/Z6VdNF3LXi0sq1ISXrMIZw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eNTQImGB7dN7wumknTTYXtn38v8RZZI0IG07xFHMK10vDB/Y70LhZ9V7rnfPlJiA0
	 dhFK+PCEwVDQqfYznwA2OlDE38vWqZL3hG0E3fXOUJ8FKI6QqX9+dat62MP36rZZ8l
	 tP1eZuzCR9hKAkbZuufId2OdpYY/yMZlbFhIRX6MvJvD8lvVuRD9PL3OJRKwLxt/Te
	 ZOhPrNExYg9hAo051DJXKE006Y1rQwo+6kMFTGzDRLoX1or5i+0rg+lPT0Wc56CLcs
	 0598Q7UcHloLQMYV5ufryUf+SRA8jYaedeliRBD8G5pzPneuaRcpZ4wZwTKQ24J0Ei
	 CHanJ+5ckTc9A==
Subject:
 Re: [PATCH net v5] octeontx2-af: Fix rep link state sync and workqueue races
From: netdev-bot+sashiko@kernel.org
To: nshettyj@marvell.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gakula@marvell.com,
 sgoutham@marvell.com, rkannoth@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bbhushan2@marvell.com, hkalra@marvell.com,
 horms@kernel.org
Date: Thu, 01 Oct 2026 06:44:08 +0000
Message-ID: <179083704829.434549.18236369316402522728@kernel.org>
In-Reply-To: <20260928034213.3173088-1-nshettyj@marvell.com>
References: <20260928034213.3173088-1-nshettyj@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 0 · High: 1 (4) · Medium: 9 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In the rvu_probe() err_irq/err_dl path, rep_evt_wq is destroyed
  before the FLR workqueue is drained.
- [Medium] One commit carries many independent fixes under a single
  `Fixes: b8fea84a0468` (Nov 2024).
- [Medium] The permanent commit message is one sentence.
- [Medium] The new initial link-state replay (rvu_rep_notify_pfvf_state()
  for PFs/VFs with NIXLF_INITIALIZED) runs only inside…
- [Medium] rvu_switch_update_rules() now takes rswitch->switch_lock on
  every non-rep call.
- [Medium] rvu_probe() can still leak rep_evt_wq.
- [Medium] The new switch_lock only covers the bookkeeping, not the
  actions that depend on it.
- [Medium] rvu_switch_enable() now sets used_entries only after
  rvu_rep_install_mcam_rules()/rvu_switch_install_rules() finish, and…
- [Medium] rvu_rep_install_mcam_rules() samples NIXLF_INITIALIZED into
  lbk_enabled, installs several rules (mbox handler calls), and only…
- [Medium] rvu_mbox_handler_get_rep_cnt() gives the representor role
  permanently to the first PF that sends GET_REP_CNT.

Pre-existing issues:
- [High] rvu_rep_update_rules() passes the relative index `entry` into
  entry2pcifunc[] straight to npc_enable_mcam_entry().
- [High] Representor teardown can dereference a NULL (or stale) parent
  netdev.
- [High] rvu_rep_destroy() reads rep->flow_cfg after
  free_netdev(rep->netdev).
- [High] rvu_rep_get_stats64() schedules rep->stats_wrk (a delayed_work
  inside rep_dev, which lives inside the netdev) on the system workqueue…
- [Medium] rvu_devlink_eswitch_mode_set() sets rswitch->mode before
  calling rvu_switch_enable(), which returns void.

--

octeontx2-af: Fix rep link state sync and workqueue races

This patch moves the representor event workqueue setup from
rvu_rep_install_mcam_rules() into rvu_mbox_handler_get_rep_cnt(), and adds
teardown for it in rvu_probe() and rvu_remove(). It also adds bounds and
ownership checks to the REP mailbox handlers, and serializes LBK link
configuration and rswitch bookkeeping with rsrc_lock and switch_lock. On
the NIC side it reworks representor teardown.

> Move rep event workqueue init to rvu_mbox_handler_get_rep_cnt(),
> fix use-after-free and race conditions in rep event handling,
> add bounds checking, and serialize LBK link configuration.
>
> Fixes: b8fea84a0468 ("octeontx2-pf: Add support to sync link state between representor and VFs")

[Severity: Medium]
Is b8fea84a0468 the right target for every fix bundled here?

Several of the rvu_switch.c changes fix code in the non-representor switch
path. That code came from 23109f8dd06d ("octeontx2-af: Introduce internal
packet switching"):

  - rvu_switch_enable() publishing used_entries before entry2pcifunc[] is
    populated
  - unlocked used_entries/entry2pcifunc[] access in
    rvu_switch_update_rules()
  - the uninstall range derived from used_entries

The rep_mode branch in rvu_switch_enable() came from 683645a2317e
("octeontx2-af: Add packet path between representor and VF").

With only the one Fixes tag, would stable trees that have 23109f8dd06d but
not b8fea84a0468 miss the rvu_switch fixes? Would it help to split this
into separate patches, each with its own Fixes tag?

[Severity: Medium]
The commit message is one sentence. Most of the behaviour changes are only
in the per-version changelog below the --- line, and git am drops that.

Could the commit message describe the mailbox contract changes that show up
in the diff?

  - rvu_rep_notify_pfvf_state() now goes through the async
    REP_EVENT_NOTIFY queue. It silently drops the event when rep_mode is
    off or there is no workqueue.
  - GET_REP_CNT now binds rep_pcifunc permanently to the first PF that
    calls it. VFs and later PFs get -EPERM, and more than RVU_MAX_REP
    representors gets -EINVAL.
  - Enabling switchdev now enables LBK links and sends initial
    PFVF_STATE events for PFs/VFs that are already initialized.
  - In rep mode, rvu_switch_disable() now disables the LBK link of every
    CGX-mapped PF/VF.
  - The workqueue changes from WQ_PERCPU to WQ_UNBOUND.
  - REP_EVENT_NOTIFY from any caller other than rep_pcifunc is rejected.

It might also help to name the original bugs being fixed:

  - rep_evt_wq was leaked on every enable
  - INIT_WORK() and INIT_LIST_HEAD() were re-run on live objects
  - queue_work() could be passed a NULL workqueue
  - the response map could overflow

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 937b085582b5f..baba564259436 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c

[ ... ]

> @@ -3686,7 +3703,18 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  err_dl:
>  	rvu_unregister_dl(rvu);
>  err_irq:
> +	/*
> +	 * GET_REP_CNT may have allocated rep_evt_wq before this failure.
> +	 * Drain it before unregistering interrupts.
> +	 */
> +	rep_wq = rvu_rep_evtq_disable(rvu);
> +
>  	rvu_unregister_interrupts(rvu);
> +
> +	if (rep_wq) {
> +		flush_workqueue(rvu->afpf_wq_info.mbox_wq);
> +		destroy_workqueue(rep_wq);
> +	}
>  err_flr:
>  	rvu_flr_wq_destroy(rvu);
>  err_mbox:

[Severity: Medium]
Can rep_evt_wq still leak when rvu_register_interrupts() itself fails?

rvu_register_interrupts() calls rvu_enable_mbox_intr() early. After that
it can still fail: PF FLR request_irq, AF-VF FLR0/FLR1, ME0/ME1, or
rvu_cpt_register_interrupts(). In that case rvu_probe() jumps to err_flr,
which is below this new block:

rvu_probe()
    err = rvu_register_interrupts(rvu);
    if (err) {
        ...
        goto err_flr;
    }

rep_evt_teardown is never set on this path. While the mailbox was live,
rvu_mbox_handler_get_rep_cnt() could have allocated and published
rep_evt_wq. It could also do so while rvu_mbox_destroy() drains mbox_wq.

Would that workqueue, and any queued rep_evtq_ent entries, be leaked when
rvu is devm_kfree()d? The v5 changelog says this probe leak is fixed.

[Severity: High]
Is rep_wq destroyed here before the FLR workqueue has been drained?

The FLR path produces representor events:

__rvu_flr_handler()
  rvu_blklf_teardown()
    rvu_nix_lf_teardown()
      rvu_rep_notify_pfvf_state()
        rvu_mbox_handler_rep_event_notify()
            wq = smp_load_acquire(&rvu->rep_evt_wq);
            ...
            queue_work(wq, &rvu->rep_evt_work);

wq is loaded without rsrc_lock or RCU, and queue_work() only runs after
the kmalloc and the spinlock section. __rvu_flr_handler() holds only
flr_lock.

On this error path the order is:

  1. rvu_rep_evtq_disable()
  2. rvu_unregister_interrupts()
  3. flush of the AF-PF mbox_wq
  4. destroy_workqueue(rep_wq)
  5. rvu_flr_wq_destroy() at err_flr

If an FLR work item loaded wq before it was cleared, can it call
queue_work() on the destroyed workqueue? rvu_remove() calls
rvu_flr_wq_destroy() before destroy_workqueue(rep_wq), so only the probe
path seems to have this ordering.

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> index a2781e0f504e3..4c4171515d743 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c

[ ... ]

> @@ -334,29 +370,43 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
>  			continue;
>  
>  		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
> +		pfvf = rvu_get_pfvf(rvu, pcifunc);
>  		rvu_get_nix_blkaddr(rvu, pcifunc);
> +		lbk_enabled = test_bit(NIXLF_INITIALIZED, &pfvf->flags);
> +		if (lbk_enabled)
> +			rvu_switch_enable_lbk_link(rvu, pcifunc, true);
>  		rep = true;
>  		for (i = 0; i < 2; i++) {

[ ... ]

> +		/* Sync initial link state for a PF brought up before
> +		 * switchdev mode was enabled.
> +		 */
> +		if (lbk_enabled)
> +			rvu_rep_notify_pfvf_state(rvu, pcifunc, true);

[Severity: Medium]
Could this queue a stale up event?

lbk_enabled is sampled before the four rule installs, and the true event
is queued only after them. Nothing orders this against NIX_LF_STOP_RX.

Suppose rvu_mbox_handler_nix_lf_stop_rx() clears NIXLF_INITIALIZED and
queues rvu_rep_notify_pfvf_state(pcifunc, false) in that window. This code
then queues true, and the FIFO worker delivers down, then up.

Would the representor end up with RVU_REP_VF_INITIALIZED set for a stopped
function? The VF loop further down has the same window.

[ ... ]

>  void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena)
>  {
>  	struct rvu_switch *rswitch = &rvu->rswitch;
>  	struct npc_mcam *mcam = &rvu->hw->mcam;
> -	u32 max = rswitch->used_entries;
>  	int blkaddr;
>  	u16 entry;
> +	u32 max;

[ ... ]

>  	rvu_switch_enable_lbk_link(rvu, pcifunc, ena);
>  	mutex_lock(&mcam->lock);
> @@ -415,6 +483,7 @@ void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena)
>  			npc_enable_mcam_entry(rvu, mcam, blkaddr, entry, ena);
>  	}
>  	mutex_unlock(&mcam->lock);
> +	mutex_unlock(&rswitch->switch_lock);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but should the index passed to
npc_enable_mcam_entry() be rswitch->start_entry + entry?

rvu_rep_install_mcam_rules() installs each rule at start + entry and
records it in entry2pcifunc[entry]. rvu_switch_update_rules() also uses
start_entry + entry. Here the relative index goes straight to
npc_enable_mcam_entry(), which programs NPC_AF_MCAMEX_BANKX_CFG() from the
index it is given.

In rep mode, would every NIX_LF_START_RX/STOP_RX then enable or disable
MCAM entries 0..used_entries-1? Those entries belong to other functions,
and the representor rules would never be touched.

This function is being rewritten anyway. Could the offset be fixed here
too?

> @@ -435,10 +504,31 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
>  	if (req->hdr.pcifunc != rvu->rep_pcifunc)
>  		return 0;
>  
> -	rvu->rep_mode = req->ena;
> +	if (req->ena) {
> +		rvu->rep_mode = true;
> +	} else {

[Severity: Medium]
When representor mode is re-enabled here, does anything replay the state
of PFs/VFs that are already running?

The new initial link-state replay only happens in
rvu_rep_install_mcam_rules(). That is reached only from
rvu_switch_enable(), and only when the AF devlink mode actually changes.

Suppose only the representor PF is switched legacy -> switchdev while the
AF stays in switchdev:

otx2_devlink_eswitch_mode_set()
    rvu_rep_destroy()
    rvu_rep_create()

ESW_CFG(ena=1) then only sets rep_mode here. rvu_devlink_eswitch_mode_set()
also returns early:

	if (rswitch->mode == mode)
		return 0;

The new reps start with RVU_REP_VF_INITIALIZED clear. For representees
that are already up, would rvu_rep_open() skip carrier-on and
rvu_rep_setup_tc_cb() return -EINVAL until their next state transition?

[ ... ]

> @@ -446,32 +536,96 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
>  int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
>  				 struct get_rep_cnt_rsp *rsp)
>  {

[ ... ]

> +	/* Only a PF can register as the representor, not a VF. */
> +	if (req->hdr.pcifunc & RVU_PFVF_FUNC_MASK) {
> +		ret = -EPERM;
> +		goto unlock;
> +	}

[Severity: Medium]
Is rejecting VFs enough to identify the representor PF?

Any PF that sends GET_REP_CNT first becomes rvu->rep_pcifunc, including a
CGX-mapped representee PF:

	rvu->rep2pfvf_map = map;
	rvu->rep_pcifunc = req->hdr.pcifunc;

That PF then passes the ownership checks in REP_EVENT_NOTIFY and ESW_CFG,
and gets the is_rep_dev() privileges in NIX/NPC. For example, it could use
REP_EVENT_NOTIFY to rewrite other functions' pfvf->mac_addr.

rep2pfvf_map is now cached, and rvu_rep_get_rep_map() returns -EPERM to
everyone else. Would the real representor PF then be locked out until the
AF is reloaded? Before this patch the role was overwritten on each call.

Could the caller be checked against the representor device itself?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
> index 49ce38685a7e6..0897598c6edea 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c

[ ... ]

> @@ -188,7 +195,7 @@ void rvu_switch_enable(struct rvu *rvu)
>  	if (!rswitch->entry2pcifunc)
>  		goto free_entries;
>  
> -	rswitch->used_entries = alloc_rsp.count;
> +	/* Publish used_entries only after entry2pcifunc[] is fully populated. */
>  	rswitch->start_entry = alloc_rsp.entry;
>  
>  	if (rvu->rep_mode) {
> @@ -200,13 +207,25 @@ void rvu_switch_enable(struct rvu *rvu)
>  	if (ret)
>  		goto uninstall_rules;
>  
> +	mutex_lock(&rswitch->switch_lock);
> +	rswitch->used_entries = alloc_rsp.count;
> +	mutex_unlock(&rswitch->switch_lock);

[Severity: Medium]
Can PF/VF state changes that happen during the install be lost now?

The install loop does not hold switch_lock, and used_entries is published
only after the loop finishes.

Take a PF/VF whose NIXLF_INITIALIZED is clear when the loop samples it.
Its LBK link is skipped, and in non-rep mode rvu_switch_install_tx_rule()
returns early.

If nix_lf_start_rx then sets the flag and calls rvu_switch_update_rules()
before used_entries is published, it sees:

	max = rswitch->used_entries;
	if (!max) {
		mutex_unlock(&rswitch->switch_lock);
		return;
	}

Would that function's LBK link and TX rule then stay unprogrammed until it
is restarted? Likewise, a stop_rx during the install would leave rules
enabled for a stopped function.

Before this patch the window covered one entry; now it covers the whole
install.

>  
>  	return;
>  
>  uninstall_rules:
> +	if (rvu->rep_mode && rvu->rep_pcifunc)
> +		rvu_switch_enable_lbk_link(rvu, rvu->rep_pcifunc, false);
> +
>  	uninstall_req.start = rswitch->start_entry;
> -	uninstall_req.end =  rswitch->start_entry + rswitch->used_entries - 1;
> +	uninstall_req.end =  rswitch->start_entry + alloc_rsp.count - 1;
>  	rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req, &uninstall_rsp);
> +	mutex_lock(&rswitch->switch_lock);
> +	rswitch->used_entries = 0;
> +	rswitch->start_entry = 0;
>  	kfree(rswitch->entry2pcifunc);
> +	rswitch->entry2pcifunc = NULL;
> +	mutex_unlock(&rswitch->switch_lock);

[Severity: Medium]
This is a pre-existing issue, but the caller never learns about this
rollback. rvu_switch_enable() returns void, and
rvu_devlink_eswitch_mode_set() has already committed the mode:

	rswitch->mode = mode;
	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV)
		rvu_switch_enable(rvu);

If rule installation fails, devlink still returns 0 and mode stays
SWITCHDEV with no rules installed. Would a later switchdev request hit the
rswitch->mode == mode early return and never retry the install?

[ ... ]

> @@ -260,35 +294,46 @@ void rvu_switch_disable(struct rvu *rvu)
>  	}
>  
>  free_ents:
> +	mutex_lock(&rswitch->switch_lock);
>  	uninstall_req.start = rswitch->start_entry;

[ ... ]

>  void rvu_switch_update_rules(struct rvu *rvu, u16 pcifunc, bool ena)
>  {
>  	struct rvu_switch *rswitch = &rvu->rswitch;
> -	u32 max = rswitch->used_entries;
> +	u16 start_entry;
>  	u16 entry;
> +	u32 max;
>  
>  	if (rvu->rep_mode)
>  		return rvu_rep_update_rules(rvu, pcifunc, ena);
>  
> -	if (!rswitch->used_entries)
> +	mutex_lock(&rswitch->switch_lock);
> +	max = rswitch->used_entries;
> +	if (!max) {
> +		mutex_unlock(&rswitch->switch_lock);
>  		return;
> +	}

[Severity: Medium]
Can this take switch_lock before it has been initialized?

Before this patch, the !used_entries case returned without touching the
lock. Now every non-rep call takes it, and rvu_rep_update_rules() also
takes it unconditionally.

In rvu_probe(), the mailbox goes live in rvu_register_interrupts() via
rvu_enable_mbox_intr(). The lock init only runs later, after
rvu_register_dl(), rvu_enable_sriov() and rvu_dbg_init():

	mutex_init(&rvu->rswitch.switch_lock);

A NIX_LF_START_RX/STOP_RX handled in that window would go through
rvu_mbox_handler_nix_lf_start_rx()->rvu_switch_update_rules() and lock an
uninitialized mutex. The later mutex_init() could then reinitialize a
mutex that is held.

rvu_mbox_handler_npc_install_flow() already had this ordering problem, but
this adds a new user on the start/stop RX path. Should the mutex_init()
move before rvu_register_interrupts()?

>  
>  	for (entry = 0; entry < max; entry++) {
>  		if (rswitch->entry2pcifunc[entry] == pcifunc)
>  			break;
>  	}
> +	start_entry = rswitch->start_entry;
> +	mutex_unlock(&rswitch->switch_lock);
>  
>  	if (entry >= max)
>  		return;
>  
> -	rvu_switch_install_tx_rule(rvu, pcifunc, rswitch->start_entry + entry);
> +	rvu_switch_install_tx_rule(rvu, pcifunc, start_entry + entry);
>  	rvu_switch_install_rx_rule(rvu, pcifunc, 0x0);
>  }

[Severity: Medium]
Does switch_lock need to cover the rule installs as well as the lookup?

The lookup runs under the lock, but two calls run after it is dropped:

  - rvu_switch_install_tx_rule(), which also enables the LBK link
  - rvu_switch_install_rx_rule(..., 0x0)

Meanwhile rvu_switch_disable() reverts the RX rules and disables the LBK
links before it takes switch_lock at free_ents.

Suppose a devlink disable completes between the lookup and these installs.
Could the LBK link end up re-enabled, the RX channel mask reverted, and a
rule written into a freed or reallocated MCAM entry?

Rep mode has a similar window. rvu_rep_update_rules(ena=true) can run
between the LBK-disable loop in rvu_switch_disable() and its locked reset,
and turn the link back on.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> index 0f5d5642d3f7a..21b5802cb9431 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c

[ ... ]

> @@ -628,20 +654,27 @@ static int rvu_rep_rsrc_init(struct otx2_nic *priv)
>  
>  void rvu_rep_destroy(struct otx2_nic *priv)
>  {
> +	struct rep_dev **reps = priv->reps;
>  	struct rep_dev *rep;
>  	int rep_id;
>  
>  	rvu_eswitch_config(priv, false);
>  	priv->flags |= OTX2_FLAG_INTF_DOWN;
>  	rvu_rep_free_cq_rsrc(priv);
> +
> +	priv->reps = NULL;
> +	/* Wait for any in-flight rvu_rep_state_evt_handler() using the old
> +	 * reps snapshot to finish before freeing the entries below.
> +	 */
> +	flush_work(&priv->mbox.mbox_up_wrk);

[Severity: High]
This isn't a bug introduced by this patch, but is rep->stats_wrk ever
cancelled before the rep is freed?

rvu_rep_get_stats64() does:

	schedule_delayed_work(&rep->stats_wrk, msecs_to_jiffies(100));

stats_wrk lives inside rep_dev, which lives inside the netdev, and only
mbox_up_wrk is flushed here.

If stats are read shortly before teardown, could rvu_rep_get_stats() run
after free_netdev() and dereference rep->mdev and rep->stats in freed
memory? Does this loop need a cancel_delayed_work_sync(&rep->stats_wrk)?

>  	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
> -		rep = priv->reps[rep_id];
> +		rep = reps[rep_id];
>  		unregister_netdev(rep->netdev);
>  		rvu_rep_devlink_port_unregister(rep);
>  		free_netdev(rep->netdev);
>  		kfree(rep->flow_cfg);

[Severity: High]
This is a pre-existing issue, but is rep still valid at this point?

In rvu_rep_create(), rep comes from netdev_priv(ndev), so it is part of
the net_device allocation. After free_netdev(rep->netdev), doesn't
kfree(rep->flow_cfg) read the pointer out of freed memory?

Since this loop is being changed, could kfree(rep->flow_cfg) move before
free_netdev()? flow_cfg->flow_ent also doesn't seem to be freed anywhere.

>  	}
> -	kfree(priv->reps);
> +	kfree(reps);
>  	rvu_rep_rsrc_free(priv);
>  }

[Severity: High]
This is also a pre-existing issue, but can rvu_rep_rsrc_free() dereference
a NULL priv->netdev?

rvu_rep_probe() allocates priv with devm_kzalloc(), and priv->netdev is
only set in rvu_rep_setup_tc_cb(). rvu_rep_free_cq_rsrc() disabled NAPI,
but the rep netdevs could still transmit until unregister_netdev(). Then:

rvu_rep_rsrc_free()
  otx2_free_hw_resources()
    otx2_cleanup_tx_cqes()
        txq = netdev_get_tx_queue(pfvf->netdev, qidx);

With TX CQEs pending, tx_pkts > 0, so this dereferences a NULL
priv->netdev. If TC setup ran earlier, it instead uses a rep netdev that
has already been freed.

otx2_tx_napi_handler() uses pfvf->reps[qidx]->netdev when
OTX2_FLAG_REP_MODE_ENABLED is set, but the cleanup path doesn't.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928034213.3173088-1-nshettyj%40marvell.com
