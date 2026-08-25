Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BB33EAC80;
	Tue, 25 Aug 2026 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650633; cv=none; b=VCV+NJSj9WQUXjmtUQVJ5JB9XWBAI+0K/4BQsI11z6eNF1XreDRu1q+ZCB56C5uFXh9wL8CJ7+cNuKk3J+Aj9ccEc3edjo8feSBIbhdntwkpZpGnSeOC51Tq4UiVDwfQoN7ZrmoH8X4WXQYuz79/c+6VsaPjsPh2PVrGz0uoLrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650633; c=relaxed/simple;
	bh=v7PXAr7VUie5dePa9q0YtpCj54A46uPXsYcUXxodook=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwJ+uSbsnXL26Kad+uthwEDF3whaya44FhikqoBbQ6nwgyza6NoQkKVFZnhCZ3AbYljkO2QQkws5heiRy3QgecUR3/qx0s1QEBeEQINWzW/UqEPo+uIaWgjHyr7fgeCJy76h0lUynAWDiPLjeaqtvnW6wibZuhxB/HOFUDQq5Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Axj/O3ZY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P36t1Y8N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uXyxlCRm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cHCtVlGM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Axj/O3ZY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P36t1Y8N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uXyxlCRm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cHCtVlGM"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 219541F769;
	Tue, 25 Aug 2026 09:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787650626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5MlkTtjTjqozoq5pZhTXQYGWSAkYJFakhcTjvkjsR8=;
	b=Axj/O3ZYljK7UWGc4rCApM+q0DVWwDgLAAGSjDVVYY39oFDxpGkaNsjvRVZqZoGwoK5zgd
	Lm6bwSY02vO/jYDp02mrYaPIV3nK3CnXO28pdcWixjkMPY9GCNjSCTGn6OS+lQNS/xV3D8
	m4BYbh6aimQk1+D9fQHcBdjT+NZh1do=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787650626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5MlkTtjTjqozoq5pZhTXQYGWSAkYJFakhcTjvkjsR8=;
	b=P36t1Y8NwWinzido9oRqHaY/DfrPIPo6qvDSaELjSuDjasW/7rRivnzWvP2Wr1iSA/0rU8
	ci3VP4NWm47qlqDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787650622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5MlkTtjTjqozoq5pZhTXQYGWSAkYJFakhcTjvkjsR8=;
	b=uXyxlCRmIgts+yTci8+6claRUMOc/ICtO3505We0uqAe/RcUpziJDZgFBWvhp5zSfydOBi
	iji/HqKQeTZBqIkXdW0h0IdMTjrRC3STFUHRqN2qwvRJlM8+TMgcsXca7YL2WUXKOA938Y
	WvgJZ8vKGFlros55dmXnu9iObB21xCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787650622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5MlkTtjTjqozoq5pZhTXQYGWSAkYJFakhcTjvkjsR8=;
	b=cHCtVlGMIJySRakhGT927nwc4c+SEeQTpfwZuF71i7H6FoZ6ZJnrHdKCPvLg5v97k6n9Id
	dYri2HYYEJ7pG8CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 920ED13331;
	Tue, 25 Aug 2026 09:37:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UXvcID1ijWoVUgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 25 Aug 2026 09:37:01 +0000
Message-ID: <9abd7020-90b3-45e3-84ef-ca31b760feaf@suse.de>
Date: Tue, 25 Aug 2026 11:36:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dropreason: add
 SKB_DROP_REASON_IP_TTL_EXCEEDED
To: Junjie Cao <junjie.cao@intel.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 linux-kernel@vger.kernel.org
References: <20260825073906.336072-1-junjie.cao@intel.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260825073906.336072-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,intel.com:email,imap1.dmz-prg2.suse.org:helo]

On 8/25/26 9:39 AM, Junjie Cao wrote:
> The forwarding paths report an expired TTL or hop limit as
> SKB_DROP_REASON_IP_INHDR, the reason otherwise used for a header that is
> malformed (ip_input.c, exthdrs.c, br_netfilter). Nothing else in the drop
> path separates the two: IPSTATS_MIB_INHDRERRORS covers both, and the TTL
> check runs before NF_INET_FORWARD, so netfilter tracing stops at
> PREROUTING and never sees the drop.
> 
> The Fedora bug linked below shows how that reads in practice. The
> reporter took kfree_skb(reason=IP_INHDR, loc=ip_forward) to mean the
> software header checksum check had failed, and worked through RX checksum
> offload, tc csum actions and both libvirt firewall backends before the
> drops turned out to be replies arriving with TTL 1. ip_forward() never
> verifies the header checksum; that runs earlier, in ip_rcv_core(), and
> reports IP_CSUM.
> 
> TTL expiry is not a corner case -- every traceroute through a Linux
> router goes through too_many_hops.
> 
> The three loopback hop limit checks in exthdrs.c drop with no reason at
> all; give them the new one.
> 
> IPSTATS_MIB_INHDRERRORS stays as it is: RFC 1213 counts time-to-live
> exceeded under ipInHdrErrors. The drop reason has no such constraint.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2517131
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>

The patch is sound but isn't this drop reason a bit redundant? I mean, a 
simple check on traffic should have shown to the user that TTL is been 
exceeded.

In any case, net-next is currently closed [1]. Please send this after it 
re-opens.

[1] 
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#git-trees-and-patch-flow

Thanks,
Fernando.

> ---
>   include/net/dropreason-core.h | 6 ++++++
>   net/ipv4/ip_forward.c         | 2 +-
>   net/ipv6/exthdrs.c            | 6 +++---
>   net/ipv6/ip6_output.c         | 2 +-
>   4 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index 2f312d1f67d6..3046a2699479 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -128,6 +128,7 @@
>   	FN(PSP_INPUT)			\
>   	FN(PSP_OUTPUT)			\
>   	FN(RECURSION_LIMIT)		\
> +	FN(IP_TTL_EXCEEDED)		\
>   	FNe(MAX)
>   
>   /**
> @@ -606,6 +607,11 @@ enum skb_drop_reason {
>   	SKB_DROP_REASON_PSP_OUTPUT,
>   	/** @SKB_DROP_REASON_RECURSION_LIMIT: Dead loop on virtual device. */
>   	SKB_DROP_REASON_RECURSION_LIMIT,
> +	/**
> +	 * @SKB_DROP_REASON_IP_TTL_EXCEEDED: IPv4 TTL or IPv6 hop limit hit
> +	 * zero on a packet being forwarded (see IPSTATS_MIB_INHDRERRORS)
> +	 */
> +	SKB_DROP_REASON_IP_TTL_EXCEEDED,
>   	/**
>   	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>   	 * shouldn't be used as a real 'reason' - only for tracing code gen
> diff --git a/net/ipv4/ip_forward.c b/net/ipv4/ip_forward.c
> index 8b65f12583eb..b242561d37e7 100644
> --- a/net/ipv4/ip_forward.c
> +++ b/net/ipv4/ip_forward.c
> @@ -174,7 +174,7 @@ int ip_forward(struct sk_buff *skb)
>   	/* Tell the sender its packet died... */
>   	__IP_INC_STATS(net, IPSTATS_MIB_INHDRERRORS);
>   	icmp_send(skb, ICMP_TIME_EXCEEDED, ICMP_EXC_TTL, 0);
> -	SKB_DR_SET(reason, IP_INHDR);
> +	SKB_DR_SET(reason, IP_TTL_EXCEEDED);
>   drop:
>   	kfree_skb_reason(skb, reason);
>   	return NET_RX_DROP;
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 9c677eb1d1a6..b9103b02e8c7 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -471,7 +471,7 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
>   			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
>   			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
>   				    ICMPV6_EXC_HOPLIMIT, 0);
> -			kfree_skb(skb);
> +			kfree_skb_reason(skb, SKB_DROP_REASON_IP_TTL_EXCEEDED);
>   			return -1;
>   		}
>   		ipv6_hdr(skb)->hop_limit--;
> @@ -633,7 +633,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>   			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
>   			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
>   				    ICMPV6_EXC_HOPLIMIT, 0);
> -			kfree_skb(skb);
> +			kfree_skb_reason(skb, SKB_DROP_REASON_IP_TTL_EXCEEDED);
>   			return -1;
>   		}
>   		ipv6_hdr(skb)->hop_limit--;
> @@ -821,7 +821,7 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
>   			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
>   			icmpv6_send(skb, ICMPV6_TIME_EXCEED, ICMPV6_EXC_HOPLIMIT,
>   				    0);
> -			kfree_skb(skb);
> +			kfree_skb_reason(skb, SKB_DROP_REASON_IP_TTL_EXCEEDED);
>   			return -1;
>   		}
>   		ipv6_hdr(skb)->hop_limit--;
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 8fc4766c8da9..0b6d78c8b6be 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -577,7 +577,7 @@ int ip6_forward(struct sk_buff *skb)
>   		icmpv6_send(skb, ICMPV6_TIME_EXCEED, ICMPV6_EXC_HOPLIMIT, 0);
>   		__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
>   
> -		kfree_skb_reason(skb, SKB_DROP_REASON_IP_INHDR);
> +		kfree_skb_reason(skb, SKB_DROP_REASON_IP_TTL_EXCEEDED);
>   		return -ETIMEDOUT;
>   	}
>   

