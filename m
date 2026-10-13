Received: from mta1.migadu.com (out-115.mta1.migadu.com [95.215.58.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C10C4A4EE9
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872063; cv=none; b=dbqHMDfj7+NTOWYMy4vP2r6nWaLELjEtL0HbkVLICHW+kDYlAjxnlp6AVue1g/gwTDvBYvauc82Y5XW9DRDqB/wCOi/C+7ABYagS9aNspPwIjV6irmECXgWKlmpoiqJSrB1o6a08xWoa7aeKUuxZPilkW6dgwh3DtojoFsKTvjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872063; c=relaxed/simple;
	bh=QsATYXt1xHNBXewMknM+2vvG4ngat0gGUTbIS3kxIak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apXE9ctFRkDO/g840KWhXtvXFKyhtaf/xbnN9TMiJJ3/mcTV9Kua1dd94ea31/mkqWalwZQzz5e2qPqdyNw2S2uL5ekCMlEfP+nTWDpxVKqBUK6dy8XcJXsjkol1feWPF9410fMEeHXeobQl5UVCl+veJiKsXVMbLo/fcIF0cGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fsHpCK7i; arc=none smtp.client-ip=95.215.58.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fsHpCK7i"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QsATYXt1xHNBXewMknM+2vvG4ngat0gGUTbIS3kxIak=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791872058; v=1; x=1792476858;
 b=fsHpCK7iecW9ZuemkYkY+Wqtt92aVrb8hy9OVMoq9lvDe9YOFhIS+HN/WUPl/Fe4AE501Ji5
 8m8X/a+zb9pLY7fEf8+TwDs85nIOi2mqd4Ub1v5iCLzWsB8llGyq1xT+43s2dkhURaH9ljaeYRd
 L/yf8LOsfUcxk6lL31PWZFpw=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 72a19cc71d4d7199;
	Tue, 13 Oct 2026 06:14:18 +0000
X-Mizu-Trace-ID: 72a19cc71d4d7199
X-Migadu-Flow: FLOW_OUT
Date: Tue, 13 Oct 2026 14:14:02 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] net: ipv6: seg6: report lwtunnel setup
 errors via extack
Message-ID: <as3MKiW1mqrX1MgC@fedora>
References: <20261009152015.462383-1-g.goller@proxmox.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009152015.462383-1-g.goller@proxmox.com>

Hi Gabriel,
On Fri, Oct 09, 2026 at 05:20:13PM +0200, Gabriel Goller wrote:
> seg6_build_state() rejected invalid configurations with a generic -EINVAL,
> so "ip route add ... encap seg6 ..." sometimes reported "Invalid argument".
> 
> Add extack messages to the checks that lacked one, and use
> NL_REQ_ATTR_CHECK() for the missing SRH attribute so that userspace can
> tell which attribute is missing. The checks themselves and their return
> values are unchanged.
> 
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> ---
> 
> v5 (https://lore.kernel.org/all/20261005140637.644840-1-g.goller@proxmox.com/):
>  * use NL_REQ_ATTR_CHECK() for the missing SRH attribute (Jakub)
>  * reword the inline mode message to "inline mode requires the IPv6
>    address family", since it also applies to IPv4 nexthop objects
>    (Andrea)
>  * consistently call the header "IPv6 Segment Routing Header" (RFC 8754)
>    in all messages (Andrea)
>  * include the offending mode value in the invalid mode message
>  * reword the commit message to match
> 
> v4 (https://lore.kernel.org/all/20260923120228.172643-1-g.goller@proxmox.com/):
>  * use NL_SET_ERR_MSG when the SRH attr is missing
>  * use NL_SET_ERR_MSG_ATTR when we have an invalid attr
> 
> v3 (https://lore.kernel.org/all/20260922090851.38978-1-g.goller@proxmox.com/):
>  * format fix
>  * use NL_SET_ERR_MSG_ATTR
> 
> v2 (https://lore.kernel.org/all/20260918153544.1178884-1-g.goller@proxmox.com/):
>  * dropped tests
> 
>  net/ipv6/seg6_iptunnel.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 69a6ef5c5317..0d39a38a5dd2 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -762,8 +762,11 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
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
> @@ -771,7 +774,7 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
>  	if (err < 0)
>  		return err;
>  
> -	if (!tb[SEG6_IPTUNNEL_SRH])
> +	if (NL_REQ_ATTR_CHECK(extack, nla, tb, SEG6_IPTUNNEL_SRH))
>  		return -EINVAL;
>  
>  	tuninfo = nla_data(tb[SEG6_IPTUNNEL_SRH]);
> @@ -782,13 +785,19 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
>  	 */
>  	min_size = sizeof(*tuninfo) + sizeof(struct ipv6_sr_hdr) +
>  		   sizeof(struct in6_addr);
> -	if (tuninfo_len < min_size)
> +	if (tuninfo_len < min_size) {
> +		NL_SET_ERR_MSG_ATTR(extack, tb[SEG6_IPTUNNEL_SRH],
> +				    "truncated IPv6 Segment Routing Header attribute");
>  		return -EINVAL;
> +	}
>  
>  	switch (tuninfo->mode) {
>  	case SEG6_IPTUN_MODE_INLINE:
> -		if (family != AF_INET6)
> +		if (family != AF_INET6) {
> +			NL_SET_ERR_MSG_ATTR(extack, tb[SEG6_IPTUNNEL_SRH],
> +					    "inline mode requires the IPv6 address family");
>  			return -EINVAL;
> +		}
>  
>  		if (tb[SEG6_IPTUNNEL_SRC]) {
>  			NL_SET_ERR_MSG(extack, "incompatible mode for tunsrc");
> @@ -804,12 +813,19 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
>  	case SEG6_IPTUN_MODE_L2ENCAP_RED:
>  		break;
>  	default:
> +		NL_SET_ERR_MSG_ATTR_FMT(extack, tb[SEG6_IPTUNNEL_SRH],
> +					"invalid SRv6 encapsulation mode %d",
> +					tuninfo->mode);
>  		return -EINVAL;
>  	}
>  
>  	/* verify that SRH is consistent */
> -	if (!seg6_validate_srh(tuninfo->srh, tuninfo_len - sizeof(*tuninfo), false))
> +	if (!seg6_validate_srh(tuninfo->srh, tuninfo_len - sizeof(*tuninfo),
> +			       false)) {
> +		NL_SET_ERR_MSG_ATTR(extack, tb[SEG6_IPTUNNEL_SRH],
> +				    "invalid IPv6 Segment Routing Header");
>  		return -EINVAL;
> +	}
>  
>  	newts = lwtunnel_state_alloc(tuninfo_len + sizeof(*slwt));
>  	if (!newts)
> -- 
> 2.47.3
> 
> 

Thanks for the update.

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
