Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C49E36495B
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 02:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368800; cv=none; b=OgRm0jMlz1nYeB8YrqXWgAyP5XrtOVmlmU7qkcYr5vk6QWQgG50w2/QMXJ8fjNiXmR8OvkGSmu0hkia+XJ95qaw8eaUcNcMYixBC+bqZPEW+882Jpl9Gu96e638fyxpwd3oDjXMQcj4ygNXTvfqZpdorS2Ot5pAvgB8wjcZTpig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368800; c=relaxed/simple;
	bh=7MxeaKGTcob7a6UVh99ZnZv6+2+xk+iHnrz4VHW1vck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9GgwnhirfdZVBwh2k48UW+M6iG8guSPs630R2Ydzp9ZZ/0iqdplv0cSc6BeJ+I6r9S3enEHqXxlY0dPAuLBJS2IjeY85DJRkxtzVAOII6pBZdazubywhYAR3CCQxSek+05UWOyA0G67G11d5edFW03duPNjcj/8jb+dpmoN0Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSaECgTa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSaECgTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6B91F00893;
	Tue,  2 Jun 2026 02:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780368798;
	bh=TAsbOftJUVKENAqzpQpOqBynxpZ4awTIIHRkrr2zjzg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jSaECgTa1DtHOdbAj9T0ZqNydDadSTdF/rDI9JJqKck/1mycYJrJofibdzn1oMT7C
	 dl8A5vaAoD29NbcomgzEFFc6+hVfhyd26VsVBPX5xywq4g5e8wnQhn/RbjauasLyIl
	 oIRqEjOYEzkajEAIJrAhDj4gGhvWd8KovJOp+Q1g6+//BR/AtH7M5sQh1OtZVezBLn
	 hZ2CK63kz9eUzN0iRkB02My+CeSC2Mht6cLUZgUUccJV/Tr3V2iV0ziQ83Z+4vXM17
	 9nf7jp4S6oGOJpe+QMjphH51mUa0e4grwGHCmJtGf0+neJXXuAROjzMzqVQEoG08tT
	 cZRx+CINZskyg==
Message-ID: <3dff2e67-5d21-4059-bb01-dc601b75b733@kernel.org>
Date: Mon, 1 Jun 2026 20:53:17 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] selftests: fib_tests: Add test cases for
 route lookup with oif
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, willemb@google.com
References: <20260601065300.267960-1-idosch@nvidia.com>
 <20260601065300.267960-3-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260601065300.267960-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/26 12:53 AM, Ido Schimmel wrote:
> Test that both address families respect the oif parameter when a
> matching multipath route is found, regardless of the presence of a
> source address.
> 
> Output without "ipv6: Honor oif when choosing nexthop for locally
> generated traffic":
> 
>  # ./fib_tests.sh -t "ipv4_mpath_oif ipv4_mpath_oif_vrf ipv6_mpath_oif ipv6_mpath_oif_vrf"
> 
>  IPv4 multipath oif test
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
>  IPv6 multipath oif with VRF test
>      TEST: IPv6 multipath via first nexthop                              [ OK ]
>      TEST: IPv6 multipath via second nexthop                             [ OK ]
>      TEST: IPv6 multipath via first nexthop with source address          [FAIL]
>      TEST: IPv6 multipath via second nexthop with source address         [FAIL]
> 
>  Tests passed:  12
>  Tests failed:   4
> 
> Output with "ipv6: Honor oif when choosing nexthop for locally generated
> traffic":
> 
>  # ./fib_tests.sh -t "ipv4_mpath_oif ipv4_mpath_oif_vrf ipv6_mpath_oif ipv6_mpath_oif_vrf"
> 
>  IPv4 multipath oif test
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
>  IPv6 multipath oif with VRF test
>      TEST: IPv6 multipath via first nexthop                              [ OK ]
>      TEST: IPv6 multipath via second nexthop                             [ OK ]
>      TEST: IPv6 multipath via first nexthop with source address          [ OK ]
>      TEST: IPv6 multipath via second nexthop with source address         [ OK ]
> 
>  Tests passed:  16
>  Tests failed:   0
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/fib_tests.sh | 183 ++++++++++++++++++++++-
>  1 file changed, 182 insertions(+), 1 deletion(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>

