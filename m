Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE2538C2D1
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521141; cv=none; b=LhswtTBFcd09Pcdxe1IU4mLMuFOxbx4Tha4c3thjz/zO+oOdYn1duVG280PjS5UlMjOmMna2aL25tuyQX0A0tnD/nG1uRNERReJ46efRgNw0O/3oUFrz9guY6Os75ICTiTQ4XSgI6SB6ikF0DMqjExbKlTSqr0HZZX4HHpmy/A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521141; c=relaxed/simple;
	bh=hSYmJwoWTNhZsgbOBF/ROkeJFa7xQJWgZ6GHokMtqO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFzI+0Yb0YOvos9L3dEqo04iRj6QW5sV+nTr0K+brypkezIj0qGb98JD4XzkmLhm8DJOdkMA5fdUy/OGkgZ1Uay5gw/hoM+geEpdFpKdpuLbTlRtpLfXsPMkJkZ+Aymg2e8a+aylqizL3r1LnvfHTGr5wgczlAxi+w0dwreY9WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EK/yuFvS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EK/yuFvS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB83A1F000FF;
	Wed, 16 Sep 2026 01:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521139;
	bh=BedP/Q5oSFj6KVVFu2tehb67HWGjDTKMUUvxiAaBNY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EK/yuFvSQMBCCfQRZIVe1Fcy48TlUlS+uFK3nNn4dpm1TztQV1k0SlEQkgs8hnTuf
	 lPK+oKrIKUACNGAkdrcIk3Pxl8DMeNJ86izgyt+SHCLzffAbLW2b3NgDb8hiWngjFI
	 QGYJHDN4GtsOEUjGkooKvGz+QMwh0krzvWIObETEOH06KfucdT65lp3N9r/ntwQAKB
	 y0Xt4H7hykjdjrFlImlnf49gvp1MB8C3zUtWaScSMoXaay3JPsjEIw9igln7yJvDVr
	 Gc+rUvo4Yy7sshkt8UwCcQl2wG1RCteL5tO7/zuF+9QCAjv1zNREAkO/RA2G4oJrJX
	 ZrLhI1PjHGQpg==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	maciej.machnikowski@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.korba@intel.com,
	grzegorz.nitka@intel.com,
	sergey.temerkhanov@intel.com,
	arkadiusz.kubalewski@intel.com,
	poros@redhat.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	pmenzel@molgen.mpg.de,
	aleksandr.loktionov@intel.com,
	alexander.nowlin@intel.com
Subject: Re: [PATCH net 06/15] ice: call PTP link change only from link events
Date: Tue, 15 Sep 2026 18:12:18 -0700
Message-ID: <20260916011218.1632528-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911003430.3386340-7-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-7-anthony.l.nguyen@intel.com>
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
ice: call PTP link change only from link events

The patch drops the ice_ptp_link_change() calls from ice_up_complete() and
ice_down() so that only the admin queue link event handler drives PTP link
state, seeds ptp_port->link_up during ice_ptp_init(), and re-checks the link
state at the end of ice_rebuild(). The PTP kworker creation is also moved
earlier in ice_ptp_init(), with the periodic work queued only once the state
is ICE_PTP_READY.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3aa..f32041dd8b274 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c

[ ... ]

> @@ -7273,7 +7272,6 @@ int ice_down(struct ice_vsi *vsi)
>  
>  	if (vsi->netdev) {
>  		vlan_err = ice_vsi_del_vlan_zero(vsi);
> -		ice_ptp_link_change(vsi->back, false);
>  		netif_carrier_off(vsi->netdev);
>  		netif_tx_disable(vsi->netdev);
>  	}

[ ... ]

> @@ -7794,6 +7792,14 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
>  
>  	ice_update_pf_netdev_link(pf);
>  
> +	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) && pf->hw.port_info) {
> +		bool link_up;
> +
> +		link_up = !!(pf->hw.port_info->phy.link_info.link_info &
> +			     ICE_AQ_LINK_UP);
> +		ice_ptp_link_change(pf, link_up);
> +	}
> +

[Severity: High]
Does this re-create, in the reset path, the same double PHY
re-initialization that the changelog describes as problem 1?

With the ice_ptp_link_change(vsi->back, false) call gone from ice_down(),
nothing clears ptp_port->link_up during reset preparation.  The only
remaining writers of that field are the store in ice_ptp_link_change() and
the new seed in ice_ptp_init().

ice_prepare_for_reset() calls ice_pf_dis_all_vsi() -> ice_down() before
ice_ptp_prepare_for_reset(), so previously link_up was cleared while the
state was still ICE_PTP_READY and the local port was skipped here:

ice_ptp_restart_all_phy()
	if (port->link_up)
		ice_ptp_port_phy_restart(port);

Now link_up survives the reset, so ice_rebuild() -> ice_ptp_rebuild() ->
ice_ptp_rebuild_owner() -> ice_ptp_restart_all_phy() does a real restart of
the local port, and then the block added above calls
ice_ptp_link_change(pf, true), which re-enters ice_ptp_port_phy_restart() a
second time within the same ice_rebuild().

For ICE_MAC_GENERIC that second entry does:

ice_ptp_port_phy_restart()
	kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
	...
	ptp_port->tx.calibrating = true;
	...
	err = ice_start_phy_timer_e82x(hw, port);

which cancels the offset verification work queued milliseconds earlier by
the first restart, re-asserts calibrating and restarts the timer.  On
ICE_MAC_GENERIC_3K_E825 it re-runs ice_start_phy_timer_eth56g(), i.e. a PHY
soft reset, timer stop, incval reprogram, PHC resync and clearing/setting of
the offset-ready bits.

Neither guard in ice_ptp_link_change() short-circuits this call:
ice_reset_subtask() clears pf->hw.reset_ongoing right before ice_rebuild(),
and ice_ptp_rebuild() has already set the state to ICE_PTP_READY earlier in
ice_rebuild().

One more question on the same block: ice_ptp_link_change() discards the
return value of ice_ptp_port_phy_restart(), and the E825 restart begins by
stopping the timer.  If the redundant second attempt fails, can it leave a
previously working PHY timer stopped, at a point where
ice_update_pf_netdev_link() has already turned the carrier on and woken the
Tx queues?

Would it be cleaner to have exactly one driver of the post-reset PHY
restart, either ice_ptp_restart_all_phy() or this new block, rather than
both?

>  	/* tell the firmware we are up */
>  	err = ice_send_version(pf);
>  	if (err) {
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 9bf3bac552f11..4dec728e219d8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1323,9 +1323,6 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>  	struct ice_ptp_port *ptp_port;
>  	struct ice_hw *hw = &pf->hw;
>  
> -	if (pf->ptp.state != ICE_PTP_READY)
> -		return;
> -
>  	ptp_port = &pf->ptp.port;
>  
>  	if (!kref_get_unless_zero(&ptp_port->ref))
> @@ -1334,6 +1331,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>  	/* Update cached link status for this port immediately */
>  	ptp_port->link_up = linkup;
>  
> +	if (pf->ptp.state != ICE_PTP_READY)
> +		goto exit_kref_put;
> +

[Severity: High]
Can moving the state check below the store make a half-initialized port
visible to ice_ptp_restart_all_phy()?

ice_ptp_setup_pf() publishes the port before the rest of PTP init runs:

	kref_init(&ptp->port.ref);

	spin_lock(&pf->adapter->ports.lock);
	list_add_rcu(&ptp->port.list_node, &pf->adapter->ports.list);
	spin_unlock(&pf->adapter->ports.lock);

After that, and while pf->ptp.state is still ICE_PTP_INITIALIZING, a link
event reaching ice_ptp_link_change() now sets ptp_port->link_up = true
before returning.  At that point ice_ptp_init_port() may not yet have run
mutex_init(&ptp_port->ps_lock) or spin_lock_init(&tx->lock), and
pf->ptp.kworker is still NULL.

ice_ptp_restart_all_phy() gates only on the kref and the cached flag:

		if (!kref_get_unless_zero(&port->ref))
			continue;
		rcu_read_unlock();

		if (port->link_up)
			ice_ptp_port_phy_restart(port);

and it is reachable from ice_ptp_settime64(), which does no ptp->state check
and ends with:

	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
	if (hw->mac_type == ICE_MAC_GENERIC)
		ice_ptp_restart_all_phy(pf);

The PHC character device already exists at that point, because
ice_ptp_init_owner() -> ice_ptp_create_clock() runs earlier in
ice_ptp_init(), so a clock_settime() on the owner PF, or a reset of the
owner PF concurrent with the probe of a peer PF, can reach it.

On ICE_MAC_GENERIC the restart then does:

		kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
					   0);

with pf->ptp.kworker == NULL, and kthread_queue_delayed_work() starts with
raw_spin_lock_irqsave(&worker->lock, flags).

Before this patch link_up stayed false for the whole of ice_ptp_init()
because ice_ptp_link_change() returned before the store while the state was
not READY, so the port->link_up guard skipped the initializing port.  Should
link_up only be published after the kworker exists and after the port locks
are initialized?

>  	/* Skip HW writes if reset is in progress */
>  	if (pf->hw.reset_ongoing)
>  		goto exit_kref_put;

[ ... ]

> @@ -3443,6 +3444,22 @@ void ice_ptp_init(struct ice_pf *pf)
>  	if (err)
>  		goto err_clean_pf;
>  
> +	/* Seed link_up from current PHY status, since link may already be up
> +	 * (e.g. after PXE boot) with no link-change edge to catch it later.
> +	 */
> +	if (pf->hw.port_info)
> +		ptp->port.link_up =
> +			!!(pf->hw.port_info->phy.link_info.link_info &
> +			ICE_AQ_LINK_UP);

[Severity: Medium]
Is ptp_port->link_up now written from two contexts without any
synchronization?

This seed runs on the probe thread, while ice_ptp_link_change() writes the
same plain bool from the service task via the admin queue link event
handler, and after this patch that store happens before the ICE_PTP_READY
bail-out.  ice_init() clears ICE_SERVICE_DIS and arms pf->serv_tmr before
ice_init_features() calls ice_ptp_init(), so both writers can run
concurrently.

There is no lock, and no WRITE_ONCE/READ_ONCE pairing, between the probe
thread's read of phy.link_info and its store to link_up, so a link
transition processed inside that window is silently dropped.

Link events are edge triggered:

ice_link_event()
	if (link_up == old_link && link_speed == old_link_speed)
		return 0;

so if the surviving value is false while the link is physically up,
ice_ptp_reset_phy_timestamping() -> ice_ptp_port_phy_restart() takes:

	if (!ptp_port->link_up)
		return ice_ptp_port_phy_stop(ptp_port);

and nothing later corrects it.  On E82x the vernier timer would then never
be started and timestamping would stay off until the link physically
toggles.  Note also that ice_ptp_port_phy_restart() reads link_up before
taking ptp_port->ps_lock, so ps_lock does not cover this field.

> +
> +	/* Create the kworker before restarting the PHY, which queues work on
> +	 * it in the E82x restart path. This prevents concurrent link events
> +	 * from reaching ice_ptp_port_phy_restart() while kworker is still NULL
> +	 */
> +	err = ice_ptp_init_work(pf, ptp);
> +	if (err)
> +		goto err_clean_pf;
> +

[Severity: Medium]
This isn't a bug introduced by this patch, but since the unwind path is
being reshuffled here, should err_clean_pf also release the Tx timestamp
tracker?

By the time this new goto err_clean_pf can be taken, ice_ptp_init_port() ->
ice_ptp_init_tx()/ice_ptp_init_tx_e82x() -> ice_ptp_alloc_tx_tracker() has
already allocated:

	tstamps = kzalloc_objs(*tstamps, tx->len);
	in_use = bitmap_zalloc(tx->len, GFP_KERNEL);
	stale = bitmap_zalloc(tx->len, GFP_KERNEL);

but the unwind only does:

err_clean_pf:
	mutex_destroy(&ptp->port.ps_lock);
	ice_ptp_cleanup_pf(pf);

ice_ptp_cleanup_pf() only unlinks the port from the adapter list and drops
the kref, and err_exit then sets ptp->state = ICE_PTP_UNINIT, which makes
ice_ptp_release() return at its first check, so
ice_ptp_release_tx_tracker() never runs.  The same leak existed on the old
err_exit path when ice_ptp_init_work() failed, so this predates the patch;
the trigger is a kthread_run_worker() failure in ice_ptp_init_work().

>  	/* Start the PHY timestamping block */
>  	ice_ptp_reset_phy_timestamping(pf);
>  
> @@ -3451,9 +3468,10 @@ void ice_ptp_init(struct ice_pf *pf)
>  
>  	ptp->state = ICE_PTP_READY;
>  
> -	err = ice_ptp_init_work(pf, ptp);
> -	if (err)
> -		goto err_exit;
> +	/* Start periodic work only after the state is READY; the worker
> +	 * returns without rescheduling while the state is not READY.
> +	 */
> +	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
>  
>  	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
>  	return;
