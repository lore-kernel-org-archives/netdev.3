Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166D30C171
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509766; cv=none; b=t3GFRIzlpYCBXTjU01Q5pPNkZfY57MZLYTMpdLqIGf+kVT8ykGUd3PMw+Vv3vTzxtHwBqgknXYmtI6CNavonvAc6pQ+Q/b6Rt3O6duSc57OHnW7/LYapsyyjT0SQeFUwMLCO//Sfrww0ZO8ehsJjT4VS1dTa0GY1bJ27kII5jX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509766; c=relaxed/simple;
	bh=YRLPL1fQZ3elyozwsGT3zRFNOzYDTllo2fchpZ8dDfQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=kHnrrWmLGhh0shEDYNWN9UFezTyCUgPLEcRq93TbXRLN2BuvXOe37DETHXg5fWfMac8bCZ5PmNoGIPQ90aZCeVfCEZnMwIThhGiEQ7cdZW4TkJZAirf+vGRfGhYTE5Fgdzez+rGLI5AbQQY8uT3wss91oHC3FsvNIOcKNMu4boU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bk+oqqQd; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bk+oqqQd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C17384E41054;
	Fri, 31 Jul 2026 14:56:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 77B596039A;
	Fri, 31 Jul 2026 14:56:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F31A311C16986;
	Fri, 31 Jul 2026 16:55:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785509760; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cnIilfgi6+eLV0SGWaaO2Nc2/1+vmHhdyz8W1SqOMbQ=;
	b=Bk+oqqQdZB/QyhR96cKZqbpCBYu7aqbQXJbioJQYbPmXOiCg4TC/OWYEq/dZAhtqyElnyI
	cwVGSt34J5/fS2fuNFFjHDNW1aQV+Ah41uvR9ogYKciZ13AKhAYkWVfQ8prphzk3Gj4RoI
	k8efaghqO/FU/ygmR/L/kIKZ4ZFHLL+jdgrJNHVlLrv3GAV2u844DdOqcKZt/o351dBJkn
	ghBA0ZAVVOu5IgtdA86IqNdQA7n1tqGHzn8+ixHSFapEnsk48sRPGrHDCdUhCKN/94h1CR
	MXUu8wZiKrLiKGokmTE/TPigwvdENg9K9HavbtpR6/+iH6vRQqtCYHCJVhm/XQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 16:55:55 +0200
Message-Id: <DKCUDTZK4HJS.1Q0JH3CNPYF4G@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v5 11/15] net: macb: change function signatures
 to take contexts
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Paolo Valerio" <pvalerio@redhat.com>, "Nicolai
 Buchwitz" <nb@tipi-net.de>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
 <20260724-macb-context-v5-11-569b1852bc7f@bootlin.com>
In-Reply-To: <20260724-macb-context-v5-11-569b1852bc7f@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

Replies to Sashiko reviews (only those that aren't about pre-existing
issues).

On this patch, only from sashiko.dev:
https://sashiko.dev/#/patchset/20260724-macb-context-v5-0-569b1852bc7f%40bo=
otlin.com

> > @@ -186,40 +188,42 @@ static struct macb_tx_skb *macb_tx_skb(struct mac=
b_queue *queue,
> >  {
> >   struct macb_txq *txq =3D macb_txq(queue);
> >
> > - return &txq->skb[macb_tx_ring_wrap(queue->bp, index)];
> > + return &txq->skb[macb_tx_ring_wrap(queue->bp->ctx, index)];
>
> [Severity: Medium]
> Will this continue to dynamically evaluate queue->bp->ctx instead of
> accepting the context parameter? It looks like this leaves a mixed refere=
nce
> which might defeat the refactoring goal of avoiding bugs from using bp->c=
tx
> instead of ctx.

The main goal of refactoring to take ctx (+ queue index) is that, on
transition states, we cannot mess up the buffers we access.

The macb_tx_skb() function is by definition a function that is only
called in places where the interface must be up and running. Changing
its signature would require passing a queue index and that means a tiny
bit more code in the 11 calling locations without any safety benefit.

> > @@ -1620,6 +1631,8 @@ static int gem_rx(struct macb_queue *queue, struc=
t napi_struct *napi,
> >        int budget)
> >  {
> > + unsigned int q =3D queue - queue->bp->queues;
> > + struct macb_context *ctx =3D queue->bp->ctx;
> >   struct macb_rxq *rxq =3D macb_rxq(queue);
> >   struct macb *bp =3D queue->bp;
>
> [Severity: Medium]
> Can this cause a mismatch in size when processing descriptors later in
> the function? Since dma_unmap_single() uses bp->ctx->rx_buffer_size
> instead of ctx->rx_buffer_size:
>
> gem_rx() {
>     ...
>     dma_unmap_single(&bp->pdev->dev, addr,
>                      bp->ctx->rx_buffer_size, DMA_FROM_DEVICE);
>
> Could this lead to wrong DMA unmap sizes if a concurrent swap modifies
> bp->ctx?

I like this review: our function signature bp to ctx rework is aimed at
avoiding those exact bugs. But here, no possible issue. We don't allow
concurrent swaps.

gem_rx() can only be called when a single context exists. Only functions
which might be called at a timeframe where two contexts might be alive
need to be careful about the context they use.

> > @@ -2358,14 +2381,14 @@ static unsigned int macb_tx_map(struct macb *bp=
,
> >   do {
> >      i--;
> >      tx_skb =3D macb_tx_skb(queue, i);
> > -    desc =3D macb_tx_desc(queue, i);
> > +    desc =3D macb_tx_desc(ctx, q, i);
> >
> >      ctrl =3D (u32)tx_skb->size;
> >      if (eof) {
> >         ctrl |=3D MACB_BIT(TX_LAST);
> >         eof =3D 0;
> >      }
> > -    if (unlikely(macb_tx_ring_wrap(bp, i) =3D=3D
> > +    if (unlikely(macb_tx_ring_wrap(ctx, i) =3D=3D
> >            bp->ctx->tx_ring_size - 1))
> >         ctrl |=3D MACB_BIT(TX_WRAP);
>
> [Severity: Medium]
> Does mixing the explicit ctx and bp->ctx in the same bounds calculation
> create a time-of-check to time-of-use race? If the context sizes ever dif=
fer
> due to a concurrent context swap, could this lead to buffer overflows by
> failing to set TX_WRAP?

Again, same reasoning. macb_tx_map() cannot be called in a timeframe
where two contexts are alive.

I'll clarify the commit message to avoid the confusion.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

