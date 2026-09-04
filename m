Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1942743E488;
	Fri,  4 Sep 2026 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559048; cv=none; b=nCzNwYfQxnEZfSk5GZgUV/foa+3w/XK4vxzwiPW6ZO7VnH4lVF1574DkCoMQWct2TEKvKz4G4HQw/sN8WVul7MbmGI4LYNAfQ3M/DPvY+/xbQbkXt92BS7j+Iypb3qnidpoLrEdYYY8mniZjJtWY593K3Pjoo2oAoN2k3bBUXiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559048; c=relaxed/simple;
	bh=RKYaqFOGjIf2vBwkCilYc+kFFQKNXJbeFRjseXJTwjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0BBZEEbynR3Bs1LCBm96iKTPiDrAuVDvHjjCltAHZOki9yvkAXW/vxIQdN2CwgiD3VHQEx95ZBFtCF+ZyXxS4eo4YlBAyzaz6gRzr+twpQr3QsGNW1FKPhvyaIyxywD9DsDGgrRPzEPPoq7XcWxanSIujosBCm+tVB78RjD6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1DDCmD4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1DDCmD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34711F00A3E;
	Fri,  4 Sep 2026 21:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788559041;
	bh=uci8gKxk33xF/HENcPwArmuTZLD74jl3MzSlnfbMShY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h1DDCmD49s3DYeql6IZrQ2gAOy4dhwSpCk+rPMF9szt1LO64RpgL75rJlgzIZEPqu
	 OX0fRV1w0mtBVW/gLFtCIQkwuMujiCGOcYl2YmuaImRKUOJMAZ2FV7A5weW9pCX29E
	 puW3Fyon5z5O4WqiKJFdjx6WbxuDxSjBOypKhUR0bfNMpjG4PkVIkFghBMD6mtrt7Y
	 7erPz2yp8+LS/Hpd1VlNpNnjeiswC823qUzM7kw/sMrTaf1P/8UsVvZmTax6rkzuF0
	 LXsLUF8fKCB/B3b/rAzjdMY6nGK4M4W19mtmEOCFqCbUPRiOkkDmat8zEAnFC6QivM
	 dncDA9XxJIhpA==
From: Jakub Kicinski <kuba@kernel.org>
To: dong100@mucse.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net-next v10 5/5] net: rnpgbe: Add link status handling support
Date: Fri,  4 Sep 2026 14:57:19 -0700
Message-ID: <20260904215719.4000060-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <0DE2629800EC1CD4+20260831073608.401988-6-dong100@mucse.com>
References: <0DE2629800EC1CD4+20260831073608.401988-6-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: rnpgbe: Add link status handling support

This patch adds firmware-driven link status handling to rnpgbe: link
state is cached from mailbox LINK_CHANGE_EVT events, a delayed service
task flips the carrier, and the driver notifies firmware of port up/down
around ndo_open and ndo_stop. A few questions about the new event and
teardown paths below.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> index feb84704d6027..5659e91f34972 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> @@ -21,6 +21,17 @@
>  #define RNPGBE_DMA_TX_STATUS           GENMASK_U32(23, 22)
>  #define RNPGBE_DMA_RX_STATUS           GENMASK_U32(21, 20)
>  #define RX_AXI_RW_EN                   0x03
> +/* RNPGBE_LINK_ST is a driver-owned link-state snapshot consumed by firmware.
> + * Set the driver-state marker; all other driver status fields start clear.
> + */
> +#define M_DEFAULT_ST                   0xa0000000
> +/* Firmware never reports 0xf in the speed field. */
> +#define M_INVALID_ST                   (M_DEFAULT_ST | GENMASK_U32(11, 8))
> +/* Driver-reported fields: 25:24 pause, 11:8 speed, 6 LLDP, 4 duplex,
> + * and 0 link up/down. M_DEFAULT_ST resets these fields so firmware reports
> + * the current hardware state again.
> + */
> +#define RNPGBE_LINK_ST                 0x000c

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> index 346e9a1cca8a9..1c649ef7ee3ac 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> @@ -16,8 +16,23 @@
>  static void rnpgbe_mbx_work(struct work_struct *work)
>  {
>  	struct mucse *mucse = container_of(work, struct mucse, mbx_work);
> +	int irq_seq;
>  
> +	irq_seq = atomic_read(&mucse->mbx_irq_seq);
>  	mucse_fw_irq_handler(&mucse->hw);
> +
> +	/*
> +	 * Only multi-vector MSI-X has a dedicated mailbox interrupt, so its
> +	 * hard IRQ records a sequence number. With a shared MSI or MSI-X
> +	 * vector, all interrupts queue this work and it checks the mailbox
> +	 * request counter. Firmware posts one request at a time and waits for
> +	 * the PF ACK before posting the next one. A mailbox interrupt while
> +	 * this work runs queues a later invocation.
> +	 */
> +	if ((mucse->flags & M_FLAG_MSIX_EN) &&
> +	    irq_seq != atomic_read(&mucse->mbx_irq_seq) &&
> +	    !test_bit(__MUCSE_DOWN, &mucse->state))
> +		queue_work(system_percpu_wq, &mucse->mbx_work);
>  }

[Severity: Medium]
The requeue here is conditioned on a new mailbox interrupt arriving during
this invocation, not on the read having failed.  Can a pending link event be
dropped when mucse_check_and_read_mbx() fails?

mucse_fw_handle_event() returns false on failure and mucse_fw_irq_handler()
discards that result:

	mutex_lock(&hw->mbx.lock);
	err = mucse_check_and_read_mbx(hw, msg.dwords, sizeof(msg));
	mutex_unlock(&hw->mbx.lock);
	if (err)
		return false;

mucse_check_and_read_mbx() -> mucse_read_mbx_pf() can fail early in
mucse_obtain_mbx_lock_pf() (read_poll_timeout with mbx->timeout_us of four
seconds), and in that case neither hw->mbx.fw_req nor the PF ACK is updated:

	err = mucse_obtain_mbx_lock_pf(hw);
	if (err)
		return err;
	...
	hw->mbx.fw_req = mucse_mbx_get_fwreq(mbx);
	mucse_mbx_inc_pf_ack(hw);

With the dedicated MSI-X mailbox vector, rnpgbe_msix_other() is the only
source that queues mbx_work, and irq_seq is unchanged for the interrupt that
scheduled this very invocation, so no requeue happens.  Per the comment above
("Firmware posts one request at a time and waits for the PF ACK before posting
the next one"), firmware would then also post nothing new.

rnpgbe_service_task() only consumes already-published events and never polls
the mailbox, so is there any path that retries the read?  Would the carrier
stay off while the link is actually up until an administrative ifdown/ifup?

[ ... ]

> @@ -1430,15 +1447,42 @@ static void rnpgbe_cancel_rx_retry_timers(struct mucse *mucse)
>  bool rnpgbe_down(struct mucse *mucse)
>  {
>  	struct net_device *netdev = mucse->netdev;
> +	struct mucse_hw *hw = &mucse->hw;
> +	unsigned long flags;
> +	int err;
>  
>  	if (test_and_set_bit(__MUCSE_DOWN, &mucse->state))
>  		return false;
>  
> +	spin_lock_irqsave(&mucse->link_lock, flags);
> +	WRITE_ONCE(hw->link, false);
> +	WRITE_ONCE(hw->speed, 0);
> +	WRITE_ONCE(hw->duplex, 0);
> +	atomic_set(&mucse->link_pending, 0);
> +	spin_unlock_irqrestore(&mucse->link_lock, flags);
> +	cancel_delayed_work_sync(&mucse->serv_task);
> +	rnpgbe_set_link(hw, false);
> +
> +	netif_carrier_off(netdev);
>  	netif_tx_disable(netdev);
>  	rnpgbe_napi_disable_all(mucse);
>  	rnpgbe_irq_disable(mucse);
>  	rnpgbe_stop_all_rx_rings(mucse);
>  	rnpgbe_cancel_rx_retry_timers(mucse);
> +
> +	err = rnpgbe_send_notify(hw, false, mucse_fw_link_report_en);
> +	if (err) {
> +		dev_warn(&hw->pdev->dev, "Send link report to hw failed %d\n",
> +			 err);
> +		dev_warn(&hw->pdev->dev, "Fw will still report link event\n");
> +	}
> +
> +	err = rnpgbe_send_notify(hw, false, mucse_fw_portup);
> +	if (err) {
> +		dev_warn(&hw->pdev->dev, "Send port down to hw failed %d\n",
> +			 err);
> +		dev_warn(&hw->pdev->dev, "Port is not truly down\n");
> +	}
>  	rnpgbe_clean_all_tx_rings(mucse);
>  	rnpgbe_clean_all_rx_rings(mucse);

[Severity: Medium]
The commit message says the port-down notification is sent "after the data
path is quiesced during teardown".  Is the TX side actually quiesced at this
point?

RX is stopped before the notification (rnpgbe_stop_all_rx_rings()), but
netif_tx_disable() only stops new software submissions.  The TX hardware is
shut down afterwards, in rnpgbe_clean_all_tx_rings() ->
rnpgbe_stop_all_tx_rings(), which clears each ring's TX_START, waits for
RNPGBE_DMA_TX_STATUS to go idle and only then clears TX_AXI_RW_EN:

	for (int i = 0; i < mucse->num_tx_queues; i++)
		rnpgbe_stop_tx_ring(mucse->tx_ring[i]);
	if (mucse->num_tx_queues && !test_bit(__MUCSE_AXI_FAULT, &mucse->state))
		err = rnpgbe_wait_tx_dma_idle(mucse);
	... dma_axi_ctl &= ~TX_AXI_RW_EN;

So firmware can take the PHY/port down while descriptors submitted earlier are
still being fetched and transmitted.  If the MAC then stops draining, the
100 ms poll in rnpgbe_wait_tx_dma_idle() times out and sets a bit that nothing
ever clears:

	if (err) {
		set_bit(__MUCSE_AXI_FAULT, &mucse->state);
		dev_err(&mucse->pdev->dev, "TX DMA failed to quiesce, status %#x\n", dma_status);
	}

__MUCSE_AXI_FAULT is only ever set and tested, never cleared, and
rnpgbe_open() returns -EIO while it is set, so the interface would stay
unusable until the driver is unbound.  Would it be safer to issue the
port-down mailbox command after rnpgbe_clean_all_tx_rings(), matching the RX
ordering?

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> index e28f3193aa854..01bab789473cf 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> @@ -199,12 +200,233 @@ int mucse_mbx_get_macaddr(struct mucse_hw *hw, int pfvfnum,

[ ... ]

> +static void mucse_mbx_fw_req_handler(struct mucse_hw *hw,
> +				     struct mbx_fw_cmd_req *req)
> +{
> +	struct mucse *mucse = container_of(hw, struct mucse, hw);
> +	u32 magic = le32_to_cpu(req->link_stat.port_magic);
> +	unsigned long flags;
> +
> +	if (le16_to_cpu(req->opcode) == LINK_CHANGE_EVT) {
> +		spin_lock_irqsave(&mucse->link_lock, flags);
> +		if (magic != ST_VALID_MAGIC) {
> +			/* Do not change the cached state for an invalid event.
> +			 * Use an invalid speed encoding to make firmware report
> +			 * again.
> +			 */
> +			mucse_hw_wr32(hw, RNPGBE_LINK_ST, M_INVALID_ST);
> +			spin_unlock_irqrestore(&mucse->link_lock, flags);
> +			return;
> +		}
> +
> +		if (mucse_link_is_up(hw, req) &&
> +		    !mucse_link_speed_valid(req)) {
> +			/* Report link down so the snapshot differs from actual
> +			 * link-up state and firmware sends a new link event.
> +			 */
> +			mucse_hw_wr32(hw, RNPGBE_LINK_ST, M_DEFAULT_ST);
> +			spin_unlock_irqrestore(&mucse->link_lock, flags);
> +			dev_warn_ratelimited(&hw->pdev->dev,
> +					     "unsupported link speed %u Mbps\n",
> +					     le16_to_cpu(req->link_stat.st.speed));
> +			return;
> +		}

[Severity: Medium]
Both rejection paths write a snapshot that is deliberately guaranteed not to
match the real link state.  Can this turn a rejected event into a
self-sustaining event source?

The documented contract in rnpgbe_hw.h and repeated in rnpgbe_up_complete()
is that firmware "only asserts LINK_CHANGE_EVT when it differs from the actual
link state AND link_report_en is true":

	M_INVALID_ST is M_DEFAULT_ST plus a speed field of 0xf, described as
	a value firmware never reports.

	M_DEFAULT_ST is a link-down snapshot, written here while the link is
	reported up.

Neither branch changes any cached driver state, keeps a retry count, applies a
backoff, or turns link_report_en off, so the same event looks like it can be
re-posted and re-rejected indefinitely.  dev_warn_ratelimited() throttles the
log line but not the event churn.

Each iteration also takes hw->mbx.lock in mucse_fw_handle_event(), which is
the same mutex used by the port up/down and link-report commands issued from
rnpgbe_up_complete() and rnpgbe_down(), and those helpers poll with
mbx->timeout_us of four seconds.  Would an older firmware revision reporting a
different port_magic, or a link up with a speed outside {10, 100, 1000}, keep
this loop running for as long as the link stays in that state?

[ ... ]

> +static bool mucse_fw_handle_event(struct mucse_hw *hw)
> +{
> +	union mbx_fw_cmd_req_u msg = {};
> +	int err;
> +
> +	/* try to check and read fw req */
> +	mutex_lock(&hw->mbx.lock);
> +	err = mucse_check_and_read_mbx(hw, msg.dwords, sizeof(msg));
> +	mutex_unlock(&hw->mbx.lock);
> +	if (err)
> +		return false;
> +
> +	mucse_mbx_fw_req_handler(hw, &msg.r);
> +
> +	return true;
> +}
> +
> +/**
> + * mucse_fw_irq_handler - Handle one pending firmware mailbox event
> + * @hw: pointer to the HW structure
> + *
> + * Process at most one event per work-item invocation. The caller requeues
> + * mailbox work when a dedicated mailbox interrupt arrives during handling.
>   **/
>  void mucse_fw_irq_handler(struct mucse_hw *hw)
>  {
> +	mucse_fw_handle_event(hw);
>  }

The discarded return value here is the same concern raised on
rnpgbe_mbx_work() above: a failed mailbox read is indistinguishable from "no
event pending".

Thanks for considering these.
