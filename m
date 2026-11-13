Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794557256;
	b=2dOsrqbKyISabqz1GuDrKqczob0RugB2FV0nI+FSlUxqynV5M6bahpCkVPC9AtK6ei1H
	 HbsrnXf8V4NBVnv/eGNKTRFICqgR1PISHHSXzHC9zoa7Y7bwUzgoy9Ea5B0Fm8gAxskIF
	 obJcrOD7FcgVsOBHqTZz+9VnLvyV5/Hi33NT9GW2Y376C6Fu8Yu0X+K3pwDgyRQBSBSbt
	 Slzmyxi2TXOK4nNDPIdSTgjns9gVI3F6c/emfL4718evgpUigkg1SWa1YO4i1KL+rWI9P
	 Rdh1ZmWrojr8kiaYhcV7MmKErsBAjYqPH0T/VjqJ4wsRE7jZ60CzoyfzBWuSG6s1MYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557256;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=GnfksSGm5MGQ/GKGPFEcSdt0KimGGIj1QAHWWPmPhNg=;
	b=UQZ2L5ZkaEIP4jCne87gToqgwHRIFPPRdJ5pkGjjJidP9m2P/8bUtlRZZhVyN1jzm2ZH
	 OmZ2d95Q9GZFVNX5VwIp0fGpm7V0jOrRTzPUogDeBgMrZ19IRa8In8RzLWg9k1ISJOs28
	 Pwol8uTqTwmuSdXQDUzYSDzZ7bvJdCHUlBtqPtTcfhnVGLAsZDX6jcRYbCb6uZ0lTQQ4K
	 PqTmnUh0oKf0+L68ZvfSsuCT7DlA36JgU0JaagbZyvFHfBpXu+/vs5xXEGuCyD9VPgLtu
	 Gr8mjd8li1o/kiEIKpoGA2/zS7OSWRO4L4RHRbc2rlCmoyxp65QGGnkabc7sR0TpH/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=rDwOmZCG;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13622606A89D;
	Fri, 13 Nov 2026 08:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13622606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=rDwOmZCG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794557264; x=1826093264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2fiZem93bWO8BjtYqrl7RyFMjybvyYFhKTSxcPJ5Z0U=;
  b=rDwOmZCGx2baPg6UYhWHrlLvn6G+e1MQkaLQWNZUDyP1JX7djUa9ch/p
   eojUklc13aTaK6Xtjty3lX/Lxpfe+J2y6SSbidBSOkouSDE3ZMCv1cSEk
   iy7mSbJM1qEYzEdDaaoudZICWtPjR2ogknraI7yAQp8qoBetAXLCUIXn2
   I1f4/ldFn6Ec36OAZDkTXJ4WbKVwvCOb6JAtn51K4N0P3WCYyS/HWDm1X
   QtsVURjU5VC9b6XwpIbgabAPtfIN3UZbT88uR75HvXrg3ELd/KSwgYnTI
   zhXBmJVYs0S6eGOyMNAx8k4Pt2MS/o+b9AKRXLDCa7ue9MPhfDa4aqLQB
   A==;
X-CSE-ConnectionGUID: hsOIJvLwS1aCWPKyNS5A6g==
X-CSE-MsgGUID: BNFG7T2kTVaOdgejz7N48Q==
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="66696610"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2026 01:07:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 13 Nov 2026 01:07:34 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 13 Nov 2026 01:07:31 -0700
Date: Fri, 13 Nov 2026 09:07:31 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <richardcochran@gmail.com>,
	<linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robert.marko@sartura.hr>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>
Subject: Re: [PATCH net-next v2 6/9] net: sparx5/lan969x: add support for
 resizing the FDMA buffers
Message-ID: <20261113080731.a6xdk63hnkjyk5w3@DEN-DL-M70577.microsemi.net>
References: <20261111-sparx5-mtu-change-v2-6-59c91357e8f6@microchip.com>
 <179450479769.2199510.7340350354512665906@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179450479769.2199510.7340350354512665906@kernel.org>

> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (1) · Medium: 2 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] On lan969x, the RX error path keeps a pointer to a page it has
>   already given back to the page_pool, so lan969x_fdma_resize() can…
> - [Medium] This patch adds a one-line lan969x RX slot clear in
>   lan969x_fdma_rx_get_frame():…
> - [Medium] net: sparx5: GFP_ATOMIC RX skb allocation in
>   sparx5_fdma_resize()
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but it is severe:
>   both RX NAPI paths ignore fdma_dcb_add()'s return value when re-arming…
> 
> --
> 
> net: sparx5/lan969x: add support for resizing the FDMA buffers
> 
> This adds an fdma_resize operation for Sparx5 and lan969x. It allocates
> new FDMA buffers sized for a new MTU, pauses the TX queues and the FDMA,
> swaps in the new buffers and then resumes. On lan969x it also clears the
> RX page slot once the page has been passed to the stack.
> 
> > diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> > index 40cdb0323eb49..6f827cad49229 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> > @@ -153,6 +153,12 @@ static struct sk_buff *lan969x_fdma_rx_get_frame(struct sparx5 *sparx5,
> >  	skb->dev->stats.rx_bytes += skb->len;
> >  	skb->dev->stats.rx_packets++;
> >  
> > +	/* The page is passed to the stack in the skb, so clear its slot in the
> > +	 * ring, so that lan969x_fdma_rx_free() does not return it to the
> > +	 * page_pool.
> > +	 */
> > +	rx->page[fdma->dcb_index][fdma->db_index] = NULL;
> 
> [Severity: Medium]
> This line also seems to fix an existing double put at deinit, separate
> from resizing.
> 
> When the NAPI reload loop fails to refill a slot,
> lan969x_fdma_rx_dataptr_cb() returns before it overwrites the slot:
> 
> 	page = page_pool_dev_alloc_pages(rx->page_pool);
> 	if (unlikely(!page))
> 		return -ENOMEM;
> 
> 	rx->page[dcb][db] = page;
> 
> The slot then still holds the page that build_skb() already gave to the
> stack. Later, lan969x_fdma_deinit()->lan969x_fdma_rx_free()->
> lan969x_fdma_free_pages() calls page_pool_put_full_page() on that page.
> 
> The earlier fix in this series, "net: sparx5/lan969x: free the FDMA
> buffers on init errors and deinit" (Fixes: d84ad2c0d80c), limits the slot
> clearing to Sparx5:
> 
>   "clear the RX buffer slot once the buffer has been passed to the stack
>   on Sparx5"
> 
> Could this lan969x line go into that fix, or into its own patch with
> Fixes: d84ad2c0d80c? Otherwise stable trees that take the fix would still
> have the lan969x double put.
> 
> > +
> >  	return skb;
> >  
> >  free_page:
> 
> [Severity: High]
> The success path now clears the slot. What about the free_page path just
> below it?
> 
> lan969x_fdma_rx_get_frame() {
>     ...
> free_page:
> 	page_pool_recycle_direct(rx->page_pool, page);
> 
> 	return NULL;
> }
> 
> This path runs on WARN_ON(!port) or when build_skb() fails. It gives the
> page back to the page_pool, but rx->page[fdma->dcb_index][fdma->db_index]
> still points at it.
> 
> lan969x_fdma_napi_poll() then breaks out before fdma_db_advance():
> 
> 		skb = lan969x_fdma_rx_get_frame(sparx5, rx);
> 		if (!skb)
> 			break;
> 
> So the slot is not reloaded. In the same poll, the reload loop can also
> hand the just-recycled page from the direct cache to an earlier slot.
> 
> After that, an MTU change that changes the page order goes through:
> 
> lan969x_fdma_resize()
>   lan969x_fdma_rx_free()
>     lan969x_fdma_free_pages()
>       page_pool_put_full_page(rx->page_pool, rx->page[i][j], false)
> 
> Can this put the same page into the page_pool a second time? If so,
> page_pool_destroy() would release it twice, with a double put_page() and
> a double DMA unmap.
> 
> The commit message says the slot is cleared "to know which RX pages are
> still owned by the driver when freeing them". The free_page path also
> gives up ownership. Should it clear the slot as well?
> 
> Before this patch the free only happened at deinit. Now
> lan969x_fdma_resize() runs it during normal operation.

Already pending on net (see answer on patch #2).

> 
> [ ... ]
> 
> > @@ -468,3 +476,67 @@ int lan969x_fdma_deinit(struct sparx5 *sparx5)
> 
> [ ... ]
> 
> > +int lan969x_fdma_resize(struct sparx5 *sparx5, struct sparx5_port *port,
> > +			int new_mtu)
> > +{
> 
> [ ... ]
> 
> > +	sparx5_fdma_pause(sparx5);
> > +
> > +	/* The FDMA is stopped and reset, and NAPI and the TX queues are
> > +	 * disabled, so nothing uses the buffers until sparx5_fdma_resume().
> > +	 */
> > +	lan969x_fdma_tx_reset(sparx5);
> > +	lan969x_fdma_rx_free(sparx5, rx);
> > +
> > +	rx->fdma = rx_new->fdma;
> > +	rx->page_pool = rx_new->page_pool;
> > +	rx->page_order = rx_new->page_order;
> > +	memcpy(rx->page, rx_new->page, sizeof(rx->page));
> > +
> > +	sparx5_fdma_resume(sparx5);
> 
> [Severity: High]
> This is a pre-existing issue, not one introduced by this patch. It
> affects the RX refill path that this series makes larger.
> 
> Both RX NAPI paths ignore the return value of fdma_dcb_add() when they
> re-arm a consumed DCB. In lan969x_fdma_napi_poll():
> 
> 		fdma_dcb_add(fdma,
> 			     old_dcb,
> 			     FDMA_DCB_INFO_DATAL(fdma->db_size),
> 			     FDMA_DCB_STATUS_INTR);
> 
> 		sparx5_fdma_reload(sparx5, fdma);
> 
> sparx5_fdma_napi_callback() does the same.
> 
> In fdma_api.c, __fdma_db_add() writes the status before the callback
> gets a chance to fail:
> 
> 	db->status = cpu_to_le64(status);
> 
> 	err = cb(fdma, dcb_idx, db_idx, &dataptr);
> 	if (unlikely(err))
> 		return err;
> 
> __fdma_dcb_add() then returns before it links prev->nextptr and updates
> fdma->last_dcb.
> 
> Suppose page_pool_dev_alloc_pages() in lan969x_fdma_rx_dataptr_cb() fails,
> or the GFP_ATOMIC __netdev_alloc_skb() in sparx5_fdma_rx_dataptr_cb()
> fails. The DCB then has DONE cleared, but it is not in the hardware chain,
> and the next successful add links around it.
> 
> The software dcb_index still walks the ring in order. When it reaches
> this DCB, fdma_has_frames() on lan969x, or fdma_db_is_done() in
> sparx5_fdma_rx_get_frame(), sees a DCB that is not done and stops. No
> further DCBs are re-armed, and the hardware stops at the last linked DCB.
> 
> Can one failed atomic refill stop CPU extraction for every port until
> the FDMA is re-initialized?
> 
> The later commit "net: sparx5/lan969x: add support for changing the MTU"
> enables jumbo MTUs, which turns these refills into higher-order
> allocations. The fix commit "net: sparx5/lan969x: free the FDMA buffers
> on init errors and deinit" checks errors for the initial fdma_dcbs_init()
> fill, but not for this refill at runtime.
> 
> [ ... ]
> 
> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> > @@ -558,3 +570,173 @@ int sparx5_fdma_stop(struct sparx5 *sparx5)
> >  
> >  	return 0;
> >  }
> > +
> > +/* Check if any TX DB is still waiting to be transmitted */
> > +static bool sparx5_fdma_tx_busy(struct fdma *fdma)
> > +{
> > +	for (int i = 0; i < fdma->n_dcbs; i++)
> > +		if (!fdma_db_is_done(fdma_db_get(fdma, i, 0)))
> > +			return true;
> > +
> > +	return false;
> > +}
> > +
> > +/* Enable or disable the forwarding of frames to the CPU ports */
> > +static void sparx5_fdma_cpu_fwd_set(struct sparx5 *sparx5, bool ena)
> > +{
> > +	for (int cpu = SPX5_PORT_CPU_0; cpu <= SPX5_PORT_CPU_1; cpu++) {
> > +		int portno = sparx5_get_internal_port(sparx5, cpu);
> > +
> > +		spx5_rmw(QFWD_SWITCH_PORT_MODE_PORT_ENA_SET(ena),
> > +			 QFWD_SWITCH_PORT_MODE_PORT_ENA,
> > +			 sparx5,
> > +			 QFWD_SWITCH_PORT_MODE(portno));
> > +	}
> > +}
> > +
> > +/* Get the memory used by the frames queued to the CPU ports */
> > +static u32 sparx5_fdma_cpu_queue_use(struct sparx5 *sparx5)
> > +{
> > +	u32 use = 0;
> > +
> > +	for (int cpu = SPX5_PORT_CPU_0; cpu <= SPX5_PORT_CPU_1; cpu++) {
> > +		int portno = sparx5_get_internal_port(sparx5, cpu);
> > +		u32 base;
> > +
> > +		base = SPX5_QRES_DST_MEM + SPX5_PRIOS * portno;
> > +		for (int prio = 0; prio < SPX5_PRIOS; prio++)
> > +			use += QRES_RES_STAT_CUR_INUSE_GET(spx5_rd(sparx5,
> > +					QRES_RES_STAT_CUR(base + prio)));
> > +	}
> > +
> > +	return use;
> > +}
> > +
> > +/* Stop the port TX queues and the FDMA, and reset the FDMA, so that the FDMA
> > + * buffers can be replaced.
> > + */
> > +void sparx5_fdma_pause(struct sparx5 *sparx5)
> > +{
> > +	bool busy;
> > +	u32 use;
> > +
> > +	/* Only ports that are up have TX queues to stop */
> > +	for (int i = 0; i < sparx5->data->consts->n_ports; i++) {
> > +		struct sparx5_port *port = sparx5->ports[i];
> > +
> > +		if (port && netif_running(port->ndev))
> > +			netif_tx_disable(port->ndev);
> > +	}
> > +
> > +	/* Give the frames already handed to the FDMA a chance to be sent, as
> > +	 * they are lost when the FDMA is reset.
> > +	 */
> > +	if (read_poll_timeout(sparx5_fdma_tx_busy,
> > +			      busy,
> > +			      !busy,
> > +			      SPX5_FDMA_TX_DRAIN_SLEEP_US,
> > +			      SPX5_FDMA_TX_DRAIN_TIMEOUT_US,
> > +			      false,
> > +			      &sparx5->tx.fdma))
> > +		dev_warn(sparx5->dev, "FDMA TX not drained, frames dropped\n");
> > +
> > +	/* Stop the switch core from forwarding frames to the CPU, and let the
> > +	 * FDMA extract the frames already queued, so that the FDMA is not
> > +	 * stopped and reset while the switch core is still sending it frames.
> > +	 */
> > +	sparx5_fdma_cpu_fwd_set(sparx5, false);
> > +	if (read_poll_timeout(sparx5_fdma_cpu_queue_use,
> > +			      use,
> > +			      !use,
> > +			      SPX5_FDMA_XTR_DRAIN_SLEEP_US,
> > +			      SPX5_FDMA_XTR_DRAIN_TIMEOUT_US,
> > +			      false,
> > +			      sparx5))
> > +		dev_warn(sparx5->dev, "CPU queue not drained, frames dropped\n");
> > +
> > +	sparx5_fdma_stop(sparx5);
> > +
> > +	/* Reset FDMA state */
> > +	spx5_wr(FDMA_CTRL_NRESET_SET(0), sparx5, FDMA_CTRL);
> > +	spx5_wr(FDMA_CTRL_NRESET_SET(1), sparx5, FDMA_CTRL);
> > +
> > +	/* Discard frames queued for the CPU, as they may not fit the new
> > +	 * buffers.
> > +	 */
> > +	sparx5_xtr_flush(sparx5, XTR_QUEUE);
> > +}
> > +
> > +/* Restart the FDMA and the port TX queues after sparx5_fdma_pause() */
> > +void sparx5_fdma_resume(struct sparx5 *sparx5)
> > +{
> > +	struct sparx5_rx *rx = &sparx5->rx;
> > +	struct sparx5_tx *tx = &sparx5->tx;
> > +
> > +	/* Enable NAPI before the RX interrupt is enabled, as the interrupt
> > +	 * handler schedules NAPI, as in sparx5_fdma_start().
> > +	 */
> > +	napi_enable(&rx->napi);
> > +
> > +	sparx5_fdma_rx_activate(sparx5, rx);
> > +	sparx5_fdma_tx_activate(sparx5, tx);
> > +
> > +	/* Forward frames to the CPU again, now that the FDMA can extract them */
> > +	sparx5_fdma_cpu_fwd_set(sparx5, true);
> > +
> > +	for (int i = 0; i < sparx5->data->consts->n_ports; i++) {
> > +		struct sparx5_port *port = sparx5->ports[i];
> > +
> > +		if (port && netif_running(port->ndev))
> > +			netif_tx_wake_all_queues(port->ndev);
> > +	}
> > +}
> > +
> > +int sparx5_fdma_resize(struct sparx5 *sparx5, struct sparx5_port *port,
> > +		       int new_mtu)
> > +{
> > +	struct sparx5_rx *rx = &sparx5->rx;
> > +	struct sparx5_tx *tx = &sparx5->tx;
> > +	struct sparx5_tx tx_new = {};
> > +	struct sparx5_rx *rx_new;
> > +	u32 db_size;
> > +	int err;
> > +
> > +	db_size = sparx5_fdma_get_db_size(sparx5, port, new_mtu);
> > +	if (db_size == rx->fdma.db_size)
> > +		return 0;
> > +
> > +	rx_new = kzalloc_obj(*rx_new);
> > +	if (!rx_new)
> > +		return -ENOMEM;
> > +
> > +	sparx5_fdma_rx_init(sparx5, rx_new, FDMA_XTR_CHANNEL, db_size);
> > +	sparx5_fdma_tx_init(sparx5, &tx_new, FDMA_INJ_CHANNEL, db_size);
> > +
> > +	err = sparx5_fdma_rx_alloc(rx_new);
> > +	if (err)
> > +		goto out;
> > +
> > +	err = sparx5_fdma_tx_alloc(&tx_new);
> > +	if (err) {
> > +		sparx5_fdma_rx_free(rx_new);
> > +		goto out;
> > +	}
> > +
> > +	sparx5_fdma_pause(sparx5);
> > +
> > +	/* The FDMA is stopped and reset, and NAPI and the TX queues are
> > +	 * disabled, so nothing uses the buffers until sparx5_fdma_resume().
> > +	 */
> > +	sparx5_fdma_rx_free(rx);
> > +	fdma_free_phys(&tx->fdma);
> > +
> > +	rx->fdma = rx_new->fdma;
> > +	memcpy(rx->skb, rx_new->skb, sizeof(rx->skb));
> > +	tx->fdma = tx_new.fdma;
> > +
> > +	sparx5_fdma_resume(sparx5);
> > +out:
> > +	kfree(rx_new);
> > +
> > +	return err;
> > +}
> 
> [Severity: Medium]
> sparx5_fdma_rx_alloc() fills the new ring through fdma_dcbs_init(),
> which calls sparx5_fdma_rx_dataptr_cb() for every DB. That callback
> always allocates the skb with GFP_ATOMIC:
> 
> 	skb = __netdev_alloc_skb(rx->ndev, fdma->db_size, GFP_ATOMIC);
> 	if (unlikely(!skb))
> 		return -ENOMEM;
> 
> That fits the NAPI refill path. Here, though, it runs in process
> context under RTNL. It allocates the whole ring of FDMA_DCB_MAX *
> FDMA_RX_DCB_MAX_DBS (960) skbs while the old ring is still allocated
> and the FDMA is still running on it.
> 
> With the jumbo MTUs enabled later in the series, db_size gets close
> to 14 KB. Each skb head is then an order-2 allocation, roughly 15 MB
> in total. GFP_ATOMIC cannot do direct reclaim or compaction. On a
> system with fragmented memory the MTU change can fail with -ENOMEM
> where a sleeping allocation would have succeeded.
> 
> It also draws on the __GFP_HIGH reserves that the NAPI refill of the
> live ring needs at the same time. A failed refill there leads to the
> stall raised above for fdma_dcb_add().
> 
> Could sparx5_fdma_rx_dataptr_cb() take the gfp mask from its caller?
> For example, a field in struct sparx5_rx could let
> sparx5_fdma_rx_alloc() use GFP_KERNEL while the NAPI refill keeps
> GFP_ATOMIC.
> 
> lan969x_fdma_rx_dataptr_cb() looks the same, since
> page_pool_dev_alloc_pages() is GFP_ATOMIC too. There the page order
> also grows with the MTU.

While this is true, I dont believe this is in-scope for this series. This
implementation is well tested and the refill is the same between lan966x and
lan969x with no issues about this reported.

> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-sparx5-mtu-change-v2-0-59c91357e8f6%40microchip.com
