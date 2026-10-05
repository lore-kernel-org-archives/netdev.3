Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C0C31ED93;
	Mon,  5 Oct 2026 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791185769; cv=none; b=ALuiDKGyFPtwzmMS6sEGUiwvA+1n07EF7RQHtg/Njg586anH+bA7w5TpprBUaZtaRTO/p4cK28C4jkJ0hZBbUh30F/Mi019E6/hSl4DS5gtlfiI7RWCHHSphcXZkNV7kJVbHNzs9PWPIZqUhumJfUheMn2gjOQivFMvbb9ZGDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791185769; c=relaxed/simple;
	bh=JCVGQQdnmkHoqgQOSMwWaUmqXANhHJt2WQb9azbipkg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ILg4UpIesUgGAkgzFsLUfw9wZEbGVHAdUcfc1nprIuDCnWX1cRrp6GVDsvLR0HxsnWC1mkYQ5Ub5gevfQ6ON0AjVxLxmRxFVrFvgCWhGBz7fQfWUBquFSA0nSVoG47PWwcmMtFGoMkibBrLuHFEILwkjVKu1Qsi7HTkKRecNhMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQq5nacQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQq5nacQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607A31F00893;
	Mon,  5 Oct 2026 07:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791185768;
	bh=pt67PtD4kJWXnEDfHbh8SqE3iwosiaaE8X5WICH9Wz0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BQq5nacQe2dBwcPFuKd6Mx8sVH+OzHhWpl2MzTwrtJN8XKPn8LIWuEEZq9vgPYoJD
	 RV8nTVyezt18rIxuudh3bvjHEeipo5PzV1B7BtJ6XkSqnKMXeXqMxnOHpanT/eT5NS
	 7Uesrr3IY14arnFXGkVupyUJCUEjCKB6i+JtLisEEHuEPkldm3MJsdfNcPY55FePa8
	 K7VjVcNZ6bh7t+YarpGEbpJyY665XzxHvyhBDpW45QBpfe7utHyJo6RiGy2pTfbya5
	 5YvhuwvYvmhgkTXvkEkFp/vzlgojrCQ4VjNdpmQ4NqOG7NANfahgzoGKpVS0RkKRYb
	 aVcDnQjFMH3pw==
Subject:
 Re: [PATCH net-next v15 3/5] net: rnpgbe: Add basic RX data path support
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Mon, 05 Oct 2026 07:36:06 +0000
Message-ID: <179118576694.434549.7190376568705891037@kernel.org>
In-Reply-To: <9C74BB4B9911EFB8+20261004065920.225077-1-dong100@mucse.com>
References: <9C74BB4B9911EFB8+20261004065920.225077-1-dong100@mucse.com>
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

- [Low] The RX drop state machine in `rnpgbe_clean_rx_irq()` keeps only a
  boolean `drop_status`, not the reason a drop is in progress.
- [Low] `rnpgbe_poll()` calls `rnpgbe_rx_refill_pending(q_vector)` after
  `napi_complete_done()` has returned true.

--

net: rnpgbe: Add basic RX data path support

This commit adds the RX DMA data path for the rnpgbe driver. RX buffers
come from page_pool with one page per descriptor, and the commit adds a
NAPI poll callback, RX ring setup/teardown and RX statistics. A per
q_vector timer retries failed page allocations by scheduling NAPI, and an
RX DMA quiesce timeout is treated as a terminal AXI fault.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> index 21cd578f75323..16982eb27aeb3 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c

[ ... ]

> +static bool rnpgbe_is_non_eop(struct mucse_ring *rx_ring,
> +			      union rnpgbe_rx_desc *rx_desc,
> +			      struct sk_buff *skb)
> +{

[ ... ]

> +	if (skb_shinfo(skb)->nr_frags < MAX_SKB_FRAGS) {
> +		/* place skb in next buffer to be received */
> +		rx_ring->rx_buffer_info[ntc].skb = skb;
> +	} else {
> +		atomic64_inc(&rx_ring->stats->dropped);
> +		rx_ring->drop_bytes = skb->len;
> +		/* too much frags, force free */
> +		dev_kfree_skb_any(skb);
> +		rx_ring->drop_status = true;
> +	}

[ ... ]

> +static int rnpgbe_clean_rx_irq(struct mucse_q_vector *q_vector,
> +			       struct mucse_ring *rx_ring,
> +			       int budget)
> +{

[ ... ]

> +		if (unlikely(!size || size > RNPGBE_RX_DESC_DATA_LEN)) {
> +			struct mucse_rx_buffer *err_rx_buffer;
> +			bool dropping = rx_ring->drop_status;
> +			u16 idx = rx_ring->next_to_clean;
> +
> +			cleaned_count++;
> +			/* Count one length error for the complete packet. */
> +			if (!dropping)
> +				total_rx_length_errors++;
> +			rx_ring->drop_bytes = 0;

[Severity: Low]
Can this branch undercount rx_length_errors?

drop_status only records that a drop is in progress, not why. Two paths
start a drop without counting a length error.

The first is the skb build failure on a non-EOP descriptor, later in
rnpgbe_clean_rx_irq():

    if (!skb) {
        cleaned_count++;
        rx_ring->drop_bytes = size;
        atomic64_inc(&rx_ring->stats->dropped);
        ...
        } else {
            rx_ring->drop_status = true;
        }

The second is the MAX_SKB_FRAGS case in rnpgbe_is_non_eop() above.

Suppose a later descriptor of the same packet reports a length of 0 or
more than RNPGBE_RX_DESC_DATA_LEN. This branch sees dropping == true and
skips total_rx_length_errors++. It also clears drop_bytes, so the
drop_status branch does not account the packet at EOP.

As a result the packet is counted only in rx_dropped. It never shows up
in rx_errors or rx_length_errors, which goes against the "Count one length
error for the complete packet" comment.

Could the ring track the reason for the drop, for example with a separate
"length error already counted" state, instead of a single bool?

[ ... ]

> @@ -201,11 +653,29 @@ static int rnpgbe_poll(struct napi_struct *napi, int budget)

[ ... ]

>  	if (!clean_complete)
>  		return budget;
>  
> -	if (likely(napi_complete_done(napi, work_done)))
> +	if (likely(napi_complete_done(napi, work_done))) {
> +		if (rnpgbe_rx_refill_pending(q_vector))
> +			mod_timer(&q_vector->rx_alloc_timer,
> +				  jiffies + msecs_to_jiffies(500));
>  		rnpgbe_irq_enable_queues(q_vector);
> +	}

[Severity: Low]
Is it safe for rnpgbe_poll() to read the ring indices after
napi_complete_done() has returned true?

Once NAPI_STATE_SCHED is cleared, this context no longer owns the NAPI
instance. rx_alloc_timer can still be pending, either from an earlier
poll or from rnpgbe_schedule_rx_retry() in rnpgbe_up_complete(). If it
fires on another CPU in this window:

CPU0                       CPU1
rnpgbe_poll()
  napi_complete_done()
                           rnpgbe_rx_alloc_retry()
                             napi_schedule()
                           rnpgbe_poll()
                             rnpgbe_clean_rx_irq()
                               writes next_to_clean
                               rnpgbe_alloc_rx_buffers()
                                 writes next_to_use
  rnpgbe_rx_refill_pending()
    mucse_desc_unused_rx()
      reads next_to_clean, next_to_use

These are plain loads and stores with no locking and no
READ_ONCE()/WRITE_ONCE(), so this is a data race that KCSAN can report.
The practical effect seems limited to arming the timer when it isn't
needed, or skipping an arm that was.

Could the refill decision be computed before napi_complete_done(), while
NAPI is still owned?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/B438B0A83ACCA2DE%2B20261004065604.224873-1-dong100%40mucse.com
