Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42FE361970;
	Mon,  3 Aug 2026 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776392; cv=none; b=Kzk7OuCumfcpHT9ywYRpsgYUkiY7fjjka+gonsBp+48OwyfoGFe1J4wOU2bvgPz8BM+OvTRwt+w6VODS77LOhIrRfaAFd8IGkhwy1tBTZY/GsZpVoqlhKJYc6+hTr+1QoH0GTcJC8hD7KmP7DhELUu76ustdAjbgBbk3/41ZEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776392; c=relaxed/simple;
	bh=ZoKlSJH6S7XBbYQb0kQUCraM0nXQODQxEAIZvHSVxgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Npc+UvvOWNkIU99L2XtWLt34ndKsaORy/CQpYjl+CI9IjhXn44Q6T8G34TbFQ6yPISybk55LjzEFgkpwmiB8mJTBgKU3V5xUtTzfkd/9lQHDpGprUrhb6tI8KEHkJx1Ilm3ZxqcVFu7ZktaJuug7ttaeHq7NWs9v4tFvyex62I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuHNsOpz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuHNsOpz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B651F000E9;
	Mon,  3 Aug 2026 16:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785776388;
	bh=VhcZS4LOVYUDfBnOFtJnArjltuTfU6OeXPNNYfWYeSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZuHNsOpz/sN9mejIOT3kXYKdhTLieoNBvifjNzvhrCYY1tGh95q/EQY0Wzs7s6xMi
	 1nCo4caDkr2ABsI2lXaCrGHfjsW/bcPK9L8cUfJIpYU791n2ILa2PRhfzi+eemotDJ
	 4iX1fhbpHlsmii/fw04B7jzGygqCskwijq9v2zfZQrdLdrkuQ/3v8rf/c+REfyoAK4
	 ST4Ouhg8KfGONmbnv4kKM7oDIapeYeBNeoGaI+hh+JcOjq+/23a00sxI/uNSRwRwkM
	 hII2Klt1LQLPz0Kve3I9+gwQop0uWJtuyfQtrQyFtC1n6VUaE9SR5S2PWE7Ppifm2j
	 T7F1y0vPdppGg==
Message-ID: <f8b967f3-238e-4402-89a3-95d8ac0bbe3f@kernel.org>
Date: Mon, 3 Aug 2026 10:59:47 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: vrf: check register_netdevice_notifier() error
 in vrf_init_module()
Content-Language: en-US
To: Minhong He <heminhong@kylinos.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260803090002.142453-1-heminhong@kylinos.cn>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260803090002.142453-1-heminhong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/26 3:00 AM, Minhong He wrote:
> vrf_init_module() ignores register_netdevice_notifier() errors and
> continues module initialization, which can leave VRF loaded without its
> netdev notifier registered.
> 
> Check the error and fail module initialization early.
> 

Fixes: 193125dbd8eb ("net: Introduce VRF device driver")

> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
>  drivers/net/vrf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> index 46209917ae4d..a0557a3a7026 100644
> --- a/drivers/net/vrf.c
> +++ b/drivers/net/vrf.c
> @@ -1932,7 +1932,9 @@ static int __init vrf_init_module(void)
>  {
>  	int rc;
>  
> -	register_netdevice_notifier(&vrf_notifier_block);
> +	rc = register_netdevice_notifier(&vrf_notifier_block);
> +	if (rc < 0)
> +		return rc;
>  
>  	rc = register_pernet_subsys(&vrf_net_ops);
>  	if (rc < 0)

Reviewed-by: David Ahern <dsahern@kernel.org>

