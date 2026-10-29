Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290516;
	b=UlrBmuxYEFkGfvYp82zuqEsnEQGamRXNRtA0yPifvfJAm95U5uH1Zk9oieMFgm9OcbVy
	 Wi4zcRdAsib31gsQw+0HyC4Rk7fRVgy2ORH66ZZbgAWzTU+Df9B4/jJsRfPMTJkx6P+1m
	 9ppeEQo7xrQ0JltLaCv61sDcMH5xlsUgk2jbgr3BZCmUKREw9r20Hg3HDwCD5AG1VPGzL
	 8zycRf2pyMrGa4uH4h1aW9nWn0GrjDL70kYhdw/AP7zAi/ONof3y7QNLKBmdUgR7cAGoI
	 HplSuJXrHadVe8WiQ4vf8rUyp/PrUuPEwfzTJSAqTPHH3/l5PF4sgvOaGeuuGlo3Mpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290516;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=k6NrO70p6SzlKRqmWvppOYWBQqrvnG6uRQVbixAqVsY=;
	b=dKSvpEt/aT01NfwfiztZOql90z3INjF2KkCsbSXMMcsINO9Qj5o5ZfaNXQL4yB2Sk0kF
	 ikRZHhiPmhZfizkbWidX85rFAZDHPrzpXwcXbplFYGPxf8KdVQosePTTF0NABKa67TNwS
	 UN33dFt+BB86tEBHAvtKBttIQTP/jLJHlidx70360A80Q8f7zuOjd1MedI1JGMVuDgFY3
	 /z0HolgqLqK9LsN62+fptExqNXjreCpWpvvqvARLwqK32XZJv1Ar7a7teKO1zXwGRQDHR
	 lWr9U3gjam3KQxZ53FvSH8VVegbjQAgerJyZQfkmxC05b9/V0z14tUNzjKasBMH4/CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MmKNS+xL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D354560A2608;
	Thu, 29 Oct 2026 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MmKNS+xL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6AD1F031E0;
	Thu, 29 Oct 2026 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290515;
	bh=k6NrO70p6SzlKRqmWvppOYWBQqrvnG6uRQVbixAqVsY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MmKNS+xLMhWpCX0yHiIQAFzVnPXx3QbBuEvveHVzBh6TPq75GX8q0uGJjivmQZArc
	 N2iKqYvGiWUGZ3PYPY7GfOGkgPSgo0DBUXmu87J9e1w8HPHw9j3FGcSepV+ZMgxG2i
	 jii1MK3OVxisaaWSK4aBMtnedcG87o6BkhjdCLx87NyvkB45pGPIBXaY+ItuYK8bEO
	 P+orIrdz/Ds//ZvV5sG30PGtlcfmxShRHN2vTuwWrqWQ586/tuKRTXYFWzKq9aZicW
	 qmq8I1yIjiuXaXvAhYs5BAvI0RsjJpAh5f24r+d/WJSF3uwMHT8RWlaQ/fpDJ7jL+r
	 9PFXTn+0bcXlw==
Subject: Re: [PATCH net 05/11] net: au1000: serialize TX completion with
 packet submission
From: netdev-bot+sashiko@kernel.org
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, shaojijie@huawei.com, horms@kernel.org,
 runyu.xiao@seu.edu.cn, mmyangfl@gmail.com, hvr@gnu.org, jeff@garzik.org,
 danny.kukawka@bisect.de, mugunthanvnm@ti.com, sebastian.hesselbarth@gmail.com,
 linux-kernel@vger.kernel.org, manuel.lauss@gmail.com
Date: Thu, 29 Oct 2026 16:15:13 +0000
Message-ID: <179329051390.3134.18192194876316281231@kernel.org>
In-Reply-To: <20261027223140.3774570-6-f.fainelli@gmail.com>
References: <20261027223140.3774570-6-f.fainelli@gmail.com>
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

Critical: 0 (1) · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] au1000_tx() in drivers/net/ethernet/amd/au1000_eth.c now frees
  the skb with hardware IRQs disabled.
- [Medium] After this patch, au1000_tx()'s inline reclaim path leaves
  aup->tx_tail permanently out of step with the hardware.

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but
  au1000_tx() copies skb->len bytes into a fixed MAX_BUF_SIZE…

--

net: au1000: serialize TX completion with packet submission

This commit takes the existing IRQ-safe aup->lock in both au1000_tx_ack()
and au1000_tx(). The goal is to serialize TX descriptor reclamation in hard
IRQ context with packet submission in ndo_start_xmit. It also closes a
missed-wakeup window between netif_stop_queue() and setting tx_full.

> diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
> index a507a524370fd..90887dac26bc9 100644
> --- a/drivers/net/ethernet/amd/au1000_eth.c
> +++ b/drivers/net/ethernet/amd/au1000_eth.c

[ ... ]

> @@ -973,17 +977,20 @@ static netdev_tx_t au1000_tx(struct sk_buff *skb, struct net_device *dev)
>  	u32 buff_stat;
>  	struct db_dest *pDB;
>  	int i;
> +	unsigned long flags;
>  
>  	netif_dbg(aup, tx_queued, dev, "tx: aup %x len=%d, data=%p, head %d\n",
>  				(unsigned)aup, skb->len,
>  				skb->data, aup->tx_head);
>  
> +	spin_lock_irqsave(&aup->lock, flags);
>  	ptxd = aup->tx_dma_ring[aup->tx_head];
>  	buff_stat = ptxd->buff_stat;
>  	if (buff_stat & TX_DMA_ENABLE) {
>  		/* We've wrapped around and the transmitter is still busy */
>  		netif_stop_queue(dev);
>  		aup->tx_full = 1;
> +		spin_unlock_irqrestore(&aup->lock, flags);
>  		return NETDEV_TX_BUSY;
>  	} else if (buff_stat & TX_T_DONE) {
>  		au1000_update_tx_stats(dev, ptxd->status);

[Severity: Medium]

Now that the lock is held here, can this inline reclaim leave aup->tx_tail
permanently out of step with the hardware?

If desc[tx_head] has TX_T_DONE set at this point, the ring is full
(tx_head == tx_tail) and the oldest buffer has just completed. This branch
updates stats and zeroes len. Later in au1000_tx() the code re-arms the
descriptor, which clears the done bit, and advances tx_head:

	ptxd->buff_stat = lower_32_bits(pDB->dma_addr) | TX_DMA_ENABLE;
	...
	aup->tx_head = (aup->tx_head + 1) & (NUM_TX_DMA - 1);

tx_tail is never advanced on this path.

Before this patch, on the uniprocessor Au1x00, the pending MAC DMA
interrupt could run au1000_tx_ack() before the re-arm and move tx_tail
forward. Now the ISR is held off until spin_unlock_irqrestore(). At that
point au1000_tx_ack() finds desc[tx_tail] re-armed with no done bit:

	while (ptxd->buff_stat & TX_T_DONE) {

So it returns without moving tx_tail, which now points at the newest
submitted descriptor.

au1000_init() sets tx_head from the hardware's own buffer index, so the
hardware completes descriptors in index order and that newest descriptor
completes last. Wouldn't that leave the TX_T_DONE bits of older completed
descriptors unacknowledged until then?

It would also delay netif_wake_queue() in au1000_tx_ack() until the whole
4-entry ring drains, rather than after one completion. The offset would
then persist until au1000_init() resets head and tail.

The same thing can happen when au1000_tx() is called with IRQs already
disabled, for example from netpoll.

The MAC DMA interrupt is IRQ_TYPE_LEVEL_HIGH, and au1000_interrupt() always
returns IRQ_RETVAL(1). If unacknowledged done bits keep the line asserted,
could this become an interrupt storm? That part depends on hardware
behaviour that has not been confirmed.

[ ... ]

[Severity: Critical]

This is a pre-existing issue, not one introduced by this patch.
au1000_tx() copies skb->len bytes into a fixed MAX_BUF_SIZE (2048 byte)
bounce buffer without checking the length:

	pDB = aup->tx_db_inuse[aup->tx_head];
	skb_copy_from_linear_data(skb, (void *)pDB->vaddr, skb->len);

Can skb->len be larger than 2048 here? When po->vnet_hdr_sz is nonzero,
tpacket_snd() in net/packet/af_packet.c skips both MTU checks:

	if ((size_max > dev->mtu + reserve + VLAN_HLEN) && !vnet_hdr_sz)
		size_max = dev->mtu + reserve + VLAN_HLEN;
	...
		if (likely(tp_len >= 0) &&
		    tp_len > dev->mtu + reserve &&
		    !vnet_hdr_sz &&
		    !packet_extra_vlan_len_allowed(dev, skb))

An all-zero virtio_net_hdr (GSO_NONE, no NEEDS_CSUM) is accepted without
making the skb GSO. validate_xmit_skb() then only linearizes it, because
au1000 does not advertise NETIF_F_SG, and applies no MTU check.

With CAP_NET_RAW, this path could deliver a multi-kilobyte skb to
au1000_tx():

socket(AF_PACKET, SOCK_RAW)
  setsockopt(PACKET_VNET_HDR)
  setsockopt(PACKET_TX_RING) with tp_frame_size > 2048
  tpacket_snd()
    packet_xmit()
      validate_xmit_skb()
        au1000_tx()
          skb_copy_from_linear_data(..., skb->len)

au1000_probe() allocates a single 16 KiB region with dma_alloc_coherent().
The TX buffers are at offsets 0-8K and the RX buffers at 8-16K. Would an
oversized frame overwrite the neighbouring TX/RX DMA buffers? Beyond about
10 KiB, would it write past the end of the coherent allocation?

Should au1000_tx() drop frames larger than MAX_BUF_SIZE?

> @@ -1012,6 +1019,7 @@ static netdev_tx_t au1000_tx(struct sk_buff *skb, struct net_device *dev)
>  	wmb(); /* drain writebuffer */
>  	dev_kfree_skb(skb);
>  	aup->tx_head = (aup->tx_head + 1) & (NUM_TX_DMA - 1);
> +	spin_unlock_irqrestore(&aup->lock, flags);
>  	return NETDEV_TX_OK;
>  }

[Severity: Medium]

With the new spin_lock_irqsave() in au1000_tx(), dev_kfree_skb(skb) now
runs with hard IRQs disabled. dev_kfree_skb() is just consume_skb():

include/linux/skbuff.h:
#define dev_kfree_skb(a)	consume_skb(a)

include/linux/netdevice.h says:

 * It is not allowed to call kfree_skb() or consume_skb() from hardware
 * interrupt context or with hardware interrupts being disabled.
 * (in_hardirq() || irqs_disabled())

Does this mean every transmitted packet now runs its skb destructors with
IRQs off? That includes sock_wfree()/tcp_wfree(), zerocopy ubuf callbacks,
and dst and conntrack puts.

If any of those reach local_bh_enable(), lockdep_assert_irqs_enabled()
would fire. With CONFIG_TRACE_IRQFLAGS, __local_bh_enable_ip() could also
turn IRQs back on inside the aup->lock section, which would reopen the
race this patch is closing.

The data has already been copied into pDB->vaddr. Could the free move
after spin_unlock_irqrestore(), or use dev_consume_skb_any() instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027223140.3774570-1-f.fainelli%40gmail.com
