Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF73E172B
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846926; cv=none; b=F5VFCyqZpiFyr9RSe2FoTyJ/Ad/ObY7ax9Q2+RT0l3Eei3yDgDRMRsZ5rlP2Wy1jmPOHuGijyUM+llh8aKL4ugi3H16qvOj3bt8X7j3MQHm7Gj4E9FZ8195lFhVPvk1bwaiWvHL+JQ2ix9abPVaLqNPZSRzCNlUtRblzZZsK7lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846926; c=relaxed/simple;
	bh=8B/WvnwpQLw8ig4+50DaHklfkQAXbT/SVeyMDkdFQk4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F+NxpcAUdLGbe14DA7I7edTfgTnlgKaO7Hs2lWG2lotPuhiyxculvpJfaidbJxmTiF2eD7/7BIihL+ce5P6Mls/q2rtwMydEs1ABJ4D2r9wlGyJ+vbBXdYuLjfRNBYsXev4JWXk0G8yODJl/d+g4JqYLPnj1PJ4CIhva60QTMzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOj6RTH6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOj6RTH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A86C1F008A1;
	Mon, 12 Oct 2026 23:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846925;
	bh=PxK3XHhioH8mJN1qJ+3oxzwUnN4kDm//D71ec0533x0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XOj6RTH6qyg8ly629AywfjvQReB6xH8iEvMP9Vs0RaYGEAGfKed7Z//1vtPnD/2cV
	 jewTJvJJS07E5pp0GM0lBi4EbR1eiAZwZpVqYDxNHFNmgBsFHZB8A+MVGYQDZnRjBr
	 usfIBychVchXDrt6SFxGegaZH56nTnSZv8ndx37tQlu/RscTnZUuoB21M9LYDf5vWs
	 C9bDeeJRNRXL0mtIUU2iBfBtiSTPK09aYIBJhWJwGijl1CU5QBjEWUxzoSKcDM76Rp
	 WGARa2DISXmPlcBC+Qie/1gR2EplVDzfmcaVfYN4Bx+mm/8+E7rabtq0USevRZK76b
	 w12GtDPr4qiTQ==
Subject: Re: [PATCH net v2 07/15] ice: E822: cancel offset verification work
 during reset preparation
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
Date: Mon, 12 Oct 2026 23:15:24 +0000
Message-ID: <179184692414.434549.12037498977381126452@kernel.org>
In-Reply-To: <20261008215614.1987250-8-anthony.l.nguyen@intel.com>
References: <20261008215614.1987250-8-anthony.l.nguyen@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message gives a false reason for leaving PF resets
  out of the new cancellation.

--

ice: E822: cancel offset verification work during reset preparation

This patch cancels the E822 offset verification work (ov_work) in
ice_ptp_prepare_for_reset() for CORE, GLOBAL and EMP resets, so the
work does not keep polling while the PHY is restarted. PF resets
return early and skip the cancel. The commit message says this is
because nothing else would restart the task after a PF reset.

> The larger resets will restart the PHY, canceling any outstanding vernier
> calibration and forcing a restart. Preemptively cancel the task for non-PF
> resets to avoid doing unnecessary checks while resetting. The task is not
> canceled for a PF reset, otherwise nothing would restart the task to finish
> vernier calibration after the reset.

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 7f82439c47ee5..7cc151b01a13e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -3006,6 +3006,9 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  	if (reset_type == ICE_RESET_PFR)
>  		return;
>  
> +	if (hw->mac_type == ICE_MAC_GENERIC)
> +		kthread_cancel_delayed_work_sync(&ptp->port.ov_work);
> +

[Severity: Medium]
Is the statement "nothing would restart the task to finish vernier
calibration after the reset" accurate for this tree?

Near the end of ice_rebuild(), ice_ptp_link_change() is called for
every reset type, PF reset included:

drivers/net/ethernet/intel/ice/ice_main.c:ice_rebuild() {
    ...
	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) && pf->hw.port_info) {
		bool link_up;

		link_up = !!(pf->hw.port_info->phy.link_info.link_info &
			     ICE_AQ_LINK_UP);
		ice_ptp_link_change(pf, link_up);
	}
    ...
}

ice_misc_intr() sets hw->reset_ongoing only on the OICR path for
CORER/GLOBR/EMPR. For a PF reset, ice_ptp_link_change() therefore does
not skip the hardware writes. On ICE_MAC_GENERIC it reaches
ice_ptp_port_phy_restart(), which cancels ov_work and queues it again:

drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_port_phy_restart() {
    ...
	case ICE_MAC_GENERIC:
		/* Start the PHY timer in Vernier mode */
		kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
		...
		kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
					   0);
		break;
    ...
}

When the link is down, the same function calls ice_ptp_port_phy_stop()
instead, which also cancels ov_work.

The call chain for a PF reset looks like this:

ice_do_reset(PFR)->ice_rebuild()->ice_ptp_link_change()
    ->ice_ptp_port_phy_restart()

If that is right, cancelling ov_work for PF resets would also be safe.
With the early ICE_RESET_PFR return placed before the new cancel, PF
resets still go through the 100 ms reschedule loop in
ice_ptp_wait_for_offsets(), because ICE_PFR_REQ makes
ice_is_reset_in_progress() return true.

Could the cancel be moved above the PFR early return? If not, could the
commit message give the actual reason for exempting PF resets?

>  	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
>  		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008215614.1987250-1-anthony.l.nguyen%40intel.com
