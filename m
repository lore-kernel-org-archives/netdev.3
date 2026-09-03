Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B33A230BDB
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 00:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394617; cv=none; b=PZN8PJpjWB2nbGpH+oJnmkrqNObbEQ+sAPgg6HSAIePakx8qJ4prADCyJbjxiI2ycFlXkQzwO2kJxE3qq6cN5YX5p4p3rOf5QOKE9V2sN+6EfkDhSg0ZWQzYXH/8bZkhdgAqF8QKIQCqfb6a9UA6KPXrM9Cz1QwyS5YmiroPOOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394617; c=relaxed/simple;
	bh=TAbIm9y3KhMo1LF1+vbSkrXVqUbkUi4pfRq1ktwqUAk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eZOkgslm/phRddTknqq26F80osuvnEVorRkf2wT0sADkqOmmv2fINRHI31OYoE5xyNkSTQ4Nkw2sR1wFs2nCE9wAXXUDnmqpaHDfQHG7lr2yHAPPZMYvRTiLUQaiaE4ShT24i5z6TQ8g6XZnyz/WZkGm44SndfP96xgZVfLhYbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHNeZCoP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHNeZCoP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB191F000E9;
	Thu,  3 Sep 2026 00:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788394615;
	bh=Tll7KApgSJsN9T7Xl3RjDamWlxyahJVjYrxerxfkV5s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UHNeZCoPIN31Wa/AHQWohSG1PuIFZz0JdYJYd+Wvt/M6+miK4LmUkJjwmT07YhbVt
	 f0kEn7kv91LOsRqwMlFa/k8+w04vXsBb6FfIIzxPqK9VwkPQAZjQvP2jde5JHqUDja
	 nBJtlipZ1pgFLG7B7D7VZIgRLCYXiswg/s/I6LUk+KmyCiqfS43Ej3zvqE725shAbv
	 lsg5+baU/JsTaTe0KLoLzh3W164LKUN9ITvjD4iq08uG56Lq0iuQQfuZw6b/jFzE98
	 U7fMrbzm+mbCwKfGl6Mx9o0DsyL6p5GhClZenn4oFARyN9nl4fAPdgHqtpP8GXj5VX
	 FrCP+fhUfYWKQ==
Subject: Re: [net,v2] net: libwx: fix PM suspend/resume flow for VF drivers
From: netdev-bot+sashiko@kernel.org
To: mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hramamurthy@google.com
Date: Thu, 03 Sep 2026 00:16:54 +0000
Message-ID: <178839461464.3394541.3478369630769947860@kernel.org>
In-Reply-To: <20260829091423.83097-1-mengyuanlou@net-swift.com>
References: <20260829091423.83097-1-mengyuanlou@net-swift.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 5 · Medium: 1 (1) · Low: 0

- [High] wxvf_suspend() frees the DMA-visible receive/transmit resources
  while the VF hardware queues are still enabled and bus mastering is…
- [High] The new error unwind in wxvf_resume() (wx_vf_common.c:91-98)
  leaves the driver in a state that is inconsistent with the netdevice.
- [High] wxvf_resume() re-arms DMA and starts the data path before any VF
  ring register is re-programmed.
- [High] wxvf_resume() recomputes the VF queue configuration but never
  publishes the new counts to the netdevice.
- [High] wxvf_suspend() tears down the service timer and work without
  ever closing the gate that allows them to be re-armed/re-queued: it…
- [Medium] When the VF interface was administratively down at suspend
  time, wxvf_resume() restores nothing but the interrupt scheme:…

Pre-existing issues:
- [Medium] wxvf_reinit_locked() (wx_vf_common.c:401-413) discards the
  return value of wx_request_msix_irqs_vf()…

--

net: libwx: fix PM suspend/resume flow for VF drivers

This reworks wxvf_suspend()/wxvf_resume() in libwx to run under rtnl_lock(),
to cancel the service timer/task and free IRQ and ring resources on suspend,
and to re-enable the PCI device, re-init the interrupt scheme and re-request
MSI-X vectors on resume, deferring hardware reconfiguration to the reset
subtask via WX_FLAG_NEED_DO_RESET.

A few questions about the new flow below.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> index 26de78e9a69e..8a212e36c3d8 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> @@ -15,10 +15,26 @@ int wxvf_suspend(struct device *dev_d)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev_d);
>  	struct wx *wx = pci_get_drvdata(pdev);
> +	struct net_device *netdev;
>  
> -	netif_device_detach(wx->netdev);
> +	netdev = wx->netdev;
> +	timer_delete_sync(&wx->service_timer);
> +	cancel_work_sync(&wx->service_task);
> +	clear_bit(WX_STATE_SERVICE_SCHED, wx->state);

[Severity: High]
Can the service timer come back after this teardown?

wxvf_suspend() does not set WX_STATE_DOWN, and it explicitly clears
WX_STATE_SERVICE_SCHED, so the only two gates in
wx_service_event_schedule() are both open:

wx_lib.c:wx_service_event_schedule() {
	if (!test_bit(WX_STATE_DOWN, wx->state) &&
	    !test_and_set_bit(WX_STATE_SERVICE_SCHED, wx->state))
		queue_work(system_power_efficient_wq, &wx->service_task);
}

If the service work is already running when suspend starts, the ordering
looks like:

  timer_delete_sync(&wx->service_timer);   /* timer now not pending */
  ... work still running:
      wxvf_service_task() -> wxvf_reset_subtask() -> wxvf_reinit_locked()
        -> wxvf_up_complete()
             mod_timer(&wx->service_timer, jiffies + HZ);
             clear_bit(WX_STATE_DOWN, wx->state);
  cancel_work_sync(&wx->service_task);     /* waits, but timer is pending */

Nothing deletes the timer after cancel_work_sync() returns, and
timer_delete_sync() (unlike timer_shutdown_sync()) does not prevent
re-arming. Suspend then frees the IRQs, rings and q_vectors and disables the
device, so when the surviving timer fires wxvf_service_task() can reach
wxvf_reinit_locked() -> wx_request_msix_irqs_vf():

wx_vf_common.c:wx_request_msix_irqs_vf() {
	err = request_irq(wx->msix_entry->vector, wx_msix_misc_vf,
			  0, netdev->name, wx);

wx->msix_entry was kfree()d and set to NULL by
wx_reset_interrupt_capability() inside wx_clear_interrupt_scheme() during
suspend, so is this a NULL dereference? wx_free_irq() on that path also
free_irq()s vectors that are already gone.

Note wxvf_shutdown() calls the same function, and timers keep running until
the machine actually restarts, so the >= HZ delay is easy to hit there too.

Would set_bit(WX_STATE_DOWN, wx->state) before the cancel, and
timer_shutdown_sync() instead of timer_delete_sync(), close this? Also, what
is the purpose of clearing WX_STATE_SERVICE_SCHED here, given that clearing
it re-opens the queueing gate?

> +
> +	rtnl_lock();
> +	netif_device_detach(netdev);
> +	if (netif_running(netdev)) {
> +		netif_tx_disable(netdev);
> +		netif_carrier_off(netdev);
> +		wx_napi_disable_all(wx);
> +		wx_free_irq(wx);
> +		wx_free_resources(wx);
> +	}
>  	wx_clear_interrupt_scheme(wx);
> +	pci_clear_master(pdev);
>  	pci_disable_device(pdev);
> +	rtnl_unlock();

[Severity: High]
Can the device DMA into the memory that wx_free_resources() just released?

Everything in the netif_running() branch is software-only work. With the
interface up, wx_configure_rx_ring_vf()/wx_configure_tx_ring_vf() have
programmed the ring DMA addresses and set the enable bits:

wx_vf_lib.c:wx_configure_rx_ring_vf() {
	wr32(wx, WX_VXRDBAL(reg_idx), rdba & DMA_BIT_MASK(32));
	wr32(wx, WX_VXRDBAH(reg_idx), rdba >> 32);
	...
	rxdctl |= WX_VXRXDCTL_ENABLE | WX_VXRXDCTL_VLAN;

The sequence that actually stops the VF engines is in wx_stop_adapter_vf()
(mask WX_VXIMS, clear WX_VXICR, WX_VXTXDCTL_FLUSH per Tx queue, clear
WX_VXRXDCTL_ENABLE per Rx queue), reachable via
wx_reset_vf() -> wx_reset_hw_vf(), and it is not called anywhere in
wxvf_suspend(). The only DMA quiesce present, pci_clear_master()/
pci_disable_device(), runs after wx_free_resources() has already
dma_free_coherent()d the descriptor rings and head-write-back buffer and
released the Rx page-pool pages.

If the PF is still forwarding frames to this VF in that window, are those
frames written into freed pages, with descriptor write-back into freed
coherent memory?

wxvf_close()/wxvf_down() use the opposite order:

wx_vf_common.c:wxvf_down() {
	wx_napi_disable_all(wx);
	wx_reset_vf(wx);

	wx_clean_all_tx_rings(wx);
	wx_clean_all_rx_rings(wx);

Should suspend do the same, i.e. reset/stop the adapter before freeing the
rings?

> @@ -34,12 +50,52 @@ int wxvf_resume(struct device *dev_d)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev_d);
>  	struct wx *wx = pci_get_drvdata(pdev);
> +	struct net_device *netdev;
> +	int err;
> +
> +	netdev = wx->netdev;
> +	err = pci_enable_device_mem(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "Cannot enable PCI device from suspend\n");
> +		return err;
> +	}
>  
>  	pci_set_master(pdev);
> -	wx_init_interrupt_scheme(wx);
> -	netif_device_attach(wx->netdev);
> +	rtnl_lock();
> +
> +	err = wx_init_interrupt_scheme(wx);
> +	if (err)
> +		goto err_pci;

[Severity: High]
Is bus mastering re-enabled too early here?

VFs frequently have no PCI PM capability, so on suspend-to-idle the function
may never leave D0 and comes back with WX_VXRXDCTL_ENABLE still set and
VXRDBAL/VXTDBAL still holding the addresses of the rings that wxvf_suspend()
freed. pci_set_master() then re-arms DMA against those stale addresses, and
nothing reprograms them until the deferred reset subtask runs, which cannot
happen before the service timer armed inside wxvf_up_complete() expires:

wx_vf_common.c:wxvf_up_complete() {
	netif_carrier_off(wx->netdev);
	mod_timer(&wx->service_timer, jiffies + HZ);

So is there a window of up to a second in which the device can DMA into
freed memory?

> +
> +	/* Since vf resume before than pf, only the vf interrupt and software
> +	 * resources need to be initialized. The hardware configuration will be
> +	 * reconfigured in reset subtask.
> +	 */
> +	if (netif_running(netdev)) {
> +		err = wx_setup_resources(wx);
> +		if (err)
> +			goto err_clear_int;
> +
> +		err = wx_request_msix_irqs_vf(wx);
> +		if (err)
> +			goto err_free_resources;
> +
> +		wxvf_up_complete(wx);

[Severity: High]
The comment says only "the vf interrupt and software resources" are
initialized, but wxvf_up_complete() writes WX_VXICR/WX_VXIMC, enables NAPI
and calls netif_tx_start_all_queues().

Both other callers configure the hardware first:

wx_vf_common.c:wxvf_open() {
	wx_configure_vf(wx);

	err = wx_request_msix_irqs_vf(wx);
	...
	wxvf_up_complete(wx);

wx_configure_vf() is the only code that writes the new VXRDBAL/H and
VXTDBAL/H, resets VXRDH/VXRDT and VXTDH/VXTDT and resyncs
next_to_use/next_to_clean with the hardware. On this path it is not called at
all before the queues are started.

If the function was reset by the power transition, does that leave the driver
transmitting on hardware queues that are disabled with zero base addresses
until the reset subtask runs, with wx_alloc_rx_buffers() ringing VXRDT and
the xmit path ringing VXTDT on queues the hardware does not have, plus the tx
watchdog running after netif_device_attach()?

[Severity: High]
Should this branch also re-publish the queue counts to the netdevice?

wxvf_suspend() -> wx_clear_interrupt_scheme() -> wx_free_q_vectors() zeroes
them:

wx_lib.c:wx_free_q_vectors() {
	wx->num_tx_queues = 0;
	wx->num_rx_queues = 0;
	wx->num_q_vectors = 0;

On resume, wx_init_interrupt_scheme() calls wx->set_num_queues(), which
starts from 1/1 and only raises the counts when the mailbox transaction
succeeds:

txgbevf_main.c:txgbevf_set_num_queues() {
	wx->num_rx_queues = 1;
	wx->num_tx_queues = 1;
	...
	ret = wx_get_queues_vf(wx, &num_tcs, &def_q);
	...
	if (ret)
		return;

Per the comment above, the VF resumes before the PF, so that request can
fail and leave one Tx ring. wxvf_open() publishes the counts, but this path
does not:

wx_vf_common.c:wxvf_open() {
	err = netif_set_real_num_tx_queues(netdev, wx->num_tx_queues);
	...
	err = netif_set_real_num_rx_queues(netdev, wx->num_rx_queues);

With netdev->real_num_tx_queues still at the pre-suspend value,
netif_tx_start_all_queues() starts all of the stale queues and they fold
onto one ring:

wx_lib.c:wx_xmit_frame() {
	if (r_idx >= wx->num_tx_queues)
		r_idx = r_idx % wx->num_tx_queues;
	tx_ring = wx->tx_ring[r_idx];

Can two CPUs then run wx_xmit_frame_ring() on the same tx_ring concurrently,
each holding a different __netif_tx_lock, and race on next_to_use /
next_to_clean and the BQL accounting? The deferred reset subtask calls
wx_configure_vf() but not set_num_queues() or netif_set_real_num_*_queues(),
so would this persist until an explicit down/up?

> +		set_bit(WX_FLAG_NEED_DO_RESET, wx->flags);
> +	}

[Severity: Medium]
This isn't a bug introduced by this patch, but setting WX_FLAG_NEED_DO_RESET
here makes wxvf_reinit_locked() part of every resume of a running interface,
and that function discards an error:

wx_vf_common.c:wxvf_reinit_locked() {
	wx_configure_vf(wx);
	wx_request_msix_irqs_vf(wx);
	wxvf_up_complete(wx);

On failure, wx_request_msix_irqs_vf() tears the interrupt capability down
before returning:

free_queue_irqs:
	while (vector) {
		vector--;
		free_irq(...);
	}
	wx_reset_interrupt_capability(wx);
	return err;

so wxvf_up_complete() then re-enables NAPI, unmasks VXIMC and starts all Tx
queues with no handlers installed and with wx->msix_entry left NULL. Would it
be worth checking the return value while touching this flow?

> +
> +	netif_device_attach(netdev);
> +	rtnl_unlock();

[Severity: Medium]
What restores the hardware when the interface was down at suspend time?

WX_FLAG_NEED_DO_RESET and the service timer re-arm both live inside the
netif_running() branch, so in the interface-down case no VF reset and no
PF/VF mailbox re-initialization happens after the power transition.
wx_reset_hw_vf() - which does the WX_VF_RESET handshake, resets
wx->vfinfo->vf_api to wx_mbox_api_null and re-establishes CTS/perm_addr and
mac.mc_filter_type - is reachable on the VF only from probe, wxvf_down() and
the wxvf_open() error path:

wx_vf_common.c:wxvf_open() {
	err = wx_setup_resources(wx);
	if (err)
		goto err_reset;
	wx_configure_vf(wx);
...
err_reset:
	wx_reset_vf(wx);

Two consequences: wx_init_interrupt_scheme() -> txgbevf_set_num_queues()
issues wx_get_queues_vf() on a mailbox that was not re-initialized and
silently falls back to one Rx/Tx queue, and a later "ip link set up" runs
wx_configure_vf() xcast-mode/mc-list/uc-list/rlpml requests with the stale
cached vf_api, discarding the errors.

For comparison, ixgbevf_resume() calls ixgbevf_reset() unconditionally right
after pci_set_master(). Should wxvf_resume() reset the VF regardless of
netif_running()?

>  
>  	return 0;
> +err_free_resources:
> +	wx_free_resources(wx);
> +err_clear_int:
> +	wx_clear_interrupt_scheme(wx);
> +err_pci:
> +	rtnl_unlock();
> +	pci_disable_device(pdev);
> +	return err;
>  }
>  EXPORT_SYMBOL(wxvf_resume);

[Severity: High]
Do these unwind paths leave the netdevice in a state the rest of the driver
can handle?

All three labels return without netif_device_attach() and without downing the
netdev, so __LINK_STATE_START stays set (netif_running() is true) while
__LINK_STATE_PRESENT stays clear, num_q_vectors/num_tx_queues/num_rx_queues
are 0, wx->msix_q_entries and wx->msix_entry have been kfree()d and NULLed by
wx_reset_interrupt_capability(), pdev->msix_enabled is 0, and the PCI device
is disabled.

An "ip link set down" afterwards is not gated by netif_device_present(), so
wxvf_close() -> wxvf_down() issues wx_reset_vf() mailbox/register accesses on
a device whose memory decoding was just disabled, and then:

wx_lib.c:wx_free_irq() {
	if (!(pdev->msix_enabled)) {
		if (!wx->misc_irq_domain)
			free_irq(pdev->irq, wx);
		return;
	}

wx->misc_irq_domain is false for VFs, so does this free_irq() an IRQ that was
never requested, giving the "Trying to free already-free IRQ" warning?

The interface also cannot be brought back up, since the device stays
detached:

net/core/dev.c:__dev_open() {
	if (!netif_device_present(dev)) {
		if (dev->dev.parent)
			pm_runtime_resume(dev->dev.parent);
		if (!netif_device_present(dev))
			return -ENODEV;
	}

And a second suspend would call pci_disable_device() on an already-disabled
device, driving enable_cnt negative.

The sibling PF drivers handle the "resources freed outside close()" case with
an explicit flag:

ngbe_main.c:ngbe_down_suspend() {
	if (test_and_set_bit(WX_STATE_RES_FREED, wx->state))
		return;
...
ngbe_close() {
	if (test_bit(WX_STATE_RES_FREED, wx->state))
		goto out;

Would something equivalent be appropriate here, together with setting
WX_STATE_DOWN in wxvf_suspend() so that the test_and_set_bit(WX_STATE_DOWN)
guard in wxvf_down() reflects the teardown suspend already performed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260829091423.83097-1-mengyuanlou%40net-swift.com
