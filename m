Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BC02D6E5C;
	Mon, 17 Aug 2026 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787006214; cv=none; b=hHbyFdVdg4rHCQGQ5X84aD87M6et+fUARHgsGFotKqK5yvrpdAUzRssNeAX51uVAQdch9Qw6XG72ikVR+KYXBmHzj4/B+ZdieuqXI7sETv8OEQR/mHN29ej2GDtwkyxOnf0kd588AZ7QTBfwcG81YzrtsLgQotl0LsBG25KpBrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787006214; c=relaxed/simple;
	bh=2M0SMe2m/siDTvZVU1sdkLJ3lLd1LCOKA2/mtW8v1D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOWqJsyuablVt5WxbQ06sbdq/VDwozn2AFnAxs1D0inadsAxPqZrKSwcpDL8sAvWOFOMyOOyaMoMijEPknwvykVe1boj40hPKUB4+kAG9Oa+EWnVWyr6oma2bSMI6tQ3Q5npRaZOqxDSHXPnZxRVBPbPdkWjMhMKPxo6Ykqxjfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksL1ztlM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksL1ztlM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0725D1F000E9;
	Mon, 17 Aug 2026 22:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787006212;
	bh=Sj+YRxnx4GqN5Bh5jRHX4Kl1Q66z4QNwWdaMurceAcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ksL1ztlMgk366w7wz76TMPgu0PpGVxzy6oAzIfJAeS7tB2bcBl3Gjd2FzE3fgitwa
	 cRyQsj+tTvrB4BuqP8qCTal6itUNeyKMTJM5pwDZ07Rgnoq1dH3Xxo6gawpuyG4kBO
	 QOIR4AeqyVcQqorUlxc9I2ZQncKTF7z20iD8JNeIx+j8duJdAptnnnniVytplAU6Lb
	 +T2AOHsndRM2SfYSt3dcRJcXegVHH2vKG7TwRyx3muLjN+jfzhub+9c6Yf0vDDsFjP
	 9NWopDMCScIVQ/8OiLBTT1DIPRiba6EWtOrIlk+5kuCiw5ZR7sbs7Vv4KLzIIV6WCv
	 d6+hgiJKkvOVw==
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
Subject: Re: [PATCH v6 1/7] net: wwan: t9xx: Add PCIe core
Date: Mon, 17 Aug 2026 15:35:25 -0700
Message-ID: <20260817223525.3688358-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-t9xx_driver_v1-v6-1-2c969fad57c6@compal.com>
References: <20260811-t9xx_driver_v1-v6-1-2c969fad57c6@compal.com>
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

This adds a new MediaTek T9xx WWAN driver skeleton: the PCIe layer with
probe/remove and MSI-X setup, the MHCCIF event channel plumbing, device
reset paths (MHCCIF, ACPI _RST, ACPI PXP._OFF/_ON), and the Kconfig and
Makefile bits. A few questions below about the interrupt dispatch, event
channel translation and teardown ordering.

The commit message says:

    Set up all the fundamental configurations for the device: PCIe layer,
    Modem Host Cross Core Interface (MHCCIF), Reset Generation
    Unit (RGU), modem common control operations and build
    infrastructure.

and

    * RGU provides interrupt channels to generate notifications
      from the device so that the T900 driver could get the
      device reset.

[Severity: Medium]
Is the RGU part accurate for this patch? Searching for rgu (case
insensitive) under drivers/net/wwan/t9xx/ returns nothing, either at this
commit or at the end of the series. mtk_pci_reg.h defines only PCIe MAC and
MHCCIF registers, enum mtk_irq_src has no RGU/reset-notification source, and
mtk_pci_probe() initialises only ATR and MHCCIF.

All resets present here are host initiated (MHCCIF
DEV_EVT_H2D_DEVICE_RESET, ACPI _RST via mtk_pci_fldr(), ACPI PXP._OFF/_ON
via mtk_pci_pldr()); there is no device to host reset notification channel.
Could the RGU wording be dropped or moved to the patch that actually adds
it?

> diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
> index 88df55d78d902..18bd40b3b8d21 100644
> --- a/drivers/net/wwan/Kconfig
> +++ b/drivers/net/wwan/Kconfig
> @@ -121,6 +121,18 @@ config MTK_T7XX
>  
>  	  If unsure, say N.
>  
> +config MTK_T9XX
> +	tristate "MediaTek PCIe 5G WWAN modem T9xx device"
> +	depends on PCI && ACPI
> +	select NET_DEVLINK

[Severity: Low]
What uses devlink here? Grepping for devlink under drivers/net/wwan/t9xx/
finds no match at this commit, and none at the tip of the series either. The
objects built for this config are only pcie/mtk_pci.o and
pcie/mtk_pci_drv_m9xx.o, so this select force-enables NET_DEVLINK for every
user of MTK_T9XX without a consumer. Can it be dropped until a devlink user
appears?

> +	help
> +	  Enables MediaTek PCIe based 5G WWAN modem (T9xx series) device.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called mtk_t9xx.
> +
> +	  If unsure, say N.
> +
>  endif # WWAN
>  
>  endmenu

[ ... ]

> diff --git a/drivers/net/wwan/t9xx/pcie/mtk_pci.c b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> new file mode 100644
> index 0000000000000..1f6cca70b74c5
> --- /dev/null
> +++ b/drivers/net/wwan/t9xx/pcie/mtk_pci.c
> @@ -0,0 +1,1029 @@

[ ... ]

> +	/* Calculate table offset */
> +	offset = ATR_PORT_OFFSET * cfg->port + ATR_TABLE_OFFSET * cfg->table;
> +	addr = REG_ATR_PCIE_WIN0_T0_SRC_ADDR_MSB + offset;
> +	val = (u32)(cfg->src_addr >> 32);
> +	mtk_pci_mac_write32(priv, addr, val);
> +
> +	addr = REG_ATR_PCIE_WIN0_T0_SRC_ADDR_LSB + offset;
> +	val = (u32)(cfg->src_addr & ATR_ADDR_ALIGN_MASK) | (atr_size << 1) | ATR_EN;
> +	mtk_pci_mac_write32(priv, addr, val);
> +
> +	addr = REG_ATR_PCIE_WIN0_T0_TRSL_ADDR_MSB + offset;
> +	val = (u32)(cfg->trsl_addr >> 32);
> +	mtk_pci_mac_write32(priv, addr, val);
> +
> +	addr = REG_ATR_PCIE_WIN0_T0_TRSL_ADDR_LSB + offset;
> +	val = (u32)(cfg->trsl_addr & ATR_ADDR_ALIGN_MASK);
> +	mtk_pci_mac_write32(priv, addr, val);
> +
> +	/* TRSL_PARAM */
> +	addr = REG_ATR_PCIE_WIN0_T0_TRSL_PARAM + offset;
> +	val = (cfg->trsl_param << ATR_PARAM_OFFSET) | cfg->trsl_id;
> +	mtk_pci_mac_write32(priv, addr, val);

[Severity: Medium]
Should ATR_EN be written last in mtk_pci_setup_atr()? The SRC_ADDR_LSB write
sets the enable bit while TRSL_ADDR_MSB/LSB and TRSL_PARAM still hold their
previous values, so the table is live with a stale translation target for
three more MMIO writes.

mtk_pci_atr_disable() clears only BIT(0), so the stale TRSL_ADDR/TRSL_PARAM
values are exactly what a prematurely enabled table would use. The four
AXI2PCI tables configured by the loop in mtk_pci_atr_init_m9xx() govern
device initiated DMA.

The t7xx driver programs the same IP in the opposite order, with an explicit
read back:

drivers/net/wwan/t7xx/t7xx_pcie_mac.c:t7xx_pcie_mac_atr_cfg() {
	...
	iowrite32(cfg->trsl_id, reg);
	...
	value = (cfg->src_addr & ...) | (atr_size << 1) | BIT(0);
	iowrite64_lo_hi(value, reg);

	/* Ensure ATR is set */
	ioread64_lo_hi(reg);
}

Would writing TRSL_ADDR and TRSL_PARAM first, then SRC_ADDR_LSB with
ATR_EN, followed by a read back, be safer here too?

> +
> +	return 0;
> +}

[ ... ]

> +static void mtk_pci_set_msix_merged(struct mtk_pci_priv *priv, int irq_cnt)
> +{
> +	mtk_pci_mac_write32(priv, REG_PCIE_CFG_MSIX, ffs(irq_cnt) * 2 - 1);
> +}

[Severity: Medium]
Does anything restore REG_PCIE_CFG_MSIX? This is the only write to that
register, and it happens only when irq_cnt != MTK_IRQ_CNT_MAX in
mtk_pci_request_irq_msix().

The probe failure paths after IRQ setup (the -ENOLINK case and the
pci_store_saved_state() failure) free the vectors but leave the merge mode
programmed, and mtk_pci_remove() does not touch it either. A later probe
that gets all 32 vectors deliberately skips programming it, assuming
power-on unmerged mode.

mtk_pci_pldr() returns -ENODEV when the bridge has no PXP._OFF/_ON, and the
MHCCIF fallback may not reset the PCIe MAC, so can a rebind end up with 32
independent per-vector descriptors while the device is still in merged
routing mode?

[ ... ]

> +int mtk_pci_register_irq(struct mtk_md_dev *mdev, int irq_id,
> +			 int (*irq_cb)(int irq_id, void *data), void *data)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +
> +	if ((irq_id < 0 || irq_id >= MTK_IRQ_CNT_MAX) || !irq_cb)
> +		return -EINVAL;
> +
> +	if (priv->irq_cb_list[irq_id]) {
> +		dev_err(mdev->dev,
> +			"Unable to register irq, irq_id=%d, it's already been register by %ps.\n",
> +			irq_id, priv->irq_cb_list[irq_id]);
> +		return -EFAULT;
> +	}
> +	priv->irq_cb_list[irq_id] = irq_cb;
> +	priv->irq_cb_data[irq_id] = data;
> +
> +	return 0;
> +}

[Severity: Medium]
Can a hardirq observe a half published callback pair here? The callback
pointer is stored before its data pointer, with no lock, no WRITE_ONCE and
no barrier, while mtk_pci_irq_handler() reads and dereferences both from
hardirq context:

	if (likely(priv->irq_cb_list[irq_id]))
		priv->irq_cb_list[irq_id](irq_id, priv->irq_cb_data[irq_id]);

so a handler can call the new callback with a NULL or stale data argument.
At the tip of the series mtk_cldma_dev_init() calls mtk_pci_register_irq()
at runtime while other MSI-X vectors are already live, since
mtk_pci_dev_init() runs after mtk_pci_request_irq() in probe.

The "already registered" test is also a plain check-then-set, so two
concurrent registrations for the same irq_id both pass and the second
silently overwrites the first.

Would publishing data before the callback pointer, and taking a lock over
both arrays, be preferable?

[ ... ]

> +int mtk_pci_unregister_irq(struct mtk_md_dev *mdev, int irq_id)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +
> +	if (irq_id < 0 || irq_id >= MTK_IRQ_CNT_MAX)
> +		return -EINVAL;
> +
> +	if (!priv->irq_cb_list[irq_id]) {
> +		dev_err(mdev->dev, "irq_id=%d has not been registered\n", irq_id);
> +		return -EFAULT;
> +	}
> +	priv->irq_cb_list[irq_id] = NULL;
> +	priv->irq_cb_data[irq_id] = NULL;
> +
> +	return 0;
> +}

[ ... ]

> +static u32 mtk_pci_ext_h2d_evt_hw_bits(u32 chs)
> +{
> +	u32 hw_bits = 0;
> +
> +	SET_HW_BITS(hw_bits, chs, MHCCIF_RC2EP_EVT_DEVICE_RESET,
> +		    DEV_EVT_H2D_DEVICE_RESET);
> +	return hw_bits;
> +}
> +
> +/**
> + * mtk_pci_send_ext_evt() - Send an MHCCIF event to the modem
> + * @mdev: MTK MD device
> + * @ch: Event channel to trigger (must be a single bit)
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
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
> +	mtk_pci_write32(mdev, rc_base + MHCCIF_RC2EP_SW_BSY, hw_bits);
> +	mtk_pci_write32(mdev, rc_base + MHCCIF_RC2EP_SW_TCHNUM, ffs(hw_bits) - 1);
> +	return 0;
> +}

[Severity: Medium]
What happens when ch is a declared channel that has no hardware mapping?
mtk_pci_ext_h2d_evt_hw_bits() translates only DEV_EVT_H2D_DEVICE_RESET, but
enum mtk_pci_evt_h2d in mtk_pci.h declares CLDMA, DPMAIF and PCIe PM
suspend/resume channels as well.

For such a channel is_power_of_2(ch) passes, hw_bits ends up 0, and then:

	mtk_pci_write32(mdev, rc_base + MHCCIF_RC2EP_SW_BSY, 0);
	mtk_pci_write32(mdev, rc_base + MHCCIF_RC2EP_SW_TCHNUM, ffs(0) - 1);

so 0xFFFFFFFF is written to the channel number register and 0 (success) is
returned to the caller.

The D2H side has the same gap: mtk_pci_ext_d2h_evt_hw_bits() and
mtk_pci_ext_d2h_evt_chs() translate only BOOT_FLOW_SYNC,
ASYNC_HS_NOTIFY_SAP and ASYNC_HS_NOTIFY_MD, so
mtk_pci_mask_ext_evt()/mtk_pci_unmask_ext_evt()/mtk_pci_clear_ext_evt()
write hw_bits == 0 and silently do nothing for every other declared
channel, although their kernel-doc says they mask, unmask or clear the
requested channels. mtk_pci_register_ext_evt() likewise accepts masks that
can never be decoded.

At the tip of the series the only callers use mapped channels
(mtk_pci_dev_reset() uses DEV_EVT_H2D_DEVICE_RESET, mtk_fsm.c uses the three
mapped D2H channels), so the bogus write is not reachable today. Should
mtk_pci_send_ext_evt() return an error when hw_bits is 0, and should the
enums be trimmed to the channels that are actually translated?

[ ... ]

> +static void mtk_mhccif_isr_work(struct work_struct *work)
> +{
> +	struct mtk_pci_priv *priv =
> +		container_of(work, struct mtk_pci_priv, mhccif_work);
> +	struct mtk_md_dev *mdev = priv->irq_desc->mdev;
> +	struct mtk_mhccif_cb *cb;
> +	u32 stat, mask, chs;
> +
> +	stat = mtk_pci_get_ext_evt_hw_status(mdev);
> +	mask = mtk_pci_read32(mdev, priv->cfg->mhccif_rc_base_addr
> +		+ MHCCIF_EP2RC_SW_INT_EAP_MASK);
> +	if (unlikely(stat == U32_MAX && !(mtk_pci_link_check(mdev)))) {
> +		/* When link failed, we don't need to unmask/clear. */
> +		dev_err(mdev->dev, "Failed to check link in MHCCIF handler.\n");
> +		return;
> +	}
> +
> +	stat &= ~mask;
> +	chs = mtk_pci_ext_d2h_evt_chs(stat);
> +	spin_lock_bh(&priv->mhccif_lock);
> +	list_for_each_entry(cb, &priv->mhccif_cb_list, entry) {
> +		if (cb->chs & chs)
> +			cb->evt_cb(cb->chs & chs, cb->data);
> +	}
> +	spin_unlock_bh(&priv->mhccif_lock);

[Severity: Low]
Is it intended that consumer callbacks run in atomic context under
mhccif_lock? A callback that sleeps is not allowed here, and a callback that
calls mtk_pci_register_ext_evt() or mtk_pci_unregister_ext_evt() would
deadlock on the same non-recursive lock. The iteration also uses
list_for_each_entry() rather than the _safe variant.

No consumer in the series hits this: the only registered callbacks at the
tip are mtk_fsm_early_bootup_handler() and mtk_fsm_hs1_handler(), both of
which only do MMIO and call mtk_fsm_evt_submit() with mode 0, which picks
GFP_ATOMIC when in_softirq() is true and only waits for EVT_MODE_BLOCKING.
Neither touches mhccif_cb_list. Could the callback contract be documented,
or the callbacks invoked outside the lock?

> +
> +	mtk_pci_clear_irq(mdev, priv->mhccif_irq_id);
> +	mtk_pci_unmask_irq(mdev, priv->mhccif_irq_id);
> +}

[ ... ]

> +static void mtk_mhccif_exit(struct mtk_md_dev *mdev)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +
> +	mtk_pci_unregister_irq(mdev, priv->mhccif_irq_id);
> +	cancel_work_sync(&priv->mhccif_work);
> +}

[Severity: Low]
Should mtk_mhccif_exit() also drain priv->mhccif_cb_list? The nodes are
kzalloc'ed in mtk_pci_register_ext_evt(), priv itself is devm freed after
remove, and mtk_pci_unregister_ext_evt() frees a node only on an exact
cb->chs == chs match, so a partial unregister just emits a dev_warn() and
leaks the node.

Nothing leaks today: the only registrations at the tip of the series are
DEV_EVT_D2H_BOOT_FLOW_SYNC in mtk_fsm.c and hs_info->mhccif_ch in
mtk_fsm_hs_info_init(), and both are unregistered with the identical mask by
mtk_fsm_exit() and mtk_fsm_hs_info_exit(). Would freeing any remaining
nodes in mtk_mhccif_exit() make the teardown self contained?

> +
> +static irqreturn_t mtk_pci_irq_handler(struct mtk_md_dev *mdev, u32 irq_state)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	int irq_id;
> +
> +	/* Check whether each set bit has a callback, if has, call it */
> +	do {
> +		irq_id = fls(irq_state) - 1;
> +		irq_state &= ~BIT(irq_id);
> +		if (likely(priv->irq_cb_list[irq_id]))
> +			priv->irq_cb_list[irq_id](irq_id, priv->irq_cb_data[irq_id]);
> +		else
> +			dev_err(mdev->dev, "Unhandled irq_id=%d, no callback for it.\n", irq_id);
> +	} while (irq_state);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t mtk_pci_irq_msix(int irq, void *data)
> +{
> +	struct mtk_pci_irq_desc *irq_desc = data;
> +	struct mtk_md_dev *mdev = irq_desc->mdev;
> +	struct mtk_pci_priv *priv;
> +	u32 irq_state, irq_enable;
> +
> +	priv = mdev->hw_priv;
> +	irq_state = mtk_pci_mac_read32(priv, REG_MSIX_ISTATUS_HOST_GRP0_0);
> +	irq_enable = mtk_pci_mac_read32(priv, REG_IMASK_HOST_MSIX_GRP0_0);
> +	irq_state &= irq_enable;

[Severity: Medium]
Should these two reads be validated for the device-gone case? When the
endpoint is unreachable (surprise removal, FLDR/PLDR in progress, link
retraining) both reads return 0xFFFFFFFF, irq_state becomes U32_MAX, both
guards below pass, and mtk_pci_irq_handler() then dispatches the callbacks
of all 32 sources as if every one were pending. The subsequent mask write to
REG_IMASK_HOST_MSIX_CLR_GRP0_0 is dropped, so the "user needs to unmask by
itself" protocol no longer holds.

mtk_pci_remove() masks only the MHCCIF vector before calling
mtk_pci_pldr(), leaving the other 31 vectors armed across the ACPI power
cycle. mtk_mhccif_isr_work() already tests for this case with
'stat == U32_MAX && !mtk_pci_link_check(mdev)' - should the MSI-X handler do
the same?

> +
> +	if (unlikely(!irq_state) ||
> +	    unlikely(!((irq_state & GENMASK(priv->irq_cnt - 1, 0)) &
> +		      irq_desc->msix_bits)))
> +		return IRQ_NONE;
> +
> +	/* Mask the bit and user needs to unmask by itself */
> +	mtk_pci_mac_write32(priv, REG_IMASK_HOST_MSIX_CLR_GRP0_0,
> +			    irq_state & ~BIT(30));
> +
> +	return mtk_pci_irq_handler(mdev, irq_state);
> +}

[Severity: High]
Can the same consumer callback run concurrently on two CPUs here? The gate
only checks that this vector's own bit is among the pending bits, but the
full bitmap is then passed to mtk_pci_irq_handler(), which invokes the
callback of every set bit.

With DPMAIF (bit 24) and CLDMA0 (bit 27) pending at the same time, two
MSI-X vectors fire on two CPUs, both latch the same irq_state (the status
read and the mask write are not atomic and nothing serialises the handlers),
and both dispatch all pending callbacks.

This also defeats the consumer teardown protocol:

drivers/net/wwan/t9xx/pcie/mtk_cldma.c:mtk_cldma_dev_exit() {
	...
	mtk_pci_mask_irq(mdev, drv_info->pci_ext_irq_id);
	synchronize_irq(virq_id);
	...
	kfree(drv_info);
}

synchronize_irq() covers only its own vector, so a handler on another vector
can still be running mtk_cldma_isr(irq_id, drv_info) after the free. Would
passing 'irq_state & irq_desc->msix_bits' to mtk_pci_irq_handler(), or
registering one handler per vector as t7xx_request_irq() does, avoid this?

> +
> +static int mtk_pci_request_irq_msix(struct mtk_md_dev *mdev,
> +				    int irq_cnt_allocated)
> +{
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	struct mtk_pci_irq_desc *irq_desc;
> +	struct pci_dev *pdev;
> +	int irq_cnt;
> +	int ret, i;
> +
> +	/* calculate the nearest 2's power number */
> +	irq_cnt = BIT(fls(irq_cnt_allocated) - 1);
> +	pdev = to_pci_dev(mdev->dev);
> +	irq_desc = priv->irq_desc;
> +	for (i = 0; i < irq_cnt; i++) {
> +		irq_desc[i].mdev = mdev;
> +		irq_desc[i].msix_bits = BIT(i);
> +		snprintf(irq_desc[i].name, MTK_IRQ_NAME_LEN, "msix%d-%s", i, mdev->dev_str);
> +		ret = pci_request_irq(pdev, i, mtk_pci_irq_msix, NULL,
> +				      &irq_desc[i], "%s", irq_desc[i].name);
> +		if (ret) {
> +			dev_err(mdev->dev, "Failed to request %s: ret=%d\n",
> +				irq_desc[i].name, ret);
> +			for (i--; i >= 0; i--)
> +				pci_free_irq(pdev, i, &irq_desc[i]);
> +			return ret;
> +		}
> +	}
> +	priv->irq_cnt = irq_cnt;
> +	priv->irq_type = PCI_IRQ_MSIX;

[Severity: Medium]
Is there a window where a handler runs before irq_cnt and irq_type are
published? pci_request_irq() makes vector 0 live immediately, but both
fields are only assigned after the loop, so an interrupt taken inside the
loop enters mtk_pci_irq_msix() with priv->irq_cnt == 0 and evaluates:

	irq_state & GENMASK(priv->irq_cnt - 1, 0)

which is GENMASK(-1, 0), i.e. a shift by BITS_PER_LONG (the input check is
inert for a non-constant high bit), so the mask is undefined.

If the handler then proceeds, mtk_mhccif_irq_cb() queues mhccif_work and
mtk_mhccif_isr_work() calls mtk_pci_clear_irq() and mtk_pci_unmask_irq(),
both of which return -EINVAL with a dev_err because priv->irq_type is still
0 while PCI_IRQ_MSIX is 4. The MHCCIF status bit then stays masked and
unacknowledged for the life of the device.

The window is open because the MHCCIF callback is already registered by
mtk_mhccif_init() and device interrupts are not masked first
(mtk_dev_cfg_0900 never sets MTK_CFG_IRQ_DFLT_MASK, so the "mask all irqs"
write in probe is skipped). Could irq_cnt and irq_type be set before the
first pci_request_irq() call?

> +
> +	if (irq_cnt != MTK_IRQ_CNT_MAX)
> +		mtk_pci_set_msix_merged(priv, irq_cnt);
> +
> +	return 0;
> +}

[Severity: High]
Does the dispatch path work at all when fewer than 32 vectors are obtained?
mtk_pci_request_irq() accepts anything from MTK_IRQ_CNT_MIN (1) upwards,
this function rounds down to a power of two and programs merged mode, but
the descriptors keep msix_bits = BIT(i) and mtk_pci_irq_handler() indexes
priv->irq_cb_list[] by the raw device bit number.

In mtk_pci_irq_msix() every status bit >= irq_cnt is discarded:

	if (unlikely(!irq_state) ||
	    unlikely(!((irq_state & GENMASK(priv->irq_cnt - 1, 0)) &
		      irq_desc->msix_bits)))
		return IRQ_NONE;

MHCCIF is irq_id 28 in mtk_dev_cfg_0900.irq_tbl and is the only interrupt
probe unmasks, so with, say, 16 vectors it is either rejected with IRQ_NONE
(status bit never cleared, event lost, and possibly a "nobody cared"
shutdown of the shared line) or, if the hardware folds the bit down,
dispatched at a low index with no registered callback ("Unhandled irq_id").
CLDMA (26, 27) and DPMAIF (24, 29, 31) behave the same way.

mtk_pci_get_virq_id() uses 'irq_id % priv->irq_cnt', which suggests merged
mode is meant to work, but the dispatch side does not implement that
mapping. Would requiring an exact vector count, as t7xx_setup_msix() does
with pci_alloc_irq_vectors(pdev, EXT_INT_NUM, EXT_INT_NUM, PCI_IRQ_MSIX), be
the simpler contract?

[ ... ]

> +static void mtk_pci_remove(struct pci_dev *pdev)
> +{
> +	struct mtk_md_dev *mdev = pci_get_drvdata(pdev);
> +	struct mtk_pci_priv *priv = mdev->hw_priv;
> +	struct device *dev = &pdev->dev;
> +
> +	mtk_pci_mask_irq(mdev, priv->mhccif_irq_id);
> +
> +	if (mtk_pci_pldr(mdev)) {
> +		dev_warn(dev, "Failed to execute PLDR, try external event\n");
> +		mtk_pci_reset(mdev, RESET_MHCCIF);
> +	}
> +
> +	pci_clear_master(pdev);
> +	mtk_pci_free_irq(mdev);
> +	mtk_mhccif_exit(mdev);
> +	pci_load_and_free_saved_state(pdev, &priv->saved_state);
> +}

[Severity: Medium]
Can mhccif_work still be queued or running when the device is reset here?
mtk_pci_pldr() evaluates PXP._OFF, sleeps 500 ms and evaluates PXP._ON (or
the fallback mtk_pci_reset(mdev, RESET_MHCCIF) runs), while
cancel_work_sync() only happens later inside mtk_mhccif_exit(), after
pci_clear_master() and mtk_pci_free_irq().

A worker running concurrently does MMIO on a device being power cycled and
finishes with:

	mtk_pci_clear_irq(mdev, priv->mhccif_irq_id);
	mtk_pci_unmask_irq(mdev, priv->mhccif_irq_id);

re-enabling the vector that remove() just masked for the rest of teardown.
The early return in mtk_mhccif_isr_work() only fires when the status read is
U32_MAX and pci_device_is_present() fails, so it does not cover a worker
that already read a valid status before the reset started.

Would mask, then free/quiesce the IRQ, then cancel_work_sync(), then reset
be the right order?

[ ... ]
-- 
pw-bot: cr
