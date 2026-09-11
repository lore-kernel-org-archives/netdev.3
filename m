Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685E73AEF51
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120709; cv=none; b=i0ZsFpCyu5keJ2nCwMlnSsSWlxLe1CnUkJMni9PU5RO8MrQeLIDHPcWoE6dVEgFmyc+P6CAhyan3K/odDP/Yow59V+xdyB/4ygTfJBXQuWpw/TjeC8WQUMtAnylpIAPsoSCyWgpmvnOvYWtAajk0Y9Mbgywo6j17TmSXqhc7Ea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120709; c=relaxed/simple;
	bh=M22/pIo1lemK9EfFCH2S4fSA2aAnrM7ouwQixjd0LQo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q6fdEvZZc0fMlyNe3wHoCxtbkwEhgyb08Hd3fQquVmZV/MMWLbbCAs3HJ2x1WYY3jfrYzRSRjKZciKkfb3jm7K0ccLHzHSdobw3GX7X4kK2C4VqAmRJExNMDhJYIfoNOmXUFwiZKsciXfVCbESvwtPkySjx7AjCTK26DQJ3TUrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNV/Wxm4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNV/Wxm4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AD21F000FF;
	Fri, 11 Sep 2026 09:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789120707;
	bh=xUFC3n5laWcMWMWVkE90/QimX9Y4d0hlk8fOKBhtB3I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HNV/Wxm4Dd42LNJ2al0Sg5GUnkN9rd/tatMyzbs5abEfa3yXs8QqvbXtuGr+I9a8r
	 KHiHRI3A5GRQQ/qHq1hwthhpJF8e7QcCz1CaqJHIHiMcA4ICunf+v3khtNFkd17/Z1
	 pg2eUKP6WmqU4chvQVGC2RpCkCe4jzT5eoio1/S/ifYU5/ZnTHKfGaHyjAjd8RjWIC
	 aTu9UbqQnckSJFlSW2yiMk+AANOzEkv/O88GKxQ+t70pKBuDiG94le0D0JGS8D+fUk
	 J1fuDX925hxUicWKeN5R5kMzDzy0wk/5f884ae1TAc8O286neHEOw1hc+Z5byQjh6+
	 kSRo5NuEN3rGA==
Subject: Re: [PATCH net-next v4] net: libwx: rework VF PM suspend/resume flow
From: netdev-bot+sashiko@kernel.org
To: mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hramamurthy@google.com
Date: Fri, 11 Sep 2026 09:58:26 +0000
Message-ID: <178912070609.219967.5944304573215641311@kernel.org>
In-Reply-To: <20260908095801.61346-1-mengyuanlou@net-swift.com>
References: <20260908095801.61346-1-mengyuanlou@net-swift.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider:

Critical: 0 · High: 4 · Medium: 5 · Low: 1

- [High] wxvf_suspend() calls wxvf_close() (the ndo_stop body) directly
  and then wx_clear_interrupt_scheme(), but never clears the core netdev…
- [High] The open_failed/hard_failure path of wxvf_reopen_subtask() hand-
  rolls the netdev down transition: it fires…
- [High] wxvf_suspend() now calls cancel_work_sync(&wx->service_task)
  after timer_delete_sync().
- [High] On the hard_failure path of wxvf_reopen_subtask()
  (wx_init_interrupt_scheme() returned an error),…
- [Medium] The commit message presents the change as a cosmetic "rework
  ... to normalize VF netdevice lifecycle handling", but the patch…
- [Medium] wxvf_reopen_subtask() gates the whole reopen on 'if
  (wx_read_mbx_vf(wx, &msgbuf, 1))' with the comment "try get mbx lock…
- [Medium] The open_failed/hard_failure path of wxvf_reopen_subtask()
  calls pci_disable_device(wx->pdev) without recording that the device…
- [Medium] wxvf_suspend() performs the resource teardown (wxvf_close() +
  wx_clear_interrupt_scheme()) under rtnl and only quiesces the service…
- [Medium] The reworked resume path (wxvf_resume() ->
  wxvf_reopen_subtask()) restores only software state:…
- [Low] wxvf_reopen_subtask() calls wx_read_mbx_vf() without holding
  wx->mbx.mbx_lock, unlike every other mailbox call site in the VF…

--

net: libwx: rework VF PM suspend/resume flow

This reworks wxvf_suspend()/wxvf_resume() so that the VF netdevice is
closed under rtnl_lock during suspend and the queue/interrupt bring-up is
deferred to a new wxvf_reopen_subtask() driven by WX_FLAG_NEED_REOPEN.
Some questions on the new flow below.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index ed5aad7857bd9..de09a6704477a 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -3381,7 +3381,8 @@ EXPORT_SYMBOL(wx_set_ring);
>  
>  void wx_service_event_schedule(struct wx *wx)
>  {
> -	if (!test_bit(WX_STATE_DOWN, wx->state) &&
> +	if ((!test_bit(WX_STATE_DOWN, wx->state) ||
> +	     test_bit(WX_FLAG_NEED_REOPEN, wx->flags)) &&
>  	    !test_and_set_bit(WX_STATE_SERVICE_SCHED, wx->state))
>  		queue_work(system_power_efficient_wq, &wx->service_task);
>  }

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> index 26de78e9a69ef..7d52da8e6af14 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> @@ -16,8 +16,18 @@ int wxvf_suspend(struct device *dev_d)
>  	struct pci_dev *pdev = to_pci_dev(dev_d);
>  	struct wx *wx = pci_get_drvdata(pdev);
>  
> +	rtnl_lock();
>  	netif_device_detach(wx->netdev);
> +	if (netif_running(wx->netdev)) {
> +		set_bit(WX_STATE_WAS_RUNNING, wx->state);
> +		wxvf_close(wx->netdev);
> +	}
>  	wx_clear_interrupt_scheme(wx);
> +	rtnl_unlock();

[Severity: High]
Calling wxvf_close() directly here runs the ndo_stop body but leaves the
core netdev state untouched, so __LINK_STATE_START and IFF_UP stay set
while wx_clear_interrupt_scheme() frees wx->msix_entry,
wx->msix_q_entries and wx->q_vector[] and zeroes num_tx_queues /
num_rx_queues / num_q_vectors.

Since wxvf_resume() restores nothing and only arms the timer, that state
is live for at least a second after userspace is thawed. If an admin
down arrives in that window, __dev_close_many() calls ndo_stop
unconditionally for any IFF_UP device, so wxvf_close() runs a second
time:

wxvf_close()
    wxvf_down()          /* early return, WX_STATE_DOWN already set */
    wx_free_irq(wx)

and in wx_free_irq() pdev->msix_enabled is now 0 while
wx->misc_irq_domain is false for VFs (only txgbe_setup_misc_irq() sets
it), so it reaches:

	if (!(pdev->msix_enabled)) {
		if (!wx->misc_irq_domain)
			free_irq(pdev->irq, wx);
		return;
	}

free_irq() on an IRQ that was never requested gives
WARN(1, "Trying to free already-free IRQ %d"). Would a
WX_STATE_RES_FREED style guard in the VF close path, like the one
ngbe_close()/txgbe_close() use for exactly this suspend-freed-resources
case, be appropriate here?

The same stale netif_running() also sends wx_set_ringparam_vf() down its
"running" branch, where wxvf_up_complete() clears WX_STATE_DOWN and
enables queues and interrupts on a device that owns no vectors and no
rings.

[Severity: Medium]
Can a service task already inside wxvf_reopen_subtask() and blocked on
rtnl_lock() re-allocate what was just freed? The teardown happens under
rtnl, and the work is only quiesced after rtnl_unlock(), and
cancel_work_sync() waits for a running work item rather than aborting
it. The blocked work would then proceed with WX_FLAG_NEED_REOPEN still
set and run wx_init_interrupt_scheme() (pci_alloc_irq_vectors() plus the
msix_entry/msix_q_entries/q_vector allocations) and, with
WX_STATE_WAS_RUNNING plus the still-true netif_running(), wxvf_open()
(ring DMA, request_irq(), and wxvf_up_complete() re-arming the service
timer and clearing WX_STATE_DOWN) immediately before
pci_clear_master()/pci_disable_device().

WX_FLAG_NEED_REOPEN is cleared by that run, so the next resume restores
nothing, and the following wx_init_interrupt_scheme() overwrites the
already-allocated msix/q_vector pointers. DEFINE_SIMPLE_DEV_PM_OPS maps
freeze/thaw/poweroff to the same pair, so hibernation performs
suspend -> resume -> suspend and can reach this with the flag still set.

> +
> +	timer_delete_sync(&wx->service_timer);
> +	cancel_work_sync(&wx->service_task);

[Severity: High]
Can this leave WX_STATE_SERVICE_SCHED set forever? wx_service_timer()
runs in softirq and wx_service_event_schedule() sets the bit before
queue_work():

	if ((!test_bit(WX_STATE_DOWN, wx->state) ||
	     test_bit(WX_FLAG_NEED_REOPEN, wx->flags)) &&
	    !test_and_set_bit(WX_STATE_SERVICE_SCHED, wx->state))
		queue_work(system_power_efficient_wq, &wx->service_task);

The only runtime clearing site is wx_service_event_complete() at the end
of wxvf_service_task(). If the timer queued the work just before
cancel_work_sync() runs, the pending item is dequeued without ever
executing, so the bit is never cleared and every later
test_and_set_bit() fails. The new WX_FLAG_NEED_REOPEN term only bypasses
the WX_STATE_DOWN test, not the SCHED gate.

Because wxvf_resume() no longer does wx_init_interrupt_scheme() and
netif_device_attach() itself, the VF then stays detached with no
interrupt scheme and no rings until the driver is unbound and rebound.
Should the suspend path clear WX_STATE_SERVICE_SCHED explicitly after
cancel_work_sync()?

> +	pci_clear_master(pdev);
>  	pci_disable_device(pdev);
>  
>  	return 0;
> @@ -34,11 +44,19 @@ int wxvf_resume(struct device *dev_d)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev_d);
>  	struct wx *wx = pci_get_drvdata(pdev);
> +	int err;
>  
> -	pci_set_master(pdev);
> -	wx_init_interrupt_scheme(wx);
> -	netif_device_attach(wx->netdev);
> +	err = pci_enable_device_mem(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Cannot enable PCI device from suspend\n");
> +		return err;
> +	}

[Severity: Medium]
The changelog describes this as a rework "to normalize VF netdevice
lifecycle handling during power management transitions", but two of the
changes look like fixes for user-visible defects that the message does
not mention and that carry no Fixes: tag.

The old wxvf_resume() did only pci_set_master() plus
wx_init_interrupt_scheme() and never re-enabled the device that suspend
had disabled, so pdev->enable_cnt went 1 -> 0 on the first suspend and
negative on the second cycle, tripping the "disabling already-disabled
device" warning in pci_disable_device(). The new
pci_enable_device_mem() here fixes that.

Similarly, the old wxvf_suspend() ran wx_clear_interrupt_scheme() and
pci_disable_device() while a running interface still had live DMA; the
new wxvf_close() and pci_clear_master() address that.

Both callbacks are live through DEFINE_SIMPLE_DEV_PM_OPS(ngbevf_pm_ops,
wxvf_suspend, wxvf_resume) and the equivalent txgbevf registration.
Could the two fixes be described and tagged so stable backports pick
them up?

>  
> +	pci_set_master(pdev);
> +	rtnl_lock();
> +	mod_timer(&wx->service_timer, jiffies + HZ);
> +	set_bit(WX_FLAG_NEED_REOPEN, wx->flags);
> +	rtnl_unlock();
>  	return 0;
>  }
>  EXPORT_SYMBOL(wxvf_resume);

[ ... ]

> @@ -403,10 +425,69 @@ static void wxvf_link_config_subtask(struct wx *wx)
>  	}
>  }
>  
> +static void wxvf_reopen_subtask(struct wx *wx)
> +{
> +	u32 msgbuf = 0;
> +
> +	if (!test_bit(WX_FLAG_NEED_REOPEN, wx->flags))
> +		return;
> +
> +	rtnl_lock();
> +	/* try get mbx lock to make sure we can communicate with the PF */
> +	if (wx_read_mbx_vf(wx, &msgbuf, 1)) {
> +		rtnl_unlock();
> +		return;
> +	}

[Severity: Medium]
Does this actually test that the PF is reachable? wx_read_mbx_vf() takes
only the VF's own VFU bit through wx_obtain_mbx_lock_vf() ->
wx_mailbox_get_lock_vf(), which writes WX_VXMAILBOX_VFU and polls the
same bit back with no PF transaction, then drains WX_VXMBMEM and writes
WX_VXMAILBOX_ACK:

	ret = wx_obtain_mbx_lock_vf(wx);
	if (ret)
		return ret;

	for (i = 0; i < size; i++)
		msg[i] = rd32a(wx, WX_VXMBMEM, i);

	wr32(wx, WX_VXMAILBOX, WX_VXMAILBOX_ACK);

So the gate passes regardless of PF state, and it consumes and ACKs
whatever PF to VF message happens to be pending. The only other reader,
wx_check_mac_link_vf(), deliberately checks first:

	wx_check_for_rst_vf(wx);
	if (!wx_check_for_msg_vf(wx))
		ret = wx_read_mbx_vf(wx, msgbuf, 2);

and dispatches WX_PF_CONTROL_MSG / WX_PF_NOFITY_VF_LINK_STATUS. A PF
ping or link-status notification landing in this window is discarded
along with the WX_FLAG_NEED_DO_RESET it would have set.

A non-decoding device also reads 0xFFFFFFFF, which has VFU set, so a
failed MMIO read looks like a successful lock, and wx_read_v2p_mailbox()
latches those all-ones R2C bits into wx->mbx.mailbox as pending-message
and PF-reset indications.

[Severity: Low]
This isn't a bug today, but this is the only mailbox access in the VF
driver taken without spin_lock_bh(&wx->mbx.mbx_lock).
wx_negotiate_api_vf(), wx_set_rx_mode_vf(), wx_configure_rx_vf(),
wx_set_mac_vf() and wxvf_watchdog_update_link() in this same work item
all wrap the helper, for example:

	spin_lock_bh(&wx->mbx.mbx_lock);
	err = wx_check_mac_link_vf(wx);
	spin_unlock_bh(&wx->mbx.mbx_lock);

Today the other users are rtnl-serialized (neither ngbevf_netdev_ops nor
txgbevf_netdev_ops registers .ndo_set_rx_mode), so no concrete race
exists, but a future non-rtnl mailbox caller would silently race with
this one. Would taking mbx_lock here keep the convention intact?

> +
> +	if (wx_init_interrupt_scheme(wx)) {
> +		dev_err(&wx->pdev->dev, "Failed to initialize interrupt scheme\n");
> +		goto hard_failure;
> +	}
> +
> +	if (test_bit(WX_STATE_WAS_RUNNING, wx->state)) {
> +		if (!netif_running(wx->netdev))
> +			goto finish_success;
> +
> +		if (wxvf_open(wx->netdev))
> +			goto open_failed;
> +	}

[Severity: Medium]
Does the new bring-up sequence need the VF hardware reset and PF
handshake? This path restores only software state
(pci_enable_device_mem(), pci_set_master(), wx_init_interrupt_scheme(),
wxvf_open()) and never calls wx_reset_vf() -> wx_reset_hw_vf() /
wx_init_hw_vf() / wx_negotiate_api_vf().

wx_reset_hw_vf() is the only place that asserts WX_VXCTRL_RST, re-applies
the VXRXDCTL defaults, invalidates the negotiated API:

	/* reset the api version */
	wx->vfinfo->vf_api = wx_mbox_api_null;

sends WX_VF_RESET so the PF re-establishes clear_to_send, RAR and
mc_filter_type, and is the only writer in the tree of the device-level
bus-master enable:

	/* amlite: bme */
	if (wx->mac.type == wx_mac_aml || wx->mac.type == wx_mac_aml40)
		wr32(wx, WX_VX_PF_BME, WX_VF_BME_ENABLE);

pci_set_master() only sets the config-space bit, not that register. After
a D3cold power cycle, would wxvf_open() then enable the descriptor
engines on default hardware while the driver still believes the VF is
configured and API-negotiated, with the PF-mediated calls in
wx_configure_vf() (wx_set_rar_vf(), wx_update_xcast_mode_vf(),
wx_rlpml_set_vf()) failing silently?

> +
> +finish_success:
> +	clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
> +	clear_bit(WX_STATE_WAS_RUNNING, wx->state);
> +	netif_device_attach(wx->netdev);
> +	rtnl_unlock();
> +	return;
> +open_failed:
> +	wx_clear_interrupt_scheme(wx);
> +hard_failure:
> +	clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
> +	clear_bit(WX_STATE_WAS_RUNNING, wx->state);
> +	set_bit(WX_STATE_DOWN, wx->state);

[Severity: High]
On the hard_failure path, wx->num_tx_queues and num_rx_queues keep the
values programmed by wx->set_num_queues() while every wx->tx_ring[] and
rx_ring[] entry is still NULL from the suspend-time wx_free_q_vector().
In wx_init_interrupt_scheme() the counts are set first and the
wx_set_interrupt_capability() failure returns immediately:

	ret = wx_set_interrupt_capability(wx);
	if (ret) {
		wx_err(wx, "Allocate irq vectors for failed.\n");
		return ret;
	}

only the wx_alloc_q_vectors() failure path zeroes the counts. The netdev
stays registered and !netif_running(), so wx_set_ringparam_vf() takes:

	for (i = 0; i < wx->num_tx_queues; i++)
		wx->tx_ring[i]->count = new_tx_count;

Can an ethtool -G on such a VF dereference NULL here? Should this path
also reset the queue counts?

> +
> +	if (netif_running(wx->netdev)) {
> +		struct net_device *netdev = wx->netdev;
> +
> +		/* Can't use dev_close() here because wxvf_close() was
> +		 * already called during suspend. Manually clear state
> +		 * and send notifications instead.
> +		 */
> +		call_netdevice_notifiers(NETDEV_GOING_DOWN, netdev);
> +		call_netdevice_notifiers(NETDEV_DOWN, netdev);
> +		netdev->flags &= ~IFF_UP;
> +		clear_bit(__LINK_STATE_START, &netdev->state);
> +	}

[Severity: High]
The changelog says this "properly synchronize core netdev states
(__LINK_STATE_START / IFF_UP) and fire notifications if reopening
fails". Does this open-coded sequence match the core contract?

__dev_close_many() does:

	call_netdevice_notifiers(NETDEV_GOING_DOWN, dev);

	clear_bit(__LINK_STATE_START, &dev->state);
	...
	dev_deactivate_many(head, true);
	...
	netif_rx_mode_cancel_retry(dev);
	netif_set_up(dev, false);

and only then netif_close_many() emits:

	rtmsg_ifinfo(RTM_NEWLINK, dev, IFF_UP | IFF_RUNNING, GFP_KERNEL, 0, NULL);
	call_netdevice_notifiers(NETDEV_DOWN, dev);

Compared to that, NETDEV_DOWN is delivered here before the state and
flag changes, so notifier consumers see the device as down while
netif_running() and IFF_UP still read true. dev->up is also left stale
true, since only netif_set_up() keeps IFF_UP and dev->up in sync:

	if (value)
		dev->flags |= IFF_UP;
	else
		dev->flags &= ~IFF_UP;
	...
	dev->up = value;

dev_deactivate_many() and netif_rx_mode_cancel_retry() are skipped, so
the qdisc stays active and the watchdog timer may remain armed on a
device whose rings and IRQs are freed, and the RTM_NEWLINK notification
never reaches rtnetlink monitors.

Also, this path never calls netif_device_attach(), so
__LINK_STATE_PRESENT stays clear and a later admin up cannot succeed,
while wxvf_resume() already returned 0. Is the interface meant to be
unusable until driver rebind?

> +
> +	rtnl_unlock();
> +	pci_disable_device(wx->pdev);

[Severity: Medium]
This disable is not recorded anywhere. enable_cnt is 1 at this point
(wxvf_resume() did the single pci_enable_device_mem()), so it drops to 0,
but only WX_STATE_DOWN is set and WX_FLAG_NEED_REOPEN is cleared. A
later wxvf_suspend() (also used as .shutdown) or wxvf_remove() calls
pci_disable_device() again unconditionally, which then hits:

	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
		      "disabling already-disabled device");

	if (atomic_dec_return(&dev->enable_cnt) != 0)
		return;

The early return skips do_pci_disable_device(), so bus mastering is
never cleared and dev->is_busmaster stays 1 after unbind. From then on
the accounting stays skewed by one in each direction. Should this path
track that the device was disabled, or leave it enabled and let the
normal suspend/remove path do the disable?

> +	dev_err(&wx->pdev->dev, "Failed to fully resume device\n");
> +}
> +
>  static void wxvf_service_task(struct work_struct *work)
>  {
>  	struct wx *wx = container_of(work, struct wx, service_task);
>  
> +	wxvf_reopen_subtask(wx);
>  	wxvf_link_config_subtask(wx);
>  	wxvf_reset_subtask(wx);
>  	wx_service_event_complete(wx);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908095801.61346-1-mengyuanlou%40net-swift.com
