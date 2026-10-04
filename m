Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAB68834;
	Sun,  4 Oct 2026 23:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791156807; cv=none; b=RJtX/9i+oHNfZPthm6pAtSUKWRg5Y+vQMa9ui9lXEjI++3swnWlCR8M9dmyqtOkzhmejGIaPEBkIMu1uZXrBS3qSz61dZYbSYsuP8t1EdqjnoCwbPlyZFmBc9U8rICT3z5v7aoOO7obri8MrSMorzd09ssdu+ofSl90c0TJ6dmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791156807; c=relaxed/simple;
	bh=eUg7ALBfUlqtl6bA3QdRqOc1Im0AUfDBsGxQFqAsKlM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lv3KGzf+HiG9oUwFQDlu/IaFOz60h+8/Q6loKD1u1aNAPLPdma+VjeqbSWnyi3AnJNLP356FhW/nccKCKL8l93abxgMmtox4MHbf5wfppeyL6rZBmqLal1w4hpW6QOgNXMDva2HjcrbQ5ek2+ku0xVQRYW96kIabxYpH7eqqpqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grWpclYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grWpclYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94D71F000FF;
	Sun,  4 Oct 2026 23:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791156805;
	bh=ZQdSTzO3ISuY186dZrE7R2+fMNKkZdI9xKCNQl0QcAQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=grWpclYkIUYoVekEl2+qzNNQlCo5YS0G9JYj5zJ0qGZJdC1ymHowErlIHGKNN9uZ6
	 onCIc9WBRvZCjsFxpGgw3rMAcmE0uT+TXSFN7VsZmFlBPjZBCKQwntLnTEhhBWkKxW
	 Db8oHytXFtqgX+RI99GEB5BbffPOSC39Yj9wiMq8MCqcfe92npzrq+k4OMP/2+vWQQ
	 9sqB+UcCK9fIUQ5azFts0AZh1wfLy0TBFRbtkTefcJJPxaHVvYV7vOh9wpk+JKEddN
	 I07SjqPjSDdmrs17RdDe/2jHWQdii9eK370Iv3ADc+ud6/JHwlPCU//LEXfLyoNE+X
	 q9j6zM7ukD1qQ==
Subject: Re: [PATCH net-next v10 1/8] net: macb: introduce macb_context struct
 for buffer management
From: netdev-bot+sashiko@kernel.org
To: theo.lebrun@bootlin.com
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pvalerio@redhat.com, nb@tipi-net.de,
 vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 benoit.monin@bootlin.com, tawfik.bayouk@mobileye.com,
 thomas.petazzoni@bootlin.com
Date: Sun, 04 Oct 2026 23:33:24 +0000
Message-ID: <179115680422.434549.3193325311731249627@kernel.org>
In-Reply-To: <20261001-macb-context-v10-1-beb541bbb7df@bootlin.com>
References: <20261001-macb-context-v10-1-beb541bbb7df@bootlin.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The NAPI poll handlers read the context after
  napi_complete_done(), and nothing stops that context from being freed…
- [Low] The patch changes what `ethtool -g` reports on AT91 EMAC devices,
  and the commit message does not say so.
- [Low] On EMAC, at91ether_open() kzallocs bp->ctx and never sets
  ctx->rx_ring_size or ctx->tx_ring_size, so both stay 0.

Pre-existing issues:
- [Medium] macb_set_ringparam() calls macb_close(), updates
  configured_*_ring_size, and then calls macb_open(bp->netdev) without…

--

net: macb: introduce macb_context struct for buffer management

This commit moves the per-queue ring buffers and ring parameters out of
struct macb and struct macb_queue into a new struct macb_context. The
context is allocated in macb_open()/at91ether_open() and freed on close.
User-requested ring sizes are now kept in bp->configured_{rx,tx}_ring_size
so they persist while the interface is down.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 20fe307898343..73ee650e09060 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -2011,15 +2011,16 @@ static void macb_tx_restart(struct macb_queue *queue)
>  
>  static bool macb_tx_complete_pending(struct macb_queue *queue)
>  {
> +	struct macb_txq *txq = macb_txq(queue);
>  	bool retval = false;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
> -	if (queue->tx_head != queue->tx_tail) {
> +	if (txq->head != txq->tail) {

[Severity: Medium]
Can bp->ctx be freed while this is running?

macb_tx_poll() calls this after napi_complete_done() has already released
NAPI ownership:

    if (work_done < budget && napi_complete_done(napi, work_done)) {
        queue_writel(queue, IER, MACB_BIT(TCOMP));
        ...
        if (macb_tx_complete_pending(queue)) {

napi_disable() waits only for ownership to be released. It does not wait
for the poll function to return. Documentation/networking/napi.rst says:

    napi_disable() and subsequent calls to the poll method only wait for
    the ownership of the instance to be released, not for the poll method
    to exit. This means that drivers should avoid accessing any data
    structures after calling napi_complete_done().

That seems to allow this interleaving:

CPU A                               CPU B
macb_tx_poll()
  napi_complete_done() == true
  <delayed>
                                    macb_close()
                                      macb_quiesce_start()
                                        napi_disable()  /* returns */
                                      ...
                                      macb_free(bp);
                                      kfree(bp->ctx);
                                      bp->ctx = NULL;
  macb_tx_complete_pending()
    macb_txq()
      &bp->ctx->txq[q]   /* NULL or freed */
    txq->head

Before this patch, queue->tx_head and queue->tx_tail lived in bp->queues
and were always valid. The freed ring was only touched when head != tail.
Now txq points into the ctx, so an empty TX ring also hits the freed or
NULL memory.

The RX side (macb_rx_poll()->macb_rx_pending()->macb_rxq()) already had a
similar window on rx_ring before this patch. Now it is on the ctx itself.

This window also seems to remain at the end of the series. There,
macb_close() and macb_context_swap_end() free the old ctx after
napi_disable(), with no further synchronization.

Should the poll handlers avoid touching ctx after napi_complete_done()?
Alternatively, should the ctx free wait for in-flight poll calls to return?

[ ... ]

> @@ -3822,8 +3912,8 @@ static int macb_set_ringparam(struct net_device *netdev,
>  		macb_close(bp->netdev);
>  	}
>  
> -	bp->rx_ring_size = new_rx_size;
> -	bp->tx_ring_size = new_tx_size;
> +	bp->configured_rx_ring_size = new_rx_size;
> +	bp->configured_tx_ring_size = new_tx_size;
>  
>  	if (reset)
>  		macb_open(bp->netdev);

[Severity: Medium]
This is a pre-existing issue, but the macb_open() return value is ignored
here.

With this patch, every macb_open() error path ends with bp->ctx == NULL:

    free_ctx:
        kfree(bp->ctx);
        bp->ctx = NULL;

Meanwhile the netdev stays IFF_UP. A later dev_close()->macb_close() calls
macb_quiesce_start()->napi_disable() on NAPI instances that were left
disabled, and that hangs. The same hang could already happen before this
patch when macb_alloc() failed on reopen. If that point were somehow
passed, macb_free() would then dereference the NULL bp->ctx.

This patch adds one more way for this path to fail: the kzalloc_obj() of
ctx.

The later commit "net: macb: use context swapping in .set_ringparam()" in
this series seems to fix this. It allocates the new context first and
returns the error with the interface untouched.

Should the macb_open() failure be handled here until then?

[ ... ]

> @@ -5177,6 +5267,13 @@ static int at91ether_open(struct net_device *netdev)
>  	if (ret < 0)
>  		return ret;
>  
> +	WRITE_ONCE(bp->ctx, kzalloc_obj(*bp->ctx));
> +	wmb(); /* ensure IRQ enabled below read the new context */
> +	if (!bp->ctx) {
> +		ret = -ENOMEM;
> +		goto pm_exit;
> +	}
> +

[Severity: Low]
Unlike macb_open(), at91ether_open() never sets ctx->rx_ring_size or
ctx->tx_ring_size. Both stay 0, while bp->configured_* holds 9/1.

Shared helpers still read these fields. For example,
at91ether_start()->macb_rx_desc()->macb_rx_ring_wrap() does:

    return index & (bp->ctx->rx_ring_size - 1);

With a size of 0 the mask is UINT_MAX, so indices pass through unchanged.
This matches the pre-patch behaviour, where bp->rx_ring_size was also 0
on EMAC.

It only works because at91ether_start() bounds its loop with
AT91ETHER_MAX_RX_DESCR and at91ether_rx() wraps rxq->tail by hand.

If the configured value were copied into ctx the way macb_open() does it,
there would be a problem. AT91ETHER_MAX_RX_DESCR (9) is not a power of
two, so the mask would be 8 and descriptors 1..7 would alias descriptor 0.

Is it intended that the EMAC ctx has ring sizes of 0 while configured_*
reports 9/1?

[ ... ]

> @@ -5998,6 +6101,15 @@ static int macb_probe(struct platform_device *pdev)
>  	/* setup capabilities */
>  	macb_configure_caps(bp, macb_config);
>  
> +	if (bp->caps & MACB_CAPS_MACB_IS_EMAC) {
> +		/* The name is lying on EMAC: sizes aren't configurable. */
> +		bp->configured_rx_ring_size = AT91ETHER_MAX_RX_DESCR;
> +		bp->configured_tx_ring_size = 1; /* tiny ring buffer */
> +	} else {

[Severity: Low]
This changes what ethtool -g reports on EMAC devices.

Before this patch, only macb_init_dflt() set bp->rx_ring_size and
bp->tx_ring_size. EMAC goes through at91ether_init() instead, but it still
installs macb_ethtool_ops. As a result, macb_get_ringparam() reported 0/0
on EMAC. With this hunk it reports 9/1.

The new values match the hardware: TX only ever uses rm9200_txq[0]. So
this looks like a fix to the reporting.

However, the commit message describes configured_{rx,tx}_ring_size only as
a way to keep the sizes across close. Could it also mention the
user-visible ethtool -g change on EMAC?

Also, at91ether_open() does not copy configured_* into the ctx (see the
comment above), so the reported values and the ctx disagree.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001-macb-context-v10-0-beb541bbb7df%40bootlin.com
