Received: from mta1.migadu.com (out-146.mta1.migadu.com [95.215.58.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0235836E
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125682; cv=none; b=CeXuQy1Y008fh5eWcugMM4ZH8k1ryyVBpNAi1W9W9z8xDirW8P6RwFkbe0Updfkvuki31F6XrZomNefG1k3eC8Lw/Nzl1uygrvxNFzc2N3PskrtkW5Fiae4wkl4LA4i6LxP2C8zbUs1zKPxNkGp4HhB+DkibPfm/Dl0t4qItC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125682; c=relaxed/simple;
	bh=79dp2Vt0XNSeCQGHZ4+GZSRurcC6S7WX8FTuku0q+Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhnsLekGUjZGLyOZSrkhsXWr4b+Jl+UfdsPHtjX6XmD5fti6X+dtHXQj8i9w4w9ILvgozgXC6P6n+BoqljwYw1B649dCU928CeCBmbeE8Fa6LQuKcCf3YSv9D4ZScnuzUV5fpaKH8IiN6s/LtexvTZvKqN1167yjSOzAToFHkn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FBHLV/P2; arc=none smtp.client-ip=95.215.58.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FBHLV/P2"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=79dp2Vt0XNSeCQGHZ4+GZSRurcC6S7WX8FTuku0q+Tw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787125676; v=1; x=1787730476;
 b=FBHLV/P2UM+qcynAe+ajGVbdfBGL0xzVQOWaXXasCEZQFIA7d2/oMLm6sY1o1q3xr8xEBldL
 373O0ogudkHBGtOrnHkVYwXuh1Wn1MDHIXk08/AiD6xB3Egt3kHY8FnDE0bOm/KyknRHUSUsE3l
 tug0EtK9e6GH83n96p8JGv6g=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (216.236.36.151)
	by smtp.migadu.com with ESMTPS id 2fdf00a199ad8956;
	Wed, 19 Aug 2026 07:47:55 +0000
X-Migadu-Flow: FLOW_OUT
Date: Wed, 19 Aug 2026 15:47:43 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	Zero Day Initiative <zdi-disclosures@trendmicro.com>
Subject: Re: [PATCH net] ip6mr: do not clone dst in ip6mr_cache_report()
Message-ID: <aoVfn7mal17ELzxc@fedora>
References: <20260818172755.4083692-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818172755.4083692-1-edumazet@google.com>

On Tue, Aug 18, 2026 at 05:27:55PM +0000, Eric Dumazet wrote:
> IPv6 input attaches a non-refcounted (NOREF) dst to skbs under RCU.
> When an ingress multicast packet misses MFC lookup,
> ip6mr_cache_unresolved() places the skb onto the unresolved queue,
> escaping the receive-side RCU grace period.
> 
> If the underlying route is deleted and freed, and the MFC queue is later
> resolved with a wrong parent interface, ip6_mr_forward() invokes
> ip6mr_cache_report(..., MRT6MSG_WRONGMIF), which executes
> dst_clone(skb_dst(pkt)) on the freed dst entry, triggering a slab
> use-after-free.
> 
> Report packets queued to mroute6_sk (a raw socket) and netlink
> notifications do not require an attached dst entry.
> 
> Fix this by:
> 1. Removing dst_clone() in ip6mr_cache_report() and ensuring report skbs
>    do not hold a dst.
> 2. Dropping skb_dst before queuing unresolved skbs in
>    ip6mr_cache_unresolved(), matching the fact that multicast
>    forwarding resolves outgoing routes anew via ip6_route_output().
> 
> Fixes: 67f415dd2906 ("ipv6: convert rx data path to not take refcnt on dst")
> Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/ip6mr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index 604a58838901a74712d08505c6bbbdeafd28149c..3f2ed9b77deb51799f34e3826ae271d8d3e2a2dd 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -1162,10 +1162,10 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
>  	msg->im6_src = ipv6_hdr(pkt)->saddr;
>  	msg->im6_dst = ipv6_hdr(pkt)->daddr;
>  
> -	skb_dst_set(skb, dst_clone(skb_dst(pkt)));
>  	skb->ip_summed = CHECKSUM_UNNECESSARY;
>  	}
>  
> +	skb_dst_drop(skb);
>  	mrt6msg_netlink_event(mrt, skb);
>  
>  	/* Deliver to user space multicast routing algorithms */
> @@ -1246,6 +1246,7 @@ static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
>  		skb->skb_iif = dev->ifindex;
>  	}
>  
> +	skb_dst_drop(skb);
>  	skb_queue_tail(&c->_c.mfc_un.unres.unresolved, skb);
>  
>  	spin_unlock_bh(&mfc_unres_lock);
> -- 
> 2.55.0.737.g08866a6d13-goog
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
