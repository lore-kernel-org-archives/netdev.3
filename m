Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F524F054E;
	Tue, 22 Sep 2026 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059983; cv=none; b=TBon3o9OVVmiyvdtgwya6kg5DeYjXM3neIQPJwBTjAKShxuT6LjgWWbhSB0XojZo82nbaM1suLiEVLKOL1inZyfYZGNaF9bUNZrxVPSoJcXt4IFZlZDDYYYvElBuHI2pfSrn4XwmEqH0xkRN7B/X+qlqXjVa4M5RccT7lkdq6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059983; c=relaxed/simple;
	bh=hvocuWtClhAlKTK7VSorkWAD+X2eLJy/yKOAz5Vwa60=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dqvRp1od34puYlWRAfWw9uTJcMVz9UlMqx2XDnHEfmrW+n+In2UuixbQVIYQHlvZeMznCqPqW/RjVxuMTyzN4jte+Wcp3iuXwSMVa2lGy2gL1bMdfeSTflA5RBgo1l2LiqyTcp6AWdt5bxhZBW3eK3BpSEc8VmSeMvp8fSYhkfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyc10dS9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyc10dS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3347C1F00899;
	Tue, 22 Sep 2026 06:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790059981;
	bh=Y+oQ3XvZb57MeMwTkbBqsuU6UHJUQMrO8Pl5vDeHt0I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kyc10dS9ELq10lzJmHB+bWdRPmLJx0L1rT09jyewGYp4ipRvix6tvFR1cbNu9+whq
	 +RSClJvGtZR6Imny4ReqoCNlBG0V8ziWaPufAgt46bs4PH8GRft7U9SP5nA2hoHRnD
	 f7AFofvJFEjQl60brPT7RB4LyFiSpRrsczIIz8KjxhtRlrAYoHIKBjyfy+jNkvsIO4
	 PkYi67ZyTgXr2Fv1weF9xpQT23j5YdVj77tv1b3vrSHAlcLapgTAh9O0rRhi3+MYWa
	 4MPL+wR82qKWjNBowGfbjl7dxeAD1WmWClges8CpWgT5ozO9Oezos696w3+hFKah5T
	 KidN7LrhwG2qg==
Subject: Re: [PATCH net-next v14 4/7] r8169: enable new interrupt mapping
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 06:53:00 +0000
Message-ID: <179005998078.2160803.538063464563531558@kernel.org>
In-Reply-To: <20260918061923.313-5-javen_xu@realsil.com.cn>
References: <20260918061923.313-5-javen_xu@realsil.com.cn>
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

- [Low] In `rtl_hw_start_8125_common()`
  (drivers/net/ethernet/realtek/r8169_main.c:4114) the patch adds `if…
- [Low] The second half of this patch converts RX error/drop/multicast
  accounting in `rtl_rx()` and `rtl8169_check_rx_desc_error()` from…

Pre-existing issues:
- [Medium] In `rtl_rx()` (drivers/net/ethernet/realtek/r8169_main.c), the
  fragmented-frame path increments the new per-ring `rx_dropped` and…

--

r8169: enable new interrupt mapping

This patch adds rtl8169_hw_enable_vec_mapping() and calls it from
rtl_hw_start_8125_common() when more than one IRQ vector is in use.  It
also moves the RX error, drop and multicast accounting from dev->stats
into new per-ring u64_stats counters aggregated in rtl8169_get_stats64().

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index c647b4327ff7..ec3643892fe2 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -768,6 +769,15 @@ struct rtl8169_rx_ring {
>  	dma_addr_t rx_desc_phy_addr[NUM_RX_DESC];
>  	dma_addr_t rx_phy_addr;
>  	struct page *rx_databuff[NUM_RX_DESC];
> +
> +	struct {
> +		u64 rx_errors;
> +		u64 rx_dropped;
> +		u64 rx_length_errors;
> +		u64 rx_crc_errors;
> +		u64 multicast;
> +		struct u64_stats_sync syncp;
> +	} stats;
>  };

[Severity: Low]
This isn't a bug, but does the commit message match what this half of the
patch does?  The message says "add error pkts counter per ring", while
rx_dropped and multicast are not error counters.

Also, rtl_setup_rx_params() still does:

	tp->num_rx_rings = 1;

so the per-ring aspect has no effect until "r8169: add support and enable
rss" raises num_rx_rings.  Would it be clearer to split this accounting
migration into its own patch, or at least describe the full set of
counters and the reason for moving them off dev->stats?

[ ... ]

> @@ -4084,6 +4094,15 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
>  	return r8168_mac_ocp_read(tp, 0xe00e) & BIT(13);
>  }
>  
> +static void rtl8169_hw_enable_vec_mapping(struct rtl8169_private *tp)
> +{
> +	u8 tmp;
> +
> +	tmp = RTL_R8(tp, INT_CFG0_8125);
> +	tmp |= INT_CFG0_ENABLE_8125;
> +	RTL_W8(tp, INT_CFG0_8125, tmp);
> +}
> +
>  static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>  {
>  	rtl_pcie_state_l2l3_disable(tp);
> @@ -4092,6 +4111,9 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>  	RTL_W32(tp, RSS_CTRL_8125, 0);
>  	RTL_W16(tp, Q_NUM_CTRL_8125, 0);
>  
> +	if (tp->irq_nvecs > 1)
> +		rtl8169_hw_enable_vec_mapping(tp);
> +

[Severity: Low]
Can this branch be taken at this commit?  The only writer of
tp->irq_nvecs is rtl_alloc_irq(), which still does:

	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);

	if (nvecs < 0)
		return nvecs;

	tp->irq_nvecs = nvecs;

With min_vecs == max_vecs == 1, tp->irq_nvecs can only be 1 here, so
INT_CFG0_ENABLE_8125 is never written and the MSI-X paths in
rtl8169_request_irq(), rtl8169_free_one_irq() and r8169_init_napi()
stay unreachable as well.

The later patch in this series, "r8169: add support and enable rss",
switches rtl_alloc_irq() to pci_alloc_irq_vectors(pdev,
get_min_irq_nvecs(tp), get_max_irq_nvecs(tp), flags), which is what
makes the gate satisfiable, so this looks like prerequisite work rather
than dead code.  Could the changelog say that the mapping is only
actually enabled once the RSS patch lands, instead of stating that this
commit "enables new interrupt mapping for RTL8127"?

[ ... ]

> @@ -5121,11 +5144,13 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  		 */
>  		dma_rmb();
>  
> -		if (rtl8169_check_rx_desc_error(dev, tp, status)) {
> +		if (rtl8169_check_rx_desc_error(ring, status)) {
>  			if (net_ratelimit())
>  				netdev_warn(dev, "Rx ERROR. status = %08x\n",
>  					    status);
> -			dev->stats.rx_errors++;
> +			u64_stats_update_begin(&ring->stats.syncp);
> +			ring->stats.rx_errors++;
> +			u64_stats_update_end(&ring->stats.syncp);
>  
>  			if (!(dev->features & NETIF_F_RXALL))
>  				goto release_descriptor;
> @@ -5141,14 +5166,18 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  		 * They are seen as a symptom of over-mtu sized frames.
>  		 */
>  		if (unlikely(rtl8169_fragmented_frame(status))) {
> -			dev->stats.rx_dropped++;
> -			dev->stats.rx_length_errors++;
> +			u64_stats_update_begin(&ring->stats.syncp);
> +			ring->stats.rx_dropped++;
> +			ring->stats.rx_length_errors++;
> +			u64_stats_update_end(&ring->stats.syncp);
>  			goto release_descriptor;
>  		}

[Severity: Medium]
This is a pre-existing imbalance and not something introduced here, but
since the counters are being reworked anyway: should rx_errors be bumped
on this path too?

rx_errors is only incremented when rtl8169_check_rx_desc_error() sees
RxRES set, while the fragmented-frame path increments rx_length_errors
alone.  The kernel-doc for struct rtnl_link_stats64 in
include/uapi/linux/if_link.h says rx_errors is the total of the detailed
receive error counters, including rx_length_errors.

If the hardware can hand up a descriptor without FirstFrag/LastFrag while
RxRES is clear, userspace would see rx_length_errors climb with no
matching rx_errors.  Can that descriptor combination occur on these
chips?

> @@ -5574,6 +5606,27 @@ rtl8169_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>  	netdev_stats_to_stats64(stats, &dev->stats);
>  	dev_fetch_sw_netstats(stats, dev->tstats);
>  
> +	for (int i = 0; i < tp->num_rx_rings; i++) {
> +		u64 errors, dropped, length_errors, crc_errors, multicast;
> +		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
> +		unsigned int start;
> +
> +		do {
> +			start = u64_stats_fetch_begin(&ring->stats.syncp);
> +			errors = ring->stats.rx_errors;
> +			dropped = ring->stats.rx_dropped;
> +			length_errors = ring->stats.rx_length_errors;
> +			crc_errors = ring->stats.rx_crc_errors;
> +			multicast = ring->stats.multicast;
> +		} while (u64_stats_fetch_retry(&ring->stats.syncp, start));
> +
> +		stats->rx_errors += errors;
> +		stats->rx_dropped += dropped;
> +		stats->rx_length_errors += length_errors;
> +		stats->rx_crc_errors += crc_errors;
> +		stats->multicast += multicast;
> +	}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918061923.313-1-javen_xu%40realsil.com.cn
