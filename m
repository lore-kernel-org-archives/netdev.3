Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80823B8BC7;
	Fri,  4 Sep 2026 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517137; cv=none; b=sKv//VpJ7t9S7o8ZK4ULbltqYlAukd3kueRGXd/jBRHzyIptzcpMNiimFyWQqttJEZbjPY4ITV5KUG8sLHUPVlSum/iX/e6Fn4ccoPYIBn52GvrqQpn6s0Ix5+3VvTjQt1nwRyx8aFdg/9SFMIJiau8yCBzrPNb1hSfwx2DzqEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517137; c=relaxed/simple;
	bh=UTiHfam/BXYHVzWBbjtpWQEbsmQIPFk/vzfvzbOCCek=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YfM9V59432WxwNFc5qsmFYqyBrLUiMjeorEvFiH3jR3YWEuaajzNUOgtuKlTOILeMWmjPjKXGvPxlUeMT6RaW3+NyUT/ekXtEYoibIW9HtDJ6zgWBhD1EW/rGuXkmhPIxlLAu2Sl09btp8vf6bDpIy+Nc8dIpXE5oYjWuXV5vOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqgomdUn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqgomdUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C11B1F00A3F;
	Fri,  4 Sep 2026 10:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517133;
	bh=hDBuWwPYCooxhMECp/DXXKliz2FpesAijNCrOfidgP0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mqgomdUn2bHUzCcInoTSvkRRpgUgTkduaoaeO5X0H2e9SxDfytdK+7Qu2gQNSWfEx
	 82lzGM7INjXx6zVoLomUeJWWHjLjfK3SuUUz/77a6lrk35xQd+NIweQRZ81ceq0jEn
	 vvHzCvPY+C9GzTen7sjsyqs8gQzC//8K8BigUDqm3Yu3lAkMW+eG5TxRfZwifYsUfn
	 PNqd1tPGi8FCi+frjLaR3mrrvgonH630QcwbrJ3lDBiw68QPlXG0ujVqHOS+vIdunJ
	 H4jyqH8kok92Ag3CGA58LkwHOKRwunad3tdZmexNhb+ac+3JYh56vGzYcm0qHofyCR
	 feXraBIKZVyWg==
Subject: Re: [PATCH net-next 6/7] bnge: Create NQ0 during probe and keep
 active across open/close
From: netdev-bot+sashiko@kernel.org
To: bhargava.marreddy@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
 rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com
Date: Fri, 04 Sep 2026 10:18:51 +0000
Message-ID: <178851713172.4131868.2938332104164915242@kernel.org>
In-Reply-To: <20260901191728.643212-7-bhargava.marreddy@broadcom.com>
References: <20260901191728.643212-7-bhargava.marreddy@broadcom.com>
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
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 5 · Low: 1

- [High] bn->grp_info is now probe-lifetime state (allocated only via
  bnge_init_ring_grps(bn, true) in bnge_netdev_alloc(); reopen passes…
- [High] bnge_setup_nq0() freezes NQ0's ring->map_idx at probe to
  bnge_aux_get_msix(bd) (== bd->aux_num_msix, call it A), allocates the…
- [Medium] Commit message omits two load-bearing behavioural changes and
  actively asserts the opposite.
- [Medium] bnge_close_core() calls bnge_quiesce_nq0() only *after*
  bnge_shutdown_nic().
- [Medium] bnge_setup_nq0() treats failure to install the optional IRQ
  affinity *hint* as fatal, so on CONFIG_SMP=n kernels every bnge probe…
- [Medium] The new unconditional NQ0 setup dereferences bn->bnapi[0] and
  bd->irq_tbl[bnge_aux_get_msix(bd)] without checking that at least one…
- [Medium] bnge_free_nq0() frees the NQ0 hardware ring and invalidates
  its ring ids while NQ0's NAPI is still enabled and pollable.
- [Low] bnge_free_nq0() contains two comments that contradict
  bnge_setup_nq0(), and the branch one of them justifies is both dead…

--

bnge: Create NQ0 during probe and keep active across open/close

This moves NQ0 creation into probe via bnge_setup_nq0() and frees it in
bnge_free_nq0() at remove, and teaches the open/close ring, IRQ and NAPI
helpers to skip NQ0 once BNGE_NAPI_FLAG_NQ0 is set.  It also adds a guard
in bnge_napi_poll() for completions of rings freed by bnge_free_nq_tree().

A few questions about the new NQ0 lifetime below.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index 10d54568f2c56..d11c404acd4e2 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c

[ ... ]

> @@ -592,6 +599,9 @@ static void bnge_quiesce_nq0(struct bnge_net *bn)
>  	if (!BNGE_NQ0_NAPI(bnapi))
>  		return;
>  
> +	if (test_and_set_bit(BNGE_NAPI_FLAG_NQ0_QUIESCED, &bnapi->flags))
> +		return;
> +
>  	ring = &nqr->ring_struct;
>  	bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
>  	synchronize_irq(bd->irq_tbl[ring->map_idx].vector);
> @@ -606,6 +616,9 @@ static void bnge_resume_nq0(struct bnge_net *bn)
>  	if (!BNGE_NQ0_NAPI(bnapi))
>  		return;
>  
> +	if (!test_and_clear_bit(BNGE_NAPI_FLAG_NQ0_QUIESCED, &bnapi->flags))
> +		return;
> +
>  	napi_enable_locked(&bnapi->napi);
>  	bnge_db_nq_arm(bn, &nqr->nq_db, nqr->nq_raw_cons);
>  }

[Severity: Medium]
The changelog says:

    The previous patch already added the bnge_quiesce_nq0()/bnge_resume_nq0()
    guard around bnge_free_core()'s teardown and bnge_alloc_core()'s rebuild,
    so NQ0 is safe to leave active across close/open from the moment
    BNGE_NAPI_FLAG_NQ0 is set below.

That reads as though no further quiesce work was needed, but this patch also
adds the new BNGE_NAPI_FLAG_NQ0_QUIESCED bit and a second bnge_quiesce_nq0()
call in bnge_close_core().  Could the changelog describe both?

The new bit looks load bearing rather than cosmetic.  bnge_close_core() now
does:

    bnge_quiesce_nq0(bn);
    ...
    bnge_free_core(bn);        /* calls bnge_quiesce_nq0() again */

Without the test_and_set_bit() guard, would the second call reach
napi_disable_locked() on an already disabled NAPI and spin forever in:

    net/core/dev.c:napi_disable_locked() {
        while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
            usleep_range(20, 200);
            val = READ_ONCE(n->state);
        }
    }

since nothing clears SCHED/NPSVC for an already disabled NAPI?  A backport
or split that keeps the earlier bnge_free_core() quiesce but drops this bit
would then hang on every "ip link set down".

Separately, the quiesce issued in bnge_close_core() is matched by the
bnge_resume_nq0() at the tail of bnge_free_core(), i.e. NQ0's NAPI is only
re-enabled because bnge_free_core() happens to be the last statement of
bnge_close_core().  Is that cross-function pairing intentional?  An early
return in bnge_free_core(), or any close path that does not end there, would
leave NQ0's NAPI disabled for good and silently defeat the async-event
handling this series adds.

> @@ -658,11 +671,13 @@ static int bnge_alloc_nq_tree(struct bnge_net *bn)
>  		nqr->bnapi = bnapi;
>  		ring = &nqr->ring_struct;
>  
> -		rc = bnge_alloc_ring(bd, &ring->ring_mem);
> -		if (rc)
> -			goto err_free_nq_tree;
> +		if (!BNGE_NQ0_NAPI(bnapi)) {
> +			rc = bnge_alloc_ring(bd, &ring->ring_mem);
> +			if (rc)
> +				goto err_free_nq_tree;
>  
> -		ring->map_idx = ulp_msix + i;
> +			ring->map_idx = ulp_msix + i;
> +		}
>  
>  		if (i < bd->rx_nr_rings) {
>  			cp_count++;

[ ... ]

> @@ -2612,6 +2648,9 @@ static void bnge_hwrm_ring_free(struct bnge_net *bn, bool close_path)
>  		for (j = 0; j < nqr->cp_ring_count && nqr->cp_ring_arr; j++)
>  			bnge_hwrm_cp_ring_free(bn, &nqr->cp_ring_arr[j]);
>  
> +		if (BNGE_NQ0_NAPI(bnapi))
> +			continue;
> +
>  		ring = &nqr->ring_struct;
>  		if (ring->fw_ring_id != INVALID_HW_RING_ID_32BIT) {
>  			hwrm_ring_free_send_msg(bn, ring,
> @@ -2673,6 +2712,9 @@ static void bnge_free_irq(struct bnge_net *bn)
>  	for (i = 0; i < bd->nq_nr_rings; i++) {
>  		int map_idx = bnge_cp_num_to_irq_num(bn, i);
>  
> +		if (BNGE_NQ0_NAPI(bn->bnapi[i]))
> +			continue;
> +
>  		irq = &bd->irq_tbl[map_idx];
>  		if (irq->requested) {
>  			if (irq->have_cpumask) {
> @@ -2701,6 +2743,9 @@ static int bnge_request_irq(struct bnge_net *bn)
>  		int map_idx = bnge_cp_num_to_irq_num(bn, i);
>  		struct bnge_irq *irq = &bd->irq_tbl[map_idx];
>  
> +		if (BNGE_NQ0_NAPI(bn->bnapi[i]))
> +			continue;
> +
>  		rc = request_irq(irq->vector, irq->handler, 0, irq->name,
>  				 bn->bnapi[i]);
>  		if (rc)

[ ... ]

> @@ -3237,6 +3289,8 @@ static void bnge_close_core(struct bnge_net *bn)
>  	clear_bit(BNGE_STATE_STATS_ENABLE, &bn->state);
>  	spin_unlock_bh(&bn->stats_lock);
>  
> +	bnge_quiesce_nq0(bn);
> +
>  	bnge_free_all_rings_bufs(bn);
>  	bnge_free_irq(bn);
>  	bnge_del_napi(bn);

[Severity: Medium]
Is it safe to quiesce NQ0 only after bnge_shutdown_nic()?  In
bnge_close_core() the order is now:

    bnge_shutdown_nic(bn);
    bnge_disable_napi(bn);        /* skips NQ0 */
    ... stats ...
    bnge_quiesce_nq0(bn);

Because this patch makes bnge_disable_int()/bnge_disable_int_sync() and
bnge_disable_napi() skip NQ0, NQ0's doorbell stays armed, its IRQ is never
synchronized and its NAPI stays enabled across bnge_shutdown_nic() ->
bnge_hwrm_resource_free() -> bnge_hwrm_ring_free(), which still releases
NQ0's completion rings in firmware because the new "continue" sits after the
cp_ring_arr loop:

    for (j = 0; j < nqr->cp_ring_count && nqr->cp_ring_arr; j++)
        bnge_hwrm_cp_ring_free(bn, &nqr->cp_ring_arr[j]);

    if (BNGE_NQ0_NAPI(bnapi))
        continue;

That is the case the comment just above bnge_disable_int_sync() in
bnge_hwrm_ring_free() warns about:

    /* The completion rings are about to be freed.  After that the
     * IRQ doorbell will not work anymore.  So we need to disable
     * IRQ here.
     */

In that window, can an NQ0 interrupt still take a CQ notification for a ring
firmware has already released, set cpr->had_nqe_notify/toggle, run
__bnge_poll_work() and then write that ring's doorbell from
__bnge_poll_cqs_done()?

The stray-completion guard added to bnge_napi_poll() does not seem to cover
this window, since nqr->cp_ring_arr is still non-NULL and nqr->cp_ring_count
is unchanged until bnge_free_core() -> bnge_free_nq_tree() runs later.  Would
moving bnge_quiesce_nq0() ahead of bnge_shutdown_nic() close it?

[ ... ]

> @@ -3467,6 +3521,159 @@ static void bnge_init_ring_params(struct bnge_net *bn)
>  	bn->netdev->cfg->hds_thresh = max(BNGE_DEFAULT_RX_COPYBREAK, rx_size);
>  }
>  
> +static void bnge_free_nq0(struct bnge_net *bn)
> +{
> +	struct bnge_nq_ring_info *nqr;
> +	struct bnge_ring_struct *ring;
> +	struct bnge_dev *bd = bn->bd;
> +	struct bnge_napi *bnapi;
> +	struct bnge_irq *irq;
> +
> +	bnapi = bn->bnapi[BNGE_NQ0_NAPI_IDX];
> +	nqr = &bnapi->nq_ring;
> +	ring = &nqr->ring_struct;
> +	irq = &bd->irq_tbl[ring->map_idx];
> +
> +	if (!BNGE_NQ0_NAPI(bnapi)) {
> +		/* A previous bnge_setup_nq0() could have failed
> +		 * leaving behind an active irq.
> +		 */
> +		goto free_irq;
> +	}
> +
> +	clear_bit(BNGE_NAPI_FLAG_NQ0, &bnapi->flags);
> +	clear_bit(BNGE_NAPI_FLAG_NQ0_QUIESCED, &bnapi->flags);
> +
> +	/* Unlike the other NQs, NQ0's NAPI is left enabled by bnge_disable_napi()
> +	 * so it can keep processing async events while the interface is
> +	 * administratively down. It is explicitly disabled below, or was never
> +	 * enabled if netdev was never opened (netif_napi_add default).
> +	 */

[Severity: Low]
Are these two comments accurate?

For the second one, bnge_setup_nq0() always runs napi_enable_locked() before
set_bit(BNGE_NAPI_FLAG_NQ0, ...), and it runs from bnge_netdev_alloc() before
register_netdev(), so whenever the flag is set the NAPI is enabled whether or
not the netdev was ever opened.  Is the "was never enabled if netdev was
never opened" case reachable?

For the first one, which state can leave "an active irq" behind with the flag
clear?  bnge_setup_nq0() runs once, every failure after request_irq() goes
through err_free_irq/err_del_napi which call free_irq() and clear
irq->requested, and bnge_netdev_alloc() jumps to err_free_ring_grps rather
than err_free_nq0 when bnge_setup_nq0() fails:

    rc = bnge_setup_nq0(bn);
    if (rc)
        goto err_free_ring_grps;

So both callers of bnge_free_nq0() only reach it with BNGE_NAPI_FLAG_NQ0 set,
making the goto dead code.  If it ever did become reachable it would act on
the wrong resources, since irq is computed from ring->map_idx before the flag
test, and map_idx is only assigned after the descriptor and ring allocations
succeed, so it would be 0 from the zeroed bnapi, which is an aux/RoCE vector
whenever bnge_aux_get_msix(bd) > 0.

> +	bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
> +	synchronize_irq(irq->vector);
> +
> +	hwrm_ring_free_send_msg(bn, ring,
> +				RING_FREE_REQ_RING_TYPE_NQ,
> +				INVALID_HW_RING_ID);
> +	ring->fw_ring_id = INVALID_HW_RING_ID;

[Severity: Medium]
Can the firmware NQ be freed here while NQ0's NAPI is still enabled and
pollable?  Only bnge_db_nq() plus synchronize_irq() run before
hwrm_ring_free_send_msg(); napi_disable_locked() happens much later, and only
inside the "if (irq->requested)" block below.

synchronize_irq() waits for bnge_msix(), not for a poll that handler already
scheduled, and the poll re-arms the NQ on the way out:

    drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:bnge_napi_poll() {
        ...
        nqr->nq_raw_cons = raw_cons;
        if (napi_complete_done(napi, work_done))
            BNGE_DB_NQ_ARM(bd, &nqr->nq_db, nqr->nq_raw_cons);
        ...
    }

With a poll still active, would hwrm_ring_free_send_msg() run concurrently
with code that keeps consuming NQ entries of the ring firmware just released,
writes NQ doorbells from the stale db_key/xid, and updates nqr->nq_raw_cons?
Async events dispatched from bnge_hwrm_handler() -> bnge_queue_sp_work() in
that window also land before the timer_shutdown_sync()/cancel_work_sync() in
bnge_netdev_free().

bnge_quiesce_nq0() already uses the other order, db_nq -> synchronize_irq ->
napi_disable_locked(), before touching any ring state.  Should bnge_free_nq0()
do the same before the HWRM free?

> +	bn->grp_info[0].nq_fw_ring_id = INVALID_HW_RING_ID;

[Severity: High]
Can bn->grp_info be NULL here?

bn->grp_info is now probe lifetime state: it is allocated only by
bnge_init_ring_grps(bn, true) from bnge_netdev_alloc(), and the open path
passes irq_re_init == false and dereferences it without reallocating.  But
bnge_init_nic()'s error path still frees it:

    err_free_ring_grps:
        bnge_free_ring_grps(bn);        /* kfree(bn->grp_info); bn->grp_info = NULL; */
        bnge_free_rx_ring_pair_bufs(bn);
        return rc;

After one failed "ip link set up" (any bnge_init_chip() HWRM failure such as
stat ctx alloc, ring alloc, vnic alloc or vnic filter) bn->grp_info stays NULL
for the life of the device while the netdev remains registered.  Then:

  - remove/unbind runs bnge_netdev_free() -> bnge_free_nq0(), and this new
    unconditional store writes through a NULL bn->grp_info

  - a later reopen calls bnge_init_ring_grps(bn, false), which skips the
    allocation and writes bn->grp_info[i].fw_grp_id through NULL

  - NQ0's preserved firmware ring id, the value hwrm_ring_alloc_send_msg()
    uses as req->nq_ring_id for HWRM_RING_ALLOC_CMPL, is lost, so the
    CQ-to-NQ0 association breaks

Should the open error path stop freeing grp_info now that it outlives open,
or should this store be guarded?

> +
> +free_irq:
> +	if (irq->requested) {
> +		if (irq->have_cpumask) {
> +			irq_set_affinity_hint(irq->vector, NULL);
> +			free_cpumask_var(irq->cpu_mask);
> +			irq->have_cpumask = 0;
> +		}
> +		free_irq(irq->vector, bnapi);
> +		irq->requested = 0;
> +
> +		netdev_lock(bn->netdev);
> +		napi_disable_locked(&bnapi->napi);
> +		__netif_napi_del_locked(&bnapi->napi);
> +		netdev_unlock(bn->netdev);
> +
> +		/* We called __netif_napi_del_locked(), we need
> +		 * grace period before freeing napi structures.
> +		 */
> +		synchronize_net();
> +	}
> +
> +	bnge_free_ring(bd, &ring->ring_mem);
> +	bnge_free_nq_desc_arr(nqr);
> +}
> +
> +static int bnge_setup_nq0(struct bnge_net *bn)
> +{
> +	struct bnge_nq_ring_info *nqr;
> +	struct bnge_ring_struct *ring;
> +	struct bnge_dev *bd = bn->bd;
> +	struct bnge_napi *bnapi;
> +	struct bnge_irq *irq;
> +	int map_idx, rc;
> +
> +	bnapi = bn->bnapi[BNGE_NQ0_NAPI_IDX];
> +	if (BNGE_NQ0_NAPI(bnapi))
> +		return 0;

[Severity: Medium]
Should this check that a network NQ exists before indexing bn->bnapi[0]?

bnge_alloc_irqs() accepts the equality case:

    if (irqs_demand < 0 || irqs_demand < aux_msix) {
        rc = -ENODEV;
        goto err_free_irqs;
    }
    ...
    rc = bnge_adjust_rings(bd, &bd->rx_nr_rings, &bd->tx_nr_rings,
                           irqs_demand - aux_msix, min == 1);

so when pci_alloc_irq_vectors() returns exactly aux_msix vectors,
bnge_adjust_rings() gets max == 0 and the shared branch of
bnge_fix_rings_count() does:

    *rx = min_t(u16, _rx, max);
    *tx = min_t(u16, _tx, max);

returning success with both counts zero, leaving bd->nq_nr_rings == 0.
bnge_alloc_bnapi_mem() then does a zero sized kzalloc(), which returns
ZERO_SIZE_PTR rather than NULL, and creates no bnapi[0] entry.  Does
bn->bnapi[BNGE_NQ0_NAPI_IDX] then read from ZERO_SIZE_PTR during probe?  The
bd->irq_tbl[bnge_aux_get_msix(bd)] access below would also be one past the
acquired vectors in that case.

> +
> +	nqr = &bnapi->nq_ring;
> +	ring = &nqr->ring_struct;
> +	rc = bnge_alloc_nq_desc_arr(&bnapi->nq_ring, bn->cp_nr_pages);
> +	if (rc)
> +		return -ENOMEM;
> +
> +	bnge_init_nq_ring_struct(bn, nqr);
> +	rc = bnge_alloc_ring(bd, &ring->ring_mem);
> +	if (rc)
> +		goto err_free_nq_desc_arr;
> +
> +	map_idx = bnge_aux_get_msix(bd);
> +	ring->map_idx = map_idx;
> +	irq = &bd->irq_tbl[map_idx];
> +	irq->handler = bnge_msix;

[Severity: High]
Is bnge_aux_get_msix(bd) stable enough to freeze NQ0's map_idx here for the
device lifetime?

NQ0's slot is captured once at probe (call it A), used as the firmware
logical_id by hwrm_ring_alloc_send_msg(), used to derive the NQ doorbell in
bnge_set_db(), and claimed with request_irq(irq_tbl[A].vector, ..., bnapi0),
irq_tbl[A].requested = 1 and irq_tbl[A].cpu_mask.  It is never revalidated,
because bnge_hwrm_nq_ring_alloc() returns early for NQ0 and
bnge_alloc_nq_tree() skips the map_idx assignment for NQ0, while all other
NQs recompute ring->map_idx = bnge_aux_get_msix(bd) + i on every open.

bd->aux_num_msix is recomputed on the open path when the aux device is not
registered:

    drivers/net/ethernet/broadcom/bnge/bnge_resc.c:bnge_reserve_rings() {
        if (!bnge_aux_registered(bd)) {
            ...
            resv_msix = hw_resc->resv_irqs - bd->nq_nr_rings;
            aux_msix = min_t(u16, resv_msix, aux_msix);
            bnge_aux_set_msix_num(bd, aux_msix);
        }
    }

If the new base B is smaller than A, does ring i == A - B get handed NQ0's
slot?  bnge_request_irq() only skips i == 0, so request_irq() would hit NQ0's
already registered vector without IRQF_SHARED, return -EBUSY, and the
err_free_irq path would run bnge_free_irq(), which sees NQ0's
requested/have_cpumask state, drops NQ0's affinity hint, frees NQ0's
cpu_mask, calls free_irq(vector, bn->bnapi[i]) with a mismatched dev_id
(__free_irq() only warns and leaves the action installed) and clears
irq->requested.

After that, bnge_free_nq0() at remove sees "if (irq->requested)" as false, so
it never frees the IRQ and never disables or deletes NQ0's NAPI, while
bnge_remove_one() goes on to bnge_free_irqs() and free_netdev().  Does that
leave an installed handler whose dev_id and napi_struct have been freed?

If the base grows instead, NQ0's frozen slot falls inside
[0, bd->aux_num_msix), which bnge_register_dev()/bnge_fill_msix_vecs() hand
to the RoCE driver as its own vectors while firmware still has NQ0 bound to
that logical_id and doorbell.  Should NQ0's vector be reserved explicitly, or
its map_idx re-derived on open?

[ ... ]

> +	if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
> +		int numa_node = dev_to_node(&bd->pdev->dev);
> +
> +		irq->have_cpumask = 1;
> +		cpumask_set_cpu(cpumask_local_spread(BNGE_NQ0_NAPI_IDX, numa_node),
> +				irq->cpu_mask);
> +		rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
> +		if (rc) {
> +			netdev_warn(bn->netdev,
> +				    "Set affinity failed, IRQ = %d\n",
> +				    irq->vector);
> +			goto err_free_irq;
> +		}
> +	}

[Severity: Medium]
Should a failure to install the optional affinity hint be fatal to probe?

On CONFIG_SMP=n the branch is always entered and the hint always fails:

    include/linux/cpumask.h
    static __always_inline bool zalloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
    {
        cpumask_clear(*mask);
        return true;
    }

    include/linux/interrupt.h
    static inline int irq_set_affinity_hint(unsigned int irq,
                                            const struct cpumask *m)
    {
        return -EINVAL;
    }

So bnge_setup_nq0() takes err_free_irq and returns -EINVAL, which
bnge_netdev_alloc() propagates up to bnge_probe_one(), and the device never
probes on uniprocessor builds.  The same pattern already exists in
bnge_request_irq(), where it only broke bringing the interface up; here it
moves the failure to probe.  Would a netdev_warn() without the goto be
enough?

> +
> +	rc = bnge_hwrm_nq_ring_alloc(bn, BNGE_NQ0_NAPI_IDX);
> +	if (rc)
> +		goto err_free_irq;

[ ... ]

>  int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
>  {
>  	struct net_device *netdev;
> @@ -3594,14 +3801,20 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
>  	if (rc)
>  		goto err_free_bnapi_mem;
>  
> +	rc = bnge_setup_nq0(bn);
> +	if (rc)
> +		goto err_free_ring_grps;
> +
>  	rc = register_netdev(netdev);
>  	if (rc) {
>  		dev_err(bd->dev, "Register netdev failed rc: %d\n", rc);
> -		goto err_free_ring_grps;
> +		goto err_free_nq0;
>  	}
>  
>  	return 0;
>  
> +err_free_nq0:
> +	bnge_free_nq0(bn);
>  err_free_ring_grps:
>  	bnge_free_ring_grps(bn);
>  err_free_bnapi_mem:

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901191728.643212-1-bhargava.marreddy%40broadcom.com
