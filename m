Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438653;
	b=LBuNWn4Tt7H8ALzKQmCjmiM2JAmfw39X39qBStxypWqd7EvA7oqv/NNMA7x/PTo3iHcx
	 HRKWG9vnpEJ10hh1bMkj1WGDZk04ze7qWhrl/Isr3dgLzhwf/O9aC8KWbVfr2vSnpDgEq
	 MJet6rK88mOqS2FRAd4P8BEB29y01Yydm3oRAY6txOuDU4hh0PyQ34f3XmtAWY7gyzSKZ
	 61cZEa+NdbX0TmCFHhllSMp1ZRWI2D+ez0U2GUYpOwksvogF7pJUT6ElCh5BxQjk0awoS
	 54/Ca9+S2dePHCs/bvk0OVeUYk/iseP0alpcwPKM4B1mpu8LlbM/emPpr0XA9d2h7ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438653;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lyiSYiBhg+IRGZO6G7RuJBb13gdg9Db9qJLDOkdCC9M=;
	b=X5Fws38H+F4rMIDCbhoDHcYOfU59AVCQ65qSOcbg7YfSjL1g6guPfgzThn+PqgmJbR+Z
	 spdnsE1XXDzi9mioEriub3vacP5wM+Ov2oT5q3QWb/XDVPCmsYpJlX4cdHuIXdwBJAJjE
	 yryou/KQILRJsx/o6z/G8pacq2Z2eXgtlsEiAFjiRQLhjiqwJcoRidV4eO8nDZatBCb5Y
	 ybIG5BeavKxL0D2cVXZZD0+PkNqhcP+UMJeGtM5EwXVESsTcggiwHUMv/F3eAjY6DtrKX
	 RRYFlvhqjiwr/Avzkoa/kKeIBxQxC01oYuUvMLPZHgbiN0PyZn8SX1fRwkpV7v7l+vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5ruulpd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C58606A899
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5ruulpd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8281F00A0F;
	Wed, 11 Nov 2026 23:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794438653;
	bh=lyiSYiBhg+IRGZO6G7RuJBb13gdg9Db9qJLDOkdCC9M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y5ruulpdFIDYgWZsNtM2zhXh6xwMj6D7lDH5HQs7FTDyI56vI0p6tReP5VXa1PDAY
	 ncidTL/HPiBmqSbBzRqhldPVim1HUVc7gF7zDX7e7EdeL0geSWSpuvG3/8EJ0Fkc59
	 QOE9K8PNdlTV2IRqvO7Th1eJWulUjTCDYDV/RGEj1dyd0kzEixFcihg7au3lEKSq2A
	 4q0YShrC6vb+wuDbd8Y8zk/a7nQq/gRPenBFNcBlumB1rAlEmGFSdvyu5HgfxQSB2J
	 aGCexOFr2Z/cv2WDoxCRDc7YDi+B3l4IS9G7DonoC45NFCmGlR9ZBvjLOyPlheule2
	 UIjST+AosyAQA==
Subject: Re: [PATCH net-next v7 16/18] net: ethernet: cortina: Drain RX
 coalescing timer on stop
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Wed, 11 Nov 2026 23:10:52 +0000
Message-ID: <179443865223.2199510.8707051713281280045@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-16-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-16-9c32a1a46aec@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message does not explain that moving hrtimer_setup()
  in gmac_open() (drivers/net/ethernet/cortina/gemini.c) fixes a…
- [Low] The commit message's reason for keeping the first
  hrtimer_cancel() in gmac_stop()…

--

net: ethernet: cortina: Drain RX coalescing timer on stop

This patch moves hrtimer_setup() for the RX coalescing timer in
gmac_open() so it runs before request_irq(). It also adds a second
hrtimer_cancel() in gmac_stop() after free_irq(). The aim is that no RX
interrupt can leave the timer queued after the port state has been freed.

> Initialize the timer before requesting the IRQ, and cancel it again
> after free_irq() has drained every handler that can rearm it. Keep the
> first cancellation to prevent the timer callback from scheduling NAPI
> while the poll instance is being disabled.

[Severity: Low]
Is this description of the first cancellation accurate? The paragraph
before it says an RX interrupt racing with that cancellation can rearm
the timer. That still seems possible while napi_disable() runs.

In gmac_stop(), the RX interrupt is only masked after napi_disable():

gmac_stop() {
	hrtimer_cancel(&port->rx_coalesce_timer);
	netif_tx_stop_all_queues(netdev);
	gmac_disable_tx_rx(netdev);
	gmac_stop_dma(port);
	napi_disable(&port->napi);
	...
	gmac_enable_irq(netdev, 0);
	...
}

A NAPI poll that finishes at the same time as the first cancel turns
the RX interrupt back on:

gmac_napi_poll() {
	...
	if (!reschedule && received < budget &&
	    napi_complete_done(napi, received))
		gmac_enable_rx_irq(napi->dev, 1);
	...
}

After that, gmac_irq() can call hrtimer_start() again. Then
gmac_coalesce_delay_expired()->napi_schedule() can run while
napi_disable() is still in progress. When rx_coalesce_nsecs is 0,
gmac_irq() calls napi_schedule() directly in the same window.

This does not cause a functional problem. A napi_schedule() on a NAPI
instance that is being disabled is either a no-op or gets waited out.
Still, the first cancel only handles a timer that is already pending. It
does not handle the rearm case.

Could the commit message say the early cancel is only best-effort?
Another option is to mask the RX interrupt before napi_disable().

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 59e6aeb07e0b4..58d6ed81a59c8 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -2201,6 +2201,10 @@ static int gmac_open(struct net_device *netdev)
>  	struct gemini_ethernet_port *port = netdev_priv(netdev);
>  	int err;
>  
> +	hrtimer_setup(&port->rx_coalesce_timer,
> +		      &gmac_coalesce_delay_expired,
> +		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +
>  	err = request_irq(netdev->irq, gmac_irq,
>  			  IRQF_SHARED, netdev->name, netdev);
>  	if (err) {
> @@ -2237,9 +2241,6 @@ static int gmac_open(struct net_device *netdev)
>  	gmac_enable_tx_rx(netdev);
>  	netif_tx_start_all_queues(netdev);
>  
> -	hrtimer_setup(&port->rx_coalesce_timer, &gmac_coalesce_delay_expired, CLOCK_MONOTONIC,
> -		      HRTIMER_MODE_REL);
> -
>  	netdev_dbg(netdev, "opened\n");
>  
>  	return 0;

[Severity: Low]
This move also seems to fix a separate race on the open side, and the
commit message does not describe it. Should the commit message mention
it, or should it go in its own patch?

Before this patch, gmac_open() called gmac_enable_irq(netdev, 1) before
hrtimer_setup(). gmac_irq() arms the timer once the RX interrupt is
unmasked, if rx_coalesce_nsecs is non-zero:

	if (!port->rx_coalesce_nsecs) {
		napi_schedule(&port->napi);
	} else {
		...
		hrtimer_start(&port->rx_coalesce_timer, ktime,
			      HRTIMER_MODE_REL);
	}

The default is 0, but gmac_set_coalesce() lets rx-usecs be set while
the interface is down. In that case, an RX interrupt can arrive between
gmac_enable_irq(netdev, 1) and the old hrtimer_setup() call:

- On the first open, it would start a zeroed hrtimer that was never
  initialized.

- On a reopen, it would start a timer that hrtimer_setup() then
  re-initializes while it is still queued.

The stop-side fix does not depend on this move, because ndo_stop only
runs after a successful open. If the commit message does not explain the
move, backporters might treat this hunk as cosmetic.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec%40kernel.org
