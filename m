Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763ABDF6C;
	Mon,  5 Oct 2026 03:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791172302; cv=none; b=GH6Fv5oPlUNKImKupGRnNoEi0uhDlEUxRSQXuRH9BI4LQpSzkMWooeGYkcC+/TsLju2x00KF6JjkcKnNeMU1LLkGiGHejKPhBAyN/aD4xwYZNhgMxYm8nRuiGI+bLH+L5oYJuC89Ec0NjK1h+JtJqN8Qk9dcixFHLdGpjDqPBdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791172302; c=relaxed/simple;
	bh=bf1aRCeVOwWnbmRdaY5vsTLCgnMOWWccKEP0pg9zfFQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FSs/cyNqlIfrqWM6iB1bDPEKBapd/6dwQF7t7x+YBXgDpAjJAUxaxK+i5oOpiGH4fEcMXA7KVBmXaaVDAa8kHELKsZumgrNmEcbs6LotyVnWJUvBYm0MS5B1Uswaybj/cxGgcoyUHUqJKK4nsHW5yY84Nq2OkZ9EjB3QeoFq8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOxHhNpP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOxHhNpP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32D21F000FF;
	Mon,  5 Oct 2026 03:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791172300;
	bh=vqHFN4ISiMdgIpZ/Kf7RvQ7eEXbPG4qoMDh7E7PTK1w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VOxHhNpPvliznv4/nIwNI+abH5xjSzEgtm+crm8CyFKX56ra1pf0yWzSo7z5grKIA
	 zP42Lo0pMzglzbCO1f/oQmRBXKbfoGQ8EA1cl0drJVIQMVTlzynWZ/44eyjtu0+YD7
	 WhbgQ2s5MoYxDiOJ/ej9JnqxZvZc+clvmVvmQ8lgg3q9XDXwZN6V+UXuSQIqjN4uH5
	 EPTSLfIRBQGsD1vdl6iAdelz3yr3G957cECLlfHKXeN9xqYgQOxM0au1fD3M7cvCJi
	 CprFrflKJ+a3JzyAefrFcwPJWsu2Gb6pp9A9meJhRExJzAALCx/cbrHR9PzCCsG5GE
	 8igKuoHifXtqA==
Subject: Re: [PATCH net v4] net: stmmac: fix error path cleanup in DMA
 descriptor ring allocation
From: netdev-bot+sashiko@kernel.org
To: dinghui1111@163.com
Cc: netdev-bot+sashiko@kernel.org, maxime.chevallier@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dinghui@lixiang.com, xiasanbo@lixiang.com, yangchen11@lixiang.com,
 liuxuanjun@lixiang.com
Date: Mon, 05 Oct 2026 03:51:38 +0000
Message-ID: <179117229846.434549.8891935731909166889@kernel.org>
In-Reply-To: <20261001035045.3305816-1-dinghui1111@163.com>
References: <20261001035045.3305816-1-dinghui1111@163.com>
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
issue(s) to consider.

Critical: 0 · High: 0 (4) · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch's new 'freed pointers are NULL' invariant is only
  written into the dma_conf object passed to…
- [Medium] stmmac_rings_status_show() takes no lock (no rtnl, no
  priv->lock).
- [Low] The commit describes and fixes real, user-visible defects but has
  no Fixes: trailer.
- [Low] The commit message says the stmmac_rings_status_show() change
  keeps 'the rings sysfs entry' from dereferencing a NULL pointer.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  stmmac_enable_rx_queue() and stmmac_enable_tx_queue()…
- [High] This problem wasn't introduced by this patch, but
  stmmac_xdp_set_prog() (stmmac_xdp.c:134-140) calls…
- [High] This problem wasn't introduced by this patch, but after a failed
  stmmac_xdp_open() inside stmmac_xdp_set_prog() (return value ignored),…
- [High] This problem wasn't introduced by this patch, but in
  stmmac_xdp_open() the irq_error path runs after the MAC RX/TX has been…

--

net: stmmac: fix error path cleanup in DMA descriptor ring allocation

This patch makes __alloc_dma_rx_desc_resources() and
__alloc_dma_tx_desc_resources() undo their own allocations on failure. It
also adds NULL checks in the RX/TX buffer free helpers and clears the freed
pointers in __free_dma_{rx,tx}_desc_resources(). Finally, it frees the RX
resources when the TX allocation fails in alloc_dma_desc_resources(), and
skips unallocated rings in stmmac_rings_status_show().

> And skip queues whose descriptor rings are not allocated
> in stmmac_rings_status_show() so reading the rings sysfs entry will
> never dereference a NULL pointer.

[Severity: Low]
This isn't a bug, but stmmac_rings_status_show() backs a debugfs file, not
a sysfs entry:

stmmac_init_fs() {
    ...
	debugfs_create_file("descriptors_status", 0444, priv->dbgfs_dir, dev,
			    &stmmac_rings_status_fops);
    ...
}

Could the commit message also explain how the rings end up unallocated
while IFF_UP is set? As far as I can tell, this only happens after one of
two ignored failures:

  - stmmac_xdp_open() failing inside stmmac_xdp_set_prog()
  - a per-queue re-allocation failing in stmmac_enable_rx_queue() or
    stmmac_enable_tx_queue()

In both cases the guard hides the symptom of a half-torn-down interface.

> Signed-off-by: Ding Hui <dinghui@lixiang.com>

[Severity: Low]
Should this have Fixes: tags? The patch fixes two separate problems:

  - a NULL dereference of rx_q->buf_pool[i] or tx_q->tx_skbuff_dma[i] in
    dma_free_rx_skbufs() and dma_free_tx_skbufs() after a failed
    kzalloc_objs()
  - a leak of the RX page_pools, buf_pools and coherent rings when
    alloc_dma_tx_desc_resources() fails

Before this patch, stmmac_setup_dma_desc() only did kfree(dma_conf) under
alloc_error, and the dma_desc_error label in stmmac_xdp_open() just
returns.

These problems seem to come from different commits, so more than one
Fixes: tag may be needed for net and stable backports.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index ec62fa7418f41..07176750a0c48 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -2161,13 +2173,20 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
>  	size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
>  
>  	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
> +	rx_q->dma_erx = NULL;
> +	rx_q->dma_rx = NULL;
> +	rx_q->dma_rx_phy = 0;

[Severity: Medium]
Do these NULL stores ever reach priv->dma_conf on the __stmmac_open()
failure paths?

__stmmac_open() copies the heap dma_conf into priv->dma_conf before the
steps that can fail:

__stmmac_open() {
    ...
	memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));
    ...
}

If stmmac_hw_setup() or stmmac_request_irq() fails after that, the callers
free the temporary copy and not priv->dma_conf:

stmmac_change_mtu() {
    ...
		ret = __stmmac_open(dev, dma_conf);
		if (ret) {
			free_dma_desc_resources(priv, dma_conf);
			kfree(dma_conf);
    ...
}

stmmac_open() follows the same pattern under err_dma_resources.

So the new NULL stores to dma_rx, buf_pool, page_pool, tx_skbuff and
tx_skbuff_dma all land in memory that is kfree()d right away. Meanwhile
priv->dma_conf keeps non-NULL pointers to the freed coherent rings and
arrays.

After a failed MTU change the netdev stays IFF_UP. The new
"if (!rx_q->dma_rx)" guards in stmmac_rings_status_show() then pass, and
sysfs_display_ring() reads memory that was already released with
dma_free_coherent().

The commit message says clearing the pointers makes "the NULL guards in
the free helpers hold reliably when the long-lived priv->dma_conf is
reused". Does that invariant actually hold for priv->dma_conf on these
paths?

The aliasing itself predates this patch. Also, after this failure, a later
"ip link set down" makes __stmmac_release() call napi_disable() on NAPI
instances that are already disabled. That spins under the rtnl lock, so a
second free_dma_desc_resources() on priv->dma_conf is not reached on that
path.

[ ... ]

> @@ -2209,9 +2228,16 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
>  	size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
>  
>  	dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
> +	tx_q->dma_etx = NULL;
> +	tx_q->dma_entx = NULL;
> +	tx_q->dma_tx = NULL;
> +	tx_q->dma_tx_phy = 0;

[Severity: High]
This is a pre-existing issue, but is the hardware still pointed at these
rings when they are freed on the stmmac_xdp_open() error path?

stmmac_xdp_open() {
    ...
	stmmac_mac_set(priv, priv->ioaddr, true);

	/* Start Rx & Tx DMA Channels */
	stmmac_start_all_dma(priv);

	ret = stmmac_request_irq(dev);
	if (ret)
		goto irq_error;
    ...
irq_error:
	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);

init_error:
	free_dma_desc_resources(priv, &priv->dma_conf);
    ...
}

If stmmac_request_irq() fails, the rings are freed with dma_free_coherent()
and the RX pages go back to the page pool. Unlike stmmac_xdp_release(),
this path never calls stmmac_stop_all_dma() or
stmmac_mac_set(..., false).

Can the DMA engine keep fetching descriptors from freed memory and writing
received frames into freed pages?

__stmmac_open() looks similar. stmmac_hw_setup() enables the MAC and starts
DMA, and the irq_error/init_error path leaves both running before the
caller frees the rings.

Setting dma_rx_phy and dma_tx_phy to 0 makes the software state look
clean, but the channel registers still hold the old bus addresses.

[ ... ]

> @@ -2298,10 +2328,22 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
>  	ret = xdp_rxq_info_reg(&rx_q->xdp_rxq, priv->dev, queue, napi_id);
>  	if (ret) {
>  		netdev_err(priv->dev, "Failed to register xdp rxq info\n");
> -		return -EINVAL;
> +		goto err_free_dma;
>  	}
>  
>  	return 0;
> +
> +err_free_dma:
> +	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
> +	rx_q->dma_erx = NULL;
> +	rx_q->dma_rx = NULL;
> +err_free_buf_pool:
> +	kfree(rx_q->buf_pool);
> +	rx_q->buf_pool = NULL;
> +err_destroy_pool:
> +	page_pool_destroy(rx_q->page_pool);
> +	rx_q->page_pool = NULL;
> +	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but what happens on the XSK
pool enable path when this unwind runs?

stmmac_enable_rx_queue() and stmmac_enable_tx_queue() return void and only
log the failure:

stmmac_enable_rx_queue() {
    ...
	ret = __alloc_dma_rx_desc_resources(priv, &priv->dma_conf, queue);
	if (ret) {
		netdev_err(priv->dev, "Failed to alloc RX desc.\n");
		return;
	}
    ...
}

stmmac_xdp_enable_pool() then carries on regardless:

	if (need_update) {
		stmmac_enable_rx_queue(priv, queue);
		stmmac_enable_tx_queue(priv, queue);
		napi_enable(&ch->rxtx_napi);

		err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);

With this patch, the earlier stmmac_disable_rx_queue() and the new unwind
leave rx_q->dma_rx, dma_erx and buf_pool NULL, and tx_q->dma_tx and
tx_skbuff_dma NULL as well.

The rxtx NAPI can still be scheduled, either by stmmac_xsk_wakeup() (which
is also ndo_xsk_wakeup) or by a TX DMA IRQ. Could that reach
stmmac_napi_poll_rxtx()->stmmac_rx_zc(), which uses &rx_q->buf_pool[entry]
and stmmac_get_rx_desc() on the NULL ring?

stmmac_xdp_disable_pool() also re-enables rx_napi and tx_napi after an
enable that may have failed.

Before this patch the same path was a use-after-free of the freed ring,
and the hardware channel still points at that freed ring.

[ ... ]

> @@ -2413,6 +2463,8 @@ static int alloc_dma_desc_resources(struct stmmac_priv *priv,
>  		return ret;
>  
>  	ret = alloc_dma_tx_desc_resources(priv, dma_conf);
> +	if (ret)
> +		free_dma_rx_desc_resources(priv, dma_conf);
>  
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but stmmac_xdp_open() is one of the callers
of alloc_dma_desc_resources(), and stmmac_xdp_set_prog() ignores its
failure:

stmmac_xdp_set_prog() {
    ...
	if (if_running && need_update)
		stmmac_xdp_open(dev);

	if (prog)
		xdp_features_set_redirect_target(dev, false);

	return 0;
}

By this point stmmac_xdp_release() has disabled all NAPI instances, freed
the IRQs, stopped DMA and freed the rings.

stmmac_xdp_open() can fail in alloc_dma_desc_resources(),
init_dma_desc_rings() or stmmac_request_irq(). If it does, userspace still
gets success. The netdev stays IFF_UP with NAPI disabled, no IRQs, and
(with this patch) NULL ring pointers.

Would the next ndo_stop or XDP toggle then call napi_disable() on an
already-disabled NAPI through stmmac_disable_all_queues()?

napi_disable_locked() waits for NAPIF_STATE_SCHED to clear, which only
happens on napi_enable(). That looks like a hang while holding the
rtnl/netdev lock. stmmac_free_irq() would also run a second time.

[Severity: High]
This is a pre-existing issue, but after the failed stmmac_xdp_open()
described above, the device is still advertised as an XDP redirect
target. xdp_features_set_redirect_target() runs whenever prog is set,
even if the reopen failed.

stmmac_xdp_xmit() is only gated on STMMAC_DOWN, and neither
stmmac_xdp_release() nor the failed open sets that bit:

stmmac_xdp_xmit() {
    ...
	if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
		return -ENETDOWN;
    ...
}

Can a devmap or bpf_redirect from another interface then reach
stmmac_xdp_xmit_xdpf()? That function:

  - computes tx_desc with stmmac_get_tx_desc()
  - writes tx_q->tx_skbuff_dma[entry] through stmmac_set_tx_dma_entry()
  - stores tx_q->xdpf[entry] = xdpf

With this patch these become NULL-pointer writes. Before it, they were
writes into freed memory.

[ ... ]

> @@ -6570,10 +6622,20 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
>  		seq_printf(seq, "RX Queue %d:\n", queue);
>  
>  		if (priv->extend_desc) {
> +			if (!rx_q->dma_erx) {
> +				seq_puts(seq, "Extended descriptor ring not allocated\n");
> +				continue;
> +			}
> +
>  			seq_printf(seq, "Extended descriptor ring:\n");
>  			sysfs_display_ring((void *)rx_q->dma_erx,
>  					   priv->dma_conf.dma_rx_size, 1, seq, rx_q->dma_rx_phy);

[Severity: Medium]
Is this check enough without any locking against the teardown paths?

stmmac_rings_status_show() takes neither rtnl nor priv->lock. It loads the
pointer for the NULL test, calls seq_printf(), and then loads the field
again for sysfs_display_ring().

Several teardown paths free the rings under rtnl only:

  - ndo_stop (IFF_UP is cleared only after ndo_stop returns)
  - stmmac_xdp_release() (IFF_UP stays set)
  - MTU and ring size changes
  - XSK queue disable

With this patch, __free_dma_rx_desc_resources() now does:

	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
	rx_q->dma_erx = NULL;
	rx_q->dma_rx = NULL;

A reader that already passed the check can then pass NULL to
sysfs_display_ring() with dma_rx_size > 0 and dereference p->des0. If the
second load happens before the NULL store, it reads freed coherent memory
instead.

The use-after-free read predates this patch. The NULL dereference does
not, and it contradicts the commit message claim that reading the entry
"will never dereference a NULL pointer". The same pattern applies to the
dma_rx branch and to both TX branches.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001035045.3305816-1-dinghui1111%40163.com
