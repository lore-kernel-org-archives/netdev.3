Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.249
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843505;
	b=Ye+Wb6UdF4gFFrfj0wC+RNH451P1eppo2FG8rHaUPmSSAOVx5/46d373YMaC99grpyQN
	 xkyhTM1VDf/NzU2GTYL4jcvxzpbI/ZD+CGvwjSAjzCnp63wJNWlBaHWhoemF4idAPjjux
	 sSHWYMJESE+Lp5xsLZ3liAikJNoqAyVc3N4Z/lfN9jZZ46xV/3ks12qP0fbj98cFRiBuC
	 AQPa2u58qUjBXhTTVdh6eWLe9fi0QW1u4DXd+5UqJjIXCktDZK4WLR+WcvKZMeVLlEAQi
	 W1ZQsVyQpjU/v7YHLSyHdnu+Gd+B0hjFHHhtFhRz973Pt/HKhQe26uwMR5M7levjDxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843505;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ky38IXx52DEGULXMrnA5tjdm39nZcAMBNJmvwXh3cTI=;
	b=ImNkXRYDigUTvxHR9i7kX1/z8p6spzMgHtsC2ONCTQp1T2b8RicXvO2ihpNvfAQA+T8e
	 AWYhbKPddtjgwX55bqVrZwrnhaulxUrX47F/g4Iau6xGTz+o4gIMUhpbmGKoB0YIB9Rx6
	 WrnYl9pr9B24+S1SQ/EgVRwIkfJPIH78Ln4X4WSv02dfK0PEoCloUmctoLO3HoxLbkuyL
	 qbZeX3sNmf4Akf86z0s3HlqNSk4IP2aAQgSGKFiWo9ZCYzHK6sKA+19M/cIBS4UfXEV2X
	 JMWIFKDPSilxEJ0CsfOYSgsrSMbfJ1Pm2VWK0i/VhokZ3fFuS63FVsVn/GrW/WLPB1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PbgEo1at;
	arc=none smtp.remote-ip=91.218.175.249
Received: from mta0.migadu.com (out-249.mta0.migadu.com [91.218.175.249])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA55A606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 01:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA55A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PbgEo1at
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DW+azq6/SBvy/V6tvbvsVQb5ifMLNmZz6ayEqb3qh9w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793843501; v=1; x=1794448301;
 b=PbgEo1atnLArh5Odi3UeSK0+CEj2+3t5Y+yIK8VJYNNdvRv6APy7KfWiFgN0ubfwkQ6oes67
 pRALqBo63uJo/BNF9mI/bLb5wqdhCT7DdSsH5nl/1tT/ne8MFdbuCYDFGNQ3+PHPD7Exi5mnEGM
 dyBSzprJkBN9bMShLwlG3wXY=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 3f261ba619c0a795;
	Thu, 05 Nov 2026 01:51:41 +0000
X-Mizu-Trace-ID: 3f261ba619c0a795
X-Migadu-Flow: FLOW_OUT
Date: Thu, 5 Nov 2026 09:51:30 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	weiwan@google.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] selftests: fib_tests: Add carrier gateway test
Message-ID: <auvhInnH7ESZj5Xr@fedora>
References: <20261104195655.1406837-1-aroslavdudkov622@gmail.com>
 <20261104195655.1406837-3-aroslavdudkov622@gmail.com>
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
In-Reply-To: <20261104195655.1406837-3-aroslavdudkov622@gmail.com>

On Wed, Nov 04, 2026 at 07:56:55PM +0000, Yaroslav Dudkov wrote:
> Test adds routes with a gateway while the nexthop device
> has no carrier and ignore_routes_with_linkdown is enabled on it. The
> routes are added to the main table and to a non-main table, with and
> without a device, for both IPv4 and IPv6. Routes are expected to be
> accepted disregarding the link state.
> 
> Without the previous patch, the IPv6 non-main table cases fail:
> 
> Without fix:
> Gateway validation with carrier down
>     TEST: IPv4 route in main table                                [ OK ]
>     TEST: IPv6 route in main table                                [ OK ]
>     TEST: IPv4 route in non-main table                            [ OK ]
>     TEST: IPv6 route in non-main table                            [FAIL]
>     TEST: IPv4 route in non-main table without device             [ OK ]
>     TEST: IPv6 route in non-main table without device             [FAIL]
>     TEST: IPv4 linkdown flag set                                  [ OK ]
>     TEST: IPv6 linkdown flag set                                  [FAIL]
> 
> With fix:
> Gateway validation with carrier down
>     TEST: IPv4 route in main table                                [ OK ]
>     TEST: IPv6 route in main table                                [ OK ]
>     TEST: IPv4 route in non-main table                            [ OK ]
>     TEST: IPv6 route in non-main table                            [ OK ]
>     TEST: IPv4 route in non-main table without device             [ OK ]
>     TEST: IPv6 route in non-main table without device             [ OK ]
>     TEST: IPv4 linkdown flag set                                  [ OK ]
>     TEST: IPv6 linkdown flag set                                  [ OK ]
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
> ---
>  tools/testing/selftests/net/fib_tests.sh | 40 ++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
> index 7c47d7fe250d..d7ac3c727f70 100755
> --- a/tools/testing/selftests/net/fib_tests.sh
> +++ b/tools/testing/selftests/net/fib_tests.sh
> @@ -406,10 +406,50 @@ fib_carrier_unicast_test()
>  	cleanup
>  }
>  
> +fib_carrier_gw_test()
> +{
> +	echo
> +	echo "Gateway validation with carrier down"
> +
> +	setup
> +
> +	set -e
> +	$NS_EXEC sysctl -qw net.ipv4.conf.dummy0.ignore_routes_with_linkdown=1
> +	$NS_EXEC sysctl -qw net.ipv6.conf.dummy0.ignore_routes_with_linkdown=1
> +	$IP link set dev dummy0 carrier off
> +	sleep 1
> +	set +e
> +
> +	$IP route add 203.0.113.0/25 via 198.51.100.2 dev dummy0 &> /dev/null
> +	log_test $? 0 "IPv4 route in main table"
> +	$IP -6 route add 2001:db8:10::/64 via 2001:db8:1::2 dev dummy0 &> /dev/null
> +	log_test $? 0 "IPv6 route in main table"
> +
> +	$IP route add 203.0.113.0/25 table 100 via 198.51.100.2 dev dummy0 &> /dev/null
> +	log_test $? 0 "IPv4 route in non-main table"
> +	$IP -6 route add 2001:db8:10::/64 table 100 via 2001:db8:1::2 dev dummy0 &> /dev/null
> +	log_test $? 0 "IPv6 route in non-main table"
> +
> +	$IP route add 203.0.113.128/25 table 100 via 198.51.100.2 &> /dev/null
> +	log_test $? 0 "IPv4 route in non-main table without device"
> +	$IP -6 route add 2001:db8:11::/64 table 100 via 2001:db8:1::2 &> /dev/null
> +	log_test $? 0 "IPv6 route in non-main table without device"
> +
> +	$IP route show table 100 203.0.113.0/25 | \
> +		grep -q "linkdown"
> +	log_test $? 0 "IPv4 linkdown flag set"
> +	$IP -6 route show table 100 2001:db8:10::/64 | \
> +		grep -q "linkdown"
> +	log_test $? 0 "IPv6 linkdown flag set"
> +
> +	cleanup
> +}
> +
>  fib_carrier_test()
>  {
>  	fib_carrier_local_test
>  	fib_carrier_unicast_test
> +	fib_carrier_gw_test
>  }
>  
>  fib_rp_filter_test()
> -- 
> 2.54.0
> 

Tested-by: Hangbin Liu <liuhangbin@kylinos.cn>
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
