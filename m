Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C342D45D5D2;
	Sat, 26 Sep 2026 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431244; cv=none; b=eCp1fAgukNHTZAXa0Db/PJgOFbEcFOuP41x6rldZ0Q/Yp2xWjyw3SntAX5fY6gP8iefEjMUckW5ljgWcAZfAdRn7PT18rXCm+Eg/lbEKhOIxvfJDper09kSHm4DPkBtFd6igS1aK5GVjr/u4tWLCaziWnvgOiHt9Ymvpo70u9r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431244; c=relaxed/simple;
	bh=kckxKRXJkADKdXgiURY49CHLlF2cmrsMh8oLqeaplEg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VrE204GHsPjnQdwGvSDJOMg5qJ3nOFUdp3T5o6GCzjEMoxgBe0ecYyU/wxo1FGst33DDzyh4XSsfXyca4v0ubHlT2HS+y9is/emUuF037NvZLYLjV2Hj+djAR69SIpa+NP0wXneaz2FdHVweHHlC8Y58Qk3cnBGfs9fc7LQrU0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpL4a5JJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpL4a5JJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F3C1F00898;
	Sat, 26 Sep 2026 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790431230;
	bh=yRML5XPr0cyAt42zN5XUmrsOr6xLaHNRMfrhmpMDGyk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PpL4a5JJFswTytLAsQuFcEZJ0qBmdVtr3sURpNm0tlQNKKLP0OW5VnuNPRiUs9v+B
	 Ft99njtbO/D5bqWAP6kpl4uyNzw3UEft+LpyUR2450v6M+tnW+rJugapN/8gHcQ/7m
	 Gq47Vocoak8/AqTsxF7rKzrnkELaR3lAlfwfjKHjolpk+ff1u0jv4P+sGCDHm4Vugf
	 +RlNk/OvtKYcNhZ8XZVFY5WZ0YKHIjvW4xHLrkAlLSb25NuDHBGNDEQdQ0R4iyMQeL
	 db+xnuW4IoTMUfQHlZ2B48Ziycflt60ByYyDyy30OJkp10EW5JWJqipDnamNcFSn/x
	 wdB3lM8H7lLng==
Subject: Re: [PATCH v29 net-next 3/8] net/nebula-matrix: add intr resource
 implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 26 Sep 2026 14:00:29 +0000
Message-ID: <179043122966.2160803.8601674260431902247@kernel.org>
In-Reply-To: <20260922120311.86593-4-illusion.wang@nebula-matrix.com>
References: <20260922120311.86593-4-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 3 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The deferred vector-recycling deadline in
  nbl_intr_retire_vectors_locked() is `retired->expires = jiffies +…
- [Medium] On reconfiguration, nbl_res_intr_cfg_msix_map() rewrites the
  coherent MSI-X map table in place while the hardware FUNCTION_MSIX_MAP…
- [Medium] The new interrupt module never invalidates the chip tables it
  owns at init, and nbl_hw_cfg_msix_map() programs them in an unsafe…
- [Low] Commit message says nbl_intr_mgt_stop() cleans up "leftover MSI-X
  maps (including remote PF maps via mailbox RPC)" and the new resource…
- [Low] The ownership note in nbl_res_remove_leonis() documents the wrong
  memory-management API family: it states "Tear down all MSI-X maps…
- [Low] struct nbl_interrupt_mgt embeds func_intr_res[NBL_MAX_FUNC] with
  NBL_MAX_FUNC == 520, but nbl_res_intr_cfg_msix_map() calls…
- [Low] Concern: __nbl_res_intr_destroy_msix_map() drops intr_mgt->lock
  and sleeps ~1 ms, then re-acquires the lock through a cached intr_mgt…
- [Low] Concern: __nbl_res_intr_set_mailbox_irq() validates only
  func_res->interrupts != NULL and vector_id < num_interrupts, but not…

--

net/nebula-matrix: add intr resource implementation

This adds a new nbl_interrupt module that owns the chip-internal MSI-X
vector index space (split into net and control bitmaps) and programs the
chip MSI-X mapping registers.  It also adds the hardware register
definitions and the resource/hw ops plumbing to reach the new code.

A few questions about the new module below.

Before the diff, one question about the commit message:

> - Global cleanup via nbl_intr_mgt_stop(): iterate all 520 function IDs to
> clean up leftover MSI-X maps (including remote PF maps via mailbox RPC)
> before devres releases coherent resources.

[Severity: Low]
nbl_intr_mgt_stop() only walks its own intr_mgt->func_intr_res[] state and
writes registers directly through hw_ops; there is no channel or mailbox
call anywhere in the new module.

Is the "via mailbox RPC" part meant to describe how those remote PF maps
were originally created (later in the series,
nbl_disp_chan_cfg_msix_map_resp() calls res_ops->cfg_msix_map(p, src_id,
...)), rather than how they are cleaned up here?

Related: none of cfg_msix_map, destroy_msix_map or set_mailbox_irq has an
in-tree caller in this patch; they are wired up by a later patch in the
series.  Would it help to say so explicitly, the same way the message
already does for pci_alloc_irq_vectors()?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index 82efe2b40a8c7..457e0212a7bfa 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> @@ -104,6 +104,20 @@ static void nbl_hw_rd_regs_lock(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 *data,
>  	spin_unlock(&hw_mgt->reg_lock);
>  }
>  
> +static void nbl_hw_wr_regs_lock(struct nbl_hw_mgt *hw_mgt, u64 reg,
> +				const u32 *data, u32 len)
> +{
> +	u32 size = len / 4;
> +	u32 i;
> +
> +	if (len % 4)
> +		return;
> +	spin_lock(&hw_mgt->reg_lock);
> +	for (i = 0; i < size; i++)
> +		wr32(hw_mgt->hw_addr, reg + i * sizeof(u32), data[i]);
> +	spin_unlock(&hw_mgt->reg_lock);
> +}
> +

[ ... ]

> @@ -130,6 +144,126 @@ static void nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt, u32 *eth_map)
>  	*eth_map = FIELD_GET(NBL_FW_BOARD_DW6_ETH_BITMAP_MASK, data);
>  }
>  

[ ... ]

> +static void nbl_hw_cfg_msix_map(struct nbl_hw_mgt *hw_mgt, u16 func_id,
> +				bool valid, dma_addr_t dma_addr, u8 bus,
> +				u8 devid, u8 function)
> +{
> +	struct nbl_function_msix_map function_msix_map;
> +
> +	memset(&function_msix_map, 0, sizeof(function_msix_map));
> +	if (valid) {
> +		function_msix_map.data[0] = lower_32_bits(dma_addr);
> +		function_msix_map.data[1] = upper_32_bits(dma_addr);
> +		/* use ctrl dev's bdf, because the dma memory was
> +		 * allocated by it
> +		 */
> +		function_msix_map.data[2] =
> +			FIELD_PREP(NBL_FUNCTION_MSIX_MAP_FUNCTION_MASK,
> +				   function) |
> +			FIELD_PREP(NBL_FUNCTION_MSIX_MAP_DEVID_MASK, devid) |
> +			FIELD_PREP(NBL_FUNCTION_MSIX_MAP_BUS_MASK, bus) |
> +			FIELD_PREP(NBL_FUNCTION_MSIX_MAP_VALID_MASK, 1);

[Severity: Medium]
This programs the map entry in ascending dword order through
nbl_hw_wr_regs_lock(): low address dword, high address dword, then
BDF plus VALID.  If the entry is already VALID from a previous driver
instance, can the pcompleter fetch the map with a spliced base address
(new low dword, stale high dword) before data[2] is rewritten?

The teardown path in this same function deliberately does the opposite
(keeps a live address, clears VALID) with the comment:

	 * Keep valid live dma address here, only clear VALID flag.

Would clearing VALID first, flushing, then writing the address and
setting VALID last be the safer order here as well?

Related: nbl_intr_mgt_start() -> nbl_intr_setup_mgt() only allocates and
zeroes software state; it does not invalidate
NBL_PCOMPLETER_FUNCTION_MSIX_MAP, NBL_PADPT_HOST_MSIX_INFO or
NBL_PCOMPLETER_HOST_MSIX_FID_TABLE at init.  The comment added above
nbl_hw_set_mailbox_irq() says these chip registers "survive kexec/forced
unload without FLR", which is why nbl_hw_cfg_mailbox_qinfo() clears
MSIX_IDX_VALID at init.  Does the same reasoning apply to the tables
added here, which additionally hold a host DMA address that the new
kernel now owns?

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

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> index 7804762a96e05..62af1738e2fdf 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c

[ ... ]

> @@ -322,8 +331,26 @@ int nbl_res_init_leonis(struct nbl_adapter *adap)
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

[Severity: Low]
Does this note describe the wrong API family?  The new module allocates
with dma_alloc_coherent() in nbl_res_intr_cfg_msix_map() and frees with
dma_free_coherent() in __nbl_res_intr_complete_destroy_msix_map() and in
the release_vecs_unlock error path; dmam_ is never used, so there is no
devres record for these tables and nothing for devres to release.

Either correcting the comment or switching to dmam_alloc_coherent() would
make the ownership model match the code.  As written, a future error path
that skips the explicit free would leak the coherent table for the
lifetime of the device with no devres safety net.

> +	 * intr_mgt itself (devm_kzalloc) is released by devres after this
> +	 * function returns
>  	 */
>  }
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> new file mode 100644
> index 0000000000000..e99a9d65c758b
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> @@ -0,0 +1,742 @@

[ ... ]

> +#define NBL_MSIX_DMA_SYNC_MIN_US	1000 /* us */
> +#define NBL_MSIX_DMA_SYNC_MAX_US	1200 /* us */

[ ... ]

> +static void nbl_intr_retire_vectors_locked(struct nbl_resource_mgt *res_mgt,
> +					   u16 *vectors, u16 cnt)
> +{
> +	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
> +	struct nbl_intr_retired_vectors *retired;
> +
> +	retired = kzalloc_obj(*retired, GFP_KERNEL);
> +	if (retired) {
> +		retired->vectors = vectors;
> +		retired->cnt = cnt;
> +		retired->expires = jiffies +
> +			usecs_to_jiffies(NBL_MSIX_DMA_SYNC_MIN_US);

[Severity: Medium]
Does this deadline actually deliver the ~1000 us quiesce window?

usecs_to_jiffies(1000) is 1 for the common HZ values, and adding a jiffy
count to the current jiffies only guarantees (count - 1) full ticks of
elapsed time.  With count == 1 the guaranteed wait is ~0 us, since the
current tick may be about to end.

nbl_intr_sweep_retired_locked() then releases the indices as soon as:

	if (!time_after_eq(jiffies, retired->expires))
		return;

holds, and nbl_res_intr_cfg_msix_map() calls the sweep immediately before
allocating from the same bitmaps with find_first_zero_bit().  So a just
retired global index can be reprogrammed into PADPT_HOST_MSIX_INFO and
PCOMPLETER_HOST_MSIX_FID_TABLE with a different function's BDF and FID
microseconds later.

The synchronous path uses usleep_range(NBL_MSIX_DMA_SYNC_MIN_US,
NBL_MSIX_DMA_SYNC_MAX_US) for exactly this purpose, and the struct field
is documented as "jiffies at which recycling is safe".  Would adding one
extra jiffy, or using a ktime based deadline, keep the documented window?

> +		list_add_tail(&retired->node, &intr_mgt->retired_list);
> +		return;
> +	}

[ ... ]

> +static int __nbl_res_intr_set_mailbox_irq(struct nbl_resource_mgt *res_mgt,
> +					  u16 func_id, u16 vector_id,
> +					  bool en_msix)
> +{

[ ... ]

> +	if (!intr_mgt->func_intr_res[func_id].interrupts) {
> +		dev_err(dev, "func %u MSIX map not configured\n", func_id);
> +		return -ENODEV;
> +	}

[Severity: Low]
This isn't reachable today, but should the enable path also test
state == NBL_INTR_FUNC_CONFIGURED (and intr_mgt->stopping), the way
nbl_res_intr_cfg_msix_map() rejects NBL_INTR_FUNC_DESTROYING with -EBUSY?

During the unlocked quiesce window of a teardown the function is in
NBL_INTR_FUNC_DESTROYING but interrupts[] is still populated, so only the
pointer and range checks here would pass.  An en_msix=true call in that
window would arm NBL_MAILBOX_QINFO_MAP MSIX_IDX/MSIX_IDX_VALID with a
global vector that __nbl_res_intr_complete_destroy_msix_map() is about to
release, and the complete phase never re-disables routing, so the routing
would outlive the vector.

I could not build that race with the current callers: every caller of
res_ops->set_mailbox_irq and res_ops->destroy_msix_map holds
disp_mgt->ops_mutex_lock across the whole resource call, and
nbl_intr_mgt_stop() runs only after the mailbox work item is cancelled.
The asymmetry between the two entry points still looks worth closing.

> +
> +	if (vector_id >= intr_mgt->func_intr_res[func_id].num_interrupts) {

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

[Severity: Low]
This isn't reachable with the callers in this series, but the lock is
dropped for ~1 ms and then retaken through the cached intr_mgt pointer,
while nbl_intr_mgt_stop() can set res_mgt->intr_mgt = NULL outside the
lock and let devres free the object:

nbl_intr_mgt_stop()
	mutex_unlock(&intr_mgt->lock);
	res_mgt->intr_mgt = NULL;

A thread parked in the window above would then either take a freed mutex
here, or dereference NULL when
__nbl_res_intr_complete_destroy_msix_map() re-reads res_mgt->intr_mgt.

I traced the callers and could not construct the overlap: all three public
ops are invoked under disp_mgt->ops_mutex_lock, the local path runs from
nbl_core_stop() before nbl_core_remove(), and nbl_dev_remove_common_dev()
does cancel_work_sync(&common_dev->clean_mbx_task) and tears down the
mailbox queue before nbl_res_remove_leonis() calls nbl_intr_mgt_stop().

Since nbl_intr_mgt_stop() has no admission or drain protocol, would an
explicit "no users in flight" guarantee (or clearing res_mgt->intr_mgt
under the lock) be worth adding so this stays safe if a caller outside the
dispatch mutex appears later?

> +
> +	return __nbl_res_intr_complete_destroy_msix_map(res_mgt, func_id);
> +}

[ ... ]

> +	/*
> +	 * Phase2: tear down old hardware MSIX config. Old vectors are
> +	 * moved to the retired list and recycled only after the
> +	 * hardware pipeline has quiesced.
> +	 * NOTE: NO DMA table free here, only invalidate HW entries.
> +	 */
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

[Severity: Medium]
On the reconfiguration path, only the per-vector PADPT_HOST_MSIX_INFO
entries are invalidated here; cfg_msix_map(..., valid=false, ...) is never
called, so NBL_FUNCTION_MSIX_MAP_VALID_MASK stays set for this function
and the pcompleter can DMA-read the table at any point.

The code then rewrites that same live table in place below, one entry at a
time, with the only barrier issued after the whole loop.  Can the device
observe a torn mix of old and new translations, for example a new gvec
whose PADPT_HOST_MSIX_INFO and FID entries are not valid yet, or a cleared
entry for a vector still in use?

__nbl_res_intr_prepare_destroy_msix_map() treats this as a real hazard and
does clear the map VALID bit, flush, and wait ~1 ms before touching the
table.  Should the reconfiguration path follow the same sequence, or
double-buffer the table?

> +		hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
> +		nbl_intr_retire_vectors_locked(res_mgt, old_interrupts,
> +					       old_num);

[ ... ]

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
> +	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
> +
> +	/* Ensure coherent memory writes are visible before HW DMA fetch */
> +	dma_wmb();

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
> index b316fb8e70519..635f34312c569 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
> @@ -68,6 +68,38 @@ int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)

[ ... ]

> +	if (rel_pf_id >= common->max_pf) {
> +		dev_err(common->dev,
> +			"func_id=%u rel_pf_id=%u exceeds max_pf=%u, VF BDF unsupported\n",
> +			pfid, rel_pf_id,
> +			common->max_pf);
> +		return -EOPNOTSUPP;
> +	}

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> index ae0a3d33198dc..c69d6f2ca3218 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h

[ ... ]

> +struct nbl_interrupt_mgt {
> +	struct mutex lock; /* Protects bitmap + func_intr_res[] */
> +	DECLARE_BITMAP(intr_net_bmap, NBL_MAX_NET_INTERRUPT);
> +	DECLARE_BITMAP(intr_other_bmap, NBL_MAX_OTHER_INTERRUPT);
> +	struct list_head retired_list;
> +	bool stopping; /* set on teardown, rejects new configurations */
> +	struct nbl_func_interrupt_resource_mng func_intr_res[NBL_MAX_FUNC];
> +};

[Severity: Low]
Can any func_id above max_pf ever occupy one of these 520 entries?

nbl_res_intr_cfg_msix_map() calls nbl_res_func_id_to_bdf() before
recording any state, and that helper returns -EOPNOTSUPP whenever
rel_pf_id >= common->max_pf, with max_pf bounded by NBL_MAX_PF (8).  So at
most 8 of the 520 entries can reach NBL_INTR_FUNC_CONFIGURED.

struct nbl_func_interrupt_resource_mng is 48 bytes after padding, so the
array is roughly 25 KB embedded in the single devm_kzalloc for intr_mgt
(an order-3 allocation), of which about 24.5 KB can never be used, and
both nbl_intr_mgt_stop() loops scan 520 entries that can never leave
NBL_INTR_FUNC_IDLE.

The commit message lists both "iterate all 520 function IDs" and "PF-only
support: explicitly reject VF function IDs with -EOPNOTSUPP" as features.
Which of the two is the intended design?

> +
>  /* --------- INFO ---------- */
>  struct nbl_sriov_info {
>  	unsigned int bdf;

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> index 59e44feab44fb..2c959832c32f4 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> @@ -13,6 +13,7 @@
>  #define NBL_MAX_PF					8
>  #define NBL_NEXT_ID(id, max) (((id) + 1) % ((max) + 1))
>  
> +#define NBL_MAX_FUNC					520
>  #define NBL_MAX_ETHERNET				4

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922120311.86593-2-illusion.wang%40nebula-matrix.com
