Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300914;
	b=uLHiosOfb40FJGsHPwGs3hNWp2Jyfsd1G2Inbxv1CalKCVNwR+d1jtAU37U32qMhKmdV
	 RMUYt0AmRKAF/Iyp1WgGCAPWTdaPXr5H19NPfuD3lVxU40NcYSiK/tXAs5iqBQXghWP3d
	 cd93NK3fl8C7Pb3ATH8Ap6OcuvEU0Xa1cNDpDakiHkphI78xpWIBSOcRKekC4YD3EPWqg
	 PauFG2sE5AJWoXNTB7v2mS7l2kx5nyJ/VTJVnawb7dxtCWxPrIb/dNVV+0d0uTMHjbeeS
	 SwBqCsZbu6VmyJdAkw428a5nh+ZHumq0/VEOX569JZu7afoCz0re5YT8ajHGt+q90oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300914;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ltnrl5vOydYNrkG1W6BlZzeak+z3Krfn2QWz7/Z+RyM=;
	b=SysB/q1Dz/w3s+CHawMtomQ/0Bmv5mM4IUS9IOLg6HDWWxywV7MQbl+seZyF9DvwfDdJ
	 35m0+KAFZ2qE0YZrXkid0/eG+BuczexY2O4G36wzHmXKQ8tK2//PBt0Fvrv73M+P1Sirt
	 nZSQlJlS3++cRogUgZom1A+/RVaJ6N2Jl+ORDiPNGxu40YpctQ6vqEABUsDpeXF9N0GCm
	 T8EUVtQBHpij87qXLtzY1ykU4QkhxOFdUmrWiETYpOaV5LjRybG4JHAJ8Y/aqMwoQjMcC
	 k526p4A5L8jhAOzixdD/utmfPx1+RI3DOQApTxI8PUCHr8rjwEUuRsZ3WPIMa2K7ggg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=l6Uzr5y8;
	arc=none smtp.remote-ip=91.218.175.225
Received: from mta0.migadu.com (out-225.mta0.migadu.com [91.218.175.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE46606A336
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FE46606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=l6Uzr5y8
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IPpB6p5683CzzqjuuxRDVIP/NIBp4A9AE4YYcXHpKx0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794300911; v=1; x=1794905711;
 b=l6Uzr5y89+SSC5OSkdujKHwXnI5JCVykoDgXJ0Yx2RaGFro6fFRn9z+4OANLNLrNmzlAyIgz
 /JZ+T3Xowrty7mayD+bQSk0eG6AHLcdTm9UnD0SRUheojhk+2+RJc0Q/7bmr8Vgql9+lKA3d+H4
 eGjDLitbleUeu8TdioIWoSlU=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 3a49c9df13cb8ee4;
	Tue, 10 Nov 2026 08:55:09 +0000
X-Mizu-Trace-ID: 3a49c9df13cb8ee4
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 16:54:50 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gabriel Goller <g.goller@proxmox.com>
Subject: Re: [PATCH net-next v5 2/2] seg6: skip the route refcount in
 seg6local IPv4 lookups
Message-ID: <avLb2q9RfJsxhHHL@fedora>
References: <20261109-seg6-lookup-noref-v5-0-96dc6a652c7e@gmail.com>
 <20261109-seg6-lookup-noref-v5-2-96dc6a652c7e@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-seg6-lookup-noref-v5-2-96dc6a652c7e@gmail.com>

On Mon, Nov 09, 2026 at 09:10:15AM +0900, Yuya Kusakabe wrote:
> ip_route_input() looks the input route up with ip_route_input_noref()
> and then forces a reference on it, which is dropped again when the
> packet is transmitted.  End.DX4 and End.DT4 call it and hand the skb
> to dst_input() within one RCU read-side section: the one of the
> receive path, or that of the nfnetlink verdict handler for a packet
> reinjected from NFQUEUE.
> 
> Use ip_route_input_noref(), as ip_rcv_finish() does.
> 
> Throughput at 0.5% packet loss of 82-byte IPv4-in-IPv6 UDP packets
> (no SRH), spread by RSS on an ixgbe 82599ES across two 10-core Xeon
> E5-2650 v3, offered by TRex over 10 runs of 10 s, in Mpps:
> 
>   End.DX4
>   queues  cores                   before   after
>   1       1                        0.791   0.811  (+2.5%)
>   10      10 on the NIC's socket   6.118   7.394  (+20.9%)
>   16      10 + 6 on two sockets    3.305  10.205  (+208.8%)
> 
>   End.DT4
>   queues  cores                   before   after
>   1       1                        0.481   0.489  (+1.6%)
>   10      10 on the NIC's socket   4.328   4.588  (+6.0%)
>   16      10 + 6 on two sockets    3.351   7.153  (+113.5%)
> 
> Every CPU takes and drops a reference on the same input route, the
> one cached on the nexthop.  At 16 queues that cache line bounces
> between the sockets, and skb_dst_force() and dst_release() together
> take more than half of the cycles for End.DX4 and over 40% for End.DT4.
> 
> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
> ---
>  net/ipv6/seg6_local.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 7fbcf590297d..209e31c21e33 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -1096,7 +1096,7 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
>  
>  	skb_dst_drop(skb);
>  
> -	reason = ip_route_input(skb, nhaddr, iph->saddr, 0, skb->dev);
> +	reason = ip_route_input_noref(skb, nhaddr, iph->saddr, 0, skb->dev);
>  	if (reason) {
>  		kfree_skb_reason(skb, reason);
>  		return -EINVAL;
> @@ -1322,7 +1322,7 @@ static int input_action_end_dt4(struct sk_buff *skb,
>  
>  	iph = ip_hdr(skb);
>  
> -	reason = ip_route_input(skb, iph->daddr, iph->saddr, 0, skb->dev);
> +	reason = ip_route_input_noref(skb, iph->daddr, iph->saddr, 0, skb->dev);
>  	if (unlikely(reason))
>  		goto drop;
>  
> 
> -- 
> 2.50.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
