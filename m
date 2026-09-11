Received: from mta0.migadu.com (out-230.mta0.migadu.com [91.218.175.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1775730649C
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 02:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095003; cv=none; b=dTBAWaO91nA/iXVufxTdX2dK83fVbadCkIOOk3v6rjoI7mCgEQ9ocZ0SrnXTeaDsnqoFwmmZyY5I7QBuUbqFH+FMlXJyYYHf5+DruoGF9DElkBq4Pv0Tk/FJnKGgdY9aUgRRLvVsoaeMrG1Wrh7MdSyVLqIQ6dlwcrK6vicDtUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095003; c=relaxed/simple;
	bh=QlW8xaRR8XMQQMLMmhsm7NOZLYvVZWtLyYURA0wt09M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmS0vAJk+eOOzulbMeOh80FuBtlzm7YM2LCJtWgltntqxSGkRVuy3Gy3P9zFgLyNskvBMXP46GuBlrt0pzJd329hy7SLkYQ0JdtjsAHSlsteTITClSmKbdwgc9Y1VkswpB1ijP6SLTnNbLxXtiXduahdI7G9yAu1q5JH6hAt7lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PwLje7at; arc=none smtp.client-ip=91.218.175.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PwLje7at"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QlW8xaRR8XMQQMLMmhsm7NOZLYvVZWtLyYURA0wt09M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789095000; v=1; x=1789699800;
 b=PwLje7at27yZN644KK3d7xSS5eznLqiMTeGr6D+gic+Lr77Ybgu08lZlN4q6XjxHhKwICfhf
 9ZGG+pG4GZGQ+4ldYAD4/7kaQAq/PsqlvM6dMX0qNeECUn5cTYke5B4jVlqG8By9y724S+NrWmm
 +bzpnygPPEQhZ5fBQz0ykTdc=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id f48e2a564b1decce;
	Fri, 11 Sep 2026 02:49:59 +0000
X-Mizu-Trace-ID: f48e2a564b1decce
X-Migadu-Flow: FLOW_OUT
Date: Fri, 11 Sep 2026 10:49:42 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Junjie Cao <junjie.cao@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] net: dropreason: add
 SKB_DROP_REASON_IP_TTL_EXCEEDED
Message-ID: <aqNsRizP27HvHcGB@fedora>
References: <20260910094937.536150-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910094937.536150-1-junjie.cao@intel.com>

On Thu, Sep 10, 2026 at 05:49:37PM +0800, Junjie Cao wrote:
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
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v5: move the entry next to the other IP_* reasons, after IP_INVALID_DEST
>     (Jakub Kicinski)
>     IPVS decrement_ttl() is a follow-up: its xmit callers free at tx_error
>     with plain kfree_skb(), so the reason has to come back out of
>     __ip_vs_get_out_rt() (David Ahern, Hangbin Liu)
> v4: https://lore.kernel.org/netdev/20260907030133.482834-1-junjie.cao@intel.com/
> v3: https://lore.kernel.org/netdev/20260904030112.450920-1-junjie.cao@intel.com/
> v2: https://lore.kernel.org/netdev/20260901020613.417495-1-junjie.cao@intel.com/
> v1: https://lore.kernel.org/netdev/20260825073906.336072-1-junjie.cao@intel.com/
>  include/net/dropreason-core.h | 6 ++++++
>  net/ipv4/ip_forward.c         | 2 +-
>  net/ipv6/exthdrs.c            | 6 +++---
>  net/ipv6/ip6_output.c         | 2 +-
>  4 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index 2f312d1f67d6..12f909651591 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -93,6 +93,7 @@
>  	FN(IP_INVALID_SOURCE)		\
>  	FN(IP_LOCALNET)			\
>  	FN(IP_INVALID_DEST)		\
> +	FN(IP_TTL_EXCEEDED)		\
>  	FN(PKT_TOO_BIG)			\
>  	FN(DUP_FRAG)			\
>  	FN(FRAG_REASM_TIMEOUT)		\
> @@ -474,6 +475,11 @@ enum skb_drop_reason {
>  	 * 1) dest ip is 0
>  	 */
>  	SKB_DROP_REASON_IP_INVALID_DEST,
> +	/**
> +	 * @SKB_DROP_REASON_IP_TTL_EXCEEDED: IPv4 TTL or IPv6 hop limit <= 1
> +	 * (see IPSTATS_MIB_INHDRERRORS)
> +	 */
> +	SKB_DROP_REASON_IP_TTL_EXCEEDED,
>  	/**
>  	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
>  	 * MTU)
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
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 09a4552f7f08..55391e2e5612 100644
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
> index 96ee3de55f93..ddaba0aebcb1 100644
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
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
