Received: from mta0.migadu.com (out-236.mta0.migadu.com [91.218.175.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629C63BB66B
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775098; cv=none; b=hMRfleRdNy+x6Gogi1xvblL8SCuTe3Bt18VLsQdwFv17xZBxOwB8UvdoXA1VCMGBDqqrBhQonLghbvgvohF48HcvwH/yE8a9tWNEsvjD2Kehs3GesBMifItIMVGJv747z2zLQQMGv8ONWGJfOrz+Z3WezcLHwf12Ga6L9v55Oes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775098; c=relaxed/simple;
	bh=29hVNzV5VatCE2BbvQyw9Qb42LUeW/8dYMtj6fXymzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkCsm5vhheDl4HGu6KXlFbisEt9tkMkkOMvSArLJsiFzNlEKaM6pzjALKG9cIX0gE7adSo/OUdl3FaFo37kxEOxNTJyJeiDEdxndM433Ar7opizu8JOkEToK+DdnHdTsZFWjbgkM4DZ79IrGvWbqbyGqVKZdOC8KEX6OdmlC6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wnLbLIRn; arc=none smtp.client-ip=91.218.175.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wnLbLIRn"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=29hVNzV5VatCE2BbvQyw9Qb42LUeW/8dYMtj6fXymzI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788775093; v=1; x=1789379893;
 b=wnLbLIRn+MJdmPInpmR3/TLVFVsK3xU/iNJ8ncK/r69+lgYi0wdnr6Nj59Snpcc7ycINLBkN
 Q5HvQ7ZV2S6qPAoWxLwbV9Ieh6aaS73QAtq59+LuAggoNXvwkmfeS4aeu9ZfhjIlf9/aXDE/RE2
 2rqCmvKNKXz2IbcqGFAv0oZk=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 052701c0d7406b80;
	Mon, 07 Sep 2026 09:58:13 +0000
X-Mizu-Trace-ID: 052701c0d7406b80
X-Migadu-Flow: FLOW_OUT
Date: Mon, 7 Sep 2026 17:58:01 +0800
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
Subject: Re: [PATCH net-next v4] net: dropreason: add
 SKB_DROP_REASON_IP_TTL_EXCEEDED
Message-ID: <ap6KqSk5O1tVLh9N@fedora>
References: <20260907030133.482834-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907030133.482834-1-junjie.cao@intel.com>

Hi Junjie,
On Mon, Sep 07, 2026 at 11:01:33AM +0800, Junjie Cao wrote:
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
> v4: kernel-doc says "<= 1" instead of "hit zero" (Jiayuan Chen)
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
> index 2f312d1f67d6..3d6aec203c3f 100644
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
> +	 * @SKB_DROP_REASON_IP_TTL_EXCEEDED: IPv4 TTL or IPv6 hop limit <= 1
> +	 * (see IPSTATS_MIB_INHDRERRORS)
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

I saw

ip_vs_forward_icmp()
  - ip_vs_in_icmp_v6
      - ip_vs_icmp_xmit_v6()
        - __ip_vs_get_out_rt_v6()
          - decrement_ttl()

Also sends ICMP_EXC_TTL/ICMPV6_EXC_HOPLIMIT messages, But not changed
in this patch. Should we also update them? Or there is no plan to
change the ipvs code yet?

Thanks
Hangbin
