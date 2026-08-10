Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8DB332629;
	Mon, 10 Aug 2026 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786397908; cv=none; b=KQOfDeA0J/T0Rg4NWtLjlgRv9RQS8nJ6yVi0vrCuuRu7rlBFKobht6J2328V8+Q0m2QmncWDUlW6I2f6HVdVZZuS1xlSrDBiz3tfA8/3TTXEGoqA26SBguSfXg/buW1oi42DkU6ybQYJwp8YQNQGsADWPOp61CH6n/hrHjosq2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786397908; c=relaxed/simple;
	bh=HFGnKGda9gR1+hzILFPCVnntIo5vN/pTgarRug1jWWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AeQ6r3CrqrrMKf+HOBcV3n4CPrt3cvxgJdrp38jaCFmg/k/6zcd0ypbih7fxilkzm/BdbsuMA2xC6Yzb5y/ALbBkyQMVhUDJxin1Shp+1BrL5UGyMOxEBV4M96coJz84sXXzJBc1pJki+mdGENrOq+Xo18VCPSpc/7fRw0CLqFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSKJiHfp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSKJiHfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E634F1F000E9;
	Mon, 10 Aug 2026 21:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786397906;
	bh=kEzd6SbOojD8COAqBMxF1qKlUm6B57X4Sb6IFRPb2E8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iSKJiHfpjHtZiJ9/0hev4nqpbbiXALwMhUyRDXW9+aOkUR0g3ZorT9iKw8KZhrNs1
	 OpSdkn0rrC1rC7WUijSL0m/Iqjbc1xEdMwu6WBQX0Bt40SHUdHs7ptueIjBH74zjqp
	 ukMmaK1U2rYoVYkcGBy9wTLjZ40ZqCIC0E/9yD0ekvJ13x31PzGpZwHJfmjpWZoHjw
	 ld5pzsKfnJkQJXewjTyOuH7ZVliTBZZFrPVJ1L9lv7OT4kajYI/iQM/RttBmbtRARg
	 b/kHv8JMrF1i0vzLbl7zVlSiIscYq7cisSJAhMUFYI8NULvpttcbTdHVnrFaZNiLY8
	 oo6L64WEuMa7w==
Date: Mon, 10 Aug 2026 14:38:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v10 5/7] r8169: add support and enable rss
Message-ID: <20260810143825.28a3d516@kernel.org>
In-Reply-To: <20260803021305.488-6-javen_xu@realsil.com.cn>
References: <20260803021305.488-1-javen_xu@realsil.com.cn>
	<20260803021305.488-6-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Aug 2026 10:13:03 +0800 javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support and enable rss for RTL8127.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - some changes moved from Patch 2/7
> 
> Changes in v3:
>  - add struct rtl8169_rss_data. Allocate it dynamically when needed.
>  - define rss_key as an u32 array
>  - replace some magic bit numbers in rtl8169_set_rss_hash_opt() and
>    rtl8125_set_rx_q_num()
>  - use union to combine different rx descriptor, refactor struct RxDesc
>  - remove dead code from rtl8169_double_check_rss_support()
> 
> Changes in v4:
>  - rename macro definition, e.g R8127_MAX_IRQ to R8127_MAX_NUM_IRQVEC
>  - change hw_supp_indir_tbl_entries type to unsigned int
>  - change init_rx_desc_type type to enum
>  - remove rtl_check_rss_support(), add helper function
>    rtl_hw_support_rss()
>  - remove hw_curr_isr_ver, use irq_nvecs to judge whether we should
>    enable vector interrupt mapping, use tp->num_rx_ring to judge whether
>    we should enable rss
>  - remove function rtl8169_double_check_rss_support(), use
>    rtl8169_set_rx_ring_num() to set num_rx_ring according to tp->irq_nvecs
> 
> Changes in v5:
>  - no changes
> 
> Changes in v6:
>  - change rss_queue_num type from u8 to unsigned int
>  - fix rx desc clear in rtl8169_rx_clear() for different desc type
>  - clamping num_rx_ring with rounddown_pow_of_two()
> 
> Changes in v7:
>  - remove unused macro
>  - change unfixed type in rtl8169_store_reta
> 
> Changes in v8:
>  - refill desc->addr when rx_desc reset
>  - rtl8169_set_channels fixed in patch 7/7
> 
> Changes in v9:
>  - remove rtl8169_set_desc_dma_addr, only set desc dma addr for
>    RX_DESC_TYPE_RSS desc
> 
> Changes in v10:
> - Change rss_key to u8 array and write rss_key_reg as u32 values.
>    Use get_unaligned_le32() to keep behavior consistent on big-endian
>    and little-endian
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 379 ++++++++++++++++++++--
>  1 file changed, 346 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 31f6d0c2e3d1..4e571fcea092 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -88,6 +88,19 @@
>  #define R8127_MAX_TX_QUEUES	8
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
> @@ -595,6 +608,20 @@ enum rtl_register_content {
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
> +#define	RX_RES_RSS			BIT(22)
> +#define	RX_RUNT_RSS			BIT(21)
> +#define	RX_CRC_RSS			BIT(20)
> +#define RTL_RX_Q_NUM_MASK		GENMASK(4, 2)
>  };
>  
>  enum rtl_desc_bit {
> @@ -652,6 +679,11 @@ enum rtl_rx_desc_bit {
>  #define RxProtoIP	(PID1 | PID0)
>  #define RxProtoMask	RxProtoIP
>  
> +#define	RX_UDPT_DESC_RSS	BIT(19)
> +#define	RX_TCPT_DESC_RSS	BIT(18)
> +#define	RX_UDPF_DESC_RSS	BIT(16) /* UDP/IP checksum failed */
> +#define	RX_TCPF_DESC_RSS	BIT(15) /* TCP/IP checksum failed */
> +
>  	IPFail		= (1 << 16), /* IP checksum failed */
>  	UDPFail		= (1 << 15), /* UDP/IP checksum failed */
>  	TCPFail		= (1 << 14), /* TCP/IP checksum failed */
> @@ -673,9 +705,27 @@ struct TxDesc {
>  };
>  
>  struct RxDesc {
> -	__le32 opts1;
> -	__le32 opts2;
> -	__le64 addr;
> +	union {
> +		/* RX_DESC_TYPE_DEFAULT */
> +		struct {
> +			__le32 opts1;
> +			__le32 opts2;
> +			__le64 addr;
> +		};
> +
> +		/* RX_DESC_TYPE_RSS */
> +		struct {
> +			union {
> +				__le64 rss_addr;
> +				struct {
> +					__le32 rss_info;
> +					__le32 rss_result;
> +				} rss_dword;
> +			};
> +			__le32 rss_opts2;
> +			__le32 rss_opts1;
> +		};
> +	};
>  };
>  
>  struct ring_info {
> @@ -747,6 +797,11 @@ enum rtl_dash_type {
>  	RTL_DASH_25_BP,
>  };
>  
> +enum rx_desc_type {
> +	RX_DESC_TYPE_DEFAULT,
> +	RX_DESC_TYPE_RSS,
> +};
> +
>  struct rtl8169_rx_ring {
>  	u32 cur_rx;					/* Index of next Rx pkt. */
>  	u32 dirty_rx;					/* Index for recycling. */
> @@ -756,6 +811,12 @@ struct rtl8169_rx_ring {
>  	struct page *rx_databuff[NUM_RX_DESC];		/* Rx data buffers */
>  };
>  
> +struct rtl8169_rss_data {
> +	u8 rss_key[RTL_RSS_KEY_SIZE];
> +	u8 rss_indir_tbl[RTL_MAX_INDIRECTION_TABLE_ENTRIES];
> +	unsigned int hw_supp_indir_tbl_entries;
> +};
> +
>  struct rtl8169_private {
>  	void __iomem *mmio_addr;	/* memory map physical address */
>  	struct pci_dev *pci_dev;
> @@ -775,7 +836,9 @@ struct rtl8169_private {
>  	u16 tx_lpi_timer;
>  	u32 irq_mask;
>  	unsigned int hw_supp_num_rx_queues;
> +	struct rtl8169_rss_data *rss_data;
>  	unsigned int irq_nvecs;
> +	enum rx_desc_type init_rx_desc_type;
>  	struct clk *clk;
>  
>  	struct {
> @@ -1605,6 +1668,11 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static bool rtl_hw_support_rss(struct rtl8169_private *tp)
> +{
> +	return tp->mac_version == RTL_GIGA_MAC_VER_80;
> +}
> +
>  static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
>  {
>  	switch (tp->mac_version) {
> @@ -1906,9 +1974,20 @@ static inline u32 rtl8169_tx_vlan_tag(struct sk_buff *skb)
>  		TxVlanTag | swab16(skb_vlan_tag_get(skb)) : 0x00;
>  }
>  
> -static void rtl8169_rx_vlan_tag(struct RxDesc *desc, struct sk_buff *skb)
> +static void rtl8169_rx_vlan_tag(struct rtl8169_private *tp,
> +				struct RxDesc *desc,
> +				struct sk_buff *skb)
>  {
> -	u32 opts2 = le32_to_cpu(desc->opts2);
> +	u32 opts2;
> +
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_TYPE_RSS:
> +		opts2 = le32_to_cpu(desc->rss_opts2);
> +		break;
> +	default:
> +		opts2 = le32_to_cpu(desc->opts2);
> +		break;
> +	}
>  
>  	if (opts2 & RxVlanTag)
>  		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), swab16(opts2 & 0xffff));
> @@ -2736,17 +2815,27 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
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
> +
>  static void rtl_setup_rx_params(struct rtl8169_private *tp)
>  {
>  	tp->num_rx_rings = 1;
>  	switch (tp->mac_version) {
>  	case RTL_GIGA_MAC_VER_80:
>  		tp->hw_supp_num_rx_queues = R8169_MAX_RX_QUEUES;
> +		tp->rss_data->hw_supp_indir_tbl_entries = RTL_MAX_INDIRECTION_TABLE_ENTRIES;
>  		break;
>  	default:
>  		tp->hw_supp_num_rx_queues = R8169_DEFAULT_RX_QUEUES;
>  		break;
>  	}
> +	tp->init_rx_desc_type = RX_DESC_TYPE_DEFAULT;
>  }
>  
>  static void rtl_request_firmware(struct rtl8169_private *tp)
> @@ -2871,6 +2960,58 @@ static void rtl_set_rx_max_size(struct rtl8169_private *tp)
>  	RTL_W16(tp, RxMaxSize, R8169_RX_BUF_SIZE + 1);
>  }
>  
> +static void rtl8169_store_rss_key(struct rtl8169_private *tp)
> +{
> +	u8 *rss_key = tp->rss_data->rss_key;
> +	const u16 rss_key_reg = RSS_KEY_REG;
> +
> +	/* Write redirection table to HW */
> +	for (int i = 0; i < RTL_RSS_KEY_SIZE; i += sizeof(u32))
> +		RTL_W32(tp, rss_key_reg + i, get_unaligned_le32(rss_key + i));

you fetched packed word of the key with get_unaligned_le32()..

> +}
> +
> +static void rtl8169_store_reta(struct rtl8169_private *tp)
> +{
> +	u8 *indir_tbl = tp->rss_data->rss_indir_tbl;
> +	unsigned int i;
> +
> +	/* Write redirection table to HW */
> +	for (i = 0; i < tp->rss_data->hw_supp_indir_tbl_entries; i += 4) {
> +		u32 reta = (u32)indir_tbl[i] |
> +			   (u32)indir_tbl[i + 1] << 8 |
> +			   (u32)indir_tbl[i + 2] << 16 |
> +			   (u32)indir_tbl[i + 3] << 24;

.. but the indir table you pack manually, why?

> +		RTL_W32(tp, RSS_INDIRECTION_TBL_REG + i, reta);
> +	}
> +}
> +
> +static void rtl8169_set_rss_hash_opt(struct rtl8169_private *tp)
> +{
> +	u32 rss_ctrl;
> +
> +	rss_ctrl = FIELD_PREP(RSS_CPU_NUM_MASK, ilog2(tp->num_rx_rings));
> +
> +	/* Perform hash on these packet types */
> +	rss_ctrl |= RSS_CTRL_TCP_IPV4_SUPP
> +		 | RSS_CTRL_IPV4_SUPP
> +		 | RSS_CTRL_IPV6_SUPP
> +		 | RSS_CTRL_IPV6_EXT_SUPP
> +		 | RSS_CTRL_TCP_IPV6_SUPP
> +		 | RSS_CTRL_TCP_IPV6_EXT_SUPP;

| should be at the end of the lines

> +	rss_ctrl |= FIELD_PREP(RSS_HASH_MASK,
> +			       ilog2(tp->rss_data->hw_supp_indir_tbl_entries));
> +
> +	RTL_W32(tp, RSS_CTRL_8125, rss_ctrl);
> +}
> +
> +static void rtl_set_rss_config(struct rtl8169_private *tp)
> +{
> +	rtl8169_set_rss_hash_opt(tp);
> +	rtl8169_store_reta(tp);
> +	rtl8169_store_rss_key(tp);
> +}

> +	/* enable rx descriptor type v4 and set queue num for rss*/

nit: missing space at the end of the comment


> -	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
> +	nvecs = pci_alloc_irq_vectors(pdev, get_min_irq_nvecs(tp), get_max_irq_nvecs(tp), flags);
> +
> +	if (nvecs < 0)
> +		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);

Why the two calls to pci_alloc_irq_vectors() ?
It should select the best number of IRQs it can, so why not just call

	pci_alloc_irq_vectors(pdev, 1, get_max_irq_nvecs(tp), flags);
	
note: please review the submission for unnecessarily going over 80
chars, we still prefer <=80 lines in netdev

>  	if (nvecs < 0)
>  		return nvecs;
