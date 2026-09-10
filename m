Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FEB471424;
	Thu, 10 Sep 2026 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039260; cv=none; b=rLB9SYxHbOGO7Z0nDkmtVmOWVK1wWoig+JlzmOWs6ClN9Scakej3CegoyzvBLfZr0BdLzKcr3OV7+c3yb9narPMiEk4O1VMgebe2U1mrp/r6tvxHkg95s+mWS0f9lKSvc/eVeSJnrTiQG+qpIe/tYVtJ0xwnYdRH5Mz84ZXOnT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039260; c=relaxed/simple;
	bh=ABwaCA/DaQs1tHTx+hqkB1iW5f7WToXYdfrXkAiTONk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qqXBAf1I8Y2waoThF45kFwxtKGktwDXnnHv1fU2lrhIrW7YswwAKQ5YmFFY/zbYOGFMEU6Kj/SFbtia+gBPmy8iTa07QSfPXAU+U0DHZdJsX8EKxnKUsqgqV20wqg7mF0nw6aYHoxh1GR/y5GSoEyFMt591GsBcLO/ey/c1YLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsOmBXfD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsOmBXfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13AA1F000FF;
	Thu, 10 Sep 2026 11:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039258;
	bh=ExrmhQpu6tbyfp5OYdFhah4P4liN7EhbNO5uO2u6/1c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IsOmBXfDGsN5DXWzSyTK81bWzn5ixSgP7vyGlm5xWmEhBBr1QDQ4Yryb4hhMhrsUL
	 kKOLd/UzCIxwH5u/MKGnt7HkZ/59C4uusOpIBocF+EVbXNIz5FWF/v4UelCm6Qn7BF
	 3yIa9ztLXV1aPdDKCiOsk1DqCEP/9MZZ548oFZWdHSUzJ0neSdrhF9WdvIdgRDpoi6
	 Z3Qo+Onnm2mjeLhPJ1i6cAipTP0YIwVXIOd9jBGZZ3kYu4rsS7pVG/9eaRPmfwgZBn
	 fbd+4G68kX781r5Ptlx0rA+CEQtcunNc1aTaS3WEhH+SpYb42Wd1jsCyNInWcaCqYl
	 O5faVrgZoWfpA==
Subject: Re: [PATCH v4 net-next 03/15] net: enetc: add link status message
 support to PF driver
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew@lunn.ch, olteanv@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 11:20:57 +0000
Message-ID: <178903925739.219967.16127084543279135513@kernel.org>
In-Reply-To: <20260909100733.1139689-4-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-4-wei.fang@oss.nxp.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 4 · Low: 2

- [Medium] A VF's hardware PSIMSGSR[MS(n)] doorbell can only be cleared
  by the VSI (by reading VSIMSGRR); the PF cannot clear it (the code's…
- [Medium] enetc_pf_send_link_status_msg() treats the registered-VF set
  as one atomic broadcast group even though it is also used to deliver a…
- [Medium] Link-status delivery is one-shot and based on a racy snapshot
  of ENETC_PSIMSGSR.
- [Medium] Any VF, including an untrusted one assigned to a hostile
  VM/container via VFIO, can register for link-status notification with…
- [Low] The comment in enetc_pf_send_link_status_msg() states that a VF
  is removed from link_status_ms_mask "[i]f the PF fails to send…
- [Low] vf_state->msg_fail_cnt is not reset across an explicit
  unregister/re-register cycle:…

--

net: enetc: add link status message support to PF driver

This adds message class 0x80 so a VF can query the PF link state or
register for link change notification. Notifications are written to
ENETC_PSIMSGSR from an ordered workqueue, and link_status_ms_mask tracks
which VFs are registered.

A few questions about the notification bookkeeping below.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> index a89a5a418a23..79dbaf72fcff 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> @@ -136,6 +136,104 @@ static u16 enetc_msg_handle_ip_revision(struct enetc_pf *pf, void *vf_msg)
>  	}
>  }
>  
> +static void enetc_pf_reply_msg(struct enetc_hw *hw, int vf_id, u16 pf_msg)
> +{
> +	/* w1c to clear the corresponding VF MR bit */
> +	enetc_wr(hw, ENETC_PSIIDR, ENETC_PSIMR_BIT(vf_id));
> +	enetc_wr(hw, ENETC_PSIMSGRR, ENETC_SIMSGSR_SET_MC(pf_msg) |
> +		 ENETC_PSIMR_BIT(vf_id));
> +}
> +

[ ... ]

> +static void enetc_msg_register_link_status_notifier(struct enetc_pf *pf,
> +						    int vf_id)
> +{
> +	struct enetc_si *si = pf->si;
> +
> +	spin_lock(&si->gen_lock);
> +	enetc_pf_reply_msg(&si->hw, vf_id, ENETC_PF_MSG_SUCCESS);
> +
> +	/* SR-IOV is being disabled if pf->sriov_enabled is false, so no
> +	 * need to set link_status_ms_mask and notify the link status.
> +	 */
> +	if (!pf->sriov_enabled) {
> +		spin_unlock(&si->gen_lock);
> +		return;
> +	}
> +
> +	pf->link_status_ms_mask |= PSIMSGSR_MS(vf_id);
> +	spin_unlock(&si->gen_lock);
> +
> +	/* Notify VF the current link status */
> +	queue_work(si->workqueue, &pf->link_status_task);
> +}

[Severity: Medium]
This queues the shared, VF-agnostic link_status_task in order to deliver one
VF's initial status. Does that mean a single VF registering re-sends the
notification to every VF currently set in link_status_ms_mask?

The retry decision in enetc_pf_send_link_status_msg() is made on the
aggregate mask rather than per VF:

	ms_status = enetc_rd(&si->hw, ENETC_PSIMSGSR) & 0xfffe;
	if ((ms_mask & ms_status) && retry_num++ < 200) {
		spin_unlock(&si->gen_lock);
		usleep_range(1000, 1020);
		goto retry;
	}

Can one VF that never reads its mailbox therefore add up to roughly 200 ms
of sleeping to every registration and every link transition seen by all the
other registered VFs?

The ms_status_check loop also advances vf_state->msg_fail_cnt for every VF
in ms_mask. Can a VF that happened to be busy during a notification
triggered by some other VF's registration accumulate failures it did not
cause, and eventually be evicted from link_status_ms_mask?

> +
> +static void enetc_msg_unregister_link_status_notifier(struct enetc_pf *pf,
> +						      int vf_id)
> +{
> +	spin_lock(&pf->si->gen_lock);
> +	pf->link_status_ms_mask &= ~PSIMSGSR_MS(vf_id);
> +	enetc_pf_reply_msg(&pf->si->hw, vf_id, ENETC_PF_MSG_SUCCESS);
> +	spin_unlock(&pf->si->gen_lock);
> +}

[Severity: Low]
Neither this function nor enetc_msg_register_link_status_notifier() resets
vf_state->msg_fail_cnt.

If a VF accumulated up to 10 consecutive delivery failures under a previous
registration, does the first busy notification after it re-registers
immediately clear its bit from link_status_ms_mask?

Later in the series the Linux VF driver unregisters on ndo_close and
registers again on ndo_open, so the counter survives an ifdown/ifup cycle.
Would clearing vf_state->msg_fail_cnt in the register path be preferable?

> +
> +static u16 enetc_msg_handle_link_status(struct enetc_pf *pf, int vf_id,
> +					void *vf_msg)
> +{
> +	struct enetc_msg_header *msg_hdr = vf_msg;
> +
> +	switch (msg_hdr->cmd_id) {
> +	case ENETC_MSG_GET_CURRENT_LINK_STATUS:
> +		/* Currently, this message is intended only for
> +		 * DPDK-owned VFs.
> +		 */
> +		enetc_msg_get_link_status(pf, vf_id);
> +		break;
> +	case ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER:
> +		enetc_msg_register_link_status_notifier(pf, vf_id);
> +		break;

[Severity: Medium]
This dispatch has no ENETC_VF_FLAG_TRUSTED check and no rate limiting,
unlike enetc_msg_set_vf_primary_mac_addr() and the other MAC filter
handlers in this file. The link speed handler added later in the series
documents exactly this abuse class in its own comment ("A malicious or
malfunctioning VM could potentially spam these messages in a tight
loop...").

The registration handler replies ENETC_PF_MSG_SUCCESS first, which clears
the VF's MR bit and lets the VF post the next message right away, then
calls queue_work() unconditionally.

Can a VF assigned to an untrusted guest register, never consume its
mailbox, and keep re-sending ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER so
that the PF's single ordered workqueue spends 200 x ~1 ms sleeping on each
invocation, delaying carrier notifications for the co-tenant VFs?

The 10-failure eviction does not appear to bound this, since the VF can
simply register again and restore its bit in link_status_ms_mask.

> +	case ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER:
> +		enetc_msg_unregister_link_status_notifier(pf, vf_id);
> +		break;
> +	default:
> +		return ENETC_PF_MSG_NOTSUPP;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> @@ -340,6 +442,22 @@ static int enetc_msg_psi_init(struct enetc_pf *pf)
>  	return err;
>  }
>  
> +static void enetc_msg_clear_vf_config(struct enetc_pf *pf, int vf_id)
> +{
> +	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
> +	struct enetc_si *si = pf->si;
> +
> +	/* For ENETC v1, we only support setting the VF's MAC address via
> +	 * VSI-to-PSI messages, so there is no configuration to clear.
> +	 */
> +	if (is_enetc_rev1(si))
> +		return;
> +
> +	spin_lock(&si->gen_lock);
> +	vf_state->msg_fail_cnt = 0;
> +	spin_unlock(&si->gen_lock);
> +}

[Severity: Medium]
This resets software state only; the hardware PSIMSGSR[MS] bit for that VSI
is left set. The comment in enetc_pf_send_link_status_msg() states that the
PF cannot write the MS bit as 0, so only the VSI can clear it by reading
VSIMSGRR.

Is there any path that disarms an MS bit left set by a VF that stopped
consuming messages, for example a crashed or paused guest, a VF FLR, a VFIO
release, or a killed DPDK application?

The commit message says:

  "The link_status_ms_mask tracks the VFs registered for notification and
   is cleared when SR-IOV is disabled."

but a VF FLR clears neither link_status_ms_mask nor msg_fail_cnt: the
enetc4_pf_vf_flr_handler() added later in the series restores only the
promiscuous state. Does a re-created VF at the same index then look
registered to the PF while the notification channel to it is blocked?

Two follow-on effects in enetc_pf_send_link_status_msg(): every later PF
link transition burns up to 200 x ~1 ms of polling because the retry gate
is keyed on the aggregate mask, and after 11 such events the VF's bit is
dropped from link_status_ms_mask with only a dev_warn_ratelimited(), while
the VF still considers itself registered because it was acked with
ENETC_PF_MSG_SUCCESS. Should there be an error reply, a re-arm, or a
periodic retry so the VF's carrier state and its RX BD congestion mode
decision (driven by the TX PAUSE bit) do not stay stale until an
administrative ifdown/ifup?

The later VF patch does drain VSIMSGRR in enetc_vf_wq_task_destroy(), but
that covers only the clean Linux VF unbind case, not FLR or guest death.

>  static void enetc_msg_psi_free(struct enetc_pf *pf)
>  {
>  	struct enetc_si *si = pf->si;

[ ... ]

> @@ -367,6 +487,11 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
>  	int err;
>  
>  	if (!num_vfs) {
> +		spin_lock(&si->gen_lock);
> +		pf->sriov_enabled = false;
> +		pf->link_status_ms_mask = 0;
> +		spin_unlock(&si->gen_lock);
> +
>  		pci_disable_sriov(pdev);
>  		enetc_msg_psi_free(pf);
>  		pf->num_vfs = 0;

[ ... ]

> @@ -396,3 +535,114 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(enetc_sriov_configure);
> +
> +void enetc_pf_send_link_status_msg(struct enetc_pf *pf)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(pf->si->ndev);
> +	u16 pf_msg, ms_mask, new_ms_msk, ms_status;
> +	struct enetc_si *si = pf->si;
> +	int retry_num = 0;
> +
> +retry:
> +	spin_lock(&si->gen_lock);
> +	ms_mask = pf->link_status_ms_mask;
> +	/* VFs have unregistered link status notification, return directly  */
> +	if (!ms_mask)
> +		goto unlock;
> +
> +	/* The MS bit is set, indicating that the corresponding VF has not
> +	 * read the last message, PF cannot send new message to the VF. To
> +	 * avoid sending messages to such a VF, the bit corresponding to VF
> +	 * is cleared from ms_mask. Because the MS bit can only be written
> +	 * as 1, writing a 0 has no effect. Writing a 1 when the bit is
> +	 * already set is undefined.
> +	 */
> +	ms_status = enetc_rd(&si->hw, ENETC_PSIMSGSR) & 0xfffe;
> +	if ((ms_mask & ms_status) && retry_num++ < 200) {
> +		spin_unlock(&si->gen_lock);
> +		/* Wait VFs to handle the last message */
> +		usleep_range(1000, 1020);
> +		goto retry;
> +	}
> +
> +	/* None of the relevant VFs have processed the previous message, and
> +	 * the PF has tried 200 times. This situation indicates that VF has
> +	 * malfunctioned.
> +	 */
> +	new_ms_msk = ms_mask & (~ms_status);
> +	if (!new_ms_msk) {
> +		dev_err_ratelimited(&si->pdev->dev,
> +				    "All registered VFs (MS: 0x%x) are busy\n",
> +				    ms_mask);
> +		goto ms_status_check;
> +	}
> +
> +	if (new_ms_msk != ms_mask)
> +		dev_warn_ratelimited(&si->pdev->dev,
> +				     "Failed to notify link status to VFs (MS: 0x%x)\n",
> +				     ms_mask ^ new_ms_msk);
> +
> +	pf_msg = enetc_build_link_status_msg(priv, pf->link_up);
> +	enetc_wr(&si->hw, ENETC_PSIMSGSR,
> +		 FIELD_PREP(PSIMSGSR_MC, pf_msg) | new_ms_msk);

[Severity: Medium]
Delivery here looks one-shot. Both the "All registered VFs ... are busy"
path and the new_ms_msk != ms_mask path abandon the pending notification:
link_status_task is not re-queued and nothing records that the excluded VFs
still owe a message, only a rate-limited log line is emitted.

Is the ms_status snapshot also racy? A VSI clears its own MS bit
asynchronously and outside si->gen_lock, so if a VF clears its bit between:

	ms_status = enetc_rd(&si->hw, ENETC_PSIMSGSR) & 0xfffe;

and:

	enetc_wr(&si->hw, ENETC_PSIMSGSR,
		 FIELD_PREP(PSIMSGSR_MC, pf_msg) | new_ms_msk);

does that VF consume the previous message content and never receive the
current link state? gen_lock cannot close this window because the MS bit is
mutated by a peer PCI function.

With the VF side added later in the series, a phy-less v4 VF relies
entirely on this notification for its carrier: enetc_phylink_connect()
returns without calling netif_carrier_on() when
vf_reg_link_status_notifier() succeeds. Does a dropped initial notification
then leave the VF netdev with no carrier until some later PF link change or
an administrative ifdown/ifup?

> +
> +ms_status_check:
> +	/* If the PF fails to send messages to the corresponding VF for 10
> +	 * consecutive times, clear that VF's bit in link_status_ms_mask.
> +	 */
> +	for (int i = 0; i < pf->num_vfs; i++) {
> +		struct enetc_vf_state *vf_state = &pf->vf_state[i];
> +
> +		if (!(PSIMSGSR_MS(i) & ms_mask))
> +			continue;
> +
> +		if (!(PSIMSGSR_MS(i) & ms_status)) {
> +			vf_state->msg_fail_cnt = 0;
> +			continue;
> +		}
> +
> +		if (vf_state->msg_fail_cnt++ < 10)
> +			continue;

[Severity: Low]
The comment above says the bit is cleared after 10 consecutive failures,
but the post-increment test lets failures with observed values 0..9
continue, so the bit is only cleared on the 11th consecutive failure. Is
the comment or the comparison off by one?

> +
> +		vf_state->msg_fail_cnt = 0;
> +		pf->link_status_ms_mask &= ~PSIMSGSR_MS(i);
> +		dev_warn_ratelimited(&si->pdev->dev,
> +				     "Clear VF%d's link status MS bit\n", i);
> +	}
> +
> +unlock:
> +	spin_unlock(&si->gen_lock);
> +}
> +EXPORT_SYMBOL_GPL(enetc_pf_send_link_status_msg);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909100733.1139689-1-wei.fang%40oss.nxp.com
