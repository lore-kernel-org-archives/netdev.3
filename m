Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F5B361DA6;
	Sun,  4 Oct 2026 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791105155; cv=none; b=lQbq2aoNd6PCkYFTn9LC6FOG+GqindZXW+ufQrMCqtj5WlGdiSvulR1BMDlv1vaLCIwAV/5vLRGYcvvqomfu3V7swV4l3lomh/PcEFRBLsIG3Dq27Ut8GgKw9wM4MJTVUx6ZWz8mIGUXDrS6PZ2mGlL0ELEgc0gdor/P0XH6EC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791105155; c=relaxed/simple;
	bh=8c3RjcFW6pE/yLFR50brABHQpL59ANKYmDN02aXWuQA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SOIq98lASui2R7u4f3hXi2JuaBdPR60oP8kk0ePNWK+YBzMhCXU/WPpjoxl56+s/BcI3Y8eKRzNbWit/tVUbtRG6ihsdinGrU1bH/1RYAxYqyG79r1zDd/P2JaVSZIBxWFJjsE+GDeEEr+GQbNmEf53cuKROHaxQtNdT2YzGFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLlcGJxh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLlcGJxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B911F000FF;
	Sun,  4 Oct 2026 09:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791105152;
	bh=AM3FBYlb8dhet8/+kAyUEKhpt0wVP2T6BHfgSXua9nM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dLlcGJxhHgxgVuC37RvNHzE4GDpHntBKUMPPcSkxlT5ryuDdxztEr7XuWL+mysJaZ
	 WLn0avfO3uv5Z8TkDg7HIlYG58L+d/O1JSseaDsA7pi13dmQ2qsGA5nzXV5abuZRoP
	 SJQXBMAKi4YdgdJZE2857d2IIpKmS8AjrSnutuw3xGSBS4GUf9P0WQLnhsmdKDFA0r
	 Y4nDKRU5OS2LWe527W7qGDjC7ixuFbqdUWosq/CS1NFkD620BS6kWculqbXtst7Ntm
	 kxfwCtu8Z59iDkxGwJPGHjiJT5QPcyN5JHdd0yHHTTIdYyp9t72wGQ5JCoLo2UIBbN
	 SxJEXxfSU26Pg==
Subject: Re: [PATCH v9 1/6] net: wwan: t9xx: Add PCIe core
From: netdev-bot+sashiko@kernel.org
To: jackbb_wu@compal.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wen-zhi.huang@mediatek.com, shi-wei.yeh@mediatek.com,
 Minano.tseng@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, robert_yu@compal.com, Jeff_Chang@compal.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-doc@vger.kernel.org
Date: Sun, 04 Oct 2026 09:12:31 +0000
Message-ID: <179110515112.434549.6297698128427358633@kernel.org>
In-Reply-To: <20260930-t9xx_driver_v1-v9-1-3248b9256956@compal.com>
References: <20260930-t9xx_driver_v1-v9-1-3248b9256956@compal.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 5 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The teardown order in mtk_pci_remove() lets MSI-X handlers run
  during callback unpublication and after cancel_work_sync().
- [Medium] The commit message says 'There is no software reset that
  returns the device from running firmware to a state the next probe can…
- [Medium] mtk_pci_remove() resets the endpoint after
  pci_disable_device(), using ACPI MRST._RST or an asynchronous MHCCIF…
- [Medium] mtk_pci_atr_init() programs the endpoint's inbound WIN0 ATR
  source address with `cfg.src_addr = pci_resource_start(pdev,…
- [Medium] mtk_pci_bar_init() maps BAR0/1 and BAR2/3 with
  pcim_iomap_region(), which calls pci_iomap(pdev, bar, 0) and so maps…
- [Medium] mtk_pci_drv has no .shutdown callback.
- [Low] mtk_pci.h defines `CEI_PCI_VENDOR_ID 0x03F0`, and t9xx_pci_table
  binds `PCI_DEVICE(CEI_PCI_VENDOR_ID, 0x01CA)` with it.
- [Low] The comment in mtk_pci_bar_init() says the fixed BAR0/1 offsets
  reach only 'MSI-X registers up to 0x3080' and uses that to justify…
- [Low] mtk_pci.h defines its own `MTK_PCI_VENDOR_ID 0x14C3`, which
  duplicates PCI_VENDOR_ID_MEDIATEK (include/linux/pci_ids.h:2142, value…
- [Low] Kconfig lets MTK_T9XX be built with only `depends on PCI &&
  ACPI`, so CONFIG_PCI_MSI=n is allowed.
- [Low] Baseline assessment: false positive (retained because
  requires_validation=true).

--

net: wwan: t9xx: Add PCIe core

This commit adds the PCIe core for the MediaTek T9xx 5G WWAN modem driver.
It covers probe and remove, MSI-X setup, ATR programming and the MHCCIF
event interface. On removal the driver resets the modem through the ACPI
MRST._RST method on the device's node.

> diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
> index 88df55d78d902..55c45af410eee 100644
> --- a/drivers/net/wwan/Kconfig
> +++ b/drivers/net/wwan/Kconfig
> @@ -121,6 +121,17 @@ config MTK_T7XX
>  
>  	  If unsure, say N.
>  
> +config MTK_T9XX
> +	tristate "MediaTek PCIe 5G WWAN modem T9xx device"
> +	depends on PCI && ACPI

[Severity: Low]
Should this also depend on PCI_MSI?

mtk_pci_request_irq() asks for exactly 32 MSI-X vectors and has no INTx
fallback:

	ret = pci_alloc_irq_vectors(pdev, MTK_IRQ_CNT_MAX,
				    MTK_IRQ_CNT_MAX, PCI_IRQ_MSIX);

With CONFIG_PCI_MSI=n, the pci_alloc_irq_vectors_affinity() stub in
include/linux/pci.h returns -ENOSPC for any request other than a single
INTx vector. Probe of both supported devices would then always fail in
that configuration.

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_pci.c b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> new file mode 100644
> index 0000000000000..34ee823119fce
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> @@ -0,0 +1,1033 @@

[ ... ]

> +int mtk_pci_unregister_irq(struct mtk_md_dev *mdev, int irq_id)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	int virq_id;

[ ... ]

> +	/* Stop the source and wait for in-flight handlers
> +	 * before the callback or its data can disappear.
> +	 */
> +	mtk_pci_mask_irq(mdev, irq_id);
> +	virq_id = mtk_pci_get_virq_id(mdev, irq_id);
> +	if (virq_id >= 0)
> +		synchronize_irq(virq_id);

[Severity: Low]
This may be fine. The mask in mtk_pci_mask_irq() is a posted iowrite32(),
and it is not read back before synchronize_irq().

mtk_pci_irq_msix() seems to close that window by itself. It reads
REG_IMASK_HOST_MSIX_GRP0_0 and applies irq_state &= irq_enable before it
dispatches, so a handler that starts after synchronize_irq() should see
the mask.

The one remaining way for the source to be re-enabled is the unmask in
mtk_mhccif_isr_work(). That is covered in the comment on mtk_pci_remove()
below.

[ ... ]

> +static const struct pci_device_id t9xx_pci_table[] = {
> +	{ PCI_DEVICE(MTK_PCI_VENDOR_ID, 0x0900), MTK_PCI_CLASS, PCI_ANY_ID },

[Severity: Low]
This isn't a bug, but MTK_PCI_VENDOR_ID (0x14C3) in mtk_pci.h duplicates
PCI_VENDOR_ID_MEDIATEK from include/linux/pci_ids.h. Could the table use
PCI_VENDOR_ID_MEDIATEK, as t7xx does?

> +	{ PCI_DEVICE(CEI_PCI_VENDOR_ID, 0x01CA), MTK_PCI_CLASS, PCI_ANY_ID },

[Severity: Low]
Is CEI_PCI_VENDOR_ID the right name for 0x03F0? Other in-tree drivers
treat that vendor ID as HP. For example, t7xx_pci.c has:

	{ PCI_DEVICE(0x03f0, 0x09c8) }, // HP DRMR-H01

and mhi pci_generic.c labels 0x03f0 as "T99W175 (sdx55), HP variant".

The commit message also mentions only the T900 device. It does not say
that the driver binds this second vendor/device ID, which becomes visible
through MODULE_DEVICE_TABLE and module autoloading.

> +	{/* end: all zeroes */}
> +};

[ ... ]

> +static int mtk_pci_atr_init(struct mtk_md_dev *mdev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(mdev->dev);
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	struct mtk_atr_cfg cfg;
> +	int port, ret;
> +
> +	mtk_pci_atr_disable(priv);
> +
> +	/* Config ATR for RC to access device's register */
> +	cfg.src_addr = pci_resource_start(pdev, MTK_BAR_2_3_IDX);

[Severity: Medium]
Should this be pci_bus_address(pdev, MTK_BAR_2_3_IDX)?

pci_resource_start() returns the CPU physical address of the BAR.
mtk_pci_setup_atr() writes cfg->src_addr into
REG_ATR_PCIE_WIN0_T0_SRC_ADDR_{MSB,LSB}, and the endpoint compares that
against the PCI bus address of incoming memory TLPs.

Some hosts have a bridge window with a non-zero CPU-to-bus offset (see
pcibios_resource_to_bus()). On those hosts, would the window fail to
match BAR2 accesses? Every access through ext_reg_base (MHCCIF mask, ack
and reset) would then hit an untranslated device address.

The other possible outcome is that the 4 MiB alignment check in
mtk_pci_setup_atr() fails with -EFAULT, even though the bus address is
aligned.

t7xx has the same pattern in t7xx_pcie_mac.c, but this patch adds new
code that repeats it. It is unchanged at the end of the series. This
also depends on how the endpoint matches ATR windows, which the code
alone cannot confirm.

> +	cfg.size = ATR_PCIE_REG_SIZE;

[ ... ]

> +static int mtk_pci_bar_init(struct mtk_md_dev *mdev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(mdev->dev);
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +
> +	/* Fixed offsets used on these mappings (MSI-X registers up to
> +	 * 0x3080 on BAR0/1, the ATR-biased MHCCIF window on BAR2/3) are

[Severity: Low]
Is 0x3080 the right upper bound? mtk_pci_reg.h defines
REG_IMASK_HOST_MSIX_GRP0_0 as 0x3100, and mtk_pci_irq_msix() reads it on
every interrupt:

	irq_enable = mtk_pci_mac_read32(priv, REG_IMASK_HOST_MSIX_GRP0_0);

That makes the highest BAR0 offset accessed 0x3103. The comment is
unchanged at the end of the series.

> +	 * guaranteed by the only two devices this driver binds (0x0900,
> +	 * 0x01CA), whose BAR sizes are fixed by hardware; an undersized
> +	 * BAR here is impossible, so no pci_resource_len() checks.
> +	 */
> +	priv->mac_reg_base = pcim_iomap_region(pdev, MTK_BAR_0_1_IDX,
> +					       mdev->dev_str);

[ ... ]

> +	/* We use MD view base address "0" to observe registers */
> +	priv->ext_reg_base = priv->bar23_addr - ATR_PCIE_REG_TRSL_ADDR;

[Severity: Medium]
Can a device with smaller BARs cause out-of-bounds MMIO here?

pcim_iomap_region() maps only the BAR length the device reports, and
nothing checks pci_resource_len().

The vendor and device IDs come from the device's own config space. A
buggy or spoofed device (a Thunderbolt/USB4 enclosure, an FPGA, an
emulated device) could present 0x14C3:0x0900 or 0x03F0:0x01CA with a
4 KiB BAR2 at a 4 MiB-aligned address, and that passes the ATR alignment
check.

The driver then uses fixed offsets. For example, mtk_mhccif_init() does:

	mtk_pci_write32(mdev, MTK_MHCCIF_RC_BASE_ADDR +
			MHCCIF_EP2RC_SW_INT_EAP_MASK_SET, U32_MAX);

This writes U32_MAX to bar23_addr + 0xA030. On BAR0, probe writes
REG_IMASK_HOST_MSIX_CLR_GRP0_0 (0x3080) and the IRQ handler reads
REG_IMASK_HOST_MSIX_GRP0_0 (0x3100).

Could both BAR lengths be checked before they are used?

> +
> +	return 0;
> +}

[ ... ]

> +static void mtk_pci_remove(struct pci_dev *pdev)
> +{
> +	struct mtk_md_dev *mdev = pci_get_drvdata(pdev);
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	/* Silence every source before tearing anything down. */
> +	mtk_pci_mac_write32(priv, REG_IMASK_HOST_MSIX_CLR_GRP0_0, U32_MAX);
> +
> +	/* Unregisters the callback (masks and synchronises the vector),
> +	 * then cancels the work.  With the callback gone the work cannot
> +	 * be requeued.
> +	 */
> +	mtk_mhccif_exit(mdev);
> +	mtk_pci_free_irq(mdev);

[Severity: High]
Can the MHCCIF vector fire again while mtk_mhccif_exit() runs, or after
it returns?

mtk_mhccif_isr_work() always ends by unmasking the source:

	mtk_pci_clear_irq(mdev, priv->mhccif_irq_id);
	mtk_pci_unmask_irq(mdev, priv->mhccif_irq_id);

If the work is running when remove starts, this unmask can land after the
mask-all write above and after synchronize_irq() in
mtk_pci_unregister_irq(). The comment in mtk_mhccif_exit() ("the work
unmasks the source on its way out") seems to say the same.

A new vector 28 interrupt then runs
mtk_pci_irq_msix()->mtk_pci_irq_handler() while the handlers are still
requested.

mtk_pci_irq_handler() loads the callback and its data separately, and it
does not take irq_cb_lock:

	cb = READ_ONCE(priv->irq_cb_list[irq_id]);
	if (likely(cb)) {
		smp_rmb(); /* Ensure data is read after callback */
		cb(irq_id, priv->irq_cb_data[irq_id]);

Suppose it reads a non-NULL cb, then mtk_pci_unregister_irq() clears both
entries, and then the handler reads NULL data. In that case
mtk_mhccif_irq_cb(28, NULL) dereferences mdev->hw_priv on a NULL mdev in
hardirq context.

Now suppose the handler gets valid data but is delayed until
cancel_work_sync() has returned. mtk_mhccif_irq_cb() then does:

	queue_work(system_highpri_wq, &priv->mhccif_work);

free_irq() waits only for the handler, not for the work. After remove
returns, devres frees priv and mdev and unmaps both BARs.

The queued work would then run container_of() on freed memory, take the
freed mhccif_lock, and do MMIO through the unmapped ext_reg_base and
mac_reg_base.

The probe error path calls mtk_pci_free_irq() before mtk_mhccif_exit().
Would using that order in remove avoid this?

The ordering is unchanged at the end of the series, where
mtk_pci_dev_exit() is added in front of it.

> +	pci_clear_master(pdev);
> +	pci_disable_device(pdev);
> +
> +	/* Reset last: the endpoint comes back at power-on defaults,
> +	 * so no MMIO, config write or MSI-X teardown may follow it.
> +	 */
> +	ret = mtk_pci_pldr(mdev);
> +	if (ret && mtk_pci_link_check(mdev)) {
> +		dev_warn(dev, "PLDR failed (%d), trying MHCCIF reset\n", ret);
> +		if (mtk_pci_send_ext_evt(mdev, DEV_EVT_H2D_DEVICE_RESET))
> +			dev_err(dev, "MHCCIF reset failed\n");
> +	}

[Severity: Medium]
Does the commit message match this code? It says:

  There is no software reset that returns the device from running
  firmware to a state the next probe can boot, ... so mtk_pci_remove()
  evaluates MRST._RST on the device's own ACPI node.

This code also has a fallback. When mtk_pci_pldr() fails and the link is
still up, remove rings the MHCCIF DEV_EVT_H2D_DEVICE_RESET doorbell,
which is a software reset. mtk_pci_pldr() fails with -ENODEV on any
platform that has no ACPI handle or no MRST._RST method.

If the doorbell cannot restore a bootable state, isn't rebind broken on
every platform without MRST._RST? On those platforms every unbind would
also log "pldr method isn't supported" and the warning.

If the doorbell can restore it, is the commit message's reason for doing
the ACPI reset in remove accurate?

Probe also never checks that MRST._RST exists. For comparison, t7xx uses
its device reset doorbell only together with FASTBOOT_DL_NOTIFY, and it
always goes through MRST._RST for PLDR. This is unchanged at the end of
the series.

> +
> +	pci_load_and_free_saved_state(pdev, &priv->saved_state);
> +}

[Severity: Medium]
Does pci_load_and_free_saved_state() restore anything in hardware here?

According to the comment above, the reset brings the endpoint back at
power-on defaults, so its BARs and command register are cleared.
pci_load_and_free_saved_state() only reloads pdev->saved_config_space and
writes nothing to the device. t7xx calls pci_save_state() before the ACPI
reset and pci_restore_state() after it.

After remove returns, pci_device_remove() sets pci_dev->driver = NULL and
calls pm_runtime_put_sync(). Userspace may have enabled runtime PM
(power/control=auto, which TLP, powertop or udev rules often set on
laptops). In that case pci_pm_runtime_suspend() takes this path:

	if (!pci_dev->driver) {
		pci_save_state(pci_dev);
		return 0;
	}

That overwrites the snapshot with the reset device's config space. The
next mtk_pci_probe() then does:

	if (pdev->state_saved)
		pci_restore_state(pdev);

This writes the power-on-default BAR and command values back, so BAR MMIO
in probe would fail.

A different driver bound afterwards (for example vfio-pci through
driver_override) would see BARs the device does not decode, because only
this driver's probe restores them.

With the MHCCIF fallback, the reset is only a doorbell with no delay and
no readiness wait. Could the device reset in the middle of the next probe
and wipe the ATR and MSI-X mask setup?

This is unchanged at the end of the series.

[ ... ]

> +static struct pci_driver mtk_pci_drv = {
> +	.name = "mtk_pci_drv",
> +	.id_table = t9xx_pci_table,
> +	.probe = mtk_pci_probe,
> +	.remove = mtk_pci_remove,
> +	.err_handler = &mtk_pci_err_handler
> +};

[Severity: Medium]
Is a .shutdown callback needed here?

On reboot or kexec, remove is not called, so the modem stays in running
firmware. The commit message says no software reset can recover from that
state.

On kexec the PCI core only clears bus mastering. The next kernel's
mtk_pci_probe() reprograms the ATR tables with AXIS ports 0-3 as
transparent pass-through. It then calls pci_set_master() without
resetting the endpoint or checking mtk_pci_get_dev_state(). In the final
series this happens after mtk_pci_dev_init() and before any handshake.

Without IOMMU translation, could a DMA engine left armed by the previous
kernel (such as CLDMA with stale descriptor addresses) resume transfers
into host memory the new kernel owns?

The probe error paths also never reset the device. t7xx provides
t7xx_pci_shutdown() for this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930-t9xx_driver_v1-v9-0-3248b9256956%40compal.com
