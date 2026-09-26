Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B774756B4;
	Sat, 26 Sep 2026 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431244; cv=none; b=DtAX0cug88FkK/S1PKa6Mfjqj+WTz4eHPrpNOiGzE/vidVpLmQX/wncIFMsDQ27eaGIryPi7LsRnhjm7D6UMIlBoqTrSkW+rKvErJ8o9m6iTiCVQRI4JkdBrgzAzYLEr5pomYWR1Ez+bMDDk9apXOK/XP96OI/upK+TF5bxtYlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431244; c=relaxed/simple;
	bh=yikM+AKtohIUqrr+Q0SgT5/Syz1pvsF6j0Y/BJC2kn4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gKtrK7lsLGLMgDUNSpTqOPohIhXt+xhtCxEknCNF3BKyI4OmN/cpnuVQEm+OhudmyqhYbJbOovophILweSb7zKdcNSuehbXrWZgB1O1MfpdlcA6OmWYxHcg68Pz+2lgcxKf3tQv/bdT63OfuPa+PaEKUekRcs7QtUrgj4KtXd/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsEa8CbJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsEa8CbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAF01F00899;
	Sat, 26 Sep 2026 14:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790431231;
	bh=dqEXyS2ID2iS7WBfMt91Fs2w/CO27nRHJCpsRAGTBRs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QsEa8CbJauCHI6XuFNVHCOY7kNzkH4wq4dQ1TxW1KMkWrPOLQPZzSG7yuyF2AgOqZ
	 GTSsHnzntH4IY/qh5ntFwO8q9oKyZvCuENmrJWhj3IiMv07tgVnG84HuG35OA74qX5
	 w4oN0ppgOWRGM32FslHStw75DwYw3DvHIhhyBgR+Q4BpEGsR1xmxcMpkYtcxzRy7TE
	 s4JH5ZP4P96r8QNi8c8ZYMHLrP2+wmymWsSNl5zI7ScIXIHpYkGDl0jk4JyW5wCKyU
	 4z1SFwFV2mPVAaplS6kyVMbFTvUKJ/3V8GH4AQueXl0d/Pr90u9FJv/wvL7gR84ifj
	 F16D1/Ph0sBnQ==
Subject: Re: [PATCH v29 net-next 4/8] net/nebula-matrix: add chip-wide
 hardware init/deinit implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 26 Sep 2026 14:00:30 +0000
Message-ID: <179043123074.2160803.5955537177560212925@kernel.org>
In-Reply-To: <20260922120311.86593-5-illusion.wang@nebula-matrix.com>
References: <20260922120311.86593-5-illusion.wang@nebula-matrix.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] nbl_probe_chip_deps() creates a *managed* device link
  (DL_FLAG_AUTOREMOVE_CONSUMER, i.e. DL_FLAG_MANAGED, not…
- [Medium] Commit message bullet 2 ("Implement PCI domain/bus/slot based
  chip-wide PF registry to track active driver-bound PFs, preventing…
- [Low] nbl_hw_deinit_module() only clears the driver_status bit and
  issues a posted-write flush, and its own comment concedes that…

--

net/nebula-matrix: add chip-wide hardware init/deinit implementation

This adds Leonis chip-wide hardware init/deinit for the nbl driver,
programming the datapath sub-modules (dped/uped, dsch, ustore/dstore,
dvn/uvn, uqm, shaping) and maintaining the firmware-synced driver_status
flag.  It also registers the new hw_ops/resource_ops entry points and adds
a device link from each non-management PF to func 0.

A few questions below.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index 457e0212a7bfa..c19c60c9dd995 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c

[ ... ]

> +/*
> + * Setting driver status to false notifies firmware to clean up per-PF
> + * hardware state such as qinfo registers.
> + *
> + * Note: firmware does NOT automatically revert chip-wide registers
> + * configured in this init flow. Those chip-wide settings remain valid
> + * until chip reset or explicitly overwritten by driver.
> + *
> + * This deinit_module only clears driver active status and flush writes.
> + * It does NOT reset or restore chip-wide datapath registers.
> + *
> + * Caller must ensure no new DMA is initiated after this point.
> + * The mailbox channel is stopped by nbl_chan_teardown_queue()
> + * before this function is called, so no in-flight mailbox DMA
> + * remains.
> + */
> +static void nbl_hw_deinit_module(struct nbl_hw_mgt *hw_mgt)
> +{
> +	nbl_hw_set_driver_status(hw_mgt, false);
> +	/* ensure registers written */
> +	nbl_flush_writes(hw_mgt);
> +	/*
> +	 * Firmware cleanup is asynchronous: there is no cleanup-complete
> +	 * status register in the current hardware revision.  The posted
> +	 * write flush above only ensures driver_status reaches the chip;
> +	 * firmware may still be performing per-PF state cleanup when this
> +	 * function returns.
> +	 */
> +}

[Severity: Low]
Is there any boundary that separates the asynchronous firmware cleanup
started here from subsequent driver register programming?

nbl_hw_deinit_module() posts driver_status = 0 and flushes, and the comment
states firmware may still be modifying per-PF state on return.  There is no
status poll, mailbox ack or bounded delay.

Could a later nbl_hw_init_module() on the same chip then reprogram per-PF
and chip-wide registers while the previous cleanup pass is still running?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index 1aafed2d46d71..6df91c751bc5e 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> @@ -83,6 +83,56 @@ static void nbl_get_func_param(struct pci_dev *pdev, kernel_ulong_t driver_data,
>  		param->caps.has_ctrl = 1;
>  }
>  
> +/*
> + * Establish chip-wide dependencies for this PF:
> + *  - register it in the chip registry so control PF teardown can detect
> + *    siblings that are still bound;

[Severity: Medium]
Where is the chip registry this comment refers to?

The commit message also says:

  "2. Implement PCI domain/bus/slot based chip-wide PF registry to track
  active driver-bound PFs, preventing premature chip-global firmware
  deinitialization."

but nbl_probe_chip_deps() only does pci_get_domain_bus_and_slot() followed
by device_link_add(), with no registry insertion, and the chip-global
deinit entry point has no sibling check either:

drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c:
void nbl_res_chip_deinit_module(struct nbl_resource_mgt *res_mgt)
{
	...
	if (!common->has_ctrl)
		return;
	hw_ops->deinit_module(res_mgt->hw_ops_tbl->priv);
}

A later patch in the series repeats the claim: the comment above
nbl_dev_remove_ctrl_dev() in nbl_dev.c says "Safety net: this registry
check additionally blocks the chip-global deinit if a sibling PF is somehow
still bound on the same chip", while that function body only calls
deinit_module().

Was the registry code lost when the series was split, or should the commit
message bullet and both comment blocks be dropped?

> + *  - for every non-management PF, add a consumer->management PF device
> + *    link. The driver core then guarantees (sysfs unbind, driver
> + *    unregister, hot-unplug alike) that this consumer is released
> + *    BEFORE the func 0 supplier, which is the only teardown order in
> + *    which the chip-global firmware deinit is safe.
> + *
> + * The management PF is addressed by the deterministic identity
> + * (domain, bus, slot, func 0) instead of any name-based scan: hardware
> + * guarantees PFs are contiguous from func 0 in the same slot.
> + *
> + * The link uses DL_FLAG_AUTOREMOVE_CONSUMER, so it is dropped by the
> + * driver core when this PF detaches; it must not be removed manually.
> + * A DORMANT link (func 0 not bound yet) activates automatically once
> + * the management PF driver binds.
> + *
> + * Return: 0 on success, negative errno on failure. On failure the chip
> + * registry entry has already been rolled back.
> + */
> +static int nbl_probe_chip_deps(struct pci_dev *pdev, bool has_ctrl)
> +{
> +	struct pci_dev *mgt;
> +	int err = 0;
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
> +	if (!device_link_add(&pdev->dev, &mgt->dev,
> +			     DL_FLAG_AUTOREMOVE_CONSUMER)) {

[Severity: High]
Can this trigger a WARN in the driver core when func 0 is not bound?

DL_FLAG_AUTOREMOVE_CONSUMER implies DL_FLAG_MANAGED, and the link is
created from inside the consumer's own probe.  If the supplier has no
driver, device_link_init_status() picks the default case:

drivers/base/core.c:device_link_init_status() {
	...
	case DL_DEV_UNBINDING:
		link->status = DL_STATE_SUPPLIER_UNBIND;
		break;
	default:
		link->status = DL_STATE_DORMANT;
	...
}

and when this consumer's probe completes:

drivers/base/core.c:device_links_driver_bound() {
	...
			WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);
			WRITE_ONCE(link->status, DL_STATE_ACTIVE);
	...
}

so the link is force-promoted to ACTIVE from an illegal state with a
backtrace, rather than the behaviour the comment describes ("A DORMANT link
(func 0 not bound yet) activates automatically once the management PF
driver binds").

There is also the DL_DEV_UNBINDING window: if func 0 is being unbound,
__device_release_driver() has already run device_links_unbind_consumers()
for it before this link existed.  In that case does the ordering property
the commit message relies on ("the driver core then guarantees ... that
this consumer is released BEFORE the func 0 supplier, which is the only
teardown order in which the chip-global firmware deinit is safe") still
hold, or can the newly bound consumer outlive the management PF's
chip-global deinit?

Would returning -EPROBE_DEFER while func 0 is unbound, or using
DL_FLAG_STATELESS with an explicit device_link_del(), fit better here?

> +		dev_err(&pdev->dev,
> +			"failed to create device link to management PF %s\n",
> +			pci_name(mgt));
> +		err = -ENOMEM;
> +	}
> +	pci_dev_put(mgt);
> +	return err;
> +}
> +
>  static int nbl_probe(struct pci_dev *pdev,
>  		     const struct pci_device_id *id)
>  {
> @@ -103,6 +153,10 @@ static int nbl_probe(struct pci_dev *pdev,
>  
>  	pci_set_master(pdev);
>  
> +	err = nbl_probe_chip_deps(pdev, param.caps.has_ctrl);
> +	if (err)
> +		goto chip_deps_err;
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922120311.86593-2-illusion.wang%40nebula-matrix.com
