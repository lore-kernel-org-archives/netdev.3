Received: from mta0.migadu.com (out-43.mta0.migadu.com [91.218.175.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC89C388392
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 06:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789369160; cv=none; b=CsdjoOiTSuGVKOoGChH1bUaCssSXSksITuGkJ2w67OJSG1sZpHzxNcuOm76VyWbf/0wtq9JxdRk5RFhMszcMDEwtJ2r3VgS6fL79uPf0Z5u9js2Ub/LfwgoFfK8sYdgurvDqqbIqljU89T1h3EGoMVQYMnGa13wWM7GFsdQNAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789369160; c=relaxed/simple;
	bh=RdI38lPbEJ2mWlXOoSpq+ttdSUBVsk+hP74ijK+MXlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMDTUWS7BhSbMwNdRohgWD2Ktcx5l8vCtXINMyjiorrGBzpHo3THNbQypmlzEuwR7M51WMv0Kn0SnE1+/pna2dlTOU3e814diTbyyrHM//+z8MKKBP1f+JIc+GfglFc/ydInhZBXkFr8+KL5ThIBXBIMSbbnQZvFNOZYrlz9FIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BVKF8w31; arc=none smtp.client-ip=91.218.175.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BVKF8w31"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RdI38lPbEJ2mWlXOoSpq+ttdSUBVsk+hP74ijK+MXlI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789369156; v=1; x=1789973956;
 b=BVKF8w31L11ninD2BWqamjPP7wpnfEZ9D+YsONuirnVy+HtACe/WyckHsFDYrGhlBndhWJuO
 E4OADB/C/HdVQmhImCDXzzzCgcnid94CiqLiwHWiTPHfF59qLuawoaCzaGkyaYUQCnUTlSS7PeP
 i+GEyWXER5SsHxZrbjDOzyLo=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 2d3a4388d5ce9ab6;
	Mon, 14 Sep 2026 06:59:06 +0000
X-Mizu-Trace-ID: 2d3a4388d5ce9ab6
X-Migadu-Flow: FLOW_OUT
Date: Mon, 14 Sep 2026 14:58:52 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, edumazet@google.com, dsahern@kernel.org,
	idosch@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org,
	luoxuanqiang@kylinos.cn
Subject: Re: [PATCH net-next v2] ipv6: make IPV6_FREEBIND and
 IPV6_TRANSPARENT setsockopt lockless
Message-ID: <aqebLK84eb_lfPOE@fedora>
References: <20260912134040.215664-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912134040.215664-1-xuanqiang.luo@linux.dev>

On Sat, Sep 12, 2026 at 09:40:40PM +0800, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> IPV6_FREEBIND and IPV6_TRANSPARENT still take the socket lock despite
> using inet_assign_bit() to update the flags shared with IP_FREEBIND
> and IP_TRANSPARENT. IPv6 TCP and UDP sockets can already update these
> flags without the lock through the corresponding SOL_IP options.
> 
> Move both options to the lockless setsockopt path.
> 
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
> Changes:
> v2:
>   - Squash the two patches into one and drop the cover letter.
>     (Eric Dumazet.)
> 
> v1: https://lore.kernel.org/all/20260911102418.157071-1-xuanqiang.luo@linux.dev/
> 
>  net/ipv6/ipv6_sockglue.c | 36 +++++++++++++++---------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> index 1f68fb64a43ef..4b3536571c980 100644
> --- a/net/ipv6/ipv6_sockglue.c
> +++ b/net/ipv6/ipv6_sockglue.c
> @@ -398,6 +398,21 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
>  
>  	/* Handle options that can be set without locking the socket. */
>  	switch (optname) {
> +	case IPV6_FREEBIND:
> +		if (optlen < sizeof(int))
> +			return -EINVAL;
> +		/* Shared with IP_FREEBIND. */
> +		inet_assign_bit(FREEBIND, sk, valbool);
> +		return 0;
> +	case IPV6_TRANSPARENT:
> +		if (valbool && !sockopt_ns_capable(net->user_ns, CAP_NET_RAW) &&
> +		    !sockopt_ns_capable(net->user_ns, CAP_NET_ADMIN))
> +			return -EPERM;
> +		if (optlen < sizeof(int))
> +			return -EINVAL;
> +		/* Shared with IP_TRANSPARENT. */
> +		inet_assign_bit(TRANSPARENT, sk, valbool);
> +		return 0;
>  	case IPV6_UNICAST_HOPS:
>  		if (optlen < sizeof(int))
>  			return -EINVAL;
> @@ -666,27 +681,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
>  		retv = 0;
>  		break;
>  
> -	case IPV6_TRANSPARENT:
> -		if (valbool && !sockopt_ns_capable(net->user_ns, CAP_NET_RAW) &&
> -		    !sockopt_ns_capable(net->user_ns, CAP_NET_ADMIN)) {
> -			retv = -EPERM;
> -			break;
> -		}
> -		if (optlen < sizeof(int))
> -			goto e_inval;
> -		/* we don't have a separate transparent bit for IPV6 we use the one in the IPv4 socket */
> -		inet_assign_bit(TRANSPARENT, sk, valbool);
> -		retv = 0;
> -		break;
> -
> -	case IPV6_FREEBIND:
> -		if (optlen < sizeof(int))
> -			goto e_inval;
> -		/* we also don't have a separate freebind bit for IPV6 */
> -		inet_assign_bit(FREEBIND, sk, valbool);
> -		retv = 0;
> -		break;
> -
>  	case IPV6_RECVORIGDSTADDR:
>  		if (optlen < sizeof(int))
>  			goto e_inval;
> 
> base-commit: 348ea4642f56ab3dc93621c8e3ab0ccd0e5f1782
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
