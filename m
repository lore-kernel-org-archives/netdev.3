Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A22B361DA7
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119082; cv=none; b=J/BfKHvj+dv5iv6KKkxD/XoL2UVgfLETsIrgpXpINFxmKSzhJQi3hDCkA9mf2iWqQtnXjmwWJIixcO5p1vQF25ty2cdwZ8UITVbxO8KwD5Gtkvxq5sW6k+EaLwxXbmWZQ0lc99xJuIQTf88WbptQwPsYIQ0Bh/uMbwCjS6pk8D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119082; c=relaxed/simple;
	bh=1scJK/kSKrc7d5AvdTdAGwnyVyMDz/ioBzZqmGZkV5c=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:In-Reply-To:
	 References:MIME-Version; b=SfnQQVSd2MYAZETkp4t5jgzGMpmSQw5TE2VqKLdFBwOApRBTG094OKdM0o2idIRXq+JPABq7hd3Jsj7T9Ut6kUl08pkGXgt2m4xGb9h05zzlv9Zfp1iIOctITwYQi6n8csL0Zyz1POtwm1DsfEOMfa+KUeBl796o2JBcsbBiEZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ow/j/6hA; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ow/j/6hA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4D52B1A14B1;
	Fri,  7 Aug 2026 16:11:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1FD64603F0;
	Fri,  7 Aug 2026 16:11:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3A2B11C37B34;
	Fri,  7 Aug 2026 18:11:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786119072; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9fu+cUvJlXgYu6yEmBzntFpysMJ3dt/4KQZXu2Enl48=;
	b=Ow/j/6hAdgBRhKZJHAHEhFiAW7IIc6Lm9uuH6bIytQ+3UTjRPqRE2eaZU9cdcbXmPPlOsI
	YZMUarHUOh9GdQ6LDW8rXJBB4pmPvRogb1xq0VGKAM4yJ3lZZwbxSAiJDUDIou0g69yiGR
	1a/N+oIfmJmHNGXJxiNC5i4V0U36v6Pp5+c7SRpuBBlIOlbgWCeTEINqZiPbDPDbOkc/yR
	CebMV9mDcGj5grUrw8OtvE92lEoAE5hmBoHe6/1ZRXapygBarhJmd3vtCKQzEYknWGTn2M
	D8dmdCoHTfnWxez4wp8ZIBCY/MYECvDVLqbYiDOMTeLecjEz0NpbqKe9s9Ar+A==
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 18:11:06 +0200
Message-Id: <DKIUD7FKQWRG.NJU9WAALIS4G@bootlin.com>
Subject: Re: [PATCH net-next v8 17/17] net: macb: use context swapping in
 .ndo_change_mtu()
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
In-Reply-To: <20260805-macb-context-v8-17-bc302ffd1174@bootlin.com>
References: <20260805-macb-context-v8-17-bc302ffd1174@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: t2rQwsuV9FQi
X-Last-TLS-Session-Version: TLSv1.3

Replying to sashiko
https://sashiko.dev/#/patchset/20260805-macb-context-v8-0-bc302ffd1174%40bo=
otlin.com

> commit 370786abcd6adf66f9c2032c12fec77c99f4d627
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: use context swapping in .ndo_change_mtu()
>
> Use newly introduced context buffer management to implement
> .ndo_change_mtu() as a context swap: allocate new context ->
> reconfigure HW -> free old context.
>
> This resists memory pressure well by failing without closing the
> interface and it is much faster by avoiding PHY reinit.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 4e004a5345b39..b3d84a65078f8 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -3533,11 +3533,29 @@ static int macb_close(struct net_device *netdev=
)
> > =20
> >  static int macb_change_mtu(struct net_device *netdev, int new_mtu)
> >  {
> > -	if (netif_running(netdev))
> > -		return -EBUSY;
> > +	struct macb *bp =3D netdev_priv(netdev);
> > +	bool running =3D netif_running(netdev);
> > +	struct macb_context *new_ctx;
> > +
> > +	if (running) {
> > +		/* Context swapping is not supported for AT91. */
> > +		if (bp->caps & MACB_CAPS_MACB_IS_EMAC)
> > +			return -EBUSY;
> > +
> > +		new_ctx =3D macb_context_alloc(bp, new_mtu,
> > +					     bp->configured_rx_ring_size,
> > +					     bp->configured_tx_ring_size);
>
> [...]
>
> > +		if (IS_ERR(new_ctx))
> > +			return PTR_ERR(new_ctx);
> > +
> > +		macb_context_swap_start(bp);
> > +	}
> > =20
> >  	WRITE_ONCE(netdev->mtu, new_mtu);
> > =20
> > +	if (running)
> > +		macb_context_swap_end(bp, new_ctx);
>
> [Severity: High]
> Can the watchdog timer cause a use-after-free by concurrently accessing t=
he
> old context pointer while macb_context_swap_end() is freeing it?
>
> If the interface is idle when the MTU is changed, the trans_start timesta=
mp
> may be older than the watchdog timeout.  macb_context_swap_start() calls
> netif_tx_disable() to stop the tx queues, but does not update trans_start=
.
>
> This can allow the asynchronous dev_watchdog timer to conclude a tx timeo=
ut
> has occurred and trigger macb_tx_timeout() -> macb_tx_restart(), which re=
ads
> the context:
>
> static void macb_tx_restart(struct macb_queue *queue)
> {
> 	struct macb_context *ctx =3D queue->bp->ctx;
> 	struct macb_txq *txq =3D macb_txq(queue);
>
> At the same time, macb_context_swap_end() replaces the context pointer
> and frees the old context:
>
> 	macb_free(old_ctx);
> 	kfree(old_ctx);
>
> Could this race cause memory corruption if macb_tx_restart() accesses the=
 old
> context after it is freed?

Well, this is a fresh report for once! But it is completely unrelated to
our series at hand. We implement context swapping.

Let's investigate anyway.

 - First I checked and nothing serialises all those call together at the
   subsystem layer. ndo_tx_timeout is only under netdev->tx_global_lock.

 - ndo_tx_timeout is in softirq context so no bp->mac_cfg_lock mutex to
   save us, that would have been the easy solution.

 - The proper solution is therefore bp->lock with a bp->ctx_swap check
   inside. As queue->tx_ptr_lock is also involved we must make sure to
   respect the ordering done elsewhere in the driver, so something like
   the following in macb_tx_timeout() should fix it:

   spin_lock_irqsave(&queue->tx_ptr_lock, flags);
   spin_lock(&bp->lock);
   if (bp->ctx_swap)
      goto out;
   ...
   spin_unlock(&bp->lock);
   spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);

This is all out of scope and series is way too large already, it'll have
to wait.

Thanks,
--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

