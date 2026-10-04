Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E4D4A9D61;
	Sun,  4 Oct 2026 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791156810; cv=none; b=CBXTHW3F5XFBt+oRFL95Fh2S5cvD7VGtRKn1GQ6U55d1LRtuZLYPF9qrq80Ov4Tk+1z37XxaO+4Um5QGtb4ww9uqX0wkMWYjNq1KTUrowAE6gq/W9oIH+CFEmU+EUmilOH2j9ts5V5jeIn8v/f6TCiAMf+fGY7MhIPyT6DACh9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791156810; c=relaxed/simple;
	bh=gzTPK1kgCcfbEh/SgJPAiHKNR2bkNbowfQXzL3iyd2M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mj6Lp9o2iQOS1O+NtgeIrmJ6gBviLXjLEQMaZntifzeLRj6Wp98aMwjs44tVljeYKyc3TkPkoccLB06dPWrwckd6FtrrHlfR7Cx0ZNU/PL8ejeP5FzXLu8JMXWI2t3H9mYyeOaPINSif7ZhCaNzo7iZgqVAm25b9MIT9S0nb4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kETp0PIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kETp0PIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9681F000FF;
	Sun,  4 Oct 2026 23:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791156808;
	bh=eMbqOy7D+B/cTppdW34ezcVo5LlA/Z+uE3UF/jHTbkc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kETp0PItlsjNw+KbMPWVoMZfDgcB3z3Bd3ilfURtYo5nz1Fd8S4eVRlkTtCF2xKDu
	 vNDmYaWI+5D/+qH6Q33Rj+A8d73DzYQMuFuYFTsIhC8gZFPyhEOY6UXGE+1B218MvF
	 E4cdh3PgbgkUl/DfDZACfsDInQtzGHN0jICbvViI+Ys6mAbXMKPlIb+REDOPDOoa4G
	 0ijnF44/YPJX/XeMJOW2vUohh7XQXGvJh3cllxVJ4ZRyTfKxj9YF8MIxs9Ptqz9mX7
	 dddyoe+eIxax84fTWb7HbSA5JWCo95YcxZMimbVZrWifAj/ioVJAaPdUIq8Rthw6g0
	 wq1lDh6OXTPhg==
Subject: Re: [PATCH net-next v10 8/8] net: macb: use context swapping in
 .ndo_change_mtu()
From: netdev-bot+sashiko@kernel.org
To: theo.lebrun@bootlin.com
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pvalerio@redhat.com, nb@tipi-net.de,
 vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 benoit.monin@bootlin.com, tawfik.bayouk@mobileye.com,
 thomas.petazzoni@bootlin.com
Date: Sun, 04 Oct 2026 23:33:27 +0000
Message-ID: <179115680718.434549.17282980902772682527@kernel.org>
In-Reply-To: <20261001-macb-context-v10-8-beb541bbb7df@bootlin.com>
References: <20261001-macb-context-v10-8-beb541bbb7df@bootlin.com>
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

- [High] A live MTU change can free the old context while a NAPI poll on
  another CPU is still reading it.

--

net: macb: use context swapping in .ndo_change_mtu()

This patch changes .ndo_change_mtu() so that it works on a running
interface. It allocates a new context, quiesces and reconfigures the
hardware, then frees the old context. Before this patch the call returned
-EBUSY when the interface was up. AT91 EMAC still returns -EBUSY.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 93049b399d783..4b03f8a513722 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3624,11 +3624,29 @@ static int macb_close(struct net_device *netdev)
>  
>  static int macb_change_mtu(struct net_device *netdev, int new_mtu)
>  {
> -	if (netif_running(netdev))
> -		return -EBUSY;

[ ... ]

> +		new_ctx = macb_context_alloc(bp, new_mtu,
> +					     bp->configured_rx_ring_size,
> +					     bp->configured_tx_ring_size);
> +		if (IS_ERR(new_ctx))
> +			return PTR_ERR(new_ctx);
> +
> +		macb_context_swap_start(bp);
> +	}
>  
>  	WRITE_ONCE(netdev->mtu, new_mtu);
>  
> +	if (running)
> +		macb_context_swap_end(bp, new_ctx);

[Severity: High]
Can a live MTU change free the old context while a NAPI poll on another
CPU is still reading it?

Both poll functions keep using context memory after
napi_complete_done(). In macb_rx_poll():

    if (work_done < budget && napi_complete_done(napi, work_done)) {
        queue_writel(queue, IER, bp->rx_intr_mask);
        ...
        if (macb_rx_pending(queue)) {

macb_rx_pending() then reads bp->ctx and rxq->tail/prepared_head, and
dereferences a descriptor in the rx ring:

    struct macb_context *ctx = queue->bp->ctx;
    struct macb_rxq *rxq = macb_rxq(queue);
    ...
    desc = macb_rx_desc(ctx, q, entry);
    ...
    return (desc->addr & MACB_BIT(RX_USED)) != 0;

macb_tx_poll() does the same thing. After napi_complete_done() it calls
macb_tx_complete_pending(), which reads:

    if (macb_tx_desc(ctx, q, txq->tail)->ctrl & MACB_BIT(TX_USED))

napi_complete_done() clears NAPIF_STATE_SCHED. napi_disable() only waits
for the instance's ownership bits to clear, not for the poll callback to
return. Documentation/networking/napi.rst says drivers should not touch
data structures after napi_complete_done() for this reason.

One possible interleaving:

CPU A (softirq)
macb_rx_poll()
    napi_complete_done()   /* SCHED cleared */

CPU B
macb_change_mtu()
    macb_context_swap_start()
        macb_quiesce_start()
            synchronize_irq() ...
            napi_disable()   /* returns immediately */
    macb_context_swap_end()
        WRITE_ONCE(bp->ctx, new_ctx);
        ...
        macb_free(old_ctx);   /* dma_free_coherent() of rings */
        kfree(old_ctx);

CPU A
    macb_rx_pending()
        reads the freed ctx and descriptor ring

As far as I can see, nothing on the swap path closes this window. There
is no synchronize_net() or synchronize_rcu(), and no tx_ptr_lock or
bp->lock handshake with the poll tail.

On non-coherent ARM/arm64 SoCs, coherent DMA memory is usually remapped
and unmapped on free, so this read could fault in softirq context. The
window is short on !PREEMPT_RT. It can be much longer under PREEMPT_RT,
threaded NAPI, or vCPU preemption.

Before this patch, macb_change_mtu() never reached the swap path on a
running interface. Any CAP_NET_ADMIN "ip link set mtu" while traffic is
flowing now gets there.

The same window also seems to exist through .set_ringparam(), which an
earlier patch in this series ("net: macb: use context swapping in
.set_ringparam()") converted to context swapping. Would a grace period
such as synchronize_net() before freeing old_ctx in
macb_context_swap_end() fix both paths? So would making the poll tails
avoid touching the context after napi_complete_done().

> +
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001-macb-context-v10-0-beb541bbb7df%40bootlin.com
