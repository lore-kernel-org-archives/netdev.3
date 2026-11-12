Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503681;
	b=vUj6gNL40Rv4g0IQ370Zeu8I11yqNxqqfm7EXWpgPsS7picf3hd5nwadqipesOgNl7LI
	 c+KsOHEW2AMi+mFCZJTAo2LuFuh+XbYCkpn810nKeiK+hAbksklP6sWyQXVi1fddYJHJN
	 y4eRvbaCzcrX+dh/GXoTQAsP/Or6Ns2zZF9W6DrGxpJehtHwwugXkFA/KlGq9boA4JwwZ
	 d8Oj4D6LU5TVzTAoKn+QKjN/ncTDjhvX3tM1dYO+93hT04aK3um+P4JN9PNi4nDHnIEbK
	 nLbO8nZin2vNBqEwglmj3tcl/i9mT93wkGqgQelmyd/e68+iwoVgqONpTmbKtNpldzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503681;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VwN746fV+LTBntHPt3X5byRkdkovaZwpypaxqChd8dw=;
	b=dLyhbcKoatHZug3xvLklnvbcjQyYTUYWNT4HcUVhL8rwZ9OcbeGLtjHbdc6gGC00orDO
	 25v0JUzEi642b/OvaoXdCJOFdLrc6pZ4mRg/bYp5I/+WnAE74vbMyOsr1yceJ8HhZDWlJ
	 cipugecoyYxrGaiu5h80EOi6jUwFp6xNfhfgpOkuTGCSYlaY9oErnaNY+mADWQK8esyTG
	 rVC5Xjc+0otHp9BlAAB1/Fw7xrDBc8vTmgDlz5Se/ez4kovL8kgAnKrg3R+gIFPYRlS/K
	 WCMAMVh0g2Hoz8EN+zUj7iWMyaa0L7BaHD4a4zLaCchkTQ/r441YKCF3SQLMo16UJ1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gXQ/1cOF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3732606A334;
	Thu, 12 Nov 2026 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gXQ/1cOF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F3B1F000C4;
	Thu, 12 Nov 2026 17:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503680;
	bh=VwN746fV+LTBntHPt3X5byRkdkovaZwpypaxqChd8dw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gXQ/1cOFzqR/ktXLHrwnhgH5HZWq4fnsOk0tyYOWhPUB8a1NZOBajh49ElgloZnfr
	 VIj6cMBXy1SF9YbLJOeeWA8H9PVjRbwCXbD1kMxA4PalfFf3lgKpOQqkH96xX5dfot
	 lMkYcrNBtDw2VNhajr8EYkxgJpAia8kbpElYBLorXZFiwuNqVgai9zJ123A2MhIh1A
	 ZLqFUWOMGD+kgltTFu2UY0P3VZ8oaluC87KaqkOr9BRcBgRq8WWLXzXnrJlVnKun94
	 Q/D2XgjSZN9v/ytreQQuXT8QexrDSRGGaB2KduXJWY1cj+rRpsFkqhJ5XgdpjJkX8B
	 wPsqfbaozOiiw==
Subject: Re: [PATCH net 3/7] net: bcm4908_enet: release the TX ring on stop
From: netdev-bot+sashiko@kernel.org
To: kudzo51@gmail.com
Cc: netdev@vger.kernel.org, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 17:14:39 +0000
Message-ID: <179450367976.2199510.16783228260595826791@kernel.org>
In-Reply-To: <20261109235700.2586821-4-kudzo51@gmail.com>
References: <20261109235700.2586821-4-kudzo51@gmail.com>
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

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In bcm4908_enet_stop()
  (drivers/net/ethernet/broadcom/bcm4908_enet.c), the new…
- [Medium] bcm4908_enet_poll_tx() now writes slot->skb = NULL (line 711)
  and then publishes the freed slots with a plain…
- [Low] The commit message says that without the patch, the next open
  means 'the DMA can send from a buffer that has been freed'.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the open and
  stop paths disagree about the optional TX interrupt, and that keeps…

--

net: bcm4908_enet: release the TX ring on stop

This patch unmaps and frees the skbs still left in the TX ring when
bcm4908_enet_stop() runs, and clears slot->skb in bcm4908_enet_poll_tx()
after the skb is freed. It also zeroes the TX descriptors in
bcm4908_enet_dma_ring_init(), so stale DMA_CTL_STATUS_OWN bits are not
carried into the next open.

> bcm4908_enet_stop() disables the TX DMA but leaves the ring as it is:
> the skbs of frames not completed yet stay mapped and are never freed,
> and their descriptors keep DMA_CTL_STATUS_OWN. The next open starts
> the indexes from 0 again over those descriptors, so the DMA can send
> from a buffer that has been freed, and start_xmit() finds OWN set on a
> slot it is about to use.

[Severity: Low]
Does "the DMA can send from a buffer that has been freed" describe the
code before this patch?

bcm4908_enet_poll_tx() is the only place TX skbs are freed. It frees a
slot only after the hardware has cleared OWN:

	if (le32_to_cpu(buf_desc->ctl) & DMA_CTL_STATUS_OWN)
		break;

bcm4908_enet_start_xmit() also will not reuse a slot that still has OWN
set:

	if (unlikely(le32_to_cpu(buf_desc->ctl) & DMA_CTL_STATUS_OWN)) {
		netif_stop_queue(netdev);
		return NETDEV_TX_BUSY;
	}

The descriptor ring and slots are allocated at probe time and kept
across stop/open. An skb behind a stale OWN descriptor was therefore
leaked and left mapped, not freed.

Before this patch the effects seem to be these:

- skbs, socket wmem charges and DMA mappings leak.
- Stale frames from the previous session go out after reopen.
- TX can stall.

The stall happens when slot 0 still has OWN after reopen. start_xmit()
then stops the queue before it calls bcm4908_enet_dma_tx_ring_enable().
No TX completion fires after that, so poll_tx() never wakes the queue,
and the driver has no ndo_tx_timeout.

Could the commit message list these effects instead of a use-after-free?
That would help stable/backport triage.

> diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
> index 727ad1e96db35..8008b44a4635f 100644
> --- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
> +++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c

[ ... ]

> @@ -510,6 +531,7 @@ static int bcm4908_enet_stop(struct net_device *netdev)
>  	bcm4908_enet_dma_rx_ring_disable(enet, &enet->rx_ring);
>  	bcm4908_enet_dma_tx_ring_disable(enet, &enet->tx_ring);
>  
> +	bcm4908_enet_tx_ring_clean(enet);

[Severity: High]
Can the TX DMA still be reading these buffers when
bcm4908_enet_tx_ring_clean() unmaps and frees them?

bcm4908_enet_dma_tx_ring_disable() is a single posted write. It does
not wait for the channel to stop:

	enet_write(enet, ring->cfg_block + ENET_DMA_CH_CFG, 0);

The RX helper, bcm4908_enet_dma_rx_ring_disable(), polls for up to 2 ms
until the hardware drops ENABLE:

	tmp = enet_read(enet, ring->cfg_block + ENET_DMA_CH_CFG);
	if (!(tmp & ENET_DMA_CH_CFG_ENABLE))
		return;

That suggests the channel stops asynchronously. bcm63xx_enet drives the
same DMA block. Its bcm_enet_disable_dma() polls
ENETDMAC_CHANCFG_EN_MASK for both TX and RX before
bcm_enet_tx_reclaim() runs. ENET_DMA_CTRL_CFG_MASTER_EN and UMAC
CMD_TX_EN are also still set at this point.

Suppose the interface goes down while frames are in flight. The DMA
could still be fetching the current descriptor's buffer here:

bcm4908_enet_stop()
  bcm4908_enet_dma_tx_ring_disable()   <- CFG = 0, no wait
  bcm4908_enet_tx_ring_clean()
    dma_unmap_single()
    dev_kfree_skb_any()

Before this patch those skbs leaked but stayed mapped, so a late DMA
read still hit valid memory. With this change the DMA could read freed
and possibly reallocated memory. That data could go out on the wire, or
the read could fault on IOMMU systems.

bcm4908_enet_dma_ring_init() clears the TX descriptors under the
comment "A descriptor the stopped DMA never completed still carries
OWN". That memset only runs at the next open. Until then, the OWN
descriptors that point at the freed buffers stay in the ring.

Could the TX disable path poll for ENET_DMA_CH_CFG_ENABLE to clear, as
the RX path does, before the buffers are freed?

>  	bcm4908_enet_dma_uninit(enet);
>  
>  	free_irq(enet->irq_tx, enet);

[Severity: High]
This isn't a bug introduced by this patch, but if the TX interrupt is
missing, does bcm4908_enet_stop() ever reach the new
bcm4908_enet_tx_ring_clean()?

The binding (brcm,bcm4908-enet.yaml) allows only the "rx" interrupt
(minItems: 1). bcm4908_enet_probe() accepts a negative value here:

	enet->irq_tx = platform_get_irq_byname(pdev, "tx");

bcm4908_enet_open() enables the TX NAPI only when that IRQ exists:

	if (enet->irq_tx > 0) {
		napi_enable(&tx_ring->napi);

bcm4908_enet_stop() still calls napi_disable(&tx_ring->napi)
unconditionally. netif_napi_add_tx() leaves the NAPI with SCHED and
NPSVC set. napi_disable_locked() would then loop in usleep_range()
forever, holding RTNL and the netdev instance lock.

In the same setup, this fallback in bcm4908_enet_start_xmit() always
fails in napi_schedule_prep(), because SCHED is already set:

	napi_schedule(&enet->tx_ring.napi);

So poll_tx() never runs, and TX stops once the ring fills.

The free_irq(enet->irq_tx, enet) here is also unconditional. open() only
requests that IRQ when irq_tx > 0.

[ ... ]

> @@ -686,6 +708,7 @@ static int bcm4908_enet_poll_tx(struct napi_struct *napi, int weight)
>  
>  		dma_unmap_single(dev, slot->dma_addr, slot->len, DMA_TO_DEVICE);
>  		dev_kfree_skb(slot->skb);
> +		slot->skb = NULL;

[Severity: Medium]
Can this NULL store race with bcm4908_enet_start_xmit() reusing the slot
on another CPU?

Later in bcm4908_enet_poll_tx(), the freed slots are published with a
plain store:

	WRITE_ONCE(tx_ring->read_idx, read_idx);

Nothing orders the slot->skb = NULL stores before it. The smp_mb() in
poll_tx() comes after it.

start_xmit() reads read_idx without a lock, through
bcm4908_enet_tx_free_descs(), and then writes:

	slot->skb = skb;

On arm64 the late NULL store from poll_tx() could land after that
write. One possible sequence:

- start_xmit() fills the ring and stops the queue.
- It rechecks after smp_mb() and sees that poll_tx() freed two or more
  slots.
- It restarts the queue and fills old_read-1, then old_read.

That slot would then hold skb == NULL while its descriptor belongs to
the new frame. The next poll_tx() unmaps it and calls
dev_kfree_skb(NULL), so the skb and its socket sk_wmem_alloc charge
leak. bcm4908_enet_tx_ring_clean() would skip that slot as well.

The window looks very narrow in practice, since poll_tx() runs an
smp_mb() shortly after the WRITE_ONCE(). Still, before this patch only
start_xmit() wrote slot->skb.

Would smp_store_release(&tx_ring->read_idx, read_idx), or an smp_wmb()
before the WRITE_ONCE(), be enough? Another option is for
bcm4908_enet_tx_ring_clean() to walk read_idx..write_idx, so poll_tx()
would not need this store at all.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109235700.2586821-1-kudzo51%40gmail.com
