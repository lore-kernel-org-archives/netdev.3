Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCF5480947;
	Wed,  5 Aug 2026 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945855; cv=none; b=t/jSXwK/VEnRW0Jx4f7x0E37Vh4R32TYuosWpVUjKjfxfinNMD4rVNgYtHF4BNOqDh+CEDbpLitT0+pVAQULFmRWCz9IOb4XS4jDuPUBjNXkv6HAJLVYKnEaWKIptLnTY1fvGipgVELNjulMMZlzZ88csH4J/MreLfj0leXEuOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945855; c=relaxed/simple;
	bh=EFoYbggMjmzi0GTrS0GP2Kuk1M/cdn+FOVw7I3M+G4s=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:In-Reply-To:
	 References:MIME-Version; b=tmtL9QlOv7T5CECBhiLu1t2dD8lBw97vrTBX27YT90XtKF4tZ3imuMzhxWhcc/bkwqunlVrfEtwH4zAkO47RvmTFQo93VPW5zMnBdiv/w99QhQhKB1YtOerFwEah80gZNpfypZDcYOoMLuFfjnWqNgcc4HPDSS2krvwlPokXgX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h5JU7rcQ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h5JU7rcQ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C9B6F4E410FC;
	Wed,  5 Aug 2026 16:04:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8B595602AB;
	Wed,  5 Aug 2026 16:04:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 39C6711C34E57;
	Wed,  5 Aug 2026 18:03:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785945838; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CynsEZq5tpeBlH+TJR+PHjj/MwuJaCxKNysaLH3fyf8=;
	b=h5JU7rcQsygknJL1Evz1Tf8OSrOeo5GoQ0cbzsABvSe5iaKRzWOrmB4JclgQB7fwSiTUvr
	HrUJTtdJL1sYmr9Y/aZn4EXSCAomRiD2C7LO9yw1jJxJXj++PTUrsobrMISIpMVkWrtGQB
	VMCqMXVNVbNboxaqCT1uBwS8gFYAhQvsMXQYszDK5AcTzxO/+4KV+qlZFW7JES/fZHxNM9
	SlzSZXBkNQ6qhjqygEH2z3YriUiTGTWFNDxXWswKohOGdK3NOagS0SHU+fIZLwkcsk0NzB
	37ENT7uoTzQy8i9yjsZFlnE4Rz6xA/KJfRQINhtpq7Xju0iE+xH2AyJxuOzxSQ==
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 18:03:50 +0200
Message-Id: <DKH4YK5JVVNB.1XC12P899ZJOP@bootlin.com>
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
Subject: Re: [PATCH net-next v7 15/17] net: macb: read ISR inside bp->lock
 critical section
In-Reply-To: <20260803-macb-context-v7-15-4d7d4af04849@bootlin.com>
References: <20260803-macb-context-v7-15-4d7d4af04849@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: u4820IyvCnm2
X-Last-TLS-Session-Version: TLSv1.3

Replying to sashiko
https://sashiko.dev/#/patchset/20260803-macb-context-v7-0-4d7d4af04849%40bo=
otlin.com

> commit add26bbfae8660854cbc34d74da1557f7bfd9fae
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: read ISR inside bp->lock critical section
>
> The IRQ handler reads ISR register into the `status` stack variable.
> If empty, it early returns. Else, it grabs bp->lock and iterates on
> the status bits.
>
> We risk a race on spinlock acquire; status might have changed.
> Move the readl(ISR) inside the bp->lock critical section.
>
> In practice, we protect ourselves from interpreting the same ISR status
> twice. To understand issues, read macb_interrupt() body and imagine
> each codepath being performed twice:
>  - Two napi_schedule_irqoff() are idempotent *if fast enough*.
> >  - Two schedule_work(tx_error_task) are idempotent *if fast enough*.
> >  - Double increment of rx_overruns.
> >  - Two queue_work(hresp_err_bh_work) are idempotent *if fast enough*.
>
> [...]
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 7e77c24da8a63..0778ce9b3223d 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -2193,12 +2193,13 @@ static irqreturn_t macb_interrupt(int irq, void=
 *dev_id)
> >  	bool hresp_err =3D false;
> >  	u32 status;
> > =20
> > -	status =3D queue_readl(queue, ISR);
> > +	spin_lock(&bp->lock);
> > =20
> > -	if (unlikely(!status))
> > +	status =3D queue_readl(queue, ISR);
>
> [...]
>
> > +	if (unlikely(!status)) {
> > +		spin_unlock(&bp->lock);
> >  		return IRQ_NONE;
> > -
> > -	spin_lock(&bp->lock);
> > +	}
>
> [Severity: High]
> Does unconditionally acquiring bp->lock in this shared IRQ handler before
> verifying the interrupt status introduce severe lock contention?
>
> Since macb_interrupt() is registered with IRQF_SHARED, it is called when
> another device on the same IRQ line triggers an interrupt.
>
> If macb_tx_error_task() is running on another CPU, it acquires bp->lock
> with IRQs disabled and polls hardware for up to 14ms (MACB_HALT_TIMEOUT):
>
> macb_tx_error_task() {
>     ...
>     spin_lock_irqsave(&bp->lock, flags);
>     netif_tx_stop_all_queues(bp->netdev);
>     if (macb_halt_tx(bp)) {
>     ...
> }
>
> During this time, wouldn't the CPU servicing the foreign interrupt spin o=
n
> bp->lock with local interrupts disabled for up to 14ms, only to eventuall=
y
> read ISR =3D=3D 0 and return IRQ_NONE? Could this stall other devices sha=
ring
> the IRQ line?

So it's describing two separate issues here.
As usual, Sashiko isn't the best at summaries.

 - macb_interrupt() now unconditionally grabs bp->lock. That combined
   with it being a shared IRQ =3D> when we land in the IRQ_NONE case we
   now have locked bp->lock for "no reason".

   =3D> As described before, correctness > performance. Here we don't have
      the choice unless we fully redesign the driver.

   See this reply to Sashiko on previous revision:
   https://lore.kernel.org/all/DKFGXHSHU73O.JE9E3TEWDAOX@bootlin.com/

 - macb_tx_error_task() has a codepath where it blocks bp->lock for a
   14ms timeout.

   =3D> Unrelated to this specific patch or even to the whole series.

Thanks,
--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

