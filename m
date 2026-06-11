Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB331B87C0
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202508; cv=none; b=ocZR9YUhYIEpcCNctc2nfMlPlJDaUXev1U4eM5H21QH1VZMV23MZ7SOt25oppNycAr13EwE5fx0vVmxrkYMJmddbyBSdkPoPWvi44WtWBZ55WBhSQCTQYcYUQknTCZPGJ4Z1PghLmt5PoBKDHOFjtCGqe/eXhn0yut8nEbKjj88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202508; c=relaxed/simple;
	bh=A3bv+PUyFNwYGfIaeo+qbQPPW1FKFonusD8x1AaEBYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHGxvtusTPL+7ryuGmt9++gbNjVHs1Jq/ksdx1kJvITaq+OO0QgAhMpdFb4yCxU5fM63N/8fq3nMYRl0Qd6hmCxS29rwzxvcMu7TNLswZObewLd0EXt908vmY0jmG5zfmXUfTyrsXC/P74kXa4o6GEU5/ZDiP+PfHNy/u0dN9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8ZP7O+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8ZP7O+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F303F1F000E9;
	Thu, 11 Jun 2026 18:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781202505;
	bh=PQ+7AF40V+UiCQ/so8xG7xoPIxuZce4SzWc4u0Zd2FA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=F8ZP7O+qURs/JvD+ud9qX64HvXWAIojPPqLBPUPOnZK0WacnQ4bvCpQGCNlXAhQNB
	 +2v1ImzkD6h+QS8l9hIR/YT9CDcRjBrqhiZXdsuwqoD+esg4LC1lvkqYyLKU2ekLqX
	 OU2+BDTSJOBjqmNRasjkS/YvS42ONDfkaxBvpUw18znh0gOv/gNhYkhW9jLLJPKEfa
	 wgr//jnNIROrjytMXTV3LLXRJV7fk0T1HGi7UV8ROoXWs+vy9bSiqIIu0Y1qSoHKAA
	 DH2oIHoJjiILFz7edPQmABPBgWKDSMwriCxJlDbi5R4u5J9QJy9GJrVH4S2dFnDFDX
	 tko/ixS1IL3CQ==
Message-ID: <9a9a8e6b-db0d-4e7c-8256-4ef31136377a@kernel.org>
Date: Thu, 11 Jun 2026 12:28:24 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] selftests: fib_tests: Add test cases for
 route lookup with oif
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, willemb@google.com
References: <20260611154605.992528-1-idosch@nvidia.com>
 <20260611154605.992528-4-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260611154605.992528-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/26 9:46 AM, Ido Schimmel wrote:
> Test that both address families respect the oif parameter when a
> matching multipath route is found, regardless of the presence of a
> source address.
> 
> Output without "ipv6: Select best matching nexthop object in
> fib6_table_lookup()" and "ipv6: Honor oif when choosing nexthop for
> locally generated traffic":
> 
>  # ./fib_tests.sh -t "ipv4_mpath_oif ipv4_mpath_oif_nh ipv4_mpath_oif_vrf ipv6_mpath_oif ipv6_mpath_oif_nh ipv6_mpath_oif_vrf"
> 
>  IPv4 multipath oif test
>      TEST: IPv4 multipath via first nexthop                              [ OK ]
>      TEST: IPv4 multipath via second nexthop                             [ OK ]
>      TEST: IPv4 multipath via first nexthop with source address          [ OK ]
>      TEST: IPv4 multipath via second nexthop with source address         [ OK ]
> 
>  IPv4 multipath oif with nexthop object test
>      TEST: IPv4 multipath via first nexthop                              [ OK ]
>      TEST: IPv4 multipath via second nexthop                             [ OK ]
>      TEST: IPv4 multipath via first nexthop with source address          [ OK ]
>      TEST: IPv4 multipath via second nexthop with source address         [ OK ]
> 
>  IPv4 multipath oif with VRF test
>      TEST: IPv4 multipath via first nexthop                              [ OK ]
>      TEST: IPv4 multipath via second nexthop                             [ OK ]
>      TEST: IPv4 multipath via first nexthop with source address          [ OK ]
>      TEST: IPv4 multipath via second nexthop with source address         [ OK ]
> 
>  IPv6 multipath oif test
>      TEST: IPv6 multipath via first nexthop                              [ OK ]
>      TEST: IPv6 multipath via second nexthop                             [ OK ]
>      TEST: IPv6 multipath via first nexthop with source address          [FAIL]
>      TEST: IPv6 multipath via second nexthop with source address         [FAIL]
> 
>  IPv6 multipath oif with nexthop object test
>      TEST: IPv6 multipath via first nexthop                              [FAIL]
>      TEST: IPv6 multipath via second nexthop                             [FAIL]
>      TEST: IPv6 multipath via first nexthop with source address          [FAIL]
>      TEST: IPv6 multipath via second nexthop with source address         [FAIL]
> 
>  IPv6 multipath oif with VRF test
>      TEST: IPv6 multipath via first nexthop                              [ OK ]
>      TEST: IPv6 multipath via second nexthop                             [ OK ]
>      TEST: IPv6 multipath via first nexthop with source address          [FAIL]
>      TEST: IPv6 multipath via second nexthop with source address         [FAIL]
> 
>  Tests passed:  16
>  Tests failed:   8
> 
> Output with the patches:
> 
>  # ./fib_tests.sh -t "ipv4_mpath_oif ipv4_mpath_oif_nh ipv4_mpath_oif_vrf ipv6_mpath_oif ipv6_mpath_oif_nh ipv6_mpath_oif_vrf"
> 
>  IPv4 multipath oif test
>      TEST: IPv4 multipath via first nexthop                              [ OK ]
>      TEST: IPv4 multipath via second nexthop                             [ OK ]
>      TEST: IPv4 multipath via first nexthop with source address          [ OK ]
>      TEST: IPv4 multipath via second nexthop with source address         [ OK ]
> 
>  IPv4 multipath oif with nexthop object test
>      TEST: IPv4 multipath via first nexthop                              [ OK ]
>      TEST: IPv4 multipath via second nexthop                             [ OK ]
>      TEST: IPv4 multipath via first nexthop with source address          [ OK ]
>      TEST: IPv4 multipath via second nexthop with source address         [ OK ]
> 
>  IPv4 multipath oif with VRF test
>      TEST: IPv4 multipath via first nexthop                              [ OK ]
>      TEST: IPv4 multipath via second nexthop                             [ OK ]
>      TEST: IPv4 multipath via first nexthop with source address          [ OK ]
>      TEST: IPv4 multipath via second nexthop with source address         [ OK ]
> 
>  IPv6 multipath oif test
>      TEST: IPv6 multipath via first nexthop                              [ OK ]
>      TEST: IPv6 multipath via second nexthop                             [ OK ]
>      TEST: IPv6 multipath via first nexthop with source address          [ OK ]
>      TEST: IPv6 multipath via second nexthop with source address         [ OK ]
> 
>  IPv6 multipath oif with nexthop object test
>      TEST: IPv6 multipath via first nexthop                              [ OK ]
>      TEST: IPv6 multipath via second nexthop                             [ OK ]
>      TEST: IPv6 multipath via first nexthop with source address          [ OK ]
>      TEST: IPv6 multipath via second nexthop with source address         [ OK ]
> 
>  IPv6 multipath oif with VRF test
>      TEST: IPv6 multipath via first nexthop                              [ OK ]
>      TEST: IPv6 multipath via second nexthop                             [ OK ]
>      TEST: IPv6 multipath via first nexthop with source address          [ OK ]
>      TEST: IPv6 multipath via second nexthop with source address         [ OK ]
> 
>  Tests passed:  24
>  Tests failed:   0
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/fib_tests.sh | 251 ++++++++++++++++++++++-
>  1 file changed, 250 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


