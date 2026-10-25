Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792920266;
	b=5TMOIiYiL91Fhl0mRbIkfhAIWWlqifpnVq+8Uh2F/fSfaSLk73yfLa/jrrfEblo5VHPu
	 VFG6XtrXoPnVQ7wz4kIrvjGOrZtPfDCyEWZL6TMaSX7QcF95wUseLjFosjSrR/Ybb6FeI
	 8471L6rfPs/OAHi90FIxUp6D2B7yg/WvMADcciBAo9nJkcghSeRp60hD3PTiXD3t27Qt3
	 qhmXt9ZwFPonR1iUmp1a24JljgtihUc1JupauwWWtfNdCwj6wXYrG5CtxHdKabdLkpDwm
	 bc/jTPMJhkdzEifQWLpEwmIcjUzw9ikE7AWUIHaB2kS2cP+SFuaHLjvYctolUEpYIwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792920266;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mQkk6S7SJpaF5dKZiyzk1p0nrfAeW52DdMKc53u3N8M=;
	b=H5lpyWF3Ho33Mz9pfRRMwWQ9WSuCo2Y2qN5rSjaOqhAfZ0kl5hLYmm4NY7if01YoBpva
	 yqkTrqzDSWAVby7cZ+mPDagyhdVrbB9kuPq5ULyh9j4yEV8FiiIFhRXHzhgGbqLGlYcRU
	 YMUhP5RonFUn3OGuhKNtAFWX7NFhLdEA5NrKZeIjZ9Net9vtF9CPvN/mXadEhbA7dMlJb
	 3iX9FO2P5qJI5dfl43GyvV4v/eD7ZdfEAKm393oV3NKu/IBa87mZ0etDfDksII24jYeWs
	 fXoo1Kng8Xvg2n0pdQ7CdjPJxwNADulXo0xN1IdPZWqJ13f0dpeCdPd81dOe2Dc2VdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i9t/j2I8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465F606A320;
	Sun, 25 Oct 2026 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9t/j2I8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D020C1F01828;
	Sun, 25 Oct 2026 09:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792920265;
	bh=mQkk6S7SJpaF5dKZiyzk1p0nrfAeW52DdMKc53u3N8M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i9t/j2I8IlCMI7DY/WiOeZePRRzzF/9kysiqyjZyLQIMJ0d7TRKT0nG7bhsUiazFO
	 mke5GGBeFCPBvQR9iM7zjw933t7cDPKx5E5j14zisN3S9y0EcSWyqWvVXwZMFZmZYv
	 xfSx9M/1TIYEpuUYyUctQNNDpOnOsIXbkNGJjqnha+OHzRxKASdi94EBfV0rGbckT0
	 1plE1RHXD9ajmrZJxAYcmAOS++3rtP8C7SMQO+XrFIYNq0XeJa7nvdadPD/XrRh155
	 Cwe/5vXAG/HFpF1vfgKLQrgmWEO10fg0uVpVDZ0Vrnukzzty1cwLHe9lIvlt3WuCiB
	 hIERdnzIensLQ==
Subject: Re: [PATCH v32 net-next 3/8] net/nebula-matrix: add intr resource
 implementation
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 andrew+netdev@lunn.ch, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 09:24:24 +0000
Message-ID: <179292026443.3134.14659465471285693546@kernel.org>
In-Reply-To: <20261021062113.2158-4-illusion.wang@nebula-matrix.com>
References: <20261021062113.2158-4-illusion.wang@nebula-matrix.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Nothing waits for the device's in-flight MSI-X map table
  fetches to finish before the coherent tables are freed or their…
- [Medium] The new kexec/no-FLR scrub runs too late to do its job.
- [Low] The commit message overstates what the quiesce delay guarantees.
- [Low] The header comment of nbl_intr_mgt_stop()
  (nbl_interrupt.c:748-753) describes a caller that read the intr_mgt…
- [Low] Claimed use-after-free: a caller that read res_mgt->intr_mgt
  without the lock could lock a mutex that devres has already freed…

--

net/nebula-matrix: add intr resource implementation

This patch adds an nbl_interrupt module. The module manages the
chip-internal MSI-X vector index space and programs the MSI-X map, info
and FID tables from the control PF. It also adds the cfg_msix_map,
destroy_msix_map and set_mailbox_irq resource ops, plus a global teardown
in nbl_intr_mgt_stop() that waits a fixed ~1ms before freeing the
coherent tables.

> 1. cfg_msix_map: Allocate global hardware MSI-X vectors from the separate
>    net/other interrupt bitmaps.  Reuse the per-function coherent DMA map
>    table on reconfig, eliminating free/realloc cycles, DMA race windows
>    and redundant quiesce sleeps.  Only tear down the old hardware state

[ ... ]

> 2. destroy_msix_map: Recycle global vector indices, clear hardware MSI-X
>    mappings, and release DMA/descriptor resources.  Implements two-stage
>    teardown: disable mailbox IRQ routing first, mask vectors, clear
>    hardware VALID bits while retaining the live DMA addresses, wait ~1ms
>    for hardware DMA quiescence, then zero the table entries and free the
>    coherent memory to prevent torn reads.

[Severity: Low]
Do these descriptions match the code?

The comment above nbl_intr_quiesce_wait() says the chip exposes no
idle/completion status and that the window "is not a guarantee".
nbl_intr_mgt_stop() calls the same wait "Best-effort only". The ~1ms
wait makes the window smaller but does not close it.

The fresh configuration path of nbl_res_intr_cfg_msix_map() also still
does an extra invalidate, flush and quiesce sleep on every call:

    if (!had_config) {
        hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
                             false, 0, 0, 0, 0);
        hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
        nbl_intr_quiesce_wait();
    }

Its own comment calls this defensive, because nbl_intr_setup_mgt() has
already invalidated the entry.

Could the commit message be adjusted to match what the code does?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
> new file mode 100644
> index 0000000000000..379b19576fd80
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c

[ ... ]

> +static void nbl_intr_quiesce_wait(void)
> +{
> +	usleep_range(NBL_MSIX_DMA_SYNC_MIN_US, NBL_MSIX_DMA_SYNC_MAX_US);
> +}

[ ... ]

> +	/*
> +	 * Release the coherent table independently of interrupts so a
> +	 * partially built config (table allocated, vectors never
> +	 * published) cannot leak coherent DMA memory.
> +	 */
> +	if (msix_map_table->base_addr) {
> +		dma_free_coherent(dev, msix_map_table->size,
> +				  msix_map_table->base_addr,
> +				  msix_map_table->dma);

[Severity: Medium]
Could the device still be fetching this table when it is freed here?

The only fence between clearing VALID and this dma_free_coherent() is
the fixed usleep_range() in nbl_intr_quiesce_wait(), and the chip offers
no completion status. If a table fetch is still outstanding after
~1ms, does it end up reading freed or reused pages?

On removal, bus mastering is still enabled when the tables are freed:

nbl_remove()
  nbl_core_remove()
    nbl_res_remove_leonis()
      nbl_intr_mgt_stop()
        nbl_intr_quiesce_wait()
        __nbl_res_intr_complete_destroy_msix_map()
          dma_free_coherent()
  pci_clear_master()

The map entry is programmed with the control PF's BDF. Later in the
series, sibling PF maps are destroyed at runtime through mailbox RPC.
For those, pci_clear_master() on the sibling would not stop these
fetches either. nbl_dev.c later in the series calls this a known
limitation.

The reconfiguration path in nbl_res_intr_cfg_msix_map() relies on the
same timed wait before it recycles the old vectors and rewrites the
live table:

    nbl_intr_quiesce_wait();

    nbl_intr_release_bitmap(intr_mgt, res_mgt, old_interrupts,
                            old_num);

Can a late fetch there resolve to vectors that have already been given
to another function?

[ ... ]

> +	/*
> +	 * Invalidate any map entry left VALID by a previous kernel.  One
> +	 * flush plus one quiesce window covers the outstanding table
> +	 * fetches, same as the teardown paths do.
> +	 */
> +	for (func_id = 0; func_id < NBL_MAX_PF; func_id++)
> +		hw_ops->cfg_msix_map(res_mgt->hw_ops_tbl->priv, func_id,
> +				     false, 0, 0, 0, 0);
> +	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
> +	nbl_intr_quiesce_wait();

[Severity: Medium]
Does this scrub run early enough for the kexec case?

During kexec shutdown the PCI core clears bus mastering, which blocks
any fetch from a stale VALID entry. nbl_probe() turns bus mastering back
on before hw and channel init, but the stale entries are only cleared
here:

nbl_probe()
  pci_set_master()
  nbl_probe_chip_deps()
  nbl_core_init()
    nbl_hw_init_leonis()
    nbl_chan_init_common()
    nbl_res_init_leonis()
      nbl_res_start()
        nbl_intr_mgt_start()
          nbl_intr_setup_mgt()

In that window, could a FUNCTION_MSIX_MAP entry that is still VALID make
the pcompleter DMA-read an old-kernel table address that this kernel has
already reused?

The scrub is only MMIO writes. Could it run before pci_set_master()?

[ ... ]

> +/*
> + * nbl_intr_mgt_stop - global control-PF interrupt teardown
> + *

[ ... ]

> + * After this returns res_mgt->intr_mgt is NULL, so the public entry
> + * points report -EINVAL.  A caller that latched the pointer before that
> + * instead runs into the stopping latch: the config path and the enable
> + * path of nbl_res_intr_set_mailbox_irq() report -ESHUTDOWN, the latter
> + * reporting -ENODEV when the function was never configured, while the
> + * en_msix=false disable path returns 0 without consulting the latch.
> + */

[Severity: Low]
Can the enable path actually return -ENODEV here?

__nbl_res_intr_set_mailbox_irq() checks the latch before the state:

    if (intr_mgt->stopping)
        return -ESHUTDOWN;

    func_res = &intr_mgt->func_intr_res[func_id];
    if (func_res->state != NBL_INTR_FUNC_CONFIGURED) {
        ...
        return -ENODEV;
    }

So once stopping is set, the enable path always returns -ESHUTDOWN.

This comment and the one on nbl_resource_mgt::intr_mgt also leave out
nbl_res_intr_destroy_msix_map(). It returns -ESHUTDOWN after stop,
because __nbl_res_intr_destroy_msix_map() checks the latch first.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> index ae0a3d33198dc..e0f07922137c5 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h

[ ... ]

> @@ -56,14 +122,30 @@ struct nbl_resource_mgt {
>  	struct nbl_resource_info *resource_info;
>  	struct nbl_channel_ops_tbl *chan_ops_tbl;
>  	struct nbl_hw_ops_tbl *hw_ops_tbl;
> +	/*
> +	 * Published interrupt manager, control PF only.  The public entry
> +	 * points read this pointer without the manager lock (the object is
> +	 * devres-owned, so it outlives them) and then pass the value they
> +	 * read down to the internal helpers; nbl_intr_mgt_stop() clears it
> +	 * under the manager lock as its last step.  A caller that reads it
> +	 * after gets -EINVAL.  A caller that latched it before runs into the
> +	 * stopping latch instead: the config path and the mailbox-enable
> +	 * path report -ESHUTDOWN, while the mailbox-disable path
> +	 * (en_msix == false) returns 0 without consulting the latch.
> +	 */
> +	struct nbl_interrupt_mgt *intr_mgt;
>  };

[Severity: Low]
This isn't a bug, but is "devres-owned, so it outlives them" the right
reason here?

devres frees intr_mgt and its mutex once nbl_remove() returns. A caller
that had already read the pointer and was still running at that point
would lock freed memory, and the stopping latch would not help.

As far as I can tell, nothing in the final series can race this.
nbl_core_remove() runs nbl_dev_remove() before nbl_res_remove_leonis(),
and nbl_dev_remove() cancels clean_mbx_task and tears down the mailbox
channel. Sibling PFs are unbound first through the device link.

Would the comment be clearer if it said that removal ordering is what
keeps callers out?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021062113.2158-1-illusion.wang%40nebula-matrix.com
