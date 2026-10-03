Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C330C177;
	Sat,  3 Oct 2026 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791057058; cv=none; b=CkHdN2zFXgIgWXIivuEmWyzulI9QhNwua8a9cspInHitP9y4dddWlkndew9Hh9aD6uqbbBIp5ACjOlmKvtg/rEusWT6zaesLdNj3NnUCH00Z8vW/GKigiBS3pOB/r2Y/eqwC3avthwxj6yYOXvJDyMwqbX3c9AznB6FD47VVtrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791057058; c=relaxed/simple;
	bh=SDGTkmDTsomO7ODQf1MVmiDtu2m9KKWqBeJHkoBgYUw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s0DsN24SUAHlVyC7SnSi06iNi6u8+LARXMR0lMAHrLk/r2/93nOh95O3kfxf9Sg64itvNFI+of8oLxIVpq4Xo/3BWVttQNqWxa98KulNAqYQn7cqoFH8A7uij7u3XP47TNCFcyycXJwrXFVpFgOab2yqxl8U7T7qK8+DFOFZ+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xs0tq8oR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xs0tq8oR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE971F0089B;
	Sat,  3 Oct 2026 19:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791057055;
	bh=XmUDUJZDDBBQDZXAP9giOqJ9nfjXtpOgwq+pbQZBo+c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xs0tq8oROOZ62jFb05YBJ2p+xKyD0VQVMHI0tGHBYMtbEwgRdX/4B7lxXGvl6Xvhf
	 jzCHflb81yC+TjuLV7CkEj6o1lD25DectiAolFmUN+AZihEKjW7urVf1BdTmR0xduo
	 tsI5FXtmfmR1syyr/ZrYPq6nt2MQqoWCfWxeiL5FVuuwXzXNsemBj79yQBQ+B/oI1S
	 a+JVLqDLVm5OakX1cztU8T8EKQ20ni+uFW18IE929oUlITmz7eaKaI3M2P0MyZYw36
	 ZG6IXyPpoCgsAWcXMwODeLC/MQBrWJC+jUDbh3BNHXqK+3HlGvFAR5sFnNj2P6KxqE
	 ht3VCG0HSH9tw==
Subject: Re: [PATCH net-next v2 3/6] enic: recover V2 VF mailbox when PF state
 is unknown
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sebaddel@cisco.com
Date: Sat, 03 Oct 2026 19:50:54 +0000
Message-ID: <179105705474.434549.8884325756137736298@kernel.org>
In-Reply-To:
 <20260929-b4-enic-sriov-v2-vf-receive-control-v2-3-5962c10061b2@cisco.com>
References:
 <20260929-b4-enic-sriov-v2-vf-receive-control-v2-3-5962c10061b2@cisco.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 6 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] enic_reset() now has two new error exits, taken when
  enic_dev_soft_reset() fails or when the newly added vnic_dev_init()…
- [High] The patch adds vf_datapath_open so that "a failed internal reset
  cannot stop it twice".
- [Medium] The commit message says the timed-out DMA mapping is left "for
  admin-channel teardown to reclaim safely".
- [Medium] vf_mbox_recovery_active is a plain bool.
- [Medium] vf_mbox_recovery_active stays true for the whole run of the
  reset worker, including the time after enic_open() has committed…
- [Medium] The patch makes several admin-RQ drop paths trigger full VF
  recovery (RX quarantine, carrier off, sends disabled, a soft reset…
- [Medium] The new V2 VF error exit in enic_open() (`goto
  err_out_dev_disable`) runs after enic_dev_enable() has succeeded, when…
- [Medium] The new vnic_dev_init() call in enic_reset() issues CMD_INIT,
  or on older firmware CMD_INIT_v1 + CMD_GET_MAC_ADDR + CMD_ADDR_ADD,…
- [Low] Concern: the patch has no Fixes: tag even though it fixes V2
  mailbox behaviour introduced by commit 1f0c856b596337.
- [Low] Concern: the commit message and comments assume a VF MAC/receive-
  filter mailbox protocol and a station/filter replay that do not exist…
- [Low] Concern: the new enic_reset_addr_lists() calls in enic_open() and
  enic_admin_chan_reopen() run __dev_uc_unsync()/__dev_mc_unsync()…

--

enic: recover V2 VF mailbox when PF state is unknown

This patch adds recovery for the V2 VF mailbox after a lost or malformed
reply. VF RX is quarantined until the admin channel has been rebuilt,
re-registered and replayed at an open/reset boundary, and the channel is
poisoned for good after a send-completion timeout. It also defers VF
notification ACKs to a work item, moves the VF handshake ahead of
enic_open() in the reset workers, calls vnic_dev_init() after soft reset
for non-dynamic vNICs, and tracks whether the V2 datapath is open.

> Assisted-by: LLM
> Signed-off-by: Satish Kharat <satishkh@cisco.com>

[Severity: Low]
This isn't a bug, but there's no Fixes: tag, even though the patch changes
V2 mailbox behaviour from commit 1f0c856b596337. The series reads as a
continuation of the V2 mailbox bring-up with the PF side still dormant, so
leaving it out may be fine for net-next. Was that intentional?

> diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
> index 61c82b48044d0..30c0a5c89a2d2 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_admin.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_admin.c

[ ... ]

> @@ -194,8 +203,10 @@ unsigned int enic_admin_rq_cq_service(struct enic *enic)
>  		rq_desc = desc;
>  		bwf = le16_to_cpu(rq_desc->bytes_written_flags);
>  		bytes_written = bwf & CQ_ENET_RQ_DESC_BYTES_WRITTEN_MASK;
> -		if (bytes_written > buf->len)
> +		if (bytes_written > buf->len) {
> +			enic_admin_rx_lost(enic);
>  			goto next_desc;
> +		}

[Severity: Medium]
Should the sender be checked before these drops trigger a full VF recovery?

This path, and the TRUNCATED and missing FCS_OK paths just below it, call
enic_admin_rx_lost() before rq_desc->vlan (the hardware-verified sender) is
read.

The same thing happens in two other places:

  - Backlog overflow in enic_admin_msg_enqueue(). Every message counts
    toward ENIC_ADMIN_MSG_MAX, even ones that are later dropped as non-PF.
  - The short-message case in enic_mbox_recv_handler(), which calls
    enic_mbox_vf_require_reconnect() before the
    src_vnic_id == ENIC_MBOX_DST_PF check.

The driver already treats non-PF senders on the VF admin RQ as spoofed. If
the adapter delivers VF-to-VF admin messages, could another VF force this
VF through repeated resets?

One such message during re-registration also makes
enic_admin_chan_reopen() return -EAGAIN. Since self-requeue is suppressed,
the VF then stays quarantined.

I couldn't confirm that firmware routes this kind of traffic. The later
patches in the series don't add sender checks to these paths either.

[ ... ]

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 9086e6dd558aa..28738bd14fa7c 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c

[ ... ]

> @@ -1736,6 +1740,30 @@ static int enic_open(struct net_device *netdev)

[ ... ]

> +	if (enic_is_sriov_vf_v2(enic) &&
> +	    (!enic->admin_chan_up || !READ_ONCE(enic->vf_registered) ||
> +	     READ_ONCE(enic->vf_mbox_reconnect_required))) {
> +		/* Re-registration makes the PF discard the old VF-requested
> +		 * filters.  Clear the netdev-core synchronization state so the
> +		 * receive-mode callback replays the current address lists.
> +		 */

[Severity: Low]
This isn't a bug, but this comment and the commit message ("restore receive
traffic after the station address and filters have been replayed") describe
a VF MAC/receive-filter mailbox protocol and a station/filter replay that
this patch doesn't contain yet.

They arrive later in the series:

  - "enic: validate V2 VF configuration replies"
  - "enic: manage V2 VF station and administrative MAC"
  - "enic: configure V2 VF receive mode over mailbox"

Could the commit message say that it depends on those follow-ups?

> +		enic_reset_addr_lists(enic);

[Severity: Low]
Does enic_reset_addr_lists() need netif_addr_lock_bh() here?

It calls __dev_uc_unsync() and __dev_mc_unsync() without the address lock.
Writers such as IPv6 MLD can change dev->mc under the address lock without
holding RTNL. The new call in enic_admin_chan_reopen() has the same issue.

This appears to be fixed later in the series, where enic_reset_addr_lists()
wraps both calls in netif_addr_lock_bh().

> +		if (enic->admin_chan_up)
> +			enic_admin_channel_close(enic);
> +		err = enic_admin_chan_reopen(enic);
> +		if (err)
> +			return err;
> +	}

[ ... ]

> @@ -1794,17 +1822,41 @@ static int enic_open(struct net_device *netdev)
>  		netdev_err(netdev, "Failed to enable device: %d\n", err);
>  		goto err_out_dev_enable;
>  	}
> +	if (enic_is_sriov_vf_v2(enic)) {

[ ... ]

> +		spin_unlock_bh(&enic->mbox_state_lock);
> +		if (err) {
> +			netdev_err(netdev,
> +				   "MBOX state changed during VF datapath open\n");
> +			goto err_out_dev_disable;
> +		}
> +	}

[ ... ]

> +err_out_dev_disable:
> +	enic_dev_disable(enic);
>  err_out_dev_enable:
>  	for (i = 0; i < enic->rq_count; i++)
>  		napi_disable(&enic->napi[i]);

[Severity: Medium]
Is this unwind enough once enic_dev_enable() has succeeded?

The existing error labels were written for failures before the device was
enabled. By this point the RQs are enabled and filled, the WQs are enabled,
and the adapter may already have written CQEs.

The unwind disables the device and queues and calls vnic_rq_clean(). It
doesn't do the vnic_cq_clean(), vnic_intr_clean() and vnic_wq_clean() calls
that __enic_stop() does after a live enable.

A later administrative enic_open() doesn't call
enic_init_vnic_resources(). On that open, could NAPI process stale CQEs
against the repositioned RQ ring? That could deliver buffers the device
never wrote, or reach an unposted buffer whose os_buf is NULL.

> @@ -1834,12 +1886,20 @@ static int enic_open(struct net_device *netdev)
>  }
>
>  /* rtnl lock is held, process context */
> -static int enic_stop(struct net_device *netdev)
> +static int __enic_stop(struct net_device *netdev, bool remove_vf_station)

[ ... ]

> +	if (enic_is_sriov_vf_v2(enic) && !enic->vf_datapath_open)
> +		return 0;
> +	(void)remove_vf_station;

[ ... ]

> @@ -1893,10 +1953,17 @@ static int enic_stop(struct net_device *netdev)
>  		vnic_cq_clean(&enic->cq[i]);
>  	for (i = 0; i < enic->intr_count; i++)
>  		vnic_intr_clean(&enic->intr[i]);
> +	if (enic_is_sriov_vf_v2(enic))
> +		enic->vf_datapath_open = false;

[Severity: High]
Does this cover the early return paths in __enic_stop()?

The flag is only cleared here, on the last line. Earlier in the function,
after napi_disable() has already run, there is:

	for (i = 0; i < enic->wq_count; i++) {
		err = vnic_wq_disable(&enic->wq[i].vwq);
		if (err)
			return err;
	}

The vnic_rq_disable() loop has the same shape. Both returns skip
enic_free_intr() and leave vf_datapath_open set to true.

enic_reset() and enic_tx_hang_reset() ignore the return value of
__enic_stop() and go on to enic_open(). There, enic_request_intr() fails
because the MSI-X vectors are still requested. enic_open() returns an error
and vf_datapath_open is still true.

A later ifdown then gets past the guard and calls napi_disable() again on
NAPI instances that are already disabled. That spins forever under RTNL.

A hung WQ in enic_tx_hang_reset() seems a likely way for vnic_wq_disable()
to time out. The commit message says the tracking exists "so a failed
internal reset cannot stop it twice". Is this path meant to be covered too?

[ ... ]

> @@ -2253,79 +2346,128 @@ static void enic_admin_chan_reopen(struct enic *enic)

[ ... ]

>  static void enic_reset(struct work_struct *work)
>  {
>  	struct enic *enic = container_of(work, struct enic, reset);
> +	bool vf_recovery = enic_is_sriov_vf_v2(enic);
> +	int err;
>
>  	if (!netif_running(enic->netdev))
>  		return;
> +	if (vf_recovery)
> +		WRITE_ONCE(enic->vf_mbox_recovery_active, true);
>
>  	rtnl_lock();

[Severity: Medium]
Can vf_mbox_recovery_active actually suppress self-requeue when
enic_reset() and enic_tx_hang_reset() are both queued?

It's a plain bool. Both workers set it to true before rtnl_lock() and to
false before rtnl_unlock().

If both work items are queued, the first one to finish clears the flag
while the second is still blocked on RTNL. The second worker then runs
enic_admin_chan_reopen() with the flag false. Any mailbox fault during that
handshake reaches:

enic_mbox_vf_kick_recovery()
	if (netif_running(enic->netdev) &&
	    !READ_ONCE(enic->vf_mbox_recovery_active))
		schedule_work(&enic->reset);

That requeues the reset, which the commit message says shouldn't happen.

There's a second gap. The check-then-schedule in
enic_mbox_vf_kick_recovery() runs without a lock, and the worker only sets
the flag after it has been dequeued. A fault in between can also requeue.

Would a lock-protected state, or a counter tied to the reset work, hold up
better here than a flag that is set on entry and cleared on exit?

[ ... ]

> +	__enic_stop(enic->netdev, false);
>  	if (enic_has_admin_chan(enic))
>  		enic_admin_channel_close(enic);
>
> -	enic_stop(enic->netdev);
>  	if (enic_is_sriov_vf_v2(enic))
>  		enic_mbox_vf_link_state_reset(enic);
> +	err = enic_dev_soft_reset(enic);
> +	if (err)
> +		goto reset_out;

[Severity: High]
Can these new error exits leave non-V2-VF devices with NAPI disabled while
netif_running() is still true?

By this point __enic_stop(enic->netdev, false) has disabled NAPI, freed the
IRQs and destroyed the page pools. If enic_dev_soft_reset() or
vnic_dev_init() fails, goto reset_out skips enic_open() for every ENIC
device type.

The double-stop guard added to __enic_stop() only covers V2 VFs:

	if (enic_is_sriov_vf_v2(enic) && !enic->vf_datapath_open)
		return 0;

On a PF, a legacy VF or a dynamic vNIC, a later ifdown or unregister calls
enic_stop()->__enic_stop()->napi_disable() on NAPI instances that are
already disabled. napi_disable_locked() then loops forever, holding RTNL,
waiting for NAPIF_STATE_SCHED / NAPIF_STATE_NPSVC to clear.

Before this patch, enic_reset() ignored the result of enic_dev_soft_reset()
and always called enic_open(). The reset is scheduled from
enic_isr_msix_err() and enic_isr_legacy() on WQ/RQ errors. That is when a
devcmd failure or an enic_dev_wait() timeout is most likely.

> +
> +	if (!enic_is_dynamic(enic)) {
> +		err = vnic_dev_init(enic->vdev, 0);

[Severity: Medium]
Should this vnic_dev_init() call hold enic->devcmd_lock?

vnic_dev_init() issues CMD_INIT through the shared devcmd registers (on
older firmware, CMD_INIT_v1 + CMD_GET_MAC_ADDR + CMD_ADDR_ADD). At this
point the netdev is registered and running.

Other runtime devcmd users take the lock. That includes one reachable from
ndo_get_stats64 without RTNL, for example by reading /proc/net/dev:

enic_dev_stats_dump()
	spin_lock_bh(&enic->devcmd_lock);
	err = vnic_dev_stats_dump(enic->vdev, vstats);

If the two interleave, can one command's arguments overwrite the other's in
the devcmd registers? The enic_dev_soft_reset() call just above was already
unlocked, but this adds up to three more unserialized devcmds.

> +		if (err) {
> +			netdev_err(enic->netdev,
> +				   "vNIC init after soft reset failed: %d\n",
> +				   err);
> +			goto reset_out;
> +		}
> +	}

[ ... ]

> +reset_out:
>  	/* Allow infiniband to fiddle with the device again */
>  	enic_set_api_busy(enic, false);
>
>  	call_netdevice_notifiers(NETDEV_REBOOT, enic->netdev);
>
> +unlock:
> +	if (vf_recovery)
> +		WRITE_ONCE(enic->vf_mbox_recovery_active, false);
>  	rtnl_unlock();
>  }

[Severity: Medium]
What happens to a mailbox fault that arrives after enic_open() has
committed but before this flag is cleared?

Once enic_open() has cleared vf_rx_quarantined and turned carrier on, the
worker still runs enic_set_api_busy(false) and
call_netdevice_notifiers(NETDEV_REBOOT) with vf_mbox_recovery_active set.
Take an admin RX fault in that window:

enic_admin_rq_cq_service()
  enic_admin_rx_lost()
    enic_mbox_vf_require_reconnect()
      enic_mbox_vf_kick_recovery()

This quarantines RX, disables sends and turns carrier off. It then skips
schedule_work() because the flag is still true.

The worker clears the flag here and returns without checking for a fault
after its commit point, so no reset gets scheduled. Wouldn't the VF then
drop every received frame, with carrier off, until someone runs down/up by
hand?

The commit message describes that outcome for a failed recovery handshake,
not a successful one.

[ ... ]

> diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
> index b8a18d9682b2f..30a5f6fda676d 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
> @@ -149,7 +149,20 @@ static int enic_mbox_send_msg_id(struct enic *enic, u8 msg_type,
>  		 * or free the buffer: the device may still DMA from dma_addr.
>  		 * Mark the channel unusable so no further sends are attempted.
>  		 */
> +		spin_lock_bh(&enic->mbox_state_lock);
>  		WRITE_ONCE(enic->mbox_send_disabled, true);
> +		WRITE_ONCE(enic->mbox_tx_poisoned, true);

[Severity: Medium]
Is the admin-channel teardown actually safe for this buffer?

The commit message says the send-timeout path leaves "the timed-out DMA
mapping for admin-channel teardown to reclaim safely". But
enic_admin_channel_close() only warns when the queue disable fails, and
then carries on:

	err = vnic_wq_disable(&enic->admin_wq);
	if (err)
		netdev_warn(enic->netdev,
			    "Failed to disable admin WQ: %d\n", err);
	...
	vnic_wq_clean(&enic->admin_wq, enic_admin_wq_buf_clean);
	...
	enic_admin_free_resources(enic);

enic_admin_wq_buf_clean() calls dma_unmap_single() and kfree() on the
buffer that this path deliberately kept alive. enic_admin_free_resources()
then frees the ring.

In enic_reset() and enic_tx_hang_reset(), this close also runs before
enic_dev_soft_reset() and enic_dev_hang_reset(), which are the operations
that would fence the admin WQ.

Suppose vnic_wq_disable() also times out on a queue that already missed its
completion. Can the device then still fetch the freed descriptor ring, or
read a buffer that has been freed and reused?

The new comment in enic.h ("until reset/DMA fencing is proven") seems to
concede that teardown doesn't prove the device has stopped.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929-b4-enic-sriov-v2-vf-receive-control-v2-0-5962c10061b2%40cisco.com
