Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D663C943A
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830646; cv=none; b=EEUfL3hoCk6MgUDe9X7eu1BaAvyPMSmjcATZvOj77BCX6rtMxU3EpgWaL/hu8TZNYWf6zoSmNUDtoOF1oPZFEMkH0kNSeCMPHOSC35w0UQHt5knJSomypUC6ixa6Q2lNT5pFWSKt7+3PBJ8a/iJ2kSYC8iLyHexS5jYdc099yXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830646; c=relaxed/simple;
	bh=fzQz/YrviIwQ0Ix1HqFC536DtnfKWfAKYWMWvKAldYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UugRhjHvAidBPnTSd8beXCidKWb1r2d7upbocXligQlnxssX025NHse+XWbGFkJUJyENaXO17GvD7azOITm6vfpDyRiGwsZkX5iYBdytEkZgAFGvfBqOSCTgziXvyZLknh+LshRV5TSIdPikWJyfml9IMmGbBzv3AOwcIU4z5JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JrIzFoA9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="JrIzFoA9"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ad135063so19266585e9.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1775830644; x=1776435444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R7aglOIIkn+rsJVBdrit9b+LIWF415isue5Ccaul45k=;
        b=JrIzFoA9bslYDm8BiCPtdFZRsd8bfvmc6Bvm/5TgAbx0iUkbshCc33T9l16gk4uztk
         GTanABQXlVvtE9EPrIHPITrMWoRjcBq7w8DjXKu+wkzGCQvWIVbZ3f1UqqrQFyee0BXr
         2bGZNnqx+a+AnDWm2ago9vq1ybu+YP/c6pY6g8YrN5rzLGJqquUkjjwiwTwFpk7z98kO
         6hVnGJbGwBt3vFBUHtv3HihazwK2+bGNR0LVVpjk7POc4hcb6Crs3yeEMSnC6llfHHgi
         w2rADJDD891Mhzd9D+6I3BzIHecvgolhT9XaGpTQzEv7BWx0htRGJXGa/uq0Bk4uQo8e
         yOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775830644; x=1776435444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7aglOIIkn+rsJVBdrit9b+LIWF415isue5Ccaul45k=;
        b=rBWMa1VzEzflgPzswen0fODAEydYtar5xyKX+kf6l4/GCtRZmYcdMIm2RZs+4tHCXO
         LTmrFnqnpbYuUC3MUGbw5CWNmGVd+3XVFlWH6oCFUvDrVQeuNZgoYBSZRpqhHWb7WwRZ
         +MMlve0aNHJ58LmpqdKFpPoAZU7w+ywIT7NiPYv+Rt4iopQlHYOf3BrYRQqU7AaQbq9o
         5burtvsPHAKA5TATTWsTkut+ht8tiLShD8GjurBFmEBdgHffxflPMletSWoHYtvqw9+K
         IwSqNGxOfG1HQuIgO2ISQhzC4HSv8aEgA70GzJc9zVn0/nxqXUHap5WZbZMbMDNeYTVG
         b/fQ==
X-Gm-Message-State: AOJu0YzwuvFIwA5DiDMfPeXpwIo2Qp7S822ma8uWMztLrINGGqv7Pso8
	fzrqrhLX2fy2N/V31xUmjhBjKkeJAGp9DD8FI0PcBIOvVIsaR/hQft1R/70PTyJ0B64=
X-Gm-Gg: AeBDies7e7zD32emtHD8wXngsdZJgN9W9q9tFc7LQaVlC12+SJ6yOGoeezkJ5se3/8T
	RuO/dt7ib5de3hFMJJHM8ZASuCC0YcUm/cQ+c6fB3yz+CSaCH64iVUKU4SthbM9OtEIyCZ2XR/F
	2RD+7xbPibfeZP1mXXAWI402Xy6NabFhtX1Q3pdiD5NrKkVf6V2rkQDzp1dKyHpvHHy0LIZ6IJL
	1rM+n3zv8tDlYidp+yTD1+7MqZ0PYreqt3woVBjR63f/7GJ9rxjBXZvXyeI/HJr4N9dh8gu1sq7
	1HdvKlWq9E/rruFU+QArBBqAklcgG14JDq9xPDm9WKM04+n4KmjYQJuguoxFk+SJ/ijldVMBIt1
	djUyvx9remNfjGDqw+pRWY38vAjFcYOegaDr4Glj3rgKcQR3LDPHEh6uHcJlU2Tgm9SjXAiJEte
	dkNeACU+vqhOpPHeY=
X-Received: by 2002:a05:600c:a411:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-488d67ec72cmr34668505e9.5.1775830643175;
        Fri, 10 Apr 2026 07:17:23 -0700 (PDT)
Received: from localhost ([37.63.33.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d53807d7sm127283505e9.10.2026.04.10.07.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:17:22 -0700 (PDT)
Date: Fri, 10 Apr 2026 17:17:19 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, dw@davidwei.uk,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] net: Rename ifq_idx to rxq_idx in netif_mp_*
 helpers
Message-ID: <adkGbyOQRRYIb3w4@penguin>
References: <20260410130602.552600-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410130602.552600-1-daniel@iogearbox.net>

On Fri, Apr 10, 2026 at 03:06:02PM +0200, Daniel Borkmann wrote:
> Rename the leftover ifq_idx parameter naming to rxq_idx to be
> consistent with the rest of the file and the header declaration.
> Back then this was taken out of the queue leasing series given
> the cleanup is independent. No functional change.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://lore.kernel.org/netdev/20260131160237.07789674@kernel.org
> ---
>  net/core/netdev_rx_queue.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index 8771e06a0afe..de4dac4c88b3 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -275,14 +275,14 @@ int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>  	return ret;
>  }
>  
> -static void __netif_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
> +static void __netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
>  				 const struct pp_memory_provider_params *old_p)
>  {
>  	struct netdev_queue_config qcfg[2];
>  	struct netdev_rx_queue *rxq;
>  	int err;
>  
> -	rxq = __netif_get_rx_queue(dev, ifq_idx);
> +	rxq = __netif_get_rx_queue(dev, rxq_idx);
>  
>  	/* Callers holding a netdev ref may get here after we already
>  	 * went thru shutdown via dev_memory_provider_uninstall().
> @@ -295,28 +295,28 @@ static void __netif_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
>  			 rxq->mp_params.mp_priv != old_p->mp_priv))
>  		return;
>  
> -	netdev_queue_config(dev, ifq_idx, &qcfg[0]);
> +	netdev_queue_config(dev, rxq_idx, &qcfg[0]);
>  	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
> -	netdev_queue_config(dev, ifq_idx, &qcfg[1]);
> +	netdev_queue_config(dev, rxq_idx, &qcfg[1]);
>  
> -	err = netdev_rx_queue_reconfig(dev, ifq_idx, &qcfg[0], &qcfg[1]);
> +	err = netdev_rx_queue_reconfig(dev, rxq_idx, &qcfg[0], &qcfg[1]);
>  	WARN_ON(err && err != -ENETDOWN);
>  }
>  
> -void netif_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
> +void netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
>  			const struct pp_memory_provider_params *old_p)
>  {
> -	if (WARN_ON_ONCE(ifq_idx >= dev->real_num_rx_queues))
> +	if (WARN_ON_ONCE(rxq_idx >= dev->real_num_rx_queues))
>  		return;
> -	if (!netif_rxq_is_leased(dev, ifq_idx))
> -		return __netif_mp_close_rxq(dev, ifq_idx, old_p);
> +	if (!netif_rxq_is_leased(dev, rxq_idx))
> +		return __netif_mp_close_rxq(dev, rxq_idx, old_p);
>  
> -	if (!__netif_get_rx_queue_lease(&dev, &ifq_idx, NETIF_VIRT_TO_PHYS)) {
> +	if (!__netif_get_rx_queue_lease(&dev, &rxq_idx, NETIF_VIRT_TO_PHYS)) {
>  		WARN_ON_ONCE(1);
>  		return;
>  	}
>  	netdev_lock(dev);
> -	__netif_mp_close_rxq(dev, ifq_idx, old_p);
> +	__netif_mp_close_rxq(dev, rxq_idx, old_p);
>  	netdev_unlock(dev);
>  }
>  
> @@ -339,11 +339,11 @@ void netif_rxq_cleanup_unlease(struct netdev_rx_queue *phys_rxq,
>  			       struct netdev_rx_queue *virt_rxq)
>  {
>  	struct pp_memory_provider_params *p = &phys_rxq->mp_params;
> -	unsigned int ifq_idx = get_netdev_rx_queue_index(phys_rxq);
> +	unsigned int rxq_idx = get_netdev_rx_queue_index(phys_rxq);
>  
>  	if (!p->mp_ops)
>  		return;
>  
>  	__netif_mp_uninstall_rxq(virt_rxq, p);
> -	__netif_mp_close_rxq(phys_rxq->dev, ifq_idx, p);
> +	__netif_mp_close_rxq(phys_rxq->dev, rxq_idx, p);
>  }
> -- 
> 2.43.0
> 
