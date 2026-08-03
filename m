Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FBF4334C9;
	Mon,  3 Aug 2026 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784711; cv=none; b=j+niyJLIjHcwtUzI2PSft/6NhOSuUHXYUykwOHvmd4EF59+LFex/2DJ1th/QJ5mQi/SksYmcwN8C79SoiyTuw/cUbyLhFO8zdcuIdD7f4jjHseaZRmd0fnrttVb2CQVFjvrJd/6gz5N9NnXrh8lYoOYX13wbdq1/XL5lXaZmK+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784711; c=relaxed/simple;
	bh=CATI9xCeGtvzKJRzWMzqM7wZ6TO/1KS3TTXIVN/LUlo=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:In-Reply-To:
	 References:MIME-Version; b=il8jry01uOZzxxri1+AnIxvlpy4rGIPTyb3/MqPytR347bkacPuvy6a121Md5GIqTsSbxBbWyrxMuldBuM7EjyzYAAEb8XhRgZQqHEm2cPzWzPgg7QBAA0BRxQPq7zf044oQ+CInr9VsxTnEFM0gwHZnGvDSb17/oI5Wo4P9auA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kTnuCndx; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kTnuCndx"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2CF924E410C3;
	Mon,  3 Aug 2026 19:18:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E62C96029B;
	Mon,  3 Aug 2026 19:18:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 378E511C3171E;
	Mon,  3 Aug 2026 21:18:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785784698; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sBF3qMdLWX1bRkOQe1N2/Rkrh3AqAqHNlX3DR5RBHGo=;
	b=kTnuCndxvdYzI6tRxH0AgTJErfXcJxZJSPYWGPP6W5seArNDqjkJ/IMhDUis/JMD/cDFGI
	6FVuGxNWccDNE9Rs9pLTCTuyV4iCkWIrbdhyfeDFg8KJvsPWovfVJiHaJJKohwWBmoGrSF
	7++ivzbDhfo0Q0JBAU/i0m58Svx9BwCp4U0w1pSPSF6aD1MMXc58aoHBbUDCIMfjtG0Iol
	2EAEFAROk8euyMq/xiSbfeaMZkZpPpxzcDCVK2643M7x6cW23AMxDyH3QPmupGcaVN/Zw8
	HdFNWrs5EPN3euYQVLOVobY4yYnQJ74P2TiYTgTyrU+zypiVe0ZqIMWczsQ/Dw==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 21:18:12 +0200
Message-Id: <DKFJUAD77C4T.38O5CM12TVT5M@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next v6 15/16] net: macb: use context swapping in
 .set_ringparam()
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
In-Reply-To: <20260731-macb-context-v6-15-49d5a1439d48@bootlin.com>
References: <20260731-macb-context-v6-15-49d5a1439d48@bootlin.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUID: Ie0vCidSH6hX
X-Last-TLS-Session-Version: TLSv1.3

Replying to non-net sashiko
https://sashiko.dev/#/patchset/20260731-macb-context-v6-0-49d5a1439d48%40bo=
otlin.com

> commit 8a3daa4202dd4f165c64eba757df11df91e1ba93
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> Subject: net: macb: use context swapping in .set_ringparam()
>
> This patch updates the set_ringparam ethtool operation to swap the contex=
t
> instead of completely closing and opening the interface. It introduces a
> new mutex, mac_cfg_lock, to serialize the context swap against phylink MA=
C
> callbacks, and implements helper functions to pause and restart interface
> hardware during the swap.
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 27824e4688882..c4818216ab702 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
>
> [ ... ]
>
> > @@ -2064,6 +2081,8 @@ static void macb_hresp_error_task(struct work_str=
uct *work)
> >  	unsigned int q;
> >  	u32 ctrl;
> > =20
> > +	mutex_lock(&bp->mac_cfg_lock);
> > +
>
> [Severity: High]
> Can we safely acquire a mutex here?
>
> The hresp_err_bh_work is queued to system_bh_wq in macb_interrupt(), whic=
h=20
> is a bottom-half workqueue executing in softirq context. Calling mutex_lo=
ck()
> from a softirq context might cause a system crash or thread freeze due to
> sleeping in an atomic context.

This is correct. The macb_hresp_error_task() function name doesn't hint
at it running in BH, I thought it was a kthread context. I don't have
any commit budget remaining to fix that up in this series.

I added that mutex_lock() in the past iteration as we now do

   if (netif_carrier_ok(bp->netdev)) { /* ... */ }

on swap_end instead of carelessly re-enabling the MAC. I wanted to avoid
races inbetween anything that can change the carrier state, that is
phylink ops and macb_hresp_error_task().

But actually macb_hresp_error_task() will only ever toggle the carrier,
and it has been disabled + we waited for its end in swap_start using
cancel_work_sync(hresp_err_bh_work), so we are not risking any race
inbetween swap_end reading netif_carrier_ok() and
macb_hresp_error_task().

Mutex can be removed!

>
> [ ... ]
>
> > @@ -3098,6 +3121,126 @@ static void macb_configure_dma(struct macb *bp)
> > +static void macb_context_swap_start(struct macb *bp)
> > +{
> > +	struct macb_queue *queue;
> > +	unsigned long flags;
> > +	unsigned int q;
> > +	u32 ctrl;
> > +
> > +	mutex_lock(&bp->mac_cfg_lock);
> > +
>
> [ ... ]
>
> > +	/* Drain BH features. HW is still active and usable at this point but
> > +	 * IRQs are being ignored.
> > +	 */
> > +
> > +	cancel_work_sync(&bp->hresp_err_bh_work);
>
> [Severity: High]
> Is there a risk of an AB-BA deadlock here if macb_hresp_error_task is
> executing concurrently?
>
> It looks like macb_context_swap_start() acquires mac_cfg_lock and then
> calls cancel_work_sync(). Concurrently, if macb_hresp_error_task() is
> running, it will attempt to acquire the exact same mac_cfg_lock, causing
> the workqueue worker and the process to wait on each other indefinitely.

Solved now that macb_hresp_error_task() doesn't grab mac_cfg_lock.

>
> > +
> > +	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue)=
 {
>
> [ ... ]
>
> > +	/* Now that everything is stopped, clear DQL. */
> > +	for (q =3D 0; q < bp->num_queues; ++q)
> > +		netdev_tx_reset_queue(netdev_get_tx_queue(bp->netdev, q));
> > +
> > +	spin_lock_irqsave(&bp->lock, flags);
> > +
> > +	/* Whether it fails or not we'll disable TE/RE next.
> > +	 * We were just trying to be nice.
> > +	 */
> > +	macb_halt_tx(bp);
>
> [Severity: Medium]
> Does calling macb_halt_tx() while holding a spinlock with interrupts
> disabled risk causing system stalls?
>
> It looks like macb_halt_tx() uses read_poll_timeout_atomic() with a
> timeout of 14000 microseconds (14ms). Spinning for up to 14ms with
> interrupts disabled might lead to high interrupt latency, dropped frames,
> or soft lockup warnings.

Well dropped frames on our interface wouldn't be a surprise as we
stopped all frame processing.

But indeed local CPU having IRQs disabled for 14ms is not being a nice
kernel citizen. We can safely move macb_halt_tx() out:
 - all schedule-able features are disabled (napi, bh error task, etc)
 - IRQs should be masked, even if they aren't bp->ctx_swap protects us
   and they can only readl(ISR).

So we cannot race with anything, no other context can access the HW.

>
> > +
> > +	ctrl =3D macb_readl(bp, NCR);
>
> [ ... ]
>
> > +static void macb_context_swap_end(struct macb *bp,
> > +				  struct macb_context *new_ctx)
> > +{
>
> [ ... ]
>
> > +	if (netif_carrier_ok(bp->netdev)) {
> > +		for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue=
) {
> > +			queue_writel(queue, IER,
> > +				     bp->rx_intr_mask |
> > +				     MACB_TX_INT_FLAGS |
> > +				     MACB_BIT(HRESP));
> > +		}
> > +
> > +		ctrl =3D macb_readl(bp, NCR);
> > +		macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
> > +	}
> > +
> > +	spin_unlock_irqrestore(&bp->lock, flags);
> > +
> > +	netif_tx_start_all_queues(bp->netdev);
>
> [Severity: High]
> Should this check if the carrier is OK before starting the TX queues?
>
> If ethtool changes the ring parameters while the network carrier is down,
> this will unconditionally wake all transmission queues without waiting
> for a link-up event. This could lead to packets being enqueued while
> hardware transmission is still disabled, potentially filling up the TX
> ring indefinitely.

If we don't do it now then no one else will do it. Link-up doesn't do
the call, it is open that does it. So we must do it here*.

* if we don't want to rework the full open sequence and we already do
  enough in this series.

---

Replying to net sashiko
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731-macb-context-v=
6-0-49d5a1439d48%40bootlin.com

> commit 7b9b44595a5ec14091f66817bfeb0843ce943c3f
> Author: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>
> net: macb: use context swapping in .set_ringparam()
>
> Reworks macb's ethtool set_ringparam so that a new buffer context is
> allocated before the interface is disturbed, then swapped in via new
> macb_context_swap_start() / macb_context_swap_end() helpers. A new
> mac_cfg_lock mutex serialises the swap against the phylink MAC callbacks,
> and AT91 EMAC is refused with -EBUSY.
>
> A few questions below about the new mutex and the swap sequence.
>
> > diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet=
/cadence/macb.h
> > index ac2f2d8065d77..93e513cf1fbbf 100644
> > --- a/drivers/net/ethernet/cadence/macb.h
> > +++ b/drivers/net/ethernet/cadence/macb.h
> > @@ -1361,6 +1361,8 @@ struct macb {
> >  	struct macb_queue	queues[MACB_MAX_QUEUES];
> > =20
> >  	spinlock_t		lock;
> > +	/* Serializes context swap against phylink MAC callbacks. */
> > +	struct mutex		mac_cfg_lock;
> >  	struct clk		*pclk;
> >  	struct clk		*hclk;
> >  	struct clk		*tx_clk;
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
> > index 27824e4688882..c4818216ab702 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
>
> [ ... ]
>
> > @@ -750,6 +754,8 @@ static int macb_mac_enable_tx_lpi(struct phylink_co=
nfig *config, u32 timer,
> >  	struct macb *bp =3D netdev_priv(netdev);
> >  	unsigned long flags;
> > =20
> > +	mutex_lock(&bp->mac_cfg_lock);
> > +
> >  	spin_lock_irqsave(&bp->lock, flags);
> >  	bp->tx_lpi_timer =3D timer;
> >  	bp->eee_active =3D true;
> > @@ -760,6 +766,8 @@ static int macb_mac_enable_tx_lpi(struct phylink_co=
nfig *config, u32 timer,
> >  	 */
> >  	mod_delayed_work(system_wq, &bp->tx_lpi_work, msecs_to_jiffies(1000))=
;
> > =20
> > +	mutex_unlock(&bp->mac_cfg_lock);
> > +
> >  	return 0;
> >  }
>
> [ ... ]
>
> > @@ -932,6 +946,7 @@ static void macb_mac_link_up(struct phylink_config =
*config,
> >  	unsigned int q;
> >  	u32 ctrl;
> > =20
> > +	mutex_lock(&bp->mac_cfg_lock);
> >  	spin_lock_irqsave(&bp->lock, flags);
> > =20
> >  	ctrl =3D macb_or_gem_readl(bp, NCFGR);
> > @@ -983,6 +998,8 @@ static void macb_mac_link_up(struct phylink_config =
*config,
> >  	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
> > =20
> >  	netif_tx_wake_all_queues(netdev);
> > +
> > +	mutex_unlock(&bp->mac_cfg_lock);
> >  }
>
> [ ... ]
>
> > @@ -2064,6 +2081,8 @@ static void macb_hresp_error_task(struct work_str=
uct *work)
> >  	unsigned int q;
> >  	u32 ctrl;
> > =20
> > +	mutex_lock(&bp->mac_cfg_lock);
> > +
>
> [Severity: High]
> [Finding: main-2-2]
> [Sources: opus-5]
> Is macb_hresp_error_task() allowed to take a sleeping lock?  The work ite=
m
> is queued onto the BH workqueue from the interrupt handler:
>
> [...]

Same remark as non-net sashiko. Fixed by removing the mutex. See above
for why it is safe to remove.

> >  	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue)=
 {
> >  		queue_writel(queue, IDR, bp->rx_intr_mask |
> >  					 MACB_TX_INT_FLAGS |
> > @@ -2093,6 +2112,8 @@ static void macb_hresp_error_task(struct work_str=
uct *work)
> > =20
> >  	netif_carrier_on(netdev);
> >  	netif_tx_start_all_queues(netdev);
> > +
> > +	mutex_unlock(&bp->mac_cfg_lock);
> >  }
>
> [ ... ]
>
> > @@ -3098,6 +3121,126 @@ static void macb_configure_dma(struct macb *bp)
> >  	}
> >  }
> > =20
> > +static void macb_context_swap_start(struct macb *bp)
> > +{
> > +	struct macb_queue *queue;
> > +	unsigned long flags;
> > +	unsigned int q;
> > +	u32 ctrl;
> > +
> > +	mutex_lock(&bp->mac_cfg_lock);
> > +
> > +	/* We cannot mask IRQs because they'll get re-armed by BH. So instead=
 we
> > +	 * signal to IRQ handler it shouldn't drive BH features and should
> > +	 * self-disarm.
> > +	 */
> > +	spin_lock_irqsave(&bp->lock, flags);
> > +	bp->ctx_swap =3D true;
> > +	spin_unlock_irqrestore(&bp->lock, flags);
> > +
> > +	/* Drain BH features. HW is still active and usable at this point but
> > +	 * IRQs are being ignored.
> > +	 */
> > +
> > +	cancel_work_sync(&bp->hresp_err_bh_work);
>
> [Severity: High]
> [Finding: main-2-3]
> [Sources: opus-5]
> Can this deadlock against macb_hresp_error_task()?  mac_cfg_lock is taken
> at the top of macb_context_swap_start() and is only dropped in
> macb_context_swap_end(), so cancel_work_sync() here runs with the mutex
> held, while the work being cancelled now starts with:
>
> [...]

Well there is echo here? echo ... echo ...

> > +
> > +		napi_disable(&queue->napi_rx);
> > +		napi_disable(&queue->napi_tx);
> > +	}
> > +
> > +	/* Must be done after napi_tx is disabled. */
> > +	cancel_delayed_work_sync(&bp->tx_lpi_work);
>
> [Severity: Low]
> [Finding: main-7-16]
> [Sources: opus-5]
> This isn't a bug, but is the cancelled LPI work ever re-armed?
>
> macb_tx_lpi_work_fn() is the only place that sets NCR bit TXLPIEN, and th=
e
> work is armed from just two places: macb_mac_enable_tx_lpi() (1 second
> after link-up) and macb_tx_lpi_schedule() called from macb_tx_complete()
> when packets completed.
>
> Since the swap deliberately does not stop phylink, mac_enable_tx_lpi() is
> not called again, and macb_context_swap_end() contains no
> macb_tx_lpi_schedule().  So after an ethtool -G on an idle EEE link,
> bp->eee_active stays true but the transmitter would not enter LPI until t=
he
> next Tx completion re-arms the timer.
>
> Note the contrast with macb_mac_disable_tx_lpi(), which pairs its cancel
> with an explicit macb_tx_lpi_set(bp, false); the swap path has neither th=
e
> register update nor a re-arm.

So we don't technically need to re-arm anything.

There is one edge case I can think about, I'm not sure if that's what
the above paragraphs point at. If link is silent after swap:
 - t=3D0.0s link up, enable EEE =3D> schedule EEE for t=3D1.0s
 - t=3D0.5s set_ringparam / change_mtu =3D> swap =3D> stop pending delayed_=
work
 - ... no EEE active until next NAPI poll ...

So we do want to re-arm, just in case. The safe value is the same as
documented in macb_mac_enable_tx_lpi():

   /* Defer initial LPI entry by 1 second after link-up per
    * IEEE 802.3az section 22.7a.
    */
   mod_delayed_work(system_wq, &bp->tx_lpi_work, msecs_to_jiffies(1000));

We might have our swap milliseconds after link-up so let's defer by that
amount. Worst case we have LPI disabled for 2s instead of 1s.

> > +	spin_lock_irqsave(&bp->lock, flags);
> > +
> > +	/* Re-arm normal interrupt processing before enabling IRQs. */
> > +	bp->ctx_swap =3D false;
> > +
> > +	macb_configure_dma(bp);
> > +
> > +	if (netif_carrier_ok(bp->netdev)) {
> > +		for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue=
) {
> > +			queue_writel(queue, IER,
> > +				     bp->rx_intr_mask |
> > +				     MACB_TX_INT_FLAGS |
> > +				     MACB_BIT(HRESP));
> > +		}
> > +
> > +		ctrl =3D macb_readl(bp, NCR);
> > +		macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
> > +	}
>
> [Severity: High]
> [Finding: main-2-4]
> [Sources: opus-5]
> Is netif_carrier_ok() reliable here?  phylink publishes the carrier bit
> only after mac_link_up() has returned and released mac_cfg_lock:
>
> drivers/net/phy/phylink.c:phylink_link_up() {
> 	...
> 	pl->mac_ops->mac_link_up(pl->config, pl->phydev, ...);
>
> 	if (pl->mac_supports_eee && pl->phy_enable_tx_lpi)
> 		phylink_activate_lpi(pl);
>
> 	if (ndev)
> 		netif_carrier_on(ndev);
> }
>
> A swap that grabs the mutex in that window sees carrier off, so the IER
> writes and the NCR RE|TE write are both skipped, yet
> netif_tx_start_all_queues() still runs right after.  With EEE in use the
> window covers the whole swap, because phylink_activate_lpi() ->
> macb_mac_enable_tx_lpi() blocks on mac_cfg_lock until
> macb_context_swap_end() unlocks.
>
> Would the interface then be left with RE/TE cleared and every queue
> interrupt masked (macb_context_swap_start() wrote IDR =3D -1) while the s=
tack
> believes the link is up?  No TCOMP/RCOMP interrupt can arrive to restart
> NAPI, and the watchdog does not help:
>
> drivers/net/ethernet/cadence/macb_main.c:macb_tx_timeout() {
> 	struct macb *bp =3D netdev_priv(netdev);
>
> 	macb_tx_restart(&bp->queues[q]);
> }
>
> which only writes TSTART.  Would it be safer to program IER and RE|TE
> unconditionally, or to track link state under mac_cfg_lock instead of
> reading the carrier bit?

There is a race yes.

No to the

> Would it be safer to program IER and RE|TE unconditionally

part. We don't want to enable the MAC while link is down. That would
open up a new world of discoveries.

Let's track link state in a bp->link_up boolean. It's sad because it's
duplicate info but we must own that info to garantee synchronisation.

(All that would be simpler if drivers were allowed to grab a phylink
mutex whenever they want. So that mutex would be grabbed implictly on
phylink ops, as done currently, but for synchroning with phylink ops we
could grab it at any point in time.)

>
> > +
> > +	spin_unlock_irqrestore(&bp->lock, flags);
> > +
> > +	netif_tx_start_all_queues(bp->netdev);
> > +
> > +	mutex_unlock(&bp->mac_cfg_lock);
> > +
> > +	/* Free old context. */
> > +
> > +	macb_free(old_ctx);
> > +	kfree(old_ctx);
> > +}
> > +
>
> [ ... ]
>
> > @@ -3842,16 +3986,24 @@ static int macb_set_ringparam(struct net_device=
 *netdev,
> >  		return 0;
> >  	}
> > =20
> > -	if (netif_running(bp->netdev)) {
> > -		reset =3D 1;
> > -		macb_close(bp->netdev);
> > +	if (running) {
> > +		/* Context swapping is not supported for AT91. */
> > +		if (bp->caps & MACB_CAPS_MACB_IS_EMAC)
> > +			return -EBUSY;
>
> [Severity: Low]
> [Finding: main-1-1]
> [Sources: opus-5]
> This isn't a bug, but is -EBUSY the right errno?  at91ether_init() instal=
ls
> the same macb_ethtool_ops, so this path is reachable on EMAC hardware, an=
d
> the condition can never clear while the interface is up - only a down/up
> works.  A userspace retry loop, which is the usual reaction to EBUSY, wou=
ld
> spin forever.  Would -EOPNOTSUPP plus an extack message (extack is alread=
y
> a parameter of this callback) describe it better?
>
> The commit message says:
>
>     AT91 EMAC is handled differently as their buffer management is separa=
te
>     and they don't do NAPI. We refuse them (-EBUSY) to avoid implementing
>     context swapping for them.
>
> Could it also mention that this is a userspace-visible behaviour change,
> i.e. that ethtool -G on a running at91ether interface used to succeed
> (updating the values reported by ethtool -g) and now fails?

Dropped because now we refuse all set_ringparam ops. They make no sense
on EMAC which has a tx_ring_size=3D9 and the tiniest TX ring.

Thanks,

--=20
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
