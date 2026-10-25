Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971839;
	b=SglzW904c/jVkKJI30fqLtaoyQcDyL9EfpF3mYL0fg1/dZ+V11C67PKFMFC/wl/jrcUv
	 NmYH8nmjqRvL8RtbZtva+VPAkq30y+YHNxBxASvoqKMnB5PirMzVh5oAH5Z9b+afPoOs+
	 YnuAcKTZcDNvrXIrAnJNJzg1I/pWSnPNl00LYcQpSdtlqINmNvufcWRzHqTO3z5/8++YF
	 BS3mgn20AK9ffSZvGCE9B/hjJihY8iU1uwfdH6hzJhq+Qw+CxhvKnrP2nxIekiqeQHrew
	 tky1FhlLt1wrEntVIUHjNeJ1bBxTYk1CzeAP5Xrjy+ZEy/6C06hScZZTdj8l6MDKH5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971839;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kJlv9xbE7vS/P+nAyOYEezD1LQMnmzbe4mzJ59IXSzg=;
	b=NDI/yM1ik6n06Y1sgJdJpA8eyzl3NzBOY4PQeJ7AjY7DANnoMauTM79RQUyZ/cePSvxH
	 /cplSFkE+pfOzBSvngZmtana3F7qEfYK35ahja/LpRQUXpwSdURU+I5oryOojxIe8HAVm
	 mjUSmxcyVg2nCms5DfNxDFor0KZSLuIVRgzZnAz1n3NgWTcoklkJElOh1IKoChaIpi6a4
	 Xp73+ixz3UEAYxEkGRuVMWms49+lvlsjXqwZSSn5ti1IRXVcKVGoZXnXvRY3TTd0oypzg
	 r3MTIgAQ0ALuCKB/yGjOA2N5FyLFCkmellTySBd3avHtfyxjFMtMOGsK3Pg/1+zS8vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+lDbPKh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12609606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 23:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+lDbPKh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A0C1F01829;
	Sun, 25 Oct 2026 23:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971838;
	bh=kJlv9xbE7vS/P+nAyOYEezD1LQMnmzbe4mzJ59IXSzg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z+lDbPKht+KY3clm/Jk60fl/KDv44imXMCEO5KrnbjwwaIIjz7N+UUh+SH2Zzr5j/
	 1rNnDbmA2hTEstw2e/4WaPYwM4GT1Qp/kox75ZrFDJVgIGt79T92ZETxh3JLj2S9PB
	 gJUppfr8Kj8mfUWCsKwJQoRKClG9G0qW6O3vhxN4fjCbojFKgwN7KHGl+JTsHcBWnC
	 4C3F7dssGPGZFiw9AzwRODTfn+NJ0jzh57ZPHHyvNK0Pfxf+ryZZ0nX0CYAFaUSvhN
	 Z9zxc1e0uVKA89f96VuoPTC1G2Sxhi0YgN9M8qL0uA+Ip2sY7/wZf2+vf7QfzLMk48
	 eErpH3xl5gm3A==
Subject:
 Re: [PATCH net v5 05/13] ice: call PTP link change only from link events
From: netdev-bot+sashiko@kernel.org
To: jacob.e.keller@intel.com
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, poros@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com,
 anthony.l.nguyen@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org
Date: Sun, 25 Oct 2026 23:43:57 +0000
Message-ID: <179297183738.3134.5666599112368477416@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes?=
 =?utf-8?q?-srcu-v5-5-72289a4ac8eb=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes-?=
 =?utf-8?q?srcu-v5-5-72289a4ac8eb=40intel=2Ecom=3E?=
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] A link speed change while the link stays up no longer re-
  calibrates the PHY timestamp block, and on E825 it no longer…
- [Medium] After a CORER/GLOBR/EMPR reset, non-owner ports' PHY timestamp
  blocks now depend on a single unordered restart from the clock owner,…
- [Medium] The post-rebuild resync in ice_rebuild()
  (ice_main.c:7801-7807) relies on ice_ptp_link_change() to bring the…
- [Medium] After a devlink reload, pf->ptp.port.link_up is stale and can
  leave the PHY timestamp block in the wrong state indefinitely.
- [Low] If ice_ptp_port_phy_restart() fails, an administrative down/up no
  longer retries it.

--

ice: call PTP link change only from link events

This patch stops calling ice_ptp_link_change() from ice_up_complete() and
ice_down(). It seeds the PTP link_up field in ice_init_link(), adds an
early return in ice_ptp_link_change() for when the cached link state
already matches, and adds a resync call at the end of ice_rebuild(). It
also makes E825 call ice_ptp_port_phy_restart() on link down.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3a..910ebdcdde19 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -1144,6 +1144,8 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
>  		ice_set_link(vsi, false);
>  	}
>  
> +	ice_ptp_link_change(pf, link_up);
> +
>  	/* if the old link up/down and speed is the same as the new */
>  	if (link_up == old_link && link_speed == old_link_speed)
>  		return 0;
> @@ -1151,8 +1153,6 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
>  	if (!link_up && old_link)
>  		pf->link_down_events++;
>  
> -	ice_ptp_link_change(pf, link_up);
> -

[Severity: Medium]
If the link speed changes while the link stays up, does the PHY timestamp
block still get restarted?

Before this patch, an up->up event with a new link_speed got past the
"link_speed == old_link_speed" check. It then called
ice_ptp_link_change(pf, true), which always ran ice_ptp_port_phy_restart().

On E82x, that restart reprograms the speed-dependent lane, UIX and PAR-PCS
settings and requeues the Vernier ov_work. On E825 with DPLL enabled, the
call also ran ice_tspll_cfg_synce_ethdiv_e825c(), which computes the CGU_R10
divider from phy.link_info.link_speed.

The new early return in ice_ptp_link_change() only compares up/down:

	if (READ_ONCE(ptp_port->link_up) == linkup)
		goto out_unlock;

ice_link_event() also forces link_up to true whenever the refreshed link
info reports the link as up:

	if (phy_info->link_info.link_info & ICE_AQ_LINK_UP)
		link_up = true;

Say a down LSE is processed after the link has already retrained at a new
speed (ethtool speed change, AN restart). That event is treated as up->up,
and so is the up LSE that follows.

Would the PHY timer keep the calibration for the old speed, and the E825
SyncE output keep the old divider, until the driver next sees a link
toggle? The kernel-doc for ice_start_phy_timer_e82x() and
ice_start_phy_timer_eth56g() says this must be done "whenever the clock
time is initialized or when link speed changes."

This also seems to conflict with the commit message:

  "This sequencing should ensure that any link transition will properly
  update the PTP state to reflect the new mode"

This still appears to be present at the end of the series.

[ ... ]

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
Can pf->ptp.port.link_up go stale across a devlink reload? This seeding
runs only from ice_init() at probe time.

ice_devlink_reinit_up() calls ice_init_hw(), ice_init_dev(), ice_init_pf()
and ice_load(), but never ice_init_link().

Before this patch, reload-down went through
ice_unload() -> ice_unregister_netdev() -> ndo_stop -> ice_down(), which
wrote link_up = false. The next ice_open() then wrote link_up = true via
ice_up_complete(). Neither write happens now.

ice_load() -> ice_init_features() -> ice_ptp_init() then calls
ice_ptp_port_phy_restart() using the link_up value from before the reload.

Suppose the link was up before the reload and is down after it. The PHY
timer is started on a down link. When the link comes back, the up LSE hits
the "link_up == linkup" early return in ice_ptp_link_change(), so the PHY
is never restarted for the negotiated link.

Now suppose the link was down before the reload and came up while LSEs were
not yet re-enabled. ice_ptp_init() stops the PHY, and no LSE edge arrives
to start it again.

In both cases, would PTP timestamping stay wrong or disabled until a
physical link toggle? This still appears to be present at the end of the
series.

>  	ice_check_link_cfg_err(pf,
>  			       pf->hw.port_info->phy.link_info.link_cfg_err);
>  
> @@ -6745,7 +6753,6 @@ static int ice_up_complete(struct ice_vsi *vsi)
>  		ice_print_link_msg(vsi, true);
>  		netif_tx_start_all_queues(vsi->netdev);
>  		netif_carrier_on(vsi->netdev);
> -		ice_ptp_link_change(pf, true);
>  	}

[Severity: Low]
Every administrative up used to retry the PHY restart from here, and this
removes that retry.

If ice_ptp_port_phy_restart() fails because ice_start_phy_timer_e82x() or
ice_start_phy_timer_eth56g() returns an error, Tx timestamps stay disabled
and ov_work is not queued.

Before, an ifdown/ifup, MTU change or ring change called
ice_ptp_link_change(pf, true) again and retried the restart. That call is
gone now. Any later call hits the "link_up == linkup" early return while
the physical link stays up.

A later commit in the series, "ice: E825: stop clearing
PHY_REG_TX_OFFSET_READY", says a link reset (e.g. via ethtool) is the
intended way to recover. The dev_err() in ice_ptp_port_phy_restart() also
says "A link-toggle may recover". So this looks deliberate.

Could the commit message mention that an administrative down/up no longer
retries a failed PHY restart?

[ ... ]

> @@ -7794,6 +7798,14 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
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
After a CORER, GLOBR or EMPR reset, does this call restart the PHY on
non-owner ports?

Before this patch, each PF's VSI rebuild called
ice_up_complete() -> ice_ptp_link_change(pf, true). That restarted the
PF's PHY after its own control and sideband queues had been reinitialized.

Also, ice_down() no longer clears ptp_port->link_up during
ice_prepare_for_reset(), so link_up stays true across the reset.

The only restart left comes from the owner PF's rebuild:

ice_rebuild() (owner PF)
  ice_ptp_rebuild()
    ice_ptp_rebuild_owner()
      ice_ptp_restart_all_phy()
        ice_ptp_port_phy_restart(port)

This path uses ptp_port_to_pf(port)->hw, which is the non-owner PF's own
sideband queue. Each PF handles the reset on its own from its service task
(ice_prepare_for_reset() shuts its control queues down and ice_rebuild()
brings them back up), and nothing orders one PF against another.

If the owner gets to ice_ptp_restart_all_phy() before a non-owner has run
ice_init_all_ctrlq(), the PHY access fails. On E82x, tx.disabled has
already been set by then and ov_work is not queued.

The non-owner's own call here then returns at the "link_up == linkup"
check, because the link was up both before and after the reset. Would
timestamping on that port stay disabled until a physical link toggle?

This still appears to be present at the end of the series.

>  	/* tell the firmware we are up */
>  	err = ice_send_version(pf);
>  	if (err) {
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 1e6ba6bbf6c2..f43918f334e8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1319,6 +1319,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>  
>  	mutex_lock(&pf->adapter->ps_lock);
>  
> +	if (READ_ONCE(ptp_port->link_up) == linkup)
> +		goto out_unlock;
> +
>  	WRITE_ONCE(ptp_port->link_up, linkup);
>  
>  	if (pf->ptp.state != ICE_PTP_READY || pf->hw.reset_ongoing)

[Severity: Medium]
Can the cached link_up drift away from what was actually applied to the
hardware?

link_up is written before the READY/reset_ongoing check, so an event that
skips the PHY action still updates the cache. Nothing on the reset path
(ice_ptp_prepare_for_reset() or ice_ptp_rebuild()) invalidates it.

The first case is an LSE handled while hw->reset_ongoing is set (it is set
without ps_lock in ice_misc_intr()) or while PTP is in ICE_PTP_RESETTING.
link_up is updated but the PHY is not touched.

If the owner's ice_ptp_restart_all_phy() has already run or skipped this
port, the ice_ptp_link_change() call at the end of ice_rebuild() returns
early. The PHY then stays stopped while the link is up.

The second case is PFR. ice_ptp_rebuild() skips the owner restart for
ICE_RESET_PFR:

	if (ice_pf_src_tmr_owned(pf) && reset_type != ICE_RESET_PFR) {
		err = ice_ptp_rebuild_owner(pf);

So if the link does not change, nothing restarts the PHY after a PF reset.

Later in the series, "ice: E822: cancel offset verification work during
reset preparation" adds an unconditional
kthread_cancel_delayed_work_sync(&ptp->port.ov_work) to
ice_ptp_prepare_for_reset() for ICE_MAC_GENERIC, before the PFR early
return. Its justification is "the ice_ptp_link_change() call at the end of
the rebuild".

Also, "ice: E822: keep Tx timestamps disabled during offset calibration"
makes ov_work the only place that clears tx.disabled.

With both of those applied, a PFR while Vernier calibration is still
pending cancels ov_work. The rebuild call then returns at this check
without requeuing it. Would Tx timestamps and the Rx offset stay disabled
until a physical link toggle?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb%40intel.com
