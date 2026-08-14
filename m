Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7A3B8111
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786747522; cv=none; b=LOuG10ynlxmKPgcdfTpnqRcWswbWz9HWmHnn3PjKUkd1x+qDiSMrbX+7fUEatusqn4e4q4pt2W23d3tK4W0eEHJP6RwtducYvSss1Yq6t2ySyYeCrM50OaFBRz+YWHzamj2gOWFoOznrD0H26GsCXzp0LNy8BnkQhM7hweue5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786747522; c=relaxed/simple;
	bh=ZZPdWHIcay1qv+DrtCvN4F8zseAA0V3VqAUQRyvQ9xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnvELxgk3YTNDpDb3j/rp+A3LX3fId/1zVNVlRCU2Kh8XDBrPNLeVN72ZrsDZnQKMWIwktXAHy1cm2gCZ+iGUXwzwhSba2v0fZWaNesMreAV/HNtBdVoT30k5lqHFyNcshhZobbfBzF8ACxKLsFcXJK7cTGq/3bTHqBU77SSD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Of4xmGE5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of4xmGE5"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1817835a91.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 15:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786747519; x=1787352319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnTL9H41agengPE4xF3U44V+FBqtamKoq0t/wWV5udI=;
        b=Of4xmGE5FqPEb+i95XR4yt6i8OG+/kxdtZzgS+kjr6KYs0BAW0vBSxLEg8wvUkCoY/
         fFGP/DyyVJF56wB0AizF2RilQEzG4p/net66LwRQSUc9avYhC+3BE02dzitfmxncZl87
         KcelXydYeKlH+VzNR/u9YO+LhkSVImBdcKXOSa8I0QiFtJ78KXCWmyFHI/9toisq5O4/
         CHBThEj8CAe4NEMlNvQcM94atUEYGH5mKyd43xqUoojUldjKd+yJOiQyVGf+qjpI2fIE
         87az8m8q5UsZbTm03capP1LXvfFSdJiZyn08ujSSH3mzkdOXmeeOMlpm1yutwioiA25a
         M/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786747519; x=1787352319;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LnTL9H41agengPE4xF3U44V+FBqtamKoq0t/wWV5udI=;
        b=hKU7d4rbGP9UG0ELIveeaBd123HumR1bxMsT+UfdcVRKPFu+TVatvBzxihJ2cicIhr
         PX+kJVwfFebN4FMGusbCDJ0L1ksuPTPdTAhA/wIuKh9Ta6xVpoLtvvPUUTOu4doJYN1W
         aDQhgQHsUD02O5Hmw7D7D9MPPmNRBIbW0w6BMezOFqKsB9MszZ1zP0CrtY8jWzONNVNH
         r9g6ro9YZGo3cFBNBQP/cE4StFGwCEieg3gveJoBYWgnAIByydfiLN+yyo9OfffOj5Em
         KHbesePOK9MECj+ar+NhSyVvQRNhDvDou+TSDaT6fRFMAHRENJb+DB0wlTQLZTbmVzQ3
         hd/g==
X-Gm-Message-State: AOJu0Yy6s79mJGSRlLmh9u6iJny+kzE44RChXItKC5Fgqn3Wkr6k4l9o
	oqq1r5xbOYPzJ8MyQoPc2EEDTe2BAcvfg05HSPKSbunlCt/kmmREknR6
X-Gm-Gg: AR+sD13htTD1jwbXUT44qMx+m5B+AIHm4YOIA2/dcQco1f5IemqKNTPQOua6cFeMAdh
	hdmg+jO7r/97tqlPnI0yL8FdK4SXoxR04rn+of4K7cb+k4sHP2Ra69ZKEUvPKCwlhKF4PN0mric
	NkbieuPhe5blYpSkQ5q22C+vy6Ww+vNf3q+HLylCNJba4J1XZ3RiZvwQJVDj/2x6EtGc2O9sP2F
	VzXvPdsbiEFVycDMHVJGBCvyp8iw9FIwml7U0GjAM2r6KUoYVxzGp2q5WZrxDbqic/x8rmfsABC
	PRzWQLK1H3vw+Eg0EDKXimWp+uLAC5bjGCqrx324R/NL8w6Uvl8ZOJfMGARSI8HtkEcxfGx4YdG
	R3c86JZ82uRIUnL3nwkVLl6yb456xW1q6f073J+Nkl0+tSIaokjYyhdAMK8QFlZcg5osWPbdO7C
	5Kp6Z3vXxfGF26InGqgpRU+UakD/wfiM/ppdzyoOvE3zNWNl/Q8lQJhSAjRnmKw5vhnO/kbK/6W
	+01fSf8EbWwot2OQLqzWWrLQslryltAd/GelDJR
X-Received: by 2002:a05:6a20:c90b:b0:3c4:2cf9:28ad with SMTP id adf61e73a8af0-3cc71ddfff1mr11341229637.12.1786747519052;
        Fri, 14 Aug 2026 15:45:19 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::7:8615])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c56aesm12147487c88.4.2026.08.14.15.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 15:45:18 -0700 (PDT)
Message-ID: <cc106b5e-943d-445e-a48c-77af70e67e70@gmail.com>
Date: Fri, 14 Aug 2026 15:45:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 3/7] r8169: add support for new interrupt
 mapping
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260814015203.1328-1-javen_xu@realsil.com.cn>
 <20260814015203.1328-4-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260814015203.1328-4-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/13/26 6:51 PM, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> To support RSS, the number of hardware interrupt bits should match the
> interrupt of software. So we add support for new interrupt mapping here.
> ISR_VEC_MAP_REG is the hardware register to indicate interrupt status.
> IMR_SET_VEC_MAP_REG is interrupt mask which is set to enable irq.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>   - no changes
> 
> Changes in v3:
>   - init index in napi_struct and get message_id from index
>   - move rtl8169_disable_hw_interrupt_msix directly before the call to
>     napi_schedule()
>   - change the condition in rtl8169_request_irq when RTL_VEC_MAP_ENABLE
>     enabled, use rtl8169_interrupt_msix
> 
> Changes in v4:
>   - remove flag tp->feature, replace tp->features & RTL_VEC_MAP_ENABLE
>     with tp->irq_nvecs > 1, they are equivalent.
>   - follow reverse xmas tree, in rtl8169_interrupt_msix(),
>     rtl8169_poll_msix_rx(), rtl8169_poll_msix_tx(),
>     rtl8169_poll_msix_other()
>   - use napi->index in rtl8169_poll_msix_other()
>   - add a comment to describe RTL8127 MSI-X vector layout
>   - simplify r8169_init_napi()
> 
> Changes in v5:
>   - replace magic number in rtl8169_poll_msix_tx()
> 
> Changes in v6:
>   - when irq_nvecs <= 1, use register IntrMask_8125, else using vec map
>   - fix irq sequence in rtl8169_interrupt_msix(), disable interrupts
>     before clean it
>   - remove dead code in rtl8169_poll_msix_tx()
> 
> Changes in v7:
>   - remove recheck_desc_ownbit
>   - change return value of rtl_tx
>   - remove message_id which only used once
> 
> Changes in v8:
>   - fix rtl8169_netpoll()
>   - remove tx_done
> 
> Changes in v9:
>   - change the way of getting message_id of napi
> 
> Changes in v10:
>   - no changes
> 
> Changes in v11:
>   - add comment on rtl8169_poll_msix_tx, only use 1 tx
>   - remove napi for other. Separate napi only for datapath, control path
>     like linkchg is handled in interrupt function, which will not call
>     napi any more.
> ---
>   drivers/net/ethernet/realtek/r8169_main.c | 213 +++++++++++++++++++---
>   1 file changed, 187 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 9311a0cab4eb..b30f0a31d7c7 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -84,6 +84,7 @@
>   #define R8169_RX_RING_BYTES	((NUM_RX_DESC + 1) * sizeof(struct RxDesc))
>   #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
>   #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
> +#define R8169_MAX_QUEUES	16
>   #define R8169_MAX_RX_QUEUES	8
>   #define R8169_DEFAULT_RX_QUEUES	1
>   #define R8169_MAX_TX_QUEUES	1
> @@ -455,8 +456,12 @@ enum rtl8125_registers {
>   	RSS_CTRL_8125		= 0x4500,
>   	Q_NUM_CTRL_8125		= 0x4800,
>   	EEE_TXIDLE_TIMER_8125	= 0x6048,
> +	IMR_CLEAR_VEC_MAP_REG	= 0x0d00,
> +	ISR_VEC_MAP_REG		= 0x0d04,
> +	IMR_SET_VEC_MAP_REG	= 0x0d0c,
>   };
>   
> +#define MSIX_ID_VEC_MAP_LINKCHG	29
>   #define LEDSEL_MASK_8125	0x23f
>   
>   #define RX_VLAN_INNER_8125	BIT(22)
> @@ -587,6 +592,9 @@ enum rtl_register_content {
>   
>   	/* magic enable v2 */
>   	MagicPacket_v2	= (1 << 16),	/* Wake up when receives a Magic Packet */
> +#define	ISRIMR_LINKCHG	BIT(29)
> +#define	ISRIMR_TOK_Q0	BIT(8)
> +#define	ISRIMR_ROK_Q0	BIT(0)
>   };
>   
>   enum rtl_desc_bit {
> @@ -1663,26 +1671,38 @@ static u32 rtl_get_events(struct rtl8169_private *tp)
>   
>   static void rtl_ack_events(struct rtl8169_private *tp, u32 bits)
>   {
> -	if (rtl_is_8125(tp))
> -		RTL_W32(tp, IntrStatus_8125, bits);
> -	else
> +	if (rtl_is_8125(tp)) {
> +		if (tp->irq_nvecs > 1)
> +			RTL_W32(tp, ISR_VEC_MAP_REG, bits);
> +		else
> +			RTL_W32(tp, IntrStatus_8125, bits);
> +	} else {
>   		RTL_W16(tp, IntrStatus, bits);
> +	}
>   }
>   
>   static void rtl_irq_disable(struct rtl8169_private *tp)
>   {
> -	if (rtl_is_8125(tp))
> -		RTL_W32(tp, IntrMask_8125, 0);
> -	else
> +	if (rtl_is_8125(tp)) {
> +		if (tp->irq_nvecs > 1)
> +			RTL_W32(tp, IMR_CLEAR_VEC_MAP_REG, 0xffffffff);
> +		else
> +			RTL_W32(tp, IntrMask_8125, 0);
> +	} else {
>   		RTL_W16(tp, IntrMask, 0);
> +	}
>   }
>   
>   static void rtl_irq_enable(struct rtl8169_private *tp)
>   {
> -	if (rtl_is_8125(tp))
> -		RTL_W32(tp, IntrMask_8125, tp->irq_mask);
> -	else
> +	if (rtl_is_8125(tp)) {
> +		if (tp->irq_nvecs > 1)
> +			RTL_W32(tp, IMR_SET_VEC_MAP_REG, tp->irq_mask);
> +		else
> +			RTL_W32(tp, IntrMask_8125, tp->irq_mask);
> +	} else {
>   		RTL_W16(tp, IntrMask, tp->irq_mask);
> +	}
>   }
>   
>   static void rtl8169_irq_mask_and_ack(struct rtl8169_private *tp)
> @@ -4382,13 +4402,17 @@ static void rtl8169_tx_clear(struct rtl8169_private *tp)
>   
>   static void rtl8169_napi_disable(struct rtl8169_private *tp)
>   {
> -	for (int i = 0; i < tp->irq_nvecs; i++)
> +	int napi_num = min(tp->irq_nvecs, R8169_MAX_QUEUES);
> +
> +	for (int i = 0; i < napi_num; i++)
>   		napi_disable(&tp->rtl8169_napi[i]);
>   }
>   
>   static void rtl8169_napi_enable(struct rtl8169_private *tp)
>   {
> -	for (int i = 0; i < tp->irq_nvecs; i++)
> +	int napi_num = min(tp->irq_nvecs, R8169_MAX_QUEUES);
> +
> +	for (int i = 0; i < napi_num; i++)
>   		napi_enable(&tp->rtl8169_napi[i]);
>   }
>   
> @@ -5030,13 +5054,66 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>   	return IRQ_HANDLED;
>   }
>   
> +static void rtl8169_free_one_irq(struct rtl8169_private *tp, int i)
> +{
> +	if (tp->irq_nvecs > 1) {
> +		if (i < R8169_MAX_QUEUES)
> +			pci_free_irq(tp->pci_dev, i, &tp->rtl8169_napi[i]);
> +		else if (i == MSIX_ID_VEC_MAP_LINKCHG)
> +			pci_free_irq(tp->pci_dev, i, tp);
> +	} else {
> +		pci_free_irq(tp->pci_dev, i, &tp->rtl8169_napi[i]);
> +	}
> +}
> +
>   static void rtl8169_free_irq(struct rtl8169_private *tp)
>   {
> -	for (int i = 0; i < tp->irq_nvecs; i++) {
> -		struct napi_struct *napi = &tp->rtl8169_napi[i];
> +	for (int i = 0; i < tp->irq_nvecs; i++)
> +		rtl8169_free_one_irq(tp, i);
> +}
>   
> -		pci_free_irq(tp->pci_dev, i, napi);
> -	}
> +static void rtl8169_disable_hw_interrupt_msix(struct rtl8169_private *tp,
> +					      int message_id)
> +{
> +	RTL_W32(tp, IMR_CLEAR_VEC_MAP_REG, BIT(message_id));
> +}
> +
> +static void rtl8169_clear_hw_isr(struct rtl8169_private *tp, int message_id)
> +{
> +	RTL_W32(tp, ISR_VEC_MAP_REG, BIT(message_id));
> +}
> +
> +static void rtl8169_enable_hw_interrupt_msix(struct rtl8169_private *tp,
> +					     int message_id)
> +{
> +	RTL_W32(tp, IMR_SET_VEC_MAP_REG, BIT(message_id));
> +}
> +
> +static irqreturn_t rtl8169_interrupt_msix(int irq, void *dev_instance)
> +{
> +	struct napi_struct *napi = dev_instance;
> +	struct net_device *dev = napi->dev;
> +	struct rtl8169_private *tp;
> +	int message_id;
> +
> +	tp = netdev_priv(dev);
> +	message_id = napi - tp->rtl8169_napi;
> +
> +	rtl8169_disable_hw_interrupt_msix(tp, message_id);
> +	rtl8169_clear_hw_isr(tp, message_id);
> +
> +	napi_schedule(napi);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t rtl8169_interrupt_other(int irq, void *dev_instance)
> +{
> +	struct rtl8169_private *tp = dev_instance;
> +
> +	rtl8169_clear_hw_isr(tp, MSIX_ID_VEC_MAP_LINKCHG);
> +	phy_mac_interrupt(tp->phydev);
> +	return IRQ_HANDLED;
>   }
>   
>   static int rtl8169_request_irq(struct rtl8169_private *tp)
> @@ -5047,8 +5124,26 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
>   
>   	for (i = 0; i < tp->irq_nvecs; i++) {
>   		napi = &tp->rtl8169_napi[i];
> -		rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
> -				     NULL, napi, "%s-%d", dev->name, i);
> +		if (tp->irq_nvecs > 1) {
> +			if (i < R8169_MAX_QUEUES)
> +				rc = pci_request_irq(tp->pci_dev, i,
> +						     rtl8169_interrupt_msix,
> +						     NULL, napi, "%s-%d",
> +						     dev->name, i);
> +			else if (i == MSIX_ID_VEC_MAP_LINKCHG)
> +				rc = pci_request_irq(tp->pci_dev, i,
> +						     rtl8169_interrupt_other,
> +						     NULL, tp, "%s-%d",
> +						     dev->name, i);
> +			else
> +				continue;
> +		} else {
> +			rc = pci_request_irq(tp->pci_dev, i,
> +					     rtl8169_interrupt,
> +					     NULL, napi, "%s-%d",
> +					     dev->name, i);
> +		}
> +
>   		if (rc)
>   			goto free_irq;
>   	}
> @@ -5056,7 +5151,7 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
>   
>   free_irq:
>   	while (--i >= 0)
> -		pci_free_irq(tp->pci_dev, i, &tp->rtl8169_napi[i]);
> +		rtl8169_free_one_irq(tp, i);
>   	return rc;
>   }
>   
> @@ -5255,8 +5350,12 @@ static void rtl8169_netpoll(struct net_device *dev)
>   	struct rtl8169_private *tp = netdev_priv(dev);
>   
>   	for (int i = 0; i < tp->irq_nvecs; i++) {

Looking at r8169_init_napi(), later down the patch, it only calls 
netif_napi_add() for min(tp->irq_nvecs, R8169_MAX_QUEUES) vectors, but 
this loop iterates all tp->irq_nvecs. Can this be an issue? Looks like 
it will be because entries entries >= R8169_MAX_QUEUES are zeroed but 
rtl8169_interrupt_msix() would set dev to NULL.

> -		rtl8169_interrupt(pci_irq_vector(tp->pci_dev, i),
> -				  &tp->rtl8169_napi[i]);
> +		if (tp->irq_nvecs > 1)
> +			rtl8169_interrupt_msix(pci_irq_vector(tp->pci_dev, i),
> +					       &tp->rtl8169_napi[i]);
> +		else
> +			rtl8169_interrupt(pci_irq_vector(tp->pci_dev, i),
> +					  &tp->rtl8169_napi[i]);
>   	}
>   }
>   #endif
> @@ -5454,7 +5553,9 @@ static void rtl_shutdown(struct pci_dev *pdev)
>   
>   static void r8169_free_napi(struct rtl8169_private *tp)
>   {
> -	for (int i = 0; i < tp->irq_nvecs; i++)
> +	int napi_num = min(tp->irq_nvecs, R8169_MAX_QUEUES);
> +
> +	for (int i = 0; i < napi_num; i++)
>   		netif_napi_del(&tp->rtl8169_napi[i]);
>   
>   	kfree(tp->rtl8169_napi);
> @@ -5508,10 +5609,16 @@ static const struct net_device_ops rtl_netdev_ops = {
>   
>   static void rtl_set_irq_mask(struct rtl8169_private *tp)
>   {
> -	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
> +	if (tp->irq_nvecs > 1) {
> +		tp->irq_mask = ISRIMR_LINKCHG | ISRIMR_TOK_Q0;
> +		for (int i = 0; i < tp->num_rx_rings; i++)
> +			tp->irq_mask |= ISRIMR_ROK_Q0 << i;
> +	} else {
> +		tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
>   
> -	if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
> -		tp->irq_mask |= SYSErr | RxFIFOOver;
> +		if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
> +			tp->irq_mask |= SYSErr | RxFIFOOver;
> +	}
>   }
>   
>   static int rtl_alloc_irq(struct rtl8169_private *tp)
> @@ -5796,10 +5903,64 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>   	return false;
>   }
>   
> +static int rtl8169_poll_msix_rx(struct napi_struct *napi, int budget)
> +{
> +	struct net_device *dev = napi->dev;
> +	struct rtl8169_private *tp;
> +	int work_done = 0;
> +	int message_id;
> +
> +	tp = netdev_priv(dev);
> +	message_id = napi - tp->rtl8169_napi;
> +
> +	if (message_id < tp->num_rx_rings)
> +		work_done += rtl_rx(dev, tp, &tp->rx_ring[message_id],
> +				    budget, napi);
> +
> +	if (work_done < budget && napi_complete_done(napi, work_done))
> +		rtl8169_enable_hw_interrupt_msix(tp, message_id);
> +
> +	return work_done;
> +}
> +
> +static int rtl8169_poll_msix_tx(struct napi_struct *napi, int budget)
> +{
> +	struct net_device *dev = napi->dev;
> +	struct rtl8169_private *tp;
> +
> +	tp = netdev_priv(dev);
> +
> +	/* Currently r8169 only supports a single Tx ring.
> +	 * Therefore, we don't need a per-ring Tx processing loop here.
> +	 */
> +	rtl_tx(dev, tp, budget);
> +
> +	if (napi_complete_done(napi, 0))
> +		rtl8169_enable_hw_interrupt_msix(tp, (int)(napi - tp->rtl8169_napi));
> +
> +	return 0;
> +}
> +
> +/* RTL8127 MSI-X vector layout:
> + * Vectors 0 .. (RxQs - 1)		: Rx Queues
> + * Vectors RxQs .. (RxQs + TxQs - 1)	: Tx Queues
> + * NAPI is only allocated for data path
> + */
>   static void r8169_init_napi(struct rtl8169_private *tp)
>   {
> -	for (int i = 0; i < tp->irq_nvecs; i++)
> -		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
> +	int napi_num = min(tp->irq_nvecs, R8169_MAX_QUEUES);
> +
> +	for (int i = 0; i < napi_num; i++) {
> +		int (*poll_fn)(struct napi_struct *, int) = rtl8169_poll;
> +
> +		if (tp->irq_nvecs > 1) {
> +			if (i < R8169_MAX_RX_QUEUES)
> +				poll_fn = rtl8169_poll_msix_rx;
> +			else
> +				poll_fn = rtl8169_poll_msix_tx;
> +		}
> +		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], poll_fn);
> +	}
>   }
>   
>   static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)

