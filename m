Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C471332B109
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521138; cv=none; b=VTSI2hHuoXUbg4L9OcvJRRa9IHK9v5Zlzih0OR1EmvFvFF8u+GmuQ/R+tcBfo90EyOSoGXUc9BhdyN7foUiX/hIEoisYuDuDc9iiV94D1hsphUQOFDPk5XHByxYS1sbmWyYmDTwduT5LN7Tmvb6KrqMS94hdq7+VqkSbmafJW9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521138; c=relaxed/simple;
	bh=F0eVdDkjTrmpsdKr8jizC45JdCNESM0JhFWfs4u24wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBlxo+gBNavCVOZz+u8LqORLoigUmOeQ1Gq92JLFykivvQ3DEoAhfeqF4ewQxW73D1X8dnTbL2Vmzvs5R/0o/O3AbeN6kG1wXacY5W1araBT18HWNxd/deWqVJhvGlgvaTvJccvOz2vhDuPtO3T02JwaMJH4kxTcpsimgO1Jl1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj/jLMaQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj/jLMaQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F367E1F000FF;
	Wed, 16 Sep 2026 01:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521136;
	bh=gJ8ur+EjRQob+u81L0jjwHEFD1+k58HdSjgti2KtJwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bj/jLMaQom0JuUBwjL6EbIVGpwsMUrCkXaTCrh0tpqAZws45W0lC2E/go/CBaPgtb
	 w2LHYTpnC+4ChTh1uJh5kdOAxxiYrn1VoWQzzKHjlAwAY2ebXcjB2GtR+0NhFM8NJ7
	 Epz6Jl6WsFyNLRL0YEXZuk7Wr+L6BmvFRrrHTprid068OsojIyDlhu7FpiVvQeQlAH
	 T4XcTR+0zaXyrgiInSdOX0LKBEpobz+xjordLfwlXeyp6k2YnWBX4EpZmDyMJH+6O/
	 P7R6x9IcJfrduYpi4uQ1TV5U5KOhw+I7ocFQfEc34c7RWcdlbM2nlofesvs97VKDk/
	 bg4U3oIF9TwLw==
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
Subject: Re: [PATCH net 04/15] ice: E822: keep Tx timestamps disabled during offset calibration
Date: Tue, 15 Sep 2026 18:12:15 -0700
Message-ID: <20260916011215.1632391-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911003430.3386340-5-anthony.l.nguyen@intel.com>
References: <20260911003430.3386340-5-anthony.l.nguyen@intel.com>
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
ice: E822: keep Tx timestamps disabled during offset calibration

This moves the clearing of port->tx.calibrating out of
ice_ptp_port_phy_restart() and into ice_ptp_wait_for_offsets(), so that Tx
timestamps stay disabled until the Tx and Rx PHY offsets have been
configured.  It also adds two dev_dbg() messages covering the pending and
the completed calibration cases.

No Link: tags present in the commit header.

A few questions below.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 68537705e8399..d018f02f700d7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1156,6 +1156,7 @@ static int ice_ptp_check_tx_fifo(struct ice_ptp_port *port)
>  static void ice_ptp_wait_for_offsets(struct kthread_work *work)
>  {
>  	struct ice_ptp_port *port;
> +	unsigned long flags;
>  	struct ice_pf *pf;
>  	struct ice_hw *hw;
>  	int tx_err;
> @@ -1178,12 +1179,28 @@ static void ice_ptp_wait_for_offsets(struct kthread_work *work)
>  		tx_err = ice_phy_cfg_tx_offset_e82x(hw, port->port_num);
>  	rx_err = ice_phy_cfg_rx_offset_e82x(hw, port->port_num);
>  	if (tx_err || rx_err) {
> -		/* Tx and/or Rx offset not yet configured, try again later */
> +		/* Tx and/or Rx offset not yet configured, try again later.
> +		 * This is expected during normal link-up: the vernier offset
> +		 * calibration cannot complete until at least one packet has
> +		 * been transmitted, so the first retries routinely land here.
> +		 */
> +		dev_dbg(ice_pf_to_dev(pf),
> +			"PTP offset not yet valid for port %u (tx_err=%d rx_err=%d)\n",
> +			port->port_num, tx_err, rx_err);
>  		kthread_queue_delayed_work(pf->ptp.kworker,
>  					   &port->ov_work,
>  					   msecs_to_jiffies(100));
>  		return;
>  	}
> +
> +	/* Tx and Rx offsets are now configured, enable Tx timestamps */
> +	spin_lock_irqsave(&port->tx.lock, flags);
> +	port->tx.calibrating = false;
> +	spin_unlock_irqrestore(&port->tx.lock, flags);

[Severity: High]
Does placing the only clear of port->tx.calibrating after the combined
"if (tx_err || rx_err)" gate make the Tx timestamp gate depend on Rx
calibration?

The two directions have independent offset-ready registers.  On the Tx side,
ice_phy_cfg_tx_offset_e82x() programs the total Tx offset and sets:

drivers/net/ethernet/intel/ice/ice_ptp_hw.c:ice_phy_cfg_tx_offset_e82x() {
	...
	err = ice_write_phy_reg_e82x(hw, port, P_REG_TX_OR, 1);
	...
}

and thereafter returns 0 immediately ("Nothing to do if we've already
programmed the offset").  Meanwhile the Rx side keeps failing until a packet
has actually been received:

drivers/net/ethernet/intel/ice/ice_ptp_hw.c:ice_phy_cfg_rx_offset_e82x() {
	...
	if (!(reg & P_REG_RX_OV_STATUS_OV_M))
		return -EBUSY;
	...
}

So in the Tx-done/Rx-pending state, ice_ptp_wait_for_offsets() loops on the
100 ms retry branch with tx_err == 0 and rx_err == -EBUSY and never reaches
the new "port->tx.calibrating = false".

Since calibrating is written in only two places after this patch (set true
in ice_ptp_port_phy_restart(), cleared here), is there anything left that
can reopen the Tx gate?  ice_ptp_is_tx_tracker_up() stays false:

drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_is_tx_tracker_up() {
	return tx->init && !tx->calibrating;
}

and every request is refused, with ice_tstamp() only bumping the skipped
counter:

drivers/net/ethernet/intel/ice/ice_txrx.c:ice_tstamp() {
	idx = ice_ptp_request_ts(tx_ring->tx_tstamps, skb);
	if (idx < 0) {
		tx_ring->vsi->back->ptp.tx_hwtstamp_skipped++;
		return;
	}
	...
}

This is reachable on an ordinary link-up when the link partner is silent or
passive, or in one-way/tap topologies, and it persists until the next link
transition.  Before this patch the Tx gate did not depend on the Rx side.

Would gating the clear on tx_err == 0 only, and letting the Rx offset
configuration continue to retry independently, be the intended behaviour?

[Severity: Low]
Should the surrounding documentation be updated along with the new
semantics?  The kernel-doc directly above ice_ptp_wait_for_offsets() still
says:

 * Once the offset in either direction is measured, configure the associated
 * registers with the calibrated offset values and enable timestamping. The Tx
 * and Rx directions are configured independently as soon as their associated
 * offsets are known.

and the member doc in ice_ptp.h for struct ice_ptp_tx still says:

 * @calibrating: if true, the PHY is calibrating the Tx offset. During this
 *               window, timestamps are temporarily disabled.

After the patch the flag is cleared only when ice_ptp_check_tx_fifo(),
ice_phy_cfg_tx_offset_e82x() and ice_phy_cfg_rx_offset_e82x() all succeed,
so the Tx gate now also encodes Rx state and Tx FIFO state.  The window is
also no longer temporary in all cases: on the ice_start_phy_timer_e82x()
error path ice_ptp_port_phy_restart() breaks before queueing ov_work, and
ice_ptp_port_phy_stop() cancels ov_work without restoring the flag.

> +
> +	dev_dbg(ice_pf_to_dev(pf),
> +		"PTP offset valid for port %u, Tx timestamps enabled\n",
> +		port->port_num);
>  }
>  
>  /**
> @@ -1269,10 +1286,13 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
>  		if (err)
>  			break;
>  
> -		/* Enable Tx timestamps right away */
> -		spin_lock_irqsave(&ptp_port->tx.lock, flags);
> -		ptp_port->tx.calibrating = false;
> -		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
> +		/* Do not clear calibrating flag here. Tx timestamps remain
> +		 * disabled until ice_ptp_wait_for_offsets() has verified
> +		 * that the Tx and Rx offset calibration has completed.
> +		 * Clearing it here would allow Tx timestamps to be reported
> +		 * before the PHY offset registers are configured, leading
> +		 * to incorrect timestamp values.
> +		 */

[Severity: Medium]
Is the "leading to incorrect timestamp values" description in this comment,
and the matching commit message text, accurate for this window?

The commit message says:

    Timestamps produced during this window use uncalibrated PHY offsets and
    can produce incorrect values.

    When ptp4l receives incorrect timestamps, it may reject them and wait
    for the next sync interval (typically 1-2 seconds), compounding delays
    during link cycling.

During that window P_REG_TX_OR is 0.  ice_start_phy_timer_e82x() begins by
calling ice_stop_phy_timer_e82x(), whose first action is:

drivers/net/ethernet/intel/ice/ice_ptp_hw.c:ice_stop_phy_timer_e82x() {
	err = ice_write_phy_reg_e82x(hw, port, P_REG_TX_OR, 0);
	...
}

and TX_OR is only set back to 1 by ice_phy_cfg_tx_offset_e82x() once the
total Tx offset has been programmed.  The driver documents that write as
invalidating timestamps:

drivers/net/ethernet/intel/ice/ice_ptp_hw.c:ice_ptp_clear_phy_offset_ready_e82x() {
 * Clear PHY TX_/RX_OFFSET_READY registers, effectively marking all transmitted
 * and received timestamps as invalid.
	...
}

And timestamps captured without the valid bit are dropped rather than
reported:

drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_process_tx_tstamp() {
	...
	/* Discard any timestamp value without the valid bit set */
	if (!(raw_tstamp & ICE_PTP_TS_VALID))
		drop_ts = true;
	...
}

Is the pre-patch symptom then a missing Tx timestamp (slot held until read
or timeout, counted in tx_hwtstamp_timeouts) rather than a wrong value
delivered to ptp4l?  The sibling patch in this series ("ice: E825: stop
clearing PHY_REG_TX_OFFSET_READY") states that with the offset-ready bit
clear "the hardware still captures Tx timestamps, but it no longer sets the
valid bit", which seems to point the same way.

Could the commit message and this new comment be reworded to describe the
actual failure mode, so that anyone matching user reports against the
Fixes: tag is not misled?

>  
>  		kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
>  					   0);
