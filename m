Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449708;
	b=AwYMxtU67LE6RoEij7vomlDLuayQLHEuBefTbH0SchXuWTwsERsOsp6SnBPeYxS+7H6a
	 f+19LiFaCmzejGx+bJQGIYRr3yt6oQkBDfwNfVOHreRwkqgP2MJs3NWxNVPLSm3dZt254
	 dKKcu22SwCnfTQxciOCQI3l58w3/SXeOWNUGzW//OCrUucwZpX+NZwhteh5rpwuT3ZMxk
	 mBsEVTb3LkvpGMrEuKUi/7Nj5gWnNkkcWktQis4uh7cOOt+NjeFawT2XOBtLhp7GeVpqT
	 rA5VE72a3/Dwocfwy8lB4lRokl/+V7nlWkFYL04QwW+Z1H5JDCLk6cPFcdV9OLXMzvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449708;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=w/G+bI1y1XPFEXnVVSbx5g6FUS3R8cb54ecVY4rT5Jo=;
	b=FZHjW+3WD316fX7TU+9xK9UF8eLkpKI+a4KRzrNVwJJI1c/YqVBpcfq+1pQgHOTWDcR4
	 +N+2bh5krK1eoOTiEYSyQQ7pQl4dPoyJTirPDJ2fz/GMzUBh0QCF0VfPn6rQleoXj4aH6
	 424RlOGgGw38nWsWXeOe/axZvFWdmYCVEb9eM+/ba9E5fEE+UAmjCm7vHekb/zyzC3iA5
	 8jPmgwAxBzlr0DVJn5Ptb4vH81iQJ0Ls8BQSzgmwo6tb0Xc2Od6oC5ECbUAGIXzYGfe5B
	 qtSEALg5B66qArlWZjycG5WOHniWs6sisXZ8gdKDL+LrlMBPq5Ii7WeA8iYsxgNTt+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EoJRmJLK;
	arc=none smtp.remote-ip=91.218.175.29
Received: from mta0.migadu.com (out-29.mta0.migadu.com [91.218.175.29])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2E9606A336
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE2E9606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EoJRmJLK
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9G2qFQ4sYFCKpZ2fPFqNG76HFv5MjfylAO8756ay2zY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794449705; v=1; x=1795054505;
 b=EoJRmJLKm+kw70cJWNKRWqUckONbjm+w8bJvrTe2T0pBpuUrFFktrGezsExIBLjTMxZhgkFa
 nmd3/OHl0lYIgp8tOJRdrYLXbEiOLPjpfNRxm2GY+Fo0Ia4zU/gGYjlxTIakNF13amTs5MXrib0
 ute6cruuUDofSLNGqxXK2Qa4=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id ae91a8d985c07d3d;
	Thu, 12 Nov 2026 02:15:04 +0000
X-Mizu-Trace-ID: ae91a8d985c07d3d
X-Migadu-Flow: FLOW_OUT
Date: Thu, 12 Nov 2026 10:14:50 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, 1342116488@qq.com
Subject: Re: [PATCH net-next] ipv6: check mc_forwarding before calling
 ip6mr_get_route()
Message-ID: <avUhGnPJk5Kzci3E@fedora>
References: <20261111094528.425826-1-sunwenbo@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111094528.425826-1-sunwenbo@cmss.chinamobile.com>

Hi Wenbo,
On Wed, Nov 11, 2026 at 05:45:28PM +0800, Wenbo Sun wrote:
> When CONFIG_IPV6_MROUTE is enabled, rt6_fill_node() unconditionally calls
> ip6mr_get_route() whenever an input interface is specified and the
> destination address is multicast.
> 
> However, if multicast routing is not active (i.e. no multicast routing
> daemon is running and mc_forwarding is 0), there is no matching (S,G)
> multicast routing cache entry, and skb->dev is NULL in the synthetic route
> query skb allocated by inet6_rtm_getroute(). As a result, ip6mr_get_route()
> returns -ENODEV, which causes rt6_fill_node() to jump to nla_put_failure
> and return -EMSGSIZE to userspace ("RTNETLINK answers: Message too long").
> 
> In contrast, IPv4 counterpart rt_fill_info() checks
> IPV4_DEVCONF_ALL_RO(net, MC_FORWARDING) before attempting to query
> ipmr_get_route(), and falls back to emitting RTA_IIF and normal local
> delivery route attributes when multicast routing is not enabled.
> 
> This discrepancy was identified during code audit of multicast route get
> handling. The failure was confirmed on a UML kernel: querying an IPv6
> multicast route with an input interface ("ip -6 route get <mcast_addr>
> from <src_addr> ...") failed with -EMSGSIZE on an unpatched kernel.
> 
> Align IPv6 behavior with IPv4 by checking whether mc_forwarding is active
> (atomic_read(&net->ipv6.devconf_all->mc_forwarding)) before calling
> ip6mr_get_route(). When mc_forwarding is 0, rt6_fill_node() proceeds to
> output RTA_IIF and normal route attributes.
> 
> Tested:
> - On a UML kernel with CONFIG_IPV6_MROUTE=y, verified that
>   "ip -6 route get ff0e::1 from 2001:db8::3 ..." with an input interface
>   now succeeds and outputs the route instead of failing with -EMSGSIZE.
> - Verified that IPv6 unicast route get and multicast route get without
>   an input interface continue to work as expected.
> - Built with W=1 on UML, x86_64 allmodconfig, and x86_64 allyesconfig with
>   zero new warnings or errors.
> 
> Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
> ---
>  net/ipv6/route.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 2eb884558c24..6dd4a70f6490 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -5862,7 +5862,8 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
>  #endif
>  	if (iif) {
>  #ifdef CONFIG_IPV6_MROUTE
> -		if (ipv6_addr_is_multicast(&rt6_dst->addr)) {
> +		if (ipv6_addr_is_multicast(&rt6_dst->addr) &&
> +		    atomic_read(&net->ipv6.devconf_all->mc_forwarding)) {
>  			int err = ip6mr_get_route(net, skb, rtm, portid);
>  
>  			if (err == 0)

In commit fd61c6ba313d ("net: ipv6: remove nowait arg to rt6_fill_node"),
David Ahern removed the nowait arg. Should we still return immediately
after err == 0? Also later if (err < 0), it still goto nla_put_failure
and return -EMSGSIZE. Maybe we can carry the err to the end and return
a more meaningful reason?

Anyway the added checking makes sense to me.

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
