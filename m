Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D7349E153;
	Thu,  1 Oct 2026 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870811; cv=none; b=GY+txaXD/WhXJpwz4tiYaxeau6blTWaKUi5xX3xdGJTxslFtkPXgtcGNcNJjlbIkzc/GgeZD9FbHois3KFzxj9oLpooW8R3OHiEA60FJZFSxfrL3yUXErfz0qiWE3TFrTsZ60ZPNmeKjPns4X1Q04SpAm869Tv2V8gczPu7WKI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870811; c=relaxed/simple;
	bh=MsXoDuzBk9/DkACT+KoXfrikrc6foRlqUHmoVPewPJg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f3SD2xik30sbjVrSeishGLzAJbRYnrBLm/GO6Ge8METAxhaGiYMMGkMgoE6+iJxjlkWe6+ieaf7qyzj7Uksrl1+xfvBQMI2/jXHSXnWT7wPF1mUryHHg28E6QDrbI+vfpHnJr1dhNU6AznkVqtkO5vc7IQwEoQG5/G8WxpqxQvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ev0sRjdy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ev0sRjdy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC321F00904;
	Thu,  1 Oct 2026 16:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870808;
	bh=J4FmfJbmwrGJvF+4GmZjmmqBoRflstHyMiCFYWjBQas=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ev0sRjdyma1EnIozSkdatiLUG8BH0sWIgbGj5zEFki6f3Z5e/ci2gPnEaJazz9kZa
	 cGLTF7G6ZoM7srmi/3gkUZq4mz1JRbk9g/d7L42pinAi2m0LWyEGgQG6YSKzmbpSY/
	 K1Oc5QPlGZrK//3MFO4EtPgn/OnBHRd+WOZapmPz6LSXscZsUjtRR6eDDY1ZODt2EC
	 54VdPDzVP1tBS/d59x4TQfvAp/Q1leGaXa37iNWWGvID5+8blFfTisW9LCcnxsg5e3
	 HFelsY3EIRd0y/6V0k816sHT1AgdL0OJ0i2kH8TPAP4+OX6LXcTXrsCK/6rofPmBJT
	 +MM45Uj/SGjqA==
Subject: Re: [PATCH net-next v15 5/7] r8169: add support and enable rss
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 16:06:47 +0000
Message-ID: <179087080747.434549.3365873067544458031@kernel.org>
In-Reply-To: <20260928070423.202-6-javen_xu@realsil.com.cn>
References: <20260928070423.202-6-javen_xu@realsil.com.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In `rtl_alloc_irq()` this patch widens the allocation from
  `pci_alloc_irq_vectors(pdev, 1, 1, flags)` to 30..32 vectors on…
- [Medium] The patch adds `if (unlikely(pkt_size < ETH_HLEN +
  ETH_FCS_LEN)) goto release_descriptor;` in `rtl_rx()` (line 5448).
- [Low] The new fallback in `rtl_alloc_irq()` runs for every chip, but it
  only makes sense for RTL_GIGA_MAC_VER_80.
- [Low] The concern was that the patch enables multi-queue RX and RSS
  (NETIF_F_RXHASH, an indirection table from…

--

r8169: add support and enable rss

This commit adds RSS support for RTL8127 (RTL_GIGA_MAC_VER_80). It
requests 30 to 32 MSI-X vectors and sizes the RX ring count from
netif_get_num_default_rss_queues(). It also switches to the RSS RX
descriptor layout and programs the RSS key, indirection table and hash
control registers.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 20eb7987f03dc..50fb15a5331e0 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -2826,17 +2908,27 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
>  	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
>  }
>  
> +static void rtl8169_init_rss(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->rss_data->hw_supp_indir_tbl_entries; i++)
> +		tp->rss_data->rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, tp->num_rx_rings);
> +
> +	netdev_rss_key_fill(tp->rss_data->rss_key, RTL_RSS_KEY_SIZE);
> +}

[Severity: Low]
This isn't a bug, but this builds ethtool-style RSS state (a default
indirection table and a random key), and rtl8169_ethtool_ops never
exposes it.

The later patch "r8169: add get_channel support for ethtool" adds
.get_channels. Even at the end of the series, though, there is no
.get_rxfh, .get_rxfh_key_size, .get_rxfh_indir_size or .get_rxfh_fields.

Could those be added so the key, table and hash fields can be read and
changed through ethtool?

[ ... ]

> @@ -5160,11 +5433,21 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
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
>  		if (likely(!(dev->features & NETIF_F_RXFCS)))
>  			pkt_size -= ETH_FCS_LEN;

[Severity: Medium]
This check applies to every chip and to both descriptor formats. The
commit message only says:

    This patch adds support and enable rss for RTL8127.

Before this patch, with NETIF_F_RXALL enabled, a runt or CRC-error
descriptor whose length field is below 4 falls through to:

    pkt_size = status & GENMASK(13, 0);
    if (likely(!(dev->features & NETIF_F_RXFCS)))
        pkt_size -= ETH_FCS_LEN;

pkt_size then wraps to about 4GiB. napi_alloc_skb() adds NET_SKB_PAD and
NET_IP_ALIGN, which wraps it back to a small allocation. The call to
skb_copy_to_linear_data(skb, rx_buf, pkt_size) then overruns that
allocation.

The fix is mentioned only in the v14 changelog below the --- line, and
that text is dropped when the patch is applied. There is no Fixes: tag.

Should this be split into its own patch with a Fixes: tag so stable
kernels pick it up?

The check also changes behaviour on non-RSS chips. With RXALL and RXFCS
both enabled, runt frames of 14 to 17 bytes used to be delivered and are
now dropped.

The commit message also does not mention that struct RxDesc, which every
chip uses, is converted into a union.

[ ... ]

> @@ -5830,6 +6119,32 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  	}
>  }
>  

[ ... ]

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

[Severity: Medium]
Can this leave MSI-X handlers bound to NAPI structs that were never added?

After this patch, irq_nvecs can be 30 to 32 on RTL8127 while
num_rx_rings is 1, 2 or 4. That happens on hosts with fewer than 8
cores, and num_rx_rings is always 1 in a kdump kernel.

rtl8169_request_irq() requests a handler for every vector up to and
including R8169_MAX_RX_QUEUES:

    for (i = 0; i < tp->irq_nvecs; i++) {
        napi = &tp->rtl8169_napi[i];
        ...
        if (tp->irq_nvecs > 1) {
            /* RX: 0~7, TX: 8*/
            if (i <= R8169_MAX_RX_QUEUES)
                rc = request_irq(irq, rtl8169_interrupt_msix,
                                 irqflags, dev->name, napi);

r8169_init_napi() calls netif_napi_add() only for i < num_rx_rings and
for index R8169_MAX_RX_QUEUES:

    for (i = 0; i < tp->num_rx_rings; i++) {
        netif_napi_add(tp->dev, &tp->rtl8169_napi[i],
                       rtl8169_poll_msix_rx);

That leaves rtl8169_napi[num_rx_rings..7] as zeroed kcalloc() memory with
napi->dev == NULL. If one of those vectors fires, rtl8169_interrupt_msix()
does:

    struct net_device *dev = napi->dev;
    ...
    tp = netdev_priv(dev);
    message_id = napi - tp->rtl8169_napi;

It then calls napi_schedule() on a napi that has no ->poll.

rtl_irq_enable() only sets ROK bits for queues below num_rx_rings. The
device might still signal these vectors, for example if the kernel that
ran before a kdump left vector-map events pending.

rtl8169_netpoll() and rtl8169_poll_msix_rx() already limit themselves to
num_rx_rings. Would it be safer for the request and free loops to skip
num_rx_rings <= i < R8169_MAX_RX_QUEUES as well?

> +
>  static int rtl_alloc_irq(struct rtl8169_private *tp)
>  {
>  	struct pci_dev *pdev = tp->pci_dev;
> @@ -5850,7 +6165,14 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>  		break;
>  	}
>  
> -	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
> +	nvecs = pci_alloc_irq_vectors(pdev, get_min_irq_nvecs(tp),
> +				      get_max_irq_nvecs(tp), flags);
> +
> +	if (nvecs < 0) {
> +		dev_info(&pdev->dev, "Failed to allocate %d MSI-X vectors.\n",
> +			 get_min_irq_nvecs(tp));
> +		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
> +	}

[Severity: Low]
On chips other than RTL_GIGA_MAC_VER_80, get_min_irq_nvecs() and
get_max_irq_nvecs() both return 1. The first call is then already
pci_alloc_irq_vectors(pdev, 1, 1, flags).

If that call fails, the driver logs "Failed to allocate 1 MSI-X vectors."
and repeats the identical request. On MAC_VER_02..17, flags is
PCI_IRQ_INTX, so MSI-X was never requested.

Should the message and the retry happen only when get_min_irq_nvecs(tp)
is greater than 1?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928070423.202-1-javen_xu%40realsil.com.cn
