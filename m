Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D33A9DA5
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565588; cv=none; b=gZHtdHZTHA8YhFDJUTTCQis0Gaz9C+TpImWfWLlJG1P9KVK97eLH+u7CMzqlYgE2vM/DWFvqNz8EidSxuLjpl3ppE0CxG4Lbgm6Z27Qg4aMylYl0BkOp/oYkqoq9lKz0EautMstZQ6qhrJ3yzrDxTyBdjtpRXzYe+ZQFGclVcCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565588; c=relaxed/simple;
	bh=cGO5c8B1MJXYxwPeALet7pgGgNZtouUdtp8hNJIfcZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqrGnffS0buPB/YYa3T2AxN03hY5QCg9dwZcm+TjJWKGC2uQTtC2xyPZ8b2pE7hvDV8byKpD4vSdVeUkaa9+5i/+1lxbCJ6fpMCssHCeBdhyq7XipvyiWrtVoo8Omxj/a1bJ2pl7Q/vgBFYWQ3+JrWEYUP2otUKDFSIV+5vRsUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=KfZcXOlu; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="KfZcXOlu"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so7283485e9.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789565582; x=1790170382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cZS6D0+Yu1bgbatKiSZWO7Ns/TkgRcscfowWn2/b34o=;
        b=KfZcXOluvt8IP9JyO87eTn8j9KH+aTt061UzSyjWRzuu5nUuezK4NhP2hP90xOJFdA
         CG/8odT8bPlzPeol69tjPT8vhEawe0CVJ6kMmXYL6OnQKXHslfkc/zmjensj2QcQiFAn
         UhHJn85GAQRe1tbzMAvdEsFv8ZtvcuXj7/6Gnt0JGl+weC27NXnrScHZ+pwf62+6tKfl
         LbRDIwR0mIrSw4E4zFmvFh4Y48GK9x5eHzGhDMESz0isyV9KFmp3frskpZEqKCYEAgGV
         d66AItPGe8xW6DxsaeQlbr0JWM7Uito9HUHNTrxp8o4CwS53GwDdBJJFAmsOzKkOEeXI
         ud1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565582; x=1790170382;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cZS6D0+Yu1bgbatKiSZWO7Ns/TkgRcscfowWn2/b34o=;
        b=TSZoupkznsWXPlzu1SeXPCinwUnqi5ijvtihl7tEb8NR2dHbaq6Zr/kVElzjomPpb7
         RWsXnidaZ+ucMiVzuFOflqnrOw79GcWCQojiOBHPwJ1P3auOmt/5A6NwFKNA9q7NkY0F
         Tt6p352Ell0vY4PoE+jnVwQPBbYf0MAPgD0bUz8BUcYmLiKd7edS3mP37RQEQgk0nU2t
         N3QqCjF9WxjOj/7RvBDDaw5Nt5wDCDjugb0o5RM+mQxmuOFlA4S04K5BGV53bQJc+0XG
         d48UEn1+1dQm9LaJd69zqLRg1ga6rak9IZshJywgsiR3CyfR5ZxVqf5LSnAiCtzZV1fV
         kArA==
X-Forwarded-Encrypted: i=1; AKwUvBxDsYa8XSgMQCYqa7pFzdZvrejtkiZMNJ1zHWzkS2zPnLLO1St4PhvdPGZJ4joRxEaegK7hmbk=@vger.kernel.org
X-Gm-Message-State: AFuF++lsJYvJ2PA8e84rm7+q7Tcofnn9VrN4R/rIAqzJj16R67OyOxue
	WZnOKYHbNHpTEqV9jlWqsvXTOJctEvW+DmjPx4THbCYV0926JYZHv5Y+hzhdJVPa8mc=
X-Gm-Gg: AYBFou0/SnGqfGIZGwa5/zAF8Jd8PHDHL8nYbqklVxZY2rxr31gjlRqZBqpomYxtu8T
	qibpwFYhK8GZ3t22Fj6jngNQETHwl5Yw6JYal5L464ZLHDVtEKtY6pyLeUW/kKeyrmPJHCfeGuK
	rMvBtZe0qWHuY8oVjnLU2SuLEqGFYFRZ2OFvtkUiAxiPbvgjueV6jX2yhXD8TvG+aX7wS7f/qzs
	zxUMGa7vivsjPU7XZhhMC0rIxJ4nGW+C09v3qYok4WhXzqbpNdy/w5DOBlFNufQjG83E8fdHv0F
	qvE5/WiSbh0nGn//gW5w9oFTfw7y4cZmaWVwBYxuMd7Wn4d6WK7s5lJKIK0oE6s89fFFUPNFek3
	p2w422a6QAfxIOcLxPF/WDoOdqPLlyViGJmZkIiGlZEZyVAi9vwMErPw7IZzqOw+s7WECU+LYjN
	/bRAHsl7qwdoJzT+KJCOtC9EPEZCqZSnDSgnhG7lXNncpxlMUIp8hPVnuqQg+dCP2Hb+Nn3rvpx
	fOHZ8dKt9/iAtEgNlsYCmQ3ifmSqQ==
X-Received: by 2002:a05:600c:468a:b0:49e:7cff:f8ca with SMTP id 5b1f17b1804b1-49ec053a73dmr30251325e9.29.1789565582076;
        Wed, 16 Sep 2026 06:33:02 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1fad3sm6543395f8f.12.2026.09.16.06.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 06:33:01 -0700 (PDT)
Message-ID: <5a8fdfa2-2ecb-453b-9df7-e52e4c381892@blackwall.org>
Date: Wed, 16 Sep 2026 16:33:00 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] netkit: no longer rely on RTNL in
 netkit_fill_info()
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Daniel Borkmann <daniel@iogearbox.net>
References: <20260916111953.1611574-1-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260916111953.1611574-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/09/2026 14:19, Eric Dumazet wrote:
> netkit_fill_info() used rtnl_dereference() to fetch nk->peer,
> and thus required RTNL.
> 
> nk->peer is already an RCU protected pointer, updated with
> rcu_assign_pointer() and read from the fast path with
> rcu_dereference(). Simply use rcu_dereference() under
> rcu_read_lock() instead.
> 
> While at it, use READ_ONCE() when reading nk->policy, because
> netkit_change_link() can change it at any time (it already uses
> WRITE_ONCE()).
> 
> Other fields (primary, mode, pair, scrub) are only set from
> netkit_new_link(), before the device is visible to dumps.
> 
> Also add missing const qualifiers.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>   drivers/net/netkit.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index a3931cd821321c3e4888edf86efc414199127bcf..82e608e733d9ee70f71c374570211c73da76ae2c 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -1209,12 +1209,12 @@ static size_t netkit_get_size(const struct net_device *dev)
>   
>   static int netkit_fill_info(struct sk_buff *skb, const struct net_device *dev)
>   {
> -	struct netkit *nk = netkit_priv(dev);
> -	struct net_device *peer = rtnl_dereference(nk->peer);
> +	const struct netkit *nk = netkit_priv(dev);
> +	const struct net_device *peer;
>   
>   	if (nla_put_u8(skb, IFLA_NETKIT_PRIMARY, nk->primary))
>   		return -EMSGSIZE;
> -	if (nla_put_u32(skb, IFLA_NETKIT_POLICY, nk->policy))
> +	if (nla_put_u32(skb, IFLA_NETKIT_POLICY, READ_ONCE(nk->policy)))
>   		return -EMSGSIZE;
>   	if (nla_put_u32(skb, IFLA_NETKIT_MODE, nk->mode))
>   		return -EMSGSIZE;
> @@ -1228,13 +1228,18 @@ static int netkit_fill_info(struct sk_buff *skb, const struct net_device *dev)
>   	if (nla_put_u32(skb, IFLA_NETKIT_PAIRING, nk->pair))
>   		return -EMSGSIZE;
>   
> +	rcu_read_lock();
> +	peer = rcu_dereference(nk->peer);
>   	if (peer) {
>   		nk = netkit_priv(peer);
> -		if (nla_put_u32(skb, IFLA_NETKIT_PEER_POLICY, nk->policy))
> -			return -EMSGSIZE;
> -		if (nla_put_u32(skb, IFLA_NETKIT_PEER_SCRUB, nk->scrub))
> +		if (nla_put_u32(skb, IFLA_NETKIT_PEER_POLICY,
> +				READ_ONCE(nk->policy)) ||
> +		    nla_put_u32(skb, IFLA_NETKIT_PEER_SCRUB, nk->scrub)) {
> +			rcu_read_unlock();
>   			return -EMSGSIZE;
> +		}
>   	}
> +	rcu_read_unlock();
>   
>   	return 0;
>   }

Thanks!
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

