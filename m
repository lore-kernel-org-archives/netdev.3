Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450333F3290
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801270; cv=none; b=Ep800vrECqD+mM3Ns0thZte1LQf0MZCYRVx6Oar023belTTzPSbx6ThKRF6+5RmNbQoNIdukt2KLpGwTcWpCc70z3t57h61DLNvBNgf62Rbkw/DRYlGvBGCcPYXwZIWE0n+Bil2UZLSVYKZ/ynKbnKeHj/1O2AmS/WagSVRmG0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801270; c=relaxed/simple;
	bh=MfkTUFBLgR2zZXrYl9QJGYAXRtTHVOIb9oRRAPx5O34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIbA87vb0CDFIr2PU2j673J6onGnDKOHcRsjeNFqCvn2I3AYRKX39sP58RxeqS2OQA5LupM0kz8hYrYYyJPOrxi5LKND2Jf+vH64eTp4SPbCpSuU7qedevpGhxl9YFwkjCsBc9gbOn//t7BOl1HUlG5vs/3NgoCR7duq1xHnOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bg/P8a5V; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bg/P8a5V"
Message-ID: <f96044e5-a0c6-4678-959e-640339d21791@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784801267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aVEYDzwglsm8WIZ4iVfwUy/od687MXjWWJi5eB+vp4=;
	b=bg/P8a5VrofWp2FMhgCvATsUbA822G6saKJGcjMRyuFOt31E8aWmSDIg/XqWFUKPZROI8E
	upIJ2ylTt4qO4KSxeMPCRIXG+ZcpKM/N+RSXvJZlYax28cDkLrBovH2QYjiLaKp6I7uLQf
	kzKMy4i3rdvaDZ7yWKRSG6KfP53LsWU=
Date: Thu, 23 Jul 2026 11:07:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3 1/2] net: sxgbe: free TX rings on RX allocation
 failure
To: Chenguang Zhao <chenguang.zhao@linux.dev>, bh74.an@samsung.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260723021820.203960-1-chenguang.zhao@linux.dev>
 <20260723021820.203960-2-chenguang.zhao@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260723021820.203960-2-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/07/2026 03:18, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> When RX descriptor ring allocation fails, init_dma_desc_rings() only
> frees the partially allocated RX rings and returns. The TX rings that
> were allocated earlier in the same function are leaked.
> 
> Rearrange error labels to clean up TX rings upon RX failures.
> 
> Fixes: 1edb9ca69e8a ("net: sxgbe: add basic framework for Samsung 10Gb ethernet driver")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>   drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> index 5051ada43d2f..9b48a587d5c2 100644
> --- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> +++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> @@ -597,14 +597,13 @@ static int init_dma_desc_rings(struct net_device *netd)
>   
>   	return 0;
>   
> -txalloc_err:
> -	while (queue_num--)
> -		free_tx_ring(priv->device, priv->txq[queue_num], tx_rsize);
> -	return ret;
> -
>   rxalloc_err:
>   	while (queue_num--)
>   		free_rx_ring(priv->device, priv->rxq[queue_num], rx_rsize);
> +	queue_num = SXGBE_TX_QUEUES;
> +txalloc_err:
> +	while (queue_num--)
> +		free_tx_ring(priv->device, priv->txq[queue_num], tx_rsize);
>   	return ret;
>   }
>   
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
