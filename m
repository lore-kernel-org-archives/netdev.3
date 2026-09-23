Received: from mta0.migadu.com (out-249.mta0.migadu.com [91.218.175.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3FB340A6F
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127004; cv=none; b=LVA8cjhK9DMmt3cMw+ujcLsp/KTwfaVKEa3cJ2hdNJhM/v9HGQ1xDgWItxsUPPg+0ADGpkjKxrYqGdrMgGfSCCEPw22U31ZoQzxj8YEvL7dWQxsGcxh/4JnbXBd4g8ORO1/dN2ocgPdOtez0Uiqc0sl4xpjUdAZO7f4aaufVqEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127004; c=relaxed/simple;
	bh=dS5qUtvKQC1wRIgURnnfaocsTm6UxBc5fX4lBc2zSJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBpdo6e26AgGS4zT+WVLm3jh0aVEJmVAHB8eS/GcdMtWGMYCeXJcXtU9Zqstim7jIUBgwegzXld9uh8iwxoaUpAyIOC8UeY9rRivPs0HwVosMq/e0twEdOER3z0HuYgfgolAyBIkIN5n22+B5cGGj16PmSRqq49hvWhHfqAjnXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FPNHYdsR; arc=none smtp.client-ip=91.218.175.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FPNHYdsR"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dS5qUtvKQC1wRIgURnnfaocsTm6UxBc5fX4lBc2zSJk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790126999; v=1; x=1790731799;
 b=FPNHYdsRYakN8DSQIJSZSihPd9eAZpPYqpkQhtXfXSPNoM7zM9RqvHcw3sTcKBYTh8ZNw/IG
 sqX1jy7+/QwAjokpc3r3s4oW4YrgjEGwaYtAeJXJCeADNX3GNirTuFCzykQWSv9CjnxEAw2PbDg
 pBfpI97D34nTwouoANKmQ294=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 380b12c68c1d1d35;
	Wed, 23 Sep 2026 01:29:59 +0000
X-Mizu-Trace-ID: 380b12c68c1d1d35
X-Migadu-Flow: FLOW_OUT
Date: Wed, 23 Sep 2026 09:29:43 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: ipv6: seg6: report lwtunnel setup
 errors via extack
Message-ID: <arMrh_SqjKz2PqlR@fedora>
References: <20260922090851.38978-1-g.goller@proxmox.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922090851.38978-1-g.goller@proxmox.com>

On Tue, Sep 22, 2026 at 11:08:33AM +0200, Gabriel Goller wrote:
> seg6_build_state() rejected invalid configurations with a generic -EINVAL, so
> "ip route add ... encap seg6 ..." always reported "Invalid argument".
> 
> Attach an extack message to each of them. The checks themselves and their return
> values are unchanged.
> 
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> ---
> 
> v2 (https://lore.kernel.org/netdev/20260918153544.1178884-1-g.goller@proxmox.com/):
>  * dropped tests
> 
>  net/ipv6/seg6_iptunnel.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 61c6a27bf202..e7f75970e26e 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -756,8 +756,12 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
>  	struct seg6_lwt *slwt;
>  	int err;
>  
> -	if (family != AF_INET && family != AF_INET6)
> +	if (family != AF_INET && family != AF_INET6) {
> +		NL_SET_ERR_MSG(
> +			extack,
> +			"unsupported address family for SRv6 encapsulation");
>  		return -EINVAL;
> +	}
>  
>  	err = nla_parse_nested_deprecated(tb, SEG6_IPTUNNEL_MAX, nla,
>  					  seg6_iptunnel_policy, extack);
> @@ -765,8 +769,10 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
>  	if (err < 0)
>  		return err;
>  
> -	if (!tb[SEG6_IPTUNNEL_SRH])
> +	if (!tb[SEG6_IPTUNNEL_SRH]) {
> +		NL_SET_ERR_MSG(extack, "missing SRv6 SRH attribute");

I think we can use NL_SET_ERR_MSG_ATTR.

Thanks
Hangbin
