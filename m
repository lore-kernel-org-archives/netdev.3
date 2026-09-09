Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45A55293EF;
	Wed,  9 Sep 2026 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953146; cv=none; b=QwBtrk0GvOSlwKKDqgwJb2rJ9Oj2YadGXQ9ORLYvWCAEe/XgNhgpIwnWVGk3WXlWBb4GNuqHRVgEYUv04kPktuVIsBLK3n4NkxPf3YS7Oz2OpHZKjRN2C1/HKHHxqW0HWS9XTC8VQAwaW0Xmzeqa2BXtouX2alZcQTzhsAFAFD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953146; c=relaxed/simple;
	bh=tJRLfz6pYDkDB2dvIiwmmTNOMq6YTKCbZJmnaVBL8jk=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tW8H5ZHDffAzLmjLLT2Y1sRblGpAyDVNkK8QnaQy6faSZErRISeVgCvAuqczNI55WTtWJ+LU+uwlqxXArgKIPZrwG8mQa0OP0OToYTyDKCK6N+uVGQLk8pvbAbo/irH/NWVGkhO/6zHkGoEOo6vW20xdOSuQJo37cVY3ztHBYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MVtQKwdy; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MVtQKwdy"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ba6wKOHnujORbjJe7O+pyns+3nNCbntvhUtNcjEEgSw=;
	b=MVtQKwdy8PxG2OefPsc3N0S3RmeS3XDJ1WCVikXNFdIQlJIfoU3gC6mgCRyqXiXSf5t5u7Tl/
	1/UDslMlomipQ3oRg26/vcEGUMh+2fouNHRyKIwODFdc2foHHNwuXk+krFF4+QoFm7vl+lqYVw3
	3crJ221cvI0RAxlT0C7xLQ0=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hfyrM6kTtzLlx7;
	Wed,  9 Sep 2026 19:14:43 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 526A54055B;
	Wed,  9 Sep 2026 19:25:38 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 9 Sep 2026 19:25:37 +0800
Message-ID: <178ff176-fa31-41d0-8681-54e6f8c77465@huawei.com>
Date: Wed, 9 Sep 2026 19:25:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jiangfeng Xiao
	<xiaojiangfeng@huawei.com>
Subject: Re: [PATCH] net: hip04: use 16-bit byte order for HI13X1 TX fields
To: hpp.iscas <hppiscas@163.com>, Jian Shen <shenjian15@huawei.com>
References: <20260905132958.63085-1-hppiscas@163.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260905132958.63085-1-hppiscas@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/9/5 21:29, hpp.iscas wrote:
> The HI13X1 transmit descriptor stores send_size and data_offset in u16
>
> fields, but hip04_mac_start_xmit() converts both values with
>
> cpu_to_be32() before assigning them. On little-endian systems the
>
> assignment truncates the converted value, leaving neither field with the
>
> intended 16-bit big-endian representation.
>
>
>
> Use cpu_to_be16() for the two HI13X1 fields. Keep the original 32-bit
>
> conversion for the other descriptor format.
>
>
>
> Fixes: d413779cdd93 ("net: hisilicon: Add an tx_desc to adapt HI13X1_GMAC")
>
> Signed-off-by: hpp.iscas <hppiscas@163.com>

Thanks!

Reviewed-by: Jijie Shao <shaojijie@huawei.com>

>
> ---
>
>   drivers/net/ethernet/hisilicon/hip04_eth.c | 5 +++--
>
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
>
>
> diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
>
> index fc2c47d..2920985 100644
>
> --- a/drivers/net/ethernet/hisilicon/hip04_eth.c
>
> +++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
>
> @@ -527,13 +527,14 @@ hip04_mac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>
>   	priv->tx_skb[tx_head] = skb;
>
>   	priv->tx_phys[tx_head] = phys;
>
>   
>
> -	desc->send_size = (__force u32)cpu_to_be32(skb->len);
>
>   #if defined(CONFIG_HI13X1_GMAC)
>
> +	desc->send_size = (__force u16)cpu_to_be16(skb->len);
>
>   	desc->cfg = (__force u32)cpu_to_be32(TX_CLEAR_WB | TX_FINISH_CACHE_INV
>
>   		| TX_RELEASE_TO_PPE | priv->port << TX_POOL_SHIFT);
>
> -	desc->data_offset = (__force u32)cpu_to_be32(phys & SOC_CACHE_LINE_MASK);
>
> +	desc->data_offset = (__force u16)cpu_to_be16(phys & SOC_CACHE_LINE_MASK);
>
>   	desc->send_addr =  (__force u32)cpu_to_be32(phys & ~SOC_CACHE_LINE_MASK);
>
>   #else
>
> +	desc->send_size = (__force u32)cpu_to_be32(skb->len);
>
>   	desc->cfg = (__force u32)cpu_to_be32(TX_CLEAR_WB | TX_FINISH_CACHE_INV);
>
>   	desc->send_addr = (__force u32)cpu_to_be32(phys);
>
>   #endif
>
>
