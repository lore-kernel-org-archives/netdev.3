Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53436BB5B
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 02:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784859095; cv=none; b=A8sbawN7FFQVZaKKcir95KW82T8gFiwyuiymsC+UGDhKX8R8nyCLc8MT8u2sQHR/HEzWf6yAkyayZSL/mfDRwE6DOnfllx6hZOJ5ntMf48hH34LyOWw7cB3o2vwPVtixCVCK+isWb/gatwisdXjJyBBQSSijtl0IkDmZJvxP9+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784859095; c=relaxed/simple;
	bh=m+ZeEJ/UJxj6T/5N9saWCQUVp2kxVjwZ98ic+mJODkQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=j3pVooenQ2opULfFdltN1vAWie59akxtm1C7NELeykX+NssS4oByPvctOq3IBKVk7RGQdlsR84/HSOlTN3o4YSSE3Rw60GnevnpDa7442iwOCoQh5UgQ3Ddws/fCMFgt+w1ZPCGINVjeluGL2XfwbCi0ACDnqpbKNPXGsyS7+9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:ivesync10t1784858951t69b38482
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.227.112.172])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 11767756379530549990
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
References: <20260716073822.24356-6-jiawenwu@trustnetic.com> <20260723091639.574355-2-horms@kernel.org>
In-Reply-To: <20260723091639.574355-2-horms@kernel.org>
Subject: RE: [PATCH net-next v11 5/5] net: wangxun: add pcie error handler
Date: Fri, 24 Jul 2026 10:09:10 +0800
Message-ID: <026601dd1b11$6a50b110$3ef21330$@trustnetic.com>
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
Thread-Index: AQJ1iHGNSt0ya3g5xz6atkL6TxAqaQGLmvi9tT6uE9A=
X-QQ-SENDSIZE: 520
Feedback-ID: ivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MwqrwaLzgdebOB0aH/q2uPdzsgYtzGwTVBhaHiUGyJ1dNinxCAgB46xE
	Ih+DxEIaj398dCoDO9AanO/D6m9PkQ8yxLTqMg0EF5yVr+ICaeqr+3s6U9qYfLHa1j3iLxM
	X4upint8D36GSbpZ7BFmiEFqT/SmbvrqEGOuCFDhjheQBOhagoTtpcQ4DWP2GkeYpuMLaFb
	k97Paq79xEwep6wxnzgP8pHdrylWIcy2B1jQ3Xc5M4ku0xI4nh0zFeMCvT4pR9qb1KbqeaB
	5w5woi/SApFlKowRlu4SIUytTPnnWI9BFbUUR/pB3K67fPwL6gllXJkdL8Cy4YlPBReO18E
	NDFG4rtAH1++KlGF1/i6QPBcyPZe/qT9uvW7J9fY4vvH04V6UdtwcOWVUVPQi+Y92ystmYE
	qg3/MGqdefPqElx8YYELL3V/QmQd21CBvbKrQTSk5n5DYYwxSqvvFRjgqSPxsjB5o8aCmB5
	vCITxzuIQ5/DiI9M9Ip6JwZ4N1z4Kxe5k9dzYtxmLeQ9LV9Jjyrhi1LBLJGI9PEptgeD2mD
	7yD5rta20zQ/c4eO6PWNpHSMVWVeKkkwl837+mFlmizBguC54+9XxJ35Of6DtSqk+izaDbM
	gp+SMzDtESqIZISf6A/Ktgcyv6VME7JiIXofWkjF5aVsYSGj8dU9a0h5sgampo6/nKSGMs2
	6BwdOD+HUjwIvWdusB7MZYZD0gdjDZdaKTUq3VR2weSpSQT4F8BmSgOdlJ7H9cY7zwFqmJY
	/n6ni+bGVzIbMDBy2BTPNtTT1bZpLWaKUM4Bp3cQdUYONOxKaGye4ImTfhrc/aEahWhOFgm
	lLLXwapHZsPRZpGs90gzpTaZ/HQMEug5ZNHidr1rIBBgTUnUkMsn19cZDZSMyw21ANJMjAb
	Q7qt95bLxNoueqfKNnvTzPZ8dPbimHixbGwkFtvsoaimidQ3YN4giMkKu/QsC7reQ9HImXM
	Y1zs/JXLREKeHgkWnjrIBC/DuI/mSH23nbjzev3cc2SKrIloBtC165Q7pxqr0qLaluro7P9
	4dm5lVjWdKBRqFpPKxRHDN/LmST/d/Kr/dRIxqild1CY373Fu6CRUK/AHCUWrdwpLhdoZbc
	71tXBKyMuUB+A1DjC1GNLFqodDsOD5m9w==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

On Thu, Jul 23, 2026 5:17 PM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> =
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260716073822.24356-=
2-jiawenwu@trustnetic.com?part=3D5
> ---
> Subject: net: wangxun: add pcie error handler
>=20
> This patch wires up pci_error_handlers callbacks (error_detected,
> slot_reset, resume) for the ngbe and txgbe drivers, adds a
> WX_FLAG_NEED_PCIE_RECOVERY flag plus a down_suspend op, and routes
> ndo_tx_timeout through a check that inspects config space and defers
> to the AER path when the device looks disconnected.
>=20
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c =
b/drivers/net/ethernet/wangxun/libwx/wx_err.c
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
> > +	struct wx *wx =3D pci_get_drvdata(pdev);
> > +	struct net_device *netdev;
> > +
> > +	if (!wx)
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +
> > +	netdev =3D wx->netdev;
> > +	if (!netif_device_present(netdev))
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +
> > +	if (state =3D=3D pci_channel_io_perm_failure)
> > +		return PCI_ERS_RESULT_DISCONNECT;
>=20
> [High]
> Should the pci_channel_io_perm_failure branch perform teardown before
> returning?  In this branch the device is guaranteed gone forever, yet =
no
> netif_device_detach(), wx_soft_quiesce(), or pci_disable_device() =
runs.
>=20
> The service_timer keeps firing every couple of seconds and
> wx_check_hang_subtask()/wx_update_stats() will keep doing MMIO reads
> against the disconnected device.  On arm64 an MMIO to a disconnected
> device raises a synchronous external abort.  TX queues are also still =
up
> and will keep taking skbs through ndo_start_xmit until remove() runs.
>=20
> Compare with ixgbe_io_error_detected() in
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c, which performs
> rtnl_lock/netif_device_detach/ixgbe_close_suspend before the
> perm_failure check.  Would applying the same ordering here work?
>=20
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
> > +	struct wx *wx =3D pci_get_drvdata(pdev);
> > +
> > +	if (pci_enable_device_mem(pdev)) {
> > +		wx_err(wx, "Cannot re-enable PCI device after reset.\n");
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +	}
>=20
> [Medium, Low]
> When pci_enable_device_mem() fails here, does wx_io_slot_reset() need =
to
> unwind the state set up by wx_io_error_detected()?  WX_STATE_DISABLED,
> WX_STATE_DOWN (via wx_soft_quiesce), and WX_FLAG_NEED_PCIE_RECOVERY =
all
> remain latched because the clear_bit() calls further down are never
> reached.
>=20
> If remove() runs later, ngbe_close()/txgbe_close() reach
> ngbe_down()/txgbe_down() and call ngbe_disable_device()/
> txgbe_disable_device(), which do:
>=20
>     if (test_and_set_bit(WX_STATE_DOWN, wx->state))
>         return;
>=20
> so the queue/ring disable MMIO sequence is skipped.  Similarly
> ngbe_reset()/txgbe_reset() early-return on WX_FLAG_NEED_PCIE_RECOVERY,
> so wx_flush_sw_mac_table() and related MAC cleanup is skipped.  Is =
that
> intended?

If pci_enable_device_mem() fails here, it indicates that the PCIe =
recovery has
completely failed and the device's MMIO space is inaccessible. The only
solution is a system reboot. We don't need to unwind the state for a =
dead
device.

>=20
> Separately, wx_err(wx, ...) here expands to
> dev_err(&(wx)->pdev->dev, ...) and dereferences wx unconditionally,
> while wx_io_error_detected() explicitly guards with
> if (!wx) return PCI_ERS_RESULT_DISCONNECT.  Should the three callbacks
> be consistent =E2=80=94 either the guard in error_detected is dead =
code, or
> slot_reset and resume are missing an intended check?
>=20
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
> > + * This callback is called when the error recovery driver tells us =
that
> > + * its OK to resume normal operation.
> > + */
> > +static void wx_io_resume(struct pci_dev *pdev)
> > +{
> > +	struct wx *wx =3D pci_get_drvdata(pdev);
> > +	struct net_device *netdev;
> > +	int err;
> > +
> > +	netdev =3D wx->netdev;
> > +	rtnl_lock();
> > +	if (netif_running(netdev)) {
> > +		err =3D netdev->netdev_ops->ndo_open(netdev);
> > +		if (err) {
> > +			wx_err(wx, "Failed to open netdev after reset\n");
> > +			goto out;
> > +		}
> > +	}
> > +	netif_device_attach(netdev);
> > +out:
> > +	rtnl_unlock();
> > +}
>=20
> [High]
> When ndo_open() fails in wx_io_resume(), the "out" path drops the rtnl
> and returns without calling netif_device_attach(), without clearing
> WX_STATE_DOWN, and without clearing WX_STATE_RES_FREED.
>=20
> Because wx_io_error_detected() only cleared __LINK_STATE_PRESENT via
> netif_device_detach(), __LINK_STATE_START is still set, so
> netif_running() continues to return true.  WX_STATE_DOWN and
> WX_STATE_RES_FREED (set earlier in the AER cycle by wx_soft_quiesce()
> and down_suspend()) are only cleared inside ngbe_up_complete() /
> txgbe_up_complete(), which are only reached if ndo_open() runs to
> completion.
>=20
> If open fails partway (wx_setup_resources, request_irq,
> phylink_connect_phy, ...), the netdev is left detached but "running"
> with WX_STATE_DOWN and WX_STATE_RES_FREED latched.  A subsequent
> userspace "ip link set eth0 down" then hits the new short-circuit
> early in ngbe_close()/txgbe_close():
>=20
>     if (test_bit(WX_STATE_RES_FREED, wx->state))
>         goto out;
>     ...
>     out:
>         wx_control_hw(wx, false);

If ndo_open() fails during the resume phase, it indicates that the =
hardware or
its underlying resources could not be successfully restored after the =
PCIe
reset. At this point, the device is considered broken and unusable.

Therefore, intentionally leaving WX_STATE_DOWN and WX_STATE_RES_FREED =
latched
(and skipping netif_device_attach()) is the desired behavior. If we =
allowed
subsequent operations like 'ip link set eth0 down' or remove() to =
execute normal
hardware shutdown routines (such as queue/ring disable MMIOs), we would =
risk
triggering secondary errors or timeouts against a device that failed to
initialize properly. Short-circuiting these hardware accesses via the =
latched
flags is the safest approach.

>=20
> Since ->resume returns void, there is no way to inform the AER core.
> Is there a recovery path other than unbind/rebind if ndo_open() fails
> here?

There is no alternative recovery path within the driver. The device must
either wait for another AER error interrupt/reset cycle to attempt =
recovery
again, or be manually removed/unbound by the user.

>=20
> > +
> > +const struct pci_error_handlers wx_err_handler =3D {
> > +	.error_detected =3D wx_io_error_detected,
> > +	.slot_reset =3D wx_io_slot_reset,
> > +	.resume =3D wx_io_resume,
> > +};
> > +EXPORT_SYMBOL(wx_err_handler);
> > +
>=20
> [ ... ]
>=20
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
> > +	if (vid =3D=3D U16_MAX || !(pci_cmd & PCI_COMMAND_MEMORY))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static void wx_tx_timeout_recovery(struct wx *wx)
> > +{
> > +	/*
> > +	 * When a PCIe hardware error occurs, the driver should initiate a =
PCIe
> > +	 * recovery mechanism. However, this recovery flow relies on the =
AER
> > +	 * driver for current kernel policy. Therefore, a self-contained
> > +	 * recovery mechanism is not implemented yet.
> > +	 */
> > +	set_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
> > +	wx_err(wx, "PCIe error detected during tx timeout\n");
> > +	queue_work(wx->reset_wq, &wx->reset_task);
> > +}
>=20
> [Medium]
> What happens on a platform where AER never fires (AER disabled at =
boot,
> firmware masks the event, or CONFIG_PCIEAER=3Dn)?
>=20
> wx_tx_timeout_recovery() only sets WX_FLAG_NEED_PCIE_RECOVERY and
> queues reset_task.  WX_FLAG_NEED_PCIE_RECOVERY is only cleared in
> wx_io_slot_reset(), so without AER the flag latches.
>=20
> wx_reset_task() then does:
>=20
>     rtnl_lock();
>     if (test_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags))
>         wx_soft_quiesce(wx);           /* sets WX_STATE_DOWN */
>     if (test_bit(WX_STATE_DOWN, wx->state) ||
>         test_bit(WX_STATE_RESETTING, wx->state))
>         goto out;                      /* always taken now */
>     wx_pf_reset_subtask(wx);           /* checks a different flag */
>=20
> and ngbe_reset()/txgbe_reset() early-return on
> WX_FLAG_NEED_PCIE_RECOVERY, so any future reset is a silent no-op.  Is
> there an intended fallback recovery when AER is unavailable, or is the
> interface expected to stay unusable until reboot?  The comment
> acknowledges "a self-contained recovery mechanism is not implemented
> yet" =E2=80=94 should this be gated on IS_ENABLED(CONFIG_PCIEAER) or =
similar?

Stay unusable until reboot.

>=20
> > +
> >  static void wx_tx_timeout_reset(struct wx *wx)
> >  {
> >  	if (test_bit(WX_STATE_DOWN, wx->state))
> > @@ -153,7 +292,10 @@ void wx_tx_timeout(struct net_device *netdev, =
unsigned int __always_unused txque
> >  {
> >  	struct wx *wx =3D netdev_priv(netdev);
> >
> > -	wx_tx_timeout_reset(wx);
> > +	if (wx_check_pcie_error(wx))
> > +		wx_tx_timeout_recovery(wx);
> > +	else
> > +		wx_tx_timeout_reset(wx);
> >  }
> >  EXPORT_SYMBOL(wx_tx_timeout);
>=20
> [ ... ]
>=20

