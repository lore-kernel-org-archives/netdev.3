Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D85C44CF29
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784761582; cv=none; b=EPiGzmSugdI5JyQq36XDF5DS3Zo0Nv84ust5Y6GRvqe0nberODG4IDH3eJVa6L6EZq5tbmLcUjDAP0uRnO3A8Fz+hhCUo12MaKlmBVQvUP6vb5gYcu0c1ebU4qPoaZgclOyljzbwJ4uD3/oz6+Dvgu5NHObT+zu0H3c0/75ab2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784761582; c=relaxed/simple;
	bh=9pyLXOsPYXEcv1QhaQxpIbjdnyUO75BxF3753KmLNts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKOiihTUL7X6mV6xDPH9v9sh091ytPBExDCeGrx2cKEF49gwa7oNOS00mWSRPWG2Ax/zcVeYhzE1usldaH41R+R3qovxOAgkakglOds/DHlCw8Yi+QtdJrg5oQst9Tz1DlETzTSmU+AxU4xhlJU7aEsfIU9J7FWwdQj/Ll71QC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+qoSGMS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+qoSGMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99621F000E9;
	Wed, 22 Jul 2026 23:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784761581;
	bh=aDj59SHi8aglviZ18zmbBTcexGYq0SnhJZApE2QFOMs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l+qoSGMSPAI0H0q9kscxxe2v5gQ3YEx3u9zSgFdQ7PKCpwiICf2F+7d1JhpiIwtDb
	 r5F2YMgdtbbdwklxsTDclBKcKlxi/h/QVw79ielELkvhiCW5h9jR5lBfWT1ZwPGCtK
	 I6XrX18LdJBQFI527ukOXUXAW6rqaSnj0r/yHIG1usvA/SiwvT6pBkgl6xKHAC8qYZ
	 l0OEI87kGkm8NokIW/2klBEjWMZVpW5ZAAzP3Jnxk9uEYUuv53ILDDVKCw0z8l6kKb
	 FvZkslLDrqrXVoHerU+51AazAgD/wrDH5bvaDDQxKG9eDaJFMRF5erbrVd3sCcVLCH
	 2Q3WJJ4b0bt1A==
Message-ID: <d61be2b8-a313-4957-9927-ec8c63221f59@kernel.org>
Date: Wed, 22 Jul 2026 17:06:19 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] ipv4: icmp: fill flow parameters in
 icmp_route_lookup decoy lookup
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Muhammad Ziad <muhzi100@gmail.com>
References: <20260722104236.2938082-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260722104236.2938082-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 4:42 AM, Eric Dumazet wrote:
> When Linux forwards a packet and needs to generate an ICMP error,
> icmp_route_lookup() performs a reverse-path relookup. For non-local
> destinations, it performs a decoy lookup to find the expected egress
> interface (rt2->dst.dev) before validating the path with ip_route_input().
> 
> Currently, the decoy flow structure (fl4_2) only sets .daddr = fl4_dec.saddr,
> leaving .saddr, .flowi4_dscp, .flowi4_proto, .flowi4_mark, .flowi4_oif,
> .fl4_sport, .fl4_dport, and .flowi4_uid zeroed out.
> 
> When policy routing rules (such as ip rule add from $SRC lookup 100, or
> dscp/fwmark/ipproto/port rules, or VRF bindings) are configured:
> 1. The decoy lookup fails to match the policy rule because saddr and other
>    key flow selectors are missing in fl4_2.
> 2. It resolves a route using the default table instead, returning an incorrect
>    egress netdev.
> 3. Passing the wrong netdev to ip_route_input() causes strict reverse-path
>    filtering (rp_filter=1) to fail, logging false-positive "martian source"
>    warnings and causing the relookup to fail.
> 
> Fix this by initializing fl4_2 from fl4_dec and:
> - Swapping source/destination IP addresses.
> - Swapping L4 ports for transport protocols with ports (TCP, UDP, SCTP, DCCP)
>   so port-based policy routing matches correctly. Non-port protocols (such as
>   ICMP or GRE) leave the flowi_uli union fields intact to prevent corruption.
> - Setting .flowi4_oif = l3mdev_master_ifindex(route_lookup_dev) to ensure
>   VRF routing tables are respected.
> - Setting .flowi4_flags |= FLOWI_FLAG_ANYSRC to allow output route lookups
>   for non-local source IP addresses.
> - Using __ip_route_output_key() instead of ip_route_output_key() for fl4_2
>   so that raw FIB routing is used without triggering spurious XFRM policy
>   lookups on the decoy flow (the actual XFRM lookup is performed later using
>   fl4_dec).
> 
> Fixes: 415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.")
> Reported-by: Muhammad Ziad <muhzi100@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAOAwikA60AYKdFr_UDLyja3oU4hqyAE7uFZWqum5uRdaQsgRYg@mail.gmail.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> v2: addressed Sashiko and Jakub feedback
> v1: https://lore.kernel.org/netdev/20260716021049.2124921-1-edumazet@google.com/
> 
>  net/ipv4/icmp.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


