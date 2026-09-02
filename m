Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADBA33263B
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 05:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327997; cv=none; b=X3ObcMcCg0O/ucZcQR2QbSporWk/vukdt5ghV3Q+1A4YuZq57miGwPxIqEd+IfT0ztosr6T1o47n3RYmJGArVW4qsRvJZ7cjAsv84oFXVo9OB/7fc5HqC7Wx2aF3TBrD5ocpgFIEIAkDUjLzfaJTjBXmYKrMhjpVZhu3EOsrbOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327997; c=relaxed/simple;
	bh=o1Z+wHt6Z4DC5zKDpA0SYmcGAJcxFpO7ZSiT4vuIzqE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f9VUUhtEAU7lH9YC73uXlYZbIEehN3gnhJtxk+4b6tg9BbFJB3H6ESg3h8tsRJ1EmABkqVQDfZsT4E1RQBVFqSIJhJIeOG2CIUi5X5aQZ7SvHkj1OUfhrl0m8zl08Be97mSJl1Zgm7jE8NWA2RkR2t7SBld/JVNLeRz7jD7HKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKMmesD+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKMmesD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E281F00A3A;
	Wed,  2 Sep 2026 05:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788327996;
	bh=YElmvIgXlIOaA9wKWm+oaBE0/UaKOhJgqq695Xz8yL0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TKMmesD+8hQjbbQbhdLnk2Gf9geO6z7WMh3q6p5gOBU6LHRz/Xa9FPQ0gCnnSwx/V
	 WfMFlFVJLe3DxfucBZLR4ThncWTLlx0E/IBQLHNQIC5RpLtd8+/QxFEHgKVZSKJHp/
	 NrM4ARLPms1SbjAg3nvdJ3eG/lKbgUgjex+Cx4Y82/rOGe8AUtO5WCqw4vJ1sHPoJo
	 zyTTORZn7EZj0yau9zkhs2XpzZbpoJpbyapdIMEZR79bSnFQ5+0g785zfKLXEe6Nfw
	 YgQ8rHLBjlMCHwgN9+dA6ilsNJ2TYvnnGCJipTUTNmm9pAyqB1qWj9HaDDYdua3zZc
	 yLav5WtNHk9lw==
Subject: Re: [net,3/4] bnxt_en: Fix driver init in kdump kernel
From: netdev-bot+sashiko@kernel.org
To: michael.chan@broadcom.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
 kalesh-anakkur.purayil@broadcom.com, scott.branden@broadcom.com
Date: Wed, 02 Sep 2026 05:46:35 +0000
Message-ID: <178832799532.3394541.18435426342767935612@kernel.org>
In-Reply-To: <20260831024342.2161156-4-michael.chan@broadcom.com>
References: <20260831024342.2161156-4-michael.chan@broadcom.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 2

- [Medium] Unchecked pcie_flr() return combined with unconditional BAR
  reprogramming in bnxt_init_one()…
- [Low] The newly added pci_save_state(pdev) call in bnxt_init_one()
  (drivers/net/ethernet/broadcom/bnxt/bnxt.c:17094) discards a…
- [Low] The new save/clear-BARs/restore sequence in bnxt_init_one() is
  left undocumented in the tree, and the only in-tree rationale for…

--

bnxt_en: Fix driver init in kdump kernel

In the kdump path, bnxt_init_one() now saves the PCI state before the
forced FLR, zeroes the BAR registers with bnxt_clear_bars() and restores
the state afterwards, so that a PCIe switch in synthetic mode observes
the BARs being (re-)initialized.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index a76674fd0d6b..c3d561ac53dc 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -17091,7 +17091,10 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	 */
>  	if (is_kdump_kernel()) {
>  		pci_clear_master(pdev);
> +		pci_save_state(pdev);

[Severity: Low]
Should the return value of pci_save_state() be checked here?

pci_save_state() saves the 64-byte header and sets dev->state_saved = true
before it attempts the capability saves:

drivers/pci/pci.c:pci_save_state() {
	...
	dev->state_saved = true;

	i = pci_save_pcie_state(dev);
	if (i != 0)
		return i;

	i = pci_save_pcix_state(dev);
	if (i != 0)
		return i;
	...
}

and pci_save_pcie_state() can fail when no save buffer was preallocated at
device add time:

drivers/pci/pci.c:pci_save_pcie_state() {
	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
	if (!save_state) {
		pci_err(dev, "buffer not found in %s\n", __func__);
		return -ENOMEM;
	}
	...
}

In that case the header/BAR portion this fix depends on is still saved, but
the PCIe capability state that pcie_flr() resets (DEVCTL MPS/MRRS, LNKCTL)
is silently left at reset defaults with no driver-side diagnostic.  Note
the pre-existing pci_save_state() call in the bnxt error recovery path
ignores the return value in the same way, so this is not a new pattern in
this driver.

>  		pcie_flr(pdev);
> +		bnxt_clear_bars(pdev);
> +		pci_restore_state(pdev);

[Severity: Medium]
Is it safe to run bnxt_clear_bars() and pci_restore_state() unconditionally
when pcie_flr() may not have reset the function?

pcie_flr() has two paths that return without ever writing
PCI_EXP_DEVCTL_BCR_FLR, plus a timeout path:

drivers/pci/pci.c:pcie_flr() {
	if (!pci_dev_config_accessible(dev, "FLR"))
		return -ENOTTY;
	...
	ret = pci_dev_reset_iommu_prepare(dev);
	if (ret) {
		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
		return ret;
	}
	...
	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
done:
	pci_dev_reset_iommu_done(dev);
	return ret;
}

If the FLR never took effect, PCI_COMMAND still carries the crashed
kernel's Memory Space Enable bit, since pci_clear_master() only clears Bus
Master Enable.  bnxt_clear_bars() then zeroes all six BAR dwords on a
function that is still decoding:

static void bnxt_clear_bars(struct pci_dev *pdev)
{
	int off;

	for (off = PCI_BASE_ADDRESS_0; off <= PCI_BASE_ADDRESS_5; off += 4)
		pci_write_config_dword(pdev, off, 0);
}

and pci_restore_state() reprograms them one dword at a time, high dword
first:

drivers/pci/pci.c:pci_restore_config_space_range() {
	for (index = end; index >= start; index--)
		pci_restore_config_dword(pdev, 4 * index,
					 pdev->saved_config_space[index],
					 force);
}

bnxt uses 64-bit memory BARs (pci_ioremap_bar(pdev, 0), pci_iomap(pdev, 2,
...), pci_ioremap_bar(pdev, 4)), so that ordering leaves a transient
(high << 32) | 0 decode window.  This is the hazard the PCI core avoids
explicitly:

drivers/pci/setup-res.c:pci_std_update_resource() {
	/*
	 * We can't update a 64-bit BAR atomically, so when possible,
	 * disable decoding so that a half-updated BAR won't conflict
	 * with another device.
	 */
	disable = (res->flags & IORESOURCE_MEM_64) && !dev->mmio_always_on;
	...
}

Would it make sense to clear PCI_COMMAND_MEMORY around the BAR writes here
as well?

The other case is a pci_dev_wait() timeout: per PCIe r4.0 sec 6.6.2 the
device may silently discard config writes while the reset is still in
progress, so the clear and restore can both be dropped.  The commit
message's guarantee that "The BARs have to be cleared to ensure that they
get re-initialized" would then not hold, and probe continues into
bnxt_get_max_irq() and the BAR0 ioremap in bnxt_init_board() with no
indication of why.

Would bailing out (or at least logging) on a non-zero pcie_flr() return be
preferable to proceeding?

>  	}
>  
>  	max_irqs = bnxt_get_max_irq(pdev);

[Severity: Low]
This isn't a bug, but the comment above this block still reads only:

	/* Clear any pending DMA transactions from crash kernel
	 * while loading driver in capture kernel.
	 */

which describes pci_clear_master() plus pcie_flr() and not the new
save / clear-BARs / restore sequence.  Could the switch-in-synthetic-mode
rationale from the changelog be added to the comment?

The reason matters because the only in-tree explanation of
bnxt_clear_bars() is in bnxt_io_slot_reset():

	/* Upon fatal error, our device internal logic that latches to
	 * BAR value is getting reset and will restore only upon
	 * rewriting the BARs.
	 *
	 * As pci_restore_state() does not re-write the BARs if the
	 * value is same as saved value earlier, driver needs to
	 * write the BARs to 0 to force restore, in case of fatal error.
	 */

After an FLR the function's own BAR registers read back as 0, so they no
longer match the saved non-zero values and pci_restore_config_dword()
would rewrite them regardless.  Applying that comment's reasoning to the
new call site would make bnxt_clear_bars() look like dead code that can be
removed, which would reintroduce the problem being fixed.  Is the intent
that the synthetic-mode switch shadows config-space reads, and can that be
spelled out next to the new call?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831024342.2161156-1-michael.chan%40broadcom.com
