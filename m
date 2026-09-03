Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF78E3BBFAD;
	Thu,  3 Sep 2026 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479084; cv=none; b=Xj32IzNaoVsqtvfK1YsO7tuKgzTZQZUJNMrpCq5SPNAlxtNWPxZnsn/dUvrf/OAGw7CA/mCI6rg+zd5PrNtz2Kd0gL2QCNUQ13gtDmiWRWOTpBfoN9fNMFE8UIxEP3NxinnsYtpCEwo3P8cwpiJOM8Stu662Lkxtcmx9qOB8mug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479084; c=relaxed/simple;
	bh=cv/CdDHnF/j/JE9abIu74TZ7GStmXWG3MT8avEsGn/U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sr2u0tiMzfjTTQwkCTT+eqjHIWQ9vFDEiJB2g/hZal3trOUCP9zRjfSuaET1iLVHnEA8S2yRYlBySbZtLIOmaHno5XC7sHy6kbLPj3Q9AjJktAHuAbF9so2W5qraUu6fKecIKU7FMwZtxxfw1Z4i9AlhnDE0IVBr+cGC0dHLtkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RygBT2CG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RygBT2CG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDEC1F00A3D;
	Thu,  3 Sep 2026 23:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788479073;
	bh=8PIIsvCnkMVBHT5zMeUU8FMuF1Spow1Sm251S4fyx7A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RygBT2CGB7mpo5qA2uSGPv7wMELWhYdDZKWni5RDfaeHrWjnn0eDOVlOBNvPuruA+
	 vp8ADnOamu/gRkz49TroHbClAwgZAiqYg5lE4uThXlo6lIevRlpmY+JMtPEsiqxhX7
	 yw7ikS++c/E4DovEun2qOq62eWiGQKd67TAPB/e255blwhbEqA+sUAPaYXO8dr9hoE
	 Wbg/0EqOWhkhIIRBRwtv4j3+/EFez8RafHakTeAB8QUzh4wlp6OFV2/c9lV6FP0hh0
	 ztMZAVbTUuGrVsy05MJCWFnhnjtd7F5rlDfofxebjYyoHix8giB/Se2N1U9aXF8/WI
	 ZKj4/rcJ6ma7A==
Subject: Re: [PATCH v3 net-next 14/15] net: enetc: add PSI-to-VSI link status
 notification support for VF
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew@lunn.ch, olteanv@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 23:44:32 +0000
Message-ID: <178847907205.4131868.7015450810217454362@kernel.org>
In-Reply-To: <20260831025441.635045-15-wei.fang@oss.nxp.com>
References: <20260831025441.635045-15-wei.fang@oss.nxp.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 6 · Low: 1

- [Medium] The PSI-to-VSI link-status notification protocol has no
  coalescing, retry or re-query path, so the newest link state can be…
- [Medium] The VF treats a CMD_SUCCESS reply to
  ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER as a guarantee that the PF…
- [Medium] The PF-side link-status subscription (bit in
  pf->link_status_ms_mask) is acquired with no guaranteed release, and…
- [Medium] Teardown ordering bug: enetc_vf_remove()
  (drivers/net/ethernet/freescale/enetc/enetc_vf.c:773-774) calls…
- [Medium] Head-of-line blocking / lock inversion between rtnl_lock and
  the VSI-PSI mailbox.
- [Medium] enetc_vf_probe() enables the message-received interrupt and
  then calls netif_carrier_off(ndev) *after* register_netdev() with no…
- [Low] Claim: the commit message omits that
  enetc_vf_msg_handle_link_status() also reprograms hardware…

--

net: enetc: add PSI-to-VSI link status notification support for VF

This adds two enetc_si_ops hooks so that a phy-less ENETC v4 VF registers a
link status notifier with the PF over the VSI-to-PSI mailbox on open and
unregisters it on close. Incoming PSI-to-VSI notifications are taken by a
dedicated MSI-X vector and processed in a work item that updates the VF
carrier.

I had a few questions about the new paths below.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 803c5c541a5c..fb5df740650e 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -2935,11 +2935,31 @@ static void enetc_clear_interrupts(struct enetc_ndev_priv *priv)
>  static int enetc_phylink_connect(struct net_device *ndev)
>  {
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct enetc_si *si = priv->si;
>  	struct ethtool_keee edata;
>  	int err;
>  
>  	if (!priv->phylink) {
>  		/* phy-less mode */
> +		if (!si->ops->vf_reg_link_status_notifier)
> +			goto carrier_on;
> +
> +		/* For phy-less VFs on ENETC v4, attempt to register a link
> +		 * status notifier with the PF via the VSI-to-PSI messaging
> +		 * channel. If registration succeeds, the PF will immediately
> +		 * send the current link status and broadcast future link
> +		 * transitions; carrier state is then managed in
> +		 * enetc_vf_msg_handle_link_status(). If registration fails,
> +		 * fall back to the LS1028A behaviour and assert carrier
> +		 * unconditionally via netif_carrier_on().
> +		 */
> +		if (!si->ops->vf_reg_link_status_notifier(si))
> +			return 0;

[Severity: Medium]

Here a CMD_SUCCESS reply to ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER is
taken as a promise that the PF registered the VF and will push the current
link status, so this path returns without calling netif_carrier_on() and
without any timeout fallback.

Does the PF side keep that promise? enetc_msg_register_link_status_notifier()
writes the SUCCESS reply first and only then checks sriov_enabled:

	enetc_pf_reply_msg(&pf->si->hw, vf_id, pf_msg);

	/* SR-IOV is being disabled if pf->sriov_enabled is false, so no
	 * need to set link_status_ms_mask and notify the link status.
	 */
	if (!pf->sriov_enabled)
		goto msg_unlock;

so both pf->link_status_ms_mask |= PSIMSGSR_MS(vf_id) and the immediate
enetc_msg_notify_vf_link_status() are skipped after the VF has already been
told SUCCESS.

That window is entered by enetc_sriov_configure(pdev, 0) (echo 0 >
sriov_numvfs) and by the pci_enable_sriov() error path, both before the VFs
are torn down.

Even with sriov_enabled true, the immediate notification can fail inside
enetc_pf_send_msg() (-EIO when the VF MS bit is still set, or the 200 ms
timeout) and is only reported with dev_err_ratelimited("PF notifies link
status failed").

In these cases, is the VF left administratively up with carrier off, with no
traffic, until a manual down/up?

> +
> +		dev_warn(&ndev->dev,
> +			 "Link status notifier registration failed\n");
> +
> +carrier_on:
>  		netif_carrier_on(ndev);
>  		return 0;
>  	}

[ ... ]

> @@ -3051,8 +3072,15 @@ int enetc_open(struct net_device *ndev)
>  err_alloc_rx:
>  	enetc_free_tx_resources(tx_res, priv->num_tx_rings);
>  err_alloc_tx:
> -	if (priv->phylink)
> +	if (priv->phylink) {
>  		phylink_disconnect_phy(priv->phylink);
> +	} else if (si->ops->vf_unreg_link_status_notifier &&
> +		   test_bit(ENETC_LINK_STATUS_NOTIFIER_REGISTERED,
> +			    &priv->flags)) {
> +		if (si->ops->vf_unreg_link_status_notifier(si))
> +			dev_warn(&ndev->dev,
> +				 "Link status notifier unregistration failed\n");
> +	}
>  err_phy_connect:
>  	enetc_free_irqs(priv);
>  err_setup_irqs:

[ ... ]

> @@ -3100,6 +3129,17 @@ int enetc_close(struct net_device *ndev)
>  		phylink_stop(priv->phylink);
>  		phylink_disconnect_phy(priv->phylink);
>  	} else {
> +		if (!si->ops->vf_unreg_link_status_notifier ||
> +		    !test_bit(ENETC_LINK_STATUS_NOTIFIER_REGISTERED,
> +			      &priv->flags))
> +			goto carrier_off;
> +
> +		if (!si->ops->vf_unreg_link_status_notifier(si))
> +			goto carrier_off;
> +
> +		dev_warn(&ndev->dev,
> +			 "Link status notifier unregistration failed\n");
> +carrier_off:
>  		netif_carrier_off(ndev);
>  	}

[Severity: Medium]

Both new unregister call sites, here and in the enetc_open() unwind, are
gated on ENETC_LINK_STATUS_NOTIFIER_REGISTERED, but that flag is only set
when the whole mailbox round trip returned 0:

enetc_vf_reg_link_status_notifier()
	err = enetc_msg_link_status_notifier(si, true);
	if (!err)
		set_bit(ENETC_LINK_STATUS_NOTIFIER_REGISTERED, &priv->flags);

On the PF side, enetc_msg_register_link_status_notifier() replies first and
sets pf->link_status_ms_mask |= PSIMSGSR_MS(vf_id) afterwards.

So if enetc_msg_vsi_send() hits its 200 ms read_poll_timeout (-ETIME) or
-EIO, the PF is registered while the VF flag stays clear, and this code
takes the goto carrier_off path so UNREGISTER is never sent. Can the
PF-side subscription be leaked this way?

A failed unregister is likewise only warned about and leaves the flag set,
and enetc_vf_remove() relies solely on unregister_netdev() -> enetc_close(),
so after close or unbind the PF keeps notifying a VF that can no longer
acknowledge, paying the full 200 ms poll under pf->msg_lock which also
serialises mailbox service for the other VFs.

enetc4_pf_vf_flr_handler() restores promisc state but does not clear the
reset VF's bit in link_status_ms_mask either. Would a forced unregister in
enetc_vf_remove(), plus clearing link_status_ms_mask on FLR, be appropriate?

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> index 4e717afba7f7..a4d0089ef1a9 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c

[ ... ]

> @@ -435,6 +481,128 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  	enetc_load_primary_mac_addr(&si->hw, ndev);
>  }
>  
> +static void enetc_vf_enable_mr_int(struct enetc_si *si)
> +{
> +	if (is_enetc_rev1(si))
> +		return;
> +
> +	enetc_wr(&si->hw, ENETC_VSIIER, VSIIER_MRIE);
> +}
> +
> +static void enetc_vf_disable_mr_int(struct enetc_si *si)
> +{
> +	if (is_enetc_rev1(si))
> +		return;
> +
> +	enetc_wr(&si->hw, ENETC_VSIIER, 0);
> +}
> +
> +static void enetc_vf_msg_handle_link_status(struct enetc_si *si, u8 status)
> +{
> +	bool tx_pause = !!(status & ENETC_CLASS_CODE_TX_PAUSE_EN);
> +	bool link_down = !!(status & ENETC_CLASS_CODE_LINK_DOWN);
> +	struct enetc_ndev_priv *priv = netdev_priv(si->ndev);
> +	struct net_device *ndev = si->ndev;
> +
> +	rtnl_lock();

[Severity: Medium]

Is rtnl_lock() needed here? netif_carrier_on()/netif_carrier_off() do not
require it, and enetc_set_congestion_mode() already serialises on
si->gen_lock.

Taking rtnl in this work item ties PF message acknowledgement to rtnl
availability. Every VSI-to-PSI sender runs with rtnl held and busy-polls the
PF for up to 200 ms inside enetc_msg_vsi_send(): the two new notifier ops
called from enetc_phylink_connect() and enetc_close(), plus
enetc_vf_set_mac_addr() and the rx-mode async worker.

There is a single si->msg_task on an ordered workqueue and MRIE stays masked
from enetc_vf_msg_msix_handler() until it completes, so while one invocation
is parked on rtnl_lock() no further PF message can be acked:

VF work item                        VF rtnl holder (ip link set <vf> down)
enetc_vf_msg_task()
  enetc_vf_msg_handle_link_status()
    rtnl_lock()  <- blocks          enetc_close()
                                      vf_unreg_link_status_notifier()
                                        enetc_msg_vsi_send() 200 ms poll

The PF in turn holds pf->msg_lock while polling for that same VF's ack.

Does this resolve only when the 200 ms timeouts fire, leaving "VSI mailbox
timeout" and "Link status notifier unregistration failed", a leaked PF
registration and a lost link transition?

> +	if (!netif_running(ndev))
> +		goto unlock_rtnl;
> +
> +	if (link_down) {
> +		if (netif_carrier_ok(ndev)) {
> +			netif_carrier_off(ndev);
> +			netdev_info(ndev, "Link is Down\n");
> +		}
> +
> +		goto unlock_rtnl;
> +	}
> +
> +	/* Link is up */
> +	enetc_set_congestion_mode(priv, tx_pause);

[Severity: Low]

This isn't a bug, but the commit message says only that the work item
"parses the notification and updates the carrier state via
netif_carrier_on() or netif_carrier_off() accordingly". It does not mention
that the same notification reprograms hardware, updating the congestion
mode bit in ENETC_RBMR for every VF Rx BD ring from the PF TX pause bit.
Could that be spelled out in the changelog?

> +
> +	if (!netif_carrier_ok(ndev)) {
> +		netif_carrier_on(ndev);
> +		netdev_info(ndev, "Link is Up, tx pause %s\n",
> +			    tx_pause ? "on" : "off");
> +	}
> +
> +unlock_rtnl:
> +	rtnl_unlock();
> +}
> +
> +static void enetc_vf_msg_task(struct work_struct *work)
> +{
> +	struct enetc_si *si = container_of(work, struct enetc_si, msg_task);
> +	struct enetc_hw *hw = &si->hw;
> +	u8 class_id, class_code;
> +	u16 pf_msg;
> +
> +	/* W1C to clear the message received interrupt event */
> +	enetc_wr(hw, ENETC_VSIIDR, VSIIDR_MR);
> +
> +	/* Reading VSIMSGRR retrieves the message data and acknowledges to
> +	 * the PF that the message was received and another message can be
> +	 * sent.
> +	 */
> +	pf_msg = FIELD_GET(VSIMSGRR_MC, enetc_rd(hw, ENETC_VSIMSGRR));

[Severity: Medium]

Only the single 16-bit value VSIMSGRR currently holds is ever consumed, and
the VF never sends ENETC_MSG_GET_CURRENT_LINK_STATUS even though the
protocol defines it and the PF already handles it.

On the PF side, enetc_pf_send_msg() drops every VF whose MS bit is still
set:

	ms_status = enetc_rd(hw, ENETC_PSIMSGSR) & 0xffff;
	ms_mask &= ~ms_status;
	if (!ms_mask)
		return -EIO;

and enetc_msg_notify_vf_link_status() only logs "PF notifies link status
failed" without storing the pending state or retrying once the MS bit
clears.

If the VF has not read VSIMSGRR within the PF's 200 ms poll, the ack being
deferred to this work item with MRIE masked meanwhile, and the link then
changes again, the second transition is skipped for that VF and never
resent.

Does the VF carrier then stay at the older state, including carrier off
which blocks all VF transmit, until some later PF transition happens to
succeed?

> +	class_id = FIELD_GET(ENETC_PF_MSG_CLASS_ID, pf_msg);
> +
> +	switch (class_id) {
> +	case ENETC_MSG_CLASS_ID_LINK_STATUS:
> +		class_code = FIELD_GET(ENETC_PF_MSG_CLASS_CODE_U8, pf_msg);
> +		enetc_vf_msg_handle_link_status(si, class_code);
> +		break;
> +	default:
> +		dev_err(&si->pdev->dev,
> +			"Unsupported Message Class ID (0x%02x) from PF\n",
> +			class_id);
> +	}
> +
> +	enetc_vf_enable_mr_int(si);
> +}
> +
> +static irqreturn_t enetc_vf_msg_msix_handler(int irq, void *data)
> +{
> +	struct enetc_si *si = (struct enetc_si *)data;
> +
> +	enetc_vf_disable_mr_int(si);
> +	queue_work(si->workqueue, &si->msg_task);
> +
> +	return IRQ_HANDLED;
> +}
> +

[ ... ]

> @@ -447,8 +615,38 @@ static const struct enetc_si_ops enetc4_vsi_ops = {

[ ... ]

> +static void enetc_vf_wq_task_destroy(struct enetc_si *si)
> +{
> +	if (!si->workqueue)
> +		return;
> +
> +	disable_work_sync(&si->msg_task);
> +
> +	/* The MR interrupt may be re-enabled by si->msg_task */
> +	enetc_vf_disable_mr_int(si);
> +
> +	destroy_workqueue(si->workqueue);
> +}
> +
>  static int enetc_vf_probe(struct pci_dev *pdev,
>  			  const struct pci_device_id *ent)
>  {
> @@ -520,15 +718,33 @@ static int enetc_vf_probe(struct pci_dev *pdev,
>  		goto err_alloc_msix;
>  	}
>  
> +	err = enetc_vf_wq_task_init(si);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to init workqueue\n");
> +		goto err_wq_init;
> +	}
> +
> +	err = enetc_vf_register_msg_msix(si);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to register msg irq\n");
> +		goto err_register_msg_msix;
> +	}
> +
>  	err = register_netdev(ndev);
>  	if (err)
>  		goto err_reg_netdev;
>  
> +	/* Enable message received interrupt */
> +	enetc_vf_enable_mr_int(si);
>  	netif_carrier_off(ndev);

[Severity: Medium]

This netif_carrier_off() runs after register_netdev() has published the
interface and dropped rtnl, with no lock held, while the new work item
writes the same carrier bit under rtnl. If the probe thread is preempted
after register_netdev(), can this happen?

  probe                            udev / ifup
  register_netdev()
                                   enetc_open()
                                     enetc_phylink_connect()
                                       vf_reg_link_status_notifier()
                                   PF sends current link status
                                   enetc_vf_msg_task()
                                     netif_carrier_on()  (rtnl held)
  netif_carrier_off()   <- reverts it

Since the carrier is now driven only by PF transition notifications, with no
periodic refresh and no VF-side status query, the interface would stay up
with carrier off until the next physical PF link change.

Would moving netif_carrier_off() and enetc_vf_enable_mr_int() before
register_netdev() avoid this? The netif_running() check in
enetc_vf_msg_handle_link_status() should make the earlier interrupt enable
harmless.

>  
>  	return 0;
>  
>  err_reg_netdev:
> +	enetc_vf_free_msg_msix(si);
> +err_register_msg_msix:
> +	enetc_vf_wq_task_destroy(si);
> +err_wq_init:
>  	enetc_free_msix(priv);
>  err_config_si:
>  err_alloc_msix:
> @@ -554,8 +770,11 @@ static void enetc_vf_remove(struct pci_dev *pdev)
>  	struct enetc_msg_swbd msg;
>  
>  	priv = netdev_priv(si->ndev);
> +	enetc_vf_disable_mr_int(si);
>  	unregister_netdev(si->ndev);

[Severity: Medium]

Is this ordering intentional? enetc_vf_disable_mr_int() masks VSIIER while
the VF is still present in pf->link_status_ms_mask, because the
UNREGISTER_LINK_CHANGE_NOTIFIER message is only sent later from
enetc_close(), reached via unregister_netdev() -> dev_close().

A PF link transition landing in that window writes PSIMSGSR and polls up to
200 ms under pf->msg_lock, but nothing can read ENETC_VSIMSGRR any more:
the MR interrupt is masked, and enetc_vf_wq_task_destroy() then calls
disable_work_sync() and masks MRIE again, so enetc_vf_msg_task() never runs.
Per enetc_pf_send_msg()'s own comment, reading VSIMSGRR is the only way to
clear the MS bit, "the MS bit can only be written as 1, writing a 0 has no
effect".

Does the MS bit then stay asserted across an unbind, so that on the next
probe and open enetc_pf_send_msg()

	ms_mask &= ~ms_status;
	if (!ms_mask)
		return -EIO;

drops the initial link status notification for the freshly registered VF,
whose carrier stays off because enetc_phylink_connect() skips
netif_carrier_on() on registration success?

The early disable also looks redundant, since enetc_vf_wq_task_destroy()
already performs the final MRIE disable after disable_work_sync().

>  
> +	enetc_vf_free_msg_msix(si);
> +	enetc_vf_wq_task_destroy(si);
>  	enetc_free_msix(priv);
>  
>  	enetc_free_si_resources(priv);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831025441.635045-1-wei.fang%40oss.nxp.com
