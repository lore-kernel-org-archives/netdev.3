Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07734BE43B
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545049; cv=none; b=JNEzYRFm+jhdDO5OWCumjO5X4QWi2d/llmBT9MaGJaN8Me9iBOXuNxe6bJ8E8qChdMyv8nCx0KNURWkF/gpdHeCGlMwPwpsXJtzMkI95M18d8J3RgxOQ3KUjgfazc35NHVlC0Gjav5cqdXfW3/39TxXXfUNrIGH84Q8SWDXMNSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545049; c=relaxed/simple;
	bh=V38vhjeTzp3k5ITMNDV6z39rmdMCvkYnm7NSfqrDfZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2V6+7X9kC/+w6/S4APIUxn3dcuCAkgeiwuXoJlE0wPKQ2eFxJvZo5ct17UpDliSqUnDMZkfh3Ut3DqOnUWdhImhxC56T5t+oA21Y2/bPFfyVadajp3ucaCnU/4dLrE0Z7AlmnwQeMkGcTVd/MH2ZcSrmXgZVGGQld+QKHTLFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwTlLord; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwTlLord"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso32062425e9.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 04:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791545038; x=1792149838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l0FDlo5X9NOcg3UrYdd8gMV7/2rytUnITD56A6AkawM=;
        b=GwTlLorduSK1NpYlzvs3WNkPYiWfIiRvgHsi6RKgfw6N9HA+hJJBE1rF4Dk7HeksZY
         vNh6Q3qzFbq9PDY/dS+CaPLTC36BMQhidW3ULEY9WfVvgood/8r1rBbE1wmk+mRWlZfm
         1qRE/IWyzcEzjlm001veLq3ldAC7aHGqTEU6yQ1PRDfWJDzC1+EcTInuwyo/K3dbfQjx
         mrn6OMJPVdZOi9BCOOCt2k9wfRrdQWyrnL+FHVq8TiFM3imY7IQo2Sf9bzuflkjPXjQe
         foHChqp/Ps3XZA1DXyr1dXZUB4T4H6IwS7qa1a7xHg8ANHPiuArSDsTW8G1hPs89J5hT
         J1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791545038; x=1792149838;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0FDlo5X9NOcg3UrYdd8gMV7/2rytUnITD56A6AkawM=;
        b=FUmnX452cgoEcCB5j+oVZfjn8PpMxb1U32/3oE0DX+h1XxOF8+p09BwlClNUrPyFCE
         ypyMp+8hf1Xlk7DSG96K/QR8Xm2G0lrIRIVZe+COXEV30wnYSsT42kJU4ZOIrHEuq9PT
         zSymBDvofDw03lpHB47BWLwjnGZhKTzC3qwfErulaixJ6kj5OYrDRH+MhrCx0x1Yglz3
         RMaZ+7gwN4rinaFgjFryKQUmplfr51BaMccAeL+aYF3tBKfrJg3gmSbOpVqj7Nu5eQQN
         0s4DHvyZ03UpdGqFE5Fvul0kHMmm8C1w9VR78arOXaXU3V33c7ObpZumDyXDOcLfork2
         D0aw==
X-Forwarded-Encrypted: i=1; AKwUvBz0mo6t/1VnWsWfy3O8uwb9x459Svp4/JMRwYjV9scBW0veM4Mr+FtuVcXi1mLF+XEW5mq4VtA=@vger.kernel.org
X-Gm-Message-State: AFuF++m8+pht2KvWGGpYlG7a/N1cjpuBw9bFULNZCkle6+S6nHF7CtF0
	0KFEoRA9ORP2MjM+Gqy6FVPLpVSY6jUaWAxlbBQ028G7zbi1K0vh0wGC
X-Gm-Gg: AYBFou2Smr5RIbVeQbtPk5u7B1ixJ7GAetTk2rxIiO1Clj69fSIOqB6e5Kmkj1qAQ4B
	W7tDEd6W3rei78FBkqOps9CTAWxc4E1KYlr2CwU5ZrdGWKol4v0N34fl9wriLV0TZAB2udANgcz
	Q9Fpi/PXwJHyxpW9jTxPb7cLq2k6Lu2OE7tV/20gTcFWiMrvo0IazM1IfFfsPcz5qkWMOUI8WL3
	HsZL9PpJ9ltlKRK4bJwOzbnAoHU/jpyBOMGl1vl4VOHtd63DX0d+GUl2JLObxjEoYgbZmhJylsr
	BWR+l4C7WSQ0h5EUYQWKWmk+abgdo0chOdE28qaY+mHN9kNIMivrxp0pDm9jpP9ef5YHD44h8L2
	hOqJmcrLEqLG+z2EH2uwPEHOSgD2HckR/mz/q32d+XfFrgC+zSiMERnwKtyC417eC7F9t5MZM9a
	+kTq1Agb/+3uqR+uvm7+hh3LCaCeZj4U12p0BfAaAXbO71RftVxEdEp9oTBZ202HzEmL5MeGya2
	c3xfKERJd3mY0x9ur06oGFK8YclHhTAjjryEJpctN01G+jJS3fACK1+J+XKDdRxIHOKqeA8P7IG
	GvyRh3xPmPAN7t7iI00g8S8G5VATd7S0OfLB4bOADiCfJc0g
X-Received: by 2002:a05:600c:524c:b0:4a1:825a:5726 with SMTP id 5b1f17b1804b1-4a18e4aeaffmr31536085e9.31.1791545037794;
        Fri, 09 Oct 2026 04:23:57 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be8c669sm58317575e9.5.2026.10.09.04.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 04:23:56 -0700 (PDT)
Message-ID: <bed0a0c0-1706-441b-926a-fe568dea313f@gmail.com>
Date: Fri, 9 Oct 2026 12:23:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: do not charge user provided SQ/CQ rings to
 RLIMIT_MEMLOCK
To: Hengyu Liang <hengyul@cs.unc.edu>, Jens Axboe <axboe@kernel.dk>
Cc: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <b5a33433-b0b9-4231-9998-23e2a2202091@kernel.dk>
 <20261008170611.1285778-1-hengyul@cs.unc.edu>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261008170611.1285778-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/26 18:06, Hengyu Liang wrote:
> Commit 8078486e1d53 ("io_uring: use region api for SQ") and commit
> 81a4058e0cd0 ("io_uring: use region api for CQ") made io_uring_setup()
> create the rings with io_create_region().
> 
> However, io_create_region() charges user provided memory to
> RLIMIT_MEMLOCK, and the rings of an IORING_SETUP_NO_MMAP ring were not
> charged before those commits. As of now, a user without CAP_IPC_LOCK
> gets ENOMEM from io_uring_queue_init_mem() when their rings exceed the
> limit, which is 8 MiB by default. PostgreSQL 18 creates its rings with
> this function [1].

That patch you mentioned 26bfa89e25f4 ("io_uring: place ring SQ/CQ
arrays under memcg memory limits") has always been a delayed time bomb,
though memlock is quite a nasty limit. Makes me wonder if there is a
way to migrate it to cgroups completely.


...> The issue can be reproduced with a simple liburing program, run as an
> unprivileged user:
> 
> [2] https://lore.kernel.org/io-uring/b5a33433-b0b9-4231-9998-23e2a2202091@kernel.dk/
> 
>   io_uring/io_uring.c |  8 ++++----
>   io_uring/kbuf.c     |  2 +-
>   io_uring/memmap.c   |  7 ++++---
>   io_uring/memmap.h   |  2 +-
>   io_uring/register.c | 10 +++++-----
>   io_uring/zcrx.c     |  2 +-
>   6 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index c2ce83c7c1f1..2a16369894d4 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -2070,8 +2070,8 @@ int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr)
>   
>   static void io_rings_free(struct io_ring_ctx *ctx)
>   {
> -	io_free_region(ctx->user, &ctx->sq_region);
> -	io_free_region(ctx->user, &ctx->ring_region);

1. It's not perfect to make all these changes for a fix because of
backporting. Let's simplify it, add a wrapper and use the "__" version
only where needed.

__io_create_region(ctx, bool account, ...) {
	if (!ctx->user)
		account = false;
	...
}
io_create_region(ctx, ...) {
	return __io_create_region(ctx, true, ...);
}

2. The need to match alloc and free arguments has a high chance to
eventually blow up. It'd be better to turn it into a flag.

__io_create_region() {
	if (account) {
		...
		mr->flags |= IO_REGION_F_ACCOUNTED;
	}
}

io_free_region() {
	if ((mr->flags & IO_REGION_F_ACCOUNTED)) {
		WARN_ON_ONCE(!user);
		unaccount(user);
	}
}

-- 
Pavel Begunkov

