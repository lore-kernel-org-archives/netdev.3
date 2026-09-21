Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE6033C1BE;
	Mon, 21 Sep 2026 03:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789962507; cv=none; b=REPUmpfcOIjmYUc0KJGcHqmg+1+SI1e1jnWCGQ3Ua7JEoTM4r/z0zrDD5q9V9+pEnFjReSWHSqj5de/MmFMIqEWCSq6EB6pMEVw6+96MxcGe5aCBkt7NERQSpsS5pvzglKoJG+ruuda5BJ4sTMBFcx9FJdSIuz2GG3exScFhiPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789962507; c=relaxed/simple;
	bh=X2FZhLiHF5lvC6RLt3eGUzO9KUxe7+iaRhCqVbumjMU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O9iZ+3ISeqjGRJUMBtxMGWphtr+o6Dg9hOe8M6GsRpcfyNVAObPxk4RgcN7dm0i6OOuRqdvomRBRCJRZWokSudTWWv/YfoArmBoSQIUhO6EoAGr3bovre3KUGQrEUc89g+MQJPo5STvK2E6EMcthfSQuPB0tNTNHuVR7+ZAo1a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiZzDuWC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiZzDuWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2041F00893;
	Mon, 21 Sep 2026 03:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789962505;
	bh=Q+gfMcgIYxr5U4QGuV3PyosxWM/5AkpyPGlqILK5RzA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kiZzDuWCuk/KY+Fz2k7BC3hkbjxzxOCv8truQU8pt8gU6HLK4oL3rcBSytBCeMyc8
	 wbtMv5lim4xcGndlcmbPcOoPQa7K0OtS4Thva63SKb5xkbH7ZYaZreUAYcPBPChCfY
	 IOFz0PXz6TTFJiTJsyt7p+oCJO1dDAk/dWCHUtD2LZ8pYaup9a4a5cjoYTzBCMVrBl
	 2woNC0V49jUrBt60UixaNcOVtrNTSPDnX79wmbQlTGDr/kJzelDgums8WqTyqVZFju
	 ILAUMJbTiIPpwrguTdcNj00HIZbqhdZ2Yr3xFzTiUIopeVarjkHxAFoGOJaYlufmmQ
	 BLV8kiTENt/nQ==
Subject: Re: [PATCH net-next v2 2/2] net: wwan: qcom_bam_dmux: Assign
 restricted DMA pool to remote processor
From: netdev-bot+sashiko@kernel.org
To: vishnu.santhosh@oss.qualcomm.com
Cc: stephan@gerhold.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 deepak.singh@oss.qualcomm.com
Date: Mon, 21 Sep 2026 03:48:23 +0000
Message-ID: <178996250389.2160803.17277339384338088713@kernel.org>
In-Reply-To:
 <20260920-qcom-bam-dmux-vmid-ext-v2-2-ef5ca2178378@oss.qualcomm.com>
References:
 <20260920-qcom-bam-dmux-vmid-ext-v2-2-ef5ca2178378@oss.qualcomm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] bam_dmux_probe()'s err_disable_pm label
  (drivers/net/wwan/qcom_bam_dmux.c:938-942) calls the new…
- [High] The feature's stated requirement - that the BAM descriptor FIFOs
  also live in the SCM-assigned region - cannot be expressed by a…
- [High] bam_dmux_remove() revokes the remote EE's access to the pool
  even when the remote has demonstrably not quiesced.
- [Medium] bam_dmux_assign_dma_pool()
  (drivers/net/wwan/qcom_bam_dmux.c:770-830) validates only device-tree…
- [Medium] bam_dmux_assign_dma_pool() accepts any qcom,vmid in 0..63
  (line 786) and stores dmux->dma_pool_perms =…
- [Medium] bam_dmux_reclaim_dma_pool()
  (drivers/net/wwan/qcom_bam_dmux.c:832-852) only logs a failure of…
- [Low] The qcom,vmid parser in bam_dmux_assign_dma_pool()
  (drivers/net/wwan/qcom_bam_dmux.c:783-787) accepts values and property…
- [Low] Binding/driver validation ranges diverge for qcom,vmid:
  Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml constrains…

--

net: wwan: qcom_bam_dmux: Assign restricted DMA pool to remote processor

This patch makes qcom_bam_dmux look up the restricted DMA pool referenced
by memory-region when qcom,vmid is present, and hands the whole pool to
both HLOS and the remote VMID via qcom_scm_assign_mem() before the DMA
channels are requested.  The pool is reclaimed for HLOS again on remove
and on the probe error path.

A few questions about the new code below.

> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
> index cc6ace8d6437..c81e668d4e96 100644
> --- a/drivers/net/wwan/qcom_bam_dmux.c
> +++ b/drivers/net/wwan/qcom_bam_dmux.c

[ ... ]

> @@ -762,6 +767,90 @@ static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int bam_dmux_assign_dma_pool(struct bam_dmux *dmux)
> +{
> +	struct device *dev = dmux->dev;
> +	struct device_node *rmem_np;
> +	struct reserved_mem *rmem;
> +	struct qcom_scm_vmperm dst[2];
> +	u64 src = BIT_ULL(QCOM_SCM_VMID_HLOS);
> +	u32 vmid;
> +	int ret;
> +
> +	if (!of_property_present(dev->of_node, "qcom,vmid"))
> +		return 0;
> +
> +	ret = of_property_read_u32(dev->of_node, "qcom,vmid", &vmid);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read qcom,vmid\n");
> +	if (vmid == QCOM_SCM_VMID_HLOS || vmid >= BITS_PER_TYPE(u64))
> +		return dev_err_probe(dev, -EINVAL, "Invalid qcom,vmid %u\n", vmid);

[Severity: Low]
Is vmid == 0 intentionally accepted here?  The binding added by
"dt-bindings: net: qcom,bam-dmux: Add memory-region and qcom,vmid
properties" declares:

  qcom,vmid:
    minItems: 1
    maxItems: 1
    items:
      minimum: 1
      maximum: 63

so qcom,vmid = <0> is schema-invalid, but this check only rejects
QCOM_SCM_VMID_HLOS and values >= 64, and 0 is forwarded as dst[1].vmid to
qcom_scm_assign_mem().

The maxItems: 1 side is not enforced either.  of_property_read_u32() reads
just the first cell, so qcom,vmid = <A B> is silently truncated rather than
rejected.  Would of_property_count_u32_elems() (or the read_variable
helper) be a better fit so a malformed list fails with the clear "Invalid
qcom,vmid" diagnostic instead of a firmware rejection later?

[Severity: Low]
Related: the binding's numeric range 1..63 includes QCOM_SCM_VMID_HLOS
(0x3, include/dt-bindings/firmware/qcom,scm.h), and the prose note that the
local execution environment must not be specified is not encoded in the
schema.  So qcom,vmid = <QCOM_SCM_VMID_HLOS> passes dt_binding_check while
this check fails probe with -EINVAL.  Could the schema express the
exclusion so the constraint is machine-checkable?

> +
> +	if (!IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL))
> +		return dev_err_probe(dev, -EOPNOTSUPP,
> +				     "qcom,vmid requires DMA_RESTRICTED_POOL\n");
> +
> +	rmem_np = of_parse_phandle(dev->of_node, "memory-region", 0);
> +	if (!rmem_np)
> +		return dev_err_probe(dev, -EINVAL,
> +					     "qcom,vmid requires memory-region\n");
> +
> +	if (!of_device_is_compatible(rmem_np, "restricted-dma-pool")) {
> +		of_node_put(rmem_np);
> +		return dev_err_probe(dev, -EINVAL,
> +				     "memory-region must reference a restricted DMA pool\n");
> +	}
> +
> +	rmem = of_reserved_mem_lookup(rmem_np);
> +	of_node_put(rmem_np);
> +	if (!rmem)
> +		return dev_err_probe(dev, -EINVAL,
> +					     "Failed to look up restricted DMA pool\n");

[Severity: Medium]
These checks confirm the device tree text (memory-region index 0 is
compatible with restricted-dma-pool, and the reserved_mem descriptor
exists), but is there anything here that confirms the pool actually backs
this device's DMA path, i.e. that dev->dma_io_tlb_mem points at it?

Attaching the pool is best-effort in the DMA core.  In
of_dma_configure_id(), the restricted pool is only installed when the
device was not claimed by an IOMMU:

drivers/of/device.c:of_dma_configure_id() {
	...
	if (ret)
		of_dma_set_restricted_buffer(dev, np);
	...
}

and of_dma_set_restricted_buffer() additionally requires the node to be
available and only warns on failure:

	if (of_device_is_compatible(it.node, "restricted-dma-pool") &&
	    of_device_is_available(it.node)) {
		if (of_reserved_mem_device_init_by_idx(dev, of_node, i))
			dev_warn(dev, "failed to initialise \"restricted-dma-pool\" memory node\n");

rmem_swiotlb_device_init() can also legitimately fail, for example:

kernel/dma/swiotlb.c:rmem_swiotlb_device_init() {
	if (PageHighMem(pfn_to_page(PHYS_PFN(rmem->base)))) {
		dev_err(dev, "Restricted DMA pool must be accessible within the linear mapping.");
		return -EINVAL;
	}

In all of those cases probe still succeeds, the pool is still granted to
the modem, and bam_dmux_skb_dma_map()'s dma_map_single() returns addresses
outside the assigned region.  The commit message states:

  "This ensures that BAM-DMUX mappings are within the assigned region."

Can that hold without checking the device's effective DMA backend (for
example is_swiotlb_for_alloc(dev) / dev->dma_io_tlb_mem) after
of_dma_configure() has run?

> +
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
> +	dst[0].vmid = QCOM_SCM_VMID_HLOS;
> +	dst[0].perm = QCOM_SCM_PERM_RW;
> +	dst[1].vmid = vmid;
> +	dst[1].perm = QCOM_SCM_PERM_RW;
> +
> +	ret = qcom_scm_assign_mem(rmem->base, rmem->size, &src, dst,
> +				  ARRAY_SIZE(dst));

[Severity: High]
This assigns the pool referenced by the bam-dmux consumer node, but the
BAM descriptor FIFOs are allocated against the BAM DMA controller device:

drivers/dma/qcom/bam_dma.c:bam_alloc_chan() {
	...
	bchan->fifo_virt = dma_alloc_wc(bdev->dev, BAM_DESC_FIFO_SIZE,
					&bchan->fifo_phys, GFP_KERNEL);
	...
}

so the FIFO follows the controller's DMA configuration, not the consumer's
restricted pool.  The commit message says:

  "When the BAM DMA controller references the same pool, its descriptor
  FIFOs are covered by the assignment as well."

How is a device tree supposed to express that?  Adding
memory-region = <&pool> to the qcom,bam-dma node does not validate, since
Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml defines no
memory-region property and ends with:

  additionalProperties: false

Without that binding change, do the descriptor FIFOs stay outside the
assigned region, which is the access the commit message describes as
triggering an XPU violation?

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "SCM assign restricted DMA pool failed\n");
> +
> +	dmux->dma_pool_base = rmem->base;
> +	dmux->dma_pool_size = rmem->size;
> +	/* Track the destination VMIDs explicitly for the reclaim operation. */
> +	dmux->dma_pool_perms = BIT_ULL(QCOM_SCM_VMID_HLOS) | BIT_ULL(vmid);

[Severity: Medium]
The check above allows any vmid up to 63, and the bit is recorded here with
BIT_ULL() and later passed as the srcvm bitmap to qcom_scm_assign_mem().
Does that work on a 32-bit build?  The SCM helper sizes the source array
with hweight64() but decodes it with the unsigned-long-wide BIT():

drivers/firmware/qcom/qcom_scm.c:qcom_scm_assign_mem() {
	src_sz = hweight64(srcvm_bits) * sizeof(*src);
	...
	for (b = 0; b < BITS_PER_TYPE(u64); b++) {
		if (srcvm_bits & BIT(b))
			src[i++] = cpu_to_le32(b);
	}
	...
		next_vm |= BIT(newvm->vmid);
}

On a 32-bit kernel a vmid >= 32 is counted but never emitted, and
qcom_tzmem_alloc() uses gen_pool_alloc() without zeroing, so the skipped
src[] slot reaches the secure monitor with stale bytes.  This driver also
covers 32-bit SoCs, and the binding example uses QCOM_SCM_VMID_NAV (0x2B,
43).  Should the accepted range match what the SCM bitmap plumbing can
actually represent?

> +
> +	return 0;
> +}
> +
> +static void bam_dmux_reclaim_dma_pool(struct bam_dmux *dmux)
> +{
> +	struct qcom_scm_vmperm hlos = {
> +		.vmid = QCOM_SCM_VMID_HLOS,
> +		.perm = QCOM_SCM_PERM_RW,
> +	};
> +	u64 src = dmux->dma_pool_perms;
> +	int ret;
> +
> +	if (!dmux->dma_pool_perms)
> +		return;
> +
> +	ret = qcom_scm_assign_mem(dmux->dma_pool_base, dmux->dma_pool_size, &src,
> +				  &hlos, 1);
> +	if (ret) {
> +		dev_err(dmux->dev, "SCM reclaim restricted DMA pool failed: %d\n", ret);
> +		return;
> +	}

[Severity: Medium]
When this reclaim fails, dma_pool_perms is left set and the region stays
owned by {HLOS, remote VMID}, but that state only lives in the devm
allocated struct bam_dmux, which goes away once probe returns or remove()
finishes.

Does that make the condition unrecoverable?  A later re-bind or module
reload enters bam_dmux_assign_dma_pool() with the hard-coded source set:

	u64 src = BIT_ULL(QCOM_SCM_VMID_HLOS);

which no longer matches the real owner set, so the assign is rejected and
the device cannot be used again without a reboot.  Would it be better to
propagate the failure (or retry) instead of only logging it?

> +
> +	dmux->dma_pool_perms = 0;
> +}
> +
>  static int bam_dmux_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;

[ ... ]

> @@ -845,6 +938,7 @@ static int bam_dmux_probe(struct platform_device *pdev)
>  err_disable_pm:
>  	pm_runtime_disable(dev);
>  	pm_runtime_dont_use_autosuspend(dev);
> +	bam_dmux_reclaim_dma_pool(dmux);
>  	return ret;
>  }

[Severity: High]
Can this path revoke the remote VMID's access while the RX pipe and its
mappings are still live?

The pc IRQ is registered before the last fallible probe step:

	ret = devm_request_threaded_irq(dev, dmux->pc_irq, NULL, bam_dmux_pc_irq,
					IRQF_ONESHOT, NULL, dmux);
	if (ret)
		goto err_disable_pm;

	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
				    &dmux->pc_state);
	if (ret)
		goto err_disable_pm;

bam_dmux_pc_irq() -> bam_dmux_power_on() does dma_request_chan(dev, "rx")
and queues BAM_DMUX_NUM_SKB RX buffers mapped out of the restricted pool,
then acks the modem.  If probe then fails here, err_disable_pm calls the
reclaim without disable_irq(dmux->pc_irq), bam_dmux_power_off() or
bam_dmux_free_skbs(), and devres only frees the IRQs (and the devm
allocated dmux) after probe returns, so the handler can even re-arm RX DMA
into an already-reclaimed pool.

bam_dmux_remove() establishes the ordering the commit message describes:

	disable_irq(dmux->pc_irq);
	bam_dmux_power_off(dmux);
	bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
	bam_dmux_reclaim_dma_pool(dmux);

The commit message says the pool is reclaimed "after DMA channels and
mappings are released during remove or probe error cleanup".  Should the
error path mirror that sequence?

>  
> @@ -879,6 +973,7 @@ static void bam_dmux_remove(struct platform_device *pdev)
>  	disable_irq(dmux->pc_irq);
>  	bam_dmux_power_off(dmux);
>  	bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
> +	bam_dmux_reclaim_dma_pool(dmux);
>  }

[Severity: High]
Is it safe to reclaim unconditionally here when the remote side did not
quiesce?  Just above, the timeout result is only logged:

	if (!wait_event_timeout(dmux->pc_wait, !dmux->rx, BAM_DMUX_REMOTE_TIMEOUT))
		dev_err(dev, "Timed out waiting for remote side to suspend\n");

Control flow is unchanged, so bam_dmux_power_off() and the new reclaim run
anyway and the modem loses RW on the pool while it may still be fetching
descriptors from it.

Local teardown is not guaranteed either.  dma_release_channel() reaches
bam_free_chan(), which can bail before resetting the pipe and freeing the
FIFO:

drivers/dma/qcom/bam_dma.c:bam_free_chan() {
	ret = pm_runtime_get_sync(bdev->dev);
	if (ret < 0)
		return;
	...
}

leaving the BAM pipe programmed with a descriptor FIFO address inside the
region whose permission was just revoked.  Should the reclaim be skipped
(or deferred) when the remote has not acked the power-down?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260920-qcom-bam-dmux-vmid-ext-v2-0-ef5ca2178378%40oss.qualcomm.com
