Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C1046DFF0;
	Thu, 24 Sep 2026 23:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290917; cv=none; b=EiZnZNvedGimuLNUEJqyCz5Wbnmn4UTZ56OpR+lY/v3V6wjc+lgRC99oiL9DuNDgFG1qposMGKOkL/vLkfTK8E4CsHoC2JkIifIc7GnpBK13O1C7svs/mxSAM7E/Oz8qPhLbz+x4mF3i2nCrlBY+0Ov3XElMhQa13Qx6VJqFaOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290917; c=relaxed/simple;
	bh=BkNGR9+hMGokcYoQ89aJItYrH9n+9ZIJ/r6CdbxMuBw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aOIIGz3VbbDVRXYusFuQQ0d7pj2YHT/biUOsdpW+gHr/YfDk8qkvBI8KZ4ncXMPOEqBOqnhRUEJX5P0dTRREQtwb0SInbQGojCbF7A4Lys87jgsyDJHEGy70/GXr7esTFm2oD8wzjoD6xQRC2dGp1SkE2duBJgetfLLdpEMWqWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIguwL5E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIguwL5E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DA41F00898;
	Thu, 24 Sep 2026 23:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790290915;
	bh=K1TR/CbDUTn6isAVawWetVJlwOdJkl09n6zZiTIDIc8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MIguwL5EONpG4ZHGPc93i7JOah5ZmIF1pwbmaXedOfRrPCPoZZuUUECBBjprxCII+
	 1KleM7zjT+Jmoyz9nOHhW/yFBe9HqaG6wV6XIuVZ79ygFHiiWxe2NRucSO1sptxe+u
	 SlTvK2sxHtQRZTR+/ZVICDThtz+RJxc4uFGU1lSXtvfxI8jr1PLOcRq8mMaaX56aN5
	 k6ODcU2ob7khoydr20JZOmJGulutvBvtjZ76VLev5OHo/F0G0+N0oOAOlWlGdjM7Vw
	 kivIMTFlHMAsztj8wrsByl4STa7KJ7m84jmtJxCCR1m9+WW7xpXnemwLK0SR2/UAqy
	 5/5NciN9rYPwA==
Subject:
 Re: [PATCH net-next 6/6] enic: configure V2 VF receive mode over mailbox
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sebaddel@cisco.com
Date: Thu, 24 Sep 2026 23:01:54 +0000
Message-ID: <179029091475.2160803.16960817666259499785@kernel.org>
In-Reply-To:
 <20260921-b4-enic-sriov-v2-vf-receive-control-v1-6-67a0a6e08d43@cisco.com>
References:
 <20260921-b4-enic-sriov-v2-vf-receive-control-v1-6-67a0a6e08d43@cisco.com>
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

Critical: 0 · High: 2 · Medium: 5 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] enic_open() now aborts with -EACCES for a V2 VF whenever the
  netdev address lists exceed the perfect-filter limits (32 per class,…
- [High] The new asynchronous VF receive-mode path excludes the VF
  station address only from the unicast class (`unicast &&…
- [Medium] An ADD reply carrying any ENIC_MAC_ADDR_FLAG_PERMANENT_MASK
  bit (OVERFLOW, NOT_PERMITTED, INVALID) makes…
- [Medium] The patch teaches two of the three internal enic_open()
  callers to schedule the asynchronous receive-mode replay, but leaves…
- [Medium] The split receive-mode update in enic_set_vf_rx_mode() does
  not satisfy netif_rx_mode_sync()'s documented guarantee that the…
- [Medium] In enic_set_vf_rx_mode(), the vf_pkt_filter_update_pending
  branch performs only the packet-filter mailbox transaction and then…
- [Medium] A failed mixed broad-mode transition can leave promiscuous
  reception enabled indefinitely after the requested configuration…
- [Low] The broad-enable comment in enic_set_vf_rx_mode() claims 'Retain
  any broad mode that is currently applied until its finite replacement…

--

enic: configure V2 VF receive mode over mailbox

This adds an asynchronous ndo_set_rx_mode_async callback for V2 VFs which
pushes individual unicast/multicast address changes and packet-filter
settings through the VF mailbox, keeping each callback to one mailbox
request. A separate netdev_ops table is selected for V2 VFs and the device
is detached before mailbox teardown in enic_remove().

A few questions about the new receive-mode paths below.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 16412c29e9321..1cc1935ee5c2c 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c

[ ... ]

> @@ -1603,17 +1610,412 @@ static int enic_set_mac_address(struct net_device *netdev, void *p)

[ ... ]

> +static unsigned int
> +enic_vf_addr_list_count(const struct enic *enic,
> +			const struct netdev_hw_addr_list *list,
> +			bool unicast)
> +{
> +	const struct netdev_hw_addr *ha;
> +	unsigned int count = 0;
> +
> +	netdev_hw_addr_list_for_each(ha, list)
> +		if (ha->refcount > ha->sync_cnt &&
> +		    !(unicast && enic->vf_station_addr_valid &&
> +		      ether_addr_equal(ha->addr, enic->vf_station_addr)))
> +			count++;
> +
> +	return count;
> +}
> +
> +static int enic_vf_collect_mac_ops(struct enic *enic,
> +				   struct netdev_hw_addr_list *list,
> +				   bool unicast,
> +				   bool install_new,
> +				   unsigned int *filter_count,
> +				   struct enic_mac_addr *macs,
> +				   struct enic_vf_mac_op *ops,
> +				   u16 *num_ops)
> +{
> +	struct netdev_hw_addr *ha;
> +	u16 pos = *num_ops;
> +
> +	/* Deletes precede adds so a full perfect-filter table has room for a
> +	 * replacement address in the same transaction.
> +	 */
> +	netdev_hw_addr_list_for_each(ha, list) {
> +		if (unicast && enic->vf_station_addr_valid &&
> +		    ether_addr_equal(ha->addr, enic->vf_station_addr))
> +			continue;

[Severity: High]
Can the station address be deleted from the PF through the multicast
class?  The station-address skip in both loops of
enic_vf_collect_mac_ops(), and in enic_vf_addr_list_count(), is gated on
the unicast argument, and enic_vf_sync_mac_filters() passes false for the
mc list:

	err = enic_vf_collect_mac_ops(enic, mc, false, install_mc,
				      &enic->mc_count,
				      macs, ops, &num_ops);

__dev_mc_add() / __hw_addr_add_ex() do not validate the multicast bit, so
"ip maddr add <own MAC> dev ethX" from inside the guest puts the station
address into netdev->mc.  That entry is then emitted as an ordinary ADD
(a DUPLICATE reply is accepted as a successful add by
enic_mbox_vf_mac_reply_matches(), and is in neither
ENIC_MAC_ADDR_FLAG_SKIPPED nor ENIC_MAC_ADDR_FLAG_PERMANENT_MASK), and a
later "ip maddr del" makes it stale and emits a DELETE for the same
address.

Since the PF keys its MAC ledger by address, as noted by the comment in
enic_vf_station_sync_reset():

	/* The PF keys its MAC ledger by address. A station entry is also the
	 * receive filter for that address and must not retain a second core
	 * synchronization reference which could later delete the station.
	 */

does that DELETE remove the station filter while the driver still
believes it is installed?  vf_station_addr_valid stays true, the unicast
walk keeps skipping the address, and the successful reply means reconnect
is never requested.  enic_vf_station_sync_reset() only calls
__dev_uc_unsync(), so it cannot drop or repair a multicast-side
reference.

The commit message says "Keep the station address out of the
secondary-unicast list" - should the same exclusion apply to the
multicast class, or is the multicast path expected to be unreachable for
a station-equal address?

Note the PF/firmware side is not in this tree.  If the PF instead answers
NOT_PERMITTED for that ADD, the request lands in the silent -EACCES path
discussed below.

[ ... ]

> +static int enic_vf_sync_mac_filters(struct enic *enic,
> +				    struct netdev_hw_addr_list *uc,
> +				    struct netdev_hw_addr_list *mc,
> +				    bool install_uc, bool install_mc,
> +				    bool *sent)
> +{

[ ... ]

> +	for (i = 0; i < num_ops; i++) {
> +		u16 flags = le16_to_cpu(macs[i].flags);
> +		bool add = flags & ENIC_MAC_ADDR_FLAG_ADD;
> +
> +		if (flags & ENIC_MAC_ADDR_FLAG_SKIPPED) {
> +			if (add)
> +				retryable_add = true;
> +			else
> +				reconnect = true;
> +			continue;
> +		}
> +		if (flags & ENIC_MAC_ADDR_FLAG_PERMANENT_MASK) {
> +			if (add)
> +				permanent_add = true;
> +			else
> +				reconnect = true;
> +			continue;
> +		}

[Severity: Medium]
Is ENIC_MAC_ADDR_FLAG_OVERFLOW really a stable policy result?  In
enic_mbox.h it is grouped with the genuine refusals:

	#define ENIC_MAC_ADDR_FLAG_PERMANENT_MASK \
		(ENIC_MAC_ADDR_FLAG_OVERFLOW | ENIC_MAC_ADDR_FLAG_NOT_PERMITTED | \
		 ENIC_MAC_ADDR_FLAG_INVALID)

OVERFLOW looks like a capacity result (PF filter table full) rather than a
trust decision.  Escalation to a broad mode is driven only by the
compile-time ENIC_UNICAST_PERFECT_FILTERS /
ENIC_MULTICAST_PERFECT_FILTERS constants applied to the netdev list
counts, never by the PF-reported result.  When the PF's real per-VF quota
is smaller than 32, does the driver end up neither installing the exact
filter nor requesting broad coverage?

There is also no log here identifying the rejected address, and
enic_set_vf_rx_mode() turns this -EACCES into a 0 return to the core, so
netif_rx_mode_run() resets dev->rx_mode_retry_count and never revisits
the address.  The ha keeps sync_cnt == 0 in the reconciled live list while
enic->uc_count / mc_count still claim table room.  Would a netdev_warn
naming the address be appropriate?

[ ... ]

> +static int enic_set_vf_rx_mode(struct net_device *netdev,
> +			       struct netdev_hw_addr_list *uc,
> +			       struct netdev_hw_addr_list *mc)
> +{

[ ... ]

> +	if (broad_enable_needed) {
> +		/* Establish newly required broad coverage before an independent
> +		 * exact-address rejection can block it. Retain any broad mode that
> +		 * is currently applied until its finite replacement is installed.
> +		 */

[Severity: Low]
This isn't a bug, but does the comment match what the code does?  It says
the currently applied broad mode is retained "until its finite
replacement is installed", while the broad_withdrawal branch below states
and implements the opposite ordering:

	/* Withdraw stale broad acceptance before installing its finite
	 * replacement.  Keep this callback to one mailbox transaction and
	 * queue exact-filter reconciliation as fresh work. ...

For a transition that both enables one broad mode and withdraws another
(applied = PROMISCUOUS, new flags = ALL_MULTICAST), the first callback
requests the union and the next callback withdraws PROMISCUOUS before any
finite replacement is installed.  Could the comment be reworded to match?

> +		prefilter_flags = flags;
> +		if (enic->vf_pkt_filter_valid)
> +			prefilter_flags |= enic->vf_pkt_filter_applied & broad_modes;
> +		err = enic_vf_set_pkt_filter(enic, prefilter_flags,
> +					     &applied_flags);
> +		if (err)
> +			return err;

[Severity: Medium]
Can promiscuous reception stay enabled indefinitely after userspace
disabled it, when this branch fails?

With applied = CMD_PFILTER_PROMISCUOUS and new flags =
CMD_PFILTER_ALL_MULTICAST without PROMISCUOUS, both predicates are true:

	broad_enable_needed = (flags & broad_modes & ~enic->vf_pkt_filter_requested);
	broad_withdrawal = (enic->vf_pkt_filter_applied & broad_modes & ~flags);

broad_enable_needed wins, and this error return omits the fail-closed
handling the withdrawal branch performs:

		if (!READ_ONCE(enic->mbox_tx_poisoned) &&
		    !READ_ONCE(enic->vf_mbox_reconnect_required))
			enic_mbox_vf_require_reconnect(enic);

enic_mbox_vf_set_pkt_filter() only calls
enic_mbox_vf_require_reconnect() for reply-wait failures; a send-side
failure goes through enic_mbox_vf_request_abort() and returns err, for
example from enic_mbox_send_msg_id():

	if (vnic_wq_desc_avail(wq) == 0) {
		err = -ENOSPC;
		goto unlock;
	}

	buf = kmalloc(total_len, GFP_KERNEL);
	if (!buf) {
		err = -ENOMEM;
		goto unlock;
	}

Since vf_pkt_filter_requested is unchanged on failure, every core retry
re-enters this same branch and never reaches the protected withdrawal
path, and netif_rx_mode_schedule_retry() gives up after
NETIF_RX_MODE_RETRY_MAX attempts with "rx_mode retry limit reached,
giving up".  Should this error path also request fresh registration?

> +		enic->vf_pkt_filter_update_pending = false;
> +		enic_vf_report_pkt_filter_denial(netdev, flags, applied_flags);
> +		netif_rx_mode_schedule_fresh(netdev);
> +		return 0;
> +	}
> +
> +	/* A permanent exact-address rejection can leave an independent packet
> +	 * filter update pending. Give that update the next mailbox transaction,
> +	 * unless it would withdraw broad coverage before finite replacements are
> +	 * installed. A later receive-mode change can retry the rejected address.
> +	 */
> +	if (enic->vf_pkt_filter_update_pending) {
> +		if (!filter_needed || broad_withdrawal) {
> +			enic->vf_pkt_filter_update_pending = false;
> +		} else {
> +			err = enic_vf_set_pkt_filter(enic, flags, &applied_flags);
> +			if (err)
> +				return err;
> +			enic->vf_pkt_filter_update_pending = false;
> +			enic_vf_report_pkt_filter_denial(netdev, flags, applied_flags);
> +			return 0;
> +		}
> +	}

[Severity: Medium]
Does this else-branch discard the address work in the snapshot it was
given?  It performs only the packet-filter transaction and returns 0
without touching uc/mc and without calling
netif_rx_mode_schedule_fresh().  Every other early "return 0" in this
function that leaves address work undone re-arms the callback.

The core treats 0 as fully installed, in netif_rx_mode_run():

	if (err)
		netif_rx_mode_schedule_retry(dev);
	else
		dev->rx_mode_retry_count = 0;

So an add (sync_cnt == 0) or a stale delete (refcount == sync_cnt) in
that snapshot is never programmed until some unrelated later rx-mode
change happens to re-queue the work.  One sequence:

run N:   permanent per-address denial -> -EACCES
         -> vf_pkt_filter_update_pending = true, schedule fresh
userspace: dev_uc_add() -> __dev_set_rx_mode() -> netif_rx_mode_queue()
         (ORs into the already pending NETDEV_WORK_RX_MODE bit)
run N+1: snapshots the new address, takes this pending branch,
         sends SET_PKT_FILTER, returns 0

A second variant: netif_rx_mode_run() returns early while
!(dev->flags & IFF_UP), and __enic_stop() does not clear
vf_pkt_filter_update_pending, so the first run after a down/up cycle
spends its one transaction on the packet filter and drops the
accumulated add/delete work.  Should this branch also schedule fresh
work?

> +
> +	if (broad_withdrawal) {
> +		/* Withdraw stale broad acceptance before installing its finite
> +		 * replacement.  Keep this callback to one mailbox transaction and
> +		 * queue exact-filter reconciliation as fresh work.  If that later
> +		 * reconciliation exhausts its retry budget, traffic may be dropped
> +		 * but PROMISC/ALLMULTI cannot remain enabled beyond the requested
> +		 * policy.
> +		 */
> +		err = enic_vf_set_pkt_filter(enic, flags, &applied_flags);

[Severity: Medium]
Do the split updates still satisfy the synchronous guarantee that
netif_rx_mode_sync() provides to its callers?  It performs exactly one
receive-mode invocation:

net/core/dev_addr_lists.c:netif_rx_mode_sync() {
	if (__netdev_work_core_cancel(dev, NETDEV_WORK_RX_MODE))
		netif_rx_mode_run(dev);
}

and callers such as the SIOCADDMULTI/SIOCDELMULTI handling in
net/core/dev_ioctl.c rely on that:

	err = dev_mc_del_global(dev, ifr->ifr_hwaddr.sa_data);
	netif_rx_mode_sync(dev);

For an up, registered V2 VF whose multicast list shrinks from more than
32 to 32 or fewer while ALL_MULTICAST is applied, this branch disables
ALL_MULTICAST, queues the individual addresses via
netif_rx_mode_schedule_fresh(), and returns 0 - so the ioctl returns with
ALLMULTI off and the individual groups not yet installed.  The
broad_enable_needed branch and the "sent && filter_needed" path behave
the same way.  The requeued run has to retake the ops-compat lock and can
block in enic_mbox_wait_reply(enic, 3000), so the window is not tiny.  Is
a half-applied configuration at syscall return intended here?

[ ... ]

> +	err = enic_vf_sync_mac_filters(enic, uc, mc, !uc_overflow,
> +				       !mc_overflow, &sent);
> +	if (err == -EACCES) {
> +		/* Do not spend the core retry budget repeating an exact operation
> +		 * that the PF rejected permanently.  If the independent packet
> +		 * policy still needs an update, queue one fresh callback for it.
> +		 */
> +		if (filter_needed) {
> +			enic->vf_pkt_filter_update_pending = true;
> +			netif_rx_mode_schedule_fresh(netdev);
> +		}
> +		return 0;
> +	}

[ ... ]

> @@ -2319,9 +2724,36 @@ static int enic_open(struct net_device *netdev)
>  		enic_vf_station_addr_set(enic, netdev->dev_addr);
>  		enic_vf_station_sync_reset(enic);
>  		vf_mac_added = true;
> +
> +		netif_addr_lock_bh(netdev);
> +		vf_uc_count = enic_vf_addr_list_count(enic, &netdev->uc, true);
> +		vf_mc_count = enic_vf_addr_list_count(enic, &netdev->mc, false);
> +		netif_addr_unlock_bh(netdev);
> +
> +		vf_filter_flags = enic_rx_mode_to_pkt_filter(netdev,
> +							     vf_uc_count,
> +							     vf_mc_count);
> +		err = enic_vf_set_pkt_filter(enic, vf_filter_flags,
> +					     &vf_filter_applied);
> +		if (err) {
> +			netdev_err(netdev,
> +				   "Failed to configure VF packet filter: %d\n",
> +				   err);
> +			goto err_out_disable_wq;
> +		}
> +		if ((vf_uc_count > ENIC_UNICAST_PERFECT_FILTERS &&
> +		     !(vf_filter_applied & CMD_PFILTER_PROMISCUOUS)) ||
> +		    (vf_mc_count > ENIC_MULTICAST_PERFECT_FILTERS &&
> +		     !(vf_filter_applied & CMD_PFILTER_ALL_MULTICAST))) {
> +			netdev_err(netdev,
> +				   "PF denied receive mode required by VF address lists\n");
> +			err = -EACCES;
> +			goto err_out_disable_wq;
> +		}
>  	}

[Severity: High]
Should ndo_open now fail when the PF declines a broad receive mode?

enic_set_vf_rx_mode() tolerates exactly this state at runtime - it calls
enic_vf_report_pkt_filter_denial(), which only emits netdev_dbg (compiled
out in default builds), and returns 0.  Here the same state aborts the
open with -EACCES.  Are the two policies meant to differ?

A reachable sequence with more than 32 multicast groups configured in the
guest (routine with several IPv6 addresses, mDNS/IGMP users, or a bridge
or macvlan on top):

enic_reset_addr_lists()
    __dev_mc_unsync(netdev, NULL)   /* drops only the driver's sync ref */

every still-requested address keeps refcount >= 1 with sync_cnt == 0, so
enic_vf_addr_list_count() counts it, enic_rx_mode_to_pkt_filter() sets
CMD_PFILTER_ALL_MULTICAST, and a non-trusted VF is denied that mode - the
protocol explicitly allows withholding the two broad modes, per the
required computation in enic_mbox_vf_set_pkt_filter().  The check above
then returns -EACCES and rolls the open back.

The commit message does not mention that ndo_open can now be rejected by
PF receive-mode policy.  Could that be spelled out?

> -	enic_set_rx_mode(netdev);
> +	if (!enic_is_sriov_vf_v2(enic))
> +		enic_set_rx_mode(netdev);
>  
>  	netif_tx_wake_all_queues(netdev);
>  
> @@ -2956,6 +3388,13 @@ static void enic_reset(struct work_struct *work)
>  	if (err)
>  		netdev_err(enic->netdev,
>  			   "Failed to reopen datapath after reset: %d\n", err);

[Severity: High]
Continuing the above: in enic_reset() and enic_tx_hang_reset() the
enic_open() failure is only logged and control falls through to
reset_out, so the new -EACCES leaves vf_datapath_open false while IFF_UP
is still set and no further retry is queued.  Does the interface stay
down permanently in that case, given that a manual down/up also fails
while the address lists and PF policy are unchanged?

> +	else if (enic_is_sriov_vf_v2(enic)) {
> +		/* Internal reset bypasses __dev_open(), which normally schedules the
> +		 * asynchronous receive-mode upload after ndo_open. Schedule the same
> +		 * core replay for lists cleared by enic_reset_addr_lists().
> +		 */
> +		netif_rx_mode_schedule_fresh(enic->netdev);
> +	}

[Severity: Medium]
Is the third internal enic_open() caller missing this same replay?
_enic_change_mtu(), reached from enic_change_mtu_work, reopens the
datapath outside __dev_open():

	if (running) {
		err = enic_open(netdev);
		if (err)
			return err;
	}

with no netif_rx_mode_schedule_fresh(), and it bypasses the
dev_set_rx_mode() call that __dev_open() performs.  enic_mtu_check()
schedules that work for SR-IOV VFs, and enic_is_sriov_vf() matches
PCI_DEVICE_ID_CISCO_VIC_ENET_VF_V2:

	if (enic_is_dynamic(enic) || enic_is_sriov_vf(enic)) {
		...
		if (mtu != netdev->mtu)
			schedule_work(&enic->change_mtu_work);

When that reopen takes enic_open()'s re-registration branch
(!admin_chan_up || !vf_registered || vf_mbox_reconnect_required), the
comment there states the contract this path would break:

	/* Re-registration makes the PF discard the old VF-requested
	 * filters.  Clear the netdev-core synchronization state so the
	 * receive-mode callback replays the current address lists.
	 */
	enic_reset_addr_lists(enic);

One concrete case with no other replay source: a previous enic_reset()
whose reopen failed leaves vf_datapath_open false and reconnect state set
with no further reset queued, then a firmware MTU notification drives
_enic_change_mtu(), whose enic_open() re-registers, calls
enic_reset_addr_lists(), and returns 0 with nothing scheduling the
replay.  Do secondary unicast and multicast filters then stay uninstalled
while the reopen reports success?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-b4-enic-sriov-v2-vf-receive-control-v1-0-67a0a6e08d43%40cisco.com
