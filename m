Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4AD43B4AA;
	Fri,  4 Sep 2026 21:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559039; cv=none; b=W9W4mV2dgopfMHDPEscNM99mssQhkAIimgZaLx2k/GeI81M3WLfNdXckS1vGPw8tIn4OS/RUr7Yz0dvYwVI/jzqOU+TaknTWWansHQTdVMGWRRDqHXhXoGgpQko2oKIt/CHuUOczSCoG2xCtdFLNYaVG74moBYeNJ0Rurw+dzEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559039; c=relaxed/simple;
	bh=QMkuBtZB/lF03g923HwbAD3WIEG9MKo80TTzLRwvKz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngnzucOZCHti8aI0Iy7ZoNRsIQhOQqyHx1x0Xf2Ti7GUhKmlG9TkBULTioe+68zlRSQRPFtJEJ6RMBGYeDZ/tt/PJUICYqkWlUB1KX7qX6KhMInG0n7B3Q9aTTepKHotiuAKJzCB9XhDGAfQex1zBLh0483L9wQKGbVY7PF+Eiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R80hHjfY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R80hHjfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81D81F00A3E;
	Fri,  4 Sep 2026 21:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788559037;
	bh=slQCtWFLnKBQcFVpWOz+ZzrFdJ7NGvf50j0seRE3/K8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R80hHjfYSHhfN5BnHtidApTgAeUYUm4sLgsI7YMqa7My8j15zOKGZ8maHcPLAVjuu
	 zw4BAzwHrJVooTgLtv9pqzll1uEo3s/2SEICndm3G0x3oRNcXrgRuK45fnykRQtRey
	 NUO6pWL0Os1LPb7FkDbMYkskUhI3NtF4cxP+pEwYiLIisMNibPl5L44gqL8bdS38zy
	 FiQcMnE/g+rPiPw/chpaxBKOpNE2E4UZ7eSbS3EfSsiKD7Gl2cdkxnlVqJaet8wz+O
	 R5yfY2L49fONmwDkFsRvcRbFVHIgp6wRGKEypg7vMQNSq010UtAuvaEIOpw5X1bwxx
	 v4g8bj4RxKATQ==
From: Jakub Kicinski <kuba@kernel.org>
To: dong100@mucse.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaojun@mucse.com
Subject: Re: [PATCH net-next v10 3/5] net: rnpgbe: Add RX packet reception support
Date: Fri,  4 Sep 2026 14:57:15 -0700
Message-ID: <20260904215715.3999973-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <91082393C60E8281+20260831073608.401988-4-dong100@mucse.com>
References: <91082393C60E8281+20260831073608.401988-4-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: rnpgbe: Add RX packet reception support

This adds the RX path for rnpgbe: the RX descriptor union, page_pool
backed RX buffers, the NAPI poll callback, RX ring setup/teardown and RX
statistics. It also adds a per-q_vector timer that retries failed page
allocations by scheduling NAPI, and RX DMA quiesce handling on teardown.

A few questions about the new RX code below.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> index ff81d222edd3..346e9a1cca8a 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c

[ ... ]

> @@ -198,15 +200,419 @@ static bool rnpgbe_clean_tx_irq(struct mucse_q_vector *q_vector,
>  	return !!budget;
>  }
>  

[ ... ]

> +/**
> + * rnpgbe_rx_alloc_retry - Retry RX buffer allocation
> + * @timer: RX allocation retry timer
> + *
> + * Schedules NAPI after RX buffer allocation fails during polling or
> + * initial ring configuration.
> + **/
> +static void rnpgbe_rx_alloc_retry(struct timer_list *timer)
> +{
> +	struct mucse_q_vector *q_vector =
> +		timer_container_of(q_vector, timer, rx_alloc_timer);
> +
> +	napi_schedule(&q_vector->napi);
> +}

[Severity: Medium]
Can this retry be silently lost when the timer is armed from
rnpgbe_configure_rx_ring()?

At that point NAPI has not been enabled yet.  The open path is:

rnpgbe_open()
  rnpgbe_configure()
    rnpgbe_configure_rx()
      rnpgbe_configure_rx_ring()
        if (rnpgbe_alloc_rx_buffers(ring, mucse_desc_unused_rx(ring))) {
                mod_timer(&ring->q_vector->rx_alloc_timer,
                          jiffies + msecs_to_jiffies(500));
        }
  rnpgbe_up_complete()
    rnpgbe_napi_enable_all()
    clear_bit(__MUCSE_DOWN, &mucse->state);

netif_napi_add_weight() leaves NAPI_STATE_SCHED and NAPI_STATE_NPSVC set
until napi_enable_locked() runs, so napi_schedule_prep() returns false and
only sets NAPIF_STATE_MISSED, which napi_enable_locked() does not act on.

rnpgbe_rx_alloc_retry() ignores the return value of napi_schedule() and does
not re-arm, so if the timer expires in the window before
rnpgbe_napi_enable_all() the retry is dropped.  If the initial refill failed
for every descriptor, no descriptors are posted, no RX interrupt can arrive
and the ring stays empty until an administrative down/up.

Would arming the timer only after NAPI is enabled, or re-arming from the
callback when napi_schedule() returns false, be more robust?

[ ... ]

> +static int rnpgbe_clean_rx_irq(struct mucse_q_vector *q_vector,
> +			       struct mucse_ring *rx_ring,
> +			       int budget)
> +{
> +	unsigned int max_size = SKB_WITH_OVERHEAD(PAGE_SIZE) - RNPGBE_SKB_PAD;

[ ... ]

> +		dma_rmb();
> +		/* Hardware enforces: minimum 33-bytes descriptor(no 1-13 byte
> +		 * size), multi-descriptors only for jumbo frames > 1536 bytes
> +		 * (controlled by M_DEFAULT_SG=96, each descriptor no more than
> +		 * 1536 bytes). Small packets use single descriptor.
> +		 */
> +		size = le16_to_cpu(rx_desc->wb.len);

[ ... ]

> +		if (unlikely(!size || size > max_size)) {

[Severity: Medium]
Is there anything that prevents a first descriptor with size in the 1..13
range from starting a fragmented packet here?

The only length check is the one above, which accepts any size from 1 to
max_size.  If such a short descriptor is non-EOP, rnpgbe_is_non_eop() parks
the skb and the following descriptors are attached with skb_add_rx_frag(),
leaving an skb whose linear head is shorter than ETH_HLEN while data_len is
non-zero.

rnpgbe_cleanup_headers() only calls eth_skb_pad(), which does nothing once
skb->len is already at least ETH_ZLEN, so the short head survives.
rnpgbe_process_skb_fields() then does:

	skb->protocol = eth_type_trans(skb, dev);

and eth_type_trans() -> eth_skb_pull_mac() -> skb_pull_inline(ETH_HLEN)
reaches the __skb_pull() check:

include/linux/skbuff.h:__skb_pull() {
	...
	BUG_ON(skb->len < skb->data_len);
	...
}

The comment above states the hardware enforces a 33-byte minimum, but the
code does not enforce it.  Would rejecting descriptors that cannot supply an
ETH_HLEN linear head, or a pskb_may_pull(skb, ETH_HLEN) before
eth_type_trans(), be worth adding?

[ ... ]

> @@ -225,11 +632,27 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
>  	if (unlikely(!budget))
>  		return 0;
>  
> +	if (q_vector->rx.count > 1)
> +		per_ring_budget = max(budget / q_vector->rx.count, 1);
> +	else
> +		per_ring_budget = budget;
> +
> +	mucse_for_each_ring(ring, q_vector->rx) {
> +		int cleaned = 0;
> +
> +		cleaned = rnpgbe_clean_rx_irq(q_vector, ring, per_ring_budget);
> +		work_done += cleaned;
> +		if (cleaned >= per_ring_budget)
> +			clean_complete = false;
> +	}
> +
>  	if (!clean_complete)
>  		return budget;
>  
> -	if (likely(napi_complete_done(napi, work_done)))
> -		rnpgbe_irq_enable_queues(q_vector);
> +	if (likely(napi_complete_done(napi, work_done))) {
> +		if (!test_bit(__MUCSE_DOWN, &q_vector->mucse->state))
> +			rnpgbe_irq_enable_queues(q_vector);
> +	}

[Severity: Medium]
Does this __MUCSE_DOWN test actually close the window the commit message
describes with "Do not re-enable queue interrupts while the device is
down"?

napi_complete_done() clears NAPI_STATE_SCHED before the test_bit() and the
MMIO unmask run, and napi_disable_locked() only waits for SCHED/NPSVC to
clear:

net/core/dev.c:napi_disable_locked() {
	...
	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		usleep_range(20, 200);
		val = READ_ONCE(n->state);
	}
	...
}

So this interleaving looks possible:

CPU0 rnpgbe_poll()
	napi_complete_done()		/* SCHED released */
	test_bit(__MUCSE_DOWN) == 0

CPU1 rnpgbe_down()
	test_and_set_bit(__MUCSE_DOWN, &mucse->state);
	rnpgbe_napi_disable_all();
	rnpgbe_irq_disable();		/* includes synchronize_irq() */
	rnpgbe_stop_all_rx_rings();
	rnpgbe_clean_all_rx_rings();

CPU0 (continues)
	rnpgbe_irq_enable_queues(q_vector);	/* unmask + trig write */

After rnpgbe_down() returns the queue interrupt would be left unmasked and
explicitly re-triggered, after RX DMA was quiesced and the RX buffers were
released, and just before rnpgbe_free_irq().

Would unmasking before napi_complete_done() releases SCHED, or re-masking
after rnpgbe_napi_disable_all() in rnpgbe_down(), give the guarantee the
changelog claims?

[ ... ]
