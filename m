Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566933876B8;
	Fri, 31 Jul 2026 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514245; cv=none; b=jqkR5pyOQmRVc5vmQOPQrxVLw0UgXUTnkxl5QyNEP4y1pcRvzkvAdGBMlGHNr1UXiJfuUOArYpM4iZaen1VntxdJj7CWy8jvJhPG57MyW/ob1ihgL7hw5S4Kb+qQG2NEBAiN9xjU2F3f78D+/vj1/mTnAKAOIj0L1pf1WRog9uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514245; c=relaxed/simple;
	bh=ZxEP6TgNv88WrJYxtaAQ3YoF12sS69sflBFNb/8mCWA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=IlzgO5ymLpt03KlpHUhA/+BVTgV67zGdIK67djQ/HG6Y3iwqGZrZgltKObRayPR0zpC93Ejx8cy5ClDpxzrASlc20yBrfz3kT4M//YyyP3vsfh/jc3PytNya/U8tvtkH3MoOWQTzy82CBeYGDY4uVw9h10yam8Bu+oHy2itnVCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Dyh/4mJ7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Dyh/4mJ7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 844981A1364;
	Fri, 31 Jul 2026 16:10:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4F8946039A;
	Fri, 31 Jul 2026 16:10:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C6F111C16A6A;
	Fri, 31 Jul 2026 18:10:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785514238; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0Dk4kbWvOzGTPH7S8Q20Ht91668Q07e4E6M0K+X69HM=;
	b=Dyh/4mJ7FDTBoJWEj8AtPIsqha4gFPhCpb4x6ZHppg0m834bTFw0KdfaAUdgeIXett7uOY
	LV9EJTHDBgbRNTdtJIJgoJnHteOKyf5dva9xqf0IzWGM5siY2EyIanbv4TBmSVFnmPLrue
	Qv2BR0YyM/544ztI7ByXtWkYaXZdarh7U1BUJocXeUt3URS6G7y4AfskL0RGpk3o0cN9fQ
	3tbWv52kk9iS0tTe2FvmnWaMe+UxBonoRs6zC1S4yA4LuwhYCEeR2cuGdQb2ZS+CfHp42z
	Bu/0GOUtBbGQ3XwgBCBibkn3jTxJd6J+ZWAMke7QZa2L/pPWXvbuU5jGZZzuUA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 18:10:33 +0200
Message-Id: <DKCVYZ69KGSM.2R1ELFSWRG5HM@bootlin.com>
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
Subject: Re: [PATCH net-next v5 14/15] net: macb: use context swapping in
 .set_ringparam()
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
 <20260724-macb-context-v5-14-569b1852bc7f@bootlin.com>
In-Reply-To: <20260724-macb-context-v5-14-569b1852bc7f@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

Sashiko replies.

Both sashiko.dev and sashiko-netdev has comments on this patch.
https://sashiko.dev/#/patchset/20260724-macb-context-v5-0-569b1852bc7f%40bo=
otlin.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260724-macb-context-v=
5-0-569b1852bc7f%40bootlin.com?patch=3D8011

---

sashiko.dev:

> > +static void macb_context_swap_end(struct macb *bp,
> > +              struct macb_context *new_ctx)
> > +{
> [ ... ]
> > +   ctrl =3D macb_readl(bp, NCR);
> > +   macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
> > +
> > +   spin_unlock_irqrestore(&bp->lock, flags);
> > +
> > +   mutex_unlock(&bp->mac_cfg_lock);
> > +
> > +   netif_tx_start_all_queues(bp->netdev);
>
> [Severity: High]
> Does unconditionally enabling the MAC receiver, transmitter, and TX queue=
s
> here risk overriding phylink's link-down state?
>
> If a user changes ring parameters via ethtool on an administratively up
> interface that currently has no physical carrier, could this forcefully
> enable the hardware and violate the phylink state machine contract?

Yes. We need to check for that using netif_carrier_ok(). We already have
our bp->mac_cfg_lock mutex delaying the conflicting phylink ops.

Note: we'll add the mutex lock in macb_hresp_error_task() which toggles
the carrier state.

>
> > +
> > +   /* Free old context. */
> > +
> > +   macb_free(old_ctx);
> > +   kfree(old_ctx);
> > +}

---

sashiko-netdev:

> > +static void macb_context_swap_end(struct macb *bp,
> > +              struct macb_context *new_ctx)
> > +{
> > +   struct macb_context *old_ctx;
> > +   struct macb_queue *queue;
> > +   unsigned long flags;
> > +   unsigned int q;
> > +   u32 ctrl;
> > +
> > +   lockdep_assert_held(&bp->mac_cfg_lock);
> > +
> > +   /* Swap contexts & give buffer pointers to HW. */
> > +
> > +   old_ctx =3D bp->ctx;
> > +   bp->ctx =3D new_ctx;
> > +   macb_init_buffers(bp);
> > +
> > +   /* Start NAPI, HW Tx/Rx and software Tx. */
> > +
> > +   for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queu=
e) {
> > +      napi_enable(&queue->napi_rx);
> > +      napi_enable(&queue->napi_tx);
> > +   }
> > +
> > +   spin_lock_irqsave(&bp->lock, flags);
> > +
> > +   /* Re-arm normal interrupt processing before enabling IRQs. */
> > +   bp->ctx_swap =3D false;
> > +
> > +   macb_configure_dma(bp);
> > +
> > +   for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queu=
e) {
> > +      queue_writel(queue, IER,
> > +              bp->rx_intr_mask |
> > +              MACB_TX_INT_FLAGS |
> > +              MACB_BIT(HRESP));
> > +   }
> > +
> > +   ctrl =3D macb_readl(bp, NCR);
> > +   macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
> > +
> > +   spin_unlock_irqrestore(&bp->lock, flags);
> > +
> > +   mutex_unlock(&bp->mac_cfg_lock);
> > +
> > +   netif_tx_start_all_queues(bp->netdev);
>
> [Medium]
> Can there be a window between mutex_unlock(&bp->mac_cfg_lock) and
> netif_tx_start_all_queues(bp->netdev) where phylink_resolve runs
> macb_mac_link_down(), which now also takes mac_cfg_lock and calls
> netif_tx_stop_all_queues()?
>
> If mac_link_down runs in that window:
>
>     static void macb_mac_link_down(...)
>     {
>         mutex_lock(&bp->mac_cfg_lock);
>         ...
>         netif_tx_stop_all_queues(netdev);
>         mutex_unlock(&bp->mac_cfg_lock);
>     }
>
> then the subsequent netif_tx_start_all_queues() in macb_context_swap_end(=
)
> would clear __QUEUE_STATE_DRV_XOFF and undo the stop that mac_link_down
> just performed.
>
> For comparison, macb_mac_link_up() calls netif_tx_wake_all_queues() while
> still holding mac_cfg_lock, and macb_mac_link_down() calls
> netif_tx_stop_all_queues() while still holding it. Would moving the
> netif_tx_start_all_queues() call above mutex_unlock() here match that
> pattern and close the window?

Agreed. netif_tx_start_all_queues() will move one line up.

>
> > +
> > +   /* Free old context. */
> > +
> > +   macb_free(old_ctx);
> > +   kfree(old_ctx);
> > +}
>
> > @@ -3816,9 +3953,10 @@ static int macb_set_ringparam(struct net_device =
*netdev,
> >                 struct kernel_ethtool_ringparam *kernel_ring,
> >                 struct netlink_ext_ack *extack)
> >  {
> > +   unsigned int new_rx_size, new_tx_size;
> >     struct macb *bp =3D netdev_priv(netdev);
> > -   u32 new_rx_size, new_tx_size;
> > -   unsigned int reset =3D 0;
> > +   bool running =3D netif_running(netdev);
> > +   struct macb_context *new_ctx;
> >
> >     if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
> >        return -EINVAL;
> > @@ -3837,16 +3975,24 @@ static int macb_set_ringparam(struct net_device=
 *netdev,
> >        return 0;
> >     }
> >
> > -   if (netif_running(bp->netdev)) {
> > -      reset =3D 1;
> > -      macb_close(bp->netdev);
> > +   if (running) {
> > +      /* Context swapping is not supported for AT91. */
> > +      if (bp->caps & MACB_CAPS_MACB_IS_EMAC)
> > +         return -EBUSY;
>
> [Medium]
> Before this change, ethtool --set-ring on an administratively up AT91
> EMAC interface went through the macb_close()/macb_open() path and
> succeeded. After this change AT91 EMAC returns -EBUSY when the interface
> is up, so users must now bring the link down, adjust ring sizes, and
> bring it back up.
>
> Should this user-visible behavior change be called out in the commit
> message, or would it be preferable to keep the previous close/reopen
> sequence as an AT91-only fallback so existing management scripts continue
> to work?

No we don't want the fallback.
Yes I'll mention this in the commit message.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



