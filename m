Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E54766B7;
	Sat,  3 Oct 2026 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791057060; cv=none; b=OG1s2kX/aVSw9/b4UIFl4Ew8DkRSPlzTh27uARC/5WlaTZwuCoKG9NvhCGKotmx5z+JQWc19dkQjYPo0IglHSJK38mmSQg8CMbERCrvtuoOm7QOu6rUP+ZxV7cQAeIwOpvMPmOdtB/RaMRSSXoJBEJECuLPmG0XEvK7FNxtV504=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791057060; c=relaxed/simple;
	bh=oPQsqm5L67MCj1T3+AgEB5+pAF8ITGySMLGyUHlrRzk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UFHegEToU6/QV0P/HpHdMt+ziGWYEuitXdaRPhr0nwXxNVMTQgVVY5/3dryXWSiSZ/jy/l1RE2FNI1LkO1G/1wSZ/+F5fSHlrB6XNXaSjMpJtiFk558jzDwfI4p7ScT2mtt3KiXtqYW4aL8E+Zhz2F1zxZBzbjWr5JxOYfO9Lmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PembsyDc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PembsyDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939E01F0089D;
	Sat,  3 Oct 2026 19:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791057058;
	bh=5cGkrI2m14RZ2wCIrSTI4qSekwfXdER0T63snKhbo14=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PembsyDcSQXgFNyjlzVRoMuG4d/2ew0vWVxVshimSeDHpoYkSxJEWeDP/4hjFWQJv
	 iwOqXnb8j7KM+h9rRrUkh1AQhFJDx5Tp0Kgt6USuuOQT7saQx2DaxMQsx8kdSxEX6V
	 LYPdOC08axG1nnqVC6F5wxHvXQMrAonUaqVfhdu2TvSVkiB4ldUJZJzhRyfAjxyWJH
	 pJiHLYi23CLwOqnr6RiZuxnrZUWrCZMz5y1gbVouPEIdYoyZMty18c5h4gfQInbTb9
	 M8AdwrekzGkNameVBqumXNu54I7htz3RKzLZEyAw7eSWhsXQxXdM5vB0z2ZhBgbINF
	 Mk1FiUY5txD3A==
Subject:
 Re: [PATCH net-next v2 5/6] enic: manage V2 VF station and administrative MAC
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sebaddel@cisco.com
Date: Sat, 03 Oct 2026 19:50:57 +0000
Message-ID: <179105705715.434549.4447540966056164842@kernel.org>
In-Reply-To:
 <20260929-b4-enic-sriov-v2-vf-receive-control-v2-5-5962c10061b2@cisco.com>
References:
 <20260929-b4-enic-sriov-v2-vf-receive-control-v2-5-5962c10061b2@cisco.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit, enic_remove() runs
  enic_vf_admin_mac_quiesce(), VF_UNREGISTER and…
- [Low] At this commit, enic_vf_station_sync_reset() drops the core sync
  reference for the uc entry that matches vf_station_addr only once.
- [Low] The comment in enic_remove() says "VF_UNREGISTER is the protocol
  teardown operation: the PF removes all VF-requested configuration,…
- [Low] At this commit, a runtime station change does not reprogram an
  old station address A that is still wanted as a secondary unicast…

Pre-existing issues:
- [Low] enic_reset_addr_lists() now holds netif_addr_lock_bh() only
  around __dev_uc_unsync()/__dev_mc_unsync().

--

enic: manage V2 VF station and administrative MAC

V2 VFs now manage the station MAC through a mailbox DEL+ADD replace
request. The address is installed on open and removed on an ordinary
stop. A delayed worker applies PF administrative MAC notifications, the
admin MAC policy is re-read after every VF registration, and the worker
is quiesced and rearmed around teardown and reset.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 28738bd14fa7c..2132bfa9c8d38 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c

[ ... ]

> @@ -1040,8 +1043,10 @@ void enic_reset_addr_lists(struct enic *enic)
>  {
>  	struct net_device *netdev = enic->netdev;
>  
> +	netif_addr_lock_bh(netdev);
>  	__dev_uc_unsync(netdev, NULL);
>  	__dev_mc_unsync(netdev, NULL);
> +	netif_addr_unlock_bh(netdev);
>  
>  	enic->mc_count = 0;
>  	enic->uc_count = 0;

[Severity: Low]
This is a pre-existing issue, and this patch did not introduce it. The
baseline did both the unsync and the counter reset with no lock at all,
so this change only narrows the window.

The addr lock now covers only the two unsync calls. mc_count, uc_count
and flags are still reset after netif_addr_unlock_bh().

Devices that use the legacy ndo_set_rx_mode path update these counters
under addr_list_lock only:

enic_set_rx_mode()
  __dev_uc_sync(netdev, enic_uc_sync, enic_uc_unsync);
    enic_uc_sync()
      enic->uc_count++;

Can an rx_mode run between the unlock and the counter reset leave
uc_count or mc_count out of step with the core sync state? If uc_count
underflows, the ENIC_*_PERFECT_FILTERS limit check would no longer work.
Could the counter resets move inside the locked section?

For V2 VFs, the last patch in the series ("enic: configure V2 VF receive
mode over mailbox") switches to ndo_set_rx_mode_async.
netif_rx_mode_run() is serialized by RTNL, and so are the callers of
enic_reset_addr_lists().

[ ... ]

> @@ -1072,6 +1532,52 @@ static int enic_set_mac_address_dynamic(struct net_device *netdev, void *p)

[ ... ]

> +		/* Keep the old software address visible until the complete station
> +		 * replacement proves convergence.
> +		 */
> +		err = enic_vf_station_addr_replace(enic, addr);
> +		if (err)
> +			return err;
> +
> +		enic_vf_station_sync_reset(enic);
> +		err = enic_set_mac_addr(netdev, addr);
> +		if (!err) {
> +			enic_vf_station_addr_set(enic, addr);
> +			enic_vf_station_sync_reset(enic);
> +			enic_vf_admin_mac_cache_selected(enic, addr);
> +		}
> +
> +		return err;
> +	}

[Severity: Low]
At this commit, if the old station address A is also in the uc list as a
secondary address, does anything reprogram A after the station moves?

enic_vf_station_addr_replace() deletes A at the PF, and
enic_vf_station_sync_reset() unsyncs A's core entry. No rx_mode update
is scheduled afterwards, so A would not be added back as a secondary
filter.

The nonzero-policy path in enic_vf_admin_mac_work() has a similar gap:

enic_vf_admin_mac_work() {
    ...
	} else if (enic->vf_station_addr_valid &&
		   !ether_addr_equal(enic->vf_station_addr, selected)) {
		mutated = true;
		err = enic_vf_station_addr_del(enic);
    ...
	changed = !ether_addr_equal(enic->netdev->dev_addr, selected);
	enic_vf_station_sync_reset(enic);
    ...
}

enic_vf_station_addr_del() clears vf_station_addr_valid on success. The
first enic_vf_station_sync_reset() then returns early, and a re-synced
entry for A can keep sync_cnt=1 while the PF no longer has a filter for
A.

Could receive for A be lost until the next rx_mode event?

The last patch in the series, "enic: configure V2 VF receive mode over
mailbox", fixes this:

  - It adds netif_rx_mode_schedule_update() here and after the admin-MAC
    update in enic_vf_admin_mac_work().
  - enic_vf_collect_mac_ops() skips the station address, so A has
    sync_cnt==0 while it is the station.

Would it make sense to schedule the rx_mode update in this patch too, so
that intermediate commits don't have this behaviour?

[ ... ]

> @@ -1807,6 +2314,25 @@ static int enic_open(struct net_device *netdev)
>  	if (!enic_is_dynamic(enic) && !enic_is_sriov_vf(enic))
>  		enic_dev_add_station_addr(enic);
>  
> +	if (enic_is_sriov_vf_v2(enic)) {

[ ... ]

> +		enic_vf_station_addr_set(enic, netdev->dev_addr);
> +		enic_vf_station_sync_reset(enic);
> +		vf_mac_added = true;
> +	}
> +
>  	enic_set_rx_mode(netdev);

[Severity: Low]
enic_vf_station_sync_reset() drops the core sync reference for the
station entry only once. At this commit V2 VFs still use
enic_set_rx_mode(), which runs on the very next line, and enic_uc_sync()
does not exclude vf_station_addr:

enic_uc_sync() {
    ...
	enic_dev_add_addr(enic, uc_addr);
	enic->uc_count++;
    ...
}

Won't this re-sync the station entry right away?

If that uc entry is removed later, enic_uc_unsync() would call
enic_dev_del_addr() for the station address. It is not clear whether
that devcmd reaches the PF's address-keyed ledger for V2 VFs. The last
patch says V2 VFs cannot program receive filters directly.

The last patch in the series, "enic: configure V2 VF receive mode over
mailbox", resolves this:

  - V2 VFs move to enic_set_vf_rx_mode() via ndo_set_rx_mode_async.
  - enic_vf_collect_mac_ops() and enic_vf_addr_list_count() skip
    vf_station_addr.
  - enic_open() calls enic_set_rx_mode() only for non-V2 devices.

[ ... ]

> @@ -3542,9 +4106,13 @@ static void enic_remove(struct pci_dev *pdev)
>  
>  		/* Close the admin channel and unregister from the PF before
>  		 * unregister_netdev() to prevent a late PF notification from
> -		 * touching a netdev that is being torn down.
> +		 * touching a netdev that is being torn down. VF_UNREGISTER is the
> +		 * protocol teardown operation: the PF removes all VF-requested
> +		 * configuration, including the station address, before replying.
>  		 */

[Severity: Low]
The VF now relies on this contract to skip the station DEL_MAC on
remove and on internal reset (__enic_stop(netdev, false)).

The in-tree PF side doesn't do this yet. enic_mbox_pf_handle_unregister()
only does:

	enic->vf_state[vf_id].registered = false;

and replies. enic_mbox_pf_process_msg() has no case for
ENIC_MBOX_VF_ADD_DEL_MAC_REQUEST or ENIC_MBOX_PF_SET_ADMIN_MAC_ACK, so
both fall through to -EOPNOTSUPP.

This can't be reached today. enic_driver has no .sriov_configure, and
the comment above enic_sriov_configure() says the V2 helpers are
"defined but not yet wired". The earlier patch "enic: validate V2 VF
configuration replies" also says PF-side MAC handling must be added
before that callback is wired.

Should this comment say it describes the PF protocol contract rather
than the in-tree PF? That would remind the PF activation series to
implement station cleanup in the unregister handler.

>  		if (enic_is_sriov_vf_v2(enic)) {
> +			enic_vf_admin_mac_quiesce(enic);
> +
>  			if (READ_ONCE(enic->vf_registered)) {
>  				int unreg_err = enic_mbox_vf_unregister(enic);

[Severity: Medium]
At this commit, enic_vf_admin_mac_quiesce(), VF_UNREGISTER and
enic_admin_channel_close() all run while the netdev is still registered
and attached, and RTNL is not held. Can a concurrent ndo_open undo this
teardown?

Under RTNL, enic_open() can see !admin_chan_up, !vf_registered or
reconnect_required and reopen the channel:

	if (enic->admin_chan_up)
		enic_admin_channel_close(enic);
	err = enic_admin_chan_reopen(enic);

That path re-registers with the PF and then rearms the worker:

enic_open()
  enic_admin_chan_reopen()
    ... admin channel open, VF register ...
    enic_vf_admin_mac_rearm()
      enic->vf_admin_mac_work_enabled = true;

unregister_netdev() -> enic_stop() does not close the admin channel.
Could the admin resources and the admin IRQ then outlive
free_netdev()?

The last patch in the series, "enic: configure V2 VF receive mode over
mailbox", closes this window:

  - It adds rtnl_lock(); netif_device_detach(netdev); rtnl_unlock();
    after the quiesce, so __dev_open() returns -ENODEV once the device
    is detached.
  - enic_admin_channel_close() quiesces the worker again at entry.

Could the detach be moved into this patch so intermediate commits don't
carry the race?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929-b4-enic-sriov-v2-vf-receive-control-v2-0-5962c10061b2%40cisco.com
