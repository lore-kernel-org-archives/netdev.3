Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA5F436367
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785962; cv=none; b=gqnhrwuQApZHks27kJ3vAON11nKHSemVUp7kxPnaL4m5q7czczjw8aCq80iEKbsTnzPdmrbWGJuEqwm99Y5kh6fvMqA6mxlyL5O4mH0E5W7KSIvuVdklIElF4PBxig9YoHJo7G3oVYY0RaTPzyky5XJKKKqihaohrYPBlQN446U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785962; c=relaxed/simple;
	bh=3mazIFbz07baJz4PmYH3Q6fsnQB61HgJXZiiBI9AFAs=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:In-Reply-To:
	 References:MIME-Version; b=L37tCZsf+4HOTa+7ciw3k1k7RQ7AMbx9Mgs+cy/arU2m2WIQ+GnnijA1ulSgLWh0cHKhwaUt/bLY6DfvsMmM0PAvrCLuEHAtIZrgRZC2/ZrgZxX6VF9cOrBa9vD9yAIMq1PqBQ2HfnR4zY4e+jyHuMpRC6e+D+is5WKYNeZU1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p8g5OteO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p8g5OteO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 25C8C1A13BA;
	Mon,  3 Aug 2026 19:39:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EAE8E6029B;
	Mon,  3 Aug 2026 19:39:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E9C311C317A8;
	Mon,  3 Aug 2026 21:39:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785785950; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=q9hh347ohZbCsamaGfy/2Efrc1sGltQvJKUIpa+u8gQ=;
	b=p8g5OteOmeboj3C4Vdg34x20RU8hwBxXPdnWs3ZX/ty/HlgsZBT7CvWPkrbX13w3etNy4b
	OIsB4OIF+9KXss5iulSCUIt33+yWh4ngXmlu7YWxeVZnXq56D9aM0+4TlVJIJFb95mdY+O
	1YNO/SwprcGMrfg0vu/TpZ9Z0x+GMya2ocYLO0VSJZDX1AS8exCHtnkNSnWkOU3XRs2ZQY
	fFHrmAuXeLpUuCIkOhHv/5uelBiyHhuoTF1tAubs3cyNF0aCmNPO814VU/ZIRHWcq01eKD
	bG92jTnQL8qgHm/XggTy5klrxeWLC0j0Ns1s1Tg8Soypk2Isd7P1RW+tU4CeBQ==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 21:39:08 +0200
Message-Id: <DKFKAB3O29LV.F8JIKVNFNVWX@bootlin.com>
Subject: Re: [PATCH net-next v6 16/16] net: macb: use context swapping in
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
In-Reply-To: <20260731-macb-context-v6-16-49d5a1439d48@bootlin.com>
References: <20260731-macb-context-v6-16-49d5a1439d48@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: wu+S07sGo8OJ
X-Last-TLS-Session-Version: TLSv1.3

Replying to non-net sashiko
https://sashiko.dev/#/patchset/20260731-macb-context-v6-0-49d5a1439d48%40bo=
otlin.com

> commit 9ae1e293afffec7abe7929599ec74c61a5616ac7
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: use context swapping in .ndo_change_mtu()
>
> This commit uses the newly introduced context buffer management to implem=
ent
> .ndo_change_mtu() as a context swap. This resists memory pressure by fail=
ing
> without closing the interface and speeds up the process by avoiding PHY
> reinitialization. AT91 EMAC is refused with -EBUSY.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index c4818216ab702..30efe46ee0d3e 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -3507,11 +3507,29 @@ static int macb_close(struct net_device *netdev=
)
>
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
>
> > +		if (IS_ERR(new_ctx))
> > +			return PTR_ERR(new_ctx);
> > +
> > +		macb_context_swap_start(bp);
>
> [Severity: High]
> Can this sequence cause a deadlock?
>
> When calling macb_context_swap_start() here, it acquires bp->mac_cfg_lock=
 and
> then waits synchronously for bp->hresp_err_bh_work to finish via
> cancel_work_sync():
>
> [...]

Solved because macb_hresp_error_task() doesn't grab mac_cfg_lock
anymore.

> [Severity: High]
> Does this fast context swap wait for the hardware RX engine to become
> completely idle before freeing the old buffers?
>
> Looking at macb_context_swap_start(), it clears the Receive Enable (RE) b=
it in
> the NCR register to stop the RX engine, but doesn't appear to poll or wai=
t for
> the hardware to finish its current DMA operations.
>
> Then, when we reach macb_context_swap_end() below, the old memory and SKB=
s are
> freed immediately. If the hardware is still in the process of finishing a
> large packet reception, could it continue writing data into the now-freed=
 skb
> buffers and corrupt memory?

The documented shutdown sequence is

   writel(readl(NCR) & ~RE, NCR);

I just re-checked the manual.
My guess is the LLM got that idea from this comment:

   static void macb_reset_hw(struct macb *bp)
   {
      u32 ctrl =3D macb_readl(bp, NCR);

      /* Disable RX and TX (XXX: Should we halt the transmission
       * more gracefully?)
       */
      ctrl &=3D ~(MACB_BIT(RE) | MACB_BIT(TE));

      // ...
   }

We should drop it, but again no commit budget is available here.

>
> > +	}
> > =20
> >  	WRITE_ONCE(netdev->mtu, new_mtu);
> > =20
> > +	if (running)
> > +		macb_context_swap_end(bp, new_ctx);
>
> [Severity: Medium]
> Does this unconditionally wake the TX queues regardless of the link state=
?
>
> The driver correctly halts and stops TX queues in macb_mac_link_down() to
> prevent queuing to disabled hardware. However, calling macb_context_swap_=
end()
> here finishes with:
>
> macb_context_swap_end() {
>         ...
>         netif_tx_start_all_queues(bp->netdev);
> }
>
> If the link is currently down, doesn't this improperly clear the XOFF sta=
te
> set by the link-down handler, allowing packets to be enqueued while the
> transmitter is disabled in hardware?

Second time the LLM reports this. netif_tx_start_all_queues() is done at
open. So it means from open to link-up we have the same issue.

If we don't do that at swap_end, even if we are currently link-down,
then the upcoming link-up will not start the queues, so they will stay
off.

>
> [Severity: Medium]
> Does the context swap sequence fail to restore the Energy Efficient Ether=
net
> (LPI) state?
>
> macb_context_swap_start() explicitly cancels the delayed work bp->tx_lpi_=
work
> to prevent it from firing during the swap.
>
> However, macb_context_swap_end() doesn't seem to contain any logic to res=
tart
> the timer or re-enable LPI. If the interface was idle and bp->eee_active =
is
> true, will this leave the hardware in a higher power state indefinitely u=
ntil
> a new packet is transmitted?

Correct. Fixed. See
https://lore.kernel.org/all/DKFJUAD77C4T.38O5CM12TVT5M@bootlin.com/

---

Replying to net sashiko
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731-macb-context-v=
6-0-49d5a1439d48%40bootlin.com

> commit cc76a66faa22e273620a90e8d48f9af6c96113e2
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: use context swapping in .ndo_change_mtu()
>
> This converts macb_change_mtu() from refusing MTU changes on a running
> interface into a context swap: allocate a new context, reconfigure the
> hardware via macb_context_swap_start()/macb_context_swap_end(), then free
> the old context. AT91 EMAC devices are meant to be refused with -EBUSY.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index c4818216ab702..30efe46ee0d3e 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -3507,11 +3507,29 @@ static int macb_close(struct net_device *netdev=
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
>
> [Severity: Low]
> [Finding: fable-5-1-1]
> [Sources: fable-5, opus-5]
> Can this branch ever be reached?  MACB_CAPS_MACB_IS_EMAC is only set by
> emac_config, whose .init is at91ether_init(), and at91ether_init()
> installs at91ether_netdev_ops:
>
> [...]

Correct. I'll keep it anyway. It costs nothing and we might want to
unify ndo in the future.

For example I just noticed that ndo_tx_timeout (which got contributed
recently) hasn't landed for EMAC, even though it could make sense.

And I like seeing easily when reading the code that there is no chance
we ever land in swap_start/end from EMAC.

> That also makes this part of the commit message inaccurate:
>
> 	AT91 EMAC is handled differently as their buffer management is separate
> 	and they don't do NAPI. We refuse them (-EBUSY) to avoid implementing
> 	context swapping for them.
>
> Nothing is actually refused here.  Note the identical guard in
> macb_set_ringparam() is reachable, because at91ether_init() does install
> the shared macb_ethtool_ops, which likely explains the copy.

I'll fix the commit message however.

> > +
> > +		macb_context_swap_start(bp);
>
> [Severity: High]
> [Finding: fable-5-5-9]
> [Sources: fable-5, opus-5]
> Can this deadlock against the HRESP work item?
>
> [...]

Fixed because macb_hresp_error_task() doesn't grab the mutex anymore.

> [Severity: High]
> [Finding: main-5-7]
> [Sources: opus-5]
> Related to the above, is it valid for macb_hresp_error_task() to take a
> mutex at all?  The work is dispatched on a BH workqueue:
>
> [...]

Fixed because macb_hresp_error_task() doesn't grab the mutex anymore.

>
> > =20
> >  	WRITE_ONCE(netdev->mtu, new_mtu);
> > =20
> > +	if (running)
> > +		macb_context_swap_end(bp, new_ctx);
>
> [Severity: High]
> [Finding: fable-5-5-10]
> [Sources: fable-5]
> Can the carrier test in macb_context_swap_end() leave RX/TX disabled for
> good?  The re-enable is conditional:
>
> 	if (netif_carrier_ok(bp->netdev)) {
> 		... queue_writel(queue, IER, ...);
> 		macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
> 	}
>
> [...]

Fixed. Have our own redundant bp->link_up that lives under
bp->mac_cfg_lock's protection. See
https://lore.kernel.org/all/DKFJUAD77C4T.38O5CM12TVT5M@bootlin.com/

Thanks,

--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
