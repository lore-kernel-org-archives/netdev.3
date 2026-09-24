Received: from mta1.migadu.com (out-107.mta1.migadu.com [95.215.58.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D73429B79B
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790212730; cv=none; b=X4TMAw0Dr5jumVacb1XIFoxkrYU+B6ToiLoPFNSlOcpt472V1sGXewYg7riMsGW8cYsKqb0HDwr0/iqBu+wQYTEHOxpN/TXn9cOh824FcagNnXb3g98EvHY9rzbxbWI+8efspPHqBb+qrWbES80MjAuprGOhtq7NtI2/L2+UClc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790212730; c=relaxed/simple;
	bh=jDGt0nOmjzKzO8dq9HkznbAlolykbBiPoksw1KIcch0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAoLkOuD4uVC9PBO+U7slAjwyau5s+/D0n4QZXEOGvTMluoWTSdPFBg9Y+xfaAYHioYEDHbsBI4twzGxvVsmCuLKWtBaqjPf7eRRJGBts4kzYmUlQnHblj7QmhykPiaNIEMA6Y4hfrVm+4j03Y7iDlB9WdwZjJgg78nIKdl9O3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JRCrkjPx; arc=none smtp.client-ip=95.215.58.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JRCrkjPx"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jDGt0nOmjzKzO8dq9HkznbAlolykbBiPoksw1KIcch0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790212725; v=1; x=1790817525;
 b=JRCrkjPxs/Bk8NmEoCj+qChe+60kngW+OVVp4RbBYwQfCreeAr7ffquaMGCdJlw3cSy6iWUR
 gWp8MjRCW8vMUKQ8DJ3ifcr+r/F/VVnk/79QD+LhPZMCcBzni3A9lhfeUealEWcpq6uHcbhogPj
 5QQCS0O3jjLD/3kMIzzN6Cgw=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 429b0a2ca9ffcf3b;
	Thu, 24 Sep 2026 01:18:45 +0000
X-Mizu-Trace-ID: 429b0a2ca9ffcf3b
X-Migadu-Flow: FLOW_OUT
Date: Thu, 24 Sep 2026 09:18:32 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Qishuai Liu <lqs@lqs.me>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv6: fix prefix route expiry in
 modify_prefix_route()
Message-ID: <arR6KOhDYJrK0lqB@fedora>
References: <20260923132048.3272878-1-lqs@lqs.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923132048.3272878-1-lqs@lqs.me>

On Wed, Sep 23, 2026 at 01:20:48PM +0000, Qishuai Liu wrote:
> modify_prefix_route() is given the lifetime in clock_t relative to now,
> but fib6_set_expires() wants an absolute jiffies value. So when a
> permanent address is changed to a finite valid_lft, the prefix route
> ends up already expired and GC removes it.
> 
> Steps to reproduce:
> 
>   ip link add dummy9 type dummy
>   ip link set dummy9 up
>   ip -6 addr add 2001:db8:9::1/64 dev dummy9
>   ip -6 addr change 2001:db8:9::1/64 dev dummy9 valid_lft 3600 preferred_lft 3600
>   ip -6 route show dev dummy9    # expires is negative

nit: Does GC really removes it? I see the expires is negative, but the time
seems overflow and GC won't remove it.

> 
> Fixes: 8308f3ff1753 ("net/ipv6: Add support for specifying metric of connected routes")
> Signed-off-by: Qishuai Liu <lqs@lqs.me>
> ---
>  net/ipv6/addrconf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 9d89be7e0544..c90ee6dd7446 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -4874,7 +4874,7 @@ static int modify_prefix_route(struct net *net, struct inet6_ifaddr *ifp,
>  			fib6_clean_expires(f6i);
>  			fib6_may_remove_gc_list(net, f6i);
>  		} else {
> -			fib6_set_expires(f6i, expires);
> +			fib6_set_expires(f6i, jiffies + clock_t_to_jiffies(expires));
>  			fib6_add_gc_list(f6i);
>  		}

The code looks good to me.

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
