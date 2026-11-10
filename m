Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292397;
	b=QvlmPuzisIGWnvUcC6Myb2ul29Cm0QiM5dJIewBdPNhEBHmIR/nQV+zbLqkvQsUXwWy/
	 fkipPUqnTf0Q1Aq8hp7FNAqVSlafkwP8vvoaAOD05AyAMaw2+G4yBL63LElurGvANrbxS
	 ZFOOs77opIHqtUk9UWBZF6UUxuGutyMg4JIVwY8WnXqMjKoyM0lZdFV8KdD9zVt0vesyp
	 l39Oh9Bq+OdfvRpbEA/oD0yzI0qcY0nO82n/BHoN/V/z1nms+ji1LB2XaDDoVVX6W3ioz
	 5E+4jSRQ4sKSBlNLJQYxy+KiDnmuxvDsiCxxEToDi2qp0Pfe/wUtliVxrbX1R4Y8UeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292397;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=i+lmjC4vZ/ZbsebCUsOQFcxcG1XDCYVhjquJWR5ibM4=;
	b=Em3LTa88vIJ/TzICBTdb9PHzEpv1KtlFh1EHzF4wBcsnriwbk6jZEffVe9/lQyHds6gU
	 PsybcENkvoUqlXOHSnFR/jrqgm8Wy8vqNbKNQ6U6v3TySHxqyMeJPs89WYyRL4zfOaeQh
	 1uQK0yUyC8raA+rxOZqhn1l8uv+33aBmQl0uKriuD2FXV7bgeihrjut7sKxQ8WfXIlx9O
	 BfLGe06xXozMvyQRuf5q7t4LFJG9GxU/bWGuV86rmW+A569Go2Gxttf4mGbNJiiGKAKHM
	 /BZVcgwGUtYbcHqGxW97qhswJFBWes8aUM4ikHrxsJ0Pr9DBRQ5pgk7uOuF4N8ifgPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BRcRC40f;
	arc=none smtp.remote-ip=95.215.58.98
Received: from mta1.migadu.com (out-98.mta1.migadu.com [95.215.58.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49F5606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A49F5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BRcRC40f
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9yp3BYFOdlf8QDUU5iOP1ir0Cm0wnydHnLiwt8bTGpA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794292393; v=1; x=1794897193;
 b=BRcRC40fyAwJkedk6w0E446g3WDdGmTR6gxzNAcQ+IWudIWxJWTvrjzmuGvixNIsvfRmzwS0
 8iqP+b51EbW1NmrWsSYqClm+za6NSQXh0TCBJsBFOrXONdjRPvJPJmpT0BiZMRSabRffQ54fUIK
 UIqN5gTYn4noI5WG4uWgv7S4=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id ed16973ca3104501;
	Tue, 10 Nov 2026 06:33:13 +0000
X-Mizu-Trace-ID: ed16973ca3104501
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 14:33:02 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jingjing Xu <xujingjing@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, willemb@google.com, kuba@kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org,
	davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [PATCH net] selftests: net: cmsg_sender: retain the resolved
 address family
Message-ID: <avK6ngiakOhpKYbg@fedora>
References: <20261110033918.49238-1-xujingjing@cmss.chinamobile.com>
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
In-Reply-To: <20261110033918.49238-1-xujingjing@cmss.chinamobile.com>

On Tue, Nov 10, 2026 at 03:39:18AM +0000, Jingjing Xu wrote:
> When neither -4 nor -6 is supplied, getaddrinfo() selects the socket
> family but opt.sock.family remains AF_UNSPEC. The cmsg and socket option
> helpers then take the IPv6 branch even for an IPv4 socket.
> 
> For example, an IPv4 loopback packet sent with -l 11 arrived with the
> default TTL of 64 on the test host. Using -L 11 instead failed with
> ENOPROTOOPT because the tool tried IPV6_UNICAST_HOPS on an IPv4 socket.
> Explicit -4 works in both cases.
> 
> Record the selected ai_family after successful address resolution so the
> helpers use the same family as the socket.
> 
> Discovered by Codex-assisted code inspection and tested with real
> loopback UDP traffic, without kernel instrumentation. Covered IPv4 and
> IPv6, automatic and explicit family selection, and cmsg and setsockopt
> hop limits. All eight cases receive the requested value after the fix.
> Built through the net selftest Makefile and with GCC -Wall -Werror.
> 
> Fixes: 2e5584e0f913 ("selftests/net: expand cmsg_ipv6.sh with ipv4")
> Signed-off-by: Jingjing Xu <xujingjing@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/net/cmsg_sender.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
> index 67a72b1a2f3d..01617a021338 100644
> --- a/tools/testing/selftests/net/cmsg_sender.c
> +++ b/tools/testing/selftests/net/cmsg_sender.c
> @@ -495,6 +495,7 @@ int main(int argc, char *argv[])
>  		goto err_free_buff;
>  	}
>  
> +	opt.sock.family = ai->ai_family;
>  	if (ai->ai_family == AF_INET6 && opt.sock.proto == IPPROTO_ICMP)
>  		opt.sock.proto = IPPROTO_ICMPV6;
>  
> base-commit: 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22
> -- 
> 2.53.0

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
