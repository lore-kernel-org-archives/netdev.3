Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BBC3264E7;
	Tue,  8 Sep 2026 03:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788838979; cv=none; b=qS3CjVYLOP32hSYfl/CUs9UxEJX0Z6HWFjPQkxtJw3+kZ1Cb4NpwpbhMzrlmq1oirTTONxe9SPkxXyY2GQIn/2zbVycNyAAYP651KQzjUXabLcxIpWxE9S8dWsleQHxuHwQbJXQPEvQYSag9h773AOoeCuD6ksyxhOaPjOJFE8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788838979; c=relaxed/simple;
	bh=GuZ3asALIGXotebjz2TqXZUlAY3xyTEPv5q56fc170E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwEvqkamuEZjdtKScgSGbuLZ783AdUGDUxHwN5rgkjRwctpTnn3Ql9KHO2gAn4AEnK04qchGHQ41zkWnAQ5nL9RFto0HSIBIIbCesCqWzwZuIwFebYbc1/GxuhTlE/XOKskCTUu0GbF/iYGwwwfxWmlCyJN0sN/kYWTQeeCV6Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz20t1788838888t55ca07c6
X-QQ-Originating-IP: hPZ5plRFpxpmTrk4KZ7xPuViFhDX+svB7IORKm2s/sM=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Sep 2026 11:41:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5007545140963111567
EX-QQ-RecipientCnt: 10
Date: Tue, 8 Sep 2026 11:41:26 +0800
From: Yibo Dong <dong100@mucse.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v10 3/5] net: rnpgbe: Add RX packet reception
 support
Message-ID: <AB03E02EF83F117B+20260908034126.GB507605@nic-Precision-5820-Tower>
References: <91082393C60E8281+20260831073608.401988-4-dong100@mucse.com>
 <20260904215715.3999973-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904215715.3999973-1-kuba@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: Mf2c2cXG8XEiaLi/YTWrj9H+3YgI0yKc5Jj4pPilZu3t5P5sT7Yf+JA6
	60GfReiK9BX2bHXVIx5k6TwB/dY5T1dB9NKidUB7ZK7R5JG0E3MVJ1Pms2vKvnbvkBuIPp4
	693oevf4ZBW8HTheDWKUTQ2W7uTq9XAG0STfBbGfPzyg2KS42bagDPYdHeleiB05jCflgw7
	N2ECcWx6MONjURC/hCI4wICUrtEpdJ8kd5onrDLDmdAGrjRffkM5QBMr0XpxvLYjHitiVq/
	qXHwWEt0fGiIoOcRa+QBGzYXvZQkBtJTVz3FwCvc9NGohuOsy7kWvAg8+zXevj3nG2EuCo9
	baIFduPRPa6Cz+HfAqhaAbtGzvHlhcrQAj69R4C1SxDT+1ccZa8NaH/0Rhv9+kAuDj/S1Ji
	LWremIZjFSuxYwNgIdsTQgLaXaoHQFEDeAO2s9ThDqDE9ogFyTNjRB8ECtjlTaS4S1yVc50
	TM7OQsFCSaumnsE1hf2JeYGO6he7hfx9sySQbQ30ga+1JEiLG391PLQ37xRi7asJJl7WUO2
	6LlT48KIHLCK0h5quivU3BC7vH77cQlUuwu+mrlk1lxmFmlIVSpGwx8Sp6g8svGrbLf85rb
	DGqnvmzjqSbXZQuMXLg+N3kAERRd9e9TTH/z2QiYNwkReVCTkseCZOpgj5p5ImCeFGuvYT5
	Mc5EFxWdLhBMGMkztM51SN5syfZ9zZHRCNiEfgbTrA9rfOqg1Igs3hoRIkZef6M00iA2DNN
	BQ1+lx6sF5a2faL5I1se1pfAhjxVe3bQ3tmwzxUBW5Zw2wNrxBSo9oXt1/UUDOFJf+8Fqzw
	J+3/PMdQ8KNR6kzYIcETH8GNEYiLxh+5dg+WzpBg4qkHCNZIKgLNGfmVC+pK6xJzMPPN1Aq
	GOri4ZFgfMMPWuOOWY5yk7eNqdMfzyOHzVCu3bbvmZ2HUJ09ClqwKrpPiiiF4ElQaovUztO
	DrYjgs72fQF4X5qZTNQljzgpDxwLmCuup+OYfD6HS3tTo7ZaVqa8EQkHEE+nqruAFyI8OUA
	bb7IXsoKcByWP4tDYCW93hGo2UuIffcS7tvVQyhhO8OvJqRm0a
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

On Fri, Sep 04, 2026 at 02:57:15PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: rnpgbe: Add RX packet reception support
> 
> This adds the RX path for rnpgbe: the RX descriptor union, page_pool
> backed RX buffers, the NAPI poll callback, RX ring setup/teardown and RX
> statistics. It also adds a per-q_vector timer that retries failed page
> allocations by scheduling NAPI, and RX DMA quiesce handling on teardown.
> 
> A few questions about the new RX code below.
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> > index ff81d222edd3..346e9a1cca8a 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> 
> [ ... ]
> 
> > @@ -198,15 +200,419 @@ static bool rnpgbe_clean_tx_irq(struct mucse_q_vector *q_vector,
> >  	return !!budget;
> >  }
> >  
> 
> [ ... ]
> 
> > +/**
> > + * rnpgbe_rx_alloc_retry - Retry RX buffer allocation
> > + * @timer: RX allocation retry timer
> > + *
> > + * Schedules NAPI after RX buffer allocation fails during polling or
> > + * initial ring configuration.
> > + **/
> > +static void rnpgbe_rx_alloc_retry(struct timer_list *timer)
> > +{
> > +	struct mucse_q_vector *q_vector =
> > +		timer_container_of(q_vector, timer, rx_alloc_timer);
> > +
> > +	napi_schedule(&q_vector->napi);
> > +}
> 
> [Severity: Medium]
> Can this retry be silently lost when the timer is armed from
> rnpgbe_configure_rx_ring()?
> 
> At that point NAPI has not been enabled yet.  The open path is:
> 
> rnpgbe_open()
>   rnpgbe_configure()
>     rnpgbe_configure_rx()
>       rnpgbe_configure_rx_ring()
>         if (rnpgbe_alloc_rx_buffers(ring, mucse_desc_unused_rx(ring))) {
>                 mod_timer(&ring->q_vector->rx_alloc_timer,
>                           jiffies + msecs_to_jiffies(500));
>         }
>   rnpgbe_up_complete()
>     rnpgbe_napi_enable_all()
>     clear_bit(__MUCSE_DOWN, &mucse->state);
> 
> netif_napi_add_weight() leaves NAPI_STATE_SCHED and NAPI_STATE_NPSVC set
> until napi_enable_locked() runs, so napi_schedule_prep() returns false and
> only sets NAPIF_STATE_MISSED, which napi_enable_locked() does not act on.
> 
> rnpgbe_rx_alloc_retry() ignores the return value of napi_schedule() and does
> not re-arm, so if the timer expires in the window before
> rnpgbe_napi_enable_all() the retry is dropped.  If the initial refill failed
> for every descriptor, no descriptors are posted, no RX interrupt can arrive
> and the ring stays empty until an administrative down/up.
> 
> Would arming the timer only after NAPI is enabled, or re-arming from the
> callback when napi_schedule() returns false, be more robust?
> 
> [ ... ]
> 
Got it, I will move mod_timer after NAPI is enabled.
> > +static int rnpgbe_clean_rx_irq(struct mucse_q_vector *q_vector,
> > +			       struct mucse_ring *rx_ring,
> > +			       int budget)
> > +{
> > +	unsigned int max_size = SKB_WITH_OVERHEAD(PAGE_SIZE) - RNPGBE_SKB_PAD;
> 
> [ ... ]
> 
> > +		dma_rmb();
> > +		/* Hardware enforces: minimum 33-bytes descriptor(no 1-13 byte
> > +		 * size), multi-descriptors only for jumbo frames > 1536 bytes
> > +		 * (controlled by M_DEFAULT_SG=96, each descriptor no more than
> > +		 * 1536 bytes). Small packets use single descriptor.
> > +		 */
> > +		size = le16_to_cpu(rx_desc->wb.len);
> 
> [ ... ]
> 
> > +		if (unlikely(!size || size > max_size)) {
> 
> [Severity: Medium]
> Is there anything that prevents a first descriptor with size in the 1..13
> range from starting a fragmented packet here?
> 
> The only length check is the one above, which accepts any size from 1 to
> max_size.  If such a short descriptor is non-EOP, rnpgbe_is_non_eop() parks
> the skb and the following descriptors are attached with skb_add_rx_frag(),
> leaving an skb whose linear head is shorter than ETH_HLEN while data_len is
> non-zero.
> 
> rnpgbe_cleanup_headers() only calls eth_skb_pad(), which does nothing once
> skb->len is already at least ETH_ZLEN, so the short head survives.
> rnpgbe_process_skb_fields() then does:
> 
> 	skb->protocol = eth_type_trans(skb, dev);
> 
> and eth_type_trans() -> eth_skb_pull_mac() -> skb_pull_inline(ETH_HLEN)
> reaches the __skb_pull() check:
> 
> include/linux/skbuff.h:__skb_pull() {
> 	...
> 	BUG_ON(skb->len < skb->data_len);
> 	...
> }
> 
> The comment above states the hardware enforces a 33-byte minimum, but the
> code does not enforce it.  Would rejecting descriptors that cannot supply an
> ETH_HLEN linear head, or a pskb_may_pull(skb, ETH_HLEN) before
> eth_type_trans(), be worth adding?
The RX descriptor write-back format guarantees that each descriptor is at
least 33 bytes, so the first descriptor always contains the Ethernet
header, including for multi-descriptor packets.
Would it be acceptable to rely on this hardware invariant rather than add
an additional defensive length check before eth_type_trans()?
> 
> [ ... ]
> 
> > @@ -225,11 +632,27 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)
> >  	if (unlikely(!budget))
> >  		return 0;
> >  
> > +	if (q_vector->rx.count > 1)
> > +		per_ring_budget = max(budget / q_vector->rx.count, 1);
> > +	else
> > +		per_ring_budget = budget;
> > +
> > +	mucse_for_each_ring(ring, q_vector->rx) {
> > +		int cleaned = 0;
> > +
> > +		cleaned = rnpgbe_clean_rx_irq(q_vector, ring, per_ring_budget);
> > +		work_done += cleaned;
> > +		if (cleaned >= per_ring_budget)
> > +			clean_complete = false;
> > +	}
> > +
> >  	if (!clean_complete)
> >  		return budget;
> >  
> > -	if (likely(napi_complete_done(napi, work_done)))
> > -		rnpgbe_irq_enable_queues(q_vector);
> > +	if (likely(napi_complete_done(napi, work_done))) {
> > +		if (!test_bit(__MUCSE_DOWN, &q_vector->mucse->state))
> > +			rnpgbe_irq_enable_queues(q_vector);
> > +	}
> 
> [Severity: Medium]
> Does this __MUCSE_DOWN test actually close the window the commit message
> describes with "Do not re-enable queue interrupts while the device is
> down"?
> 
> napi_complete_done() clears NAPI_STATE_SCHED before the test_bit() and the
> MMIO unmask run, and napi_disable_locked() only waits for SCHED/NPSVC to
> clear:
> 
> net/core/dev.c:napi_disable_locked() {
> 	...
> 	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
> 		usleep_range(20, 200);
> 		val = READ_ONCE(n->state);
> 	}
> 	...
> }
> 
> So this interleaving looks possible:
> 
> CPU0 rnpgbe_poll()
> 	napi_complete_done()		/* SCHED released */
> 	test_bit(__MUCSE_DOWN) == 0
> 
> CPU1 rnpgbe_down()
> 	test_and_set_bit(__MUCSE_DOWN, &mucse->state);
> 	rnpgbe_napi_disable_all();
> 	rnpgbe_irq_disable();		/* includes synchronize_irq() */
> 	rnpgbe_stop_all_rx_rings();
> 	rnpgbe_clean_all_rx_rings();
> 
> CPU0 (continues)
> 	rnpgbe_irq_enable_queues(q_vector);	/* unmask + trig write */
> 
> After rnpgbe_down() returns the queue interrupt would be left unmasked and
> explicitly re-triggered, after RX DMA was quiesced and the RX buffers were
> released, and just before rnpgbe_free_irq().
> 
> Would unmasking before napi_complete_done() releases SCHED, or re-masking
> after rnpgbe_napi_disable_all() in rnpgbe_down(), give the guarantee the
> changelog claims?
> 
> [ ... ]
> 
I plan to keep the normal poll path unchanged and fix this in the down path:

        rnpgbe_irq_disable(mucse);
        rnpgbe_napi_disable_all(mucse);
        synchronize_net();
        rnpgbe_irq_disable(mucse);

The first mask prevents new hard IRQs from scheduling NAPI and
synchronizes any running IRQ handlers. After NAPI is disabled,
synchronize_net() waits for an in-flight NAPI poll tail which may already
have cleared NAPI_STATE_SCHED but has not yet returned. The final mask is
therefore not subject to a later rnpgbe_irq_enable_queues() write.
Would this teardown ordering be an acceptable way to close the race while
keeping the normal RX/TX poll path unchanged?

Thanks for your feedback.
