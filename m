Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D74C471D03
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253840; cv=none; b=FpCxAfFqU2ddx3ZC1GFM7+YypgHQ6X9Fgdnua4PT0kW2TGBzWeswbw9tWxQhYMMAboHxJpSkGCkBhdkMG/PvfW9XAneNgCSr0Sr1jgfPhUqCiCN5gIuFqxhpsZU8iR/bm8KUmJK041lIIpTDjKFgkVmYPb53AwA2SdFJchrFiL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253840; c=relaxed/simple;
	bh=r43ercH8hh7m4a7NMFw494Tp8qt25nxfbWpSPXZRdMg=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:In-Reply-To:
	 References:MIME-Version; b=OHDS+pbZGxgl6UrkKTx5iUax7BaF8xK73+ZCXRzOmnex7CtAo/8pZeG7ktL7U/Op1vAKjTDW+m1d453dMWFUqrsIO/gS3q2vg0M9XwVL2eUxvjXpKRjrjRFOopR4NncXELw02chr1rlyeYqODd4drcoI8mZTCpCO/gXOkQLPgVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mxcC5TSJ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mxcC5TSJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 56B434E41474;
	Tue,  1 Sep 2026 09:10:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 210A56053C;
	Tue,  1 Sep 2026 09:10:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6DC5111C78AAE;
	Tue,  1 Sep 2026 11:10:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788253828; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=O6M7R6qeKpGv7hKN92NZpeG9scGOhJTRlBjUTgzzTrg=;
	b=mxcC5TSJB+emTkc08IySeI8kzDDA7EH7tsdzHd2PwXYRd04nb+gNTqxc63NoueCDms4t18
	B9Ci6mAQ3myMC7nJve7IsyB9LbEHilce1RMJToTyK+WnYo5BCtZV7VPUt6xluJrZMuqvfz
	PcpfVlC35QyX5tu6TZYVFd63YQcEXEZtu2PNTMozouUPjITWnhKindYylD9sOmkXnpai/T
	jRtQ4n2YfHyWJABrWmItLZeG4Me+0lLODwEXi0BMkU2tkTSH+w8Gr9BOdgpuRPphtHw2Ax
	iliEtn7TlsqMiI14y7QvpkzGRP8e777HXYjemkOtmdeqHhfUB1PDox8+mBoZYA==
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 11:10:22 +0200
Message-Id: <DL3V2OWS1QQK.3LSPJWT56YK43@bootlin.com>
Subject: Re: [PATCH net-next v9 05/17] net: macb: enforce reverse christmas
 tree (RCT) convention
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260812-macb-context-v9-5-7ddbf5f715e0@bootlin.com>
References: <20260812-macb-context-v9-5-7ddbf5f715e0@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: DAMUKiy6g+Ou
X-Last-TLS-Session-Version: TLSv1.3

Replying to non-net sashiko
https://sashiko.dev/#/patchset/20260812-macb-context-v9-0-7ddbf5f715e0%40bo=
otlin.com

> commit da95f184645150278bd5328618e0592f867e39bb
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: enforce reverse christmas tree (RCT) convention
>
> This patch enforces the reverse christmas tree convention for variable
> declarations in several macb functions. The goal is to minimize unrelated
> diffs in future patches.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 77053cb9d8f7b..b138b94ea0d89 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
>
> [ ... ]
>
> > @@ -2476,10 +2475,10 @@ static netdev_tx_t macb_start_xmit(struct sk_bu=
ff *skb,
> >  	unsigned int q =3D skb_get_queue_mapping(skb);
> >  	unsigned int desc_cnt, nr_frags, frag_size, f;
> >  	struct macb_queue *queue =3D &bp->queues[q];
> > +	netdev_tx_t ret =3D NETDEV_TX_OK;
> >  	unsigned int hdrlen;
> >  	unsigned long flags;
> >  	bool is_lso;
> > -	netdev_tx_t ret =3D NETDEV_TX_OK;
>
> [Severity: Low]
> This isn't a bug, but it looks like the first few variable declarations i=
n
> macb_start_xmit() are still not in reverse christmas tree order.
>
> With this patch applied, the top declarations in macb_start_xmit() are:
>
> 	struct macb *bp =3D netdev_priv(dev);
> 	unsigned int q =3D skb_get_queue_mapping(skb);
> 	unsigned int desc_cnt, nr_frags, frag_size, f;
> 	struct macb_queue *queue =3D &bp->queues[q];
> 	netdev_tx_t ret =3D NETDEV_TX_OK;
>
> Is it intended that these first few variables remain in their original or=
der
> due to initialization dependencies?=20
>
> The commit message mentions enforcing RCT here, but to fully sort them, t=
he
> initializations might need to be split from the declarations similar to w=
hat
> was done in macb_tx_error_task().

It sounds like Sashiko doesn't visualise the tree trunk.
I'll ignore this review!

Thanks,

--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

