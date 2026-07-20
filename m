Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC4F1FA859
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554268; cv=none; b=rlSjoXQLAVBupua5/SafGOnVNVbKYxfbyQ42MGHpyxUItb2ZNdu8HmfRbjw74U3qRlnUFtahxm8VtCc31qAoDBx9MlatKqpNk3I2UjlEcDSGmwzxL6ulxyMA4bBKdU8r0pa0UG5ZfudfJJ0saZGwTa/Jjm7Vibqi/i+Wm04Qxwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554268; c=relaxed/simple;
	bh=drrriSMBs1cPOloveDK0qTkGBiOCOEH6bv2v1nv3k/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjfW3W/9ms/0KIMLdy36dXMpgmLOEdpjx1VwFGamRfcEJE3ZqXx24Nzzzb3D71WdbmdDWI9+BpZ3cq59aqPW36ah+L7F/PluCA0u/ACKXaSyeurJhmqhlsqvwdFwdAjkJUUnz7EOOQaRVUdVyNHaiVBdoOUGQHbhH53qOZ7LBf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBOrg0wo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBOrg0wo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899641F000E9;
	Mon, 20 Jul 2026 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784554266;
	bh=ct81yaBUUAhTucM+P0CUBU5y7Xbf1aFZVPUvh3goSFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FBOrg0wokX5nGth0lw1wNuLMVWnnqY47UKDuQ1AD1VOrnl0b+wbQ/ZKtWTjFph/J/
	 NRb2JBk9YMDSsRzgyoX8wyKShZmX88g/BqGeRE50Ro5/hG97xauWbUjE7WrXmxy+w5
	 fgwjfCqdx6jxS1ixvzplcbhfhhAqbmEZquQNnYcepkAD7sLt7ZQFYk8Wuu+vDk7ahO
	 6hf8NIpibpsw9jAhMYM37wO1KRxu20yfbgn7p587bMxLjQU0Twqc3v9usaLmsfY3YC
	 ME0wxmj/Xl+/KJYUhtYiMKiDwQANCMnPUUveC37Ze13e4snHpEKJjHWO70ZZUqo344
	 x86ZFkgea0m3g==
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
Date: Mon, 20 Jul 2026 14:30:16 +0100
Message-ID: <20260720133015.145797-2-horms@kernel.org>
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
https://sashiko.dev/#/patchset/20260713035049.25310-1-atharvapotdar07@gmail.com?part=1
---
--- Patch [1]: [PATCH v5] r8169: migrate Rx path to page_pool, prepare for XDP ---
commit db5a368e94d087883d45d81ba30f59c05de881cf
Author: Atharva Potdar <atharvapotdar07@gmail.com>

r8169: migrate Rx path to page_pool, prepare for XDP

Replace the alloc_pages() + dma_map_page() + skb_copy() Rx model with
a page_pool-backed napi_build_skb() path for zero-copy delivery.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index ec4fc21fa21fb..c548e7e8db874 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
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

[Severity: High]
If memory allocation fails under pressure during an interface reset,
this loop breaks and leaves tp->Rx_databuff[i] as NULL. When NAPI runs,
could this lead to a permanent deadlock in rtl_rx()?

If a descriptor has a NULL buffer, rtl_rx() currently does:

    if (unlikely(!tp->Rx_databuff[entry]))
        break;

This breaks out of the Rx loop without advancing tp->cur_rx. Because
cur_rx didn't advance, the subsequent call to rtl8169_rx_refill() sees
tp->dirty_rx == tp->cur_rx and will not attempt to allocate memory.
Would it be better to advance cur_rx and drop the packet, or handle
the allocation failure without stalling the entire ring?

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
>  
>  		addr = le64_to_cpu(desc->addr);
>  		rx_buf = page_address(tp->Rx_databuff[entry]);
>  
>  		dma_sync_single_for_cpu(d, addr, pkt_size, DMA_FROM_DEVICE);
> -		prefetch(rx_buf);
> -		skb_copy_to_linear_data(skb, rx_buf, pkt_size);
> -		skb->tail += pkt_size;
> -		skb->len = pkt_size;
> -		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
> +		prefetch(rx_buf + tp->rx_headroom);
> +
> +		if (unlikely(tp->rx_headroom == 0)) {
> +			skb = napi_alloc_skb(&tp->napi, pkt_size);
> +			if (likely(skb)) {
> +				skb_copy_to_linear_data(skb, rx_buf, pkt_size);
> +				skb_put(skb, pkt_size);

[Severity: Critical]
This is a pre-existing issue, but earlier in rtl_rx() there is an
integer underflow on runt frames:

    pkt_size = status & GENMASK(13, 0);
    if (likely(!(dev->features & NETIF_F_RXFCS)))
        pkt_size -= ETH_FCS_LEN;

If NETIF_F_RXALL is enabled, the hardware can pass runt frames smaller
than 4 bytes. In this case, pkt_size underflows to a massive unsigned
value. 

Since this code passes pkt_size directly into dma_sync_single_for_device()
and skb_put(), could this massive value trigger an skb_over_panic() and
crash the kernel when processing runts?
