Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1499941A507
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786709254; cv=none; b=ldxSonJJswLHHVJZJJU6YwFUMrSrj5XEwQiYZ40l7+GHbwLlzm0cHeTx99XXhpc6r8Vy4cwPEWK03t0oRrjxnYwUzSrNAqAxbWp56cyYWlidP1xMg5y6nhekSoSCQeGnFsrI/6ftYVQScJob35/eQtKD4zBrtKhbtXTDIk0eC44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786709254; c=relaxed/simple;
	bh=/dJOlPt9+aDTsVN8f7vGpfqLyyvD8u+8QGIo3/kyDhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItPfw3llHnBiYqdaplC9ZEZSggZ7zhTSvHDGw4/S+BkSNHHUeuCYbwVwSPZU50VIJieZowmEeybPaQ96lrhiRfFgoUioNpQhKt3g+5l77/vx5iwfJC9wu9FPSqNT/eTgtnx9YrEpH9C22ZLdDPBrtziBur6xePoevlcOB+XYo40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yv65DuZq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yv65DuZq"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso958628a91.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 05:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786709250; x=1787314050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Iqn1uiDWgSvKCjqu1BHEGLhPdwV2ZOubviHkY4jibc4=;
        b=Yv65DuZqzTF3Q5YUPf/t2oKxrvrYuxu5WeTNudB+oBSW+rypUqURh9A4dL8NpnT/l4
         HG7y4qZTN/yW24pvxmbaPnTYUXkyFl/nissI34jEXnxvOdRevGO6q8qX3L5WhoHiAVNb
         XSvrr1h050cdWecd7OvcLnPO/8j7T9Bj8AtQ0QfKtjf6iWNqAjnThoM8Wkd18iFiixR1
         Hky440EouYQX8CDkfnSZY06QUW+L0LW08ECDLshIWElQytAaoJs6MPFuwrmIr23GjOlv
         oZI/II2qUoNMhEkXFepCWViiJQuK09/Gs0S/WXY2DVCIjAO72cu2LlXuzYxnA1cPPU/E
         CnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786709250; x=1787314050;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iqn1uiDWgSvKCjqu1BHEGLhPdwV2ZOubviHkY4jibc4=;
        b=Q4I0l7IzQ3y7n9h1hZ9ACgFd/zPbi9uHGhOPdAzgLjyy3ThLE7cV71tg1u0onh/GO9
         T4bNCzFGQDKbNnayprtS8jNQ4ygbSsWIyPtN6xARWzKWEAA94WSOjBOTvmKGdlNqeQ75
         0sb25L1lfBdjgEv9whtl0tic7kgGEx/2JUdBIKrHxcQ/9CqPQ5HrRZ4J5tPEZ8qkxONU
         mxRvCpGle1M4vMKqEZHiGn45UTdqJcsdO6kbVOnrxWt9p6zDU2G/eBjJe17kf59JkzJP
         Yi1zBRZBZf9LYDkObRqlAJpN1EXTi89v9N5TrT8uiOdIHd6pIf5t/u41yb6x4HUgZAqQ
         Et9Q==
X-Gm-Message-State: AOJu0YwJ04/WSbATbGpAFUC71onK/6JKR+yBJvXc+48kNNYLGtkl+QUI
	Bk1nRUeXXI6jwAs2yiigBdWlQP7KZQax9NmrPCxsZwQuD0o6vy3deCHnepgRq2Yq
X-Gm-Gg: AR+sD13CE5xWdgpp1U/OzZEFytfNYB7MSZ/P193AdrNzCKFZaausKvL+hHRCUn8zQOA
	caZc5mqueliW6z9cPuWOkqmem3r5TVlV2UESXW70OvdCJdWu8nC44eXjiAT9hNM/lGNARdZMM7K
	sHkRST9OS6fjq0JC5viZbXSoXVjLxJF2Zl017NS1pwpFrmiP4XhW7bepakh6OVJp0kuwMmUQ9jG
	eRs9eYRWw7hCxAjUPquM4eScGAD/1JQuvInMOl4s7TTAkW9JPmsTJxq+VfUSEZEsCSaTh+BOnyW
	vsovQgYFq+AC8FpPqGi9v2Ezz7E4W7lqwzq5j6WG2bk3Ah9kVbBwaetecfrXFANPpVdAbLGeJcZ
	8j5EiAAlCJDxWyVdZdM1xCgAAUs5ZFWDQ3memc19AmHNSkUSCgyeLrZ56XMxlAfo7ZqxEYnXOrF
	S6OlpAnjGAgDNMtW6hwBJUbY2YRghrYB3VtvNSQjE/OpOlAqIAoAO72KE=
X-Received: by 2002:a17:90b:520d:b0:38f:5801:cd76 with SMTP id 98e67ed59e1d1-3933b6d0171mr6355069a91.3.1786709249856;
        Fri, 14 Aug 2026 05:07:29 -0700 (PDT)
Received: from fedora ([203.175.12.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb7539d3sm2629381a91.15.2026.08.14.05.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:07:27 -0700 (PDT)
Date: Fri, 14 Aug 2026 20:07:20 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net-next] selftests: net: move log_test to lib file and
 remove duplicate code
Message-ID: <an8E-JDiGdmWbQdt@fedora>
References: <20260813-self_log_test-v1-1-f88b1107842e@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-self_log_test-v1-1-f88b1107842e@kylinos.cn>

On Thu, Aug 13, 2026 at 04:11:57PM +0800, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> When reviewing the test code, I saw many tests using the same or similar
> log_test functions. We can move them to lib.sh to save effort. However,
> due to historical reasons, we moved the log_test from the forwarding lib
> first, which has different usage. So, rename the log_test in the net
> folder to log_test_expected. Since renaming all the log_test functions
> in the test cases would change too many lines, I just use a wrapper in
> the old code.
> 
> The fourth argument in icmp_redirect.sh is not needed, as the xfail issue
> has already been fixed and it should always pass. But I still keep the
> xfail logic in the log_test in lib.sh in case other tests need it.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> ---

[...]

> diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
> index 3d347126730a..16fe92775ae0 100755
> --- a/tools/testing/selftests/net/fib_nexthops.sh
> +++ b/tools/testing/selftests/net/fib_nexthops.sh
> @@ -70,44 +70,7 @@ nsid=100
>  
>  log_test()
>  {
> -	local rc=$1
> -	local expected=$2
> -	local msg="$3"
> -
> -	if [ ${rc} -eq ${expected} ]; then
> -		printf "TEST: %-60s  [ OK ]\n" "${msg}"
> -		nsuccess=$((nsuccess+1))
> -	else
> -		if [[ $rc -eq $ksft_skip ]]; then
> -			[[ $ret -eq 0 ]] && ret=$ksft_skip
> -			nskip=$((nskip+1))
> -			printf "TEST: %-60s  [SKIP]\n" "${msg}"
> -		else
> -			ret=1
> -			nfail=$((nfail+1))
> -			printf "TEST: %-60s  [FAIL]\n" "${msg}"
> -		fi
> -
> -		if [ "$VERBOSE" = "1" ]; then
> -			echo "    rc=$rc, expected $expected"
> -		fi
> -
> -		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
> -		echo
> -			echo "hit enter to continue, 'q' to quit"
> -			read a
> -			[ "$a" = "q" ] && exit 1
> -		fi
> -	fi
> -
> -	if [ "${PAUSE}" = "yes" ]; then
> -		echo
> -		echo "hit enter to continue, 'q' to quit"
> -		read a
> -		[ "$a" = "q" ] && exit 1
> -	fi
> -
> -	[ "$VERBOSE" = "1" ] && echo
> +	log_test_expected "$1" "$2" "$3"
>  }
>  
>  run_cmd()

[...]

> diff --git a/tools/testing/selftests/net/icmp_redirect.sh b/tools/testing/selftests/net/icmp_redirect.sh
> index b13c89a99ecb..0107af73aef4 100755
> --- a/tools/testing/selftests/net/icmp_redirect.sh
> +++ b/tools/testing/selftests/net/icmp_redirect.sh
> @@ -61,28 +61,7 @@ log_section()
>  
>  log_test()
>  {
> -	local rc=$1
> -	local expected=$2
> -	local msg="$3"
> -	local xfail=$4
> -
> -	if [ ${rc} -eq ${expected} ]; then
> -		printf "TEST: %-60s  [ OK ]\n" "${msg}"
> -		nsuccess=$((nsuccess+1))
> -	elif [ ${rc} -eq ${xfail} ]; then
> -		printf "TEST: %-60s  [XFAIL]\n" "${msg}"
> -		nxfail=$((nxfail+1))
> -	else
> -		ret=1
> -		nfail=$((nfail+1))
> -		printf "TEST: %-60s  [FAIL]\n" "${msg}"
> -		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
> -			echo
> -			echo "hit enter to continue, 'q' to quit"
> -			read a
> -			[ "$a" = "q" ] && exit 1
> -		fi
> -	fi
> +	log_test_expected "$1" "$2" "$3"
>  }

[...]
>  
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index d46d2cec89e4..e02a6a91ff91 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -454,6 +454,44 @@ log_test_xfail()
>  	RET=$ksft_xfail retmsg= log_test "$@"
>  }
>  
> +# Log test result with expected return value
> +log_test_expected()
> +{
> +	local rc=$1
> +	local expected=$2
> +	local msg="$3"
> +
> +	if [ "${rc}" -eq "${expected}" ]; then
> +		nsuccess=$((nsuccess+1))
> +		printf "TEST: %-60s  [ OK ]\n" "${msg}"
> +	elif [ "${rc}" -eq "${ksft_skip}" ]; then
> +		[[ "$ret" -eq 0 ]] && ret="$ksft_skip"
> +		nskip=$((nskip+1))
> +		printf "TEST: %-60s  [SKIP]\n" "${msg}"
> +	elif [ "${rc}" -eq "${ksft_xfail}" ]; then
> +		nxfail=$((nxfail+1))
> +		printf "TEST: %-60s  [XFAIL]\n" "${msg}"
> +	else
> +		ret=$(ksft_exit_status_merge "$ret" "$ksft_fail")
> +		nfail=$((nfail+1))
> +		printf "TEST: %-60s  [FAIL]\n" "${msg}"
> +		if [ "$VERBOSE" = "1" ]; then
> +			echo "    rc=$rc, expected $expected"
> +		fi
> +
> +		pause_on_fail
> +	fi
> +
> +	if [ "${PAUSE}" = "yes" ]; then
> +		echo
> +		echo "hit enter to continue, 'q' to quit"
> +		read -r a
> +		[ "$a" = "q" ] && exit 1
> +	fi
> +
> +	[ "$VERBOSE" = "1" ] && echo
> +}
> +

Reply to sashiko's review.

  """
  fib_nexthops.sh has two unconditional hard-failure calls:
  tools/testing/selftests/net/fib_nexthops.sh:ipv6_fcnal_runtime() {
  	...
  	else
  		log_test 2 0 "Ping - multipath failed"
  	fi
  	...
  }
  """

Correct, this need to be updated, otherwise the report will be xfail.

  """
  The same concern applies to ordinary positive checks written as
  "log_test $? 0 ...".  iproute2 returns 2 for kernel-reported errors and ping
  returns 2 for local errors such as "Network is unreachable", for example in
  fcnal-test.sh:
  	run_cmd ping -c1 -w1 -I br0 ${NSB_IP}
  	log_test $? 0 "Bridge into VRF - IPv4 ping out"
  and fcnal-test.sh decides its verdict from nfail alone:
  	if [ $nfail -ne 0 ]; then
  		exit 1 # KSFT_FAIL
  Would it be safer to only take the SKIP/XFAIL arms when "expected" itself is
  ksft_skip/ksft_xfail?
  """

If "expected" itself is ksft_skip/ksft_xfail, and we got the expected number,
then the result should be PASS.


  """
  In the other direction, icmp_redirect.sh's checks are grep pipelines that
  only produce 0 or 1, so after dropping the fourth argument its nxfail
  counter and the "Tests xfailed" line can no longer be reached.
  """

We can remove the xfail count in icmp_redirect.sh testing


> diff --git a/tools/testing/selftests/net/test_bridge_neigh_suppress.sh b/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
> index e9ed0d750996..9d2dc0faf741 100755
> --- a/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
> +++ b/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
> @@ -72,39 +72,7 @@ PAUSE=no
>  
>  log_test()
>  {

[...]
> -
> -	[ "$VERBOSE" = "1" ] && echo
> -	return 0
> +	log_test_expected "$1" "$2" "$3"
>  }
>  

  """
  Is dropping this "return 0" safe here?
  """

Hmm, yes, we'd better add return 0 in log_test as the read may return 1 if
it's not "q".

I will update the patch.

Thanks
Hangbin
