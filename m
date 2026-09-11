Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852FB37A858
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148077; cv=none; b=JzJ+CdWRlEDVL5dtINJckga8AK4twSlGlb3cvNsANuQK/o9lVm17rRNAwiREKQ1ZsYMWx2rLCp9aoeoLStJ3ouasJ0O01FJsZe/fN6reFwsHDDqQpH9Ku6Oj/2Nu/S2+7i1U0QwKWC8rR6eQn7TmUNQueRP6N1Ix+OLI83t8uvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148077; c=relaxed/simple;
	bh=RBY7lZwtsfQ2RJkPc82K4STh6l7BokTJxRE8RtJ3/JA=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:In-Reply-To:
	 References:MIME-Version; b=PfBGVbO7lNFX6CJ0bgSCYMUColErBXVcph1RzXVoDjRaG72ssewXkKpS5guzep+VI64iEw7TakRHJHOoolS5h8xrna83r2sCPFKbecmyXGlHrQ2naIdpSDSC61y6wi97JnLoBHyiaPA4H8w9OtGypSLf8qwsA/7nLQcy6RKYSvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ATfplhYE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ATfplhYE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F18161A01EF;
	Fri, 11 Sep 2026 17:34:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C3E80601A3;
	Fri, 11 Sep 2026 17:34:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1759811C7AFAD;
	Fri, 11 Sep 2026 19:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789148071; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fEfwvzZ1FQaRICJYWrLud8DTMm74WpFOhCG7W2r2il4=;
	b=ATfplhYEV88PcT3XiAjw9fKztYqGx2rAsRBNdYPXjNV86iN2pPM0r86Xzo7hty9igtjTsT
	KI6D7BAflvJz2wSiRxLSUJ7dNxk2ayaHjfGs4P60ptoPACITLcm6SXtZUcOgNjqOX3CRQ4
	m+nK7d698ha/D0QLbmWmmOw/W5COlEJ96087uARn4dBwTS8IK2c8bbKAnoO81MyTnurakD
	cVONF+/vv/VLkwRjFQ4NaUVmoHTqAw+6aHTMtx+nN8vgt8YTnP8pYgiWYSkyNV6xBPo3fB
	KRO5/14VfFAxMyb/vOrSSFSYanXgRxwIHDQaCRjnIiUSKfLKsvgraQLZtmmR+Q==
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 19:33:55 +0200
Message-Id: <DLCO1OTT6D7E.3KIF8LWG9FMRT@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v9 15/17] net: macb: read ISR inside bp->lock
 critical section
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
In-Reply-To: <20260812-macb-context-v9-15-7ddbf5f715e0@bootlin.com>
References: <20260812-macb-context-v9-15-7ddbf5f715e0@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: P0s/ZTOr6xz1
X-Last-TLS-Session-Version: TLSv1.3

Replying to non-net sashiko
https://sashiko.dev/#/patchset/20260812-macb-context-v9-0-7ddbf5f715e0%40bo=
otlin.com

> commit 48c8a049fccfd5d7c55b15a7fd08dc4eca66d836
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> Date:   Wed Aug 12 08:03:29 2026 +0000
>
>     net: macb: read ISR inside bp->lock critical section
>    =20
>     The IRQ handler reads ISR register into the `status` stack variable.
>     If empty, it early returns. Else, it grabs bp->lock and iterates on
>     the status bits.
>    =20
>     We risk a race on spinlock acquire; status might have changed.
>     Move the readl(ISR) inside the bp->lock critical section.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index d23a0d08c2769..6d79663e42bfe 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -2190,12 +2190,13 @@ static irqreturn_t macb_interrupt(int irq, void=
 *dev_id)
> >  	bool hresp_err =3D false;
> >  	u32 status;
> > =20
> > -	status =3D queue_readl(queue, ISR);
> > +	spin_lock(&bp->lock);
>
> [Severity: High]
> Does taking this lock unconditionally cause severe latency spikes for oth=
er
> devices on a shared interrupt line?
>
> If a shared interrupt fires while the driver's error handling task is run=
ning,
> this CPU might spin with local interrupts disabled for up to 14ms:
>
> macb_tx_error_task()
>     spin_lock(&bp->lock);
>     macb_halt_tx()
>         read_poll_timeout_atomic(..., MACB_HALT_TIMEOUT, ...)
>
> (MACB_HALT_TIMEOUT is 14000us)

Yes this is correct. And something we will live with.
 - Our IRQ line is shared only with other queues of the same MAC.
 - That timeout is scaled to 10 Mbits/s, on 1G this timeout should be
   100 times smaller. We just don't bother scaling it with link speed.

[...]

> > -	if (unlikely(!status))
> > +	status =3D queue_readl(queue, ISR);
>
> [Severity: High]
> This is a pre-existing issue, but can this unconditional hardware registe=
r
> read trigger a synchronous external abort (bus fault) if the MAC is in
> runtime suspend?
>
> If another device on the same shared IRQ line triggers an interrupt while
> the MAC's clocks are gated via macb_clks_disable() in macb_runtime_suspen=
d(),
> accessing memory-mapped registers of a clock-gated peripheral typically
> causes a bus fault.

Again, we have IRQF_SHARED only to share with other queues of the same
MAC. So that theory is moot. Long term I'd like to drop IRQF_SHARED.

>
> > +	if (unlikely(!status)) {
> > +		spin_unlock(&bp->lock);
> >  		return IRQ_NONE;
> > -
> > -	spin_lock(&bp->lock);
> > +	}
> > =20
> >  	while (status) {
>
> [Severity: High]
> This is a pre-existing issue, but will this loop infinitely if an unhandl=
ed
> interrupt bit (like PFR) is set on hardware with Write-1-to-Clear ISR
> behavior?

Yes. Long term I'd like to introduce a max iteration count.
Completely unrelated to context swapping.

> [Severity: High]
> This isn't a bug introduced by this patch, but does the driver have a
> use-after-free risk during interface closure or driver removal?
>
> In macb_close(), the context structure is freed without synchronizing wit=
h
> or cancelling the asynchronous error tasks:

Yes. This one I'll fix. See previous email.

Re: [PATCH net-next v9 08/17] net: macb: introduce macb_context struct for =
buffer management
https://lore.kernel.org/netdev/DLCLQPVD8B9N.NFKWDS6SH0QN@bootlin.com/

[...]

---

Replying to net sashiko
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260812-macb-context-v=
9-0-7ddbf5f715e0%40bootlin.com

> commit 4cc0cf203c223199f230330ef1014c2cac4c4841
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: read ISR inside bp->lock critical section
>
> This moves the queue_readl(queue, ISR) in macb_interrupt() from before th=
e
> bp->lock acquisition to inside the critical section, and unlocks on the
> early return path when status is zero.  The stated goal is to avoid actin=
g
> on a stale ISR sample.
>
> > We risk a race on spinlock acquire; status might have changed.
> > Move the readl(ISR) inside the bp->lock critical section.
> >
> > In practice, we protect ourselves from interpreting the same ISR status
> > twice.
>
> [Severity: Low]
> [Finding: gpt-5-6-sol-1-3]
> [Sources: gpt-5-6-sol, opus-5]
> Could the changelog name the two contexts that can observe the same ISR
> sample, and the hardware precondition?

If any other context clears an IRQ then we race against that. Grep for
macb_queue_isr_clear in the code; for example the suspend !WOL case.
Maybe the commit message is badly written; it isn't a notion of
interpreting the same bit twice.

[...]

> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index d23a0d08c276..6d79663e42bf 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -2190,12 +2190,13 @@ static irqreturn_t macb_interrupt(int irq, void=
 *dev_id)
> >  	bool hresp_err =3D false;
> >  	u32 status;
> > =20
> > -	status =3D queue_readl(queue, ISR);
> > +	spin_lock(&bp->lock);
> > =20
> > -	if (unlikely(!status))
> > +	status =3D queue_readl(queue, ISR);
> > +	if (unlikely(!status)) {
> > +		spin_unlock(&bp->lock);
> >  		return IRQ_NONE;
> > -
> > -	spin_lock(&bp->lock);
> > +	}
>
> [Severity: Medium]
> [Finding: main-3-6]
> [Sources: opus-5]
> Does this remove the lock-free "not my interrupt" fast path?
>
> The handler is registered shared in macb_init():

Yes! Once again, we share only with other queues of the same MAC.
We don't support running alongside other devices.

[...]

Thanks,
--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

