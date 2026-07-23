Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D73A2EACF2
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784803299; cv=none; b=HToYyGqYLgzvh8y3bwnXhFd1I5PKbVQSlv0GbYEGGxi/kP9NLXx5fKyZYvk6N6d/v2ghFVUmztBJiJRaxMh8ZhxH+9GT0rtNYW450GYHM42BRfkjcBGGPzxIdLwbYUHb9QFXpSgsuY+JmUZmN+LDGcnLhLq88UbpT+i8aYR8GQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784803299; c=relaxed/simple;
	bh=65Q18ZvQ6iPG4/QKof7xBXCNW48Z60ElrZ5O19AtKns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOdzwgWtT0PZ1D9Yszd/cfpnGd1c+c+6xMSHAxsTM6Il12MvbG4dZNqsgNWuOqkPhRV9v4HXYasbMSN9U55qkxKWB4kusUAqADlnYt3do0X1GRy0QNBawzOhMX66Dc/QWlY/OQIM2vgiyjbfjU+eer7HL7+wCJiRfRp3qQbqGMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nHOrhg29; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nHOrhg29"
Message-ID: <b958ab82-2935-422a-874e-13b68687ffb1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784803294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cOIRhWlKt589wRGXG03JjK5osWNwuYz+fXDSK8mOFAY=;
	b=nHOrhg29xlRcK6MawWDcb8RxgqDuvZOf2FAQdvv+mikvHoRaYOmk3sVO0pP8/RIFuMkqDZ
	1dsE/NipqKBLYU0aAvXVxx5J6oWvjwS+wi2X639R/VGEBCdZvp5083an6oR1hqgRmAYV8/
	4RSBLJyu0EO51Q3NXEvXFEios7XhtEE=
Date: Thu, 23 Jul 2026 11:41:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] forcedeth: fix UAF of txrx_stats in nv_remove
To: Chenguang Zhao <chenguang.zhao@linux.dev>, rain.1986.08.12@gmail.com,
 zyjzyj2000@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260723092637.2135095-1-chenguang.zhao@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260723092637.2135095-1-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/07/2026 10:26, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> nv_remove() frees the per-CPU txrx_stats before unregister_netdev().
> Until unregister completes, ndo_get_stats64, the NAPI/xmit data path,
> and nv_close()/drain may still access txrx_stats, leading to a
> use-after-free.
> 
> Free the stats only after unregister_netdev().
> 
> Fixes: f4b633b911fd ("forcedeth: use per cpu to collect xmit/recv statistics")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>   drivers/net/ethernet/nvidia/forcedeth.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
> index 5b0435d7bc39..106885bd0f6b 100644
> --- a/drivers/net/ethernet/nvidia/forcedeth.c
> +++ b/drivers/net/ethernet/nvidia/forcedeth.c
> @@ -6187,9 +6187,11 @@ static void nv_remove(struct pci_dev *pci_dev)
>   	struct net_device *dev = pci_get_drvdata(pci_dev);
>   	struct fe_priv *np = netdev_priv(dev);
>   
> -	free_percpu(np->txrx_stats);
> -
> +	/* txrx_stats is used by ndo_get_stats64 and the data path until
> +	 * unregister_netdevice() has completed.
> +	 */
>   	unregister_netdev(dev);
> +	free_percpu(np->txrx_stats);
>   
>   	nv_restore_mac_addr(pci_dev);
>   
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
