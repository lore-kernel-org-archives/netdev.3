Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686513E557B;
	Wed,  5 Aug 2026 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924128; cv=none; b=S4GZYMptd6Q6OTs3eU1lEdB9mgg4AEmiyRGa/EM0sqtc9guth7ObohD28IyJBlxP8Zns/KjpBnqs7+gTwglOqqKEpmqFKgBnOOe0PcyA7rJqv3uqrfhqFUPST/cvd1rGaFGV+t21F2+ylKOZmSpdRY+d7zloFFIuoz8RtkAdXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924128; c=relaxed/simple;
	bh=wsRuP2F1AJQLteHOzECEwrN1aDO5dGC2lKn8vtas/Zs=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:In-Reply-To:
	 References:MIME-Version; b=gUdkRIn7qg/RrgtZglMuT0Q8g5U+PfhqCdPt+NRPjgAyVvpW8J83KvCrEG8H0KZuPBGvcNvR6SlV2l/OKPrOQK4vX2ostAqSXSEReHMff/x0LZedRHbbsF6JAay+YM79sAkgtNolaO2OYiFTsU6v+kGJiWloyWRTVePjoKwQJo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aAGTYWze; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aAGTYWze"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B90511A142E;
	Wed,  5 Aug 2026 10:02:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 82AF0602AB;
	Wed,  5 Aug 2026 10:02:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0BD211C34675;
	Wed,  5 Aug 2026 12:01:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785924121; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HjCGnXHlnjC+p0DIkgkmZBlOGK4OoMDGUrMCSECHQMg=;
	b=aAGTYWzeDfAfDy7aOyUnOzajzG/xWE3ckMKodcnrT3R4fkvK6uwpWePE/DTCUX1YolUu+N
	U5GUCIEXeLBhR3jZWGB1tdh1kWJqCSY6hDfUCGDotRve2QovyrDRI2gzj1xEGmMq53mthO
	TfJjhqs/FG58COJWbiwm0A+Kt07Nz8nO39v1ePP7THiEBbtxBp0RrZbtpWkJ8h42asBpOY
	BBUzcdLO8xjZB62i0uannfY1gUJsSHenI/qG4PlaWSr4PYZFzMOfq++TrBTWQ6vcoajErU
	Boc3RHxTbi1qCi03SsX/+sgbDZ2QBMVkaxf0Yz1sUj7L7KQO9gZVzOOdbfiAeA==
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 12:01:55 +0200
Message-Id: <DKGX9G3R5L6Q.1FNC63JL9OF4H@bootlin.com>
Subject: Re: [PATCH net-next v7 14/17] net: macb: move printk() calls out of
 bp->lock critical section
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
In-Reply-To: <20260803-macb-context-v7-14-4d7d4af04849@bootlin.com>
References: <20260803-macb-context-v7-14-4d7d4af04849@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: mosvbmn41ptX
X-Last-TLS-Session-Version: TLSv1.3

Replying to sashiko
https://sashiko.dev/#/patchset/20260803-macb-context-v7-0-4d7d4af04849%40bo=
otlin.com

> commit 236ca85ec182e174ae2b672ce495a29216642196
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: move printk() calls out of bp->lock critical section
>
> This patch moves printk() calls outside of the bp->lock critical section =
in
> the macb driver to prevent deadlocks with netconsole. It defers the error
> reporting for TX buffer exhaustion, halt timeouts, and HRESP errors.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 5a4eb87f5a97d..7e77c24da8a63 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -1303,6 +1303,7 @@ static void macb_tx_error_task(struct work_struct=
 *work)
> >  	struct macb_tx_skb *tx_skb;
> >  	struct macb_dma_desc *desc;
> >  	bool halt_timeout =3D false;
>
> [Severity: High]
> Does the driver ensure that this work item is cancelled during teardown?
>
> If macb_close() frees bp->ctx and sets it to NULL without calling
> cancel_work_sync(), this work item might execute after the interface is
> brought down.
>
> Since this function starts with:
>
> macb_tx_error_task() {
>     ...
>     struct macb_context *ctx =3D queue->bp->ctx;
>     ...
> }
>
> Could this result in a use-after-free or NULL pointer dereference if an
> error interrupt fires shortly before or during interface teardown? The
> same question applies to macb_hresp_error_task() and bp->ctx.

Ignoring because this is a pre-existing issue.

It complains about the close codepath which we don't modify here. BTW
the fix to the close codepath would probably to copy most ideas from
the swap we are implementing. Said another way, swap is more thoughtful
than close.

> > +	bool buggy_driver =3D false;
> >  	struct sk_buff *skb;
> >  	unsigned long flags;
> >  	unsigned int tail;
>
> [ ... ]
>
> > @@ -1412,6 +1411,13 @@ static void macb_tx_error_task(struct work_struc=
t *work)
> >  	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
> > =20
> >  	spin_unlock_irqrestore(&bp->lock, flags);
> > +
> > +	if (halt_timeout)
> > +		netdev_err(bp->netdev, "BUG: halt tx timed out, we ignored it\n");
> > +
> > +	if (buggy_driver)
> > +		netdev_err(bp->netdev, "BUG: TX buffers exhausted mid-frame\n");
> > +
> >  	napi_enable(&queue->napi_tx);
>
> [Severity: High]
> Could moving these netdev_err() calls here create a race condition that
> stalls the TX queue?
>
> Earlier in this function, the hardware is restarted and interrupts are
> unmasked. When the spinlock is dropped, an interrupt can fire while
> napi_tx is still disabled.
>
> If a TCOMP interrupt fires during these netdev_err() calls, the
> interrupt handler will mask the TCOMP interrupt in IDR and attempt
> to schedule NAPI:
>
> macb_interrupt() {
>     ...
>     if (status & (MACB_BIT(TCOMP) | MACB_BIT(TXUBR))) {
>         queue_writel(queue, IDR, MACB_BIT(TCOMP));
>         ...
>         napi_schedule_irqoff(&queue->napi_tx);
>     }
>     ...
> }
>
> Since napi_enable() hasn't been called yet, the schedule request will be
> dropped. When napi_enable() finally runs, it clears the disabled state
> but does not unmask the interrupt or schedule NAPI, which seems like it
> could leave the queue permanently stalled. Should napi_enable() be
> called before these netdev_err() calls?

So this complains about a race inbetween macb_tx_error_task() and our
IRQ handler. Here is the two contexts side-by-side (sorry for 80 char
overflow, I'm counterbalancing that with shiny box drawing unicode):

=E2=94=80 PROCESS CONTEXT =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
                                   =E2=94=82
macb_tx_error_task() {             =E2=94=82
  napi_disable(queue->napi_tx)     =E2=94=82
  spin_lock_irqsave(bp->lock)      =E2=94=82
  ...                              =E2=94=82
  spin_unlock_irqrestore(bp->lock) =E2=94=82
                                   =E2=94=9C=E2=94=80 INTERRUPT CONTEXT =E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
                                   =E2=94=82
                                   =E2=94=82 macb_interrupt() {
                                   =E2=94=82   spin_lock(bp->lock)
                                   =E2=94=82   status =3D queue_readl(queue=
, ISR)
                                   =E2=94=82   if (status & TCOMP) {
                                   =E2=94=82     queue_writel(queue, IDR, T=
COMP)
                                   =E2=94=82     macb_queue_isr_clear(queue=
, TCOMP)
                                   =E2=94=82     napi_schedule_irqoff(&queu=
e->napi_tx)
                                   =E2=94=82   }
                                   =E2=94=82   ...
                                   =E2=94=82 }
                                   =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
  napi_enable(queue->napi_tx)      =E2=94=82
}                                  =E2=94=82
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98

(I've schematised it but expect macb_interrupt() to be stuck on
spin_lock() waiting for spin_unlock() from the process context.)

The race is that the IRQ might call napi_schedule_irqoff() before
napi_enable(). But what we've done with our deferred netdev_err() calls
is only to grow the race window, we haven't introduced it.

The LLM missed one key point in that the window was already present, and
probably as important or more than the printk I'm adding:
spin_unlock_irqrestore() might trigger kernel-side pre-emption.

So I'll move my two netdev_err() after napi_enable(), but this is a
pre-existing issue unrelated to this swap series.

Thanks,

--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

