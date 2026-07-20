Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAB13D0938
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537903; cv=none; b=s06XM+daHEGeA7xuAtALU1qOERlJE8Q1KCqpIew97lRnaSLUlJ89QDf3nXmfB4t/l4ey+lUELrcrYCGlyjBs85hUt6V92ShNZUakuouaio1mOwqRZj0cEetwvlJyIiUxYQLbvDt4XSPmVbNZCvnKI0QTZ+JE+uiYSL2O03SDl0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537903; c=relaxed/simple;
	bh=M/FeSkUlN2iqLgZl/QwQ1vDPTww3FqT+IV1psC7BNho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0yZtYhr2/hWnWVRnjpO9+ZKjBg9xJ+7QpB0Zw+3CFWlqrFeALInvCc4ft60Wqyu46c9BGOWQwftfhu99wqNmakVxzmAw6arHayI1yofDbd3xKYhSoi0bMbh+t5QGiTOGbZ0QqDEa4GM+w/KRAIQ+uL23TXsg+2f47+m6v63EAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=OmEOHsHV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="OmEOHsHV"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so40545935e9.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 01:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784537900; x=1785142700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=THIFmBumm1t3Qj7dX1twvX3kH9ShW1vcRhMAUJ6LjVo=;
        b=OmEOHsHV1yx0RqQiAPzeLw2sgL+NqlWk1UPFafaoN/Zl+qaYW621crfEk5i0WuaD4b
         NYW0V2qscSsfyCJFqfGGdE4LcurbM0g7i6+2z5zHS3lISYl01ay6vXx0YYFbc+Cs6Ivk
         DVn5HnKlFydPO6NvwP8MIbIJPHx1GLyhJ7//qbVuH0zMbKralYP8O3RInrV0InP/hCE9
         WoQNtJhPhgfSkMXxhK+cGoHK0h0UXqli2m0QwdX3a+YxTKjiOzNi9VNrL+bSvNPAj+Li
         J4dw67cw7chtFrWCC2dIzliECo9kCvcskIpKZj4em5QbYqop8TIqyLmzNDfKshPbxCTa
         hOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784537900; x=1785142700;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THIFmBumm1t3Qj7dX1twvX3kH9ShW1vcRhMAUJ6LjVo=;
        b=ga/xSl4YVLS2qvPWon8JK79GZKSGeDTdLM6FiElTOEzlCzGV9dk0bKvucGlukU573p
         bPy8roXWuJz7WW1k5945cnxwVxfUvKCO+LRrmRWPGIWi+fohd0h4OZrOx3NlXQd+Pf+G
         Mvo6HRRZ09V2slxIBBeXCu0LIlDfcuZlfs20AK/Q1sqJfl2vTRHkfpYwGB3UYpuxtXS8
         Tyb7cmIvfWu1GRlxtSqmtdCUygMCuVDZIgZ2EuSC0QM6Fx2jxKc3E5IcpSz77vGXDRmH
         qiqy/0l9Z3HqxW2KmwfIuwVjFaMpWoYroDZxEQEIHiYPbWx2RrGVSgzwSJUN1nEjPN1A
         AvZA==
X-Forwarded-Encrypted: i=1; AHgh+Rpq/OFgDnWHZM+AmWWsCG11nBOnmpzi+tWW7F2BP6x2FCkvfxA8NTBXK+r/kyR5VjCNwJuOekk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnrPnFLwj2AbnL7oLUvJ1cmTrQexgu5DWuS/Xagr69phSOTszz
	3tg353zdli7/1p8d4JbPVVv9UvEkWde645FIO8OLH6VYgwkcU4gRYnY0/TxeqfBEISM=
X-Gm-Gg: AfdE7cnbJIAfqr/QaVLQjZ6vseoDfYcIGm1d3wOPA2nAxO15bs/htuVnAo0XYmobVLr
	k8ecEnjqFkNDa5K2KRrQdRa1g6Cja+bZcI4A9QT9tD/0kg55nnl78ZpDDTd01e4PBzECBL9Umyq
	929v5Sqc1xzSAjw/ebtqns7sjXHfK2vkW3vEDePwxdRb/ceLHKWWojW7WNaeAoTNuQ1xuOwqGe4
	nin1LkCaZXJ5oz6aEmRZA47xVoRf4tEh0wtoWGhhr2p3FL0Iv5mXP6GRz5pXWl9NrDIL9OttI/T
	r39n14b3JlUs3t+DWwouW6mjux+mvjZgMi3gOU458THF+8If8tyoy6i2inGlG6t3p89zNCI6ZQI
	NWv3aZSp8qf5u0vywIgJkUBR00HuIeRVGIt7XzTZ0qw8VkXLrkZe/ZD0ZQcb2u7VPWRQ9629foI
	e6FDhNqXYQoqywcb/Q/9hEjAM8znrYMTiL
X-Received: by 2002:a05:600c:4f44:b0:495:5b02:23a5 with SMTP id 5b1f17b1804b1-4955b02253amr51695905e9.30.1784537899449;
        Mon, 20 Jul 2026 01:58:19 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49563eee22esm1870305e9.1.2026.07.20.01.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 01:58:18 -0700 (PDT)
Message-ID: <2797c0ca-07f3-4815-9233-f0f27375162f@blackwall.org>
Date: Mon, 20 Jul 2026 11:58:17 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] bridge: Use direct pointer in
 br_is_nd_neigh_msg()
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ja@ssi.bg, petrm@nvidia.com, fw@strlen.de, kuniyu@google.com,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1784463131.git.danieller@nvidia.com>
 <c710e4a236e69868a59c969bab31e5f29cfc0e86.1784463131.git.danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <c710e4a236e69868a59c969bab31e5f29cfc0e86.1784463131.git.danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2026 16:34, Danielle Ratson wrote:
> Both callers of br_is_nd_neigh_msg() already call pskb_may_pull() to
> ensure sizeof(struct ipv6hdr) + sizeof(struct nd_msg) bytes are in the
> linear area before invoking this function. The skb_header_pointer()
> call and its fallback buffer are therefore unnecessary.
> 
> Replace skb_header_pointer() with a direct cast to ipv6_hdr(skb) + 1
> and drop the now-unused 'msg' parameter and its corresponding stack
> buffer from all callers.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>   net/bridge/br_arp_nd_proxy.c | 9 ++-------
>   net/bridge/br_device.c       | 4 ++--
>   net/bridge/br_input.c        | 4 ++--
>   net/bridge/br_private.h      | 2 +-
>   4 files changed, 7 insertions(+), 12 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


