Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45A53C7691;
	Thu, 15 Oct 2026 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076154; cv=none; b=iCta/OoJiBfy0qaOJzk+gq7CRVM/WQIZeVmC/EWi+SX4dt3n14oPmcyYvKJNkLbxJQ4kHWmEFs0DtdGlORSzCwa8sMbXo59M5z7khy89JaHkCw9NceBI73BNxKnbmWIkKV+hMdNrZmIjIWvUQac9Q/v257B11B9XbQjsnQ0Tmss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076154; c=relaxed/simple;
	bh=isTx+LcjmaCHQgev7fAtrM+MMsNdOS5pmRApLXi6U+8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=cu1HahLfEcV2NRweZJTiEgOKjh6gm7O0LNx9/QefqUcPk8QQHbPl9JsniDIGNDIQTKvpxEntm8UZ7lIzKdD5bFFa0ZHAtxsa/ND1tkp6yLK39vV6/40OBEtyFRU9AjUlwpWpn2W2Brp2YeEw9aAPMmPL6m/JVv+LcSJmoo/OXxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jz8BQxKV; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jz8BQxKV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 543154E41246;
	Thu, 15 Oct 2026 14:55:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1055560360;
	Thu, 15 Oct 2026 14:55:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F334C10328C54;
	Thu, 15 Oct 2026 16:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792076139; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3o2WyvmLOWDgHDolqDTUEuVR4bEKLVuPPY7sUcOTkPc=;
	b=Jz8BQxKVdqOLLlq3WjuPLlipK5Y3jyE6xENVb3MtUfy3ugSaSSk+WrKBUSV5ckH+YJFMse
	SoAQ8wgOLPoRenVpl91yNXxZSF8Mk6lVNSymebIf1aZysZGeVJYtojQp0b0LKS0oycPqdI
	zxuF2Tc9SYAlW3nXHMbW5y1ZNhb5o3Ztid72v5m271YJneexLNO5CZ2R2R8p+YW+/Ir5zc
	cfj02nhNPLRRrJfvpVD0EWZQu2M+q2fWLz0WXJCabHdIH3dAeSbtq/PELjmx5nSIFXagbY
	EO0aryxzwlBYTNxakBji+zYeNvaAWGeYhdxj0zfo7H9+j38sAjB3uSpZQEE4sg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 16:55:32 +0200
Message-Id: <DM5HYXXJV8GS.1IX8XO5IECV35@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v11 0/9] net: macb: implement context swapping
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Paolo
 Valerio" <pvalerio@redhat.com>, "Nicolai Buchwitz" <nb@tipi-net.de>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <stable+noautosel@kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
In-Reply-To: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Th=C3=A9o,

Sashiko has 4 high comments, Clashiko has 3 low comments.

TL;DR: nothing worth a respin because it is all out of scope.

https://sashiko.dev/#/patchset/20261013-macb-context-v11-0-b27785167566%40b=
ootlin.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013-macb-context-v=
11-0-b27785167566%40bootlin.com

> commit 0eff5390c4748a085f669ce98d1bc433c0f36ace
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> net: macb: introduce macb_context struct for buffer management
>
> This commit introduces a macb_context structure to own all queue
> buffers and parameters, paving the way for supporting multiple contexts
> in parallel during buffer reallocation. It updates ring parameters and
> moves related fields out of the main macb struct into the context struct.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> [ ... ]
> > @@ -2741,60 +2789,71 @@ static void gem_free_rx_buffers(struct macb *bp=
)
> [ ... ]
> >  static unsigned int macb_tx_ring_size_per_queue(struct macb *bp)
> >  {
> > - return macb_dma_desc_get_size(bp) * bp->tx_ring_size + bp->tx_bd_rd_p=
refetch;
> > + return macb_dma_desc_get_size(bp) * bp->ctx->tx_ring_size +
> > +    bp->tx_bd_rd_prefetch;
> >  }
>
> [Severity: High]
> Can this dereference a NULL pointer if the context was freed?
>
> If macb_open() fails, it now frees bp->ctx and leaves it NULL. Later, if
> the interface is closed and macb_free() calls this function:
>
> macb_close() -> macb_free() -> macb_tx_ring_size_per_queue()
>
> This will dereference bp->ctx.

Sashiko says there is an issue with a macb_open() failing followed by a
macb_close(). Indeed, but the interface won't be closed if its open
operation failed.

>
> [ ... ]
> > @@ -3856,8 +3946,8 @@ static int macb_set_ringparam(struct net_device *=
netdev,
> >      macb_close(bp->netdev);
> >   }
> >
> > - bp->rx_ring_size =3D new_rx_size;
> > - bp->tx_ring_size =3D new_tx_size;
> > + bp->configured_rx_ring_size =3D new_rx_size;
> > + bp->configured_tx_ring_size =3D new_tx_size;
> >
> >   if (reset)
> >      macb_open(bp->netdev);
> >
> >   return 0;
> >  }
>
> [Severity: High]
> Should we be checking the return value of macb_open() here?
>
> If macb_open() fails, it frees bp->ctx. However, this function
> unconditionally returns 0, masking the failure and leaving the device in
> an UP state in the network stack.
>
> A subsequent interface down event will trigger macb_close(), which calls
> macb_free(), resulting in the NULL pointer dereference in
> macb_tx_ring_size_per_queue() noted above.

We ignore that on purpose. Check out the last two commits. The whole
point of this series is to introduce context swapping, to fix the
set_ringparam operation (and others).

---

> commit b435a89b7b7a33cd5d0880d8a83b893da802f106
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: change function signatures to take contexts
>
> This commit changes many function signatures in the MACB driver to take a
> macb_context pointer instead of macb or macb_queue. This refactoring prep=
ares
> the driver for supporting parallel MACB contexts while reducing the bug
> surface area by preventing the use of the wrong context.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> [ ... ]
> >   for (tail =3D txq->tail; tail !=3D txq->head; tail++) {
> >      u32   ctrl;
> >
> > -    desc =3D macb_tx_desc(queue, tail);
> > +    desc =3D macb_tx_desc(ctx, q, tail);
>
> [Severity: High]
> Does this traversal and unmapping of the TX ring lack necessary synchroni=
zation?
>
> When macb_tx_error_task is triggered in a workqueue due to a TX error, it
> calls netif_tx_stop_all_queues(). This sets QUEUE_STATE_DRV_XOFF but does
> not wait for a concurrent macb_start_xmit on another CPU.

This is out of scope. We ignore suspend, the HRESP error task and the TX
error task on purpose.

[...]

> >      ctrl =3D desc->ctrl;
> >      tx_skb =3D macb_tx_skb(queue, tail);
> >      skb =3D tx_skb->skb;
> [ ... ]
> >   netif_tx_stop_all_queues(netdev);
> >   netif_carrier_off(netdev);
> >
> > - bp->macbgem_ops.mog_init_rings(bp);
> > + bp->macbgem_ops.mog_init_rings(ctx);
>
> [Severity: High]
> Could this ring reinitialization lead to a use-after-free or data corrupt=
ion?
>
> When a hardware HRESP error triggers macb_hresp_error_task via system_bh_=
wq,
> mog_init_rings is called to reset ring pointers and reallocate SKB arrays=
.
> However, it does not appear to synchronize with software datapath operati=
ons
> using napi_disable() and spin_lock(&queue->tx_ptr_lock).

This is out of scope. We ignore suspend, the HRESP error task and the TX
error task on purpose.

[...]

---

> commit c7aa30e3b67cf259fbc73811fb17ffc27d9be6eb
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
>     net: macb: use context swapping in .set_ringparam()
>
> This patch introduces a context swapping mechanism for macb's set_ringpar=
am
> ethtool operation. It avoids freeing buffers during interface close and
> reallocating them on open, instead pre-allocating a new context to preven=
t
> failures under memory pressure. The swap logic is synchronized against MA=
C
> callbacks and NAPI execution using a new mac_cfg_lock mutex and the quies=
ce
> state.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 32a24c91c045a..6bacf3e3caabb 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> [ ... ]
> > @@ -2010,29 +2038,37 @@ static int macb_rx_poll(struct napi_struct *nap=
i, int budget)
> >
> >  static void macb_tx_restart(struct macb_queue *queue)
> >  {
> > - struct macb_context *ctx =3D queue->bp->ctx;
> > - struct macb_txq *txq =3D macb_txq(queue);
> >   struct macb *bp =3D queue->bp;
> >   unsigned int head_idx, tbqp;
> > + struct macb_context *ctx;
> > + struct macb_txq *txq;
> >   unsigned long flags;
> >
> >   spin_lock_irqsave(&queue->tx_ptr_lock, flags);
> >
> > + spin_lock(&bp->lock);
> > +
> > + /* context swap ongoing? */
> > + if (bp->irq_quiesced)
> > +    goto out_unlock;
> > +
> > + ctx =3D queue->bp->ctx;
> > + txq =3D macb_txq(queue);
> > +
> >   if (txq->head =3D=3D txq->tail)
> > -    goto out_tx_ptr_unlock;
> > +    goto out_unlock;
>
> [Severity: High]
> Does macb_tx_error_task() in drivers/net/ethernet/cadence/macb_main.c als=
o
> need to acquire queue->tx_ptr_lock when updating txq->head and txq->tail?

This is out of scope. We ignore suspend, the HRESP error task and the TX
error task on purpose.

[...]

---

> commit 59119f040d96bc1d81d6e0708a9c738cad768fcd
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: use context swapping in .set_ringparam()
>
> The old close/reopen sequence in macb_set_ringparam() is replaced. A new
> context with the requested ring sizes is now allocated before the
> interface is stopped, and it is swapped in with the new helpers
> macb_context_swap_start() and macb_context_swap_end(). A new mac_cfg_lock
> mutex serializes the swap against the phylink MAC callbacks, and a new
> bp->link_up boolean tracks link state under that lock.
>
> > diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet=
/cadence/macb.h
> > index ec2e2fbc1146a..b7b4b6a382980 100644
> > --- a/drivers/net/ethernet/cadence/macb.h
> > +++ b/drivers/net/ethernet/cadence/macb.h
>
> [ ... ]
>
> > @@ -1419,10 +1421,13 @@ struct macb {
> >   u32         tx_lpi_timer;
> >
> >   /* ISR must not drive NAPI & BH mechanisms. True when the interface
> > -  * is closed. Protected by bp->lock.
> > +  * is closed or during context-swap. Protected by bp->lock.
> >    */
> >   bool        irq_quiesced;
> >
> > + /* Redundant to netif_carrier_ok(), but set under bp->mac_cfg_lock. *=
/
> > + bool        link_up;
>
> [Severity: Low]
> [Finding: main-2-3]
> [Sources: opus-5-5]
> Is the "redundant to netif_carrier_ok()" claim accurate?
> macb_hresp_error_task() changes the carrier and the hardware enable bits
> without taking mac_cfg_lock, and it never reads or updates bp->link_up:

Technically the "Redundant to netif_carrier_ok()" phrase is wrong yes
but I hope it is evident that if it was actually redundant, we wouldn't
have introduced a separate flag.

Fixing the many known races inbetween the HRESP task and the rest of the
driver execution is out of scope of this series.

[...]

> > @@ -3995,16 +4140,20 @@ static int macb_set_ringparam(struct net_device=
 *netdev,
> >      return 0;
> >   }
> >
> > - if (netif_running(bp->netdev)) {
> > -    reset =3D 1;
> > -    macb_close(bp->netdev);
> > + if (running) {
> > +    new_ctx =3D macb_context_alloc(bp, netdev->mtu,
> > +                  new_rx_size, new_tx_size);
> > +    if (IS_ERR(new_ctx))
> > +       return PTR_ERR(new_ctx);
> > +
> > +    macb_context_swap_start(bp);
> >   }
> >
> >   bp->configured_rx_ring_size =3D new_rx_size;
> >   bp->configured_tx_ring_size =3D new_tx_size;
>

[... pre existing finding ...]

>
> >
> > - if (reset)
> > -    macb_open(bp->netdev);
> > + if (running)
> > +    macb_context_swap_end(bp, new_ctx);
> >
> >   return 0;
> >  }
>
> [Severity: Low]
> [Finding: gpt-6-astra-1-2]
> [Sources: gpt-6-astra, opus-5-5]
> The code change looks correct, but the commit message describes the old
> behaviour only as:
>
>   Under memory pressure this does not fly: we free our buffers at close
>   and cannot reallocate new ones at open.

I've cut the rambling. The point here is that the commit message is
somewhat underselling what we gain from context swapping. I couldn't
agree more, context swapping is great!

Clashiko wants to point out all the advantages and add a Fixes trailer.
I consider all that useless and see this patch as a new feature rather
than a bugfix.

[...]

---

> commit 9410fd54d1f3a19a62c932c210f14be133012c06
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: use context swapping in .ndo_change_mtu()
>
> This patch makes macb_change_mtu() handle a running interface by swapping
> contexts: it allocates a new context sized for the new MTU, quiesces and
> reconfigures the hardware, then frees the old context. Before this, the
> function returned -EBUSY. AT91 EMAC devices are rejected defensively, sin=
ce
> they use a separate ndo struct and should never reach this path.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 6bacf3e3caabb..f087f278f9e56 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -3658,11 +3658,29 @@ static int macb_close(struct net_device *netdev=
)
> >
> >  static int macb_change_mtu(struct net_device *netdev, int new_mtu)
> >  {
> > - if (netif_running(netdev))
> > -    return -EBUSY;
> > + struct macb *bp =3D netdev_priv(netdev);
> > + bool running =3D netif_running(netdev);
> > + struct macb_context *new_ctx;
> > +
> > + if (running) {
> > +    /* Context swapping is not supported for AT91. */
> > +    if (bp->caps & MACB_CAPS_MACB_IS_EMAC)
> > +       return -EBUSY;
>
> [Severity: Low]
> [Finding: main-2-0]
> [Sources: opus-5-5]
> This isn't a bug, but should this comment say "AT91 EMAC" instead of
> "AT91"?
>
> MACB_CAPS_MACB_IS_EMAC is set only by emac_config. Other AT91-family
> configs, such as at91sam9260_config, sama5d2_config and sama5d3_config,
> don't set it. Those parts use macb_netdev_ops, so they do get context
> swapping on a live MTU change. The commit message already says "AT91 EMAC=
".

On this one, I agree: AT91 is confusing, the proper way to describe the
old IP we support would be 'EMAC' or 'RM9200' (only board we support
that uses that IP revision).

I won't respin just for this comment tweak. If we wanted to fully remove
the confusion, we would also rename all functions from at91ether_* to
something else, like macb_emac_* or something of the sort. This feels
out of scope.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

