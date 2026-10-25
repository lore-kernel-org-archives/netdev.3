Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792920265;
	b=jp/dpSopw3u6IdIWFVFsUVFXgrpuOeeELrnFxNKk2jt4OYM/VUwuRystkDAPALEx4btD
	 8JOgSh9u3ZzNcmCt7YvkSE4Cg75qEmCNbZXC4skjeEqY+sBKXppn77Cd2fCQ1wlAnfNu4
	 Vbt6UEgCOkDFoAsNAyfPy9YNyU+HUSfpIzmKcxXS60KmFdeJcksGBhzdhNFAkNqdVziLA
	 Twn2IwlkRQJtnSt1x0gh1v46qwpeOx5waku2DCRgSctsa3Cu2cyA/chlQKWYwzObPaeJ8
	 pD1mrg9DUJ0sfa/p/vPINkkwSH3ReGEx/DiHKo94oYIXymMfsZakeo0TqyI9msUQLXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792920265;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uEd53XtB1jlrRI9vXtLynTr645wbvU/7++6imUxBUR0=;
	b=yWdb7EDKbjCv1GJRk8AY3rDEF7W2RCIVNuoS8GHHEgACyJMDjOwqx6vR0gUEn24K045m
	 SGl6IQFIqUesP4by3xULb4tE8TlIkVxaimgdhilsVKl642nX63UE7RYa5nYRp8LVeu44s
	 opNE0xwvXiXDJxw35XULOoT18UH/zxYGBjkF23IvGQNXf3tD0hViUqOhggNkN6TS94itq
	 bhNfknIn4Yv9G3BtOqb16AobrbBrOztPI/FitSNkriOeqGfptlKZhOd8UslJRaQCVO/eH
	 rdJj88X4e1wUlXfH7K2OLDy9Dr4KMeGfqKg9NnVv+4S/8tiwcl3bn0pJWuNr+DKMscQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FOnSnYPa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9B7606A31A;
	Sun, 25 Oct 2026 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FOnSnYPa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A543F1F01825;
	Sun, 25 Oct 2026 09:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792920264;
	bh=uEd53XtB1jlrRI9vXtLynTr645wbvU/7++6imUxBUR0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FOnSnYPaLICL9e9cxdA1WgfBBckYoBG2JKE65VZg4nDrXBrT5lxcMc5Tnb3qSS5rD
	 tzG/3YNqLoNNYKqeHGlHr0x5DvzCVK0tcU93LLJW+yXS1Q1BoG3lE3umt61NSaw824
	 /MuaaFyIH+yeQwPRwYYDYoLzdBBV6N1DJ/Rdjiy3w+MYA5ELb2u3clZgxt4+yMYWMS
	 taTT3pbsXk7KtRrTBxlcp3FQS0xfNmYAWEFb0pol58TUghNXO0zz9al3lcmxIR6OMg
	 ZRdzkz2mR/DXFIEP5+LowiTAUFzW213YytkfgBaxshzl66r18HWqc7xRWeJY3SsjA+
	 l0YQGrsX7Owdw==
Subject: Re: [PATCH v32 net-next 1/8] net/nebula-matrix: add channel layer
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 andrew+netdev@lunn.ch, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 09:24:23 +0000
Message-ID: <179292026318.3134.1233768885583452270@kernel.org>
In-Reply-To: <20261021062113.2158-2-illusion.wang@nebula-matrix.com>
References: <20261021062113.2158-2-illusion.wang@nebula-matrix.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In nbl_probe_chip_deps(), a failed device_trylock(&mgt->dev)
  is turned into -EPROBE_DEFER, on the assumption that a later bind of…
- [Low] The comments in nbl_chan_cfg_qinfo_map_table() and the
  get_host_pf_mask kernel-doc say pf_mask is validated by…
- [Low] The commit message says 'a channel costs one devres node and one
  IOMMU mapping per ring', and the code comment in…

--

net/nebula-matrix: add channel layer

This adds a mailbox-based channel layer that carries control messages
between PF0 and the other PFs. It uses TX/RX rings backed by coherent
DMA, an xarray of message handlers and ACK wait slots. It also adds
nbl_probe_chip_deps(), which defers non-management PFs until function 0
is bound to this driver, and links each of them to function 0 with a
device link.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> new file mode 100644
> index 0000000000000..a4b1110134f83
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> @@ -0,0 +1,1522 @@

[ ... ]

> +static int nbl_chan_init_tx_queue(struct nbl_common_info *common,
> +				  struct nbl_chan_info *chan_info)
> +{
> +	struct nbl_chan_ring *txq = &chan_info->txq;
> +	struct device *dev = common->dev;
> +	dma_addr_t base_dma;
> +	size_t size =
> +		chan_info->num_txq_entries * sizeof(struct nbl_chan_tx_desc);
> +	void *base;
> +	u16 i;
> +
> +	txq->desc.tx_desc = dmam_alloc_coherent(dev, size, &txq->dma,
> +						GFP_KERNEL);
> +	if (!txq->desc.tx_desc)
> +		return -ENOMEM;
> +
> +	/*
> +	 * All per-entry buffers come from one contiguous coherent block, so a
> +	 * ring costs exactly one allocation, one devres node and one IOMMU
> +	 * mapping whatever the page size is.  Per-entry dmam_alloc_coherent()
> +	 * instead rounds every NBL_CHAN_BUF_LEN buffer up to a whole page
> +	 * (8 MiB per PF on 16 KiB pages, 32 MiB on 64 KiB pages), and a
> +	 * dma_pool only fixes the large-page case: with NBL_CHAN_BUF_LEN equal
> +	 * to PAGE_SIZE it still degenerates to one allocation per buffer on
> +	 * 4 KiB pages.  NBL_CHAN_BUF_LEN is a power of two, so the block
> +	 * always divides evenly into per-entry slots.
> +	 */
> +	base = dmam_alloc_coherent(dev,
> +				   chan_info->num_txq_entries *
> +				   chan_info->txq_buf_size,
> +				   &base_dma, GFP_KERNEL);
> +	if (!base)
> +		return -ENOMEM;
> +
> +	chan_info->wait = devm_kcalloc(dev, chan_info->num_txq_entries,
> +				       sizeof(*chan_info->wait), GFP_KERNEL);

[Severity: Low]
This isn't a bug, but is the "exactly one allocation, one devres node
and one IOMMU mapping" wording accurate for a ring?

This function calls dmam_alloc_coherent() twice, once for the descriptor
ring and once for the buffer block. It also makes devm_kcalloc() calls
for chan_info->wait and txq->buf. nbl_chan_init_rx_queue() likewise
makes two dmam_alloc_coherent() calls plus a devm_kcalloc() for
rxq->buf.

The commit message makes the same claim:

  Each ring uses one contiguous coherent DMA block sliced into
  fixed-size slots, so a channel costs one devres node and one IOMMU
  mapping per ring instead of one per slot.

Could both say that this only applies to the per-slot data buffers?

[ ... ]

> +static void nbl_chan_cfg_qinfo_map_table(struct nbl_channel_mgt *chan_mgt,
> +					 u8 bus, u8 devid)
> +{
> +	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
> +	struct nbl_hw_mgt *p = chan_mgt->hw_ops_tbl->priv;
> +	u32 pf_mask = 0;
> +	u8 func_id;
> +
> +	/*
> +	 * k_pf_mask rule: bit N == 0 means PF#N enabled, bit N == 1 masked out.
> +	 * Program mailbox QINFO entry for each hardware-active PF func_id.
> +	 *
> +	 * Note: This loop iterates over the raw hardware PF func_id.
> +	 * Product constraints limit supported PF counts to the contiguous
> +	 * sets PF0, PF0~1 and PF0~3.  The mask is validated by
> +	 * nbl_res_init_pf_num() in the resource layer, which runs before
> +	 * this call and rejects any other mask with -EINVAL, so pf_mask
> +	 * here is always one of 0xfe/0xfc/0xf0.
> +	 */

[Severity: Low]
This isn't a bug, but nbl_res_init_pf_num() and the resource layer do
not exist yet at this commit. They arrive later in the series. The
get_host_pf_mask kernel-doc added to nbl_def_hw.h makes the same
ordering claim.

cfg_chan_qinfo_map_table() has no caller here yet, and once the whole
series is applied the described ordering does hold. Could these
comments move into the patch that adds nbl_res_init_pf_num(), or be
reworded so they are accurate at this point in the series?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index f2552bc732937..bd29c5da8bc81 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

[ ... ]

> +	/*
> +	 * func 0's device lock is taken with a trylock.  This probe already
> +	 * runs under device_lock(funcN), so a blocking device_lock(func0)
> +	 * would establish the N -> 0 order, while __pci_bus_lock() (AER
> +	 * recovery, slot reset) walks the bus in devfn order, i.e. 0 -> N,
> +	 * and dev->mutex is lockdep_set_novalidate_class(), so lockdep
> +	 * cannot report that inversion.  A trylock never blocks, so it
> +	 * cannot take part in a deadlock cycle; failing it defers this
> +	 * probe.

[ ... ]

> +	if (!device_trylock(&mgt->dev)) {
> +		pci_dev_put(mgt);
> +		return -EPROBE_DEFER;
> +	}

[Severity: Medium]
Can a failed trylock here leave the sibling PF deferred with nothing to
retry it later?

When func 0 binds, really_probe()->driver_bound() runs with
device_lock(func0) held. device_links_driver_bound() puts the
AUTOPROBE consumer on the pending list. After that:

drivers/base/dd.c:driver_bound() {
    ...
	driver_deferred_probe_trigger();

	bus_notify(dev, BUS_NOTIFY_BOUND_DRIVER);
	kobject_uevent(&dev->kobj, KOBJ_BIND);
}

So deferred_probe_work_func() can re-probe funcN on another CPU while
func 0's lock is still held. The trylock then fails and funcN returns
-EPROBE_DEFER again.

driver_probe_device() only retriggers when deferred_trigger_count
changed during the probe:

	if (trigger_count != atomic_read(&deferred_trigger_count) &&
	    !defer_all_probes)
		driver_deferred_probe_trigger();

Here the increment happened before funcN's probe read trigger_count.
So nothing retriggers, and funcN stays on deferred_probe_pending_list.

Other holders of func 0's device lock that never bind a driver seem to
have the same effect. Examples are __pci_bus_lock() during AER recovery
or a bus/slot reset, a reset through sysfs, or a write to
sriov_numvfs. No bind event follows any of these.

In both cases the sibling PF and its ports stay unbound until some
unrelated driver binds elsewhere in the system. Doesn't that break the
"re-probes them when function 0 binds again" behaviour described in the
commit message?

> +
> +	/*
> +	 * The management PF must be bound to *this* driver, with its probe
> +	 * completed.  links.status == DL_DEV_DRIVER_BOUND alone only says
> +	 * "bound to some driver", so func 0 on vfio-pci or pci-stub
> +	 * (driver_override) would pass it and this PF would run with func
> +	 * 0's chip-global init never performed.  pdev->dev.driver is our
> +	 * own driver, set by the core before ->probe() is called.
> +	 *
> +	 * Deferring is enough to recover: a successful bind re-triggers
> +	 * deferred probing for every pending device (driver_bound() ->
> +	 * driver_deferred_probe_trigger()), so this PF is retried once func
> +	 * 0 is bound to this driver.
> +	 */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021062113.2158-1-illusion.wang%40nebula-matrix.com
