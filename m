Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672122;
	b=mPGDOT2UQp0frwiNa010VxO39bJsGRtvdngq3JuKpl5PWbLHkFKQ+Ln1uBqokgCYY3k+
	 Px6WIpEJZQolILm3ssVBJlismZ6hfr9ezSsdZjqiLxQBwhgwEF65w0JkNv8QvVYgnuDkX
	 EWZwjJxrwkXBsjTWoX4hN6HFFRpmGThlfv5pY0h5mOrDXGZiAoyztI3en2DalcVkiJls7
	 nUuJuLZ829ttJoxS3KLk853isvRnRd0uMhfxIOYUaZQmrUyh7n3G1YHJzSwGJPL42xHdX
	 PcFgCybXwov1BS0pRy4ropEtdN+m0VKpVyAG+5bkN6BZ4YuUy6VRrAwxkR3hFH3h51Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672122;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=swMBrZuLYQl7RYBGcyFALBP5NnR05K4Y76My6FBJtU0=;
	b=HBUFbTa2q0OnwpfxCIPgK6QQo2vHnTUMITeLo0ZXdTV4p1/QZ6DxxbV+CaEtIr//tIzR
	 YebpQhmtbcj07F31/Wr+2t2jO25OdZ38lv3YAQfZi4vh3pb0V98xAqINgtwKFXPfOPz2d
	 n+UMuZf2aOABn5gHdew5f1Fph0NctzBAtg+5NscqBuyo/hTaCd+zLX3h3gO7+Cr2y6Ax5
	 MqqOvo9UZObJpaZLU3+i9ZTtUcfpKw/cKPxp3h31f3nxBQqUEZ9Ot9MieB83U5sV0CcF2
	 EOEVMfnbT1wpJQfk87EH51d15Bxv00qr7HZYANsRCZ/mneppluLdj5oU/xoQuc/lhrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lX4qJf0e;
	arc=none smtp.remote-ip=91.218.175.75
Received: from mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43617606A331
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43617606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lX4qJf0e
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Z4q8r55MMjPLd9lBbgy0/F1GPB2LJsVrIvS8JZYXVIM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793672119; v=1; x=1794276919;
 b=lX4qJf0evWkWo2H1GzdHljzs7DptE1ZYrRbf8XisV/6XjG1cxnHYRhmmVUWcCY8tKdmyuoP2
 C/LAmXc7JadQV4BZR++4X9gTsqc8mVhmW9xcw7rlz8NHNS85TPF1wyRIM1FfbDU8M0Hgj+oor4L
 ZfC4OZaZ+0qyvGEzfhUwqhWY=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 635985c26460c19e;
	Tue, 03 Nov 2026 02:15:16 +0000
X-Mizu-Trace-ID: 635985c26460c19e
X-Migadu-Flow: FLOW_OUT
Date: Tue, 3 Nov 2026 10:15:03 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	David Lebrun <david.lebrun@uclouvain.be>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Mathieu Xhonneux <m.xhonneux@gmail.com>,
	David Lebrun <dlebrun@google.com>,
	Stefano Salsano <stefano.salsano@uniroma2.it>,
	Andrea Mayer <andrea@common-net.org>
Subject: Re: [PATCH net 3/6] seg6: update skb checksum when SRv6 behaviors
 advance to the next SID
Message-ID: <aulA09qBNtIxJq7S@fedora>
References: <20261031225033.64-1-andrea.mayer@uniroma2.it>
 <20261031225033.64-4-andrea.mayer@uniroma2.it>
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
In-Reply-To: <20261031225033.64-4-andrea.mayer@uniroma2.it>

Hi Andrea,
On Sat, Oct 31, 2026 at 11:50:30PM +0100, Andrea Mayer wrote:
> advance_nextseg() decrements Segments Left and writes the next segment into
> the destination address, and seg6_next_csid_advance_arg() advances the
> NEXT-C-SID argument in the destination address.
> With CHECKSUM_COMPLETE, neither updates skb->csum for these changes. The
> stale skb->csum is read when the packet is delivered on the same node, e.g.
> through End.B6.Encaps towards a local End.DT6 SID.
> As a consequence, when skb->csum is computed in software, for instance by
> conntrack, UDP can drop the packet as a checksum error. With skb->csum
> computed by the device, TCP can instead log a "hw csum failure", as if the
> device had computed a wrong skb->csum.
> 
> Update skb->csum in both functions with update_csum_diff16() for the
> destination address. advance_nextseg() also uses update_csum_diff4() for
> Segments Left.
> 
> Depends on patch "seg6: fix skb checksum update helpers".
> 
> Found by manual code inspection while working on
> commit 8ae3f4067ba4 ("seg6: ensure packet data is writable before modifying
> SRH and IPv6 DA"), and reproduced in a VM without kernel changes or error
> injection. A following commit adds a selftest that reproduces the problem
> with a tc ct action. With this patch, the selftest passes for the
> End.B6.Encaps and next-csid paths. Also tested against the srv6 selftests,
> and with a ConnectX-6 Lx NIC (mlx5) that provides CHECKSUM_COMPLETE.
> 
> Fixes: 140f04c33bbc ("ipv6: sr: implement several seg6local actions")
> Fixes: 848f3c0d4769 ("seg6: add NEXT-C-SID support for SRv6 End behavior")
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  net/ipv6/seg6_local.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 0c3d1be7f129..57a82477ce3f 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -291,7 +291,9 @@ static struct ipv6_sr_hdr *advance_nextseg(struct sk_buff *skb,
>  					   struct ipv6_sr_hdr *srh,
>  					   enum skb_drop_reason *reason)
>  {
> +	struct in6_addr *daddr;
>  	struct in6_addr *addr;
> +	__be32 old;
>  	int srhoff;
>  	int wlen;
>  
> @@ -309,10 +311,19 @@ static struct ipv6_sr_hdr *advance_nextseg(struct sk_buff *skb,
>  
>  	/* skb_ensure_writable() may change skb pointers; evaluate srh again */
>  	srh = (struct ipv6_sr_hdr *)(skb->data + srhoff);
> +	daddr = &ipv6_hdr(skb)->daddr;
> +	/* nexthdr, hdrlen, type and segments_left */
> +	old = *(__be32 *)srh;
>  
>  	srh->segments_left--;
>  	addr = srh->segments + srh->segments_left;
> -	ipv6_hdr(skb)->daddr = *addr;
> +
> +	if (skb->ip_summed == CHECKSUM_COMPLETE) {
> +		update_csum_diff4(skb, old, *(__be32 *)srh);
> +		update_csum_diff16(skb, (__be32 *)daddr, (__be32 *)addr);
> +	}
> +
> +	*daddr = *addr;

Nit: we can re-use seg6_update_csum() if the transport header set correctly.
But that function is static and we need adjust header files.
So the current change looks good for me.

>  
>  	return srh;
>  }
> @@ -427,11 +438,13 @@ seg6_next_csid_advance_arg(struct sk_buff *skb,
>  	__u8 fnc_octects = seg6_flv_lcnode_func_octects(finfo);
>  	__u8 blk_octects = seg6_flv_lcblock_octects(finfo);
>  	struct in6_addr *addr;
> +	struct in6_addr old;
>  
>  	if (unlikely(skb_ensure_writable(skb, sizeof(struct ipv6hdr))))
>  		return SKB_DROP_REASON_NOMEM;
>  
>  	addr = &ipv6_hdr(skb)->daddr;
> +	old = *addr;
>  
>  	/* advance DA.Argument */
>  	memmove(&addr->s6_addr[blk_octects],
> @@ -440,6 +453,9 @@ seg6_next_csid_advance_arg(struct sk_buff *skb,
>  
>  	memset(&addr->s6_addr[16 - fnc_octects], 0x00, fnc_octects);
>  
> +	if (skb->ip_summed == CHECKSUM_COMPLETE)
> +		update_csum_diff16(skb, (__be32 *)&old, (__be32 *)addr);
> +
>  	return SKB_NOT_DROPPED_YET;
>  }
>  
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
