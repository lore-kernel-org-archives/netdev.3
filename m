Received: from mta0.migadu.com (out-199.mta0.migadu.com [91.218.175.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260FD10F2
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789870496; cv=none; b=BYAYwiAfdYe5yQ9Mwed7k56ZNcYpEDqvkmm8hzUGEPYXM0evuNyaIRjpokNMQi2if4/GjlidhhOYUXEeijCOJi3LzKD9xz20jqquPxXo3CyRyi+EM+6RZawEt5QIKttw0Wv9zKY05nUoDWlWLmEXdHA4HYdqbAHfbNbmUh93MV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789870496; c=relaxed/simple;
	bh=gInrxQr7RzUoPGXd0Jztrt7BAd7FDVYZId+ILlnU6Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4zMd5ZneFlN8g50l829XXb33hI4q1XFgNLDDoln0uAaF0kMB0iNruNMB16nVgDQQrwGMGH1wW4V1cayW6xMZo0jPZYD6T0ZHVQh6CUCHuKgzxBAtZFXYbED0K31qU7Ca36hAn0isbKX0xIKghGAvOILH8CAWBSw47MU+XL5C1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZBEputKW; arc=none smtp.client-ip=91.218.175.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZBEputKW"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gInrxQr7RzUoPGXd0Jztrt7BAd7FDVYZId+ILlnU6Zg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789870492; v=1; x=1790475292;
 b=ZBEputKWxBuLBoHPLDULN1VolR92U68b52+ldevMdrhprmRjXugSV621AxQm8iL4VFS1W+7V
 tOSa5XRzNz3ARrJjI8tBdU1lEaTkr7UKeeaoR6pQOeVWYHUmQB7LG2kkHTkTgGI1H04X9Ei3Rvi
 Bgh7M8VjO2a9xmXLJc+TsQJI=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id fd4c83da557be30d;
	Sun, 20 Sep 2026 02:14:51 +0000
X-Mizu-Trace-ID: fd4c83da557be30d
X-Migadu-Flow: FLOW_OUT
Date: Sun, 20 Sep 2026 10:14:44 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Adriano Cordova <adrianox@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: check per-interface proxy_ndp in forwarding and NA
 paths
Message-ID: <aq9BlF-7wSOnYCvN@fedora>
References: <20260918151405.716075-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918151405.716075-1-adrianox@gmail.com>

On Fri, Sep 18, 2026 at 12:14:05PM -0300, Adriano Cordova wrote:
> proxy_ndp can be enabled per interface, with net.ipv6.conf.all.proxy_ndp
> as a global default. ndisc_recv_ns() checks both, but ip6_forward() and
> ndisc_recv_na() check only the global value. With the per-interface proxy
> ndp set and the global one left at 0, the router answers proxy NS but
> does not pass NDP messages to the proxied target.
> 
> Check both values at these two sites, as ndisc_recv_ns() already does.
> 
> Fixes: fbea49e1e240 ("[IPV6] NDISC: Add proxy_ndp sysctl.")
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  net/ipv6/ip6_output.c | 4 ++--
>  net/ipv6/ndisc.c      | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 550965058991..738fa46a892a 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -581,8 +581,8 @@ int ip6_forward(struct sk_buff *skb)
>  		return -ETIMEDOUT;
>  	}
>  
> -	/* XXX: idev->cnf.proxy_ndp? */
> -	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
> +	if ((READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
> +	     (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&
>  	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev)) {
>  		int proxied = ip6_forward_proxy_check(skb);
>  
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index 75515fd99383..f787082069b7 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -1097,9 +1097,9 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
>  		 */
>  		if (lladdr && !memcmp(lladdr, dev->dev_addr, dev->addr_len) &&
>  		    READ_ONCE(net->ipv6.devconf_all->forwarding) &&
> -		    READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
> +		    (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
> +		     (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&
>  		    pneigh_lookup(&nd_tbl, net, &msg->target, dev)) {
> -			/* XXX: idev->cnf.proxy_ndp */
>  			goto out;
>  		}
>  
> -- 
> 2.51.0
> 

LGTM

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
