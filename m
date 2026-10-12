Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154C63D649C
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846925; cv=none; b=eS9FsM4gWTwDd8lNg7GmxMcoCI2OwIw4WIvlc6J9Bo4szUXZq+85Z1tyyxrw3QLXPB+3+cszdl7J8vKyKooPLFxmumNgj7N1gxyGQriC1Nyt/JnviA4KYzneVNNMqvG+4kxas6CkAVXjaq5ZdP+yl6qlTU38Pt9KRmp4hDfnqNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846925; c=relaxed/simple;
	bh=JViVI3vTAhie1ZqSoflKJXH0psTLYSe7lAe7+WlGILs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DNB4GUGE2QMjHvFZ+/8eOZTk4MPDARa73aUfEhRIif1NC8VA6/mqOjUJ4XuEXwh2SUKhtGnvhymMdFZBMbtMIZxgKY0o9Cex6prcShKY+dtiUAU3tZcSBA10HiEhIiO4+iN4GhWb5Gx51xtJU5W9S1adiQtrk0jjYcxkoBXSbPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ainM8qCz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ainM8qCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCCA1F008A2;
	Mon, 12 Oct 2026 23:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846924;
	bh=2kiVjI7COBcC/NEQHzIDppzrirT5d3IbM6gkVhlyd+Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ainM8qCzwhe3kJyGHwIAgXL7YuI1Cvuhd9KWNA5ag573xTVLYXYqcRvYbNEVOQbou
	 HKosk25Akw11+lJW52WjeF4zTl9rTFiznxd2OXTSisVPS6kNwBd2+i4hPLGh7qd7df
	 kI/2bOPSbO7PAi8ZWbakoK2cu9MqNjwrgLqTRcf6g7ZhAqRzZKhJY4cIkCft8k54a/
	 /7Sz/5gSL7d1HyM01ViAyA92TBxf4ZsvMUX0gfzZg0qF3SmutIkZ/zKGsmXVs6KtH2
	 PMgybqS3y7/omnlKlT04LaXa/x5FC4XW5vwak76cBpXDAp8Wv+Z2zazVEm5j0DPv1t
	 VYWZHsgEltxLA==
Subject:
 Re: [PATCH net v2 05/15] ice: call PTP link change only from link events
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 maciej.machnikowski@intel.com, jacob.e.keller@intel.com,
 przemyslaw.korba@intel.com, grzegorz.nitka@intel.com,
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com,
 poros@redhat.com, richardcochran@gmail.com, horms@kernel.org,
 pmenzel@molgen.mpg.de, aleksandr.loktionov@intel.com,
 alexander.nowlin@intel.com
Date: Mon, 12 Oct 2026 23:15:22 +0000
Message-ID: <179184692262.434549.10025168203766414646@kernel.org>
In-Reply-To: <20261008215614.1987250-6-anthony.l.nguyen@intel.com>
References: <20261008215614.1987250-6-anthony.l.nguyen@intel.com>
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

Critical: 0 · High: 1 (1) · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In the non-READY branch of ice_ptp_release() (state ERROR after
  a failed ice_ptp_rebuild_owner(), or RESETTING after a rebuild that…
- [Medium] On E82x, every non-PFR reset (CORER/GLOBR/EMPR) now restarts
  the PHY timestamp block twice.
- [Medium] A link event that arrives during the INITIALIZING window of
  ice_ptp_init() is now lost for good.
- [Medium] Now that the ice_up_complete() call is gone, edge detection in
  ice_link_event() is the only thing that updates PTP link state at…
- [Medium] The new block at the end of ice_rebuild() programs the PTP PHY
  from pf->hw.port_info->phy.link_info.link_info without asking firmware…

Pre-existing issues:
- [High] ice_ptp_init() publishes the port on adapter->ports.list
  (ice_ptp_setup_pf() -> list_add_rcu) before ice_ptp_init_work()…

--

ice: call PTP link change only from link events

This patch removes the ice_ptp_link_change() calls from ice_up_complete()
and ice_down(), so the link event handler is the only runtime source of
PTP link state. It seeds ptp->port.link_up in ice_ptp_init() and adds an
ice_ptp_link_change() call at the end of ice_rebuild(). It also creates
the kworker before the first PHY restart in ice_ptp_init().

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3aa..f32041dd8b274 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -6745,7 +6745,6 @@ static int ice_up_complete(struct ice_vsi *vsi)
>  		ice_print_link_msg(vsi, true);
>  		netif_tx_start_all_queues(vsi->netdev);
>  		netif_carrier_on(vsi->netdev);
> -		ice_ptp_link_change(pf, true);
>  	}

[Severity: Medium]
With this call gone, can PTP miss a link-up that some code other than the
LSE handler notices first?

ice_link_event() only notifies PTP on an edge, and it compares against the
cached pi->phy.link_info:

ice_link_event() {
    ...
	if (link_up == old_link && link_speed == old_link_speed)
		return 0;
    ...
	ice_ptp_link_change(pf, link_up);
}

Other paths refresh that cache with Get Link Status:
ice_open_internal() -> ice_update_link_info(), ice_check_media_subtask()
while ICE_FLAG_NO_MEDIA is set, and ethtool ice_set_link_ksettings().

Here is one sequence:

- The netdev is down and the cable is pulled. PTP link_up becomes false,
  and on E82x ice_ptp_port_phy_stop() stops the PHY timer.
- The cable is plugged back in.
- 'ip link set up' runs before the service task drains the ARQ.

ice_open_internal() then refreshes the cache to up, and ice_up_complete()
turns the carrier on without telling PTP. When the queued LSE is handled,
it sees old == new and returns early.

Would ptp_port->link_up then stay false while carrier is on, until the next
physical link transition? The E82x PHY timer would stay stopped, and
ice_ptp_process_tx_tstamp() would drop every Tx timestamp. Later in the
series, ice_ptp_is_tx_tracker_up() rejects new requests instead. Before
this patch, the open path handled this case.

> @@ -7273,7 +7272,6 @@ int ice_down(struct ice_vsi *vsi)
>  
>  	if (vsi->netdev) {
>  		vlan_err = ice_vsi_del_vlan_zero(vsi);
> -		ice_ptp_link_change(vsi->back, false);
>  		netif_carrier_off(vsi->netdev);
>  		netif_tx_disable(vsi->netdev);
>  	}

[Severity: High]
ice_down() no longer clears link_up during reset preparation, so it stays
true through a failed reset. Can ice_ptp_restart_all_phy() then reach a
port whose kworker has already been destroyed?

ice_ptp_release() has a non-READY branch. It runs in state ERROR after a
failed ice_ptp_rebuild_owner(), or in state RESETTING after a rebuild that
failed early. That branch destroys the worker before it removes the port
from adapter->ports.list:

ice_ptp_release() {
    ...
	kthread_destroy_worker(pf->ptp.kworker);
	pf->ptp.kworker = NULL;
    ...
	ice_ptp_cleanup_pf(pf);
}

ice_ptp_settime64() does not check the PTP state, and on E82x it calls
ice_ptp_restart_all_phy(). If that runs during this window, it takes a
reference on the port, which is still on the list. With link_up true it
then goes down this path:

ice_ptp_settime64()
  ice_ptp_restart_all_phy()
    ice_ptp_port_phy_restart()
      kthread_cancel_delayed_work_sync(&ptp_port->ov_work)
      kthread_queue_delayed_work(pf->ptp.kworker, ...)

The cancel goes through work->worker, which can point at the freed worker.
The queue call passes a NULL worker.

Before this patch, ice_down() cleared link_up from ice_prepare_for_reset(),
so ice_ptp_restart_all_phy() skipped the port.

The order of destroying the worker before removing the port comes from the
earlier patch in this series, "ice: fix removal of PTP timestamp tracker
during reset". This change makes it reachable for ports that had a running
netdev. Can this end in a use-after-free or a NULL dereference in
kthread_queue_delayed_work()?

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

[Severity: Medium]
Does this restart the E82x PHY timestamp block a second time on every
CORER, GLOBR or EMPR?

Before this patch, ice_prepare_for_reset() -> ice_pf_dis_all_vsi() ->
ice_vsi_close() -> ice_down() cleared ptp_port->link_up while the state was
still READY. ice_ptp_restart_all_phy() then skipped the port, and the one
restart came later, from ice_up_complete().

Now link_up keeps its pre-reset value, so the earlier ice_ptp_rebuild()
call already restarts the port:

ice_rebuild()
  ice_ptp_rebuild()
    ice_ptp_rebuild_owner()
      ice_ptp_restart_all_phy()
        if (READ_ONCE(port->link_up))
            ice_ptp_port_phy_restart(port);

That cancels ov_work, sets calibrating, starts the PHY timer and queues
ov_work. Then this new block calls ice_ptp_link_change().

hw.reset_ongoing was already cleared in ice_reset_subtask() before
ice_rebuild() ran, so the HW writes go ahead. On ICE_MAC_GENERIC this calls
ice_ptp_port_phy_restart() again every time. On E825 it does so when
linkup is true:

ice_ptp_link_change() {
    ...
	case ICE_MAC_GENERIC:
		ice_ptp_port_phy_restart(ptp_port);
		break;
    ...
}

So the calibration that was just started is thrown away and started again.
The owner's ice_ptp_restart_all_phy() also restarts the ports of other PFs.
Each of those PFs then restarts its own port again at the end of its own
rebuild.

The commit message names this as the first problem being fixed:

    1. Double initialization on link-up: ice_handle_link_event() calls
       ice_ptp_link_change(true), then ice_up_complete() calls it again.

Does the reset path now get the same kind of double restart?

[Severity: Medium]
Is link_info current at this point after the reset?

ice_update_pf_netdev_link(), just above, uses ice_get_link_status(). That
only sends Get Link Status when phy.get_link_info is set, and in the driver
only ethtool sets that flag:

ice_get_link_status() {
    ...
	if (phy_info->get_link_info) {
    ...
}

During rebuild, the cache is refreshed only when the netdev is running
(ice_ena_vsi() -> ice_open_internal() -> ice_update_link_info()).
ice_init_all_ctrlq() also drops any LSE that was queued before the reset.

So for a netdev that is down, this seeds PTP from the pre-reset snapshot.
If the reset changed the real link state, the E82x/E825 PHY timer can be
set up for the wrong state.

ice_up_complete() no longer notifies PTP. A later open refreshes the cache
without telling PTP, and the next LSE may then match the cache and be
ignored.

The commit message says:

    Initialize the link_up in ice_ptp_init() and ensure that we check and
    restore the link status at the end of the rebuild flow, ensuring that we
    initialize the PHY timer appropriately after a reset.

Should this re-read link_info from firmware before using it? As written, it
restores a cached software value rather than the hardware link status.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index bbb57edcec0f5..220d174397bab 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -3414,8 +3415,23 @@ void ice_ptp_init(struct ice_pf *pf)
>  	if (err)
>  		goto err_release_tx_tracker;
>  
> -	/* Start the PHY timestamping block */
> +	/* Create the kworker before restarting the PHY, which queues work on
> +	 * it in the E82x restart path.
> +	 */
> +	err = ice_ptp_init_work(pf, ptp);
> +	if (err)
> +		goto err_clean_pf;
> +

[Severity: High]
This is a pre-existing issue, but this reorder doesn't fully close the
window it is aimed at. Can another PF still restart this port before
ptp->kworker is assigned?

ice_ptp_setup_pf() adds the port to adapter->ports.list with
list_add_rcu() before ice_ptp_init_work() runs. The kworker is then
assigned without ps_lock.

ice_ptp_release() sets pf->ptp.kworker = NULL but never clears
pf->ptp.port.link_up. ice_unload() also runs ice_deinit_features() before
ice_unregister_netdev(), so ice_down() never clears it either. After a
devlink reload, the PF therefore re-enters ice_ptp_init() with link_up
still true.

The window includes kthread_run_worker() creating a thread. If the E82x
clock owner handles clock_settime during it:

ice_ptp_settime64()
  ice_ptp_restart_all_phy()
    kref_get_unless_zero(&port->ref)   /* succeeds, port is listed */
    if (READ_ONCE(port->link_up))      /* stale true */
        ice_ptp_port_phy_restart(port)
          kthread_queue_delayed_work(pf->ptp.kworker /* NULL */, ...)

then kthread_queue_delayed_work() dereferences a NULL worker. The window
was larger before this patch.

Would creating the kworker before ice_ptp_setup_pf(), or clearing link_up
in ice_ptp_release(), close it?

> +	/* Seed link_up from current PHY status, since link may already be up
> +	 * (e.g. after PXE boot) with no link-change edge to catch it later.
> +	 */
>  	mutex_lock(&pf->adapter->ps_lock);
> +	if (pf->hw.port_info)
> +		WRITE_ONCE(ptp->port.link_up,
> +			   !!(pf->hw.port_info->phy.link_info.link_info &
> +			      ICE_AQ_LINK_UP));
> +
> +	/* Start the PHY timestamping block */
>  	ice_ptp_port_phy_restart(&ptp->port);
>  	mutex_unlock(&pf->adapter->ps_lock);
>  
> @@ -3424,9 +3440,10 @@ void ice_ptp_init(struct ice_pf *pf)
>  
>  	ptp->state = ICE_PTP_READY;
>  

[Severity: Medium]
What happens to a link event that is handled after link_up is seeded above
but before ptp->state is set to ICE_PTP_READY here?

The service task is already running at this point. ice_init() clears
ICE_SERVICE_DIS and arms serv_tmr, and ice_init_link() has already called
ice_phy_cfg(). The window covers ice_ptp_port_phy_restart() and
ice_ptp_cfg_tx_interrupt().

If an LSE is handled in that window, ice_link_event() updates the cached
link_info and calls ice_ptp_link_change(pf, true). That call returns
before it records the new state:

ice_ptp_link_change() {
	if (pf->ptp.state != ICE_PTP_READY)
		return;
    ...
	WRITE_ONCE(ptp_port->link_up, linkup);
    ...
}

Later LSEs then see link_up == old_link in ice_link_event() and return
early. Before this patch, the ice_up_complete() call fixed this on the next
open, but that call is now removed.

Would ptp_port->link_up stay false while the link is up, until the link
flaps or a reset runs? The E82x/E825 PHY timer would never be started, and
Tx timestamps would be dropped at this commit. Later in the series,
ice_ptp_is_tx_tracker_up() rejects new requests instead.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008215614.1987250-1-anthony.l.nguyen%40intel.com
