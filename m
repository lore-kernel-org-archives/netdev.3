Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4B2BEFEF
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786748056; cv=none; b=sLFxvLXZDWP9opyxNDhV7Hooeuk6qQJwnPUG2NEwjfWWJxTYlZGnnBiGXJ4+O629vxO0srJVYyNwFK/Hw90ohp7lqcKnuRWht98V7WsrgMAB8GzIiT2yREPAt9mn4kO67/HESjOZSxtZ7j/GC1+RqO3Ox86i0nHqc9ftEr9sVlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786748056; c=relaxed/simple;
	bh=2iKXdr6QXSyjPn85CuyZW+p5YOArKwI+0Qk5/NokLEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hX+6o08cIyca0ILKyH6wg702vnhOoi/7NB7Q7ABuNixeCSf+rlvknLTVuXbTkz5ME7OGAHU5QEJMUjHJNbmHoQpdEOIPNjLQm9ghdRZYzfSxFQDW7ODP07eMl+PSL73SsPNuL2+TTBwZX9bKR5icMC1nC/3PmSmN4CWdJnvXgqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xa/fPEn9; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa/fPEn9"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so2107927a91.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 15:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786748054; x=1787352854; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RHBkDnmyOPFi5TUloKF73rijfsvcu5cEOfTWvQpbO80=;
        b=Xa/fPEn92VCr+ubjk5DIwUyVuWJ08WZw+Dx7CMfFvqGq3jmon5+2dm21xXMAtD9DTu
         rm0yRzr18mtF4J/ZrV2JGi7RjuR/UJev0oEqyx8nWinL+PE3I3TOCAgSK21zOKObdChx
         zHQujAFqWdb2XWnMV+ztmFDdPm2zmpk2PrYdJ2rRpvaWVAyW/veK/uZ9mNI/vUSNsJj9
         +kej8b9PSz2L1f/N3JEIoVf8UKRuKhtcKdmk4FujU5572peCn7nmYkgNn5SwATwH3f+I
         kF18Y40PrhVhoyV0dN2/DuT2by2aCEO2rYYF9ej5VRzbAbaLw8W73YazDXc8cwFKZmVW
         Hntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786748054; x=1787352854;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RHBkDnmyOPFi5TUloKF73rijfsvcu5cEOfTWvQpbO80=;
        b=aMlTZHP2hr8wS4aHbN/BW8wkmqIFwA8r3EGB7/vlOaBWxp9f8qXzoQY20DKy/0ONFx
         HBYXwipvrkPrXKNWYAsvi52/ZoqCsflxVBpTv8w8z1YHc/NXw8/HFzWD00bryk5NF1i5
         S16mi3fxRUr/kwDfhNCSF6cDSVaLDvdlCyYBhfflymr8uFnJj7qg8GQLhIzJ9GQmM8fe
         olcNVAoRg8WfDRaYJGlgz3FbMcEh3CkeFTZIfg2TDMDuiq85MZc56SkfdVyiEYTFUZg9
         TECRdysdylSIz6QcxPboDooLwPcKh0MD0zBa3+c32zyTuIKG1i8sgBxLr7D1bcZY+AB3
         rRRQ==
X-Gm-Message-State: AOJu0Yx/sHSk+a+0IKNi1tkK9wniejlUJxl6pbfKuDjtCPxMAUsrHiLU
	nMe9if8ly5LdGCNfQ5X2qDVo3fTMHPcxjKQSjRYyd6wN6NLzXbmEATeZ
X-Gm-Gg: AR+sD11LAGgnlbFFkiXxCk5Sn60XfQG8jaEwlrsgUI2RAlvX+ANu+woeqSieU5DWmtw
	cYKZqPc6Eix4CVItVS9m8USSOR7UgrJ4bPhu09ut1iWoYpy7YKbBaT8fRhKQmW7bLwhV9zjM3Jr
	r3WN1ccqqsdqliWtDJTpUspVMrWwndqAwc2BRzM5DyY6hWOsSKyTXBjAP8nSnj+dWJMXS0x4L19
	W2nD3PVOCyZrWfG4kZB2aJ1ha7dzWS7KkBB8WN4WSKcrICK2HSJA5iMg6C9+OaOw0GnsQAPOBwc
	riDWzMVzFiFZrgS0dsDU5/X+OfocfYtWHziZq1vTz0E2qJa107B4YUdIMZ/g3j8dDL4n3bIU2et
	9aY5fTjs1zB0Bu38foBUtMdR8Ynxz2s+GqD8DVhDP1JzCN6RpsTgRH7DOqln2IPc3KGRpIBWF/z
	rq+PByzlOXZA5Y1hW4tdyvHCv3JAq6Ca51w9p+gJfTeKonZSMFpg4oq5LkM/saIgnETPACS+sRI
	7nAnuLWVj3ZReR5105vvRzaZ8r56izS0HMq7J7a
X-Received: by 2002:a17:90b:3d43:b0:37f:c97a:939f with SMTP id 98e67ed59e1d1-3933b811e2dmr10688037a91.7.1786748053832;
        Fri, 14 Aug 2026 15:54:13 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::7:8615])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea8fe3cdsm8532422eec.28.2026.08.14.15.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 15:54:12 -0700 (PDT)
Message-ID: <9c73a611-8aab-411a-968f-86757e2756e5@gmail.com>
Date: Fri, 14 Aug 2026 15:54:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 4/7] r8169: enable new interrupt mapping
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260814015203.1328-1-javen_xu@realsil.com.cn>
 <20260814015203.1328-5-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260814015203.1328-5-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/13/26 6:52 PM, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch enables new interrupt mapping for RTL8127 and add error pkts
> counter per ring.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>   - no changes
> 
> Changes in v3:
>   - no changes
> 
> Changes in v4:
>   - no changes
> 
> Changes in v5:
>   - no changes
> 
> Changes in v6:
>   - no changes
> 
> Changes in v7:
>   - no changes
> 
> Changes in v8:
>   - no changes
> 
> Changes in v9:
>   - no changes
> 
> Changes in v10:
>   - no changes
> 
> Changes in v11:
>   - add error pkts counter per ring
> ---
>   drivers/net/ethernet/realtek/r8169_main.c | 80 +++++++++++++++++++----
>   1 file changed, 68 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index b30f0a31d7c7..aa72c42c374d 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -29,6 +29,7 @@
>   #include <linux/prefetch.h>
>   #include <linux/ipv6.h>
>   #include <linux/unaligned.h>
> +#include <linux/u64_stats_sync.h>
>   #include <net/ip6_checksum.h>
>   #include <net/netdev_queues.h>
>   #include <net/phy/realtek_phy.h>
> @@ -754,6 +755,15 @@ struct rtl8169_rx_ring {
>   	dma_addr_t rx_desc_phy_addr[NUM_RX_DESC];
>   	dma_addr_t rx_phy_addr;
>   	struct page *rx_databuff[NUM_RX_DESC];
> +
> +	struct {
> +		u64 rx_errors;
> +		u64 rx_dropped;
> +		u64 rx_length_errors;
> +		u64 rx_crc_errors;
> +		u64 multicast;
> +		struct u64_stats_sync syncp;
> +	} stats;
>   };
>   
>   struct rtl8169_private {
> @@ -3939,6 +3949,15 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
>   	return r8168_mac_ocp_read(tp, 0xe00e) & BIT(13);
>   }
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
>   static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>   {
>   	rtl_pcie_state_l2l3_disable(tp);
> @@ -3947,6 +3966,9 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>   	RTL_W32(tp, RSS_CTRL_8125, 0);
>   	RTL_W16(tp, Q_NUM_CTRL_8125, 0);
>   
> +	if (tp->irq_nvecs > 1)
> +		rtl8169_hw_enable_vec_mapping(tp);
> +
>   	/* disable UPS */
>   	r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);
>   
> @@ -4347,7 +4369,7 @@ static int rtl8169_init_ring(struct rtl8169_private *tp)
>   
>   	memset(tp->tx_skb, 0, sizeof(tp->tx_skb));
>   
> -	for (i = 0; i < tp->num_rx_rings; i++) {
> +	for (int i = 0; i < tp->num_rx_rings; i++) {

This looks like an unrelated change. Looking the function body, this is 
introducing a new bug on the cleanup path by changing the scope of i.

>   		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
>   
>   		memset(ring->rx_databuff, 0, sizeof(ring->rx_databuff));
> @@ -4926,15 +4948,16 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb,
>   		skb_checksum_none_assert(skb);
>   }
>   
> -static bool rtl8169_check_rx_desc_error(struct net_device *dev,
> -					struct rtl8169_private *tp,
> +static bool rtl8169_check_rx_desc_error(struct rtl8169_rx_ring *ring,
>   					u32 status)
>   {
>   	if (unlikely(status & RxRES)) {
> +		u64_stats_update_begin(&ring->stats.syncp);
>   		if (status & (RxRWT | RxRUNT))
> -			dev->stats.rx_length_errors++;
> +			ring->stats.rx_length_errors++;
>   		if (status & RxCRC)
> -			dev->stats.rx_crc_errors++;
> +			ring->stats.rx_crc_errors++;
> +		u64_stats_update_end(&ring->stats.syncp);
>   		return true;
>   	}
>   	return false;
> @@ -4965,11 +4988,13 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>   		 */
>   		dma_rmb();
>   
> -		if (rtl8169_check_rx_desc_error(dev, tp, status)) {
> +		if (rtl8169_check_rx_desc_error(ring, status)) {
>   			if (net_ratelimit())
>   				netdev_warn(dev, "Rx ERROR. status = %08x\n",
>   					    status);
> -			dev->stats.rx_errors++;
> +			u64_stats_update_begin(&ring->stats.syncp);
> +			ring->stats.rx_errors++;
> +			u64_stats_update_end(&ring->stats.syncp);
>   
>   			if (!(dev->features & NETIF_F_RXALL))
>   				goto release_descriptor;
> @@ -4985,14 +5010,18 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>   		 * They are seen as a symptom of over-mtu sized frames.
>   		 */
>   		if (unlikely(rtl8169_fragmented_frame(status))) {
> -			dev->stats.rx_dropped++;
> -			dev->stats.rx_length_errors++;
> +			u64_stats_update_begin(&ring->stats.syncp);
> +			ring->stats.rx_dropped++;
> +			ring->stats.rx_length_errors++;
> +			u64_stats_update_end(&ring->stats.syncp);
>   			goto release_descriptor;
>   		}
>   
>   		skb = napi_alloc_skb(napi, pkt_size);
>   		if (unlikely(!skb)) {
> -			dev->stats.rx_dropped++;
> +			u64_stats_update_begin(&ring->stats.syncp);
> +			ring->stats.rx_dropped++;
> +			u64_stats_update_end(&ring->stats.syncp);
>   			goto release_descriptor;
>   		}
>   
> @@ -5011,8 +5040,11 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>   
>   		rtl8169_rx_vlan_tag(desc, skb);
>   
> -		if (skb->pkt_type == PACKET_MULTICAST)
> -			dev->stats.multicast++;
> +		if (skb->pkt_type == PACKET_MULTICAST) {
> +			u64_stats_update_begin(&ring->stats.syncp);
> +			ring->stats.multicast++;
> +			u64_stats_update_end(&ring->stats.syncp);
> +		}
>   
>   		napi_gro_receive(napi, skb);
>   
> @@ -5428,6 +5460,27 @@ rtl8169_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
>   	netdev_stats_to_stats64(stats, &dev->stats);
>   	dev_fetch_sw_netstats(stats, dev->tstats);
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
>   	/*
>   	 * Fetch additional counter values missing in stats collected by driver
>   	 * from tally counters.
> @@ -6166,6 +6219,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	if (!tp->rx_ring)
>   		return -ENOMEM;
>   
> +	for (int i = 0; i < tp->num_rx_rings; i++)
> +		u64_stats_init(&tp->rx_ring[i].stats.syncp);
> +
>   	tp->rtl8169_napi = kcalloc(tp->irq_nvecs, sizeof(struct napi_struct),
>   				   GFP_KERNEL);
>   	if (!tp->rtl8169_napi) {

