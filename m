Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA69468C3F;
	Tue, 18 Aug 2026 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051718; cv=none; b=Wfq4iwzMmJzSmh2vSFrDnxWYbTSlcHJaVUjBlc4iOnUONGxIJHIs+3zUSHwcg+zs981a771tWzxu6B8Y7GQAVebWMAOprPaZEBHgeM2GB+fH65I12+V6yotdzuEgfqlYd7CmxZzKdSHpOiJ+FUDZdhKrnHBuc7OmPxpDu2bpvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051718; c=relaxed/simple;
	bh=L/C9RVH9i3x8KmGyZZxEuhl6PkzhNNSlOt6enNmozYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/ez6UKrNEEvEb74hwgFV2paqgEEt3PlJo+m93eRZBDoEK0qzuD0Fw715VHDDYjVU7X2GLcjF7KenJGgV1TEkSNc2253N6d6ayLPGIjBqNoR3YIR2iSeUxfWHTeyEP9S3vjFZRKr+e9Djev2k0zqP/uOhlw6VXLzhuZJv+WVUxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWRavBr/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWRavBr/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FA91F000E9;
	Tue, 18 Aug 2026 11:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787051716;
	bh=hXVKKPGF88P8ypPexdppsGctIybPEejnDz0bBleBqss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XWRavBr/A805tJtlXy7Vg442dfluS9RG8tx74xzRMAe30rAwUX4iGW8gangbuh29V
	 vH6421Dni2CFTTWKEKowcXk2Q77bRb8R7nx3hW4zFJ6elroe3XHxzxJOvVqCXL8hJB
	 R5m0PMIdX7kHQsm1r3TSrKTP9kMxnJiE8JVUCjXq4NmslG9hMRxK4iwy0MRg/Lj5oI
	 kn9aR9uVygW3O5Cw3OWfIEnV7FTltpgPk26Z+GHvR87VYCbcHBN5Fbbc7D5jtyTEdP
	 Kbokdfm/+xGOS4XBiUtPaLn5USFiNaNQsaZTglE71OQ8E/64P3f2nFNudPrz76Y3E2
	 q6KcERVMVZQfQ==
Date: Tue, 18 Aug 2026 12:15:12 +0100
From: Simon Horman <horms@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v9 3/4] net: rnpgbe: Add RX packet reception
 support
Message-ID: <20260818111512.GC265046@horms.kernel.org>
References: <20260814111317.1741087-1-dong100@mucse.com>
 <20260814111317.1741087-4-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814111317.1741087-4-dong100@mucse.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814111317.1741087-2-dong100@mucse.com?part=3
---
--- Patch [3]: [PATCH net-next v9 3/4] net: rnpgbe: Add RX packet reception support ---
commit a40163a8c61d2ade85f38149bd7ae36c6f8c266b
Author: Dong Yibo <dong100@mucse.com>

net: rnpgbe: Add RX packet reception support

This adds the RX path for rnpgbe: the hardware write-back RX descriptor
format, page_pool backed RX buffers with one page per descriptor, the NAPI
poll callback, RX ring setup/teardown and RX statistics.  A per q_vector
timer retries failed page allocations by scheduling NAPI.

A few questions on the new code below.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> index 49fcbd2e37409..1d3e4078f16b1 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h

[ ... ]

> @@ -112,6 +150,18 @@ static inline u16 mucse_desc_unused(struct mucse_ring *ring)
>  	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 1;
>  }
>  
> +static inline u16 mucse_desc_unused_rx(struct mucse_ring *ring)
> +{
> +	u16 ntc = ring->next_to_clean;
> +	u16 ntu = ring->next_to_use;
> +
> +	/* Keep M_RX_BUFFER_WRITE descriptors unused so the ring is not filled
> +	 * completely. Refill is attempted once at least this many descriptors
> +	 * are available.
> +	 */
> +	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 16;
> +}

[Severity: Low]
[Finding: main-1-1]
[Sources: opus-5]
The comment in mucse_desc_unused_rx() says the reserved gap is
M_RX_BUFFER_WRITE descriptors, but the expression subtracts a literal 16.
M_RX_BUFFER_WRITE is defined independently in rnpgbe_lib.h and is what
rnpgbe_clean_rx_irq() uses as the refill threshold, and rnpgbe.h does not
include rnpgbe_lib.h, so the helper cannot reference the macro as written.

Both values are 16 today, so the accounting is consistent, but if
M_RX_BUFFER_WRITE is later changed only the refill trigger moves while the
reserved gap stays at 16.  And if the reserve were ever made smaller than
the number of posted descriptors, this u16 expression would wrap to roughly
65500 and rnpgbe_alloc_rx_buffers() would walk well past the ring.

Would it make sense to have the helper use the same constant rather than
open-coding 16?

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> index 8700c48669ecb..9199a48e75d42 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c

[ ... ]

> @@ -199,8 +201,412 @@ static bool rnpgbe_clean_tx_irq(struct mucse_q_vector *q_vector,

[ ... ]

> +static int rnpgbe_clean_rx_irq(struct mucse_q_vector *q_vector,
> +			       struct mucse_ring *rx_ring,
> +			       int budget)
> +{
> +	unsigned int max_size = SKB_WITH_OVERHEAD(PAGE_SIZE) - RNPGBE_SKB_PAD;
> +	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
> +	u16 cleaned_count = mucse_desc_unused_rx(rx_ring);
> +	unsigned int work_done = 0;
> +
> +	while (likely(work_done < budget)) {
> +		struct mucse_rx_buffer *rx_buffer;
> +		union rnpgbe_rx_desc *rx_desc;
> +		struct sk_buff *skb;
> +		unsigned int size;
> +
> +		if (cleaned_count >= M_RX_BUFFER_WRITE) {
> +			if (rnpgbe_alloc_rx_buffers(rx_ring, cleaned_count)) {
> +				mod_timer(&q_vector->rx_alloc_timer,
> +					  jiffies + msecs_to_jiffies(500));
> +				cleaned_count = mucse_desc_unused_rx(rx_ring);
> +			} else {
> +				cleaned_count = 0;
> +			}
> +		}

[ ... ]

> @@ -893,9 +1390,12 @@ bool rnpgbe_down(struct mucse *mucse)
>  		return false;
>  
>  	netif_tx_disable(netdev);
> -	rnpgbe_napi_disable_all(mucse);
> +	rnpgbe_cancel_rx_retry_timers(mucse);
>  	rnpgbe_irq_disable(mucse);
> +	rnpgbe_stop_all_rx_rings(mucse);
> +	rnpgbe_napi_disable_all(mucse);
>  	rnpgbe_clean_all_tx_rings(mucse);
> +	rnpgbe_clean_all_rx_rings(mucse);
>  
>  	return true;
>  }

[Severity: Medium]
[Finding: gpt-5-6-sol-5-12]
[Sources: gpt-5-6-sol, opus-5]
Can the rx_alloc_timer still be armed after rnpgbe_cancel_rx_retry_timers()
returns here?  The timers are cancelled before rnpgbe_napi_disable_all(),
but NAPI is the only context that arms them:

rnpgbe_clean_rx_irq()
	if (rnpgbe_alloc_rx_buffers(rx_ring, cleaned_count)) {
		mod_timer(&q_vector->rx_alloc_timer,
			  jiffies + msecs_to_jiffies(500));

timer_delete_sync() only guarantees the timer is neither pending nor running
when it returns, so a poll still in flight on another CPU can re-arm it:

CPU0					CPU1 (NAPI softirq)
rnpgbe_down()
  rnpgbe_cancel_rx_retry_timers()
    timer_delete_sync()
					rnpgbe_clean_rx_irq()
					  mod_timer(&q_vector->rx_alloc_timer)
  rnpgbe_napi_disable_all()
  rnpgbe_clean_all_rx_rings()

rnpgbe_close() then calls rnpgbe_free_all_rx_resources(), which vfree()s
rx_buffer_info, dma_free_coherent()s the descriptor ring and calls
page_pool_destroy(), while that timer is still pending.

Today the damage looks bounded: rnpgbe_rx_alloc_retry() only calls
napi_schedule(), rnpgbe_free_q_vector() does its own timer_delete_sync()
before kfree(q_vector), and after napi_disable() napi_schedule_prep() just
sets NAPIF_STATE_MISSED, which produces one spurious poll after the next
napi_enable().  That still leaves a timer armed over freed ring state, and
it contradicts the commit message wording that the timer "is cancelled
before RX cleanup and q_vector teardown".

Would cancelling the timers after rnpgbe_napi_disable_all() (or cancelling
them a second time there) close this window?

[ ... ]

> @@ -1321,5 +1823,251 @@ void rnpgbe_get_stats64(struct net_device *netdev,

[ ... ]

> +static int mucse_alloc_page_pool(struct mucse_ring *rx_ring)
> +{
> +	int ret = 0;
> +
> +	struct page_pool_params pp_params = {
> +		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> +		.order = 0,
> +		.pool_size = rx_ring->count,
> +		.nid = dev_to_node(rx_ring->dev),
> +		.dev = rx_ring->dev,
> +		.dma_dir = DMA_FROM_DEVICE,
> +		.offset = 0,
> +		.max_len = PAGE_SIZE,
> +	};
> +
> +	rx_ring->page_pool = page_pool_create(&pp_params);

[Severity: Low]
[Finding: gpt-5-6-sol-2-7]
[Sources: gpt-5-6-sol]
This isn't a bug, but was leaving .netdev, .queue_idx and .napi unset
intentional?  All three are known at this point: rx_ring->netdev,
rx_ring->queue_index and &rx_ring->q_vector->napi.

page_pool_list() in net/core/page_pool_user.c only links a pool into the
netdev list when slow.netdev is set:

	if (pool->slow.netdev) {
		hlist_add_head(&pool->user.list,
			       &pool->slow.netdev->page_pools);

so these per-ring pools are not visible per interface or per queue through
the netdev page-pool netlink interface.  With .napi unset, pages returned
via skb_mark_for_recycle() also cannot use the NAPI-local recycle fast path
and always go through the ptr_ring.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
> index 0ac4514b07c74..f3f45281d86e4 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
> @@ -9,12 +9,28 @@ struct mucse_hw;
>  struct mucse_ring;
>  
>  #define RING_OFFSET(n)            (0x1000 + 0x100 * (n))
> +#define RNPGBE_RX_START           0x10
>  #define RNPGBE_TX_START           0x18
>  #define RNPGBE_DMA_INT_MASK       0x24
>  #define TX_INT_MASK               BIT(1)
>  #define RX_INT_MASK               BIT(0)
>  #define INT_VALID                 (BIT(16) | BIT(17))
>  #define RNPGBE_DMA_INT_TRIG       0x2c /* lost-interrupt recovery trigger */
> +#define RNPGBE_RX_BASE_ADDR_HI    0x30
> +#define RNPGBE_RX_BASE_ADDR_LO    0x34
> +#define RNPGBE_RX_LEN             0x38
> +#define RNPGBE_RX_HEAD            0x3c
> +#define RNPGBE_RX_TAIL            0x40
> +#define M_DEFAULT_RX_FETCH        0x100020
> +#define RNPGBE_RX_FETCH           0x44
> +#define M_DEFAULT_INT_TIMER_R     30
> +#define RNPGBE_RX_INT_TIMER       0x48
> +#define M_DEFAULT_RX_INT_PKTCNT   64
> +#define RNPGBE_RX_INT_PKTCNT      0x4c
> +#define RNPGBE_RX_ARB_DEF_LVL     0x50
      ^^^^

Simon says: I think the concerns below are highly subjective.
            I think you can use your own best judgement here.

[Severity: Low]
[Finding: main-1-2]
[Sources: opus-5]
RNPGBE_RX_ARB_DEF_LVL has no users anywhere in the driver, while every
other RX register macro added here is programmed by
rnpgbe_configure_rx_ring().  Is the RX arbitration default level a
configuration step that was missed, or can this define be dropped?

Related, rnpgbe_clean_rx_ring() is declared in this header but its only
caller is rnpgbe_clean_all_rx_rings() in the same file.  The TX side is the
other way round: rnpgbe_clean_tx_ring() is static and only the all-rings
wrapper is exported.  Should rnpgbe_clean_rx_ring() be static as well?

> +#define RNPGBE_RX_TIMEOUT_TH      0x54
> +#define M_DEFAULT_SG              96 /* unit 16b, 1536 bytes */
> +#define RNPGBE_RX_SG_LEN          0x58
>  #define RNPGBE_TX_BASE_ADDR_HI    0x60
>  #define RNPGBE_TX_BASE_ADDR_LO    0x64
>  #define RNPGBE_TX_LEN             0x68
> @@ -37,13 +53,15 @@ struct mucse_ring;
>  /* 2 desc gap to keep tail from touching head */
>  /* 1 desc for context descriptor */
>  #define RESV_DESC_NEEDED          3
> +#define RNPGBE_SKB_PAD            (NET_SKB_PAD + NET_IP_ALIGN)
> +#define M_RX_BUFFER_WRITE         16
> +

[ ... ]

> @@ -54,10 +72,15 @@ void rnpgbe_irq_disable(struct mucse *mucse);
>  bool rnpgbe_down(struct mucse *mucse);
>  void rnpgbe_up_complete(struct mucse *mucse);
>  void rnpgbe_configure_tx(struct mucse *mucse);
> +void rnpgbe_configure_rx(struct mucse *mucse);
> +void rnpgbe_clean_all_tx_rings(struct mucse *mucse);
>  int rnpgbe_setup_all_tx_resources(struct mucse *mucse);
>  void rnpgbe_free_all_tx_resources(struct mucse *mucse);
>  netdev_tx_t rnpgbe_xmit_frame_ring(struct sk_buff *skb,
>  				   struct mucse_ring *tx_ring);
>  void rnpgbe_get_stats64(struct net_device *netdev,
>  			struct rtnl_link_stats64 *stats);
> +void rnpgbe_clean_rx_ring(struct mucse_ring *rx_ring);
> +int rnpgbe_setup_all_rx_resources(struct mucse *mucse);
> +void rnpgbe_free_all_rx_resources(struct mucse *mucse);
>  #endif
