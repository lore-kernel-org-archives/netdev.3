Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971847;
	b=ulTpR6BZl5IUMeUUYtMmOObBlL4PnwpSeU/GeLTY8uwd6Oapuq1VNkq3syloly9dk5yc
	 +MT4NtoTvvGDh6bjCcsjgHwpo/I5xibl08VHxJFrkhbCw/R7d08gN+ZQvl7bKKNsY16XZ
	 XVKFbGi1ED1eIWVxlTk34yN4zjv0WDxdOngmgo7769ISzVTVkAsb/+Wuj9MMK72KIafm0
	 yy94hIeyLUUPm5jdkTkdsUyUaRlYxTQqhNBXyEqUBD3qCgDxYXu2SRJG6IE96AiejSZLr
	 ve8z3tSLJNt9SxjGCMx0cuu7T6QKKV4OmlM7SAOIhWCeiP9q9baDWb/mwxwZSuC6QhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971847;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=feAMzXw0I0VzttmiPYuwLfS9Ux7rt/ffGxnvEU3h+nc=;
	b=X58jKwnrf71oyI41DhgT7Myc1O1LFtclgusMwFjOiUwdjlXgPydzzRRdWLXGI+1ruY6j
	 GBpqA5kVRDRUkXKk2ov+2M37NirCU5WO12G5xMgfoDexaL++fdbVu/weBKxm5+xQwsSQf
	 AuRfgfVJRfc1GWgrMMCZz9ZamgPdkHTFDo7t4/FEbyof1Gj6+P19euY8ouojMvA3iCOrN
	 8m2kTNfO0u8UXlZL/5WM3GHDBfTjpVfNHJ+HrS9lp9v7cCsm+t2KyhffR/L8elkdQscUh
	 YhgjS3jcI79GS7RfuZ9gh5qhs6pX1lnBw34CwZxNlMrRt1pc56PxT0sVOT0/tNZReEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a96IRBmE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21EB606A31B
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a96IRBmE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21711F01825;
	Sun, 25 Oct 2026 23:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971846;
	bh=feAMzXw0I0VzttmiPYuwLfS9Ux7rt/ffGxnvEU3h+nc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=a96IRBmEay2whO7MI/6Yulgsh5T1xgmj4j5hSHxegiFHnEvy+u1cY5AygE2P3kgi9
	 bA44ofzSETkY4AzsI/rWN5HZrx5JUhVL2ZWql7zz/cN69sOY+H9Z6eip/zyaycri8h
	 wEpR/P9qcYu/bqVycRcvb+eXGomSU35XIneH47/nFnA2DVUTwV4UdFKKX5JGG2cYDI
	 Gajpa1vtZT32qT+4t6VGlApDV7Uo/1TPoZ4PPPAjBfLrvCvQDrhfOVohh2JAs29d2j
	 U3ySFxPJlBz9uPs72265W7CCf+H5CGhEGbo8f1c+M7JmKqIDn6iYLG+CPsNqaDjifb
	 RXW1M03i+HM0Q==
Subject: Re: [PATCH net v5 11/13] ice: keep Tx timestamp slots tracked until
 completion or timeout
From: netdev-bot+sashiko@kernel.org
To: jacob.e.keller@intel.com
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, poros@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com,
 anthony.l.nguyen@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org
Date: Sun, 25 Oct 2026 23:44:05 +0000
Message-ID: <179297184533.3134.5564062752798799751@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes?=
 =?utf-8?q?-srcu-v5-11-72289a4ac8eb=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes-?=
 =?utf-8?q?srcu-v5-11-72289a4ac8eb=40intel=2Ecom=3E?=
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says link-down requests are marked stale,
  but the patch never marks them stale on E810, E830 or E82x.

--

ice: keep Tx timestamp slots tracked until completion or timeout

This patch stops dropping outstanding Tx timestamp requests on link down
and rejects new requests while the link is down. Slots that are not ready
yet are now released by the existing 2 second timeout. It also makes the
interrupt re-arm checks ignore stale slots, and lets
ice_ptp_maybe_trigger_tx_interrupt() run for PFs that handle their own Tx
timestamp interrupt.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index b7c539f98276..309fa2877cc3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -582,14 +584,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>  			return;
>  	}
>  
> -	/* Drop packets if the link went down */
> -	link_up = READ_ONCE(ptp_port->link_up);
> -
>  	for_each_set_bit(idx, tx->in_use, tx->len) {
>  		struct skb_shared_hwtstamps shhwtstamps = {};
>  		u8 phy_idx = idx + tx->offset;
>  		u64 raw_tstamp = 0, tstamp;
> -		bool drop_ts = !link_up;
> +		bool drop_ts = false;
>  		struct sk_buff *skb;

[Severity: Medium]
The commit message says:

    Mark the outstanding requests stale so their completions are read
    and discarded

Where does this stale marking happen for E810, E830 and E82x? The patch
removes the link-down drop here, but it doesn't add any new calls to
ice_ptp_mark_tx_tracker_stale().

On link down, the only caller that can be reached is the
ICE_MAC_GENERIC_3K_E825 branch of ice_ptp_port_phy_stop() (and the same
branch of ice_ptp_port_phy_restart()):

ice_ptp_port_phy_stop() {
    ...
	case ICE_MAC_E810:
	case ICE_MAC_E830:
		err = 0;
		break;
	case ICE_MAC_GENERIC:
		kthread_cancel_delayed_work_sync(&ptp_port->ov_work);

		err = ice_stop_phy_timer_e82x(hw, port, true);
		break;
	case ICE_MAC_GENERIC_3K_E825:
		...
		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
    ...
}

Also, ice_ptp_link_change() skips E810 and E830 entirely:

	case ICE_MAC_E810:
	case ICE_MAC_E830:
		/* Do not reconfigure E810 or E830 PHY */
		break;

The new in_irq check in ice_port_has_timestamps() only excludes stale
slots:

	if (in_irq)
		return bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len);

Given that, can a link down with a request still outstanding on E810
(non-LL), E830 or E82x cause a back-to-back interrupt loop? The sequence
would be:

  link goes down while a not-ready slot is set in in_use
  ice_ptp_maybe_trigger_tx_interrupt()
    ice_ptp_tx_tstamps_pending(pf, false) -> true
    wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M)
  ice_ptp_process_tx_tstamp()
    slot not ready and not timed out -> continue
  ice_misc_intr_thread_fn() (E810/E82x) or ice_ptp_ts_irq() (E830)
    ice_ptp_tx_tstamps_pending(pf, true) -> true, slot is not stale
    wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M)
  ... repeats until the 2 second timeout frees the slot

On E830 the re-arm happens in hardirq context in ice_ptp_ts_irq(). On E82x
every pass does sideband PHY reads. Before this patch, the first pass after
link down dropped every slot, so this loop could not happen.

A later patch in this series, "ice: don't clear in_use until HW clears
ready bitmap", adds an ice_ptp_is_tx_tracker_up() check to the in_irq
branch. Combined with the link_up check added here, that seems to close
the loop.

Even after that patch, though, E810, E830 and E82x still don't get any
stale marking on link down. So this commit isn't bisect-safe on its own,
and the commit message describes a mechanism the code doesn't implement.

Should the commit message be corrected, or should the stale marking be
added for the other MAC types?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb%40intel.com
