Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5619053F69D;
	Tue, 22 Sep 2026 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079286; cv=none; b=PlSq+tOHUwoc58nHR+o1sOW3e5hxt6QGUPrzbY8hPxOLXj4H4QmUCGWYX3Y4X5wbIFpa7Xdc+ZyvOYs9Za9cf9yOkOpfi50mG3HJpAx8pJw/tdOcoa8WWw6zcf14XxgrcVXoUrRe7zaComedXwSsXF2CE/1B0us1C0UYdcb91Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079286; c=relaxed/simple;
	bh=Q7RiFhoGRbySHqvPSFYPUcALqzImlYeZVtCbskrh94g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JhPWA+DID9UJsI2cq84TDO2pGr+IaPF2OGgzeHyXlnTBhMsiiB9GZNEgGh3gJNiYjziqJspDEjtisVZQYn7OOfTE/TY4WeTJ5ILVBTfjj0/kbdQupioYvD/p/rWyEUVN1LdzTMDi10BgGaOmTQr3xWWP+bkcgcM8k54DXl7Gg0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAOTTa7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAOTTa7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AAB1F000FF;
	Tue, 22 Sep 2026 12:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790079283;
	bh=Zp2Dvto/hyY43E31Wtx7fAoFERGAPqmmPJqfwSGA8eA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YAOTTa7NAgXD7hgyPo3+uIGZwF11sidibspvv/zqvcyQFHQm7tv/MrN+yfgb9ZAsh
	 b1H9ivsFhDV2EsPLx15WHEtfAboroYCl4kFkKp1s4AnLg93xqmanBGV/YeyRV8DX3f
	 Mx66QemYm1Vmhy735nrBmicxVAWNfIVIXWcp5iVYSBnyZB0sPo61Dc1/uSds9zqcFp
	 zNT7Vw9raLYLBGJYoIe9OxH+U3RvdCOQCN4SlfpI2W3/K/gAYJ7jsdp3HXkxLBD4p/
	 nN/TPSypSy2wrm8SfNd1vDCAyfkdtF0BKiTAW4+lxnumJYtIRcxcsW7Oew4kj4gWvR
	 D4UIPeh4rCM7w==
Subject: Re: [PATCH net-next v3] net: stmmac: fix error path cleanup in DMA
 descriptor ring allocation
From: netdev-bot+sashiko@kernel.org
To: dinghui1111@163.com
Cc: lorenzo.bianconi@oss.qualcomm.com, netdev-bot+sashiko@kernel.org,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dinghui@lixiang.com, xiasanbo@lixiang.com, yangchen11@lixiang.com,
 liuxuanjun@lixiang.com
Date: Tue, 22 Sep 2026 12:14:42 +0000
Message-ID: <179007928254.2160803.9473310468138142059@kernel.org>
In-Reply-To: <20260919121436.1642724-1-dinghui1111@163.com>
References: <20260919121436.1642724-1-dinghui1111@163.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] alloc_dma_desc_resources() still returns a TX allocation
  failure without undoing the RX allocations it made immediately before,…
- [Medium] The patch newly publishes NULL into rx_q->dma_erx/rx_q->dma_rx
  and tx_q->dma_etx/dma_entx/dma_tx of the long-lived priv->dma_conf,…
- [Low] The patch fixes crash-class bugs (NULL dereference on the
  allocation-failure unwind path, and a double-free/use-after-free of…

Pre-existing issues:
- [High] stmmac_enable_rx_queue() and stmmac_enable_tx_queue() are void
  and only netdev_err() when __alloc_dma_{rx,tx}_desc_resources() fails,…
- [High] __free_dma_tx_desc_resources() now clears tx_q->tx_skbuff_dma,
  tx_q->tx_skbuff/xdpf, tx_q->dma_tx/dma_etx/dma_entx and…

--

net: stmmac: fix error path cleanup in DMA descriptor ring allocation

This makes __alloc_dma_rx_desc_resources() and
__alloc_dma_tx_desc_resources() unwind their own allocations on failure
instead of leaving partially-initialized queues for the outer free
helpers, adds NULL guards in dma_free_rx_skbufs(), dma_free_rx_xskbufs(),
dma_free_tx_skbufs() and stmmac_free_tx_buffer(), and clears the freed
pointers in __free_dma_rx_desc_resources() and
__free_dma_tx_desc_resources().

Link: https://lore.kernel.org/netdev/20260905154654.1725313-1-dinghui1111@163.com/
Link: https://lore.kernel.org/netdev/20260830040610.1156008-1-dinghui1111@163.com/

> Signed-off-by: Ding Hui <dinghui@lixiang.com>

[Severity: Low]
The trailers only carry Signed-off-by.  Should this have a Fixes: tag?

The bugs being fixed are crash-class: the NULL dereference reached from
alloc_dma_rx_desc_resources() -> err_dma -> free_dma_rx_desc_resources(),
which iterates every queue including the one whose kzalloc_objs() just
failed, and the stale buf_pool/page_pool reuse across XDP open/release.

Two introducing commits look identifiable: the union xdpf/tx_skbuff
dereference in stmmac_free_tx_buffer() came in with the XDP_TX support,
and the per-queue buf_pool/page_pool teardown with the refactor that
introduced __alloc_dma_{rx,tx}_desc_resources() and
__free_dma_{rx,tx}_desc_resources().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index bf9e7e4cb1c3..32394a5a83fc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -2185,13 +2197,20 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
>  	size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
>  
>  	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
> +	rx_q->dma_erx = NULL;
> +	rx_q->dma_rx = NULL;
> +	rx_q->dma_rx_phy = 0;

[Severity: Medium]
Does publishing NULL into the long-lived priv->dma_conf ring pointers need
a matching check in the debugfs reader?

stmmac_rings_status_show() only bails out on the interface being down:

	if ((dev->flags & IFF_UP) == 0)
		return 0;

and then hands rx_q->dma_rx / rx_q->dma_erx (and the TX equivalents)
straight to sysfs_display_ring(), which dereferences the descriptors in a
loop with no head check:

	for (i = 0; i < size; i++) {
		dma_addr = dma_phy_addr + i * desc_size;
		seq_printf(seq, "%d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
				i, &dma_addr,
				le32_to_cpu(p->des0), le32_to_cpu(p->des1),

dma_rx_size / dma_tx_size are not cleared, so the loop still runs.

The free helpers run with the interface up: stmmac_xdp_enable_pool() does
napi_disable() then stmmac_disable_rx_queue()/stmmac_disable_tx_queue()
while netif_running() is true, and IFF_UP is never cleared.  If the
following stmmac_enable_rx_queue() allocation then fails, the NULL stays
there indefinitely.

Reading descriptors_status in that window looks like it faults now, where
before the patch it read freed coherent memory.

>  
>  	if (xdp_rxq_info_is_reg(&rx_q->xdp_rxq))
>  		xdp_rxq_info_unreg(&rx_q->xdp_rxq);
>  
>  	kfree(rx_q->buf_pool);
> -	if (rx_q->page_pool)
> +	rx_q->buf_pool = NULL;
> +
> +	if (rx_q->page_pool) {
>  		page_pool_destroy(rx_q->page_pool);
> +		rx_q->page_pool = NULL;
> +	}
>  }
>  
>  static void free_dma_rx_desc_resources(struct stmmac_priv *priv,
> @@ -2233,9 +2252,16 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
>  	size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
>  
>  	dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
> +	tx_q->dma_etx = NULL;
> +	tx_q->dma_entx = NULL;
> +	tx_q->dma_tx = NULL;
> +	tx_q->dma_tx_phy = 0;
>  
>  	kfree(tx_q->tx_skbuff_dma);
> +	tx_q->tx_skbuff_dma = NULL;
> +
>  	kfree(tx_q->tx_skbuff);
> +	tx_q->tx_skbuff = NULL;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but are these stores
synchronized against a concurrent transmit?

One caller, stmmac_disable_tx_queue() (AF_XDP pool enable/disable), takes
&ch->lock only around stmmac_disable_dma_irq(), drops it, then:

	stmmac_stop_tx_dma(priv, queue);
	__free_dma_tx_desc_resources(priv, &priv->dma_conf, queue);

There is no netif_tx_stop_queue() and no __netif_tx_lock.  Its caller only
quiesces NAPI:

	need_update = netif_running(priv->dev) && stmmac_xdp_is_enabled(priv);

	if (need_update) {
		napi_disable(&ch->rx_napi);
		napi_disable(&ch->tx_napi);
		stmmac_disable_rx_queue(priv, queue);
		stmmac_disable_tx_queue(priv, queue);

stmmac_xmit()/stmmac_xdp_xmit()/stmmac_tx_clean() read tx_skbuff_dma,
tx_skbuff/xdpf and dma_tx/dma_etx/dma_entx under __netif_tx_lock only, and
stmmac_set_tx_dma_entry() writes tx_q->tx_skbuff_dma[entry] with no NULL
test.  The locksets do not intersect and napi_disable() does not stop
ndo_start_xmit.

The driver's own convention elsewhere stops the queue first:

	netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, chan));

	stmmac_stop_tx_dma(priv, chan);
	dma_free_tx_skbufs(priv, &priv->dma_conf, chan);

Would the new NULL stores turn the existing dangling-pointer window into a
deterministic NULL dereference, and should transmit be fenced before
publishing them?

>  
>  static void free_dma_tx_desc_resources(struct stmmac_priv *priv,

[ ... ]

> @@ -2327,10 +2357,22 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
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
This isn't a bug introduced by this patch, but with the queue now
guaranteed to be all-NULL after a failure, what protects the fast path
when stmmac_enable_rx_queue()/stmmac_enable_tx_queue() swallow the error?

Both helpers are void and just log:

	ret = __alloc_dma_rx_desc_resources(priv, &priv->dma_conf, queue);
	if (ret) {
		netdev_err(priv->dev, "Failed to alloc RX desc.\n");
		return;
	}

	ret = __alloc_dma_tx_desc_resources(priv, &priv->dma_conf, queue);
	if (ret) {
		netdev_err(priv->dev, "Failed to alloc TX desc.\n");
		return;
	}

stmmac_xdp_enable_pool() and stmmac_xdp_disable_pool() cannot see that, so
they continue:

		stmmac_enable_rx_queue(priv, queue);
		stmmac_enable_tx_queue(priv, queue);
		napi_enable(&ch->rxtx_napi);

		err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);

and return 0 with the netdev TX queue never stopped.  Since the peer
queue's init did set an xsk_pool, stmmac_xsk_wakeup()'s

	if (!rx_q->xsk_pool && !tx_q->xsk_pool)
		return -EINVAL;

check passes and a poll is scheduled on the half-initialized channel.

stmmac_set_tx_dma_entry() then writes into a NULL tx_skbuff_dma:

	tx_q->tx_skbuff_dma[entry].buf = addr;
	tx_q->tx_skbuff_dma[entry].len = len;
	tx_q->tx_skbuff_dma[entry].buf_type = type;

and stmmac_rx_zc()/stmmac_tx_clean() hit the same pattern on the RX side.

Should the enable helpers propagate the allocation error and keep the
queue stopped until it is successfully re-armed?

> @@ -2400,6 +2442,14 @@ static int __alloc_dma_tx_desc_resources(struct stmmac_priv *priv,
>  		tx_q->dma_tx = addr;
>  
>  	return 0;
> +
> +err_free_skbuff:
> +	kfree(tx_q->tx_skbuff);
> +	tx_q->tx_skbuff = NULL;
> +err_free_skbuff_dma:
> +	kfree(tx_q->tx_skbuff_dma);
> +	tx_q->tx_skbuff_dma = NULL;
> +	return -ENOMEM;
>  }

[Severity: Medium]
The commit message states the fix is "making each allocation function
responsible for undoing its own allocations on error".  Does
alloc_dma_desc_resources() still miss that rule?

	/* RX Allocation */
	int ret = alloc_dma_rx_desc_resources(priv, dma_conf);

	if (ret)
		return ret;

	ret = alloc_dma_tx_desc_resources(priv, dma_conf);

	return ret;

On TX failure the RX side it just allocated is not undone, and the caller
skips the free:

stmmac_setup_dma_desc():
	init_error:
		free_dma_desc_resources(priv, dma_conf);
	alloc_error:
		kfree(dma_conf);
		return ERR_PTR(ret);

The allocation failure lands on alloc_error, so every RX queue's
page_pool, buf_pool, registered xdp_rxq_info and dma_alloc_coherent()
ring is leaked with the only pointers to them inside the kfree()d
dma_conf.

stmmac_xdp_open() has the same shape:

	init_error:
		free_dma_desc_resources(priv, &priv->dma_conf);
	dma_desc_error:
		return ret;

Here the RX half of the long-lived priv->dma_conf stays populated and a
later open overwrites those pointers.  Should the RX resources be freed
when alloc_dma_tx_desc_resources() fails?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919121436.1642724-1-dinghui1111%40163.com
