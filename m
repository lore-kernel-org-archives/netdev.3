Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D2496D34
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141549; cv=none; b=tbI338bWaUKWdtWjqHl41Fw0wcLKYIh3c5ENIDT68jPbegmjsWbXCxc0zlQD1Zjq6N3DNWemGpEkHVnqByrhk+sBVH7oSRuD6GcT9HDWyMsqwgAWYk3FoFibtooHM5qkgqeVnG4s8QDzmc95RBtYmbBy9U631kV8G0BTDFOvXQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141549; c=relaxed/simple;
	bh=V0wN3JC6ahh7rk0oXw0MBwxacu8tuHsgn5GfhoNgALQ=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:In-Reply-To:
	 References:MIME-Version; b=b5syQBjiYU85ndlEzriCaRCtOkuuVi2AXHYefWzbjjweK4CLUB29z4ui/aEKDtLHrgEIfpRDxOrOxabVeQ55kLOIdNaJfOZFRfKDAO3lOisjSI+POZ6giUglSLFmVYyGDl7PaX/DN8bvmfeZdbap2i8lyOu0VaU7/XxiryHpMlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MpmIs/B0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MpmIs/B0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 948641A01F2;
	Fri, 11 Sep 2026 15:45:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6575C601A3;
	Fri, 11 Sep 2026 15:45:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7FA9611C7AFBA;
	Fri, 11 Sep 2026 17:45:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789141539; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zvoomP/KmcW9uaMqASjpDFj47yuZryYCAre99LjYrIw=;
	b=MpmIs/B0SQ6arMNYfrcKtYMX38wzeYRrc85TvFAbZiFzbejsdwTQ1RkQm06yO8vQgLlT75
	ThpscA7DLx1uPMKM90Zf1RXgWwBWg4eKV3geLwKU6As02u2L24QBoaHNIe50VkR8wMalId
	q1h0+8t2X5C1KUv9+y2ZIDiY7pg0gHPwNvmWzQtCwST7GJEIFT6+UADPQ/z6PV3LBRKNCm
	FTb9O1u8IZfXylnSnPOzCJz+ZzXVVgJHHFhqRYPKwpz1Hg82ClWv4io8ZruNNtllhwjotN
	XGu5hq1jMKBrS1cUmq/snnpBxRE/6FODhw32urSyHP1syA4BMKuGeeVpd36InQ==
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 17:45:33 +0200
Message-Id: <DLCLQPVD8B9N.NFKWDS6SH0QN@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v9 08/17] net: macb: introduce macb_context
 struct for buffer management
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Paolo Valerio" <pvalerio@redhat.com>, "Nicolai
 Buchwitz" <nb@tipi-net.de>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>
In-Reply-To: <20260812-macb-context-v9-8-7ddbf5f715e0@bootlin.com>
References: <20260812-macb-context-v9-8-7ddbf5f715e0@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: NkPDzVMT/sTg
X-Last-TLS-Session-Version: TLSv1.3

Replying to non-net sashiko
https://sashiko.dev/#/patchset/20260812-macb-context-v9-0-7ddbf5f715e0%40bo=
otlin.com

> commit 64775f904ae680bc33819f27120daf167d287348
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> Subject: net: macb: introduce macb_context struct for buffer management
>
> Whenever an operation requires buffer realloc, we close the interface,
> update parameters and reopen. This commit introduces the macb_context
> struct to own all queue buffers and parameters, paving the way for
> supporting multiple contexts in parallel to improve reliability under
> memory pressure.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
>
> [ ... ]
>
> > @@ -1257,6 +1288,7 @@ static void macb_tx_error_task(struct work_struct=
 *work)
> >  	struct macb_queue *queue =3D container_of(work, struct macb_queue,
> >  						tx_error_task);
> >  	unsigned int q =3D queue - queue->bp->queues;
> > +	struct macb_txq *txq =3D macb_txq(queue);
> >  	struct macb *bp =3D queue->bp;
> >  	struct macb_tx_skb *tx_skb;
> >  	struct macb_dma_desc *desc;
>
> [Severity: High]
> Does this asynchronously executing work item dereference the bp->ctx
> pointer unconditionally via the macb_txq() helper?
>
> If the interface is brought down, macb_close() is called, which frees
> bp->ctx and sets it to NULL. If a hardware error interrupt had just fired
> and scheduled queue->tx_error_task, it appears this task could continue t=
o
> execute because it is not cancelled via cancel_work_sync() in macb_close(=
).
> Could this result in a NULL pointer dereference or use-after-free?

Yes! This is all unrelated to the context swapping series but as the
context swapping codepath does it properly we can fix the macb_close
codepath along the way.

The sequence will be something like:
 - quiesce IRQs to make sure they cannot re-schedule our BH tasks
 - synchronize_irq(bp->queues[i].irq) for all i
 - drain all BH tasks (in the right order!)
    - bp->hresp_err_bh_work
    - queue->tx_error_task
    - queue->napi_rx
    - queue->napi_tx
    - bp->tx_lpi_work

Here is my "what schedules what?" table which explains the ordering:

|               |   enable/disable   |           schedule            |
|               |----|-------|-------|------|----|----|--------|-----|
|               |IRQs|napi_tx|napi_rx|tx_lpi|napi|napi|tx_error|hresp|
| Context       |    |       |       | task | rx | tx |  task  |task |
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D|=3D=3D=3D=3D=3D=
=3D=3D|=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D|=3D=3D=3D=3D|=
=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D|
| open          | X  |   X   |   X   |      |    |    |        |     |
| link_up       | X  |       |       |      |    |    |        |     |
| link_down     | X  |       |       |      |    |    |        |     |
| close         | X  |   X   |   X   |      |    |    |        |     |
| enable_tx_lpi |    |       |       |  X   |    |    |        |     |
| swap          | X  |   X   |   X   |  X   |    |    |        |     |
| suspend       | X  |   X   |   X   |      |    |    |        |     |
| resume        | X  |   X   |   X   |      |    |    |        |     |
|---------------|----|-------|-------|------|----|----|--------|-----|
| irq & netpoll | X  |       |       |      | X  | X  |   X    | X   |
|---------------|----|-------|-------|------|----|----|--------|-----|
| napi_rx       | X  |       |       |      | X  |    |        |     |
| napi_tx       | X  |       |       |  X   |    | X  |        |     |
|---------------|----|-------|-------|------|----|----|--------|-----|
| tx_error_task | X  |   X   |       |      |    |    |        |     |
| hresp task    | X  |       |       |      |    |    |        |     |


>
> [ ... ]
>
> > @@ -3222,6 +3300,8 @@ static int macb_close(struct net_device *netdev)
> >  	spin_unlock_irqrestore(&bp->lock, flags);
> > =20
> >  	macb_free(bp);
> > +	kfree(bp->ctx);
> > +	bp->ctx =3D NULL;
>
> [Severity: High]
> Is it possible that queue->tx_error_task or bp->hresp_err_bh_work
> are still running or pending when we reach this point?

Yes, see above.

[...]

> [Severity: High]
> This is a pre-existing issue, but does macb_close() need to call
> synchronize_irq() before freeing resources?

Yes, see above.

[...]

>
> >
> >  	if (bp->ptp_info)
> >  		bp->ptp_info->ptp_remove(netdev);
>
> [ ... ]
>
> [Severity: High]
> This is a pre-existing issue, but does macb_interrupt() safely handle
> shared interrupts when the device is runtime suspended?
>
> drivers/net/ethernet/cadence/macb_main.c:macb_interrupt() {
>     ...
>     spin_lock(&bp->lock);
>
>     status =3D queue_readl(queue, ISR);
>     if (unlikely(!status)) {
>         spin_unlock(&bp->lock);
>         return IRQ_NONE;
>     ...
> }
>
> If the device enters runtime suspend and its clocks are disabled, and
> another device sharing the same IRQ line triggers an interrupt, this
> handler executes and performs queue_readl(queue, ISR) without verifying
> the device's power management state. Could this trigger a synchronous
> external abort (bus fault)?
>
> Using pm_runtime_get_if_active() before accessing hardware registers in
> shared IRQ handlers is typically required to prevent accessing powered-of=
f
> hardware.

Too unrelated to context swapping. Also it only crashes if shared lanes
are with separate interfaces. I hope no hardware like that exists in
the wild. We supported shared interrupts only because some HW uses a
single lane for all queues.

Long term I'd like to have a single handler for those IP blocks.
Goal being to reduce overhead and remove that pesky IRQF_SHARED flag.

---

Replying to net sashiko
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260812-macb-context-v=
9-0-7ddbf5f715e0%40bootlin.com

> commit d54f7e79d0f10ea8e363d1bb3711374a51ae9c90
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: introduce macb_context struct for buffer management
>
> This moves the per-queue ring/buffer pointers and the ring size
> parameters out of struct macb / struct macb_queue into a new
> heap-allocated struct macb_context, allocated in macb_open() and
> at91ether_open() and freed in the close paths. All accessors are
> converted to reach the state through bp->ctx.
>
> > diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet=
/cadence/macb.h
> > index 1e1f52285a39..95cb494190c5 100644
> > --- a/drivers/net/ethernet/cadence/macb.h
> > +++ b/drivers/net/ethernet/cadence/macb.h
>
> [ ... ]
>
> > @@ -1295,6 +1284,32 @@ struct ethtool_rx_fs_list {
> >  	unsigned int count;
> >  };
> > =20
> > +struct macb_rxq {
> > +	struct macb_dma_desc	*ring;		/* MACB & GEM */
> > +	dma_addr_t		ring_dma;	/* MACB & GEM */
> > +	unsigned int		tail;		/* MACB & GEM */
> > +	unsigned int		prepared_head;	/* GEM */
> > +	struct sk_buff		**skbuff;	/* GEM */
> > +	dma_addr_t		buffers_dma;	/* MACB */
> > +	void			*buffers;	/* MACB */
> > +};
> > +
> > +struct macb_txq {
> > +	unsigned int		head;
> > +	unsigned int		tail;
> > +	struct macb_dma_desc	*ring;
> > +	dma_addr_t		ring_dma;
> > +	struct macb_tx_skb	*skb;
> > +};
> > +
> > +struct macb_context {
> > +	unsigned int		rx_buffer_size;
> > +	unsigned int		rx_ring_size;
> > +	unsigned int		tx_ring_size;
> > +	struct macb_rxq		rxq[MACB_MAX_QUEUES];
> > +	struct macb_txq		txq[MACB_MAX_QUEUES];
> > +};
> > +
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 1476bce77f34..380ee72e26ac 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
>
> [ ... ]
>
> > @@ -1257,6 +1288,7 @@ static void macb_tx_error_task(struct work_struct=
 *work)
> >  	struct macb_queue *queue =3D container_of(work, struct macb_queue,
> >  						tx_error_task);
> >  	unsigned int q =3D queue - queue->bp->queues;
> > +	struct macb_txq *txq =3D macb_txq(queue);
> >  	struct macb *bp =3D queue->bp;
> >  	struct macb_tx_skb *tx_skb;
> >  	struct macb_dma_desc *desc;
>
> [ ... ]
>
> > @@ -1353,10 +1385,10 @@ static void macb_tx_error_task(struct work_stru=
ct *work)
> >  	wmb();
> > =20
> >  	/* Reinitialize the TX desc queue */
> > -	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
> > +	queue_writel(queue, TBQP, lower_32_bits(txq->ring_dma));
> >  	/* Make TX ring reflect state of hardware */
> > -	queue->tx_head =3D 0;
> > -	queue->tx_tail =3D 0;
> > +	txq->head =3D 0;
> > +	txq->tail =3D 0;
>
> [ ... ]
>
> > @@ -2615,60 +2663,71 @@ static void gem_free_rx_buffers(struct macb *bp=
)
>
> [ ... ]
>
> >  static void macb_free(struct macb *bp)
> >  {
> >  	struct device *dev =3D &bp->pdev->dev;
> >  	struct macb_queue *queue;
> > +	struct macb_txq *txq;
> > +	struct macb_rxq *rxq;
> >  	unsigned int q;
> >  	size_t size;
> > =20
> >  	bp->macbgem_ops.mog_free_rx_buffers(bp);
> > =20
> > +	txq =3D &bp->ctx->txq[0];
> >  	size =3D bp->num_queues * macb_tx_ring_size_per_queue(bp);
> > -	dma_free_coherent(dev, size, bp->queues[0].tx_ring, bp->queues[0].tx_=
ring_dma);
> > +	dma_free_coherent(dev, size, txq->ring, txq->ring_dma);
> > =20
> > +	rxq =3D &bp->ctx->rxq[0];
> >  	size =3D bp->num_queues * macb_rx_ring_size_per_queue(bp);
> > -	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_=
ring_dma);
> > +	dma_free_coherent(dev, size, rxq->ring, rxq->ring_dma);
>
> [ ... ]
>
> > @@ -2728,7 +2786,8 @@ static int macb_alloc(struct macb *bp)
> >  {
> >  	struct device *dev =3D &bp->pdev->dev;
> >  	dma_addr_t tx_dma, rx_dma;
> > -	struct macb_queue *queue;
> > +	struct macb_txq *txq;
> > +	struct macb_rxq *rxq;
> >  	unsigned int q;
> >  	void *tx, *rx;
> >  	size_t size;
> > @@ -2754,16 +2813,19 @@ static int macb_alloc(struct macb *bp)
> >  	netdev_dbg(bp->netdev, "Allocated %zu bytes for %u RX rings at %08lx =
(mapped %p)\n",
> >  		   size, bp->num_queues, (unsigned long)rx_dma, rx);
> > =20
> > -	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue)=
 {
> > -		queue->tx_ring =3D tx + macb_tx_ring_size_per_queue(bp) * q;
> > -		queue->tx_ring_dma =3D tx_dma + macb_tx_ring_size_per_queue(bp) * q;
> > +	for (q =3D 0; q < bp->num_queues; ++q) {
> > +		txq =3D &bp->ctx->txq[q];
> > +		rxq =3D &bp->ctx->rxq[q];
> > +
> > +		txq->ring =3D tx + macb_tx_ring_size_per_queue(bp) * q;
> > +		txq->ring_dma =3D tx_dma + macb_tx_ring_size_per_queue(bp) * q;
> > =20
> > -		queue->rx_ring =3D rx + macb_rx_ring_size_per_queue(bp) * q;
> > -		queue->rx_ring_dma =3D rx_dma + macb_rx_ring_size_per_queue(bp) * q;
> > +		rxq->ring =3D rx + macb_rx_ring_size_per_queue(bp) * q;
> > +		rxq->ring_dma =3D rx_dma + macb_rx_ring_size_per_queue(bp) * q;
>
> [Severity: Medium]
> [Finding: gpt-5-6-sol-4-12]
> [Sources: gpt-5-6-sol, opus-5]
> This isn't a bug introduced by this patch, but while macb_alloc() is bein=
g
> reshaped here, does the tx coherent block get leaked on the early error
> paths?

Yes indeed. I've got a fix for that incoming. But completely unrelated.

[...]

> > @@ -3140,14 +3207,22 @@ static int macb_open(struct net_device *netdev)
> >  	if (err < 0)
> >  		return err;
> > =20
> > +	bp->ctx =3D kzalloc_obj(*bp->ctx);
> > +	if (!bp->ctx) {
> > +		err =3D -ENOMEM;
> > +		goto pm_exit;
> > +	}
> > +
> >  	/* RX buffers initialization */
> >  	macb_init_rx_buffer_size(bp, bufsz);
> > +	bp->ctx->rx_ring_size =3D bp->configured_rx_ring_size;
> > +	bp->ctx->tx_ring_size =3D bp->configured_tx_ring_size;
> > =20
> >  	err =3D macb_alloc(bp);
> >  	if (err) {
> >  		netdev_err(netdev, "Unable to allocate DMA memory (error %d)\n",
> >  			   err);
> > -		goto pm_exit;
> > +		goto free_ctx;
> >  	}
> > =20
> >  	bp->macbgem_ops.mog_init_rings(bp);
> > @@ -3189,6 +3264,9 @@ static int macb_open(struct net_device *netdev)
> >  		napi_disable(&queue->napi_tx);
> >  	}
> >  	macb_free(bp);
> > +free_ctx:
> > +	kfree(bp->ctx);
> > +	bp->ctx =3D NULL;
> >  pm_exit:
> >  	pm_runtime_put_sync(&bp->pdev->dev);
> >  	return err;
> > @@ -3222,6 +3300,8 @@ static int macb_close(struct net_device *netdev)
> >  	spin_unlock_irqrestore(&bp->lock, flags);
> > =20
> >  	macb_free(bp);
> > +	kfree(bp->ctx);
> > +	bp->ctx =3D NULL;
>
> [Severity: High]
> [Finding: gpt-5-6-sol-4-11]
> [Sources: gpt-5-6-sol, opus-5]
> Can a pending queue->tx_error_task still reference the context after this
> kfree()?

Yes, see above.

[...]

> > @@ -3712,8 +3799,8 @@ static int macb_set_ringparam(struct net_device *=
netdev,
> >  		macb_close(bp->netdev);
> >  	}
> > =20
> > -	bp->rx_ring_size =3D new_rx_size;
> > -	bp->tx_ring_size =3D new_tx_size;
> > +	bp->configured_rx_ring_size =3D new_rx_size;
> > +	bp->configured_tx_ring_size =3D new_tx_size;
> > =20
> >  	if (reset)
> >  		macb_open(bp->netdev);
>
> [Severity: High]
> [Finding: gpt-5-6-sol-3-7]
> [Sources: gpt-5-6-sol, opus-5]
> What happens here if macb_open() fails now that it can fail at the new
> kzalloc_obj() of bp->ctx?

We ignore this error path because at the end of the series this gets
turned into a context swap operation and the context_swap_end cannot
fail!

[...]

> > @@ -5061,6 +5149,12 @@ static int at91ether_open(struct net_device *net=
dev)
> >  	if (ret < 0)
> >  		return ret;
> > =20
> > +	bp->ctx =3D kzalloc_obj(*bp->ctx);
> > +	if (!bp->ctx) {
> > +		ret =3D -ENOMEM;
> > +		goto pm_exit;
> > +	}
> > +
>
> [Severity: Low]
> [Finding: gpt-5-6-sol-2-3]
> [Sources: gpt-5-6-sol, opus-5]
> This isn't a bug today, but should at91ether_open() also initialise the
> context parameters the way macb_open() does?

No because "configured_*_ring_size" does not mean anything on at91ether
which has 1-sized tx ring or 4-sized rx ring. We refuse the ring size
config ops, as expected.

[...]

Thanks,
--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

