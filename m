Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E743E42CB08;
	Mon, 21 Sep 2026 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986055; cv=none; b=Z1Wt57DyLnF2+I/jva9k1nwH4PryML4VwANin3/LGN1BYQmARDyBHzZk84IZokONI3mEjMxlEkZgCCbrSwd1+8FNk9yP3ifKX5fh9g6R7MX7WPWGtv9Wnb+PLCjIYe+0gqc1Mni0cROUBf0IGitbOI5ifBhQPYgPPaOy0s2VuJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986055; c=relaxed/simple;
	bh=aPTWd8FyH+YT5CrEbsYAxo8u+/qea/+3HoVN0VY8jW8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HCj5jdqNAcF70anEWut2rlUwASp8WYz0a3Zktq/Te+Qtn//f+8rLxKJ1UbuM7vBBLijE0dCpk5J8FjFBZpxXR4WierpMnl+ML/7PsS0oLHVSEHObThG2yN5IoiDos37k3c18aJp/++83psSj60jPBFqu4lKguXOPh770UcskcVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MetQW92c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MetQW92c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0360C1F0089A;
	Mon, 21 Sep 2026 10:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789986048;
	bh=51UYfMcEfP2X6vZ/3xe/6Qs23ant7fnze/CviFlzD6Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MetQW92cpGG1IHE9nGw2XJ3JrKsVdBfDUV99eJABqgANqFdcnsi6A3D7O7FK/4o3o
	 rCvt4y/rlZKS4rXfVdW5VUFw2K/or945gHvVa15gfQta8IyVuFE4v0jbZoE5lcZyl8
	 V0Ol4HM7+q8iGaKFkevjpg+Ywg5u29nr+AWWpJ13Nl93AL3kDcQALC4AklJOFssRmy
	 7++sjP09sGKAB55a62hoDryPgvLZYosEXdBVg1cK9mQOYzJWlCRE3a1LtXWxk2SBQt
	 EnchwCmAfZdECkR2fFrKBAH6QomuzhcM2OIpaycTneWZAV8K0e0UW1FTi6YAA6sRs2
	 egThedqip6tFA==
Subject:
 Re: [PATCH net-next v13 5/5] net: rnpgbe: Add link status handling support
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Mon, 21 Sep 2026 10:20:47 +0000
Message-ID: <178998604759.2160803.16482228339355253392@kernel.org>
In-Reply-To: <DC59A6B88E791E22+20260920092700.345667-1-dong100@mucse.com>
References: <DC59A6B88E791E22+20260920092700.345667-1-dong100@mucse.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] netif_running() is used as the gate for 'the data path is
  configured, it is safe to enable the GMAC receiver and assert carrier'.
- [High] mucse->serv_task (delayed work) is queued from the mailbox work
  item — mucse_mbx_fw_req_handler() calls…
- [Medium] M_DEFAULT_ST (0xa0000000) is simultaneously the 'driver has
  not seen link / make firmware report again' snapshot and the steady-…
- [Medium] The firmware->PF request counter read by mucse_mbx_get_fwreq()
  is only 16 bits (FIELD_GET(GENMASK_U32(15,0), MUCSE_MBX_FW2PF_CNT))…
- [Medium] rnpgbe_set_link() performs a read-modify-write of GMAC_CONTROL
  plus a write of GMAC_FRAME_FILTER, but the two callers use different…

--

net: rnpgbe: Add link status handling support

This adds firmware-driven link handling to rnpgbe: link state is cached in
struct mucse_hw, firmware link events arrive over the mailbox, and a delayed
work item (serv_task) converts them into netif_carrier_on()/off(). The patch
also adds the GMAC receiver enable in rnpgbe_set_link() and makes ndo_open
fail when the firmware port-up or link-report commands do not complete.

A few questions about the new paths below.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> index 4e2835b71f32..b56263de4a36 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c

[ ... ]

> @@ -224,3 +249,30 @@ void rnpgbe_set_rx_mode(struct net_device *netdev)
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

[Severity: Medium]
Should the read-modify-write of GMAC_CONTROL here be serialized?

The two callers disagree on the lockset. mucse_mbx_fw_req_handler() calls
rnpgbe_set_link() with mucse->link_lock held:

	spin_lock_irqsave(&mucse->link_lock, flags);
	...
	rnpgbe_set_link(hw, mucse_link_is_up(hw, req));

while rnpgbe_down() calls it after link_lock has already been dropped:

	spin_unlock_irqrestore(&mucse->link_lock, flags);
	...
	rnpgbe_set_link(hw, false);

So the intersection of locks held for GMAC_CONTROL and GMAC_FRAME_FILTER is
empty. Can the read of GMAC_CONTROL in one path interleave with the write
from the other, and can the mailbox path re-set GMAC_CONTROL_RE plus
GMAC_FRAME_FILTER = GMAC_RX_ALL after rnpgbe_down() has cleared them?

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> index feb84704d602..5659e91f3497 100644
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
>  #define RNPGBE_DMA_AXI_EN              0x0010
>  #define RNPGBE_TX_MIN_PKT_LEN          33

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> index 9afd10273a62..2a5349f03a02 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c

[ ... ]

> @@ -1399,7 +1407,19 @@ static void rnpgbe_cancel_rx_retry_timers(struct mucse *mucse)
>  void rnpgbe_down(struct mucse *mucse)
>  {
>  	struct net_device *netdev = mucse->netdev;
> +	struct mucse_hw *hw = &mucse->hw;
> +	unsigned long flags;
> +	int err;
>  
> +	spin_lock_irqsave(&mucse->link_lock, flags);
> +	WRITE_ONCE(hw->link, false);
> +	WRITE_ONCE(hw->speed, 0);
> +	WRITE_ONCE(hw->duplex, 0);
> +	atomic_set(&mucse->link_pending, 0);
> +	spin_unlock_irqrestore(&mucse->link_lock, flags);
> +	cancel_delayed_work_sync(&mucse->serv_task);

[Severity: High]
This is the only cancel_delayed_work_sync(&mucse->serv_task) in the driver.
Is that enough to keep the work item from outliving the struct mucse?

The producer is mucse_mbx_fw_req_handler(), running from mbx_work, gated
only on netif_running():

	atomic_set_release(&mucse->link_pending, 1);
	mod_delayed_work(system_percpu_wq, &mucse->serv_task, 0);

In net/core/dev.c, __dev_open() sets __LINK_STATE_START before calling
ndo_open and clears it only if ndo_open returns an error, so netif_running()
is already true on entry to rnpgbe_open() and stays true across the new
err_down unwind. Can a mailbox event serviced right after the cancel above
re-arm serv_task? Note firmware link reporting is only disabled later in
rnpgbe_down(), and that failure is merely warned about ("Fw will still
report link event").

If serv_task is left queued and the interface was never successfully
opened, removal does not appear to cancel it:

rnpgbe_rm_adapter()
    unregister_netdev()      /* no ndo_stop, device not IFF_UP */
    rnpgbe_free_mbx_irq()    /* cancels mbx_work only */
    rnpgbe_clear_interrupt_scheme()
    free_netdev(netdev)      /* frees the mucse holding serv_task */

and rnpgbe_service_task() then dereferences mucse and mucse->netdev from
that freed allocation. rnpgbe_dev_shutdown() has no serv_task cancellation
either. Should the remove and shutdown paths call
cancel_delayed_work_sync(&mucse->serv_task) before the netdev is freed?

> +
> +	netif_carrier_off(netdev);
>  	rnpgbe_irq_disable(mucse);
>  	rnpgbe_napi_disable_all(mucse);
>  	synchronize_net();
> @@ -1408,22 +1428,77 @@ void rnpgbe_down(struct mucse *mucse)
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
> +	rnpgbe_set_link(hw, false);
>  	rnpgbe_clean_all_rx_rings(mucse);
>  }

[ ... ]

> +	err = rnpgbe_send_notify(hw, true, mucse_fw_portup);
> +	if (err) {
> +		dev_err(&hw->pdev->dev,
> +			"Failed to notify firmware that port is up: %d\n", err);
> +		return err;
> +	}
> +	/* Firmware checks RNPGBE_LINK_ST (driver's last-received link state)
> +	 * and only asserts LINK_CHANGE_EVT when it differs from the actual link
> +	 * state AND link_report_en is true.
> +	 */
> +	err = rnpgbe_send_notify(hw, true, mucse_fw_link_report_en);
> +	if (err) {
> +		dev_err(&hw->pdev->dev,
> +			"Failed to enable firmware link reporting: %d\n",
> +			 err);
> +		return err;
> +	}
> +
> +	return 0;
>  }

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index 35eb858eb2c1..9ba53bb3629b 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

[ ... ]

> @@ -86,9 +87,16 @@ static int rnpgbe_open(struct net_device *netdev)
>  	err = rnpgbe_configure(mucse);
>  	if (err)
>  		goto err_free_rx;
> -	rnpgbe_up_complete(mucse);
> +	err = rnpgbe_up_complete(mucse);
> +	if (err)
> +		goto err_down;
>  
>  	return 0;
> +err_down:
> +	rnpgbe_down(mucse);
> +	rnpgbe_free_all_rx_resources(mucse);
> +	rnpgbe_free_all_tx_resources(mucse);
> +	goto err_free_irqs;
>  err_free_rx:
>  	rnpgbe_free_all_rx_resources(mucse);
>  err_free_tx:

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> index 2310f01df1f5..74f42be975c2 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> @@ -197,7 +197,8 @@ static int mucse_read_mbx_pf(struct mucse_hw *hw, __le32 *msg, u16 size)
>   * mucse_check_for_msg_pf - Check to see if the fw has sent mail
>   * @hw: pointer to the HW structure
>   *
> - * Return: 0 if the fw has set the Status bit or else -EIO
> + * Return: 0 if firmware has posted a new message, -ENOMSG if there is no
> + * new message, or -EIO if the mailbox has been reset
>   **/
>  static int mucse_check_for_msg_pf(struct mucse_hw *hw)
>  {
> @@ -205,12 +206,11 @@ static int mucse_check_for_msg_pf(struct mucse_hw *hw)
>  	u16 fw_req;
>  
>  	fw_req = mucse_mbx_get_fwreq(mbx);
> -	/* chip's register is reset to 0 when rc send reset
> -	 * mbx command. Return -EIO if in this state, others
> -	 * fw == hw->mbx.fw_req means no new msg.
> -	 **/
> -	if (fw_req == 0 || fw_req == hw->mbx.fw_req)
> +	/* The request counter is reset to zero by a mailbox reset. */
> +	if (!fw_req)
>  		return -EIO;
> +	if (fw_req == hw->mbx.fw_req)
> +		return -ENOMSG;
>  
>  	return 0;
>  }

[Severity: Medium]
Is zero really reserved for a mailbox reset?

mucse_mbx_get_fwreq() returns a 16-bit field:

	u32 val = mbx_data_rd32(mbx, MUCSE_MBX_FW2PF_CNT);

	return FIELD_GET(GENMASK_U32(15, 0), val);

and the corresponding producer side, mucse_mbx_inc_pf_req(), just does a
plain u16 increment with nothing skipping zero. So zero looks like a normal
counter value after 0xffff.

On the new asynchronous path, what recovers from that? mucse_fw_handle_event()
returns on any error without calling mucse_mbx_event_end():

	err = mucse_mbx_event_begin(hw, msg.dwords, sizeof(msg));
	if (err) {
		mutex_unlock(&hw->mbx.lock);
		if (err != -ENOMSG)
			dev_warn_ratelimited(...);
		return;
	}

so the event is never acknowledged and hw->mbx.fw_req stays stale. Per the
contract documented in mucse_mbx_event_begin(), firmware does not touch the
shared window again until the PF acknowledges, so does the counter ever get
past zero?

The new mucse_ack_pending_event() has the same test:

	fw_req = mucse_mbx_get_fwreq(mbx);
	if (fw_req == hw->mbx.fw_req)
		return 0;
	if (!fw_req)
		return -EIO;

which would make every SET_PHY_UP and LINK_REPORT_EN command fail, and with
the new error returns in rnpgbe_up_complete() that turns into a persistent
failure of ndo_open. RESET_HW is only issued from probe.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> index e28f3193aa85..6415b6430efc 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c

[ ... ]

> +static void mucse_update_link_status_reg(struct mucse_hw *hw,
> +					 struct mbx_fw_cmd_req *req)
> +{
> +	u16 status = le16_to_cpu(req->link_stat.st.status);
> +	u16 speed = le16_to_cpu(req->link_stat.st.speed);
> +	u32 value;
> +
> +	value = M_DEFAULT_ST;
> +
> +	if (mucse_link_is_up(hw, req)) {

[ ... ]

> +	} else {
> +		value &= ~BIT(0);
> +	}

[ ... ]

> +static void mucse_mbx_fw_req_handler(struct mucse_hw *hw,
> +				     struct mbx_fw_cmd_req *req)
> +{
> +	struct mucse *mucse = container_of(hw, struct mucse, hw);
> +	u32 magic = le32_to_cpu(req->link_stat.port_magic);
> +	unsigned long flags;
> +
> +	if (le16_to_cpu(req->opcode) == LINK_CHANGE_EVT) {
> +		u16 speed = le16_to_cpu(req->link_stat.st.speed);
> +
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
> +			/* Do not acknowledge an invalid speed as valid.
> +			 * Keep the snapshot mismatched so firmware retries it.
> +			 * Firmware limits link reports to one per 500 ms.
> +			 */
> +			mucse_hw_wr32(hw, RNPGBE_LINK_ST, M_DEFAULT_ST);
> +			spin_unlock_irqrestore(&mucse->link_lock, flags);
> +			dev_warn_ratelimited(&hw->pdev->dev,
> +					     "unsupported link speed %u Mbps\n",
> +					     speed);
> +			return;
> +		}

[Severity: Medium]
Can M_DEFAULT_ST here be distinguished by firmware from an acknowledged
link-down snapshot?

In mucse_update_link_status_reg() the link-down branch is:

	value = M_DEFAULT_ST;
	...
	} else {
		value &= ~BIT(0);
	}

Bit 0 is already clear in M_DEFAULT_ST, so that mask is a no-op and a
link-down snapshot with LLDP clear is byte-identical to M_DEFAULT_ST. The
speed field also collides, since mucse_speed_10 is 0 in enum mucse_speed.

Given the comment added in rnpgbe_hw.h that M_DEFAULT_ST "resets these
fields so firmware reports the current hardware state again", what happens
on this path if the cable is pulled before a valid retry arrives? The
exported snapshot already reads as link down, which matches the hardware, so
firmware can stop reporting, and rnpgbe_process_link_event() only consumes
pending events:

	if (!atomic_xchg(&mucse->link_pending, 0))
		return false;

so carrier would stay up with no way to refresh it. Under the other reading
of the register, every acknowledged link-down snapshot mismatches reality
and firmware re-reports at its 500 ms rate for as long as the link is down.

Note this path also leaves the previously cached link-up state untouched and
does not set link_pending, while the caller mucse_fw_handle_event() goes on
to acknowledge the event via mucse_mbx_event_end(). Would M_INVALID_ST,
as used by the invalid-magic branch just above, be the right value here?

> +
> +		if (!netif_running(mucse->netdev)) {
> +			rnpgbe_set_link(hw, false);
> +			mucse_update_link_status_reg(hw, req);
> +			spin_unlock_irqrestore(&mucse->link_lock, flags);
> +			return;
> +		}
> +
> +		if (mucse_link_is_up(hw, req))
> +			WRITE_ONCE(hw->link, true);
> +		else
> +			WRITE_ONCE(hw->link, false);
> +
> +		WRITE_ONCE(hw->speed, le16_to_cpu(req->link_stat.st.speed));
> +		WRITE_ONCE(hw->duplex, req->link_stat.st.flags & DUPLEX_BIT);
> +		rnpgbe_set_link(hw, mucse_link_is_up(hw, req));

[Severity: High]
Does netif_running() mean the receive data path is configured here?

__dev_open() in net/core/dev.c sets __LINK_STATE_START before it calls
ndo_open, and clears it only if ndo_open failed, so netif_running() is true
from the first statement of rnpgbe_open() until __dev_open() returns. Can a
LINK_CHANGE_EVT delivered in that window take the link-up branch above and
have rnpgbe_set_link(hw, true) write GMAC_FRAME_FILTER = GMAC_RX_ALL and set
GMAC_CONTROL_RE before rnpgbe_configure_rx() has programmed the ring bases,
RNPGBE_DMA_AXI_EN |= RX_AXI_RW_EN and RNPGBE_RX_START? rnpgbe_service_task()
uses the same gate and would call netif_carrier_on() for an interface whose
open has not completed.

The teardown side looks similar. rnpgbe_down() does not cancel or flush
mbx_work (that only happens in rnpgbe_free_mbx_irq()), so can an event
processed after rnpgbe_down()'s final rnpgbe_set_link(hw, false) re-enable
the receiver in receive-all mode with the rx rings stopped and drained? On
the new err_down path in rnpgbe_open() the rings are freed right after
rnpgbe_down() while netif_running() is still true:

rnpgbe_up_complete()   /* LINK_REPORT_EN written, ack times out */
    return err
rnpgbe_open()
    goto err_down
        rnpgbe_down()
        rnpgbe_free_all_rx_resources()

with firmware link reporting enabled at that point.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/B8AF0FDE24FAFB51%2B20260920092424.345309-1-dong100%40mucse.com
