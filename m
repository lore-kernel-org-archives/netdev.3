Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494B496917;
	Sat,  3 Oct 2026 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791057061; cv=none; b=oslLX6G1NpJVd+VhgPslND1BBg8gBj7yCdOtJ9zTZ6PTRJ5lBogdDr+J7TitGxwnwD0h9DIauUx7A8Sj8uCXHho0So9hkC0+IfsVGJuBKp/6KOosBo5z3kLLoZ2QgGbJkxnyWIIz5YPzFNTpLjeWn0tGRVoleoZuBqZRwSM0Qmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791057061; c=relaxed/simple;
	bh=TDxrqVro0M7jCHrK6kg9vD8bKbfswrrpR6+pTo2uGpg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f4gK18M9AQrU/RiocTbkV32srj9CJfd2J2RWsbNPJTp5r23gIFJgal5VbbjtdENjnGbjGFYNHgldKH61eMq8LZ4iW0wABVvWwhosOShIOPxEvH/jG/xEzH4wWSwKETQjdkzRHqhZRePjYK7UZxzyWPiUGhCd/HLUW56e8Cl2ZxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aspq8pRA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aspq8pRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF6B1F0089B;
	Sat,  3 Oct 2026 19:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791057059;
	bh=zw7reVeo8t5Nhp9L4+IOqRGwkYZNaqNz4J9ptNFRxpQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Aspq8pRAOIrmZXBWWCvfNdxgm1mCNQqsT+rMoHwjl20XMWLNoKfutPGJcDF1TPS72
	 dtG4JmGSvU0Vrdoh6q80HW3PfxXcUGbJ8eymGylGMwNUfwJX3TIukI+CSB8QbU8lId
	 5/3ToTHbSCNWqiz8jFvaTmcqx5s7AQxkKhVFDLnO6OoTw2j4G8CGWencQxQ2/SX8cB
	 J2/tGLTEOSL4voUheDN/vJFQRrJad9iBXmtXswZ+HYVvNIeKzaIG6IHN3JEVGNlT1R
	 zgXiL1Aah52CIOxoPfOCCU0jZzdE4a/9SvW13qm4JBEw1DaQwevQL/NYqnSI+7l41S
	 MWKNqqlSZIt9Q==
Subject:
 Re: [PATCH net-next v2 6/6] enic: configure V2 VF receive mode over mailbox
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sebaddel@cisco.com
Date: Sat, 03 Oct 2026 19:50:58 +0000
Message-ID: <179105705830.434549.15753082776541886216@kernel.org>
In-Reply-To:
 <20260929-b4-enic-sriov-v2-vf-receive-control-v2-6-5962c10061b2@cisco.com>
References:
 <20260929-b4-enic-sriov-v2-vf-receive-control-v2-6-5962c10061b2@cisco.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] enic_open() and enic_set_vf_rx_mode() handle the same PF refusal
  of a needed broad receive mode in opposite ways.
- [Medium] For V2 VFs the patch stops syncing receive mode inside
  enic_open(): enic_set_rx_mode() is now called only `if…
- [Medium] If the whole ADD_DEL_MAC request is rejected, the batch's
  DELETEs are left unrecovered.
- [Medium] enic_vf_sync_mac_filters() misreads a transactional MAC-batch
  result.
- [Medium] In enic_set_vf_rx_mode(), broad_enable_needed is computed from
  what was previously requested, not from what was applied: `(flags &…
- [Low] The comment in the broad_enable_needed branch of
  enic_set_vf_rx_mode() says the code will 'Retain any broad mode that…
- [Low] enic_set_vf_rx_mode() runs from the global netdev_work item under
  rtnl_lock(): enic has no ops lock, so netdev_lock_ops_compat() takes…

--

enic: configure V2 VF receive mode over mailbox

This patch adds an ndo_set_rx_mode_async callback for V2 VFs. The callback
sends unicast/multicast exact-filter changes and packet-filter settings to
the PF over the mailbox. For V2 VFs, enic_open() now programs only the
packet filter and relies on the core async receive-mode path (scheduled
explicitly after internal resets) to replay the address lists.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 2132bfa9c8d38..382bac6669bf3 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c

[ ... ]

> +static int enic_vf_sync_mac_filters(struct enic *enic,
> +				    struct netdev_hw_addr_list *uc,
> +				    struct netdev_hw_addr_list *mc,
> +				    bool install_uc, bool install_mc)
> +{

[ ... ]

> +	/* The protocol carries all changed unicast and multicast addresses in
> +	 * one request.  Besides matching the native ABI, this bounds time spent
> +	 * in the RTNL-held asynchronous receive-mode callback to one MAC reply.
> +	 */

[Severity: Low]
This isn't a bug, but does this comment describe the whole callback? The
ADD_DEL_MAC part is bounded to one reply. Before calling this,
enic_set_vf_rx_mode() can also send the broad_enable_needed SET_PKT_FILTER
and the broad_withdrawal SET_PKT_FILTER. Each of those waits up to 3000 ms
in enic_mbox_wait_reply().

The callback runs from netdev_work_proc() with RTNL held through
netdev_lock_ops_compat(). So one callback can hold RTNL across up to three
mailbox round trips.

Also, while PROMISC or ALLMULTI is requested, filter_needed is always true.
Every receive-mode run then sends a SET_PKT_FILTER under RTNL.

A timeout sets the reconnect flag, so later sends fail fast. The commit
message also says completing all phases in one callback is deliberate.

Could the comment say that the bound applies to the MAC request only?

> +	err = enic_mbox_vf_add_del_macs(enic, macs, num_ops);
> +	if (err)
> +		goto free_ops;

[Severity: Medium]
What happens to the DELETEs in this batch if the PF rejects the whole
ADD_DEL_MAC request?

For a nonzero ret_major such as ENIC_MBOX_ERR_GENERIC, or an errno-style
value, enic_mbox_vf_classify_reply() returns -EIO and leaves recovery at
ENIC_MBOX_VF_REPLY_OK:

    if (ret_major)
        return -EIO;

The SET_PKT_FILTER reply handler escalates this case to a reconnect, but
the ADD_DEL_MAC handler does not. So enic_mbox_vf_add_del_macs() returns
-EIO without calling enic_mbox_vf_require_reconnect().

This goto free_ops then skips the per-address loop below. That loop is the
only place where a failed DELETE becomes a reconnect. The comment further
down says:

    A failed DELETE can leave hardware accepting an address no longer in
    the requested list.  Registration is the fail-closed cleanup boundary.

enic_set_vf_rx_mode() returns -EIO. The core retries at most
NETIF_RX_MODE_RETRY_MAX times, and then netif_rx_mode_schedule_retry()
prints "rx_mode retry limit reached, giving up".

After that, can the removed address stay installed at the PF, still
accepting traffic, until some unrelated receive-mode event?

> +
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

[ ... ]

> +	if (reconnect) {
> +		enic_mbox_vf_require_reconnect(enic);
> +		err = -EIO;
> +	} else if (retryable_add) {
> +		err = -EAGAIN;
> +	} else if (permanent_add) {
> +		err = -EACCES;
> +	}

[Severity: Medium]
How does this classification behave when the PF permanently rejects one ADD
and marks the rest of the batch as SKIPPED? enic_vf_station_addr_replace()
documents that PF behaviour:

    /* A policy-rejected ADD can be reported with all preceding DELETEs
     * skipped. No operation changed state in that coherent result tuple.
     */

Here a SKIPPED DELETE sets reconnect. One stable policy denial then calls
enic_mbox_vf_require_reconnect() and triggers a VF reset on every list
change that includes a DELETE.

The rejected ADD keeps sync_cnt == 0, so enic_vf_collect_mac_ops() sends it
again in every batch. After the reset replay the batch contains only ADDs,
and the valid ADDs come back SKIPPED. Because retryable_add is checked
before permanent_add, the result is -EAGAIN rather than -EACCES.

Does the core then retry the same batch until NETIF_RX_MODE_RETRY_MAX and
give up, leaving none of the valid secondary addresses installed? That
seems to contradict the commit message:

    stable policy denials do not consume the retry budget

The -EAGAIN/-EIO return also skips the final enic_vf_set_pkt_filter() in
enic_set_vf_rx_mode(), so pending packet-filter changes are dropped too.

[ ... ]

> +static int enic_set_vf_rx_mode(struct net_device *netdev,
> +			       struct netdev_hw_addr_list *uc,
> +			       struct netdev_hw_addr_list *mc)
> +{

[ ... ]

> +	filter_needed = !enic->vf_pkt_filter_valid ||
> +			 enic->vf_pkt_filter_requested != flags ||
> +			 (flags & broad_modes);
> +	broad_enable_needed =
> +		(!enic->vf_pkt_filter_valid && (flags & broad_modes)) ||
> +		(flags & broad_modes & ~enic->vf_pkt_filter_requested);
> +	broad_withdrawal = enic->vf_pkt_filter_valid &&
> +		(enic->vf_pkt_filter_applied & broad_modes & ~flags);
> +	if (broad_enable_needed) {
> +		/* Establish newly required broad coverage before an independent
> +		 * exact-address rejection can block it. Retain any broad mode that
> +		 * is currently applied until its finite replacement is installed.
> +		 */
> +		prefilter_flags = flags;
> +		if (enic->vf_pkt_filter_valid)
> +			prefilter_flags |= enic->vf_pkt_filter_applied & broad_modes;
> +		err = enic_vf_set_pkt_filter(enic, prefilter_flags,
> +					     &applied_flags);
> +		if (err)
> +			return err;
> +		target_filter_updated = prefilter_flags == flags;
> +		enic_vf_report_pkt_filter_denial(netdev, flags, applied_flags);
> +	}
> +
> +	if (broad_withdrawal) {
> +		/* Withdraw stale broad acceptance before installing its finite
> +		 * replacement. Complete both phases in this callback so a synchronous
> +		 * receive-mode operation cannot return between them.
> +		 */
> +		err = enic_vf_set_pkt_filter(enic, flags, &applied_flags);

[Severity: Low]
This isn't a bug, but the broad_enable_needed comment above says the
applied broad mode is kept until its finite replacement is installed.

When broad_withdrawal is also true, this block runs right afterwards. That
happens, for example, when UC goes from overflow back to finite while MC
starts to overflow. The block then removes the retained mode before
enic_vf_sync_mac_filters() installs the exact filters.

The commit message and this comment describe the actual order. Should the
earlier comment be updated? In this case the retained bit in
prefilter_flags only costs an extra mailbox round trip.

[ ... ]

> +	err = enic_vf_sync_mac_filters(enic, uc, mc, !uc_overflow,
> +				       !mc_overflow);
> +	if (err == -EACCES) {

[ ... ]

> +	}
> +	if (err)
> +		return err;
> +
> +	if (!target_filter_updated && filter_needed) {
> +		err = enic_vf_set_pkt_filter(enic, flags, &applied_flags);
> +		if (err)
> +			return err;

[Severity: Medium]
Can a denied broad mode stay unrequested after PF policy starts allowing
it? broad_enable_needed is computed from vf_pkt_filter_requested, not from
vf_pkt_filter_applied:

    (flags & broad_modes & ~enic->vf_pkt_filter_requested);

Once PROMISCUOUS or ALL_MULTICAST has been requested and withheld, the bit
is set in vf_pkt_filter_requested, so later callbacks skip the early enable
phase. The broad mode is then re-requested only by this final
enic_vf_set_pkt_filter().

If a finite-class ADD comes back SKIPPED (-EAGAIN), or the MAC request
fails some other way, the "if (err) return err;" above returns before this
call. Repeated failures can use up the core retry budget without the
broad-mode request ever being sent again.

That looks like the case the broad_enable_needed comment says the code
prevents:

    Establish newly required broad coverage before an independent
    exact-address rejection can block it.

[ ... ]

> @@ -2331,9 +2703,38 @@ static int enic_open(struct net_device *netdev)
>  		enic_vf_station_addr_set(enic, netdev->dev_addr);
>  		enic_vf_station_sync_reset(enic);
>  		vf_mac_added = true;

[ ... ]

> +		if ((enic_vf_uc_needs_promisc(vf_uc_count) &&
> +		     !(vf_filter_applied & CMD_PFILTER_PROMISCUOUS)) ||
> +		    (vf_mc_count > ENIC_MULTICAST_PERFECT_FILTERS &&
> +		     !(vf_filter_applied & CMD_PFILTER_ALL_MULTICAST))) {
> +			netdev_err(netdev,
> +				   "PF denied receive mode required by VF address lists\n");
> +			err = -EACCES;
> +			goto err_out_disable_wq;
> +		}
> +	}

[Severity: High]
Is it intended that enic_open() fails on a denial that
enic_set_vf_rx_mode() accepts at runtime?

Take 32 or more secondary UC addresses, or more than 32 MC addresses, with
a PF policy that withholds PROMISCUOUS/ALL_MULTICAST (for example an
untrusted VF). enic_set_vf_rx_mode() computes the same flags, but it:

- only reports the denial with netdev_dbg() in
  enic_vf_report_pkt_filter_denial()
- stops installing new exact filters for the overflowing class
- returns 0

So the lists can grow past the limit while the interface is up, and the VF
keeps running while silently dropping the extra traffic.

Any later enic_open() with those lists then fails here with -EACCES. That
includes an administrative down/up, _enic_change_mtu(), enic_reset() and
enic_tx_hang_reset(). The reset workers only log the error:

    err = enic_open(enic->netdev);
    if (err)
        netdev_err(enic->netdev,
                   "Failed to reopen datapath after reset: %d\n", err);

Does that leave the VF with IFF_UP set and the datapath closed until the
address lists are shrunk? The commit message doesn't mention this new
failure mode for open and reset.

>  
> -	enic_set_rx_mode(netdev);
> +	if (!enic_is_sriov_vf_v2(enic))
> +		enic_set_rx_mode(netdev);

[Severity: Medium]
enic_set_rx_mode() is now skipped for V2 VFs. Every caller that calls
enic_open() directly, bypassing __dev_open(), then has to schedule the
async update itself. enic_reset() and enic_tx_hang_reset() do that below.
Is _enic_change_mtu() missing the same call?

enic_mtu_check()->schedule_work(&enic->change_mtu_work)
  enic_change_mtu_work()
    _enic_change_mtu()
      enic_open()

_enic_change_mtu() {
    ...
    if (running) {
        err = enic_open(netdev);
        if (err)
            return err;
    }
    ...
}

Here enic_open() can take its reconnect branch (!admin_chan_up,
!vf_registered or vf_mbox_reconnect_required). That branch is reachable
after a failed reset handshake, because vf_mbox_reconnect_required stays
set until a later external recovery event.

That branch calls enic_reset_addr_lists() and re-registers, so the PF drops
all VF-requested filters. Only the station address and the packet filter
are then installed again.

Would the secondary unicast and multicast filters then stay uninstalled
until some unrelated address-list or flag change queues a receive-mode
run?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929-b4-enic-sriov-v2-vf-receive-control-v2-0-5962c10061b2%40cisco.com
