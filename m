Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF594F798B;
	Thu,  3 Sep 2026 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455922; cv=none; b=rt5TMbofpzbGMndvT4+6BzNvMdIPRGRr5p//e+rKgfhQrt0x8ppeVl1OvNYcKDmSdzzePCKbXX78Ee+zQLUt1VZGZJbB2L2TbVQBZi0E9+nB9jCuWG2WHgUAhXs7o4YLeoZRkmHdyTJoZtgpfMSODQlXfJFPRg+NTegwPvoQv60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455922; c=relaxed/simple;
	bh=kJJLVC0nBQuxSnW8vAwUAUojsqudz1yQvjIzDViSRHg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dnslGGH+lA1OLnDskcgblPd9RvSNvw07GxDZzsyIcs10+sYQgvw3EBL2vGUYWGU0i1QiD7t7X/F1KSo0RkWL6EQVziQ1IjDVPsONbbyoin63zhNJgAnRHJA9uFSdoVYDe5rgkIxglrOOWf/+hLmmJvlOrd1xcZmaAa66l7Imxrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQ/AG6CQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ/AG6CQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF811F01559;
	Thu,  3 Sep 2026 17:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455920;
	bh=pQJC8pe3vW8dfTURRja3oppbK/rB4jhlolo4qpWGWeI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AQ/AG6CQQ/hYx/CETZUSaxtiaQLvggdl2RXne1ldaH9YjEXVA4VWhSDbvS+L1eCSl
	 jmawq01wxwqioDUj+yioud9grJEXvUAi+Yte+eW9+MzNNJnwtgEB+LKRoK+4FWLK9O
	 wmpb1eevxqCdjxb1BBYcVVFoT5u8WCH2KRBJRVThVj7zTf7L0mIHYvX2WO2vO90U2s
	 FP9BPmpMWmZz75J8uzWX8AvmVyaIh/AdVr2TdlQxsY+ZZzq8ezdduDXm2TljminyC4
	 SenkOqzO/+ubCsT0dk/1eLLZfg5qqdYUSGE0d0MbiFlV7jqSsetJiMXsPswG5giIrS
	 NT0jgyRBo9MRA==
Subject:
 Re: [v26,net-next,05/10] net/nebula-matrix: add intr resource implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 17:18:38 +0000
Message-ID: <178845591897.3394541.11397950332049451514@kernel.org>
In-Reply-To: <20260831021408.2325-6-illusion.wang@nebula-matrix.com>
References: <20260831021408.2325-6-illusion.wang@nebula-matrix.com>
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
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 1 · Low: 5

- [High] Teardown asymmetry in the interrupt manager:
  nbl_intr_mgt_start() has no counterpart, and nothing ever walks…
- [High] nbl_res_func_id_to_bdf explicitly treats all func_ids as PF IDs,
  causing MSI-X configuration to fail for all VFs.
- [Medium] nbl_res_intr_destroy_msix_map() releases the coherent MSI-X
  map table with dmam_free_coherent() after only a fixed…
- [Low] The kernel-doc of nbl_res_intr_set_mailbox_irq() states "Return:
  0 on success, negative errno on parameter check or hw failure", but…
- [Low] (Retained for policy reasons; my verification indicates this is
  NOT a defect.) Concern: nbl_res_intr_destroy_msix_map() recycles the…
- [Low] (Retained for policy reasons; my verification indicates this is
  NOT a defect.) Concern: the commit message credits…
- [Low] (Retained for policy reasons; my verification indicates this is
  resolved later in the series.) Concern: nbl_res_intr_cfg_msix_map()…
- [Low] (Retained for policy reasons; my verification indicates this is
  resolved later in the series.) Concern: per-function interrupt…

--

net/nebula-matrix: add intr resource implementation

This adds the nbl_interrupt module, which owns the driver-wide global
MSI-X index space (intr_net_bmap / intr_other_bmap) and programs the
chip-internal MSI-X mapping registers.  It exposes cfg_msix_map,
destroy_msix_map and set_mailbox_irq through the resource ops, and
instantiates the manager from nbl_res_start() via nbl_intr_mgt_start().

A few questions below, mostly around teardown.

    Physical PCI MSI-X vector allocation lives in device layer via
    nbl_dev_init_interrupt_scheme().

[Severity: Low]
This isn't a bug, but nbl_dev_init_interrupt_scheme() does not exist in
the tree at this commit, and neither does any caller of cfg_msix_map,
destroy_msix_map or set_mailbox_irq.  Both arrive later in the series
("dispatch: implement channel RPC framework and serialize hardware ops"
and "add common dev start/stop operation").

Could the message say the symbol is added later in the series, so a
reader bisecting to this commit does not go looking for it?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> new file mode 100644
> index 000000000000..52872264e906
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> @@ -0,0 +1,402 @@

[ ... ]

> +int nbl_res_intr_destroy_msix_map(struct nbl_resource_mgt *res_mgt,
> +				  u16 func_id)
> +{

[ ... ]

> +	/* Step 1: mask each MSIX vector in hardware first */
> +	for (i = 0; i < intr_num; i++) {
> +		hw_ops->cfg_msix_info(res_mgt->hw_ops_tbl->priv,
> +				      func_id, false, interrupts[i],
> +				      0, 0, 0, false);
> +	}
> +
> +	nbl_intr_release_bitmap(res_mgt, interrupts, intr_num);

[Severity: Low]
This isn't a bug in the final series, but the resource layer here looks
self-inconsistent.  nbl_res_intr_destroy_msix_map() returns the global
vector ids to intr_net_bmap / intr_other_bmap and clears
PADPT_HOST_MSIX_INFO, PCOMPLETER_HOST_MSIX_FID_TABLE and
FUNCTION_MSIX_MAP, but it never clears the MSIX_IDX / MSIX_IDX_VALID
fields in NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id) that
nbl_hw_set_mailbox_irq() programmed.

Afterwards the repair path is closed too, because
nbl_res_intr_set_mailbox_irq() rejects the disable case once the array
is gone:

	if (!intr_mgt->func_intr_res[func_id].interrupts) {
		dev_err(dev, "func %u MSIX map not configured\n", func_id);
		return -ENODEV;
	}

even though nbl_hw_set_mailbox_irq() ignores global_vec_id when
en_msix is false.

I checked the end of the series and nothing reaches that state:
nbl_dev_stop() calls nbl_dev_disable_mailbox_irq() before
nbl_dev_destroy_msix_map(), nbl_dev_start() configures the map before
enabling the mailbox irq, and cfg_msix_map() has a single caller.  So
the ordering happens to be correct everywhere.

The ordering requirement is only prose though, and the RPC handler
nbl_disp_chan_destroy_msix_map_resp() accepts a destroy request from a
peer without requiring a prior set_mailbox_irq(false).  Would it be
worth having destroy_msix_map() clear the mailbox route it owns, and
letting the disable path succeed when no map is configured?

> +
> +	/*
> +	 * Stage 1 tear down: retain valid DMA address, ONLY clear VALID bit
> +	 * avoid hardware torn read (VALID=1 & dma_addr=0)
> +	 */
> +	hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
> +			     false, live_dma, 0, 0, 0);
> +	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
> +
> +	/*
> +	 * Hardware provides no idle status register for MSIX map DMA engine.
> +	 * Use bounded sleep to mitigate race between posted MMIO disable writes
> +	 * and ongoing in-flight table read DMA access.
> +	 * After sleep, hardware no longer performs DMA access to MSIX table.
> +	 */
> +	usleep_range(NBL_MSIX_DMA_SYNC_MIN_US, NBL_MSIX_DMA_SYNC_MAX_US);
> +
> +	/*
> +	 * Stage 2: hardware has quiesced MSIX table DMA access,
> +	 * fully zero MSIX map entry safely now
> +	 */
> +	hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
> +			     false, 0, 0, 0, 0);
> +	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
> +
> +	/*
> +	 * Now safe to release old MSIX DMA memory, prevents devres accumulation
> +	 * leak Since hardware DMA has quiesced after sleep, no IOMMU fault risk
> +	 * anymore.
> +	 */
> +	if (msix_map_table->base_addr) {
> +		dmam_free_coherent(dev, msix_map_table->size,
> +				   msix_map_table->base_addr,
> +				   msix_map_table->dma);
> +	}

[Severity: Medium]
Can the 100-120 us sleep be relied on here?  The comment states "After
sleep, hardware no longer performs DMA access to MSIX table", but as
the changelog itself says there is no idle status register for this
engine, so there is no device-observable handshake backing that claim.

The sequence is:

	cfg_msix_map(valid=false, live_dma)   /* posted MMIO */
	flush_write()
	usleep_range(100, 120)
	dmam_free_coherent(...)               /* IOVA torn down */

A table fetch already issued before the VALID clear was observed can
complete after dmam_free_coherent() has unmapped the buffer.  PCIe
bounds read completion only by the completion timeout range (tens of
microseconds up to tens of milliseconds), not by 100 us, and a switch,
congested link or an IOMMU in the path can push past it.

The outcome would be exactly what this code is trying to avoid: an
IOMMU translation fault, or a fetch of memory already handed to another
owner followed by an MSI-X raised with a garbage global index.

Is there any status bit, or a read-back of a register the engine
updates, that could be polled instead?  Failing that, would retaining
the buffer (freeing it only at detach, or after a much longer bound)
be safer than a fixed sleep?

> +
> +	/* Release runtime allocated interrupt vector buffer */
> +	kfree(intr_mgt->func_intr_res[func_id].interrupts);
> +	intr_mgt->func_intr_res[func_id].interrupts = NULL;
> +	intr_mgt->func_intr_res[func_id].num_interrupts = 0;
> +	intr_mgt->func_intr_res[func_id].num_net_interrupts = 0;

[ ... ]

> +int nbl_res_intr_cfg_msix_map(struct nbl_resource_mgt *res_mgt,
> +			      u16 func_id, u16 num_net_msix,
> +			      u16 num_others_msix,
> +			      bool net_msix_mask_en)
> +{

[ ... ]

> +	/* Allocate net interrupt vectors */
> +	for (i = 0; i < num_net_msix; i++) {
> +		intr_index = find_first_zero_bit(intr_mgt->intr_net_bmap,
> +						 NBL_MAX_NET_INTERRUPT);
> +		if (intr_index == NBL_MAX_NET_INTERRUPT) {
> +			dev_err(dev, "No free net interrupt vectors left\n");
> +			ret = -EAGAIN;
> +			goto release_vecs;
> +		}
> +		tmp_interrupts[i] = intr_index + NBL_NET_INTR_BASE;
> +		set_bit(intr_index, intr_mgt->intr_net_bmap);
> +	}

[Severity: Low]
The find_first_zero_bit() plus separate set_bit() on the driver-wide
intr_net_bmap / intr_other_bmap is not atomic, so at this commit two
concurrent calls for different func_ids could hand the same global
index to two functions.

I checked the rest of the series and this is covered: the later
dispatch patch wraps every entry point (nbl_disp_cfg_msix_map(),
nbl_disp_destroy_msix_map(), nbl_disp_set_mailbox_irq() and the three
matching nbl_disp_chan_*_resp() handlers) in
disp_mgt->ops_mutex_lock, and there is one disp_mgt per adapter, so
the allocations end up serialized.

Since the requirement lives only in the comment, would a
lockdep_assert_held() on that mutex, or a double-underscore name for
these helpers, make the contract checkable?

> +
> +	/* Allocate other interrupt vectors */
> +	for (; i < requested; i++) {
> +		intr_index =
> +			find_first_zero_bit(intr_mgt->intr_other_bmap,
> +					    NBL_MAX_OTHER_INTERRUPT);

[ ... ]

> +/**
> + * nbl_res_intr_set_mailbox_irq - bind mailbox IRQ to specified vector
> + * @res_mgt: resource management instance
> + * @func_id: target function identifier
> + * @vector_id: index inside local interrupt array
> + * @en_msix: enable/disable mailbox interrupt
> + *
> + * Caller note: this function has no internal locking. Serialization
> + * must be guaranteed at upper dispatch layer.
> + *
> + * Return: 0 on success, negative errno on parameter check or hw failure
> + */

[Severity: Low]
Can this function ever report a hardware failure?  The only hardware
call it makes is hw_ops->set_mailbox_irq(), which is declared void in
struct nbl_hw_ops (nbl_def_hw.h), and its only implementation
nbl_hw_set_mailbox_irq() returns nothing:

	void (*set_mailbox_irq)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
				bool en_msix, u16 global_vec_id);

So every non-zero return comes from the three parameter and state
checks.  Should the "or hw failure" wording be dropped, or should the
hw op return a status?

> +int nbl_res_intr_set_mailbox_irq(struct nbl_resource_mgt *res_mgt,
> +				 u16 func_id, u16 vector_id,
> +				 bool en_msix)
> +{

[ ... ]

> +	if (!intr_mgt->func_intr_res[func_id].interrupts) {
> +		dev_err(dev, "func %u MSIX map not configured\n", func_id);
> +		return -ENODEV;
> +	}
> +	if (vector_id >= intr_mgt->func_intr_res[func_id].num_interrupts) {
> +		dev_err(dev, "vector_id %u out of range (max %u)\n",
> +			vector_id,
> +			intr_mgt->func_intr_res[func_id].num_interrupts - 1);
> +		return -EINVAL;
> +	}
> +
> +	global_vec_id = intr_mgt->func_intr_res[func_id].interrupts[vector_id];

[Severity: Low]
Same observation for the per-function state.  At this commit
func_intr_res[].interrupts is validated and then dereferenced here
while nbl_res_intr_destroy_msix_map() may kfree() it, and two
concurrent destroys would snapshot the same interrupts and
msix_map_table->base_addr pointers and free them twice.

The later dispatch patch closes both by taking the same per-adapter
ops_mutex_lock around all six entry points into these three functions,
and nbl_intr_mgt_start() is the only other toucher and runs
single-threaded during probe, so no in-tree path hits either case.

The resource layer still relies on prose only ("Serialization must be
guaranteed at upper dispatch layer") with nothing asserting it.

[ ... ]

> +static struct nbl_interrupt_mgt *nbl_intr_setup_mgt(struct device *dev)
> +{
> +	struct nbl_interrupt_mgt *intr_mgt;
> +
> +	intr_mgt = devm_kzalloc(dev, sizeof(*intr_mgt), GFP_KERNEL);
> +	if (!intr_mgt)
> +		return ERR_PTR(-ENOMEM);
> +
> +	bitmap_zero(intr_mgt->intr_net_bmap, NBL_MAX_NET_INTERRUPT);
> +	bitmap_zero(intr_mgt->intr_other_bmap, NBL_MAX_OTHER_INTERRUPT);
> +
> +	return intr_mgt;
> +}
> +
> +int nbl_intr_mgt_start(struct nbl_resource_mgt *res_mgt)
> +{
> +	struct device *dev = res_mgt->common->dev;
> +	struct nbl_interrupt_mgt *intr_mgt;
> +	int ret;
> +
> +	intr_mgt = nbl_intr_setup_mgt(dev);
> +	if (IS_ERR(intr_mgt)) {
> +		ret = PTR_ERR(intr_mgt);
> +		return ret;
> +	}
> +	res_mgt->intr_mgt = intr_mgt;
> +	return 0;
> +}

[Severity: High]
This helper treats func_id as a PF id throughout, but the callers
hand it the whole function id space.  nbl_res_intr_cfg_msix_map(),
nbl_res_intr_destroy_msix_map() and nbl_res_intr_set_mailbox_irq() all
bound func_id by NBL_MAX_FUNC, which this patch defines as 520, and
intr_mgt->func_intr_res[] is sized the same way, so the interrupt
manager is clearly meant to track VFs as well as the 8 PFs.

For any func_id past the PF range nbl_common_func_id_to_rel_pf_id()
subtracts common->mgt_pf and the resulting rel_pf_id then trips this
check against resource_info->max_pf, so nbl_res_func_id_to_bdf()
returns -ERANGE and nbl_res_intr_cfg_msix_map() aborts before it
allocates anything.  A VF whose map is programmed on its behalf by the
ctrl PF (the CONFIGURE_MSIX_MAP RPC handler added later in the series
passes the peer's src_id straight through as func_id) can therefore
never get an MSI-X mapping, and the failure is silent apart from a
dev_err that reports the value as "PF ID".

The lookup itself has no VF support either: sriov_info[rel_pf_id].bdf
only records the PF bdf, and there is nothing here that applies the
SR-IOV VF offset/stride to derive a VF's bus/dev/func.

Is VF handling intended to land in a later patch?  If so, would it be
clearer to reject the out-of-PF-range func_id in
nbl_res_intr_cfg_msix_map() with an explicit "VF not supported yet"
path, rather than having it surface as -ERANGE from a BDF lookup that
reports it as a bad PF id?  Or should nbl_res_func_id_to_bdf() learn
to map a VF func_id to its owning PF and compute the VF bdf from the
capability offset and stride?

[Severity: High]
Does nbl_intr_mgt_start() need a counterpart?  Nothing in the series
walks intr_mgt->func_intr_res[] at detach, and nbl_res_remove_leonis()
is still an empty function whose comment says:

	/*
	 * No resource release here because all memory uses devm managed
	 * allocation
	 */

That comment no longer holds after this patch, since the per-function
vector array is kcalloc()'d in nbl_res_intr_cfg_msix_map() and only
freed in nbl_res_intr_destroy_msix_map().

The part I am unsure about is the remote PFs.  On a 2 or 4 PF card,
PF1..PF3 configure their maps over the mailbox RPC, so
nbl_disp_chan_cfg_msix_map_resp() -> nbl_res_intr_cfg_msix_map(res_mgt,
src_id) allocates both the kcalloc()'d interrupts array and a
dmam_alloc_coherent() MSI-X table on the ctrl PF's device, recorded in
the ctrl PF's func_intr_res[1..3].

Later in the series nbl_dev_stop() only destroys its own function's
map:

	ret = nbl_dev_destroy_msix_map(dev_mgt);

so when the ctrl PF detaches first (plain rmmod nbl detaches in bind
order, and unbinding PF0 alone through sysfs is a normal admin action)
the path is:

nbl_core_stop()          /* destroys only func_id == common->mgt_pf */
  nbl_core_remove()
    nbl_res_remove_leonis()   /* empty */
      devres release

Two things follow from that.  Does this leak
func_intr_res[1..3].interrupts, since kfree() on those arrays only ever
runs from nbl_res_intr_destroy_msix_map()?

And can devres release the remote PFs' coherent MSI-X tables while
NBL_PCOMPLETER_FUNCTION_MSIX_MAP(func), NBL_PADPT_HOST_MSIX_INFO and
NBL_PCOMPLETER_HOST_MSIX_FID_TABLE for those functions still hold
VALID=1 and the live bus address?  That skips the two-stage clear plus
quiesce sleep that destroy_msix_map() documents as required before
freeing the table.  The remaining PFs cannot repair it later either,
because their nbl_dev_stop() RPCs go to a mailbox that is already gone.

Would an nbl_intr_mgt_stop() in nbl_res_remove_leonis(), iterating
func_intr_res[] and calling nbl_res_intr_destroy_msix_map() for each
configured func_id, cover this?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> index a719cc8fbf8a..4b6a5bc8715a 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c

[ ... ]

> @@ -287,6 +292,10 @@ static int nbl_res_start(struct nbl_resource_mgt *res_mgt)
>  		ret = nbl_res_ctrl_dev_vsi_info_init(res_mgt);
>  		if (ret)
>  			return ret;
> +
> +		ret = nbl_intr_mgt_start(res_mgt);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	return 0;

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> index ee53f9e10a8e..fd86eef4a0d3 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h

[ ... ]

> @@ -39,6 +47,8 @@ struct nbl_hw_ops {
>  
>  	void (*cfg_mailbox_qinfo)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
>  				  u8 bus, u8 devid, u8 function);
> +	void (*set_mailbox_irq)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
> +				bool en_msix, u16 global_vec_id);
>  	void (*get_fw_eth_map)(struct nbl_hw_mgt *hw_mgt, u32 *eth_map);
>  	void (*get_board_info)(struct nbl_hw_mgt *hw_mgt,
>  			       struct nbl_board_port_info *board);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831021408.2325-1-illusion.wang%40nebula-matrix.com
