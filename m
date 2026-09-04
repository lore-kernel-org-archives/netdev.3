Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7B63F12E3;
	Fri,  4 Sep 2026 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517139; cv=none; b=MmMSYMFJnDQLi9LqNcltG8B1t9udnSRZfvwhnOX3qTZ6bUBYtOOGvGtDhxyNQ3+IcVmKmxMSMHTYqa1uYjwd4SV6ln3fMmgdqFBYWnTRCKnDIpwjdZgo5L2ZSNuNXeQcWM5MmbN35QrGr/ADXl16l5+tpaQWO9CdzmC4RlvKbn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517139; c=relaxed/simple;
	bh=N70d4OTM4MbzPzRrc3jCGl3C7gCaldrIYREq5tRQNgE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ARI8dSgecuXgWpb8i3/CKUQUQcFgQhavxZUulUZl83Nd+nKOkasbk6f6IM1KWcmEwRXqQ2Izvfv8kQrctQDFv0womcHnv1elcJw7OBrDhtOd52zN2dH6jx4kJXFmFHzE6bzYgqgzn35d1aahJzQxppdwa3J50f249YqOapSnHhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq171NIO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq171NIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42771F00A3E;
	Fri,  4 Sep 2026 10:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517134;
	bh=DRVdbCXXZKSxF9egZrKuVdyCyDlkeGtPVnc0hMTAlAg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Mq171NIO6+sMOsjfgT1J4mGRk2dQf6z5Wyhmqrmnom3+ioe7Dp5q6TSov/oc7pCYl
	 Y9VpAjseKu7MSqcB3J1arRwTO3zNN8KBXdBiz6i5ffNjoW7/3pNrFrfCLtWVoj0rbn
	 6g/qhnzWEZVJJezZlqTPtD5WyFxy6iP6KQwP5f2j145/oUociyb44ZNXiHmK/6XRFK
	 SeUasO1p2pxsbhOZEl9QTCsOtdICP6g1Ygzd4u8zom37KDHaypUvTmw5k7ob/i0ei8
	 yDsyTMwkFfDCfi+BH6MLW2M/c/Z6WAvk08s+ErC1axsWlTBHUv5o0IjjmE9TrIhm+d
	 BPBgmWfgO2ZKQ==
Subject: Re: [PATCH net-next 7/7] bnge: Process async events while
 administratively down
From: netdev-bot+sashiko@kernel.org
To: bhargava.marreddy@broadcom.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
 rajashekar.hudumula@broadcom.com, dharmender.garg@broadcom.com
Date: Fri, 04 Sep 2026 10:18:53 +0000
Message-ID: <178851713320.4131868.3669657834636275060@kernel.org>
In-Reply-To: <20260901191728.643212-8-bhargava.marreddy@broadcom.com>
References: <20260901191728.643212-8-bhargava.marreddy@broadcom.com>
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
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 3 (1) · Low: 0

- [High] bnge_sp_task(): replacing the early return with `goto async_evt`
  lets the entire link/PHY event block execute while BNGE_STATE_OPEN is…
- [High] Processing PHY events while administratively down inadvertently
  turns the hardware link back on.
- [Medium] The new `if (!netif_running(bd->netdev)) return;` in
  bnge_report_link() (bnge_link.c:405) silently drops a report that its…
- [Medium] bnge_close() ends with the plain, non-atomic store
  `bn->sp_event = 0;` (bnge_netdev.c:3307) while NQ0's NAPI and IRQ are…
- [Medium] A speed/PHY-configuration async event processed while the
  interface is closed silently overwrites the link and pause settings…

Pre-existing issues:
- [Medium] bnge_free_nq0() (bnge_netdev.c:3523-3583) sends HWRM_RING_FREE
  for NQ0 and invalidates ring->fw_ring_id before it disables the NAPI…

--

bnge: Process async events while administratively down

bnge_sp_task() now jumps over the periodic-stats block with a goto instead
of returning early when BNGE_STATE_OPEN is clear, so async link/PHY events
are handled while the interface is down.  bnge_report_link() gains an early
return when the netdev is not running.

A few questions about the new behaviour below.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
> index 3b0dfcf273762..31e2ede2e537a 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_link.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
> @@ -402,6 +402,9 @@ static char *bnge_report_fec(struct bnge_link_info *link_info)
>  
>  void bnge_report_link(struct bnge_dev *bd)
>  {
> +	if (!netif_running(bd->netdev))
> +		return;
> +

[Severity: Medium]
Can this early return make a link transition disappear entirely instead of
just deferring the message?

The only caller is edge-triggered.  bnge_update_link() commits the new
state and reports only when it changed:

	if (chng_link_state) {
		if (link_info->phy_link_status == BNGE_LINK_LINK)
			link_info->link_state = BNGE_LINK_STATE_UP;
		else
			link_info->link_state = BNGE_LINK_STATE_DOWN;
		if (link_state != link_info->link_state)
			bnge_report_link(bd);

bnge_hwrm_shutdown_link() relies on that, leaving a sentinel behind on
close:

	if (!rc) {
		/* Device is not obliged to link down in certain scenarios,
		 * even when forced. Setting the state unknown is consistent
		 * with driver startup and will force link state to be
		 * reported during subsequent open based on PORT_PHY_QCFG.
		 */
		bd->link_info.link_state = BNGE_LINK_STATE_UNKNOWN;
	}

With this patch, an async link event handled while down calls
bnge_update_link(bn, true), which replaces BNGE_LINK_STATE_UNKNOWN with
UP/DOWN and consumes the transition, while bnge_report_link() returns
immediately.  At the next open, bnge_open_core() ->
bnge_update_phy_setting() -> bnge_update_link() reads the same value, sees
no change, and never calls bnge_report_link().

Does that permanently lose the "NIC Link is Up, N Mbps ..." / "NIC Link is
Down" message and the FEC line for that transition, so whether link state
gets reported at all depends on whether an async event happened to arrive
while the port was down?  Carrier itself still gets fixed up by
bnge_tx_enable() via "if (BNGE_LINK_IS_UP(bn->bd)) netif_carrier_on()",
which means carrier and the log output are now driven by two different
paths.

>  	if (BNGE_LINK_IS_UP(bd)) {
>  		const char *signal = "";
>  		const char *flow_ctrl;
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index d11c404acd4e2..49e27cbc63946 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> @@ -394,10 +394,8 @@ static void bnge_sp_task(struct work_struct *work)
>  	struct bnge_dev *bd = bn->bd;
>  
>  	netdev_lock(bn->netdev);
> -	if (!test_bit(BNGE_STATE_OPEN, &bd->state)) {
> -		netdev_unlock(bn->netdev);
> -		return;
> -	}
> +	if (!test_bit(BNGE_STATE_OPEN, &bd->state))
> +		goto async_evt;

[Severity: High]
Is the block below the async_evt label read-only with respect to the PHY?

For a speed-change event, bnge_sp_task() first calls
bnge_hwrm_phy_qcaps(bd), which refreshes the supported-speed mask:

	if (resp->supported_speeds2_auto_mode)
		link_info->support_auto_speeds2 =
			le16_to_cpu(resp->supported_speeds2_auto_mode);

and then calls bnge_update_link(bn, true), whose tail is:

	support_changed = bnge_support_speed_dropped(bn);
	if (support_changed && (bn->eth_link_info.autoneg & BNGE_AUTONEG_SPEED))
		rc = bnge_hwrm_set_link_setting(bn, true);

bnge_support_speed_dropped() returns true whenever the advertised mask
contains speeds that are no longer in support_auto_speeds2, which is what
happens when a transceiver is swapped for one supporting fewer speeds while
the port is administratively down.

bnge_hwrm_set_link_setting() -> bnge_hwrm_set_link_common() then builds an
HWRM_PORT_PHY_CFG with:

		req->flags |= cpu_to_le32(BNGE_PHY_FLAGS_RESTART_AUTO);
	...
	/* tell FW that the setting takes effect immediately */
	req->flags |= cpu_to_le32(PORT_PHY_CFG_REQ_FLAGS_RESET_PHY);

Does this undo the PORT_PHY_CFG_REQ_FLAGS_FORCE_LINK_DWN that bnge_close()
issued through bnge_hwrm_shutdown_link()?  Nothing re-asserts the force-down
afterwards, and since bnge_report_link() now returns early while not
running, the carrier stays off, so the link partner would see an active link
on a closed interface.

BNGE_PHY_CFG_ABLE(bd) is link_info.phy_enabled, a firmware capability set in
bnge_hwrm_phy_qcaps() and not cleared on close, so it does not block this.
Every other PHY-programming path is gated on netif_running() -
bnge_set_link_ksettings() and bnge_set_pauseparam() both do
"if (netif_running(dev))" before touching hardware.  Would it be better to
narrow the BNGE_STATE_OPEN gate to the read-only link-info refresh rather
than remove it for the whole block?

[Severity: Medium]
Related question about the same fall-through: further down, sp_task ends
with

	if (speed_chng || cfg_chng)
		bnge_init_ethtool_link_settings(bn);

bnge_init_ethtool_link_settings() rewrites elink_info->autoneg,
->advertising, ->req_duplex and ->req_flow_ctrl from the current hardware
auto_mode / duplex_setting / pause settings.

While the interface is down, bn->eth_link_info is the pending userspace
request: bnge_set_link_ksettings() and bnge_set_pauseparam() store into it
and only program hardware "if (netif_running(dev))", and
bnge_update_phy_setting() applies it at the next open.

If an async speed/config event arrives after "ethtool -s" or "ethtool -A"
was issued on a down interface, does this overwrite the queued request with
the hardware-derived values, so the next open sees nothing to change and the
user's setting is silently dropped?

[Severity: Medium]
One more on whether the events the fall-through wants actually survive
close.  bnge_close() ends with a plain store:

	bnge_close_core(bn);
	bnge_hwrm_shutdown_link(bn->bd);
	bnge_hwrm_if_change(bn->bd, false);
	bn->sp_event = 0;

At that point NQ0 is live again: bnge_close_core() -> bnge_free_core() ends
with bnge_resume_nq0(), which re-enables NQ0 NAPI and re-arms the doorbell,
and bnge_free_irq() skips the NQ0 vector.  bnge_hwrm_shutdown_link() forces
the port down, which itself generates a LINK_STATUS_CHANGE async event, and
the NAPI side records it with atomic bitops:

static void bnge_queue_sp_work(struct bnge_net *bn, unsigned int event)
{
	set_bit(event, &bn->sp_event);
	__bnge_queue_sp_work(bn);
}

Two questions here.  Is the plain word store racing with set_bit() from
softirq context on the same word, and can it clobber a bit set
concurrently?

And since bnge is ops-locked and bnge_sp_task() takes netdev_lock, the
queued worker cannot run until bnge_close() returns, i.e. after the wipe.
Does that mean the event the new async_evt path is meant to handle is
discarded before it can be observed, with nothing re-polling while down
because the periodic timer is stopped?  Would clearing only the bits that
are meaningless while down, using atomic bitops, be more consistent with
the goal of this patch?

>  
>  	if (test_and_clear_bit(BNGE_PERIODIC_STATS_SP_EVENT, &bn->sp_event)) {
>  		bnge_hwrm_port_qstats(bd, 0);
> @@ -405,6 +403,7 @@ static void bnge_sp_task(struct work_struct *work)
>  		bnge_accumulate_all_stats(bd);
>  	}
>  
> +async_evt:
>  	if (test_and_clear_bit(BNGE_UPDATE_PHY_SP_EVENT, &bn->sp_event)) {
>  		int rc;
>  

[Severity: High]
The first block that the new label falls into is the PHY retry, and
that one does not just read state - it programs the PHY.
bnge_sp_task() calls bnge_update_phy_setting(bn), whose tail is:

	if (!BNGE_LINK_IS_UP(bd))
		update_link = true;

	if (update_link)
		rc = bnge_hwrm_set_link_setting(bn, update_pause);

So the "link is currently down" case is precisely the case that sends
an HWRM_PORT_PHY_CFG to bring the link back up.  Running that while
BNGE_STATE_OPEN is clear looks like it undoes the
PORT_PHY_CFG_REQ_FLAGS_FORCE_LINK_DWN that bnge_close() issued via
bnge_hwrm_shutdown_link(), and nothing on this path re-asserts it
afterwards.  Combined with the other half of this patch -
bnge_report_link() returning early when !netif_running() - the carrier
stays off while the port is actually being brought up, so the link
partner sees an active link on an administratively down interface and
the driver logs nothing about it.

How does the submitter expect BNGE_UPDATE_PHY_SP_EVENT to be reachable
while down?  bd->link_info.phy_retry is only cleared on success here,
and BNGE_PHY_CFG_ABLE(bd)/link_info.phy_enabled is a firmware
capability that close does not clear, so a retry queued before the
state bit went away (for example a partially failed open, or a reset
that clears BNGE_STATE_OPEN without wiping bn->sp_event) would be
serviced here.  If that is possible at all, this block needs to stay
gated: every other PHY-programming path in the driver checks
netif_running() first (bnge_set_link_ksettings(),
bnge_set_pauseparam()).  Would it be cleaner to keep the
BNGE_STATE_OPEN check for the PHY retry and only let the read-only
link-info refresh run while down?

[Severity: Medium]
This isn't a bug introduced by this patch, but while looking at the NQ0
persistence machinery this patch builds on: in bnge_free_nq0(), the
firmware ring is freed before the poller is disabled.

	bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
	synchronize_irq(irq->vector);

	hwrm_ring_free_send_msg(bn, ring,
				RING_FREE_REQ_RING_TYPE_NQ,
				INVALID_HW_RING_ID);
	ring->fw_ring_id = INVALID_HW_RING_ID;

and only later, inside the irq->requested block:

		free_irq(irq->vector, bnapi);
		irq->requested = 0;

		netdev_lock(bn->netdev);
		napi_disable_locked(&bnapi->napi);

synchronize_irq() waits for an in-flight handler but not for a NAPI
instance that handler already scheduled, so can bnge_napi_poll() still
write BNGE_DB_NQ()/BNGE_DB_NQ_ARM() using the doorbell key of a ring
firmware has already released?  The ring memory itself is freed after
napi_disable_locked() and synchronize_net(), so this looks limited to
doorbell writes against a freed firmware ring id on the removal and probe
error paths.  Would disabling and draining NAPI before sending
HWRM_RING_FREE be the right ordering?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901191728.643212-1-bhargava.marreddy%40broadcom.com
