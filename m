Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D0C3CF662
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950789; cv=none; b=H/8cQoRJVK/XktxcT4BMnJBRxu9XQFTeABK2w6HbfbEXKIRMMXQngtHFkz8gVgCXvJ1azFmslq5eQSjkXaCa231txLERchZ+1KWlpmTzLhF8UpF7hWvD5l8l3ASEMCMWW9az/9HVXCdGTb1pedaDAKxFs2kpPG2IKaQnSSZLSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950789; c=relaxed/simple;
	bh=5qipwgTvv2a6xCfQm2wonmBMECbQlwL5mwmsnO9a38E=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:In-Reply-To:
	 References:MIME-Version; b=lhmIRdUyEx7LAIJRFAjKBTCTg/sLGRloUinFqsVkHHPqosxp1ABZs62VrHKQTDmPIrf5Y0cUz7gw/0aY1r5GCrJ5xvIU9JBZ45rq4XDw6Xdo3UJZD/fbhY10oTET1J9ZghwavOkSrVovJrYEFOUFaCP/rgXfH147mLaqSJNnqGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xMaszOA8; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xMaszOA8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 72A944E40FEA;
	Wed,  5 Aug 2026 17:26:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 33705602AB;
	Wed,  5 Aug 2026 17:26:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFADB11C35011;
	Wed,  5 Aug 2026 19:26:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785950779; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UGS3umiNr2B7IWOTPEArrlb6zKePkB8J7CNSWWn85V0=;
	b=xMaszOA8zbkopei0waTHUVOnUcH/H8oe4wptYBG7CKeE5iRr8iV1ZasdqIecdXecwArKC1
	JYLamiSrznsIcxxcwPBnZRTeRpVFqOoPN430lVjRih56dUi7QvHWj6jHSnFEACpaDzUtbl
	sIDefzIoq5tu5SX4YHSYZLvfhr/jIufTymP68ACN3vqf7yzrZET0Bb6/W/S70B+DvU6hS4
	vbPgIdWBdmqw83/+gTyLi095Bk+gZ3kPJ7ulL1E45BTMrh9P/fgRH5q8qYLmC3gWehPVDM
	4uZuzRLO6lT9EW2/7IH9s3cDiVoneMSdRJsBKyosG/YyM9XwHGsyUJY+AiWXfw==
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 19:26:13 +0200
Message-Id: <DKH6PMSV6AT4.37ECXZ29QXHCB@bootlin.com>
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
Subject: Re: [PATCH net-next v7 17/17] net: macb: use context swapping in
 .ndo_change_mtu()
In-Reply-To: <20260803-macb-context-v7-17-4d7d4af04849@bootlin.com>
References: <20260803-macb-context-v7-17-4d7d4af04849@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: hbTrsmwUNin+
X-Last-TLS-Session-Version: TLSv1.3

Replying to sashiko
https://sashiko.dev/#/patchset/20260803-macb-context-v7-0-4d7d4af04849%40bo=
otlin.com

> commit 86a1d8b3d0caecfd721045c06709c6a2234de503
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: use context swapping in .ndo_change_mtu()
>
> This commit implements ndo_change_mtu() for MACB by swapping contexts.
> It allocates a new context, reconfigures the hardware, and frees the
> old context to resist memory pressure and speed up the process.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 9093fb2c789f5..df9594e515df4 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -3531,11 +3531,29 @@ static int macb_close(struct net_device *netdev=
)
> > =20
>
> [...]
>
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
> Does macb_context_swap_end() unconditionally wake the TX queues even if t=
he
> link is down?
>
> If the interface is UP but the link is DOWN (e.g., carrier loss),
> macb_mac_link_down() stops the TX queues. However, when ndo_change_mtu() =
is
> called and executes macb_context_swap_end():
>
> macb_context_swap_end() {
>     if (bp->link_up && bp->eee_active)
>         macb_txp_lpi_initial_defer(bp);
>    =20
>     netif_tx_start_all_queues(bp->netdev);
> }
>
> By calling netif_tx_start_all_queues() without checking the bp->link_up
> state, the TX queues are awakened. Can this cause the networking stack to
> push packets to the driver, filling up the TX ring and eventually trigger=
ing
> a NETDEV_WATCHDOG TX timeout since the hardware transmitter remains
> disabled?

Argh! It's not the first time Sashiko mentions this
netif_tx_start_all_queues() call during swap.

It didn't bother me because we have the same in macb_open(). So if our
open implementation leaves tx queues active even before link-up then I
don't see why it's wrong to have our swap implementation do the same.

Looking more and more into it, the only difference I could find is that
we cannot have a qdisc attached at open, but we might have one at swap
even while link is down (with the net/core/link_watch.c mechanism).

Let's please Sashiko, and do two changes:
 - condition the netif_tx_start_all_queues() call
 - actually replace it by a netif_tx_wake_all_queues()

I'm adding the second point because IIUC it is needed to trigger
immediately if there were pending packets in the qdisc, else it could
wait for the next packet to arrive.

Thanks,

--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

