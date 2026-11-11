Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363847;
	b=mc//tWncJrbs84+DjZBXImfAw4L4lWZ0dPvVQjmfbb1+agcxtC6iOY+ZsZlYrEaQw9Mz
	 YU/KH3zk4PYnyI9VxUFNaL8EHmK3PnL2Sf7WBmTjiGcfY9joTUAbd8qf2rOklHNxf4lgo
	 ct62UgQ/5yV+kG6MoPcHfz5/Z1qVK/x9h1mAxfgjJkEZ3xQdniU/voNw/ub6VdG6KEgxw
	 Wr8xHBhG7CaJmr9JiM2WxYC8uJR65tAS7+qeK0Axmg9+n6zPUkXFtBEcwIMxCdPYTOvEz
	 V20NM/K4ddmvZslapRkAOvyqmQdaekZDLj3OdLdLPlwQmUKi7l1sOuV/YwOZwLJhHmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363847;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aMlrCdF6wdgpbtzH1/toupj8eIjFQGIp8QPct95wWLQ=;
	b=vEGP7Xb1SZn3nGTAbMGo3gZ64n0J1Z2+S5gwLYuvWUSyRsWD4TNoNVkqqgqZmfrJalzN
	 62e910k+C3XrtCI9oEdDYcCAx7sZ7zsnCxP4F5t7FkavaqsFWBJtRfg8ReIi/UQCRWa1P
	 xASuacwF2kX19SQUO+8Ijeace0NCwbwh/8TcMksvcmJYk22Qpz9ojloo1zckzgcYB4/SH
	 e3zUZvpa4onDEkKcekHcFZ2E9TDtdPHfXS0kKKLFPpyCCXqzqZeBmZNWWEp7HfcPXxDQr
	 4sfOffbw17miP+G1ldI2+0Ixnyxw6k0GV8+iQp8yQzm1HlsjOP4Bd9lkUUQJA2JXUGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c52fP1Mq;
	arc=none smtp.remote-ip=95.215.58.1
Received: from mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B921606A320
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 02:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B921606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c52fP1Mq
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MoQGpo4FuP4mzIUo8BoEyWZZfoeLV0yVTLAJvW0r6/o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794363844; v=1; x=1794968644;
 b=c52fP1MqBvZyF4hcFd5xyIlBgcKmrWFwQXPg9YL5M3/gI+1f7VVQyvVRE2obF+mkGC1YBMoC
 EPdE9ZijQi3e3L660cSFOg0KzAUgmP6YjRX+E5jcnnfKdKSwuzSIRPeAu9cx7j1lwtcMO9aOk0O
 OQCjSbvEsBIvTjSF8wKVE/1o=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 6f6d6ffe7c88529c;
	Wed, 11 Nov 2026 02:24:03 +0000
X-Mizu-Trace-ID: 6f6d6ffe7c88529c
X-Migadu-Flow: FLOW_OUT
Date: Wed, 11 Nov 2026 10:23:53 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH net v2 0/3] rtnetlink: fix truncation of dump entry
Message-ID: <avPRuQugknhA-HqL@fedora>
References: <20261110172925.3293312-1-stephen@networkplumber.org>
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
In-Reply-To: <20261110172925.3293312-1-stephen@networkplumber.org>

On Tue, Nov 10, 2026 at 09:26:15AM -0800, Stephen Hemminger wrote:
> While analyzing one of the OSS Scanner dump reports for iproute2,
> a bug was uncovered in netlink route dump.
> A route dump whose first entry is too large for the dump skb ends with
> NLMSG_DONE and status 0. The route and everything after it is silently
> dropped; "ip route show table 100" prints nothing and exits 0.
> 
> It takes some non real world stuff to do this 
> like a 500 way multipath route is enough to trigger this.
> 
> The series is broken into three parts:
>   1. Fix regression in rtnl_dumpit().
>      Do not hide EMSGSIZE on empty skb case.
>   2. Fix IPv6 FIB dump to propagate error properly
>   3. Add a test for this bug.
> 
> v2 - drop Assisted-by
>    - correct commit message about "ip route get"
> 
> Stephen Hemminger (3):
>   rtnetlink: return EMSGSIZE when first dump entry does not fit
>   ipv6: return EMSGSIZE when first route in dump does not fit
>   selftests: net: netlink-dumps: test dump of route larger than skb
> 
>  net/core/rtnetlink.c                        |   5 +-
>  net/ipv6/ip6_fib.c                          |   6 +
>  tools/testing/selftests/net/config          |   3 +
>  tools/testing/selftests/net/netlink-dumps.c | 271 +++++++++++++++++++-
>  4 files changed, 280 insertions(+), 5 deletions(-)
> 
> -- 
> 2.53.0
> 

For the series

Tested-by: Hangbin Liu <liuhangbin@kylinos.cn>
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
