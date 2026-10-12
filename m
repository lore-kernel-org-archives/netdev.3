Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C3385D87
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846937; cv=none; b=LECUo3vTDmAOU50dpOTc28qR/1AzxJBaplUqbCr9oyn/GUJH9dUV8oNn+4zO2Y62THopd+/znLY4Mz2Lb7CRIyRPZt/814IS5gX0HhfKddnSHMD8OECDDG9JnWSJyeXguXj+DYSLQ8E/Ru+VxHXStWU0Mgj/Mg5XNEIQVBvWinM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846937; c=relaxed/simple;
	bh=oGvz0zo7X6HUniSnXn+WiatwSi28D8tLp1iyoZgJXk4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dn4t1btmBBpOs5ZsOZXut6ergk0DUbYnpyCRPDFcHcvySXMcnm9zcOXgjZMltxgTYxbV7IiI0HGqkMs3LJ5dGhCCuC6BmbBRXMph9gBItzqaLFPhWkoJKwf7LxxG2rNuWmcviDmCnNeswdOO10yFY4ckt073Dm2jcRIAeZsPjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHjD+gvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHjD+gvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210871F008A2;
	Mon, 12 Oct 2026 23:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846936;
	bh=4xz8eXuMmVNWLY855vS03rcMLHuePGaRk7+ZumOKd7E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JHjD+gvfXWVRXvAVfO/aENVyL/MV8B7WLyY8V5fQP/3aUuhOBZ9FoX/5Ahuo2G4yq
	 kzVK99TNmJlZ+oq7qh133RrdD/hj7B0mIplGdTpXN03iqIkFNLNy9U4HkF9SVN/BvC
	 +4SGvtEnWQWoZ8iPnv13G9egVDKXdb7A0JNCU5oQbRroLDriipxk/7xq4thAQeqwfl
	 hXwv+kqRPMAHKDNE9/NnUeKPOtBY7z/dPibX1MqA0Ka+NHsbDBpUndUNvzPOhAnmbC
	 Y8g3DGl7wB3gdLK5Otb7tQ3XwbFfbB6DQrCkFiwTuP8MeBvkbCYVT6JjCLD9z7sZUl
	 QtTyBnfbYoGlw==
Subject:
 Re: [PATCH net v2 15/15] ice: Recalibrate PHY after settime64 on E825-C
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
Date: Mon, 12 Oct 2026 23:15:34 +0000
Message-ID: <179184693471.434549.9184447106002765149@kernel.org>
In-Reply-To: <20261008215614.1987250-16-anthony.l.nguyen@intel.com>
References: <20261008215614.1987250-16-anthony.l.nguyen@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix only partly ports the E82x settime recalibration
  sequence to E825-C.
- [Medium] The new E825-C recalibration call in ice_ptp_settime64() runs
  ice_start_phy_timer_eth56g() after the PTP hardware semaphore has been…
- [Low] On E825-C, ice_ptp_settime64() can return 0 even though PHY
  recalibration failed, and the port is left unable to take Tx timestamp…

--

ice: Recalibrate PHY after settime64 on E825-C

This patch makes ice_ptp_settime64() call ice_ptp_restart_all_phy() on
E825-C (ICE_MAC_GENERIC_3K_E825), as it already did on E822/E823, so the
PHY is recalibrated after the clock time is set. Without this, ptp4l
converges slowly after large time jumps because the PHY timestamps are
incorrect.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 8d302b500a399..a5fe05d704617 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2086,8 +2086,9 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
>  	/* Reenable periodic outputs */
>  	ice_ptp_enable_all_perout(pf);
>  
> -	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
> -	if (hw->mac_type == ICE_MAC_GENERIC)
> +	/* Recalibrate and re-enable timestamp blocks for E822/E823/E825-C */
> +	if (hw->mac_type == ICE_MAC_GENERIC ||
> +	    hw->mac_type == ICE_MAC_GENERIC_3K_E825)
>  		ice_ptp_restart_all_phy(pf);

[Severity: Medium]
Does E825-C get only half of the E82x settime sequence here?

On E82x, ice_ptp_settime64() marks timestamps invalid before it writes
the new time:

	if (hw->mac_type == ICE_MAC_GENERIC) {
		err = ice_ptp_clear_phy_offset_ready_e82x(hw);
		...
	}

That check is still E82x-only. On E825-C, PHY_REG_RX_OFFSET_READY stays
set and tx.calibrating stays false through ice_ptp_write_init(). They
only change later, one port at a time:

ice_ptp_restart_all_phy()
  ice_ptp_port_phy_restart()
    tx.calibrating = true; ice_ptp_mark_tx_tracker_stale()
    ice_start_phy_timer_eth56g()
      ice_stop_phy_timer_eth56g()
        PHY_REG_RX_OFFSET_READY = 0

The window between INIT_TIME and that point covers
ice_ptp_reset_cached_phctime(), ice_ptp_enable_all_perout(), taking
ps_lock, and the full restart of every earlier port in the adapter list.

Each restart calls ice_ptp_phy_soft_reset_eth56g(), which has two
usleep_range(5000, 6000) calls plus a sync. Later ports therefore wait
10 ms or more for each earlier port.

The commit message says the PHY timestamps are incorrect until
recalibration. During this window the cached PHC time has already moved,
and ice_ptp_get_rx_hwts() only checks the valid bit:

	if (!(rx_desc->wb.time_stamp_low & ICE_PTP_TS_VALID))
		return 0;

Could uncalibrated Rx timestamps that still have the valid bit set reach
the stack here?

Tx timestamp requests made in the window could also complete before
that port's ice_ptp_mark_tx_tracker_stale() call.
ice_ptp_reset_cached_phctime() only marks pf->ptp.port.tx stale, not
the other ports in the adapter.

Would it make sense to clear RX_OFFSET_READY and set tx.calibrating on
all E825-C ports before ice_ptp_write_init(), as the E82x path does?

[Severity: Low]
Can a failed E825-C recalibration go unreported here?

In ice_ptp_port_phy_restart(), the ICE_MAC_GENERIC_3K_E825 case does:

		ptp_port->tx.calibrating = true;
		...
		err = ice_start_phy_timer_eth56g(hw, port);
		if (err)
			break;

ice_start_phy_timer_eth56g() clears PHY_REG_RX_OFFSET_READY first and
can fail after that, for example with -EBUSY when ice_ptp_lock() fails,
or on a sideband read/write error. On that path tx.calibrating stays set
and RX_OFFSET_READY is not restored.

ice_ptp_restart_all_phy() returns void and drops the per-port error, so
ice_ptp_settime64() still returns 0 to the PTP core. The only record is
a dev_err() that says "on link-up", even when the call came from
settime.

After that, ice_ptp_is_tx_tracker_up() refuses Tx timestamp requests on
the port:

	return tx->init && !tx->calibrating && READ_ONCE(ptp_port->link_up);

This lasts until a later restart succeeds, for example after a link
toggle.

The ignored return value already existed on the E82x path. This change
makes the failure reachable from clock_settime() and from large
clock_adjtime() calls on E825-C.

Should ice_ptp_restart_all_phy() pass the error back to
ice_ptp_settime64()?

[Severity: Medium]
Can the new E825-C restart from settime race with a concurrent clock
update on the shared source timer command register?

ice_ptp_restart_all_phy() runs after ice_ptp_unlock(), and
ice_start_phy_timer_eth56g() writes GLTSYN_CMD before it takes the PTP
semaphore. On secondary PFs that write goes to the primary hw:

	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
	if (err)
		return err;

	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
	...
	if (!ice_ptp_lock(hw)) {

ice_ptp_tmr_cmd_to_src_reg() maps ICE_PTP_NOP to GLTSYN_CMD_READ_TIME.

At the same time, another caller can hold the semaphore inside
ice_ptp_tmr_cmd(): a second settime, adjtime through ice_ptp_write_adj(),
or adjfine through ice_ptp_write_incval_locked():

	ice_ptp_src_cmd(hw, cmd);

	err = ice_ptp_port_cmd(hw, cmd);
	...
	ice_ptp_exec_tmr_cmd(hw);

Suppose the unlocked NOP write lands between ice_ptp_src_cmd() and
ice_ptp_exec_tmr_cmd(). Wouldn't the source timer then run READ_TIME
while the PHY ports still apply INIT_TIME, ADJ_TIME or INIT_INCVAL?

The concurrent caller would return success but its PHC change would be
lost. Later ice_sync_phy_timer_eth56g() calls would then align the PHYs
to the unchanged PHC.

Nothing serializes these two paths. ptp_clock_settime() and
ptp_clock_adjtime() hold only the posix-clock read-side rwsem, and the
time-write part of settime/adjtime does not take ps_lock.

The unlocked write is older than this patch and could already be reached
from the E825-C link-up restart in ice_ptp_link_change(). This change
adds a path to it from userspace clock_settime() and large
clock_adjtime() calls.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008215614.1987250-1-anthony.l.nguyen%40intel.com
