Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5302435506
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417558; cv=none; b=kLgZwqVYN9o6TnaE9gomy9oiwNBX6UFR7xnUnLbbhp252J4uqrJ2KCLeXBbh+TWU5eoplsspnQUFuMrTAxsmrmyn/KplB+Z8g6FFJ2NaU0EziRkgUBZikfaXe0QheTEdN/vXL2EDEUxrjMHxxRxl1Nq4CU5WqkgyFKR5/I5GRss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417558; c=relaxed/simple;
	bh=NF1qSZAoW7N8Ly9/HdThnf1ZKQhpjId6QcEFwqKfG+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3KoD1Mxf6TLouxhNG8IVJ85joPQ85nCV4N1B3IgIxVdCRuNOK21hJ8t04QNbkkJ6YZLKC1jie3Lnuo29Qvh/i4m4ks+1pn7am374r5t2bO4eiK3NwS2i0yYovoir+3KFP5GQIeAxHK65J9VrSSe4Byl2Y5vZR74CL6G7b4kmfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIbB7eUL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIbB7eUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77F41F00A3E;
	Thu, 30 Jul 2026 13:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785417554;
	bh=zXTHeGINFjuqCi/OI71o3RsflyVrWZwXBUM9KTLqlRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SIbB7eULnLi4wcrILF1R9myn1NgYYtUH6a4S++6AmJv2tWHm4+E4Uq5x22QiO7071
	 17O/Go4YJgyWgLyD4Ves+MTaCKSi9SWN9RaxizOWG+kpbXW5sq3clprG+2UXRxwunN
	 zVheh/AiLYXuND3KOX+yl9JHLQuAd8SyahpG5h39msJKQdykUL5Zul+wptolplHEkR
	 91sKsHuBfx9vEuvnDlooeP/w1AY8kNvA1QTy19pyiAAFLlQ2/JSE2LCu4HVXYMyHgL
	 olXr8n0wHA1isJqNGkv821JOwIbhw3KnqL3F7w65kR+3VYz3zTBABhXjsWVSVDis4R
	 RSUx5ny3rNMBg==
Date: Thu, 30 Jul 2026 14:19:08 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>, Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH net-next v12 5/5] net: wangxun: add pcie error handler
Message-ID: <20260730131908.GB51943@horms.kernel.org>
References: <20260724101309.23472-1-jiawenwu@trustnetic.com>
 <20260724101309.23472-6-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724101309.23472-6-jiawenwu@trustnetic.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260724101309.23472-2-jiawenwu@trustnetic.com?part=5
---
--- Patch [5]: [PATCH net-next v12 5/5] net: wangxun: add pcie error handler ---
commit bbdaff8533430e43d4fe6382b836808684487044
Author: Jiawen Wu <jiawenwu@trustnetic.com>

net: wangxun: add pcie error handler

Support AER driver to handle the PCIe errors. Sometimes netdev watchdog
Tx timeout happens before the AER error report when a PCIe error occurs,
CPU blocking would be caused by MMIO during the reset process. To
prevent it, check PCIe error status in .ndo_tx_timeout. The current
function of ngbe is not yet fully developed, it will be completed in the
future.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> index ee27f96735dc7..7936845c2894c 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_err.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c

[ ... ]

> @@ -139,6 +253,33 @@ void wx_check_hang_subtask(struct wx *wx)
>  }
>  EXPORT_SYMBOL(wx_check_hang_subtask);
>  
> +static bool wx_check_pcie_error(struct wx *wx)
> +{
> +	u16 vid, pci_cmd;
> +
> +	pci_read_config_word(wx->pdev, PCI_VENDOR_ID, &vid);
> +	pci_read_config_word(wx->pdev, PCI_COMMAND, &pci_cmd);
> +
> +	/* PCIe link loss or memory space can't access */
> +	if (vid == U16_MAX || !(pci_cmd & PCI_COMMAND_MEMORY))
> +		return true;
> +
> +	return false;
> +}
> +
> +static void wx_tx_timeout_recovery(struct wx *wx)
> +{
> +	/*
> +	 * When a PCIe hardware error occurs, the driver should initiate a PCIe
> +	 * recovery mechanism. However, this recovery flow relies on the AER
> +	 * driver for current kernel policy. Therefore, a self-contained
> +	 * recovery mechanism is not implemented yet.
> +	 */
> +	set_bit(WX_FLAG_NEED_PCIE_RECOVERY, wx->flags);
> +	wx_err(wx, "PCIe error detected during tx timeout\n");
> +	queue_work(wx->reset_wq, &wx->reset_task);
> +}

[Severity: Medium]
Can a race condition between this timeout handler and concurrent AER recovery
permanently disable the device?

If the timeout handler detects an error but is delayed, AER recovery might
complete in the meantime, clearing the recovery flag and restoring the
device.

When this delayed handler resumes, it would blindly set
WX_FLAG_NEED_PCIE_RECOVERY and queue the reset task. This would cause
wx_reset_task() to unconditionally call wx_soft_quiesce() on the freshly
recovered device, leaving it permanently unresponsive.

> +
>  static void wx_tx_timeout_reset(struct wx *wx)
>  {

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 92895f5035118..56d4b63387fd6 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c

[ ... ]

> @@ -529,12 +548,16 @@ static int ngbe_close(struct net_device *netdev)
>  {
>  	struct wx *wx = netdev_priv(netdev);
>  
> +	if (test_bit(WX_STATE_RES_FREED, wx->state))
> +		goto out;
> +

Simon says: I believe the issue below this was raised in the review of an
	    earlier version, and changes were made to address it. But could
	    you take another look?

[Severity: High]
Does bypassing wx_ptp_stop() here leak the PTP clock device and cause a
use-after-free?

When an AER error triggers a slot reset, wx_io_slot_reset() invokes
ngbe_down_suspend() which sets WX_STATE_RES_FREED but does not call
wx_ptp_stop().

If the device is subsequently closed, this check causes the driver to skip
wx_ptp_stop(). The driver memory is then freed while the kernel PTP subsystem
retains a dangling pointer to the destroyed clock device, which will panic
upon any subsequent userspace access.

>  	wx_ptp_stop(wx);
>  	ngbe_down(wx);

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index 11ac4b04f5ee3..582ee567e6b9c 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c

[ ... ]

> @@ -538,12 +557,16 @@ static int txgbe_close(struct net_device *netdev)
>  {
>  	struct wx *wx = netdev_priv(netdev);
>  
> +	if (test_bit(WX_STATE_RES_FREED, wx->state))
> +		goto out;

Simon says: ditto

[Severity: High]
Similarly, does bypassing wx_ptp_stop() here leak the PTP clock device
and cause a use-after-free?

Just like in ngbe_close(), if an AER error triggers a slot reset,
wx_io_slot_reset() invokes txgbe_down_suspend() which sets
WX_STATE_RES_FREED without calling wx_ptp_stop().

If the device is then closed, this bypasses the cleanup, leaving the
kernel PTP subsystem with a dangling pointer to the destroyed clock device.

Simon says: I think the issue below can be looked at in the context
            of possible follow-up.

[Severity: High]
This is a pre-existing issue, but does failing to open the device in
txgbe_open() lead to a NULL pointer dereference on subsequent open attempts?

If txgbe_open() encounters an error, the error path calls
wx_reset_interrupt_capability(), which frees wx->msix_q_entries and sets
it to NULL.

If a user subsequently attempts to bring the interface up again,
txgbe_request_queue_irqs() is called, which dereferences the NULL
wx->msix_q_entries array.

>  	wx_ptp_stop(wx);
>  	txgbe_down(wx);
