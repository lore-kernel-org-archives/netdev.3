Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0AA3655F3
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786545029; cv=none; b=uQOMeN+MgNcKKKD7iOsFOqr7+FQj0tLPVZuDPKrvipEd2DQGToXtz38LDXO8RJorxupPwFuFjr1alP9fFKLwwrmflfhbsTkV/A/1B88r6Lm2PZgnzmigWv2x+vOK+8psMDSUbmYbSYI4fyZ8vQEtVzF5i64/g++7EQLufGpflAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786545029; c=relaxed/simple;
	bh=wcZettSTNfqOlFlLGgZdWldeIxZP1hJuwogqXfpzyUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWFwmJGsNOCT8RopdLuOpN9C/qUG0SFSShCeZ9lx7A/mn4UhaJ0z4lm0FumUDDFOyNlo4r5ZznoEYfh8IESj4BA+qY1Mozq4EwhnrH9zBmEShOUEt+1WN2T7Upcm5/jA7awnUKqO3FhWrEOaKpayO+F9xWvaage4agJ9GuQ68ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=PeCLprZl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="PeCLprZl"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c197e7e4e94so190743266b.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 07:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786545022; x=1787149822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yMT7PPQ1ysktkS1cevhGzCC9k5h/+zORJkENpAoJdlM=;
        b=PeCLprZl8gyFkTyhOYKuMgrdkwtGAmI0/gHeQGEEQZ5FZZ612v8xSUvkY01NPwTSTP
         zo25TXQj4KHHHfXgcS3Kmyf6f8Wr0yuJh7bNClQJT0ZE89T4NVIpXlCGyYysy9z/Iz6g
         qvxTrzYuT/w0ZLooNiy/KaJ16UTVrmqX/bQclMkyKWg25XX/BG9p0e42TgWk2iESoykA
         vAYcWA7ep8N+1JWbboklcvcI2Xyoqa8xS3DGIreK4EV5Ar0kVxNzD29YNS3NgT+2gKBb
         ErrooJZJW/QDDwIb5j6BcQLIeyolpe8YaRXKkkhLjG48bn7WuW9ToTmsmxRRp+p/f8MJ
         3MAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786545022; x=1787149822;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yMT7PPQ1ysktkS1cevhGzCC9k5h/+zORJkENpAoJdlM=;
        b=O6xJDZAovmIIpiia1kJtbNuMD+Kn0E53Ek6EMWXSwYgk8SYuYBEXb1dhwwlE9Z/3E3
         34VNFtAAre1IuYTYewPvXz9O1EpwWUxAlleuYbZpyE66QatY32NscVar+soGz3NnMjIo
         JHZzO0hEv42K3hbY4HwdKlXUdO+HSOko684ZBhiGmR5hfuzPVPbY9ThdNO8az6ZwWQvW
         kZPKvjKfakdtZeRVSQjvH/vaPGXD6cg4Ul/JrxmwsP1ZTFqLGXfgY4IVtxLNDtH4Xfz8
         okdIeMU8nPAS8vkJxX08w6NxHzyIpp1cEnBm8TOsUs73zGCjJD7a/JkRJc7eRtVhJGw0
         h5MQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqeblcuy/GXjUJFoh3VOHP67nrLDM3KTxrdp4Y7E9JVb/tPoqsCptTPd6RS6vNT+KUn3H22//g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPT9HX1410Lf1og1fA8lVzmsVCwobYdAnf5iN3fVMidtmfdDtZ
	Vau2JLoz7SGiflvHU0PWlPTrcUWxILYufuan5Lsd6Rv3f8vaVouFJu5RmsDwzO6haBc=
X-Gm-Gg: AR+sD11zVKjh6nKSfgIgxXH3+svHT3mWRJ5J0lktjfen6NFIourVW0uf6HnEBX3JCle
	zc0P+2mb3VB0EjE1o8IYupEEH5IkQi9fykv92rBxyvpc9GNyLVIukanMlLXnjYME2zRq2Xcy3+o
	zGZuqZ4TxYbqhRboLgr/slMUKfhwY8sn/rt+fLR/Qmay/+mLDtzxRASH+bRUZTR5FX53PNqTIvm
	oEiXf+bClPaVxcwfN4I1VlOyW7eAQjpQ/CqGz5JKO+7dYhgnMYHPnXymQx3yQuB/9rEks8mvhRq
	AULoOt2C5EKQ1FCUKhbjtOKTRsy8hqdHD9/TiRBkOcIDoxZQ8XHiFwg/axkAfejeepaTaMI83J3
	E+VGsXKCceibG6yp6jAEcP9FGVIX2hrfa/yU/fjGtZPzPgZ/zjnFsU3Rsu2sWzItR9TuRGtFZYy
	FOx6hdx0O56TSzHZR5ZcvBHpgB3l3OHX4QdLPJPUvKronhncjyhEqO/GjGaNt7AM8GKuU/0PXDq
	ZyS+EseisuJ43j18SSFu3JaxeCktR0=
X-Received: by 2002:a17:907:1905:b0:c20:7557:d986 with SMTP id a640c23a62f3a-c20f2f042a1mr256702766b.13.1786545021983;
        Wed, 12 Aug 2026 07:30:21 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3769ad71bsm835132a12.14.2026.08.12.07.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 07:30:21 -0700 (PDT)
Message-ID: <e4624ff2-53b5-4cfb-9c5b-aec34f7e7b3e@blackwall.org>
Date: Wed, 12 Aug 2026 17:30:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: convert netdev_nl_sock bindings list to
 xarray
Content-Language: en-US, bg
To: Shivaji Kant <shivajikant@google.com>, netdev@vger.kernel.org
Cc: praan@google.com, Mina Almasry <almasrymina@google.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Dragos Tatulea <dtatulea@nvidia.com>,
 Kees Cook <kees@kernel.org>, David Carlier <devnexen@gmail.com>,
 Yue Haibing <yuehaibing@huawei.com>, Daniel Borkmann <daniel@iogearbox.net>,
 David Wei <dw@davidwei.uk>, Maoyi Xie <maoyixie.tju@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20260811142958.160088-1-shivajikant@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260811142958.160088-1-shivajikant@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2026 17:29, Shivaji Kant wrote:
> netdev_nl_sock previously used a struct list_head bindings to keep
> track of active netdev netlink bindings, protected by a per-socket
> struct mutex lock (priv->lock).
> 
> Since list modifications and iterations are not concurrency-safe,
> priv->lock was introduced to serialize operations on priv->bindings.
> However, xarray manages its own internal locking (xa_lock) for store,
> erase, and iteration operations.
> 
> Convert bindings in struct netdev_nl_sock from struct list_head to
> struct xarray and remove priv->lock. This simplifies the code by
> removing explicit mutex locking in netdev_nl_bind_rx_doit(),
> netdev_nl_bind_tx_doit(), and socket initialization/teardown functions.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Shivaji Kant <shivajikant@google.com>
> ---
> v1 -> v2:
>    - Add explicit err_erase_dmabuf_bindings err label in net_devmem_bind_dmabuf()
>      to align cleanup paths with the rest of the function (feedback from reviewer).
> 
> v1: https://lore.kernel.org/all/20260810065759.3735934-1-shivajikant@google.com/
> 
>   include/net/netdev_netlink.h |  5 ++---
>   net/core/devmem.c            | 14 +++++++++++---
>   net/core/devmem.h            |  4 ++--
>   net/core/netdev-genl.c       | 25 ++++++-------------------
>   4 files changed, 21 insertions(+), 27 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

