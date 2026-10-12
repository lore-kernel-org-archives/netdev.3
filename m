Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB1D3E44E0
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846928; cv=none; b=OT+d9DokkP7CMUaKjjOkFbQ9wSpHCn23qJm3/TxCGNAOtlxJjnjCzP2+OomyJpF2Oy3rJXmtYDHQEjXdoo1xppe46MuNkLdH4p/kQ9FahlnVBtQZSlB/ERg2opRYCkYgfiTTrg6vubiuRSNI2Zs4xR/rr0GVToDCfO2kHu2fVFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846928; c=relaxed/simple;
	bh=b7vVZELbIVPCfv6u5Ew+JBKdj1XgYXBR1ih7lPmAxXc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PUMRPbMwwqItRcqMCx4b9uWrMIt+bNvWKRllszZ3PQFFjLrtPdnNG/aUTuDNkBVVxmQ9Vhup0jB8C1MHa6ii6wsvpUhwRRrgN3ihHnf0H1y2ZmQjXRO5z4ro5hnHV5K+phHGClRw9HNdJfpIgw0JwEHW60qY1FhVQTQfBvFwf7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBW2Bxa+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBW2Bxa+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171D31F008A2;
	Mon, 12 Oct 2026 23:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846927;
	bh=S6RE7CCQg2sdYUx2wVBbmTIS4iCpq5ftYqKHYv04iuI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kBW2Bxa+MPK7ilXn/F/hXI5nfIpsOnEZOsWt6pmPRkpONIaSN3/qT6OFfrXDmrA5R
	 NO24YBXJPXxXseqUgkZ8d5Wkp6K0R/IPAV51vBQAyQRLMs970F++MqoYYpYSrsDUUB
	 Rw80AtkuuTEalf2US4MvJsUSPVNkMN4PlxKHeZDTjd6D4Sn2VDpaqn+GrEZjFIAt2p
	 GwRx5ZR73czXFUFfnwGeQ//7IdTEst9Bd2oebcCO7FRirWkabMpmNOP9nP68c41E0Y
	 p++f5X6jW3TAKHnSRnToBjRnziXQRBReU3GslOenXw2s7zcc8d+Hi4mgaedd0KSfNE
	 WbCe8bj8Q5+Ig==
Subject:
 Re: [PATCH net v2 08/15] ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
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
Date: Mon, 12 Oct 2026 23:15:25 +0000
Message-ID: <179184692566.434549.13285577131769636984@kernel.org>
In-Reply-To: <20261008215614.1987250-9-anthony.l.nguyen@intel.com>
References: <20261008215614.1987250-9-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Concern: the new ice_ptp_mark_tx_tracker_stale() calls in the
  E825 branches of ice_ptp_port_phy_restart() (line 1322) and…
- [Low] The new error message in ice_ptp_port_phy_restart()
  (drivers/net/ethernet/intel/ice/ice_ptp.c:1340) blames a link-up…

--

ice: E825: stop clearing PHY_REG_TX_OFFSET_READY

On E825, ice_stop_phy_timer_eth56g() no longer clears
PHY_REG_TX_OFFSET_READY, because clearing it leaves the hardware Tx
timestamp counter out of sync. The E825 stop and restart paths now set
tx.calibrating and mark outstanding Tx timestamps stale, then clear
tx.calibrating once the PHY start succeeds. The patch also drops the
unused soft_reset argument and rewords the restart failure message.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 7cc151b01a13e..818e2e265a7e5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -1302,15 +1310,35 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
>  					   0);
>  		break;
>  	case ICE_MAC_GENERIC_3K_E825:
> +		/* ice_ptp_port_phy_stop() may have already disabled
> +		 * timestamps, but some restarts occur without first stopping
> +		 * the timer, so we ensure that new requests are disabled
> +		 * here.
> +		 */
> +		spin_lock_irqsave(&ptp_port->tx.lock, flags);
> +		ptp_port->tx.calibrating = true;
> +		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
> +
> +		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);

[Severity: High]
Can this call race with ice_ptp_release() freeing the Tx tracker bitmaps?

At this commit, ice_ptp_mark_tx_tracker_stale() does not check tx->init:

ice_ptp_mark_tx_tracker_stale() {
	spin_lock_irqsave(&tx->lock, flags);
	bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len);
	spin_unlock_irqrestore(&tx->lock, flags);
}

ice_ptp_release_tx_tracker() clears tx->init under tx->lock. It then
frees the bitmaps without holding tx->lock or ps_lock:

	bitmap_free(tx->in_use);
	tx->in_use = NULL;

	bitmap_free(tx->stale);
	tx->stale = NULL;

	tx->len = 0;

ice_ptp_link_change() checks pf->ptp.state against ICE_PTP_READY without
a lock, before it takes ps_lock. ice_ptp_release() sets ICE_PTP_UNINIT
without holding ps_lock.

So on E825, the service task could handle a link-up event during driver
removal and reach this path:

ice_ptp_link_change()
  ice_ptp_port_phy_restart()
    ice_ptp_mark_tx_tracker_stale()
      bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len)

If that happens while ice_ptp_release_tx_tracker() is freeing or clearing
tx->stale and tx->in_use, this would touch freed or NULL bitmaps. The new
call in the E825 branch of ice_ptp_port_phy_stop() has the same
exposure.

The direct call ice_ptp_release() -> ice_ptp_port_phy_stop() is safe,
because it runs after tx->len has already been set to 0.

A later patch in the series, "ice: keep Tx timestamp slots tracked until
completion or timeout", appears to fix this. It wraps the bitmap_or() in
ice_ptp_mark_tx_tracker_stale() with an if (tx->init) check under
tx->lock.

Could that check be added here, or could that patch be ordered before
this one, so the tree stays safe at every commit for bisection?

> +
>  		err = ice_start_phy_timer_eth56g(hw, port);
> +		if (err)
> +			break;
> +
> +		spin_lock_irqsave(&ptp_port->tx.lock, flags);
> +		ptp_port->tx.calibrating = false;
> +		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
> +
>  		break;
>  	default:
> -		err = -ENODEV;
> +		dev_dbg(ice_pf_to_dev(pf), "PTP failed to restart PHY port %u with unknown MAC type %d\n",
> +			port, hw->mac_type);
> +		return -ENODEV;
>  	}
>  
>  	if (err)
> -		dev_err(ice_pf_to_dev(pf), "PTP failed to set PHY port %d up, err %d\n",
> -			port, err);
> +		dev_err(ice_pf_to_dev(pf), "PTP failed to restart PHY port %u on link-up with err %pe; Timestamping remains disabled; A link-toggle may recover.\n",
> +			port, ERR_PTR(err));

[Severity: Low]
Is "on link-up" accurate for every caller of ice_ptp_port_phy_restart()?

ice_ptp_link_change() calls it, but so does ice_ptp_restart_all_phy(),
which runs from the reset rebuild path and from ice_ptp_settime64():

ice_ptp_restart_all_phy() {
	...
		if (READ_ONCE(port->link_up))
			ice_ptp_port_phy_restart(port);
	...
}

ice_ptp_init() also calls it directly:

	/* Start the PHY timestamping block */
	ice_ptp_port_phy_restart(&ptp->port);

At this commit, the settime64 path only applies to E822. Later in the
series, "ice: Recalibrate PHY after settime64 on E825-C" extends it to
E825 as well.

If the PHY start fails during rebuild, init or settime, this message
says a link-up event caused it. The wording is still the same at the end
of the series.

Would something like "PTP failed to restart PHY port %u" without the "on
link-up" part be more accurate?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008215614.1987250-1-anthony.l.nguyen%40intel.com
