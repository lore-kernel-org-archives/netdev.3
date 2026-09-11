Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1306B4BEE2C
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163628; cv=none; b=s2e4Jfgp0aTzi4GHyyE4GZwX4Rp1dvCi65Ac3NU8bfMornoahDvb3eqTsW62IAEjAr4XQ9kmVomkPavvCKF7kSo2WPhQeqf6vwOtLXMHKG9ir46zfn9TQMOBEBni0MDAn7SHximKlvKGZBysbpeirT2hQNKaan1rQbnlYoIhXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163628; c=relaxed/simple;
	bh=nwkwsVe8qcZX8Qp2xjQ7ZFv1InoQh8iT/fObeTFZUS0=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:In-Reply-To:
	 References:MIME-Version; b=FX0xy0KrV5zoLbsBFHd852adcA9gYR1TFjzixU1jCTWTBDRzefoAM0HKnr30qmqizerI4jgtucUnuOthjp+r3FsGlJk0w17Ge634H105rrVXFLLHIYlOdDzZ1kX8SHyRwxEqqC3ep9P2xHz+q1CiM1HLnn8PwvwZQ/1U3DJ3cq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nRWcuevK; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nRWcuevK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D70C3C63A10;
	Fri, 11 Sep 2026 21:54:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BB051601A3;
	Fri, 11 Sep 2026 21:53:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3080911C7A23F;
	Fri, 11 Sep 2026 23:53:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789163617; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PXhwIoA5YrzEr7CnOC2IKZ0EMecuH8cMMUx2syI+imw=;
	b=nRWcuevKqwTmKvT031GCVWoqjbfj9VJGA0wblLQs5UPv0wAJgQNN58BlcICglrdENo4vXA
	yiTCZcOJsy0sT9rNdUFK1EEDuc8YMnmDiqxoG1xZsVPkKk8SoksUOOLcw7SI9peQOZ80Xh
	O8GZQubeKjenzZJVTioqNEt2j1+9KSPDZpY9BfOMt4fbfrTd0lQzvufdI2ziGTvAxBFuhR
	A4vFAWz6bRO2YpNHr9AkXziuXrW4FMv/L4/6D7Lxmb3dDstooqk1tAQzXaFEoqzShX2IZ+
	pRPPnil/brpAo4SmZmNX/18RM77PAAP1J1wE1WYvgl8kZRQVDyc/J0588x5+Gw==
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 23:53:28 +0200
Message-Id: <DLCTKEROUJCX.12G2JSI26LQXH@bootlin.com>
Subject: Re: [PATCH net-next v9 16/17] net: macb: use context swapping in
 .set_ringparam()
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
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
In-Reply-To: <20260812-macb-context-v9-16-7ddbf5f715e0@bootlin.com>
References: <20260812-macb-context-v9-16-7ddbf5f715e0@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: HrqNTrNukpF3
X-Last-TLS-Session-Version: TLSv1.3

Replying to non-net sashiko
https://sashiko.dev/#/patchset/20260812-macb-context-v9-0-7ddbf5f715e0%40bo=
otlin.com

> commit 34a47bcab06bd390622de5b8628e1ca4b22fa12e
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> Subject: net: macb: use context swapping in .set_ringparam()
>
> This commit modifies the ethtool set_ringparam implementation to use a
> new context swapping mechanism instead of the previous close and reopen
> sequence. It introduces macb_context_swap_start() and
> macb_context_swap_end() helpers to handle the transition smoothly, along
> with a new mac_cfg_lock to serialize changes against phylink MAC callback=
s.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 6d79663e42bfe..55c97f2035e76 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -814,6 +831,10 @@ static void macb_mac_link_down(struct phylink_conf=
ig *config, unsigned int mode,
> >  	unsigned int q;
> >  	u32 ctrl;
> > =20
> > +	mutex_lock(&bp->mac_cfg_lock);
> > +
> > +	bp->link_up =3D false;
> > +
> >  	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC))
> >  		for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue=
)
> >  			queue_writel(queue, IDR,
> > @@ -824,6 +845,8 @@ static void macb_mac_link_down(struct phylink_confi=
g *config, unsigned int mode,
> >  	macb_writel(bp, NCR, ctrl);
>
> [Severity: High]
> This is a pre-existing issue, but does this read-modify-write of NCR need
> protection to avoid dropping hardware configuration?

Indeed. Unrelated but will do.

> >  	netif_tx_stop_all_queues(netdev);
> > +
> > +	mutex_unlock(&bp->mac_cfg_lock);
> >  }
>
> [ ... ]
>
> > @@ -3105,6 +3135,134 @@ static void macb_configure_dma(struct macb *bp)
> >  	}
> >  }
> > =20
> > +static void macb_context_swap_start(struct macb *bp)
> > +{
> > +	struct macb_queue *queue;
> > +	unsigned long flags;
> > +	unsigned int q;
> > +	u32 ctrl;
> > +
> > +	mutex_lock(&bp->mac_cfg_lock);
> > +
> > +	/* We cannot mask IRQs because they'll get re-armed by BH. So instead=
 we
> > +	 * signal to IRQ handler it shouldn't drive BH features and should
> > +	 * self-disarm.
> > +	 */
> > +	spin_lock_irqsave(&bp->lock, flags);
> > +	bp->ctx_swap =3D true;
> > +	spin_unlock_irqrestore(&bp->lock, flags);
> > +
> > +	/* Drain BH features. HW is still active and usable at this point but
> > +	 * IRQs are being ignored.
> > +	 */
> > +
> > +	cancel_work_sync(&bp->hresp_err_bh_work);
> > +
> > +	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue)=
 {
> > +		/* Must be done before NAPI is disabled. */
> > +		cancel_work_sync(&queue->tx_error_task);
>
> [Severity: High]
> This is a pre-existing issue, but since we are carefully cancelling worke=
r
> threads here during context swap, should we also be cancelling them durin=
g
> macb_close() and macb_suspend()?

Yes I'll integrate all that for next revision. See this email where I
went into more details.
https://lore.kernel.org/netdev/DLCLQPVD8B9N.NFKWDS6SH0QN@bootlin.com/

[...]
> > +
> > +		napi_disable(&queue->napi_rx);
> > +		napi_disable(&queue->napi_tx);
> > +	}
> > +
> > +	/* Must be done after napi_tx is disabled. */
> > +	cancel_delayed_work_sync(&bp->tx_lpi_work);
> > +
> > +	/* Can finally disable software Tx; need to wait until napi_tx and
> > +	 * tx_error_task cannot be scheduled as either might wakeup Tx.
> > +	 */
> > +	netif_tx_disable(bp->netdev);
>
> [Severity: High]
> Does this sequence leave the interface vulnerable to a false TX timeout?
>
> When macb_context_swap_start() stops the software TX queues via
> netif_tx_disable(), it does not suspend the watchdog via netif_carrier_of=
f()
> or update the queue's trans_start time.

Well actually netif_tx_disable() does reset dev_queue->trans_start of
all queues. So a race does exist but it is pretty slim (not the full
context swap): either before this netif_tx_disable() line or if context
swap lasts more than 5s.

I'll protect this by (1) grabbing bp->lock inside macb_tx_restart() and
(2) checking the state of our boolean flag to know if context swap is
ongoing.

> > +
> > +	/* Now that everything is stopped, clear DQL. */
>
> [ ... ]
>
> > +static void macb_context_swap_end(struct macb *bp,
> > +				  struct macb_context *new_ctx)
> > +{
>
> [ ... ]
>
> > +	/* Free old context. */
> > +
> > +	macb_free(old_ctx);
> > +	kfree(old_ctx);
>
> [Severity: Critical]
> This is a pre-existing issue, but could this initialization sequence lead
> to severe memory corruption if we are under memory pressure?

Yes, that's the whole point.

>
> macb_init_buffers() is called earlier in this function to swap to the new
> context. When initializing DMA rings, gem_init_rings() calls
> gem_init_rx_ring(), which leaves the newly allocated descriptors complete=
ly
> zeroed, and then calls gem_rx_refill().
>
> If netdev_alloc_skb() fails due to memory pressure, gem_rx_refill() abort=
s
> early:
>
>     if (unlikely(!skb)) {
>         netdev_err(bp->netdev, "Unable to allocate sk_buff\n");
>         break;
>     }

That's the main issue: gem_rx_refill() should propagate the error and
make the context swap fail. This patch exists but was part of the XDP
series. I'll take it along the ride as it's needed to make context swap
reasonable.

[...]

> > @@ -3829,9 +3987,10 @@ static int macb_set_ringparam(struct net_device =
*netdev,
> >  			      struct kernel_ethtool_ringparam *kernel_ring,
> >  			      struct netlink_ext_ack *extack)
> >  {
> > +	unsigned int new_rx_size, new_tx_size;
> >  	struct macb *bp =3D netdev_priv(netdev);
> > -	u32 new_rx_size, new_tx_size;
> > -	unsigned int reset =3D 0;
> > +	bool running =3D netif_running(netdev);
> > +	struct macb_context *new_ctx;
> > =20
> >  	if (bp->caps & MACB_CAPS_MACB_IS_EMAC)
> >  		return -EOPNOTSUPP;
> > @@ -3853,16 +4012,20 @@ static int macb_set_ringparam(struct net_device=
 *netdev,
> >  		return 0;
> >  	}
> > =20
> > -	if (netif_running(bp->netdev)) {
> > -		reset =3D 1;
> > -		macb_close(bp->netdev);
> > +	if (running) {
> > +		new_ctx =3D macb_context_alloc(bp, netdev->mtu,
> > +					     new_rx_size, new_tx_size);
>
> [Severity: High]
> Can this allocation path lead to a kernel panic and memory leak on failur=
e?
>
> When macb_context_alloc() is called here under memory pressure, it calls
> macb_alloc().
>
> In macb_alloc(), if the RX DMA allocation fails (or boundary check fails)=
,
> it jumps to the error path after allocating tx:
>
> drivers/net/ethernet/cadence/macb_main.c:macb_alloc() {
>     ...
>     if (!rx || upper_32_bits(rx_dma) !=3D upper_32_bits(rx_dma + size - 1=
))
>         goto out_err;
>     ...
> out_err:
>     macb_free(ctx);
> }
>
> At this point, txq->ring is still NULL. macb_free() will unconditionally =
call:
>
>     dma_free_coherent(dev, size, txq->ring, txq->ring_dma);
>
> Will this trigger a panic on architectures where dma_free_coherent() lack=
s
> tolerance for a NULL virtual address, and permanently leak the successful=
ly
> allocated TX DMA ring?

I don't see where dma_free_coherent() "lacks tolerance for a NULL
virtual address". That would be surprising.

However we do have a leak yes, which I plan on fixing (still unrelated
to context swapping).

>
> > +		if (IS_ERR(new_ctx))
> > +			return PTR_ERR(new_ctx);
> > +
> > +		macb_context_swap_start(bp);
> >  	}

---

Replying to net sashiko
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260812-macb-context-v=
9-0-7ddbf5f715e0%40bootlin.com

> commit c12dbce3061c66a490797075684d70f4e544b34f
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: use context swapping in .set_ringparam()
>
> This replaces the close / resize / reopen sequence in
> ethtool_ops.set_ringparam() with a context swap: a new context (rings and
> buffers) is allocated first, the datapath is quiesced via a new bp->ctx_s=
wap
> flag plus NAPI/work draining, the new context is handed to the hardware, =
and
> the old context is freed afterwards. A new mac_cfg_lock mutex serialises =
the
> swap against the phylink MAC callbacks, and a redundant bp->link_up boole=
an
> tracks link state under that mutex.
>
> A few questions below, first on the changelog and then inline in the diff=
.
>
> [Severity: Low]
> [Finding: main-1-0]
> [Sources: opus-5]
> The changelog describes the new mutex and the redundant link state boolea=
n:
>
>     Introduce a new locking primitive (mac_cfg_lock mutex) to serialise s=
wap
>     with phylink MAC callbacks. [...] so we use a redundant bp->link_up
>     boolean that is mac_cfg_lock protected.
>
> but the second new state flag, bp->ctx_swap, is not mentioned anywhere, a=
nd
> neither is the change of macb_interrupt() semantics that goes with it. Wh=
ile
> a swap is in progress the handler treats every pending cause as if the de=
vice
> were down (IDR -1, ISR clear, break), so MACB_INT_MISC_FLAGS handling and
> HRESP DMA bus errors are acknowledged and discarded for the duration of t=
he
> window.
>
> Could the changelog say a word about bp->ctx_swap and about the interrupt
> handler behaviour during the swap, since correctness of the sequence depe=
nds
> on both?

Good point, this is missing!

>
> > diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet=
/cadence/macb.h
> > index ed9bd58d2e26..35564f2ed662 100644
> > --- a/drivers/net/ethernet/cadence/macb.h
> > +++ b/drivers/net/ethernet/cadence/macb.h
>
> [ ... ]
>
> > @@ -1415,6 +1417,12 @@ struct macb {
> >  	struct delayed_work	tx_lpi_work;
> >  	u32			tx_lpi_timer;
> > =20
> > +	/* ISR must not drive NAPI & BH mechanisms. Protected by bp->lock. */
> > +	bool			ctx_swap;
> > +
> > +	/* Redundant to netif_carrier_ok(), but set under bp->mac_cfg_lock. *=
/
> > +	bool			link_up;
> > +
> >  	u32	rx_intr_mask;
> > =20
> >  	struct macb_pm_data pm_data;
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 6d79663e42bf..55c97f2035e7 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
>
> [ ... ]
>
> > @@ -2199,8 +2227,10 @@ static irqreturn_t macb_interrupt(int irq, void =
*dev_id)
> >  	}
> > =20
> >  	while (status) {
> > -		/* close possible race with dev_close */
> > -		if (unlikely(!netif_running(netdev))) {
> > +		/* close possible race with dev_close, and with context-swap
> > +		 * teardown
> > +		 */
> > +		if (unlikely(!netif_running(netdev) || bp->ctx_swap)) {
> >  			queue_writel(queue, IDR, -1);
> >  			macb_queue_isr_clear(bp, queue, -1);
> >  			break;
>
> [Severity: Medium]
> [Finding: main-5-8]
> [Sources: opus-5]
> bp->ctx_swap is set on entry to the swap region in macb_context_swap_star=
t()
> and cleared on exit in macb_context_swap_end(), purely to keep the interr=
upt
> handler away from state the swap is mutating. Is a boolean the right
> mechanism here rather than masking the per-queue IRQs?
>
> The driver already owns queue->irq, so disable_irq()/enable_irq(), or IMR
> masking plus synchronize_irq(), would enforce the exclusion instead of
> relying on the handler observing the flag.

No the masking+synchronize_irq() doesn't work. If we start context
swapping by masking interrupts, NAPI/BH is still active and might
re-arm IRQs. See how napi_rx/napi_tx/tx_error_task/hresp_task all can
enable/disable IRQs, and they are not yet disabled/cancelled.

So then we might think "we'll disable NAPI/BH features first then
disable IRQs". But that doesn't fly either! Notice how IRQs schedule
the NAPI/BH features and we can't have that if they are disabled. Eg
napi_disable on an already disabled NAPI is a deadlock.

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

The reason disable_irq()/enable_irq() doesn't work is more long term. We
also need the same "shutdown IRQs atomically" mechanism for the suspend
WOL path. In that case we need to shutdown all but one IRQ. There's the
same thing for when the interface is down. We'll use this "quiesce
IRQs" mechanism as well, but might want to keep some activated.

We're not the first ones using such a mechanism. Check out tg3 for
example and its tg3_irq_quiesce() function.
https://elixir.bootlin.com/linux/v7.2.2/source/drivers/net/ethernet/broadco=
m/tg3.c#L7488

[...]

>
> > @@ -3105,6 +3135,134 @@ static void macb_configure_dma(struct macb *bp)
> >  	}
> >  }
> > =20
> > +static void macb_context_swap_start(struct macb *bp)
> > +{
>
> [ ... ]
>
> > +	/* Must be done after napi_tx is disabled. */
> > +	cancel_delayed_work_sync(&bp->tx_lpi_work);
> > +
> > +	/* Can finally disable software Tx; need to wait until napi_tx and
> > +	 * tx_error_task cannot be scheduled as either might wakeup Tx.
> > +	 */
> > +	netif_tx_disable(bp->netdev);
>
> [Severity: High]
> [Finding: gpt-5-6-sol-5-11]
> [Sources: gpt-5-6-sol, opus-5]
> This stops all TX queues while netif_running() and the carrier both stay =
set,
> since this is an ethtool op and phylink is deliberately not stopped. Does
> that leave the netdev TX watchdog free to run during the swap?

Yes! See above (grep for "^Well actually") where I explained how we fix
this TX watchdog race. And we explicitely don't touch phylink because
we don't want any PHY retrain. Gotta go fast.

[...]

>
> > +	spin_unlock_irqrestore(&bp->lock, flags);
> > +}
> > +
> > +static void macb_context_swap_end(struct macb *bp,
> > +				  struct macb_context *new_ctx)
> > +{
> > +	struct macb_context *old_ctx;
> > +	struct macb_queue *queue;
> > +	unsigned long flags;
> > +	unsigned int q;
> > +	u32 ctrl;
> > +
> > +	lockdep_assert_held(&bp->mac_cfg_lock);
> > +
> > +	/* Swap contexts & give buffer pointers to HW. */
> > +
> > +	old_ctx =3D bp->ctx;
> > +	bp->ctx =3D new_ctx;
> > +	macb_init_buffers(bp);
>
> [Severity: Medium]
> [Finding: main-5-9]
> [Sources: opus-5]
> bp->ctx is published here with a plain store, with no bp->lock, no
> WRITE_ONCE() and no barrier, and old_ctx is dma-freed and kfree()d at the
> end of this function after mac_cfg_lock has been dropped and after NAPI,
> software TX and hardware RX/TX have been restarted.

Yes that's a mistake. Should be WRITE_ONCE() followed by mb().
All codepaths that assign bp->ctx should look like that.

Btw, I learnt something reading a good chunk of
Documentation/memory-barriers.txt: "Memory operations issued before the
ACQUIRE may be completed after the ACQUIRE operation has completed". So
here we do

   bp->ctx =3D ...;
   spin_lock(...);
   relaxed_writel(...);

And the spin_lock isn't implicitely introducing a mandatory mb. TIL.

> Every other non-rtnl reader of bp->ctx runs from hardirq, softirq or work
> context under bp->lock or queue->tx_ptr_lock, for example
> macb_tx_lpi_work_fn() -> macb_tx_all_queues_idle():
>
>     for (q =3D 0; q < bp->num_queues; ++q) {
>         txq =3D &bp->ctx->txq[q];
>
> so the safety of the swap rests entirely on the drain list in
> macb_context_swap_start() being exhaustive. The macb_tx_timeout() ->
> macb_tx_restart() path noted above is one reader that is not on it.
>
> Would doing the pointer swap under bp->lock (taken a few lines below
> anyway), and freeing old_ctx only after a synchronisation point, make tha=
t
> contract enforced rather than assumed?

No let's not do this. It is "taken a few lines below anyway" but
inbetween there's napi_enable() and it mustn't be done in bp->lock
critical section and the sequence ordering must stay as-is.

And doing the ctx write in a bp->lock critical section doesn't help
anything if in the same section we also write some MMIO registers
(taking the same example as below).

>
> > +
> > +	/* Start NAPI, HW Tx/Rx and software Tx. */
> > +
> > +	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue)=
 {
> > +		napi_enable(&queue->napi_rx);
> > +		napi_enable(&queue->napi_tx);
> > +	}
> > +
> > +	spin_lock_irqsave(&bp->lock, flags);
> > +
> > +	/* Re-arm normal interrupt processing before enabling IRQs. */
> > +	bp->ctx_swap =3D false;
> > +
> > +	macb_configure_dma(bp);
> > +
> > +	if (bp->link_up) {
> > +		for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue=
) {
> > +			queue_writel(queue, IER,
> > +				     bp->rx_intr_mask |
> > +				     MACB_TX_INT_FLAGS |
> > +				     MACB_BIT(HRESP));
> > +		}
> > +
> > +		ctrl =3D macb_readl(bp, NCR);
> > +		macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
> > +	}
>
> [Severity: Medium]
> [Finding: gpt-5-6-sol-7-14]
> [Sources: gpt-5-6-sol, opus-5]
> The descriptors for new_ctx were written earlier, in macb_context_alloc()=
 ->
> mog_init_rings(), and the ring base registers were handed over just above=
 by
> macb_init_buffers(); RE|TE are then enabled here. Is a wmb() missing betw=
een
> the descriptor stores and those register writes?

Covered above.

[...]

> > +	spin_unlock_irqrestore(&bp->lock, flags);
> > +
> > +	if (bp->link_up) {
> > +		netif_tx_wake_all_queues(bp->netdev);
> > +
> > +		if (bp->eee_active)
> > +			macb_txp_lpi_initial_defer(bp);
> > +	}
>
> [Severity: Medium]
> [Finding: main-2-3]
> [Sources: opus-5]
> bp->link_up is documented in macb.h as "Redundant to netif_carrier_ok(), =
but
> set under bp->mac_cfg_lock", and it gates both IER/RE|TE re-arming and th=
e
> TX wake here. Is macb_hresp_error_task() able to break that redundancy?

hresp_error is not even taking bp->lock to writel to the hardware. It
races against every other context in MACB. One we get in, the right
primitives will be there to fix this, as it is almost a context swap
operation (just with old_ctx free before new_ctx alloc).

[...]

Thanks,
--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

