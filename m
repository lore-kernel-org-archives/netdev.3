Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB83264614;
	Mon, 10 Aug 2026 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786397507; cv=none; b=LnGKv6wJdtq6hBrBdFguFUDBsGc957EArr4sIOTi76kPuxtfH+oZwzBo/bLyV/mbSgPrDeRR3IKqYKVcubWs9kss/zFUECr7Ycqm8RUmyNdrGzpdC/YVP2LFFoU8WozspNKChn6ZMVWix+/c4St5uvk/v+7NgZVQMkdkOriZFj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786397507; c=relaxed/simple;
	bh=mX4BgPm+RC12y5cNxujzhqWqUlY5YoQOFKughZzwGKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvmHrgy6R1n4uh0SCRzAr69WiUcXelN5w1/CaxrcHbh9v4Gj2uXpmW/Lx/34FycjWn/iF3+/UE0RUN6go0LceycCjdtB8xZKBkB1EdxscJNwB38DbJdbGdslC1EGWg0CfB1IMrOgN/fOJHiJKjUSK3PTAzsyp/G2fIVS7b1OIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjuIbd+Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjuIbd+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AF61F000E9;
	Mon, 10 Aug 2026 21:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786397505;
	bh=K/ez3z+AnN8NU3BT5SzNb5Ag2rVhW5CkT7vxeDSCOGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MjuIbd+ZZSlq4UBiWOCM3EpQlKmiyKuLAl/GYx7h7o8xdnF+rSET6t2h959MmvSnv
	 +zAaH7DGGxvKbXtzld7ZdwDGqSfHtG60VOygQjmDuwSs0CCDxGKo0xmcmtWDJvR5Gl
	 OMzWF1qfnAy+grDUP2tseVMWaXGFP1XFkb31lEL/w/DV/GwVZiMZBYG5RmoPGwyMjX
	 z01YfV7HCJ7N1pFOJ6o2a+8SAC28j7RqtpLTvU/hNuzmdrznet1GLPubtrMUflOJ6x
	 gQwm9EoFB7cH26Uitzhb4FcyZvGsZ5F1WV1FUCesIqaxhYPQQQAynPXcplovQjCTZK
	 JsuWHZUgnUYeg==
From: Jakub Kicinski <kuba@kernel.org>
To: javen_xu@realsil.com.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 5/7] r8169: add support and enable rss
Date: Mon, 10 Aug 2026 14:31:44 -0700
Message-ID: <20260810213144.854057-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803021305.488-6-javen_xu@realsil.com.cn>
References: <20260803021305.488-6-javen_xu@realsil.com.cn>
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
r8169: add support and enable rss

This patch adds support and enables Receive Side Scaling (RSS) for RTL8127.
It configures RSS keys, redirection tables, and introduces support for
parsing RSS-specific RX descriptors.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
[ ... ]
> @@ -4920,27 +5123,87 @@ static inline int rtl8169_fragmented_frame(u32 status)
>  	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
>  }
>  
> -static inline void rtl8169_rx_csum(struct sk_buff *skb,
> +static inline void rtl8169_rx_hash(struct rtl8169_private *tp,
> +				   struct RxDesc *desc,
> +				   struct sk_buff *skb)
[ ... ]
> +static inline void rtl8169_rx_csum(struct rtl8169_private *tp,
> +				   struct sk_buff *skb,
>  				   u32 opts1)
>  {
> -	u32 status = opts1 & (RxProtoMask | RxCSFailMask);
> +	bool csum_ok = false;
> +
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_TYPE_RSS:
> +		if (((opts1 & RX_TCPT_DESC_RSS) && !(opts1 & RX_TCPF_DESC_RSS)) ||
> +		    ((opts1 & RX_UDPT_DESC_RSS) && !(opts1 & RX_UDPF_DESC_RSS)))
> +			csum_ok = true;
> +		break;
> +	default:
> +		u32 status = opts1 & (RxProtoMask | RxCSFailMask);

[Severity: Low]
Will this compile under standard C? Declaring a variable immediately
following a label (default:) is a syntax error in C unless it is wrapped in
a block.

>  
> -	if (status == RxProtoTCP || status == RxProtoUDP)
> +		if (status == RxProtoTCP || status == RxProtoUDP)
> +			csum_ok = true;
> +		break;
> +	}
> +
> +	if (csum_ok)
>  		skb->ip_summed = CHECKSUM_UNNECESSARY;
>  	else
>  		skb_checksum_none_assert(skb);
>  }
[ ... ]
>  static bool rtl8169_check_rx_desc_error(struct net_device *dev,
>  					struct rtl8169_private *tp,
>  					u32 status)
>  {
> -	if (unlikely(status & RxRES)) {
> -		if (status & (RxRWT | RxRUNT))
> -			dev->stats.rx_length_errors++;
> -		if (status & RxCRC)
> -			dev->stats.rx_crc_errors++;
> -		return true;
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_TYPE_RSS:
> +		if (unlikely(status & RX_RES_RSS)) {
> +			if (status & RX_RUNT_RSS)
> +				dev->stats.rx_length_errors++;
> +			if (status & RX_CRC_RSS)
> +				dev->stats.rx_crc_errors++;

[Severity: Medium]
Can these direct increments to dev->stats cause lost updates?

Now that RSS is enabled, multiple RX queues can trigger NAPI polling
concurrently on different CPUs. If multiple queues receive errored packets
simultaneously, they will race to read-modify-write these global stat
counters.

> +			return true;
> +		}
> +		break;
> +	default:
> +		if (unlikely(status & RxRES)) {
> +			if (status & (RxRWT | RxRUNT))
> +				dev->stats.rx_length_errors++;
> +			if (status & RxCRC)
> +				dev->stats.rx_crc_errors++;
> +			return true;
> +		}
> +		break;
>  	}
>  	return false;
>  }
[ ... ]
> @@ -4977,7 +5240,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  
>  			if (!(dev->features & NETIF_F_RXALL))
>  				goto release_descriptor;
> -			else if (status & RxRWT || !(status & (RxRUNT | RxCRC)))
> -				goto release_descriptor;
> +			if ((status & RxRWT || !(status & (RxRUNT | RxCRC))) &&
> +			    tp->init_rx_desc_type == RX_DESC_TYPE_DEFAULT)
> +				goto release_descriptor;
>  		}

[Severity: High]
Does this bypass the drop logic for fatal errors when RSS and RXALL are
both enabled?

If the hardware receives a fatally errored packet while RSS is enabled,
the descriptor type check (tp->init_rx_desc_type == RX_DESC_TYPE_DEFAULT)
prevents the code from taking the goto release_descriptor path. This could
cause the driver to process frames with corrupted length fields or 
uninitialized memory.

>  
> @@ -5010,10 +5274,12 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
