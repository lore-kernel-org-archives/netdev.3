Received: from mta1.migadu.com (out-148.mta1.migadu.com [95.215.58.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C52838D3F8
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024164; cv=none; b=iYI06tC0HIW7KeEGw1R6Jo8pqcxCJtHdPlv7Th5fsgH2TTYrgt/zn9SxzrzWmoo0sKI5m2UGxs2IG9heeJsxfTKTrTTjFCUliKeU8Hh0BoewyN6NcgSh3xPl/BFuxwKmV39yyzjlfc6M9MM3G7+NjzLCta1a7BiSxv3JuwBZFtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024164; c=relaxed/simple;
	bh=Y403jaOKhHe7Sb0nski03ecI6TvSN0eVBxJ/t2icqFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Min+EgqIbsjCpYpdql+2x7ffR0IJ+Fx96P8/tz7cmbgZRRefP9B5g4K0B6I8VBI+02uLWE3CcQ1iwbiWZ+zOMyy1Ppd/XArY7JiJRMeGc0PZzjlL5HSh6QOzCAzMnp2f5RaRBV1VQsyM4ZBhOyXJReWYVqsFUrp8DZd7s7/iev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pt+qALge; arc=none smtp.client-ip=95.215.58.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pt+qALge"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Y403jaOKhHe7Sb0nski03ecI6TvSN0eVBxJ/t2icqFs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789024159; v=1; x=1789628959;
 b=pt+qALgeeUpYSNuGoNlASvrZNU4uONSYbSlssJ7ULHhgwPs50wmTYxLDuMFOLIJlKwpI+Jpq
 nphebLwWKUAbOaDgy0/YsS/B/+t6c1Fogn41dPPvjF7XZKAPLslvS3Cm4eMXolbP0V+eHoWVeuY
 jsqdY//ldLC75kNrwF1g0dLI=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 74274ef4c270a488;
	Thu, 10 Sep 2026 07:09:19 +0000
X-Mizu-Trace-ID: 74274ef4c270a488
X-Migadu-Flow: FLOW_OUT
Date: Thu, 10 Sep 2026 15:09:10 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipv6: replace sprintf() with no format specifiers with
 strscpy()
Message-ID: <aqJXluR9b-5p76ei@fedora>
References: <20260909210552.51828-1-lalitshankarch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909210552.51828-1-lalitshankarch@gmail.com>

Hi Lalit,
On Wed, Sep 09, 2026 at 09:05:52PM +0000, Lalit Shankar Chowdhury wrote:
> Multiple instances of sprintf() have no format specifiers. Replace
> them with strscpy().
> 
> Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
> ---
>  net/ipv6/ip6_tunnel.c | 2 +-
>  net/ipv6/ip6_vti.c    | 2 +-
>  net/ipv6/ip6mr.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index d5ff50a2ac01..ef3a6d931c9e 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -294,7 +294,7 @@ static struct ip6_tnl *ip6_tnl_create(struct net *net, struct __ip6_tnl_parm *p)
>  			goto failed;
>  		strscpy(name, p->name, IFNAMSIZ);
>  	} else {
> -		sprintf(name, "ip6tnl%%d");
> +		strscpy(name, "ip6tnl%d", IFNAMSIZ);

The sprintf() is doing format expansion (%% -> %), the name will be used
in __dev_alloc_name() later. I think there is no need to change them.

Thanks
Hangbin
