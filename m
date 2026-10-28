Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198150;
	b=UWWdfSVlSUmY5+/QmOdedRxF/rXv+gqmSada7SRzUlUbqcSs74rpTpxBiNxdYRBNxwDo
	 03azLF4DxVlWTygNXfZLav4qLkUsrcwMNy1M+b0lGdGB58HO8reybkZHSlAMIKmitJBwC
	 Nr9ixZ1WWMYMI2A2toLX3G+y/na28dg8Fzf3G9ul5vGOGohak9YFMLSvDfeG6LzlGLhLa
	 RDF0QI2T2nv4lG1X2BQRSgOzwo/2iyUq9xHyv6Aq1XU4vXQRpD6LMgUX3DThVdNcghZiE
	 ByPNsa9/OFDxYoTHdJiDWe8qZYS+VU8jwD5pfu2lVvddVtwOMevAN/5EJCXosSqHS+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198150;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=sTv72HXLS642hKtRKZu2ty/aYX7p7GlGK+o3A+/U4nU=;
	b=eeDkbPdftrlTOPT1a6t+pm8g3vQtMGGL0BiCFvLd8wCmznA6WMUAnOvK/amtQeeUNToT
	 MjDfvsvg9PuCaL8JgLAMV8+NT8g1tdihfLA1sAzuIWeZOR2JEUGsHmNIuFIx0hnjo2dcK
	 alU7KHsUEAYlSQ0p5PIGsdS2avb+70wmso6Sp7exNfA8LDpuoCGzxr2MW4gx4Ua12UAjW
	 VlgRnG1dZHdMXtOW1guzx+lpt6B65yuhpIFBONpXW5eFj3VTX/QlSuILdt2HK/lNHsYMy
	 lGSAeaTZCQkENZbp09hYGO9EMvGYoubzrKGtsk1jlFtdbPV18T89A3WB5nn/6Og2Hfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qs6OO7h2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3106A606A32D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qs6OO7h2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE80A1F01829;
	Wed, 28 Oct 2026 14:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793198150;
	bh=sTv72HXLS642hKtRKZu2ty/aYX7p7GlGK+o3A+/U4nU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Qs6OO7h2KpnuMZniQ3yYLQSDSUI74XKlKqCQm8mCF5K1mYmnyr/jHuNW/GSuIMdmo
	 sulhdIvrz5xZanU496QWJWXh2KWYp78oPrDA9GxjCbBmvDor1+/bXiUP3+DhlaR4aj
	 YDBAN7zlhD8PkjDeU75dBKZkAYiSPhiejMEZE5S60Beg21IiYIzZOCi7zVJEtBjOXR
	 bQbCajAziWl/rtKZsRpBEekCmCu0lK4WTvZOr7yLlQXOebB0/GyYoA/rEGxNCksvfR
	 Ojg3WzIv488v27LYs1AITaMCFbeZPmPe5MRA0nCJlSQ8oAyWINKlk6OvrStxV6HMvx
	 mWJzyBfmJraxQ==
Message-ID: <a3e50c6f-0da2-4e77-80b5-2ae371676280@kernel.org>
Date: Wed, 28 Oct 2026 08:35:48 -0600
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: vrf: Set L3MDEV OIF flag for outbound lookups
Content-Language: en-US
To: Gabriel Goller <g.goller@proxmox.com>, Haon KIM <akrn112@naver.com>,
 Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
References: <20261026164702.1415-1-akrn112@naver.com>
 <auH8PdGEPaf2GI73@luna.proxmox.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <auH8PdGEPaf2GI73@luna.proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[ cc author of referenced Fixes commit ]

On 10/28/26 7:57 AM, Gabriel Goller wrote:
> On 27.10.2026 01:47, Haon KIM wrote:
>> The IPv4 and IPv6 outbound processing paths in the VRF driver
>> set the L3 master device index in the flow structure before
>> performing route lookups, but do not set
>> FLOWI_FLAG_L3MDEV_OIF.
>>
>> Both the IPv4 and IPv6 outbound processing paths contain
>> the comment "needed to match OIF rule", indicating that
>> the L3 master device index is needed to match OIF rules.
>> However, FIB rule matching requires both
>> FLOWI_FLAG_L3MDEV_OIF and a matching flowi_l3mdev index
>> to match a rule specifying the VRF master as the output
>> interface.
>>
>> The matching logic introduced by commit 2d300ce0b783
>> ("net: fib_rules: Fix iif / oif matching on L3 master device")
>> requires FLOWI_FLAG_L3MDEV_OIF to be set for OIF rules to
>> match the VRF master. The existing outbound processing paths
>> set the L3 master device index directly, so
>> l3mdev_update_flow() does not set this flag.
>>
>> Consequently, OIF rules specifying the VRF master may fail
>> to match these flows.
>>
>> Set FLOWI_FLAG_L3MDEV_OIF in both outbound processing paths
>> so that FIB rules can correctly match the VRF master as the
>> output interface.
>>
>> The issue was identified by code inspection. Runtime testing
>> has not been performed.

Please do not do that; do some testing before sending patches.

>>
>> Fixes: 2d300ce0b783 ("net: fib_rules: Fix iif / oif matching on L3 master device")
> 
> I think this should be:
> 
> Fixes: 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset for port devices")

No, the Fixes above is correct if there is a bug; the
FLOWI_FLAG_L3MDEV_OIF flag was introduced by 2d300ce0b783 and was not
present for 40867d74c374.

That said, unless I am misremembering something the flag does not need
to be set in this outbound path.

> 
>> Signed-off-by: Haon KIM <akrn112@naver.com>
>> ---
>>  drivers/net/vrf.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
>> index 79d433f49f80..f22ac91fefd4 100644
>> --- a/drivers/net/vrf.c
>> +++ b/drivers/net/vrf.c
>> @@ -432,6 +432,7 @@ static netdev_tx_t vrf_process_v6_outbound(struct sk_buff *skb,
>>  	fl6.flowlabel = ip6_flowinfo(iph);
>>  	fl6.flowi6_mark = skb->mark;
>>  	fl6.flowi6_proto = iph->nexthdr;
>> +	fl6.flowi6_flags = FLOWI_FLAG_L3MDEV_OIF;
>>  
>>  	dst = ip6_dst_lookup_flow(net, NULL, &fl6, NULL);
>>  	if (IS_ERR(dst) || dst == dst_null)
>> @@ -506,7 +507,7 @@ static netdev_tx_t vrf_process_v4_outbound(struct sk_buff *skb,
>>  	fl4.flowi4_l3mdev = vrf_dev->ifindex;
>>  	fl4.flowi4_iif = LOOPBACK_IFINDEX;
>>  	fl4.flowi4_dscp = ip4h_dscp(ip4h);
>> -	fl4.flowi4_flags = FLOWI_FLAG_ANYSRC;
>> +	fl4.flowi4_flags = FLOWI_FLAG_ANYSRC | FLOWI_FLAG_L3MDEV_OIF;
>>  	fl4.flowi4_proto = ip4h->protocol;
>>  	fl4.daddr = ip4h->daddr;
>>  	fl4.saddr = ip4h->saddr;
> 
> Also this is a breaking change, before the patch, this rule matched:
> 
>    ip rule add iif vrf0 table 100
> 
> After the patch, this one matches (and the iif rule above no longer does):
> 
>    ip rule add oif vrf0 table 100
> 
> A selftest would also be nice.

See commit message in cited Fixes commit. Have you checked
fib_rule_tests.sh? If not, try the commands in 2d300ce0b783 and if they
are broken, there is a problem. If not, let's get them added to the
selftest.

