Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6BC37A833;
	Thu, 17 Sep 2026 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608760; cv=none; b=Cs+15SvdBJjyRo8H3ccBE+AMtGMX+znBHpjtwDMrDPOa7O3L/inZpV9ORA9MVsy1OtfocANcw2VUkObYvUAt4JAQJcKXIXTe2CmL6c6etBS3fxL5h4NIkXIZRKdYChPZXdz3ugoVW/kNSK1qbvLhscdHEymtGyT4oFlSieLTrro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608760; c=relaxed/simple;
	bh=avEn7XPn73sOe/TnKFjoQOzHArz4y4hPQ02pz1C/WFE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=btYV7n9xlhWfWdHwJPvPMyRuMMCz0f0IkKADL76v4HGUeMbwTyWlPgmGp/z2UFUVmqaanmjrrMl+Z3GXcu+Yz+xqbGklJRjEEv+BzEq6F7CjRUp/LdGNDEwELk929K/ApLuAYuh3IEEC3YK2hZDkdP+tyVAV+6MRO94jbaEDj7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0GhUqQN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0GhUqQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE69C1F00899;
	Thu, 17 Sep 2026 01:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608753;
	bh=dUE9PJFRYtDz+k/j2rAJASUy0lu984M0LgC3krwNuVs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m0GhUqQNEDHmIeVKKpufbYHXQxc892KQYULz/lduRcZhlyQGftb7mma8EIeoEDH3C
	 6Q1znUQMKJPpojCVJJhlXzySlLLYMfX+vs+sMseun2tWyP2HHNAog+KTgAuO99U4KU
	 OojVUkV2sTw8kVVaQL31Rvdhs75Axv6kE662l5Kulgq9hKfQL/WJXu7Rj0XXbSYu95
	 u1Kdz3NgE4EkkDL21aWH3KNiI6LL6k69SNyszxnqqnyHhTPI+itV422fjn9UlmAJQ9
	 Mf0h8XeEk+MQs4WoQ/zQ95VxLAp/6ui2+FaQ1MCL+AbhpVYBc20PX3zKbFZuUu/9Jk
	 1GhmQ4lpnLeiw==
Subject:
 Re: [PATCH net-next v12 5/5] net: rnpgbe: Add link status handling support
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Thu, 17 Sep 2026 01:32:32 +0000
Message-ID: <178960875235.22033.15750556489804734666@kernel.org>
In-Reply-To: <37722C0F45E58956+20260914013251.2262704-1-dong100@mucse.com>
References: <37722C0F45E58956+20260914013251.2262704-1-dong100@mucse.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 · Low: 2

- [Medium] A mailbox-buffer-lock timeout permanently abandons a pending
  firmware event without acknowledging or retrying it.
- [Medium] With asynchronous firmware->PF LINK_CHANGE_EVT messages now
  enabled, the PF->FW transmit path can overwrite an unread firmware…
- [Low] The new `serv_task` delayed work re-arms itself unconditionally
  every 500 ms for the whole time the interface is up, but it has no…
- [Low] `rnpgbe_set_link()` performs an unsynchronized read-modify-write
  of GMAC_CONTROL (`u32 value = mucse_hw_rd32(hw, GMAC_CONTROL);` ...…

--

net: rnpgbe: Add link status handling support

This adds link state tracking to the rnpgbe driver: firmware link events
arrive over the mailbox and are consumed by a new delayed-work service
task that drives netif_carrier_on()/netif_carrier_off().  It also notifies
firmware on interface up/down and enables the GMAC receiver in
receive-all mode once the chip-level receive filter is programmed.

A few questions below about the mailbox event handling, the GMAC_CONTROL
update and the periodic service task.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> index 4e2835b71f322..798e4fa3905ac 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c

[ ... ]

> @@ -224,3 +230,30 @@ void rnpgbe_set_rx_mode(struct net_device *netdev)
>  	mucse_hw_wr32(hw, RNPGBE_RX_MCAST_CTRL, mcast_ctrl);
>  	mucse_hw_wr32(hw, RNPGBE_RX_FILTER_CTRL, filter_ctrl);
>  }
> +
> +/**
> + * rnpgbe_set_link - Set the hardware link state
> + * @hw: hw information structure
> + * @linkup: link on or not
> + *
> + * rnpgbe_set_link setup link status
> + *
> + **/
> +void rnpgbe_set_link(struct mucse_hw *hw, bool linkup)
> +{
> +	u32 value = mucse_hw_rd32(hw, GMAC_CONTROL);
> +
> +	/* The chip-level filter is programmed by ndo_set_rx_mode(). Keep the
> +	 * GMAC in receive-all mode so it does not discard frames accepted by
> +	 * that filter.
> +	 */
> +	if (linkup) {
> +		mucse_hw_wr32(hw, GMAC_FRAME_FILTER, GMAC_RX_ALL);
> +		value |= GMAC_CONTROL_RE;
> +		mucse_hw_wr32(hw, GMAC_CONTROL, value);
> +	} else {
> +		value &= ~GMAC_CONTROL_RE;
> +		mucse_hw_wr32(hw, GMAC_CONTROL, value);
> +		mucse_hw_wr32(hw, GMAC_FRAME_FILTER, 0);
> +	}
> +}

[Severity: Low]
This does a read-modify-write of GMAC_CONTROL to toggle only the RE bit.
Grepping the driver shows GMAC_CONTROL is not written anywhere else, and
the driver never programs the MAC speed/duplex/port-select bits even
though mucse_mbx_fw_req_handler() caches speed and duplex from the link
event (they feed only the netdev_info() print and the RNPGBE_LINK_ST
snapshot).

If those bits are owned by the firmware that drives the link, can a
firmware write to GMAC_CONTROL that lands between this read and this
write be lost, leaving the MAC configured for a different line rate or
duplex than the driver reports?

The two callers are:

  rnpgbe_service_task() -> rnpgbe_link_is_up() -> rnpgbe_set_link(hw, true)
  rnpgbe_down() -> rnpgbe_set_link(hw, false)

and in rnpgbe_down() this runs before SET_PHY_UP=0 is sent, so both can
overlap a firmware link-programming instant.  Would toggling RE without
preserving the rest of the register, or a documented handshake for this
register, be preferable here?

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> index e4b7ff992c4d0..8b73bd4bb5db4 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> @@ -16,8 +16,15 @@
>  static void rnpgbe_mbx_work(struct work_struct *work)
>  {
>  	struct mucse *mucse = container_of(work, struct mucse, mbx_work);
> +	int irq_seq;
>  
> +	irq_seq = atomic_read(&mucse->mbx_irq_seq);
>  	mucse_fw_irq_handler(&mucse->hw);
> +
> +	/* A mailbox interrupt while this work runs needs another invocation. */
> +	if (irq_seq != atomic_read(&mucse->mbx_irq_seq) &&
> +	    !test_bit(__MUCSE_DOWN, &mucse->state))
> +		queue_work(system_percpu_wq, &mucse->mbx_work);
>  }

[ ... ]

> @@ -1372,10 +1381,23 @@ static void rnpgbe_cancel_rx_retry_timers(struct mucse *mucse)
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
>  	rnpgbe_irq_disable(mucse);
>  	rnpgbe_napi_disable_all(mucse);
> @@ -1384,6 +1406,20 @@ bool rnpgbe_down(struct mucse *mucse)
>  	rnpgbe_stop_all_rx_rings(mucse);
>  	rnpgbe_cancel_rx_retry_timers(mucse);
>  	rnpgbe_clean_all_tx_rings(mucse);
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
>  	rnpgbe_clean_all_rx_rings(mucse);

[Severity: Medium]
These two mailbox commands are sent while firmware link reporting is
still enabled, and both mailbox directions share a single shared-memory
window (MUCSE_MBX_FWPF_SHM = 8 in rnpgbe_mbx.h).

mucse_write_mbx_pf() only arbitrates the hardware PFU lock; it never
checks mucse_check_for_msg_pf() before writing the request words.  Per
the comment added to mucse_fw_handle_event(), firmware releases the
buffer lock before raising the interrupt and then waits for the PF ack.

In that window, can rnpgbe_down() -> mucse_mbx_link_report(false) or
mucse_mbx_phyup(false) write over an unread LINK_CHANGE_EVT sitting in
the shared window?

The mailbox work item serializes on hw->mbx.lock held by the writer, so
it runs afterwards, still sees a changed fw_req, reads back the driver's
own request words, acks them and drops them because the opcode is not
LINK_CHANGE_EVT.  Is the link event then lost with RNPGBE_LINK_ST left
un-acknowledged?

Additionally, if firmware does not service a new PF request while it is
still waiting for its own ack, does mucse_poll_for_ack() stall for the
full mbx->timeout_us (4 s) for each of these two commands, with rtnl
held from ndo_stop?  Before this patch there were no firmware-initiated
messages, so this collision could not occur.

>  	return true;
> @@ -1392,17 +1428,60 @@ bool rnpgbe_down(struct mucse *mucse)
>  /**
>   * rnpgbe_up_complete - Final step for port up
>   * @mucse: pointer to private structure
> + *
> + * Return: 0 on success, negative errno if firmware setup fails
>   **/
> -void rnpgbe_up_complete(struct mucse *mucse)
> +int rnpgbe_up_complete(struct mucse *mucse)
>  {

[ ... ]

> +	err = rnpgbe_send_notify(hw, true, mucse_fw_link_report_en);
> +	if (err) {
> +		dev_err(&hw->pdev->dev,
> +			"Failed to enable firmware link reporting: %d\n",
> +			 err);
> +		return err;
> +	}
> +
> +	queue_delayed_work(system_percpu_wq, &mucse->serv_task,
> +			   msecs_to_jiffies(500));
> +
> +	return 0;
>  }

[ ... ]

> @@ -2059,3 +2138,111 @@ int rnpgbe_configure_rx(struct mucse *mucse)
>  
>  	return 0;
>  }
> +
> +/**
> + * rnpgbe_process_link_event - Consume a pending link event
> + * @mucse: pointer to the device private structure
> + * @link: link status snapshot
> + * @speed: link speed snapshot
> + * @duplex: link duplex snapshot
> + *
> + * Return: true if a link event was consumed, false otherwise
> + **/
> +static bool rnpgbe_process_link_event(struct mucse *mucse, bool *link,
> +				      int *speed, u8 *duplex)
> +{
> +	struct mucse_hw *hw = &mucse->hw;
> +	unsigned long flags;
> +
> +	if (!atomic_xchg(&mucse->link_pending, 0))
> +		return false;
> +
> +	spin_lock_irqsave(&mucse->link_lock, flags);
> +	*link = hw->link;
> +	*speed = hw->speed;
> +	*duplex = hw->duplex;
> +	spin_unlock_irqrestore(&mucse->link_lock, flags);
> +
> +	return true;
> +}

[ ... ]

> +/**
> + * rnpgbe_process_link_subtask - Process a link-state update
> + * @mucse: pointer to the device private structure
> + **/
> +static void rnpgbe_process_link_subtask(struct mucse *mucse)
> +{
> +	bool link;
> +	int speed;
> +	u8 duplex;
> +
> +	/* if interface is down do nothing */
> +	if (test_bit(__MUCSE_DOWN, &mucse->state))
> +		return;
> +
> +	if (!rnpgbe_process_link_event(mucse, &link, &speed, &duplex))
> +		return;
> +
> +	if (link)
> +		rnpgbe_link_is_up(mucse, speed, duplex);
> +	else
> +		rnpgbe_link_is_down(mucse);
> +}
> +
> +/**
> + * rnpgbe_service_task - Manages and runs subtasks
> + * @work: pointer to work_struct containing our data
> + **/
> +void rnpgbe_service_task(struct work_struct *work)
> +{
> +	struct mucse *mucse = container_of(work, struct mucse, serv_task.work);
> +
> +	if (test_bit(__MUCSE_DOWN, &mucse->state))
> +		return;
> +
> +	rnpgbe_process_link_subtask(mucse);
> +
> +	if (!test_bit(__MUCSE_DOWN, &mucse->state))
> +		queue_delayed_work(system_percpu_wq, &mucse->serv_task,
> +				   msecs_to_jiffies(500));
> +}

[Severity: Low]
This isn't a bug, but is there anything the periodic re-arm can ever
discover on its own?

rnpgbe_process_link_subtask() is the only sub-task and it returns
immediately unless atomic_xchg(&mucse->link_pending, 0) is non-zero.
link_pending is set only in mucse_mbx_fw_req_handler(), which in the
same critical section already does:

	mod_delayed_work(system_percpu_wq, &mucse->serv_task, 0);

So every real event is dispatched immediately, and the 500 ms tick
started by the queue_delayed_work() at the end of rnpgbe_up_complete()
appears to be a per-interface wakeup with no consumer.

The in-tree comment in mucse_mbx_fw_req_handler() says the periodic
schedule is kept "for future maintenance work", while the commit message
describes it as "Add a service task to handle pending events".  Could the
periodic re-arm be dropped until a sub-task actually needs it, or the
commit message state what the periodic run is for?

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> index 2310f01df1f50..185465d4e0dcd 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> @@ -252,6 +252,26 @@ int mucse_poll_and_read_mbx(struct mucse_hw *hw, __le32 *msg, u16 size)
>  	return mucse_read_mbx_pf(hw, msg, size);
>  }
>  
> +/**
> + * mucse_check_and_read_mbx - check if there is notification and receive message
> + * @hw: pointer to the HW structure
> + * @msg: the message buffer
> + * @size: length of buffer
> + *
> + * Return: 0 if it successfully received a message notification and
> + * copied it into the receive buffer, negative errno on failure
> + **/
> +int mucse_check_and_read_mbx(struct mucse_hw *hw, __le32 *msg, u16 size)
> +{
> +	int err;
> +
> +	err = mucse_check_for_msg_pf(hw);
> +	if (err)
> +		return err;
> +
> +	return mucse_read_mbx_pf(hw, msg, size);
> +}
> +
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> index e28f3193aa854..9a40c73f357fc 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c

[ ... ]

> +/**
> + * mucse_mbx_link_report - Configure firmware link-change event reporting
> + * @hw: pointer to the HW structure
> + * @is_report: true for report, false for no
> + *
> + * mucse_mbx_link_report echo fw to change event report state
> + *
> + * Return: 0 on success, negative errno on failure
> + **/
> +int mucse_mbx_link_report(struct mucse_hw *hw, bool is_report)
> +{

[ ... ]

> +	len = le16_to_cpu(req.r.datalen);
> +	mutex_lock(&hw->mbx.lock);
> +	err = mucse_write_and_wait_ack_mbx(hw, req.dwords, len);
> +	mutex_unlock(&hw->mbx.lock);
> +
> +	return err;
> +}

[ ... ]

> +		WRITE_ONCE(hw->speed, le16_to_cpu(req->link_stat.st.speed));
> +		WRITE_ONCE(hw->duplex, req->link_stat.st.flags & DUPLEX_BIT);
> +		/* update regs to notify link info is received */
> +		mucse_update_link_status_reg(hw, req);
> +		atomic_set_release(&mucse->link_pending, 1);
> +		/* Run link handling immediately; the service task also remains
> +		 * periodically scheduled for future maintenance work.
> +		 */
> +		mod_delayed_work(system_percpu_wq, &mucse->serv_task, 0);
> +		spin_unlock_irqrestore(&mucse->link_lock, flags);
> +	}
> +}
> +
> +/**
> + * mucse_fw_handle_event - Handle one pending firmware event
> + * @hw: pointer to the hardware structure
> + **/
> +static void mucse_fw_handle_event(struct mucse_hw *hw)
> +{
> +	union mbx_fw_cmd_req_u msg = {};
> +	int err;
> +
> +	/* try to check and read fw req */
> +	mutex_lock(&hw->mbx.lock);
> +	err = mucse_check_and_read_mbx(hw, msg.dwords, sizeof(msg));
> +	mutex_unlock(&hw->mbx.lock);
> +	/* Firmware releases the mailbox lock before raising the interrupt and
> +	 * waits for the ACK. A failure is not transient contention to retry.
> +	 */
> +	if (err)
> +		return;
> +
> +	mucse_mbx_fw_req_handler(hw, &msg.r);
> +}

[Severity: Medium]
Is the comment "A failure is not transient contention to retry" accurate
for a mailbox-buffer-lock timeout?

mucse_check_and_read_mbx() -> mucse_read_mbx_pf() starts with:

	err = mucse_obtain_mbx_lock_pf(hw);
	if (err)
		return err;

On a timeout there (up to mbx->timeout_us, 4 s) hw->mbx.fw_req is not
refreshed and mucse_mbx_inc_pf_ack() is never called, so the event stays
pending in hardware.  mucse_fw_handle_event() then discards the error
unconditionally, and rnpgbe_mbx_work() only re-invokes on a newly
observed interrupt:

	if (irq_seq != atomic_read(&mucse->mbx_irq_seq) &&
	    !test_bit(__MUCSE_DOWN, &mucse->state))
		queue_work(system_percpu_wq, &mucse->mbx_work);

If firmware has released the buffer lock and is waiting for the PF ack,
as the comment states, no further interrupt need arrive.  Does the link
event get dropped permanently in that case, leaving netif_carrier state
stale and the firmware event channel waiting for an ack that never
comes?

Related: the new kernel-doc for mucse_check_and_read_mbx() says
"negative errno on failure", but mucse_check_for_msg_pf() returns the
same -EIO for the two non-failure cases "no new message" and "register
reset".  Should those be distinguishable from real errors so the caller
can tell whether a retry is warranted?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/64BE41C2D2C0836A%2B20260914013019.2262317-1-dong100%40mucse.com
