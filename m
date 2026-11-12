Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503287;
	b=GTDHFMl/aFiCGEL8UOJVvkCeaS7bg3gcnKf4Zalgoaa2zYvxlGzpqEc63ggTCYabCKwv
	 JlO9bYHrxmp6QO5lMGRS+DFsSZVww1G5IN8YDAW5qsVgg3a3kkgQYcdoTOF7X5B2ki6fz
	 5guTizd4NgvUBBOokQrdRpNeJoaxJFTdCJI6i34MnKQq9zi1YFLq6OUCOo9Qj8uQU/KDW
	 M4t66GsrvdlAZlf/CdtvuzqdFUFCnimJffC7zIPDRpFZNZS1AZg94G44Xnc+gfsXOyu1a
	 TufrFDi803YbNIdFgi7ThKWwnfATu0acjoAFPiHqnbR1z8bvsQupVCMmyEwnD2uzt/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503287;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=l8Xa4/vmyq0qsDMCoam28ApipnagXDv+kj8KHuHRQgQ=;
	b=ycudtfcYsOvoLWrk/bFcJFbnugL5IZQIBeDjFSRz8DTcoXz463oeuHWQg8vfx8nNodO3
	 tUDili22UX2AG5+za612AioGNz44lDZxciySxm/2TaF9qk8HPn00JP1dy33FJ5BH0VC6l
	 lzB4FGNo5PtkbX3I5fRwaDJBS2xtvKrziEn7zCF/np0RyUTJ82Cv6WRnj2MW0NriS02w9
	 byTQRN8toz+a3LBwhoAa5Gca4AtnvUnt6VxUDTjF+mQNYq7++2iYU/DYow7qvH3psW47l
	 VGS5H9pwEh2o94SpAbLbaKuzNmnv8DpG8SXstGd/T0JvRXizJi7zbG94ELv42KTRqpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPfOS6Kn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD30606A330
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPfOS6Kn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8301F000C4;
	Thu, 12 Nov 2026 17:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503287;
	bh=l8Xa4/vmyq0qsDMCoam28ApipnagXDv+kj8KHuHRQgQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UPfOS6Kng6P63ucZ3pR1ZbDhsiIG2OHtch3g8f+H06kf4+G/qafojw/zY73Cserwl
	 JHHgY8QNi/gbaehYTka+cA6Bn1f9zL82eQ3DOd/d5MneSrTo33aX0v2exbwEND6y8H
	 pLILc2s4Oa846YeOWS2ewReO8a9b7ONE44JhSTVpR4LrhgorI2rAB6sSpeCm79dNq4
	 He40YP1gfvMxDOiCzqPrquXDBlyr8mxAE7HI+6sVuV2ec1Z0iqVAcngg3uZiS9D0uM
	 wPrHdKdpPP067VoXikMYnGk5uhBS5WcbvIMGmrbDTzKSjiaoPJ+esaeTlZhPcBBFhK
	 +tr4cC4KKaelw==
Subject:
 Re: [PATCH net v7 1/2] enic: retain admin-channel DMA until queues stop
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: netdev@vger.kernel.org, sebaddel@cisco.com, aradhana@cisco.com,
 rfaucett@cisco.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Date: Thu, 12 Nov 2026 17:08:06 +0000
Message-ID: <179450328635.2199510.2101319582570477640@kernel.org>
In-Reply-To: <20261109-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v7-1-30ca6f467673@cisco.com>
References: <20261109-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v7-1-30ca6f467673@cisco.com>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When the admin channel is quarantined, the reset workers close
  the netdev for every device type, but the enic_open() refusal only…
- [Low] enic_admin_channel_close() returns a nonzero value with two
  different meanings.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  rewrites the same branch and leaves it in place.

--

enic: retain admin-channel DMA until queues stop

The patch tracks the enic admin channel as DOWN, LIVE or QUARANTINED. The
admin WQ/RQ/CQ graph is released only after both queues report RUNNING == 0;
otherwise it is retained and reopening is refused. The reset workers now
abandon the reset and close the netdev when the channel is quarantined.
Probe unwind and remove keep the retained resources and the BAR reservation
until reboot.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
> index 61c82b48044d0..8a063c563a41e 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_admin.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_admin.c

[ ... ]

> @@ -662,6 +661,111 @@ void enic_admin_channel_close(struct enic *enic)

[ ... ]

> +int enic_admin_channel_close(struct enic *enic)
> +{

[ ... ]

> +	if (wq_err || rq_err) {
> +		WRITE_ONCE(enic->admin_chan_state, ENIC_ADMIN_CHAN_QUARANTINED);
> +		mutex_unlock(&enic->mbox_lock);
> +		/* Retained targets remain valid for late DMA. Keep bus mastering
> +		 * enabled for the independent datapath and command transport.
> +		 */
> +		return wq_err ?: rq_err;
> +	}
> +
> +	enic_admin_channel_release(enic);
> +	mutex_unlock(&enic->mbox_lock);
> +
> +	/* Firmware rejection does not undermine the WQ/RQ proof. */
> +	return qp_err;
> +}

[Severity: Low]
By this point the graph has been released and the state is DOWN, but the
function still returns qp_err. The only caller that checks the return value
is the disable_queues path in enic_admin_channel_open():

	close_err = enic_admin_channel_close(enic);
	if (close_err)
		netdev_err(enic->netdev,
			   "Failed to close partial admin channel: %d\n",
			   close_err);

In the partial-open cases, firmware is likely to reject QP_DISABLE. One case
is enic_admin_rq_fill() failing before QP_ENABLE was ever sent. Another is
QP_ENABLE itself failing.

Would open then log a close failure even though the channel was fully
released?

Right now a nonzero return from enic_admin_channel_close() has two meanings:

- the channel is quarantined and the graph retained (-ETIMEDOUT or -EBUSY)
- the channel was released, but firmware rejected QP_DISABLE

Could the return value tell these two cases apart?

[ ... ]

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 6b5824f45a14c..899e0b1e14be2 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c

[ ... ]

> @@ -2264,17 +2276,27 @@ static void enic_reset(struct work_struct *work)
>  
>  	rtnl_lock();
>  
> +	if (!netif_running(enic->netdev))
> +		goto unlock;
> +
>  	/* Stop any activity from infiniband */
>  	enic_set_api_busy(enic, true);
>  

[ ... ]

> -	if (enic_has_admin_chan(enic))
> +	if (enic_has_admin_chan(enic)) {
>  		enic_admin_channel_close(enic);
> +		/* Channel close has drained registration replies. */
> +		if (enic_is_sriov_vf_v2(enic))
> +			WRITE_ONCE(enic->vf_registered, false);
> +	}
> +	if (enic_admin_channel_is_quarantined(enic)) {
> +		/* Core close excludes netpoll and clears __LINK_STATE_START first. */
> +		dev_close(enic->netdev);
> +		goto reset_out;
> +	}

[Severity: Medium]
This check does not look at the device type, and it runs even when
enic_has_admin_chan() returned false. Can it close a PF and skip the soft
reset?

The other two quarantine checks apply only to a V2 VF. One is the
post-reopen check later in this function:

	if (enic_is_sriov_vf_v2(enic) &&
	    enic_admin_channel_is_quarantined(enic))
		dev_close(enic->netdev);

The other is the refusal in enic_open():

	if (enic_is_sriov_vf_v2(enic) &&
	    enic_admin_channel_is_quarantined(enic))
		return -EBUSY;

A PF admin channel can become quarantined in two ways. One is
enic_admin_channel_close() timing out here while SR-IOV V2 is enabled. The
other is enic_sriov_v2_disable(), which clears ENIC_SRIOV_ENABLED before the
close:

	enic->priv_flags &= ~ENIC_SRIOV_ENABLED;
	cancel_work_sync(&enic->link_notify_work);

	pci_disable_sriov(enic->pdev);
	enic_admin_channel_close(enic);

After that, every soft reset would dev_close() the PF uplink and skip
enic_dev_soft_reset(). The same check in enic_tx_hang_reset() would skip
enic_dev_hang_notify() and enic_dev_hang_reset().

enic_open() still allows the PF to come back up, but without the reset it
needed. The next queue error or tx hang would then close it again.

The commit message describes only the VF policy:

  "A V2 VF with a quarantined control channel is closed and cannot reopen."

Is closing the PF here intended? If it is, should enic_open() and the commit
message describe the same PF behaviour?

This looks latent for now. enic_sriov_v2_enable() is __maybe_unused and
.sriov_configure is not wired up yet, so a PF admin channel cannot be opened
today. It would become reachable when the follow-up series wires up
.sriov_configure.

>  
>  	enic_stop(enic->netdev);
>  	if (enic_is_sriov_vf_v2(enic))
> @@ -2287,7 +2309,8 @@ static void enic_reset(struct work_struct *work)
>  	enic_dev_set_ig_vlan_rewrite_mode(enic);
>  	enic_ext_cq(enic);
>  
> -	enic_open(enic->netdev);
> +	if (enic_open(enic->netdev))
> +		goto reset_out;

[Severity: High]
This is a pre-existing issue, not one introduced by this patch, but the
patch rewrites this branch. When enic_open() fails, the worker jumps to
reset_out and the netdev keeps IFF_UP and __LINK_STATE_START. Can that leave
NAPI disabled on a device the core still treats as running?

enic_stop() above has already called napi_disable() on every RQ and WQ NAPI,
and every failure exit in enic_open() leaves them disabled.
enic_request_intr(), enic_dev_notify_set(), page_pool_create() and the RQ
fill all fail before napi_enable(). The err_out_dev_enable path calls
napi_disable() again.

One way to hit this is in enic_tx_hang_reset(). If vnic_wq_disable() times
out, enic_stop() returns early without freeing the IRQs. enic_request_intr()
then fails with -EBUSY.

The next ndo_stop then runs this chain. That can be a user ifdown, the
enic_stop() in a later reset, or unregister_netdev() in enic_remove():

enic_stop()
  napi_disable()
    napi_disable_locked()

napi_disable_locked() waits on a NAPI that still has NAPIF_STATE_SCHED and
NAPIF_STATE_NPSVC set:

	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		usleep_range(20, 200);
		val = READ_ONCE(n->state);
	}

Would this loop forever while RTNL is held?

enic_stop() would also run enic_dev_notify_unset() a second time, and disable
and clean the WQs and RQs a second time, after they have already been torn
down.

The quarantine branch added above uses dev_close() to reach a consistent
closed state. Does the failed-open branch need a similar way out, both here
and in enic_tx_hang_reset()?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v7-0-30ca6f467673%40cisco.com
