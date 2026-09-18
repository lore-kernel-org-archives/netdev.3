Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A071498928;
	Fri, 18 Sep 2026 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726435; cv=none; b=kLgZOgch20f1G6A1DAI4hXN4KG7Z20oplq2oBfks+2PF560z1+b21LqKP9iMdFr5HiIoCtEC+pvSLEpIszSS33YCr0/Ql3hl1Zc9PwjbQCbFqupMi8p4Nlaekw1CiVETEWT1kzCFsU1R7UBG2obdSaOmGPMLOCHRikusD7wFGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726435; c=relaxed/simple;
	bh=iSH0E9Jcm6t+rPOS4TpUMQxQr8jXQhrI9k/PEa2IzKg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Rai6YstbZK7QJrH2pIjx9M7ktiIzu+hPBt0dBZoOKgVVstDYsNxGrPa3dUSjSCgttgmu9xhh0/wSEKJhPN9n1XYoiC8a7nUOvH5Wt1LkgZVOc4rOf2JVUIMxTgBUlmljKXADtsN2pyrxfwNZOu9Abu+pdExwqdVdndO556qYT0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=uPu+QSuB; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="uPu+QSuB"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D579BA50C5;
	Fri, 18 Sep 2026 12:13:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789726431; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BeKJdR2NSxrN3rpWoNvn3da2FZBpXXOFyJAI5e0BdvA=;
	b=uPu+QSuBBxQX2dbNNqCwNE72mXw+EBqES9hk8YUmYSTBGgaHy7jBymppmDI+f5MHitH6e2
	B/duV3iwr+kR8QI7g3qLhTtSA851ar62Rm/7U2MDVoh7Ob+nMKMwr1Ff3MKnpSamRgzbou
	MHM4+Aaj5ebFiGj4g754iO+IkUKCm/Ac2NzW0XzFgh+6byfr/4paXcs/4G0LkdweqmztvS
	g+hCDYOUTkkNzWE848wmIjZ6PP0m/gyrnFteFyGZV9OCETv6Ww0RyQwkW/jPM4z0TWmEjU
	thVrGqfE7yoZSjLZj0sJ/qFe0mn4KU1xjzAtQvDLp1aMULmGFuf7SAfbC8FRaw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 12:13:50 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Cursor <cursoragent@cursor.com>, Doug Berger
 <opendmb@gmail.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>, Simon Horman
 <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 8/8] net: bcmgenet: mask DMA_TIMEOUT_MASK when reading
 DMA_RING0_TIMEOUT
In-Reply-To: <20260918000732.276506-9-florian.fainelli@broadcom.com>
References: <20260918000732.276506-1-florian.fainelli@broadcom.com>
 <20260918000732.276506-9-florian.fainelli@broadcom.com>
Message-ID: <deed740324c4daaa945d1bfd065bf92c@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 18.9.2026 02:07, Florian Fainelli wrote:
> bcmgenet_get_coalesce() reads DMA_RING0_TIMEOUT to calculate
> rx_coalesce_usecs without masking out bits outside DMA_TIMEOUT_MASK
> (16 bits). If upper bits are non-zero or contain status/flags, the
> computed value of rx_coalesce_usecs returned to userspace via ethtool
> becomes corrupted.
> 
> Mask the register read with DMA_TIMEOUT_MASK before computing the
> timeout in microseconds.
> 
> Fixes: 4a29645bfe6c ("net: bcmgenet: Implement RX coalescing control 
> knobs")
> Assisted-by: LLM
> Co-authored-by: Cursor <cursoragent@cursor.com>
> Change-Id: I4c5b5019e764dbd0c7e51bd8c7365939a4736e44
> ---
>  drivers/net/ethernet/broadcom/genet/bcmgenet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 3a6a2f075959..b15e64a484b4 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -852,7 +852,8 @@ static int bcmgenet_get_coalesce(struct net_device 
> *dev,
>  	ec->rx_max_coalesced_frames =
>  		bcmgenet_rdma_ring_readl(priv, 0, DMA_MBUF_DONE_THRESH);
>  	ec->rx_coalesce_usecs =
> -		bcmgenet_rdma_readl(priv, DMA_RING0_TIMEOUT) * 8192 / 1000;
> +		(bcmgenet_rdma_readl(priv, DMA_RING0_TIMEOUT) &
> +		 DMA_TIMEOUT_MASK) * 8192 / 1000;
> 
>  	for (i = 0; i <= priv->hw_params->rx_queues; i++) {
>  		ring = &priv->rx_rings[i];

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
