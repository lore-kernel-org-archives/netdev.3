Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF445A284;
	Thu, 24 Sep 2026 23:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290914; cv=none; b=sUGWsHPK5xy3T8G/IZpeHBwtg6y1p1UapoHnPMhEss3c6A4TdSYV0cX5Gd1zhxiTUasEimE8kiPwdd5AxosgDOxWQGKeyHKUahM9K6rAyLfqYhJs/7LdcuW06JWrlNpQVp78EcKGFMZL+6iW6XU2VtjHasix7Ud48OrNDt+WQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290914; c=relaxed/simple;
	bh=fM69l3nsMwhYylx3upl2fefZFUts3qGMLs6ipx+93ys=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hu2fCaitTstu5AhemRMODZaXbSEb0f79c8NiXY5CCJgNLIeT181XbHwDRmzYaQ4Ma/Y3qkqLRW54YknY+T9LSxcpHo9kimBe+y4ucoivFTO1U5wAR2P/4zDpYJ4fnazPdz7IaBOGKXd3A4x99HAvUCEHo7igUcDX/RykRKMtlyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hy1kRU0y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hy1kRU0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C681F00898;
	Thu, 24 Sep 2026 23:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790290912;
	bh=gK7AAnRkSbSlFQmfOb75p4d3UnF4yTrEGddOz/t1RnI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hy1kRU0yqGbWsxe74T5cwGFjV2uKPAblOHbly/EXXD/HIxH/2uetSi5BndjGKj7wI
	 PyUfDt+gKd9NrhDQEcwBO3l0k+2cNQQYgqaV9oZ1A+67/AnzMNm65YMC1TpCslbcoI
	 6OH18V6vkQ6qB0fC/eDyylPc1L1HFxQRqqWI262J9cbkjccD8OXkLjfpPvn82WSQUn
	 eOS+loofGkOkVXeN46+WPTs8evNaB/rVLOeiGNsKsiRzhevoV00nSULqJDuEKV+O2F
	 rvG/RSA/oCl4zsuVMxgj2E3AWg7mjFLmWuk2iT9p2SehKV7k0v3BJoQJXWLzxsKDKI
	 efUqibMtQhueA==
Subject:
 Re: [PATCH net-next 3/6] enic: recover V2 VF mailbox when PF state is unknown
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sebaddel@cisco.com
Date: Thu, 24 Sep 2026 23:01:51 +0000
Message-ID: <179029091102.2160803.2616233664154985745@kernel.org>
In-Reply-To:
 <20260921-b4-enic-sriov-v2-vf-receive-control-v1-3-67a0a6e08d43@cisco.com>
References:
 <20260921-b4-enic-sriov-v2-vf-receive-control-v1-3-67a0a6e08d43@cisco.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 4 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] enic_reset() gains two abort paths (enic_dev_soft_reset()
  failure and the new vnic_dev_init() failure) that `goto reset_out`…
- [High] __enic_stop() still returns early mid-teardown when
  vnic_wq_disable()/vnic_rq_disable() times out, and both reset workers…
- [High] enic_mbox_vf_kick_recovery() unconditionally does
  schedule_work(&enic->reset) with no attempt counter, backoff, or…
- [High] enic: VF permanently locked out after send timeout due to
  uncleared mbox_tx_poisoned
- [Medium] The new admin-channel recovery inside enic_open() can race
  enic_remove(): enic_remove() unregisters the VF and calls…
- [Medium] Malformed admin messages can quarantine and reset a V2 VF
  before the hardware-verified sender is checked: for messages shorter…
- [Low] Commit message and new in-tree comments (enic_open(),
  enic_admin_chan_reopen(), struct enic.vf_mbox_reconnect_required)…
- [Low] The patch fixes several distinct user-visible defects (lost-reply
  state divergence, RX served while VF state is unknown, double NAPI…

--

enic: recover V2 VF mailbox when PF state is unknown

This adds a reconnect/quarantine state machine for the V2 VF mailbox: a lost
or malformed reply marks the protocol generation stale, receive traffic is
dropped while the VF cannot trust its state, link-state acknowledgments are
deferred to a work item, and the reset workers now rebuild the admin channel
and re-run vnic_dev_init() before reopening the datapath.

A few questions below.

> Assisted-by: LLM
> Signed-off-by: Satish Kharat <satishkh@cisco.com>

[Severity: Low]
Should this carry Fixes: tags and be split up?  The change fixes several
distinct user-visible defects (state divergence after a lost reply, receive
traffic served while the VF state is unknown, a second NAPI disable after a
failed internal reset) but has no Fixes: tag.

It also bundles at least six independent mechanisms in one patch: the
mailbox reconnect state machine, the RX quarantine in the datapath, the
deferred notification-ACK worker, the new post-soft-reset vnic_dev_init()
that also affects PFs, the datapath-open tracking, and the new
reset-abort behaviour.  Splitting these would make the double-stop fix or
the deferred ACK backportable without the permanent mbox_tx_poisoned
policy.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
> index 61c82b48044d0..30c0a5c89a2d2 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_admin.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
> @@ -132,14 +132,22 @@ unsigned int enic_admin_wq_cq_service(struct enic *enic)
>   */
>  #define ENIC_ADMIN_MSG_MAX	256
>  
> +static void enic_admin_rx_lost(struct enic *enic)
> +{
> +	if (enic_is_sriov_vf_v2(enic))
> +		enic_mbox_vf_require_reconnect(enic);
> +}
> +

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

[ ... ]

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 9086e6dd558aa..1c60e7a666aeb 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c

[ ... ]

> @@ -1736,6 +1740,30 @@ static int enic_open(struct net_device *netdev)
>  		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>  	};
>  
> +	/* A reply timeout invalidates the current request generation.  Rebuild
> +	 * and re-register the channel before allocating datapath resources so a
> +	 * later userspace down/up can recover a failed open or reset handshake.
> +	 * A send timeout is intentionally not recoverable here because its WQ
> +	 * descriptor may still be hardware-owned.
> +	 */
> +	if (enic_is_sriov_vf_v2(enic) &&
> +	    READ_ONCE(enic->mbox_tx_poisoned))
> +		return -EIO;
> +	if (enic_is_sriov_vf_v2(enic) &&
> +	    (!enic->admin_chan_up || !READ_ONCE(enic->vf_registered) ||
> +	     READ_ONCE(enic->vf_mbox_reconnect_required))) {
> +		/* Re-registration makes the PF discard the old VF-requested
> +		 * filters.  Clear the netdev-core synchronization state so the
> +		 * receive-mode callback replays the current address lists.
> +		 */
> +		enic_reset_addr_lists(enic);
> +		if (enic->admin_chan_up)
> +			enic_admin_channel_close(enic);
> +		err = enic_admin_chan_reopen(enic);
> +		if (err)
> +			return err;
> +	}

[Severity: Low]
Do these comments describe code that only exists in later patches of the
series?  The comment in enic_open() talks about the PF discarding "old
VF-requested filters" and about the receive-mode callback replaying address
lists, and enic_admin_chan_reopen() says "RX remains quarantined until
enic_open() replays the station and receive policy".

At this commit the only VF to PF requests are CAPABILITY, REGISTER and
UNREGISTER, enic_set_rx_mode() is devcmd based, and enic_open() does not
install a station address for SR-IOV VFs, so there is nothing to replay
yet.  The commit message has the same forward reference:

  "then restore receive traffic after the station address
   and filters have been replayed"

Would it read better to move these comments to the patches that add the
ADD_DEL_MAC / SET_PKT_FILTER transactions?

[Severity: Medium]
Can this new admin-channel rebuild inside ndo_open race enic_remove()?
enic_remove() unregisters the VF and calls enic_admin_channel_close()
before unregister_netdev(), and without rtnl_lock():

enic_remove()
	if (enic_is_sriov_vf_v2(enic)) {
		if (READ_ONCE(enic->vf_registered))
			enic_mbox_vf_unregister(enic);
		...
		enic_admin_channel_close(enic);
	}
	unregister_netdev(netdev);

Meanwhile "ip link set dev X up" reaches enic_open(), sees !admin_chan_up
or !vf_registered, and runs enic_admin_channel_close() followed by
enic_admin_chan_reopen().  The gate in enic_admin_channel_close() is only

	if (!enic->admin_chan_up)
		return;

which is a plain bool read outside any lock, so it does not serialise the
two teardowns.  Can this either double-free the admin resources and IRQ,
or leave a freshly reopened admin channel (requested MSI-X vector, DMA
rings, live work items) behind after free_netdev()?  Disabling the reset
work items in enic_remove() does not cover ndo_open.

> @@ -1834,12 +1886,20 @@ static int enic_open(struct net_device *netdev)
>  }
>  
>  /* rtnl lock is held, process context */
> -static int enic_stop(struct net_device *netdev)
> +static int __enic_stop(struct net_device *netdev, bool remove_vf_station)
>  {
>  	struct enic *enic = netdev_priv(netdev);
>  	unsigned int i;
>  	int err;
>  
> +	/* Internal reset leaves netif_running() set while the datapath is down.
> +	 * If re-registration or reopen then fails, a later administrative close
> +	 * must not disable NAPI a second time.
> +	 */
> +	if (enic_is_sriov_vf_v2(enic) && !enic->vf_datapath_open)
> +		return 0;
> +	(void)remove_vf_station;
> +

[ ... ]

> @@ -1893,10 +1953,17 @@ static int enic_stop(struct net_device *netdev)
>  		vnic_cq_clean(&enic->cq[i]);
>  	for (i = 0; i < enic->intr_count; i++)
>  		vnic_intr_clean(&enic->intr[i]);
> +	if (enic_is_sriov_vf_v2(enic))
> +		enic->vf_datapath_open = false;
>  
>  	return 0;
>  }

[Severity: High]
Can vf_datapath_open stay true after a partial teardown?  __enic_stop()
still returns early when a queue refuses to stop:

	for (i = 0; i < enic->wq_count; i++) {
		err = vnic_wq_disable(&enic->wq[i].vwq);
		if (err)
			return err;
	}

That return happens after napi_disable() but before enic_free_intr(),
vnic_wq_clean(), vnic_rq_clean(), page_pool_destroy() and before the new
"enic->vf_datapath_open = false" at the end of the function.

Both reset workers now invoke it as a bare statement and ignore the
error:

	enic_dev_hang_notify(enic);
	__enic_stop(enic->netdev, false);

enic_tx_hang_reset() runs precisely because a queue is hung, and
vnic_wq_disable()/vnic_rq_disable() poll the hardware running bit and
return -ETIMEDOUT when it does not clear.  The worker then continues into
enic_dev_hang_reset() and enic_init_vnic_resources(), reprogramming the
ring control registers while to_use/to_clean/desc_avail still describe
the pre-reset ring, with buffers still DMA-mapped and data-path IRQs
still requested.

If enic_admin_chan_reopen() then fails and the worker exits via
hang_reset_out without napi_enable(), vf_datapath_open is still true, so
the guard at the top of __enic_stop() does not fire on the next
dev_close() and napi_disable() is called again on an already disabled
NAPI.  napi_disable_locked() loops:

	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		usleep_range(20, 200);
		val = READ_ONCE(n->state);
	}

and only napi_enable() clears those bits, so does this spin forever with
RTNL held?  Would clearing vf_datapath_open before the fallible teardown
steps, and propagating the __enic_stop() error, avoid this?

> @@ -2253,79 +2346,119 @@ static void enic_admin_chan_reopen(struct enic *enic)
>  		 */
>  		schedule_work(&enic->link_notify_work);
>  	}
> +
> +	return 0;
>  }
>  
>  static void enic_reset(struct work_struct *work)
>  {
>  	struct enic *enic = container_of(work, struct enic, reset);
> +	int err;
>  
>  	if (!netif_running(enic->netdev))
>  		return;

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
> +
> +	if (!enic_is_dynamic(enic)) {
> +		err = vnic_dev_init(enic->vdev, 0);
> +		if (err) {
> +			netdev_err(enic->netdev,
> +				   "vNIC init after soft reset failed: %d\n",
> +				   err);
> +			goto reset_out;
> +		}
> +	}

[Severity: High]
Is mbox_tx_poisoned ever cleared again?  I cannot find a single
WRITE_ONCE(enic->mbox_tx_poisoned, false) anywhere in the series, so
after one admin-WQ send timeout in enic_mbox_send_msg_id() the flag
stays set for the rest of the driver's lifetime on that device, and
every recovery route is then closed:

  - enic_admin_channel_open() returns -EIO up front,
  - enic_open() returns -EIO before it touches any datapath resource,
  - enic_reset() and enic_tx_hang_reset() abort at
    enic_admin_chan_reopen(), which also re-checks the flag under
    mbox_state_lock and turns a successful re-registration into
    -EAGAIN.

So a single timeout leaves the VF with carrier down, vf_rx_quarantined
set, and "ip link set dev X down; ip link set dev X up" failing with
-EIO until the driver is unloaded or the device re-probed.  Given that
ENIC_MBOX_POLL_TIMEOUT_US is a bounded poll against a PF that may just
be slow or busy, that seems like a heavy penalty for one lost send
completion.

The field comment says the channel must not be reopened "until
reset/DMA fencing is proven", but the reset path in this same patch
looks like it provides exactly that: enic_admin_channel_close() stops
the admin QP and runs vnic_wq_clean(&enic->admin_wq,
enic_admin_wq_buf_clean), which is what the commit message calls the
teardown that reclaims the timed-out mapping, and enic_reset() then
runs enic_dev_soft_reset() plus the new vnic_dev_init() before
anything is reopened.  If that sequence is sufficient to retire the
hardware-owned descriptor, should the poison be cleared there rather
than being permanent?  If it is not sufficient, could you spell out
what is still unfenced after the soft reset, and how an operator is
expected to get the VF back without a module reload?

Related: on the timeout path the kmalloc'd buffer and its
dma_map_single() mapping are deliberately leaked.  If the channel can
never be reopened, is enic_admin_channel_close() still guaranteed to
run (and thus unmap it), or does this also leak the mapping until
device removal?

[Severity: High]
What happens to a plain PF (or dynamic/legacy VF) when either of these two
new aborts is taken?  Before this change enic_reset() always ran
enic_init_vnic_resources() and enic_open() after the soft reset; now both
"goto reset_out" paths skip them, and reset_out only clears api_busy,
fires NETDEV_REBOOT and unlocks RTNL.  The worker is not requeued.

enic_dev_soft_reset() is enic_dev_wait(vnic_dev_soft_reset,
vnic_dev_soft_reset_done, 0), so it returns -ETIMEDOUT after a couple of
seconds when firmware never completes, which is the unresponsive-firmware
case that triggers the reset in the first place.

After such an abort, netif_running() is still true while the vNIC is
disabled and unprogrammed, the IRQs are freed and every NAPI is left
disabled.  The new double-stop guard is gated on enic_is_sriov_vf_v2(),
and vf_datapath_open is not even maintained for other device types, so
the next ndo_stop() or _enic_change_mtu():

	if (running) {
		err = enic_stop(netdev);

re-runs the full teardown and calls napi_disable() a second time, which
spins in napi_disable_locked() with RTNL held, and enic_free_intr()
re-issues free_irq() on already freed IRQs.  Should these abort paths
either complete the reopen or at least mark the datapath as already
stopped for all device types?

> @@ -2333,21 +2466,30 @@ static void enic_tx_hang_reset(struct work_struct *work)
>  	enic_dev_set_ig_vlan_rewrite_mode(enic);
>  	enic_ext_cq(enic);
>  
> -	enic_open(enic->netdev);
> +	if (enic_is_sriov_vf_v2(enic)) {
> +		err = enic_admin_chan_reopen(enic);
> +		if (err)
> +			goto hang_reset_out;
> +	}

[ ... ]

> diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
> index b8a18d9682b2f..2d77d41577a3a 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c

[ ... ]

> @@ -193,6 +305,26 @@ static int enic_mbox_vf_send_request(struct enic *enic, u8 request_type,
>  				     expected_reply);
>  }
>  
> +static void enic_mbox_vf_mark_reconnect_locked(struct enic *enic,
> +					       bool registration_lost)
> +{
> +	lockdep_assert_held(&enic->mbox_state_lock);
> +
> +	if (registration_lost)
> +		WRITE_ONCE(enic->vf_registered, false);
> +	enic->vf_mbox_fault_generation++;
> +	WRITE_ONCE(enic->vf_mbox_reconnect_required, true);
> +	WRITE_ONCE(enic->mbox_send_disabled, true);
> +	WRITE_ONCE(enic->vf_rx_quarantined, true);
> +}
> +
> +static void enic_mbox_vf_kick_recovery(struct enic *enic)
> +{
> +	enic_mbox_vf_link_state_set_running(enic, false);
> +	if (netif_running(enic->netdev))
> +		schedule_work(&enic->reset);
> +}

[Severity: High]
Is there anything that bounds how often this re-arms enic->reset?  There
is no attempt counter, no delay and no "recovery already in progress"
check, and the only gate is netif_running(), which the new
vf_datapath_open comment documents as staying true across an internal
reset.

The reply handlers that call it run while the reset worker is itself
executing:

enic_reset()
	enic_admin_chan_reopen()
		enic_mbox_vf_capability_check()
		enic_mbox_vf_register()
			enic_mbox_vf_handle_reply()
				if (recovery != ENIC_MBOX_VF_REPLY_OK)
					enic_mbox_vf_kick_recovery(enic);

Because the PENDING bit was cleared when the worker started, that
schedule_work() queues another full reset.  If the PF keeps rejecting the
handshake, for example a REGISTER reply carrying
ENIC_MBOX_ERR_VF_NOT_REGISTERED, or a malformed reply, does this become a
self-sustaining reset loop where every iteration takes rtnl_lock() across
admin-channel teardown, rebuild, a soft reset and synchronous mailbox
transactions?

enic_admin_rx_lost() in enic_admin_rq_cq_service() adds a per-descriptor
trigger for the same path, so a burst of bad descriptors can re-arm it
repeatedly within one poll.  Would a retry budget plus a delayed requeue
be appropriate here?

> @@ -600,6 +742,8 @@ static void enic_mbox_recv_handler(struct enic *enic, void *buf,
>  			netdev_warn(enic->netdev,
>  				    "MBOX: truncated message (len %u < %zu)\n",
>  				    len, sizeof(*hdr));
> +		if (!enic->vf_state)
> +			enic_mbox_vf_require_reconnect(enic);
>  		return;
>  	}

[Severity: Medium]
Does this act on a message before the sender has been validated?  For
messages shorter than struct enic_mbox_hdr, enic_admin_rq_cq_service()
skips the hardware-attributed rewrite:

	sender_vlan = le16_to_cpu(rq_desc->vlan);
	if (bytes_written >= sizeof(struct enic_mbox_hdr)) {
		struct enic_mbox_hdr *hdr = buf->os_buf;

		hdr->src_vnic_id = (sender_vlan == 0) ?
			cpu_to_le16(ENIC_MBOX_DST_PF) :
			cpu_to_le16(sender_vlan - 1);
	}

so src_vnic_id keeps whatever the sender put there, and the message is
still enqueued.  enic_mbox_recv_handler() then calls
enic_mbox_vf_require_reconnect() ahead of the

	le16_to_cpu(hdr->src_vnic_id) == ENIC_MBOX_DST_PF

check used for all normal dispatch.  Via
enic_mbox_vf_mark_reconnect_locked() that disables mailbox sends,
quarantines RX and, through enic_mbox_vf_kick_recovery(), drops carrier
and schedules a device reset.  The new enic_admin_rx_lost() calls for
descriptor errors and backlog drops are sender-agnostic in the same way.

Should the sender check happen before any state-destroying recovery
action, so that admin traffic not attributable to the PF cannot force a
VF into quarantine and reset?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43%40cisco.com
