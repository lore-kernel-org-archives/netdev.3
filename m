Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294D542E8F1
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508773; cv=none; b=KZdiFPfLp7h1SNvftNOMYXSVjPkt91ee3v4JZ9bjHK0z9B6E8QR9SCKUIaH+3oFwltV6d5pKMclMuRxB5nqUEsx/fZRWce7o+cZ1w0RJqmfT5ALiHLH0heWSPfCtMxhF0zfOwGbqk+aR6JMcxDtpmK+HSUXpSUusQt+wKnDAIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508773; c=relaxed/simple;
	bh=D1aJPZBOo/OhYP1HH4IOSv56VOjVJA/fxuLhsShIff8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=huYr+wrDwBH3GdadVNg2QwtqhJ9kfLbqLIhkdo925Pj/snSHs0WIYyS5nL0yKNcZ0rR4at5kpxfCqRJnM9LhRM/Kvma3wdhtfRqwEwaW3n3TUizW1S1jP3izBTGgAQJowVYc8dyumqOrtATVkjBCPMNhkM0HXWXDneUTggDvA0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g4z2dp+2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g4z2dp+2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 585971A135E;
	Fri, 31 Jul 2026 14:39:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1C5C36039A;
	Fri, 31 Jul 2026 14:39:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6EAE411C1693A;
	Fri, 31 Jul 2026 16:39:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785508763; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uUpTXFVzOqLSupsepWIgmJgJHum04BsXDSlkHLk2W5U=;
	b=g4z2dp+2U6NXxgj5+EGOa+1bUiHld1jmAudMsJhfsve9so34i4hgSn15/kRc6YO9nzBghl
	jDEkUwGDqi+WRt/30NI2dY+573Knomgyhqz/Q9rceKooc6eA13aK0Vmje/MQrfgNZwnru4
	OZH1XJfBuSdNTUse06FFo8bsgtJXdPfL3pHZ3/kBldaIJMN+9JnJE/GNUHzDJU3oEAI/DN
	a3R+HQ4HsRShpLVzCpddMh6nRt2BkMCQLJ2SP2zkqIAkkNNWBotCYNkVY3XqspAlk+Sw2P
	aA79JRRElrYQohV0xE8htBrd8f7vphQMVTT+fu7KfllXzSOiG3yIYbwheKGKTg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 16:39:16 +0200
Message-Id: <DKCU137TXTQJ.1G54TGB6LKZVW@bootlin.com>
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
Subject: Re: [PATCH net-next v5 07/15] net: macb: introduce macb_context
 struct for buffer management
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
 <20260724-macb-context-v5-7-569b1852bc7f@bootlin.com>
In-Reply-To: <20260724-macb-context-v5-7-569b1852bc7f@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

This is a reply to both Sashikos comments.
https://sashiko.dev/#/patchset/20260724-macb-context-v5-0-569b1852bc7f%40bo=
otlin.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260724-macb-context-v=
5-0-569b1852bc7f%40bootlin.com

sashiko.dev has comments on previous patches but they all match

> This is a pre-existing issue, but [...]

What remains:

> > @@ -3696,8 +3783,8 @@ static int macb_set_ringparam(struct net_device *=
netdev,
> >  			      MIN_TX_RING_SIZE, MAX_TX_RING_SIZE);
> >  	new_tx_size =3D roundup_pow_of_two(new_tx_size);
> >
> > -	if ((new_tx_size =3D=3D bp->tx_ring_size) &&
> > -	    (new_rx_size =3D=3D bp->rx_ring_size)) {
> > +	if (new_tx_size =3D=3D bp->configured_tx_ring_size &&
> > +	    new_rx_size =3D=3D bp->configured_rx_ring_size) {
> >  		/* nothing to do */
> >  		return 0;
> >  	}
> > @@ -3707,8 +3794,8 @@ static int macb_set_ringparam(struct net_device *=
netdev,
> >  		macb_close(bp->netdev);
> >  	}
> >
> > -	bp->rx_ring_size =3D new_rx_size;
> > -	bp->tx_ring_size =3D new_tx_size;
> > +	bp->configured_rx_ring_size =3D new_rx_size;
> > +	bp->configured_tx_ring_size =3D new_tx_size;
> >
> >  	if (reset)
> >  		macb_open(bp->netdev);
> >
> >  	return 0;
> >  }
>
> [Severity: Critical]
> Does ignoring the return value of macb_open() here risk leaving the
> device in the UP state with a NULL bp->ctx?
>
> If a ring parameter update fails during macb_open() (for example, due to =
a
> DMA allocation failure), bp->ctx will be freed and left as NULL. Because
> the failure is ignored and 0 is returned, the network stack still
> considers the device to be UP. A subsequent interface down event will cal=
l
> macb_close() which will panic when it dereferences bp->ctx to free the
> queues.

This is also a pre-existing issue but it's wasn't flagged as one.
Anyway, it should be ignored because by the end of the series this
macb_open() disappears and we do context swapping.

---

For netdev sashiko now:

> > @@ -3138,14 +3205,22 @@ static int macb_open(struct net_device *netdev)
> >  	if (err < 0)
> >  		return err;
> >
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
> >
> >  	err =3D macb_alloc(bp);
> >  	if (err) {
> >  		netdev_err(netdev, "Unable to allocate DMA memory (error %d)\n",
> >  			   err);
> > -		goto pm_exit;
> > +		goto free_ctx;
> >  	}
> >
> >  	bp->macbgem_ops.mog_init_rings(bp);
> > @@ -3187,6 +3262,9 @@ static int macb_open(struct net_device *netdev)
> >  		napi_disable(&queue->napi_tx);
> >  	}
> >  	macb_free(bp);
> > +free_ctx:
> > +	kfree(bp->ctx);
> > +	bp->ctx =3D NULL;
> >  pm_exit:
> >  	pm_runtime_put_sync(&bp->pdev->dev);
> >  	return err;
>
> [High]
> Once macb_init_hw() has enabled IRQs, can the hardware fire a TX error
> or HRESP interrupt whose handler schedules work before this error path
> runs?
>
> [...]

Same type of report. It sees a bug because now the race lands in a
bp->ctx null ptr deref, but the bug existed before and probably crashes
the system as well.

> > @@ -3220,6 +3298,8 @@ static int macb_close(struct net_device *netdev)
> >  	spin_unlock_irqrestore(&bp->lock, flags);
> >
> >  	macb_free(bp);
> > +	kfree(bp->ctx);
> > +	bp->ctx =3D NULL;
> >
> >  	if (bp->ptp_info)
> >  		bp->ptp_info->ptp_remove(netdev);
>
> [High, High]
> The same question applies here: after macb_reset_hw() masks the HW
> interrupts under bp->lock, can a handler that had already read ISR on
> another CPU still schedule tx_error_task or hresp_err_bh_work once
> bp->lock is dropped?
>
> [...]

Again, pre-existing issue.

> > @@ -5093,6 +5187,10 @@ static int at91ether_close(struct net_device *ne=
tdev)
> >
> >  	at91ether_stop(bp);
> >
> > +	synchronize_irq(bp->netdev->irq);
> > +	kfree(bp->ctx);
> > +	bp->ctx =3D NULL;
> > +
> >  	pm_runtime_put(&bp->pdev->dev);
> >
> >  	return 0;
>
> [High]
> Is the ordering here inverted?
>
> at91ether_stop() writes IDR to mask MAC interrupts and then calls
> at91ether_free_coherent(), which dma_free_coherent()s rxq->ring and
> rxq->buffers and sets both pointers to NULL. Only after that does
> synchronize_irq() run.
>
> If an at91ether_interrupt handler on another CPU had already read a
> set RCOMP bit before the IDR write became visible, it will proceed
> into at91ether_rx():

This is true: synchronize_irq() is too late. I'm pretty sure this is
moot anyway because AT91 is (old and) only single core. I expect a lot
of at91ether code would break if at91ether_*() functions were used on a
multicore SoC.

Anyway I'll fix in next revision.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

