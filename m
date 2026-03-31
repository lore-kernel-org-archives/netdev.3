Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B492F5A34;
	Tue, 31 Mar 2026 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917990; cv=none; b=p698pHzGJN3Xp43BGa4XvKo+t232qt+j9Mux1kEnc1VUSZI/CF/EHZD4ygeBhAQDHzX5fknNrXViI7Uzm80FtWDTl16a9dRu4+h5TRI0eQMzDCjF4iriBS9Ed5yqUZEY++uptRPXwzA8Of3Cx/sjI+a6SMtzJcGaXb/ioXRPbUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917990; c=relaxed/simple;
	bh=Ng5xulmJbykg7qv1WJ/ziJTsz9xWAcA5AbewZsttxPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKaYAgoetcaCF9o6Pzog+2SKpgu2wxjlD1KXlcj+bIsKwNO0XY5zU3DEEQoNXF8rf6ImMTmS9Luz5aW90B4htTsM6DAvpfi9vUuRprUwPFJu0wT3jqM6agHxVsHfO6SRHwEFBtVcrPIZw+nRosTWrPeJe6nd6auicJinort3Wpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkSRGqPw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkSRGqPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC70C4CEF7;
	Tue, 31 Mar 2026 00:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774917989;
	bh=Ng5xulmJbykg7qv1WJ/ziJTsz9xWAcA5AbewZsttxPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WkSRGqPwi79zR2IIYC0RU40bAtDsfM3TMLoKocwUFShNZ3HuuILAAjxU8KlgY7EoI
	 6Xz/gLlapPA0UDiAwoe9+esZUOrSxLOI/Rkp42AAE2q8O84tYAaotKdavS+URQmw7D
	 gU/oFQ2L+KdVD/8o7R7vFzl2SkglzUt44oBDcLmwreyF/4rNBlYp4TUQXICo9lnDRj
	 EJk6OikG30dMZfF2vwe+WuY1hi1Bi7cpglmDYf9g4DGTxLEJeVRYuPqKJdbdYOI5W0
	 ca45mNzFzrM7wyel9mH7RMIWXIYJRsozLukYp2boCNxvIBaiRn/j9ia2EMx858QFfL
	 E5xRkd56GLEwQ==
Date: Mon, 30 Mar 2026 17:46:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Fei Liu
 <feliu@redhat.com>
Subject: Re: [PATCH net v2] ipv6: fix data race in fib6_metric_set() using
 cmpxchg
Message-ID: <20260330174628.0cb1ebc6@kernel.org>
In-Reply-To: <20260327-b4-fib6_metric_set-kmemleak-v2-1-366b2c78b5c2@gmail.com>
References: <20260327-b4-fib6_metric_set-kmemleak-v2-1-366b2c78b5c2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 10:24:47 +0800 Hangbin Liu wrote:
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -730,17 +730,24 @@ void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val)
>  	if (!f6i)
>  		return;
>  
> -	if (f6i->fib6_metrics == &dst_default_metrics) {
> +	if (READ_ONCE(f6i->fib6_metrics) == &dst_default_metrics) {
> +		struct dst_metrics *dflt = (struct dst_metrics *)&dst_default_metrics;

Why does this exist? To cast away the const?

>  		struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
>  
>  		if (!p)
>  			return;
>  
> +		p->metrics[metric - 1] = val;
>  		refcount_set(&p->refcnt, 1);
> -		f6i->fib6_metrics = p;
> +		if (cmpxchg(&f6i->fib6_metrics, dflt, p) != dflt)
> +			kfree(p);
> +		else
> +			return;
>  	}
>  
> -	f6i->fib6_metrics->metrics[metric - 1] = val;
> +	struct dst_metrics *m = READ_ONCE(f6i->fib6_metrics);

No variable declarations in the middle of a function please.

> +	WRITE_ONCE(m->metrics[metric - 1], val);
>  }
