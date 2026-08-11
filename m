Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D606722E3F0
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407972; cv=none; b=kHeTOjm6rDhffSsUCvSTlx7sBmtZ8IbyFVvxA6jJ2rdJYStuJhd+c3dliPNuL8xLQc6WbCWnP3exqix/HM9wIcx2fK4Q70qRPdP2Fc75yDrB87FZwj8UAZGinZBC3tM4r+pY+XfcuuoOLvN9vRqRtyYS8rbTIOBJG7m79PMYY6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407972; c=relaxed/simple;
	bh=P/fL8kGnlyscba7QW/lYS9gXhr6STGQSI5DJXPhuQoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHwHEYmRS1UDWNZkmPgeLvTgoFu9eFW6Xbb/B1dP2JgyeY/c9ovxrIiKfZc/LZF4IToKQSHaIXbuvQdr1M1hPrkF3dmAD+O3oq5U0pjil3b2gri4lLGVeiYEw2kFiG9L6fCqMMz/pcETkpIi34dwV0gJZRyX6dvaNj4T7/ngmS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0qDMiqX; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0qDMiqX"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-380fbfae1a2so292424a91.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 17:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786407970; x=1787012770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IhRbvmHYXhFQ9Cyt9TR3UOP/9MRjlVWpX8ibWI5vEl4=;
        b=P0qDMiqXSqFDLAqwFKu6JsOfNIXkrWDOB6TM77m0bxZuQ3vtj7gT/1lphoWthjyYaf
         87ZGqjzU/UFnkRJcQ9IoYQWuAMGmIUDAhKYyTk6nIXn9Uh/2FC2GTFb6kbANs9HYcYjf
         P4RrEs4ufPqQDvGAIfS0cE7Ve3OYjG7rPGrO3ls7UnJM0DVzcMnkTcr5wxgknBLwNgv/
         NtD6/4Du7NXjAMVIZ6M7E7lri2u9k0yjSR1yZaGAXp/iK7zp4j8yTgEGS9mCV8DSKTqs
         QiejSsbLMevb1bZwtWbBFyRFLdnHBHv4y/z2olMMISYJTNXjOvr/FdYFbziSHRxiBQi7
         pcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786407970; x=1787012770;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IhRbvmHYXhFQ9Cyt9TR3UOP/9MRjlVWpX8ibWI5vEl4=;
        b=C/iezYwkye9taibhuEBwaRIdUSCWtXd+s0vSLDIQvNqTjEyCmvALKZTK05i+I2PrM4
         FI1hTYhJ2g0U6Koi1IvHHedLlk64ssbwUAy7BNM4dvJLrakAtxqWKyvczO2WPlzcniNt
         mD9I0OOjXLLw3g4+MtU9MIuY7Xfb2I//QdolLXAXb5L37P8+kyMZx6CYL02JZK573YgX
         Tn8hWDLGGqXlf06jlbT2S75Oc63MTUnbMq378R9nvzJp3L0JDCd2SuF8vLlhkVCoBTNi
         69IbXrwW7rMvkhQl6qAQRJJsyD4ooBNnNY+09227WcZdcZF0lQjHAz+VtasaTrsULyRr
         ysYw==
X-Forwarded-Encrypted: i=1; AHgh+Rqi48l2vvDGpL/eMokH9izmdwA4Ux8a4t4aQ1ANMWhIZatcEKSTxswS5QzTvpC8sBtCse9qpPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqPn2wC9w7khHv3ZjAuuA+Hjoio9solUHJ76F0pCvRqdejR7fn
	b8xfQsBjjPEKiQD0esUjsBBbnfa8nicbfhnZNXbDpkvbBZ4Rc4EifWO1
X-Gm-Gg: AR+sD12M0jWfKijwcOclHtKsAXXhCwBTWtqnpEiC47oqgP5UtbUycRob6MyzR74T8F0
	0+oZEGV98rrk67COitnzFcGfrm/Tks0HQRRonyccaCMZp8mDjV1Q/hwIp5Z9H9md9/ShFSyk88Y
	fGUSwWECKbHp1NdMGaWyC8kGqMnw6fSx/QuB7cg64bCNhJZqMlTTZmSY3vYGfY0Djik3uZO3PES
	bY3poKjck4H6qGFNn6cUxAKhYl1/G473Tu7YxO+JZDfvY63Ns7kRwUP/MAwR4YZJtf7EgI4etJT
	GqklkzzWuacTQSY7DjWln5tql9UJuLj/YlJ/FeQX3LMbvwcNoyAjSMptg1Z6AcAy4ifFiDItKG1
	kMAZzZs28KHiQ3FUebocxqJJ4JeW8XjIZuGXXi3hU2xSHhnIZEfR17I/LPyE9E35CFR1CrHrxJ0
	CRN4C6HtVUIIucwFv7+Mq8Yd3cnZbZOkAvdWVm9H99axHRoNS+1jS7RA==
X-Received: by 2002:a17:90b:2d0e:b0:390:b3c5:e2c9 with SMTP id 98e67ed59e1d1-392d61cf225mr976242a91.17.1786407970093;
        Mon, 10 Aug 2026 17:26:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4c::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d4050827sm1306069a91.2.2026.08.10.17.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 17:26:09 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:25:54 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, tariqt@nvidia.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: devmem: add netdev_has_dmabuf_binding()
 helper
Message-ID: <anpr5knZj33e8d3S@devvm7509.cco0.facebook.com>
References: <20260810175446.3945358-2-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810175446.3945358-2-dtatulea@nvidia.com>

On 08/10, Dragos Tatulea wrote:
> Currently there is no way to check if there is a dmabuf bound on a TX
> queue. RX side has netif_rxq_has_unreadable_mp() which gives a hint of
> it.
> 
> To help with that, this patch add a helper to check whether a devmem
> dmabuf binding is active on a given netdev, optionally filtered by the
> DMA device the dmabuf was mapped against.
> 
> This API is necessary for the upcoming support of data direct in mlx5e
> to allow blocking accidental swapping of DMA devices while devmem is active.
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  include/net/netmem.h | 19 +++++++++++++++++++
>  net/core/devmem.c    | 20 ++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index bccacd21b6c3..0e332e04ea16 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -363,16 +363,35 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
>  	return netmem_to_nmdesc(netmem)->dma_addr;
>  }
>  
> +struct net_device;
> +
>  #if defined(CONFIG_NET_DEVMEM)
>  static inline bool net_is_devmem_iov(const struct net_iov *niov)
>  {
>  	return niov->type == NET_IOV_DMABUF;
>  }
> +
> +/**
> + * netdev_has_dmabuf_binding - is there a dmabuf binding for a
> + * given @dev and @dma_dev
> + *
> + * @dev: netdev to check bindings
> + * @dma_dev: dma device to check, when NULL it will not be checked
> + *
> + * Return: true if a binding is found under @dev and possibily @dma_dev
> + */
> +bool netdev_has_dmabuf_binding(struct net_device *dev, struct device *dma_dev);
>  #else
>  static inline bool net_is_devmem_iov(const struct net_iov *niov)
>  {
>  	return false;
>  }
> +
> +static inline bool netdev_has_dmabuf_binding(struct net_device *dev,
> +					     struct device *dma_dev)
> +{
> +	return false;
> +}
>  #endif
>  
>  void __get_netmem(netmem_ref netmem);
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 957d6b96216b..f13a0e343684 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -364,6 +364,26 @@ struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id)
>  	return binding;
>  }
>  
> +bool netdev_has_dmabuf_binding(struct net_device *dev, struct device *dma_dev)
> +{
> +	struct net_devmem_dmabuf_binding *binding;
> +	unsigned long id;
> +	bool found = false;

xmas tree. Other than that LGTM. Presumably it's better to ship via your
upcoming series to show the actual usage?
