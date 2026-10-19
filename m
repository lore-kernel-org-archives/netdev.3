Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440847;
	b=l7UsFShtUrCMaeVwbKfM7sFplTX1VHs+9Vnng8RqISQmtkhWNH+ygNlRV+2K54Yw9hSq
	 ha4uVnDQ2fK4zoe6mz1XR1a34OIdL8XUSfew58AR0/FYE85E6F7Wm4sp8CimF6PFgUmGt
	 szKZsUosSvi5LNdkG4Derm+D7FMQ8er4ezYV+m/F6RGlvEE0xMQWVk5BSrzzL9zFW0JLr
	 UNpfFcpg8FXjmKKu4S8GJ+ugyNzejnMfnELFtMqQqH0xpEojcm5orlu/jKaKnEKHOz/GX
	 YkSD6qrEA/R8Nat8fl7MF0vQEUDss0qW8aOTDCScj2zM0dAKzM5SyW6uohh0+jKVNNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440847;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zYm0+5vn9vQ0BrFbdiZO5o3qkKlYJ6Cg/sh5Nva+1S0=;
	b=MTOUcUYhNIr6hOm3+Hce8UTPP0a1RJAzqYPOYKFAGFXaqRM5EA1/xAzuyK3MAucrUyTc
	 6WWrBqetwsw42VOicBjKswNZehYUwPucA//9iHSOJ3FGfDQLr+z+K1aXkBa+LEa6wnhCH
	 L5eZMHsLW89cnrUx61RPZ6TOtC8DRsYo756XVp3FrsSzXIDM/4blcVV7z29YZ9ujtNSBO
	 uz4BfqwVwUXMKwZyT+RT0XDlb6lpJxoV7drWEJpJ4cAkVQ7w8IR+oRxARbv61/IQQHc9S
	 iZMJkwNdZ/2vT73n/IFvuqm2ey92s93gGxhg0kstIMqsiAKoo3FkGGoUfsEEqD6l8hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxkD+niN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEC0606A31C
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxkD+niN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060A31F000CA;
	Mon, 19 Oct 2026 20:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792440847;
	bh=zYm0+5vn9vQ0BrFbdiZO5o3qkKlYJ6Cg/sh5Nva+1S0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HxkD+niNfLlJ3I3msWuI5z31AwnaOgcTDElMfumeevk+FJB3LAdM2IkjcnU7mMNLI
	 /W4rL81uO3alDiF8YNlOdDhKWdOVBnGhIOjvEz8KgUpNKRVa6u0Ez3pekybTWsYOwp
	 oqqK00dzQjZ3/FDMGraKRPGZTCeOiRGM/hYjRNRM/3xrURDoT19C0KwhzRURRxL8yU
	 6tKW2qQMLjQtY+ZqDn878cahXAKIHZuhXCurtM51t8cIq8oXy5O9oOWBKbZJa9ibcu
	 H2oX4lNWuD1REdVZYQMQWqhb1Cu+JrMNjT3fsyyyxcaP52g+xFTQQQRDoCQSztb/Se
	 QeKGcH+wxtPdA==
Subject:
 Re: [PATCH net v3 05/14] ice: call PTP link change only from link events
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 poros@redhat.com, jacob.e.keller@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, grzegorz.nitka@intel.com,
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com,
 richardcochran@gmail.com, horms@kernel.org
Date: Mon, 19 Oct 2026 20:14:05 +0000
Message-ID: <179244084553.3135.12829466635546463271@kernel.org>
In-Reply-To: <20261015191102.1174111-6-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-6-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message says the new ice_ptp_link_change() call in
  ice_rebuild() (ice_main.c:7803-7808) exists 'to reflect the current…
- [Medium] This patch removes ice_ptp_link_change(pf, true) from
  ice_up_complete(), which leaves the PTP link state with no resync on…
- [Medium] The new PTP link_up seed is only in ice_init_link()
  (ice_main.c:4817).
- [Medium] ice_ptp_link_change() used to start with `if (pf->ptp.state !=
  ICE_PTP_READY) return;`.
- [Medium] ice_ptp_init() now sets `ptp->state = ICE_PTP_READY`
  (ice_ptp.c:3425) before the PHY restart and before…
- [Low] The comment above ice_ptp_rebuild() in ice_rebuild() still says
  'PTP init needs to happen before the VSI rebuild.

--

ice: call PTP link change only from link events

This patch stops calling ice_ptp_link_change() from ice_up_complete() and
ice_down(). Instead it seeds the PTP link_up field in ice_init_link() and
resyncs it from ice_rebuild(). ice_ptp_link_change() now records link_up
even when PTP is not ready, and ice_ptp_init() sets ICE_PTP_READY before
it restarts the PHY timestamping block.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3aa..b4ee2cf7cd704 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4810,6 +4810,14 @@ static void ice_init_link(struct ice_pf *pf)
>  
>  	ice_init_link_dflt_override(pf->hw.port_info);
>  
> +	/* Seed PTP link status from current PHY status, since link may
> +	 * already be up (e.g. after PXE boot) without a link-change edge to
> +	 * catch it later.
> +	 */
> +	WRITE_ONCE(pf->ptp.port.link_up,
> +		   !!(pf->hw.port_info->phy.link_info.link_info &
> +		      ICE_AQ_LINK_UP));
> +

[Severity: Medium]
Does the devlink reload path need this seed too?

ice_init_link() is only reached from ice_init() on probe. The reload path
skips it:

ice_devlink_reinit_up()
  ice_init_hw()
  ice_init_dev()
  ice_init_pf()
  ice_load()
    ice_init_features()
      ice_ptp_init()
        ice_ptp_port_phy_restart()

ice_ptp_port_phy_restart() then uses whatever pf->ptp.port.link_up was
left from before the unload, because ice_ptp_release() does not reset it.

While the reload is in progress, the service task is stopped and the
control queues are shut down, so link events are lost. ice_init_hw() then
refreshes the link_info cache with ice_aq_get_link_info(), so no later
ice_link_event() sees a difference.

Before this patch, the ice_ptp_link_change(pf, true) call in
ice_up_complete() fixed a stale value on the next open. That call is now
gone. Say the link was down before devlink dev reload and came up during
the reload. Does PTP then stay at link_up == false until the next physical
link flap or reset? On E82x that means the PHY timer stays stopped and Tx
timestamps are dropped.

> @@ -6745,7 +6753,6 @@ static int ice_up_complete(struct ice_vsi *vsi)
>  		ice_print_link_msg(vsi, true);
>  		netif_tx_start_all_queues(vsi->netdev);
>  		netif_carrier_on(vsi->netdev);
> -		ice_ptp_link_change(pf, true);
>  	}

[Severity: Medium]
With this call removed, can PTP miss a link-up event that is still queued
when the interface is opened?

ice_open_internal() refreshes the cached link_info directly from firmware:

ice_open_internal() {
    ...
	pi = vsi->port_info;
	err = ice_update_link_info(pi);
    ...
}

ice_link_event() compares against that same cache. If nothing changed, it
returns before it reaches ice_ptp_link_change():

ice_link_event() {
    ...
	if (link_up == old_link && link_speed == old_link_speed)
		return 0;
    ...
	ice_ptp_link_change(pf, link_up);
    ...
}

Take an admin-down netdev whose PTP link_up is false from an earlier
link-down event. A link-up LSE has been posted to the ARQ but the service
task has not handled it yet:

ice_open()
  ice_open_internal()
    ice_update_link_info()     <- cache now says up
    ice_up_complete()          <- carrier on, PTP not told

service task
  ice_link_event()             <- up == up, returns early

Wouldn't pf->ptp.port.link_up stay false while the physical link is up?

On E82x, ice_ptp_port_phy_restart() would keep the PHY timer stopped.
ice_ptp_process_tx_tstamp() would drop Tx timestamps because link_up is
false. Later in the series the same link_up value gates Tx timestamp
requests, so those requests would be refused instead.

A later ifdown/ifup does not fix this either, because ice_down() and
ice_up_complete() no longer touch PTP. Only a link flap or a reset does.
This seems to contradict the commit message statement that "the link
status will reflect the current state of the physical link". Later
patches in the series leave ice_up_complete() unchanged.

[ ... ]

> @@ -7794,6 +7800,14 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
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

[Severity: High]
When the netdev is administratively down, is link_info re-read from
firmware anywhere before this read?

The commit message says this call is there "to reflect the current link
status in case it changed and an edge was missed during a reset". However,
ice_ena_vsi() only calls ice_open_internal(), and through it
ice_update_link_info(), when netif_running(vsi->netdev) is true.

ice_update_pf_netdev_link() -> ice_get_link_status() only queries firmware
when pi->phy.get_link_info is set. Only the ethtool set_link_ksettings path
sets that flag. Nothing else in ice_rebuild() issues Get Link Status.

If so, for an admin-down interface this call just replays the pre-reset
state:

- the link is down before the reset (PTP link_up == false, PHY stopped)
- the link comes up during the reset, and the LSE is lost while the
  control queues are down
- the cache still says down, so this calls ice_ptp_link_change(pf, false)
- a later ice_open() refreshes the cache to up and turns the carrier on,
  but ice_up_complete() no longer notifies PTP

Wouldn't PTP then stay at link_up == false while the carrier is up, until
another link flap or reset?

The reverse case also looks possible. A stale "up" value makes
ice_ptp_link_change(pf, true) start the PHY timer before the link has
retrained. The real link-up LSE is then suppressed by the unchanged-cache
check in ice_link_event().

The end of the series does not change this code. Would calling
ice_update_link_info(pf->hw.port_info) before computing link_up fix this?

[Severity: Low]
This isn't a bug, but the comment above ice_ptp_rebuild() earlier in
ice_rebuild() still reads:

	/* If the PF previously had enabled PTP, PTP init needs to happen before
	 * the VSI rebuild. If not, this causes the PTP link status events to
	 * fail.
	 */

After this patch the VSI rebuild no longer sends PTP link status updates,
because ice_ptp_link_change() was removed from ice_up_complete() and
ice_down(). The ordering that matters now is that this new
ice_ptp_link_change() call runs after ice_ptp_rebuild() has set
ICE_PTP_READY. Should the comment say that instead?

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 11416e23dadeb..776f211290eca 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -1315,17 +1315,13 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>  	struct ice_ptp_port *ptp_port;
>  	struct ice_hw *hw = &pf->hw;
>  
> -	if (pf->ptp.state != ICE_PTP_READY)
> -		return;
> -
>  	ptp_port = &pf->ptp.port;
>  
>  	mutex_lock(&pf->adapter->ps_lock);

[Severity: Medium]
The state check now comes after mutex_lock(), so every call dereferences
pf->adapter, even after ice_ptp_release() has set ICE_PTP_UNINIT. Can
this touch a freed ice_adapter during removal?

In ice_remove(), the adapter reference is dropped before the service task
is drained:

ice_remove() {
    ...
	ice_adapter_put(pdev);
	ice_deinit_hw(&pf->hw);

	ice_deinit_dev(pf);    <- ice_service_task_stop() happens here
    ...
}

ice_deinit() only sets ICE_SERVICE_DIS. It does not wait for a service
task that is already running. For the last PF on an adapter,
ice_adapter_put() can free the adapter. A service task already inside
ice_link_event() past the ice_get_main_vsi() check could then reach
ice_ptp_link_change() and lock the freed adapter's ps_lock. For example,
the task could be stalled in ice_set_link() AQ traffic.

Before this patch, the early state check made this a no-op once
ice_ptp_release() had run.

The race itself is older: the same window already has a pre-existing use
of the freed VSI from the concurrent service task. What this change adds
is the adapter access. At the end of the series the lock is still taken
unconditionally.

>  
> -	ptp_port->link_up = linkup;
> +	WRITE_ONCE(ptp_port->link_up, linkup);
>  
> -	/* Skip HW writes if reset is in progress */
> -	if (pf->hw.reset_ongoing)
> +	if (pf->ptp.state != ICE_PTP_READY || pf->hw.reset_ongoing)
>  		goto out_unlock;

[ ... ]

> @@ -3426,7 +3422,9 @@ void ice_ptp_init(struct ice_pf *pf)
>  	if (err)
>  		goto err_release_tx_tracker;
>  
> -	/* Start the PHY timestamping block */
> +	ptp->state = ICE_PTP_READY;
> +
> +	/* (Re)start the PHY timestamping block */
>  	mutex_lock(&pf->adapter->ps_lock);
>  	ice_ptp_port_phy_restart(&ptp->port);
>  	mutex_unlock(&pf->adapter->ps_lock);
> @@ -3434,8 +3432,6 @@ void ice_ptp_init(struct ice_pf *pf)
>  	/* Configure initial Tx interrupt settings */
>  	ice_ptp_cfg_tx_interrupt(pf);
>  
> -	ptp->state = ICE_PTP_READY;
> -

[Severity: Medium]
Setting ICE_PTP_READY before ice_ptp_cfg_tx_interrupt() runs: can
ndo_hwtstamp_set now race with that call?

ice_ptp_init() runs from ice_load() -> ice_init_features() after
ice_register_netdev(), so the netdev is already visible. The only check in
ice_ptp_hwtstamp_set() is:

	if (pf->ptp.state != ICE_PTP_READY)
		return -EAGAIN;

Both paths end up in ice_ptp_cfg_tx_interrupt(). The user path gets there
through ice_ptp_set_timestamp_mode() -> ice_ptp_restore_timestamp_mode().
The function computes enable from pf->ptp.tstamp_config.tx_type and then
does an unlocked read-modify-write:

	val = rd32(hw, PFINT_OICR_ENA);
	if (enable)
		val |= PFINT_OICR_TSYN_TX_M;
	else
		val &= ~PFINT_OICR_TSYN_TX_M;
	wr32(hw, PFINT_OICR_ENA, val);

ice_ptp_init() runs under devl_lock and the ndo runs under rtnl/netdev
locking, so nothing keeps the two apart. In ICE_PTP_TX_INTERRUPT_SELF
mode:

ice_ptp_init()                        ice_ptp_hwtstamp_set()
  enable = false (tx_type OFF)
                                        tx_type = HWTSTAMP_TX_ON
                                        sets PFINT_OICR_TSYN_TX_M
  rd32(PFINT_OICR_ENA)
  clears PFINT_OICR_TSYN_TX_M
  wr32(PFINT_OICR_ENA)

Wouldn't the config then report HWTSTAMP_TX_ON while the Tx timestamp
interrupt is masked? Tx timestamps would then time out until the next
hwtstamp_set or reset.

Before this patch, hwtstamp_set returned -EAGAIN until init had finished
ice_ptp_cfg_tx_interrupt(). The end of the series keeps the new ordering.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015191102.1174111-1-anthony.l.nguyen%40intel.com
