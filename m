Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93240185B48;
	Sun, 11 Oct 2026 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791705876; cv=none; b=IkRsND5agYK0SNiYcmF0MiX0T5v1GLnNbjUngsKS10hKuGlNgruOG+48fRnP7/2fL+/hb8/tK/8DbLIqVAUUuacq4B3LWHz+5HZbDRaYeu6+VpRwFEvbitS/OcHsXNPuf7wbtUVbPk9VeHEsKFv2hxckwlnaXKDeN9G0Zb3+22Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791705876; c=relaxed/simple;
	bh=3dl2088A3FSVhN92Lv3OonvssgasnxbW+zR4oicbTRU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K9XaeAnVmXdYLxFYbHY3dS5oP1064uWn+lRvHvRvgY0ZagSm5GDuWDghU6wGOjwUKq4HJrB+UjZcg8+wUAb4uZ1NrZvcMrCh43dOa1gQMcuZ3pxLdtMYdrdQZP8tQ/Ekxbz5X/gE/W7W/+eM1t4TDCEGTyaog9GNzIorzILFqM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCmVXKiU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCmVXKiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BCD1F0089B;
	Sun, 11 Oct 2026 08:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791705875;
	bh=Lti2Y8S7Hxd6PYECyIiG64uGEClN5O3X1xqGLARzapI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oCmVXKiURQ68dMVmKOFiAY13faPEJgYuFLKR/PxVqjJbgNudQoX1YyqhjNL/Km1od
	 TGsU2zsaUdMR3/Y6MmiYwTws6q80lj5mZFfZPyuUH9R0b0m1pjhraxt7aNxSDBZ3ZE
	 4m8BigL7dvd+dXrMeCBFxOni+gnnpezZhD/etYAw3upAg3n0zvp1EOPpNJ6JZLsZBH
	 w2hrXFUjKIL1KElUHBBtNiVXEyDlhjP0TgHnkYRTlyL3XTayNSoGqSUfir22dX5rvY
	 jcXkWa3CFHiBtBRqUeCAHntraXHUxr5rNs83xdfWV7dQEL1d5mvK33luw9yZEQFbOR
	 tNcQLw4bF6nBA==
Subject: Re: [PATCH net-next] net: bgmac: use the NAPI skb cache
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 08:04:34 +0000
Message-ID: <179170587420.434549.9366997254776579845@kernel.org>
In-Reply-To: <20261010070635.97759-1-rosenp@gmail.com>
References: <20261010070635.97759-1-rosenp@gmail.com>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In bgmac_dma_rx_read() (drivers/net/ethernet/broadcom/bgmac.c),
  the patch replaces build_skb() with napi_build_skb().

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but bgmac_poll()
  has no zero-budget guard.

--

net: bgmac: use the NAPI skb cache

This commit changes bgmac to allocate RX skb heads with napi_build_skb()
and to free completed TX skbs with napi_consume_skb(). The skb heads are
then recycled through the per-CPU NAPI cache instead of the slab
allocator.

> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index 3e9c57196a397..63a01accd7803 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c

[ ... ]

> @@ -466,9 +467,9 @@ static int bgmac_dma_rx_read(struct bgmac *bgmac, struct bgmac_dma_ring *ring,
>  			/* Omit CRC. */
>  			len -= ETH_FCS_LEN;
>  
> -			skb = build_skb(buf, BGMAC_RX_ALLOC_SIZE);
> +			skb = napi_build_skb(buf, BGMAC_RX_ALLOC_SIZE);

[Severity: High]
Can netpoll's zero-budget poll reach this call outside softirq context?

poll_one_napi() in net/core/netpoll.c calls napi->poll(napi, 0). A budget
of 0 means only the TX path should be cleaned. The TX side of bgmac_poll()
handles this, because napi_consume_skb() falls back to
dev_consume_skb_any() when budget is 0.

However, bgmac_poll() still calls bgmac_dma_rx_read() with weight 0. The
budget check there only runs after a descriptor has been handled:

bgmac_dma_rx_read() {
    ...
		if (handled >= weight) /* Should never be greater */
			break;
    ...
}

So one ready RX frame always reaches napi_build_skb():

netpoll_send_skb() [local_irq_save]
  __netpoll_send_skb()
    netpoll_poll_dev()
      poll_one_napi()
        bgmac_poll(napi, 0)
          bgmac_dma_rx_read(weight=0)
            napi_build_skb()
              __napi_build_skb()
                napi_skb_cache_get()

napi_skb_cache_get() modifies the per-CPU napi_alloc_cache
(nc->skb_cache[--nc->skb_count]) under local_lock_nested_bh(). On !RT
kernels, that lock is only a lockdep_assert_in_softirq() plus a lockdep
annotation.

Netpoll can be entered from hardirq context, for example by a printk
through netconsole from an IRQ handler. Suppose that hardirq interrupts a
NET_RX softirq on the same CPU while the softirq is inside
napi_skb_cache_get() or napi_skb_cache_put().

Could both contexts then take the same skb head, or corrupt
nc->skb_count?

On PREEMPT_RT, local_lock_nested_bh() is a sleeping per-CPU lock. Here it
would be taken with IRQs disabled. With lockdep enabled,
lockdep_assert_in_softirq() would also warn every time netpoll handles an
RX frame.

The old build_skb() used kmem_cache_alloc(), which is safe in this
context. Zero-budget RX could already reach napi_skb_cache_put() through
the GRO_MERGED_FREE path in gro_skb_finish(). This change makes the cache
access unconditional for every frame handled at budget 0.

Would it make sense to skip RX processing when weight is 0, either in
bgmac_poll() or at the top of bgmac_dma_rx_read()?

[ ... ]

> @@ -1153,7 +1154,7 @@ static int bgmac_poll(struct napi_struct *napi, int weight)
>  	/* Ack */
>  	bgmac_write(bgmac, BGMAC_INT_STATUS, ~0);
>  
> -	bgmac_dma_tx_free(bgmac, &bgmac->tx_ring[0]);
> +	bgmac_dma_tx_free(bgmac, &bgmac->tx_ring[0], weight);
>  	handled += bgmac_dma_rx_read(bgmac, &bgmac->rx_ring[0], weight);

[Severity: Medium]
This isn't a bug introduced by this patch, but bgmac_poll() has no guard
for a zero budget. With weight 0, bgmac_dma_rx_read() handles one RX
descriptor and returns 1. bgmac_poll() then skips the handled < weight
branch and also returns 1.

Doesn't that trigger the WARN_ONCE() in poll_one_napi()?

net/core/netpoll.c:poll_one_napi() {
    ...
	work = napi->poll(napi, 0);
	WARN_ONCE(work, "%pS exceeded budget in poll\n", napi->poll);
    ...
}

This missing guard is also what allows the napi_build_skb() issue above.
The same fix, returning before RX processing when weight is 0, would
cover both.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010070635.97759-1-rosenp%40gmail.com
