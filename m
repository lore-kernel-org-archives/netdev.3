Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FB434B1B0;
	Fri,  2 Oct 2026 03:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790912117; cv=none; b=QDuauhiLP5EfMp++Jbh4bLIbM9iPnE/xSdp3Z144K53GulsGaTR2+jTDJJPb7a9yndFf9a7sm4HUX1w3/upw3HDZQrXTxDQlGsiI+YwJ2daab6B0Isu7oZMxS3QQV/OaV/hsQtl2FrL0qWyucn3CFaTaGxke/CzHn3jNDdiCrTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790912117; c=relaxed/simple;
	bh=e6llGLkqVFyuFdZ8o8Cnq8o5C2cucRuhzXpp71A9mYM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rXfaUyoGAGqR3YyieWHLnkmZQzk23UmUcTrWeSt8fuLFWsjJkvaHi9YJs9kjpJSLA3klAInMPe2R1TMAeUrf/zhqUBsKdEdcavXbh/Mvs2cZ0rxnbDUwiw84+Y5iay1R07rBEoDHOQGEORd1wCJWHFmzWgUL2fjjiZelWF3uDG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1nHFNRP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1nHFNRP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681511F00898;
	Fri,  2 Oct 2026 03:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790912115;
	bh=kzbUExwxDCHOA7FSWuvkSCtsCOOx941ZwyU6mHC29q0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f1nHFNRPkrU66PqYfxIP/oOn9tvOMohuHAj4CtVQb6oSgSiiKLRDBpNBFFjvtVSWm
	 wfvzruFRPqOFGPpLwy1SHHs89pPCRA/rngBXQAoqHb2yWvNuPmhJlMrYiY6HZYnn17
	 raYXcwZICZl05dHYq53RJMSjtDtBVUXfWVN31ZPJV5U9YcNVr9ihGbQODxZknhTbcg
	 HK8he280jegSITOnaIar2Gks2vT3CqD2mGzUr8CtIj8rUC82uYvYqTM3DKNxba51Aw
	 nkkPe/+wIweRUgPc1zFhB4revqwKnfilbtWxbJ/ES55w1sXGvD33sOS3gId2AJdBEm
	 JqLi0464LrnOg==
Subject: Re: [PATCH v30 net-next 3/8] net/nebula-matrix: add intr resource
 implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 03:35:15 +0000
Message-ID: <179091211500.434549.13484540437234503727@kernel.org>
In-Reply-To: <20260928123237.88994-4-illusion.wang@nebula-matrix.com>
References: <20260928123237.88994-4-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 6

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Nothing clears the chip-internal MSI-X routing tables at init:
  NBL_PCOMPLETER_FUNCTION_MSIX_MAP (per-function VALID, table DMA…
- [Low] In nbl_res_intr_cfg_msix_map(), a reconfiguration allocates the
  whole new vector set from intr_net_bmap/intr_other_bmap (the…
- [Low] In nbl_hw_cfg_msix_map(), the valid branch has the comment "clear
  VALID first, prevent torn read of partial entry", but the code writes…
- [Low] Several comments describe teardown synchronization the code does
  not implement.
- [Low] struct nbl_interrupt_mgt (nbl_resource.h) embeds
  func_intr_res[NBL_MAX_FUNC] with NBL_MAX_FUNC = NBL_MAX_PF +…
- [Low] The public entry points nbl_res_intr_destroy_msix_map() and
  nbl_res_intr_set_mailbox_irq() read res_mgt->intr_mgt without a lock,…
- [Low] Before dma_free_coherent() of the MSI-X map table
  (__nbl_res_intr_destroy_msix_map ->…

--

net/nebula-matrix: add intr resource implementation

This patch adds an nbl_interrupt module. For the control PF, it manages
the chip-internal MSI-X vector index space with separate net and other
bitmaps, and it programs the chip MSI-X map, info and FID tables. It also
adds the cfg_msix_map, destroy_msix_map and set_mailbox_irq resource ops,
and a global nbl_intr_mgt_stop() teardown called from
nbl_res_remove_leonis().

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index 4d3477f70bcc..acd4f3dd0757 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c

[ ... ]

> @@ -123,6 +137,139 @@ static void nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt, u32 *eth_map)

[ ... ]

> +static void nbl_hw_cfg_msix_map(struct nbl_hw_mgt *hw_mgt, u16 func_id,
> +				bool valid, dma_addr_t dma_addr, u8 bus,
> +				u8 devid, u8 function)
> +{
> +	struct nbl_function_msix_map function_msix_map;
> +
> +	memset(&function_msix_map, 0, sizeof(function_msix_map));
> +	if (valid) {
> +		/* clear VALID first, prevent torn read of partial entry */
> +		function_msix_map.data[0] = 0;
> +		function_msix_map.data[1] = 0;
> +		function_msix_map.data[2] = 0;
> +		nbl_hw_wr_regs_lock(hw_mgt,
> +				    NBL_PCOMPLETER_FUNCTION_MSIX_MAP(func_id),
> +				    function_msix_map.data,
> +				    sizeof(function_msix_map));

[Severity: Low]
Does this write actually clear VALID first? nbl_hw_wr_regs_lock() writes
data[0] through data[3] in ascending order, and the VALID bit is in
data[2]:

nbl_hw_leonis.h:
/* data[2] */
...
#define NBL_FUNCTION_MSIX_MAP_VALID_MASK BIT(16)

If the entry is already VALID when this branch runs, the two DMA address
words get zeroed while the old VALID bit is still set. VALID is cleared
third, not first.

That leaves a window where the hardware could see VALID=1 with a zero or
half-written address, which is the torn state the comment says it
prevents. The teardown branch below avoids this by keeping the live
address while it clears VALID.

This needs the entry to be VALID on entry. After prepare/Phase 2 that
only happens with stale state from a previous kernel (kexec or forced
unload).

Would the comment hold if data[2] were cleared on its own first, or if
this first write kept the old address?

> +
> +		/* program full entry and set VALID */

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> new file mode 100644
> index 000000000000..c41cfa14f90f
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> @@ -0,0 +1,703 @@

[ ... ]

> +static int __nbl_res_intr_destroy_msix_map(struct nbl_resource_mgt *res_mgt,
> +					   u16 func_id)
> +{
> +	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
> +	int ret;
> +
> +	lockdep_assert_held(&intr_mgt->lock);
> +
> +	if (intr_mgt->stopping)
> +		return -ESHUTDOWN;
> +
> +	ret = __nbl_res_intr_prepare_destroy_msix_map(res_mgt, func_id);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * prepare() only transitions CONFIGURED functions; an IDLE func
> +	 * has nothing to wait for or complete.
> +	 */
> +	if (intr_mgt->func_intr_res[func_id].state !=
> +	    NBL_INTR_FUNC_DESTROYING)
> +		return 0;
> +
> +	usleep_range(NBL_MSIX_DMA_SYNC_MIN_US, NBL_MSIX_DMA_SYNC_MAX_US);
> +
> +	return __nbl_res_intr_complete_destroy_msix_map(res_mgt, func_id);

[Severity: Low]
Is a fixed 1ms sleep enough to guarantee that the pcompleter has stopped
fetching from the table before
__nbl_res_intr_complete_destroy_msix_map() calls dma_free_coherent() on
it?

The only ordering here is: clear FUNCTION_MSIX_MAP VALID, call
flush_write(), then call usleep_range(1000, 1200). Nothing polls a
hardware idle or completion status.

nbl_intr_mgt_stop() uses the same wait and calls it "Best-effort only".
The reconfig path in nbl_res_intr_cfg_msix_map() also relies on it before
recycling vectors and rewriting the live table.

If a table fetch is still in flight after the window, could it hit an
unmapped IOVA or reused memory? Is there a status register that could be
polled instead?

> +}
> +
> +int nbl_res_intr_destroy_msix_map(struct nbl_resource_mgt *res_mgt,
> +				  u16 func_id)
> +{
> +	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
> +	int ret;
> +
> +	if (!intr_mgt)
> +		return -EINVAL;
> +
> +	mutex_lock(&intr_mgt->lock);
> +	ret = __nbl_res_intr_destroy_msix_map(res_mgt, func_id);

[Severity: Low]
This reads res_mgt->intr_mgt without a lock and then locks the captured
object. __nbl_res_intr_destroy_msix_map() above does not use that
pointer; it loads res_mgt->intr_mgt again, then dereferences it for
lockdep_assert_held() and intr_mgt->stopping.
__nbl_res_intr_set_mailbox_irq() does the same, and its enable path
dereferences intr_mgt->stopping.

nbl_intr_mgt_stop() clears the pointer while it holds the mutex:

	res_mgt->intr_mgt = NULL;
	mutex_unlock(&intr_mgt->lock);

Suppose a caller was blocked on the mutex during stop's Phase 2. Wouldn't
it take the lock, read NULL in the helper, and dereference it?

And if a caller captured the pointer before nbl_res_remove_leonis()
returned, wouldn't it lock a mutex in devres-freed memory?

With the teardown ordering at the end of the series, no concurrent caller
seems possible. nbl_dev_remove() tears down the mailbox and cancels
clean_mbx_task before nbl_res_remove_leonis() runs, and device links
unbind sibling PFs first. The stop() comment does expect racing callers,
though.

Could the helpers take intr_mgt as a parameter from the locked caller?

> +	mutex_unlock(&intr_mgt->lock);
> +
> +	return ret;
> +}

[ ... ]

> +	/* Allocate net interrupt vectors */
> +	for (i = 0; i < num_net_msix; i++) {
> +		intr_index = find_first_zero_bit(intr_mgt->intr_net_bmap,
> +						 NBL_MAX_NET_INTERRUPT);
> +		if (intr_index == NBL_MAX_NET_INTERRUPT) {
> +			dev_err(dev, "No free net interrupt vectors left\n");
> +			ret = -EAGAIN;
> +			goto release_vecs_unlock;
> +		}

[Severity: Low]
On reconfiguration, the whole new vector set is taken from intr_net_bmap
and intr_other_bmap here while the function's old vectors are still set.
The old ones are only released later, in the had_config block:

		nbl_intr_release_bitmap(res_mgt, old_interrupts, old_num);

A reconfig therefore needs free room for the whole new request on top of
the old one. When the pool is nearly full, even a reconfig of the same
size or smaller fails with -EAGAIN, although the old config stays intact.

This follows from the "Only tear down old hardware state after new
allocation succeeds" design. In-tree callers at the end of the series ask
for one other vector per PF (nbl_dev_init_msix_cnt()), so they can't use
up the pool. Is this capacity limit intended?

[ ... ]

> +static struct nbl_interrupt_mgt *nbl_intr_setup_mgt(struct device *dev)
> +{
> +	struct nbl_interrupt_mgt *intr_mgt;
> +	int err;
> +
> +	intr_mgt = devm_kzalloc(dev, sizeof(*intr_mgt), GFP_KERNEL);
> +	if (!intr_mgt)
> +		return ERR_PTR(-ENOMEM);
> +
> +	err = devm_mutex_init(dev, &intr_mgt->lock);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	intr_mgt->stopping = false;
> +	bitmap_zero(intr_mgt->intr_net_bmap, NBL_MAX_NET_INTERRUPT);
> +	bitmap_zero(intr_mgt->intr_other_bmap, NBL_MAX_OTHER_INTERRUPT);

[Severity: Medium]
Only software state is reset here. Does anything clear the chip-internal
tables at init, namely NBL_PCOMPLETER_FUNCTION_MSIX_MAP,
NBL_PADPT_HOST_MSIX_INFO and NBL_PCOMPLETER_HOST_MSIX_FID_TABLE?

The comment above nbl_hw_set_mailbox_irq() says this chip state survives
kexec/forced unload without FLR. The pci_driver also has no .shutdown
callback.

After kexec or kdump, the old kernel's VALID map entries would still
point at DMA table addresses the new kernel no longer owns. INFO/FID
entries would also remain for gvecs that the new bitmaps treat as free.

nbl_intr_mgt_stop() only cleans functions whose software state is
CONFIGURED, so this stale state is never cleaned up.

On a fresh config (had_config == false), nbl_res_intr_cfg_msix_map() also
arms the new INFO/FID entries before it overwrites the map entry, which
may still be VALID from the old kernel:

	for (i = 0; i < requested; i++) {
		...
		hw_ops->cfg_msix_info(res_mgt->hw_ops_tbl->priv,
				      func_id, true, gvec, ...);
	}
	...
	hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
			     true, official_tbl->dma, ...);

That doesn't match the "not yet valid (on fresh config)" comment above
it.

Could the pcompleter then DMA-read a map table at an old-kernel address,
or route a stale map into gvecs that were just given to another function?

In this series, nbl_hw_cfg_mailbox_qinfo() disarms mailbox routing, so
whether this triggers depends on how the hardware fetches and on future
interrupt sources.

Would it make sense to invalidate these tables for all functions during
control-PF init, the same way the mailbox MSIX fields are scrubbed?

> +
> +	return intr_mgt;
> +}

[ ... ]

> +	/*
> +	 * Phase 1: batch invalidate all hardware MSIX map entries.
> +	 * stopping is set under the lock, so any caller racing with the
> +	 * quiesce window below either holds the lock and sees stopping
> +	 * at its next checkpoint, or acquires it after this phase and
> +	 * fails (-ESHUTDOWN/-EBUSY/-ENODEV) before issuing MMIO.
> +	 */
> +	mutex_lock(&intr_mgt->lock);
> +	intr_mgt->stopping = true;

[ ... ]

> +	mutex_unlock(&intr_mgt->lock);
> +
> +	/*
> +	 * Global quiesce: wait for straggler DMA table reads after all
> +	 * MSIX map entries have been invalidated in hardware, before
> +	 * freeing coherent memory. Best-effort only.
> +	 */
> +	usleep_range(NBL_MSIX_DMA_SYNC_MIN_US, NBL_MSIX_DMA_SYNC_MAX_US);
> +
> +	/* Phase2: safely release MSIX coherent memory and intr resources */
> +	mutex_lock(&intr_mgt->lock);

[ ... ]

> +	/* Clear the published pointer under the lock, last */
> +	res_mgt->intr_mgt = NULL;
> +	mutex_unlock(&intr_mgt->lock);
> +}

[Severity: Low]
Some comments here and in nbl_resource.h don't seem to match the code.

The enum nbl_intr_func_state comment says:

 * the hardware-DMA quiesce window of a teardown; the lock is held across
 * that window so a concurrent configuration cannot install a map that

However, nbl_intr_mgt_stop() drops the lock after Phase 1, sleeps, and
takes it again for Phase 2. In that window, correctness depends on the
stopping flag, which the comment doesn't mention.

The Phase 1 comment says racing callers fail with -ESHUTDOWN/-EBUSY/-ENODEV
"before issuing MMIO". But the en_msix=false branch of
__nbl_res_intr_set_mailbox_irq() runs before any stopping check:

	if (!en_msix) {
		hw_ops->set_mailbox_irq(res_mgt->hw_ops_tbl->priv,
					func_id, false, 0);
		hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
		return 0;
	}

So that branch writes NBL_MAILBOX_QINFO_MAP_REG_ARR and returns 0. After
stop completes, callers get -EINVAL, which the comment doesn't list
either.

"Clear the published pointer under the lock, last" suggests that readers
synchronize on intr_mgt->lock. Every public entry point reads
res_mgt->intr_mgt without holding it, though.

Could these comments be updated to describe the actual contract?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> index ae0a3d33198d..c14a78a47c98 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> @@ -17,6 +17,53 @@

[ ... ]

> +struct nbl_interrupt_mgt {
> +	struct mutex lock; /* Protects bitmap + func_intr_res[] */
> +	DECLARE_BITMAP(intr_net_bmap, NBL_MAX_NET_INTERRUPT);
> +	DECLARE_BITMAP(intr_other_bmap, NBL_MAX_OTHER_INTERRUPT);
> +	bool stopping; /* set on teardown, rejects new configurations */
> +	struct nbl_func_interrupt_resource_mng func_intr_res[NBL_MAX_FUNC];
> +};

[Severity: Low]
This isn't a bug, but func_intr_res[] is sized by NBL_MAX_FUNC
(NBL_MAX_PF + NBL_MAX_VF = 520). Each entry is about 48 bytes on 64-bit,
so struct nbl_interrupt_mgt comes to about 25 KB. That makes the
devm_kzalloc() in nbl_intr_setup_mgt() a physically contiguous order-3
allocation.

Only PF entries can ever be used. nbl_res_func_id_to_bdf() returns
-EOPNOTSUPP for rel_pf_id >= max_pf before func_intr_res[] is touched.
nbl_intr_mgt_stop() also walks all 520 entries twice.

Could this be sized by NBL_MAX_PF, or allocated with devm_kvzalloc()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928123237.88994-1-illusion.wang%40nebula-matrix.com
