Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383097;
	b=W4I4PQxkgBPBdM62t1NJ3zkSTpuxKPg0jx0NIxei4GdfTSdMnNyGWDTdyv7bymEfHNK5
	 cBBPtvrDjX9t7/gtYUSyZxy2RiPzgpL3YhDqD3x1dUGFQmf/fTlJpdUgmWbaDym0DaMt9
	 iIJsuzPCWK7DKtYpTIA77eyCDyUrRhCjSk1tJnSZ6evfxTYUPTpRpqAP6in2wX8jFs085
	 +eTgupI+JMsD1uQeCFnzC+1fVag+Ch9QXf7hytfsUOu0lkQLd6e1Ux4f88R8URZC0Qpem
	 CPc85uukZ6hTenAMPKt/RcirrDKD+9jZLO7GIUINqI35pvh/yJ41+f3JSpmqAMRuB8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383097;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aTzRns4P41LTvEjZitBtZ35u3x5iyyKI3BwYPIuLk0Y=;
	b=VPLgj8d6D4s6eoAb0YZOp7wMSHmsfYj4uI88cXuURhS+5EpAnX4l2Nemqj892yVAs+Sv
	 +zdDRW+FcsQaYrDZ/5J0BV+yzByzIIbI/DxygTzQv70BmhZfQhyzGljgyMFH/xrv/UKcv
	 ZlM/WT+/PYyWxWIEO1mvDXfH5OogjBoDusl8uu0Rrq/VYEob75jpnKhLcY7ydOxCsfnmJ
	 wFPYN9lMrsb8+8jqEOETxJ2aCAEUERh41qNgVZLh5u7sBg9uKHmLBUYCdEzbt+8xN+5vt
	 thCQ1haq2KspmD2iIIqw/mkfWLBJuoOkjdu0J4g8CrrwplVinLMir4ZLb/K+YHAgjsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OH6REcCW;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8C606A323
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 17:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9E8C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OH6REcCW
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7cc7938c5e9so899903137.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 10:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793383096; x=1793987896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aTzRns4P41LTvEjZitBtZ35u3x5iyyKI3BwYPIuLk0Y=;
        b=OH6REcCWtn8nG/b0uztoyUtP7F0ry1Puw5O7NoS4qy2UmbvdtK8W7ZCkAIPQskbBQ2
         4b0LCW2YEN9QqyRpfuwgwsbRMnjGOr3UteVEZpp1V9uzo82PLbHMfFr43OT4BGlk7OTV
         HZVPPlolJu3NG1SCenT7OaQ2mvaPTVAo4BpQPg/6MkMKDy8pwZNxGkB7vZ0es4BEJw/D
         b5rj5AphjNxt/AAcAtwx2nz2XSJ376aThZv/cCzjLvw3JVdx5YZ7vlQxwAPB9D0O6N2u
         xU8MXus+rt1YKuHV6A7YBNwASV3R9mlFCpX+ovEDHw4lJGoHz1XlzYmzZ54GS9puxqKT
         /Tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793383096; x=1793987896;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aTzRns4P41LTvEjZitBtZ35u3x5iyyKI3BwYPIuLk0Y=;
        b=tics+u95OrCqCdWVUilR0Y63nDt90hZUiwcc7pOu0CJBTYZU+lz7GrKWLXDPHngOka
         FYPHi2EXzpl9jzbq+N3NUYEZK8KAQw1FYz19M7l317X+JOBGSA2APRelZDq1c3Wnd8XE
         56aeAH3YdOEwO0Ar9DoGjKiwhlaZDPlyh2THGi+fOLljUBEafc4YYA7j8IVoAdvvh6Oh
         RJ91iZDVlLP2tChQ1rj8SlBPCXg6sgu4Q1wmVDVPUabf1c2/V4tJ/CZGC/BIcIhWww8G
         n+lOgljTrH6dWkXcT0tcEnMy5oYTjHtmI1kibShykaYLWZTkl24az8C759Nd++di7iJX
         OIdg==
X-Forwarded-Encrypted: i=1; AKwUvBxOEvjTdl7GlvIgB5Aa6bUQtUj/WlnySlXiJ3L+kK4t56+4IPrd1jjwYFs2bymCqsdd1lhJCLk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpduRLBNiL5hfpo+Ri+cq4oxM2pgQ8/5aeigUvKdMbbTK/1mFU
	oC3GW4ZpVoBC65d9LfP+iovOUkD9fh8hYMNoY2nbvt4/wvNVr/zdQ8xa
X-Gm-Gg: AYBFou1bPRN3C73eZ7B/TcdKIp+5EZP54EZdAj2vG0S+X6VUIYjQCVPtj2k5ayHUJB+
	+rIldbX+958kPq93GjSE4UEJmynO7iJ3kv0zWNuXGtIXsz5Sf4AMcrLnXhSoEWYqTMdNOOh7lMj
	037enJLfGN3UXdf+X3YpA38/YfWNxeOJFcOSBO/iZqEB6pb6tZToHda+VeJ2pnHDsaT6F2rPDkl
	IxkjdJVoxnc3dF7sHD4UYyAOdAMuhpQBPFxi6efyJ+MHtMydHEcPs/xmAspRXu/BskGH0NouOJM
	vFKrhPyT3lvkWBjDcMNQKtGkAvydxZU/u3/96bv/kejVkPMSzvVVYMjJDho59RLXMl+YXowC9db
	WC68/0q7f9U8ZW4JGpK6QGXdAMJrpSERyfnpTAEXdsz2z5A0VzhnfvdNT4QIOQsFGo1ryPA6lf6
	ETVztYu6i7NOrihozcn7vp05hCvnQGCPXGBqK64UwQIZKXtHQtstWd/1Pf6vrOUQ7hDDc4ponl+
	3ORd8NmUO3OtBxBgTH9GbgJuvEt5W4LzW3bPO5DqwDP9NMiTZmCI3TMVqz46TntuKcHut1HNStu
	psQVJGHPy3yBPHr8w4PAAOovSkdE7SvUW4MBDrCARmSHZXW+2loXoGNjJXjBkVlLCFUaAzGQXRv
	a7tRjnRSAye8pjNmYGnqPqlXBTZvsKC8wo5T0uRPZTBRKs7D5AISx1QlOa4nbbFd0jSbl
X-Received: by 2002:a05:6102:50a5:b0:7bb:64cc:1362 with SMTP id ada2fe7eead31-7d072c2b96amr883485137.6.1793383095802;
        Fri, 30 Oct 2026 10:58:15 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d0770b28e0sm3198299137.0.2026.10.30.10.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:58:15 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:58:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>, 
 netdev@vger.kernel.org
Cc: dsahern@kernel.org, 
 idosch@nvidia.com, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 yana06070@163.com
Message-ID: <willemdebruijn.kernel.6ba984cf38a@gmail.com>
In-Reply-To: <20261030141435.779302-1-yanxia@cmss.chinamobile.com>
References: <20261030141435.779302-1-yanxia@cmss.chinamobile.com>
Subject: Re: [PATCH net] ipv6: fix cached route reuse for SO_MARK control
 messages
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xia Yan wrote:
> A connected IPv6 UDP socket can reuse its cached route when a SO_MARK
> control message supplies a different mark. The packet then takes the
> route selected for the socket mark instead of the per-message mark.
> 
> udpv6_sendmsg() sets flowi6_mark from the control message and clears
> connected. However, ip6_sk_dst_lookup_flow() still tries the cached dst;
> connected only controls whether a newly looked-up route is stored.
> ip6_sk_dst_check() checks the addresses and output interface, but not
> the mark.
> 
> Commit 42dcfd850e51 ("udp6: allow SO_MARK ctrl msg to affect routing")
> fixed the mark used for fresh route lookups; connected sockets still
> reuse the route cached before the control message.
> 
> Reject the cached dst when flowi6_mark differs from sk_mark so that
> the packet goes through a new route lookup with the requested mark.
> 
> Found during code review of IPv6 UDP route caching. Reproduced in UML
> with a connected socket and a fwmark rule pointing to a prohibit route:
> marked sends succeeded before the fix and return EACCES after it.
> A two-interface test also confirms that marked sends use the selected
> interface and subsequent sends without a control message still use the
> socket mark. cmsg_so_mark.sh passes before and after.
> 
> Fixes: c6af0c227a22 ("ip: support SO_MARK cmsg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> 
> Tested on net 5838f10563d58afca6711edb5e4eda968ca181d9. The relevant
> send and route-cache code is unchanged at the base commit.
> 
> Full x86_64 W=1 builds completed before and after with no new
> diagnostics, using configurations based on allmodconfig and
> allyesconfig. WERROR was disabled for both; allyesconfig also had
> KASAN disabled. Both used LD_ORPHAN_WARN_LEVEL="warn" and
> DRM_WERROR=n.
> 
>  net/ipv6/ip6_output.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 25fe0ba98b1a6..843bb95e635b9 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1125,6 +1125,7 @@ static struct dst_entry *ip6_sk_dst_check(struct sock *sk,
>  	    ip6_rt_check(&rt->rt6i_src, &fl6->saddr,
>  			 np->saddr_cache ? &np->saddr : NULL) ||
>  #endif
> +	    fl6->flowi6_mark != READ_ONCE(sk->sk_mark) ||

Asides, not expectation that you fix the following:

The same is probably also true for flowlabel and dscp.

Not net material, but ideally ipv4 and ipv6 would do the exact same
thing.

>  	   (fl6->flowi6_oif && fl6->flowi6_oif != dst_dev(dst)->ifindex)) {
>  		dst_release(dst);
>  		dst = NULL;
> 
> base-commit: d8a4f4c59da52b7c31ae337243b8473a19a3f819
> -- 
> 2.39.0.windows.2
> 
> 
> 


