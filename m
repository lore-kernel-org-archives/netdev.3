Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37D22D3727;
	Thu,  3 Sep 2026 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479066; cv=none; b=Zy/lW1HFJvEamPqVSM8GFfKvmFTk/lZbS14zKsYe1bLNml/1DIO3141mngBTPYDsOb4hb6xZh+kG4O4Z7Gwlq1LBc4bZkWXSMHlOk3PaCoESghqSgl73wU3C/dGZaro5cHkQNhRz/p6FgrbP43uYpOjihZ1FlVSx/CZW8vo9IUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479066; c=relaxed/simple;
	bh=79G1VtWBYNI1Yb+rLByMLWc2N2fFYPLyZ/cay8aWq04=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ce+7Na+hLy7ONgpPXrdGgwVdG+8pKQxg1r1mfAdTlnLZwsNu2HRaIx0xsJlfOqITo/ziW95QZD6OXNu73h9ymI2Tp8DX9Emkawxrq8r+TphKfsI+u0mASO2dYw8uv4vTxYDUAFDdet8j602jYuxHTPRO12dt1XEzF0Z035loMmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQhOZBd1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQhOZBd1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC871F00A3D;
	Thu,  3 Sep 2026 23:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788479064;
	bh=6IGMoVFngXiVh617le38pjAhDRRqj0oJruoTGMTXJ8g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mQhOZBd1VxdqSbbP++kWCoOUykJwtd+GRAn4gKWLk5cDbXd2VrG8ZHbwiClZPh2gB
	 ZyMHM01uuYOFgtMyG4gUA7VIyVtmJ4ovVpxZfQVLcdMccAc7zj+X8NwReUc/Et2JUq
	 cf6oq1JeNpqegLbxi0Y4/CibONGPqeX0o1r3Nmufz6iCDBNK+bOFjddTWLCRgATRqW
	 Ct55N56gfC8K895HBDM3vqqqHkY3lIVuPd8HuA0WESiIuwp6lLQg0fSbBL1Fk98uHq
	 4vD8GmBsCUVA4qBP0czaUORPk4BSCR/OPI26EF2kJ4lK5GDglmnY87JPGTAOETu45K
	 ScmRi1F63WHmA==
Subject: Re: [PATCH v3 net-next 03/15] net: enetc: add link status message
 support to PF driver
From: netdev-bot+sashiko@kernel.org
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew@lunn.ch, olteanv@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 23:44:23 +0000
Message-ID: <178847906345.4131868.5011473704889309213@kernel.org>
In-Reply-To: <20260831025441.635045-4-wei.fang@oss.nxp.com>
References: <20260831025441.635045-4-wei.fang@oss.nxp.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 1 · Low: 1

- [High] A link-state notification that cannot be delivered is silently
  discarded, leaving the VF with a permanently stale link/TX-PAUSE view.
- [High] enetc_pf_send_msg() performs a sleeping 200 ms poll
  (read_poll_timeout(..., 1000, 200000, ...), enetc_msg.c:204) whose…
- [Medium] Per-VF link-change notifier registration (bit in
  pf->link_status_ms_mask) has no teardown path tied to VF lifetime.
- [Low] enetc_pf_send_msg() logs "PF cannot send message to VF(s) 0x%x"
  (enetc_msg.c:197-199) with the value `ms_mask ^ old_ms_mask`, which is…

--

net: enetc: add link status message support to PF driver

This adds a link status message class (0x80) to the ENETC PF mailbox so a
VF can query the current PF link state, register for link change
notifications, or unregister from them. Registered VFs are notified from
the PF phylink callbacks via the ENETC_PSIMSGSR register, with a new
pf->msg_lock mutex and a pf->link_status_ms_mask bitmask tracking which VFs
want notifications.

A few questions below about the notification delivery path.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index 935a6a03b14f..17fd9ee27942 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -899,6 +899,7 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
>  	enetc4_set_rx_pause(pf, rx_pause);
>  	enetc4_mac_tx_enable(pf);
>  	enetc4_mac_rx_enable(pf);
> +	enetc_pf_notify_vf_link_up(pf);
>  }
>  
>  static void enetc4_pl_mac_link_down(struct phylink_config *config,
> @@ -907,6 +908,7 @@ static void enetc4_pl_mac_link_down(struct phylink_config *config,
>  {
>  	struct enetc_pf *pf = phylink_to_enetc_pf(config);
>  
> +	enetc_pf_notify_vf_link_down(pf);
>  	enetc4_mac_rx_graceful_stop(pf);
>  	enetc4_mac_tx_graceful_stop(pf);
>  }

[ ... ]

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 16da732dc5de..f97602714118 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -80,6 +80,11 @@ static inline u32 enetc_vsi_set_msize(u32 size)
>  #define ENETC_SIMSGSR_SET_MC(val) ((val) << 16)
>  #define ENETC_SIMSGSR_GET_MC(val) ((val) >> 16)
>  
> +#define ENETC_PSIMSGSR		0x208
> +/* n is VF index, which is less than 15 */
> +#define  PSIMSGSR_MS(n)		BIT((n) + 1)
> +#define  PSIMSGSR_MC		GENMASK(31, 16)
> +

[ ... ]

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> index a89a5a418a23..e21414acdc0d 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> @@ -136,6 +136,154 @@ static u16 enetc_msg_handle_ip_revision(struct enetc_pf *pf, void *vf_msg)
>  	}
>  }
>  

[ ... ]

> +static int enetc_pf_send_msg(struct enetc_pf *pf, u32 msg_code, u16 ms_mask)
> +{
> +	struct enetc_hw *hw = &pf->si->hw;
> +	u16 old_ms_mask = ms_mask;
> +	u16 ms_status;
> +	u32 val;
> +
> +	/* The MS bit is set, indicating that the corresponding VF has not
> +	 * read the last message, PF cannot send new message to the VF. To
> +	 * avoid sending messages to such a VF, the bit corresponding to VF
> +	 * is cleared from ms_mask. Because the MS bit can only be written
> +	 * as 1, writing a 0 has no effect. Writing a 1 when the bit is
> +	 * already set is undefined.
> +	 */
> +	ms_status = enetc_rd(hw, ENETC_PSIMSGSR) & 0xffff;
> +	ms_mask &= ~ms_status;
> +	if (!ms_mask)
> +		return -EIO;

[Severity: High]
Can a link state change be lost permanently here?

The return happens before the enetc_wr(hw, ENETC_PSIMSGSR, ...) below, so
when the target VF still has an unread message the new link state is never
published, and enetc_msg_notify_vf_link_status() only prints
"PF notifies link status failed". Nothing records that the VF is out of
date, and notifications are generated only on the phylink transitions in
enetc4_pl_mac_link_up()/enetc4_pl_mac_link_down().

Single-VF sequence:

  link up   -> PSIMSGSR written with "link up", the poll below times out
               after 200 ms because the VF has not read VSIMSGRR yet
  link down -> ms_status still has MS(0) set, ms_mask becomes 0,
               -EIO is returned and "link down" is never written

The VF then consumes the stale "link up" message and keeps carrier on plus
a stale TX PAUSE derived congestion-mode setting until the next PF link
transition. The same drop can hit the initial notification issued from
enetc_msg_register_link_status_notifier(), which has already replied
ENETC_MSG_CLASS_ID_CMD_SUCCESS to the VF.

Would it make sense to record a pending state and re-send it once the MS
bit is observed clear, rather than dropping the transition?

> +
> +	if (ms_mask != old_ms_mask)
> +		dev_warn_ratelimited(&pf->si->pdev->dev,
> +				     "PF cannot send message to VF(s) 0x%x\n",
> +				     ms_mask ^ old_ms_mask);

[Severity: Low]
The printed value is a PSIMSGSR MS-bit mask, not a VF index mask, since

  #define  PSIMSGSR_MS(n)		BIT((n) + 1)

so a stuck VF0 is reported as 0x2 and VF1 as 0x4. Should the value be
shifted back to VF numbering before printing, or should the message say
that it is an MS mask?

> +
> +	enetc_wr(hw, ENETC_PSIMSGSR,
> +		 FIELD_PREP(PSIMSGSR_MC, msg_code) | ms_mask);
> +
> +	return read_poll_timeout(enetc_rd, val, !(val & ms_mask), 1000,
> +				 200000, false, hw, ENETC_PSIMSGSR);
> +}

[Severity: High]
This waits up to 200 ms for a bit that only the VF can clear, and every
caller holds pf->msg_lock across it. Can an untrusted guest use that to
stall the host?

The VF-initiated path has no ENETC_VF_FLAG_TRUSTED check (unlike the MAC
filter handlers) and no rate limiting:

  enetc_msg_task()
    enetc_msg_handle_rxmsg()
      enetc_msg_handle_link_status()   /* cmd_id from the VF */
        enetc_msg_register_link_status_notifier()
          mutex_lock(&pf->msg_lock);
          enetc_msg_notify_vf_link_status()
            enetc_pf_send_msg()        /* sleeps up to 200 ms */

enetc_msg_task() handles all VFs sequentially in one work item with the MR
interrupts disabled, so a VF that registers, drains its mailbox and
re-registers in a loop keeps pf->msg_lock and the mailbox work item busy
and denies mailbox service to the sibling VFs.

The same pf->msg_lock is taken by enetc_pf_notify_vf_link_status() from
enetc4_pl_mac_link_up()/enetc4_pl_mac_link_down(), and phylink runs those
from its resolve work, which is flushed synchronously from ndo_open/
ndo_stop with rtnl_lock held:

drivers/net/phy/phylink.c:phylink_run_resolve_and_disable() {
	...
	flush_work(&pl->resolve);
	...
}

so the guest-induced stall propagates into the host PF link handling and
rtnl-held paths. In the other direction, one unresponsive registered VF
adds up to 200 ms to every PF link transition, because the poll condition
!(val & ms_mask) waits for all bits of the aggregate mask.

Is the synchronous acknowledgement wait needed at all here? Link state is
idempotent, so a fire-and-forget write with a deferred retry, or at least
dropping pf->msg_lock before waiting, would keep the PF link state machine
independent of VF behaviour. The commit message does not mention that a PF
link transition can now block on VF acknowledgement.

> +
> +static void enetc_msg_notify_vf_link_status(struct enetc_pf *pf, u16 ms_mask)
> +{
> +	struct enetc_ndev_priv *priv = netdev_priv(pf->si->ndev);
> +	u16 pf_msg;
> +
> +	pf_msg = enetc_build_link_status_msg(priv, pf->link_up);
> +	if (enetc_pf_send_msg(pf, pf_msg, ms_mask))
> +		dev_err_ratelimited(&pf->si->pdev->dev,
> +				    "PF notifies link status failed\n");
> +}
> +
> +static void enetc_msg_register_link_status_notifier(struct enetc_pf *pf,
> +						    int vf_id)
> +{
> +	u16 pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
> +				ENETC_MSG_CLASS_ID_CMD_SUCCESS);
> +
> +	mutex_lock(&pf->msg_lock);
> +
> +	enetc_pf_reply_msg(&pf->si->hw, vf_id, pf_msg);
> +
> +	/* SR-IOV is being disabled if pf->sriov_enabled is false, so no
> +	 * need to set link_status_ms_mask and notify the link status.
> +	 */
> +	if (!pf->sriov_enabled)
> +		goto msg_unlock;
> +
> +	pf->link_status_ms_mask |= PSIMSGSR_MS(vf_id);

[Severity: Medium]
What clears this bit if the VF goes away without unregistering?

The bit is set here and cleared only by a cooperative
ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER in
enetc_msg_unregister_link_status_notifier(), or globally in
enetc_sriov_configure() when SR-IOV is disabled. A VM destroy, a guest
crash/reboot, or a killed DPDK application leaves the bit set.

After that, every PF link transition reaches enetc_pf_send_msg() with the
stale mask and either writes the MS bit for a VF that will never read it
and then blocks the full 200 ms with pf->msg_lock held from the phylink
callbacks, or, once the MS bit is stuck set, filters that VF out and (when
it is the only registered VF) returns -EIO, logging "PF notifies link
status failed" indefinitely. Since the poll waits for all bits of the mask,
one dead VF also delays notifications to the live ones.

The FLR handler added later in the series, enetc4_pf_vf_flr_handler(),
only restores the promiscuous mode bits and does not touch
link_status_ms_mask, and enetc_sriov_configure() resets only the software
mask without bringing PSIMSGSR back to a known state. Should the per-VF
bit be cleared on FLR / VF teardown as well?

> +
> +	/* Notify VF the current link status */
> +	enetc_msg_notify_vf_link_status(pf, PSIMSGSR_MS(vf_id));
> +
> +msg_unlock:
> +	mutex_unlock(&pf->msg_lock);
> +}
> +
> +static void enetc_msg_unregister_link_status_notifier(struct enetc_pf *pf,
> +						      int vf_id)
> +{
> +	u16 pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
> +				ENETC_MSG_CLASS_ID_CMD_SUCCESS);
> +
> +	mutex_lock(&pf->msg_lock);
> +
> +	pf->link_status_ms_mask &= ~PSIMSGSR_MS(vf_id);
> +	enetc_pf_reply_msg(&pf->si->hw, vf_id, pf_msg);
> +
> +	mutex_unlock(&pf->msg_lock);
> +}
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

> @@ -367,6 +519,11 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
>  	int err;
>  
>  	if (!num_vfs) {
> +		mutex_lock(&pf->msg_lock);
> +		pf->sriov_enabled = false;
> +		pf->link_status_ms_mask = 0;
> +		mutex_unlock(&pf->msg_lock);
> +
>  		pci_disable_sriov(pdev);
>  		enetc_msg_psi_free(pf);
>  		pf->num_vfs = 0;

[ ... ]

> @@ -396,3 +567,34 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(enetc_sriov_configure);
> +
> +static void enetc_pf_notify_vf_link_status(struct enetc_pf *pf,
> +					   bool link_up)
> +{
> +	/* pf->msg_lock is initialized when pf->total_vfs is not 0 */
> +	if (!pf->total_vfs)
> +		return;
> +
> +	mutex_lock(&pf->msg_lock);
> +
> +	pf->link_up = link_up;
> +	if (!pf->link_status_ms_mask)
> +		goto msg_unlock;
> +
> +	enetc_msg_notify_vf_link_status(pf, pf->link_status_ms_mask);
> +
> +msg_unlock:
> +	mutex_unlock(&pf->msg_lock);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831025441.635045-1-wei.fang%40oss.nxp.com
