Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3453C314A90;
	Sat, 19 Sep 2026 23:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789862092; cv=none; b=A/V6WFAucUkXk5wUc1KdWX6Ny/mjdylW0rgiTTRoVvVi1mWH3mNtZiwxIrU1SCXp2/GNPtN83wHzbCia9HpqKhxlrIf1IHrMxJ2KD6xPEdVpccXnK41IMlQcnd2tZjk0xAHgnPWE9zq1iSrQUnuHARXPkVdq7rQVIXXKJ3mxx3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789862092; c=relaxed/simple;
	bh=Bw+ab6sGk/mpytIlT1WE5QkAYGSTA8tHg60l9Qx0qM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snWCifmqM66sCcMFGSwyAO2FoM38gCvJFNlVHW46f24RtKRZ0surWeJ+k4DgTWPxLjUGvAFszb1S1mhIB7lZRH4V2PAX+vnez8h8uAmGLy8P6dN4Vf1DnQ0ERNAyYqXYQsMMkBt0Kf4K/e0B+Yp/XBJv5bwqIZuAJkAWWSUypI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Csd0zJx3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Csd0zJx3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF1C1F00898;
	Sat, 19 Sep 2026 23:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789862090;
	bh=Ks218AcebVpION5XJyOQUnNqOhWIRHLgeLn8S/kBrk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Csd0zJx30//YYYxZtQykiIYLxfTZ52zKawyiEUT50a9JX/TfZUOiszd2hekUwO62z
	 qYYmihy7qw5/980h+t90A+Q7mgPzIbRN2+52bH00+hUP0khLrWx7BoyOZf6611XnxL
	 9WIysuiHMBeQn0p1fdxFt/DYsDeLNmAhgmqEOzROYaEfT206nSQN3PMKCNwZj7ngSg
	 4GvTjkIoDucRV1XoXUjSRWCKaeb/IokQ1YYueVrCoAs+1tVg0TarRl585e/ZcMEufv
	 wg956kCeUVOwD1L/s332gu/NZSFcNX6xY/YBAY2eQg3O7yF3yvFtReNIVTRcO65Kbn
	 kr2dMJ1kn0Z5w==
From: Jakub Kicinski <kuba@kernel.org>
To: jackbb_wu@compal.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	wen-zhi.huang@mediatek.com,
	shi-wei.yeh@mediatek.com,
	Minano.tseng@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	robert_yu@compal.com,
	Jeff_Chang@compal.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 1/6] net: wwan: t9xx: Add PCIe core
Date: Sat, 19 Sep 2026 16:54:48 -0700
Message-ID: <20260919235449.839711-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914-t9xx_driver_v1-v8-1-5206c2e6bea0@compal.com>
References: <20260914-t9xx_driver_v1-v8-1-5206c2e6bea0@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wwan: t9xx: Add PCIe core

This adds the T9xx PCIe layer: probe/remove, MSI-X setup and teardown,
the MHCCIF doorbell channels used for the boot handshake, and the modem
register/interrupt helpers.  Removal resets the endpoint by evaluating
MRST._RST on the device's ACPI node, falling back to the MHCCIF reset
doorbell.

A few questions on the interrupt teardown ordering, the reset path and a
couple of smaller items below.

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_pci.c b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> new file mode 100644
> index 0000000000000..eb72efc19652d
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> @@ -0,0 +1,1020 @@

[ ... ]

> +int mtk_pci_get_virq_id(struct mtk_md_dev *mdev, int irq_id)
> +{
> +	struct pci_dev *pdev = to_pci_dev(mdev->dev);
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +
> +	if (irq_id < 0 || irq_id >= priv->irq_cnt)
> +		return -EINVAL;
> +
> +	return pci_irq_vector(pdev, irq_id);
> +}

[ ... ]

> +int mtk_pci_unregister_irq(struct mtk_md_dev *mdev, int irq_id)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	int virq_id;
> +
> +	if (irq_id < 0 || irq_id >= MTK_IRQ_CNT_MAX)
> +		return -EINVAL;
> +
> +	if (!READ_ONCE(priv->irq_cb_list[irq_id])) {
> +		dev_err(mdev->dev, "irq_id=%d has not been registered\n", irq_id);
> +		return -EFAULT;
> +	}
> +
> +	/* Stop the source and wait for in-flight handlers
> +	 * before the callback or its data can disappear.
> +	 */
> +	mtk_pci_mask_irq(mdev, irq_id);

[Severity: Low]
Should the three helpers agree on what makes an irq_id valid?

mtk_pci_mask_irq(), mtk_pci_unmask_irq() and mtk_pci_clear_irq() bound
irq_id by MTK_IRQ_CNT_MAX and additionally require
priv->irq_type == PCI_IRQ_MSIX, while mtk_pci_get_virq_id() bounds the
same value by priv->irq_cnt.  mtk_pci_unregister_irq() has to satisfy
both.

On the probe failure path that jumps to free_mhccif, either
pci_alloc_irq_vectors() or mtk_pci_request_irq_msix() failed, so
priv->irq_type is 0 and priv->irq_cnt is 0.  mtk_mhccif_exit() then
calls mtk_pci_unregister_irq() -> mtk_pci_mask_irq(), which logs

	dev_err(mdev->dev, "Failed to mask irq: input irq_id=%d\n", irq_id);

for irq_id 28 during otherwise correct cleanup, and
mtk_pci_get_virq_id() rejects the id the other helpers consider in
range.  Would it be clearer to document the irq_type precondition and
have the mask/unmask/clear helpers return quietly (or use dev_dbg) when
no vectors are allocated?

> +	virq_id = mtk_pci_get_virq_id(mdev, irq_id);
> +	if (virq_id >= 0)
> +		synchronize_irq(virq_id);
> +
> +	spin_lock(&priv->irq_cb_lock);
> +	WRITE_ONCE(priv->irq_cb_list[irq_id], NULL);
> +	priv->irq_cb_data[irq_id] = NULL;
> +	spin_unlock(&priv->irq_cb_lock);
> +
> +	return 0;
> +}

[ ... ]

> +int mtk_pci_send_ext_evt(struct mtk_md_dev *mdev, u32 ch)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	u32 rc_base, hw_bits;
> +
> +	rc_base = priv->cfg->mhccif_rc_base_addr;
> +
> +	/* Only allow one ch to be triggered at a time */
> +	if (!is_power_of_2(ch)) {
> +		dev_err(mdev->dev, "Unsupported ext evt ch=0x%08x\n", ch);
> +		return -EINVAL;
> +	}
> +
> +	hw_bits = mtk_pci_ext_h2d_evt_hw_bits(ch);
> +	if (!hw_bits) {
> +		dev_err(mdev->dev, "Unmapped ext evt ch=0x%08x\n", ch);
> +		return -EINVAL;
> +	}
> +
> +	mtk_pci_write32(mdev, rc_base + MHCCIF_RC2EP_SW_BSY, hw_bits);
> +	mtk_pci_write32(mdev, rc_base + MHCCIF_RC2EP_SW_TCHNUM, ffs(hw_bits) - 1);
> +	return 0;
> +}

[ ... ]

> +int mtk_pci_pldr(struct mtk_md_dev *mdev)
> +{
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_status acpi_ret;
> +	acpi_handle handle;

[ ... ]

> +	acpi_ret = acpi_evaluate_object(handle, "MRST._RST", NULL, &buffer);
> +	if (ACPI_FAILURE(acpi_ret)) {
> +		dev_err(mdev->dev, "Failed to execute MRST._RST method: %s\n",
> +			acpi_format_exception(acpi_ret));
> +		return -EIO;
> +	}
> +	acpi_os_free(buffer.pointer);

[Severity: Low]
Can this error return leak buffer.pointer?

The result object is never used here, but ACPI_ALLOCATE_BUFFER is
requested, and acpi_evaluate_object() can fail with the caller buffer
already allocated:

drivers/acpi/acpica/nsxfeval.c:acpi_evaluate_object() {
	...
	status = acpi_ut_initialize_buffer(return_buffer, buffer_space_needed);
	if (ACPI_FAILURE(status)) {
		...
	} else {
		status = acpi_ut_copy_iobject_to_eobject(info->return_object, return_buffer);
	}
	...
}

If acpi_ut_copy_iobject_to_eobject() fails after the buffer was
allocated (for example AE_NO_MEMORY while building a package), the
-EIO return here skips acpi_os_free().  Since the returned object is
unused, would passing NULL as the return buffer be simpler?

> +
> +	return 0;
> +}

[ ... ]

> +static void mtk_mhccif_isr_work(struct work_struct *work)
> +{

[ ... ]

> +	chs = mtk_pci_ext_d2h_evt_chs(stat);
> +	/* Callbacks must not sleep or modify mhccif_cb_list */
> +	spin_lock_bh(&priv->mhccif_lock);
> +	list_for_each_entry(cb, &priv->mhccif_cb_list, entry) {
> +		if (cb->chs & chs)
> +			cb->evt_cb(cb->chs & chs, cb->data);
> +	}
> +	spin_unlock_bh(&priv->mhccif_lock);
> +
> +	mtk_pci_clear_irq(mdev, priv->mhccif_irq_id);
> +	mtk_pci_unmask_irq(mdev, priv->mhccif_irq_id);
> +}

[Severity: Medium]
Can this tail re-enable the MSI-X source after teardown has masked it?

Nothing appears to serialize the worker against removal:

CPU0                              CPU1
mtk_mhccif_isr_work()
  ... past spin_unlock_bh()
                                  mtk_pci_remove()
                                    write REG_IMASK_HOST_MSIX_CLR_GRP0_0 = U32_MAX
                                    mtk_mhccif_exit()
                                      mtk_pci_unregister_irq()
                                        mtk_pci_mask_irq()
                                        synchronize_irq(virq)
  mtk_pci_clear_irq()
  mtk_pci_unmask_irq()
    write REG_IMASK_HOST_MSIX_SET_GRP0_0 = BIT(28)
                                      cancel_work_sync()

synchronize_irq() only waits for the hardirq handler, not for the
already-running work item, and priv->irq_type is still PCI_IRQ_MSIX at
that point so the unmask write goes through.  cancel_work_sync() then
returns with the source enabled, and the rest of mtk_pci_remove()
(pci_free_irq(), pci_free_irq_vectors(), the reset) runs without the
"Silence every source before tearing anything down" property it
assumes.  A later assertion in that window reaches
mtk_pci_irq_handler() with no registered callback and only produces
dev_err_ratelimited("Unhandled irq_id=28").

Would a re-mask after cancel_work_sync(), or a teardown flag checked
before the clear/unmask pair, close this?

[ ... ]

> +static int mtk_pci_bar_init(struct mtk_md_dev *mdev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(mdev->dev);
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +
> +	priv->mac_reg_base = pcim_iomap_region(pdev, MTK_BAR_0_1_IDX,
> +					       mdev->dev_str);
> +	if (IS_ERR(priv->mac_reg_base)) {
> +		dev_err(mdev->dev, "Failed to map BAR0/1\n");
> +		return PTR_ERR(priv->mac_reg_base);
> +	}
> +
> +	priv->bar23_addr = pcim_iomap_region(pdev, MTK_BAR_2_3_IDX,
> +					     mdev->dev_str);
> +	if (IS_ERR(priv->bar23_addr)) {
> +		dev_err(mdev->dev, "Failed to map BAR2/3\n");
> +		return PTR_ERR(priv->bar23_addr);
> +	}
> +
> +	/* We use MD view base address "0" to observe registers */
> +	priv->ext_reg_base = priv->bar23_addr - ATR_PCIE_REG_TRSL_ADDR;
> +
> +	return 0;
> +}

[Severity: Low]
This isn't a bug, but would a pci_resource_len() sanity check here be
worth adding?

Both mappings are used with fixed offsets afterwards, for example
REG_IMASK_HOST_MSIX_CLR_GRP0_0 (0x3080) on BAR0/1 in mtk_pci_probe(),
and mhccif_rc_base_addr 0x1000A000 relative to the biased
ext_reg_base (bar23_addr + 0xA030) in mtk_mhccif_init().  The
mtk_pci_mac_write32() and mtk_pci_write32() accessors in mtk_pci.h add
those offsets without any range enforcement, so a device reporting
undersized BARs would be written outside the ioremap mapping.  The
sibling t7xx driver has the same pattern, so this is hardening rather
than a defect.

[ ... ]

> +static void mtk_mhccif_exit(struct mtk_md_dev *mdev)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	struct mtk_mhccif_cb *cb, *tmp;
> +
> +	mtk_pci_unregister_irq(mdev, priv->mhccif_irq_id);
> +	cancel_work_sync(&priv->mhccif_work);
> +
> +	list_for_each_entry_safe(cb, tmp, &priv->mhccif_cb_list, entry) {
> +		list_del(&cb->entry);
> +		kfree(cb);
> +	}
> +}

[ ... ]

> +static int mtk_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{

[ ... ]

> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		dev_err(mdev->dev, "Failed to enable pci device.\n");
> +		goto log_err;
> +	}

[ ... ]

> +	return 0;
> +
> +clear_master:
> +	pci_clear_master(pdev);
> +	mtk_pci_free_irq(mdev);
> +free_mhccif:
> +	mtk_mhccif_exit(mdev);
> +log_err:
> +	dev_err(dev, "Failed to probe device, ret=%d\n", ret);
> +
> +	return ret;
> +}

[Severity: Medium]
On the clear_master path, is the ordering here inverted with respect to
mtk_pci_remove()?

mtk_pci_free_irq() runs before mtk_mhccif_exit(), so an MHCCIF work
item queued by mtk_mhccif_irq_cb() just before the failure can still
be running when pci_free_irq() and pci_free_irq_vectors() complete.
Its tail then does

	mtk_pci_clear_irq(mdev, priv->mhccif_irq_id);
	mtk_pci_unmask_irq(mdev, priv->mhccif_irq_id);

touching the interrupt mask registers after the IRQ action and the
MSI-X vectors are gone.  Should this path call mtk_mhccif_exit() (which
unregisters the callback and cancels the work) before
mtk_pci_free_irq(), the way mtk_pci_remove() does?

> +
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
> +	pci_clear_master(pdev);
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
Can the "no MMIO, config write or MSI-X teardown may follow it"
invariant hold while probe uses pcim_enable_device()?

pcim_enable_device() installs a devres action that the driver core runs
in devres_release_all(), after remove() returns:

drivers/pci/devres.c:pcim_enable_device() {
	...
	devm_add_action(&pdev->dev, pcim_disable_device, pdev);
	...
}

and that action reaches do_pci_disable_device(), which does a
PCI_COMMAND config read and, if the read shows PCI_COMMAND_MASTER, a
config write.  On an endpoint that was just reset the read can return
0xFFFF (which has that bit set), so a config write of 0xFFFB is then
attempted on a possibly link-down device.  Would moving the reset out
of the tail of remove(), or using the non-managed pci_enable_device()
with an explicit disable before the reset, keep the stated ordering?

A second question on the same path: neither reset waits for
completion.  mtk_pci_send_ext_evt() only performs two posted BAR
writes (MHCCIF_RC2EP_SW_BSY and MHCCIF_RC2EP_SW_TCHNUM) with no
readback, and there is no delay or presence poll after either reset
before remove() returns.  An immediate re-bind then runs
mtk_pci_probe() -> atr_init() -> mtk_pci_atr_disable(), which
read-modify-writes the BAR0 ATR registers:

	val = mtk_pci_mac_read32(priv, REG_ATR_PCIE_WIN0_T0_SRC_ADDR_LSB + offset);
	val = val & (~BIT(0));
	mtk_pci_mac_write32(priv, REG_ATR_PCIE_WIN0_T0_SRC_ADDR_LSB + offset, val);

On a still-resetting device the reads come back as all ones and the
writes are dropped, yet probe treats this as success; mtk_pci_link_check()
is only consulted later, after MSI-X setup.  For comparison, t7xx sleeps
FASTBOOT_RESET_DELAY_MS after its equivalent doorbell in
t7xx_modem_ops.c.  Should this path wait for the endpoint to settle?

> +
> +	pci_load_and_free_saved_state(pdev, &priv->saved_state);
> +}
> +
> +static pci_ers_result_t mtk_pci_error_detected(struct pci_dev *pdev,
> +					       pci_channel_state_t state)
> +{
> +	struct mtk_md_dev *mdev = pci_get_drvdata(pdev);
> +
> +	dev_err(mdev->dev, "AER detected: pci_channel_state_t=%d\n", state);

[Severity: Low]
This isn't a bug, but pci_channel_state_t is declared in
include/linux/pci.h as

	typedef unsigned int __bitwise pci_channel_state_t;

so %d degrades the sparse-restricted unsigned type to signed int, which
make C=1 reports as "restricted pci_channel_state_t degrades to
integer".  Would %u with an explicit cast be preferable here?

> +
> +	/* AER recovery not supported, disconnect the device */
> +	return PCI_ERS_RESULT_DISCONNECT;
> +}

[ ... ]
