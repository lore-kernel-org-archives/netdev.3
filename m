Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359A73BBA01
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 23:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786748455; cv=none; b=cbnhSxHHdNf81RGFP4wY0gaCYJAOBezmnIftzv5OfzUxoL9USthU+4HB1lPfWOkmD0Mv1vEi0P5LO47lDbMpwW4ztrlZX8ZhCIbofvIFBXJkhFZbLqtc7SqmCUuFzNUIkBhG1Dia7+SoX7O5uHlg5GO+vdyfm2jaGiLr+KtV7ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786748455; c=relaxed/simple;
	bh=9JLUivoNLzPVF5hpuH4EeRy9SAQkVl1Xjyz4+YABLUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBDZo1zr+fic3aXStRSTIdH/OCV4IyJmXNLYerW6pbrC1LutxnfRM7pIF3f6yGNu1ye2f3xoNtmfKt41Tp6noQ9QtxM69sF1jDwFceZYWiHrzOJZVKg49MAiyUY29DqJTZxKsOrS/3H2AgCC/96VUZwz3ADO7I7U+/KSdelsuWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsZotQyn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsZotQyn"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1726394a91.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 16:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786748452; x=1787353252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NT94MG0BN+EqcyfhD4QPGn2GLUh1VnWaOa2jIhDqWLQ=;
        b=ZsZotQynkv4QXg3IrCsCVUNtVZB7T5o66k/6vsU5/WpIzcA/7sq+tcPcDvTRIKpz+R
         lz/uWPQU097C4u8X5Logza7sojcaGGbp5y6zfJfU4MR2QCnwKkSV1Gxcm9CCLtKixJpl
         i5l0MFlWum0XrGEuTSlQYbpscjf/ahCiIIRtE/oZ20ibXyKba3FQs24hbOq+rNlIPk2Z
         6vimXR8CBDWMDY5Mekn8rm/MSX7lX5G6IcquA1IFhYw7OGUAkxAmLXQO14T62M76/9D6
         xvwIFtA9vuYtp1k6dWBTJyq/vKShCYLVxbTqyLhDr8dQt8A2QU2NlhE4l2/k42hU/Mbm
         YrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786748452; x=1787353252;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NT94MG0BN+EqcyfhD4QPGn2GLUh1VnWaOa2jIhDqWLQ=;
        b=pib5UDEHKp34EU6ZduVh5Ao6A8Xrj+1Eta/AqgxJnXVp4nNWRFwunimEOqiQR8wKHB
         CyEWDjIMqx+FPrpdEwHM/UwkwIBUoo0yX0lxYiLvUDholOFxtLoaGsw04T+htcb10MdU
         t2JCw7mLh4QdCO3ib/alr52xjZnSCuhvq9YvDKrSi2Ujy/nPOIedkDreIjPUE6uFYDVv
         ma+X//1fd1WBDuvg6OtyZOBnYyFMD988EGzPlXe/KrLaLrhgWaZSN7wmn7mlPLfYWOFh
         9bmE72QZDiT2ZzYEKEc5wP7xLj4R4xwi6q0o/lFRm1giC1iT9MOGFrJqIzkAR/A1ahbw
         ddRQ==
X-Gm-Message-State: AOJu0YzrTI7krbbxufdkiv9vbS3HX0a6x8Y+kvIZJSpeNkkXsKWBCtVO
	9BJlWHkhwi/FVxe2D8nrMMtGuCeZeL2LhSQbPYM02bTwLPQQnsl4BhHA
X-Gm-Gg: AR+sD13MYdfVGMCndrb0HKbLWj+hN2CbzlL7ol7aVHvvLKpTuENksYjGpha531Rx/H1
	3T8s90pcEtajW4N6o6J/OHVgKk/2C6Tc0ZQr83I35GijYaRdvxSFeI124ODE4Qz0pBco1k2LWWv
	/qTaj5vz7atLXPUtk0rF2pNNDmSoijDI5wLcV2AGsv5lP4hZUxgelGzofU+nOAX2ZsDhY1gar63
	JwaiJJzbjXRxO/EKP9WFRs/Cnr2faA1arxECr1AQ1VvH0pCC119LNCPKy4L9/GYbTDsfzcQiVga
	BqrzbwdyZhd3YjCvkFrqkedTzlCXh7lzP73+gtr3sEOGdpVvkUI1XiL1MxA63SClh6gW2o2+964
	bPeVlSXPjz+xjsSoNk4OFFRp9I5ggzFSSXVl+gZuzuNKhCwgVTgG/cg5KY5HQRuVANVQKywSsgz
	m9Ot9vol5vIs4lAHjORSehNJ/SzlzDAmGTKRpvWMdGitSz5ToOwV4GEdl/aq5GkxHzazD+qNoV/
	jalsGD9xk0tLgm7YvHmuifBCPJiQ+TPFUSbF1Rh
X-Received: by 2002:a17:90b:268c:b0:38f:2168:b9cb with SMTP id 98e67ed59e1d1-3933b84be0cmr11024600a91.9.1786748452054;
        Fri, 14 Aug 2026 16:00:52 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::7:8615])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141388b2554sm18799991c88.14.2026.08.14.16.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 16:00:51 -0700 (PDT)
Message-ID: <91f22805-bba2-4ffc-a490-54ad9c2f1c23@gmail.com>
Date: Fri, 14 Aug 2026 16:00:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 5/7] r8169: add support and enable rss
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260814015203.1328-1-javen_xu@realsil.com.cn>
 <20260814015203.1328-6-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260814015203.1328-6-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/13/26 6:52 PM, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support and enable rss for RTL8127.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>   - some changes moved from Patch 2/7
> 
> Changes in v3:
>   - add struct rtl8169_rss_data. Allocate it dynamically when needed.
>   - define rss_key as an u32 array
>   - replace some magic bit numbers in rtl8169_set_rss_hash_opt() and
>     rtl8125_set_rx_q_num()
>   - use union to combine different rx descriptor, refactor struct RxDesc
>   - remove dead code from rtl8169_double_check_rss_support()
> 
> Changes in v4:
>   - rename macro definition, e.g R8127_MAX_IRQ to R8127_MAX_NUM_IRQVEC
>   - change hw_supp_indir_tbl_entries type to unsigned int
>   - change init_rx_desc_type type to enum
>   - remove rtl_check_rss_support(), add helper function
>     rtl_hw_support_rss()
>   - remove hw_curr_isr_ver, use irq_nvecs to judge whether we should
>     enable vector interrupt mapping, use tp->num_rx_ring to judge whether
>     we should enable rss
>   - remove function rtl8169_double_check_rss_support(), use
>     rtl8169_set_rx_ring_num() to set num_rx_ring according to tp->irq_nvecs
> 
> Changes in v5:
>   - no changes
> 
> Changes in v6:
>   - change rss_queue_num type from u8 to unsigned int
>   - fix rx desc clear in rtl8169_rx_clear() for different desc type
>   - clamping num_rx_ring with rounddown_pow_of_two()
> 
> Changes in v7:
>   - remove unused macro
>   - change unfixed type in rtl8169_store_reta
> 
> Changes in v8:
>   - refill desc->addr when rx_desc reset
>   - rtl8169_set_channels fixed in patch 7/7
> 
> Changes in v9:
>   - remove rtl8169_set_desc_dma_addr, only set desc dma addr for
>     RX_DESC_TYPE_RSS desc
> 
> Changes in v10:
>   - Change rss_key to u8 array and write rss_key_reg as u32 values.
>     Use get_unaligned_le32() to keep behavior consistent on big-endian
>     and little-endian
> 
> Changes in v11:
>   - fix compilation error by adding block in switch default case
>   - fix concurrency bug on updating global dev->stats by using per-queue
>     stat
>   - fix packet drop logic to properlly handle fatal errors when rss is
>     enable
>   - use get_unaligned_le32() uniformly in rtl8169_store_reta()
>   - fix coding style issues
>   - add comment on pci_alloc_irq_vectors() call
> ---
>   drivers/net/ethernet/realtek/r8169_main.c | 398 ++++++++++++++++++++--
>   1 file changed, 361 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index aa72c42c374d..1b4416d32231 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -89,6 +89,19 @@
>   #define R8169_MAX_RX_QUEUES	8
>   #define R8169_DEFAULT_RX_QUEUES	1
>   #define R8169_MAX_TX_QUEUES	1
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
>   #define OCP_STD_PHY_BASE	0xa400
>   
> @@ -491,6 +504,9 @@ enum rtl_register_content {
>   	RxRUNT	= (1 << 20),
>   	RxCRC	= (1 << 19),
>   
> +	RXRUNT_RSS	= (1 << 21),
> +	RXCRC_RSS	= (1 << 20),
> +
>   	/* ChipCmdBits */
>   	StopReq		= 0x80,
>   	CmdReset	= 0x10,
> @@ -596,6 +612,20 @@ enum rtl_register_content {
>   #define	ISRIMR_LINKCHG	BIT(29)
>   #define	ISRIMR_TOK_Q0	BIT(8)
>   #define	ISRIMR_ROK_Q0	BIT(0)
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
>   };
>   
>   enum rtl_desc_bit {
> @@ -653,6 +683,11 @@ enum rtl_rx_desc_bit {
>   #define RxProtoIP	(PID1 | PID0)
>   #define RxProtoMask	RxProtoIP
>   
> +#define	RX_UDPT_DESC_RSS	BIT(19)
> +#define	RX_TCPT_DESC_RSS	BIT(18)
> +#define	RX_UDPF_DESC_RSS	BIT(16) /* UDP/IP checksum failed */
> +#define	RX_TCPF_DESC_RSS	BIT(15) /* TCP/IP checksum failed */
> +
>   	IPFail		= (1 << 16), /* IP checksum failed */
>   	UDPFail		= (1 << 15), /* UDP/IP checksum failed */
>   	TCPFail		= (1 << 14), /* TCP/IP checksum failed */
> @@ -674,9 +709,27 @@ struct TxDesc {
>   };
>   
>   struct RxDesc {
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
>   };
>   
>   struct ring_info {
> @@ -748,6 +801,11 @@ enum rtl_dash_type {
>   	RTL_DASH_25_BP,
>   };
>   
> +enum rx_desc_type {
> +	RX_DESC_TYPE_DEFAULT,
> +	RX_DESC_TYPE_RSS,
> +};
> +
>   struct rtl8169_rx_ring {
>   	u32 cur_rx;
>   	u32 dirty_rx;
> @@ -766,6 +824,12 @@ struct rtl8169_rx_ring {
>   	} stats;
>   };
>   
> +struct rtl8169_rss_data {
> +	u8 rss_key[RTL_RSS_KEY_SIZE];
> +	u8 rss_indir_tbl[RTL_MAX_INDIRECTION_TABLE_ENTRIES];
> +	unsigned int hw_supp_indir_tbl_entries;
> +};
> +
>   struct rtl8169_private {
>   	void __iomem *mmio_addr;	/* memory map physical address */
>   	struct pci_dev *pci_dev;
> @@ -785,7 +849,9 @@ struct rtl8169_private {
>   	u16 tx_lpi_timer;
>   	u32 irq_mask;
>   	unsigned int hw_supp_num_rx_queues;
> +	struct rtl8169_rss_data *rss_data;
>   	unsigned int irq_nvecs;
> +	enum rx_desc_type init_rx_desc_type;
>   	struct clk *clk;
>   
>   	struct {
> @@ -1615,6 +1681,11 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
>   	}
>   }
>   
> +static bool rtl_hw_support_rss(struct rtl8169_private *tp)
> +{
> +	return tp->mac_version == RTL_GIGA_MAC_VER_80;
> +}
> +
>   static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
>   {
>   	switch (tp->mac_version) {
> @@ -1916,9 +1987,20 @@ static inline u32 rtl8169_tx_vlan_tag(struct sk_buff *skb)
>   		TxVlanTag | swab16(skb_vlan_tag_get(skb)) : 0x00;
>   }
>   
> -static void rtl8169_rx_vlan_tag(struct RxDesc *desc, struct sk_buff *skb)
> +static void rtl8169_rx_vlan_tag(struct rtl8169_private *tp,
> +				struct RxDesc *desc,
> +				struct sk_buff *skb)
>   {
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
>   	if (opts2 & RxVlanTag)
>   		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), swab16(opts2 & 0xffff));
> @@ -2746,17 +2828,27 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
>   	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
>   }
>   
> +static void rtl8169_init_rss(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->rss_data->hw_supp_indir_tbl_entries; i++)
> +		tp->rss_data->rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, tp->num_rx_rings);
> +
> +	netdev_rss_key_fill(tp->rss_data->rss_key, RTL_RSS_KEY_SIZE);
> +}
> +
>   static void rtl_setup_rx_params(struct rtl8169_private *tp)
>   {
>   	tp->num_rx_rings = 1;
>   	switch (tp->mac_version) {
>   	case RTL_GIGA_MAC_VER_80:
>   		tp->hw_supp_num_rx_queues = R8169_MAX_RX_QUEUES;
> +		tp->rss_data->hw_supp_indir_tbl_entries = RTL_MAX_INDIRECTION_TABLE_ENTRIES;
>   		break;
>   	default:
>   		tp->hw_supp_num_rx_queues = R8169_DEFAULT_RX_QUEUES;
>   		break;
>   	}
> +	tp->init_rx_desc_type = RX_DESC_TYPE_DEFAULT;
>   }
>   
>   static void rtl_request_firmware(struct rtl8169_private *tp)
> @@ -2881,6 +2973,56 @@ static void rtl_set_rx_max_size(struct rtl8169_private *tp)
>   	RTL_W16(tp, RxMaxSize, R8169_RX_BUF_SIZE + 1);
>   }
>   
> +static void rtl8169_store_rss_key(struct rtl8169_private *tp)
> +{
> +	u8 *rss_key = tp->rss_data->rss_key;
> +	const u16 rss_key_reg = RSS_KEY_REG;
> +
> +	/* Write redirection table to HW */
> +	for (int i = 0; i < RTL_RSS_KEY_SIZE; i += sizeof(u32))
> +		RTL_W32(tp, rss_key_reg + i, get_unaligned_le32(rss_key + i));
> +}
> +
> +static void rtl8169_store_reta(struct rtl8169_private *tp)
> +{
> +	u8 *indir_tbl = tp->rss_data->rss_indir_tbl;
> +	unsigned int i;
> +
> +	/* Write redirection table to HW */
> +	for (i = 0; i < tp->rss_data->hw_supp_indir_tbl_entries; i += 4) {
> +		u32 reta = get_unaligned_le32(&indir_tbl[i]);
> +
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
> +	rss_ctrl |= RSS_CTRL_TCP_IPV4_SUPP |
> +		    RSS_CTRL_IPV4_SUPP |
> +		    RSS_CTRL_IPV6_SUPP |
> +		    RSS_CTRL_IPV6_EXT_SUPP |
> +		    RSS_CTRL_TCP_IPV6_SUPP |
> +		    RSS_CTRL_TCP_IPV6_EXT_SUPP;
> +
No support for UDP? If it is intentional, maybe drop a comment?

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
> +
>   static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
>   {
>   	struct rtl8169_rx_ring *ring = &tp->rx_ring[0];
> @@ -3949,6 +4091,18 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
>   	return r8168_mac_ocp_read(tp, 0xe00e) & BIT(13);
>   }
>   
> +static void rtl8125_set_rx_q_num(struct rtl8169_private *tp)
> +{
> +	u16 rx_q_num;
> +	u16 q_ctrl;
> +
> +	rx_q_num = ilog2(tp->num_rx_rings);
> +	q_ctrl = RTL_R16(tp, Q_NUM_CTRL_8125);
> +	q_ctrl &= ~RTL_RX_Q_NUM_MASK;
> +	q_ctrl |= FIELD_PREP(RTL_RX_Q_NUM_MASK, rx_q_num);
> +	RTL_W16(tp, Q_NUM_CTRL_8125, q_ctrl);
> +}
> +
>   static void rtl8169_hw_enable_vec_mapping(struct rtl8169_private *tp)
>   {
>   	u8 tmp;
> @@ -3988,6 +4142,13 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>   	    tp->mac_version == RTL_GIGA_MAC_VER_80)
>   		RTL_W8(tp, 0xD8, RTL_R8(tp, 0xD8) & ~0x02);
>   
> +	/* enable rx descriptor type v4 and set queue num for rss */
> +	if (tp->num_rx_rings > 1) {
> +		rtl8125_set_rx_q_num(tp);
> +		RTL_W8(tp, RTL_DESC_TYPE_CTRL,
> +		       RTL_R8(tp, RTL_DESC_TYPE_CTRL) | RTL_DESC_TYPE_RSS);
> +	}
> +
>   	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
>   		r8168_mac_ocp_modify(tp, 0xe614, 0x0f00, 0x0f00);
>   	else if (tp->mac_version == RTL_GIGA_MAC_VER_70)
> @@ -4224,6 +4385,12 @@ static void rtl_hw_start(struct  rtl8169_private *tp)
>   	rtl_hw_aspm_clkreq_enable(tp, true);
>   	rtl_set_rx_max_size(tp);
>   	rtl_set_rx_tx_desc_registers(tp);
> +	if (rtl_is_8125(tp)) {
> +		if (tp->num_rx_rings > 1)
> +			rtl_set_rss_config(tp);
> +		else
> +			RTL_W32(tp, RSS_CTRL_8125, 0x00);
> +	}
>   	rtl_lock_config_regs(tp);
>   
>   	rtl_jumbo_config(tp);
> @@ -4251,14 +4418,26 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
>   	return 0;
>   }
>   
> -static void rtl8169_mark_to_asic(struct RxDesc *desc)
> +static void rtl8169_mark_to_asic(struct rtl8169_private *tp, struct RxDesc *desc)
>   {
> -	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
> +	u32 eor;
>   
> -	desc->opts2 = 0;
> -	/* Force memory writes to complete before releasing descriptor */
> -	dma_wmb();
> -	WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_TYPE_RSS:
> +		eor = le32_to_cpu(desc->rss_opts1) & RingEnd;
> +		desc->rss_opts2 = cpu_to_le32(0);
> +		/* Force memory writes to complete before releasing descriptor */
> +		dma_wmb();
> +		WRITE_ONCE(desc->rss_opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
> +		break;
> +	default:
> +		eor = le32_to_cpu(desc->opts1) & RingEnd;
> +		desc->opts2 = cpu_to_le32(0);
> +		/* Force memory writes to complete before releasing descriptor */
> +		dma_wmb();
> +		WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
> +		break;
> +	}
>   }
>   
>   static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
> @@ -4281,9 +4460,12 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
>   		return NULL;
>   	}
>   
> -	desc->addr = cpu_to_le64(mapping);
>   	ring->rx_desc_phy_addr[index] = mapping;
> -	rtl8169_mark_to_asic(desc);
> +	if (tp->init_rx_desc_type == RX_DESC_TYPE_RSS)
> +		desc->rss_addr = cpu_to_le64(mapping);
> +	else
> +		desc->addr = cpu_to_le64(mapping);
> +	rtl8169_mark_to_asic(tp, desc);
>   
>   	return data;
>   }
> @@ -4300,8 +4482,25 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp,
>   		__free_pages(ring->rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
>   		ring->rx_databuff[i] = NULL;
>   		ring->rx_desc_phy_addr[i] = 0;
> -		ring->rx_desc_array[i].addr = 0;
> -		ring->rx_desc_array[i].opts1 = 0;
> +		if (tp->init_rx_desc_type == RX_DESC_TYPE_RSS) {
> +			ring->rx_desc_array[i].rss_addr = 0;
> +			ring->rx_desc_array[i].rss_opts1 = 0;
> +		} else {
> +			ring->rx_desc_array[i].addr = 0;
> +			ring->rx_desc_array[i].opts1 = 0;
> +		}
> +	}
> +}
> +
> +static void rtl8169_mark_as_last_descriptor(struct rtl8169_private *tp, struct RxDesc *desc)
> +{
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_TYPE_RSS:
> +		desc->rss_opts1 |= cpu_to_le32(RingEnd);
> +		break;
> +	default:
> +		desc->opts1 |= cpu_to_le32(RingEnd);
> +		break;
>   	}
>   }
>   
> @@ -4321,7 +4520,7 @@ static int rtl8169_rx_fill(struct rtl8169_private *tp, struct rtl8169_rx_ring *r
>   	}
>   
>   	/* mark as last descriptor in the ring */
> -	ring->rx_desc_array[NUM_RX_DESC - 1].opts1 |= cpu_to_le32(RingEnd);
> +	rtl8169_mark_as_last_descriptor(tp, &ring->rx_desc_array[NUM_RX_DESC - 1]);
>   
>   	return 0;
>   }
> @@ -4480,8 +4679,13 @@ static void rtl8169_rx_desc_reset(struct rtl8169_private *tp)
>   	for (int i = 0; i < tp->num_rx_rings; i++) {
>   		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
>   
> -		for (int j = 0; j < NUM_RX_DESC; j++)
> -			rtl8169_mark_to_asic(ring->rx_desc_array + j);
> +		for (int j = 0; j < NUM_RX_DESC; j++) {
> +			dma_addr_t phy_addr = ring->rx_desc_phy_addr[j];
> +
> +			if (tp->init_rx_desc_type == RX_DESC_TYPE_RSS)
> +				ring->rx_desc_array[j].rss_addr = cpu_to_le64(phy_addr);
> +			rtl8169_mark_to_asic(tp, ring->rx_desc_array + j);
> +		}
>   	}
>   }
>   
> @@ -4937,28 +5141,91 @@ static inline int rtl8169_fragmented_frame(u32 status)
>   	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
>   }
>   
> -static inline void rtl8169_rx_csum(struct sk_buff *skb,
> +static inline void rtl8169_rx_hash(struct rtl8169_private *tp,
> +				   struct RxDesc *desc,
> +				   struct sk_buff *skb)
> +{
> +	u32 rss_header_info;
> +	u32 hash_val;
> +
> +	if (!(tp->dev->features & NETIF_F_RXHASH))
> +		return;
> +
> +	rss_header_info = le32_to_cpu(desc->rss_dword.rss_info);
> +
> +	if (!(rss_header_info & RXS_RSS_L3_TYPE_MASK))
> +		return;
> +
> +	hash_val = le32_to_cpu(desc->rss_dword.rss_result);
> +
> +	skb_set_hash(skb, hash_val,
> +		     (RXS_RSS_L4_TYPE_MASK & rss_header_info) ?
> +		     PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3);
> +}
> +
> +static inline void rtl8169_rx_csum(struct rtl8169_private *tp,
> +				   struct sk_buff *skb,
>   				   u32 opts1)
>   {
> -	u32 status = opts1 & (RxProtoMask | RxCSFailMask);
> +	bool csum_ok = false;
> +
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_TYPE_RSS:
> +		if (((opts1 & RX_TCPT_DESC_RSS) && !(opts1 & RX_TCPF_DESC_RSS)) ||
> +		    ((opts1 & RX_UDPT_DESC_RSS) && !(opts1 & RX_UDPF_DESC_RSS)))
> +			csum_ok = true;
> +		break;
> +	default: {
> +		u32 status = opts1 & (RxProtoMask | RxCSFailMask);
> +
> +		if (status == RxProtoTCP || status == RxProtoUDP)
> +			csum_ok = true;
> +		break;
> +	}
> +	}
>   
> -	if (status == RxProtoTCP || status == RxProtoUDP)
> +	if (csum_ok)
>   		skb->ip_summed = CHECKSUM_UNNECESSARY;
>   	else
>   		skb_checksum_none_assert(skb);
>   }
>   
> +static __le32 rtl8169_rx_desc_opts1(struct rtl8169_private *tp, struct RxDesc *desc)
> +{
> +	switch (tp->init_rx_desc_type) {
> +	case RX_DESC_TYPE_RSS:
> +		return READ_ONCE(desc->rss_opts1);
> +	default:
> +		return READ_ONCE(desc->opts1);
> +	}
> +}
> +
>   static bool rtl8169_check_rx_desc_error(struct rtl8169_rx_ring *ring,
> +					struct rtl8169_private *tp,
>   					u32 status)
>   {
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
> +			if (status & RX_RUNT_RSS)
> +				ring->stats.rx_length_errors++;
> +			if (status & RX_CRC_RSS)
> +				ring->stats.rx_crc_errors++;
> +			u64_stats_update_end(&ring->stats.syncp);
> +			return true;
> +		}
> +		break;
> +	default:
> +		if (unlikely(status & RxRES)) {
> +			u64_stats_update_begin(&ring->stats.syncp);
> +			if (status & (RxRWT | RxRUNT))
> +				ring->stats.rx_length_errors++;
> +			if (status & RxCRC)
> +				ring->stats.rx_crc_errors++;
> +			u64_stats_update_end(&ring->stats.syncp);
> +			return true;
> +		}
>   	}
>   	return false;
>   }
> @@ -4978,7 +5245,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>   		dma_addr_t addr;
>   		u32 status;
>   
> -		status = le32_to_cpu(READ_ONCE(desc->opts1));
> +		status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
>   		if (status & DescOwn)
>   			break;
>   
> @@ -4988,7 +5255,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>   		 */
>   		dma_rmb();
>   
> -		if (rtl8169_check_rx_desc_error(ring, status)) {
> +		if (rtl8169_check_rx_desc_error(ring, tp, status)) {
>   			if (net_ratelimit())
>   				netdev_warn(dev, "Rx ERROR. status = %08x\n",
>   					    status);
> @@ -4998,8 +5265,14 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>   
>   			if (!(dev->features & NETIF_F_RXALL))
>   				goto release_descriptor;
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
>   		}
>   
>   		pkt_size = status & GENMASK(13, 0);
> @@ -5035,10 +5308,12 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>   		skb->len = pkt_size;
>   		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
>   
> -		rtl8169_rx_csum(skb, status);
> +		if (tp->num_rx_rings > 1)
> +			rtl8169_rx_hash(tp, desc, skb);
> +		rtl8169_rx_csum(tp, skb, status);
>   		skb->protocol = eth_type_trans(skb, dev);
>   
> -		rtl8169_rx_vlan_tag(desc, skb);
> +		rtl8169_rx_vlan_tag(tp, desc, skb);
>   
>   		if (skb->pkt_type == PACKET_MULTICAST) {
>   			u64_stats_update_begin(&ring->stats.syncp);
> @@ -5050,7 +5325,9 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>   
>   		dev_sw_netstats_rx_add(dev, pkt_size);
>   release_descriptor:
> -		rtl8169_mark_to_asic(desc);
> +		if (tp->init_rx_desc_type == RX_DESC_TYPE_RSS)
> +			desc->rss_addr = cpu_to_le64(ring->rx_desc_phy_addr[entry]);
> +		rtl8169_mark_to_asic(tp, desc);
>   	}
>   
>   	return count;
> @@ -5674,6 +5951,32 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
>   	}
>   }
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
>   static int rtl_alloc_irq(struct rtl8169_private *tp)
>   {
>   	struct pci_dev *pdev = tp->pci_dev;
> @@ -5694,7 +5997,11 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>   		break;
>   	}
>   
> -	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
> +	nvecs = pci_alloc_irq_vectors(pdev, get_min_irq_nvecs(tp),
> +				      get_max_irq_nvecs(tp), flags);
> +
> +	if (nvecs < 0)
> +		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
>   
>   	if (nvecs < 0)
>   		return nvecs;
> @@ -6109,6 +6416,13 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	tp->dash_type = rtl_get_dash_type(tp);
>   	tp->dash_enabled = rtl_dash_is_enabled(tp);
>   
> +	if (rtl_hw_support_rss(tp)) {
> +		tp->rss_data = devm_kzalloc(&pdev->dev, sizeof(*tp->rss_data),
> +					    GFP_KERNEL);
> +		if (!tp->rss_data)
> +			return -ENOMEM;
> +	}
> +
>   	tp->cp_cmd = RTL_R16(tp, CPlusCmd) & CPCMD_MASK;
>   
>   	if (sizeof(dma_addr_t) > 4 && tp->mac_version >= RTL_GIGA_MAC_VER_18 &&
> @@ -6129,6 +6443,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	if (rc < 0)
>   		return dev_err_probe(&pdev->dev, rc, "Can't allocate interrupt\n");
>   
> +	rtl8169_set_rx_ring_num(tp);
> +
> +	if (rtl_hw_support_rss(tp))
> +		rtl8169_init_rss(tp);
> +
>   	INIT_WORK(&tp->wk.work, rtl_task);
>   	disable_work(&tp->wk.work);
>   
> @@ -6141,6 +6460,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO;
>   	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
>   
> +	if (rtl_hw_support_rss(tp) && tp->num_rx_rings > 1) {
> +		dev->hw_features |= NETIF_F_RXHASH;
> +		dev->features |= NETIF_F_RXHASH;
> +	}
> +
>   	/*
>   	 * Pretend we are using VLANs; This bypasses a nasty bug where
>   	 * Interrupts stop flowing on high load on 8110SCd controllers.

