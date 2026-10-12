Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C7384CE5
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830752; cv=none; b=MZS5WSderugsFfUPhYuU9fFPI5LCJTnNNl4c+LVWI4LfAbptcq5BZHMSiuCwjWXVikkKEeLcKCd5wRr5H/w+zBGl9p4rFX7RtQLdAa/sJq/AOGxG+Au3UEwA1BcnhB6P5cNNX4KhJi1JND59ap758//7TaWokOeZACex7xmSqSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830752; c=relaxed/simple;
	bh=J6d+y//vMWwp8Nw2FBW3BzQJwhdqfPE+0G1WLofT+w0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nXEBEbOHyi65p4moRyc37Dkb07sbkzTj62h8Lhv+4orclbl2FUrdyq3Urx6O/O2EJDlhCMKuJsijqPWAL4BAC0XqfqOvV2Ol2qu1u2+J8cbjHIT3cMdbEimJ00E2C7Ey360SwqoPhesRmnAT/Uk2+UeKBBL1/PiWixwQBvrB4+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gr1fbk9u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gr1fbk9u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597501F008A2;
	Mon, 12 Oct 2026 18:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830739;
	bh=ikcYy6pzNtyCQEEtIkuJmYK4C59q2374+tU9M1BKrNU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Gr1fbk9u8F5I4FFlmXtxmkzRb/burRgmkslZOJ3zj8voxBedDdAGUgcvVi4EodeJN
	 ICh9IP9DoyKYv7BEt2GqLv6kpQpeJSDEFxjE6zkyudn/E/6iBMWQURqL1a/Ib/dJiK
	 0HNiqJJD6cyTzfqu15Sh2biZK3zZJTqqauHFwWzTIJexC0HKsifJHPArFBTQ1SQT6F
	 Rtsl5fUV+diEfA10yGYH3HukLb96RvhAlHQkdaD5jY0S0RnHXKQ4N2rj1h++aJc23w
	 k89qXaxKi0S7ny22kE2t6KOOmYkW3TNuUUPNRmDh2ZsN7UJ6qgOKdZ5Gs4982/g7Ca
	 iHF4phzNSMTzg==
Subject: Re: [PATCH net-next v4 13/15] net: ethernet: cortina: Release partial
 RX frames on stop
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 12 Oct 2026 18:45:38 +0000
Message-ID: <179183073891.434549.14362423377968840090@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-13-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-13-4b1631b08f5d@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit fixes a real leak in gmac_stop() but has no Fixes:
  trailer (and no Cc: stable).

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the
  rx_coalesce_timer lifecycle in gmac_open()/gmac_stop() is out of order…
- [Low] This problem wasn't introduced by this patch, but
  port->rx_stats_syncp (and tx_stats_syncp/ir_stats_syncp) is never…

--

net: ethernet: cortina: Release partial RX frames on stop

This patch frees any partially assembled RX frag skb in gmac_stop() after
napi_disable() and before the saved RX state is cleared. The discarded
frame is counted in rx_dropped, using the irqsave u64_stats helpers.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 43fd8fd773e3c..32291d4c33904 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -2209,12 +2209,19 @@ static int gmac_open(struct net_device *netdev)
>  static int gmac_stop(struct net_device *netdev)
>  {
>  	struct gemini_ethernet_port *port = netdev_priv(netdev);
> +	unsigned long flags;
>  
>  	hrtimer_cancel(&port->rx_coalesce_timer);

[Severity: High]
This isn't a bug introduced by this patch, but is rx_coalesce_timer
cancelled too early here?

hrtimer_cancel() runs before gmac_enable_irq(netdev, 0) masks the RX
interrupt, and before free_irq(). While NAPI is idle the RX queue interrupt
is enabled, because gmac_napi_poll() calls gmac_enable_rx_irq(napi->dev, 1)
when it completes. If rx_coalesce_nsecs is non-zero, an RX interrupt in
that window re-arms the timer from gmac_irq():

drivers/net/ethernet/cortina/gemini.c:gmac_irq() {
    ...
	if (val & (DEFAULT_Q0_INT_BIT << netdev->dev_id)) {
		gmac_enable_rx_irq(netdev, 0);

		if (!port->rx_coalesce_nsecs) {
			napi_schedule(&port->napi);
		} else {
			...
			hrtimer_start(&port->rx_coalesce_timer, ktime,
				      HRTIMER_MODE_REL);
		}
	}
    ...
}

Can the timer then still be pending after gmac_stop() returns? On device
removal, the netdev private area that embeds the hrtimer could be freed
while the timer is enqueued. gmac_coalesce_delay_expired() would then run
on freed memory.

On a quick reopen, gmac_open() calls hrtimer_setup(). Its
__hrtimer_setup() does a memset() on a timer that may still be linked into
the hrtimer base rbtree.

gmac_open() has a similar ordering problem, because interrupts are enabled
before the timer is set up:

drivers/net/ethernet/cortina/gemini.c:gmac_open() {
    ...
	gmac_start_dma(port);
	gmac_enable_irq(netdev, 1);
	gmac_enable_tx_rx(netdev);
	netif_tx_start_all_queues(netdev);

	hrtimer_setup(&port->rx_coalesce_timer, &gmac_coalesce_delay_expired, CLOCK_MONOTONIC,
		      HRTIMER_MODE_REL);
    ...
}

gmac_set_coalesce() accepts a non-zero rx-usecs while the interface is
down. On the first open after that, an RX interrupt in this window would
call hrtimer_start() on a zeroed hrtimer. lock_hrtimer_base() would then
dereference a NULL timer->base in hardirq context.

On later opens, an interrupt in the same window can arm the old timer just
before hrtimer_setup() clears it.

Would it make sense to set up the timer once at probe time, and to cancel
it in gmac_stop() only after the RX interrupt is masked?

>  	netif_tx_stop_all_queues(netdev);
>  	gmac_disable_tx_rx(netdev);
>  	gmac_stop_dma(port);
>  	napi_disable(&port->napi);
> +	if (port->rx_skb) {
> +		napi_free_frags(&port->napi);
> +		flags = u64_stats_update_begin_irqsave(&port->rx_stats_syncp);

[Severity: Low]
This is a pre-existing issue, but is rx_stats_syncp ever initialized with
u64_stats_init()?

The port is allocated with devm_alloc_etherdev_mqs() in
gemini_ethernet_port_probe(). The driver has no u64_stats_init() call for
rx_stats_syncp, tx_stats_syncp or ir_stats_syncp.

On 32-bit builds with CONFIG_DEBUG_LOCK_ALLOC, write_seqcount_begin()
calls lock_acquire() on a dep_map that has no key. Lockdep then prints
"trying to register non-static key" and turns itself off.

The existing writer in gmac_napi_poll() and the readers already run into
this. The new call in gmac_stop() is one more user.

> +		port->stats.rx_dropped++;
> +		u64_stats_update_end_irqrestore(&port->rx_stats_syncp, flags);
> +	}
>  	port->rx_skb = NULL;

[Severity: Low]
Should this patch have a Fixes: tag?

The leak seems to come from commit 06937db21ee3 ("net: ethernet: cortina:
Make RX SKB per-port"). That commit added the "port->rx_skb = NULL;" line
in gmac_stop() without freeing napi->skb.

Before 06937db21ee3, the static skb in gmac_rx() kept its value across
stop and open. The start-of-frame handling in gmac_rx() would then free the
stale partial frame:

	if (skb) {
		napi_free_frags(&port->napi);
		port->stats.rx_dropped++;
		...
	}

napi_disable() and napi_enable() do not release napi->skb, and
napi_get_frags() returns the existing napi->skb. After a reopen, the stale
skb and its old frags are reused, and the page references they hold are
leaked.

06937db21ee3 carries its own Fixes: tag and is headed for stable. Would it
help to add the following, so this fix reaches the same trees?

Fixes: 06937db21ee3 ("net: ethernet: cortina: Make RX SKB per-port")

>  	port->rx_frag_nr = 0;
>  	port->rx_dropping = false;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d%40kernel.org
