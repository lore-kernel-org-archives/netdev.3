Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D4B3F328C;
	Fri, 11 Sep 2026 03:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098112; cv=none; b=Bryb0zdHciSo4wItdEdd93MXkjE1NjIZEGriTi4JAbyfA5oOgEF8Y7e1h7p6BJjGmBoHu/qaKaXEyZQFGux5/vryPw2HDvlNdxCHsFSSFAHL35URFHCEqr+ZU92coYI97C7KHb2gPmQK0CixiMGsEtK9/DMO7BUbkOu0bLhSs+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098112; c=relaxed/simple;
	bh=328udNkCXvF2D0blJB5r+tjgduVN/0GunIK5vCSf06o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m5h3YfHo3Tkm6rRXuQbTexHVLd3kCxSZWrD8jpqsthHBfDfWfEdxsdKhHQe9yxFYjessrHy/N8Foq0Mo6oKJSA3QgN26VS/U7knwi+zi9hoIidEM2zczGXISHVGP+7dkPH8DxjMPAeoWJbNYRfR39j3YELU7c86HU5DPzjtvoSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O89cvkH/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O89cvkH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789C71F000FF;
	Fri, 11 Sep 2026 03:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789098110;
	bh=k7ZquKIQddlc8EIX1GJAj86Q5Oc8dcvFyf2p1vVeGTQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O89cvkH/7QKwwARgIyansdfNkM93ddWcG8IaoHtsNgDbiFVy7FueDUwZoNYUeTLUf
	 9DgyC/dGd6Hvw0X84E64kP6SDDj/R58xeT/1pJdKZ2KUql3UFw1IhJ/BOxjYy070La
	 2W7UjUzkvBAUdpu9yTMKkPW8NieNPKnkB1Er4sScIkE7/9Q+nT3Bs77JTA9M0Yb3KT
	 09lnLzMJERRSQt/Ynd/rZvJOZEOveAXnuR/EXqlbNaiGn0brrN1k5u1MRQjfrwRMfc
	 pB8rqswj3hYwtAwp1/ohi+qQ1J41dyO9S3q+amtpaTurOZjWBPcgnwkaXfn174NU+K
	 scjAsS/pmCZdA==
Subject: Re: [PATCH v27 net-next 05/10] net/nebula-matrix: add intr resource
 implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 03:41:49 +0000
Message-ID: <178909810904.219967.6857628941684553135@kernel.org>
In-Reply-To: <20260907123848.30256-6-illusion.wang@nebula-matrix.com>
References: <20260907123848.30256-6-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 3

- [Medium] Coherent MSI-X map table is released based on a timed guess,
  not on proven device quiescence.
- [Low] Two in-tree comments state mutually exclusive ownership models
  for the coherent MSI-X tables.
- [Low] The 'Step 1' comment in __nbl_res_intr_destroy_msix_map() says
  'mask each MSIX vector in hardware first', but the call it annotates…
- [Low] Reported concern: nbl_intr_mgt_stop() publishes the 'dead' state
  with a plain store 'res_mgt->intr_mgt = NULL' outside intr_mgt->lock,…

--

net/nebula-matrix: add intr resource implementation

This adds the nbl_interrupt module which owns the driver-wide global MSI-X
index space and programs the chip-internal MSI-X map/info registers.  It
adds cfg_msix_map, destroy_msix_map, set_mailbox_irq and cfg_msix_info,
plus nbl_intr_mgt_start()/nbl_intr_mgt_stop() wired into the leonis
resource layer.

A few questions about the teardown path and about some of the comments
below.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index b4aba4faa555a..4c2e577610230 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c

[ ... ]

> @@ -91,6 +115,124 @@ static void nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt, u32 *eth_map)

[ ... ]

> +static void nbl_hw_cfg_msix_info(struct nbl_hw_mgt *hw_mgt, u16 func_id,
> +				 bool valid, u16 interrupt_id, u8 bus,
> +				 u8 devid, u8 function, bool msix_mask_en)
> +{
> +	u32 host_msix_fid = 0;
> +	struct nbl_host_msix_info msix_info;
> +
> +	memset(&msix_info, 0, sizeof(msix_info));
> +	if (valid) {
> +		host_msix_fid =
> +			FIELD_PREP(NBL_PCOMPLETER_HOST_MSIX_FID_TABLE_FID_MASK,
> +				   func_id) |
> +			FIELD_PREP(NBL_PCOMPLETER_HOST_MSIX_FID_TABLE_VLD_MASK,
> +				   1);
> +
> +		msix_info.data[1] =
> +			FIELD_PREP(NBL_HOST_MSIX_INFO_FUNCTION_MASK, function) |
> +			FIELD_PREP(NBL_HOST_MSIX_INFO_DEVID_MASK, devid) |
> +			FIELD_PREP(NBL_HOST_MSIX_INFO_BUS_MASK, bus) |
> +			FIELD_PREP(NBL_HOST_MSIX_INFO_VALID_MASK, 1);
> +
> +		if (msix_mask_en)
> +			msix_info.data[1] |=
> +			FIELD_PREP(NBL_HOST_MSIX_INFO_MSIX_MASK_EN_MASK, 1);
> +	}

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> index 46180522295a3..c1f10f1f6b775 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c

[ ... ]

> @@ -328,8 +337,24 @@ int nbl_res_init_leonis(struct nbl_adapter *adap)
>  
>  void nbl_res_remove_leonis(struct nbl_adapter *adap)
>  {
> +	struct nbl_resource_mgt *res_mgt = adap->core.res_mgt;
> +	struct nbl_common_info *common = &adap->common;
> +
> +	if (!res_mgt)
> +		return;
> +
> +	/*
> +	 * Tear down all MSI-X maps before devres releases the coherent
> +	 * tables.	This is critical on the control PF, which may hold
> +	 * maps for remote PFs that are still bound.
> +	 */
> +	if (common->has_ctrl && res_mgt->intr_mgt)
> +		nbl_intr_mgt_stop(res_mgt);
> +
>  	/*
> -	 * No resource release here because all memory uses devm managed
> -	 * allocation
> +	 * Note: the per-function interrupts arrays (kcalloc) are freed
> +	 * by nbl_intr_mgt_stop() above.  The coherent MSI-X tables
> +	 * (dmam_alloc_coherent) and intr_mgt itself (devm_kzalloc) are
> +	 * released by devres after this function returns.
>  	 */
>  }

[Severity: Low]
Is this comment still accurate?

nbl_intr_mgt_stop() loops over every function id and calls
__nbl_res_intr_destroy_msix_map(), which itself calls dmam_free_coherent()
on msix_map_table->base_addr and then sets it to NULL.  So by the time
nbl_res_remove_leonis() returns, there should be no devres-managed
coherent MSI-X table left for devres to release.

The kernel-doc on nbl_res_intr_cfg_msix_map() states the opposite
ownership model:

 * Old MSIX table memory is explicitly freed inside the locked
 * destroy path after a bounded DMA quiesce sleep (best-effort;
 * hardware provides no idle status register), so repeated
 * reconfiguration does not accumulate devres-managed DMA memory.

The commit message carries the same wording as the comment here, "It is
called from nbl_res_remove_leonis() before devres releases the coherent
tables."

Could these be reconciled so a later change does not drop the explicit
dmam_free_coherent() on the assumption devres still owns the tables?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> new file mode 100644
> index 0000000000000..fd3b71a05c236
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> @@ -0,0 +1,544 @@

[ ... ]

> +	/* Step 0: disable mailbox IRQ routing before tearing down map */
> +	__nbl_res_intr_set_mailbox_irq(res_mgt, func_id, 0, false);
> +
> +	/* Step 1: mask each MSIX vector in hardware first */
> +	for (i = 0; i < intr_num; i++) {
> +		hw_ops->cfg_msix_info(res_mgt->hw_ops_tbl->priv,
> +				      func_id, false, interrupts[i],
> +				      0, 0, 0, false);
> +	}
> +	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);

[Severity: Low]
Does this loop actually mask anything?

The call passes valid=false and msix_mask_en=false, and
nbl_hw_cfg_msix_info() starts with:

	memset(&msix_info, 0, sizeof(msix_info));
	if (valid) {
		...
	}

so for valid=false both host_msix_fid and msix_info.data[] stay zero and
the writes to NBL_PCOMPLETER_HOST_MSIX_FID_TABLE() and
NBL_PADPT_HOST_MSIX_INFO_REG_ARR() drive
NBL_HOST_MSIX_INFO_MSIX_MASK_EN_MASK (BIT(17)) and
NBL_HOST_MSIX_INFO_VALID_MASK (BIT(16)) to 0 and clear the FID VLD bit.

That invalidates the entry and turns mask-enable off rather than masking
the vector.  Would "invalidate each MSIX info entry" describe the step
more accurately?  The commit message has the same wording, "Step 1 masks
each vector."

> +	/*
> +	 * Stage 1 tear down: retain valid DMA address, ONLY clear
> +	 * VALID bit to avoid hardware torn read (VALID=1 & dma_addr=0).
> +	 */
> +	hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
> +			      false, msix_map_table->dma, 0, 0, 0);
> +	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
> +
> +	/*
> +	 * Hardware provides no idle status register for the MSIX map
> +	 * DMA engine.  Use a bounded sleep to mitigate the race between
> +	 * posted MMIO disable writes and an ongoing in-flight table
> +	 * read DMA.
> +	 *
> +	 * This is best-effort, not a guarantee: a table fetch already
> +	 * issued before the VALID clear was observed can complete after
> +	 * this sleep.  On the normal teardown path the mailbox channel
> +	 * is stopped before this function runs, so no new interrupts
> +	 * can trigger table fetches.  On the residual cleanup path in
> +	 * nbl_intr_mgt_stop(), a longer global quiesce is applied
> +	 * after all functions are torn down.
> +	 */
> +	usleep_range(NBL_MSIX_DMA_SYNC_MIN_US, NBL_MSIX_DMA_SYNC_MAX_US);
> +
> +	/* safe to release global vector IDs, pcompler no longer reads table */
> +	nbl_intr_release_bitmap(res_mgt, interrupts, intr_num);
> +
> +	/*
> +	 * Stage 2: hardware has quiesced MSIX table DMA access, fully
> +	 * zero the MSIX map entry safely now.
> +	 */
> +	hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
> +			     false, 0, 0, 0, 0);
> +	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
> +
> +	/*
> +	 * Now safe to release the MSIX DMA coherent memory.  Hardware
> +	 * DMA has quiesced after the sleep above, so no IOMMU fault
> +	 * risk remains.
> +	 */
> +	if (msix_map_table->base_addr) {
> +		dmam_free_coherent(dev, msix_map_table->size,
> +				   msix_map_table->base_addr,
> +				   msix_map_table->dma);
> +		msix_map_table->base_addr = NULL;
> +		msix_map_table->dma = 0;
> +		msix_map_table->size = 0;
> +	}

[Severity: Medium]
Can the coherent table be freed here while the pcompleter still has a
table fetch outstanding?

The two comments in __nbl_res_intr_destroy_msix_map() disagree with each
other.  The first says:

	 * This is best-effort, not a guarantee: a table fetch already
	 * issued before the VALID clear was observed can complete after
	 * this sleep.

and a few lines later:

	 * Hardware DMA has quiesced after the sleep above, so no IOMMU
	 * fault risk remains.

followed by dmam_free_coherent() on the buffer the device DMA-reads.

If a fetch does land after the free, with an IOMMU the read hits an
unmapped IOVA and produces a DMAR/SMMU fault; without one it reads
recycled memory whose bytes are interpreted as an MSI-X map entry
(NBL_MSIX_MAP_VALID_MASK plus the 13-bit NBL_MSIX_MAP_INDEX_MASK), which
could steer an interrupt to a global vector now owned by a different
function.

The table size does not depend on the request:

	tmp_msix_tbl->size =
		sizeof(struct nbl_msix_map) * NBL_MSIX_MAP_TABLE_MAX_ENTRIES;

Since the allocation is a fixed 2 KiB regardless of num_net_msix /
num_others_msix, would it be simpler to allocate the table once per
function and rewrite the entries in place, so the free/realloc cycle, the
timed sleeps and the admitted race all go away?

The commit message describes the same mechanism, "sleeps 1 ms to allow
in-flight table fetch DMA to quiesce (best-effort; no idle status register
exists), then zeroes the entry before freeing memory."

[ ... ]

> +void nbl_intr_mgt_stop(struct nbl_resource_mgt *res_mgt)
> +{
> +	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
> +	u16 func_id;
> +	int ret;
> +
> +	if (!intr_mgt)
> +		return;
> +
> +	mutex_lock(&intr_mgt->lock);
> +	for (func_id = 0; func_id < NBL_MAX_FUNC; func_id++) {
> +		if (intr_mgt->func_intr_res[func_id].interrupts) {
> +			dev_info(res_mgt->common->dev,
> +				 "intr_mgt_stop: destroying leftover map for func %u\n",
> +				 func_id);
> +			ret = __nbl_res_intr_destroy_msix_map(res_mgt,
> +							      func_id);
> +			if (ret)
> +				dev_warn(res_mgt->common->dev,
> +					 "intr_mgt_stop: destroy map for func %u failed: %d\n",
> +					 func_id, ret);
> +		}
> +	}
> +	mutex_unlock(&intr_mgt->lock);
> +
> +	/*
> +	 * Global quiesce after all functions are torn down.  Each
> +	 * destroy has an internal 1ms sleep between Stage 1 (clear
> +	 * VALID) and Stage 2 (zero dma_addr), but Stage 2 itself has
> +	 * no trailing sleep.  This final wait covers the last
> +	 * function's Stage 2 and any straggler DMA from
> +	 * concurrently-torndown functions.
> +	 */
> +	usleep_range(NBL_MSIX_DMA_SYNC_MIN_US, NBL_MSIX_DMA_SYNC_MAX_US);

[Severity: Medium]
Does this final usleep_range() still cover anything?

The loop above has already called __nbl_res_intr_destroy_msix_map() for
every func_id, and each of those calls ends with dmam_free_coherent() on
that function's table.  By the time this sleep runs there is no coherent
table left that a straggler DMA could safely land in, so the wait appears
to be after the window the comment says it protects.

Should this wait happen before the per-function dmam_free_coherent()
instead, or is it simply not needed?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907123848.30256-1-illusion.wang%40nebula-matrix.com
