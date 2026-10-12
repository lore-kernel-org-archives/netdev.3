Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BBF435EFA;
	Mon, 12 Oct 2026 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790888; cv=none; b=P8mMEhiEyPEp2D1nnUYiK8u6RjOtyeMGOgrHCjxNzzzZThPLnqfU+1RWFQ1re3EnVL+XHcpVMzwlA6o+iN3KpwEd0rILMGfDlgGG+V4TrtpjFFgsgAsMLYoH9ebaDKHB3xtq350WDh75ev/TeOZxLsP3ypS9/nDwmM+kSLb7RzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790888; c=relaxed/simple;
	bh=bVM83k57FTwcNmGdO2oU9tiL/8HAF5S7ORasH3kpdFU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WKwmIEC2IOFNWveW/vyVUoubHxqh7JFdas2RwgwuSd+KmP9hvRFKcCYksq5XU1brLY35s8yqrsfMKDKmQ5o0KEIZC3CSJvWuTXePZ/Lohu8I4qqjhzgKlkN45PoEzOZXeUeicraD//H9JfDOwpZd/AJBmOSDY7VSEPpA37DAPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwSHabWo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwSHabWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CB31F0089B;
	Mon, 12 Oct 2026 07:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791790887;
	bh=zG68sLTO8bj+0p8gSK8rxYVAV4fSNaKS5VbtiJpdQ+E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OwSHabWoA1/DCzBiP67Wnby2ri/K+kjnzhsrRpxB5EhjdNtlVvtXtdpiCbjAlDQ3X
	 cKypJgl2QUTHeOU8Jxd5K2bPn7VkvZBBFsK8Eb2rQIFdMKvVTU7M7qCq/NNwSzEwvC
	 NaJ0LsoGmDQdlY57ssVX+mioY6vYrh165ktcP17qYnXFusRsluIXTqMpyrn7TV+dI6
	 wYbCPQ90Jqf8ZUTRVlFdHDp3CGf8de5VVCo97LvSpHXuiJ3lAjqO6RFzZeCoU2AwVX
	 5EF0d0UCFxuDS1tPcFTuPwTdlX6JUNhG49Ocp9WzWSgMcWTmy20ocYwUKZVnTLcshD
	 AHqxmaOubWImg==
Subject:
 Re: [PATCH net-next v16 3/7] r8169: add support for new interrupt mapping
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk
Date: Mon, 12 Oct 2026 07:41:25 +0000
Message-ID: <179179088580.434549.14246613625296073658@kernel.org>
In-Reply-To: <20261008065722.1026-4-javen_xu@realsil.com.cn>
References: <20261008065722.1026-4-javen_xu@realsil.com.cn>
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

- [Low] Baseline decision: false positive at the end of the series.
- [Low] Baseline decision: false positive at the end of the series.
- [Low] The comment above r8169_init_napi() in
  drivers/net/ethernet/realtek/r8169_main.c is inaccurate.
- [Low] Baseline decision: false positive at the end of the series.

--

r8169: add support for new interrupt mapping

This adds the infrastructure for the vector-map interrupt registers on
RTL8127, used for multi-vector MSI-X. It adds per-RX-ring and TX NAPI
poll handlers and a dedicated link-change vector. All of the new paths
are gated on tp->irq_nvecs > 1, which is still always 1 at this point in
the series.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index e88d512cc3a56..caa5f2880c6a2 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -1769,26 +1776,38 @@ static u32 rtl_get_events(struct rtl8169_private *tp)

[ ... ]

>  static void rtl_irq_enable(struct rtl8169_private *tp)
>  {
> -	if (rtl_is_8125(tp))
> -		RTL_W32(tp, IntrMask_8125, tp->irq_mask);
> -	else
> +	if (rtl_is_8125(tp)) {
> +		if (tp->irq_nvecs > 1)
> +			RTL_W32(tp, IMR_SET_VEC_MAP_REG, tp->irq_mask);
> +		else
> +			RTL_W32(tp, IntrMask_8125, tp->irq_mask);
> +	} else {
>  		RTL_W16(tp, IntrMask, tp->irq_mask);
> +	}
>  }

[Severity: Low]
Does the chip need to be in vector-map mode before writes to
IMR_SET_VEC_MAP_REG, IMR_CLEAR_VEC_MAP_REG and ISR_VEC_MAP_REG take
effect?

In this commit nothing sets INT_CFG0_ENABLE_8125, and
rtl_hw_start_8125() clears the whole register:

rtl_hw_start_8125() {
    ...
	RTL_W8(tp, INT_CFG0_8125, 0x00);
    ...
}

This can't trigger here because irq_nvecs is always 1. The next patch
in the series, "r8169: prepare for new interrupt mapping", adds
rtl8169_hw_enable_vec_mapping(). That function sets INT_CFG0_ENABLE_8125
from rtl_hw_start_8125_common() when irq_nvecs > 1.

It runs after the clear above, through rtl_hw_config() ->
rtl_hw_start_8127a() -> rtl_hw_start_8125_common(), so the series as a
whole looks consistent.

Would it be worth saying in the commit message that vector-map mode is
enabled in a later patch?

[ ... ]

> @@ -6208,12 +6325,69 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
>  	return 0;
>  }
>  
> +static int rtl8169_poll_msix_rx(struct napi_struct *napi, int budget)
> +{

[ ... ]

> +	if (message_id < tp->num_rx_rings)
> +		work_done += rtl_rx(dev, tp, &tp->rx_ring[message_id],
> +				    budget, napi);

[Severity: Low]
Once there is one of these NAPI instances per RX ring, could they run at
the same time on different CPUs? If so, they would race on the shared
dev->stats counters in rtl_rx():

rtl_rx() {
    ...
		if (unlikely(rtl8169_fragmented_frame(status))) {
			dev->stats.rx_dropped++;
			dev->stats.rx_length_errors++;
			goto release_descriptor;
    ...
		if (skb->pkt_type == PACKET_MULTICAST)
			dev->stats.multicast++;
    ...
}

rtl8169_check_rx_desc_error() increments dev->stats.rx_length_errors
and dev->stats.rx_crc_errors in the same way. These are plain
non-atomic increments, so concurrent writers could lose updates.

This can't happen in this commit because irq_nvecs is always 1. The
next patch, "r8169: prepare for new interrupt mapping", moves these
counters into per-ring ring->stats protected by u64_stats_sync. That
happens before "r8169: add support and enable rss" enables multiple RX
NAPIs.

[ ... ]

> +/* RTL8127 MSI-X vector layout:
> + * Vectors 0 .. (MAX_RXQ - 1)			: Rx Queues
> + * Vectors MAX_RXQ .. (MAX_RXQ + MAX_TXQ - 1)	: Tx Queues
> + * NAPI is only allocated for data path
> + */

[Severity: Low]
This isn't a bug, but is this comment accurate?

The layout leaves out the link-change vector MSIX_ID_VEC_MAP_LINKCHG
(29). rtl8169_request_irq() requests that vector with
rtl8169_interrupt_other(), and rtl8169_free_one_irq() frees it.

Also, rtl_init_one() allocates one napi_struct per vector:

	tp->rtl8169_napi = kcalloc(tp->irq_nvecs, sizeof(struct napi_struct),

Later in the series there are 30 to 32 vectors, but only
num_rx_rings + 1 of these entries are ever registered. So the NAPI
structs are allocated per vector and only registered for the data path.

The comment is still unchanged at the end of the series.

>  static void r8169_init_napi(struct rtl8169_private *tp)
>  {
> -	for (int i = 0; i < tp->irq_nvecs; i++) {
> -		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
> -		netif_napi_set_irq(&tp->rtl8169_napi[i],
> -				   pci_irq_vector(tp->pci_dev, i));
> +	int i;
> +
> +	if (tp->irq_nvecs > 1) {
> +		for (i = 0; i < tp->num_rx_rings; i++) {
> +			netif_napi_add(tp->dev, &tp->rtl8169_napi[i],
> +				       rtl8169_poll_msix_rx);
> +			netif_napi_set_irq(&tp->rtl8169_napi[i],
> +					   pci_irq_vector(tp->pci_dev, i));
> +		}
> +		netif_napi_add_tx(tp->dev,
> +				  &tp->rtl8169_napi[R8169_MAX_RX_QUEUES],
> +				  rtl8169_poll_msix_tx);

[Severity: Low]
Is tp->rtl8169_napi[R8169_MAX_RX_QUEUES] always inside the array here?

The array is allocated with kcalloc(tp->irq_nvecs, ...), but the only
check is irq_nvecs > 1. With irq_nvecs between 2 and 8, index 8 would be
past the end of the array. That index is used here and in
rtl8169_napi_enable(), rtl8169_napi_disable(), r8169_free_napi() and
rtl8169_netpoll().

There is a similar gap for the link-change vector. rtl_set_irq_mask()
always arms ISRIMR_LINKCHG when irq_nvecs > 1. However,
rtl8169_request_irq() only installs rtl8169_interrupt_other() when the
loop reaches MSIX_ID_VEC_MAP_LINKCHG (29). With fewer than 30 vectors,
the link-change interrupt would have no handler.

As far as I can tell, neither case can happen anywhere in the series:

- In this commit, rtl_alloc_irq() calls
  pci_alloc_irq_vectors(pdev, 1, 1, flags).
- In "r8169: add support and enable rss", the minimum is 30 vectors
  for RTL_GIGA_MAC_VER_80, with a fallback to exactly 1 vector.

So irq_nvecs > 1 implies irq_nvecs >= 30.

Could this dependency be made explicit, with a check or a comment saying
multi-vector mode requires at least 30 vectors, rather than relying on
irq_nvecs > 1 alone?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008065722.1026-1-javen_xu%40realsil.com.cn
