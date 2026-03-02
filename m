Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9B013B58C
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772415534; cv=none; b=i2MsMPWuNmPypErhqmtos04of7NhDv7bG8OX309hCbpPNQdn7n65HBXVxJJF0uJWlEJ2IgLyFPFWgP1/OpS4OvwXNMJFng5wMxNj57vd6CK6SnrFfX7d/xpJtTy8MxwHxVdqFpiinpKiCcyAdMgKQ9Te3i9fDmHl35MtJHweOto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772415534; c=relaxed/simple;
	bh=gCR/VUAdErCYtTJeVNqXaOxY519eMv9wYj2Rl/+Pn+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uadk86hh5c2DsdLrMXpbEE4GjXL66IqnedDIp2+sTHk6oHM3CtWd4/fJ9KfeOwTsjjf/As2mYUNHdIl5hD016wB6C76JS3TRc8k/hLIBCxo66fqb7oFPLJyUqA90B+e0qM5Z06VbonxiejxI7bV+wD9ZueE3h6bi5Q7Op6q6mA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0EnvhAd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0EnvhAd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B046C116C6;
	Mon,  2 Mar 2026 01:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772415534;
	bh=gCR/VUAdErCYtTJeVNqXaOxY519eMv9wYj2Rl/+Pn+0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m0EnvhAd9gwism0gztuQKDUv6J64W3T6l70v/vXnre9+LWC0lEWo9px71AusljJ0t
	 xdWtl76w9feoDJq3LVIXfNHYLeNjoRu1JYmfyzes5LjlJwM6QLGTYbSsWFudNYFzBX
	 HjhrLJBUAp/eUWYkfa1FqkHtA34Wg3VUcIn81anpwjgdeHjpnPyfslWdKA05kOMppe
	 B1SzaesFncIoTkFEscerRpgz6YnzhRiNgYHeoNRJgC+W2/WgSBYa2yf3XY/t2hAy47
	 qWC6o6I0YdwGamJ9vCzUrqNTNafdUH/wMda+8UM5QZPewtDTLR2JKSIKV1B3XEin9d
	 Af91ThuTtACcA==
Message-ID: <859d39ff-cb1e-4f3f-b154-d8bf2c7997c9@kernel.org>
Date: Sun, 1 Mar 2026 18:38:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
References: <20260301194548.927324-1-kuba@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260301194548.927324-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/1/26 12:45 PM, Jakub Kicinski wrote:
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 85df25c36409..7db0c837196c 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -1063,7 +1063,8 @@ static struct net_device *ip6_rt_get_dev_rcu(const struct fib6_result *res)
>  		 */
>  		if (netif_is_l3_slave(dev) &&
>  		    !rt6_need_strict(&res->f6i->fib6_dst.addr))
> -			dev = l3mdev_master_dev_rcu(dev);
> +			dev = l3mdev_master_dev_rcu(dev) ? :
> +			      dev_net(dev)->loopback_dev;

how can the flag on the netdev say there is L3 master, yet the device
not be there within an rcu window?


>  		else if (!netif_is_l3_master(dev))
>  			dev = dev_net(dev)->loopback_dev;
>  		/* last case is netif_is_l3_master(dev) is true in which

