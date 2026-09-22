Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909434EFFB3;
	Tue, 22 Sep 2026 06:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059981; cv=none; b=c9N/pTEGBsMnLPpOpObN1QD3DlOWepgexM8XAMjEy9mPWHOHFDezC4i3o8GzMsmtLpoMSbGLp1QcNGri10h1RvvOMOZFAiVKovMM0xWTYmBSCrMjwLWrWdVr9aoB7UfveA8ZH0NvtxsX/vTHe7Vp5FunYjKVp1i3h01ttC3yZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059981; c=relaxed/simple;
	bh=go2u5q2dSJ3V0Ao/eUtvHKtCRa6JnBVWMR3hv9Jenok=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FowRObGqZm1BIBntADJ95aeGZQUrYY1BLkNzgwqBFkCwV1xcUrGq+3b9I27KdQX293kmtk7BeHgeF0NkQb03j9xhEq4G0Cjn1lBqXzV6hNVVqU0OyIF5XAot4gRQ8kzQJKsWfzmnWqHqfursByhIc+PI9g6t9oLgc3lQUXwbbD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4gHTQcy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4gHTQcy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41C71F00893;
	Tue, 22 Sep 2026 06:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790059979;
	bh=GUvj9RxdFQdrb6GGbJkh5JU6bX0IL/KD5hEZq03Xd4c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h4gHTQcyxxi0hZ0lerbX9821QvLfDMPkzdKsFdIEoVBtXZgzBMHKUL085Y4Q2r7N+
	 FTL8zVJe4obG32ETFnNCuymRrQA0IKugt2eoPelMWULose+kjLoIhBeemif9efWX8h
	 5qC2e156KsHpy8LqROI38bakywceWio1S/+95a9IqupxLtej/t9+ExT0NBssgdDdzP
	 xnGGLqUh5mrJepeSpaRAoNUc8oXGIdwsdLPcdDha3bL0wgs/M7SFzVq/3mnCY8Ay/B
	 nXlqihPu2lO1IB9KLSoKK85BBUJe5S/B5B3h4Lpyo4ti4L076KKsL0g2WlvBIrpx8z
	 kBVIRaXs3tJvg==
Subject: Re: [PATCH net-next v14 2/7] r8169: refactor RX path to prepare for
 multi-queue
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 06:52:58 +0000
Message-ID: <179005997833.2160803.11638220941043197221@kernel.org>
In-Reply-To: <20260918061923.313-3-javen_xu@realsil.com.cn>
References: <20260918061923.313-3-javen_xu@realsil.com.cn>
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

- [Low] Queue-count contract mismatch: rtl_init_one() allocates the
  netdev with a hard-coded 8 RX queues (devm_alloc_etherdev_mqs(...,…
- [Low] The patch adds a new 2 KB-per-ring shadow array `dma_addr_t
  rx_desc_phy_addr[NUM_RX_DESC]` to struct rtl8169_rx_ring and switches…
- [Low] Unrelated churn in a refactor-only patch: rtl8169_rx_csum()'s
  prototype is re-wrapped across two lines with byte-identical…

Pre-existing issues:
- [Low] In rtl_rx(), `pkt_size = status & GENMASK(13, 0)` followed by an
  unguarded `pkt_size -= ETH_FCS_LEN` (when NETIF_F_RXFCS is clear) can…

--

r8169: refactor RX path to prepare for multi-queue

This patch introduces struct rtl8169_rx_ring and moves the RX ring state
out of rtl8169_private into a per-queue array, switching the netdev
allocation to devm_alloc_etherdev_mqs() with room for 8 RX queues.  The
number of active RX rings stays at 1 for now.

A few questions below.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index a8214c48a775..7a2e7ce56e48 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -74,9 +74,13 @@
>  #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
>  #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
>  #define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
> +
>  #define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
>  #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
>  #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
> +#define R8169_MAX_RX_QUEUES	8
> +#define R8169_DEFAULT_RX_QUEUES	1
> +#define R8169_MAX_TX_QUEUES	1
>  
>  #define OCP_STD_PHY_BASE	0xa400
>  

[ ... ]

> @@ -750,6 +755,14 @@ enum rtl_dash_type {
>  	RTL_DASH_25_BP,
>  };
>  
> +struct rtl8169_rx_ring {
> +	u32 cur_rx;
> +	struct RxDesc *rx_desc_array;
> +	dma_addr_t rx_desc_phy_addr[NUM_RX_DESC];
> +	dma_addr_t rx_phy_addr;
> +	struct page *rx_databuff[NUM_RX_DESC];
> +};
> +

[Severity: Low]
The commit message describes this as turning "the previously embedded RX
state in rtl8169_private into a per-queue array", but rx_desc_phy_addr[]
is not moved state, it is new state (2 KB per ring on 64-bit), and it
comes with a new invariant: rtl8169_alloc_rx_data() writes it next to
desc->addr, rtl8169_rx_clear() unmaps from it and then zeroes it, and
rtl_rx() now trusts it instead of reading the descriptor back.

The reason for no longer reading the address out of the descriptor
appears only in the v8 changelog below the "---" line, which is not kept
in git history.

Could the commit message gain a sentence describing the new shadow array
and why the descriptor read-back is dropped?

>  enum rtl_sfp_mode {
>  	RTL_SFP_NONE,
>  	RTL_SFP_8168_AF,
> @@ -764,20 +777,18 @@ struct rtl8169_private {
>  	enum mac_version mac_version;
>  	enum rtl_dash_type dash_type;
>  	enum rtl_sfp_mode sfp_mode;
> -	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
>  	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
>  	u32 dirty_tx;
>  	struct TxDesc *TxDescArray;	/* 256-aligned Tx descriptor ring */
> -	struct RxDesc *RxDescArray;	/* 256-aligned Rx descriptor ring */
>  	dma_addr_t TxPhyAddr;
> -	dma_addr_t RxPhyAddr;
> -	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
>  	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
>  	struct napi_struct *rtl8169_napi;
> +	struct rtl8169_rx_ring *rx_ring;
>  	unsigned int num_rx_rings;
>  	u16 cp_cmd;
>  	u16 tx_lpi_timer;
>  	u32 irq_mask;
> +	unsigned int hw_supp_num_rx_queues;
>  	unsigned int irq_nvecs;
>  	struct clk *clk;
>  	int speed;

[ ... ]

> @@ -2773,6 +2800,14 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
>  static void rtl_setup_rx_params(struct rtl8169_private *tp)
>  {
>  	tp->num_rx_rings = 1;
> +	switch (tp->mac_version) {
> +	case RTL_GIGA_MAC_VER_80:
> +		tp->hw_supp_num_rx_queues = R8169_MAX_RX_QUEUES;
> +		break;
> +	default:
> +		tp->hw_supp_num_rx_queues = R8169_DEFAULT_RX_QUEUES;
> +		break;
> +	}
>  }

[ ... ]

> @@ -4941,7 +5048,8 @@ static inline int rtl8169_fragmented_frame(u32 status)
>  	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
>  }
>  
> -static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
> +static inline void rtl8169_rx_csum(struct sk_buff *skb,
> +				   u32 opts1)
>  {
>  	u32 status = opts1 & (RxProtoMask | RxCSFailMask);
>  
> @@ -4951,15 +5059,30 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
>  		skb_checksum_none_assert(skb);
>  }
>  
> +static bool rtl8169_check_rx_desc_error(struct net_device *dev,
> +					struct rtl8169_private *tp,
> +					u32 status)
> +{
> +	if (unlikely(status & RxRES)) {
> +		if (status & (RxRWT | RxRUNT))
> +			dev->stats.rx_length_errors++;
> +		if (status & RxCRC)
> +			dev->stats.rx_crc_errors++;
> +		return true;
> +	}
> +	return false;
> +}
> +

[Severity: Low]
These aren't bugs, but two bits of churn here look unrelated to the
per-queue RX refactor.

The rtl8169_rx_csum() prototype is re-wrapped onto two lines with the
same two parameters, so it is a whitespace-only change.  Could it be
folded into the later patch that actually adds a parameter to it?

rtl8169_check_rx_desc_error() takes a struct rtl8169_private *tp that is
never dereferenced in its body at this commit.  Would it be cleaner to
add the tp argument in the patch that starts using it?

>  static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
> -		  int budget, struct napi_struct *napi)
> +		  struct rtl8169_rx_ring *ring, int budget,
> +		  struct napi_struct *napi)
>  {
>  	struct device *d = tp_to_dev(tp);
>  	int count;
>  
> -	for (count = 0; count < budget; count++, tp->cur_rx++) {
> -		unsigned int pkt_size, entry = tp->cur_rx % NUM_RX_DESC;
> -		struct RxDesc *desc = tp->RxDescArray + entry;
> +	for (count = 0; count < budget; count++, ring->cur_rx++) {
> +		unsigned int pkt_size, entry = ring->cur_rx % NUM_RX_DESC;
> +		struct RxDesc *desc = ring->rx_desc_array + entry;
>  		struct sk_buff *skb;
>  		const void *rx_buf;
>  		dma_addr_t addr;
> @@ -4975,15 +5098,11 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  		 */
>  		dma_rmb();
>  
> -		if (unlikely(status & RxRES)) {
> +		if (rtl8169_check_rx_desc_error(dev, tp, status)) {
>  			if (net_ratelimit())
>  				netdev_warn(dev, "Rx ERROR. status = %08x\n",
>  					    status);
>  			dev->stats.rx_errors++;
> -			if (status & (RxRWT | RxRUNT))
> -				dev->stats.rx_length_errors++;
> -			if (status & RxCRC)
> -				dev->stats.rx_crc_errors++;
>  
>  			if (!(dev->features & NETIF_F_RXALL))
>  				goto release_descriptor;

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch, but
since the surrounding error filter is being touched here it may be worth
a look.  With NETIF_F_RXALL set, a short descriptor can reach the length
computation just below:

	pkt_size = status & GENMASK(13, 0);
	if (likely(!(dev->features & NETIF_F_RXFCS)))
		pkt_size -= ETH_FCS_LEN;

Can pkt_size wrap here when the descriptor reports fewer than
ETH_FCS_LEN bytes?  pkt_size is unsigned, so the subtraction would leave
a huge value that is then handed to napi_alloc_skb(),
dma_sync_single_for_cpu() and skb_copy_to_linear_data().

The same code is present in the pre-series baseline, and a guard

	if (unlikely(pkt_size < ETH_FCS_LEN))
		goto release_descriptor;

does appear later in this series in "r8169: add support and enable rss".
Would it make sense to move that guard into a separate fix ahead of the
refactor?

> @@ -5010,8 +5129,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  			goto release_descriptor;
>  		}
>  
> -		addr = le64_to_cpu(desc->addr);
> -		rx_buf = page_address(tp->Rx_databuff[entry]);
> +		addr = ring->rx_desc_phy_addr[entry];
> +		rx_buf = page_address(ring->rx_databuff[entry]);
>  
>  		dma_sync_single_for_cpu(d, addr, pkt_size, DMA_FROM_DEVICE);
>  		prefetch(rx_buf);

[ ... ]

> @@ -6106,7 +6222,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	u32 txconfig;
>  	u32 xid;
>  
> -	dev = devm_alloc_etherdev(&pdev->dev, sizeof (*tp));
> +	dev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(*tp),
> +				      R8169_MAX_TX_QUEUES,
> +				      R8169_MAX_RX_QUEUES);
> +
>  	if (!dev)
>  		return -ENOMEM;
>  

[Severity: Low]
There are three different RX queue counts in play after this patch, and
they do not agree.  Is that intentional?

The netdev is allocated with R8169_MAX_RX_QUEUES (8) struct
netdev_rx_queue slots for every supported chip, including the ones for
which rtl_setup_rx_params() then sets hw_supp_num_rx_queues to
R8169_DEFAULT_RX_QUEUES (1).

hw_supp_num_rx_queues itself has no reader in this patch; it is only
written in rtl_setup_rx_params().  Its first users
(rtl8169_set_rx_ring_num() and rtl8169_get_channels()) arrive in later
patches of the series.

The user-visible count is clamped back down later in rtl_init_one():

	rc = netif_set_real_num_queues(tp->dev, 1, tp->num_rx_rings);

so only rx-0 is exposed.  Since tp->mac_version is not known until the
MMIO BAR is mapped, allocating for the hardware maximum looks like the
only possible ordering; would a short comment at the
devm_alloc_etherdev_mqs() call saying so help?

> @@ -6295,20 +6414,25 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		}
>  	}
>  
> +	tp->rx_ring = kcalloc(tp->num_rx_rings, sizeof(struct rtl8169_rx_ring),
> +			      GFP_KERNEL);
> +	if (!tp->rx_ring) {
> +		rc = -ENOMEM;
> +		goto err_destory_phylink;
> +	}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918061923.313-1-javen_xu%40realsil.com.cn
