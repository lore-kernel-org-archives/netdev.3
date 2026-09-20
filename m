Received: from mta1.migadu.com (out-69.mta1.migadu.com [95.215.58.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9AC3C37AF
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 02:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871835; cv=none; b=TC1pvfq/he1RQqFp33PfP6gqQjfVDHvXevG3r76NRsttQaorKtFrJxp/VqwHIyzN61qgXvOwCOc+IPBWk5Xf09T0a5mrUTHi1B97c2wWYaYvsBmg4URQNOxIkvEawS8d5xxTJMW+wfNHhgMBYmcdrHaqPj0LOj5BJ1FKZIuTfp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871835; c=relaxed/simple;
	bh=KEHC7Ybv8zBaTyt4GK6bKUm/ZUTKpqHf7pUVNn4EBkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4Cs7Tdnsr667qc218C00bT1fP70Ka7haQl5NL1zUyMPyoTXkBBZNbEgm/XZqxPuVOjElCicRsIDnkCC0WGBXUHXM/6lC1dq4Uc2vvPIqJ1Tj49/lk37oav7SLbqcAR5CNGKZ4DVN1VeN3UvnvsUELk5OmddTPSEeHso7LZ7deA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EUiV+vZB; arc=none smtp.client-ip=95.215.58.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EUiV+vZB"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KEHC7Ybv8zBaTyt4GK6bKUm/ZUTKpqHf7pUVNn4EBkE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789871825; v=1; x=1790476625;
 b=EUiV+vZBDMbKCHkmwLesAzghFwqVO9Ilqm19xlJ1NXVSU9myBkGXOZboWx3zxSC0Luo1fLT9
 Ptq7jLXmn2SdySsIJF2WDsTFPDNg4hyzpTErHGsDLvMxvtsyTqbpYI1D5ZwLneYkBHlQtMOXspI
 /QQ6d9w6zPJIbXJKR7ftXh1w=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 601a97d2d0705a04;
	Sun, 20 Sep 2026 02:37:05 +0000
X-Mizu-Trace-ID: 601a97d2d0705a04
X-Migadu-Flow: FLOW_OUT
Date: Sun, 20 Sep 2026 10:36:56 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Wei Wang <weiwan@google.com>,
	Marc Harvey <marcharvey@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net] ipv6: Fix dst leak for uncached routes.
Message-ID: <aq9GyCKfNYOCLLXa@fedora>
References: <20260918041439.2575935-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918041439.2575935-1-kuniyu@google.com>

On Fri, Sep 18, 2026 at 04:14:37AM +0000, Kuniyuki Iwashima wrote:
> ip6_route_output_flags(), ip6_rt_put_flags(), and ip6_dst_check()
> detect an uncached route by list_empty(&rt->dst.rt_uncached),
> which replaced the static DST_NOCACHE flag check in commit
> a4c2fd7f7891 ("net: remove DST_NOCACHE flag").
> 
> When a device is unregistered, rt6_uncached_list_flush_dev()
> unlinks uncached routes tied to the device from rt6_uncached_list.
> 
> Previously, they were moved to another list with list_move()
> (__list_del_entry() + list_add()), and since commit 98aa546af5e4
> ("inet: remove (struct uncached_list)->quarantine"), the routes
> are just unlinked with list_del_init().
> 
> If list_del_init() runs concurrently, list_empty() evaluates to
> true; ip6_route_output_flags() calls dst_hold_safe() incorrectly
> and ip6_rt_put_flags() skips ip6_rt_put(), leaking dst, and thus
> dev tied via rt->from as well.
> 
> The same race is partially fixed by commit 9a6f0c4d5796 ("dst:
> fix races in rt6_uncached_list_del() and rt_del_uncached_list()").
> 
> Let's check rt6->dst.rt_uncached_list instead.
> 
> Note that IPv4 does not have the same issue.
> 
> Fixes: 7d9e5f422150 ("ipv6: convert major tx path to use RT6_LOOKUP_F_DST_NOREF")
> Fixes: d64a1f574a29 ("ipv6: honor RT6_LOOKUP_F_DST_NOREF in rule lookup logic")
> Fixes: a4c2fd7f7891 ("net: remove DST_NOCACHE flag")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/ip6_route.h | 2 +-
>  net/ipv6/route.c        | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
> index b9e8d2b759e9..2c5ded121f54 100644
> --- a/include/net/ip6_route.h
> +++ b/include/net/ip6_route.h
> @@ -106,7 +106,7 @@ static inline struct dst_entry *ip6_route_output(struct net *net,
>  static inline void ip6_rt_put_flags(struct rt6_info *rt, int flags)
>  {
>  	if (!(flags & RT6_LOOKUP_F_DST_NOREF) ||
> -	    !list_empty(&rt->dst.rt_uncached))
> +	    rt->dst.rt_uncached_list)
>  		ip6_rt_put(rt);
>  }
>  
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 08bd68f1b5bb..b18cd0d9148c 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -2722,7 +2722,7 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
>  	dst = ip6_route_output_flags_noref(net, sk, fl6, flags);
>  	rt6 = dst_rt6_info(dst);
>  	/* For dst cached in uncached_list, refcnt is already taken. */
> -	if (list_empty(&rt6->dst.rt_uncached) && !dst_hold_safe(dst)) {
> +	if (!rt6->dst.rt_uncached_list && !dst_hold_safe(dst)) {
>  		dst = &net->ipv6.ip6_null_entry->dst;
>  		dst_hold(dst);
>  	}
> @@ -2831,7 +2831,7 @@ INDIRECT_CALLABLE_SCOPE struct dst_entry *ip6_dst_check(struct dst_entry *dst,
>  	from = rcu_dereference(rt->from);
>  
>  	if (from && (rt->rt6i_flags & RTF_PCPU ||
> -	    unlikely(!list_empty(&rt->dst.rt_uncached))))
> +	    unlikely(rt->dst.rt_uncached_list)))
>  		dst_ret = rt6_dst_from_check(rt, from, cookie);
>  	else
>  		dst_ret = rt6_check(rt, from, cookie);
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
