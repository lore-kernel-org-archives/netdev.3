Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C3E30AABE;
	Mon,  3 Aug 2026 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771049; cv=none; b=BVVSpQFxQ2pnVd+U6XIonyi10m4ZGuoILlCZLnzF1St4X6LQ5xWkxJBJ2aoKgNq1x5MrAP6lQ5Ycvx1M4h6f9wPdAMnXOjh7stoE8ij2QPNeGFXg30PvsyprzXAs3tHo1uy6cMt1aXdvaZa6LYKeepRpY5upFFpKdrp4yZp0sHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771049; c=relaxed/simple;
	bh=qeLDm/Ban+yDKg9REViCMOoKu1GW505e2bASqiZvymI=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:In-Reply-To:
	 References:MIME-Version; b=CZKan0/4Sm9ZddCRjfuouWzq+0qBLtAr0IzkncXwzrDhLkc8fs7clgt4eWqhd2KTRH0YhljLgj180IdmsWTYYNlGDnMsw5RtAL/cXTuImTtNOCvRXFGU6d2RpUwjQDBR0lrGuyPUgDAcN4J4QQMOqT9VYZ7j5dPKQMfrHv07FYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ps++XH0x; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ps++XH0x"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D3AA21A13D3;
	Mon,  3 Aug 2026 15:30:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A5B056029B;
	Mon,  3 Aug 2026 15:30:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D583311C31080;
	Mon,  3 Aug 2026 17:30:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785771042; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DeD9PgnjK1ZGXim42dPmq/2bT7mUFkRJNcQAOf1ebYc=;
	b=Ps++XH0xAcQ//98BNL4AOpRfTd4K10EGzrAqE4JdE+ewMUMTXCE9SOz364BnxbF/zN92SR
	jUahqBMEBnVUPRJih4tbyNFWE/2LFjlUv4+pA5bbOyZDi3oGGtAIvvmaFEF1dsUS3P8cIo
	f2VhJn7lqdiT2uOMs3K/qn6qAOQ6L7p7x7L7wOn7lR3BLoKpZfGEixxcANx88LYAT1NjJ3
	NT7FY8x6QYae0u5m4fEDRZ5p3nvzcWgegA7imfwAuKmUw+DPOmule2s+JteRPOKuVw2qI5
	wN53DCTIVKARN61zVZ5Jl7reWjaKksHjJ38R1Qtd6e575pe5+B+6KjiJdFO/qQ==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 17:30:37 +0200
Message-Id: <DKFF0170T6H2.18I5BAQ9ZR3XV@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v6 11/16] net: macb: change function signatures
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
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>
In-Reply-To: <20260731-macb-context-v6-11-49d5a1439d48@bootlin.com>
References: <20260731-macb-context-v6-11-49d5a1439d48@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: HZX2O44ETRZd
X-Last-TLS-Session-Version: TLSv1.3

Replying to net sashiko
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731-macb-context-v=
6-0-49d5a1439d48%40bootlin.com

> commit 8d7bc94670a7294669d008889ae3d43a6f139a9f
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: change function signatures to take contexts
>
> This converts the macb ring/descriptor helpers and the alloc/free/init
> paths so they take a struct macb_context *ctx (plus a queue index where a
> struct macb_queue * was used) instead of struct macb *bp, in preparation
> for having more than one context around. Callers in the normal datapath
> now latch bp->ctx into a local variable and pass it down.
>
> A few questions below about the conversion.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 97c8374317ceb..8f8c952ffc74a 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
>
> [ ... ]
>
> > @@ -1233,14 +1238,15 @@ static int macb_halt_tx(struct macb *bp)
> >  					bp, TSR);
> >  }
> > =20
> > -static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb,=
 int budget)
> > +static void macb_tx_unmap(const struct macb_info *info,
> > +			  struct macb_tx_skb *tx_skb, int budget)
>
> [Severity: Low]
> [Finding: fable-5-1-2]
> [Sources: fable-5, opus-5]
> The commit message presents an exhaustive enumeration:
>
>     Full list:
>
>        macb_adj_dma_desc_idx()
>        macb_tx_ring_wrap()
>        ...
>        macb_init_rings()
>
> macb_tx_unmap() also changes signature here, and all of its call sites ar=
e
> updated (macb_tx_error_task(), macb_tx_complete(), macb_tx_map() pass
> &bp->info, macb_free() passes ctx->info), but it is not in that list.
>
> It is also the one converted helper that does not follow the stated rule:
>
>     To reduce bug surface area, taint those functions to *only* take a
>     context `struct macb_context *ctx` and no `struct macb *bp`.
>
> macb_tx_unmap() takes const struct macb_info *info instead. Could the lis=
t
> be extended and the macb_info choice mentioned, so the exception is
> explicit?

macb_tx_unmap() should have been updated in [10/16] rather than [11/16].
I'm surprised the LLM didn't notice that; probably has a rather limited
view of the series, on purpose. Fixed for next revision.

> > @@ -5026,7 +5051,7 @@ static int at91ether_alloc_coherent(struct macb *=
bp)
> > =20
> >  	rxq->ring =3D dma_alloc_coherent(&bp->pdev->dev,
> >  				       (AT91ETHER_MAX_RX_DESCR *
> > -					macb_dma_desc_get_size(&bp->info)),
> > +				       macb_dma_desc_get_size(&bp->info)),
> >  				       &rxq->ring_dma, GFP_KERNEL);
>
> [Severity: Low]
> [Finding: fable-5-1-2]
> [Sources: fable-5, opus-5]
> This hunk changes only leading whitespace, nothing on the line is affecte=
d
> by the context conversion, and it is not mentioned in the commit message.
> The new indentation also no longer lines up with the open parenthesis of
> (AT91ETHER_MAX_RX_DESCR *, which the original did. Could this hunk be
> dropped?

Removed.

Thanks,

--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
