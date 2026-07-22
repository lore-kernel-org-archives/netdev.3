Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355C340F726
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717475; cv=none; b=TZPDnff+iDA7QHahQnwVPMILV5dhlIPr8B15IjM2oG/6YbbAGbc6EiVHgX8CrT8wA8V7IrFiukoRo00Seel9EapnL37jPdyFla7US3WGXgVsXxFbSUBI1HWzaeDd5lhvv1fsN34cksOcmW8wc8vDljK0EBfsmkiw/y8fSLGrTik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717475; c=relaxed/simple;
	bh=FeaSMPCDqwEZ/teOmQjlufGegjHByAATz+LrGlLEDsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4vR1Eo4wIqzXEWBZ0IA6JeNlrmgHWWlV3pSjakxdrZTrIVQ3olJa4OJ4nDFspzmQxCLwAc+QemP7rEVyhkqnqSmGyx4cmLbrk2/80ONxdJkfP3W9Or7Iu8Bapj+qreNAZ2Ynl6yFsqMuIEKNvGkKHBfgE9B0nhd0lN0jN7CQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pyldr5sd; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pyldr5sd"
Message-ID: <32855493-a1d8-4632-aa54-ba667ff56ab5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784717471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CHTWuUzxErGplj/3QxOFqdbT0InZx9RXkMIe9nUfSAs=;
	b=pyldr5sdT7YsjVuSrHPopDv6m+rilfvWkR9K2Nd6eC7ZweqrhQ0BuQiLoaPm0RP3AOKS2o
	I7MK/RFwKu9O4aamzxKnZGYSR5P1rNp8sCHLWaqT5raFJujkRH9oy9p3qNH0qCZcYA6ofL
	P8Sr7/FIGc30YW6A+ZKCaUsSOYEPHGA=
Date: Wed, 22 Jul 2026 11:50:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 1/2] net: sxgbe: free TX rings on RX allocation
 failure
To: Chenguang Zhao <chenguang.zhao@linux.dev>, bh74.an@samsung.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260722014055.157269-1-chenguang.zhao@linux.dev>
 <20260722014055.157269-2-chenguang.zhao@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260722014055.157269-2-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/07/2026 02:40, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> When RX descriptor ring allocation fails, init_dma_desc_rings() only
> frees the partially allocated RX rings and returns. The TX rings that
> were allocated earlier in the same function are leaked.
> 
> Mirror the TX allocation error path and release all TX rings before
> returning the error.
> 
> Fixes: 1edb9ca69e8a ("net: sxgbe: add basic framework for Samsung 10Gb ethernet driver")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>   drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> index 5051ada43d2f..fc7b72627f2a 100644
> --- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> +++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> @@ -605,6 +605,9 @@ static int init_dma_desc_rings(struct net_device *netd)
>   rxalloc_err:
>   	while (queue_num--)
>   		free_rx_ring(priv->device, priv->rxq[queue_num], rx_rsize);
> +	queue_num = SXGBE_TX_QUEUES;
> +	while (queue_num--)
> +		free_tx_ring(priv->device, priv->txq[queue_num], tx_rsize);
>   	return ret;
>   }
>   

There is already some error code to clear tx rings. It makes more sense
to rearrange labels to reuse already existing code.
