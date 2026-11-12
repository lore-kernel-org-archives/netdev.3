Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503680;
	b=4GXKk9tkxMTXUdJpVJ8S4CP4waJJvdYYO1e2SEM3fXBQhNdGAehzLrB2zuPSSd6QFjx1
	 9p6Oz/1ptN+ddcxj3rLpTXHckYzL5s1k//5VD14ktEmcz/TyZ4iDzdgxVBmMixzYnJbut
	 aTmPPt5YAcaWr1BnXVa84nEWRb4ole+yZ192+CG6AW9LXprgoM9qWHHheuNKB9CwJbIqJ
	 XPzOQK2v5/ArX3jX9H+Nx2ocD2U0gqMb4slRLP5R9jUiKGCwha3eg3ptEPCBChA2TT1mY
	 iMaPlTts5a7wTwsvqR4aNFK8pMgK0BcBvx28ea4cwQzpcLHLkS9uqeMmMeX/qoQ0VAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503680;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/TDcQhTa12XtYWxapL+e3sH8uDMDLzi4mZ29QKak43A=;
	b=DWcXIp6V+T0SUm/M7Jt6rRvMpcp/SojJYHY2jyfbacGNehvb0/V4Kt/Q62WAN2XXxH3g
	 WKsHaZlio8lZYVPoXbi5SeDKo/8letpzP3JI1bEkxmiXu5rt70ldMNCgnNMyLSGEKbbCh
	 1zWRG6JuU/1mEhHseb0qG+ykCwLRw5/Cqu+w92e6rB22f/GT87gDSPK+xOymplOXPivLA
	 G9ISLOWhVcahPN5QSHkEzH4dwUOrn2JtAh5bwLuYds4ZhP0iS2bA2lhtKeETU/yH5wDb2
	 ilFqKynF9UwkY5yiy/S0IUPeYo17KmkJ7FKGJq8C6UVA+B890J2Z7se4Pt58diHHjsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2XvtUl1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013FA606A31C;
	Thu, 12 Nov 2026 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2XvtUl1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0024F1F000C4;
	Thu, 12 Nov 2026 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503679;
	bh=/TDcQhTa12XtYWxapL+e3sH8uDMDLzi4mZ29QKak43A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l2XvtUl1+lKAuKGPvcerkThj5kNyPxpTvfjnCKaaUKGn36RZWOWeCOlC6OJPHw9k/
	 t4uWQdMnE23Vt2u04lU2sJFqzxxvAe+lmvh/9j1kzII2qAJosOdIcMcaRRRKbvJNTq
	 1y+hQ9qL8qfkmgscPD7UDgFI9bcIXQ6cydo+DucogK5lik7MHPXM2mqgA3MD2X8lHE
	 62N8+cbFXwL4Rm3b/ypvyLxnnvPKY2oWyIDmhLhPJuExbgY6LPgG9YcOr5hfHPBtyu
	 COCAkqoBWydfthmDlknVMnoH3SLgqMRirFShdu7wO71mI43LMnh88IcBMJfISMyaGo
	 vpBzHcari0TSQ==
Subject: Re: [PATCH net 1/7] net: bcm4908_enet: fix the TX ring wrap
From: netdev-bot+sashiko@kernel.org
To: kudzo51@gmail.com
Cc: netdev@vger.kernel.org, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 17:14:38 +0000
Message-ID: <179450367847.2199510.5624854630375363280@kernel.org>
In-Reply-To: <20261109235700.2586821-2-kudzo51@gmail.com>
References: <20261109235700.2586821-2-kudzo51@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The early ring-full path at the top of
  bcm4908_enet_start_xmit() (`if…
- [Low] The commit message leaves out a second symptom of the same index
  mismatch, which this patch also fixes.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch's
  new stop/wake logic still depends on it working.

--

net: bcm4908_enet: fix the TX ring wrap

The TX ring now uses all descriptors, with WRAP on the last one. Both
read_idx and write_idx wrap at length, and one descriptor is always left
free, so read_idx == write_idx can only mean an empty ring.
bcm4908_enet_start_xmit() now stops the queue once the ring is full.
bcm4908_enet_poll_tx() wakes it again, with smp_mb() on both sides.

> diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
> index fd2715f84af97..01a3e1d0192f8 100644
> --- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
> +++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c

[ ... ]

> @@ -525,20 +535,14 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic

[ ... ]

>  	/* Free transmitted skbs */
>  	if (enet->irq_tx < 0 &&
> -	    !(le32_to_cpu(ring->buf_desc[ring->read_idx].ctl) & DMA_CTL_STATUS_OWN))
> +	    !(le32_to_cpu(ring->buf_desc[READ_ONCE(ring->read_idx)].ctl) & DMA_CTL_STATUS_OWN))
>  		napi_schedule(&enet->tx_ring.napi);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
does the new stop/wake logic work when the optional TX interrupt is
missing?

In Documentation/devicetree/bindings/net/brcm,bcm4908-enet.yaml, both
interrupts and interrupt-names have minItems: 1. A DT node that lists
only "rx" is therefore valid, and probe carries on with
enet->irq_tx < 0.

In that case bcm4908_enet_open() never enables the TX NAPI:

	if (enet->irq_tx > 0) {
		napi_enable(&tx_ring->napi);

The TX NAPI still has NAPI_STATE_SCHED set from netif_napi_add, so
napi_schedule() here always fails in napi_schedule_prep(), and
bcm4908_enet_poll_tx() never runs.

Nothing then advances read_idx, unmaps or frees the TX skbs, or wakes
the queue. After length - 1 frames, the new stop-on-full branch at the
end of bcm4908_enet_start_xmit() stops the queue. Nothing wakes it
again, although the new comment there says "poll_tx() wakes the queue
once there is room".

On ifdown, bcm4908_enet_stop() calls napi_disable(&tx_ring->napi) on
the NAPI that was never enabled. Wouldn't napi_disable_locked() then
spin here forever while holding RTNL and the netdev instance lock?

		while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
			usleep_range(20, 200);
			val = READ_ONCE(n->state);
		}

bcm4908_enet_stop() also calls free_irq(enet->irq_tx, enet) with a
negative IRQ.

This goes back to 12bb508bfe5a ("net: broadcom: bcm4908_enet: support
TX interrupt"). The in-tree bcm4908.dtsi provides both "rx" and "tx",
so only DTs that use the binding's optional-TX form are affected.

>  
> -	/* Don't use the last empty buf descriptor */
> -	if (ring->read_idx <= ring->write_idx)
> -		free_buf_descs = ring->read_idx - ring->write_idx + ring->length;
> -	else
> -		free_buf_descs = ring->read_idx - ring->write_idx;
> -	if (free_buf_descs < 2) {
> +	if (unlikely(bcm4908_enet_tx_free_descs(ring) < 1)) {
>  		netif_stop_queue(netdev);
>  		return NETDEV_TX_BUSY;
>  	}

[Severity: Medium]
Can this early ring-full path in bcm4908_enet_start_xmit() lose a
wakeup?

It stops the queue without the smp_mb() and re-check that the patch
adds at the end of bcm4908_enet_start_xmit(). include/net/netdev_queues.h
says the standard stop/wake pairing does not prevent false wake ups
when the ring is full, and that drivers should check for ring full at
the start of the xmit handler. So this path can be reached.

Here is one way to get a false wake:

  - bcm4908_enet_poll_tx() finds netif_queue_stopped() true and free
    descriptors >= 1.
  - Meanwhile the stop/smp_mb/re-check at the end of start_xmit
    restarts the queue.
  - poll_tx is delayed, for example by a hardirq, before it calls
    netif_wake_queue().
  - start_xmit fills the last free descriptor and stops the queue
    again.
  - poll_tx's late netif_wake_queue() then clears XOFF on a full ring.

There is no read barrier in poll_tx between the XOFF test and the
write_idx load, so load-load reordering is another way to get there.

On the next xmit, the early check reads read_idx and sees a full ring.
Suppose the poll_tx() runs that reap the remaining descriptors finish
inside the window before netif_stop_queue() here:

CPU0 (start_xmit)                    CPU1 (poll_tx)
bcm4908_enet_tx_free_descs() == 0
                                     reap all outstanding descriptors
                                     WRITE_ONCE(tx_ring->read_idx, ...)
                                     smp_mb()
                                     netif_queue_stopped() == false
netif_stop_queue()
return NETDEV_TX_BUSY

No descriptors are outstanding at that point, so no TX interrupt or
NAPI poll follows, and the driver has no ndo_tx_timeout. Wouldn't the
queue then stay stopped until ifdown/ifup? That is the "queue stops for
good with nothing left to wake it" symptom the commit message describes.

The window is narrow. It needs the xmit CPU to be preempted, as on
PREEMPT_RT, or held by a long hardirq.

Could this path use netif_txq_try_stop() instead, or the same
stop/smp_mb/re-check/restart sequence used at the end of
bcm4908_enet_start_xmit()?

[ ... ]

> @@ -572,8 +576,17 @@ static netdev_tx_t bcm4908_enet_start_xmit(struct sk_buff *skb, struct net_devic
>  
>  	bcm4908_enet_dma_tx_ring_enable(enet, &enet->tx_ring);
>  
> -	if (++ring->write_idx == ring->length - 1)
> -		ring->write_idx = 0;
> +	WRITE_ONCE(ring->write_idx,
> +		   ring->write_idx == ring->length - 1 ? 0 : ring->write_idx + 1);

[Severity: Low]
This isn't a bug, but the commit message leaves out a second symptom of
the same index mismatch, and this change fixes it too.

With the old wrap at length - 1, slot length - 1 was never filled.
bcm4908_enet_poll_tx() wrapped read_idx at length. After it reaped
slot length - 2, read_idx became length - 1, which write_idx could
never equal.

The loop then ran on the unused slot, whose descriptor ctl is still
zero, so OWN is clear. Once per ring lap it called dma_unmap_single()
with slot->dma_addr 0 and slot->len 0, then dev_kfree_skb(NULL) and
handled++. This over-counted tx_packets and caused CONFIG_DMA_API_DEBUG
warnings about unmapping memory that was never mapped.

The changelog only says:

    while poll_tx() wraps read_idx at length,

Could it also name this symptom, so stable backporters can see that it
is covered?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109235700.2586821-1-kudzo51%40gmail.com
