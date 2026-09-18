Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6517C4BA1E0;
	Fri, 18 Sep 2026 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789728231; cv=none; b=YoA6qZB19I+BJ/psczwDN8z2qj257trCVUNMiOSz9KA8S+N+RNjA3nghG0UIcB0ARixaM2/mIR7EEof6M5ywG8n56Os+/PZtKztGj2tywRgeMG5K5KRtJjuCkoKRDkKfBLG1xZKm4vpCoq6tR6aOp7hB076EkTlmvWjU7v4Zy2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789728231; c=relaxed/simple;
	bh=4+vvzHzG0DzCFQhtqKXeSvm6fSUrgbGBjid2fbwe/Eo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dHIsPEcRQaZVFKnFkwT/0QoDBewptQMA9b9uBhJbnUGbDBkgK0rpHzRb9f4KTDrpk9KppviAZxS3yVZQIoxJZC133/KU737lIabpUa3lAXh3r4igkxfiR43lg3MRc2XWRVwtzmcBgORckW3guOi7KZGRtk6Hxbbc/RqQhped54Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=cjHw+FAK; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="cjHw+FAK"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 23664A927F;
	Fri, 18 Sep 2026 12:43:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789728225; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cBS9jomX1/O/L/Bls6/vweIhM6Xf83WcCYutAT3K5mQ=;
	b=cjHw+FAK0UAXDPh1/u+WbaTlhbPLaOdfJucZZGOT8AnHLdrsFYMSc5Mg8qFFS95u4XpWoH
	A1PhdFlfSGUHQEjpeqHsdTsERgXX71ph3Yx3lblop5TO5zzPbqg6jYSbujGNrtwt3JXWLm
	StYasiq5pfMnVZuAn+mEu691EuraCZ0HZLaBtFOZJcXhw68hngBRqm/7xOEigOXboQ/AtK
	T8PoAegE+dNT2IPrP/Q2tMe+ISlwOAhwoOiLxrTiTy5xFIxGhRwUfs7HvmHnZ06qn1zT7n
	+22uEsKmedgISA3dfhCRJR10IkDaBDY1BbJR5J9rYrKjUWfUywwBXrOmYG8okg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 12:43:43 +0200
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
Subject: Re: [PATCH net 4/8] net: bcmgenet: clean up RX NAPI on
 bcmgenet_init_rx_queues failure
In-Reply-To: <20260918000732.276506-5-florian.fainelli@broadcom.com>
References: <20260918000732.276506-1-florian.fainelli@broadcom.com>
 <20260918000732.276506-5-florian.fainelli@broadcom.com>
Message-ID: <d8b67a2402ec38f7cb374c5b223afb81@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Florian

On 18.9.2026 02:07, Florian Fainelli wrote:
> bcmgenet_init_rx_ring() registers a NAPI instance for each RX ring via
> netif_napi_add(). If bcmgenet_init_rx_queues() fails while initializing
> subsequent rings, bcmgenet_init_dma() frees the RX buffers and page 
> pools
> but fails to clean up already registered NAPI instances with
> bcmgenet_fini_rx_napi(). This leaves stale NAPI structs on the 
> net_device
> napi_list.
> 
> Call bcmgenet_fini_rx_napi() in the error handling path of
> bcmgenet_init_dma() when bcmgenet_init_rx_queues() fails.
> 
> Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
> Assisted-by: LLM
> Co-authored-by: Cursor <cursoragent@cursor.com>
> Change-Id: I45982e0e198a44f3f56b1300f462870462b81108
> ---
>  drivers/net/ethernet/broadcom/genet/bcmgenet.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index bfb74dca55d6..ef155a170fa6 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -3167,6 +3167,7 @@ static int bcmgenet_init_dma(struct bcmgenet_priv 
> *priv, bool flush_rx)
>  	ret = bcmgenet_init_rx_queues(priv->dev);
>  	if (ret) {
>  		netdev_err(priv->dev, "failed to initialize Rx queues\n");
> +		bcmgenet_fini_rx_napi(priv);


napi->dev is still NULL here, bcmgenet_init_rx_ring() only fails before
netif_napi_add().  netif_napi_del() does netdev_lock(napi->dev), so this
oopses on -ENOMEM at first open.

rx_queues is 0 in all hw_params anyway, so there is nothing to clean up.
Drop this one?

>  		bcmgenet_free_rx_buffers(priv);
>  		bcmgenet_destroy_rx_page_pools(priv);
>  		kfree(priv->rx_cbs);

Thanks,
Nicolai
