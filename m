Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312496;
	b=1bv9MWsLsKV2+IvNl++KH91Ft04CaygSgvJNpFsDq1hNth3upSI+o63XFIxEqVpbojCk
	 GKuvkWLAneNIeKWqv7MbzOT7qah61ionCEqnnJbmO9dTz+wWKKmR2uQIEULfHpvGdLjrJ
	 N4mpOkxQMN1Xt6rCT0rp0gHT7EV8QOeBLtsaEvSAEbjaIjDmKZ6WDTByyOuFucJoGExrT
	 cXfcaGQscJy/FfhNIY1eN5VYjX1mKXvwn+36Lpd3ueLENWc+DCHHSpb3MmonMyWwd5LvT
	 aCyt8VFUnrhyeJvBTo5lDKOqwW/KQb6+3Q/6dsJUDhXPtCS4bfrW0IsoYWOMT+26mEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312496;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BuKIQPz/oLiMZvm7vo+pet8mf+UKQMzhnaHi2cUDtcA=;
	b=EFKk/kXNM6gecnW07vBtAJ5vi3+F1LSHQXmHLdTQJC+Gj0xl/wgwFV7V/YfgxfoRj/7/
	 pS/ApVivhuzC7M+Eu18hJzO82vuIkEu/lC7J0lL7in+AJVSl1QsilaLWOr/nlTS611HVq
	 GbiCbferoFdF9m/GDQbp3n568r+VNtNSxuAoMpkSiyjhAK+Q85SgN48SFvz4t4E7VgpiU
	 i8SfUleJ7AWym7pPO+s38kYPBu6eFro72OpOU7U8BSAFk6axFH37ECT6yy1pdO2JLcEma
	 1O5Yn2VXsofsYHuz0RGjp/KMMRRPZXYb/qj1ktG2yXG90ewdcjB+nYCrYSAdg/Vk7ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9mRVLj4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F2606A332;
	Tue, 10 Nov 2026 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9mRVLj4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6631F008A1;
	Tue, 10 Nov 2026 12:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312495;
	bh=BuKIQPz/oLiMZvm7vo+pet8mf+UKQMzhnaHi2cUDtcA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=W9mRVLj40IqcFD2Zw5kHM7ZBz4hJA/SBXANBg2rIuCdARdAVqmWz6/V1nFFazUzAc
	 z5CgNRA+ko09oIg1YlTpRdakeIfin9ef1ZcbLYeEgHT3IXwxPbOVUaVflDuC0VipXj
	 f3Ry5WcbQsY5kVsggn4fEubbAEChfycVhMMDATgQFWR5A5Ncd8P8vBDib9JbxQmwSp
	 Ha5pd/slWNKB0FkxCyW5c6wLIN2KROPaZQMDiEizc7cqphZNPEaOUSeX6gT21dS+eJ
	 njTJxJlw7bkuhITCeYefAgqWOwRBEHzzBedpEzzGOYjQDDwdgYoBdP/fxacOpTi0nB
	 5jMv6cTgg8onQ==
Subject: Re: [PATCH net-next v6 RESEND 1/4] net: stmmac: guard against NULL
 pointers when freeing TX/RX buffers
From: netdev-bot+sashiko@kernel.org
To: dinghui1111@163.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dinghui@lixiang.com, xiasanbo@lixiang.com, yangchen11@lixiang.com,
 liuxuanjun@lixiang.com
Date: Tue, 10 Nov 2026 12:08:14 +0000
Message-ID: <179431249447.994134.11805263376098684197@kernel.org>
In-Reply-To: <20261106090507.1020751-2-dinghui1111@163.com>
References: <20261106090507.1020751-2-dinghui1111@163.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (3) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message understates what the patch fixes and has no
  Fixes: tag.

Pre-existing issues:
- [High] stmmac_enable_rx_queue() (stmmac_main.c:7204) and
  stmmac_enable_tx_queue() (stmmac_main.c:7254) return void.
- [High] stmmac_xdp_set_prog() (stmmac_xdp.c) calls stmmac_xdp_release()
  and then stmmac_xdp_open(dev), but ignores the return value.
- [High] stmmac_xdp_enable_pool() and stmmac_xdp_disable_pool()
  (stmmac_xdp.c) call stmmac_disable_tx_queue() ->…

--

net: stmmac: guard against NULL pointers when freeing TX/RX buffers

This adds NULL checks to the stmmac TX/RX buffer free helpers so they can
be called on queues whose buffer arrays were never allocated. It also
clears the freed pointers in __free_dma_rx_desc_resources() and
__free_dma_tx_desc_resources() so priv->dma_conf can be reused across XDP
open/release cycles.

> Add NULL checks in the free helpers as a defensive measure, since they may
> be called on partially-initialized queues.
> Additionally, make __free_dma_rx_desc_resources() and
> __free_dma_tx_desc_resources() clear the pointers they free, so that
> the NULL guards in the free helpers hold reliably when the long-lived
> priv->dma_conf is reused across XDP open/release cycles.

[Severity: Medium]
Is "a defensive measure" the right description here? It looks like this
fixes two crashes that can be hit on an ordinary allocation failure.

First, when __alloc_dma_rx_desc_resources() fails on queue k,
alloc_dma_rx_desc_resources() unwinds with:

err_dma:
	free_dma_rx_desc_resources(priv, dma_conf);

This walks all rx_queues_to_use queues, including the ones after k that
were never allocated. Their buf_pool is NULL, so the following path
dereferences NULL:

free_dma_rx_desc_resources()
  __free_dma_rx_desc_resources()
    dma_free_rx_skbufs()
      stmmac_free_rx_buffer()
        buf = &rx_q->buf_pool[i];
        if (buf->page)

The TX side does the same thing with tx_q->tx_skbuff_dma[i].buf in
stmmac_free_tx_buffer().

Second, stmmac_xdp_set_prog() calls stmmac_xdp_release() and then
stmmac_xdp_open() on the same priv->dma_conf. Before this patch the free
path left buf_pool, page_pool, the coherent rings and tx_skbuff(_dma)
dangling. A failure in stmmac_xdp_open()->alloc_dma_desc_resources() then
made the unwind kfree() and dma_free_coherent() those stale pointers a
second time, and call page_pool_destroy() on a pool that was already
destroyed.

Should the commit message describe these as the NULL dereference and
double free they are? Should it also carry a Fixes: tag so it can go
through net and be picked up by stable?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a2177777727ef..fcc80ece37679 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -2198,13 +2210,20 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
>  	size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
>  
>  	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
> +	rx_q->dma_erx = NULL;
> +	rx_q->dma_rx = NULL;
> +	rx_q->dma_rx_phy = 0;

[Severity: High]
This is a pre-existing issue, but what happens on the AF_XDP pool path
when the re-allocation after this free fails?

stmmac_xdp_enable_pool() does:

	stmmac_disable_rx_queue(priv, queue);
	stmmac_disable_tx_queue(priv, queue);
	...
	stmmac_enable_rx_queue(priv, queue);
	stmmac_enable_tx_queue(priv, queue);
	napi_enable(&ch->rxtx_napi);

	err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);

stmmac_enable_rx_queue() and stmmac_enable_tx_queue() return void. On
failure they only log a message:

	ret = __alloc_dma_rx_desc_resources(priv, &priv->dma_conf, queue);
	if (ret) {
		netdev_err(priv->dev, "Failed to alloc RX desc.\n");
		return;
	}

Suppose the RX allocation fails and the TX one succeeds. tx_q->xsk_pool
is then set, so stmmac_xsk_wakeup() schedules rxtx_napi.
stmmac_napi_poll_rxtx()->stmmac_rx_zc() then does the following with
rx_q->dma_rx now NULL:

	p = stmmac_get_rx_desc(priv, rx_q, entry);
	status = stmmac_rx_status(priv, &priv->xstats, p);

A TX failure has the same problem with tx_q->dma_tx and tx_skbuff_dma.

With this patch the result is a NULL dereference in NAPI context instead
of a use-after-free of the freed ring.

Could the enable helpers return an error? That would let
stmmac_xdp_enable_pool() and stmmac_xdp_disable_pool() avoid enabling
NAPI on a queue that has no rings.

[ ... ]

> @@ -2246,9 +2265,16 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
>  	size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
>  
>  	dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
> +	tx_q->dma_etx = NULL;
> +	tx_q->dma_entx = NULL;
> +	tx_q->dma_tx = NULL;
> +	tx_q->dma_tx_phy = 0;

[Severity: High]
This isn't a bug introduced by this patch, but stmmac_xdp_set_prog()
ignores the return value of stmmac_xdp_open():

	if (if_running && need_update)
		stmmac_xdp_open(dev);

	if (prog)
		xdp_features_set_redirect_target(dev, true);

	return 0;

stmmac_xdp_open() can fail in alloc_dma_desc_resources(),
init_dma_desc_rings() or stmmac_request_irq(). In each case it returns
with the rings freed (now NULL), the IRQs released and all NAPIs still
disabled. The device stays IFF_UP and STMMAC_DOWN is not set.

Can a later ndo_stop, XDP program change or suspend then hang?
stmmac_disable_all_queues() would call napi_disable() on NAPIs that are
already disabled. napi_disable_locked() would then wait forever, with
RTNL held, for NAPIF_STATE_SCHED and NAPIF_STATE_NPSVC to clear.
stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0) would also run a second time on
IRQs that were already freed.

There is also a problem on the redirect side, because stmmac_xdp_xmit()
only checks STMMAC_DOWN:

	if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
		return -ENETDOWN;

Frames redirected to this device from another interface therefore reach
stmmac_xdp_xmit_xdpf(), which writes tx_q->tx_skbuff_dma[entry] and
tx_q->xdpf[entry]. With this patch those writes go near NULL. Before it
they went into freed memory.

>  
>  	kfree(tx_q->tx_skbuff_dma);
> +	tx_q->tx_skbuff_dma = NULL;
> +
>  	kfree(tx_q->tx_skbuff);
> +	tx_q->tx_skbuff = NULL;
>  }

[Severity: High]
This is a pre-existing issue, but is there anything that keeps the
transmit paths away from these arrays while they are being freed and
cleared here?

stmmac_xdp_enable_pool() and stmmac_xdp_disable_pool() call
stmmac_disable_tx_queue()->__free_dma_tx_desc_resources() on a running
interface while holding only RTNL:

	napi_disable(&ch->rxtx_napi);
	stmmac_disable_rx_queue(priv, queue);
	stmmac_disable_tx_queue(priv, queue);
	synchronize_rcu();

The netdev TX queue is never stopped, and __netif_tx_lock is not taken.
So stmmac_xmit() and stmmac_tso_xmit() (under HARD_TX_LOCK), and
stmmac_xdp_xmit() (under __netif_tx_lock), can run while tx_q->dma_tx,
tx_skbuff/xdpf and tx_skbuff_dma are being freed. The synchronize_rcu() in
stmmac_xdp_disable_pool() runs only after the memory is already freed.

Before this patch a concurrent xmit wrote into freed memory. With it, the
xmit either hits the window between kfree() and the NULL store, or
dereferences NULL.

If stmmac_enable_tx_queue() then fails, the queue stays transmit-enabled
with these pointers permanently NULL.

Does the TX queue need to be stopped first, the way stmmac_xdp_release()
does with netif_tx_disable()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106090507.1020751-1-dinghui1111%40163.com
