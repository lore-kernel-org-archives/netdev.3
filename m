Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602529;
	b=pvs7WiaJuj5YEpxaOXuH4z20H39XiLckfWS0uw8ioaj6ZnWsOxWPOK2iburXnEDcbjNA
	 6WW9M59fb1MtJUMCQfaSGcPqROeysIC3SgaJtvxHsRyvjps2eWvDpHydqd++VxKqOuGSm
	 +42erPf1AQojjgThboAnJ81ogZbNEHmdE3rrq/7kiBccPg/nrHYoMK06c03nPDXTRuObq
	 DKinUShQ+5BgstpprnalyoCBqolr7n3nmSB3gEZ+zPi7/TND607cA5/ahlaNsGGildqp7
	 M6R8QjU2vls1dy/sHrXuPlslkNIHRNOpJIipyl2jCB3vIdIuWPYH13iawIyCbBZ7VFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602529;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=24ZB7C+xk57SPHEJRtbLd+k3HhvZYXpppDTs6E1+8t0=;
	b=23gzaXS0yfwEVJOkbs/tTfcATjayd1DaUi5ff7ZfDEfX6ohO6GstuExNsJDsX4COzH4L
	 hJTCWBAoXG1YXYVmJkCAxPu/8t3bf+/lu1KmeR3M07S39hQOHnL+sXuTK8U5Exr3cnDmj
	 c1Z7jCR4wt86AjTi3BiuJsyVV5yn/M7hx/e+fwyFW9JJEKElVkebMl6ve/S4qqYprrzpm
	 KaC/7t+7HD/ITKR+/PRYXmzhrECUOBVqmwYY0WJpU5sjJg2a9ReLlCpJdRyM7C+QUaS9g
	 kxfmED8I2qXLCtMNZMbIMNJXeeo/UI0NAoWpQUeS2bOnR90mUTKlSBL5MzVFOBzBdRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibI9HDRY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1ED606A32D;
	Fri, 13 Nov 2026 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibI9HDRY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278561F000C4;
	Fri, 13 Nov 2026 20:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602528;
	bh=24ZB7C+xk57SPHEJRtbLd+k3HhvZYXpppDTs6E1+8t0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ibI9HDRYDL3qXuFApPYH5PzklzMtkjMgPsQ9RwGtlZr9JTimBy94vdVnkzq7RAFxf
	 Uce0BCNFGzKODk9tr+1GNTR+MB65wjrnp2gCJ+hNa5m7Jj/gFrkoOtkT9hM4yD+vCk
	 BSzMWpSV1Nbp1rwFOB0gw21wQ2YEKz5iHcLnci2GTBeFKoe1YOTosgXKkzkjIvgxMj
	 fyaGSuAzZ18g1/EczxeBKOJzBfNx6ZpSxbbH893PjZHv/IfP9YIcqWCUN9n4N8y0y+
	 6ShnuynbHZ9WzcoY7JsEJINL0mvPOGh5oHk15Yvmc62N3HHROpWrai3HGBjSahO33c
	 akthls1omT7mQ==
Subject: Re: [PATCH net v2 1/6] net: bcm4908_enet: fix the TX ring wrap
From: netdev-bot+sashiko@kernel.org
To: kudzo51@gmail.com
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com,
 florian.fainelli@broadcom.com, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 20:42:07 +0000
Message-ID: <179460252768.2199510.4667025168810979943@kernel.org>
In-Reply-To: <20261112195051.597102-2-kudzo51@gmail.com>
References: <20261112195051.597102-2-kudzo51@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] net: bcm4908_enet: missing barriers and late write_idx update
  on TX ring

Pre-existing issues:
- [High] When the device tree has no "tx" interrupt, TX completions never
  run, so the queue stop/wake design this patch adds cannot work.
- [High] bcm4908_enet_poll_tx() reads the producer index without a lock
  or ordering, then reads descriptor and slot contents with no read…

--

net: bcm4908_enet: fix the TX ring wrap

This patch makes start_xmit() and poll_tx() wrap the TX ring indexes at
the same point. It sets WRAP on the last descriptor and keeps one
descriptor free, so read_idx == write_idx always means an empty ring. It
also switches the queue stop/wake logic to the netif_txq_* helpers from
netdev_queues.h.

> diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
> index fd2715f84af97..60f711e8ce189 100644
> --- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
> +++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c

[ ... ]

> @@ -518,30 +519,34 @@ static int bcm4908_enet_stop(struct net_device *netdev)

[ ... ]

>  	/* Free transmitted skbs */
>  	if (enet->irq_tx < 0 &&
> -	    !(le32_to_cpu(ring->buf_desc[ring->read_idx].ctl) & DMA_CTL_STATUS_OWN))
> +	    !(le32_to_cpu(ring->buf_desc[READ_ONCE(ring->read_idx)].ctl) &
> +	      DMA_CTL_STATUS_OWN))
>  		napi_schedule(&enet->tx_ring.napi);

[ ... ]

> @@ -572,8 +577,13 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
>  
>  	bcm4908_enet_dma_tx_ring_enable(enet, &enet->tx_ring);
>  
> -	if (++ring->write_idx == ring->length - 1)
> -		ring->write_idx = 0;
> +	if (ring->write_idx == ring->length - 1)
> +		WRITE_ONCE(ring->write_idx, 0);
> +	else
> +		WRITE_ONCE(ring->write_idx, ring->write_idx + 1);
> +
> +	/* poll_tx() wakes the queue once there is room again */
> +	netif_txq_maybe_stop(txq, bcm4908_enet_tx_free_descs(ring), 1, 1);

[Severity: Medium]
This isn't introduced by this patch either, but separately from the
missing read barrier on write_idx in bcm4908_enet_poll_tx(), are there
two more ordering problems in this lockless ring?

bcm4908_enet_start_xmit() hands the descriptor to the DMA by setting
OWN in buf_desc->ctl, and kicks the channel with
bcm4908_enet_dma_tx_ring_enable(), before it publishes the new
ring->write_idx here. Suppose the frame completes and the TX interrupt
is taken on another CPU inside that window. bcm4908_enet_irq_handler()
masks and acks the TX interrupt and schedules the TX NAPI.
bcm4908_enet_poll_tx() then still sees read_idx == write_idx, handles
nothing, calls napi_complete_done() and unmasks the interrupt again.
The status for that frame has already been acked, so nothing brings
poll_tx() back for it.

If that frame is the one that made netdev_sent_queue() hit the BQL
limit, or made netif_txq_maybe_stop() stop the queue, nothing is left
to wake it and TX stalls much like the bug this patch fixes. If not,
the skb and its BQL bytes still sit there until some later frame's
completion. The window is small, but a hard interrupt on the
transmitting CPU between the enable and the WRITE_ONCE() is enough to
widen it.

Simply publishing write_idx before the enable doesn't look sufficient
if the channel is still running from an earlier frame and picks up
the descriptor as soon as OWN is set. Would it make sense for
poll_tx() to re-check the ring after re-enabling the interrupt and
reschedule itself if a completed descriptor is pending?

Second, the WRITE_ONCE(tx_ring->read_idx, read_idx) at the end of
bcm4908_enet_poll_tx() is not a release. On arm64 that store can
become visible before the earlier loads of buf_desc->ctl,
slot->dma_addr, slot->len and slot->skb in the loop are done. When
poll_tx() reclaims several slots in one pass from a full ring,
bcm4908_enet_tx_free_descs() in start_xmit() on another CPU can
already count them as free, and start_xmit() refills slots[] and
buf_desc[] for them. Could poll_tx() then unmap the new buffer, free
the new skb while the DMA is reading it, or report the wrong length
to BQL?

Would smp_store_release(&tx_ring->read_idx, read_idx) here, paired
with smp_load_acquire() of read_idx in bcm4908_enet_tx_free_descs(),
be enough? The barrier in netif_txq_completed_wake() comes after
this store, so it does not order the loads in the loop before it.

[Severity: High]
This is a pre-existing issue, but does this comment still hold when the
device tree has no "tx" interrupt?

The binding (brcm,bcm4908-enet.yaml) has minItems: 1 for interrupts and
interrupt-names, so a DT with only "rx" is valid. In that case
bcm4908_enet_probe() stores a negative value in enet->irq_tx, and
bcm4908_enet_open() never enables the TX NAPI:

bcm4908_enet_open() {
    ...
	if (enet->irq_tx > 0) {
		napi_enable(&tx_ring->napi);
    ...
}

netif_napi_add() leaves NAPI_STATE_SCHED set until napi_enable(). So the
napi_schedule() fallback in bcm4908_enet_start_xmit() never does
anything: napi_schedule_prep() sees SCHED already set and returns false,
and bcm4908_enet_poll_tx() never runs.

After this patch, poll_tx()->netif_txq_completed_wake() is the only path
that wakes the queue. Once length - 1 frames are queued, or the BQL limit
is reached, netif_txq_maybe_stop() stops the queue. start_xmit() is then
never called again, so TX stays stopped for good.

On ifdown, bcm4908_enet_stop() calls napi_disable(&tx_ring->napi)
unconditionally. Does napi_disable_locked() then spin forever with RTNL
held, waiting for SCHED/NPSVC to clear on a NAPI that was never enabled?
stop() also calls free_irq(enet->irq_tx, enet) with a negative IRQ.

This dates back to commit 12bb508bfe5a ("net: broadcom: bcm4908_enet:
support TX interrupt"). The later patches in this series don't seem to
change the open/stop gating or the irq_tx < 0 path.

Would it make sense to always enable the TX NAPI and only free the TX IRQ
when irq_tx > 0? Another option is to make the TX interrupt mandatory.

>  
>  	return NETDEV_TX_OK;
>  }
> @@ -652,17 +662,19 @@ static int bcm4908_enet_poll_tx(struct napi_struct *napi, int weight)

[ ... ]

> +	int read_idx = tx_ring->read_idx;
>  	unsigned int bytes = 0;
>  	int handled = 0;
>  
> -	while (handled < weight && tx_ring->read_idx != tx_ring->write_idx) {
> -		buf_desc = &tx_ring->buf_desc[tx_ring->read_idx];
> +	while (handled < weight && read_idx != READ_ONCE(tx_ring->write_idx)) {
> +		buf_desc = &tx_ring->buf_desc[read_idx];
>  		if (le32_to_cpu(buf_desc->ctl) & DMA_CTL_STATUS_OWN)
>  			break;
> -		slot = &tx_ring->slots[tx_ring->read_idx];
> +		slot = &tx_ring->slots[read_idx];
>  
>  		dma_unmap_single(dev, slot->dma_addr, slot->len, DMA_TO_DEVICE);
>  		dev_kfree_skb(slot->skb);

[Severity: High]
This isn't a bug introduced by this patch, but is a read barrier missing
between the write_idx load and the descriptor and slot loads here?

write_idx is not read with smp_load_acquire(), and there is no
smp_rmb()/dma_rmb() before the reads of buf_desc->ctl and slot->dma_addr,
slot->len and slot->skb. Only a control dependency links them, and on
arm64 that doesn't order a load against a later load.

Nothing clears the ctl word of a free descriptor, so a slot completed on
the previous lap still has OWN=0. That looks the same as a frame that
just completed. Suppose poll_tx() has caught up, so read_idx == write_idx
== i:

CPU1 (start_xmit, under the TX queue lock)
    fill slots[i], set buf_desc[i].ctl = OWN
    bcm4908_enet_dma_tx_ring_enable()
    WRITE_ONCE(ring->write_idx, i + 1)

CPU2 (poll_tx, NAPI, does not take the TX queue lock)
    load buf_desc[i].ctl early -> stale OWN=0
    READ_ONCE(tx_ring->write_idx) -> i + 1
    dma_unmap_single() / dev_kfree_skb() on slot i

Could this unmap and free the skb that the DMA is still reading? And if
the slot loads return the previous lap's values, could it double free
the old skb and leak the new one? BQL and the statistics would also be
updated too early.

The patch turns this loop into an explicit lockless producer/consumer
scheme, but the netif_txq_* helpers only order the stop/wake decision.
The later patch in this series that publishes the buffer address before
OWN adds dma_wmb()/dma_rmb() only to the producer and RX paths. poll_tx()
is the same at the end of the series.

Would it be enough to use smp_load_acquire(&tx_ring->write_idx) paired
with smp_store_release() in start_xmit()? Adding an smp_rmb() after the
index check would be another option.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112195051.597102-1-kudzo51%40gmail.com
