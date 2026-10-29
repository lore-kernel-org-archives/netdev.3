Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793235217;
	b=svZV0ZfJFiJsbaUar9KNwb0A2S7a/FWfcFVbRSqiY1++2s5SQtoioKngc7OYFMiL25mD
	 0s2Z2rgj9LBubEOcLGbnpN64s8sABqycoMamcmpnupXlWPM9CmjG4I4RJ9hrup4z2VB1v
	 vNe1Li/TiAVdIUCKHU/sb1RS2sKdWUzcdXZ+fBS1YBb70k0l7cI81XqjuHYLARcbISfrB
	 f3N8X4sc+mcYJDqfpRXsvvw7shhNOFXizBfYGExG6rct1pBISZHcDMuDBfrBWTXlVZPOl
	 cCfLV9Yu6yQKZLxC/wVM6Iv04DaZX6I4s6r4SMiEIJteA4TSwxF0TJJqi6cHrF/FkpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793235217;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FqRwHbmTCbmGJ8iS4OFIeGTzfrApt9eKXrcVHOlw5xs=;
	b=DM21v+c9593blqa4U+IuJS/4/I8FUqf/b6p7oYFYR1iv2gdiCoMS1Tuz8JyZ445NwbdM
	 vEsrcZ1hZk9HyJescAkVlJPKab4Htb02+f+R05Qxd1mMgQyBMP0MNZYxAS3OYTd/qKTLC
	 HIbmGicJ62xeIAXa9ulbEzB1CdDYZn6A4BnLY/2QT7/wcVNYnrF/qReV+zK5nMWjVPgCs
	 ICjjlYtgTnCf4pQA+UhaxmPr1B34UhV7qDGMXt38TlvmadUrZr6In8GqLtGgwg7gF3woN
	 3xqEdDhwZt5m0fMYMxpijddQEBeHX3B8nXMX1qDuhT0v6xfGfPP0ZlsZWvuTuOGvcwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RncUpiKB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBEB606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 00:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RncUpiKB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0F31F01825;
	Thu, 29 Oct 2026 00:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793235216;
	bh=FqRwHbmTCbmGJ8iS4OFIeGTzfrApt9eKXrcVHOlw5xs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RncUpiKBcL/DoI7Q+BvOGdQ/s8yaYRk9j/HPeP0kKvPweShK8WeTE3ajKtrdKPtWe
	 6yXb9n5aX1WIupOGs/xWTvvTpqlT8Bba8/vveDmKKIYeru+BL4Wy0ekSz2Jum6yiMI
	 B9vzG+ZoXyzRFc0OuXPqr0zuwK6d943m1HpOw8iZCE6WF4amxu3B5nsMM6Kvh26OOk
	 t9cxYkHnbvUcQm0c6e20ZUr8GxrOFeUtCqqUZ6iC5PPNP33empiLqdSwVWo1aczSSP
	 hlL22xXi5698IRSx8irjBV5wG7CKQUwloGFrEWfY+t8fAW6j+XHyIwBrTAY0mhz/ep
	 rzH/Q2n4WUtng==
Subject: Re: [PATCH net 4/6] ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
From: netdev-bot+sashiko@kernel.org
To: jacob.e.keller@intel.com
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, poros@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com,
 anthony.l.nguyen@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org
Date: Thu, 29 Oct 2026 00:53:35 +0000
Message-ID: <179323521502.3134.1640101944514020934@kernel.org>
In-Reply-To: <20261027-reduction-v1-4-81237c67a361@intel.com>
References: <20261027-reduction-v1-4-81237c67a361@intel.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ice_ptp_port_phy_restart()
  (drivers/net/ethernet/intel/ice/ice_ptp.c) now returns from the…

--

ice: E825: stop clearing PHY_REG_TX_OFFSET_READY

On E825, ice_stop_phy_timer_eth56g() no longer clears
PHY_REG_TX_OFFSET_READY. Clearing it left the hardware's outstanding Tx
timestamp counter out of sync. New Tx timestamp requests are now blocked
through the tracker's tx.disabled flag while the PHY is stopped or
restarting. The patch also adds a tx->init check in
ice_ptp_mark_tx_tracker_stale(), and changes the error messages in
ice_ptp_port_phy_restart().

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 2f8563eb6fb19..3ba6632bb1965 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -1305,15 +1311,35 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)

[ ... ]

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
> +		dev_err(ice_pf_to_dev(pf), "PTP failed to restart PHY port %u with err %pe; Timestamping not enabled; A link-toggle may recover.\n",
> +			port, ERR_PTR(err));
>  
>  	mutex_unlock(&ptp_port->ps_lock);

[Severity: High]
Does this new return leave ptp_port->ps_lock held?

ice_ptp_port_phy_restart() takes the mutex before the switch:

	mutex_lock(&ptp_port->ps_lock);

	switch (hw->mac_type) {

Before this patch, the default arm set err = -ENODEV and fell through to
the mutex_unlock() at the end. The new return -ENODEV skips that unlock.

After that, any ice_ptp_port_phy_stop() or ice_ptp_port_phy_restart() on
the same port would block forever in mutex_lock(). That includes the
ice_ptp_release() -> ice_ptp_port_phy_stop() teardown path.

The default arm in ice_ptp_port_phy_stop() still uses err = -ENODEV and
reaches its unlock.

The commit message only describes this hunk as a logging change:

  "For the invalid MAC type path returning -ENODEV, skip this message and
  log a dev_dbg that we failed with an unknown MAC type instead."

The current tree does not seem to hit this path at runtime.
ice_ptp_init_port() rejects unknown MAC types before
ice_ptp_reset_phy_timestamping() runs. However, the path becomes
reachable if a MAC type is ever added to ice_ptp_init_port() but not
here.

The last patch in the series ("ice: skip reading Tx ready bitmap on
ports with no timestamps") still has the same return with the lock held.

Could the default arm call mutex_unlock() before returning? Another
option is to set err and jump to a label that skips the dev_err() but
still unlocks.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027-reduction-v1-0-81237c67a361%40intel.com
