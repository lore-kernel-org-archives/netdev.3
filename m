Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400027;
	b=yrQt2IV+F9Qsy3Lxth4DUFIpI2plz90ftIswLNM9Jek0hAW6aPQqu8+R3XbFI944FM2S
	 wFw4gZqLQPTM/E+AJLJ4PMyjrz0pLQWD2ddPseTk2L1640afNFqLcF03g+zVg7RQT2ldk
	 62w8WfWefLsEl1C6Ig2aq/nLjdHP7mjQ+YhnZGpF0bPyoGbgg22NS7ml93HLW6Qd3N1e6
	 iqYGkz22ONpFhcHtvwiUcLtFQgboTAFphtKljzGex59365KeN96J4El2/MvUtZfBcyilp
	 IiR/GALeggVwSvWbLrqT985n0o8d2fksW9Hg4+mR2yOVCLPFvUCPN40n6znPPkNJaSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400027;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vAF4izMEDM2y5cyzFb6fR/2GWqvZbCnGFDII4gspu00=;
	b=X9+wATU+80XpQ/mTGy8AU8bMUAff1XU94KMivONIAcTBfeDPZsWueqQ3nQ+LSSJOSoFd
	 wSNHuESPmpsVSirz6OvBzeiZGWEC9a930lfG/+5TZKWgdHXDQFhU6HuCl3Ff+D5IAbrl6
	 n1iXasgME/DGPKs07nRezfePyifvIfApY3WakEc8xt7xEkhQuaLD9wNaMJ7Odwdpn+gdd
	 pMTjI8wDMfaCeeIIyWHuKo13gRxU2ecg34vgnTG8W3FRx8Pn6uTWJnMBROcKpYPY7Q24O
	 ieadkRRIK7sjJW6t83RCDN6JZ9EHZ2fibwcPjePROJlDcp24qd8U5WCl4hcgmLm7WLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Az9jdJKK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3EC606A331
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Az9jdJKK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00051F00A15;
	Fri, 30 Oct 2026 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400026;
	bh=vAF4izMEDM2y5cyzFb6fR/2GWqvZbCnGFDII4gspu00=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Az9jdJKKucZFt6Xh76zleft4cbmOw97yy2cPBqV5XYocSeU80MKEcraR+uW73tZ2P
	 h2x3aDVf1DX1Z9lw0T41qjy3Qc4h121Wsqa7rvERCN8S6v85KfbrBTlqMaNK3p8VY0
	 3S9HB45/iAQPjGRIXgY9Ww+/EtAxUxeGLmRjwGi+iPNDgoTX6kSx6Fzfz7l5kURuTB
	 xMCGKE6cMTbYjXphZq+uwwkVZmDdoC9Xd30wvda1LzeaFigpCnDqxdk3sxUxyT7Y41
	 HlBTYef8RH74T6FaN+kUTDobonOJlfYVfPfpB2e4l44YGkFynjRRYTp8WAETn+PXk1
	 JSdD+gAo4xy8g==
Subject:
 Re: [PATCH net v3 1/2] enic: retain admin-channel DMA until queues stop
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: netdev@vger.kernel.org, sebaddel@cisco.com, aradhana@cisco.com,
 rfaucett@cisco.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Date: Fri, 30 Oct 2026 22:40:25 +0000
Message-ID: <179340002556.3131.229561522947370936@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261027-b4-enic-dma-vf-index-net-generic-first-v1?=
 =?utf-8?q?-20261010-v3-1-ba237ed71241=40cisco=2Ecom=3E?=
References: =?utf-8?q?=3C20261027-b4-enic-dma-vf-index-net-generic-first-v1-?=
 =?utf-8?q?20261010-v3-1-ba237ed71241=40cisco=2Ecom=3E?=
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

- [Medium] enic_remove() now holds rtnl_lock() across the V2 VF PF-
  unregister handshake and enic_admin_channel_close(), not just across…
- [Low] A failed VF re-registration in enic_admin_chan_reopen() can leave
  enic->vf_registered true after the channel has been closed.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  touches the exact line: when enic_open() fails inside enic_reset() or…

--

enic: retain admin-channel DMA until queues stop

This patch tracks the admin channel as DOWN, LIVE or QUARANTINED. When the
admin WQ/RQ cannot be shown to have stopped, it keeps the admin DMA graph
instead of freeing it. The reset workers and the probe/remove paths are
changed so they refuse to reopen or free a quarantined channel, and removal
holds RTNL while it detaches the netdev and closes the channel.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 6b5824f45a14c..5a1621599c5f5 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c

[ ... ]

> @@ -2287,7 +2309,8 @@ static void enic_reset(struct work_struct *work)
>  	enic_dev_set_ig_vlan_rewrite_mode(enic);
>  	enic_ext_cq(enic);
>  
> -	enic_open(enic->netdev);
> +	if (enic_open(enic->netdev))
> +		goto reset_out;

[Severity: High]
This is a pre-existing issue and not introduced by this patch, but this
line is being touched: what state is the netdev left in when enic_open()
fails here?

By this point enic_stop() has already called napi_disable() on every NAPI
and has called enic_free_intr(). enic_open() can then fail in
enic_request_intr(), page_pool_create(), the RQ fill or enic_dev_enable().
Its unwind disables the NAPIs it enabled and calls enic_free_intr() again.
__LINK_STATE_START and IFF_UP stay set the whole time.

enic_free_intr() also never clears msix[i].requested:

	case VNIC_DEV_INTR_MODE_MSIX:
		for (i = 0; i < enic->intr_count; i++)
			if (enic->msix[i].requested)
				free_irq(enic->msix_entry[i].vector,
					enic->msix[i].devid);

Any of these would then run enic_stop() again over the released
resources: a later ip link set down, the new dev_close() in the quarantine
branch of a later reset, or unregister_netdev() from enic_remove():

enic_stop()
    napi_disable(&enic->napi[i])    <- already disabled
    ...
    enic_free_intr(enic)            <- vectors already freed

Can the second napi_disable() loop forever in napi_disable_locked() while
RTNL is held? NAPIF_STATE_SCHED and NAPIF_STATE_NPSVC are still set from
the first disable. The repeated free_irq() calls would also WARN.

enic_tx_hang_reset() has the same sequence, with the same new
goto reset_out after a failed enic_open().

>  
>  	/* Re-establish the admin/MBOX channel after the data path is back up.
>  	 * It was fully torn down by enic_admin_channel_close() above;
> @@ -2296,12 +2319,17 @@ static void enic_reset(struct work_struct *work)
>  	 */
>  	if (enic_has_admin_chan(enic))
>  		enic_admin_chan_reopen(enic);
> +	if (enic_is_sriov_vf_v2(enic) &&
> +	    enic_admin_channel_is_quarantined(enic))
> +		dev_close(enic->netdev);

[Severity: Low]
Can vf_registered stay true after enic_admin_chan_reopen() closes the
channel because re-registration failed?

The commit message says:

  "Clear local VF registration after draining channel replies, including
  when recovery exits early."

The clears added to enic_reset() and enic_tx_hang_reset() run before the
reopen. The failure path inside enic_admin_chan_reopen() does not clear the
flag afterwards:

		err = enic_mbox_vf_register(enic);
		if (err) {
			netdev_err(...);
			enic_admin_channel_close(enic);
		}

enic_mbox_send_msg_id() publishes mbox_expected_reply and
mbox_expected_msg_num before it rings the doorbell. It then polls the WQ CQ
for up to 5 s while holding only mbox_lock. During that window,
admin_msg_work can accept a REGISTER_REPLY in enic_mbox_vf_handle_reply():

		case ENIC_MBOX_VF_REGISTER_REPLY:
			WRITE_ONCE(enic->vf_registered, true);

If the sender still sees no WQ completion, it returns -ETIMEDOUT. That
error comes back through enic_mbox_vf_register(), and the channel is closed
with vf_registered still set.

enic_remove() later sees vf_registered and calls enic_mbox_vf_unregister().
That call fails with -ENODEV because mbox_send_disabled is set, and remove
logs "Failed to unregister from PF".

Should vf_registered also be cleared after the enic_admin_channel_close()
calls in enic_admin_chan_reopen()?

[ ... ]

> @@ -3397,6 +3454,8 @@ static void enic_remove(struct pci_dev *pdev)
>  		disable_work_sync(&enic->reset);
>  		disable_work_sync(&enic->tx_hang_reset);
>  		disable_work_sync(&enic->change_mtu_work);
> +		rtnl_lock();
> +		netif_device_detach(netdev);
>  
>  		/* Close the admin channel and unregister from the PF before
>  		 * unregister_netdev() to prevent a late PF notification from
> @@ -3413,6 +3472,7 @@ static void enic_remove(struct pci_dev *pdev)
>  			}
>  			enic_admin_channel_close(enic);
>  		}
> +		rtnl_unlock();

[Severity: Medium]
Is RTNL held here for longer than it needs to be?

The new RTNL section covers the whole V2 VF unregister handshake and the
channel close:

enic_remove()
  rtnl_lock()
  enic_mbox_vf_unregister()
    enic_mbox_send_msg_id()           <- WQ CQ poll, up to 5 s
    enic_mbox_wait_reply(enic, 3000)  <- up to 3 s
  enic_admin_channel_close()
    enic_admin_qp_type_set(enic, QP_DISABLE)
    enic_admin_wq_disable()           <- 500 ms, retried on -ETIMEDOUT
    enic_admin_rq_disable()           <- 2 x 500 ms, retried on -ETIMEDOUT
  rtnl_unlock()

The new admin helpers poll with:

	return read_poll_timeout(ioread32, running, !running, 10, 500000,
				 false, &wq->ctrl->running);

These replace the earlier vnic_wq_disable()/vnic_rq_disable() polls of
about 10 ms.

This patch targets the case where the admin queues don't stop or the PF
doesn't respond. In that case, could removing the VF stall every RTNL user
for roughly 8 to 11 seconds? The same longer queue polls now also run under
RTNL and mbox_lock in enic_reset() and enic_tx_hang_reset().

The reset works are already disabled at this point. After rtnl_unlock(),
both enic_open() and the core check netif_device_present(). Would holding
RTNL only around netif_device_detach() be enough to keep a concurrent open
out?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v3-0-ba237ed71241%40cisco.com
