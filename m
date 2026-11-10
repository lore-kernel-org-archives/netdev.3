Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291996;
	b=j8SL4SdkkRSjkxAC9KaRKyaJHmMxky9hXvw0TpHgBErTwBxgaiyo7iVtubQDwMJ0Hjge
	 YxNYm+4xq+4cX2s1fqCi2lHrN+1QMgwneQwT6PVzsjudTI0aG7WSRUq9or53+ZYJTqPDQ
	 Y17v2JBdq/GCZf2X9b8+Abr/kwym8EOS+EyHW5NoJQr8HLjieS8KaRiyYkXA09k61lmbb
	 KDanxiCO6hlSE94Nqoo+n3cfQZw8bQMhbawb4u7NNnwy7/cCvUJaKMMS/O8Il/hxlAsV2
	 p/33qQQbWWxqGrqzsNIEG1AaUgqaaeozXliudbZ8kvruUklY79QcMqk0rGozigPo/Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291996;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ojUYDTL9NZGqTuzOAcNPqIkucjU3jwnh2aKBI9TK0GA=;
	b=i1sBK49UUrwhrO9rKw7GwZCYltcs0qUq+ZzrWEol7DvCdVyeS0cK7Dd/O3eZyJLOxm+Z
	 J2x3tvQwj/E9f34mxPWKtZJmo+z/RnU8yaMK3zvPTkYsf5KAxd6tveEVPJvibJgP5BoDW
	 SXkHvBbSjf/30acM7aAR93ggZLlI2VhhH/BcfsWhfGfCo93FO6dzK9LwjxgxxHya/97zF
	 l0myFMoxQ2QkhL3KpbIIANECrqUWowGvAbWqYLqVJ/6wWsX6ypGumFJS7SPoXgHTg5tmn
	 SFxda4xhSab8qV02WdVzXEyhroD0w+NUqcyvYsVo0VV5GmRbbJPxqwl/DmvvWeeFqIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WdU61FaQ;
	arc=none smtp.remote-ip=95.215.58.28
Received: from mta1.migadu.com (out-28.mta1.migadu.com [95.215.58.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44261606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44261606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WdU61FaQ
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2HOEpaZ+eKTnq4zhEkTJPCUHP9kr5u1Ujd+ujWJoYoQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794291992; v=1; x=1794896792;
 b=WdU61FaQHjjd+fNp26rLGbCEqgA5/u8zkoKZsSU1t1/zhTcptpk6SVuJ/554HaYq1dFsF/fZ
 hlyvEUXb1a67JBEwwIRsjpDXipInThcVHcM85eucGEsQpKU4/49cXf8x8EKMUgL5Ux23HSBkSNG
 zICfEJpoIGHTqAeSxwxzSoOU=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 21ddd5e6cb307c28;
	Tue, 10 Nov 2026 06:26:31 +0000
X-Mizu-Trace-ID: 21ddd5e6cb307c28
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 14:26:13 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jingjing Xu <xujingjing@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, willemb@google.com, kuba@kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org,
	davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [PATCH net] selftests: net: udpgso_bench_tx: honor CPU zero in
 the affinity option
Message-ID: <avK5BTH-n4hHIb4_@fedora>
References: <20261110033920.49267-1-xujingjing@cmss.chinamobile.com>
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
In-Reply-To: <20261110033920.49267-1-xujingjing@cmss.chinamobile.com>

On Tue, Nov 10, 2026 at 03:39:20AM +0000, Jingjing Xu wrote:
> The -C option accepts a CPU number, with -1 meaning that affinity was
> not requested. Testing cfg_cpu > 0 ignores an explicit -C 0, so the
> benchmark can run on other CPUs despite the requested pinning.
> 
> Accept zero as well, keeping the negative default unchanged.
> 
> Discovered by Codex-assisted code inspection. Validated before and after
> the fix with loopback UDP traffic, inheriting CPUs 0 and 1 and reading
> the process affinity with sched_getaffinity(). Before the fix, -C 0
> retains both CPUs; after it, only CPU 0 is allowed. The default and -C 1
> cases retain their expected masks. Built with GCC using -Wall -Werror.
> 
> No kernel instrumentation or fault injection was used.
> 
> Fixes: 3a687bef148d ("selftests: udp gso benchmark")
> Signed-off-by: Jingjing Xu <xujingjing@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/net/udpgso_bench_tx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
> index 86d80cce55b4..797c8d6800f0 100644
> --- a/tools/testing/selftests/net/udpgso_bench_tx.c
> +++ b/tools/testing/selftests/net/udpgso_bench_tx.c
> @@ -642,7 +642,7 @@ int main(int argc, char **argv)
>  
>  	parse_opts(argc, argv);
>  
> -	if (cfg_cpu > 0)
> +	if (cfg_cpu >= 0)
>  		set_cpu(cfg_cpu);
>  
>  	for (i = 0; i < sizeof(buf[0]); i++)
> base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
> -- 
> 2.53.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
