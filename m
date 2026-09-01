Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EDF35C69C;
	Tue,  1 Sep 2026 02:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788229428; cv=none; b=SJQLI+vy9AcWR+2QeWyd9lnkzuZ8hMZCshmMNU9tB9SeXeFeLmhE/ok1zQRDstKAq2/2mk37ZgpwpFES4b3I3t3u6gUE073HEKVB4VuhEF1uDsj0OLoHWzq3AwNfJXOfOwlJpwnuVJoT1bN1CBUnmR+c8NjhzKUK7Q2wNgrWdo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788229428; c=relaxed/simple;
	bh=jjo/QVN81+mKIPlWprcvxxppUKU0zE6MAdcRt6sNm84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgRklIl3kjf+1yR/eed2NbBBmPm2j+eQDK0GRj0v+XyxAIjtsG6N1Z/BCjmON2U/cUXcJPDYkWzw/5GzUeb0tRthVPpMhkrK/WMfF7Aw05LHTW+JxCmnKPQEvM/rsDNpvsN1W0MMJY+Fmpc3pI1PLiQ/b6idZxpAEa9YwXzWAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JA1J3nNt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JA1J3nNt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28C51F000E9;
	Tue,  1 Sep 2026 02:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788229427;
	bh=ACJMY/83lWO63tg7OoF0hUJEnIuwwL7R39Ev4W5uZoU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JA1J3nNt+qvK1AF+sEPx0KtrlUpsGX3aWQpznJ7mRMe64i77u+6DB8O7Ba7fhvKOr
	 vq1/WpXN6Lm2cZQjJ0aQhEHcJ6vfr7RWyNiDERzzbeIY5tH3roqzMuvWVIT320dDEr
	 FreC4AoCVhtaXb5BrRn/uEvd7SoxoRNzb13DujORRBqpK7pCX7inIcl1FoDokNAfhi
	 D5ZLtcFTrVxQp9sBq70ihTTR/YHdPqmnwD5rDwS5fd82FcbBjIObcLtgjZsbgSsE0A
	 UtNQxz4H3bhR0bqR9e2YeYTNBzFPzUctfurKog7BbmOr0R6QUHNc8vjgbd7Z40DrK6
	 c9CCepHgPawBA==
Message-ID: <7afff157-a5ed-459a-9b40-47123efd71e1@kernel.org>
Date: Mon, 31 Aug 2026 20:23:45 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: dropreason: add
 SKB_DROP_REASON_IP_TTL_EXCEEDED
Content-Language: en-US
To: Junjie Cao <junjie.cao@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260901020613.417495-1-junjie.cao@intel.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260901020613.417495-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/26 8:06 PM, Junjie Cao wrote:
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index 2f312d1f67d6..3046a2699479 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -128,6 +128,7 @@
>  	FN(PSP_INPUT)			\
>  	FN(PSP_OUTPUT)			\
>  	FN(RECURSION_LIMIT)		\
> +	FN(IP_TTL_EXCEEDED)		\
>  	FNe(MAX)
>  
>  /**
> @@ -606,6 +607,11 @@ enum skb_drop_reason {
>  	SKB_DROP_REASON_PSP_OUTPUT,
>  	/** @SKB_DROP_REASON_RECURSION_LIMIT: Dead loop on virtual device. */
>  	SKB_DROP_REASON_RECURSION_LIMIT,
> +	/**
> +	 * @SKB_DROP_REASON_IP_TTL_EXCEEDED: IPv4 TTL or IPv6 hop limit hit
> +	 * zero on a packet being forwarded (see IPSTATS_MIB_INHDRERRORS)
> +	 */
> +	SKB_DROP_REASON_IP_TTL_EXCEEDED,
>  	/**
>  	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>  	 * shouldn't be used as a real 'reason' - only for tracing code gen
> diff --git a/net/ipv4/ip_forward.c b/net/ipv4/ip_forward.c
> index 8b65f12583eb..b242561d37e7 100644
> --- a/net/ipv4/ip_forward.c
> +++ b/net/ipv4/ip_forward.c
> @@ -174,7 +174,7 @@ int ip_forward(struct sk_buff *skb)
>  	/* Tell the sender its packet died... */
>  	__IP_INC_STATS(net, IPSTATS_MIB_INHDRERRORS);
>  	icmp_send(skb, ICMP_TIME_EXCEEDED, ICMP_EXC_TTL, 0);
> -	SKB_DR_SET(reason, IP_INHDR);
> +	SKB_DR_SET(reason, IP_TTL_EXCEEDED);
>  drop:
>  	kfree_skb_reason(skb, reason);
>  	return NET_RX_DROP;

what about icmp_unreach, ip_expire, and other sources of
ICMP_TIME_EXCEEDED? The reason code applies to more than just forwarding
paths.

> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 51941ad656a3..74caaf8746ff 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -464,7 +464,7 @@ static int ipv6_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
>  			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
>  				    ICMPV6_EXC_HOPLIMIT, 0);
> -			kfree_skb(skb);
> +			kfree_skb_reason(skb, SKB_DROP_REASON_IP_TTL_EXCEEDED);
>  			return -1;
>  		}
>  		ipv6_hdr(skb)->hop_limit--;
> @@ -623,7 +623,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
>  			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
>  				    ICMPV6_EXC_HOPLIMIT, 0);
> -			kfree_skb(skb);
> +			kfree_skb_reason(skb, SKB_DROP_REASON_IP_TTL_EXCEEDED);
>  			return -1;
>  		}
>  		ipv6_hdr(skb)->hop_limit--;
> @@ -815,7 +815,7 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
>  			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
>  			icmpv6_send(skb, ICMPV6_TIME_EXCEED, ICMPV6_EXC_HOPLIMIT,
>  				    0);
> -			kfree_skb(skb);
> +			kfree_skb_reason(skb, SKB_DROP_REASON_IP_TTL_EXCEEDED);
>  			return -1;
>  		}
>  		ipv6_hdr(skb)->hop_limit--;
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 8fc4766c8da9..0b6d78c8b6be 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -577,7 +577,7 @@ int ip6_forward(struct sk_buff *skb)
>  		icmpv6_send(skb, ICMPV6_TIME_EXCEED, ICMPV6_EXC_HOPLIMIT, 0);
>  		__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
>  
> -		kfree_skb_reason(skb, SKB_DROP_REASON_IP_INHDR);
> +		kfree_skb_reason(skb, SKB_DROP_REASON_IP_TTL_EXCEEDED);
>  		return -ETIMEDOUT;
>  	}
>  

similarly for IPv6, there are more ICMPV6_TIME_EXCEED cases than just
the forwarding path.

