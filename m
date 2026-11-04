Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793808871;
	b=hFVgldZ6SG0Uhob0JqD4gdu+StiG3+iundKWivJtPeQpgAr2ObV2KEGiqG+UneOnwjjR
	 YYpQPnPA+HoV7Ui60Bhwqa9dKeVJxFBHWUaLvRyEwnj11ScgheVYVfGwGNUa3Q7YA2hEy
	 GdUtSnyxPY8UMV+VMXykASJv9aOOS7hZO7NLoxSUSlCeXT17n5gurk3e8TzdbtMM2vWmd
	 eHS7K3/xrrOyxCBkF2diAn9eTESoYKJGLROoqFQtN//0XE73S+wDvVJR4vPgq+enLUfwY
	 Yo2cdh54o6W7D0IJif6iNAD7iLD6tHQEnoMw9kUCqCjxX8Zio97kZ+3XDthivUQFZXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=2ZRVEb3uxaxxpFesD6mkqxkpYWx/oMieXN2/50UShAY=;
	b=IAknmibneXuAPpxJtPZW1zpWBND03Gh0NmSJOBmENaa905R4JuppCyDIhZNah1pjrTjw
	 +bjvXeF8MOv8alROhueM1+Vvfb1NNrUSIQj1h9iVi10SbfnZtK/OtRAOUDCX/UCSoS63g
	 svJ7R1DYjZboj7RLwSCnZEvwq5PQbz93GczDAcwwzGGBhFp9K/Z0buikbV12ajmTwPQkY
	 MQc/Du21MBlFhdFLZZdFKjJ7iCSTFCG5VOsRIjM/x4XnYTkI9uyNGIqtximMoZ0ASPpAU
	 1yA6F56JBaIS6dLG4b5OWaSlWFp2lg2jZzXiAQTO4NdZ9facWS8Fc8kkO6MD6+AJJEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IuSJLkep;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8094E606A32E
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 16:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8094E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IuSJLkep
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-85ac281604dso481512a34.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 08:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793808868; x=1794413668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ZRVEb3uxaxxpFesD6mkqxkpYWx/oMieXN2/50UShAY=;
        b=IuSJLkepLgOArjmNbY3qRy4/aW97zsadqKol5nVhQIjaLRZbMapm1gA7KVin7hCcIb
         XqbvwN5IRjwz32rI7YvqZJYAZIAw3c+5OTUYV92u9/URZU+PFf7Jk9HGtGAFPw36fGl4
         LIqSP3X0ArMMI5cw2fEHT3N/v8BiiNH3y6PVpR6fx/KzH+99By4wr/bTFUIk+rhl0ad3
         XCmwBdYcfT8kWo/x+iYkwx8l5KfJcWaoqL5thS/Q6hbb3lLG0bPh5f7dMGXPekdZdC+r
         dHS8p+mGCpuXaIIB/wMS0/nvmm1dg15mBpmkz+ZXXOgnShD+GMAhhsFhZtjKlKeef4Kd
         m1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793808868; x=1794413668;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ZRVEb3uxaxxpFesD6mkqxkpYWx/oMieXN2/50UShAY=;
        b=lDnRmYYdD9OHEuymfkChgffnBvGB+s5QJu7ymiTZyWd66DUPT7lILyGQmth250gTUg
         9QEM5qKxLH9PlxiA21bk+Q45w3FaglM7ATjtvyMM30Uj9s0+B0fkb5wRVNFSiCysdww2
         btE8Lr3OyOHgaiTg6o5ZHNhoj4uUuJ5yJrvwie8t0vj4wPT4pbUm7VvpVIRXpZ9GoVyJ
         JosKC7VaXsxcK8Rhp7sHYsHm7LAhZM2giCbjjH6fvt9VllxLlqFpqvKlN28sUjakazuW
         p2CXQ4nZw2wXyHKmNfYo/v62wTu3jMf+1arX3g6m51obpUznzH1picwCpxsnS7BHzrGI
         r8gA==
X-Gm-Message-State: APuU4Z+RHRx5H0h1E26+QALTKxxCK4bU8Tb7sEEOmuJj4T9wh6Zeqz6n
	I/ev/XAfw9ETJqnUFNHv80GZZxcnngnhzh6V5vN5N95OxFbEvCs27x+gJqBkTKsXlGizxkFOvfe
	8DpP3flY=
X-Gm-Gg: AYBFou1KpjI6sqa1hLFU2dLpNBY9+vUypL2kx1HuIUBZUckiGnYpx8h8FZ5cROTB7Bm
	8aEOh+vLLqbsWn/6rf6/cLj1JdybWPHqR4K6Qa+8Lxx6TT/i519Vvy/k/TE0LiFNpBT2X3kP0J0
	NmEH0ouiuxWyxXYkZ5MV8dQl6WrN/o6H0ICeU05JV8cQZemHLFmtFIbN8HU3T3Mh1Kkk+R3VuI/
	IeuAPbav5aIHxxL5qaVH7cwVukjGEfgx/WNJxFe4dO4I+V6bomiHx5azdomp+Wv89YT2OESY+OX
	wMhLgZEmeifS4XIR+Hz4R2lOfTZv8cOuW8ZRiRJJuJHxHw7KjyLSgYNmGQAT9Bb/ZahboGPLxlm
	TvWJ7oo7HE7tLGnSC6KkViJ/p2yqOsjXGOsK1dDHAmEbQtjBl+zs6Hjfw8vpKqVu8lQv/sKhDmm
	wZr1YVhlRJQXyTG0dyy8qU+vjDgYedc7IZlp7wrMNBpQQxJUpgr5YQpsXwdWKYPNPM/GCZjSV+S
	F3ED6yO5X5oY1JTTWmTLOA73osnwPMPE7PYWfKxfB26LgvExiMl6rTiwO3p2qyaQBgKgZE4/BCT
	9mONOzSGXo1Wzr6W54/Jj/5EwiGKuZFPfLeJQ95OVr+/qjC3fDlB6VQMEBlDaK4B+lBAfO936N8
	lClAeA1ty
X-Received: by 2002:a05:6830:2695:b0:805:2785:fad5 with SMTP id 46e09a7af769-85d36536870mr10734286a34.27.1793808868398;
        Wed, 04 Nov 2026 08:14:28 -0800 (PST)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3a1da87sm2246465a34.3.2026.11.04.08.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 08:14:26 -0800 (PST)
Message-ID: <1a338198-527e-418c-9e0f-2b619ea84e71@kernel.dk>
Date: Wed, 4 Nov 2026 09:14:25 -0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring] io_uring/zcrx: don't sync for cpu dma-bufs
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org
References: <2cf944dd571364e249af5fefcab07bc670bce842.1793623006.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2cf944dd571364e249af5fefcab07bc670bce842.1793623006.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 5:11 PM, Pavel Begunkov wrote:
> dma-bufs follow different from normal memory rules, we don't need to
> sync it for the user. If the user space wants to directly access it, it
> should use proper primitives like DMA_BUF_IOCTL_SYNC.
> 
> Fixes: a5c98e9424573 ("io_uring/zcrx: dmabuf backed zerocopy receive")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  io_uring/zcrx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> index 6d7abb1636e7..17e554bb774f 100644
> --- a/io_uring/zcrx.c
> +++ b/io_uring/zcrx.c
> @@ -1425,6 +1425,8 @@ static int io_pp_zc_init(struct page_pool *pp)
>  	if (pp->p.dma_dir != DMA_FROM_DEVICE)
>  		return -EOPNOTSUPP;
>  
> +	if (!ifq->kern_readable)
> +		pp->dma_sync_for_cpu = false;

Should this clear ->dma_sync as well for this? That'd bring it
closer to what devmem does.

-- 
Jens Axboe

