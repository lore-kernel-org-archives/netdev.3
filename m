Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC611A3160
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790816523; cv=none; b=p1Ihy+pbBoPMnlvrMVqJdjBoZ9Fiuck4N/sCA8+I2regmxPMQFJbj7gVKuv1TYpUcAz474U6WAQ1CYXzxn31vI572f6EezwMKBxVmp/TTv9XltwGCI3DuRvJama0iEj2KG1F2xH91hgXTMigpLa2TOqN7zaicYLgba5U2gp5JqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790816523; c=relaxed/simple;
	bh=lZLr6424H/K1fXi72Gzy9hfKlfypfkJ5nge1lI5gCrY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OgZ1h8rCvguIF5mpczHHMdFSokhsLGqJg7tuioQtwZqMI9LWOyzsmUCoC0C8dGrjdQrOkJCuCOCkaQIHn3vUh4hxm83HeQtkcn2RkKiwzgQcB3/WKqjLtpxRhKt5AnXDd8RFrc1Z4dRSQqULTN9fBkuD++pgLBG8aKfX0fVjoMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdL5K9mt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdL5K9mt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3211F00898;
	Thu,  1 Oct 2026 01:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790816518;
	bh=WgIbUfWcsckCB5dhnQ9L1cA/IL2ZEVajIzxljmQXUjI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TdL5K9mtGCACRAhuvQI2DOUg28Pq/cGu/vJ/Wj7rBdnVjhZVvV7Et4ctRZ9n2ND8J
	 I1xcGmbUHOSvZxOrwYQ05eWhK47vXAPACyOciJiuAUBc/bZ8NkY5PcM6EjoITsCKcD
	 zOGNzKvleNTdPp67fiAJSdulonjmczIjjkgVCqt4+XV5FI7kzz0z0BW+FtEB8D2uRp
	 wPK4a3rvH+lJmN59CZZCU/TkWWwLUhuPk1qowrFRFAZTMW4pDU5mNcYY514KPhiqK4
	 Dmsitq27TQFaaRuu1MYrFdywKgouPURI09JxPANCTglfa9Izkfs5VXcBcZqi6COnsD
	 BrEYQa8FVdfyA==
Subject: Re: [PATCH net v2 8/9] bnxt_en: Fix driver init in kdump kernel
From: netdev-bot+sashiko@kernel.org
To: michael.chan@broadcom.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, joe@dama.to,
 kalesh-anakkur.purayil@broadcom.com, scott.branden@broadcom.com
Date: Thu, 01 Oct 2026 01:01:57 +0000
Message-ID: <179081651750.434549.17674422326504505764@kernel.org>
In-Reply-To: <20260928041712.3467803-9-michael.chan@broadcom.com>
References: <20260928041712.3467803-9-michael.chan@broadcom.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In bnxt_kdump_reset(), the path the patch adds for an
  'unresponsive after FLR' device cannot re-program the BARs.
- [Low] Two new comments in bnxt_kdump_reset()
  (drivers/net/ethernet/broadcom/bnxt/bnxt.c) promise more than…

--

bnxt_en: Fix driver init in kdump kernel

This commit adds bnxt_kdump_reset() to do a longer FLR sequence in the
kdump kernel. The sequence disables bus master and memory, saves PCI
state, does the FLR, clears the BARs and restores PCI state. It also moves
bnxt_get_max_irq() ahead of the FLR so the MSI-X capability is not read
as 0xffff afterwards.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 8c6bf10aba8a..e4530b091d3b 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -17229,6 +17229,42 @@ static void bnxt_clear_bars(struct pci_dev *pdev)
>  		pci_write_config_dword(pdev, off, 0);
>  }
>  
> +/* Clear any pending DMA transactions from crash kernel while loading driver in
> + * capture kernel.
> + */
> +static void bnxt_kdump_reset(struct pci_dev *pdev)
> +{

[ ... ]

> +	rc = pcie_flr(pdev);
> +	if (rc)
> +		dev_warn(&pdev->dev, "pcie_flr() failed (rc: %d), trying to continue\n",
> +			 rc);
> +
> +	/* A complete or partial reset has been done.  Clear the BARs
> +	 * if the device is responsive.
> +	 */

[Severity: Low]
Is this comment accurate for every non-zero return from pcie_flr()?

pcie_flr() has two error returns that happen before it sets
PCI_EXP_DEVCTL_BCR_FLR:

drivers/pci/pci.c:pcie_flr() {
	if (!pci_dev_config_accessible(dev, "FLR"))
		return -ENOTTY;
	...
	ret = pci_dev_reset_iommu_prepare(dev);
	if (ret) {
		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
		return ret;
	}

	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
	...
}

Take an ATS-capable device where __iommu_group_alloc_blocking_domain() or
__iommu_attach_device() fails. The IOMMU prepare step fails but the device
still responds. The PCI_COMMAND read below succeeds, so
bnxt_clear_bars() and pci_restore_state() run and probe continues. No
reset was ever issued, and the "pcie_flr() failed" warning is the only
sign of it.

The old code ignored the return value of pcie_flr() completely, so
continuing without a reset is not new behaviour. Still, this comment and
the function header ("Clear any pending DMA transactions from crash
kernel") both suggest the pending DMA has been handled.

Could the comments or the warning tell "reset not attempted" apart from
"reset attempted but device slow to respond"? Only the pci_dev_wait()
timeout fits the second case.

> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +	if (PCI_POSSIBLE_ERROR(cmd))
> +		dev_warn(&pdev->dev, "PCI config space inaccessible after FLR, not clearing BARs\n");
> +	else
> +		bnxt_clear_bars(pdev);
> +
> +	pci_restore_state(pdev);

[Severity: Medium]
If config space cannot be accessed here, does calling pci_restore_state()
on the same device have any effect?

Suppose pcie_flr() fails because pci_dev_wait() gives up after
PCIE_RESET_READY_POLL_MS:

drivers/pci/pci.c:pci_dev_wait() {
	...
		if (delay > timeout) {
			pci_err(dev, "not ready %dms after %s; giving up\n",
				delay - 1, reset_type);
			return -ENOTTY;
		}
	...
}

PCI_COMMAND then reads back as 0xffff, so bnxt_clear_bars() is skipped
because the device is unresponsive.

pci_restore_state() still runs, though. pci_restore_config_dword() writes
each saved BAR, COMMAND and DEVCTL value once, with no retry or read-back:

drivers/pci/pci.c:pci_restore_config_dword() {
	pci_read_config_dword(pdev, offset, &val);
	if (!force && val == saved_val)
		return;
	...
	pci_write_config_dword(pdev, offset, saved_val);
}

A function that is still in reset would drop those writes.

Nothing later in probe writes the BARs again. bnxt_init_board() only calls
pci_enable_device(), pci_set_master() and pci_ioremap_bar() with the
stored resource addresses.

The new comment above pcie_flr() says "The device may eventually respond
to HWRM_VER_GET later in the init sequence". If the device does recover
later, it has not seen its BARs programmed since the reset. Neither has a
synthetic-mode switch in front of it. Wouldn't HWRM_VER_GET over BAR0
still fail in that case?

DEVCTL MPS/MRRS would also stay at their post-reset defaults, while the
PCI core believes they were restored.

Would it make sense to fail the probe in this case? Another option is to
poll until config space is reachable and then do the clear and restore
again. The later patch in this series ("Re-write the BARs following any
type of PCIe errors") only changes bnxt_io_slot_reset(), so it does not
cover this path.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928041712.3467803-1-michael.chan%40broadcom.com
