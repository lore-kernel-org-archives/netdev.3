Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09953361948
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773665; cv=none; b=RTlqxj7TRC1mqDW3JXoAp5PrNLrtM6sugs6/bpYkOmQVX25dsTx58F2Kn+s3mBDv4IE8ONUVv9N3Tn9dpUQiudC9lcx0J0dveBYtAvWhi183+iRsuQqpJOdwJ0193BrDSNGi2jp9lLKF9r1xETfHLKRMg9soyHLxrt4uDyXYgUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773665; c=relaxed/simple;
	bh=05zUD1DqX//LGId/b0JLgygyPbfAgN6l4FTF+WdnVNg=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:In-Reply-To:
	 References:MIME-Version; b=m8AlyWMGXBNK4/4Exe/HfnrjmtOA69A8VT3IJZtDZysZIZtYINBMLurUn1zfGNyTBW0YoY9olb/yw0chKBVNZAc7DLHg1sMCefdep5QDt6fejS9VfRwBmCBXW8d3tMAtN6ecC1zWHS4hhhl0HBTqEqvSionreYTFL/ULsVB1DqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LiKMYZvj; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LiKMYZvj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DAA371A13C3;
	Mon,  3 Aug 2026 16:14:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AAE876029B;
	Mon,  3 Aug 2026 16:14:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7EAA011C31208;
	Mon,  3 Aug 2026 18:14:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785773651; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Y4JgK5NUlRyN3S8WjIMJEXYYt8qj05KpzjPaRCWnPYU=;
	b=LiKMYZvjePZJiaia2zjWJq5QWY3oEIVDa8mIEG2MUkMnAX84kEraHwqPghC3CUZH6n7lco
	ndrs1B7s9cz+vBpNZIPIN+Rpdor7lZMIkqCbOGkQ/3aYvF4qS/40x3Dvunh8ViLxXea/b9
	Up9vm1m/PcljBzN1z1IaZMPvFa7ykfyolukW4zUUxgED8QY6lC7bT/JRGHBNg/asQljNVx
	7NWUaHHDyd4X22zUk+/kgRAMXlIZeTmnCmpNC9Q5CC9rVr5COkK3yJEeb+dd0EOlvXyUu2
	d0vuBzM+sICj2Zmk9pv4PM0xlZKG/N4e3CZaxgNFODwJIn/RocSoyBGepRJrtA==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 18:14:06 +0200
Message-Id: <DKFFXBM6VKXZ.22PW13MLAXSF@bootlin.com>
Subject: Re: [PATCH net-next v6 13/16] net: macb: move printk() calls out of
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
In-Reply-To: <20260731-macb-context-v6-13-49d5a1439d48@bootlin.com>
References: <20260731-macb-context-v6-13-49d5a1439d48@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: rsbB8rKmzlrJ
X-Last-TLS-Session-Version: TLSv1.3

Replying to net sashiko
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731-macb-context-v=
6-0-49d5a1439d48%40bootlin.com

> commit 99f5236ffcf1506bce8a08773b0456e50c57986e
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: move printk() calls out of bp->lock critical section
>
> The two netdev_err() calls in macb_tx_error_task() are deferred until aft=
er
> the spin_unlock_irqrestore(&bp->lock, flags), using the existing
> halt_timeout flag plus a new buggy_driver flag. The stated goal is to
> guarantee that netpoll can never be entered while bp->lock is held.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 987fafb2bf40d..65d5ff8a5e230 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -1358,9 +1358,6 @@ static void macb_tx_error_task(struct work_struct=
 *work)
> >  			 * since it's the only one written back by the hardware
> >  			 */
> >  			if (!(ctrl & MACB_BIT(TX_BUF_EXHAUSTED))) {
> > -				netdev_vdbg(bp->netdev, "txerr skb %u (data %p) TX complete\n",
> > -					    macb_tx_ring_wrap(ctx, tail),
> > -					    skb->data);
> >  				bp->netdev->stats.tx_packets++;
> >  				queue->stats.tx_packets++;
> >  				packets++;
>
> [Severity: Low]
> [Finding: main-1-1]
> [Sources: opus-5]
> This isn't a bug, but the commit message only describes deferring the
> netdev_err() calls, while this hunk deletes the per-descriptor
> netdev_vdbg() trace outright rather than moving it. Its arguments are
> per-descriptor (macb_tx_ring_wrap(ctx, tail) and skb->data) and cannot be
> reproduced after the loop, so VERBOSE_DEBUG builds lose that TX error
> recovery trace. Could the commit message mention this removal?

See below.

>
> > @@ -1374,8 +1371,7 @@ static void macb_tx_error_task(struct work_struct=
 *work)
> >  			 * those. Statistics are updated by hardware.
> >  			 */
> >  			if (ctrl & MACB_BIT(TX_BUF_EXHAUSTED))
> > -				netdev_err(bp->netdev,
> > -					   "BUG: TX buffers exhausted mid-frame\n");
> > +				buggy_driver =3D true;
> > =20
> >  			desc->ctrl =3D ctrl | MACB_BIT(TX_USED);
> >  		}
>
> [Severity: Low]
> [Finding: main-1-1]
> [Sources: opus-5]
> Same finding as above: this also converts a per-descriptor message into o=
ne
> aggregated message per invocation, so the number of affected descriptors =
is
> no longer visible. Worth a line in the commit message as well?

Yes! Mentioned in cover letter but not enough in commit message.

> > @@ -1412,6 +1408,13 @@ static void macb_tx_error_task(struct work_struc=
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
> >  }
>
> [Severity: High]
> [Finding: main-1-0]
> [Sources: opus-5]
> The commit message says the goal is "to ensure we can never netpoll under
> bp->lock's reign". Is that invariant actually established, given the
> netdev_err() still present in macb_interrupt_misc()?
>
> 	if (status & MACB_BIT(HRESP)) {
> 		queue_work(system_bh_wq, &bp->hresp_err_bh_work);
> 		netdev_err(netdev, "DMA bus error: HRESP not OK\n");
> 		macb_queue_isr_clear(bp, queue, MACB_BIT(HRESP));
> 	}
>
> macb_interrupt() holds the lock across the whole status loop, including t=
hat
> call:
>
> 	spin_lock(&bp->lock);
> 	while (status) {
> 		...
> 		if (unlikely(status & MACB_INT_MISC_FLAGS))
> 			if (macb_interrupt_misc(queue, status))
> 				break;
> 		status =3D queue_readl(queue, ISR);
> 	}
> 	spin_unlock(&bp->lock);
>
> [...]

Argh, yes. I had seen this printk() following the last review iteration
but I couldn't think of a way to land in the interrupt handler while
netpoll was doing its job. But actually it's the other way around: we
might be in the IRQ handler and call our printk that triggers netpoll
mode, re-entering into macb_interrupt_misc().

Let's drop that netdev_err() in macb_interrupt_misc(). I've checked
again, it's the only non-debug printk I could find potentially in a
bp->lock section.

If you have debug prints active AND you land in this race, you have your
hands in the engine anyway. This isn't hurting any real driver user. So
I explicitely ignore them.

(Note: I will re-add the netdev_vdbg() in macb_tx_error_task().)

Thanks,

--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
