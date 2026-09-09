Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6771568FA0
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987290; cv=none; b=K63QiVj4HLnADg+nwUvYtW53PdABOTbp3JQ+kFN/idGtbSwLIx0eInnVOVM2nzBeCqwYVRNERDaS2WHbNIIAGVL17NULdKfrca9mqqC5MDRuWtbaOPKxTIjtgzCnQgeMtBJxHSnwYJ8NcF6mhv4Pf5rynaZVfhmGXS8PXYwbRJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987290; c=relaxed/simple;
	bh=0PREt4IaqG3/qbC6GdqbP3+TkxujAuBYOc/AgWKP/fk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uLCP7aKlRfYKHEeutcsmHp8qeerJy1sN8wCDl8MqKiIlDwtQv/lNrN2P9c7MrtSgEDMmxPM+LDasfOVetW9pUnhxKX85WlO8bkSd0H1fFRh5nrKtbf9SNrK87v+b5ZE0XLGzCVXL7GiAR4rcQp1lU1aBk/Xm05S7BBeoUkVE3AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7zPJz7d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7zPJz7d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252EE1F000FF;
	Wed,  9 Sep 2026 20:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788987280;
	bh=zFjag1Q6Ns9F6neR/g/bSO9c1QrnelScUeoPMwneuGI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M7zPJz7deK9LRx5gFJ1H2Kxmyvk0Pe8QbKUfxlkV5njQMghkzkMRMSOQOPT/f0nqa
	 NoCAbLpWiG2jA/Q4XYRQa+rB8KqtRNFXRdvJ2JgYMNjJerPn8x1qKgSpe6tumwonPG
	 EEq60ktjmJKaCtMO6keTEnVrx4xfwA5FySOfYpIQrqJ5nqLxV5hDJ08nvur7CHC0BP
	 JWqFff0nA8F5O+Bdwbi8bMoUSMkGi4RFFbzmYbdv6HMVB+kE1e1cTvU1+0rtdA+1Ja
	 uNuxNp/Qr1DMn43ax5t0HuVFe29UPY5QZwe/AjwZrNeyciXKPO7Wv0eBFqZpFo/IXj
	 FmxAHxdyDEk8w==
Subject:
 Re: [PATCH net v3] net: libwx: fix PM suspend/resume flow for VF drivers
From: netdev-bot+sashiko@kernel.org
To: mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hramamurthy@google.com
Date: Wed, 09 Sep 2026 20:54:39 +0000
Message-ID: <178898727965.219967.3544026501287547381@kernel.org>
In-Reply-To: <20260904085216.43469-1-mengyuanlou@net-swift.com>
References: <20260904085216.43469-1-mengyuanlou@net-swift.com>
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
issue(s) to consider:

Critical: 0 · High: 3 · Medium: 5 · Low: 0

- [High] wxvf_resume() clears WX_STATE_DOWN (wx_vf_common.c:54) and
  returns success while the device has zero q_vectors, zero rings, no…
- [High] wxvf_resume()'s else branch (interface was administratively down
  at suspend time) only does pci_set_master() + netif_device_attach()…
- [High] wxvf_reopen_subtask() tests WX_FLAG_NEED_REOPEN *outside*
  rtnl_lock and then, after acquiring rtnl_lock, unconditionally…
- [Medium] The commit message advertises 'Provide error unwinding inside
  wxvf_reopen_subtask() if re-opening fails', but the unwinding does not…
- [Medium] The VF PM ops report a successful resume before the
  previously-running netdevice has been restored to an operational…
- [Medium] wxvf_suspend() frees the q_vectors
  (wx_clear_interrupt_scheme()) and calls…
- [Medium] wxvf_reopen_subtask() re-programs the VF Tx/Rx rings and
  mailbox-based configuration via wxvf_open() without any wx_reset_vf()…
- [Medium] wxvf_suspend() newly calls
  cancel_work_sync(&wx->service_task), which can cancel a work item that…

--

net: libwx: fix PM suspend/resume flow for VF drivers

This reworks the libwx VF PM callbacks so that wxvf_suspend() closes a
running interface with wxvf_close() before clearing bus mastering and
disabling the PCI device, and wxvf_resume() defers the rebuild to a new
service-task subtask gated by WX_FLAG_NEED_REOPEN.

A few questions about the new lifecycle handling below.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> index 26de78e9a69ef..3e55738e2096f 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> @@ -16,9 +16,16 @@ int wxvf_suspend(struct device *dev_d)
>  	struct pci_dev *pdev = to_pci_dev(dev_d);
>  	struct wx *wx = pci_get_drvdata(pdev);
>  
> +	rtnl_lock();
>  	netif_device_detach(wx->netdev);
> +	if (netif_running(wx->netdev))
> +		wxvf_close(wx->netdev);
>  	wx_clear_interrupt_scheme(wx);
> +	pci_clear_master(pdev);
>  	pci_disable_device(pdev);
> +	rtnl_unlock();
> +	timer_delete_sync(&wx->service_timer);

[Severity: Medium]
Is it safe to free the q_vectors and disable the PCI function before the
service timer and work are quiesced?

wx_service_timer() re-arms and queues the work while the interface is up:

	mod_timer(&wx->service_timer, next_event_offset + jiffies);

	wx_service_event_schedule(wx);

wxvf_link_config_subtask() runs without rtnl, so the rtnl_lock() taken
here does not exclude it, and the new gate added in this patch is a plain
read:

	if (test_bit(WX_STATE_DOWN, wx->state))
		return;

	wxvf_watchdog_update_link(wx);

A worker that passes that test just before wxvf_down() sets the bit
continues into wx_check_mac_link_vf() while suspend is running
wxvf_close() -> wxvf_down() -> wx_reset_vf().  wx_reset_hw_vf() issues its
wx_mbx_write_and_read_reply() without taking wx->mbx.mbx_lock, while
wxvf_watchdog_update_link() does take it, so the two mailbox users are not
mutually excluded against the WX_VXCTRL_RST self-reset and
wx_virt_clr_reg().

Would moving timer_delete_sync()/cancel_work_sync() ahead of
wx_clear_interrupt_scheme() and pci_disable_device() close this window?

> +	cancel_work_sync(&wx->service_task);

[Severity: Medium]
Can WX_STATE_SERVICE_SCHED get stuck here?

cancel_work_sync() on a work item that was queued but has not started
skips the callback, so wx_service_event_complete() - the only place that
clears WX_STATE_SERVICE_SCHED - never runs.  wxvf_resume() clears that bit
only in the netif_running() branch, so if the interface was administratively
down at suspend time the bit survives and wx_service_event_schedule() never
queues work again:

	if (!test_bit(WX_STATE_DOWN, wx->state) &&
	    !test_and_set_bit(WX_STATE_SERVICE_SCHED, wx->state))
		queue_work(system_power_efficient_wq, &wx->service_task);

Since wxvf_up_complete() leaves the carrier off and relies on the service
task to report link up, a later "ip link set dev X up" would then never
report carrier.  Should the clear_bit(WX_STATE_SERVICE_SCHED, wx->state)
be unconditional next to the new cancel_work_sync()?

>  
>  	return 0;
>  }
> @@ -34,11 +41,25 @@ int wxvf_resume(struct device *dev_d)
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
>  
> +	rtnl_lock();
> +	if (netif_running(wx->netdev)) {
> +		clear_bit(WX_STATE_DOWN, wx->state);
> +		clear_bit(WX_STATE_SERVICE_SCHED, wx->state);
> +		mod_timer(&wx->service_timer, jiffies + HZ);
> +		set_bit(WX_FLAG_NEED_REOPEN, wx->flags);

[Severity: High]
Should WX_STATE_DOWN be cleared here, a second or more before anything is
re-allocated?

At this point wxvf_suspend() has already run wxvf_close() and
wx_clear_interrupt_scheme(), so there are no q_vectors, no rings, no
requested IRQs and no bus mastering.  The rebuild only happens once
wxvf_reopen_subtask() runs, which cannot be before the service timer
expires.

netif_running() is still true because wxvf_close() was called directly
rather than through dev_close(), so __LINK_STATE_START was never cleared.
An "ip link set dev X down" inside that window reaches
ndo_stop == wxvf_close(), and the idempotency guard in wxvf_down() no
longer short-circuits because the bit was just cleared:

	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
		return;

	timer_delete_sync(&wx->service_timer);

so the whole teardown runs a second time.  Doesn't that mean:

- wx_reset_vf() drives MMIO and mailbox traffic on a function whose bus
  mastering was cleared,

- the timer_delete_sync() above removes the only trigger for the pending
  WX_FLAG_NEED_REOPEN, so the netdev stays netif_device_detach()ed and
  __dev_open() keeps returning -ENODEV for good,

- wx_free_irq() takes its non-MSI-X branch, with wx->misc_irq_domain false
  for VFs and pdev->irq forced to 0 for VFs by pci_read_irq():

	if (!(pdev->msix_enabled)) {
		if (!wx->misc_irq_domain)
			free_irq(pdev->irq, wx);
		return;
	}

  which lands in WARN(1, "Trying to free already-free IRQ %d")?

Would keeping WX_STATE_DOWN set until wxvf_reopen_subtask() has actually
completed avoid all three?

> +	} else {
> +		pci_set_master(pdev);
> +		netif_device_attach(wx->netdev);
> +	}

[Severity: High]
The else branch drops the wx_init_interrupt_scheme() call that the old
unconditional code provided, but wxvf_suspend() still calls
wx_clear_interrupt_scheme() unconditionally.

For a VF, MSI-X is the only mode, so wx_reset_interrupt_capability()
always runs:

	kfree(wx->msix_q_entries);
	wx->msix_q_entries = NULL;
	kfree(wx->msix_entry);
	wx->msix_entry = NULL;

and wx_free_q_vectors() zeroes num_q_vectors, num_tx_queues and
num_rx_queues.  Nothing on this path rebuilds any of that, while
netif_device_attach() makes the next "ip link set dev X up" succeed into
ndo_open == wxvf_open().

With num_q_vectors == 0, does wx_request_msix_irqs_vf() skip its per-queue
loop entirely and then dereference the NULL msix_entry?

	for (vector = 0; vector < wx->num_q_vectors; vector++) {
		...
	}

	err = request_irq(wx->msix_entry->vector, wx_msix_misc_vf,
			  0, netdev->name, wx);

The sibling ngbe_resume() restores the interrupt scheme unconditionally
and only conditionalizes the open:

	err = wx_init_interrupt_scheme(wx);
	if (!err && netif_running(netdev))
		err = ngbe_open(netdev);
	if (!err)
		netif_device_attach(netdev);

> +	rtnl_unlock();
>  	return 0;
>  }
>  EXPORT_SYMBOL(wxvf_resume);

[Severity: Medium]
Returning 0 here reports a completed resume while a previously running
interface still has no rings, no IRQs and no bus mastering for at least
the one second until the service timer fires, so traffic is silently
dropped in that window.

DEFINE_SIMPLE_DEV_PM_OPS in ngbevf_main.c and txgbevf_main.c installs
wxvf_resume() as .resume, .thaw and .restore, and neither pm_ops has a
.complete callback, so nothing forces wxvf_reopen_subtask() to finish
before the PM transition ends and any failure it hits can only be logged
after the PM core has already seen success.

Is deferring the restore preferable to performing it synchronously in the
callback, the way ngbe_resume() does?

[ ... ]

> @@ -403,10 +427,37 @@ static void wxvf_link_config_subtask(struct wx *wx)
>  	}
>  }
>  
> +static void wxvf_reopen_subtask(struct wx *wx)
> +{
> +	if (!test_bit(WX_FLAG_NEED_REOPEN, wx->flags))
> +		return;
> +
> +	rtnl_lock();

[Severity: High]
The flag is tested before rtnl_lock() and nothing is re-validated once the
lock is held.  No path (wxvf_close(), wxvf_suspend(), wxvf_remove()) ever
clears WX_FLAG_NEED_REOPEN, and cancel_work_sync() can only wait for an
already executing work item.

Since dev_close(), wxvf_suspend() and unregister_netdev() all hold rtnl,
can this worker sit blocked in rtnl_lock() across the transition and then
reopen afterwards?

wxvf_suspend()
	rtnl_lock();
	... wxvf_close(), wx_clear_interrupt_scheme(), pci_disable_device()
	rtnl_unlock();
	cancel_work_sync(&wx->service_task);	/* only waits */

wxvf_reopen_subtask()	/* was blocked in rtnl_lock() */
	pci_set_master(wx->pdev);
	wx_init_interrupt_scheme(wx);
	wxvf_open(wx->netdev);

That re-enables bus mastering, MSI-X and DMA on the function that was just
disabled.  The wxvf_remove() case looks worse:

	unregister_netdev(netdev);
	timer_shutdown_sync(&wx->service_timer);
	cancel_work_sync(&wx->service_task);
	...
	wx_clear_interrupt_scheme(wx);

unregister_netdev() holds rtnl while calling ndo_stop, so the blocked
worker reopens after it, and wx_clear_interrupt_scheme() then frees the
q_vectors that the late reopen registered as IRQ dev_id:

	wx->q_vector[v_idx] = NULL;
	netif_napi_del(&q_vector->napi);
	kfree_rcu(q_vector, rcu);

Remove never calls wx_free_irq() or wx_free_resources(), so do the
handlers stay registered against freed q_vectors, with the DMA rings
leaked and the device still bus-mastering?

wx_io_resume() in the same library and ngbe_resume() both re-check
netif_running() under rtnl before reopening.  Would re-testing the flag
and netif_running()/netif_device_present() under rtnl here, plus clearing
WX_FLAG_NEED_REOPEN in close/suspend/remove before dropping rtnl, be
enough?

> +	pci_set_master(wx->pdev);
> +	if (wx_init_interrupt_scheme(wx))
> +		goto out;
> +	if (wxvf_open(wx->netdev))
> +		goto out_clear_scheme;

[Severity: Medium]
Should this path reset the VF before reprogramming it?

The last reset was wxvf_close() -> wxvf_down() -> wx_reset_vf(), which ran
before pci_disable_device() and the low-power transition.  Coming back,
wxvf_open() reprograms the rings and issues mailbox configuration without
redoing the sequence in wx_reset_hw_vf():

	wx->vfinfo->vf_api = wx_mbox_api_null;
	...
	wr32m(wx, WX_VXCTRL, WX_VXCTRL_RST, WX_VXCTRL_RST);
	...
	if (wx->mac.type == wx_mac_aml || wx->mac.type == wx_mac_aml40)
		wr32(wx, WX_VX_PF_BME, WX_VF_BME_ENABLE);
	...
	wx_virt_clr_reg(wx);
	mbx->timeout = 2000;
	ret = wx_mbx_write_and_read_reply(wx, msgbuf, msgbuf, ARRAY_SIZE(msgbuf));

So the WX_VF_RESET handshake is not redone, the API version is not
renegotiated, and on aml/aml40 parts WX_VX_PF_BME is not re-armed.  Since
wx_set_rx_mode_vf() ignores its return values and wx_configure_rx_vf()
only wx_dbg()s an RLPML failure, would silently NACKed configuration go
unnoticed here?

ngbe_resume() calls ngbe_reset_hw() before wx_init_interrupt_scheme() and
ngbe_open(), and ixgbevf_resume() calls ixgbevf_reset() before
ixgbevf_init_interrupt_scheme()/ixgbevf_open().

> +	clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
> +	netif_device_attach(wx->netdev);
> +	rtnl_unlock();
> +	return;
> +
> +out_clear_scheme:
> +	wx_clear_interrupt_scheme(wx);
> +out:
> +	pci_clear_master(wx->pdev);
> +	clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
> +	set_bit(WX_STATE_DOWN, wx->state);
> +	rtnl_unlock();
> +	dev_err(&wx->pdev->dev, "Failed to reopen device\n");
> +}

[Severity: Medium]
The commit message says "Provide error unwinding inside
wxvf_reopen_subtask() if re-opening fails".  Does this unwinding leave a
recoverable device?

netif_device_attach() is only reached on the success path, and
wxvf_suspend() already did netif_device_detach(), so __LINK_STATE_PRESENT
stays clear and __dev_open() returns -ENODEV:

	if (!netif_device_present(dev)) {
		if (dev->dev.parent)
			pm_runtime_resume(dev->dev.parent);
		if (!netif_device_present(dev))
			return -ENODEV;
	}

WX_FLAG_NEED_REOPEN is cleared here, and setting WX_STATE_DOWN also stops
wx_service_event_schedule() from ever queueing the service task again:

	if (!test_bit(WX_STATE_DOWN, wx->state) &&
	    !test_and_set_bit(WX_STATE_SERVICE_SCHED, wx->state))
		queue_work(system_power_efficient_wq, &wx->service_task);

so nothing retries, and wxvf_resume() already returned 0 so the PM core
never learns about the failure.  After one transient allocation or
request_irq() failure at resume, is the interface unusable until driver
unbind/rebind?  netif_running() also stays true with all rings, IRQs and
q_vectors freed, which feeds back into the wx_free_irq() concern noted
above.

>  
>  static void wxvf_service_task(struct work_struct *work)
>  {
>  	struct wx *wx = container_of(work, struct wx, service_task);
>  
> +	wxvf_reopen_subtask(wx);
>  	wxvf_link_config_subtask(wx);
>  	wxvf_reset_subtask(wx);
>  	wx_service_event_complete(wx);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904085216.43469-1-mengyuanlou%40net-swift.com
