Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453741F365
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801530; cv=none; b=WHzJ/dmFay+y/QcIyd7nEKTJSJ92vSAO6NMlTzzB18mtyvYE8d8GX2nQOTNxnyanY44UCnL0pmss6pDjC9rkVp5QDZlcddu/iyz40A9g9PxyT2lc8mg+GMrheFOW9ryMjLWAXI9CxYLQSWmbqFT9p+jrQWZpc6XBcfWpLU/B7YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801530; c=relaxed/simple;
	bh=s8R1oLxd2gIIgWGwtYNS6mqoL+pvsJYIcUi6+9o+IK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZPSIGhfx94WwR1+8b/99s4N1dH/s2aVEmLn1D7Y6GJxybotVL0leCZtLrBi3Jgs4zWEEjid7p358N8myNo30BnXY7KzO/0lDuM4dDpDQxN3dm/8iF/KuytBTUgG7fEHEIVqYH4yM577fbYemmth4HUGikOjs2uxTpQFeWLt3xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F2puuL5z; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F2puuL5z"
Message-ID: <805de3f6-8263-45d6-b6fe-e07d11d254b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784801525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1U+8mcZ4GUt99itgJDVO6aYiE8iYBw4lBNbt5LbW6A=;
	b=F2puuL5zSsneB3TxjBHfNPICct0eosOm7K/KSSwY/dAG3YJta0fCoi/m85iojC/ylgeQe8
	+DeSyn+EKKnowuvEpIklOk/JgO5hn+0E/ifLL7182K+2BHfEf4G06hk21jFqMUGEPMnLjM
	VUVWtOEbuMVAhjdBUCWpLy6r4ErxbQc=
Date: Thu, 23 Jul 2026 11:11:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3 2/2] net: sxgbe: check descriptor ring allocation
 failures
To: Chenguang Zhao <chenguang.zhao@linux.dev>, bh74.an@samsung.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260723021820.203960-1-chenguang.zhao@linux.dev>
 <20260723021820.203960-3-chenguang.zhao@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260723021820.203960-3-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/07/2026 03:18, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> sxgbe_open() ignores the return value of init_dma_desc_rings() and
> continues to program DMA with invalid ring addresses when allocation
> fails. Check the return value and disconnect the PHY on failure.
> 
> Fixes: 1edb9ca69e8a ("net: sxgbe: add basic framework for Samsung 10Gb ethernet driver")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>   drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> index 9b48a587d5c2..70cf3619555f 100644
> --- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> +++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> @@ -1078,7 +1078,9 @@ static int sxgbe_open(struct net_device *dev)
>   	priv->dma_buf_sz = SXGBE_ALIGN(DMA_BUFFER_SIZE);
>   	priv->tx_tc = TC_DEFAULT;
>   	priv->rx_tc = TC_DEFAULT;
> -	init_dma_desc_rings(dev);
> +	ret = init_dma_desc_rings(dev);
> +	if (ret)
> +		goto init_phy_error;
>   
>   	/* DMA initialization and SW reset */
>   	ret = sxgbe_init_dma_engine(priv);
> @@ -1187,6 +1189,7 @@ static int sxgbe_open(struct net_device *dev)
>   
>   init_error:
>   	free_dma_desc_resources(priv);
> +init_phy_error:

nit: better to name it init_dma_error

>   	if (dev->phydev)
>   		phy_disconnect(dev->phydev);
>   phy_error:

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
