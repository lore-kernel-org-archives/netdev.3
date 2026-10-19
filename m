Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440852;
	b=b9BpvjXBD31/F73s3QBqGaile0UV+QYukvL2U/ZOQmARogzlvt7ho+pxGR7DUSUGMQL5
	 3pBFgSe2RXoO+XhZQPkVQ1GrX3yZmqJd3tZTUX9fGRPzFwSGEbGRvg22Kw5jJ5JdYWDEb
	 Q9IxDYZwwaj5O9+PTGB//pD8QolzHdaRDwahLzrYckhDOS0UPfpGAAUBzPXb2BevywR5H
	 DFyIt24Hng29NqDwFD7gQDsg1llbfSm/AvE0lS3fPYILiYi1sovmTvqnO31zMFH4zVfJK
	 c2gVn8A2EaVQCwn9+X1aWKMqP4qq3tVZ7IeRkiBeG7dBxeNnQgZSb9ki5fd0/E2Zi4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440852;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DzrcsOeLD3pI6O2YFZ/rfcIsT7DsrqTOKWvM27ebr0M=;
	b=Sl/iI6KpNZyQGE7BtjUsf5gT2gS6H4SvWDo4FtQQpgsiK/SsjNGV40jNvtwLmMDIEXoe
	 b12PLIi5eD0x1xtSThMHQQpUYfVtTxmsdqSccEhwjs+LTXEzyznu8wsWMoKeXFeBtChJI
	 Rb3YAxRvMnr4xy2TGGbgu/UrpvR4hs0lmgVLtfFuIDQ087DU8bTDhwBKHcRnRDPgi8xfF
	 WlY367V1dDhryGfViaQFmjQ+KiAAFp72ao4q1TvKfSsmzwc1XGFgYHjVCIadbXH3PrsUC
	 4W46EvFNBDa0smu5hkznAbwbI9FWScTcRNStkv/uiuhi0JmyBEDpBZqlOTePHBlPwHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHbbebwO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E7606A31F
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHbbebwO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9AD1F000C6;
	Mon, 19 Oct 2026 20:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792440851;
	bh=DzrcsOeLD3pI6O2YFZ/rfcIsT7DsrqTOKWvM27ebr0M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kHbbebwO1QWJFdD9xbP3TX28fc4RYGo2ZrcMmdCi6vjK63+HOhg+qguUZuvoEX6zx
	 DLFRL9qAjO/zxZyGb8aabzqCgMsjk8P0fngtzdHcXlNLaUaCu0DFYEvOqb1zOis49N
	 7aVJ9FQJQaIRKPAxSO+56YqoO48RiBnYjZtvQ+1wcAwbVfRs008xC10+3bs/eQLEGq
	 GYpMz+9AizIeImnDk7iSD7Fwx/HoQNH7Jw+4NDay3bVV3jswtZoL7QUic1xvmDZ1gz
	 7ZF7FxNdO+fm6tVRk/y1d2DuiOZo7qaQ8m339/6Z0b8PlgcjLYuDCCW8mGdoOeBboh
	 /E6A/w7qkJdag==
Subject:
 Re: [PATCH net v3 08/14] ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 poros@redhat.com, jacob.e.keller@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, grzegorz.nitka@intel.com,
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com,
 richardcochran@gmail.com, horms@kernel.org
Date: Mon, 19 Oct 2026 20:14:10 +0000
Message-ID: <179244085024.3135.15051854897545383662@kernel.org>
In-Reply-To: <20261015191102.1174111-9-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-9-anthony.l.nguyen@intel.com>
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

- [Low] The kernel-doc no longer matches how the code uses `struct
  ice_ptp_tx::calibrating` and `ice_ptp_mark_tx_tracker_stale()`.
- [Low] The new dev_err in `ice_ptp_port_phy_restart()`
  (ice_ptp.c:1347-1349) says "Timestamping remains disabled", which is…

--

ice: E825: stop clearing PHY_REG_TX_OFFSET_READY

On E825, ice_stop_phy_timer_eth56g() no longer clears
PHY_REG_TX_OFFSET_READY, because clearing it puts the hardware Tx timestamp
counter out of sync. Instead, the PHY stop and restart paths set
tx.calibrating to block new Tx timestamp requests, and mark outstanding
timestamps stale. The unused soft_reset parameter is removed and the
restart failure message is reworded.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 6297773806949..365cff9c10173 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -818,7 +818,8 @@ ice_ptp_mark_tx_tracker_stale(struct ice_ptp_tx *tx)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&tx->lock, flags);
> -	bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len);
> +	if (tx->init)
> +		bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len);
>  	spin_unlock_irqrestore(&tx->lock, flags);
>  }
>  

[ ... ]

> @@ -1243,7 +1245,14 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
>  		err = ice_stop_phy_timer_e82x(hw, port, true);
>  		break;
>  	case ICE_MAC_GENERIC_3K_E825:
> -		err = ice_stop_phy_timer_eth56g(hw, port, true);
> +		/* Disable new Tx timestamp requests */
> +		spin_lock_irqsave(&ptp_port->tx.lock, flags);
> +		ptp_port->tx.calibrating = true;
> +		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
> +
> +		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);

[Severity: Low]
This isn't a bug, but should the kernel-doc for the calibrating field be
updated to match how E825 now uses it? In ice_ptp.h, struct ice_ptp_tx
still says:

 * @calibrating: if true, the PHY is calibrating the Tx offset. During this
 *               window, timestamp requests are disabled.

After this patch, E825 sets the bit in ice_ptp_port_phy_stop() on link
down, where no calibration runs. The commit message also says E825 "does
not perform vernier calibration".

ice_ptp_port_phy_restart() leaves the bit set on failure, so it acts as a
"timestamping disabled until link toggle" state. ice_ptp_release() also
leaves the bit set after teardown.

The kernel-doc for ice_ptp_mark_tx_tracker_stale() has the same problem. It
still says:

 * This should be called when the PTP clock is modified such as after a set
 * time request.

It doesn't mention the new PHY stop and restart callers. It also doesn't say
that the helper now does nothing when tx->init is clear. The teardown order
in ice_ptp_release() depends on that check, because the tracker bitmaps have
already been freed:

ice_ptp_release()
    ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
    ...
    ice_ptp_port_phy_stop(&pf->ptp.port);
        ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);

Could both comments be updated to describe the new behavior?

> +
> +		err = ice_stop_phy_timer_eth56g(hw, port);
>  		break;

[ ... ]

> @@ -1309,15 +1318,35 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)

[ ... ]

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

[ ... ]

>  	if (err)
> -		dev_err(ice_pf_to_dev(pf), "PTP failed to set PHY port %d up, err %d\n",
> -			port, err);
> +		dev_err(ice_pf_to_dev(pf), "PTP failed to restart PHY port %u with err %pe; Timestamping remains disabled; A link-toggle may recover.\n",
> +			port, ERR_PTR(err));

[Severity: Low]
Is "Timestamping remains disabled" accurate for Rx on E825 in every
failure case?

Tx is now blocked only in software, through tx.calibrating. Rx is blocked
only in hardware, through PHY_REG_RX_OFFSET_READY.

Suppose the first register write in ice_start_phy_timer_eth56g() fails:

ice_start_phy_timer_eth56g()
    err = ice_stop_phy_timer_eth56g(hw, port);
    if (err)
        return err;

PHY_REG_RX_OFFSET_READY then keeps its previous value, for example 1 from
an earlier successful start. The hardware may keep marking Rx descriptor
timestamps valid, even though ice_sync_phy_timer_eth56g() never ran.

If any later step fails, RX_OFFSET_READY has already been cleared and the
message is accurate. The early return is not new; only the message's
absolute claim is.

Could the message be more precise here, for example by saying that Tx
timestamping remains disabled?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015191102.1174111-1-anthony.l.nguyen%40intel.com
