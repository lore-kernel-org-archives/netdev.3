Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC99A4AAC70;
	Thu, 17 Sep 2026 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684509; cv=none; b=FcLMU6hwO563fiy+dqPgkrWWAPZBIG6a6yMQn3ysXiT0kBnRcrJePmpxLyCjk/PsaPpG1SuuLQTqchwgAK7sf+mW0ej5cq19t51nqFUTGuoUBQeo5EP3s99bNyc40Pmp4HfK2S2qnx6/JtqzvFBiZPbtlhq6L9oB8gV0xzFum0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684509; c=relaxed/simple;
	bh=AbUDQJ5MP+DgRsewt+XW1Is7LV0cBXIEqGZJj2O/fv0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M22PnPUxZfk1nG7z8//wt7GHep3Mofx8z2QspBogMRLqLlnzyn+IeBChXdJhJnP71NhIA00/LuLo1txQiyMKJpEVXiXe27EPEFsbGZVXN1DFovGLeyQ9ZvDJ6GZ1YoIW1zK+7mlZeKIa91SY+0fUOr0WaDmvoJpM0GDpvrhPNnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5kHCWBp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5kHCWBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817D31F00898;
	Thu, 17 Sep 2026 22:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684506;
	bh=1wN776cKxIsIU0DrFnM8hJHBz1tagIJbOHWHPvshXo4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h5kHCWBpz6vipXpa4d90PDeVPCZlpC2Ds0WtEfcvE4sHKJS8uJltzuyO9vluKsIEt
	 ROubH8k/Vi33A6LkSEWblRGSS1dyKoWzhF67kfhbdGJwA0ORrVCdqiPuyPpYlFrNjJ
	 6I0i3Q+7vNFbglBzNyApTz88yPCiXhuyR5tgFZahk9mgRw+GU8y/XNt1zQ94AH+Zeh
	 Y00lqEnLssMhzTa5V7xPyUsNXRvIGYjE10e0JwJpI/x251iLEYatcGuBjYvEWS2RYp
	 kDRJ4nfI9kSVe5tZFylu4epdHXuRjmRLHyKMe3EMCw2cTkY2BdjuXWPd7wOMqT/5Yg
	 y/L+K0ZlknHLQ==
Subject: Re: [PATCH v28 net-next 05/10] net/nebula-matrix: add intr resource
 implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 22:35:05 +0000
Message-ID: <178968450508.22033.474722083307073807@kernel.org>
In-Reply-To: <20260914123429.56596-6-illusion.wang@nebula-matrix.com>
References: <20260914123429.56596-6-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 6 · Low: 4

- [Medium] The changelog and the in-tree comment added by this patch both
  claim devres/managed ownership of the MSI-X map coherent buffer that…
- [Medium] The two-stage MSI-X map teardown does not implement the
  sequence the commit message and the hw-layer comment describe.
- [Medium] The comment added above nbl_hw_set_mailbox_irq()
  (nbl_hw_leonis.c:118-126) states that "nbl_hw_cfg_mailbox_qinfo()…
- [Medium] nbl_res_intr_cfg_msix_map() allocates the per-function
  coherent MSI-X map table (2 KiB: sizeof(struct nbl_msix_map) * 1024)…
- [Medium] On the reconfigure branch of nbl_res_intr_cfg_msix_map()
  (taken when func_intr_res[func_id].interrupts is already non-NULL) the…
- [Medium] In the reconfigure branch of nbl_res_intr_cfg_msix_map(), the
  old global hardware vector indices are returned to the shared…
- [Low] For a patch that creates drivers/net/ethernet/nebula-
  matrix/nbl/nbl_hw/nbl_interrupt.c from scratch, the changelog and the…
- [Low] In nbl_hw_leonis.h the descriptive comment "/* pcompleter_host
  pcompleter_host_virtio_qid_map_table */" is attached to…
- [Low] __nbl_res_intr_destroy_msix_map() drops intr_mgt->lock for a
  1000-1200 us sleep between the prepare and complete teardown phases…
- [Low] nbl_intr_mgt_stop() clears res_mgt->intr_mgt with a plain store
  outside intr_mgt->lock (nbl_interrupt.c:590), while every public entry…

--

net/nebula-matrix: add intr resource implementation

This patch adds a new nbl_interrupt module that manages the chip-internal
global MSI-X vector index space (intr_net_bmap / intr_other_bmap) and
programs the related pcompleter/padpt mapping registers.  It also adds the
hardware helpers cfg_msix_map, cfg_msix_info and set_mailbox_irq, plus
nbl_intr_mgt_start() / nbl_intr_mgt_stop() wiring into the leonis resource
layer.

A few questions below about the teardown sequencing, an error path, and some
comments that appear to describe something other than what the code does.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index 960263d8f28cd..33f6b4e870815 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c

[ ... ]

> @@ -101,6 +115,124 @@ static void nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt, u32 *eth_map)
>  	*eth_map = FIELD_GET(NBL_FW_BOARD_DW6_ETH_BITMAP_MASK, data);
>  }
>  
> +/*
> + * nbl_hw_set_mailbox_irq - read-modify-write NBL_MAILBOX_QINFO_MAP_REG_ARR
> + *
> + * The full RMW sequence is wrapped by reg_lock, so concurrent register
> + * access from different CPUs is already serialized safely.
> + * nbl_hw_cfg_mailbox_qinfo() overwrites the entire register during init,
> + * which unconditionally clears MSIX_IDX and MSIX_IDX_VALID bits, disabling
> + * mailbox MSIX interrupt routing for this PF.
> + */

[Severity: Medium]
Does nbl_hw_cfg_mailbox_qinfo() really overwrite the entire register?  As
implemented in this same file it is a read-modify-write that clears only the
BDF fields:

	data &= ~(NBL_MAILBOX_QINFO_MAP_FUNCTION_MASK |
		  NBL_MAILBOX_QINFO_MAP_DEVID_MASK |
		  NBL_MAILBOX_QINFO_MAP_BUS_MASK);

NBL_MAILBOX_QINFO_MAP_MSIX_IDX_MASK is GENMASK(28, 16) and
NBL_MAILBOX_QINFO_MAP_MSIX_IDX_VALID_MASK is BIT(29), i.e. they live in the
same 32-bit word and are preserved rather than cleared.

If a previous driver instance never reached nbl_intr_mgt_stop() (crash,
kexec, forced unload with no FLR), wouldn't MSIX_IDX_VALID survive init, so
mailbox interrupts stay routed to a global vector index that this instance
can hand to a different function via nbl_res_intr_cfg_msix_map()?

> +static void nbl_hw_set_mailbox_irq(struct nbl_hw_mgt *hw_mgt, u16 func_id,
> +				   bool en_msix, u16 gvec)
> +{

[ ... ]

> +static void nbl_hw_cfg_msix_map(struct nbl_hw_mgt *hw_mgt, u16 func_id,
> +				bool valid, dma_addr_t dma_addr, u8 bus,
> +				u8 devid, u8 function)
> +{

[ ... ]

> +	} else {
> +		/*
> +		 * reg_lock prevents concurrent CPU writes to the same
> +		 * function's MSIX entry, but cannot synchronize hardware DMA
> +		 * reads. Upper layer uses two-stage destruction + sync sleep
> +		 * to avoid torn hardware read of partial MSIX entry.
> +		 * Keep valid live dma address here, only clear VALID flag.
> +		 */
> +		function_msix_map.data[0] = lower_32_bits(dma_addr);
> +		function_msix_map.data[1] = upper_32_bits(dma_addr);
> +		function_msix_map.data[2] = 0;
> +	}
> +
> +	nbl_hw_wr_regs_lock(hw_mgt,
> +			    NBL_PCOMPLETER_FUNCTION_MSIX_MAP_REG_ARR(func_id),
> +			    function_msix_map.data, sizeof(function_msix_map));
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> index 251dd68d07215..7d0adc5bfb0aa 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> @@ -54,6 +54,48 @@ struct nbl_mailbox_qinfo_cfg_table {

[ ... ]

> +/*  --------  HOST_PCOMPLETER  --------  */
> +/* pcompleter_host pcompleter_host_virtio_qid_map_table */
> +#define NBL_PCOMPLETER_FUNCTION_MSIX_MAP_REG_ARR(i)   \
> +	(NBL_INTF_HOST_PCOMPLETER_BASE + 0x00004000 + \
> +	 (i) * sizeof(struct nbl_function_msix_map))

[Severity: Low]
This isn't a bug, but the label says virtio_qid_map_table while the macro and
struct describe the per-function MSI-X map table, and its only consumer
nbl_hw_cfg_msix_map() writes the MSI-X table DMA address, control-PF BDF and
VALID bit there.  Is the comment a leftover from the virtio QID map block?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> index 46180522295a3..338cebcbcc8ba 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c

[ ... ]

> @@ -328,8 +337,26 @@ int nbl_res_init_leonis(struct nbl_adapter *adap)
>  
>  void nbl_res_remove_leonis(struct nbl_adapter *adap)
>  {
> +	struct nbl_resource_mgt *res_mgt = adap->core.res_mgt;
> +	struct nbl_common_info *common = &adap->common;
> +
> +	if (!res_mgt)
> +		return;
> +
>  	/*
> -	 * No resource release here because all memory uses devm managed
> -	 * allocation
> +	 * Tear down all MSI-X maps before devres releases the coherent
> +	 * tables.	This is critical on the control PF, which may hold
> +	 * maps for remote PFs that are still bound.
> +	 */
> +	if (common->has_ctrl && res_mgt->intr_mgt)
> +		nbl_intr_mgt_stop(res_mgt);
> +
> +	/* Note:
> +	 * per-function interrupts arrays (kcalloc) are freed by
> +	 * nbl_intr_mgt_stop().
> +	 * MSIX coherent tables are explicitly freed by dmam_free_coherent()
> +	 * inside the intr destroy path, before nbl_intr_mgt_stop() returns.
> +	 * intr_mgt itself (devm_kzalloc) is released by devres after this
> +	 * function returns
>  	 */
>  }

[Severity: Medium]
Is the dmam_free_coherent() claim accurate?  nbl_res_intr_cfg_msix_map()
allocates the table with plain dma_alloc_coherent() and
__nbl_res_intr_complete_destroy_msix_map() releases it with plain
dma_free_coherent().  A grep for dmam_ in drivers/net/ethernet/nebula-matrix/
only turns up nbl_channel.c, so there does not appear to be any devres
backstop for the MSI-X map table at all.

The changelog wording has the same assumption:

	"It is called from nbl_res_remove_leonis() before devres releases
	 coherent tables."

Could both the comment and the changelog be reworded to say the table is
unmanaged, since that distinction matters for the error path noted further
down?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> new file mode 100644
> index 0000000000000..6ad65f6e1c615
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> @@ -0,0 +1,591 @@

[ ... ]

> +	/* Step 1: invalidate each MSIX info entry in hardware first */
> +	for (i = 0; i < intr_num; i++) {
> +		hw_ops->cfg_msix_info(res_mgt->hw_ops_tbl->priv,
> +				      func, false, interrupts[i],
> +				      0, 0, 0, false);
> +	}
> +	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
> +
> +	/* Stage1 tear down: retain DMA address, only clear VALID bit */
> +	hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func,
> +			     false,
> +			     intr_mgt->func_intr_res[func].msix_map_table.dma,
> +			     0, 0, 0);
> +	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
> +
> +	/* Stage2: zero MSIX map entry */
> +	hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func,
> +			      false, 0, 0, 0, 0);
> +	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);

[Severity: Medium]
The commit message describes this sequence as:

	"Two-stage hardware teardown retains live DMA address while clearing
	 VALID bit, then waits ~1ms for in-flight hardware DMA table fetch
	 to quiesce (best-effort, no idle status register available). After
	 quiesce, zero the table entry before freeing coherent memory."

Here Stage1 and Stage2 are issued back-to-back with only a posted-write
flush between them, and the usleep_range() runs afterwards in
__nbl_res_intr_destroy_msix_map() and in nbl_intr_mgt_stop().

Does the "retain live DMA address" stage have any duration in practice?  If
a table fetch already latched VALID=1, would it not re-read the address words
after Stage2 zeroed them, since nbl_hw_wr_regs_lock() writes data[0] and
data[1] before data[2], and issue a DMA read at address 0 instead of the
still-allocated table?

The same ordering applies to the hw layer comment in nbl_hw_cfg_msix_map(),
which states the upper layer uses "two-stage destruction + sync sleep".

[ ... ]

> +	interrupts = intr_mgt->func_intr_res[func_id].interrupts;
> +	if (!interrupts)
> +		return 0;
> +
> +	intr_num = intr_mgt->func_intr_res[func_id].num_interrupts;
> +	msix_map_table = &intr_mgt->func_intr_res[func_id].msix_map_table;
> +
> +	nbl_intr_release_bitmap(res_mgt, interrupts, intr_num);
> +
> +	if (msix_map_table->base_addr) {
> +		dma_free_coherent(dev, msix_map_table->size,
> +				  msix_map_table->base_addr,
> +				  msix_map_table->dma);

[ ... ]

> +static int __nbl_res_intr_destroy_msix_map(struct nbl_resource_mgt *res_mgt,
> +					   u16 func_id)
> +{
> +	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
> +	int ret;
> +
> +	lockdep_assert_held(&intr_mgt->lock);
> +
> +	ret = __nbl_res_intr_prepare_destroy_msix_map(res_mgt, func_id);
> +	if (ret)
> +		return ret;
> +	mutex_unlock(&intr_mgt->lock);
> +	usleep_range(NBL_MSIX_DMA_SYNC_MIN_US, NBL_MSIX_DMA_SYNC_MAX_US);
> +	mutex_lock(&intr_mgt->lock);
> +
> +	return __nbl_res_intr_complete_destroy_msix_map(res_mgt, func_id);
> +}

[Severity: Low]
The lock is dropped here for 1000-1200 us while
__nbl_res_intr_prepare_destroy_msix_map() has deliberately left
func_intr_res[func_id].interrupts, num_interrupts and msix_map_table
populated, so the intermediate state looks identical to a live
configuration.  nbl_intr_mgt_stop() has the same split with the lock dropped
across the global quiesce.

If nbl_res_intr_cfg_msix_map() could run for the same func_id inside that
window, the completion phase would release the newly installed vectors back
to the bitmaps and dma_free_coherent() a still-armed table.

Checking the callers, that does not seem reachable today: every
res_ops->cfg_msix_map / destroy_msix_map / set_mailbox_irq call in
nbl_dispatch.c is wrapped in mutex_lock(&disp_mgt->ops_mutex_lock) for the
whole resource call, and nbl_intr_mgt_stop() runs from
nbl_res_remove_leonis() only after nbl_dev_remove_common_dev() has done
cancel_work_sync(&common_dev->clean_mbx_task) and removed the mailbox queue.

So the question is about the documented contract rather than a live race:
the kdoc of nbl_res_intr_cfg_msix_map() says this module "takes
intr_mgt->lock internally to protect ... against concurrent callers" and the
changelog says "callers need not hold any upper-layer lock", yet the teardown
drops that lock mid-operation and correctness depends on
disp_mgt->ops_mutex_lock.  Could the dependency on the dispatch mutex be
stated explicitly, or the intermediate state be marked so the completion
phase can detect it?

[ ... ]

> +/**
> + * nbl_res_intr_cfg_msix_map - allocate & program MSI-X mapping table
> + * @res_mgt: resource management instance
> + * @func_id: target function identifier
> + * @num_net_msix: required net data interrupt vectors
> + * @num_others_msix: required control interrupt vectors
> + * @net_msix_mask_en: enable mask for net interrupt entries
> + *
> + * Allocate interrupt vectors; MSIX coherent DMA table is allocated once
> + * per function on first configuration, entries are updated in-place on
> + * subsequent reconfigurations. No free/realloc of DMA table on vector
> + * count changes. This removes the DMA table free/realloc cycle,
> + * per-reconfig timed sleep and the in-flight DMA race window.

[Severity: Low]
This isn't a bug, but this file is created by this patch, so what does "This
removes the DMA table free/realloc cycle, per-reconfig timed sleep and the
in-flight DMA race window" refer to?  The changelog has the same phrasing:

	"Subsequent reconfigurations reuse the existing DMA buffer and avoid
	 free/realloc cycles, removing the associated DMA race window and
	 quiesce sleep on reconfigure."

Since there is no earlier in-tree implementation, could both be reworded as a
plain description of the new behaviour rather than a delta?  As written a
reader may go looking for the commit being fixed.

> + *
> + * Serialization: this function takes intr_mgt->lock internally to
> + * protect the global vector bitmaps and per-function state against
> + * concurrent callers.
> + *
> + * Return: 0 on success, negative errno on failure
> + */

[ ... ]

> +	/* Allocate MSIX DMA table once per function */
> +	if (!official_tbl->base_addr) {
> +		official_tbl->size =
> +			sizeof(struct nbl_msix_map) *
> +			NBL_MSIX_MAP_TABLE_MAX_ENTRIES;
> +		official_tbl->base_addr = dma_alloc_coherent(dev,
> +							     official_tbl->size,
> +							     &official_tbl->dma,
> +							     GFP_KERNEL);
> +		if (!official_tbl->base_addr) {
> +			dev_err(dev, "Failed to allocate DMA memory for MSIX table\n");
> +			ret = -ENOMEM;
> +			goto release_vecs_unlock;
> +		}
> +	}
> +
> +	/* Allocate net interrupt vectors */
> +	for (i = 0; i < num_net_msix; i++) {
> +		intr_index = find_first_zero_bit(intr_mgt->intr_net_bmap,
> +						 NBL_MAX_NET_INTERRUPT);
> +		if (intr_index == NBL_MAX_NET_INTERRUPT) {
> +			dev_err(dev, "No free net interrupt vectors left\n");
> +			ret = -EAGAIN;
> +			goto release_vecs_unlock;
> +		}

[Severity: Medium]
Does this path leak the coherent MSI-X map table?  The 2 KiB buffer
(sizeof(struct nbl_msix_map) * 1024) is stored in
func_intr_res[func_id].msix_map_table before the vector loops run, but
.interrupts is only swapped in on the success path.  On the -EAGAIN branches
release_vecs_unlock only releases the bitmap and frees tmp_interrupts:

release_vecs_unlock:
	nbl_intr_release_bitmap(res_mgt, tmp_interrupts, allocated_cnt);
	kfree(tmp_interrupts);
out_unlock:
	mutex_unlock(&intr_mgt->lock);

and both teardown helpers skip func_ids whose .interrupts is NULL:

__nbl_res_intr_complete_destroy_msix_map()
	interrupts = intr_mgt->func_intr_res[func_id].interrupts;
	if (!interrupts)
		return 0;		/* dma_free_coherent() never reached */

nbl_intr_mgt_stop()
	if (intr_mgt->func_intr_res[func_id].interrupts) {

Combined with the unmanaged dma_alloc_coherent() noted earlier, wouldn't that
buffer stay allocated across unbind and module unload?

The bitmap exhaustion branch looks reachable from a peer PF:
nbl_disp_chan_cfg_msix_map_resp() passes num_net_msix / num_others_msix
straight from the mailbox payload, each bounded only by
NBL_MSIX_MAP_TABLE_MAX_ENTRIES (1024), while NBL_MAX_OTHER_INTERRUPT is also
1024, so two large "others" requests exhaust intr_other_bmap.

[ ... ]

> +	if (intr_mgt->func_intr_res[func_id].interrupts) {
> +		old_interrupts = intr_mgt->func_intr_res[func_id].interrupts;
> +		old_num = intr_mgt->func_intr_res[func_id].num_interrupts;
> +
> +		ret = __nbl_res_intr_set_mailbox_irq(res_mgt, func_id, 0,
> +						     false);
> +		if (ret) {
> +			dev_err(dev, "%s: disable old mailbox irq failed, keep old config\n",
> +				__func__);
> +			goto release_vecs_unlock;
> +		}
> +		for (j = 0; j < old_num; j++) {
> +			hw_ops->cfg_msix_info(res_mgt->hw_ops_tbl->priv,
> +					      func_id, false, old_interrupts[j],
> +					      0, 0, 0, false);
> +		}
> +		hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
> +		nbl_intr_release_bitmap(res_mgt, old_interrupts, old_num);
> +		kfree(old_interrupts);

[Severity: Medium]
The old global vector indices go straight back into the shared
intr_net_bmap / intr_other_bmap here, with no quiesce, while
NBL_PCOMPLETER_FUNCTION_MSIX_MAP for this func_id is still VALID and its
coherent table still contains those old indices (the table is only rewritten
a few lines further down).

The destroy path treats the wait as mandatory before releasing anything
("waits ~1ms for in-flight hardware DMA table fetch to quiesce").  If the
next cfg_msix_map() for a different func_id picks up one of these indices and
programs NBL_PADPT_HOST_MSIX_INFO / NBL_PCOMPLETER_HOST_MSIX_FID_TABLE with
that other function's BDF and FID, can a straggler fetch on behalf of the
reconfigured func_id end up delivering into the other PF's vector space?

> +	}
> +
> +	/* Swap new vector array into func state */
> +	intr_mgt->func_intr_res[func_id].interrupts = tmp_interrupts;
> +	intr_mgt->func_intr_res[func_id].num_interrupts = requested;
> +	intr_mgt->func_intr_res[func_id].num_net_interrupts = num_net_msix;
> +	tmp_interrupts = NULL;
> +
> +	/*
> +	 * Fill MSIX map table IN-PLACE in the pre-allocated DMA buffer.
> +	 * Only zero entries beyond requested count to avoid full table
> +	 * memset overhead.
> +	 */
> +	msix_map_entries = official_tbl->base_addr;
> +	memset(msix_map_entries + requested, 0,
> +	       (NBL_MSIX_MAP_TABLE_MAX_ENTRIES - requested) *
> +	       sizeof(*msix_map_entries));
> +
> +	for (i = 0; i < requested; i++) {
> +		gvec = intr_mgt->func_intr_res[func_id].interrupts[i];
> +		msix_map_entries[i].data =
> +			cpu_to_le16(FIELD_PREP(NBL_MSIX_MAP_VALID_MASK, 1) |
> +				    FIELD_PREP(NBL_MSIX_MAP_INDEX_MASK,
> +					       gvec));
> +		entry_masked = (i < num_net_msix && net_msix_mask_en);
> +		hw_ops->cfg_msix_info(res_mgt->hw_ops_tbl->priv,
> +				      func_id, true, gvec,
> +				      bus, devid, function,
> +				      entry_masked);
> +	}

[Severity: Medium]
On the reconfigure branch this rewrites the coherent table while
NBL_PCOMPLETER_FUNCTION_MSIX_MAP for func_id is still programmed VALID=1 with
the same DMA address, since Phase2 above says:

	 * NOTE: NO DMA table free here, only invalidate HW entries and
	 * release vec bitmap.

The memset() and the per-entry stores go into that still-armed buffer, and
dma_wmb() only comes afterwards.  Also, for each i the entry is published
pointing at gvec before cfg_msix_info() makes
NBL_PADPT_HOST_MSIX_INFO[gvec] / NBL_PCOMPLETER_HOST_MSIX_FID_TABLE[gvec]
valid, so a fetch in that window resolves entry i to a global vector whose
info/FID entry was just zeroed in Phase2.

Should this path clear VALID and quiesce first, the way
__nbl_res_intr_prepare_destroy_msix_map() does, given the hw layer comment
says reg_lock "cannot synchronize hardware DMA reads"?

The reconfigure branch does look reachable: nbl_dev_stop() / nbl_dev_start()
treat destroy_msix_map as best-effort, so a peer PF whose destroy RPC fails
leaves the map installed and the next bind re-enters here with
func_intr_res[func_id].interrupts non-NULL.

[ ... ]

> +void nbl_intr_mgt_stop(struct nbl_resource_mgt *res_mgt)
> +{

[ ... ]

> +	mutex_unlock(&intr_mgt->lock);
> +
> +	res_mgt->intr_mgt = NULL;
> +}

[Severity: Low]
res_mgt->intr_mgt is cleared with a plain store outside intr_mgt->lock, while
every public entry point loads that pointer unsynchronized and only then
locks the object it points at, for example in nbl_res_intr_cfg_msix_map():

	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
	...
	if (!intr_mgt)
		return -EINVAL;
	...
	mutex_lock(&intr_mgt->lock);

No "stopping" state is published before the lock is dropped for the global
quiesce, and there is no refcount or operation drain, so structurally a
caller could latch the old pointer and then work on a stopped manager whose
devm memory is released once remove returns.

I could not build a reachable case: all entry points run under
disp_mgt->ops_mutex_lock, and nbl_intr_mgt_stop() is only reached from
nbl_res_remove_leonis() after nbl_dev_remove_common_dev() has done
cancel_work_sync(&common_dev->clean_mbx_task) and removed the mailbox queue,
including on the nbl_core_init() failure paths.  Is that external ordering
the intended guarantee, and could it be noted next to the NULL store?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914123429.56596-1-illusion.wang%40nebula-matrix.com
