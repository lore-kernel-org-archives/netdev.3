Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FD3B83F9
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536583; cv=none; b=et+1kS/6y4Acwn3KT3yd3cNtVwmXyAJz4fyrq9aNEzEBO/zZb9hX3HTyC5PS88tB0zTo4BdJHfFWXrbkOf3/dC/1i5Hrf65H9I84+tWlzBsBo+Yw5NmiWbG/SreUWOrTVxkIwJhKzHh90pq1dP8q7u2hr8B7weVFSF3pTThYDB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536583; c=relaxed/simple;
	bh=T0JUWRzx57iOTA1KZI2poUKNYg5hQ2DvWkFi/iwU020=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WER0TISgLm2tpd457K8CzxrokZtDszsqeErevGSf5pU2UfuPwzDNX//7Kgq2BZoBgYVo2kUZbe2IpDgSYNVbMG6RyrNKjUobx6I+y7rNw7Lko+e5sfCPEeDpJqHoXo5pIuSHhZIwYLWuNH3itxApjwAGvkj7DhhxF1MrQAvLVAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgFPX2Sh; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgFPX2Sh"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffe817151so4999675e9.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 12:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790536579; x=1791141379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LP3SPyinwD8fn1a8RK+gsX1s+9bGZ+MpdPQLG7wq3ns=;
        b=PgFPX2Shy2UiLP3eP0qxk5y+ogjxxsN45w/3pj7qsPUMaAepJftHkpsF/A5scnCqo6
         baf+x7GXYXBP/jC10fV9HhDhK09eM8eIhCsihJeGu3qKWHSiCdBADEtMpEikX766TFX3
         8EPGOkQ7TUoWmv3APZpnNVmB8ObG9UwhAGc18iG1ngdOktZaeXug8b0pjns1JrGX4V0R
         FkzfnmizYZCPjLajLYfc8GtngirIrZF05Q7L7gQkHl/QXld/SjK1vr/eMhSY58t4aF2t
         zv4IplIyXiOXXi9/2ptTlYDCCaVEXGonuTFN7IMIuNwBpyX20OnugSwGzS9sbqm2Gr7S
         28YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790536579; x=1791141379;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LP3SPyinwD8fn1a8RK+gsX1s+9bGZ+MpdPQLG7wq3ns=;
        b=fxsiPB9yFpuYvFqnXuryNroT25ewNmLrnDgkpmV5wtl0krDs2yzaFjI/g7S5qUAPeT
         DiidzL4s/GU9aZSsdPLr4EIa9iSihpYqZ1rxzoN61fpwF5LeSwFLjCceqs1xgXwQGSc0
         m7EjEZoZCUTzZMz+RiHalkh5if5vMdWSrbrn/JYEqDRwlATz7ADy0cEq6DbMtb+8Y5HO
         42RqlWbK/1hAbAhLheN2Z1lm+NfHhKm6bltMyOJ/n7iu8wxDxDrwb5Iyr0+oCvPj+cyn
         Phf/TgnJL/k/54QbJIdXDbooZZjjGq82HRtKFGRxX4HefxM+KWCEvGAPIQNSAWAICCRt
         NL8w==
X-Forwarded-Encrypted: i=1; AKwUvByszTsh0xUazvF3l3pMPoVjZCEvGNTCvSY4pLfXB9he3MDXANl9Fm+6HgUQB0oW3Z9q4Jpswz4=@vger.kernel.org
X-Gm-Message-State: AFuF++mYdJEGZcLrMk6d7pNuXHIYn6e022MJ81YAiLI93RbEk3vPvKd9
	sZvb5/3OAMR2GU0YC/vVrq2Hng+ysa19FubHCP9I9trrBARFw4bHrMCv
X-Gm-Gg: AYBFou1N4jz+oqQwQ7y6QDo5RWFnTyABQr5nQzV6KE8S1uUok+IjEofQ4hKhNFBrcj2
	nsVAXxVf4yPudaXhj67Pt65rE7e0Br0m6WudaJeM9OGNbjPZoOFGsMHZP7YmgdnI0OrsEVBrLAX
	mO2i5VIRZfhiOxBWJxTjCUUdFZzgTINnqA8m+ys8TRRQB1UYAlwqn3dc5Eu8lPvr7NKTWDpjXmb
	U/NF7BElmgAaOsQKjuynoNED2frOXysWgbSlWHBvzbe/6DFy54QL0dbRABGFCX8tivPq/cqnmFj
	O5uY1MAr4xATQvD+VDaSFsTr7dlV+3K7+X5lZc6hgFlTlIAnlkQmvMfNi+03UjoC5/NBnauH+OL
	ZUcEsjuVBwAO9KYWcypubzpbG5owNyKCGPJ+xIQLzrluQdeI2INSOYWC5/P+8MsFII5kieUCmsW
	Icy3yy8QEvnRBhHVLroCXKpXGQWNY97UCveRu99ewvrMNGz4HRmrahVW5BN0YgX7n0SkWUkSgyO
	ScwjFBopvcjKNgtYS/g9qkn15w46OQ5mTKvj8ZhreM7KSvgXlz5zRnPbTuNtQp6bROCJWBUv0qr
	tpwr3GzPq5hALg26aiuGAYEvO7AOzCMgnIzjNIsD/7vDH02Y
X-Received: by 2002:a05:600c:468d:b0:49f:f9d1:e618 with SMTP id 5b1f17b1804b1-49ff9d1e6b1mr76692205e9.17.1790536579591;
        Sun, 27 Sep 2026 12:16:19 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0018e6dcbsm75325005e9.6.2026.09.27.12.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 12:16:18 -0700 (PDT)
Message-ID: <e2e61157-896f-46a2-8c85-8e64b4cdb004@gmail.com>
Date: Sun, 27 Sep 2026 20:16:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/cmd_net: end TX_TIMESTAMP multishot when the CQ
 is full
To: lollipopkit <a@lolli.tech>, Jens Axboe <axboe@kernel.dk>
Cc: Willem de Bruijn <willemb@google.com>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260927074206.65427-1-a@lolli.tech>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260927074206.65427-1-a@lolli.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/26 08:42, lollipopkit wrote:
> SOCKET_URING_OP_TX_TIMESTAMP arms an EPOLLERR apoll multishot and, on
> each error queue edge, posts one 32 byte aux CQE per timestamp skb. Aux
> CQEs have no overflow backing, so io_uring_cmd_post_mshot_cqe32() fails
> once the CQ ring is full. The loop then stops, splices the unprocessed
> skbs back onto sk_error_queue and returns -EAGAIN.
...>   static int io_uring_cmd_timestamp(struct socket *sock,
> @@ -135,7 +137,8 @@ static int io_uring_cmd_timestamp(struct socket *sock,
>   		skb = skb_peek(&list);
>   		if (!skb)
>   			break;
> -		if (!io_process_timestamp_skb(cmd, sk, skb, issue_flags))
> +		ret = io_process_timestamp_skb(cmd, sk, skb, issue_flags);
> +		if (ret)
>   			break;
>   		__skb_dequeue(&list);
>   		consume_skb(skb);
> @@ -145,6 +148,12 @@ static int io_uring_cmd_timestamp(struct socket *sock,
>   		scoped_guard(spinlock_irqsave, &q->lock)
>   			skb_queue_splice(&list, q);
>   	}
> +	/*
> +	 * Aux CQEs cannot overflow and the poll is edge triggered, so nothing
> +	 * re-runs the command once the CQ drains. End the multishot instead.
> +	 */
> +	if (ret == -ENOBUFS)
> +		return -ENOBUFS;

I'd make it a 3-state return instead of relying on
skb_get_tx_timestamp() not returning specific error codes, but it
should be fine for now.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

>   	return -EAGAIN;
>   }
>   
> 
> base-commit: a3bdf68feecc57af5c11fb599f860ac9790ffad9

-- 
Pavel Begunkov

