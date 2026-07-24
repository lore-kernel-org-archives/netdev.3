Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44534F255
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 02:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784861574; cv=none; b=MT+ixgR2MNz6AOSohX1e5C+oq00Q6Suc/eckepmnbhvvh8XYF5gua4DrpiPAAjcFnGqF4/HWgmbCaTpiSAnnHGB5Y+50HL2GuzHjNM2m11xMS0fv4s9fvmNFLUkRhZ9UwpuPNUQ9WLJXuPw18ej+xp0xk9lomhKPLfd7jBtcFJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784861574; c=relaxed/simple;
	bh=GBrlAKyjqx4raJKP+g095xfJSqXY/jCcMe+xXcyq8Xw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=BsBzdayR/wKDsCsdurt6vKiYnnLYmXHRXbuO9vq26yrh3tz5D2alzecnHm/TdhHbEgfbKuVknkQMitO4eunx42rxzPgPnEagwEj2UcdH0dr9zKlApZl9Yzx02kv8vAyFO7AhfKGLNohWQCOHBBZTfnPIS5+gt+CbPfvbtQcDCoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:ivesync10t1784861490t6488a3ba
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.227.112.172])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 12921411429093780474
To: "'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<aleksandr.loktionov@intel.com>,
	<jacob.e.keller@intel.com>,
	<michal.swiatkowski@linux.intel.com>,
	<kees@kernel.org>,
	<larysa.zaremba@intel.com>,
	<leitao@debian.org>,
	<joe@dama.to>,
	<u.kleine-koenig@baylibre.com>,
	<weirongguang@kylinos.cn>,
	<fabio.baltieri@gmail.com>
References: <20260716073822.24356-6-jiawenwu@trustnetic.com> <20260723091639.574355-2-horms@kernel.org> <20260723093722.GF418547@horms.kernel.org>
In-Reply-To: <20260723093722.GF418547@horms.kernel.org>
Subject: RE: [PATCH net-next v11 5/5] net: wangxun: add pcie error handler
Date: Fri, 24 Jul 2026 10:51:29 +0800
Message-ID: <026701dd1b17$53f64870$fbe2d950$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJ1iHGNSt0ya3g5xz6atkL6TxAqaQGLmvi9ApbZMcq1KgTjgA==
X-QQ-SENDSIZE: 520
Feedback-ID: ivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MOBA+Vr+J4DzvD4FhaWC+5DggyL3wz/vLK59pcIGXRMNkPISsmo+GkAw
	JcyG01bSa8XpWhA6vNv6sGeb9kLt3VEnyST10QGaQecNS0wNMx3b3K04eLkaPWADbcL0Gyg
	xeHQamn+ovWjmjPMo59slWeBkU6RsGxX7ASTSoHN2Z0yGKUjJdI2LuimoLbkFqoXVAs0fQh
	z4UXrRr17mHDDGbkSBrNFcsAXT3mMCQ9EW8q8QoVZRxzBCbuVY3gtIohr5ANHjO4xWARPSN
	HQ0S0NmX9Jm3YT91emC5xMGlloqYnOLojcya6UALBt2nG5prkqbTZZSuzF2Suf7HI3KZYH0
	rKzlYHQ3VWcgAXpZ7pt9d6yWZXD7i3OfK0FElH/rvOlycDU3pFMpsXbzlPqToRbNOdSr+Gy
	5o7lCJEbwL90bF72jYty1u1og3ACGEdWgaMCZCs/QkwHnosyl9NhlG6latkEqn9RwOS1uoD
	3uVKZJrsC4nQ3AeGC7BG7FcBVearY/qVW/qk1Wme/yIrERD7ZbG5H0qEL7pMfArpcZRlRZV
	hi9HDjtdG3Rgb8jDm6Dx958TzPo7a2X5W1M2v1+mHiV/dPPEUj5VubyW2MNWLAeaT1XmXKd
	XIHFCdDPEN//oBXSBOgABUCtBEXctDYHbgSxOX3Lc90M3owamb4650f3e261njc3Ikh70hF
	zzO5PlaHtbkJWy/8ezJDT3IqEw8yZs2DOU4eCjgxO1+yAZBcJT8WsozOeg174CiS4mpj3lv
	RkByBudmMnwbh/acmSkzgJj1E7nFdWs4ZKYTRNU1J7zrdAdt0PFKKvhA9byLamS06d4PqPf
	iyDA/nP+s+ZTtaGkdafG2QPw06QR8RQqbKIVdB3xLmycq//tctG4CLBRS7MJl99mvz/lhCA
	CIjxhCeZIUQ6QqhWgc0Zm+EqNzyYLF5oDp0V+C6g8ic8bN4hvBQ03LSpd9DK7IlEcqXJi2e
	PsojAKIEFWlTP5SkVSGy4djcHJkQ91lDWrpVn9ENF+hqhWbYGI9OFHZxKtqhlwiXSldiL7w
	+3aq3A1ZficwGPvtaGU/bQhaYIMUJUe7E97dXnPV1DtWzuGBBjv0favoLtkF3hGWR/eu5Fu
	lM7AefSQicaSyOfh2WxPWd/TrbLnMo46FiZnbfqu63u
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

On Thu, Jul 23, 2026 5:37 PM, Simon Horman wrote:
> On Thu, Jul 23, 2026 at 10:16:39AM +0100, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > =
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260716073822.24356-=
2-jiawenwu@trustnetic.com?part=3D5
>=20
> Hi Jiawen,
>=20
> I'm very sorry but my previous email was supposed to come with some
> commentary. Somehow it vanished between entering it and the email =
being
> dispatched.
>=20
> Firstly, thanks for your updates since v4. Sashiko has still managed
> to flag some issues in v5. For the other patches of the series, 1/4 - =
1/5,
> these all seem to have been rated as low or medium. So while I'd =
appreciate
> it if you could look over them, I'm only forwarding this review which
> has some more critical items.

Thanks Simon, I didn't see this email before my last reply. My =
clarification in
that reply may seem redundant. Here is my updated reply.

>=20
> > ---
> > Subject: net: wangxun: add pcie error handler
> >
> > This patch wires up pci_error_handlers callbacks (error_detected,
> > slot_reset, resume) for the ngbe and txgbe drivers, adds a
> > WX_FLAG_NEED_PCIE_RECOVERY flag plus a down_suspend op, and routes
> > ndo_tx_timeout through a check that inspects config space and defers
> > to the AER path when the device looks disconnected.
> >
> > > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c =
b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > > index ee27f96735dc..0cb99e456a1c 100644
> > > --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > > +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> > > @@ -4,11 +4,120 @@
> > >
> > >  #include <linux/netdevice.h>
> > >  #include <linux/pci.h>
> > > +#include <linux/aer.h>
> > >
> > >  #include "wx_type.h"
> > >  #include "wx_lib.h"
> > >  #include "wx_err.h"
> > >
> > > +/**
> > > + * wx_io_error_detected - called when PCI error is detected
> > > + * @pdev: Pointer to PCI device
> > > + * @state: The current pci connection state
> > > + *
> > > + * Return: pci_ers_result_t.
> > > + *
> > > + * This function is called after a PCI bus error affecting
> > > + * this device has been detected.
> > > + */
> > > +static pci_ers_result_t wx_io_error_detected(struct pci_dev =
*pdev,
> > > +					     pci_channel_state_t state)
> > > +{
> > > +	struct wx *wx =3D pci_get_drvdata(pdev);
> > > +	struct net_device *netdev;
> > > +
> > > +	if (!wx)
> > > +		return PCI_ERS_RESULT_DISCONNECT;
> > > +
> > > +	netdev =3D wx->netdev;
> > > +	if (!netif_device_present(netdev))
> > > +		return PCI_ERS_RESULT_DISCONNECT;
> > > +
> > > +	if (state =3D=3D pci_channel_io_perm_failure)
> > > +		return PCI_ERS_RESULT_DISCONNECT;
> >
> > [High]
> > Should the pci_channel_io_perm_failure branch perform teardown =
before
> > returning?  In this branch the device is guaranteed gone forever, =
yet no
> > netif_device_detach(), wx_soft_quiesce(), or pci_disable_device() =
runs.
> >
> > The service_timer keeps firing every couple of seconds and
> > wx_check_hang_subtask()/wx_update_stats() will keep doing MMIO reads
> > against the disconnected device.  On arm64 an MMIO to a disconnected
> > device raises a synchronous external abort.  TX queues are also =
still up
> > and will keep taking skbs through ndo_start_xmit until remove() =
runs.
> >
> > Compare with ixgbe_io_error_detected() in
> > drivers/net/ethernet/intel/ixgbe/ixgbe_main.c, which performs
> > rtnl_lock/netif_device_detach/ixgbe_close_suspend before the
> > perm_failure check.  Would applying the same ordering here work?
> >
> > > +
> > > +	rtnl_lock();
> > > +	netif_device_detach(netdev);
> > > +	set_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
> > > +	wx_soft_quiesce(wx);
> > > +
> > > +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> > > +		pci_disable_device(pdev);
> > > +	rtnl_unlock();
> > > +
> > > +	/* Request a slot reset. */
> > > +	return PCI_ERS_RESULT_NEED_RESET;
> > > +}
> > > +
> > > +/**
> > > + * wx_io_slot_reset - called after the pci bus has been reset.
> > > + * @pdev: Pointer to PCI device
> > > + *
> > > + * Return: pci_ers_result_t.
> > > + *
> > > + * Restart the card from scratch, as if from a cold-boot.
> > > + */
> > > +static pci_ers_result_t wx_io_slot_reset(struct pci_dev *pdev)
> > > +{
> > > +	struct wx *wx =3D pci_get_drvdata(pdev);
> > > +
> > > +	if (pci_enable_device_mem(pdev)) {
> > > +		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
> > > +		return PCI_ERS_RESULT_DISCONNECT;
> > > +	}
> >
> > [Medium, Low]
> > When pci_enable_device_mem() fails here, does wx_io_slot_reset() =
need to
> > unwind the state set up by wx_io_error_detected()?  =
WX_STATE_DISABLED,
> > WX_STATE_DOWN (via wx_soft_quiesce), and WX_FLAG_NEED_PCIE_RECOVERY =
all
> > remain latched because the clear_bit() calls further down are never
> > reached.
> >
> > If remove() runs later, ngbe_close()/txgbe_close() reach
> > ngbe_down()/txgbe_down() and call ngbe_disable_device()/
> > txgbe_disable_device(), which do:
> >
> >     if (test_and_set_bit(WX_STATE_DOWN, wx->state))
> >         return;
> >
> > so the queue/ring disable MMIO sequence is skipped.  Similarly
> > ngbe_reset()/txgbe_reset() early-return on =
WX_FLAG_NEED_PCIE_RECOVERY,
> > so wx_flush_sw_mac_table() and related MAC cleanup is skipped.  Is =
that
> > intended?
>=20
> Simon says: The issue below seems to be a suggested clean-up.
>             I don't think it needs to impede progress of this =
patch-set.
>=20
> > Separately, wx_err(wx, ...) here expands to
> > dev_err(&(wx)->pdev->dev, ...) and dereferences wx unconditionally,
> > while wx_io_error_detected() explicitly guards with
> > if (!wx) return PCI_ERS_RESULT_DISCONNECT.  Should the three =
callbacks
> > be consistent =E2=80=94 either the guard in error_detected is dead =
code, or
> > slot_reset and resume are missing an intended check?
> >
> > > +
> > > +	/* make all memory operations done before clearing the flag */
> > > +	smp_mb__before_atomic();
> > > +	clear_bit(WX_STATE_DISABLED, wx->state);
> > > +	clear_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
> > > +	pci_set_master(pdev);
> > > +	pci_restore_state(pdev);
> > > +	pci_wake_from_d3(pdev, false);
> > > +
> > > +	rtnl_lock();
> > > +	if (netif_running(wx->netdev) && wx->down_suspend)
> > > +		wx->down_suspend(wx);
> > > +	if (wx->do_reset)
> > > +		wx->do_reset(wx->netdev, false);
> > > +	rtnl_unlock();
> > > +
> > > +	return PCI_ERS_RESULT_RECOVERED;
> > > +}
> > > +
> > > +/**
> > > + * wx_io_resume - called when traffic can start flowing again.
> > > + * @pdev: Pointer to PCI device
> > > + *
> > > + * This callback is called when the error recovery driver tells =
us that
> > > + * its OK to resume normal operation.
> > > + */
> > > +static void wx_io_resume(struct pci_dev *pdev)
> > > +{
> > > +	struct wx *wx =3D pci_get_drvdata(pdev);
> > > +	struct net_device *netdev;
> > > +	int err;
> > > +
> > > +	netdev =3D wx->netdev;
> > > +	rtnl_lock();
> > > +	if (netif_running(netdev)) {
> > > +		err =3D netdev->netdev_ops->ndo_open(netdev);
> > > +		if (err) {
> > > +			wx_err(wx, "Failed to open netdev after reset\n");
> > > +			goto out;
> > > +		}
> > > +	}
> > > +	netif_device_attach(netdev);
> > > +out:
> > > +	rtnl_unlock();
> > > +}
>=20
> Simon says: I believe the issue was already discussed in the review of =
v10.
>             And we can pass on it going forward.
>=20
> > [High]
> > When ndo_open() fails in wx_io_resume(), the "out" path drops the =
rtnl
> > and returns without calling netif_device_attach(), without clearing
> > WX_STATE_DOWN, and without clearing WX_STATE_RES_FREED.
> >
> > Because wx_io_error_detected() only cleared __LINK_STATE_PRESENT via
> > netif_device_detach(), __LINK_STATE_START is still set, so
> > netif_running() continues to return true.  WX_STATE_DOWN and
> > WX_STATE_RES_FREED (set earlier in the AER cycle by =
wx_soft_quiesce()
> > and down_suspend()) are only cleared inside ngbe_up_complete() /
> > txgbe_up_complete(), which are only reached if ndo_open() runs to
> > completion.
> >
> > If open fails partway (wx_setup_resources, request_irq,
> > phylink_connect_phy, ...), the netdev is left detached but "running"
> > with WX_STATE_DOWN and WX_STATE_RES_FREED latched.  A subsequent
> > userspace "ip link set eth0 down" then hits the new short-circuit
> > early in ngbe_close()/txgbe_close():
> >
> >     if (test_bit(WX_STATE_RES_FREED, wx->state))
> >         goto out;
> >     ...
> >     out:
> >         wx_control_hw(wx, false);
> >
> > Since ->resume returns void, there is no way to inform the AER core.
> > Is there a recovery path other than unbind/rebind if ndo_open() =
fails
> > here?
> >
> > > +
> > > +const struct pci_error_handlers wx_err_handler =3D {
> > > +	.error_detected =3D wx_io_error_detected,
> > > +	.slot_reset =3D wx_io_slot_reset,
> > > +	.resume =3D wx_io_resume,
> > > +};
> > > +EXPORT_SYMBOL(wx_err_handler);
> > > +
> >
> > [ ... ]
> >
> > > @@ -139,6 +251,33 @@ void wx_check_hang_subtask(struct wx *wx)
> > >  }
> > >  EXPORT_SYMBOL(wx_check_hang_subtask);
> > >
> > > +static bool wx_check_pcie_error(struct wx *wx)
> > > +{
> > > +	u16 vid, pci_cmd;
> > > +
> > > +	pci_read_config_word(wx->pdev, PCI_VENDOR_ID, &vid);
> > > +	pci_read_config_word(wx->pdev, PCI_COMMAND, &pci_cmd);
> > > +
> > > +	/* PCIe link loss or memory space can't access */
> > > +	if (vid =3D=3D U16_MAX || !(pci_cmd & PCI_COMMAND_MEMORY))
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> > > +
> > > +static void wx_tx_timeout_recovery(struct wx *wx)
> > > +{
> > > +	/*
> > > +	 * When a PCIe hardware error occurs, the driver should initiate =
a PCIe
> > > +	 * recovery mechanism. However, this recovery flow relies on the =
AER
> > > +	 * driver for current kernel policy. Therefore, a self-contained
> > > +	 * recovery mechanism is not implemented yet.
> > > +	 */
> > > +	set_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
> > > +	wx_err(wx, "PCIe error detected during tx timeout\n");
> > > +	queue_work(wx->reset_wq, &wx->reset_task);
> > > +}
> >
> > [Medium]
> > What happens on a platform where AER never fires (AER disabled at =
boot,
> > firmware masks the event, or CONFIG_PCIEAER=3Dn)?
> >
> > wx_tx_timeout_recovery() only sets WX_FLAG_NEED_PCIE_RECOVERY and
> > queues reset_task.  WX_FLAG_NEED_PCIE_RECOVERY is only cleared in
> > wx_io_slot_reset(), so without AER the flag latches.
> >
> > wx_reset_task() then does:
> >
> >     rtnl_lock();
> >     if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
> >         wx_soft_quiesce(wx);           /* sets WX_STATE_DOWN */
> >     if (test_bit(WX_STATE_DOWN, wx->state) ||
> >         test_bit(WX_STATE_RESETTING, wx->state))
> >         goto out;                      /* always taken now */
> >     wx_pf_reset_subtask(wx);           /* checks a different flag */
> >
> > and ngbe_reset()/txgbe_reset() early-return on
> > WX_FLAG_NEED_PCIE_RECOVERY, so any future reset is a silent no-op.  =
Is
> > there an intended fallback recovery when AER is unavailable, or is =
the
> > interface expected to stay unusable until reboot?  The comment
> > acknowledges "a self-contained recovery mechanism is not implemented
> > yet" =E2=80=94 should this be gated on IS_ENABLED(CONFIG_PCIEAER) or =
similar?
> >
> > > +
> > >  static void wx_tx_timeout_reset(struct wx *wx)
> > >  {
> > >  	if (test_bit(WX_STATE_DOWN, wx->state))
> > > @@ -153,7 +292,10 @@ void wx_tx_timeout(struct net_device *netdev, =
unsigned int __always_unused txque
> > >  {
> > >  	struct wx *wx =3D netdev_priv(netdev);
> > >
> > > -	wx_tx_timeout_reset(wx);
> > > +	if (wx_check_pcie_error(wx))
> > > +		wx_tx_timeout_recovery(wx);
> > > +	else
> > > +		wx_tx_timeout_reset(wx);
> > >  }
> > >  EXPORT_SYMBOL(wx_tx_timeout);
> >
> > [ ... ]
>=20
> Separately, the following issue was flagged in the AI-generated review
> on sashiko.dev [1]. I am concerned that it is exacerbated by this =
patch
> in the case where an AER recovery occurs and the module is =
subsequently
> removed without the device being opened.
>=20
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c =
b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > index 7a05661b1d802..499f48619f000 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> [ ... ]
> > @@ -989,7 +1014,8 @@ static void txgbe_remove(struct pci_dev *pdev)
> >  	kfree(wx->mac_table);
> >  	wx_clear_interrupt_scheme(wx);
> >
> > -	pci_disable_device(pdev);
> > +	if (!test_and_set_bit(WX_STATE_DISABLED, wx->state))
> > +		pci_disable_device(pdev);
> >  }
> This isn't a bug introduced by this patch, but does unloading the =
module
> without bringing the interface up cause memory corruption?
> In txgbe_remove() (just above this hunk), wx_free_isb_resources() is =
called
> unconditionally during module removal.
> drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_free_isb_resources() {
> 	...
> 	dma_free_coherent(&pdev->dev, sizeof(u32) * 4,
> 			  wx->isb_mem, wx->isb_dma);
> 	wx->isb_mem =3D NULL;
> }
> If the interface is never opened, wx->isb_mem remains NULL. Passing a =
NULL
> virtual address and 0 DMA handle to dma_free_coherent() can bypass =
normal NULL
> checks and free physical page 0, potentially causing silent memory =
corruption
> or panics.
> Should there be a NULL check before calling dma_free_coherent()?
>=20
> [1] =
https://sashiko.dev/#/patchset/20260716073822.24356-1-jiawenwu%40trustnet=
ic.com?part=3D5

I think this confusion is caused by the different free processes of =
txgbe and
ngbe. For txgbe, wx_free_isb_resources() is called only in =
txgbe_remove(). But
for ngbe, it is called in ngbe_close() and ngbe_down_suspend(), which is
restricted to the flag WX_STATE_RES_FREED. They can respectively =
guarantee that
wx->isb_mem !=3D NULL when dma_free_coherent() is called.


