Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD143C7C4;
	Thu, 30 Jul 2026 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785426312; cv=none; b=ppAHvI3gIaNBqaIa0UDjxxOYlwuLoVb/gLpvF2di2f8ABCeEffSWlKAHzyrOATSemqZZfcyFIgjodShlbkaRdY+JeaR9SXnwNYMfqKByxUx9ectRWqCOTEyCrnVcrEXn1Bzdw5hXAAenW0hSIpaNRjUoYNDMdDPdd66AAjKDS18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785426312; c=relaxed/simple;
	bh=iTHw/K2IF9EmPyxT8/T6I69QfQf5cZNgodrYtpJfWMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/YM4kKBE5UXCeSZIFYnNntuVSl0nB0xGKAAiwrnoQJ4eiRAQviPgRqk495u4KAycf6Wo9hlQhvAMujVKzxIsFd17EYmJSS9S6/Ua7lWKYos6sfEriYYDoK0fEAfnMZT4XsFErXiTwfAvoVl9mwgqhrzDBDmiXNwM2PM5PRpIpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW18L1Bj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW18L1Bj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2F01F00A3A;
	Thu, 30 Jul 2026 15:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785426311;
	bh=ZVvrjrZ4uU5XwtVP5iM2dZ93y5LbtvYPGASnI2bE1gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dW18L1Bjux4+OxpHA4P5NBoDRjwqCllbEtviiH3OuEpX7uaSjG14FFsBjqaJxhGQA
	 Si3GXRPpVKYHhOzJHRwwH848XObl372eeh6n+BNF3q1dagPeRTiAKQLm86h42Mypf/
	 hlm6Uj0M/9pCQkxHG5xUL4FMfssCh3MMDixuP3yXNPCZaiIvLRwhyYv77iT94pvIXA
	 dZRxfNJXY+7HpV8YvzO2UDEsjnoop5NScbgKOAveSlNYvNEmy+TvqFC7GELKFxlxo5
	 Oq0O1sioaAE6T/OJTh+3ctMsrooKlNtMaQTmiFF4BXrIOTcK76mVyM4CVueR25QOai
	 W97eEDRl70BtQ==
Date: Thu, 30 Jul 2026 17:45:08 +0200
From: Antoine Tenart <atenart@kernel.org>
To: xuanqiang.luo@linux.dev
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, tom@herbertland.com, 
	aduyck@mirantis.com, linux-kernel@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v1] udp: fix potential use-after-free in tunnel
 segmentation
Message-ID: <amtxfCFLD-nlsdTm@kwain>
References: <20260730093554.68127-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730093554.68127-1-xuanqiang.luo@linux.dev>

On Thu, Jul 30, 2026 at 05:35:54PM +0800, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> __skb_udp_tunnel_segment() gets the UDP header before ensuring the
> tunnel header is in the skb head. If the pull reallocates skb->head,
> the saved UDP header pointer is no longer valid.
> 
> Get the UDP header after the pull to avoid a potential use-after-free.
> 
> Fixes: dbef491ebe7f ("udp: Use uh->len instead of skb->len to compute checksum in segmentation")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Antoine Tenart <atenart@kernel.org>

> ---
>  net/ipv4/udp_offload.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 29651b1a0bc70..639c59044c135 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -178,7 +178,7 @@ static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
>  	int tnl_hlen = skb_inner_mac_header(skb) - skb_transport_header(skb);
>  	bool remcsum, need_csum, offload_csum, gso_partial;
>  	struct sk_buff *segs = ERR_PTR(-EINVAL);
> -	struct udphdr *uh = udp_hdr(skb);
> +	struct udphdr *uh;
>  	u16 mac_offset = skb->mac_header;
>  	__be16 protocol = skb->protocol;
>  	u16 mac_len = skb->mac_len;
> @@ -189,6 +189,8 @@ static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
>  	if (unlikely(!pskb_may_pull(skb, tnl_hlen)))
>  		goto out;
>  
> +	uh = udp_hdr(skb);
> +
>  	/* Adjust partial header checksum to negate old length.
>  	 * We cannot rely on the value contained in uh->len as it is
>  	 * possible that the actual value exceeds the boundaries of the
> -- 
> 2.43.0
> 
