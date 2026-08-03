Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D3C31E857
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770727; cv=none; b=jkZJBHZpUbhQP//YNzmHpZCeE1J9tS0ND23viNRDs7sRWdWW+KiYHTcsn+as01wUrPDC51KaY02MCyq1S0Xd7JI5saMNb9aIkkJsER2HkN6HqCoLPZ7dH1aaOuy6JSdq6JsK1rL1Y6CJBvvG23ieSG1zRKVZGhBD/LEZkbfNFgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770727; c=relaxed/simple;
	bh=OhJHb0JVLzDI82HddeXGyWsj9t/v/sHkSHf8DTKjUKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fylDKu4W34ZIIAvi9tB+n1q3iaYb4qpYV/QF5wbC9o85f7U7iX7PuvSQ1ez9b9A9KIidHARZrarl14pzU02/0Xa5TcgBldTmUDxskTki5gcVt+nsZf4y3vX9JEYD2m30Kz7KNTbP2U0ZnIms7VNiKZaF2WeHwgz8Sts4wuREsxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=m8MtngfJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="m8MtngfJ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso75175e9.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 08:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1785770724; x=1786375524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KwUQ3Wr2m8nBhJ/UMULCTIH4+LOh16SIlVduO+rNc04=;
        b=m8MtngfJPUXwrjuRijTsm8Shpo+2j1qon3hdJs8y/3gsKGk/T1vlRpVv9kSxMvc3G5
         2rm1YzuAQeBwjJP/m+gvYvmJ7/Cm1JeiC+8YyS5eSlom70xVbOW2fT+OTqdC+jy8AAJr
         NCNzstB1sIlrjqF6RTCtlJz0KEMZY8ROIrKAzCLx8dU+ScGzlays9zN2RMt8IFwi4Odz
         Tq9704EwG9z/bXIqrFIeDcW4FWSY7pRJea9CKdZaFxDrFIibLcnyCzBJATSCokQC3/sJ
         NL6d+Y0ofUeL0+rf5C0yd/7gTpSV9AokKL1b90MSVxjujNo+9s2GCLLNWFiEePaw/SAx
         ur5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785770724; x=1786375524;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KwUQ3Wr2m8nBhJ/UMULCTIH4+LOh16SIlVduO+rNc04=;
        b=a+BlOMa6Gmf5y89DOMS3ugb08UefhuoBKMxvk6nHZE8qmKoBievvaJzr9wERiAswMF
         P1gJKVeo2R5rZX82N27h+i7LScWkOqgCCtko7RuRyRGerNFWZ+xia8yxpSGCAmq7FFr5
         MdBMxUCsAYZJ4yh6t4tV+AbrUQYiMNz5gbkthtilykOL55lgztVnSa210EmaLOsHyeLo
         FuGgdR/FutESxti3SUHNvEOgUPwNfDWAeRxAi1ItODDi3O9qeShCCgo9nTA0D7eST/4j
         sXDiFcjhbTS0KnapNP8/AWvsdjHVPWFcVUiW/f4mSTCVAfmF6DOcubrAS+1qV3z5588c
         Xvhg==
X-Gm-Message-State: AOJu0YyihgF1Q0pAs7dGgMKwSQ+BGr+ZF3aq8oUJ5zsajiqCW2QdwuJB
	/HerxAdJizsZrXsD0g4dm/wsOtbPULscZCHSgjhc+8VSXrKK32FpLVaOBowgX2DNclE=
X-Gm-Gg: AR+sD10ZcTXjsUvBLWwtK9rV+lnRpBXIuYxgEF9vGTwOs0gjAf0xZbRiW2+V4N/Uznw
	WYcV723vHj/QzDXeD03u83utf0Vkz6XdWBHQC6r46qGiRQ14XZvUQRXds1fIL1C9znsCwSHccLJ
	J60ZJNgQr3biDS7HIKqJlWAPoPr8kvai8M9Ux6qePTF2WdeckNQjVUTuZQirylYaWnkM8zOS81L
	u4oTna3ZneNg/f6kticzb3BJewGtpkp/pnByaZTCdjk35eqI2r0SJejiSklPLKlV1S3jeIj1grK
	BdTV4QgriY/HqgX7qMV+SmTgNGgAOmbR/B22oIb68xI1UrMrHJWKnGu9LPGnwJFwF6LdlxIJUgv
	05j428W+nx9TtkotsMXrUqrI0KrwvtsBRqjfSB2eEJkbX7RCsPCZ7pPFkwXHeaOsF96u0SPE5az
	s0cLB5lYkRQxlRRwkeXOjT1X7wtguMokLyNW+CfZIc+dUrjb7QckmohSe4
X-Received: by 2002:a7b:ce08:0:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-49949f89850mr351145e9.0.1785770723443;
        Mon, 03 Aug 2026 08:25:23 -0700 (PDT)
Received: from localhost ([151.251.47.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980878dbaesm407013465e9.12.2026.08.03.08.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 08:25:22 -0700 (PDT)
Date: Mon, 3 Aug 2026 18:25:21 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, ja@ssi.bg, petrm@nvidia.com,
	fw@strlen.de, kuniyu@google.com, bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/5] bridge: Linearize skb once the ND
 message type is validated
Message-ID: <anCy4eCZAbz3Tv4u@penguin>
References: <20260803112505.613873-1-danieller@nvidia.com>
 <20260803112505.613873-5-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803112505.613873-5-danieller@nvidia.com>

On Mon, Aug 03, 2026 at 02:25:04PM +0300, Danielle Ratson wrote:
> br_nd_send() parses ND options from ns->opt[] and therefore needs the skb
> to be linear. Commit a01aee7cafc5 ("bridge: br_nd_send: linearize skb
> before parsing ND options") ensured that by linearizing inside
> br_nd_send() itself.
> 
> Move the linearization up into br_is_nd_neigh_msg(), right after
> ndisc_check_ns_na() has validated the message as an NS/NA. This makes a
> linear buffer a property of every recognized ND message, so that this and
> any future ND message handling operate on a linear skb and cannot
> reintroduce that class of bug by forgetting to linearize.
> 
> Since the skb is now linear by the time br_nd_send() runs, drop the
> linearization there and derive ns from the transport header set by
> ndisc_check_ns_na(), instead of recomputing it from the network header.
> 
> If linearization fails under memory pressure, br_is_nd_neigh_msg() returns
> NULL and the packet falls back to normal forwarding rather than being
> suppressed.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     	* Add a comment noting that br_is_nd_neigh_msg() also linearizes the
>     	  skb.
> 
>  net/bridge/br_arp_nd_proxy.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index 445c930ed59b..6b6de0eff38c 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -235,11 +235,17 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
>  #endif
>  
>  #if IS_ENABLED(CONFIG_IPV6)
> +/* Validate skb as an NS/NA and linearize it for br_nd_send()'s ND
> + * option parsing; returns the nd_msg, or NULL on failure.
> + */
>  struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb)
>  {
>  	if (ndisc_check_ns_na(skb))
>  		return NULL;
>  
> +	if (skb_linearize(skb))
> +		return NULL;
> +
>  	return (struct nd_msg *)skb_transport_header(skb);
>  }
>  
> @@ -259,7 +265,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
>  	bool dad;
>  	u16 pvid;
>  
> -	if (!dev || skb_linearize(request))
> +	if (!dev)
>  		return;
>  
>  	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) +
> @@ -276,8 +282,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
>  	skb_set_mac_header(reply, 0);
>  
>  	daddr = eth_hdr(request)->h_source;
> -	ns = (struct nd_msg *)(skb_network_header(request) +
> -			       sizeof(struct ipv6hdr));
> +	ns = (struct nd_msg *)skb_transport_header(request);
>  
>  	/* Do we need option processing ? */
>  	ns_olen = request->len - (skb_network_offset(request) +
> -- 
> 2.54.0
> 

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
