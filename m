Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6967D47A0A4
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984291; cv=none; b=Fo1iPkPzex3GwMurmMw6tIkAbSg61NJgqGiLI1PNJSrLZtw50HS3/u5wvSR2gVBt64jz2PKSVSRnruDdAJ3J1oFTLxZWNLVDnt7zDGg+zavSOMrqYFckeIg+S3VOfno5fq0CgHRx8VH77wiqwVHIuYosty9RyXuWQeODBuqiFkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984291; c=relaxed/simple;
	bh=IVVGqokkt2/CVu9PPDhXlEMtjnDR7rVoThOX533N0d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I789UpvUG7SrXDnxII6piSQjsKWWqGCshwLEXfWYOhXdzWwL3Joc0JiLVt1xn2GOOfrscDlj7yqG9a2gV6k6Ai0iXmyvyS4PAgM/TbYagxWhwgBjrHbhMOMmXYeIqzQUIpe8ZaNj+mRe0NHLUyWeMbQuVC8o8s9Dj5O2Rzn0Akg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ECMJ5xct; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ECMJ5xct"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0E40F4E40C2D;
	Thu,  2 Jul 2026 09:24:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D57775FF03;
	Thu,  2 Jul 2026 09:24:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 435BE104C960F;
	Thu,  2 Jul 2026 11:24:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782984287; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=C8ZUCuEdh3L5hiMLxhe72EUm7msl9vPjzpCNBa4UiB4=;
	b=ECMJ5xctawFPrREzuOI0pNWBVkqC6NQl1qV6ErqDxRadk74nuKAskbqEsPDOaUBzgbXC6e
	0HAlht92Y8RZBGWcMkBRxZhjQPcJg80COUTTDlFQhyzwUo95PatKSfMDKJJaB/LkBNIhKH
	TGe5+f4c9m4mkbGJmiuEwnA9hLpvCin0OJXRzzcLYue2OJfuH9DPHX8+hUTiqZf7o8dcXs
	EvJGW4n0m/DDHaGE/iqdaB6MVzY43eAzFbhgOJmuRzs+lfclI3f4uDxdBDfb8WSN52AJq8
	XnIfocAV0s5Mw51Tm6Quomn9yMr38tSp3KPW8HD0s0rGoCOCu6Yg6Zfd5agxvg==
Message-ID: <1e4cedb5-fc16-4007-9a11-8c819f2c5731@bootlin.com>
Date: Thu, 2 Jul 2026 11:24:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/stmmac: Set Rx queue page_pool to NULL when
 freeing DMA resources
To: Jakub Raczynski <j.raczynski@samsung.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 linux-kernel@vger.kernel.org, k.tegowski@samsung.com,
 k.domagalski@samsung.com, Yashwant Varur <yashwant.v@samsung.com>
References: <CGME20260630101157eucas1p1b1cef0db9381391bdd9400f1d255ce49@eucas1p1.samsung.com>
 <20260630100953.747868-1-j.raczynski@samsung.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260630100953.747868-1-j.raczynski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 6/30/26 12:09, Jakub Raczynski wrote:
> When freeing RX descriptor resources, there is standard clearing of
> descriptor page_pool via page_pool_destroy() which does destroy
> page but does not set its pointer to NULL, which must be done by driver
> calling this function.
> It is not done in __free_dma_rx_desc_resources() when stopping interface,
> which is generally not an issue, because __alloc_dma_rx_desc_resources() does
> setup this regardless of previous state.
> But above is true assuming reinitialization is successful.
> 
> In case of failure of page_pool_create() in __alloc_dma_rx_desc_resources(),
> all non-NULL pages will be freed, including those already cleared.
> So there is possible kernel panic due to wrong paging request at address.
> 
> Fix this by assigning NULL to page_pool pointer on free
> 
> Fixes: da5ec7f22a0f1 ("net: stmmac: refactor stmmac_init_rx_buffers for stmmac_reinit_rx_buffers")
> Signed-off-by: Yashwant Varur <yashwant.v@samsung.com>
> Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3591755ea30b..4b8f2814d3b5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2172,8 +2172,10 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
>  		xdp_rxq_info_unreg(&rx_q->xdp_rxq);
>  
>  	kfree(rx_q->buf_pool);
> -	if (rx_q->page_pool)
> +	if (rx_q->page_pool) {
>  		page_pool_destroy(rx_q->page_pool);
> +		rx_q->page_pool = NULL;
> +	}

page_pool_destroy can be passed NULL, as you're fixing this I think you might as well
drop the if(rx_q->page_pool) at the same time :) I agree with the change otherwise.

with that changed,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

