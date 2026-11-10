Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308634;
	b=mj4pRTqlkiDZyH4A/ez8oEGaGcA3G+KzCgP20M7rqBkLUZbpeBMA2pbstCpFltaWbi9w
	 L0Mbpm2YLypZsAMOcqQkORnCuMYdGT1z7nDNZ7/WNwlyYtTOzi004EEJAohhPTN4qYh+x
	 Vtk1N37jcmmyZHdR5df5ziVcRCysmQ8EvqKPNFonJzozHzatBIeE9s0Faphv9qt1WNDQa
	 q1w5D6dI+sL4ydlxID9/Qhyk29eyhy8PrQRqBzMfx9QcXwXS8O7dLT8pSwx0Y1C5JNAU9
	 CVzuYibOb06rlDpng345IAExwcRrem2QX7ujQaqckzLvk6M5OB7TL5nKiesNOcZ3WUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308634;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QNzDDU0a6i2LEAcjYqhv6FOLU8rHbK1ng1Hzgb9fTtQ=;
	b=jY9LAmA0/EGR8TEm7PP8E3BdJwQ579tXzpp8vXs5nN0Lo4jeP3KtOke8ehRZYUxRHW6J
	 cnbU9CUZh6nxrWsXvpOWoXfiYmIqYdOWDH+v15tbbTgx2lushdADuyRZoRVmdCRRUZxNG
	 3fwnMqEZPrhP7Kev1L6MtWPFozLUsl33XhD/F6mB80ByYxkeBOkQ6rwb4lmcsIuvs16lb
	 XufWhssT4rEcA15IuI7DwSKI60cyhchdNOiMO+Auu0q7suy2HgjE/1+olzK7sJGonjSQ6
	 QX6oPZTI0bw03mJNttLzM6Qga68XSAMmws9hLg9RrDbA8u8v9MTMtTbnynpS9zyy71w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbZk5ay6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7857606A31C;
	Tue, 10 Nov 2026 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbZk5ay6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465EA1F008A1;
	Tue, 10 Nov 2026 11:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794308633;
	bh=QNzDDU0a6i2LEAcjYqhv6FOLU8rHbK1ng1Hzgb9fTtQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QbZk5ay6twrd8p0CDlxAK1Z8Zqud9jDaFsgVHp8H/+m5PBCqy6NH7uj8QVQDttyta
	 YttuwgxWuRxME2Vv+hZpqNCUEsvBhVy683lqf25Fw9KZT8FfE7I24nhCdQH8TG1pCj
	 hiYnb7W/JFHh5WYVRAKuOh/0mC7zhN7ub4kxF1jGyiWf2aEeSIypk+SZb10wp3SDLv
	 k0+qpZDQD67W2isy3kqmGO7r5ONveF9NwAb0zM7rn8sBccNsv8jR5Fu6IgDeledqzt
	 HugCki5GjW4bH7xAshvg9a67algPeGfPyk22ELSRVZGKLxrBiAADj68SV+KlPAi0mi
	 ncYuUbqnokvng==
Subject: Re: [PATCH v11 1/6] net: wwan: t9xx: Add PCIe core
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
Date: Tue, 10 Nov 2026 11:03:51 +0000
Message-ID: <179430863179.994134.3831157543887487578@kernel.org>
In-Reply-To: <20261105-t9xx_driver_v1-v11-1-2084aa512864@compal.com>
References: <20261105-t9xx_driver_v1-v11-1-2084aa512864@compal.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The modem is reset only on the way down, in mtk_pci_remove()
  and in mtk_pci_shutdown() (which calls mtk_pci_remove()).
- [Medium] In mtk_pci_remove(), which every shutdown also reaches through
  mtk_pci_shutdown(), the MHCCIF doorbell fallback runs when…
- [Medium] mtk_pci_bar_init() maps BAR0/1 and BAR2/3 with
  pcim_iomap_region(), which maps exactly the BAR length the device…
- [Medium] mtk_pci_request_irq() allocates exactly 32 MSI-X vectors.
- [Low] mtk_pci_bar_init() passes mdev->dev_str as the @name argument to
  both pcim_iomap_region() calls.
- [Low] mtk_pci_remove() writes U32_MAX to
  REG_IMASK_HOST_MSIX_CLR_GRP0_0, then calls mtk_pci_free_irq(), and…

--

net: wwan: t9xx: Add PCIe core

This adds the PCIe core of the MediaTek T9xx 5G WWAN modem driver. It
covers probe and remove, MSI-X setup, the MHCCIF event interface and the
register access helpers. Remove and shutdown reset the modem through the
ACPI MRST._RST method, with an MHCCIF reset doorbell as the fallback.

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_pci.c b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> new file mode 100644
> index 0000000000000..902bcbe1512e9
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> @@ -0,0 +1,1044 @@

[ ... ]

> +static int mtk_pci_bar_init(struct mtk_md_dev *mdev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(mdev->dev);
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +
> +	/* Fixed offsets used on these mappings (MSI-X registers up to
> +	 * 0x3103 on BAR0/1, the ATR-biased MHCCIF window on BAR2/3) are
> +	 * guaranteed by the only two devices this driver binds (0x0900,
> +	 * 0x01CA), whose BAR sizes are fixed by hardware.  A device that
> +	 * misreports them is out of scope rather than impossible, so no
> +	 * pci_resource_len() checks.
> +	 */
> +	priv->mac_reg_base = pcim_iomap_region(pdev, MTK_BAR_0_1_IDX,
> +					       mdev->dev_str);

[Severity: Medium]
pcim_iomap_region() maps exactly the BAR length the device reports. Binding
only needs a vendor/device/class match. So what happens with a device that
spoofs 14c3:0900 or 03f0:01ca and reports small BARs, for example a
hot-plugged Thunderbolt/USB4 device? It would get these fixed-offset
accesses:

  mtk_pci_probe() writes U32_MAX at BAR0 + 0x3080
  mtk_pci_irq_msix() reads BAR0 + 0x0F00 and BAR0 + 0x3100
  mtk_mhccif_init() writes U32_MAX at bar23_addr + 0xA030 (via ext_reg_base)

The comment treats such a device as out of scope. Still, can these writes
land past the ioremap area and its guard page, in neighbouring ioremap or
vmalloc mappings?

Two pci_resource_len() checks (BAR0 >= 0x3104, BAR2 >= 0xA044) look like
enough to rule this out.

> +	if (IS_ERR(priv->mac_reg_base)) {
> +		dev_err(mdev->dev, "Failed to map BAR0/1\n");
> +		return PTR_ERR(priv->mac_reg_base);
> +	}
> +
> +	priv->bar23_addr = pcim_iomap_region(pdev, MTK_BAR_2_3_IDX,
> +					     mdev->dev_str);

[Severity: Low]
Is mdev->dev_str the intended name argument for both pcim_iomap_region()
calls? The kernel-doc in drivers/pci/devres.c describes @name as "Name of
the driver requesting the resource". It becomes the resource name in
/proc/iomem and in resource conflict messages.

dev_str is a copy of pci_name(pdev), so the BARs get labelled with the PCI
address (e.g. 0000:01:00.0) instead of mtk_t9xx. t7xx passes DRIVER_NAME
to the same API. Would KBUILD_MODNAME work here?

[ ... ]

> +static int mtk_pci_request_irq(struct mtk_md_dev *mdev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(mdev->dev);
> +	int ret;
> +
> +	ret = pci_alloc_irq_vectors(pdev, MTK_IRQ_CNT_MAX,
> +				    MTK_IRQ_CNT_MAX, PCI_IRQ_MSIX);
> +	if (ret < 0) {
> +		dev_err(mdev->dev,
> +			"Unable to alloc %d MSI-X vectors: ret=%d\n",
> +			MTK_IRQ_CNT_MAX, ret);
> +		return ret;
> +	}
> +
> +	ret = mtk_pci_request_irq_msix(mdev);
> +	if (ret)
> +		pci_free_irq_vectors(pdev);
> +
> +	return ret;
> +}

[Severity: Medium]
Should the device's MSI-X vector configuration be programmed here? The
handler only takes status bit i on vector i:

mtk_pci_irq_msix() {
    ...
	irq_state &= irq_desc->msix_bits; /* scope to this vector */
	if (unlikely(!irq_state))
		return IRQ_NONE;
    ...
}

Nothing writes the MAC register that tells the device how many host
vectors exist.

The register map matches t7xx: ISTATUS at 0x0F00, IMASK SET/CLR at
0x3000/0x3080, and the status dummy register at 0x0D1C. t7xx writes
T7XX_PCIE_CFG_MSIX (0x03ec) with ffs(irq_count) * 2 - 1 after allocating
its vectors:

t7xx_setup_msix()
  t7xx_pcie_set_mac_msix_cfg(t7xx_dev, EXT_INT_NUM)

It writes it again in t7xx_pcie_interrupt_reinit().

Here the 1:1 layout depends on the register's reset or leftover value. If
that value merges sources onto fewer vectors, would the MHCCIF source
(bit 28) land on a vector whose handler drops it and returns IRQ_NONE?

That would leave the boot handshake unserviced. The spurious IRQ detector
could also end up disabling the line.

[ ... ]

> +static void mtk_pci_remove(struct pci_dev *pdev)
> +{
> +	struct mtk_md_dev *mdev = pci_get_drvdata(pdev);
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	struct device *dev = &pdev->dev;
> +	int i, ret;
> +
> +	/* Silence every source before tearing anything down. */
> +	mtk_pci_mac_write32(priv, REG_IMASK_HOST_MSIX_CLR_GRP0_0, U32_MAX);
> +
> +	/* Free the vectors first: once no handler can run, the unmask at the
> +	 * tail of mtk_mhccif_isr_work() cannot re-open the source behind
> +	 * mtk_mhccif_exit()'s back.
> +	 */
> +	mtk_pci_free_irq(mdev);
> +	mtk_mhccif_exit(mdev);

[Severity: Low]
Does this ordering give the guarantee the comment describes?
cancel_work_sync() only runs later, inside mtk_mhccif_exit(). So a
mhccif_work queued before the mask-all write can still run after
mtk_pci_free_irq(), and it ends with:

mtk_mhccif_isr_work() {
    ...
	mtk_pci_unmask_irq(mdev, priv->mhccif_irq_id);
}

This writes BIT(28) to REG_IMASK_HOST_MSIX_SET_GRP0_0. By then
pci_free_irq_vectors()->pci_msix_shutdown() has cleared
PCI_MSIX_FLAGS_ENABLE and called pci_intx_for_msi(dev, 1). The source is
unmasked with INTx enabled until mtk_mhccif_exit() masks it again.

There is a second window between the mask-all write and
mtk_pci_free_irq(). A pending work can unmask the source there, take a new
MSI-X interrupt and requeue itself.

The end state is masked. Would calling mtk_mhccif_exit() before
mtk_pci_free_irq() close both windows? While the vectors still exist,
mtk_pci_unregister_irq() gets a valid virq for synchronize_irq(), and
cancel_work_sync() plus the final mask finish before the vectors are
freed.

> +	pci_clear_master(pdev);
> +	pci_disable_device(pdev);
> +
> +	/* Reset last: the endpoint comes back at power-on defaults, so no MMIO
> +	 * and no MSI-X teardown may follow it.
> +	 */
> +	ret = mtk_pci_pldr(mdev);
> +	if (!ret) {
> +		/* MRST._RST may return before the link has retrained, and a
> +		 * config write the device does not take is simply lost.
> +		 */
> +		for (i = 0; i < MTK_PLDR_READY_POLLS && !mtk_pci_link_check(mdev); i++)
> +			msleep(MTK_PLDR_READY_POLL_MS);
> +		if (!mtk_pci_link_check(mdev))
> +			dev_warn(dev, "device not back %d ms after reset, its config space may not be restored\n",
> +				 MTK_PLDR_READY_POLLS * MTK_PLDR_READY_POLL_MS);
> +	} else if (!mtk_pci_link_check(mdev)) {
> +		dev_warn(dev, "PLDR failed (%d) and link is down, modem not reset\n", ret);
> +	} else {
> +		dev_warn(dev, "PLDR failed (%d), trying MHCCIF reset\n", ret);
> +		if (mtk_pci_send_ext_evt(mdev, DEV_EVT_H2D_DEVICE_RESET)) {
> +			dev_err(dev, "MHCCIF reset failed\n");
> +		} else {
> +			/* Unlike MRST._RST the doorbell returns before the device
> +			 * has reset, so let it settle before the restore below.
> +			 */
> +			msleep(MTK_MHCCIF_RESET_DELAY_MS);
> +		}
> +	}

[Severity: Medium]
The PLDR branch polls mtk_pci_link_check() because "a config write the
device does not take is simply lost", and it warns if the device has not
come back. The doorbell branch only sleeps a fixed 2000 ms and then goes
on to the restore.

If the doorbell reset takes the endpoint off the link and it has not
retrained within 2 s, are the pci_restore_state() writes below silently
dropped?

pci_load_and_free_saved_state() has already freed priv->saved_state and
set it to NULL, and pci_restore_state() clears dev->state_saved. Nothing
is left to retry with. Would the next bind then see BARs the device does
not decode, with nothing in the log?

Probe allows platforms without MRST._RST, and there every remove and
shutdown takes this branch. Could it use the same link poll and warning
as the PLDR branch?

> +
> +	/* Without this a runtime-PM suspend after unbind would snapshot the
> +	 * reset state over our copy, and whoever binds next finds BARs the
> +	 * device does not decode.
> +	 */
> +	pci_load_and_free_saved_state(pdev, &priv->saved_state);
> +	pci_restore_state(pdev);
> +}
> +
> +/* A kexec reboot neither resets nor powers down the slot, and the boot
> + * notification the next kernel waits for is one-shot, so reset the modem
> + * on the way down the same way remove() does.
> + */
> +static void mtk_pci_shutdown(struct pci_dev *pdev)
> +{
> +	mtk_pci_remove(pdev);
> +}

[Severity: Medium]
The commit message says the shutdown reset is needed because "a kexec
reboot gets no platform reset and the next kernel would otherwise find
that firmware still running". Is crash kexec (kdump, kexec -p) covered?
That path is:

__crash_kexec()
  machine_crash_shutdown()
  machine_kexec()

It never calls device_shutdown(), so mtk_pci_shutdown() does not run. The
capture kernel then probes a modem whose firmware is still running.

By then the crashed kernel's mtk_mhccif_isr_work() has already acked
BOOT_FLOW_SYNC, and the comment in mtk_mhccif_init() says:

	 * Do NOT ack here: EP2RC status bits are latched one-shot
	 * notifications (e.g. BOOT_FLOW_SYNC raised before the driver
	 * loads) that the device never re-sends.

mtk_pci_probe() neither resets the modem nor checks whether firmware is
already running. Would the boot flow wait for a BOOT_FLOW_SYNC that never
comes? Later in the series, mtk_fsm_dev_add_act() moves to FSM_STATE_ON,
unmasks BOOT_FLOW_SYNC and waits.

The same state also seems reachable after mtk_pci_remove() if the reset
does not take effect. That covers a down link, or no MRST._RST combined
with firmware that ignores the doorbell. The commit message says the
doorbell "cannot recover firmware that has stopped responding - the case
the reset exists for".

Resetting the modem, or detecting running firmware, in probe would cover
these cases. It would also remove the 1-2 s wait that every reboot and
power-off now has, which still does not help kdump.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105-t9xx_driver_v1-v11-0-2084aa512864%40compal.com
