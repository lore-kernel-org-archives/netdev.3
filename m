Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC7131283E;
	Fri,  2 Oct 2026 03:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790912119; cv=none; b=VM1mQ/+sscOriEPj8kqcFVXCQkX83XeTqyQfw6zKC9xIl77F1YpEXGjtcfe98B0YCFRL0p96vkfIk7SPNKr990xp74sQ1aT3JZzV1fYIAEAyPOBqEZWUrjiyCQ1Elm9zgAoCZ2ABkItwK75y63RxOWOGhcK1DAHMMt7TsGE2gxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790912119; c=relaxed/simple;
	bh=c+TKfHAfDLJX4jhtlQRU3MNDT2sFTlYveGnGskbuLfA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kl+Aqm6ex0WimzkTNgzVaSJWz8xamYIHDzbMFZbqALarNLesLGO07AVBuMiDu9rY9ANvyHB9DZbEzhpyP9z8POt53C1mQ6bzANM/m+whCWN9R7XjmtaNIfj6Q3uvVKLLQ/F+iIGWpoIM1y6anoVkZEFj6rWcCv21ARzWIw2NYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMSY0kf6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMSY0kf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849571F000FF;
	Fri,  2 Oct 2026 03:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790912117;
	bh=ifMp6dWbsvSy33vBZCWFHYojSI0gUbr0TqIG0XOU+Rw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TMSY0kf6IQVHTsZ+3EOXaSqU5VnLSGWuUx8YMIMoOrMLgbX0oM7FMdQIRuwVAuxLZ
	 W/X3AOgdSNyB7c88tcFkTXF+I6uAEEgFxbgcrODh4YoDU0YJsX7l0ARYllRLT9R00j
	 FaQ1QU4SLbnSJXTsT355VbdVWsfPk+lMjqEQ2xnxRe1h0Bc/qikIHaMrwLjBNyNNX7
	 e5m83IfWjsU+bAYck6WRzJQAijGuYt1z/X4cA13bRbsxp2iKfB8p2C8+y48ljZncbn
	 m7LE8Md0xG0AywTcjA5uG0AED62pewM8Lwl3EVmTEUak5So7m/DYSb35fT2MIEBCdj
	 bC5hjJluKTAgw==
Subject: Re: [PATCH v30 net-next 4/8] net/nebula-matrix: add chip-wide
 hardware init/deinit implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 03:35:16 +0000
Message-ID: <179091211608.434549.7904266219885415447@kernel.org>
In-Reply-To: <20260928123237.88994-5-illusion.wang@nebula-matrix.com>
References: <20260928123237.88994-5-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] nbl_probe_chip_deps() (drivers/net/ethernet/nebula-
  matrix/nbl/nbl_main.c:113) adds a managed device link from each non-…
- [Medium] nbl_hw_deinit_module() (nbl_hw_leonis.c:721) clears
  driver_status, which starts asynchronous firmware cleanup, then…
- [Medium] nbl_probe_chip_deps() checks the supplier state without
  holding the device-links lock (READ_ONCE(mgt->dev.links.status) !=…
- [Medium] nbl_probe_chip_deps() dereferences the managed link returned
  by device_link_add() (READ_ONCE(link->status), nbl_main.c:161) without…
- [Low] nbl_probe_chip_deps() treats func 0 as a ready nbl management PF
  as soon as READ_ONCE(mgt->dev.links.status) == DL_DEV_DRIVER_BOUND…

--

net/nebula-matrix: add chip-wide hardware init/deinit implementation

This commit adds Leonis chip-wide datapath init/deinit hooks
(init_module/deinit_module) in the hw and resource layers. The hooks use
a driver_status flag handshake with firmware. It also adds a device link
from each non-management PF to func 0, so that sibling PFs are unbound
before the management PF.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index acd4f3dd0757..47ec995e3ac8 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> @@ -5,11 +5,23 @@
>  #include <linux/device.h>
>  #include <linux/pci.h>
>  #include <linux/bits.h>
> +#include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/spinlock.h>
>  #include <linux/bitfield.h>
>  #include "nbl_hw_leonis.h"
>  
> +/*
> + * Firmware cleanup after driver_status=false is asynchronous and the
> + * current hardware revision exposes no cleanup-complete status bit.
> + * Wait a bounded window so the firmware pass finishes before this
> + * function returns, establishing an explicit boundary against a later
> + * init_module() that would otherwise reprogram per-PF/chip-wide
> + * registers while firmware is still wiping them. Best-effort only.
> + */
> +#define NBL_FW_CLEANUP_SYNC_MIN_US	2000
> +#define NBL_FW_CLEANUP_SYNC_MAX_US	3000

[ ... ]

> +/*
> + * Setting driver status to false notifies firmware to clean up per-PF
> + * hardware state such as qinfo registers.
> + *

[ ... ]

> + * Firmware cleanup is asynchronous with no completion status register,
> + * so a bounded sync delay follows the flush. On return the firmware
> + * pass has settled, so a subsequent init_module() cannot race it.
> + *

[ ... ]

> +static void nbl_hw_deinit_module(struct nbl_hw_mgt *hw_mgt)
> +{
> +	nbl_hw_set_driver_status(hw_mgt, false);
> +	/* ensure driver_status reaches the chip */
> +	nbl_flush_writes(hw_mgt);
> +	/*
> +	 * Allow the asynchronous firmware cleanup pass to finish before
> +	 * returning, so this function is the boundary between firmware
> +	 * per-PF teardown and any later driver reprogramming.
> +	 */
> +	usleep_range(NBL_FW_CLEANUP_SYNC_MIN_US, NBL_FW_CLEANUP_SYNC_MAX_US);
> +}

[Severity: Medium]

Is the guarantee in the nbl_hw_deinit_module() kernel-doc accurate? It
says "On return the firmware pass has settled, so a subsequent
init_module() cannot race it". But the comment above
NBL_FW_CLEANUP_SYNC_MIN_US says there is no cleanup-complete status bit
and calls the wait "Best-effort only".

The only synchronisation here is a fixed 2-3 ms sleep. There is no
firmware acknowledgement.

If firmware cleanup takes longer than that, could a quick PF0
unbind/rebind reprogram qinfo in nbl_dev_setup_chan_qinfo() and the
datapath in nbl_hw_init_module(), and then have firmware wipe that state?

nbl_hw_init_module() also sets driver_status again without checking that
firmware is idle. It does not handle a driver_status bit left set by a
previous instance that crashed or was kexec'd.

The commit message also says:

  - Explicit register flushing synchronizes with asynchronous firmware cleanup

and:

  The deinit path only clears driver_status and flushes writes.

The read of NBL_HW_DUMMY_REG only ensures the posted write reached the
device. It can't observe firmware completion. The deinit path also
sleeps, which the message doesn't mention.

Could the commit message and both comments match what the code actually
guarantees? This is still present at the end of the series.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index 1aafed2d46d7..e1a30b5ba0cd 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> @@ -83,6 +83,87 @@ static void nbl_get_func_param(struct pci_dev *pdev, kernel_ulong_t driver_data,
>  		param->caps.has_ctrl = 1;
>  }
>  
> +/*
> + * Establish chip-wide dependencies for this PF:
> + *  - for every non-management PF, add a consumer->management PF device
> + *    link. The driver core then guarantees (sysfs unbind, driver
> + *    unregister, hot-unplug alike) that this consumer is released
> + *    BEFORE the func 0 supplier, which is the only teardown order in
> + *    which the chip-global firmware deinit is safe.
> + *

[ ... ]

> +static int nbl_probe_chip_deps(struct pci_dev *pdev, bool has_ctrl)
> +{
> +	struct device_link *link;
> +	struct pci_dev *mgt;
> +
> +	if (has_ctrl)
> +		return 0;
> +
> +	mgt = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> +					  pdev->bus->number,
> +					  PCI_DEVFN(PCI_SLOT(pdev->devfn), 0));
> +	if (!mgt) {
> +		dev_err(&pdev->dev,
> +			"management PF (func 0) not found on this chip\n");
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * The management PF must have COMPLETED probing, not merely
> +	 * have a driver assigned.  While func 0 is still PROBING, its

[ ... ]

> +	 */
> +	if (READ_ONCE(mgt->dev.links.status) != DL_DEV_DRIVER_BOUND) {
> +		pci_dev_put(mgt);
> +		return -EPROBE_DEFER;
> +	}

[Severity: Low]

Does this check confirm that func 0 is bound to nbl specifically?
links.status is DL_DEV_DRIVER_BOUND for any bound driver. If func 0 is
bound to vfio-pci or pci-stub through driver_override, the check passes
and the sibling creates a link to that other driver.

nbl_core_init() would then run on the non-management PF even though nbl
never did the func 0 chip-global setup. That includes the mailbox QINFO
map from nbl_dev_setup_chan_qinfo() under has_ctrl.

The comment above says "The management PF must have COMPLETED probing",
which reads as the nbl probe. The check doesn't enforce that.

Later in the series, nbl_dev_start()->nbl_dev_rpc_timeout() turns the
mailbox RPC timeout into -EPROBE_DEFER. The sibling would then likely
keep deferring, with an RPC timeout on every retry.

> +
> +	link = device_link_add(&pdev->dev, &mgt->dev,
> +			       DL_FLAG_AUTOREMOVE_CONSUMER);

[Severity: Medium]

What happens to the sibling PFs when func 0 is unbound and then bound
again?

On a func 0 unbind, device_links_unbind_consumers() releases every
sibling PF driver. device_links_driver_cleanup() then deletes the
AUTOREMOVE_CONSUMER link.

When func 0 binds again, device_links_driver_bound() re-queues consumers
only through AUTOPROBE links:

drivers/base/core.c:device_links_driver_bound() {
    ...
	if (device_link_test(link, DL_FLAG_AUTOPROBE_CONSUMER))
		driver_deferred_probe_add(link->consumer);
    ...
}

device_link_add() also returns NULL when DL_FLAG_AUTOPROBE_CONSUMER is
combined with DL_FLAG_AUTOREMOVE_CONSUMER.

So would PF1..PF3 and their Ethernet ports stay unbound until an admin
rebinds each one by hand?

The commit message ("ensuring safe chip-global firmware deinit") and the
comment above nbl_probe_chip_deps() describe only the teardown ordering.
Neither mentions that the ports are not restored. Would a persistent
managed link with DL_FLAG_AUTOPROBE_CONSUMER work better here?

At this commit, nbl_res_chip_deinit_module() has no caller yet. The later
commit "net/nebula-matrix: add common/ctrl dev init/remove operation"
wires deinit_module into nbl_dev_remove_ctrl_dev(). The missing re-probe
is still there at the end of the series.

> +	pci_dev_put(mgt);
> +	if (!link) {
> +		dev_err(&pdev->dev,
> +			"failed to create device link to management PF\n");
> +		return -ENOMEM;
> +	}
> +
> +	/*
> +	 * If func 0 began unbinding between the driver check above and
> +	 * link creation, the core's unbind-consumers pass has already
> +	 * run and missed this new link, which starts SUPPLIER_UNBIND.
> +	 * Fail the probe: the managed link is auto-purged and the core
> +	 * retries after func 0 is bound again.
> +	 */
> +	if (READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
> +		return -EPROBE_DEFER;

[Severity: Medium]

Can func 0 change state between the lockless check of
mgt->dev.links.status and device_link_add()? Func 0 unbind and func N
probe hold different device locks. In that window func 0 can go
UNBINDING -> NO_DRIVER, and possibly back to PROBING.

device_link_init_status() would then set the new link to one of:

  supplier NO_DRIVER                   -> DL_STATE_DORMANT
  supplier PROBING, consumer probing   -> DL_STATE_CONSUMER_PROBE

This check rejects neither state.

In the DORMANT case, the sibling finishes probe with no bound management
PF. device_links_driver_bound() then hits:

	WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);
	WRITE_ONCE(link->status, DL_STATE_ACTIVE);

In the CONSUMER_PROBE case, the sibling's mailbox setup races func 0's
chip-global init. The comment above the links.status check is meant to
prevent exactly that.

If func 0's probe then fails, device_links_no_driver() moves the link to
DORMANT without unbinding the sibling. A later func 0 bind makes the link
AVAILABLE. device_links_unbind_consumers() only force-unbinds ACTIVE
consumers, so a later func 0 unbind would run deinit_module while the
sibling is still bound and doing mailbox DMA.

Is there a way to close this window, rather than rejecting only
DL_STATE_SUPPLIER_UNBIND after the fact? This is still present at the end
of the series.

[Severity: Medium]

Is it safe to dereference link here? The device_link_add() kernel-doc
says that for a managed link the caller "is handing the management of the
link over to the driver core entirely and its return value can only be
used to check whether or not the link is present".

Suppose func 0 is being removed and has already passed
device_links_busy(). The new link starts in SUPPLIER_UNBIND and does not
block the removal.

If this probe thread is preempted after device_link_add() returns, func 0
removal can continue:

device_del()
  device_links_purge()
    __device_link_del()
...
device_link_release_fn()
  device_link_synchronize_removal()
  kfree(link)

Would READ_ONCE(link->status) then read freed memory? Nothing here holds
the device-links SRCU read lock or a reference on the link. This is still
present at the end of the series.

> +
> +	return 0;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928123237.88994-1-illusion.wang%40nebula-matrix.com
