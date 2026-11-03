Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728792;
	b=LqdzwA4hkuYQUD1EAW0kUtL6NonFSMCFqDnM9gWlKIjl74QDMHmJhoJU1gPIAAOkAqf/
	 /C9W0kqd9rcv12/Q+ryrDfx8IzmdJgMqDPIF3YPa2qSMdDbD2mRgguEuPLE/m8XWaRUf/
	 XXrEHsZZhJ2P/AkOcXNfIwksMAnJmyqL+S9iQhpkg6tVAlHpg/j6vn+2VGVXMvQYg39y8
	 cIH3j4YO748/SP0ffwftQikJR9yHV1Gb91Z4h0ynJbr5AyH5JBE6eoUrIweLjzcAuIShW
	 YyOYCgaQQ+g0kBWWazAUFPPNbGMLrp2+zN7X8sACXUyvNabJuxamc/b/kwL9zEEMPPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=2F2lIdK086BENYIYPQD2Q2okdf2dHEkNd/6V9465bEA=;
	b=y4+ZXvwLdmb+qSd+qW/o4Yfu3ewznQfbt8Co1C3gyYmKkiCMpPwwvaTAJ90GYq3xurAQ
	 DqzwxyA5GWSSXNNzuDSF2Zta9I/YUXHr44rNclT/iERjJDfgSx9cJYE/7vfx/bbP9M773
	 1CTEu4kejzznydEvhDWuYUL8cjbCFKkNbpkVAa8iUDe68zmPh0XWNo8nMY63mrkqRLxz3
	 8elzXxxOGtks2Q22HFsQir0Wt7GrTBkkk86ENTzOuSPZi9Yo0rO1VyCnDhzCCLOolcg+Z
	 P04MO32XtljTjls9eWGFVHs9hmS2COGtMfpRs4Hl6APfksgXfUfmakcPBtDrmqXPB1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TCjz6mkB;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723C9606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 723C9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TCjz6mkB
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-14394530ec6so5957343c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 09:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793728792; x=1794333592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2F2lIdK086BENYIYPQD2Q2okdf2dHEkNd/6V9465bEA=;
        b=TCjz6mkBL99yj7gcdlCxhkwe/S1344iWFLlicIpOOL8sh5AZPdcffvifLfg7haM9pE
         zST8Mq20JhE4GJsoCQm3Hwz8nuKlSI46LWNjKkhhLnLHo70247g6nrlv1k7bM1ysBw7Y
         ZqLAIsi9gkq6nv1jr34z/oW128mpWH0hWG5frvuyXcVCEspkykU7rWa13cfbPUyEsPge
         JqVpeLojl3l4YjD9R+CPkz42fMdWKiZpONPHyU4iryYbge7Rzow2PCCVWBkz54rXMgnY
         PLg2ce51LXdHBAN6WX80jHcpLsHMucqmRZILe2gC4Oq+Qt/W7PxCCuXq4uBFr6XJdMz+
         FHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728792; x=1794333592;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2F2lIdK086BENYIYPQD2Q2okdf2dHEkNd/6V9465bEA=;
        b=IZc4r8J5u1STtN2lA5bDTxe6CqYPS08BoFlHi+MnVP6f46n9iqYGZcYfd2ro+2Mx8I
         Nn8a8grB5HLaJH8HCBranLPQzS9rHWm5CEPXsTEai71l5xP8dAACuCAC7qnZ9QURWQ7/
         SJ+sBXeY1LseT5eH5I+bmJVbZkAIitsmD3b4yxCy0ImCxaBBjgMh/s+NxDb+aVxOtdcF
         nBGJ2miempfOoCnuaMTRhzE4/4ETbgrttvDV7UD6F/MmWPmy/YyhQRCoymPgJluhKwBZ
         xSMVXxxeqzBfvOG/oD0j7I74Y3y+rWlvx738TkGas+hH0iu6+Z+M5VVJnS2tlC71uswX
         IE2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxlixTTnZLfgjntv9/BGxHJjb949UKSEZECNRWVdutbPG2cy5eTopCOwB/kWW4ild6IUetQ1SQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8h3CkEzdWVpgib+lOSagsrmj9iL2KzmwpFiwoYdenQW6uBN+LX
	tzvu53mLwBOwaRq+pa3J8nhCWIqhn7ZXZjkfL7B9Cd0yMVZmBBKb/KTh
X-Gm-Gg: AYBFou1xSxC7I9/xXiLnuFuO5zBpRDslO+I4tdEWxkIOU3UyJ0bfvQFi1cA+AeSUn2j
	yFbct5OeTPbRaIqeffFoqhss606T3nhzTRyKMgLAPRi0wWuiJUIgimMKWXMEqBLAh4j+OSwkQnr
	4HD9VxozOvDtvEzBK2WNTrOPuTolVxySv6Q9BDoZtbIm4K8TereFlxvC/UnEViIzo6Pr/olILQo
	EaAQLQrnejFRd1mFoV81W3aNMGllNY3dbJ9WevG2BmwQI7lKsdlWDsax5hCawZS4Y5x4QmOTUc8
	j0xpEcOmqUt0pg2jR0Zpca13JKX+Y3Vow/C6LZLislsg80P9Cpx1pkYwOg7Q6ee1aRhVl5BNQTC
	Q/kFN8HUNafqY0XzD80NF4qm5DMZJOwrT9lDUY6qi2Ntq/N2gKU4aw1zXl26tn88RUABi3WTYUx
	LNEP5WETbmHPOfGC0d01XHgP4rQ1CxPj4r6c/oTnRVeacMXOa08AfWZLehxT9hS8MKy3r4BMDJ7
	Wvmps7gei+L/YdiT3feauC/4eDevJM9+4yWjtFZ0mpN3wVhJJg/26Vsc66viKFUDDhvyeIz6PfF
	S5Lsqfj3ONBri5PBV/QhOQfLtI/AXEpDJMEPLa1HoY2vbzbtClBOVVLB8axW3+T/mw==
X-Received: by 2002:a05:701b:420c:20b0:194:f017:5a01 with SMTP id a92af1059eb24-1ac5fc0d363mr20693907c88.42.1793728791460;
        Tue, 03 Nov 2026 09:59:51 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21c1::14ac? ([2620:10d:c090:400::5:e3cc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c65194sm427461c88.19.2026.11.03.09.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 09:59:51 -0800 (PST)
Message-ID: <cf4b221c-cf4b-414f-b087-815848c85b2e@gmail.com>
Date: Tue, 3 Nov 2026 09:59:49 -0800
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
Subject: Re: [PATCH] selftests: net: fix format warnings on 32-bit
 architectures
To: Sasha Levin <sashal@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261103155503.534876-1-sashal@kernel.org>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20261103155503.534876-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/3/26 7:55 AM, Sasha Levin wrote:
> On 32-bit architectures ssize_t is an int, tv_sec is a long long with a
> 64-bit time_t, and uint64_t is not a size_t, so ipsec, txtimestamp and
> the tcp_ao library warn when printing them with %ld, %lu and %zu:
> 
>    txtimestamp.c:191:42: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type '__time64_t' {aka 'long long int'} [-Wformat=]
> 
> Print ssize_t with %zd, tv_sec as long long, and the net namespace
> cookies with PRIu64 as the rest of ftrace-tcp.c already does. While at
> it, print tv_nsec, a long, with %ld instead of %lu, and cast it to long,
> as it is a long long on x32.
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> Found with a 32-bit build of the selftests with a 64-bit time_t (gcc 16
> and clang 21 with -m32 -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64);
> KernelCI's 32-bit arm builds show the same warnings. The changed files
> build without format warnings there now, and the x86_64 builds don't
> change. The other selftests get the same kind of fix in separate
> patches.
> 
>   tools/testing/selftests/net/ipsec.c                 | 2 +-
>   tools/testing/selftests/net/tcp_ao/lib/ftrace-tcp.c | 2 +-
>   tools/testing/selftests/net/txtimestamp.c           | 9 +++++----
>   3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
> index 89c32c354c008..ba8c36a93f176 100644
> --- a/tools/testing/selftests/net/ipsec.c
> +++ b/tools/testing/selftests/net/ipsec.c
> @@ -2030,7 +2030,7 @@ static int __write_desc(int test_desc_fd, struct xfrm_desc *desc)
>   	if (ret == sizeof(*desc))
>   		return 0;
>   
> -	pr_err("Writing test's desc failed %ld", ret);
> +	pr_err("Writing test's desc failed %zd", ret);
>   
>   	return -1;
>   }
> diff --git a/tools/testing/selftests/net/tcp_ao/lib/ftrace-tcp.c b/tools/testing/selftests/net/tcp_ao/lib/ftrace-tcp.c
> index 27403f8750547..cd93ff8965dda 100644
> --- a/tools/testing/selftests/net/tcp_ao/lib/ftrace-tcp.c
> +++ b/tools/testing/selftests/net/tcp_ao/lib/ftrace-tcp.c
> @@ -504,7 +504,7 @@ static int setup_tcp_trace_events(struct test_ftracer *tracer)
>   	size_t i;
>   	int ret;
>   
> -	filter = test_sprintf("net_cookie == %zu || net_cookie == %zu",
> +	filter = test_sprintf("net_cookie == %" PRIu64 " || net_cookie == %" PRIu64,
>   			      ns_cookie1, ns_cookie2);
>   	if (!filter)
>   		return -ENOMEM;
> diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
> index f7bdf30b78d9f..be1452d73b303 100644
> --- a/tools/testing/selftests/net/txtimestamp.c
> +++ b/tools/testing/selftests/net/txtimestamp.c
> @@ -188,12 +188,13 @@ static void __print_timestamp(const char *name, struct timespec *cur,
>   		return;
>   
>   	if (cfg_print_nsec)
> -		fprintf(stderr, "  %s: %lu s %lu ns (seq=%u, len=%u)",
> -				name, cur->tv_sec, cur->tv_nsec,
> +		fprintf(stderr, "  %s: %lld s %ld ns (seq=%u, len=%u)",
> +				name, (long long)cur->tv_sec, (long)cur->tv_nsec,
>   				key, payload_len);
>   	else
> -		fprintf(stderr, "  %s: %lu s %lu us (seq=%u, len=%u)",
> -				name, cur->tv_sec, cur->tv_nsec / NSEC_PER_USEC,
> +		fprintf(stderr, "  %s: %lld s %ld us (seq=%u, len=%u)",
> +				name, (long long)cur->tv_sec,
> +				(long)(cur->tv_nsec / NSEC_PER_USEC),
>   				key, payload_len);
>   
>   	if (cur != &ts_usr) {

Reviewed-by: Mohsin Bashir <hmohsin@meta.com>
