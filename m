Received: from mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1232E2DDD
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 01:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790213478; cv=none; b=MwE6txaCFgPx+IQ96T9Nu2eVDtLepXNvp8SuzbJECtjyuvPOBSN7h86ZshkVXZzdQJ51BwQQ/qBJNVCf6S2TPoKAFY82VzTeFLxVLv1QqnV8zHY8fn01hBQsovZ3KhKWAXJMV7a9IGFRZvca5iLQTwWvim8P80XHKcUKlfKCWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790213478; c=relaxed/simple;
	bh=ag+ZUwlDzFeNvrCPxmLy3KDciZGg8ZkkgsfnAenlFAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebb6yij/s0aiYtOYwhN4xTyWa5TFNn5jDYzrEWD3r6GTpuXH/67G7dnLxo9l9rDX4a/IkSwebK1BQADjsxUdSPfZO9jF9zhnEytQvKP2lXbclzIuU3M0rzAyWkq9XsmBH9++xCygyYOYSbs1eANEjiOh0yW0qVKXQhMW1LLSe+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mMro5ifd; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mMro5ifd"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ag+ZUwlDzFeNvrCPxmLy3KDciZGg8ZkkgsfnAenlFAE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790213474; v=1; x=1790818274;
 b=mMro5ifdbAQiIVpxbTsyzcerG1jd66OxzHyuoROc32ENXNtjB8FPYvRzp1bmv5n289aOo2qv
 ophIDmu9dX9gcEJ+NsrJY6DPp62ox4/id77PZFleePbUI+o0xtgye4W4GpAX1Qh7KSsV3r+4QwD
 ldZKsovRSG2s6IjurtpNPQKY=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id b1111577bfa5aa53;
	Thu, 24 Sep 2026 01:31:14 +0000
X-Mizu-Trace-ID: b1111577bfa5aa53
X-Migadu-Flow: FLOW_OUT
Date: Thu, 24 Sep 2026 09:31:07 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: ipv6: seg6: report lwtunnel setup
 errors via extack
Message-ID: <arR9WwUQv5NReOyS@fedora>
References: <20260923120228.172643-1-g.goller@proxmox.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923120228.172643-1-g.goller@proxmox.com>

Hi Gabriel,
On Wed, Sep 23, 2026 at 02:02:04PM +0200, Gabriel Goller wrote:
> seg6_build_state() rejected invalid configurations with a generic -EINVAL,
> so "ip route add ... encap seg6 ..." always reported "Invalid argument".
> 
> Attach an extack message to each of them. The checks themselves and their
> return values are unchanged.
> 
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> ---
> 
> v3 (https://lore.kernel.org/all/20260922090851.38978-1-g.goller@proxmox.com/):
>  * format fix
>  * use NL_SET_ERR_MSG_ATTR
> 
> v2 (https://lore.kernel.org/all/20260918153544.1178884-1-g.goller@proxmox.com/):
>  * dropped tests
> 
>  net/ipv6/seg6_iptunnel.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 61c6a27bf202..9f1aecc4f215 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -756,8 +756,11 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
>  	struct seg6_lwt *slwt;
>  	int err;
>  
> -	if (family != AF_INET && family != AF_INET6)
> +	if (family != AF_INET && family != AF_INET6) {
> +		NL_SET_ERR_MSG(extack,
> +			       "unsupported address family for SRv6 encapsulation");
>  		return -EINVAL;
> +	}
>  
>  	err = nla_parse_nested_deprecated(tb, SEG6_IPTUNNEL_MAX, nla,
>  					  seg6_iptunnel_policy, extack);
> @@ -765,8 +768,10 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
>  	if (err < 0)
>  		return err;
>  
> -	if (!tb[SEG6_IPTUNNEL_SRH])
> +	if (!tb[SEG6_IPTUNNEL_SRH]) {
> +		NL_SET_ERR_MSG_ATTR(extack, nla, "missing SRv6 SRH attribute");
>  		return -EINVAL;

My bad. NL_SET_ERR_MSG_ATTR expects the specific attr. In this error path,
there is no tb[SEG6_IPTUNNEL_SRH]. So we can keep using NL_SET_ERR_MSG().

> +	}
>  
>  	tuninfo = nla_data(tb[SEG6_IPTUNNEL_SRH]);
>  	tuninfo_len = nla_len(tb[SEG6_IPTUNNEL_SRH]);
> @@ -776,13 +781,18 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
>  	 */
>  	min_size = sizeof(*tuninfo) + sizeof(struct ipv6_sr_hdr) +
>  		   sizeof(struct in6_addr);
> -	if (tuninfo_len < min_size)
> +	if (tuninfo_len < min_size) {
> +		NL_SET_ERR_MSG(extack, "truncated SRv6 SRH attribute");

And here I think we can use like

	NL_SET_ERR_MSG_ATTR(extact, tb[SEG6_IPTUNNEL_SRH], "truncated ...")

>  		return -EINVAL;
> +	}
>  
>  	switch (tuninfo->mode) {
>  	case SEG6_IPTUN_MODE_INLINE:
> -		if (family != AF_INET6)
> +		if (family != AF_INET6) {
> +			NL_SET_ERR_MSG(extack,
> +				       "inline mode requires an IPv6 route");

Same here

	NL_SET_ERR_MSG_ATTR(extact, tb[SEG6_IPTUNNEL_SRH], "inline ...")

>  			return -EINVAL;
> +		}
>  
>  		if (tb[SEG6_IPTUNNEL_SRC]) {
>  			NL_SET_ERR_MSG(extack, "incompatible mode for tunsrc");
> @@ -798,12 +808,16 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
>  	case SEG6_IPTUN_MODE_L2ENCAP_RED:
>  		break;
>  	default:
> +		NL_SET_ERR_MSG(extack, "invalid SRv6 encapsulation mode");

And here.

>  		return -EINVAL;
>  	}
>  
>  	/* verify that SRH is consistent */
> -	if (!seg6_validate_srh(tuninfo->srh, tuninfo_len - sizeof(*tuninfo), false))
> +	if (!seg6_validate_srh(tuninfo->srh, tuninfo_len - sizeof(*tuninfo),
> +			       false)) {
> +		NL_SET_ERR_MSG(extack, "invalid SRv6 segment routing header");
>  		return -EINVAL;
> +	}

Here.

Thanks
Hangbin
