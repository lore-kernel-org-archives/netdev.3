Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24463264D6
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115468; cv=none; b=qyOb4yoGiBdRby4iGA8rQ9yybFqlOLahUp93ithVFg3nd0Lrb7NWmyrswdJ0pVEX+IzeeH4+Jbc4SHsujki6bqJgZNAMYzCTiiISx0A6/HHPgZxFAyhoOUtX1QKDtHqRMdxvYGBq1/YucLn1wWfXY5J1obXYW+R0mISEO96w+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115468; c=relaxed/simple;
	bh=uK/PNS8JNQkh2cvxK1QDAfTyjEZuX44ypZ4nReWUVyw=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:In-Reply-To:
	 References:MIME-Version; b=Y5mQgnV8Kyhq76P58zN7/83WnR0nqmXP3kYUA84Gh3MGoTDbxe+NWI9fs66CSvvjVk+JQ0SN7d67a/irYqa28JccuZc09hfNSrIBt03F0DkfZkoUYwUIi4Ih7ehGgi5yiufdhvY+TgdL+uuALQoPC7EIUP3aHKK2rsPZdduxzWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EvQy0Qzi; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EvQy0Qzi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A50CE4E4113F;
	Fri,  7 Aug 2026 15:11:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 77D07603F0;
	Fri,  7 Aug 2026 15:11:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5B9D11C37A9B;
	Fri,  7 Aug 2026 17:10:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786115457; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XRR2UvZSRCKTVbyGykaVEtXpGtPWwz6jcORSSkjGKGU=;
	b=EvQy0QziPdFdM6nWLP+PTQovKwRFxb+qMQvkr3JMmkDjautHajbeqenPmIZ9WmfsVF29WV
	B38HfPllnivTr+arU8pilB4XSh3VH3kVggO4d8flbUycFhvDFW0dEewOIAfaoYdZxPJXJ7
	uLhwJ006dA04ItCYt3JK0c69aueqU4z8F6lKWHyoWuH4kUJtaT7vWw/a0UqJC2NVGGqHYd
	HC10vB2vkue2rl1G+QUGuxG8fSSFxklU0MCe5XkmSv94KYey8IyuG2bhNQcYrajN5825pv
	tMwM/U5D30FE2KcMU4HS1XBH/c4QrErgjGijRWKE/R4w4RbC9bMJhHgPVYdFZA==
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 17:10:52 +0200
Message-Id: <DKIT3392F9P2.1LIU3XTCN3B6F@bootlin.com>
Subject: Re: [PATCH net-next v8 08/17] net: macb: introduce macb_context
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
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Richard Cochran" <richardcochran@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
In-Reply-To: <20260805-macb-context-v8-8-bc302ffd1174@bootlin.com>
References: <20260805-macb-context-v8-8-bc302ffd1174@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: lmV91QiQ4UJy
X-Last-TLS-Session-Version: TLSv1.3

Replying to sashiko
https://sashiko.dev/#/patchset/20260805-macb-context-v8-0-bc302ffd1174%40bo=
otlin.com

> commit 275a99a81c17ff48dfcda588314d331d16fe6efa
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> net: macb: introduce macb_context struct for buffer management
>
> This commit introduces the macb_context structure to own all queue buffer=
s
> and their associated parameters. To improve reliability under memory pres=
sure,
> it restructures the driver to support allocating new buffers before freei=
ng
> old ones. Various fields are migrated from macb and macb_queue structs to
> macb_context, macb_txq, and macb_rxq.
>
> [ ... ]
>
> > @@ -3701,8 +3788,8 @@ static int macb_set_ringparam(struct net_device *=
netdev,
> >  			      MIN_TX_RING_SIZE, MAX_TX_RING_SIZE);
> >  	new_tx_size =3D roundup_pow_of_two(new_tx_size);
> > =20
> > -	if ((new_tx_size =3D=3D bp->tx_ring_size) &&
> > -	    (new_rx_size =3D=3D bp->rx_ring_size)) {
> > +	if (new_tx_size =3D=3D bp->configured_tx_ring_size &&
> > +	    new_rx_size =3D=3D bp->configured_rx_ring_size) {
> >  		/* nothing to do */
> >  		return 0;
> >  	}
> > @@ -3712,8 +3799,8 @@ static int macb_set_ringparam(struct net_device *=
netdev,
> >  		macb_close(bp->netdev);
> >  	}
> > =20
> > -	bp->rx_ring_size =3D new_rx_size;
> > -	bp->tx_ring_size =3D new_tx_size;
> > +	bp->configured_rx_ring_size =3D new_rx_size;
> > +	bp->configured_tx_ring_size =3D new_tx_size;
> > =20
> >  	if (reset)
> >  		macb_open(bp->netdev);
> > =20
> >  	return 0;
> >  }
>
> [Severity: High]
> Is there a risk of a NULL pointer dereference if macb_open() fails here?
>
> If macb_open() fails (for example, due to a memory allocation failure), i=
t
> returns an error, but this function ignores the return value and always r=
eturns
> 0. Because the interface state wasn't updated via the core dev_close(),
> netif_running(netdev) remains true, while bp->ctx is left as NULL.
>
> If the system later suspends and resumes, macb_resume() will see that
> netif_running(netdev) is true and call macb_init_buffers():
>
> static int __maybe_unused macb_resume(struct device *dev)
> {
>         ...
>         if (netif_running(netdev)) {
>                 ...
>                 if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC))
>                         macb_init_buffers(bp);
>
> This would unconditionally dereference the NULL bp->ctx pointer. Should t=
he
> return value of macb_open() be checked and propagated here?

Two replies:

 - This is a pre-existing issue, but not flagged as such.

 - We fix it at the end of the series, but using context swapping. It's
   basically the whole point of the series. I'm surprised Sashiko
   doesn't pick that up by itself, nor does it pick up that I already
   told it the same thing on the same patch on previous revisions.

Thanks,

--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

