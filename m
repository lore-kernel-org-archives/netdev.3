Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A131457E49
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791199100; cv=none; b=ldWjngUZ160IDiuG+KToCVNuZfSUjAb8RBWLlhz2Zwa+9l1KGWOtfaumYl/EsYXJkMKz62Zg+77d4St/6FW5sxZaCdOVdfVHTSyf8Sbpz0VESYEOW7mR+hIjCgkpuoz3s6IjB1+rwsmx/6enrelYjm/jvwY3QAatNo4Y0AcmQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791199100; c=relaxed/simple;
	bh=IK6vvqVLx0VN7gW3YaqLJEVHK5Mx6/escREkj8Mrlps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNQnsu09dtExK5m70zs03U9IBvXx9DTGTJlQbY+dcpXkJa+SUnh5jsALkzEoxPgOmT7b+R8ywqBd6B83kYTNlQ1BmzUZYV55VyeshBsal5aWMDIZQXzUMzPkGN/NVv0JoQ18TvmdT5y0PERemAADBMtyN2lupNo+u3shlKQw0F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu6mtOMS; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu6mtOMS"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b01d89b23so769976f8f.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 04:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791199096; x=1791803896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TDYttNtDrGDnB4Dwqr04ORtBzD3eCHssCmsCpTKY6Oo=;
        b=Uu6mtOMSesoQS/6drWY9odMwnHert6wEryKTsR/5OfjxT1GZmymVcKroq5EtMK/NP3
         RfT+OT0cZlHh5lsAbSjSlby1aT3z0WCb3TUW8wE4hU1Ga7Vsm0EfRJ+bhBGK11g0CBUV
         wcC1CZ7fQcBg5P5iUKcpcyGJHSUB7wRRU+vUBfenDIAn9tIg7Zu66TGIvvNem/OoGHf4
         pSvpRxQEAppdKOP4skGixIJ9hudIhJOXeRBqtjAFJBEOQRx1FJWViGcllPCZqCcvfCTB
         e1RDkb3rZsVkJ6LZVk3tc8F3VVatTQOV5QtsJVbSOaQAJc2rGPfTBi6Fpe00JoPRmFF5
         z1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791199096; x=1791803896;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TDYttNtDrGDnB4Dwqr04ORtBzD3eCHssCmsCpTKY6Oo=;
        b=pNdGT34pTyDDtNT1LeMWultF7r2azV/cMeCwlZQjKsqniOscI5isFJXOXRxLApSz/J
         t7DeFspnsT5oYyeFC5baB5YaljJqtibKdnjUF6aLf3hBH0BYD84Zb/iTiFXSWdKC+i2z
         ddR7BxGgN9aVVAG0NOuN1oODpYENsN8DiLOXhUMNkMMuB3nIDEimF+pY6Xg0CIh/pPlO
         1mQS5C/GJ0pRdkzgQ2CLtjzvkmPQV/AFyYEwyGJmtuiaR+MYz/DKzb3ZuNf84T+NeuEg
         nFABqZ1HsBd2w1hx7ffANEFExio/4mDjZz2OzTlJbjdPvIFyCUUbR9ARNyVICQu9rhfS
         Xqwg==
X-Forwarded-Encrypted: i=1; AKwUvBzR31/YQBKqRdrVp6ffVtgIvz69XfRgL8gEguc1gzwZiMjtzt46d6cNW+eq76EoK6bkGS9N4ck=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkfrAcB3INZlMvKeAKbsWGepq+kVcGyiyEyC0EKr4bOFCs0PVo
	/GNqzomD9w7mjZ19up9nx+rWURxW0Kifcn0CeFfgmRMQZo8cJ0JQS2em
X-Gm-Gg: AYBFou1R0xgmVElIguhBiQMifjdPNuglC49VzEz9xlPj62SI3lchiillVTeIXn0yU/T
	Hr/mBhypCLvfhYlS8qVL766Uej7M5rom7BuHEVxUkNaaiBW7Hu8dmMjhlBRTSuL1gGTVdH+jEqp
	7cNguDuYeVH/0eJ8ka8XfN4inBFlamVS//JHO7PwLZZjthD8MvvvIWyZir8VFaWjhHDrRvI506M
	MFZ7ROfdw0R52TVRh6tZhOmQ8hSStkHvxAUuumQ8c1b/bRhJxIwTctq7F3nvlGjzpYDcfVWtFIf
	Eko/ExW/Q/3XQKfcpKzdqpXerqMwkSUxhSIn3uXrvpmQPyT0rVxlZHKlBM98p+wOCHCphnz31lN
	joBKCiVIAhAdKy84iTFyxq72sakhIbyHwfB96KQanQRF86AOBVGkx7d2uYImYXYcAryV8W9hn7M
	1HSy36iq6NIEhpW8VRnXMqUTuUm6DfJU/YGZWqYOdTFK0NMN6inlFpqFAd69QEHp8/u8zlRDukF
	HdTZNTGujZ/ZVHbn5ddNvJUpPRITaCG1Q==
X-Received: by 2002:a05:6000:4711:b0:48b:10c8:2183 with SMTP id ffacd0b85a97d-48b1271f665mr18148108f8f.32.1791199095489;
        Mon, 05 Oct 2026 04:18:15 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622ab7b5sm3133150f8f.37.2026.10.05.04.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 04:18:14 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id B6B68DC01EA; Mon, 05 Oct 2026 13:18:13 +0200 (CEST)
Date: Mon, 5 Oct 2026 13:18:13 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org, Stefan Fleischmann <sfle@kth.se>,
	Eric Dumazet <edumazet@google.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bernhard Schmidt <berni@debian.org>
Subject: Re: [PATCH net] bnxt_en: fix DMA mapping length for padded small
 packets
Message-ID: <asOHdc6HMSVrS9z9@eldamar.lan>
References: <20261005023812.130639-1-edumazet@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005023812.130639-1-edumazet@kernel.org>

Hi,

On Mon, Oct 05, 2026 at 04:38:12AM +0200, Eric Dumazet wrote:
> Stefan Fleischmann reported Intel IOMMU DMA Read faults on BCM57412
> NetXtreme-E NICs when transmitting packets on VLAN/macvlan interfaces:
> 
>   DMAR: [DMA Read NO_PASID] Request device [18:00.0] fault addr 0xfc499000
>         [fault reason 0x06] PTE Read access is not set
>   bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0xb4 0x41a} len: 0 due to firmware status: 0x2000001
>   ...
>   NETDEV WATCHDOG: eno1np0 (bnxt_en): transmit queue 0 timed out
> 
> The fault address (0xfc499000) is on an exact 4KB page boundary,
> pointing to a DMA read buffer overrun.
> 
> In bnxt_start_xmit(), packets smaller than BNXT_MIN_PKT_SIZE (52 bytes),
> such as 42-byte untagged ARP frames, are padded:
> 
>     if (length < BNXT_MIN_PKT_SIZE) {
>         pad = BNXT_MIN_PKT_SIZE - length;
>         if (skb_pad(skb, pad))
>             goto tx_kick_pending;
>         length = BNXT_MIN_PKT_SIZE;
>     }
> 
>     mapping = dma_map_single(&pdev->dev, skb->data, len, DMA_TO_DEVICE);
>     ...
>     dma_unmap_len_set(tx_buf, len, len);
> 
> However, 'len' was initialized earlier to skb_headlen(skb) (e.g. 42 bytes)
> and is left unadjusted after padding. Consequently, dma_map_single() and
> dma_unmap_len_set() map and track only 42 bytes.
> 
> Later, the hardware TX buffer descriptor is programmed with the padded length:
> 
>     txbd->tx_bd_len_flags_type =
>         cpu_to_le32(((len + pad) << TX_BD_LEN_SHIFT) | flags |
>                     TX_BD_FLAGS_PACKET_END);
> 
> The NIC DMA engine is thus instructed to read 52 bytes from a region where
> only 42 bytes were DMA-mapped. If skb->data ends near the boundary of a 4KB
> page (within 'pad' bytes of the next page), the hardware DMA read overruns
> into the unmapped adjacent page, triggering an IOMMU fault.
> 
> This issue was exposed after commit 447cbe95ebb9 ("vlan: fix skb_under_panic
> and races when toggling HW VLAN offload") because reserving extra VLAN
> headroom rounded LL_RESERVED_SPACE from 48 up to 64 bytes, shifting skb->data
> offsets and potentially causing small frames to land right against page
> boundaries.
> 
> Fix this by using skb_put_padto(skb, BNXT_MIN_PKT_SIZE) in the normal_tx
> path. This ensures skb->len and skb_headlen(skb) reflect the padded size so
> that dma_map_single() maps the full buffer and the descriptor length is
> consistent. This also removes the temporary 'pad' variable and masking logic.
> 
> Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
> Cc: stable@vger.kernel.org
> Reported-by: Stefan Fleischmann <sfle@kth.se>
> Closes: https://lore.kernel.org/netdev/20261004122616.56714cbd@nargothrond/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Michael Chan <michael.chan@broadcom.com>
> Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index d7728d0c5b6e63ee72de9dea54426bb4c8b7a9fc..7ea27e81e88c5ca82a453b449982b791e8acc831 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -486,7 +486,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct netdev_queue *txq;
>  	int i;
>  	dma_addr_t mapping;
> -	unsigned int length, pad = 0;
> +	unsigned int length;
>  	u32 len, free_size, vlan_tag_flags, cfa_action, flags;
>  	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
>  	struct pci_dev *pdev = bp->pdev;
> @@ -672,14 +672,12 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	}
>  
>  normal_tx:
> -	if (length < BNXT_MIN_PKT_SIZE) {
> -		pad = BNXT_MIN_PKT_SIZE - length;
> -		if (skb_pad(skb, pad))
> -			/* SKB already freed. */
> -			goto tx_kick_pending;
> -		length = BNXT_MIN_PKT_SIZE;
> +	if (skb_put_padto(skb, BNXT_MIN_PKT_SIZE)) {
> +		/* SKB already freed. */
> +		goto tx_kick_pending;
>  	}
> -
> +	length = skb->len;
> +	len = skb_headlen(skb);
>  	mapping = dma_map_single(&pdev->dev, skb->data, len, DMA_TO_DEVICE);
>  
>  	if (unlikely(dma_mapping_error(&pdev->dev, mapping)))
> @@ -759,10 +757,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
>  	}
>  
> -	flags &= ~TX_BD_LEN;
> -	txbd->tx_bd_len_flags_type =
> -		cpu_to_le32(((len + pad) << TX_BD_LEN_SHIFT) | flags |
> -			    TX_BD_FLAGS_PACKET_END);
> +	txbd->tx_bd_len_flags_type |= cpu_to_le32(TX_BD_FLAGS_PACKET_END);
>  
>  	netdev_tx_sent_queue(txq, skb->len);
>  
> -- 
> 2.53.0

FWIW, got as well reported in Debian for an update in the 6.12.y
series: https://bugs.debian.org/1149564 , in case you would like to
add a further Link/Closes reference. Bernhard Schmidt is testing the
patch as well on top of 6.12.111 (what we have right now in Debian)
and looks promissing: https://bugs.debian.org/1149564#89 .

Berhard, want to report back a Tested-by from you?

Regards,
Salvatore
