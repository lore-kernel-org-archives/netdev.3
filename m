Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042B639B488
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806997; cv=none; b=MIjFsJ971e7mgRxmSZ5Hm7zjyMEUCKRmHJk9URP7MQ+6TaQ86rGvt09c/MBee3uMRbFh1F8Xbb45ijgFr9UbwGoAUy3WZG9vzqMLOddpYpS9SsBcuVG2LWrsYrnWZiBJFTdUVnLGdngoUtvgjhgowA8EvpnMMG9i2Zx8BjxhTRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806997; c=relaxed/simple;
	bh=yC08SBMmv1GBfoPepoWD7l1EzWAvJFNrcYCSx/kIrew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iph1yIU7TTM8tDJgkEbBrnzLrvVcroY9M8pchLWSOIrb/DA/QY4HIKx5tek3LgMqCg+UTWbO87DwF8nV2tGrGKmFZqyn2Kj2KueuD6Hw9k+FGtgI8ZhYlZM7+4/88uid8H6VXaTxcmRpM92SkEDdjDFrAtTczR9gd7kdiXaPQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HqTfMdby; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="HqTfMdby"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso21107855e9.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 00:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1775806994; x=1776411794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9BHd5rH9baSCcHucQaINuf+AYXdmrmHiREhfjm+We78=;
        b=HqTfMdbyxpmNdYUDBUkjMlvi3Gq0Vng1yxiLWw5oeMhoNi4kUW3h4H6sP2y8Y5pa6B
         OBU7lEAVYJgW1BeaPDKpm0ZBH69GE74BOc4IB7AXhMotjPQWQ1U/ngduUzRLiyZN3a+M
         vJyRdP4zGnUWupmWgaM9LbS6/NBiPZwFTyRZPLjG+VjfkXUHABu2s/cE8abiIybskoPp
         8euv6CWSgA18QOKkodGHCU0j2wzuMfNXTSN+qQSPOxg4GiYG1NWtdFDtQ8/iM2VYZyhF
         /BeneAOLSVLcEA+KWwuZl5ZiCwWNpMrBBi07P5CoZ++FeArThDEOm3Oj5gSOT231DRp9
         KfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775806994; x=1776411794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BHd5rH9baSCcHucQaINuf+AYXdmrmHiREhfjm+We78=;
        b=PvKPtL23F5uAkhRZ3X5WAzxWqjtbRaJEMn59Fr61DGqEFbJN4ptIIeTuZB/AJlEXWG
         sk9hNx4vKq9YNJ+aNCdcO9/hb7c5DVBPHLXxPwMnIRyqWcgoKyk34vHcJECNLWV2oidk
         IwZq0jxBwj0kg6ArxYfOo/8PZGW+OBp8/RDvl13StJPLtZyPsvmq5ijDbqb40YFWEcYv
         l6XLxbIkQVeyVYNhQGFybRVVwitbATut5j83QMhx8XIB/EsX0YNObtx9dq7a9TdIeLvS
         av848Wpzxb9uwo40IhxuJ1CsWZKa4+92nQmBo0fjoRt0GmFId7wEj8CMDZgrGH4eI+JF
         yKHw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3gPFIWN0a+Ai5C3lzQUKFhBbyk5CoQylD+ifUX5T1Su2uOmJqnVffYPsyJN1gWX5KZAtb90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiOL9LqFnMZAA5i78AlBaoBliSVxwGICA1JYSyosMjMDWDx6i7
	H3fXUVHD6rXg2QDallOeZUrQTHMzq9T5IfRL04llAPT5iU2Q/X+v5E9E71KkPVTALLM=
X-Gm-Gg: AeBDiev7B0EYiZnXGwlv00iDlFH3UueyYHYl4sEr1d4OglhIhsnbOz7/OewZVdtPt4c
	zMDfh8XIV767orqWHkTEEVtLtwtFfn7fZU1d3MUAVrkdCt8Q9X+Gu0AdvLlEC4vfe3XZ5bAv97X
	hPhgrM3stWGHjoiLaqsKFBHNKexvZzyN6lk0UvUjj4txLcjH+9cCypl9qeRwVXOWLSOEQfnWiUi
	Vxje1WjJ2jyozcY5ZH6ORW/i0iGY/uhhiUySEm1gN2VV1LaH4FFZGG0wJTYHApnvas/f7tyjFQi
	Gvn08iDxVcZLIwineA80fkLVeL9P/MW1++bzyI5AGws9S0jYOi3eUg9w3AHe2TepEUL80itznSH
	muwxzlw7PmWwxoBTbu8QQdB6FRaliQGbt0KvjGZPfZlK2tuj0LOYTg7NW7ca2lcouLa1wm1GEA+
	tsvvf1vWvomxPxspAbW0kr9CePleP6bY7mWoN1yUkJcVqQtJ3DACZ6Ia0=
X-Received: by 2002:a05:600c:a11b:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-488d687c06bmr18264485e9.25.1775806994113;
        Fri, 10 Apr 2026 00:43:14 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b46ffsm17630445e9.6.2026.04.10.00.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 00:43:13 -0700 (PDT)
Message-ID: <a3dac5ce-250b-4d13-ade1-8036b454e21f@blackwall.org>
Date: Fri, 10 Apr 2026 10:43:12 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] netkit: Don't emit scrub attribute for single
 device mode
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, dw@davidwei.uk, pabeni@redhat.com
References: <20260410072334.548232-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260410072334.548232-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/26 10:23, Daniel Borkmann wrote:
> When userspace reads a single mode netkit device via RTM_GETLINK,
> it receives IFLA_NETKIT_SCRUB=NETKIT_SCRUB_DEFAULT attribute from
> netkit_fill_info(). If that attribute is echoed back to recreate
> the device, the seen_scrub presence check in netkit_new_link()
> causes creation to fail with -EOPNOTSUPP. Since it has no meaning
> for single devices at this point, just don't dump it.
> 
> Fixes: 481038960538 ("netkit: Add single device mode for netkit")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  drivers/net/netkit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 5619209329d5..7b56a7ad7a49 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -1214,7 +1214,8 @@ static int netkit_fill_info(struct sk_buff *skb, const struct net_device *dev)
>  		return -EMSGSIZE;
>  	if (nla_put_u32(skb, IFLA_NETKIT_MODE, nk->mode))
>  		return -EMSGSIZE;
> -	if (nla_put_u32(skb, IFLA_NETKIT_SCRUB, nk->scrub))
> +	if (nk->pair == NETKIT_DEVICE_PAIR &&
> +	    nla_put_u32(skb, IFLA_NETKIT_SCRUB, nk->scrub))
>  		return -EMSGSIZE;
>  	if (nla_put_u16(skb, IFLA_NETKIT_HEADROOM, dev->needed_headroom))
>  		return -EMSGSIZE;

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

