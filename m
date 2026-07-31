Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A8453A44;
	Fri, 31 Jul 2026 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514875; cv=none; b=JTmJ5kINVQVa52Yx7Fw/4Zbl/rg3i/WmcYgX/H0MzGvlzrDLpKCJe+BGQSrK9rZOYdu9aJ6UvV+861f5RSTXs37MyoEcKLI0+cX+XNBp0VtlM1IrXEJzHCu9sMWzgdGLn8EQTdyCCLdwCD8j8hVh24Hl9fsuHpK8M1JdsiRi0Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514875; c=relaxed/simple;
	bh=vLZuZ0bPYtVDsdGoYRjjMdmvdHT9O/TBnkF6nUNffw8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=V5BVdheax8mqdhO+89RRYBpA/BcE6YpongtqvbIWJut6NPIu+OOGEDcUexq3p4N+UYPP2Fli4tA6zuL7r72pP49Ic8gGBq+r5t3i6QVcOsyvSGRQfffJ7AYtdSKshNddSBK5bwhE/IJkhZei8517nfExtZjD6iZUYYa+XluFuYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ztORXrgg; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ztORXrgg"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 662491A1366;
	Fri, 31 Jul 2026 16:21:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 367E06039A;
	Fri, 31 Jul 2026 16:21:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 600DA11C16A9C;
	Fri, 31 Jul 2026 18:21:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785514868; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hl4GXjd/Cg8VT0kpm417nRugGjVEQrxWCQ4gwmm81f4=;
	b=ztORXrgggePeNfLe7poZlpmUV22JOSiKP+f2Kx+/3V1N1HcsKZlUXEgjxBhQy7SpfCC4a3
	PpMHRFSGjSEoPxo0Pj0TRQETX9tF4Txb9P2sBWeLNEUJv6d1JwUjxGHOlgGQ//LuBof3uk
	JXt8W+YzCugz55Lpf8ulWSFi26EuQ+nDvtUb+VYcqlH5mCedxXxLY0bY8vvq/OUdLwTP9q
	jZ/zAhRr76B3CK9X9w/iQbAcGnWRYBBW4y79s9pD1IyN/WklT7Z6anGc8XU0f7ImjWdK+k
	pWo4Tv/rU7/Poax0TbhTX3dt9QLPbz4y834shRNjAuCqcoG46QeHDoAXqlWyTA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 18:21:04 +0200
Message-Id: <DKCW7184EDH0.2HX1G8K8J44C@bootlin.com>
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
Subject: Re: [PATCH net-next v5 15/15] net: macb: use context swapping in
 .ndo_change_mtu()
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
 <20260724-macb-context-v5-15-569b1852bc7f@bootlin.com>
In-Reply-To: <20260724-macb-context-v5-15-569b1852bc7f@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

Replying to sashiko.dev reviews.
https://sashiko.dev/#/patchset/20260724-macb-context-v5-0-569b1852bc7f%40bo=
otlin.com

> > @@ -3496,11 +3496,29 @@ static int macb_close(struct net_device *netdev=
)
> >
> >  static int macb_change_mtu(struct net_device *netdev, int new_mtu)
> >  {
> > -   if (netif_running(netdev))
> > -      return -EBUSY;
> > +   struct macb *bp =3D netdev_priv(netdev);
> > +   bool running =3D netif_running(netdev);
> > +   struct macb_context *new_ctx;
> > +
> > +   if (running) {
> > +      /* Context swapping is not supported for AT91. */
> > +      if (bp->caps & MACB_CAPS_MACB_IS_EMAC)
> > +         return -EBUSY;
> > +
> > +      new_ctx =3D macb_context_alloc(bp, new_mtu,
> > +                    bp->configured_rx_ring_size,
> > +                    bp->configured_tx_ring_size);
> > +      if (IS_ERR(new_ctx))
> > +         return PTR_ERR(new_ctx);
> > +
> > +      macb_context_swap_start(bp);
> > +   }
> >
> >     WRITE_ONCE(netdev->mtu, new_mtu);
> >
> > +   if (running)
> > +      macb_context_swap_end(bp, new_ctx);
>
> [Severity: High]
> When macb_context_swap_end() unconditionally re-enables interrupts, sets =
MAC
> RX/TX back on (RE/TE in NCR), and calls netif_tx_start_all_queues(), does
> this override the phylink state machine by fully activating the MAC witho=
ut
> checking netif_carrier_ok()?
>
> If the interface is administratively UP but the physical link is DOWN,
> macb_mac_link_down() is called by phylink, which disables MAC RX/TX (RE/T=
E
> bits) and stops the TX queues.
>
> If an MTU change is requested in this state, does this sequence bypass ca=
rrier
> state validation and activate the MAC while the physical link is still do=
wn?

Yes, agreed. Reported in [14/15] and discussed there.
https://lore.kernel.org/netdev/DKCVYZ69KGSM.2R1ELFSWRG5HM@bootlin.com/

 - Adding netif_carrier_ok() check.
 - Grabbing bp->mac_cfg_lock from macb_hresp_error_task() which also
   edits the carrier state (so risks conflicting).
 - However we don't condition netif_tx_start_all_queues() on
   netif_carrier_ok() because macb_open() is the one doing the call,
   not link-up.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

