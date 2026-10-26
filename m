Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017131;
	b=zhB4ZNACFF1iQ+1qyka2wEt5UWPVBRwsQ66cvWRPGnACi/wg2oLnMlZwdRCboRMj1pME
	 shKzYK5+NQudR0GX8XGfzq3mw+x7nKJYkICj6VnDRNoy+/r2bFiCO/adSNfpiBO5zye8f
	 1zzZZeY/9L7FjsfxjQQ5R8ICWh1PpEtW4YvxHMUalFhdjb5q2NXzfwqo1kC3+RHJDMKVV
	 BRwOgIIrpi/rgwssAH8NYj7AFzBG/NVrxeDuHhXANnlZxfJaLB00xSRv3+xcSfDLoeZv8
	 mhPnj6uVOvC5ypgkV0M1HTnP9m/wj5OcDqdiBAm1DyQpJrzRuXSKiOXLE3BSskOEaug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017131;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cTBJRTPeS84dOB9s5x8uR4MEgNCw0/1iG7T79mAeXR0=;
	b=ifZM2/GgCN6Sh3PhdG0BBv2N+6u1cljoKpmtkQpyJgLbwH325rJ3U7doLNoYPjsW/jA7
	 eN0N3wQJHtmsHzWUfOGKLo7X5O9o+m0pk/e60sDqePxRiC5ppYQcbdWxT53+yv1dvBInJ
	 +Vpt3mny6HHDo6iL+V4lEO9tb8hCBWzIjXYVh1P0ikkO9ElnWKyp1tl33K78vD1uhoKVf
	 u92rZielfPRjoL6Yauo6ZkEP0LfQlY7jvIaKzZ1i5HsS9LI9IgAbYGTyiIviXbm+6J8Dq
	 qDF05vql6rYD2at4guqE6hBk+Oa7PAuDMzV1Yb1g9MxNxqu6rp0QTi4XSH0W0qE/nzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBCANcMU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC61606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBCANcMU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28821F031E0;
	Mon, 26 Oct 2026 12:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793017130;
	bh=cTBJRTPeS84dOB9s5x8uR4MEgNCw0/1iG7T79mAeXR0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JBCANcMUblCq6jrmcYGPXMauy/Z2zjhSYsyP4ka2wV5sKzPIjzGGfIrCGvdA1qT8R
	 BDLXd+SF2o5KliivpJA8U8TjFWidk384bOqRgYItMUseXbi+ZFpMyJOYH+RXLvN/NA
	 WCQC4iiOpaf+nJcI/8hYCXwLtXyxcz3eeW082CzZAQrRti2fnwTYVC7FHnNnIDfZ/v
	 PYRxAo82ruPaBavWc9vhtifP3a5ibR6bsug9zF7mPiyEr0FaZLV67bjmC76QVqVqbr
	 qirNXeMrVZMOinToVyLThcFm7oDZY5EBz8/dC91eiHtJMkB3V2wqb312+iJldcdX52
	 MDWL2Q5akh8bQ==
Subject:
 Re: [PATCH net v2 1/2] enic: retain admin-channel DMA until queues stop
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: netdev@vger.kernel.org, sebaddel@cisco.com, aradhana@cisco.com,
 rfaucett@cisco.com, kuba@kernel.org
Date: Mon, 26 Oct 2026 12:18:49 +0000
Message-ID: <179301712918.3134.8314049527043073547@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261022-b4-enic-dma-vf-index-net-generic-first-v1?=
 =?utf-8?q?-20261010-v2-1-8db19b4a714e=40cisco=2Ecom=3E?=
References: =?utf-8?q?=3C20261022-b4-enic-dma-vf-index-net-generic-first-v1-?=
 =?utf-8?q?20261010-v2-1-8db19b4a714e=40cisco=2Ecom=3E?=
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

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 5 (1) · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message understates what users will see when the
  admin channel is quarantined.
- [Medium] enic_admin_channel_close() now takes
  mutex_lock(&enic->mbox_lock), which can be held by a sender for up to…
- [Medium] The quarantine checks use different conditions.
- [Medium] enic_admin_wq_disable() and enic_admin_rq_disable() treat only
  `running == 0` as stopped.
- [Medium] The concern says the retained BAR reservation does not fence
  the device: vfio-pci or pci-stub can bind without requesting regions,…
- [Low] The patch adds early exits to enic_reset() and
  enic_tx_hang_reset(): `if (quarantined) { dev_close(); goto reset_out;…
- [Low] The probe and remove paths handle a quarantined channel
  differently.
- [Low] The commit message does not describe several behaviour changes
  that apply even when no admin queue ever times out: (1) a new `if…
- [Low] The new comment in the quarantine branch of enic_reset() says
  "Core close excludes netpoll and clears IFF_UP before ndo_stop." That…
- [Low] Two problems around mbox_tx_poisoned.

Pre-existing issues:
- [High] This bug was not introduced by this patch, but the patch
  rewrites the exact line involved and leaves it in place.
- [Medium] This problem wasn't introduced by this patch, but: enic_stop()
  returns early when vnic_wq_disable() or vnic_rq_disable() on a…

--

enic: retain admin-channel DMA until queues stop

This patch tracks the enic admin channel as DOWN, LIVE or QUARANTINED. When
an admin WQ or RQ disable times out, the admin allocations are now kept
instead of freed. The reset paths close the netdev rather than reopen a
quarantined channel, and enic_open() refuses to open a quarantined V2 VF.
On remove, a final queue recheck is made. If that recheck fails, the
netdev, vnic_dev, admin allocations and BAR reservation are kept until
reboot.

> diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
> index 7a509a0569900..4bf30d78383b2 100644
> --- a/drivers/net/ethernet/cisco/enic/enic.h
> +++ b/drivers/net/ethernet/cisco/enic/enic.h

[ ... ]

> @@ -298,13 +304,12 @@ struct enic {

[ ... ]

>  	bool mbox_send_disabled;
> +	/* A posted send timed out; its mapping remains on the admin WQ. */
> +	bool mbox_tx_poisoned;

[Severity: Low]
Is this comment accurate? enic_admin_channel_close() also sets
mbox_tx_poisoned whenever an admin WQ or RQ disable times out, even if no
send is pending:

	if (wq_err || rq_err) {
		WRITE_ONCE(enic->admin_chan_state, ENIC_ADMIN_CHAN_QUARANTINED);
		WRITE_ONCE(enic->mbox_tx_poisoned, true);

A related question: can the new -EIO check in enic_admin_channel_open()
ever be reached?

The flag is only set while the state is LIVE (send timeout) or
QUARANTINED (close). Both release paths set the state to DOWN and clear
the flag under mbox_lock. That means this earlier check always returns
first:

	if (READ_ONCE(enic->admin_chan_state) != ENIC_ADMIN_CHAN_DOWN) {
		...
		return -EBUSY;
	}

The only way to hit "Refusing to reopen poisoned admin channel" is an open
that races a release, between WRITE_ONCE(admin_chan_state, DOWN) in
enic_admin_channel_release() and the WRITE_ONCE(mbox_tx_poisoned, false)
that follows it. In that case the refusal would be spurious.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
> index 61c82b48044d0..4325c6d9c30e3 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_admin.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_admin.c

[ ... ]

> @@ -600,60 +613,51 @@ int enic_admin_channel_open(struct enic *enic)

[ ... ]

> -void enic_admin_channel_close(struct enic *enic)
> +static int enic_admin_wq_disable(struct enic *enic)
>  {

[ ... ]

> +	struct vnic_wq *wq = &enic->admin_wq;
> +	u32 running;
>  
> -	netdev_dbg(enic->netdev, "admin channel close\n");
> +	iowrite32(0, &wq->ctrl->enable);
> +	return read_poll_timeout(ioread32, running, !running, 10, 500000,
> +				 false, &wq->ctrl->running);
> +}

[Severity: Medium]
What happens here if the function is gone, for example after a surprise
hot-unplug, an AER or link-down event, or a host-side PF reset seen by a
guest? ioread32() on the running register would return 0xFFFFFFFF. The
!running condition then never holds, and read_poll_timeout() returns
-ETIMEDOUT. enic_admin_rq_disable() has the same problem.

Elsewhere the driver already treats an all-ones read from this control
block as hardware gone, for example in vnic_rq_clean():

	if (fetch_index == 0xFFFFFFFF) { /* check for hardware gone  */

With this patch, that read leads to a decision that cannot be undone:

- enic_admin_channel_close() sets QUARANTINED and mbox_tx_poisoned.
- enic_admin_channel_recheck_on_remove() fails the same way.
- enic_remove() takes the retain path. It keeps the pci_dev reference,
  netdev, vnic_dev, admin allocations and DMA mappings for a device that
  cannot be doing DMA.

Before the patch, the same read only produced a warning and normal
teardown.

Each pass also now waits 500 ms instead of about 10 ms. A surprise-removed
VF therefore spends several seconds under rtnl and mbox_lock, plus the 5 s
unregister send poll, before its resources are leaked.

Could an all-ones value be treated as device gone in these helpers?

[ ... ]

> @@ -662,6 +666,114 @@ void enic_admin_channel_close(struct enic *enic)

[ ... ]

> +	/* A sender may have passed the gate before it was raised.  Wait only
> +	 * after cancelling workers which can themselves wait for mbox_lock.
> +	 */
> +	mutex_lock(&enic->mbox_lock);
> +	qp_err = enic_admin_qp_type_set(enic, QP_DISABLE);
> +	if (qp_err)
> +		netdev_warn(enic->netdev,
> +			    "Failed to disable admin QP type: %d\n", qp_err);
> +
> +	wq_err = enic_admin_wq_disable(enic);
> +	rq_err = enic_admin_rq_disable(enic);
> +
> +	/* Run both complete disable helpers once before retrying only a helper
> +	 * which timed out.
> +	 */
> +	if (wq_err == -ETIMEDOUT)
> +		wq_err = enic_admin_wq_disable(enic);
> +	if (rq_err == -ETIMEDOUT)
> +		rq_err = enic_admin_rq_disable(enic);

[Severity: Medium]
How long can rtnl be held across this?

mutex_lock(&enic->mbox_lock) can wait up to ENIC_MBOX_POLL_TIMEOUT_US (5 s)
for an in-flight sender. After that, the sleeping polls run with the mutex
held:

- WQ: up to 500 ms, plus one retry.
- RQ: two 500 ms passes, plus one retry.

That is roughly 3 s per close, compared with about 10 ms before.

enic_reset() and enic_tx_hang_reset() hold rtnl across this close.
enic_remove() now also takes rtnl around both the VF unregister and this
close:

		rtnl_lock();
		netif_device_detach(netdev);
		...
				int unreg_err = enic_mbox_vf_unregister(enic);
		...
			enic_admin_channel_close(enic);
		}
		rtnl_unlock();

enic_mbox_vf_unregister() can spend up to 5 s in the send poll plus a
3000 ms reply wait. A device that misbehaves can therefore hold the global
RTNL for more than 10 s during a single remove.

Does rtnl need to cover more than netif_device_detach() in enic_remove()?

The commit message only says "Poll for up to 500 ms per pass" and gives no
total. Could it state the worst case?

[ ... ]

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 6b5824f45a14c..838b6dc837ee4 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
> @@ -1736,6 +1736,13 @@ static int enic_open(struct net_device *netdev)
>  		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>  	};
>  
> +	/* Internal reopen paths also bypass the networking core's presence check. */
> +	if (!netif_device_present(netdev))
> +		return -ENODEV;
> +	if (enic_is_sriov_vf_v2(enic) &&
> +	    enic_admin_channel_is_quarantined(enic))
> +		return -EBUSY;

[Severity: Medium]
The commit message says:

  Keep bus mastering enabled at runtime so the independent datapath and
  command transport remain usable.

Is that accurate for a V2 VF? Once the channel is QUARANTINED, this check
makes every enic_open() return -EBUSY. The only way out of QUARANTINED is
a successful enic_admin_channel_recheck_on_remove(). Until reboot,
"ip link set up" keeps failing.

enic_reset() and enic_tx_hang_reset() also call dev_close() as soon as
they see quarantine. That happens either right after
enic_admin_channel_close() or after enic_admin_chan_reopen() fails.

For a PF, every later soft or hang reset becomes a plain dev_close(), and
the hardware reset is skipped.

Could the commit message describe these effects? The patch carries a
Fixes: tag and may be picked up for stable.

[ ... ]

> @@ -2275,6 +2288,11 @@ static void enic_reset(struct work_struct *work)
>  	 */
>  	if (enic_has_admin_chan(enic))
>  		enic_admin_channel_close(enic);
> +	if (enic_admin_channel_is_quarantined(enic)) {
> +		/* Core close excludes netpoll and clears IFF_UP before ndo_stop. */

[Severity: Low]
Is the ordering in this comment right? __dev_close_many() clears
__LINK_STATE_START before ndo_stop. IFF_UP is only cleared after ndo_stop
returns:

		if (ops->ndo_stop)
			ops->ndo_stop(dev);

		netif_rx_mode_cancel_retry(dev);
		netif_set_up(dev, false);

So IFF_UP is still set while enic_stop() runs from this dev_close().

> +		dev_close(enic->netdev);
> +		goto reset_out;
> +	}

[Severity: Medium]
Should this check also be limited to enic_is_sriov_vf_v2()?

The close above runs under enic_has_admin_chan(), which also covers a PF
with SR-IOV V2 enabled. For a quarantined PF, this branch calls dev_close()
and skips enic_dev_soft_reset().

The check after reopen further down is VF-only, and so is the gate in
enic_open():

	if (enic_is_sriov_vf_v2(enic) &&
	    enic_admin_channel_is_quarantined(enic))
		return -EBUSY;

So userspace can bring the PF straight back up on hardware that never got
its reset. enic_admin_channel_close() keeps returning -EBUSY and the state
stays QUARANTINED, so each later reset request becomes another dev_close().
A PF hang then never gets recovered.

It also goes the other way. If enic_admin_chan_reopen() ends up
quarantining the channel, a VF is closed but a PF keeps its datapath open.

The same unqualified check is in enic_tx_hang_reset(). This is latent
today because .sriov_configure is not wired up, so a PF never opens the
admin channel.

> @@ -2287,7 +2305,8 @@ static void enic_reset(struct work_struct *work)
>  	enic_dev_set_ig_vlan_rewrite_mode(enic);
>  	enic_ext_cq(enic);
>  
> -	enic_open(enic->netdev);
> +	if (enic_open(enic->netdev))
> +		goto reset_out;

[Severity: High]
This isn't a bug introduced by this patch, but since this line is being
rewritten: what state is the netdev left in when enic_open() fails here?

IFF_UP and __LINK_STATE_START are still set. enic_open() has already
undone its own work: enic_free_intr(), enic_dev_notify_unset(), and the
page pools destroyed. The NAPI instances are still disabled from the
enic_stop() call earlier in the reset.

The next ndo_stop runs enic_stop() again. That can come from "ip link set
down", or from unregister_netdev() in enic_remove(), since
__dev_close_many() allows ndo_stop after a DETACH:

enic_stop()
    napi_disable(&enic->napi[i])
        napi_disable_locked()
            while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
                usleep_range(20, 200);
                val = READ_ONCE(n->state);
            }

A napi_disable() that has completed leaves SCHED and NPSVC set. Can this
loop spin forever with rtnl held?

Even if the loop were passed, enic_free_intr() would call free_irq() a
second time, because msix[i].requested is never cleared on free.

Any of these failures in enic_open() can trigger this:

- page_pool_create() returning ENOMEM
- vnic_rq_fill() producing no buffers
- enic_dev_notify_set() failing
- request_irq() failing
- enic_dev_enable() failing

The quarantine branch above calls dev_close(). Should this open-failure
branch do the same? enic_tx_hang_reset() has the same pattern.

[Severity: Low]
This exit and the quarantine exit above both skip
enic_admin_chan_reopen(). On the reset path, that is the only place that
clears vf_registered:

	if (enic_is_sriov_vf_v2(enic))
		WRITE_ONCE(enic->vf_registered, false);

According to its comment, this stops the VF from believing it still has a
usable PF registration over a dead channel. On these exits, vf_registered
stays true while the channel is DOWN or QUARANTINED and
mbox_send_disabled is set.

Later, at remove or in the probe err_out_admin_close path,
enic_mbox_vf_unregister() sends a request that is rejected with -ENODEV.
The driver then logs a misleading "Failed to unregister from PF: -19"
warning.

Should vf_registered also be cleared before these early exits? The same
applies to enic_tx_hang_reset().

[ ... ]

> @@ -2311,6 +2335,9 @@ static void enic_tx_hang_reset(struct work_struct *work)
>  
>  	rtnl_lock();
>  
> +	if (!netif_running(enic->netdev))
> +		goto unlock;
> +

[Severity: Low]
This isn't a bug, but the commit message does not mention several changes
that apply even when no admin queue ever times out:

- This new netif_running() check, and the one added under rtnl in
  enic_reset(). A queued TX-hang reset is now dropped if the interface has
  gone down.
- The netif_device_present() check at the top of enic_open(), which
  applies to every enic device.
- The new rtnl_lock()/netif_device_detach() section in enic_remove(),
  which wraps the VF unregister request/reply wait and the admin close.

Could the commit message describe these? That would let stable
backporters tell them apart from the DMA-lifetime fix.

> @@ -2320,6 +2347,10 @@ static void enic_tx_hang_reset(struct work_struct *work)
>  	 */
>  	if (enic_has_admin_chan(enic))
>  		enic_admin_channel_close(enic);
> +	if (enic_admin_channel_is_quarantined(enic)) {
> +		dev_close(enic->netdev);
> +		goto reset_out;
> +	}

[Severity: Medium]
This is a pre-existing issue, but the new dev_close() unwind here and in
enic_reset() depends on enic_stop() running to completion. enic_stop()
returns early when a datapath queue disable times out:

	for (i = 0; i < enic->wq_count; i++) {
		err = vnic_wq_disable(&enic->wq[i].vwq);
		if (err)
			return err;
	}

That early return skips enic_dev_notify_unset(), enic_unset_affinity_hint(),
enic_free_intr() and the ring and page pool cleanup.

dev_close() clears __LINK_STATE_START and IFF_UP whatever ndo_stop
returns. unregister_netdev() then never calls enic_stop() again, so the
datapath irqactions and page pools appear to be leaked.

The commit message says it "does not repair the separate generic datapath
queue-disable error path". Quarantine requires MSI-X, and
enic_dev_deinit()->enic_clear_intr_mode() tears down the vectors, so this
looks like a leak rather than a use-after-free. Before this patch, the same
failure left the device running and led to re-entering enic_stop().

[ ... ]

> @@ -3374,6 +3412,17 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	}
>  #endif
>  err_out_vnic_unregister:
> +	if (enic_admin_channel_is_quarantined(enic)) {
> +		/* Normal generic cleanup and CMD_CLOSE have already run. Retain
> +		 * only the inert admin/control owners and their PCI reservation.
> +		 */
> +		pci_dev_get(pdev);
> +		pci_clear_master(pdev);
> +		pci_disable_device(pdev);
> +		pci_set_drvdata(pdev, NULL);
> +		dev_err(dev, "Admin DMA unresolved; retaining resources until reboot\n");
> +		return err;
> +	}

[Severity: Low]
Should probe also call enic_admin_channel_recheck_on_remove() before it
decides to retain? enic_remove() does:

		if (enic_admin_channel_is_quarantined(enic))
			enic_admin_channel_recheck_on_remove(enic);

This path retains straight away, even though enic_dev_deinit() and
vnic_dev_close() (CMD_CLOSE) have just run and may have stopped the
queues.

Quarantine during probe can come from the partial-open unwind, a
capability-check failure or a registration failure. In each case the
netdev, vnic_dev, admin graph and BAR reservation are kept, and rebind is
blocked until reboot. Close has already polled for about 3 s at this
point, so a recheck would probably rarely change the outcome.

[ ... ]

> @@ -3429,9 +3481,25 @@ static void enic_remove(struct pci_dev *pdev)

[ ... ]

> +		if (enic_admin_channel_is_quarantined(enic)) {
> +			/* All generic queues and CPU entry points followed ordinary
> +			 * teardown. No admin buffer can return from the network stack.
> +			 * Pin the PCI object for the reservation's owner-name pointer;
> +			 * this reference does not fence DMA or preserve IOMMU state.
> +			 */
> +			pci_dev_get(pdev);
> +			pci_clear_master(pdev);
> +			pci_disable_device(pdev);
> +			pci_set_drvdata(pdev, NULL);
> +			dev_err(&pdev->dev,
> +				"Admin DMA unresolved; retaining resources until reboot\n");
> +			return;
> +		}

[Severity: Medium]
Does the retained BAR reservation keep the device away from a later owner?
vfio-pci or pci-stub can bind without requesting regions. Remove/rescan or
kexec drops the reservation and probes again, and enic_probe() then does:

	err = pci_request_regions(pdev, dev_name(dev));
	...
	pci_set_master(pdev);

There is no function reset first. Could an admin queue that is still
running then DMA through stale IOVAs into memory that now has a new owner?

Most of this looks covered today:

- Both retain paths call pci_clear_master() first.
- vfio-pci resets the function before userspace can turn bus mastering
  back on, and pci-stub never sets it.
- A V2 VF cannot be re-enumerated without toggling VF Enable, which
  resets it.
- The commit message limits the guarantee to "while the PCI device
  remains enumerated".

The remaining case seems to be a future PF quarantine followed by PF
remove/rescan and a probe without a reset. It also depends on the hardware
resuming queue DMA once bus mastering is set again.

Would a function reset before pci_set_master() in that case, or a
documented limitation, be worth considering?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v2-0-8db19b4a714e%40cisco.com
