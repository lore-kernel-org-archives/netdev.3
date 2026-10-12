Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E3445AFC;
	Mon, 12 Oct 2026 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790891; cv=none; b=au5tE6qDXGUoqBlnD8+OGEXffLbj+l1bb3oZy1NkwJmv8GjV2CQM7WrG6AaiTEqn9aAHndumM0PGuHAph5oXmYtupAmXwBP5AOv8P2lerXT+wts3yZWWU/PeDaB5uIrTvEpvN3MxPFhsarsjh+23Smu2vE27vxsj8AmJVCro7Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790891; c=relaxed/simple;
	bh=RHusdzI8dGaGiTqtGg1sI+FJ/cVtSsrR74SlnoC5e6I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n0LSQgF1MWU2op34fMHodycy+jOySYmfJAAmwnykJXSKyZMqQa3i7gXnpQJnH4ZA12DWaI/1LPTF0t/nn8vKKgIx62M2qTVIGFeNdaQCCTzHbHHX8SAHVibrd9/GBKuri30ym5lIVvW+rCyoDGusUMriUII3jksNObb3DJJongc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkMavVZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkMavVZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1C21F0089D;
	Mon, 12 Oct 2026 07:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791790889;
	bh=/51NrFZKVLOIjDsOEqPRixRctzO8GVTzo0gbZ9Hr4Sc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RkMavVZXUXdq9vvmSVhjKB1knuebbAWGBN48AF0Pr2H0JjF7bXUItSN0mNmkVkcyu
	 vtYtoU4mgdulEm7lBDOUmFDAY2oP2LGFaiLaVKot5jEZFOpUTGtgfiv/TOEJU0h38l
	 PLIW9dIO+lLLpV7mtHy8MtFM+i8lE/sTz8BAAGTbhGWpKU5Ptw7HTGBgj09RCzZuM7
	 cjl09mnWwQ2Ww46PoAGAeDUF2TCCe91EXlbiAvtzAIijAOZ9rQMqE5f/qFZqbb6VaU
	 dxvEkgt9Zt71GqHOQm+WTyUO071KdXr8gMYY80h1APN7lx5+QZrFe28MH7srnbCICb
	 NBH6MA7jsLEHQ==
Subject: Re: [PATCH net-next v16 5/7] r8169: add support and enable rss
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk
Date: Mon, 12 Oct 2026 07:41:28 +0000
Message-ID: <179179088836.434549.3540299588900573541@kernel.org>
In-Reply-To: <20261008065722.1026-6-javen_xu@realsil.com.cn>
References: <20261008065722.1026-6-javen_xu@realsil.com.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says this patch fixes a memory overrun in
  rtl_rx() (drivers/net/ethernet/realtek/r8169_main.c) that happens with…
- [Low] On RTL8127 (RTL_GIGA_MAC_VER_80), rtl_alloc_irq() always calls
  pci_alloc_irq_vectors(pdev, 30, 32, flags) before…

--

r8169: add support and enable rss

This adds RSS support for RTL8127. The driver now requests 30 to 32 MSI-X
vectors and turns struct RxDesc into a union so it can handle the RSS
descriptor layout. It also adds a minimum length check in rtl_rx() for
runt and CRC-error frames received with NETIF_F_RXALL enabled.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 76f7a4592deb9..671a20c6e39a7 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -5158,11 +5432,21 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  
>  			if (!(dev->features & NETIF_F_RXALL))
>  				goto release_descriptor;
> -			else if (status & RxRWT || !(status & (RxRUNT | RxCRC)))
> -				goto release_descriptor;
> +
> +			if (tp->init_rx_desc_type == RX_DESC_TYPE_DEFAULT) {
> +				if (status & RxRWT || !(status & (RxRUNT | RxCRC)))
> +					goto release_descriptor;
> +			} else {
> +				if (!(status & (RXRUNT_RSS | RXCRC_RSS)))
> +					goto release_descriptor;
> +			}
>  		}
>  
>  		pkt_size = status & GENMASK(13, 0);
> +
> +		if (unlikely(pkt_size < ETH_HLEN + ETH_FCS_LEN))
> +			goto release_descriptor;
> +

[Severity: Medium]
The commit message says:

  Additionly, this patch fixes a potential skb overrun issue. Previously,
  with NETIF_F_RXALL enabled, a runt or CRC-error desc with a length below
  4 would fall through to subtract ETH_FCS_LEN. This will lead to a memory
  overrun.

The bug being fixed is already in mainline. In the current rtl_rx(), a
runt or CRC-error descriptor is not released when RXALL is on, so it
reaches this code with no minimum length check:

    pkt_size = status & GENMASK(13, 0);
    if (likely(!(dev->features & NETIF_F_RXFCS)))
        pkt_size -= ETH_FCS_LEN;

If the length is below 4, pkt_size wraps to about 4G. napi_alloc_skb()
then adds NET_SKB_PAD + NET_IP_ALIGN, which wraps the length back to a
small allocation. After that, skb_copy_to_linear_data() copies pkt_size
bytes, overrunning both the skb head and the RX page.

This check does not depend on RSS. Since it is part of a net-next feature
patch with no Fixes: tag or stable Cc, will stable kernels pick it up?

Could it be split into its own patch for the net tree, with a Fixes: tag
pointing at the commit that introduced the unchecked subtraction? The
logic looks like it comes from 588c7e5cc048 ("r8169: make rtl_rx better
readable") and ce11ff5e5963 ("r8169: fix vlan tag read ordering.").

>  		if (likely(!(dev->features & NETIF_F_RXFCS)))
>  			pkt_size -= ETH_FCS_LEN;
>  

[ ... ]

> @@ -5828,11 +6118,39 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static int get_max_irq_nvecs(struct rtl8169_private *tp)
> +{
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
> +		return R8127_MAX_NUM_IRQVEC;
> +	return R8169_IRQ_DEFAULT;
> +}
> +
> +static int get_min_irq_nvecs(struct rtl8169_private *tp)
> +{
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
> +		return R8127_MIN_NUM_IRQVEC;
> +	return R8169_IRQ_DEFAULT;
> +}
> +
> +static void rtl8169_set_rx_ring_num(struct rtl8169_private *tp)
> +{
> +	if (tp->irq_nvecs >= get_min_irq_nvecs(tp)) {
> +		unsigned int rss_queue_num = netif_get_num_default_rss_queues();
> +
> +		tp->num_rx_rings = rounddown_pow_of_two(min(rss_queue_num,
> +							    tp->hw_supp_num_rx_queues));
> +		if (tp->num_rx_rings >= 2)
> +			tp->init_rx_desc_type = RX_DESC_TYPE_RSS;
> +	}
> +}
> +

[ ... ]

> @@ -5848,7 +6166,14 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>  		break;
>  	}
>  
> -	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
> +	nvecs = pci_alloc_irq_vectors(pdev, min_nvecs,
> +				      get_max_irq_nvecs(tp), flags);

[Severity: Low]
On RTL8127 this always requests 30 to 32 vectors. The RX ring count is
chosen later, in rtl8169_set_rx_ring_num(). What happens when
netif_get_num_default_rss_queues() returns 1?

That function returns 1 unconditionally in a kdump kernel:

    if (unlikely(is_kdump_kernel() || !zalloc_cpumask_var(&cpus, GFP_KERNEL)))
        return 1;

It also returns 1 on a system with a single physical core. The result is
num_rx_rings = 1 and RX_DESC_TYPE_DEFAULT, so RSS stays off. irq_nvecs is
still around 32, though, so every irq_nvecs > 1 check still switches the
device to vector mapping mode, for example in rtl_hw_start_8125_common():

    if (tp->irq_nvecs > 1)
        rtl8169_hw_enable_vec_mapping(tp);

The same applies to the vector map registers in rtl_ack_events(),
rtl_irq_enable() and rtl_irq_disable(), the split NAPI setup in
r8169_init_napi(), and the per-vector handlers in rtl8169_request_irq().

Only a few of the allocated vectors are ever requested, so 27 to 29 stay
reserved and unused. In kdump this works against
netif_get_num_default_rss_queues() deliberately returning 1.

Should the ring count be decided before the vectors are allocated, or the
allocation fall back to a single vector when RSS will not be used? If the
current behavior is intended, could the commit message say that every
RTL8127 moves to vector mapping mode even when RSS stays off?

> +
> +	if (nvecs < 0 && min_nvecs > 1) {
> +		dev_info(&pdev->dev, "Failed to allocate %d MSI-X vectors.\n",
> +			 min_nvecs);
> +		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
> +	}
>  
>  	if (nvecs < 0)
>  		return nvecs;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008065722.1026-1-javen_xu%40realsil.com.cn
