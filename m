Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971840;
	b=igFLbjQRRJL1C8if+AD+2+WfMlz5pVrm5RaXppY5h6mVW7UAkuEN4jakUZhlMrff1766
	 4imxvMUpuZS33qMjopVaDYq1N88QVQE1zyqr9PpCmMtMt96Ix0WgHA5fVl2019gfdM2CB
	 zEOgbqCElHc0uxsGMKrfPdMgy0XSZ7C7c9Ss4lqUTBGcwyyjOA/EhY3nlSW5F/ivVZp1S
	 i3pG9XUHClr5D5N7l6msWIL/us5t81bF41OTjDg78wWPr0SKSLx9l5XcKtfjb6TC910K0
	 gvKcHr8FoL6mjjq18Tbn5nROt2vZ7CzbvNBGv//3GSpG12sZl0PDkiN4KErYeK2eReA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971840;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PYWpe1SLz98ganGEahJ4kk+mAlyWdY8uFNrTFL/Ch6k=;
	b=0AOAmxurE2w2hBoYrJknCCGG41EjWGWWW3QoVKehqOdte63QuUzFoAWatZX/KIAF9txH
	 zVL/5tOBNxKvbo+uUHIrB9fNnSt2H3CDg5PXDFpbADZJy25O8wylgyks8NqOTpaEp1Y/J
	 w8tSCJvbIlPUHA4LiN4kay7jP4Yikx8SdlYTAgjHKTyAlKZ34DrORlZC9HjzPGnYv/mxZ
	 Rr37Pm3gpL33XKUgza0kHZ/wQQS97n9liMI7MJQZwxSyydzSXikTrGxu6B08v0DIi7Vo1
	 gpv1SZkrlpYxx1meaObN55ud2ZCVPIPcrmU0rhbvsfq8Y9jdo44DSd+A/g6vg2bOZSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0LgcVr5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616CA606A322
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0LgcVr5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6A81F01828;
	Sun, 25 Oct 2026 23:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971840;
	bh=PYWpe1SLz98ganGEahJ4kk+mAlyWdY8uFNrTFL/Ch6k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K0LgcVr5qwoFG1pM2UVO8mKP5IZ31H8+AmXShJ+LB5K2VZ0zuIaxbP11bY9RlFJbp
	 yhPA31HK0xD/JSyee/UoqpNBby1awDKgYU9266vqSGtDcFeBJ6xdqIoWSNiPDA9e3R
	 Gq2yW4r94CUIcpANtKeXOAgui/HPjWSYPVPkIpouoFG9bYOpmonjWnDDXEdLyPboaW
	 QYtid4IFVCljWPUC56fdaVFnCs8FkkiRnSkIDYcUuDRWmW92De8aAryF5LIx+wRIIM
	 jJaL1cWo8WbpZ6ZZHBPVYmygmB+3Q4tlrJ+RTzjoThvP+n4eaKNiLWITUhQ8c5FRbV
	 lM6h+xty3xLYA==
Subject: Re: [PATCH net v5 07/13] ice: E822: cancel offset verification work
 during reset preparation
From: netdev-bot+sashiko@kernel.org
To: jacob.e.keller@intel.com
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, poros@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com,
 anthony.l.nguyen@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org
Date: Sun, 25 Oct 2026 23:43:58 +0000
Message-ID: <179297183889.3134.7235166603160633075@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes?=
 =?utf-8?q?-srcu-v5-7-72289a4ac8eb=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes-?=
 =?utf-8?q?srcu-v5-7-72289a4ac8eb=40intel=2Ecom=3E?=
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

- [High] On E822 (ICE_MAC_GENERIC), a PF reset (PFR) during Vernier
  calibration leaves Tx timestamping disabled on that port until the…

--

ice: E822: cancel offset verification work during reset preparation

This commit cancels the E822 offset verification work (ov_work) in
ice_ptp_prepare_for_reset(). According to the commit message, the PHY is
reconfigured after any reset, either by the clock owner rebuild or by
ice_ptp_link_change() at the end of the rebuild. On that basis the work is
not needed while the reset runs.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 57e2606655c4..6e1f60d7eef7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -3004,6 +3004,9 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  
>  	kthread_cancel_delayed_work_sync(&ptp->work);
>  
> +	if (hw->mac_type == ICE_MAC_GENERIC)
> +		kthread_cancel_delayed_work_sync(&ptp->port.ov_work);
> +
>  	if (reset_type == ICE_RESET_PFR)
>  		return;

[Severity: High]
Can a PF reset during vernier calibration leave Tx timestamps disabled on
this port?

The new cancel sits before the ICE_RESET_PFR early return, so it also runs
for PFR. ice_ptp_wait_for_offsets() is the only code that programs the
offsets and sets P_REG_TX_OR/P_REG_RX_OR. It is also the only place that
clears port->tx.disabled:

ice_ptp_wait_for_offsets() {
    ...
		spin_lock_irqsave(&port->tx.lock, flags);
		if (port->tx.disabled) {
			port->tx.disabled = false;
    ...
}

After a PFR, nothing seems to queue ov_work again. For PFR,
ice_ptp_rebuild() skips the owner rebuild, and ice_ptp_restart_all_phy()
along with it:

ice_ptp_rebuild() {
    ...
	if (ice_pf_src_tmr_owned(pf) && reset_type != ICE_RESET_PFR) {
		err = ice_ptp_rebuild_owner(pf);
    ...
}

If the link was up both before and after the reset, the
ice_ptp_link_change() call at the end of ice_rebuild() returns early:

ice_ptp_link_change() {
    ...
	if (READ_ONCE(ptp_port->link_up) == linkup)
		goto out_unlock;
    ...
}

The only other path that queues ov_work is ice_ptp_port_phy_restart(). It
is reached only from ice_ptp_init() at probe time and from
ice_ptp_restart_all_phy(), via settime or the owner rebuild.

Calibration needs at least one Tx packet, so after link up ov_work can keep
requeuing itself every 100ms. A PFR in that window would cancel it.
Examples are an ethtool reset, Tx timeout recovery, a VSI rebuild failure
that schedules ICE_RESET_PFR, or an IIDC function reset.

After that, TX_OR/RX_OR stay at the 0 that ice_stop_phy_timer_e82x()
wrote, and tx.disabled stays true. ice_ptp_request_ts() then rejects every
Tx timestamp request until the link flaps or the PHC is set.

Before this patch, the in-flight work saw ice_is_reset_in_progress(),
requeued itself, and finished calibration after the reset. Later patches in
the series don't appear to change any of these paths.

This also seems to contradict this part of the commit message:

    However, a device reset will result in the PHY being reconfigured either as
    part of the clock owner resetting or due to the ice_ptp_link_change() call
    at the end of the rebuild.

Neither of those paths runs on a PFR when the link state doesn't change.

Is there also a timing-dependent variant on CORER/GLOBR? The clock owner's
ice_ptp_restart_all_phy() could restart a non-owner E822 peer's PHY and
queue its ov_work before the peer's own ice_ptp_prepare_for_reset() runs.
The peer's new cancel would then drop that work, and the peer's rebuild
does not restart its PHY.

Would it work to cancel only for non-PFR resets where the PHY is known to
be restarted? Another option is to requeue ov_work, or call
ice_ptp_port_phy_restart(), during the E822 rebuild when the link is up.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb%40intel.com
