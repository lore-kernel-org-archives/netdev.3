Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125851DE07;
	Wed, 30 Sep 2026 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803085; cv=none; b=G7BfmBYuNBdYRQAi810de7Iwm8KsLGL0zE3NBKfUzQyHzuws3OEiPTK9yoUcZcr+8Viezq4aUlZ/FjSe4QzOjgjSauguDoiNKgctn1k2YGgyMiY+ripEwc6wHMJ8bde0BZ4NYKGWX10kOuVGmjNd2A5r2aUYnyFHUXO3ykctKS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803085; c=relaxed/simple;
	bh=AYcZc1I5U3gWT889uu8UJwEqXiMjmZCtkK2jb5/EQmk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ultRrMLLcjM8C8A1TEq79NnENb4QudcMfLtLzMLX5cClD5qf+WbQqLYHLcYqsDP0PIgOHymxoX4HqdsvJYgKLQyFK96thXmnD3SksJGGcfzZOcRmnirlOD4t53rF/5UgnPmVkj3X705N40QS14MM5Aa86cwXe86Iqw1oJ8BIFl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zop67NBp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zop67NBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850471F00898;
	Wed, 30 Sep 2026 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790803083;
	bh=9gQU9t3cqa59YjmR5HfwDc+pfDQuKZxgB2G5jjbJa6o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Zop67NBpfRwpZjKHUxiqgAigzMa58yQbR5WnG3OgIfY2MfzWFEAm94nddsbk7+8Re
	 QUq18VF4eAJrfRTMn2oRxGDENgFY4pKqEzimrs4JZvDby5BOyWTmYQ38oCOxNZvDpv
	 wvSmF/+nkoZybhXCCe0NjCU5kRfrcolfP+GLIDaXMAc7+70W1qYUStDXLFFguLE3xr
	 Qz27UErV8nKvjnuyuniSYbTIYFkeo/s5OOb9HK/CF0YkVrwA2DK5T/nOEuAt5TSz4L
	 d0KlR4ogWxIrl9eqR32Uv6XCqeiawZHLzaiTyIjRH9nCe7LsCT1rUXdiNg0Q/42Y7y
	 M0zvBlVlb7rUA==
Subject: Re: [PATCH 4/5] net: ftgmac100: Add AST2700 upper DMA address support
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ratbert@faraday-tech.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 21:18:01 +0000
Message-ID: <179080308197.434549.16136724606360692634@kernel.org>
In-Reply-To: <20260927-support_ast2700-v1-4-9f03f29d2c82@aspeedtech.com>
References: <20260927-support_ast2700-v1-4-9f03f29d2c82@aspeedtech.com>
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

- [Low] The descriptor layout comments in
  drivers/net/ethernet/faraday/ftgmac100.h now contradict the code.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but TX completion
  reads the producer-published ring index without a paired read barrier.
- [High] This problem wasn't introduced by this patch, but the NC-SI
  failure path in ftgmac100_open() frees DMA memory while the MAC's DMA…

--

net: ftgmac100: Add AST2700 upper DMA address support

This commit adds 35-bit DMA addressing for the AST2700. It programs the
high RX and TX ring base registers and stores buffer address bits 34:32
in descriptor word 2. All of this is gated by a new
FTGMAC100_QUIRK_DMA_35BIT match-data quirk, which also sets a 35-bit DMA
mask at probe time.

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index b835472da3604..4becd28f805bc 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c

[ ... ]

> @@ -672,9 +686,14 @@ static void ftgmac100_free_tx_packet(struct ftgmac100 *priv,
>  				     struct ftgmac100_txdes *txdes,
>  				     u32 ctl_stat)
>  {
> -	dma_addr_t map = le32_to_cpu(txdes->txdes3);
> +	dma_addr_t map;
>  	size_t len;
>  
> +	map = le32_to_cpu(txdes->txdes3);
> +	if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT)
> +		map |= (u64)FIELD_GET(FTGMAC100_TXDES2_TXBUF_BADR_HI,
> +				     le32_to_cpu(txdes->txdes2)) << 32;
> +

[Severity: High]
This is a pre-existing issue, but the txdes2 read added here has the same
ordering problem as the existing txdes0 and tx_skbs[] reads on the TX
completion path. Is there a read barrier that pairs with the smp_wmb() in
ftgmac100_hard_start_xmit()?

The producer side does:

ftgmac100_hard_start_xmit()
    txdes->txdes2 = ...;
    txdes->txdes3 = ...;
    ...
    dma_wmb();
    first->txdes0 = cpu_to_le32(f_ctl_stat);
    smp_wmb();
    priv->tx_pointer = pointer;

The NAPI consumer side does:

ftgmac100_tx_complete()
    ftgmac100_tx_buf_cleanable()
        return priv->tx_pointer != priv->tx_clean_pointer;
    ftgmac100_tx_complete_packet()
        ctl_stat = le32_to_cpu(txdes->txdes0);
        if (ctl_stat & FTGMAC100_TXDES0_TXDMA_OWN)
            return false;
        skb = priv->tx_skbs[pointer];
        netdev->stats.tx_bytes += skb->len;
        ftgmac100_free_tx_packet(priv, pointer, skb, txdes, ctl_stat);

The smp_mb() in ftgmac100_tx_complete() only runs after this loop.

xmit and NAPI poll can run on different CPUs of an SMP AST2600/AST2700.
Could the NAPI CPU see the new tx_pointer while still reading the stale
txdes0 of that slot, with TXDMA_OWN clear from the previous clean, and a
stale tx_skbs[] entry?

If that happens, a packet that was just queued would be handled as
completed. skb could be NULL when skb->len is read. The buffer could also
be unmapped and freed while the MAC is about to DMA from it, and txdes0
would be overwritten, clearing the TXDMA_OWN bit that the producer just
set.

Would an smp_rmb() after ftgmac100_tx_buf_cleanable(), or an
smp_load_acquire() of tx_pointer, close this window?

>  	if (ctl_stat & FTGMAC100_TXDES0_FTS) {
>  		len = skb_headlen(skb);
>  		dma_unmap_single(priv->dev, map, len, DMA_TO_DEVICE);

[ ... ]

> @@ -931,7 +956,12 @@ static void ftgmac100_free_buffers(struct ftgmac100 *priv)
>  	for (i = 0; i < priv->rx_q_entries; i++) {
>  		struct ftgmac100_rxdes *rxdes = &priv->rxdes[i];
>  		struct sk_buff *skb = priv->rx_skbs[i];
> -		dma_addr_t map = le32_to_cpu(rxdes->rxdes3);
> +		dma_addr_t map;
> +
> +		map = le32_to_cpu(rxdes->rxdes3);
> +		if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT)
> +			map |= (u64)FIELD_GET(FTGMAC100_RXDES2_RXBUF_BADR_HI,
> +					     le32_to_cpu(rxdes->rxdes2)) << 32;
>  
>  		if (!skb)
>  			continue;

[Severity: High]
This is a pre-existing issue, and this patch did not introduce it.
ftgmac100_open() can reach ftgmac100_free_buffers() while the MAC's RX
and TX DMA engines are still enabled.

ftgmac100_open()->ftgmac100_init_all()->ftgmac100_start_hw() sets:

	maccr |= FTGMAC100_MACCR_TXDMA_EN	|
		 FTGMAC100_MACCR_RXDMA_EN	|
		 ...

If ncsi_start_dev() fails after that, the error path is:

err_ncsi:
	phy_stop(netdev->phydev);
	napi_disable(&priv->napi);
	netif_stop_queue(netdev);
err_alloc:
	ftgmac100_free_buffers(priv);
	free_irq(netdev->irq, netdev);
err_irq:
	netif_napi_del(&priv->napi);
err_hw:
	iowrite32(0, priv->base + FTGMAC100_OFFSET_IER);
	ftgmac100_free_rings(priv);

Only IER is cleared here. ftgmac100_stop_hw(), which clears MACCR, is
never called on this path, although ftgmac100_stop() does call it.

ncsi_start_dev() can fail on a reopen with NCSI_DEV_PROBED set. In that
case ncsi_reset_dev()->ncsi_choose_active_channel() returns -ENODEV when
no channel is found.

After that, can the RX engine keep polling the freed descriptor ring and
DMA incoming frames into the freed skb buffers, whose addresses are still
in rxdes3 and rxdes2?

Would calling ftgmac100_stop_hw() on this error path prevent that?

[ ... ]

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
> index 8c35c895b1465..0c244b1c0a351 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.h
> +++ b/drivers/net/ethernet/faraday/ftgmac100.h

[ ... ]

> @@ -226,6 +229,7 @@ struct ftgmac100_txdes {
>  #define FTGMAC100_TXDES1_TX2FIC		(1 << 30)
>  #define FTGMAC100_TXDES1_TXIC		(1 << 31)
>  
> +#define FTGMAC100_TXDES2_TXBUF_BADR_HI	GENMASK(18, 16)
>  /*
>   * Receive descriptor, aligned to 16 bytes
>   */
> @@ -272,4 +276,6 @@ struct ftgmac100_rxdes {
>  #define FTGMAC100_RXDES1_UDP_CHKSUM_ERR	(1 << 26)
>  #define FTGMAC100_RXDES1_IP_CHKSUM_ERR	(1 << 27)
>  
> +#define FTGMAC100_RXDES2_RXBUF_BADR_HI	GENMASK(18, 16)
> +

[Severity: Low]
This isn't a bug, but the descriptor layout comments in this header
still describe these words differently:

struct ftgmac100_txdes {
	...
	__le32	txdes2; /* Reserved */
	...
};

struct ftgmac100_rxdes {
	...
	__le32	rxdes2; /* length/type on AST2500 */
	...
};

When FTGMAC100_QUIRK_DMA_35BIT is set, the driver now writes buffer
address bits 34:32 into txdes2 and rxdes2. The writes happen in
ftgmac100_alloc_rx_buf(), ftgmac100_init_rings() and
ftgmac100_hard_start_xmit(). The bits are read back in
ftgmac100_rx_packet(), ftgmac100_free_buffers() and
ftgmac100_free_tx_packet().

Could these comments be updated to mention the AST2700 upper address
bits? The last patch in the series does not update them either.

>  #endif /* __FTGMAC100_H */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927-support_ast2700-v1-0-9f03f29d2c82%40aspeedtech.com
