Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CA73BAD89
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438970; cv=none; b=blxKyysAT2dSOebXG8z37uADWPaMGOEBYozOwpa9G0Xdt1bo75CMv1LlNOB+fuA97NKPIpUatO/EwaOs8qQKp4B/pVuWmfv7UGI0cx0DUzKnixgACYkIoL9ph8/ygI9NuqpzLQO9MVs1rokeghSCPyZZZW7CCAEXmxgz6b9azYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438970; c=relaxed/simple;
	bh=5WHjlG72d+xJLtqAx/ToykbvdBP5gcv1x5UevJqlPeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pImu80ijr6OBRbGyYjaSWsI5ht5GVGdy2k1fd6hVsiQlttrOz/NfTfA/N4s3JJA4ORqcttcoeIOA539VaxDo7UPK0c8wEb6i8O2QwLaLsvHgU9HRWRldFLx/crYb2s2e5pbCP5fUpohYvm/RcIAjuq62ytyJk5pDDKQN03aKINs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pWKLjyvU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWKLjyvU"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso43537f8f.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 12:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785438963; x=1786043763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xgXPviuoYbN7EB9Py/8KZMntvbdaAe2VnJspeF2bwTo=;
        b=pWKLjyvUqApeKZOf+YV3YGlJ/HSoUaK8wo2zVPjscdGnrVJ1z5g7m5MWsWUYxXjb10
         axNFTrZXmV0o+RjwAJvO5hhNIMs7CyCLf5fs/8YkLbG0POg/PiOpMwXT7aAJTZvI1GQO
         qAvLmCFJVm1dIqs0B1Ep7VMxIEjM/0W7UEMVlWFp7OHMfpooqXToGOgfxMiP8fuPc9nd
         r5nZjG0niVDQ0K3trP4RkwWxOZjHmvHrg555PpGCMSGVtnj2+nTvezYC1bEybthBfyHc
         BWcqiJarzZPljPZ4d0/I91NdcWJtceK0hdycu7mvmFH8FlqXhiYkPKc4S3+XF+O4pD2F
         LJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785438963; x=1786043763;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xgXPviuoYbN7EB9Py/8KZMntvbdaAe2VnJspeF2bwTo=;
        b=YehfIGj3LMT3idavMGeYC+iuq3G7Mvjzqk+jKHSmjVix9nvReugKqAZiMX4gBOQBpm
         /pPFkTT7nA5O11qC+5lsRXy+Ld8v+EeC4xMQ4ETfsx2dKniCmUNJC8Us4O3+4KmKMSva
         UzxbDa6gnFHPiVHTvLV9Ug24l5jbdrO+3YaVycddhaHmYDOlwNAdUAJcn1UzDqktjyRc
         JSWQ5zKGb5IJvfCBJrmDgp7jJeaVo+BfYI1HEv9OWUJgX76VfQV1uZlByBre56LR3zBE
         CLm1J04Fo5Xc9qj3HnESgvF+NbT3ZNz0f2MnGfNCb/RtqzNGA3ogfTC59pMFQ9g7dQP/
         7ZZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4TK/omX8pUu5/LeERyqp0ol4434HC07xA/dXpRuLbrBvp822iAiTBrdH/a6JHrvWTWEZAW4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YySWarICnxSooslIGOEV9+0XlKxUBcUV2zgxNNWgOrHBODzzfAV
	A7LXM72lSAE4Wkm9Zo4lMzLDRRVBIUeUqGTmBorkaVPeHFaIcp4whY2c
X-Gm-Gg: AR+sD10tfbd+ZUtT8tMkYlKYrSekBDBihTPUI0iyaY4zY/MIzczv6GurCG0++Hlnm2U
	x3GMYnxiKFPsQS/kJjceJoUUvd7btOfC9RQBl9KhPeMgrjw72FrMz2vgJwq5vUN50H8CkXOQuWU
	hZfsl7YoSa8zZqySipxkf/dfAj5Ax+mxHRzw+Y6w2cSmCw5ohOznNJ8b7AyDGSz2lUXrN8p7voI
	sOxc4cBrdw8wp6igaMV3BFAtgeNyDnFtkj5b0/oIluNQn5melh9O248RQunvFUCTx0G9DNFOQIo
	e4NxIlAjfmspMVHXD6uB1H4dBrj61TvFQ3nBeGB2T6eq69x4RAZaa+Stp9QtmKdicEZOHYzYZ49
	AFbYQosglaiq3TYX6wUBfsRIf/xjqtBSFeKHGNDHZwru8/buWpZqd2FeBQAozySWvLNnL8VVh3y
	aLBkaZmV71a9g1ur/gjXFsuVd+Z9T34w5/ORJmBv0JOVMutm87mar42/JGfgkCptHTOcIA+KvhK
	5W8J2Twly0F4Zof+AAvAtZdbzgHiUWHzwffj5z65ZRbJjYhbuBDYs1QXRG3SHbBdalMHTTrMoch
	qL+fpKfQzsujt8oN0Y7SxeWF0UU4WdgsEB06OeE=
X-Received: by 2002:adf:e18c:0:b0:47f:921f:3a35 with SMTP id ffacd0b85a97d-47fcbb4c6dcmr2947822f8f.37.1785438963078;
        Thu, 30 Jul 2026 12:16:03 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d6e68sm8231813f8f.7.2026.07.30.12.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 12:16:02 -0700 (PDT)
Message-ID: <7cdc0130-6dca-4e18-8f0e-1e7221fb9853@gmail.com>
Date: Thu, 30 Jul 2026 20:16:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/zcrx: don't clear master_ctx from the import
 path
To: Woraphat Khiaodaeng <worapat.kd2@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260730162741.1125-1-worapat.kd2@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260730162741.1125-1-worapat.kd2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/26 17:27, Woraphat Khiaodaeng wrote:
> import_zcrx() attaches an existing ifq to another ring.  It never calls
> zcrx_set_ring_ctx() and so never takes the ->master_ctx reference, but
> its error path still passes @ctx to zcrx_unregister(), which clears
> ->master_ctx and drops its percpu_ref whenever ifq->master_ctx == ctx.
> 
> That condition is reachable.  A ring that registers an ifq with a
> non-zero event type_mask gets ->master_ctx pointed at itself, and
> nothing stops it from exporting that ifq with ZCRX_CTRL_EXPORT and
> importing the resulting fd back into the same ring.  Failing the import
> after the refcount bumps -- an argument page mapped PROT_READ makes the
> copy_to_user() in import_zcrx() return -EFAULT -- then clears the
> ->master_ctx owned by the original registration, which is still live.
> 
> Refcounts stay balanced and nothing is freed early, so there is no
> splat.  The ring silently stops receiving ZCRX_EVENT_ALLOC_FAIL and
> ZCRX_EVENT_COPY: zcrx_send_notif() returns early on a NULL
> ->master_ctx, and ->master_ctx is only ever set on a freshly allocated
> ifq, so it cannot be restored without tearing the ring down.

Yep, it effectively disables event CQEs.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

...> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> index 76b9b0d54af9e..fea2b27272ec2 100644
> --- a/io_uring/zcrx.c
> +++ b/io_uring/zcrx.c
> @@ -808,7 +808,8 @@ static int import_zcrx(struct io_ring_ctx *ctx,
>   	scoped_guard(mutex, &ctx->mmap_lock)
>   		xa_erase(&ctx->zcrx_ctxs, id);
>   err:
> -	zcrx_unregister(ifq, ctx);
> +	/* the import path never took the ->master_ctx ref, don't drop it */

nit: I'd say "... it never set ->master_ctx ..." as it's about having
a ctx and not references, but it's not worth of respinning.

> +	zcrx_unregister(ifq, NULL);
>   	return ret;
>   }
-- 
Pavel Begunkov

