Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130013AFD19
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776496; cv=none; b=ehyPN/WXxhyI0MiX4rUOBoVcYNcjmNPgE55pfGn903FaZxGUdoaudFlEcLIkRjaLR3zUQLLDJx2Oa9MsypJ0EaAIHWnaCvOk4lsqeDh8+RYSJPqkO1UWiw7s78Nrh0qophjHedIIyCxnTMcGQXPyCjTnuJOdraZnKMm9JccTXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776496; c=relaxed/simple;
	bh=T7Xbv1HPgC8KcKf+J7vR+jsy468TNNxGnUktUUdkaK0=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:In-Reply-To:
	 References:MIME-Version; b=de1x4sfyIs7FE7q5mYZ824gPVt9xRTXKMHmUdrgKXHpI/eFuRxJtQxoZ3yX/plAarN5pWEONyLuUxxf2VbfK/q6CqMZhKsBKOJJ1OpoayZ/9fNMDJ311vNTGuto5bNcgX10w61UgWrdfZ/z/Rl9QVvcg8vQ8GTrOBOVyrcCAxyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b1A3PKk5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b1A3PKk5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2ECC51A13D9;
	Mon,  3 Aug 2026 17:01:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E815B6029B;
	Mon,  3 Aug 2026 17:01:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7833611C31389;
	Mon,  3 Aug 2026 19:01:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785776486; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Jtde3NvxnHWnhn3+uGuUKoEjppDuNtou4ptMWknv9Og=;
	b=b1A3PKk5lkEXomNXKw8vVqwb5GLx5ggkCet8mYIHi4BPigZAQaIKN0XsDlgHPe9fQ4kJDR
	/gCG9NJbVouJ1N9FG/oxlKTfBsHlmCltACdJuGDI4efQBDY8O56AFMLgFX6+c9NcUBIveB
	bxuHsNMRMFK2DcF+CsTldrgS+7Fti8lZDnq6CnL6KwfSceGO1Ygv9/u8Gw5NKx7Hl8d0ns
	WUS385d68bu5qtHkCPv8EoGBoshPscl7JCpzQHPSap2lyzRInxtUcWCmf6zhNIZibhDzyR
	wnJzB49OtPZ7tq6cSMKfZ6D1L2OWnSwS0rs2jybRw7QDdeofjB6JUb8Yea1iAg==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 19:01:20 +0200
Message-Id: <DKFGXHSHU73O.JE9E3TEWDAOX@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v6 14/16] net: macb: read ISR inside bp->lock
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
In-Reply-To: <20260731-macb-context-v6-14-49d5a1439d48@bootlin.com>
References: <20260731-macb-context-v6-14-49d5a1439d48@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: bf927u7YwvMn
X-Last-TLS-Session-Version: TLSv1.3

Replying to non-net sashiko
https://sashiko.dev/#/patchset/20260731-macb-context-v6-0-49d5a1439d48%40bo=
otlin.com

> commit c95e9317ebb0315f714eea20911c711f5b1a1ce7
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: read ISR inside bp->lock critical section
>
> This commit moves the read of the Interrupt Status Register (ISR)
> inside the spinlock critical section in the macb_interrupt handler.
> The intention is to prevent a race condition where the status might
> change before the lock is acquired.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -2190,12 +2190,13 @@ static irqreturn_t macb_interrupt(int irq, void=
 *dev_id)
> >  	struct net_device *netdev =3D bp->netdev;
> >  	u32 status;
> > =20
> > +	spin_lock(&bp->lock);
>
> [Severity: High]
> Does this unconditional lock acquisition cause hardirq stalls for shared
> interrupts?
>
> If this device shares an IRQ line, macb_interrupt() is called for other
> devices' interrupts and will grab bp->lock before checking the ISR regist=
er.
>
> If another CPU is executing macb_tx_error_task(), which holds bp->lock an=
d
> can stall for up to 14ms via macb_halt_tx(), wouldn't the CPU handling th=
e
> shared interrupt spin with hard IRQs disabled for the entire duration?

Yes, and we cannot do anything better (at least ATM).
 - If we readl(ISR) outside bp->lock, it might contain an outdated value
   once we enter bp->lock.
 - To fix, we must readl(ISR) inside bp->lock, but then we risk stalling
   in this above (niche) case.

To recap the edge case described: we must have had a tx error
(MACB_TX_ERR_FLAGS) and have the HW refuse to halt (I don't know in
which context it can occur & I've never seen that).

Picking correctness > performance, we'll tolerate the latency risk.

> [Severity: Critical]
> Can this lead to a recursive spinlock deadlock when netconsole is active?
>
> If a hardware error like HRESP occurs, macb_interrupt_misc() logs the err=
or
> using netdev_err(). When netconsole is enabled on this interface, the pri=
ntk()
> call synchronously invokes netpoll_send_skb_on_dev(), which recursively c=
alls
> macb_poll_controller().
>
> Since macb_poll_controller() calls macb_interrupt() on the same CPU, and =
the
> outer macb_interrupt() execution already holds bp->lock, will this inner
> attempt to acquire the same lock spin forever?

Yes, this was reported on [13/16].
https://lore.kernel.org/all/DKFFXBM6VKXZ.22PW13MLAXSF@bootlin.com/

Solution: defer the netdev_err() out of the critical section.

---

Replying to net sashiko
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731-macb-context-v=
6-0-49d5a1439d48%40bootlin.com

> commit d8496423c6f6f3cdfb35cfe0e924250ba7610fa1
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: read ISR inside bp->lock critical section
>
> The macb IRQ handler used to read the queue ISR register before taking
> bp->lock, and returned IRQ_NONE without touching the lock when the read
> came back empty.  This patch moves the ISR read inside the bp->lock
> critical section, so the lock is now acquired unconditionally at handler
> entry.
>
> No Link: tags are present in the commit header.
>
> > net: macb: read ISR inside bp->lock critical section
> >
> > The IRQ handler reads ISR register into the `status` stack variable.
> > If empty, it early returns. Else, it grabs bp->lock and iterates on
> > the status bits.
> >
> > We risk a race on spinlock acquire; status might have changed.
> > Move the readl(ISR) inside the bp->lock critical section.
> >
> > One risk remains with spurious interrupts that would, in addition to
> > taking excessive CPU time, also create lock contention. How bad is it?
> > Probably not too bad.
>
> [Severity: Low]
> [Finding: main-1-1]
> [Sources: opus-5, old-prompts]
> This isn't a bug, but could the changelog name the concrete symptom?
>
> "We risk a race on spinlock acquire; status might have changed" does not
> say what breaks.  The pre-patch handler already re-read ISR at the bottom
> of its loop:
>
> drivers/net/ethernet/cadence/macb_main.c:macb_interrupt() {
> 	...
> 		status =3D queue_readl(queue, ISR);
> 	}
>
> 	spin_unlock(&bp->lock);
> 	...
> }
>
> so a stale first snapshot was tolerated by design.
>
> The rest of the series does supply a rationale that the message leaves
> out: macb_context_swap_start() sets bp->ctx_swap and does
> queue_writel(IDR, -1) / queue_readl(ISR) / macb_queue_isr_clear(-1)
> under spin_lock_irqsave(&bp->lock), and the handler's locked loop then
> tests bp->ctx_swap.  Reading ISR under bp->lock is what keeps the status
> snapshot consistent with that state.

This paragraph about bp->ctx_swap is fuzzy to me and sounds wrong. It
isn't ISR being read in bp->lock that saves us, it is bp->ctx_swap
being read in bp->lock. And that is always done (introduced in this
series).

> Would it be worth spelling that dependency out in the changelog, and
> quantifying "Probably not too bad" rather than leaving it open?

The goal is to avoid duplicated handling of the same ISR status. So all
macb_interrupt() codepaths that have side-effects are at risk. Most
should handle it fine in the normal case, but we are at risk:

 - Two napi_schedule_irqoff() are idempotent if fast enough.

 - Two schedule_work(tx_error_task) are idempotent if fast enough.

 - Double increment of rx_overruns.

 - Two queue_work(hresp_err_bh_work) are idempotent if fast enough.

 - Two pm_wakeup_event() is safe.

I'll expand the commit message.

> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 65d5ff8a5e230..27824e4688882 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -2190,12 +2190,13 @@ static irqreturn_t macb_interrupt(int irq, void=
 *dev_id)
> >  	struct net_device *netdev =3D bp->netdev;
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
> [Severity: High]
> [Finding: main-1-0]
> [Sources: opus-5, old-prompts]
> Can this recursively acquire bp->lock when netconsole is in use?
>
> macb_interrupt() now takes bp->lock before it knows whether the interrupt
> belongs to this device, and printk() calls still run inside that critical
> section.  macb_interrupt_misc() is called from within the locked loop and
> does:
>
> [...]

This is the same report as above and as in [13/16].

 - Moved the netdev_err() out of the macb_interrupt() bp->lock.

 - Ignoring voluntarily the debug calls. If you are debugging the MACB
   driver then you know what you are doing. And you probably don't want
   to debug MACB using netconsole...

> [Severity: Medium]
> [Finding: main-5-5]
> [Sources: opus-5, old-prompts]
> Does this add hardirq latency for other devices on the shared line?
>
> The interrupt is requested shared:
>
> drivers/net/ethernet/cadence/macb_main.c:macb_probe() {
> 	...
> 		err =3D devm_request_irq(&pdev->dev, queue->irq, macb_interrupt,
> 				       IRQF_SHARED, netdev->name, queue);
> 	...
> }
>
> so macb_interrupt() also runs for interrupts owned by other devices on
> the line and for spurious/level assertions.  Those cases used to complete
> lock-free in two MMIO cycles; now they block on bp->lock first.
>
> [...]

Yes it can add latency. No we cannot do anything in this series. Here we
just fix a correctness bug.

Proper fixes would be:

 - Per-queue locking mechanism.

 - I expect the main (only?) reason for shared support is queues using
   the same IRQ lane. In that case it would be more efficient to
   acquire a single handler that handles all queues at once.

   Instead of calling macb_interrupt() N times and locking N times, we'd
   do it once and iterate inside.

Both are completely unrelated to this series. Here, as said before, we
do correctness > performance.

Thanks,

--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
