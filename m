Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504799;
	b=VxfeNGeEAvr/CwrbvMQXAbCdDDRuDuLU+0jB/xyjY/Y2YJRIvSXiFKp1LaDu/zdnYu4R
	 tA/wo+XJh5XMRDGqCfbfjhrcUrbpokHKw6I9KkPvBae3YrFD2wSdjcqIwgqtzfvENqpMe
	 +TiMNMj+xPBGa17y8Zmq2oZes9XTUCBSCLmrrmskoKlsG4e0tFvMHGVQW7OBFZibgbkTa
	 MOleklwuuvtE00Su7n79wV+EwT0JIlJuD/d8K1xc4qN9jf4q7I1uZKHzBU9QX8kf2gS25
	 RomMCMR6SuOaH4vvwnp3L1cUmIEfdS6QtYurWU2/PmhtDzVwBURLN2uFx3Ud5rQjwlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504799;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TWU28xxWKolcs593mhA8pg+/WchtWSWI2RoWiYJxdrk=;
	b=2AlNeW8KkCUHy92isOhK33cUDmAK0gxoN9R0YyjlUTO0+vG3kzDupCgUKcY7jlf3iMj4
	 C1G+xWrOwtrgzEsr2RR4KQY4HTnzrmZidTtbPxF5AeTIJHK8vMrtnQEFVUOncvKRFKECN
	 hNC6qdB5kA8ozQCRGAyPZzK8VAMRFLc02I6bYXrOfi3X5UUVStCJ3lYhklbHtvmh7n/FZ
	 CJMpEMLkz+M7OidD9a3YgNYbd09Rc3yLCYbAK8Q4WHqkoX22+2VyzjeGnXwfpF/dewyKU
	 16PAVvSCt/lCtQ81DcimF3KklEh1koJepYpD5Zq9vbXHktA/N2UIxU4Eo9pDPsMFcmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYsK+QQU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFBF60A383F;
	Thu, 12 Nov 2026 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYsK+QQU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAF41F000CA;
	Thu, 12 Nov 2026 17:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504798;
	bh=TWU28xxWKolcs593mhA8pg+/WchtWSWI2RoWiYJxdrk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bYsK+QQUASJniilrXvr2xzBD41YmM1FjqEReh91s+dkUOcoumiG9TMJ91x0HxpmQp
	 tt83f3uDFwMZTQHIBMFMmY5ejZVrw2GkHCYGZ9QIqIcZJgczLwe63WBCPM2UsRoosh
	 BOCS3YIaAKS7exvgGT1lhVyUuncxB+3JGVv+0L4WeBQf46c7RpYsMS7B8MI99xXuWp
	 XX6X12JDqUDZr3Mge14bNai7SgoaSAkw6HcsUYv7Si1C/hZSnFtrR6hSGKYma7QksL
	 1vbM3GOmM51BPJd5w62ueEdPzMYFGPZT/2DspnExIDG0SGRYDOmFf70+GVkhhJbFI7
	 XHvT41IvQZBXw==
Subject: Re: [PATCH net-next v2 6/9] net: sparx5/lan969x: add support for
 resizing the FDMA buffers
From: netdev-bot+sashiko@kernel.org
To: daniel.machon@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robert.marko@sartura.hr,
 horatiu.vultur@microchip.com, jensemil.schulzostergaard@microchip.com
Date: Thu, 12 Nov 2026 17:33:17 +0000
Message-ID: <179450479769.2199510.7340350354512665906@kernel.org>
In-Reply-To: <20261111-sparx5-mtu-change-v2-6-59c91357e8f6@microchip.com>
References: <20261111-sparx5-mtu-change-v2-6-59c91357e8f6@microchip.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On lan969x, the RX error path keeps a pointer to a page it has
  already given back to the page_pool, so lan969x_fdma_resize() can…
- [Medium] This patch adds a one-line lan969x RX slot clear in
  lan969x_fdma_rx_get_frame():…
- [Medium] net: sparx5: GFP_ATOMIC RX skb allocation in
  sparx5_fdma_resize()

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is severe:
  both RX NAPI paths ignore fdma_dcb_add()'s return value when re-arming…

--

net: sparx5/lan969x: add support for resizing the FDMA buffers

This adds an fdma_resize operation for Sparx5 and lan969x. It allocates
new FDMA buffers sized for a new MTU, pauses the TX queues and the FDMA,
swaps in the new buffers and then resumes. On lan969x it also clears the
RX page slot once the page has been passed to the stack.

> diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> index 40cdb0323eb49..6f827cad49229 100644
> --- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> +++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> @@ -153,6 +153,12 @@ static struct sk_buff *lan969x_fdma_rx_get_frame(struct sparx5 *sparx5,
>  	skb->dev->stats.rx_bytes += skb->len;
>  	skb->dev->stats.rx_packets++;
>  
> +	/* The page is passed to the stack in the skb, so clear its slot in the
> +	 * ring, so that lan969x_fdma_rx_free() does not return it to the
> +	 * page_pool.
> +	 */
> +	rx->page[fdma->dcb_index][fdma->db_index] = NULL;

[Severity: Medium]
This line also seems to fix an existing double put at deinit, separate
from resizing.

When the NAPI reload loop fails to refill a slot,
lan969x_fdma_rx_dataptr_cb() returns before it overwrites the slot:

	page = page_pool_dev_alloc_pages(rx->page_pool);
	if (unlikely(!page))
		return -ENOMEM;

	rx->page[dcb][db] = page;

The slot then still holds the page that build_skb() already gave to the
stack. Later, lan969x_fdma_deinit()->lan969x_fdma_rx_free()->
lan969x_fdma_free_pages() calls page_pool_put_full_page() on that page.

The earlier fix in this series, "net: sparx5/lan969x: free the FDMA
buffers on init errors and deinit" (Fixes: d84ad2c0d80c), limits the slot
clearing to Sparx5:

  "clear the RX buffer slot once the buffer has been passed to the stack
  on Sparx5"

Could this lan969x line go into that fix, or into its own patch with
Fixes: d84ad2c0d80c? Otherwise stable trees that take the fix would still
have the lan969x double put.

> +
>  	return skb;
>  
>  free_page:

[Severity: High]
The success path now clears the slot. What about the free_page path just
below it?

lan969x_fdma_rx_get_frame() {
    ...
free_page:
	page_pool_recycle_direct(rx->page_pool, page);

	return NULL;
}

This path runs on WARN_ON(!port) or when build_skb() fails. It gives the
page back to the page_pool, but rx->page[fdma->dcb_index][fdma->db_index]
still points at it.

lan969x_fdma_napi_poll() then breaks out before fdma_db_advance():

		skb = lan969x_fdma_rx_get_frame(sparx5, rx);
		if (!skb)
			break;

So the slot is not reloaded. In the same poll, the reload loop can also
hand the just-recycled page from the direct cache to an earlier slot.

After that, an MTU change that changes the page order goes through:

lan969x_fdma_resize()
  lan969x_fdma_rx_free()
    lan969x_fdma_free_pages()
      page_pool_put_full_page(rx->page_pool, rx->page[i][j], false)

Can this put the same page into the page_pool a second time? If so,
page_pool_destroy() would release it twice, with a double put_page() and
a double DMA unmap.

The commit message says the slot is cleared "to know which RX pages are
still owned by the driver when freeing them". The free_page path also
gives up ownership. Should it clear the slot as well?

Before this patch the free only happened at deinit. Now
lan969x_fdma_resize() runs it during normal operation.

[ ... ]

> @@ -468,3 +476,67 @@ int lan969x_fdma_deinit(struct sparx5 *sparx5)

[ ... ]

> +int lan969x_fdma_resize(struct sparx5 *sparx5, struct sparx5_port *port,
> +			int new_mtu)
> +{

[ ... ]

> +	sparx5_fdma_pause(sparx5);
> +
> +	/* The FDMA is stopped and reset, and NAPI and the TX queues are
> +	 * disabled, so nothing uses the buffers until sparx5_fdma_resume().
> +	 */
> +	lan969x_fdma_tx_reset(sparx5);
> +	lan969x_fdma_rx_free(sparx5, rx);
> +
> +	rx->fdma = rx_new->fdma;
> +	rx->page_pool = rx_new->page_pool;
> +	rx->page_order = rx_new->page_order;
> +	memcpy(rx->page, rx_new->page, sizeof(rx->page));
> +
> +	sparx5_fdma_resume(sparx5);

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. It
affects the RX refill path that this series makes larger.

Both RX NAPI paths ignore the return value of fdma_dcb_add() when they
re-arm a consumed DCB. In lan969x_fdma_napi_poll():

		fdma_dcb_add(fdma,
			     old_dcb,
			     FDMA_DCB_INFO_DATAL(fdma->db_size),
			     FDMA_DCB_STATUS_INTR);

		sparx5_fdma_reload(sparx5, fdma);

sparx5_fdma_napi_callback() does the same.

In fdma_api.c, __fdma_db_add() writes the status before the callback
gets a chance to fail:

	db->status = cpu_to_le64(status);

	err = cb(fdma, dcb_idx, db_idx, &dataptr);
	if (unlikely(err))
		return err;

__fdma_dcb_add() then returns before it links prev->nextptr and updates
fdma->last_dcb.

Suppose page_pool_dev_alloc_pages() in lan969x_fdma_rx_dataptr_cb() fails,
or the GFP_ATOMIC __netdev_alloc_skb() in sparx5_fdma_rx_dataptr_cb()
fails. The DCB then has DONE cleared, but it is not in the hardware chain,
and the next successful add links around it.

The software dcb_index still walks the ring in order. When it reaches
this DCB, fdma_has_frames() on lan969x, or fdma_db_is_done() in
sparx5_fdma_rx_get_frame(), sees a DCB that is not done and stops. No
further DCBs are re-armed, and the hardware stops at the last linked DCB.

Can one failed atomic refill stop CPU extraction for every port until
the FDMA is re-initialized?

The later commit "net: sparx5/lan969x: add support for changing the MTU"
enables jumbo MTUs, which turns these refills into higher-order
allocations. The fix commit "net: sparx5/lan969x: free the FDMA buffers
on init errors and deinit" checks errors for the initial fdma_dcbs_init()
fill, but not for this refill at runtime.

[ ... ]

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> @@ -558,3 +570,173 @@ int sparx5_fdma_stop(struct sparx5 *sparx5)
>  
>  	return 0;
>  }
> +
> +/* Check if any TX DB is still waiting to be transmitted */
> +static bool sparx5_fdma_tx_busy(struct fdma *fdma)
> +{
> +	for (int i = 0; i < fdma->n_dcbs; i++)
> +		if (!fdma_db_is_done(fdma_db_get(fdma, i, 0)))
> +			return true;
> +
> +	return false;
> +}
> +
> +/* Enable or disable the forwarding of frames to the CPU ports */
> +static void sparx5_fdma_cpu_fwd_set(struct sparx5 *sparx5, bool ena)
> +{
> +	for (int cpu = SPX5_PORT_CPU_0; cpu <= SPX5_PORT_CPU_1; cpu++) {
> +		int portno = sparx5_get_internal_port(sparx5, cpu);
> +
> +		spx5_rmw(QFWD_SWITCH_PORT_MODE_PORT_ENA_SET(ena),
> +			 QFWD_SWITCH_PORT_MODE_PORT_ENA,
> +			 sparx5,
> +			 QFWD_SWITCH_PORT_MODE(portno));
> +	}
> +}
> +
> +/* Get the memory used by the frames queued to the CPU ports */
> +static u32 sparx5_fdma_cpu_queue_use(struct sparx5 *sparx5)
> +{
> +	u32 use = 0;
> +
> +	for (int cpu = SPX5_PORT_CPU_0; cpu <= SPX5_PORT_CPU_1; cpu++) {
> +		int portno = sparx5_get_internal_port(sparx5, cpu);
> +		u32 base;
> +
> +		base = SPX5_QRES_DST_MEM + SPX5_PRIOS * portno;
> +		for (int prio = 0; prio < SPX5_PRIOS; prio++)
> +			use += QRES_RES_STAT_CUR_INUSE_GET(spx5_rd(sparx5,
> +					QRES_RES_STAT_CUR(base + prio)));
> +	}
> +
> +	return use;
> +}
> +
> +/* Stop the port TX queues and the FDMA, and reset the FDMA, so that the FDMA
> + * buffers can be replaced.
> + */
> +void sparx5_fdma_pause(struct sparx5 *sparx5)
> +{
> +	bool busy;
> +	u32 use;
> +
> +	/* Only ports that are up have TX queues to stop */
> +	for (int i = 0; i < sparx5->data->consts->n_ports; i++) {
> +		struct sparx5_port *port = sparx5->ports[i];
> +
> +		if (port && netif_running(port->ndev))
> +			netif_tx_disable(port->ndev);
> +	}
> +
> +	/* Give the frames already handed to the FDMA a chance to be sent, as
> +	 * they are lost when the FDMA is reset.
> +	 */
> +	if (read_poll_timeout(sparx5_fdma_tx_busy,
> +			      busy,
> +			      !busy,
> +			      SPX5_FDMA_TX_DRAIN_SLEEP_US,
> +			      SPX5_FDMA_TX_DRAIN_TIMEOUT_US,
> +			      false,
> +			      &sparx5->tx.fdma))
> +		dev_warn(sparx5->dev, "FDMA TX not drained, frames dropped\n");
> +
> +	/* Stop the switch core from forwarding frames to the CPU, and let the
> +	 * FDMA extract the frames already queued, so that the FDMA is not
> +	 * stopped and reset while the switch core is still sending it frames.
> +	 */
> +	sparx5_fdma_cpu_fwd_set(sparx5, false);
> +	if (read_poll_timeout(sparx5_fdma_cpu_queue_use,
> +			      use,
> +			      !use,
> +			      SPX5_FDMA_XTR_DRAIN_SLEEP_US,
> +			      SPX5_FDMA_XTR_DRAIN_TIMEOUT_US,
> +			      false,
> +			      sparx5))
> +		dev_warn(sparx5->dev, "CPU queue not drained, frames dropped\n");
> +
> +	sparx5_fdma_stop(sparx5);
> +
> +	/* Reset FDMA state */
> +	spx5_wr(FDMA_CTRL_NRESET_SET(0), sparx5, FDMA_CTRL);
> +	spx5_wr(FDMA_CTRL_NRESET_SET(1), sparx5, FDMA_CTRL);
> +
> +	/* Discard frames queued for the CPU, as they may not fit the new
> +	 * buffers.
> +	 */
> +	sparx5_xtr_flush(sparx5, XTR_QUEUE);
> +}
> +
> +/* Restart the FDMA and the port TX queues after sparx5_fdma_pause() */
> +void sparx5_fdma_resume(struct sparx5 *sparx5)
> +{
> +	struct sparx5_rx *rx = &sparx5->rx;
> +	struct sparx5_tx *tx = &sparx5->tx;
> +
> +	/* Enable NAPI before the RX interrupt is enabled, as the interrupt
> +	 * handler schedules NAPI, as in sparx5_fdma_start().
> +	 */
> +	napi_enable(&rx->napi);
> +
> +	sparx5_fdma_rx_activate(sparx5, rx);
> +	sparx5_fdma_tx_activate(sparx5, tx);
> +
> +	/* Forward frames to the CPU again, now that the FDMA can extract them */
> +	sparx5_fdma_cpu_fwd_set(sparx5, true);
> +
> +	for (int i = 0; i < sparx5->data->consts->n_ports; i++) {
> +		struct sparx5_port *port = sparx5->ports[i];
> +
> +		if (port && netif_running(port->ndev))
> +			netif_tx_wake_all_queues(port->ndev);
> +	}
> +}
> +
> +int sparx5_fdma_resize(struct sparx5 *sparx5, struct sparx5_port *port,
> +		       int new_mtu)
> +{
> +	struct sparx5_rx *rx = &sparx5->rx;
> +	struct sparx5_tx *tx = &sparx5->tx;
> +	struct sparx5_tx tx_new = {};
> +	struct sparx5_rx *rx_new;
> +	u32 db_size;
> +	int err;
> +
> +	db_size = sparx5_fdma_get_db_size(sparx5, port, new_mtu);
> +	if (db_size == rx->fdma.db_size)
> +		return 0;
> +
> +	rx_new = kzalloc_obj(*rx_new);
> +	if (!rx_new)
> +		return -ENOMEM;
> +
> +	sparx5_fdma_rx_init(sparx5, rx_new, FDMA_XTR_CHANNEL, db_size);
> +	sparx5_fdma_tx_init(sparx5, &tx_new, FDMA_INJ_CHANNEL, db_size);
> +
> +	err = sparx5_fdma_rx_alloc(rx_new);
> +	if (err)
> +		goto out;
> +
> +	err = sparx5_fdma_tx_alloc(&tx_new);
> +	if (err) {
> +		sparx5_fdma_rx_free(rx_new);
> +		goto out;
> +	}
> +
> +	sparx5_fdma_pause(sparx5);
> +
> +	/* The FDMA is stopped and reset, and NAPI and the TX queues are
> +	 * disabled, so nothing uses the buffers until sparx5_fdma_resume().
> +	 */
> +	sparx5_fdma_rx_free(rx);
> +	fdma_free_phys(&tx->fdma);
> +
> +	rx->fdma = rx_new->fdma;
> +	memcpy(rx->skb, rx_new->skb, sizeof(rx->skb));
> +	tx->fdma = tx_new.fdma;
> +
> +	sparx5_fdma_resume(sparx5);
> +out:
> +	kfree(rx_new);
> +
> +	return err;
> +}

[Severity: Medium]
sparx5_fdma_rx_alloc() fills the new ring through fdma_dcbs_init(),
which calls sparx5_fdma_rx_dataptr_cb() for every DB. That callback
always allocates the skb with GFP_ATOMIC:

	skb = __netdev_alloc_skb(rx->ndev, fdma->db_size, GFP_ATOMIC);
	if (unlikely(!skb))
		return -ENOMEM;

That fits the NAPI refill path. Here, though, it runs in process
context under RTNL. It allocates the whole ring of FDMA_DCB_MAX *
FDMA_RX_DCB_MAX_DBS (960) skbs while the old ring is still allocated
and the FDMA is still running on it.

With the jumbo MTUs enabled later in the series, db_size gets close
to 14 KB. Each skb head is then an order-2 allocation, roughly 15 MB
in total. GFP_ATOMIC cannot do direct reclaim or compaction. On a
system with fragmented memory the MTU change can fail with -ENOMEM
where a sleeping allocation would have succeeded.

It also draws on the __GFP_HIGH reserves that the NAPI refill of the
live ring needs at the same time. A failed refill there leads to the
stall raised above for fdma_dcb_add().

Could sparx5_fdma_rx_dataptr_cb() take the gfp mask from its caller?
For example, a field in struct sparx5_rx could let
sparx5_fdma_rx_alloc() use GFP_KERNEL while the NAPI refill keeps
GFP_ATOMIC.

lan969x_fdma_rx_dataptr_cb() looks the same, since
page_pool_dev_alloc_pages() is GFP_ATOMIC too. There the page order
also grows with the MTU.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-sparx5-mtu-change-v2-0-59c91357e8f6%40microchip.com
