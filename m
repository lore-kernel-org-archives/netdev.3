Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048FE4F93BC;
	Tue, 22 Sep 2026 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059984; cv=none; b=AgWIxMrnRX/BXvbgygGrMsMWJsM6z2069hVRLHgWh6n1z8E83bQ92rHx1aBCynvZ1RZDmNyJGODeNAZhPqo/9GT68i0VDWCIowkaF4dGUuJIlbvYmhvjLsVkItInjgdafxzbDfmLWJjMjPGXP/WkttMLGRlp3GDHj18q8ipZdqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059984; c=relaxed/simple;
	bh=LJcXZhIH+ezMTY4P6cxIJsjkg8bnyLIWpjpEB9W1oxA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NhAq/G0fELsnkjqNAaHKnPW2oQaC+DexypkqLOJ90iaZce3g1KJ9V9qMOxrCXnZl5V7sSdH5fnJA/Zk8bte0g4weINBUHhNaanlmPzVxsTDHTud+NdroBAXQkJr3q+3zCUdbX4vvM9WTcS74EdLr7yf23IGc0Zc34GlJeSp25+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5uSqydr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5uSqydr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5924B1F00893;
	Tue, 22 Sep 2026 06:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790059982;
	bh=pYR/te7RD6Aq8zKO9fqGxK9I2OTeDZvGuARbkTLE4Ak=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q5uSqydr3qPkCCiI6IBtY0mZhpPQwOUC/zWuQouLFoAUbJEf+OsHKekzB/Q0wTnmP
	 Oz6l23SnDTwidcWBSSUbcjZxgjFwctZA25QS52SOXqMf4F3LApd8v7LEmYsc7SxczJ
	 yECwVUIh0LZbU/7ev8SxiP9SAnbKi0P+1YmLy9LWiI+LInbp/aN5QrvVjg4vsKhz+y
	 dJJ76UYV0hyxB89C0uq1PxNTyt3Dbczz8OXcHSVZPqRp985seKx4FvbIJU4LNnkgFY
	 knniYVCrz92KC5iGmBBm9Ycq+cEBqWA3mbQw3vk2sKPkyJYEyge4cD3ROLayRoWz6r
	 NwQWuPCB7TcFg==
Subject: Re: [PATCH net-next v14 5/7] r8169: add support and enable rss
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 06:53:01 +0000
Message-ID: <179005998192.2160803.13913852634612357214@kernel.org>
In-Reply-To: <20260918061923.313-6-javen_xu@realsil.com.cn>
References: <20260918061923.313-6-javen_xu@realsil.com.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 5 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch silently bundles a fix for a pre-existing integer
  underflow in the chip-independent RX path into a feature commit.
- [Medium] The one-line commit message does not disclose the new IRQ
  allocation policy for RTL8127, which is all-or-nothing and consumes…
- [Medium] For the new RSS (v4) RX descriptor the patch re-declares the
  MAC error status bits shifted one position up relative to the legacy…
- [Medium] Packets received on the newly enabled RSS RX rings are handed
  to GRO without recording the receiving queue, so per-queue RPS/RFS…
- [Medium] The new minimum-length guard in rtl_rx() is too weak: it only
  rejects `pkt_size < ETH_FCS_LEN`, so a descriptor reporting exactly 4…

--

r8169: add support and enable rss

This patch adds RSS support for RTL8127 (RTL_GIGA_MAC_VER_80): a second RX
descriptor layout, an RSS key and indirection table, per-ring RX error
accounting and a new MSI-X vector allocation policy.  RSS is turned on by
default when enough MSI-X vectors are granted.  A few questions below.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index ec3643892fe2..ad360f145076 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -82,6 +82,19 @@
>  #define R8169_MAX_RX_QUEUES	8
>  #define R8169_DEFAULT_RX_QUEUES	1
>  #define R8169_MAX_TX_QUEUES	1
> +#define R8127_MAX_NUM_IRQVEC	32
> +#define R8127_MIN_NUM_IRQVEC	30
> +#define R8169_IRQ_DEFAULT	1
> +#define RTL_RSS_KEY_SIZE	40
> +#define RSS_CPU_NUM_MASK	GENMASK(18, 16)
> +#define RSS_HASH_MASK		GENMASK(10, 8)
> +#define RTL_MAX_INDIRECTION_TABLE_ENTRIES 128
> +#define RXS_RSS_UDP		BIT(27)
> +#define RXS_RSS_IPV4		BIT(28)
> +#define RXS_RSS_IPV6		BIT(29)
> +#define RXS_RSS_TCP		BIT(30)
> +#define RXS_RSS_L3_TYPE_MASK	(RXS_RSS_IPV4 | RXS_RSS_IPV6)
> +#define RXS_RSS_L4_TYPE_MASK	(RXS_RSS_TCP | RXS_RSS_UDP)
>  
>  #define OCP_STD_PHY_BASE	0xa400
>  
> @@ -506,6 +519,9 @@ enum rtl_register_content {
>  	RxRUNT	= (1 << 20),
>  	RxCRC	= (1 << 19),
>  
> +	RXRUNT_RSS	= (1 << 21),
> +	RXCRC_RSS	= (1 << 20),
> +
>  	/* ChipCmdBits */
>  	StopReq		= 0x80,
>  	CmdReset	= 0x10,

[ ... ]

> @@ -611,6 +627,20 @@ enum rtl_register_content {
>  #define	ISRIMR_LINKCHG	BIT(29)
>  #define	ISRIMR_TOK_Q0	BIT(8)
>  #define	ISRIMR_ROK_Q0	BIT(0)
> +#define RTL_DESC_TYPE_CTRL		0xd8
> +#define RSS_KEY_REG			0x4600
> +#define RSS_INDIRECTION_TBL_REG		0x4700
> +#define RSS_CTRL_TCP_IPV4_SUPP		BIT(0)
> +#define RTL_DESC_TYPE_RSS		BIT(1)
> +#define RSS_CTRL_IPV4_SUPP		BIT(1)
> +#define RSS_CTRL_TCP_IPV6_SUPP		BIT(2)
> +#define RSS_CTRL_IPV6_SUPP		BIT(3)
> +#define RSS_CTRL_IPV6_EXT_SUPP		BIT(4)
> +#define RSS_CTRL_TCP_IPV6_EXT_SUPP	BIT(5)
> +#define RSS_CTRL_UDP_IPV4_SUPP		BIT(11)
> +#define RSS_CTRL_UDP_IPV6_SUPP		BIT(12)
> +#define	RX_RES_RSS			BIT(22)
> +#define RTL_RX_Q_NUM_MASK		GENMASK(4, 2)
>  };

[ ... ]

> @@ -5093,28 +5299,91 @@ static inline int rtl8169_fragmented_frame(u32 status)

[ ... ]

>  static bool rtl8169_check_rx_desc_error(struct rtl8169_rx_ring *ring,
> +					struct rtl8169_private *tp,
>  					u32 status)
>  {
> -	if (unlikely(status & RxRES)) {
> -		u64_stats_update_begin(&ring->stats.syncp);
> -		if (status & (RxRWT | RxRUNT))
> -			ring->stats.rx_length_errors++;
> -		if (status & RxCRC)
> -			ring->stats.rx_crc_errors++;
> -		u64_stats_update_end(&ring->stats.syncp);
> -		return true;
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_TYPE_RSS:
> +		if (unlikely(status & RX_RES_RSS)) {
> +			u64_stats_update_begin(&ring->stats.syncp);
> +			if (status & RXRUNT_RSS)
> +				ring->stats.rx_length_errors++;
> +			if (status & RXCRC_RSS)
> +				ring->stats.rx_crc_errors++;
> +			u64_stats_update_end(&ring->stats.syncp);
> +			return true;
> +		}
> +		break;

[Severity: Medium]

The three v4 error bits are the legacy bits shifted up by one:

	RX_RES_RSS   = BIT(22)  vs  RxRES   = BIT(21)
	RXRUNT_RSS   = BIT(21)  vs  RxRUNT  = BIT(20)
	RXCRC_RSS    = BIT(20)  vs  RxCRC   = BIT(19)

Is there also a shifted counterpart of RxRWT (receive watchdog /
over-length, legacy BIT(22), so BIT(23) here)?  It is neither defined nor
tested anywhere in the patch, which leads to two differences on the RSS
path.

First, the RSS branch above never bumps ring->stats.rx_length_errors for a
watchdog/over-length error, while the default branch counts
status & (RxRWT | RxRUNT) as a length error, so rx_length_errors is fed by
two different bit maps depending on descriptor type.

Second, the rx-all bypass in rtl_rx() below drops an RWT frame
unconditionally on the legacy layout but not on the RSS layout:

	if (tp->init_rx_desc_type == RX_DESC_TYPE_DEFAULT) {
		if (status & RxRWT || !(status & (RxRUNT | RxCRC)))
			goto release_descriptor;
	} else {
		if (!(status & (RXRUNT_RSS | RXCRC_RSS)))
			goto release_descriptor;
	}

So a descriptor carrying the over-length bit together with a CRC or RUNT
error is delivered to the stack on RTL8127 but discarded on every other
chip.  Is that difference intended, or is the RWT equivalent simply missing
from the new bit definitions?

> @@ -5154,11 +5423,21 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
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
> +		if (unlikely(pkt_size < ETH_FCS_LEN))
> +			goto release_descriptor;
> +
>  		if (likely(!(dev->features & NETIF_F_RXFCS)))
>  			pkt_size -= ETH_FCS_LEN;

[Severity: Medium]

This guard is placed after the shared pkt_size = status & GENMASK(13, 0)
assignment, so it runs for RX_DESC_TYPE_DEFAULT as well.  At the baseline
the code was:

	pkt_size = status & GENMASK(13, 0);
	if (likely(!(dev->features & NETIF_F_RXFCS)))
		pkt_size -= ETH_FCS_LEN;

with no lower bound, so the pkt_size underflow was reachable on every
r8169/r8168/r8125 chip with rx-all enabled, not only on the new RTL8127 RSS
path.

The recorded commit message is only "This patch adds support and enable rss
for RTL8127." — the "fix an integer underflow in rtl_rx()" note lives below
the scissors line and is stripped from git history, and there is no Fixes:
tag or Cc: stable.

Would it make sense to split this hunk into its own patch with a Fixes: tag
so it can be found and backported on its own?

[Severity: Medium]

Is ETH_FCS_LEN a large enough lower bound here?  A descriptor reporting
exactly 4 gives a zero-length skb, and any reported length in 4..17 (or
4..13 with rx-fcs on) gives an skb shorter than ETH_HLEN, which is then
handed to eth_type_trans():

	skb_copy_to_linear_data(skb, rx_buf, pkt_size);
	skb->tail += pkt_size;
	skb->len = pkt_size;
	...
	skb->protocol = eth_type_trans(skb, dev);

eth_type_trans() uses eth_skb_pull_mac(), which ignores the NULL return of
skb_pull_inline() when ETH_HLEN > skb->len:

include/linux/etherdevice.h:
	static inline struct ethhdr *eth_skb_pull_mac(struct sk_buff *skb)
	{
		struct ethhdr *eth = (struct ethhdr *)skb->data;

		skb_pull_inline(skb, ETH_HLEN);
		return eth;
	}

so eth_skb_pkt_type() reads eth->h_dest and eth_type_trans() reads
eth->h_proto at offsets 0..13, while only pkt_size bytes were copied into a
head that napi_alloc_skb() does not zero.  Can skb->protocol, skb->pkt_type
and the ring->stats.multicast accounting then be derived from stale heap
bytes?

For an AF_PACKET listener those bytes also become visible, since
eth_header_parse() copies six source-MAC bytes with no length check:

net/ethernet/eth.c:
	const struct ethhdr *eth = eth_hdr(skb);

	memcpy(haddr, eth->h_source, ETH_ALEN);

and packet_recvmsg() returns them in sockaddr_ll.sll_addr.

Would testing for a complete Ethernet header be more appropriate here, for
example ETH_HLEN + ETH_FCS_LEN before the FCS adjustment?  Also, when this
goto fires no rx_dropped or rx_length_errors counter is updated, so the
frames disappear without accounting — is that intentional?

> @@ -5191,10 +5470,12 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  		skb->len = pkt_size;
>  		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
>  
> -		rtl8169_rx_csum(skb, status);
> +		if (tp->num_rx_rings > 1)
> +			rtl8169_rx_hash(tp, desc, skb);
> +		rtl8169_rx_csum(tp, skb, status);
>  		skb->protocol = eth_type_trans(skb, dev);

[Severity: Medium]

Should rtl_rx() also call skb_record_rx_queue() here?  The receiving ring is
known to the caller, rtl8169_poll_msix_rx() picks it from the MSI-X message
id and passes it to rtl_rx(), but no driver code records it before
napi_gro_receive().  git grep skb_record_rx_queue finds no hit in
r8169_main.c at the baseline, at this commit, or at the end of the series.

rtl_init_one() calls netif_set_real_num_queues(tp->dev, 1,
tp->num_rx_rings), so sysfs exposes rps_cpus and rps_flow_cnt for every
ring, but get_rps_cpu() only advances past rx-0 when the queue is recorded:

net/core/dev.c:get_rps_cpu() {
	struct netdev_rx_queue *rxqueue = dev->_rx;
	...
	if (skb_rx_queue_recorded(skb)) {
		u16 index = skb_get_rx_queue(skb);
	...
}

Does this mean per-queue rps_cpus settings on rx-1..rx-7 have no effect, and
the rx-0 setting is applied to traffic from all rings?  Setting the RSS hash
does not set skb->queue_mapping, so it doesn't substitute for the missing
call.

> @@ -5823,6 +6106,32 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
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
>  static int rtl_alloc_irq(struct rtl8169_private *tp)
>  {
>  	struct pci_dev *pdev = tp->pci_dev;
> @@ -5843,7 +6152,11 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>  		break;
>  	}
>  
> -	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
> +	nvecs = pci_alloc_irq_vectors(pdev, get_min_irq_nvecs(tp),
> +				      get_max_irq_nvecs(tp), flags);
> +
> +	if (nvecs < 0)
> +		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
>  
>  	if (nvecs < 0)
>  		return nvecs;

[Severity: Medium]

This makes the RTL8127 allocation all-or-nothing: 30 to 32 vectors, or a
single vector.  Are the extra reserved vectors used anywhere?
rtl8169_request_irq() only installs handlers for vectors up to
R8169_MAX_RX_QUEUES and for MSIX_ID_VEC_MAP_LINKCHG:

	for (i = 0; i < tp->irq_nvecs; i++) {
		...
			if (i <= R8169_MAX_RX_QUEUES)
				rc = request_irq(irq, rtl8169_interrupt_msix, ...);
			else if (i == MSIX_ID_VEC_MAP_LINKCHG)
				rc = request_irq(irq, rtl8169_interrupt_other, ...);
			else
				continue;

so 21 to 23 of the reserved vectors end up with no handler, and the
kcalloc() of napi structures is sized by tp->irq_nvecs as well.

Both downgrades are also silent.  If the platform cannot supply 30 vectors
the fallback to (1, 1) leaves num_rx_rings at 1 and init_rx_desc_type at
RX_DESC_TYPE_DEFAULT with no message.  On a 2 or 3 CPU machine
rounddown_pow_of_two(min(netif_get_num_default_rss_queues(),
hw_supp_num_rx_queues)) can be 1, so RSS stays off while 30 to 32 vectors
remain reserved.

Would a dev_info() on those paths help, and should the requested count match
the number of vectors the driver actually hooks up?

The one-line commit message does not describe this new allocation policy at
all — could it be mentioned there?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918061923.313-1-javen_xu%40realsil.com.cn
