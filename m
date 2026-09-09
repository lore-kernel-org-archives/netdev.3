Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB061FFC59;
	Wed,  9 Sep 2026 00:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914884; cv=none; b=UTygfkgHrO+Y9bVf/I2WUu6Lj5zL/ARwVKQfVxm0oZbW1W0rJxCnJS1e23KVE/XHT6UtN0SY26kqHxjtHeVkdR7545lQsbeqq0Bd+tjydypWQ0apqLmIEJSLC9QR/YoeWHYFxxJmqPwJcoZigBPDmy79apNv7y3Om1ywsfIlWm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914884; c=relaxed/simple;
	bh=HLox7zhoFfanfrixi5miNH5ca6aAaV22LxQlFFjsPfY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V52AFiy+IQEQhMveguLhfHrU9IFmWaMOZxfh6vB3xganUW8hxMy/ZQbltPUnoVBwWrhF5hvyXXYYAKN5ruVVeUgafWNYRmx7x6tuopZRXF1mNQeyDM2Ow1q5Bodg2Dy834oZoE4Qn5G2oMXonnFYk6+pb+zCK02/gwYN7k+pmvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmoyUQxn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmoyUQxn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C75B1F00A3A;
	Wed,  9 Sep 2026 00:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914883;
	bh=cddY/E/7oRehQlouyl/DN8qA56tsyMqy79qmg1Igs+8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FmoyUQxnjrOmLwR9wtu1tfMcUvoUAK7aHOe0zGY7o1lAk1In7MJKsAUTNjNwGpWAP
	 R+63GdSzxTEJpyZovpST4EtPcgMH/VQXADlIVVlc7tBhrexJwfzdmdjQ++gTRPqTs3
	 WzvTj02nLN8zf+tRjXv9JX7uwrIUCQq3rtcVyJ8ByMRAWce5aVBD1TI6je1Z1zn5js
	 Qo871Tgx5BqRs9X7o1RSl8ydMZodEvfrnTtDogJ7lfOCMF/7HAOiWQSmwy3m0fNQfm
	 /9i2glVvjwF684PN2c5Ii0UJTNgH7/OK59IeO15IqrKjvBSPUciIbc0VixVoD/e4LU
	 5kRxH5+6Pn6Kg==
Subject: Re: [PATCH net-next v2] net: stmmac: fix error path cleanup in DMA
 descriptor ring allocation
From: netdev-bot+sashiko@kernel.org
To: dinghui1111@163.com
Cc: andrew@lunn.ch, maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dinghui@lixiang.com, xiasanbo@lixiang.com, yangchen11@lixiang.com,
 liuxuanjun@lixiang.com
Date: Wed, 09 Sep 2026 00:48:01 +0000
Message-ID: <178891488143.219967.12581003227734181738@kernel.org>
In-Reply-To: <20260905154654.1725313-1-dinghui1111@163.com>
References: <20260905154654.1725313-1-dinghui1111@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 1

- [High] The newly added NULL guards encode the contract 'NULL == not
  allocated', but the free helpers never establish it:…
- [Low] Missing `Fixes:` tag (and no stable routing) on a patch that
  fixes a user-visible NULL-pointer dereference.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  makes it deterministic: `stmmac_enable_rx_queue()`…
- [Medium] This problem wasn't introduced by this patch, but the sibling
  error path in `alloc_dma_desc_resources()` (stmmac_main.c:2445-2457)…

--

net: stmmac: fix error path cleanup in DMA descriptor ring allocation

This makes __alloc_dma_rx_desc_resources() and
__alloc_dma_tx_desc_resources() unwind their own partial allocations on
failure, and adds NULL checks in the buffer free helpers so they can be
called on partially-initialized queues.

A few questions below about the new error paths and the surrounding
callers.

[Severity: Low]
The commit message describes three concrete NULL dereferences that are
reachable today, when a kzalloc_objs() inside
__alloc_dma_rx_desc_resources() / __alloc_dma_tx_desc_resources() fails
and the err_dma: labels in alloc_dma_rx_desc_resources() /
alloc_dma_tx_desc_resources() run the bulk free helpers over every
queue.

Should this carry a Fixes: tag so it can be routed to the stable trees?
Without one it is hard for a backporter to tell how far back the
dereference exists.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 07a6fab6460ed..8d03eb7904ef1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -1761,6 +1761,10 @@ static void dma_free_rx_skbufs(struct stmmac_priv *priv,
>  	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
>  	int i;
>  
> +	/* buf_pool may not be allocated if alloc failed early */
> +	if (!rx_q->buf_pool)
> +		return;
> +
>  	for (i = 0; i < dma_conf->dma_rx_size; i++)
>  		stmmac_free_rx_buffer(priv, rx_q, i);
>  }

[Severity: High]
These new guards assume "NULL means not allocated", but do the free
helpers ever establish that? __free_dma_rx_desc_resources() releases
everything without clearing the fields:

	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);

	if (xdp_rxq_info_is_reg(&rx_q->xdp_rxq))
		xdp_rxq_info_unreg(&rx_q->xdp_rxq);

	kfree(rx_q->buf_pool);
	if (rx_q->page_pool)
		page_pool_destroy(rx_q->page_pool);

__free_dma_tx_desc_resources() does the same for tx_skbuff_dma,
tx_skbuff and the coherent TX ring.

That matters because these helpers also run on the long-lived
priv->dma_conf, and it is re-used for the next allocation:

  stmmac_xdp_set_prog()
    stmmac_xdp_release()
      free_dma_desc_resources(priv, &priv->dma_conf)   /* pointers stay set */
    stmmac_xdp_open()
      alloc_dma_desc_resources(priv, &priv->dma_conf)

Unlike stmmac_open(), which works on a freshly kzalloc'ed dma_conf,
nothing zeroes priv->dma_conf here. So if any per-queue allocation fails
mid-way (for example page_pool_create() for queue 1, which is the one
early return this patch leaves as-is), alloc_dma_rx_desc_resources()
jumps to err_dma: and free_dma_rx_desc_resources() loops over all queues
0..rx_queues_to_use-1:

	for (queue = 0; queue < rx_count; queue++)
		__free_dma_rx_desc_resources(priv, dma_conf, queue);

The queues that were not touched in this pass still hold the pointers
freed by the preceding release. Since those pointers are freed but not
NULL, does the new guard fire at all for them?

Following that path through, stmmac_free_rx_buffer() would read
buf->page out of the freed buf_pool object and pass it to
page_pool_put_full_page() on an already-destroyed pool, then
dma_free_coherent() runs a second time on the released coherent memory,
kfree(rx_q->buf_pool) becomes a slab double free, and
page_pool_destroy(rx_q->page_pool) is called on a freed pool. Can that
corrupt the slab and DMA state?

The TX side looks symmetric via the new "if (!tx_q->tx_skbuff_dma)
return;" guard and the tx_skbuff/xdpf tests added in
stmmac_free_tx_buffer().

Would it make sense for __free_dma_rx_desc_resources() and
__free_dma_tx_desc_resources() to NULL the fields they free, so the new
guards actually hold?

[ ... ]

> @@ -2296,10 +2312,27 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
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
> +	if (priv->extend_desc)
> +		dma_free_coherent(priv->device, size, rx_q->dma_erx,
> +				  rx_q->dma_rx_phy);
> +	else
> +		dma_free_coherent(priv->device, size, rx_q->dma_rx,
> +				  rx_q->dma_rx_phy);
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
This isn't a bug introduced by this patch, but does the patch turn it
into a deterministic NULL dereference?

stmmac_enable_rx_queue() and stmmac_enable_tx_queue() return void and
simply drop the allocation error:

	ret = __alloc_dma_rx_desc_resources(priv, &priv->dma_conf, queue);
	if (ret) {
		netdev_err(priv->dev, "Failed to alloc RX desc.\n");
		return;
	}

After the new labels above, the failed queue is left with
rx_q->buf_pool == NULL, rx_q->page_pool == NULL and
rx_q->dma_rx/dma_erx == NULL (tx_skbuff and tx_skbuff_dma on the TX
side).

The caller in stmmac_xdp.c continues regardless:

	stmmac_enable_rx_queue(priv, queue);
	stmmac_enable_tx_queue(priv, queue);
	napi_enable(&ch->rxtx_napi);

	err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);

and stmmac_xsk_wakeup() reaches __napi_schedule(&ch->rxtx_napi). Its
only precondition is:

	if (!rx_q->xsk_pool && !tx_q->xsk_pool)
		return -EINVAL;

which does not help here, because dma_free_tx_skbufs() only clears
tx_q->xsk_pool when xsk_frames_done is non-zero.

Does the scheduled poll then dereference rx_q->buf_pool[entry] and
tx_q->tx_skbuff_dma[entry] in softirq context on a queue whose arrays
were just set to NULL? Should the enable helpers propagate the error and
skip the napi_enable()/wakeup instead?

[ ... ]

> @@ -2369,6 +2402,14 @@ static int __alloc_dma_tx_desc_resources(struct stmmac_priv *priv,
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
>  
>  static int alloc_dma_tx_desc_resources(struct stmmac_priv *priv,

[Severity: Medium]
This is a pre-existing issue, but the sibling function in the same
family still does not follow the rule the commit message states, namely
"making each allocation function responsible for undoing its own
allocations on error".

alloc_dma_desc_resources() allocates RX first and returns the TX error
directly:

	int ret = alloc_dma_rx_desc_resources(priv, dma_conf);

	if (ret)
		return ret;

	ret = alloc_dma_tx_desc_resources(priv, dma_conf);

	return ret;

On TX failure only free_dma_tx_desc_resources() has run (inside
alloc_dma_tx_desc_resources()), so every rx_q->page_pool,
rx_q->buf_pool and coherent RX ring is still allocated. The caller then
takes the alloc_error: path:

init_error:
	free_dma_desc_resources(priv, dma_conf);
alloc_error:
	kfree(dma_conf);
	return ERR_PTR(ret);

which only kfree()s dma_conf and drops the only pointers to those RX
resources; free_dma_desc_resources() is reached only via init_error:.

Does this leak the RX page pools, the buf_pool arrays and the
dma_alloc_coherent RX rings when a TX allocation fails during ifup or an
MTU change? stmmac_xdp_open() has the same shape, except the resources
stay reachable through priv->dma_conf, which feeds into the stale
pointer question above.

Would adding a free_dma_rx_desc_resources() call to
alloc_dma_desc_resources() on the TX failure path fit the pattern this
patch establishes?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260905154654.1725313-1-dinghui1111%40163.com
