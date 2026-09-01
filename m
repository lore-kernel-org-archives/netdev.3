Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD1C38A72B
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245905; cv=none; b=P7TdTXNsyOc+bI9vs38cSQfr9AqB9BCUNXglQefHv3Vxv6uWaiOsBu56kTx0BxsI8TiY1+Yv556/PJqLw+A5BGe3Am/rS43m8/LlMkKa3SJqEUgcF4FKDKOgveY+OP5ojr5DESe/DRKVmC5eNGxt/8MkGPyEKw8U4tserf5rw6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245905; c=relaxed/simple;
	bh=yfaR0A/+gSGtM9k54V0oJDhwxPBwxLScBGZZgZ0p00k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTumFNHoTNuMDdaHqHP8PL+2yRV3DGgcJDvKHtlgWQ64OIDsSSuqRcJTld5M2QAFa6XO/lW2qX5xNPn/JH1yRRW+1ioqM6iXIdYpyY5gSRhRcqiOuhmNk0ZZWyr8eob6A1gQLfzkheq94GwbHujfetkIlrKGEj/KNWqo8AlRNOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=NQXzxQkj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="NQXzxQkj"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b8687630fso31665585e9.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 23:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788245899; x=1788850699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2AqnrywdkgyiuCUc7C7pp08uWzz2A6+vu89yOmEHuQk=;
        b=NQXzxQkj0hHIElysyAl3oDwPEqp0gUD8MVxaj2sjES1UUAko9xAhUw2RaLzrGTBmQU
         8KbFngk+tV/Z8ZayKoh3ZlaMYcrfia9KdoeumL0yZFBxS8jngkTKI546wQFBRrrRkfQ0
         7tqEZZTg/2OIeQQMKzS8vSxQh2Z/xa0JDM12UkSJa4rWHrQfr24IHTEPFttycuVwZwR1
         i9u8292mV9kIEK3qnmezuMZ7Gkgmlp8mEsJpcC10TreUzVVX4kS6Fs1dE/49OiU/58Q1
         yHM3zqT4JCxfAtrUyOUeSpzjKxEkPt610fYNmB6/s5zKC1oiPKJkLhw+3YS2sS77B723
         8XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788245899; x=1788850699;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2AqnrywdkgyiuCUc7C7pp08uWzz2A6+vu89yOmEHuQk=;
        b=bcVmn/WUvmAVd++ACj4O+6mN/+0ewHkY3/dV/PF+ek1MLprBgvJBRAGqz63YmwgHk8
         vDUHgvI8po+YxPVZ19VARjkXNrFqHgsxMrZPAdMlalOXBZFZYzje8Y7fITn6jMfT5L4e
         hXaGwJ4OuLxfN0voqeIOrpnJF397ZDxD8y459RbH6kLnRz37NqTxGQMT9wZlcskOQM3a
         BoYNl/DiTrMDj24nrSM26lydIjVGAJvDSe3FZPrVHMCcpy+h2uHi+DRd6rziSNQvELgE
         k3+zIbqvdmAMaoOkKb/ZpPj7YyT9XURs4gMqjeoloXDpvO8yK7pZHQlJVOG+JhAXcoEt
         vtug==
X-Gm-Message-State: AFuF++mBML03HD4bYCV8rURLlBM7bueTzebWDmckZFcr0ZeiSVPYsysv
	P6XYdsH5aIkVdr2waVe4UoEYlgdNCf9W0r/naYtjJBMAyZHd8sAK+kUHd5KjsUET9ZY=
X-Gm-Gg: AR+sD13Gurs0XGvf0W+uYa5eYwHwaY8yrL+OImSi+VAXBaRPYccRcXLmn/azSgPVtbU
	k+uue80HwQ81xPlko2AKyFacXMCsP9T25wdGEyZJLL9fKoJfgtEH4Iuw+Xkk18oeGaJRymJNLiO
	B0sAdtGlDYvEyfCKIQfErbmau7wJxSa7M+8lycV0x1tuZ9Gmowpt2jZrNbp/ru4Y5Qfjjdm7gXa
	CNlKOPQK/Duza/CbQx+VYv3GnR0HV8eHNJ0+fqJLyZmzUoepizqmcSaLzCFo87bzWTRrm8Avcsi
	XLKzXBWJwZCMZjcw7am5SirGYCF07kb5nWG6mbXmMIkiv/FpPeD6iRgyhjbSXraxMwTQpvzJ1j6
	wn9XmnJ55f/kRj9meAUZFw261+ssZ2P9TV9p2VHsrhFvIy46N+XiwgiwrhSPrnIhfy4cUSEA1HI
	671OVjtNAN2okFlgDylk7mk7aEDWnlsDciIk43GWHcbR01GZBNvcG4KZzrxDf4WNLE2PJx0fyFX
	Nuj/jAXXUOITqFKsKQ=
X-Received: by 2002:a05:600c:4f0e:b0:49b:9433:ea44 with SMTP id 5b1f17b1804b1-49cdc40ff56mr120580185e9.4.1788245898951;
        Mon, 31 Aug 2026 23:58:18 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce0b425sm44270625e9.1.2026.08.31.23.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 23:58:18 -0700 (PDT)
Message-ID: <d0efe7c7-efaf-4e2a-917a-98f99dc66b3a@blackwall.org>
Date: Tue, 1 Sep 2026 09:58:17 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] netdev: correct error code in
 netdev_nl_queue_fill_lease()
Content-Language: en-US, bg
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, daniel@iogearbox.net,
 bobbyeshleman@meta.com, sdf@fomichev.me, Joe Damato <joe@dama.to>
References: <20260831164159.1124679-1-kuba@kernel.org>
 <20260831164159.1124679-2-kuba@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260831164159.1124679-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 19:41, Jakub Kicinski wrote:
> netdev_nl_queue_fill_lease() returns ENOMEM on nla_put failures.
> This is wrong, the error code should be EMSGSIZE. But it doesn't
> matter, caller of netdev_nl_queue_fill_lease() just checks if
> the retcode is zero or not, and uses EMSGSIZE.
> 
> Reviewed-by: Joe Damato <joe@dama.to>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   net/core/netdev-genl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index cb18db681640..04dcd7fc614e 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -434,7 +434,7 @@ netdev_nl_queue_fill_lease(struct sk_buff *rsp, struct net_device *netdev,
>   nla_put_failure_unlock:
>   	rcu_read_unlock();
>   nla_put_failure:
> -	return -ENOMEM;
> +	return -EMSGSIZE;
>   }
>   
>   static int

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

