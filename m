Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6013D4AB1A2;
	Thu, 17 Sep 2026 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638335; cv=none; b=IdJqdtC2vIXAReu+fDNvYOB3Pw7bNplsmOG1EZIiyKkL7CUljTNJOjkocuuiKT07PWZFjGwk1IFJD7kzGVwGvuZU8wkrvbPWCA1k9rNijnwwsenRcdaqg+iaRbkhIQpHyg4+nOCXc42cQN7Sd54MHDuFxQmr6SRMgoyZ47e7rWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638335; c=relaxed/simple;
	bh=M4NHTFmcYbNJH2JPge5wuaiu9ulfGZl4X27rldtAL0E=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:In-Reply-To:
	 References:MIME-Version; b=WOwgypSMwwGSlYRBRAyr4ibJj9xiII3ynIWgK5d3ioWPvhOx+Vc84SePkbQE1PepY2LRySNzr5p/w5C99X+2giz4bhi8X4fbBqVk2KgpMOWJgFDjpW5FH9Qd0329VwlLTZxSu1BR/7kBAtiRgtMn+DXO3EtqonHNij7u1ytDjt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i2RQGNo2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i2RQGNo2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C0B054E40790;
	Thu, 17 Sep 2026 09:45:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 704175FAA3;
	Thu, 17 Sep 2026 09:45:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A964C11C78E37;
	Thu, 17 Sep 2026 11:45:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789638312; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=m5h4RH8Zhvq0LtQZCdgb8aUjySpjojyaBqU9sphNE0I=;
	b=i2RQGNo2EyK+a4fsshElnpd3pG3xYOpwblF8y8zMP3+I9lAat4Dj64WKvEVSgzsEAdC/+U
	IwGnLis3yf2RjhDJbN2+A0xz0iRbFzdO+fe3a7Of8zSErr8jzLBSgf2Gr6cXZ/iduwzFzg
	dhgantukbp1El4RfLziKE158zWoGjM5LBFTCg8PpBx979S1ZFZW1qdjaZekgbm+xZYTUP0
	qc81j800fidZJb3N749Kmr1ty5S0q2vdnPYt27/Cq/st9l6U2kMJQmwqRzO74ol/Ir6R2F
	PAXx32Be0z9T03L2p1LgQnB1vg76bZ3cl8n50ebg9VR9zdvDVNPfe1bHCIAwgQ==
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 11:45:08 +0200
Message-Id: <DLHHU0WE2ZW9.2NSJTO8BVRAD1@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v9 17/17] net: macb: use context swapping in
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
In-Reply-To: <20260812-macb-context-v9-17-7ddbf5f715e0@bootlin.com>
References: <20260812-macb-context-v9-17-7ddbf5f715e0@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: WOENQ0w8vn9n
X-Last-TLS-Session-Version: TLSv1.3

Replying to net sashiko
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260812-macb-context-v=
9-0-7ddbf5f715e0%40bootlin.com

> commit 6e5157b79656fb39cc93533094703e19ecdcef41
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: use context swapping in .ndo_change_mtu()
>
> This converts macb_change_mtu() from returning -EBUSY on a running
> interface into a context swap: allocate a new context, quiesce and
> reconfigure the hardware, then free the old context. AT91 EMAC keeps the
> -EBUSY behaviour via a MACB_CAPS_MACB_IS_EMAC check.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 55c97f2035e7..3160e815a89a 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -3530,11 +3530,29 @@ static int macb_close(struct net_device *netdev=
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
> > +		if (IS_ERR(new_ctx))
> > +			return PTR_ERR(new_ctx);
>
> [Severity: Medium]
> [Finding: gpt-5-6-sol-4-5]
> [Sources: gpt-5-6-sol]
>
> This isn't a bug introduced by this patch, but can this error path leak t=
he
> coherent Tx ring?  The same structure already exists at the series baseli=
ne
> in macb_alloc_consistent()/macb_free_consistent() and was reachable throu=
gh
> macb_open(); this hunk adds a second, easily repeatable trigger from
> userspace.

Yes there is a bug in macb_alloc() and it'll be fixed.

[...]

>
> > +
> > +		macb_context_swap_start(bp);
> > +	}
> > =20
> >  	WRITE_ONCE(netdev->mtu, new_mtu);
> > =20
> > +	if (running)
> > +		macb_context_swap_end(bp, new_ctx);
> > +
>
> [Severity: High]
> [Finding: main-5-6]
> [Sources: opus-5]
>
> Is the netdev Tx watchdog also covered by the swap window?

Yes. Talked about in reply to [PATCH net-next v9 16/17]:
https://lore.kernel.org/all/DLCTKEROUJCX.12G2JSI26LQXH@bootlin.com/

Copy/pasting here:

   Well actually netif_tx_disable() does reset dev_queue->trans_start of
   all queues. So a race does exist but it is pretty slim (not the full
   context swap): either before this netif_tx_disable() line or if context
   swap lasts more than 5s.

   I'll protect this by (1) grabbing bp->lock inside macb_tx_restart() and
   (2) checking the state of our boolean flag to know if context swap is
   ongoing.

[...]

Thanks,
--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

