Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B35B4A4EE1;
	Fri, 25 Sep 2026 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344346; cv=none; b=Mk/J35Z7RBqXJK5J7J1IpY78IjisSvm3Nisx99Tnpii6J7qwhLfwkhAOK+pm+HW8731vyNzqkoKOGyk/mh8rHbXHFY7hAV73a9fak2LEPYqUV1QuootFZN28vyGbLofaOp+hfK8e6sVgPlphUMz91H9iDAubOxM2Yir7Ozw3rEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344346; c=relaxed/simple;
	bh=fGFzYX71+rr6A/SV1pDWmXiKMNZGcCthiPK9IK+Qe3A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fSm73TOEKV18uh4BbcorVVJWFawXrkL+uIrG/BLiB5BAXWkwHs7yPPPZ9n5xbQ8N94+OgbtpqGw+zDrq2o+OcyUOd+OhfcVR2InA2P8NP8NoXOiQkb9Hzcydom50VqHZ0BvEHF9JeIMt6e/bx55aXcZ6ST0Lc9Wq7QR6BS9Mllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAlBJxtt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAlBJxtt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0C61F000FF;
	Fri, 25 Sep 2026 13:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790344344;
	bh=f3BiFWB0AB1cE/gRSYPxMNSCMVVdBSZol4rDfzd56ec=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WAlBJxtt9owiIsTJMuk6kY3ALx5QNCSSQ6sjw6lvpDsmkGAtamsgAtSSdyrPAcPFQ
	 jWdK8uyLpBuzfi3NMgetqjzb96tc7RqNy1X8PCDhez025kAbIOVp3c8MHU0vO8uXvV
	 nKR4lGLPnZfbOS8FaEEQf3wN5C20O6vZJ82Xy66N4OLmEfAaX5FBfHiQqhQJt9r3ad
	 Lgm/txJG95TjmASIFnnVbJtVbXFoOdyZwhDfH59gZLCzSPDLUnEMQCNtVSV55PTWAI
	 4a7UWkcUaKkGhMtKrGkVMWYSryW+c/4mBwuJfEq99TdvZe6f71TOA0D5kNIgFKidfR
	 /jNqM5BNqK1/Q==
Subject:
 Re: [PATCH net v2 1/4] net: axienet: start the TX queue in axienet_open()
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: netdev@vger.kernel.org, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 daniel@iogearbox.net, andybnac@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 13:52:23 +0000
Message-ID: <179034434365.2160803.14320302243857899975@kernel.org>
In-Reply-To: <20260924135116.185161-2-maimon.sagi@gmail.com>
References: <20260924135116.185161-2-maimon.sagi@gmail.com>
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

- [Low] On resume, the new netif_start_queue() at the end of
  axienet_open() makes the later netif_device_attach() skip its qdisc…

Pre-existing issues:
- [High] axienet_open() throws away the return value of
  axienet_device_reset().
- [High] axienet_resume() ignores the return value of axienet_open().

--

net: axienet: start the TX queue in axienet_open()

This adds a netif_start_queue() call at the end of a successful
axienet_open(). The goal is to clear a __QUEUE_STATE_DRV_XOFF left over
from a close while the queue was stopped. Without that, the interface
could stay unable to transmit after a down/up cycle.

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 782f903d318f3..fb26d2e39faca 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -1700,6 +1700,11 @@ static int axienet_open(struct net_device *ndev)
>  			goto err_phy;
>  	}
>  
> +	/* Nothing else clears a stop left over from before the last close:
> +	 * the ring is empty, so no TX completion will wake the queue.
> +	 */

[Severity: High]
This isn't a bug introduced by this patch, but this comment and the commit
message ("The ring is reinitialised empty") assume that the reset at the
top of axienet_open() succeeded. Is that guaranteed?

axienet_open() {
	...
	axienet_lock_mii(lp);
	ret = axienet_device_reset(ndev);
	axienet_unlock_mii(lp);

	ret = phylink_of_phy_connect(lp->phylink, lp->dev->of_node, 0);
	...
}

The axienet_device_reset() result is overwritten before anything checks it.
On the legacy DMA path, axienet_device_reset() returns early in two cases:
__axienet_device_reset() times out, or axienet_dma_bd_init() fails:

axienet_dma_bd_init() {
	...
	lp->tx_bd_v = dma_alloc_coherent(lp->dev, ...);
	if (!lp->tx_bd_v)
		return -ENOMEM;
	...
out:
	axienet_dma_bd_release(ndev);
	return -ENOMEM;
}

In both cases axienet_dma_start() never runs. tx_bd_v is then either NULL
or a stale pointer, because axienet_dma_bd_release() does not clear it.
The memory it points to was already freed, either by the error path above
or by the previous axienet_stop() when the reset times out on reopen.

axienet_open() still returns 0, and with this patch it also starts the
queue. The next axienet_start_xmit() then reaches
axienet_check_tx_bd_space():

	cur_p = &lp->tx_bd_v[(READ_ONCE(lp->tx_bd_tail) + num_frag) %
			     lp->tx_bd_num];
	if (cur_p->cntrl)

Can this dereference a NULL tx_bd_v? Could it instead write descriptors
into freed coherent memory and kick XAXIDMA_TX_TDESC on a channel that was
never started?

A later ifdown also goes through axienet_stop()->axienet_dma_bd_release(),
which would call dma_free_coherent() on tx_bd_v a second time.

The new netif_start_queue() also clears a stop left over from the previous
close, even though the hardware was never initialised. Should
axienet_open() check the axienet_device_reset() return value before going
on?

> +	netif_start_queue(ndev);

[Severity: Low]
On the resume path, does this stop netif_device_attach() from rescheduling
the qdisc?

axienet_suspend() calls netif_device_detach(), which sets
__QUEUE_STATE_DRV_XOFF. Packets sent while the device is suspended can stay
queued in the qdisc. axienet_resume() then does:

	rtnl_lock();
	axienet_open(ndev);
	rtnl_unlock();

	netif_device_attach(ndev);

axienet_open() now ends with netif_start_queue(), which clears DRV_XOFF
without calling __netif_schedule(). Then
netif_device_attach()->netif_tx_wake_all_queues()->netif_tx_wake_queue()
reschedules only when it clears the bit itself:

netif_tx_wake_queue() {
	...
	if (test_and_clear_bit(__QUEUE_STATE_DRV_XOFF, &dev_queue->state)) {
		...
		__netif_schedule(q);
	...
}

The bit is already clear at that point, so the backlog is not rescheduled.
The commit message says the resume path works "because
netif_device_attach() wakes the queues", but with this change that wake
does nothing.

If the carrier is already up when linkwatch runs (fixed-link, for example),
the queued packets would wait for the next unrelated enqueue. Would using
netif_wake_queue() in axienet_open() avoid this? Another option would be
to leave the resume case to netif_device_attach().

> +
>  	return 0;

[Severity: High]
This is a pre-existing issue, but axienet_open() is also called from
axienet_resume(). What happens if it fails there?

axienet_resume() {
	...
	rtnl_lock();
	axienet_open(ndev);
	rtnl_unlock();

	netif_device_attach(ndev);

	return 0;
}

The return value is ignored. So if phylink_of_phy_connect(), request_irq(),
axienet_init_dmaengine() or axienet_init_legacy_dma() fails, the device is
still attached, its TX queues are woken, and the PM core is told that
resume succeeded.

On legacy DMA, axienet_stop() disabled NAPI during suspend, and the failed
open either never re-enabled it or disabled it again in its error path. A
later ifdown then runs axienet_stop() again:

	napi_disable(&lp->napi_tx);
	napi_disable(&lp->napi_rx);

Can this spin forever in napi_disable_locked() while holding RTNL? The same
path would also call free_irq() on tx_irq and rx_irq, which may not be
requested at that point.

On dmaengine, tx_skb_ring and rx_skb_ring have already been freed and the
channels released. That happened either in axienet_stop() during suspend
or in the axienet_init_dmaengine() error path. Can
axienet_start_xmit_dmaengine() then use the freed tx_skb_ring and the
released tx_chan? Can a later ifdown kfree() the ring entries a second
time?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924135116.185161-1-maimon.sagi%40gmail.com
