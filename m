Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD042BEA5
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799459; cv=none; b=psdl94xlGclAZE9L3evpQFt31p04ibVnFeS7Ra4YmipWdVvzYYNZkiPcl6iC1E+jYNf3/GEAgAhay3GT6i2/W+6Jr6JtSvvKP+NJP/8GmFfLRWHOZ8WJMpQ9triYeg30aMYVvwW+N9gwtqLc2FZODfSvne/nSSOlES355j5IE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799459; c=relaxed/simple;
	bh=uuroRO3PQNvIm4FISD9zq0ejBx0YM6M5SFjXrwLtniQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCiWkuIPJnsvnCnaGXXKwwLzNuuK5eTVrhggCX2FAg8iTErSuhLO4vqlRygpD00h+XpJH0vlfjnjlsYxy6T1XXlsatOKtZKNLHmgEywrxJkWVaC9fzcR/pkdNNPJtCvGGR16GpOSYiIa492iwO2z3YlJyG4jQUMVy3+R1YIVc3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIGuOm0T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIGuOm0T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B751F000E9;
	Thu, 23 Jul 2026 09:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784799456;
	bh=OxVk2+UVVLIVG8MOOK8n1Qk98G/VcJJx7+xhyJUmySQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nIGuOm0Tg3f+CtN29aoHhYMXP5ti0x1rKAOPXFEXWWjtYEchoeKUZkf5HKqItal1T
	 ffLGF7BvvnVj61D3XscEiVHnVLiXXeC6WlgLqGsHs6KXwnj8+U4U2I3KOqmj+FBCHk
	 3G8KUCFYe3gc1HNBT0wOjVk1HLWuXsWYl5DI2GedlZQWnDSpMP6ICwREyLUnoH1EjH
	 dLyB00yN27O/dwWmHrel4In1c2Ro1qxLt12fcCXo2/pT8/1zRFTOSaTb+pcZa4QTGi
	 0ptcAkJWizXXQCpgOJG1Di1W9Y7w/VLLH1OWXz1/6KNsXvzyvheRmvEYli2vK7VmKh
	 CclwGiTmxIuhA==
Date: Thu, 23 Jul 2026 10:37:22 +0100
From: Simon Horman <horms@kernel.org>
To: jiawenwu@trustnetic.com
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
	linux@armlinux.org.uk, aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com, michal.swiatkowski@linux.intel.com,
	kees@kernel.org, larysa.zaremba@intel.com, leitao@debian.org,
	joe@dama.to, u.kleine-koenig@baylibre.com, weirongguang@kylinos.cn,
	fabio.baltieri@gmail.com
Subject: Re: [PATCH net-next v11 5/5] net: wangxun: add pcie error handler
Message-ID: <20260723093722.GF418547@horms.kernel.org>
References: <20260716073822.24356-6-jiawenwu@trustnetic.com>
 <20260723091639.574355-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260723091639.574355-2-horms@kernel.org>

On Thu, Jul 23, 2026 at 10:16:39AM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260716073822.24356-2-jiawenwu@trustnetic.com?part=5

Hi Jiawen,

I'm very sorry but my previous email was supposed to come with some
commentary. Somehow it vanished between entering it and the email being
dispatched.

Firstly, thanks for your updates since v4. Sashiko has still managed
to flag some issues in v5. For the other patches of the series, 1/4 - 1/5,
these all seem to have been rated as low or medium. So while I'd appreciate
it if you could look over them, I'm only forwarding this review which
has some more critical items.

> ---
> Subject: net: wangxun: add pcie error handler
> 
> This patch wires up pci_error_handlers callbacks (error_detected,
> slot_reset, resume) for the ngbe and txgbe drivers, adds a
> WX_FLAG_NEED_PCIE_RECOVERY flag plus a down_suspend op, and routes
> ndo_tx_timeout through a check that inspects config space and defers
> to the AER path when the device looks disconnected.
> 
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > index ee27f96735dc..0cb99e456a1c 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > @@ -4,11 +4,120 @@
> >
> >  #include <linux/netdevice.h>
> >  #include <linux/pci.h>
> > +#include <linux/aer.h>
> >
> >  #include "wx_type.h"
> >  #include "wx_lib.h"
> >  #include "wx_err.h"
> >
> > +/**
> > + * wx_io_error_detected - called when PCI error is detected
> > + * @pdev: Pointer to PCI device
> > + * @state: The current pci connection state
> > + *
> > + * Return: pci_ers_result_t.
> > + *
> > + * This function is called after a PCI bus error affecting
> > + * this device has been detected.
> > + */
> > +static pci_ers_result_t wx_io_error_detected(struct pci_dev *pdev,
> > +					     pci_channel_state_t state)
> > +{
> > +	struct wx *wx = pci_get_drvdata(pdev);
> > +	struct net_device *netdev;
> > +
> > +	if (!wx)
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +
> > +	netdev = wx->netdev;
> > +	if (!netif_device_present(netdev))
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +
> > +	if (state == pci_channel_io_perm_failure)
> > +		return PCI_ERS_RESULT_DISCONNECT;
> 
> [High]
> Should the pci_channel_io_perm_failure branch perform teardown before
> returning?  In this branch the device is guaranteed gone forever, yet no
> netif_device_detach(), wx_soft_quiesce(), or pci_disable_device() runs.
> 
> The service_timer keeps firing every couple of seconds and
> wx_check_hang_subtask()/wx_update_stats() will keep doing MMIO reads
> against the disconnected device.  On arm64 an MMIO to a disconnected
> device raises a synchronous external abort.  TX queues are also still up
> and will keep taking skbs through ndo_start_xmit until remove() runs.
> 
> Compare with ixgbe_io_error_detected() in
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c, which performs
> rtnl_lock/netif_device_detach/ixgbe_close_suspend before the
> perm_failure check.  Would applying the same ordering here work?
> 
> > +
> > +	rtnl_lock();
> > +	netif_device_detach(netdev);
> > +	set_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
> > +	wx_soft_quiesce(wx);
> > +
> > +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> > +		pci_disable_device(pdev);
> > +	rtnl_unlock();
> > +
> > +	/* Request a slot reset. */
> > +	return PCI_ERS_RESULT_NEED_RESET;
> > +}
> > +
> > +/**
> > + * wx_io_slot_reset - called after the pci bus has been reset.
> > + * @pdev: Pointer to PCI device
> > + *
> > + * Return: pci_ers_result_t.
> > + *
> > + * Restart the card from scratch, as if from a cold-boot.
> > + */
> > +static pci_ers_result_t wx_io_slot_reset(struct pci_dev *pdev)
> > +{
> > +	struct wx *wx = pci_get_drvdata(pdev);
> > +
> > +	if (pci_enable_device_mem(pdev)) {
> > +		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +	}
> 
> [Medium, Low]
> When pci_enable_device_mem() fails here, does wx_io_slot_reset() need to
> unwind the state set up by wx_io_error_detected()?  WX_STATE_DISABLED,
> WX_STATE_DOWN (via wx_soft_quiesce), and WX_FLAG_NEED_PCIE_RECOVERY all
> remain latched because the clear_bit() calls further down are never
> reached.
> 
> If remove() runs later, ngbe_close()/txgbe_close() reach
> ngbe_down()/txgbe_down() and call ngbe_disable_device()/
> txgbe_disable_device(), which do:
> 
>     if (test_and_set_bit(WX_STATE_DOWN, wx->state))
>         return;
> 
> so the queue/ring disable MMIO sequence is skipped.  Similarly
> ngbe_reset()/txgbe_reset() early-return on WX_FLAG_NEED_PCIE_RECOVERY,
> so wx_flush_sw_mac_table() and related MAC cleanup is skipped.  Is that
> intended?

Simon says: The issue below seems to be a suggested clean-up.
            I don't think it needs to impede progress of this patch-set.

> Separately, wx_err(wx, ...) here expands to
> dev_err(&(wx)->pdev->dev, ...) and dereferences wx unconditionally,
> while wx_io_error_detected() explicitly guards with
> if (!wx) return PCI_ERS_RESULT_DISCONNECT.  Should the three callbacks
> be consistent — either the guard in error_detected is dead code, or
> slot_reset and resume are missing an intended check?
> 
> > +
> > +	/* make all memory operations done before clearing the flag */
> > +	smp_mb__before_atomic();
> > +	clear_bit(WX_STATE_DISABLED, wx->state);
> > +	clear_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
> > +	pci_set_master(pdev);
> > +	pci_restore_state(pdev);
> > +	pci_wake_from_d3(pdev, false);
> > +
> > +	rtnl_lock();
> > +	if (netif_running(wx->netdev) && wx->down_suspend)
> > +		wx->down_suspend(wx);
> > +	if (wx->do_reset)
> > +		wx->do_reset(wx->netdev, false);
> > +	rtnl_unlock();
> > +
> > +	return PCI_ERS_RESULT_RECOVERED;
> > +}
> > +
> > +/**
> > + * wx_io_resume - called when traffic can start flowing again.
> > + * @pdev: Pointer to PCI device
> > + *
> > + * This callback is called when the error recovery driver tells us that
> > + * its OK to resume normal operation.
> > + */
> > +static void wx_io_resume(struct pci_dev *pdev)
> > +{
> > +	struct wx *wx = pci_get_drvdata(pdev);
> > +	struct net_device *netdev;
> > +	int err;
> > +
> > +	netdev = wx->netdev;
> > +	rtnl_lock();
> > +	if (netif_running(netdev)) {
> > +		err = netdev->netdev_ops->ndo_open(netdev);
> > +		if (err) {
> > +			wx_err(wx, "Failed to open netdev after reset\n");
> > +			goto out;
> > +		}
> > +	}
> > +	netif_device_attach(netdev);
> > +out:
> > +	rtnl_unlock();
> > +}

Simon says: I believe the issue was already discussed in the review of v10.
            And we can pass on it going forward.

> [High]
> When ndo_open() fails in wx_io_resume(), the "out" path drops the rtnl
> and returns without calling netif_device_attach(), without clearing
> WX_STATE_DOWN, and without clearing WX_STATE_RES_FREED.
> 
> Because wx_io_error_detected() only cleared __LINK_STATE_PRESENT via
> netif_device_detach(), __LINK_STATE_START is still set, so
> netif_running() continues to return true.  WX_STATE_DOWN and
> WX_STATE_RES_FREED (set earlier in the AER cycle by wx_soft_quiesce()
> and down_suspend()) are only cleared inside ngbe_up_complete() /
> txgbe_up_complete(), which are only reached if ndo_open() runs to
> completion.
> 
> If open fails partway (wx_setup_resources, request_irq,
> phylink_connect_phy, ...), the netdev is left detached but "running"
> with WX_STATE_DOWN and WX_STATE_RES_FREED latched.  A subsequent
> userspace "ip link set eth0 down" then hits the new short-circuit
> early in ngbe_close()/txgbe_close():
> 
>     if (test_bit(WX_STATE_RES_FREED, wx->state))
>         goto out;
>     ...
>     out:
>         wx_control_hw(wx, false);
> 
> Since ->resume returns void, there is no way to inform the AER core.
> Is there a recovery path other than unbind/rebind if ndo_open() fails
> here?
> 
> > +
> > +const struct pci_error_handlers wx_err_handler = {
> > +	.error_detected = wx_io_error_detected,
> > +	.slot_reset = wx_io_slot_reset,
> > +	.resume = wx_io_resume,
> > +};
> > +EXPORT_SYMBOL(wx_err_handler);
> > +
> 
> [ ... ]
> 
> > @@ -139,6 +251,33 @@ void wx_check_hang_subtask(struct wx *wx)
> >  }
> >  EXPORT_SYMBOL(wx_check_hang_subtask);
> >
> > +static bool wx_check_pcie_error(struct wx *wx)
> > +{
> > +	u16 vid, pci_cmd;
> > +
> > +	pci_read_config_word(wx->pdev, PCI_VENDOR_ID, &vid);
> > +	pci_read_config_word(wx->pdev, PCI_COMMAND, &pci_cmd);
> > +
> > +	/* PCIe link loss or memory space can't access */
> > +	if (vid == U16_MAX || !(pci_cmd & PCI_COMMAND_MEMORY))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static void wx_tx_timeout_recovery(struct wx *wx)
> > +{
> > +	/*
> > +	 * When a PCIe hardware error occurs, the driver should initiate a PCIe
> > +	 * recovery mechanism. However, this recovery flow relies on the AER
> > +	 * driver for current kernel policy. Therefore, a self-contained
> > +	 * recovery mechanism is not implemented yet.
> > +	 */
> > +	set_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
> > +	wx_err(wx, "PCIe error detected during tx timeout\n");
> > +	queue_work(wx->reset_wq, &wx->reset_task);
> > +}
> 
> [Medium]
> What happens on a platform where AER never fires (AER disabled at boot,
> firmware masks the event, or CONFIG_PCIEAER=n)?
> 
> wx_tx_timeout_recovery() only sets WX_FLAG_NEED_PCIE_RECOVERY and
> queues reset_task.  WX_FLAG_NEED_PCIE_RECOVERY is only cleared in
> wx_io_slot_reset(), so without AER the flag latches.
> 
> wx_reset_task() then does:
> 
>     rtnl_lock();
>     if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
>         wx_soft_quiesce(wx);           /* sets WX_STATE_DOWN */
>     if (test_bit(WX_STATE_DOWN, wx->state) ||
>         test_bit(WX_STATE_RESETTING, wx->state))
>         goto out;                      /* always taken now */
>     wx_pf_reset_subtask(wx);           /* checks a different flag */
> 
> and ngbe_reset()/txgbe_reset() early-return on
> WX_FLAG_NEED_PCIE_RECOVERY, so any future reset is a silent no-op.  Is
> there an intended fallback recovery when AER is unavailable, or is the
> interface expected to stay unusable until reboot?  The comment
> acknowledges "a self-contained recovery mechanism is not implemented
> yet" — should this be gated on IS_ENABLED(CONFIG_PCIEAER) or similar?
> 
> > +
> >  static void wx_tx_timeout_reset(struct wx *wx)
> >  {
> >  	if (test_bit(WX_STATE_DOWN, wx->state))
> > @@ -153,7 +292,10 @@ void wx_tx_timeout(struct net_device *netdev, unsigned int __always_unused txque
> >  {
> >  	struct wx *wx = netdev_priv(netdev);
> >
> > -	wx_tx_timeout_reset(wx);
> > +	if (wx_check_pcie_error(wx))
> > +		wx_tx_timeout_recovery(wx);
> > +	else
> > +		wx_tx_timeout_reset(wx);
> >  }
> >  EXPORT_SYMBOL(wx_tx_timeout);
> 
> [ ... ]

Separately, the following issue was flagged in the AI-generated review
on sashiko.dev [1]. I am concerned that it is exacerbated by this patch
in the case where an AER recovery occurs and the module is subsequently
removed without the device being opened.

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index 7a05661b1d802..499f48619f000 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
[ ... ]
> @@ -989,7 +1014,8 @@ static void txgbe_remove(struct pci_dev *pdev)
>  	kfree(wx->mac_table);
>  	wx_clear_interrupt_scheme(wx);
>  
> -	pci_disable_device(pdev);
> +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> +		pci_disable_device(pdev);
>  }
This isn't a bug introduced by this patch, but does unloading the module
without bringing the interface up cause memory corruption?
In txgbe_remove() (just above this hunk), wx_free_isb_resources() is called
unconditionally during module removal.
drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_free_isb_resources() {
	...
	dma_free_coherent(&pdev->dev, sizeof(u32) * 4,
			  wx->isb_mem, wx->isb_dma);
	wx->isb_mem = NULL;
}
If the interface is never opened, wx->isb_mem remains NULL. Passing a NULL
virtual address and 0 DMA handle to dma_free_coherent() can bypass normal NULL
checks and free physical page 0, potentially causing silent memory corruption
or panics. 
Should there be a NULL check before calling dma_free_coherent()?

[1] https://sashiko.dev/#/patchset/20260716073822.24356-1-jiawenwu%40trustnetic.com?part=5
