Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440857;
	b=nfESRjxEdBthFv/SnDElYR1cGHqYPEPAwxgFtLWfL+k6+tDAX3ARszk2T41z0XUv0/2l
	 2QtP+O7ItUVYmd5xIbF2Z1PdVwSAY0YA+5YBgxqbfVV6UOAfZq1HkIpemgosmzAQH0K5S
	 STufh5DHIABeH3kZFXmfTy5fN8h/TDrEMuhlI0WbJkmtuISz35/+tk5bCo66zQpt8wnEH
	 04Z8eNqRClAaQmq1ekiIgMJeWBy+m5lIfJUOeT1f9hOYIeIhFyjFB/DZYp9pFgdOJjqNB
	 XFXqQcry7x1hq4edaAMFFb+3IviCp43G5ml0rW6N3wno2RKXneH9fzGjaqIpT/kgxkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440857;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QA0VhwsFvdNMhItCXFdoNxRykx3D8rjnZAd279UTOjA=;
	b=VKOmF+6VYW0+qZgdQzdJEIqjlY3Lu6UtgAMzAV3yQB1hETq7BaU5YXj0ZtJ2j01xLiYj
	 61ypXwZ1UYLBWiUx+T/F3Pah63oTaY6TdPZbMtrJ0QvJ/WrcDxsim3M4nxJAtXLkCbjDY
	 2nQ/3oBLSpZx7rbYySEVkR9U1dLKRY9EYesyusO3mBP8C98jvKUdb1ybtEVCv0/U9HVDh
	 8435mGWyPfci99ZoH12UH5+0IhBH24QpFbbNCyOu9DCz2QvPmWLNbSd8t9svpAu8PVXnW
	 juay/OWGI9ffDs0E5pZGyNOL/Yh8MaMPElAkPeQJ5Azwfl+anHYWblkR057v58Gxfjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6ny3C6U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF15606A33A
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6ny3C6U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6323B1F000C5;
	Mon, 19 Oct 2026 20:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792440856;
	bh=QA0VhwsFvdNMhItCXFdoNxRykx3D8rjnZAd279UTOjA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N6ny3C6UZ9nRrFGZLPeNJhied5GMPQ+IC5fJdM2e328mGef5JJveB0l9A2SerU1Tf
	 Cx+r4o3dkX9RASMf4l5HqCfREYGQC69T8mnYphwgMKIr0Lefq0pkZdh1vheqvpAom3
	 B5ne3OolQU3xjjHsq7ADtNhhmip/BzJf/0WP+SLAK9Bkg+8GtRDTL/3/2G+LxoINAj
	 A40KlGAR09Mysa/euGdyjrKQ2wTxsBz76ujrERLUSF6BFDiB0fwZX4h6Yfm21xnZ8s
	 aRlJMAxaBWr68OrUqKwdvtPY6Pg/HDOtWMNAuWbimYQVVwUYYAb15mINwIE9EqzkEM
	 5QXCPik3ZMK+w==
Subject: Re: [PATCH net v3 11/14] ice: wait for in-flight Tx timestamps before
 removing the tracker
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 poros@redhat.com, jacob.e.keller@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, grzegorz.nitka@intel.com,
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com,
 richardcochran@gmail.com, horms@kernel.org
Date: Mon, 19 Oct 2026 20:14:14 +0000
Message-ID: <179244085491.3135.8474994286741014334@kernel.org>
In-Reply-To: <20261015191102.1174111-12-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-12-anthony.l.nguyen@intel.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On E830, the new drain wait runs, but the flush that follows
  cannot clear the ready entries it waited for.
- [Medium] The tracker is released while the PF's Tx path is still live,
  and the new drain wait gives up after 10 ms.

--

ice: wait for in-flight Tx timestamps before removing the tracker

This patch adds ice_ptp_wait_for_tracker_drain(). It polls the PHY Tx
timestamp ready bitmap for up to 10 ms, until every in-use tracker index
reports ready. ice_ptp_release_tx_tracker() now calls it before
ice_ptp_flush_tx_tracker(), so in-flight captures get cleared instead of
being left as orphaned ready bits, and E810 is skipped via
tx->has_ready_bitmap.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 32be908373c30..ca581490f3edb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -751,6 +751,68 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)

[ ... ]

> +static void
> +ice_ptp_wait_for_tracker_drain(struct ice_pf *pf, struct ice_ptp_tx *tx)
> +{
> +	bool drained;
> +	int err;
> +
> +	if (!tx->has_ready_bitmap)
> +		return;

[Severity: Medium]
Does this wait do anything useful on E830? ice_ptp_init_tx() sets:

	tx->has_ready_bitmap = pf->hw.mac_type != ICE_MAC_E810;

E830 passes this check. ice_ptp_is_tracker_drained() then polls the
E830 valid bits through ice_get_phy_tx_tstamp_ready_e830() for up to
10 ms.

The flush that follows calls ice_clear_phy_tstamp() for each ready
index, and that function has no E830 case:

drivers/net/ethernet/intel/ice/ice_ptp_hw.c:ice_clear_phy_tstamp() {
	switch (hw->mac_type) {
	case ICE_MAC_E810:
		return ice_clear_phy_tstamp_e810(hw, block, idx);
	case ICE_MAC_GENERIC:
		return ice_clear_phy_tstamp_e82x(hw, block, idx);
	case ICE_MAC_GENERIC_3K_E825:
		return ice_clear_ptp_tstamp_eth56g(hw, block, idx);
	default:
		return -EOPNOTSUPP;
	}
}

ice_ptp_flush_tx_tracker() ignores the return value, so the failure is
silent.

The commit message says:

  Only later devices (E822, E825, E830) have the bitmap and potential
  issues with internal tracking.

On E830, won't the valid bits this wait collected still be set after
the flush? If so, the patch adds up to 10 ms of latency there without
fixing the desync.

ice_read_phy_tstamp() already has an E830 case that reads
E830_PRTTSYN_TXTIME_H/L, but the clear path never uses it. Should
ice_clear_phy_tstamp() get an E830 case, or should E830 skip the wait?
The E830 case is still missing at the end of the series.

> +
> +	err = read_poll_timeout(ice_ptp_is_tracker_drained,
> +				drained, drained, 500, 10 * USEC_PER_MSEC, false,
> +				pf, tx);
> +	if (err) {
> +		dev_dbg(ice_pf_to_dev(pf), "Timed out waiting for in-flight Tx timestamps on block %u\n",
> +			tx->block);
> +	}
> +}

[ ... ]

> @@ -868,6 +930,8 @@ ice_ptp_release_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
>  	/* wait for potentially outstanding interrupt to complete */
>  	synchronize_irq(pf->oicr_irq.virq);
>  
> +	ice_ptp_wait_for_tracker_drain(pf, tx);
> +
>  	ice_ptp_flush_tx_tracker(pf, tx);

[Severity: Medium]
Is the Tx path still live when this runs? On the remove and devlink
reload paths the order is:

ice_unload()
  ice_deinit_features()
    ice_ptp_release()
      ice_ptp_release_tx_tracker()
        ice_ptp_wait_for_tracker_drain()
        ice_ptp_flush_tx_tracker()
  ...
  ice_unregister_netdev()

Nothing quiesces the Tx queues before the tracker is released.
ice_ptp_release() masks PFINT_OICR_TSYN_TX and turns off Rx
timestamping. Clearing tx->init only stops ice_ptp_request_ts() from
handing out new indexes.

Two cases seem to slip past the 10 ms wait:

  ice_tstamp() has already reserved an index through
  ice_ptp_request_ts(), but the TSYN context descriptor has not been
  posted yet.

  A TSYN descriptor stays in the hardware Tx ring for more than 10 ms,
  for example at low link speed, under PFC/pause backpressure, or with
  rate limiting.

In either case read_poll_timeout() times out with only a dev_dbg().
ice_ptp_flush_tx_tracker() then sees the index as not ready, skips
ice_clear_phy_tstamp(), and frees the entry. When the frame finally
goes out, the PHY sets a ready bit (Q_REG_TX_MEMORY_STATUS on E82x)
that no tracker owns.

On E82x that quad memory is shared with the other ports of the quad,
possibly including ports owned by other PFs. ice_ptp_process_tx_tstamp()
only walks in_use, so nothing ever reads the orphaned entry.

Isn't that the same "delivery for the whole quad degrades to the
periodic work" situation the commit message describes? Would it be more
robust to flush after Tx has been stopped, instead of relying on a fixed
timeout? The ordering is the same at the end of the series.

>  
>  	kfree(tx->tstamps);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015191102.1174111-1-anthony.l.nguyen%40intel.com
