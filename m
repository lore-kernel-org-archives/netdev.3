Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF941DEC8
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554206; cv=none; b=Url/DsCdKA2p/4I0V7dWJ8hM55xUXjB/8zbPpPRtb6JURoxDUut89z1mToQmA5/LTfbl28li3RFsAiCXNtAXXbazS6kS1Nla0lIdXUu0GMtC8YKLOjKqYYI/fQ0lokpVot9nsRmRA0BY9ViAELTaaDRW+uS9HdWnWv62o48hhdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554206; c=relaxed/simple;
	bh=sZc6NPIdhmYAIqJYFZm+s8nuxkU2bL76RvZtHIyg90E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJtX5njxW4fvvawhxL5LBISskBDT3OJTwK4CO/VmrgRP8ho57BbBLAFgrtMyCGuCgJAiFwPJh3XAn15NTWnMQqHCLyo127+wHInUGqRbtPf0TibWElteY/7PIz3bUEZMxgCU8Hvhiyg6wO5PY7mUlTSNmsAkx4H5alcJQy8GrRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhxgO5VC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhxgO5VC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A481F000E9;
	Mon, 20 Jul 2026 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784554204;
	bh=9VE3DuhtN00BCJKWO7ZPDa44qjPM1EDgrabynkps7dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bhxgO5VCYF9KmbsqIrtA8AjQXYwb9xlQsOLMHX5oTEO+HYWg9QAmKXbsfp9AVlv9a
	 cu0JLVNgKggYhoOqIqaOTZACumombsJvmRdvz3Gwd4/0QM9OPfONdLvCeBshUwIWFQ
	 bizAdUjgDxpqlonSLYf8wEDn6Llby13Q7w2xTh8HFSZsx//Sgf4jB5PtN+FpDHcZsd
	 H5PH9JspaGZEvLkH7dzaTwlN5jhxvqrhA29Pg9vQrsuC3kjtQCeIir88srHBPJNv/R
	 /oi3r/Cv7w4e/oec35Q3kTb1mj2umWq7T8YjAOlqulUL+LqQMGXZYcQPK6c/ZQDERL
	 k/OSGje2odfYg==
From: Simon Horman <horms@kernel.org>
To: atharvapotdar07@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	romieu@fr.zoreil.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5] r8169: migrate Rx path to page_pool, prepare for XDP
Date: Mon, 20 Jul 2026 14:29:53 +0100
Message-ID: <20260720132953.145008-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713035049.25310-1-atharvapotdar07@gmail.com>
References: <20260713035049.25310-1-atharvapotdar07@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260713035049.25310-1-atharvapotdar07@gmail.com?part=1
---
r8169: migrate Rx path to page_pool, prepare for XDP

This commit replaces the alloc_pages() + dma_map_page() + skb_copy() Rx
model with a page_pool-backed napi_build_skb() path. It keeps MACs up to
RTL_GIGA_MAC_VER_06 on the copy path, and reserves XDP_PACKET_HEADROOM
on newer MACs. It also decouples cur_rx from dirty_rx and registers an
xdp_rxq for MEM_TYPE_PAGE_POOL.

A few questions on the new code below.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index ec4fc21fa21f..c548e7e8db87 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -4221,12 +4228,57 @@ static int rtl8169_rx_fill(struct rtl8169_private *tp)
>  
>  static int rtl8169_init_ring(struct rtl8169_private *tp)
>  {
> +	struct page_pool_params params = {0};
> +	int err;
> +
>  	rtl8169_init_ring_indexes(tp);
>  
> +	if (tp->mac_version <= RTL_GIGA_MAC_VER_06) {
> +		tp->rx_headroom = 0;
> +		tp->rx_buf_sz = R8169_RX_BUF_SIZE;
> +	} else {
> +		tp->rx_headroom = XDP_PACKET_HEADROOM;
> +		tp->rx_buf_sz = SZ_16K -
> +						SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) -
> +						XDP_PACKET_HEADROOM;
> +	}

[High]

Can this silently break jumbo Rx on RTL8125/RTL8126? For those MACs
rtl_jumbo_max() returns JUMBO_16K (16362 bytes) and dev->max_mtu is
left unchanged by this patch, but tp->rx_buf_sz here becomes:

    SZ_16K - SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
           - XDP_PACKET_HEADROOM

which is roughly 15808 bytes. This value is written into every
descriptor by rtl8169_mark_to_asic():

    WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | rx_buf_sz));

while rtl_set_rx_max_size() still programs RxMaxSize based on
R8169_RX_BUF_SIZE + 1 = 16384. When a frame larger than ~15808 bytes
arrives at an MTU near 16362, the hardware will split it across
descriptors, and rtl8169_fragmented_frame() then drops it and bumps
rx_length_errors:

    if (unlikely(rtl8169_fragmented_frame(status))) {
        dev->stats.rx_dropped++;
        dev->stats.rx_length_errors++;
        goto release_descriptor;
    }

Should dev->max_mtu (or rtl_jumbo_max()) be adjusted for the newer
MACs so this reduction in the per-descriptor buffer size does not
silently drop max-size jumbo frames?

Relatedly, rtl8169_change_mtu() does not recompute rx_buf_sz or
repopulate the ring, so a change from a smaller MTU up towards
JUMBO_16K will not re-evaluate this either. Is that intentional?

Since the commit message describes this only as XDP preparation, could
the MTU-visible behaviour change be called out there as well?

[ ... ]

> +	tp->rx_pool = page_pool_create(&params);
> +	if (IS_ERR(tp->rx_pool)) {
> +		err = PTR_ERR(tp->rx_pool);
> +		tp->rx_pool = NULL;
> +		return err;
> +	}
> +
> +	err = xdp_rxq_info_reg(&tp->xdp_rxq, tp->dev, 0, tp->napi.napi_id);
> +	if (err)
> +		goto err_free_pool;

[Medium]

At this point, is tp->napi.napi_id actually assigned yet? rtl_open()
calls rtl8169_init_ring() before rtl8169_up() -> napi_enable(), and
napi_hash_add() (which populates napi_id) runs from
napi_enable_locked(). netif_napi_add() at probe time does not assign a
napi_id either.

If so, xdp_rxq_info_reg() is called with napi_id == 0 and the xdp_rxq
loses the association intended for busy-poll, netlink queue
introspection and XDP redirect wakeups.

Would deferring xdp_rxq_info_reg() until after napi_enable(), or using
a persistent napi_config-based id, keep the association the commit
message is establishing?

[ ... ]

> @@ -4311,8 +4363,20 @@ static void rtl_reset_work(struct rtl8169_private *tp)
>  
>  	rtl8169_cleanup(tp);
>  
> -	for (i = 0; i < NUM_RX_DESC; i++)
> -		rtl8169_mark_to_asic(tp->RxDescArray + i);
> +	for (i = 0; i < NUM_RX_DESC; i++) {
> +		if (tp->Rx_databuff[i])
> +			continue;
> +		tp->Rx_databuff[i] =
> +			rtl8169_alloc_rx_data(tp, tp->RxDescArray + i);
> +		if (!tp->Rx_databuff[i])
> +			break;
> +	}
> +
> +	for (i = 0; i < NUM_RX_DESC; i++) {
> +		if (!tp->Rx_databuff[i])
> +			continue;
> +		rtl8169_mark_to_asic(tp->RxDescArray + i, tp->rx_buf_sz);
> +	}
>  
>  	napi_enable(&tp->napi);
>  	rtl_hw_start(tp);

[High]

Can this leave the Rx ring with permanent gaps under memory pressure?

rtl8169_cleanup() does not clear Rx_databuff[], so on entry this loop
tries to refill slots consumed by the zero-copy path. On the first
allocation failure it breaks:

    if (!tp->Rx_databuff[i])
        break;

This skips every later NULL slot, even those where a subsequent
allocation might have succeeded. The second loop only marks entries
that already have a databuff, so the gap entries keep DescOwn=0.

rtl_reset_work() is void and rtl_hw_start() runs unconditionally, so
hardware then walks the ring sequentially and stalls at the first
gap. Since the normal refill (rtl8169_rx_refill()) only iterates
between dirty_rx and cur_rx, would slots at higher indices that were
never allocated here ever be filled again?

Would it be preferable to keep retrying across all slots (rather than
break on the first failure), or to fail the reset out to a scheduled
retry when allocation fails?

[ ... ]

> @@ -4768,16 +4832,39 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
>  		skb_checksum_none_assert(skb);
>  }
>  
> +static void rtl8169_rx_refill(struct rtl8169_private *tp)
> +{
> +	while (tp->dirty_rx != tp->cur_rx) {
> +		unsigned int entry = tp->dirty_rx % NUM_RX_DESC;
> +		struct RxDesc *desc = tp->RxDescArray + entry;
> +
> +		if (!tp->Rx_databuff[entry]) {
> +			struct page *new_page = page_pool_dev_alloc_pages(tp->rx_pool);
> +
> +			if (unlikely(!new_page))
> +				break;
> +
> +			tp->Rx_databuff[entry] = new_page;
> +
> +			desc->addr = cpu_to_le64(page_pool_get_dma_addr(new_page) +
> +				tp->rx_headroom);
> +		}
> +		rtl8169_mark_to_asic(desc, tp->rx_buf_sz);
> +
> +		tp->dirty_rx++;
> +	}
> +}
> +
>  static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget)
>  {
>  	struct device *d = tp_to_dev(tp);
>  	int count;
>  
> -	for (count = 0; count < budget; count++, tp->cur_rx++) {
> +	for (count = 0; count < budget;) {
>  		unsigned int pkt_size, entry = tp->cur_rx % NUM_RX_DESC;
>  		struct RxDesc *desc = tp->RxDescArray + entry;
>  		struct sk_buff *skb;
> -		const void *rx_buf;
> +		void *rx_buf;
>  		dma_addr_t addr;
>  		u32 status;
>  
> @@ -4820,21 +4907,40 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
>  			goto release_descriptor;
>  		}
>  
> -		skb = napi_alloc_skb(&tp->napi, pkt_size);
> -		if (unlikely(!skb)) {
> -			dev->stats.rx_dropped++;
> -			goto release_descriptor;
> -		}
> +		if (unlikely(!tp->Rx_databuff[entry]))
> +			break;

[High]

Can this pair of paths leave the ring wedged with hardware waiting on a
DescOwn=0 slot that software has already given up on?

If rtl8169_rx_refill() runs after some pages were consumed by the
zero-copy path and page_pool_dev_alloc_pages() fails, the loop breaks
without calling rtl8169_mark_to_asic() and without advancing dirty_rx:

    if (unlikely(!new_page))
        break;
    ...
    rtl8169_mark_to_asic(desc, tp->rx_buf_sz);
    tp->dirty_rx++;

So the descriptor stays with DescOwn=0 and Rx_databuff[entry] == NULL.

On the next NAPI iteration, when rtl_rx() reaches that entry the new
early exit:

    if (unlikely(!tp->Rx_databuff[entry]))
        break;

leaves rtl_rx() without advancing tp->cur_rx and without re-marking
the descriptor. Hardware is also stuck at this same slot, so if there
is no other IRQ source (e.g. TX completions) to schedule NAPI again,
does anything actually recover the Rx queue?

The pre-patch code always called rtl8169_mark_to_asic(desc) on the
drop path in rtl_rx(), so this stalled state was not structurally
reachable. Should the alloc-failure path here retain ownership with
the hardware (mark_to_asic with a placeholder / retry later) rather
than leaving DescOwn=0?

[ ... ]
