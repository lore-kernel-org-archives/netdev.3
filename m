Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A8370D79;
	Sun,  4 Oct 2026 23:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791156808; cv=none; b=SrBu8khF6qXClEfNHjTx/QK6bgYKWgUeyYsesAcFRI0Nc2dAMkFBm4aVWtBPvsjMD5m0xlgGBKqzVe8vIIJ/TmghAHjpdtVg8KTr55e3Snsdhew/YdiHLvm9OeBp/6ZMdgK+wa2kpYnUIGGMEfjFv4OPA0O9bw3rtuTLKaL10Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791156808; c=relaxed/simple;
	bh=S0quYlFJxiJ9EEBg+v/5yVdeMpgzya4xtqOD4Vk0RTI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L9HjJCj7PXxXhThb//3cKeC6A+53QgxzlL5b+1rqW708UbGvNKGmKmli8+Jt5v0NYc+k+o1XRy2SwUSbVTtQv1q8czsI9OYW8nw1J3R9EjGKTOmziDdxTStk/AtZJKcMBGU2mDpzTD2RD5lLgCNpZkn5CGoU76+V+hGrT/4Gkko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlq8yxD8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlq8yxD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C1E1F00893;
	Sun,  4 Oct 2026 23:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791156807;
	bh=y+I+nhV4tmxvaiCBG1Ie8pXtveWP2/rZEEr1Gx+5TGc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nlq8yxD846x+Nm7F27PshKZDMuQEPDLURaCdGOF9W8usDGJ5xz6DbTE2TYfDdm9lv
	 E7/fomeg94p/Ay0J2HFFUxA5FJ+5mBRxrnbF5U3tLXeVb3zaa1Tw4FzsLxiz9BRlAv
	 kiFWYpzhb4MUC84FxUgDd60/jSNiu4sdXHbAuArfbvgXg5hkjOMDvQSrDN7X//w+uN
	 22TO5rC0IgunugHq8lUlfF8ApKqzema5VspdDQgkMqYjIKVC8EIGi71ox/TsQfi9ZS
	 JFTxW6iW6CoSGUCylmmNlpREy8QkDG+qBb8lHk8kENWzX1OFSC1RXWZWQG+qfPDnNO
	 Irm3igGXy1d4w==
Subject: Re: [PATCH net-next v10 7/8] net: macb: use context swapping in
 .set_ringparam()
From: netdev-bot+sashiko@kernel.org
To: theo.lebrun@bootlin.com
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pvalerio@redhat.com, nb@tipi-net.de,
 vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 benoit.monin@bootlin.com, tawfik.bayouk@mobileye.com,
 thomas.petazzoni@bootlin.com
Date: Sun, 04 Oct 2026 23:33:25 +0000
Message-ID: <179115680572.434549.1016291990685937691@kernel.org>
In-Reply-To: <20261001-macb-context-v10-7-beb541bbb7df@bootlin.com>
References: <20261001-macb-context-v10-7-beb541bbb7df@bootlin.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Use-after-free in the new live context swap.

--

net: macb: use context swapping in .set_ringparam()

This patch reworks macb_set_ringparam(). It now allocates a new context
before stopping the interface, swaps it in and then frees the old one,
instead of doing a full close/open. The generic swap logic is split into
macb_context_swap_start() and macb_context_swap_end(), and a new
mac_cfg_lock mutex serialises the swap against the phylink MAC callbacks.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 69873966a9890..93049b399d783 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -3217,6 +3255,112 @@ static void macb_configure_dma(struct macb *bp)
>  	}
>  }
>  
> +static void macb_context_swap_start(struct macb *bp)
> +{
> +	struct macb_queue *queue;
> +	unsigned long flags;
> +	unsigned int q;
> +	u32 ctrl;
> +
> +	mutex_lock(&bp->mac_cfg_lock);
> +
> +	macb_quiesce_start(bp);

[ ... ]

> +static void macb_context_swap_end(struct macb *bp,
> +				  struct macb_context *new_ctx)
> +{

[ ... ]

> +	old_ctx = bp->ctx;
> +	WRITE_ONCE(bp->ctx, new_ctx);
> +	wmb(); /* ensure IRQ enabled below read the new context */
> +	macb_init_buffers(bp);

[ ... ]

> +	mutex_unlock(&bp->mac_cfg_lock);
> +
> +	/* Free old context. */
> +
> +	macb_free(old_ctx);
> +	kfree(old_ctx);
> +}

[Severity: High]
Can a NAPI poll still be reading old_ctx when it gets freed here?

The swap depends on macb_quiesce_start() calling napi_disable() to drain
NAPI. However, napi_disable() only waits for NAPIF_STATE_SCHED and
NAPIF_STATE_NPSVC to clear, and napi_complete_done() clears SCHED before
the poll callback returns. Documentation/networking/napi.rst notes that
napi_disable() only waits for the ownership of the instance to be
released, not for the poll method to exit.

Both poll functions keep reading the context after napi_complete_done()
succeeds. In macb_rx_poll():

	if (work_done < budget && napi_complete_done(napi, work_done)) {
		queue_writel(queue, IER, bp->rx_intr_mask);
		...
		if (macb_rx_pending(queue)) {

and macb_rx_pending() does:

	struct macb_context *ctx = queue->bp->ctx;
	struct macb_rxq *rxq = macb_rxq(queue);
	...
	entry = macb_rx_ring_wrap(ctx, rxq->tail);
	desc = macb_rx_desc(ctx, q, entry);
	...
	return (desc->addr & MACB_BIT(RX_USED)) != 0;

macb_tx_poll() does the same through macb_tx_complete_pending(). That
function reads queue->bp->ctx and the TX ring under tx_ptr_lock. The swap
and free path takes neither tx_ptr_lock nor any other lock or RCU grace
period that these helpers respect.

This looks like a possible interleaving:

poll CPU
macb_rx_poll()
  napi_complete_done()   /* clears SCHED */
  macb_rx_pending()
    ctx = queue->bp->ctx;   /* old ctx */
    <delayed>

ethtool CPU
macb_set_ringparam()
  macb_context_swap_start()
    macb_quiesce_start()
      napi_disable()   /* returns, SCHED already clear */
  macb_context_swap_end()
    WRITE_ONCE(bp->ctx, new_ctx);
    ...
    macb_free(old_ctx);   /* rings NULLed and dma_free_coherent()ed */
    kfree(old_ctx);

poll CPU
    desc = macb_rx_desc(ctx, q, entry);   /* freed memory */

Here the poll CPU would dereference the kfree()d context, a NULL ring
pointer, or freed coherent DMA memory. The delay could come from threaded
NAPI, softirq preemption on PREEMPT_RT, interrupts or vCPU preemption.
This can be triggered with ethtool -G while traffic is flowing.

The new irq_quiesced check in macb_tx_restart() does not seem to cover
this. That helper runs before napi_complete_done() and is already
protected by NAPI ownership.

macb_close() uses the same napi_disable-then-free pattern. This patch adds
a new free-while-running site that is reachable during normal operation.
The later patch "net: macb: use context swapping in .ndo_change_mtu()"
reuses these helpers without adding any extra synchronization.

Would a synchronize_net() (or an equivalent grace period) before
macb_free(old_ctx) be enough to close this window? Alternatively, the
post-completion helpers could be made to check for an ongoing swap.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001-macb-context-v10-0-beb541bbb7df%40bootlin.com
