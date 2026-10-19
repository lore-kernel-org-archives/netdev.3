Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440849;
	b=KicLNsLxJJMb3YEtO7UyIGfwZBaNVJ9OqmWuV0wJMZwj9rJo+VnLLdHowZ6w6YsqcxoK
	 ikR2h87236T33gKJDTingot9FygD+1XtRZCvR44qit0/My1LZWeoueE5z8n/EzuxovdQc
	 kOAqKiCSgpBnBKSlEuGvTbr+IeNE4PKTM79LntIfb6W8G+NEOnBcOHcV1JcCj7L3Aa4y0
	 mRnJfj8q+FbnUm/EQ7DZkfb1uIV89cpyqYTwDuk8OBRlUZ0pJikliz5qMb87CQ4CFv/lY
	 EvTzoNwtNI6glUmTLaG8h82wcaLlhrmBWqQq+8J80xmvHohCwYBFu0M1vh1DIQQVSxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440849;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PdajFz9tIyMN81nMLwdSVSPFGILmaYyCCnOQcFuAxWc=;
	b=AfjcawXs4axt4oCIL0pzgPatXSmI96QCfWuLoSk1Gm46mOnnSSN//CVPWYSz77EiKqty
	 Axjd5wW7MsZiwfYvn9aaT9WsJd6hWhPCZJa2SWsUx/6QU8OT3TWxwj91F3Nea4NXf73TX
	 KR5swSZ5HG4QkfeqeMXUrcRuwOuk1Fpw7mW7z4+tBN3rgVl2PJrcWSU65wbhP2JoLLPZf
	 ZbgwOwCIX77qggG4SenbflVEEvA3LBbfjBGLaS6hxiP8ksX6iS3CJyu2Pps7Yfs+as6RG
	 SWhv3DL4z3rzZjkKsiwzkSEsyYqpQW6Zp0/TDXDp6pbWnTm8c0j42HVvnPsa9ZzhqRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2N96dTD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FF4606A32F
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2N96dTD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993741F000C5;
	Mon, 19 Oct 2026 20:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792440848;
	bh=PdajFz9tIyMN81nMLwdSVSPFGILmaYyCCnOQcFuAxWc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=A2N96dTDxmowfkhSMe748/WanynbvBpJnY3TEFev/WeCR71r1Ie9Iuf+8eSNSkANj
	 LhomUEIygwoS1q33SVerNG/Jq3/HeOkbo7ReHecEbGT+PZHkhow0Sva39TTC33VlG5
	 5HJGJyS2Nv/hMRYey9Sb+eTQjxe0Ln8t4gXqovJcXWx+PMc7oXun4jLGLEDzGUcJbD
	 AoGutcZlVZxttKrV+f6GCe0VcaSjzS4/FgTlLhqYfX9tbL8GTkMmGHBuvHaCfLM2+5
	 jcmon8Uo2RWByath4+d3GBeHuzTIMmLpnmxGKi9rOvF09yNdTf9nXymGtpSUENkAkM
	 XIpKVM4iQTzAA==
Subject: Re: [PATCH net v3 06/14] ice: E822: keep Tx timestamps disabled
 during offset calibration
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 poros@redhat.com, jacob.e.keller@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, grzegorz.nitka@intel.com,
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com,
 richardcochran@gmail.com, horms@kernel.org
Date: Mon, 19 Oct 2026 20:14:07 +0000
Message-ID: <179244084713.3135.15270894261694265167@kernel.org>
In-Reply-To: <20261015191102.1174111-7-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-7-anthony.l.nguyen@intel.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The kernel-doc for ice_ptp_tx::calibrating (ice_ptp.h:109-110)
  still says "if true, the PHY is calibrating the Tx offset".

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  ice_ptp_settime64() leaves the E82x PHY offset-ready bits cleared with…

--

ice: E822: keep Tx timestamps disabled during offset calibration

ice_ptp_port_phy_restart() no longer clears tx.calibrating right after
ice_start_phy_timer_e82x() succeeds. The flag is now cleared in
ice_ptp_wait_for_offsets(), once ice_phy_cfg_tx_offset_e82x() has
succeeded. The patch also adds debug messages for pending and completed
offset calibration.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 776f211290eca..828d46a73f292 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -1283,11 +1301,10 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
>  		if (err)
>  			break;
>  
> -		/* Enable Tx timestamps right away */
> -		spin_lock_irqsave(&ptp_port->tx.lock, flags);
> -		ptp_port->tx.calibrating = false;
> -		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
> -
> +		/* Do not clear calibrating flag here. Tx timestamp requests
> +		 * remain disabled until ice_ptp_wait_for_offsets() has
> +		 * verified that the Tx offset calibration has completed.
> +		 */
>  		kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
>  					   0);
>  		break;

[Severity: Medium]
This is a pre-existing issue, and this patch did not introduce it. ov_work
is the only thing that re-arms the E82x PHY offsets. Can
ice_ptp_settime64() leave Tx and Rx timestamps invalid on every port if
ice_ptp_lock() fails?

ice_ptp_settime64() clears the offset-ready bits first. It can then bail
out before the PHYs are restarted:

drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_settime64() {
    ...
	if (hw->mac_type == ICE_MAC_GENERIC) {
		err = ice_ptp_clear_phy_offset_ready_e82x(hw);
		...
	}

	if (!ice_ptp_lock(hw)) {
		err = -EBUSY;
		goto exit;
	}
    ...
	if (hw->mac_type == ICE_MAC_GENERIC)
		ice_ptp_restart_all_phy(pf);
exit:
    ...
}

ice_ptp_clear_phy_offset_ready_e82x() writes 0 to P_REG_TX_OR and
P_REG_RX_OR on every port. ice_ptp_lock() polls the shared PFTSYN_SEM up
to MAX_TRIES times, with usleep_range(5000, 6000) between polls, and then
gives up. So this path can be hit if another function holds the semaphore
for that long.

The goto skips ice_ptp_restart_all_phy(). That is the only route to
ice_ptp_port_phy_restart(), and so the only way ov_work gets queued. If
ov_work had already finished, nothing calls
ice_phy_cfg_tx_offset_e82x() or ice_phy_cfg_rx_offset_e82x() again.

Would every Tx and Rx timestamp then be marked invalid and dropped by the
ICE_PTP_TS_VALID checks? That would last until a link flap, a reset, or a
later successful settime. tx.calibrating stays false the whole time, so
Tx timestamp requests are still accepted.

Could the offset-ready clear move after the lock is taken, or could the
error path still restart the PHYs? This still looks present at the end of
the series.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
> index 27ea502b75768..029ee4612d765 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
> @@ -107,7 +107,7 @@ enum ice_tx_tstamp_work {
>   * @len: length of the tstamps and in_use fields.
>   * @init: if true, the tracker is initialized;
>   * @calibrating: if true, the PHY is calibrating the Tx offset. During this
> - *               window, timestamps are temporarily disabled.
> + *               window, timestamp requests are disabled.

[Severity: Low]
This isn't a bug, but is the first half of this kernel-doc still accurate
after this patch?

On E822, ice_ptp_wait_for_offsets() is now the only place that clears the
flag, so it can stay true while nothing is calibrating. Say link goes down
before ice_phy_cfg_tx_offset_e82x() has succeeded. ice_ptp_port_phy_stop()
then cancels ov_work and stops the PHY timer without touching the flag:

	case ICE_MAC_GENERIC:
		kthread_cancel_delayed_work_sync(&ptp_port->ov_work);

		err = ice_stop_phy_timer_e82x(hw, port, true);
		break;

Before this patch that could not happen, because the flag was cleared
right after a successful start. The same is true when
ice_start_phy_timer_e82x() fails: ice_ptp_port_phy_restart() breaks out
with calibrating still set and no ov_work queued.

Later in the series, the E825 ice_ptp_port_phy_stop() path also sets
calibrating to true on link-down. That moves the meaning further from
this description.

This has no functional effect. The next ice_ptp_port_phy_restart() sets
the flag again and requeues ov_work.

The flag now reads more like "Tx timestamp requests are blocked until the
Tx offset has been configured" than "the PHY is calibrating". The
"temporarily disable Tx timestamps while calibrating PHY offset" comment
in ice_ptp_port_phy_restart() has the same mismatch.

Could both comments be updated to match the new behaviour?

>   * @has_ready_bitmap: if true, the hardware has a valid Tx timestamp ready
>   *                    bitmap register. If false, fall back to verifying new
>   *                    timestamp values against previously cached copy.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015191102.1174111-1-anthony.l.nguyen%40intel.com
