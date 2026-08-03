Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103F4409283
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769902; cv=none; b=TZEstI3uWsMrCxI2x9TZHu75wSw6/m0NJX1ZYvpkbvvi/kNKcfp+26xzidJo/vGwWrQqEUh3ZVOzCFAKYjUzj9+77HV6ssYfLAz6ybFz6ssoSGstkN4C8Fhtl5vzI/xCfc40c0nqXrBAnq0NxtF1WmHO702EkDIAD4wXEcmFcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769902; c=relaxed/simple;
	bh=cwTw8H3Ooghe9JQlbIlOU2vfYQ+Hgal3F2VQx+HstJc=;
	h=Content-Type:Date:Message-Id:To:From:Subject:Cc:In-Reply-To:
	 References:MIME-Version; b=XGxiXQ1N9C7nOKvbSTBGqH+C1M6iAorWTdlWdFzsPecDjDdI0lu9qyYhngeHzNLndo5FdC3XP6yd/qPJcyrHnf6Cd49jS5gYmA3b1eyczjJmhbcdqUzhX1+C3pib8QjwqOiNtrvny1xxvPJKm7oEffuD2s8NwA+7UaF+OmRu8O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=w6p4ns8s; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="w6p4ns8s"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 54FDC4E410B9;
	Mon,  3 Aug 2026 15:11:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 25F2D6029B;
	Mon,  3 Aug 2026 15:11:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 23FFF11C30FDF;
	Mon,  3 Aug 2026 17:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785769895; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qLX9wRFjFE7qhEodLkyDzpDCN7Wclzx+yq56b7aCTEU=;
	b=w6p4ns8sCly6RBnj2PZoW1nBacAXXYwC0rSlyrSbwdzOI1L4b0zi0hZnIDVAxLvKQMem+Q
	59ynWOYxzDH3GjIUH5QFRWFuac1TTsDgXDDKZhbwkg4tgKQYWTs3CWQT8ofHyiawSqsYOk
	tvOHe6VI1xCwvAzlJvLzp7V7DmelOqwSbyd/FLzOvlcNtUUM7NJs3HhIYm+hTW9z4SIuK9
	qfDGH10DmIG2jPrU7d+tYWXoQPbu4UpgZUpox61XzGXZ/2ksSnX1Pb4rMO1yhXO+kClp62
	wJLuAn1pDfShymUQLhVh/zdPBQiQbAgFvVbUf9Shwwik/q1snhcnyvv6/0faPw==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 17:11:29 +0200
Message-Id: <DKFELDU6EGAJ.2CO5UDMWMHNW0@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v6 07/16] net: macb: introduce macb_context
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
In-Reply-To: <20260731-macb-context-v6-7-49d5a1439d48@bootlin.com>
References: <20260731-macb-context-v6-7-49d5a1439d48@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: mC/LAB5bGbA0
X-Last-TLS-Session-Version: TLSv1.3

Replying to net sashiko
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731-macb-context-v=
6-0-49d5a1439d48%40bootlin.com

> commit 4cc5f75700ce9248e0d2a9728229a16b10ce9942
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: introduce macb_context struct for buffer management
>
> This moves all per-queue ring/buffer state and the ring size parameters o=
ut
> of struct macb / struct macb_queue into a new struct macb_context that is
> allocated in macb_open() / at91ether_open() and freed in the close paths.
> The ring sizes requested by userspace are now remembered in
> bp->configured_{rx,tx}_ring_size, and all data path code reaches its
> buffers through bp->ctx.
>
> A few questions below.
>
> > diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet=
/cadence/macb.h
> > index 9857df5b57f09..452b2c8f8641f 100644
> > --- a/drivers/net/ethernet/cadence/macb.h
> > +++ b/drivers/net/ethernet/cadence/macb.h
> > @@ -1272,21 +1272,10 @@ struct macb_queue {
> > =20
> >  	/* Lock to protect tx_head and tx_tail */
> >  	spinlock_t		tx_ptr_lock;
> > -	unsigned int		tx_head, tx_tail;
> > -	struct macb_dma_desc	*tx_ring;
> > -	struct macb_tx_skb	*tx_skb;
> > -	dma_addr_t		tx_ring_dma;
> >  	struct work_struct	tx_error_task;
> >  	bool			txubr_pending;
> >  	struct napi_struct	napi_tx;
> > =20
> > -	dma_addr_t		rx_ring_dma;
> > -	dma_addr_t		rx_buffers_dma;
> > -	unsigned int		rx_tail;
> > -	unsigned int		rx_prepared_head;
> > -	struct macb_dma_desc	*rx_ring;
> > -	struct sk_buff		**rx_skbuff;
> > -	void			*rx_buffers;
> >  	struct napi_struct	napi_rx;
> >  	struct queue_stats stats;
> >  };
>
> [Severity: Low]
> [Finding: main-2-2]
> [Sources: opus-5]
> This isn't a bug, but the comment above tx_ptr_lock in struct macb_queue
> still says:
>
> 	/* Lock to protect tx_head and tx_tail */
>
> while tx_head and tx_tail are removed from that struct by this hunk. The
> protected fields are now head and tail in struct macb_txq, living in the
> separately allocated bp->ctx->txq[q]. Should the comment be updated to na=
me
> where the protected state now lives, given the lock and the data it prote=
cts
> are in two objects with different lifetimes?

Agreed. Changing to the following for clarification.

   /* Lock to protect ctx->txq[q].head and ctx->txq[q].tail */

If we grep for tx_head we still find:

 - tx_head stack variable in macb_tx_map(). Leaving alone.

 - A printk() call in macb_start_xmit(), changing from

      netdev_dbg(netdev, "tx_head =3D %u, tx_tail =3D %u\n",
                 txq->head, txq->tail);

   to

      netdev_dbg(netdev, "txq head =3D %u, txq tail =3D %u\n",
                 txq->head, txq->tail);

> > @@ -3674,8 +3761,8 @@ static void macb_get_ringparam(struct net_device =
*netdev,
> >  	ring->rx_max_pending =3D MAX_RX_RING_SIZE;
> >  	ring->tx_max_pending =3D MAX_TX_RING_SIZE;
> > =20
> > -	ring->rx_pending =3D bp->rx_ring_size;
> > -	ring->tx_pending =3D bp->tx_ring_size;
> > +	ring->rx_pending =3D bp->configured_rx_ring_size;
> > +	ring->tx_pending =3D bp->configured_tx_ring_size;
> >  }
>
> [Severity: Low]
> [Finding: main-2-0]
> [Sources: opus-5]
> Does this report ring sizes that at91ether devices never use?
>
> emac_config sets MACB_CAPS_MACB_IS_EMAC and .init =3D at91ether_init, whi=
ch
> installs netdev->ethtool_ops =3D &macb_ethtool_ops, so .get_ringparam =3D
> macb_get_ringparam and .set_ringparam =3D macb_set_ringparam are reachabl=
e on
> those devices. macb_probe() now unconditionally sets
> configured_rx_ring_size / configured_tx_ring_size to
> DEFAULT_RX_RING_SIZE / DEFAULT_TX_RING_SIZE, so ethtool -g reports 512/51=
2.
>
> But at91ether_open() only does kzalloc_obj() for bp->ctx and never copies
> bp->configured_* into ctx->rx_ring_size / ctx->tx_ring_size (they stay 0)=
,
> and the at91ether path hard-codes its ring size in
> at91ether_alloc_coherent() / at91ether_start() / at91ether_rx():
>
> 	rxq->ring =3D dma_alloc_coherent(&bp->pdev->dev,
> 				       (AT91ETHER_MAX_RX_DESCR *
> 					macb_dma_desc_get_size(bp)),
> 				       &rxq->ring_dma, GFP_KERNEL);
>
> with AT91ETHER_MAX_RX_DESCR =3D=3D 9. Before this patch the callback retu=
rned
> bp->rx_ring_size, which was only set by macb_init_dflt() and so reported =
0
> for at91ether. Now it reports 512, and ethtool -G on a down at91ether
> interface stores the new value and returns success while nothing in the
> at91ether path consults it. Should macb_ethtool_ops leave these callbacks
> out for MACB_CAPS_MACB_IS_EMAC, or should at91ether_open() set
> ctx->rx_ring_size / ctx->tx_ring_size to what it actually allocates?

So to clarify those paragraphs, on EMAC:
 - RX:
    - Ring buffer size is 9.
    - Before we reported rx_ring_size=3D0 to userspace.
    - Now we report rx_ring_size=3D512 to userspace.
 - TX:
    - No ring buffer so 1.
    - Before we reported rx_ring_size=3D0 to userspace.
    - Now we report rx_ring_size=3D512 to userspace.
 - The message mentions that `ethtool -G` now changes the value without
   error but nothing uses it in the EMAC case. That was already true
   previously, it didn't change.

To my eyes we need two changes:
#1. Report proper value to userspace, by setting
    bp->configured_{rx,tx}_ring_size at probe to hardcoded values if EMAC.
#2. Refuse set_ringparam op if EMAC. I looked at all other
    macb_ethtool_ops wondering if we'd be better off with a different
    vtable, but no. Those are the only broken ones on EMAC.

Part #1 can be squashed into this commit (which introduces
bp->configured_*) but part #2 deserves its separate patch.

I want to acknowledge I'm already at 16 out of 15 max patches in net
land. I see nothing I can split up easily, and most of the code is well
reviewed already. I'll still append new patch as the doc seems to
indicate it is a soft rule:

> Avoid sending series longer than 15 patches.

I don't see many other options. Even if I sent part #2 standalone I'd
still be at 16 patches. Please tell me if I'm wrong in this!

Thanks,

--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
